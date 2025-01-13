Return-Path: <linux-aspeed+bounces-451-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2359EC02185
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:49:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2rZ4Klnz3d8t;
	Tue, 14 Jan 2025 06:49:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797742;
	cv=none; b=XNIakHNJNw3KB1NFgf9kh+bAnZQUW8nLiO7LMVbZN5SIShm7qvzp4AkgVKddizgqaQ7y8ijOn3J1Z7QFSBXl81oAYJ4E1/PNLSlblYMU2mkJ0FKTDVqi8EQ7Q2LWEbi2SS7NVxEQ5mqXVS99bG0Hxz9dCXPIGsTKHIq95FLmtKCMdHU2DWGaqObisactu/ajc8pcHLJLbXcqGSuyeOsMkwiCZaYmku+oDLh2AO0iWk53eBx1LpAZCM44/sRYCnRZtMmtPevy7XrzSMAVkidA+qaj0BQQuhnQJ3D4zv40C2YYA0+ZtFgFB7oMhLsLrq9+oY/pjjjlVowZbzW5nB1gLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797742; c=relaxed/relaxed;
	bh=zJ3XITMWT7pMwbAprF2XAaRfRk4pBMPEr9iYYHQbiEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPNKBd7MeYZqnuP8oA6O/Cj6U0ln+o8Ddo9Pe14kdfyaepklIntRaDehjhM/dzfFEzABhqXU8zZjMRm65MGCepEpuu1gGDgAikxgwGO8Y/soK6sHjDp9c7D/2GSj5kXD6HrVPysxV6Yo2HjNXfkJNggStrIqfzS1zh5VJdi0HNP1NHlJN6lsBLYpDray95/iJ1PuU0tf9GqyJ4gfBmYQq4Fw9gzEhkGKbP0vs2Jrc+K2sRMjDD9l74QC8dH7ODqCOX0M4ECJGQE4/GqgJt3+xStC8ZJYBJfwiQ0nT++CnBPEiVlW/mLcHVd7jxCDqfLSTcJExn7zGcskSacw0QhpaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mSe+8Dse; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mSe+8Dse;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2rY4tChz3d8G
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:49:01 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DEilV5002387;
	Mon, 13 Jan 2025 19:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zJ3XITMWT7pMwbApr
	F2XAaRfRk4pBMPEr9iYYHQbiEo=; b=mSe+8Dse4xeX9f0BGPpd1plgQpeGLgl/y
	UyLpuKFn0ws9gOPmVmT9ANnc2MBzm3ryN6TLP0/KqoEHAN+ZD8SFxOwki8Aj4MlG
	NmB72ftRMyOlhxjkUMA2UgAhy5wiZS+3uesIt3+ZpPAaF+P0iVpZvue1j2X05O0K
	QTCV/c1zgO6nWkGzXPvoDZCUClD6hwhXVtWJbVBTaej/IDbmaFLWqTdMoV3QgEHD
	ZzB5+eqQY14iIncBW6WVgXZ9tiocShqmKOvx9nPNK5kbtYiH/RlglTdaZkZWa8ia
	FAlnikIIE4wrG/rbhpMx5WHM51ZpokfyldkKcLOMvKwm0r1B0Z8Kw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uaguvtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJk0M1028162;
	Mon, 13 Jan 2025 19:48:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uaguvte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHqJME016491;
	Mon, 13 Jan 2025 19:48:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1fgd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJmW6227525716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:48:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93B065805C;
	Mon, 13 Jan 2025 19:48:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C62858059;
	Mon, 13 Jan 2025 19:48:31 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:48:31 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v4 7/9] ARM: dts: aspeed: system1: Remove VRs max8952
Date: Mon, 13 Jan 2025 13:48:17 -0600
Message-ID: <20250113194822.571884-8-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113194822.571884-1-ninad@linux.ibm.com>
References: <20250113194822.571884-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: c5a9zqPiqaP8EBHBI95776q-twvL_7xi
X-Proofpoint-GUID: AJPz-QquAw2JAWV1gLX1GzgVvYwpph_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

Removing voltage regulators max8952 from device tree. Those are fully
controlled by hardware and firmware should not touch them.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 34 -------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 1e0b1111ea9a..089a8315753a 100644
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


