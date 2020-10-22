From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 22 Oct 2020 18:37:58 +1100
Subject: [PATCH] net: ftgmac100: Ensure tx descriptor updates are visible
In-Reply-To: <dca2ce4487024eba9398426af86c761d@AcuMS.aculab.com>
References: <20201020220639.130696-1-joel@jms.id.au>
 <86480db3977cfbf6750209c34a28c8f042be55fb.camel@kernel.crashing.org>
 <dca2ce4487024eba9398426af86c761d@AcuMS.aculab.com>
Message-ID: <ef0d576f4eba266b60586b93c6ace79ed3cc7096.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-10-21 at 08:18 +0000, David Laight wrote:
> From: Benjamin Herrenschmidt
> > Sent: 21 October 2020 01:00
> > 
> > On Wed, 2020-10-21 at 08:36 +1030, Joel Stanley wrote:
> > > We must ensure the tx descriptor updates are visible before updating
> > > the tx pointer.
> > > 
> > > This resolves the tx hangs observed on the 2600 when running iperf:
> > 
> > To clarify the comment here. This doesn't ensure they are visible to
> > the hardware but to other CPUs. This is the ordering vs start_xmit and
> > tx_complete.
> 
> You need two barriers.
> 1) after making the data buffers available before transferring
> the descriptor ownership to the device.
> 2) after transferring the ownership before 'kicking' the mac engine.
> 
> The first is needed because the mac engine can poll the descriptors
> at any time (eg on completing the previous transmit).
> This stops it transmitting garbage.
> 
> The second makes sure it finds the descriptor you've just set.
> This stops delays before sending the packet.
> (But it will get sent later.)

The above is unrelated to this patch. This isn't about fixing any
device <-> CPU ordering or interaction but purely about ensuring proper
ordering between start_xmit and tx packet cleanup. IE. We are looking
at two different issues with this driver.

> For (2) dma_wmb() is the documented barrier.
> 
> I'm not sure which barrier you need for (1).
> smp_wmb() would be right if the reader were another cpu,
> but it is (at most) a compile barrier on UP kernels.
> So you need something stronger than smp_wmb().

There should already be sufficient barriers for that in the driver
(except for the HW bug mentioned earlier).

> On a TSO system (which yours probably is) a compile barrier
> is probably sufficient, but if memory writes can get re-ordered
> it needs to be a stronger barrier - but not necessarily as strong
> as dma_wmb().
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

