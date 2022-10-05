From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Oct 2022 08:18:40 -0500
Subject: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
In-Reply-To: <20221004032841.3714928-5-neal_liu@aspeedtech.com>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-5-neal_liu@aspeedtech.com>
Message-ID: <20221005131840.GA3256371-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 04, 2022 at 11:28:41AM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> Advanced High-Performance Bus (AHB) Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> new file mode 100644
> index 000000000000..c42a350d30a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device Tree Bindings
> +
> +maintainers:
> +  - Neal Liu <neal_liu@aspeedtech.com>
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +description: |
> +  Advanced High-performance Bus Controller (AHBC) supports plenty of mechanisms
> +  including a priority arbiter, an address decoder and a data multiplexer
> +  to control the overall operations of Advanced High-performance
> +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate with the
> +  related peripherals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-ahbc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        compatible = "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        ahbc: bus at 1e600000 {
> +            compatible = "aspeed,ast2600-ahbc";
> +            reg = <0x1e600000 0x100>;

Devices on the AHB bus should be child nodes here. Unless this is just 
for device master interface to memory, but that's not what the 
description says.

Rob
