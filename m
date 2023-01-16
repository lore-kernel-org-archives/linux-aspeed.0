From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Jan 2023 21:47:07 +0100
Subject: [PATCH 00/22] drm: Remove includes for drm_crtc_helper.h
In-Reply-To: <20230116131235.18917-1-tzimmermann@suse.de>
References: <20230116131235.18917-1-tzimmermann@suse.de>
Message-ID: <Y8W3y32sOpP3D6YX@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas.

On Mon, Jan 16, 2023 at 02:12:13PM +0100, Thomas Zimmermann wrote:
> A lot of source files include drm_crtc_helper.h for its contained
> include statements. This leads to excessive compile-time dependencies.
> 
> Where possible, remove the include statements for drm_crtc_helper.h
> and include the required source files directly. Also remove the
> include statements from drm_crtc_helper.h itself, which doesn't need
> most of them.
With this patchset drm_crtc_helper usage is reduced from 85 places to 35
places. And the 35 places is only .c files.
This is a very nice reduction of bloat! I hope this has a measureable
effect on building times.

I was working on something similar, but that approach only added missing
includes, and did not kill all the unnessesary includes - which I think
is the biggest win here.

All patches are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

For a few of them the r-b is conditional, see the specific comments
posted.


I did a build check here with the archs and config I verifies with.
This covers "alpha arm arm64 sparc64 i386 x86 powerpc s390 riscv sh"
and everything was fine. I have a few specific configs to pull in
drivers that need a bit extra to be built.
So I consider build coverage OK for applying, but it would be nice to
wait a few days for the bots to verify too.

My own work on slimming drm_atomic_helper.h and drm_print.h will be
rebased on top of your work before I continue it.
I need to look into removing unused includes too.

	Sam

> 
> I built this patchset on x86-64, aarch64 and arm. Hopefully I found
> all include dependencies.
> 
> Thanks to Sam Ravnborg for bringing this to my attention.
> 
> Thomas Zimmermann (22):
>   drm/amdgpu: Fix coding style
>   drm: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/amdgpu: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/arm/komeda: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/aspeed: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/ast: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/bridge: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/gma500: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/i2c/ch7006: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/ingenic: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/kmb: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/logicvc: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/nouveau: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/radeon: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/rockchip: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/shmobile: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/sprd: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/sun4i: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/tidss: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/udl: Remove unnecessary include statements for drm_crtc_helper.h
>   drm/vboxvideo: Remove unnecessary include statements for
>     drm_crtc_helper.h
>   drm/crtc-helper: Remove most include statements from drm_crtc_helper.h
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  1 -
>  drivers/gpu/drm/amd/amdgpu/atombios_crtc.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  1 -
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  2 ++
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  1 -
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  1 -
>  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           |  1 -
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |  1 -
>  drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |  1 -
>  drivers/gpu/drm/ast/ast_drv.c                      |  1 -
>  drivers/gpu/drm/ast/ast_main.c                     |  1 -
>  drivers/gpu/drm/ast/ast_mode.c                     |  1 -
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  1 -
>  drivers/gpu/drm/bridge/analogix/anx7625.c          |  1 -
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |  1 -
>  drivers/gpu/drm/bridge/ite-it6505.c                |  1 -
>  drivers/gpu/drm/bridge/ite-it66121.c               |  1 -
>  drivers/gpu/drm/bridge/tc358768.c                  |  1 -
>  drivers/gpu/drm/bridge/tc358775.c                  |  1 -
>  drivers/gpu/drm/drm_crtc_helper.c                  |  1 -
>  drivers/gpu/drm/drm_lease.c                        |  2 +-
>  drivers/gpu/drm/drm_plane_helper.c                 |  1 -
>  drivers/gpu/drm/gma500/cdv_device.c                |  1 +
>  drivers/gpu/drm/gma500/cdv_intel_crt.c             |  2 ++
>  drivers/gpu/drm/gma500/cdv_intel_display.c         |  1 +
>  drivers/gpu/drm/gma500/cdv_intel_dp.c              |  1 +
>  drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |  2 ++
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c            |  2 ++
>  drivers/gpu/drm/gma500/framebuffer.c               |  2 ++
>  drivers/gpu/drm/gma500/gma_display.c               |  2 ++
>  drivers/gpu/drm/gma500/oaktrail_crtc.c             |  1 +
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c             |  2 ++
>  drivers/gpu/drm/gma500/oaktrail_lvds.c             |  1 +
>  drivers/gpu/drm/gma500/psb_device.c                |  1 +
>  drivers/gpu/drm/gma500/psb_intel_display.c         |  3 +++
>  drivers/gpu/drm/gma500/psb_intel_drv.h             |  1 -
>  drivers/gpu/drm/gma500/psb_intel_lvds.c            |  2 ++
>  drivers/gpu/drm/gma500/psb_intel_sdvo.c            |  2 ++
>  drivers/gpu/drm/i2c/ch7006_drv.c                   |  2 ++
>  drivers/gpu/drm/i2c/ch7006_priv.h                  |  1 -
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  1 -
>  drivers/gpu/drm/kmb/kmb_crtc.c                     |  1 -
>  drivers/gpu/drm/kmb/kmb_plane.c                    |  1 -
>  drivers/gpu/drm/logicvc/logicvc_interface.c        |  1 -
>  drivers/gpu/drm/logicvc/logicvc_mode.c             |  1 -
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c            |  1 +
>  drivers/gpu/drm/nouveau/dispnv04/dac.c             |  2 +-
>  drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  2 +-
>  drivers/gpu/drm/nouveau/dispnv04/tvmodesnv17.c     |  1 -
>  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  2 +-
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/head.c            |  1 -
>  drivers/gpu/drm/nouveau/nouveau_drm.c              |  1 -
>  drivers/gpu/drm/nouveau/nouveau_vga.c              |  1 -
>  drivers/gpu/drm/radeon/atombios_crtc.c             |  2 +-
>  drivers/gpu/drm/radeon/atombios_encoders.c         |  1 +
>  drivers/gpu/drm/radeon/r300.c                      |  1 -
>  drivers/gpu/drm/radeon/radeon_asic.c               |  1 -
>  drivers/gpu/drm/radeon/radeon_connectors.c         |  1 +
>  drivers/gpu/drm/radeon/radeon_display.c            |  1 +
>  drivers/gpu/drm/radeon/radeon_drv.c                |  1 -
>  drivers/gpu/drm/radeon/radeon_encoders.c           |  1 -
>  drivers/gpu/drm/radeon/radeon_irq_kms.c            |  1 -
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c        |  2 +-
>  drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |  2 +-
>  drivers/gpu/drm/radeon/radeon_legacy_tv.c          |  1 -
>  drivers/gpu/drm/radeon/radeon_mode.h               |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  1 -
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |  2 ++
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c           |  1 -
>  drivers/gpu/drm/shmobile/shmob_drm_plane.c         |  1 -
>  drivers/gpu/drm/sprd/sprd_dpu.c                    |  1 -
>  drivers/gpu/drm/sprd/sprd_drm.c                    |  1 -
>  drivers/gpu/drm/sprd/sprd_dsi.c                    |  1 -
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |  2 +-
>  drivers/gpu/drm/tidss/tidss_crtc.c                 |  1 -
>  drivers/gpu/drm/tidss/tidss_drv.c                  |  1 -
>  drivers/gpu/drm/tidss/tidss_encoder.c              |  2 +-
>  drivers/gpu/drm/tidss/tidss_kms.c                  |  1 -
>  drivers/gpu/drm/tidss/tidss_plane.c                |  1 -
>  drivers/gpu/drm/udl/udl_drv.c                      |  2 +-
>  drivers/gpu/drm/udl/udl_modeset.c                  |  1 -
>  drivers/gpu/drm/vboxvideo/vbox_drv.c               |  2 +-
>  drivers/gpu/drm/vboxvideo/vbox_main.c              |  1 -
>  include/drm/drm_crtc_helper.h                      | 14 +++++++++-----
>  include/drm/drm_fixed.h                            |  1 +
>  94 files changed, 70 insertions(+), 70 deletions(-)
> 
> 
> base-commit: 68d139b609a97a83e7c231189d4864aba4e1679b
> prerequisite-patch-id: 0aa359f6144c4015c140c8a6750be19099c676fb
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: 3f204510fcbf9530d6540bd8e6128cce598988b6
> -- 
> 2.39.0
