From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Jun 2021 08:58:42 +0930
Subject: [PATCH v4 3/7] ARM: dts: aspeed-g6: Add SGPIO node.
In-Reply-To: <20210607071514.11727-4-steven_lee@aspeedtech.com>
References: <20210607071514.11727-1-steven_lee@aspeedtech.com>
 <20210607071514.11727-4-steven_lee@aspeedtech.com>
Message-ID: <5277db96-4eb8-4794-a1fa-6a5bc40bffb7@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 7 Jun 2021, at 16:45, Steven Lee wrote:
> AST2600 supports 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index f96607b7b4e2..c09b24824b6d 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -377,6 +377,36 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> +			sgpiom0: sgpiom at 1e780500 {
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				compatible = "aspeed,ast2600-sgpiom-128";
> +				reg = <0x1e780500 0x100>;
> +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +				ngpios = <128>;

Doesn't this affect the way the data is presented on the bus?

My understanding is this should be defined by each platform, not in the dtsi. Having said that, it appears it is specified in aspeed-g5.dtsi (as the value 8?).

> +				clocks = <&syscon ASPEED_CLK_APB2>;
> +				interrupt-controller;
> +				bus-frequency = <12000000>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_sgpm1_default>;
> +				status = "disabled";
> +			};
> +
> +			sgpiom1: sgpiom at 1e780600 {
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				compatible = "aspeed,ast2600-sgpiom-80";
> +				reg = <0x1e780600 0x100>;
> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +				ngpios = <80>;

As above.

Andrew
