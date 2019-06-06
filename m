From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 6 Jun 2019 09:36:33 -0500
Subject: [PATCH v2] ARM: configs: Remove useless UEVENT_HELPER_PATH
In-Reply-To: <1559636093-26005-1-git-send-email-krzk@kernel.org>
References: <1559636093-26005-1-git-send-email-krzk@kernel.org>
Message-ID: <3ca9b096-e53e-6434-47ee-2c3d59676fd4@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 6/4/19 3:14 AM, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 6701a975e785..fe2e1e82e233 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -44,7 +44,6 @@ CONFIG_PCI=y
>  CONFIG_PCI_MSI=y
>  CONFIG_PCIE_ALTERA=y
>  CONFIG_PCIE_ALTERA_MSI=y
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y

For (socfpga_defconfig):

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
