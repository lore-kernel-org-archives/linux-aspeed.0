Return-Path: <linux-aspeed+bounces-4947-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61537C624DA
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:24:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0hW62GKz2y8F;
	Thu, 03 Sep 2026 10:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380301;
	cv=none; b=H3B3Y7OhRU5j7qP6758qjNFSjqqvShFy05Buwu2wkEdl415VhPxlOq5aJ4KMzBLqod2brTwD+42GvqBP4P50HmCHVhMp/J2NXT4Bo6ihEuqFQDIE+hO3RGck7VXqgraABJk+aKuAqXm+JfkZR87CCXrNeH/AisbMJbUin/GP5N33ERsFHupLxK6Gkd5U2d1fcFB64pKCZIM8Ye3tX/sIb2jKygU+EhED5uvKtHgSmFpUiRAXae/3jrrmWRkSAIEnurPzBwcOwh1gqlozBY4JFjHfE+sDY0LmFxq2vmAGz/98KN1A1rTK7UpjI7boootGpMcvDskkElmWyQEt4jNqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380301; c=relaxed/relaxed;
	bh=c6HQDZCYEIMsyPfEAWg93U0OzA1bvoHTLf63dEO3qvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN7vJrPkLpwOSGi9KT228wJdL0aWbAw58efeiBkd6cG2FGw2J1Hg7+5qRyfw0nvgk6UK7JTJlCuHPeL5uPJE7N3sMWMwBYlp6jeua9y1VjVUtMR87ZGKFlUVG1WggNK65zgMGy7xjjbf4B4PsMrDZ6nnXFIgdhWqj7eeSuIFBABCKUuOoTCYitm4lNFhtDhp85/S7a4T48ZdoUeYlVqtyB/8vxiiv5265d8izjUBjywYJ4ysZwl80YzLHY5SGTRDNSmOIUpk+IB36lsn5rlBb9CNEQgen9kFEos8RUXt37AEGhs9sq09w00sYsyUDUpUUEAbP6irRSXLmHdppOo3/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4/xxysH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2Ode14z; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4/xxysH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2Ode14z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvDr529bz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:18:20 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHb2C2524595
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c6HQDZCYEIM
	syPfEAWg93U0OzA1bvoHTLf63dEO3qvM=; b=D4/xxysHu6h5JqhAcumyeOuS3B8
	W8HHU0fAh48XcC6p1FWpCc2Nbh86TBNshywT7oaRRWlnNNGj16e5t8MJkIl0qkg3
	QlE0KLApseLXQGMF/TkpZph7x6/qwS3VGBhQ1yQaaay0gsb5lbWSfZKY5MwXlzPO
	SWK+FZWTmf61Vr2egMo37bFGQmD2M08uWW4WJWts/XSXmNiEpoWQj29wYB3AnRMG
	oerW2EcPR842lQMgQNkheGBnvx4wVE9HKfFPSaEy2lHtx4dN+TadUgisT0+mDKZf
	MpZfNS0m23xfe+zQsYROXrYO9VBk7cxQv3AEwOItzm7SU2pEAXWFA+pi+RA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:18:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso1777515a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380297; x=1788985097; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6HQDZCYEIMsyPfEAWg93U0OzA1bvoHTLf63dEO3qvM=;
        b=U2Ode14zEJ7/uY3BJWLALK0rLfXR+Mzyk2+Wf0KLXunIUid2kw9ATD4GBjYA7D4Anr
         JcWr3Zam8wYrBRyuOqa5jctgCNe0W3gkLG1cA1at1ecofV3dsARsMPiKg8HSE6oaYaWv
         cA4ryrBYvAQZlcr+WAegj8RsSV3u8byrLvzQBYltEMFkYWzHuANwn480rtpt8EPfRNfk
         BhngbFj4kwmGctVCsQ17RfDJ2IhZFXML82962OclZXEJv+JLBrDg86h7+Fb4k70teLwI
         tOSdh+lmThSxKL6bK9NgKj1lsY/M1Fb8DsVhJcij6iJvyihV2OPBAFfUjhEXhZ5PM1Fq
         ARZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380297; x=1788985097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6HQDZCYEIMsyPfEAWg93U0OzA1bvoHTLf63dEO3qvM=;
        b=MkYZEZL5XVXXAjWRfbkUTfs/BwtyfXgio1FJGauXG21YKyMToZQQEHG8/quGvAyreQ
         27yO66KPDw2hqt+6zac9c6Zx6jfoz0Zv/lmuL35aNKZ0dV68jbj9dRcQDHhFm23f6AE0
         CCChiJqnLybJPj+Lu3yDlkAY/yDnY0ZGkEQwa0ZJcZKQvJHfaO5nKZLY7MnYZsCzA7IL
         nOkO75nMo332/D9fG0q8UJsV9fs1i7D86krJnNhrxvAZfe+1+ZZrwZpYKKJtCs1BwoX9
         8KZJ3hyYC2gtrkbCvMe3kyH1m7FcPRRvzMGEl44VLF5Cum+9ZLxTMf60QwmNj+Ra/ZIR
         hUfw==
X-Forwarded-Encrypted: i=1; AKwUvBzAMj4Lus4vXjCju28pAp8YAPVmmtLBJVGQjyB6ZwRjLFGAmr5cKjJ9KOo8bBCmN/cxK9ncUslIp0nBsj4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++khBcFSf8aDUKXUl0fqlR09p0WRU3O+6VxnExAns0Gh8e8a/H0S
	Grq4gCMYnR8EKEW0MV6QwwyAL2naCV7DcssseeFQDOGLffLGBn6LTGR5HSWLj9QnCDsYiklOJ20
	2O3an9+Pq5bEvss9xBKsTrjad1MAYSbuMWPQogQfKQOFkAAgJ7z+BWfldY5/hPnFhqbRr
X-Gm-Gg: AYBFou3i9TdnSn4m/dOEUfNnXHle4IjktFMilmHW8AplZDD9+7t+i5RzO9mLib0YOLK
	QEaA9C819A5C68xG0Cp1zvN9SVxf3JyFtd417lElJxssu3bkVErsKcdJG7UXrQR3CMb7FUN6fDI
	C0BM69dM7H6CN4rBhOl5mnBGFoQzlg3Ejr8DI+tlhIFY1YW1U53gT9RVYSUwsOTQbVtaH4PFujf
	bDfVVW1yRPVcKNhStzietjDgDXEDHIVpyyHBSMB0OmY+IEyct9iaVoiZ2TWAudiR9OwWydnlo0/
	O5RBVaqYuecpZRv5VPm2Xzyrx9JBC21y4wcds63mxXE0NyOFcPZWpbN6Zgc2XfvvhmeKYRj9qiO
	tMoS44txxURMQ+WYTeUEgOIP7F+s=
X-Received: by 2002:a17:90b:33c4:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39aee178de8mr9152934a91.21.1788380296967;
        Wed, 02 Sep 2026 13:18:16 -0700 (PDT)
X-Received: by 2002:a17:90b:33c4:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39aee178de8mr9152869a91.21.1788380296440;
        Wed, 02 Sep 2026 13:18:16 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:18:16 -0700 (PDT)
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
Subject: [PATCH v2 10/11] drm: aspeed: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:39 +0530
Message-ID: <20260902201640.2024648-11-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a98848a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: XlNPz66-RemXnppr_lEphQVbWy_tYrVE
X-Proofpoint-ORIG-GUID: XlNPz66-RemXnppr_lEphQVbWy_tYrVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX+OKIYSlrLjwg
 ip5UOSmQLNrMhpHeAPsnfh3p4/7e2iGEzdqAL+49K2N/8kV91rV3ZnEFxM9rSxqvyPhbsI4IVLY
 KFJMebo4VbbCT2KuFosStXQ0WAq0D8qDw4SwUuuvbul1dJ3wP1+DXxXOq34ieT0twppXCZyqR2V
 Fqgv7Zl4LRkbr8c9OSJfZVQGI//PThJZB9tQ0HSa6ao3/G69qVLJw1YMqC3TLulWp+zDpx06XsM
 ZuZaFnOYAuafnPvlGG/RCJLl9vppoppRR4989PIrsLYOwLhV7H6KxM5Vng41RFIzonigPrYE4ze
 Zxz1ze5Zx6Tvgrx7l9lu7h+rYkuAyifLYaneZls5x1X4hr6u1Gqd7S5SG4S9aOBq5YaZV3wfFPF
 MBzM0qZmSF2BhnGzI0ltCZIpk4YfWAVFroOtxPM7cb98kDVdU8MdTeR2YsbzW8trR5aj25+VhYc
 xvVprKAks3i310y+Ygw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX4QpBQ9VogP2U
 sU9or3asvB0abWncHbrkAOnhCTUPRHzmCgpQ0nUIBg09/NSp9TfiqfBpX3wVPWKe43GJgB1p9Hi
 6m1zmg/Nz4TPblxGg7rZE60qmENgeNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4577663a1f0..2c7e54fc35d9 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -168,7 +168,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 		}
 	}
 
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to initialize reserved mem: %d\n", ret);
-- 
2.55.0


