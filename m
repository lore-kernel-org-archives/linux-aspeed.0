From: Joel Stanley <joel@jms.id.au>
Date: Wed, 26 Aug 2020 16:49:16 +0930
Subject: [PATCH] ARM: config: aspeed: Fix selection of media drivers
Message-ID: <20200826071916.3081953-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the 5.7 merge window the media kconfig was restructued. For most
platforms these changes set CONFIG_MEDIA_SUPPORT_FILTER=y which keeps
unwanted drivers disabled.

The exception is if a config sets EMBEDDED or EXPERT (see b0cd4fb27665).
In that case the filter is set to =n, causing a bunch of DVB tuner drivers
(MEDIA_TUNER_*) to be accidentally enabled. This was noticed as it blew
out the build time for the Aspeed defconfigs.

Enabling the filter means the Aspeed config also needs to set
CONFIG_MEDIA_PLATFORM_SUPPORT=y in order to have the CONFIG_VIDEO_ASPEED
driver enabled.

Fixes: 06b93644f4d1 ("media: Kconfig: add an option to filter in/out platform drivers")
Fixes: b0cd4fb27665 ("media: Kconfig: on !EMBEDDED && !EXPERT, enable driver filtering")
Cc: stable at vger.kernel.org
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---

Another solution would be to revert b0cd4fb27665 ("media: Kconfig: on
!EMBEDDED && !EXPERT, enable driver filtering"). I assume this was done
to be helpful, but in practice it has enabled the TUNER drivers (and
others) for the following configs that didn't have them before:

$ git grep -lE "(CONFIG_EXPERT|CONFIG_EMBEDDED)"  arch/*/configs/ | xargs grep -l MEDIA_SUPPORT
arch/arm/configs/aspeed_g4_defconfig
arch/arm/configs/aspeed_g5_defconfig
arch/arm/configs/at91_dt_defconfig
arch/arm/configs/bcm2835_defconfig
arch/arm/configs/davinci_all_defconfig
arch/arm/configs/ezx_defconfig
arch/arm/configs/imote2_defconfig
arch/arm/configs/imx_v4_v5_defconfig
arch/arm/configs/imx_v6_v7_defconfig
arch/arm/configs/milbeaut_m10v_defconfig
arch/arm/configs/multi_v7_defconfig
arch/arm/configs/omap2plus_defconfig
arch/arm/configs/pxa_defconfig
arch/arm/configs/qcom_defconfig
arch/arm/configs/sama5_defconfig
arch/arm/configs/tegra_defconfig
arch/mips/configs/ci20_defconfig
arch/mips/configs/lemote2f_defconfig
arch/mips/configs/loongson3_defconfig
arch/mips/configs/pistachio_defconfig

I've cc'd the maintainers of these defconfigs so they are aware.

---
 arch/arm/configs/aspeed_g4_defconfig | 3 ++-
 arch/arm/configs/aspeed_g5_defconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 303f75a3baec..58d293b63581 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -160,7 +160,8 @@ CONFIG_SENSORS_TMP421=y
 CONFIG_SENSORS_W83773G=y
 CONFIG_WATCHDOG_SYSFS=y
 CONFIG_MEDIA_SUPPORT=y
-CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_SUPPORT_FILTER=y
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ASPEED=y
 CONFIG_DRM=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index b0d056d49abe..cc2449ed6e6d 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -175,7 +175,8 @@ CONFIG_SENSORS_TMP421=y
 CONFIG_SENSORS_W83773G=y
 CONFIG_WATCHDOG_SYSFS=y
 CONFIG_MEDIA_SUPPORT=y
-CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_SUPPORT_FILTER=y
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_ASPEED=y
 CONFIG_DRM=y
-- 
2.28.0

