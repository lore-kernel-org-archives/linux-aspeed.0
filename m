From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 14 Aug 2024 08:54:19 +0800
Subject: [PATCH v4 0/2] media: aspeed: Allow to capture from SoC display (GFX)
Message-ID: <20240814005421.3362441-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aim of this series is to add another capture source, SoC
Display(GFX), for video.

 v4 changes:
  - Use scoped/cleanup to make aspeed_regmap_lookup simpler.
  - Update dts
 v3 changes:
  - Update for enum_input.
 v2 changes:
  - Update patch subject and comments.

Jammy Huang (2):
  ARM: dts: aspeed: Add properties of scu and gfx for video
  media: aspeed: Allow to capture from SoC display (GFX)

 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi      |   2 +
 drivers/media/platform/aspeed/aspeed-video.c | 192 ++++++++++++++++---
 include/uapi/linux/aspeed-video.h            |   7 +
 3 files changed, 173 insertions(+), 28 deletions(-)


base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
-- 
2.25.1

