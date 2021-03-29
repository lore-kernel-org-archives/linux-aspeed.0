From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:17 -0500
Subject: [PATCH 19/22] ARM: dts: Aspeed: Everest: Add RTC
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-20-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the RTC at the appropriate I2C bus and address.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 18a3d65fb67d..f33c22f824cd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -708,6 +708,11 @@ ucd90320 at 11 {
 		reg = <0x11>;
 	};
 
+	rtc at 32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+
 	eeprom at 51 {
 		compatible = "atmel,24c64";
 		reg = <0x51>;
-- 
2.27.0

