From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 28 Oct 2020 11:51:13 +0100
Subject: [PATCH] net: ftgmac100: Ensure tx descriptor updates are visible
In-Reply-To: <CACPK8XfHaGWcDf7vDHoPhqgWQ4LEwxq9EBtbkBngEpHEzJk2SA@mail.gmail.com>
References: <20201020220639.130696-1-joel@jms.id.au>
 <CAK8P3a3gz4rMSkvZZ+TPaBx3B1yHXcUVFDdMFQMGUtEi4xXzyg@mail.gmail.com>
 <428dc31828795ce0b010509c8c30bf0049ad9190.camel@kernel.crashing.org>
 <CACPK8XfHaGWcDf7vDHoPhqgWQ4LEwxq9EBtbkBngEpHEzJk2SA@mail.gmail.com>
Message-ID: <CAK8P3a1xxefNQqhZN6QWC0-uQ=b7hu4JzoidXt8TgemZFb0ykw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 28, 2020 at 5:47 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 22 Oct 2020 at 07:41, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > > >
> > > > +       /* Ensure the descriptor config is visible before setting the tx
> > > > +        * pointer.
> > > > +        */
> > > > +       smp_wmb();
> > > > +
> > >
> > > Shouldn't these be paired with smp_rmb() on the reader side?
> >
> > (Not near the code right now) I *think* the reader already has them
> > where it matters but I might have overlooked something when I quickly
> > checked the other day.
>
> Do we need a read barrier at the start of ftgmac100_tx_complete_packet?
>
>         pointer = priv->tx_clean_pointer;
> <--- here
>         txdes = &priv->txdes[pointer];
>
>         ctl_stat = le32_to_cpu(txdes->txdes0);
>         if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
>                 return false;
>
> This was the only spot I could see that might require one.

No, I don't think this is the one, since tx_clean_pointer is not updated
in the other CPU, only this one. From what I can tell, you have
a communication between three concurrent threads in the TX
path:

a) one CPU runs start_xmit. It reads tx_clean_pointer
    from the second CPU, writes the descriptors for the hardware,
    notifies the hardware and updates tx_pointer.

b) the hardware gets kicked by start_xmit, it reads the
     descriptors, reads the data and updates the descriptors.
     it may send an interrupt, which is not important here.

c) a second CPU runs the poll() function. It reads the
    tx_pointer, reads the descriptors, updates the descriptors
    and updates tx_clean_pointer.

Things get a bit confusing because the tx_pointer and
tx_clean_pointer variables are hidden behind macros
and both sides repeatedly read and write them, with no
serialization.

This is what I would try to untangle it:

- mark both tx_pointer and tx_clean_pointer as
  ____cacheline_aligned_in_smp to avoid the cacheline
 pingpong between the two CPUs

- Use smp_load_acquire() to read a pointer that may have
  been updated by the other thread, and smp_store_release()
  to update the one the other side will read.

- pull these accesses into the callers and only do them
  once if possible

- reconsider the "keep poll() going as long as tx
  packets are queued" logic, and instead serialize
  against the packets that are actually completed
  by the hardware.

        Arnd
