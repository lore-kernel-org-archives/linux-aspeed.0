From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:27:04 +0200
Subject: [PATCH v15 28/32] ARM: dts: aspeed: yosemite4: fix GPIO linename
 typo
In-Reply-To: <20240906062701.37088-29-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-29-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <6ce7bb37-833f-4164-8247-2ea80321993e@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Fix GPIO linename typo and add missing GPIO pin initial state.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
>  1 file changed, 455 insertions(+), 99 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index abd4a9173de4..4090725160f9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -285,6 +285,8 @@ &mac2 {
>  	pinctrl-0 = <&pinctrl_rmii3_default>;
>  	use-ncsi;
>  	mellanox,multi-host;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;

NAK.

Stop sending downstream junk to us.

...

> +	pin_gpio_m3 {

You were already told multiple times to fix youro naming.

Underscores are not allowed in node names.

Finally, fix all your patches, not just one.

> +		gpios = <ASPEED_GPIO(M, 3) GPIO_ACTIVE_LOW>;
> +		input;
> +	};
> +	pin_gpio_m4 {
> +		gpios = <ASPEED_GPIO(M, 4) GPIO_ACTIVE_LOW>;
> +		input;
> +	};
> +	pin_gpio_m5 {
> +		gpios = <ASPEED_GPIO(M, 5) GPIO_ACTIVE_LOW>;
> +		input;
> +	};
> +	pin_gpio_n0 {
> +		gpios = <ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
> +		input;
> +	};
> +	pin_gpio_n1 {

Best regards,
Krzysztof

