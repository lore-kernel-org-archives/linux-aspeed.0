From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:09 +0800
Subject: [PATCH 03/10] dts: aspeed: ast2600: Support SDR50 for SD device
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20210922103116.30652-4-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The maximum frequency for SD controller on AST2600 EVB is
100MHz. In order to achieve 100MHz, sd-uhs-sdr50 property
should be added and the driver will set the SDR50 supported
bit in capability 2 register during probing stage.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..4551dba499c2 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -280,6 +280,7 @@
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	sdhci-drive-type = /bits/ 8 <3>;
 	sdhci-caps-mask = <0x7 0x0>;
@@ -292,6 +293,7 @@
 &sdhci1 {
 	status = "okay";
 	bus-width = <4>;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	sdhci-drive-type = /bits/ 8 <3>;
 	sdhci-caps-mask = <0x7 0x0>;
-- 
2.17.1

