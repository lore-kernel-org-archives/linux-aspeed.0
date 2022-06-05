From: Rob Herring <robh@kernel.org>
Date: Sun, 5 Jun 2022 16:47:00 -0500
Subject: [PATCH v2 2/2] dt-bindings: aspeed-i2c: add properties for
 manual clock setting
In-Reply-To: <20220601041512.21484-3-potin.lai.pt@gmail.com>
References: <20220601041512.21484-1-potin.lai.pt@gmail.com>
 <20220601041512.21484-3-potin.lai.pt@gmail.com>
Message-ID: <20220605214700.GA3558088-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 01, 2022 at 12:15:12PM +0800, Potin Lai wrote:
> Add following properties for manual tuning clock divisor and cycle of
> hign/low pulse witdh.
> 
> * aspeed,i2c-manual-clk: Enable aspeed i2c clock manual setting
> * aspeed,i2c-base-clk-div: Base Clock divisor (tBaseClk)
> * aspeed,i2c-clk-high-cycle: Cycles of clock-high pulse (tClkHigh)
> * aspeed,i2c-clk-low-cycle: Cycles of clock-low pulse (tClkLow)
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> index ea643e6c3ef5..e2f67fe2aa0c 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -12,6 +12,28 @@ maintainers:
>  allOf:
>    - $ref: /schemas/i2c/i2c-controller.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          const: st,stm32-uart

stm32 uart?

> +
> +    then:
> +      properties:
> +        aspeed,i2c-clk-high-cycle:
> +          maximum: 8
> +        aspeed,i2c-clk-low-cycle:
> +          maximum: 8
> +
> +  - if:
> +      required:
> +        - aspeed,i2c-manual-clk
> +
> +    then:
> +      required:
> +        - aspeed,i2c-base-clk-div
> +        - aspeed,i2c-clk-high-cycle
> +        - aspeed,i2c-clk-low-cycle

'dependencies' can better express this than an if/then.

However, I think this should all be done in a common way.

> +
>  properties:
>    compatible:
>      enum:
> @@ -49,6 +71,28 @@ properties:
>      description:
>        states that there is another master active on this bus
>  
> +  aspeed,i2c-manual-clk:
> +    type: boolean
> +    description: enable manual clock setting

No need for this as presence of the other properties can determine this.

> +
> +  aspeed,i2c-base-clk-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192,
> +           16384, 32768]
> +    description: base clock divisor

Specify the i2c bus frequency and calculate the divider.

> +
> +  aspeed,i2c-clk-high-cycle:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 16
> +    description: cycles of master clock-high pulse width
> +
> +  aspeed,i2c-clk-low-cycle:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 16
> +    description: cycles of master clock-low pulse width

These 2 should be common. I think you just need a single property 
expressing duty cycle.

Rob
