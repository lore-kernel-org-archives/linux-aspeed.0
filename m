From: Chia Hsing Yin <peteryin.openbmc@gmail.com>
Date: Tue, 16 Apr 2024 00:03:08 +0800
Subject: [PATCH v5 00/12] Revise Meta(Facebook) Harma BMC(AST2600)
In-Reply-To: <3eb80a2f21a96cc0fc275db60631f673bb14e77f.camel@codeconstruct.com.au>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com> <3eb80a2f21a96cc0fc275db60631f673bb14e77f.camel@codeconstruct.com.au>
Message-ID: <CAPSyxFRj0twCJG6Lr5UZpznrUHyd_L0Reo=kZSFwCw3FNQ+x+A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sure thing, I will base on version 5 for future modifications.

Thanks.

On Mon, Apr 15, 2024 at 10:00?AM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Fri, 2024-04-12 at 17:15 +0800, Peter Yin wrote:
> > Summary:
> > Revise linux device tree entry related to Meta(Facebook) Harma
> > specific devices connected to BMC(AST2600) SoC.
> >
> > Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw at mail.gmail.com/
> >
> > Change log:
> >
> > v4 -> v5
> >   - Patch 0011 - Add retimer device
> >   - Patch 0012 - Modify gpio line name
> >
> > v3 -> v4
> >   - Patch 0010 - Revise node name
> >   - fixed PDB temperature node name in Patch 0006
> >
> > v2 -> v3
> >   - Patch 0007 - Revise max31790 address
> >   - Patch 0008 - Harma: Add NIC Fru device
> >   - Patch 0009 - Add ltc4286 device
> >
> > v1 -> v2
> >   - Add infineon,slb9670 information for tpm.
> >   - Patch 0006 - Add PDB temperature.
> >
> > v1
> >   - Patch 0001 - Revise SGPIO line name.
> >   - Patch 0002 - Mapping ttyS2 to UART4.
> >   - Patch 0003 - Remove Vuart.
> >   - Patch 0004 - Add cpu power good line name.
> >   - Patch 0005 - Add spi-gpio.
> >
> > Peter Yin (12):
> >   ARM: dts: aspeed: Harma: Revise SGPIO line name.
> >   ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
> >   ARM: dts: aspeed: Harma: Remove Vuart
> >   ARM: dts: aspeed: Harma: Add cpu power good line name
> >   ARM: dts: aspeed: Harma: Add spi-gpio
> >   ARM: dts: aspeed: Harma: Add PDB temperature
> >   ARM: dts: aspeed: Harma: Revise max31790 address
> >   ARM: dts: aspeed: Harma: Add NIC Fru device
> >   ARM: dts: aspeed: Harma: Add ltc4286 device
> >   ARM: dts: aspeed: Harma: Revise node name
> >   ARM: dts: aspeed: Harma: Add retimer device
> >   ARM: dts: aspeed: Harma: Modify GPIO line name
> >
> >  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 107 ++++++++++++++----
> >  1 file changed, 85 insertions(+), 22 deletions(-)
> >
>
> Joel had applied an earlier version of this series to his for-next
> branch. I'm collecting patches targeting it while he's on leave. I've
> updated the series he'd applied to the v5 you've posted here.
>
> Can you please post any further changes as patches on top? You can find
> my branch here:
>
> https://github.com/amboar/linux/tree/for/bmc/dt-6.10
>
> Andrew
