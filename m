From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Jul 2021 15:04:05 -0700
Subject: [PATCH 11/14] hwmon: peci: Add cputemp driver
In-Reply-To: <fb4ace5c357832e8b5131a5e6f8e07ed42c7f634.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-12-iwona.winiarska@intel.com>
 <20210727070651.GP8018@packtop>
 <fb4ace5c357832e8b5131a5e6f8e07ed42c7f634.camel@intel.com>
Message-ID: <5613c531-5c6a-c2ec-9081-63db50a108b3@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/30/21 2:51 PM, Winiarska, Iwona wrote:
> On Tue, 2021-07-27 at 07:06 +0000, Zev Weiss wrote:
>> On Mon, Jul 12, 2021 at 05:04:44PM CDT, Iwona Winiarska wrote:
>>> Add peci-cputemp driver for Digital Thermal Sensor (DTS) thermal
>>> readings of the processor package and processor cores that are
>>> accessible via the PECI interface.
>>>
>>> The main use case for the driver (and PECI interface) is out-of-band
>>> management, where we're able to obtain the DTS readings from an external
>>> entity connected with PECI, e.g. BMC on server platforms.
>>>
>>> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
>>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> ---
>>> MAINTAINERS????????????????? |?? 7 +
>>> drivers/hwmon/Kconfig??????? |?? 2 +
>>> drivers/hwmon/Makefile?????? |?? 1 +
>>> drivers/hwmon/peci/Kconfig?? |? 18 ++
>>> drivers/hwmon/peci/Makefile? |?? 5 +
>>> drivers/hwmon/peci/common.h? |? 46 ++++
>>> drivers/hwmon/peci/cputemp.c | 503 +++++++++++++++++++++++++++++++++++
>>> 7 files changed, 582 insertions(+)
>>> create mode 100644 drivers/hwmon/peci/Kconfig
>>> create mode 100644 drivers/hwmon/peci/Makefile
>>> create mode 100644 drivers/hwmon/peci/common.h
>>> create mode 100644 drivers/hwmon/peci/cputemp.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f47b5f634293..35ba9e3646bd 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -14504,6 +14504,13 @@ L:?????platform-driver-x86 at vger.kernel.org
>>> S:??????Maintained
>>> F:??????drivers/platform/x86/peaq-wmi.c
>>>
>>> +PECI HARDWARE MONITORING DRIVERS
>>> +M:?????Iwona Winiarska <iwona.winiarska@intel.com>
>>> +R:?????Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> +L:?????linux-hwmon at vger.kernel.org
>>> +S:?????Supported
>>> +F:?????drivers/hwmon/peci/
>>> +
>>> PECI SUBSYSTEM
>>> M:??????Iwona Winiarska <iwona.winiarska@intel.com>
>>> R:??????Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index e3675377bc5d..61c0e3404415 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -1507,6 +1507,8 @@ config SENSORS_PCF8591
>>>  ????????? These devices are hard to detect and rarely found on mainstream
>>>  ????????? hardware. If unsure, say N.
>>>
>>> +source "drivers/hwmon/peci/Kconfig"
>>> +
>>> source "drivers/hwmon/pmbus/Kconfig"
>>>
>>> config SENSORS_PWM_FAN
>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>> index d712c61c1f5e..f52331f212ed 100644
>>> --- a/drivers/hwmon/Makefile
>>> +++ b/drivers/hwmon/Makefile
>>> @@ -202,6 +202,7 @@ obj-$(CONFIG_SENSORS_WM8350)????????+= wm8350-hwmon.o
>>> obj-$(CONFIG_SENSORS_XGENE)?????+= xgene-hwmon.o
>>>
>>> obj-$(CONFIG_SENSORS_OCC)???????+= occ/
>>> +obj-$(CONFIG_SENSORS_PECI)?????+= peci/
>>> obj-$(CONFIG_PMBUS)?????????????+= pmbus/
>>>
>>> ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>> diff --git a/drivers/hwmon/peci/Kconfig b/drivers/hwmon/peci/Kconfig
>>> new file mode 100644
>>> index 000000000000..e10eed68d70a
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/Kconfig
>>> @@ -0,0 +1,18 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +config SENSORS_PECI_CPUTEMP
>>> +???????tristate "PECI CPU temperature monitoring client"
>>> +???????depends on PECI
>>> +???????select SENSORS_PECI
>>> +???????select PECI_CPU
>>> +???????help
>>> +???????? If you say yes here you get support for the generic Intel PECI
>>> +???????? cputemp driver which provides Digital Thermal Sensor (DTS) thermal
>>> +???????? readings of the CPU package and CPU cores that are accessible via
>>> +???????? the processor PECI interface.
>>> +
>>> +???????? This driver can also be built as a module. If so, the module
>>> +???????? will be called peci-cputemp.
>>> +
>>> +config SENSORS_PECI
>>> +???????tristate
>>> diff --git a/drivers/hwmon/peci/Makefile b/drivers/hwmon/peci/Makefile
>>> new file mode 100644
>>> index 000000000000..e8a0ada5ab1f
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/Makefile
>>> @@ -0,0 +1,5 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +peci-cputemp-y := cputemp.o
>>> +
>>> +obj-$(CONFIG_SENSORS_PECI_CPUTEMP)?????+= peci-cputemp.o
>>> diff --git a/drivers/hwmon/peci/common.h b/drivers/hwmon/peci/common.h
>>> new file mode 100644
>>> index 000000000000..54580c100d06
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/common.h
>>> @@ -0,0 +1,46 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/* Copyright (c) 2021 Intel Corporation */
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +#ifndef __PECI_HWMON_COMMON_H
>>> +#define __PECI_HWMON_COMMON_H
>>> +
>>> +#define UPDATE_INTERVAL_DEFAULT????????????????HZ
>>> +
>>> +/**
>>> + * struct peci_sensor_data - PECI sensor information
>>> + * @valid: flag to indicate the sensor value is valid
>>> + * @value: sensor value in milli units
>>> + * @last_updated: time of the last update in jiffies
>>> + */
>>> +struct peci_sensor_data {
>>> +???????unsigned int valid;
>>
>>  From what I can see it looks like the 'valid' member here is strictly a
>> one-shot has-this-value-ever-been-set indicator, which seems a bit
>> wasteful to keep around forever post initialization; couldn't the same
>> information be inferred from checking last_updated != 0 or something?
> 
> That's just expressed in jiffies, which means it can overflow (we're just
> unlikely to hit it - but IIUC it can happen).
> Doing it this way would require making sure that last_updated is never set to 0
> in code that does the update. I don't think it's worth to add more complexity
> there just to save a couple of bytes.
> 

Correct. There are ways around that (eg by setting 'last_updated' to some time
in the past), but that isn't really worth the trouble.

'valid' should be bool, though, not "unsigned int".

Guenter

>>
>>> +???????s32 value;
>>> +???????unsigned long last_updated;
>>> +};
>>> +
>>> +/**
>>> + * peci_sensor_need_update() - check whether sensor update is needed or not
>>> + * @sensor: pointer to sensor data struct
>>> + *
>>> + * Return: true if update is needed, false if not.
>>> + */
>>> +
>>> +static inline bool peci_sensor_need_update(struct peci_sensor_data *sensor)
>>> +{
>>> +???????return !sensor->valid ||
>>> +????????????? time_after(jiffies, sensor->last_updated +
>>> UPDATE_INTERVAL_DEFAULT);
>>> +}
>>> +
>>> +/**
>>> + * peci_sensor_mark_updated() - mark the sensor is updated
>>> + * @sensor: pointer to sensor data struct
>>> + */
>>> +static inline void peci_sensor_mark_updated(struct peci_sensor_data
>>> *sensor)
>>> +{
>>> +???????sensor->valid = 1;
>>> +???????sensor->last_updated = jiffies;
>>> +}
>>> +
>>> +#endif /* __PECI_HWMON_COMMON_H */
>>> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
>>> new file mode 100644
>>> index 000000000000..56a526471687
>>> --- /dev/null
>>> +++ b/drivers/hwmon/peci/cputemp.c
>>> @@ -0,0 +1,503 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +// Copyright (c) 2018-2021 Intel Corporation
>>> +
>>> +#include <linux/auxiliary_bus.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/module.h>
>>> +#include <linux/peci.h>
>>> +#include <linux/peci-cpu.h>
>>> +#include <linux/units.h>
>>> +#include <linux/x86/intel-family.h>
>>> +
>>> +#include "common.h"
>>> +
>>> +#define CORE_NUMS_MAX??????????64
>>> +
>>> +#define DEFAULT_CHANNEL_NUMS???5
>>
>> DEFAULT_ seems like a slightly odd prefix for this (it's not something
>> that can really be overridden or anything); would BASE_ perhaps be a bit
>> more appropriate?
> 
> Ack.
> 
>>
>>> +#define CORETEMP_CHANNEL_NUMS??CORE_NUMS_MAX
>>> +#define CPUTEMP_CHANNEL_NUMS???(DEFAULT_CHANNEL_NUMS +
>>> CORETEMP_CHANNEL_NUMS)
>>> +
>>> +#define TEMP_TARGET_FAN_TEMP_MASK??????GENMASK(15, 8)
>>> +#define TEMP_TARGET_REF_TEMP_MASK??????GENMASK(23, 16)
>>> +#define TEMP_TARGET_TJ_OFFSET_MASK?????GENMASK(29, 24)
>>> +
>>> +#define DTS_MARGIN_MASK????????????????GENMASK(15, 0)
>>> +#define PCS_MODULE_TEMP_MASK???GENMASK(15, 0)
>>> +
>>> +#define DTS_FIXED_POINT_FRACTION???????64
>>> +
>>> +struct resolved_cores_reg {
>>> +???????u8 bus;
>>> +???????u8 dev;
>>> +???????u8 func;
>>> +???????u8 offset;
>>> +};
>>> +
>>> +struct cpu_info {
>>> +???????struct resolved_cores_reg *reg;
>>> +???????u8 min_peci_revision;
>>
>> As with the dimmtemp driver, min_peci_revision appears unused here,
>> though in this case if it were removed there'd only be one (pointer)
>> member left in struct cpu_info, so we could perhaps remove it as well
>> and then also a level of indirection in peci_cputemp_ids/cpu_{hsx,icx}
>> too?
> 
> As I mentioned in reply to previous patch comment, it'll be used to validate if
> PECI device revision matches driver requirements.
> 
>>
>>> +};
>>> +
>>> +struct peci_cputemp {
>>> +???????struct peci_device *peci_dev;
>>> +???????struct device *dev;
>>> +???????const char *name;
>>> +???????const struct cpu_info *gen_info;
>>> +???????struct {
>>> +???????????????struct peci_sensor_data die;
>>> +???????????????struct peci_sensor_data dts;
>>> +???????????????struct peci_sensor_data tcontrol;
>>> +???????????????struct peci_sensor_data tthrottle;
>>> +???????????????struct peci_sensor_data tjmax;
>>> +???????????????struct peci_sensor_data core[CORETEMP_CHANNEL_NUMS];
>>> +???????} temp;
>>> +???????const char **coretemp_label;
>>> +???????DECLARE_BITMAP(core_mask, CORE_NUMS_MAX);
>>> +};
>>> +
>>> +enum cputemp_channels {
>>> +???????channel_die,
>>> +???????channel_dts,
>>> +???????channel_tcontrol,
>>> +???????channel_tthrottle,
>>> +???????channel_tjmax,
>>> +???????channel_core,
>>> +};
>>> +
>>> +static const char *cputemp_label[DEFAULT_CHANNEL_NUMS] = {
>>
>> static const char * const cputemp_label?? (That is, const pointer to
>> const char, rather than non-const pointer to const char.)
> 
> Ack.
> 
>>
>>> +???????"Die",
>>> +???????"DTS",
>>> +???????"Tcontrol",
>>> +???????"Tthrottle",
>>> +???????"Tjmax",
>>> +};
>>> +
>>> +static int get_temp_targets(struct peci_cputemp *priv)
>>> +{
>>> +???????s32 tthrottle_offset, tcontrol_margin;
>>> +???????u32 pcs;
>>> +???????int ret;
>>> +
>>> +???????/*
>>> +??????? * Just use only the tcontrol marker to determine if target values
>>> need
>>> +??????? * update.
>>> +??????? */
>>> +???????if (!peci_sensor_need_update(&priv->temp.tcontrol))
>>> +???????????????return 0;
>>> +
>>> +???????ret = peci_pcs_read(priv->peci_dev, PECI_PCS_TEMP_TARGET, 0, &pcs);
>>> +???????if (ret)
>>> +???????????????return ret;
>>> +
>>> +???????priv->temp.tjmax.value = FIELD_GET(TEMP_TARGET_REF_TEMP_MASK, pcs) *
>>> MILLIDEGREE_PER_DEGREE;
>>> +
>>> +???????tcontrol_margin = FIELD_GET(TEMP_TARGET_FAN_TEMP_MASK, pcs);
>>> +???????tcontrol_margin = sign_extend32(tcontrol_margin, 7) *
>>> MILLIDEGREE_PER_DEGREE;
>>> +???????priv->temp.tcontrol.value = priv->temp.tjmax.value -
>>> tcontrol_margin;
>>> +
>>> +???????tthrottle_offset = FIELD_GET(TEMP_TARGET_TJ_OFFSET_MASK, pcs) *
>>> MILLIDEGREE_PER_DEGREE;
>>> +???????priv->temp.tthrottle.value = priv->temp.tjmax.value -
>>> tthrottle_offset;
>>> +
>>> +???????peci_sensor_mark_updated(&priv->temp.tcontrol);
>>> +
>>> +???????return 0;
>>> +}
>>> +
>>> +/*
>>> + * Processors return a value of DTS reading in S10.6 fixed point format
>>> + * (sign, 10 bits signed integer value, 6 bits fractional).
>>
>> This parenthetical reads to me like it's describing 17 bits -- I'm not a
>> PECI expert, but from my reading of the (somewhat skimpy) docs I've got
>> on it I'd suggest a description more like "sign, 9-bit magnitude, 6-bit
>> fraction".
> 
> You're right, adding "sign" here was not intentional.
> I'll change it to:
> "16 bits: sign, 9-bit magnitude, 6-bit fraction"
> or
> "16 bits: 10-bit signed magnitude, 6-bit fraction"
> 
> Thanks
> -Iwona
> 

