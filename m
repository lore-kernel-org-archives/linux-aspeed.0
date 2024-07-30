From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jul 2024 14:44:48 -0000
Subject: [PATCH 0/5] treewide: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1.

Recently, multiple developers have been eradicating these warnings
treewide, and I personally submitted almost 300 patches over the past
few months. Almost all of my patches landed by 6.11-rc1, either by
being merged in a 6.10-rc or by being merged in the 6.11 merge
window. However, a few of my patches did not land.

In some cases I see them in linux-next, but they did not land during
the merge window. I'm still monitoring those.

In a few cases I have not had any feedback that the patches have been
accepted into a maintainer's tree. At the advice of Greg KH I've
consolidated those patches into this single series with the hope these
can still land before 6.11-final.
https://lore.kernel.org/all/2024071518-ridden-election-8118 at gregkh/

Links to the original individual patches:

crypto: arm/xor - add missing MODULE_DESCRIPTION() macro
https://lore.kernel.org/all/20240711-md-arm-arch-arm-lib-v2-1-ab08653dc106 at quicinc.com/

x86/mm: add testmmiotrace MODULE_DESCRIPTION()
https://lore.kernel.org/all/20240515-testmmiotrace-md-v1-1-10919a8b2842 at quicinc.com/

cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
https://lore.kernel.org/all/20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d at quicinc.com/

fsi: add missing MODULE_DESCRIPTION() macros
https://lore.kernel.org/all/20240605-md-drivers-fsi-v1-1-fefc82d81b12 at quicinc.com/

locking/ww_mutex/test: add MODULE_DESCRIPTION()
https://lore.kernel.org/all/20240528-md-test-ww_mutex-v2-1-a2a19e920b12 at quicinc.com/

---
Jeff Johnson (5):
      crypto: arm/xor - add missing MODULE_DESCRIPTION() macro
      x86/mm: add testmmiotrace MODULE_DESCRIPTION()
      cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
      fsi: add missing MODULE_DESCRIPTION() macros
      locking/ww_mutex/test: add MODULE_DESCRIPTION()

 arch/arm/lib/xor-neon.c           | 1 +
 arch/x86/mm/testmmiotrace.c       | 1 +
 drivers/cpufreq/maple-cpufreq.c   | 1 +
 drivers/cpufreq/pasemi-cpufreq.c  | 1 +
 drivers/cpufreq/pmac64-cpufreq.c  | 1 +
 drivers/cpufreq/powernv-cpufreq.c | 1 +
 drivers/cpufreq/ppc_cbe_cpufreq.c | 1 +
 drivers/fsi/fsi-core.c            | 1 +
 drivers/fsi/fsi-master-aspeed.c   | 1 +
 drivers/fsi/fsi-master-ast-cf.c   | 3 ++-
 drivers/fsi/fsi-master-gpio.c     | 1 +
 drivers/fsi/fsi-master-hub.c      | 1 +
 drivers/fsi/fsi-scom.c            | 1 +
 kernel/locking/test-ww_mutex.c    | 1 +
 14 files changed, 15 insertions(+), 1 deletion(-)
---
base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
change-id: 20240730-module_description_orphans-cb5e25fe1656

