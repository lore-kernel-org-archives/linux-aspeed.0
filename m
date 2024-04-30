From: Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 30 Apr 2024 08:37:00 -0000
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <20240430045853.3894633-2-Kelly_Hung@asus.com>
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
 <20240430045853.3894633-2-Kelly_Hung@asus.com>
Message-ID: <20240430-spotty-generic-f34c53e2e50a@wendy>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 30, 2024 at 12:58:52PM +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
> 
> Signed-off-by: Kelly Hung <ppighouse@gmail.com>
> 
> ---
> V6 -> v7:
> - Remove incorrect tags.
> - Modify Signed-off-by field.
> v5 -> v6:
> - Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> - Add Reviewed-by: Rob Herring <robh@kernel.org>
> - Add Reviewed-by: Zev Weiss <zweiss@equinix.com>
> - Add Acked-by: Conor Dooley <conor.dooley@microchip.com>

I did actually ack this, so dropping mine was not required:
https://lore.kernel.org/all/20240229-rocket-fraction-76e85d9f4bfb at spud/

> V4 -> V5: Update all changelog from v1 to v5.
> V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use
> a ast2600-a3 chip, so correct string to asus,x4tf-bmc.
> V2 -> V3: Add a label to indicate it is new compatible for bmc.
> V1 -> V2: Remove blank in front of the string x4tf.
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3..0047eb4ab 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus,x4tf-bmc
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240430/18e336cf/attachment-0001.sig>
