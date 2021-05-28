From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 28 May 2021 08:00:09 +0700
Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
In-Reply-To: <HK0PR06MB3380CCA6A264A6D0E6E462FDF2299@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519074934.20712-6-quan@os.amperecomputing.com>
 <HK0PR06MB3380BFA9FD9EF8F51F9DCC23F22A9@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <3eba7d01-2507-17c6-2b27-7f1a7e286413@os.amperecomputing.com>
 <HK0PR06MB3380CCA6A264A6D0E6E462FDF2299@HK0PR06MB3380.apcprd06.prod.outlook.com>
Message-ID: <b39c7434-4926-4bb1-88d8-59c6464f3fb1@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/05/2021 13:09, Ryan Chen wrote:
>> -----Original Message-----
>> From: Quan Nguyen <quan@os.amperecomputing.com>
>> Sent: Thursday, May 20, 2021 10:10 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Corey Minyard
>> <minyard@acm.org>; Rob Herring <robh+dt@kernel.org>; Joel Stanley
>> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Brendan Higgins
>> <brendanhiggins@google.com>; Benjamin Herrenschmidt
>> <benh@kernel.crashing.org>; Wolfram Sang <wsa@kernel.org>; Philipp Zabel
>> <p.zabel@pengutronix.de>; openipmi-developer at lists.sourceforge.net;
>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
>> linux-i2c at vger.kernel.org
>> Cc: Open Source Submission <patches@amperecomputing.com>; Thang Q .
>> Nguyen <thang@os.amperecomputing.com>; Phong Vo
>> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
>> Subject: Re: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
>>
>> On 20/05/2021 18:06, Ryan Chen wrote:
>>>> -----Original Message-----
>>>> From: openbmc
>>>> <openbmc-bounces+ryan_chen=aspeedtech.com@lists.ozlabs.org> On
>> Behalf
>>>> Of Quan Nguyen
>>>> Sent: Wednesday, May 19, 2021 3:50 PM
>>>> To: Corey Minyard <minyard@acm.org>; Rob Herring
>>>> <robh+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
>>>> <andrew@aj.id.au>; Brendan Higgins <brendanhiggins@google.com>;
>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org>; Wolfram Sang
>>>> <wsa@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
>>>> openipmi-developer at lists.sourceforge.net;
>>>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>>>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
>>>> linux-i2c at vger.kernel.org
>>>> Cc: Open Source Submission <patches@amperecomputing.com>; Thang Q .
>>>> Nguyen <thang@os.amperecomputing.com>; Phong Vo
>>>> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
>>>> Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
>>>>
>>>> Slave i2c device on AST2500 received a lot of slave irq while it is
>>>> busy processing the response. To handle this case, adds and exports
>>>> aspeed_set_slave_busy() for controller to temporary stop slave irq
>>>> while slave is handling the response, and re-enable them again when the
>> response is ready.
>>>>
>>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>>>> ---
>>>> v3:
>>>>     + First introduce in v3 [Quan]
>>>>
>>>>    drivers/i2c/busses/i2c-aspeed.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c
>>>> b/drivers/i2c/busses/i2c-aspeed.c index b2e9c8f0ddf7..9926d04831a2
>>>> 100644
>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>>> @@ -944,6 +944,26 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus
>>>> *bus,
>>>>    	return 0;
>>>>    }
>>>>
>>>> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
>>>> +void aspeed_set_slave_busy(struct i2c_adapter *adap, bool busy) {
>>>> +	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
>>>> +	unsigned long current_mask, flags;
>>>> +
>>>> +	spin_lock_irqsave(&bus->lock, flags);
>>>> +
>>>> +	current_mask = readl(bus->base + ASPEED_I2C_INTR_CTRL_REG);
>>>> +	if (busy)
>>>> +		current_mask &= ~(ASPEED_I2CD_INTR_RX_DONE |
>>>> ASPEED_I2CD_INTR_SLAVE_MATCH);
>>>> +	else
>>>> +		current_mask |= ASPEED_I2CD_INTR_RX_DONE |
>>>> ASPEED_I2CD_INTR_SLAVE_MATCH;
>>>> +	writel(current_mask, bus->base + ASPEED_I2C_INTR_CTRL_REG);
>>>> +
>>>> +	spin_unlock_irqrestore(&bus->lock, flags); }
>>>> +EXPORT_SYMBOL_GPL(aspeed_set_slave_busy);
>>>> +#endif
>>>> +
>>>>    static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)  {
>>>>    	struct platform_device *pdev = to_platform_device(bus->dev);
>>>> --
>>>> 2.28.0
>>>
>>> Hello,
>>> 	The better idea is use disable i2c slave mode.
>>> 	Due to if i2c controller running in slave will get slave match, and latch the
>> SCL.
>>> 	Until cpu clear interrupt status.
>>> Ryan
>>>
>> Thanks Ryan,
>>
>> Do you mean to enable/disable slave function as per example code below ?
> Yes. it is.

Dear Ryan,

This solution looks good. I'll switch to use this way in next version.
Thanks for the suggestion.

- Quan

>>
>>           /* Turn on slave mode. */
>>           func_ctrl_reg_val = readl(bus->base +
>> ASPEED_I2C_FUN_CTRL_REG);
>>           func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
>>           writel(func_ctrl_reg_val, bus->base +
>> ASPEED_I2C_FUN_CTRL_REG);
>>
>> Will try this idea.
>> - Quan

