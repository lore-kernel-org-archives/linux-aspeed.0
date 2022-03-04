From: Tommy Haung <tommy_huang@aspeedtech.com>
Date: Fri, 4 Mar 2022 14:31:35 +0800
Subject: [PATCH v1 0/2] Add 1024x768 timing for AST2600
Message-ID: <20220304063137.12970-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v1: 
  Add 1024x768 at 70Hz for AST2600 soc display timing selection.
  Add gfx flag for future usage.

Testing steps:

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
  3. Check the display mode is 1024x768 at 70Hz at AST2600.
  4. Check the display mode is 800x600 at 60Hz at AST2500.

Tommy Haung (2):
  drm/aspeed: Add gfx flags and clock selection for AST2600
  drm/aspeed: Add 1024x768 mode for AST2600

 drivers/gpu/drm/aspeed/aspeed_gfx.h      | 15 ++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 20 ++++++++++++--
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c  | 14 +++++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.17.1

