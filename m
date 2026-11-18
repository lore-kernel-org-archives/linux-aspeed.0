Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE378606A320
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESWCC2lt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV2VP0p06z2xSl;
	Thu, 19 Nov 2026 00:28:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795008509;
	cv=none; b=YoTcR8gAPxx2r9s1LtYFt+SkSqPM4p4kWOYujL7MsdFCRQihPL1IhewEVa/weVhyTXnlIo5Rnach6ZqLnvPG1zThrEKr3j8MTtgrSE0ZyD66RgG7eiIWDKerjDd+hBj4lXMkcygWG8o+FYNsJ/qzcH/J3fpIq9AOcByrx26ro09EffiVN2AAoJwIe0fWve+Xenx2J2Nep8ch7/1iI0BOqECX9n8br47FxZ/SOpoZNFHYZMfSzVA/K1h9sz+tGUXxJWYf/hSEG+dfvdnm6hKgMjlFtpWA264hPy1EQy+2ouKNWSt1puI5A/Yo/PAe/j9jFe4AXobmUWKKFQGDQMVK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795008509; c=relaxed/relaxed;
	bh=xrbOr3k8zHV2i5uttrL4VksfyxzivrA+exHcMjQwxoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMwk7HIUqVX7RpBtYC4Wc18W4wbJs/EjIay9um6P8FXbSr+GXPKjPkTd80Bk2/utxJ37IXeXzVyoG/DLez4qiMnCtyjAakWF3HRIQdurpeQfIjoRGfPK188SISMD02szuOf4DFoo0qgqD4dA9y8w0046OijwaMFjdzLlIM3I3N5fSDxGSILAQNhdgzNN/L7cnB6l7nDChyVSMwXsXBnOOvck0Xdz2TYWiqq8kFYlH9a3zldSr7CiNHWu0+TKCyqeY0+UYk737p43ldyu0yFtZJolWWnbATQuH+SrvPUMfapR5Lyd7Kn82bPjHnB/i50AqiV4IzBE5fSjYZlxk0DkEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESWCC2lt; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ESWCC2lt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV2VK4LcZz2xL4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 00:28:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795008506; x=1826544506;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=9s0PP2tU8ramnQ9P7B7e47VS/Lqt+TFQgn/D6GHoCw4=;
  b=ESWCC2ltlFqh2ubh3obxKOhrmzeaqKT5YzFf/p+I7Rgh7BqNtmyilM/V
   XhnoQ/aDYLezT9YpCRzWGTLOVfNcJsSwn8/Rso4aAemkmXIqZ+6Ee5q6Z
   FvFMULABWhOnQ0NW8H4/k2S9EeEPB+uCdbthSd2bXK+713KIHKiSL3+TB
   EYj9h+x8hcHusGbjc7hgqdQGmrwjf3vKzSnLm1moi1lciQi+uQ5XOaaSh
   BE5ns8l1YXLRfKpAvIGPx9coE129GZIUzNzEus0jHe8Sbgklqof8BMOvt
   1SBZcuKT2VNGjKWK9xVW9haBqbzv3UaI6ImuOU5DEk3hgf4WMxj218IiL
   g==;
X-CSE-ConnectionGUID: ZNV61HDMS5+DzgcAfFQhHA==
X-CSE-MsgGUID: r73JrGcYSvSi0vODwXfwWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3818344"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3818344"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 05:28:21 -0800
X-CSE-ConnectionGUID: yZhr9dpARI60OAP4iow+yA==
X-CSE-MsgGUID: +rfdIahmSKCYwfI5yMV7+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10544495"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 05:27:43 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, David
 Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sasha Finkelstein <k@chaosmail.tech>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
 asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-riscv@lists.infradead.org, etnaviv@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imagination@lists.freedesktop.org,
 linux-mips@vger.kernel.org, lima@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
In-Reply-To: <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1795002467.git.ukleinek@kernel.org>
 <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
Date: Wed, 18 Nov 2026 15:27:40 +0200
Message-ID: <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> w=
rote:
> These arrays already mostly match the most used and generally
> recommended coding style. That is:
>
>  - list terminators in a single line;
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator (unless there is a comment);
>  - proper tab indentation for multi-line initializers;
>
> Adapt the offenders accordingly.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/gpu/drm/adp/adp-mipi.c                |   4 +-
>  drivers/gpu/drm/adp/adp_drv.c                 |   4 +-
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |   8 +-
>  drivers/gpu/drm/arm/hdlcd_drv.c               |   4 +-
>  drivers/gpu/drm/arm/malidp_drv.c              |   8 +-
>  drivers/gpu/drm/armada/armada_crtc.c          |   2 +-
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |   2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |   4 +-
>  .../drm/bridge/analogix/analogix-anx6345.c    |   4 +-
>  .../drm/bridge/analogix/analogix-anx78xx.c    |   2 +-
>  drivers/gpu/drm/bridge/analogix/anx7625.c     |   4 +-
>  drivers/gpu/drm/bridge/chipone-icn6211.c      |   2 +-
>  drivers/gpu/drm/bridge/chrontel-ch7033.c      |   2 +-
>  drivers/gpu/drm/bridge/display-connector.c    |   2 +-
>  drivers/gpu/drm/bridge/fsl-ldb.c              |  23 +-
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |   7 +-
>  .../drm/bridge/imx/imx8qxp-pixel-combiner.c   |   4 +-
>  .../gpu/drm/bridge/imx/imx8qxp-pixel-link.c   |   4 +-
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c  |   2 +-
>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c   |   2 +-
>  drivers/gpu/drm/bridge/imx/imx93-pdfc.c       |   4 +-
>  drivers/gpu/drm/bridge/ite-it6263.c           |   2 +-
>  drivers/gpu/drm/bridge/lontium-lt8912b.c      |   4 +-
>  drivers/gpu/drm/bridge/lontium-lt9211.c       |   2 +-
>  drivers/gpu/drm/bridge/lvds-codec.c           |   2 +-
>  .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |   4 +-
>  drivers/gpu/drm/bridge/microchip-lvds.c       |   6 +-
>  drivers/gpu/drm/bridge/nwl-dsi.c              |   2 +-
>  drivers/gpu/drm/bridge/nxp-ptn3460.c          |   2 +-
>  drivers/gpu/drm/bridge/parade-ps8622.c        |   6 +-
>  drivers/gpu/drm/bridge/sii902x.c              |   2 +-
>  drivers/gpu/drm/bridge/sii9234.c              |   2 +-
>  drivers/gpu/drm/bridge/sil-sii8620.c          |   2 +-
>  drivers/gpu/drm/bridge/tc358767.c             |   2 +-
>  drivers/gpu/drm/bridge/tc358768.c             |   4 +-
>  drivers/gpu/drm/bridge/tc358775.c             |   4 +-
>  drivers/gpu/drm/bridge/tda998x_drv.c          |   2 +-
>  drivers/gpu/drm/bridge/th1520-dw-hdmi.c       |   2 +-
>  drivers/gpu/drm/bridge/thc63lvd1024.c         |   4 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c         |   2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c         |   4 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c            |   2 +-
>  drivers/gpu/drm/bridge/ti-tpd12s015.c         |   4 +-
>  drivers/gpu/drm/bridge/waveshare-dsi.c        |   4 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |   2 +-
>  drivers/gpu/drm/exynos/exynos5433_drm_decon.c |   6 +-
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c    |   2 +-
>  drivers/gpu/drm/exynos/exynos_dp.c            |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c      |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c      |  33 +-
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c       |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c       |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c   |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c    |   2 +-
>  drivers/gpu/drm/exynos/exynos_hdmi.c          |   5 +-
>  drivers/gpu/drm/exynos/exynos_mixer.c         |  15 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |   2 +-
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c  |   2 +-
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |   7 +-
>  .../drm/i915/display/intel_display_device.c   |   2 +-
>  .../gpu/drm/i915/display/intel_lpe_audio.c    |   6 +-
>  drivers/gpu/drm/i915/i915_pci.c               |   2 +-
>  drivers/gpu/drm/imagination/pvr_drv.c         |   2 +-
>  drivers/gpu/drm/imx/dc/dc-drv.c               |   2 +-
>  drivers/gpu/drm/imx/dc/dc-ic.c                |   2 +-
>  drivers/gpu/drm/imx/dc/dc-pe.c                |   2 +-
>  drivers/gpu/drm/imx/dcss/dcss-drv.c           |   4 +-
>  drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c       |  11 +-
>  drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |   4 +-
>  drivers/gpu/drm/imx/ipuv3/imx-ldb.c           |   4 +-
>  drivers/gpu/drm/imx/ipuv3/imx-tve.c           |   2 +-
>  drivers/gpu/drm/imx/ipuv3/parallel-display.c  |   2 +-
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |   2 +-
>  drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c     |   2 +-
>  drivers/gpu/drm/ingenic/ingenic-ipu.c         |   2 +-
>  drivers/gpu/drm/kmb/kmb_drv.c                 |   4 +-
>  drivers/gpu/drm/lima/lima_drv.c               |   2 +-
>  drivers/gpu/drm/logicvc/logicvc_drm.c         |   2 +-
>  drivers/gpu/drm/mcde/mcde_drv.c               |   2 +-
>  drivers/gpu/drm/mcde/mcde_dsi.c               |   2 +-
>  drivers/gpu/drm/mediatek/mtk_cec.c            |   4 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     |  14 +-
>  drivers/gpu/drm/mediatek/mtk_disp_color.c     |  20 +-
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c     |  20 +-
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   4 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  50 ++-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  26 +-
>  drivers/gpu/drm/mediatek/mtk_dp.c             |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dpi.c            |   2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 395 +++++++++++-------
>  drivers/gpu/drm/mediatek/mtk_ethdr.c          |   4 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c       |   4 +-
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |   4 +-
>  drivers/gpu/drm/meson/meson_drv.c             |  28 +-
>  drivers/gpu/drm/meson/meson_dw_hdmi.c         |  24 +-
>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.c     |   2 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c    |   2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  70 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      |   6 +-
>  drivers/gpu/drm/msm/dp/dp_display.c           |   2 +-
>  drivers/gpu/drm/msm/dsi/dsi.c                 |   2 +-
>  drivers/gpu/drm/msm/hdmi/hdmi.c               |   2 +-
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c           |  38 +-
>  drivers/gpu/drm/msm/msm_drv.c                 |   2 +-
>  drivers/gpu/drm/msm/msm_mdss.c                |   2 +-
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c             |   6 +-
>  drivers/gpu/drm/nouveau/nouveau_drm.c         |   2 +-
>  drivers/gpu/drm/omapdrm/dss/dispc.c           |   2 +-
>  drivers/gpu/drm/omapdrm/dss/dsi.c             |   8 +-
>  drivers/gpu/drm/omapdrm/dss/dss.c             |   2 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c           |   4 +-
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c           |   6 +-
>  drivers/gpu/drm/omapdrm/dss/venc.c            |   8 +-
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c      |   2 +-
>  drivers/gpu/drm/panel/panel-arm-versatile.c   |   4 +-
>  drivers/gpu/drm/panel/panel-boe-himax8279d.c  |   4 +-
>  .../drm/panel/panel-boe-th101mb31ig002-28a.c  |   4 +-
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  47 ++-
>  drivers/gpu/drm/panel/panel-dsi-cm.c          |   2 +-
>  drivers/gpu/drm/panel/panel-edp.c             |   5 +-
>  .../gpu/drm/panel/panel-feixin-k101-im2ba02.c |   2 +-
>  .../drm/panel/panel-feiyang-fy07024di26a30d.c |   2 +-
>  .../gpu/drm/panel/panel-focaltech-ota7290b.c  |   4 +-
>  drivers/gpu/drm/panel/panel-himax-hx83102.c   |  47 ++-
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  17 +-
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c |  11 +-
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  30 +-
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c |   2 +-
>  .../gpu/drm/panel/panel-jdi-lt070me05000.c    |   2 +-
>  drivers/gpu/drm/panel/panel-khadas-ts050.c    |   4 +-
>  .../drm/panel/panel-kingdisplay-kd097d04.c    |   2 +-
>  drivers/gpu/drm/panel/panel-lg-lb035q02.c     |   4 +-
>  drivers/gpu/drm/panel/panel-lg-sw43408.c      |   4 +-
>  .../gpu/drm/panel/panel-lincolntech-lcd197.c  |   2 +-
>  drivers/gpu/drm/panel/panel-lvds.c            |   4 +-
>  .../drm/panel/panel-magnachip-d53e6ea8966.c   |   2 +-
>  drivers/gpu/drm/panel/panel-nec-nl8048hl11.c  |   4 +-
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c |   2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c |   2 +-
>  .../gpu/drm/panel/panel-novatek-nt36672a.c    |   2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt36850.c |   2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt37801.c |   2 +-
>  .../drm/panel/panel-osd-osd101t2587-53ts.c    |   5 +-
>  .../drm/panel/panel-panasonic-vvx10f034n00.c  |   2 +-
>  drivers/gpu/drm/panel/panel-raydium-rm67191.c |   2 +-
>  drivers/gpu/drm/panel/panel-renesas-r63419.c  |   2 +-
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c  |   2 +-
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  |   2 +-
>  drivers/gpu/drm/panel/panel-samsung-db7430.c  |   6 +-
>  drivers/gpu/drm/panel/panel-samsung-s6d27a1.c |   4 +-
>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c |   6 +-
>  .../panel/panel-samsung-s6e88a0-ams427ap24.c  |   2 +-
>  .../panel/panel-samsung-s6e88a0-ams452ef01.c  |   2 +-
>  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   |   5 +-
>  .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   |   2 +-
>  .../gpu/drm/panel/panel-sharp-ls037v7dw01.c   |   4 +-
>  .../gpu/drm/panel/panel-sharp-ls043t1le01.c   |   2 +-
>  drivers/gpu/drm/panel/panel-simple.c          |  70 ++--
>  .../gpu/drm/panel/panel-sitronix-st7789v.c    |  18 +-
>  drivers/gpu/drm/panel/panel-sony-acx565akm.c  |   4 +-
>  .../drm/panel/panel-startek-kd070fhfid015.c   |   2 +-
>  drivers/gpu/drm/panel/panel-summit.c          |   2 +-
>  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  |   2 +-
>  drivers/gpu/drm/panel/panel-tpo-td028ttec1.c  |   6 +-
>  drivers/gpu/drm/panel/panel-tpo-td043mtea1.c  |   4 +-
>  drivers/gpu/drm/panel/panel-tpo-tpg110.c      |   6 +-
>  drivers/gpu/drm/panel/panel-visionox-r66451.c |   2 +-
>  .../gpu/drm/panel/panel-visionox-rm69299.c    |  12 +-
>  .../gpu/drm/panel/panel-widechips-ws2401.c    |   6 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  36 +-
>  drivers/gpu/drm/panthor/panthor_drv.c         |   4 +-
>  drivers/gpu/drm/pl111/pl111_versatile.c       |   4 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                 |   6 +-
>  drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c    |   6 +-
>  drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c    |   2 +-
>  .../gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c    |   2 +-
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    |   6 +-
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  12 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        |   8 +-
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  32 +-
>  .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |   2 +-
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |   2 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  32 +-
>  .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |   6 +-
>  drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  12 +-
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c        |   2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   4 +-
>  drivers/gpu/drm/rockchip/rockchip_lvds.c      |   6 +-
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  |   4 +-
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |  92 ++--
>  drivers/gpu/drm/sitronix/st7571-i2c.c         |   2 +-
>  drivers/gpu/drm/sitronix/st7571-spi.c         |   2 +-
>  drivers/gpu/drm/sitronix/st7586.c             |   4 +-
>  drivers/gpu/drm/sitronix/st7735r.c            |   4 +-
>  drivers/gpu/drm/sprd/sprd_dpu.c               |   2 +-
>  drivers/gpu/drm/sprd/sprd_drm.c               |   4 +-
>  drivers/gpu/drm/sprd/sprd_dsi.c               |   2 +-
>  drivers/gpu/drm/sti/sti_compositor.c          |   5 +-
>  drivers/gpu/drm/sti/sti_drv.c                 |   4 +-
>  drivers/gpu/drm/sti/sti_dvo.c                 |   2 +-
>  drivers/gpu/drm/sti/sti_hda.c                 |   4 +-
>  drivers/gpu/drm/sti/sti_hdmi.c                |   5 +-
>  drivers/gpu/drm/sti/sti_hqvdp.c               |   2 +-
>  drivers/gpu/drm/sti/sti_tvout.c               |   2 +-
>  drivers/gpu/drm/sti/sti_vtg.c                 |   2 +-
>  drivers/gpu/drm/stm/drv.c                     |   8 +-
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |   4 +-
>  drivers/gpu/drm/stm/lvds.c                    |   2 +-
>  drivers/gpu/drm/sun4i/sun4i_frontend.c        |   8 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c        |   6 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  12 +-
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |   2 +-
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |   6 +-
>  drivers/gpu/drm/sysfb/ofdrm.c                 |   4 +-
>  drivers/gpu/drm/sysfb/simpledrm.c             |   4 +-
>  drivers/gpu/drm/tegra/dc.c                    |   5 +-
>  drivers/gpu/drm/tegra/dpaux.c                 |   2 +-
>  drivers/gpu/drm/tegra/drm.c                   |  84 ++--
>  drivers/gpu/drm/tegra/dsi.c                   |   2 +-
>  drivers/gpu/drm/tegra/gr2d.c                  |   2 +-
>  drivers/gpu/drm/tegra/hdmi.c                  |   2 +-
>  drivers/gpu/drm/tegra/hub.c                   |   9 +-
>  drivers/gpu/drm/tegra/nvdec.c                 |   2 +-
>  drivers/gpu/drm/tegra/nvjpg.c                 |   2 +-
>  drivers/gpu/drm/tegra/sor.c                   |   2 +-
>  drivers/gpu/drm/tegra/vic.c                   |   2 +-
>  drivers/gpu/drm/tidss/tidss_drv.c             |  12 +-
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c           |   6 +-
>  drivers/gpu/drm/tiny/arcpgu.c                 |   4 +-
>  drivers/gpu/drm/tiny/ili9225.c                |   4 +-
>  drivers/gpu/drm/tiny/ili9486.c                |   2 +-
>  drivers/gpu/drm/tiny/mi0283qt.c               |   4 +-
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c         |   4 +-
>  drivers/gpu/drm/tiny/pixpaper.c               |   2 +-
>  drivers/gpu/drm/tiny/repaper.c                |   4 +-
>  drivers/gpu/drm/tiny/sharp-memory.c           |   4 +-
>  drivers/gpu/drm/tve200/tve200_drv.c           |   2 +-
>  drivers/gpu/drm/v3d/v3d_drv.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_crtc.c                |   2 +-
>  drivers/gpu/drm/vc4/vc4_dpi.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_drv.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_dsi.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                |   2 +-
>  drivers/gpu/drm/vc4/vc4_hvs.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_txp.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_v3d.c                 |   2 +-
>  drivers/gpu/drm/vc4/vc4_vec.c                 |   2 +-
>  drivers/gpu/drm/verisilicon/vs_dc.c           |   2 +-
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |   4 +-
>  drivers/gpu/host1x/dev.c                      |  20 +-
>  drivers/gpu/host1x/tegra114-mipi.c            |   2 +-
>  drivers/gpu/ipu-v3/ipu-common.c               |   8 +-
>  drivers/gpu/ipu-v3/ipu-pre.c                  |   4 +-
>  drivers/gpu/ipu-v3/ipu-prg.c                  |   4 +-
>  254 files changed, 1155 insertions(+), 940 deletions(-)

How do you expect a patch of this size be merged?

> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/driver=
s/gpu/drm/i915/display/intel_display_device.c
> index 055396f85e4a..6b51a5102201 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -1442,7 +1442,7 @@ static bool has_no_display(struct pci_dev *pdev)
>  {
>  	static const struct pci_device_id ids[] =3D {
>  		INTEL_IVB_Q_IDS(INTEL_VGA_DEVICE, 0),
> -		{}
> +		{ }
>  	};
>=20=20
>  	return pci_match_id(ids, pdev);
> diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu=
/drm/i915/display/intel_lpe_audio.c
> index ff2cf479d8e1..3d92cb307251 100644
> --- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
> +++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
> @@ -185,10 +185,10 @@ static bool lpe_audio_detect(struct intel_display *=
display)
>  	if (display->platform.valleyview || display->platform.cherryview) {
>  		static const struct pci_device_id atom_hdaudio_ids[] =3D {
>  			/* Baytrail */
> -			{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0f04)},
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0f04) },
>  			/* Braswell */
> -			{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2284)},
> -			{}
> +			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2284) },
> +			{ }
>  		};
>=20=20
>  		if (!pci_dev_present(atom_hdaudio_ids)) {
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_=
pci.c
> index 84a7dc6ab5db..faceb3de4fa3 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -870,7 +870,7 @@ static const struct pci_device_id pciidlist[] =3D {
>  	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
>  	INTEL_ARL_IDS(INTEL_VGA_DEVICE, &mtl_info),
>  	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
> -	{}
> +	{ }

Personally, I would *always* use {} instead of { }, and would rather not
change.

Across the tree, {} is slightly more common than { }. IMO changing them
is pointless churn.


BR,
Jani.


--=20
Jani Nikula, Intel

