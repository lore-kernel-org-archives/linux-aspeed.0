From: Andrew MS1 Peng <pengms1@lenovo.com>
Date: Thu, 9 Jan 2020 08:07:17 +0000
Subject: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWxdICBSZTogW1BBVENIIHYxIDEvMV0gQVJNOiBk?=
 =?utf-8?Q?ts:_aspeed:_update_Hr855xg2_device_tree?=
In-Reply-To: <CACPK8XeY5dPHtRfFD55dLVHT0SF1gJEVf1DixsbJKpciLP2s5Q@mail.gmail.com>
References: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
 <CACPK8XeY5dPHtRfFD55dLVHT0SF1gJEVf1DixsbJKpciLP2s5Q@mail.gmail.com>
Message-ID: <85dc718f42f54d40ad50853c047ec3ae@lenovo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

Please help to check below my comments. Thanks.

Regards,
Andrew Peng

> -----????-----
> ???: Joel Stanley <joel@jms.id.au>
> ????: 2020?1?6? 14:48
> ???: Andrew MS1 Peng <pengms1@lenovo.com>
> ??: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Andrew Jeffery <andrew@aj.id.au>; devicetree
> <devicetree@vger.kernel.org>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Benjamin Fair <benjaminfair@google.com>;
> OpenBMC Maillist <openbmc@lists.ozlabs.org>; Derek Lin23
> <dlin23@lenovo.com>; Yonghui YH21 Liu <liuyh21@lenovo.com>
> ??: [External] Re: [PATCH v1 1/1] ARM: dts: aspeed: update Hr855xg2
> device tree
> 
> On Thu, 26 Dec 2019 at 08:54, Andrew Peng <pengms1@lenovo.com> wrote:
> >
> 
> When you have a list of things like below, it's sometimes a good hint that you
> should be sending one patch for each bullet point. This makes it easier to
> review.
> 

Should I separate below changes to six patches for next patch version?
For example: [PATCH v2 0/5]  [PATCH v2 1/5] ...etc

> > Update i2c aliases.
> > Change flash_memory mapping address and size.
> > Add in a gpio-keys section.
> > Enable vhub, vuart, spi1 and spi2.
> > Add raa228006, ir38164 and sn1701022 hwmon sensors.
> > Remove some unuse gpio from gpio section.
> 
> unused?
> 

It was my mistake, the correct sentence should be "Remove gpio from gpio section since it controlled by user space."

> >
> > Signed-off-by: Andrew Peng <pengms1@lenovo.com>
> > Signed-off-by: Derek Lin <dlin23@lenovo.com>
> > Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>
> 
> I got two copies of this. I think they are the same.
> 

I apologize to send twice.

> > ---
> > v1: initial version
> >
> >  arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts | 557
> > ++++++++++++++++-------
> >  1 file changed, 382 insertions(+), 175 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > index 8193fad..e1386d4 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > @@ -15,14 +15,21 @@
> >         compatible = "lenovo,hr855xg2-bmc", "aspeed,ast2500";
> >
> 
> > -               flash_memory: region at 98000000 {
> > +               flash_memory: region at 9EFF0000 {
> >                         no-map;
> > -                       reg = <0x98000000 0x00100000>; /* 1M */
> > +                       reg = <0x9EFF0000 0x00010000>; /* 64K */
> 
> Do you really use 64K here, or was this a workaround for the lpc-ctlr driver
> requiring a memory region?
> 

We reserve 64K for L2A In-Band Firmware Update (phosphor-ipmi-flash).

> If it's a workaround you can now drop the memory region phandle, as the
> driver works without it.
> 
> > +&spi2 {
> >         status = "okay";
> >         pinctrl-names = "default";
> > -       pinctrl-0 = <&pinctrl_txd1_default
> > -                       &pinctrl_rxd1_default>;
> > +       pinctrl-0 = <&pinctrl_spi2ck_default
> > +                               &pinctrl_spi2cs0_default
> > +                               &pinctrl_spi2miso_default
> > +                               &pinctrl_spi2mosi_default>;
> > +
> > +               spidev at 0 {
> > +                               status = "okay";
> > +                               compatible = "aspeed,spidev";
> > +                               reg = < 0 >;
> > +                               spi-max-frequency = <50000000>;
> > +               };
> 
> This is for an out of tree driver? We discourage that, and prefer you submit the
> driver upstream for review before adding it to the device tree.
> 
> Please drop the sbidev bit from your next version.
> 

I will remove spidev at 0 property in the next version.

> > +
> > +               flash at 0 {
> > +                               compatible = "jedec,spi-nor";
> > +                               m25p,fast-read;
> > +                               label = "fpga";
> > +                               reg = < 0 >;
> > +                               spi-max-frequency = <50000000>;
> > +                               status = "okay";
> > +               };
> >  };
> 
> > +&vuart {
> >         status = "okay";
> > +       auto-flow-control;
> > +       espi-enabled = <&syscon 0x70 25>;
> 
> Is this the same as the upstreamed aspeed,sirq-polarity-sense?
> 

Yes, it is used for sirq-polarity-sense.

> Please review
> https://git.kernel.org/torvalds/c/8d310c9107a2a3f19dc7bb54dd50f70c65ef5
> 409.
> I think you will find you can drop the espi-enabled property as aspeed-g5.dtsi
> now contains the same information.
> 

I will remove espi-enabled property in the next version.

> > +               pcie_slot12: i2c at 4{
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                               reg = <4>;
> > +               };
> > +
> > +               switch0_i2c5:i2c at 5{
> 
> a space after the :
> 

I will revise it.

> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +                               reg = <5>;
> > +                               eeprom at 54 {
> > +                                               compatible =
> "atmel,24c04";
> > +                                               pagesize =
> <16>;
> > +                                               reg = <0x54>;
> > +                               };
> >                 };
> >         };
> >  };
> > @@ -216,13 +377,43 @@
> >         };
> >
> >         VR at 45 {
> > -               compatible = "pmbus";
> > +               compatible = "raa228006";
> 
> Please send this change once you've had your pmbus driver accepted by
> Guneter. In the mean time I suggest dropping it from v2 so we can merge the
> other changes.
> 

I will remove it in the next version.

> >                 reg = <0x45>;
> >         };
> >  };
> >
> 
> > +       CPU0_VCCIN at 60 {
> 
> Convention is to use lower case for node names.
> 

I will drop CPUXX_VCCXX relative property in the next version since it use new pmbus driver, and I will remember to use lower case for node names.

> > +               compatible = "raa228006";
> > +               reg = <0x60>;
> > +       };
> > +
