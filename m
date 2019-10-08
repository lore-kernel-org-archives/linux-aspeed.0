From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Oct 2019 04:54:47 +0000
Subject: [PATCH 0/7] pinctrl: Fixes for AST2600 support
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
Message-ID: <CACPK8XeKx_W0_b6ZLJzVdtQQOL8eZ3FcscB5TZT5NXMwRi4r6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2019 at 04:41, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series resolves several issues found in testing by Johnny Huang from
> ASPEED, who also contributed the patches to fix them. We'll have more patches
> from him in the near future (which I'm pretty happy about).

For the series:

Reviewed-by: Joel Stanley <joel@jms.id.au>

These patches have been in the OpenBMC tree for a while and look good.

Cheers,

Joel

>
> The major issue resolved is the way I grouped the eMMC pins. What I had was
> ugly and I want to get rid of it before the binding is solidified with the 5.4
> release.
>
> The remaining fixes are minor issues that stem from lack of documentation or
> understanding on my part, and at least one brain-fart.
>
> Please review!
>
> Andrew
>
> Andrew Jeffery (4):
>   dt-bindings: pinctrl: aspeed-g6: Rework SD3 function and groups
>   pinctrl: aspeed-g6: Sort pins for sanity
>   pinctrl: aspeed-g6: Fix I2C14 SDA description
>   pinctrl: aspeed-g6: Make SIG_DESC_CLEAR() behave intuitively
>
> Johnny Huang (3):
>   pinctrl: aspeed-g6: Fix I3C3/I3C4 pinmux configuration
>   pinctrl: aspeed-g6: Fix UART13 group pinmux
>   pinctrl: aspeed-g6: Rename SD3 to EMMC and rework pin groups
>
>  .../pinctrl/aspeed,ast2600-pinctrl.yaml       |  86 ++++++------
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    | 124 ++++++++----------
>  drivers/pinctrl/aspeed/pinmux-aspeed.h        |   3 +-
>  3 files changed, 98 insertions(+), 115 deletions(-)
>
> --
> 2.20.1
>
