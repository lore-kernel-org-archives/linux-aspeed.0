Return-Path: <linux-aspeed+bounces-4926-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8EC61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:18:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0ZM52ttz2y2M;
	Thu, 03 Sep 2026 10:18:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380267;
	cv=none; b=ltmdY6YAOFw7GyoPgvQfz7DuJV5riEc2nV8ofGdrL0f2Sz3uQeLd039ZcQ8dxxPliY4TdxZQsOCyyHV1wDQVIWzBmEvOJtN0ys37zuOfWcXUrSAwFOARzCia+DlUpyZBSC4wDITZpKtq80y6teaN+irG7INZ//1lx3n4tGwAzUZ5tL/jwAejw4WZs3F96BB6FwKsRrH8hMtDbblLRkXazdsRpQwSdl+COybHk/sfJ7mApOStYKpe3JzRmbmPubT/iXyNbFiKzWUae049g3hKIPuflLC/5lfEBh34AfP2YEkWq9wOW9n/L1hw5nk44GZZhIc88HyLhXvsvPVSTPQSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380267; c=relaxed/relaxed;
	bh=OK2sFiDhiyRA3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+65BPIRWzF6jAG6tTaPiIXwjBMLqTH4soO52kqZUW3xc0w8OBqEhz+cnhujtmdVF7jRaiT6z4xMDp8Ckc4EWvEoFmqkJ7jPLf3uslW9uNMwDXzLJtoBURC2lRGd4WtD/1vD/mhim97lc9sQAwH1dRD/3G0mDWmg1kjh9SxpTUmtBrfdEZhlaUTxqIeic/FLVqkxUSEa2D7U07IPk5loAhRvrgYbPUvcV21RFpIrTx/lH1eWu/3Lab/WW9O06mCFwUmBQ3aIMPIvgZ4n56T0Xdv5xwQwhd240/ckJInXEi+HhfDtBLEvwrbsORrOMa0BUsMnf1XkQ9lRKE0IGfd0sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ow90BtAB; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gB5HNOI5; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ow90BtAB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gB5HNOI5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvDB4ScMz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:17:46 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHRJY2686410
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OK2sFiDhiyR
	A3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=; b=Ow90BtABdKWP8vEEbn7t954tODk
	ed5Gq2vRHg44uxceRgHe+MUJEVNrD99ap0s+2bZYF6XW4NoSCd8zgBNC5nAGSu4p
	BEjjuyFQtErp+hmYy3jBNHnfMce3vvAkcX+esB7Sb/tXiw2X9y4cjF6SKw3DLHZD
	LjpyC1/OTGudejH2Z3Clr5w1WRSCPAn61zsEKZHauIL3buq1FRd2S88QjK27Cv27
	QKMF5hjaKuQhKS+hftXVD8l5aYHH2MT/ANXSyoK6bRvttvI/SpMvtlbBDv7W1Df+
	7juJZTuSyv1yUuJ1cMkdiFnI+aJnGWEGzf5C9bKdKtLgWIthSu091fT0WCg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a855-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:17:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3968dfff779so361295a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380263; x=1788985063; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OK2sFiDhiyRA3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=;
        b=gB5HNOI5lvlxSbSSf5Cd3D+3bo8dhefwu6H7KIeBAQXuM1fX8wTbvoCmMC+7dvDeCz
         9/XkKKkhXHIwIivlTyiSQqr9zsaX8OpBzzoTU0bQtqCjrCR7evNTSvrpAam/JV49Fo+s
         Qf+qY/IGbEho2nTB7JPTXlYD2rCBuv0MJnpM9aRA3oSx7g9oONxe/r4ceXqhaozYaIRG
         d+RMrgT3AFxPvDCKwviCmitLUETBu8uKHDFKcSCz9bTOucr55mCQ3kEon3RicoW7XrhE
         T03iJN6Hkem3ZiwfyiWGlkhH6NDrQJEVS7c5qxZYihHNhR9DygbeVC+tl+VwWVreINZR
         598g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380263; x=1788985063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OK2sFiDhiyRA3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=;
        b=pcuDROEHOl1tDTF6iq2hU9fiu7kjtHNp6hvuVOOnaLZYoV3z4FnosW62QeL5DfQ/m/
         yGMtl+KRBRN4T0kePaDHkPW3PRMFWMnqaH1+VqpfEwRXXxBK/lFcRqTMu9xll5VJTqIZ
         xYLMeVMIyraxzwitOVmvs/LHYGGpHlfQzw/H3ikv2B797b7NHv3FCIjbzESclYTHOnYw
         DOJmRockvIt+OlAMuzerZTbu0JrpFGot4dHBhgKbmyyMXJTutDF390NubszlgtMnfrHn
         VJOINBKfKJQHZeF7kDx9J6MH2fA3qsl3ujrEcwdCiNAX2JkXrbCf/f/PIl0v1vQH1zrp
         joug==
X-Forwarded-Encrypted: i=1; AKwUvBxNyIYk7gsj2oawqVPQ544pBZO2veV0AcPpanyDMXdkOvoMUujArJcZPUqP4O83uCWxl0/eYBGxsTaVFZM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m2WroBO/6DshS2qTykYk7rtCUW+8WSEIe7GEed82fgTUlVG2TZ
	ZR3P5DbiL6feGD8N3reyc/sUWw7pKHOR07YnKMvZAzQJYr18nmiA+ZdqbzWA7yMdk9zmqV1iFVK
	P6MPfiIgO/SaCmFbfqJWSGdWe1dmw1SdcWZl4alhuMd+YTnpCMXLvtKc2TLbL3WOvDUIA
X-Gm-Gg: AYBFou2tFiytRZ7ZrnzsBwEqyjfiSb4/k2cdMK395cSa+LFwK7u1lVvr0vUwojgWx2W
	mxfVPCMvRI7nIhrci7e0F9uiCKG4dPtf7UDOWR4FgbZog46MaFO/RldxTpNpElTipkxq7oCuQQ/
	Q44BamGC6rk0pqtHlI5SiEBL123zlocEdkzrRkzR941JPsDQHmYuE4B9UN/BVwLpp7Ovs9yaKWi
	ImwBp4NLziTezM7TSq2tmGOkvx2wy6GXCUuOFKfTiYu4B0KfmJ8CTadOdD/CxJIJa0pdS1UHnmm
	WxLmekxjMzVwlnbNLq/CvGUiUpPvJQWmyohTjOoR0kBqnogsPvoaHAbBQLxGXJoFNdrvNSYOi4P
	GW8NdbLlYs5IDuElhaHCHGAO9VPU=
X-Received: by 2002:a17:90b:5804:b0:398:9beb:a2b6 with SMTP id 98e67ed59e1d1-39b087e4c2fmr1678971a91.24.1788380262984;
        Wed, 02 Sep 2026 13:17:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5804:b0:398:9beb:a2b6 with SMTP id 98e67ed59e1d1-39b087e4c2fmr1678920a91.24.1788380262507;
        Wed, 02 Sep 2026 13:17:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:42 -0700 (PDT)
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
Subject: [PATCH v2 6/11] drm: ingenic: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:35 +0530
Message-ID: <20260902201640.2024648-7-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: 8mETZO8eE2xX9lwXAZfXuJAYknZTk6O7
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a988467 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=ER_8r6IbAAAA:8
 a=EUspDBNiAAAA:8 a=iWCwWg-Lr60CcT_aNAIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=9LHmKk7ezEChjTCyhBa9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX1gDi8/VFC5Hj
 b1FTlFdX6CvAZ+jO5FhOFu9Br5hNfFOONcCTMoM54IUgTs9i3huRhoW2hlvxgJDMGdLCbsUDy6N
 ly7j/qeiVD3OEgkRuuoFiHELkekOzoJWeu/Wk1kRcnMKb0hYzVToBIHLfq840E5Ovr4H2Oo10+e
 jqhssXTTqoFMAkcA00DjvWKn9NR4Y/OINDKNT6wRqnBphXd0kijYU7h/J/JwT06M4oCjS1O4nK+
 f6cL/PlLpL87o+A7YUO1C9M0ljZ9pOTAFRhjWx2n6WH57D7KAIlIMLHDvZKJIMZcbo9JD/hONp9
 Y00qz3ak4/OXQKQkKdQoB4JsoRTGQDKRjBOsOkqyx3fSYXzVvsaL57qg3n5F7ivNikVSGRqCJmG
 vZXNRDlGWx9F7XfB0vkucvfiU3w1X2HqPig8LlB6+kaNUlt5Y61sgorkGmfSCh6ZXuC4XdRqpHy
 6BzEk0fwyFZ3XLlAQTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX1Cl4UiLBauWO
 hqBbskRpXET1munZT/78RFzEBTp9+PbPB2Km9hDx0lNGEuh5MAdPGVd2k5hG8DxQzEcpPWM0r8F
 pKwGzyE4KbIuDt4qkqzoVbdB/2VOuSI=
X-Proofpoint-ORIG-GUID: 8mETZO8eE2xX9lwXAZfXuJAYknZTk6O7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

Replace the hand-rolled devm wrapper (ingenic_drm_release_rmem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource
manager handle cleanup automatically.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 738a80b2550f..2c4dd6ed2d41 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1060,11 +1060,6 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
-static void __maybe_unused ingenic_drm_release_rmem(void *d)
-{
-	of_reserved_mem_device_release(d);
-}
-
 static void ingenic_drm_configure_hwdesc(struct ingenic_drm *priv,
 					 unsigned int hwdesc,
 					 unsigned int next_hwdesc, u32 id)
@@ -1127,16 +1122,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	}
 
 	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 
 		if (ret && ret != -ENODEV)
 			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
-
-		if (!ret) {
-			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
-			if (ret)
-				return ret;
-		}
 	}
 
 	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
-- 
2.55.0


