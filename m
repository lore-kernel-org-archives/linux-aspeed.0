From: Konstantin Ryabitsev via B4 Submission Endpoint <devnull+icon.mricon.com@kernel.org>
Date: Wed, 21 Dec 2022 14:27:59 -0500
Subject: [PATCH] arm: lanyang: fix lable->label typo for lanyang dts
Message-ID: <20221221-lanyang-lable-fix-v1-1-eb6e11eb4a6c@mricon.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Konstantin Ryabitsev <icon@mricon.com>

Fix an obvious spelling error in the dts file for Lanyang BMC.
This was reported via bugzilla a few years ago but never fixed.

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205891
Signed-off-by: Konstantin Ryabitsev <icon@mricon.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index c0847636f20b..e72e8ef5bff2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -52,12 +52,12 @@ hdd_fault {
 			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
 		};
 		bmc_err {
-			lable = "BMC_fault";
+			label = "BMC_fault";
 			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
 		};
 
 		sys_err {
-			lable = "Sys_fault";
+			label = "Sys_fault";
 			gpios = <&gpio ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		};
 	};

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20221221-lanyang-lable-fix-605edf14d27e

Best regards,
-- 
Konstantin Ryabitsev <icon@mricon.com>
