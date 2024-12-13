Return-Path: <linux-aspeed+bounces-231-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB21E77180
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 14:51:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8sj26GXKz3bV3;
	Sat, 14 Dec 2024 01:51:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734101462;
	cv=none; b=YDogmDsWCXbFWOEnPBGG9+CiR43+JfMoP4xZTffiS0eMNIWEZ2Apj3+f5aW3gG9gs1RIAfAu/4vuAYOp/OaSiEUwbq77ImmlNEPQ+aUsdgRAOTayUkispq0F7qfI/9RGzJo8XgZgQ078XxngtgWhvoaMBV0J1TW+wZ4MKC82g4wZon7TLIRWexfsI7LUCOA7+osnhKsATxG5Kale33/2Dco4+ouzFyYqnEDtgICu4HcUC+PYDw9MgvLxEpDBYiL5asxO8Qti6FVbb3FTxADA0skoNNn8IOwNnhORtc/3WdI6/qs938S/LyB3lknCwzbCmKWA/jMQe/+D4Rih3l3tuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734101462; c=relaxed/relaxed;
	bh=cMh6AeyFpvczebWCh8FNv94z64GtVsxRzl/pqnu6d8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2vfYLVYSsefYMDa8RH/S24qB9UWGdXfoafzpDqZbysZdh5DHISCBPVz6aW7Ou3SNR1FpilYOUIeFPbOPVkYywnWbH6X7q8yMg0faDrDavJSRJ8Rpt0oIozUIXGAYRcYdp+iydieZSz+KTjDKidFlznqbw+HHzYZbo6B+jOlbt4CCKNRX+3RjFcaHgn4vGuN3EtK0a0u9lNXc98Po6PDUvbMELQx84SfIUFYmf3sOMNufEiHzux/lpK/ihBKUNtHKcFnXscUgCKTmqrh2ijzIO+ZJwE4ifFkWE5KgvqNXPHKqVybA0cRV6y0SyoXTn6NdF6YC/BGW7DUX7kwvqThhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WO7A8we5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WO7A8we5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8sj21JtZz30hC
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 01:51:01 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIvoi022063;
	Fri, 13 Dec 2024 14:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cMh6AeyFpvczebWCh
	8FNv94z64GtVsxRzl/pqnu6d8U=; b=WO7A8we5Jf+NW479G9PN/JunpaGHQbfGZ
	agkzf46PhcfmVVWrr9129WKOE3JNu+z+3cnGD6TeJ2gXmMGgHIXLxPo1yBLmXTfN
	EzbBX2GMUVoGTNaW7or3DfrpPXC84i+h7PnPirjt9UXBiT1+3dE5xDhPqSfgoWKO
	VUsPtgTosQCBq7xwNMA3U4nE2U+XTRY+5eKJkyQHyRp3tDy26a2qN+Mk7XAyh7bA
	TqpC69QODv4QYVAD9LVooMfeAbUe36UbrwC0SdGofT06kfiplDQ2g71Tu7Oe4hjU
	2niI3KMQaQUbd45Q86OBttacDA9pipg5mE9B76sHNMkWiU+mbJsVA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhkm61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDt6mx023023;
	Fri, 13 Dec 2024 14:50:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wke1f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEolCG32637568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F7B858056;
	Fri, 13 Dec 2024 14:50:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0E858045;
	Fri, 13 Dec 2024 14:50:46 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:46 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 8/8] ARM: dts: aspeed: system1: Disable gpio pull down
Date: Fri, 13 Dec 2024 08:50:34 -0600
Message-ID: <20241213145037.3784931-9-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: AIwkqErLoC_II4uRgkPVjB1yp8bRh88Y
X-Proofpoint-ORIG-GUID: AIwkqErLoC_II4uRgkPVjB1yp8bRh88Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=849
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

Disable internal pull down for the following GPIO lines.
- GPIOL4 - Reset PCH registers in the rtc.
- GPIOL5 - Reset portition of Intel ME
- GPIOL6 - FM smi active
- GPIOL7 - psu all dc power good.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index be0cd6152c61..c9575dd59b03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -355,7 +355,35 @@ &uhci {
 	status = "okay";
 };
 
+&pinctrl {
+	pinctrl_gpiol4_unbiased: gpiol4 {
+		pins = "C15";
+		bias-disable;
+	};
+
+	pinctrl_gpiol5_unbiased: gpiol5 {
+		pins = "F15";
+		bias-disable;
+	};
+
+	pinctrl_gpiol6_unbiased: gpiol6 {
+		pins = "B14";
+		bias-disable;
+	};
+
+	pinctrl_gpiol7_unbiased: gpiol7 {
+		pins = "C14";
+		bias-disable;
+	};
+};
+
 &gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiol4_unbiased
+		&pinctrl_gpiol5_unbiased
+		&pinctrl_gpiol6_unbiased
+		&pinctrl_gpiol7_unbiased>;
+
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",
-- 
2.43.0


