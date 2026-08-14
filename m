Return-Path: <linux-aspeed+bounces-4737-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C20BC5DF66
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 00:41:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNYtK5xF3z2xd5;
	Mon, 17 Aug 2026 10:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786739771;
	cv=none; b=Oc1ysdpFfc+1OlxDaHLDa49Lg8M5Rk+IoWI5cK4Aym6W0YL94dpkMR/sltqfqk9BgEvvLeNkGA6uvMHFMtyORyt0SelsNhAqUmEZUP8gvxkWIjNMyZc4F2XDbpnS6ysX0HjvtD3pXMhChSuzxp+ajpc9QIVVVI2EJG0lPOxOSxg7VCkktZhM118IDfFAwRPh3y9hPiXvwugiIX5K3mPmBjhu77onmB+igLLJp2IyBFppJX6kGYp5ANbbhNb3/oqV16ikedO6W2IhDPZazrLN2TyqQL2XFwIr9yV1b1vr0sdmZL6ngYFAFLeTHdBrFa30iVA9dJKhYqoE0fcO0tdXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786739771; c=relaxed/relaxed;
	bh=Y8HxtGS/+pDsEWZq9YYRCPV84sZrTTgU1WrgrxJbu3s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hliXl3jY71qMDIGKO9Z0iRYvVj641o4jaocXJa+7jvU90+jmrYg6LPrZwX5ZC/Kh8tT4xO5seaYnNsEoqzjxVjdFX6VItj3uWWKwKwjdX2/aloKxsUUJs9CGUB/QOEoCgkru37He2WA7KlUGkVt0nlb47qEntx+IEetCOXF7wJmRpYiejZBNVvdFuCi7ylDWKmbYoUnKnPjl1Gi52vjmiAsFgwycRG9+Fns3/R6kYn4cmX3VQfMTJwhxm2R9KEAhZUkqMBFLBh39dohmQ7G5meSOLOr6mPGKgUyfao6OK1dbjYFjevSs9gyERQNuBKPGXMEdfTJJgZwGOWujCmUcTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dA5z7iOB; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgfTQFKS; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lyude@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dA5z7iOB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgfTQFKS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lyude@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMDXB5Pknz2yRZ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Aug 2026 06:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8HxtGS/+pDsEWZq9YYRCPV84sZrTTgU1WrgrxJbu3s=;
	b=dA5z7iOB63l7igazC+YILQQmqy5uRc8hJ9M8ANjeTYuxDxMUPO+qzJyMg0gpNojhORxHep
	i4HziwgZF4Mv+os3YiDxE/k4ukZdGizpx1AC7lzoc38ah8QKeIBBmzbtaA+X5Srk91khCw
	oIuxab5A2N7NHjInBwg6vkMGFos2l74=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8HxtGS/+pDsEWZq9YYRCPV84sZrTTgU1WrgrxJbu3s=;
	b=AgfTQFKSszM+EAn628ftjV3pxLM7SaTElub1TLd0yqGa1u1hfSURb09aM19q5iG8XmF70I
	YY9UwqSEdldPfBYThoc+/Ft6aM+NX2jUQHetwA2FmbcSAXGOHp9OXbbTUP6BZNpod/nz3I
	OQddXjMPqi+MaxU800lLri0Lot+t6zk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-OoJM1A43PeiGF1bcosKBrg-1; Fri,
 14 Aug 2026 16:35:57 -0400
X-MC-Unique: OoJM1A43PeiGF1bcosKBrg-1
X-Mimecast-MFC-AGG-ID: OoJM1A43PeiGF1bcosKBrg_1786739754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC0B919560B5;
	Fri, 14 Aug 2026 20:35:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12FBC197751A;
	Fri, 14 Aug 2026 20:35:49 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-samsung-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	intel-gfx@lists.freedesktop.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	spice-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imx@lists.linux.dev
Subject: [PATCH 1/5] drm/vblank: Add drm_device.has_hw_vblank
Date: Fri, 14 Aug 2026 16:35:29 -0400
Message-ID: <20260814203542.1405135-2-lyude@redhat.com>
In-Reply-To: <20260814203542.1405135-1-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
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
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: YSutvi6WW4GxZv06WXtMmfW9VUPcYlFpYilG1r2HxtI_1786739754
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the way we check if a driver supports hardware vblanks or not is
actually funny and cursed! Likely because it predates KMS.

As it turns out, we only check dev->num_crtcs to see if we have vblank
support. Why? Because it doesn't actually represent the number of CRTCs on
the device, unless drm_vblank_init() has been called - which sets
dev->num_crtcs. And as it turns out, this is the second place we keep track
of the number of CRTCs we have.

Let's clean this up by starting with adding a variable specifically for
tracking whether drm_vblank_init() has been called or not.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 3 ++-
 include/drm/drm_device.h     | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e423..d317148af8cb3 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -557,6 +557,7 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 	if (!dev->vblank)
 		return -ENOMEM;
 
+	dev->has_hw_vblank = true;
 	dev->num_crtcs = num_crtcs;
 
 	for (i = 0; i < num_crtcs; i++) {
@@ -600,7 +601,7 @@ EXPORT_SYMBOL(drm_vblank_init);
  */
 bool drm_dev_has_vblank(const struct drm_device *dev)
 {
-	return dev->num_crtcs != 0;
+	return dev->has_hw_vblank;
 }
 EXPORT_SYMBOL(drm_dev_has_vblank);
 
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 768a8dae83c52..2df08c756afd3 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -287,6 +287,13 @@ struct drm_device {
 	 */
 	struct drm_vblank_crtc *vblank;
 
+	/**
+	 * @has_hw_vblank:
+	 *
+	 * Has the driver called drm_vblank_init() to setup hardware vblank support?
+	 */
+	bool has_hw_vblank;
+
 	/**
 	 * @vblank_time_lock:
 	 *
-- 
2.55.0


