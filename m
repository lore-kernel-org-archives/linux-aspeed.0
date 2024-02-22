From: Kelly Hung(洪嘉莉) <Kelly_Hung@asus.com>
Date: Thu, 22 Feb 2024 07:33:53 -0000
Subject: [PATCH] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <2ab9b3924dbe07039e934d4580ab7dd397a31728.camel@codeconstruct.com.au>
References: <20240222032504.1147489-1-Kelly_Hung@asus.com>
	 <20240222032504.1147489-2-Kelly_Hung@asus.com>
 <2ab9b3924dbe07039e934d4580ab7dd397a31728.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB6596F2EBAF65F7F53809C2259D562@TYZPR04MB6596.apcprd04.prod.outlook.com>
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
index 749ee54a3ff8..60a494b7aaaf 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
--
2.25.1


<p></p>

-----Original Message-----
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Sent: Thursday, February 22, 2024 1:14 PM
To: Kelly Hung <ppighouse@gmail.com>; robh+dt at kernel.org
Cc: krzysztof.kozlowski+dt at linaro.org; conor+dt at kernel.org; joel at jms.id.au; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org; openbmc at lists.ozlabs.org; Kelly Hung(???) <Kelly_Hung@asus.com>; AllenYY Hsu(???) <AllenYY_Hsu@asus.com>
Subject: Re: [PATCH] dt-bindings: arm: aspeed: add ASUS X4TF board

External email : Ensure your email is secure before opening links and attachments.

Hi Kelly,

On Thu, 2024-02-22 at 11:25 +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
>
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3ff8..60a494b7aaaf 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus, x4tf

You need to remove the space after the comma. This should be `asus,x4tf`.

Andrew

<p></p>
===================================================================================================================================
This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. Please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resale price. All customers are free to set their own price as they wish.
===================================================================================================================================
