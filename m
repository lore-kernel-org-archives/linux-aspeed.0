Return-Path: <linux-aspeed+bounces-4925-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC3C624DA
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0ZH3Hwzz2y06;
	Thu, 03 Sep 2026 10:18:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380276;
	cv=none; b=IUA1g3p6Gg+Eo4PSJYf2EO9iI+QtGLlwtcVnCk/PCoyiz4ZL9wD5S4yaATySKbGviQH6gPAgHJKuj+6rJYcudaD9CYnIeBSWJ5Qm6yzGDWR6yQDZKr/dXYi9ExFUbNVs0Qmp2LijjnycYZjfXejdhhQ7Yui1qL53dpDZEFCDzu/s9/RHd6twWr8P3QCRcqaOcjz6QIvAwXavGD4g/FCFSwz8lQdQ9TyqqSsdpCAkLNIhgsZuXtgRYSjDkLZ5rUEVX3+g+uXnX5rdI/6zhPbOyaS1NKEzLoVy4zcGAivrO/BVndwxGiLlsxLDiTbtE4xd0JLjohtGlFlyOZ/oZ7CgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380276; c=relaxed/relaxed;
	bh=8JDjRVYqzUw0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga3yVDrdjTy/exdHErTj2GUIQ4+H3yscmXyEFJrBMouahWvWrHmsCRv/BstlvzXfxrZfUvXKfL5lFC3oTCp8G4Ww/tqXroSjY0JHVeyO1hc/qLHmVIQRjDjwRUEeoQGzrSkbtgtILgRz99n9tCJqN8CF8TODVw3vAIvpekRQFvSSRO4ZIegvqGJhMdQYii7UNVBrmq7oEXXBvVXwBu0XctmL7bSGDlQzFx//FJmViaGWt5n5e8SWg/elTXWIvv8i5jloK6LjcTaY9K+9DfvxhIsekj+qwaXOt+5y9YheY5rI7HS4nr4o2KleWzHe9Zyu91FvfWMTSWLSMhPDwCZNOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EZxmMMjj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=khnSnoYa; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EZxmMMjj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=khnSnoYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvDM2sQTz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:55 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHIMO1962876
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8JDjRVYqzUw
	0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=; b=EZxmMMjjSUe4iDpYendft8KMQIW
	QkTF2YwCjO/T+sAA0lM05BjucwS8gz5p8R9Y3XJ8dt3UKkChO5FXcmzEgXUYh5LV
	0eUM6KrEuBBs5kxP0uzF9gj5GfWUkp6aC6hqAqGb4Rt++R/dXixxZqPa/dj3gjgG
	VIondF8saW5VVamYQkiL3C+emxDxq886FpIUTmNoJIWi8eb7UMiAGOZ2JQ+QMhfO
	/oD7yrZ9fucXcKp59nfpx2XTZ4N06MhaW5AEiuqcHir5eQFTJnqvpTT9lAiTGR8C
	8XHq+Nb3SFVzm1xP/WolzePIlW8KkPNlVss4gLm+VQ3dA98z+xxFZHo6Lww==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4srsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so2123486a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380271; x=1788985071; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JDjRVYqzUw0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=;
        b=khnSnoYa+OKZFZQ4/RzUj2m6wdSIIL5YyhhtdOUmp8h1250LYMjKg72ArUFJTUEYKq
         ZQIF8mZSfJvFTNKfkngXMT6go9iNkre4P7kNgbZFC68xJ8tcDpPy2o2m7QvW0GHVrTBA
         DUt/3Q3p7j6VBRFu9zsZMdTc5ZXwbhj+vfKWX8YY8OaIItJurHKLCzxpZ+RAZ4OCK1F8
         XDnyG0gmvpc1AedN0gzKTj0Vb18J+e4bFhYQpSDcjje4Wu9+Vk1EOTpZLhZugyyb6Bux
         VXgfGDRHi5Cc0D2vm59kglIHnLJttMUlLaQsMB8jNGlpVJ9++EHVRUks9nBoZ5ZUyv5m
         lK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380271; x=1788985071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8JDjRVYqzUw0COQ4lE1cK71GEKSAg7BunK0EkaeA4ZQ=;
        b=n3Aquo40Wsy7e4rVs0EWjev197w6UYjZCtQ7t7eNlwtaYKd2gMbV8X9X+3a6PnWEmp
         dIz8G2JxrAZbN+1x8t2TvW0P/c2fQXs9sLYPNkgvA7eSUh2OKKbuvtVYMfbuc2CDl2vX
         Beu3fEEIiR60kSP4/oajeNcCo3645VU5rM0mJaUxAEXPCk6B0u/fMMB9cbYHU95rGw3u
         7HAMGWObhCSn7TQSCOyrjRgeHG9ParonT/1dFXHppRsuseiui4+vTYVa7XfFv8FSYpij
         PVkS7cfMo0VfpA3rl1kzqawIAM4ZZQHtP8KaG+I0yUTvD004EStobdV6suXy/BbUx0xp
         mx0A==
X-Forwarded-Encrypted: i=1; AKwUvBwCStt34rhTs30ku4OJQzlIE4bQK9dBzzzf6/q+/yAMAITgfSnPFvKcTbkgWrVMxJCoTp1mhEg3IzvvhpU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k5SMfTW2M+7GKT3yWSpG37cXEi48PC0NaGG1LHSdu1nTKJs4J/
	c8kze96JZkBJ/nysqQXcVu3hmmWhV3rqGQT6RbwhYHIctI9a/cD+W4zbFtmo+EOSwiI+mVWi27P
	G5bmHg+/5LbmQvnrJrTPvxQVfAN35nrb9sCnkDjBS0m08Lr8OSTmdcxTJUSd5d2pedY4V
X-Gm-Gg: AYBFou0TCGIMRogNGY0Yb40tZtKqSAxuu0PdjILotixjDia+zZqyCszI77KjtjTFZGs
	OFodmq4XizE7MO6JKiLphxq0kuUFwotURBNQ+PlZEQwC05cj5V4/f7jDrPMnf4j1DUhSZ8uL167
	8abtv0sbHpkwXqAV6wSkYhMgUasrWe126N7lrzoXX+qZdOunhbHheCDP7lD+EWOmXorOJV2oWS5
	uR0N9gRBMXIm8aTcKHSyLtu2uVdNLIKPjm3u1PaK9qdscifuRDUur5/2Dv3OfpOAmLILxB5XPzg
	vrICnnXSIO29qoudD1tDZ04QgIq+x/wbuE+IuGRGiNkb2CFrVSxO+vZLFQHughqAHAalKo/C9Ls
	TcndZ/zZt/8tSVdWVZyPubM0bGYg=
X-Received: by 2002:a05:6a20:1611:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3d9ad9a7feamr11025911637.1.1788380271451;
        Wed, 02 Sep 2026 13:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:1611:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3d9ad9a7feamr11025843637.1.1788380270956;
        Wed, 02 Sep 2026 13:17:50 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:50 -0700 (PDT)
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
Subject: [PATCH v2 7/11] drm: kmb: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:36 +0530
Message-ID: <20260902201640.2024648-8-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX/HOuEvlqEcMk
 +jr+KCv2T0obdn6bEsS3iWq9aEpxcqhU2P3cSrYyN4bdC/b5dW6Q5FFb3TWcOFyFiDSca7idzMI
 zCbVAKQuOYYt5PEnjRIh13CBhhg0uyHkSpj5ITVA7p2A9jNUBYvkTnQ19rj+hk1L4RRcAYXYXMm
 EW6I4LLntkfXRzmh5AhlQCtsriNnjvS/jztqHXd6895jfNDNFtlsfFfWQuTptt9s51RinILq2q5
 OwxwovPTbDwlUzGZkET6YtjoPJ65l6bEiLsnnVq1aeioJBzI7e1x3MDKn8p12SoG/3zrBfhputw
 S0FKcnNPmYc3eGqM1tcxsM+02JHBg2/y+2GauhmFU+dqM/4vrCDSmdgRMW5+1z9kIVhg2saBwdm
 Z/kZiZEDuwf4N8qDdpOp9irDuzzqeiOPqGnLgfa6yETTGRpivSFpelWZAjYjvGxAvXFARkBprTm
 YnkIzek1yplvWT/ISlA==
X-Proofpoint-ORIG-GUID: -Hj4q-JeTxuSiFhwEO8Lk9Q-v4wA6BKz
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a988470 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WgoW8aVLYYFOpEymBdMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -Hj4q-JeTxuSiFhwEO8Lk9Q-v4wA6BKz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX0fJNrsGN6QMU
 3j1xpJtQ2O90uNSPzgiV7lL4drFinp/fWfExNY/tmZI8rYHx4DkLVM2ppeDG2zWmZXj7oAXcKFl
 LulFqfnpjL7B94zs3aUTA1lvA5z0xvQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.
Also simplify the IRQ error path since the release before init was a no-op.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..88fe377940f3 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -140,13 +140,12 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	/* Allocate LCD interrupt resources */
 	irq_lcd = platform_get_irq(pdev, 0);
 	if (irq_lcd < 0) {
-		ret = irq_lcd;
 		drm_err(&kmb->drm, "irq_lcd not found");
-		goto setup_fail;
+		return irq_lcd;
 	}
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -155,11 +154,6 @@ static int kmb_hw_init(struct drm_device *drm, unsigned long flags)
 	kmb->irq_lcd = irq_lcd;
 
 	return 0;
-
- setup_fail:
-	of_reserved_mem_device_release(drm->dev);
-
-	return ret;
 }
 
 static const struct drm_mode_config_funcs kmb_mode_config_funcs = {
@@ -465,8 +459,6 @@ static void kmb_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(drm->dev);
 	pm_runtime_disable(drm->dev);
 
-	of_reserved_mem_device_release(drm->dev);
-
 	/* Release clks */
 	kmb_display_clk_disable(kmb);
 
-- 
2.55.0


