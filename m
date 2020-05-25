From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 May 2020 15:08:22 +0200
Subject: [PATCH 12/21] drm/mcde: Use GEM CMA object functions
In-Reply-To: <402b57b6-0827-2659-b676-dc633bf6c444@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-13-tzimmermann@suse.de>
 <CACRpkdaHuRHiNjisai2d-karW6y11M2qsPkx5Hn0sfc8T6B_qQ@mail.gmail.com>
 <402b57b6-0827-2659-b676-dc633bf6c444@suse.de>
Message-ID: <CACRpkdZVgbqLmqzvZBAzKvEkYmT=be=d2UxyRMwRXjYDp1mx3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 25, 2020 at 2:51 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 25.05.20 um 13:36 schrieb Linus Walleij:
> > On Fri, May 22, 2020 at 3:52 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> >> The mcde driver uses the default implementation for CMA functions. The
> >> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
> >> All remaining operations are provided by CMA GEM object functions.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Could you boot-test with the patchset applied?

Yes, if you have a git branch I can just build and boot I can
do it quickly!

I have no idea what this patch set is based on so it could be
hard to figure out the dependencies otherwise. Also many
patches.

Yours,
Linus Walleij
