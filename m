From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 01 Oct 2020 10:02:21 +0930
Subject: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
In-Reply-To: <b7bcc925-b0da-446f-84a7-1a564a1f4f83@www.fastmail.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
 <20200930090603.19891-1-billy_tsai@aspeedtech.com>
 <b7bcc925-b0da-446f-84a7-1a564a1f4f83@www.fastmail.com>
Message-ID: <2b3c4303-ef63-4c34-be00-ff59abc32e69@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 1 Oct 2020, at 09:42, Andrew Jeffery wrote:
> Hi Billy,
> 
> On Wed, 30 Sep 2020, at 18:36, Billy Tsai wrote:
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 97ca743363d7..b9ec8b579f73 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -357,7 +357,7 @@
> >  				#gpio-cells = <2>;
> >  				gpio-controller;
> >  				compatible = "aspeed,ast2600-gpio";
> > -				reg = <0x1e780000 0x800>;
> > +				reg = <0x1e780000 0x500>;
> 
> We took the 0x800 value from the memory space layout table in the datasheet for 
> the 2600. Should that be updated too? Or are you just limiting the region to 
> the registers currently described rather than the allocated address space?

Ah, actually, I see what's going on. We really have this layout (taking some liberties):

0x1e785000 - 0x1e785500: PGPIO 3.3V
0x1e785500 - 0x1e785600: SGPM1
0x1e785600 - 0x1e785700: SGPM2
0x1e785700 - 0x1e785740: SPGS1
0x1e785740 - 0x1e785780: SPGS2
0x1e785800 - 0x1e786000: PGPIO 1.8V

Ryan: Can you change the address space layout table to reflect this? That way it
still functions as a quick - but accurate - reference.

Andrew
