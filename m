From: Ben Pai <Ben_Pai@wistron.com>
Date: Thu, 21 Jan 2021 15:31:46 +0800
Subject: [PATCH v1] ARM: dts: aspeed: Add Mowgli rtc driver
Message-ID: <20210121073146.28217-1-Ben_Pai@wistron.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add mowgli rtc driver.

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
index b648e468e9db..8503152faaf0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
@@ -582,6 +582,11 @@
 	/* TMP275A */
 	/* TMP275A */
 
+	rtc at 32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+
 	tmp275 at 48 {
 		compatible = "ti,tmp275";
 		reg = <0x48>;
-- 
2.17.1


---------------------------------------------------------------------------------------------------------------------------------------------------------------
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. 
Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
---------------------------------------------------------------------------------------------------------------------------------------------------------------
