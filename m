Return-Path: <linux-aspeed+bounces-646-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BC9C02194
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 19:41:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnYdq6GhHz2ysv;
	Wed,  5 Feb 2025 06:41:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738698095;
	cv=none; b=Ol4dNXHLwgq8T82Sl2MzKGW1jwtZkeZYHP37fgJokRaZ3E+xsaTpHYc/3k/h64ai0agFvH2sFLktgiBETYtxlqbnyKkiEIVD2SUT8wCO2OFiEqnZ3//7hD2K3pJKgKhhEe017edO69kiA/XaMhnCqsUx5F0AHIK0yIbo2ZoNDPkONYEeQQtnK56i4z4FbQGu3fe02eAx64rqrJ7oKohCbyBusRPQ2XWDIdJ5/wYaJMdEIcBapIJJVCMH7lhT+nrhFIofjzUjsQa9MXhPADWCVpGHaZBDf1Qo2R219wVXenT9HfufGsV4lIe/T3686mo6NAE6AinKgUnC39aGI1/LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738698095; c=relaxed/relaxed;
	bh=nvqbVT4drsM9WVhiv0bKb5eYbFkLe0Zn30rWSLoCYBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHpKl4HYr/vRHcHwc+NRx3VJG/5+KibdaB+ctG3Loer8HCH1S/RqPQzxs75H1ISqDFS/qLC0OIkMeDSWI3bcT91hiV3V7M7ybPM94UVa0KXjYTNtGvr3JZSxfrDEohb4LiiUhd3/IuZJMjuRAP/lnULUnbacq/Wb5ME4J/aJaTW6j3v4MrDyRKnkxJTmtpry+NMFElxLkKutaUNu6wsTjIN5B+EAzFqydKDDONuHG3EOPrcCjowfENCZplB/j2PhL/tyjtVKe5gNsHOryssol2MG28UGT+CD9MqJto7Ct6wcU41VeL2W0IR9Yy9gNLeVUJO8k+AEi+aUKC7A8g90JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s+ofY21F; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s+ofY21F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnYdq1Nfxz2ypD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 06:41:35 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnp3029228;
	Tue, 4 Feb 2025 19:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nvqbVT4drsM9WVhiv0bKb5eYbFkLe0Zn30rWSLoCY
	BQ=; b=s+ofY21FVrh+loGav4Xlib/QQJY4AJPd6+DmgQhYLISQYrF6CBWKatIgB
	2QI777CUaNW70GG96x+OMTcc5mfBRhJptQOlVGhxI/P77xwNb/vPWZ59MHaLr8Ak
	B83NdyicRNDcknn5+pmrGXoMJweGhYAUzxsBPqHoAmCBuBlz+dPACjaoBX0FyV5S
	CiRUh7iEeVOrJ9n6uHBmi6m5cXpF0+7ExGWEf7BTYHvB6xAOnpXmOokbC9hIX+XW
	e0z0Pt6vvVoxUtx0iQ2gGEZ2k6Hd/uuCwIG+hRWWzAn8ox/Nv1xG6sOwXqE0OEcm
	C8p9j2PyDAD8bdRzA/W1F4LQdFslA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k8y9n2q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:41:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514HHdiF005310;
	Tue, 4 Feb 2025 19:41:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jvwyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:41:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514JfHp133096406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 19:41:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C5258043;
	Tue,  4 Feb 2025 19:41:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18EE55805D;
	Tue,  4 Feb 2025 19:41:17 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 19:41:17 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v9 0/9] DTS updates for system1 BMC
Date: Tue,  4 Feb 2025 13:41:03 -0600
Message-ID: <20250204194115.3899174-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-GUID: pFFpmevC1gL6Z0sj3MqonkpW3qUW5ai5
X-Proofpoint-ORIG-GUID: pFFpmevC1gL6Z0sj3MqonkpW3qUW5ai5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=657 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040145

Hello,

Please review the patch set version 9.

V9:
---
  - Fixed Author name.

V8:
---
  - Updated subject line from bindings to dt-bindings
  - Updated comment with reviewed by.

V7:
---
  - Updated pattern in the ast2400-gpio.yaml
  - Dropped "dt-bindings: net: faraday,ftgmac100" patch sending it
    separately.

V6:
---
  - Fixed dt_binding_check errors for ipmb-dev.yaml
  - Changed the hog parsing pattern in ast2400-gpio

V5:
---
  - Improved IPBM device documentation.
  - Added the hog parsing in ast2400-gpio

V4:
---
  - Removed "Add RGMII support" patch as it needs some work from the
    driver side.
  - Improved IPBM device documentation.
  - There is a new warning in CHECK_DTBS which are false positive so
    ignored them.
    arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'

V3:
---
  - Fixed dt_binding_check warnings in ipmb-dev.yaml
  - Updated title and description in ipmb-dev.yaml file.
  - Updated i2c-protocol description in ipmb-dev.yaml file.

V2:
---
  Fixed CHECK_DTBS errors by
    - Using generic node names
    - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
    - Adding binding documentation for IPMB device interface

Ninad Palsule (9):
  dt-bindings: ipmi: Add binding for IPMB device
  dt-bindings: gpio: ast2400-gpio: Add hogs parsing
  ARM: dts: aspeed: system1: Add IPMB device
  ARM: dts: aspeed: system1: Add GPIO line name
  ARM: dts: aspeed: system1: Reduce sgpio speed
  ARM: dts: aspeed: system1: Update LED gpio name
  ARM: dts: aspeed: system1: Remove VRs max8952
  ARM: dts: aspeed: system1: Mark GPIO line high/low
  ARM: dts: aspeed: system1: Disable gpio pull down

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    |   6 +
 .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  56 +++++++
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 139 +++++++++++-------
 3 files changed, 147 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

-- 
2.43.0


