From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sat, 12 Sep 2020 20:33:34 +0200
Subject: [PATCH] MAINTAINERS: make linux-aspeed list remarks consistent
Message-ID: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit f15a3ea80391 ("MAINTAINERS: Add ASPEED BMC GFX DRM driver entry")
does not mention that linux-aspeed at lists.ozlabs.org is moderated for
non-subscribers, but the other three entries for
linux-aspeed at lists.ozlabs.org do.

By 'majority vote' among entries, let us assume it was just missed here and
adjust it to be consistent with others.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on master and next-20200911

Joel, please ack.
David, Daniel, please pick this minor non-urgent clean-up patch.

This patch submission will also show me if linux-aspeed is moderated or
not. I have not subscribed to linux-aspeed and if it shows up quickly in
the archive, the list is probably not moderated; and if it takes longer,
it is moderated, and hence, validating the patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26af84f97353..f2561c3fc9db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5448,7 +5448,7 @@ F:	drivers/gpu/drm/panel/panel-arm-versatile.c
 
 DRM DRIVER FOR ASPEED BMC GFX
 M:	Joel Stanley <joel@jms.id.au>
-L:	linux-aspeed at lists.ozlabs.org
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
-- 
2.17.1

