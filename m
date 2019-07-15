From: Joel Stanley <joel@jms.id.au>
Date: Mon, 15 Jul 2019 23:16:54 +0000
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Fix 'compatible' schema
 errors
In-Reply-To: <20190715223725.12924-1-robh@kernel.org>
References: <20190715223725.12924-1-robh@kernel.org>
Message-ID: <CACPK8Xdz98CQzgE2KCjz8eOhPtx=H8jTe1hVT7LvP77U_gGASQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2019 at 22:37, Rob Herring <robh@kernel.org> wrote:
>
> The Aspeed pinctl schema have errors in the 'compatible' schema:
>
> Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml: \
> properties:compatible:enum: ['aspeed', 'ast2400-pinctrl', 'aspeed', 'g4-pinctrl'] has non-unique elements
> Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml: \
> properties:compatible:enum: ['aspeed', 'ast2500-pinctrl', 'aspeed', 'g5-pinctrl'] has non-unique elements
>
> Flow style sequences have to be quoted if the vales contain ','. Fix
> this by using the more common one line per entry formatting.

>
>  properties:
>    compatible:
> -    enum: [ aspeed,ast2400-pinctrl, aspeed,g4-pinctrl ]
> +    enum:
> +      - aspeed,ast2400-pinctrl
> +      - aspeed,g4-pinctrl

Thanks for the fix. However, we've standardised on the first form for
all of our device trees, so we can drop the second compatible string
from the bindings.

I think Andrew already has a patch cooking to do this.

Cheers,

Joel
