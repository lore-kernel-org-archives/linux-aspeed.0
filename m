Return-Path: <linux-aspeed+bounces-745-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC68C021A4
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvd36wRjz2yRF;
	Sat, 15 Feb 2025 14:32:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739492477;
	cv=none; b=i1eHONafsOTA08ARa+wCqJR37tLra5q5Olmo/1iO7eAHRyt3GOilqUZpmSOLoHWFg2vIE3yrhyu3vUCm9a3qztwS7J5SaJKrCKaFEgGYkLvJw5uxI7HAkcooo32j++1gyu1qNjalIpKcXPH0HZsp2mN3KgDl2ppzIhZFRAs7YpEbvKy/Rx+DLRXdDc3UWUsu8AxjdpuIiXRxUClPsLV0ltPkmf5j0EntfjFKs2DZgjppbUa+TXX72n8cD2skwzIhvh6abnRE7HGP6Zmvtlt+MYS7yI9y0aDCW14lxCJenFOslAPnu5+WLSalRj9Njh6wgPu5/4Y9LpY2zukaMoAXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739492477; c=relaxed/relaxed;
	bh=WV3CUjfdiDqmiVITg/ki0rg01TIBSPaLDwHXu/1B6+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikKU66PUUbPo8cSP6ttB2YOtkzrt+SNDzdMdtUydwhOqnYfs2W3H6EW4lvDJdyMdaGYFdDrju03NbTWDAtxMXhAnMes9PWe2Rp5gpeovHEwppp9Xgv/oB6PO8Su2DsQL/eQ8jW2a1BTbDfleWdqsbBoUd71jXzsSTREbRAKDwhycr4WhL1UM4al0280VHaaUBXOW9gd7ESiaAH51KX7jODlh5RxVpqUAnTs61t66asOYpVM9lWy8cuxQceSTtKDNYbDipaAqRLx11OoqMCNdcJyONCQha6y+GHIM3D4QwiVd9MMoVIQp9YNGAmlevft4tmCGcN58L0GCi43aVl3EtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+XFriqs; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LuCR42MW; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+XFriqs;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LuCR42MW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvCQN5JD8z2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 11:21:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV3CUjfdiDqmiVITg/ki0rg01TIBSPaLDwHXu/1B6+E=;
	b=Z+XFriqsHxiyv6G0GN8cYvj2gjPwNJF20lpBgy/vvsvg9VK7MEa9M7OUYzJACgEknqJEeV
	+E/oLK7s9Fxb6QfO8TwhQikraNI6ndkQPLMqDRriJeWZyc7CYIqcFKgk26zNPbydEWIlqg
	7cQ7mQya4EdDNyQQjpwif8MuvXBv3Co=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV3CUjfdiDqmiVITg/ki0rg01TIBSPaLDwHXu/1B6+E=;
	b=LuCR42MWd9fxGwQ/YJIVQ4wcpWSEq5jNT2WyFHWc4nuvwAe0WOOv30I1KR3OYDkIAY96dM
	cwyJ6NvC007tAXGr9d5L8V1mlZh7fc5MyHLsvLoQWdLACAT6vqXFFQiqIkHTkM1TN55gVZ
	/85S0TCR/jcRuCD2WYa1XdaLFvjLtAU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-VWyHsseaPNaZQ615f1HAfw-1; Thu,
 13 Feb 2025 19:21:10 -0500
X-MC-Unique: VWyHsseaPNaZQ615f1HAfw-1
X-Mimecast-MFC-AGG-ID: VWyHsseaPNaZQ615f1HAfw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD23F19560B9;
	Fri, 14 Feb 2025 00:21:04 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F337119373C4;
	Fri, 14 Feb 2025 00:20:54 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 19:19:22 -0500
Subject: [PATCH 09/12] drm/tegra: move to devm_platform_ioremap_resource()
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
Message-Id: <20250213-mem-cocci-v3-v1-9-93466d165349@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739492356; l=1560;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=66gfH4HaVcJzuzQX0NHIOkeT0eso2EOo8AHIoNrPiQ8=;
 b=lERldx+LESWFe45bunCkBz/hTi0YUBRXtlg7nEd9i+5NiEJuicyc5TDHv4kGFLqu6nL+Q4mjK
 OFl9sPsgdQeB02s6YY5/9O/HjCjt3dM44IBUwlkbzFjZuraMmQBWPEO
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

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/tegra/dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 4a8cd9ed0a9414b2f40b716fa8c02aff038a53e0..51f1ed897f8e473f45f89ff3e2d99f66d2c80f21 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1564,7 +1564,6 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 static int tegra_dsi_probe(struct platform_device *pdev)
 {
 	struct tegra_dsi *dsi;
-	struct resource *regs;
 	int err;
 
 	dsi = devm_kzalloc(&pdev->dev, sizeof(*dsi), GFP_KERNEL);
@@ -1636,8 +1635,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dsi->regs = devm_ioremap_resource(&pdev->dev, regs);
+	dsi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dsi->regs)) {
 		err = PTR_ERR(dsi->regs);
 		goto remove;

-- 
2.47.0


