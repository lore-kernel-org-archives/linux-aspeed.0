Return-Path: <linux-aspeed+bounces-841-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68C9C18E7C
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 23:01:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2Y4Z1kqhz30Wg;
	Wed, 26 Feb 2025 10:01:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740522081;
	cv=none; b=FcP/rDxIGdfzGqZhVpQAh4C8XMxICLsDlgoD7X1vCNQ7Pi4/wwi8h+rgOE8AiU0KduiO42bULPnmHQzQX2uq1cS4zDedzfV+Oz8BWg3xU6jmcBUN9S0r0G/HwB/agr7MFFvhaOoVzM3gJ3Po6EYdmTe3aWts0frk4nWeDb51Xm8wGyV37sUiJvidxdy1H0DNKPazFEY2nwcsYqi9Roe8AOTtDe3T7mye11ZExd1xvAGonl5Flk8XDeOA4h8kHyCsvCvP8CSsyghMm9bzV9SeU6VbeLECHiDJ1/FlAmg26c9n7hJhNPoB11gzpMyDR0ES7LXDiL+RqxOUYDpwRjldtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740522081; c=relaxed/relaxed;
	bh=HmdS/AlEx+8JlcqZ5mtM6o9rE+VmGN6xnAqIajbGwQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=bS6eSKADfTgmS1fA/X150O6BbsOMb662L3GWsSHWLEnaGdd05YHnlsk5Wqyz52VtRABxnvGpAr9CRWJRCGdi+oMcZi3TUDRap+rgCcnuee8CSw/IKb8pPmgrNTYDwgJVuzQYixAs6DBf2Raaj+/I6e+98q7zVWnyaNrV2ZxK1ft2RH3/soIDt+2pX7D+NvKbkWRSVsCYyqyk7qkDW3hcGebQ6xOGgPykGfdTxhvdBP6/UyZgcZrrirQ/he1rc20SxA5AZBtnhgNkN5P6j8KIyx36HABLp4y+6pZszQO194k3/A9TqOcB0WqBa+3La7hMb3AHygr2PAE4W169AI66pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEOwyBL2; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7xLYShd; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEOwyBL2;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7xLYShd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2XBR0FbZz2ypD
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 09:21:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HmdS/AlEx+8JlcqZ5mtM6o9rE+VmGN6xnAqIajbGwQA=;
	b=SEOwyBL2JiogcH302apskT2FoB49V3UEi2SYtJDpeZ64QKwb5vTgWfUDcEo0IO4654qr6b
	nJb6YZIhoNKBC0VjB3uaR0sw4pI3Fpn00XzQEy94fIU1mgGDVxzAMUgxzBUwDBCfvpBV7A
	MU6Hz8ufjLHhPj72TdhzZ3+Q/TLzOzA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HmdS/AlEx+8JlcqZ5mtM6o9rE+VmGN6xnAqIajbGwQA=;
	b=I7xLYShdWKN7CCfNIXdMCxEgA0I1e4EjmMheNcyMJCFuocRVXH5+JCPKynlvFM1OKe9vf4
	5Y1N6Akx5qUfl9cFqRnRhDyhrrdnUr6uSvzBJFaRaIkJIBOp4paExvHOyDuzNqbNsk4geY
	+1vYl35+/X5kkQdXeNTuAFEymuV/Soc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-bEt8P_VWOeaeQWGLKOdHDg-1; Tue,
 25 Feb 2025 17:21:08 -0500
X-MC-Unique: bEt8P_VWOeaeQWGLKOdHDg-1
X-Mimecast-MFC-AGG-ID: bEt8P_VWOeaeQWGLKOdHDg_1740522063
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A699A1800874;
	Tue, 25 Feb 2025 22:20:59 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BC6E1800359;
	Tue, 25 Feb 2025 22:20:46 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH RESEND 00/12] drm: Move to using
 devm_platform_ioremap_resource
Date: Tue, 25 Feb 2025 17:20:41 -0500
Message-Id: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
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
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADlCvmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3dzU3PyiSt2Uolzd3MziZN281IoS3SQjExOTJBMLi5QkIyWg1oK
 i1LTMCrCx0UpBrsGufi5KsbW1AGMd+zJuAAAA
X-Change-ID: 20250225-memory-drm-misc-next-b2444b488db2
To: Joel Stanley <joel@jms.id.au>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>, 
 CK Hu <ck.hu@mediatek.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740522045; l=4600;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=VRew4thqjNNr9Bhh7XZ9CycetampVVfLEpViJv98lrg=;
 b=ECHxTPhmX8SH8mJXx2ad9sYUXYHscl1DXpCA8GXt5zVBerbXI/IktA9aaJ7pdl+ts3xeDePFN
 9Ct46KCSVgmCxQFFFX9oDZfk9E0JAYbrP432VYqTJmou2zlqrmetjZp
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MWjtY7LAEGZdGhn86gEjYheRoW53qnrLVE8Pz84u6Zk_1740522063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Start replacing the below occurences with the newer API:
- (devm_)platform_get_resource + devm_ioremap_resource
- (devm_)platform_get_resource + (devm_)ioremap
- platform_get_resource_byname + devm_ioremap
Move all these occurences to uses devm_platform_ioremap_resource
instead.

This is a resend of v3 of the series. Sending this from drm-misc-next.
Changes from v2 [1]:
- Keep the old snippet of documentation and add further
clarification (Thomas)
- change in vc4 driver for the a resource is not needed.
Add a comment to clarify why that is left behind (Maxime)

[1] - https://patchwork.freedesktop.org/series/144073/

Used Coccinelle to make the code changes.Semantic patch:

//First Case
//rule s/platform_get_resource + devm_ioremap_resource/devm_platform_ioremap_resource
@rule_1@
identifier res;
expression ioremap_res;
identifier pdev;
@@
-struct resource *res;
...
-res = platform_get_resource(pdev,...);
-ioremap_res = devm_ioremap_resource(...);
+ioremap_res = devm_platform_ioremap_resource(pdev,0);

//Second case
//rule s/(devm_)platform_get_resource + (devm_)ioremap/devm_platform_ioremap_resource.
@rule_2@
identifier res;
expression ioremap;
identifier pdev;
@@
-struct resource *res;
...
-res = platform_get_resource(pdev,...);
<...
-if (!res) {
-...
-}
...>
-ioremap = devm_ioremap(...);
+ioremap = devm_platform_ioremap_resource(pdev,0);

//Third case
//rule s/(devm_)platform_get_resource_byname + (devm_)ioremap/devm_platform_ioremap_resource_byname.
@rule_3@
identifier res;
expression ioremap;
identifier pdev;
constant mem;
expression name;
@@
-struct resource *res;
<+...
-res = platform_get_resource_byname(pdev,mem,name);
<...
-if (!res) {
-...
-}
...>
-ioremap = devm_ioremap(...);
+ioremap = devm_platform_ioremap_resource_byname(pdev,name);
...+>

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (12):
      drm/aspeed: move to devm_platform_ioremap_resource() usage
      drm/fsl-dcu: move to devm_platform_ioremap_resource() usage
      drm/hisilicon: move to devm_platform_ioremap_resource() usage
      drm/mediatek: move to devm_platform_ioremap_resource() usage
      drm/mxsfb: move to devm_platform_ioremap_resource() usage
      drm/sprd: move to devm_platform_ioremap_resource() usage
      drm/sti: move to devm_platform_ioremap_resource() usage
      drm/stm: move to devm_platform_ioremap_resource() usage
      drm/tegra: move to devm_platform_ioremap_resource() usage
      drm/tiny: move to devm_platform_ioremap_resource() usage
      drm/vc4: move to devm_platform_ioremap_resource() usage
      Documentation: Update the todo

 Documentation/gpu/todo.rst                      | 13 +++---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c         |  4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       |  4 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    |  4 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_merge.c       |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         |  4 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c        |  4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c              |  4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c             |  4 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         |  4 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c               |  4 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c               |  4 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                 |  9 +----
 drivers/gpu/drm/sprd/sprd_dsi.c                 |  9 +----
 drivers/gpu/drm/sti/sti_compositor.c            | 10 +----
 drivers/gpu/drm/sti/sti_dvo.c                   | 10 +----
 drivers/gpu/drm/sti/sti_hda.c                   |  9 +----
 drivers/gpu/drm/sti/sti_hdmi.c                  | 11 +----
 drivers/gpu/drm/sti/sti_hqvdp.c                 | 10 +----
 drivers/gpu/drm/sti/sti_tvout.c                 | 10 +----
 drivers/gpu/drm/sti/sti_vtg.c                   | 10 +----
 drivers/gpu/drm/stm/ltdc.c                      |  4 +-
 drivers/gpu/drm/tegra/dsi.c                     |  4 +-
 drivers/gpu/drm/tiny/arcpgu.c                   |  4 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                  | 53 +++++++++----------------
 28 files changed, 51 insertions(+), 171 deletions(-)
---
base-commit: 27d4815149ba0c80ef2db2a82f0512f647e76d62
change-id: 20250225-memory-drm-misc-next-b2444b488db2

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


