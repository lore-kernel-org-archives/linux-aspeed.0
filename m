Return-Path: <linux-aspeed+bounces-4393-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5B6C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 23:37:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtkR92Bthz3btS;
	Mon, 06 Jul 2026 09:36:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783280449;
	cv=none; b=iI1c09mH9y12bvyF61ge7mMd85BGMcRfut+Q2o0McK6AZ6nQTZc9GJ5nX2Yar4QwwDEbV9MRrDHSVWyqgROQeNTFeShPQUD1HFBOPHJFBLiBGjf6gjcEs8cuJdK2dXkJRSftNt8dNo24l8mXGkFanQA5SjDjYzrOqax1Ff9ACsjH8zP1zLwI5bdCZ+q5gOJ3NxoNTByxxIjE6TX+oJhb/yAow+1qh4v8B7RJVgtcBP1n3ye6JGzNxWujSn8l05lnF0I8hVojA1DP6U91u28OYn4cx30ptzGYyZi6LoXl6joJAE8/VYjYjvZfqWKoAQAGSP+dyxGOlqNrLDBor6rxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783280449; c=relaxed/relaxed;
	bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQJ9la/vulO/mM1P0Axm/5wm96M+pAbzIV2x69P+2OTeZZUlOvvwcqKZZcACbOK9yPdLrsx2ifVJxbKo4GlYf/VslgIODTNG1XzzKJpMBt7kCfmaBos6cgOE421d8+hiKOOMjj1uP9EtxWblIgOLFyU8e2h9WSdQefoX8imdhdSGu4fwBKKLugA2FWH0MgQFnCZnGeLshMXFQFxMieV4WvUAbzRzbHdjGBe3/HdFWd8xj5ZAHWfBbODalHbFZfHYg37n00JuWszudYhPgO0w93iCBOo0AxVDc2fER5UDTtaqW+6a7jtt7CMgVypwl/2zDQZ+EkmwD0duigrplR+2fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lc/WGFTE; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIucv+xL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lc/WGFTE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIucv+xL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtdBn0fmWz2yd7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 05:40:48 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665HiRL52348296
	for <linux-aspeed@lists.ozlabs.org>; Sun, 5 Jul 2026 19:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7OthzF5yzbE
	g8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=; b=Lc/WGFTEsBR6FyBf8pb2q2cTo/S
	IRTkAnMpy4BZluObjv10Ds1+8wWUnkRZLMFnZfxn4lwUf9wNpTCxvblYHfxq/YKl
	Ovc/Cj5jLSEuk8ulecmXZk1CDgTUxGIQtjZKnuWR+K1jUu+ftDDZonwnoZEjSzlk
	ct1xTk+NVIo42IekyeGwdAr5vq+YHarJ6RB16P36dz97W6pvhWCceSyR2czSTYp6
	hSXnIp2oW/ZkZTxzubwpV++50pKMPkSorshnXRFfqderNm50KPgm9F/0EgLX4x+X
	hMm6Gy4Wmztc6y63i7GrlHroXX0TGdaLddDcR9h9VbzCKd2rrL7p6658Gqg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64ke15-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 19:40:46 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88fc985a65so3719792a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783280446; x=1783885246; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
        b=AIucv+xLUQhEsADc0rVsHFl2Adsxwq1j3/LTmRC209BxH9sRzMWd0Nc0gHpaH6mMNj
         URkVavNT4vARWI/PrG/BauYNXo3qBZnYSCoO8g6B9ptvk9b1sSf2lRJQm2wjxh+WFszp
         aCC7E2eAb5xorvATod1BD65pYkRb6hJux/qT3lhzx9l1ueGbuiqCHDHnc7GmTXeX6+7g
         Whvex6qbSMRYjw0kLjFLZ/eWotBF4GDZjU6bahfnI+J8YFM/zLAqTcelnj1QF/fzwsng
         huSeCs3LA68wwHoR4deLS96WyB7dpHMSXeLR6dHoRkgeMhVlIzrdVOHamPSjmRKSGKj1
         wQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783280446; x=1783885246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OthzF5yzbEg8KQGkSEAgoedjCLI4POQTlWuL9KBHJU=;
        b=hRKwjaTXT7zKBL3pumqZ21b12njskDWVhJR3cyrMWkROYwS9FaVMGg9Ta9l+H0b4hu
         GzpNJMnwkVhCIG32RYsYdpv/63yvmLKecv3pGNZseYbWi5uPMzHkjrivrubh2dcL7TMC
         xWZpU7adCC2dNpD+Oua0pktUqFQ784sfVNPnXd44oIokPR3hZNgj47fu7GbluejGv7ve
         SBGFQ1VE7IR/b370kY3EIroBDyvt2AcHosTEUi04N3V6VQh4UoeaJ3ffwd2S+3YQwtt0
         ppDDc0zsO9en08QhY9B5GVoDkI5yp+JeKc4V5otMyufMa//ZaEVDqL04FhRRF2wOojXb
         6+Zw==
X-Forwarded-Encrypted: i=1; AHgh+RrKBq2pj1LCtXbRmVM2RnrBx6IaAtOXgnYL78jLg/cWNILxJUe3njYfarUaP9O+Looi4JnDTechvXyiDlQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YybL5pa+AkBAYRmIoGeLFIBom8NUzyRwpTb66aIqgigL12urtx4
	0m0gBUtlMedi90qdoNgDkycNHOwPq00IxEUxwBHhISxEZRmW+gznmg+PUozwLvaCZN6LLXaI+Wa
	xpWabOwRqOHMY/7p8gruXbnpQgmE2t61RQ+/wNkt7FG36i4r5+IG0nUbOLQM2xPKSBYYp
X-Gm-Gg: AfdE7cnviKusoFRh3AzOEwefidXL5z2I0C3pN+Q60dJE8BZL5Y4c02A9Wk5rJwEMtJ7
	WLrHXIuqO84L42pdePsGQlMBuCSvt78NW0YFj+qWeKuQrUnn0H3QfhHgwGyYRtwTjBSFoBfKruk
	DX5ZNNsViMDAdzfQ8TfD8QuhhTE7MXgWmhWjZu/HCWkSAUCMuGUYYkxzuLRGoUXsCn39UBRd3Zy
	ieKym9nyQipH0K53COxsM29Yy3sTngvI7PSMsC3sY6/gb0G1Ceeetojeo4FyRW2iMmOiwjRnDyh
	FbHmGzQTTfD3xnqcULvdBNxyMRZX81YWylsW28Pwr7FDKc5f7RINknzcpXxyNsEOhgBi+0FIhJg
	y/vQSWbgzE6IKGNZJp+AXUxzo4UvxdjP5BBZpTw==
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id adf61e73a8af0-3c03e521435mr7049940637.60.1783280445929;
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id adf61e73a8af0-3c03e521435mr7049907637.60.1783280445455;
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:40:45 -0700 (PDT)
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
Subject: [PATCH 35/42] ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:11 +0530
Message-ID: <20260705194019.2565498-3-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX7rI9gIZDESqL
 Abo2lD2u1+7qgdX1YoaP7CFq/yTHRAfLXVKdhtNl/pej9+OViEvMKPewRGDbCZ08atP8iboINwj
 6hruFZFYc9QuvJ2cvYLai7mMH9L6sKAFqgh28SmZef+IdkJeylu3B05qCTGC0HlTB5K89RtZbg5
 CVhvN5KJoL2/RnZjczEjgGwRtELuEE+MjDq9TmGBfaGpFRCr93rzr1jSkBIrO97Y77p8SNbQKAq
 tiRARflSCCiOPLDbN3TfJsbEFPVZ3bju6013U/CapnOpPaCzsuNB0S4isJs9n8HOuQqivLuCD/T
 2/zkQtDBzs8ug7elR8pb6M3gH8KZ19WMWW3kswNyquBYcEJoYFQuqAzpl/k1ANivyDG89qDcxoi
 021y3FG7VZrUbx0QrfbeTv0YtC/TTZp/4KNC0ZD9b212A0arZOBkWEnHe1PEjjv4A/QTsRWfARY
 V4QnprsI+7B6j7LulVA==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4ab33e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: bCV4-Pq89dHxwyxfZxtYHfK1YE70Tjva
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX70r+u5G0YAoH
 B557SfZr6SzX7+J/k4aPdVSBI5ih3pKmRcf0Q8Jv6K9tSNSWXofiaDZ4/z0MvsSOp2bEg5dYzro
 hkNp4tAmzPXiv1ah7cRLupQAbObOmCA=
X-Proofpoint-GUID: bCV4-Pq89dHxwyxfZxtYHfK1YE70Tjva
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
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index 44a521c3a610..60576f885acd 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2836,7 +2836,7 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe_priv = afe->platform_priv;
 	afe->dev = &pdev->dev;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_info(dev, "no reserved memory found, pre-allocating buffers instead\n");
 		afe->preallocate_buffers = true;
-- 
2.53.0


