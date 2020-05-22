From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 May 2020 20:45:43 +0200
Subject: [PATCH 01/21] drm/cma-helper: Rework DRM_GEM_CMA_VMAP_DRIVER_OPS
 macro
In-Reply-To: <CACvgo53YDOD1t4KYOWKiO-q8T639jNbMrZuyTXcbe1FBAfxP+Q@mail.gmail.com>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-2-tzimmermann@suse.de>
 <20200522174835.GA1087580@ravnborg.org>
 <CACvgo53YDOD1t4KYOWKiO-q8T639jNbMrZuyTXcbe1FBAfxP+Q@mail.gmail.com>
Message-ID: <20200522184543.GA1516204@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Emil.

> > Please fix zte/zx_drm_drv.c which also uses DRM_GEM_CMA_VMAP_DRIVER_OPS.
> >
> Isn't DRM_GEM_CMA_VMAP_DRIVER_OPS introduced to zte with the last
> patch in the series?

You are right, I just applied all patches and throw them after my
build script and zte failed.

	Sam
