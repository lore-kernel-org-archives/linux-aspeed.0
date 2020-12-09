From: Troy Lee <troy_lee@aspeedtech.com>
Date: Wed, 9 Dec 2020 15:59:19 +0800
Subject: [PATCH 3/4] hwmon: Add Aspeed AST2600 support
In-Reply-To: <20201209075921.26689-1-troy_lee@aspeedtech.com>
References: <20201209075921.26689-1-troy_lee@aspeedtech.com>
Message-ID: <20201209075921.26689-4-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updating index.rst and adding aspeed_pwm_tachometer.rst to address the
driver.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 Documentation/hwmon/aspeed_pwm_tachometer.rst | 24 +++++++++++++++++++
 Documentation/hwmon/index.rst                 |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/hwmon/aspeed_pwm_tachometer.rst

diff --git a/Documentation/hwmon/aspeed_pwm_tachometer.rst b/Documentation/hwmon/aspeed_pwm_tachometer.rst
new file mode 100644
index 000000000000..301448002e6e
--- /dev/null
+++ b/Documentation/hwmon/aspeed_pwm_tachometer.rst
@@ -0,0 +1,24 @@
+Kernel driver aspeed_pwm_tachometer
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
index 89e1a824021f..26d277c1d211 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -43,6 +43,7 @@ Hardware Monitoring Kernel Drivers
    asb100
    asc7621
    aspeed-pwm-tacho
+   aspeed_pwm_tachometer
    bcm54140
    bel-pfe
    bt1-pvt
-- 
2.17.1

