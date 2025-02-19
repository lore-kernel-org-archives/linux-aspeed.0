Return-Path: <linux-aspeed+bounces-783-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F0CC021B1
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 21:27:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyqHS33Jtz2yGs;
	Thu, 20 Feb 2025 08:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740000468;
	cv=none; b=WLyDU1QCmm3ixWdu8PiPXe/lYbZfYgnvlTA3RthggLk9bqS2zq5e22UOdnOdyMvV9nv8N/Lx7Vansy/9F002WJwZDAIoD1ME/1yhvrlvMmE7HPjmX93kDaxmGoMYej+oJZUXbirsGArAUUBFrlzIobLtd2xoN1Bb8VaxNoK19NKwi2yfycEksExKHuKao0j3WtlQRLZ8I7RdmsYf1c8QxnYpWpfoRQClUL69R72GHFlT5NXFaHXR98s6IDwISp/O9yR3kkNjIEmJmFLgOrfAc+ZYB+73idTcCmbj+NfCwhvN1genjx2AOkywsP65XdJkYwUDHdwu2SEwbe/y1JzqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740000468; c=relaxed/relaxed;
	bh=aA7lB82hsTfw9UnDwJnvWUB0RJTi8MOrkrwkpNiGlAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POTZBQHPPQp7DnHW45yvhe/xm/spLnSF/yiXz9CGS7zLrbp6MzrNPOhLmqq3+YWAHbgTM8R0zJlIrOtiwojcwQ+GMPjkYCmRrdNHG2pfHe+ynsiMs/o2qf/dSrSXMnRLFWtbp2OOS0kkt4UFfNYwJqJhlZUAObPD35u45JX29apZm6kKOLcpF0Mz6vp6wu0magPBgQDPdjq7WM8VpL4LXNGwFKr991irHnHEOzhIEc01Bmb/+uG7Vc1Kz5LZ/rUAy6fupg1mxb9oz7gjC3mcyeBHMCthj78ElvISGOL1+ygiaXm1qU1SuzMlWj1gOI9TJXOLEiU2JRxDb5ih+B9AIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r1SOU75d; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r1SOU75d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyqHQ4Pvzz2xs7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Feb 2025 08:27:46 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGYMTZ005303;
	Wed, 19 Feb 2025 21:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aA7lB82hsTfw9UnDw
	JnvWUB0RJTi8MOrkrwkpNiGlAU=; b=r1SOU75dIWOMo+YJPA4bStPgMx/JxtZjw
	Ur2BdT5WFsfLDcAe2rslh4uflL1KkMOUBfbeufFVF1q00PlPtbES41DL5y3oVrOP
	1Vy0k4HCSaZLnKdheK4Nhtk4LbXrJBMifNAs28pXVbIt/+gm41jD6g9y7+2ipeOi
	MjES7ymedBHQziI834kSZPpPCsQ21Px2UI22ZaAoseo+w6+ODm86dDwEV4hGW5pa
	0I6eSHpdoMJ3T/QBtCqr0wCkrpMh+rZPOTKFOAIAJV16njwkR9m9lk2ILen17km0
	8fUGWKWNgiRq1pzOoJFKPglur6c5XkI79tFprkoIsbuJDutRDsVhg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650d4kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:27:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKYv2j030158;
	Wed, 19 Feb 2025 21:27:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x6cs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:27:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JLRa1k27329132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:27:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7054E58051;
	Wed, 19 Feb 2025 21:27:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F63D58060;
	Wed, 19 Feb 2025 21:27:36 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.48.195])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:27:36 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH 1/3] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Wed, 19 Feb 2025 15:27:33 -0600
Message-ID: <20250219212735.1365050-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250219212735.1365050-1-eajames@linux.ibm.com>
References: <20250219212735.1365050-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tUJfWjQo0MyWumd-WX-0Nn6_rJAEQZNB
X-Proofpoint-GUID: tUJfWjQo0MyWumd-WX-0Nn6_rJAEQZNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=930 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190158

Document a new AST2600 BMC board for IBM P11 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb..e80286ff92cc1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -88,6 +88,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,yosemite4-bmc
+              - ibm,balcones-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.43.5


