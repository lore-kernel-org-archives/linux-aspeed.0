From: Borislav Petkov <bp@alien8.de>
Date: Mon, 4 Oct 2021 21:03:55 +0200
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <20210803113134.2262882-2-iwona.winiarska@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
Message-ID: <YVtQG+idmwKn0qLe@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 03, 2021 at 01:31:20PM +0200, Iwona Winiarska wrote:
> Baseboard management controllers (BMC) often run Linux but are usually
> implemented with non-X86 processors. They can use PECI to access package
> config space (PCS) registers on the host CPU and since some information,
> e.g. figuring out the core count, can be obtained using different
> registers on different CPU generations, they need to decode the family
> and model.
> 
> Move the data from arch/x86/include/asm/intel-family.h into a new file
> include/linux/x86/intel-family.h so that it can be used by other
> architectures.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
> To limit tree-wide changes and help people that were expecting
> intel-family defines in arch/x86 to find it more easily without going
> through git history, we're not removing the original header
> completely, we're keeping it as a "stub" that includes the new one.
> If there is a consensus that the tree-wide option is better,
> we can choose this approach.

Why can't the linux/ namespace header include the x86 one so that
nothing changes for arch/x86/?

And if it is really only a handful of families you need, you might just
as well copy them into the peci headers and slap a comment above it
saying where they come from and save yourself all that churn...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
