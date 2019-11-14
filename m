From: Asmaa Mnebhi <Asmaa@mellanox.com>
Date: Thu, 14 Nov 2019 14:16:38 +0000
Subject: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
In-Reply-To: <20191113234133.3790374-1-vijaykhemka@fb.com>
References: <20191113234133.3790374-1-vijaykhemka@fb.com>
Message-ID: <DB6PR0501MB2712658DD269E4B22A327A2DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

You haven't addressed some of my comments.

-----Original Message-----
From: Vijay Khemka <vijaykhemka@fb.com> 
Sent: Wednesday, November 13, 2019 6:42 PM
To: Corey Minyard <minyard@acm.org>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; openipmi-developer at lists.sourceforge.net; linux-kernel at vger.kernel.org
Cc: vijaykhemka at fb.com; cminyard at mvista.com; Asmaa Mnebhi <Asmaa@mellanox.com>; joel at jms.id.au; linux-aspeed at lists.ozlabs.org; sdasari at fb.com
Subject: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB

Many IPMB devices doesn't support smbus protocol and current driver support only smbus devices. Added support for raw i2c packets.

User can define i2c-protocol in device tree to use i2c raw transfer.

A>> Please fix the description as suggested in previous comments

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index ae3bfba27526..10904bec1de0 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -63,6 +63,7 @@ struct ipmb_dev {
 	spinlock_t lock;
 	wait_queue_head_t wait_queue;
 	struct mutex file_mutex;
+	bool is_i2c_protocol;
 };
 
 static inline struct ipmb_dev *to_ipmb_dev(struct file *file) @@ -112,6 +113,25 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
 	return ret < 0 ? ret : count;
 }
 
+static int ipmb_i2c_write(struct i2c_client *client, u8 *msg) {
+	struct i2c_msg i2c_msg;
+
+	/*
+	 * subtract 1 byte (rq_sa) from the length of the msg passed to
+	 * raw i2c_transfer
+	 */
+	i2c_msg.len = msg[IPMB_MSG_LEN_IDX] - 1;
+
+	/* Assign message to buffer except first 2 bytes (length and address) */
+	i2c_msg.buf = msg + 2;
+
+	i2c_msg.addr = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);

You can have:
i2c_msg.flags = addr;
addr being an argument of the ipmb_i2c_write function and passed in ipmb_write. We already define it.

+	i2c_msg.flags = client->flags & I2C_CLIENT_PEC;
+
+	return i2c_transfer(client->adapter, &i2c_msg, 1); }
+
 static ssize_t ipmb_write(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
@@ -133,6 +153,12 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
 	netf_rq_lun = msg[NETFN_LUN_IDX];
 
+	/* Check i2c block transfer vs smbus */
+	if (ipmb_dev->is_i2c_protocol) {
+		ret = ipmb_i2c_write(ipmb_dev->client, msg);
+		return (ret == 1) ? count : ret;
+	}
+
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
 	 * i2c_smbus_xfer
@@ -277,6 +303,7 @@ static int ipmb_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ipmb_dev *ipmb_dev;
+	struct device_node *np;
 	int ret;
 
 	ipmb_dev = devm_kzalloc(&client->dev, sizeof(*ipmb_dev), @@ -302,6 +329,11 @@ static int ipmb_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	/* Check if i2c block xmit needs to use instead of smbus */
+	np = client->dev.of_node;
+	if (np && of_get_property(np, "i2c-protocol", NULL))
+		ipmb_dev->is_i2c_protocol = true;

I know Corey said that ACPI is not a priority but many companies (including mine) use ACPI and I would prefer if we implement it. All you need to do is use
device_property_read_u32 function instead of of_get_property:
ret = device_property_read_u32(&client->dev, "i2c-protocol", &ipmb_dev->is_i2c_protocol);
This function does the job for both dt and acpi.

+
 	ipmb_dev->client = client;
 	i2c_set_clientdata(client, ipmb_dev);
 	ret = i2c_slave_register(client, ipmb_slave_cb);
--
2.17.1

