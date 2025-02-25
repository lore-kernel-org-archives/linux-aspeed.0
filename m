Return-Path: <linux-aspeed+bounces-834-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4971EC021B2
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 23:01:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2Y4W2jp3z30Vr;
	Wed, 26 Feb 2025 10:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740522101;
	cv=none; b=cPFqoudqzPH3gHXv5InshBMNz9c6gi7/KkR5z0HV4xvq4POXJRc+Tck5aob10tPIhXsAQwyRmjKlY4+6RacqPKUEkTAbfY5cYltW1ww655E8NQdnyk2ASxBwp/TUb1+ROXMCArs10RWRZLz11xq4FaMuJWhuXfuILEZ/1G4uoC6OegPOFtxIax4LP2HEkFd5VzA7IOzpZyYagwJVPWJRMYa/YqsHgpPDxVndgthnbWamLq++NYqDG+RvqNk45yUzVURp6PYMIGW9hxdIFxAm5cZxZROQMbEF65LHlcDe2QPLT+YAjhPYrBF3H9FPdDb+taRya1HCeMV3+2UGzdlgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740522101; c=relaxed/relaxed;
	bh=rEUADPvt5vUb0DPdb4ydVYz2t+TuARR2y9RFIuVvjk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlCMLmJMzflsSnWK7z0zhqnzztl5WC1gTvhwgWLThzNDuXiNsO/XndH0ANpAaLTmGwvIwauUJ5cQcSjhjVd1hb7eua7y9L/LbxCm0zj77yBLzZ0rtq4rcDC0lwc/5wmGuPj50OIr/V40JYyzYWEe6Hn2YpNwFj9AsVvetaxeXDwcmEq9N0Ss0KV0dqyAk+ZuzqRlaFUQTvYH+P7XBPU6rqgOi1Jf16AbgCu8jo0tSU9cB7qItkutDfcYPDFAitx+9kQ7LmZ7T/VIBrSDxCrg4DETaB6WTl4IknahMfOwf68+IsswEh7v8LjORsgfh5WUsgEr2VX4xHbGcpaqQ1gxGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpX/FzhU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iNF3FVFL; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpX/FzhU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iNF3FVFL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2XBr2zmCz2ypD
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 09:21:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEUADPvt5vUb0DPdb4ydVYz2t+TuARR2y9RFIuVvjk4=;
	b=TpX/FzhUdiJSTFuk/7NjtbKknekWejDUoYoyHyk8YGqz4jon7ql6o/pOdkIDf5eHmFXGa3
	5BuzY0GoR0lRGq6zfE5L6518x8o7/zlviHMn2GnecwYWgglf+GpOhgFKqYTjzgJcrHPNXy
	SKfFypUz8DrbY5rfdBVfGR+a26G+27c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEUADPvt5vUb0DPdb4ydVYz2t+TuARR2y9RFIuVvjk4=;
	b=iNF3FVFLIhWrLXVJH/4ThKKfjpVoQG6SFsU/M3t50uYjvRZi96uoZFC4LZ1xy3gWK+EHBN
	ucPqqxdcCyG4o90vVhbhdLP4WsEzIa3z3SrEG0LHLKp6rADc+aDgnnxA/sd7BU+9qVEPeW
	TLv/yFN1tuQxzRbCxLXuGolKYKILE+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-z3spe7bOMT2IG8zc8OX8QQ-1; Tue,
 25 Feb 2025 17:21:30 -0500
X-MC-Unique: z3spe7bOMT2IG8zc8OX8QQ-1
X-Mimecast-MFC-AGG-ID: z3spe7bOMT2IG8zc8OX8QQ_1740522084
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEA1B180087B;
	Tue, 25 Feb 2025 22:21:23 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 582781800359;
	Tue, 25 Feb 2025 22:21:12 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Feb 2025 17:20:43 -0500
Subject: [PATCH RESEND 02/12] drm/fsl-dcu: move to
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
Message-Id: <20250225-memory-drm-misc-next-v1-2-9d0e8761107a@redhat.com>
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
In-Reply-To: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740522045; l=1621;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=qdWoCRSaEyGwiB1pCeMHCVglO9KpvJz3OeotRemVCtM=;
 b=MmBvjsDUiZbRNuaaJsdP+iaWgAOgnswhlGjAArEmd1kmgdQaNCxLmnLpvsxJEIH5kCN+PlsH/
 go4avHjeRbHA/sDEeDZ3Q3Km73RDsC/HCkVsfgMOmX3OzBTArnMLOg3
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
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
2.48.1


