Return-Path: <linux-aspeed+bounces-354-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABDEE7719A
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 16:37:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YStql1zmKz30W0;
	Thu,  9 Jan 2025 03:37:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736354243;
	cv=none; b=b8JQKuzPh7j50fcOiTxVTTRDhsn5JNZhrzqn/1TAIIB0JanxGuXxFuO1iO1HrKAJ0rbwA2HpH7rUcQDJfJeL9jp/uoFBmJQcxUz/DLiib+VyK9FJT1i19A3mm1mmtQJC2E4K2rTlv6D/Kp2r5p6REdNtyzaBWaZs5q6cz81zspznHDogZ5XRFB/ICd6aI6SDUrgm54bxl16RHrmb2QETYf9wjBMs8bZD5Dfljq/Wni7Pgwc3Iduu6fx5Ajrqt7M3jWlCurTn/hOW75j0aG3+ek+RhPDHwbmg8+E+51oGqdZ2VwND6YaAvEtn8GB4QGiMCLOjg1VTqhwK1U4aavl88w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736354243; c=relaxed/relaxed;
	bh=1VA4FnLg6AvKPrRYtRK9oUlIVGRANDBmf4NbQIGwPjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lezhdxtpm9+oycboMLFGy4XeqFtnTS/gKtDzs2sBu67O+3sbQ7R0MpJjMBMbrWE0he1CSqf+oWsHsdegV3rkDpfse5S9RgVGp8PQE6fQNmEfIqBSRbnGAwjkrBUaOgKorL0uJeUuks09XzURSnRwY5brvzLarPbCcjwiOCNZy/NU1shGMBCARU/4qyEnaf8rQlvjZV+ji2dSH1naOf1GI5yQn5wIDnRuanalm7y28s/X2EGayi81J4qYWNPMYvzaUs1/7Z7jJlbsU4p4eLKKNBjtSXVrXPVJDeHCel6WiMsA5Pym+clIBdQuk+XSCrfQzzj+f2IyInFyBMxfL7rtBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OStWXGSm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OStWXGSm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YStqk15BZz30VL
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 03:37:21 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508D6H3H026793;
	Wed, 8 Jan 2025 16:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1VA4FnLg6AvKPrRYtRK9oUlIVGRANDBmf4NbQIGwP
	jI=; b=OStWXGSm9nCog8IqzqUB5mzviot330BxZIFq9Xyb9tduBEjY7A7V2N/7u
	V7vdp81Aeqtavy30flT69x0o2sMNUin7Kt5I+IcbiljzH0p3wxCI8lo9TwLhAXzw
	wR24xCNXK6j1/p6bN+zz6gN3Lrtt0d7P6aCmN3P4WmGb58DGZgNhTFztXjgPojli
	cssxgSOc00fV2mtesYIDUqTCptIaQhuhCI1HBRLPW6ghdXsX6dxNXwASiqzZIj2t
	jpjjMcKM1cYP1tEgOwGF/77LvzquYeMue/vpmBb5OHTJxI5b8+CMNZh9P+4hFd6J
	xnzBHZR8hQMgjdcszy+XkC1snP/Fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441e3b3ymf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508GVHaV012904;
	Wed, 8 Jan 2025 16:36:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441e3b3ymc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DUSK7013663;
	Wed, 8 Jan 2025 16:36:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap0nq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508Gahii27198136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:36:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 538B158059;
	Wed,  8 Jan 2025 16:36:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25D6F58058;
	Wed,  8 Jan 2025 16:36:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 16:36:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 00/10] DTS updates for system1 BMC
Date: Wed,  8 Jan 2025 10:36:28 -0600
Message-ID: <20250108163640.1374680-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 56gAYlJwF9rTlfsKRDyoE1WveLeBGmap
X-Proofpoint-GUID: Ua654eol_PRhKB7UIS7w0T6FCjVbxqA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=528 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080137

Hello,

Please review the patch set.

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

 .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
 .../bindings/net/faraday,ftgmac100.yaml       |   3 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
 3 files changed, 165 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

-- 
2.43.0


