Return-Path: <linux-aspeed+bounces-3158-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B312D637B2
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHT3MPdz2yFW;
	Sat, 20 Dec 2025 17:44:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766154968;
	cv=none; b=KLNZEpjkCiJJPyvZwlc9jIT2g/FvzysqxSWT3/RSrDuoOnFX9ailZeAL5ogJvXN8LbVo3rtCRKzrjP3XEWJRINajG3a9fpCEmRjenEI1EvQBHZDMNUrHx6f3Z5ZQiEqTI6yqIXSYKBpNEsz7EHH6UoMdnwloEi1cdOF72FO4SoGix2GTiiK2TwOrqlX01Yf2cvm51n7/LR8Mt29tskib2V1zTo6pveE5GpOruqGxvTDxbRqa3ecz2s6qW00EQZ3PLwAsf3rQ1FZ04sNCLppXtm61RhR0cEwLsElDoq0A9d1vvHt/iTXsaeCRZ50/prIW6yKRKpwh6sg1hKDjZXnE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766154968; c=relaxed/relaxed;
	bh=QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zx5vvRPAJMf3Y9ATM73xYIEtg5l5XZswzKyESTbuzdEqfMcPMNfLImtJq9qatFRzlj/EDPC8Y7aKzQeOZFhDOrX35Hwp62T80dPTI5b8we5btBkSzY47iz0r0OeOdSBECyWtGxlg23MpLDyCBa9nq/dvvtZ9xgIV+BeOb+Br5wWh/+PZa9vusDSmc5f1JTQMIsEiZ6j2DreAWbFmlsmopYWHxBcHVeTwChoHDycOQH85yIJ8bELKGaPjFah6nlyc9vop3PVx+F3m34WD66x8rLXHJGFRwIYI0yZJ1POPu31TNnBGB1ZVruRo8zdZjH85IMGGXDcus/eBv+hTd7FLEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WAIpjOpQ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XFH50hpf; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WAIpjOpQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XFH50hpf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXqpb53sRz2yFb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:36:07 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBuf0e3701008
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=; b=WAIpjOpQ+PoNwSKf
	y6JtoIF7TqlCyNrzHYGE+yWtSdWoOyxksM5aRSYFA8xjuacFCIiBdanU0xMirIwc
	HvvXytN5sQL9MThx09ocL96j496Kwdh1HT/ShkbLg+avvHcZOQyP0aQcLTJjdjNS
	plwyUlhPM5DGO7yfqsRg7kNjM3mghrWuzrUg4NZSiwgykJ0l3J1XJiVeohj5EvBg
	ZwM7Hk4vg/6y/A39PL5MEv/AFz7koX2K9SDHVI/Su1KtYGcY+uEGI6Nx5NjVhRjX
	TOpKAI0d9aANoZ5kav6OUUVD8dNycvwl6xva9HaolBGgAafQsUkpDV4jOb5etk2Q
	ME8/Dw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ejw1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:36:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee09693109so33642561cf.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154964; x=1766759764; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=;
        b=XFH50hpfMJwd1hJpwDw+8WbvoARH/b+vsdIY8/YHUQI1lkJNSHOR1iSvDPWRLbMfCe
         Id57HYLgEm8EWjCVtDn9pDoIqQTtDmDIl/XY2tanOETsgG+cgWjZCLjzo8OeyDm6l3TY
         jEZo/9RuXjVtJy22XzJzvW5pOZxL5EYoUray7Lnb7aZcmk4r53EqdFY5W7o8CSOhSpid
         T75QBcg/x27QUqjYmzYFRL88uZnJciCXRs1GoGjOgpGhvoM7N2KAbXUgcKc8xzBQ0jOw
         0gpN2lqiKmHgd6vqd0pSgQCUFjHrJHok75YfvRknxmkPR3HvXWAfTcn9a5ITTBpH6V8v
         q1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154964; x=1766759764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=;
        b=to+MvTekfNppgxkUyk/SXQi3U/HaHu6iB6fXLQsXDyoO0GfvczIWvoRd7L3Tc4NIdO
         SRQ8cuMq1J51e2d1+GKE7rP00Lwi4nf3jYOq8nwTyoo0hEetk5ijBn7YUBNHvNX8PRaU
         xgewi3IzAVlnvHqv7EFZOSyfjnOjDGvf0FRzvr36t+AbomTyB8dD2vhwnTplrqLDGHak
         7JXbC4WCWBv4s8fAkGC6wY6Dh2F4g/+v71yFpXUmm459BxEDe6m3slPovJ7rneyMlK/x
         Vn8gzh2zr7R0d3ccXZtzrUILRCWdxfWbgZxjofaXDSLA5opqmcRxAJzg7hJLPwATNuoz
         iBJw==
X-Forwarded-Encrypted: i=1; AJvYcCXyh7WqGlClmtxNuuW+ptarxcZvI9rAx70i2ObThrOFGw5zRTHAAyzZtWL7ZPIwVZ2jyBm6FtGT0iL+/HE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzO0SdH+OSHjur+uDqe/uLo29aIwo1bq/9xDs1WmnZzcJh3GzjH
	fUhgEG33iib9DuMNJjYDubTeqxoXGHOUexlpsSjCfar1PrgyftKZguK37Q6fkcyNJvXIj+M+yXc
	QOzObzOIN6+C7eIkzq8gixwawCGrkVsD2cTMTV+B/w4lQBcfLvw+ooxPgbkokZkoqAEcn
X-Gm-Gg: AY/fxX63+1g8LJWNsAFRgpMoiRRwLZD36nifQFZaZvTKedxn1VEuI2ktPV0ed8vq2uF
	8MSlVZ5fOsKMsTPWdS8KN9dTkC2pSBXjP/I+j5BrK0rhtvvzRhEsXDXC8QHk+6viKwoK0E1E/pB
	aK5mpUkNHJlxj53zOrLsLPaTg08htvgwVOZf6d6CxNSbpcZl+cunQD/mN7dcL0eQerVCXUv9Ktm
	5fzMj4jdqnCVB8F5IH5mJpsDvViHA3+DraGVbRXlHZcQht7yoraRaula1p/UEFBla/S6pRd8WYJ
	Kjwm3uK7bsAsPu+gFDcZ/9gmRXGd5g90wmTZHFBTG/YxZnJ71PHf8cpJjONnJykt4r4Gv/K5K2y
	G3L2e5Jcexb55WlWsCTLOqB2b1LFtr44rC6SSZVLByowIHX9ERhCJyTY7Pd7hJ4UoTzg2
X-Received: by 2002:a05:622a:11cb:b0:4ed:a6b0:5c39 with SMTP id d75a77b69052e-4f4abdc6a4dmr43263671cf.63.1766154964157;
        Fri, 19 Dec 2025 06:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYupEl3gYLzDt53suprXOO0WmjuzlD6rknnropJD9KMCWfnffglHqPJoWvFjr/nYkg2I6ZFg==
X-Received: by 2002:a05:622a:11cb:b0:4ed:a6b0:5c39 with SMTP id d75a77b69052e-4f4abdc6a4dmr43262891cf.63.1766154963604;
        Fri, 19 Dec 2025 06:36:03 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:36:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:54 +0100
Subject: [PATCH 5/5] iio: adc: sc27xx: Simplify with dev_err_probe
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
Message-Id: <20251219-iio-dev-err-probe-v1-5-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=FwErtDRj45YR9+G3sGWpElTdT9H2524MS3PEIg8X+gs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLIBxhyFmOssOsCYuSdWCS+KQ38MQOZRW/DR
 UUjiKlsTFiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUViyAAKCRDBN2bmhouD
 14EwD/9O5g0sKxohmlPbWRb5GCF+Zyv/zhIM4UOKtjqVRmXpwhQlQ5PPhdnKhun24YiM5mVrrTJ
 jazVQ0q7AS3Pd2nhNF4aEli4cGK6v+5tsbY+W+Z0S4brTp60yR3kHRWKRCH1obXF5k//KG88vDI
 utRrA3kUsFGOuVY7/mGT6u70Y3vLUHvpOIePcaw7yO9ZGQDh1fhrk3V3xE726Y05GFCMAGboP75
 e5VMg8CddWKpb7pPw6KRXj6vMp3stkIQKd2FwIKY+ZVmeuk/WbgJCkyb7JgtONVtYQ7HhS5kv5V
 quVBHJXrbe7XoEpzecJg2KoIlIGSd1hkMo3M3rO6eKwxyyDiwo+IbO+1tAiGJ6z94+0rB3TWS0z
 JCwZsFz7fcLYl/27TiOCXPxoBnkGkpvwMCilqcQ0wuG8Na42nRitMIu5+E2veKtiSHsZkYBaOyR
 qHojscW3lXvVSO1PfjMjpFwqaB3byNdUl96aEpaSezOibzXovGjyYtcrkVErlwWYnUUgSm7JDfd
 SuH2bGvlkFDQDgaR7/uudIXSCccjtRXp+GjB0rZJLAgTtoPW+LIukSddD2zmR6Pz+gV0UFqZSMK
 mAbcTZA4Xd+e1kCf+Aey0jp6AP4Fkt9KxCEvNYvSGtubZ60ve7d5mAoLFT1jAeudBulbCHSu47V
 dnwL6XXYday0k5w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: SJRaGb-PEJ5BDVc5fLw8x1s3Kj1O850_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfX+qqGKS3vybkh
 s1fCP6+9pKKFq3fA4U1CL5xnkszbyd4pKFquiUrely+xTypxcGlCv5Q5McIibGyAhZmWDIbr8ST
 Ba11h1/bhS2Pzg/Fuasb2U6kECzBd9fUnTLwF7fuhAYJ4kNJeshDjOOmO6tTRYXILPdVR/gDleu
 vAmyw0L4iZkvf5as6gMrs/Ud0izKH2U6iVmBxw3b0g/Ei92aiYG9XfdXXyEfM29q/3mRTJ+hmU+
 2E+0pSz9bv/ds//ES/WE0mYK/a+l0m5jhXYT3em2LT/9tSvbsBTqESy7w21MZTlPSCu2Gs2YBDX
 fQRpeXo6G+t+PCIO5CX1IA9fUUkfCSEacQkSo7I3vukNr1TN8j4y5E28hQ46F2IkRsPnow8Wh0C
 d7pLOuEISt7Cf0TafRrH+pRH/wKevyg8Yqdvn6bThF2fzf2/pZBqWWOhVXG3Cv2NktuMx33yBMx
 lJlN+84IZdWg10jiT7w==
X-Proofpoint-ORIG-GUID: SJRaGb-PEJ5BDVc5fLw8x1s3Kj1O850_
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=694562d4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cWTT0jPcX04evTyD5nUA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/sc27xx_adc.c | 49 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 2535c2c3e60b..6209499c5c37 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -867,10 +867,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	pdata = of_device_get_match_data(dev);
-	if (!pdata) {
-		dev_err(dev, "No matching driver data found\n");
-		return -EINVAL;
-	}
+	if (!pdata)
+		return dev_err_probe(dev, -EINVAL, "No matching driver data found\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
 	if (!indio_dev)
@@ -879,56 +877,43 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	sc27xx_data = iio_priv(indio_dev);
 
 	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!sc27xx_data->regmap) {
-		dev_err(dev, "failed to get ADC regmap\n");
-		return -ENODEV;
-	}
+	if (!sc27xx_data->regmap)
+		return dev_err_probe(dev, -ENODEV, "failed to get ADC regmap\n");
 
 	ret = of_property_read_u32(np, "reg", &sc27xx_data->base);
-	if (ret) {
-		dev_err(dev, "failed to get ADC base address\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get ADC base address\n");
 
 	sc27xx_data->irq = platform_get_irq(pdev, 0);
 	if (sc27xx_data->irq < 0)
 		return sc27xx_data->irq;
 
 	ret = of_hwspin_lock_get_id(np, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get hwspinlock id\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get hwspinlock id\n");
 
 	sc27xx_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
-	if (!sc27xx_data->hwlock) {
-		dev_err(dev, "failed to request hwspinlock\n");
-		return -ENXIO;
-	}
+	if (!sc27xx_data->hwlock)
+		return dev_err_probe(dev, -ENXIO, "failed to request hwspinlock\n");
 
 	sc27xx_data->dev = dev;
 	if (pdata->set_volref) {
 		sc27xx_data->volref = devm_regulator_get(dev, "vref");
-		if (IS_ERR(sc27xx_data->volref)) {
-			ret = PTR_ERR(sc27xx_data->volref);
-			return dev_err_probe(dev, ret, "failed to get ADC volref\n");
-		}
+		if (IS_ERR(sc27xx_data->volref))
+			return dev_err_probe(dev, PTR_ERR(sc27xx_data->volref),
+					     "failed to get ADC volref\n");
 	}
 
 	sc27xx_data->var_data = pdata;
 	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
-	if (ret) {
-		dev_err(dev, "failed to enable ADC module\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable ADC module\n");
 
 	ret = devm_add_action_or_reset(dev, sc27xx_adc_disable, sc27xx_data);
-	if (ret) {
-		dev_err(dev, "failed to add ADC disable action\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add ADC disable action\n");
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.51.0


