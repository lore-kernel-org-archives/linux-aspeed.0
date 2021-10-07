From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  6 Oct 2021 17:09:54 -0700
Subject: [PATCH 9/9] ARM: dts: aspeed: Add e3c246d4i BIOS flash device
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
Message-ID: <20211007000954.30621-10-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This uses a dynamic DT node because the BIOS SPI flash requires
significant coordination with the host system (power state tracking,
GPIOs, IPMI messages) before the BMC can touch it, and needs to be
relinquished back to the host when the BMC is done accessing it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..428198703824 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -68,6 +68,29 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	/*
+	 * The BIOS SPI flash is shared with the host via an external mux, and
+	 * is not accessible by the BMC by default (hence reserved/dynamic
+	 * here rather than okay).  This would ideally be done on the flash at 0
+	 * node instead of the spi1 controller, but the driver infrastructure
+	 * to support dynamic devices at that level of the device tree isn't
+	 * currently in place, and it's the only flash chip on this
+	 * controller, so we can get away with the coarser granularity here
+	 * until support for making individual flash chips dynamic is
+	 * available.
+	 */
+	status = "reserved";
+	dynamic;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
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

