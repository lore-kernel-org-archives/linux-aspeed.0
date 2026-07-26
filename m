Return-Path: <linux-aspeed+bounces-4559-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789E5C53219
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6T5MTpz2yfH;
	Mon, 27 Jul 2026 10:07:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095182;
	cv=none; b=RLgWNMWKM6FWD2Qlgr3Hr0cf2yfXqE95jccsdFsgYmeau+JRBGuRPQb3/GMDoaJC1VgFm5py+Hg2ngVLVErxhgYhieFPBzsRMNGY0yGD0zDfkhwNaZzGZIfyS4fsm0J+Re6XDUUfa9efM2l8hz1BZ1oCCn1EblMqknZ3CzAdMCVmS+SHlzE1PoASeC+xBtZehzqY7qlKUlwCUYv6/6WU0r9NoLlxVfGN2KqsL+bVSWtQigpBxmFx/VliJvpANI35ZUiFsxaPF1Bgv1dg3cpOU5mgmRP4vJ9nNeJVpNG8FDmEQwg33J+SNsqR4HABpcwtoutTPA0NGoAd12jyJbUxag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095182; c=relaxed/relaxed;
	bh=tzBRrJFfWf9nuUSk+Umahe/GXjmEn4PayMptDA8R4co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMyjM7PkBZHBQKuLCjpXLihdkOVIy3g4ZikyCxa92F5YGFLLDCXERwdc3fwgsEKFhqZK/fSAzbVmmhhLjiolRRosMyTpMn3xVJzGqav1l4271dFV6LfXxBHxhqim/Z8Wdj2gL8wZiGigQhH/iF6CtIEstqSmBsnJAPLtcwN8RY4B6mQAkOXp7gl0AsdIbv7E58esQf2ooVSljx4k+WnhjKxajDRrnRvXuPlmAFOezb6EbJrF5tQtyr43pCP4euu98UnMKALLusKkP1zhytG7MIA9pfhyyTTFTVElvXjZ9jBpVO69mrl4fKCpZFqOr9CGeE6RBFpoe086lLOlXgKPog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSrHRae+; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUgjrG7D; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSrHRae+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUgjrG7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XKT21Zhz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:46:21 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH76HT1191707
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tzBRrJFfWf9nuUSk+Umahe/GXjmEn4PayMptDA8R4co=; b=eSrHRae+4KBJsqzq
	PRmZQmIoQ8J6u9+blj/zwfOFX54m0IOTPrB/iPVShNYnvFDCwzhSKRSqlVKDvuNs
	vA+xR14w273BsD0kDwfefgw+yW4p6AFSBDFMfZ3fpzle9yt2Oi+Vu1hfg1fsXazo
	XKci7DdKH9K+o7gJuy5xA9SXDUa4hrbLKzEXBbgkDODDK679rHG83Fb0Fbcnse/E
	5w82A7Vg9wzAvkzCIPc5pcIvNVdN4FGPG2Nht9vykKbwX1mya0SDeoruIsYgk+FT
	gyUp7CWEzdUcjSXQsYKq2OJwLOpZ2lCCliBingET4Gpo+AiMNbuYYtMb0qCDIR7K
	xDewrw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjgn3ypc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so2884048a91.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095177; x=1785699977; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzBRrJFfWf9nuUSk+Umahe/GXjmEn4PayMptDA8R4co=;
        b=gUgjrG7D7hnhP/ptHkPJuzSflrjQypD+n5cQ1vnca5lWas6U2HaArUTdlN2N+jG6Fs
         vWhbeTtRDQSjJWCbdcsNJE2Uwi9hiAemP5iQyLCqlcvszo96gfnkCM+b5uCd0PedG5FQ
         bFlCUqg+wFf904YJMHJdU55LgO1WthMUy5QV8YLs5WiG+bcsLUrgYosvOAhG6yHcDcpg
         PaTsn6oJY5l2h4tB0Je0HZgPGAvRYEQ6mHwLzDreLsLT2h7iaPJ6kBNYeHZIuMgFyzEu
         Jxk6jX6rD5uletuik1BYwZGdMmvjw8yNP3kgKDfVexSRGHuIdbUF0bgiJBCVlOu81Gza
         XTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095177; x=1785699977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzBRrJFfWf9nuUSk+Umahe/GXjmEn4PayMptDA8R4co=;
        b=baouEQX1Kk9z5Ao9BaA8cNqsCQjbDqL2ZCnCe2RHvB62BbcHTYpq5ODZMqED6uXGnM
         mrz7+jX54RKxY8Ov4MrFR90TY7dS+jNG/isvsOvpOPMEsTVdgN4RJarydXi2U7grqWYO
         qaK+Dtq+mg+E6UTnolGWZZ13ZZza/H4B0i/a5JbKNxHW9nWylIXoIHdphQlPiLdUKTU3
         zv3IzBcDNMWpH5JwZPwKTh+pJTgiWvqYXR3Z7C/BYEWk3C/rOchLdjHNdbySvhzT+1VH
         9Wz5BhkeUShtZjqtAY9ggjshY9YidcIUdXMYzs7RkIlaa0OwjBwiRhh9p319ajSy1m2w
         ZPVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLLD0INNm7hxaFn7JS1jsEqkC33oOrBs0+sBGBqJ4zOMaps8I5Ftqr28OR49UsRYd1wcMbucxbSIwltFA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+/KY8gr+oXEmBdkP+/CM/a/4SYePCPULHrHxg+e4hh04UO6LR
	/Bbp1Auid+M8k9Y1yXCuqNy7JtemCACo3UbKOfvTO0xtJojEVOSRH1ODkd2cfpa7Dg52Du9lQQG
	vOidm4oobdK6ZZb4qzNjSxlZ+O5lkphQmnprQkpB+nK5JwLqVYLEzsBLO21ivq9phO8Mz
X-Gm-Gg: AR+sD11bn5cX1MsZrxCdVhmGPMvVeEj1BjX7K8lCvPHssyxDI1EVR7Dq016f/0oTJws
	pu4qDJTQTMhV6gvidVomWTzooAqbaTLICTdcfjdS5xhHtP1GJJQlEABRydO1DcVSAlwsrXqRZP+
	VL7HxsSRR4wVQgsxWSyse+L5fQME+H0+5huzhVenvY7v7IFxSVj5pDVuHwmMsNP4hwwQ9PWyj6C
	Mb03nUPHc+HT5lIbo9CFVb9al9X1hUxqZ7FFOALKkFcb6aHnq466tVpzbPNp+I0QRI3rWnEvFgZ
	Xx7AxNV1G5w/ZtTGNZXOShkCeJE3PbiCWSAylVU5nOB/9Cktxt6KzWDHwzPfKVgYSm6aKExIrFl
	i0SvBiomKVl1TuSBdrCBB
X-Received: by 2002:a17:90a:d607:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38f294ea129mr5919548a91.14.1785095177306;
        Sun, 26 Jul 2026 12:46:17 -0700 (PDT)
X-Received: by 2002:a17:90a:d607:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38f294ea129mr5919538a91.14.1785095176894;
        Sun, 26 Jul 2026 12:46:16 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm4105998a91.8.2026.07.26.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:46:16 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 03:45:18 +0800
Subject: [PATCH v3 5/8] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
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
Message-Id: <20260727-drm-simple-kms-removal-v3-5-cd5dc89858c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095129; l=8382;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=g+MDix2aoww8WVfrNbk1rE7PxKYObabHjKYvIJmxIMM=;
 b=mVZJXr+XmZgsHgsqa8wml/FP/WY7LcnwyXF2tb9+b/ejFt0L03u0D2Ll1AvyTMa4xxIz1ByxX
 qLo+sDvLyK+DfFgJTfsRiCYyQwCIqSBAsF6iNEqLbnHNKyQJtYM5yyE
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-GUID: d1xJ6Pwc_osBqLyZvRO1jWCmrgCQQFFl
X-Authority-Analysis: v=2.4 cv=HMHz0Itv c=1 sm=1 tr=0 ts=6a66640a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cqCYvchtcWlsvxqGjdoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfXwgRjhwQwyxRW
 LVH3IdWs3tcARRxsP0Lwj0jQnfGhiYAI8SP1aNokcqswoqmhyGAj8AA+UmbemPr8VdlWreqIo2k
 FxNF3lAwDYzsFkvrItMoL5PES0Zn4ekGSXFvHQDrIdKkJI9wRf67Wm1ufQT//XuISRM4eW74Zrh
 CIQ+BDe9XPF27uQYNF0dH655dICAcT1wBvWhi0LE2wLclSTjJK8/bm511bBwKfZ641mP26n+wtG
 w4n2mQGFbFHNDlCrKkDq0ZxYQpmpdM963SO4TvNXNShBxIEZLDhw4GsCffTTIQi/b7TVf6FEbR7
 p7c32t0nMsy/W0MdjD418kup7v5H7GhDvE3i7hXTORpFVbQ2Pn8TUTMzI57xF4nfuB/ZaGbJN2g
 3nT5SlXtwkmkUzsZlrOChffXEAJlsWEixU1hl6Xr+/zaydIBSGE1SYlalFMgGp6r9brC2LFzFCG
 zb3SFL4IhT49vhKwLZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfXyj9Qr2eEmnyv
 LXdr2HklSLQ7fKGAAeS/mreCR3CRZJSRmv6fYGGnY0e7ErR3n/5/kojP0P2fMAgsA2ZwmPIhfdq
 vviSk/LfeuMjl277vl/EstqBU/DtS7s=
X-Proofpoint-ORIG-GUID: d1xJ6Pwc_osBqLyZvRO1jWCmrgCQQFFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260200

Convert gm12u320 to direct primary plane, CRTC and encoder setup.

Keep shadow-plane helper state, framebuffer access helpers and
no-scaling plane-state check from simple-KMS path.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

---
Changes in v3:
- Use commit-local plane state in the CRTC enable path when marking the first
  frame dirty.
- Make the gm12u320 container helper static inline.
---
 drivers/gpu/drm/tiny/gm12u320.c | 138 ++++++++++++++++++++++++++++++++--------
 1 file changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index d73dfebb4353..afcf0dfff14b 100644
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
@@ -102,7 +104,10 @@ struct gm12u320_device {
 	} fb_update;
 };
 
-#define to_gm12u320(__dev) container_of(__dev, struct gm12u320_device, dev)
+static inline struct gm12u320_device *to_gm12u320(struct drm_device *__dev)
+{
+	return container_of(__dev, struct gm12u320_device, dev);
+}
 
 static const char cmd_data[CMD_SIZE] = {
 	0x55, 0x53, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00,
@@ -554,43 +559,106 @@ static int gm12u320_conn_init(struct gm12u320_device *gm12u320)
 }
 
 /* ------------------------------------------------------------------ */
-/* gm12u320 (simple) display pipe				      */
+/* gm12u320 display pipe					      */
 
-static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_plane_state *plane_state)
+static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
 	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, &gm12u320->plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(pstate);
 
 	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
-	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
+	gm12u320_fb_mark_dirty(pstate->fb, &shadow_plane_state->data[0], &rect);
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
+	struct drm_plane_state *state = drm_atomic_get_new_plane_state(commit, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
+	if (!state->fb)
+		return;
+
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
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
+
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static const struct drm_plane_helper_funcs gm12u320_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= gm12u320_plane_helper_atomic_check,
+	.atomic_update	= gm12u320_plane_helper_atomic_update,
+};
+
+static int gm12u320_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *commit)
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
@@ -677,13 +745,29 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
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
2.43.0


