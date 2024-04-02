From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Apr 2024 13:07:18 -0500
Subject: [PATCH] dt-bindings: watchdog: Convert Aspeed binding to DT
 schema
In-Reply-To: <20240402120118.282035-1-andrew@codeconstruct.com.au>
References: <20240402120118.282035-1-andrew@codeconstruct.com.au>
Message-ID: <20240402180718.GA358505-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 02, 2024 at 10:31:18PM +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/watchdog at 1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 130 ++++++++++++++++++
>  .../bindings/watchdog/aspeed-wdt.txt          |  73 ----------
>  2 files changed, 130 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> new file mode 100644
> index 000000000000..10fcb50c4051
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed watchdog timer controllers
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-wdt
> +      - aspeed,ast2500-wdt
> +      - aspeed,ast2600-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks: true

# and order/function if more than 1 must be defined.

Please note it was missing from the original binding in the commit 
message.

> +
> +  aspeed,reset-type:
> +    enum:
> +      - cpu
> +      - soc
> +      - system
> +      - none
> +    description: |
> +      Reset behaviour - The watchdog can be programmed to generate one of three
> +      different types of reset when a timeout occcurs.
> +
> +      Specifying 'cpu' will only reset the processor on a timeout event.
> +
> +      Specifying 'soc' will reset a configurable subset of the SoC's controllers
> +      on a timeout event. Controllers critical to the SoC's operation may remain untouched.
> +
> +      Specifying 'system' will reset all controllers on a timeout event, as if EXTRST had been asserted.
> +      Specifying "none" will cause the timeout event to have no reset effect.
> +      Another watchdog engine on the chip must be used for chip reset operations.
> +
> +      The default reset type is "system"

Express as schema:

default: system

> +
> +  aspeed,alt-boot:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

Don't need '|' if no formatting to preserve.

> +      Direct the watchdog to configure the SoC to boot from the alternative boot
> +      region if a timeout occurs.
> +
> +  aspeed,external-signal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Assert the timeout event on an external signal pin associated with the
> +      watchdog controller instance. The pin must be muxed appropriately.
> +
> +  aspeed,ext-pulse-duration:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The duration, in microseconds, of the pulse emitted on the external signal pin

Wrap at <80. Period@end needed.

> +
> +  aspeed,ext-push-pull:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If aspeed,external-signal is specified in the node, set the external
> +      signal pin's drive type to push-pull. If aspeed,ext-push-pull is not
> +      specified then the pin is configured as open-drain.
> +
> +  aspeed,ext-active-high:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If both aspeed,external-signal and aspeed,ext-push-pull are specified in
> +      the node, set the pulse polarity to active-high. If aspeed,ext-active-high
> +      is not specified then the pin is configured as active-low.
> +
> +  aspeed,reset-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      A bitmaks indicating which peripherals will be reset if the watchdog
> +      timer expires. On AST2500 SoCs this should be a single word defined using
> +      the AST2500_WDT_RESET_* macros; on AST2600 SoCs this should be a two-word
> +      array with the first word defined using the AST2600_WDT_RESET1_* macros,
> +      and the second word defined using the AST2600_WDT_RESET2_* macros.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      anyOf:
> +        - required:
> +            - aspeed,ext-push-pull
> +        - required:
> +            - aspeed,ext-active-high
> +        - required:
> +            - aspeed,reset-mask
> +    then:
> +      properties:
> +        compatible:
> +          enum:
> +            - aspeed,ast2500-wdt
> +            - aspeed,ast2600-wdt
> +  - if:
> +      required:
> +        - aspeed,ext-active-high
> +    then:
> +      required:
> +        - aspeed,ext-push-pull
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    wdt1: watchdog at 1e785000 {

Drop unused labels.

> +        compatible = "aspeed,ast2400-wdt";
> +        reg = <0x1e785000 0x1c>;
> +        aspeed,reset-type = "system";
> +        aspeed,external-signal;
> +    };
> +  - |
> +    #include <dt-bindings/watchdog/aspeed-wdt.h>
> +    wdt2: watchdog at 1e785040 {
> +        compatible = "aspeed,ast2600-wdt";
> +        reg = <0x1e785040 0x40>;
> +        aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> +                            (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> deleted file mode 100644
> index 3208adb3e52e..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -Aspeed Watchdog Timer
> -
> -Required properties:
> - - compatible: must be one of:
> -	- "aspeed,ast2400-wdt"
> -	- "aspeed,ast2500-wdt"
> -	- "aspeed,ast2600-wdt"
> -
> - - reg: physical base address of the controller and length of memory mapped
> -   region
> -
> -Optional properties:
> -
> - - aspeed,reset-type = "cpu|soc|system|none"
> -
> -   Reset behavior - Whenever a timeout occurs the watchdog can be programmed
> -   to generate one of three different, mutually exclusive, types of resets.
> -
> -   Type "none" can be specified to indicate that no resets are to be done.
> -   This is useful in situations where another watchdog engine on chip is
> -   to perform the reset.
> -
> -   If 'aspeed,reset-type=' is not specified the default is to enable system
> -   reset.
> -
> -   Reset types:
> -
> -        - cpu: Reset CPU on watchdog timeout
> -
> -        - soc: Reset 'System on Chip' on watchdog timeout
> -
> -        - system: Reset system on watchdog timeout
> -
> -        - none: No reset is performed on timeout. Assumes another watchdog
> -                engine is responsible for this.
> -
> - - aspeed,alt-boot:    If property is present then boot from alternate block.
> - - aspeed,external-signal: If property is present then signal is sent to
> -			external reset counter (only WDT1 and WDT2). If not
> -			specified no external signal is sent.
> - - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
> -
> -Optional properties for AST2500-compatible watchdogs:
> - - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
> -			 drive type to push-pull. The default is open-drain.
> - - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
> -			   is configured as push-pull, then set the pulse
> -			   polarity to active-high. The default is active-low.
> -
> -Optional properties for AST2500- and AST2600-compatible watchdogs:
> - - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
> -		      the watchdog timer expires.  On AST2500 this should be a
> -		      single word defined using the AST2500_WDT_RESET_* macros;
> -		      on AST2600 this should be a two-word array with the first
> -		      word defined using the AST2600_WDT_RESET1_* macros and the
> -		      second word defined using the AST2600_WDT_RESET2_* macros.
> -
> -Examples:
> -
> -	wdt1: watchdog at 1e785000 {
> -		compatible = "aspeed,ast2400-wdt";
> -		reg = <0x1e785000 0x1c>;
> -		aspeed,reset-type = "system";
> -		aspeed,external-signal;
> -	};
> -
> -	#include <dt-bindings/watchdog/aspeed-wdt.h>
> -	wdt2: watchdog at 1e785040 {
> -		compatible = "aspeed,ast2600-wdt";
> -		reg = <0x1e785040 0x40>;
> -		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> -				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> -	};
> -- 
> 2.39.2
> 
