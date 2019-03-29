From: Rob Herring <robh@kernel.org>
Date: Fri, 29 Mar 2019 14:45:29 -0500
Subject: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
In-Reply-To: <CAO=notynUJGUn3tuJZ_jFPdz23_T1FPyzS46mm5msphLnLW_JA@mail.gmail.com>
References: <20190327212155.80730-1-venture@google.com>
 <20190328165009.GA25705@bogus>
 <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
 <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
 <CAO=notx6K7xTW1VG6BGJFBM5k8EQsWXn3WoWSPSrZRsxkwueSA@mail.gmail.com>
 <CAO=notxD=5pa5sT15a+VrA7qVNPBoJoTo=5sLxibBxc+HWcG4g@mail.gmail.com>
 <CAO=notynUJGUn3tuJZ_jFPdz23_T1FPyzS46mm5msphLnLW_JA@mail.gmail.com>
Message-ID: <CAL_Jsq+0udKJ1ZyfJCvS8GDGXdNiFmGN+mOGNBvf5mqLr31wew@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 29, 2019 at 10:11 AM Patrick Venture <venture@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 7:59 AM Patrick Venture <venture@google.com> wrote:
> >
> > On Fri, Mar 29, 2019 at 7:56 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Fri, Mar 29, 2019 at 6:38 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 28, 2019 at 12:03 PM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > > > > > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > > > > > >
> > > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > > > ---
> > > > > > > Changes for v8:
> > > > > > > - None
> > > > > > > Changes for v7:
> > > > > > > - Moved node under the syscon node it requires
> > > > > > > Changes for v6:
> > > > > > > - None
> > > > > > > Changes for v5:
> > > > > > > - None
> > > > > > > Changes for v4:
> > > > > > > - None
> > > > > > > Changes for v3:
> > > > > > > - None
> > > > > > > Changes for v2:
> > > > > > > - Added comment about syscon required parameter.
> > > > > > > ---
> > > > > > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> > > > > > >  1 file changed, 48 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > > > > >
> > > > > >
> > > > > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > > > > > there's no need to repost patches *only* to add the tags. The upstream
> > > > > > maintainer will do that for acks received on the version they apply.
> > > > > >
> > > > > > If a tag was not added on purpose, please state why and what changed.
> > > > >
> > > > > Adding tags in this case is adding a change version?  I was doing this
> > > > > to keep the two patches version-synced.  I thought that was required.
> > > > > There was a version change in the other patch in this set.
> > > >
> > > > Adding tags is not considered a change. I gave a Reviewed-by in v7.
> > > > Subsequent versions should carry that tag if there's no change (or
> > > > only minor changes) in this patch. What happens in the other patches
> > > > is not really important. Maintainers are not going to go searching
> > > > thru the versions to find all the ack/review tags. And if I've already
> > > > reviewed this, I don't want to look at it again.
> > >
> > > Thank you, I didn't realize that had happened.
> >
> > I went back through my email and found the line of your email that
> > included it.  I apologize.
> >
> > So, before I send the updated patch with your ack -- do I need to send
> > a v9? or is this just me sending v8 again?
>
> Sorry.  I see you already answered that when you said that adding a
> tag isn't considered a change.  I have therefore re-sent v8 of this
> patch with your tag added.

To repeat my form letter again, you don't need to send a series again
just to add tags. IOW, if you send a v9, then add the tags. If v8 is
what a maintainer applies, the maintain will take care of adding them
(or patchwork does it for us):

> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
