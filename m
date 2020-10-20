From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 20 Oct 2020 10:24:15 -0700
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <3ebaa814fe21eb7b4b25a2c9455a34434e0207d6.camel@kernel.crashing.org>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1a02e57b6b7d425a19dc59f84091c38ca4edcf47.camel@kernel.crashing.org>
 <20201019195723.41a5591f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <3ebaa814fe21eb7b4b25a2c9455a34434e0207d6.camel@kernel.crashing.org>
Message-ID: <20201020102415.52b51895@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2020 17:15:42 +1100 Benjamin Herrenschmidt wrote:
> On Mon, 2020-10-19 at 19:57 -0700, Jakub Kicinski wrote:
> > > I suspect the problem is that the HW (and yes this would be a HW bug)
> > > doesn't order the CPU -> memory and the CPU -> MMIO path.
> > > 
> > > What I think happens is that the store to txde0 is potentially still in
> > > a buffer somewhere on its way to memory, gets bypassed by the store to
> > > MMIO, causing the MAC to try to read the descriptor, and getting the
> > > "old" data from memory.  
> > 
> > I see, but in general this sort of a problem should be resolved by
> > adding an appropriate memory barrier. And in fact such barrier should
> > (these days) be implied by a writel (I'm not 100% clear on why this
> > driver uses iowrite, and if it matters).  
> 
> No, a barrier won't solve this I think.
> 
> This is a coherency problem at the fabric/interconnect level. I has to
> do with the way they implemented the DMA path from memory to the
> ethernet controller using a different "port" of the memory controller
> than the one used by the CPU, separately from the MMIO path, with no
> proper ordering between those busses. Old school design .... and
> broken.
> 
> By doing a read back, they probably force the previous write to memory
> to get past the point where it will be visible to a subsequent DMA read
> by the ethernet controller.

Thanks for the explanation. How wonderful :/

It'd still be highly, highly preferable if the platform was conforming
to the Linux memory model. IO successors (iowrite32 / writel) must
ensure previous DRAM writes had completed. For performance sensitive
ops, which don't require ordering we have writel_relaxed etc.

I assume the DRAM controller queue is a straight FIFO and we don't have
to worry about hitting the same address, so how about we add a read
of some known uncached address in iowrite32 / writel?
