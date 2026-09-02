Return-Path: <linux-aspeed+bounces-4948-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25BEC624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:24:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0hY0Dhtz2yqq;
	Thu, 03 Sep 2026 10:24:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380309;
	cv=none; b=Gi8jSV0XHumm38Ype6IZRAfTyFfg2efWbM28gORTwNvruybTmt3CGU5rXTLUgN+wAWEMM8ONgHU3q5NUB0S3AXLCJ+EGO0MznqgKNluQso+iEbSwLJMplTpIsA4JWS8gLcG/JtI52EnAbvDx1lDtkuLTbFE3sknXc4Boe074Ioq8bOjv3RMVlNwPkl/R6WI/ZAsfwb+hcLpQfEab5ZioHNDNtouvey7tIjm6GZuGMhXcde0v6HMhxsk9NcTAbuDO3v+jjAouRJRuryZZ/lu6QYDbzkpxDIdoNCHwakSF3Q4gUE2INYH2OQjhExYvp3ClwGiZcbEPIHZY3pFMqw8vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380309; c=relaxed/relaxed;
	bh=nQGNtigd/fhQj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlPIvJe6G3S3KKWNpZN1B5uvINBAiMaijU9v+n8TzEb8RgNneZvSjR6Iy5r7hQ7y1VeX+tbQuCrLa95WfxOws9lXzxIMSqS9kaVvx+rUoa6XJb/B1w22hydMemNza5BGaKycWV3KQ34A2mPytEwZpnk5YYQbyBD0SQ0/n8cQZGCp3gqKtNDkyCub/0y46CCC8uHVLqHWnouKVc4XfPN8vVNhHw9ZO2P5WbXjYno9OYDg8ye525E22dK1tjcnLZP6AQsy0WFfJkq3e1Z72T7T7zo7He0nOD+eE4u1pKGVRgoG3GXjdHuGca4STfqqg2hex4Do5Cm+w9Bzg6ezThkIVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n5T54Ehs; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fWXLh8zh; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n5T54Ehs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fWXLh8zh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvF11BmKz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:18:28 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KH8232417702
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nQGNtigd/fh
	Qj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=; b=n5T54EhsFCac0SeU5D97p7M0YyQ
	OQP1d0SiagH2QmIaJgTg0EzJqAasz7GbSsSPgUw2R5IJKN5KyjDdv+DO0Rik54jE
	Bw2ZYVdQ/cPd0iB5Rya3x6gJSo0zOOi5xs+R2+lI1ZraYlDfpII2Kju77CMQhqq1
	kK2P51HgZ7pos/Fkkp4EMGCSK6kQA/B3WSACwICogt3xvn0rRFQCCjtomCESoywQ
	hdJHu110huHjIB6qTqqapo0sKyxDfgmizZ5IWbyX/yMQ0sY/FvNGJGoNx8oXqqAr
	mXJHiTmzb2USb616HCS79zAQNlYwqyhwmVHKR2UWQd2CiF/orhDCnJuwgcA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdses4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:18:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d7443e0f0bso23055445ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380305; x=1788985105; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQGNtigd/fhQj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=;
        b=fWXLh8zh/cSNKXS9gJafdXIZsBX36Rev9UDyWfx+dlRUaTJWmZC5xTcWWyqBDHCmwX
         7/9a4AceOAPbrki+08n2DWeiOhQCFZdLGdPdkBPoIVN3xP2HKDIjetoIScBC+lrFzvVP
         RWLIYlxzGbZ6YoWx/cWeu/6w0qZmXdqfNY7pLTGaaadIc4uBus7A2azoZ5iUHT11wHuE
         zK3VR+vlfWKeKQ8VBJ1chq9eSbVg6zY5k4GtX7iuMkbxapPNZ12VB2bmF6qzO9IxpoMr
         QXomgBJVn/x4zAEI8Me4NdnssL8XN4rnLjbt1jCUiXItSnqW+OSXtq3qfdwHVyRChurF
         t5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380305; x=1788985105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nQGNtigd/fhQj8k99E1cXDjPd48Xc/BcsE7CCfKWZIU=;
        b=rpFuPcguhCDdHB9u7Goj61SyKewh5e7szrfmendIXM2pxqjIy9L6cUorGqfhyQ5cRm
         +1Ujb0enG1+mLMptFBD7yMMaN4pkkRSqjPTGua2WMnOFpmYTfQY34gpyXYeE7CESCzPL
         aeCrfI/Asw47tFyymmsAf1EFP8yqsS3AW1UN4ecuwqiKUSVCFddVwghmAz7IhyoJMnwV
         ir2GwOmcchI4hJyuaShv2XvFl6KzMIEdwfRt5TUTMUZW99YwUAvRiCmW1ut1FTNfCjcG
         I2lXPV0LhO0WO6A3Qf5kBGInd1JvxW42WPVLm0NeRHCgfb0D+IUagrQRnKuIQ24Ocxtk
         bVoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzROxVlX2iy+K5RR8RNwBhXcBkYl1oHJ6y2giDAJhFHnvc8SOxOsiOf33PFONglNcABCmt04epoTGvu9Kc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l0hbFsRELD84b4m8+DcAVPRGTBAlqWQgQeoRGB1NvBloAm+cGP
	r6yPy18QgL8czzrt8m6uUFYZE87uSEgrd1YirYeQ1bJ0ZbFm81wtKJWttBGi6eYkcS4c8a2tZ82
	qXPsCNfwznssHT96P29KxaNBHWmzXMoKoXaGUDOUDitqswdWRJ0i/hjWxWnDLR45YyaUr
X-Gm-Gg: AYBFou2Y2WFz9cMCmtwD6RYFuG4MckwNnpbTacT0gN8zd/5ANyk5RDLtGTFkAi7QFYc
	74JxXsZgPFeTxL3nfv/FEkHFzvDaoP7BqjwKLCzrVMVROOwj4kDUfW+6KojeDBulQWYQzO6zLNP
	55aN5X4Mo725aj3mHmx5JYEK93F07TGr8vm17ov0p8WDXBJWDJAG90N3q7HTNs2Vt1WCuvtPSxA
	WnGiaMu9WZqJWE2lnr+b0qx2+og5O/UqqT+JmsWn8W1n+e3p3XM60FQ8dXgN+4M5W9xpAT+MVXk
	EGalVYQmaDSAV8XKfWY1wQw+gDirGPJZ6dp24RV8u4gifi99xnn0y+We4e1X+CBQ5XhKCKiFmjD
	YDooOEIhjqOrS3vTq1AXJruIIURs=
X-Received: by 2002:a17:903:32c2:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2daec646e99mr78475585ad.7.1788380305423;
        Wed, 02 Sep 2026 13:18:25 -0700 (PDT)
X-Received: by 2002:a17:903:32c2:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2daec646e99mr78474985ad.7.1788380304847;
        Wed, 02 Sep 2026 13:18:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:18:24 -0700 (PDT)
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
Subject: [PATCH v2 11/11] drm: arcpgu: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:40 +0530
Message-ID: <20260902201640.2024648-12-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a988492 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lEtn7xO9CsvGDZioIccA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ovS-2CD2TAY-7pw6hMyXun0UzsVGe1E2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX/RD8DUX0hASS
 QQxTinQc18JHA8OOfbO7Z+gqI1h6O3eBHTM8OsZU+E/Wd0RLXcGFrFGMIsngj/qJ5cRQYRld9x4
 /aX/lQPiWhvu12VmKbwRFaIMnX7sPrHmiIIWtd6Rj1HB1mUbOYZo5qIM0EEx0snPfnBOZmXP/FX
 5OuDy3eQbOzxevsAOpGuSVON3OfigRXxXOdRVAvRyYQUYrKlPbtdW5ZGJ0wFkeN65E3bv+n5dD0
 ru5qWWguagoSTlNmIgQB8KMdLPJh38c/j9WAmHfdQQpaXa1IJfOsFwIIkL9c7kAXxkXAcFP3OE5
 UbDhIPgXqiMGHCUBpR52TJbF/kuYCSqLULQOCmYOWH3vb/151CIPOv+llrOCR1/J5HP9ODm+3Hi
 qAwHmHU8zmvkwbJ3AmoURtObaYv/PSPlfndLoME7rjb3OkHKsJaL/bOVY+zPSabexMm0GzGgrNV
 Wf6Qqg9om84XXk+PQ5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX+aH0tpEYbBra
 BrgV0JFNF5YXjZexRBKfq0biG6Q9Yv7T6n93MGWy0xyeoLRC+0Ynn1AtVM4Nd5NxnJEOcC3Mx02
 N4TwB6pRL3oLCSbmHIK1ELTqmwtnnRs=
X-Proofpoint-ORIG-GUID: ovS-2CD2TAY-7pw6hMyXun0UzsVGe1E2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

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
2.55.0


