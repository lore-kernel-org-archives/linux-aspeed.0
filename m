From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Nov 2019 16:58:56 +1030
Subject: [PATCH 4/5] ARM: configs: multi_v7: ASPEED network, gpio, FSI
In-Reply-To: <20191112062857.32638-1-joel@jms.id.au>
References: <20191112062857.32638-1-joel@jms.id.au>
Message-ID: <20191112062857.32638-5-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable drivers used by the ASPEED SoCs so the multi v7 defconfig can run
on those boards.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/multi_v7_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 13ba53286901..124f50dc9cc7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -244,6 +244,7 @@ CONFIG_BGMAC_BCMA=y
 CONFIG_SYSTEMPORT=m
 CONFIG_MACB=y
 CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_FTGMAC100=m
 CONFIG_GIANFAR=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_E1000E=y
@@ -437,6 +438,7 @@ CONFIG_PINCTRL_MSM8X74=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
+CONFIG_GPIO_ASPEED_SGPIO=y
 CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_EM=y
@@ -1041,6 +1043,13 @@ CONFIG_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
+CONFIG_FSI=m
+CONFIG_FSI_MASTER_GPIO=m
+CONFIG_FSI_MASTER_HUB=m
+CONFIG_FSI_MASTER_ASPEED=m
+CONFIG_FSI_SCOM=m
+CONFIG_FSI_SBEFIFO=m
+CONFIG_FSI_OCC=m
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.24.0

