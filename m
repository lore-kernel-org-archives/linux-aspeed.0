From: Joel Stanley <joel@jms.id.au>
Date: Mon, 1 Nov 2021 23:33:37 +0000
Subject: [PATCH -next 1/4] ARM: dts: aspeed: add LCLK setting into LPC IBT
 node
In-Reply-To: <20211101233751.49222-2-jae.hyun.yoo@intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <20211101233751.49222-2-jae.hyun.yoo@intel.com>
Message-ID: <CACPK8XcAN-SsKDS2E_Cnv=5-Rq=9sAWYyb88i2Ub-iX0WH6aZw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 1 Nov 2021 at 23:18, <jae.hyun.yoo@intel.com> wrote:
>
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>
> Add LCLK clock setting into LPC IBT node to enable the LCLK by
> individual LPC sub drivers.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Do you need to update the bindings too?

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
>  arch/arm/boot/dts/aspeed-g6.dtsi | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index b313a1cf5f73..f14dace34c5a 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -381,6 +381,7 @@ ibt: ibt at 140 {
>                                         compatible = "aspeed,ast2400-ibt-bmc";
>                                         reg = <0x140 0x18>;
>                                         interrupts = <8>;
> +                                       clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                         status = "disabled";
>                                 };
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index c7049454c7cb..d0cc4be2de59 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -507,6 +507,7 @@ ibt: ibt at 140 {
>                                         compatible = "aspeed,ast2500-ibt-bmc";
>                                         reg = <0x140 0x18>;
>                                         interrupts = <8>;
> +                                       clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                         status = "disabled";
>                                 };
>                         };
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 5106a424f1ce..465c3549fdc3 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -581,6 +581,7 @@ ibt: ibt at 140 {
>                                         compatible = "aspeed,ast2600-ibt-bmc";
>                                         reg = <0x140 0x18>;
>                                         interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>                                         status = "disabled";
>                                 };
>                         };
> --
> 2.25.1
>
