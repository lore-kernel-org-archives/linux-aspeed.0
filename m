From: Borislav Petkov <bp@alien8.de>
Date: Mon, 4 Oct 2021 21:08:22 +0200
Subject: [PATCH v2 02/15] x86/cpu: Extract cpuid helpers to
 arch-independent
In-Reply-To: <20210803113134.2262882-3-iwona.winiarska@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-3-iwona.winiarska@intel.com>
Message-ID: <YVtRJiYD9EqGh7TM@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 03, 2021 at 01:31:21PM +0200, Iwona Winiarska wrote:
> Baseboard management controllers (BMC) often run Linux but are usually
> implemented with non-X86 processors. They can use PECI to access package
> config space (PCS) registers on the host CPU and since some information,
> e.g. figuring out the core count, can be obtained using different
> registers on different CPU generations, they need to decode the family
> and model.
> 
> The format of Package Identifier PCS register that describes CPUID
> information has the same layout as CPUID_1.EAX, so let's allow to reuse
> cpuid helpers by making it available for other architectures as well.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS                      | 1 +
>  arch/x86/Kconfig                 | 1 +
>  arch/x86/include/asm/cpu.h       | 3 ---
>  arch/x86/include/asm/microcode.h | 2 +-
>  arch/x86/kvm/cpuid.h             | 3 ++-
>  arch/x86/lib/Makefile            | 2 +-
>  drivers/edac/mce_amd.c           | 3 +--
>  include/linux/x86/cpu.h          | 9 +++++++++
>  lib/Kconfig                      | 4 ++++
>  lib/Makefile                     | 2 ++
>  lib/x86/Makefile                 | 3 +++
>  {arch/x86/lib => lib/x86}/cpu.c  | 2 +-
>  12 files changed, 26 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/x86/cpu.h
>  create mode 100644 lib/x86/Makefile
>  rename {arch/x86/lib => lib/x86}/cpu.c (95%)

AFAICT, all that churn is done for x86_family() and x86_model() which
are used *exactly* *once* and which are almost trivial anyway.

What's wrong with simply computing the family and model "by hand", so to
speak, in peci_device_info_init() and do away with that diffstat

 12 files changed, 26 insertions(+), 9 deletions(-)

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
