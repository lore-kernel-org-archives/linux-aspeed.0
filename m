From: John Wang <wangzhiqiang.bj@bytedance.com>
Date: Thu, 10 Dec 2020 17:31:01 +0800
Subject: [PATCH 3/3] ARM: dts: aspeed: Enable g220a uart route
Message-ID: <20201210093101.413-1-wangzhiqiang.bj@bytedance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
 arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
index 89916a2eec18..e3a82679ed9c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
@@ -929,3 +929,7 @@ &video {
 &vhub {
 	status = "okay";
 };
+
+&uart_routing {
+	status = "okay";
+};
-- 
2.25.1

