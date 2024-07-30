From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 30 Jul 2024 13:29:08 +0930
Subject: [PATCH v11 20/27] ARM: dts: aspeed: yosemite4: support medusa
 board adc sensors
In-Reply-To: <ZqgTz9DVPcqtTfUC@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240723092310.3565410-21-Delphine_CC_Chiu@wiwynn.com>
	 <ZqgTz9DVPcqtTfUC@heinlein.vulture-banana.ts.net>
Message-ID: <86a3b58d00fc475065ad51458504a636e2f67e02.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-29 at 17:12 -0500, Patrick Williams wrote:
> On Tue, Jul 23, 2024 at 05:23:01PM +0800, Delphine CC Chiu wrote:
> > Add ina233/ina28 support for medusa board adc sensors
> > 
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 98eeee49b082..49500db53a13 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -915,6 +915,19 @@ power-sensor at 40 {
> >  		reg = <0x40>;
> >  	};
> >  
> > +	power-sensor at 41 {
> > +			compatible = "ti,ina233";
> > +			resistor-calibration = /bits/ 16 <0x0a00>;
> > +			current-lsb= /bits/ 16 <0x0001>;
> > +			reg = <0x41>;
> > +	};
> 
> This depends on this unmerged patchset, right?
> 
> https://lore.kernel.org/lkml/4a1cb223-448c-3e93-eb38-d86f543659e3 at roeck-us.net/
> 
> Please resolve the issues Guenter raised.

Probably best to drop these nodes until those issues are resolved and
the binding patch is merged.

Andrew
