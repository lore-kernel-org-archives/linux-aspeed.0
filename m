From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 14 Jul 2023 11:56:12 +0300
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <SEZPR06MB5269EB586319B3333CD96010F234A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <eda7789d-a603-d565-c9da-edfe9493a05d@linaro.org>
 <SEZPR06MB5269EB586319B3333CD96010F234A@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <ZLENrPhQZe5NN1E4@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 14, 2023 at 08:08:48AM +0000, Ryan Chen wrote:
> On 14/07/2023 09:45, Ryan Chen wrote:

...

> > +	ret = devm_i2c_add_adapter(dev, &i2c_bus->adap);
> > +	if (ret)
> > +		return ret;

...

> > +	i2c_del_adapter(&i2c_bus->adap);
> 
> > I have doubts that you tested this. I think you have here double free/del of the adapter.
> Sorry, i can't catch your point for double free the adapter.
> It should use i2c_del_adapter in driver remove function.
> All the driver doing this 
> https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-npcm7xx.c#L2373
> https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-altera.c#L473
> 
> Do you mean it is not necessary? 

I'm wondering if you understand what you are doing...

-- 
With Best Regards,
Andy Shevchenko


