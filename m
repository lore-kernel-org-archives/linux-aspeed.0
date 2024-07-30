From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 30 Jul 2024 13:26:21 +0930
Subject: [PATCH v11 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056
 support
In-Reply-To: <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
	 <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
Message-ID: <cf5f5efb49ef6230ba5084e53316a8fb8ddedef1.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-29 at 17:03 -0500, Patrick Williams wrote:
> On Tue, Jul 23, 2024 at 05:23:06PM +0800, Delphine CC Chiu wrote:
> > Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.
> > 
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index f73719b3c2f1..03a1e41312e3 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -1240,35 +1240,35 @@ adc at 37 {
> >  	};
> >  
> >  	power-sensor at 40 {
> > -		compatible = "ti,ina233";
> > +		compatible = "ti,ina233", "richtek,rtq6056";
> 
> Is this legal to have two chips both listed as compatible?  I thought
> this approach has been rejected before.

It depends on the circumstances. Does one have a superset of the
functionality of the other?

https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter2-devicetree-basics.rst#compatible

Andrew
