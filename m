From: Joel Stanley <joel@jms.id.au>
Date: Wed, 5 Apr 2023 01:52:15 +0000
Subject: [PATCH v3 0/3] i3c dw,ast2600: Add a driver for the AST2600 i3c controller
In-Reply-To: <20230331091501.3800299-1-jk@codeconstruct.com.au>
References: <20230331091501.3800299-1-jk@codeconstruct.com.au>
Message-ID: <CACPK8XdLpg2H4a2nHo4PokfBc4r3D8MbK2-62jXkPXAq8Q03Rg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 31 Mar 2023 at 09:15, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> This series adds a new i3c controller driver, for the ASPEED AST2600 i3c
> SoC peripheral. This device is very similar to the dw i3c controller, so
> we implement this by adding a little platform abstraction to the dw
> driver, and then a platform implementation for ast2600.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I have also tested it in qemu.

>
> For those testing at home: there's a couple of prereqs for getting this
> running: we need the ast2600 i3c clocks in their proper configuration,
> as implemented in:
>
>   https://lore.kernel.org/all/20230302005834.13171-1-jk at codeconstruct.com.au/
>
> - this series has been merged to clk-next, but has not hit Linus'
> upstream yet. The series will still build fine without this.
>
> You'll also want the dts definitions for the i3c controller and
> pincontrol setup on the ast2600 platform. I have changes for those in my
> dev/i3c branch:
>
>   https://github.com/CodeConstruct/linux/commits/dev/i3c
>
> - and will send those once we have the driver accepted.

Given we have acks on the bindings, I think it's safe to send the
device tree changes now so we can merge what you have in the upcoming
merge window. If there's changes we can modify or revert.

Cheers,

Joel

>
> v3: expand the prereqs & background above, and implement some feedback
> from review. Mainly: rather that using a platform_data pointer, assume
> platforms will use an encapsulating struct for their platform-specific
> data
>
> v2: This is a rework from an earlier series that implemented this as
> part of the dw driver; I have adopted Ben Dooks' suggestion to split
> into a new driver + exported hooks from the dw base.
>
> As always: comments, queries etc. are most welcome.
>
> Cheers,
>
>
> Jeremy
>
> Jeremy Kerr (3):
>   i3c: dw: Add infrastructure for platform-specific implementations
>   dt-bindings: i3c: Add AST2600 i3c controller
>   i3c: ast2600: Add AST2600 platform-specific driver
>
>  .../bindings/i3c/aspeed,ast2600-i3c.yaml      |  72 ++++++++
>  MAINTAINERS                                   |   6 +
>  drivers/i3c/master/Kconfig                    |  14 ++
>  drivers/i3c/master/Makefile                   |   1 +
>  drivers/i3c/master/ast2600-i3c-master.c       | 168 ++++++++++++++++++
>  drivers/i3c/master/dw-i3c-master.c            |  76 ++++----
>  drivers/i3c/master/dw-i3c-master.h            |  54 ++++++
>  7 files changed, 358 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
>  create mode 100644 drivers/i3c/master/ast2600-i3c-master.c
>  create mode 100644 drivers/i3c/master/dw-i3c-master.h
>
> --
> 2.39.1
>
