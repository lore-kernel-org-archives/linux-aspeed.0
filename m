From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Dec 2020 02:20:45 +0000
Subject: [PATCH 2/2] ARM: dts: aspeed: Add LCLK to lpc-snoop
In-Reply-To: <20201202051634.490-2-wangzhiqiang.bj@bytedance.com>
References: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com>
 <20201202051634.490-2-wangzhiqiang.bj@bytedance.com>
Message-ID: <CACPK8XfVGSy=ST8afmcA-VTRZEdf-5-LSbXbd5DZ7LQ999mcxA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Dec 2020 at 05:16, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
>

Can you add a note here about why we are adding these so it's clear is
a fix/enhancement?

Also add a Fixes line for both patches.

> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>


Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g6.dtsi | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index f606fc01ff13..2364b660f2e4 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -370,6 +370,7 @@ lpc_snoop: lpc-snoop at 10 {
>                                                 compatible = "aspeed,ast2400-lpc-snoop";
>                                                 reg = <0x10 0x8>;
>                                                 interrupts = <8>;
> +                                               clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                                 status = "disabled";
>                                         };
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 19288495f41a..30bbf7452b90 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -496,6 +496,7 @@ lpc_snoop: lpc-snoop at 10 {
>                                                 compatible = "aspeed,ast2500-lpc-snoop";
>                                                 reg = <0x10 0x8>;
>                                                 interrupts = <8>;
> +                                               clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                                 status = "disabled";
>                                         };
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..4b1013870fb1 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -520,6 +520,7 @@ lpc_snoop: lpc-snoop at 0 {
>                                                 compatible = "aspeed,ast2600-lpc-snoop";
>                                                 reg = <0x0 0x80>;
>                                                 interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +                                               clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                                 status = "disabled";
>                                         };
>
> --
> 2.25.1
>
