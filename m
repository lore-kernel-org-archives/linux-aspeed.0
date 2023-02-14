From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 14 Feb 2023 08:57:02 +0000
Subject: [PATCH v4 3/3] i2c: aspeed: support ast2600 i2c new register mode
 driver
In-Reply-To: <013cc486-dc70-a8b9-69d2-d0ae991549fd@linaro.org>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
 <30c7cbbf57abbdfb5f974d6ee17b2218d124c7e8.camel@ozlabs.org>
 <SEZPR06MB526941A3DDB25529F0671112F2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <5239ea2f-284a-dcf5-6dd4-be3b13b319e6@linaro.org>
 <SEZPR06MB526951F24B841965C0DD6B84F2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <SEZPR06MB52698009DA893813FECBE76FF2A29@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <013cc486-dc70-a8b9-69d2-d0ae991549fd@linaro.org>
Message-ID: <SEZPR06MB5269752C96643832E32F8AD1F2A29@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

> 
> On 14/02/2023 07:12, Ryan Chen wrote:
> > Hello Krzysztof,
> >>
> >>> On 02/02/2023 10:16, Ryan Chen wrote:
> >>>>>>> +static struct platform_driver ast2600_i2c_global_driver = {
> >>>>>> +???????.probe? = ast2600_i2c_global_probe,
> >>>>>> +???????.driver = {
> >>>>>> +???????????????.name = KBUILD_MODNAME,
> >>>>>> +???????????????.of_match_table =
> >> ast2600_i2c_global_of_match,
> >>>>>> +???????},
> >>>>>> +};
> >>>>>> +
> >>>>>> +static int __init ast2600_i2c_global_init(void) {
> >>>>>> +???????return
> >>>>>> +platform_driver_register(&ast2600_i2c_global_driver);
> >>>>>> +}
> >>>>>> +device_initcall(ast2600_i2c_global_init);
> >>>>>
> >>>>> Maybe module_platform_driver() instead?
> >>>>
> >>>> Due to i2c global is top of all i2c bus like the scu, it make sure
> >>>> the driver is
> >>> before the i2c bus driver probe.
> >>>> It is needed use device_initcal function.
> >>>
> >>> No, we do not do such ordering. device links and proper resource
> >>> sharing handle the order. This must be module_platform_driver()
> >>> (assuming we do not drop entire submission).
> >>
> >>
> >> If global driver use module_platform_driver, does i2c driver will
> >> latter the global driver probe?
> >> If yes, I think it will workable.
> >>>
> > I find a good way instead.
> > subsys_initcall(ast2600_i2c_global_init); is better ?
> 
> Not really, this is not a subsystem. This is module platform driver so use it.
> 
But, I need i2c-global to be early then i2c-ast2600 driver. The subsys_initcall is needed.
I2c-global driver to initial full i2c clock and reset, after this, i2c bus driver(i2c-ast2600.c) can work. 
So I suggest to use subsys_initcall in i2c global driver. Is it ok?
Best regards,

