From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Sun, 29 Aug 2021 19:42:09 +0000
Subject: [PATCH v2 07/15] peci: Add peci-aspeed controller driver
In-Reply-To: <CAPcyv4hUm0Ec1+_n0PZ+S0A9Tt1=8oLdeYtEiEnAmntm8PtmKQ@mail.gmail.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-8-iwona.winiarska@intel.com>
 <CAPcyv4jPVSt9Wr2TkDActFVLP+ygaDwBnsKG410Nf1qfP_MB9A@mail.gmail.com>
 <b26ee278838698289869964fe59578f0d5f7b19c.camel@intel.com>
 <CAPcyv4hUm0Ec1+_n0PZ+S0A9Tt1=8oLdeYtEiEnAmntm8PtmKQ@mail.gmail.com>
Message-ID: <d43b405df504b26e8af2356921570c341976b890.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-08-27 at 09:24 -0700, Dan Williams wrote:
> On Thu, Aug 26, 2021 at 4:55 PM Winiarska, Iwona
> <iwona.winiarska@intel.com> wrote:
> > 
> > On Wed, 2021-08-25 at 18:35 -0700, Dan Williams wrote:
> > > On Tue, Aug 3, 2021 at 4:35 AM Iwona Winiarska
> > > <iwona.winiarska@intel.com> wrote:
> > > > 
> > > > From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > > 
> > > > ASPEED AST24xx/AST25xx/AST26xx SoCs supports the PECI electrical
> > > > interface (a.k.a PECI wire).
> > > 
> > > Maybe a one sentence blurb here and in the Kconfig reminding people
> > > why they should care if they have a PECI driver or not?
> > 
> > Ok, I'll expand it a bit.
> [..]
> > > > +static int aspeed_peci_xfer(struct peci_controller *controller,
> > > > +?????????????????????????? u8 addr, struct peci_request *req)
> > > > +{
> > > > +?????? struct aspeed_peci *priv = dev_get_drvdata(controller-
> > > > >dev.parent);
> > > > +?????? unsigned long flags, timeout = msecs_to_jiffies(priv-
> > > > > cmd_timeout_ms);
> > > > +?????? u32 peci_head;
> > > > +?????? int ret;
> > > > +
> > > > +?????? if (req->tx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
> > > > +?????????? req->rx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
> > > > +?????????????? return -EINVAL;
> > > > +
> > > > +?????? /* Check command sts and bus idle state */
> > > > +?????? ret = aspeed_peci_check_idle(priv);
> > > > +?????? if (ret)
> > > > +?????????????? return ret; /* -ETIMEDOUT */
> > > > +
> > > > +?????? spin_lock_irqsave(&priv->lock, flags);
> > > > +?????? reinit_completion(&priv->xfer_complete);
> > > > +
> > > > +?????? peci_head = FIELD_PREP(ASPEED_PECI_TARGET_ADDR_MASK, addr) |
> > > > +?????????????????? FIELD_PREP(ASPEED_PECI_WR_LEN_MASK, req->tx.len) |
> > > > +?????????????????? FIELD_PREP(ASPEED_PECI_RD_LEN_MASK, req->rx.len);
> > > > +
> > > > +?????? writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
> > > > +
> > > > +?????? memcpy_toio(priv->base + ASPEED_PECI_WR_DATA0, req->tx.buf,
> > > > min_t(u8, req->tx.len, 16));
> > > > +?????? if (req->tx.len > 16)
> > > > +?????????????? memcpy_toio(priv->base + ASPEED_PECI_WR_DATA4, req-
> > > > >tx.buf +
> > > > 16,
> > > > +?????????????????????????? req->tx.len - 16);
> > > > +
> > > > +?????? dev_dbg(priv->dev, "HEAD : 0x%08x\n", peci_head);
> > > > +?????? print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf,
> > > > req-
> > > > > tx.len);
> > > 
> > > On CONFIG_DYNAMIC_DEBUG=n builds the kernel will do all the work of
> > > reading through this buffer, but skip emitting it. Are you sure you
> > > want to pay that overhead for every transaction?
> > 
> > I can remove it or I can add something like:
> > 
> > #if IS_ENABLED(CONFIG_PECI_DEBUG)
> > #define peci_debug(fmt, ...) pr_debug(fmt, ##__VA_ARGS__)
> > #else
> > #define peci_debug(...) do { } while (0)
> > #endif
> 
> It's the hex dump I'm worried about, not the debug statements as much.
> 
> I think the choices are remove the print_hex_dump_bytes(), put it
> behind an IS_ENABLED(CONFIG_DYNAMIC_DEBUG) to ensure the overhead is
> skipped in the CONFIG_DYNAMIC_DEBUG=n case, or live with the overhead
> if this is not a fast path / infrequently used.

I will place it behind IS_ENABLED(CONFIG_DYNAMIC_DEBUG).

> 
> > 
> > (and similar peci_trace with trace_printk for usage in IRQ handlers and
> > such).
> > 
> > What do you think?
> 
> In general, no, don't wrap the base level print routines with
> driver-specific ones. Also, trace_printk() is only for debug builds.
> Note that trace points are built to be even less overhead than
> dev_dbg(), so there's no overhead concern with disabled tracepoints,
> they literally translate to nops when disabled.

Ack.

> 
> > 
> > > 
> > > > +
> > > > +?????? priv->status = 0;
> > > > +?????? writel(ASPEED_PECI_CMD_FIRE, priv->base + ASPEED_PECI_CMD);
> > > > +?????? spin_unlock_irqrestore(&priv->lock, flags);
> > > > +
> > > > +?????? ret = wait_for_completion_interruptible_timeout(&priv-
> > > > > xfer_complete, timeout);
> > > 
> > > spin_lock_irqsave() says "I don't know if interrupts are disabled
> > > already, so I'll save the state, whatever it is, and restore later"
> > > 
> > > wait_for_completion_interruptible_timeout() says "I know I am in a
> > > sleepable context where interrupts are enabled"
> > > 
> > > So, one of those is wrong, i.e. should it be spin_{lock,unlock}_irq()?
> > 
> > You're right - I'll fix it.
> > 
> > > 
> > > 
> > > > +?????? if (ret < 0)
> > > > +?????????????? return ret;
> > > > +
> > > > +?????? if (ret == 0) {
> > > > +?????????????? dev_dbg(priv->dev, "Timeout waiting for a response!\n");
> > > > +?????????????? return -ETIMEDOUT;
> > > > +?????? }
> > > > +
> > > > +?????? spin_lock_irqsave(&priv->lock, flags);
> > > > +
> > > > +?????? writel(0, priv->base + ASPEED_PECI_CMD);
> > > > +
> > > > +?????? if (priv->status != ASPEED_PECI_INT_CMD_DONE) {
> > > > +?????????????? spin_unlock_irqrestore(&priv->lock, flags);
> > > > +?????????????? dev_dbg(priv->dev, "No valid response!\n");
> > > > +?????????????? return -EIO;
> > > > +?????? }
> > > > +
> > > > +?????? spin_unlock_irqrestore(&priv->lock, flags);
> > > > +
> > > > +?????? memcpy_fromio(req->rx.buf, priv->base + ASPEED_PECI_RD_DATA0,
> > > > min_t(u8, req->rx.len, 16));
> > > > +?????? if (req->rx.len > 16)
> > > > +?????????????? memcpy_fromio(req->rx.buf + 16, priv->base +
> > > > ASPEED_PECI_RD_DATA4,
> > > > +???????????????????????????? req->rx.len - 16);
> > > > +
> > > > +?????? print_hex_dump_bytes("RX : ", DUMP_PREFIX_NONE, req->rx.buf,
> > > > req-
> > > > > rx.len);
> > > > +
> > > > +?????? return 0;
> > > > +}
> > > > +
> > > > +static irqreturn_t aspeed_peci_irq_handler(int irq, void *arg)
> > > > +{
> > > > +?????? struct aspeed_peci *priv = arg;
> > > > +?????? u32 status;
> > > > +
> > > > +?????? spin_lock(&priv->lock);
> > > > +?????? status = readl(priv->base + ASPEED_PECI_INT_STS);
> > > > +?????? writel(status, priv->base + ASPEED_PECI_INT_STS);
> > > > +?????? priv->status |= (status & ASPEED_PECI_INT_MASK);
> > > > +
> > > > +?????? /*
> > > > +??????? * In most cases, interrupt bits will be set one by one but also
> > > > note
> > > > +??????? * that multiple interrupt bits could be set at the same time.
> > > > +??????? */
> > > > +?????? if (status & ASPEED_PECI_INT_BUS_TIMEOUT)
> > > > +?????????????? dev_dbg_ratelimited(priv->dev,
> > > > "ASPEED_PECI_INT_BUS_TIMEOUT\n");
> > > > +
> > > > +?????? if (status & ASPEED_PECI_INT_BUS_CONTENTION)
> > > > +?????????????? dev_dbg_ratelimited(priv->dev,
> > > > "ASPEED_PECI_INT_BUS_CONTENTION\n");
> > > > +
> > > > +?????? if (status & ASPEED_PECI_INT_WR_FCS_BAD)
> > > > +?????????????? dev_dbg_ratelimited(priv->dev,
> > > > "ASPEED_PECI_INT_WR_FCS_BAD\n");
> > > > +
> > > > +?????? if (status & ASPEED_PECI_INT_WR_FCS_ABORT)
> > > > +?????????????? dev_dbg_ratelimited(priv->dev,
> > > > "ASPEED_PECI_INT_WR_FCS_ABORT\n");
> > > 
> > > Are you sure these would not be better as tracepoints? If you're
> > > debugging an interrupt related failure, the ratelimiting might get in
> > > your way when you really need to know when one of these error
> > > interrupts fire relative to another event.
> > 
> > Tracepoints are ABI(ish), and using a full blown tracepoint just for IRQ
> > status
> > would probably be too much.
> 
> Tracepoints become ABI once someone ships tooling that depends on them
> being there. These don't look? attractive for a tool, and they don't
> look difficult to maintain if the interrupt handler needs to be
> reworked. I.e. it would be trivial to keep a dead tracepoint around if
> worse came to worse to keep a tool from failing to load.

After more consideration, I would prefer to remove these logs for now - in case
of error I'll log full status in xfer().

> 
> > I was thinking about something like trace_printk hidden under a
> > "CONFIG_PECI_DEBUG" (see above), but perhaps that's something for the future
> > improvement?
> 
> Again trace_printk() is only for private builds.
> 
> > 
> > > 
> > > > +
> > > > +?????? /*
> > > > +??????? * All commands should be ended up with a
> > > > ASPEED_PECI_INT_CMD_DONE
> > > > bit
> > > > +??????? * set even in an error case.
> > > > +??????? */
> > > > +?????? if (status & ASPEED_PECI_INT_CMD_DONE)
> > > > +?????????????? complete(&priv->xfer_complete);
> > > 
> > > Hmm, no need to check if there was a sequencing error, like a command
> > > was never submitted?
> > 
> > It's handled by checking if HW is idle in xfer before a command is sent,
> > where
> > we just expect a single interrupt per command.
> 
> I'm asking how do you determine if this status was spurious, or there
> was a sequencing error in the driver?

I don't think we have any means to determine it.
PECI itself doesn't provide any mechanism to verify it (there is no sequence
number or tag to match request/response).
We're relying on the fact that BMC is a requester and initiates communication
with CPU - the interrupt won't be generated if BMC doesn't send any request.

Thanks
-Iwona
