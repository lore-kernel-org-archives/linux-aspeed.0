Return-Path: <linux-aspeed+bounces-4394-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F68C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:38:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkRP17zBz3btq;
	Mon, 06 Jul 2026 09:37:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280439;
	cv=none; b=Z0FvW9y/FFkfIRNrXImA+bamCe1c3qsTOcTEsSeC1Iafh5kLYe4uKSDo3Qh3Ap9ltBFHrLSdKmOStLaf4hKCgUWsNbjOmiqZJ59zqJWY4lbskNr8FD7pN35dZLgCLf9m0WtfCqkoV37krcQzT7GfePcofU/Sx7UnMeSCC5pW/6WWxPLvvoXCzR2bGuIZ6PICjzMeysGDHJ54oGDdVmIaXXRdF0hPF72BCURoEJeV/SgAm+j5ALhnMs3plf9/l3uPLQewFh/n29ldhq21bCgw9r/FGCSyzvD1rVXYJvdG6pfDS5OzbEX85+QqHplMdBGqEqf5hXcFKmVnf/Zetqo5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280439; c=relaxed/relaxed;
	bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRqi5YSaB93TmK5XKitN3nROO3cqNBQ5M388651ytFmk9ZfPqdCcfilIFo2Z3WnTBi1+RxnLtzKo8ZwMVhWPnHDaN0jIT8aMmfNNd1CV48lydhL0/0w/XBP8WsbUDge+wUriDohG5fVTmyeEDJx4S0yqGZ2YnxIE3FyJJ8RGHf5toXRbfBMW3EJ7vA5H0yIdqX+Ax4UNjX0ueJ4xQVMTn07Zc7vxtm0w5q1Txrc83vY7vKa/smzOED6TEgY4MX15mrJbxQTZd0JEhMT9ibsvdF8RO/jl+Wz7V/Y8rp1IU7uONRE+GDmo5fT3rb5vSiMliJEJiFiIhDM0A/4ufukA5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDqYFdv4; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IdlzMJAG; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDqYFdv4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IdlzMJAG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdBX5dHkz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:40:35 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Hj2Tn2328901
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=03p+FFlmwi4
	5suRC+aZpApiuhNt9KA4gObs4WxBM+z8=; b=EDqYFdv4Pmeqy9IR99dcNiLiDAT
	/yuTE7Ljg9Hev+D7GIua619X8FUaXVlexko06UWo2I1UG1HwTHa/3pcOiO1FNKdk
	YiY1UO4+AP6rm2LO5F78feakLwRgePs5DdWtrzsXwhYCgTfecFqPFRL/MQqcfyO9
	pb9r2UQAkfcA5gru+dfTHa2mdfv7340zDAANejxt7cH1lKuJqEenlOMOzxtkjth3
	hBP3jcZzSc9vRDjWjL0r4gMT/svWmjZh1dvVGSJdpYFTDJ+ZtuRTINMxgHG6Wmig
	3zizUVw2wRtMv7D6VUvWZqVy2hRD9jXlwyfLqvXinpJSMddoU1sfRGdzOYQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh3cs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8952346bb9so1794068a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280430; x=1783885230; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
        b=IdlzMJAGXfM4TJ9e2APquFKdViAlT9co/vusjPMX43JC5+G77t0ghOHQeM9vQhdqkJ
         2BmdFVq8B/43vFm8vOqueBZgLN6PniY4ge05n9Wh1Uay6rbl0JwjnzuEfGZ/lqSzS3/I
         Z/l49CgFT8Z5vh6z6hiG3AmUIXbml06DncvaMydjDLmXchRzBSH8IK32IgXiX4RLAjKA
         AJLBVF283wWe+Oo1irVTHg/g9BSku+poYi8rMSbOfHDoaOqYjYip3ZVYAqra+D77emFF
         diO/AhFphHzTtnYaNsGSBLVxSsXfZfHnfSCHnfvCFuVwgHa67XMOzC4ALYvRu9eXacMh
         kgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280430; x=1783885230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03p+FFlmwi45suRC+aZpApiuhNt9KA4gObs4WxBM+z8=;
        b=HlES754eTvH3VueicOg6RlJ0ohIiy30+Pu9fYjWMtvx5XzU3t0fCn8eiSGz5iTooeL
         /Bt95eGeOFlSDsM7NIqhqSGYeQnbsGirY6xbEJ2u0uKaST2s6wIRGcDYGUmI+p/H/XWX
         EBGLbtr+yHJsqfLkUe6ogGplLKu/m06ydtvZcWxBFSh1uP4K/9PfI3jP9vdHOCbZ3dhQ
         cZrcBp7Fb1zklb6iPhnR2DMABNRY6xTS8XonkgxZDVkiK4cAEo+sHQPnfi+00a2tyWvc
         fQTyc6UzZQ3p0s0+7IaoVK8Ttuh4QPFkptLWBX+L7y41vakwsuNt+zciuLW8sOJpiKWg
         ftww==
X-Forwarded-Encrypted: i=1; AHgh+RqjWsiDCEJffNZQk/g+U25YyzZm5EYtL6FfNoF3dIB5YuzK9r3Lf+9mXFD9B6Gw+Sct/8nBV6D2eGvU2vE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/hjGDq/I1OP/DRr+AnRnC/CDVSDdasLhf3d514AyJ7wqb4hbv
	f6je0wzBAvWvQLcMOwPpqSkM6pF9jG7/baUyT8Yl9gAPT8AlyftDo6OMdL7c+dvsjh/gThLMjVG
	bgRFXGqMKIPP9Yp8fkDEVm2Euv4vZG8pu7gWEFTs2HY/phwYoYPTx3iUklVm7EJrBvgXd
X-Gm-Gg: AfdE7cm1gZNZMIQ5+//LbZ/wYG4aZC2GIar0Dzxe4zETvlbd99k2WJT8Gd8g2oKQRYf
	DWoWudb6mljAoaj0Q0fBMcadRvt6MPmzCCBNgwr9bhH6Ay2pfDzOrtycNAIcqUhWbNsoO5YrQ5L
	6yndfnz42gAcgOBldC3NhRbdAtxoq6Atomw9V5ygii2/CnZYswtONWb1G00sQWnY5yH3Z8E/zAY
	FEUhA9o+1Oo5KViE+NdrADH5jJDyWQcNz01UsWxDV9BViuiSi9MDRYpH1bJLxdf6kHmAfknFWrF
	eCi9KGJtKQ8rCyt57b81LAuOdpUNUhgdCRMJ2Z89pCEAaS8dnfe+cF8F03BJhaGTkqr7IN04f8n
	yam2w9E1JOGVy7j/0SEFw0vFfqyiEzEvVyg5FTQ==
X-Received: by 2002:a05:6a20:a122:b0:3bf:9944:a8d8 with SMTP id adf61e73a8af0-3c03e3ed638mr7693667637.34.1783280430274;
        Sun, 05 Jul 2026 12:40:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:a122:b0:3bf:9944:a8d8 with SMTP id adf61e73a8af0-3c03e3ed638mr7693658637.34.1783280429779;
        Sun, 05 Jul 2026 12:40:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:29 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 33/42] drm: arcpgu: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:09 +0530
Message-ID: <20260705194019.2565498-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4ab32f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lEtn7xO9CsvGDZioIccA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXx38YkgDVibSh
 pwsvVWxDVFzj59Quic5L8chG6Bx1H7CDb2SoyHZQh0Fo9Bj7Er66h6oc1rxBUBAJSy/MYm/YU94
 fQHPU+8JRb/fpTRVtlWqGGFFKE2T/u5/yfUbltLvtW44kU/ej3W9uJmnrlZpUMfAGGNei76CnHT
 Q4KQb6tM57yxoWQYEGCJdZUvIcnHRLQ0H3FYSc3YseKhcjKe99VSfSlVx/sJezrAya5ISFdM6mh
 K5Zxy6mbYmBEQaXp6xGLIpGCsGHxSa3f2rU6NwDZ2iCbpyGsic+zJHyuA+P91MsKDzoEuDwH+5v
 kKPHCkCK0J2sFmMAQxe0tZOzcDEDKhm8r+ZBQxRMs3+IWZJp3/dNUnGwCr+hKY5bQddBwD9Smpg
 GadB1yn0l00AX2rqVZOFOOIOLYdoBi5iVkXstifhsJvoFLSPHXYjTGNNdcPE3qObDPDlRsnYW3f
 +uURDMCFqVR3miAok/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXw6VGdfclnoE4
 Bjd5T5yZab4lQfqSu1oilGtCh/trdUgN+/hu4rj+nITSyYSy8un7YdYr/Lokzl4WSKesE770HDX
 kNwYgD6ZDw0qLOzOepm+AFcH0YCGEEo=
X-Proofpoint-ORIG-GUID: L2R2KU0nPHlJgabnI7b4PR1MpiPZU6Za
X-Proofpoint-GUID: L2R2KU0nPHlJgabnI7b4PR1MpiPZU6Za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the optional reserved memory region is released on device removal,
fixing a missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..fa01407570a8 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -278,7 +278,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		 arc_pgu_read(arcpgu, ARCPGU_REG_ID));
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
-- 
2.53.0


