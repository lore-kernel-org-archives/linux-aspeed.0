From: Patrick Williams <patrick@stwcx.xyz>
Date: Thu, 4 Nov 2021 04:30:14 -0500
Subject: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <HKAPR04MB40039608E14195D859DE7EC5968D9@HKAPR04MB4003.apcprd04.prod.outlook.com>
References: <20211103071417.388388-1-howard.chiu@quantatw.com>
 <YYKatBCCroiYxLew@heinlein>
 <HKAPR04MB40039608E14195D859DE7EC5968D9@HKAPR04MB4003.apcprd04.prod.outlook.com>
Message-ID: <YYOoJgXyOdgNmI6B@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 04, 2021 at 03:30:08AM +0000, Howard Chiu (???) wrote:

> > Is this board using 64MB or 128MB modules?  Many of the newer systems
> > have been
> > starting to use 128MB.  I just want to confirm this is correct.
> 1Gb SPI flash, MX66L1G45GMI-08G

1Gb = 1024Mb / 8 = 128MB, right?  Shouldn't we use the 128MB layout?

> > > +	sled0_ioexp: pca9539 at 76 {
> > > +		compatible = "nxp,pca9539";
> > > +		reg = <0x76>;
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		gpio-controller;
> > > +		#gpio-cells = <2>;
> > > +
> > > +		gpio-line-names =
> > > +
> > 	"","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_
> > ALERT",
> > > +
> > 	"SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
> > > +
> > 	"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_D
> > IR","SLED0_MD_DECAY",
> > > +
> > 	"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED
> > 0_AC_PWR_EN";
> > 
> > In general, in OpenBMC, we have a preference for the GPIOs to not be
> > schematic
> > names but to be named based on their [software-oriented] function.  Please
> > take
> > a look at:
> > 
> > 
> > https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-na
> > ming.md
> > 
> > Any function you see that isn't documented there we should try to get
> > documented
> > before fixing the GPIO name to match it.
> > 
> I intend to delete them for now if I have to document them first, because 
> most of them are platform-specific GPIO, not for general purpose and also not
> suitable to current OpenBMC.
> For example, OpenBMC believes there is only one GPIO to be used to power on 
> the chassis, but Bletchley has six.
> I define gpio-line-names for gpioset/geioget/phosphor-multi-gpio-monitor
> usage, and they can be replaced with gpiochip number and offset instead.
> The disadvantage is that they won't be human-friendly when TEs develop their tool to test these GPIOs.
> > > +		gpio-line-names =
> > > +		"SLED0_EMBER_LED","SLED0_BLUE_LED","SLED0_RST_IOEXP","",

Deleting them entirely sounds even less desirable.  If these were just for
humans, then having a schematic name is better than nothing.  But when you
suggest their usage to be "TEs develop their tool to test these GPIOs" that
seems to indicate this becomes ABI and we want stable, documented names, to
limit the churn on users.

I don't believe the gpiochip/pin numbers are considered stable ABI.  Our team
has previously had to do an abstraction between 4.x and 5.x kernel because of
changes in that space.

My initial preference would be that you leave them in as schematic names, for
human purposes, until you start using them in code at which point they should be
well-documented and using the style we've set out in the document above.

Re: "OpenBMC believes there is only one GPIO to be used to power on the chassis,
but Bletchley has six."... This does not make it system-specific.  Yosemite-v2
has 4 independently managed systems, with their own power sequencing.  There
should be work going on by that team to expand the GPIO documentation to cover N
sub-chassis as well; it just might be that you are ahead of them in documenting
it.

It should be trivial to expand the `power-chassis-control` and
`power-chassis-good` documentation to support sub-chassis.  I can do this for
you if you need.  Many of your GPIOs were related to LEDs which are also already
covered by this doc (except might need minor wording for sub-chassis as well).
Can you let me know which other GPIO functions you think you'll need that aren't
already in that document and we can work to get them added?

> > > +&i2c13 {
> > > +	multi-master;
> > > +	aspeed,hw-timeout-ms = <1000>;
> > > +	status = "okay";
> > > +};
> > 
> > Was this intentional to have defined a multi-master bus with nothing on it?
> There is a OCP debug card which is a hot plugging device.
> We only need to specify this bus with "multi-mater" property for IPMB support.

Got it.

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211104/4d740d18/attachment.sig>
