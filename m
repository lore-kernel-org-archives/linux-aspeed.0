From: Benjamin Fair <benjaminfair@google.com>
Date: Fri,  6 Jul 2018 11:25:32 -0700
Subject: [PATCH] drivers/misc: Aspeed LPC snoop output using misc chardev
Message-ID: <20180706182531.137362-1-benjaminfair@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Robert Lippert <rlippert@google.com>

Provides the data bytes snooped over the LPC snoop bus to userspace
as a (blocking) misc character device.

Bytes output from the host using LPC I/O transactions to the snooped port
can be watched or retrieved from the character device using a simple
command like this:
~#  od -w1 -A n -t x1 /dev/aspeed-lpc-snoop0
 10
 de
 ad
 c0
 ff
 ee

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
Signed-off-by: Benjamin Fair <benjaminfair@google.com>
---
 drivers/misc/aspeed-lpc-snoop.c | 84 +++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/misc/aspeed-lpc-snoop.c
index cb78c98bc78d..2feb4347d67f 100644
--- a/drivers/misc/aspeed-lpc-snoop.c
+++ b/drivers/misc/aspeed-lpc-snoop.c
@@ -16,12 +16,15 @@
 
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
+#include <linux/fs.h>
 #include <linux/kfifo.h>
 #include <linux/mfd/syscon.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/poll.h>
 #include <linux/regmap.h>
 
 #define DEVICE_NAME	"aspeed-lpc-snoop"
@@ -59,20 +62,70 @@ struct aspeed_lpc_snoop_model_data {
 	unsigned int has_hicrb_ensnp;
 };
 
+struct aspeed_lpc_snoop_channel {
+	struct kfifo		fifo;
+	wait_queue_head_t	wq;
+	struct miscdevice	miscdev;
+};
+
 struct aspeed_lpc_snoop {
 	struct regmap		*regmap;
 	int			irq;
-	struct kfifo		snoop_fifo[NUM_SNOOP_CHANNELS];
+	struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];
+};
+
+static struct aspeed_lpc_snoop_channel *snoop_file_to_chan(struct file *file)
+{
+	return container_of(file->private_data,
+			    struct aspeed_lpc_snoop_channel,
+			    miscdev);
+}
+
+static ssize_t snoop_file_read(struct file *file, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
+	unsigned int copied;
+	int ret = 0;
+
+	if (kfifo_is_empty(&chan->fifo)) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		ret = wait_event_interruptible(chan->wq,
+				!kfifo_is_empty(&chan->fifo));
+		if (ret == -ERESTARTSYS)
+			return -EINTR;
+	}
+	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+
+	return ret ? ret : copied;
+}
+
+static unsigned int snoop_file_poll(struct file *file,
+				    struct poll_table_struct *pt)
+{
+	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
+
+	poll_wait(file, &chan->wq, pt);
+	return !kfifo_is_empty(&chan->fifo) ? POLLIN : 0;
+}
+
+static const struct file_operations snoop_fops = {
+	.owner  = THIS_MODULE,
+	.read   = snoop_file_read,
+	.poll   = snoop_file_poll,
+	.llseek = noop_llseek,
 };
 
 /* Save a byte to a FIFO and discard the oldest byte if FIFO is full */
-static void put_fifo_with_discard(struct kfifo *fifo, u8 val)
+static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
-	if (!kfifo_initialized(fifo))
+	if (!kfifo_initialized(&chan->fifo))
 		return;
-	if (kfifo_is_full(fifo))
-		kfifo_skip(fifo);
-	kfifo_put(fifo, val);
+	if (kfifo_is_full(&chan->fifo))
+		kfifo_skip(&chan->fifo);
+	kfifo_put(&chan->fifo, val);
+	wake_up_interruptible(&chan->wq);
 }
 
 static irqreturn_t aspeed_lpc_snoop_irq(int irq, void *arg)
@@ -97,12 +150,12 @@ static irqreturn_t aspeed_lpc_snoop_irq(int irq, void *arg)
 	if (reg & HICR6_STR_SNP0W) {
 		u8 val = (data & SNPWDR_CH0_MASK) >> SNPWDR_CH0_SHIFT;
 
-		put_fifo_with_discard(&lpc_snoop->snoop_fifo[0], val);
+		put_fifo_with_discard(&lpc_snoop->chan[0], val);
 	}
 	if (reg & HICR6_STR_SNP1W) {
 		u8 val = (data & SNPWDR_CH1_MASK) >> SNPWDR_CH1_SHIFT;
 
-		put_fifo_with_discard(&lpc_snoop->snoop_fifo[1], val);
+		put_fifo_with_discard(&lpc_snoop->chan[1], val);
 	}
 
 	return IRQ_HANDLED;
@@ -139,12 +192,22 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	const struct aspeed_lpc_snoop_model_data *model_data =
 		of_device_get_match_data(dev);
 
+	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
 	/* Create FIFO datastructure */
-	rc = kfifo_alloc(&lpc_snoop->snoop_fifo[channel],
+	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
 			 SNOOP_FIFO_SIZE, GFP_KERNEL);
 	if (rc)
 		return rc;
 
+	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
+	lpc_snoop->chan[channel].miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
+	lpc_snoop->chan[channel].miscdev.parent = dev;
+	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
+	if (rc)
+		return rc;
+
 	/* Enable LPC snoop channel at requested port */
 	switch (channel) {
 	case 0:
@@ -191,7 +254,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	kfifo_free(&lpc_snoop->snoop_fifo[channel]);
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
+	misc_deregister(&lpc_snoop->chan[channel].miscdev);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
-- 
2.18.0.203.gfac676dfb9-goog

