Return-Path: <linux-aspeed+bounces-3944-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16315F94CB6
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Apr 2026 22:46:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0csV1Pz9z30Jy;
	Wed, 22 Apr 2026 08:46:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776811582;
	cv=none; b=JH/rEfH4tILMASwhQGNICZKN5qcmIIfUiVrkKDQ6NmLUDuX2sjzgeUSMNCGBIJU+BCzUjxehkJX3Cefoc/6gwkQrbATv+uRGf/SoMZe4IA/cqUyBq3PXwI0IgQ4ycbieohLs7K6inMOBeAMlnGiij4qSSSyGVZwYS/kn85A6b+pyvTW5dyVM/Bnqk8b/AgeRZNsN3+M5WAcnV7Rc/OPkhu7xrHfaWxKBW/HhFotoXNOcrUJmaQmFn/sgJ80qVPXEOzQrSJBFW3Bp2cPpVivwfq2CmKo3u1fEghQy393NjMxmFygnEt0D3q0q1n/KszcnYVFatN856t5EN7pDrnCMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776811582; c=relaxed/relaxed;
	bh=cS+yLtaHravYz+Y7YPFjvQMfMx9w5jkr37dgZcu2XRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyMjSWoqxBSJJ9f8++JDGLQUf9aKnGOWcL4u59b1eWPScaCuSGrXz2Gk1MkyhtpykQ1DR5eSoNDDFaar5nQY3rsR0BH0bV9Z8B83UyK8RzfeYjpj9bD2wjOxBHxFaq1GnDTik5+lTj+mw1AWTuQhgArQmYtag8L8TylGm/bLyOZIOfWYowfwCkodCSXDOnwDcvK2dKK3x2Vv6PnERezORDNLMdH8OQ8LgP3xhisIIZjmN1OcX4fzYA/kMzfGN1NwF+5CzPD3mPijDKd5JfRH8hI6ANOdjgEOqDB1gE7qSL5HacW3SoByjiQuC1/CuB5l2NM3n/NrdVzCNWNBt/dsTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R9Wox7gN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R9Wox7gN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0csS57Bgz30Ff
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Apr 2026 08:46:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LImRGG878216;
	Tue, 21 Apr 2026 22:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cS+yLtaHravYz+Y7Y
	PFjvQMfMx9w5jkr37dgZcu2XRY=; b=R9Wox7gNf8Sdhzwv/E3I8OcXwzTy5S2JD
	JRtusrJK/sBv1GyhrFK92ml7zB+0qBjTpRj2a7K2EGTbOc0wTloD1gy0B12lDViY
	gf+/PQa1ZaEVtdxtO/xb1flF2btegyd9SRfcoeviN5EYcpxotEYHjZdCaiMGe3eV
	ZP+xncZ/HshZlCryzm/L9xr39dDKAjsJfGw5WDAHVjWFjNmLK0fHupdyfAZ1jaXA
	hu16qZGRtmUCgMtRJISebYrxsztAQPlpjgDXemP8oncKneEhvyE+6mT7TF2sOmUC
	iUQp84j9a86JkVpIszIFbMTw7vf2wzgMMEcSN1a2hkCTaBs6Rcggw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu20qj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 22:46:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LMZPdB013594;
	Tue, 21 Apr 2026 22:46:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsh2js9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 22:46:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LMk3va27394736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 22:46:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5321F5805F;
	Tue, 21 Apr 2026 22:46:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDB7C58043;
	Tue, 21 Apr 2026 22:46:02 +0000 (GMT)
Received: from pfw153.pfw.tadn.ibm.com (unknown [9.5.7.52])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 22:46:02 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: eajames@linux.ibm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 7/7] ARM: dts: aspeed: system1: DTS updates
Date: Tue, 21 Apr 2026 17:45:44 -0500
Message-ID: <20260421224551.1611818-8-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421224551.1611818-1-ninad@linux.ibm.com>
References: <20260421224551.1611818-1-ninad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyMiBTYWx0ZWRfXyCw/pT34eaWz
 NvK52xExibTzl9ixyuXpy4vYbc40L46feOmRq5aJzGxdvotyVOkTZAxNDT5zeHho1Mqer3pLOPC
 07myP+m0l/Mjg05xVbNkvoDkJylhAMMVXeIM5bjj0Dxx6NlCIqXkP4JnEkRwYWfGjA8Bd/x2Ppf
 yqCQBG+5fsL0oV/KmNoLuAzX2XrvsqMgucb11g8gAVkksRRhBhCp08RZI2n2NSXDheVxOUcITza
 aMS/D2NtaPK53aqFvCq3RI2ZZ+AD3sRQc/Rhc4R6MzTYeM7kgcVJrXhT80f/qTGBJ8tpvWykvH3
 hIc8sayRRiPlb0/gNu8EQZ8k5eVu95Hw3h1sbW/mBqJY8V1mEW2t3EmkOUPSEV5446L78Z0Kysk
 8WKHgFxAXpisCq6pMh7yL3YYq1KDnm2VaFlpDcB6dTlFoR1c02kYzEQxaxYMeyVHz5evFW7Dnid
 VNTk+y5fBUb1qE6XUqw==
X-Proofpoint-ORIG-GUID: sqXl7nSeLWUgo4IcCn7u4ZdF8NAXH1zE
X-Proofpoint-GUID: sqXl7nSeLWUgo4IcCn7u4ZdF8NAXH1zE
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e7fe2e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=weSylXKMd7dZRB46iqoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210222

- Removed SGPIO node as not in use anymore.
- Updated chassis power related pins as per the new hardware design

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 91c317267d6b..d7a934fe5860 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -424,7 +424,7 @@ &pinctrl_gpiol6_unbiased
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
 	/*G0-G7*/	"","","","","","","","",
-	/*H0-H7*/	"","","","","","","","",
+	/*H0-H7*/	"power-chassis-good","power-chassis-reboot","","","","","","",
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
@@ -440,7 +440,7 @@ &pinctrl_gpiol6_unbiased
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",
 	/*W0-W7*/	"","","","","","","","",
-	/*X0-X7*/	"fpga-pgood","power-chassis-good","pch-pgood","","","","","",
+	/*X0-X7*/	"fpga-pgood","","pch-pgood","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 
@@ -486,12 +486,6 @@ &emmc {
 	clk-phase-mmc-hs200 = <180>, <180>;
 };
 
-&sgpiom0 {
-	status = "okay";
-	ngpios = <128>;
-	bus-frequency = <500000>;
-};
-
 &ibt {
 	status = "okay";
 };
-- 
2.51.0


