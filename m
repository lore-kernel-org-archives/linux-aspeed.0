Return-Path: <linux-aspeed+bounces-3193-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5259AE6748D
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Dec 2025 05:01:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZQvr6DXwz2xpt;
	Mon, 22 Dec 2025 16:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766327191;
	cv=none; b=C0PjX9l3GTmGx1Re+Dyb2D3JOiGWSGly7hHthe0npGCeKHkoBIspltrMxuRb1xL3sDY/y2rZSv5LITHWi9M7dAbpfw/UfymWmQtHlhLIWdjX3BdnYTYlKP7I/P3cyFt/6HGNWY/nQZuuRSk1OgAf4Oa6C0LTbqjXMw4OpQDd8GizFWbz5UUQ9T7SvgGK+CXnCAhNCqcIgkVeUwu+ya3wKrkl1aEzNcJe+51Dz8Pcl35DCjlX3TfXh2vg2QWeqmTN4S/RVIw+VgFrTL0gSwwjUL83aYGNW++yfYyfhMmu+7sGS6RuClf/OSWOhVgI5nv53STUwtpDAc2rISqmzHrXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766327191; c=relaxed/relaxed;
	bh=cXrQ0eZNLwvaZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6iQ80ErkfkofR//+25GtXVtKiDFnO6expzK4aCIS4xXNoOUwdO543IPQWb2oVLgYX5M7tYf2qAWX5I5dnC+PYMYXawePhS1wUfq9K9kF0gwaBvyYPmxcAZXCV5RzxoqyyvF5Qdt4Tut6tM+j8HINhCaCSS1HblKVcyCysJ1zUYGwnHRJGH5veOFdxZwlP0m/OGpbNgreTWWJ0jh2/C2bvSWFm2h14la1VTe88E8Fqu8h+MOUQjYnyiy5Q7lJr9q1/HSENEJVoEK8vkDCdxn3q5plsHuR40p/h+uT44BKPeSFMX0QxNXgaUo+9r7dmqwUyDjfAFld4zDTeGDVJty5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ESqqQSPk; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NaaN3Wmn; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ESqqQSPk;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NaaN3Wmn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ3VZ2DfQz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 01:26:30 +1100 (AEDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLEHKeV3417951
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cXrQ0eZNLwv
	aZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=; b=ESqqQSPkedBLhNq/E4CyZq1vCkD
	mpS6lcHajHlLLq/IzjSJkGONW3Tznz5HDQnY+sJEDU44RT5HXK84eRAg4auDDsZt
	zLLXjBpYr1sqVkGKeMxBfU+iRF0ltmCP7OorhTUfUIrexKTjYOhdgXO1uRnmTTOo
	RYs66G5eVwg5VkaTjWa76ONagbOYxuX7LJ8ZseR6gac0w1VDbJtk+0tn2mZnS/p9
	RtpsflX7YiFYyf4JPZCHTg4e78dvWbgGf9ImF6xO9beP6TCqGEwd8DVsqpquJ/2m
	X42Ay2Vjkaz7PLsknBt5NgF2+BFa5mxDqxmuCUkOgnZuaWs4fT77J2KgHDA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mubjduv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:26:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d2aa793fso82452431cf.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766327187; x=1766931987; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXrQ0eZNLwvaZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=;
        b=NaaN3Wmnu8uv1BDcWPCwcfmmq8OgQ52gkdt5jL5/Lpi3ymBRwzujZnVUse+S/70Odw
         dkU8LHTUY+SLmhEZg+G2YsAk1NJovDXAkiVdaOPUoijObkzgcV2DXWJ8lLZeToxc2BUF
         RZYUv1I91btVOGuxY4+RakWHFaRiFdLXvc9thkfHTZeqX2wAIWJyXv9IF4fInk40xdcC
         qpJoFy+Hcx42KGWam5BDl08FTzs3bWBO1//AjwOsKZ+/l8jiSo5kEqEJYnP3NQAnr7/h
         rOzBRk21I3fbKUaat7WgSdTorRb2jth9fEXLmRLaf6DFZDMDik1EGhn7pbGYSTKVEuks
         AUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766327187; x=1766931987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXrQ0eZNLwvaZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=;
        b=woetr6IFrrkTXp0B3F8KzTYa+guOSJG6rAK+Lb4Vc/IatxWQKMhbN1ERTMENKTknzW
         2QDvll3PZom7Ues+1/jj7X3fKD0oXbAMClObegHQGAQHYU0rd7y9xbcamVtVmXu4mKad
         mhXbk9NtCihdgPo6hIzmLe0Ldxku2z4aRji+EsqPK3UXBfN11bkxIGZgi6QXm8wZHbBz
         FtKGeEiJbjMG6HA8Lp+QNIzqYFk9k60YWShxyhyJoioRhiUMtFaajFDXrR/b1ofzjnXb
         iysFvktFwu7e8si4MicWNvR52BhTtf7gSY/GM4FT9jntuwgouPrOEpTUmTVrziE3AmvM
         CK8w==
X-Forwarded-Encrypted: i=1; AJvYcCX/qijmD3BRVBmSF+q6IXYaoyBPx1phl4DSDtNoHt2lk/yFbsLokSIz3KpFuqIaxPgbJPw7KVNWLNuEYt0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyL2fmHU42CyfSB57ervnEnAa0l9WMV+EdMcoDjsklDwu3Z0p9W
	51JW+J789kzD+hKByRF9zTj+2qaXBfDmfr8A0t3Xl917/4kWcBi3YAUeSmKntG7vcUZdql5V6mv
	b80YSk6uCFoaOrhSlKkzJCGejOjQifNOzh26SM0NLymjwfce8t6Se97OUqdKcotIwrqmT
X-Gm-Gg: AY/fxX4Ct8osagRzCmwPOiMaGG4pesYUgjcVRYV67VNRQO1jVlYjRjHyxyBXkzFGMqL
	twltwnNMAuO1Zpon5BuGXz8zP6w/zpQFCaP+nltY6htWenLNfy0k8Gi/lkVXt5GOdTO0+7Pbr+6
	CwnsLIsleneKotD9s/goPpqP0/j6gje+Gg5vk9rGUxtVLIB3Nm3fCNeqFiGfM75znEghS77TkdB
	hC8fcstsLRVojpJYMhcAD9pz/R3jDgDwpnZLrkDT2BGErH5F4QnGN+ISe2ofC4pxnS3DesZFrW/
	KQfyAM8a/MLIEeLWFxglORU0DaLzPgz7+lM7PPMyW54NpdP5amhT24ophM4R4WdBJkJA8LnB2qn
	vHMuvfqOhoaBiY0tFKzGqHwwJ/BgVZxGcguoCsNEE/JLo/LW5jwF4qq6M2KdP0YZcLR4=
X-Received: by 2002:ac8:6f07:0:b0:4f1:83e3:bb1a with SMTP id d75a77b69052e-4f4abcf86abmr121194971cf.31.1766327187404;
        Sun, 21 Dec 2025 06:26:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4X1T9bdZZS/qvpRUsFhD2vRTGIBwr1akucMiS/SqlqEtSXJi9+JqEGzxWGbwmBgDxvbN0gQ==
X-Received: by 2002:ac8:6f07:0:b0:4f1:83e3:bb1a with SMTP id d75a77b69052e-4f4abcf86abmr121194621cf.31.1766327186904;
        Sun, 21 Dec 2025 06:26:26 -0800 (PST)
Received: from quoll.home (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm211742666b.28.2025.12.21.06.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:26:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/3] iio: adc: exynos: Simplify probe() with local 'dev' and 'np'
Date: Sun, 21 Dec 2025 15:26:04 +0100
Message-ID: <20251221142602.47368-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4355; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=K0IQtqWX619jZ9YkzBmDaKMoDdmrpKcT02lv7CF+pGE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpSAN7uXaCJu7ZGPqhfs4R9Ef5h9276gYJLaLUY
 YKtXtzQRLGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUgDewAKCRDBN2bmhouD
 1zfqD/wIktSEHD3nlDu4v1bjhJA+iTTRm5qqTc01Jd3T7PEFYcGXDQQwVYANojieNLNhQux9H/p
 NFLX3aSMRGGDEtulqa8DTrHo70IujJZnb2VvTTwdsT1tLHm2e3cIJu2tEdsuSICwS/NYNbpJahV
 BwjaeUk3isJfSeqXAP6Csj3zU4RfoaB92oRmTYaBj3eORohYq6iX/4Aau7uY4KTPR/L2Q979/L2
 oK46pTx6bcGRSMxerNyqWfkY7wFEnldgowWv+xTWy8+zUeEttz+1RTfu/TZN3KMTkwPJo6EQNHU
 cYv/XezRWPAZdmSeVmsNQARSPCZoXtMw8kY5rq3m6NdJaGe/epLes9YKEEVao3TqboDYEtFGpws
 +N1kQjjwOjdRLTBufFRlH7Srs3LK7s7fliDsvr4QC+Ds6HVcj9VQ629ELMv7HOVj5z1L6xtGB4/
 2uHJWxzoPAY0CvX1tuyVHtvXrc9W4i4hAe/dNXmPpkgY4sndzLGcjsLtfZNNSHzRozcPVo3LRmQ
 QEsDz+N1VL2jw2fvLPTeV4GlwIFvlwXk9g+Tp7XFsQroqX6D4OTzxudmqlMPnjJcrcF0tvZMlol
 mMO9nAe9r45SZ0mNUNB+DdalACiMKdZxySYOp6/HwvPbxNagKQxBEAAnkQS2cnW/OIZdKLBHhdD StOStPPzq1Gm0FA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzNSBTYWx0ZWRfX8/JLI+aMbMbu
 hCadaBI17/BqI1g4fHFwCszflQv38wwEay8JgRm13bLXtflbDeZAivGTtYCi2oyuWiRqzAsAB7y
 ywCptua4LqbkHFHIsa8ReEkItAyXmlr4TyIcxVZ9NsaYjuYSy7v1vmyyKX3A+3q8GtOH8LInaEN
 69jeFsGMNd5ydLoEDOlBQsSLDX/CdFNx6QCPNRaKQIiLNQPc2wWMyvEjQgd1ErqujFwFJfl6QVH
 JTQET+1GwFDpzIOxBME9/E3Z2gt6ODicSV4GLH2JNK/KioVQ6H0PLDPsMyvpiWV/xHO3IDxg1WO
 zq+mWDUFikutx/GxppmamuZOYvUTxidzHcNiVR85tB6hQuPpc7B1h0QlQHS917gQPTqj1WifYJR
 WpQ5CK8cxncIqV3VqdR3t4dZwWSPQ7caXlUXTInFXpDpb9CFq4UB5LfEIRgndmhFHggFBHCLROP
 igRda2n2cCROzoPvbOw==
X-Proofpoint-GUID: viXDMOFytsgMXD8MoWFRpVF5NmB0mH7a
X-Proofpoint-ORIG-GUID: viXDMOFytsgMXD8MoWFRpVF5NmB0mH7a
X-Authority-Analysis: v=2.4 cv=KYbfcAYD c=1 sm=1 tr=0 ts=69480393 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XA6BSOE7zRTYN9-09qgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512210135

Simplify the probe function by using local 'dev' and 'np' variables
instead of full pointer dereferences.  This makes several lines shorter,
which allows to avoid wrapping making code more readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/exynos_adc.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 491e8dcfd91e..aa287132a369 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -552,12 +552,13 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
 static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev = NULL;
 	int ret;
 	int irq;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct exynos_adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -565,7 +566,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	info->data = exynos_adc_get_data(pdev);
 	if (!info->data)
-		return dev_err_probe(&pdev->dev, -EINVAL, "failed getting exynos_adc_data\n");
+		return dev_err_probe(dev, -EINVAL, "failed getting exynos_adc_data\n");
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
@@ -573,11 +574,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 
 	if (info->data->needs_adc_phy) {
-		info->pmu_map = syscon_regmap_lookup_by_phandle(
-					pdev->dev.of_node,
-					"samsung,syscon-phandle");
+		info->pmu_map = syscon_regmap_lookup_by_phandle(np, "samsung,syscon-phandle");
 		if (IS_ERR(info->pmu_map))
-			return dev_err_probe(&pdev->dev, PTR_ERR(info->pmu_map),
+			return dev_err_probe(dev, PTR_ERR(info->pmu_map),
 					     "syscon regmap lookup failed.\n");
 	}
 
@@ -585,25 +584,24 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
-	info->dev = &pdev->dev;
+	info->dev = dev;
 
 	init_completion(&info->completion);
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
+	info->clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(info->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
+		return dev_err_probe(dev, PTR_ERR(info->clk), "failed getting clock\n");
 
 	if (info->data->needs_sclk) {
-		info->sclk = devm_clk_get(&pdev->dev, "sclk");
+		info->sclk = devm_clk_get(dev, "sclk");
 		if (IS_ERR(info->sclk))
-			return dev_err_probe(&pdev->dev, PTR_ERR(info->sclk),
+			return dev_err_probe(dev, PTR_ERR(info->sclk),
 					     "failed getting sclk clock\n");
 	}
 
-	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
+	info->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(info->vdd))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->vdd),
-				     "failed getting regulator");
+		return dev_err_probe(dev, PTR_ERR(info->vdd), "failed getting regulator");
 
 	ret = regulator_enable(info->vdd);
 	if (ret)
@@ -619,7 +617,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->name = dev_name(dev);
 	indio_dev->info = &exynos_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = exynos_adc_iio_channels;
@@ -627,11 +625,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 
-	ret = request_irq(info->irq, exynos_adc_isr,
-					0, dev_name(&pdev->dev), info);
+	ret = request_irq(info->irq, exynos_adc_isr, 0, dev_name(dev), info);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
-							info->irq);
+		dev_err(dev, "failed requesting irq, irq = %d\n", info->irq);
 		goto err_disable_clk;
 	}
 
@@ -644,7 +640,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed adding child nodes\n");
+		dev_err(dev, "failed adding child nodes\n");
 		goto err_of_populate;
 	}
 
-- 
2.51.0


