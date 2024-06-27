From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu, 27 Jun 2024 15:00:07 +0800
Subject: [PATCH v2 05/10] ARM: dts: aspeed: Harma: add power monitor xdp710
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Message-ID: <20240627070013.2509150-6-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add HSC xdp710 device in i2c4.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7d809f1636d6..77eaa89b5eb5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -329,6 +329,11 @@ power-monitor at 44 {
 		reg = <0x44>;
 		shunt-resistor-micro-ohms = <250>;
 	};
+
+	power-monitor at 40 {
+		compatible = "infineon,xdp710";
+		reg = <0x40>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1

