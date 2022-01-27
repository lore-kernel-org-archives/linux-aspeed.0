From: Andrei Kartashev <a.kartashev@yadro.com>
Date: Thu, 27 Jan 2022 16:17:04 +0300
Subject: [PATCH] ARM: dts: aspeed: remove unhandled fttmr010,pwm-outputs
In-Reply-To: <20220127121952.3985981-1-clabbe@baylibre.com>
References: <20220127121952.3985981-1-clabbe@baylibre.com>
Message-ID: <b5e8f3defc6715fbc0798a5c490d588e247335bc.camel@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Good catch! I miss this on porting DTS from local tree, based on
Intel's one. Since there is no such driver in upstream kernel
(https://github.com/Intel-BMC/linux/blob/dev-5.15-intel/drivers/pwm/pwm-fttmr010.c
), both this and beeper sections could be completely removed.

I will send another patch with cleanup.

Thank you.

On Thu, 2022-01-27 at 12:19 +0000, Corentin Labbe wrote:
> fttmr010,pwm-outputs is not handled by its timer driver, so this
> property is useless.
> Fixes: 67ac01d03862 ("ARM: dts: aspeed: add device tree for YADRO
> VEGMAN BMC")
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> ?arch/arm/boot/dts/aspeed-bmc-vegman.dtsi | 1 -
> ?1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> index 1a5b25b2ea29..43af63910571 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> +++ b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> @@ -166,7 +166,6 @@ &sdhci1 {
> ?};
> ?
> ?&timer {
> -???????fttmr010,pwm-outputs = <5>;
> ????????pinctrl-names = "default";
> ????????pinctrl-0 = <&pinctrl_timer5_default>;
> ????????#pwm-cells = <3>;

-- 
Best regards,
Andrei Kartashev


