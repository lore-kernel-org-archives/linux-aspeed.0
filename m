From: Conor Dooley <conor@kernel.org>
Date: Thu, 22 Feb 2024 16:02:07 +0000
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <20240222085914.1218037-1-Kelly_Hung@asus.com>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
Message-ID: <20240222-getting-nebulizer-8f75ba8063b1@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 22, 2024 at 04:59:13PM +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.

It would be good to mention here what the x4tf is - is it a bmc or
an sbc etc.

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3..80009948e 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus,x4tf
>                - facebook,bletchley-bmc
>                - facebook,cloudripper-bmc
>                - facebook,elbert-bmc
> -- 
> 2.25.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240222/4d77c794/attachment.sig>
