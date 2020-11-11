From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Nov 2020 23:34:10 +0000
Subject: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
Message-ID: <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series adds the initial version of device tree for Facebook
> Galaxy100 (AST2400) BMC.
>
> Patch #1 adds common dtsi to minimize duplicated device entries across
> Facebook Network AST2400 BMC device trees.
>
> Patch #2 simplfies Wedge40 device tree by using the common dtsi.
>
> Patch #3 simplfies Wedge100 device tree by using the common dtsi.
>
> Patch #4 adds the initial version of device tree for Facebook Galaxy100
> BMC.

Nice. They look good to me.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Is there another person familiar with the design you would like to
review before I merge?


>
> Tao Ren (4):
>   ARM: dts: aspeed: Common dtsi for Facebook AST2400 Network BMCs
>   ARM: dts: aspeed: wedge40: Use common dtsi
>   ARM: dts: aspeed: wedge100: Use common dtsi
>   ARM: dts: aspeed: Add Facebook Galaxy100 (AST2400) BMC
>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-galaxy100.dts     |  57 +++++++++
>  .../boot/dts/aspeed-bmc-facebook-wedge100.dts | 120 +++---------------
>  .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 112 +---------------
>  .../dts/ast2400-facebook-netbmc-common.dtsi   | 117 +++++++++++++++++
>  5 files changed, 191 insertions(+), 216 deletions(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
>  create mode 100644 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
>
> --
> 2.17.1
>
