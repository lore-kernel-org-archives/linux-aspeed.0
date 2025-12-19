Return-Path: <linux-aspeed+bounces-3172-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E594DE668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFK23VDMz2yFh;
	Sat, 20 Dec 2025 17:45:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766140443;
	cv=none; b=jdq6ZDEcgSRDpqbJmRLFbCY158pYUCS6cPaP3g8qhCzB5C3gIQbMUU8W6fGbvVPgiDrqNHmQC1Fj1uP/3LgHR60C656OEXNeM1IXrnbhM2wvWHiyrrNC/VjGVKHtaq51HcqKUwH2CVerR+c+jIRdJ3FOessstVT3P8AAFFoyanqD/ooC0FfiAKvf3FwX53i8zbCy4nlxVjwnFeFKYwm31fdjCtDxVnaigofqV7eGS41FaTvHV9XHmUMB1aJFs6ylhmScjWB3V5E+uXeSRwSkSibH1sj4h+Y3oLYmCuOfUhh8sBThy3rMMlDjH0Xo8KAzQ8HpRK5S99pfJefakL8lsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766140443; c=relaxed/relaxed;
	bh=xf6jTbUm0qoyYu8gm8niL1dyfimxXVsufFdZ/b8qih8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dd1GejcQMC69FHPVPWoJUl4Ht+7AJ8XxCOUhcw9UmVjTcLoUDHhid6o/aYpgafGTeQzpMMAR1WxSdutY+oGAPM+wYBxbIpyQUQwdUXjHes7G8g3RKWFiw0WbbLeRS/LU8oJQhxciOH0gaqwOvp/OelDdwoao3+VHk8VlMBntIsJ5ae+65gDcjW5SLlsKBh+iAGZJrly4GYm81lEAfA5qh8C2zwx72XyGomUl1H1+dRTFoAhNMVPI+4SlFJicOO45up44AjhO4PNojItovemc1IF7jvBW9+xtw9BDbdtnZq2piSzZBTopXr2o2YuVuqf4XlJkTNC/+QYyvaAeEcO2YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ffOtTXfu; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxB+5jdC; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ffOtTXfu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxB+5jdC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1316 seconds by postgrey-1.37 at boromir; Fri, 19 Dec 2025 21:34:01 AEDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXkRF2hcjz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 21:34:00 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4cDBG3991646
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xf6jTbUm0qoyYu8gm8niL1dyfimxXVsufFdZ/b8qih8=; b=ffOtTXfujRW6VmN/
	cfHoFdkk+8CHUBWVmPYKg7o8aE7I1ZuY8N4fnbHjpVU2Nh0uygRMsrcM1wkikVZx
	FX7euVdaCfOcr8vjTQsvI9p1KEk4TuDwY1sDBIP6svocPwu5EYBfTXePCV8su1N4
	LYdShGzy5H6y5ofL4W9pybFjdIdWUWegsiwDdcDVX7E/+OEMwAsJi+Z3/WpcnXqW
	AWSC+C8d+ozmpjLR4n9M/xcQxsci8VahzdRJyT0M5w5l7xFHxiakjBUulzCeAqNN
	fV5mvY7/8oFNlsx/JeysK83h7gg5Df46wqlSs9WtgE/zaBt5QnDllvK0d2w4q07L
	HyWNcA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2da6xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0193a239so15454691cf.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 02:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766139125; x=1766743925; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf6jTbUm0qoyYu8gm8niL1dyfimxXVsufFdZ/b8qih8=;
        b=LxB+5jdCBs2J0HoxnyIzpYfpTjwhE4GC4urPtgxLpXTnHh8H7KOPquvTn5RU2vQ+wP
         MpdAyTUaGB2bslOyNVFkt5ZhXNRwzHGMV0e9oTtS4vEnnu1k++NkzQFnx83hI/7RFyj9
         d/8HkXeYOf/O+ygLq7M+3+Nim/wGj4lL0/dWBf8FqmhAh2ncqrhkxE1smo37haXrmyRK
         iW3fFRNt04HviB1EYBSDsBlmrYuJg64yhz2x/9SR/S1XTp8HEqOJXUKQWKeK+OKBbuqI
         sLs66xBCVGkdijKOM22t94N0HogFwjX1zMkOuTNigy5Z5oHTeB3E9MtaoMbu/QiNwXgj
         wwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766139125; x=1766743925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xf6jTbUm0qoyYu8gm8niL1dyfimxXVsufFdZ/b8qih8=;
        b=Wh5rd3Y1KXxpp+duDFUNmv+h4D2hqdxBVrVepNdBbtEx042j4n3X22LOe3aCLzxfPr
         p15fUoKKJ5vMHtIMd+3sQirTIGNNuoMECSEoe3SrJW8tkuJc/jw4+2SKVMkiDxERzToP
         R5rNu3X561ZZyGZcNNIJwUZKTHBFZUtNVbo3XbyDH/K/9xqhgK4Txm2ASr/xS0aspgw2
         YvHDozzQEv1DXF+a8Juh+0YSYQbHdml5uatxXacz3hzBwdaiy59k+ebX9O3l1yBt/X22
         LFrAt+i431OdxeBPc1UtckS7+jK4QfuO9uWzK+KJ+JWAGRfpIZ8qNuSlLtaSPjBCo9wn
         gRMg==
X-Forwarded-Encrypted: i=1; AJvYcCXFUsjn6fe+VKCdBjRb3JSeA5mRI3+h2LUjfenaFXVdRjKPq9TwA6Z2OzeK4sg7zwdCjwrEc9dlHEa1bjs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzuBPUZhnrOk6zlpf/JrDZ1keXh1F8eAwUDyph/Wg9VRKWl6Q0z
	M/YNB7moNC3MZ38ahaWG6tbqO5dHl5u5pAQqyHRli5hkKW1OJgH05229nrSNzi4nf5+bcvDVXDL
	FLIlYI6wH4ZbJKzGEozo1kvQnMALpE9g0/+QXqPsnF07+JjfxgMhvhNt4XSfRlaBhbDQT
X-Gm-Gg: AY/fxX4PmeQNdA2aN6EWKrY6KRDQI4HW4uVvc8NieukbBVpJQ/tCz6NFzoSCMgavUYu
	dCYrUuGJ83i1DmWFScRvgWjVMpxGbiaUIN8g73YArK5Vn+IsCwpMTGFp6nwm6aHJlg5TXeVc64V
	IHwUEs+vORR8MUVj0IDcR99+9Hx4r1B8gt1xnJPLD81M8ipraZGwoauLvn7zHra7tJvIWlkdBsG
	c5NuPxkuzl0jgRrYA9UgZxrdCYtNm3nDFU0dAMixVdCN8yM3JXPRQmr8EJMP10+MEjUFZV+OhtP
	k3AfAfh3GwputPS8QD9H/a82aVel1zAN89jdfCUIUrWQRCrF9qTKzEgI3rdOrLWSPNVt0YtSX5H
	dszEKbzQxDL2zruzFQaMTokKkYZ6rudjpKtDkkJcURKXDZ4R44o8O5ntWbeFCc5f25J+E
X-Received: by 2002:a05:622a:4d06:b0:4eb:a3e0:2fef with SMTP id d75a77b69052e-4f4abd608a4mr31870861cf.39.1766139124680;
        Fri, 19 Dec 2025 02:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGDTlX0iU36lVyLN46KKkoi/rMtiwt+794nHbi6MbHilGuWk3Az/XiiMKPtVYE7ZtJKns2Yg==
X-Received: by 2002:a05:622a:4d06:b0:4eb:a3e0:2fef with SMTP id d75a77b69052e-4f4abd608a4mr31870641cf.39.1766139124235;
        Fri, 19 Dec 2025 02:12:04 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ae2dbesm197282666b.29.2025.12.19.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:12:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:11:52 +0100
Subject: [PATCH v2 3/3] gpio: zynq: Simplify with
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
Message-Id: <20251219-gpio-of-match-v2-3-5c65cbb513ac@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bWc6AXEQzSRq4zuby2A5YtN+WTOqqPth6RtesjMEyLw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRSTttsAJdpejjeAUj4NiuzzKgYQZACMFLFx+C
 +szUIlcq5uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUUk7QAKCRDBN2bmhouD
 19d/D/9ZlneV6zdxdZpH6ooBKxvcs2CfFE4DmO2P6QlNgRQFQngc0HtgVS9m7dRDcQeHfG6yrbO
 Vh9Rzj/M5JyX8L/WBMguqLMiyRlFoNpkaUFAz+dNZzmrDfKl/MBveRe0PQQv4Lju73CzKa+imn2
 jcMHjgbnI64nDc6uvBL602+zdp3QtvV9lC+5j4FCxgqP6YPuW2GC/EDfhliHNS7BXWB9xLjHtQz
 hRsv23l0QVX9IRN9hqCpHMJIXLjJbP/IDwF5YdVcWOC+oI2LNNWrMzgQh+RSJzDn2AHXN69mSx/
 hXIeGz+2ISormsVP6vbw2GcsduTBMSsHnfBoOEnMkbQjRS93Ug9YPULPNW7WZx1thrufKKeHwnC
 xAc+07Ui3nN/M2BzVG5WBAoknrjCwel6npD4XsBkCsIOcvbW6SVhNLiLSfbekXKjbHLHJvgzZpZ
 Qhsl+/Dpo00lHz4g1OTF3GjXiQHKjU6FLX7MYYLdekNym444BwaQVusQe319Ed3R8gTXZTAC1b7
 hJSokvPN0cidBPcOAuPxxdYXQaNDgJgeQ7mE/3OYgEZfqJ9wLGk+qSYaKkRbOga3ZJ9uNM7OlGh
 W+zi+8HzSLNECK+gOiziR410YSFabLi6BeSuRF4vVxd0yt/d6U+MbdLcdvH6+c57e1VZS6g0Nmv
 VNNg20P3w5Ech0w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=AcG83nXG c=1 sm=1 tr=0 ts=694524f5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lsN0KVCTPuDBfKR-m84A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4NCBTYWx0ZWRfX/YWXUN6mDtDb
 5ch4oRP+9hrVGwr9yB8oo0Q4Z1pgSkICwqydrKUUWw29SoDcjejb874sRL5yPEFNjv5drbQrAgo
 4ULL4ZjiXyO4JoLTdqmrsgzjvwspOt5nB5LL0FKR67KR8NC4PMNF5qXzI7T6f5BpLqyvnD2+fZn
 5f5F0LcQpMUGQ5ShX+ovZ3hl6E+z+lAJgIqlGepxxzJ9gIbhJnrdwftI2i2wL+oNCulY2/nWj1e
 89NfJsCwaFLM2bqEDSVQBi9UPT9I3dxSupnbBmFUcoopE15mxKo1bI+l7pAIjS29SvJP8xuUetV
 qs1f8WZza7rQmVGgpS097h8nhjhqSZigZHHgoBlDC8AzYybQ9m0LWHV7Et0Lii7UOlIXij6QQtx
 jf8Kz3earbE1QvFe3PZqPvBo3eX4DB0i9Po6fOCzfOaGAazOzSLUhwRtb4pwQv7FuaIFZYNQz8j
 1fo6twtgYh1qYhG5oww==
X-Proofpoint-GUID: p0cgg_dL7VtX3PerxhdTYgk06tZqhbWJ
X-Proofpoint-ORIG-GUID: p0cgg_dL7VtX3PerxhdTYgk06tZqhbWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190084

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpio/gpio-zynq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 97780c57ab56..d69773318888 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -903,18 +903,16 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	struct zynq_gpio *gpio;
 	struct gpio_chip *chip;
 	struct gpio_irq_chip *girq;
-	const struct of_device_id *match;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	match = of_match_node(zynq_gpio_of_match, pdev->dev.of_node);
-	if (!match) {
-		dev_err(&pdev->dev, "of_match_node() failed\n");
+	gpio->p_data = device_get_match_data(&pdev->dev);
+	if (!gpio->p_data) {
+		dev_err(&pdev->dev, "of_device_get_match_data() failed\n");
 		return -EINVAL;
 	}
-	gpio->p_data = match->data;
 	platform_set_drvdata(pdev, gpio);
 
 	gpio->base_addr = devm_platform_ioremap_resource(pdev, 0);

-- 
2.51.0


