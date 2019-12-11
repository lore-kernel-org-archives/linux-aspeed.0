From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 11 Dec 2019 11:01:55 -0800
Subject: [PATCH] drivers: ipmi: Modify max length of IPMB packet
Message-ID: <20191211190155.1279610-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As per IPMB specification, maximum packet size supported is 255,
modified Max length to 240 from 128 to accommodate more data.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 68a254c0dd92..382e4a1df510 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -19,7 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 
-#define MAX_MSG_LEN		128
+#define MAX_MSG_LEN		240
 #define IPMB_REQUEST_LEN_MIN	7
 #define NETFN_RSP_BIT_MASK	0x4
 #define REQUEST_QUEUE_MAX_LEN	256
-- 
2.17.1

