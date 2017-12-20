From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:53:18 +1030
Subject: [PATCH v3 10/20] ARM: dts: aspeed: Add LPC Snoop device
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-11-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

LPC snoop hardware on the ASPEED BMC, used for monitoring
host I/O port activity.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4=
.dtsi
index 91aea96c10c8..e8a61fc3956d 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -237,6 +237,13 @@
 						status =3D "disabled";
 					};
=20
+					lpc_snoop: lpc-snoop at 0 {
+						compatible =3D "aspeed,ast2400-lpc-snoop";
+						reg =3D <0x0 0x80>;
+						interrupts =3D <8>;
+						status =3D "disabled";
+					};
+
 					lhc: lhc at 20 {
 						compatible =3D "aspeed,ast2400-lhc";
 						reg =3D <0x20 0x24 0x48 0x8>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5=
.dtsi
index af3869ec87bb..d558091aa92b 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -288,6 +288,12 @@
 						status =3D "disabled";
 					};
=20
+					lpc_snoop: lpc-snoop at 0 {
+						compatible =3D "aspeed,ast2500-lpc-snoop";
+						reg =3D <0x0 0x80>;
+						interrupts =3D <8>;
+						status =3D "disabled";
+					};
=20
 					lhc: lhc at 20 {
 						compatible =3D "aspeed,ast2500-lhc";
--=20
2.15.1

