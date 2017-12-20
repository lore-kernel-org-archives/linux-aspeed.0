From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:53:14 +1030
Subject: [PATCH v3 06/20] ARM: dts: aspeed: Add watchdog clocks
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-7-joel@jms.id.au>
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
index 57194d804051..2b1bb31ce390 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -177,11 +177,13 @@
 			wdt1: watchdog at 1e785000 {
 				compatible =3D "aspeed,ast2400-wdt";
 				reg =3D <0x1e785000 0x1c>;
+				clocks =3D <&syscon ASPEED_CLK_APB>;
 			};
=20
 			wdt2: watchdog at 1e785020 {
 				compatible =3D "aspeed,ast2400-wdt";
 				reg =3D <0x1e785020 0x1c>;
+				clocks =3D <&syscon ASPEED_CLK_APB>;
 			};
=20
 			vuart: serial at 1e787000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5=
.dtsi
index b6faaef2b1a7..95bb04e4cee2 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -219,16 +219,19 @@
 			wdt1: watchdog at 1e785000 {
 				compatible =3D "aspeed,ast2500-wdt";
 				reg =3D <0x1e785000 0x20>;
+				clocks =3D <&syscon ASPEED_CLK_APB>;
 			};
=20
 			wdt2: watchdog at 1e785020 {
 				compatible =3D "aspeed,ast2500-wdt";
 				reg =3D <0x1e785020 0x20>;
+				clocks =3D <&syscon ASPEED_CLK_APB>;
 			};
=20
 			wdt3: watchdog at 1e785040 {
 				compatible =3D "aspeed,ast2500-wdt";
 				reg =3D <0x1e785040 0x20>;
+				clocks =3D <&syscon ASPEED_CLK_APB>;
 				status =3D "disabled";
 			};
=20
--=20
2.15.1

