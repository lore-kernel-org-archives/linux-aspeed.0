Return-Path: <linux-aspeed+bounces-4350-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB2DC43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSC2cvjz2ygW;
	Sun, 05 Jul 2026 15:36:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783190012;
	cv=none; b=iX3eq0enUdkHsh24DC0A9KGNeAFMe2oEkQzm2HEKIycS0ot/09QmugEQR2djng0eeY4R9dFbklonO9WIgfkQdVUgxCt5hN30RqBr+NfhVUbKZ6xAZchIxSR9ca2JKCNI/J8uqM4Qx/EzVzaPPohWtU4eOL59l9BvvFqvM7CxaOdo3Z03U+dBYSl4eXleuB1rkCZEIBpc2rO+sEm1pHeDo7cgbfL6KU0uOUizD6ABHfvWZRlDY+RsaRUNkDbYhVojAanqmJklEuGjBnyv3eEpK8/VyYLs9jyliCZsxLjaKM2PTxHYuV4XhHQQ30kyPiNDDAVu/9sXm4MpOHjhqzHWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783190012; c=relaxed/relaxed;
	bh=g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VczhOkKh0b9Uqp/Ga1txie6u69AY7AEk4FGfhkmnquNaSm2n2C4cvXwqeoOFj3kbKfUcja+0lYQdW2X//N3QeMkjwleHzVxxISvh/g4DhdnYIIoQxrp5FosiJl7hbNmzmo+Isi1CGUoGUWRFne18PFvHQDFDjE9N43s86Qo6YFN6fK4s1EMuAYbNkvrCqPiKUgoreVOeWUw6A5IeQb+7ptBg6LJDr9+5ovg5KvPb1uUsx7yCwSe3fnSLTJXU7rwE/G9ZrdmGZUwBkB47GtCz+XRD8mgRvSDhPHyZBNaVoUOLuAJtF8akkhe/mjikNpORcAdKBHT9X2wVYnmEB+UyBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6KKvrhm; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AyNDWyJI; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6KKvrhm;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AyNDWyJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszlb6lbZz2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:33:31 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664G8L2E3293625
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=; b=W6KKvrhmeJ2fyG7f
	WVeIgvI7yc1jiGCDVMy8ENc4fDLxlrrfJe8IN0O7lmm2B65JmceQegoTuxl0Zy4Q
	OqrwkMJhj1H45TKfCC4YEbJgkLuuqCQWQ+x7QobwEfYeReDSSCL5wWTZivIRfWQf
	ZJvG8MRhzMrHmL/91mXHljlnNhNPpfDOq9WZgplUeCnLLFjKY3B6g8sVRCTh67r/
	N/u3p+SV46iH5sChKzMK/1uJIPHpraflaat1ixydDZW7kQwP9UJMiq81VaHpAprp
	JpC6F9G6ErO9rXO+wqrCAT9MR9ncg2ZJVslkCM+/pUyt+MTHGF3FE+8IziiOj809
	wXvMLA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txeh99y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:33:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8478423e020so2625364b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783190009; x=1783794809; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=;
        b=AyNDWyJIWscKOKkto/15rXyuL/QIStzU6LONQSF2k1BqizDIqBk1XcsyC/i9nf9ShM
         DQp83l5ABZoTj83CXKZUsOx9taJG19XuTwOTa9yvX9CBb7J0hrypoR8F78rSx94YUtp6
         2b6I0L9IO7dMT7r8O6r2N7VaYnwydPdz3KSW2803xBEHu4S1p4AZFBr4yODAK8mrJJEa
         GeIGiVYqTn25zdNCrz+DB+megFHcj4f1tTKP0Xwd/QiB63R9p/OaM32MVT6dsQKl11EG
         K3x65rHJMF16WgMtLIHoVh/heHg5YsEcg3NsPb6FCn2D+FlRn4vujju2XGbUkL6aTBzB
         x2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783190009; x=1783794809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0BtnuFOv0FQCXxUBDMLCWTcgE0j6FLXPqatMYGCcJA=;
        b=ByvHcQKfe7wZkTRPL+/k8xKv+rmg0fFcR2t+NMQ0sGQg5lOFg1bwm9SlWGAionmgwD
         BvW4j/p8tGsms4una7LHGOKTPOBSHeZhrgm+3cob0ShVQ3pHIlybzOPMzWRLm1XLjMYu
         TdMaKpM/o+UTzPAgxzF8ScbARO4rt7Rx4L/IM9Y9m5PxbSk2+c82FBi3VvMuXFWmScm4
         4gzo5eOQO791AVLmD+8gjBxelhcI/Z4nK8HqZH2QNOH7gciWWPuGobCLn37kKDcYaHZS
         Z39/PAYm9eHkTeHJPPKVhEoUVknKf8Jyz3MwdNXGKEoJVuaS41rT1tnk787Y/DadIjsu
         NzXA==
X-Forwarded-Encrypted: i=1; AFNElJ87zHVKamw38VfM8aHHRs959Eu2HdWy2oPh6vKf6SLYJHVZq0z0MSWIRObwDDuTrkIBloAY/jGpdKNQaEk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUyYmezCwPpKVHialB0HgJh3dQbwPMh/4HkOeYRXFX7X/5hXKZ
	43q5mE29Y+8r3bn+eh9wgKOex18HqITYxLHTTcmNd8fZFbgbIl0eUYghXNcrbbSqI7ehK31jNsg
	b1VZAG3MNERQEUZDZKfFILKFbgBDdDwB2lZ/18+QfpNYscz/C+JuwqNGtPQgsXY52psMBEGhccp
	rLZ1+pXw==
X-Gm-Gg: AfdE7cnqJ2aONekZmvc+Js8anEH1hM053mBlblZAEhhPZZeUk5XNlCWx392HOc1h/di
	6m6Cn0aGwPOvaRv2lOBeddeo/TiWn5bEMgcTLx1Dk+M4Xfpn7JGnodWxzUTQonkNc+LhlCQFqE/
	c23cuAP5vaRF5q0WvOXlQwXgLC1DwftAXXdXM3Ejw7NbAfIEtI/YICTJbYL14t/YtV4Y32roPrn
	hHOYA9FmnuVPIufIK1KiPLnJkJ+tBAO5ZYvg/nZlHjC089OqCjN+q2eavM00yTUV+52tAiF15kB
	ryXHdOfWLUOdYLtd8lp3cfZvlRdzGn4MRamm/4KzzPTmOkmhK7S8At/9KeHwDTh5GuJ0iFtrsD3
	f1nySFbdc6+KDwb1VpMJQzcM=
X-Received: by 2002:a05:6a00:e05:b0:845:d274:bfa3 with SMTP id d2e1a72fcca58-847f6f96cdemr3661060b3a.58.1783190009293;
        Sat, 04 Jul 2026 11:33:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:e05:b0:845:d274:bfa3 with SMTP id d2e1a72fcca58-847f6f96cdemr3661037b3a.58.1783190008770;
        Sat, 04 Jul 2026 11:33:28 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:33:28 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:17 +0800
Subject: [PATCH 8/9] drm/tve200: replace struct drm_simple_display_pipe
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
Message-Id: <20260705-drm-simple-kms-removal-v1-8-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
In-Reply-To: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=12559;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=IU9daMuh+wIrKu2A7tjNZQhHlWlCXrpg0Z3XcY9yMsA=;
 b=wca2bARZyhz/O2pE/2ultazGgfCDL/nXmuhK0zZODTqz3phtgEMU73vuIDTkXkqZJvrB1l2Xi
 pazMWuCMQ9XDkjSq9DKd98nVhHWb8WoQEKSNkWUUn6L6rvw9PKEzFZA
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX/Xmiv/hnX3Mx
 8f3awJrGGGxYW386RH7a92XSiiako0KO03vzt7XSTKFDOz++NMcyL6uiSN0MOh8r3HcYTHxYG84
 a9JfAjpU4VoRipkr2zRVEF2tdmZFYoM=
X-Proofpoint-GUID: AP0jhW8ikr7nQXroQKzZhmGuse9KtdFa
X-Proofpoint-ORIG-GUID: AP0jhW8ikr7nQXroQKzZhmGuse9KtdFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX6HwYkhBPinzW
 I3oCsJoH1XPstlcQQEin6Zb8fcSP3L2iNNjF9Ay5ZQWo553r+EiOrUSforuCvW85RGi1riw1OfS
 rjET0M/Lo8JJb5d5bUkC97zo5mMYYP/xejBI1iRBJ+Zslui8fL2sR6lfguoe/uaaJXGd2Kskk0c
 gM6yLfseInNAqgt9g4wws+KSdXR1+6Dyisr+0Pei74+kwfku2dh5ya40nINASyok0x3AYkYRZfH
 PotzyHfw3cofoyp1YdvclAdezH5Z+36cNvbIHM/u4PtGFLz+Fc+qzZdDhkZT108w5FuXJ93q5w7
 FTxn2EM1G4IyX75TYDf8KvxeC6ls6f6e0TfMrS44mZg4DdWQojICLse1cVfiVVm7pAZWJRUYpxd
 1cgKFnuOjMu4JkKf3lqWGnIcOcsQ6Ne29IJMrrr3hvXLmIbRyYWlppiTNf3LGrnCwWIGADZAKqR
 WwDdEiVLy9I5GvlcHYA==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4951fa cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=dgwnEUiFKTnKxPjcC9oA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

Convert TVE200 to explicit plane, CRTC and encoder objects.

Keep generic plane-state validation before TVE200-specific mode,
alignment, pitch and format-change checks, and install GEM framebuffer
prepare helper explicitly.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tve200/tve200_display.c | 221 ++++++++++++++++++++++----------
 drivers/gpu/drm/tve200/tve200_drm.h     |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c     |  17 ++-
 3 files changed, 168 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index 26b6c65ef6fd..8fdf69e8e126 100644
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
@@ -69,13 +71,34 @@ irqreturn_t tve200_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int tve200_display_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *pstate,
-			       struct drm_crtc_state *cstate)
+static int tve200_plane_helper_atomic_check(struct drm_plane *plane,
+					    struct drm_atomic_commit *state)
 {
-	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = pstate->crtc;
+	struct drm_crtc_state *cstate = NULL;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = plane->state->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
+
+	if (crtc)
+		cstate = drm_atomic_get_new_crtc_state(state, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(pstate, cstate,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+
+	if (!pstate->visible)
+		return 0;
+
+	if (!cstate)
+		return 0;
+
+	mode = &cstate->mode;
 
 	/*
 	 * We support these specific resolutions and nothing else.
@@ -119,16 +142,73 @@ static int tve200_display_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *cstate,
-				 struct drm_plane_state *plane_state)
+static void tve200_plane_helper_atomic_update(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
+{
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_device *drm;
+	struct tve200_drm_dev_private *priv;
+	struct drm_pending_vblank_event *event;
+	struct drm_plane_state *pstate = plane->state;
+	struct drm_framebuffer *fb = pstate->fb;
+
+	if (!crtc)
+		return;
+
+	drm = crtc->dev;
+	priv = drm->dev_private;
+	event = crtc->state->event;
+
+	if (fb) {
+		/* For RGB, the Y component is used as base address */
+		writel(drm_fb_dma_get_gem_addr(fb, pstate, 0),
+		       priv->regs + TVE200_Y_FRAME_BASE_ADDR);
+
+		/* For three plane YUV we need two more addresses */
+		if (fb->format->format == DRM_FORMAT_YUV420) {
+			writel(drm_fb_dma_get_gem_addr(fb, pstate, 1),
+			       priv->regs + TVE200_U_FRAME_BASE_ADDR);
+			writel(drm_fb_dma_get_gem_addr(fb, pstate, 2),
+			       priv->regs + TVE200_V_FRAME_BASE_ADDR);
+		}
+	}
+
+	if (event) {
+		crtc->state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
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
+					     struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(state, crtc);
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_plane_state *plane_state = priv->plane.state;
+	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_connector *connector = priv->connector;
 	u32 format = fb->format->format;
 	u32 ctrl1 = 0;
@@ -240,9 +320,9 @@ static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
 	drm_crtc_vblank_on(crtc);
 }
 
-static void tve200_display_disable(struct drm_simple_display_pipe *pipe)
+static void tve200_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct tve200_drm_dev_private *priv = drm->dev_private;
 
@@ -255,46 +335,8 @@ static void tve200_display_disable(struct drm_simple_display_pipe *pipe)
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
 
@@ -304,22 +346,49 @@ static int tve200_display_enable_vblank(struct drm_simple_display_pipe *pipe)
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
+static int tve200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	int ret;
+
+	if (!crtc_state->enable)
+		goto out;
+
+	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+	if (ret)
+		return ret;
+
+out:
+	return drm_atomic_add_affected_planes(state, crtc);
+}
+
+static const struct drm_crtc_helper_funcs tve200_crtc_helper_funcs = {
+	.atomic_check	= tve200_crtc_helper_atomic_check,
+	.atomic_enable	= tve200_crtc_helper_atomic_enable,
+	.atomic_disable	= tve200_crtc_helper_atomic_disable,
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
@@ -346,13 +415,31 @@ int tve200_display_init(struct drm_device *drm)
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
+	if (ret)
+		return ret;
+
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
 	if (ret)
 		return ret;
 
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
index 562f3f11812a..e2e8346acbb8 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -105,16 +105,21 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
-						    bridge);
+	priv->panel = panel;
+	priv->connector = drm_panel_bridge_connector(bridge);
+	priv->bridge = bridge;
+
+	ret = drm_connector_attach_encoder(priv->connector, &priv->encoder);
 	if (ret) {
-		dev_err(dev->dev, "failed to attach bridge\n");
+		dev_err(dev->dev, "failed to attach encoder\n");
 		goto out_bridge;
 	}
 
-	priv->panel = panel;
-	priv->connector = drm_panel_bridge_connector(bridge);
-	priv->bridge = bridge;
+	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
+	if (ret) {
+		dev_err(dev->dev, "failed to attach bridge\n");
+		goto out_bridge;
+	}
 
 	dev_info(dev->dev, "attached to panel %s\n",
 		 dev_name(panel->dev));

-- 
2.55.0


