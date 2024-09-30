From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:20 +0000
Subject: [PATCH 25/45] media: cobalt: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-25-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/pci/cobalt/cobalt-driver.c:263:25-33: opportunity for str_enable_disable(ctrl & 1)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/cobalt/cobalt-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index 6e1a0614e6d0..cff2d29410d4 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -260,7 +260,7 @@ static void msi_config_show(struct cobalt *cobalt, struct pci_dev *pci_dev)
 	u32 adrs_l, adrs_h;
 
 	pci_read_config_word(pci_dev, 0x52, &ctrl);
-	cobalt_info("MSI %s\n", ctrl & 1 ? "enable" : "disable");
+	cobalt_info("MSI %s\n", str_enable_disable(ctrl & 1));
 	cobalt_info("MSI multiple message: Capable %u. Enable %u\n",
 		    (1 << ((ctrl >> 1) & 7)), (1 << ((ctrl >> 4) & 7)));
 	if (ctrl & 0x80)

-- 
2.46.1.824.gd892dcdcdd-goog

