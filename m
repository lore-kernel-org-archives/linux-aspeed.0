Return-Path: <linux-aspeed+bounces-4354-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B7DC44500
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSG4Bk2z2yhD;
	Sun, 05 Jul 2026 15:36:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783189995;
	cv=none; b=XlZp8JUG2EkKzqOs9vWIzGE/u3YLVVwvtzWKTCS/KDL0nNjxt+uYQ96lnotz2SWn6GaXQID32Umt52UklnJdNCk1+8+7/Crrv0Er1RHV6UUI2QdmUOyo3H+ikpUgVTIYDR48YeL4gQUp6830xPEXnQplrKOqqAIyoI13B0risew0C7brUdMF/F9ibDFwzf0EACK7c+HS+BO1fACzA+kEQl4k+hLBW+YznUpC7m1wPPTpaa4dehdVIRdPXI6qYqemGYCphZFAKWo5fotaPODQDb576TrXBw3b53PThXSlMFxBfLyb5i5xo+U88Qlbe68yJwh0+58xSP3DHbP31a7yzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783189995; c=relaxed/relaxed;
	bh=qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYTvmXrRG22Z4ugu3OK9lwOlg8iVsHokwXD6rWAr3z4sbMwi2p3D//k6SwSITc2mXfTYWzNpmTlC0RjN9AskoTfICScE/meAQIeaLevXQNJmAFCDpSj8in9Jy+zEtYC0f4PJ4qNlcvTnWA29n5FaEnV+LFo0iDGqApwltNizf61tnB6srOn+dPc91BUAcSMCIgogqnhxKsynw+rQ+VCnM1MhqTItW7Jbv7dew/wdMrYJpc58mT0E+kDpstsFj1WznJJlYik9+l3g3D6VQZ8KCKNbJLtrahTNTeXiO0WadpwhKAuxTSd7/nIfP4gbaLyyKl5PfYMwxVbRjaTJehW4sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bLvR58BK; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CvPmEoO9; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bLvR58BK;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CvPmEoO9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszlG6QPMz2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:33:13 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664GB5bX3241474
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=; b=bLvR58BKlqOhSmYR
	GWZwh7RAaMqMue255wp2Ux0Os9VOxeZTTKB+ZxPySU6eFiW7ptjT3b3vdgETw6Jd
	5I947fjxQJDg/XrP4LXewlGPDfkNLfXj7mTxRKCdL6xeN/5VUZXXu70dBIH6VF4M
	vEAqNimBJaFsBPVH580f4bNI6/oHvXzoi1q5GHo/74VpLiQfryAKkNpALUWKrKKi
	lvjTgd7dkMAiZOSDtM3dX1XAgaypnJoWr9VA7uycRiP6EF2yiseN2j1pALBmIuq8
	aSzmjLQ8i3hGYowHvMb9Iz2eUDnGL8p6GAbRS+lTM2RvEbLelhiecOA5MlLsGH+5
	fsNVbA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgh7mk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:33:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84240683a82so1207812b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783189990; x=1783794790; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=;
        b=CvPmEoO9OiHsirdjJ0X80D+4ppTpTMVsP/bBAkmqSU5sgSuy9oWE6E/c+PrwLwjMow
         Marypltem8IOWgtj9urqUpYz/4sviZ6qG3EQzI2vcdK+37t/KNf8QPgBtU1EGeIW5hjG
         iSyo5OO+LgcfbdLAqQvj39wVX+fnqTNZlPwPcAEizp/YZ+BzQesqjR/Bzp2HHSVrMpbw
         ZNEYXsFlcZuuzFIsraLgCMCA9gE8Gxl9ERE/kwYPeXnB5FIF4BlTwYHmobBt3bd8uWbk
         I4j7emzvTtasAdrqW0zSu4kHcj5GVGCBDjOc0MW5XvaOAP71Lm3lGm9v9XYib2ptFksU
         pNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783189990; x=1783794790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qeewdBY9B/GoXx4wh8GHCfZpl3Bn2RXn06zKpHrow0s=;
        b=GMepoENjVvHl8HzvmR27WH1UfHmLZ8wBidmFjhb3U1c9K7zwrd7Qj+36hO8ejf/igb
         aeOC+EERgrwYLsG5MIWv7hBkQJmq8rwbHsAw62/OiHDAnhtFSskd+Em6fl0MVgisOu56
         seQt2il45me+ExPoVlFlEQZZ7cER3ND1DOIzF7T2tPV9c+Ih/IBt13NvJTDeCgtyGhhW
         Oc2q+tWWBNGQ/QK2uCL23O1QLFrV5F33KPhEtDFvn3hZlP2gff/9EK82m8Wi251lxeIP
         sjDZnyJyAvAMb0XA662a3/WLn0APAQUVQmC9Z/0Hv6n1SSrmgwYZLW4Z3XI62tyO6OBg
         BZSg==
X-Forwarded-Encrypted: i=1; AFNElJ8QSSChM8uJ0jxlJsix5cSFHlGI69lmbKfgAgWeucBNi8AtxbpfSJyR+KwSpbFVCOt6AO3j5Mz1HU4gBMc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpYSL4SLUFuPVNbjnkVhp6WCWcI7lstBwjaBbTJSY5R531S3CE
	UXaM46toCAppqih3vcjOx2PK9iIqI1hUrHCh0/zOV53kZtnIQDBKvyG1jcPCwhhKhuAf3yVNA5R
	Rok+qxiKPQSSBxop7vx6lACwzNhPTyKUtQrYgk6FpKOA+eXo93Y/b6spRyg9WYDDAwgg7B7m4YQ
	5uJeaTmQ==
X-Gm-Gg: AfdE7clHfFLyMdTxFsk8GwgS1V7mk8wA1GgfgFEW75JZcMgv72Czcgkz8J9OVM+1jQj
	1yxx+rSLqGLQzm3jbBq7i2Np55k7LrSh6ktBHAENzzS8VeaH9JLqtw1ebHvqg2k8ZxzfpnG4X2S
	l/AT8aOKYNcxMpuUOYDNxxyuzvftQbIlKClpj1tt+/HF5M2VS5v0v8KwwsGA7vISBvMPRg6QUcp
	Hn74kkU8boKmkiVBV0AEcOdswC3lZC48/SsRhHyn3KQjlGIL2K712BskCfMShr44BRo4e42Sylq
	/J0+8xHPcpLRCHEwacDXWy5Ysh9GCKF3PaxwflG6OxBxHbEWLAkuzVYH2SiTQzjlU5OA+5i7HtG
	9XfTg1uZ+50asVoHxAe7/TJc=
X-Received: by 2002:a05:6a00:2e9f:b0:847:8791:f54f with SMTP id d2e1a72fcca58-847f86eaa41mr3109150b3a.29.1783189989801;
        Sat, 04 Jul 2026 11:33:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9f:b0:847:8791:f54f with SMTP id d2e1a72fcca58-847f86eaa41mr3109120b3a.29.1783189989281;
        Sat, 04 Jul 2026 11:33:09 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:33:08 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:14 +0800
Subject: [PATCH 5/9] drm/pl111: replace struct drm_simple_display_pipe with
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
Message-Id: <20260705-drm-simple-kms-removal-v1-5-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=11040;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=UIMnAJmAsHNwzG3sUZoBE/LPKERzVi4sWM5J738IWxI=;
 b=RA4hDvGQcIHiHVgB2nIPn7/+tx2Alt8IiBFpU/Uf0g/qT5hFfsIN9rsVXLuWJcPpHLAeWBSzR
 q+gEaxP+EW5CPiUrPHYeBUiOXsCRtxFFrHUtMoJ7EySIxRCwYIyPTDI
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX2Y6FgK0uwmAY
 5KX7L5pzInFmvtBuZI1drTfF1fCtPnWGrQBEEv3V2c42KRk4gK3SBLjlr8veGgenJ5Rrh+buJrR
 dr8vTTOO6LFVGl5+4ecUlASvnbdFE10=
X-Proofpoint-ORIG-GUID: MgGLeCX161y7VRhgSMHOx9Bz1SRan3HS
X-Proofpoint-GUID: MgGLeCX161y7VRhgSMHOx9Bz1SRan3HS
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4951e6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zKtxPG1kur982WRNNmIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX0Xg7V9EVVvls
 C+eXtOncg07UMFwTDCRoXuwQ3vKt9F95O8+QYD4YtCov4VEFLfmN1dI6qmCYfAqhJ0mHZSbuwKN
 Dphu8IuA0WEJ2i7DBaMQlV2Bb4TiEMAX+gUhDZaSAVEQYCrQpdjz89TB6O2dkbC+/26baaxQrjK
 1HA6gBl9tMpM+zhYlgeykm2/lUwZHOuVNMS5bVLtL39BAXXFzedtOg+7hxCss5qPP4UfHGKz0W8
 VLGTYLATT6uVuMI2flZ9nDhfOT+33bPTNmHHluk6ewBsZBrcFgpwvwoSbPMpFsAunvIvYNamRM6
 XgGFXLtHKL3dfZYdd7YDOLHapV0Y0H83JJI9Gbn0WwOTqFJAYENMbUw+x66fJWMQc2fPnPCmSbA
 rjJ8j9vDwHlDVCPfMONwJa7034wUBDu5fOXab8iMZP5ZkiKaFSjH3EQ3eGktU1JDcrIPocQOHlF
 Bv3GvFgI72/VQ8eFn8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

Replace PL111 simple display pipe with explicit plane, CRTC and encoder
objects.

Keep existing hardware programming and vblank behavior, and install GEM
framebuffer prepare helper explicitly.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_display.c | 174 ++++++++++++++++++++++++++--------
 drivers/gpu/drm/pl111/pl111_drm.h     |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c     |   3 +-
 3 files changed, 136 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 5d10bc5fdf1f..b1bdd4c9dbe6 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -15,6 +15,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/of_graph.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -37,7 +38,7 @@ irqreturn_t pl111_irq(int irq, void *data)
 		return IRQ_NONE;
 
 	if (irq_stat & CLCD_IRQ_NEXTBASE_UPDATE) {
-		drm_crtc_handle_vblank(&priv->pipe.crtc);
+		drm_crtc_handle_vblank(&priv->crtc);
 
 		status = IRQ_HANDLED;
 	}
@@ -49,10 +50,10 @@ irqreturn_t pl111_irq(int irq, void *data)
 }
 
 static enum drm_mode_status
-pl111_mode_valid(struct drm_simple_display_pipe *pipe,
-		 const struct drm_display_mode *mode)
+pl111_crtc_helper_mode_valid(struct drm_crtc *crtc,
+			     const struct drm_display_mode *mode)
 {
-	struct drm_device *drm = pipe->crtc.dev;
+	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 	u32 cpp = DIV_ROUND_UP(priv->variant->fb_depth, 8);
 	u64 bw;
@@ -83,13 +84,35 @@ pl111_mode_valid(struct drm_simple_display_pipe *pipe,
 	return MODE_OK;
 }
 
-static int pl111_display_check(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *pstate,
-			       struct drm_crtc_state *cstate)
+static int pl111_plane_helper_atomic_check(struct drm_plane *plane,
+					   struct drm_atomic_commit *state)
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
 
 	if (mode->hdisplay % 16)
 		return -EINVAL;
@@ -117,16 +140,14 @@ static int pl111_display_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *cstate,
-				 struct drm_plane_state *plane_state)
+static void pl111_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_plane *plane = &pipe->plane;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
+	struct drm_crtc_state *cstate = crtc->state;
 	const struct drm_display_mode *mode = &cstate->mode;
-	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_framebuffer *fb = priv->plane.state->fb;
 	struct drm_connector *connector = priv->connector;
 	struct drm_bridge *bridge = priv->bridge;
 	bool grayscale = false;
@@ -355,9 +376,9 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		drm_crtc_vblank_on(crtc);
 }
 
-static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
+static void pl111_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 	u32 cntl;
@@ -387,17 +408,23 @@ static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
 	clk_disable_unprepare(priv->clk);
 }
 
-static void pl111_display_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_pstate)
+static void pl111_plane_helper_atomic_update(struct drm_plane *plane,
+					     struct drm_atomic_commit *state)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_device *drm = crtc->dev;
-	struct pl111_drm_dev_private *priv = drm->dev_private;
-	struct drm_pending_vblank_event *event = crtc->state->event;
-	struct drm_plane *plane = &pipe->plane;
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct drm_device *drm;
+	struct pl111_drm_dev_private *priv;
+	struct drm_pending_vblank_event *event;
 	struct drm_plane_state *pstate = plane->state;
 	struct drm_framebuffer *fb = pstate->fb;
 
+	if (!crtc)
+		return;
+
+	drm = crtc->dev;
+	priv = drm->dev_private;
+	event = crtc->state->event;
+
 	if (fb) {
 		u32 addr = drm_fb_dma_get_gem_addr(fb, pstate, 0);
 
@@ -416,9 +443,8 @@ static void pl111_display_update(struct drm_simple_display_pipe *pipe,
 	}
 }
 
-static int pl111_display_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int pl111_display_enable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
@@ -427,21 +453,63 @@ static int pl111_display_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void pl111_display_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void pl111_display_disable_vblank(struct drm_crtc *crtc)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
 
 	writel(0, priv->regs + priv->ienb);
 }
 
-static struct drm_simple_display_pipe_funcs pl111_display_funcs = {
-	.mode_valid = pl111_mode_valid,
-	.check = pl111_display_check,
-	.enable = pl111_display_enable,
-	.disable = pl111_display_disable,
-	.update = pl111_display_update,
+static int pl111_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
+static struct drm_crtc_funcs pl111_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs pl111_crtc_helper_funcs = {
+	.mode_valid	= pl111_crtc_helper_mode_valid,
+	.atomic_check	= pl111_crtc_helper_atomic_check,
+	.atomic_enable	= pl111_crtc_helper_atomic_enable,
+	.atomic_disable	= pl111_crtc_helper_atomic_disable,
+};
+
+static const struct drm_plane_funcs pl111_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.reset			= drm_atomic_helper_plane_reset,
+	.destroy		= drm_plane_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs pl111_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= pl111_plane_helper_atomic_check,
+	.atomic_update	= pl111_plane_helper_atomic_update,
+};
+
+static const struct drm_encoder_funcs pl111_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static int pl111_clk_div_choose_div(struct clk_hw *hw, unsigned long rate,
@@ -583,18 +651,40 @@ int pl111_display_init(struct drm_device *drm)
 		return ret;
 
 	if (!priv->variant->broken_vblank) {
-		pl111_display_funcs.enable_vblank = pl111_display_enable_vblank;
-		pl111_display_funcs.disable_vblank = pl111_display_disable_vblank;
+		pl111_crtc_funcs.enable_vblank = pl111_display_enable_vblank;
+		pl111_crtc_funcs.disable_vblank = pl111_display_disable_vblank;
 	}
 
-	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
-					   &pl111_display_funcs,
-					   priv->variant->formats,
-					   priv->variant->nformats,
-					   NULL,
-					   priv->connector);
+	ret = drm_universal_plane_init(drm, &priv->plane, 0,
+				       &pl111_plane_funcs,
+				       priv->variant->formats,
+				       priv->variant->nformats,
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
 		return ret;
 
+	drm_plane_helper_add(&priv->plane, &pl111_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->plane,
+					NULL, &pl111_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&priv->crtc, &pl111_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &priv->encoder, &pl111_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	priv->encoder.possible_crtcs = drm_crtc_mask(&priv->crtc);
+
+	if (priv->connector) {
+		ret = drm_connector_attach_encoder(priv->connector,
+						   &priv->encoder);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index d1fe756444ee..ec92a5a180a8 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -21,7 +21,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_panel.h>
-#include <drm/drm_simple_kms_helper.h>
 
 /*
  * CLCD Controller Internal Register addresses
@@ -135,7 +134,9 @@ struct pl111_drm_dev_private {
 	struct drm_connector *connector;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 
 	void *regs;
 	u32 memory_bw;
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f5..f649c266c33a 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -168,8 +168,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
-						    bridge);
+	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
 	if (ret)
 		return ret;
 

-- 
2.55.0


