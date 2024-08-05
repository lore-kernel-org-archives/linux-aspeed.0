From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 05 Aug 2024 13:29:09 +0930
Subject: [PATCH 0/6] Update the device tree for Ampere's BMC platform
In-Reply-To: <1c2dca43-444d-44a7-b304-5fbd59b788a8@amperemail.onmicrosoft.com>
References: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
	 <172252600912.120761.16384387883905749466.robh@kernel.org>
	 <1c2dca43-444d-44a7-b304-5fbd59b788a8@amperemail.onmicrosoft.com>
Message-ID: <6171be101ee10aa2a11e021caafe877eb428412a.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2024-08-03 at 10:49 +0700, Chanh Nguyen wrote:
> 
> On 01/08/2024 22:29, Rob Herring (Arm) wrote:
> > 
> > On Thu, 01 Aug 2024 09:12:10 +0000, Chanh Nguyen wrote:
> > > Updates the device tree to support some features on Ampere's
> > > Mt.Mitchell BMC and Ampere's Mt.Jade BMC.
> > > 
> > > Chanh Nguyen (6):
> > >    ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
> > >    ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
> > >    ARM: dts: aspeed: mtmitchell: Add I2C Riser card alias ports
> > >    ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
> > >    ARM: dts: aspeed: mtmitchell: Add LEDs
> > >    ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers
> > > 
> > >   .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
> > >   .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 152 ++++++++++++++++++
> > >   2 files changed, 168 insertions(+)
> > > 
> > > --
> > > 2.43.0
> > > 
> > > 
> > > 
> > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >    pip3 install dtschema --upgrade
> > 
> > 
> > New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtjade.dtb aspeed/aspeed-bmc-ampere-mtmitchell.dtb' for 20240801091217.1408809-1-chanh at os.amperecomputing.com:
> > 
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/apb/bus at 1e78a000/i2c at 480/fan-controller0 at 20: failed to match any schema with compatible: ['maxim,max31790']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/apb/bus at 1e78a000/i2c at 480/fan-controller1 at 2f: failed to match any schema with compatible: ['maxim,max31790']
> > 
> > 
> 
> Thank Rob for your review!
> 
> I am aware of the new warnings you mentioned. For more information, the 
> schema binding of "maxim,max31790" is being progressed by other series? 
> https://lore.kernel.org/lkml/20240414042246.8681-2-chanh at os.amperecomputing.com/ 
> 

For now can you please remove the `maxim,max31790` nodes from your
devicetree and re-send? As it stands you've been asked to rework what
you proposed in the thread that you linked, and a quick look at the
hwmon trees suggests support for the max31790 hasn't been merged.

You can send a follow-up patch adding the nodes to your devicetree once
the binding has been merged.

Andrew
