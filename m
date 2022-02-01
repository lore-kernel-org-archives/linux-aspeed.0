From: Joel Stanley <joel@jms.id.au>
Date: Tue,  1 Feb 2022 15:35:00 +1030
Subject: [PATCH 1/2] firmware: Add boot information sysfs
In-Reply-To: <20220201050501.182961-1-joel@jms.id.au>
References: <20220201050501.182961-1-joel@jms.id.au>
Message-ID: <20220201050501.182961-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Machines often have firmware that perform some action before Linux is
loaded. It's useful to know how this firmware is configured, so create a
sysfs directory and some example properties that a system can choose to
expose to describe how the system was started.

Currently the intended use describes five files, relating to hardware
root of trust configuration.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../ABI/testing/sysfs-firmware-bootinfo       | 43 +++++++++++++++++++
 drivers/base/firmware.c                       | 14 ++++++
 include/linux/firmware_bootinfo.h             |  8 ++++
 3 files changed, 65 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
new file mode 100644
index 000000000000..cd6c42316345
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
@@ -0,0 +1,43 @@
+What:		/sys/firmware/bootinfo/*
+Date:		Jan 2022
+Description:
+		A system can expose information about how it was started in
+		this directory.
+
+		This information is agnostic as to the firmware implementation.
+
+		A system may expose a subset of these properties as applicable.
+
+
+What:		/sys/firmware/bootinfo/secure_boot
+Date:		Jan 2022
+Description:
+		Indicates the system was started with secure boot enabled in
+		the firmware.
+
+
+What:		/sys/firmware/bootinfo/abr_image
+Date:		Jan 2022
+Description:
+		Indicates the system was started from the alternate image
+		loaded from an Alternate Boot Region. Often this is a result of
+		the primary firmware image failing to start the system.
+
+
+What:		/sys/firmware/bootinfo/low_security_key
+Date:		Jan 2022
+Description:
+		Indicates the system's secure boot was verified with a low
+		security or development key.
+
+What:		/sys/firmware/bootinfo/otp_protected
+Date:		Jan 2022
+Description:
+		Indicates the system's boot configuration region is write
+		protected and cannot be modified.
+
+What:		/sys/firmware/bootinfo/uart_boot
+Date:		Jan 2022
+Description:
+		Indicates the system firmware was loaded from a UART instead of
+		an internal boot device.
diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
index 8dff940e0db9..2a6478aa178d 100644
--- a/drivers/base/firmware.c
+++ b/drivers/base/firmware.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/firmware_bootinfo.h>
 
 #include "base.h"
 
@@ -24,3 +25,16 @@ int __init firmware_init(void)
 		return -ENOMEM;
 	return 0;
 }
+
+/*
+ * Exposes attributes documented in Documentation/ABI/testing/sysfs-firmware-bootinfo
+ */
+int __init firmware_bootinfo_init(const struct attribute_group *attr_group)
+{
+	struct kobject *kobj= kobject_create_and_add("bootinfo", firmware_kobj);
+	if (!kobj)
+		return -ENOMEM;
+
+	return sysfs_create_group(kobj, attr_group);
+}
+EXPORT_SYMBOL_GPL(firmware_bootinfo_init);
diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
new file mode 100644
index 000000000000..581b68508ec8
--- /dev/null
+++ b/include/linux/firmware_bootinfo.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 IBM Corp
+
+#include <linux/sysfs.h>
+#include <linux/init.h>
+
+int __init firmware_bootinfo_init(const struct attribute_group *attr_group);
+
-- 
2.34.1

