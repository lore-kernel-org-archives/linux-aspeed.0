Return-Path: <linux-aspeed+bounces-4505-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9CBC44526
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DPF5lsyz3c57;
	Sat, 18 Jul 2026 14:31:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784192621;
	cv=none; b=VLS/yQBr6Gf8atpn+MQlwPYlVdIeLpeivY5OMHcM6lc9hZuUwH/jylHXFbw9wNXhBTvmtZj/OLembV8Oz/8QWeG2/ei0UMj4ImAs6/8AdXj1QIO91S8+83Z/y1wNu9e6pD3lgbBOA3+3hQjqBGCT3Olc8Cmzo73Y07RF9CHCzLnuTE6ohCPOf//Bu3E7V4PwE81wKIyTcbabV9For/vdItUe8WgNKn35dhgZtF7CmWidCkyd+tBURuInnHYohl4oU7AwCeQXDgTyACWowM0txp0nVTopOuMjoKmRwACxev4wzFmN1FBRW/dD4+U/ga8Xukaku6MHgEjrON1eYKaG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784192621; c=relaxed/relaxed;
	bh=cXDzlp0Mz8ahuhkKRd5AdRfYSWy40uSfi+gwEDZHB1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbBBNrHeU9zmRtgj9Bgl69jRCG2Xnan8/b0uGP3fcp4gTrAacuflthCBZzkFNavSaD6ro3onIuecazAtymoRjJ9B+kUvAsqBucrpXH8H0jTLbvQS2SRTnc02lqXehZQABGlwsL2VV7DVrlJ75Md1/awI7joaVVGIm5gvhmnQ2KUUCEGJ8X1UITttR9pnp/V/Eph5BGyNEkRSd3ZEgCe44ecfBWbzTdd/PNK3bZczCJAd9xSWXHbB6ZYuoT+NriJbNaba3joEFkZeaZrzsKdfnZszDB7S07NVg1uKtgBAsXKKkVo0wUSOJo5BihthxmH7CWxu7bhLTKWMlB8NvymCNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HO+D16pl; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j8tMri1E; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HO+D16pl;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j8tMri1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h16XY178pz2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 19:03:41 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DPEe2102710
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cXDzlp0Mz8ahuhkKRd5AdRfYSWy40uSfi+gwEDZHB1w=; b=HO+D16pl5NnizWLT
	EiMKDbufmks1qDlaQmm1bJz9KtHJwjUUnFtC4Me8/8F36stmqHRtBitdEEowis42
	Czjd1k9g6jTFrBIkPRKARjHghPuGlbRrFzUjSyKg4sIRVah6bmHxFnhNggLNKtDN
	6LwFrZ/16Im1HNnxucmuQINDVjXIzrL8otMAYymHT4IbqXFio6vLxD7ML6EUARO7
	h/oK7i6SVbP6XjgA770I5CoABfF8si0W7ccqtMQmYbU2TUT/b2dMzt9sNMKs6+/f
	b7U6y2Np8ogkNabFyqwfqFxd9FMgcDNaN9pWrCBypJwJFv7mZVeE4zlXT88wTA6E
	EEqdlw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4w9jad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc8bde6318so117357935ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784192619; x=1784797419; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXDzlp0Mz8ahuhkKRd5AdRfYSWy40uSfi+gwEDZHB1w=;
        b=j8tMri1Eg2q/tztUj5ordMn8wqwFD4c+h6wKl1Pg1CrOKB4mZP0rLybD7GdV6yv4zW
         nuQ7xQHGxRJVmUHtLUP8YPtoOin+RGioT3jTMa9cF5LTwKHiESsflsHvECfQod8eS3VM
         Yx8F+iR/jOZaSeK5FFJbOuwFsd4vqIMU0Np5BnA02VIWdTg4eYzauaU8oUJhxfXSyrs8
         tjIczh/eXr5X3XpUvWVVVcGdPnrrQezFYMRZBaAxj/mQpg+J7Y6a9mywLGPzjNekKZ4l
         3heZpJWIWBHvJ26aN2eEU45SR5h4CyW00HKJnPay+cjkkp6XvEXcPM3rpQOR35PjnzbD
         dgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192619; x=1784797419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXDzlp0Mz8ahuhkKRd5AdRfYSWy40uSfi+gwEDZHB1w=;
        b=JfPGAsnGWD4QnYeguiWmGhuz+trqWmJTzd7xM6KTLGB0+cSAgkQ6Nip3ZolWinOHei
         3cTEelp8fqIIf0Z4U0GKJ04LeO1pChMwgbp6JyM3mlsZnbsord5edT8S6gbqvVZE1z91
         Y/kdDimGJEQ1Em6rGA2ZrXLUL7GoFUL4nZYDuZZJz1KNmYB82es1fl0ETH1The5Gefav
         uqbH3fwNDzVN07oFKFzfJHxGXlOckQxvaUP8D/EIkT9a0j+TWtsJcSLYGFNJuASWFP3v
         mhhsGRNxL4MzF7aFvVnntXuvJVWtkKBtMIJdyzJ9a4pjG9yD0j8d9BEzqfsXJSevfXoe
         o+zA==
X-Forwarded-Encrypted: i=1; AHgh+RqIPX/7l/pHsYd3DyqnoSWP79pfvTbPUHjfebEoaUEn2jjwoP5N3iQj82EroRHE4MpDg8mN1akNoNARI0A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxA6um+ce/tgkppjnSxi6ckN/qNW4zYh1OaDvaRhfADnjhYIhab
	qq1QSeHVrlEwzW9qvqrIa7vzQRoGZFgdE7/Bn+xLIw6UHc5MyW7hJ/t+uIZzEI0FesiCVXnNWrF
	qbtAhvy62uL0k8h1vSEN+7FmcX6ByppWrOmOT/ggSL02fSTh2IgdYt439wxPbcR6PIfBu
X-Gm-Gg: AfdE7ck6l0B74MqzPZfrK1ducSSObtxrL7bR3L1uHcWCjadBizVv6Pj5S8upPSrf5bb
	I5JFZMmdWlDjz9aPgTuwx25LggI63G5qdDhjF3uwSloGxA2Xm0e3CS5nV0jmS0pxfCKZ4eJfZbN
	b5OGTRQhoCscp0VJ0NBjS3eNuVenShVT5wv5Ikei34lbrALCPO7qv07U62kq7jk1MshWQvunWLe
	NWRGiU+PBjlQKwPXLxJU/2bGDZayfoAPchluf3TBVx0mMwTkd+NVf3Q4LpQNzL1FQyXwoKN48ws
	tGlw+J95QLy7/p1O42M4GP5RyMxBTB2rq1dVcQa8z/6MwKK17CZMqSZTl3n+dZ5HfnLPP9REZ+F
	T7756EWrw8NnA7o1UjpX0
X-Received: by 2002:a17:902:fda8:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2cef1370d34mr95423045ad.43.1784192618454;
        Thu, 16 Jul 2026 02:03:38 -0700 (PDT)
X-Received: by 2002:a17:902:fda8:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2cef1370d34mr95422605ad.43.1784192617798;
        Thu, 16 Jul 2026 02:03:37 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:03:37 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:01:59 +0800
Subject: [PATCH v2 7/8] drm/tve200: replace struct drm_simple_display_pipe
 with regular atomic helpers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-drm-simple-kms-removal-v2-7-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
In-Reply-To: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
To: Alexey Brodkin <abrodkin@synopsys.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192560; l=12710;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=1viaAX+744S54GCG+tWfVVj2xmjTbnyOumJ6LSWV5BM=;
 b=O8lpuoMTn2tkvb1RSrnDKTTQNtcFREO2jObb3WocoCvGUqjOl9Y9c3xswWhyXseEslHU7pcEk
 GcfaTN4aIRaAKXobRA8r0gDPuaWc00NDSyh2r/gWBxcdWV2JfOEcbIS
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a589e6b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dgwnEUiFKTnKxPjcC9oA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: n706YY3FGuIiqv0ZLCsHyaXfHjdvs4ih
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX0FA2HtWDR+HC
 HGbIFffH1EG6lmtPoPnYJTEZnxkwKpsQCyqs7GoWi8HbdeXW1A+N66+efWhnn7dUYQ9MNlrvk5E
 x1r19hvywqc0AI0iYEXMynz6FWlTNw0=
X-Proofpoint-ORIG-GUID: n706YY3FGuIiqv0ZLCsHyaXfHjdvs4ih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX4zbXHqcSrHFW
 1KOYkCC34jJqPTlu02OoZqrvn88xVzZaW/FD7NKoXA8etW0u1Ox6Q2DAuV6/Js7c4CNeZ0ym0wH
 g5E7XzF0Rx4dLfRMgD2+62ChTRpNBg1hbe8AtLJEGzXvsa1pDS1Tg0F0TGM5hPYxihVnM5dcZ0B
 iEawn0esKws/CiNjVo4eRnsrf4zW8ex1duzmc8UED6c3LxnL69nUAtTlQHJv5irNjRrs0BdiLjR
 b0jHOGWHXIUmqmrbppFnJFcyndcvt1ltxiU6qiG0jZND0lttN7VRQToJdR9QCMPtgzKQZ1veYi2
 /XKccdc9pdQ5Wyh0T9dA+hhbMdZ/2tzNckkDlpCQGS7iKbCbm6LCQJ5jCVk+VLO+0QpECAPjI13
 NdnK2Z96CvpZnURpiHTBHJH0mi40xDJM+Lto34vQUPAAocsDvafsFrbe0RPzYsOkBQ+S/RFKh0j
 B80JWXTiZkNLGCEVuRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091

Convert TVE200 to explicit plane, CRTC and encoder objects.
Keep generic plane-state validation before TVE200-specific mode,
alignment, pitch and format-change checks, and install GEM framebuffer
prepare helper explicitly.

Move page-flip event handling to the CRTC commit path and wire the CRTC
vblank callbacks explicitly so events are not consumed from the plane
update path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tve200/tve200_display.c | 217 ++++++++++++++++++++++----------
 drivers/gpu/drm/tve200/tve200_drm.h     |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c     |  12 +-
 3 files changed, 161 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index 26b6c65ef6fd..6021f90d8531 100644
--- a/drivers/gpu/drm/tve200/tve200_display.c
+++ b/drivers/gpu/drm/tve200/tve200_display.c
@@ -15,6 +15,8 @@
 #include <linux/of_graph.h>
 #include <linux/delay.h>
 
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -52,7 +54,7 @@ irqreturn_t tve200_irq(int irq, void *data)
 		val = readl(priv->regs + TVE200_CTRL);
 		/* We have an actual start of vsync */
 		if (!(val & TVE200_VSTSTYPE_BITS)) {
-			drm_crtc_handle_vblank(&priv->pipe.crtc);
+			drm_crtc_handle_vblank(&priv->crtc);
 			/* Toggle trigger to start of active image */
 			val |= TVE200_VSTSTYPE_VAI;
 		} else {
@@ -69,13 +71,32 @@ irqreturn_t tve200_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int tve200_display_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *pstate,
-			       struct drm_crtc_state *cstate)
+static int tve200_plane_helper_atomic_check(struct drm_plane *plane,
+					    struct drm_atomic_commit *commit)
 {
-	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_crtc *crtc = pstate->crtc;
+	struct drm_crtc_state *cstate = NULL;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = old_pstate->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
+
+	if (crtc)
+		cstate = drm_atomic_get_new_crtc_state(commit, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(pstate, cstate,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+
+	if (!pstate->visible || !cstate)
+		return 0;
+
+	mode = &cstate->mode;
 
 	/*
 	 * We support these specific resolutions and nothing else.
@@ -119,16 +140,72 @@ static int tve200_display_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *cstate,
-				 struct drm_plane_state *plane_state)
+static void tve200_plane_helper_atomic_update(struct drm_plane *plane,
+					      struct drm_atomic_commit *commit)
+{
+	struct tve200_drm_dev_private *priv = plane->dev->dev_private;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_framebuffer *fb = pstate->fb;
+
+	if (!fb)
+		return;
+
+	/* For RGB, the Y component is used as base address */
+	writel(drm_fb_dma_get_gem_addr(fb, pstate, 0),
+	       priv->regs + TVE200_Y_FRAME_BASE_ADDR);
+
+	/* For three plane YUV we need two more addresses */
+	if (fb->format->format == DRM_FORMAT_YUV420) {
+		writel(drm_fb_dma_get_gem_addr(fb, pstate, 1),
+		       priv->regs + TVE200_U_FRAME_BASE_ADDR);
+		writel(drm_fb_dma_get_gem_addr(fb, pstate, 2),
+		       priv->regs + TVE200_V_FRAME_BASE_ADDR);
+	}
+}
+
+static void tve200_crtc_helper_atomic_flush(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_pending_vblank_event *event = cstate->event;
+
+	if (!event)
+		return;
+
+	cstate->event = NULL;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (cstate->active && drm_crtc_vblank_get(crtc) == 0)
+		drm_crtc_arm_vblank_event(crtc, event);
+	else
+		drm_crtc_send_vblank_event(crtc, event);
+	spin_unlock_irq(&crtc->dev->event_lock);
+}
+
+static const struct drm_plane_helper_funcs tve200_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= tve200_plane_helper_atomic_check,
+	.atomic_update	= tve200_plane_helper_atomic_update,
+};
+
+static const struct drm_plane_funcs tve200_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static void tve200_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *commit)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(commit, crtc);
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_plane_state *plane_state = priv->plane.state;
+	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_connector *connector = priv->connector;
 	u32 format = fb->format->format;
 	u32 ctrl1 = 0;
@@ -240,9 +317,9 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
 	drm_crtc_vblank_on(crtc);
 }
 
-static void tve200_display_disable(struct drm_simple_display_pipe *pipe)
+static void tve200_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
@@ -255,46 +332,8 @@ static void tve200_display_disable(struct drm_simple_display_pipe *pipe)
 	clk_disable_unprepare(priv->clk);
 }
 
-static void tve200_display_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_pstate)
-{
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct tve200_drm_dev_private *priv = drm->dev_private;
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
-	struct drm_plane_state *pstate = plane->state;
-	struct drm_framebuffer *fb = pstate->fb;
-
-	if (fb) {
-		/* For RGB, the Y component is used as base address */
-		writel(drm_fb_dma_get_gem_addr(fb, pstate, 0),
-		       priv->regs + TVE200_Y_FRAME_BASE_ADDR);
-
-		/* For three plane YUV we need two more addresses */
-		if (fb->format->format == DRM_FORMAT_YUV420) {
-			writel(drm_fb_dma_get_gem_addr(fb, pstate, 1),
-			       priv->regs + TVE200_U_FRAME_BASE_ADDR);
-			writel(drm_fb_dma_get_gem_addr(fb, pstate, 2),
-			       priv->regs + TVE200_V_FRAME_BASE_ADDR);
-		}
-	}
-
-	if (event) {
-		crtc->state->event = NULL;
-
-		spin_lock_irq(&crtc->dev->event_lock);
-		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
-			drm_crtc_arm_vblank_event(crtc, event);
-		else
-			drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
-}
-
-static int tve200_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int tve200_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
@@ -304,22 +343,48 @@ static int tve200_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void tve200_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void tve200_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
 	writel(0, priv->regs + TVE200_INT_EN);
 }
 
-static const struct drm_simple_display_pipe_funcs tve200_display_funcs = {
-	.check = tve200_display_check,
-	.enable = tve200_display_enable,
-	.disable = tve200_display_disable,
-	.update = tve200_display_update,
-	.enable_vblank = tve200_display_enable_vblank,
-	.disable_vblank = tve200_display_disable_vblank,
+static int tve200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	int ret;
+
+	if (crtc_state->enable) {
+		ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+		if (ret)
+			return ret;
+	}
+
+	return drm_atomic_add_affected_planes(commit, crtc);
+}
+
+static const struct drm_crtc_helper_funcs tve200_crtc_helper_funcs = {
+	.atomic_check	= tve200_crtc_helper_atomic_check,
+	.atomic_enable	= tve200_crtc_helper_atomic_enable,
+	.atomic_disable	= tve200_crtc_helper_atomic_disable,
+	.atomic_flush	= tve200_crtc_helper_atomic_flush,
+};
+
+static const struct drm_crtc_funcs tve200_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank		= tve200_crtc_enable_vblank,
+	.disable_vblank		= tve200_crtc_disable_vblank,
+};
+
+static const struct drm_encoder_funcs tve200_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 int tve200_display_init(struct drm_device *drm)
@@ -346,13 +411,31 @@ int tve200_display_init(struct drm_device *drm)
 		DRM_FORMAT_YUV420,
 	};
 
-	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
-					   &tve200_display_funcs,
-					   formats, ARRAY_SIZE(formats),
-					   NULL,
-					   priv->connector);
+	ret = drm_universal_plane_init(drm, &priv->plane, 0,
+				       &tve200_plane_funcs,
+				       formats, ARRAY_SIZE(formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
 		return ret;
 
+	drm_plane_helper_add(&priv->plane, &tve200_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &priv->crtc,
+					&priv->plane, NULL,
+					&tve200_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&priv->crtc, &tve200_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &priv->encoder,
+			       &tve200_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	priv->encoder.possible_crtcs = drm_crtc_mask(&priv->crtc);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/tve200/tve200_drm.h b/drivers/gpu/drm/tve200/tve200_drm.h
index 5420b52ea16b..631a9f5d9aa6 100644
--- a/drivers/gpu/drm/tve200/tve200_drm.h
+++ b/drivers/gpu/drm/tve200/tve200_drm.h
@@ -15,8 +15,6 @@
 
 #include <linux/irqreturn.h>
 
-#include <drm/drm_simple_kms_helper.h>
-
 struct clk;
 struct drm_bridge;
 struct drm_connector;
@@ -107,7 +105,9 @@ struct tve200_drm_dev_private {
 	struct drm_connector *connector;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 
 	void *regs;
 	struct clk *pclk;
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 562f3f11812a..0b8096b1e600 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -105,16 +105,20 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
-						    bridge);
+	priv->panel = panel;
+	priv->bridge = bridge;
+
+	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
 	if (ret) {
 		dev_err(dev->dev, "failed to attach bridge\n");
 		goto out_bridge;
 	}
 
-	priv->panel = panel;
 	priv->connector = drm_panel_bridge_connector(bridge);
-	priv->bridge = bridge;
+	if (!priv->connector) {
+		ret = -ENODEV;
+		goto out_bridge;
+	}
 
 	dev_info(dev->dev, "attached to panel %s\n",
 		 dev_name(panel->dev));

-- 
2.43.0


