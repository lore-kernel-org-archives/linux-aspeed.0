From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 29 Aug 2024 14:45:06 +0800
Subject: [PATCH v6 0/2] media: aspeed: Allow to capture from SoC display (GFX)
Message-ID: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 v6 changes:
  - Replace aspeed-video.txt with aspeed,video-engine.yaml.
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
  dt-bindings: media: convert aspeed-video.txt to dt-schema
  media: aspeed: Allow to capture from SoC display (GFX)

 .../bindings/media/aspeed,video-engine.yaml   |  78 ++++++++
 .../bindings/media/aspeed-video.txt           |  33 ---
 drivers/media/platform/aspeed/aspeed-video.c  | 189 +++++++++++++++---
 include/uapi/linux/aspeed-video.h             |   7 +
 4 files changed, 246 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt


base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.25.1

