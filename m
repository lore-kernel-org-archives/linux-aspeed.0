From: Paul Fertser <fercerpav@gmail.com>
Date: Fri, 15 Jan 2021 14:53:41 +0300
Subject: [PATCH v29 3/6] Add Aspeed SoC 24xx and 25xx families JTAG
 master driver
In-Reply-To: <20200413222920.4722-4-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-4-ernesto.corona@intel.com>
Message-ID: <20210115115341.GC2971@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please note that JTAG_XFER_HW_MODE seems to be broken, at least it
doesn't work in my testing with exactly the same userspace and
hardware so I wasn't properly evaluating it.

On Mon, Apr 13, 2020 at 03:29:17PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/drivers/jtag/jtag-aspeed.c
...
> +/*#define USE_INTERRUPTS*/

I think if you implemented support for interrupts and DeviceTree
provides the resource, then it should be enabled. If the support is
untested or known to be buggy, it should be removed altogether and can
be introduced later when the issues are sorted out.

> +struct aspeed_jtag {
> +	void __iomem			*reg_base;
> +	void __iomem			*scu_base;

SCU is manipulated by a separate driver, it shouldn't be here.

> +/*
> + * This is the complete set TMS cycles for going from any TAP state to any
> + * other TAP state, following a "shortest path" rule.
> + */
> +static const struct tms_cycle _tms_cycle_lookup[][16] = {
> +/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
> +/* TLR  */{{0x00, 0}, {0x00, 1}, {0x02, 2}, {0x02, 3}, {0x02, 4}, {0x0a, 4},
> +/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
> +	    {0x0a, 5}, {0x2a, 6}, {0x1a, 5}, {0x06, 3}, {0x06, 4}, {0x06, 5},
> +/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
> +	    {0x16, 5}, {0x16, 6}, {0x56, 7}, {0x36, 6} },

This belongs to the generic JTAG architecture layer rather than an
individual driver.

> +static int aspeed_jtag_freq_set(struct jtag *jtag, u32 freq)
> +{
> +	struct aspeed_jtag *aspeed_jtag = jtag_priv(jtag);
> +	unsigned long apb_frq;
> +	u32 tck_val;
> +	u16 div;
> +
> +	apb_frq = clk_get_rate(aspeed_jtag->pclk);
> +	if (!apb_frq)
> +		return -ENOTSUPP;
> +
> +	div = (apb_frq - 1) / freq;
> +	tck_val = aspeed_jtag_read(aspeed_jtag, ASPEED_JTAG_TCK);
> +	aspeed_jtag_write(aspeed_jtag,
> +			  (tck_val & ~ASPEED_JTAG_TCK_DIVISOR_MASK) | div,
> +			  ASPEED_JTAG_TCK);
> +	return 0;
> +}

ASPEED datasheet says PCLK * 2 is used as the prescaler source, so
this calculation is probably incorrect. This implementation seems to
be also failing to check for the lower and upper limits and return an
error in case the request can't be fulfilled.

> +static inline void aspeed_jtag_slave(struct aspeed_jtag *aspeed_jtag)
> +{
> +	u32 scu_reg = readl(aspeed_jtag->scu_base);
> +
> +	writel(scu_reg | ASPEED_SCU_RESET_JTAG, aspeed_jtag->scu_base);
> +}

reset_control_(de)assert should be used instead of direct SCU
manipulation, here and in all the other places too.

> +static void aspeed_jtag_end_tap_state_sw(struct aspeed_jtag *aspeed_jtag,
> +					 struct jtag_end_tap_state *endstate)
> +{
> +	/* SW mode from curent tap state -> to end_state */
> +	if (endstate->reset) {
> +		int i = 0;
> +
> +		for (i = 0; i < ASPEED_JTAG_RESET_CNTR; i++)
> +			aspeed_jtag_tck_cycle(aspeed_jtag, 1, 0);
> +		aspeed_jtag->status = JTAG_STATE_TLRESET;
> +	}
> +
> +	aspeed_jtag_set_tap_state(aspeed_jtag, endstate->endstate);
> +}

endstate->tck is ignored.

> +static int aspeed_jtag_status_set(struct jtag *jtag,
> +				  struct jtag_end_tap_state *endstate)
> +{
> +	struct aspeed_jtag *aspeed_jtag = jtag_priv(jtag);
> +
> +	dev_dbg(aspeed_jtag->dev, "Set TAP state: %s\n",
> +		end_status_str[endstate->endstate]);
> +
> +	if (!(aspeed_jtag->mode & JTAG_XFER_HW_MODE)) {
> +		aspeed_jtag_end_tap_state_sw(aspeed_jtag, endstate);
> +		return 0;
> +	}
> +
> +	/* x TMS high + 1 TMS low */
> +	if (endstate->reset) {
> +		/* Disable sw mode */
> +		aspeed_jtag_write(aspeed_jtag, 0, ASPEED_JTAG_SW);
> +		mdelay(1);
> +		aspeed_jtag_write(aspeed_jtag, ASPEED_JTAG_CTL_ENG_EN |
> +				  ASPEED_JTAG_CTL_ENG_OUT_EN |
> +				  ASPEED_JTAG_CTL_FORCE_TMS, ASPEED_JTAG_CTRL);
> +		mdelay(1);
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_SW_TDIO, ASPEED_JTAG_SW);
> +		aspeed_jtag->status = JTAG_STATE_TLRESET;
> +	}
> +
> +	return 0;
> +}

endstate->tck is ignored.

> +static int aspeed_jtag_xfer_push_data_last(struct aspeed_jtag *aspeed_jtag,
> +					   enum jtag_xfer_type type,
> +					   u32 shift_bits,
> +					   enum jtag_endstate endstate)
> +{
> +	int res = 0;
> +
> +	if (type == JTAG_SIR_XFER) {
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_IOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_INST,
> +				  ASPEED_JTAG_CTRL);
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_IOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_INST |
> +				  ASPEED_JTAG_CTL_INST_EN,
> +				  ASPEED_JTAG_CTRL);
> +		res = aspeed_jtag_wait_instruction_complete(aspeed_jtag);
> +	} else {
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_DOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_DATA,
> +				  ASPEED_JTAG_CTRL);
> +		aspeed_jtag_write(aspeed_jtag,
> +				  ASPEED_JTAG_DOUT_LEN(shift_bits) |
> +				  ASPEED_JTAG_CTL_LASPEED_DATA |
> +				  ASPEED_JTAG_CTL_DATA_EN,
> +				  ASPEED_JTAG_CTRL);
> +		res = aspeed_jtag_wait_data_complete(aspeed_jtag);
> +	}
> +	return res;
> +}

endstate is ignored.

> +static int aspeed_jtag_init(struct platform_device *pdev,
> +			    struct aspeed_jtag *aspeed_jtag)
> +{
> +	struct resource *res;
> +	struct resource *scu_res;
> +#ifdef USE_INTERRUPTS
> +	int err;
> +#endif
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	aspeed_jtag->reg_base = devm_ioremap_resource(aspeed_jtag->dev, res);
> +	if (IS_ERR(aspeed_jtag->reg_base))
> +		return -ENOMEM;
> +
> +	scu_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	aspeed_jtag->scu_base = devm_ioremap_resource(aspeed_jtag->dev,
> +						      scu_res);
> +	if (IS_ERR(aspeed_jtag->scu_base))
> +		return -ENOMEM;

This always fails either because the second IORESOURCE_MEM wasn't
specified at all (as per the provided example in the dt-bindings
documentation) or because the SCU region is already claimed by the SCU
driver (if you try to specify it). Apparently this version of the
patch series wasn't run-time tested at all. The driver works if this
is removed altogether because reset_control_(de)assert calls do the
right thing.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
