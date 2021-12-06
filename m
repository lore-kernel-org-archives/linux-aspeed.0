From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 6 Dec 2021 09:37:50 +0100
Subject: [PATCH 2/2] drm: aspeed: select CONFIG_DRM_GEM_CMA_HELPER
In-Reply-To: <20211204174637.1160725-2-arnd@kernel.org>
References: <20211204174637.1160725-1-arnd@kernel.org>
 <20211204174637.1160725-2-arnd@kernel.org>
Message-ID: <845d7175-8c35-9061-3751-6292a9336c8f@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Arnd

Am 04.12.21 um 18:46 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The aspeed driver uses the gem_cma_helper code, but does
> noto enforce enabling this through Kconfig:
> 
> x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2c8): undefined reference to `drm_gem_cma_prime_import_sg_table'
> x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_drv.o:(.rodata+0x2d8): undefined reference to `drm_gem_cma_dumb_create'
> x86_64-linux-ld: drivers/gpu/drm/aspeed/aspeed_gfx_crtc.o: in function `aspeed_gfx_pipe_update':
> aspeed_gfx_crtc.c:(.text+0xe5): undefined reference to `drm_fb_cma_get_gem_obj'
> 
> Add the same 'select' that is used in other such drivers.
> 
> Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks! I've added both patches to drm-misc-next.

Best regards
Thomas

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 840 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211206/c06f158c/attachment.sig>
