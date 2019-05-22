From: Brandon Wyman <bjwyman@gmail.com>
Date: Tue, 21 May 2019 19:25:16 -0500
Subject: [PATCH dev-5.1] ARM: dts: aspeed: swift: Add pca9539 devices
In-Reply-To: <CAK_vbW2474g00xqoNU-Qd5DJ31mk5vcQvcr1GKxL8mGZ-Dqxfw@mail.gmail.com>
References: <1558383435-38811-1-git-send-email-anoo@linux.ibm.com>
 <CAK_vbW2474g00xqoNU-Qd5DJ31mk5vcQvcr1GKxL8mGZ-Dqxfw@mail.gmail.com>
Message-ID: <CAK_vbW1fodzoYBAtqFg9w3i+kK5W3Yt4GczxukSfMHN80rku9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 21, 2019 at 7:23 PM Brandon Wyman <bjwyman@gmail.com> wrote:
>
> On Mon, May 20, 2019 at 3:17 PM Adriana Kobylak <anoo@linux.ibm.com> wrote:
> >
> > From: Adriana Kobylak <anoo@us.ibm.com>
> >
> > Add the pca9539 devices to the Swift device tree.
> >
> > Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>

Reviewed-by: Brandon Wyman <bjwyman@gmail.com>

> > ---
> >  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 146 +++++++++++++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> > index 9610637..270c923 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
> > @@ -732,6 +732,79 @@
> >                 compatible = "infineon,ir35221";
> >                 reg = <0x72>;
> >         };
> > +
> > +       pca2: pca9539 at 74 {
> > +               compatible = "nxp,pca9539";
> > +               reg = <0x74>;
>
> This looks like the right bus, address, and chip/compatible type, but
> what follows after I am not 100% certain on. I do not know the
> specifics of how to indicate these are input GPIO pins.
>
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               gpio at 0 {
> > +                       reg = <0>;
> > +               };
> > +
> > +               gpio at 1 {
> > +                       reg = <1>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +               };
> > +
> > +               gpio at 8 {
> > +                       reg = <8>;
> > +               };
> > +
> > +               gpio at 9 {
> > +                       reg = <9>;
> > +               };
> > +
> > +               gpio at 10 {
> > +                       reg = <10>;
> > +               };
> > +
> > +               gpio at 11 {
> > +                       reg = <11>;
> > +               };
> > +
> > +               gpio at 12 {
> > +                       reg = <12>;
> > +               };
> > +
> > +               gpio at 13 {
> > +                       reg = <13>;
> > +               };
> > +
> > +               gpio at 14 {
> > +                       reg = <14>;
> > +               };
> > +
> > +               gpio at 15 {
> > +                       reg = <15>;
> > +               };
> > +       };
> >  };
> >
> >  &i2c10 {
> > @@ -756,6 +829,79 @@
> >                 compatible = "infineon,ir35221";
> >                 reg = <0x72>;
> >         };
> > +
> > +       pca3: pca9539 at 74 {
> > +               compatible = "nxp,pca9539";
> > +               reg = <0x74>;
>
> This looks like the correct bus, address, and type as well, but again,
> not sure on how to make sure they are GPIO input pins.
>
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               gpio at 0 {
> > +                       reg = <0>;
> > +               };
> > +
> > +               gpio at 1 {
> > +                       reg = <1>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +               };
> > +
> > +               gpio at 8 {
> > +                       reg = <8>;
> > +               };
> > +
> > +               gpio at 9 {
> > +                       reg = <9>;
> > +               };
> > +
> > +               gpio at 10 {
> > +                       reg = <10>;
> > +               };
> > +
> > +               gpio at 11 {
> > +                       reg = <11>;
> > +               };
> > +
> > +               gpio at 12 {
> > +                       reg = <12>;
> > +               };
> > +
> > +               gpio at 13 {
> > +                       reg = <13>;
> > +               };
> > +
> > +               gpio at 14 {
> > +                       reg = <14>;
> > +               };
> > +
> > +               gpio at 15 {
> > +                       reg = <15>;
> > +               };
> > +       };
> >  };
> >
> >  &i2c11 {
> > --
> > 1.8.3.1
> >
