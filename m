From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 16 Feb 2023 09:17:12 +0000
Subject: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
In-Reply-To: <a62fb259-3ad3-b75e-c59e-2ce937bf799a@linux.microsoft.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
 <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <a62fb259-3ad3-b75e-c59e-2ce937bf799a@linux.microsoft.com>
Message-ID: <TYZPR06MB52747AA667D2481034396444F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dhananjay,

> -----Original Message-----
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Sent: Thursday, February 16, 2023 12:17 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
> i2C driver
> 
> Hi Ryan,
> 
> On 2/14/2023 9:43 PM, Ryan Chen wrote:
> > It is not duplicated, as my description in cover " This series add AST2600 i2c
> new register set driver"
> > So, this will be different driver compatible.
> > The original compatible is
> >        - aspeed,ast2400-i2c-bus
> >        - aspeed,ast2500-i2c-bus
> >        - aspeed,ast2600-i2c-bus
> > So the new register set compatible is "- aspeed,ast2600-i2c", remove "bus".
> 
> Is it possible to keep existing driver drivers/i2c/busses/i2c-aspeed.c for
> ast2400/ast2500, while move ast2600 support to new driver altogether, say
> i2c-ast2600.c along with new register mode? By default new driver can
> support legacy mode with same compatible "aspeed,ast2600- i2c-bus",
> additionally driven by dt props, switch to new mode.

No, as the patch cover latter description, it is two different register offsets.
Pure new register control, and also different control sequence.

Regards,
Ryan
