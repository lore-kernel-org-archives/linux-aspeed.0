From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Jun 2023 09:08:15 -0700
Subject: [PATCH 00/53] drm: Convert to platform remove callback returning void
In-Reply-To: <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de> <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
Message-ID: <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Thu, Jun 1, 2023 at 8:40?AM Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sun, May 07, 2023 at 06:25:23PM +0200, Uwe Kleine-K?nig wrote:
> > this patch series adapts the platform drivers below drivers/gpu/drm
> > to use the .remove_new() callback. Compared to the traditional .remove()
> > callback .remove_new() returns no value. This is a good thing because
> > the driver core doesn't (and cannot) cope for errors during remove. The
> > only effect of a non-zero return value in .remove() is that the driver
> > core emits a warning. The device is removed anyhow and an early return
> > from .remove() usually yields a resource leak.
> >
> > By changing the remove callback to return void driver authors cannot
> > reasonably (but wrongly) assume any more that there happens some kind of
> > cleanup later.
>
> I wonder if someone would volunteer to add the whole series to
> drm-misc-next?!

It looks as if Neil applied quite a few of them already, so I looked
at what was left...

I'm a little hesitant to just apply the whole kit-and-caboodle to
drm-misc-next since there are specific DRM trees for a bunch of them
and it would be better if they landed there. ...so I went through all
the patches that still applied to drm-misc-next, then used
'scripts/get_maintainer.pl --scm' to check if they were maintained
through drm-misc. That still left quite a few patches. I've applied
those ones and pushed to drm-misc-next:

71722685cd17 drm/xlnx/zynqmp_dpsub: Convert to platform remove
callback returning void
1ed54a19f3b3 drm/vc4: Convert to platform remove callback returning void
b957812839f8 drm/v3d: Convert to platform remove callback returning void
e2fd3192e267 drm/tve200: Convert to platform remove callback returning void
84e6da7ad553 drm/tiny: Convert to platform remove callback returning void
34cdd1f691ad drm/tidss: Convert to platform remove callback returning void
d665e3c9d37a drm/sun4i: Convert to platform remove callback returning void
0c259ab19146 drm/stm: Convert to platform remove callback returning void
9a865e45884a drm/sti: Convert to platform remove callback returning void
3c855610840e drm/rockchip: Convert to platform remove callback returning void
e41977a83b71 drm/panfrost: Convert to platform remove callback returning void
cef3776d0b5a drm/panel: Convert to platform remove callback returning void
bd296a594e87 drm/mxsfb: Convert to platform remove callback returning void
38ca2d93d323 drm/meson: Convert to platform remove callback returning void
fd1457d84bae drm/mcde: Convert to platform remove callback returning void
41a56a18615c drm/logicvc: Convert to platform remove callback returning void
980ec6444372 drm/lima: Convert to platform remove callback returning void
82a2c0cc1a22 drm/hisilicon: Convert to platform remove callback returning void
c3b28b29ac0a drm/fsl-dcu: Convert to platform remove callback returning void
a118fc6e71f9 drm/atmel-hlcdc: Convert to platform remove callback returning void
9a32dd324c46 drm/aspeed: Convert to platform remove callback returning void
2c7d291c498c drm/arm/malidp: Convert to platform remove callback returning void
a920028df679 drm/arm/hdlcd: Convert to platform remove callback returning void
1bf3d76a7d15 drm/komeda: Convert to platform remove callback returning void

The following ones appeared to apply to the top of drm-misc-next, but
I didn't apply them since get_maintainer didn't say they were part of
drm-misc-next:

drm/tiny: Convert to platform remove callback returning void
drm/tilcdc: Convert to platform remove callback returning void
drm/sprd: Convert to platform remove callback returning void
drm/shmobile: Convert to platform remove callback returning void
drm/rcar-du: Convert to platform remove callback returning void
drm/omap: Convert to platform remove callback returning void
drm/nouveau: Convert to platform remove callback returning void
drm/mediatek: Convert to platform remove callback returning void
drm/kmb: Convert to platform remove callback returning void
drm/ingenic: Convert to platform remove callback returning void
drm/imx/ipuv3: Convert to platform remove callback returning void
drm/imx/dcss: Convert to platform remove callback returning void
drm/etnaviv: Convert to platform remove callback returning void
drm/armada: Convert to platform remove callback returning void

-Doug
