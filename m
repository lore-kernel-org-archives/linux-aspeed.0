From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 1 Mar 2023 05:57:45 +0000
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <53090449-58c9-bc03-56df-aa8ae93c0c26@linaro.org>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
 <53090449-58c9-bc03-56df-aa8ae93c0c26@linaro.org>
Message-ID: <SEZPR06MB52699DEB2255EB54F35C2A59F2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, February 27, 2023 4:25 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Andrew Jeffery
> <andrew@aj.id.au>; Brendan Higgins <brendan.higgins@linux.dev>; Benjamin
> Herrenschmidt <benh@kernel.crashing.org>; Joel Stanley <joel@jms.id.au>;
> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> linux-i2c at vger.kernel.org; openbmc at lists.ozlabs.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for AST2600-i2cv2
> 
> On 26/02/2023 04:13, Ryan Chen wrote:
> > Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,timeout
> > aspeed,xfer-mode description for ast2600-i2cv2.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > index f597f73ccd87..75de3ce41cf5 100644
> > --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > @@ -49,6 +49,25 @@ properties:
> >      description:
> >        states that there is another master active on this bus
> >
> > +  aspeed,timeout:
> > +    type: boolean
> > +    description: I2C bus timeout enable for master/slave mode
> 
> Nothing improved here in regards to my last comment.

Yes, as I know your require is about " DT binding to represent hardware setup"
So I add more description about aspeed,timeout as blow.

ASPEED SOC chip is server product, i2c bus may have fingerprint connect to another board. And also support hotplug.
The following is board-specific design example.
Board A                                         Board B
-------------------------                       ------------------------
|i2c bus#1(master/slave)  <===fingerprint ===> i2c bus#x (master/slave)|
|i2c bus#2(master)-> tmp i2c device |          |                       |
|i2c bus#3(master)-> adc i2c device |          |                       |
-------------------------                       ------------------------

aspeed,timout properites:
For example I2C controller as slave mode, and suddenly disconnected.
Slave state machine will keep waiting for master clock in for rx/tx transmit.
So it need timeout setting to enable timeout unlock controller state.
And in another side. In Master side also need avoid suddenly slave miss(un-plug), Master will timeout and release the SDA/SCL.

Do you mean add those description into ore aspeed,timout properites description?

> 
> > +
> > +  aspeed,xfer-mode:
> > +    description: |
> > +      I2C bus transfer mode selection.
> > +      - "byte": I2C bus byte transfer mode.
> > +      - "buffered": I2C bus buffer register transfer mode.
> > +      - "dma": I2C bus dma transfer mode (default)
> > +    items:
> > +      enum: [byte, buffered, dma]
> > +    maxItems: 1
> 
> Drop, not an array.
> 
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> 
> Wrong ref. This is not an array, but one string.

Sorry, I can't catch your "one string" point.
Could you point me what ref I can refer to?
That I can check into Linux example. Thanks a lot.
> 
> > +
> > +  aspeed,global-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of i2c global register node.
> > +
> >  required:
> >    - reg
> >    - compatible
> > @@ -57,6 +76,19 @@ required:
> >
> >  unevaluatedProperties: false
> >
> > +if:
> 
> This should be under allOf (in this location)
> 
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: aspeed,ast2600-i2cv2
> > +
> > +then:
> > +  properties:
> > +    reg:
> > +      minItems: 2
> > +  required:
> > +    - aspeed,global-regs
> 
> else:
>   aspeed,global-regs: false
> and the same for other v2 properties
> 

Does modify by following? 

allOf:
 -if:
   properties:
    compatible:
      contains:
        const: aspeed,ast2600-i2cv2

 then:
  properties:
    reg:
      minItems: 2
  required:
    - aspeed,global-regs
 else:
    - aspeed,global-regs: false
    -aspeed,timeout: false
    - aspeed,xfer-mode: false

> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/clock/aspeed-clock.h>
> > @@ -71,3 +103,15 @@ examples:
> >        interrupts = <0>;
> >        interrupt-parent = <&i2c_ic>;
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    i2c1: i2c at 80 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      compatible = "aspeed,ast2600-i2cv2";
> > +      reg = <0x80 0x80>, <0xc00 0x20>;
> > +      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +      aspeed,global-regs = <&i2c_global>;
> > +      clocks = <&syscon ASPEED_CLK_APB>;
> > +      resets = <&syscon ASPEED_RESET_I2C>;
> > +    };
> 
Best regards,
Ryan Chen.
