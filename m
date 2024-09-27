From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 27 Sep 2024 15:30:34 +0930
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
In-Reply-To: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-09-26 at 09:34 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Remove the redundant space in the compatible string of adm1272.

In this case the space is not redundant, it's just incorrect, the
compatible string doesn't match any specified. Do you mind fixing the
wording?

> 
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Can you please add an appropriate Fixes: tag?

Thanks,

Andrew

> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..7ed76cd4fd2d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -284,12 +284,12 @@ &i2c10 {
>  &i2c11 {
>  	status = "okay";
>  	power-sensor at 10 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x10>;
>  	};
>  
>  	power-sensor at 12 {
> -		compatible = "adi, adm1272";
> +		compatible = "adi,adm1272";
>  		reg = <0x12>;
>  	};
>  

