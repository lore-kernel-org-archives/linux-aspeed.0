From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Sep 2021 07:03:52 +0000
Subject: [PATCH 0/2] arm: aspeed: Add LPC uart routing support
In-Reply-To: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
References: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
Message-ID: <CACPK8XfeU0+w03fgYxXVMVYOW-2woXQtUZ4FEDri3MSe+80_Wg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 1 Sept 2021 at 06:22, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Add LPC uart routing driver and the device tree nodes.

Thanks for submitting this driver. There are many parties who are
interested in this, so hopefully they can step forward and review.

Is this LPC UART routing, or UART routing in general? I know the
register to control the routing is hidden in the LPC space, but I
thought it was just general routing. I would drop the LPC part of the
name.

You also need to update the bindings document with the new compatible
string. Send a patch for
Documentation/devicetree/bindings/mfd/aspeed-lpc.txt.

Cheers,

Joel



>
> Chia-Wei Wang (2):
>   soc: aspeed: Add LPC UART routing support
>   ARM: dts: aspeed: Add uart routing to device tree
>
>  arch/arm/boot/dts/aspeed-g5.dtsi             |   6 +
>  arch/arm/boot/dts/aspeed-g6.dtsi             |   6 +
>  drivers/soc/aspeed/Kconfig                   |  11 +
>  drivers/soc/aspeed/Makefile                  |   9 +-
>  drivers/soc/aspeed/aspeed-lpc-uart-routing.c | 621 +++++++++++++++++++
>  5 files changed, 649 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/soc/aspeed/aspeed-lpc-uart-routing.c
>
> --
> 2.17.1
>
