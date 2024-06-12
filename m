From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 12 Jun 2024 14:23:32 +0800
Subject: [PATCH] usb: gadget: aspeed_udc: fix device address
 configuration
In-Reply-To: <OS8PR06MB7541C6D06FEC637644BEC5D2F2C02@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240612-aspeed-udc-v1-1-d277b553aecf@codeconstruct.com.au>
	 <OS8PR06MB7541C6D06FEC637644BEC5D2F2C02@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <9f2f14979faa5a6d0b17601cfec4988a374ce0c8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

> > /* Main config reg */
> > -#define UDC_CFG_SET_ADDR(x)????????????((x) & 0x3f)
> > -#define UDC_CFG_ADDR_MASK??????????????(0x3f)
> > +#define UDC_CFG_SET_ADDR(x)????????????((x) & UDC_CFG_ADDR_MASK)
> > +#define UDC_CFG_ADDR_MASK??????????????GENMASK(6, 0)
> > 
> 
> It should be GENMASK(5,0), not GENMASK(6, 0), am I? right?

No, that was the bug: we need bits 0:6 (== 0x7f) here.

With the mask of 0:5 (== 0x3f), we don't get the full USB address set.

Cheers,


Jeremy
