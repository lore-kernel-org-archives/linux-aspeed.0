From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 10 Sep 2024 09:30:33 +0200
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
In-Reply-To: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/09/2024 08:39, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Enable interrupt setting and add GPIO line name for pca9555 for the I/O
> expanders on Medusa board.
> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 52 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..cb2436031181 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -295,30 +295,74 @@ power-sensor at 12 {
>  
>  	gpio at 20 {
>  		compatible = "nxp,pca9555";
> -		reg = <0x20>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		reg = <0x20>;

Hm? Why? The placement is after compatible.

> +		interrupt-parent = <&gpio0>;
> +		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> +		gpio-line-names =
> +		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",

Nothing improved here. I already commented about above and this.
Implement feedback for all your patches, not only one.

Best regards,
Krzysztof

