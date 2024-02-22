From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 22 Feb 2024 15:44:20 +1030
Subject: [PATCH] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <20240222032504.1147489-2-Kelly_Hung@asus.com>
References: <20240222032504.1147489-1-Kelly_Hung@asus.com>
	 <20240222032504.1147489-2-Kelly_Hung@asus.com>
Message-ID: <2ab9b3924dbe07039e934d4580ab7dd397a31728.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kelly,

On Thu, 2024-02-22 at 11:25 +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3ff8..60a494b7aaaf 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus, x4tf

You need to remove the space after the comma. This should be
`asus,x4tf`.

Andrew
