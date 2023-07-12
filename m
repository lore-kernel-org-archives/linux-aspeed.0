From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed, 12 Jul 2023 13:02:53 +0200
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <94eb6e4d-9384-152f-351b-ebb217411da9@amd.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <94eb6e4d-9384-152f-351b-ebb217411da9@amd.com>
Message-ID: <20230712110253.paoyrmcbvlhpfxbf@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 12, 2023 at 12:46:33PM +0200, Christian K?nig wrote:
> Am 12.07.23 um 11:46 schrieb Uwe Kleine-K?nig:
> > Hello,
> > 
> > while I debugged an issue in the imx-lcdc driver I was constantly
> > irritated about struct drm_device pointer variables being named "dev"
> > because with that name I usually expect a struct device pointer.
> > 
> > I think there is a big benefit when these are all renamed to "drm_dev".
> > I have no strong preference here though, so "drmdev" or "drm" are fine
> > for me, too. Let the bikesheding begin!
> > 
> > Some statistics:
> > 
> > $ git grep -ohE 'struct drm_device *\* *[^ (),;]*' v6.5-rc1 | sort | uniq -c | sort -n
> >        1 struct drm_device *adev_to_drm
> >        1 struct drm_device *drm_
> >        1 struct drm_device          *drm_dev
> >        1 struct drm_device        *drm_dev
> >        1 struct drm_device *pdev
> >        1 struct drm_device *rdev
> >        1 struct drm_device *vdev
> >        2 struct drm_device *dcss_drv_dev_to_drm
> >        2 struct drm_device **ddev
> >        2 struct drm_device *drm_dev_alloc
> >        2 struct drm_device *mock
> >        2 struct drm_device *p_ddev
> >        5 struct drm_device *device
> >        9 struct drm_device * dev
> >       25 struct drm_device *d
> >       95 struct drm_device *
> >      216 struct drm_device *ddev
> >      234 struct drm_device *drm_dev
> >      611 struct drm_device *drm
> >     4190 struct drm_device *dev
> > 
> > This series starts with renaming struct drm_crtc::dev to drm_dev. If
> > it's not only me and others like the result of this effort it should be
> > followed up by adapting the other structs and the individual usages in
> > the different drivers.
> > 
> > To make this series a bit easier handleable, I first added an alias for
> > drm_crtc::dev, then converted the drivers one after another and the last
> > patch drops the "dev" name. This has the advantage of being easier to
> > review, and if I should have missed an instance only the last patch must
> > be dropped/reverted. Also this series might conflict with other patches,
> > in this case the remaining patches can still go in (apart from the last
> > one of course). Maybe it also makes sense to delay applying the last
> > patch by one development cycle?
> 
> When you automatically generate the patch (with cocci for example) I usually
> prefer a single patch instead.

Maybe I'm too stupid, but only parts of this patch were created by
coccinelle. I failed to convert code like

-       spin_lock_irq(&crtc->dev->event_lock);
+       spin_lock_irq(&crtc->drm_dev->event_lock);

Added Julia to Cc, maybe she has a hint?!

(Up to now it's only 

@@
struct drm_crtc *crtc;
@@
-crtc->dev
+crtc->drm_dev

)

> Background is that this makes merge conflicts easier to handle and detect.

Really? Each file (apart from include/drm/drm_crtc.h) is only touched
once. So unless I'm missing something you don't get less or easier
conflicts by doing it all in a single patch. But you gain the freedom to
drop a patch for one driver without having to drop the rest with it. So
I still like the split version better, but I'm open to a more verbose
reasoning from your side.

> When you have multiple patches and a merge conflict because of some added
> lines using the old field the build breaks only on the last patch which
> removes the old field.

Then you can revert/drop the last patch without having to respin the
whole single patch and thus caring for still more conflicts that arise
until the new version is sent.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230712/c0800bcd/attachment-0001.sig>
