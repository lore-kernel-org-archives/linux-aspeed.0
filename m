From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Aug 2019 07:52:53 -0700
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Add ast2600 compatible
In-Reply-To: <20190819051738.17370-2-joel@jms.id.au>
References: <20190819051738.17370-1-joel@jms.id.au>
 <20190819051738.17370-2-joel@jms.id.au>
Message-ID: <20190831145252.GA6062@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 19, 2019 at 02:47:37PM +0930, Joel Stanley wrote:
> This adds a compatible for the ast2600, a new ASPEED SoC.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>  - Add Andrew's r-b
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index c5077a1f5cb3..d78d4a8fb868 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -4,6 +4,7 @@ Required properties:
>   - compatible: must be one of:
>  	- "aspeed,ast2400-wdt"
>  	- "aspeed,ast2500-wdt"
> +	- "aspeed,ast2600-wdt"
>  
>   - reg: physical base address of the controller and length of memory mapped
>     region
