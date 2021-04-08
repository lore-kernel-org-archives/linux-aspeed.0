From: David Hildenbrand <david@redhat.com>
Date: Thu,  8 Apr 2021 12:05:22 +0200
Subject: [PATCH v2 1/2] drivers/video/fbdev: don't select DMA_CMA
In-Reply-To: <20210408100523.63356-1-david@redhat.com>
References: <20210408100523.63356-1-david@redhat.com>
Message-ID: <20210408100523.63356-2-david@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Random drivers should not override a user configuration of core knobs
(e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
dependencies and manual overrides.

"This is similar to "select" as it enforces a lower limit on another
 symbol except that the "implied" symbol's value may still be set to n
 from a direct dependency or with a visible prompt."

Implying DMA_CMA should be sufficient, as that depends on CMA.

Note: If this is a real dependency, we should use "depends on DMA_CMA"
instead -  but I assume the driver can work without CMA just fine --
esp. when we wouldn't have HAVE_DMA_CONTIGUOUS or CMA right now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 4f02db65dede..d37cd5341e1b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2186,7 +2186,7 @@ config FB_HYPERV
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_DEFERRED_IO
-	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
+	imply DMA_CMA
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
 
-- 
2.30.2

