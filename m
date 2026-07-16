Return-Path: <linux-aspeed+bounces-4500-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BBBC4451C
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DPB2vrqz3c5M;
	Sat, 18 Jul 2026 14:31:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784192597;
	cv=none; b=YdPoVf00bYC/3ffXnXHyBdKhBr0sQk/fqJiTzhcCZJUDUn04MWzCV5JVouMK+ph9uzmQeLIYTAo5Zw83c6jqPSIyjDMFRTLJAmrZF7hxxB6dbN8QFHdhQtBUMZ/KC+/v+gZR+4u7V8bmmCG/vsV9MIwzO1c2wz3m9VBShI1xwLk4M1S19ZTCYMq6zbsA3r3GoqygtCDZoJ2kjo4mQgyY9WWDK2dW/7+DJAuRGge3iMFWbDyoPzdigYCGu+ffOVxqXwTd6szhKAq8WQ0l21gvWNk3uyNyacQo/W95QzVH7JTnTLR1gPICXWcPWuk8akdcx8nF4Hkje8ZFW0xK7BR34g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784192597; c=relaxed/relaxed;
	bh=3gs6ZFn51ViIywPhcgxd9Yb4ROtm55PINNXW4yAOhhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbtAo/l85tAGM86GML6ekQedOfM1oteI0TwPc5aU2EcDrm/GUP63bojLucU4V0KylTX2sW1R/jwkFKi4kjUDaokUo1iIPH8PM0IBdzFFsHbZGjDflT2kqiIMU2B39aUiKss8jT7JIlFri+tnk8SpYeJIcCHa0A8/ZRArKEs2+HdJAHLvGmcgx735O7SXuMkkNy9pcArP2qaPlj8AXjezvnE2hoP/VUPc+qgHwiMgXt5wS5j0StSsG1oMB3OMedAjcrcgW7UTAn0mK/rAV6HxnRB8mmU2BwrQ6OJvDMFHS6AYnv84AcnqoXh/BISOVIY2AchHvG7ojkz7mQOJ+j76Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PLzkANko; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HID8RLwb; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PLzkANko;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HID8RLwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h16X44Zyjz2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 19:03:16 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DU2k1994824
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3gs6ZFn51ViIywPhcgxd9Yb4ROtm55PINNXW4yAOhhE=; b=PLzkANkoIcwLSt8u
	qxHbKYQBqEIGyO2zD8ScRdo116d1xg/kxNzHjH6wRUBPXjaSRWbwhIWprgtUuLPW
	KKXSZZjdsq6P20BmYmWkfRvjGicEbsDDRmbrScs3ts42gkrr6BG7rkMDzXfkQk7R
	XCM6gQv9sUWksFHIu4edURnNQqBEGuvw+hA2qNFkuswKLyLyNE/9rnRq6YmABhoO
	d/UeUHTGoFT6tFDGmMt/J71Jn/g9BodysDeOv4b751VtWPp0lgwJ83kqMdE538O8
	rm+50X8hZFJXBYVKeXh2Iqpxeea25a7lbs8Dt0DH1gJBof+Wx3TcwLyDz6fJjHiX
	xZ3ULw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqjwmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso82084745ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784192590; x=1784797390; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gs6ZFn51ViIywPhcgxd9Yb4ROtm55PINNXW4yAOhhE=;
        b=HID8RLwbB5lNZ8xO/f37Ztki67Qa+CmQm9A7N4rZap2NMM6oI1oA4Sqs7dRKJGFszc
         itcxPuEZKWHdEDQpZKSlW8mFdLWwCVZKDGvtrsWXOk+U+fVwVC5KPnbFzGBxMtmy0pkn
         +hKT8Goyk05SZml3tcuN88pmvV+JLyH6H7biHjKHgwvv5+wjzQfIzCFTGR+Zk4IdWKom
         mQuOtn3xJ2Un1CM9lwCn6CBApLtGK/URNaSNEZeSgBtHeYkB/NRsuZV5nRd5g/sb5QKQ
         SuZ8nkE0Akd+/3rnZV+Mo/ykt5DEi3F82Ef13Oiq1PqygyHSuXGcXXGANtm+Dx+tB6a5
         Fbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192590; x=1784797390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3gs6ZFn51ViIywPhcgxd9Yb4ROtm55PINNXW4yAOhhE=;
        b=REshlngMVCuPsjkrqAs1wHdGTPkBEvhqEEegyrZDDnuzBCDnUba+e6RX8Ug57IBxMx
         jeIwqxClU5NxqGOOF1k00/x8JqjSc5OJehXle0XiteQgdSmuOmjFIwCpmIPrw8HeLpSU
         mwdZABxg3DUDL21pDiJlnwP7ahgGMxxrmIcaIYHBqax8OkgXIbshALLc1uATljU1RP2U
         VGq1K4oaYBNSM/i1+q08taTyPnXNSjUP2aWwaSceZrM6tHt+SOSVKRbtujNuErcfKSpx
         TkRVRl3qOhr8b9YOs+jaqG9FReXGdMlY+nC5lGSaAtNGN06gUiYDTCi7G4CbC9r3MIhb
         Jz6Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro/KAit6vDZf3A9MouLF/Bmsx3n6qOXsHvgascFU7xWpLsHnj11IS+L5xSHPqBw8OE02BQ/XpoG2TZt7dU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQXn4Mp5x+FgPifkAJLEwgE4IGzsdzbKOJOuEFO1KSD6z0DhnQ
	jzmzP290Lt6JDtqsXGfbjVwfKtFFMCxw6Cbs6CMxBWLEDcNdqKnk5PriOhb1UTbQuYZCWsBcCVD
	xt/eepe6hw4vHKDVJqsNZoXamGNd36lAacT39XVmMdwLgJCHV0nRnT7xNXPs6wPHaYp+J
X-Gm-Gg: AfdE7ckwLbol+jw3lgn3SR5knIBuEWcBePOc7ApcglapgcssTb0IZtfR7kQlJ41tYIh
	Y7WfEcb2bR3AIzpWP+CJUkt6+wzWkwCl3DtXO6AXEwE7saCLgvY7A3RzESB6TdUTFLGJ3sTGW8y
	rsojVaS58tasgGtb1huQdyx8rUgSV8d0IFdk5mOfXseO9WZmo8LCgtlHRMElQNooiFE26XIZIc1
	vcjmqccLMPk3TKJIWSex6MpGkxJW8lX16uM4dsFoEkWeOWww3NVl+0mX9X9p9nxfhoy0Lg37ucL
	a82t17xTwVesZMyZACz0K0dhTq0D4Phlx8i4V/n1/bvMrd2U2T2UcjypMLsViCCa2ln0egAuPWW
	8CI+x/3FqGhRcvjJWvkd0
X-Received: by 2002:a17:903:458f:b0:2ca:304:f93e with SMTP id d9443c01a7336-2cee9b58fa9mr109883265ad.22.1784192589913;
        Thu, 16 Jul 2026 02:03:09 -0700 (PDT)
X-Received: by 2002:a17:903:458f:b0:2ca:304:f93e with SMTP id d9443c01a7336-2cee9b58fa9mr109882915ad.22.1784192589269;
        Thu, 16 Jul 2026 02:03:09 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:03:08 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:01:55 +0800
Subject: [PATCH v2 3/8] drm/mcde: replace struct drm_simple_display_pipe
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
Message-Id: <20260716-drm-simple-kms-removal-v2-3-1133a8fc3785@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192560; l=15094;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=68SyLROdh7gtSjTLnzbueeYHapUemcEJldTPDqGBdBg=;
 b=GZwBrZK7hIoCbv3x6DM9/eN8GGXvJVijZFHj5nkZmiajld9kb1tDcEAiNnFrtIIuriqYSY/32
 F3xiVq3FpDRA9RMcdgRY89Bz0rhbKAJEmtJuYqvmpmgQ33WCA3AICwE
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a589e52 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7TuhGXn_jpZpJwHYtc4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX/1lb6FsZ8F0c
 i7hRTa8a52DQeNz6Fu+B4oKkyPFs47yhbhEMagLKh2rwLd6mzoENgl99WuHNDBuChWi3JVb/chN
 Gs25a3TKXvK+uRQIMHa0tl52TIAOZ7k=
X-Proofpoint-ORIG-GUID: hn0Y1oOh52xvOB5NNTkr59eDl9-Pnb6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX7LWaCAsx/jJN
 ryfKmhSGGn9feWWyFXFsFJPC5DhcMWxurQ1coI+sb636JqkGShfQ86WOBAyquFEvnNeP7vHiNmK
 L6pBe040+8zROOlQmrpix6B0gPA+bMrODRr8B56iZcQjQT91v98syUF0HIWcAr7CWcBLQ5JjYav
 2uSIyttp/yDCOU1VNgqonbnTEgb5jp8t/aA3DETv+N4K7v0h+U2Up2i774rmZ9ArU2rtttgazS9
 j1dlH1zejB6l11Sf0UOB/wkIYmDPpO4dDL4/lOkorwUD1erF9Kczg/Vtwc84b5m+mEODXbOqzDq
 kXRN3NzoU3/w5URfTy90wogiXUkcbjttvXUEZsywj277OiKL/7++UN8y1OHrtbgcmm075M6yKiw
 cr2jymivZUB3JGjUJZ5rI1fU4/ZMeiWGjI+A2qA9zYAnTIwmVNaFcMFS5yzDG82msp3tjo3n9sG
 KtfSjzlYvEbLw8zGl8Q==
X-Proofpoint-GUID: hn0Y1oOh52xvOB5NNTkr59eDl9-Pnb6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091

Convert MCDE to explicit plane, CRTC and encoder objects.

Handle pending page-flip events from the CRTC atomic flush path using the
commit-local CRTC state, and avoid manual connector/encoder attachment
before the connector has been created by the bridge path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/mcde/mcde_display.c | 251 +++++++++++++++++++++++-------------
 drivers/gpu/drm/mcde/mcde_drm.h     |   8 +-
 drivers/gpu/drm/mcde/mcde_drv.c     |   8 +-
 3 files changed, 173 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 257a6e84dd58..86edf94c5237 100644
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
@@ -157,40 +157,57 @@ void mcde_display_disable_irqs(struct mcde *mcde)
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
+	struct drm_crtc *crtc = pstate->crtc;
+	struct drm_crtc_state *cstate = NULL;
+	const struct drm_display_mode *mode;
+	struct drm_framebuffer *old_fb = old_pstate->fb;
 	struct drm_framebuffer *fb = pstate->fb;
+	int ret;
 
-	if (fb) {
-		u32 offset = drm_fb_dma_get_gem_addr(fb, pstate, 0);
+	if (crtc)
+		cstate = drm_atomic_get_new_crtc_state(commit, crtc);
 
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
+	}
+
+	/*
+	 * There's no pitch register, the mode's hdisplay
+	 * controls this.
+	 */
+	if (fb->pitches[0] != mode->hdisplay * fb->format->cpp[0]) {
+		DRM_DEBUG_KMS("can't handle pitches\n");
+		return -EINVAL;
 	}
 
+	/*
+	 * We can't change the FB format in a flicker-free
+	 * manner (and only update it during CRTC enable).
+	 */
+	if (old_fb && old_fb->format != fb->format)
+		cstate->mode_changed = true;
+
 	return 0;
 }
 
@@ -1149,16 +1166,15 @@ static void mcde_setup_dsi(struct mcde *mcde, const struct drm_display_mode *mod
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
@@ -1298,9 +1314,10 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
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
@@ -1318,9 +1335,9 @@ static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
 		mcde_dsi_disable(mcde->bridge);
 	}
 
-	event = crtc->state->event;
+	event = cstate->event;
 	if (event) {
-		crtc->state->event = NULL;
+		cstate->event = NULL;
 
 		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, event);
@@ -1381,44 +1398,13 @@ static void mcde_set_extsrc(struct mcde *mcde, u32 buffer_address)
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
 
-	/*
-	 * Handle any pending event first, we need to arm the vblank
-	 * interrupt before sending any update to the display so we don't
-	 * miss the interrupt.
-	 */
-	if (event) {
-		crtc->state->event = NULL;
-
-		spin_lock_irq(&crtc->dev->event_lock);
-		/*
-		 * Hardware must be on before we can arm any vblank event,
-		 * this is not a scanout controller where there is always
-		 * some periodic update going on, it is completely frozen
-		 * until we get an update. If MCDE output isn't yet enabled,
-		 * we just send a vblank dummy event back.
-		 */
-		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0) {
-			dev_dbg(mcde->dev, "arm vblank event\n");
-			drm_crtc_arm_vblank_event(crtc, event);
-		} else {
-			dev_dbg(mcde->dev, "insert fake vblank event\n");
-			drm_crtc_send_vblank_event(crtc, event);
-		}
-
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
-
 	/*
 	 * We do not start sending framebuffer updates before the
 	 * display is enabled. Update events will however be dispatched
@@ -1443,9 +1429,40 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
-static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_helper_atomic_flush(struct drm_crtc *crtc,
+					  struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_pending_vblank_event *event = crtc_state->event;
+
+	/*
+	 * Handle any pending event first, we need to arm the vblank
+	 * interrupt before sending any update to the display so we don't
+	 * miss the interrupt.
+	 */
+	if (!event)
+		return;
+
+	crtc_state->event = NULL;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	/*
+	 * Hardware must be on before we can arm any vblank event,
+	 * this is not a scanout controller where there is always
+	 * some periodic update going on, it is completely frozen
+	 * until we get an update. If MCDE output isn't yet enabled,
+	 * we just send a vblank dummy event back.
+	 */
+	if (crtc_state->active && drm_crtc_vblank_get(crtc) == 0)
+		drm_crtc_arm_vblank_event(crtc, event);
+	else
+		drm_crtc_send_vblank_event(crtc, event);
+
+	spin_unlock_irq(&crtc->dev->event_lock);
+}
+
+static int mcde_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 	u32 val;
@@ -1462,9 +1479,8 @@ static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void mcde_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = to_mcde(drm);
 
@@ -1474,13 +1490,55 @@ static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
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
@@ -1510,14 +1568,29 @@ int mcde_display_init(struct drm_device *drm)
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
 	if (ret)
 		return ret;
 
+	mcde->encoder.possible_crtcs = drm_crtc_mask(&mcde->crtc);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mcde_display_init);
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index ecb70b4b737c..10dd79893811 100644
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
@@ -95,7 +97,7 @@ struct mcde {
 	struct regulator *vana;
 };
 
-#define to_mcde(dev) container_of(dev, struct mcde, drm)
+struct mcde *to_mcde(struct drm_device *dev);
 
 static inline bool mcde_flow_is_video(struct mcde *mcde)
 {
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5f2c462bad7e..01787b923520 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -109,6 +109,11 @@ static const struct drm_mode_config_helper_funcs mcde_mode_config_helpers = {
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
+struct mcde *to_mcde(struct drm_device *dev)
+{
+	return container_of(dev, struct mcde, drm);
+}
+
 static irqreturn_t mcde_irq(int irq, void *data)
 {
 	struct mcde *mcde = data;
@@ -186,8 +191,7 @@ static int mcde_modeset_init(struct drm_device *drm)
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


