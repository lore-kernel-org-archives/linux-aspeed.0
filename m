From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 12 Nov 2019 15:13:07 -0800
Subject: [PATCH v2] drivers: ipmi: Support raw i2c packet in IPMB
Message-ID: <20191112231309.3094727-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Many IPMB devices doesn't support smbus protocol and current driver
support only smbus devices. Added support for raw i2c packets.

User can include ipmi_ipmb.h and set xmit type via ioctl.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 54 ++++++++++++++++++++++++++++++++
 include/uapi/linux/ipmi_ipmb.h   | 17 ++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 include/uapi/linux/ipmi_ipmb.h

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index ae3bfba27526..11f7240f62cc 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/ipmi_ipmb.h>
 
 #define MAX_MSG_LEN		128
 #define IPMB_REQUEST_LEN_MIN	7
@@ -63,6 +64,7 @@ struct ipmb_dev {
 	spinlock_t lock;
 	wait_queue_head_t wait_queue;
 	struct mutex file_mutex;
+	unsigned long xmit_type;
 };
 
 static inline struct ipmb_dev *to_ipmb_dev(struct file *file)
@@ -112,6 +114,39 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
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
@@ -133,6 +168,11 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
 	netf_rq_lun = msg[NETFN_LUN_IDX];
 
+	if (ipmb_dev->xmit_type == IPMB_XMIT_TYPE_I2C_RAW) {
+		ret = ipmb_i2c_write(ipmb_dev->client, msg);
+		return (ret == 1) ? count : ret;
+	}
+
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
 	 * i2c_smbus_xfer
@@ -166,11 +206,25 @@ static unsigned int ipmb_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+static long ipmb_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
+
+	if (cmd == IPMI_IPMB_IOCTL_SET_XMIT_TYPE)
+		ipmb_dev->xmit_type = arg;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct file_operations ipmb_fops = {
 	.owner	= THIS_MODULE,
 	.read	= ipmb_read,
 	.write	= ipmb_write,
 	.poll	= ipmb_poll,
+	.unlocked_ioctl = ipmb_ioctl,
 };
 
 /* Called with ipmb_dev->lock held. */
diff --git a/include/uapi/linux/ipmi_ipmb.h b/include/uapi/linux/ipmi_ipmb.h
new file mode 100644
index 000000000000..b283752f77f8
--- /dev/null
+++ b/include/uapi/linux/ipmi_ipmb.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Facebook
+ */
+
+#ifndef _UAPI_LINUX_IPMI_IPMB_H
+#define _UAPI_LINUX_IPMI_IPMB_H
+
+#include <linux/ioctl.h>
+
+#define __IPMI_IPMB_IOCTL_MAGIC        0xC1
+#define IPMI_IPMB_IOCTL_SET_XMIT_TYPE _IO(__IPMI_IPMB_IOCTL_MAGIC, 0x01)
+
+#define IPMB_XMIT_TYPE_SMBUS 0
+#define IPMB_XMIT_TYPE_I2C_RAW 1
+
+#endif /* _UAPI_LINUX_IPMI_IPMB_H */
-- 
2.17.1

