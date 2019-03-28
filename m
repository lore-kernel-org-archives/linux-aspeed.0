From: Patrick Venture <venture@google.com>
Date: Thu, 28 Mar 2019 10:03:36 -0700
Subject: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
In-Reply-To: <20190328165009.GA25705@bogus>
References: <20190327212155.80730-1-venture@google.com>
 <20190328165009.GA25705@bogus>
Message-ID: <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> > Changes for v8:
> > - None
> > Changes for v7:
> > - Moved node under the syscon node it requires
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - None
> > Changes for v3:
> > - None
> > Changes for v2:
> > - Added comment about syscon required parameter.
> > ---
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Adding tags in this case is adding a change version?  I was doing this
to keep the two patches version-synced.  I thought that was required.
There was a version change in the other patch in this set.
