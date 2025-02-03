Return-Path: <linux-aspeed+bounces-609-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1120DC02192
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 14:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ymq5w3cMLz2xsW;
	Tue,  4 Feb 2025 01:44:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738593892;
	cv=none; b=Aaft0P3NX7U/a1DVXm+yvont3eM43DqPKWGCNJurd3m24fBl3UPHUV6S8dXg9CCW+ulY8I2/k14J+W1WKtRCst+84HmH6C10xOcxpIEQn986P3yVuYfYhpLepSxVGECByZKt2XmUzw1FM90s6hds8N9s1/KXHiKEJVvnmLm7fl61NucYKJeMsk8UhKSlZDLT1+5S1ajWvNg8GWKaoMuHi2I3y5EdI7RQA1ZAHDncSCI2O2DnW1aP8MsouWv47iSfrncnHs90uFyQlGHy4byFjmQ7duIfz4LSo2rm69RJITEO4/JpK6i0oF7SLBljHFxaXOT5SjcdZCHWFGFU1FChKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738593892; c=relaxed/relaxed;
	bh=57e8SP5e9JbUAQMVxb6TWdu8KVW8snT83iM0TR2yseE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGB6Os5O3z/Wfn6Sh1pKx+EfL0/kdiyEINoZb9mIa/HqzVlIAmDvawYwGi1veU0xfShGDzFtIyYyrt8DwKFcSngltZ1XlJcfPdI0bN1vmTZLGouK6DL2E1/mFnd4h3pQzq3L3yNKGafbdQNNNUjMUBySl+bG6j6qqggDh5NjkbnVv4lMM2cPDieU/2ShNjjqpviBhbB4L2w6+iuTbO1uLeo+bMEXn+dBBwnCXaa8K5nEZaRJzt9ZBKVGJhfdLcNgFKAvjORE2bxOvPqUnGb3S6u1UkV57NLjQmBdiA4oaRxoNP9Vjrgoaq/1fl3CAmMrY3h7oGgmo8sIl3piTfFWsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QxMZLNx4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QxMZLNx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymq5v3dz1z2xk7
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 01:44:51 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135OTxn014061;
	Mon, 3 Feb 2025 14:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=57e8SP5e9JbUAQMVxb6TWdu8KVW8snT83iM0TR2ys
	eE=; b=QxMZLNx4X9dCVjGJr52R18nrzui38288SUQL4fnhN7RkvPq/BhDXuzlmH
	4uSlk9A2FylNuyGhy+p9LdAkTQQrLxVKfQgdykpqw4B/dRvWU0b8TXAm21eehYYH
	0baFWLOb4fukk71zFkSoIKAMp59XYgiQKTe2OAsnGLrmfhKHiSSdX7bXAGLHCung
	1X90u9aj5oIlA0cu1xhynh+GVFhKLcOWMWRK1kbvUjOpGndtCzRj7NqgIpoectZa
	XzeLq/SwjSI7H6Z5halGx0/z0ShN371gibR615JVdyc5k8Es4E/6pEgt00/Mk2oi
	WV5agTe0GkuZrJq2E3i0DwSfauQSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7aj78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513EhAGg008691;
	Mon, 3 Feb 2025 14:44:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7aj74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513BX37J007130;
	Mon, 3 Feb 2025 14:44:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxayewn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513EiQQf65143156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 14:44:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D3B58053;
	Mon,  3 Feb 2025 14:44:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1F358043;
	Mon,  3 Feb 2025 14:44:25 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 14:44:25 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v7 0/9] DTS updates for system1 BMC
Date: Mon,  3 Feb 2025 08:44:10 -0600
Message-ID: <20250203144422.269948-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: xCo4g4MsFiQNDmhv33-RZ2uMaIFB-2FW
X-Proofpoint-ORIG-GUID: ggXuQi27YS5gOpRnabq3GSadIWQaDmpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=593 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030106

Hello,

Please review the patch set version 7.

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
  bindings: ipmi: Add binding for IPMB device intf
  dt-bindings: gpio: ast2400-gpio: Add hogs parsing
  ARM: dts: aspeed: system1: Disable gpio pull down

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    |   6 +
 .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  56 +++++++
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 139 +++++++++++-------
 3 files changed, 147 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

-- 
2.43.0


