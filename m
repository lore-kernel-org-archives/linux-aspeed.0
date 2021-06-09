From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Jun 2021 12:54:37 +0200
Subject: [PATCH v5 00/10] ASPEED sgpio driver enhancement.
In-Reply-To: <20210608102547.4880-1-steven_lee@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdZOStr+K9U9QTkAcsk4NxuSqBRVv_-9_VkGJbT69iSxmQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 8, 2021 at 12:26 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
> supports up to 80 pins.
> In the current driver design, the max number of sgpio pins is hardcoded
> in macro MAX_NR_HW_SGPIO and the value is 80.
>
> For supporting sgpio master interfaces of AST2600 SoC, the patch series
> contains the following enhancement:
> - Convert txt dt-bindings to yaml.
> - Update aspeed-g6 dtsi to support the enhanced sgpio.
> - Define max number of gpio pins in ast2600 platform data. Old chip
>   uses the original hardcoded value.
> - Support muiltiple SGPIO master interfaces.
> - Support up to 128 pins.
> - Support wdt reset tolerance.
> - Fix irq_chip issues which causes multiple sgpio devices use the same
>   irq_chip data.
> - Replace all of_*() APIs with device_*().
>
> Changes from v4:

v5 looks good to me!

I just need Rob's or another DT persons nod on the bindings (or timeout)
before I merge it. Poke me if nothing happens.

>   ARM: dts: aspeed-g6: Add SGPIO node.
>   ARM: dts: aspeed-g5: Remove ngpios from sgpio node.

These two need to be merged through the SoC tree, the rest I will handle.

Yours,
Linus Walleij
