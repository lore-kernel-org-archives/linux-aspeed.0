From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 28 May 2020 15:34:30 +0100
Subject: [PATCH 07/21] drm/hisilicon/kirin: Use GEM CMA object functions
In-Reply-To: <ccee78e2-8930-2de6-0b7c-0f1ad1e636f8@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-8-tzimmermann@suse.de>
 <CACvgo51cYh4iLKEfrLSbgOGQM4=ojsBq54gW9VJBPoX+p04o+g@mail.gmail.com>
 <ccee78e2-8930-2de6-0b7c-0f1ad1e636f8@suse.de>
Message-ID: <CACvgo52de8opoX98Kchp00gfDa7iGyezumNZPeNaOeLpYjETEQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2020 at 13:41, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi Emil
>
> Am 22.05.20 um 20:11 schrieb Emil Velikov:
> > Hi Thomas,
> >
> > On Fri, 22 May 2020 at 14:53, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> The kirin driver uses the default implementation for CMA functions; except
> >> for the .dumb_create callback. The __DRM_GEM_CMA_DRIVER_OPS macro now sets
> >> these defaults and .dumb_create in struct drm_driver. All remaining
> >> operations are provided by CMA GEM object functions.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 12 +-----------
> >>  1 file changed, 1 insertion(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> >> index c339e632522a9..b1ffd7d43e562 100644
> >> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> >> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> >> @@ -921,17 +921,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ade_fops);
> >>  static struct drm_driver ade_driver = {
> >>         .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> >>         .fops = &ade_fops,
> >> -       .gem_free_object_unlocked = drm_gem_cma_free_object,
> >> -       .gem_vm_ops = &drm_gem_cma_vm_ops,
> >> -       .dumb_create = drm_gem_cma_dumb_create_internal,
> >
> > This doesn't seem right. The _internal documentation explicitly says
> > that this should _not_ be used as .dumb_create. Instead drivers should
> > use it to implement their callback.
> >
> > Since it yields the same result as drm_gem_cma_dumb_create we can use
> > the default macro below.
>
> I noticed this and thought that the driver authors probably had their
> reasons. Changing the driver to the default macro is probably still a
> good idea.
>
To be on the _extra_ safe side might want to keep that separate patch
explicitly CC-ing the author/reviewers of the offending commit.
Although as said before - it's your call, I'm fine either way.

HTH
Emil
