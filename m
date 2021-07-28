From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Jul 2021 17:49:01 -0700
Subject: [PATCH 13/14] docs: hwmon: Document PECI drivers
In-Reply-To: <20210727225808.GU8018@packtop>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-14-iwona.winiarska@intel.com>
 <20210727225808.GU8018@packtop>
Message-ID: <0521a076-9772-532f-2eab-8870464ca211@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/27/21 3:58 PM, Zev Weiss wrote:
> On Mon, Jul 12, 2021 at 05:04:46PM CDT, Iwona Winiarska wrote:
>> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>
>> Add documentation for peci-cputemp driver that provides DTS thermal
>> readings for CPU packages and CPU cores and peci-dimmtemp driver that
>> provides DTS thermal readings for DIMMs.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
>> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>> Documentation/hwmon/index.rst         |  2 +
>> Documentation/hwmon/peci-cputemp.rst  | 93 +++++++++++++++++++++++++++
>> Documentation/hwmon/peci-dimmtemp.rst | 58 +++++++++++++++++
>> MAINTAINERS                           |  2 +
>> 4 files changed, 155 insertions(+)
>> create mode 100644 Documentation/hwmon/peci-cputemp.rst
>> create mode 100644 Documentation/hwmon/peci-dimmtemp.rst
>>
>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>> index bc01601ea81a..cc76b5b3f791 100644
>> --- a/Documentation/hwmon/index.rst
>> +++ b/Documentation/hwmon/index.rst
>> @@ -154,6 +154,8 @@ Hardware Monitoring Kernel Drivers
>>     pcf8591
>>     pim4328
>>     pm6764tr
>> +   peci-cputemp
>> +   peci-dimmtemp
>>     pmbus
>>     powr1220
>>     pxe1610
>> diff --git a/Documentation/hwmon/peci-cputemp.rst b/Documentation/hwmon/peci-cputemp.rst
>> new file mode 100644
>> index 000000000000..d3a218ba810a
>> --- /dev/null
>> +++ b/Documentation/hwmon/peci-cputemp.rst
>> @@ -0,0 +1,93 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +Kernel driver peci-cputemp
>> +==========================
>> +
>> +Supported chips:
>> +	One of Intel server CPUs listed below which is connected to a PECI bus.
>> +		* Intel Xeon E5/E7 v3 server processors
>> +			Intel Xeon E5-14xx v3 family
>> +			Intel Xeon E5-24xx v3 family
>> +			Intel Xeon E5-16xx v3 family
>> +			Intel Xeon E5-26xx v3 family
>> +			Intel Xeon E5-46xx v3 family
>> +			Intel Xeon E7-48xx v3 family
>> +			Intel Xeon E7-88xx v3 family
>> +		* Intel Xeon E5/E7 v4 server processors
>> +			Intel Xeon E5-16xx v4 family
>> +			Intel Xeon E5-26xx v4 family
>> +			Intel Xeon E5-46xx v4 family
>> +			Intel Xeon E7-48xx v4 family
>> +			Intel Xeon E7-88xx v4 family
>> +		* Intel Xeon Scalable server processors
>> +			Intel Xeon D family
>> +			Intel Xeon Bronze family
>> +			Intel Xeon Silver family
>> +			Intel Xeon Gold family
>> +			Intel Xeon Platinum family
>> +
>> +	Datasheet: Available from http://www.intel.com/design/literature.htm
>> +
>> +Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> +
>> +Description
>> +-----------
>> +
>> +This driver implements a generic PECI hwmon feature which provides Digital
>> +Thermal Sensor (DTS) thermal readings of the CPU package and CPU cores that are
>> +accessible via the processor PECI interface.
>> +
>> +All temperature values are given in millidegree Celsius and will be measurable
>> +only when the target CPU is powered on.
>> +
>> +Sysfs interface
>> +-------------------
>> +
>> +======================= =======================================================
>> +temp1_label		"Die"
>> +temp1_input		Provides current die temperature of the CPU package.
>> +temp1_max		Provides thermal control temperature of the CPU package
>> +			which is also known as Tcontrol.
>> +temp1_crit		Provides shutdown temperature of the CPU package which
>> +			is also known as the maximum processor junction
>> +			temperature, Tjmax or Tprochot.
>> +temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
>> +			the CPU package.
>> +
>> +temp2_label		"DTS"
>> +temp2_input		Provides current DTS temperature of the CPU package.
> 
> Would this be a good place to note the slightly counter-intuitive nature
> of DTS readings?  i.e. add something along the lines of "The DTS sensor
> produces a delta relative to Tjmax, so negative values are normal and
> values approaching zero are hot."  (In my experience people who aren't
> already familiar with it tend to think something's wrong when a CPU
> temperature reading shows -50C.)
> 

All attributes shall follow the ABI, and the driver must translate reported
values to degrees C. If those sensors do not follow the ABI and report something
else, I won't accept the driver.

Guenter

>> +temp2_max		Provides thermal control temperature of the CPU package
>> +			which is also known as Tcontrol.
>> +temp2_crit		Provides shutdown temperature of the CPU package which
>> +			is also known as the maximum processor junction
>> +			temperature, Tjmax or Tprochot.
>> +temp2_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
>> +			the CPU package.
>> +
>> +temp3_label		"Tcontrol"
>> +temp3_input		Provides current Tcontrol temperature of the CPU
>> +			package which is also known as Fan Temperature target.
>> +			Indicates the relative value from thermal monitor trip
>> +			temperature at which fans should be engaged.
>> +temp3_crit		Provides Tcontrol critical value of the CPU package
>> +			which is same to Tjmax.
>> +
>> +temp4_label		"Tthrottle"
>> +temp4_input		Provides current Tthrottle temperature of the CPU
>> +			package. Used for throttling temperature. If this value
>> +			is allowed and lower than Tjmax - the throttle will
>> +			occur and reported at lower than Tjmax.
>> +
>> +temp5_label		"Tjmax"
>> +temp5_input		Provides the maximum junction temperature, Tjmax of the
>> +			CPU package.
>> +
>> +temp[6-N]_label		Provides string "Core X", where X is resolved core
>> +			number.
>> +temp[6-N]_input		Provides current temperature of each core.
>> +temp[6-N]_max		Provides thermal control temperature of the core.
>> +temp[6-N]_crit		Provides shutdown temperature of the core.
>> +temp[6-N]_crit_hyst	Provides the hysteresis value from Tcontrol to Tjmax of
>> +			the core.
> 
> I only see *_label and *_input for the per-core temperature sensors, no
> *_max, *_crit, or *_crit_hyst.
> 
>> +
>> +======================= =======================================================
>> diff --git a/Documentation/hwmon/peci-dimmtemp.rst b/Documentation/hwmon/peci-dimmtemp.rst
>> new file mode 100644
>> index 000000000000..1778d9317e43
>> --- /dev/null
>> +++ b/Documentation/hwmon/peci-dimmtemp.rst
>> @@ -0,0 +1,58 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Kernel driver peci-dimmtemp
>> +===========================
>> +
>> +Supported chips:
>> +	One of Intel server CPUs listed below which is connected to a PECI bus.
>> +		* Intel Xeon E5/E7 v3 server processors
>> +			Intel Xeon E5-14xx v3 family
>> +			Intel Xeon E5-24xx v3 family
>> +			Intel Xeon E5-16xx v3 family
>> +			Intel Xeon E5-26xx v3 family
>> +			Intel Xeon E5-46xx v3 family
>> +			Intel Xeon E7-48xx v3 family
>> +			Intel Xeon E7-88xx v3 family
>> +		* Intel Xeon E5/E7 v4 server processors
>> +			Intel Xeon E5-16xx v4 family
>> +			Intel Xeon E5-26xx v4 family
>> +			Intel Xeon E5-46xx v4 family
>> +			Intel Xeon E7-48xx v4 family
>> +			Intel Xeon E7-88xx v4 family
>> +		* Intel Xeon Scalable server processors
>> +			Intel Xeon D family
>> +			Intel Xeon Bronze family
>> +			Intel Xeon Silver family
>> +			Intel Xeon Gold family
>> +			Intel Xeon Platinum family
>> +
>> +	Datasheet: Available from http://www.intel.com/design/literature.htm
>> +
>> +Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> +
>> +Description
>> +-----------
>> +
>> +This driver implements a generic PECI hwmon feature which provides Digital
>> +Thermal Sensor (DTS) thermal readings of DIMM components that are accessible
>> +via the processor PECI interface.
> 
> I had thought "DTS" referred to a fairly specific sensor in the CPU; is
> the same term also used for DIMM temp sensors or is the mention of it
> here a copy/paste error?
> 
>> +
>> +All temperature values are given in millidegree Celsius and will be measurable
>> +only when the target CPU is powered on.
>> +
>> +Sysfs interface
>> +-------------------
>> +
>> +======================= =======================================================
>> +
>> +temp[N]_label		Provides string "DIMM CI", where C is DIMM channel and
>> +			I is DIMM index of the populated DIMM.
>> +temp[N]_input		Provides current temperature of the populated DIMM.
>> +temp[N]_max		Provides thermal control temperature of the DIMM.
>> +temp[N]_crit		Provides shutdown temperature of the DIMM.
>> +
>> +======================= =======================================================
>> +
>> +Note:
>> +	DIMM temperature attributes will appear when the client CPU's BIOS
>> +	completes memory training and testing.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 35ba9e3646bd..d16da127bbdc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14509,6 +14509,8 @@ M:	Iwona Winiarska <iwona.winiarska@intel.com>
>> R:	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> L:	linux-hwmon at vger.kernel.org
>> S:	Supported
>> +F:	Documentation/hwmon/peci-cputemp.rst
>> +F:	Documentation/hwmon/peci-dimmtemp.rst
>> F:	drivers/hwmon/peci/
>>
>> PECI SUBSYSTEM
>> -- 
>> 2.31.1
>>
> 

