Return-Path: <linux-aspeed+bounces-4503-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7384DC44525
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DPD19ZSz3c7d;
	Sat, 18 Jul 2026 14:31:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784192579;
	cv=none; b=Y5BwlpzOcIxsoT39Jh/yFz+aa/p687XVwhEB6neKmpQYfU9ez3iHXgDb/pwJ+DnfI8+v+15c4Y/qtA29jtO3mDwedaGyQ4BGy0OrN8pvC0NBpPquMdZrDVvd4H0LV3gGUL7wKm0IHdwx/z0mwjRqI+IsaBe9b5cWQhdF7PDE2vC0SXu07d/bbkMs/OVb5I5DnfuaykGT/hOPrCXPzAX4WfsUOKlnEXSC89YhFRUZPenY0mSgzFiXg79oUyBi8QyTTLKNJpuqCmG8VgTmiii79K/I/PbPelYewa0Ihxz9rfGqP7zBuz8ECFaQJsNGpqksP5BUEittbt2UTcWVXjQ3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784192579; c=relaxed/relaxed;
	bh=K0bpK7inA55ypw9IyK4ZYF+yJtIn8h5ntrPY4x3zw2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iacvM3+W02Xixx9qtS6ka0yV8NShPD8Rdfv9T3DV7qNamzogkPeUmOL2XMj1ArIcPKKvhs1n8RzFVBqL7lb1b6FxUTVldaHyKUp/ID7e3yR6fiGXWt84/eBc60vi8zpuJjMmLTMP6SpAlOeXdn4FYkCOg5SMYiCCan3UvZJXCyuaLhELMg8Z2oaWTSkbRYJpfrqRklpGx97FWJebNr2k4iW13X/Pn/v29R6mgwZLYoVQie5IraHsrvBXyf3nbkKPfZ7kmYdFXAiBQMqmv3xDueGbZSSJgvckb5eBDXf3L7t8WvcbeSMKNPZpvhAxNkkyvDc/Kh2aupKLbalVCIwogg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jtsMH/Ci; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vvtnh5dT; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jtsMH/Ci;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vvtnh5dT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h16Wl0JtTz2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 19:02:58 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DtYv2049000
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K0bpK7inA55ypw9IyK4ZYF+yJtIn8h5ntrPY4x3zw2I=; b=jtsMH/CiIg+IYyIM
	UoWG17o1MwtLWopLoZO3sy24Al2Z9sOFbaENN4AOVJF4xU+bpPR+d9C9787h4TwO
	tSi9Ly3o/bxKWOdhB2fUU2i6GLhIiOeLqh+axAMMQ1eq/rr8R37KUew+2z2OQOHC
	nepZjqnosLkUboNLZlbyuXUjJEuUwJmPnkH2LVpO1iG4PXZJbOh8GFxD2BcKMFn7
	41Czs3gRW49t6RwW8MVnxwacodggU7naT8AG19dTfVi+b1JqsixtDBt1+u2reMB+
	XBxXv62GBdx6j/TuWz2kjm07GxtIOsh5Py6VZY4wdDPyPKa0u7dUY310ccoTFnlq
	1cRjdA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfm445-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:02:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c7f385887bso154816195ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784192575; x=1784797375; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0bpK7inA55ypw9IyK4ZYF+yJtIn8h5ntrPY4x3zw2I=;
        b=Vvtnh5dTc/GoQhp0I6thoKVBmAw8Lwei+bJuKCCkI5Dh8cCOyigDtdQqXTchUbu6xF
         SKPlD8kc6S+PISS2Cqnc0T/I0SGaz/CN8OinU92NcuEQG10CxU+uxk5BD1rfJd6+gvFs
         PsUF0VssrfYYnUjk5qM0av+B22T16FV8sGwijMdPEmORPJe6AdP6HNTflJqKlrX/3gch
         LENj2CNM3EJjHNzYTUSXW7JRb36393mtgj0/PR5nl2sC9Yd9uHB5K2BajdcZfIhacRcn
         qs+t+6fIDrebvB4cyprSpmzu2Ncm57ryjocpj5o/3ic4rHOgUdqxDzp2av0pPdgCuecr
         YxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192575; x=1784797375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0bpK7inA55ypw9IyK4ZYF+yJtIn8h5ntrPY4x3zw2I=;
        b=YzwQqB2eUcPK5bvY3KmIx3/V1wDeWeEZZHlFtUA11tZauVypYtveP51eampKFajKRp
         VARvYQ8v7dVSMiiOmu+2zIPqxQ9Rrp+UfJGlh2DhGBvQQaQ310jI6HPN6Ce9S28djXBz
         5UbvdNRpuhTsM8Imr1lqlQMbcsIJVEkEi7kWGQNbnNNfFoBFItOAgz6cWOZo6utHXzba
         nG6fulgIbr0vSYk09bsaUkN+uheoQByk91h7Je7N7b0ylBwrpAqTcQyGu/F6N096ljqy
         UNdtUEOrbuFSDcMf7PkCP2QyDnZox6A+vXjpFiiN3SgT4TEYcbkfYIVVpEyU7T7Op9Xq
         I7Uw==
X-Forwarded-Encrypted: i=1; AHgh+RrRA6bD8zKELi0N7dZmbrniWvbkbl4tmRu0opRKOKCJoCnvlFpW3XTDmyJyA4CyO136nvOeqG4pLb1islQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxiA4QhCJnlrckc6GipcCH3aqH6VzFnzMSZepd7M1jk78mfz/NT
	mVqrt9RmUXN1mt6pCj7k/tuKzStGCwYWFT4DfmjbWIbfE9cIdprmFlDZUqUgSeB/akahWrwYnph
	Kv75YDv3Cj2ySrc6Srnhh7s8sgsMWGrLzpFI4WpZUTRhc28+iBwXRM5UZsjhDlVZHaBMC
X-Gm-Gg: AfdE7cn6O89c4XHw0hfHrGG4w2Eko5FAoIBuEGM8OIeCzhu/N5Esdsw/wiw7KFU+bNC
	Rq611K+eOuSKwakv0d3l+nrl6PzjJo3W38OCTgWj+gLTk7MitrIb645PgsAtCZwzFs+7Ycb80Jo
	K+ae04tQRAewNGJzLdcj7Kq1MRlafmbEKFuWlG5PuVXYnUx+HP40FMFT1cJYvqTH1duQgBhtxhi
	lvXSKMUg1UHtbm5leSavAXpyF7/XIqGg6VFAuS8D2M94i7leV0z9rPSxTOVsnpA6kga9uRYVF5/
	bD6CNiKx3qW7vqvkZkbX1XT06fZYo79pzKAdRrSvuD4oP/qAFHa2Hz4UJ1c3Ob8+cEtbzniHhT8
	bB8noPyfYBmUGUR3CSrM5
X-Received: by 2002:a17:902:e787:b0:2cc:7c36:2c23 with SMTP id d9443c01a7336-2cf03d6be8amr56675165ad.43.1784192575389;
        Thu, 16 Jul 2026 02:02:55 -0700 (PDT)
X-Received: by 2002:a17:902:e787:b0:2cc:7c36:2c23 with SMTP id d9443c01a7336-2cf03d6be8amr56674695ad.43.1784192574779;
        Thu, 16 Jul 2026 02:02:54 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:02:54 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:01:53 +0800
Subject: [PATCH v2 1/8] drm/arcpgu: replace struct drm_simple_display_pipe
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
Message-Id: <20260716-drm-simple-kms-removal-v2-1-1133a8fc3785@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192559; l=11611;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=mhZuZpvxlw2add5yFJofNe/qRYemwKr9KZXWIRbaR4U=;
 b=bKGcIBRbY3DWlMj5Cf4cPqNMuGZMGDU6qKuQzX/N11LATYpXjJUNET/zATFlfhoW3+9trVitB
 aYnklaVV/K+BCQCTcDi+FqGjUSBjW456AT7fVFNvbJXR15fJ9ZpoOgM
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-GUID: qE85ClqwSI454p9HnGMay5zLVRcYE8kO
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a589e40 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dobV-df0kVLvunOko3gA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX+tLjTkM6pPn2
 kiwpikYIlNeE7t3o8UtItA9pDT0akydSi1QcpIIfi1o1nmNaUXQYhuan0EJzU/YhmaiUsV62RX2
 Agd7VwG9CgPx98nS7iPwHr1C9s4WsNLafNUyMtEEImpfLjPYB6PaMcTichWwIc+lcf+F9FxIsLl
 45OgeS4gPDElhODbTc5rDeuxl4oo4qMsF4PEAu3eVpYCsS8kHuDsfkgzyvTP/ub27PaRacp7I4L
 HCYAKXdeBCOn2C1aNlmGBeoaZD1nJUcpS5fMv/cqmYLueGOG6i0uQ0KIolMtBX7Kusod2R5ag+p
 sbrsiyLU197v1rMSNquuSI4UEp1j1L/BBCLOHWI5JGGn6hQ9nPRgS7AEKib58zK5DecEkkUq9cq
 Sit4qKzud7Z7t0J6Yr7WPkwW9tf54agee/FQ+0dxpw9wsPVsmG4Jcv09QPNYR00/NpTpvQ37NCB
 D5DXtApSJ7ad9pHAipg==
X-Proofpoint-ORIG-GUID: qE85ClqwSI454p9HnGMay5zLVRcYE8kO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX2+k2xHdv2hdc
 dU1wOnyPyifehe77BhxSNqrkT5nFo2IejSqzFjNZ6ubfJn82Qh3b/U9WyrqTwgDFCvmcOr/NcXf
 aaLPmrRlBaIa5e55oKaEZltn5oM7D8c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091

Instantiate plane, CRTC and encoder directly and wire them up with
standard atomic helpers.

This removes arcpgu's dependency on deprecated simple-KMS display pipe
interface.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 179 +++++++++++++++++++++++++++++++-----------
 1 file changed, 133 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..e0cce4798f3e 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_device.h>
@@ -17,12 +18,13 @@
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
+#include <drm/drm_plane.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of_reserved_mem.h>
@@ -52,13 +54,16 @@ struct arcpgu_drm_private {
 	struct drm_device	drm;
 	void __iomem		*regs;
 	struct clk		*clk;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane	plane;
+	struct drm_crtc		crtc;
+	struct drm_encoder	encoder;
 	struct drm_connector	sim_conn;
 };
 
-#define dev_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, drm)
-
-#define pipe_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_private, pipe)
+static inline struct arcpgu_drm_private *dev_to_arcpgu(struct drm_device *drm)
+{
+	return container_of(drm, struct arcpgu_drm_private, drm);
+}
 
 static inline void arc_pgu_write(struct arcpgu_drm_private *arcpgu,
 				 unsigned int reg, u32 value)
@@ -117,7 +122,7 @@ static const u32 arc_pgu_supported_formats[] = {
 
 static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
 {
-	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
+	const struct drm_framebuffer *fb = arcpgu->plane.state->fb;
 	uint32_t pixel_format = fb->format->format;
 	u32 format = DRM_FORMAT_INVALID;
 	int i;
@@ -139,10 +144,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
 }
 
-static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *pipe,
-					       const struct drm_display_mode *mode)
+static enum drm_mode_status arcpgu_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							  const struct drm_display_mode *mode)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
 	long rate, clk_rate = mode->clock * 1000;
 	long diff = clk_rate / 200; /* +-0.5% allowed by HDMI spec */
 
@@ -155,7 +160,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
 
 static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
 {
-	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
+	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
 	u32 val;
 
 	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
@@ -194,11 +199,10 @@ static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
 	clk_set_rate(arcpgu->clk, m->crtc_clock * 1000);
 }
 
-static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
-			   struct drm_crtc_state *crtc_state,
-			   struct drm_plane_state *plane_state)
+static void arcpgu_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *commit)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
 
 	arc_pgu_mode_set(arcpgu);
 
@@ -208,9 +212,10 @@ static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
 		      ARCPGU_CTRL_ENABLE_MASK);
 }
 
-static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
+static void arcpgu_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_commit *commit)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
 
 	clk_disable_unprepare(arcpgu->clk);
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
@@ -218,35 +223,95 @@ static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
 			      ~ARCPGU_CTRL_ENABLE_MASK);
 }
 
-static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
-			   struct drm_plane_state *state)
+static void arcpgu_plane_helper_atomic_update(struct drm_plane *plane,
+					      struct drm_atomic_commit *commit)
 {
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
 	struct arcpgu_drm_private *arcpgu;
 	struct drm_gem_dma_object *gem;
 
-	if (!pipe->plane.state->fb)
+	if (!pstate->fb)
 		return;
 
-	arcpgu = pipe_to_arcpgu_priv(pipe);
-	gem = drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
+	arcpgu = dev_to_arcpgu(plane->dev);
+	gem = drm_fb_dma_get_gem_obj(pstate->fb, 0);
 	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
 }
 
-static const struct drm_simple_display_pipe_funcs arc_pgu_pipe_funcs = {
-	.update = arc_pgu_update,
-	.mode_valid = arc_pgu_mode_valid,
-	.enable	= arc_pgu_enable,
-	.disable = arc_pgu_disable,
-};
-
 static const struct drm_mode_config_funcs arcpgu_drm_modecfg_funcs = {
-	.fb_create  = drm_gem_fb_create,
+	.fb_create = drm_gem_fb_create,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
 
+static int arcpgu_plane_helper_atomic_check(struct drm_plane *plane,
+					    struct drm_atomic_commit *commit)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static const struct drm_plane_helper_funcs arcpgu_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= arcpgu_plane_helper_atomic_check,
+	.atomic_update	= arcpgu_plane_helper_atomic_update,
+};
+
+static const struct drm_plane_funcs arcpgu_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static int arcpgu_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					   struct drm_atomic_commit *commit)
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
+static const struct drm_crtc_helper_funcs arcpgu_crtc_helper_funcs = {
+	.mode_valid	= arcpgu_crtc_helper_mode_valid,
+	.atomic_check	= arcpgu_crtc_helper_atomic_check,
+	.atomic_enable	= arcpgu_crtc_helper_atomic_enable,
+	.atomic_disable	= arcpgu_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs arcpgu_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs arcpgu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 {
 	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
@@ -254,6 +319,9 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	struct device_node *endpoint_node = NULL;
 	struct drm_connector *connector = NULL;
 	struct drm_device *drm = &arcpgu->drm;
+	struct drm_plane *plane;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
 	int ret;
 
 	arcpgu->clk = devm_clk_get(drm->dev, "pxlclk");
@@ -285,6 +353,30 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	if (dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32)))
 		return -ENODEV;
 
+	plane = &arcpgu->plane;
+	ret = drm_universal_plane_init(drm, plane, 0,
+				       &arcpgu_plane_funcs,
+				       arc_pgu_supported_formats,
+				       ARRAY_SIZE(arc_pgu_supported_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &arcpgu_plane_helper_funcs);
+
+	crtc = &arcpgu->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
+					&arcpgu_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &arcpgu_crtc_helper_funcs);
+
+	encoder = &arcpgu->encoder;
+	ret = drm_encoder_init(drm, encoder, &arcpgu_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
 	/*
 	 * There is only one output port inside each device. It is linked with
 	 * encoder endpoint.
@@ -293,29 +385,24 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	if (endpoint_node) {
 		encoder_node = of_graph_get_remote_port_parent(endpoint_node);
 		of_node_put(endpoint_node);
-	} else {
-		connector = &arcpgu->sim_conn;
-		dev_info(drm->dev, "no encoder found. Assumed virtual LCD on simulation platform\n");
-		ret = arcpgu_drm_sim_init(drm, connector);
-		if (ret < 0)
-			return ret;
-	}
 
-	ret = drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe_funcs,
-					   arc_pgu_supported_formats,
-					   ARRAY_SIZE(arc_pgu_supported_formats),
-					   NULL, connector);
-	if (ret)
-		return ret;
-
-	if (encoder_node) {
 		/* Locate drm bridge from the hdmi encoder DT node */
 		struct drm_bridge *bridge __free(drm_bridge_put) =
 			of_drm_find_and_get_bridge(encoder_node);
 		if (!bridge)
 			return -EPROBE_DEFER;
 
-		ret = drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
+		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
+		if (ret)
+			return ret;
+	} else {
+		connector = &arcpgu->sim_conn;
+		dev_info(drm->dev, "no encoder found. Assumed virtual LCD on simulation platform\n");
+		ret = arcpgu_drm_sim_init(drm, connector);
+		if (ret < 0)
+			return ret;
+
+		ret = drm_connector_attach_encoder(connector, encoder);
 		if (ret)
 			return ret;
 	}
@@ -342,7 +429,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_device *drm = node->minor->dev;
 	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
 	unsigned long clkrate = clk_get_rate(arcpgu->clk);
-	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
+	unsigned long mode_clock = arcpgu->crtc.state->mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);

-- 
2.43.0


