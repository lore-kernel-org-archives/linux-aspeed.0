From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Jan 2020 03:34:37 +0000
Subject: [PATCH 1/3] ARM: dts: aspeed-g6: Add Video Engine node
In-Reply-To: <20200107011503.17435-2-jae.hyun.yoo@linux.intel.com>
References: <20200107011503.17435-1-jae.hyun.yoo@linux.intel.com>
 <20200107011503.17435-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8XcEVBp6hQ=97ZVM6a_y77PAhLZZsV104FDwTCsZm7JWDg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2020 at 01:14, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> The AST2600 has Video Engine so add it.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Acked-by: Joel Stanley <joel@jms.id.au>

I will merge this through the aspeed tree for 5.6.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 5f6142d99eeb..89833987e270 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -297,6 +297,16 @@
>                                 quality = <100>;
>                         };
>
> +                       video: video at 1e700000 {
> +                               compatible = "aspeed,ast2600-video-engine";
> +                               reg = <0x1e700000 0x1000>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +                                        <&syscon ASPEED_CLK_GATE_ECLK>;
> +                               clock-names = "vclk", "eclk";
> +                               interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                               status = "disabled";
> +                       };
> +
>                         gpio0: gpio at 1e780000 {
>                                 #gpio-cells = <2>;
>                                 gpio-controller;
> --
> 2.17.1
>
