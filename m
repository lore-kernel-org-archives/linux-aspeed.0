From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 20 Oct 2020 06:14:52 +0000
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Jakub Kicinski [mailto:kuba at kernel.org]
> Sent: Tuesday, October 20, 2020 3:01 AM
> To: Joel Stanley <joel@jms.id.au>
> Cc: Dylan Hung <dylan_hung@aspeedtech.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>; David S . Miller <davem@davemloft.net>;
> netdev at vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Po-Yu Chuang <ratbert@faraday-tech.com>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; OpenBMC Maillist
> <openbmc@lists.ozlabs.org>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] net: ftgmac100: Fix missing TX-poll issue
> 
> On Mon, 19 Oct 2020 08:57:03 +0000 Joel Stanley wrote:
> > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > index 00024dd41147..9a99a87f29f3 100644
> > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > @@ -804,7 +804,8 @@ static netdev_tx_t
> ftgmac100_hard_start_xmit(struct sk_buff *skb,
> > >          * before setting the OWN bit on the first descriptor.
> > >          */
> > >         dma_wmb();
> > > -       first->txdes0 = cpu_to_le32(f_ctl_stat);
> > > +       WRITE_ONCE(first->txdes0, cpu_to_le32(f_ctl_stat));
> > > +       READ_ONCE(first->txdes0);
> >
> > I understand what you're trying to do here, but I'm not sure that this
> > is the correct way to go about it.
> >
> > It does cause the compiler to produce a store and then a load.

Yes, the load instruction here is to guarantee the previous store is indeed pushed onto the physical memory.

> 
> +1 @first is system memory from dma_alloc_coherent(), right?
> 
> You shouldn't have to do this. Is coherent DMA memory broken on your
> platform?

It is about the arbitration on the DRAM controller.  There are two queues in the dram controller, one is for the CPU access and the other is for the HW engines.
When CPU issues a store command, the dram controller just acknowledges cpu's request and pushes the request into the queue.  Then CPU triggers the HW MAC engine, the HW engine starts to fetch the DMA memory.
But since the cpu's request may still stay in the queue, the HW engine may fetch the wrong data.
