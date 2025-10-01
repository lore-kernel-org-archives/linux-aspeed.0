Return-Path: <linux-aspeed+bounces-2368-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EDDCCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 14:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccHlR6m1Qz3cfB;
	Thu,  2 Oct 2025 00:45:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759329907;
	cv=none; b=IDi1UUdyt1dUcvEQKSyQhG3LCIgI6HxPZnlQHON9E4y9Hq536CDlchooehVzGzbCTk+y0xOg/jFKPsEQp/Js+issT8vPiibcB7VfNzztjrDUbr06rOvu9CJ5OwJUtYB85dF90AXPTyFhJ1zVmw20Lq16WzmYau1pPnsC+XvnySa0dgvnSQ9BYdCmXJRZjSir7LdFMOFs7HoCabEsyPlCU3KPq1l46DQlhUkbFsZMsZVuK1aUvXkUl2FmaYAxudpkGDJeNLiOVdkGModFRKzBK3BHpL7ac5CqCMSyg4GKwuaaBJMNTLv+uGLnqYyvFyo8ka8dRtOWaGokcc+16lLTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759329907; c=relaxed/relaxed;
	bh=Hokf1lue+vVbLiF9VZl0cEYqrAg1Uo/ImMJ3thEnMec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5y+VAbtWKKqiA5SGe5bwPkCq7rccDFhJcFo2hrFKXsKrbOS1TsZUiZlu+zOGjne4Yln8bFciextil10m1Ln2ifEOLOioUp88wQJ3ZYuyMAsVviwb//xEnK7XgRn1Ltq3uzP10lzA6fOZtLJFciQ4RhLgzH7+h/KCiCtQEvdw9IMIK3ATUsLcX5N8qhn3tmWylHW66rRKqwGP7l7Ig75XfpX9sV4nphQp9e2tcEtzX/LUSa0YT19T6jGolz20KUCr1xOrwQLhl21zR5JQhjAANWa6K3xwQ4IAQcs7muznsUq6NzQvuR2YipqyIO+A6T4Noj5jmFEVjMSujOzPqZ3YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Cw4MT6fl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Cw4MT6fl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccHlR2l87z3cdn
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 00:45:07 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916UoN1005829;
	Wed, 1 Oct 2025 14:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hokf1lue+vVbLiF9V
	Zl0cEYqrAg1Uo/ImMJ3thEnMec=; b=Cw4MT6flk09WEVURBK9Ws+5stwRi4x11K
	6XcixOehWr+4xOkxSUw1kD+6JYsJM7rrrmjU5EozTh4AQaRnex0tT5HtDZKNulAY
	xtT+mhvZKUTt/Ws7u9Z0saOZ71akhZHGGD51dbiFDZJlioqMPt+SIjIewHexMQTL
	E/XpPTVZddEQliQ6a13j6joOjZ5/5+GTlCaWd4QUbd/TbFqdDSjjmxTg/dm1KQqh
	lZSMHzsO1L2Y09tOLXzrCV1b4rnSaS+feLEuTJrdHwbLH4OS3SGGmnO6zsvVDEpP
	6YFT0G8KBVlkLC9xWtyxNk1R5ygL9NxlDphVVYurVtThLM9AHBKcg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7g5h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591Dc8sc024157;
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy18y7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591EimsU57868714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BC258043;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7A2758059;
	Wed,  1 Oct 2025 14:44:47 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:47 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 1/7] dt-bindings: arm: aspeed: add IBM Balcones board
Date: Wed,  1 Oct 2025 09:44:35 -0500
Message-ID: <20251001144441.310950-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -tY1LzVVnLJPn3clXXUS7s3HWKia3Yh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX4t4n6x9Z5pYn
 lVmOqwz58SpODlIV6JQJye/TkmYkZAhteQIKFBy+OGzBC8pgn9fZcR8GbHLBVwaJVgGzn2+2WEv
 r5KR8kiAxSFth4eWG/LwIjFSNRz17eDQDU0AvqHIMwDQ5DBrgzvv2u4xeE3QKAc3bPXYjUybC6R
 c6KR3JjzxVP3WdxKCz/jAaCTihlAiAd0NyHuRYmTHte/kCtkg85tDUfs0kW99dootH7wE4B7btv
 rHEUtedd9Je/ddTNzwmlUW1tfu8jTVB2NYXokTuQJtGYtBNf6IoAPekEgTvdx3uMXvXl03eZklt
 qqcrzEMsu8/9JMGYPtZ98Y2wkFt9X22dN+JGeX7P3Nnijv9FLZvVwMmaQx3crsmRqggMhgxcrVq
 qUQHDRIamqWX8GxgnmjpMZ/I+rQQ+w==
X-Proofpoint-GUID: -tY1LzVVnLJPn3clXXUS7s3HWKia3Yh5
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68dd3e62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=AJooQMD86rzp5GWHMWgA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

Document a new AST2600 BMC board for IBM P11 server.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a8..b2fcfcc4a3b9a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -93,6 +93,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - ibm,balcones-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.51.0


