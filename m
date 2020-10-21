From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Oct 2020 09:16:25 +0200
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <32bfb619bbb3cd6f52f9e5da205673702fed228f.camel@kernel.crashing.org>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <CAK8P3a2pEfbLDWTppVHmGxXduOWPCwBw-8bMY9h3EbEecsVfTA@mail.gmail.com>
 <32bfb619bbb3cd6f52f9e5da205673702fed228f.camel@kernel.crashing.org>
Message-ID: <CAK8P3a2j7fV5EFmC8UvSyvXixU8=Nmp6hrJco-fdP2Z+w8bLnA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2020 at 12:10 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2020-10-20 at 21:49 +0200, Arnd Bergmann wrote:
> > On Tue, Oct 20, 2020 at 11:37 AM Dylan Hung <dylan_hung@aspeedtech.com> wrote:
> > > > +1 @first is system memory from dma_alloc_coherent(), right?
> > > >
> > > > You shouldn't have to do this. Is coherent DMA memory broken on your
> > > > platform?
> > >
> > > It is about the arbitration on the DRAM controller.  There are two queues in the dram controller, one is for the CPU access and the other is for the HW engines.
> > > When CPU issues a store command, the dram controller just acknowledges cpu's request and pushes the request into the queue.  Then CPU triggers the HW MAC engine, the HW engine starts to fetch the DMA memory.
> > > But since the cpu's request may still stay in the queue, the HW engine may fetch the wrong data.
>
> Actually, I take back what I said earlier, the above seems to imply
> this is more generic.
>
> Dylan, please confirm, does this affect *all* DMA capable devices ? If
> yes, then it's a really really bad design bug in your chips
> unfortunately and the proper fix is indeed to make dma_wmb() do a dummy
> read of some sort (what address though ? would any dummy non-cachable
> page do ?) to force the data out as *all* drivers will potentially be
> affected.
>
> I was under the impression that it was a specific timing issue in the
> vhub and ethernet parts, but if it's more generic then it needs to be
> fixed globally.

We have CONFIG_ARM_HEAVY_MB for SoCs with similar problems,
it turns mb() and wmb() into a platform specific function call, though it
doesn't do that for dma_wmb() and smp_wmb(), which should not
be affected if the problem is only missing serialization between DMA
and CPU writes.

> > If either of the two is the case, then the READ_ONCE() would just
> > introduce a long delay before the iowrite32() that makes it more likely
> > that the data is there, but the inconsistent state would still be observable
> > by the device if it is still working on previous frames.
>
> I think it just get stuck until we try another packet, ie, it doesn't
> see the new descriptor valid bit. But Dylan can elaborate.

Ok, that would point to an insufficient barrier in iowrite32() as well,
not in dma_wmb().

At the moment, the only chips that need the heavy barrier are
omap4 and mstar_v7, and early l2 cache controllers (not the one
on Cortex-A7) have another synchronization callback that IIRC
is used for streaming mappings.

These are the two implementations of soc_mb() we have:

/*
 * This may need locking to deal with situations where an interrupt
 * happens while we are in here and mb() gets called by the interrupt handler.
 *
 * The vendor code did have a spin lock but it doesn't seem to be needed and
 * removing it hasn't caused any side effects so far.
*
 * [writel|readl]_relaxed have to be used here because otherwise
 * we'd end up right back in here.
 */
static void mstarv7_mb(void)
{
       /* toggle the flush miu pipe fire bit */
       writel_relaxed(0, l3bridge + MSTARV7_L3BRIDGE_FLUSH);
       writel_relaxed(MSTARV7_L3BRIDGE_FLUSH_TRIGGER, l3bridge
                       + MSTARV7_L3BRIDGE_FLUSH);
       while (!(readl_relaxed(l3bridge + MSTARV7_L3BRIDGE_STATUS)
                       & MSTARV7_L3BRIDGE_STATUS_DONE)) {
               /* wait for flush to complete */
       }
}
/*
 * OMAP4 interconnect barrier which is called for each mb() and wmb().
 * This is to ensure that normal paths to DRAM (normal memory, cacheable
 * accesses) are properly synchronised with writes to DMA coherent memory
 * (normal memory, uncacheable) and device writes.
 *
 * The mb() and wmb() barriers only operate only on the MPU->MA->EMIF
 * path, as we need to ensure that data is visible to other system
 * masters prior to writes to those system masters being seen.
 *
 * Note: the SRAM path is not synchronised via mb() and wmb().
 */
static void omap4_mb(void)
{
       if (dram_sync)
               writel_relaxed(0, dram_sync);
}

Obviously, adding one of these for ast2600 would slow down every
mb() and writel() a lot, but if it is a chip-wide problem rather than
one isolated to the network device, it would be the correct solution,
provided that a correct code sequence can be found.

      Arnd
