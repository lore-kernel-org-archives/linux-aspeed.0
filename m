From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 15 Feb 2021 09:38:13 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_6/6]_ARM:_dts:_aspeed:_rainier:_Add_leds_that_are_o?=
 =?UTF-8?Q?n_optional_PCI_cable_cards?=
In-Reply-To: <6CFB3D8D-CF5A-4E33-8D57-6A4034DDC49E@linux.vnet.ibm.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
 <1605247168-1028-6-git-send-email-vishwa@linux.vnet.ibm.com>
 <CACPK8XfttMptuYFsocBaj2v4z1vzNjDUfe18FeDcAbmZjWKjfQ@mail.gmail.com>
 <6CFB3D8D-CF5A-4E33-8D57-6A4034DDC49E@linux.vnet.ibm.com>
Message-ID: <30e6c20b-1f00-4209-960c-8de1d70c8a4e@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 10 Feb 2021, at 21:46, vishwanatha subbanna wrote:
> 
> 
> > On 16-Nov-2020, at 11:43 AM, Joel Stanley <joel@jms.id.au> wrote:
> > 
> > On Fri, 13 Nov 2020 at 05:59, Vishwanatha Subbanna
> > <vishwa@linux.vnet.ibm.com> wrote:
> >> 
> >> These are LEDs on the cable cards that plug into PCIE slots.
> >> The LEDs are controlled by PCA9552 I2C expander
> >> 
> >> Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
> >> ---
> >> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 288 +++++++++++++++++++++++++++
> >> 1 file changed, 288 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >> index 67c8c40..7de5f76 100644
> >> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >> @@ -696,6 +696,70 @@
> >>                        gpios = <&pca4 7 GPIO_ACTIVE_LOW>;
> >>                };
> >>        };
> >> +
> >> +       leds-optional-cablecard0 {
> > 
> > Is it necessary to have separate nodes for each of the different GPIO devices?
> > 
> > Would it make sense to combine them, or is it better to be separate?
> > 
> > Andrew, Eddie, Brad: please review this one before I merge it.
> 
> I answered this in previous patch set.  If I express ?em all in one 
> node that is ?leds {", then if any of the GPIO is not seen because of 
> not having the card, then the current leds-gpio driver knocks off all 
> the ones on which it successfully acquired the GPIOs also, leaving 
> nothing.

I'm struggling to follow this sentence. Can you please explain what you're 
trying to say in a less colloquial way?

> I did speak to the maintainer and it looked like the behaviour 
> was existing since long time and changing it would break old code.
> 

Break how?

Andrew
