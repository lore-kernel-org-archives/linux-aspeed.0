From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 19 Feb 2021 09:15:27 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_6/6]_ARM:_dts:_aspeed:_rainier:_Add_leds_that_are_o?=
 =?UTF-8?Q?n_optional_PCI_cable_cards?=
In-Reply-To: <14C0B6E9-0724-42FE-89BA-1FA0262B9BBB@linux.vnet.ibm.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
 <1605247168-1028-6-git-send-email-vishwa@linux.vnet.ibm.com>
 <CACPK8XfttMptuYFsocBaj2v4z1vzNjDUfe18FeDcAbmZjWKjfQ@mail.gmail.com>
 <6CFB3D8D-CF5A-4E33-8D57-6A4034DDC49E@linux.vnet.ibm.com>
 <30e6c20b-1f00-4209-960c-8de1d70c8a4e@www.fastmail.com>
 <14C0B6E9-0724-42FE-89BA-1FA0262B9BBB@linux.vnet.ibm.com>
Message-ID: <944d22cc-ea6f-4368-8253-61f9b663dbba@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 15 Feb 2021, at 17:14, vishwanatha subbanna wrote:
> 
> 
> > On 15-Feb-2021, at 4:38 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > 
> > 
> > On Wed, 10 Feb 2021, at 21:46, vishwanatha subbanna wrote:
> >> 
> >> 
> >>> On 16-Nov-2020, at 11:43 AM, Joel Stanley <joel@jms.id.au> wrote:
> >>> 
> >>> On Fri, 13 Nov 2020 at 05:59, Vishwanatha Subbanna
> >>> <vishwa@linux.vnet.ibm.com> wrote:
> >>>> 
> >>>> These are LEDs on the cable cards that plug into PCIE slots.
> >>>> The LEDs are controlled by PCA9552 I2C expander
> >>>> 
> >>>> Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
> >>>> ---
> >>>> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 288 +++++++++++++++++++++++++++
> >>>> 1 file changed, 288 insertions(+)
> >>>> 
> >>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >>>> index 67c8c40..7de5f76 100644
> >>>> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >>>> @@ -696,6 +696,70 @@
> >>>>                      gpios = <&pca4 7 GPIO_ACTIVE_LOW>;
> >>>>              };
> >>>>      };
> >>>> +
> >>>> +       leds-optional-cablecard0 {
> >>> 
> >>> Is it necessary to have separate nodes for each of the different GPIO devices?
> >>> 
> >>> Would it make sense to combine them, or is it better to be separate?
> >>> 
> >>> Andrew, Eddie, Brad: please review this one before I merge it.
> >> 
> >> I answered this in previous patch set.  If I express ?em all in one 
> >> node that is ?leds {", then if any of the GPIO is not seen because of 
> >> not having the card, then the current leds-gpio driver knocks off all 
> >> the ones on which it successfully acquired the GPIOs also, leaving 
> >> nothing.
> > 
> > I'm struggling to follow this sentence. Can you please explain what you're 
> > trying to say in a less colloquial way?
> 
> 
> Okay.. So, let me give a bit of background. We have some cards that are 
> optional. What that means is, if the cards are to be inserted, then the 
> system needs to be brought down to put ?em. Now, there can be N such 
> cards in our system and any of ?em can be populated or none of ?em can 
> be populated depending on what user wants.
> 
> Now, let us assume I put global ?leds { , compatible = "gpio-leds"; ? 
> section and I describe LEDs of all these N cards along with all the 
> other LEDs on the planar, then leds-gpio driver would populate all the 
> entries in /sys/class/leds/ __if__ all of the N cards that I mentioned 
> are plugged in and their GPIOs can be detected.
> 
> However, take for instance where 1 or more of those cards are not 
> plugged in, then, because there is a failure in detecting those GPIOs, 
> leds-gpio driver will
> discard all other LEDs on which it could successfully acquire the 
> GPIOs. So, there will not be anything in ?/sys/class/leds?. So, the way 
> it works is : either -all- or -none-.

Right.

So what's happening is we're using the static description of the hardware in 
the devicetree to describe non-static data. That makes the patch a bit of a 
hack. I'm not terribly enthused about it. Reliance on a specific probe 
behaviour of the leds-gpio driver is not ideal.

The alternative is runtime device creation and driver binding, but then we have 
issues describing the device configuration to the kernel. For LED configuration 
I don't think that's a solved problem, but I'm keen for others to weigh in with 
ideas here.

I think where I land is the devicetree approach is quite distasteful, but 
pragmatic?

I'm torn so I'm going to punt to the maintainer.

Andrew
