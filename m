Return-Path: <linux-aspeed+bounces-4341-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD4C44500
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:28:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGHC3xnfz2yYf;
	Sun, 05 Jul 2026 15:28:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783190006;
	cv=none; b=FIEu+BLnzA+8FvzrWdQj4GVqNcY6O4VDHzVMFsMCDprVVU0G4MgcMnvOk05k9WpXh9MsgOTUEAC93gPbcLMBV8OpJ2EeN8gW7KU91tvnq6JFZ2NcfZMap1cO6MbyfRWZZIR5dNMdBkaSPNVvKjQzL8QrRa1eHiEpkci7mVERaMMGBq7RbbBNKAu0LzaAjXL/jKdcm3K4Tv2GvDzzI+TuSAjViJ8G2iH6t84n6cqr6mHiwlx5Pfssp/lj3Sfa2EqU58htli3RrpuJbqH+necpVKy6EyaiSNb5r+WwRQ2kKtLB+zpQBnCt37akUSOeDXQdpGYzMHVv7k2DSERsJflaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783190006; c=relaxed/relaxed;
	bh=d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZnfDyN4luRQgpC6M3P4m/H/C4tEAJaEcowEWXALzoK9v8wLZUuxQN0U88yO7gy8YN9cwM/2wueeaLg1RRsjvZs8e0JwWa3mRUpBpB2hGe+U11iclDxCgTcSI4MVz34Emlk5R2ogdOTMPZ1araTdHI5rWGYEO2kQfP1y4phKZ4ksNBtCy7vkIG8Xpg1fyhNtoeuaoB5SKP+ssWU2DQMqCDWsaKCwreMR5TwpcITnLfLXuck7r/ZOWbOFXsvx5kz5ys3ANlsp+NUIIJNmmNr4YN9G7tFQdfuWVihhpnCRg3ljTR6V2luc9mCMfLWdP1c9Wci4edWAKSeQnBsVoauUnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JAoIYFLi; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZnGVXI7b; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JAoIYFLi;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZnGVXI7b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszlT545Wz2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:33:25 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664G8Uab3236251
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=; b=JAoIYFLieW2sulob
	8aKS9YKc17lyfb7CkmeQiYpno8SQEG5nYVlB2llF6oJ6jwMVnyQ3d+KGfvB4W4DH
	GZyHLai4/8DV1JBbnmoHe90LsTRqlQS3Nu8VfpFis3FvhONuKHSAhKid03HvVmcF
	BR7uU3TTQPutgDXECfOEHCyox2dbQiV7g+MKxnrcBmUQcur2B8CxZSmdFWoJJYmG
	TJB4Pk9pQPuqNJlT9bQxqfANLuIW771S6dai19iy1YU+s2AVfvymkJk6qipOrE1y
	b1+ByW4lEXfIKKI6m+ZVxSF5QLjt831FP0iy6aX8qC91V0Td7yh/ILPUkmBNWF3A
	ykGHbA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgh7n6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:33:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845bc2e658aso1424144b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783190003; x=1783794803; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=;
        b=ZnGVXI7bUmme3ZniPS5iAsDcaEdQ1fLYRacSTrAIgSFJivF8ZLjlSu2BmYh/nyusYo
         reR0fTAGDxRcNvIj0lwVupbDNnW/VhesRCNe8ijywzNWn1thCsMOWAYkxHWPPS3/LbQm
         T0JAesxakmOq1te2S9StM8HZY62r8IzNyeRTOZn1TFuMY5ivP46CT6FnKshL2rFsmxDM
         XxioGqTLkdh6te9A8Ffz/5x4lQsggzKBJkUVcj2i4HJZJpGHL+RLzv3U/lZdcLUy1F7P
         S2yYEgYG2VlFZnOnxHRmN6YY+z8dZjwTpz/a17yER54qbzWPUqUccwdA7ko6z+/2TaLP
         9YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783190003; x=1783794803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9o/IQZq06TE0+/STQz+x6iRc27qZ5OMF6+HG6X3OyU=;
        b=UJAAOBfuM9rsrUZAEhbijIdaDLiF73J6qlVJNv+NUHVWP6Im54fwBhMtmjGIrOMEd+
         tEE2ixHEL/6IRCYrN7UtUx8VMuHVG+/956cRQXrRnpEju7eCQf5KSQJJAN0AxAtuDaRC
         ipstm+aWk/JOW5b9/i97j9GSEwEwhpkvVpoTn/OGN3CBpIy1RLxOQcxePF+hQIpioeyg
         2cH5HnTGhL2lRf3argS4urE8GqVNJDVQGKThWGnMbqQsa+fRvz0xw19/6cEOmpSG1up1
         +bEXOEdyXkT5QBD9KWpUvFl6Pdc8Kfy8eE+C1biDszumIrXlXmBVELdl9MofNd/iAbYA
         v2/g==
X-Forwarded-Encrypted: i=1; AHgh+Ro99pAyOXrDJQNhMG9jaAVxLDT7CB0GajWPD5oKMkwLFa7ZYlZXy6YzLWC6paW6P5uu/BE8EfFkRRV1kuY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxd/qTZygILWtwoaSWGLqDdv0JfEkq//DV2moTAPiKrz77F+Uq/
	47DoBdiToNW42YO2/nl2UtlYzL7FzeCbiyldBjcpxoljPDMtdBzni3BhhjQe6+hWkfnNkHaimOM
	DC3l+uiWyYZLYf8Yvv6UscTz586udX3tmQ2JMPpfmb3SF/OqgeP8HfZViI+BZe8SDG/GC
X-Gm-Gg: AfdE7clClTYN7MJEt3pFQPli/crRuVqMZgt+/v+zVM03qLa6hKbVPmb2JF2HL0FaP9/
	xB2I7i1f5eY2G+dniPWzGMQEEU5t5LbylQSw0aNyrWPWdiof3pHUZW7a5LRxoxUewl1jRF7/V5+
	S0T6gWR1n6iJkExBeR+xTx5PfSH5txtYWMTqyUl/RZ7vXpKpaO2xjxgAk+dYNkByI+3i2cC3g/9
	ueZjxAqJFYDEuXRNh/fr2VMpm5JsHCuA3HLs3JbR6UcGYfcmPxhi71tHuV0Kb7j5iO8Ct66Tocu
	kKZPmCUST5eHuoRkySo587M55AmvPs+JMpj9zpPBy4RCeVgfF6OplyDi7dt7MteN1qtbRYve8K+
	6979m0FaksmvtLbk/9URv7HA=
X-Received: by 2002:a05:6a00:1399:b0:847:9518:a6fe with SMTP id d2e1a72fcca58-847f6dd54b8mr3903008b3a.26.1783190003091;
        Sat, 04 Jul 2026 11:33:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:1399:b0:847:9518:a6fe with SMTP id d2e1a72fcca58-847f6dd54b8mr3902984b3a.26.1783190002572;
        Sat, 04 Jul 2026 11:33:22 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:33:22 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 02:31:16 +0800
Subject: [PATCH 7/9] drm/repaper: replace struct drm_simple_display_pipe
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
Message-Id: <20260705-drm-simple-kms-removal-v1-7-b4e1ca053623@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=7683;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=X0UwoE9ZxeInLb/TsbQTXm8HFa5R2/0dvM/cIQQ4UA0=;
 b=3r4r5kIqIqgZijf/Kqr49p7Qlhtwg622PqfbalukoH6sC56FcuoGH9O2XainORoxzzo+57CBd
 48iBMIor2dOCYnCxiNIqiB3V0iSu79Fbb/lbiQqldwHfi0N4kpAgnXv
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX1RYMab1/ye/u
 8Qtsmed61H5qTo854u4iI26y3Dp4grbA6DMK1s2LX0pTNSK6JEhzVa25L4ukHY+44TKO3jJaio5
 7r+aWe/N/uXjbQKUat9lBjvPKgAG0ts=
X-Proofpoint-ORIG-GUID: btnxgS-Lq7UecYwh204JZwaSuXXq5u-G
X-Proofpoint-GUID: btnxgS-Lq7UecYwh204JZwaSuXXq5u-G
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4951f3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rSXZLFMjQQqjKu18WoMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX7huMyUyPZ0O9
 fDvIn8RhW/Ph6B47fpn7Bdd1G5+5bZmtkkTcMPJZTiNtDFZcTx2/HOt3zNmKxqsyZo4ipZK/FlH
 rDZnjMcGOF5geHEQFtS9GPpc3nYeDCEJR6rWrpHaUw55bzyq35hjZ7emwQ6qD5XJ7JccVWn7M4x
 Bv5QZfcq3G/kKImbPxM1VHQs3rjh+AK0V6f6l9vwo8PNrfv+e9mivkA7Mo3S77A9vpjA0yGImei
 m5tmvXF3Ppqsif3khmWI2oXF9+3tgVzqe1bgHjl6i2RWWnkgq94S5GK++J4RtXf+q1faPdtrQ5u
 17JXw70FpbSusDP/5aTh49DGv07Y78ufVr5LJYnvy1JFLnqiO3CoNmhvjb/7OqJUpcP6UISJ1E/
 pV0EIDzKZgpdi8j6oI1P7yDZ7F/FrTpzpdLGYbHvTzhkzf4Eg4gn0/lnXtrTYJ0I20DepaZIdgL
 dCWUdo5lFZNkDw4qaEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

Convert repaper to explicit primary plane, CRTC and encoder objects.

Keep shadow-plane helpers, framebuffer access handling and no-scaling
plane-state validation from simple-KMS path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/repaper.c | 130 +++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..23be9c762803 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -22,6 +22,7 @@
 #include <linux/thermal.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_damage_helper.h>
@@ -38,7 +39,6 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #define REPAPER_RID_G2_COG_ID	0x12
 
@@ -65,7 +65,9 @@ enum repaper_epd_border_byte {
 
 struct repaper_epd {
 	struct drm_device drm;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	const struct drm_display_mode *mode;
 	struct drm_connector connector;
 	struct spi_device *spi;
@@ -622,26 +624,24 @@ static void power_off(struct repaper_epd *epd)
 	gpiod_set_value_cansleep(epd->discharge, 0);
 }
 
-static enum drm_mode_status repaper_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
-						    const struct drm_display_mode *mode)
+static enum drm_mode_status repaper_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							   const struct drm_display_mode *mode)
 {
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 
 	return drm_crtc_helper_mode_valid_fixed(crtc, mode, epd->mode);
 }
 
-static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *crtc_state,
-				struct drm_plane_state *plane_state)
+static void repaper_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
 {
-	struct repaper_epd *epd = drm_to_epd(pipe->crtc.dev);
+	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 	struct spi_device *spi = epd->spi;
 	struct device *dev = &spi->dev;
 	bool dc_ok = false;
 	int i, ret, idx;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(crtc->dev, &idx))
 		return;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -771,9 +771,10 @@ static void repaper_pipe_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void repaper_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
-	struct repaper_epd *epd = drm_to_epd(pipe->crtc.dev);
+	struct repaper_epd *epd = drm_to_epd(crtc->dev);
 	struct spi_device *spi = epd->spi;
 	unsigned int line;
 
@@ -827,14 +828,15 @@ static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
 	power_off(epd);
 }
 
-static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_state)
+static void repaper_plane_helper_atomic_update(struct drm_plane *plane,
+					       struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *state = plane->state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
-	if (!pipe->crtc.state->active)
+	if (!state->crtc || !state->crtc->state->active)
 		return;
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
@@ -842,12 +844,72 @@ static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
 				 &shadow_plane_state->fmtcnv_state);
 }
 
-static const struct drm_simple_display_pipe_funcs repaper_pipe_funcs = {
-	.mode_valid = repaper_pipe_mode_valid,
-	.enable = repaper_pipe_enable,
-	.disable = repaper_pipe_disable,
-	.update = repaper_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_funcs repaper_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int repaper_plane_helper_atomic_check(struct drm_plane *plane,
+					     struct drm_atomic_commit *state)
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
+static const struct drm_plane_helper_funcs repaper_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= repaper_plane_helper_atomic_check,
+	.atomic_update	= repaper_plane_helper_atomic_update,
+};
+
+static int repaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *state)
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
+static const struct drm_crtc_helper_funcs repaper_crtc_helper_funcs = {
+	.mode_valid	= repaper_crtc_helper_mode_valid,
+	.atomic_check	= repaper_crtc_helper_atomic_check,
+	.atomic_enable	= repaper_crtc_helper_atomic_enable,
+	.atomic_disable	= repaper_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs repaper_crtc_funcs = {
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs repaper_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static int repaper_connector_get_modes(struct drm_connector *connector)
@@ -1102,9 +1164,27 @@ static int repaper_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(drm, &epd->pipe, &repaper_pipe_funcs,
-					   repaper_formats, ARRAY_SIZE(repaper_formats),
-					   NULL, &epd->connector);
+	ret = drm_universal_plane_init(drm, &epd->plane, 0,
+				       &repaper_plane_funcs,
+				       repaper_formats, ARRAY_SIZE(repaper_formats),
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&epd->plane, &repaper_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &epd->crtc, &epd->plane, NULL,
+					&repaper_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&epd->crtc, &repaper_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &epd->encoder, &repaper_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	epd->encoder.possible_crtcs = drm_crtc_mask(&epd->crtc);
+
+	ret = drm_connector_attach_encoder(&epd->connector, &epd->encoder);
 	if (ret)
 		return ret;
 

-- 
2.55.0


