Return-Path: <linux-aspeed+bounces-3190-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D02D711D5
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Dec 2025 04:55:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZQnl0ZBtz2xnl;
	Mon, 22 Dec 2025 15:55:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766327193;
	cv=none; b=ZmT6+HUv1hzOp6MnHmNQbp3KRN8giZjo3ETr8/6WBv4Q5mZz1Ij4lyO3mbkFe3rI4LOSxguM252UxAlZm5fLJTtN3GIzdb7H9oZ0rAZ1xPwC6kVyvwUn/sD3jzyDpQuxpWH1xtsWNqBahqXSmeLyEf9NcILoSyqiZVlHjedqROfB/SNxaNPEM3gLG2vGvybari2U5ErWRpIoSQ5Qa+uZw+njI9CmbvSI4SRRJgc1l0SVdw7CO2mv716ZPlRSZcSmbegElYrDESoqMiP/EqRHNzQLR5NXoRNv5j6NSDACB4Wm/LBjt5dzd7sUdPxbT22w2GM4MIJloTghDEgFlAP9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766327193; c=relaxed/relaxed;
	bh=N/Ya93eis3xqRDX4t6fcfXGbB6PyZ7xS9AaL1hTAB60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg7nYP6GaxfVjg2O/S2dNp9GT52EltmJahrAhcGluFXaEW6G+Bvubjs6XYGV5JieZLFJw3yYIlxozJ6SpAfG++3wfZ20IyhkSr0RjsU4YVMlg3PmnMeuW6Wb0IdM9vIBxsNys7fL+INmz4O8JlKkIex8NZ6g8UmdTfpdcDDbIczJOH3WjYsqZgzfbfblonyJTf4c53MNS1ryjqhse+I7OjZ6Lj+BM2Kc/5C81CsHcqYULz0+wi0QSPW4pd7DcxI+EIlJ5gA+PAgshfw/xx/Y6hQKP/6/Nak50BtiUNYf1OIOFZ+Q3ZDDrJSon7L74hgXMRonaPfMxTXX0+c+dXEnNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FsRh4ae1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XzllJm+c; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FsRh4ae1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XzllJm+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ3Vc6zksz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 01:26:32 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLDMati2683715
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=N/Ya93eis3x
	qRDX4t6fcfXGbB6PyZ7xS9AaL1hTAB60=; b=FsRh4ae1DDi063NeFL/u8wjoPkP
	sN1VrGwgnaX/DgnI7mD43o25xSS/xFHXShyTridFFdVWZpPGo84Z/I+LjFv9ovDj
	LLyfTZ2ABPhXHSYNckKztW8l8a3UJSlHgeLHe55Y1Of9CDatGM4/RVVbdWGkp0vW
	osM7k2noJ4Oy5Vp1hc2ki10MluXc7IarvuJ1FydPxHvsxH1vGeAU8WrZ9VJ1JMYi
	ZJGz7keslpPULe87+fC4PKckLRziJA+8v5DskpSKLSXE7UX1U9iI8OzlTmIJAR6/
	/BejovyYdwu0O/Q7DM+unaC50m4e3+4qmFq1whpSy7K9Bz+hJ2Elux1atdQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry2dn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:26:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74e6c468so44372311cf.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766327190; x=1766931990; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/Ya93eis3xqRDX4t6fcfXGbB6PyZ7xS9AaL1hTAB60=;
        b=XzllJm+crZ5pu4/nZp6mj5ZlxUmUSPEfRnts3tXSEVp1KvfcFMlaiugCUugqm+lNqC
         6m2nDqp4zwvDqyRpU9/LRZ2mhbwlCgQcvTZSnWz+zZ54zN/6YBlpyaedVK9xp8X11JF4
         q5KqccT7lTdlwp5nCyy/oXsc288FRmYuU6JcMeU8vh6DXSu1a8z2OcD+zYVkHpQx26Vm
         LJBHKhr8TIgULiDj7eJJK+jUX1f8LAcIxQxZOvMHO+tW5vtU5+a2tAZ8C5XPoQd9G4yc
         B1p5QFNnv7a5ZdJ3GJdtAWIspZXXvsW6Dkkq1aFysXOVyvwgbUOnU6uhoSRXmXRZRL0P
         JD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766327190; x=1766931990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/Ya93eis3xqRDX4t6fcfXGbB6PyZ7xS9AaL1hTAB60=;
        b=K/q96bt6ehFSDzsmvzhsitLSiumcXchB30R9PNqNVBykSJYlHOYxZtToXMmR2O3RFG
         qQdBnDNx7OaCoZmsGTvJ/STrHnX/cjCrV1dUk7/uZybk3PRZKSpirONhY6id+FV0Zund
         FFTq2LerRVY/35CMdSp4E9HSRMMfp1/727kB6fMvBP3WvdBb8IlmEGHEnLAtk9mK7x9a
         tvAGmcQw3iHx7kP7GPlbeXUHffgU3ha/3FG/MpBfz6KaBqNrj/mwZEKNfOVadYlvMW7x
         f1+T4lczzEeTd1NP+dtxn9y30Gk8AbvWX1atgmvzpuyLwNVXbhAzfk9qOZh8KdCujrEv
         Qdxw==
X-Forwarded-Encrypted: i=1; AJvYcCXbanC4ZpNfkd4LWhFQFDDPBhvYsOdIDtqebIO+MWgrBC7QjHsNEztbpKhebPUIhXxCLmolR9qISZyVNHE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0CK1fTcujLz0cLfalHDLlp/Kk6+CBoKcw1wELQF458Q7Bp7Bn
	GAjJreryI51shmiD0pIaZe3ioZAMN/Yrgwi/V4q8R7ujUIdsrUWh96a8Jg11pPVWnKyAUT/3qde
	ab5MT0TpWSFcLOL1x7rv75dgyQCCyuZ6joSEsjqz02FngmBrWgypAdjfM6JZXftfLGvTa
X-Gm-Gg: AY/fxX7DxI25qzrbKhLMwXwYdYdeDeXk+/8JEwomkZOwxflfmU3/3RrDKJO7OCNDHyX
	YjGR8GjkVUZRDmFfAhksNUrPtNfSrtF33YmAANks9J3Zzo70Uga0+q+ur1G06W2mhEMwDeFM+Xp
	5+znjnqSMOvDFKwsAnQpeKhSHf9JedWqiIU78GQ1UVCCeJv/Rq3vcNEI8pC5j0ezBiA1x0+H/OB
	otVff2spxMpDx4KJydut4j8hkfxFChGOLDkb7BPleBrLnAl0VIuLtrUwWOuOddGhY7kom0kMmin
	V0VAabYdF4j77hCFAN4AkAt3V6ZfkWMEp5673Rtr98UHkVYlQzm9t2jFdQsXY/mlr704awenGoa
	vQNyjhsNQf2gVcjFgq9eBnPAc7Qwrpyp+ohef6AAPgQNBUHTwGrgE6FOXDFSqHddoda0=
X-Received: by 2002:ac8:4808:0:b0:4f4:c11f:a893 with SMTP id d75a77b69052e-4f4c841ce15mr13310261cf.38.1766327189848;
        Sun, 21 Dec 2025 06:26:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6MSj9kp3XaPt/Hj5dvTyhFXG7Ou9KvnYkLbuj3WrXScz5IKiaHkNRDJMrQqc7zufDKoYpDQ==
X-Received: by 2002:ac8:4808:0:b0:4f4:c11f:a893 with SMTP id d75a77b69052e-4f4c841ce15mr13309851cf.38.1766327189276;
        Sun, 21 Dec 2025 06:26:29 -0800 (PST)
Received: from quoll.home (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm211742666b.28.2025.12.21.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:26:28 -0800 (PST)
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
Subject: [PATCH 3/3] iio: adc: rockchip: Simplify probe() with local 'dev'
Date: Sun, 21 Dec 2025 15:26:05 +0100
Message-ID: <20251221142602.47368-6-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6007; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=HCB26hEUOkbZ72ftaM1RnljHTQz/EsE98Plg38e2Ofw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpSAN8/kcgZNFHUfB3Ke+DoF9mdl7RgO5jsfjBt
 eN2YOKEHeqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUgDfAAKCRDBN2bmhouD
 13OzD/93KT9dmliMmsuwd8OOM8ZuIX084rVOcADFrvVtzozY0sU8KlUTvYM/rPMk0reJd+QgIvq
 N1LZVujUSp3iYnYUk1v9/iaXKnbIUR+/kU5gNBZzoTz4FuoPXnQHzHjqJw1nPmrDaas93l0YR8M
 2F9VZuU7nELtirflYtOEOtzAHIfAwxc9GhcslUuHTD44dtc34W8s0xCzXB6m91DKH3T2u13q5/F
 BcS9YWPjAZ2kKw1Aa98hxwXSb7yTyZQn+D+74OeuF86xg8ADZOUV7By7uUJ19pR/uu2Pabl9Vit
 tk03JUTPTlUKzFOqQZ1N+5fTxjFgNRn8TdzVrQoy1t8QexBRo5lTSlpAQ5RTe6ft4lW6dDti54R
 b28cFZyN/z+a/lTu4eMvC1oRNEZuyGoWGTKxE2UnSTWcdzSebTUOXh/IgV+faAzEk4SRmMXsehU
 e03NBnIIcXoeoJbe99uJ65vYEPTD5PD8ktls9/3n4bMNjCscHwvkAyMWw4Q1GHDPbo+RFAvjP6b
 PQBZFt5IFj7vUJm5Y7zD0EK4CzgLbBrDhUtD1D0HIWOAGwpm42ytcF00VTiSJbwKoUPjsXWKMcl
 xmcwRIBdcM3Otrdvl/arbkZjZtD30tpJ8Ugl21DoVCX0mBCn8vziGIgCM8MlzXgoj7ax6ltia2L xCpbZ49NWUj7xbg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=69480396 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Dh8f_jLqcEms2xoULN4A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzNSBTYWx0ZWRfX50S2KcxtTS8l
 /qlaTsVYUwTqsvNEspCMDtbEeqXdvxzZfMNzrpIJ/Bt0jmeHbufsrJdEqxhiCeHzvJiADP8XA92
 raUvHy1PkbEiVpUJ8RZSNFvRmLMDUDMtrf/5otFtzXlF2bD17k8GSPtvPeW58PvpIDiOtkY5dNV
 Lp+oAapAC/m6yhkrDvMlqdGSWLwjHrHliw/zE9kxQ75MBhGFpHLGTnWjsV1WcXdepcJdixXkw/5
 QlV25pwyS4rj8fOFF6K5SyD0Eb8OMIjo2jU9jUy33fGjRtneAwaoBqieG3KYODFlA0AgBBxa+Xo
 4o63bxZFsBa/uwb77mfoVETG4ZWc0/bbnqUSObcdZTw2B/t/FYz602e1ihGpQFHXkfrqDxx6Wxe
 KidR/VFEynb8p2DIPyn/EjoCc2Za5KSBckp2CQvtKpmTkgc+8H7XjlGnRH4oQywnpR0aKQu331l
 ya4mzM1DjSPTOf18YRQ==
X-Proofpoint-GUID: sHdjp8QG3MoVfoK2bk2joyciZ8UInBMx
X-Proofpoint-ORIG-GUID: sHdjp8QG3MoVfoK2bk2joyciZ8UInBMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210135

Simplify the probe function by using a local 'dev' variable instead of
full pointer dereference.  This makes several lines shorter, which
allows to avoid wrapping making code more readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/rockchip_saradc.c | 50 ++++++++++++++-----------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 263d80c5fc50..0f0bf2906af0 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -456,6 +456,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 {
 	const struct rockchip_saradc_data *match_data;
 	struct rockchip_saradc *info = NULL;
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev = NULL;
 	int ret;
@@ -464,23 +465,21 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENODEV;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	info = iio_priv(indio_dev);
 
-	match_data = of_device_get_match_data(&pdev->dev);
+	match_data = of_device_get_match_data(dev);
 	if (!match_data)
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "failed to match device\n");
+		return dev_err_probe(dev, -ENODEV, "failed to match device\n");
 
 	info->data = match_data;
 
 	/* Sanity check for possible later IP variants with more channels */
 	if (info->data->num_channels > SARADC_MAX_CHANNELS)
-		return dev_err_probe(&pdev->dev, -EINVAL,
-				     "max channels exceeded");
+		return dev_err_probe(dev, -EINVAL, "max channels exceeded");
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
@@ -490,10 +489,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 * The reset should be an optional property, as it should work
 	 * with old devicetrees as well
 	 */
-	info->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								"saradc-apb");
+	info->reset = devm_reset_control_get_optional_exclusive(dev, "saradc-apb");
 	if (IS_ERR(info->reset))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->reset),
+		return dev_err_probe(dev, PTR_ERR(info->reset),
 				     "failed to get saradc-apb\n");
 
 	init_completion(&info->completion);
@@ -502,14 +500,14 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
+	ret = devm_request_irq(dev, irq, rockchip_saradc_isr,
 			       0, dev_name(&pdev->dev), info);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret, "failed requesting irq %d\n", irq);
+		return dev_err_probe(dev, ret, "failed requesting irq %d\n", irq);
 
-	info->vref = devm_regulator_get(&pdev->dev, "vref");
+	info->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(info->vref))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->vref),
+		return dev_err_probe(dev, PTR_ERR(info->vref),
 				     "failed to get regulator\n");
 
 	if (info->reset)
@@ -517,11 +515,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	ret = regulator_enable(info->vref);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to enable vref regulator\n");
+		return dev_err_probe(dev, ret, "failed to enable vref regulator\n");
 
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_regulator_disable, info);
+	ret = devm_add_action_or_reset(dev, rockchip_saradc_regulator_disable, info);
 	if (ret)
 		return ret;
 
@@ -531,14 +527,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	info->uv_vref = ret;
 
-	info->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
+	info->pclk = devm_clk_get_enabled(dev, "apb_pclk");
 	if (IS_ERR(info->pclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
-				     "failed to get pclk\n");
+		return dev_err_probe(dev, PTR_ERR(info->pclk), "failed to get pclk\n");
 
-	info->clk = devm_clk_get_enabled(&pdev->dev, "saradc");
+	info->clk = devm_clk_get_enabled(dev, "saradc");
 	if (IS_ERR(info->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+		return dev_err_probe(dev, PTR_ERR(info->clk),
 				     "failed to get adc clock\n");
 	/*
 	 * Use a default value for the converter clock.
@@ -546,18 +541,17 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 */
 	ret = clk_set_rate(info->clk, info->data->clk_rate);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to set adc clk rate\n");
+		return dev_err_probe(dev, ret, "failed to set adc clk rate\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->name = dev_name(dev);
 	indio_dev->info = &rockchip_saradc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = info->data->channels;
 	indio_dev->num_channels = info->data->num_channels;
-	ret = devm_iio_triggered_buffer_setup(&indio_dev->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      rockchip_saradc_trigger_handler,
 					      NULL);
 	if (ret)
@@ -568,7 +562,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&pdev->dev,
+	ret = devm_add_action_or_reset(dev,
 				       rockchip_saradc_regulator_unreg_notifier,
 				       info);
 	if (ret)
@@ -576,7 +570,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 
-	return devm_iio_device_register(&pdev->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int rockchip_saradc_suspend(struct device *dev)
-- 
2.51.0


