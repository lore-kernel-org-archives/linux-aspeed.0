From: Iwona Winiarska <iwona.winiarska@intel.com>
Date: Tue,  8 Feb 2022 16:36:38 +0100
Subject: [PATCH v8 12/13] docs: hwmon: Document PECI drivers
In-Reply-To: <20220208153639.255278-1-iwona.winiarska@intel.com>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
Message-ID: <20220208153639.255278-13-iwona.winiarska@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Add documentation for peci-cputemp driver that provides DTS thermal
readings for CPU packages and CPU cores, and peci-dimmtemp driver that
provides Temperature Sensor on DIMM readings.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/index.rst         |  2 +
 Documentation/hwmon/peci-cputemp.rst  | 90 +++++++++++++++++++++++++++
 Documentation/hwmon/peci-dimmtemp.rst | 57 +++++++++++++++++
 MAINTAINERS                           |  2 +
 4 files changed, 151 insertions(+)
 create mode 100644 Documentation/hwmon/peci-cputemp.rst
 create mode 100644 Documentation/hwmon/peci-dimmtemp.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index df20022c741f..f387f661e1d7 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -161,6 +161,8 @@ Hardware Monitoring Kernel Drivers
    pcf8591
    pim4328
    pm6764tr
+   peci-cputemp
+   peci-dimmtemp
    pmbus
    powr1220
    pxe1610
diff --git a/Documentation/hwmon/peci-cputemp.rst b/Documentation/hwmon/peci-cputemp.rst
new file mode 100644
index 000000000000..fe0422248dc5
--- /dev/null
+++ b/Documentation/hwmon/peci-cputemp.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver peci-cputemp
+==========================
+
+Supported chips:
+	One of Intel server CPUs listed below which is connected to a PECI bus.
+		* Intel Xeon E5/E7 v3 server processors
+			Intel Xeon E5-14xx v3 family
+			Intel Xeon E5-24xx v3 family
+			Intel Xeon E5-16xx v3 family
+			Intel Xeon E5-26xx v3 family
+			Intel Xeon E5-46xx v3 family
+			Intel Xeon E7-48xx v3 family
+			Intel Xeon E7-88xx v3 family
+		* Intel Xeon E5/E7 v4 server processors
+			Intel Xeon E5-16xx v4 family
+			Intel Xeon E5-26xx v4 family
+			Intel Xeon E5-46xx v4 family
+			Intel Xeon E7-48xx v4 family
+			Intel Xeon E7-88xx v4 family
+		* Intel Xeon Scalable server processors
+			Intel Xeon D family
+			Intel Xeon Bronze family
+			Intel Xeon Silver family
+			Intel Xeon Gold family
+			Intel Xeon Platinum family
+
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides Digital
+Thermal Sensor (DTS) thermal readings of the CPU package and CPU cores that are
+accessible via the processor PECI interface.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+Sysfs interface
+-------------------
+
+======================= =======================================================
+temp1_label		"Die"
+temp1_input		Provides current die temperature of the CPU package.
+temp1_max		Provides thermal control temperature of the CPU package
+			which is also known as Tcontrol.
+temp1_crit		Provides shutdown temperature of the CPU package which
+			is also known as the maximum processor junction
+			temperature, Tjmax or Tprochot.
+temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
+			the CPU package.
+
+temp2_label		"DTS"
+temp2_input		Provides current temperature of the CPU package scaled
+			to match DTS thermal profile.
+temp2_max		Provides thermal control temperature of the CPU package
+			which is also known as Tcontrol.
+temp2_crit		Provides shutdown temperature of the CPU package which
+			is also known as the maximum processor junction
+			temperature, Tjmax or Tprochot.
+temp2_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
+			the CPU package.
+
+temp3_label		"Tcontrol"
+temp3_input		Provides current Tcontrol temperature of the CPU
+			package which is also known as Fan Temperature target.
+			Indicates the relative value from thermal monitor trip
+			temperature at which fans should be engaged.
+temp3_crit		Provides Tcontrol critical value of the CPU package
+			which is same to Tjmax.
+
+temp4_label		"Tthrottle"
+temp4_input		Provides current Tthrottle temperature of the CPU
+			package. Used for throttling temperature. If this value
+			is allowed and lower than Tjmax - the throttle will
+			occur and reported at lower than Tjmax.
+
+temp5_label		"Tjmax"
+temp5_input		Provides the maximum junction temperature, Tjmax of the
+			CPU package.
+
+temp[6-N]_label		Provides string "Core X", where X is resolved core
+			number.
+temp[6-N]_input		Provides current temperature of each core.
+
+======================= =======================================================
diff --git a/Documentation/hwmon/peci-dimmtemp.rst b/Documentation/hwmon/peci-dimmtemp.rst
new file mode 100644
index 000000000000..e562aed620de
--- /dev/null
+++ b/Documentation/hwmon/peci-dimmtemp.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver peci-dimmtemp
+===========================
+
+Supported chips:
+	One of Intel server CPUs listed below which is connected to a PECI bus.
+		* Intel Xeon E5/E7 v3 server processors
+			Intel Xeon E5-14xx v3 family
+			Intel Xeon E5-24xx v3 family
+			Intel Xeon E5-16xx v3 family
+			Intel Xeon E5-26xx v3 family
+			Intel Xeon E5-46xx v3 family
+			Intel Xeon E7-48xx v3 family
+			Intel Xeon E7-88xx v3 family
+		* Intel Xeon E5/E7 v4 server processors
+			Intel Xeon E5-16xx v4 family
+			Intel Xeon E5-26xx v4 family
+			Intel Xeon E5-46xx v4 family
+			Intel Xeon E7-48xx v4 family
+			Intel Xeon E7-88xx v4 family
+		* Intel Xeon Scalable server processors
+			Intel Xeon D family
+			Intel Xeon Bronze family
+			Intel Xeon Silver family
+			Intel Xeon Gold family
+			Intel Xeon Platinum family
+
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides
+Temperature sensor on DIMM readings that are accessible via the processor PECI interface.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+Sysfs interface
+-------------------
+
+======================= =======================================================
+
+temp[N]_label		Provides string "DIMM CI", where C is DIMM channel and
+			I is DIMM index of the populated DIMM.
+temp[N]_input		Provides current temperature of the populated DIMM.
+temp[N]_max		Provides thermal control temperature of the DIMM.
+temp[N]_crit		Provides shutdown temperature of the DIMM.
+
+======================= =======================================================
+
+Note:
+	DIMM temperature attributes will appear when the client CPU's BIOS
+	completes memory training and testing.
diff --git a/MAINTAINERS b/MAINTAINERS
index b2d0b0b58da9..c666ef7ea5a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15113,6 +15113,8 @@ PECI HARDWARE MONITORING DRIVERS
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-hwmon at vger.kernel.org
 S:	Supported
+F:	Documentation/hwmon/peci-cputemp.rst
+F:	Documentation/hwmon/peci-dimmtemp.rst
 F:	drivers/hwmon/peci/
 
 PECI SUBSYSTEM
-- 
2.34.1

