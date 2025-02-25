Return-Path: <linux-aspeed+bounces-840-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D9C021B2
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 23:01:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2Y4Y5dvWz30gC;
	Wed, 26 Feb 2025 10:01:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740522197;
	cv=none; b=OE+iPjyg87G7gC3zGS9nr6ia/Dl7o2H5kOkBX+BzhsbQsio/nq667013ZM+xXNX6kbTNUeRBjo3zKdvfNhm3de3TpiUNKl1ftKpkrZuh5SDlaF5ilK46OJdjNtDjKfFBbDKVKRbjje65I83A3c7rvlae1k+2hXzG2j/6gFujIjXNcEzkBEe/tvi601aB6XLjWr+l67FiPJuU+iER7yiqavc4/1cyYN0HVsT9lIEWTLUmeGI2AncO7RFFqaA0sRTnUfywnakTPZxnphz52Q5v7XeeUMQVAAQjDJS55vyUOcG63kq1pkXYpeuMxSsxrNEZKqGtWN19bVzBS2lCK12i7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740522197; c=relaxed/relaxed;
	bh=4YKTxXn5l9L/3067x1ZnZ8w6M1gB59GICvb9XtTgB0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Plj6kSh4uoDvrq4lIkyd6fOHxNdjfxbLQ74KDDNf0aUA4Ru0nUZijejvEkf4l/5nCQTfN9fdc225eCddrstukBjrdeHNUUjfUvP0r2TrsPn3zp/IFKc8S5e3PDjn5V1S59k9twY5+yT2Bf3JsYbE0cfwV4XOnPxt7cfj3O8J2wlXJ2RnYPWpWtxnRJdrOe9uKYb4r1IgWl6rJy6SkzOWFRCoT9RYapUeGQoaKVjbFUl4cm6yXORekeLfspsfU2HG0fV481VV8byBl0S6jA/RXFMm93mAm+LYUBaPA7cjcAbPteSe+wAlHoIbSwRlERSSjTpEv86NMI6gwrtAJDCgbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LC3ir0+O; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LC3ir0+O; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LC3ir0+O;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LC3ir0+O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=asrivats@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2XDh5qjdz2ypD
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 09:23:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YKTxXn5l9L/3067x1ZnZ8w6M1gB59GICvb9XtTgB0s=;
	b=LC3ir0+OZKAoIFN09kk7QIu3MUoz2vSTyEdNft0hRwMd0ptV/NW82p4k+JAWm6Glyqc6pZ
	JxRt/2wPaoLjhBng/0k7NHz6gPVL8BH0R5B49IY1IAPQecE9VM+35JbOHnQ4D3nnsrtAGr
	wLNTD5jp0yFzi5kmzqCfN2FpA6r+gzk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YKTxXn5l9L/3067x1ZnZ8w6M1gB59GICvb9XtTgB0s=;
	b=LC3ir0+OZKAoIFN09kk7QIu3MUoz2vSTyEdNft0hRwMd0ptV/NW82p4k+JAWm6Glyqc6pZ
	JxRt/2wPaoLjhBng/0k7NHz6gPVL8BH0R5B49IY1IAPQecE9VM+35JbOHnQ4D3nnsrtAGr
	wLNTD5jp0yFzi5kmzqCfN2FpA6r+gzk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-oa49bnmHNVqMO6CG_JqJbQ-1; Tue,
 25 Feb 2025 17:23:08 -0500
X-MC-Unique: oa49bnmHNVqMO6CG_JqJbQ-1
X-Mimecast-MFC-AGG-ID: oa49bnmHNVqMO6CG_JqJbQ_1740522183
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D68F01903085;
	Tue, 25 Feb 2025 22:23:00 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D5CD1800357;
	Tue, 25 Feb 2025 22:22:51 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Feb 2025 17:20:53 -0500
Subject: [PATCH RESEND 12/12] Documentation: Update the todo
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
Message-Id: <20250225-memory-drm-misc-next-v1-12-9d0e8761107a@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740522045; l=1573;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=/15qlsboM6yCAvaydvQcsEN4W06HB6cK0UlxWA8+/dI=;
 b=ctwB++vs/uJo3W74tDO1hgYWH+/4RjK1rS8II5NkImDP6J2u1dRysoaEir8KpfcS5eR2mtRZk
 klKUEMHenKeDWvB9gJk66H8NhG2Mti3PcGp+7DJwrN0qR8FJ1Dt9Wf3
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
2.48.1


