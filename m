From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jun 2018 09:25:55 +1000
Subject: [PATCH 04/14] fsi: master-gpio: Rename and adjust send delay
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Message-ID: <20180626232605.13420-5-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

What the driver called "FSI_GPIO_PRIME_SLAVE_CLOCKS" is what
the FSI spec calls tSendDelay and should be 16 clocks by
default.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 1fd8b417939d..836587701ceb 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -18,6 +18,7 @@
 
 #define	FSI_GPIO_STD_DLY	1	/* Standard pin delay in nS */
 #define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
+#define	FSI_SEND_DELAY_CLOCKS	16	/* Number clocks for send delay */
 #define	FSI_PRE_BREAK_CLOCKS	50	/* Number clocks to prep for break */
 #define	FSI_BREAK_CLOCKS	256	/* Number of clocks to issue break */
 #define	FSI_POST_BREAK_CLOCKS	16000	/* Number clocks to set up cfam */
@@ -48,7 +49,6 @@
 #define	FSI_GPIO_CRC_SIZE	4
 #define	FSI_GPIO_MSG_ID_SIZE		2
 #define	FSI_GPIO_MSG_RESPID_SIZE	2
-#define	FSI_GPIO_PRIME_SLAVE_CLOCKS	20
 
 #define LAST_ADDR_INVALID		0x1
 
@@ -535,9 +535,12 @@ static int poll_for_response(struct fsi_master_gpio *master,
 	if (busy_count > 0)
 		trace_fsi_master_gpio_poll_response_busy(master, busy_count);
  fail:
-	/* Clock the slave enough to be ready for next operation */
+	/*
+	 * tSendDelay clocks, avoids signal reflections when switching
+	 * from receive of response back to send of data.
+	 */
 	local_irq_save(flags);
-	clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
+	clock_zeros(master, FSI_SEND_DELAY_CLOCKS);
 	local_irq_restore(flags);
 
 	return rc;
-- 
2.17.1

