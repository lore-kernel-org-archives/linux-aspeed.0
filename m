Return-Path: <linux-aspeed+bounces-668-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0589DC0219D
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 22:51:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpFpC3ll2z300V;
	Thu,  6 Feb 2025 09:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738786283;
	cv=none; b=bbLQxLJXiTiieC2Csh+zJ+LJG+nY2FU9ZWK+4tM4aQl5O9Em7MXmKPyS/Y2TL/dtLyoBU1jZrqKabFwwt8THTk16IlViW3gnud/HU0WrH+0Fqxa//lKNsRTLDhGfB2U+lsmV3PRkzZkINPYTHUnbUtu6HLGGsIcHQuTCUbE3NnUS448Pjkx783v9CBgoRUzo553wDuFb/Aoga0lX89e1ZnLv901rJwdgXaQqQODW7wQ4jRyeFOddQ2MphCR8kMVcjNrgPWHp/4WYBHcAyD0jEcc3iaTKp4XvRrCO1RPRx79tWpja72631RmigB1POp8csk+8J6W6RohiO+DR+NA3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738786283; c=relaxed/relaxed;
	bh=SZeGtn73Y88CUfVnHvmhJXIyAiaLqqpqwADZqySX09U=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=lPzrH2hwkSoiZoxuBR9aLNRIh7nsJsUeUpqQs4BOnILU4Jd0XC656TWRKLRF1/loechrBv97QYT0u37vJwB1bb0hmyGOd7sPlshk/LWMfzZOzphFvdVeeosTeGvmAeDVvAAv8A/Flnm11VaZfTl9Oyvrpw1AAsbM2mYRoncV81omVukjT3UlpU9WmP6wU2ABoD8J52Ifwbftmbppq9yDltr0EVhR6i0FdBRZeP0mRohSICO74P27b9HciO5gCtsKZc/aqbQUlwUI/lmfjXOKz1t3Gf42pbvA+WWGLh4niahOoFL9cZFtx/VTFZOTuAkWjsoX449WGeuxSth2sWRK3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnJLg78G; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnJLg78G; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnJLg78G;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnJLg78G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpBFk2rDJz3011
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Feb 2025 07:11:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZeGtn73Y88CUfVnHvmhJXIyAiaLqqpqwADZqySX09U=;
	b=YnJLg78GJmq+zjiEg07DIqp3W+0wQkJ2fC8U6Ro5BB0NGXrHmFCU29D+XMEBzm7gqD24uQ
	hD0nAlEqWHDcVgQeTppGlbf5DYzmAeA3oQUVSdxZWbbA6NNG8TgOiX40Zjrhlw3OuA28Jf
	j4t199RM+61/laLXTYLoHgvveFupsxI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZeGtn73Y88CUfVnHvmhJXIyAiaLqqpqwADZqySX09U=;
	b=YnJLg78GJmq+zjiEg07DIqp3W+0wQkJ2fC8U6Ro5BB0NGXrHmFCU29D+XMEBzm7gqD24uQ
	hD0nAlEqWHDcVgQeTppGlbf5DYzmAeA3oQUVSdxZWbbA6NNG8TgOiX40Zjrhlw3OuA28Jf
	j4t199RM+61/laLXTYLoHgvveFupsxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-XrLRZbIRMpab2n-xkqm89A-1; Wed,
 05 Feb 2025 15:11:15 -0500
X-MC-Unique: XrLRZbIRMpab2n-xkqm89A-1
X-Mimecast-MFC-AGG-ID: XrLRZbIRMpab2n-xkqm89A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B45771800268;
	Wed,  5 Feb 2025 20:11:07 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.17.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C50519560A3;
	Wed,  5 Feb 2025 20:10:57 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 05 Feb 2025 15:08:06 -0500
Subject: [PATCH 10/12] drm/tiny: move to devm_platform_ioremap_resource()
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
Message-Id: <20250205-mem-cocci-newapi-v1-10-aebf2b0e2300@redhat.com>
References: <20250205-mem-cocci-newapi-v1-0-aebf2b0e2300@redhat.com>
In-Reply-To: <20250205-mem-cocci-newapi-v1-0-aebf2b0e2300@redhat.com>
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
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738786137; l=1744;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=7+Q2lsuHInmFMU6F4dj3qB4yNCyOo0pZ9W9kufCkjVw=;
 b=760bfuqeQwB2H7jkE4dYuBDK73EXGEZNFWeKXn1Of96MzG/gKvOtfpspbFSJECAZcDlGGB/p8
 CY4DM7EBirEA1qRG0o0TqcMkXSTVS6lZYO5NB4/ZPvsibEJrpSbIKQu
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pvPrq8jpuCxLu2Ww5lgqVZp6cb1eMeGh_1w_WwslGp4_1738786268
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 2748d1f21d8697275047886865a5518792a4dd7c..7cf0f0ea1bfe4fa82234a120b52837e26a8ee5b0 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -253,7 +253,6 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
-	struct resource *res;
 	int ret;
 
 	arcpgu->clk = devm_clk_get(drm->dev, "pxlclk");
@@ -270,8 +269,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	drm->mode_config.max_height = 1080;
 	drm->mode_config.funcs = &arcpgu_drm_modecfg_funcs;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	arcpgu->regs = devm_ioremap_resource(&pdev->dev, res);
+	arcpgu->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(arcpgu->regs))
 		return PTR_ERR(arcpgu->regs);
 

-- 
2.47.0


