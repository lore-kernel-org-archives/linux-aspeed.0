From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 23 Jun 2022 07:52:28 +0000
Subject: [PATCH] usb: gadget: aspeed_udc: fix handling of tx_len == 0
In-Reply-To: <20220623072216.GQ16517@kadam>
References: <YrMsU9HvdBm5YrRH@kili>
 <HK0PR06MB32023259EBD6B4C649C62E8280B59@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <20220623064320.GN16517@kadam> <20220623072216.GQ16517@kadam>
Message-ID: <HK0PR06MB3202379EBEFD773974832F8080B59@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Thu, Jun 23, 2022 at 09:43:20AM +0300, Dan Carpenter wrote:
> > On Thu, Jun 23, 2022 at 01:41:49AM +0000, Neal Liu wrote:
> > > > The bug is that we should still enter this loop if "tx_len" is zero.
> > > >
> > > > After adding the "last" variable, then the "chunk >= 0" condition
> > > > is no longer required but I left it for readability.
> > > >
> > >
> > > Use either "chunk >=0" or "last".
> > > I think the former is more simpler.
> >
> > chunk >= 0 doesn't work.  last works but I think this way is more
> > readable.
> 
> Fine, I can remove the chunk >= 0.  But you can see why your idea of
> removing the "last" doesn't work, right?  I mean maybe it does work and
> there was a bug in the original code?  Could you please look at that so we're
> for sure writing correct code?
> 

Why removing the "last" doesn't work? If "chunk == 0", it would go through while loop once, and chunk will be negative (chunk -= ep->chunk_max).

Best Regards,
-Neal


