From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Mon, 7 Oct 2024 09:26:13 +0000
Subject: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add aspeed,ast2700-evb
 compatible string
In-Reply-To: <2b40d7e4-10f5-406a-9ac9-f9292a52a659@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
 <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
 <PSAPR06MB4949F7F617DB4A371567EB4789812@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <2b40d7e4-10f5-406a-9ac9-f9292a52a659@kernel.org>
Message-ID: <PSAPR06MB494943F3F34881D23CEEBD9A897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > Hi Krzk,
> >
> >>> ---
> >>>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> >>> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> >>> index 71c31c08a8ad..b21551817f44 100644
> >>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> >>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> >>> @@ -99,4 +99,9 @@ properties:
> >>>                - ufispace,ncplite-bmc
> >>>            - const: aspeed,ast2600
> >>>
> >>> +      - description: AST2700 based boards
> >>> +        items:
> >>> +          - enum:
> >>> +              - aspeed,ast2700-evb
> >>
> >> NAK, this cannot be alone. Look at all other examples. Why are you
> >> doing things differently?
> > Disagree, ast2700-evb is 7th generation IC in ASPEED.
> 
> I gave you argument and you just respond "disagree" with unrelated
> statement?
> > It not in the sub-set of AST2400/AST2500/AST2600 based boards.
> 
> 
> ? That does not answer at all my concerns. Bring me any example doing this
> that way: single board compatible.
In current stage, we only have one kind of ASPEED AST2700 evaluation board.
Should I add const for aspeed,ast2700 as the following.
      - description: AST2700 based boards 
        items: 
          - enum: 
              - aspeed,ast2700-evb 
          - const: aspeed,ast2700

> 
> Answer to the argument, instead of bringing useless text "ast is a board". Yeah,
> of course it is. What else could it be? A ship? A car?

> 
> Best regards,
> Krzysztof

