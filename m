From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 20 Oct 2020 13:15:11 +0000
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
Message-ID: <f75555e09d47476a871669ffe017c4f8@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dylan Hung
> Sent: 20 October 2020 07:15
> 
> > -----Original Message-----
> > From: Jakub Kicinski [mailto:kuba at kernel.org]
> >
> > On Mon, 19 Oct 2020 08:57:03 +0000 Joel Stanley wrote:
> > > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > index 00024dd41147..9a99a87f29f3 100644
> > > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > @@ -804,7 +804,8 @@ static netdev_tx_t
> > ftgmac100_hard_start_xmit(struct sk_buff *skb,
> > > >          * before setting the OWN bit on the first descriptor.
> > > >          */
> > > >         dma_wmb();
> > > > -       first->txdes0 = cpu_to_le32(f_ctl_stat);
> > > > +       WRITE_ONCE(first->txdes0, cpu_to_le32(f_ctl_stat));
> > > > +       READ_ONCE(first->txdes0);
> > >
> > > I understand what you're trying to do here, but I'm not sure that this
> > > is the correct way to go about it.
> > >
> > > It does cause the compiler to produce a store and then a load.
> 
> Yes, the load instruction here is to guarantee the previous store is indeed
> pushed onto the physical memory.

That rather depends where the data is 'stuck'.

An old sparc cpu would flush the cpu store buffer before the read.
But a modern x86 cpu will satisfy the read from the store buffer
for cached data.

If the write is 'posted' on a PCI(e) bus then the read can't overtake it.
But that is a memory access so shouldn't be to a PCI(e) address.

Shouldn't dma_wb() actually force your 'cpu to dram' queue be flushed?
In which case you need one after writing the ring descriptor and
before the poke of the mac engine.

The barrier before the descriptor write only needs to guarantee
ordering of the writes - it can probably be a lighter barrier?

It might be that your dma_wmb() needs to do a write+read of
an uncached DRAM location in order to empty the cpu to dram queue.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

