From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 04 Jun 2024 11:32:54 +0930
Subject: [PATCH] ARM: dts: aspeed: convert ASRock SPC621D8HM3 NVMEM
 content to layout syntax
In-Reply-To: <11f0a9a0-967e-4971-8ca1-4730f2881ee1@hatter.bewilderbeest.net>
References: <20240520063044.4885-1-zajec5@gmail.com>
	 <11f0a9a0-967e-4971-8ca1-4730f2881ee1@hatter.bewilderbeest.net>
Message-ID: <f4a891a6548461935129bb8ef4bed68c265567a1.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-06-03 at 18:21 -0700, Zev Weiss wrote:
> On Sun, May 19, 2024 at 11:30:44PM PDT, Rafa? Mi?ecki wrote:
> > From: Rafa? Mi?ecki <rafal@milecki.pl>
> > 
> > Use cleaner (and non-deprecated) bindings syntax. See commit
> > bd912c991d2e ("dt-bindings: nvmem: layouts: add fixed-layout") for
> > details.
> > 
> > Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> > ---
> > .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts     | 12 ++++++++----
> > 1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
> > index 555485871e7a..c4097e4f2ca4 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
> > @@ -110,11 +110,15 @@ eeprom at 50 {
> > 		compatible = "st,24c128", "atmel,24c128";
> > 		reg = <0x50>;
> > 		pagesize = <16>;
> > -		#address-cells = <1>;
> > -		#size-cells = <1>;
> > 
> > -		eth0_macaddress: macaddress at 3f80 {
> > -			reg = <0x3f80 6>;
> > +		nvmem-layout {
> > +			compatible = "fixed-layout";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +
> > +			eth0_macaddress: macaddress at 3f80 {
> > +				reg = <0x3f80 6>;
> > +			};
> > 		};
> > 	};
> > 
> > -- 
> > 2.35.3
> > 
> 
> Acked-by: Zev Weiss <zev@bewilderbeest.net>
> 

Thanks, I've applied this to a tree for Joel to pick up.

Andrew
