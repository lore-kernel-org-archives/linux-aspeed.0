From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 30 Aug 2023 11:45:28 +0200
Subject: [PATCH v4 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
In-Reply-To: <20230830090212.3880559-3-peteryin.openbmc@gmail.com>
References: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
 <20230830090212.3880559-3-peteryin.openbmc@gmail.com>
Message-ID: <1d531692-5455-fbfd-0775-50856bf0fbc7@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30/08/2023 11:02, peteryin wrote:
> Document the new compatibles used on Meta Minerva.
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 6b0a6683ccae..b681bbf960d1 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -80,6 +80,7 @@ properties:
>                - facebook,fuji-bmc
>                - facebook,greatlakes-bmc
>                - facebook,yosemite4-bmc
> +              - facebook,minerva-bmc

m is not after y. Keep things sorted, I already wrote this in your v2.

Best regards,
Krzysztof

