From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Oct 2020 18:40:35 +1100
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <CAK8P3a0qzyb0z-OH-hGNJ8iQoLckVkkz4DQfYpFFd=UuXP3gwA@mail.gmail.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <CAK8P3a2pEfbLDWTppVHmGxXduOWPCwBw-8bMY9h3EbEecsVfTA@mail.gmail.com>
 <32bfb619bbb3cd6f52f9e5da205673702fed228f.camel@kernel.crashing.org>
 <CAK8P3a2j7fV5EFmC8UvSyvXixU8=Nmp6hrJco-fdP2Z+w8bLnA@mail.gmail.com>
 <CAK8P3a0qzyb0z-OH-hGNJ8iQoLckVkkz4DQfYpFFd=UuXP3gwA@mail.gmail.com>
Message-ID: <f3f4243408afb4e31a72b8ccb8cef4ba539c67a3.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-10-21 at 14:11 +0200, Arnd Bergmann wrote:
> (replying to my own mail from a different address to deal with the
> regular one being blacklisted somewhere, sorry for any duplicates)
> 
> On Wed, Oct 21, 2020 at 9:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > On Wed, Oct 21, 2020 at 12:10 AM Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > On Tue, 2020-10-20 at 21:49 +0200, Arnd Bergmann wrote:
> > > > On Tue, Oct 20, 2020 at 11:37 AM Dylan Hung <dylan_hung@aspeedtech.com> wrote:
> > > > > > +1 @first is system memory from dma_alloc_coherent(), right?
> > > > > > 
> > > > > > You shouldn't have to do this. Is coherent DMA memory broken on your
> > > > > > platform?
> > > > > 
> > > > > It is about the arbitration on the DRAM controller.  There are two queues in the dram controller, one is for the CPU access and the other is for the HW engines.
> > > > > When CPU issues a store command, the dram controller just acknowledges cpu's request and pushes the request into the queue.  Then CPU triggers the HW MAC engine, the HW engine starts to fetch the DMA memory.
> > > > > But since the cpu's request may still stay in the queue, the HW engine may fetch the wrong data.
> > > 
> > > Actually, I take back what I said earlier, the above seems to imply
> > > this is more generic.
> > > 
> > > Dylan, please confirm, does this affect *all* DMA capable devices ? If
> > > yes, then it's a really really bad design bug in your chips
> > > unfortunately and the proper fix is indeed to make dma_wmb() do a dummy
> > > read of some sort (what address though ? would any dummy non-cachable
> > > page do ?) to force the data out as *all* drivers will potentially be
> > > affected.
> > > 
> > > I was under the impression that it was a specific timing issue in the
> > > vhub and ethernet parts, but if it's more generic then it needs to be
> > > fixed globally.
> > 
> > We have CONFIG_ARM_HEAVY_MB for SoCs with similar problems,
> > it turns mb() and wmb() into a platform specific function call, though it
> > doesn't do that for dma_wmb() and smp_wmb(), which should not
> > be affected if the problem is only missing serialization between DMA
> > and CPU writes.

Right. I got mixed up by David mention of dma_wmb, it's not the issue
here, it's indeed the ordering of writes to "coherent" memory vs
iowrite.

> > > > If either of the two is the case, then the READ_ONCE() would just
> > > > introduce a long delay before the iowrite32() that makes it more likely
> > > > that the data is there, but the inconsistent state would still be observable
> > > > by the device if it is still working on previous frames.
> > > 
> > > I think it just get stuck until we try another packet, ie, it doesn't
> > > see the new descriptor valid bit. But Dylan can elaborate.
> > 
> > Ok, that would point to an insufficient barrier in iowrite32() as well,
> > not in dma_wmb().

Correct.

> > At the moment, the only chips that need the heavy barrier are
> > omap4 and mstar_v7, and early l2 cache controllers (not the one
> > on Cortex-A7) have another synchronization callback that IIRC
> > is used for streaming mappings.

 .../...

> > Obviously, adding one of these for ast2600 would slow down every
> > mb() and writel() a lot, but if it is a chip-wide problem rather than
> > one isolated to the network device, it would be the correct solution,
> > provided that a correct code sequence can be found.

I'm surprised that problem doesn't already exist on the ast2400 and
2500 and I thus worry about the performance impact of such a workaround
applied generally to every MMIO writes....

But we did kill mmiowb so ... ;-)

Cheers,
Ben.


