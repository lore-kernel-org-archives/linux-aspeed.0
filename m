From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 2 Feb 2023 10:33:13 +0100
Subject: [PATCH v4 3/3] i2c: aspeed: support ast2600 i2c new register mode
 driver
In-Reply-To: <SEZPR06MB526941A3DDB25529F0671112F2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-4-ryan_chen@aspeedtech.com>
 <30c7cbbf57abbdfb5f974d6ee17b2218d124c7e8.camel@ozlabs.org>
 <SEZPR06MB526941A3DDB25529F0671112F2D69@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <5239ea2f-284a-dcf5-6dd4-be3b13b319e6@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/02/2023 10:16, Ryan Chen wrote:
>>>> +static struct platform_driver ast2600_i2c_global_driver = {
>>> +???????.probe? = ast2600_i2c_global_probe,
>>> +???????.driver = {
>>> +???????????????.name = KBUILD_MODNAME,
>>> +???????????????.of_match_table = ast2600_i2c_global_of_match,
>>> +???????},
>>> +};
>>> +
>>> +static int __init ast2600_i2c_global_init(void) {
>>> +???????return platform_driver_register(&ast2600_i2c_global_driver);
>>> +}
>>> +device_initcall(ast2600_i2c_global_init);
>>
>> Maybe module_platform_driver() instead?
> 
> Due to i2c global is top of all i2c bus like the scu, it make sure the driver is before the i2c bus driver probe.
> It is needed use device_initcal function.

No, we do not do such ordering. device links and proper resource sharing
handle the order. This must be module_platform_driver() (assuming we do
not drop entire submission).



Best regards,
Krzysztof

