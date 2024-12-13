Return-Path: <linux-aspeed+bounces-230-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C21E7717F
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 14:51:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8sj13F2Nz3bTn;
	Sat, 14 Dec 2024 01:51:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734101461;
	cv=none; b=MFRJR5ogU+TKhgHtpjEf0oK7jlW3laCTLQvVOmxtAqsMS6JZ2rWfIFaO2fPs4uqKgznK/58in6IFKAg1KNECKnUp5aAaH1S4RHF3NmmUDFR/gqvdlaF8Ll5LoWfFvqa8Ss25OPFx/zz9xvtJ90J55f/LvjETEyn0jw2zW2TK+WGLRyB5a3TCYrjLEjOVaD8v51Gbcmu/JUHczDUsEc/ynmEuu4iSQtIkUlMjGtDlT73/7lvDFFfz2G3pQ2SGjGpYoYP9RHT159f8cDcnuNuFkfFC2cS7ll+1VW62+VKwEERZX84DZvA1GMOMQ9v/7mWPInAVs9NrOr5S2tOAivDIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734101461; c=relaxed/relaxed;
	bh=JAD71IwOAA32z1JJ/0HMb/xqrSSgnABthIuidtyzRmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms+vbD94jC9m+abJES44Q7ZXeaq7tlSk9xIJMU3npmcUsHPPHEk7VD37/LCPlsxf1WKYM2Oh1TdLurkF4d9/zB2YPg+OAWT4af5c/L7zHpdD4ZrWRYlfcQ7sMIcps5bWdFrckfXsdeQ51VW1IHQcwqwlGWWCIUwA/uwIyvW9LwV/hjMTSNfn/+FdheloKI36vLSPEbY0JX9QIKbZPumSzkA6jOKsaBOBGFxzF3iKciDwRywygDCrbt/yXMIE1YHEQ92Cz2BqvQaoXr6SC7gmpCx6EvopILtRZEM0sg8ySfR2jtj9hKNVcCOatZiUQlXCxo0pZ6sWdm+9/OVhBxHHEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RN7ny8VN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RN7ny8VN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8sj05b6Bz30hC
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 01:51:00 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIu8Q017056;
	Fri, 13 Dec 2024 14:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JAD71IwOAA32z1JJ/
	0HMb/xqrSSgnABthIuidtyzRmg=; b=RN7ny8VNWs4Bulybi304DEF/W6Avm8zMo
	06oPR+A2AaWUpGkhAqXsc6AeH5gFh52gki/xcvBBk9vDmDvyJiYSzfu8+Q5orFZ3
	ygEWzyA8WcQrerog4hYSVwqhLkBS9ItZi/OsjfB7JWDxyUSeglaixLrfYWkiZvtT
	ELByXakHpQXcMxAPhPyeeXiKrVXgaYFHOAzCshopTinT7YSZe2Xv8EMNElioDwq6
	WbmjEU1KF2NC8wWA8it7AXEsdFcDu2DXFVlYravyS05KjOQOaY5pdQczaB9Vwtkt
	767a7P8s0f1YJSurTd3tEVJ6z8JbneQE5EunbGErob1Ep6RuWGNVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbtv9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDD63g6018618;
	Fri, 13 Dec 2024 14:50:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kx6kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEojVj18612950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E78B58052;
	Fri, 13 Dec 2024 14:50:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C58BF58054;
	Fri, 13 Dec 2024 14:50:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 6/8] ARM: dts: aspeed: system1: Remove VRs max8952
Date: Fri, 13 Dec 2024 08:50:32 -0600
Message-ID: <20241213145037.3784931-7-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5bAFWIizQVQFb68IYlBMzgxTpdTeSbAT
X-Proofpoint-GUID: 5bAFWIizQVQFb68IYlBMzgxTpdTeSbAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

Removing voltage regulators max8952 from device tree. Those are fully
controlled by hardware and firmware should not thouch them.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 34 -------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 149b9ad23dbb..ca2d4a292687 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -514,23 +514,6 @@ eeprom@50 {
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
@@ -1227,23 +1210,6 @@ eeprom@50 {
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


