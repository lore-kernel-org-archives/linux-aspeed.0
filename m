From: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Date: Tue, 27 Sep 2022 17:15:15 +0530
Subject: [PATCH v6] ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
Message-ID: <20220927114515.GA22344@hcl-ThinkPad-T495>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added IPMB-13 channel for Debug Card communication.
which improves the readability of the machine and makes
it easier to debug the server and it will display some
pieces of information about the server like "system info",
"Critical sensors" and "critical sel".

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
v6:
 -Fix the commit format

v5:
 -Updated commit message

v4:
 -Resolved syntax error

v3:
 -Updated the title and commit

v2:
 -Updated the title

v1:
 - Initial draft
---
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..84236df522dc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -215,6 +215,17 @@
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	// Debug Card
+	multi-master;
+	ipmb13 at 10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
 &pwm_tacho {
 	status = "okay";
 	//FSC
-- 
2.17.1

