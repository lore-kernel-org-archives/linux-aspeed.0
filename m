From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 Feb 2022 22:23:44 +1030
Subject: [PATCH v2 3/3] x86/setup: Populate bootinfo with secure boot status
In-Reply-To: <20220203115344.267159-1-joel@jms.id.au>
References: <20220203115344.267159-1-joel@jms.id.au>
Message-ID: <20220203115344.267159-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

bootinfo indicates to userspace that firmware is configured to boot with
secure boot.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: new
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f7a132eb794d..b805b758478f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/firmware_bootinfo.h>
 
 #include <uapi/linux/mount.h>
 
@@ -1100,17 +1101,22 @@ void __init setup_arch(char **cmdline_p)
 	setup_log_buf(1);
 
 	if (efi_enabled(EFI_BOOT)) {
+		struct bootinfo bootinfo = {};
+
 		switch (boot_params.secure_boot) {
 		case efi_secureboot_mode_disabled:
 			pr_info("Secure boot disabled\n");
+			BOOTINFO_SET(bootinfo, secure_boot, false);
 			break;
 		case efi_secureboot_mode_enabled:
 			pr_info("Secure boot enabled\n");
+			BOOTINFO_SET(bootinfo, secure_boot, true);
 			break;
 		default:
 			pr_info("Secure boot could not be determined\n");
 			break;
 		}
+		firmware_bootinfo_init(&bootinfo);
 	}
 
 	reserve_initrd();
-- 
2.34.1

