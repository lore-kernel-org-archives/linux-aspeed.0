From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Fri, 30 Jul 2021 20:10:22 +0000
Subject: [PATCH 08/14] peci: Add device detection
In-Reply-To: <20210729205013.GW8018@packtop>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-9-iwona.winiarska@intel.com>
 <20210727174900.GR8018@packtop>
 <47440a8329ce06c41ca9746db42cb1d66154ea46.camel@intel.com>
 <20210729205013.GW8018@packtop>
Message-ID: <e09a84385be48304d01584c6d629c0f56caad8a1.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2021-07-29 at 20:50 +0000, Zev Weiss wrote:
> On Thu, Jul 29, 2021 at 01:55:19PM CDT, Winiarska, Iwona wrote:
> > On Tue, 2021-07-27 at 17:49 +0000, Zev Weiss wrote:
> > > On Mon, Jul 12, 2021 at 05:04:41PM CDT, Iwona Winiarska wrote:
> > > > 
> > > > +
> > > > +static int peci_detect(struct peci_controller *controller, u8 addr)
> > > > +{
> > > > +???????struct peci_request *req;
> > > > +???????int ret;
> > > > +
> > > > +???????req = peci_request_alloc(NULL, 0, 0);
> > > > +???????if (!req)
> > > > +???????????????return -ENOMEM;
> > > > +
> > > 
> > > Might be worth a brief comment here noting that an empty request happens
> > > to be the format of a PECI ping command (and/or change the name of the
> > > function to peci_ping()).
> > 
> > I'll add a comment:
> > "We are using PECI Ping command to detect presence of PECI devices."
> > 
> 
> Well, what I was more aiming to get at was that to someone not
> intimately familiar with the PECI protocol it's not immediately obvious
> from the code that it in fact implements a ping (there's no 'msg->cmd =
> PECI_CMD_PING' or anything), so I was hoping for something that would
> just make that slightly more explicit.

/*
 * PECI Ping is a command encoded by tx_len = 0, rx_len = 0.
 * We expect correct Write FCS if the device at the target address is
 * able to respond.
 */

I would like to avoid doing a peci_ping wrapper that doesn't operate on
peci_device - note that at this point we don't have a struct peci_device yet,
we're using ping to figure out whether we should create one.

> > > > +
> > > > +/**
> > > > + * peci_request_alloc() - allocate &struct peci_request with buffers
> > > > with
> > > > given lengths
> > > > + * @device: PECI device to which request is going to be sent
> > > > + * @tx_len: requested TX buffer length
> > > > + * @rx_len: requested RX buffer length
> > > > + *
> > > > + * Return: A pointer to a newly allocated &struct peci_request on
> > > > success
> > > > or NULL otherwise.
> > > > + */
> > > > +struct peci_request *peci_request_alloc(struct peci_device *device, u8
> > > > tx_len, u8 rx_len)
> > > > +{
> > > > +???????struct peci_request *req;
> > > > +???????u8 *tx_buf, *rx_buf;
> > > > +
> > > > +???????req = kzalloc(sizeof(*req), GFP_KERNEL);
> > > > +???????if (!req)
> > > > +???????????????return NULL;
> > > > +
> > > > +???????req->device = device;
> > > > +
> > > > +???????/*
> > > > +??????? * PECI controllers that we are using now don't support DMA,
> > > > this
> > > > +??????? * should be converted to DMA API once support for controllers
> > > > that
> > > > do
> > > > +??????? * allow it is added to avoid an extra copy.
> > > > +??????? */
> > > > +???????if (tx_len) {
> > > > +???????????????tx_buf = kzalloc(tx_len, GFP_KERNEL);
> > > > +???????????????if (!tx_buf)
> > > > +???????????????????????goto err_free_req;
> > > > +
> > > > +???????????????req->tx.buf = tx_buf;
> > > > +???????????????req->tx.len = tx_len;
> > > > +???????}
> > > > +
> > > > +???????if (rx_len) {
> > > > +???????????????rx_buf = kzalloc(rx_len, GFP_KERNEL);
> > > > +???????????????if (!rx_buf)
> > > > +???????????????????????goto err_free_tx;
> > > > +
> > > > +???????????????req->rx.buf = rx_buf;
> > > > +???????????????req->rx.len = rx_len;
> > > > +???????}
> > > > +
> > > 
> > > As long as we're punting on DMA support, could we do the whole thing in
> > > a single allocation instead of three?? It'd add some pointer arithmetic,
> > > but would also simplify the error-handling/deallocation paths a bit.
> > > 
> > > Or, given that the one controller we're currently supporting has a
> > > hardware limit of 32 bytes per transfer anyway, maybe just inline
> > > fixed-size rx/tx buffers into struct peci_request and have callers keep
> > > them on the stack instead of kmalloc()-ing them?
> > 
> > I disagree on error handling (it's not complicated) - however, one argument
> > for
> > doing a single alloc (or moving the buffers as fixed-size arrays inside
> > struct
> > peci_request) is that single kzalloc is going to be faster than 3. But I
> > don't
> > expect it to show up on any perf profiles for now (since peci-wire interface
> > is
> > not a speed demon).
> > 
> > I wanted to avoid defining max size for TX and RX in peci-core.
> > Do you have a strong opinion against multiple alloc? If yes, I can go with
> > fixed-size arrays inside struct peci_request.
> > 
> 
> As is it's certainly not terribly complicated in an absolute sense, but
> comparatively speaking the cleanup path for a single allocation is still
> simpler, no?
> 
> Making it more efficient would definitely be a nice benefit too (perhaps
> a more significant one) -- in a typical deployment I'd guess this code
> path will see roughly socket_count + total_core_count executions per
> second?? On a big multi-socket system that could end up being a
> reasonably large number (>100), so while it may not end up as a major
> hot spot in a system-wide profile, it seems like it might be worth
> having it do 1/3 as many allocations if it's reasonably easy to do.
> (And while I don't think the kernel is generally at fault for this, from
> what I've seen of OpenBMC as a whole I think it might benefit from a bit
> more overall frugality with CPU cycles.)
> 
> As for a fixed max request size and inlined buffers, I definitely
> understand not wanting to put a cap on that in the generic PECI core --
> and actually, looking at the peci-npcm code from previous iterations of
> the PECI patchset, it looks like the Nuvoton hardware has significantly
> larger size limits (127 bytes if I'm reading things right) that might be
> a bit bulky for on-stack allocation.? So while that's appealing
> efficiency-wise and (IMO) aesthetically, perhaps it's not ultimately
> real viable.
> 
> Hmm, though (thinking out loud) I suppose we could also get down to a
> zero-allocation common case by having the driver hold on to a request
> struct and reuse it across transfers, given that they're all serialized
> by a mutex anyway?

With the "zero-allocation" case we still need some memory to copy the necessary
data from the "request area" (now "global" - per-controller).

After more consideration, I think this doesn't have to rely on controller
capabilities, we can just define a max value based on the commands we're using
and use that with single alloc (with rx and tx having fixed size arrays).
I'll change it in v2.

Thank you
-Iwona
> 
