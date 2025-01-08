Return-Path: <linux-aspeed+bounces-363-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5EEE7719E
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 16:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YStqs1yMmz30XZ;
	Thu,  9 Jan 2025 03:37:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736354249;
	cv=none; b=n9eGKG1H7yWYOZKmAvXJjJWyWs3SgbZFnkgt/ZmuoMeZEkJNfRiYQ5SRZMvn94zDxHQctJaGQjThlsaclzF5vJXkidrANsvwZB2/m7Ha7tI+/CvuxKFEuqCb885rN2Y1vGwDW+sU1EE/XlBUPHa+QxvPjVSoxPtagVeaucUMCZYb+tjkGFeZ3v3IyMurxXZixwd9defoHKrFgRIhUIPnsnh/Dnu8ptNqjGwfmb5HYgqPd9l7gae+5U3hO+ijGmyzG6HGjlkwEfN/165nmGizpShRf71HZjtJBhVRJuiYzROqp8LyGFZizSnxQjWn8gkmw6j+v1fNwPURRfWvOsQteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736354249; c=relaxed/relaxed;
	bh=fsZaBvqB5dpJzWpJ5hZO5QeO8dMiC6iqXWnWtWWoyMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im1d65nC+fcv0Rem1vxO3O4Du4CbFx/LhksE58YmkoUZOo4kYUaC19iPpiA21Au9o8sWBOPWdA2U3cDS0l1PN1Jx5j1UfgnDxBkAZDhq3AR5vJ2D3W8s9TR+sc4CqGyvfCX23fdTQA/k0GFcQhl+EvZ2fNjt/a/IxsyKW17WwnZ8culamMof6OPtfX07RXZcjCM1A858x6h9jstWnX+E7CRrrMiak2B9FiWTiU2ItbevRWh04UMt/3TBChpu6h/ZNeUUc1swaJTPKYrWfvXu3In3euMmWx6H4mPoaAasKZyulDX7LNQnFUz2nAOMGORV1SQYo0SQSQld/QWYQaa/Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XMEILpY8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XMEILpY8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YStqr3Rcxz30Wp
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 03:37:28 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508E6lld001175;
	Wed, 8 Jan 2025 16:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fsZaBvqB5dpJzWpJ5
	hZO5QeO8dMiC6iqXWnWtWWoyMU=; b=XMEILpY8/KG49vhyMDV09vojU5Ktwrgly
	5bP/3cs0reaBUv1CjCxRswIxGE1B9PbknHbCH4AcPcFZpUU4nppMuAsUq851oXcQ
	d8QPUyxrPVhed+hrJHiFoEp1RfCSgeXkt63NvJw3sMPMTcuT6S/3WjDu84kS5P0y
	MqYiLdiBJMFvNnVSCGoKemDgoWSEGwhuER/OFlr88veZi4hbXfrY5BUEBiZU+DgC
	R9qc8IElkRloGwW/nPGRXCiPXJdaKG9QDwl7V+AITB5H01t7ndq5ut7+M6qNeo3X
	SGoH5/tjMy51RkRs1+HBHv9TCDJFYrpkG7Pz4nSX/0SLA50VTB1tw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5gpd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508GZVF4012693;
	Wed, 8 Jan 2025 16:36:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5gpcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508G88PW004143;
	Wed, 8 Jan 2025 16:36:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat8vwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508Gas9T26542614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:36:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D1C58057;
	Wed,  8 Jan 2025 16:36:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A12ED58058;
	Wed,  8 Jan 2025 16:36:53 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 16:36:53 +0000 (GMT)
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
Subject: [PATCH v3 09/10] ARM: dts: aspeed: system1: Mark GPIO line high/low
Date: Wed,  8 Jan 2025 10:36:37 -0600
Message-ID: <20250108163640.1374680-10-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108163640.1374680-1-ninad@linux.ibm.com>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: 4qtteKZqfeR-F6ZMZc4CyEcOEcETSJ0b
X-Proofpoint-ORIG-GUID: SwE45y4gFxXNbdAKVNQxg3PrHBDyVeL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=929 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080137

- Mark following GPIO lines as input high:
  - GPIOL4 (reset PCH registers)
  - GPIOL5 (reset portition of intel ME)
- Mark isolate errors from cpu1 gpio (GPIOO6) as active low output.
- The fan controller reset line should be active high.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 90570b4d6d35..8026c67ecaee 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -383,6 +383,34 @@ &gpio0 {
 	/*X0-X7*/	"fpga-pgood","power-chassis-good","pch-pgood","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
 	/*Z0-Z7*/	"","","","","","","","";
+
+	hog-0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "RST_RTCRST_N";
+	};
+
+	hog-1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "RST_SRTCRST_N";
+	};
+
+	hog-2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_FAN_E3_SVC_PEX_INT_N";
+	};
+
+	hog-3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(O, 6) GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "isolate_errs_cpu1";
+	};
 };
 
 &emmc_controller {
-- 
2.43.0


