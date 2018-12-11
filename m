From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 11 Dec 2018 14:12:40 -0600
Subject: [PATCH 1/2] clk: aspeed: Add video engine reset index definition
In-Reply-To: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
References: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1544559161-21468-2-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an index into the array of resets kept in the Aspeed clock driver
for the video engine. This isn't a HW bit definition.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/aspeed-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index f437386..15a9059 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -50,5 +50,6 @@
 #define ASPEED_RESET_I2C		7
 #define ASPEED_RESET_AHB		8
 #define ASPEED_RESET_CRT1		9
+#define ASPEED_RESET_VIDEO		10
 
 #endif
-- 
1.8.3.1

