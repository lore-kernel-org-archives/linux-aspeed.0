From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 9 Apr 2021 19:21:34 +0000
Subject: [PATCH v2 09/21] ipmi: kcs_bmc: Split out kcs_bmc_cdev_ipmi
In-Reply-To: <6aa7c000-da09-4058-96b4-f330193c7fc6@www.fastmail.com>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-9-andrew@aj.id.au> <YG/QUCIdEzW1ghVA@packtop>
 <6aa7c000-da09-4058-96b4-f330193c7fc6@www.fastmail.com>
Message-ID: <YHCpPa3EtVy9XcLn@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 09, 2021 at 12:48:21AM CDT, Andrew Jeffery wrote:
>
>
>On Fri, 9 Apr 2021, at 13:26, Zev Weiss wrote:
>> On Fri, Mar 19, 2021 at 01:27:40AM CDT, Andrew Jeffery wrote:
>> >Take steps towards defining a coherent API to separate the KCS device
>> >drivers from the userspace interface. Decreasing the coupling will
>> >improve the separation of concerns and enable the introduction of
>> >alternative userspace interfaces.
>> >
>> >For now, simply split the chardev logic out to a separate file. The code
>> >continues to build into the same module.
>> >
>> >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> >---
>> > drivers/char/ipmi/Makefile            |   2 +-
>> > drivers/char/ipmi/kcs_bmc.c           | 423 +------------------------
>> > drivers/char/ipmi/kcs_bmc.h           |  10 +-
>> > drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 428 ++++++++++++++++++++++++++
>> > 4 files changed, 451 insertions(+), 412 deletions(-)
>> > create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
>> >
>> >diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
>> >index 0822adc2ec41..a302bc865370 100644
>> >--- a/drivers/char/ipmi/Makefile
>> >+++ b/drivers/char/ipmi/Makefile
>> >@@ -22,7 +22,7 @@ obj-$(CONFIG_IPMI_SSIF) += ipmi_ssif.o
>> > obj-$(CONFIG_IPMI_POWERNV) += ipmi_powernv.o
>> > obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
>> > obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
>> >-obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o
>> >+obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o kcs_bmc_cdev_ipmi.o
>> > obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
>> > obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
>> > obj-$(CONFIG_NPCM7XX_KCS_IPMI_BMC) += kcs_bmc_npcm7xx.o
>> >diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>> >index c4336c1f2d6d..ef5c48ffe74a 100644
>> >--- a/drivers/char/ipmi/kcs_bmc.c
>> >+++ b/drivers/char/ipmi/kcs_bmc.c
>> >@@ -3,446 +3,51 @@
>> >  * Copyright (c) 2015-2018, Intel Corporation.
>> >  */
>> >
>> >-#define pr_fmt(fmt) "kcs-bmc: " fmt
>> >-
>> >-#include <linux/errno.h>
>> >-#include <linux/io.h>
>> >-#include <linux/ipmi_bmc.h>
>> > #include <linux/module.h>
>> >-#include <linux/platform_device.h>
>> >-#include <linux/poll.h>
>> >-#include <linux/sched.h>
>> >-#include <linux/slab.h>
>> >
>> > #include "kcs_bmc.h"
>> >
>> >-#define DEVICE_NAME "ipmi-kcs"
>> >-
>> >-#define KCS_MSG_BUFSIZ    1000
>> >-
>> >-#define KCS_ZERO_DATA     0
>> >-
>> >-
>> >-/* IPMI 2.0 - Table 9-1, KCS Interface Status Register Bits */
>> >-#define KCS_STATUS_STATE(state) (state << 6)
>> >-#define KCS_STATUS_STATE_MASK   GENMASK(7, 6)
>> >-#define KCS_STATUS_CMD_DAT      BIT(3)
>> >-#define KCS_STATUS_SMS_ATN      BIT(2)
>> >-#define KCS_STATUS_IBF          BIT(1)
>> >-#define KCS_STATUS_OBF          BIT(0)
>> >-
>> >-/* IPMI 2.0 - Table 9-2, KCS Interface State Bits */
>> >-enum kcs_states {
>> >-	IDLE_STATE  = 0,
>> >-	READ_STATE  = 1,
>> >-	WRITE_STATE = 2,
>> >-	ERROR_STATE = 3,
>> >-};
>> >-
>> >-/* IPMI 2.0 - Table 9-3, KCS Interface Control Codes */
>> >-#define KCS_CMD_GET_STATUS_ABORT  0x60
>> >-#define KCS_CMD_WRITE_START       0x61
>> >-#define KCS_CMD_WRITE_END         0x62
>> >-#define KCS_CMD_READ_BYTE         0x68
>> >-
>> >-static inline u8 kcs_bmc_read_data(struct kcs_bmc *kcs_bmc)
>> >+u8 kcs_bmc_read_data(struct kcs_bmc *kcs_bmc)
>> > {
>> > 	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
>> > }
>> >+EXPORT_SYMBOL(kcs_bmc_read_data);
>> >
>> >-static inline void kcs_bmc_write_data(struct kcs_bmc *kcs_bmc, u8 data)
>> >+void kcs_bmc_write_data(struct kcs_bmc *kcs_bmc, u8 data)
>> > {
>> > 	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.odr, data);
>> > }
>> >+EXPORT_SYMBOL(kcs_bmc_write_data);
>> >
>> >-static inline u8 kcs_bmc_read_status(struct kcs_bmc *kcs_bmc)
>> >+u8 kcs_bmc_read_status(struct kcs_bmc *kcs_bmc)
>> > {
>> > 	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.str);
>> > }
>> >+EXPORT_SYMBOL(kcs_bmc_read_status);
>> >
>> >-static inline void kcs_bmc_write_status(struct kcs_bmc *kcs_bmc, u8 data)
>> >+void kcs_bmc_write_status(struct kcs_bmc *kcs_bmc, u8 data)
>> > {
>> > 	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.str, data);
>> > }
>> >+EXPORT_SYMBOL(kcs_bmc_write_status);
>> >
>> >-static void kcs_bmc_update_status(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
>> >+void kcs_bmc_update_status(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
>> > {
>> > 	kcs_bmc->io_updateb(kcs_bmc, kcs_bmc->ioreg.str, mask, val);
>> > }
>> >+EXPORT_SYMBOL(kcs_bmc_update_status);
>> >
>> >-static inline void set_state(struct kcs_bmc *kcs_bmc, u8 state)
>> >-{
>> >-	kcs_bmc_update_status(kcs_bmc, KCS_STATUS_STATE_MASK,
>> >-					KCS_STATUS_STATE(state));
>> >-}
>> >-
>> >-static void kcs_force_abort(struct kcs_bmc *kcs_bmc)
>> >-{
>> >-	set_state(kcs_bmc, ERROR_STATE);
>> >-	kcs_bmc_read_data(kcs_bmc);
>> >-	kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
>> >-
>> >-	kcs_bmc->phase = KCS_PHASE_ERROR;
>> >-	kcs_bmc->data_in_avail = false;
>> >-	kcs_bmc->data_in_idx = 0;
>> >-}
>> >-
>> >-static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
>> >-{
>> >-	u8 data;
>> >-
>> >-	switch (kcs_bmc->phase) {
>> >-	case KCS_PHASE_WRITE_START:
>> >-		kcs_bmc->phase = KCS_PHASE_WRITE_DATA;
>> >-		fallthrough;
>> >-
>> >-	case KCS_PHASE_WRITE_DATA:
>> >-		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
>> >-			set_state(kcs_bmc, WRITE_STATE);
>> >-			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
>> >-			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
>> >-						kcs_bmc_read_data(kcs_bmc);
>> >-		} else {
>> >-			kcs_force_abort(kcs_bmc);
>> >-			kcs_bmc->error = KCS_LENGTH_ERROR;
>> >-		}
>> >-		break;
>> >-
>> >-	case KCS_PHASE_WRITE_END_CMD:
>> >-		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
>> >-			set_state(kcs_bmc, READ_STATE);
>> >-			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
>> >-						kcs_bmc_read_data(kcs_bmc);
>> >-			kcs_bmc->phase = KCS_PHASE_WRITE_DONE;
>> >-			kcs_bmc->data_in_avail = true;
>> >-			wake_up_interruptible(&kcs_bmc->queue);
>> >-		} else {
>> >-			kcs_force_abort(kcs_bmc);
>> >-			kcs_bmc->error = KCS_LENGTH_ERROR;
>> >-		}
>> >-		break;
>> >-
>> >-	case KCS_PHASE_READ:
>> >-		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len)
>> >-			set_state(kcs_bmc, IDLE_STATE);
>> >-
>> >-		data = kcs_bmc_read_data(kcs_bmc);
>> >-		if (data != KCS_CMD_READ_BYTE) {
>> >-			set_state(kcs_bmc, ERROR_STATE);
>> >-			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
>> >-			break;
>> >-		}
>> >-
>> >-		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len) {
>> >-			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
>> >-			kcs_bmc->phase = KCS_PHASE_IDLE;
>> >-			break;
>> >-		}
>> >-
>> >-		kcs_bmc_write_data(kcs_bmc,
>> >-			kcs_bmc->data_out[kcs_bmc->data_out_idx++]);
>> >-		break;
>> >-
>> >-	case KCS_PHASE_ABORT_ERROR1:
>> >-		set_state(kcs_bmc, READ_STATE);
>> >-		kcs_bmc_read_data(kcs_bmc);
>> >-		kcs_bmc_write_data(kcs_bmc, kcs_bmc->error);
>> >-		kcs_bmc->phase = KCS_PHASE_ABORT_ERROR2;
>> >-		break;
>> >-
>> >-	case KCS_PHASE_ABORT_ERROR2:
>> >-		set_state(kcs_bmc, IDLE_STATE);
>> >-		kcs_bmc_read_data(kcs_bmc);
>> >-		kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
>> >-		kcs_bmc->phase = KCS_PHASE_IDLE;
>> >-		break;
>> >-
>> >-	default:
>> >-		kcs_force_abort(kcs_bmc);
>> >-		break;
>> >-	}
>> >-}
>> >-
>> >-static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
>> >-{
>> >-	u8 cmd;
>> >-
>> >-	set_state(kcs_bmc, WRITE_STATE);
>> >-	kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
>> >-
>> >-	cmd = kcs_bmc_read_data(kcs_bmc);
>> >-	switch (cmd) {
>> >-	case KCS_CMD_WRITE_START:
>> >-		kcs_bmc->phase = KCS_PHASE_WRITE_START;
>> >-		kcs_bmc->error = KCS_NO_ERROR;
>> >-		kcs_bmc->data_in_avail = false;
>> >-		kcs_bmc->data_in_idx = 0;
>> >-		break;
>> >-
>> >-	case KCS_CMD_WRITE_END:
>> >-		if (kcs_bmc->phase != KCS_PHASE_WRITE_DATA) {
>> >-			kcs_force_abort(kcs_bmc);
>> >-			break;
>> >-		}
>> >-
>> >-		kcs_bmc->phase = KCS_PHASE_WRITE_END_CMD;
>> >-		break;
>> >-
>> >-	case KCS_CMD_GET_STATUS_ABORT:
>> >-		if (kcs_bmc->error == KCS_NO_ERROR)
>> >-			kcs_bmc->error = KCS_ABORTED_BY_COMMAND;
>> >-
>> >-		kcs_bmc->phase = KCS_PHASE_ABORT_ERROR1;
>> >-		kcs_bmc->data_in_avail = false;
>> >-		kcs_bmc->data_in_idx = 0;
>> >-		break;
>> >-
>> >-	default:
>> >-		kcs_force_abort(kcs_bmc);
>> >-		kcs_bmc->error = KCS_ILLEGAL_CONTROL_CODE;
>> >-		break;
>> >-	}
>> >-}
>> >-
>> >+int kcs_bmc_ipmi_event(struct kcs_bmc *kcs_bmc);
>>
>> This declaration looks a bit out of place here; should it be in
>> kcs_bmc.h instead?
>
>These are only temporary and get removed later on in the series after
>some shuffling of the code.
>

Okay -- there were a couple others further down in the patch that I'm
pretty sure were strictly redundant and could perhaps be cleaned up
(kcs_bmc_ipmi_event and kcs_bmc_ipmi_alloc in kcs_bmc_cdev_ipmi.c), but
aside from that:

Reviewed-by: Zev Weiss <zweiss@equinix.com>
