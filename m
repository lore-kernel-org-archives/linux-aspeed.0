Return-Path: <linux-aspeed+bounces-4357-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C81C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSH5VSvz2yhb;
	Sun, 05 Jul 2026 15:36:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783189981;
	cv=none; b=GEulav4tZ+Ev6wT82vuXG5pQamuu9KyFAKlPB4qyCjvBqawTN93MRap66BLNggN9TqC2EfbJITB2KyVYTxNYIIUgM/EBo394R8LqoUhFxYU/LlEtxDCPbrDv7Lb8xisnDrjkGW5IymfghTogVwKbX2tHQy8o/GKOpVaeWFkcQkDSRuJQU3kSYArTz9BkBsbMoVQC6N4bCTtsjzOcx1iv1wU1MGoxMQtHYdve1rjMDhEY47DU5cQ/VVIs49Ga042iiAeHozUwV+qDyt3zU9bUfPgw6geC0tEVDwjFaBhHuH76/38tUn24FkBvAztks1mdQdqQQKvFZIWCOPnzPc8lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783189981; c=relaxed/relaxed;
	bh=Ttm/7fm0Amr5YNq5qGHZbCjSuHzVM8tYT1SDU8QGDHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfIoAOh+r5t4dCQKIgZE+4ObiKbq4ZugDe3OVK2IZ7pJ8O2IZkHto9dJrH6m/W+JR9DdG0JzF11tcY8cgqG4gGnTaDpaVv4qtTcdSOzLcEbRNoCTwrA/jyi+eEkz0tnup4kagYlmktuGF54oXAq8F32ZZEav3PeIWQHafFgYcdAwD2EZS7JAAiqAOmKStisjk/TZaW8HLyI7Jxt2msRFCw8NWCuYtlksg09Y43NfX9d8O++UlBOk3I4+4/zGaeikOoJuL1+6ZaBrULDIog1KUwlleJjbmibAjfC++L6kvQU6k1RU87o5R+yMzzUpxpSD2L3L8Tm/fwu/S9ZDid13TQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KMvlZI/B; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISnuUXeL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KMvlZI/B;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISnuUXeL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszl02yDSz2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:33:00 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664G8eIs3376064
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ttm/7fm0Amr5YNq5qGHZbCjSuHzVM8tYT1SDU8QGDHk=; b=KMvlZI/BAGdkRbPC
	g4ZIOHQiHU6hWIPh5Xyk1zLy8YjJRzKKQ8XvMI6bfVxnghFPZKFzMyNCXHQVnYLh
	CpqZ/+AAF8wlJkPYwd58iNQLXFzwdZFIxpybyiWg2LAQYA2wMZB5Igu2MDLJjIh3
	2MlbaKCZEkHHerTQH5LcXL8V5TIMkSQc0apFOBcJni38UEsDNAAjj0xVykLSTgVb
	zqR7onBwTqwp6lznxPUOIxN1iN+t5D5W7XO1ZEf/uUbb80VQW4JdAs1wk0TFLWuR
	qOpgAbSlNa/p0eFNqRUvnHImfWzu7nhZbAK6rh0ZXmecbvahwLNXC3ar8iwI1eDi
	WKzCvg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnhp7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:32:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8478423e020so2625051b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783189977; x=1783794777; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ttm/7fm0Amr5YNq5qGHZbCjSuHzVM8tYT1SDU8QGDHk=;
        b=ISnuUXeLH7HaTmrb70Rl5Pp8Ju2TmUDkJALOYJWlBC5FzIbyVdCYlZXLjoTMVYbnTP
         B7EfRbUbed3RjgLFcdu/GqJe0x8r4bVnGmAvYm51yzb3hRbwpk6a1hTpe5pdTfPi6wpu
         xjR7Xanf1YvK7hqg0uIR4Ne2Hc9AcmsAh5dbQW5A83QsO5u1ZTUxa30BC8vZ3so8PzMA
         GxVJYaj1+k6QL2A4GrO2NtHNhTlBA4gQcyZSO9m92z02lyEGjYnRTMU6GkDS/X7Rkikw
         NL53R2l27n/6jJy6OWJ6YTLuZ64yxrb2S8mYUC3xK77hbmQFBz0e8DdPo10Xc9kaxnqZ
         crpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783189977; x=1783794777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ttm/7fm0Amr5YNq5qGHZbCjSuHzVM8tYT1SDU8QGDHk=;
        b=gUIIhqIAK0L07yQNekZPUc8qAsEAhAF3tkWNsOwqCclZywJK9IHrqrdQ7A/SVNfDTO
         v3sQ++mprzhjBw4Sb8Gq2gx6m4fwF6LhDSYwB+dQGoV+1UjfgiQEX1PdtxJBb9QtnnGt
         XKT63uAyh8qgz46IlrWIp0+NJPq9Jfa6v6gONkJejpL3pjUv6c1fPqfvomRM6UN7XBEW
         XoY9Au9dXymyxdS4rJG/sxabejkm1Al7Vn1xHigJgq908WEezD9TgecSHx+pxBYNqaCM
         UdS8tm6T3ncRTmr7DhQK3hly0gnovNrcPj4aiD3QLPon7iZw5PmiRAfj9EwY2dF722OC
         2+wQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1UXqFAtdp/CW5ocdXQC3ek1gppCjAqVQoNESPDyw8hdSODAX+u5QgjuoFAsgcHC4qmS4NflcPtArwwM0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycT5+r902PVsvAyCBmKiqSPP7ub7sYzsThAhCEyptwKm1e3gtE
	d4dujOnhB0HZJScHc+kn6K3seaVEY5TUaDpTq1aw8L6lqsvtSgZqgoiniKCEokeRfBR3Dgq3/rj
	8+xhxDJNB1bTvfjUOjcF0DIWFGgvxZNAoMk5U8Z1grw0LaxhfN3xP76MJKc7dEbcC+sUW
X-Gm-Gg: AfdE7clbOy5860R16vbr74Vvh86+3dAK6aPy/ziK6R3uPDBIn5WsVo1EokB47VPlvR2
	U2YaFKLkSO2ML+nyLQBo5aVu7c6pNwCVVhCjgBm6xUu/2SF8SCxC0wy2saTRdx4FrBZArMT+GQU
	fqKWyNgXRCrPak1CNNNOy5jptF3fjiUGZEucTOUmgwk8x62lAPQP4dIhjW6/yxTzXH9SKgRho/i
	7XOHFeB5ufY1hyQLueZ+Bk56FTgzKbiavR/bUGcHRtAYaVKal0JqVdceKi0n8tu6Bm/0mPM/qfh
	f1pqoQWeteNNXOpjRCxy2QGDTUPPwt57LeAtXt4vc8+k0PqtclC8WU+gmiDdo8GDX5CZcVN5p0z
	1C1eUTYnDyycmlxjZxzp8iVQ=
X-Received: by 2002:a05:6a00:330a:b0:845:e873:4248 with SMTP id d2e1a72fcca58-847f6f88bf1mr3891492b3a.56.1783189976895;
        Sat, 04 Jul 2026 11:32:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:330a:b0:845:e873:4248 with SMTP id d2e1a72fcca58-847f6f88bf1mr3891475b3a.56.1783189976356;
        Sat, 04 Jul 2026 11:32:56 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:32:54 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:12 +0800
Subject: [PATCH 3/9] drm/imx: replace struct drm_simple_display_pipe with
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
Message-Id: <20260705-drm-simple-kms-removal-v1-3-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=12402;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=ZBckuX3txIAWgfa7laBsW3ynqRXr57quONUZ0OswUhc=;
 b=CcD/bGc8N1fmpUeIAF1DgOcRu2w5rkAIDVMHiLPgTjWBMB2Cr/5H5zbeIN+QE6UHLIN4SkusI
 ddIQkvZ0PpPDGax+ynKj3ZJ+UsHYNrpUI0x4wQabe61C0XeadfBIfqL
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX62zwjN+5R2Ql
 MEcBsprCsgrWKnubA1lbLm3ZnNW3NbIMKs3XRa1U2+8RfJeMjDoiuScNLPxv44YSmtkcKbLQZtx
 /zzvUSda2hHVw2+jNAYA35kvZmQhU/g=
X-Proofpoint-ORIG-GUID: ewRtGYaAp1m-slwdLp3Ia3zlzDbbIKoL
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4951da cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mQfPNFbHEbGQ-wo8duEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfXy5M7rqkwHKXY
 L2u9XAl66t8eyUYLTQoiIDH7cUMIDsLtN0GGoBDiKL2onyWG3B3NravHw3RBGhwJioDnrlyIz5Q
 Npp1Xc+XzQ9IYeCzIMO7CQTr1TT3TSOLOYreKmwNCC9qXqdyw98ZXeiDq13rSnsX4OneIQYhQI8
 SnsZK0+WYE6WKhxMoYzpE0StOmFA0EiKBNz87fAp8HCMYz6eQYoUNcpRsfb2N6Tk7evgUtOdBJX
 h95TSjVzXwLGDf+WRdyvgaSRzWjqKSkBvgTsR1KiTDXOP6u7y4ovJbbodtENnIa3mCj1BLvMXVO
 qcR2OhDO5X/vifDBe0bJ7EWeHuWX630ceVKpzQc5gEG4JDS7HCrH7H9atWNRyrr5r2x2RH8Ul1K
 75RMmbba2RqzB1cYzJdMmW5WpcKnFPZRNyM7XOLcs7MRxXGEjpAD4xFefycRefGDHwgkYjSy08Y
 orfBlz18yTtKDfTnizw==
X-Proofpoint-GUID: ewRtGYaAp1m-slwdLp3Ia3zlzDbbIKoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

Convert i.MX LCDC to explicit primary plane, CRTC and encoder objects.

Keep no-scaling plane check and GEM framebuffer prepare callback from
simple-KMS path. Only touch hardware state when framebuffer exists,
since atomic plane updates can run on disabling transitions.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 178 ++++++++++++++++++++++++++----------
 1 file changed, 130 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
index f52832b43aca..d091dc562098 100644
--- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
+++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
@@ -14,9 +14,9 @@
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
@@ -102,7 +102,9 @@
 
 struct imx_lcdc {
 	struct drm_device drm;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct drm_connector *connector;
 	void __iomem *base;
 
@@ -135,14 +137,13 @@ static unsigned int imx_lcdc_get_format(unsigned int drm_format)
 	}
 }
 
-static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
+static void imx_lcdc_update_hw_registers(struct drm_crtc *crtc,
 					 struct drm_plane_state *old_state,
 					 bool mode_set)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane_state *new_state = pipe->plane.state;
+	struct drm_plane_state *new_state = crtc->primary->state;
 	struct drm_framebuffer *fb = new_state->fb;
-	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
+	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
 	u32 lpcr, lvcr, lhcr;
 	u32 framesize;
 	dma_addr_t addr;
@@ -188,16 +189,16 @@ static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe *pipe,
 		clk_prepare_enable(lcdc->clk_per);
 }
 
-static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_plane_state *plane_state)
+static void imx_lcdc_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *state)
 {
 	int ret;
 	int clk_div;
 	int bpp;
-	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
-	struct drm_display_mode *mode = &pipe->crtc.mode;
+	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
+	struct drm_display_mode *mode = &crtc->mode;
 	struct drm_display_info *disp_info = &lcdc->connector->display_info;
+	struct drm_plane_state *plane_state = crtc->primary->state;
 	const int hsync_pol = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : 1;
 	const int vsync_pol = (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : 1;
 	const int data_enable_pol =
@@ -231,34 +232,34 @@ static void imx_lcdc_pipe_enable(struct drm_simple_display_pipe *pipe,
 
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
+	imx_lcdc_update_hw_registers(crtc, NULL, true);
 
 	/* Enable VBLANK Interrupt */
 	writel(INTR_EOF, lcdc->base + IMX21LCDC_LIER);
 }
 
-static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void imx_lcdc_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+						struct drm_atomic_commit *state)
 {
-	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(pipe->crtc.dev);
-	struct drm_crtc *crtc = &lcdc->pipe.crtc;
+	struct imx_lcdc *lcdc = imx_lcdc_from_drmdev(crtc->dev);
 	struct drm_pending_vblank_event *event;
 
 	clk_disable_unprepare(lcdc->clk_ahb);
 	clk_disable_unprepare(lcdc->clk_ipg);
 
-	if (pipe->crtc.enabled)
+	if (crtc->enabled)
 		clk_disable_unprepare(lcdc->clk_per);
 
 	spin_lock_irq(&lcdc->drm.event_lock);
@@ -273,17 +274,18 @@ static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
 	writel(0, lcdc->base + IMX21LCDC_LIER);
 }
 
-static int imx_lcdc_pipe_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *plane_state,
-			       struct drm_crtc_state *crtc_state)
+static int imx_lcdc_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
 {
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	const struct drm_display_mode *mode = &crtc_state->mode;
-	const struct drm_display_mode *old_mode = &pipe->crtc.state->mode;
+	const struct drm_display_mode *old_mode = &crtc->state->mode;
+	int ret;
 
 	if (mode->hdisplay < LCDC_MIN_XRES || mode->hdisplay > LCDC_MAX_XRES ||
 	    mode->vdisplay < LCDC_MIN_YRES || mode->vdisplay > LCDC_MAX_YRES ||
 	    mode->hdisplay % 0x10) { /* must be multiple of 16 */
-		drm_err(pipe->crtc.dev, "unsupported display mode (%u x %u)\n",
+		drm_err(crtc->dev, "unsupported display mode (%u x %u)\n",
 			mode->hdisplay, mode->vdisplay);
 		return -EINVAL;
 	}
@@ -292,27 +294,42 @@ static int imx_lcdc_pipe_check(struct drm_simple_display_pipe *pipe,
 		old_mode->hdisplay != mode->hdisplay ||
 		old_mode->vdisplay != mode->vdisplay;
 
-	return 0;
+	if (!crtc_state->enable)
+		goto out;
+
+	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+	if (ret)
+		return ret;
+
+out:
+	return drm_atomic_add_affected_planes(state, crtc);
 }
 
-static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_state)
+static void imx_lcdc_plane_helper_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane_state *new_state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *new_state = plane->state;
+	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_pending_vblank_event *event;
 	struct drm_framebuffer *fb = new_state->fb;
 	struct drm_framebuffer *old_fb = old_state->fb;
 	struct drm_crtc *old_crtc = old_state->crtc;
 	bool mode_changed = false;
 
-	if (old_fb && old_fb->format != fb->format)
-		mode_changed = true;
-	else if (old_crtc != crtc)
-		mode_changed = true;
+	if (!crtc)
+		return;
 
-	imx_lcdc_update_hw_registers(pipe, old_state, mode_changed);
+	if (fb) {
+		if (old_fb && old_fb->format != fb->format)
+			mode_changed = true;
+		else if (old_crtc != crtc)
+			mode_changed = true;
 
+		imx_lcdc_update_hw_registers(crtc, old_state, mode_changed);
+	}
+
+	event = crtc->state->event;
 	if (event) {
 		crtc->state->event = NULL;
 
@@ -327,11 +344,56 @@ static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
-static const struct drm_simple_display_pipe_funcs imx_lcdc_pipe_funcs = {
-	.enable = imx_lcdc_pipe_enable,
-	.disable = imx_lcdc_pipe_disable,
-	.check = imx_lcdc_pipe_check,
-	.update = imx_lcdc_pipe_update,
+static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *plane,
+					      struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+	int ret;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	return ret;
+}
+
+static const struct drm_plane_helper_funcs imx_lcdc_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= imx_lcdc_plane_helper_atomic_check,
+	.atomic_update	= imx_lcdc_plane_helper_atomic_update,
+};
+
+static const struct drm_plane_funcs imx_lcdc_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs imx_lcdc_crtc_helper_funcs = {
+	.atomic_check	= imx_lcdc_crtc_helper_atomic_check,
+	.atomic_enable	= imx_lcdc_crtc_helper_atomic_enable,
+	.atomic_disable	= imx_lcdc_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs imx_lcdc_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs imx_lcdc_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static const struct drm_mode_config_funcs imx_lcdc_mode_config_funcs = {
@@ -369,7 +431,7 @@ MODULE_DEVICE_TABLE(of, imx_lcdc_of_dev_id);
 static irqreturn_t imx_lcdc_irq_handler(int irq, void *arg)
 {
 	struct imx_lcdc *lcdc = arg;
-	struct drm_crtc *crtc = &lcdc->pipe.crtc;
+	struct drm_crtc *crtc = &lcdc->crtc;
 	unsigned int status;
 
 	status = readl(lcdc->base + IMX21LCDC_LISR);
@@ -387,6 +449,9 @@ static int imx_lcdc_probe(struct platform_device *pdev)
 	struct imx_lcdc *lcdc;
 	struct drm_device *drm;
 	struct drm_bridge *bridge;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
 	int irq;
 	int ret;
 	struct device *dev = &pdev->dev;
@@ -428,23 +493,40 @@ static int imx_lcdc_probe(struct platform_device *pdev)
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
2.55.0


