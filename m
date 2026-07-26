Return-Path: <linux-aspeed+bounces-4558-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15880C53219
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6Q3Hrwz2ydn;
	Mon, 27 Jul 2026 10:07:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095189;
	cv=none; b=hXLFWfSFGZ7D0iSLCdJgIhJuexoEpNluAlLg36xClc2hB0VnVIldlM+3p8Q+U8X9mueUEFDjWS44IGK1dxeiX781Xjsmf0iciwOdeRsvADR1OpSbqVO3lWteOcTwjo0uaRDKAzgPQXilFFhBeAw+A6tSf7yeahSdVx5lseg6qQEAtwrPVk1HKZL2Pbk1vRm5dWBnnHLpGfKD5fFfj2JsmPoj1pXn7g7pfR2QJbtn/lHr1OgMG4DIGrQsLPu+NWi+4ONPjvCw+1AKxdfCUzruSdhm18YZod/5W4UfYmYxdXIp/eFOHTiXBRv5fQl+HnmzZEQZNqtqYwLt8NNZwsnzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095189; c=relaxed/relaxed;
	bh=qYw7YOevf7R1VaLGJE434uj9XUAJ+efhiT66MYE6HgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VA102WkotS/GaROBXXwAvx8QEwUqwL0q9Qkh59ONNMUf1fBJNu10wB+OBAYFyAuYUQPPEZ+VPz3jHNuhtquNsw4+I7bzBuBerw4BHW7tfjgy7fKCs9hipna0hKeZczrITd/42aOrmCeqjddt7Sn0QqBHk/Ssm/XnDa5YE2wKUN6f8WG3bTkTI5xT4NORqM3IEH6X2ROeT0LyNacoTA6YQgp7aZHOqlxTtMqjUBCRCiW1aDelFL2U5xeJiynKPQW+FNp6iYFxqJAS/hqQAWB6BkeXw82tzH8BGS5Is6J0AKD7GCu8L+yPHWa3gfJ4w992t33K2E8UtKm7069aFeNeJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFD2x2i6; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i5Dbo972; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFD2x2i6;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i5Dbo972;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XKc5lsKz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:46:28 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH7eYP1212451
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qYw7YOevf7R1VaLGJE434uj9XUAJ+efhiT66MYE6HgA=; b=JFD2x2i6i050fq5c
	bDN7bgFtTZ7Sfm5SqUnqFm5eluW8Vk6cS3DMjgDr6v9VexxI+t0aU4tSBtrcAvT7
	I/lyXA43IaigZbmeOXdLWxxGDY9+DlgVAjoGjG+ObeQ71Y69u+RPqFXcUWZACs5d
	c28BQkTmfH5Y82NI96ySJY/gycW7qY2IkWbtJyvXyYN2+cYzvFFY4Ctmw+cn4o5h
	0vPoCRRSR9dkSFYNJLGTKliq5XHgo9Z6fNUAVxOzNPxuIHtTJAoSNL7353yWnify
	EzhMbvNba5KKY0r7lV7Ta4kUeMp5Fw3+4oUSiBQY9VPmf6gsV9dVj7v/URc5Zoe1
	UVJbkA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmfguqbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:46:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-380b630c505so2524824a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095185; x=1785699985; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYw7YOevf7R1VaLGJE434uj9XUAJ+efhiT66MYE6HgA=;
        b=i5Dbo972IHaBOvReid2hPaKxAzSZmuGSq1JTjk0TqxOTTd1GHk0LDmEmaVOGrrLKr8
         qAyiVypM8LXlzwZ++OhmqN/aezmSV4D1g8CvNs4CwJa5ypJQVZ/AGz+UuWsRAEVmJ75J
         mKDlA7Z8WCeo3Cgz+24hBL8K3s3bss8x3yRrrhKiInAyOpROmfawjYnlbk0Xvj9tW7t+
         EKlZ9LI9LHxw0FnKaqzgyUkNLk6SqTw0ZzJSxG07Bdm1HF2yqqRS2VOSahB/nOWqh6OM
         XHYulA+T1E4jcclTUvaiJkbnup4ve9/F42zCGBxa75lLYDLr+ys5Cj1wiZnKsfl3Fg1Q
         mBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095185; x=1785699985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYw7YOevf7R1VaLGJE434uj9XUAJ+efhiT66MYE6HgA=;
        b=d4XZ9F4J+HGHZB84gKq16l1YgVUDDT/q8IwGgWe4AlhYEcVbQuna9hjd/2CSpuYZ39
         wbvqJAesH03anTB544yLNd8ko0jTOcvP2XmD57L4fGOCtcdcn2ZtSf+0WHnzFFY8Mmxx
         uTPTGbL7LAoBCAnElFPEgcSsL/DKjJwCmZHzb3fczy/yXOWZ6PBF9UWhIlahC7QqU2yP
         si5t8NtgIReKk8QY5OFehI+g1JnMsw16mLnfAk7+c4rlVrV2A357AnKeJUgwXbXwFwUm
         WAjfnOqdFIzIU7jEnzAJbLxLmSLdkJAYHruqyC3PKMBgExYO1FEpMIwJvATFPb7BQF98
         OsvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjWi/13Y17TLPI4RoFmF7uhD1A2UXrNZw1kLLNzX6RvDbAfDide5XkA5AtxtxyoVuTInLCx0ZSqhKFA0Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9KLj49c/DlZwTJ6YjuH3W5bE0cb1iuNoCYhwtX/N0QkCOBc8C
	e2GdIgYcgU7j8Z21bWBxjWDasqUUKmm2tLOAqnUDKdGE3TN5+FXFBXXW401vZIqdwPJM+nAszrv
	xPgjk8RefZL03z5lKh33m+opbmX64vqkhwQEwvfr2VBFZb2KEU+qjIfw9boCST1aOvgWZ
X-Gm-Gg: AR+sD10vwrqKDMCKIVqbAg+OtCX0VFcJNWGvsjOO/pijwU+r+77sqrc/JjhqmN4hgNN
	Cqt5o2eEUXHWrt/He8+Vv/4tJLFu96GnP80gn1W4qHIppB9bbhK+4GrgqHxfJS+ww9/SumSWFzx
	pyyn3I2lU4DIEyD2lvteVxhDC5u6asZ/2hIlQUXNcAoXrbf3xysn+l1F+1mtZhJPR9kdQ/vbPaz
	Pfj8K7A8CLnldllE2cOhdRR1PxKIn7O20mDRxBkAyFHwZKpziRlkNjpucBbItwhzvod8ra7pVef
	EvBmq6cJKf6FOrmqYppj+M+WIWqkKhpL9h3QHO54Km45NJ7DYeYmbcOql99ib2ZKSBE2+3y8cji
	Ye+HvAmKnN+iRGpInz2wU
X-Received: by 2002:a17:90b:2642:b0:38f:1e1a:5141 with SMTP id 98e67ed59e1d1-38f29620a7emr6222281a91.28.1785095184897;
        Sun, 26 Jul 2026 12:46:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2642:b0:38f:1e1a:5141 with SMTP id 98e67ed59e1d1-38f29620a7emr6222251a91.28.1785095184441;
        Sun, 26 Jul 2026 12:46:24 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm4105998a91.8.2026.07.26.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:46:23 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 03:45:19 +0800
Subject: [PATCH v3 6/8] drm/repaper: replace struct drm_simple_display_pipe
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
Message-Id: <20260727-drm-simple-kms-removal-v3-6-cd5dc89858c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095129; l=8123;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=AAx34gAM0g1XJvks56BpyKPpL86hNGfHkaqmTZ6w6/0=;
 b=0wLxQLCaGBQoh2NRb3mNAmGNnyaRnCPadbrAOaKKC67gUQV3goDlvM9OKxsAyvDatXtean6lJ
 GxRtATgRjlEC7duzu8UWemNPnKENa4bCZTwGGNjQcIYvTf3lN+2t4jy
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-GUID: CbsqZz3KF1yfeJ-J987RS33ozUSedVea
X-Proofpoint-ORIG-GUID: CbsqZz3KF1yfeJ-J987RS33ozUSedVea
X-Authority-Analysis: v=2.4 cv=GdYnWwXL c=1 sm=1 tr=0 ts=6a666412 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pkK3EMrqy3vWcbFnmDwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMSBTYWx0ZWRfX4hmj2PNl4gK2
 n9kurdqfzBQ48rNw6JyMYIyPDDcpPA8OpjqqUSDLt74413mHkFPOJNsCPxHspzFFWz4iP1MPpXj
 1nLtNjsj+7Kw5OOurxIQXwygOkZ9iJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMSBTYWx0ZWRfXyjs4GYfna3hh
 rHrhBCsux7bGs5mVlqFjBSHo5a19njn7tGcbQO7LHhxZu3qWtrtLDpUyxAQKKza/1X0uGL0qgCs
 ZbiGg1+8hhIGqPyZGpfrK+9ZvNK0tMZsUxFU9PtMiVGEpqcSrSycCQgLXuAOqwlN0n4lWnTagCa
 UQwOtHov+W6ZsMYKgcnM8yTMQeBlTwTv1X0lsTV/K3muKzZXtJjFfyG3ekvf2zmrzCua04S2DNa
 nRh6oIvL/HCq88U5Kgg+0YrXLlnUb8DOKahR0RxHqeRuQS4InHoPd7MDBqr3ZNoTlpMt3MydU57
 qjwvgs6bRS+CDhRVCit967gJPQuDMRFhBGiT1VeytwCTpjEE3U+bxlqAi0uNs2UbyOPkNvptScD
 euyEF1v0lY24F5Y6kLI+K1QJ3YNySwAh1szeo7U+sPBKADjwn+TyYPJzTVR6SltG6CHVKBFdPc9
 xHd6bc2qPivMKIzhnSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260201

Convert repaper to explicit primary plane, CRTC and encoder objects.

Keep the shadow-plane helpers, framebuffer access handling and
no-scaling plane-state validation from the simple-KMS path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>

---
Changes in v3:
- Skip damage updates unless the CRTC state exists and is active.
---
 drivers/gpu/drm/tiny/repaper.c | 138 ++++++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..f225e38fd404 100644
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
 
@@ -827,27 +828,90 @@ static void repaper_pipe_disable(struct drm_simple_display_pipe *pipe)
 	power_off(epd);
 }
 
-static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
-				struct drm_plane_state *old_state)
+static void repaper_plane_helper_atomic_update(struct drm_plane *plane,
+					       struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
+	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(pstate);
+	struct drm_crtc_state *cstate = NULL;
 	struct drm_rect rect;
 
-	if (!pipe->crtc.state->active)
+	if (pstate->crtc)
+		cstate = drm_atomic_get_new_crtc_state(commit, pstate->crtc);
+
+	if (!cstate || !cstate->active)
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
-		repaper_fb_dirty(state->fb, shadow_plane_state->data,
+	if (drm_atomic_helper_damage_merged(old_pstate, pstate, &rect))
+		repaper_fb_dirty(pstate->fb, shadow_plane_state->data,
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
+					     struct drm_atomic_commit *commit)
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
+static const struct drm_plane_helper_funcs repaper_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= repaper_plane_helper_atomic_check,
+	.atomic_update	= repaper_plane_helper_atomic_update,
+};
+
+static int repaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					    struct drm_atomic_commit *commit)
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
@@ -1102,9 +1166,27 @@ static int repaper_probe(struct spi_device *spi)
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
2.43.0


