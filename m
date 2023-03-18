From: Andi Shyti <andi.shyti@kernel.org>
Date: Sat, 18 Mar 2023 10:09:36 +0100
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
Message-ID: <20230318090936.qvqozqfskpe5lja7@intel.intel>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Sun, Feb 26, 2023 at 11:13:20AM +0800, Ryan Chen wrote:
> Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,timeout
> aspeed,xfer-mode description for ast2600-i2cv2.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> index f597f73ccd87..75de3ce41cf5 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -49,6 +49,25 @@ properties:
>      description:
>        states that there is another master active on this bus
>  
> +  aspeed,timeout:
> +    type: boolean
> +    description: I2C bus timeout enable for master/slave mode

Finally you can proceed with this. Please remove "aspeed,timeout"
and use "i2c-scl-has-clk-low-timeout" instead.

Andi
