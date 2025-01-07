Return-Path: <linux-aspeed+bounces-328-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A832BE77199
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 16:24:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSGbJ33Nsz30gd;
	Wed,  8 Jan 2025 03:24:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736267068;
	cv=none; b=CCDmYgtBOIOj8OOlCHF80Q2HpKpa9VkuT4M71AAJ80apzxNOTaAzOE0XJiCuL2naVjZecuClxZol5LUf8yz2AiEbJgVcLdIm3jXzT0VVjdw4AZgtTnAZ5tT/N45zBA5bGZkiLzuhZda3MJh6mRLIbzhXon+MFGKzvFGTYkwk26qBrU4nYyehM4SIARAd+fRT+kNTgIbjHhmhuRiQOay12Y3bYDpeaOPFxXREYkAR67foAFnawOAjAPVaY26f2TmjnoAaGAI8W11F99HwW0EJY6WFTuAKdRezZmkYsOEhf6fjrePP+vofuq2yUykray9Qq66YdEo0KtwyHH4ZNH+Cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736267068; c=relaxed/relaxed;
	bh=GYAgmjZBiA6JTCjMJCmqD3MxCfAICQ4dJqivijHe7MY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GS/SmoBcJYx+vP6uFujKFyp4F26P8VZo+oxtZqCCfMb31C0DCXsh58OFjqpAcNtqB6DYyh+viBMwWuZOHYU3JpQEF7I293VhCac9XUPtPGIYxzOtjiQM7457qCkddvVWVy/Px8bSdt+lp2rJJ45yZ4+ZcQVhXFTsj+VfeaigFAjcwgU/oXIH+m1akl459pLzqB9d297C2WtYSXQ1UbR031Efe7IyVvRYp5n9EhwiVGoJiRBhq9qVd6DSaaqj0UdokLFlxRaMhIsSrMi1RX3TT5yrUcO7PcZNoIeZWtyqmVPD2tExmkB2h3NIgydlDyS13Hy1BEqsxYIKDIOKYb2jfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTWYQqdR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTWYQqdR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSGbH1lqvz30gv
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 03:24:26 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EY2Ic012681;
	Tue, 7 Jan 2025 16:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GYAgmjZBiA6JTCjMJCmqD3MxCfAICQ4dJqivijHe7
	MY=; b=TTWYQqdRGeqluXIqgecJrJE1sRlU8IX4x6J1EHpptKy/GFNIH7TV7Smf+
	s44jRd76covn2dlsO1xydkpMe8FF+bM8Bj8C2q2Kel+jGoNsU673DtkUcKO7v5Hx
	GxgC+ZdFGLcZ+JffHpOOapAyH3O2P4tbmw8w5pKX4JGF/UI9wPvXB4fmIbJeReiD
	0VlKFgm7/c3IKBq6Rze1OKhz0XuWtw/3gInEadmVDQ61YfbfGqIY5EOx48xovxEH
	2cgErcOT9bFOnDYoe9L/p/pvZW0D93cJ3izUBlbD6RpuhbQNVYJ1oGOsOSXL6Wum
	K4J1or91AKtDkZyZA20cEMGCxukuA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrcb8n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507GNsIb018908;
	Tue, 7 Jan 2025 16:23:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrcb8n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507FtRF1008875;
	Tue, 7 Jan 2025 16:23:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyuf2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507GNq7P21824080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 16:23:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A79658058;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE14258059;
	Tue,  7 Jan 2025 16:23:51 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 16:23:51 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ninad@linux.ibm.com,
        ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] DTS updates for system1 BMC
Date: Tue,  7 Jan 2025 10:23:37 -0600
Message-ID: <20250107162350.1281165-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: ZK7yhZ5I33Bj_qEUveZB1hnGoTeimQ2R
X-Proofpoint-ORIG-GUID: ApJbNe-3Yghr4WJcLLm9p0paPourxDzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=448 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070133

Hello,

Please review the patch set.

V2:
---
  Fixed CHECK_DTBS errors by
    - Using generic node names
    - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
    - Adding binding documentation for IPMB device interface

NINAD PALSULE (7):
  ARM: dts: aspeed: system1: Add IPMB device
  ARM: dts: aspeed: system1: Add GPIO line name
  ARM: dts: aspeed: system1: Add RGMII support
  ARM: dts: aspeed: system1: Reduce sgpio speed
  ARM: dts: aspeed: system1: Update LED gpio name
  ARM: dts: aspeed: system1: Remove VRs max8952
  ARM: dts: aspeed: system1: Mark GPIO line high/low

Ninad Palsule (3):
  dt-bindings: net: faraday,ftgmac100: Add phys mode
  bindings: ipmi: Add binding for IPMB device intf
  ARM: dts: aspeed: system1: Disable gpio pull down

 .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  42 +++++
 .../bindings/net/faraday,ftgmac100.yaml       |   3 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
 3 files changed, 163 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

-- 
2.43.0


