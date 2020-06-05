From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:16 +0200
Subject: [PATCH v3 12/43] drm/hisilicon/kirin: Set .dumb_create to
 drm_gem_cma_dumb_create()
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-13-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The kirin drivers uses drm_gem_cma_dumb_create_internal() for its
.dumb_create implementation. The function is meant for internal use
only by drivers that require additional buffer setup.

Kirin does not do an additional setup, so convert it over to
drm_gem_cma_dumb_create().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index c339e632522a9..18e57e571e054 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -923,7 +923,7 @@ static struct drm_driver ade_driver = {
 	.fops = &ade_fops,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops = &drm_gem_cma_vm_ops,
-	.dumb_create = drm_gem_cma_dumb_create_internal,
+	.dumb_create = drm_gem_cma_dumb_create,
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
-- 
2.26.2

