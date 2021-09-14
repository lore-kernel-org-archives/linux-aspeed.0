From: George Liu <liuxiwei1013@gmail.com>
Date: Tue, 14 Sep 2021 16:55:55 +0800
Subject: [PATCH] ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding
In-Reply-To: <CACPK8XfbJbU8zPzTri3o+zbSf82iUuGUXmFL5TwsdPHKLnTNTQ@mail.gmail.com>
References: <20210819055227.140980-1-liuxiwei@inspur.com>
 <CANFuQ7A5jLXftmfLn_W93MuDF8heL88BPQRL_rkYk+bj0_Db0w@mail.gmail.com>
 <CACPK8XfbJbU8zPzTri3o+zbSf82iUuGUXmFL5TwsdPHKLnTNTQ@mail.gmail.com>
Message-ID: <CANFuQ7A6xbM571ds+aq-QUmLxUZ-FUjKukPqGV-irt8X_j=fkw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks!

On Tue, Sep 14, 2021 at 4:45 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 14 Sept 2021 at 08:16, George Liu <liuxiwei1013@gmail.com> wrote:
> >
> > Hey Joel:
> > do you have any comments at this patch?
> >
> > Thx -- George Liu
> >
> > On Thu, Aug 19, 2021 at 1:52 PM George Liu <liuxiwei1013@gmail.com> wrote:
> > >
> > > Signed-off-by: George Liu <liuxiwei@inspur.com>
>
> It looks okay to me.
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> I have applied it for 5.16.
>
> > > ---
> > >  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > > index 1752f3250e44..d0c3acbf6c8c 100644
> > > --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > > +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > > @@ -3,6 +3,7 @@
> > >  #include "aspeed-g5.dtsi"
> > >  #include <dt-bindings/gpio/aspeed-gpio.h>
> > >  #include <dt-bindings/leds/leds-pca955x.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > >
> > >  / {
> > >         model = "FP5280G2 BMC";
> > > @@ -902,4 +903,10 @@ fan at 7 {
> > >
> > >  };
> > >
> > > +&kcs3 {
> > > +       status = "okay";
> > > +       aspeed,lpc-io-reg = <0xca2>;
> > > +       aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > > +};
> > > +
> > >  #include "ibm-power9-dual.dtsi"
> > > --
> > > 2.30.2
> > >
