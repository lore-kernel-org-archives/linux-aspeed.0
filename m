From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Jul 2021 11:13:59 -0700
Subject: [PATCH 01/14] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <218ef97a68491e88d8012799385ee244544a157a.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-2-iwona.winiarska@intel.com>
 <32c71687f11fb418dafa45ecf15f7c6b50dd0397.camel@intel.com>
 <218ef97a68491e88d8012799385ee244544a157a.camel@intel.com>
Message-ID: <CAPcyv4hxsjKjLkEgGuG6tHvYxUa69315OvhYRORvCtXv6vu2nw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 15, 2021 at 9:47 AM Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
>
> On Wed, 2021-07-14 at 16:54 +0000, Williams, Dan J wrote:
> > On Tue, 2021-07-13 at 00:04 +0200, Iwona Winiarska wrote:
> > > Baseboard management controllers (BMC) often run Linux but are
> > > usually
> > > implemented with non-X86 processors. They can use PECI to access
> > > package
> > > config space (PCS) registers on the host CPU and since some
> > > information,
> > > e.g. figuring out the core count, can be obtained using different
> > > registers on different CPU generations, they need to decode the
> > > family
> > > and model.
> > >
> > > Move the data from arch/x86/include/asm/intel-family.h into a new
> > > file
> > > include/linux/x86/intel-family.h so that it can be used by other
> > > architectures.
> >
> > At least it would make the diffstat smaller to allow for rename
> > detection when the old file is deleted in the same patch:
> >
> >  MAINTAINERS                                                | 1 +
> >  {arch/x86/include/asm => include/linux/x86}/intel-family.h | 6 +++---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > ...one thing people have done in the past is include a conversion
> > script in the changelog that produced the diff. That way if a
> > maintainer wants to be sure to catch any new usage of the header at
> > the old location they just run the script.
>
> You mean like a simple s#asm/intel-family.h#linux/x86/intel-family.h#g
> ?
> Operating on kernel tree? Or individual patches?

Whole kernel tree, something like this patch is a good example:

58c1a35cd522 btrfs: convert kmap to kmap_local_page, simple cases

In this one, Ira generated a patch from a script, and the maintainer
could re-run it if new development added more of the "old way" before
applying Ira's patch.

> Is including "old" header in new code that big of a deal?

I was proposing ripping the band-aid off and deleting the old header,
in which case it would cause compile breakage if someone added a new
instance of the old include before the conversion patch was applied.

> I guess it
> could break grepability (looking for users of the header, now that it
> can be pulled from two different places).
> It would be worse if someone decided to add new content to old header,
> but this should be easier to catch during review.

Having 2 potential places for the same definition causes a small
ongoing maintenance / review burden, so I vote moving the file rather
than leaving a place holder, but it's ultimately an x86 maintainer
call.
