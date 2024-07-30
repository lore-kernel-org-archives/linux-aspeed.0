From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 30 Jul 2024 13:30:47 +0930
Subject: [PATCH v5 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
In-Reply-To: <CAGfYmwVSd846mX=WwhPu9dzZ0-d92jEzWG=dbDA+hQP+25uC9A@mail.gmail.com>
References: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
	 <172199921421.1507234.14901757413141840919.robh@kernel.org>
	 <6d73dcf20c726ad59e2aa16e507af17b3af59c42.camel@codeconstruct.com.au>
	 <CAGfYmwVSd846mX=WwhPu9dzZ0-d92jEzWG=dbDA+hQP+25uC9A@mail.gmail.com>
Message-ID: <87dc3f83dfd85c2d6b81fb28b9058d59efc6b2c6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-29 at 09:50 +0800, Potin Lai wrote:
> On Mon, Jul 29, 2024 at 9:17?AM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> > 
> > Hi Potin,
> > 
> > On Fri, 2024-07-26 at 08:09 -0500, Rob Herring (Arm) wrote:
> > > On Fri, 26 Jul 2024 18:26:48 +0800, Potin Lai wrote:
> > > > Add Linux device tree entry related to Meta(Facebook) Catalina specific
> > > > devices connected to BMC(AST2600) SoC.
> > > 
> > ...
> > > 
> > > My bot found new DTB warnings on the .dts files added or changed in this
> > > series.
> > > 
> > > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > > are fixed by another series. Ultimately, it is up to the platform
> > > maintainer whether these warnings are acceptable or not. No need to reply
> > > unless the platform maintainer has comments.
> > > 
> > > If you already ran DT checks and didn't see these error(s), then
> > > make sure dt-schema is up to date:
> > > 
> > >   pip3 install dtschema --upgrade
> > > 
> > > 
> > > New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-catalina.dtb' for 20240726-potin-catalina-dts-v5-0-8f02305af527 at gmail.com:
> > > 
> > > 
> > ...
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 2/pwm at 21: failed to match any schema with compatible: ['maxim,max31790']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 2/pwm at 27: failed to match any schema with compatible: ['maxim,max31790']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 3/vrm at 60: failed to match any schema with compatible: ['isil,raa228004']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 3/vrm at 61: failed to match any schema with compatible: ['isil,raa228004']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 100/i2c-mux at 70/i2c at 3/vrm at 62: failed to match any schema with compatible: ['isil,raa228004']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus at 1e78a000/i2c at 400/ipmb at 10: failed to match any schema with compatible: ['ipmb-dev']
> > ...
> > 
> > The snipped errors are mostly from the DTSI, but these errors above are
> > specific to your DTS. Can you please address them?
> > 
> > Andrew
> 
> Hi Andrew,
> 
> I tried to follow exist dts files to add the compatible strings, but
> all of them are showing error when I manual running "make ARCH=arm
> CHECK_DTBS=y aspeed/aspeed-bmc-facebook-catalina.dtb".
> 
> - "ipmb-dev": arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts at line 432
> - "max31790": arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts at line 196
> - "maxim,max31790": arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
> at line 511
> - "isil,raa229004": arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
> at line 512
> 
> And there is no .yaml file for these drivers to check the proper
> compatible string.
> Do you have any suggestions in this case? Thank you.

Yes, please don't add any more cases of these warnings :)

Either get the bindings merged for these devices, or drop these nodes
from your devicetree (... and add them back later once the bindings are
merged).

Cheers,

Andrew
