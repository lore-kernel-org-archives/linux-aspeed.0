From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jun 2018 09:25:58 +1000
Subject: [PATCH 07/14] fsi: master-gpio: Remove unused definitions
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Message-ID: <20180626232605.13420-8-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index a00a85aa6d56..2bc85514bb0c 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -25,9 +25,6 @@
 #define	FSI_INIT_CLOCKS		5000	/* Clock out any old data */
 #define	FSI_GPIO_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
 #define	FSI_GPIO_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
-#define	FSI_GPIO_STD_DELAY	10	/* Standard GPIO delay in nS */
-					/* todo: adjust down as low as */
-					/* possible or eliminate */
 #define FSI_CRC_ERR_RETRIES	10
 
 #define	FSI_GPIO_CMD_DPOLL      0x2
@@ -45,10 +42,7 @@
 
 #define	FSI_GPIO_MAX_BUSY	200
 #define	FSI_GPIO_MTOE_COUNT	1000
-#define	FSI_GPIO_DRAIN_BITS	20
 #define	FSI_GPIO_CRC_SIZE	4
-#define	FSI_GPIO_MSG_ID_SIZE		2
-#define	FSI_GPIO_MSG_RESPID_SIZE	2
 
 #define LAST_ADDR_INVALID		0x1
 
-- 
2.17.1

