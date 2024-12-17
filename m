Return-Path: <linux-aspeed+bounces-271-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC18E77189
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Dec 2024 17:36:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCP9m07Gsz30Mn;
	Wed, 18 Dec 2024 04:36:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734456971;
	cv=none; b=mpdZ7YpLkduhT4+vDkB7BCB+JXtUzw9SAWasQ8Q3kdx/XuQyMzv9DmiKFYpLDLBxtZMnKxT1IpHyHKYGVFVJ/9f8grMhIqs8ju952HZmmd8Sux/VWBa+mkWTgyEFD8HHflYboaUoXTMZ0SeMi+Za/Rsaw9TuEzyG3P+kRBY1ZQsPnOM4qTPelDE7WuhiomtecdRS3LFW7vocYNe3nKePSQ5Wfk8V6OHoWWBtVyEkuGxcQ+hQjS+6zbDFSD/Af6X0viYXULLMArHrznwfRre0XrbVLn6uZTqzv4m++Sy/0E2sTQSLfXPjxdmXVS5itgFZDWz1sROCvy5xxDoohI+0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734456971; c=relaxed/relaxed;
	bh=3Cze64ZkJ4Cz2gsZweHybIIHWwAMYbRAejZdS1uXHZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4IfKljudXpW/AvK30LCiLxELpOuUwwkTnc+7rfH9L9/IbWIKUq9j/d4GJ/wkEoOae7MKCaaX/S5Cz6WWsy+v+1iDVlTb6A4Wtc+ZxFQhzJopx7YwAuGERIz0FqrEwBXm6xco7ijTqJzFfJXi/1k8670gADLIsQ8EcsVgfF1lLwRKtzj7pAHSTDem3q6X0b8hiHyKP28nc1d4Bj5v+lff+ZJQielBWUMqdpf/Qk57Vwf9+xBf5mAqyGgRm1nU99y3U0fPSFOMEet9RtfX2gJJ4hfxijG/C/ymVObGT5yrBJN9qGgBb65awV4bCJhBJzPN4F64X/ytzQu2Jjnz8HPqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RyhdRXmt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RyhdRXmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCP9k3VdTz30NF
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 04:36:10 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHD0UoA028122;
	Tue, 17 Dec 2024 17:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3Cze64ZkJ4Cz2gsZweHybIIHWwAMYbRAejZdS1uXH
	ZQ=; b=RyhdRXmtfU1PxDNu+dAtHsA4dikP/urhvZ1aDjrJ6M7CFpYB/RP/37Qqi
	Uf9kf46bcPZ1EjYDGPVq8nx6BHqF51PF5RZl4hiQUKp4GO32W9zWn2fWppezczt1
	A0rexEJSNsd7dSOZlrxIVfmrfXKKdmhSIPmus9MYFupa9UvFs4N7SFwqMH0ktLJf
	jagbMLWsdZh6MTQa3/2t/3IAopKKCnRnkbyt4ESeQpbvF0Wd9cZVf4ljHF2CC2bE
	jO27X7mj9hKO1WIIDKV8n+n4ZwkZIs5Hm4PB3Ebz8hPHCNWGCLk7sAg4w624DX/R
	Uv3cho6gYF1TqkwaqjA/2vV28QQmA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k9t6heeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:35:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BHHQ0jN028818;
	Tue, 17 Dec 2024 17:35:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k9t6heeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:35:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHEs3sY029321;
	Tue, 17 Dec 2024 17:35:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsm34m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:35:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHHZfSZ25887300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 17:35:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1747A5805D;
	Tue, 17 Dec 2024 17:35:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09A45805C;
	Tue, 17 Dec 2024 17:35:39 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 17:35:39 +0000 (GMT)
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
Subject: [PATCH v4 0/4] Add support for Intel CRPS PSU
Date: Tue, 17 Dec 2024 11:35:31 -0600
Message-ID: <20241217173537.192331-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: QWx7H6vTap48emznpRAQAtERyGJSso6k
X-Proofpoint-ORIG-GUID: AEW_zZyOLNc4vOhz9gVc1LmegMtQ296D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412170134

Hello,

Please review the version 3 of patchset.

V4:
---
  - Improved commit message.

V3:
---
  - Improved documentation as per suggestion.
  - Fixed issues in the probe function.
  - Add ACKed string in the commit message
V2:
---
  - Fixed documentation issues.
  - Added pmbus revision debugfs file in the core
  - Remove debugfs and read word from crps185
  - Improved commit messages

Ninad Palsule (4):
  hwmon: (pmbus/core) Add PMBUS_REVISION in debugfs
  hwmon: (pmbus/crps) Add Intel CRPS185 power supply
  dt-bindings: hwmon: intel,crps185: Add to trivial
  ARM: dts: aspeed: system1: Use crps PSU driver

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 Documentation/hwmon/crps.rst                  | 97 +++++++++++++++++++
 Documentation/hwmon/index.rst                 |  1 +
 MAINTAINERS                                   |  7 ++
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     |  8 +-
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/crps.c                    | 74 ++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 13 ++-
 9 files changed, 206 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/hwmon/crps.rst
 create mode 100644 drivers/hwmon/pmbus/crps.c

-- 
2.43.0


