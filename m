Return-Path: <linux-aspeed+bounces-4954-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F03C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:29:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0pM2T08z2yrg;
	Thu, 03 Sep 2026 10:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380225;
	cv=none; b=O2iQ1KdWNJHn7i7fWsps4bReY5URkXbFjb1NAPlafZF22HOd5BMNbSEDSasLhQZMjvQjGdkUJ1+jhpZOdapOIdsdVzWSU89RljbqrjJtSBfanleMX7D6smkT3/wH2LMIfG9ApUhmlQupGHHUQraPCqmgL2YcJ8GihyrubtnGe9whmR+daJfgt+zPGgK5uKYrjidwCKmO3bNYknEOwjAXAXDbTIKMPGJPjfu0b+zkw3Me+kSMuZKDdQVNBIiQZbbal3FPzlmaR1LfQBVdgNU/u70td2j7UrM2+yEeU3BB+hHcvNk6ca8Quo8CavqbFpFawlxuX5GIaSPM+Z6Gi1HnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380225; c=relaxed/relaxed;
	bh=AzXtSV/WWtydTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEgYD1edCcCiWpJKzmPi4FhCNqUai+26FLjVblSGY2FhRVBvXOS4/YgPsY4+x3ToTSyL8tfqRgwT18AQVJtghmQ0JnKHaROzs+En+OuX18HxqkRgiwgmajit+SRn0MaQjbFlWGdBbO8qENV9TWP6WBJhzaT/Mlj9+JVv/ylYhjNjUzFJjOr9k0GGAyAolieQR9Q/GycaHMBb1DGvmdbm+dyqOy1FZaQ/UHPxJWSAfQb+dOyAEW7K8RKLIHegOt357SyH7ldEewqERFVG5pvWmp05t49Ji01DwgpRr107Q4+GpN9esPHeh/t4VTSkeJJP6uhXLG99CK+hGVCn0B7XlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CvbVC+q9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BUkYCZYo; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CvbVC+q9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BUkYCZYo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvCN6kM1z2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:04 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HsKqt2732015
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AzXtSV/WWty
	dTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=; b=CvbVC+q9kQRRtFSCnNcyzsAX5tj
	yTWXuwhhl+7w/PCwuugp+uPc+vbrzE7anfZtzqn3uf46kLo72QjQf86fmd1F4AHh
	YZz5UIP4/Sl0EbR391MOBU/DWnz+wNtMd2+J6UiEf06DeZJ9UcSFFesMDBHrLTuo
	nyo+CJtNOEw4++m2/oAxc2OmlDoocqY5bhZkHlq6VkXFFqQrcYA3RFW8MxWkdwy5
	u4Daiw3zhz6A0Wd1VQbtsPS+efAub9dHQaYctpfIgSP8G4jPWB0Umbn3Ul2wHZvW
	Cnp59SwGnFPZwPQ09iNce1ycNwr4B7tBac3ES/O25zXm9HWjJ9tn9m4Zt7w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2t4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so2192389a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380221; x=1788985021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzXtSV/WWtydTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=;
        b=BUkYCZYo4DWTwt/D2nNuBybav5QCtvajw9d0o42d9A6rCWr4sZPHA4HZkSAomqWqej
         rf6DxTZYYd0E37GozHTnbOIDvA53DRZ25CLI2x1SFd/TNOl1kPdI1T4nPO63FOK6WcJI
         iSKPGhwh/hT7DxWbLWqZKq/f1WMLRFnvJQok6S+SFbjDdT3NsZIDWvnd62u9MuR84uua
         MaLDrVXR3pEEYYqQhPNLOBXEeqOjSGKtP6cNo6P8MidU3gZR1w/F3qAtX9okgKhjoUQS
         gGoLA6LpEtup/k8uc4gABp/91tjz8BYamPXe5bpow/279W+DVdPQMJ0H5asvtCchTU/e
         VIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380221; x=1788985021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AzXtSV/WWtydTYO3EmejDkL+S0H/FVtNGv1YBW4SI2s=;
        b=S0drSwyNAn9EdrsfiBvSpItCFalHB0jbFbLbKWCfcZTVseu3EV1dpqfEsY5SZMAXPC
         NOaci5RQve8mTiXjVpfnxYVQK0SLyUZcdcI+Gwiyh5FFkCLygnqwAuo3Cm3cbB2Wh1ut
         0NcMnDJ5/9PYNILv0oheh+wlOJj9JeKn3fAjPuxwn/wFOE0RhfFP2JPGMR9XokTjzjJl
         /KUeMXlxfXsWeHmBX2h+93wt/aNGClpUezg9+FZ+g257EEtQQM75asWZ/+tYo110myfl
         QnVyRAlK4GLkQjxbErQ1rbymI/0tTC8FkHskdOv8wzqGCHhkHZRTG72CaLZRb6a3Sj+C
         1HHA==
X-Forwarded-Encrypted: i=1; AKwUvBwRip6z4gZm4gcrzLMidSlUD5F806wdBufxAwd9yNl8+IeiAV4yrkOD2XyGm2tA98j4DzLEP/ecCTatFWM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nvJei++swqM4XYrfLYFjriVFEVuw7pxNvRSE3R8RlMP0y0TnJ2
	7fAHFjtcpto2oqgz4X2YJJzD+PAjTYtz6PHyG4waMROI0v8IIdQBn+rOaO3fmfhPfG1TQzFmChh
	5czAfvAkpHSE2SIuMcy1SR+A5XOAfQfZ6MwMpMi8a2KV88L3tdpohlVd4hH5yF3ZWyn7U
X-Gm-Gg: AYBFou1n/lW7iO+uJWyWw/XAc0uDB0a+oLVkiXlmqOzYhlCQ4I7cqrR/3RMjt3auq0p
	kYkthoBh5hn0Zl/fmfSDUg8DBGFibduk6+QHU3uC0LQbCQ4SaJ4GY8ermZTAy3DIHvhe0L3CA6p
	fmFdcNZTzxSBKsSC/v2yULBkk4lFMTqh37lqqTufRKKMea1RXssqx5oU8ywrmm3FC1tg35SWCXU
	ufN9Vorvi2d7p+0ow7wrqgcMp//klmCEZ5lsqaWL61y4A1shlg+tdnpr5u+bpYYuklhpC7geEwX
	XCvn7NdcXGVHLvXfsfXXtYWLGUhFPlURI2klK2lZ+19Z8RFPty0HNZzWiJX5UcSi7mcJO+6y9Yb
	EBpMy+0XgPx01N0Jsks+Be/APH0k=
X-Received: by 2002:a17:90b:3907:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-39aee066e04mr8860750a91.14.1788380220862;
        Wed, 02 Sep 2026 13:17:00 -0700 (PDT)
X-Received: by 2002:a17:90b:3907:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-39aee066e04mr8860691a91.14.1788380220414;
        Wed, 02 Sep 2026 13:17:00 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:16:59 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 1/11] drm: logicvc: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:30 +0530
Message-ID: <20260902201640.2024648-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a98843e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ReI0EElcLHst8dYcsfAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: PZC1pRiP4h6_AXX6efdXA_IpQz0N4vnN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX4J6XbtMWXXHt
 /Pu1vdFnnanngIffrac4OcbxCYd+Vh7IHcI6fli6SaeLLOZZETBoEuBt7TW0qJl9tgtXZ3DV16P
 7eHyNvNKTobcnVY/0XR9ih+6+JdozXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX6NfNrUacZA3k
 AoOfb97SHT4BtyqCGfkY+bkgxzOFfiAc3s8HupmRJ2JafcvPl1rdjozbxKh5gSelRh1vh4L3PBd
 1ERUqYIiF9RpMspJX1slreNkcN7dO+4ySR0jOehHEKq2fd0vsucUON7149py6c6V2tfFspVY3xi
 mk86TpJA/AMdrt028EiB/19Chlij3x5TmXVF49hZGJeIfBqCGg3FafvOpD7nlOP5bA8T9x46VDh
 4V4sKq701+QXFugLaB7AkvESr3XTOzh7BSxk+ywpcP8GPAILkF6329d43YpDTTBUPjumc+Tqbi4
 gtT232NZ50oLPGw3SaOl9urxusc8+n20YoTfCnXz+POPFw++GF0WfodTBKneWbm+ZzwDQWp24VK
 vael7unLkV+gQOFPgYmbXIUFa5HBBsJbBr9hwWVU8kKv50ILZRnpVVGVbXS2OtnV9pjS9JhOJvZ
 nfRw4eWfisapd0swJaA==
X-Proofpoint-ORIG-GUID: PZC1pRiP4h6_AXX6efdXA_IpQz0N4vnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device unbind.
Replace all error paths that jumped to error_reserved_mem: with
error_early: since the manual cleanup label is no longer needed, and
remove the explicit of_reserved_mem_device_release() call in the remove
function.

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
Acked-by: Paul Kocialkowski <paulk@sys-base.io>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/logicvc/logicvc_drm.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51..d6dbe52ff0a9 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -306,7 +306,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(dev, "Failed to init memory region\n");
 		goto error_early;
@@ -327,14 +327,14 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		ret = of_address_to_resource(of_node, 0, &res);
 		if (ret) {
 			dev_err(dev, "Failed to get resource from address\n");
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		base = devm_ioremap_resource(dev, &res);
 		if (IS_ERR(base)) {
 			dev_err(dev, "Failed to map I/O base\n");
 			ret = PTR_ERR(base);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 
 		logicvc_drm_regmap_config.max_register = resource_size(&res) -
@@ -345,21 +345,21 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		if (IS_ERR(regmap)) {
 			dev_err(dev, "Failed to create regmap for I/O\n");
 			ret = PTR_ERR(regmap);
-			goto error_reserved_mem;
+			goto error_early;
 		}
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENODEV;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc = devm_drm_dev_alloc(dev, &logicvc_drm_driver,
 				     struct logicvc_drm, drm_dev);
 	if (IS_ERR(logicvc)) {
 		ret = PTR_ERR(logicvc);
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	platform_set_drvdata(pdev, logicvc);
@@ -371,7 +371,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	caps = logicvc_drm_caps_match(logicvc);
 	if (!caps) {
 		ret = -EINVAL;
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	logicvc->caps = caps;
@@ -382,7 +382,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	ret = logicvc_clocks_prepare(logicvc);
 	if (ret) {
 		drm_err(drm_dev, "Failed to prepare clocks\n");
-		goto error_reserved_mem;
+		goto error_early;
 	}
 
 	ret = devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
@@ -450,9 +450,6 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 error_clocks:
 	logicvc_clocks_unprepare(logicvc);
 
-error_reserved_mem:
-	of_reserved_mem_device_release(dev);
-
 error_early:
 	return ret;
 }
@@ -469,8 +466,6 @@ static void logicvc_drm_remove(struct platform_device *pdev)
 	logicvc_mode_fini(logicvc);
 
 	logicvc_clocks_unprepare(logicvc);
-
-	of_reserved_mem_device_release(dev);
 }
 
 static void logicvc_drm_shutdown(struct platform_device *pdev)
-- 
2.55.0


