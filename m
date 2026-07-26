Return-Path: <linux-aspeed+bounces-4561-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02467C53219
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6h275Yz2ydn;
	Mon, 27 Jul 2026 10:07:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095165;
	cv=none; b=YDqQKjCHp7bUfv1zyLJnlZYDXWqFInFqpkfm6xudb1asikryUaprFPAHK2t975DtWE5TNMQFELJ/4SOG6JkmHdj/LiLXAysrM9he5FBzjW/Frcl+ezpC2SPHdhZ10nA2TAo2RELjgPs1NPpZSaDljFf96Bh2zXxraY9qSINHlA3pvwueTCcy+Xl3N0rvQvntA1qENq7GUHrdBxAfQG/FrWefypaYzB1bFI9oVVcaRB0DnjlarI4yNmpZSXanOh4w0oQVuWPWkoBtixqmByLwbcyG5q7XT8oj6eRxBEs3jB2WdaAItacS25UIJfkHtEcf5jWUHOUtOCFyyZ5dslmFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095165; c=relaxed/relaxed;
	bh=SZXoBChzns6xQdNb4HgZdv4bepAswU/wjM3061XMqlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJjOIyaQ/lp4vAZ5z6n9kqCCwA9pwlh4Kqo12nB3kx4rwN5GZZ6g58bhE5f5Hv72mrKw59qVClg03B+BlaEZQelznZ9xDztR6zxF9/h+yPMktOr/a8HT3ToRuLr/7OeILa4nDMsR+zXDgAmIAMPVn/o0pxKJDaX6pzYqWkTCuJ4ByD4jvmB0V8a+Mh/VAZvaJq16TEVWWJuMANepzY51y2kVqbPxXkR4HYQWMrYS060j5Q2zxoa8ZzM9YuSzzQ64x53pHlRiRD2sRrMfVIe+oGoljTUWWusmUGJRasFwX3L3lO0SCK04klWhgQlFLqKwvklm4L3hsTvwNjxkFItGZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O82oYMAC; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kDbmNkAN; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O82oYMAC;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kDbmNkAN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XK85ztJz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:46:04 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH7J37721720
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SZXoBChzns6xQdNb4HgZdv4bepAswU/wjM3061XMqlo=; b=O82oYMACwKC0mT9h
	woXRMDLyHeliuxVcUGvUxVvOwEsT6m+/ZqnHT01/XQUDRllrdyST0RVM6BgSdgTb
	3WNWchYfO+bqEH6TdtwTt268lP1N7ns6aiASsHgdzdNujircUG2vLpayIV9Qjek7
	+HGxn/BRlmAEXoqWaHW3sR9Oq62wnupkx68EYs7xvm8X88W1Wzgj0xC/VIsovHzK
	nkUtYsZIKzR+zT3PxPPxvK+LvaLg5e8ar29lnKgKMI9AUdGC5TbSfyHvbSAzUzNb
	JbjO6jMgdRCaVCPbaNi5/Juwd/jQGbDJ2O0Gm5rJEsV8rsJUyLm8gwqM/B/KSUR9
	7Cgd6w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajkcjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3811279d51aso3950881a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095162; x=1785699962; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZXoBChzns6xQdNb4HgZdv4bepAswU/wjM3061XMqlo=;
        b=kDbmNkANDF2CEU6YwvbEr20wYQl9wIKlH0RLy7/r67kx/u/+inA13Ut+r6qDM0kghx
         FB/ZTAR8hu/9063d5dqd/hbsc3jYiF1NDdvjQxRJR7pwoDPEhw9SGhJxUfSGS5Us85se
         a0yyo93koGs0dT3V/7hvZB7d6WJbRuwQ9cqHDd5AXHD6GHT1rwqYt1DK5zuF1Ny1X/k8
         MTSiW6fHVSzX7iAj6c6YKQ0Yclo0ld4AU3A00A9SLjNix9jlpxulk6li/Zx1tmzujYCx
         o/wo3MQg0K7yNOAp3921A4S9p5kldz8XWvXl/xJcHN8jC21j0qQQ9Jyoyg2WRDL+XhZP
         Stbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095162; x=1785699962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZXoBChzns6xQdNb4HgZdv4bepAswU/wjM3061XMqlo=;
        b=QnV664IMrRFySsM80Hxgd3iooAEVLLW6mDqOgsfc0XbsWwtImjluIDHLeGJEOqaH1V
         gAfsMchtraHnNbYv0f9DPeqDMklbeKX5V95AVM3n6MH7uKQ33eNsQI0hmYNz0+7rt/S4
         GgUdlgF2ZrxffPtPA7Yuf5Kahjwfmr+OgCfdkMgolunlWQ8IvrsStS+zb9Mw6BxutBEQ
         nVTNpzXINA8qgAoz6BT3uFM/v/tY1T2vhYVuPVc0cDrxMSbHbBEimdhs+b22oyRyArFh
         svlUlqFrMEDJ5UAqdvJzjFVHBTtxgu8tS6wEcEp8xROsaI5Y8O9fC7NOYD4A8imqmJCt
         dZKA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6luxJL0njs77ZCA8FZF7ns+0Xr1tTqh1WK86tjYRbH5YlyWupxjP2le6NaD8dNy2JG0GLIcCmn0rHWrU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyE9ddM4P8kbZcGuXqUDBI8D4FndFMX5SXJeZyYpx0GlxIOIUze
	g5/+LtqsBzhXQONua8cEigqI6zRo38qAKOGb68zAsdyV2O0OzW5kFLtkNpDUUEOnoXP3HLoJSTf
	2sGj67IaX8yYSaeNT3wYzzMVO0FhjhqIVQ32dwZ1V8uHgAZHVIH6DAslU2uF/5hgy/Go9
X-Gm-Gg: AR+sD13HBa60ZakYh5DpnnsR0syKDknAcIPhaJf9Yd63Az0iHRblYbO1ZkqAk4Hqk4Y
	YumjJER0NGhiBbA5O4qOc4gC0HJv03RM+i5dyF5hIt9fLP+Sgi7BwCg3rGnjB8gQve+BpQ7yXyJ
	CIU9uQ6uMBZJPCu1K29+UOBk878bAFpmtTnfT6eXq7douCfz2g2aGHn16n8gSnsaZbM6gUM8v28
	++SFhRaIeWJyToARcc/HnFTXkFWRraXm0PFUN5wzh6KJopz2Rg603YzsM9ULfDzpDg6+jLClxbM
	+BgTpAHA/Me1ZPyBhpsHRAVO/gpCNesJE8v/2+SpqC/vi9nS93wRg2qrOxfWidFcfLK5PN//118
	iN7DXedOi2kB8P9gJ6EqM
X-Received: by 2002:a17:90b:2604:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38f297802c7mr5136049a91.30.1785095161862;
        Sun, 26 Jul 2026 12:46:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2604:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38f297802c7mr5136018a91.30.1785095161243;
        Sun, 26 Jul 2026 12:46:01 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm4105998a91.8.2026.07.26.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:46:00 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 03:45:16 +0800
Subject: [PATCH v3 3/8] drm/mcde: replace struct drm_simple_display_pipe
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
Message-Id: <20260727-drm-simple-kms-removal-v3-3-cd5dc89858c6@oss.qualcomm.com>
References: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
In-Reply-To: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095128; l=15608;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=cG5eqORbwgLjytGSt4bgAB7iRWGJSRJOK/O7QjULDRQ=;
 b=dUv1z+8IsrXCEJL6IHnCBSpQNODfXvTKqNt5CIq2WKVnxYyxmosBGI+eSjoRCN3YWUn8RIHt+
 hGEPH0SXwp+CbxHEcC0emaV04jGmPMLiA/haus+5DmswysajzWCM2NM
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-ORIG-GUID: lh3xrO-Q5YAmfP_5sWt3P0Lmr2DE3xvT
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a6663fa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=CXBmYrQIWaHMVGb9AFMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: lh3xrO-Q5YAmfP_5sWt3P0Lmr2DE3xvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX81R8WllZAx4q
 FUxNj8cq+K1gmuaJTZV1neh6uyjBncKcGTzwi78TXYXGwbe7/oYqSYAOS5Gxv50MDXIJtVgBh32
 affcsj1dB9RMxfxnv0xN3xCtgQ2SDxR0eyeYs8TBfyCuopT69lwGsd+TKQfQaWmZF5LW/BEJoIk
 fqnE4NUfLqAMHOQ2/2zgyaWG9Mhl/RjBMEDg/KdNfJhV1jSU6JBQ65Jo7iZio6mUn1ECdLhSg5t
 xRY20SkAGtX8j7KR9UxhSfBXS3dsun+yIsrRpH3J5DkI79ff8ylqI3KfRMBcHuaXifvwu+4Bjhe
 AdAnVgN3XomhpZgU6xRCoY/zkvhuUTxp8DJyF3VzD9M+/rKO4bJJmprFPUZFxyxFQEt+Bh+jfYR
 w9UQP9GMNwG3xgHVScLdzDHZZpHh1qtqUVglrNiQ6IUqKDqHMQzaWcVmKLEntLzjSREg7Wlfa4F
 XisGJK0wwkfKteMz97A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfXyQYO6WVDOVkX
 eH/f7eUvjZYkVyCSE1rDes1C/13cUCg5T3Tz45oICE64t8zF12DBlZ3E5sSLzk4Dg5b2IGpVbHz
 IdqsD1aF3R0Jp4mpyP4rK9OgJmv0Uoc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260200

Convert MCDE to explicit plane, CRTC and encoder objects.

Handle pending page-flip events from the CRTC atomic flush path using the
commit-local CRTC state, and avoid manual connector/encoder attachment
before the connector has been created by the bridge path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

---
Changes in v3:
- Move the one-shot flow start to CRTC atomic_flush(), after pending event
  handling.
- Move the MCDE container helper to the header as static inline.
---
 drivers/gpu/drm/mcde/mcde_display.c | 248 +++++++++++++++++++++++-------------
 drivers/gpu/drm/mcde/mcde_drm.h     |  12 +-
 drivers/gpu/drm/mcde/mcde_drv.c     |   3 +-
 3 files changed, 172 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 257a6e84dd58..50c90cf84a9a 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -10,6 +10,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/media-bus-format.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
@@ -18,7 +19,6 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_vblank.h>
 #include <video/mipi_display.h>
@@ -132,7 +132,7 @@ void mcde_display_irq(struct mcde *mcde)
 	writel(mispp, mcde->regs + MCDE_RISPP);
 
 	if (vblank)
-		drm_crtc_handle_vblank(&mcde->pipe.crtc);
+		drm_crtc_handle_vblank(&mcde->crtc);
 
 	if (misovl)
 		dev_info(mcde->dev, "some stray overlay IRQ %08x\n", misovl);
@@ -157,40 +157,59 @@ void mcde_display_disable_irqs(struct mcde *mcde)
 	writel(0xFFFFFFFF, mcde->regs + MCDE_RISCHNL);
 }
 
-static int mcde_display_check(struct drm_simple_display_pipe *pipe,
-			      struct drm_plane_state *pstate,
-			      struct drm_crtc_state *cstate)
+static int mcde_plane_helper_atomic_check(struct drm_plane *plane,
+					  struct drm_atomic_commit *commit)
 {
-	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_crtc_state *cstate = NULL;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = old_pstate->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
 
-	if (fb) {
-		u32 offset = drm_fb_dma_get_gem_addr(fb, pstate, 0);
+	if (pstate->crtc) {
+		cstate = drm_atomic_get_crtc_state(commit, pstate->crtc);
+		if (IS_ERR(cstate))
+			return PTR_ERR(cstate);
+	}
 
-		/* FB base address must be dword aligned. */
-		if (offset & 3) {
-			DRM_DEBUG_KMS("FB not 32-bit aligned\n");
-			return -EINVAL;
-		}
+	ret = drm_atomic_helper_check_plane_state(pstate, cstate,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
 
-		/*
-		 * There's no pitch register, the mode's hdisplay
-		 * controls this.
-		 */
-		if (fb->pitches[0] != mode->hdisplay * fb->format->cpp[0]) {
-			DRM_DEBUG_KMS("can't handle pitches\n");
-			return -EINVAL;
-		}
+	if (!pstate->visible || !fb)
+		return 0;
 
-		/*
-		 * We can't change the FB format in a flicker-free
-		 * manner (and only update it during CRTC enable).
-		 */
-		if (old_fb && old_fb->format != fb->format)
-			cstate->mode_changed = true;
+	mode = &cstate->mode;
+
+	u32 offset = drm_fb_dma_get_gem_addr(fb, pstate, 0);
+
+	/* FB base address must be dword aligned. */
+	if (offset & 3) {
+		DRM_DEBUG_KMS("FB not 32-bit aligned\n");
+		return -EINVAL;
 	}
 
+	/*
+	 * There's no pitch register, the mode's hdisplay
+	 * controls this.
+	 */
+	if (fb->pitches[0] != mode->hdisplay * fb->format->cpp[0]) {
+		DRM_DEBUG_KMS("can't handle pitches\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * We can't change the FB format in a flicker-free
+	 * manner (and only update it during CRTC enable).
+	 */
+	if (old_fb && old_fb->format != fb->format)
+		cstate->mode_changed = true;
+
 	return 0;
 }
 
@@ -1149,16 +1168,15 @@ static void mcde_setup_dsi(struct mcde *mcde, const struct drm_display_mode *mod
 	*dsi_formatter_frame = formatter_frame;
 }
 
-static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *cstate,
-				struct drm_plane_state *plane_state)
+static void mcde_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					   struct drm_atomic_commit *commit)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, &mcde->plane);
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_framebuffer *fb = plane_state->fb;
 	u32 format = fb->format->format;
 	int dsi_pkt_size;
 	int fifo_wtrmrk;
@@ -1298,9 +1316,10 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
 	dev_info(drm->dev, "MCDE display is enabled\n");
 }
 
-static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *commit)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(commit, crtc);
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	struct drm_pending_vblank_event *event;
@@ -1318,9 +1337,9 @@ static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
 		mcde_dsi_disable(mcde->bridge);
 	}
 
-	event = crtc->state->event;
+	event = cstate->event;
 	if (event) {
-		crtc->state->event = NULL;
+		cstate->event = NULL;
 
 		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, event);
@@ -1381,24 +1400,46 @@ static void mcde_set_extsrc(struct mcde *mcde, u32 buffer_address)
 	writel(buffer_address + mcde->stride, mcde->regs + MCDE_EXTSRCXA1);
 }
 
-static void mcde_display_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_pstate)
+static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
+					    struct drm_atomic_commit *commit)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct mcde *mcde = to_mcde(drm);
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
-	struct drm_plane_state *pstate = plane->state;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
+	struct mcde *mcde = to_mcde(plane->dev);
 	struct drm_framebuffer *fb = pstate->fb;
 
+	/*
+	 * We do not start sending framebuffer updates before the
+	 * display is enabled. Update events will however be dispatched
+	 * from the DRM core before the display is enabled.
+	 */
+	if (fb) {
+		mcde_set_extsrc(mcde, drm_fb_dma_get_gem_addr(fb, pstate, 0));
+		dev_info_once(mcde->dev, "first update of display contents\n");
+	} else {
+		/*
+		 * If an update is receieved before the MCDE is enabled
+		 * (before mcde_display_enable() is called) we can't really
+		 * do much with that buffer.
+		 */
+		dev_info(mcde->dev, "ignored a display update\n");
+	}
+}
+
+static void mcde_crtc_helper_atomic_flush(struct drm_crtc *crtc,
+					  struct drm_atomic_commit *commit)
+{
+	struct mcde *mcde = to_mcde(crtc->dev);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, &mcde->plane);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_pending_vblank_event *event = crtc_state->event;
+
 	/*
 	 * Handle any pending event first, we need to arm the vblank
 	 * interrupt before sending any update to the display so we don't
 	 * miss the interrupt.
 	 */
 	if (event) {
-		crtc->state->event = NULL;
+		crtc_state->event = NULL;
 
 		spin_lock_irq(&crtc->dev->event_lock);
 		/*
@@ -1408,7 +1449,7 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
 		 * until we get an update. If MCDE output isn't yet enabled,
 		 * we just send a vblank dummy event back.
 		 */
-		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0) {
+		if (crtc_state->active && drm_crtc_vblank_get(crtc) == 0) {
 			dev_dbg(mcde->dev, "arm vblank event\n");
 			drm_crtc_arm_vblank_event(crtc, event);
 		} else {
@@ -1419,33 +1460,12 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
 		spin_unlock_irq(&crtc->dev->event_lock);
 	}
 
-	/*
-	 * We do not start sending framebuffer updates before the
-	 * display is enabled. Update events will however be dispatched
-	 * from the DRM core before the display is enabled.
-	 */
-	if (fb) {
-		mcde_set_extsrc(mcde, drm_fb_dma_get_gem_addr(fb, pstate, 0));
-		dev_info_once(mcde->dev, "first update of display contents\n");
-		/*
-		 * Usually the flow is already active, unless we are in
-		 * oneshot mode, then we need to kick the flow right here.
-		 */
-		if (mcde->flow_active == 0)
-			mcde_start_flow(mcde);
-	} else {
-		/*
-		 * If an update is receieved before the MCDE is enabled
-		 * (before mcde_display_enable() is called) we can't really
-		 * do much with that buffer.
-		 */
-		dev_info(mcde->dev, "ignored a display update\n");
-	}
+	if (crtc_state->active && plane_state && plane_state->fb && mcde->flow_active == 0)
+		mcde_start_flow(mcde);
 }
 
-static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int mcde_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	u32 val;
@@ -1462,9 +1482,8 @@ static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 
@@ -1474,13 +1493,55 @@ static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
 	writel(0xFFFFFFFF, mcde->regs + MCDE_RISPP);
 }
 
-static struct drm_simple_display_pipe_funcs mcde_display_funcs = {
-	.check = mcde_display_check,
-	.enable = mcde_display_enable,
-	.disable = mcde_display_disable,
-	.update = mcde_display_update,
-	.enable_vblank = mcde_display_enable_vblank,
-	.disable_vblank = mcde_display_disable_vblank,
+static int mcde_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *commit)
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
+static const struct drm_crtc_funcs mcde_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank		= mcde_crtc_enable_vblank,
+	.disable_vblank		= mcde_crtc_disable_vblank,
+};
+
+static const struct drm_crtc_helper_funcs mcde_crtc_helper_funcs = {
+	.atomic_check	= mcde_crtc_helper_atomic_check,
+	.atomic_enable	= mcde_crtc_helper_atomic_enable,
+	.atomic_disable	= mcde_crtc_helper_atomic_disable,
+	.atomic_flush	= mcde_crtc_helper_atomic_flush,
+};
+
+static const struct drm_plane_funcs mcde_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.destroy		= drm_plane_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs mcde_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= mcde_plane_helper_atomic_check,
+	.atomic_update	= mcde_plane_helper_atomic_update,
+};
+
+static const struct drm_encoder_funcs mcde_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 int mcde_display_init(struct drm_device *drm)
@@ -1510,14 +1571,29 @@ int mcde_display_init(struct drm_device *drm)
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(drm, &mcde->pipe,
-					   &mcde_display_funcs,
-					   formats, ARRAY_SIZE(formats),
-					   NULL,
-					   mcde->connector);
+	ret = drm_universal_plane_init(drm, &mcde->plane, 0,
+				       &mcde_plane_funcs,
+				       formats, ARRAY_SIZE(formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(&mcde->plane, &mcde_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &mcde->crtc, &mcde->plane,
+					NULL, &mcde_crtc_funcs, NULL);
 	if (ret)
 		return ret;
 
+	drm_crtc_helper_add(&mcde->crtc, &mcde_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &mcde->encoder, &mcde_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	mcde->encoder.possible_crtcs = drm_crtc_mask(&mcde->crtc);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mcde_display_init);
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index ecb70b4b737c..edbb4580a7d8 100644
--- a/drivers/gpu/drm/mcde/mcde_drm.h
+++ b/drivers/gpu/drm/mcde/mcde_drm.h
@@ -4,7 +4,7 @@
  * Parts of this file were based on the MCDE driver by Marcus Lorentzon
  * (C) ST-Ericsson SA 2013
  */
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 
 #ifndef _MCDE_DRM_H_
 #define _MCDE_DRM_H_
@@ -72,7 +72,9 @@ struct mcde {
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	struct drm_connector *connector;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct mipi_dsi_device *mdsi;
 	bool dpi_output;
 	s16 stride;
@@ -95,7 +97,11 @@ struct mcde {
 	struct regulator *vana;
 };
 
-#define to_mcde(dev) container_of(dev, struct mcde, drm)
+static inline struct mcde *to_mcde(struct drm_device *dev)
+{
+	return container_of(dev, struct mcde, drm);
+}
+
 
 static inline bool mcde_flow_is_video(struct mcde *mcde)
 {
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5f2c462bad7e..401cf8ab83bc 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -186,8 +186,7 @@ static int mcde_modeset_init(struct drm_device *drm)
 	}
 
 	/* Attach the bridge. */
-	ret = drm_simple_display_pipe_attach_bridge(&mcde->pipe,
-						    mcde->bridge);
+	ret = drm_bridge_attach(&mcde->encoder, mcde->bridge, NULL, 0);
 	if (ret) {
 		dev_err(drm->dev, "failed to attach display output bridge\n");
 		return ret;

-- 
2.43.0


