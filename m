From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 12:04:01 +0930
Subject: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta
 Yosemite4
In-Reply-To: <172589661042.199175.14634437656639420015.robh@kernel.org>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
	 <172589661042.199175.14634437656639420015.robh@kernel.org>
Message-ID: <39630cb9cf923eec6d8e229aea4e6fc5980aa73e.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ricky,

On Mon, 2024-09-09 at 10:45 -0500, Rob Herring (Arm) wrote:
> On Mon, 09 Sep 2024 18:54:15 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > 
...
> > 
> > Ricky CX Wu (3):
> >   ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
> >   ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
> >   ARM: dts: aspeed: yosemite4: add fan led config
> > 
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 706 ++++++++++++++++--
> >  1 file changed, 660 insertions(+), 46 deletions(-)
> > 
> > --
> > 2.25.1
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-yosemite4.dtb' for 20240909105420.441607-1-Delphine_CC_Chiu at wiwynn.com:
> 
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 20: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 2f: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 780/i2c-mux at 74/i2c at 0/gpio at 61: failed to match any schema with compatible: ['nxp,pca9552']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 20: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm at 2f: '#address-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 780/i2c-mux at 74/i2c at 1/gpio at 61: failed to match any schema with compatible: ['nxp,pca9552']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 0/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 1/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 2/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus at 1e78a000/i2c at 800/i2c-mux at 72/i2c at 3/temperature-sensor at 3c: failed to match any schema with compatible: ['smsc,emc1403']
> 

Please either:

1. Remove the offending nodes from your series so we don't add yet more
warnings, or
2. Write appropriate bindings and send them as part of the series

Regarding 1, you can always update the devicetree to add the nodes
after someone else has got the bindings merged. However, if you must
have the nodes, then you need to do 2.

Thanks,

Andrew
