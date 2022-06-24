From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jun 2022 16:39:50 +1000
Subject: [PATCH] usb: gadget: aspeed_udc: fix handling of tx_len == 0
In-Reply-To: <20220624063457.GG11460@kadam>
References: <YrMsU9HvdBm5YrRH@kili>
	 <HK0PR06MB32023259EBD6B4C649C62E8280B59@HK0PR06MB3202.apcprd06.prod.outlook.com>
	 <20220623064320.GN16517@kadam>
	 <e0b1c201bec2ccb68d1779ea8e9cfdf27563dd73.camel@amazon.com>
	 <20220624063457.GG11460@kadam>
Message-ID: <46f88070d8f6f47f55310e964a4576cadbc810f4.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

(switching back to my normal "community" email)

On Fri, 2022-06-24 at 09:34 +0300, Dan Carpenter wrote:
> > Hrm... what is that driver ? I've missed it ... is the code lifted
> > from
> > aspeed-vhub ? If yes, should we instead make it a common code base
> > ?
> > And if there are bug fixes on one they might apply to the other as
> > well...
> 
> 
> No, I'm the person who introduced the bug so it's unique to this
> driver.

Ok thanks. That said, the code looks fairly similar to the vhub code,
so my comment stands, if this is the same IP block, which it appears to
be, the driver should be common.

IE. The vhub is made of a virtual hub with a bunch of UDCs underneath,
this appears to address the ast2600 "new" standalone (no hub) variant
of said UDC if I'm not mistaken.

The way I structured the code in vhub, it shouldn't be overly difficult
to make it standalone. I wrote (and maintain) aspeed-vhub and would be
happy to work on this if I got sent an ast2600 board.

Cheers,
Ben.

