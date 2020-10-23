From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 23 Oct 2020 10:39:32 +0200
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <f3f4243408afb4e31a72b8ccb8cef4ba539c67a3.camel@kernel.crashing.org>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <CAK8P3a2pEfbLDWTppVHmGxXduOWPCwBw-8bMY9h3EbEecsVfTA@mail.gmail.com>
 <32bfb619bbb3cd6f52f9e5da205673702fed228f.camel@kernel.crashing.org>
 <CAK8P3a2j7fV5EFmC8UvSyvXixU8=Nmp6hrJco-fdP2Z+w8bLnA@mail.gmail.com>
 <CAK8P3a0qzyb0z-OH-hGNJ8iQoLckVkkz4DQfYpFFd=UuXP3gwA@mail.gmail.com>
 <f3f4243408afb4e31a72b8ccb8cef4ba539c67a3.camel@kernel.crashing.org>
Message-ID: <CAK8P3a1JD57NSz+_ffyNwX-ERnDq56taNXryoVyV6ZXzEXft0g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 22, 2020 at 9:41 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2020-10-21 at 14:11 +0200, Arnd Bergmann wrote:
>
> > > At the moment, the only chips that need the heavy barrier are
> > > omap4 and mstar_v7, and early l2 cache controllers (not the one
> > > on Cortex-A7) have another synchronization callback that IIRC
> > > is used for streaming mappings.
>
>  .../...
>
> > > Obviously, adding one of these for ast2600 would slow down every
> > > mb() and writel() a lot, but if it is a chip-wide problem rather than
> > > one isolated to the network device, it would be the correct solution,
> > > provided that a correct code sequence can be found.
>
> I'm surprised that problem doesn't already exist on the ast2400 and
> 2500 and I thus worry about the performance impact of such a workaround
> applied generally to every MMIO writes....
>
> But we did kill mmiowb so ... ;-)

The real cost would have to be measured of course, and it depends a
lot on how it's done. The read-from-uncached-memory as in the 1/4
patch here seems fairly expensive, the mstarv7_mb() method (spinning
on an mmio read) seems worse, but the omap4 method (a posted write
to a mmio address in the memory controller to enforce a barrier between
the two ports) doesn't seem that bad and would correspond to what
the chip should be doing in the first place.

       Arnd
