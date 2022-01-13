From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 13 Jan 2022 21:02:54 +0000
Subject: [PATCH v5 05/13] peci: Add peci-aspeed controller driver
In-Reply-To: <CACPK8XewQJBvwssM6zQKQoxT=JLpk-qjGhsiTAa980OtbU7JBw@mail.gmail.com>
References: <20220112230247.982212-1-iwona.winiarska@intel.com>
 <20220112230247.982212-6-iwona.winiarska@intel.com>
 <CACPK8XewQJBvwssM6zQKQoxT=JLpk-qjGhsiTAa980OtbU7JBw@mail.gmail.com>
Message-ID: <f2a7582d6ea4bd7fc04f3a31c98fdd8b80e46296.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2022-01-13 at 04:12 +0000, Joel Stanley wrote:
> On Wed, 12 Jan 2022 at 23:06, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
> > 
> > From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > 
> > ASPEED AST24xx/AST25xx/AST26xx SoCs support the PECI electrical
> > interface (a.k.a PECI wire) that provides a communication channel with
> > Intel processors.
> > This driver allows BMC to discover devices connected to it and
> > communicate with them using PECI protocol.
> > 
> > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The driver looks good to me. I would be happy to see it merged in its
> current state.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thank you :)

> 
> I've a few questions below that can be followed up later if need be.
> 
> > +
> > +static void aspeed_peci_init_regs(struct aspeed_peci *priv)
> > +{
> > +?????? u32 val;
> > +
> > +?????? /* Clear interrupts */
> > +?????? val = readl(priv->base + ASPEED_PECI_INT_STS) | ASPEED_PECI_INT_MASK;
> 
> Should that be & MASK?
> 
> As you're just sanitising the registers, you could clear the status
> unconditionally:
> 
> ?writel(ASPEED_PECI_INT_MASK, priv->base + ASPEED_PECI_INT_STS);
> 

The idea is to not modify any other fields in this register and write 1's only
to INT_MASK.
In theory the other fields are RO, but I already found that touching reserved
fields in other registers may make the HW upset.
I'll check whether clearing unconditionally works here.

> > +?????? writel(val, priv->base + ASPEED_PECI_INT_STS);
> > +
> > +?????? /* Set timing negotiation mode and enable interrupts */
> > +?????? val = FIELD_PREP(ASPEED_PECI_TIMING_NEGO_SEL_MASK,
> > ASPEED_PECI_1ST_BIT_OF_ADDR_NEGO);
> 
> That's a complicated way to set val to zero :)

Agreed - however, you can think of it as a way to document the programming
sequence :)

> 
> > +?????? val |= ASPEED_PECI_INT_MASK;
> > +?????? writel(val, priv->base + ASPEED_PECI_INT_CTRL);
> > +
> > +?????? val = FIELD_PREP(ASPEED_PECI_CTRL_SAMPLING_MASK,
> > ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT);
> > +?????? writel(val, priv->base + ASPEED_PECI_CTRL);
> 
> This will clear the rest of the ctrl register, including the divisor
> settings. Was that your intention?

Yes, it was my intention - the register is initialized with "random" values so
it requires to be cleared when we first accessed it (if we just RMW it, the HW
gets upset).
> 
> Reading the rest of your driver you only call _init_regs after
> _controller_enable, so I guess you're fine.

aspeed_peci_init_regs() is always called after controller reset, any other
register programming is going to happen later on (with RMW). 

> 
> > +}
> > +
> > +static int aspeed_peci_check_idle(struct aspeed_peci *priv)
> > +{
> > +?????? u32 cmd_sts = readl(priv->base + ASPEED_PECI_CMD);
> > +?????? int ret;
> > +
> > +?????? /*
> > +??????? * Under normal circumstances, we expect to be idle here.
> > +??????? * In case there were any errors/timeouts that led to the situation
> > +??????? * where the hardware is not in idle state - we need to reset and
> > +??????? * reinitialize it to avoid potential controller hang.
> > +??????? */
> > +?????? if (FIELD_GET(ASPEED_PECI_CMD_STS_MASK, cmd_sts)) {
> > +?????????????? reset_control_assert(priv->rst);
> > +
> > +?????????????? ret = reset_control_deassert(priv->rst);
> > +?????????????? if (ret) {
> > +?????????????????????? dev_err(priv->dev, "cannot deassert reset control\n");
> > +?????????????????????? return ret;
> > +?????????????? }
> > +
> > +?????????????? aspeed_peci_init_regs(priv);
> > +
> > +?????????????? ret = clk_set_rate(priv->clk, priv->clk_frequency);
> > +?????????????? if (ret < 0) {
> > +?????????????????????? dev_err(priv->dev, "cannot set clock frequency\n");
> > +?????????????????????? return ret;
> > +?????????????? }
> > +
> > +?????????????? aspeed_peci_controller_enable(priv);
> > +?????? }
> > +
> > +?????? return readl_poll_timeout(priv->base + ASPEED_PECI_CMD,
> > +???????????????????????????????? cmd_sts,
> > +???????????????????????????????? !(cmd_sts & ASPEED_PECI_CMD_IDLE_MASK),
> > +???????????????????????????????? ASPEED_PECI_IDLE_CHECK_INTERVAL_US,
> > +???????????????????????????????? ASPEED_PECI_IDLE_CHECK_TIMEOUT_US);
> > +}
> > +
> > +static int aspeed_peci_xfer(struct peci_controller *controller,
> > +?????????????????????????? u8 addr, struct peci_request *req)
> > +{
> > +?????? struct aspeed_peci *priv = dev_get_drvdata(controller->dev.parent);
> > +?????? unsigned long timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
> > +?????? u32 peci_head;
> > +?????? int ret;
> > +
> > +?????? if (req->tx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
> > +?????????? req->rx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
> > +?????????????? return -EINVAL;
> > +
> > +?????? /* Check command sts and bus idle state */
> > +?????? ret = aspeed_peci_check_idle(priv);
> > +?????? if (ret)
> > +?????????????? return ret; /* -ETIMEDOUT */
> > +
> > +?????? spin_lock_irq(&priv->lock);
> > +?????? reinit_completion(&priv->xfer_complete);
> > +
> > +?????? peci_head = FIELD_PREP(ASPEED_PECI_TARGET_ADDR_MASK, addr) |
> > +?????????????????? FIELD_PREP(ASPEED_PECI_WR_LEN_MASK, req->tx.len) |
> > +?????????????????? FIELD_PREP(ASPEED_PECI_RD_LEN_MASK, req->rx.len);
> > +
> > +?????? writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
> > +
> > +?????? memcpy_toio(priv->base + ASPEED_PECI_WR_DATA0, req->tx.buf, min_t(u8,
> > req->tx.len, 16));
> > +?????? if (req->tx.len > 16)
> > +?????????????? memcpy_toio(priv->base + ASPEED_PECI_WR_DATA4, req->tx.buf +
> > 16,
> > +?????????????????????????? req->tx.len - 16);
> > +
> > +#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
> > +?????? dev_dbg(priv->dev, "HEAD : %#08x\n", peci_head);
> > +?????? print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf, req-
> > >tx.len);
> > +#endif
> 
> The ifdef is unfortunate. Could you do this?
> 
> dev_dbg(priv->dev, "HEAD : %#08x\n", peci_head);
> if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG))
> ?????? print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf,
> req->tx.len);
> 
> Not a biggie though, don't let this hold up merging.

I don't understand why should we treat HEAD differently that the rest of the
buffer. Ultimately (looking at this from the PECI protocol level) this is just a
part of TX packet.
Overall, this is the "hot path" of this particular driver - the ifdef is here to
avoid dumping all packets all the time (which would happen if dynamic debug is
not present).

Thanks
-Iwona

> 
> > +?????? priv->status = 0;
> > +?????? writel(ASPEED_PECI_CMD_FIRE, priv->base + ASPEED_PECI_CMD);
> > +?????? spin_unlock_irq(&priv->lock);
> > +

