Return-Path: <linux-aspeed+bounces-456-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB9CC02180
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:49:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2rf46Rcz3d95;
	Tue, 14 Jan 2025 06:49:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797746;
	cv=none; b=iOtis5r5YWS+QVnc2H2Z0Nkto0krneDLSclsRAldgySsTHGc2HRvGwFWMCnYSFm19aCbOiWKvKuMjzdQCBoZYCy8ZfY69KwUxyie+9zCSF/1t3Ds2IxpN2WsrNhBzcUIrASgl5K/NVduDF1bz/R+NJAa2DVVI9J23X13c8UokLjoiWMLnm/8EPewtm05lA0+XuX7f8+Bz8qIbajFTK6kQOeqF4n5m9hWTb/CFNr8RKcDlJ0IfOBRWtt4pweJW7ZTizX5Kgd60lcKK6JhFLpKSfXoSrhyztQ7LoT+LMtapUU3lI01j3mKfRwk0/NM9HkAlDawsxtz38y6FaHwD9BkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797746; c=relaxed/relaxed;
	bh=lI3o01bHQXZgJL9XcZlb7A4E5yqHwfiO2JwhT8zbtNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WptwanQpncS++WL3Vn8vcZ9UHpjNVnJWMwHIDsKdM/d/GM5Ot16bmX15SWu4yhIrshaxagPIF5C6EhHFnI7ADBk9w6AwUtFgwzOpvyICl2E8B77TfYHW39GQ9u53M4e2ZvYrhxHWntdG3UXMCk4a0IXLQAJL9XcZhG7XVu4IeiUdRKp6aN5SdfHDGj00PNoY//GrkN5W1cmlvjq/tTRaa8jSvQJcBVQY8zrKELy5NDXY0DxgC+IUJ5ySXKHW8a4COqkFNthfLa9dWV9AxwnMXN6nT0mAlHBq7ORwHTYTjDqLtYZD5xFJOt8aeX8cNKE0iBCGa6jCFwW9pf/6l36vcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=efm847bQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=efm847bQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2rd4y4lz3d8R
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:49:05 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIPfXq032628;
	Mon, 13 Jan 2025 19:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lI3o01bHQXZgJL9Xc
	Zlb7A4E5yqHwfiO2JwhT8zbtNg=; b=efm847bQE+Y5mGPQl5ZKS2PQbnJRI+faa
	oaNf/QEtuH47exBlnB2LvL/V1QyJiFBwZ/dyH8eXX/fKW8BG+A0qzqBtJEVeu1uW
	em0g6VogQJgR8Fv2MLME/xCK8p94AdYDHNeJcPdbq5w/ltcEO1VEIhfvHMN8bOQ0
	MiJLOfVEiPj46SzDswC8gz1AmxNZdCH9oSJdvdZ+Ic5Plm0hontF/AQ4ghoYdeKO
	y0ZzJ3bc5iW1cRMe/9Of4z43ez4ppgp61Iua2+6745EORcLMlvfRXYowHq9zv5YO
	7pmemVZw3NNd154XT2u2i+KZO5kGrPvoROhUscwBAbOgtHKbbhHgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12k1nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJmaT7019407;
	Mon, 13 Jan 2025 19:48:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12k1ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DH5Aw2000875;
	Mon, 13 Jan 2025 19:48:35 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jqjpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJmYLG27263526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:48:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCF5B5805E;
	Mon, 13 Jan 2025 19:48:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9175805B;
	Mon, 13 Jan 2025 19:48:33 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:48:33 +0000 (GMT)
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
Subject: [PATCH v4 9/9] ARM: dts: aspeed: system1: Disable gpio pull down
Date: Mon, 13 Jan 2025 13:48:19 -0600
Message-ID: <20250113194822.571884-10-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113194822.571884-1-ninad@linux.ibm.com>
References: <20250113194822.571884-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: X3oty0EoMTvYFCKhAsy8gd2Rac_K09JN
X-Proofpoint-GUID: aVJwtmOYazZ2VHAEAu0jw38S0gOk86R0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=872 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

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
index 1f0a6247f97e..723cbbbc72bf 100644
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


