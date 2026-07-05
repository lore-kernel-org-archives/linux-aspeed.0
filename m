Return-Path: <linux-aspeed+bounces-4395-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A599BC44500
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:38:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkRT43gJz3btt;
	Mon, 06 Jul 2026 09:37:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280444;
	cv=none; b=K8SDqQu3G7xFPybp8XSbEp1gebWhLjsoVeh/DkPRJsggOS5EkuJAHB1TWEM+0F+xZpxxni5+uCVQB434rTIsyVMpCZ3vjzKlyizLHdPw2KClwrBEqw8RDfOyk6M8iiZpieqjxCk2RHTU4uigLM8T8T70397EnMZqfZPDzvlKLm9448FQ+xRRtRaphDBApdzwdRveFOMi2TOun0/JSdbER4WlXY/SdAy75Kp4c/fBcTqMaCCe9E8ompSBSupGjJNy1ofGDjut+STOyrJJ+Z8gt7eRmlbsjy25V7caETBL3rIJwYvu3TDFA1VEt8rwuWcHdZl02YTeoCuKPtFJ/3pp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280444; c=relaxed/relaxed;
	bh=WZiFjnWLtnNsmK5dA/42zGQp+sVNdR8iWt1Gg293cw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjB4ZXdBlzeReDuSa7eYh68jcy2R1cQbCiHQNCNZqgw9/6LFSgWjyC1px/nKcpFG5usYtQk1DrJspIpqizs3wnItxlYMGCID6KaPq6jXBW+IiM/ED7bFG5n7xxRuW9uxL8SGyZIvgPkVZjr79wKKqJR54M5pL2UeO1zudZZnM15GVz2KwMSqh5grpmE8/UzHKLpYREYBcGktkn5VmQznZeY58e7ns/AoSc93Y0n+b48Pdm5qLY0LhPp1rVFEToKBW/bPgtiwW01QdRWJ80tzBya9Hf+gNSEk97g/Dh3vxRiQOSBw4dnh1zIig+aefcJ5JYbS1yTMgTYJt7+K78jweA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BbBSGLsA; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FCUbDXc5; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BbBSGLsA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FCUbDXc5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdBg0sTFz2yRM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:40:42 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HiKW62348194
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WZiFjnWLtnN
	smK5dA/42zGQp+sVNdR8iWt1Gg293cw0=; b=BbBSGLsAqnWOATGTpRNCO1gHtgn
	+/zw/8wXZTNlV0J3BkwSreM5wcmTjEIf/OTa3q53G3k+GmVKk2WvAcGb1Ew8Q+8E
	QrpYExNDDivaknI9UzYxo3JTDkbOWqzrVRq+0pWix+SzBwl+OC9alMamMCk86nPx
	bmTcN5MVq2c1dhjwDSCMvlPP+5gNlCOpgfXdThV6SMKQM+0ZTQPkQ4Udmvt+mimB
	/CiyDPPnOPppMy7keT4n98UkPZmn2g6GcpUmf3hrAlfVAqeyUVB9oeO42PhzzgZB
	p0LNoVgtCvusL9jOPJlKPYe4pVrl4XUBs3oqCO5q6awivbcuGKDA559+r1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64ke0x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-385d2703b64so185526a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280440; x=1783885240; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZiFjnWLtnNsmK5dA/42zGQp+sVNdR8iWt1Gg293cw0=;
        b=FCUbDXc5yLntM0E8PgqyY1HDDnIxkeZ5JTXgUX2SkiFTtBPngVScIP+QUx4In7wgjR
         hroavfcrGIeCI0djQXPHkc20jK45w/wSNujUZNgkPLXGl/zY0ngXPYYUAPXm3KbpAWJe
         Wumw9vU7T66kk1KNKnstVLUufgLJCXS1Fw4Hkb5Lc3Gmo+08gIqDwVuq2/70HMZZKKIL
         Poq5jUwgropQhadzU2GV/KEXqit7aPqZNWzVsWSCqT4bMsg9vVAPCTJq1MpqCLMdMqEx
         eoUWn4LQ8ydq/ywscGvilk86c2BOPC8W5Ew6YjAsgAZY2Y4Q4fdNpZfCmmvoG8fNVyvw
         EA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280440; x=1783885240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZiFjnWLtnNsmK5dA/42zGQp+sVNdR8iWt1Gg293cw0=;
        b=im7j+xEun0vs3fen1nSdbDZAA8zA7U98yrvvgjf3tsyy3np4YeP/qMc7cNguZKYlae
         LIpOasH4WtB+4GrY4W5WBQc3r3AQ6Knr52tVk0wBuT3VhqYR7OIt5S2gW9whBwIfzwVg
         VX0i5o2/4OMKQSdtMF7IOItIruJaS5ndus8caOP7lYa4uV2b9c32z+w3neSSiBKpVrFW
         2uiPfKC6TGW4T+SrqgioUvOLTGb0bAJoKDSQ68R0lMBR+hc8LsybsZtMtWaqQUvkr7JQ
         YVv2BNoY7o/A8dsArTRA/yFlbjQm5e9lk1xd7HReBQteAllSfwcCgmIeCLCUNmCyEaW0
         PzXA==
X-Forwarded-Encrypted: i=1; AHgh+RqyuEXT2f2KxovxPjA5lHcy7iFYw118Sf9AGjl8wcU2nzd8tsiy0HgUVnMeQhjKSxiuPRAaSBOToFD9lD0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YywwzdsH7mLND6G8VMgSgSO/BCR+lozI+PtaprGFHr9ZmLqIVvt
	5qe5E353B6x4JTd0vgE9sdC7Th78leNJMfBD5KxCH6GSCfRr1L6Whrtg113ge4drGG2ALxRzdtF
	UNhWRaHFY5huk4zhk6FTre+kaMWxWRh3NAeKYgPpHrssHi0Kl0zCzr7scivoTIkqUk/Wn
X-Gm-Gg: AfdE7cmxXMqGZfCiC0t3gTM+xiZMGYFH37m+RMDBTNP54TAwahGGhTw1JvdrJ08J1wh
	Y+I3Q0CXOw9ep6XaX48K5S4AjIiIhyFdpnpdoGlFH2IVhQoI3nJokE4pcXB+NKqt5EQLfbi65GN
	XwBpCs0mfM9TpmqVQ6vpZBAngd3oHuikS9GMXM2v2LC/vTpxFPraBFf8jz3BDGD6oOisSl/gJTZ
	ze7m0C6au9A2F/+SmDs8Kk2iqqwU8oSmFaothsbPY4WLlk2HVIqdFtyb1bUZ82ex1TMRQtp9GMb
	y4E3YkWtw6LUXaCw4JEAqXYkXjJeC/sUksyec7w2gTjAVIe8aFZSmBY8LHvP7wsuCl179/kdkY2
	oau28gMXnjc3l3+XAkERZ8fo0wmKYFC9eA4IkYw==
X-Received: by 2002:a17:902:d591:b0:2bd:5ae4:26d1 with SMTP id d9443c01a7336-2cacb06f287mr116872385ad.17.1783280439598;
        Sun, 05 Jul 2026 12:40:39 -0700 (PDT)
X-Received: by 2002:a17:902:d591:b0:2bd:5ae4:26d1 with SMTP id d9443c01a7336-2cacb06f287mr116871975ad.17.1783280439045;
        Sun, 05 Jul 2026 12:40:39 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:38 -0700 (PDT)
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
Subject: [PATCH 34/42] ASoC: mediatek: mt8173: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:10 +0530
Message-ID: <20260705194019.2565498-2-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfXx/IJtNMfWO8S
 8I+vS5mVIMQ1j0NmBrxTibaJUG2Tuko9jB7kZfv5QcNNksAqFVMfMhmi0SVNl7hDGeZRLyehHFH
 3BJnEU6p3m9DRzipUiqgA4L3DXBKlfqVM7fqknZUthbQ7BzWzmRjKnfM7lp7xooHQZDwGk8zIBX
 ApcRU0E0/5HVqR4hpuo77plO/CR+ciz6zYuaCGB6IYn0vAMWRda1LQ50KPuLzGNC0XPW7k3C4iX
 Astb0VwuBF13AaeR0v+V+glwPeRea8jsQYAmTixyOptc50AvNjgkSybJesSZ8ethkcCBmKbSyXv
 j86v70sAuvQPzTFVLujr2SlUUJiyhrPw9ZaRZTg/iMBTmqCa8PmCpSvuSfs/DPaKm/94/0js1GB
 Zi+po6UCFbPcBOKfJLOEcKRCQyCu0EX7m2t2w53AL30zp4CwCEYf+gq/W/rCyDej68l9fpP/Sk2
 fJCjjCYno7rYDjMJvcQ==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4ab338 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=2-kJ_DxirqQsj2pPc2sA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vTsW50OK4EkbevAVHB9FFsLyZcrnfmjo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX5uFTvG4OIrzu
 jza/bSqtHcV7AXklBveJ2vDcvvue45e3GrUJAOGRl1v2i+wnJ21UALsf3Ef7Jt9d43lz6bTIW4q
 WVYHWaOgC3nHgt2SBL6gKgaTt5ed90M=
X-Proofpoint-GUID: vTsW50OK4EkbevAVHB9FFsLyZcrnfmjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050212

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 69cadc91c97f..0424d79bc9b0 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1072,7 +1072,7 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-- 
2.53.0


