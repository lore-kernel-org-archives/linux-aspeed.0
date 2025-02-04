Return-Path: <linux-aspeed+bounces-642-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5BAC02194
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:44:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnXMd1WkMz2yvh;
	Wed,  5 Feb 2025 05:44:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738694653;
	cv=none; b=lP8kyjz/hyBt/GqPN740g/MjKaFUHMSfbEvZYKKMpKzcRtd/fQGGRWEQvD4n4e9LKviVp1Z9QriCxh69mliMWCKt9UTSwE9CemUi+/Mp4ikk+Ts72Ykg4iNsdgT2oCaDPxNPX3YhXqeR1j5MZID1xGeeWb65UsIPpz/Etx0j2UixpPAI9gdYNKRKSiHqBoI1OHicieHCC6hQ2+lpy5PQ400XTxziH1xjf8W5ZlcnSKVYttHC3wclO5JT0URODRSb7JX9xwKQP5uu1z8+wIuMyM6TrQLwhY07hSewqkVkCKwFrDidqWWQUxMZ4yY2wO13VWd4ZBPrZ/8B0wsr98NiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738694653; c=relaxed/relaxed;
	bh=PYjjz1aWU4NtFt4XUxGKKc+IidttJLlsWDQxKQMaaKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwJkQxXS5snuObC9w5LPVzZlUQZKSYykTw8zxKTs5eXbcNtyszc5bU5YiougOr/oyJ2tDyStdTIrbLgZJbfDhb+4xahoEZ5je2xMQ1twhLafXUM2k/j+OmuZuS88jF00b7Sf23WkjwCA5jEF7JabRX5JKKKwmrwZoIrGt1knqIVM7Kjef1GwAakGn/al5MX5+iowUOHvEomaLHejw2bv+/IkL4v7gkS4VSPzjMbBf4N6yN3OULG0RNl7yeEh5hglh8U0Y40kRukVRH9PdLg8ctQhW8ZaTNLtsLLZC1W1uCZr4g5d6INBqoH+RuJE4WW5ubsKqdnYNfY4ybkKy398Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M+r60eEP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M+r60eEP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnXMc1xKxz2ysf
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:44:11 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEmFh023238;
	Tue, 4 Feb 2025 18:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PYjjz1aWU4NtFt4XU
	xGKKc+IidttJLlsWDQxKQMaaKY=; b=M+r60eEPK1QLMq2D/iGTf/QA3gdFfsxHD
	spzJ7fjAmSJgCvB5djBZ+db5W53dlUvrEGV4HfQ5mbIH3/AXr4y+8jdyl39opqNk
	ZHdHN0bwBK6BPnZcX73PUeV8dY7N4EJNqtdFYhZTdLIHHv79+YF/FYUKML9JsjWQ
	dZXGR17YmyIXp6MTaMIyx20ZiH28NTbF6I3XLDlhDWU+VPbjHslEOAKHGB7sj1tA
	Ay5eyW2sc8w1gDf6ma5SNDwukCEwB5F87So/ARsroFfdyJxG6vjuqlol8aNIer9g
	BL66jNBCVbpwxHE9Xs4SnDOHEO3aF7aVR22ThnNt4uV2/1LEAaryA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62h6gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514G6diX024506;
	Tue, 4 Feb 2025 18:43:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn4y1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Ihon319923586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 18:43:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5099C58058;
	Tue,  4 Feb 2025 18:43:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A6158059;
	Tue,  4 Feb 2025 18:43:49 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 18:43:49 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v8 9/9] ARM: dts: aspeed: system1: Disable gpio pull down
Date: Tue,  4 Feb 2025 12:43:35 -0600
Message-ID: <20250204184337.3896834-10-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204184337.3896834-1-ninad@linux.ibm.com>
References: <20250204184337.3896834-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: 3USUnJHjBMRwF6VX6atP-O_ydnemG9SL
X-Proofpoint-ORIG-GUID: 3USUnJHjBMRwF6VX6atP-O_ydnemG9SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=870 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040140

Disable internal pull down for the following GPIO lines.
- GPIOL4 - Reset PCH registers in the rtc.
- GPIOL5 - Reset portition of Intel ME
- GPIOL6 - FM smi active
- GPIOL7 - psu all dc power good.

Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 00b091bc7da9..c8267c97a44e 100644
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


