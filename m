From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 27 Feb 2023 04:12:52 +0000
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <8999ef4a57b035a81b086d8732d119638d46968c.camel@codeconstruct.com.au>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
	 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
 <8999ef4a57b035a81b086d8732d119638d46968c.camel@codeconstruct.com.au>
Message-ID: <SEZPR06MB52699858C92383E8E07D0832F2AF9@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jeremy,

> -----Original Message-----
> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Sunday, February 26, 2023 3:04 PM
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
> Hi Ryan,
> 
> > --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> > @@ -49,6 +49,25 @@ properties:
> > ???? description:
> > ?????? states that there is another master active on this bus
> >
> > +? aspeed,timeout:
> > +??? type: boolean
> > +??? description: I2C bus timeout enable for master/slave mode
> > +
> > +? aspeed,xfer-mode:
> > +??? description: |
> > +????? I2C bus transfer mode selection.
> > +????? - "byte": I2C bus byte transfer mode.
> > +????? - "buffered": I2C bus buffer register transfer mode.
> > +????? - "dma": I2C bus dma transfer mode (default)
> > +??? items:
> > +????? enum: [byte, buffered, dma]
> > +??? maxItems: 1
> > +??? $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> 
> There are still unresolved questions about this xfer-mode property from
> previous submissions of this binding. We don't yet have a justification on why
> the mode configuration is needed in the device tree rather than something
> that is specified in a driver implementation.
> 
> By now, I think we well understand what the modes are, and how a driver
> implementation might configure them, but none of that has (so far) provided
> sufficient rationale on why this belongs in the device tree.
> 
> The previous threads had a couple of pending discussions, following up on
> those here:
> 
> A) You mentioned in [1] that the DMA controller is shared between all i3c
> devices, does that have any consequence on which modes individual devices
> might want to choose?

Yes, I2C controller share the same dma engine. The original thought can be enable in
all i2c channel. But in AST2600 have ERRATA "I2C DMA fails when DRAM bus is busy
and it can not take DMA write data immediately", So it means only 1 i2c bus can be
enable for DMA mode.
It means only 1 bus channel can be enable DMA for use case.
That following example for board-specific selection.
It is description in cover-letter.

The following is board-specific design example.
Board A                                         Board B
-------------------------                       ------------------------
|i2c bus#1(master/slave)  <===fingerprint ===> i2c bus#x (master/slave)|
|i2c bus#2(master)-> tmp i2c device |        |                   |
|i2c bus#3(master)-> adc i2c device |        |                   |
-------------------------                       ------------------------

- in bus#1 situation, you should use DMA mode.
Because bus#1 have trunk data needed for transfer, it can enable bus dma mode to reduce cpu utilized.
- in bus#2/3 situation, you should use buffer/byte mode
bus#2/3 is small package transmit, it can enable buffer mode or byte mode to reduce memory cache flush overhead.
Buffer mode is better, because byte mode have interrupt overhead(interrupt per byte data transmit),

-But if you more bus#4 that still have trunk data needed for transfer (master/slave),
it also use buffer mode to transmit. Because bus#1 have been use for DMA mode.

Best Regards.
Ryan Chen.

> 
> B) You implied in [2] that the different transfer modes might be related to
> whether there are other masters present on the bus, but the logic behind that
> is not clear.
> 
> C) In [3] you mentioned that there might be some DRAM savings by using a
> particular mode.
> 
> and, most importantly:
> 
> D) unanswered from [4] and [5]: what are the hardware-specified reasons why
> a DT author would chose one mode over another?
> 
> If you can write this out in some format like:
> 
>  - in hardware situation X, you should use DMA mode
>  - in hardware situation Y, you should use byte mode
>  - [...]
> 
> that might help us to understand where this configuration belongs, or what a
> reasonable DT representation should look like, or even if existing DT schema
> can already provide the information required to decide.
> 
> Cheers,
> 
> 
> Jeremy
> 
> [1]:
> https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009876.html
> [2]:
> https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009892.html
> [3]:
> https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009880.html
> [4]:
> https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009871.html
> [5]:
> https://lists.ozlabs.org/pipermail/linux-aspeed/2023-February/009884.html
