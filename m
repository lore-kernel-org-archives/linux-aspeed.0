From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 5 Oct 2020 01:55:54 +0000
Subject: [PATCH] ARM: dts: aspeed-g6: Add sgpiom/sgpios node
In-Reply-To: <6bc40a50-8c21-4642-ad9e-e92f756aac25@www.fastmail.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
 <6bc40a50-8c21-4642-ad9e-e92f756aac25@www.fastmail.com>
Message-ID: <C4E8563D-DF4D-4BCE-97B3-F6396AD99020@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

?On 2020/10/1, 8:36 AM, Andrew Jeffery wrote:

    Hi Billy,
    
    On Wed, 30 Sep 2020, at 14:41, Billy Tsai wrote:
    > This commit add two sgpiom and two sgpios node into aspeed-g6.dtsi
    > and change the register range of gpio0 to fix the hardware design.
    > 
    > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    > ---
    >  arch/arm/boot/dts/aspeed-g6.dtsi | 51 +++++++++++++++++++++++++++++++-
    >  1 file changed, 50 insertions(+), 1 deletion(-)
    > 
    > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
    > index 97ca743363d7..00237daec2a1 100644
    > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
    > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
    > @@ -357,7 +357,7 @@
    >  				#gpio-cells = <2>;
    >  				gpio-controller;
    >  				compatible = "aspeed,ast2600-gpio";
    > -				reg = <0x1e780000 0x800>;
    > +				reg = <0x1e780000 0x500>;
    >  				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
    >  				gpio-ranges = <&pinctrl 0 0 208>;
    >  				ngpios = <208>;
    > @@ -365,6 +365,55 @@
    >  				interrupt-controller;
    >  				#interrupt-cells = <2>;
    >  			};
    > +			sgpiom0: sgpiom at 1e780500 {
    > +				#gpio-cells = <2>;
    > +				gpio-controller;
    > +				compatible = "aspeed,ast2600-sgpiom";
    > +				reg = <0x1e780500 0x100>;
    > +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
    > +				ngpios = <128>;
    > +				clocks = <&syscon ASPEED_CLK_APB2>;
    > +				interrupt-controller;
    > +				bus-frequency = <12000000>;
    > +
    > +				pinctrl-names = "default";
    > +				pinctrl-0 = <&pinctrl_sgpm1_default>;
    > +				status = "disabled";
    > +			};
    > +
    > +			sgpiom1: sgpiom at 1e780600 {
    > +				#gpio-cells = <2>;
    > +				gpio-controller;
    > +				compatible = "aspeed,ast2600-sgpiom";
    > +				reg = <0x1e780600 0x100>;
    > +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
    > +				ngpios = <80>;
    > +				clocks = <&syscon ASPEED_CLK_APB2>;
    > +				interrupt-controller;
    > +				bus-frequency = <12000000>;
    > +
    > +				pinctrl-names = "default";
    > +				pinctrl-0 = <&pinctrl_sgpm2_default>;
    
   > Have you tried building this on top of upstream? Because neither sgpm2 nor 
   > sgps2 are supported by the pinctrl driver. If you have patches that implement 
   > both mux configurations, can you post them too?
    
   > Andrew

Sorry for that.

I will resend another patch which includes pinctrl information to fix this error.
  
Best Regards,
Billy Tsai
 


