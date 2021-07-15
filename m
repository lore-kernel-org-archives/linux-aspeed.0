From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 15 Jul 2021 16:58:28 +0000
Subject: [PATCH 02/14] x86/cpu: Extract cpuid helpers to arch-independent
In-Reply-To: <87be3ed7be9949f6e929c2b185dc7d623d525f8e.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-3-iwona.winiarska@intel.com>
 <c81be21327124c2269baa13741cacbd304120e7f.camel@intel.com>
 <87be3ed7be9949f6e929c2b185dc7d623d525f8e.camel@intel.com>
Message-ID: <ae9654202758925d72f98e6ec14b106af39e5f3e.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2021-07-15 at 16:51 +0000, Winiarska, Iwona wrote:
> On Wed, 2021-07-14 at 16:58 +0000, Williams, Dan J wrote:
> > On Tue, 2021-07-13 at 00:04 +0200, Iwona Winiarska wrote:
> > > diff --git a/arch/x86/include/asm/cpu.h
> > > b/arch/x86/include/asm/cpu.h
> > > index 33d41e350c79..2a663a05a795 100644
> > > --- a/arch/x86/include/asm/cpu.h
> > > +++ b/arch/x86/include/asm/cpu.h
> > > @@ -37,9 +37,6 @@ extern int _debug_hotplug_cpu(int cpu, int
> > > action);
> > > ?
> > > ?int mwait_usable(const struct cpuinfo_x86 *);
> > > ?
> > > -unsigned int x86_family(unsigned int sig);
> > > -unsigned int x86_model(unsigned int sig);
> > > -unsigned int x86_stepping(unsigned int sig);
> > > ?#ifdef CONFIG_CPU_SUP_INTEL
> > > ?extern void __init sld_setup(struct cpuinfo_x86 *c);
> > > ?extern void switch_to_sld(unsigned long tifn);
> > > diff --git a/arch/x86/include/asm/microcode.h
> > > b/arch/x86/include/asm/microcode.h
> > > index ab45a220fac4..4b0eabf63b98 100644
> > > --- a/arch/x86/include/asm/microcode.h
> > > +++ b/arch/x86/include/asm/microcode.h
> > > @@ -2,9 +2,9 @@
> > > ?#ifndef _ASM_X86_MICROCODE_H
> > > ?#define _ASM_X86_MICROCODE_H
> > > ?
> > > -#include <asm/cpu.h>
> > > ?#include <linux/earlycpio.h>
> > > ?#include <linux/initrd.h>
> > > +#include <linux/x86/cpu.h>
> > 
> > Has this patch set received a build success notification from the
> > kbuild robot? I.e. are you sure that this include was only here for
> > the
> > 
> > unsigned int x86_family(unsigned int sig);
> > unsigned int x86_model(unsigned int sig);
> > unsigned int x86_stepping(unsigned int sig);
> > 
> > ...helpers. All the other replacements look trivially verifiable as
> > only needing these 3 helpers.

Missed the rest of your email in my previous post - sorry.
Yes - and before that I ran this through allyesconfig on x86.

> > 
> > > ?
> > > ?struct ucode_patch {
> > > ????????struct list_head plist;
> > > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > > index c99edfff7f82..bf070d2a2175 100644
> > > --- a/arch/x86/kvm/cpuid.h
> > > +++ b/arch/x86/kvm/cpuid.h
> > > @@ -4,10 +4,11 @@
> > > ?
> > > ?#include "x86.h"
> > > ?#include "reverse_cpuid.h"
> > > -#include <asm/cpu.h>
> > > ?#include <asm/processor.h>
> > > ?#include <uapi/asm/kvm_para.h>
> > > ?
> > > +#include <linux/x86/cpu.h>
> > > +
> > > ?extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
> > > ?void kvm_set_cpu_caps(void);
> > > ?
> > > diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> > > index bad4dee4f0e4..fd73c1b72c3e 100644
> > > --- a/arch/x86/lib/Makefile
> > > +++ b/arch/x86/lib/Makefile
> > > @@ -41,7 +41,7 @@ clean-files := inat-tables.c
> > > ?
> > > ?obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
> > > ?
> > > -lib-y := delay.o misc.o cmdline.o cpu.o
> > > +lib-y := delay.o misc.o cmdline.o
> > > ?lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
> > > ?lib-y += memcpy_$(BITS).o
> > > ?lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
> > > diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> > > index 27d56920b469..f545f5fad02c 100644
> > > --- a/drivers/edac/mce_amd.c
> > > +++ b/drivers/edac/mce_amd.c
> > > @@ -1,8 +1,7 @@
> > > ?// SPDX-License-Identifier: GPL-2.0-only
> > > ?#include <linux/module.h>
> > > ?#include <linux/slab.h>
> > > -
> > > -#include <asm/cpu.h>
> > > +#include <linux/x86/cpu.h>
> > > ?
> > > ?#include "mce_amd.h"
> > > ?
> > > diff --git a/include/linux/x86/cpu.h b/include/linux/x86/cpu.h
> > > new file mode 100644
> > > index 000000000000..5f383d47886d
> > > --- /dev/null
> > > +++ b/include/linux/x86/cpu.h
> > > @@ -0,0 +1,9 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +#ifndef _LINUX_X86_CPU_H
> > > +#define _LINUX_X86_CPU_H
> > > +
> > > +unsigned int x86_family(unsigned int sig);
> > > +unsigned int x86_model(unsigned int sig);
> > > +unsigned int x86_stepping(unsigned int sig);
> > > +
> > > +#endif /* _LINUX_X86_CPU_H */
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index d241fe476fda..cc28bc1f2d84 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -718,3 +718,8 @@ config PLDMFW
> > > ?
> > > ?config ASN1_ENCODER
> > > ??????? tristate
> > > +
> > > +config GENERIC_LIB_X86
> > > +???????bool
> > > +???????depends on X86
> > > +???????default n
> > 
> > No need for a "default n" line. Omitting a default is the same as
> > "default n".

Sure - I'll fix this in v2.

Thanks
-Iwona

> > 
> 

