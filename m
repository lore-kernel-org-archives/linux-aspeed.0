From: Joel Stanley <joel@jms.id.au>
Date: Tue, 2 Apr 2019 02:09:19 +0000
Subject: [PATCH 2/2] drm: Add ASPEED GFX driver
In-Reply-To: <20190328075317.GR2665@phenom.ffwll.local>
References: <20190328054316.17939-1-joel@jms.id.au>
 <20190328054316.17939-3-joel@jms.id.au>
 <20190328075317.GR2665@phenom.ffwll.local>
Message-ID: <CACPK8Xf8Vz+pfJd1jo4Mzce9=vNoKk_Osvi3Tbdu3KSTmgmBkA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2019 at 07:53, Daniel Vetter <daniel@ffwll.ch> wrote:

> > +static int aspeed_gfx_get_modes(struct drm_connector *connector)
> > +{
> > +     return drm_add_modes_noedid(connector, 800, 600);
>
> Is this the only mode you do, or just a default? Iirc if you report
> "connected", you'll get this as one of the fallback modes already.

I this is the only mode we can do with the clock that we have available.

> Very nice driver!
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks!

> For merging/maintenance, do you want to put this into drm-misc?
>
> https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#small-drivers

That makes sense. I'll send out a v2 with the changes you and Noralf
suggested, and a maintainers patch, once I've given it a spin on
hardware.

> We could also officially put drm/ast in there, if you want to maintain
> that too.

I haven't had much to do with that driver (it's physically inside the
BMC, but a different piece of hardware). I can probably be included so
I'm on cc for changes.

Cheers,

Joel


>
> Either way, patch also needs a MAINTAINERS entry.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
