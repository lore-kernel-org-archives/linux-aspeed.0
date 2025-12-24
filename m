Return-Path: <linux-aspeed+bounces-3222-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F235DD3B7E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:46:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffFY61LMz2yFx;
	Mon, 29 Dec 2025 12:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766580289;
	cv=none; b=jlPVqwX1dRx8GkP3T7YKXtTa5EeM/LpRNDg40houR8peYx6QMxYXrmIXdihcaCtz+GbBxsm0NR1cwP6DMAHcNet4dnYVBPIcSvJA/+0kqRJ+vnu7Uhi2pX5/pXLu6kURKmpEGiUQaUpmtOE8/0wEWWfX8PGiNZ6sbeJyfkNhuGk4rVLFq1cpIjU+/YmM6b0qqtwxIeuZb3pM/7Zz37RWTeDx+NZNrAxNIlEE3R0qgvJHtzAlt3KD7E9lWEVktR5HQe2wxocmdCL/44Xipjoytry2iBc80zIEpzhUCvZLrCkFU3IJTpQqhgc/Ku5/mIh7vUC38gbrOI+LBqZdxBe8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766580289; c=relaxed/relaxed;
	bh=pIBKnWae4catNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU5i0wvuRb6T5aTws9WPdAJGwVTxNi/FnIEYVKOblbhI+n/55KJC6W66xUeWIBxExDUcjY7sFF5BMRG9/hJRsSfsV1heagu4Nn2g2Ii3YPRDNeVOuVpF77XPTMEzKiFVFZpCmVOVM3+HZ05nxOhhwbearovq/sYULI3uOwrrD9zhUNUwHZ2U3YsnQaWabryyRq+0duECZ/UUmeGvnPEDh3aQqdygAI3yFWtgytLlH5NhfNdNnEVtdXRIjMTbYgtt7EHK2bwb1CWtZhFqNTJxsg2w0ZUV1VPhJ8xEVd0yBOp2O8s1uFmBgSo13gtGKoVgFrLcZWd6vKIMRbgmOP99Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YmVfTXwS; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dq5qkc74; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YmVfTXwS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dq5qkc74;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbs5s24CZz2ySb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 23:44:49 +1100 (AEDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BOCclKn4134029
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pIBKnWae4ca
	tNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=; b=YmVfTXwSg+dzYWqzDS2Fpsnl+k+
	SoCPXSRlgSckh5iv5ayAMfxhfXcHJOkKcOHnKH8GO+G+PiIEOqh5yxvfzsvHvagh
	DsfzldtCWsLRZYfFfMiyj4BBioW9ZIbpAmldVI2UZI+qRHzxOuer4u5TqfyiuuHl
	bACTzaQOJHgjRDbHTNTpnL9981mFYhB5FqCtQQeIjKlpeVDTHcG2+McanmvDXwBi
	LPforIBOwwkdCel6R8oWLCRoBnJkER8aYz3DGpb93+EsTNsEcEqGtmlpfBAjdAbj
	WRgUUrxD5HDQbiZhGy+FNKF/BgDimrPDuNV872iYi/jr1GpII2a2ac7jPpg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7x46u21f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1d26abbd8so160833071cf.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 04:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580286; x=1767185086; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIBKnWae4catNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=;
        b=dq5qkc74Tg1Tt963mVD31YOeiymX+nmvlJL88YdFwBTokXVzpUdrU4WVdt4FdSew7X
         vweNGD8s9lSzFcRwIaA4KDHASA3CxnoFwEpGbAX5U3tNpcKJh7ymf2mrOseWIDmfAUdt
         sJ+C/SBz9t52XoZegozOEb4NYtBvcq+qwtLtIUQxF9DL1xnCuv+OgEyfPCWMbcKNpuVa
         OVc+bApWUn++mEjXpQKUlQstLiBh1WuQ28DiamUp2sBal7oocfSScx4ABdOeAUtwViv+
         zG69AbaU7/VvVQu5rHElYY4PCOHkry+CXBL0Z0rXxGcGqW/lQgmV4HTgN5FsSSeByRkf
         UwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580286; x=1767185086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIBKnWae4catNyYhM3q80mHwGLIsFVJVcGLF7SAAxtM=;
        b=bvIjZt4m83qV0oI6IRrdv2R7u60i+V9BS4YD/HZiTP4/S2+AoW/Jtxdx7mv3+Fzg4y
         agc4QoS2CeMygom5Io190Jgs28FQGy/d7HN+/DshIyScS2J3Ja4R9EuBxcy/42AI06KL
         OoF17bqoEAureDVl42ycRgaUJhBnt1gcQAp96dwCC8pENGP3QO7tJqQ/94OBHsAke9oK
         GVQ2ya86bISGxBmN+wGh/j8oZMKbKu1zwWeu1avrDEVUD1Bxoq2s28GAJTvp+KQcZPBR
         wEqadDO6Jh3aoQSMvXI4p4e2JqDtNUNmSy6JJ2o7IwJdj98VkGokGlOnQ8rO5NwZDnD/
         dJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpqMtBo1BCNxBLdOZ6q9X5pH9b0xnvh2pNxATShuhtKJzzTX2n43PKgARRqTPOb2CZTxD7m4ZyQHky8m8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxr5pgW8wFME8EwjKUHelyX1WpowxXDw0mPVyzwAf5OXWhZkldF
	SOyhj8lTFlrtkyJ4vMI+eZ225aBfTsz7QtIMSQYt/AyFynLItRlRx7lIKwJ7+lrJtlOd2V/1VQx
	zFNQtzvOxTpHhFhch29bh/FA0Qyc2pdxhJ9DJtNHYJC6X+p8NVUxy0tiJubuudhoGLYNS
X-Gm-Gg: AY/fxX7p9Qgh4GQZftGq98x/kFzZpY82KsUmjHkAP+YzNXUDdGW06C4mdUOIvez6h6f
	7bXsn5kTd3BCxvhqoKf0XiRLqTcWKpe5LPdYp/CMdw9buXmDSy4aFX5iLg2eZqXG6Qv/oyw9Uzs
	BPtOY6r31FkMuYjR3b+nAClbhtgLyqayY6TJ7nSAchjyNkYDvvt5oYr5ZEb6CRNzLr1E1yY2P2N
	7rBeDYI0C01MU/9ZuIO16Ny/U6n0VoJgINGl20lFXtYYkC+Kq/4P95PeT9AUyrzAyldSAdAP33a
	nwE39p58vhHPIjRnTqVcdwPeBRGkgLWoTPmT7zCM6ODBmMxNRA4jduw1VJ2yiu9+2aDijcW6BPV
	x78l4nUCSOWKUl2rkkIjqIEtdTFcu7RSNce0vLPilsy5ZM4lvC9+O9t/U4z9ZrBxjw5jsTQ==
X-Received: by 2002:ac8:5a4c:0:b0:4f1:ab28:d9f6 with SMTP id d75a77b69052e-4f4abd03195mr248360281cf.26.1766580286439;
        Wed, 24 Dec 2025 04:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTZXliHT1pgcb3I+/DNRDGU4Mh4keA+YHzBcuOF/mpCrQZKYCA78vOX3Oe8oOjwDHK4oJOAA==
X-Received: by 2002:ac8:5a4c:0:b0:4f1:ab28:d9f6 with SMTP id d75a77b69052e-4f4abd03195mr248359981cf.26.1766580286049;
        Wed, 24 Dec 2025 04:44:46 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:45 -0800 (PST)
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
Subject: [PATCH 4/4] mmc: sdhci: aspeed: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:44:35 +0100
Message-ID: <20251224124431.208434-8-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=k3fIiJQnt3//kLj8p1O4BhrfyE8J8CFmxoc44wKmiXk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AxsqyFxFGGpeZZHIhCyKOnvdjTJf+CTZuIW
 G78x7Z+JzWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgMQAKCRDBN2bmhouD
 17GWD/9Ixj1ULpYkMSdzu/q3hf0Kyx/91sewvClr8ICZPurrL/DEHrytAOup7j0UsUf2tqG+OyT
 q6YcG4NKAewr+dd4p6QyFCs6nsZ4iElL7Poc82/r2gIRHtRdWcCDaRZWlFvKMiR4pbqXC95Z0Zz
 s9fK2CprxcJVIOTMdjDqP0zIsBY7bn23YlXQmVkcnwj6tyDPDVeppRSNuLAC380N2f7msIhKcJQ
 hJkCfAP/LP92Cb8Yui3UoJ0pk0mYh2q1irGN9ANWu1j7Yv1py9TbXofb32r0aNUPL4eCkt6i9AX
 zFwqoAPZYFBnvUNpXZYwSzVTgpo+JA5kT7t1vKdt6z102UMhDrrYhFl/n/s7UnUZZnk+DiC45Xc
 GZeD1kOX3T1q3SuYwV8kE+G8vr+p1QLOS5wuBWwEidmkJfHGc/KRDVwreOXDAgeSMK93UbZqiDx
 +TXPEPeJ4QH2Y67axdeOdhhhsHD8xZ7XWxKOcjNoXkyIe26f4zdZ0F0NUBD47rgPILROWsCmicy
 waGD9LyfGuE8rVmiOhslBqiSQ3/fyNbBSlOfegAl1K/1fQHLCdl5E+ckDPH5j+NnzSiJGl/Ebvf
 jiLZwczT4DSEMogX90P/8nlA/WHEX+S/g9SdtVK2prE1TUsOpmany/Fame9afDjdsGeXptNT+8J g0yiZTEko+NQNlA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zyVEuju27u-90FJQPp8JmigYOBUwWQwc
X-Proofpoint-GUID: zyVEuju27u-90FJQPp8JmigYOBUwWQwc
X-Authority-Analysis: v=2.4 cv=aOf9aL9m c=1 sm=1 tr=0 ts=694be03f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=v5e_MpXYYeFlSKZv_FQA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfXxoUp9Hv2rPAW
 BjfAmR9eXqjwcgyOlBcZH2UFlLtEOeyiw20Om+9b4gTBEA6queqh+IPeHBVx4/VnkrOxc2Vi+hV
 37KaaefbG+fCPu0sMMIdk053Y4hYyQ5IuI2kgtfcGNnRizedJegXWgUDuzxkGb0bbbty0zpa/va
 cgxYxOfXGZO8eEQKTeoSHHpJ2G9qxKZoXtEqfqwrThscnUKhRRlkgs3yT7UoSfsSHjyiUJDiWyk
 XbioGTMrbJWgMGVhUlFTXy1SDxPaphzMvPGVylxo/5Cb6a81GNYIRxVWOgtmPLtddjDjnPvz7Qx
 lqZZqKIxiI+Dc7ucNNGkk+gyLSkMFO3KTk22sdt9QSZqe/VBkVGnIRCeLZ05Vdi2isocFDTVkni
 sVSNvZXW3062EokL433wTmUWBNoDtP0EnBEAuQLjkSXA81YtgwD21OzmK56RCnL41iGucT5/LIu
 4Go8SvGf/9pRpGxyHPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index ca97b01996b1..4296def69436 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -519,7 +519,7 @@ static struct platform_driver aspeed_sdhci_driver = {
 static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
-	struct device_node *parent, *child;
+	struct device_node *parent;
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -548,12 +548,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, sdc);
 
 	parent = pdev->dev.of_node;
-	for_each_available_child_of_node(parent, child) {
+	for_each_available_child_of_node_scoped(parent, child) {
 		struct platform_device *cpdev;
 
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
 		if (!cpdev) {
-			of_node_put(child);
 			ret = -ENODEV;
 			goto err_clk;
 		}
-- 
2.51.0


