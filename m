From: tommy-huang <tommy_huang@aspeedtech.com>
Date: Wed, 17 Nov 2021 13:45:14 +0800
Subject: [PATCH v3 0/4] Add Aspeed AST2600 soc display support
Message-ID: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v3:
  Refine the patch for clear separate purpose.
  Skip to send devicetree patch

v2:
  Remove some unnecessary patch.
  Refine for reviwer request.

v1:
  First add patch.

Joel Stanley (2):
  ARM: dts: aspeed: Add GFX node to AST2600
  ARM: dts: aspeed: ast2600-evb: Enable GFX device

tommy-huang (2):
  drm/aspeed: Update INTR_STS handling
  drm/aspeed: Add AST2600 chip support

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         | 11 +++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx.h      |  1 +
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 15 ++++++++++++++-
 4 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.17.1

