From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Apr 2021 15:54:33 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_13/21]_ipmi:_kcs=5Fbmc:_Decouple_the_IPMI_charde?=
 =?UTF-8?Q?v_from_the_core?=
In-Reply-To: <YG/ZkanVAypmjCba@packtop>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-13-andrew@aj.id.au> <YG/ZkanVAypmjCba@packtop>
Message-ID: <386cc03a-f6d0-45b6-a27b-fc204dedbcac@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 9 Apr 2021, at 14:05, Zev Weiss wrote:
> On Fri, Mar 19, 2021 at 01:27:44AM CDT, Andrew Jeffery wrote:
> >Now that we have untangled the data-structures, split the userspace
> >interface out into its own module. Userspace interfaces and drivers are
> >registered to the KCS BMC core to support arbitrary binding of either.
> >
> >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >---
> > drivers/char/ipmi/Kconfig             | 13 +++++
> > drivers/char/ipmi/Makefile            |  3 +-
> > drivers/char/ipmi/kcs_bmc.c           | 78 ++++++++++++++++++++++++++-
> > drivers/char/ipmi/kcs_bmc.h           |  4 --
> > drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 33 +++++++++---
> > drivers/char/ipmi/kcs_bmc_client.h    | 14 +++++
> > 6 files changed, 132 insertions(+), 13 deletions(-)
> >
> >diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> >index 07847d9a459a..bc5f81899b62 100644
> >--- a/drivers/char/ipmi/Kconfig
> >+++ b/drivers/char/ipmi/Kconfig
> >@@ -124,6 +124,19 @@ config NPCM7XX_KCS_IPMI_BMC
> > 	  This support is also available as a module.  If so, the module
> > 	  will be called kcs_bmc_npcm7xx.
> >
> >+config IPMI_KCS_BMC_CDEV_IPMI
> >+	depends on IPMI_KCS_BMC
> >+	tristate "IPMI character device interface for BMC KCS devices"
> >+	help
> >+	  Provides a BMC-side character device implementing IPMI
> >+	  semantics for KCS IPMI devices.
> >+
> >+	  Say YES if you wish to expose KCS devices on the BMC for IPMI
> >+	  purposes.
> >+
> >+	  This support is also available as a module. The module will be
> >+	  called kcs_bmc_cdev_ipmi.
> >+
> > config ASPEED_BT_IPMI_BMC
> > 	depends on ARCH_ASPEED || COMPILE_TEST
> > 	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
> >diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
> >index a302bc865370..fcfa676afddb 100644
> >--- a/drivers/char/ipmi/Makefile
> >+++ b/drivers/char/ipmi/Makefile
> >@@ -22,7 +22,8 @@ obj-$(CONFIG_IPMI_SSIF) += ipmi_ssif.o
> > obj-$(CONFIG_IPMI_POWERNV) += ipmi_powernv.o
> > obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
> > obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
> >-obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o kcs_bmc_cdev_ipmi.o
> >+obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o
> >+obj-$(CONFIG_IPMI_KCS_BMC_CDEV_IPMI) += kcs_bmc_cdev_ipmi.o
> > obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
> > obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
> > obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) += kcs_bmc_npcm7xx.o
> >diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> >index 266ebec71d6f..694db6ee2a92 100644
> >--- a/drivers/char/ipmi/kcs_bmc.c
> >+++ b/drivers/char/ipmi/kcs_bmc.c
> >@@ -5,7 +5,9 @@
> >  */
> >
> > #include <linux/device.h>
> >+#include <linux/list.h>
> > #include <linux/module.h>
> >+#include <linux/mutex.h>
> >
> > #include "kcs_bmc.h"
> >
> >@@ -13,6 +15,11 @@
> > #include "kcs_bmc_device.h"
> > #include "kcs_bmc_client.h"
> >
> >+/* Record probed devices and cdevs */
> >+static DEFINE_MUTEX(kcs_bmc_lock);
> >+static LIST_HEAD(kcs_bmc_devices);
> >+static LIST_HEAD(kcs_bmc_cdevs);
> >+
> > /* Consumer data access */
> >
> > u8 kcs_bmc_read_data(struct kcs_bmc_device *kcs_bmc)
> >@@ -100,16 +107,83 @@ EXPORT_SYMBOL(kcs_bmc_disable_device);
> >
> > int kcs_bmc_add_device(struct kcs_bmc_device *kcs_bmc)
> > {
> >-	return kcs_bmc_ipmi_attach_cdev(kcs_bmc);
> >+	struct kcs_bmc_cdev *cdev;
> >+	int rc;
> >+
> >+	spin_lock_init(&kcs_bmc->lock);
> >+	kcs_bmc->client = NULL;
> >+
> >+	mutex_lock(&kcs_bmc_lock);
> >+	list_add(&kcs_bmc->entry, &kcs_bmc_devices);
> >+	list_for_each_entry(cdev, &kcs_bmc_cdevs, entry) {
> >+		rc = cdev->ops->add_device(kcs_bmc);
> >+		if (rc)
> >+			dev_err(kcs_bmc->dev, "Failed to add chardev for KCS channel %d: %d",
> >+				kcs_bmc->channel, rc);
> >+	}
> >+	mutex_unlock(&kcs_bmc_lock);
> >+
> >+	return 0;
> 
> We're ignoring failed ->add_device() calls here?

Yep. If one chardev module is failing to accept new devices we don't 
want to not add them to the remaining chardev modules.

What would the caller do with a error return value? Maybe it should 
just be void.

> 
> > }
> > EXPORT_SYMBOL(kcs_bmc_add_device);
> >
> > int kcs_bmc_remove_device(struct kcs_bmc_device *kcs_bmc)
> > {
> >-	return kcs_bmc_ipmi_detach_cdev(kcs_bmc);
> >+	struct kcs_bmc_cdev *cdev;
> >+	int rc;
> >+
> >+	mutex_lock(&kcs_bmc_lock);
> >+	list_del(&kcs_bmc->entry);
> >+	list_for_each_entry(cdev, &kcs_bmc_cdevs, entry) {
> >+		rc = cdev->ops->remove_device(kcs_bmc);
> >+		if (rc)
> >+			dev_err(kcs_bmc->dev, "Failed to remove chardev for KCS channel %d: %d",
> >+				kcs_bmc->channel, rc);
> >+	}
> >+	mutex_unlock(&kcs_bmc_lock);
> >+
> >+	return 0;
> 
> Similarly with the return value here...

As above.

> 
> > }
> > EXPORT_SYMBOL(kcs_bmc_remove_device);
> >
> >+int kcs_bmc_register_cdev(struct kcs_bmc_cdev *cdev)
> >+{
> >+	struct kcs_bmc_device *kcs_bmc;
> >+	int rc;
> >+
> >+	mutex_lock(&kcs_bmc_lock);
> >+	list_add(&cdev->entry, &kcs_bmc_cdevs);
> >+	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
> >+		rc = cdev->ops->add_device(kcs_bmc);
> >+		if (rc)
> >+			dev_err(kcs_bmc->dev, "Failed to add chardev for KCS channel %d: %d",
> >+				kcs_bmc->channel, rc);
> >+	}
> >+	mutex_unlock(&kcs_bmc_lock);
> >+
> >+	return 0;
> 
> ...return value again here...

As above.

> 
> >+}
> >+EXPORT_SYMBOL(kcs_bmc_register_cdev);
> >+
> >+int kcs_bmc_unregister_cdev(struct kcs_bmc_cdev *cdev)
> >+{
> >+	struct kcs_bmc_device *kcs_bmc;
> >+	int rc;
> >+
> >+	mutex_lock(&kcs_bmc_lock);
> >+	list_del(&cdev->entry);
> >+	list_for_each_entry(kcs_bmc, &kcs_bmc_devices, entry) {
> >+		rc = cdev->ops->remove_device(kcs_bmc);
> >+		if (rc)
> >+			dev_err(kcs_bmc->dev, "Failed to add chardev for KCS channel %d: %d",
> 
> s/add/remove/

Thanks.

> 
> Might also want to differentiate the *_device() error messages from the
> *_cdev() ones a bit more?

I'll look into it.

> 
> >+				kcs_bmc->channel, rc);
> >+	}
> >+	mutex_unlock(&kcs_bmc_lock);
> >+
> >+	return rc;
> 
> ...but this one is a bit incongruous, propagating the return value of
> only the last ->remove_device() call.

Hah. good catch.

Andrew
