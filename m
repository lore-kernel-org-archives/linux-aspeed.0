Return-Path: <linux-aspeed+bounces-3191-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9708D711D5
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Dec 2025 04:56:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZQnq0Q6pz2xpt;
	Mon, 22 Dec 2025 15:55:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766327191;
	cv=none; b=ET7fyPOQZKnnIcsEde92OmlmGfuJrMHFybBCmA+qztHFg9hSMdnIRM1jWKous70F+ETMrtLzb4mHXzoBUtDDRMcJoMMGJsgRgTNCUcOxFSiFEZ3+QvUK3sRi60w1GfF7UI2zbtL1zu/vU7X90t6qxWmtztYVQLd5jiWuFTZjUz52bN+flIzVZODORpOjQ2oNws/OWkdEwbIcvchhsKFwkywwIvUWprrKnSj5wdFaw4EZetmxerlOrpviZf2SiFjE4TykplmJDgfguWGG+cs3IsK/K7P9tlcjPgJ3myUu2IK0ahkw1D9fwk2/t6ojk+Z2rNjTGR/S9hbh6cWh+Uyevg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766327191; c=relaxed/relaxed;
	bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs7HupizkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VH8pPNQsbt5pkjAIOAGjmEtXVFaCWJwU+mLfYx/7DnXLT5XqCNMRm3AkUhRWAIpIhRjzfMFRWDLnoeEZchbYroV7zFL2RjrTrv7IWIagu+X0i87JrZnX+4zb4paLOrsVoEeh2QUu4oKj2X6ANGS2+SMXM1oebXjHAMZAClpKSOenTxWjhj4UGjVRHFCYmhfUhI03erKDC9yRi1FMcwsng0SNtWmCoQ9vXaG4jZ480+2gZowo3cvc6N6WD/3jjkGfMPV8EO2XKTdXejeVvtellCQYXlXsLylb45T9iBOK7pGB4j4BdPDhQqPpDoOkEkvIKkxY/s5UuvS+N1IK4Lb3Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8EUpWtX; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WUwDiDBq; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8EUpWtX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WUwDiDBq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ3VZ1QNhz2xSX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 01:26:29 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BL5sBdO1804556
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs
	7HupizkM=; b=m8EUpWtXl3yU9Rj8JAnOwV47nrwluO7hLjeBfomTh99Rg6v1FVH
	7lAbOiiTId8JG875n/CBetzVQxZEHKmAMdJET8z4HgZVPs7bISugR6zXg3fFhal2
	a2UIH3pS28Yv9WxloIjcXIPDcn0gBraDLP0+7emj/amIHKMcjaK9OMFHYI+eau/j
	g3dnQQ+6l7Xi2Qg6Gm6zL2tYxBiP0vzYnwJx0KXBO/kWCqlomOL72jkz03dBO/bA
	m4GRGIlJM0YgE+6i1SPaC097B1CIf1vxFfh5mjzJ4/uXgfMt8rC2QepxY0l8jZjx
	uGgk+5Nia8r/IT/KjxAfK2djdBySTQC9QYA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry2dmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 14:26:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6ff3de05so91267251cf.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766327185; x=1766931985; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs7HupizkM=;
        b=WUwDiDBq1D4jgLpZ3lXPl3hg+TpHc24YLP3jH1WlEHqHYfQLsRIEo79HpbLFXzdN0o
         ApdMLZxpOShJc1pI/tC+RgB97S1Yd6tQ0I5bscxFZ3W1vFjygAWGpWDr8WhvA4fxl6/Y
         v9jP66sRfmrprrLkP39tJI8iGIW0OJAKcjUe7Ut5tgxw3qtw65gZnwy7bsv6Pz4wDaXH
         uGDITVie4RvZ2pPKjhO493IT9MTzQldcm+UJps06seRuwHVtpgMqB3crL19K4UW2gOZh
         SslGqE8SYiz58Gm+4P1klB3Y3mIDiXwpS1u8nrsxTSqOY423JzUcl3/MzIX+t/lrsdEO
         eI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766327185; x=1766931985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs7HupizkM=;
        b=GDroCxpDpRZO7rACYczK7KmbUhKwdc/SOta3kVA6wsV95fy6O59pb8VWlBLagiOooT
         J4niGYBh5CaZvnVCL177XZbEV4KiAx+F1D1dict3ZKVOS8KqTXSoQoTG51ESbjVZQTno
         gPTT3/Q3urD6dHKtTFnEH5rFLkaU+6Ruf0RE0AZ4EdmBkB6PRqD/1kZYtlXzYPPJXeXT
         5elgfAAsPfxXVQGDNg4nhwUOqxXi+ZlTfq7Qgo+hCKSizmvGEJqlKcAMqVFefdjOKeEV
         Tw6NycePXDyh1BKorZcj+Xaxc+F5CXUoufUCym648hHiuG1BQ9ZsXDqQ4RSqOm5izXT6
         NlWA==
X-Forwarded-Encrypted: i=1; AJvYcCWm0XGXdRAkm9FyBpabWJcM701Z99oRjcA0CKt2oGBrSQEbRRrOaPbs4dxdcsSWqLuraVjhFCnmx4ocV9A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsjMWttUAfsuACQ41HKKUW1TCI9ZRS7ztkN0UGz2bWJiwShSGL
	C4JdWA2LyI2+wSnXHUndd7C58c6UWT9cpieIYfkNd2oLAeeAE+8FThqM7RoROU/Qwig7zEvU/09
	CjRyNxHwL6Prsp/HqbAZxIXTmxgccb99CqhrIrHjJMiMK9DCazYMhQ4Zjma6IHs4urRqz
X-Gm-Gg: AY/fxX62ILPN+X9jqE3a0G90xVdeQ+Ph4AUwnFiudKzgdK6W81YVHCvdAs8Wfsd0fOz
	CSfS/OXQNi28yw6NUohFIbLsjnNTapLA3kos8mbS63uZ79hFQ0xjWXqRQsIe6XKjqkGDucD2SHB
	qc2IqvF2zDZXoCU2NmghvIc7GkubYyg2JxCj+5h1WCcnaB5Pvbk3tgfgYwwTTof/bAg+ara07GC
	9gxL6OCHbjC3PBHlwIY/Hr1w86lKddakybW7wO8oGP+1saMMye5V3FekxeEyhPgwG/EqPl3Trzs
	xAFxJcE1EqQMTYZitJZuJX+sbABERbo7eScWJSIQlR7KiXdcv5BYxaUcy8f/HRk5i+29CETFbHy
	M0eZobd4pDyrSmsUZOFYBD7BhlliP7a2DYew1f5tJN4U2h9t3nVXHdaiFjdR1Ehv0CPI=
X-Received: by 2002:ac8:7c4d:0:b0:4f1:ea37:cc6c with SMTP id d75a77b69052e-4f4abccef5cmr121973651cf.1.1766327185414;
        Sun, 21 Dec 2025 06:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Ewwu8jx2ZwPNq71Z/1YkKihvuGLTgnEvdj7fUV4p110jAK9fWg0mU4MzcCWC6pVFe4KQUw==
X-Received: by 2002:ac8:7c4d:0:b0:4f1:ea37:cc6c with SMTP id d75a77b69052e-4f4abccef5cmr121973401cf.1.1766327184948;
        Sun, 21 Dec 2025 06:26:24 -0800 (PST)
Received: from quoll.home (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm211742666b.28.2025.12.21.06.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:26:24 -0800 (PST)
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
Subject: [PATCH 1/3] iio: adc: aspeed: Simplify probe() with local 'dev' and 'np'
Date: Sun, 21 Dec 2025 15:26:03 +0100
Message-ID: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5796; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=4memX5LYrUSHkpPHO9rC17xhoMrrygUhrVZmB+X+Pes=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpSAN6XXbmliCtMd47o2Ukt4Nzqp5wMfuT7YMpn
 B0bxk6i8+iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUgDegAKCRDBN2bmhouD
 1+QUD/4h6/Z/xjzwuixOi8qQKqxnJhDBq0SFL89uOLzuKcSdkerG6kIqP7Ohf+mL8qJq4iT9ZiK
 VsdrgMQA3s3wVXAXqMBkdCK4e9csD8bF2MAUKIb6+HbFsphWegKqmDsL43IPwZx9/Jnhc8ju4xg
 oxISsYHMxi+Lj+hZLswy7fJuPV/rlT4xRCfpnYaEaHrxzE0DHOdYw9VFuch6FLzt/KI5dJB+0rq
 7bqm2523WSW2EJ4qQhN0AIfkGnn7aQS8WFdQ9JgjvYolDnqxLqRTskV+aTUh77WY2ryH27Z/qSm
 cHHcsvZ4+knptjeLzi7tuaHR6Fm1a4PV9q1Cf6nvm2G8XflIX9mk9xTUCzqz5uFkJx4p/hW2n5R
 6owLdaaAFn3fweGPPh56+M388RM89VLo3lkF1W0ElrbFdySTYlWn00GU1nS90KlKf7MxrsWOoSS
 RaSroRmjHzXefIK6ze3kbvtJE6WWl4yhFfauKQea7oj8F2bPFtXX966l/rAm3hf2dxd1CrYdOCE
 RksgInFqSNWHu3uv+A5FBHnK3AqjapgI4O0rjglPxs4M65UEZ/Y7wJDZtriE0TYjiDNFIxl4lo2
 njHCvzlwf61GZw/aZas9Y1KQrIPiEYJeCBOcCv49+k/V6Q8WWZUJtdkLDLvBbHNzeL+MeN/gb4A JQzD7dXuG8fDQ9A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=69480392 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Nk-rwAvTYNLgZ8AtZ6UA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzNSBTYWx0ZWRfX+dhKBfnlpnYy
 RbqnfHr1lJzdmKfPQ8Sbw0iqc9kvjpADZ58OSmKe6COX1bK9XqHY7ySg+HrSx8lASv0iueCugn+
 /ss9gZEWljN88dbu3Uu1Pjy9qbZgFak0Uj21HIWPTjutuNTLyWtseAJpYG6+0N1g8v2GQSIVQtV
 pBjBMjPdXO6Zpq/e8wUrlU/mZGm6LcyvOho4qk5yKzm2BpuvzTIHZ0lh1zoLFE9e01O4S7/Ckls
 E4QhqNjB7+9VCGZWPXw1TgKVPZzfYShWis7+ckntuSyZgnxT3OtbF8o3llx0U6AH/XAZT2KjIe5
 54NmMVNgYKfKTumMdPW+X2CDt1mmv3AqhHesRfsXpMal0rjBMeI8nmc5n4LLTchTJ5xizPzb/UZ
 3P/RnfHuVHeFlRemGoMVMmIvTVrY/Fg7Wtw/ml20AsDtw9slez64LPgOTp0Bi0EpJMcQVFAZGRQ
 eBLeES8AuG0Lznmh/yA==
X-Proofpoint-GUID: djBlHdS35az966pJraRJNewQPRxCVq2O
X-Proofpoint-ORIG-GUID: djBlHdS35az966pJraRJNewQPRxCVq2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210135

Simplify the probe function by using local 'dev' and 'np' variables
instead of full pointer dereferences.  This makes several lines shorter,
which allows to avoid wrapping making code more readable.  While
touching the return line, simplify by avoiding unnecessary 'ret'
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/aspeed_adc.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 1ae45fe90e6c..4be44c524b4d 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -472,16 +472,18 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	struct aspeed_adc_data *data;
 	int ret;
 	u32 adc_engine_control_reg_val;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
 	unsigned long scaler_flags = 0;
 	char clk_name[32], clk_parent_name[32];
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	data->dev = &pdev->dev;
-	data->model_data = of_device_get_match_data(&pdev->dev);
+	data->dev = dev;
+	data->model_data = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, indio_dev);
 
 	data->base = devm_platform_ioremap_resource(pdev, 0);
@@ -491,16 +493,15 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	/* Register ADC clock prescaler with source specified by device tree. */
 	spin_lock_init(&data->clk_lock);
 	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
-		 of_clk_get_parent_name(pdev->dev.of_node, 0));
+		 of_clk_get_parent_name(np, 0));
 	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-fixed-div",
 		 data->model_data->model_name);
-	data->fixed_div_clk = clk_hw_register_fixed_factor(
-		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);
+	data->fixed_div_clk = clk_hw_register_fixed_factor(dev, clk_name,
+							   clk_parent_name, 0, 1, 2);
 	if (IS_ERR(data->fixed_div_clk))
 		return PTR_ERR(data->fixed_div_clk);
 
-	ret = devm_add_action_or_reset(data->dev,
-				       aspeed_adc_unregister_fixed_divider,
+	ret = devm_add_action_or_reset(dev, aspeed_adc_unregister_fixed_divider,
 				       data->fixed_div_clk);
 	if (ret)
 		return ret;
@@ -510,7 +511,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-prescaler",
 			 data->model_data->model_name);
 		data->clk_prescaler = devm_clk_hw_register_divider(
-			&pdev->dev, clk_name, clk_parent_name, 0,
+			dev, clk_name, clk_parent_name, 0,
 			data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15, 0,
 			&data->clk_lock);
 		if (IS_ERR(data->clk_prescaler))
@@ -526,7 +527,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-scaler",
 		 data->model_data->model_name);
 	data->clk_scaler = devm_clk_hw_register_divider(
-		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
+		dev, clk_name, clk_parent_name, scaler_flags,
 		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
 		data->model_data->scaler_bit_width,
 		data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
@@ -534,15 +535,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk_scaler))
 		return PTR_ERR(data->clk_scaler);
 
-	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
+	data->rst = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(data->rst))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
+		return dev_err_probe(dev, PTR_ERR(data->rst),
 				     "invalid or missing reset controller device tree entry");
 
 	reset_control_deassert(data->rst);
 
-	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
-				       data->rst);
+	ret = devm_add_action_or_reset(dev, aspeed_adc_reset_assert, data->rst);
 	if (ret)
 		return ret;
 
@@ -554,7 +554,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_property_present(data->dev->of_node, "aspeed,battery-sensing")) {
+	if (of_property_present(np, "aspeed,battery-sensing")) {
 		if (data->model_data->bat_sense_sup) {
 			data->battery_sensing = 1;
 			if (readl(data->base + ASPEED_REG_ENGINE_CONTROL) &
@@ -566,15 +566,13 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 				data->battery_mode_gain.div = 2;
 			}
 		} else
-			dev_warn(&pdev->dev,
-				 "Failed to enable battery-sensing mode\n");
+			dev_warn(dev, "Failed to enable battery-sensing mode\n");
 	}
 
 	ret = clk_prepare_enable(data->clk_scaler->clk);
 	if (ret)
 		return ret;
-	ret = devm_add_action_or_reset(data->dev,
-				       aspeed_adc_clk_disable_unprepare,
+	ret = devm_add_action_or_reset(dev, aspeed_adc_clk_disable_unprepare,
 				       data->clk_scaler->clk);
 	if (ret)
 		return ret;
@@ -592,8 +590,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	writel(adc_engine_control_reg_val,
 	       data->base + ASPEED_REG_ENGINE_CONTROL);
 
-	ret = devm_add_action_or_reset(data->dev, aspeed_adc_power_down,
-					data);
+	ret = devm_add_action_or_reset(dev, aspeed_adc_power_down, data);
 	if (ret)
 		return ret;
 
@@ -625,8 +622,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 					    aspeed_adc_iio_channels;
 	indio_dev->num_channels = data->model_data->num_channels;
 
-	ret = devm_iio_device_register(data->dev, indio_dev);
-	return ret;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct aspeed_adc_trim_locate ast2500_adc_trim = {
-- 
2.51.0


