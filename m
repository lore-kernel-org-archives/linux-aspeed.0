From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 6 May 2024 17:38:11 +0200
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add I3C config in DTS
In-Reply-To: <20240506113306.1283179-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240506113306.1283179-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <3903300d-9d5b-44b3-95fa-0579e5421071@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/05/2024 13:33, Delphine CC Chiu wrote:
> Set I3C config in yosemite4 DTS.
> 
> Test plan:
> Tested with aspeed I3C patches and I3C hub driver.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..6a30c424d745 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -595,6 +595,92 @@ i2c-mux at 72 {
>  	};
>  };
>  
> +&i3c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i3c1_default>;
> +	i3c-pp-scl-hi-period-ns = <40>;
> +	i3c-pp-scl-lo-period-ns = <40>;
> +	i3c-od-scl-hi-period-ns = <380>;
> +	i3c-od-scl-lo-period-ns = <620>;
> +	sda-tx-hold-ns = <10>;
> +
> +	mctp-controller;
> +	hub at 0x70 {

That's not a valid unit address.


> +		reg = <0x70 0x3c0 0x00700000>;
> +		cp0-ldo-en = "enabled";
> +		cp1-ldo-en = "enabled";
> +		cp0-ldo-volt = "1.2V";
> +		cp1-ldo-volt = "1.2V";
> +		tp0145-ldo-en = "enabled";
> +		tp2367-ldo-en = "enabled";
> +		tp0145-ldo-volt = "1.2V";
> +		tp2367-ldo-volt = "1.2V";
> +		tp0145-pullup = "2k";
> +		tp2367-pullup = "2k";

Where are bindings for all this?



Best regards,
Krzysztof

