From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Apr 2021 15:36:48 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_11/21]_ipmi:_kcs=5Fbmc:_Split_headers_into_devic?=
 =?UTF-8?Q?e_and_client?=
In-Reply-To: <YG/RkB07Wh69/xdu@packtop>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-11-andrew@aj.id.au> <YG/RkB07Wh69/xdu@packtop>
Message-ID: <e5c84ec2-5fe7-4f29-866a-331f652edd79@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 9 Apr 2021, at 13:31, Zev Weiss wrote:
> On Fri, Mar 19, 2021 at 01:27:42AM CDT, Andrew Jeffery wrote:
> >Strengthen the distinction between code that abstracts the
> >implementation of the KCS behaviours (device drivers) and code that
> >exploits KCS behaviours (clients). Neither needs to know about the APIs
> >required by the other, so provide separate headers.
> >
> >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >---
> > drivers/char/ipmi/kcs_bmc.c           | 21 ++++++++++-----
> > drivers/char/ipmi/kcs_bmc.h           | 30 ++++++++++-----------
> > drivers/char/ipmi/kcs_bmc_aspeed.c    | 20 +++++++++-----
> > drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 39 ++++++++++++++++++---------
> > drivers/char/ipmi/kcs_bmc_client.h    | 29 ++++++++++++++++++++
> > drivers/char/ipmi/kcs_bmc_device.h    | 19 +++++++++++++
> > drivers/char/ipmi/kcs_bmc_npcm7xx.c   | 20 +++++++++-----
> > 7 files changed, 129 insertions(+), 49 deletions(-)
> > create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
> > create mode 100644 drivers/char/ipmi/kcs_bmc_device.h
> >
> >diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> >index 709b6bdec165..1046ce2bbefc 100644
> >--- a/drivers/char/ipmi/kcs_bmc.c
> >+++ b/drivers/char/ipmi/kcs_bmc.c
> >@@ -1,46 +1,52 @@
> > // SPDX-License-Identifier: GPL-2.0
> > /*
> >  * Copyright (c) 2015-2018, Intel Corporation.
> >+ * Copyright (c) 2021, IBM Corp.
> >  */
> >
> > #include <linux/module.h>
> >
> > #include "kcs_bmc.h"
> >
> >+/* Implement both the device and client interfaces here */
> >+#include "kcs_bmc_device.h"
> >+#include "kcs_bmc_client.h"
> >+
> >+/* Consumer data access */
> >+
> > u8 kcs_bmc_read_data(struct kcs_bmc *kcs_bmc)
> > {
> >-	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
> >+	return kcs_bmc->ops->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
> > }
> > EXPORT_SYMBOL(kcs_bmc_read_data);
> >
> > void kcs_bmc_write_data(struct kcs_bmc *kcs_bmc, u8 data)
> > {
> >-	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.odr, data);
> >+	kcs_bmc->ops->io_outputb(kcs_bmc, kcs_bmc->ioreg.odr, data);
> > }
> > EXPORT_SYMBOL(kcs_bmc_write_data);
> >
> > u8 kcs_bmc_read_status(struct kcs_bmc *kcs_bmc)
> > {
> >-	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.str);
> >+	return kcs_bmc->ops->io_inputb(kcs_bmc, kcs_bmc->ioreg.str);
> > }
> > EXPORT_SYMBOL(kcs_bmc_read_status);
> >
> > void kcs_bmc_write_status(struct kcs_bmc *kcs_bmc, u8 data)
> > {
> >-	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.str, data);
> >+	kcs_bmc->ops->io_outputb(kcs_bmc, kcs_bmc->ioreg.str, data);
> > }
> > EXPORT_SYMBOL(kcs_bmc_write_status);
> >
> > void kcs_bmc_update_status(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
> > {
> >-	kcs_bmc->io_updateb(kcs_bmc, kcs_bmc->ioreg.str, mask, val);
> >+	kcs_bmc->ops->io_updateb(kcs_bmc, kcs_bmc->ioreg.str, mask, val);
> > }
> > EXPORT_SYMBOL(kcs_bmc_update_status);
> >
> >-int kcs_bmc_ipmi_event(struct kcs_bmc *kcs_bmc);
> > int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
> > {
> >-	return kcs_bmc_ipmi_event(kcs_bmc);
> >+	return kcs_bmc->client.ops->event(&kcs_bmc->client);
> > }
> > EXPORT_SYMBOL(kcs_bmc_handle_event);
> >
> >@@ -60,4 +66,5 @@ EXPORT_SYMBOL(kcs_bmc_remove_device);
> >
> > MODULE_LICENSE("GPL v2");
> > MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
> >+MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> > MODULE_DESCRIPTION("KCS BMC to handle the IPMI request from system software");
> >diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
> >index bf0ae327997f..a1350e567723 100644
> >--- a/drivers/char/ipmi/kcs_bmc.h
> >+++ b/drivers/char/ipmi/kcs_bmc.h
> >@@ -8,6 +8,15 @@
> >
> > #include <linux/miscdevice.h>
> >
> >+#include "kcs_bmc_client.h"
> >+
> >+#define KCS_BMC_EVENT_NONE	0
> >+#define KCS_BMC_EVENT_HANDLED	1
> 
> Is there a particular reason we're introducing these macros and using an
> int return type for kcs_bmc_client_ops.event instead of just having it
> be irqreturn_t?  Other event types or outcomes we're anticipating needing
> to handle maybe?

In earlier iterations of the patches I was doing some extra work in the 
event handling path and felt it was useful at the time. However I've 
refactored things a little and this may have outlived its usefulness.

I'll reasses!

> 
> >+
> >+#define KCS_BMC_STR_OBF		BIT(0)
> >+#define KCS_BMC_STR_IBF		BIT(1)
> >+#define KCS_BMC_STR_CMD_DAT	BIT(3)
> 
> The first two of these macros are used later in the series, but the third
> doesn't end up used at all I think?

I think I just added it as documentation as the hardware-defined bits 
aren't contiguous.

Andrew
