From: tommy-huang <tommy_huang@aspeedtech.com>
Date: Tue, 28 Sep 2021 10:56:57 +0800
Subject: [PATCH 0/6] *** Add AST2600 GFX node ***
Message-ID: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add AST2600 GFX support first.

Joel Stanley (5):
  ARM: dts: aspeed: Add GFX node to AST2600
  ARM: dts: aspeed: ast2600-evb: Enable GFX device
  drm/aspeed: Add AST2600 support
  HACK: drm/aspeed: INTR_STS hadndling
  HACK: drm/aspeed: Paramterise modes

tommy-huang (1):
  dt-bindings: gpu: Add ASPEED GFX bindings document

 .../devicetree/bindings/gpu/aspeed-gfx.txt     |  1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts       | 13 +++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi               | 11 +++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c        | 18 +++++++++++++-----
 4 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.17.1

