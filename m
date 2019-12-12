From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 12 Dec 2019 15:22:44 +1030
Subject: [PATCH v2 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
In-Reply-To: <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-7-git-send-email-eajames@linux.ibm.com>
 <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
 <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
Message-ID: <f597202e-0d5a-4b76-ba0a-a6f0a857b289@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 12 Dec 2019, at 07:09, Eddie James wrote:
> 
> On 12/10/19 9:47 PM, Andrew Jeffery wrote:
> >
> > On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> >> +
> >> +static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
> >> +						struct aspeed_xdma_op *op,
> >> +						u32 bmc_addr)
> >> +{
> >> +	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
> >> +		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
> >> +	unsigned int line_size;
> >> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
> >> +	unsigned int line_no = 1;
> >> +	unsigned int pitch = 1;
> >> +	struct aspeed_xdma_cmd *ncmd =
> >> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
> >> +
> >> +	if ((op->host_addr + op->len) & 0xffffffff00000000ULL)
> > Do we know that this won't wrap?
> 
> 
> No, but I assume it would be a bad transfer anyway at that point?

But what happens as a consequence? We would have a 64 bit address
but wouldn't enable 64bit addressing, so presumably the hardware
would only use the bottom 32 bits of the address?

Things could get weird yes?

Or is there some failure that would occur before we trigger the transfer?
Is that what you're depending on?

> >> +
> >> +static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
> >> +{
> >> +	if (ctx->current_client) {
> >> +		ctx->current_client->error = error;
> >> +		ctx->current_client->in_progress = false;
> >> +		ctx->current_client = NULL;
> > You need to take start_lock before writing these members to ensure the
> > writes are not reordered across acquisition of start_lock in
> > aspeed_xdma_start() above, unless there's some other guarantee of that?
> 
> 
> Unless we get spurious interrupts (as in, the xdma interrupt fires with 
> no transfer started, and somehow the correct status bits are set), it's 
> not possible to execute this at the same time as aspeed_xdma_start(). So 
> I did not try and lock here. Do you think it's worth locking for that 
> situation?
> 

Why is it worth not locking? How is it correct? To answer that way we invoke
all kinds of reasoning about multi-processing (interrupt handled on one core
while aspeed_xdma_start() is executing on another), value visibility and
instruction reordering (though as it happens the 2400, 2500 and 2600 are all
in-order). We'll trip ourselves up if there is eventually a switch to out-of-order
execution where the writes might be reordered and delayed until after
start_lock has been acquired in aspeed_xdma_start() by a subseqent transfer.
This line of reasoning is brittle exploitation of properties of the currently used
cores for no benefit. Finishing the DMA op isn't a hot path where you might
want to take some of these risks for performance, so we have almost zero
care for lock contention but we must always be concerned about correctness.

We avoid invoking all of those questions by acquiring the lock.

> >> +
> >> +	ctx->vga_pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
> >> +	if (!ctx->vga_pool) {
> >> +		dev_err(dev, "Failed to setup genalloc pool.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	rc = of_property_read_u32_array(dev->of_node, "vga-mem", vgamem, 2);
> > As mentioned, this could be any reserved memory range. Also can't we get it as
> > a resource rather than parsing a u32 array? Not sure if there's an advantage
> > but it feels like a better representation.
> 
> 
> That doesn't work unfortunately because the VGA memory is not mapped and 
> the reserved memory subsystem fails to find it.

Fair enough.

> >> +
> >> +	regmap_update_bits(sdmc, SDMC_REMAP, ctx->chip->sdmc_remap,
> >> +			   ctx->chip->sdmc_remap);
> > I disagree with doing this. As mentioned on the bindings it should be up to
> > the platform integrator to ensure that this is configured appropriately.
> 
> 
> Probably so, but then how does one actually configure that elsewhere? Do 
> you mean add code to the edac driver (and add support for the ast2600) 
> to read some dts properties to set it?

Right. That's where I was going. I don't expect you to do that as part of this
patch series, but if you could separate this code out into separate patches
(dealing with the sdmc property in the devicetree binding as well) we can at
least concentrate on getting the core XDMA driver in and work out how to
move forward with configuring the memory controller later.

> >> +/*
> >> + * aspeed_xdma_direction
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_DOWNSTREAM: transfers data from the host to the BMC
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_UPSTREAM: transfers data from the BMC to the host
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_RESET: resets the XDMA engine
> >> + */
> >> +enum aspeed_xdma_direction {
> >> +	ASPEED_XDMA_DIRECTION_DOWNSTREAM = 0,
> >> +	ASPEED_XDMA_DIRECTION_UPSTREAM,
> >> +	ASPEED_XDMA_DIRECTION_RESET,
> > I still think having a reset action as part of the direction is a bit funky. Can you maybe
> > put that in a separate patch so we can debate it later?
> 
> 
> I can, but I'm fairly convinced this is the cleanest way to add the 
> reset functionality.
> 

Right, but if you separate it out you'll get my reviewed-by on the core XDMA
patches much quicker :) You can convince me about it in slow-time.

Cheers,

Andrew
