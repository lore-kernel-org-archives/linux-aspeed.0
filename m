From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 2 Feb 2023 05:15:16 +0000
Subject: [PATCH v4 1/3] dt-bindings: i2c-ast2600: Add support for AST2600
 I2C global controller
In-Reply-To: <c227fa62c1040c7c280f1a6559dcf4cf8fb40428.camel@codeconstruct.com.au>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
	 <20230201103359.1742140-2-ryan_chen@aspeedtech.com>
 <c227fa62c1040c7c280f1a6559dcf4cf8fb40428.camel@codeconstruct.com.au>
Message-ID: <SEZPR06MB5269699F950320DB7A78D7FEF2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jeremy
> 
> > AST2600 I2C global register controller, add bindings document to
> > support driver of i2c global register set.
> 
> [...]
> 
> > +allOf:
> > +? - $ref: /schemas/i2c/i2c-controller.yaml#
> 
> Are you sure about this? This particular binding doesn't describe the i2c
> controller.
Due to this is i2c driver global register setting. I think I will remove this ref:
But instead add description for understanding. Is it ok?

> 
> > +
> > +properties:
> > +? compatible:
> > +??? enum:
> > +????? - aspeed,ast2600-i2c-global
> > +
> > +? reg:
> > +??? minItems: 1
> > +??? items:
> > +????? - description: address offset and range of bus
> > +????? - description: address offset and range of bus buffer
> 
> Seems to be a duplicate here.
> 
The same, will remove items, keep minItems:1. 

Thanks
Ryan
> 
> 
> Jeremy
