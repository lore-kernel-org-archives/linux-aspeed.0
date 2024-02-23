From: Kelly Hung(洪嘉莉) <Kelly_Hung@asus.com>
Date: Fri, 23 Feb 2024 02:47:41 -0000
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <20240222-getting-nebulizer-8f75ba8063b1@spud>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
 <20240222-getting-nebulizer-8f75ba8063b1@spud>
Message-ID: <TYZPR04MB6596ED7F905CB53191F48A289D552@TYZPR04MB6596.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

External email : Ensure your email is secure before opening links and attachments.

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..80009948e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
--
2.25.1


<p></p>

-----Original Message-----
From: Conor Dooley <conor@kernel.org>
Sent: Friday, February 23, 2024 12:02 AM
To: Kelly Hung <ppighouse@gmail.com>
Cc: robh+dt at kernel.org; krzysztof.kozlowski+dt at linaro.org; conor+dt at kernel.org; joel at jms.id.au; andrew at codeconstruct.com.au; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org; openbmc at lists.ozlabs.org; Kelly Hung(???) <Kelly_Hung@asus.com>; AllenYY Hsu(???) <AllenYY_Hsu@asus.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board

On Thu, Feb 22, 2024 at 04:59:13PM +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.

It would be good to mention here what the x4tf is - is it a bmc or an sbc etc.

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
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
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
===================================================================================================================================
This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. Please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resale price. All customers are free to set their own price as they wish.
===================================================================================================================================
