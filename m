From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 20 Jul 2022 12:34:28 +0200
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: document Ampere
 Mt.Mitchell BMC compatibles
In-Reply-To: <20220720085230.3801945-2-quan@os.amperecomputing.com>
References: <20220720085230.3801945-1-quan@os.amperecomputing.com>
 <20220720085230.3801945-2-quan@os.amperecomputing.com>
Message-ID: <0a5cbaaa-565a-7215-5e31-12c52f4bbcbd@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/07/2022 10:52, Quan Nguyen wrote:
> Document Ampere Mt.Mitchell BMC board compatible.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Thank you for your patch. There is something to discuss/improve.

> ---
> v2:
>   + Introduce in v2 to add Ampere Mt. Mitchell BMC compatible [Krzysztof]
> 
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index d61408194998..b8146d5c4431 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -71,6 +71,7 @@ properties:
>            - enum:
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - ampere,mtmitchell-bmc

Put the entry ordered alphabetically.


Best regards,
Krzysztof
