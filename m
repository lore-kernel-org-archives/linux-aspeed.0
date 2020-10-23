From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Fri, 23 Oct 2020 13:08:30 +0000
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <529612e1-c6c4-4d33-91df-2a30bf2e1675@www.fastmail.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <CAK8P3a2pEfbLDWTppVHmGxXduOWPCwBw-8bMY9h3EbEecsVfTA@mail.gmail.com>
 <32bfb619bbb3cd6f52f9e5da205673702fed228f.camel@kernel.crashing.org>
 <529612e1-c6c4-4d33-91df-2a30bf2e1675@www.fastmail.com>
Message-ID: <PS1PR0601MB18498469F0263306A6E5183F9C1A0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Andrew Jeffery [mailto:andrew at aj.id.au]
> Sent: Wednesday, October 21, 2020 6:26 AM
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>; Arnd Bergmann
> <arnd@arndb.de>; Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; Po-Yu Chuang <ratbert@faraday-tech.com>;
> netdev <netdev@vger.kernel.org>; OpenBMC Maillist
> <openbmc@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Jakub Kicinski <kuba@kernel.org>; David
> Miller <davem@davemloft.net>
> Subject: Re: [PATCH] net: ftgmac100: Fix missing TX-poll issue
> 
> 
> 
> On Wed, 21 Oct 2020, at 08:40, Benjamin Herrenschmidt wrote:
> > On Tue, 2020-10-20 at 21:49 +0200, Arnd Bergmann wrote:
> > > On Tue, Oct 20, 2020 at 11:37 AM Dylan Hung
> <dylan_hung@aspeedtech.com> wrote:
> > > > > +1 @first is system memory from dma_alloc_coherent(), right?
> > > > >
> > > > > You shouldn't have to do this. Is coherent DMA memory broken on
> > > > > your platform?
> > > >
> > > > It is about the arbitration on the DRAM controller.  There are two
> queues in the dram controller, one is for the CPU access and the other is for
> the HW engines.
> > > > When CPU issues a store command, the dram controller just
> acknowledges cpu's request and pushes the request into the queue.  Then
> CPU triggers the HW MAC engine, the HW engine starts to fetch the DMA
> memory.
> > > > But since the cpu's request may still stay in the queue, the HW engine
> may fetch the wrong data.
> >
> > Actually, I take back what I said earlier, the above seems to imply
> > this is more generic.
> >
> > Dylan, please confirm, does this affect *all* DMA capable devices ? If
> > yes, then it's a really really bad design bug in your chips
> > unfortunately and the proper fix is indeed to make dma_wmb() do a
> > dummy read of some sort (what address though ? would any dummy
> > non-cachable page do ?) to force the data out as *all* drivers will
> > potentially be affected.
> >

The issue was found on our test chip (ast2600 version A0) which is just for testing and won't be mass-produced.  This HW bug has been fixed on ast2600 A1 and later versions.

To verify the HW fix, I run overnight iperf and kvm tests on ast2600A1 without this patch, and get stable result without hanging.
So I think we can discard this patch.

> > I was under the impression that it was a specific timing issue in the
> > vhub and ethernet parts, but if it's more generic then it needs to be
> > fixed globally.
> >
> 
> We see a similar issue in the XDMA engine where it can transfer stale data to
> the host. I think the driver ended up using memcpy_toio() to work around that
> despite using a DMA reserved memory region.
