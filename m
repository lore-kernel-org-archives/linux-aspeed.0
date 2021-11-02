From: Corey Minyard <minyard@acm.org>
Date: Tue, 2 Nov 2021 07:22:41 -0500
Subject: [PATCH -next 0/4] Add LCLK control into Aspeed LPC sub drivers
In-Reply-To: <CACPK8XfBi+jY5ftLqsEVXHe01SQBNpTSwo+WtXN3=YUQnXACtw@mail.gmail.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <CACPK8XfBi+jY5ftLqsEVXHe01SQBNpTSwo+WtXN3=YUQnXACtw@mail.gmail.com>
Message-ID: <20211102122241.GK4667@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 01, 2021 at 11:36:38PM +0000, Joel Stanley wrote:
> On Mon, 1 Nov 2021 at 23:18, <jae.hyun.yoo@intel.com> wrote:
> >
> > From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >
> > Hello all,
> >
> > This series is for appliying below fix to all Aspped LPC sub drivers.
> > https://lore.kernel.org/all/20201208091748.1920-1-wangzhiqiang.bj at bytedance.com/
> >
> > An LPC sub driver can be enabled without using the lpc-ctrl driver or it
> > can be registered ahead of lpc-ctrl depends on each system configuration and
> > this difference introduces that LPC can be enabled without heart beating of
> > LCLK so it causes improper handling on host interrupts when the host sends
> > interrupts in that time frame. Then kernel eventually forcibly disables the
> > interrupt with dumping stack and printing a 'nobody cared this irq' message
> > out.
> >
> > To prevent this issue, all LPC sub drivers should enable LCLK individually
> > so this patch adds clock control logic into the remaining Aspeed LPC sub
> > drivers.
> 
> Thanks for sending this out!
> 
> This will resolve a few of the issues we have in the issue tracker:
> 
> https://github.com/openbmc/linux/issues/210
> https://github.com/openbmc/linux/issues/130
> 
> The patches look good to me. I think you've just missed Corey's PR for
> v5.16, but I will stick them in the openbmc tree once they've had a
> review.

We can still get them in to 5.16 if it's important for that; this is a
bug fix, after all, and it's early.  I just need to know the urgency.

Get the Reviewed-by's in and add the bindings and I can get it into the
next tree for a bit, then I can submit.  We may be in rc1 by then, but
that's ok.

-corey

> 
> Cheers,
> 
> Joel
> 
> >
> > Please review this series.
> >
> > Thanks,
> > Jae
> >
> > Jae Hyun Yoo (4):
> >   ARM: dts: aspeed: add LCLK setting into LPC IBT node
> >   ipmi: bt: add clock control logic
> >   ARM: dts: aspeed: add LCLK setting into LPC KCS nodes
> >   ipmi: kcs_bmc_aspeed: add clock control logic
> >
> >  arch/arm/boot/dts/aspeed-g4.dtsi   |  1 +
> >  arch/arm/boot/dts/aspeed-g5.dtsi   |  5 +++++
> >  arch/arm/boot/dts/aspeed-g6.dtsi   |  5 +++++
> >  drivers/char/ipmi/bt-bmc.c         | 24 ++++++++++++++++++++++-
> >  drivers/char/ipmi/kcs_bmc_aspeed.c | 31 ++++++++++++++++++++++++++----
> >  5 files changed, 61 insertions(+), 5 deletions(-)
> >
> > --
> > 2.25.1
> >
