From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 6 Sep 2024 06:37:46 +0000
Subject: [PATCH v15 32/32] ARM: dts: aspeed: yosemite4: add ISL28022
 support on 11
In-Reply-To: <20240906062701.37088-33-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906062701.37088-33-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <TYZPR04MB5853E02120EFB41B9AF9464AD69E2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We are sorry to bother you!
We are reorganizing these patches and will run the DTS check before contributing.
Please ignore the PATCH v15.
Sorry about the spamming mail.

> -----Original Message-----
> From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> Sent: Friday, September 6, 2024 2:27 PM
> To: patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@codeconstruct.com.au>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>
> Cc: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-renesas-soc at vger.kernel.org
> Subject: [PATCH v15 32/32] ARM: dts: aspeed: yosemite4: add ISL28022
> support on 11
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 0341b61aa1f1..e0cdda701c24 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1088,7 +1088,7 @@ power-sensor at 41 {
>  	};
> 
>  	power-sensor at 44 {
> -		compatible = "ti,ina238";
> +		compatible = "ti,ina238", "renesas,isl28022";
>  		shunt-resistor = <1000>;
>  		reg = <0x44>;
>  	};
> --
> 2.25.1

