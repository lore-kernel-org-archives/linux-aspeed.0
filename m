From: Rob Herring <robh@kernel.org>
Date: Thu, 15 Jul 2021 10:28:40 -0600
Subject: [PATCH 04/14] dt-bindings: Add bindings for peci-aspeed
In-Reply-To: <20210712220447.957418-5-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-5-iwona.winiarska@intel.com>
Message-ID: <20210715162840.GA1187226@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 13, 2021 at 12:04:37AM +0200, Iwona Winiarska wrote:
> Add device tree bindings for the peci-aspeed controller driver.
> 
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>  .../devicetree/bindings/peci/peci-aspeed.yaml | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> 
> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.yaml b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> new file mode 100644
> index 000000000000..6061e06009fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/peci/peci-aspeed.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed PECI Bus Device Tree Bindings
> +
> +maintainers:
> +  - Iwona Winiarska <iwona.winiarska@intel.com>
> +  - Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> +
> +allOf:
> +  - $ref: peci-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-peci
> +      - aspeed,ast2500-peci
> +      - aspeed,ast2600-peci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      Clock source for PECI controller. Should reference the external
> +      oscillator clock.
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-divider:
> +    description: This value determines PECI controller internal clock
> +      dividing rate. The divider will be calculated as 2 raised to the
> +      power of the given value.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +

> +  msg-timing:
> +    description: |
> +      Message timing negotiation period. This value will determine the period
> +      of message timing negotiation to be issued by PECI controller. The unit
> +      of the programmed value is four times of PECI clock period.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +    default: 1
> +
> +  addr-timing:
> +    description: |
> +      Address timing negotiation period. This value will determine the period
> +      of address timing negotiation to be issued by PECI controller. The unit
> +      of the programmed value is four times of PECI clock period.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +    default: 1
> +
> +  rd-sampling-point:
> +    description: |
> +      Read sampling point selection. The whole period of a bit time will be
> +      divided into 16 time frames. This value will determine the time frame
> +      in which the controller will sample PECI signal for data read back.
> +      Usually in the middle of a bit time is the best.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +    default: 8
> +
> +  cmd-timeout-ms:
> +    description: |
> +      Command timeout in units of ms.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 1000
> +    default: 1000

Are all of these properties common for PECI or specific to this 
controller? The former needs to go into the common schema. The latter 
need vendor prefixes.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    peci-controller at 1e78b000 {
> +      compatible = "aspeed,ast2600-peci";
> +      reg = <0x1e78b000 0x100>;
> +      interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
> +      resets = <&syscon ASPEED_RESET_PECI>;
> +      clock-divider = <0>;
> +      msg-timing = <1>;
> +      addr-timing = <1>;
> +      rd-sampling-point = <8>;
> +      cmd-timeout-ms = <1000>;
> +    };
> +...
> -- 
> 2.31.1
> 
> 
