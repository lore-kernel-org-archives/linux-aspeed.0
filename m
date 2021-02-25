From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 25 Feb 2021 17:18:54 +0700
Subject: [PATCH 4/4] docs: hwmon: (smpro-hwmon) Add documentation
In-Reply-To: <20210225101854.13896-1-quan@os.amperecomputing.com>
References: <20210225101854.13896-1-quan@os.amperecomputing.com>
Message-ID: <20210225101854.13896-5-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add documentation for the Ampere(R)'s Altra(R) SMpro hwmon driver.

Signed-off-by: Thu Nguyen <thu@os.amperecomputing.com>
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/smpro-hwmon.rst | 100 ++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/hwmon/smpro-hwmon.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 8d5a2df1ecb6..b48a980ed08b 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -164,6 +164,7 @@ Hardware Monitoring Kernel Drivers
    sis5595
    sl28cpld
    smm665
+   smpro-hwmon
    smsc47b397
    smsc47m192
    smsc47m1
diff --git a/Documentation/hwmon/smpro-hwmon.rst b/Documentation/hwmon/smpro-hwmon.rst
new file mode 100644
index 000000000000..d546b90982e5
--- /dev/null
+++ b/Documentation/hwmon/smpro-hwmon.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver Ampere(R)'s Altra(R) SMpro hwmon
+==============================================
+
+Supported chips:
+
+  * Ampere(R) Altra(R)
+
+    Prefix: 'smpro'
+
+    Reference: Altra SoC BMC Interface Specification
+
+Author: Thu Nguyen <thu@os.amperecomputing.com>
+
+Description
+-----------
+This driver supports hardware monitoring for Ampere(R) Altra(R) SoC's based on the
+SMpro co-processor (SMpro).
+The following sensor types are supported by the driver:
+
+  * temperature
+  * voltage
+  * current
+  * power
+
+The SMpro interface provides the registers to query the various sensors and
+their values which are then exported to userspace by this driver.
+
+Usage Notes
+-----------
+
+SMpro hwmon driver creates two sysfs files for each sensor.
+
+* File ``<sensor_type><idx>_label`` reports the sensor label.
+* File ``<sensor_type><idx>_input`` returns the sensor value.
+
+The sysfs files are allocated in the SMpro root fs folder.
+There is one root folder for each SMpro instance.
+
+When the SoC is turned off, the driver is failed to read the registers.
+It returns TIMEDOUT Error(-110) for the read sensors.
+
+Sysfs entries
+-------------
+
+The following sysfs files are supported:
+
+* Ampere(R) Altra(R):
+
+===============    =============   ======= ===============================================
+Name        Unit        Perm    Description
+temp1_input     mili Celsius     RO    SoC temperature
+temp2_input     mili Celsius     RO    Highest temperature reported by the SoC VRDs
+temp3_input     mili Celsius     RO    Highest temperature reported by the DIMM VRDs
+temp4_input     mili Celsius     RO    Highest temperature reported by the Core VRDs
+temp5_input     mili Celsius     RO    Highest temperature of DIMM Channel 0 to 3
+temp6_input     mili Celsius     RO    Temperature of DIMM0 on CH0
+temp7_input     mili Celsius     RO    Temperature of DIMM0 on CH1
+temp8_input     mili Celsius     RO    Temperature of DIMM0 on CH2
+temp9_input     mili Celsius     RO    Temperature of DIMM0 on CH3
+temp10_input     mili Celsius     RO    Highest temperature of DIMM Channel 4 to 7
+temp11_input     mili Celsius     RO    Temperature of DIMM0 on CH4
+temp12_input     mili Celsius     RO    Temperature of DIMM0 on CH5
+temp13_input     mili Celsius     RO    Temperature of DIMM0 on CH6
+temp14_input     mili Celsius     RO    Temperature of DIMM0 on CH7
+temp15_input     mili Celsius     RO    MEM HOT Threshold
+temp16_input     mili Celsius     RO    SoC VRD HOT Threshold
+temp17_input     mili Celsius     RO    Highest temperature reported by the RCA VRD
+in0_input     mili Volt     RO    Core voltage
+in1_input     mili Volt     RO    SoC voltage
+in2_input     mili Volt     RO    DIMM VRD1 voltage
+in3_input     mili Volt     RO    DIMM VRD2 voltage
+in4_input     mili Volt     RO    Maximum voltage of DIMM VRD1 and VRD2
+in5_input     mili Volt     RO    RCA VRD voltage
+cur1_input     mili Ampere     RO    Core VRD current
+cur2_input     mili Ampere     RO    SoC VRD current
+cur3_input     mili Ampere     RO    DIMM VRD1 current
+cur4_input     mili Ampere     RO    DIMM VRD2 current
+cur5_input     mili Ampere     RO    RCA VRD current
+power1_input     nano Wat     RO    Core VRD power
+power2_input     nano Wat     RO    SoC VRD power
+power3_input     nano Wat     RO    DIMM VRD1 power
+power4_input     nano Wat     RO    DIMM VRD2 power
+power5_input     nano Wat     RO    CPU VRD power, total of SoC and Core VRD power
+power6_input     nano Wat     RO    Total of DIMM VRD1 and VRD2 power
+power7_input     nano Wat     RO    RCA VRD power
+power8_input     nano Wat     RO    Socket TDP
+===============    =============   ======= ===============================================
+
+Example::
+
+    # cat in0_input
+    830
+    # cat temp1_input
+    37000
+    # cat curr1_input
+    9000
+    # cat power5_input
+    19500000
-- 
2.28.0

