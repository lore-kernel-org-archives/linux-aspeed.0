Return-Path: <linux-aspeed+bounces-4342-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEC3C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGHm3hvzz2yd7;
	Sun, 05 Jul 2026 15:28:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783189987;
	cv=none; b=AEdtODIFIRkkVB3HlO6ItrmrXpaUowfvFmTRHdZ4JAEJnLhaQrZt9EZZvu5oBazHWyYDj9Pe910x2hwRs1jFDLWGN0OVl6x7NKRbEV6mNsm8q9E87w12JASs8YqGIMSdAgloWh81VjBV36ir+XGFCh/gjhNIvtRUJ/3A3LxwMfQ/c+4DhvR3mggYaBts7XzHPgmnbxid9QxStx7b2Uygl1++NdGwiZrkW0wZYIJW82D+vkwI49sFSjTYOJ94Oho8+GUgDfww/kFrCkkYFJhiJq3fhNMHGv8ScibcuYRwxFxzj+4i/RigaogdbKOVQTDC9CQzb0x3eOs3ldw3h+EbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783189987; c=relaxed/relaxed;
	bh=eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgTI1mzttehdihoTBxTZYcnlKckhM9K5mcC+tHJz0MOUq/IkAAoIwtYU6A6hgC60WTn1L4Kdx+qH+TP1TYXjAxsGIBf/y5b9Sz0tf3DmgQbMJz/PjO43sPP4+kuxOn9C0Lgkj2Fkr/uNaZ6Rkbt6WY6xQXWJ9dGY2R4KneqNzkycbiNGJ227va6GGr3OiszBKDGQFXeUiwPbDdClQh1vGbLe4XtN+aNsaq7Gi0nMDy75Af8r7oE4E/UJnaGnxD+gWY+jt67OsYujLatiQZUhY8uJjiFHsYxyrcTDJETFZ7LKh+t8HlJs/cSuNFWE5WDztwv3E1weuHNwsR4L4jK9zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=piotc2Xu; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PYF2g7YH; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=piotc2Xu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PYF2g7YH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszl63X38z2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:33:06 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664G8S7h3415008
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=; b=piotc2XuZr1Bos25
	5+otg4KB3av2dGCjMnxed7l9UNU1sVMI2kUsiZRBoFsmF86yqMxA6CL0XqY4mJKJ
	uLWJ26w7JLB6hTr5Y3blAe6hFdllG5Aab+MVAsOysh3S6GhGS15NxNYaOuz0dnQJ
	htQBNF/gMJPFMGVxcqqLNF37XPK2aFHwhZSIAVMt9dTDs/ETvdinooP5J+47b0Hm
	Q9ekeu9T31+WduIFfsCcgQWiIX9OcelaDpS/L77sJM9YzYgVG060Xug0K2nH30TX
	Es+o2G8e7KL9jEKWjSOVlMEZrqiwc2DJvPfilJZMgXagYwb30oTfgLMCrpBA6syy
	Ia0rew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8uhbpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:33:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8894570b58so1110023a12.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783189983; x=1783794783; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=;
        b=PYF2g7YHcjt2gDAKKknV4n62DU952d07dVQkRGbymVedekvJ/0FxFquRkS4BQj/aZc
         8KgkyQuyCbMPZAcIPBeM0n7+RvdLEtP0DPnoTF7roWfuV7Xsm4QCionP/bGwcS7h0uri
         QAdl+7/cMlcdeipK6li2fdkkpRy2peHBcDF8YdRzn8NUMsJzZCpjD4cROhODY5rWlLBa
         hKEjHQs4F4y46Iek462/SUIIOC6a2yj0/2HDw7m890o9aW0j36xQyPDBLwa/Mo+GPon1
         eENhHNauYb6+TTl1TpqYCTyr0EeF5dOqjDi8zpj6RHY2eXXnrBjc3KTuUw+zGavc6f5F
         wp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783189983; x=1783794783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQ2wkGh9OQFPGIh6+CsATSCyNIJhVVQjedvP3yUcR8I=;
        b=rQ+IhkCUD7zfHqNdtDqIAcYvULbg0EGeCScm7GVB0ROR/q++Tl0bsD51GGHXKAkSCT
         6JjrnnQL416UH/nFHoyL0U2ajD3WkWeTBDpa6esKOT5j1YGTUzYdf4OMo+9cbPCjHGJD
         l2OCTBktdCl7lOqaBzoZ7S58Hb9CScZRwKxEPRjAuX1iNlAtRMyN5nWOWOq4SQWX47DI
         gBgmjy0Z9Kaez2E9L1a2BJB/MlnqjLwj31xtZDM/hggQKFqpArdZJk4I12hJpDG5Saf1
         CUHSD2M73OisRZuWQS9qYqkjlUbHkly9xKiUXNo+oRlx2JLhezjxkp6PUbpx2AEiJjnz
         Cbyg==
X-Forwarded-Encrypted: i=1; AHgh+RouV/O+JTktNv8yrwumPvBlNdRUAcqG2qym1zabGky2/2K1jP68rSVgFzoA74VZnyYikn/v9Y3lG+F0BPM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyrfab16znfW+OmZHgyALanmcEiYTa7oU/tEsFoxhHXu8s7FKjq
	W3r/IfZrx7VBbN7xCTWKHwyivK0d4g84j2dh89ESmQRL7ItlBWGUmmECxmuuWdEjFVIfPI6QAw4
	nHRbQsXaZwrnQD26kEg/g9c/iQZSHXT5h+m85lMjwQblZWSn22TKEyuguObBNwSrRL3bK
X-Gm-Gg: AfdE7cnCprx5XAXBu0qBWJnCpewIn45ttmIgOTb+Ovz4fNsAK0TsuRDbWS/UT0Dy58U
	dL8qWXEvQnfMXiguXPHMY1PUSB+jJCHqxwKLgXblAxxS9t6/DZSjS+RUN0qJq5iP7I1e4+esoLz
	VRlZ+FvWDpYBmTzTuGNxHpOpXxZW9P5jbUh0B/s3XJB3O0z1dx84vai4tXbmHu06iFoF3CdJ2O3
	MY8L21t4Rk1hDPc8A2y/HJrCkSoRAaVuJSH8mw4dc1fM2wNS+KaMkEX14UOKHz3UdC115RpdIaI
	TvVNkHnDp5phUVPWaWRXti191NyI8I2DdZeWM8oV2PsyATKOnJaBumc/DBFNTGx/37lIT8p7y+l
	PlMernURtOy/ze54P5ExPo78=
X-Received: by 2002:a05:6a00:330c:b0:847:7f7a:dd18 with SMTP id d2e1a72fcca58-847f6d663f2mr3781686b3a.3.1783189982978;
        Sat, 04 Jul 2026 11:33:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:330c:b0:847:7f7a:dd18 with SMTP id d2e1a72fcca58-847f6d663f2mr3781665b3a.3.1783189982458;
        Sat, 04 Jul 2026 11:33:02 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:33:02 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:13 +0800
Subject: [PATCH 4/9] drm/mcde: replace struct drm_simple_display_pipe with
 regular atomic helpers
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
Message-Id: <20260705-drm-simple-kms-removal-v1-4-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=10718;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=Qcol9fj3wcEepZH3ImnK7lH90wrvdzfXhAcRLociBUs=;
 b=Mx6Ue7MKCfC0JMWj0BrhEUBH/ynLrlUW5+zwyXd6XNRIoOn78c9YTfhlfyKIIkBbAjhKd8rqo
 rj42P/bhNkcBIPjnFtFAre0a4wkLVPMpB+ZD6+uq3vfaTAz3vXXq5qV
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-ORIG-GUID: q7VqEuEKRTTmMFQ3KL9u2ooCcNFEfLRg
X-Proofpoint-GUID: q7VqEuEKRTTmMFQ3KL9u2ooCcNFEfLRg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX4V7Zeyf6r4bS
 IJT2qYJ23o6ZFdsDg2/gbZxxLF8EpMLzrXVCEcdS4qzi7lmPpSmXsjPtSjJmJVZD9mePo8UoRo1
 ga+vpK91cxFjV2uY++mePvNp/atD7/o=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4951e0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=T3BUC5bxBd2b0rxqrJgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX0G3WhTmB25hM
 ENZBtmmKamPxvc0SXAXNeem5BJr9H23kfyOihYhX6utSKaPqDxk121ougO0Ytj1i4Drfzj9CiMZ
 KPFiWGGwtwQAgutpSWGmKP3f2VWUib/yPQcyU7piyrkHAvLc++9nrKyrdGpPKcNLiucEDyWXMxE
 IBNmSC05hxrMTSm2eMgD4Zac/i4lnFKh9q6zU3E1nJVR29A7VcZxFkLljczS4fzdkQ8IinZ3Cjq
 u7ENxPAQQv1jvmKaPqWuXOYZB3YIJHGbRIBAe7qrzvY9KX2bICQTMQ7b4NnMMM8O7wft6qMjOnM
 N1IIMT0rR4m4Tz1gJ756FrtM+OQl0uu9IZTtDf7CRRq0IE9Uf1aTn4arpRImG1zJ3SewKGP1KR7
 Gqg9BFS/FJHStx2fwuwVQdG3KEcXdkv9Eqy5trmXegVSAKN40TYDCEP8/WwpVDKKsSoYP3+HHgL
 itI2J3wmSi/6tiF+I0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

Convert MCDE to explicit plane, CRTC and encoder objects.

Keep FIFO, event and framebuffer update sequencing intact, and install
GEM framebuffer prepare callback explicitly.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/mcde/mcde_display.c | 162 +++++++++++++++++++++++++++---------
 drivers/gpu/drm/mcde/mcde_drm.h     |   6 +-
 drivers/gpu/drm/mcde/mcde_drv.c     |   3 +-
 3 files changed, 129 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 257a6e84dd58..4d86fa5030eb 100644
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
@@ -157,13 +157,35 @@ void mcde_display_disable_irqs(struct mcde *mcde)
 	writel(0xFFFFFFFF, mcde->regs + MCDE_RISCHNL);
 }
 
-static int mcde_display_check(struct drm_simple_display_pipe *pipe,
-			      struct drm_plane_state *pstate,
-			      struct drm_crtc_state *cstate)
+static int mcde_plane_helper_atomic_check(struct drm_plane *plane,
+					  struct drm_atomic_commit *state)
 {
-	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = pstate->crtc;
+	struct drm_crtc_state *cstate;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = plane->state->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
+
+	if (!crtc)
+		return 0;
+
+	cstate = drm_atomic_get_new_crtc_state(state, crtc);
+	if (!cstate)
+		return 0;
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
+	mode = &cstate->mode;
 
 	if (fb) {
 		u32 offset = drm_fb_dma_get_gem_addr(fb, pstate, 0);
@@ -1149,16 +1171,14 @@ static void mcde_setup_dsi(struct mcde *mcde, const struct drm_display_mode *mod
 	*dsi_formatter_frame = formatter_frame;
 }
 
-static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *cstate,
-				struct drm_plane_state *plane_state)
+static void mcde_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					   struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
+	struct drm_crtc_state *cstate = crtc->state;
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_framebuffer *fb = mcde->plane.state->fb;
 	u32 format = fb->format->format;
 	int dsi_pkt_size;
 	int fifo_wtrmrk;
@@ -1298,9 +1318,9 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
 	dev_info(drm->dev, "MCDE display is enabled\n");
 }
 
-static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	struct drm_pending_vblank_event *event;
@@ -1381,17 +1401,23 @@ static void mcde_set_extsrc(struct mcde *mcde, u32 buffer_address)
 	writel(buffer_address + mcde->stride, mcde->regs + MCDE_EXTSRCXA1);
 }
 
-static void mcde_display_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_pstate)
+static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
+					    struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct mcde *mcde = to_mcde(drm);
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_device *drm;
+	struct mcde *mcde;
+	struct drm_pending_vblank_event *event;
 	struct drm_plane_state *pstate = plane->state;
 	struct drm_framebuffer *fb = pstate->fb;
 
+	if (!crtc)
+		return;
+
+	drm = crtc->dev;
+	mcde = to_mcde(drm);
+	event = crtc->state->event;
+
 	/*
 	 * Handle any pending event first, we need to arm the vblank
 	 * interrupt before sending any update to the display so we don't
@@ -1443,9 +1469,8 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
-static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int mcde_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	u32 val;
@@ -1462,9 +1487,8 @@ static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 
@@ -1474,13 +1498,56 @@ static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
 	writel(0xFFFFFFFF, mcde->regs + MCDE_RISPP);
 }
 
-static struct drm_simple_display_pipe_funcs mcde_display_funcs = {
-	.check = mcde_display_check,
-	.enable = mcde_display_enable,
-	.disable = mcde_display_disable,
-	.update = mcde_display_update,
-	.enable_vblank = mcde_display_enable_vblank,
-	.disable_vblank = mcde_display_disable_vblank,
+static int mcde_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
@@ -1510,11 +1577,30 @@ int mcde_display_init(struct drm_device *drm)
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
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&mcde->crtc, &mcde_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &mcde->encoder, &mcde_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	mcde->encoder.possible_crtcs = drm_crtc_mask(&mcde->crtc);
+
+	ret = drm_connector_attach_encoder(mcde->connector, &mcde->encoder);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index ecb70b4b737c..6123afb1e3b8 100644
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
2.55.0


