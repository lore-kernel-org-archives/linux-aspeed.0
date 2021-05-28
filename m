From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 28 May 2021 02:57:58 +0000
Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
In-Reply-To: <14d58497-44e6-265a-af9d-7189379784d5@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519074934.20712-6-quan@os.amperecomputing.com>
 <HK0PR06MB3380FD2B7649CFB48BEA2D4FF2269@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <1648966e-3e45-9661-c5dc-5ac2f40e2581@os.amperecomputing.com>
 <HK0PR06MB338093E5E0D0DBA9EA7C1168F2269@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <917237ce-98f8-df5f-32b6-b4145ac47ac9@os.amperecomputing.com>
 <HK0PR06MB33805BB4A4D35192A0D95E59F2259@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <14d58497-44e6-265a-af9d-7189379784d5@os.amperecomputing.com>
Message-ID: <HK0PR06MB33802E8CBF0F2B70B6104C29F2229@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Quan Nguyen <quan@os.amperecomputing.com>
> Sent: Friday, May 28, 2021 8:53 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Corey Minyard
> <minyard@acm.org>; Rob Herring <robh+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Brendan Higgins
> <brendanhiggins@google.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>; Wolfram Sang <wsa@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; openipmi-developer at lists.sourceforge.net;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-i2c at vger.kernel.org
> Cc: Open Source Submission <patches@amperecomputing.com>; Thang Q .
> Nguyen <thang@os.amperecomputing.com>; Phong Vo
> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
> Subject: Re: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
> 
> On 25/05/2021 17:30, Ryan Chen wrote:
> >> -----Original Message-----
> >> From: Quan Nguyen <quan@os.amperecomputing.com>
> >> Sent: Monday, May 24, 2021 6:49 PM
> >> To: Ryan Chen <ryan_chen@aspeedtech.com>; Corey Minyard
> >> <minyard@acm.org>; Rob Herring <robh+dt@kernel.org>; Joel Stanley
> >> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Brendan Higgins
> >> <brendanhiggins@google.com>; Benjamin Herrenschmidt
> >> <benh@kernel.crashing.org>; Wolfram Sang <wsa@kernel.org>; Philipp
> >> Zabel <p.zabel@pengutronix.de>;
> >> openipmi-developer at lists.sourceforge.net;
> >> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> >> linux-i2c at vger.kernel.org
> >> Cc: Open Source Submission <patches@amperecomputing.com>; Thang Q .
> >> Nguyen <thang@os.amperecomputing.com>; Phong Vo
> >> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
> >> Subject: Re: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
> >>
> >> On 24/05/2021 17:36, Ryan Chen wrote:
> >>>> -----Original Message-----
> >>>> From: Quan Nguyen <quan@os.amperecomputing.com>
> >>>> Sent: Monday, May 24, 2021 6:20 PM
> >>>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Corey Minyard
> >>>> <minyard@acm.org>; Rob Herring <robh+dt@kernel.org>; Joel Stanley
> >>>> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Brendan Higgins
> >>>> <brendanhiggins@google.com>; Benjamin Herrenschmidt
> >>>> <benh@kernel.crashing.org>; Wolfram Sang <wsa@kernel.org>; Philipp
> >>>> Zabel <p.zabel@pengutronix.de>;
> >>>> openipmi-developer at lists.sourceforge.net;
> >>>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >>>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> >>>> linux-i2c at vger.kernel.org
> >>>> Cc: Open Source Submission <patches@amperecomputing.com>; Thang
> Q .
> >>>> Nguyen <thang@os.amperecomputing.com>; Phong Vo
> >>>> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
> >>>> Subject: Re: [PATCH v3 5/7] i2c: aspeed: Add
> >>>> aspeed_set_slave_busy()
> >>>>
> >>>> On 24/05/2021 17:06, Ryan Chen wrote:
> >>>>>> -----Original Message-----
> >>>>>> From: openbmc
> >>>>>> <openbmc-bounces+ryan_chen=aspeedtech.com@lists.ozlabs.org> On
> >>>> Behalf
> >>>>>> Of Quan Nguyen
> >>>>>> Sent: Wednesday, May 19, 2021 3:50 PM
> >>>>>> To: Corey Minyard <minyard@acm.org>; Rob Herring
> >>>>>> <robh+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> >>>>>> Jeffery <andrew@aj.id.au>; Brendan Higgins
> >>>>>> <brendanhiggins@google.com>; Benjamin Herrenschmidt
> >>>>>> <benh@kernel.crashing.org>; Wolfram Sang <wsa@kernel.org>;
> >>>>>> Philipp Zabel <p.zabel@pengutronix.de>;
> >>>>>> openipmi-developer at lists.sourceforge.net;
> >>>>>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >>>>>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> >>>>>> linux-i2c at vger.kernel.org
> >>>>>> Cc: Open Source Submission <patches@amperecomputing.com>;
> Thang
> >> Q .
> >>>>>> Nguyen <thang@os.amperecomputing.com>; Phong Vo
> >>>>>> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
> >>>>>> Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
> >>>>>>
> >>>>>> Slave i2c device on AST2500 received a lot of slave irq while it
> >>>>>> is busy processing the response. To handle this case, adds and
> >>>>>> exports
> >>>>>> aspeed_set_slave_busy() for controller to temporary stop slave
> >>>>>> irq while slave is handling the response, and re-enable them
> >>>>>> again when the
> >>>> response is ready.
> >>>>>>
> >>>>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> >>>>>> ---
> >>>>>> v3:
> >>>>>>      + First introduce in v3 [Quan]
> >>>>>>
> >>>>>>     drivers/i2c/busses/i2c-aspeed.c | 20 ++++++++++++++++++++
> >>>>>>     1 file changed, 20 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c
> >>>>>> b/drivers/i2c/busses/i2c-aspeed.c index
> >>>>>> b2e9c8f0ddf7..9926d04831a2
> >>>>>> 100644
> >>>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
> >>>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
> >>>>>> @@ -944,6 +944,26 @@ static int aspeed_i2c_init(struct
> >>>>>> aspeed_i2c_bus *bus,
> >>>>>>     	return 0;
> >>>>>>     }
> >>>>>>
> >>>>>> +#if IS_ENABLED(CONFIG_I2C_SLAVE) void
> >>>>>> +aspeed_set_slave_busy(struct i2c_adapter *adap, bool busy) {
> >>>>>> +	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
> >>>>>> +	unsigned long current_mask, flags;
> >>>>>> +
> >>>>>> +	spin_lock_irqsave(&bus->lock, flags);
> >>>>>> +
> >>>>>> +	current_mask = readl(bus->base + ASPEED_I2C_INTR_CTRL_REG);
> >>>>> Hello
> >>>>> 	Where the bus->base to be remap?
> >>>>>
> >>>>
> >>>> Hi Ryan,
> >>>>
> >>>> In "[PATCH v3 6/7] ipmi: ssif_bmc: Add Aspeed SSIF BMC driver", the
> >>>> ->priv is retrieved by calling i2c_get_adapdata(client->adapter).
> >>>> ->And in
> >>>> aspeed_set_ssif_bmc_status(), call the exported
> >>>> aspeed_set_slave_busy() using ->priv pointer as code below.
> >>>>
> >>> Yes, I see the probe function " ssif_bmc->priv =
> >> i2c_get_adapdata(client->adapter);" to get priv.
> >>> But my question I don?t see the bus->base address be assigned.
> >>>
> >> Hi Ryan,
> >>
> >> In drivers/i2c/busses/i2c-aspeed.c:
> >> struct aspeed_i2c_bus {
> >>           struct i2c_adapter              adap;
> >>           struct device                   *dev;
> >>           void __iomem                    *base;
> >>           struct reset_control            *rst;
> >>           /* Synchronizes I/O mem access to base. */
> >>           spinlock_t                      lock;
> >>
> >> So when "struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);", the
> >> bus->base should point to the base of the aspeed_i2c_bus, which is
> >> already initialized by the aspeed i2c bus driver.
> >>
> >> Do I miss something?
> > Hello Quan,
> > 	After study. I think the ssif_bmc_aspeed.c assume the priv data is the
> same struct.
> > 	That is trick.
> > 	Do we have a better for slave enable/disable call back to implement this?
> > 	If add call back in struct i2c_algorithm; is it workable?
> >>
> 
> Hi Ryan,
> 
> I dont know which is better, ie: adding callback to struct i2c_algorithm or to
> struct i2c_adapter.
> I have tried to add generic callback to struct i2c_adapter as below and it
> works.
> 
Hello Quan,
	Thanks your feedback.
	Because, if we apply it in callback. It can unify it in ssif_bmc.c to do callback.
	Not have ssif_bmc_aspeed.c, ssif_bmc_xxx.c .....
	Because the priv struct is different in different i2c driver implement. 
Ryan
	

> diff --git a/include/linux/i2c.h b/include/linux/i2c.h index
> 4e7714c88f95..6e9abf2d6abb 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -713,6 +713,10 @@ struct i2c_adapter {
>   	const struct i2c_adapter_quirks *quirks;
> 
>   	struct irq_domain *host_notify_domain;
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	int (*slave_enable)(struct i2c_adapter *adap);
> +	int (*slave_disable)(struct i2c_adapter *adap); #endif
>   };
>   #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> 
> >>>> +extern void aspeed_set_slave_busy(struct i2c_adapter *adap, bool
> >>>> +busy); static void aspeed_set_ssif_bmc_status(struct ssif_bmc_ctx
> >>>> +*ssif_bmc,
> >>>> unsigned int status)
> >>>> +{
> >>>> +	if (status & SSIF_BMC_BUSY)
> >>>> +		aspeed_set_slave_busy((struct i2c_adapter *)ssif_bmc->priv,
> true);
> >>>> +	else if (status & SSIF_BMC_READY)
> >>>> +		aspeed_set_slave_busy((struct i2c_adapter *)ssif_bmc->priv,
> >>>> +false); }
> >>>> +
> >>>> +static int ssif_bmc_probe(struct i2c_client *client, const struct
> >>>> i2c_device_id *id)
> >>>> +{
> >>>> +	struct ssif_bmc_ctx *ssif_bmc;
> >>>> +
> >>>> +	ssif_bmc = ssif_bmc_alloc(client, 0);
> >>>> +	if (IS_ERR(ssif_bmc))
> >>>> +		return PTR_ERR(ssif_bmc);
> >>>> +
> >>>> +	ssif_bmc->priv = i2c_get_adapdata(client->adapter);
> >>>> +	ssif_bmc->set_ssif_bmc_status = aspeed_set_ssif_bmc_status;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>>
> >>>> - Quan
> >>>>
> >>>>
> >>>
> >

