From: Joel Stanley <joel@jms.id.au>
Date: Wed, 3 Apr 2019 07:30:12 +0000
Subject: [PATCH v3 3/3] MAINTAINERS: Add ASPEED BMC GFX DRM driver entry
In-Reply-To: <20190403071115.GO2665@phenom.ffwll.local>
References: <20190403001909.31637-1-joel@jms.id.au>
 <20190403001909.31637-4-joel@jms.id.au>
 <20190403071115.GO2665@phenom.ffwll.local>
Message-ID: <CACPK8XdLkG3TR3yLKCJuUJzw+Fonpdi+imKPnQjbZ8B=WEQ47g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2019 at 07:11, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Apr 03, 2019 at 10:49:09AM +1030, Joel Stanley wrote:
> > This hardware is found inside ASPEED Baseboard Management Controller
> > (BMC) system on chips. It is called the 'SOC Display Controller' or 'GFX'.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c18f5f10cf91..c3ad730e26f3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4909,6 +4909,14 @@ M:     Dave Airlie <airlied@redhat.com>
> >  S:   Odd Fixes
> >  F:   drivers/gpu/drm/ast/
> >
> > +DRM DRIVER FOR ASPEED BMC GFX
> > +M:   Joel Stanley <joel@jms.id.au>
> > +L:   linux-aspeed at lists.ozlabs.org
> > +T:   git git://anongit.freedesktop.org/drm/drm-misc
>
> Do you have the fdo account request for drm-misc already?

I don't. How does the process work?

Cheers,

Joel
