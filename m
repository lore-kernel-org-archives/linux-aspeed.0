From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Feb 2023 11:44:30 +0100
Subject: [PATCH v5 2/2] i2c: aspeed: support ast2600 i2cv2 new register
 mode driver
In-Reply-To: <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-3-ryan_chen@aspeedtech.com>
 <63986fb1-f8d4-f348-bae9-72e08369213b@linaro.org>
Message-ID: <7dfdb0fb-3a8b-0584-e8b1-6d2200f18097@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/02/2023 09:43, Krzysztof Kozlowski wrote:
> On 20/02/2023 07:17, Ryan Chen wrote:

(...)

>> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &i2c_bus->bus_frequency);
>> +	if (ret < 0) {
>> +		dev_warn(&pdev->dev, "Could not read bus-frequency property\n");
>> +		i2c_bus->bus_frequency = 100000;
>> +	}
>> +
>> +	/* Initialize the I2C adapter */
>> +	i2c_bus->adap.owner = THIS_MODULE;
>> +	i2c_bus->adap.algo = &i2c_ast2600_algorithm;
>> +	i2c_bus->adap.retries = 0;
>> +	i2c_bus->adap.dev.parent = i2c_bus->dev;
>> +	i2c_bus->adap.dev.of_node = pdev->dev.of_node;
>> +	i2c_bus->adap.algo_data = i2c_bus;
>> +	strscpy(i2c_bus->adap.name, pdev->name, sizeof(i2c_bus->adap.name));
>> +	i2c_set_adapdata(&i2c_bus->adap, i2c_bus);
>> +
>> +	ast2600_i2c_init(i2c_bus);
>> +
>> +	ret = devm_request_irq(&pdev->dev, i2c_bus->irq, ast2600_i2c_bus_irq, 0,
>> +			       dev_name(&pdev->dev), i2c_bus);
>> +	if (ret < 0)
>> +		goto unmap;
>> +
>> +	if (of_property_read_bool(pdev->dev.of_node, "smbus-alert")) {
> 
> There is no such property. Don't add undocumented properties to your code.

Actually such property exists, so this one is fine.

Best regards,
Krzysztof

