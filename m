Return-Path: <linux-aspeed+bounces-3170-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2AE668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJs0WbDz2yFd;
	Sat, 20 Dec 2025 17:45:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766141227;
	cv=none; b=L0cvhF5HXitnLu963skDto9tBBZppHo4zHrMx6FNOwFg7ZoChkYfXi6XwOR7I98QBqaduHAV4BsxIOgWVEHrKmeW0hezXUBm4kzWfuapXWOdJGzG3/Gx5awYxYw8iDwMQiiS/5H1WazmL40QjYrlt6v+JpYtCNXqQZ//wBLvarw9Fb0if8MLHAI0V6OtdERJgKg+MjCiRFUcMFxt4PsxTlWkK48+FY8caNsMtjATvY6AIdtQtv76H1nXd5tA5L0WDMZ+mYCwF3VQPMJRWBBCD8yfSOUu8hj4VTT68syqvEHG9bd/Vkn2yvSyronNpigIhnhbBQEkLBrBxBWlvjiFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766141227; c=relaxed/relaxed;
	bh=e11O7WAtQq0V30sjydUBQo6QneVAGBPiSxZEi7Evnj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUlh26zp5MKDmloYKBEAuh4jXnOJ85d+wK2G/fyhsJ523zd/Fl76VJLHrnEpyDxplX0+mEBtLe7l7GjJ3MrQyxxfy/QfNqJXFwwU3UrdxeRSrd6qgZh+YyG9lTEuHFUAsLd6B9I/UTcVeZmgEhBotCcSAAPBAFEBlU3CEQFEsNwk6tR83i0fA2A5O0VptbWdwYbtq3yejpDlqpC9OgRSMI9Vapnr+3myvHZhURFFA+2CiFlpKCyzntA0wZfenZpwDVYAvu+CnZWmsCfQTerCK2hIHx+LIyYYAp8EMkdv/FVo/o0eWWYqNfkF06qmblaM58AVvIj+RrrjJlTwxrv3Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GeF5/jDR; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y25ci8Vj; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GeF5/jDR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y25ci8Vj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXkkL2jJpz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 21:47:05 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c2nh3990931
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e11O7WAtQq0V30sjydUBQo6QneVAGBPiSxZEi7Evnj4=; b=GeF5/jDRzvlTX5tk
	KBeH9RWWuiWLoNcy4OQ0l5vlkkUN2mr9hTQRTfIwV7EYaZWgWpO4Ton/fzyJIYUM
	+faUlY7hnMJlOq0i4fpga/eQ4ZQ/zrWfasFDIF0vyqtKnz4/tHgNoL7TeW5lPdTM
	XrxvU9wwp0PXGU1mT7x2tcKBqHZGtYgCcezB5fLp2+UE3K9gs/Hn7wJNsRkLEEer
	ifcfw1EbWZHqMSLyqGUFAKHnSEIvOumcPY9LDKgdufupaaAze5i4aH429Rn/03EB
	FrM6zGfdfPaAwfpZmWniuqkjRfSTamxX5CMShKG4eR52WsDrRFbyVAeMEEmADSGs
	qxEY/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2da6xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f4a92bf359so22328951cf.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 02:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766139123; x=1766743923; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e11O7WAtQq0V30sjydUBQo6QneVAGBPiSxZEi7Evnj4=;
        b=Y25ci8VjFWtoxrgMNxXy7EaVtPBG6o+k+v02Fe6ZyP1fsqjBbblsrcBacZt2xwSH7o
         7HORUto7/nNBKpUuFcPbYTVyKfN0Ai7SQZSwzyQcaIju3r8+gJI0o8MK/jq5r3Xk5BOh
         4Xou8aUPqJgiiXP6ktrSN/ppAqpq4w77RLfwuDlX+SrcANf7xYqKxk43V1hf/F8qFEe2
         yRrEvxnlV1IKtgXXq5Dltwbd6vdfW5cPBwEJwg1J70EbMiJKTJUlMnbYIaWIJ2jlTKZv
         un/VcJK7QKwOnQK0XPFPyKdGnoPhFxujVqOKvZbu76CbdgRp4r3K4w5wwk+CGCf4W7F5
         /vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766139123; x=1766743923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e11O7WAtQq0V30sjydUBQo6QneVAGBPiSxZEi7Evnj4=;
        b=Vg+4NTCsCHNocf6dsqOt9XRTsQvazmCtATHAPKPtmy0R8qOgpgxSQ9iJxRyP3rvdEN
         A6iJsEjlr9gsEb8UjUfRVUI1I+CfnMLAbHOCgGnlPIqngSX1F3mxRQbpvogH0boesAkY
         MrdV3vg4rm4tdZlEcs61KsRKzNIDRqMm4nd2hI7ws8NsuCJ7yLHaSRzYP2+aWwsOujdG
         +fljRTYh0MRtQECQbhYy+HTft1iwwfLSShwHGg+2hhinr6VZkOYsvhJVRiSqOO3k44W+
         nmn/34U+EmiZsulh/0x1Ueo6qsfPwZ6ZMrL5WUHHkuFXLJ8BHtiJEkoneM7zDX+RJt5S
         kTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzEVIFjEkHeo2kV7WGiRYUCMnz5Hv7+v3KzAlhlekABe9VmpnGRx1ac7/QtQDtcVcvZ0xhyq7wi8BgFbM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqUrTF2+4vRU4YHpZWfcTMJvGESEbtdtP73Y6DFIDXQH+qLaYY
	yOOgTu2dCJV57j0M1QUrOsrj/xd2PeIifzVVPH/vLkrIezekepMF17EaWTk8ihYfxi1Gc0bhiFc
	FjrZlvlgUDeBV16i+JvFcHk473j8w5KeEa+jGguyWB6pQL/10+IZMwzOKIU/ZMl/v6s5O
X-Gm-Gg: AY/fxX5tpwLdXkLHmoeksZN5bDt5WDE4yS0AOcCOvvJDQnnMmBc1w25JMK4cY3iaTmW
	E45QW5iEXSQsRMLO8IAFfZm1hDLY6rAD75Ak3hz95M8gNE81ENLQXuLNKJfZDn0gofzkPPfTWoE
	1PV6+WF5C/q7O8/0Vqc/WUUgAD1qJtmRCt5RkMs0zUYA0MOywf34mauY0+OOV257vu9oH2xbWg6
	p8Yk0AA35/J7cY/WFfz7DEBuszuGjiCH+5Nd0GP6LPBD8iaj0XYbKUrDbIHr0I/6M+YzYQ1/Ou/
	D9889y/XHNC6utYYAlFD8V36trtO+W2yhisTXy8f1Gc2Mfr9IBFKbyyILDh1juxpHotOuK/Gj6b
	GNM4Z0zGimQ/hlKPkCewRq7e/KsYYHq0pSfpYV44vTMnv8WHN4oaQHewsHZCkaHW4HlN5
X-Received: by 2002:a05:622a:10b:b0:4ed:bad6:9fbd with SMTP id d75a77b69052e-4f4abcce28bmr28251871cf.17.1766139123143;
        Fri, 19 Dec 2025 02:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYPgSaCcmPuoSfgXGVgvOFCxSBDDQbQDNSQ7Imo07pG5M/eJ4s1sl+/JwMksm25q0myLjohw==
X-Received: by 2002:a05:622a:10b:b0:4ed:bad6:9fbd with SMTP id d75a77b69052e-4f4abcce28bmr28251701cf.17.1766139122704;
        Fri, 19 Dec 2025 02:12:02 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ae2dbesm197282666b.29.2025.12.19.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:12:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:11:51 +0100
Subject: [PATCH v2 2/3] gpio: creg-snps: Simplify with
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
Message-Id: <20251219-gpio-of-match-v2-2-5c65cbb513ac@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=M1I1B7Udnpxw3kqOUmTDz8mzC1Q9PDPSdhxdkZyTeg4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRSTsTLtOg852rwGRRm63SKoAk11EUA/5yATfQ
 DO+VbDO5TOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUUk7AAKCRDBN2bmhouD
 19BvEACXOJ82lmOwWQMSgzD0/7AV53q93RIe1/uPbkJ700ZIodWgSNwvAQOuJL2t+iJjswOoa+5
 g+KiL3++EVh57qeKMhDO+yZddKJ6FmBBk54v2TYk//064TQLXKrq4uMMrpVAGNUTgdr4Gi5VuTn
 hSbJC+UO9+DqrqjV2LhTfdgKzfcY+eo3i2cECkxN4bt2o9afuPvaDF5tm3Dfd9RT6NeDx7ZIWo1
 jltnNlPO1kBiAyXo5V69KRadK/kq2KwNE7p7Ff8SOgUM/T0yzhLiLWnrEmcA4/2uyylVsf68LgS
 GXAo5JqGkrsUFhwEPqkYrtJWatupgA8Hoh9ihAlQZYOQ8+28a1Y7ynm+cTPJjpf30cefaQoAFj4
 oPNqT4X8N9lQzYREgZX3XP8fa4hQy3aoDPeL8CCmSR3eqq7zZAXWuKXDaiS7GC0rFh2dpQPx1nD
 HpYt6mxmFi99aEZ4Q9nuS+0+hiVhhUqaT0TLTYUAnuz8tsqnGPLLd8U+xkcUe6v4+QHCgtHjOOS
 n8RPq4/pus8WSdRRqeXiCgF1Xd3gtn0DukbIqFOnU5XCIFdtcp38X/5P/UNErhukcsol9d54//V
 O4J987p2MsiD4NhRY/wzcJ9pYnlb2ElML30pODiLxUti7Z391ROqFczfNaRqOt2rjC2ziiZV/g3
 BrFenai+e+qKnFQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=AcG83nXG c=1 sm=1 tr=0 ts=694524f3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lsN0KVCTPuDBfKR-m84A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4NCBTYWx0ZWRfXzSKG3F1eU0W0
 c/Tf6bEaEdADInuDlPb2OxqtEdugCe30oBo2UYJRmfcaRGLlgdlecqpgdB6bzHs49W91BLWkvQN
 PbfrcxfVMIi7FWZaBIMhmIR38u33yhytr8tLy56Q070LyA8f4fsj011hy/8LJtVrc6VGedK5pp9
 XA8rkv+ANWmJ6TNrsy7pHmTL2IvbgBIx/vESOVSpWuMX1YCNLjbiEgeRaUTmtMMkhCnzXsCXUes
 MD4wyr39CvZNr86QhM/B+RW17SUegHPXa8cJ927+O39cCJmyrkuTLzhq3LkcVRAcnFes0eqgSyP
 m2g1utXx7i2GrD2+ZlDMIiVlhnY4/D8hCWvNVUSinS990LC8ddVxR6SLs1/kwaH5e4qNidFzfFu
 6jFaSd6MIdZtVoEkbmkdbwhC3m9t/lBuZ6S5Zxl06zELCyRXD730KaLYOFLuNp8KxrT6n2fD8XS
 BRZuPlvqF1I13tXdbNQ==
X-Proofpoint-GUID: -i44JSGTQvs5bE8dHfGZKTzTWYRArh90
X-Proofpoint-ORIG-GUID: -i44JSGTQvs5bE8dHfGZKTzTWYRArh90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190084

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpio/gpio-creg-snps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
index f8ea961fa1de..157ab90f5ba8 100644
--- a/drivers/gpio/gpio-creg-snps.c
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -134,7 +134,6 @@ static const struct of_device_id creg_gpio_ids[] = {
 
 static int creg_gpio_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct creg_gpio *hcg;
 	u32 ngpios;
@@ -148,8 +147,7 @@ static int creg_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(hcg->regs))
 		return PTR_ERR(hcg->regs);
 
-	match = of_match_node(creg_gpio_ids, pdev->dev.of_node);
-	hcg->layout = match->data;
+	hcg->layout = device_get_match_data(dev);
 	if (!hcg->layout)
 		return -EINVAL;
 

-- 
2.51.0


