From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Mar 2021 17:39:02 -0500
Subject: [PATCH 2/3] dt-bindings: serial: 8250: update for
 aspeed,sirq-active-high
In-Reply-To: <20210330002338.335-3-zev@bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-3-zev@bewilderbeest.net>
Message-ID: <20210330223902.GA837825@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 29, 2021 at 07:23:37PM -0500, Zev Weiss wrote:
> Update DT bindings documentation for the new incarnation of the
> aspeed,sirq-polarity-sense property.

Why?

This isn't a compatible change.

> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index f54cae9ff7b2..0bbb7121f720 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -13,7 +13,7 @@ allOf:
>    - $ref: /schemas/serial.yaml#
>    - if:
>        required:
> -        - aspeed,sirq-polarity-sense
> +        - aspeed,sirq-active-high
>      then:
>        properties:
>          compatible:
> @@ -181,13 +181,11 @@ properties:
>    rng-gpios: true
>    dcd-gpios: true
>  
> -  aspeed,sirq-polarity-sense:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> +  aspeed,sirq-active-high:
> +    type: boolean
>      description: |
> -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> -      offset and bit number to identify how the SIRQ polarity should be
> -      configured. One possible data source is the LPC/eSPI mode bit. Only
> -      applicable to aspeed,ast2500-vuart.
> +      Set to indicate that the SIRQ polarity is active-high (default
> +      is active-low).  Only applicable to aspeed,ast2500-vuart.
>  
>  required:
>    - reg
> @@ -227,7 +225,7 @@ examples:
>          interrupts = <8>;
>          clocks = <&syscon ASPEED_CLK_APB>;
>          no-loopback-test;
> -        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
> +        aspeed,sirq-active-high;
>      };
>  
>  ...
> -- 
> 2.31.1
> 
