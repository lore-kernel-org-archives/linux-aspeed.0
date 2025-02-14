Return-Path: <linux-aspeed+bounces-738-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410EC02198
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvd12qZXz3bmH;
	Sat, 15 Feb 2025 14:32:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739492447;
	cv=none; b=Q133J7PK5J51Q5GywqejDIwFeXebK7n2zkn1CihmV9QeUzbmEbNfi9m533tfkPn+8Qq/qRxV5U/GBYVSBPobUJk6NRiZWkBop9djw+Ce1yxpFOg6drmCij5T+DybpW00KGNMrGow37U63i7f70vQpTnBCVg9qadIkgsrCClIWojF9hEp/O7H3np9IzldNmdC++BDS/82gN/NfRn5AGpAvGQXosy6AxFOEqejjdp6B1QHcL4GT26FY1nGQFNcLtk8mMCv3hmwjUgXmueLalbJkM6MgJ/QaOfLsEBhEsFY22CySy2BSBI6WpYgNDSEe3ha5PbBuAqZ6Ym8mmE1TDSYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739492447; c=relaxed/relaxed;
	bh=u5DUTgeKSzBlhfw6rOV4iz9Co6cl3sdssftt47WsrV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RckNUw0G08x4Tnb/feyupihrfG7K0jYZoHoAChhEgprV+N9FqxlcPjt+UuDYpyVe3NjYrEjeG+GNZWt/ecP44x3lSI31zG84Q1TcOL3OAWAIouqeT0se1mWaBBCmlEawB+WP8CZHKBbQCT78hSw/OFqC4aL+fQEnTmomaBcCDH0+hmd93kaEAh8j9HzCzJpn8MCJNHHZKheDl5SBpBayS3rgyCCa1ykijpyTjX5gmhPQegZVMtwxKaCa9C4x7A8SdEXigYk9wkcm4V8iZD+xqrH4pVPSGvrUJM7NwAJM9slzVm7mC6tz1T2HzWjep2U+aUOn0Ko3Ay1m6CHxK+5eiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P00e3gMl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P00e3gMl; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P00e3gMl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P00e3gMl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvCPp6pDlz2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 11:20:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5DUTgeKSzBlhfw6rOV4iz9Co6cl3sdssftt47WsrV0=;
	b=P00e3gMlsaY/ozH61LGKUpEr0ZYzAZJdJKFfZpnyVYNvXhbx1KFRsQhyMvQUOyXNHWfFwa
	4qhOhx7A11v8IjpIX9bv8gyfbRuSwj6hJfAlhJEbtT/YTLyjdUEIAoQK02IQH0pMLh/Miv
	h48lHgiyFX3WPMxhucqXotMqpwqUWsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5DUTgeKSzBlhfw6rOV4iz9Co6cl3sdssftt47WsrV0=;
	b=P00e3gMlsaY/ozH61LGKUpEr0ZYzAZJdJKFfZpnyVYNvXhbx1KFRsQhyMvQUOyXNHWfFwa
	4qhOhx7A11v8IjpIX9bv8gyfbRuSwj6hJfAlhJEbtT/YTLyjdUEIAoQK02IQH0pMLh/Miv
	h48lHgiyFX3WPMxhucqXotMqpwqUWsQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-uQZOT7WGNS-9ha7hQf9gsw-1; Thu,
 13 Feb 2025 19:20:40 -0500
X-MC-Unique: uQZOT7WGNS-9ha7hQf9gsw-1
X-Mimecast-MFC-AGG-ID: uQZOT7WGNS-9ha7hQf9gsw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9A2019039C5;
	Fri, 14 Feb 2025 00:20:34 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76BC319373C4;
	Fri, 14 Feb 2025 00:20:25 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 19:19:19 -0500
Subject: [PATCH 06/12] drm/sprd: move to devm_platform_ioremap_resource()
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
Message-Id: <20250213-mem-cocci-v3-v1-6-93466d165349@redhat.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739492356; l=2443;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=TUTmaiy8ktvyaVot7XAdlGbdVhdJXc6wa5HLnlHeW8o=;
 b=axlcFZToqyPDTa57KeclbJgjYIwMsyapnKIbq7G2GSRXbwVjCU51RG/UGVM6g1j4qeKJz5pla
 tb99zgNlyKsDQwOda15aHnv3kWaboZQzlQGPMnd4u8j0SsF6LU0UVK4
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace platform_get_resource + devm_ioremap
with just devm_platform_ioremap_resource()

Used Coccinelle to do this change. SmPl patch:
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

Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 9 +--------
 drivers/gpu/drm/sprd/sprd_dsi.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index cb2816985305fd19eac27413c214681a5a1e9ffa..65cd5aa1634eee5a6735ccffa4ee3979844d92ce 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -784,16 +784,9 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dpu_context *ctx = &dpu->ctx;
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get I/O resource\n");
-		return -EINVAL;
-	}
-
-	ctx->base = devm_ioremap(dev, res->start, resource_size(res));
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (!ctx->base) {
 		dev_err(dev, "failed to map dpu registers\n");
 		return -EFAULT;
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 8fc26479bb6bce0aa94914f49d0986a7e19326c1..1668bb4166ab0ad3812c5654244544a9caf249a6 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -901,15 +901,8 @@ static int sprd_dsi_context_init(struct sprd_dsi *dsi,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dsi_context *ctx = &dsi->ctx;
-	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get I/O resource\n");
-		return -EINVAL;
-	}
-
-	ctx->base = devm_ioremap(dev, res->start, resource_size(res));
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (!ctx->base) {
 		drm_err(dsi->drm, "failed to map dsi host registers\n");
 		return -ENXIO;

-- 
2.47.0


