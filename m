From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Mar 2022 03:09:02 +0000
Subject: [PATCH v6 0/5] Add Aspeed AST2600 soc display support
In-Reply-To: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
References: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
Message-ID: <CACPK8XdKH5BaGC9mtgg17ndiJyOneuzzUbrLmxYZKmi6RRzzpg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Mar 2022 at 02:49, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
>
> v6:
>   Remove some unnecessary reset patch.
>   Refine patch format.
>   Add detail explain of SOC display reset bits.
>
> v5:
>   Add lost reset define.
>
> v4:
>   Add necessary reset control for ast2600.
>   Add chip caps for futher use.
>   These code are test on AST2500 and AST2600 by below steps.
>
>   1. Add below config to turn VT and LOGO on.
>
>         CONFIG_TTY=y
>         CONFIG_VT=y
>         CONFIG_CONSOLE_TRANSLATIONS=y
>         CONFIG_VT_CONSOLE=y
>         CONFIG_VT_CONSOLE_SLEEP=y
>         CONFIG_HW_CONSOLE=y
>         CONFIG_VT_HW_CONSOLE_BINDING=y
>         CONFIG_UNIX98_PTYS=y
>         CONFIG_LDISC_AUTOLOAD=y
>         CONFIG_DEVMEM=y
>         CONFIG_DUMMY_CONSOLE=y
>         CONFIG_FRAMEBUFFER_CONSOLE=y
>         CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>         CONFIG_LOGO=y
>         CONFIG_LOGO_LINUX_CLUT224=y
>
>   2. The Linux logo will be shown on the screen, when the BMC boot in Linux.
>
> v3:
>   Refine the patch for clear separate purpose.
>   Skip to send devicetree patch

Looks good! Thanks Tommy.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll apply this once I've tested it on hardware.

>
> v2:
>   Remove some unnecessary patch.
>   Refine for reviwer request.
>
> v1:
>   First add patch.
>
> Joel Stanley (2):
>   ARM: dts: aspeed: Add GFX node to AST2600
>   ARM: dts: aspeed: ast2600-evb: Enable GFX device
>
> Tommy Haung (3):
>   drm/aspeed: Update INTR_STS handling
>   drm/aspeed: Add AST2600 chip support
>   ARM: dtsi: aspeed: Modified gfx reset control
>
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi         | 11 +++++++++++
>  drivers/gpu/drm/aspeed/aspeed_gfx.h      |  1 +
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 15 ++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
