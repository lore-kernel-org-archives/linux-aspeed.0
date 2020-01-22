From: Joel Stanley <joel@jms.id.au>
Date: Wed, 22 Jan 2020 00:26:38 +0000
Subject: [External] Re: [PATCH v1 1/1] ARM: dts: aspeed: update Hr855xg2
 device tree
In-Reply-To: <85dc718f42f54d40ad50853c047ec3ae@lenovo.com>
References: <1577350475-127530-1-git-send-email-pengms1@lenovo.com>
 <CACPK8XeY5dPHtRfFD55dLVHT0SF1gJEVf1DixsbJKpciLP2s5Q@mail.gmail.com>
 <85dc718f42f54d40ad50853c047ec3ae@lenovo.com>
Message-ID: <CACPK8XctO0SraKF_0Z40S_bBjz_ooQacpej3tMxwTq6XD90DGg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2020 at 08:07, Andrew MS1 Peng <pengms1@lenovo.com> wrote:
>
> Hi Joel,
>
> Please help to check below my comments. Thanks.
>
> Regards,
> Andrew Peng
>
> > -----????-----
> > ???: Joel Stanley <joel@jms.id.au>
> > ????: 2020?1?6? 14:48
> > ???: Andrew MS1 Peng <pengms1@lenovo.com>
> > ??: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Andrew Jeffery <andrew@aj.id.au>; devicetree
> > <devicetree@vger.kernel.org>; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Benjamin Fair <benjaminfair@google.com>;
> > OpenBMC Maillist <openbmc@lists.ozlabs.org>; Derek Lin23
> > <dlin23@lenovo.com>; Yonghui YH21 Liu <liuyh21@lenovo.com>
> > ??: [External] Re: [PATCH v1 1/1] ARM: dts: aspeed: update Hr855xg2
> > device tree
> >
> > On Thu, 26 Dec 2019 at 08:54, Andrew Peng <pengms1@lenovo.com> wrote:
> > >
> >
> > When you have a list of things like below, it's sometimes a good hint that you
> > should be sending one patch for each bullet point. This makes it easier to
> > review.
> >
>
> Should I separate below changes to six patches for next patch version?
> For example: [PATCH v2 0/5]  [PATCH v2 1/5] ...etc

It's up to you.

I do not require it.

>
> > > Update i2c aliases.
> > > Change flash_memory mapping address and size.
> > > Add in a gpio-keys section.
> > > Enable vhub, vuart, spi1 and spi2.
> > > Add raa228006, ir38164 and sn1701022 hwmon sensors.
> > > Remove some unuse gpio from gpio section.
> >
> > unused?
> >
>
> It was my mistake, the correct sentence should be "Remove gpio from gpio section since it controlled by user space."
>
> > >
> > > Signed-off-by: Andrew Peng <pengms1@lenovo.com>
> > > Signed-off-by: Derek Lin <dlin23@lenovo.com>
> > > Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>
> >
> > I got two copies of this. I think they are the same.
> >
>
> I apologize to send twice.
>
> > > ---
> > > v1: initial version
> > >
> > >  arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts | 557
> > > ++++++++++++++++-------
> > >  1 file changed, 382 insertions(+), 175 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > index 8193fad..e1386d4 100644
> > > --- a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > +++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
> > > @@ -15,14 +15,21 @@
> > >         compatible = "lenovo,hr855xg2-bmc", "aspeed,ast2500";
> > >
> >
> > > -               flash_memory: region at 98000000 {
> > > +               flash_memory: region at 9EFF0000 {
> > >                         no-map;
> > > -                       reg = <0x98000000 0x00100000>; /* 1M */
> > > +                       reg = <0x9EFF0000 0x00010000>; /* 64K */
> >
> > Do you really use 64K here, or was this a workaround for the lpc-ctlr driver
> > requiring a memory region?
> >
>
> We reserve 64K for L2A In-Band Firmware Update (phosphor-ipmi-flash).

Okay, thanks for clarifying.

I am happy with rest of your responses. Please send v2 with these things fixed.

Cheers,

Joel
