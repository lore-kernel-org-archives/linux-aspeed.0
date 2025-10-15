Return-Path: <linux-aspeed+bounces-2468-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4748CCD193
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:37:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Yy3MZmz304H;
	Thu, 16 Oct 2025 09:37:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.181.50.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760510339;
	cv=none; b=gAT49Ns69gDFwK8SQODBBb82obvnQ9BrhWF9c1rJ5TN967Mbn759jVkcHBY/JUruYDR0KGA9K1DRfeBOHUR1E0xBQojQy9LRHZYOhCxfNxcBLBs3fFvV8ESHIiT/C6O8J2Gjd0WyjViTgSq9YlrV0l5IUxsenQ4a+aSTpHFGH15iGLr4Mw3YUXARbcnsjTx/FvgHvtjeZWbn9MqmmF137tH2ex81NAouYNBcwMsKJgVEbC0B1OoSg7/xKHa3NEZN26S5Vlhlw4IR8tdKYgG/8bMXq8ymyxs17Gll9RTRWQskm+MclxXcZAAO3maqNvgLfA6AQrkkIfLsh8lZb7OtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760510339; c=relaxed/relaxed;
	bh=DA0NnJWQNr9VtzOBUBAFC69U2oZMOGFr4ymyJuLtrcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+n4joLbl4SyiwovLkAjCrvihg4DAmitGVrDTa70YmFPUPkfB1GtDdQy5hNa/1z2byvE6wKxVt1Woj6mgqi6c4hOLpglLdlxaUn9NnKQlcGf3p5Le9TqljF9+QxB4rcyf9iAnLEznn9n1xsJ3PB9/sSgrp0Cqcg70FFSxpugbHiRsEEwZZsaMVudZClCAosYg3jCV4FZCfB/1wyAQl5ajK4uhf5GFgDYjR6AonxQzu7DrBnIALnLL9WHO8sJVZQLNtCbYqRdadhwGp34gwRxgcTmy/mjrG6COTpS0RvTmpTgFvNtGLOvG0Se79WPUoEs/c38upGiKs4Zg1IcBV7w1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass (client-ip=220.181.50.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org) smtp.mailfrom=baidu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=220.181.50.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmhJ22nBRz3cfx
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 17:38:55 +1100 (AEDT)
From: lirongqing <lirongqing@baidu.com>
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
	<lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub
 Kacinski <kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel
 Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>, Jonathan
 Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
	<liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Phil
 Auld <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Russell King
	<linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt
	<rostedt@goodmis.org>
Subject: [PATCH][v4] hung_task: Panic when there are more than N hung tasks at the same time
Date: Wed, 15 Oct 2025 14:36:15 +0800
Message-ID: <20251015063615.2632-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjhj-exc9.internal.baidu.com (172.31.3.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Currently, when 'hung_task_panic' is enabled, the kernel panics
immediately upon detecting the first hung task. However, some hung
tasks are transient and allow system recovery, while persistent hangs
should trigger a panic when accumulating beyond a threshold.

Extend the 'hung_task_panic' sysctl to accept a threshold value
specifying the number of hung tasks that must be detected before
triggering a kernel panic. This provides finer control for environments
where transient hangs may occur but persistent hangs should be fatal.

The sysctl now accepts:
- 0: don't panic (maintains original behavior)
- 1: panic on first hung task (maintains original behavior)
- N > 1: panic after N hung tasks are detected in a single scan

This maintains backward compatibility while providing flexibility for
different hang scenarios.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Florian Wesphal <fw@strlen.de>
Cc: Jakub Kacinski <kuba@kernel.org>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
diff with v3: comments modification, suggested by Lance, Masami, Randy and Petr
diff with v2: do not add a new sysctl, extend hung_task_panic, suggested by Kees Cook

 Documentation/admin-guide/kernel-parameters.txt      | 20 +++++++++++++-------
 Documentation/admin-guide/sysctl/kernel.rst          |  9 +++++----
 arch/arm/configs/aspeed_g5_defconfig                 |  2 +-
 kernel/configs/debug.config                          |  2 +-
 kernel/hung_task.c                                   | 15 ++++++++++-----
 lib/Kconfig.debug                                    |  9 +++++----
 tools/testing/selftests/wireguard/qemu/kernel.config |  2 +-
 7 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a51ab46..492f0bc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1992,14 +1992,20 @@
 			the added memory block itself do not be affected.
 
 	hung_task_panic=
-			[KNL] Should the hung task detector generate panics.
-			Format: 0 | 1
+			[KNL] Number of hung tasks to trigger kernel panic.
+			Format: <int>
+
+			When set to a non-zero value, a kernel panic will be triggered if
+			the number of detected hung tasks reaches this value.
+
+			0: don't panic
+			1: panic immediately on first hung task
+			N: panic after N hung tasks are detected in a single scan
 
-			A value of 1 instructs the kernel to panic when a
-			hung task is detected. The default value is controlled
-			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
-			option. The value selected by this boot parameter can
-			be changed later by the kernel.hung_task_panic sysctl.
+			The default value is controlled by the
+			CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time option. The value
+			selected by this boot parameter can be changed later by the
+			kernel.hung_task_panic sysctl.
 
 	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
 				terminal devices. Valid values: 0..8
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f3ee807..0065a55 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -397,13 +397,14 @@ a hung task is detected.
 hung_task_panic
 ===============
 
-Controls the kernel's behavior when a hung task is detected.
+When set to a non-zero value, a kernel panic will be triggered if the
+number of hung tasks found during a single scan reaches this value.
 This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
-= =================================================
+= =======================================================
 0 Continue operation. This is the default behavior.
-1 Panic immediately.
-= =================================================
+N Panic when N hung tasks are found during a single scan.
+= =======================================================
 
 
 hung_task_check_count
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 61cee1e..c3b0d5f 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -308,7 +308,7 @@ CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
 CONFIG_WQ_WATCHDOG=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_FUNCTION_TRACER=y
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e81327d..9f6ab7d 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -83,7 +83,7 @@ CONFIG_SLUB_DEBUG_ON=y
 #
 # Debug Oops, Lockups and Hangs
 #
-# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=0
 # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b2c1f14..84b4b04 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -81,7 +81,7 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
  * hung task is detected:
  */
 static unsigned int __read_mostly sysctl_hung_task_panic =
-	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
+	CONFIG_BOOTPARAM_HUNG_TASK_PANIC;
 
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
@@ -218,8 +218,11 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
 }
 #endif
 
-static void check_hung_task(struct task_struct *t, unsigned long timeout)
+static void check_hung_task(struct task_struct *t, unsigned long timeout,
+		unsigned long prev_detect_count)
 {
+	unsigned long total_hung_task;
+
 	if (!task_is_hung(t, timeout))
 		return;
 
@@ -229,9 +232,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 */
 	sysctl_hung_task_detect_count++;
 
+	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
-	if (sysctl_hung_task_panic) {
+	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
 		console_verbose();
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
@@ -300,6 +304,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
 	struct task_struct *g, *t;
+	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
 
 	/*
 	 * If the system crashed already then all bets are off,
@@ -320,7 +325,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 
-		check_hung_task(t, timeout);
+		check_hung_task(t, timeout, prev_detect_count);
 	}
  unlock:
 	rcu_read_unlock();
@@ -389,7 +394,7 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "hung_task_check_count",
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3034e294..3976c90 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1258,12 +1258,13 @@ config DEFAULT_HUNG_TASK_TIMEOUT
 	  Keeping the default should be fine in most cases.
 
 config BOOTPARAM_HUNG_TASK_PANIC
-	bool "Panic (Reboot) On Hung Tasks"
+	int "Number of hung tasks to trigger kernel panic"
 	depends on DETECT_HUNG_TASK
+	default 0
 	help
-	  Say Y here to enable the kernel to panic on "hung tasks",
-	  which are bugs that cause the kernel to leave a task stuck
-	  in uninterruptible "D" state.
+	  When set to a non-zero value, a kernel panic will be triggered
+	  if the number of hung tasks found during a single scan reaches
+	  this value.
 
 	  The panic can be used in combination with panic_timeout,
 	  to cause the system to reboot automatically after a
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 936b18b..0504c11 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -81,7 +81,7 @@ CONFIG_WQ_WATCHDOG=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
 CONFIG_PANIC_TIMEOUT=-1
 CONFIG_STACKTRACE=y
 CONFIG_EARLY_PRINTK=y
-- 
2.9.4


