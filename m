From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 15 Feb 2023 05:43:12 +0000
Subject: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
In-Reply-To: <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
Message-ID: <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, February 2, 2023 4:58 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
> i2C driver
> 
> On 01/02/2023 11:33, Ryan Chen wrote:
> > AST2600 support new register set for I2C controller, add bindings
> > document to support driver of i2c new register mode controller.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../bindings/i2c/aspeed,i2c-ast2600.yaml      | 78
> +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> > b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> > new file mode 100644
> > index 000000000000..b7d7bc303e77
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> > @@ -0,0 +1,78 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AST2600 I2C Controller on the AST26XX SoCs Device Tree
> > +Bindings
> > +
> > +maintainers:
> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/i2c/i2c-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2600-i2c
> 
> NAK. It's already there. Please do not waste our time in submitting duplicated
> drivers.

It is not duplicated, as my description in cover " This series add AST2600 i2c new register set driver"
So, this will be different driver compatible. 
The original compatible is 
      - aspeed,ast2400-i2c-bus
      - aspeed,ast2500-i2c-bus
      - aspeed,ast2600-i2c-bus
So the new register set compatible is "- aspeed,ast2600-i2c", remove "bus".


Best regards,
Ryan Chen
