From: Guenter Roeck <linux@roeck-us.net>
Date: Sun,  2 Feb 2020 08:39:39 -0800
Subject: [PATCH] ARM: dts: aspeed: tacoma: Enable eMMC controller
Message-ID: <20200202163939.13326-1-linux@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enabling emmc without enabling its controller doesn't do any good.
Enable its controller as well to make it work.

Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index ff49ec76fa7c..47293a5e0c59 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -132,6 +132,10 @@
 	use-ncsi;
 };
 
+&emmc_controller {
+	status = "okay";
+};
+
 &emmc {
 	status = "okay";
 };
-- 
2.17.1

