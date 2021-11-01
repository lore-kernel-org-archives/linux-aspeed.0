From: tommy-huang <tommy_huang@aspeedtech.com>
Date: Mon, 1 Nov 2021 19:01:03 +0800
Subject: [PATCH 0/4] Add Aspeed AST2600 soc display support
Message-ID: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed AST2600 soc diaplay support is added in this patch.
Because some hw designed is changed in this version, add them 
in this patch.

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
  dt-bindings: gpu: Add ASPEED GFX bindings document

 .../devicetree/bindings/gpu/aspeed-gfx.txt    |  1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 18 +++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi              | 11 ++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx.h           |  2 ++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       | 26 ++++++++++++++++---
 5 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.17.1

