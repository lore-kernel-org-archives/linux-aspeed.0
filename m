From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Aug 2021 16:22:02 +0930
Subject: [PATCH 3/4] ARM: config: aspeed_g4: Enable EDAC and SPGIO
In-Reply-To: <20210819065203.2620911-1-joel@jms.id.au>
References: <20210819065203.2620911-1-joel@jms.id.au>
Message-ID: <20210819065203.2620911-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These two devices are part of the AST2400 and the drivers have support
for that version of the soc.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g4_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 397c57e94743..a578865c2d96 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -141,6 +141,7 @@ CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_ASPEED=y
+CONFIG_GPIO_ASPEED_SGPIO=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_GPIO=y
 CONFIG_W1_SLAVE_THERM=y
@@ -205,6 +206,7 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_EDAC=y
+CONFIG_EDAC_ASPEED=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_PCF8523=y
-- 
2.32.0

