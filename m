Return-Path: <linux-aspeed+bounces-732-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4D4C021A6
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvct03HVz2yZN;
	Sat, 15 Feb 2025 14:32:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739492393;
	cv=none; b=bDvRknZrDKkzkxR7rQGZjWY5N1UiPwNk5xf0DQS73zDPA9sb+80rbTZUTBzUVX1exGA6xxz85LHmwqziZUB7AkquNr7SIskSzHJ6Zbry6/2EBMwpTuOTHBfVwBJXTaxrCc2ZNrmk/DmBBAv6KJsbef2300764XYrSt3dLVRIsBlG0nXJbNZUjerVcMdvmsQUujRn95ImVdcz0sWAx6yKkHEwDGG7tfgSRtUwo0LdSJ3MJPKElhjGvVPk/blNwWNnBA6NGB4ngY1GIfoTHGxV6aUXtmEcCxd77nQ/WwPoVoKuEyczXYNi5hzK2v09oZwyLhwm7Y5QZzjXlxh3tp2MCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739492393; c=relaxed/relaxed;
	bh=tF6nQiuAoGdDRaxi4ffFK8y97AsM0p7biyz4jaKoW/4=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=mR6FI5TWD+QvlP/UAngTV8ToZu2n1Bj/A8BfJ23Te/5WQSyDq7E41/BY3T9w4R/4gYWZ32tWW1OjFikPFKPF72usJ+VbS2s/IFXK374vX7TgKxSc2zvxWrdZRkW91PI1BHmSxIZbXl/QkRNAYDOGcv3lTqL8Ba+Bupd5WsIGNxoEXz8/7qvMyNqinotWaCIbvP7mfHdoAGNZs7Uy4R0L6dY9rhpmjGaLspbB/S+BxmZTtwWWQw7Cl/nDcmXdHnLgv46K+sfXlhZkMOWAscddu5aGavU45RMSMyUyA+neCkXpxqcyMusUGURAXwWA4pgNzaiVoVMQ/9S52utXsF7kXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hfskKvOw; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b11CFYtm; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hfskKvOw;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b11CFYtm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvCNm0v0Hz2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 11:19:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tF6nQiuAoGdDRaxi4ffFK8y97AsM0p7biyz4jaKoW/4=;
	b=hfskKvOw3ZQLr6fAbok+cYr2qwuecnpRQt3llnFkBbqQmZ7PrE+ZgeIEJgu3z3gKNyfFhR
	GUkUScmTAi7/8sqL+njfe6PSZsRVQk3ldT29LQgZgKEhqAj1whgMtkTuGWoy/YfeaMYSLN
	egVp0eYNJAkzUfSV6pI7GedKThP8wjs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tF6nQiuAoGdDRaxi4ffFK8y97AsM0p7biyz4jaKoW/4=;
	b=b11CFYtmUjIpH8OoRsEvRcDPb7z5f4JEZBIqpIU1kTA5UGQ8jVo/GH9vGAGLkNWJI7OIq8
	8vmQik8EyRHR6grPmKieA+n4VMCewuEozjzHXjjQmVoX/WoCixlDH6OajWelh/3hyqePgz
	MiMAg4rYc+yfoTo9/6B1gFBGuzOzARc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-zfNw4zUWPoCPxlmZ-VC4NA-1; Thu,
 13 Feb 2025 19:19:41 -0500
X-MC-Unique: zfNw4zUWPoCPxlmZ-VC4NA-1
X-Mimecast-MFC-AGG-ID: zfNw4zUWPoCPxlmZ-VC4NA_1739492375
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73DD9180087D;
	Fri, 14 Feb 2025 00:19:30 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9123019373C4;
	Fri, 14 Feb 2025 00:19:16 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 00/12] drm: Move to using devm_platform_ioremap_resource
Date: Thu, 13 Feb 2025 19:19:13 -0500
Message-Id: <20250213-mem-cocci-v3-v1-0-93466d165349@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAAKMrmcC/x3MQQqAIBBA0avIrBvQCSG6SrSIaapZqKEQgXj3p
 OVb/F+hSFYpMJsKWR4tmmKHGwzwtcVTUPduIEvekhsxSEBOzIrPiJ6dFXKeZDqgJ3eWQ99/t6y
 tfbaoKWFeAAAA
X-Change-ID: 20250213-mem-cocci-v3-5c10e2152e8f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739492356; l=4546;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=RYl8F5/aPh8ikJsFxMU1SMqP5uI28pqwHX8dD7l8K/U=;
 b=WnxWQhBi5C/L81rTjcUFFGzsRo89PrH4LR3kqQyjFGJ7KK2bxR5gH52AZgGYsQJmH1QxT+UZU
 m56uJ8jVm3wDxtsSjBgC7XvMz5uL+Ep+Zw75J7pRo4h0Sv4qNV2Ryxi
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: amzDaZWpbpND9a3o5PGCwZrzuIgPctkza7W3A1tyC9Q_1739492375
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Start replacing the below occurences with the newer API:
- (devm_)platform_get_resource + devm_ioremap_resource
- (devm_)platform_get_resource + (devm_)ioremap
- platform_get_resource_byname + devm_ioremap
Move all these occurences to uses devm_platform_ioremap_resource
instead.

This is v3 of the series. Changes from v2 [1]:
- Keep the old snippet of documentation and add further
clarification (Thomas)
- change in vc4 driver for the a resource is not needed.
Add a comment to clarify why that is left behind (Maxime)

[2] - https://patchwork.freedesktop.org/series/144073/

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
 drivers/gpu/drm/vc4/vc4_hdmi.c                  | 54 +++++++++----------------
 28 files changed, 51 insertions(+), 172 deletions(-)
---
base-commit: 68763b29e0a6441f57f9ee652bbf8e7bc59183e5
change-id: 20250213-mem-cocci-v3-5c10e2152e8f

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


