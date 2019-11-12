From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 11 Nov 2019 18:36:10 -0800
Subject: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
In-Reply-To: <20191112023610.3644314-1-vijaykhemka@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
Message-ID: <20191112023610.3644314-2-vijaykhemka@fb.com>
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
index 2419b9a928b2..7f9198bbce96 100644
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

