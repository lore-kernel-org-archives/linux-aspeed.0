From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Oct 2020 09:05:34 +1100
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <f75555e09d47476a871669ffe017c4f8@AcuMS.aculab.com>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <f75555e09d47476a871669ffe017c4f8@AcuMS.aculab.com>
Message-ID: <7b44608bed9eccad80457cbfdfcca9043aae56f2.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-10-20 at 13:15 +0000, David Laight wrote:
> That rather depends where the data is 'stuck'.
> 
> An old sparc cpu would flush the cpu store buffer before the read.
> But a modern x86 cpu will satisfy the read from the store buffer
> for cached data.
> 
> If the write is 'posted' on a PCI(e) bus then the read can't overtake it.
> But that is a memory access so shouldn't be to a PCI(e) address.
> 
> Shouldn't dma_wb() actually force your 'cpu to dram' queue be flushed?
> In which case you need one after writing the ring descriptor and
> before the poke of the mac engine.
> 
> The barrier before the descriptor write only needs to guarantee
> ordering of the writes - it can probably be a lighter barrier?
> 
> It might be that your dma_wmb() needs to do a write+read of
> an uncached DRAM location in order to empty the cpu to dram queue.

This is a specific bug with how a specific IP block is hooked up in
those SOCs, I wouldn't bloat the global dma_wmb for that. The read back
in the driver with appropriate comment should be enough.

Cheers,
Ben.


