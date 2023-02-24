From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 24 Feb 2023 16:22:55 +0800
Subject: [PATCH] i3c: dw: Use configured rate and bus mode for clock
 configuration
In-Reply-To: <547646005ac9e5013350c8ed84136088b6be7bad.camel@codeconstruct.com.au>
References: <20230216062040.497815-1-jk@codeconstruct.com.au>
	 <07f8ecaa-9a1a-dcf9-a7f2-fb67f9ddd51a@gmail.com>
	 <547646005ac9e5013350c8ed84136088b6be7bad.camel@codeconstruct.com.au>
Message-ID: <1cb6effca796c914a523d62a4dfff17ef7368ce7.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vitor,

> > > ????????scl_timing = SCL_EXT_LCNT_1(lcnt);
> > > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
> > > +???????lcnt = max_t(u8, lcnt,
> > > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt);
> > > ????????scl_timing |= SCL_EXT_LCNT_2(lcnt);
> > > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
> > > +???????lcnt = max_t(u8, lcnt,
> > > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt);
> > > ????????scl_timing |= SCL_EXT_LCNT_3(lcnt);
> > > -???????lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
> > > +???????lcnt = max_t(u8, lcnt,
> > > +??????????????????? DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt);
> > 
> > what about to use a for loop and only do lcnt calculation if
> > 
> > bus->scl_rate.i3c > I3C_BUS_SDRx_SCL_RATE ?
> 
> I have intended for this to be the same as the existing calculations,
> just applying the limit of the global scl_rate.
> 
> We could restructure as a for-loop (which I'd suggest splitting as a
> separate change, so that the calculation changes are more obvious),
> but it's going to get a bit weird with the macro usage there.

Actually, a for-loop isn't too bad:

  static const struct {
  	unsigned int freq;
  	unsigned int shift;
  } sdrs[] = {
  	{ I3C_BUS_SDR1_SCL_RATE, 0 },
  	{ I3C_BUS_SDR2_SCL_RATE, 8 },
  	{ I3C_BUS_SDR3_SCL_RATE, 16 },
  	{ I3C_BUS_SDR4_SCL_RATE, 24 },
  };
  
  static int dw_i3c_clk_cfg(struct dw_i3c_master *master, unsigned long i3c_rate,
  			  bool pure)
  {
  	/* ... */
  
  	/*
  	 * Timings for lower SDRx rates where specified by device MXDS values;
  	 * we limit these to the global max rate provided, which also prevents
  	 * weird duty cycles
  	 */
  	scl_timing = 0;
  	for (i = 0; i < ARRAY_SIZE(sdrs); i++) {
  		tmp = DIV_ROUND_UP(core_rate, sdrs[i].freq) & 0xff;
  		if (tmp < lcnt)
  			tmp = lcnt;
  		scl_timing |= tmp << sdrs[i].shift;
  	}
  	writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
  
  }

Is this what you were intending?

Cheers,


Jeremy

