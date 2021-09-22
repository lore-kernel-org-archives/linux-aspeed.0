From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:15 +0800
Subject: [PATCH 09/10] dt-bindings: mmc: aspeed: Add max-tap-delay property
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20210922103116.30652-10-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add max-tap-delay proptery in order to record the maximum
tap delay on different platforms.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..5bb66849df65 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -37,6 +37,9 @@ properties:
   clocks:
     maxItems: 1
     description: The SD/SDIO controller clock gate
+  max-tap-delay:
+    maxItems: 1
+    description: The maximum delay in picosecond for SD/SDIO controller
 
 patternProperties:
   "^sdhci@[0-9a-f]+$":
-- 
2.17.1

