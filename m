From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Aug 2023 08:08:12 +0000
Subject: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
Message-ID: <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series fixes a few entries in wedge400 device tree.
>
> Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> by wedge400 dts) to make sure spi bus is consistent with flash labels in
> flash layout.
>
> Patch #2 enables more ADC channels in wedge400 dts.
>
> Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
>
> Tao Ren (3):
>   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi

I wondered if we should do this in the aspeed-g5.dtsi.

>   ARM: dts: aspeed: wedge400: Enable more ADC channels
>   ARM: dts: aspeed: wedge400: Set eMMC max frequency

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 +++-
>  arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> --
> 2.40.1
>
