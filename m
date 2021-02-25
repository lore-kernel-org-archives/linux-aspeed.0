From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Feb 2021 08:08:45 -0800
Subject: [PATCH 3/4] hwmon: smpro: Add Ampere's Altra smpro-hwmon driver
In-Reply-To: <20210225101854.13896-4-quan@os.amperecomputing.com>
References: <20210225101854.13896-1-quan@os.amperecomputing.com>
 <20210225101854.13896-4-quan@os.amperecomputing.com>
Message-ID: <f38fb368-1ea7-d27d-0575-bac466dc56c7@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/25/21 2:18 AM, Quan Nguyen wrote:
> This commit adds support for Ampere SMpro hwmon driver. This driver
> supports accessing various CPU sensors provided by the SMpro co-processor
> including temperature, power, voltages, and current.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  drivers/hwmon/Kconfig       |   8 +
>  drivers/hwmon/Makefile      |   1 +
>  drivers/hwmon/smpro-hwmon.c | 620 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 629 insertions(+)
>  create mode 100644 drivers/hwmon/smpro-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 54f04e61fb83..7b0458bf903c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -67,6 +67,14 @@ config SENSORS_ABITUGURU3
>  	  This driver can also be built as a module. If so, the module
>  	  will be called abituguru3.
>  
> +config SENSORS_SMPRO
> +	tristate "Ampere's Altra SMpro hardware monitoring driver"
> +	depends on MFD_SMPRO
> +	help
> +	  If you say yes here you get support for the thermal, voltage,
> +	  current and power sensors of Ampere's Altra processor family SoC
> +	  with SMpro co-processor.
> +
>  config SENSORS_AD7314
>  	tristate "Analog Devices AD7314 and compatibles"
>  	depends on SPI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index fe38e8a5c979..ac0892540abb 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -173,6 +173,7 @@ obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
>  obj-$(CONFIG_SENSORS_SHTC1)	+= shtc1.o
>  obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
>  obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
> +obj-$(CONFIG_SENSORS_SMPRO)	+= smpro-hwmon.o
>  obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>  obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
> diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
> new file mode 100644
> index 000000000000..d70764ffc78f
> --- /dev/null
> +++ b/drivers/hwmon/smpro-hwmon.c
> @@ -0,0 +1,620 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Ampere Computing SoC's SMPro Hardware Monitoring Driver
> + *
> + * Copyright (c) 2021, Ampere Computing LLC
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.

Repeating the text of GPL is not necessary. This is what
SPDX-License-Identifier is for.

> + */
> +#include <linux/bitfield.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* Identification Registers */
> +#define MANUFACTURER_ID_REG		0x02
> +#define AMPERE_MANUFACTURER_ID		0xCD3A
> +
> +/* Capability Registers  */
> +#define SOC_TDP_REG			0x0E

This is used to report power. What does it actually report ?
If it is the design power, it should not be reported as power,
but possibly as maximum SOC power.

If so, and if other limit registers are reported as actual values,
please change to report as limits.

> +
> +/* Logical Power Sensor Registers */
> +#define SOC_TEMP_REG			0x10
> +#define SOC_VRD_TEMP_REG		0x11
> +#define DIMM_VRD_TEMP_REG		0x12
> +#define CORE_VRD_TEMP_REG		0x13
> +#define CH0_DIMM_TEMP_REG		0x14
> +#define CH1_DIMM_TEMP_REG		0x15
> +#define CH2_DIMM_TEMP_REG		0x16
> +#define CH3_DIMM_TEMP_REG		0x17
> +#define CH4_DIMM_TEMP_REG		0x18
> +#define CH5_DIMM_TEMP_REG		0x19
> +#define CH6_DIMM_TEMP_REG		0x1A
> +#define CH7_DIMM_TEMP_REG		0x1B
> +#define RCA_VRD_TEMP_REG		0x1C
> +
> +#define CORE_VRD_PWR_REG		0x20
> +#define SOC_PWR_REG			0x21
> +#define DIMM_VRD1_PWR_REG		0x22
> +#define DIMM_VRD2_PWR_REG		0x23
> +#define CORE_VRD_PWR_MW_REG		0x26
> +#define SOC_PWR_MW_REG			0x27
> +#define DIMM_VRD1_PWR_MW_REG		0x28
> +#define DIMM_VRD2_PWR_MW_REG		0x29
> +#define RCA_VRD_PWR_REG			0x2A
> +#define RCA_VRD_PWR_MW_REG		0x2B
> +
> +#define MEM_HOT_THRESHOLD_REG		0x32
> +#define SOC_VR_HOT_THRESHOLD_REG	0x33

Apparently there _are_ more limit registers.
Please implement those as limit attributes.

> +#define CORE_VRD_VOLT_REG		0x34
> +#define SOC_VRD_VOLT_REG		0x35
> +#define DIMM_VRD1_VOLT_REG		0x36
> +#define DIMM_VRD2_VOLT_REG		0x37
> +#define RCA_VRD_VOLT_REG		0x38
> +
> +#define CORE_VRD_CURR_REG		0x39
> +#define SOC_VRD_CURR_REG		0x3A
> +#define DIMM_VRD1_CURR_REG		0x3B
> +#define DIMM_VRD2_CURR_REG		0x3C
> +#define RCA_VRD_CURR_REG		0x3D
> +
> +/* Add for DIMM group */
> +#define DIMM_GROUP_DUMMY_REG		0xFF
> +
> +struct smpro_hwmon {
> +	struct regmap *regmap;
> +};
> +
> +static const u8 temp_regs[] = {
> +	SOC_TEMP_REG,
> +	SOC_VRD_TEMP_REG,
> +	DIMM_VRD_TEMP_REG,
> +	CORE_VRD_TEMP_REG,
> +	/* reserved for DIMM G0 */
> +	DIMM_GROUP_DUMMY_REG,
> +	CH0_DIMM_TEMP_REG,
> +	CH1_DIMM_TEMP_REG,
> +	CH2_DIMM_TEMP_REG,
> +	CH3_DIMM_TEMP_REG,
> +	/* reserved for DIMM G1 */
> +	DIMM_GROUP_DUMMY_REG,
> +	CH4_DIMM_TEMP_REG,
> +	CH5_DIMM_TEMP_REG,
> +	CH6_DIMM_TEMP_REG,
> +	CH7_DIMM_TEMP_REG,
> +	MEM_HOT_THRESHOLD_REG,
> +	SOC_VR_HOT_THRESHOLD_REG,
> +	RCA_VRD_TEMP_REG,
> +};
> +
> +static const u8 volt_regs[] = {
> +	CORE_VRD_VOLT_REG,
> +	SOC_VRD_VOLT_REG,
> +	DIMM_VRD1_VOLT_REG,
> +	DIMM_VRD2_VOLT_REG,
> +	/* vrd1 has higher priority than vrd2 using vrd1 as output for ddr */

What is the point of this comment ?

> +	DIMM_VRD1_VOLT_REG,

That doesn't make sense. It appears that DIMM VRD1
is reported as DIMM VRD1 _and_ as DIMM VRD. I don't know
what this is supposed to accomplish, but no. Please remove
all instances of "virtual" attributes.

> +	RCA_VRD_VOLT_REG,
> +};
> +
> +static const u8 curr_regs[] = {
> +	CORE_VRD_CURR_REG,
> +	SOC_VRD_CURR_REG,
> +	DIMM_VRD1_CURR_REG,
> +	DIMM_VRD2_CURR_REG,
> +	RCA_VRD_CURR_REG,
> +};
> +
> +enum pwr_regs {
> +	CORE_VRD_PWR,
> +	SOC_PWR,
> +	DIMM_VRD1_PWR,
> +	DIMM_VRD2_PWR,
> +	CPU_VRD_PWR,
> +	DIMM_VRD_PWR,
> +	RCA_VRD_PWR,
> +	SOC_TDP_PWR,
> +};

Add empty line. And run checkpatch - it would have told you.

> +static const char * const label[] = {
> +	"SoC",
> +	"SoC VRD",
> +	"DIMM VRD",
> +	"DIMM VRD1",
> +	"DIMM VRD2",
> +	"CORE VRD",
> +	"CH0 DIMM",
> +	"CH1 DIMM",
> +	"CH2 DIMM",
> +	"CH3 DIMM",
> +	"CH4 DIMM",
> +	"CH5 DIMM",
> +	"CH6 DIMM",
> +	"CH7 DIMM",
> +	"MEM HOT",
> +	"SoC VR HOT",
> +	"CPU VRD",
> +	"RCA VRD",
> +	"SOC TDP",
> +	"DIMM G0",
> +	"DIMM G1",
> +};
> +
> +static int smpro_read_temp(struct device *dev, u32 attr, int channel,
> +				long *val)

This looks suspicious, and indeed, checkpatch states:

total: 0 errors, 2 warnings, 31 checks, 641 lines checked

Besides, the line length limit is now 100 columns.

> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int t_max = 0xffffffff;
> +	unsigned int value;
> +	s32 i;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		if (temp_regs[channel] == DIMM_GROUP_DUMMY_REG) {
> +			for (i = 1; i <= 4; i++) {
> +				ret = regmap_read(hwmon->regmap,
> +						temp_regs[channel + i], &value);
> +				if (ret)
> +					return ret;
> +				/* continue if invalid */
> +				if (value == 0xffff)
> +					continue;
> +
> +				value &= 0x1ff; /* 9-bit value */
> +				if (t_max != 0xffffffff)
> +					t_max = (value > t_max) ? value : t_max;
> +				else
> +					t_max = value;
> +			}

This needs explanation. Why not return four different sensor values ?
Otherwise, why four different registers to read data for a single sensor ?

But ... no, wait, it looks like this is used to report the maximum
of the subsequent four DIMMs. No, this is unacceptable. If this
"channel" does not exist, but the index/channel is for some reason
needed, report it as not visible using the is_visible callback.

> +
> +			if (t_max == 0xffffffff)
> +				return -1;

Valid error codes, please. -1 translates to -EPERM. However,
it looks like this may suggest that the DIMMs are not populated.
If so, mask affected channels using the is_visible callback.

> +
> +			*val = t_max * 1000;
> +		} else {
> +			ret = regmap_read(hwmon->regmap,
> +					temp_regs[channel], &value);
> +			if (ret)
> +				return ret;
> +			*val = (value & 0x1ff) * 1000;

Above code suggests that a value of 0xffff might be reported,
which micht suggest an unpopulated sensor (eg an unpouplated DIMM).
The driver should not blindly report 255 Dgrees C in that situation,
but instead mark the sensor as invisible.

The same applies to all other sensors.

> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int smpro_read_in(struct device *dev, u32 attr, int channel,
> +				long *val)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		ret = regmap_read(hwmon->regmap, volt_regs[channel], &value);
> +		if (ret < 0)
> +			return ret;
> +		*val = value & 0x7fff; /* 15-bit value */

Scale reported by the hardware is 1mV ? Justw wondering;
a brief comment might make sense.

> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read_curr(struct device *dev, u32 attr, int channel,
> +				long *val)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		ret = regmap_read(hwmon->regmap, curr_regs[channel], &value);
> +		if (ret < 0)
> +			return ret;
> +		*val = value & 0x7fff; /* 15-bit value */
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read_power(struct device *dev, u32 attr, int channel,
> +				long *val_pwr)
> +{
> +	struct smpro_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int val2, val2_mw;
> +	unsigned int val, val_mw;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		switch (channel) {
> +		case CORE_VRD_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					CORE_VRD_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						CORE_VRD_PWR_MW_REG, &val_mw);
> +			if (ret)
> +				return ret;

Please handle errors directly.

			ret = regmap_read();
			if (ret)
				return ret;
			ret = regmap_read()
			if (ret)
				return ret;

Same everywhere below.

> +			break;
> +		case SOC_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					SOC_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						SOC_PWR_MW_REG, &val_mw);
> +			if (ret)
> +				return ret;
> +			break;
> +		case DIMM_VRD1_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					DIMM_VRD1_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						DIMM_VRD1_PWR_MW_REG, &val_mw);
> +			if (ret)
> +				return ret;
> +			break;
> +		case DIMM_VRD2_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					DIMM_VRD2_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						DIMM_VRD2_PWR_MW_REG, &val_mw);
> +			if (ret)
> +				return ret;
> +			break;
> +		case RCA_VRD_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					RCA_VRD_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						RCA_VRD_PWR_MW_REG, &val_mw);
> +			if (ret)
> +				return ret;
> +			break;
> +		case SOC_TDP_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					SOC_TDP_REG, &val);
> +			if (ret)
> +				return ret;
> +			break;
> +		case CPU_VRD_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					CORE_VRD_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						CORE_VRD_PWR_MW_REG, &val_mw);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						SOC_PWR_REG, &val2);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						SOC_PWR_MW_REG, &val2_mw);
> +			if (ret)
> +				return ret;
> +			break;
> +		case DIMM_VRD_PWR:
> +			ret = regmap_read(hwmon->regmap,
> +					DIMM_VRD1_PWR_REG, &val);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						DIMM_VRD1_PWR_MW_REG, &val_mw);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						DIMM_VRD2_PWR_REG, &val2);
> +			if (!ret)
> +				ret = regmap_read(hwmon->regmap,
> +						DIMM_VRD2_PWR_MW_REG, &val2_mw);
> +			if (ret)
> +				return ret;
> +			break;

Ah, there are more "virtual" atributes. Again, please remove all those.
If userspace w ants to group attributes in whatever way it wants to, fine,
but that is not a kernel concern.

Besides, what if a DIMM is unpopulated ?

> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		/* Set to 0 if invalid */
> +		if (val_mw == 0xffff)
> +			val_mw = 0;
> +		if (val2_mw == 0xffff)
> +			val2_mw = 0;
> +

Does this indicate a temporary or a permanent problem ?
If it means that the sensor is not populated, it should be
handled in is_visible. Also, what about val / val2 ?

> +		*val_pwr = (val + val2) * 1000000 + (val_mw + val2_mw) * 1000;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_read(struct device *dev, enum hwmon_sensor_types type,
> +				u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return smpro_read_temp(dev, attr, channel, val);
> +	case hwmon_in:
> +		return smpro_read_in(dev, attr, channel, val);
> +	case hwmon_power:
> +		return smpro_read_power(dev, attr, channel, val);
> +	case hwmon_curr:
> +		return smpro_read_curr(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int smpro_write(struct device *dev, enum hwmon_sensor_types type,
> +				u32 attr, int channel, long val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static umode_t smpro_is_visible(const void *data,
> +				enum hwmon_sensor_types type,
> +				u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
> +				char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +
> +	return sprintf(buf, "%s\n", label[index]);
> +}
> +
> +static const u32 smpro_temp_config[] = {
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info smpro_temp = {
> +	.type = hwmon_temp,
> +	.config = smpro_temp_config,
> +};
> +
> +static const u32 smpro_in_config[] = {
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info smpro_in = {
> +	.type = hwmon_in,
> +	.config = smpro_in_config,
> +};
> +
> +static const u32 smpro_curr_config[] = {
> +	HWMON_C_INPUT,
> +	HWMON_C_INPUT,
> +	HWMON_C_INPUT,
> +	HWMON_C_INPUT,
> +	HWMON_C_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info smpro_curr = {
> +	.type = hwmon_curr,
> +	.config = smpro_curr_config,
> +};
> +
> +static const u32 smpro_power_config[] = {
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	HWMON_P_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info smpro_power = {
> +	.type = hwmon_power,
> +	.config = smpro_power_config,
> +};
> +
> +static const struct hwmon_channel_info *smpro_info[] = {
> +	&smpro_temp,
> +	&smpro_in,
> +	&smpro_power,
> +	&smpro_curr,
> +	NULL
> +};
> +

The above can all be polulated with HWMON_CHANNEL_INFO().

> +static const struct hwmon_ops smpro_hwmon_ops = {
> +	.is_visible = smpro_is_visible,
> +	.read = smpro_read,
> +	.write = smpro_write,
> +};
> +
> +static const struct hwmon_chip_info smpro_chip_info = {
> +	.ops = &smpro_hwmon_ops,
> +	.info = smpro_info,
> +};
> +
> +static SENSOR_DEVICE_ATTR(temp1_label, 0444, show_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_label, 0444, show_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_label, 0444, show_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_label, 0444, show_label, NULL, 5);
> +static SENSOR_DEVICE_ATTR(temp5_label, 0444, show_label, NULL, 19);
> +static SENSOR_DEVICE_ATTR(temp6_label, 0444, show_label, NULL, 6);
> +static SENSOR_DEVICE_ATTR(temp7_label, 0444, show_label, NULL, 7);
> +static SENSOR_DEVICE_ATTR(temp8_label, 0444, show_label, NULL, 8);
> +static SENSOR_DEVICE_ATTR(temp9_label, 0444, show_label, NULL, 9);
> +static SENSOR_DEVICE_ATTR(temp10_label, 0444, show_label, NULL, 20);
> +static SENSOR_DEVICE_ATTR(temp11_label, 0444, show_label, NULL, 10);
> +static SENSOR_DEVICE_ATTR(temp12_label, 0444, show_label, NULL, 11);
> +static SENSOR_DEVICE_ATTR(temp13_label, 0444, show_label, NULL, 12);
> +static SENSOR_DEVICE_ATTR(temp14_label, 0444, show_label, NULL, 13);
> +static SENSOR_DEVICE_ATTR(temp15_label, 0444, show_label, NULL, 14);
> +static SENSOR_DEVICE_ATTR(temp16_label, 0444, show_label, NULL, 15);
> +static SENSOR_DEVICE_ATTR(temp17_label, 0444, show_label, NULL, 17);
> +
> +static SENSOR_DEVICE_ATTR(in0_label, 0444, show_label, NULL, 5);
> +static SENSOR_DEVICE_ATTR(in1_label, 0444, show_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_label, 0444, show_label, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in3_label, 0444, show_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(in4_label, 0444, show_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in5_label, 0444, show_label, NULL, 17);
> +
> +static SENSOR_DEVICE_ATTR(power1_label, 0444, show_label, NULL, 5);
> +static SENSOR_DEVICE_ATTR(power2_label, 0444, show_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power3_label, 0444, show_label, NULL, 3);
> +static SENSOR_DEVICE_ATTR(power4_label, 0444, show_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(power5_label, 0444, show_label, NULL, 16);
> +static SENSOR_DEVICE_ATTR(power6_label, 0444, show_label, NULL, 2);
> +static SENSOR_DEVICE_ATTR(power7_label, 0444, show_label, NULL, 17);
> +static SENSOR_DEVICE_ATTR(power8_label, 0444, show_label, NULL, 18);
> +
> +static SENSOR_DEVICE_ATTR(curr1_label, 0444, show_label, NULL, 5);
> +static SENSOR_DEVICE_ATTR(curr2_label, 0444, show_label, NULL, 1);
> +static SENSOR_DEVICE_ATTR(curr3_label, 0444, show_label, NULL, 3);
> +static SENSOR_DEVICE_ATTR(curr4_label, 0444, show_label, NULL, 4);
> +static SENSOR_DEVICE_ATTR(curr5_label, 0444, show_label, NULL, 17);
> +
> +static struct attribute *smpro_attrs[] = {
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,
> +	&sensor_dev_attr_temp6_label.dev_attr.attr,
> +	&sensor_dev_attr_temp7_label.dev_attr.attr,
> +	&sensor_dev_attr_temp8_label.dev_attr.attr,
> +	&sensor_dev_attr_temp9_label.dev_attr.attr,
> +	&sensor_dev_attr_temp10_label.dev_attr.attr,
> +	&sensor_dev_attr_temp11_label.dev_attr.attr,
> +	&sensor_dev_attr_temp12_label.dev_attr.attr,
> +	&sensor_dev_attr_temp13_label.dev_attr.attr,
> +	&sensor_dev_attr_temp14_label.dev_attr.attr,
> +	&sensor_dev_attr_temp15_label.dev_attr.attr,
> +	&sensor_dev_attr_temp16_label.dev_attr.attr,
> +	&sensor_dev_attr_temp17_label.dev_attr.attr,
> +
> +	&sensor_dev_attr_in0_label.dev_attr.attr,
> +	&sensor_dev_attr_in1_label.dev_attr.attr,
> +	&sensor_dev_attr_in2_label.dev_attr.attr,
> +	&sensor_dev_attr_in3_label.dev_attr.attr,
> +	&sensor_dev_attr_in4_label.dev_attr.attr,
> +	&sensor_dev_attr_in5_label.dev_attr.attr,
> +
> +	&sensor_dev_attr_curr1_label.dev_attr.attr,
> +	&sensor_dev_attr_curr2_label.dev_attr.attr,
> +	&sensor_dev_attr_curr3_label.dev_attr.attr,
> +	&sensor_dev_attr_curr4_label.dev_attr.attr,
> +	&sensor_dev_attr_curr5_label.dev_attr.attr,
> +
> +	&sensor_dev_attr_power1_label.dev_attr.attr,
> +	&sensor_dev_attr_power2_label.dev_attr.attr,
> +	&sensor_dev_attr_power3_label.dev_attr.attr,
> +	&sensor_dev_attr_power4_label.dev_attr.attr,
> +	&sensor_dev_attr_power5_label.dev_attr.attr,
> +	&sensor_dev_attr_power6_label.dev_attr.attr,
> +	&sensor_dev_attr_power7_label.dev_attr.attr,
> +	&sensor_dev_attr_power8_label.dev_attr.attr,
> +
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(smpro);
> +

This can be done with LABEL attributes (HWMON_T_LABEL etc).

> +static int is_valid_id(struct regmap *regmap)

bool

> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(regmap, MANUFACTURER_ID_REG, &val);
> +
> +	return  (ret || (val != AMPERE_MANUFACTURER_ID)) ? 0 : 1;
> +}
> +
> +static int smpro_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct smpro_hwmon *hwmon;
> +	struct device *hwmon_dev;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct smpro_hwmon),
> +			GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	hwmon->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!hwmon->regmap)
> +		return -ENODEV;
> +
> +	/* Check for valid ID */
> +	if (!is_valid_id(hwmon->regmap))
> +		dev_warn(&pdev->dev, "Hmmh, SMPro not ready yet\n");

This does not appear appropriate. It should be either -EPROBE_DEFER
or -ENODEV.

> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +			"smpro_hwmon", hwmon,
> +			&smpro_chip_info, smpro_groups);
> +	if (IS_ERR(hwmon_dev))
> +		dev_err(&pdev->dev, "failed to register as hwmon device");

Unnecessary error message. It is either -EINVAL, which would
always be the case, or -ENOMEM, which is already reported.

> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id smpro_hwmon_of_match[] = {
> +	{ .compatible = "ampere,ac01-hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, smpro_hwmon_of_match);
> +
> +static struct platform_driver smpro_hwmon_driver = {
> +	.probe		= smpro_hwmon_probe,
> +	.driver = {
> +		.name	= "smpro-hwmon",
> +		.of_match_table = smpro_hwmon_of_match,
> +	},
> +};
> +
> +module_platform_driver(smpro_hwmon_driver);
> +
> +MODULE_AUTHOR("Thu Nguyen <thu@os.amperecomputing.com>");
> +MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
> +MODULE_DESCRIPTION("Ampere Altra SMPro hwmon driver");
> +MODULE_LICENSE("GPL");
> 

