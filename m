Return-Path: <linux-aspeed+bounces-4946-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF528C61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:24:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0hW3WnMz2y2X;
	Thu, 03 Sep 2026 10:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380251;
	cv=none; b=LZBIa9qXfQ1uyci3ic7pPrOAdYoOzQBOQb9dKhuKubMRKnZp2G6AQzZgvGWLRp4gEI0IjjlEBYZwloSkjfIIcTDC8wDy0nrYzs2HMlP7GCmg2kRRRxxlYmdJ1sslkXQYTwGFXhz59lhexqu1ciJ8KZctFlglgtC3XpElBo9WrDigfGbd6QleCZe4LY8+gCv5ZUSc3JRCFim64x9BUxaZMXuNgEBvahdo7CyYui1JN9emeXZAkR7ulHNuL2D1g+qXIOI4SxsbquU+ipuueV8JSU7LnQKYChnNPslNRtyEkLsDh2HW/INCHRFvqtKYDqPpP2Y+yKAD6A5Iwwo4lKijpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380251; c=relaxed/relaxed;
	bh=+W6tpccLyWv9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkMHjrjI/ZyxUr9d4m2isg7+Zkl12ePc+LWuY34Dt2h32MvRH3DYBeVn30awd3roLnyb3QCYm/rB5O3/q70SIPCNMUX354Br5Q4WwoInz+Q5XvrbXLDq1SZv8PCx9GhGY0ViGRiiQo1/aszUutFIC7WS5sIhPoBe2l/QxLkRnsy86fbAO3tTJZ1dRPPVDLAKXhClRAqsKXBXifLhfVRkHT5JFTUo88EjI8EFEhmm5QZdLFButH09p7vD+hUv1BdPLyFNeIgpqK/3U7W4ohN3+Z/AdR889qhU28E1z42XcZODYGzUfYOjOKn6h00LeraG7+VxkpW4CvdMI2CMaXILeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cHASjO9n; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G/oELpHT; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cHASjO9n;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G/oELpHT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvCt6zdtz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:30 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHIFG2523948
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+W6tpccLyWv
	9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=; b=cHASjO9nJpDVndRqPqR+0ZBZe5y
	S5gqMEV2gnPj4s3n6BEV7NXgRHhdxo2t0J8shBsPe84l25uRRQorpCDeYPC6YnSC
	OKft0Zbq2yoHiHs58iPdkdcmhbsRlnMhwhCK6oxRoW38JR/QJC+pBGyumeR96CuL
	eKNmh88z2yaKScZqwLyJ4LQFBMLCggSJLOZjPef0vdX5LM0qiJrez8p52ZABeQ4m
	fH9g0Es37j/K5/wBfk5+csMuAx+ftxFpWvhK3647Iizdm4lZLTNWKEtdJr3OxbGA
	ohXjXcbEau00q26eI9i2SFV5O3n3QlU5c+RrvTAgZrmy0HdwOiQpjGX4dmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2119859a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380247; x=1788985047; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+W6tpccLyWv9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=;
        b=G/oELpHTplM8eHWW8R5sinytWWZK6GeJNTdZFDzwi+sStLfIyAiw1rlVA1XpsvdtEx
         aeS7BCJLi9atvHDrPdym+o16cYCoes181+eL+Cc/ESqK3LUbN9BXKHaoh7+4MdkeRk3e
         Hiv7lUrhQ02qrHqTq+eqVe3jWnWDgqioCTEXtJrvpreJ6F5vZy/QD8D1Wh6omomFMuJZ
         ThPGUs34Ibo9D8AE9n1tMZpdOkA0FljpHm1mibvzaGdmV5OV8nZV1aHK7o4DZtyys/Xc
         6zhG08VGqP/4ivnI7+CxDXno1UaBmxqjEdXZNdETNqet3GcpL7JSEX3u766RX4W+ajkV
         AG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380247; x=1788985047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+W6tpccLyWv9ClYrckcY6BlDCEvf2HSTQJWRxk+QBXg=;
        b=HWWUxFJ5UysaIc2xsVN8eMp6/o3sBu0LZCi08SlsuOhxd4VhfZ30uXPsxzZjv3rKay
         WFcMzmfJgP9LVjZ0rYqYdbInDFayO3yyYAuWXo4Hyf/OND4GCvNlyTYKdm5DY8SeSd3I
         ia+EaqWOuNtklVj8ZXfZGXY+zjLvtZolaCpg5JDViEhZJTririu/BQG9h8zgZLFbw1zm
         lQ56izBctq9DBkq+kbu/koVSy+oH4Ho6sTay0Gx0ln3pXwfl4ncL0KNVVmyD85LJmfnr
         kNPvBU+KDj8P4zxp6HzZbNa3754XLRmivlr1lDyPSJ2GkEZCbtXnthQycex0BMuKlYCo
         b9ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH5rAyk/846KyMuz3jNqb1frK0vUBq3EkaM7Xj/C8AEctWzltEU/qx2vVEqGxC4Z+Aozc+gHdVqhVGeXQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kBU0TQv0765TrD3iDpgwmMObbDwQxwxm2/w4eg/e5PXfHAiH0I
	XlCa+xQM9QaKNtyOE6BE4fo3+SqiCuSFmkcSneWESARtyq1CP+e+kw182BNhQY+i22qsUNmAzxb
	nHiiataEprnZ3Y0vuq3Boy5afS27R63l8mqIIZQJ5KawX/3OkUq+8WoU5R+eJcvOaT+1i
X-Gm-Gg: AYBFou0UnK3LIxSvwDi+DZB1uCN4RHvMd1tH+1Pr8EjOscjCOp/sI+yXovKWfhdFGUy
	FI2CmJhq0eZJY4BhRv996Ml72Sc+5RGndLGcPp5GkdBTKFT3aCsDIpmwEhwyNVhpOQ6208rbj1A
	8D5N8AqgniGjfixx9lBf/EhYDFv599BITVc6kcqhDN+7lqKg3mrnlAmnlG9fg9qCs23h9I4sM9z
	QqpVLYXUaGGYSPH54cHTPtj+AdEOcTcjS1QJX8NqLsay1vBOyf6UVwBiIS2hk6EhhToKbp6qzlO
	CN++1OWSf8jXKNbuw1xoXDTCA+1K8XAquGLR039+PEJbFgTjfbOXTQy8ouLa02+WScmBKOLh4yu
	UpOSTcGQPwZqroFw/yItd2CSnM+w=
X-Received: by 2002:a17:90b:4e8b:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39aedec54d0mr11465795a91.5.1788380246181;
        Wed, 02 Sep 2026 13:17:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8b:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39aedec54d0mr11465704a91.5.1788380245604;
        Wed, 02 Sep 2026 13:17:25 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:25 -0700 (PDT)
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
Subject: [PATCH v2 4/11] drm: komeda: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:33 +0530
Message-ID: <20260902201640.2024648-5-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a988457 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=8sfNmL5Et35J21XlSqYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: LKVFC_B92hHCd3MO_SJL6_SMnipFyEOf
X-Proofpoint-ORIG-GUID: LKVFC_B92hHCd3MO_SJL6_SMnipFyEOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX8lsLl+EocCXw
 cn4yc6FrGJWsE4KKmVRWTEsXcaBUYPjMReZodI3yrnvijRYyN7Uqxj3lGTV5n7uznUOe00Q07YL
 5WsrL8ss5a8TTo6GOZjbk9HrTITJFINq5XsFRaV8usEAmJCV63p2S0WntQmMHIcnMTMrmzx4mst
 uK9GUC4s4bYwNZGbPB6XS1aZwgVF8VpdJFCCA5dsLR8LcDS7phg0z4da2w0srh6a1pGPugirapN
 tJ95DcfQj88SBeNMo2GYSr1DjuoDjcHoUQDunLZgJPS6QuYj2JnRwW2mU5U7ubIf7buDywLBTbI
 1GXEy+4143kta7QRO7zfsozDyhdiM8IV4KwzQ6SGH5FNB5KgLgUM79BwOwnkWdGn+3viyDn/fFh
 pAL+e3Frhq2B5r337ZOi3Hxdro4eXNLEQdsn6VQWx7lkci37CGrBQzMHPJQswZByDWVAsf4MJU3
 OPea99USPe/q4G/4oWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX9PmSf4Pr5bDV
 MtkbNSLHYlr0kSKvd129P4TbCA8mfEn+H9EsS4zFMoEXP2sIAaEE4Y12RHyAhIxVkW9dJrHwnlh
 tYbW9V/wj4/D7MlW32GlcuSIbDlxT5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 9aad1d1d28ec..8016f5a68cba 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -145,7 +145,7 @@ static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
 	}
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -292,8 +292,6 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 
 	mdev->n_pipelines = 0;
 
-	of_reserved_mem_device_release(dev);
-
 	if (funcs && funcs->cleanup)
 		funcs->cleanup(mdev);
 
-- 
2.55.0


