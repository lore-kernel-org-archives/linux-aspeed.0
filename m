Return-Path: <linux-aspeed+bounces-88-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01026D59F6A
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 19:33:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkFk20Gxjz3bc6;
	Thu,  7 Nov 2024 06:33:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730921609;
	cv=none; b=AgeK5jtRIzkMKwaYWw4yrD3niuHqGz2bdT2DlZth62zMoSy8P6TR8Ch/FM+Q5OQI0VnxodamWMTzBIma+eYlOrP1Z2RsyN6d5KHM0SS//2lZhtwDTM2yuhaDEGCYI+HjxBiHAv9GNAsUYCIEt81QpndxYh2Z0CXobtWXnrPE+hJULNJ9LaEydyD+6Pg7VAXRAhV3zTJAxCE9t+xjHGzcPKr+6Mq3V1e+UeVAIQDJ/u7o9qYWYoKIRh3ki8pjRqHCE03aCYZ9jtqfxCTtkf6l3ARjQaS6V1B0kMaVShgMO74QQ522p2NjAPzDTegnYh/p90sTN8QTgZaVRt24dG08Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730921609; c=relaxed/relaxed;
	bh=DWKirZ0Dp0Cmi7IM3wOgw90y9rfSjrE2uL6xs36CaBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWqKyd9nHj/Vh6PCQVvgVapCjSQ7LsGtsQxwZVOT2W6z2DBMOY0MzxFuDvJc/JIaP8PoqMKr3I29Zn4RqOyqKDssii8/WM1TQEAz1LxAJ/R49tNHbBIXWp8SFr0D4/6vcQnpeCQKrynL/4MVl0s1J54Qoial3Co7oIH2/Nj6oQOHmVBIJE05p8LpLLvr3O6hYHH5l+d1XVPROMPukOL8spLrAI+bZXc/XFIbLdpSZX9Ogrrvx9AqLrI/JAvIFpwmxf0DGFl0l5S/1MT970s8cCgQE0pS1L5RNQ+3RLCm/gzrR4weufHhTjWCY9D5gw0kOp79sA8g6sULa9pQJl91DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ENr9eiVZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ENr9eiVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkFjy3xbXz3bbn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 06:33:25 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ie2xn019000;
	Wed, 6 Nov 2024 19:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DWKirZ0Dp0Cmi7IM3wOgw90y9rfSjrE2uL6xs36Ca
	BI=; b=ENr9eiVZ04SS+raMo7YOwe/5lqseQep5DBV0mxtj4ejs6+D6s9ty+mVdL
	yo+w7ofJrydqMWdkYqNFTgqsJvSHqWSYDNIKk3RQinPE7o/7DwsjOSRwjW+22/fo
	NOQXk728926OMGZ/1lRM7eeVSwrloJhOXNFhdXdvxOKBDq7urArFKRw8yDyOy8Am
	Ppwq3cfxtHD1QpIF+Id4CF/WaTHp+E4LM6RM6CqeIs+xKQWaW3oL8lL/73tzAjRz
	F9z4tRgba7b7B4MNZZyh9Jk3EolaIePA/UuWabvLYAbPxYYD2Rct49Z3XD7LUETW
	Sh4vKmDjS/c3MGUnjRPf74t/icEog==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rdxc87t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 19:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Fpd2Q019096;
	Wed, 6 Nov 2024 19:33:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj6rhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 19:33:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6JX6Di47841676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 19:33:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AAF5805C;
	Wed,  6 Nov 2024 19:33:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850925805A;
	Wed,  6 Nov 2024 19:33:05 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.24.137])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 19:33:05 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] arm: dts: aspeed: Everest and Fuji: Add VRM presence gpio expander
Date: Wed,  6 Nov 2024 13:33:03 -0600
Message-ID: <20241106193303.748824-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-GUID: PJz5APyk2-yIADYsMYqQhSW6YClopaTn
X-Proofpoint-ORIG-GUID: PJz5APyk2-yIADYsMYqQhSW6YClopaTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=602
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060147

Add the gpio expander that provides the VRM presence detection
pins.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 27 +++++++++++++++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 27 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 513077a1f4be..9961508ee872 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -353,6 +353,33 @@ pca1: pca9552@62 {
 			"presence-base-op",
 			"";
 	};
+
+	led-controller@63 {
+		compatible = "nxp,pca9552";
+		reg = <0x63>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-vrm-c12",
+			"presence-vrm-c13",
+			"presence-vrm-c15",
+			"presence-vrm-c16",
+			"presence-vrm-c17",
+			"presence-vrm-c18",
+			"presence-vrm-c20",
+			"presence-vrm-c21",
+			"presence-vrm-c54",
+			"presence-vrm-c55",
+			"presence-vrm-c57",
+			"presence-vrm-c58",
+			"presence-vrm-c59",
+			"presence-vrm-c60",
+			"presence-vrm-c62",
+			"presence-vrm-c63";
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
index c24e464e5faa..27ded3bba66d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
@@ -355,6 +355,33 @@ led-controller@62 {
 			"presence-base-op",
 			"";
 	};
+
+	led-controller@63 {
+		compatible = "nxp,pca9552";
+		reg = <0x63>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-vrm-c12",
+			"presence-vrm-c13",
+			"presence-vrm-c15",
+			"presence-vrm-c16",
+			"presence-vrm-c17",
+			"presence-vrm-c18",
+			"presence-vrm-c20",
+			"presence-vrm-c21",
+			"presence-vrm-c54",
+			"presence-vrm-c55",
+			"presence-vrm-c57",
+			"presence-vrm-c58",
+			"presence-vrm-c59",
+			"presence-vrm-c60",
+			"presence-vrm-c62",
+			"presence-vrm-c63";
+	};
 };
 
 &i2c1 {
-- 
2.43.5


