From: Rob Herring <robh@kernel.org>
Date: Mon, 30 Sep 2019 13:59:18 -0500
Subject: [PATCH 2/2] dt-bindings: i2c: Aspeed: Add AST2600 compatible
In-Reply-To: <1568392510-866-3-git-send-email-eajames@linux.ibm.com>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
 <1568392510-866-3-git-send-email-eajames@linux.ibm.com>
Message-ID: <20190930185918.GA18431@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 13, 2019 at 11:35:10AM -0500, Eddie James wrote:
> Document the AST2600 I2C bus compatible string.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> index 8fbd863..b47f6cc 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -1,4 +1,4 @@
> -Device tree configuration for the I2C busses on the AST24XX and AST25XX SoCs.
> +Device tree configuration for the I2C busses on the AST24XX, AST25XX, and AST26XX SoCs.

Perhaps s/buses/busses/ while you're here.

Acked-by: Rob Herring <robh@kernel.org>

>  
>  Required Properties:
>  - #address-cells	: should be 1
> @@ -6,6 +6,7 @@ Required Properties:
>  - reg			: address offset and range of bus
>  - compatible		: should be "aspeed,ast2400-i2c-bus"
>  			  or "aspeed,ast2500-i2c-bus"
> +			  or "aspeed,ast2600-i2c-bus"
>  - clocks		: root clock of bus, should reference the APB
>  			  clock in the second cell
>  - resets		: phandle to reset controller with the reset number in
> -- 
> 1.8.3.1
> 
