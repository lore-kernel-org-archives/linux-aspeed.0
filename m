From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:53:11 +1030
Subject: [PATCH v3 03/20] ARM: dts: aspeed: Add LPC and child devices
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Andrew Jeffery <andrew@aj.id.au>

Ensure the ordering is correct and add all of the children in the SoC
device trees for the ast2400 and ast2500.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Fix ast2400 compatible string
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 27 +++++++++++++++++----------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4=
.dtsi
index 45d815a86d42..9422f9cb1e11 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -225,6 +225,41 @@
 				status =3D "disabled";
 			};
=20
+			lpc: lpc at 1e789000 {
+				compatible =3D "aspeed,ast2400-lpc", "simple-mfd";
+				reg =3D <0x1e789000 0x1000>;
+
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				ranges =3D <0x0 0x1e789000 0x1000>;
+
+				lpc_bmc: lpc-bmc at 0 {
+					compatible =3D "aspeed,ast2400-lpc-bmc";
+					reg =3D <0x0 0x80>;
+				};
+
+				lpc_host: lpc-host at 80 {
+					compatible =3D "aspeed,ast2400-lpc-host", "simple-mfd", "syscon";
+					reg =3D <0x80 0x1e0>;
+					reg-io-width =3D <4>;
+
+					#address-cells =3D <1>;
+					#size-cells =3D <1>;
+					ranges =3D <0x0 0x80 0x1e0>;
+
+					lpc_ctrl: lpc-ctrl at 0 {
+						compatible =3D "aspeed,ast2400-lpc-ctrl";
+						reg =3D <0x0 0x80>;
+						status =3D "disabled";
+					};
+
+					lhc: lhc at 20 {
+						compatible =3D "aspeed,ast2400-lhc";
+						reg =3D <0x20 0x24 0x48 0x8>;
+					};
+				};
+			};
+
 			uart2: serial at 1e78d000 {
 				compatible =3D "ns16550a";
 				reg =3D <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5=
.dtsi
index 5c4ecdba3a6b..069f13df19d1 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -265,6 +265,16 @@
 				status =3D "disabled";
 			};
=20
+			vuart: serial at 1e787000 {
+				compatible =3D "aspeed,ast2500-vuart";
+				reg =3D <0x1e787000 0x40>;
+				reg-shift =3D <2>;
+				interrupts =3D <10>;
+				clocks =3D <&clk_uart>;
+				no-loopback-test;
+				status =3D "disabled";
+			};
+
 			lpc: lpc at 1e789000 {
 				compatible =3D "aspeed,ast2500-lpc", "simple-mfd";
 				reg =3D <0x1e789000 0x1000>;
@@ -288,6 +298,13 @@
=20
 					reg-io-width =3D <4>;
=20
+					lpc_ctrl: lpc-ctrl at 0 {
+						compatible =3D "aspeed,ast2500-lpc-ctrl";
+						reg =3D <0x0 0x80>;
+						status =3D "disabled";
+					};
+
+
 					lhc: lhc at 20 {
 						compatible =3D "aspeed,ast2500-lhc";
 						reg =3D <0x20 0x24 0x48 0x8>;
@@ -295,16 +312,6 @@
 				};
 			};
=20
-			vuart: serial at 1e787000 {
-				compatible =3D "aspeed,ast2500-vuart";
-				reg =3D <0x1e787000 0x40>;
-				reg-shift =3D <2>;
-				interrupts =3D <10>;
-				clocks =3D <&clk_uart>;
-				no-loopback-test;
-				status =3D "disabled";
-			};
-
 			uart2: serial at 1e78d000 {
 				compatible =3D "ns16550a";
 				reg =3D <0x1e78d000 0x20>;
--=20
2.15.1

