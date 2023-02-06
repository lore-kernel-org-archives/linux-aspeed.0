From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 6 Feb 2023 13:55:03 -0600
Subject: [PATCH] dt-bindings : misc : aspeed,cvic interrupt controller :
 convert the binding document to yaml
In-Reply-To: <20230206153325.43692-1-sunrockers8@gmail.com>
References: <20230206153325.43692-1-sunrockers8@gmail.com>
Message-ID: <CAL_JsqJoH2EdWxZc115HpGLmqQ3Wu8q3MS85NiqGKu57Y1o6dA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 6, 2023 at 9:35 AM Vijaya Anand <sunrockers8@gmail.com> wrote:
>
>     Convert the binding document for ASPEED AST2400 and AST2500 coprocessor interrupt controller
>     from txt to yaml so one could validate dt-entries correctly and any future additions can go
>     into yaml format. The options for compatability described according to the example given.

Missing DCO (Signed-off-by). checkpatch.pl will tell this for you.

> ---
>  .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 ----------
>  .../devicetree/bindings/misc/aspeed,cvic.yaml | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
>
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
> deleted file mode 100644
> index d62c783d1d5e..000000000000
> --- a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* ASPEED AST2400 and AST2500 coprocessor interrupt controller
> -
> -This file describes the bindings for the interrupt controller present
> -in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
> -ColdFire coprocessor.
> -
> -It is not a normal interrupt controller and it would be rather
> -inconvenient to create an interrupt tree for it as it somewhat shares
> -some of the same sources as the main ARM interrupt controller but with
> -different numbers.
> -
> -The AST2500 supports a SW generated interrupt
> -
> -Required properties:
> -- reg: address and length of the register for the device.
> -- compatible: "aspeed,cvic" and one of:
> -               "aspeed,ast2400-cvic"
> -             or
> -               "aspeed,ast2500-cvic"
> -
> -- valid-sources: One cell, bitmap of supported sources for the implementation
> -
> -Optional properties;
> -- copro-sw-interrupts: List of interrupt numbers that can be used as
> -                      SW interrupts from the ARM to the coprocessor.
> -                      (AST2500 only)
> -
> -Example:
> -
> -       cvic: copro-interrupt-controller at 1e6c2000 {
> -               compatible = "aspeed,ast2500-cvic";
> -               valid-sources = <0xffffffff>;
> -               copro-sw-interrupts = <1>;
> -               reg = <0x1e6c2000 0x80>;
> -       };
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> new file mode 100644
> index 000000000000..bbff0418fa2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/aspeed,cvic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400 and AST2500 coprocessor interrupt controller
> +
> +maintainers:
> +  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
> +  - Rob Herring <robh@kernel.org>

Should be someone that has and cares about Aspeed h/w, not me.

> +
> +description: |
> +  This file describes the bindings for the interrupt controller present
> +  in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
> +  ColdFire coprocessor.
> +
> +  It is not a normal interrupt controller and it would be rather
> +  inconvenient to create an interrupt tree for it as it somewhat shares
> +  some of the same sources as the main ARM interrupt controller but with
> +  different numbers.
> +
> +  The AST2500 supports a SW generated interruptThe Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> +  which provides high-throughput LDPC and Turbo Code implementations.
> +  The LDPC decode & encode functionality is capable of covering a range of
> +  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> +  principally covers codes used by LTE. The FEC Engine offers significant
> +  power and area savings versus implementations done in the FPGA fabric.
> +
> +properties:
> +
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-cvic
> +      - aspeed,ast2500-cvic
> +
> +  reg:
> +    maxItems: 1
> +    description: address and length of the register for the device.

Drop generic descriptions.

> +
> +  valid-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: One cell, bitmap of supported sources for the implementation

Drop 'one cell'. The type says that.

> +
> +  copro-sw-interrupts:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Is there a range of number of entries and/or values for entries. If
so, add constraints.

> +    description: |

Don't need '|' if no formatting to maintain.

> +                  List of interrupt numbers that can be used as
> +                  SW interrupts from the ARM to the coprocessor.
> +                  (AST2500 only)
> +
> +required:
> +  - compatible
> +  - reg
> +  - valid-sources
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cvic: copro-interrupt-controller at 1e6c2000
> +    {
> +        compatible = "aspeed,ast2500-cvic";
> +        valid-sources = <0xffffffff>;
> +        copro-sw-interrupts = <1>;
> +        reg = <0x1e6c2000 0x80>;
> +    };
> --
> 2.37.1 (Apple Git-137.1)
>
