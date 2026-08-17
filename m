Return-Path: <linux-aspeed+bounces-4744-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB01EC5B572
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 12:41:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNss00Mxfz2y1Y;
	Mon, 17 Aug 2026 22:41:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786970483;
	cv=none; b=gaF85AH48H/ca22lI3nWDIyvurwuc+Mkp+6K+DKpsa4wnn8rM390Ky1qMp6rRrjyyalCUaqT8mb2E7sqPxYqUx9Q1eclcRP0u1ZZUibuCTfff9v9Ju/SG5KwWfkIE8xiWfZpgfIMlhUxOM1buJ/Rh1tFgwTPU83UWSJfwz6XNFC+O63jcBg+czEqvVg68D/Yk7Csr4M4xKN0VzSdgll4MulSrNbvA55pEXS4rQlTDmfWk01zwfOq5BUY/8ayqLuI1f6+dNOzQnJ/JoEeQ2hW5hZu1ONgDp9dc+oOrspWCBDcUGZ7KQNAugL51ZMZlAW14ndkYKYrKVqIgPrjb/bsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786970483; c=relaxed/relaxed;
	bh=GmMwzgYICEZgaUQS0J4MmV5SSQYrGmVvWfDuKpV65fM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gOkd7V90RciIksddqu4QQXD2SGR44mJ9jX0p3MstQTWZYJAsiKw2i22plHlcWqQAxdRjjzJglJghGRG0SkiP4bnG6xjOXBv8HlyFBHG/iPUHneRpzy3rKF+oGbJqBctjIWlF7bu/uO+l6BPxKQomPndgdJvbD6TN51uuflY5SUiox1KdNqU96JMCkDgAbl7KvrkXZyLiKKMZqnJrx+VXJKCxbLPvnXtSaJrGCeNrCLjRVDz50j/oLX7QivjtUsf+I3QzZo8Gqs9nEjMguVgrwjguWzbKAGbhob79Vg/NzwtXS1moIz0//OKIcEihFkynB5KHhS8Y6A8ct96zq/TG8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ffepjc4w; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ffepjc4w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNsrw2lqvz2xl5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Aug 2026 22:41:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786970481; x=1818506481;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=7X4st2dfy1l8lT+fjQAQC0tAfIF/QQdIXAwtTks4e/k=;
  b=Ffepjc4wywQtL2hcr8Knp/07EtQS7tqiRe2bQDSh3HPAterCYerFBUhV
   X7m0w16pUwl+fpJfamlsxatFQTy6nMyKIdkS6qidSSPS2+TWVP1TNo6jc
   xeYm3bmLYut3eX0J15fO8ficHu6A3YYfBZxa0geuqmBe/FuUypRa1kP0R
   WUTwpuVWmQQxfEjeMi+Npx5iPEQOM7arCevbk0pI5NWcZmbq/vbjZLRk3
   tPmezGmx/malC4F1rIAXkeY2F32YAnfSqBNYIhtnOgzQ52ky70dXwWGsD
   GdZEcHMkkGB80UtS0UC+cdDXRzAQWigoirjDm3KBMNwnRRMrd/sgkugaX
   Q==;
X-CSE-ConnectionGUID: K5Ta7IJZTDWPl3JzNZlffA==
X-CSE-MsgGUID: 9ZFxrfORRYy7f5XyNdJWDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98598086"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98598086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 05:41:10 -0700
X-CSE-ConnectionGUID: kO9/n7EERguTo2l7wfOCtw==
X-CSE-MsgGUID: 7ox5dl61Tw6To4e/rrOiGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="266887598"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.110])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 05:41:05 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-sunxi@lists.linux.dev, asahi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-mediatek@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 linux-aspeed@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 imx@lists.linux.dev
Subject: Re: [PATCH 0/5] drm/vblank: Enforce all-or-nothing vblank support
In-Reply-To: <20260814203542.1405135-1-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260814203542.1405135-1-lyude@redhat.com>
Date: Mon, 17 Aug 2026 15:41:02 +0300
Message-ID: <5f06e91a5ff0e5bb887b72e4ff9077c45cd9216e@intel.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 14 Aug 2026, Lyude Paul <lyude@redhat.com> wrote:
> One of the oddities with DRM that is leftover from the old days is how
> vblank support is implemented by drivers. This has caused some minor
> issues for the rust bindings for KMS which could be worked around.
> However, it seems like a much better idea to fix this on the C side.
> Those oddities are mainly:
>
> * There's nothing in the vblank core that actually ensures that all
>   CRTCs implement vblank support if one of them do. On Rust's side, we
>   can't have this and have to ensure either the whole device has vblank
>   support or not - otherwise it would be quite painful ensuring we don't
>   expose vblank methods to drivers that can't use them.
>   This additionally means such a situation would lead to UB.
> * There is a second variable for keeping track of the number of CRTCs
>   and it's kind of broken and confusing. Even worse, we currently allow
>   the vblank API to allow a driver to specify a different number of
>   CRTCs then it actually has.
>
> So, let's just go ahead and fix this across the whole tree, and enforce
> that a driver must either implement hardware vblank support for all
> CRTCs or no CRTCs.

For i915, the relevant init order is currently:

- drm_vblank_init()
- drm_mode_config_init()
- drm_crtc_init_with_planes() for each CRTC

For the patch series to work, drm_vblank_init() would have to happen
after mode config and CRTC init. Off-hand, I couldn't say if there are
dependencies that make this change difficult.

I'd be surprised if i915 were the only driver like this.


BR,
Jani.

>
> Lyude Paul (5):
>   drm/vblank: Add drm_device.has_hw_vblank
>   drm/vblank: Remove drm->num_crtcs
>   drm/vblank: Remove num_crtcs argument from drm_vblank_init()
>   drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()
>   drm/vblank: Require all CRTCs implement vblank support in
>     drm_vblank_init()
>
>  drivers/gpu/drm/adp/adp_drv.c                 |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
>  drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
>  drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
>  drivers/gpu/drm/armada/armada_drv.c           |  2 +-
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
>  drivers/gpu/drm/drm_vblank.c                  | 60 ++++++++++++-------
>  drivers/gpu/drm/exynos/exynos_drm_drv.c       |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
>  drivers/gpu/drm/gma500/psb_drv.c              |  2 +-
>  drivers/gpu/drm/gma500/psb_irq.c              |  4 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |  2 +-
>  .../drm/i915/display/intel_display_driver.c   |  3 +-
>  drivers/gpu/drm/imx/dc/dc-kms.c               |  2 +-
>  drivers/gpu/drm/imx/dcss/dcss-kms.c           |  2 +-
>  drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |  2 +-
>  drivers/gpu/drm/imx/lcdc/imx-lcdc.c           |  2 +-
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  2 +-
>  drivers/gpu/drm/kmb/kmb_drv.c                 |  2 +-
>  drivers/gpu/drm/logicvc/logicvc_mode.c        |  2 +-
>  drivers/gpu/drm/loongson/lsdc_drv.c           |  2 +-
>  drivers/gpu/drm/mcde/mcde_drv.c               |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
>  drivers/gpu/drm/meson/meson_drv.c             |  2 +-
>  drivers/gpu/drm/msm/msm_kms.c                 |  2 +-
>  drivers/gpu/drm/mxsfb/lcdif_drv.c             |  2 +-
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_display.c     |  2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
>  drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
>  drivers/gpu/drm/qxl/qxl_display.c             |  2 +-
>  drivers/gpu/drm/radeon/atombios_crtc.c        |  4 +-
>  drivers/gpu/drm/radeon/radeon_irq_kms.c       |  2 +-
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c   |  4 +-
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  2 +-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  2 +-
>  .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  2 +-
>  drivers/gpu/drm/sprd/sprd_drm.c               |  2 +-
>  drivers/gpu/drm/sti/sti_compositor.c          |  2 +-
>  drivers/gpu/drm/stm/ltdc.c                    |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
>  drivers/gpu/drm/tegra/drm.c                   |  2 +-
>  drivers/gpu/drm/tidss/tidss_kms.c             |  2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  2 +-
>  drivers/gpu/drm/tiny/bochs.c                  |  2 +-
>  drivers/gpu/drm/tiny/cirrus-qemu.c            |  2 +-
>  drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
>  drivers/gpu/drm/vc4/vc4_kms.c                 |  6 +-
>  drivers/gpu/drm/verisilicon/vs_drm.c          |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_display.c      |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c               |  3 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c          |  2 +-
>  drivers/gpu/drm/xlnx/zynqmp_kms.c             |  2 +-
>  include/drm/drm_device.h                      | 10 +++-
>  include/drm/drm_vblank.h                      |  2 +-
>  64 files changed, 114 insertions(+), 92 deletions(-)
>
>
> base-commit: 568d4cb5dcc5ec4e22975699b6ea67a30806884c

-- 
Jani Nikula, Intel

