Return-Path: <linux-aspeed+bounces-735-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DE7C021A9
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvct4yW7z2xQ8;
	Sat, 15 Feb 2025 14:32:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739492434;
	cv=none; b=CBira2GRmD2IhD8qHai2qXbXVnpYw6cihXkjHG29N7GVuXHS4XH2Ja2sTCUa6RyadQhEMhs58SfCrqPo6w7REKd9o8mmuZ1FknXsAL0g7Hc0k4wJ3zVSh44K77nPRsaNPkw7EAuVzSGCk7ZqGm0/RzaPxI0TMtO7J+HKArHxox5KKCo6B/uzegyJ6yQIiJwNV26vdh85klteHEXSX0qwCbHm/NyiwbBymPa5C8uC+hzVZUO2C6g53ksZ6dReUIX2x++73DEC/hHlJBJhVUug9fYUmC+3aXmsnijMEY7MP/F31qUWa32MA11kQ+YXDcDB7x8gfY+qSuG78eJnVOnVug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739492434; c=relaxed/relaxed;
	bh=IrH9X/arE/6sOUtmaO+Jg5cKd9dcGxIYeKDtr1nTdl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLNr4HlyQBtQoN6lPztiXG1kd+f0mQtOBkskXlqKup6b1q5yOsRWkpSy4wfhsYkRzYegwlQOqPaC44jvxDDpCLr7hiuwPI/888+RoR7r+7kPM2j/Vuywp7KuUG415w1rC5ScD5LyJr5KzK7Cz3w4tpYpZ9kHgVjtypGol4X9oW8B5aivbmuh9vCmqTTP7IeeKb+s41dXr9C2KO0rIowWxzIZ/B7u3T1tY+wD8UzkxXCt0dtFMLB2nlVqw1rgs/dOmc5X9PMnmmW1CyG6FU/amqvvBnt59NZYJ1TQY4cHvBMoUj42vkoijhjpdClWhLDLniIWhC+wecaX9KoVIkXFPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gabwQIzZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gabwQIzZ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gabwQIzZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gabwQIzZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvCPY6J1nz2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 11:20:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrH9X/arE/6sOUtmaO+Jg5cKd9dcGxIYeKDtr1nTdl8=;
	b=gabwQIzZ3BQgDxRi5Igf+Zh0lxud9C8pgBCimJUO3B+hUSj38SI856Z7GVm55b9ZejRIMQ
	1wuT0Cw6rinhHYfab1TZ0iRTB2Fy02XfJTE2P38c/U3xie1aE9tsFcOsJVZ6ZHi2aSYM72
	7taHF+Sic2tA68Chk5w6bSliw1F9NL0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrH9X/arE/6sOUtmaO+Jg5cKd9dcGxIYeKDtr1nTdl8=;
	b=gabwQIzZ3BQgDxRi5Igf+Zh0lxud9C8pgBCimJUO3B+hUSj38SI856Z7GVm55b9ZejRIMQ
	1wuT0Cw6rinhHYfab1TZ0iRTB2Fy02XfJTE2P38c/U3xie1aE9tsFcOsJVZ6ZHi2aSYM72
	7taHF+Sic2tA68Chk5w6bSliw1F9NL0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-fB0R1Q5qMxKpSN7LnWu8DQ-1; Thu,
 13 Feb 2025 19:20:25 -0500
X-MC-Unique: fB0R1Q5qMxKpSN7LnWu8DQ-1
X-Mimecast-MFC-AGG-ID: fB0R1Q5qMxKpSN7LnWu8DQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC2E919039C5;
	Fri, 14 Feb 2025 00:20:13 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35F9D19373C4;
	Fri, 14 Feb 2025 00:20:04 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 19:19:17 -0500
Subject: [PATCH 04/12] drm/mediatek: move to
 devm_platform_ioremap_resource() usage
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
Message-Id: <20250213-mem-cocci-v3-v1-4-93466d165349@redhat.com>
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
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>, 
 CK Hu <ck.hu@mediatek.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739492356; l=8775;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=uIXcHmCDzw/Ei7jNzyEofRMwehXYGBmCK1xBP21HeuI=;
 b=8QC1slobRzH+eG8+Tc/zIkmBfWL9kuhfEuiATareVypRbQhFrZhLfEU8EjDj0xrEQnjEBrnVQ
 xGVacoOX6u4CRK/AZIqa8HBLhS1RMlQpzmaIHQeX0lP21nciMoGwQec
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace platform_get_resource + devm_ioremap_resource
with just devm_platform_ioremap_resource()

Used Coccinelle to do this change. SmPl patch:
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

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 4 +---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 +---
 drivers/gpu/drm/mediatek/mtk_disp_merge.c | 4 +---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 4 +---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c  | 4 +---
 drivers/gpu/drm/mediatek/mtk_dsi.c        | 4 +---
 drivers/gpu/drm/mediatek/mtk_hdmi.c       | 4 +---
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c   | 4 +---
 8 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index dd8433a38282a9ba1bcc3a4ddd01dd89738ccb60..39c7de4cdcc16b56a5a1d046aaabaf5580227ed2 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -96,7 +96,6 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_disp_color *priv;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -108,8 +107,7 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get color clk\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap color\n");
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index b17b11d93846f2019d8c4afb294375333e22dc42..8afd15006df2a21f3f52fe00eca3c5501f4fb76a 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -256,7 +256,6 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_disp_gamma *priv;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -268,8 +267,7 @@ static int mtk_disp_gamma_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get gamma clk\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap gamma\n");
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index 563b1b248fbbb38ef03bb3e3ceecdd265961df60..b174dda091d3fbd16796e8e128b030fccf5b902c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -306,7 +306,6 @@ static const struct component_ops mtk_disp_merge_component_ops = {
 static int mtk_disp_merge_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct mtk_disp_merge *priv;
 	int ret;
 
@@ -314,8 +313,7 @@ static int mtk_disp_merge_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap merge\n");
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index df82cea4bb79c472acbb66e0df27fbad3e70bd20..d0581c4e3c999cf865fdd0aaf4c2f38dd404926e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -604,7 +604,6 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_disp_ovl *priv;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -621,8 +620,7 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get ovl clk\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap ovl\n");
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index bf47790e4d6be5d60070c63c15c75fa201cc4b27..c9d41d75e7f2a3af5820921b7e563da377ce8d0d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -313,7 +313,6 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_disp_rdma *priv;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -330,8 +329,7 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get rdma clk\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap rdma\n");
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 40752f2320548fbf6c7de96b18e8a636ac9c31be..f298293471de49473dd05973383dc22f7d3b6c23 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1192,7 +1192,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 {
 	struct mtk_dsi *dsi;
 	struct device *dev = &pdev->dev;
-	struct resource *regs;
 	int irq_num;
 	int ret;
 
@@ -1217,8 +1216,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->hs_clk))
 		return dev_err_probe(dev, PTR_ERR(dsi->hs_clk), "Failed to get hs clock\n");
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dsi->regs = devm_ioremap_resource(dev, regs);
+	dsi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dsi->regs))
 		return dev_err_probe(dev, PTR_ERR(dsi->regs), "Failed to ioremap memory\n");
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index ca82bc829cb96446d4d34eeef45848df03bd716b..d729c13590cb5ec176f15b680c262a26b677e6aa 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1425,7 +1425,6 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	struct device_node *cec_np, *remote, *i2c_np;
 	struct platform_device *cec_pdev;
 	struct regmap *regmap;
-	struct resource *mem;
 	int ret;
 
 	ret = mtk_hdmi_get_all_clk(hdmi, np);
@@ -1471,8 +1470,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	}
 	hdmi->sys_regmap = regmap;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdmi->regs = devm_ioremap_resource(dev, mem);
+	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs)) {
 		ret = PTR_ERR(hdmi->regs);
 		goto put_device;
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index fc69ee38ce7d6a245a7460cfde8de426e83b2e80..7982788ae9df51f1a378d8d538737f38af7299f2 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -291,7 +291,6 @@ static const struct component_ops mtk_mdp_rdma_component_ops = {
 static int mtk_mdp_rdma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct mtk_mdp_rdma *priv;
 	int ret = 0;
 
@@ -299,8 +298,7 @@ static int mtk_mdp_rdma_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap rdma\n");

-- 
2.47.0


