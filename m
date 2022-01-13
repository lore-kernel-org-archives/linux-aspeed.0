From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Jan 2022 03:16:25 +0000
Subject: [PATCH v5 03/13] ARM: dts: aspeed: Add PECI controller nodes
In-Reply-To: <20220112230247.982212-4-iwona.winiarska@intel.com>
References: <20220112230247.982212-1-iwona.winiarska@intel.com>
 <20220112230247.982212-4-iwona.winiarska@intel.com>
Message-ID: <CACPK8XfL8-TovFWBxXo7ryijPXeS+sFwejxz-fKNNwxgD1N+oA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 12 Jan 2022 at 23:04, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add PECI controller nodes with all required information.
>
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 11 +++++++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 11 +++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 11 +++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index b313a1cf5f73..3c2961da6272 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -391,6 +391,17 @@ uart_routing: uart-routing at 9c {
>                                 };
>                         };
>
> +                       peci0: peci-controller at 1e78b000 {
> +                               compatible = "aspeed,ast2400-peci";
> +                               reg = <0x1e78b000 0x60>;
> +                               interrupts = <15>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> +                               resets = <&syscon ASPEED_RESET_PECI>;
> +                               cmd-timeout-ms = <1000>;
> +                               clock-frequency = <1000000>;
> +                               status = "disabled";
> +                       };
> +
>                         uart2: serial at 1e78d000 {
>                                 compatible = "ns16550a";
>                                 reg = <0x1e78d000 0x20>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index c7049454c7cb..aab1c3ecb4dc 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -511,6 +511,17 @@ ibt: ibt at 140 {
>                                 };
>                         };
>
> +                       peci0: peci-controller at 1e78b000 {
> +                               compatible = "aspeed,ast2500-peci";
> +                               reg = <0x1e78b000 0x60>;
> +                               interrupts = <15>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> +                               resets = <&syscon ASPEED_RESET_PECI>;
> +                               cmd-timeout-ms = <1000>;
> +                               clock-frequency = <1000000>;
> +                               status = "disabled";
> +                       };
> +
>                         uart2: serial at 1e78d000 {
>                                 compatible = "ns16550a";
>                                 reg = <0x1e78d000 0x20>;
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 5106a424f1ce..564f1292993f 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -507,6 +507,17 @@ wdt4: watchdog at 1e7850c0 {
>                                 status = "disabled";
>                         };
>
> +                       peci0: peci-controller at 1e78b000 {
> +                               compatible = "aspeed,ast2600-peci";
> +                               reg = <0x1e78b000 0x100>;
> +                               interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
> +                               resets = <&syscon ASPEED_RESET_PECI>;
> +                               cmd-timeout-ms = <1000>;
> +                               clock-frequency = <1000000>;
> +                               status = "disabled";
> +                       };
> +
>                         lpc: lpc at 1e789000 {
>                                 compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
>                                 reg = <0x1e789000 0x1000>;
> --
> 2.31.1
>
