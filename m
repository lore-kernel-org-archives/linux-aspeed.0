From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 May 2022 11:07:04 +0200
Subject: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed udc
In-Reply-To: <20220513065728.857722-4-neal_liu@aspeedtech.com>
References: <20220513065728.857722-1-neal_liu@aspeedtech.com>
 <20220513065728.857722-4-neal_liu@aspeedtech.com>
Message-ID: <da78aaf6-c9ae-d591-fdc4-723f097ace2c@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/05/2022 08:57, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed USB2.0 Device
> Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../devicetree/bindings/usb/aspeed,udc.yaml   | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,udc.yaml

Please name the file as first compatible, so "aspeed,ast2600-udc.yaml"


> 
> diff --git a/Documentation/devicetree/bindings/usb/aspeed,udc.yaml b/Documentation/devicetree/bindings/usb/aspeed,udc.yaml
> new file mode 100644
> index 000000000000..d1d2f77d1c54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/aspeed,udc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 Facebook Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/aspeed,udc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED USB 2.0 Device Controller
> +
> +maintainers:
> +  - Neal Liu <neal_liu@aspeedtech.com>
> +
> +description: |+
> +  The ASPEED USB 2.0 Device Controller implements 1 control endpoint and
> +  4 generic endpoints for AST260x.
> +
> +  Supports independent DMA channel for each generic endpoint.
> +  Supports 32/256 stages descriptor mode for all generic endpoints.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-udc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

No child properties? No ports or any other devices? No usb-hcd.yaml?
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
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    udc: udc at 1e6a2000 {

Node name: usb

> +            compatible = "aspeed,ast2600-udc";
> +            reg = <0x1e6a2000 0x300>;
> +            interrupts = <9>;
> +            clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_usb2bd_default>;
> +    };


Best regards,
Krzysztof
