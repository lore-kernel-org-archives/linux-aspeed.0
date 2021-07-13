From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue, 13 Jul 2021 16:26:39 +0700
Subject: [PATCH v5 2/4] mfd: smpro-mfd: Adds Ampere's Altra SMpro MFD
 driver
In-Reply-To: <4e251a34-5c0f-da9d-e471-517c1d581fa4@roeck-us.net>
References: <20210713060031.31568-1-quan@os.amperecomputing.com>
 <20210713060031.31568-3-quan@os.amperecomputing.com>
 <4e251a34-5c0f-da9d-e471-517c1d581fa4@roeck-us.net>
Message-ID: <95a7f95b-445c-359b-69b9-facfb3a3cc1a@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/07/2021 16:11, Guenter Roeck wrote:
> On 7/12/21 11:00 PM, Quan Nguyen wrote:
>> Adds Multi-function devices driver for SMpro co-processor found on the
>> Mt.Jade hardware reference platform with Ampere's Altra processor family.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> Maybe that has been discussed, but is there anything else besides
> hardware monitoring connected to this i2c interface, and are there
> more child drivers coming ? I don't find the BMC Interface Specification
> mentioned in the documentation patch, but the hardware specification
> seems to suggest that the i2c bus is dedicated for hardware monitoring.
> If there is no other child driver, an mfd driver would not make sense.
>Thanks for the comment.

Yes, there are more child drivers coming, one is to provide error 
monitoring and the other to provide other miscellaneous features.
The child drivers used the register map exposed by this mfd driver.

-Quan

> Thanks,
> Guenter
> 
>> ---
>> Changes in v5:
>> ?? + Dropped the use of simple-mfd-i2c driver [Quan]
>> ?? + Introduced drivers/mfd/smpro-mfd.c driver to instantiate
>> ?? sub-devices. This is to avoid DT nodes without resource issue [Quan]
>> ?? + Revised commit message [Quan]
>>
>> Changes in v4:
>> ?? + Add "depends on I2C" to fix build issue found by kernel test
>> ?? robot [Guenter]
>>
>> Changes in v3:
>> ?? + None
>>
>> Changes in v2:
>> ?? + Used 'struct of_device_id's .data attribute [Lee Jones]
>>
>> ? drivers/mfd/Kconfig???? | 12 +++++++
>> ? drivers/mfd/Makefile??? |? 1 +
>> ? drivers/mfd/smpro-mfd.c | 74 +++++++++++++++++++++++++++++++++++++++++
>> ? 3 files changed, 87 insertions(+)
>> ? create mode 100644 drivers/mfd/smpro-mfd.c
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 6a3fd2d75f96..25e502cca32f 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -77,6 +77,18 @@ config MFD_AS3711
>> ????? help
>> ??????? Support for the AS3711 PMIC from AMS
>> +config MFD_SMPRO
>> +??? tristate "Ampere Computing MFD SMpro core driver"
>> +??? depends on I2C
>> +??? select MFD_CORE
>> +??? select REGMAP_I2C
>> +??? help
>> +????? Say yes here to enable SMpro driver support for Ampere's Altra
>> +????? processor family.
>> +
>> +????? Ampere's Altra SMpro exposes an I2C regmap interface that can
>> +????? be accessed by child devices.
>> +
>> ? config MFD_AS3722
>> ????? tristate "ams AS3722 Power Management IC"
>> ????? select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 8116c19d5fd4..046fd36de85a 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -268,6 +268,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)??? += qcom-pm8008.o
>> ? obj-$(CONFIG_SGI_MFD_IOC3)??? += ioc3.o
>> ? obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)??? += simple-mfd-i2c.o
>> +obj-$(CONFIG_MFD_SMPRO)??????? += smpro-mfd.o
>> ? obj-$(CONFIG_MFD_INTEL_M10_BMC)?? += intel-m10-bmc.o
>> ? obj-$(CONFIG_MFD_ATC260X)??? += atc260x-core.o
>> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
>> new file mode 100644
>> index 000000000000..b0cd3c248507
>> --- /dev/null
>> +++ b/drivers/mfd/smpro-mfd.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Ampere Altra Family SMPro MFD - I2C
>> + *
>> + * Copyright (c) 2021, Ampere Computing LLC
>> + *
>> + * Author: Quan Nguyen <quan@os.amperecomputing..com>
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/regmap.h>
>> +
>> +/* Identification Registers */
>> +#define MANUFACTURER_ID_REG???? 0x02
>> +#define AMPERE_MANUFACTURER_ID? 0xCD3A
>> +
>> +static const struct regmap_config simple_word_regmap_config = {
>> +??? .reg_bits = 8,
>> +??? .val_bits = 16,
>> +};
>> +
>> +static const struct mfd_cell smpro_devs[] = {
>> +??? MFD_CELL_NAME("smpro-hwmon"),
>> +};
>> +
>> +static int smpro_mfd_probe(struct i2c_client *i2c)
>> +{
>> +??? const struct regmap_config *config;
>> +??? struct regmap *regmap;
>> +??? unsigned int val;
>> +??? int ret;
>> +
>> +??? config = device_get_match_data(&i2c->dev);
>> +??? if (!config)
>> +??????? config = &simple_word_regmap_config;
>> +
>> +??? regmap = devm_regmap_init_i2c(i2c, config);
>> +??? if (IS_ERR(regmap))
>> +??????? return PTR_ERR(regmap);
>> +
>> +??? /* Check for valid ID */
>> +??? ret = regmap_read(regmap, MANUFACTURER_ID_REG, &val);
>> +??? if (ret)
>> +??????? return ret;
>> +
>> +??? if (val != AMPERE_MANUFACTURER_ID)
>> +??????? return -ENODEV;
>> +
>> +??? return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
>> +??????????????????? smpro_devs, ARRAY_SIZE(smpro_devs), NULL, 0, NULL);
>> +}
>> +
>> +static const struct of_device_id smpro_mfd_of_match[] = {
>> +??? { .compatible = "ampere,smpro", .data = 
>> &simple_word_regmap_config },
>> +??? {}
>> +};
>> +MODULE_DEVICE_TABLE(of, smpro_mfd_of_match);
>> +
>> +static struct i2c_driver smpro_mfd_driver = {
>> +??? .probe_new = smpro_mfd_probe,
>> +??? .driver = {
>> +??????? .name = "smpro-mfd-i2c",
>> +??????? .of_match_table = smpro_mfd_of_match,
>> +??? },
>> +};
>> +module_i2c_driver(smpro_mfd_driver);
>> +
>> +MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
>> +MODULE_DESCRIPTION("SMPRO MFD - I2C driver");
>> +MODULE_LICENSE("GPL v2");
>>
> 

