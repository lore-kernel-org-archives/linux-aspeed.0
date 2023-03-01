From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 1 Mar 2023 03:02:11 +0000
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <f4cb3efc9825efa582aa94bd03657b1319ff38fd.camel@codeconstruct.com.au>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
	 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
	 <8999ef4a57b035a81b086d8732d119638d46968c.camel@codeconstruct.com.au>
	 <SEZPR06MB52699858C92383E8E07D0832F2AF9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <f4cb3efc9825efa582aa94bd03657b1319ff38fd.camel@codeconstruct.com.au>
Message-ID: <SEZPR06MB52695281E21B27DB57A7B2FFF2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jeremy,

> -----Original Message-----
> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Monday, February 27, 2023 1:40 PM
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
> > Yes, I2C controller share the same dma engine. The original thought
> > can be enable in all i2c channel. But in AST2600 have ERRATA "I2C DMA
> > fails when DRAM bus is busy and it can not take DMA write data
> > immediately", So it means only 1 i2c bus can be enable for DMA mode.
> 
> OK, this is a pretty important detail! I'd suggest putting it in the binding
> document.

Sorry, Do you mean add in description like following??
  aspeed,xfer-mode:
    description: |
      I2C bus transfer mode selection.
	  ERRATA "I2C DMA fails when DRAM bus is busy and it can not take DMA write data
Immediately", only 1 i2c bus can be enable for DMA mode.
      - "byte": I2C bus byte transfer mode.
      - "buffered": I2C bus buffer register transfer mode.
      - "dma": I2C bus dma transfer mode (default)
      
> Anything in the cover letter will get lost after review. If there is documentation
> that would be useful for a DTS author, I'd suggest putting it in the binding.
> 
> > It means only 1 bus channel can be enable DMA for use case.
> > That following example for board-specific selection.
> > It is description in cover-letter.
> > The following is board-specific design example.
> > Board A???????????????????????????????????????? Board
> B
> > -------------------------
> > ------------------------
> > > i2c bus#1(master/slave)? <===fingerprint ===> i2c bus#x
> > > (master/slave)| i2c bus#2(master)-> tmp i2c device
> |??????? |
> > > | i2c bus#3(master)-> adc i2c device
> |??????? |?????????????????? |
> > -------------------------
> > ------------------------
> >
> > - in bus#1 situation, you should use DMA mode.
> > Because bus#1 have trunk data needed for transfer, it can enable bus
> > dma mode to reduce cpu utilized.
> 
> What is "trunk data" in this context? Is this just a statement about the amount
> of expected transfers?
Sorry, I can't catch your point, for example for most server application usage.
The i2c not only connect with small device (like temperature sensor/ adc).
It also connect with other mcu base device support i2c slave.
Most case is transfer MCTP package. (basic 64kbytes). So I say "trunk data".

> 
> > - in bus#2/3 situation, you should use buffer/byte mode
> > bus#2/3 is small package transmit, it can enable buffer mode or byte
> > mode to reduce memory cache flush overhead.
> > Buffer mode is better, because byte mode have interrupt
> > overhead(interrupt per byte data transmit),
> >
> > -But if you more bus#4 that still have trunk data needed for transfer
> > (master/slave), it also use buffer mode to transmit. Because bus#1
> > have been use for DMA mode.
> 
> So, it sounds like:
> 
>  - there's no point in using byte mode, as buffer mode provides
>    equivalent functionality with fewer drawbacks (ie, less interrupt
>    load)
> 
>  - this just leaves the dma and buffer modes
> 
>  - only one controller can use dma mode
> 
> So: how about just a single boolean property to indicate "use DMA on this
> controller"? Something like aspeed,enable-dma? Or if DT binding experts can
> suggest something common that might be more suitable?

If so, just leave enable-dma and only support for buffer mode and dma mode, am I right?

Best Regards.
Ryan
