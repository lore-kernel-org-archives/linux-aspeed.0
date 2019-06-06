From: Nicolas.Ferre@microchip.com <Nicolas.Ferre@microchip.com>
Date: Thu, 6 Jun 2019 09:16:06 +0000
Subject: [PATCH v2] ARM: configs: Remove useless UEVENT_HELPER_PATH
In-Reply-To: <1559636093-26005-1-git-send-email-krzk@kernel.org>
References: <1559636093-26005-1-git-send-email-krzk@kernel.org>
Message-ID: <58ffd0ff-42e8-1011-0329-65957717de72@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/06/2019 at 10:14, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>     CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>     made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>     [...] creates a high system load") and was kept only for ancient
>     userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>     README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Changes since v2:
> 1. Remove unrelated files.
> 2. Add Geert's ack.
> ---
>   arch/arm/configs/acs5k_defconfig          | 1 -
>   arch/arm/configs/acs5k_tiny_defconfig     | 1 -
>   arch/arm/configs/am200epdkit_defconfig    | 1 -
>   arch/arm/configs/aspeed_g4_defconfig      | 1 -
>   arch/arm/configs/aspeed_g5_defconfig      | 1 -
>   arch/arm/configs/at91_dt_defconfig        | 1 -

[..]

>   arch/arm/configs/sama5_defconfig          | 1 -

for at91 (at91_dt_defconfig & sama5_defconfig):
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

>   arch/arm/configs/socfpga_defconfig        | 1 -
>   arch/arm/configs/spear13xx_defconfig      | 1 -
>   arch/arm/configs/spear3xx_defconfig       | 1 -
>   arch/arm/configs/spear6xx_defconfig       | 1 -
>   arch/arm/configs/spitz_defconfig          | 1 -
>   arch/arm/configs/tango4_defconfig         | 1 -
>   arch/arm/configs/tct_hammer_defconfig     | 1 -
>   arch/arm/configs/u300_defconfig           | 1 -
>   arch/arm/configs/u8500_defconfig          | 1 -
>   arch/arm/configs/vexpress_defconfig       | 1 -
>   arch/arm/configs/viper_defconfig          | 1 -
>   arch/arm/configs/xcep_defconfig           | 1 -
>   arch/arm/configs/zeus_defconfig           | 1 -
>   arch/arm/configs/zx_defconfig             | 1 -
>   69 files changed, 69 deletions(-)
[..]
-- 
Nicolas Ferre
