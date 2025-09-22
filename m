Return-Path: <linux-aspeed+bounces-2314-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD12CAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 17:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVrSY2Vt4z2yxN;
	Tue, 23 Sep 2025 03:58:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758563901;
	cv=none; b=IhNfYbcteTNqnwQblS90+ecGxIfoE2gx0jQpO/cWP6IbfKgao6HoQORDEvUC8ZU8Rvs1DWSSZYJxGukdQ3lQLvbayatyFLLMK10v7cSsP9Y3YfapAv9j0LzerEhrxVoIZlwRaksx0wIWlGj6YNxL6wnb3ASnzUBuDQEADyAfahSulLBnsu1t/Tr5PYxUBxDzs7eyWgGIUGcWXy3EO92eOlY3gnwWRaatfkiDIZnbShkuTWD4pVA69vJ5g/ylWA7g5HZ20kBI0V4ZXDNKFfZ/oHmo51QMPuz1cp41iY06Z6Ub3uotMFivby/c4tmI/2qoyGUqPgUQa92JCwSR3pfVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758563901; c=relaxed/relaxed;
	bh=zolTJVBjpAipV1fMb3a+ZCYRNoqZ+X283t5H38F594Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGaXaUu3Kf5baPRNYMRLtUB9lmaNP3KC++3MuBoXS6h7iF5vxNQvTcp2j3mC3PaU663fF4dUwuFsAMmKdAs0mLyAs97k4/xnjh+9a+xmhbiWw1YtObzzK1MU3v8zhxu8LhR6T9R8mfLktoCFGKpSqeTCLGC0v8bYzgSQ8c8yWQn3UlPxVtLoCNVUGeBgYyb1TVJf0MzeL5ydv2Ql/SMsmr7rQmdqi9XK5Vw9SmLE751kWHbxz7VHmt5+y2/0uHJqLfiqbOMe+/auFcEEPaFi2miZHi8bTxEQYW/I59Bdnmn5noWfqdvgVFDj0Z1/xwZCe0unBXA8LEJCl5kio6r11g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CtBOOLo3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CtBOOLo3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVrSX0Lzyz2xPw
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 03:58:19 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MC1iLR011029;
	Mon, 22 Sep 2025 17:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zolTJVBjpAipV1fMb3a+ZCYRNoqZ+X283t5H38F59
	4Q=; b=CtBOOLo3UESYwdh97IcBnHSaU9Yby6gzwZXdlhU6CuKE/Fx6c5xuqnlqS
	6BBZH4JYUH0fnrTJ+h75f+8lhqlR6rXcraMpuWeSk9XcIcs9G62Hx/hCSBJYuQjX
	laCq6AH2FIm5dVkBWuff4JdkaO+vNJhxicJMtVi7Mp1hnMYQxM0qpTBoq3uRmnyw
	PWA4VJxsF51UGb5PPX1EfgvRZh+blIf5mwNyw8GFfB9vLoAecCSsAfIZbjlWr3v/
	Os3FLqAI8B77z+KIiYq5xqq5/Zl6gRQQAyucfcwPFIsU6hOegUB4ogb7HuzMdNMm
	TTbSyLRAvCIRY41ksa5wqS414Hd0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5vhku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHEQbH013602;
	Mon, 22 Sep 2025 17:58:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tj767q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MHwAch8848812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 17:58:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B459358059;
	Mon, 22 Sep 2025 17:58:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4954F58058;
	Mon, 22 Sep 2025 17:58:10 +0000 (GMT)
Received: from slate16 (unknown [9.61.160.40])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 17:58:10 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 0/7] ARM: dts: aspeed: Add Balcones system
Date: Mon, 22 Sep 2025 12:57:57 -0500
Message-ID: <20250922175804.31679-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
X-Proofpoint-ORIG-GUID: mYf0pmLjX0JAqVNVQ_9fGukWoVmpU9Tq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX69MxYZaOHw33
 kGti/mSpuLXGSqY1+oZ6FskcpPnEE/1UK05NY0J18exdX+L4UUL+SAfw6WZBljUlZEIdDMvfE2B
 Al8JbUZikaWm750+ZuF7J4ElSTew4ISrBY3oMrbbPdOaNKKQp9gKK9Typ7/7P4ick1/6HdIlkpn
 mSEZMZbXKh4+55w4d93aSYYjO2a9BfhnWMcnhNLygBzNB5w5BwLrbknuqwg34MKo3I9jiOoBPQs
 dJTJyYQJAZLDr8fYpSD0o7j5zKPmph3gRwG+gufZVEGVBUAiybpOTOKChdvO2TgNFLSBAeXBS4y
 ayDsMvgORd3n+tdanwWetCaOJoXKPqLL/f1+stEk2+ScOr1To6hsa+cyigw9+qMYmq4afDUF/Kv
 IbqD5wSL
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d18e34 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=Hy7NEVtaT5kuqzZ1rwQA:9
X-Proofpoint-GUID: mYf0pmLjX0JAqVNVQ_9fGukWoVmpU9Tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

The Balcones system is similar to Bonnell but with a POWER11 processor.

Changes since v7:
 - Remove un-documented fan properties under max31785 nodes
 - Change fan-x to fan@x in max31790 documentation.

Changes since v5:
 - Add patch to add address and size cells to max31790 document
 - Don't remove address and size cells in max31785 fixes change

Changes since v4:
 - Add patch to fix max31785 warnings
 - Add patch to fix missing Bonnell documentation

Changes since v3:
 - Add max31785 to the max31790 document instead of to trivial-devices
 - Fix minor formatting in dps310 document

Changes since v2:
 - Fix a couple of incorrect i2c addresses
 - Document dps310 and max31785 properly
 - Drop the UCD binding documentation update, it's been fixed

Changes since v1:
 - Add all the ucd9000 driver supported compatible strings
 - Fix node ordering in Balcones device tree
 - Improve commit message to explain addition of ibm-power11-dual.dtsi

Eddie James (7):
  dt-bindings: arm: aspeed: add IBM Balcones board
  dt-bindings: arm: aspeed: add IBM Bonnell board
  dt-bindings: iio: Add Infineon DPS310 sensor documentation
  dt-bindings: hwmon: Move max31785 compatibles to max31790 document
  dt-bindings: hwmon: max31790: Use addressed fan nodes
  ARM: dts: aspeed: Add Balcones system
  ARM: dts: aspeed: Fix max31785 fan properties

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 .../devicetree/bindings/hwmon/max31785.txt    |  22 -
 .../bindings/hwmon/maxim,max31790.yaml        |  22 +-
 .../iio/pressure/infineon,dps310.yaml         |  44 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
 .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |   4 -
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |   8 -
 .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  12 -
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  36 -
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 14 files changed, 1456 insertions(+), 855 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

-- 
2.51.0


