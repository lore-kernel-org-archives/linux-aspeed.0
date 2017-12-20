From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:53:21 +1030
Subject: [PATCH v3 13/20] ARM: dts: Add OpenBMC flash layout
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-14-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This is a layout used by OpenBMC systems. It describes the fixed flash
layout of a 32MB mtd device.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
  - Remove leading zeros to fix warning
---
 arch/arm/boot/dts/openbmc-flash-layout.dtsi | 32 +++++++++++++++++++++++++=
++++
 1 file changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout.dtsi

diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dt=
s/openbmc-flash-layout.dtsi
new file mode 100644
index 000000000000..6c26524e93e1
--- /dev/null
+++ b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+partitions {
+	compatible =3D "fixed-partitions";
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+
+	u-boot at 0 {
+		reg =3D <0x0 0x60000>;
+		label =3D "u-boot";
+	};
+
+	u-boot-env at 60000 {
+		reg =3D <0x60000 0x20000>;
+		label =3D "u-boot-env";
+	};
+
+	kernel at 80000 {
+		reg =3D <0x80000 0x440000>;
+		label =3D "kernel";
+	};
+
+	rofs at c0000 {
+		reg =3D <0x4c0000 0x1740000>;
+		label =3D "rofs";
+	};
+
+	rwfs at 1c00000 {
+		reg =3D <0x1c00000 0x400000>;
+		label =3D "rwfs";
+	};
+};
--=20
2.15.1

