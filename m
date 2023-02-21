From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 21 Feb 2023 01:12:47 +0000
Subject: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <abec828b-9b34-fc5a-cd36-8be6f20dfd25@linaro.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
 <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <abec828b-9b34-fc5a-cd36-8be6f20dfd25@linaro.org>
Message-ID: <TYZPR06MB52743FC4ED5ED152446106ABF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,


> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, February 20, 2023 6:36 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
> 
> On 20/02/2023 10:56, Ryan Chen wrote:
> >>
> >>> And also have separate i2c master and slave register set for control.
> >>
> >> Since several of my questions remained unanswered and quite frankly
> >> it's fruitless... so let me read the commit msg directly - it's the
> >> same device, just with different register layout. Having new
> >> compatible makes sense, but this should be part of old binding.
> >>
> > Sorry, I am confused, Do you mean I should base on original
> > Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > Add new compatible? Not add another aspeed,i2cv2.yaml.
> 
> Yes. New compatible and new syscon phandle (constrained to specific
> compatibles in allOf:if:then:) to the old binding.
Thank your guidance.
The following is my sample modify, if my understand is correct, I will update in patch1 thread discussion.
I need add in original aspeed,i2c.yaml not aspeed,i2cv2.yaml
allOf:
  - $ref: /schemas/i2c/i2c-controller.yaml#
  - if:
      properties:
        compatible:
          contains:
            const: aspeed,ast2600-i2cv2

    then:
      required:
        - aspeed,gr
		-as is.

Best regards,
Ryan Chen
