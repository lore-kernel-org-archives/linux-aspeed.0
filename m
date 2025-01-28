Return-Path: <linux-aspeed+bounces-554-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98338C02193
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Jan 2025 23:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjLPN04c6z2yhG;
	Wed, 29 Jan 2025 10:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738103446;
	cv=none; b=af+N2U8RuW5T0q632IHJBJpOVIhIdNpq18Ks1joPC9gp2/Uco0YacUFEyRSWJS3Or+bsfK9El4TrisD9I1K5KtnGRI6UdRXo6rqAKtvdJmX3dQ6Cr8RI3PNjg16jeES+wd7u/C/6ig8Yi7XEspNnX+LegLeh7ym/4S9zYadA+gdeRxwQGI23fYgyrrQPlj4bzmyT489kdcjmR0yOvY0yWXleEG38EaBnwXlYfZdbbuEieI47p/c9mUjeRrg7IpOjAhOehb1IuGm/yhwaaTzIwFi47ShWbP8/lh0D3TacFBNyITGTKaLPQ11NgWzMzpWWZaCTVi4q+2zL92NA0GYJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738103446; c=relaxed/relaxed;
	bh=Bbih3RuEKQlUkWbTQ/PFCmKMuLjifWffxPwT42Mo1uc=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=ou6bTRDDS8RrBsF8lfiZRfgFnZOtyOZuKumypHmgBrm+pdT4n14bM+G67EfqS0vLANxON0kQx5z27vS6M3w9mPpzAbByrZiie9eabneIQA8gWC4GIKslmFcTZoqP8RvzJTw3DQSjDUCAR9UOkqdTB+mbZG06tTXQJaZpW3IgOqw/q4wK1TDaZ/sVJYdL5fB6weZSKfBD/EUExo4JN91gTg/2nBixw/q7mbUd+HJvubKK2pa5bzgWjESxfTvfZZt3JuGGQQUhuvV42htGSzkKgxo+q1o2Y+vPIKMM098TbjQHSfdapk7fCHvFoty4iCi+Yu0bg4kjmNQqGSldFnciCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmLbdVvH; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmLbdVvH; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmLbdVvH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmLbdVvH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjKkF47Kjz2xt7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 09:30:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bbih3RuEKQlUkWbTQ/PFCmKMuLjifWffxPwT42Mo1uc=;
	b=OmLbdVvHjJNKDV5cSNgdDL+wLrJPovxbV7h/rWhuCV6nmdIdDWJY4MQZDAlmaG5qeTfMMq
	MtGYvAgi9Dy96LCocBwXydfpb8pW4MBFlxLT1SBKqWPFZCQeVMPmYIMcvP+6pKh4KUQTly
	dZDooUFgYSUeCHmSa97xvpvtClisekk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bbih3RuEKQlUkWbTQ/PFCmKMuLjifWffxPwT42Mo1uc=;
	b=OmLbdVvHjJNKDV5cSNgdDL+wLrJPovxbV7h/rWhuCV6nmdIdDWJY4MQZDAlmaG5qeTfMMq
	MtGYvAgi9Dy96LCocBwXydfpb8pW4MBFlxLT1SBKqWPFZCQeVMPmYIMcvP+6pKh4KUQTly
	dZDooUFgYSUeCHmSa97xvpvtClisekk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-LtV_82jsOVW9ot0uekBm9Q-1; Tue,
 28 Jan 2025 17:30:37 -0500
X-MC-Unique: LtV_82jsOVW9ot0uekBm9Q-1
X-Mimecast-MFC-AGG-ID: LtV_82jsOVW9ot0uekBm9Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EE851800360;
	Tue, 28 Jan 2025 22:30:27 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.231])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83018180035E;
	Tue, 28 Jan 2025 22:30:10 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 00/14] drm: Move to using devm_platform_ioremap_resource
Date: Tue, 28 Jan 2025 17:29:24 -0500
Message-Id: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAERamWcC/x3MTQqAIBBA4avErBtQI42uEi3EppqFPyhEEd49a
 fkt3nuhUGYqMHcvZLq4cAwNsu/AnTYchLw1gxJqFFJN6KJzjJ58zA/axKi0JjlYMRoy0LKUaef
 7Xy5rrR8zCerIYgAAAA==
X-Change-ID: 20250128-cocci-memory-api-266e13a057e7
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
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
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
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738103409; l=4607;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=t1B4jwyIADVA6S8X7DXOmIb01Pyst5f0UX1jMRzVBZA=;
 b=TKPB6evzfjTeNzV82GgFaRIEt8PBIygsoHwoHMJY6JP3p+kHHMkgJH10gfKAjIAyEApxibsX1
 CFZ8Xj5+QaQDJehni2woQbUyEUZMq2rh8dkQ+4RKwUZp27t3QE5BRgr
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TcBOtim4dd5AmRETH4m96kbPOSJ3TbV0m-llJNLpZJQ_1738103431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Start replacing the below occurences with the newer API:
- (devm_)platform_get_resource + devm_ioremap_resource
- (devm_)platform_get_resource + (devm_)ioremap
- platform_get_resource_byname + devm_ioremap
Move all these occurences to uses devm_platform_ioremap_resource
instead.

Address a TODO item in the GPU section.

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
...
-res = platform_get_resource_byname(pdev,mem,name);
<...
-if (!res) {
-...
-}
...>
-ioremap = devm_ioremap(...);
+ioremap = devm_platform_ioremap_resource_byname(pdev,name);

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (14):
      drm/aspeed: move to devm_platform_ioremap_resource() usage
      drm/fsl-dcu: move to devm_platform_ioremap_resource() usage
      drm/hisilicon: move to devm_platform_ioremap_resource() usage
      drm/mediatek: move to devm_platform_ioremap_resource() usage
      drm/meson: move to devm_platform_ioremap_resource() usage
      drm/mxsfb: move to devm_platform_ioremap_resource() usage
      drm/rockchip: move to devm_platform_ioremap_resource() usage
      drm/sprd: move to devm_platform_ioremap_resource() usage
      drm/sti: move to devm_platform_ioremap_resource() usage
      drm/stm: move to devm_platform_ioremap_resource() usage
      drm/tegra: move to devm_platform_ioremap_resource() usage
      drm/tiny: move to devm_platform_ioremap_resource() usage
      drm/vc4: move to devm_platform_ioremap_resource() usage
      Documentation: Update the todo

 Documentation/gpu/todo.rst                      | 15 ---------------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c         |  4 +---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       |  4 +---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    |  4 +---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  4 +---
 drivers/gpu/drm/mediatek/mtk_disp_color.c       |  4 +---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c       |  4 +---
 drivers/gpu/drm/mediatek/mtk_disp_merge.c       |  4 +---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         |  4 +---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c        |  4 +---
 drivers/gpu/drm/mediatek/mtk_dsi.c              |  4 +---
 drivers/gpu/drm/mediatek/mtk_hdmi.c             |  4 +---
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         |  4 +---
 drivers/gpu/drm/meson/meson_drv.c               |  9 +--------
 drivers/gpu/drm/mxsfb/lcdif_drv.c               |  4 +---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c               |  4 +---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  4 +---
 drivers/gpu/drm/sprd/sprd_dpu.c                 |  9 +--------
 drivers/gpu/drm/sprd/sprd_dsi.c                 |  9 +--------
 drivers/gpu/drm/sti/sti_compositor.c            | 10 +---------
 drivers/gpu/drm/sti/sti_dvo.c                   | 10 +---------
 drivers/gpu/drm/sti/sti_hda.c                   | 10 +---------
 drivers/gpu/drm/sti/sti_hdmi.c                  | 11 +----------
 drivers/gpu/drm/sti/sti_hqvdp.c                 | 10 +---------
 drivers/gpu/drm/sti/sti_tvout.c                 | 10 +---------
 drivers/gpu/drm/sti/sti_vtg.c                   | 10 +---------
 drivers/gpu/drm/stm/ltdc.c                      |  4 +---
 drivers/gpu/drm/tegra/dsi.c                     |  4 +---
 drivers/gpu/drm/tiny/arcpgu.c                   |  4 +---
 drivers/gpu/drm/vc4/vc4_hdmi.c                  |  9 ++-------
 30 files changed, 30 insertions(+), 164 deletions(-)
---
base-commit: c4b9570cfb63501638db720f3bee9f6dfd044b82
change-id: 20250128-cocci-memory-api-266e13a057e7

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


