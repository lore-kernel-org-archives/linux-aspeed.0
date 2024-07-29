From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 29 Jul 2024 17:13:57 -0500
Subject: [PATCH v11 14/27] ARM: dts: aspeed: yosemite4: Revise ina233
 config for yosemite4 schematic change
In-Reply-To: <20240723092310.3565410-15-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-15-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <ZqgUJVR-j-Valq0_@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 23, 2024 at 05:22:55PM +0800, Delphine CC Chiu wrote:
> Revise ina233 config for yosemite4 schematic change
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 1765a0bb70d7..df389b506b4b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1034,28 +1034,38 @@ adc at 37 {
>  	};
>  
>  	power-sensor at 40 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";

Also depends on unmerged code?

https://lore.kernel.org/lkml/4a1cb223-448c-3e93-eb38-d86f543659e3 at roeck-us.net/

>  		reg = <0x40>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 41 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";
>  		reg = <0x41>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 42 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";
>  		reg = <0x42>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 43 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";
>  		reg = <0x43>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	power-sensor at 44 {
> -		compatible = "ti,ina230";
> +		compatible = "ti,ina233";
>  		reg = <0x44>;
> +		resistor-calibration = /bits/ 16 <0x0a00>;
> +		current-lsb= /bits/ 16 <0x0001>;
>  	};
>  
>  	temperature-sensor at 4e {
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240729/915ba247/attachment-0001.sig>
