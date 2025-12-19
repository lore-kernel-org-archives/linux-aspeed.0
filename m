Return-Path: <linux-aspeed+bounces-3159-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E143CE6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHj3Dndz2yFY;
	Sat, 20 Dec 2025 17:44:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766154967;
	cv=none; b=iqX/v5u9VHv+bkCUKHNq5DxNnejpW6pXW+HbCm6Q1As7JQgYN6IpVe7gDPFgA3Oa8ry37DxdXIwYJT1HS1xU2FpedMoTrN97bcCTg0nwExkYfna+uoOmXzjgtlk3QKJUnPg+ltF9J7Pb7Jiy3ooSO5JPmZucTfvIKXhq7FZedJjxaawIj7DCJn6BFC+RBBQqdUg6sf9nxWFaxrG4mweIxa681wAhIQ5ylbpnFvwLf+V22fBlvf2SlE5OJvf4a/sCjqmah7XH4YQsoTJnx95iMzoBodK08ItlFyWpg0LcHUO16GZbrl5aaULhV0kXwsKHet0wSC+5LWBbYILJ+xJuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766154967; c=relaxed/relaxed;
	bh=mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVAWqkyQ4yIdOTJC914/pSJyco9ODMtCpLoXEIsJvsKgBGD8g6tguEv87vT4wWRYkf6fsZIHVdCe8r0eWK4yHBd02+3uwp7SNmk9KoFukLfY5Qhfb3/KM+8ygj09+zn0gxNCRzigaXT3ElqPWlWUK1RrTxx0FgnJs1zr8v9lZsRGU8r1wurbBFoZA2crQeyM3v65o3/rnvU/65nU3lRtkbOW12R/uBnG8dRy+A6DliwG0+qUyqisgj2k4JskPlLSUt1RNYZl5v+x4V0yiEsTue78plQuGCtp7Ttna1QxMEWLNVUWCVYqVLamHI2CFHm+MnUYti1wyrwy8t9OyKl5yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hnl+K3EY; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hSYYc1Vl; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hnl+K3EY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hSYYc1Vl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXqpZ6yCPz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:36:06 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBXZLR3700755
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=; b=Hnl+K3EYmUsBTOLP
	WKUR+pd29tzWcTrxfDnWjJym0NAIJMvzCAZo1XoIju72SabnOeH+Si/DSk7wWt9D
	oZMehEmfq4xBDwNtTOglEuyRmwgPGYyHIZ7vthx9Cp3LxdC5KHis5lVk+IbGd1AG
	ElFm+04c/XROzRn2bGmyaScKWTM3gcIW8QQFbwXq0V33Q2hFtJKWFfT23mz07ZNN
	1mJGKMxg3R6Rkdy8l9mIR42LL+sQ8vIvQIlYW7l0INl85Z3iYZgIVtFrNda77bWh
	ZjlQAfFoHLQPLMmUG5GeGzRg4E5HV7BLzPrqmLb5/JTr8N3JPKG6ipoSyi13Pn+m
	3fN/xA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ejw11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:36:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee09211413so41640221cf.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154961; x=1766759761; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=;
        b=hSYYc1VleM7teqdalC4kKeIjHSGgb1fvyOt5op9Wy4VZPsaguXpqSfeG5U7nB9gYbJ
         eoe/R1d92TMN4zCm8PQSNfva16FmCZZUONZPBQFR1xk8tUeapr6EWSrmXePueo/C4DFX
         /byxhBOGbcOPhtUbBJx1Ge2mvQPPg3cvAnnzCxdy7uOgYTqVIcJ+mYHc1RLcENSML6K0
         DczzjojmGUBKBGK7U2GQHLpMWMAh4rNurlrdHcamtuMJkNl3TYkZc23Vw+TWgsz6WANb
         8c/OkTYbEGYcwsEQOoL+8abyDjr3CshuM1vC3pFbi0jvCc1It5xN8IIZ1e2rQ6FTOf4k
         UpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154961; x=1766759761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=;
        b=ceCrYOGxwjngyjPf24arzkP/p2QjWJSSZmq+HLDf7FIzeeFkF/otp/qB5rNLQgpNAd
         TcKoHXe9SuWFEcASE1yJW6bqrlcgOs9VW9pGJJLhQEaSnjY1MSHgujXvsZ4DQrVeEFD9
         kQAVanKwCBxoCQP4g2yVc7CIrdjqqmvud3r9wUimWHfLPQs0TAixOo3QdshZTmxcBkn3
         MJJvO0DW+SbZ4xC+Mvp+qWoiSSq4CUv0kSYNpzqxrzXQ0Y2G0SBqBP0w2rbTRTQaFLQ7
         zSh6sopoepFBf/8UQwl8KBaB2+1msgM44qfvTD/3oot+QfpaI9QYOmgmfLcsh2ViQKuD
         8SoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Ud2gi0UMN0NsbAL4QGoM92VgWYxUm/fT9kNxUAHExkl1Aw2T3eIVHPboZN9HK7tHw8b3HrSN1tpxEps=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxuRK0ROqUYvoPKVlOXOA1jyixWP15VuTg7ZvgWRhQfRfKRmYuH
	5RPzRkqxN+7UNuC4mQLtMeUaEk1V//7nXQGEdhOj7Ta0qqVtovI0ALLY8JuP8fhHEP31D9xfmLq
	+rmXMLtdL6G7UhTVdaZl2HVxNb1UBph8LjquxnhPg/ze5NGBZ4gJOcewycordxH7qIIUM
X-Gm-Gg: AY/fxX5UQtAeJZ7I2i7Tjy1JHiND01nSzHoTmzgcM2LO3e6ijYxLbv7HrWqJ5ozb5tl
	/VY7Rpya+75cen/B9dVV0LPM7uIDI+IPhFl5ikR6AKiiqrAki7hjuPBI8J9ch7nS2wQh74ZhKzF
	wnuEgJ1ug4yRTdx4daxWsS9FnWKLKvwAvopr15snhqFqD/ZCydFn4rAe1O8AsXAdJIHNseYEh29
	m+h+JcRiFjZi0iytKLYAPJJxw2vZ0CiSK0pAl5bCDi5CipuVCx18kxIVTqSdxHX8fnHAbStmCWO
	aKbxAzyPV6gcEl661gvorSOWulvogG/4OhHm5enZvVAH+NPmRS5Uy/rAyy7e8dxc2UsY/GlF/dw
	p4qKLXAthBtZNFFlJjiJoAmpDsULop2zvwuM7hPfTjhSyo9G8jzUMIJHSPg7bxGMYMsls
X-Received: by 2002:a05:622a:64b:b0:4ee:4128:bec1 with SMTP id d75a77b69052e-4f4abcd0634mr42477631cf.1.1766154960534;
        Fri, 19 Dec 2025 06:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE14Hdyk6PYivkSsJrsYsK8HqoPfU/tUKnkUGbL/VoSc0mjAxe4s8KppQKyl06O0O0KHLdlBw==
X-Received: by 2002:a05:622a:64b:b0:4ee:4128:bec1 with SMTP id d75a77b69052e-4f4abcd0634mr42477181cf.1.1766154960101;
        Fri, 19 Dec 2025 06:36:00 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:35:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:52 +0100
Subject: [PATCH 3/5] iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
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
Message-Id: <20251219-iio-dev-err-probe-v1-3-bd0fbc83c8a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Wr5/vHqfZ3Gkfva2+k6ouaLP7uADJ4+N3dLFOeSScgE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLGmaXpsHKPVC+KP0GNHBF5FoyjkihTiGxVO
 0Wee7mEOLWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVixgAKCRDBN2bmhouD
 1+tgEACJ9D5sTugYsbqYRRJ6CCQ3oNlqtf0R6GLUE4ytsf+XShS+0sC96+5R0EPmCZpzonwX3st
 rWjZ69pIrqkt8vi4/NGrDPo+3Adjwd+2aLuHyS3q5Zw2Mc1d6E+ZTr5VZuBvmK2h0A/+cLZOPaO
 LGen8z3hLH9M++ar0raTYwYjDOcIXvy/glGwyDie9kEZ0JFaLnCnQHv90k5gUAKx3G3V0zNHs4t
 jVLznzV0/bHuDILNvP3IC7IJIWbHSuj9uucQ452vB0a62/l9JI1Q/1UwDWU4oqSH8b7Nl+J+/j0
 ZmpCOAxvxAAttvndseS8PXRQcwhYfFublNu/KXHm8PcaDvkoPbtSP/9i/dOu1iUvznZfTwSdC9s
 5Smcy3zfm3Bkh4XKngX0bmVZN+5u2QFQAR6x4FrvtIMUKsn39QYc5nz9Iu8GE5RSIHZdPyK8NuP
 yWhRFxNJ6oX2Q1dPpYJO8vcm5MGfYVZC7+N2rCgl5u9M1NPv/8qmnFo+3/rdI5V/h2f4wXQcqII
 kkH49dB7Alz57gNeRKF27a5Gf/kY0/Fev/xjxyf77JZ+p+OUIDtgPgXX7/Oo9vWSkmWez62IGUM
 DRPR+FwkGYwPEUhasoSN5DCf5E0a+8HWt2Gm+zAX0hsAOUYNptE4rAXqrrr5Xxe1umf1ksteQNc
 q+XIrxE906tgOgg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: zi5DVDlJ2w90c5pvcnq8DF53htE_vKKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfXxun2aafX9p63
 TP82uuxGpHKYV5yzZYZUOEKWkh2z8GdNiNz7pcKD9/ZupNXUEAVC/VcLA4oWRuGeHNVFVC7uHp2
 ON53j+Zj8cbeutx4VoDB11f6JZ+yCeQA28V7KeP+nKPLT47JVHvLuBq9PTi2Ljdd4uwReyqQvK1
 I+akytMsUmImgvofmc7iLNuPHHMC7/C8b3PEujc8tKmlLePcQzT/AyQB9yfzZJCD3PEM0oIDNdI
 inNx/7m1IU6IgNCkACMjeQ82JOmkCx5Uc3pcbY4yiwf4JH5t1VpE5z5jH8W3t/D1/a0LZp3HqoM
 xHkFpyKciALaJye57aQIPgf5z7imIcgRYJDShQpkOQ4FY3sAxoCPsXFjB/M1h8SfUzZYdF3zz1z
 Bc8v+R6mUJNDwj6vqQoYPI/o0T+G9fAn9sQY3OkHfXDLF11g/sJZ7ykLbNVBq5F6xcvyaOQf3Qu
 +xj1RZdmdTboNXT0Dew==
X-Proofpoint-ORIG-GUID: zi5DVDlJ2w90c5pvcnq8DF53htE_vKKV
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=694562d1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AYNcBwFTG3nuAf8aWDwA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-rradc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
index b245416bae12..8e75665204d1 100644
--- a/drivers/iio/adc/qcom-spmi-rradc.c
+++ b/drivers/iio/adc/qcom-spmi-rradc.c
@@ -934,20 +934,15 @@ static int rradc_probe(struct platform_device *pdev)
 
 	chip = iio_priv(indio_dev);
 	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!chip->regmap) {
-		dev_err(dev, "Couldn't get parent's regmap\n");
-		return -EINVAL;
-	}
+	if (!chip->regmap)
+		return dev_err_probe(dev, -EINVAL, "Couldn't get parent's regmap\n");
 
 	chip->dev = dev;
 	mutex_init(&chip->conversion_lock);
 
 	ret = device_property_read_u32(dev, "reg", &chip->base);
-	if (ret < 0) {
-		dev_err(chip->dev, "Couldn't find reg address, ret = %d\n",
-			ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Couldn't find reg address\n");
 
 	batt_id_delay = -1;
 	ret = device_property_read_u32(dev, "qcom,batt-id-delay-ms",
@@ -975,10 +970,9 @@ static int rradc_probe(struct platform_device *pdev)
 
 	/* Get the PMIC revision, we need it to handle some varying coefficients */
 	chip->pmic = qcom_pmic_get(chip->dev);
-	if (IS_ERR(chip->pmic)) {
-		dev_err(chip->dev, "Unable to get reference to PMIC device\n");
-		return PTR_ERR(chip->pmic);
-	}
+	if (IS_ERR(chip->pmic))
+		return dev_err_probe(dev, PTR_ERR(chip->pmic),
+				     "Unable to get reference to PMIC device\n");
 
 	switch (chip->pmic->subtype) {
 	case PMI8998_SUBTYPE:

-- 
2.51.0


