From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 May 2021 02:38:38 +0200
Subject: [PATCH 11/11] drm/tiny: drm_gem_simple_display_pipe_prepare_fb is
 the default
In-Reply-To: <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
References: <20210521090959.1663703-1-daniel.vetter@ffwll.ch>
 <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
Message-ID: <CACRpkdbZf_cTMppxfC4mM6XZ2YySH7dQ0NCY6v_pfwsdRzLPKA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 21, 2021 at 11:10 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> Goes through all the drivers and deletes the default hook since it's
> the default now.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: "Noralf Tr?nnes" <noralf@tronnes.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Emma Anholt <emma@anholt.net>
> Cc: David Lechner <david@lechnology.com>
> Cc: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-aspeed at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: xen-devel at lists.xenproject.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
