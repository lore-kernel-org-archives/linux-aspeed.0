From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 13 Nov 2019 11:23:25 -0800
Subject: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Message-ID: <20191113192325.2821207-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Many IPMB devices doesn't support smbus protocol and current driver
support only smbus devices. Added support for raw i2c packets.

User can define use-i2c-block in device tree to use i2c raw transfer.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index ae3bfba27526..16d5d4b636a9 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -63,6 +63,7 @@ struct ipmb_dev {
 	spinlock_t lock;
 	wait_queue_head_t wait_queue;
 	struct mutex file_mutex;
+	bool use_i2c;
 };
 
 static inline struct ipmb_dev *to_ipmb_dev(struct file *file)
@@ -112,6 +113,39 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
 	return ret < 0 ? ret : count;
 }
 
+static int ipmb_i2c_write(struct i2c_client *client, u8 *msg)
+{
+	unsigned char *i2c_buf;
+	struct i2c_msg i2c_msg;
+	ssize_t ret;
+	u8 msg_len;
+
+	/*
+	 * subtract 1 byte (rq_sa) from the length of the msg passed to
+	 * raw i2c_transfer
+	 */
+	msg_len = msg[IPMB_MSG_LEN_IDX] - 1;
+
+	i2c_buf = kzalloc(msg_len, GFP_KERNEL);
+	if (!i2c_buf)
+		return -EFAULT;
+
+	/* Copy message to buffer except first 2 bytes (length and address) */
+	memcpy(i2c_buf, msg+2, msg_len);
+
+	i2c_msg.addr = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
+	i2c_msg.flags = client->flags &
+			(I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB);
+	i2c_msg.len = msg_len;
+	i2c_msg.buf = i2c_buf;
+
+	ret = i2c_transfer(client->adapter, &i2c_msg, 1);
+	kfree(i2c_buf);
+
+	return ret;
+
+}
+
 static ssize_t ipmb_write(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
@@ -133,6 +167,12 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
 	netf_rq_lun = msg[NETFN_LUN_IDX];
 
+	/* Check i2c block transfer vs smbus */
+	if (ipmb_dev->use_i2c) {
+		ret = ipmb_i2c_write(ipmb_dev->client, msg);
+		return (ret == 1) ? count : ret;
+	}
+
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
 	 * i2c_smbus_xfer
@@ -277,6 +317,7 @@ static int ipmb_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ipmb_dev *ipmb_dev;
+	struct device_node *np;
 	int ret;
 
 	ipmb_dev = devm_kzalloc(&client->dev, sizeof(*ipmb_dev),
@@ -302,6 +343,13 @@ static int ipmb_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	/* Check if i2c block xmit needs to use instead of smbus */
+	np = client->dev.of_node;
+	if (np && of_get_property(np, "use-i2c-block", NULL))
+		ipmb_dev->use_i2c = true;
+	else
+		ipmb_dev->use_i2c = false;
+
 	ipmb_dev->client = client;
 	i2c_set_clientdata(client, ipmb_dev);
 	ret = i2c_slave_register(client, ipmb_slave_cb);
-- 
2.17.1

