From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 27 Feb 2023 13:40:12 +0800
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <SEZPR06MB52699858C92383E8E07D0832F2AF9@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
	 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
	 <8999ef4a57b035a81b086d8732d119638d46968c.camel@codeconstruct.com.au>
	 <SEZPR06MB52699858C92383E8E07D0832F2AF9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <f4cb3efc9825efa582aa94bd03657b1319ff38fd.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> Yes, I2C controller share the same dma engine. The original thought
> can be enable in all i2c channel. But in AST2600 have ERRATA "I2C DMA
> fails when DRAM bus is busy and it can not take DMA write data
> immediately", So it means only 1 i2c bus can be enable for DMA mode.

OK, this is a pretty important detail! I'd suggest putting it in the
binding document.

Anything in the cover letter will get lost after review. If there is
documentation that would be useful for a DTS author, I'd suggest putting
it in the binding.

> It means only 1 bus channel can be enable DMA for use case.
> That following example for board-specific selection.
> It is description in cover-letter.
> The following is board-specific design example.
> Board A???????????????????????????????????????? Board B
> -------------------------?????????????????????? ------------------------
> > i2c bus#1(master/slave)? <===fingerprint ===> i2c bus#x (master/slave)|
> > i2c bus#2(master)-> tmp i2c device |??????? |?????????????????? |
> > i2c bus#3(master)-> adc i2c device |??????? |?????????????????? |
> -------------------------?????????????????????? ------------------------
> 
> - in bus#1 situation, you should use DMA mode.
> Because bus#1 have trunk data needed for transfer, it can enable bus
> dma mode to reduce cpu utilized.

What is "trunk data" in this context? Is this just a statement about the
amount of expected transfers?

> - in bus#2/3 situation, you should use buffer/byte mode
> bus#2/3 is small package transmit, it can enable buffer mode or byte
> mode to reduce memory cache flush overhead.
> Buffer mode is better, because byte mode have interrupt
> overhead(interrupt per byte data transmit),
> 
> -But if you more bus#4 that still have trunk data needed for transfer
> (master/slave),
> it also use buffer mode to transmit. Because bus#1 have been use for
> DMA mode.

So, it sounds like:

 - there's no point in using byte mode, as buffer mode provides
   equivalent functionality with fewer drawbacks (ie, less interrupt
   load)

 - this just leaves the dma and buffer modes

 - only one controller can use dma mode

So: how about just a single boolean property to indicate "use DMA on
this controller"? Something like aspeed,enable-dma? Or if DT binding
experts can suggest something common that might be more suitable?

Cheers,


Jeremy
