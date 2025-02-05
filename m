Return-Path: <linux-aspeed+bounces-670-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ABFC02199
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 22:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpFpD22Plz306J;
	Thu,  6 Feb 2025 09:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738786176;
	cv=none; b=O93YM85EsEnlEB/pHEn/6EOCsnvMtYxLQX184xApk8h0IMis2+gjTD9jhSOvOpntApBhn0hgjMqmXtfuTikfl/FVhwYuR+OHfPsuLJdgQmCPEzz8HdpO3w7eXQmNAzAjtiBN/yHiYQ0ftlP2AM5WIcMMbs4UQVEBIXQYcuZWIQKaX5G4gqSuUBSRdALQm4TCSEL84YRnpBgBSwIinrBMgX2ybAIyx6hRJUpV43U0FsXDHEmgBmoAw0HpvpgwYBCyFuT7dK8UlZyHbieDcoeGp4x4lg1MpYazqpmeT7g36e/Xfvk8rObu+wzjSKJ4vgsSjyZETjX5hXsdxFrbnmWTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738786176; c=relaxed/relaxed;
	bh=FtyHp14quoZKfSwCwvs1IfBWioeKvvPDS6kPB6/O+SI=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=mPkwNAYcEGzzerfnlkLDOUze52Mck0P/ua/bbAkipkglQJaXmt//8DGsRvsqADd9ANoFeQWvp1eCpdebqfNOGyvBrSPTx/QRQiEWm6njJ1OJDO0uOvg9rcwSGf0BWN+XF3MzwYGdx4NllazIztuWJENNSz/jvCdQ+WHOfrQYDOS+zDVZg2YO5xsUYHK8L4MK1zmsw2USfNsHEQyu/DuicKXMNnwsai74j3rbm1JOj97EjXDIbE5+uJlopw2a/HKPfG3rYUgYbdh50qcLybg68C7swxpzLz/++69XZui4r+msc8iaIIYlwEBf3A17juz8aMjCA/NnaRmIfjvKDs38BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=enfdz9QJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Enaho0bq; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=enfdz9QJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Enaho0bq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpBCd2L5kz3011
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Feb 2025 07:09:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FtyHp14quoZKfSwCwvs1IfBWioeKvvPDS6kPB6/O+SI=;
	b=enfdz9QJ+69G2dIe+QOzItgQeTJOJetipJ36vrbVG0pSxnl4tardMD9dySgWEOrpiFpawQ
	GpMANZFdw/XnOSIJP9B0yv7sqS61O+pAkBrTCZcco138uWnHCCNz12WEju6zx0PUyQgAfF
	R2piun2Yztpi4ZNDRWrX5h2da3YFCo4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FtyHp14quoZKfSwCwvs1IfBWioeKvvPDS6kPB6/O+SI=;
	b=Enaho0bqesLNKvL0NTIqFKvneu6TkEzKVtK4mecT+wgYbP944/nWPCH7fYx+Wf5oQYTXN0
	h42hCFRJFGAmzdV7ivWM+IYoN9jLT4gnpgZDIB3t75ZIRYOsbKlWL8I+Lhfxmvx4bl6Pk+
	SP5rEr3FvII/kQ30tsv+pVBoJm3gGPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-CF1M26uSNJmCSR8ep_ZkTQ-1; Wed,
 05 Feb 2025 15:09:22 -0500
X-MC-Unique: CF1M26uSNJmCSR8ep_ZkTQ-1
X-Mimecast-MFC-AGG-ID: CF1M26uSNJmCSR8ep_ZkTQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 409D419560B6;
	Wed,  5 Feb 2025 20:09:13 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.17.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 957B919560A3;
	Wed,  5 Feb 2025 20:08:57 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 00/12] drm: Move to using devm_platform_ioremap_resource
Date: Wed, 05 Feb 2025 15:07:56 -0500
Message-Id: <20250205-mem-cocci-newapi-v1-0-aebf2b0e2300@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIABzFo2cC/x3MQQqAIBBA0avErBtQSYmuEi1Sp5pFKgoVSHdPW
 r7F/xUKZaYCU1ch08WFY2iQfQfuWMNOyL4ZlFBaKKHxpBNddI4x0L0mRuPtYEcpjTcELUuZNn7
 +5by87we0aAeTYgAAAA==
X-Change-ID: 20250205-mem-cocci-newapi-6db4b8116d6e
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
 Fabio Estevam <festevam@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>, 
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
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738786137; l=4887;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=JBXfstQaIVwQ4CElA5zFAPJmVat5vbPS8gLTRdPLuUI=;
 b=kB2Ax15EIn2x59280nG+iYRJh3A8F3lI/vAFp/1S4keeM/8lC4ZnJc86pKPdqRuC7++JEqhWK
 fKEzwCmQXKIDNwrIxS+ebvDgJC/rzBnDe6p36Nc05otkT/OeNyXMGX2
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ji46vYLmisLD6YhHzaCJqbzA0u_Wb3YLZ9k0M1yiyZo_1738786157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Start replacing the below occurences with the newer API:
- (devm_)platform_get_resource + devm_ioremap_resource
- (devm_)platform_get_resource + (devm_)ioremap
- platform_get_resource_byname + devm_ioremap
Move all these occurences to uses devm_platform_ioremap_resource
instead.

This is v2 of the series. Changes from v1 [1]:
- Mostly fix the compilation errors :( What had passed locally
happened to be the wrong config with most drivers not enabled.
- Clarify the TODO item in the GPU section of Documentation
for anyone who wants to do it in future.
- Drop meson patch from discussion in v1
- Drop rockchip patch as well. Offline discussion with
Maxime led to the conclusion that using
devm_platform_get_and_ioremap_resource() would be a better
approach in that source file. Not adding that change as part of
this series, can be addressed separately.

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

 Documentation/gpu/todo.rst                      | 12 +++---
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
 drivers/gpu/drm/sprd/sprd_dpu.c                 |  9 +---
 drivers/gpu/drm/sprd/sprd_dsi.c                 |  9 +---
 drivers/gpu/drm/sti/sti_compositor.c            | 10 +----
 drivers/gpu/drm/sti/sti_dvo.c                   | 10 +----
 drivers/gpu/drm/sti/sti_hda.c                   |  9 +---
 drivers/gpu/drm/sti/sti_hdmi.c                  | 11 +----
 drivers/gpu/drm/sti/sti_hqvdp.c                 | 10 +----
 drivers/gpu/drm/sti/sti_tvout.c                 | 10 +----
 drivers/gpu/drm/sti/sti_vtg.c                   | 10 +----
 drivers/gpu/drm/stm/ltdc.c                      |  4 +-
 drivers/gpu/drm/tegra/dsi.c                     |  4 +-
 drivers/gpu/drm/tiny/arcpgu.c                   |  4 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                  | 55 +++++++------------------
 28 files changed, 46 insertions(+), 177 deletions(-)
---
base-commit: 92514ef226f511f2ca1fb1b8752966097518edc0
change-id: 20250205-mem-cocci-newapi-6db4b8116d6e

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


