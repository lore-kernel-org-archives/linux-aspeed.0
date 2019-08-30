From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 30 Aug 2019 11:09:44 -0500
Subject: [PATCH 2/3] ARM: dts: aspeed: swift: Change power supplies to version
 2
In-Reply-To: <1567181385-22129-1-git-send-email-eajames@linux.ibm.com>
References: <1567181385-22129-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1567181385-22129-3-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Swift power supplies are version 2 of the IBM CFFPS. Make it so in the
devicetree.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index f14f745..815b865 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -494,7 +494,7 @@
 	};
 
 	power-supply at 68 {
-		compatible = "ibm,cffps1";
+		compatible = "ibm,cffps2";
 		reg = <0x68>;
 	};
 
@@ -504,7 +504,7 @@
 	};
 
 	power-supply at 69 {
-		compatible = "ibm,cffps1";
+		compatible = "ibm,cffps2";
 		reg = <0x69>;
 	};
 
-- 
1.8.3.1

