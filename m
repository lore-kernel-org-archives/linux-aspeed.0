Return-Path: <linux-aspeed+bounces-4355-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CA1C43602
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSG4myBz2yhP;
	Sun, 05 Jul 2026 15:36:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783190000;
	cv=none; b=IRmleNQ+fxPtZF6ePlU+eqOf/b+89roBaoGKZZxkvSiuc6FsxjEm/sZUqfd1pM5DDkXE05BDQCZXCFeUkRcNLzyMYNnqZ8vkaTEnaeUAxNpMbPZuE5+09KsqKaFAJH7NinhNH4xaI5X3Wuunp2glx3H2Fx34J1RyzntTXo/u+VfXVMlV4zySdna0vBihasVMd5RK7sHQyHrdeebuEsCt6jRGzjuUquLpVWkBoiE1Gj+WV8WSEkLfFVit4Xe/O6P8BH5NFJKZcirJaqC4Lio/NTYYuj4WxWXjR6wNsz7KEzMeyZj1Ox0YXjaXMzuWPhNCojV9m+nQlXwdTQunjpYrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783190000; c=relaxed/relaxed;
	bh=/kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9xMqh/f7in/8ehxpIu92R1eWL+KNvbppcYBCzap06diYP3MgFYMrPgDhxfRgX/Z5SIQzR4MSsPzEJJMHEBrc+70vxXEIYRtxoxSTQfe+tCpXaZLDA8EbguLPBkxaKSo5dzVuRxVfIyLEadjO9LNXFjjxmtAyEPwYK2YBCzksPZRAceY3OeGcdBKDRYF0SVbkzoMUu2bTVtd5LJTRF2vVnCMQjAnNRCKcMOLPUzzeZs6b8K5d/voPsCj5gtfaIozV7Z2euA9DhGB6pmMFrN2jm1BY1jsR2npiEX31ZBmNAKJn8wjTASrSmBjFfO7gLIPIcQ82mOygbetTZ7v0Oumww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=chGpCVDh; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HHhB83KF; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=chGpCVDh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HHhB83KF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszlM33b2z2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:33:19 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664G8oSu3450833
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=; b=chGpCVDhexRvJ6rr
	wnmP0f94vr8luGOm/++TME2IvEnl0eKIx55FeM3CXaEiwLRW7vXHIKtqjy4o6v06
	SAHgN+sR0Jj96ZfmMzcgh335WxtjOsMExrklcuQvZl0uYzFXYR3+G1qMf7iQJMSH
	wgjWX8QkGys5zg3B0KSZEaLe+bq/Tq1HzMGUDBzrixKO/XaeUaogKOUhmMN/5fE/
	Bo4+ixv+GyB7BhGd3crg1HcJOQ2aynBeUQUP5g/YAQXiZVkBVQpbEnRJF5Z03g49
	fz0f/Vv79d7TcM4jozs0CKmd2kiry+IbhZSW0rpic/qx3/3xor4rojO9WILwcw0Y
	/TyXkw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4ssfva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:33:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-847ad67cc51so1578022b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783189997; x=1783794797; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=;
        b=HHhB83KFD/7N3KpFAQPWT5tve80Cmz3oDpke/Oa+a0PBtr2X9xsEjMgTvXoXIovJ+O
         larlxOgiwO4lw3U006abrQ8ttptcA6AQeYdbYXRj4SWf269dExQr3ORnxa+7ZBYKZmGE
         8SiQVUcRRhQCMS2yb/LWYBAoWqB2SKDLNXI5r4N32ae7e0p6jvDPo4/YGv8FKoAfL+8n
         sXpNZMORU/YDBgp/ix4b2xyBsAjUY3EdEYjKJtw6SFuOvMbJ+j+n0ZEMSsJzPQUef0gF
         48K4STHCHXETgApIhmK+OFouQKFpyS8umRhwM092qF6CMnfr95is1IgDBk9dp0pVr5VH
         HlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783189997; x=1783794797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/kuFitKvD+N+j3LNjGp20fDGgGetUmMinD8vCRF2MSU=;
        b=e2kWOe9nEi3vGECNWjfGXId6EIqt4xpxyKLqndsuxc1MsC4Wp04pjRDPZj9Zm37fSA
         0iQbqam1+sMdjHh/gIHkNMQ3Wx5p/JhvFTOnOVHmQ4YcyHhH4QVNT4v5oMwmd9e8x5CG
         979Md63H6j4NDrUFjzptTP7n7SrIws0GqwsgND5sTbRyggjlPZNckWn3Ufb7aIK0ksSc
         5gXZuud7TW8SHSyeXZjcMskk5ylDyWyfiYoJhjCC+tb5rq+pKIE7yxBVbTPioIRWBoJy
         NjXuCaJ/sOsfW3eokK6K14fL/PetykEY0EOFjEsjKU5pDKI1CppUFPe/DA8KjexOWIc1
         tslg==
X-Forwarded-Encrypted: i=1; AHgh+RroV1cHyjBYBHXBvzie7mY6lHzjYW08NRD7COZhi0SMkU7T0+667/DvEP2oDL1bhoj+qDihZAmqbSdz5jk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMjecNvo48INrbrMWpD1FS3Fzrs9GSEDYJooSljlrFC6PXTiAe
	lmIY6hhnOqwF+ACdLrqi/Go1rM8LOnRxf3It44viRmCNYwfUk6qbnnCBJpksI8tdyRPo65zstSn
	lMqBJqlpmJLmn5uAt8U141f+63M7vx5trWnEO+xlfnICLsS4d1yO8giLovaW7f33RXDQM
X-Gm-Gg: AfdE7cmzChtt/HHgC6eWrde1u7XG9qmjld7S8ny8Jy7fL9Nhq/Pbph3llbp1RLOoLeT
	J8sqLBmqCQYw/cNfbkX091Dr0qsWI+V03waGDFkI189CfgcEPU72F1gt5e7XAx4SzqX5cvvB20m
	h7d1+0FyHXq93LfRMUrCBPUUJw/qzO3urxnC6sjufmo3WEF2witFOhRy2AkyCChMtAx9HY4WiwF
	WzlzZtJljapFAxzQB8+Fakc+iSCu1KZeV9hikb1Fwp8bC0dzw2AkWUkewfOeKiFVGbtBicurbPo
	yudfkk2dwFJ0o5AU5jEk2Qx0QQcX8UgBHGtAVpFUaudUePvnuREUYhfqTF4A3GW3mjF3UD6Kr8F
	de62htdiyqsuYbPMaPnIiNu8=
X-Received: by 2002:a05:6a00:b481:b0:846:2f3d:6275 with SMTP id d2e1a72fcca58-847f6fd61e8mr3673895b3a.58.1783189996846;
        Sat, 04 Jul 2026 11:33:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:b481:b0:846:2f3d:6275 with SMTP id d2e1a72fcca58-847f6fd61e8mr3673864b3a.58.1783189996356;
        Sat, 04 Jul 2026 11:33:16 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:33:15 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:15 +0800
Subject: [PATCH 6/9] drm/gm12u320: replace struct drm_simple_display_pipe
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
Message-Id: <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=7466;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=r2DdGfAWLZ7vlivcGlngDUbsQreUWLRRttkb80TMXtg=;
 b=ZpiamN8SsvzwHpSl4AWbZvzEzxMPS4b0qx+XHy2MamxT7sudsnCfhp6cfZmSMvpCePwkCMiIy
 rN1rIEme/zqBMPX9TVQFYz/cgOxWF7zd0K0T0G1rbbrGY1RY1W5avTu
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX6fV3FnWJJuH3
 VW0aO45+1fCDtkD1FFCBL6O8iZCfmrqjWeOdpT27/GKx+jKgv5VgZBc4H7EiRpOdzoHxlfDWrhs
 XEuMHOhO9U4IWx8pYoYO035D0Xtqt2g=
X-Proofpoint-ORIG-GUID: TU3ENquj4BmWCsN2xYF3ooGoKv30LtfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX7TN9OO9Wi0cH
 9bZjuX5IDRUBCvOHD+EUOpcncr/nKydUoJ4vC3vVhCN+whl+3BNHw4FEYyA19zi2kGGnIMyXPXl
 Ebvy9Ronz90z9DRjHgEfzBHRhlq/QNK5sa8MVm0MmDqlDyX5cRntQwxw7wtitsTRVMzRSTv3I/a
 CeT8psiocPr7oKqL523wDr8CxUquMofcCJZ69jD6SUt+sju7okJSuxE/96cRLxKsHe4sulwLNTP
 RlLh7iNceNCLlPTm+VyWLkNCbV/JqiYP1MQW/SJNy4KVBFwj8Q1cnwmIKrpIQL4tonpE25mmMGL
 s7E/VYWGTfOsF4xVSHn5s049NihhvDa/x30lZr+mLhBv+g4cSAfSfz/riZoPtD2XR9ofeiBKAIN
 2YhuDsrS0SUkL261zLBNd5kWOTvUHcJZCayU22md+5QG5aO5ehFIv+b7rQJ9GHDbfbCvwQctoua
 Hc4VtNKw2+BKjzvH3YA==
X-Proofpoint-GUID: TU3ENquj4BmWCsN2xYF3ooGoKv30LtfW
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4951ed cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=g95SU4BBbiomblFqym4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

Convert gm12u320 to direct primary plane, CRTC and encoder setup.

Keep shadow-plane helper state, framebuffer access helpers and
no-scaling plane-state check from simple-KMS path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 128 ++++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index d73dfebb4353..992160ea794d 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -8,6 +8,7 @@
 #include <linux/usb.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
@@ -27,7 +28,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 static bool eco_mode;
 module_param(eco_mode, bool, 0644);
@@ -87,7 +87,9 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
 
 struct gm12u320_device {
 	struct drm_device	         dev;
-	struct drm_simple_display_pipe   pipe;
+	struct drm_plane	         plane;
+	struct drm_crtc		         crtc;
+	struct drm_encoder	         encoder;
 	struct drm_connector	         conn;
 	unsigned char                   *cmd_buf;
 	unsigned char                   *data_buf[GM12U320_BLOCK_COUNT];
@@ -554,31 +556,33 @@ static int gm12u320_conn_init(struct gm12u320_device *gm12u320)
 }
 
 /* ------------------------------------------------------------------ */
-/* gm12u320 (simple) display pipe				      */
+/* gm12u320 display pipe						      */
 
-static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_plane_state *plane_state)
+static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
 	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
+	struct drm_plane_state *plane_state = crtc->primary->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 
 	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
 	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void gm12u320_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+						struct drm_atomic_commit *commit)
 {
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
 
 	gm12u320_stop_fb_update(gm12u320);
 }
 
-static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_state)
+static void gm12u320_plane_helper_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
@@ -586,11 +590,71 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
 		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
-	.enable	    = gm12u320_pipe_enable,
-	.disable    = gm12u320_pipe_disable,
-	.update	    = gm12u320_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_funcs gm12u320_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int gm12u320_plane_helper_atomic_check(struct drm_plane *plane,
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
+static const struct drm_plane_helper_funcs gm12u320_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= gm12u320_plane_helper_atomic_check,
+	.atomic_update	= gm12u320_plane_helper_atomic_update,
+};
+
+static int gm12u320_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *state)
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
+static const struct drm_crtc_helper_funcs gm12u320_crtc_helper_funcs = {
+	.atomic_check	= gm12u320_crtc_helper_atomic_check,
+	.atomic_enable	= gm12u320_crtc_helper_atomic_enable,
+	.atomic_disable	= gm12u320_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs gm12u320_crtc_funcs = {
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs gm12u320_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static const uint32_t gm12u320_pipe_formats[] = {
@@ -677,13 +741,29 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(&gm12u320->dev,
-					   &gm12u320->pipe,
-					   &gm12u320_pipe_funcs,
-					   gm12u320_pipe_formats,
-					   ARRAY_SIZE(gm12u320_pipe_formats),
-					   gm12u320_pipe_modifiers,
-					   &gm12u320->conn);
+	ret = drm_universal_plane_init(dev, &gm12u320->plane, 0,
+				       &gm12u320_plane_funcs,
+				       gm12u320_pipe_formats,
+				       ARRAY_SIZE(gm12u320_pipe_formats),
+				       gm12u320_pipe_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&gm12u320->plane, &gm12u320_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(dev, &gm12u320->crtc, &gm12u320->plane, NULL,
+					&gm12u320_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&gm12u320->crtc, &gm12u320_crtc_helper_funcs);
+
+	ret = drm_encoder_init(dev, &gm12u320->encoder, &gm12u320_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	gm12u320->encoder.possible_crtcs = drm_crtc_mask(&gm12u320->crtc);
+
+	ret = drm_connector_attach_encoder(&gm12u320->conn, &gm12u320->encoder);
 	if (ret)
 		return ret;
 

-- 
2.55.0


