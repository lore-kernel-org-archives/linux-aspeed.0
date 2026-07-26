Return-Path: <linux-aspeed+bounces-4565-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B410C53219
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6w3c64z2ygG;
	Mon, 27 Jul 2026 10:07:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095035;
	cv=none; b=j++N6W4+IWYpGO9WSeTpHdg/1dn5+SMlQ6HPl2RVpNq+HuyaqMUiizBblMQt4fwW35IFayeDbYhWo28Yoz9UkBpmIDUbjvQhWcUGTneUB++YR1G765JEHf0xAxdm2Us+NoN+QJnoyHbw+ir2kbZgUFmRR0Wsdm2oOhFGCWuZQEmoAhIGVZgynMu8HIqHA7UxmlMzZQabvTvFUmqE+dvm0/ofyXlfjawh26esqfQ8Qvbwi2tAMJ13m+vDc/iK7SAQXN/Ukk/PPAj393tG/42LUNvwOcVWQ/ugd0yn22LIWbjQx+unXMZqgW/6mSPSYCLb9q93IGcVt+MwBrWDh7pesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095035; c=relaxed/relaxed;
	bh=Cnh9LuBe1nllVe6dn8rg7eH465Ab2ZOSgYQD7jgYRGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epzzACQSMsNboOcXUlStsOtpfPNHmuMgyP/lXe/edWRIG/rpF48jP3+hzYqXorAeoSzA/n/elCS+/GgLQhcfGatEKFFYMReoTLcEroJYYaioyCDr9SX6+EC7sZCA6JO9IwX5Pr39BhNmwkIgbf817kszGvyznbvqZ5T+JtwrWrAInrJWM0YDSuG6bI83DiWrhsiOoA+KKSVaDApJb02Atgv2Z/LQONuOkZMB4iwI3RQQ9gRwJAn410QFuN05DPlx7Uds2nR/KnaP0b18JdfFGPfsKqnNid9slu/k5beiUW2Byke3p4whFEwP5/j77JprzpFILh72eRkPO5/ERNgLDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FzmefLSA; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hHl+CsFq; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FzmefLSA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hHl+CsFq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XGf22sTz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:43:54 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH7Udr1127155
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cnh9LuBe1nllVe6dn8rg7eH465Ab2ZOSgYQD7jgYRGs=; b=FzmefLSAtCzjOw1O
	w5jZRHtTqcNmdCEbNAnp16PtSUDvWIUJC0qM8+au1Dp61p66KI8YSDV5Ip+KqE2e
	frpwLESANXukoVrYMx7134xo2jY2RrLU5q3ciQl8SjrDWLQM4OrUsT5rCjkHAd7U
	xLnteKCIZsZC1qjUg7zJlTkLTp9s1e714h2k0eaDBx/GC8loP9i835jHar9MFvKm
	r3HL6nToWnZOrJ4DhsVhlzaRfKA1c8zvypWtGnJNNGWYzWwFQOnsdTZpIG0ge/av
	lyrf87hevYx+bMwcsgWERbvaE0ntjJMyhE5J8YZT4DXlYMlVDBtkQ1n245TvOMrD
	vYF2Tg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnweuf2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:43:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc5faecf01so44417975ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095031; x=1785699831; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cnh9LuBe1nllVe6dn8rg7eH465Ab2ZOSgYQD7jgYRGs=;
        b=hHl+CsFq0N8FdnJyLSJGSauNYkagkrbhmc0hdfvo6MPPz+yPGeo+80UIPDfJGi0HZk
         nD8M/x4EP07qSz8G+thZ1W0jWOwCTHJuJZxKxPlDnfrODUYgWGGhp1urvwvUTV17ixqb
         RSKR8DABCcIPRwH5yX3JDm8pMkESZPrpkTyDScmZiCQ/ASngon/qKOtBKw0zfxKdaSjv
         LIPx4IdFkaeb6ByqlW/eubROjF4k98PoDG8bP/CLNFQzjVeSIBOqgo0LLiUUK2S7FPkE
         IQZdpSIXMLh3EQbxZx4ZCAfNS6el3H/68yQjjAtW5ruk6SeqSxtiWJ5X13dJ/EDcv61U
         Xu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095031; x=1785699831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cnh9LuBe1nllVe6dn8rg7eH465Ab2ZOSgYQD7jgYRGs=;
        b=IJBTKI5uZ6lV4rp/lIWJE4W/5cXdulLEMuVn3W92dBOTKLHdgKGlFrzav8O+EpWDj9
         Q0zgR7GtxoD/BCK+ebLqQSgccWADcrqBrCtyQ+UTUb4j0TtcL+vgD+Nr88DycCKx5cQ3
         0f1sAMcykNzJ+iu59cbo35RBbmuhNhnwx2LQKZAPwf0UBHd0tVmbbzfWMKAdedLl0KDV
         xD/IM2YrFFxTt1Fa9EIxBen0SAxVl1QVyzKAK2i32SC8/UUz96pjAIwZbyHPt73hv9pe
         0vYwcYbS72vr+/kOkALvS+BbRA48UR0mpHzCG3GWz4ZajNhWFJRoKzlo7S/jxujU4dBm
         RorA==
X-Forwarded-Encrypted: i=1; AHgh+RqtztHxH2I3SAATxKuqN4hMsV9QQ4cqBJUj+luW7oCIPYxoL0GOaAxnrlqjD4045dle+XI0xQBxjStYZgg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxboGtdrx6evUcOWRIH5y7w98PF2DJPfYeHR4iOqTFyXaobnx0u
	cC8Pt7JyO8WsI0WH9eJkNwobF61yC2onkyOUP51Ee5Tc/bi/AUh/yKgRRM6z129a5wPBU1GYodl
	wUdWS9muMNdK+5T2DlM1DaX6KPY4r8Y48khcHrXKsK5OKl+MkyrkozUL0ejD91OjLRKq1
X-Gm-Gg: AR+sD11iAQbooMmPFLjNBP2n/I6tnTTVBBS1NMY2/6BZmmReOP0Sq/R2I4EKrlTvVkg
	1tJBiSAt4Qr8Pj17hQsrDdpeKIA0fspryb3M++0WMJFMFPAdK5YIv9M64Z9yk8Jr4hS4e20hnkX
	ZL2+AyRQwJwj+S6zIO0WkPxSG/FfqMsUBGR3HGiXFmcQyJwwFDJ6E27m14xphvLALak+qCJVQya
	tF+YVSGHMkRx24+LPpDC1vNesIVb99v28Gu3jKpvgeiE7AUuHqmwGsX+glM/5ehpn9hyjNfd6Pk
	QPTUTWelV1WV34/Em0Dxgl3xUwqVUlVDUUCyzB+ymZBxpFnpjL2BfVrsSSAYA2oq9nwzB5au3h7
	HwERaDpNRhZ3oQHxwzMf8
X-Received: by 2002:a05:6a20:ce43:b0:3c3:dce5:b1a0 with SMTP id adf61e73a8af0-3c67e133c1dmr6000506637.64.1785095031117;
        Sun, 26 Jul 2026 12:43:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:ce43:b0:3c3:dce5:b1a0 with SMTP id adf61e73a8af0-3c67e133c1dmr6000492637.64.1785095030649;
        Sun, 26 Jul 2026 12:43:50 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dcd38sm2312070a12.29.2026.07.26.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:43:50 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 03:42:33 +0800
Subject: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
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
Message-Id: <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com>
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
In-Reply-To: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
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
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Marian Cichy <m.cichy@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095005; l=17703;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=ii7D7fVwMZnTOsCdry61t18Iyruc6rBN0buH4kXzP+A=;
 b=rMjPpwlvOZ8uxGZ3bMH3pDWt0BN6+82F2BNkMU6Kx2gIMw+MXmvUrDU5uaQuTOq5ii2IiEnoX
 /9/3teg1E6oDpDSEJoOeu7dMhff4ReKw6BEADbivI8wb7g7q1YilJ+Y
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX2JRlpqxJmb3y
 PnrCcKyoADyud+bmzb8U5zIb7LJWXYy5RZyJXRhC1n+M/8CwSfP8YlJGiB7puEcnarW31Ztn+ul
 S1cZqolXppAXPxVuh3PNFeY6+4JWgpeNmXxpOZqJVso+ALDzhTnfH4O57l08/EaPq4SsbB/TxiY
 r1C+5NLPfuejvPB9XD9ejLXscvpHHR1uXuSejsAxmgFaPUPDES3UH91q0y3wbIbtGmPM0BXyr/H
 Cn0Qp2sU9J31UzacaFOFQ/NXAqMan2yOJKJPDBJC3MzrRIwE8Gq0AyGbhF3U/A83SdycNPSVGm+
 pZ42vRJUXPf91ouEVeXOKAQeX86mUPT5dGXVIDYLCflcxomg8CeD8nE3AxhFtcSGi7Nb5JaK9Og
 0eEUHJV7T2IqNy3jk7MAj1BFxK75BPHA+x4eTT1Ko3VbcTatppf8aEbpwmIq3a7JV65uNfDfskU
 Le8WTB+4ap5Fwr/g7cg==
X-Proofpoint-GUID: uo0Wm8Asv7j8Hq0Ef7Sqh29_vpL0w_p5
X-Authority-Analysis: v=2.4 cv=S77pBosP c=1 sm=1 tr=0 ts=6a666378 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1bWX6k_Zg_mReU0a2YEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: uo0Wm8Asv7j8Hq0Ef7Sqh29_vpL0w_p5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX751K1mVcGja9
 c3/bTZ9Hd9oP6V1/W6DEUd851PK8gQUD6h2yYSrPgPAazSVxtCPSKoNttXgMLNhy2QrA4DHbpXU
 UajDE2/3iUQtDeo2C1nsdADU+LCGRtU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260200

Convert i.MX LCDC to explicit primary plane, CRTC and encoder objects.
Keep no-scaling plane check and GEM framebuffer prepare callback from
simple-KMS path.

Wire the vblank lifecycle explicitly with CRTC vblank callbacks and
drm_crtc_vblank_on()/drm_crtc_vblank_off(). Use the old CRTC state in the
disable path for clock unwinding so the clock reference count remains
paired with the previous active state.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 264 ++++++++++++++++++++++++++----------
 1 file changed, 190 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
index 81024f7d9e96..4835f01954f7 100644
--- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
+++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
@@ -2,6 +2,7 @@
 // SPDX-FileCopyrightText: 2020 Marian Cichy <M.Cichy@pengutronix.de>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_damage_helper.h>
@@ -14,9 +15,9 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
+#include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
@@ -102,7 +103,9 @@
 
 struct imx_lcdc {
 	struct drm_device drm;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct drm_connector *connector;
 	void __iomem *base;
 
@@ -135,14 +138,15 @@ static unsigned int imx_lcdc_get_format(unsigned int drm_format)
 	}
 }
 
-static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
-					 struct drm_plane_state *old_state,
+static void imx_lcdc_update_hw_registers(struct drm_crtc *crtc,
+					 struct drm_crtc_state *old_crtc_state,
+					 struct drm_crtc_state *new_crtc_state,
+					 struct drm_plane_state *new_state,
 					 bool mode_set)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane_state *new_state = pipe->plane.state;
+	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
+	const struct drm_display_mode *mode = &new_crtc_state->mode;
 	struct drm_framebuffer *fb = new_state->fb;
-	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
 	u32 lpcr, lvcr, lhcr;
 	u32 framesize;
 	dma_addr_t addr;
@@ -155,24 +159,24 @@ static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
 		return;
 
 	/* Disable PER clock to make register write possible */
-	if (old_state && old_state->crtc && old_state->crtc->enabled)
+	if (old_crtc_state && old_crtc_state->enable)
 		clk_disable_unprepare(lcdc->clk_per);
 
 	/* Framesize */
-	framesize = FIELD_PREP(IMX21LCDC_LSR_XMAX, crtc->mode.hdisplay >> 4) |
-		FIELD_PREP(IMX21LCDC_LSR_YMAX, crtc->mode.vdisplay);
+	framesize = FIELD_PREP(IMX21LCDC_LSR_XMAX, mode->hdisplay >> 4) |
+		FIELD_PREP(IMX21LCDC_LSR_YMAX, mode->vdisplay);
 	writel(framesize, lcdc->base + IMX21LCDC_LSR);
 
 	/* HSYNC */
-	lhcr = FIELD_PREP(IMX21LCDC_LHCR_HFPORCH, crtc->mode.hsync_start - crtc->mode.hdisplay - 1) |
-		FIELD_PREP(IMX21LCDC_LHCR_HWIDTH, crtc->mode.hsync_end - crtc->mode.hsync_start - 1) |
-		FIELD_PREP(IMX21LCDC_LHCR_HBPORCH, crtc->mode.htotal - crtc->mode.hsync_end - 3);
+	lhcr = FIELD_PREP(IMX21LCDC_LHCR_HFPORCH, mode->hsync_start - mode->hdisplay - 1) |
+		FIELD_PREP(IMX21LCDC_LHCR_HWIDTH, mode->hsync_end - mode->hsync_start - 1) |
+		FIELD_PREP(IMX21LCDC_LHCR_HBPORCH, mode->htotal - mode->hsync_end - 3);
 	writel(lhcr, lcdc->base + IMX21LCDC_LHCR);
 
 	/* VSYNC */
-	lvcr = FIELD_PREP(IMX21LCDC_LVCR_VFPORCH, crtc->mode.vsync_start - crtc->mode.vdisplay) |
-		FIELD_PREP(IMX21LCDC_LVCR_VWIDTH, crtc->mode.vsync_end - crtc->mode.vsync_start) |
-		FIELD_PREP(IMX21LCDC_LVCR_VBPORCH, crtc->mode.vtotal - crtc->mode.vsync_end);
+	lvcr = FIELD_PREP(IMX21LCDC_LVCR_VFPORCH, mode->vsync_start - mode->vdisplay) |
+		FIELD_PREP(IMX21LCDC_LVCR_VWIDTH, mode->vsync_end - mode->vsync_start) |
+		FIELD_PREP(IMX21LCDC_LVCR_VBPORCH, mode->vtotal - mode->vsync_end);
 	writel(lvcr, lcdc->base + IMX21LCDC_LVCR);
 
 	lpcr = readl(lcdc->base + IMX21LCDC_LPCR);
@@ -184,19 +188,20 @@ static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
 	writel(new_state->fb->pitches[0] / 4, lcdc->base + IMX21LCDC_LVPWR);
 
 	/* Enable PER clock */
-	if (new_state->crtc->enabled)
+	if (new_crtc_state->enable)
 		clk_prepare_enable(lcdc->clk_per);
 }
 
-static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_plane_state *plane_state)
+static void imx_lcdc_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
 	int ret;
 	int clk_div;
 	int bpp;
-	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
-	struct drm_display_mode *mode = &pipe->crtc.mode;
+	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
+	struct drm_crtc_state *cstate = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, &lcdc->plane);
+	struct drm_display_mode *mode = &cstate->mode;
 	struct drm_display_info *disp_info = &lcdc->connector->display_info;
 	const int hsync_pol = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : 1;
 	const int vsync_pol = (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : 1;
@@ -207,7 +212,7 @@ static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	clk_div = DIV_ROUND_CLOSEST_ULL(clk_get_rate(lcdc->clk_per),
 					mode->clock * 1000);
-	bpp = imx_lcdc_get_format(plane_state->fb->format->format);
+	bpp = imx_lcdc_get_format(pstate->fb->format->format);
 
 	writel(FIELD_PREP(IMX21LCDC_LPCR_PCD, clk_div - 1) |
 	       FIELD_PREP(IMX21LCDC_LPCR_LPPOL, hsync_pol) |
@@ -231,40 +236,46 @@ static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	ret = clk_prepare_enable(lcdc->clk_ipg);
 	if (ret) {
-		dev_err(pipe->crtc.dev->dev, "Cannot enable ipg clock: %pe\n", ERR_PTR(ret));
+		dev_err(crtc->dev->dev, "Cannot enable ipg clock: %pe\n", ERR_PTR(ret));
 		return;
 	}
 	ret = clk_prepare_enable(lcdc->clk_ahb);
 	if (ret) {
-		dev_err(pipe->crtc.dev->dev, "Cannot enable ahb clock: %pe\n", ERR_PTR(ret));
+		dev_err(crtc->dev->dev, "Cannot enable ahb clock: %pe\n", ERR_PTR(ret));
 
 		clk_disable_unprepare(lcdc->clk_ipg);
 
 		return;
 	}
 
-	imx_lcdc_update_hw_registers(pipe, NULL, true);
+	imx_lcdc_update_hw_registers(crtc, NULL, cstate, pstate, true);
 
 	/* Enable VBLANK Interrupt */
 	writel(INTR_EOF, lcdc->base + IMX21LCDC_LIER);
+
+	drm_crtc_vblank_on(crtc);
 }
 
-static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void imx_lcdc_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+						struct drm_atomic_commit *commit)
 {
-	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
-	struct drm_crtc *crtc = &lcdc->pipe.crtc;
+	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(commit, crtc);
+	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
 	struct drm_pending_vblank_event *event;
 
+	drm_crtc_vblank_off(crtc);
+
 	clk_disable_unprepare(lcdc->clk_ahb);
 	clk_disable_unprepare(lcdc->clk_ipg);
 
-	if (pipe->crtc.enabled)
+	if (old_crtc_state->enable)
 		clk_disable_unprepare(lcdc->clk_per);
 
 	spin_lock_irq(&lcdc->drm.event_lock);
-	event = crtc->state->event;
+	event = new_crtc_state->event;
 	if (event) {
-		crtc->state->event = NULL;
+		new_crtc_state->event = NULL;
 		drm_crtc_send_vblank_event(crtc, event);
 	}
 	spin_unlock_irq(&lcdc->drm.event_lock);
@@ -273,66 +284,151 @@ static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
 	writel(0, lcdc->base + IMX21LCDC_LIER);
 }
 
-static int imx_lcdc_pipe_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *plane_state,
-			       struct drm_crtc_state *crtc_state)
+static int imx_lcdc_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *commit)
 {
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(commit, crtc);
 	const struct drm_display_mode *mode = &crtc_state->mode;
-	const struct drm_display_mode *old_mode = &pipe->crtc.state->mode;
+	const struct drm_display_mode *old_mode = &old_crtc_state->mode;
+	int ret;
 
-	if (mode->hdisplay < LCDC_MIN_XRES || mode->hdisplay > LCDC_MAX_XRES ||
-	    mode->vdisplay < LCDC_MIN_YRES || mode->vdisplay > LCDC_MAX_YRES ||
-	    mode->hdisplay % 0x10) { /* must be multiple of 16 */
-		drm_err(pipe->crtc.dev, "unsupported display mode (%u x %u)\n",
+	if (crtc_state->enable) {
+		ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+		if (ret)
+			return ret;
+	}
+
+	if (crtc_state->enable &&
+	    (mode->hdisplay < LCDC_MIN_XRES || mode->hdisplay > LCDC_MAX_XRES ||
+	     mode->vdisplay < LCDC_MIN_YRES || mode->vdisplay > LCDC_MAX_YRES ||
+	     mode->hdisplay % 0x10)) { /* must be multiple of 16 */
+		drm_err(crtc->dev, "unsupported display mode (%u x %u)\n",
 			mode->hdisplay, mode->vdisplay);
 		return -EINVAL;
 	}
 
-	crtc_state->mode_changed =
-		old_mode->hdisplay != mode->hdisplay ||
-		old_mode->vdisplay != mode->vdisplay;
+	if (old_mode->hdisplay != mode->hdisplay ||
+	    old_mode->vdisplay != mode->vdisplay)
+		crtc_state->mode_changed = true;
 
-	return 0;
+	return drm_atomic_add_affected_planes(commit, crtc);
 }
 
-static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_state)
+static void imx_lcdc_plane_helper_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *commit)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane_state *new_state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_crtc *crtc = new_state->crtc;
+	struct drm_crtc_state *old_crtc_state = NULL;
+	struct drm_crtc_state *new_crtc_state;
 	struct drm_framebuffer *fb = new_state->fb;
 	struct drm_framebuffer *old_fb = old_state->fb;
 	struct drm_crtc *old_crtc = old_state->crtc;
 	bool mode_changed = false;
 
+	if (!fb || !crtc)
+		return;
+
+	if (old_crtc)
+		old_crtc_state = drm_atomic_get_old_crtc_state(commit, old_crtc);
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	if (!new_crtc_state)
+		return;
+
 	if (old_fb && old_fb->format != fb->format)
 		mode_changed = true;
 	else if (old_crtc != crtc)
 		mode_changed = true;
 
-	if (!drm_atomic_crtc_needs_modeset(crtc->state))
-		imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
+	if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+		imx_lcdc_update_hw_registers(crtc, old_crtc_state, new_crtc_state,
+					     new_state, mode_changed);
+}
 
-	if (event) {
-		crtc->state->event = NULL;
+static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *plane,
+					      struct drm_atomic_commit *commit)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_crtc_state *crtc_state = NULL;
+
+	if (plane_state->crtc) {
+		crtc_state = drm_atomic_get_crtc_state(commit, plane_state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+	}
 
-		spin_lock_irq(&crtc->dev->event_lock);
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
 
-		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
-			drm_crtc_arm_vblank_event(crtc, event);
-		else
-			drm_crtc_send_vblank_event(crtc, event);
+static const struct drm_plane_helper_funcs imx_lcdc_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= imx_lcdc_plane_helper_atomic_check,
+	.atomic_update	= imx_lcdc_plane_helper_atomic_update,
+};
 
-		spin_unlock_irq(&crtc->dev->event_lock);
-	}
+static const struct drm_plane_funcs imx_lcdc_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static void imx_lcdc_crtc_helper_atomic_flush(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_pending_vblank_event *event = new_crtc_state->event;
+
+	if (!event)
+		return;
+
+	new_crtc_state->event = NULL;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (new_crtc_state->active && drm_crtc_vblank_get(crtc) == 0)
+		drm_crtc_arm_vblank_event(crtc, event);
+	else
+		drm_crtc_send_vblank_event(crtc, event);
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
-static const struct drm_simple_display_pipe_funcs imx_lcdc_pipe_funcs = {
-	.enable = imx_lcdc_pipe_enable,
-	.disable = imx_lcdc_pipe_disable,
-	.check = imx_lcdc_pipe_check,
-	.update = imx_lcdc_pipe_update,
+static const struct drm_crtc_helper_funcs imx_lcdc_crtc_helper_funcs = {
+	.atomic_check	= imx_lcdc_crtc_helper_atomic_check,
+	.atomic_enable	= imx_lcdc_crtc_helper_atomic_enable,
+	.atomic_disable	= imx_lcdc_crtc_helper_atomic_disable,
+	.atomic_flush	= imx_lcdc_crtc_helper_atomic_flush,
+};
+
+static int imx_lcdc_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	return 0;
+}
+
+static void imx_lcdc_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+}
+
+static const struct drm_crtc_funcs imx_lcdc_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank		= imx_lcdc_crtc_enable_vblank,
+	.disable_vblank		= imx_lcdc_crtc_disable_vblank,
+};
+
+static const struct drm_encoder_funcs imx_lcdc_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static const struct drm_mode_config_funcs imx_lcdc_mode_config_funcs = {
@@ -370,7 +466,7 @@ MODULE_DEVICE_TABLE(of, imx_lcdc_of_dev_id);
 static irqreturn_t imx_lcdc_irq_handler(int irq, void *arg)
 {
 	struct imx_lcdc *lcdc = arg;
-	struct drm_crtc *crtc = &lcdc->pipe.crtc;
+	struct drm_crtc *crtc = &lcdc->crtc;
 	unsigned int status;
 
 	status = readl(lcdc->base + IMX21LCDC_LISR);
@@ -388,6 +484,9 @@ static int imx_lcdc_probe(struct platform_device *pdev)
 	struct imx_lcdc *lcdc;
 	struct drm_device *drm;
 	struct drm_bridge *bridge;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
 	int irq;
 	int ret;
 	struct device *dev = &pdev->dev;
@@ -429,23 +528,40 @@ static int imx_lcdc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Cannot initialize mode configuration structure\n");
 
-	/* CRTC, Plane, Encoder */
-	ret = drm_simple_display_pipe_init(drm, &lcdc->pipe,
-					   &imx_lcdc_pipe_funcs,
-					   imx_lcdc_formats,
-					   ARRAY_SIZE(imx_lcdc_formats), NULL, NULL);
+	plane = &lcdc->plane;
+	ret = drm_universal_plane_init(drm, plane, 0,
+				       &imx_lcdc_plane_funcs,
+				       imx_lcdc_formats,
+				       ARRAY_SIZE(imx_lcdc_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret < 0)
+		return dev_err_probe(drm->dev, ret, "Cannot initialize primary plane\n");
+	drm_plane_helper_add(plane, &imx_lcdc_plane_helper_funcs);
+
+	crtc = &lcdc->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
+					&imx_lcdc_crtc_funcs, NULL);
+	if (ret < 0)
+		return dev_err_probe(drm->dev, ret, "Cannot initialize CRTC\n");
+	drm_crtc_helper_add(crtc, &imx_lcdc_crtc_helper_funcs);
+
+	encoder = &lcdc->encoder;
+	ret = drm_encoder_init(drm, encoder, &imx_lcdc_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret < 0)
-		return dev_err_probe(drm->dev, ret, "Cannot setup simple display pipe\n");
+		return dev_err_probe(drm->dev, ret, "Cannot initialize encoder\n");
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
 	if (ret < 0)
 		return dev_err_probe(drm->dev, ret, "Failed to initialize vblank\n");
 
-	ret = drm_bridge_attach(&lcdc->pipe.encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
 		return dev_err_probe(drm->dev, ret, "Cannot attach bridge\n");
 
-	lcdc->connector = drm_bridge_connector_init(drm, &lcdc->pipe.encoder);
+	lcdc->connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(lcdc->connector))
 		return dev_err_probe(drm->dev, PTR_ERR(lcdc->connector), "Cannot init bridge connector\n");
 

-- 
2.43.0


