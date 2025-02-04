Return-Path: <linux-aspeed+bounces-634-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5053DC02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:44:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnXMY63f2z2ypx;
	Wed,  5 Feb 2025 05:44:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738694649;
	cv=none; b=S3x6Nwz7v+L1H+AjAmKKC3+QI4wEDJiPpTiK5Q7JqvEosMReNGLcwickHKac1N9YyUbkqdoejV0VNRCQcRVAeLYVW6gZnzMoKD3Qh7236FGOzSJfeK+t8Ay493rtmtrJivGmdpLNXykGaHwk9HxSx1B4ba06flZ4JystlrG0JPWLiulGHlDTCqzRZrcE1IilC+2Uh5vS2t/CeEHjPRiltIY+jvBRKLneUu/mUePtLDJoxvqmBB4VkD7ip9bpwrdyPzrBk6RKyAv3B36zFDH5+kS0KnrQxPO1t9rm6TqDqfuKdLwnNHYb9QZj0xm2o+UwiuNK7uus55V7BdjW9rD9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738694649; c=relaxed/relaxed;
	bh=04WzVX7EtQWTPKmKKzRPk5axEY8o7nIvjJi2dGAMQZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7Kg7dypZL+6oC6jmWnCxUH054/WYMD+SoyiJW4107BIXA01Qv3tjPLf/jI3gNeEVtAsieU9AMN23rfMGEipIkyBiAmkYVDXzzWfVdRU22p9QLW+1EANXafRHaNO+E2jPxzqIPCnSFneDf65HSx2x/RhO8ndTCg32insQbth1AUScu4l+Qqo33nvjmwsF2bXFNhm3pXi1tB5ohWxgrMkA7pXm2AKC+WFVnf9GTCSi7yLBwhXy0RM9Q69zDE2JiO2Sc+oLWMnpVwFUGCcpcunx7UFhOmcMW5atHS+72BbR7K5xJlCGI/hO0MxH+lqNw05HL/OscVFVbIlQuz9pwfeVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bCqzJ9sw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bCqzJ9sw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnXMY0kQ6z2yXd
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:44:08 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GFZiY024517;
	Tue, 4 Feb 2025 18:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=04WzVX7EtQWTPKmKK
	zRPk5axEY8o7nIvjJi2dGAMQZY=; b=bCqzJ9sw5eIoAIFEjO8YKD8iquwuAeNeN
	8eKhFnSDMJORUz31CY0qS0d/EK34valyz3OuK6/qy0U/KJLxv20vvOM+i+IeXZFp
	mEz6KCCzKMMXnnCTLNQoJegGaV5sVfKOapBHruB9bNbBqiI3cBeGldpR3GIxWxoO
	s9YWqvlpE+klrKf63RKl9ICe6jB7H/GSHXSXe7sDg7oHZYNkM2zZ+euj+ZMYjXiF
	utWKqtwP6phYKR5QSqYmwZz2Cx7Qx8yc+fHI6E95YQarB6xuf7hqEemBrUlQ6pFQ
	Lucfpp66quMTCWun/M5I+3uWXzkJzo/wuuOc+7A8PLV+LRqReQImw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kcq7uvum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514H6LgT005251;
	Tue, 4 Feb 2025 18:43:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jvq1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Ihlw99765420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 18:43:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42F7658059;
	Tue,  4 Feb 2025 18:43:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6339B5805C;
	Tue,  4 Feb 2025 18:43:47 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 18:43:47 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v8 7/9] ARM: dts: aspeed: system1: Remove VRs max8952
Date: Tue,  4 Feb 2025 12:43:33 -0600
Message-ID: <20250204184337.3896834-8-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204184337.3896834-1-ninad@linux.ibm.com>
References: <20250204184337.3896834-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: bs_bZmDHzzM5Ahk2dxmYjyEKwv4H_p5L
X-Proofpoint-ORIG-GUID: bs_bZmDHzzM5Ahk2dxmYjyEKwv4H_p5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040140

Removing voltage regulators max8952 from device tree. Those are fully
controlled by hardware and firmware should not touch them.

Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 34 -------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 56357dda4b0a..7d9f6a1b2637 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -486,23 +486,6 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
-
-	regulator@60 {
-		compatible = "maxim,max8952";
-		reg = <0x60>;
-
-		max8952,default-mode = <0>;
-		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
-						<1050000>, <950000>;
-		max8952,sync-freq = <0>;
-		max8952,ramp-speed = <0>;
-
-		regulator-name = "VR_v77_1v4";
-		regulator-min-microvolt = <770000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
 };
 
 &i2c1 {
@@ -1198,23 +1181,6 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
-
-	regulator@60 {
-		compatible = "maxim,max8952";
-		reg = <0x60>;
-
-		max8952,default-mode = <0>;
-		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
-						<1050000>, <950000>;
-		max8952,sync-freq = <0>;
-		max8952,ramp-speed = <0>;
-
-		regulator-name = "VR_v77_1v4";
-		regulator-min-microvolt = <770000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
 };
 
 &i2c11 {
-- 
2.43.0


