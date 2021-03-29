From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:15 -0500
Subject: [PATCH 17/22] ARM: dts: aspeed: everest: Add UCD90320 power sequencer
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-18-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jim Wright <jlwright@us.ibm.com>

Add UCD90320 chip to Everest device tree.

Signed-off-by: Jim Wright <jlwright@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 04c96a3fe506..9e77bbb3e4d1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -406,6 +406,11 @@ &i2c7 {
 &i2c8 {
 	status = "okay";
 
+	ucd90320 at 11 {
+		compatible = "ti,ucd90320";
+		reg = <0x11>;
+	};
+
 	eeprom at 51 {
 		compatible = "atmel,24c64";
 		reg = <0x51>;
-- 
2.27.0

