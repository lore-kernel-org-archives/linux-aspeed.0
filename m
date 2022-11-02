From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 2 Nov 2022 14:00:33 -0700
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Setup watchdog pre-timeout
 interrupt
In-Reply-To: <20221101205338.577427-3-eajames@linux.ibm.com>
References: <20221101205338.577427-1-eajames@linux.ibm.com>
 <20221101205338.577427-3-eajames@linux.ibm.com>
Message-ID: <20221102210033.GA2090211@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 01, 2022 at 03:53:38PM -0500, Eddie James wrote:
> Specify the interrupt lines for the base SOCs that support it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 3 +++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 04f98d1dbb97..b4b98bf38e48 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -410,18 +410,21 @@ wdt1: watchdog at 1e785000 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785000 0x20>;
>  				clocks = <&syscon ASPEED_CLK_APB>;
> +				interrupts = <27>;
>  			};
>  
>  			wdt2: watchdog at 1e785020 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785020 0x20>;
>  				clocks = <&syscon ASPEED_CLK_APB>;
> +				interrupts = <27>;
>  			};
>  
>  			wdt3: watchdog at 1e785040 {
>  				compatible = "aspeed,ast2500-wdt";
>  				reg = <0x1e785040 0x20>;
>  				clocks = <&syscon ASPEED_CLK_APB>;
> +				interrupts = <27>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index ebbcfe445d9c..d9379fd7b1c2 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -539,23 +539,27 @@ uart5: serial at 1e784000 {
>  
>  			wdt1: watchdog at 1e785000 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e785000 0x40>;
>  			};
>  
>  			wdt2: watchdog at 1e785040 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e785040 0x40>;
>  				status = "disabled";
>  			};
>  
>  			wdt3: watchdog at 1e785080 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e785080 0x40>;
>  				status = "disabled";
>  			};
>  
>  			wdt4: watchdog at 1e7850c0 {
>  				compatible = "aspeed,ast2600-wdt";
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				reg = <0x1e7850C0 0x40>;
>  				status = "disabled";
>  			};
