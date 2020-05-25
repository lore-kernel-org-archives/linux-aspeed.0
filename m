From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 May 2020 13:36:43 +0200
Subject: [PATCH 20/21] drm/tv200: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-21-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-21-tzimmermann@suse.de>
Message-ID: <CACRpkdacQd71UqyU5QcnSemfR7M+fA9hf-tahzTtyKgK4wV9Sg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2020 at 3:53 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:

> The tve200 driver uses the default implementation for CMA functions. The
> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
> All remaining operations are provided by CMA GEM object functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
