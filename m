From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Sep 2022 15:48:10 -0500
Subject: [PATCH v1 3/4] dt-bindings: crypto: add documentation for Aspeed
 ACRY
In-Reply-To: <20220902060012.3758637-4-neal_liu@aspeedtech.com>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-4-neal_liu@aspeedtech.com>
Message-ID: <20220907204810.GA312863-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 02, 2022 at 02:00:11PM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> ECDSA/RSA ACRY Engines Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/crypto/aspeed,ast2600-acry.yaml  | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> new file mode 100644
> index 000000000000..192b40cd0a39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED ACRY ECDSA/RSA Hardware Accelerator Engines Device Tree Bindings

Drop ' Device Tree Bindings'

> +
> +maintainers:
> +  - Neal Liu <neal_liu@aspeedtech.com>
> +
> +description: |

Don't need '|' if no formatting.

> +  The ACRY ECDSA/RSA engines is designed to accelerate the throughput
> +  of ECDSA/RSA signature and verification. Basically, ACRY can be
> +  divided into two independently engines - ECC Engine and RSA Engine.

independent

> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-acry
> +
> +  reg:
> +    items:
> +      - description: acry base address & size
> +      - description: acry sram base address & size
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    acry: crypto at 1e6fa000 {
> +        compatible = "aspeed,ast2600-acry";
> +        reg = <0x1e6fa000 0x400>, <0x1e710000 0x1800>;
> +        interrupts = <160>;
> +        clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 832da6d77374..09ab1c3adbb7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3214,7 +3214,7 @@ ASPEED CRYPTO DRIVER
>  M:	Neal Liu <neal_liu@aspeedtech.com>
>  L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
> +F:	Documentation/devicetree/bindings/crypto/aspeed,*
>  F:	drivers/crypto/aspeed/
>  
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> -- 
> 2.25.1
> 
> 
