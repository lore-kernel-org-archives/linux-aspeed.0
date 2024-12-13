Return-Path: <linux-aspeed+bounces-227-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72002E77180
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 14:51:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8shz0L6Zz3bTf;
	Sat, 14 Dec 2024 01:50:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734101458;
	cv=none; b=IFzbR2X0J0V2jeaXfrEMrkxTxBs+E3SBvhcrMWfGDqIbaQ15bbLOSkrz/K/06PRHicymxJtwW30Fw1DlCKnrpC0J3wtzGUn7PUVraTA+8fnmUoBnZldxGxLLhnaG9hha1R50jBdYll4nd42Sn9YfDZJXwYUSV5xDpv0VkPf0EaMxXFgbi4tKnZPXKnPCGtYKbGI0s27AVuneuGTIuG7SxVF7PxtYJOxt178C5Lzmw+dBmjCHGRdcnle5ba7nVeq+IxTmHYPuJzvh72V3zSvMwQQWb9ucuZZYdkxOOUBXkA7W8+CCJm2gjUMbM795hcnJx/6KpcEH9AV7OVdUfR2c9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734101458; c=relaxed/relaxed;
	bh=1A4o9TJk57MA+9zwLE6hTD2yisDJsgIjNaPzNrZQc3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy7l3HNjhqxtLXnlB++5wfv62BkDStK29NnMz5R5xkW/O2BnHQHtHO99U9ycJt59DUmJq5msfGzZLNrm0V9Qme7vV8bTaEOnN1dMHEPTcptHIfUeszz38gsS7ZFuPPfyYH486Tgm2kfK4U9bKF7JV0mmuxEWr4BWEnFECPMNr6IKz/BmN4+IjS4ye8tBj7kcjIUev6nIjctjsMRe/rnNOeouQ0K4J0ZSjepD6NjkFzPXS2kwbPq119M3/yZCm42AnWxJnSvbaldOW9oN5AMJfw1gQpYiHNni69+rokBPXkPTo8ooYF7QRdl7YLYVDN7vdUiqm1NgcXklTad8WJURnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZwHM5D8H; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZwHM5D8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8shx3pL5z30hC
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 01:50:56 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIvoh022063;
	Fri, 13 Dec 2024 14:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1A4o9TJk57MA+9zwL
	E6hTD2yisDJsgIjNaPzNrZQc3g=; b=ZwHM5D8HRQ4PKG7Szss0SzWQ5KYiVCfcW
	1mfm6sFO6/AdDWM9nHhjWHwS2HNOfPsJf6q34dRP++MYyaZzVRoN/jnjW9Rm2Wu4
	Je7uB8+0ERCwouuWcGulSLQeYFy3EiURmkpj+lowH7EcoVtiVBq9w/t0NIuh+Xs4
	gONTNgvxmPUAHtHiRLGYeNSlhvQd1zk3KQon+agCYxSytihL3AkteHhdPHoK3eEb
	lDns8pxyFX1ywx6pwaXP9wk2l3uZEzIfttpTCZUX9hj4sr5wSy6Pt8NvBxEHHhD6
	eaeE/fNMXtCrhAIoonxzg3pH/Jnb71npmhL5BMcBV8pDcw2saPp5w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhkm5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDC5lK1016926;
	Fri, 13 Dec 2024 14:50:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yphgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEofnc37159360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106275805E;
	Fri, 13 Dec 2024 14:50:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E50E58050;
	Fri, 13 Dec 2024 14:50:40 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:40 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 1/8] ARM: dts: aspeed: system1: Add IPMB device
Date: Fri, 13 Dec 2024 08:50:27 -0600
Message-ID: <20241213145037.3784931-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: fKRPsI_CUA403YpcABO9Wt2nvZdUH5no
X-Proofpoint-ORIG-GUID: fKRPsI_CUA403YpcABO9Wt2nvZdUH5no
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=758
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

Add IPMB device sitting behind PCH module

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 8f77bc9e860c..51a116d7041a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -763,6 +763,16 @@ i2c3mux0chn7: i2c@7 {
 
 &i2c4 {
 	status = "okay";
+	multi-master;
+	bus-frequency = <1000000>;
+
+	//Set bmc' slave address;
+	bmc_slave@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+
+		i2c-protocol;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


