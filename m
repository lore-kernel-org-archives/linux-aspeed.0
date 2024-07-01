From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 14:15:32 -0000
Subject: [PATCH 2/9] mtd: add mtd_is_master helper
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
Message-ID: <20240701-b4-v6-10-topic-usbc-tcpci-v1-2-3fd5f4a193cc@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Provide a simple helper to make it easy to detect an master mtd device.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 include/linux/mtd/mtd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 8d10d9d2e830..bf3fc2ea7230 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -408,6 +408,11 @@ static inline struct mtd_info *mtd_get_master(struct mtd_info *mtd)
 	return mtd;
 }
 
+static inline bool mtd_is_master(struct mtd_info *mtd)
+{
+	return mtd->parent ? false : true;
+}
+
 static inline u64 mtd_get_master_ofs(struct mtd_info *mtd, u64 ofs)
 {
 	while (mtd->parent) {

-- 
2.39.2

