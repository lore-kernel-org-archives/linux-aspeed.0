From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 09:01:45 +0800
Subject: [PATCH] drm/aspeed: Fix vga_pw sysfs output
Message-ID: <20211117010145.297253-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Before the drm driver had support for this file there was a driver that
exposed the contents of the vga password register to userspace. It would
present the entire register instead of interpreting it.

The drm implementation chose to mask of the lower bit, without explaining
why. This breaks the existing userspace, which is looking for 0xa8 in
the lower byte.

Change our implementation to expose the entire register.

Fixes: 696029eb36c0 ("drm/aspeed: Add sysfs for output settings")
Reported-by: Oskar Senft <osk@google.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index b53fee6f1c17..65f172807a0d 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -291,7 +291,7 @@ vga_pw_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (rc)
 		return rc;
 
-	return sprintf(buf, "%u\n", reg & 1);
+	return sprintf(buf, "%u\n", reg);
 }
 static DEVICE_ATTR_RO(vga_pw);
 
-- 
2.33.0

