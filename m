From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 15 Jul 2021 16:47:16 +0000
Subject: [PATCH 01/14] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <32c71687f11fb418dafa45ecf15f7c6b50dd0397.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-2-iwona.winiarska@intel.com>
 <32c71687f11fb418dafa45ecf15f7c6b50dd0397.camel@intel.com>
Message-ID: <218ef97a68491e88d8012799385ee244544a157a.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-07-14 at 16:54 +0000, Williams, Dan J wrote:
> On Tue, 2021-07-13 at 00:04 +0200, Iwona Winiarska wrote:
> > Baseboard management controllers (BMC) often run Linux but are
> > usually
> > implemented with non-X86 processors. They can use PECI to access
> > package
> > config space (PCS) registers on the host CPU and since some
> > information,
> > e.g. figuring out the core count, can be obtained using different
> > registers on different CPU generations, they need to decode the
> > family
> > and model.
> > 
> > Move the data from arch/x86/include/asm/intel-family.h into a new
> > file
> > include/linux/x86/intel-family.h so that it can be used by other
> > architectures.
> 
> At least it would make the diffstat smaller to allow for rename
> detection when the old file is deleted in the same patch:
> 
> ?MAINTAINERS??????????????????????????????????????????????? | 1 +
> ?{arch/x86/include/asm => include/linux/x86}/intel-family.h | 6 +++---
> ?2 files changed, 4 insertions(+), 3 deletions(-)
> 
> ...one thing people have done in the past is include a conversion
> script in the changelog that produced the diff. That way if a
> maintainer wants to be sure to catch any new usage of the header at
> the old location they just run the script.

You mean like a simple s#asm/intel-family.h#linux/x86/intel-family.h#g
?
Operating on kernel tree? Or individual patches?

Is including "old" header in new code that big of a deal? I guess it
could break grepability (looking for users of the header, now that it
can be pulled from two different places).
It would be worse if someone decided to add new content to old header,
but this should be easier to catch during review.

> 
> I am not aware of x86 maintainer preference here. Either way you decide
> to go you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 

Thank you
-Iwona
