Return-Path: <linux-aspeed+bounces-3162-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57264E6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHz6j1jz2yFW;
	Sat, 20 Dec 2025 17:44:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766154961;
	cv=none; b=fsoN4x5mtAFMWleKKQrpz3Q6m3gMqeJWBj3vveFMw2gD4DyC9VSK0PyGN2ufURm09SY9Ja72Y2XmqOcd8THJ2RgpFyb5Y9+640HuarZE1pWvZyNTPWi85cyh0WTtKCBxg7HhCAy6iHWTaLEA8w/5rtyatoz0EnrTWlDB8qcGXRjv7Ub4svZTdVWUZUlNPXBZd2wgj3EGtXE1BFHqHkE9yuCNXx0JDSTm61+uCVX8q1hEPOhveA90bailqPj6K8973OZ6PILJ3VfesR7jdeSgew7au88apJYwuruDKkrBEty9f34VyYG/KeYleRt0S++25dOUwF1rCb/lKuwehtXV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766154961; c=relaxed/relaxed;
	bh=xV7Sj1lP+ipO/vMdQQDAnXh1FyZ9JEzti6vulzMdahc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYdBr3K+7LdGYEEem12aw7X0P0fMjFY9FTirRnVkbk3nmbnGLhiV+OU5XabWntKBYK5XVdG2FU78svBg1havDVYwq13oOw5IS04k3n/XL6QCjz3aEJDxbLoZulRCEQkR6VVenMaDRvKlVvxea7Z6T7Q8THvKsEZhAlzOUAWRAddAwbCO9G6TPC0GahFv6rtD17w/GAx63/Thg2b3s+gvqtowKoZvZt05bD0AzDxizzGf7J9NRfnmz2gsdK0D1JQRgkLPut1HTU205lVFbWxPcGTuXuCeZ/0Ya9oS/511fWR+tX47XV26FqLClRctfLj8du936nT9SmVd/V2ruKcMBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aAO6xiK7; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E2rOP7Lb; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aAO6xiK7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E2rOP7Lb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXqpS1sgkz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:36:00 +1100 (AEDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBlFPl3975656
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xV7Sj1lP+ipO/vMdQQDAnXh1FyZ9JEzti6vulzMdahc=; b=aAO6xiK7B2Ahpu0Q
	tStX64yB/Oyj6iYNxsdek7WORUjXVMmB1EL6+Wo81vsth5sEsUNHmvEBxPaakkiT
	3WXMe9musPUKGR66HMiUIVPfcEIYimPkz8v+nn5K5fZ/ot581KTdLa2XOFf9SC3G
	yKvrcxcYJxj5Zm2LKOXeDZS61VYFmeBQk4w+V48PN/LZSjl4Hvuyy9Rak2s+wL9V
	GRCZXgEVJ5hMXictveqt3ggt1808OhVYh55oeeXcA4/BqHqX8Qj8pBVlO07OmyJI
	tUd5Qv3CNWYPQZF0FaRzPBUdlbC7lgYYqyx6sA3bQ0YIuCRo22y6rQg+MYvAEJOf
	t2aX0A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2fjw2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:35:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b6a9c80038so173520385a.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154957; x=1766759757; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xV7Sj1lP+ipO/vMdQQDAnXh1FyZ9JEzti6vulzMdahc=;
        b=E2rOP7LbS0XKzOEvpR0FoBUm4vwIovkKyX+4ilKBHqQuZhnHvEqB+Xra62g49XWUBx
         2XevDlzixfziy695DnLtVxzvguJQSgM4PW1Q8dUrOhcdlj0C3DbM39z2r2yJIF2UWQIy
         Ckz1U8CO5JrvRYbB2QOFy073swnknrSie83UZMkeZFXuSebCvYhTsPHa+1Qr97n5qP/v
         kG+xPguVFsso8NFC+JdQkHjoBG3qy6gqoH83nX1UP8fx3Ju6RJbiF6wjwqD0CPuN/QKJ
         gNmX5n/5nvkb0yq3WyqtIc45Wcve6fwvVsiB7KxfQvkeox/z66meSBtC0Iu1du/L31+d
         xbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154957; x=1766759757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xV7Sj1lP+ipO/vMdQQDAnXh1FyZ9JEzti6vulzMdahc=;
        b=sfQm0pLSiCMo4JkJ40RStlKHqAvjRBbEUs6RldJKy80LBApFVWOQOY8M10BI5uTpyL
         K6dX1VopJ/fLZi/l2IIof/tbsyyianKVDlDdUedoiarzZpDiptmS1KNcrB495GxGpZMq
         bQEgrh22k+26TDWtMmsLEZ1cqPPrVUOMAGpTPNRkPzhVb1ZSpN9K07pVKBXpLqtuWhWd
         Bz/fBg7rtRXgjRdmZRy/aKfRDNhd4lf13qm14l/h8af1X8o7Cm0fwidXmPx1XOpSKpPF
         e4ZM+XgsJNgOOyWGEpwnGxhgDerohFT9KkcktND+KtlvOlDKlKvL2MhSQyAl47gTp1cz
         3RKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7wbkagl2XJmgY9aeSRX56VSIHqFQaSKiIeRYD2ejsTFB0ZbsAQNpPHIlHsAni9ix8hb6+GbN9GUVCmFs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1lQe80+WU/T3hBFfMrMTU2/4OGbbRcT4axAr8TzvJa4R2Z2aq
	PK7D9756oNduzwOq/aSbyj9qtQQqtL+JZVBeVTMQpUTswmPQ5iTdkdkAE3hBvM2iGwz2C0Y0h3o
	dzHAYYwL+8VtkWWVJVoIK7A8brJUT5ilPlNUanbDwnu2gZ3+fAChKf9VjAjq7LrJmM7b6
X-Gm-Gg: AY/fxX6ljjJF3CaH7A4q7RVWhgDYIcoQeqNk/sLs5gWIfI7Yb+Zs9pdm8+tdb39pDYX
	Q5Bl1ImQL1q4YnBWkNs4SmhK1ycqLt44VaB+BcGvDxTG+gKjiX8qt80BCm4SUuJQvRh+l+vMIvI
	DiOHSxe575Sgwlod5CnwxGDRc0Lam2jdS1D8tBgz64ETZ4NVtYnFedPDtCbyBKJlR/DfFMNU5Nj
	OaOeNkS80FTEGfr6u1qSadplekhJ+o/Kd+iYMZ9ZNdQIg3mxrp1l2TUqO8f4Xq4tGa6HgAekotv
	GdKIZOw5Q9V9LfNzDtuYk1E2lwR5VK5vn0PKDpEoN+J4k4MkDuOrfoCPhUFezEpgseWmgDZO7OA
	x+hkOQ6OxDRMyWt4tYTKai5xn0Ye1dJoAtpmAe1SSjVmnTPtkgL6Xar1UBriO2HzIeQsg
X-Received: by 2002:a05:622a:4c15:b0:4ec:fdaa:b31e with SMTP id d75a77b69052e-4f4abce094cmr43174091cf.32.1766154957158;
        Fri, 19 Dec 2025 06:35:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpXU5pTYf8IAIDbE0Sqzc6Vk3SDvjFDfm4RPQu+aDyXRPlzu/xbQTB4M/gboaQR6K2hZYIIA==
X-Received: by 2002:a05:622a:4c15:b0:4ec:fdaa:b31e with SMTP id d75a77b69052e-4f4abce094cmr43173611cf.32.1766154956699;
        Fri, 19 Dec 2025 06:35:56 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:35:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:50 +0100
Subject: [PATCH 1/5] iio: adc: aspeed: Simplify with dev_err_probe
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
Message-Id: <20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=z3gIGj1oIvvmH82pocqz/4k2PQOnpGa3jr5JHcWhyj8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLEcsg/U41BoWF/u0CzNiG+xeoGWVjGVoXoT
 NfSmwwYEgaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVixAAKCRDBN2bmhouD
 17LSD/9ruRFSUuxVXUPfzteRn2rDyimSpK7gTLu+xZB/8ccc5jh3NFxaTc82kprKc9KeXopFpk7
 sxqJAClDY/CkpObXefij8urEBNLvrMDnI2eShXdGAumF4Re2rxTN2eN4fpTrEsHeVCeRn/GUiTm
 aqd8AWv2WVpUQocZdUlWsHte9x4AyuaQiclWlO2P/+ESmUygqA526P77fL+zqusY8dl1Qx/mLZl
 0Fj9c5zLge/Pdq6xHeypu8XYSNPOeFtFIu4bjKsusMTEzUmFcfEs4PcejG89bsqU21BGciXyuCj
 VDozY6YnIFEx8SvMmhcSZeXZ1hH9yn6PHBevAuaxu4jdUVVhe7WFjiKht6Q/J1KECutkpfaQ7Ut
 /CZjinA1SFtrdElPEAfnk5RXoXjxH8VdVzcEFz/hbgzOR0pDj81MJnNJYyX0wBCFZ6uqWFfQfxw
 foCaRbwDfrobfvdERQQb8brmubRaYWsJPduVobsoGGGm9GCqzCFf8QoqtaWV0vG55G6vnuLCktx
 jK8PiB2fsLJ6Tf8T938FxIEAkBGN799ClXQq6w07f+8xN1d6kqIGHE3RDvu8eVdfqEvu9PEeyKm
 oUutIFIRV+Ua5vv9o5gi4gWG3SfHKRQq+UEMXE1nm7Z8KS7cy4Kymsd/ds1yZD71QXN8clXwwKl
 b/wRwDEQRYvMMdA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=NODYOk6g c=1 sm=1 tr=0 ts=694562cd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dK7io7gEiNwTpUlzFjcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: BKDIaAxAU6t6sCBN4g1Ikvmm980cY5rp
X-Proofpoint-GUID: BKDIaAxAU6t6sCBN4g1Ikvmm980cY5rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfX2BlAedKQmGRp
 6vv9qbQnX0z9qSd4q+bzED8v0mnW7MwGlbjiITwhA1buZjXjWYLvVAaJqBLMxKI+u7nVvQ6etgT
 wF6PQ4EMTONJuPqUn9ld6uCftcg2G41Bu4z/7WXRfGSVepJZ9IkBi6N4J+rWnS5XIvffBvIi5kh
 npuAcAKxZM+XGqwHvGTeHtw8vqBzBbCnEGfkrAxbd4aGVrxg/7XBPauBDnjdi0294JVsn1S/n3p
 jZuRZW7oykcR+RvzDLGSrVwZHt4aOhB1aW/Hw0IWRQqn6bUc3Yj0cBU1VgnJTomNp85J0nLZbud
 ET1gg98vketWudVoOCYoFIY0frtTyA9+z6sAiSfL7SRksz7gjByX0dywLYrmjS80e+UhHFKrlZn
 RvHbDL+fJRzcF84Y7mC5A2hThBgLgNjEsRhPSlXoQJ18+xKYTBsJiXK4XBlgmYhY4f8dbi3KEpW
 DGIcV2e3afr58wxIk4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/aspeed_adc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index bf2bfd6bdc41..1ae45fe90e6c 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -535,11 +535,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(data->clk_scaler);
 
 	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
-	if (IS_ERR(data->rst)) {
-		dev_err(&pdev->dev,
-			"invalid or missing reset controller device tree entry");
-		return PTR_ERR(data->rst);
-	}
+	if (IS_ERR(data->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
+				     "invalid or missing reset controller device tree entry");
+
 	reset_control_deassert(data->rst);
 
 	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,

-- 
2.51.0


