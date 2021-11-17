From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Wed, 17 Nov 2021 06:55:27 +0000
Subject: [PATCH v3 0/4] Add Aspeed AST2600 soc display support
In-Reply-To: <CACPK8XdUHZBAwcwT96Su+Fa_nenYSa75vCNpskh864Cvx04y8Q@mail.gmail.com>
References: <20211117054518.3555-1-tommy_huang@aspeedtech.com>
 <CACPK8XdUHZBAwcwT96Su+Fa_nenYSa75vCNpskh864Cvx04y8Q@mail.gmail.com>
Message-ID: <HK2PR0601MB2033D57AED42522155074B96E19A9@HK2PR0601MB2033.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

	Got it. I will change user name for next patch send.

	The ast2600 is tested on my platform.
	And I will try this on the ast2500.
	Below is testing steps:

	1. Apply the patch into project.
	2. Add below config for VT and LOGO on.

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

	3. The Linux logo will be shown on the screen, when the BMC boot in Linux.

	Thanks,

	By Tommy
> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Wednesday, November 17, 2021 2:06 PM
> To: Tommy Huang <tommy_huang@aspeedtech.com>
> Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Rob
> Herring <robh+dt@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; open list:DRM DRIVERS
> <dri-devel@lists.freedesktop.org>; devicetree <devicetree@vger.kernel.org>;
> Linux ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v3 0/4] Add Aspeed AST2600 soc display support
> 
> On Wed, 17 Nov 2021 at 05:45, tommy-huang
> <tommy_huang@aspeedtech.com> wrote:
> >
> > v3:
> >   Refine the patch for clear separate purpose.
> >   Skip to send devicetree patch
> 
> Thanks Tommy. A few things:
> 
>  - Set up your authorship in git:
> 
>  git config --global user.name "Tommy Haung"
> 
> - The "Add AST2600 chip support" patch is the same as the one I sent, you can
> put mine back in your series now
> 
> - We should add a device tree bindings document
> 
> Can you confirm you tested these changes on both the ast2500 and the
> ast2600? How did you test?
> 
> Cheers,
> 
> Joel
> 
> 
> >
> > v2:
> >   Remove some unnecessary patch.
> >   Refine for reviwer request.
> >
> > v1:
> >   First add patch.
> >
> > Joel Stanley (2):
> >   ARM: dts: aspeed: Add GFX node to AST2600
> >   ARM: dts: aspeed: ast2600-evb: Enable GFX device
> >
> > tommy-huang (2):
> >   drm/aspeed: Update INTR_STS handling
> >   drm/aspeed: Add AST2600 chip support
> >
> >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
> >  arch/arm/boot/dts/aspeed-g6.dtsi         | 11 +++++++++++
> >  drivers/gpu/drm/aspeed/aspeed_gfx.h      |  1 +
> >  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 15 ++++++++++++++-
> >  4 files changed, 44 insertions(+), 1 deletion(-)
> >
> > --
> > 2.17.1
> >
