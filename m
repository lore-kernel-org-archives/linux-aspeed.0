From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 02 Apr 2021 11:44:39 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v3_4/4]_dt-bindings:_serial:_8250:_add_aspeed,
 lpc-a?= =?UTF-8?Q?ddress_and_aspeed,sirq?=
In-Reply-To: <20210402004716.15961-5-zev@bewilderbeest.net>
References: <20210402004716.15961-1-zev@bewilderbeest.net>
 <20210402004716.15961-5-zev@bewilderbeest.net>
Message-ID: <639f957f-a0d7-4a06-8598-90da0e17820b@beta.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 2 Apr 2021, at 11:17, Zev Weiss wrote:
> These correspond to the existing lpc_address, sirq, and sirq_polarity
> sysfs attributes; the second element of aspeed,sirq provides a
> replacement for the deprecated aspeed,sirq-polarity-sense property.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml 
> b/Documentation/devicetree/bindings/serial/8250.yaml
> index 491b9297432d..a6e01f9b745f 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -12,8 +12,13 @@ maintainers:
>  allOf:
>    - $ref: /schemas/serial.yaml#
>    - if:
> -      required:
> -        - aspeed,sirq-polarity-sense
> +      anyOf:
> +        - required:
> +            - aspeed,lpc-address

Why not aspeed,lpc-io-reg like the KCS binding?

There are some things we can do to improve it, but we shouldn't go and invent something different. I prefer aspeed,lpc-io-reg because it's name derives from the generic 'reg' property as does it's behaviour (if you assume a related `#size-cells = 0`).

> +        - required:
> +            - aspeed,sirq

Why not aspeed,lpc-interrupts like the KCS binding?

The generic IRQ property is 'interrupts', so like aspeed,lpc-io-reg the interrupts proposal for KCS follows in name and form. I'm hiding it behind the aspeed vendor prefix for now while I'm not satisfied that I understand the requirements of non-aspeed parts. Similarly, I added the lpc prefix because we don't tend to describe the host devicetree in the BMC devicetree (and so there's no parent interrupt controller that we can reference via a phandle) and we need a way to differentiate from the local interrupts property.

I don't see a reason for either of them to differ from what we already have for KCS, and I don't see any reason to continue the sysfs naming scheme in the binding.

Eventually I want to distil an LPC peripheral binding schema from what we've developed for the peripherals supported by aspeed and nuvoton SoCs.

Cheers,

Andrew

> +        - required:
> +            - aspeed,sirq-polarity-sense
>      then:
>        properties:
>          compatible:
> @@ -190,6 +195,20 @@ properties:
>        applicable to aspeed,ast2500-vuart.
>      deprecated: true
>  
> +  aspeed,lpc-address:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: |
> +      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
> +
> +  aspeed,sirq:
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      A 2-cell property describing the VUART SIRQ number and SIRQ
> +      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
> +      applicable to aspeed,ast2500-vuart.
> +
>  required:
>    - reg
>    - interrupts
> @@ -221,6 +240,7 @@ examples:
>      };
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      serial at 1e787000 {
>          compatible = "aspeed,ast2500-vuart";
>          reg = <0x1e787000 0x40>;
> @@ -228,7 +248,8 @@ examples:
>          interrupts = <8>;
>          clocks = <&syscon ASPEED_CLK_APB>;
>          no-loopback-test;
> -        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
> +        aspeed,lpc-address = <0x3f8>;
> +        aspeed,sirq = <4 IRQ_TYPE_LEVEL_LOW>;
>      };
>  
>  ...
> -- 
> 2.31.1
> 
>
