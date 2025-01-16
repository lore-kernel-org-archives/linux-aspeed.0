Return-Path: <linux-aspeed+bounces-518-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC72C0218B
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 20:36:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYvlh1XWqz3cdZ;
	Fri, 17 Jan 2025 07:36:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737059776;
	cv=none; b=JWtAQZ9gDCLSkr7tOxLfvjc9Uaf518lGR6UJT21vnRdpW2Y3Yyg02hM+AeqS1qQ4RFtMkxZ9IIAa1kdxajZGHTarkzNz6OLq0MS8N2LpPmZhDB5sRuW7HqXQeJ5eJq7jUBF23Va/zHqj5iw0+DsGXyTlL8eOevf+0qvt0TDNaaWhkdJ6TT6K1eysTXmeFUwpY80fGA8LnlBk7TCM1mrDvCPf074eH16DT6Fa4nVLmXVG7ywO2Q2RlriEHFXhI/99VzpnTQnIxzdX2pkHVNFBuUKrHLUb2lfn9pnbWbtFKjlCQQM2GIGiX86rM2GNVsgPDG4ek5QpQbUdmPmcPFf/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737059776; c=relaxed/relaxed;
	bh=+jr4Ceh/umV7VXKGfGgJe3Fldiqyi1OTzMj9Uq8APsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT8TUiumoM2+Dzi2nvsR00acrmfnJuFO1eLsSiWnFYjCsuqezNnwl7JXGCBmkhPcfAQXkDG81ufJwzFQ0T2YJgk+coO7RMDSfFMqFNdBpt8QPIPmSylJOjTi8/yr2mut0ja3KqzG/pS8qhNZv0QdMagRnmaxX1QzL8MY2kn93XJ91kcrRd2VvnrLXCiWeG0WmdTIEJ+UIa/4ADcXoNy3oVZ/A2r+jX35MCxSs6v00byWeal79JHPAn57Wmhr9FkFmP+gWL3B0A7rLJQvSTjeekWx9RUB8RpNLJ5tEYWx1QlE0Px6M70geOqlJ5SuULLR7ubBXKT2nOHKwiibrUSr/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bgZK0m0P; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bgZK0m0P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYvlg48hGz3cds
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 07:36:15 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE6LDs024421;
	Thu, 16 Jan 2025 20:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+jr4Ceh/umV7VXKGf
	GgJe3Fldiqyi1OTzMj9Uq8APsc=; b=bgZK0m0PWbY3iAdUnvz5ds+B/5KDGEAxQ
	6LTGa3QAayf++4eF88l/96R5KQccq2+99l8IifgI5/eD3GPDGEMnbD8n5bTUpofQ
	Qn67AqwBiJ9uBH3ESJFbgDdEcgjMp7Hdzvxyk2rT/LC5dumPGIYgUQ1RvdZ4ZBiC
	+97lzU3WrTOAoo9qRoSf+1gKngIgTNQZO5/N/YcX6v0WZgIBWEK7rAPNl31zQhbT
	4edqA/AepZlj//R5D1PQ8cuOLXOf0OZYwxZz8n9ZcY+GIGjx+0G2aj6Xc9DO1w7S
	r1kFpps8DnUDlfVTxNeTZlVHbtRWR1MA8aW5miV57w9+mLcoa21kw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k59ur1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKZk4d015817;
	Thu, 16 Jan 2025 20:35:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k59uqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GKWBRN002689;
	Thu, 16 Jan 2025 20:35:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byfrn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKZi6E28901930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:35:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 022BD58059;
	Thu, 16 Jan 2025 20:35:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF6D5805B;
	Thu, 16 Jan 2025 20:35:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:35:42 +0000 (GMT)
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
Subject: [PATCH v6 10/10] ARM: dts: aspeed: system1: Disable gpio pull down
Date: Thu, 16 Jan 2025 14:35:25 -0600
Message-ID: <20250116203527.2102742-11-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116203527.2102742-1-ninad@linux.ibm.com>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: BmKnoH6s3Qm2jAgzysPyc4eLek-Xi9aP
X-Proofpoint-ORIG-GUID: Xv4iXw5ob2hra7QTRDTMOp-T0f2h_LRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=871 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160151

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
index 9abbad07c751..3cf45a39acbe 100644
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


