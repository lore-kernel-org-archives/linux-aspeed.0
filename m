Return-Path: <linux-aspeed+bounces-106-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CE1D5C0E3
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Nov 2024 14:58:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlMX40Fnxz3bwk;
	Sat,  9 Nov 2024 01:58:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731077923;
	cv=none; b=mK5e9mgOIrJNuhyr17yXIYeUSnYYUSU8GhT5MkZg819Ufv14382vKLRyCehNUx74cxp2M5YrVbwiyQB2VVQ9x2KMSG1qGwo9w6TV3Hdy/zQ/vK8COypdG6iSa6sYlHgLvg+b2aSduOI4tw5szcT7xjQ0+2BuZolGYAhA4gwXwsSuAfmR3qZ8kN6auTA6tlioSjacicyxL3v2ri0TzE7mb0APyYTdH5nkYVqTtm57OsCTR8myrwsc2uBFrqYEhWrh9+3iIHQ6KgDtiQ9tEMZmpCIEQejqPc1mc1S2QfX2QDjCBn8QNru/4W4h6c7pAYipQ20qlP67+zq8Ab+BqrprNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731077923; c=relaxed/relaxed;
	bh=zbQ/7ajaIUHGgWotTYl7JBdEMFP9k+dUhiJRbgtHLw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyBOqyBcbqJDGl0AYfEgdSh7cEVwE9zxuqgpBns6SM+kdjDOFSFJ730TxjNWqv3JiCPu9Sv29QBJdULl6mYeicGrlz6EJmi+6RKVIcWreLkqZ9eJoaMkGF6H9fK4hOWndua7WwZ5dUPJHrZJ81lZzJZJPbTexKK1kal8t1buq/BRlMtnC4vfr7S455gYPCI+Tn3st604GuuWcFyvt8hz5nCknGaUafPstRDNc2qhCfMr8FzEZ9RGnJpWnU5CHlL0Gp3qURQNcxmkCRiQpbY1Rkjo/ZElHDs/XO1P+LgrC/KN1RZsgfH33rAnX/F1gcLSKHQh18rHXCmKp96NVfrbnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XIBNqvHO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XIBNqvHO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlMX21DGhz3bw9
	for <linux-aspeed@lists.ozlabs.org>; Sat,  9 Nov 2024 01:58:41 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8DBXp0001699;
	Fri, 8 Nov 2024 14:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zbQ/7ajaIUHGgWotTYl7JBdEMFP9k+dUhiJRbgtHL
	w8=; b=XIBNqvHOF2R1YdeL7CXowNR4wqAOMUzKpbgEDXznKwrIgP8d5dSMQImlM
	8onEXw51YTzdg56FnLx4UVpEcDMVubquzpniNtvYz8wL/tNyEcD/KI7kde9nAOc0
	VK31Bck8XMMtSoWKaSQAwE6gJvzpYd+nEhAP4jlhA9YlL3tHzAVKquWzrbi3VQsB
	da94cTXxg6dwr6NsQPeDDgYzjN6VsahH5qUsnCL5T2d5gP7sn+QlaRpLNJK5JBHj
	Be6vbbRCbMVUKydf0TyqpKbPCqZT2WMzFqY1J/UlmsbVXUW1OXhbhJC/U4TBqEkv
	o28S26i1xJVkf2F/GhZDko/8DcQ3w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sk9s8hxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 14:58:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8EQCsa008433;
	Fri, 8 Nov 2024 14:58:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywmjfh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 14:58:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A8EwO5E24117922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 14:58:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E31A65805A;
	Fri,  8 Nov 2024 14:58:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37E558056;
	Fri,  8 Nov 2024 14:58:23 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.24.137])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 14:58:23 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] arm: dts: aspeed: Blueridge and Rainer: Add VRM presence GPIOs
Date: Fri,  8 Nov 2024 08:58:21 -0600
Message-ID: <20241108145822.1365072-1-eajames@linux.ibm.com>
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
X-Proofpoint-GUID: uEoh45k5zx-eHpSrTI_hq81m4nT7e9B5
X-Proofpoint-ORIG-GUID: uEoh45k5zx-eHpSrTI_hq81m4nT7e9B5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=318 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411080122

Add GPIO line names to the GPIO expander to describe DCM and
VRM presence detection lines.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
index 5f9a46c2abb8..d504ae84db89 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
@@ -1232,8 +1232,8 @@ led-controller@60 {
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-			"", "", "", "", "", "", "", "",
-			"", "", "", "", "", "", "power-config-full-load", "";
+			"", "", "", "", "", "", "P10_DCM0_PRES", "P10_DCM1_PRES",
+			"", "", "", "", "PRESENT_VRM_DCM0_N", "PRESENT_VRM_DCM1_N", "power-config-full-load", "";
 	};
 
 	led-controller@61 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index a4aec3010456..eefc69d0d032 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1280,8 +1280,8 @@ pca_pres3: pca9552@60 {
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-			"", "", "", "", "", "", "", "",
-			"", "", "", "", "", "", "power-config-full-load", "";
+			"", "", "", "", "", "", "P10_DCM0_PRES", "P10_DCM1_PRES",
+			"", "", "", "", "PRESENT_VRM_DCM0_N", "PRESENT_VRM_DCM1_N", "power-config-full-load", "";
 	};
 
 	pca_pres2: pca9552@61 {
-- 
2.43.5


