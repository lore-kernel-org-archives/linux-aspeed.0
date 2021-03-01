From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 1 Mar 2021 19:46:08 +0700
Subject: [PATCH 2/4] mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro support
In-Reply-To: <20210226083114.GE641347@dell>
References: <20210225101854.13896-1-quan@os.amperecomputing.com>
 <20210225101854.13896-3-quan@os.amperecomputing.com>
 <20210226083114.GE641347@dell>
Message-ID: <f4b00f4c-6e6c-810d-d16d-5d01ebf4d36d@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/02/2021 15:31, Lee Jones wrote:
> On Thu, 25 Feb 2021, Quan Nguyen wrote:
> 
>> Adds an MFD driver for SMpro found on the Mt.Jade hardware reference
>> platform with Ampere's Altra processor family.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>>   drivers/mfd/Kconfig          | 10 ++++++++++
>>   drivers/mfd/simple-mfd-i2c.c | 15 +++++++++++++--
>>   2 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index b74efa469e90..5414371bdea1 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -77,6 +77,16 @@ config MFD_AS3711
>>   	help
>>   	  Support for the AS3711 PMIC from AMS
>>   
>> +config MFD_SMPRO
>> +	tristate "Ampere Computing MFD SMpro core driver"
>> +	select MFD_SIMPLE_MFD_I2C
> 
> Nice to see another user here.
> 
>> +	help
>> +	  Say yes here to enable SMpro driver support for Ampere's Altra
>> +	  processor family.
>> +
>> +	  Ampere's Altra SMpro exposes an I2C regmap interface that can
>> +	  be accessed by child devices.
>> +
>>   config MFD_AS3722
>>   	tristate "ams AS3722 Power Management IC"
>>   	select MFD_CORE
>> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
>> index 87f684cff9a1..0459a9fbd3f5 100644
>> --- a/drivers/mfd/simple-mfd-i2c.c
>> +++ b/drivers/mfd/simple-mfd-i2c.c
>> @@ -21,14 +21,24 @@ static const struct regmap_config simple_regmap_config = {
>>   	.val_bits = 8,
>>   };
>>   
>> +static const struct regmap_config simple_word_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 16,
>> +};
>> +
>>   static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>>   {
>>   	const struct regmap_config *config;
>>   	struct regmap *regmap;
>>   
>>   	config = device_get_match_data(&i2c->dev);
>> -	if (!config)
>> -		config = &simple_regmap_config;
>> +	if (!config) {
>> +		if (of_device_is_compatible(i2c->dev.of_node,
>> +						"ampere,ac01-smpro"))
> 
> Could you use 'struct of_device_id's .data attribute instead please?
> 
Thank you, but I'm not sure if I got it right.

Do you mean we could use .data attribute to get the expected 
reg_bits/val_bits values and translate them to simple_word_regmap_config 
without the need to match the compatible string ?

>> +			config = &simple_word_regmap_config;
>> +		else
>> +			config = &simple_regmap_config;
>> +	}
>>   
>>   	regmap = devm_regmap_init_i2c(i2c, config);
>>   	if (IS_ERR(regmap))
>> @@ -39,6 +49,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>>   
>>   static const struct of_device_id simple_mfd_i2c_of_match[] = {
>>   	{ .compatible = "kontron,sl28cpld" },
>> +	{ .compatible = "ampere,ac01-smpro" },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> 

