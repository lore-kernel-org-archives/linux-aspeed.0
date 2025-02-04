Return-Path: <linux-aspeed+bounces-635-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A283C02197
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:44:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnXMZ6Q8vz2ysv;
	Wed,  5 Feb 2025 05:44:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738694650;
	cv=none; b=lN8x1B/ak4hMxWt8IT7oHnjuFg/fUhavT0mFNaquMR0AzVjkRm2CQATQcPKOqHdxDHE09PN7j/0oK649pf3+i1ZWoc5SQ/2jV56u+yvDFiCyLO3t+Oh6GexGhg1mq0Oo2qm9q8OX+8nR0r8YblS6P5Ac/aJ9rY0rSEtTkjmcB/rzjttc42Jj4tTxp2R1Ypv7Q3CfvN8tv1k4hqaWMBqGqCiE6YCNX1nYF/zlvbkGnsEWRMnsM/ekTS84KujMctV5bjPrEYamBvuzIDfdNxZGA7dri+uWDkL0/juMMEcqPK38KwC9jUuNaDbsoHAersEC90d6wNeo7PDhsCgHppH0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738694650; c=relaxed/relaxed;
	bh=EGA6gUn9zRkuVLwQf80uhCdEddQ0d36aW1lKnlzmiRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5Nue7TwiDVHsC/DoZC6Bjc7IdoWn6mmMCfzwbm26i5UyKHVaMBVeOYTCVVCMA9b4EX1lLy16wGcjkM9V45cSLqcYQpW5ctAqSlwyaTQ/jRUrvNjv18wQVfEt9vwYuiOmvftDAklBFz8SdoCXVNjuVueK62Q1OaDdqrwbMp04V5EMcuuFVgqSR7Au/ACueJbPbtgKXbYEZ7YNFV0x2ekzDKOIRkwoxH/ERPmIe1HCjmJSy6eNACbzXCR7Wy88qZUju9I5KY3Lju8QjsztnwzTNid4HbrmwkN+Mro+w/n43vHG2IrLzquJJ3PEaYQsx34iMN0f7ABYrph53RUMYo9fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bIebhRt8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bIebhRt8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnXMZ0cHtz2yXd
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:44:09 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnWO028618;
	Tue, 4 Feb 2025 18:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EGA6gUn9zRkuVLwQf80uhCdEddQ0d36aW1lKnlzmi
	RQ=; b=bIebhRt8NW06bb1R2iEF9rHXjje7eQhp6FSqccrpeNHVicQ0bcn+x37z/
	PU5DlOTBxkqbfXZrWtpibxlSHT4kO+ZPgGTc7JQOMuh3RN90LmyI9puZ8Gq0tpWD
	Mh59Rf/77TXXKzbCBSDcCz0canUoQ1+qTm0gmkrqaxaclcbGD5bs5jTRHr2rDCw3
	vsAz3npuxg7eViILUs93sZ0yk20w9yFiojH2gXyET4ZGLlucziw12TrmvWjVMIuJ
	4m3yEouwRRhwAZzqnXaQIC8biAf6MBy1ZJYYj/WIQnNuqHW2imT8ZKT7Ghvv5Oyp
	UOgdmCks+e+6VI/bMcdXXGwrZWa9Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtrxfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514GDkbq006502;
	Tue, 4 Feb 2025 18:43:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekcuuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Ihfah25101028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 18:43:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE6158058;
	Tue,  4 Feb 2025 18:43:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26AF858059;
	Tue,  4 Feb 2025 18:43:40 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 18:43:40 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v8 0/9] DTS updates for system1 BMC
Date: Tue,  4 Feb 2025 12:43:26 -0600
Message-ID: <20250204184337.3896834-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: sSYgMD278uzYUMt_Vx3iymDjSFnl_9I0
X-Proofpoint-ORIG-GUID: sSYgMD278uzYUMt_Vx3iymDjSFnl_9I0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=616 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040140

Hello,

Please review the patch set version 8.

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

NINAD PALSULE (6):
  ARM: dts: aspeed: system1: Add IPMB device
  ARM: dts: aspeed: system1: Add GPIO line name
  ARM: dts: aspeed: system1: Reduce sgpio speed
  ARM: dts: aspeed: system1: Update LED gpio name
  ARM: dts: aspeed: system1: Remove VRs max8952
  ARM: dts: aspeed: system1: Mark GPIO line high/low

Ninad Palsule (3):
  dt-bindings: ipmi: Add binding for IPMB device
  dt-bindings: gpio: ast2400-gpio: Add hogs parsing
  ARM: dts: aspeed: system1: Disable gpio pull down

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    |   6 +
 .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  56 +++++++
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 139 +++++++++++-------
 3 files changed, 147 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

-- 
2.43.0


