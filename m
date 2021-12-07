From: Tommy Haung <tommy_huang@aspeedtech.com>
Date: Tue, 7 Dec 2021 18:27:42 +0800
Subject: [PATCH v4 0/6] Add Aspeed AST2600 soc display support
Message-ID: <20211207102749.18118-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: tommy-huang <tommy_huang@aspeedtech.com>

v4:
  Add necessary reset control for ast2600.
  Add chip caps for futher use.
  These code are test on AST2500 and AST2600 by below steps.

  1. Add below config to turn VT and LOGO on.

	CONFIG_TTY=y
	CONFIG_VT=y
	CONFIG_CONSOLE_TRANSLATIONS=y
	CONFIG_VT_CONSOLE=y
	CONFIG_VT_CONSOLE_SLEEP=y
	CONFIG_HW_CONSOLE=y
	CONFIG_VT_HW_CONSOLE_BINDING=y
	CONFIG_UNIX98_PTYS=y
	CONFIG_LDISC_AUTOLOAD=y
	CONFIG_DEVMEM=y
	CONFIG_DUMMY_CONSOLE=y
	CONFIG_FRAMEBUFFER_CONSOLE=y
	CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
	CONFIG_LOGO=y
	CONFIG_LOGO_LINUX_CLUT224=y

  2. The Linux logo will be shown on the screen, when the BMC boot in Linux.

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

tommy-huang (4):
  drm/aspeed: Update INTR_STS handling
  drm/aspeed: Add AST2600 chip support
  drm/aspeed: Add reset and clock for AST2600
  arm:boot:dts:aspeed-g6 Add more gfx reset control

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         | 13 +++++
 drivers/gpu/drm/aspeed/aspeed_gfx.h      | 17 ++++++-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 16 ++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 65 ++++++++++++++++++++++--
 5 files changed, 123 insertions(+), 6 deletions(-)

-- 
2.17.1

