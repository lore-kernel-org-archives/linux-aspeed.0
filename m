From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 29 Sep 2021 04:54:08 -0700
Subject: [PATCH 6/6] ARM: dts: aspeed: Add e3c246d4i BIOS flash device
In-Reply-To: <20210929115409.21254-1-zev@bewilderbeest.net>
References: <20210929115409.21254-1-zev@bewilderbeest.net>
Message-ID: <20210929115409.21254-7-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..456f4de53869 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -68,6 +68,22 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		/*
+		 * The BIOS SPI flash is shared with the host via an
+		 * external mux, and is not accessible by the BMC by
+		 * default (hence "reserved" rather than "okay").
+		 */
+		status = "reserved";
+		label = "bios";
+		m25p,fast-read;
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.33.0

