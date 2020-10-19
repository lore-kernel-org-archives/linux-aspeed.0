From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Oct 2020 10:23:41 +1100
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <1a02e57b6b7d425a19dc59f84091c38ca4edcf47.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-10-19 at 12:00 -0700, Jakub Kicinski wrote:
> On Mon, 19 Oct 2020 08:57:03 +0000 Joel Stanley wrote:
> > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > index 00024dd41147..9a99a87f29f3 100644
> > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > @@ -804,7 +804,8 @@ static netdev_tx_t
> > > ftgmac100_hard_start_xmit(struct sk_buff *skb,
> > >          * before setting the OWN bit on the first descriptor.
> > >          */
> > >         dma_wmb();
> > > -       first->txdes0 = cpu_to_le32(f_ctl_stat);
> > > +       WRITE_ONCE(first->txdes0, cpu_to_le32(f_ctl_stat));
> > > +       READ_ONCE(first->txdes0);  
> > 
> > I understand what you're trying to do here, but I'm not sure that
> > this
> > is the correct way to go about it.
> > 
> > It does cause the compiler to produce a store and then a load.
> 
> +1 @first is system memory from dma_alloc_coherent(), right?
> 
> You shouldn't have to do this. Is coherent DMA memory broken 
> on your platform?

I suspect the problem is that the HW (and yes this would be a HW bug)
doesn't order the CPU -> memory and the CPU -> MMIO path.

What I think happens is that the store to txde0 is potentially still in
a buffer somewhere on its way to memory, gets bypassed by the store to
MMIO, causing the MAC to try to read the descriptor, and getting the
"old" data from memory.

It's ... fishy, but that isn't the first time an Aspeed chip has that
type of bug (there's a similar one in the USB device controler iirc).

Cheers,
Ben.


