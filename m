Return-Path: <linux-aspeed+bounces-131-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF770D68BDB
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Nov 2024 22:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xqs8z3bcSz3bX5;
	Sat, 16 Nov 2024 09:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731709667;
	cv=none; b=DGRfydAT/voq5a8K/J4qLZZm/HrVUeHh0OMzh/eBAw77vyi4x19HveEdmotuijvskLTD+P2fMlfIf4PPML+uTHAtIN4kgl7oVGlw9Ugrv3//9Ejwqw88H0Efe3B7wcIJ4dyu45iOGwCYcG1UuPTnd/3faGkIPwj0bRwv9UH82YCiCi2NFnM4rNKnAfMlyBLAtb/3s6BU8Sk0kqwH4eilI/P40/BTQRr9gSP8Ux5UNg2vlJM6rjM+Gi4VsfHYU/JZAKZ7lQ6M60yRrkoH3iXnfDRi8mxeAFt6FgG1LjvzUrzVPR6/QOX7EZ7LIu732myuz7CpBk2AjZH4YGHQfx8q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731709667; c=relaxed/relaxed;
	bh=qF+mrQmSnUbowuzaVvbuJVUuttwpmgemw8P54JHvWpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiLakpgF205UZPiyDZ3QLSHewEx2xaFxzjIRW9Mk0OhC1H5TDxrtveJPWnuaKCgD5A8LwnNBW8Xyf2E3XHBHyv9BjequYc3Uah0vjWbipRmcBeKBv473MQfRlkJzgM0yc/o5dkkiGFcoxW87L6LXWguQTwAQTDaotoj56WDQUwuHRyXzMEgShx1jZVQ3cVsGHXZUG1VFqVOCIqW11BGnQN//xFTrbm0/60mKP6ysGKEhmgJuYdHgzkqkbFFSjQ8hT52Af3U2p1jleK1gVgtZED5BUFXkBvjLnOeob4qlga/D3Fx8n1qoA2CC0cWdM90J+Q1dFqLzPf3QjTMzHpIfPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bkwDMOyC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bkwDMOyC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xqs8y1b2tz3bX1
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Nov 2024 09:27:45 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFLQIiq003900;
	Fri, 15 Nov 2024 22:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qF+mrQmSnUbowuzaVvbuJVUuttwpmgemw8P54JHvW
	pM=; b=bkwDMOyC2ZStTUq3RCfq6jBWOqf3MIwUkQi2feVIVV+jMnzpQRSQOyyyL
	5TOwYrvO6YuOsOI/8KTq3iXhGEy/r903MTUCqDlp1TL7Kb6qTQ9f+kBOduvOuTgl
	i7SjUFWlqeKmANnUF84Wb3t6vTxq3C8uxl1V/qCxdVPft/BwgY8FsOsvvH4BlUIO
	g5ipC/9LZsFLu3AEuVEuxZymQywmFF46c1qiIsxnPxDYhmg1Cw3ysht5twKQpIfP
	ByYMCJnktw0TrbvxATE8p0ZBCzUmbQMcSWqrXBAVWhUj3++SEFbg6QJSvKqZafcN
	zAaVTN3lDvUluwAPTRQNAfIzhEp2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuy1nth8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:27:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFLRhAg029721;
	Fri, 15 Nov 2024 22:27:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmxccu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:27:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFMRN2j48300424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 22:27:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200F85805E;
	Fri, 15 Nov 2024 22:27:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E347858051;
	Fri, 15 Nov 2024 22:27:22 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.159.220])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 22:27:22 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] arm: dts: aspeed: Blueridge and Rainer: Add VRM presence GPIOs
Date: Fri, 15 Nov 2024 16:27:21 -0600
Message-ID: <20241115222721.1564735-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: MSJwhyRl3RV_-5CFans8ZY7eUkqKx3kg
X-Proofpoint-GUID: MSJwhyRl3RV_-5CFans8ZY7eUkqKx3kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxlogscore=435 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150186

Add GPIO line names to the GPIO expander to describe DCM and
VRM presence detection lines.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Fix lines that were too long

 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts | 5 +++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
index 5f9a46c2abb8..bc4c46235421 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
@@ -1232,8 +1232,9 @@ led-controller@60 {
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-			"", "", "", "", "", "", "", "",
-			"", "", "", "", "", "", "power-config-full-load", "";
+			"", "", "", "", "", "", "P10_DCM0_PRES", "P10_DCM1_PRES",
+			"", "", "", "", "PRESENT_VRM_DCM0_N", "PRESENT_VRM_DCM1_N",
+			"power-config-full-load", "";
 	};
 
 	led-controller@61 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index a4aec3010456..638a2c1c7892 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1280,8 +1280,9 @@ pca_pres3: pca9552@60 {
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-			"", "", "", "", "", "", "", "",
-			"", "", "", "", "", "", "power-config-full-load", "";
+			"", "", "", "", "", "", "P10_DCM0_PRES", "P10_DCM1_PRES",
+			"", "", "", "", "PRESENT_VRM_DCM0_N", "PRESENT_VRM_DCM1_N",
+			"power-config-full-load", "";
 	};
 
 	pca_pres2: pca9552@61 {
-- 
2.43.5


