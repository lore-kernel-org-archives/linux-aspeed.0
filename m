Return-Path: <linux-aspeed+bounces-4556-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC795C53219
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6H2cQnz2xYh;
	Mon, 27 Jul 2026 10:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095204;
	cv=none; b=jvG2/AhNNybT7FDd1RFO0qXs6nB0GTO/nq2nSa8cKVSYs5fIG/eNtFyyoXYyCEeLuefYPz6rLNGxtQkHsFLZUDnsfvLG/BxzuQ15Jdzz+eJGiE572bitsfjWtB5oGdCKkXIJkuNnCJPC6HGYNCumVO/2oHUcqZ1VZVzjC649rUK0+2bOAC6LtlM6c/N52Qmq1X/ZnYCGf8kvciKwq+ZskSiAOlh/5RNhTIh08A4KleBAeY+2cBWqhjFuEg2MuiN9hhwVeCuF4KYKvT37m85cBZOxUVrBAAtCYE6OYaOB+L0j6JiJztHoyoi3HtSmSDqMZF3P3wxmAO+Ask7kaXTXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095204; c=relaxed/relaxed;
	bh=wSGeQRwMP4eO9GjmSugudIPnkFmlYP4r8d4tXRAJ/XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEqreXwxz1N26xrRQ1ecEfLHRqxRbPPjmbxbYueA2W2tZvqwL3gw1yz5H7dhrEIijDDE8Pth/ApwhRdj/O/m99i3gjhi3Qig1cAM3HOpcCVD0r64m5M/0sY5J2Z6sZoMaBXh7lRC9c4VTUel5HPFMwnwkbpiw0xELSTpYN6abwg37LclCaAsLvMBJ1etAkjabqRxE3ZoOzVqmQBD7pgg9QIYDzpr2mStn3qgXUCM7WmVPBWhFnxTRzdX/Q65zxLnaF1M2i04QMtPjmjUckAuXPWG7/lFWw8yrS7CB1LfN5ataMXzmwJtIyv74wc9QibApjl+ck6ZPF9LrpuaGCP0Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KhyqLUah; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ihab+y1Z; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KhyqLUah;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ihab+y1Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XKv6wXcz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:46:43 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH7RMn1524300
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wSGeQRwMP4eO9GjmSugudIPnkFmlYP4r8d4tXRAJ/XE=; b=KhyqLUahopd1K+8F
	/i7o6UN4Zy4pvwoukMXxUan1QmeEdB8UIb9Ks8LzYVawYUykG71n98l1/g4JQihk
	zsAB4zh6e/2qkEhaZ/XIaXpbmeevlQ/9AwssdwfNZfZTL8xE70i1bgSpzqNSvVGA
	HEiC9jox5mGm/z3/nHocm7ymikNfv3bMB+nzN9oQLceFfKRH5WE7KehG9KoAucVV
	X1A+rbGBCf2dwZFDvi1gJ8iTE2R/KtK/KrgnYxMpDPG11DrG5ZE0e0pnGcKAJLoL
	yykF0vrX80gwHl2keJetGHSUKwpA2Nfe6p6KfuBq/xXj8lQc2k4WfhcDE+U7jxlR
	7+79yw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sbp44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e63de75aaso3403629a91.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095201; x=1785700001; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSGeQRwMP4eO9GjmSugudIPnkFmlYP4r8d4tXRAJ/XE=;
        b=Ihab+y1ZNdlRZQlcKeNFyC7FjbIknFn2slHKIG3IqZ4V514rXz+qOeF764g8O/ZOdu
         TCKErVWPOHrsbHoT4WQxZZ8wOlTRmrpD9u52jsrMoeVY5Za/cKInWg7rHvW4GUFi7WAc
         he51DdcJH3u0VpTIMu+CAvyjJHt6lEgYcqqnAFcshU24eE8PSFxBVGIcw3HKUG+bdg9B
         jcNtM1s9smvNOpvABS5n8fNye76ikCi/2NtNdsHDRiJ7RiXZCJOredPe33gGZ9zReNKU
         bKH7Yctde0TvH3XwLPWzpkJL0mciiAPrJecUK59iJWrvB8aNvu7tftqES0vaTkcX6W6R
         7c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095201; x=1785700001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSGeQRwMP4eO9GjmSugudIPnkFmlYP4r8d4tXRAJ/XE=;
        b=s6305IURJboatrZdZTKhcPUEo2UI7Ny29k3OMcxrR4gWUncDeJzKB/WaNr29ycNpBG
         b+mqAqqqUE2UqkUUXyWxd99ZCyxYk/CGmdq+HErvMbPHIZj8D1BWRMWIRnRI5YtsWkYb
         lRdpqXlY6FfzpKz/51wm6q7dU0ijDhj7q7K2bh7yhuHxA3aTeVGqGLW5SgJ4k4Flx8Vz
         MOF945dZFMKJdC/K393zNHYXXtibvBsXrQ5T3MXP5BOFdrKd/jMNMWUFAYHNDr9sIAiz
         HlwE3vMANEtHa/UOpFobRR2hnxA0vbberxSrDyPz4ByCnlEPZ+56HdZj777liP0velux
         QG4w==
X-Forwarded-Encrypted: i=1; AHgh+RpxTpD4ei5ZDhO9nc7APkHg/U8IDvIlwCBBmPKH2xm1fGIwThQ66U8D010aV9ueBCbinoguaV2wh6cJnRQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwG5suYJ9Qsxx+vFwdXqLspFEG4+lBUYmw7Gd0PpibZcEsf3Ao+
	deuuEqpuinSx6kj4dZLyi8MjjiRjrnOETqL1nwVX7cyKBXdW3WTZAPm8X0RLyQTM/+yMluecz+K
	gjW+LEyseIsuY3yp1rhk+mIoKAF0UrBQXvux+eYh7nTzDHSSRrq/wu/51eTY3ZFizMPgj
X-Gm-Gg: AR+sD13/JYCsuLN+KWemBJceE4RaItOL2EMbM/x5XKexgVtVAdEEwMJGgSRJayOXMEl
	Ck87DoeEZAPY/FuG5g83DidZEY9dYhyYmSfYYPHYgmp87M4/WgVW+Nudpe2TcwWX9RCbmXbCB2y
	2s683WBm8OMxlt76Q2017cwnUKuKb75Co9Opi9JfR7UjSv4JIMGTrYsEt/iSOua7XksO6Hxw9wH
	zS4YRd+FCBsJohyBTT4Wchd15ZmHv4xFLnjXKsDQSSi5ID9gKYDF6putGPJM+c4G+yyXujQ69mH
	8OCpm3uHdBFqEDgERulvBAxuAIPod4aXyFiuVJD+d3y9dvF44Z4FvPBAn6CteFseojKq2EGL3j2
	3EgmUP/7ipx+dx1Ja07Ek
X-Received: by 2002:a17:90b:1d44:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-38f29613652mr5757533a91.28.1785095200535;
        Sun, 26 Jul 2026 12:46:40 -0700 (PDT)
X-Received: by 2002:a17:90b:1d44:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-38f29613652mr5757521a91.28.1785095200078;
        Sun, 26 Jul 2026 12:46:40 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm4105998a91.8.2026.07.26.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:46:39 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 03:45:21 +0800
Subject: [PATCH v3 8/8] drm/xen: replace struct drm_simple_display_pipe
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
Message-Id: <20260727-drm-simple-kms-removal-v3-8-cd5dc89858c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095129; l=12894;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=PBi4kPXC6bDPKtTGd5qKGiDifkO/iF7Wup738qwpRwk=;
 b=oinILOU2wbGLYnenfbXSKIYuY97ShWRNCMA98C159D9els3KvEJFV0EOtNDjwTl46s7UQU1oH
 AXM4ZR3zIj+Bsp+yxt1D7aR4Bdwl0q4QKSVjC9zIMUkDziqZf2vfXbJ
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMSBTYWx0ZWRfXw54o3VI9eXly
 kgTz7033vYltp058T0X1BGhajdjWTcyGyRZJDUHmuHi+iArT/oUG+U7hBmt8hm3ixVZmV5qesnF
 979QPd9agVa+46pSnUOsCadDEpVtMDM6UyQU0ts/D1oUy74D0o4WmCfFqthtSwuIDJ2n8iQfXxi
 XYQg7K3FGyGCScgLxadxJiHpEStL0XtBCMhjPP/2rwt1SVsrv3Wp5st+mIDESdWOpBZF+I0/RXY
 XEHHzaPEoMSI6ebnxTlO8ko7Bta8r4s9d9m6kpdb/jpLODsHJwRP1mBE+DPQ1BR3iB/+fOK01SU
 2Cw0vnE9/M9grgwGMhfE6qhvwyij/ppZYHgyBjr9/Rg2+h0rBiz4uXi+fvIvndI9MI7EW/HBuaZ
 Iy9eluC4FOZmBITsZNDFAVE8HPVSL6+rDrLX48eRmnWpgXhP3OfE4aJ+ry3T6OOlHE6vAgyhRkn
 wry1pDae81G8ZyeUPaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMSBTYWx0ZWRfXzN2zLcaoAk0e
 q2iH936c7mlKW1ZqCUchXNE3tahuL4jRC1eqQ7e7ivLG0oBB4mLLDvYDX0UKr7XA5rSg7DGhZ6o
 iyEmVLNVYb+A/BLq5cOgdt1lHvSIIgo=
X-Proofpoint-ORIG-GUID: ObGREgNml9LPx_GMF15Tb_sHmy_22lRY
X-Proofpoint-GUID: ObGREgNml9LPx_GMF15Tb_sHmy_22lRY
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a666421 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ypIeFc3LJoL4UEiODvkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260201

Replace the Xen frontend simple display pipe with explicit plane, CRTC
and encoder objects for each pipeline.

Keep generic plane-state validation before Xen-specific checks, and
install the GEM framebuffer prepare helper explicitly.

Use commit-local plane state in the CRTC enable path and pass the new
plane source position to the backend mode-set request. Handle pending
page-flip events through the commit-local CRTC state in the plane update
path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

---
Changes in v3:
- Use commit-local plane state in the CRTC enable path.
- Pass the new plane source position to the xen_drm_front_mode_set.
- Make the container helpers static inline.
---
 drivers/gpu/drm/xen/xen_drm_front.h     |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 188 +++++++++++++++++++++++---------
 2 files changed, 142 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
index a987c78abe41..02138b5abef5 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.h
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -14,7 +14,7 @@
 #include <linux/scatterlist.h>
 
 #include <drm/drm_connector.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 
 #include "xen_drm_front_cfg.h"
 
@@ -100,7 +100,9 @@ struct xen_drm_front_drm_pipeline {
 
 	int index;
 
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 
 	struct drm_connector conn;
 	/* These are only for connector mode checking */
diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 48772b5fe71c..9896ea35b743 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -30,10 +30,16 @@
  */
 #define FRAME_DONE_TO_MS	(XEN_DRM_FRONT_WAIT_BACK_MS + 100)
 
-static struct xen_drm_front_drm_pipeline *
-to_xen_drm_pipeline(struct drm_simple_display_pipe *pipe)
+static inline struct xen_drm_front_drm_pipeline *
+xen_drm_pipeline_from_crtc(struct drm_crtc *crtc)
 {
-	return container_of(pipe, struct xen_drm_front_drm_pipeline, pipe);
+	return container_of(crtc, struct xen_drm_front_drm_pipeline, crtc);
+}
+
+static inline struct xen_drm_front_drm_pipeline *
+xen_drm_pipeline_from_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct xen_drm_front_drm_pipeline, plane);
 }
 
 static void fb_destroy(struct drm_framebuffer *fb)
@@ -94,7 +100,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 
 static void send_pending_event(struct xen_drm_front_drm_pipeline *pipeline)
 {
-	struct drm_crtc *crtc = &pipeline->pipe.crtc;
+	struct drm_crtc *crtc = &pipeline->crtc;
 	struct drm_device *dev = crtc->dev;
 	unsigned long flags;
 
@@ -105,24 +111,21 @@ static void send_pending_event(struct xen_drm_front_drm_pipeline *pipeline)
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
 
-static void display_enable(struct drm_simple_display_pipe *pipe,
-			   struct drm_crtc_state *crtc_state,
-			   struct drm_plane_state *plane_state)
+static void xen_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
 {
-	struct xen_drm_front_drm_pipeline *pipeline =
-			to_xen_drm_pipeline(pipe);
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_framebuffer *fb = plane_state->fb;
+	struct xen_drm_front_drm_pipeline *pipeline = xen_drm_pipeline_from_crtc(crtc);
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, &pipeline->plane);
+	struct drm_framebuffer *fb = pstate->fb;
 	int ret, idx;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(crtc->dev, &idx))
 		return;
 
-	ret = xen_drm_front_mode_set(pipeline, crtc->x, crtc->y,
+	ret = xen_drm_front_mode_set(pipeline, pstate->crtc_x, pstate->crtc_y,
 				     fb->width, fb->height,
 				     fb->format->cpp[0] * 8,
 				     xen_drm_front_fb_to_cookie(fb));
-
 	if (ret) {
 		DRM_ERROR("Failed to enable display: %d\n", ret);
 		pipeline->conn_connected = false;
@@ -131,13 +134,13 @@ static void display_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static void display_disable(struct drm_simple_display_pipe *pipe)
+static void xen_drm_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
-	struct xen_drm_front_drm_pipeline *pipeline =
-			to_xen_drm_pipeline(pipe);
+	struct xen_drm_front_drm_pipeline *pipeline = xen_drm_pipeline_from_crtc(crtc);
 	int ret = 0, idx;
 
-	if (drm_dev_enter(pipe->crtc.dev, &idx)) {
+	if (drm_dev_enter(crtc->dev, &idx)) {
 		ret = xen_drm_front_mode_set(pipeline, 0, 0, 0, 0, 0,
 					     xen_drm_front_fb_to_cookie(NULL));
 		drm_dev_exit(idx);
@@ -177,12 +180,13 @@ static void pflip_to_worker(struct work_struct *work)
 	send_pending_event(pipeline);
 }
 
-static bool display_send_page_flip(struct drm_simple_display_pipe *pipe,
+static bool display_send_page_flip(struct xen_drm_front_drm_pipeline *pipeline,
+				   struct drm_atomic_commit *commit,
 				   struct drm_plane_state *old_plane_state)
 {
 	struct drm_plane_state *plane_state =
-			drm_atomic_get_new_plane_state(old_plane_state->state,
-						       &pipe->plane);
+			drm_atomic_get_new_plane_state(commit,
+						       &pipeline->plane);
 
 	/*
 	 * If old_plane_state->fb is NULL and plane_state->fb is not,
@@ -193,8 +197,6 @@ static bool display_send_page_flip(struct drm_simple_display_pipe *pipe,
 	 * sent to the backend as a part of display_set_config call.
 	 */
 	if (old_plane_state->fb && plane_state->fb) {
-		struct xen_drm_front_drm_pipeline *pipeline =
-				to_xen_drm_pipeline(pipe);
 		struct xen_drm_front_drm_info *drm_info = pipeline->drm_info;
 		int ret;
 
@@ -224,10 +226,29 @@ static bool display_send_page_flip(struct drm_simple_display_pipe *pipe,
 	return false;
 }
 
-static int display_check(struct drm_simple_display_pipe *pipe,
-			 struct drm_plane_state *plane_state,
-			 struct drm_crtc_state *crtc_state)
+static int xen_drm_plane_helper_atomic_check(struct drm_plane *plane,
+					     struct drm_atomic_commit *commit)
 {
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_crtc_state *crtc_state = NULL;
+	int ret;
+
+	if (plane_state->crtc) {
+		crtc_state = drm_atomic_get_crtc_state(commit, plane_state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+	}
+
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+
+	if (!plane_state->visible || !crtc_state)
+		return 0;
+
 	/*
 	 * Xen doesn't initialize vblanking via drm_vblank_init(), so
 	 * DRM helpers assume that it doesn't handle vblanking and start
@@ -242,16 +263,17 @@ static int display_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void display_update(struct drm_simple_display_pipe *pipe,
-			   struct drm_plane_state *old_plane_state)
+static void xen_drm_plane_helper_atomic_update(struct drm_plane *plane,
+					       struct drm_atomic_commit *commit)
 {
-	struct xen_drm_front_drm_pipeline *pipeline =
-			to_xen_drm_pipeline(pipe);
-	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct xen_drm_front_drm_pipeline *pipeline = xen_drm_pipeline_from_plane(plane);
+	struct drm_crtc *crtc = &pipeline->crtc;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
 	struct drm_pending_vblank_event *event;
 	int idx;
 
-	event = crtc->state->event;
+	event = crtc_state ? crtc_state->event : NULL;
 	if (event) {
 		struct drm_device *dev = crtc->dev;
 		unsigned long flags;
@@ -259,13 +281,13 @@ static void display_update(struct drm_simple_display_pipe *pipe,
 		WARN_ON(pipeline->pending_event);
 
 		spin_lock_irqsave(&dev->event_lock, flags);
-		crtc->state->event = NULL;
+		crtc_state->event = NULL;
 
 		pipeline->pending_event = event;
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 	}
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx)) {
+	if (!drm_dev_enter(crtc->dev, &idx)) {
 		send_pending_event(pipeline);
 		return;
 	}
@@ -278,19 +300,17 @@ static void display_update(struct drm_simple_display_pipe *pipe,
 	 * If this is not a page flip, e.g. no flip done event from the backend
 	 * is expected, then send now.
 	 */
-	if (!display_send_page_flip(pipe, old_plane_state))
+	if (!display_send_page_flip(pipeline, commit, old_plane_state))
 		send_pending_event(pipeline);
 
 	drm_dev_exit(idx);
 }
 
 static enum drm_mode_status
-display_mode_valid(struct drm_simple_display_pipe *pipe,
-		   const struct drm_display_mode *mode)
+xen_drm_crtc_helper_mode_valid(struct drm_crtc *crtc,
+			       const struct drm_display_mode *mode)
 {
-	struct xen_drm_front_drm_pipeline *pipeline =
-			container_of(pipe, struct xen_drm_front_drm_pipeline,
-				     pipe);
+	struct xen_drm_front_drm_pipeline *pipeline = xen_drm_pipeline_from_crtc(crtc);
 
 	if (mode->hdisplay != pipeline->width)
 		return MODE_ERROR;
@@ -301,12 +321,53 @@ display_mode_valid(struct drm_simple_display_pipe *pipe,
 	return MODE_OK;
 }
 
-static const struct drm_simple_display_pipe_funcs display_funcs = {
-	.mode_valid = display_mode_valid,
-	.enable = display_enable,
-	.disable = display_disable,
-	.check = display_check,
-	.update = display_update,
+static int xen_drm_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *commit)
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
+static const struct drm_plane_helper_funcs display_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= xen_drm_plane_helper_atomic_check,
+	.atomic_update	= xen_drm_plane_helper_atomic_update,
+};
+
+static const struct drm_plane_funcs display_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs display_crtc_helper_funcs = {
+	.mode_valid	= xen_drm_crtc_helper_mode_valid,
+	.atomic_check	= xen_drm_crtc_helper_atomic_check,
+	.atomic_enable	= xen_drm_crtc_helper_atomic_enable,
+	.atomic_disable	= xen_drm_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs display_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs display_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static int display_pipe_init(struct xen_drm_front_drm_info *drm_info,
@@ -331,10 +392,37 @@ static int display_pipe_init(struct xen_drm_front_drm_info *drm_info,
 
 	formats = xen_drm_front_conn_get_formats(&format_count);
 
-	return drm_simple_display_pipe_init(dev, &pipeline->pipe,
-					    &display_funcs, formats,
-					    format_count, NULL,
-					    &pipeline->conn);
+	ret = drm_universal_plane_init(dev, &pipeline->plane, 0,
+				       &display_plane_funcs,
+				       formats, format_count,
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(&pipeline->plane, &display_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(dev, &pipeline->crtc,
+					&pipeline->plane, NULL,
+					&display_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&pipeline->crtc, &display_crtc_helper_funcs);
+
+	ret = drm_encoder_init(dev, &pipeline->encoder,
+			       &display_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	pipeline->encoder.possible_crtcs = drm_crtc_mask(&pipeline->crtc);
+
+	ret = drm_connector_attach_encoder(&pipeline->conn, &pipeline->encoder);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 int xen_drm_front_kms_init(struct xen_drm_front_drm_info *drm_info)

-- 
2.43.0


