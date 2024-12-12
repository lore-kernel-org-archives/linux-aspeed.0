Return-Path: <linux-aspeed+bounces-207-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCFDE7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 21:50:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8R2x0kMNz30Sy;
	Fri, 13 Dec 2024 08:50:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734040201;
	cv=none; b=XOWM/FQda4qhn0qQlpfQ1aaEx0UbYqDww6wXfHDdg5hdYOrDk9T06qfcOs9QTlsoUmtKW+XzEnUNjDcE3GGaaBNDxb+et6INYY+ffe9UqdLq4yB5O/XwD2ne8NK6/TM2Y4XOHG+XEiHe+Uu6zfLhvPXXpl/yTelS06AVHJBK4k+tNPXjGr2NaxCjEbZ0BxkBsIL7osT1aV3JKp3BLxg4bke4HRfsovx0Wqmwf8wheGBG21rRQFQg6o4EllzsZnmi0hBhln4P89YWhzEF8Z1hlZVqMdLrQOx33B1t3pNLtDK5uSwodELPCG9f++v/MJwcIXGwOkQ0H9JrBpfFW4MlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734040201; c=relaxed/relaxed;
	bh=sQSRIpbMZMTvSt/ONP7qcZFmo/OmYcaw7A/YcvOiJxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evT6TJ2qJefjDc3sN8AAPfhinEfWTd83q+eBp8GTKtGt2vVGizq5Ngsa/VNmHV39XaB0TPjDCRbe3HKroN6Rx80gpT6euoiXLixJBjRBmzbk7Q0IzmUAKY6KEUUFQK550eBDs0fzvSNEK+iVdEJ/NLBwjf9WmbQp0u+v3PGBP+ozIalM9f958+D5PKaLzdZdw8m2wHOpdZWdt11vNv7g2SqyCjU9moBel8eEvNUFvABBOyHLvZUpPVhDTrricb8qLDKGJ15RRErcWvqXB3tnpWFYNZTU5nXizXsLzsPvKiPQavU9OsqCxabxMv8CTPq1YltU+DYy5ysuR08aYzzTgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eun+Ov/e; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eun+Ov/e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8R2v4lYfz2yjg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 08:49:59 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHHNP1029647;
	Thu, 12 Dec 2024 21:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sQSRIpbMZMTvSt/ONP7qcZFmo/OmYcaw7A/YcvOiJ
	xU=; b=Eun+Ov/ejazf5dJAtHZffyPyka2SPRWHNX95vIR0ulqUblko6XdBRitqV
	PoQt054qhSB+cDeNn58SBtCMtQULwGCc0TWWvkDhhn8MGBINlMav2GZnCgBdhyPe
	ecLis80cr0+hIiwQ+1XDeJHrfw2fcY6f52UpVToh4xUOK3FKmh3/7fGEkclxSfar
	PV693d9CAXMY7TlFEivhVV6g9yjaEiMFRssfhmvWXqQKt2h9PMzqpd38GGKMpOPe
	an1Y1vJYUIr1lMDFfNAaaOcj6vEnu9dCB/NyCsZbNixiecqSZEf4pFtCMl1EgsHX
	jIl0f3zTSfV4gHlP9kG/lupG+ZszA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjwnbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:49:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCLmpVu014905;
	Thu, 12 Dec 2024 21:49:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjwnbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:49:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJWAhG032760;
	Thu, 12 Dec 2024 21:49:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pstx59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:49:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCLnW8131392502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 21:49:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F5558056;
	Thu, 12 Dec 2024 21:49:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A148958054;
	Thu, 12 Dec 2024 21:49:30 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 21:49:30 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        eajames@linux.ibm.com, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
        Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org,
        peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
        naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
        patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 0/4] Add support for Intel CRPS PSU
Date: Thu, 12 Dec 2024 15:48:59 -0600
Message-ID: <20241212214927.3586509-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: icj0bAT7zzgFYlr1nDRjw_RxSGMuUP5q
X-Proofpoint-ORIG-GUID: lvlUArhSuLBsHdj0aE27zUlAmBm5SjQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=979
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120156

Hello,

Please review the changes for Intel CRPS power supply driver.
I need to add label in the pmbus core as new application like PSUSensor
requires it.

Ninad Palsule (4):
  hwmon: pmbus-core: Add label for fan and temp
  hwmon: (pmbus/crps) Add Intel CRPS185 power supply
  dt-bindings: hwmon: intel,crps185: Add to trivial
  ARM: dts: aspeed: system1: Use crps PSU driver

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 Documentation/hwmon/crps.rst                  |  95 ++++++
 MAINTAINERS                                   |   7 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     |   8 +-
 drivers/hwmon/pmbus/Kconfig                   |   9 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/crps.c                    | 299 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              |  14 +
 8 files changed, 431 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/hwmon/crps.rst
 create mode 100644 drivers/hwmon/pmbus/crps.c

-- 
2.43.0


