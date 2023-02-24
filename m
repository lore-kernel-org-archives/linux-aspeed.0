From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu, 23 Feb 2023 16:03:59 -0800
Subject: [PATCH v2 2/3] ARM: dts: aspeed: e3c246d4i: Add PECI device
In-Reply-To: <20230224000400.12226-1-zev@bewilderbeest.net>
References: <20230224000400.12226-1-zev@bewilderbeest.net>
Message-ID: <20230224000400.12226-3-zev@bewilderbeest.net>
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
2.39.1.438.gdcb075ea9396.dirty

