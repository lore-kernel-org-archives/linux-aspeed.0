From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 28 May 2021 08:50:43 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_1/1]_dt-bindings:_aspeed-i2c:_Convert_txt_to_yam?=
 =?UTF-8?Q?l_format?=
In-Reply-To: <20210527102512.20684-2-jamin_lin@aspeedtech.com>
References: <20210527102512.20684-1-jamin_lin@aspeedtech.com>
 <20210527102512.20684-2-jamin_lin@aspeedtech.com>
Message-ID: <f7df6bb6-762d-4250-a4bc-076cbfc441eb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 27 May 2021, at 19:55, Jamin Lin wrote:
> Convert aspeed i2c to yaml.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 86 +++++++++++++++++++
>  .../devicetree/bindings/i2c/i2c-aspeed.txt    | 49 -----------
>  2 files changed, 86 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml 
> b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> new file mode 100644
> index 000000000000..1f7064d77708
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED I2C on the AST24XX, AST25XX, and AST26XX SoCs Device 
> Tree Bindings
> +
> +maintainers:
> +  - Rayn Chen <rayn_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-i2c-bus
> +      - aspeed,ast2500-i2c-bus
> +      - aspeed,ast2600-i2c-bus
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#address-cells":
> +    const: 1
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: address offset and range of bus
> +      - description: address offset and range of bus buffer
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt number
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      root clock of bus, should reference the APB
> +      clock in the second cell
> +
> +  reset:
> +    maxItems: 1
> +    description: phandle to reset controller with the reset number in
> +      the second cell
> +
> +  bus-frequency:
> +    minimum: 500
> +    maximum: 4000000
> +    default: 100000
> +    description: frequency of the bus clock in Hz defaults to 100 kHz 
> when not
> +      specified
> +
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus
> +
> +required:
> +  - reg
> +  - compatible
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    i2c0: i2c-bus at 40 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <1>;
> +      reg = <0x40 0x40>;
> +      compatible = "aspeed,ast2500-i2c-bus";
> +      clocks = <&syscon ASPEED_CLK_APB>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +      bus-frequency = <100000>;
> +      interrupts = <0>;
> +      interrupt-parent = <&i2c_ic>;
> +      status = "disabled";
> +      /* Does not need pinctrl properties */

Note this actually isn't right and someone (me?) needs to send a patch 
to fix the devicetree(s) - the I2C mux properties for bus 0 and 1 just 
don't have a group, and so SCL and SDA need to be muxed individually.

I expect we wound up with this comment by a lack of a match for an 
erroneous grep.

Andrew
