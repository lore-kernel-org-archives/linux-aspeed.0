From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 6 Jun 2019 18:49:23 +0000
Subject: [PATCH v2 1/2] hwmon: pmbus: Add Infineon PXE1610 VR driver
In-Reply-To: <20190605204659.GA32329@roeck-us.net>
References: <20190530231159.222188-1-vijaykhemka@fb.com>
 <20190605204659.GA32329@roeck-us.net>
Message-ID: <75FAE0E3-DE09-416A-90A4-D0AEC0684FC9@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 6/5/19, 1:47 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On Thu, May 30, 2019 at 04:11:56PM -0700, Vijay Khemka wrote:
    > Added pmbus driver for the new device Infineon pxe1610
    > voltage regulator. It also supports similar family device
    > PXE1110 and PXM1310.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Applied.
Thanks
    
    Thanks,
    Guenter
    
    > ---
    > Changes in v2:
    > incorporated all the feedback from Guenter Roeck <linux@roeck-us.net>
    > 
    >  drivers/hwmon/pmbus/Kconfig   |   9 +++
    >  drivers/hwmon/pmbus/Makefile  |   1 +
    >  drivers/hwmon/pmbus/pxe1610.c | 139 ++++++++++++++++++++++++++++++++++
    >  3 files changed, 149 insertions(+)
    >  create mode 100644 drivers/hwmon/pmbus/pxe1610.c
    > 
    > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
    > index 30751eb9550a..338ef9b5a395 100644
    > --- a/drivers/hwmon/pmbus/Kconfig
    > +++ b/drivers/hwmon/pmbus/Kconfig
    > @@ -154,6 +154,15 @@ config SENSORS_MAX8688
    >  	  This driver can also be built as a module. If so, the module will
    >  	  be called max8688.
    >  
    > +config SENSORS_PXE1610
    > +	tristate "Infineon PXE1610"
    > +	help
    > +	  If you say yes here you get hardware monitoring support for Infineon
    > +	  PXE1610.
    > +
    > +	  This driver can also be built as a module. If so, the module will
    > +	  be called pxe1610.
    > +
    >  config SENSORS_TPS40422
    >  	tristate "TI TPS40422"
    >  	help
    > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
    > index 2219b9300316..b0fbd017a91a 100644
    > --- a/drivers/hwmon/pmbus/Makefile
    > +++ b/drivers/hwmon/pmbus/Makefile
    > @@ -18,6 +18,7 @@ obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
    >  obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
    >  obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
    >  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
    > +obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
    >  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
    >  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
    >  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
    > diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
    > new file mode 100644
    > index 000000000000..ebe3f023f840
    > --- /dev/null
    > +++ b/drivers/hwmon/pmbus/pxe1610.c
    > @@ -0,0 +1,139 @@
    > +// SPDX-License-Identifier: GPL-2.0+
    > +/*
    > + * Hardware monitoring driver for Infineon PXE1610
    > + *
    > + * Copyright (c) 2019 Facebook Inc
    > + *
    > + */
    > +
    > +#include <linux/err.h>
    > +#include <linux/i2c.h>
    > +#include <linux/init.h>
    > +#include <linux/kernel.h>
    > +#include <linux/module.h>
    > +#include "pmbus.h"
    > +
    > +#define PXE1610_NUM_PAGES 3
    > +
    > +/* Identify chip parameters. */
    > +static int pxe1610_identify(struct i2c_client *client,
    > +			     struct pmbus_driver_info *info)
    > +{
    > +	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
    > +		u8 vout_mode;
    > +		int ret;
    > +
    > +		/* Read the register with VOUT scaling value.*/
    > +		ret = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
    > +		if (ret < 0)
    > +			return ret;
    > +
    > +		vout_mode = ret & GENMASK(4, 0);
    > +
    > +		switch (vout_mode) {
    > +		case 1:
    > +			info->vrm_version = vr12;
    > +			break;
    > +		case 2:
    > +			info->vrm_version = vr13;
    > +			break;
    > +		default:
    > +			return -ENODEV;
    > +		}
    > +	}
    > +
    > +	return 0;
    > +}
    > +
    > +static struct pmbus_driver_info pxe1610_info = {
    > +	.pages = PXE1610_NUM_PAGES,
    > +	.format[PSC_VOLTAGE_IN] = linear,
    > +	.format[PSC_VOLTAGE_OUT] = vid,
    > +	.format[PSC_CURRENT_IN] = linear,
    > +	.format[PSC_CURRENT_OUT] = linear,
    > +	.format[PSC_TEMPERATURE] = linear,
    > +	.format[PSC_POWER] = linear,
    > +	.func[0] = PMBUS_HAVE_VIN
    > +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
    > +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
    > +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
    > +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
    > +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
    > +	.func[1] = PMBUS_HAVE_VIN
    > +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
    > +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
    > +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
    > +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
    > +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
    > +	.func[2] = PMBUS_HAVE_VIN
    > +		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
    > +		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
    > +		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
    > +		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
    > +		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
    > +	.identify = pxe1610_identify,
    > +};
    > +
    > +static int pxe1610_probe(struct i2c_client *client,
    > +			  const struct i2c_device_id *id)
    > +{
    > +	struct pmbus_driver_info *info;
    > +	u8 buf[I2C_SMBUS_BLOCK_MAX];
    > +	int ret;
    > +
    > +	if (!i2c_check_functionality(
    > +			client->adapter,
    > +			I2C_FUNC_SMBUS_READ_BYTE_DATA
    > +			| I2C_FUNC_SMBUS_READ_WORD_DATA
    > +			| I2C_FUNC_SMBUS_READ_BLOCK_DATA))
    > +		return -ENODEV;
    > +
    > +	/*
    > +	 * By default this device doesn't boot to page 0, so set page 0
    > +	 * to access all pmbus registers.
    > +	 */
    > +	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
    > +
    > +	/* Read Manufacturer id */
    > +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
    > +	if (ret < 0) {
    > +		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
    > +		return ret;
    > +	}
    > +	if (ret != 2 || strncmp(buf, "XP", 2)) {
    > +		dev_err(&client->dev, "MFR_ID unrecognized\n");
    > +		return -ENODEV;
    > +	}
    > +
    > +	info = devm_kmemdup(&client->dev, &pxe1610_info,
    > +			    sizeof(struct pmbus_driver_info),
    > +			    GFP_KERNEL);
    > +	if (!info)
    > +		return -ENOMEM;
    > +
    > +	return pmbus_do_probe(client, id, info);
    > +}
    > +
    > +static const struct i2c_device_id pxe1610_id[] = {
    > +	{"pxe1610", 0},
    > +	{"pxe1110", 0},
    > +	{"pxm1310", 0},
    > +	{}
    > +};
    > +
    > +MODULE_DEVICE_TABLE(i2c, pxe1610_id);
    > +
    > +static struct i2c_driver pxe1610_driver = {
    > +	.driver = {
    > +			.name = "pxe1610",
    > +			},
    > +	.probe = pxe1610_probe,
    > +	.remove = pmbus_do_remove,
    > +	.id_table = pxe1610_id,
    > +};
    > +
    > +module_i2c_driver(pxe1610_driver);
    > +
    > +MODULE_AUTHOR("Vijay Khemka <vijaykhemka@fb.com>");
    > +MODULE_DESCRIPTION("PMBus driver for Infineon PXE1610, PXE1110 and PXM1310");
    > +MODULE_LICENSE("GPL");
    

