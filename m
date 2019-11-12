From: Cédric Le Goater <clg@kaod.org>
Date: Tue, 12 Nov 2019 09:29:11 +0100
Subject: [PATCH 3/5] ARM: config: aspeed-g4: Add MMC, and cleanup
In-Reply-To: <20191112062857.32638-4-joel@jms.id.au>
References: <20191112062857.32638-1-joel@jms.id.au>
 <20191112062857.32638-4-joel@jms.id.au>
Message-ID: <fc2e193f-93e5-fc71-663f-d08e5b60e8ca@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/11/2019 07:28, Joel Stanley wrote:
> The PCA muxes now depend on I2C_MUX. SPI si now required by SPI-NOR.
> 
> Add the eMMC driver, and remove the FSI SBEFIFO which is not used on AST2400
> systems.
> 
> The remaining changes are cleanups from regenerating the defconfig.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/configs/aspeed_g4_defconfig | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
> index 1857df992484..303f75a3baec 100644
> --- a/arch/arm/configs/aspeed_g4_defconfig
> +++ b/arch/arm/configs/aspeed_g4_defconfig
> @@ -132,10 +132,12 @@ CONFIG_ASPEED_BT_IPMI_BMC=y
>  CONFIG_HW_RANDOM_TIMERIOMEM=y
>  # CONFIG_I2C_COMPAT is not set
>  CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MUX=y
>  CONFIG_I2C_MUX_PCA9541=y
>  CONFIG_I2C_MUX_PCA954x=y
>  CONFIG_I2C_ASPEED=y
>  CONFIG_I2C_FSI=y
> +CONFIG_SPI=y
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_ASPEED=y
> @@ -185,6 +187,12 @@ CONFIG_USB_CONFIGFS_F_LB_SS=y
>  CONFIG_USB_CONFIGFS_F_FS=y
>  CONFIG_USB_CONFIGFS_F_HID=y
>  CONFIG_USB_CONFIGFS_F_PRINTER=y
> +CONFIG_MMC=y
> +# CONFIG_PWRSEQ_EMMC is not set
> +# CONFIG_PWRSEQ_SIMPLE is not set
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_OF_ASPEED=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_CLASS_FLASH=y
> @@ -216,7 +224,6 @@ CONFIG_FSI_MASTER_GPIO=y
>  CONFIG_FSI_MASTER_HUB=y
>  CONFIG_FSI_MASTER_AST_CF=y
>  CONFIG_FSI_SCOM=y
> -CONFIG_FSI_SBEFIFO=y
>  CONFIG_FANOTIFY=y
>  CONFIG_OVERLAY_FS=y
>  CONFIG_TMPFS=y
> @@ -231,7 +238,6 @@ CONFIG_SQUASHFS_ZSTD=y
>  # CONFIG_NETWORK_FILESYSTEMS is not set
>  CONFIG_HARDENED_USERCOPY=y
>  CONFIG_FORTIFY_SOURCE=y
> -# CONFIG_CRYPTO_ECHAINIV is not set
>  CONFIG_CRYPTO_HMAC=y
>  CONFIG_CRYPTO_SHA256=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> @@ -247,14 +253,14 @@ CONFIG_DEBUG_INFO_REDUCED=y
>  CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_GDB_SCRIPTS=y
>  CONFIG_STRIP_ASM_SYMS=y
> +CONFIG_SCHED_STACK_END_CHECK=y
> +CONFIG_PANIC_ON_OOPS=y
> +CONFIG_PANIC_TIMEOUT=-1
>  CONFIG_SOFTLOCKUP_DETECTOR=y
>  # CONFIG_DETECT_HUNG_TASK is not set
>  CONFIG_WQ_WATCHDOG=y
> -CONFIG_PANIC_ON_OOPS=y
> -CONFIG_PANIC_TIMEOUT=-1
>  # CONFIG_SCHED_DEBUG is not set
> -CONFIG_SCHED_STACK_END_CHECK=y
>  CONFIG_FUNCTION_TRACER=y
> -# CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_DEBUG_WX=y
>  CONFIG_DEBUG_USER=y
> +# CONFIG_RUNTIME_TESTING_MENU is not set
> 

