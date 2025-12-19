Return-Path: <linux-aspeed+bounces-3160-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31774D637B2
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHj56Ymz2xlF;
	Sat, 20 Dec 2025 17:44:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766154965;
	cv=none; b=n9oCKJJOjKoTFb0sKl4xwHSe+Z2zP7iDJx9VJFQy36o4iNBR8GYfz5AinYStHZohsHIZyAeOYr+rmO+7hWGDaKKu/DP3cOddDSYJFVHgz8HPbqyu6dGiW/SjgJ/+4BLO/03GQqi0EHJVP2sXhBn3taOtckeOhcLhXZCjffSm9+ykXuAUPh5U/1oSpdm5CRikkn8jFkC0Xh4H3RLzv8y1uMV0NcozZr9pzaHThigTilbuTnQGQSKYTr9A88r4/MKNW8v+spHwi2CYbxxN24a3yEECsdiDB5nhsx0oitS7Z9QAN26fqAtbUyQU7Iy+zECPrgt/GafeuUxaJgq9E1GPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766154965; c=relaxed/relaxed;
	bh=6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LU/Vv7J5VVM3t8h1PXX2El1++zXWHC/addEnuNmey/sIYjNvjdLCeWyHl8VdLygjPQfi+vMUunjSb9ec63UrN6c7PH3VG3TlWOLw1HRI65whcIaRmtgayebdsbPeKJl/GVJ3DoiXcliBJ1HyrpmYt1VIQ2TAfPsw/ESDOQcXla9NgZbESwRz+ptVPWeAYjmshZSCFYw1i3HQUWlGXDX0gFuaWqyZ7P3zPGSifS+9EF6SGHb2SdIIqGlKYot8MEj6h7tRlMY9bWZLu/Wd6qhL1x2d/BLivNSLk2I1KyRWERTMBZA5s63kLuGee6qn8K7ykbtb563rELnmZpWyIklSHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dx6RAz2M; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WRQ7wdEs; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dx6RAz2M;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WRQ7wdEs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXqpY0Kzpz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:36:04 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBuf0d3701008
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=; b=Dx6RAz2MmQbVOKoW
	UDi0K93jkktF0Nszi/pD8lDSsAqYLALDNIz8FwmlIXxBTLlZzeHqx4R7pTt7UhIG
	DWmkliMOf4jN/ZqpamEBz3dOcSS7LwJdW7a23TY7OZqHT94/fYay94YEaGDt2bCg
	eNWxmLyJm3NJOorIOvXcle/4rrXsHtln0vtt5DzVBlYaxJhYfeQsTUSftPurIdlQ
	CziXMC4GXW1tnfR43T+5Uy0uXJn9CEF2E3ohrI8zJzQ4kFYweHWwvMbLzqxPDzC/
	bJhfDsut1yCEbk0zbCdA4ouj3hRi0woR18qT0YgOSfXRgJG7elKeZhYay+WFtIgo
	uEmzCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ejw19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:36:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1d60f037bso37809091cf.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154962; x=1766759762; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=;
        b=WRQ7wdEs0fmN7JDcYxPr29zrL7N18uTbMewZi2d4enbNx161/BFdKysVVFcIGhx35v
         8Hz6byjiIrj+rOLlfjHW6Leww8P0/I4asTrVtDObBVsGx5lmNkbx3KoYz20Y4q7/2v1H
         wTsvtKF2MHIlp/AW8kuyMnOPAa/tfilkRPLjYRsZsyY4TLz50m2bJIo3eiqshxvzQs/Q
         hjN6VZc98EZfcyYsS9dSKyquU62vYvMROye2zf280uu/0+P+kE96KgOMEN2FGX7TAKEH
         YXyZCsLOm4CvipJEJICfD9L59UUZDBEPm0VJzgaEknvriu0YGojrkyp4S4j3tX+BKAGC
         qbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154962; x=1766759762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=;
        b=L7+3dsiDOMMlIzKAfZBLWSaEzBdoYytS0A7O2PtRERbxVasgsF6tiVmOoqti8jJl2I
         DsrFM3fGp87y1oSIeTJSRoh6KJv/cAt3Mm0A96ubkCJv0CB1BVy4mUVCd2PCzb2LwUwo
         0kOXRFUxkZtrE59XhMZaXQBrAHz7tWchrD8MqOGllQCqeyca9Pny8T+IAcFFlOjZQLxj
         O58s2gunW5Wq421L99WkHEhnX+CF5CHdd2i5ZNHQLP9+tyOInkaZTFHO0HOEY8hFmaF4
         B6Z/ct85ytpRRkn9w01ekzzF/EClPRyK6iabg56VJWw7dMvoS58VBIzIa9DUiVzzRavA
         hchQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy2DehWuHqXNApK17FNDI5eNj+bKv70wi/NtKStEOI1j5Hqtp1OW02tniO2kt+oHVc1vvD0mKiCcjX1ZQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7LAWPby9Fan2l4XtsxuZO2oL/DvmZ7jdYwKPC2o+52vMP6+7V
	5pnLMdVOSvJrP4pfGI+U9Ehc2UloPNUBqei/UglXqcje3NWdBivQ5XSPn5JwPRoB3V6BXWBcxcz
	Xf+KdDe6X8sidCiZRY6fW7eUKebXF8AgJMnxnJ8JkfEzmUjP+Ra/mm7AqXDZanST0DFWi
X-Gm-Gg: AY/fxX5ubnl79GQg7eWFH/TGcUvs5wdLEVY+dsvYkKvQbokn4MTYI5EySYT1fSJg50s
	HganGmI1OPVkyWleXtqSMX27cwWff5i1PH+IuVZEaHxGfHSgmQuHGMo3rjHD9+dx96gAaEErd28
	QsScMQZ89cXSO9PoYTgs129SZHY9s+rVoLiyrrJJhRXL3/kDYkkGTJZFEAJuUIlIWe9E9eSuw70
	q70a5WP3SiZxdHd52jMaVRnPt5rzXxCNOvhePL0qH7MUjHj9YPklAg8yo2nmuS3mxD5IiaAiMvk
	CSCs2nXFKVOhPIbq/Oey1954EWs8MaWxjW2+KW+ydy0oRgtwu8mrFKaz6NktMgM7D8gSJL4qdiW
	ML/tis07dk0lFTXojFRRdCze7taa8sFLKbsSy2XahFCWYFFPKRNbbL84BFFFmmkjmMrSw
X-Received: by 2002:a05:622a:5909:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4f4abd0cafbmr40585961cf.30.1766154962199;
        Fri, 19 Dec 2025 06:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf/8P/7gffTggqaLL7XA+UX+u7FNuz6BrjE8UubcGAq9Jn0DzHD2i139MD/SRvhbhO2DTJMw==
X-Received: by 2002:a05:622a:5909:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4f4abd0cafbmr40585381cf.30.1766154961735;
        Fri, 19 Dec 2025 06:36:01 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:36:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:53 +0100
Subject: [PATCH 4/5] iio: adc: rockchip: Simplify with dev_err_probe
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
Message-Id: <20251219-iio-dev-err-probe-v1-4-bd0fbc83c8a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Fmnj6mVvpbfLtwijoNhLAn9j7guM9pp4HVJeADMhGe0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLH1EFl2sCBthzt79pkShZZiMmOVlFkKcQCW
 mlR1bgxXBeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVixwAKCRDBN2bmhouD
 1yneEACQf/jyEI6/m6DrHaosqP0fY91Xp3YLGPZnm/1USifaPKrakFkvixtn0eSGYllX4PXMDgd
 duf5nq+PPq67Mbt2J6GvQ80K55z+C99pMr/xL1KxwOqk7vbu18uyryGnjYDo/O3ra1OFDJUCBL1
 xbEmsfWqd15AUJcY74qMPZW30zYCuLScdNNvhWpQvsURFVXzruPmXAUEA1LZDkD13KfhiF+4hd6
 0+cey9A7YbrHXZuLIjkq+EKDRu5c1HY7nFEXeRjZG/VdRpNHnnrZOYLeoSg89UD3d9zHAoAIlC6
 k2HwnIcyCIoM1VTZcC0v71LYPm9FtsIMbZ94VyqS7JIzAkn9JWACeavbmC8utEloLZ1sdxRA5fw
 j+nj7Ugdy0niu9678mY+/hCHp0pGpfxC4S5L2uAkyze9Be1VsT/nJ8+rY7+yrfcULh0awxpWvCY
 yq3qH+6xgGymoG7C/DWWg1p2Tc2UT5VXyB1wlUZ3Dy7rs1t6MPOoW0m6Y8GpIoqbxKl95Ot07Ql
 yxXnHOIsTgub0fbyrI3uwQNMn2b2HkGofj5xJHACHWk+TZRseG+oRZoNhk6gO/t5QSrT80IQCqV
 dapzjsOgJWWyp4u5wm7f/aXgCFoj+c/zRYy4LBpWkRFxP+7dqmmB8UObF1SIb2AyV0JQKEvlVEB
 VKH7vTQ/hvVYXJA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: t7RhIOnoONB5ygkZiqbLRpalPXrzRQBU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfX3YRjiYVI6JrR
 6pE7CF5zFCe4ULGPcz+M4ytuHhFe4deMM8ZlMXjO9E+q/alky5IdulolIijTCtFle1nnFXeoOZ3
 /h/8u2oKgz2yV1Gpoa98+rC9Ms+pWXdL7KqQj9W8jbv7zhXc3HPolE/q9t75vSy367Y2HLUOZDo
 z3F6ajnuphvL2tZIP6EuqTxWISNoPTycmASuWf9VK6Hw4UtLrxTBSIKj5mIb8mVzRqzs94Tc+BD
 Y0H/NE1EnaGxdS+ou4Y7OfbKKKNqTICelYlRTZP8ylh7Zwgkz1rIl2vR7pH6QV+WFYX5FhWeFws
 QzsXCsJ7pWqsKNaj6ShQWLDVhAOEtqmrzo/TouEioi6ZgeaiLgMn97GBb7vtzNfzoG47u+3+vwT
 3mJQPyFoGl8jsTYd4SR8T+7ngOMWOHPS0xBeaoClOHlZjEai5AOoIubGtOOUG5MYpuZ21ulJkfa
 nUiCrkQ+JU5A88uVG7w==
X-Proofpoint-ORIG-GUID: t7RhIOnoONB5ygkZiqbLRpalPXrzRQBU
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=694562d2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UodCGf9HWxkVo1034I8A:9
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
 drivers/iio/adc/rockchip_saradc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 6721da0ed7bb..263d80c5fc50 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -492,10 +492,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 */
 	info->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								"saradc-apb");
-	if (IS_ERR(info->reset)) {
-		ret = PTR_ERR(info->reset);
-		return dev_err_probe(&pdev->dev, ret, "failed to get saradc-apb\n");
-	}
+	if (IS_ERR(info->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->reset),
+				     "failed to get saradc-apb\n");
 
 	init_completion(&info->completion);
 
@@ -505,10 +504,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
 			       0, dev_name(&pdev->dev), info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed requesting irq %d\n", irq);
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))

-- 
2.51.0


