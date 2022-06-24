From: Herrenschmidt, Benjamin <benh@amazon.com>
Date: Fri, 24 Jun 2022 06:17:31 +0000
Subject: [PATCH] usb: gadget: aspeed_udc: fix handling of tx_len == 0
In-Reply-To: <20220623064320.GN16517@kadam>
References: <YrMsU9HvdBm5YrRH@kili>
	 <HK0PR06MB32023259EBD6B4C649C62E8280B59@HK0PR06MB3202.apcprd06.prod.outlook.com>
	 <20220623064320.GN16517@kadam>
Message-ID: <e0b1c201bec2ccb68d1779ea8e9cfdf27563dd73.camel@amazon.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2022-06-23 at 09:43 +0300, Dan Carpenter wrote:
> On Thu, Jun 23, 2022 at 01:41:49AM +0000, Neal Liu wrote:
> > > The bug is that we should still enter this loop if "tx_len" is
> > > zero.
> > > 
> > > After adding the "last" variable, then the "chunk >= 0" condition
> > > is no longer
> > > required but I left it for readability.
> > > 
> > 
> > Use either "chunk >=0" or "last".
> > I think the former is more simpler.
> 
> chunk >= 0 doesn't work.  last works but I think this way is more
> readable.

Hrm... what is that driver ? I've missed it ... is the code lifted from
aspeed-vhub ? If yes, should we instead make it a common code base ?
And if there are bug fixes on one they might apply to the other as
well...

Neal, is that "UDC" IP block the same that resides under the vhub ? If
yes then this really needs to be a common driver instead, using the
code existing in aspeed-vhub, simply making it able to work without a
parent vhub pointer.

Cheers,
Ben.
