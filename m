From: Troy Lee <troy_lee@aspeedtech.com>
Date: Mon, 18 Jan 2021 06:50:50 +0000
Subject: [PATCH v3 2/4] hwmon: Add Aspeed AST2600 support
In-Reply-To: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
References: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
Message-ID: <20210118065059.2478078-3-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updating index.rst and adding aspeed2600-pwm-tachometer.rst to address
the driver.

Changes since v1:
 - rename to aspeed2600-pwm-tachometer.rst
 - add license identifier

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 .../hwmon/aspeed2600-pwm-tachometer.rst       | 27 +++++++++++++++++++
 Documentation/hwmon/index.rst                 |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/hwmon/aspeed2600-pwm-tachometer.rst

diff --git a/Documentation/hwmon/aspeed2600-pwm-tachometer.rst b/Documentation/hwmon/aspeed2600-pwm-tachometer.rst
new file mode 100644
index 000000000000..cf0d31a19597
--- /dev/null
+++ b/Documentation/hwmon/aspeed2600-pwm-tachometer.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+Kernel driver aspeed2600-pwm-tachometer
+===================================
+
+Supported chips:
+	ASPEED AST2600
+
+Authors:
+	Ryan Chen <ryan_chen@aspeedtech.com>
+
+Description:
+------------
+This driver implements support for ASPEED AST2600 PWM and Fan Tacho
+controller. The PWM controller supports upto 16 PWM outputs. The Fan tacho
+controller supports up to 16 tachometer inputs.
+
+The driver provides the following sensor accesses in sysfs:
+
+=============== ======= =====================================================
+fanX_input	ro	provide current fan rotation value in RPM as reported
+			by the fan to the device.
+
+pwmX		rw	get or set PWM fan control value. This is an integer
+			value between 0(off) and 255(full speed).
+=============== ======= =====================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fcb870ce6286..02020c282549 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -44,6 +44,7 @@ Hardware Monitoring Kernel Drivers
    asb100
    asc7621
    aspeed-pwm-tacho
+   aspeed2600-pwm-tachometer
    bcm54140
    bel-pfe
    bt1-pvt
-- 
2.25.1

