From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 04:47:38 +0000
Subject: [PATCH] net: ftgmac100: Ensure tx descriptor updates are visible
In-Reply-To: <428dc31828795ce0b010509c8c30bf0049ad9190.camel@kernel.crashing.org>
References: <20201020220639.130696-1-joel@jms.id.au>
 <CAK8P3a3gz4rMSkvZZ+TPaBx3B1yHXcUVFDdMFQMGUtEi4xXzyg@mail.gmail.com>
 <428dc31828795ce0b010509c8c30bf0049ad9190.camel@kernel.crashing.org>
Message-ID: <CACPK8XfHaGWcDf7vDHoPhqgWQ4LEwxq9EBtbkBngEpHEzJk2SA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2020 at 07:41, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-10-21 at 14:40 +0200, Arnd Bergmann wrote:
> > On Wed, Oct 21, 2020 at 12:39 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > >
> > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> > > index 331d4bdd4a67..15cdfeb135b0 100644
> > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > @@ -653,6 +653,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
> > >         ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
> > >         txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
> > >
> > > +       /* Ensure the descriptor config is visible before setting the tx
> > > +        * pointer.
> > > +        */
> > > +       smp_wmb();
> > > +
> > >         priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
> > >
> > >         return true;
> > > @@ -806,6 +811,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
> > >         dma_wmb();
> > >         first->txdes0 = cpu_to_le32(f_ctl_stat);
> > >
> > > +       /* Ensure the descriptor config is visible before setting the tx
> > > +        * pointer.
> > > +        */
> > > +       smp_wmb();
> > > +
> >
> > Shouldn't these be paired with smp_rmb() on the reader side?
>
> (Not near the code right now) I *think* the reader already has them
> where it matters but I might have overlooked something when I quickly
> checked the other day.

Do we need a read barrier at the start of ftgmac100_tx_complete_packet?

        pointer = priv->tx_clean_pointer;
<--- here
        txdes = &priv->txdes[pointer];

        ctl_stat = le32_to_cpu(txdes->txdes0);
        if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
                return false;

This was the only spot I could see that might require one.

Cheers,

Joel
