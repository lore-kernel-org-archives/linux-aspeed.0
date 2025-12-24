Return-Path: <linux-aspeed+bounces-3214-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AC4E9271B
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:41:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff8P5zZNz2xrL;
	Mon, 29 Dec 2025 12:41:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766580286;
	cv=none; b=cyxxX8FiLeU2CfUQxbvc34j0cjR19OP6x2UetJG5wfuauOdLGu0q5+gFy3RwNDbuysqKOgd0XD8pxFNndo1MNn0QNI04KxmoB0wgLXHeN6yjteeC2Vjt4s+tZ9ZDO7o8nVk+4lHx0kNLrhcXKSNNKMBwuUfjlyi2qtP9xw0LaiAUtOv2SBMWAqQo7tgOD8j+la6AWSEpKnFn3Eq5GSWcl9Td9z9eig5FIdZRcwB5+pqTznG6sfB60BBR9RKtKFO1it1Q4m3s3oLMQS0W8iMvf+M3BzKm7J/wjqLk0ykG1IaRKH7SQHqIkLNS/yxY6uUrslFhQu+Df7y8RTVLPLH2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766580286; c=relaxed/relaxed;
	bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB51X9ls6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIvtSazsOzwkCZeOFbuSFgqijf6SGpihrJlSRn5L89hXMNRCX8nwf987/hWxaWeV2PWDL0mwJiS00VoXXf2cuEX0bpJ/Ok6ifwqsUa6riA87qgbYy1M6v0CVCzc1Y5aFpcTzAgf21Jv0bvacxHvWudWO7BoTQLm9+2pgH7DBuHrqeUEerpcl+VUU06/hafJALkCqcrCJs5LMLenCibGQerHayYLhxJ7JGra1U+BEfAC8Kj5KW+SsSE5yAVowuENEXhH3Dni+ZURsl0KscOai/p8Wv/PBHxuTXH2uOFVDU816L4z7QvakHFX0A7sGnQxI36yo4MvgoBRXopgz50AQwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fldrpCj+; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S0S1hHkr; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fldrpCj+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S0S1hHkr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbs5m4vVHz2yLg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 23:44:43 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BOBtcpX913652
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB
	51X9ls6I=; b=fldrpCj+zA9Q7h/0byn4xtx/X+g2HVNthktaN8KT3CGaPx18Eeu
	ZhgJsqk+U2LEM5K848P1u9lcbDdFs/Khx/O6Svo+Whi74m1Mpo2HVFq1ZyRbaFm7
	FR+LI/bJ210Qj95lb2XVxhhV4IiAM/dhKI29cjmc5z9G0QcpqRsMDKqMEnnk9vdW
	USDUGebEx5Bm3wxnkkWgHGHUJTWuTq1VVLSx/i9AvMFY5ir8V7JBPvubHtnWW3Hr
	QcBZauX+sDL4uoJQt4t2tHim/XbTLT8JdR4dZ/GjRpYAwhDkmTQ3+B/IBpt2U0Xb
	kcDr/k7K10BXVAahHytAxbDKQ+4kgg96tnQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7vt2k7a5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 12:44:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1d26abbd8so160830761cf.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 04:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766580279; x=1767185079; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB51X9ls6I=;
        b=S0S1hHkr97VlRg+3tKjwuuhL9pyRyo29b+BNm2Z5SKA8bBp/sm8Qxo7Uzq2GfKd7Y7
         0oSb2ai54r3bhBrZDotJCDFWcrxt8OT/+6nsj3hFUeZ1K5ZE9CaLGXDLWqvqKQnt9dld
         4O3oHAykP5JSH0+xvbIqWMV/kWiG35VwRSnjggZEUpYYe8D0GteuqcstgEulMj3a0ajl
         36XcblMjddsx9wRyQY8i+tQERsbimxKtn1DohrQqZ7Rl38LLi4PgX4LT3ujNFlNfz62W
         9qLsDJs5UFGMoWg+rdZlwzQQcZWzKCihmaE/RoAsRP+zywsdKh0RptjjFY5c9PiFlT68
         7epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580279; x=1767185079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9r1P67fE5RYVgK7sJ1zYioAmxa+nW61YwB51X9ls6I=;
        b=fI9VDg9Vk2caew+vOWkGZyvZeCSwcdu0TM7bJP3eLl8xQutKN+4LkIR+eoxFRJy2wQ
         RUPPEqtx8pbL8C1bvRtjGIBTA3GCRvIMiVMqjkGqClJ+oyMu2Ww8IKFOwQrkw/ItNl+m
         zVegueKN4F94bDiPjFw/3y/oLg1F9t/Yj8q5ctUHad2uTWfkSZ9focYPGICfUOiJpFuJ
         wm6erUNeZzlfzx+nSzG62V5np4mM5/plD4zsk99hMcf0RtsPZXvj0YPJTN5aTZAp0wf1
         0dpGNCtwxwW9dRmJjn/Gr6lMCdEz75vmUuT5OjnVSqtJN99OfMfv6TcsV6Z3Whqont7I
         YJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUoyzbzD0LBYIYIrZ6tqNq66qSgUPlq5dxCpHNkOf/CrEBTw7Pe+PX8LLbl2D5idQcNooy/ZUkBJ6hcSS0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFW9prJcQ8MQEBMztjaQgF+lQOK8quoVGzU6EhnCjhy+zNvJwK
	zkChywWals1lfENdVV754fkNnYUa7k6LgF2QavyPWngidObDdxWM6IqmV6T87r5mXmoqL81aC55
	E1HfdfotBcAVpgCtMzn0Yf0/42bFXytmt4awRoCtrL93XsarKigjsqdcxm4iHNtqF0/HP
X-Gm-Gg: AY/fxX6aKwQi3n569Rz20U11fS1X1+zloKDWV5s0S0RiecOerv/EBTxS9cDErSDFncc
	t0YDkWLsaSgFU/EZKiiudnJxMn2hLfJKQ5sj5cnFxKMFbfecRgZCpvMzKMSovzh2FoP5LIiaVCv
	Xg6STYBTRuVe29g0RuJIDUwTQ38pzrrRfoQjxNVoli9YxqjJTDy5pNZgdQKnlFIIku9qIXUgBMG
	TjQSW74A7DySOzHz5M81HIAAnjJavyzRm/i+a7vVvKe3Yzb+JKqPn3GCRqQuZ6mw9947mFF9xjT
	lqwOSbLK7KPNhKcoUWMOy3kJH6yPbx8Y9S51VDncPMaxyXmMjdAejx60KeVxksyP8YWdMBGSSCp
	OPgREDwZJKzBOU+EnfaYIEPocixya4j1RcXL6Ng3ljdkbuEkEGu6Dfu+cXYdzvQdjUw1qWw==
X-Received: by 2002:a05:622a:1c0b:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-4f4abd2b668mr288449131cf.37.1766580279383;
        Wed, 24 Dec 2025 04:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+NA1y+53V5FjdDZScyPo8qs3w+gs5u6C1SMipwvVq0kLIBUeyMoHc8CouFvb8Es/3VC8oWA==
X-Received: by 2002:a05:622a:1c0b:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-4f4abd2b668mr288448641cf.37.1766580278931;
        Wed, 24 Dec 2025 04:44:38 -0800 (PST)
Received: from quoll.home (83.5.187.232.ipv4.supernova.orange.pl. [83.5.187.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6d0sm16832679a12.28.2025.12.24.04.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:44:38 -0800 (PST)
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
Subject: [PATCH 1/4] mmc: atmel-mci: Simplify with scoped for each OF child loop
Date: Wed, 24 Dec 2025 13:44:32 +0100
Message-ID: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=yM7PsCJOfo1O8B7Z+MHBYKtQYFgSA+XM28CKwgjSXg0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpS+AvGomzzRiYXzxCRUVc56q7ljsbdKRtMaPH+
 BmIj4M47laJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUvgLwAKCRDBN2bmhouD
 1wBbD/91aQO1mFxSqslLTeFr4Dl5APuLTTk/ILf/WeP5bXwicwB+MKjkIBB/JMvW4h/70qH6Z0x
 l09ct2wktyCrkWbBXtou6V1Y7rQsfK5mBLfeoxl2z/dp0pdlPJ+qsTGLXvYBdllFC+pDR+g2a0z
 CfRUHflxj7UxVculnSnhluQuS2OrR3hG3fGC4hSE0ZHz3Cz91jZDiaif43yekqT14EMViCjISYR
 H6kMCEtvfb0MIxvAWqKiV5Q1h8khWIqVX12yPrf4VBGyBBXHt7B3QZfYeHKZCJsaDfOsJkUV6AM
 AVVwK/wByZHE6ifGhM6wfijBfJ14+RW5pP0GKmymxenVLVK5UfT5BzLb4k3GG33U50rZduZkfnw
 eb4Bs1IFB38KkbXmaqGOKFwpSesJzlAy+im5tpxruX59GaZgLflrwRxkG/bi3jqwRV0yBpjGzuF
 e+/PdMNsicVjYO+w6R3MtfXc57BiM4CTKFuJNIf370wI4+L+0KQiLwvsmMV2BaSLDHHNL0JKSsj
 vjYF2o3X8hNSkyG45ET2MNOjWnEdUMSgjSbImKE/Z7lsX1lkdTiF0tjBDqlqNie+zMUsjPkQVH9
 qVzme2ry1K2D/fe6OqB4TZTznqd3WBI5cl4kmaZ5rzs+cDgLAacpGV20A9n3wfVZMEiM9MBVLDA KYGhqVe3L36+D5Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDExMCBTYWx0ZWRfX0kjTGxGtP1ix
 j77GNoTGuTjC8u2yQlz9bLtJvQiNTI1m8Gff6pfZhVjLiv3SYS6PAL9Xe2e/I1melvlsbHkigiG
 3Awp4DNMC5VDvviaeO50Az95p6w24VohHFfO1gBK3l8SjmO6Pbs+fkIjw6+3lG54cT/1W6rgIww
 nLRZeKgGvd6DBWomsEsUXYjUQsaxUKm3EZIB/lZ3Rm+EFYjJY/OFRAfVP7Gu3Yq7ka4gmQS5ZLV
 i8XvOmVrEg9jA1dfKhXk61Avvr8ln6vsae+m3eoCb24wmIM46n18sE5ekjl1B++BjdCZF+jh6Lz
 pIoxALS8gojoo/MvPuZTZ0HE8Bn3RkqPbx1Ag97wm8F8miKhQ636eJby49wrNcE4YXO25dLOCfL
 Y3FCAHtu7nUjYcZzAoyIwp1Wvkn+RmsqF1N4sYXqcXcAhz4xZ+O41gjzbZ8t1QJy9IqKZB3FLq+
 +05HKe4fLHFoLBk2yNQ==
X-Proofpoint-GUID: edQPnA0HuS6JzjH1fnPhkcWXF4trhdUN
X-Proofpoint-ORIG-GUID: edQPnA0HuS6JzjH1fnPhkcWXF4trhdUN
X-Authority-Analysis: v=2.4 cv=brtBxUai c=1 sm=1 tr=0 ts=694be037 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=urQ9wjG1USoGuMoDBEOPbA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8ZTf1ciMPyF_Hyv9z0sA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240110

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mmc/host/atmel-mci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fdf6926ea468..3b4928f5b9b2 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -629,14 +629,13 @@ static int atmci_of_init(struct atmel_mci *host)
 {
 	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *cnp;
 	u32 slot_id;
 	int err;
 
 	if (!np)
 		return dev_err_probe(dev, -EINVAL, "device node not found\n");
 
-	for_each_child_of_node(np, cnp) {
+	for_each_child_of_node_scoped(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &slot_id)) {
 			dev_warn(dev, "reg property is missing for %pOF\n", cnp);
 			continue;
@@ -645,7 +644,6 @@ static int atmci_of_init(struct atmel_mci *host)
 		if (slot_id >= ATMCI_MAX_NR_SLOTS) {
 			dev_warn(dev, "can't have more than %d slots\n",
 			         ATMCI_MAX_NR_SLOTS);
-			of_node_put(cnp);
 			break;
 		}
 
@@ -658,10 +656,8 @@ static int atmci_of_init(struct atmel_mci *host)
 					      "cd", GPIOD_IN, "cd-gpios");
 		err = PTR_ERR_OR_ZERO(host->pdata[slot_id].detect_pin);
 		if (err) {
-			if (err != -ENOENT) {
-				of_node_put(cnp);
+			if (err != -ENOENT)
 				return err;
-			}
 			host->pdata[slot_id].detect_pin = NULL;
 		}
 
@@ -673,10 +669,8 @@ static int atmci_of_init(struct atmel_mci *host)
 					      "wp", GPIOD_IN, "wp-gpios");
 		err = PTR_ERR_OR_ZERO(host->pdata[slot_id].wp_pin);
 		if (err) {
-			if (err != -ENOENT) {
-				of_node_put(cnp);
+			if (err != -ENOENT)
 				return err;
-			}
 			host->pdata[slot_id].wp_pin = NULL;
 		}
 	}
-- 
2.51.0


