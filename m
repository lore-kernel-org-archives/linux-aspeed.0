Return-Path: <linux-aspeed+bounces-3217-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8BEE784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:42:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff8R6yY7z2yFp;
	Mon, 29 Dec 2025 12:41:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766580286;
	cv=none; b=Umf8MSh0xpg8wRjl6YGP9QvUxnezWC1V2Uh6tmoXIRbZmRrTtIbHjEVBfkau5h3U2pNyJxMF23Ygn8LQqDnyXtRpbENk2m4CIKBx9OO/jXcb4t5rJekGKp6pkjubDez0wx8PQsJQg+CE3Y0/l0hkBN03k6xcXRv/KLxToIcvVHBtzd/OPenZKJmwPp3hibC29HdJJPxerKGXjCYW2Vps9+/9HGQ5ALeT5GC+QR39sff4GoOaF7YbzcU/OlooNm9VbG9ejDa4p2yrajAwyCDY58VY9AkTf7VfDaULhvQb/O93lkDBz2hsNQJr3VYGIiBo+sf23BihiQQgBQpdYXl6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766580286; c=relaxed/relaxed;
	bh=KNilgW2hQVLA4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzaDQptFNqhdV3Nyh8DEwj+d50UDDDk5gMZ7Xugum7AmbvddikgrVq4QCesuKF9yztpRFzQmyAkTLncehpLA1b21oJiBvplu/yeDQQz77ebme7OJjQZ9kuBORgLxd1z4Im3YjFs3w8AW5YdjKbzP4WDOSpSKPHFmwBsqInAkYx4yDFgfdCwJ2y8iuBo9N+zxt4Sk8xqjjVu0APp2zEvIENnA4HDyUyLagP081LktdvISEM0Dl55WHEroSUzeRPDgSCcEZIOv+gOKDRTV4CmrpoTMbrP4E7pR/z5OPK27ptCyzsSsCc8nbKRCM4qWLT700dTc9iNPNYVk8Yd8xWERCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OYv/QbS9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AEckgmFn; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OYv/QbS9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AEckgmFn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbs5n2cnwz2yMv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 23:44:45 +1100 (AEDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO8PCx4721286
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KNilgW2hQVL
	A4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=; b=OYv/QbS9aElI5G5BGNnWjL6XO02
	WgVgefJa+aL3ab57iZqGYNa3drsUElqFpIzmnFd8kVZHqgJQZbsP8tFFCPHP1X0e
	xPLgoLq7gr93/JC7zzSQmeEK8RL8Ojw4do9qDtvsRhjnRa4fgNsZRg1CnxEWsGDs
	g1yOJJhJBVNG1a4NKOsul4cxqODezrmnKnk7D5AVtor0aQ9S9fvJv//VPn/hvhNi
	p2dGmPx51k37IrtpaAr+w6b4p12ieo6pihlO1I58l27jrTkuScbpyGuTeM4mpPJ/
	FyMwcoelU2AA8SGCP1GShqSOL/KWgA9yT7vYMRfG1ILIAPWgx6h/VNVV+nA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b81mta7vr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f35f31000cso82711471cf.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 04:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580282; x=1767185082; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNilgW2hQVLA4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=;
        b=AEckgmFn5sCj3AqbsLHf8fvjqD7vjGKItD7TC+1b1s3KjnTl4JlSHY0441USk7KTfB
         4aev2b0tZ2viAX92Fqyixngb7ruP13648l1iOql/EhNmoCva4OYKMfz+Qhk1+XvaKdMC
         YkCKPLgZTGfIYjOEIvx3xRwYXd8ijEWvVv0l1KbJz1LUZcy1fMQhEX2XfjNVRwCC9LjC
         dst6PbIgcggCzPwUl+hMbKBOnZRmecBknCzPFv4nNauQitcZKSJplRAtR/0YdnHQZ4et
         HiL4vMkRVlEV4d/9qFMEpliIJH0E8mmi6cbejA0giKXIjBHwJZupL5TXsMLBzV3RZ3Dk
         KdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580282; x=1767185082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNilgW2hQVLA4gLgVez5G1ooyvmxPr2+tpwPGpuLFvo=;
        b=f3gm6YfsYLcmZu17vCflJPEL/yOtCoA/NXyqH0iXH09zYZF8ow9GrLQGpMVKKl++9S
         JBM6dQtBfxDetHnXoNKGbFS6+6bRhcA3bzB4+hzfUc4lDwzSGgJakPCfK+6BC9l22WDZ
         N4SrnDjHggUrcgGpyq7gEp+4RxZKPs+cNy/U3AMP6015psev24vsUM/w8SBEAd/95nfT
         PtdnIWPB1iwyjCf03TwuyArnwBiyujTyGxkZ3TE9ap1GwF5Uht1WxcOuOlSMVrtGXC09
         7FuHGLVOoNgTc9jHJmSz/NodS49gPzrfKPrxmBed41HUd2/XsrRjh1FbPV373ZjLcgtE
         rzOg==
X-Forwarded-Encrypted: i=1; AJvYcCUUveiwqKZ9SQ2RkdNh28fMtuhr02uwxiy80iJ6i+8pjTXYFJ8TLZ+GU66lv/y67/tie3a2PWaRbD/CTQg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7dVtWJAo3cFKZjr59F7plFJzAyhm1RxIBHsnhoNHVK4GYatWK
	OiyDkLp5vQ3VrJ1MdisxwfNEQRC48K6Ok9YuFqmcMMq2aCCcTSEZIJ3N2+MjG+z9q0r9oFJel49
	3MNMrjwEhVY+DGqTMBcGUV5c1C0P5OrYux8m7dBFfdHUMfc9PgJ2fvATM9j3YexhgKMwp
X-Gm-Gg: AY/fxX7sLNq4EA893zk4XSUvW68vpmke0GIn0lJB9zPWjwSras+1l7GomWrGfa2/2Yt
	xlGaONBba2aSLq5zNyKD8DYkX2YQuiz/CsoFB6Um64OdYj5HGxhuTiDw4rs5a3nJ9IwApKiT1O9
	xZxyhEAKONnb/xOM9WUZgFOBVIkBWEksraDyX0ANtqjmdW+44gdNipRKreJc97BRHZjrsJGQ/zq
	8odlp+o6s2Gp0nCT2pjsM3rNf37624WB88yoTfmVKE236D70xpXd2eZ1ruIaAYUe5pd2LCCXTyX
	Sl2deB+nb0kVSG+1sB+QKJT+LSCCNL2WRh2MekfwhA34j15WEjQIyJeOKuV7/DJHatmOQoYusTd
	yNvDRA2O38OD73aINIFKPX5fHpjiEutG+THuyubfZTZzA1zV9zxQ7kI2OFdm8UVxymj5HKw==
X-Received: by 2002:a05:622a:2488:b0:4f1:ccfa:377c with SMTP id d75a77b69052e-4f4abd61335mr226687351cf.45.1766580282424;
        Wed, 24 Dec 2025 04:44:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjvpN7s+TXKm4SLsrLkne4UHksiC+p6orY9KBQYhq92eh57vEMHcnwzJgX6up3Vu2ofSSjDQ==
X-Received: by 2002:a05:622a:2488:b0:4f1:ccfa:377c with SMTP id d75a77b69052e-4f4abd61335mr226687071cf.45.1766580282043;
        Wed, 24 Dec 2025 04:44:42 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aubin Constans <aubin.constans@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Robert Richter <rric@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/4] mmc: cavium-octeon: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:44:33 +0100
Message-ID: <20251224124431.208434-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=FSxaYZxRQw8NtKxY6K+zMOwodj+OLUAUfn5MDuEJjsw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AwQ5nt6vw2D5baL22d3lRE3rCSSx3sNXoft
 Vv4+URvpJyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgMAAKCRDBN2bmhouD
 17PtD/9fPRxk2QKcs6uPuvMXpzzcrsQbQfN62ZHe0qNSRHZVjUZYRSclOZTFYSAbcTufyVWU6XQ
 +BeXZ/vHxvBypyatbdEQ/LlDjI3iPFTROp1xfZXNwjSVhfKs2YgngMDhBjdYLnj+PO1gfBKveQ/
 WwFiSASnRWqMBH/MQ5yzsuoZS5/HBB0S5yeY3HNKZAASCVsXKPmGsyQlDKc+aobVqSXIIit1Cnq
 phLUeHtgWO8BxwNRAPJCvAIeevCY2cUwoeaZC0sgO6BvTtHF3XAAVthEob/V7TANCFkQpFkIa9k
 ugZ7raeZuoEN251R028d1ihz5HO6XpvwTDDqgi7urpjhDixnoPAVWDrKpOcENAJg2jl4xIKfxFj
 6iepzuyHXalf/4fbXWTmTmQUjW1G0ohdRcb+AMvl60nnz7If3RHoNIxEM43ZJLlAK5BT/NMpEcw
 +AT7kZGOsqZ0y85GzBe5wzqqcrrsDxtBdCHnqh4v84nD0/D+pm/T4HKjfymo+Ld5Vs5Rb3kKEAB
 GUuyNEvbawqC/3EtNgnNYrHAEEqJ9BQyeDrJcIkrco854b3FknW5scT3l1XW2hQa8nLSTjrl/Zy
 Y5reUj7YPS6HmfNfkhtjmZQ6CAXdK58bZ0BcUGWK+XIFbmovY+QRNWftxWEVKJMWqhELo95L0rv +AeqG72kM21k/yQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e/ILiKp/ c=1 sm=1 tr=0 ts=694be03b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kVq6N5mEIK0mURhpU1kA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: _HEJWJTxiFJo89MJBit4KdIx9dAUaXmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfX++ocKviVnRxI
 18YpTL0nTtkDODobhNG9D8U8JWu3Su8x5JKD9pD5dZgz92Z3d0w+mJSwNl+kE0oBC6T/VanAFpI
 OCpT9aVzVeH9US7lWP4d643RSqPPaCoJtjdnXplSiSNsTINqZOUkj435AbBOsRSpHec+dRUMti2
 uuH/iChjBU1AEVs/LBTAM1/EauV40PxKK+WB2hEUPhVQrRzR1EPAeVi8sIhL8qHA+S3hFVINQa9
 xIt1z8lIZf0UGrHgR9fAeVx6uZIrk9s+KfCcVBINWkHJcqpt8nZGAXzR8Lwnm2Aohc12V3D55FE
 s89JEiOxfGnCt5uo8Qrmj39HW94ON5dVRAMUmdSMNuuku5nTjTBGILChW82M80lV+2jqHfRLfqd
 Vr7+jfUnIM5JwQ7yniWsq17bOCWPxMSbBA5X/WRwId+fZwPQODjYK3SCQZT3vs9dTvwmIBSGrzY
 z62152TEJr10p2P2QZA==
X-Proofpoint-ORIG-GUID: _HEJWJTxiFJo89MJBit4KdIx9dAUaXmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/cavium-octeon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 0592f356b1e5..8a0daddd9200 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -148,7 +148,7 @@ static void octeon_mmc_dmar_fixup_done(struct cvm_mmc_host *host)
 
 static int octeon_mmc_probe(struct platform_device *pdev)
 {
-	struct device_node *cn, *node = pdev->dev.of_node;
+	struct device_node *node = pdev->dev.of_node;
 	struct cvm_mmc_host *host;
 	void __iomem *base;
 	int mmc_irq[9];
@@ -268,7 +268,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	i = 0;
-	for_each_child_of_node(node, cn) {
+	for_each_child_of_node_scoped(node, cn) {
 		host->slot_pdev[i] =
 			of_platform_device_create(cn, NULL, &pdev->dev);
 		if (!host->slot_pdev[i]) {
@@ -279,7 +279,6 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "Error populating slots\n");
 			octeon_mmc_set_shared_power(host, 0);
-			of_node_put(cn);
 			goto error;
 		}
 		i++;
-- 
2.51.0


