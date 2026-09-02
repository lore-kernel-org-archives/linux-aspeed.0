Return-Path: <linux-aspeed+bounces-4943-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B53C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:24:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0hV3fprz2yqs;
	Thu, 03 Sep 2026 10:24:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380243;
	cv=none; b=aqkel+A8j1at8uJ0SjGAr30yLOrARtxXPP9ip3dyGGZAnzfQbnebHMEZRdHY2NmS0N/kbHe7RuMGSUFEWOvh2cickcQWaxpkmhbDQdYocf1/vl+y8T6ywCFCM7igsW2T6QxWGY1L8gbz7LUppcmSIIUoCQDX+t9fpqYVf1wGXCPPs1M5XaPWdXITaPDEziNvTgyS+dApOETOdKQ96vs/79xLtUs2ZyVxo3W5VfeI2hyv7rnWAgZwxz9fICLzEy/NGvRQTIZ5wwskC5b+pH/4BoMj5KFG9+7VeeFWEhwjV+QR4wRWVQ+1ceYDO5ZZ+bjyolKy4lwTqlXkoKak0dQsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380243; c=relaxed/relaxed;
	bh=5pBRbhbzo1PcOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSxN3wyYDDKh9/p2LayQEHHLUcgJZYumqYhirL7NKzbguxUVL87Lu7OHl4GqY1QFR0+jzFRgwrgCOLx9gf0mbwat42M3ghssX4EI6ch5n45uDsZySwbftA9QxhvtBzRnJ+/W6peygg0pRcUFXGjSXoyu1RUEijRlByhvUNdGT/psRxqw/mceAmPetpFU6gRfTLUqpg8qHiVGxbcdu5X7E7w47dkuPH+KsyAkjrPstYSwY1loKnOfFdp1LANAn3VWrXy/IFT3I26ZYF3huUHS5N741yPGQDcv8DGAJjoUJO0EO0nBVLFuhgef3D5Q2ThCnivbKcyxH+EtXlVp39BnlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YH71TVQX; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYDeNPO2; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YH71TVQX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYDeNPO2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvCk6YZrz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:22 +1000 (AEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHKMJ2025608
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5pBRbhbzo1P
	cOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=; b=YH71TVQXwSMcn3Fu/Uff9SK4nzC
	54IULE63yNKCuMTPEd49MGBUR9KKNNIN/QVTquPXtzIjMppcDurhMW02H3mw/HoK
	QpIWWpHShP1aC26/5Elx8gXqpOsaRWjvdKkLXCUSyLf1mZfjfZiZSS4H+mV1c8Id
	88ruhQ6RqKJIryjdqDsY4tS8gLQX3HTIOvazfZQQPjxVQiBY+Ozb/umbSbvelZan
	fwT6i3hl7FkpHSIJoP7vd8T9SpNtUG5AcXWPwBduK7YLtF34TKGVzNjoOtZ3ZMdN
	eB2EhtinE7Jy1HoAhoeMJRx0yJorifYNZ8msk5ykeSvB8lt2qUSCYqN0DjA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemce9wwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so2192650a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380231; x=1788985031; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pBRbhbzo1PcOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=;
        b=RYDeNPO2TUgs9Bc2Bhgf9eRo94Q7rfKR7IGSuxGbdTMzHF4gML0uWfB1eGv5lpNDUn
         QBUOhscInjBjFqWuaAFgpDWyyTSKNgr6LhP2PN3hP2wvt7Vx+Kqyf/9zDVQDaDrabnd0
         jYGt5ZtjZTKZl89R1OkSyz1Ba2f4selPoY/qEG4DLlaYkqJqhOS3VJuAsnePq0L80SkO
         1kY+8+Bi5gmRqzxTVMVk3hnivUcZvqkpVd0w28P6ZTgDV2qPUXz2Z4Oi+2aI8a33PP8d
         k1BQ3g5twwb9OL0UQ1GQS773k01DKFebaLRp+Akf5uUH6EGbjr2UlkVu7F3dvMEx2Cwo
         SANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380231; x=1788985031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5pBRbhbzo1PcOFREec6Gs1n8ea1WgM8d8Z6/KvlnlrA=;
        b=PHLn44nDdlgKPYoeYwgfQ11pH92bj6yllvs+07ZWcRTcuhU9VYVaBSA7XPx1cbhFXG
         wsujumrjRRlOaHQ6QGak3gdBsbKUhBaM2vGvBbac5YawxdFn9Jty+o5H9clCkVnrYJ6m
         gPxb6X9rPyBr/G5VVllIWnRn9ITTowoxTYvIUbwGX++Wsti1hb4gBnVs/sytfqaD7ajY
         6bTs12reuhctWtlmpVFgqmum+MECQjAA2CW1/ONUwNo9zGJSm4bYFrv+yz3csGce2T0l
         KyiIvBasuQdhrjVg197Sig01hl0lGhDTguL0oI2WoYZNy+YkoyCUHC8UmKozUByiSMka
         GjTA==
X-Forwarded-Encrypted: i=1; AKwUvBzvIuCOU8sl+tx+sP4PvgDHpL/q2eFbpTGBjqxHLGLM0j8zpKUJUmmCW32rCAusgdhxNJCRQD70EskDpzs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mBdY69I0519L7LlmqXWS66kWOR6jF3AjRR2lhND6JOr8BqiAxb
	JSxkk4Okid0I6TgXORGB1aoLR/ShaDa1li4d92NgJm5xEVU620XgCRlWtEOtP1w8RjhNC11jv/Q
	u/y1ASePnc36bhRDdhkAZK+9ImZpZxy1Aoe2AYF5uDPRzFikk9deZ+nX3j+fhtvSVT48c
X-Gm-Gg: AYBFou0ZokppIuHwEAM7qOwy9q4+cItcKyPC23HCjgbr2B3p3isSs2ggSDLjRiQZMZa
	o2WhlECT5hta8rQpXDRl1qLpeJCz+nRD+LdWlpWVYUWfViolM5eJCnIf3U9VzCmziPqosO078QI
	g21DDl/R5zxKzbPMQtXitI8QuVU08hO1rAe8N1NQ9kdT3Mbxni6bOTR29VWLUvPHIIaBabYk4cl
	AymeGNyCJkXmQgjiePegaBMK5mTui4XzIVLWTBvJnrxnXLVvS6APfJqli1TF+e3w4guXqhOEpAT
	8Ek6N78K2hQSlGrwblk68Io1HH7t8LWStQqAat+FH7F0pw3Jxk1c/m+WBr6yzIIL3zpfWxgu5yl
	V0m8sakl3FpA63ET+Vdn8VTsigIw=
X-Received: by 2002:a17:90b:2785:b0:396:5cdc:4bea with SMTP id 98e67ed59e1d1-39aedeb83e0mr11608241a91.5.1788380230693;
        Wed, 02 Sep 2026 13:17:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2785:b0:396:5cdc:4bea with SMTP id 98e67ed59e1d1-39aedeb83e0mr11607901a91.5.1788380228811;
        Wed, 02 Sep 2026 13:17:08 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:08 -0700 (PDT)
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
Subject: [PATCH v2 2/11] drm: hdlcd: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:31 +0530
Message-ID: <20260902201640.2024648-3-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX5NOGPMj+Qx4o
 LbLUQcURA5KKghZyIWmhfINkgemhZFNQhIrHQ9px0kMQcVxVYDViCG7S1Z042OladSTXhj+FiWk
 aCGknCILhUXm8hPH5smSvZRx/uVRspSgoDmz1vVepEP5qM0sX78Dmve0VUjigYC2KKKxWOTxYOV
 9UIQVNUjnUhKw+ZcbVd2ECt5Ou/9FgBtnNW4Xq+fHrgMpqwQ1M+YPQvA7vBFnbZnnrM/Zg6CttR
 7ShfnnU411Mk0ESCwPL33xpH9LteO2oFYt9FGBMqUB6XXUinoUWmY+r4qtzJ+ItQ6apd7bL81f6
 flpNHgthCbOKmQqYdGlXRzQ6d9LHPdN+ZdcxXigCf2JScSao8mUNeUpc/jBOtue/qAYM9zQkado
 GinUMyxTrR/gzroTQ/I+oYiKNd/Vj5zRe6qVaVdScj3nZP2VNil86TcRuUCEMNyME1Vg+9yTm1B
 E46UUwmGj8ES7nFeGxA==
X-Proofpoint-ORIG-GUID: kPT3wLceAmI_ZVipyzCNv1YW1EQtG3Y4
X-Authority-Analysis: v=2.4 cv=QfpWeMbv c=1 sm=1 tr=0 ts=6a988450 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=zu8Q1U5i7KxegdXecekA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: kPT3wLceAmI_ZVipyzCNv1YW1EQtG3Y4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX+dmXOs8NMfpF
 NNsK+7R+cIyLoJxx4r4EKYAxiZF2v0jS/HRJqn7JRiZKhvhC0S6wf2m1utMJZzg5QVg17RYxydX
 vID5UQizNS6eFRwdlsn0TGtb9ez5rog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically on probe failure or device unbind.
Remove the three explicit of_reserved_mem_device_release() calls in
the setup_fail error path, the bind error path, and hdlcd_drm_unbind().

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 81d45f2dd6a7..67466fd441d5 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -134,7 +134,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 		version & HDLCD_VERSION_MINOR_MASK);
 
 	/* Get the optional framebuffer memory resource */
-	ret = of_reserved_mem_device_init(drm->dev);
+	ret = devm_of_reserved_mem_device_init(drm->dev);
 	if (ret && ret != -ENODEV)
 		return ret;
 
@@ -164,8 +164,6 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 irq_fail:
 	drm_crtc_cleanup(&hdlcd->crtc);
 setup_fail:
-	of_reserved_mem_device_release(drm->dev);
-
 	return ret;
 }
 
@@ -316,7 +314,6 @@ static int hdlcd_drm_bind(struct device *dev)
 	of_node_put(hdlcd->crtc.port);
 	hdlcd->crtc.port = NULL;
 	hdlcd_irq_uninstall(hdlcd);
-	of_reserved_mem_device_release(drm->dev);
 err_free:
 	dev_set_drvdata(dev, NULL);
 	return ret;
@@ -338,7 +335,6 @@ static void hdlcd_drm_unbind(struct device *dev)
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
-	of_reserved_mem_device_release(dev);
 	dev_set_drvdata(dev, NULL);
 }
 
-- 
2.55.0


