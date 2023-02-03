From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri,  3 Feb 2023 02:54:05 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: e3c246d4i: Add PECI device
In-Reply-To: <20230203105405.21942-1-zev@bewilderbeest.net>
References: <20230203105405.21942-1-zev@bewilderbeest.net>
Message-ID: <20230203105405.21942-3-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that we've got driver support for it, we might as well enable and
use it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..67a75aeafc2b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -202,3 +202,7 @@ &kcs3 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca2>;
 };
+
+&peci0 {
+	status = "okay";
+};
-- 
2.39.1.236.ga8a28b9eace8

