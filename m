From: Conor Dooley <conor@kernel.org>
Date: Fri, 30 Aug 2024 15:04:04 +0100
Subject: [PATCH v2 1/4] dt-bindings: gpio: aspeed,ast2400-gpio: Support
 ast2700
In-Reply-To: <20240830034047.2251482-2-billy_tsai@aspeedtech.com>
References: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
 <20240830034047.2251482-2-billy_tsai@aspeedtech.com>
Message-ID: <20240830-untangled-charting-48503e510ea7@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 30, 2024 at 11:40:44AM +0800, Billy Tsai wrote:
> The AST2700 is the 7th generation SoC from Aspeed, featuring two GPIO
> controllers: one with 12 GPIO pins and another with 216 GPIO pins.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 46 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> index cf11aa7ec8c7..4d439972c14b 100644
> --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -15,6 +15,7 @@ properties:
>        - aspeed,ast2400-gpio
>        - aspeed,ast2500-gpio
>        - aspeed,ast2600-gpio
> +      - aspeed,ast2700-gpio
>  
>    reg:
>      maxItems: 1
> @@ -42,7 +43,7 @@ properties:
>      const: 2
>  
>    ngpios:
> -    minimum: 36
> +    minimum: 12
>      maximum: 232

Aren't you missing a corresponding update to gpio-line-names, which has
a minimum of 36?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240830/d719956e/attachment.sig>
