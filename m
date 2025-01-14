Return-Path: <linux-aspeed+bounces-479-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E473C02185
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 22:02:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXjmG325Tz2yjR;
	Wed, 15 Jan 2025 09:02:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736892158;
	cv=none; b=mBPCMpAc9PVIjXy1H/A5ElRENL+X61rVVoICAAAQBaPMOkG8B5X4IyS6VjflCM6NXzr9oE+ugzggm6zq6/07WNj37OKxwg3lTctNEgZgZwu20CBojQtRlY0N9MxZnuuIU9fe+G2hVmiPH2BX618NSRp7wvTF5Fc/zDZxZQ11NKf4UGPpLktFwv9Y0rPVs2canGCpjIulSg9d1wfVXDDMKe2yTTWtbSOu9+wYXkEjeR/orOykGntmYj6snEKkALlL9UMsTujyJ9D0WKJkl6UOSD9XJLwWZiOk59rDth8vHAvU6WLE5zFfnKBu//yduzC3k45wiY14Y1D/i6/NgMe5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736892158; c=relaxed/relaxed;
	bh=uFmc3fWwU+UWkA5NAjC/u/5zyqF+9SC/CSG4ZyHvu1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it7a5CkWsKpS02CA2pdhZONYWabvdbNwW1WwgVh1XDEpPySn0leR/DEQwnTUMFiW7fnjwfm7xLQ1h7M+jHaTpi4xouPfY6QYC6MjVJTQkFiAIJnaanwrmUsBE5Q0keUw0a7YtfW/+l5wFujxdBi989hMFrR5rd7IHHxDaOrgJAM3y37GQqXymWiVOv/Wt3Ib4CQCg2Kb/Pc76HcwFtbj9nT3kdk0wZiouV0g7HCPEjxMnW9Xv+bdZiyZ8CbhEme7ktEgjlkyIhgrrXh390mhzuHL//YPaVS9Skjxk7Wqk5IdjopwBwDWuvVWbcLDNR3+8BxASCGwR50SGF8/DX+i0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EJ7KVL1w; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EJ7KVL1w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXjmF3zr8z2ym2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 09:02:37 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EE6KhN013488;
	Tue, 14 Jan 2025 22:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uFmc3fWwU+UWkA5NA
	jC/u/5zyqF+9SC/CSG4ZyHvu1c=; b=EJ7KVL1wRNERm7OA0cQwCPrmwEx08pRBY
	Y5RyiPDr9P11PADsXBhmMaRjT668X3QncBrkstV/4nW7kvf1v+sci4FVxeY5RNBJ
	UGG2/j57WpKSyQ/KqzgVU/A7EYGhyMF9RaUPd0tZM3bnLRJyjNMaIF4Q7hHqmgdy
	GNDxk6DcQb3YsJfRA/7RARZkcC/e/cgP5zWw8pYCMnb0/IcH54C45MIAwgUEyjwR
	vQRt+GG0xKx0GQ5Ypag0WSm+SKYDKP9DlPOIfqgjTTf7/6bdnr8BQGu6D2KU/i6Y
	NIBrhu6zLjAFpiG2dEzBxqUyX5dEit1E0f5TGPX6BKEvPFqPXlYEg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445sd6213t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50ELvOuP028050;
	Tue, 14 Jan 2025 22:01:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445sd6213m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EId9nJ001089;
	Tue, 14 Jan 2025 22:01:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jw1xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:01:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EM1qgg18612872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 22:01:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EB6658059;
	Tue, 14 Jan 2025 22:01:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15BA258055;
	Tue, 14 Jan 2025 22:01:52 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 22:01:52 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v5 09/10] ARM: dts: aspeed: system1: Mark GPIO line high/low
Date: Tue, 14 Jan 2025 16:01:43 -0600
Message-ID: <20250114220147.757075-10-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114220147.757075-1-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: B42NHJSvYXt5wbHtYnQzFUlhKQ_S8xna
X-Proofpoint-ORIG-GUID: 65DADc97KBHndruFj5sytOJNwr9iFl0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=909 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140166

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
index 089a8315753a..1f0a6247f97e 100644
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


