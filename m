From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Aug 2021 16:22:00 +0930
Subject: [PATCH 1/4] ARM: config: aspeed: Enable hardened allocator feature
In-Reply-To: <20210819065203.2620911-1-joel@jms.id.au>
References: <20210819065203.2620911-1-joel@jms.id.au>
Message-ID: <20210819065203.2620911-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

SLAB_FREELIST_HARDENED can protect from freelist overwrite attacks with
really small overhead.

It works best with the SLUB allocator, so make SLUB the default by
removing SLAB=y.

      total   used           free           shared        buff/cache    available
SLAB  425596  44065.3+/-220  311099+/-3800  14864+/-3900  70432+/-3700  352767+/-3900

SLUB  425592  44225.3+/-280  313275+/-600   12132+/-3.3   68092+/-530   355295+/-280

These figures are the average memory usage from three boots of each
option in qemu, running the Romulus userspace. The output is from
free(1), reported in kilobytes.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g4_defconfig | 2 +-
 arch/arm/configs/aspeed_g5_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index a3ee647b1ebb..397c57e94743 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -18,8 +18,8 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
 CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 2db48438c5d2..3f81146a9c0e 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -18,8 +18,8 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_SLAB=y
 CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G5=y
-- 
2.32.0

