From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 08:25:03 +0200
Subject: [PATCH v3 08/14] dt-bindings: fsi: ast2600-fsi-master: Switch to
 yaml format
In-Reply-To: <20240425213701.655540-9-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-9-eajames@linux.ibm.com>
Message-ID: <5822e000-01d3-442c-bb52-04fab87cb3da@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2024 23:36, Eddie James wrote:
> Switch to yaml for the AST2600 FSI master documentation.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../fsi/aspeed,ast2600-fsi-master.yaml        | 72 +++++++++++++++++++
>  .../bindings/fsi/fsi-master-aspeed.txt        | 36 ----------
>  2 files changed, 72 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> new file mode 100644
> index 000000000000..f053e3e1d259
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed FSI master
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  The AST2600 and later contain two identical FSI masters. They share a
> +  clock and have a separate interrupt line and output pins.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "aspeed,ast2600-fsi-master"
> +      - "aspeed,ast2700-fsi-master"

This wasn't tested. No quotes. Do you see any other example like this?

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  cfam-reset-gpios:
> +    maxItems: 1
> +    description:
> +      Output GPIO pin for CFAM reset
> +
> +  fsi-routing-gpios:
> +    maxItems: 1
> +    description:
> +      Output GPIO pin for setting the FSI mux (internal or cabled)
> +
> +  fsi-mux-gpios:
> +    maxItems: 1
> +    description:
> +      Input GPIO pin for detecting the desired FSI mux state
> +
> +  interrupts:
> +    maxItems: 1
> +
> +allOf:
> +  - $ref: fsi-controller.yaml#

This goes after required:

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    #include <dt-bindings/gpio/aspeed-gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    fsi-master at 1e79b000 {
> +        compatible = "aspeed,ast2600-fsi-master";
> +        reg = <0x1e79b000 0x94>;
> +        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_fsi1_default>;
> +        clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
> +        fsi-routing-gpios = <&gpio0 ASPEED_GPIO(Q, 7) GPIO_ACTIVE_HIGH>;
> +        fsi-mux-gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_HIGH>;
> +        cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_LOW>;

No children?


Best regards,
Krzysztof

