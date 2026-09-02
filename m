Return-Path: <linux-aspeed+bounces-4944-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA4CC624DA
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:24:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0hV3hdbz2yqx;
	Thu, 03 Sep 2026 10:24:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380242;
	cv=none; b=ELuMpjR+v/5/ObejPntgkfnZPNVSsFIm9sRjLFCtnMWMoJRTRJX1Y+LyDWU55JgIynT3y8gJuuEJfJH1KPOT9PKRwIFudS0p7XeLTKBCxWxOpgHJlf2UuYdBTvGOOZLgmixw5TpHIchPLwm8svwBIexubLu/ERsug3WGZU9M6u8IeD6jQH7DCd3VOJqxe0+OPxl4veRnr+BOtT1RY7fpYMWdtGtOZFGYf2flfzesQVg4edmdb6BpVVFvJdwLriVmlOafVfKe3tOKK5JGk4bC6g0nEXb6RF3m78DL92aXk4PJOhcqA5oEC29WWhBvVn/rRXX4mWo8yw2k90zMh6l6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380242; c=relaxed/relaxed;
	bh=9lDnpS9AG8BMnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhIBpGHRhqdP48jUm9WjzyQBPgmggXuCoEiKRWLmI+uGEW/J6qY0KIa6fq2h8LoKZB2HrV/jeoYotASO3aGAAYMxG4z0PmHLJtoxLtkPe9iqw5/PsRH+OrNTooQb8QqSM+2XqqljLKvrxNiABZoxKAkWDuDLN9hpLVXdNlTI3plCzfZ3gzVyUaS7n9mHlAG/NL/N3+XMSjsj43NA+2awVwuoGLsklMHe1ZkJkMr/3LIMDv7upfgHEOgeI510iQzAg7JFxm+GJOODUsY+4gBbJah6i2blMQlIy1e/7TXiw6SsMeOmBXRvCDm+zM8lcSR6cNQVgZtA2CLCI33QaWN0/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a0sYz4CC; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lwt/pjvU; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a0sYz4CC;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lwt/pjvU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvCj3Znpz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:21 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHJEi2524076
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9lDnpS9AG8B
	MnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=; b=a0sYz4CCAZERJ5cvQgZ067dKOaN
	q3zsMGdWtgW4siEJGM7JhH5S27ck/eEvpze57SsRdLn6TIb6EYfN4QDUd0EgoQ47
	hCyZGr6sDbJ7x0sKo2J5FjWKamDlSx8J1AfHtG13YKSYWtdxi8lr8kdNCA37Mrn7
	ffVtMIw9RXL7cpU0LXHWe8Y2v1Hng0Cw8YAniRAajGPRp4mAkHO15m2C94aUICNL
	VtHZwWDy3QkuVzs9vQCqcXewaaRtyixuRjgqgrCtOI+jCbl0UhLpkfLp1PykMbjL
	qokITfmOkJByT5TuP8bH+8444POICdhc+B1vucMlN5DsaaxXwT4RQuCrmzQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4jq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so2024065a91.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380238; x=1788985038; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lDnpS9AG8BMnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=;
        b=Lwt/pjvUElzEbQH3r0/2R+5CY+0tRvhFaeC4qvgYKNVViSiLhQh1yzDm9cWOv129NW
         xBuaKhMppM9ptiiojYKDO681Y/kxtv21T1Dgy8Kw6xKZE9iBRKVV+v81InaSIxaABG7J
         kIrBYEGX1z97w20kDz6FmQ7fn0jRrBscRwjp/MGtjwamcvW+pdoSU5G+9Wgl7JH/8hJg
         Sz1gOLP5rYrp+7w8shnLPc8lAZWntg4m8Sn6zSSYz2dv5lP+o9gY5hT2Swva4m/yT/F9
         Mbd0kAs/cixvWUjECR6tBnqB92bhMMYeAyIuAmm6HSUnjuh0KmscNjX2zi3vpOpBKOTd
         enYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380238; x=1788985038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9lDnpS9AG8BMnKFjVCsDrmYG+UZscdm8zFBOnLWOShw=;
        b=ROwe7XYJD+uWbkasTsQIxWIklXK5NvJ5zx9VIf1VpKkQGEUm2+0LoQDpI2+FInkFnP
         dhWXo7GWvDpmOMrXEeAsGIKehscI2a1rjiqtgIWub+W/njbZzz4Rwy0ZdFuqB31ltgg7
         tSdr+iwZRQhPUUgFjwLj0XFTOuKrjVMd48TTCyJnrPhEeV7FwyrEZhB26SKweqr0XYsO
         ESiUvfFxfCssAk4ucUrIi/Ch7pJCPLbwf2zZP1y4uWkFWF4LAuvJK+B0EEn+5WsHZUSe
         fbKbhvBumN6ysb84t+TUsRDFKDWJsweLVPWBWTELvcaz5gsvRdpl83WDtNqg2BOpT+mH
         bEww==
X-Forwarded-Encrypted: i=1; AKwUvBy/DPqHnz7/zIyTPzYX/IBwJWvnHWBB6TyHJ2gwKCtjHss8HLtEYEOi/+AbWnBncrKeTE/7ku/Hl/BUWnA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l7/TJfMhgaaJ4383LHtE8HcP5yALKl+2pLEwxiBMr0I8IP9TYn
	50qrHNNkso9TPfY55WoYVuytFezoup6xPH0eMSE2dZPN4zGQi5w77ppuyxiZ9EwjwJRQzxvoZUa
	jffyigsWIoA0gpzG7cxiJJlABsuNqol0ZX1CE96+ca6gslPNINDW4Z8Nth5jSM4VyIthC
X-Gm-Gg: AYBFou29Hv+7r83qu8XrWvv1eUQwVmh7kx6OHbTRJAuoyRJv4tHZBnqCKesxo757K99
	R90tS01VoQUFV3MKMLb3uxWETb+cVAY+wWbmaq+QyBlZEUxEF2mCZzrmYFWzf6vB4OBzE8opslw
	qzqGqD99ocZJxqBEERm8mhip2rDkqhYCXb5hsLRb5P59+UpUcH8HtODH4FeF0jbjY16vdgy/cnP
	X4iaRN25OiB7M6lC5zE4f4rsgHFua7YQjng5MLiLZAlXgbZSYDt6PAcmS4Ic8LnFk2c1Ca9Jxk1
	I2FuiKLgqnaFefOS7V9u+4RlbUIU7w1jcKpfLlHbYUB4hocFC9ag+YZ2KrEx+yLHcxpeee6ZxWc
	TDnEi88NVpkDvfyfuoirnJB3CtQI=
X-Received: by 2002:a17:90b:1dc9:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39aee17a0ecmr11378954a91.25.1788380237648;
        Wed, 02 Sep 2026 13:17:17 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc9:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39aee17a0ecmr11378858a91.25.1788380237159;
        Wed, 02 Sep 2026 13:17:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:16 -0700 (PDT)
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
Subject: [PATCH v2 3/11] drm: pl111: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:32 +0530
Message-ID: <20260902201640.2024648-4-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a98844e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=cxSrDiPXJhrM2elx99wA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 1P_o508PEeeg6U_Rpvh2He9FPpyJsqE4
X-Proofpoint-ORIG-GUID: 1P_o508PEeeg6U_Rpvh2He9FPpyJsqE4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX7dBHeZ3eVO9N
 R+Xq74HHqzr3dQBzHvYZz3Ko1PzZFBa/Z+FQnu9yOhsgUl9YRBBHk9O1Cp2bGC8duGKq64vZZno
 TKkSCiwwmmy9tfNBTpVcIBplhNzm5tBRER9Gz5VLrZclKw79UwDRZmZMy5K7Wfb7OoLhKFXDUzf
 UkN4Aoes1pOL/TgrRXjtMgM93uy4yU3d2L9qzyepQFWRu6XLXCGXGXLOfAnVX8JFf4pe/qSJiaW
 NEcs8IB6np+R1a+huD2AePs0DnkKNziIamQZoyHc88YQ1hJ7S2nlh+C60LiN0tJlBsSWbuk7BA2
 ZVTQGklsI1vTO+SC9sP1wB/Q3tfI0SPOKwo7a8AQH4DuPW8YDqHDys7w6cCc8ukqMW5+Zxb8vLW
 Tr/hqwVwAWO4gh1s1BG/Rzfi48QjfYf/oDX/XMQZ/CT4J7R0wUDmK0Q0YDrUC368tBRLOwSBDQH
 nIoRQelWyFWeo1Xb5pA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXyfc5foLhK8IG
 JL8xowczUKmw94St9SmLY/NnA5pQVZXiQ05wpKZ1JNZ/YyW0x6pLMfTmqTCu9wC3JdsVRDLmpxo
 czAafUMYLQQscgdCqCcGZpvS1rqLy8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device removal.
Remove the explicit of_reserved_mem_device_release() calls in the
dev_put error path and pl111_amba_remove().

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 8ec659b3c08e..a07b17261961 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -255,7 +255,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (!ret) {
 		drm_info(drm, "using device-specific reserved memory\n");
 		priv->use_device_memory = true;
@@ -314,7 +314,6 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 
 dev_put:
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -330,7 +329,6 @@ static void pl111_amba_remove(struct amba_device *amba_dev)
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_dev_put(drm);
-	of_reserved_mem_device_release(dev);
 }
 
 static void pl111_amba_shutdown(struct amba_device *amba_dev)
-- 
2.55.0


