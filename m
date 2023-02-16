From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 16 Feb 2023 09:26:37 +0000
Subject: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
In-Reply-To: <c5aa358d-6fb8-9d4d-eef7-d3a8268229e8@linaro.org>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
 <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <b58fad13-12d5-346b-9452-d345c7bf5327@linaro.org>
 <TYZPR06MB5274C8D759C5C762C12A1CE9F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <c5aa358d-6fb8-9d4d-eef7-d3a8268229e8@linaro.org>
Message-ID: <TYZPR06MB5274B15C35A6030CB49BFD23F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, February 16, 2023 5:22 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
> i2C driver
> 
> On 16/02/2023 10:20, Ryan Chen wrote:
> > Hello Krzysztof
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Sent: Thursday, February 16, 2023 4:18 AM
> >> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> >> <robh+dt@kernel.org>; Krzysztof Kozlowski
> >> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
> >> Andrew Jeffery <andrew@aj.id.au>; Philipp Zabel
> >> <p.zabel@pengutronix.de>; openbmc at lists.ozlabs.org;
> >> linux-arm-kernel at lists.infradead.org;
> >> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> >> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for
> >> AST2600 i2C driver
> >>
> >> On 15/02/2023 06:43, Ryan Chen wrote:
> >>>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    enum:
> >>>>> +      - aspeed,ast2600-i2c
> >>>>
> >>>> NAK. It's already there. Please do not waste our time in submitting
> >>>> duplicated drivers.
> >>>
> >>> It is not duplicated, as my description in cover " This series add
> >>> AST2600 i2c
> >> new register set driver"
> >>> So, this will be different driver compatible.
> >>> The original compatible is
> >>>       - aspeed,ast2400-i2c-bus
> >>>       - aspeed,ast2500-i2c-bus
> >>>       - aspeed,ast2600-i2c-bus
> >>> So the new register set compatible is "- aspeed,ast2600-i2c", remove
> "bus".
> >>
> >> Bindings are documenting hardware, so I claim - we already have this
> >> hardware described and this is duplicated. Otherwise - what are these
> >> two I2C controllers and what are the differences? Why they do not
> >> have really different name? Bus looks more like a mistake than a
> differentiating name.
> > For misunderstanding, or mistaken.
> > I purpose to be aspeed,ast2600-i2cv2, will it more clear way ?
> 
> I don't know. I still did not get answers. I asked here several questions.
Those are different i2c controller, as I description in cover letter.
The i2c new register mode, there have two separate slave/master register.
And different register with old register.
So now, avoid misunderstanding, or mistaken.
I purpose to be aspeed,ast2600-i2cv2.

Best regards,
Ryan Chen 
