From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Sep 2023 13:16:37 -0500
Subject: [PATCH v8 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
In-Reply-To: <20230905062223.774871-3-peteryin.openbmc@gmail.com>
References: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
 <20230905062223.774871-3-peteryin.openbmc@gmail.com>
Message-ID: <20230905181637.GA3742088-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 05, 2023 at 02:22:22PM +0800, Peter Yin wrote:
> Document the new compatibles used on Meta Minerva.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> 

You should not have blank lines between tags. 

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 68f717670f78..32582ee56264 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -79,6 +79,7 @@ properties:
>                - facebook,elbert-bmc
>                - facebook,fuji-bmc
>                - facebook,greatlakes-bmc
> +              - facebook,minerva-bmc
>                - facebook,yosemite4-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
> -- 
> 2.25.1
> 
