From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Oct 2020 21:49:17 +0200
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
Message-ID: <CAK8P3a2pEfbLDWTppVHmGxXduOWPCwBw-8bMY9h3EbEecsVfTA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2020 at 11:37 AM Dylan Hung <dylan_hung@aspeedtech.com> wrote:
> > +1 @first is system memory from dma_alloc_coherent(), right?
> >
> > You shouldn't have to do this. Is coherent DMA memory broken on your
> > platform?
>
> It is about the arbitration on the DRAM controller.  There are two queues in the dram controller, one is for the CPU access and the other is for the HW engines.
> When CPU issues a store command, the dram controller just acknowledges cpu's request and pushes the request into the queue.  Then CPU triggers the HW MAC engine, the HW engine starts to fetch the DMA memory.
> But since the cpu's request may still stay in the queue, the HW engine may fetch the wrong data.

There is still something missing in the explanation: The iowrite32()
only tells the
device that it should check the queue, but not where the data is. I would expect
the device to either see the correct data that was marked valid by the
'dma_wmb();first->txdes0 = cpu_to_le32(f_ctl_stat);' operation, or it would see
the old f_ctl_stat value telling it that the data is not yet valid and
not look at
the rest of the descriptor. In the second case you would see the data
not getting sent out until the next start_xmit(), but the device should not
fetch wrong data.

There are two possible scenarios in which your patch would still help:

a) the dma_wmb() does not serialize the stores as seen by DMA the
    way it is supposed to, so the device can observe the new value of txdec0
    before it observes the correct data.

b) The txdes0 field sometimes contains stale data that marks the
    descriptor as valid before the correct data is written. This field
    should have been set in ftgmac100_tx_complete_packet() earlier

If either of the two is the case, then the READ_ONCE() would just
introduce a long delay before the iowrite32() that makes it more likely
that the data is there, but the inconsistent state would still be observable
by the device if it is still working on previous frames.

        Arnd
