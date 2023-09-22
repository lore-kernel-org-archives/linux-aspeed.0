From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 22 Sep 2023 15:34:06 -0700
Subject: [PATCH RESEND] MAINTAINERS: aspeed: Update git tree URL
Message-ID: <20230922223405.24717-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The description for joel/aspeed.git on git.kernel.org currently says:

    Old Aspeed tree. Please see joel/bmc.git

Let's update MAINTAINERS accordingly.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b8a9749cb0b..b54f2a42a898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1968,7 +1968,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
 F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
-- 
2.42.0

