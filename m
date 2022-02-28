From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Feb 2022 09:53:06 +0000
Subject: [PATCH v5 0/7] Add Aspeed AST2600 soc display support
In-Reply-To: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
Message-ID: <CACPK8XcTDUt8q+5s44nnFFK1XiisXw=PBoGaNZowGS7M-j=Phg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

On Wed, 8 Dec 2021 at 01:34, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
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

Sorry for the long delay. I have tested your patches on an ast2600a3
evb and they worked. I have some questions about the reset lines that
I couldn't answer by reading the datasheet, so once they are cleared
up we can go ahead with merging your patches.

When you re-send, you will need to fix your git configuration so your
name appears correctly:

git config --global user.name "Tommy Haung"

And then for each patch, do this to fix up the authorship and the s-o-b line:

git commit --amend --reset-author -s

Cheers,

Joel



>
> v3:
>   Refine the patch for clear separate purpose.
>   Skip to send devicetree patch
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
> Tommy Haung (1):
>   dt-bindings:ast2600-clock Add CRT reset define
>
> tommy-huang (4):
>   drm/aspeed: Update INTR_STS handling
>   drm/aspeed: Add AST2600 chip support
>   drm/aspeed: Add reset and clock for AST2600
>   arm:boot:dts:aspeed-g6 Add more gfx reset control
>
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts  | 18 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi          | 13 +++++
>  drivers/gpu/drm/aspeed/aspeed_gfx.h       | 17 +++++-
>  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c  | 16 ++++++
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c   | 65 +++++++++++++++++++++--
>  include/dt-bindings/clock/ast2600-clock.h |  1 +
>  6 files changed, 124 insertions(+), 6 deletions(-)
>
> --
> 2.17.1
>
