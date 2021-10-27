From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Wed, 27 Oct 2021 14:05:45 +0300
Subject: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
In-Reply-To: <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
References: <20211026200058.2183-1-aladyshev22@gmail.com>
 <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
Message-ID: <CACSj6VVTFa0t9WK=R2TucG7eFqUzBsWYFzvsaRt6eXOiFuQORA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for the comments. Can I ask you some questions about this
`device-tree-gpio-naming.md`?

1) First of all in my naming I've tried to use naming scheme the same
as the EthanolX CRB DTS currently has
(https://github.com/torvalds/linux/blob/d25f27432f80a800a3592db128254c8140bd71bf/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts#L102).
Do you want me to change GPIO naming in the EthanolX CRB as well?
2) Also this naming comes from the signal names in the board
schematics. This way it is clear to check schematics vs DTS. If we use
this OpenBMC naming style, we will lose that correspondence. Is it
really good?
3) In the initial version of the DTS file I've supplied only a minimal
set of GPIO, that are used by OpenBMC. GPIOs for x86-power-control app
and led id/fault gpios. With renaming these GPIOs I'm only sure about
these GPIOs:

FAULT_LED                  - led-fault
CHASSIS_ID_BTN        - led-identify

What about the rest? For example the document doesn't really state
what the *-button postfix states? Is it for asserting or monitoring
buttons? How should I name these signals?

ASSERT_BMC_READY
ASSERT_RST_BTN
ASSERT_PWR_BTN

MON_P0_RST_BTN
MON_P0_PWR_BTN
MON_P0_PWR_GOOD
MON_PWROK

Can you help me with those?

4) And what should I do to the board GPIO signals that OpenBMC doesn't
use? If you look at the EthanolX CRB DTS
(https://github.com/torvalds/linux/blob/d25f27432f80a800a3592db128254c8140bd71bf/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts#L102)
it has a ton of GPIOs. Should they be renamed to this OpenBMC style as
well? Or can they be named exactly like in the schematics?

I've also CCed original author of the `device-tree-gpio-naming.md`
document Andrew Geissler. Andrew, can you please provide your opinion
on the subject?

Best regards,
Konstantin Aladyshev

On Wed, Oct 27, 2021 at 12:03 AM Joel Stanley <joel@jms.id.au> wrote:
>
> Hello Konstantin,
>
> On Tue, 26 Oct 2021 at 20:01, Konstantin Aladyshev
> <aladyshev22@gmail.com> wrote:
> >
> > Add initial version of device tree for the BMC in the AMD DaytonaX
> > platform.
> >
> > AMD DaytonaX platform is a customer reference board (CRB) with an
> > Aspeed ast2500 BMC manufactured by AMD.
> >
> > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
>
> This looks good. I have one comment about the GPIOs below.
>
> > +&gpio {
> > +       status = "okay";
> > +       gpio-line-names =
> > +       /*A0-A7*/       "","","FAULT_LED","","","","","",
> > +       /*B0-B7*/       "","","","","","","","",
> > +       /*C0-C7*/       "CHASSIS_ID_BTN","","","","","","","",
> > +       /*D0-D7*/       "","","ASSERT_BMC_READY","","","","","",
> > +       /*E0-E7*/       "MON_P0_RST_BTN","ASSERT_RST_BTN","MON_P0_PWR_BTN","ASSERT_PWR_BTN","",
> > +                       "MON_P0_PWR_GOOD","MON_PWROK","",
>
> For systems that will run openbmc, we try to use naming conventions
> from this document:
>
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> If a GPIO is missing from that doc I encourage you to add it.
