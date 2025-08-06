Return-Path: <linux-aspeed+bounces-1920-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E93C87FD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 19:21:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by0Xb1rb8z30W5;
	Thu,  7 Aug 2025 05:21:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754508111;
	cv=none; b=Df2G2fJxhCpjoyw2jgoS3/iP/r7aEhv6iVgNR8tlZmOq72JEixzo+OcG0OmVPDQFzFOYhDhbzrpUcyrAiJXTmAO3OuYaE/Qh45DF2B6R+njChK2BtY2F0hlPHPrVbctqk+TglxiM8jBBRW7totxjTxydyPSpZKy3JmM/R8GKtD/5LrwEpnNk5QcW66ceYIs6WDGanq4wZwHabE6z5BUSMMAdI+3NaRNQDTKTdKKWcJasLzJiUwOI7nTTPpD7v2uw75atnz86p2ix86GL2xblZhM+/7hEJ0Pce8wgqWqzxvhMRoUGKoY+fKz9n8xbu6mqpQJ9WMdL+etJNJiyUE6iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754508111; c=relaxed/relaxed;
	bh=CgmcA+zBVvKl4Gmn6AZd6bq19anghxG3Qxq6uTcndds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQpFKlWLEdqvT28lWoO1RlRpX8/BDLcJKST9x26Ap2oaXiYns54p7FVklnZ82p0s+8w3EX1STNyaMnkv8061gUIGSczP/JbZThIPU6Q5hmBQtIPVWf/MEyz4CJsdvHH1A0tTDutPRPgu10K4JDFGBTn52L6skr5feOVu5o7/r5JTwG66JFEu/IfKZX4vbvvKn57ZufbMe5wn22jeFeOMVX24rIbM6v8rEU0df7b42Kp3FT8/WLommgOajnhS3jpUbbWMeFw7N4LLDlDgjMYgTwXqWZ14hOm+eFlK6sNI4JtOI6Rn+yJZRiHMmtu2sYRDW+gyLZCozDoC6jTJxpIhjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L5466qMA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L5466qMA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4by0XZ27Mlz2ySY
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 05:21:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576Icx2M020776;
	Wed, 6 Aug 2025 18:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CgmcA+zBVvKl4Gmn6
	AZd6bq19anghxG3Qxq6uTcndds=; b=L5466qMAAEALlUchwULCrX0E7vi7nE+U1
	s220UCe/lHSgCO0yN49sJMoJvq+6abD62o4wd8LJcI1+7iuaDFc2PjnimXTmxXzB
	odl2k+nbaenw6y9gKSaCPDF4yETgUepoA8+Otn8X3Jjn6vxpStjn1jFpjycbmxst
	v3pDy3Gf7HttbHcMSE6MKAZcde+eEErp3cqsVwJfT/gLJSPTEURvKKrv4Mq2JLfT
	Fa1X2TcNvpqVClG02BOifogr1977XnqG5iZb6piitf3HLwwE7og8mfj21pUO8+R+
	VCyDH9i6PGhP0S/EWVFy3UUsAzK04yL6QHzOBURk5GAHfawS92lAw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq635wgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 18:47:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576GKApv007970;
	Wed, 6 Aug 2025 18:47:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwmw160-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 18:47:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576IlCeb22479402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 18:47:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B36B25803F;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81BA258061;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
Received: from slate16 (unknown [9.61.84.78])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v3 1/4] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Wed,  6 Aug 2025 13:47:08 -0500
Message-ID: <20250806184711.1882725-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806184711.1882725-1-eajames@linux.ibm.com>
References: <20250806184711.1882725-1-eajames@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6893a339 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=3wLJMGCjkU_6NCSB5IAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vFYjQhCKW4qUUm0W0FovpRRJE-G3PIQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEyMSBTYWx0ZWRfXzCoYqaA09BOt
 o05xi6H23lTK3Y3ccHA12AoTYTc8pumTYj65n4jvbY445JpMAMQjop2pyOaP5rSXF85a0FPeE15
 x0s+uyKPAufQct7qI/C/QzCn4N11g+JAxHjurh9wfv6QwPOpxNDphojETUQ8UGCmjWGhgxM0G8a
 mhCxKOYoJZB8TKz9YeFKd4e9AwmhVBFKK/yAozB+iKiznfKxErdu2HEa+2HhW69d/xTc5WpCSfp
 NS5fO1fu3b2Db5ozAa76uGQFQ3BnM7cfgLxkIDLvklT5lLk0/rbiJM/CmXs1vmHH4Og6h9IG4us
 PD178Kvibl04icnQFcNN7EZ8u1bvUDAQnaDa4o38vRFDTGqPqn9/hoBS+r8l6vcWYFXQFNgCU17
 0V7t5C5N7++uW1MF1GtEouihP9WrtqaUkmbdcHp36JFKfTfh3TPhgJ36sTC3dWtaA4hEal5n
X-Proofpoint-ORIG-GUID: vFYjQhCKW4qUUm0W0FovpRRJE-G3PIQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060121

Document a new AST2600 BMC board for IBM P11 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b3c9d3310d57..1283ef1a3520 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - ibm,balcones-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.50.1


