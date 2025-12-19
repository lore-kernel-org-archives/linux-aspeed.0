Return-Path: <linux-aspeed+bounces-3166-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081E2E6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJb3ZkVz2xlF;
	Sat, 20 Dec 2025 17:45:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766146408;
	cv=none; b=IgIt0s1Cxu254Ufk6pGombgtNXHVQGt+FKzmQtabrCaJMb75h6N8krqGzcMD9V7RuHiWZc5MtMdT7iH08f4f7+Xn8jW7O+E5PtAL6ug+IcxfgTqKE7mbGehgR/u5eBbpillGm2dXr4GehL2MTzYvwr2JDdv3I3mgeq6wPS7WlsrZaEkcYnwUKwwPSjqI/Tm4xRZo1AGTt3rmcIiQttnPF9IaSQEqvSz5GfRQnHRLAg7TdSNAbRlSwTt2JRsgA8vJgLfbTZ9qEArdGc226ooXa736mU6KAPN4LXBtv9PtPsw1tTPJRoX83vBaIR+4GO9SyaoKTbebL+Hoocs0RkLmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766146408; c=relaxed/relaxed;
	bh=3XYtkw+nSvqnasmCmZa85drCB060RxRk2PJNPFTL4O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=On6De9bOmf2/w1pJ2wGZAJVXTdVSqf7epB84R70V7d7EZG1OMOImgNYtoiTHnkDKFq1kD/Mwvt067tzAh+MGt13d0+vM0c4/9/uRVuxlIUb73SJpUOG9cWwKchpiQqpge7UmJ/cKf0tcjAiaZwHDZLgr/ua9MHmZfebvysuYlLUBmeVX7TX6BwODy3MsxbKCNg0zOrZA1TXFToaaSs2QuF06j24DxBm4z9k+GZRQhZ3ILhwMJUGp/ivYbI+aBAu9TaMuKqQfcgCQU5fLa3iiNttYz1CNrKGXFceiKyG8ZtqAS5/qKe2UfqtA9YTUXchfcasWkyvxh+Q+ZI6C+mTWXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iNr1hU4l; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dGj/U2AG; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iNr1hU4l;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dGj/U2AG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXmf00m6mz2yFY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 23:13:27 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBAwor4146888
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3XYtkw+nSvqnasmCmZa85drCB060RxRk2PJNPFTL4O8=; b=iNr1hU4l7X6cHnFT
	R7c593Nb9OPsn7XLVFIX9mAzJlNGcLSRLtyQ5/xhSn+o8gAX6i1WWJPcH2nrIJC9
	sK7d+oVdvt6HZrHvHaHcImGOvrzHL5v8nGvoB6wAGJ7RiopmUadqdqPnbPnMXHsC
	TvaYJR2iMNIgMzeIfqsWZAbnKHZeidsDSS3IpmfzpI6TfEeHRLS+lRFD8aWWwPvr
	GpB6XSVysekBH1rB3g68Lt1Jl/1+lozdlht/PUuKFQQgSRIWyjDYLFocJg0eWjBh
	So4Ao3ZgurCNH5OdyGpUk8ow9QLo7v7lcKIZvfYOsdCF4MINyUvlJLzoxqgC2riD
	OsoJeA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2dtkq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6ff3de05so43914241cf.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 04:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766146405; x=1766751205; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XYtkw+nSvqnasmCmZa85drCB060RxRk2PJNPFTL4O8=;
        b=dGj/U2AGZndDRqA+rk5lao0AGOgkgZN4Z0Gc+s/PyDSNxtDrhzvqgIqN6H+hJ/HTVd
         M5fYOnZHGCj8EjQJe4rGKd31NGi2Y2n97Rn0Ew0o63+uej+Thd9Tnog0jm4o+2zIWuMa
         mS5bBPnCfk98Cnn04ay206ZkXZOgcjrAr+oBba8CRCpGdAagL7i4VOldemjCerOE8WDr
         aMD9wGw/MOeX0tjYG00vk8Uycwg7229utrMXoOZokrilalZkjZmH8saPQd8gk8J/ox1E
         cCtisyt234dA9M9nt46mwS7XAFyheX/X98p/eJovZrjAvLytcMAh7SVfi/Fw3wxMQx25
         bHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766146405; x=1766751205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3XYtkw+nSvqnasmCmZa85drCB060RxRk2PJNPFTL4O8=;
        b=It7GaAdy4yt55rQLtSCoCUQbM7Wq6ID8XbQvKLOdN2TEb6hqj1wqvD4p10j993mb4j
         esfAWVSTyu+yC2vkiNw7pKUow9sHWjTrWgXR+9ok/FwhrrfEeOg7lNYQnhpw0i7K3Fxl
         r89O4DQes09n+MlQDhU/Y7t0woC/D0HK3XJmqcpksuwK3OzlCQd0wN3DowtWUuS6KNcG
         Ajk+/xnLmx7d9ChmZblaIwMu9gozdkiIBH/nlISCAhSdnJt2i1cXfzX/g8um+4pmKxEc
         PocoS3OJOYoe7eAr9aRWXhujEdWRfkDUr8Mh3Ehvn+itUQKaKTDP1wQN8YRM/L9+HJYH
         yUTA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4jZI6lEcfeNat5RgdSL9NWUTCWKP+lGbCcTNtD2FSfhJ5ZYHoKdcHa1SNX6CsYZqJgVUdzPN7d8Xxdw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQA6SYQRLqauhIGF8gVuxTJbfuOfFgrPEub/viPEg6HXIYY0RP
	dCmdT1YFsTEUzneXi+n1+C/Ac2kjzITtFLRTSsolN4EoaSydyfU8JJxFBCq8dmHaUz0xxNVZlZE
	YjgzOqHkGlhkIV7GmV/og3WOs3mKFg9HA7U8cn9hupKg3+WuISgbWc4NGfGoUQuuuP7p/
X-Gm-Gg: AY/fxX6vv48rbbbgSTfKmc2j2lyWYc6Z4bLQo3KARGuCs8xHROjMyG9WZfTBFfV+l9N
	ePBcbYPcWHG1/d4FPbN3N4PGdodXDoTfJpbSj2cHcsc9ddcuStMozEUssPi/GYPZZx9SVK9sk1+
	87pEEE4CNm7Wi4eGnvIgAywBfWbdtwV9Li6OmwWALC5wXbQbZpjnGbrT6DTmTn9Pe/TWuyp451f
	gjW9k4bGuOOC75IDXeLlakcJGkyrVrU+I97y707Su0o759IV8bF4BINn6tnKCGXfeTg+NydfNUi
	pRsfnNIA44n8OXQkYPDRWclnunyqtd47rduY172qr2YpubvoejVmIYR5TrP8evSTmr0yKmeiBwH
	JkJ4FzGfP498eu3KP+ozEFl4fFTUxgI9v5PoBwDWWDamrqamzPo+y01b0l39gsi1nv/gV
X-Received: by 2002:a05:622a:5983:b0:4ee:4128:bec0 with SMTP id d75a77b69052e-4f4abdca2ddmr32270151cf.69.1766146405158;
        Fri, 19 Dec 2025 04:13:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMGQ+d3otw2nAPUGtegOYZpq5fCuoKczEdq05H59+XN5udCj/HZS+Tj+OrbXthiwOmCJlIYQ==
X-Received: by 2002:a05:622a:5983:b0:4ee:4128:bec0 with SMTP id d75a77b69052e-4f4abdca2ddmr32269731cf.69.1766146404760;
        Fri, 19 Dec 2025 04:13:24 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f48606sm220309466b.62.2025.12.19.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:13:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:13:14 +0100
Subject: [PATCH v3 3/3] gpio: zynq: Simplify with device_get_match_data()
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
Message-Id: <20251219-gpio-of-match-v3-3-6b84194a02a8@oss.qualcomm.com>
References: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SAxPbvwDZoBTjv6FbalCU3GUYht4QxIdHt0ObCI8jYY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRUFdS1h4j4pt1sNkG+hGyJGJFGsvNTcB3blMZ
 rNX8gjvmSKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVBXQAKCRDBN2bmhouD
 18zpD/9AiimGe5xpPQ48Kpf9MK48t1Iv5LXlngybCeYtF63egJQgavqmurypnZmJ5UsqdmpZNeI
 VNpeXZ+sie8aJrF6q8zsfX5lASEvujZg5t5KuguPsC6mBrXw7TOai3MUAkcwQKTrJA2DEedVwS6
 eoBY4OuLB6+vlDlVq2hV+7Ny5eq50BYT9TUOtMxmY9aFDSDISUUFPMS2IhvazmrTQC6WRUbpr3E
 swDTycu2CyZacncDe+/pN3eaObaNkd/3usuGktzd2qgKiDQkrNNj6fiv+D7KRs/8+SMsnxiuAJ5
 E8qtAtjqyIP+mAjYBQ/Wy2848YdmPoe/X/GTZ7wNsr6AquG2QpbYlvCtaMY1Jf0+Be3zqNQiXNg
 zE31249qxQK4t4vtUhTwbF83DsF1I1zLW/Wil4wDnTAX0sUn0zmBjzmFfh/lW1kzRCDe6xCjDIy
 GXXZP766qt1J7syee9eXYS1R2Nrqd1+ei5kO8d2MrFceF5E4WtJ7oehCBlw50eN7s5jQLSI/jkc
 cTZf7StzG97LFhTe02ucaJ0wqCi3PX+BD1YF+trrU8SGrna2x/febfv/VjTmIuNbHTrCNg8bC1W
 IcZf3O4Ykv9AyR8cd6KCS+LKc99dWOgzR9dO3f9ZrApkMWbuyjPg1BnUSUX+quQDjDLSJ4njy2m
 0JwSRIcLkfPXXxQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: 3atLNBmX6Zz7cw8IInkFKlojZukdVBnp
X-Authority-Analysis: v=2.4 cv=A7ph/qWG c=1 sm=1 tr=0 ts=69454165 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ZCGY6Re1LpNA-TmytnoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 3atLNBmX6Zz7cw8IInkFKlojZukdVBnp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwMSBTYWx0ZWRfX0r4Oh6jh3mzo
 ftXG8maDMitgZSZYy7BYRSLhje6c9nOpazUGNiDezsR47AcA+Exl13I/K5olLvJkNfTBMK+trku
 SjAb9GjteVP6d+7TVtGCmxvAF8s8nVcx839BlMzz31l8WaKaS7dbHjTVeODlKT05vwm1DgZFPeF
 IxFY/7EdaOJDhNkB7yS0a4n2fB+IznLiM60NXrhN+MwYeD0C3kkSWDjarpHSROCe7jPPl2vwp7z
 DlOLTj1hK4uIP76PmQHORtZa+Z2F0nFh3zlD/hor5ZmUaKOVlkZGgqiJL6d3j7Ok1lF0d+nSSn3
 0ZCdhMDgKxFkSsjGockKlerVPweWcgbV8Xhf/cP0OKOtlVItHqxcnfrzz5c/tPo7tPIAsQLvcfA
 KcX7iYc0OPgq+Q2eKT6OZC1yWIPHjJHA9+TLVhXOXlwnIbsilUHNx13v3MQRs146yEmNDAvpGwu
 qzY3IUUOcox5LtMzzlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190101

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with device_get_match_data().

While changing the error message, switch to dev_err_probe() so error
path is a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpio/gpio-zynq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 97780c57ab56..571e366624d2 100644
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
-		return -EINVAL;
-	}
-	gpio->p_data = match->data;
+	gpio->p_data = device_get_match_data(&pdev->dev);
+	if (!gpio->p_data)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "device_get_match_data() failed\n");
+
 	platform_set_drvdata(pdev, gpio);
 
 	gpio->base_addr = devm_platform_ioremap_resource(pdev, 0);

-- 
2.51.0


