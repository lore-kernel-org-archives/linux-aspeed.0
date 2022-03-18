From: Joel Stanley <joel@jms.id.au>
Date: Fri, 18 Mar 2022 06:18:50 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
In-Reply-To: <87fsngxnff.wl-maz@kernel.org>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
 <87h77wxslh.wl-maz@kernel.org>
 <20220317211024.GA99538@9a2d8922b8f1> <87fsngxnff.wl-maz@kernel.org>
Message-ID: <CACPK8Xdv4bG=Haz5oe+gHotQ_B7=bMbZE3fNnHs-Ezy7Yje6Jg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 17 Mar 2022 at 21:46, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 17 Mar 2022 21:10:24 +0000,
> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:

> > >
> > > >
> > > > Moreover, clocks also matches incorrectly with the regex pattern.
> > > > Remove this entry altogether to fix it.
> > > > 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >
> > > NAK. That's not a reason to randomly butcher things.
> >
> > I hope I explained my reasons above.
>
> My position on this sort of change remains. Blindly changing existing
> DTs based on a warning provided by a tool that totally ignores the
> reality of what is out there is not acceptable.

Thanks Marc for stating this. I share this view; we shouldn't go
around deleting parts of device trees for the sake of the bindings.
It's been happening across the tree, and I think it's to the detriment
of the supported hardware.

In the case of this particular change: I suspect this property was
there for early bringup, before the firmware was in place to configure
CNTFRQ. Looking back in time we had:

 clock-frequency = <25000000>;
 arm,cpu-registers-not-fw-configured;

I'm not sure why that changed from clock-frequency to clocks when the
device tree was mainlined.

That was bringup. These days, the vendor u-boot programs CNTFRQ with a
value for the system. This code is also in mainline u-boot, so as long
as you're running one of those firmwares the standard method will
work.

The qemu model also sets CNTFRQ, so loading the kernel without going
through u-boot will be fine there too.

Given that, I think we can go ahead with removing the property in this case.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll take the patch through my aspeed tree.

Cheers,

Joel
