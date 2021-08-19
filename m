From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Aug 2021 16:22:01 +0930
Subject: [PATCH 2/4] ARM: config: aspeed: Enable KCS adapter for raw SerIO
In-Reply-To: <20210819065203.2620911-1-joel@jms.id.au>
References: <20210819065203.2620911-1-joel@jms.id.au>
Message-ID: <20210819065203.2620911-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Raw SerIO is used by the OpenBMC debug-trigger application to take
signals from the host that applications are unresponsive on the BMC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g5_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 3f81146a9c0e..6ba30b212bda 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -130,7 +130,7 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_IBM_PANEL=y
-# CONFIG_SERIO is not set
+CONFIG_SERIO_RAW=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
@@ -144,6 +144,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_ASPEED_KCS_IPMI_BMC=y
+CONFIG_IPMI_KCS_BMC_SERIO=y
 CONFIG_ASPEED_BT_IPMI_BMC=y
 CONFIG_HW_RANDOM_TIMERIOMEM=y
 # CONFIG_I2C_COMPAT is not set
-- 
2.32.0

