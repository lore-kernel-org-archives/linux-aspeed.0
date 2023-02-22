From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 22 Feb 2023 09:28:26 +0100
Subject: [PATCH v5 2/2] i2c: aspeed: support ast2600 i2cv2 new register
 mode driver
In-Reply-To: <SEZPR06MB5269B032022D3D7286E59D36F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-3-ryan_chen@aspeedtech.com>
 <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
 <SEZPR06MB5269B032022D3D7286E59D36F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <77480142-a2c0-f6da-af0e-d3f01f72ac53@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22/02/2023 04:36, Ryan Chen wrote:

>>> +
>>> +	return 0;
>>> +
>>> +free_irq:
>>> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
>>
>> Why?
>>
>>> +unmap:
>>> +	devm_iounmap(&pdev->dev, i2c_bus->reg_base);
>>
>> Why?
>>
>>> +free_mem:
>>> +	devm_kfree(&pdev->dev, i2c_bus);
>>
>> Why?
>>
> 
> Sorry, those are probe following, if any error, will goto this label.
> To release mem/unmap/free_irq. Is this unnecessary? 

Releasing managed resources is usualyl unnecessary. Therefore I am
asking why do you think it is necessary here?

> I saw many driver submit is remove all probe fail goto label, is just return ERR.
> Do you mean I direct go for this way?

Why would you do it differently?

> 
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int ast2600_i2c_remove(struct platform_device *pdev) {
>>> +	struct ast2600_i2c_bus *i2c_bus = platform_get_drvdata(pdev);
>>> +
>>> +	/* Disable everything. */
>>> +	writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
>>> +	writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
>>> +
>>> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
>>> +
>>> +	i2c_del_adapter(&i2c_bus->adap);
>>
>> Wrong order of cleanup. It should be reversed to the probe, unless you have
>> some reason, but then please explain.
> 
> Sorry, this in remove function, it should do i2c_del_adapter(&i2c_bus->adap) in the end.
> Why this should revered to probe?

Because it's logical, you do the same with error paths of probe, it it
usually the only way to make sure some of the resources are not used by
some other piece (e.g. interrupt handler is called while i2c adapter is
unregistered).


Best regards,
Krzysztof

