From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Mon, 11 Oct 2021 20:53:51 +0000
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <67f2cfda-c78b-6282-f5a3-2f345f8e2849@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <67f2cfda-c78b-6282-f5a3-2f345f8e2849@intel.com>
Message-ID: <43e367e452c6c8d9c6a275299d7ff6f2bb26b8e3.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-10-11 at 12:40 -0700, Dave Hansen wrote:
> On 10/11/21 12:21 PM, Winiarska, Iwona wrote:
> > On Mon, 2021-10-04 at 21:03 +0200, Borislav Petkov wrote:
> > > On Tue, Aug 03, 2021 at 01:31:20PM +0200, Iwona Winiarska wrote:
> > > > Baseboard management controllers (BMC) often run Linux but are usually
> > > > implemented with non-X86 processors. They can use PECI to access package
> > > > config space (PCS) registers on the host CPU and since some information,
> > > > e.g. figuring out the core count, can be obtained using different
> > > > registers on different CPU generations, they need to decode the family
> > > > and model.
> > > > 
> > > > Move the data from arch/x86/include/asm/intel-family.h into a new file
> > > > include/linux/x86/intel-family.h so that it can be used by other
> > > > architectures.
> > > > 
> > > > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > > > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > > To limit tree-wide changes and help people that were expecting
> > > > intel-family defines in arch/x86 to find it more easily without going
> > > > through git history, we're not removing the original header
> > > > completely, we're keeping it as a "stub" that includes the new one.
> > > > If there is a consensus that the tree-wide option is better,
> > > > we can choose this approach.
> > > Why can't the linux/ namespace header include the x86 one so that
> > > nothing changes for arch/x86/?
> > Same reason why PECI can't just include arch/x86 directly (we're building
> > for
> > ARM, not x86).
> If you're in include/linux/x86-hacks.h, what prevents you from doing
> 
> #include "../../arch/x86/include/asm/intel-family.h"
> 
> ?
> 
> In the end, to the compiler, it's just a file in a weird location in the
> tree.? I think I'd prefer one weird include to moving that file out of
> arch/x86.

Using relative includes in include/linux is uncommon (I can see just one usage
in libfdt.h pulling stuff from scripts), so I thought I can't use it in this way
(seems slightly hacky to pull stuff from outside include path).

But if that would be ok, it looks like a good alternative to avoid duplication
in this case.

Thanks
-Iwona
