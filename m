From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 25 Sep 2023 12:12:45 +0930
Subject: [PATCH 1/2] dt-bindings: watchdog: aspeed-wdt: Add aspeed,reset-mask
 property
In-Reply-To: <20230922104231.1434-5-zev@bewilderbeest.net>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
 <20230922104231.1434-5-zev@bewilderbeest.net>
Message-ID: <6df088a6-75ab-42f2-ba39-3f155714ed2d@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 22 Sep 2023, at 20:12, Zev Weiss wrote:
> This property configures the Aspeed watchdog timer's reset mask, which
> controls which peripherals are reset when the watchdog timer expires.
> Some platforms require that certain devices be left untouched across a
> reboot; aspeed,reset-mask can now be used to express such constraints.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
>  include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
>  2 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h
>
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt 
> b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index a8197632d6d2..3208adb3e52e 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -47,7 +47,15 @@ Optional properties for AST2500-compatible watchdogs:
>  			   is configured as push-pull, then set the pulse
>  			   polarity to active-high. The default is active-low.
> 
> -Example:
> +Optional properties for AST2500- and AST2600-compatible watchdogs:
> + - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
> +		      the watchdog timer expires.  On AST2500 this should be a
> +		      single word defined using the AST2500_WDT_RESET_* macros;
> +		      on AST2600 this should be a two-word array with the first
> +		      word defined using the AST2600_WDT_RESET1_* macros and the
> +		      second word defined using the AST2600_WDT_RESET2_* macros.
> +
> +Examples:
> 
>  	wdt1: watchdog at 1e785000 {
>  		compatible = "aspeed,ast2400-wdt";
> @@ -55,3 +63,11 @@ Example:
>  		aspeed,reset-type = "system";
>  		aspeed,external-signal;
>  	};
> +
> +	#include <dt-bindings/watchdog/aspeed-wdt.h>
> +	wdt2: watchdog at 1e785040 {
> +		compatible = "aspeed,ast2600-wdt";
> +		reg = <0x1e785040 0x40>;
> +		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> +				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> +	};

Rob has acked your current approach already, but I do wonder about an alternative that aligns more with the clock/reset/interrupt properties. Essentially, define a new generic watchdog property that is specified on the controllers to be reset by the watchdog (or even on just the watchdog node itself, emulating what you've proposed here):

watchdog-resets = <phandle index>;

The phandle links to the watchdog of interest, and the index specifies the controller associated with the configuration. It might even be useful to do:

watchdog-resets = <phandle index enable>;

"enable" could provide explicit control over whether somethings should be reset or not (as a way to prevent reset if the controller targeted by the provided index would otherwise be reset in accordance with the default reset value in the watchdog controller).

The macros from the dt-bindings header can then use macros to name the indexes rather than define a mask tied to the register layout. The index may still in some way represent the mask position. This has the benefit of hiding the issue of one vs two configuration registers between the AST2500 and AST2600 while also allowing other controllers to exploit the binding (Nuvoton BMCs? Though maybe it's generalising too early?).

It'd probably need a new function exported from the watchdog subsystem for the drivers to call through, though I don't think that's too much of a hurdle?

Andrew

> diff --git a/include/dt-bindings/watchdog/aspeed-wdt.h 
> b/include/dt-bindings/watchdog/aspeed-wdt.h
> new file mode 100644
> index 000000000000..7ae6d84b2bd9
> --- /dev/null
> +++ b/include/dt-bindings/watchdog/aspeed-wdt.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef DT_BINDINGS_ASPEED_WDT_H
> +#define DT_BINDINGS_ASPEED_WDT_H
> +
> +#define AST2500_WDT_RESET_CPU		(1 << 0)
> +#define AST2500_WDT_RESET_COPROC	(1 << 1)
> +#define AST2500_WDT_RESET_SDRAM		(1 << 2)
> +#define AST2500_WDT_RESET_AHB		(1 << 3)
> +#define AST2500_WDT_RESET_I2C		(1 << 4)
> +#define AST2500_WDT_RESET_MAC0		(1 << 5)
> +#define AST2500_WDT_RESET_MAC1		(1 << 6)
> +#define AST2500_WDT_RESET_GRAPHICS	(1 << 7)
> +#define AST2500_WDT_RESET_USB2_HOST_HUB	(1 << 8)
> +#define AST2500_WDT_RESET_USB_HOST	(1 << 9)
> +#define AST2500_WDT_RESET_HID_EHCI	(1 << 10)
> +#define AST2500_WDT_RESET_VIDEO		(1 << 11)
> +#define AST2500_WDT_RESET_HAC		(1 << 12)
> +#define AST2500_WDT_RESET_LPC		(1 << 13)
> +#define AST2500_WDT_RESET_SDIO		(1 << 14)
> +#define AST2500_WDT_RESET_MIC		(1 << 15)
> +#define AST2500_WDT_RESET_CRT		(1 << 16)
> +#define AST2500_WDT_RESET_PWM		(1 << 17)
> +#define AST2500_WDT_RESET_PECI		(1 << 18)
> +#define AST2500_WDT_RESET_JTAG		(1 << 19)
> +#define AST2500_WDT_RESET_ADC		(1 << 20)
> +#define AST2500_WDT_RESET_GPIO		(1 << 21)
> +#define AST2500_WDT_RESET_MCTP		(1 << 22)
> +#define AST2500_WDT_RESET_XDMA		(1 << 23)
> +#define AST2500_WDT_RESET_SPI		(1 << 24)
> +#define AST2500_WDT_RESET_SOC_MISC	(1 << 25)
> +
> +#define AST2500_WDT_RESET_DEFAULT 0x023ffff3
> +
> +#define AST2600_WDT_RESET1_CPU		(1 << 0)
> +#define AST2600_WDT_RESET1_SDRAM	(1 << 1)
> +#define AST2600_WDT_RESET1_AHB		(1 << 2)
> +#define AST2600_WDT_RESET1_SLI		(1 << 3)
> +#define AST2600_WDT_RESET1_SOC_MISC0	(1 << 4)
> +#define AST2600_WDT_RESET1_COPROC	(1 << 5)
> +#define AST2600_WDT_RESET1_USB_A	(1 << 6)
> +#define AST2600_WDT_RESET1_USB_B	(1 << 7)
> +#define AST2600_WDT_RESET1_UHCI		(1 << 8)
> +#define AST2600_WDT_RESET1_GRAPHICS	(1 << 9)
> +#define AST2600_WDT_RESET1_CRT		(1 << 10)
> +#define AST2600_WDT_RESET1_VIDEO	(1 << 11)
> +#define AST2600_WDT_RESET1_HAC		(1 << 12)
> +#define AST2600_WDT_RESET1_DP		(1 << 13)
> +#define AST2600_WDT_RESET1_DP_MCU	(1 << 14)
> +#define AST2600_WDT_RESET1_GP_MCU	(1 << 15)
> +#define AST2600_WDT_RESET1_MAC0		(1 << 16)
> +#define AST2600_WDT_RESET1_MAC1		(1 << 17)
> +#define AST2600_WDT_RESET1_SDIO0	(1 << 18)
> +#define AST2600_WDT_RESET1_JTAG0	(1 << 19)
> +#define AST2600_WDT_RESET1_MCTP0	(1 << 20)
> +#define AST2600_WDT_RESET1_MCTP1	(1 << 21)
> +#define AST2600_WDT_RESET1_XDMA0	(1 << 22)
> +#define AST2600_WDT_RESET1_XDMA1	(1 << 23)
> +#define AST2600_WDT_RESET1_GPIO0	(1 << 24)
> +#define AST2600_WDT_RESET1_RVAS		(1 << 25)
> +
> +#define AST2600_WDT_RESET1_DEFAULT 0x030f1ff1
> +
> +#define AST2600_WDT_RESET2_CPU		(1 << 0)
> +#define AST2600_WDT_RESET2_SPI		(1 << 1)
> +#define AST2600_WDT_RESET2_AHB2		(1 << 2)
> +#define AST2600_WDT_RESET2_SLI2		(1 << 3)
> +#define AST2600_WDT_RESET2_SOC_MISC1	(1 << 4)
> +#define AST2600_WDT_RESET2_MAC2		(1 << 5)
> +#define AST2600_WDT_RESET2_MAC3		(1 << 6)
> +#define AST2600_WDT_RESET2_SDIO1	(1 << 7)
> +#define AST2600_WDT_RESET2_JTAG1	(1 << 8)
> +#define AST2600_WDT_RESET2_GPIO1	(1 << 9)
> +#define AST2600_WDT_RESET2_MDIO		(1 << 10)
> +#define AST2600_WDT_RESET2_LPC		(1 << 11)
> +#define AST2600_WDT_RESET2_PECI		(1 << 12)
> +#define AST2600_WDT_RESET2_PWM		(1 << 13)
> +#define AST2600_WDT_RESET2_ADC		(1 << 14)
> +#define AST2600_WDT_RESET2_FSI		(1 << 15)
> +#define AST2600_WDT_RESET2_I2C		(1 << 16)
> +#define AST2600_WDT_RESET2_I3C_GLOBAL	(1 << 17)
> +#define AST2600_WDT_RESET2_I3C0		(1 << 18)
> +#define AST2600_WDT_RESET2_I3C1		(1 << 19)
> +#define AST2600_WDT_RESET2_I3C2		(1 << 20)
> +#define AST2600_WDT_RESET2_I3C3		(1 << 21)
> +#define AST2600_WDT_RESET2_I3C4		(1 << 22)
> +#define AST2600_WDT_RESET2_I3C5		(1 << 23)
> +#define AST2600_WDT_RESET2_ESPI		(1 << 26)
> +
> +#define AST2600_WDT_RESET2_DEFAULT 0x03fffff1
> +
> +#endif
> -- 
> 2.40.0.5.gf6e3b97ba6d2.dirty
