From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Feb 2023 10:32:28 +0800
Subject: [PATCH] i3c: dw: Use configured rate and bus mode for clock
 configuration
In-Reply-To: <07f8ecaa-9a1a-dcf9-a7f2-fb67f9ddd51a@gmail.com>
References: <20230216062040.497815-1-jk@codeconstruct.com.au>
	 <07f8ecaa-9a1a-dcf9-a7f2-fb67f9ddd51a@gmail.com>
Message-ID: <547646005ac9e5013350c8ed84136088b6be7bad.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vitor,

> Please find my comments bellow.

Thanks for taking a look, and for the review. Some replies inline:

> > +???????/* 50% duty cycle */
> > +???????hcnt = DIV_ROUND_UP(core_rate, i3c_rate * 2);
> > ?
> > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
> > -???????if (lcnt < SCL_I3C_TIMING_CNT_MIN)
> > -???????????????lcnt = SCL_I3C_TIMING_CNT_MIN;
> > +???????/* In shared mode, we limit t_high, so that i3c SCL signalling is
> > +??????? * rejected by the i2c devices' spike filter */
> > +???????if (!pure)
> > +???????????????hcnt = min_t(u8, hcnt,
> > +??????????????????????????? DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period)) - 1;
> 
> You are assuming that t_high may be lower than 40ns, right?
> by the spec the max speed is 12.9MHz, don't think you need this min_t() here.

This is to handle the case where t_high is *longer* than 41ns - from the
50% duty cycle calculation above, when using a lower bus frequency
(lower than about 12.2MHz).

Then, for mixed-mode (where we need to be compatible with i2c devices
on the bus), we reduce this to the 41ns max (and then hcnt gets
increased to fit the intended frequency).

This is to match the definitions in Table 86 of the I3C spec: the 41ns
maximum is only specified for the mixed bus case.

> > +
> > +???????hcnt = max_t(u8, hcnt, SCL_I3C_TIMING_CNT_MIN);
> 
> I would branch this part into:
> 
> if(pure)
> 
> ??? hcnt= ;
> 
> else
> 
> ??? hcnt= ;
> 
> think this way is more readable.

Yeah, I've been debating min_t()/max_t() vs. conditionals; the
conditionals are more verbose, but likely easier to interpret. I'll
re-do all of these limits as conditionals.

> > +
> > +???????lcnt = DIV_ROUND_UP(core_rate, i3c_rate) - hcnt;
> > +???????lcnt = max_t(u8, lcnt, SCL_I3C_TIMING_CNT_MIN);
> > ?
> > ????????scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
> > ????????writel(scl_timing, master->regs + SCL_I3C_PP_TIMING);
> > ?
> > -???????if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
> > +???????if (pure)
> > ????????????????writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
> > ?
> > -???????lcnt = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
> > +???????/* open drain mode requires a minimum of OD_MIN_NS */
> 
> My comment here would say why we need a higher OD time rather the minimum.

OK, sounds good.

> > +???????lcnt = max_t(u8, lcnt, DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period));
> > ????????scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
> > ????????writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
> > ?
> > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt;
> > +???????/* Timings for lower SDRx rates where specified by device MXDS values;
> > +??????? * we limit these to the global max rate provided, which also prevents
> > +??????? * weird duty cycles */
> 
> I think checkpatch complains with this comment format. I would suggest
> to use like in the rest of kernel.

Yep, will change.

> Unfortunately, we need to address the cases in which SDRx frequency is
> higher than bus->scl_rate.i3c.

I'm not sure if I'm interpreting your comment correctly, but that's
essentially what this is doing: limiting the SDRx frequencies, so that
none is higher than bus->scl_rate.i3c.

For example, if scl_rate is set at 5MHz, we should end up with:

  * default: 5MHz
  * SDR1: 5MHz
  * SDR2: 5MHz
  * SDR3: 4MHz
  * SDR4: 2MHz

Or do you mean that we should be generating timing configurations that
allow SDRx to be greater than the specified scl_rate.i3c? That would
seem to defeat the purpose of the scl_rate override - a device trying to
limit the rate through GETMXDS would result in the rate
*increasing* from the default.

Or something else?

> > +???????lcnt = max_t(u8, lcnt,
> > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt);
> 
> The lcnt within max_t() function comes from SCL_I3C_OD_TIMING,
> correct? Have you checked this value for bus->scl_rate.i3c = 12.5MHz?

Good catch, I assume that this should be based on the PP value, will
update.

> > ????????scl_timing = SCL_EXT_LCNT_1(lcnt);
> > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
> > +???????lcnt = max_t(u8, lcnt,
> > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt);
> > ????????scl_timing |= SCL_EXT_LCNT_2(lcnt);
> > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
> > +???????lcnt = max_t(u8, lcnt,
> > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt);
> > ????????scl_timing |= SCL_EXT_LCNT_3(lcnt);
> > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
> > +???????lcnt = max_t(u8, lcnt,
> > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt);
> 
> what about to use a for loop and only do lcnt calculation if
> 
> bus->scl_rate.i3c > I3C_BUS_SDRx_SCL_RATE ?

I have intended for this to be the same as the existing calculations,
just applying the limit of the global scl_rate.

We could restructure as a for-loop (which I'd suggest splitting as a
separate change, so that the calculation changes are more obvious), but
it's going to get a bit weird with the macro usage there.

Cheers,


Jeremy
