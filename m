From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 10 Jun 2021 10:24:19 +0800
Subject: [PATCH v5 00/10] ASPEED sgpio driver enhancement.
In-Reply-To: <CACRpkdZOStr+K9U9QTkAcsk4NxuSqBRVv_-9_VkGJbT69iSxmQ@mail.gmail.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <CACRpkdZOStr+K9U9QTkAcsk4NxuSqBRVv_-9_VkGJbT69iSxmQ@mail.gmail.com>
Message-ID: <20210610022416.GA27188@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 06/09/2021 18:54, Linus Walleij wrote:
> On Tue, Jun 8, 2021 at 12:26 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
> 
> > AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> > with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
> > supports up to 80 pins.
> > In the current driver design, the max number of sgpio pins is hardcoded
> > in macro MAX_NR_HW_SGPIO and the value is 80.
> >
> > For supporting sgpio master interfaces of AST2600 SoC, the patch series
> > contains the following enhancement:
> > - Convert txt dt-bindings to yaml.
> > - Update aspeed-g6 dtsi to support the enhanced sgpio.
> > - Define max number of gpio pins in ast2600 platform data. Old chip
> >   uses the original hardcoded value.
> > - Support muiltiple SGPIO master interfaces.
> > - Support up to 128 pins.
> > - Support wdt reset tolerance.
> > - Fix irq_chip issues which causes multiple sgpio devices use the same
> >   irq_chip data.
> > - Replace all of_*() APIs with device_*().
> >
> > Changes from v4:
> 
> v5 looks good to me!
> 
> I just need Rob's or another DT persons nod on the bindings (or timeout)
> before I merge it. Poke me if nothing happens.
> 
> >   ARM: dts: aspeed-g6: Add SGPIO node.
> >   ARM: dts: aspeed-g5: Remove ngpios from sgpio node.
> 
> These two need to be merged through the SoC tree, the rest I will handle.
> 
Hi Linus, Andrew,

Per the comment in the following mail
https://lkml.org/lkml/2021/6/9/317

I was wondering if I should prepare v6 for the currnet solution or
I should drop this patch series then prepare another patch for the
new solution(piar GPIO input/output) which breaks userspace but is
better than the current solution.

Thanks,
Steven

> Yours,
> Linus Walleij
