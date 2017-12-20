From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:53:27 +1030
Subject: [PATCH v3 19/20] ARM: dts: aspeed-plametto: Add flash layout and fix
 memory node
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-20-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The OpenBMC flash layout is used by Palmetto systems.

Add the unit name to the memory node to fix a warning with W=3D1.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Added memory node unit name
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/=
dts/aspeed-bmc-opp-palmetto.dts
index a8f0c046e83e..4379d09a261f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -12,7 +12,7 @@
 		bootargs =3D "console=3DttyS4,115200 earlyprintk";
 	};
=20
-	memory {
+	memory at 40000000 {
 		reg =3D <0x40000000 0x20000000>;
 	};
=20
@@ -34,6 +34,7 @@
 		status =3D "okay";
 		m25p,fast-read;
 		label =3D "bmc";
+#include "openbmc-flash-layout.dtsi"
 	};
 };
=20
--=20
2.15.1

