From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 19 Aug 2024 16:08:57 +0800
Subject: [PATCH v5 0/2] media: aspeed: Allow to capture from SoC display (GFX)
Message-ID: <20240819080859.1304671-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 v5 changes:
  - Remove dts.
  - Add doc, aspeed,video.yaml.
  - Simplify aspeed_regmap_lookup.
 v4 changes:
  - Use scoped/cleanup to make aspeed_regmap_lookup simpler.
  - Update dts
 v3 changes:
  - Update for enum_input.
 v2 changes:
  - Update patch subject and comments.

Jammy Huang (2):
  dt-bindings: arm: aspeed: Add aspeed,video binding
  media: aspeed: Allow to capture from SoC display (GFX)

 .../bindings/arm/aspeed/aspeed,video.yaml     |  81 ++++++++
 drivers/media/platform/aspeed/aspeed-video.c  | 189 +++++++++++++++---
 include/uapi/linux/aspeed-video.h             |   7 +
 3 files changed, 249 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.25.1

