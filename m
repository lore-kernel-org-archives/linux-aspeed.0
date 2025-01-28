Return-Path: <linux-aspeed+bounces-566-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109DC02195
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Jan 2025 23:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjLPS3hNPz30Sy;
	Wed, 29 Jan 2025 10:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738103471;
	cv=none; b=lVoaoH52sqO7RAeLQF5MkMEIgRjcr++OAFnJM/dA0qITFtCjlMNLP4EuyejMualQ3YsvJwjwgvZCDFQO7HCYEYfp/p4UJbh0G4CH32+qea43fpSR1Or0n/4GM4Ce2+oQvzQUccQAxsZ27uOM8XLfdxcRv4DQvqxVp8zr3rFKiY3u2KJil41jebp2vPlZmb+7gD54OigNoUyyY8guadG5Kp49VJXZXRJJsYdUvR26ittoo2PLKpVsuIinrVpPbsLvURcl48hk/xedveJDW1qjKjIoZvrOlydkbxKlC7YRhBko2CksaA8H3Vzzn24qBzJ7BlwsAJckAc7RDs2tnebFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738103471; c=relaxed/relaxed;
	bh=lAlVhEovi3Moc7M0X3CwlbuNR4AC2AlPw2mJBO4AZuI=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=hIZ/BFby3Tl1UslT95HdWH4LR++A26TIRY/uWcr8aXHmnRwiP5uiokHoYu1DHMrUnfs5rz60jElekI+hAdmoGTdTnHBqnzASS702XsGOILUr1GR72sZ5J4KsA9Tx6eqjw9LHe1edIZ7Z3HyxFaKtNIG3zQp4aSX4DPEPKPWYYZtjhFPWW3N5qccV4LkWJm3iFOLdvhcbpLkDdUjNDV39Ye2l8TaCeug52oJGCFrRh6NaGjzozfE8IDQSRc1gBH+eFYiClP7DI8I1p0YW30/7WzWwmbx2CFOdgpNEKUR2KFB/uNd9IzSIHEIorTTtxKEo0VXH248SuZnNbNnP4kAT3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evEYUYFZ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evEYUYFZ; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evEYUYFZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evEYUYFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjKkk2sDnz2xt7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 09:31:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAlVhEovi3Moc7M0X3CwlbuNR4AC2AlPw2mJBO4AZuI=;
	b=evEYUYFZMaCO8Zya+Iygi6ExUYtNTIsQEfZmDUXbf7S90xOyT6Y7O8oVi0360R9m4jKVMO
	zdWjHwXEBC88mpnogRacx2ixgHfHHEXL3gX8F3KegLXuK+bBDfF8lw5FCZyvXMaSic7ldk
	vdyo/aWda/Ly14aCWewFQbEWer9klyY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAlVhEovi3Moc7M0X3CwlbuNR4AC2AlPw2mJBO4AZuI=;
	b=evEYUYFZMaCO8Zya+Iygi6ExUYtNTIsQEfZmDUXbf7S90xOyT6Y7O8oVi0360R9m4jKVMO
	zdWjHwXEBC88mpnogRacx2ixgHfHHEXL3gX8F3KegLXuK+bBDfF8lw5FCZyvXMaSic7ldk
	vdyo/aWda/Ly14aCWewFQbEWer9klyY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-k1KRTK1yM5GR1U36nh5WLw-1; Tue,
 28 Jan 2025 17:31:03 -0500
X-MC-Unique: k1KRTK1yM5GR1U36nh5WLw-1
X-Mimecast-MFC-AGG-ID: k1KRTK1yM5GR1U36nh5WLw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D52AC195608A;
	Tue, 28 Jan 2025 22:30:54 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.231])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 315BF180035E;
	Tue, 28 Jan 2025 22:30:41 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 28 Jan 2025 17:29:26 -0500
Subject: [PATCH 02/14] drm/fsl-dcu: move to
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
Message-Id: <20250128-cocci-memory-api-v1-2-0d1609a29587@redhat.com>
References: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
In-Reply-To: <20250128-cocci-memory-api-v1-0-0d1609a29587@redhat.com>
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
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738103410; l=1572;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=E/x0XHfCIYue1aYPjwmvjhLSrhE3WYrX8VtBbLE/Ors=;
 b=o/s7NBj4DCNY2pulLJsJuj/ZWooQ7Q4OXjwNgE+GzlT4LHlVgk+SwhztgWU9DBj2cokJBlAMD
 1cuOYyBx9wgDmTlkdvTPHqjWzzViiuIkUi85/Bq3GHnhQvaMLPCb6uC
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UTHtjIFTcrxvtQiKHBd9HiNePM-hsH-dg1EpTv8xE48_1738103456
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

Cc: Stefan Agner <stefan@agner.ch>
Cc: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 03b076db9381a5db0bff6576cda2772495a61fed..3bbfc1b56a6557e2f54d2b7ed099531053871341 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -260,7 +260,6 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	struct fsl_dcu_drm_device *fsl_dev;
 	struct drm_device *drm;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	void __iomem *base;
 	struct clk *pix_clk_in;
 	char pix_clk_name[32];
@@ -278,8 +277,7 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	fsl_dev->soc = id->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
 		return ret;

-- 
2.47.0


