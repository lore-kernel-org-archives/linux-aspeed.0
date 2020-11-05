From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Nov 2020 16:39:49 -0600
Subject: [v3 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI
 memory controller
In-Reply-To: <20201105120331.9853-2-chin-ting_kuo@aspeedtech.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-2-chin-ting_kuo@aspeedtech.com>
Message-ID: <20201105223949.GA1927504@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 05, 2020 at 08:03:28PM +0800, Chin-Ting Kuo wrote:
> Create binding file with YAML syntax for ASPEED FMC/SPI memory controller.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  .../bindings/spi/aspeed,spi-aspeed.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> new file mode 100644
> index 000000000000..41b9692c7226
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/aspeed,spi-aspeed.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI memory controller for ASPEED SoCs
> +
> +maintainers:
> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +
> +description: |
> +  There are three SPI memory controllers embedded in a ASPEED SoC.
> +  They are usually connected to SPI NOR flashes. Each of them has
> +  more than a chip select. They also support SPI single, dual and
> +  quad IO modes for SPI NOR flash.
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

You can drop oneOf (there's only 1) and items.

> +          - enum:
> +              - aspeed,ast2600-fmc
> +              - aspeed,ast2600-spi
> +
> +  reg:
> +    items:
> +      - description: the control register location and length
> +      - description: the flash memory mapping address and length
> +
> +  clocks:
> +    description: AHB bus clock which will be converted to SPI bus clock

maxItems: 1

Constraints on num-cs values? Or up to 2^32 is good?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - num-cs
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    spi1: spi at 1e630000 {
> +      compatible = "aspeed,ast2600-spi";
> +      reg = <0x1e630000 0xc4>, <0x30000000 0x10000000>;
> +      reg-names = "spi_ctrl_reg", "spi_mmap";
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      num-cs = <2>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      flash at 0 {
> +        compatible = "jedec,spi-nor";
> +        reg = <0>;
> +        spi-max-frequency = <50000000>;
> +      };
> +      flash at 1 {
> +        compatible = "jedec,spi-nor";
> +        reg = <1>;
> +        spi-max-frequency = <50000000>;
> +      };
> +    };
> -- 
> 2.17.1
> 
