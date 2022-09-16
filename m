From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 16 Sep 2022 12:41:57 +0100
Subject: [PATCH] Add dependency on ARCH_ASPEED
Message-ID: <20220916114157.367094-1-pbrobinson@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The VIDEO_ASPEED is part of the Aspeed silicon so it makes
sense to depend on ARCH_ASPEED and for compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/media/platform/aspeed/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed/Kconfig b/drivers/media/platform/aspeed/Kconfig
index c871eda33570..16c5d8913488 100644
--- a/drivers/media/platform/aspeed/Kconfig
+++ b/drivers/media/platform/aspeed/Kconfig
@@ -4,6 +4,7 @@ comment "Aspeed media platform drivers"
 
 config VIDEO_ASPEED
 	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
+	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.37.3

