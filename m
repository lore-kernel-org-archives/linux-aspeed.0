From: John Stultz <john.stultz@linaro.org>
Date: Wed, 3 Jun 2020 22:49:03 -0700
Subject: [PATCH v2 07/23] drm/hisilicon/kirin: Set .dumb_create to
 drm_gem_cma_dumb_create()
In-Reply-To: <20200603083132.4610-8-tzimmermann@suse.de>
References: <20200603083132.4610-1-tzimmermann@suse.de>
 <20200603083132.4610-8-tzimmermann@suse.de>
Message-ID: <CALAqxLWG7XN_A70omeZn03x8zc5aEBrStQDkm8MtUNRxm0sD+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 3, 2020 at 1:31 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> The kirin drivers uses drm_gem_cma_dumb_create_internal() for its
> .dumb_create implementation. The function is meant for internal use
> only by drivers that require additional buffer setup.
>
> Kirin does not do an additional setup, so convert it over to
> drm_gem_cma_dumb_create().
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
