From: John Stultz <john.stultz@linaro.org>
Date: Wed, 3 Jun 2020 22:49:31 -0700
Subject: [PATCH v2 08/23] drm/hisilicon/kirin: Use GEM CMA object functions
In-Reply-To: <20200603083132.4610-9-tzimmermann@suse.de>
References: <20200603083132.4610-1-tzimmermann@suse.de>
 <20200603083132.4610-9-tzimmermann@suse.de>
Message-ID: <CALAqxLWnxsv8wuMjAWw=MAcf+2oyFLH2M=Av7owZCMgUpQexNw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 3, 2020 at 1:31 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> The kirin driver uses the default implementation for CMA functions. The
> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
>
> Using DRM_GEM_CMA_DRIVER_OPS introduces several changes: the driver now
> sets .gem_create_object to drm_cma_gem_create_object_default_funcs(),
> which sets CMA GEM object functions. GEM object functions implement the
> rsp operations where possible. Corresponding interfaces in struct drm_driver
> are cleared. Prime import now uses drm_gem_cma_prime_import_sg_table_vmap(),
> which maps the imported buffer upon import. Mmap operations are performed
> by drm_gem_prime_mmap(), which goes through GEM file operations. These
> changes have been part of the aspeed driver for some time.
>
> v2:
>         * use DRM_GEM_CMA_DRIVER_OPS
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Emil Velikov <emil.velikov@collabora.com>
> Cc: Xu YiPing <xuyiping@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>

Thanks for sending this out! Works fine on my HiKey board.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
