From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Jul 2019 13:07:26 +0930
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Enable first MMC slot on AST2500 EVB
In-Reply-To: <20190712033726.25237-1-andrew@aj.id.au>
References: <20190712033726.25237-1-andrew@aj.id.au>
Message-ID: <20190712033726.25237-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enabled for testing purposes.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Leave sdhci1 disabled

 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 556ed469830c..5279b1040c37 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -94,6 +94,17 @@
 	};
 };
 
+&sdc {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd1_default>;
+};
+
 /*
  * Enable port A as device (via the virtual hub) and port B as
  * host by default on the eval board. This can be easily changed
-- 
2.20.1

