From: Manojkiran Eda <manojkiran.eda@gmail.com>
Date: Tue, 19 Mar 2024 09:35:35 -0000
Subject: [PATCH v2 2/4] mtd: Replace module_init with subsys_initcall
In-Reply-To: <20240319093405.39833-1-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
Message-ID: <20240319093405.39833-3-manojkiran.eda@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While engaged in development on the espi kernel device driver[1],
I noticed that the espi flash driver, utilizing the mtd subsystem,
appears to initialize before the mtdcore subsystem registers the
mtd_class. As a result, although the mtd device for espi is created,
it does not populate within the /sys/class/mtd hierarchy.

Given that mtd serves as a subsystem upon which numerous other drivers
rely for infrastructure, it appears logical to adjust the module_init()
call to an alternative priority initcall, subsys_initcall(), thereby
ensuring that the mtd core subsystem is probed prior to the drivers
utilizing its infrastructure.

Although this adjustment alters the initialization ordering, there
exists a slight risk of uncovering implicit initialization ordering
issues. However, I believe it is preferable to prioritize it reasonably
rather than having module_init() in order to maintain the exact old
ordering.

Link : [1] https://lore.kernel.org/openbmc/20240213-espi_driver-v1-1-92741c812843 at gmail.com

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e451b28840d5..cc51c9fb2c1e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2560,7 +2560,7 @@ static void __exit cleanup_mtd(void)
 	idr_destroy(&mtd_idr);
 }
 
-module_init(init_mtd);
+subsys_initcall(init_mtd);
 module_exit(cleanup_mtd);
 
 MODULE_LICENSE("GPL");
-- 
2.40.1

