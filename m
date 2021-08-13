From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu, 12 Aug 2021 23:19:00 -0700
Subject: [PATCH] ARM: dts: aspeed: cloudripper: Add comments for "mdio1"
Message-ID: <20210813061900.24539-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Add some comments to explain the purpose of "mdio1" controller: it's
connected to the MDC/MDIO interface of the on-board management switch.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
index 01ec3ce0a29d..9c6271a17ae8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
@@ -96,6 +96,11 @@
 	status = "okay";
 };
 
+/*
+ * "mdio1" is connected to the MDC/MDIO interface of the on-board
+ * management switch (whose ports are connected to BMC, Host and front
+ * panel ethernet port).
+ */
 &mdio1 {
 	status = "okay";
 };
-- 
2.17.1

