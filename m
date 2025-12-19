Return-Path: <linux-aspeed+bounces-3169-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36696E668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJm5Vpxz2yFb;
	Sat, 20 Dec 2025 17:45:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766141835;
	cv=none; b=kYbjiiISjZVX47o5C6BM8WvBVbaNuKR0PGf8vItBRkzoh9iFXMbASBhYBDu5ugIENlWAQ1VbvGnCbtZp1OEM1RXfppPeCqYQim7JWjzyqDOAcb0xy8gkjV+zxn6LQXdMDe9EajysmvpGX39TGYyY+V/A6e0Eru81ysct4VZEsAyv2WVx0sOW6Y3sdbjYwDaEoVk7sgt7qs6XXXqBaCOwmxAkYQy2zhxBAHDar+Z/efx7pJh4pOQDwzIBrbpMV88U76KRLSUh67IPOqLFCw64oo3nfNQsY0etDHBQICV5644yrI13dbKzr8gzMBL3mTko/Aufm+l1Pudo0qx2CFtRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766141835; c=relaxed/relaxed;
	bh=3IDPx0z9gonIKpAudg1HfQLLk1WHlUCJuXDV7vFQm18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiwbHkTo3TkITYKXrS/JiE25AxfNI1wo5yGslrLba9VPZ7IkH1CMbvAgXqJB6KFRcNzteLXyd+7Z3lDSrA76/OR8/BTiSQDtnJFEQyuKIww3TIYOk+kCEp0CP7JK20GSYGbQn8F3/DIP4HTL1jahds/XwoU53849bJcLBrYcTIkDj3i/H61tG5WzZ1s84XW0vQ0MctwmRkhkVkVGXSVEHYCbX5CCkxCWnnc9bCfngwT1YeTPED6s1UEKJXQWU1XgbqpCq/djJuBzBIFuUPAwyc74HsvRspSFIH2LC25lRm4+YmWdO6W++BslQtpqs+eVUuY0uz9HsPf67y/y3y7dGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dfb6VnVo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C/g3bzSl; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dfb6VnVo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C/g3bzSl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXky24lX4z2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 21:57:14 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4cXLw3700967
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3IDPx0z9gonIKpAudg1HfQLLk1WHlUCJuXDV7vFQm18=; b=Dfb6VnVocYk2+T/k
	LWkQWiOsZbC5NpilKGZAmHw1z42Sq2p9K4E06H5gd793Xw7OHM5cCCCvUxY+2Tg3
	oBfDCRDwjRd68Yg3BOSc4jXxx12xKdpK3MNxSVQHxugTHkK7x+BXzZ7oFIaZ84xB
	ZTcdSaJovlVJYSBlMjxebTNVT5UT0/Kfo+u3ZI/4ox/8vopyK1p2/+LzuWHk/R3Q
	W3L4ycnd7dRYriVZN6nANEtfCx1UIdDN1Uc2KWiZ7ynEXRFzRXo/k/EyvxTpxDG0
	EbXBBo7GDru8OdToSlXziNniFUJe5T3w16e8MvzzNDkt/yIYYa7xM6f3uCwRYqkv
	847IEA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ej78f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so33788471cf.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766139122; x=1766743922; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IDPx0z9gonIKpAudg1HfQLLk1WHlUCJuXDV7vFQm18=;
        b=C/g3bzSlSeTH8Q6f+KnRS/dytqjzFugD8u/bHnrg1mWawmMe4+bXdtTTqCnc4tqfjz
         Xs/Zx2FONMiqRbEWcNJYBoSuowAl34nlzNDAQVstACw1gSaAXvVbjq/MmeIw8MKpkd77
         uOigGXmjkxaNXwoh9BjQltpLXFPs6efkNEkJvvcr4nQKf6P5mlLchx3zaMNiLeengX34
         l61EQmbhSohXd3Am6z0L0xSrSeWfXsne8Mmt9LIAzp9q+Td+PactrXyP8Hi0StsbQE10
         4OzgZdVKWC92VMXfRXy1kFVJsCfG+YR+vvqO7/e9omGFwbiMQCaQ5A0vknKP/XJEXRiQ
         S2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766139122; x=1766743922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3IDPx0z9gonIKpAudg1HfQLLk1WHlUCJuXDV7vFQm18=;
        b=AQstebSay2yyewO6G97JlG1whUJFZ/2nGMMLosd47YqhuIcS/iLfjIZZFkZB5bCJUP
         TcGpAPFG5YOXlm7zi7vqOe8IHMZrrhC4HVVOBq6F0gga1BP0ZaIR1hgSBqyoZSBw8JKP
         jLadBcaken309irHKbzz4FqPw1jKaMxFu1xfa8gCO2A3pTh8uFvpUv8hxsfadYI+zVMb
         cXosfng1RBET6ugbe8UmgC5J866fN2WdVN4pJCZ/m1UOjf0GhvB3hNC78K6Mm2rvxCyM
         KRurT0Tsr+rfUGYe0kJISyFQyGq8CHm8Ro4Ia+y9BsAN0QosfyhYrhkjEPfonjYzTc//
         JCBA==
X-Forwarded-Encrypted: i=1; AJvYcCWkWYPOHrD9aX6/bkmLpUY02A2uFr3L4d4+6aABYzPNL5VV/B8ea9bESwTkOOFkKet1HDrABfDIM7c1fJo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwadWktKYgIcw3wpKCMX7ubnXhAV5TKUd1ilRfYAXqMlDE+e8JC
	oSHk91RBUK4q+HPjoe5bY/Qf3qSeLji7TUf34FzBzwnzX8e9adTvuyNgxBli5SKksO9Jd0UIoZq
	rlZBgADyGjj8ZtqbgGm8STNVSHxF1TfqvSCLRp64TzXTuY1sOZPgveAY9CiP9VSQWzmYN
X-Gm-Gg: AY/fxX6EfzgfjpA3O1WjcbDwt1U9QbMbe+P3Tff5te6x5avnDZyzO0nX6XEOcy42i6G
	2paZchwzxuEYbspFTWva6F4GWnYn6HExadJBE8HYFvOelF2R1ompCdOgbP/JAaqaR4MpdCJcpoL
	lGWw+4FxrZhMIdOHGUWew2uD4sLZAGgpnwKc8/LObTEyQrRJWpci4HR41Ni7Z8t80+pNG6yUR0j
	k1cOCONDahtJFEhmyx41W75hJmI2wrei0JNSnwxeKneYEyxZGCmCdipj/A00w2XJIV1YnZAJocP
	u7o1xc1IjuOvkmyLWhVMLMzf23QshTfdYR/X9wlUMsI6vAiwzoQM6LAv+7ZvvajxrPXV+bz4HTL
	wj7K9A6WBzUK6SPVegKqzjxydoT2HDzcGoQrZAkxRO0SwSnzOFImfN3MpwYGzcWkU1aGA
X-Received: by 2002:ac8:5742:0:b0:4ed:66df:8023 with SMTP id d75a77b69052e-4f4abd06713mr31926281cf.30.1766139121827;
        Fri, 19 Dec 2025 02:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0l97mx7gRpuBGwVkELAb9IZ++QtMUYrYZc71BAUyZzA/39KQ8GeAH6JeAS+KeFjHkPHqXug==
X-Received: by 2002:ac8:5742:0:b0:4ed:66df:8023 with SMTP id d75a77b69052e-4f4abd06713mr31926031cf.30.1766139121314;
        Fri, 19 Dec 2025 02:12:01 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ae2dbesm197282666b.29.2025.12.19.02.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:12:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:11:50 +0100
Subject: [PATCH v2 1/3] gpio: aspeed: Simplify with
 of_device_get_match_data()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-gpio-of-match-v2-1-5c65cbb513ac@oss.qualcomm.com>
References: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com>
To: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5qG992duprd04+w1UB0QY0FMcY8BPgFL5D7DrXqV7f0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRSTsHKBoTukEuIPZTVcHUflKv4jxU/jlrejPj
 o+LyWzJA92JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUUk7AAKCRDBN2bmhouD
 1x2hD/9m6Mjy9pvXxQcUsoScFVlVTm2XUP8CZNDyTxQFBeRTYCvdYGz6sUinXcE1aLbjsjp8dge
 nJViBjuaMMgRHw7MazkKB6rZkuYS2qWw7BVroOiKvzFCiAUl5R+GUXB7MyFC2SoYjNddrXC5hRv
 HMhco53HKj8uhLDSXpd/nidu02HGOyPmytRbFqpXL3wTFwv+2mc4ylcmjqpCUVGmsxmMchd8+TV
 f5RQi490gJSx/ORDN9Px1XHP17O04KaX7lezsS0lJusuCHPYJ6G4vbN7G8EDx2ynBlOaGOkUw5F
 R91hcnmqBx9FywIhbHxtOxmh5tMMRteRV/hibT3YXPQ3jte2lRvqGrJdz/lDY/INLXiWxG3Pn9h
 C+NjTopoPbdRCoIa/SFOwrvgHSj+cn4Ft+x4JRdCVojJgNX3fb0VBZIYncM9h5NIIgU8+8G+7vX
 vCA7nyv8l9wZKtsQQgg2wPtPdOVHBtXsw85n3GoXgIU6p+TbRZAZS093M8hY8pMuN36Grz3ygh0
 tgRFetNcDp4PAfRviDpZULwldfbgDiGEa65/IhvgDNY91kQc9UhRqDLWSM05mWas0GKduyzYRuu
 lJ75UZiOtwGScCI1AlLeOeE//DzFel59LsF2yCCppnXNeReU2eyc7r3HlGNjzFyCbmdFuf9YPjd
 GcDDNhb/+sLkiqg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: mq8usRpPenpfrHhMdX3Ztwcj5Yzql_LB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4NCBTYWx0ZWRfX8sevl/Lb12pR
 BND8eEK5herMNfiCp01wXmwGIeTanDVp5BLOMwGm6WS4B91c0ODpQnP4dY8HAFCqWibmsChoC+1
 0UVxqRLa8l47gJnNQAOUlqqJ9tvhpEXknwDu+q8gv9gFtkHrBovFwXtCWwGtl9ijVl2awEXUf6/
 pnAZe1n9FvTpL4zRxHnxGRiPrkrgQ9tcKKjFdS7N8TzjHcplO5gb2psC0RJ1CXo5MFgLlcJuHio
 nrJUx+YBxyeu25m0HKk/GY/AZ02XDemb6sFYlajJFCaZ+B6hSPrxt9M9J3c98wCS+aa4etW4+zs
 skJ74fJObMqJc3fAfqhrYyU1GEM2VctjUku+jsCZIrys8KDeZZYRxAYfjnmTsdT6Rlqs2Cp8uNr
 bNvldeB3e54A0Ts0E3l4PBi0J0s8hqgHRVo4s+AdYsnN/fHx4sp+yGa0Zv3QvOjoEcecyPO2L7a
 hgM+WXlLYeaWcfjfpQg==
X-Proofpoint-ORIG-GUID: mq8usRpPenpfrHhMdX3Ztwcj5Yzql_LB
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=694524f2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AxvInAFV_DmKQgZoSDEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190084

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpio/gpio-aspeed.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index cbdf781994dc..9115e56a1626 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1302,7 +1302,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
 static int aspeed_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *gpio_id;
 	struct gpio_irq_chip *girq;
 	struct aspeed_gpio *gpio;
 	int rc, irq, i, banks, err;
@@ -1320,8 +1319,8 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&gpio->lock);
 
-	gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
-	if (!gpio_id)
+	gpio->config = device_get_match_data(&pdev->dev);
+	if (!gpio->config)
 		return -EINVAL;
 
 	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -1331,8 +1330,6 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 		gpio->clk = NULL;
 	}
 
-	gpio->config = gpio_id->data;
-
 	if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bit_get ||
 	    !gpio->config->llops->reg_bank_get)
 		return -EINVAL;

-- 
2.51.0


