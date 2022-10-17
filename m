From: Rob Herring <robh@kernel.org>
Date: Mon, 17 Oct 2022 13:51:38 -0500
Subject: [PATCH linux v2 1/3] spi: dt-bindings: aspeed: Add a ranges
 property
In-Reply-To: <20221017091624.130227-2-clg@kaod.org>
References: <20221017091624.130227-1-clg@kaod.org>
 <20221017091624.130227-2-clg@kaod.org>
Message-ID: <20221017185138.GA2264550-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 17, 2022 at 11:16:22AM +0200, C?dric Le Goater wrote:
> "ranges" predefines settings for the decoding ranges of each CS.

Please explain the problem, not what the change is.

> Cc: Naresh Solanki <naresh.solanki@9elements.com>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  .../devicetree/bindings/spi/aspeed,ast2600-fmc.yaml      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> index fa8f4ac20985..a11cbc4c4c5c 100644
> --- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -38,6 +38,14 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  ranges:
> +    minItems: 1
> +    maxItems: 5
> +    description: |
> +      Defines the address mapping for child devices with four integer
> +      values for each chip-select line in use:
> +      <cs-number> 0 <physical address of mapping> <size>
> +
>  required:
>    - compatible
>    - reg
> @@ -58,6 +66,7 @@ examples:
>          compatible = "aspeed,ast2600-fmc";
>          clocks = <&syscon ASPEED_CLK_AHB>;
>          interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +        ranges = <0 0 0x20000000 0x2000000>, <1 0 0x22000000 0x2000000>;

By having ranges here, 'reg' in child nodes become translatable 
addresses. But they are not because they are SPI chip-selects. Only 
memory mapped addresses should be translatable. 

Probably the ranges here should be in 'reg' of the controller.

>  
>          flash at 0 {
>                  reg = < 0 >;
> -- 
> 2.37.3
> 
> 
