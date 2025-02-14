Return-Path: <linux-aspeed+bounces-736-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D34C021AA
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 03:32:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvvcw1KWTz2ygP;
	Sat, 15 Feb 2025 14:32:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739492504;
	cv=none; b=PWDzeDWZM2ShbAj+6xcy4KcT/7RwLQ93xi1eYR80aLlk1SAe6wnKN/WepoPa1teXFjkakzIFh+QzCCivW/p5zvZbGibOvEaMeXH0zc6q/N4D84GDOkzBDFHyAyFSbqZIlRXd/mPEGNuAWnjrtfjFtao3/KJKZ7hmggLc2LIcEXP0BwuN1fCDSLs/Jp/Vfpd+Ge63FE0ioTdEPLMqwjyXfD9utO/Iskp1ayblbMVLVYE1zRzASv4LKWM6BAYKLKTtYeYrN8p2MkgoTWDmXgqZW1NrJ9ejrv7mcSwRnxJTknW5Yy/5tqC1U0He8xhlQfPITj+Sn85sugmETXN69LaxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739492504; c=relaxed/relaxed;
	bh=YekiFLZYEOC7oNklCnqy2v4cDXBgQn3tW82+Hlneiv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MqUc8jfh2Sfx3/h50HHv2sOyFBgSfBZ56y9oZgDWspj9jSvMdoYE+wG+J2+SKr07SEoGvA6K4bokH9iSD0/q/ii+9Pa1RE0JGjKbEFLMz9T9Y+3yYNnizYI+wL2ZrwAU79D+gVOAf2Kk0gquyou3ISWH/K5K3YJuHY42TZtYHRzaArhzNtEPEXYEwihY2nH0Ienrq4fEbRqg17DouCVtJXoVphNoRJ1alas3as+AVrYnk8PalJGJHO6q5FmTlJeiTeyRBK+f0kHZVFDJdzZfcpZ6+xu1McpGOzTgKPgJe6PPToZBsYtC2PhOdyk38pNn3+5JzYmqjj61aeUZ/QiQiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IgWGZ0i4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhPCtwVV; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IgWGZ0i4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhPCtwVV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvCQv6Jtvz2yft
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 11:21:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YekiFLZYEOC7oNklCnqy2v4cDXBgQn3tW82+Hlneiv0=;
	b=IgWGZ0i4ZRCo/+B0+FFQZQUiPeFQrFSyh+ZrY3SWVI2Fka7B8q0TLAKUL+QNMQAGLivb8h
	lH37XFo/RC6AevUSTM6qBVvw/KjevfP2EPYM1NsZzhVw85tDDJIyGRJT7iPQT5NUSKlfiA
	QQLuZH0V4K8PSpozWGZ4Uek8dKdki9M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739492501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YekiFLZYEOC7oNklCnqy2v4cDXBgQn3tW82+Hlneiv0=;
	b=NhPCtwVVUpsOnBLWgJk4EBx7RkCRj0TQOIsbXF4tMf40pHzfnMCc+ZjWyR7pytDkh4VfWh
	hBF8ePivRb6zr2XgfLQHFGCbsJanpYCE4s6Ty+VZO4ySdB9iXsAnITBg5j0oCcMpAVRq+s
	lAqpETpAH7ert+Zk3q3Z7w4lfZtWevg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-GREkPZofPRqAGTMWmiWrUg-1; Thu,
 13 Feb 2025 19:21:37 -0500
X-MC-Unique: GREkPZofPRqAGTMWmiWrUg-1
X-Mimecast-MFC-AGG-ID: GREkPZofPRqAGTMWmiWrUg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE9361800879;
	Fri, 14 Feb 2025 00:21:32 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B66FE19373C4;
	Fri, 14 Feb 2025 00:21:23 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 19:19:25 -0500
Subject: [PATCH 12/12] Documentation: Update the todo
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
Message-Id: <20250213-mem-cocci-v3-v1-12-93466d165349@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739492356; l=1573;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=bYxgFN867I+WeRXfo+Hqrkj7dpTr9KOQQ6gXwIiRKW0=;
 b=cHX+5YoNVZJTRemhs4SucNAn3ucLSNF85bfH//R9r2aykA56GpMQQQSLXVA7X7foeQRwKWecs
 +OKDBIRplsKChc5XegZo+yGbuHDto2wbs/C+rOhVmPq3dgGic16khxR
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Update the Documentation to be more precise.

v2: Update for clarity
v3: Further details in Todo

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 Documentation/gpu/todo.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 256d0d1cb2164bd94f9b610a751b907834d96a21..c57777a24e03d91b1ffe04365f7356f2d938befd 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -441,14 +441,15 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
 Level: Intermediate
 
-Request memory regions in all drivers
--------------------------------------
+Request memory regions in all fbdev drivers
+--------------------------------------------
 
-Go through all drivers and add code to request the memory regions that the
-driver uses. This requires adding calls to request_mem_region(),
+Old/ancient fbdev drivers do not request their memory properly.
+Go through these drivers and add code to request the memory regions
+that the driver uses. This requires adding calls to request_mem_region(),
 pci_request_region() or similar functions. Use helpers for managed cleanup
-where possible.
-
+where possible. Problematic areas include hardware that has exclusive ranges
+like VGA. VGA16fb does not request the range as it is expected.
 Drivers are pretty bad at doing this and there used to be conflicts among
 DRM and fbdev drivers. Still, it's the correct thing to do.
 

-- 
2.47.0


