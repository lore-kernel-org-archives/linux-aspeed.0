From: Vitor Soares <ivitro@gmail.com>
Date: Thu, 23 Feb 2023 22:29:24 +0000
Subject: [PATCH] i3c: dw: Use configured rate and bus mode for clock
 configuration
In-Reply-To: <20230216062040.497815-1-jk@codeconstruct.com.au>
References: <20230216062040.497815-1-jk@codeconstruct.com.au>
Message-ID: <07f8ecaa-9a1a-dcf9-a7f2-fb67f9ddd51a@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

Please find my comments bellow.


On 2/16/23 06:20, Jeremy Kerr wrote:
> We may have a non-typical i3c rate configured; use this (instead of
> the fixed I3C_BUS_TYP_I3C_SCL_RATE) when calculating timing
> characteristics. We can also expand the SCL high time based on the
> presence/absence of i2c devices.
>
> Also, since we now have bus->mode, use it to determine whether we se up
> the BUS_FREE_TIMING register; rather than re-reading
> DEV_CTRL_I2C_SLAVE_PRESENT from hardware.
>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 44 ++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 51a8608203de..d73d57362b3b 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -515,7 +515,8 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
>  	dw_i3c_master_start_xfer_locked(master);
>  }
>  
> -static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
> +static int dw_i3c_clk_cfg(struct dw_i3c_master *master, unsigned long i3c_rate,
> +			  bool pure)
>  {
>  	unsigned long core_rate, core_period;
>  	u32 scl_timing;
> @@ -527,31 +528,45 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
>  
>  	core_period = DIV_ROUND_UP(1000000000, core_rate);
>  
> -	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period) - 1;
> -	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
> -		hcnt = SCL_I3C_TIMING_CNT_MIN;
> +	/* 50% duty cycle */
> +	hcnt = DIV_ROUND_UP(core_rate, i3c_rate * 2);
>  
> -	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
> -	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
> -		lcnt = SCL_I3C_TIMING_CNT_MIN;
> +	/* In shared mode, we limit t_high, so that i3c SCL signalling is
> +	 * rejected by the i2c devices' spike filter */
> +	if (!pure)
> +		hcnt = min_t(u8, hcnt,
> +			     DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period)) - 1;

You are assuming that t_high may be lower than 40ns, right?
by the spec the max speed is 12.9MHz, don't think you need this min_t() here.

> +
> +	hcnt = max_t(u8, hcnt, SCL_I3C_TIMING_CNT_MIN);

I would branch this part into:

if(pure)

??? hcnt= ;

else

??? hcnt= ;

think this way is more readable.

> +
> +	lcnt = DIV_ROUND_UP(core_rate, i3c_rate) - hcnt;
> +	lcnt = max_t(u8, lcnt, SCL_I3C_TIMING_CNT_MIN);
>  
>  	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
>  	writel(scl_timing, master->regs + SCL_I3C_PP_TIMING);
>  
> -	if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
> +	if (pure)
>  		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
>  
> -	lcnt = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
> +	/* open drain mode requires a minimum of OD_MIN_NS */

My comment here would say why we need a higher OD time rather the minimum.


> +	lcnt = max_t(u8, lcnt, DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period));
>  	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
>  	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
>  
> -	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt;
> +	/* Timings for lower SDRx rates where specified by device MXDS values;
> +	 * we limit these to the global max rate provided, which also prevents
> +	 * weird duty cycles */

I think checkpatch complains with this comment format. I would suggest to use like in the rest of kernel.

Unfortunately, we need to address the cases in which SDRx frequency is higher than bus->scl_rate.i3c.


> +	lcnt = max_t(u8, lcnt,
> +		     DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt);

The lcnt within max_t() function comes from SCL_I3C_OD_TIMING, correct? Have you checked this value for
bus->scl_rate.i3c = 12.5MHz?


>  	scl_timing = SCL_EXT_LCNT_1(lcnt);
> -	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
> +	lcnt = max_t(u8, lcnt,
> +		     DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt);
>  	scl_timing |= SCL_EXT_LCNT_2(lcnt);
> -	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
> +	lcnt = max_t(u8, lcnt,
> +		     DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt);
>  	scl_timing |= SCL_EXT_LCNT_3(lcnt);
> -	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
> +	lcnt = max_t(u8, lcnt,
> +		     DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt);

what about to use a for loop and only do lcnt calculation if

bus->scl_rate.i3c > I3C_BUS_SDRx_SCL_RATE ?


>  	scl_timing |= SCL_EXT_LCNT_4(lcnt);
>  	writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
>  
> @@ -605,7 +620,8 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>  			return ret;
>  		fallthrough;
>  	case I3C_BUS_MODE_PURE:
> -		ret = dw_i3c_clk_cfg(master);
> +		ret = dw_i3c_clk_cfg(master, bus->scl_rate.i3c,
> +				     bus->mode == I3C_BUS_MODE_PURE);
>  		if (ret)
>  			return ret;
>  		break;


Best regards,

Vitor Soares

