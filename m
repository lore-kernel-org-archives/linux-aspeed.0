Return-Path: <linux-aspeed+bounces-563-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE943C02194
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Jan 2025 23:01:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YjLPS0Kyjz30T1;
	Wed, 29 Jan 2025 10:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738103503;
	cv=none; b=IqJEUQE/FYFSMEAytjt5SsI0BV2zv2qRsj3+49jXDysYtcJpByuhVQidHxjIAPJ2DzB3aXrtkZr08fbKJPeSndV9WwCGUxRaODgki9DjDHvBmJg4sZT50mre7Q3Fj7A4fkREkq4k9HWeFtF56QY+dWImnqEAz3+9FvpdfwjSKco66n0T1/x68cyzOBiFaghF40mpcU0SCba9/ECarvBXpbRmmF/YUG9C8BUue6qNHKULbZDMZ8Yk2GMbd6gQZhbnjZxkRw0zT1KdDMsvYp1NZ9aXvIyS3uJFaZdZBM4YKDX+7czbM7MKz39yzxWK1CuC+XIigmVO6pyfol/ZEXq7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738103503; c=relaxed/relaxed;
	bh=uBHgf3oei/qHmIZpbMF9VehDvC+EICOlxAHVG2vbAos=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=SaFsJ1gjnaRD28EtG3/Ev14BpCbOu3CZF3aCSq4PcOPI5eV2ew3ZwdTieQFRdiTrD5D7Fes51hlk+QqTVqKA5NpRHxVeCnXK0r8aZUSHCXGJLofKcbX3S1dtrD/zAMADK7A5Wkw984IMtHwBhnE2hLKdTIrBQilhZ2ncjXPMS6at5B10TTdecRNZcwDxFSFNA8VZc8d6ETn8w2+sFXfzf/uD+1iaeE5cWhOde8twdMfgAdmRF33dXprlsCYlgU3vwHwIKCJP5ihQxik5ED2vyRMnssQ+zC+usdPODv+LM1A16JVxGXFx/VssOFqiDlNBBw0qc0wnR5dqkUhKdWGyWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIY3QfC9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIY3QfC9; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIY3QfC9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIY3QfC9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YjKlL2jJbz2xt7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jan 2025 09:31:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBHgf3oei/qHmIZpbMF9VehDvC+EICOlxAHVG2vbAos=;
	b=jIY3QfC9PtFjT9dAJ7JyzPEEIfHkjAAq6HnhBMQw8Ml54ZWTAWPEe5NbAgVJZCLQf9xKYC
	lg70R/MbLmz06Fjv/bSSqaTQoalhM2ua7I+dAspT5av9FUDrreGDF0mPhjPXjsLJB2iZLl
	rWhH1m4CDWoIDnvZGtpxXHkXwkch+00=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738103499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBHgf3oei/qHmIZpbMF9VehDvC+EICOlxAHVG2vbAos=;
	b=jIY3QfC9PtFjT9dAJ7JyzPEEIfHkjAAq6HnhBMQw8Ml54ZWTAWPEe5NbAgVJZCLQf9xKYC
	lg70R/MbLmz06Fjv/bSSqaTQoalhM2ua7I+dAspT5av9FUDrreGDF0mPhjPXjsLJB2iZLl
	rWhH1m4CDWoIDnvZGtpxXHkXwkch+00=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-fxGDwM2BPi2Fc2IPObJXkg-1; Tue,
 28 Jan 2025 17:31:37 -0500
X-MC-Unique: fxGDwM2BPi2Fc2IPObJXkg-1
X-Mimecast-MFC-AGG-ID: fxGDwM2BPi2Fc2IPObJXkg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F1441800366;
	Tue, 28 Jan 2025 22:31:31 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.231])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67E34180035E;
	Tue, 28 Jan 2025 22:31:19 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 28 Jan 2025 17:29:29 -0500
Subject: [PATCH 05/14] drm/meson: move to devm_platform_ioremap_resource()
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
Message-Id: <20250128-cocci-memory-api-v1-5-0d1609a29587@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738103410; l=1714;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=f2q+dLROh+nmfHqYKZQjWCkJEGeXIqlbeRtQt42VgCQ=;
 b=lhClH7lzArBOUdWbc4Q4UnvQ1RCQ19pVNRVv63WKBHzCVgJMxuArGJpHa8TYtAgCNIzt7DlYr
 NxuKblbIiv5BF/Ek4dNs87o4KLEP61IBFsptwDPsRW00XhC+FVopP4m
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vIJPCKXduCQNYdSTLbQICPcH-9RZm5dJyMK3-vT8_So_1738103492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Replace platform_get_resource_byname + devm_ioremap
with just devm_platform_ioremap_resource()

Used Coccinelle to do this change. SmPl patch:
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

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 81d2ee37e7732dca89d02347b9c972300b38771a..6c805805b7a7f675f8bb03944318972eb4df864e 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -184,7 +184,6 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	const struct meson_drm_match_data *match;
 	struct meson_drm *priv;
 	struct drm_device *drm;
-	struct resource *res;
 	void __iomem *regs;
 	int ret, i;
 
@@ -220,14 +219,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	}
 
 	priv->io_base = regs;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
-	if (!res) {
-		ret = -EINVAL;
-		goto free_drm;
-	}
 	/* Simply ioremap since it may be a shared register zone */
-	regs = devm_ioremap(dev, res->start, resource_size(res));
+	regs = devm_platform_ioremap_resource_byname(pdev, "hhi");
 	if (!regs) {
 		ret = -EADDRNOTAVAIL;
 		goto free_drm;

-- 
2.47.0


