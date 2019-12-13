From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Dec 2019 15:42:58 -0600
Subject: [PATCH v2 1/2] dt-bindings: mfd: Add ast2600 to ASPEED LPC
In-Reply-To: <20191129000827.650566-2-joel@jms.id.au>
References: <20191129000827.650566-1-joel@jms.id.au>
 <20191129000827.650566-2-joel@jms.id.au>
Message-ID: <20191213214258.GA7625@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 29, 2019 at 10:38:26AM +1030, Joel Stanley wrote:
> The AST2600 has the same LPC layout as previous generation SoCs.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Fix cut and paste error in reset bindings
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 86446074e206..a5d89aa9a3c1 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -46,6 +46,7 @@ Required properties
>  - compatible:	One of:
>  		"aspeed,ast2400-lpc", "simple-mfd"
>  		"aspeed,ast2500-lpc", "simple-mfd"
> +		"aspeed,ast2600-lpc", "simple-mfd"
>  
>  - reg:		contains the physical address and length values of the Aspeed
>                  LPC memory region.
> @@ -64,6 +65,7 @@ BMC Node
>  - compatible:	One of:
>  		"aspeed,ast2400-lpc-bmc"
>  		"aspeed,ast2500-lpc-bmc"
> +		"aspeed,ast2600-lpc-bmc"
>  
>  - reg:		contains the physical address and length values of the
>                  H8S/2168-compatible LPC controller memory region
> @@ -128,6 +130,7 @@ Required properties:
>  - compatible:	One of:
>  		"aspeed,ast2400-lpc-ctrl";
>  		"aspeed,ast2500-lpc-ctrl";
> +		"aspeed,ast2600-lpc-ctrl";
>  
>  - reg:		contains offset/length values of the host interface controller
>  		memory regions
> @@ -168,6 +171,7 @@ Required properties:
>  - compatible:	One of:
>  		"aspeed,ast2400-lhc";
>  		"aspeed,ast2500-lhc";
> +		"aspeed,ast2600-lhc";
>  
>  - reg:		contains offset/length values of the LHC memory regions. In the
>  		AST2400 and AST2500 there are two regions.
> @@ -187,8 +191,11 @@ state of the LPC bus. Some systems may chose to modify this configuration.
>  
>  Required properties:
>  
> - - compatible:		"aspeed,ast2500-lpc-reset" or
> -			"aspeed,ast2400-lpc-reset"
> + - compatible:		One of:
> +			"aspeed,ast2400-reset";
> +			"aspeed,ast2500-reset";
> +			"aspeed,ast2600-reset";

Doesn't match what's in the driver.

Rob
