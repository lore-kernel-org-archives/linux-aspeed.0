From: Pratyush Yadav <p.yadav@ti.com>
Date: Wed, 6 Apr 2022 00:52:43 +0530
Subject: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
In-Reply-To: <8c88e726-0ddb-e2ba-35df-676cfc3d0475@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-9-clg@kaod.org>
 <20220331164115.w5q3wxlmwcg3w4ns@ti.com>
 <8c88e726-0ddb-e2ba-35df-676cfc3d0475@kaod.org>
Message-ID: <20220405192243.7ilibbsyomg42uwg@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/04/22 09:30AM, C?dric Le Goater wrote:
> On 3/31/22 18:41, Pratyush Yadav wrote:
> > Hi,
> > 
> > On 25/03/22 11:08AM, C?dric Le Goater wrote:
> > > To accommodate the different response time of SPI transfers on different
> > > boards and different SPI NOR devices, the Aspeed controllers provide a
> > > set of Read Timing Compensation registers to tune the timing delays
> > > depending on the frequency being used. The AST2600 SoC has one of these
> > > registers per device. On the AST2500 and AST2400 SoCs, the timing
> > > register is shared by all devices which is problematic to get good
> > > results other than for one device.
> > > 
> > > The algorithm first reads a golden buffer at low speed and then performs
> > > reads with different clocks and delay cycle settings to find a breaking
> > > point. This selects a default good frequency for the CEx control register.
> > > The current settings are a bit optimistic as we pick the first delay giving
> > > good results. A safer approach would be to determine an interval and
> > > choose the middle value.
> > > 
> > > Calibration is performed when the direct mapping for reads is created.
> > > Since the underlying spi-nor object needs to be initialized to create
> > > the spi_mem operation for direct mapping, we should be fine. Having a
> > > specific API would clarify the requirements though.
> > > 
> > > Cc: Pratyush Yadav <p.yadav@ti.com>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> > > Signed-off-by: C?dric Le Goater <clg@kaod.org>
> > > ---
> > >   drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
> > >   1 file changed, 281 insertions(+)
> > > 
> > [...]
> > > @@ -517,6 +527,8 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
> > >   	return 0;
> > >   }
> > > +static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
> > > +
> > >   static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
> > >   {
> > >   	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> > > @@ -565,6 +577,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
> > >   	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
> > >   	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
> > > +	ret = aspeed_spi_do_calibration(chip);
> > > +
> > 
> > I am still not convinced this is a good idea. The API does not say
> > anywhere what dirmap_create must be called after the flash is completely
> > initialized, though that is what is done currently in practice.
> 
> Yes because we wouldn't have a correct 'spi_mem_dirmap_info' if it wasn't
> the case. May be change the documentation ?

SPI NOR knows what protocol and opcodes it would use before it actually 
puts the flash in that mode. So in theory it could call dirmap_create() 
before it has put the flash in say 8D-8D-8D mode. I don't see much 
reason to do so in practice, but who knows, that might change. This is 
why I would like to hear what other people think.

> 
> > I think
> > an explicit API to mark flash as "ready for calibration" would be a
> > better idea.
> 
> OK. Since the above is a oneliner, it should not be a problem to move
> it under a new handler if needed.
> 
> The dirmap_create() handler expects the spi-mem descriptor and the field
> 'desc->info.op_tmpl' to be correctly initialized in order to compute the
> control register value, which is a requirement for dirmap_read(). The
> calibration sequence simply comes after.
> 
> AFAICT, there is nothing incorrect today.

In practice, no there is nothing incorrect. But as I explained above, it 
is certainly possible to call dirmap_create() before the flash is ready.

> 
> > Tudor/Mark/Miquel, what do you think?
> 
> 
> Thanks,
> 
> C.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
