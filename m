Return-Path: <linux-aspeed+bounces-741-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6B2C021A7
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvd213kLz3blv;
	Sat, 15 Feb 2025 14:32:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739492458;
	cv=none; b=Asqan53YLx+QaUznIftYU17t07xh+hY8sgqoDerXuN1iRGtsoEWB4dVeUhlBoysTwcR8mq/x/A2pcKl8OpD7DjibkARJ8ey4iLuq5RvHz0WZRm1nLR1yFYheWU8Gq1FZWFucDdx+KVSED5Hpkjv7QYmcLdJ1Su/to0YyVZsy4kbnFQyl1XL1qRTzD9JxEJlDRa/BGhFZm12gEm6jzj7VS35zUdvmvpLhI9DxFX6heTDy6G9PmxydjGHpYBZNxRuBoda/f9BSgyq/twjAWetRcWBghmItXLDqUfuMibVeppo4gLnSrUYinLMkXSSTYJtjZIbOUvMH4+cfOXvIz0euyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739492458; c=relaxed/relaxed;
	bh=1SyGjgKbryTWmJVGn6FomMxHDBk+KgTQY7/iUl03kyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iun5C8YobSglkK2IoeO/kCDZdESKErXBTZaY4m2byj0Dt3y6BZm13WsEByxRYjRf2ZqIVteMIm3lui4sKUSme6rp/tYlXxzAsbWMrR7HF2wWjDnUEflLd7L3AvUQmPNH97smaEmgU7e8qvzFx0xMc282adO0TWXNsE36SJ/KtYxHLtjF+NjA59vxmRHgMH4TawZDz4RGkvBWDhJDs05Q83TlGy5UcBolRMhSEuoZbWebEM7Iy7cTWcd8KH8ElPRAICv27kHIPdR1S69xvshsVvY5+ulW4xdLAPSYpqYB3ULAsef+oIBmRQYAhH9T9YiaO/xr2orLjpRLqDMN+yZl0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmdVUXd9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmdVUXd9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmdVUXd9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TmdVUXd9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvCQ14Kzqz2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 11:20:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SyGjgKbryTWmJVGn6FomMxHDBk+KgTQY7/iUl03kyE=;
	b=TmdVUXd9AmpSvhKN9MoO6nQZhdiod8cV1oRjLaq8zNLR6mDEQ78+HBmSKvcR6WICcJ4ecK
	YvgHau5ipA10C3MNZa1MBy+NmKJ6F+2QKarJc2atx+yX+hAuPZyHCXhLB6UfF8aet0AU38
	oHlXHeymMgs+09UDkrCtn0ZxOIMnvBs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SyGjgKbryTWmJVGn6FomMxHDBk+KgTQY7/iUl03kyE=;
	b=TmdVUXd9AmpSvhKN9MoO6nQZhdiod8cV1oRjLaq8zNLR6mDEQ78+HBmSKvcR6WICcJ4ecK
	YvgHau5ipA10C3MNZa1MBy+NmKJ6F+2QKarJc2atx+yX+hAuPZyHCXhLB6UfF8aet0AU38
	oHlXHeymMgs+09UDkrCtn0ZxOIMnvBs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-NZ_l7rMjMgiBJJ3A2lr8EQ-1; Thu,
 13 Feb 2025 19:20:50 -0500
X-MC-Unique: NZ_l7rMjMgiBJJ3A2lr8EQ-1
X-Mimecast-MFC-AGG-ID: NZ_l7rMjMgiBJJ3A2lr8EQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19E851903089;
	Fri, 14 Feb 2025 00:20:45 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2200219373C4;
	Fri, 14 Feb 2025 00:20:34 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 19:19:20 -0500
Subject: [PATCH 07/12] drm/sti: move to devm_platform_ioremap_resource()
 usage
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-mem-cocci-v3-v1-7-93466d165349@redhat.com>
References: <20250213-mem-cocci-v3-v1-0-93466d165349@redhat.com>
In-Reply-To: <20250213-mem-cocci-v3-v1-0-93466d165349@redhat.com>
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
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739492356; l=8242;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=uVtYXzPEFiDF4K0A7qqpqkoig1yNms2Ij9v80VQ98xQ=;
 b=VKUk1zcg2mPnfm/PNHPPHhCC3Yd5O6ZOCp9zsb1NrYlNRwcKR/unOXyqCrAga6kEyJT3WNZ+6
 iOTlf2+1wSxBZg2OUrhHOsCr2s7XkwnTopImc0AnJPXJgAcJzea3XWS
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace platform_get_resource/_byname + devm_ioremap
with just devm_platform_ioremap_resource()

Used Coccinelle to do this change. SmPl patch:

@rule@
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

and
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

v2: Fix compilation error.

Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/sti/sti_compositor.c | 10 +---------
 drivers/gpu/drm/sti/sti_dvo.c        | 10 +---------
 drivers/gpu/drm/sti/sti_hda.c        |  9 +--------
 drivers/gpu/drm/sti/sti_hdmi.c       | 11 +----------
 drivers/gpu/drm/sti/sti_hqvdp.c      | 10 +---------
 drivers/gpu/drm/sti/sti_tvout.c      | 10 +---------
 drivers/gpu/drm/sti/sti_vtg.c        | 10 +---------
 7 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
index 063f82d23d80c4ba83624a0066a18416a2b37351..7aefce6706ba2cd7d97a33228c9b9812edecf06f 100644
--- a/drivers/gpu/drm/sti/sti_compositor.c
+++ b/drivers/gpu/drm/sti/sti_compositor.c
@@ -177,7 +177,6 @@ static int sti_compositor_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct device_node *vtg_np;
 	struct sti_compositor *compo;
-	struct resource *res;
 	unsigned int i;
 
 	compo = devm_kzalloc(dev, sizeof(*compo), GFP_KERNEL);
@@ -194,14 +193,7 @@ static int sti_compositor_probe(struct platform_device *pdev)
 
 	memcpy(&compo->data, of_match_node(compositor_of_match, np)->data,
 	       sizeof(struct sti_compositor_data));
-
-	/* Get Memory ressources */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		DRM_ERROR("Get memory resource failed\n");
-		return -ENXIO;
-	}
-	compo->regs = devm_ioremap(dev, res->start, resource_size(res));
+	compo->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (compo->regs == NULL) {
 		DRM_ERROR("Register mapping failed\n");
 		return -ENXIO;
diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index c6c2abaa1891cd3ea025805b50d275ec314512c3..660588f01f90950a9b2c180ab230188c19901f26 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -511,7 +511,6 @@ static int sti_dvo_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_dvo *dvo;
-	struct resource *res;
 	struct device_node *np = dev->of_node;
 
 	DRM_INFO("%s\n", __func__);
@@ -523,14 +522,7 @@ static int sti_dvo_probe(struct platform_device *pdev)
 	}
 
 	dvo->dev = pdev->dev;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dvo-reg");
-	if (!res) {
-		DRM_ERROR("Invalid dvo resource\n");
-		return -ENOMEM;
-	}
-	dvo->regs = devm_ioremap(dev, res->start,
-			resource_size(res));
+	dvo->regs = devm_platform_ioremap_resource_byname(pdev, "dvo-reg");
 	if (!dvo->regs)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b12863bea95559c4f874eb94cea8938609d435d4..0b5dbaf4d5305989846e25a1cab6f82d191aa9a5 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -750,14 +750,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hda->dev = pdev->dev;
-
-	/* Get resources */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hda-reg");
-	if (!res) {
-		DRM_ERROR("Invalid hda resource\n");
-		return -ENOMEM;
-	}
-	hda->regs = devm_ioremap(dev, res->start, resource_size(res));
+	hda->regs = devm_platform_ioremap_resource_byname(pdev, "hda-reg");
 	if (!hda->regs)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index ca2fe17de4a5d1e0199e59a97e6c7601e139ed9e..666143c48b0d0f2c20cd26323ddbc8e69d966622 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1380,7 +1380,6 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hdmi *hdmi;
 	struct device_node *np = dev->of_node;
-	struct resource *res;
 	struct device_node *ddc;
 	int ret;
 
@@ -1399,15 +1398,7 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 	}
 
 	hdmi->dev = pdev->dev;
-
-	/* Get resources */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdmi-reg");
-	if (!res) {
-		DRM_ERROR("Invalid hdmi resource\n");
-		ret = -ENOMEM;
-		goto release_adapter;
-	}
-	hdmi->regs = devm_ioremap(dev, res->start, resource_size(res));
+	hdmi->regs = devm_platform_ioremap_resource_byname(pdev, "hdmi-reg");
 	if (!hdmi->regs) {
 		ret = -ENOMEM;
 		goto release_adapter;
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 0f658709c9d0d398c4eed65202443db9d0b41f8c..420395598d119a403d531211022e6005d6a2bd59 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1356,7 +1356,6 @@ static int sti_hqvdp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *vtg_np;
 	struct sti_hqvdp *hqvdp;
-	struct resource *res;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -1367,14 +1366,7 @@ static int sti_hqvdp_probe(struct platform_device *pdev)
 	}
 
 	hqvdp->dev = dev;
-
-	/* Get Memory resources */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		DRM_ERROR("Get memory resource failed\n");
-		return -ENXIO;
-	}
-	hqvdp->regs = devm_ioremap(dev, res->start, resource_size(res));
+	hqvdp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (!hqvdp->regs) {
 		DRM_ERROR("Register mapping failed\n");
 		return -ENXIO;
diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index af6c06f448c4819def8cc0d0836e30f991529690..0bebe815f5e7567f84388af93723a6fa7d2cc7a2 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -838,7 +838,6 @@ static int sti_tvout_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct sti_tvout *tvout;
-	struct resource *res;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -850,14 +849,7 @@ static int sti_tvout_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tvout->dev = dev;
-
-	/* get memory resources */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tvout-reg");
-	if (!res) {
-		DRM_ERROR("Invalid glue resource\n");
-		return -ENOMEM;
-	}
-	tvout->regs = devm_ioremap(dev, res->start, resource_size(res));
+	tvout->regs = devm_platform_ioremap_resource_byname(pdev, "tvout-reg");
 	if (!tvout->regs)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index 5ba469b711b5318e9e9e6d8df127fb8933d1fac1..b5353fe774d72fd629ecd3ef75a5d2817ca8617f 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -380,20 +380,12 @@ static int vtg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_vtg *vtg;
-	struct resource *res;
 	int ret;
 
 	vtg = devm_kzalloc(dev, sizeof(*vtg), GFP_KERNEL);
 	if (!vtg)
 		return -ENOMEM;
-
-	/* Get Memory ressources */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		DRM_ERROR("Get memory resource failed\n");
-		return -ENOMEM;
-	}
-	vtg->regs = devm_ioremap(dev, res->start, resource_size(res));
+	vtg->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (!vtg->regs) {
 		DRM_ERROR("failed to remap I/O memory\n");
 		return -ENOMEM;

-- 
2.47.0


