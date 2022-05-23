From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 23 May 2022 10:56:40 -0700
Subject: [PATCH -next] ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom
Message-ID: <20220523175640.60155-1-quic_jaehyoo@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Nuvia has been acquired by Qualcomm and the vendor name 'nuvia' will
not be used anymore so rename aspeed-bmc-nuvia-dc-scm.dts to
aspeed-bmc-qcom-dc-scm-v1.dts and change 'nuvia' to 'qcom' as its vendor
name in the file.

Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
---
 arch/arm/boot/dts/Makefile                                    | 2 +-
 ...eed-bmc-nuvia-dc-scm.dts => aspeed-bmc-qcom-dc-scm-v1.dts} | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{aspeed-bmc-nuvia-dc-scm.dts => aspeed-bmc-qcom-dc-scm-v1.dts} (97%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 03f5b3a15415..2a3c95387613 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1584,7 +1584,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr630.dtb \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
-	aspeed-bmc-nuvia-dc-scm.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mihawk.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
@@ -1597,6 +1596,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-witherspoon.dtb \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
+	aspeed-bmc-qcom-dc-scm-v1.dtb \
 	aspeed-bmc-quanta-q71l.dtb \
 	aspeed-bmc-quanta-s6q.dtb \
 	aspeed-bmc-supermicro-x11spi.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts b/arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
similarity index 97%
rename from arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
rename to arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
index f4a97cfb0f23..259ef3f54c5c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
@@ -6,8 +6,8 @@
 #include "aspeed-g6.dtsi"
 
 / {
-	model = "Nuvia DC-SCM BMC";
-	compatible = "nuvia,dc-scm-bmc", "aspeed,ast2600";
+	model = "Qualcomm DC-SCM V1 BMC";
+	compatible = "qcom,dc-scm-v1-bmc", "aspeed,ast2600";
 
 	aliases {
 		serial4 = &uart5;
-- 
2.25.1

