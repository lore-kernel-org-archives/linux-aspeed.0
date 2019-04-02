From: Joel Stanley <joel@jms.id.au>
Date: Tue,  2 Apr 2019 12:49:33 +1030
Subject: [PATCH v2 3/3] MAINTAINERS: Add ASPEED BMC GFX DRM driver entry
In-Reply-To: <20190402021933.13071-1-joel@jms.id.au>
References: <20190402021933.13071-1-joel@jms.id.au>
Message-ID: <20190402021933.13071-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This hardware is found inside ASPEED Baseboard Management Controller
(BMC) system on chips. It is called the 'SOC Display Controller' or 'GFX'.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c18f5f10cf91..c3ad730e26f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4909,6 +4909,14 @@ M:	Dave Airlie <airlied@redhat.com>
 S:	Odd Fixes
 F:	drivers/gpu/drm/ast/
 
+DRM DRIVER FOR ASPEED BMC GFX
+M: 	Joel Stanley <joel@jms.id.au>
+L:	linux-aspeed at lists.ozlabs.org
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Supported
+F:	drivers/gpu/drm/aspeed/
+F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+
 DRM DRIVER FOR BOCHS VIRTUAL GPU
 M:	Gerd Hoffmann <kraxel@redhat.com>
 L:	virtualization at lists.linux-foundation.org
-- 
2.20.1

