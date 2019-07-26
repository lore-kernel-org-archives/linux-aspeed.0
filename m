From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 26 Jul 2019 15:09:51 +0930
Subject: [PATCH 09/17] ARM: dts: ibm-power9-dual: Add a unit address for OCC
 nodes
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
Message-ID: <20190726053959.2003-10-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These temporarily have a unit address until userspace is fixed up as
noted in comments elsewhere in the dtsi.

Fixes the following warning:

    arch/arm/boot/dts/ibm-power9-dual.dtsi:89.18-91.6: Warning (unit_address_vs_reg): /gpio-fsi/cfam at 0,0/sbefifo at 2400/occ: node has a reg or ranges property, but no unit name
    arch/arm/boot/dts/ibm-power9-dual.dtsi:190.18-192.6: Warning (unit_address_vs_reg): /gpio-fsi/cfam at 0,0/hub at 3400/cfam at 1,0/sbefifo at 2400/occ: node has a reg or ranges property, but no unit name

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/ibm-power9-dual.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ibm-power9-dual.dtsi b/arch/arm/boot/dts/ibm-power9-dual.dtsi
index 2abc42eda7b0..a0fa65b44b0f 100644
--- a/arch/arm/boot/dts/ibm-power9-dual.dtsi
+++ b/arch/arm/boot/dts/ibm-power9-dual.dtsi
@@ -86,7 +86,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			fsi_occ0: occ {
+			fsi_occ0: occ at 1 {
 				compatible = "ibm,p9-occ";
 			};
 		};
@@ -187,7 +187,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			fsi_occ1: occ {
+			fsi_occ1: occ at 2 {
 				compatible = "ibm,p9-occ";
 			};
 		};
-- 
2.20.1

