Return-Path: <linux-aspeed+bounces-795-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAB8C021B3
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Feb 2025 21:00:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzQd23vf5z2y92;
	Fri, 21 Feb 2025 08:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740085206;
	cv=none; b=djgb9v9kpsyWHJ5kLp+J2L1pD6zdOIkrdSpI9hOP2V3MRUQkukF75OLbNyfJaDm2VBvLEf/Si5NKBvzITz1pR8vsch9LYs3DNjNhbJxLyAs1R3C4mA2b7Q/GJY267CBpFq2j0EIbFAiON1d8X0j7D6sJSC/DDtId3skHDKFqobkJH440hX8mfPHKxEPtxHUAZL59YwuaOQkAH0dzMYRqi7bU1z/PyQs7nNZbCxDvWo2W33aVncFdcTDL080vqgUxQBouGQcxnLLh5HWoEjUOMJJnku9DbvJPlmFhBhcWQKtWnYt9ZlSInYli60GYm8dvifZkFBE1qSPeLuu+vf8zKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740085206; c=relaxed/relaxed;
	bh=Ay90aIoC12ub+sc0fHvsFF5x1FZK0nWJsCdk9go52qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTc4RFGMSRDlJBz3D62E4a2e1snW8psiVwLlN82KNOukEPMOaquoKl3k/yu0m135+JEAlTdoQ5rNmpN9YsC9msLtVTkd3OTQmlvoPTo9Fe7+882otiz9CjtIYcydlFcy50Ik6j25vLLhEBhC83NYi9R3IuoVCmXrYzY+svM+BUX1FvIqydkJ9UgailnqoTPov1V0wVv3EFLt0jszrGOipu/e/0Hlh9vqvOpXYNMvV/KBqzW+UaDLcNVHvBlsZs6cA5DvQw613vhJnWqagnwv5AmL4iMZ9ncl7beF3qzMGYdhgm5/HtG7Ir9XitW6vFUs9q93R3kN3r4gvz2J89wATw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N2eGWgaU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N2eGWgaU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzQd10GCZz2yGN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 08:00:03 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1hSW010230;
	Thu, 20 Feb 2025 20:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ay90aIoC12ub+sc0fHvsFF5x1FZK0nWJsCdk9go52
	qA=; b=N2eGWgaUoGXSDi66BDr5tA0WdtrHAtk/swtHmFULEQo9iRBYY8OdmPSHV
	6d5R5Q8WIZdTw0fdnVn1g9FUleTXrzdUvNoSGDQWBD/B9yNXSTJayCvfdEmHddZE
	lbHCFkhazqUv3yiYei+ScgS38mJymzG5REIOrwyJOzjweMI8nPgXRBTwZGeIBsKn
	ICCBJcs4kPv6MPNJMNjxK4GyG4LhoxVRVKVSLZkZubkK2h4uD3Bh/8pr2X9oLGB8
	wejvGTloIOHgfzYaTkZ2uqkPkd8Rszo52iKkA77+DAwTqIR5+CM+JkpE/sRHMhs5
	RaXwqA5XKPSBVnB2pOx54vqr8cbgA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wu80dc63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:59:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI81Cg002323;
	Thu, 20 Feb 2025 20:59:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xc6p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:59:50 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KKxnDh9568946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 20:59:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 979295803F;
	Thu, 20 Feb 2025 20:59:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2785358054;
	Thu, 20 Feb 2025 20:59:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.129.233])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 20:59:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v2 0/3] ARM: dts: aspeed: Add Balcones system
Date: Thu, 20 Feb 2025 14:59:45 -0600
Message-ID: <20250220205948.1777200-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-GUID: 9nsGT2CUchekFR5PniEZCCRtzcHlEDhH
X-Proofpoint-ORIG-GUID: 9nsGT2CUchekFR5PniEZCCRtzcHlEDhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=787 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200140

The Balcones system is similar to Bonnell but with a POWER11 processor.

Changes since v1:
 - Add all the ucd9000 driver supported compatible strings
 - Fix node ordering in Balcones device tree
 - Improve commit message to explain addition of ibm-power11-dual.dtsi

Eddie James (3):
  dt-bindings: arm: aspeed: add IBM Balcones board
  dt-bindings: hwmon: ucd90320: Add additional compatible strings
  ARM: dts: aspeed: Add Balcones system

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../bindings/hwmon/pmbus/ti,ucd90320.yaml     |   6 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 594 +++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 6 files changed, 1383 insertions(+), 767 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

-- 
2.43.5


