From: Joel Stanley <joel@jms.id.au>
Date: Mon,  7 Jun 2021 12:42:55 +0930
Subject: [PATCH 2/6] ARM: dts: aspeed: everest: Add nvme and fan indicator leds
In-Reply-To: <20210607031259.475020-1-joel@jms.id.au>
References: <20210607031259.475020-1-joel@jms.id.au>
Message-ID: <20210607031259.475020-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These are the indicator leds for nvme slots and fans and are
driven by PCA9552.

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 132 +++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 6a17b75b5d5b..03c26812c909 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -970,6 +970,138 @@ fan at 3 {
 				};
 			};
 
+			pca_fan_nvme: pca9552 at 60 {
+				compatible = "nxp,pca9552";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "nvme0";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "nvme1";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 2 {
+					label = "nvme2";
+					reg = <2>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 3 {
+					label = "nvme3";
+					reg = <3>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 4 {
+					label = "nvme4";
+					reg = <4>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 5 {
+					label = "nvme5";
+					reg = <5>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 6 {
+					label = "nvme6";
+					reg = <6>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 7 {
+					label = "nvme7";
+					reg = <7>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 8 {
+					label = "nvme8";
+					reg = <8>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 9 {
+					label = "nvme9";
+					reg = <9>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 10 {
+					label = "fan0";
+					reg = <10>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 11 {
+					label = "fan1";
+					reg = <11>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 12 {
+					label = "fan2";
+					reg = <12>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 13 {
+					label = "fan3";
+					reg = <13>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 14 {
+					reg = <14>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 15 {
+					reg = <15>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
+
 			pca0: pca9552 at 61 {
 				compatible = "nxp,pca9552";
 				#address-cells = <1>;
-- 
2.30.2

