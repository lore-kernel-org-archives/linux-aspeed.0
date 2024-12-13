Return-Path: <linux-aspeed+bounces-234-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827DBE7717F
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 14:51:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8sj50391z3bV6;
	Sat, 14 Dec 2024 01:51:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734101464;
	cv=none; b=Va//VDcoHDprhHAoGVC2avbr6U3seGRb3DO1BIndsv0PywcRo5yO11+aefmXQQ+adqBmPgpBr05MZyRUiV5IfYw+gNStMHPpc44sbTj2DKaKMUdVGpr0kj8n3ij939s+zs3Jiee4UBVrZR03G0deu+SuSKwaLHpcLsMGyKr8nR4zxbI0Im6B9Um6+Eu5G6M0EormUfxDEFFdxLQgrC91QFCkS8brObvIulWa00W3tv6v0WPoSb8DF0rXW5jsXskWVUJ/1HEhUAJTV5I8jlcKjTYME6KE8HXbDh4Y2sEfIPr2S7pjz2iAxSq17DKSBvg/1yTcsxE4Dakwj/5rB/7OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734101464; c=relaxed/relaxed;
	bh=1Ps8PZ48azPDmDkGqM447j7mdpJN2YPTJOYaXEaVT0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTkR9jYp2kvJg5Jkf44M7mRwt2UTozXe7kvkalcJmntl8PlRHhUtmNE7koZhpC94VGlmanApS09Tztou5GC8M5R1tpAI3sS7ygMLBFJJ0SK8lq9jl6AYrrHVe4xdFkJ7xVS3hCBqbDq3zEHQEbFgpvsbtBVQmApCCO3Agog3UOXs8OCB40Swc6Q9UopSf1qNmPF1tguXhiJxxzmVWrPSKsGhQOMwa/CKYqQuaUTFwNvdsB7/6YZn8fkfH82BiF04zIuEnKCaQc/dECcrOFEKfD1j8HW2QEPDvpwgvtcUgFGb2Nk2mtbqBjs2JDVfga1clSuI9BfIzBKLu8xO+nxJzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QzLDTDgV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QzLDTDgV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8sj41BkLz3bV2
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 01:51:03 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIu6Y031404;
	Fri, 13 Dec 2024 14:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1Ps8PZ48azPDmDkGq
	M447j7mdpJN2YPTJOYaXEaVT0E=; b=QzLDTDgVN4TKxfGX4gd7aI0WYVoi5J/+g
	G1MxC1klgoWXIdkNw0gp2p/opgpS9d2etvc7ckaf5cFBUW31DBpkUsBopeKLN8sJ
	aFSf1qW0c/0qV51dN+e7ICERKBnRHRnG+Z3X1CCl1LVYzCVY6o1nc2wCZISZEtlc
	rQktq8XFY7nqhFxaxLBH56WA0nYyBAh9I2VJxGq/4ALP92UwFawtqAQ08aLHD2Cc
	PpAa659TfxpNoTPxnCGdP+icj3o96++goCfHb4DP8CGPP8BOarVGjjWI2QM4YMqp
	7Q9J7rJWW/s6rmRkZuBUR2nr490n9rhrQ1PU3ix86PXoKYDIrEoEA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gpd5r7bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBM392029231;
	Fri, 13 Dec 2024 14:50:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43gcprtheh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEokBU30802490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7280D58061;
	Fri, 13 Dec 2024 14:50:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA5985805E;
	Fri, 13 Dec 2024 14:50:45 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:45 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 7/8] ARM: dts: aspeed: system1: Mark GPIO line high/low
Date: Fri, 13 Dec 2024 08:50:33 -0600
Message-ID: <20241213145037.3784931-8-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: TtDooRRfjmuIUIvNQt1ObXcxJoI3CeBP
X-Proofpoint-ORIG-GUID: TtDooRRfjmuIUIvNQt1ObXcxJoI3CeBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=938
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

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
index ca2d4a292687..be0cd6152c61 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -383,6 +383,34 @@ &gpio0 {
 	/*X0-X7*/	"fpga-pgood","power-chassis-good","pch-pgood","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
 	/*Z0-Z7*/	"","","","","","","","";
+
+	rtc_reset {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "RST_RTCRST_N";
+	};
+
+	srtc_reset {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "RST_SRTCRST_N";
+	};
+
+	fan_controller_reset {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_FAN_E3_SVC_PEX_INT_N";
+	};
+
+	isolate_errs_cpu1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(O, 6) GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "isolate_errs_cpu1";
+	};
 };
 
 &emmc_controller {
-- 
2.43.0


