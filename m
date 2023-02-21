From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 21 Feb 2023 02:43:12 +0000
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
Message-ID: <TYZPR06MB527427ADCCD29DFD77FB0EE3F2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, February 20, 2023 4:35 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
> 
> On 20/02/2023 07:17, Ryan Chen wrote:
> > AST2600 support new register set for I2Cv2 controller, add bindings
> > document to support driver of i2cv2 new register mode controller.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/i2c/aspeed,i2cv2.yaml | 83
> > +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> 
> New compatible is okay, but as this is the same controller as old one, this
> should go to old binding.
> 
> There are several issues anyway here, but I won't reviewing it except few
> obvious cases.
> 
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> > b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> > new file mode 100644
> > index 000000000000..913fb45d5fbe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i2c/aspeed,i2cv2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED I2Cv2 Controller on the AST26XX SoCs
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
> > +      - aspeed,ast2600-i2cv2
> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: address offset and range of register
> > +      - description: address offset and range of buffer register
> 
> Why this is optional?

Will modify minItems: 1 to 2
> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      Reference clock for the I2C bus
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clock-frequency:
> > +    description:
> > +      Desired I2C bus clock frequency in Hz. default 100khz.
> > +
> > +  multi-master:
> > +    type: boolean
> > +    description:
> > +      states that there is another master active on this bus
> 
> Drop description and type. Just :true.
> 
Since i2c.txt have multi-master will drop it.
> > +
> > +  timeout:
> > +    type: boolean
> > +    description: Enable i2c bus timeout for master/slave (35ms)
> 
> Why this is property for DT? It's for sure not bool, but proper type coming from
> units.
This is i2c controller feature for enable slave mode inactive timeout and
also master mode sda/scl auto release timeout. 
So I will modify to 
  aspeed,timeout:
	type: boolean
    description: I2C bus timeout enable for master/slave mode 

> > +
> > +  byte-mode:
> > +    type: boolean
> > +    description: Force i2c driver use byte mode transmit
> 
> Drop, not a DT property.
> 
> > +
> > +  buff-mode:
> > +    type: boolean
> > +    description: Force i2c driver use buffer mode transmit
> 
> Drop, not a DT property.
> 
The controller support 3 different for transfer.
Byte mode: it means step by step to issue transfer.
Example i2c read, each step will issue interrupt then enable next step.
Sr (start read) | D | D | D | P
Buffer mode: it means, the data can prepare into buffer register, then
Trigger transfer. So Sr D D D P, only have only 1 interrupt handling. 
The DMA mode most like with buffer mode, 
The differ is data prepare in DRAM, than trigger transfer. 

So, should I modify to
  aspeed,byte:
	type: boolean
    description: Enable i2c controller transfer with byte mode

  aspeed,buff:
	type: boolean
    description: Enable i2c controller transfer with buff mode

> > +
> > +  aspeed,gr:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of i2c global register node.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - resets
> > +  - aspeed,gr
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/ast2600-clock.h>
> > +    i2c: i2c-bus at 80 {
> 
> You did not test the bindings... This is i2c.
> 
I do use command : make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml 
To test it. is it not correct method?
I will modify "i2c: i2c-bus at 80" -> "i2c0: i2c at 80"

> 
> Best regards,
> Krzysztof

