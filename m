From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Oct 2020 07:13:05 +0000
Subject: [PATCH 1/4] ftgmac100: Fix race issue on TX descriptor[0]
In-Reply-To: <d5c4682b3e049f7dac66b17e7a726b8c20ee5789.camel@kernel.crashing.org>
References: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
 <20201019085717.32413-2-dylan_hung@aspeedtech.com>
 <be7a978c48c9f1c6c29583350dee6168385c3039.camel@kernel.crashing.org>
 <CACPK8XdECaKwdQgWFQ=sRBiCjDLXHtMKo=o-xQZPmMZyevOukQ@mail.gmail.com>
 <d5c4682b3e049f7dac66b17e7a726b8c20ee5789.camel@kernel.crashing.org>
Message-ID: <CACPK8Xdyw7eSw6RqJcku_PHANviovmkbjNSONAB4_K+_+Tt1KQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2020 at 06:23, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2020-10-20 at 04:13 +0000, Joel Stanley wrote:
> > On Mon, 19 Oct 2020 at 23:20, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > >
> > > On Mon, 2020-10-19 at 16:57 +0800, Dylan Hung wrote:
> > > > These rules must be followed when accessing the TX descriptor:
> > > >
> > > > 1. A TX descriptor is "cleanable" only when its value is non-zero
> > > > and the owner bit is set to "software"
> > >
> > > Can you elaborate ? What is the point of that change ? The owner
> > > bit
> > > should be sufficient, why do we need to check other fields ?
> >
> > I would like Dylan to clarify too. The datasheet has a footnote below
> > the descriptor layout:
> >
> >  - TXDES#0: Bits 27 ~ 14 are valid only when FTS = 1
> >  - TXDES#1: Bits 31 ~ 0 are valid only when FTS = 1
> >
> > So the ownership bit (31) is not valid unless FTS is set. However,
> > this isn't what his patch does. It adds checks for EDOTR.
>
> No I think it adds a check for everything except EDOTR which just marks
> the end of ring and needs to be ignored in the comparison.

Of course. I missed the invert.

I did some testing with just this patch (and "[4/4] ftgmac100: Restart
MAC HW once") from Dylan. It seemed to resolve the hang, but there
were occasional retries. Putting in some tracing I only hit the
condition in ftgmac100_tx_complete_packet, never in
ftgmac100_hard_start_xmit.

> That said, we do need a better explanation.
>
> One potential bug I did find by looking at my code however is:
>
> static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
> {
>         struct net_device *netdev = priv->netdev;
>         struct ftgmac100_txdes *txdes;
>         struct sk_buff *skb;
>         unsigned int pointer;
>         u32 ctl_stat;
>
>         pointer = priv->tx_clean_pointer;
>         txdes = &priv->txdes[pointer];
>
>         ctl_stat = le32_to_cpu(txdes->txdes0);
>         if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
>                 return false;
>
>         skb = priv->tx_skbs[pointer];
>         netdev->stats.tx_packets++;
>         netdev->stats.tx_bytes += skb->len;
>         ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
>         txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
>
>   ^^^^ There should probably be an smp_wmb() here to ensure that all the above
> stores are visible before the tx clean pointer is updated.
>
>         priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
>
>         return true;
> }
>
> Similarly we probablu should have one before setting tx_pointer in start_xmit().

I added the two smp_wmb you suggested (with only 4/4 applied). This
did the trick; iperf on a gigabit link is running well with no
retries.

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
b/drivers/net/ethernet/faraday/ftgmac100.c
index 331d4bdd4a67..15cdfeb135b0 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -653,6 +653,11 @@ static bool ftgmac100_tx_complete_packet(struct
ftgmac100 *priv)
     ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
     txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);

+    /* Ensure the descriptor config is visible before setting the tx
+     * pointer.
+     */
+    smp_wmb();
+
     priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);

     return true;
@@ -806,6 +811,11 @@ static netdev_tx_t
ftgmac100_hard_start_xmit(struct sk_buff *skb,
     dma_wmb();
     first->txdes0 = cpu_to_le32(f_ctl_stat);

+    /* Ensure the descriptor config is visible before setting the tx
+     * pointer.
+     */
+    smp_wmb();
+
     /* Update next TX pointer */
     priv->tx_pointer = pointer;

I left the test running while writing this email and I did start to
see some retries. I'm not sure if that's because my laptop is one of
the test machines, or if we have another issue.

I will do some further testing over night.

Cheers,

Joel

>
> As for the read side of this, I'm not 100% sure, I'll have to think more about
> it, it *think* the existing barriers are sufficient at first sight.
>
> Cheers,
> Ben.
>
> > >
> > > > 2. A TX descriptor is "writable" only when its value is zero
> > > > regardless the edotr mask.
> > >
> > > Again, why is that ? Can you elaborate ? What race are you trying
> > > to
> > > address here ?
> > >
> > > Cheers,
> > > Ben.
> > >
> > > > Fixes: 52c0cae87465 ("ftgmac100: Remove tx descriptor accessors")
> > > > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > ---
> > > >  drivers/net/ethernet/faraday/ftgmac100.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > index 00024dd41147..7cacbe4aecb7 100644
> > > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > @@ -647,6 +647,9 @@ static bool
> > > > ftgmac100_tx_complete_packet(struct
> > > > ftgmac100 *priv)
> > > >       if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
> > > >               return false;
> > > >
> > > > +     if ((ctl_stat & ~(priv->txdes0_edotr_mask)) == 0)
> > > > +             return false;
> > > > +
> > > >       skb = priv->tx_skbs[pointer];
> > > >       netdev->stats.tx_packets++;
> > > >       netdev->stats.tx_bytes += skb->len;
> > > > @@ -756,6 +759,9 @@ static netdev_tx_t
> > > > ftgmac100_hard_start_xmit(struct sk_buff *skb,
> > > >       pointer = priv->tx_pointer;
> > > >       txdes = first = &priv->txdes[pointer];
> > > >
> > > > +     if (le32_to_cpu(txdes->txdes0) & ~priv->txdes0_edotr_mask)
> > > > +             goto drop;
> > > > +
> > > >       /* Setup it up with the packet head. Don't write the head
> > > > to
> > > > the
> > > >        * ring just yet
> > > >        */
> > > > @@ -787,6 +793,10 @@ static netdev_tx_t
> > > > ftgmac100_hard_start_xmit(struct sk_buff *skb,
> > > >               /* Setup descriptor */
> > > >               priv->tx_skbs[pointer] = skb;
> > > >               txdes = &priv->txdes[pointer];
> > > > +
> > > > +             if (le32_to_cpu(txdes->txdes0) & ~priv-
> > > > > txdes0_edotr_mask)
> > > >
> > > > +                     goto dma_err;
> > > > +
> > > >               ctl_stat = ftgmac100_base_tx_ctlstat(priv,
> > > > pointer);
> > > >               ctl_stat |= FTGMAC100_TXDES0_TXDMA_OWN;
> > > >               ctl_stat |= FTGMAC100_TXDES0_TXBUF_SIZE(len);
>
