From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 01 Mar 2023 11:23:33 +0800
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <SEZPR06MB52695281E21B27DB57A7B2FFF2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
	 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
	 <8999ef4a57b035a81b086d8732d119638d46968c.camel@codeconstruct.com.au>
	 <SEZPR06MB52699858C92383E8E07D0832F2AF9@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <f4cb3efc9825efa582aa94bd03657b1319ff38fd.camel@codeconstruct.com.au>
	 <SEZPR06MB52695281E21B27DB57A7B2FFF2AD9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <c18b064b6b01bd547b2f03006dbf4bb6fdf9b91d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> Sorry, Do you mean add in description like following??
> ? aspeed,xfer-mode:
> ??? description: |
> ????? I2C bus transfer mode selection.
> ????????? ERRATA "I2C DMA fails when DRAM bus is busy and it can not
> take DMA write data
> Immediately", only 1 i2c bus can be enable for DMA mode.
> ????? - "byte": I2C bus byte transfer mode.
> ????? - "buffered": I2C bus buffer register transfer mode.
> ????? - "dma": I2C bus dma transfer mode (default)

I would suggest putting some background about the transfer mode as a
top-level description in the binding.

There has been a lot of discussion here on why the binding specifies
the transfer mode; it would be useful (for future readers) to have a
bit of context on what modes they should use.

Perhaps something like:

    description: |
      [general binding description]

      ASPEED ast2600 platforms have a number of i2c controllers, and share a
      single DMA engine between the set. DTSes can specify the mode of data
      transfer to/from the device - either DMA or programmed I/O - but
      hardware limitations may require a DTS to manually allocate which
      controller can use DMA mode; the enable-dma property allows control of
      this.

      In cases where one the hardware design results in a specific
      controller handling a larger amount of data, a DTS would likely
      allocate DMA mode for that one controller.

- adjusted for whatever property interface we settle on here, of course.

> > So, it sounds like:
> > 
> > ?- there's no point in using byte mode, as buffer mode provides
> > ?? equivalent functionality with fewer drawbacks (ie, less interrupt
> > ?? load)
> > 
> > ?- this just leaves the dma and buffer modes
> > 
> > ?- only one controller can use dma mode
> > 
> > So: how about just a single boolean property to indicate "use DMA
> > on this controller"? Something like aspeed,enable-dma? Or if DT binding
> > experts can suggest something common that might be more suitable?
> 
> If so, just leave enable-dma and only support for buffer mode and dma
> mode, am I right?

Yes, from what you have said so far, I think just a single switch
between DMA / not-DMA is all you need here (unless there is any time
that byte mode is preferable?)

If there is already an existing DT convention for indicating/enabling
DMA capability, I would suggest using that. Otherwise, just a boolean
flag with a sensible name would seem to work fine. The DT experts
probably have a good idea of what works best here :)

Cheers,


Jeremy
