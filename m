Return-Path: <linux-aspeed+bounces-4945-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3211CC624DB
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:24:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0hW37hdz2y2M;
	Thu, 03 Sep 2026 10:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380260;
	cv=none; b=G3RHJyENWkHlssYSKttMy330RZOwRgq9PtTosbyu+gUEB1zI8BvoEjmWVE33xdx5j61+JaPpaGHAcFGXCdBr6ezYFCtmmG5RjEpHRgRooTsm8cvwF0vTjP7J7sZGGnyfjCCJV0hRgC5wHCYcwV8jOYOx3EQaZqj5GnlkV+1dOyAhH7KCyR6mFy7JF72TCTIGMKTdAWApB2tJQZrkc9ytQAYbeiQ66i0fH2NYD7/RxPG/iEHTGU4g+KDj9aXoXjQ4SMH9zB5DL0ptJ9Yhs8ai3XxRUEGGHIp2ibTS2tHhKOZElXgI2OZSryARPYSVZ3vPHfuKRQ9Vw5I96ITYgzdQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380260; c=relaxed/relaxed;
	bh=fJookc6jcAFEyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL54iW33qXPB6pzfL6DmdOpwonSBenBxQ0VaU5yQHDej17b8FBIDpCSNsM2iZDWRApHyltFoI+cxw+OOSAHmYkYnWxw/fgim3ARjxQtsAsqb0QFN9mAZtuXfWK0lXdAGhT2Z0kAbrXLmzOlQ1dxEd9Ek3DeOjErS43uXcbxgZ66RwJYbCSxlGChwLMwmnkuEoyNxTAxN3GUBYYy2oW9P1Lhuu5rruRrLoG0H/2DuO4SZ0EaljWpK15SPbbymBjjxl0Cg5Aql4AOBSUmvA4aarkwhd/smROy3K6bX7leT4jgSh7xb/Pk+cDRj1UZ0Sj25g7aN6ASNB2AHxa+74VcHPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cKzTE0q9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P2/KbZ/9; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cKzTE0q9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P2/KbZ/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvD32g4kz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:39 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHWQf2686502
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fJookc6jcAF
	EyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=; b=cKzTE0q9kggbsu9YuOq1kAkuDdR
	YJhvVN+czMppY1U0nol/0Nu9eJg+w/VFZzYpLp6tDgr08w/mOjZzQMor1M5ZJ43s
	aqFqFF8zPGXQ974shwBrtJIoDDhkVNz9CXms9H9Ur4Nh5EJh3egmeDqIa8aVm3HB
	f7W+dmLT4Bpgj5WrbBijZpdzHBScjhtTOCpC5WtmF8n6Kg8j3e12752VkYVhsUAV
	euJrXiqfaKFvPGVbkivLLcukuLJ4/t0MfC0ImtQmBOwomB4h1Tyd5aDhFDADBn7C
	wt5VIxwjnf6q4IbxY62WHm94TJBj9F6OQtfzZFVnS5QgaNIjYXnDEWEc8lA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a84k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso2831954a91.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380255; x=1788985055; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJookc6jcAFEyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=;
        b=P2/KbZ/93YgHeR+nfWQAr0y9lFA04Cci2GRl//ljWvJ/s1PM8w1ktChjXt30RejTVm
         723+jHCPJyPI4+2gfEPVK4JSvWbEw/4iKUU1jL9vkBGjfnQwAKuvKw8ozSz6jKeQj9xM
         TVqkqUk+JNzc3Og3Oz13RbOh+2D8lXUGH8r7USqrWczoO1PtANqYkw6ZMs52oKPsNKwM
         xxX/2h1J4hWv4uRs2bsaH/iFlxaHUq+9c16ZiXHGHApxs8V35PqzrTwI7VTpoq3np9sq
         T9XOzCa9E/g7ND2ndfM7qJs6m9rZ+GixDYIgMn6b0LDFr5tPMUGFjayttwqrI+N4p9xv
         fIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380255; x=1788985055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJookc6jcAFEyWsEkKo0DtGELL3YSCH9IlXzUWBNEdY=;
        b=AYC5d34L20/q3hC+2cAutHwT0JNirqejltYS5RA8IfZv01NnDM6MbAzO6u5wfEJtB4
         wjXBwNejpNqgrmuQLyuMMNC/IGVShosewPU+9Y3N2jS5VicUu04MTa8u9CgfrgFDfma/
         BB2NXw46PSTVUVWoHTn3uNLpwiie7bM4R6g3d8/GZ836hw025tq9BSiN1bpa79RiGZq2
         17A4u4lD5PLq3mbYXfj/LcAk8oW0M410EkNSSrh+Pli3IUeohtEOqbLD/w5RsV7d2KD7
         HFgZyndTXbiIs9+uiEPmoFeuM1MyDsb5Zk6Bi1OHVpEdKf7iHuAYWWvVn2mJ87Kn2vn8
         91fg==
X-Forwarded-Encrypted: i=1; AKwUvBw/jAiRLbGgHA2Nziq3A1/AU9nu2gvMmAGzEsJiHnytT5mFJsRWdpPhAocJXO+OvO9mUrHM7jNND/QWTqM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mxWaVRqxpoAr8iSLEwgmx/+/YSwe87pEeak6bQQjpqlE4hwE/U
	uX3/Jkr0xq/BoWAwLcwsRfHOMv+3+qxySPJy7zagdFXxfMIwf+P1BCulzQMLjbCPPGos89HXq3L
	OBk24CWajBiBKwy5BVTDaMRoLGQkUfNYJdimQvdj9FaNn16K5+JrlYwTc3BJcYdwo8ULl
X-Gm-Gg: AYBFou2L8zRcWiwFElXY1Vrtwh8QiH2PXcmAR0yjB1PS9jeO0XNWEw8MI9cqr7wtYjt
	vFosOBAkUcV5PuP2+QwcR6DCv3UWiybk36OxIv/fouWvUoYdfyvmPs8vBf0FYdmjIrExghMrS80
	OWynklYeD6WqnXtH9CTTiYI9nMKqrHnUMw53woGAjkSO1v0/a2eDkvJhgjz7CuzKDN4ZwgyeaQG
	PEay18/bywVxN8DUUTKUTe3al1g7iMQu0/LabQCdKSVnhi6g9lygT8rnNNLLbU/7+9PW4AeQdw3
	1/kRwOBDlghn1HLekejUrDSRSenWlPPfv0pGX44Q33i9Nqb/WWQBLgZHCEI+Sj2qxtdD4YRxwkO
	sHST8ElyFHSUDlM+jCxOi1BlWqXQ=
X-Received: by 2002:a17:90b:4b0f:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39aee238df1mr8817754a91.21.1788380254742;
        Wed, 02 Sep 2026 13:17:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0f:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39aee238df1mr8817663a91.21.1788380254041;
        Wed, 02 Sep 2026 13:17:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:33 -0700 (PDT)
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
Subject: [PATCH v2 5/11] drm: malidp: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:34 +0530
Message-ID: <20260902201640.2024648-6-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: pxITgtUIvuyXxzw1FGovQvg0VuPv0Nka
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a98845f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=JOjAg5lxkONN77W759IA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX2jbjXHHWigVT
 71CoNBCOEf9dRPT3zTiaxDIbysIhlSa+Lyi+L5HEZvrEzaB22cyf6xFBDlBp+gJgztKGCLh1KpT
 PZY0xkwnOGoL27jVGNHkS2b0W9CUlxow8KXmxGfUia1+2hmaEjVv2AwLTlINJZFi5OWBDs84BiM
 ePWJP7QTSmjji0zHpZ9X4cpjg9qh21PWGImKyk1H4KBked9ouKOHs6T+dtGbSS0eSI/Kx4VyasN
 bkhM2GGwe/nee8IKbVzWn4qyAP9A8WIEXC7Mwqb5HGP/LjMVF3r27JQI26sQxNxgeGbEXuu6WvP
 fs2WG/Uvmjdi9UdPkLxdOum1Ze2LaAcVHy+M0U1dbmi0OpQQDe7IhBJMu9fR3geAqJnghGhAb9s
 e+KPGztxxBTD+T+fSO0ePa1N8rZE80Rtxn4+fRNvekRPbLIEyN3ZdEg5XuoGK8RVqUvLQHH8flc
 yTBgUmm6Dsl1xTDyDjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX5VpxaFwO4+nO
 Dk85/F7JYeGe3ytt0OHIkWLWOmNmnDoW5A9fq0MDVVHIeC1QZlycBkqyaiqGMXC5ItdShQVRaga
 6VVB4AOf/ASZ+F1rTMAf6fslL0u6Vp4=
X-Proofpoint-ORIG-GUID: pxITgtUIvuyXxzw1FGovQvg0VuPv0Nka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 23fa942ae4bb..3e17513c3114 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -758,7 +758,7 @@ static int malidp_bind(struct device *dev)
 		return PTR_ERR(hwdev->pxlclk);
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -887,7 +887,6 @@ static int malidp_bind(struct device *dev)
 	else
 		malidp_runtime_pm_suspend(dev);
 	dev_set_drvdata(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	return ret;
 }
@@ -913,7 +912,6 @@ static void malidp_unbind(struct device *dev)
 	else
 		malidp_runtime_pm_suspend(dev);
 	dev_set_drvdata(dev, NULL);
-	of_reserved_mem_device_release(dev);
 }
 
 static const struct component_master_ops malidp_master_ops = {
-- 
2.55.0


