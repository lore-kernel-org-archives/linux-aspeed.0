From: ryan_chen <ryan_chen@aspeedtech.com>
Date: Tue, 3 Jan 2023 17:37:02 +0800
Subject: [PATCH 2/2] dtsi:aspeed: add miss pinctrl in pinctrl dtsi
In-Reply-To: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
References: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
Message-ID: <20230103093702.2613574-3-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

add miss pcie rc, secure i2c, i3c, 8bit emmc, uart ncts..

Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 216 +++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
index 7cd4f075e325..d04399b35e39 100644
--- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
@@ -2,6 +2,16 @@
 // Copyright 2019 IBM Corp.
 
 &pinctrl {
+	pinctrl_pcierc0_default: pcierc0_default {
+		function = "PCIERC0";
+		groups = "PCIERC0";
+	};
+
+	pinctrl_pcierc1_default: pcierc1_default {
+		function = "PCIERC1";
+		groups = "PCIERC1";
+	};
+
 	pinctrl_adc0_default: adc0_default {
 		function = "ADC0";
 		groups = "ADC0";
@@ -297,6 +307,66 @@ pinctrl_i2c9_default: i2c9_default {
 		groups = "I2C9";
 	};
 
+	pinctrl_si2c1_default: si2c1_default {
+		function = "SI2C1";
+		groups = "SI2C1";
+	};
+
+	pinctrl_si2c2_default: si2c2_default {
+		function = "SI2C2";
+		groups = "SI2C2";
+	};
+
+	pinctrl_si2c3_default: si2c3_default {
+		function = "SI2C3";
+		groups = "SI2C3";
+	};
+
+	pinctrl_si2c4_default: si2c4_default {
+		function = "SI2C4";
+		groups = "SI2C4";
+	};
+
+	pinctrl_si2c5_default: si2c5_default {
+		function = "SI2C5";
+		groups = "SI2C5";
+	};
+
+	pinctrl_si2c6_default: si2c6_default {
+		function = "SI2C6";
+		groups = "SI2C6";
+	};
+
+	pinctrl_si2c7_default: si2c7_default {
+		function = "SI2C7";
+		groups = "SI2C7";
+	};
+
+	pinctrl_si2c8_default: si2c8_default {
+		function = "SI2C8";
+		groups = "SI2C8";
+	};
+
+	pinctrl_si2c9_default: si2c9_default {
+		function = "SI2C9";
+		groups = "SI2C9";
+	};
+
+	pinctrl_si2c10_default: si2c10_default {
+		function = "SI2C10";
+		groups = "SI2C10";
+	};
+
+	pinctrl_i3c1_default: i3c1_default {
+		function = "I3C1";
+		groups = "I3C1";
+	};
+
+	pinctrl_i3c2_default: i3c2_default {
+		function = "I3C2";
+		groups = "I3C2";
+	};
+
 	pinctrl_i3c3_default: i3c3_default {
 		function = "I3C3";
 		groups = "I3C3";
@@ -857,6 +927,11 @@ pinctrl_emmc_default: emmc_default {
 		groups = "EMMCG4";
 	};
 
+	pinctrl_emmcg8_default: emmcg8_default {
+		function = "EMMC";
+		groups = "EMMCG8";
+	};
+
 	pinctrl_sgpm1_default: sgpm1_default {
 		function = "SGPM1";
 		groups = "SGPM1";
@@ -952,6 +1027,11 @@ pinctrl_spi2cs2_default: spi2cs2_default {
 		groups = "SPI2CS2";
 	};
 
+	pinctrl_ssprstroot_default: ssprstroot_default {
+		function = "SSPRSTROOT";
+		groups = "SSPRSTROOT";
+	};
+
 	pinctrl_tach0_default: tach0_default {
 		function = "TACH0";
 		groups = "TACH0";
@@ -1142,6 +1222,16 @@ pinctrl_usb2bd_default: usb2bd_default {
 		groups = "USBB";
 	};
 
+	pinctrl_usb2adp_default: usb2adp_default {
+		function = "USB2ADP";
+		groups = "USBA";
+	};
+
+	pinctrl_usb2ahp_default: usb2ahp_default {
+		function = "USB2AHP";
+		groups = "USBA";
+	};
+
 	pinctrl_usb11bhid_default: usb11bhid_default {
 		function = "USB11BHID";
 		groups = "USBB";
@@ -1181,4 +1271,130 @@ pinctrl_wdtrst4_default: wdtrst4_default {
 		function = "WDTRST4";
 		groups = "WDTRST4";
 	};
+
+	pinctrl_ncts1_default: ncts1_default {
+		function = "NCTS1";
+		groups = "NCTS1";
+	};
+
+	pinctrl_ncts2_default: ncts2_default {
+		function = "NCTS2";
+		groups = "NCTS2";
+	};
+
+	pinctrl_ncts3_default: ncts3_default {
+		function = "NCTS3";
+		groups = "NCTS3";
+	};
+
+	pinctrl_ncts4_default: ncts4_default {
+		function = "NCTS4";
+		groups = "NCTS4";
+	};
+
+	pinctrl_ndcd1_default: ndcd1_default {
+		function = "NDCD1";
+		groups = "NDCD1";
+	};
+
+	pinctrl_ndcd2_default: ndcd2_default {
+		function = "NDCD2";
+		groups = "NDCD2";
+	};
+
+	pinctrl_ndcd3_default: ndcd3_default {
+		function = "NDCD3";
+		groups = "NDCD3";
+	};
+
+	pinctrl_ndcd4_default: ndcd4_default {
+		function = "NDCD4";
+		groups = "NDCD4";
+	};
+
+	pinctrl_ndsr1_default: ndsr1_default {
+		function = "NDSR1";
+		groups = "NDSR1";
+	};
+
+	pinctrl_ndsr2_default: ndsr2_default {
+		function = "NDSR2";
+		groups = "NDSR2";
+	};
+
+	pinctrl_ndsr3_default: ndsr3_default {
+		function = "NDSR3";
+		groups = "NDSR3";
+	};
+
+	pinctrl_ndsr4_default: ndsr4_default {
+		function = "NDSR4";
+		groups = "NDSR4";
+	};
+
+	pinctrl_nri1_default: nri1_default {
+		function = "NRI1";
+		groups = "NRI1";
+	};
+
+	pinctrl_nri2_default: nri2_default {
+		function = "NRI2";
+		groups = "NRI2";
+	};
+
+	pinctrl_nri3_default: nri3_default {
+		function = "NRI3";
+		groups = "NRI3";
+	};
+
+	pinctrl_nri4_default: nri4_default {
+		function = "NRI4";
+		groups = "NRI4";
+	};
+
+	pinctrl_ndtr1_default: ndtr1_default {
+		function = "NDTR1";
+		groups = "NDTR1";
+	};
+
+	pinctrl_ndtr2_default: ndtr2_default {
+		function = "NDTR2";
+		groups = "NDTR2";
+	};
+
+	pinctrl_ndtr3_default: ndtr3_default {
+		function = "NDTR3";
+		groups = "NDTR3";
+	};
+
+	pinctrl_ndtr4_default: ndtr4_default {
+		function = "NDTR4";
+		groups = "NDTR4";
+	};
+
+	pinctrl_nrts1_default: nrts1_default {
+		function = "NRTS1";
+		groups = "NRTS1";
+	};
+
+	pinctrl_nrts2_default: nrts2_default {
+		function = "NRTS2";
+		groups = "NRTS2";
+	};
+
+	pinctrl_nrts3_default: nrts3_default {
+		function = "NRTS3";
+		groups = "NRTS3";
+	};
+
+	pinctrl_nrts4_default: nrts4_default {
+		function = "NRTS4";
+		groups = "NRTS4";
+	};
+
+	pinctrl_fwspi18_default: fwspi18_default {
+		function = "FWSPI18";
+		groups = "FWSPI18";
+	};
+
 };
-- 
2.34.1

