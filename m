From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 29 Jul 2024 17:03:23 -0500
Subject: [PATCH v11 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056
 support
In-Reply-To: <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 23, 2024 at 05:23:06PM +0800, Delphine CC Chiu wrote:
> Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index f73719b3c2f1..03a1e41312e3 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1240,35 +1240,35 @@ adc at 37 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";

Is this legal to have two chips both listed as compatible?  I thought
this approach has been rejected before.

>  		reg = <0x40>;
>  		resistor-calibration = /bits/ 16 <0x0a00>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 41 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x41>;
>  		resistor-calibration = /bits/ 16 <0x0a00>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 42 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x42>;
>  		resistor-calibration = /bits/ 16 <0x0a00>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 43 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x43>;
>  		resistor-calibration = /bits/ 16 <0x0a00>;
>  		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 44 {
> -		compatible = "ti,ina233";
> +		compatible = "ti,ina233", "richtek,rtq6056";
>  		reg = <0x44>;
>  		resistor-calibration = /bits/ 16 <0x0a00>;
>  		current-lsb= /bits/ 16 <0x0001>;
> -- 
> 2.25.1
> 

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240729/4efab799/attachment.sig>
