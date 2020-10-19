From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 19 Oct 2020 12:00:40 -0700
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
Message-ID: <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2020 08:57:03 +0000 Joel Stanley wrote:
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> > index 00024dd41147..9a99a87f29f3 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -804,7 +804,8 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
> >          * before setting the OWN bit on the first descriptor.
> >          */
> >         dma_wmb();
> > -       first->txdes0 = cpu_to_le32(f_ctl_stat);
> > +       WRITE_ONCE(first->txdes0, cpu_to_le32(f_ctl_stat));
> > +       READ_ONCE(first->txdes0);  
> 
> I understand what you're trying to do here, but I'm not sure that this
> is the correct way to go about it.
> 
> It does cause the compiler to produce a store and then a load.

+1 @first is system memory from dma_alloc_coherent(), right?

You shouldn't have to do this. Is coherent DMA memory broken 
on your platform?
