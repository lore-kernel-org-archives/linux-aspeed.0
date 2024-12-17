Return-Path: <linux-aspeed+bounces-272-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52E2E7717F
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Dec 2024 17:36:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCP9p3qrDz30Nc;
	Wed, 18 Dec 2024 04:36:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734456974;
	cv=none; b=GBunJ7dXHqPmOqURAOKuuglmb57J18w7TEqxhjpUiFgyxZjhPpSzW+6qqoIZeJ2Nr0HfdZnVY/zOfFCze0qptyOqjkHyOtu0xUr0kl1GbVVkTnSAIcdoqHY0YbefZJHVA3PMY5c9c+77bjAJVWCoAU+JDWJVo1Dlw5LhJ9UZliZt4F8uGbuXKB4K/wF3o/sfVZPyesz9BfbfrpHLWCih4iwS1wHJhYmldq7qYAk3cgfrsEBvm3edYbuyCCi5Ya/zU7mVgvcwnHWE6IekjLYlE7ak1s2K0/MToTRyM8pfrh8XXPIHNH3g6Gx+PWeq+JgjRLhpFrIOWGPP2B2Ppr1xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734456974; c=relaxed/relaxed;
	bh=cK+l/BTqBMQlSMv3Wwmy81zGJ0D0dTlpVAditAsXNbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvQX9B5g79C6LVYVGnAetEQjyHhPavojc9SY1CKmgxW0uBM9PaK4+hDt65TEaH5vyQqXSenlJjOCMRQkQL+1A8RvDMQuJsJxJVY5HWuLpwvL+HPCI9OVgwh8cURs08Fd5zIOKKD2qsyqKB61NforjdgxX2yrhXaePG0OEzK6besyRsJtqSOnog8dUzW9qD+3p8MuL0EMkhWEFqFbWXwBbDu9JpQPzoQSgnAnStaRAyy2p02xz7FoSZ1wK1sh4pEB71vA1vjrI74Bd7OKsiaW8DVYUZYhU/MDaYaIXss2eJ0wxD54Lns1HZelsMrRUoxMpYY7Jwfn6tkedwYsHpOzGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l2Mmo76g; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l2Mmo76g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCP9n64JLz30NF
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 04:36:13 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHD0OJp028091;
	Tue, 17 Dec 2024 17:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cK+l/BTqBMQlSMv3W
	wmy81zGJ0D0dTlpVAditAsXNbI=; b=l2Mmo76gyDIF7FxMFcSPWHqrp74Js8rrc
	zUnTTVgPQC+jAeRur83qU6kkVEj0B05uuTGWwtf1KRL4hWEzqaqf9XThyD2rZOdi
	VVQnxdcvD4D9ds4fSoSMF/bKBXZUAXVleHjfQhGgQUXPihWDVlyqLVlEZ3Ofe7CS
	GObDm+rzwpUdTzp54lDf80wriKq4AARgAwbN8GZKhShYMOa35xMQx5qat8tT2dNv
	y5Is41Ghmf6ne2c6JFBTKnKynPpp0igI/WFJlor51deQYg9M7pwhmiboX9SVPRO+
	wP4czuq/EnNVAvzW78jmUFx4/jv42QQp2XlrjTHLIBxNiRSz01Gww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k9t6hef5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:35:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BHHNtAr023671;
	Tue, 17 Dec 2024 17:35:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k9t6hef1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:35:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHH341h010923;
	Tue, 17 Dec 2024 17:35:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjk3mgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:35:46 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHHZjUX18416144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 17:35:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9270558060;
	Tue, 17 Dec 2024 17:35:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F9A5805C;
	Tue, 17 Dec 2024 17:35:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 17:35:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        eajames@linux.ibm.com, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
        Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org,
        peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
        naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
        patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: hwmon: intel,crps185: Add to trivial
Date: Tue, 17 Dec 2024 11:35:34 -0600
Message-ID: <20241217173537.192331-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217173537.192331-1-ninad@linux.ibm.com>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YEJ5j0YNKWh7fOd3NS_AbeHVFFqlrnFh
X-Proofpoint-ORIG-GUID: oHQORVIhY3FjKRcbtuEduCLBHI18EaRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412170134

Add INTEL Common Redundant Power Supply Versions crps185 bindings as
trivial. The hardware does not have any resources like clocks which are
required to be included in the device tree.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 34e8ac1ddc24..fadbd3c041c8 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -149,6 +149,8 @@ properties:
           - injoinic,ip5306
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
+            # Intel common redudant power supply crps185
+          - intel,crps185
             # Intersil ISL29028 Ambient Light and Proximity Sensor
           - isil,isl29028
             # Intersil ISL29030 Ambient Light and Proximity Sensor
-- 
2.43.0


