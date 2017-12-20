From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:53:15 +1030
Subject: [PATCH v3 07/20] ARM: dts: aspeed: Add flash controller clocks
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-8-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
 arch/arm/boot/dts/aspeed-g5.dtsi | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4=
.dtsi
index 2b1bb31ce390..36cb66d8cc10 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -55,6 +55,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			compatible =3D "aspeed,ast2400-fmc";
+			clocks =3D <&syscon ASPEED_CLK_AHB>;
 			status =3D "disabled";
 			interrupts =3D <19>;
 			flash at 0 {
@@ -70,6 +71,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			compatible =3D "aspeed,ast2400-spi";
+			clocks =3D <&syscon ASPEED_CLK_AHB>;
 			status =3D "disabled";
 			flash at 0 {
 				reg =3D < 0 >;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5=
.dtsi
index 95bb04e4cee2..156b345ff20d 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -55,6 +55,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			compatible =3D "aspeed,ast2500-fmc";
+			clocks =3D <&syscon ASPEED_CLK_AHB>;
 			status =3D "disabled";
 			interrupts =3D <19>;
 			flash at 0 {
@@ -80,6 +81,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			compatible =3D "aspeed,ast2500-spi";
+			clocks =3D <&syscon ASPEED_CLK_AHB>;
 			status =3D "disabled";
 			flash at 0 {
 				reg =3D < 0 >;
@@ -99,6 +101,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			compatible =3D "aspeed,ast2500-spi";
+			clocks =3D <&syscon ASPEED_CLK_AHB>;
 			status =3D "disabled";
 			flash at 0 {
 				reg =3D < 0 >;
--=20
2.15.1

