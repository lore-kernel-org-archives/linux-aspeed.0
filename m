From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Mon, 11 Oct 2021 19:21:26 +0000
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <YVtQG+idmwKn0qLe@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
Message-ID: <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-10-04 at 21:03 +0200, Borislav Petkov wrote:
> On Tue, Aug 03, 2021 at 01:31:20PM +0200, Iwona Winiarska wrote:
> > Baseboard management controllers (BMC) often run Linux but are usually
> > implemented with non-X86 processors. They can use PECI to access package
> > config space (PCS) registers on the host CPU and since some information,
> > e.g. figuring out the core count, can be obtained using different
> > registers on different CPU generations, they need to decode the family
> > and model.
> > 
> > Move the data from arch/x86/include/asm/intel-family.h into a new file
> > include/linux/x86/intel-family.h so that it can be used by other
> > architectures.
> > 
> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > To limit tree-wide changes and help people that were expecting
> > intel-family defines in arch/x86 to find it more easily without going
> > through git history, we're not removing the original header
> > completely, we're keeping it as a "stub" that includes the new one.
> > If there is a consensus that the tree-wide option is better,
> > we can choose this approach.
> 
> Why can't the linux/ namespace header include the x86 one so that
> nothing changes for arch/x86/?

Same reason why PECI can't just include arch/x86 directly (we're building for
ARM, not x86).

> And if it is really only a handful of families you need, you might just
> as well copy them into the peci headers and slap a comment above it
> saying where they come from and save yourself all that churn...

It's a handful of families for now - but I do expect the list to grow once new
platforms are introduced (and with that - duplicates have to be added in both
places).

Since the churn is relatively low I wanted to start with trying to keep things
clean first.
If you're against that - sure, we can duplicate. 

Thanks
-Iwona
