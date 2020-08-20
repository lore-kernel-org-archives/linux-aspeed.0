From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 20 Aug 2020 11:11:51 -0500
Subject: [PATCH 4/5] ARM: dts: Aspeed: Tacoma: Add IBM Operation Panel I2C
 device
In-Reply-To: <20200820161152.22751-1-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
Message-ID: <20200820161152.22751-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set I2C bus 0 to multi-master mode and add the panel device that will
register as a slave.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 5f4ee67ac787..9cf2e02ae9e2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -438,7 +438,13 @@ aliases {
 };
 
 &i2c0 {
+	multi-master;
 	status = "okay";
+
+	ibm-panel at 62 {
+		compatible = "ibm,op-panel";
+		reg = <0x40000062>; /* I2C_OWN_SLAVE_ADDRESS */
+	};
 };
 
 &i2c1 {
-- 
2.26.2

