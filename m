From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 8 Apr 2021 13:16:59 +0300
Subject: [PATCH v2 0/2] drivers: don't select DMA_CMA or CMA
In-Reply-To: <20210408100523.63356-1-david@redhat.com>
References: <20210408100523.63356-1-david@redhat.com>
Message-ID: <YG7YGxN83VxtKAeo@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 08, 2021 at 12:05:21PM +0200, David Hildenbrand wrote:
> Trying to set CONFIG_CMA=y with CONFIG_DMA_CMA=n revealed that we have
> three drivers that select these options. Random drivers should not
> override user settings of such core knobs. Let's use "imply DMA_CMA"
> instead, such that user configuration and dependencies are respected.
> 
> v1 -> v2:
> - Fix DRM_CMA -> DMA_CMA
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Russell King <linux+etnaviv@armlinux.org.uk>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: linux-aspeed at lists.ozlabs.org
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: etnaviv at lists.freedesktop.org
> Cc: linux-fbdev at vger.kernel.org
> 
> David Hildenbrand (2):
>   drivers/video/fbdev: don't select DMA_CMA
>   drivers/gpu/drm: don't select DMA_CMA or CMA from aspeed or etnaviv
> 
>  drivers/gpu/drm/aspeed/Kconfig  | 3 +--
>  drivers/gpu/drm/etnaviv/Kconfig | 3 +--
>  drivers/video/fbdev/Kconfig     | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
