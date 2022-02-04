From: Joel Stanley <joel@jms.id.au>
Date: Fri,  4 Feb 2022 17:52:32 +1030
Subject: [PATCH v3 1/3] firmware: Add boot information to sysfs
In-Reply-To: <20220204072234.304543-1-joel@jms.id.au>
References: <20220204072234.304543-1-joel@jms.id.au>
Message-ID: <20220204072234.304543-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Machines often have firmware that perform some action before Linux is
loaded. It's useful to know how this firmware is configured, so create a
sysfs directory and some properties that a system can choose to expose
to describe how the system was started.

Currently the intended use describes four files, relating to hardware
root of trust configuration.

These properties are populated by platform code at startup. Using fixed
values is suitable as the state that the system booted in will not
change after firmware has handed over.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Rewrite so properties are present in common code and are exposed based
   on the is_visible callback.
 - Use sysfs_emit
v3:
 - drop uart_boot
 - Add kerneldoc to header
 - Rename en -> present
 - Rename val -> value
 - Drop unncessary __init from header
 - Wrap macro in do { } while(0)
---
 .../ABI/testing/sysfs-firmware-bootinfo       | 37 +++++++++
 drivers/base/firmware.c                       | 80 +++++++++++++++++++
 include/linux/firmware_bootinfo.h             | 48 +++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
new file mode 100644
index 000000000000..cd8eeaa49a00
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
@@ -0,0 +1,37 @@
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
diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
index 8dff940e0db9..8d1a7a36784c 100644
--- a/drivers/base/firmware.c
+++ b/drivers/base/firmware.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/firmware_bootinfo.h>
 
 #include "base.h"
 
@@ -24,3 +25,82 @@ int __init firmware_init(void)
 		return -ENOMEM;
 	return 0;
 }
+
+/*
+ * Exposes attributes documented in Documentation/ABI/testing/sysfs-firmware-bootinfo
+ */
+static struct bootinfo bootinfo;
+
+static ssize_t abr_image_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.abr_image.value);
+}
+static DEVICE_ATTR_RO(abr_image);
+
+static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.low_security_key.value);
+}
+static DEVICE_ATTR_RO(low_security_key);
+
+static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.otp_protected.value);
+}
+static DEVICE_ATTR_RO(otp_protected);
+
+static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", bootinfo.secure_boot.value);
+}
+static DEVICE_ATTR_RO(secure_boot);
+
+#define ATTR_ENABLED(a) ((attr == &dev_attr_##a.attr) && bootinfo.a.present)
+
+static umode_t bootinfo_attr_mode(struct kobject *kobj, struct attribute *attr, int index)
+{
+	if (ATTR_ENABLED(abr_image))
+		return 0444;
+
+	if (ATTR_ENABLED(otp_protected))
+		return 0444;
+
+	if (ATTR_ENABLED(low_security_key))
+		return 0444;
+
+	if (ATTR_ENABLED(otp_protected))
+		return 0444;
+
+	if (ATTR_ENABLED(low_security_key))
+		return 0444;
+
+	if (ATTR_ENABLED(secure_boot))
+		return 0444;
+
+	return 0;
+}
+
+static struct attribute *bootinfo_attrs[] = {
+	&dev_attr_abr_image.attr,
+	&dev_attr_low_security_key.attr,
+	&dev_attr_otp_protected.attr,
+	&dev_attr_secure_boot.attr,
+	NULL,
+};
+
+static const struct attribute_group bootinfo_attr_group = {
+	.attrs = bootinfo_attrs,
+	.is_visible = bootinfo_attr_mode,
+};
+
+int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init)
+{
+	struct kobject *kobj = kobject_create_and_add("bootinfo", firmware_kobj);
+	if (!kobj)
+		return -ENOMEM;
+
+	memcpy(&bootinfo, bootinfo_init, sizeof(bootinfo));
+
+	return sysfs_create_group(kobj, &bootinfo_attr_group);
+}
+EXPORT_SYMBOL_GPL(firmware_bootinfo_init);
diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
new file mode 100644
index 000000000000..237da83b673c
--- /dev/null
+++ b/include/linux/firmware_bootinfo.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2022 IBM Corp. */
+
+#include <linux/sysfs.h>
+#include <linux/init.h>
+
+#define BOOTINFO_SET(b, n, v) do {b.n.present = true; b.n.value = v; } while (0)
+
+/**
+ * struct bootinfo_entry - A bootinfo sysfs entry
+ * @present: true if the file should be present (visible) in sysfs
+ * @value: value of the entry, will be printed as 1 or 0
+ *
+ * Contains the state of a given bootinfo sysfs file, to be filled out by the
+ * platform that wishes it to be present.
+ *
+ * It is used by sysfs. The is_present callback tests .present indicate the
+ * attribute should be shown, and by the show callback tests .value to display
+ * the value.
+ */
+struct bootinfo_entry {
+	bool present;
+	bool value;
+};
+
+/**
+ * struct bootinfo: A collection of bootinfo entries
+ * @abr_image: sysfs property
+ * @low_security_key: sysfs property
+ * @otp_protected: sysfs property
+ * @secure_boot: sysfs property
+ *
+ * The documented set of bootinfo entries to be displayed in
+ * /sys/firmware/bootinfo. Platform code populates a struct bootinfo and
+ * passes it to firmware_bootinfo_init, which takes a copy to be used at
+ * runtime.
+ *
+ * See struct bootinfo_entry for a description of the information each entry
+ * contiains.
+ */
+struct bootinfo {
+	struct bootinfo_entry abr_image;
+	struct bootinfo_entry low_security_key;
+	struct bootinfo_entry otp_protected;
+	struct bootinfo_entry secure_boot;
+};
+
+int firmware_bootinfo_init(struct bootinfo *bootinfo_init);
-- 
2.34.1

