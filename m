From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:30:20 +0200
Subject: [PATCH v15 09/32] ARM: dts: aspeed: yosemite4: Enable interrupt
 setting for pca9555
In-Reply-To: <20240906062701.37088-10-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-10-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <4065ec96-5f8b-4e89-9db6-6b1203958af9@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Enable interrupt setting for pca9555
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index b11951c2f71e..09bbbcb192f5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -832,30 +832,78 @@ power-sensor at 12 {
>  
>  	gpio at 20 {
>  		compatible = "nxp,pca9555";
> -		reg = <0x20>;

NAK.

You are making the code worse. Read DTS coding style.

> +		pinctrl-names = "default";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",

Broken alignment.



Best regards,
Krzysztof

