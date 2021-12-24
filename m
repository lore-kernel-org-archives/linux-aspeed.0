From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 24 Dec 2021 11:13:48 +0700
Subject: [PATCH v6 5/9] regmap: Introduces regmap lock helpers
In-Reply-To: <20211224041352.29405-1-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
Message-ID: <20211224041352.29405-6-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit introduces regmap_acquire/release_lock() functions and makes
them available for drivers that need atomic access of regmap registers

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
Change in v6:
  + First introduced in v6 [Quan]

 drivers/base/regmap/regmap.c | 12 ++++++++++++
 include/linux/regmap.h       |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2d74f9f82aa9..36921309725b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -87,6 +87,18 @@ bool regmap_check_range_table(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_check_range_table);
 
+void regmap_acquire_lock(struct regmap *map)
+{
+	map->lock(map->lock_arg);
+}
+EXPORT_SYMBOL_GPL(regmap_acquire_lock);
+
+void regmap_release_lock(struct regmap *map)
+{
+	map->unlock(map->lock_arg);
+}
+EXPORT_SYMBOL_GPL(regmap_release_lock);
+
 bool regmap_writeable(struct regmap *map, unsigned int reg)
 {
 	if (map->max_register && reg > map->max_register)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 22652e5fbc38..0ed12e6ad4fb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1194,6 +1194,8 @@ int regmap_async_complete(struct regmap *map);
 bool regmap_can_raw_write(struct regmap *map);
 size_t regmap_get_raw_read_max(struct regmap *map);
 size_t regmap_get_raw_write_max(struct regmap *map);
+void regmap_acquire_lock(struct regmap *map);
+void regmap_release_lock(struct regmap *map);
 
 int regcache_sync(struct regmap *map);
 int regcache_sync_region(struct regmap *map, unsigned int min,
-- 
2.28.0

