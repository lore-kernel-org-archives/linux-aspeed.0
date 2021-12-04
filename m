From: Arnd Bergmann <arnd@kernel.org>
Date: Sat,  4 Dec 2021 18:46:23 +0100
Subject: [PATCH 2/2] drm: aspeed: select CONFIG_DRM_GEM_CMA_HELPER
In-Reply-To: <20211204174637.1160725-1-arnd@kernel.org>
References: <20211204174637.1160725-1-arnd@kernel.org>
Message-ID: <20211204174637.1160725-2-arnd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

The aspeed driver uses the gem_cma_helper code, but does
noto enforce enabling this through Kconfig:

x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2c8): undefined reference to `drm_gem_cma_prime_import_sg_table'
x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2d8): undefined reference to `drm_gem_cma_dumb_create'
x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_crtc.o: in function `aspeed_gfx_pipe_update':
aspeed_gfx_crtc.c:(.text+0xe5): undefined reference to `drm_fb_cma_get_gem_obj'

Add the same 'select' that is used in other such drivers.

Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/aspeed/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
index 36c4a7e86981..024ccab14f88 100644
--- a/drivers/gpu/drm/aspeed/Kconfig
+++ b/drivers/gpu/drm/aspeed/Kconfig
@@ -5,6 +5,7 @@ config DRM_ASPEED_GFX
 	depends on (COMPILE_TEST || ARCH_ASPEED)
 	depends on MMU
 	select DRM_KMS_HELPER
+	select DRM_GEM_CMA_HELPER
 	select DMA_CMA if HAVE_DMA_CONTIGUOUS
 	select CMA if HAVE_DMA_CONTIGUOUS
 	select MFD_SYSCON
-- 
2.29.2

