Return-Path: <linux-aspeed+bounces-1974-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0113BCA0EE4
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 19:47:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3XhN43MDz3cjf;
	Sat, 16 Aug 2025 05:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287268;
	cv=none; b=k/E7EYHLJcAObglQEga/KYFBobUlpJcop/gIJIQhguqIbyovi5YXk8+SmEyT6MLGCoD5oqowDknMvy+tc6S5wUSUFnXtU9dPUzZ3FT/VKX4tKMngRHXdKU2sHeH5Jqytz6qxB+LC3FVBqhQEyWNgyBM3BKB5dRqhdjvWmrEQUFTzLxK6WbeqpQf5Ue0UlfCfKKMm66ZmnszRlGl6vGKZTBZ7D6vIuuoeCO3kbepq3D5gRP5K6+zI6z24HBv9z4d3OLJ+PzsH8hQbkpcMoIrASAcWbenbriLSN3AUIKyLcnlNVnq9CgH2X6P4NDpRqTsg/eLZ8MmtGfTYm+UWqxolNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287268; c=relaxed/relaxed;
	bh=wB3GZ7BA20S/EiVo68LEbZykCg00/1rIm9eGU1e+FcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INYL870K1Kn5+asnw3ReEHYMY3kYR8HdLu2z8ISEMFvTEu/0OJ5kRxPcUNLoTZ2uLCDEeIjLZdrnqAMmkRuuuPtLmXyinq6CfIY4R5ezlBFo6lbumrDFsxpMK21pkj+fcLYPhe/wpelmIW3a3KFn6ZuvroS1FYRC5O00hQnscbmX3X0/3MKRBxUizpEcuT3Nm/qncccFudF3SSqdKQC699e7KaZ9MTIT7AC0NiHFf6+h/RkFGkcXvf5iSqdyCdyGYgrA/ILV5MrzH1WVRpy1i1jH4AQNtVIQ6YqwRo+3ze22QIGlcCBgL0ZmMBBR+7AVCtNvOxmqJZH2V9eBuFWbXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GYF51Rxj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GYF51Rxj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3XhM4zzmz3cj9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:47 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FIonrt022409;
	Fri, 15 Aug 2025 19:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wB3GZ7BA20S/EiVo6
	8LEbZykCg00/1rIm9eGU1e+FcI=; b=GYF51RxjB5R8YD4oOYLapvakDJ5aXIEuz
	FnNJzDh4zaatFRvfUGfdITOPwz8Ry4Uj4G0jnilImmDhnOY8uMtmqqATwC5KM0Va
	QeIsLZ9pOJvPjgoaS5vW7gUkMgRAi08YBd31xtdTfw9a7Kuf/fYKJm20eF6OlQ4A
	bm1/bsBb+4Fo2nlwkcdmFcFbKisnBy0/MdNOaqHCFonXVSAsfs0aWPoBu7MXbtZl
	5vdTNJ5c3xP3CL1V8OpUHT4WTQHwmqBEdbWGho1NcXXKAzAZfKx4SG/MGeLDyY/1
	5Qi/YJAT/PqTJmJE4sCVx37YLSOit34sEARlJw8DrkOQ3qVlSFgPg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx15130m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FJJhD4010622;
	Fri, 15 Aug 2025 19:47:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnv2n9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FJlcGO15991542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:47:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 357BB58058;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05C785805D;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
Received: from slate16 (unknown [9.61.135.91])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 19:47:37 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v4 1/4] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Fri, 15 Aug 2025 14:47:27 -0500
Message-ID: <20250815194730.41695-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194730.41695-1-eajames@linux.ibm.com>
References: <20250815194730.41695-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mX8f6xuVL34o807ShTKlXJoEcAIUIceG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX6+TWtix2Gpbw
 IPCDjXtSOY1QojoxCwlhYsoqgtKgPirEM18Iiw5HHY9vL3yFklomwDfCi9Kf/eHGVu9AdaIqo90
 lKiPLlo422AMxNNBIuaA7dsqcmj4QcBuZJ8/fPI1JtqIGV5kNLclKkXPGxxFGET0MTSC6LIOwZ9
 HtIZscr62AGCiJhZJkxP7cPTCpA3udZ9LZkLigkSH2+wUwvS2Oq3b5Z7mG+fe+0nzEMRewjKgWT
 ULi50p0ifEeuJ/DJFFMUJ9zjUGb71c2+ReESrvp8VIKeeTV+Pd0keifdlYXOoQGdwYSzzWgkd+K
 kKd7aa1amHgMsi//F+yscMUJwLXa0fLZ3rIEa6sa6DVGxK0YHdsKsL5neHRAkCqLwdz6Qbo0bem
 qynYPDkI
X-Proofpoint-GUID: mX8f6xuVL34o807ShTKlXJoEcAIUIceG
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689f8edc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=3wLJMGCjkU_6NCSB5IAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Document a new AST2600 BMC board for IBM P11 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
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


