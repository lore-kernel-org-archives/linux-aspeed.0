From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 22 May 2020 19:15:10 +0100
Subject: [PATCH 01/21] drm/cma-helper: Rework DRM_GEM_CMA_VMAP_DRIVER_OPS
 macro
In-Reply-To: <20200522174835.GA1087580@ravnborg.org>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-2-tzimmermann@suse.de>
 <20200522174835.GA1087580@ravnborg.org>
Message-ID: <CACvgo53YDOD1t4KYOWKiO-q8T639jNbMrZuyTXcbe1FBAfxP+Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2020 at 18:48, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Thomas.
>
> On Fri, May 22, 2020 at 03:52:26PM +0200, Thomas Zimmermann wrote:
> > Rename the macro to DRM_GEM_CMA_DRIVER_OPS to align with SHMEM
> > helpers.
> This part is fine, I like that the naming is somehow consistent.
>
> > An internal version is provided for drivers that override
> > the default .dumb_create callback. Adapt drivers to the changes.
> I loathe anything named __foo or __FOO. This __ signals to me
> that the author was clueless in naming - or some sort.
> I know that __ is used in some lib headers - but thats not the case
> here.
>
> But I love that we have a variant that takes a create function.
> So we do not have to escape from the nice macro.
> The macro is another way to tell me as rewiewer that this
> drivers uses all the default helpers for this.
>
Fwiw I share the sentiment, although I fear we're a little late. __
prefixed functions are widely common in core drm and it's helpers.

>
> So critizising the name I better suggest something that
> I personally like better:
>
> DRM_GEM_CMA_DRIVER_OPS_CREATE()
>
> It would look like this:
>         /* GEM Operations */
> -       DRM_GEM_CMA_VMAP_DRIVER_OPS,
> -       .dumb_create            = drm_sun4i_gem_dumb_create,
> +       DRM_GEM_CMA_DRIVER_OPS_CREATE(drm_sun4i_gem_dumb_create),
>
>
>
> Please fix zte/zx_drm_drv.c which also uses DRM_GEM_CMA_VMAP_DRIVER_OPS.
>
Isn't DRM_GEM_CMA_VMAP_DRIVER_OPS introduced to zte with the last
patch in the series?

-Emil
