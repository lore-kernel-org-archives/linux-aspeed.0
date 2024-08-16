From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 16 Aug 2024 04:08:05 +0000
Subject: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add aspeed,ast2700-evb
 compatible string
In-Reply-To: <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
 <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
Message-ID: <PSAPR06MB4949F7F617DB4A371567EB4789812@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index 71c31c08a8ad..b21551817f44 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -99,4 +99,9 @@ properties:
> >                - ufispace,ncplite-bmc
> >            - const: aspeed,ast2600
> >
> > +      - description: AST2700 based boards
> > +        items:
> > +          - enum:
> > +              - aspeed,ast2700-evb
>
> NAK, this cannot be alone. Look at all other examples. Why are you doing
> things differently?
Disagree, ast2700-evb is 7th generation IC in ASPEED.
It not in the sub-set of AST2400/AST2500/AST2600 based boards.

>
> Best regards,
> Krzysztof

--
Best Regards,
Kevin.Chen
************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
