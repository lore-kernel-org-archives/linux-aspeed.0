From: Joel Stanley <joel@jms.id.au>
Date: Tue, 27 Jul 2021 13:16:39 +0930
Subject: [PATCH] ARM: dts: aspeed: ast2500evb: Enable built in RTC
Message-ID: <20210727034639.474458-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable this device so the RTC driver can be tested on the EVB.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 583a241f1151..1d24b394ea4c 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -129,3 +129,7 @@ &gfx {
      status = "okay";
      memory-region = <&gfx_memory>;
 };
+
+&rtc {
+	status = "okay";
+};
-- 
2.32.0

