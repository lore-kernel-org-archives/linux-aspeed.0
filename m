Return-Path: <linux-aspeed+bounces-2318-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2566CAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 17:58:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVrSd1CKlz307q;
	Tue, 23 Sep 2025 03:58:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758563905;
	cv=none; b=Au7DgasRPwq8CvsWbTYQvLxAZOU9BhkvBE0cDaEqjhhButyN5xSmDJe3TQIJEXbRJe/8yRI5do9tlRtd1DOHJ0pQ4Ywi2adOsXb+x5xOHLkeR96evuzMq1dXIwWz5bItSP3+fc1ZyY0ks5HeUJE4wQw00CEOzKhdDHMd2QzbzXXvv4QghhPyqRVaBGeN1T3lMrQt/MBEUymmzfjnf/hRGRIZkmePnWrfet7Jpv4TMBDbLIPJJ5WG4xxEqpzQguMm8aRRVdi+AOhoAINhQG33wIgmGbLQgyaWJd1voK2H+IRDHTEAIExE0o3lVDUku22vd3gBk31sMUa7+wCTI2oKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758563905; c=relaxed/relaxed;
	bh=xU/mKPOxpYgMlnUyj4Zgu1OyckkeAGsJNFbd59wLYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5eviNRx0ijADwgiaD05D2+ny/QVjvoNk+ZNnX/BICtWrhTqfxS6aWX0IwiJMbctLkIHfX9+A9TTKTXPO+oaYVUvDSpeCerN/+5IB6gVbrZ+X0IjhM3b04ZTE/WRY32rGYMTeHWaokpNnYDE9LS1cZjLdBN1SxZyZFH9yXJTjnFzqZspamLAu72T2xdxILI80UbBH7keN2/cZ0Ff4yWceJ3MevKkk6v1Yx0qC/RV4N1H5kGAKNVsw6Ip4um9o4MebDdCy01CrP5YFZ3ABdprZkSxe1XDd1LjHEWwLQR7R93SamHtDwSlwpUxkxubgkN1Brz99QH8jtdFj0pgd9Ax7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fZcWxKHh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fZcWxKHh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVrSc4B5Lz2xPw
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 03:58:24 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MC8cTl007713;
	Mon, 22 Sep 2025 17:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xU/mKPOxpYgMlnUyj
	4Zgu1OyckkeAGsJNFbd59wLYNk=; b=fZcWxKHhBEp3NJstiDoH9/786F5Vqd1T5
	nBJDTnoKQoWJHZhGkYVCv6GCHJkf7CWkG+AEP7MAVimIYfChmwyqFPJCN73WTtU0
	ZU167ozEPVUmltHeMEbZ1PZr880A+go7w0gJgiQrohwbfSJEI7ZE6Qo7gjDaYb7E
	TFxXsH56ImIeclJOxWEUTfQqJUvbkEzgl3gPxlHbtp3eGpFD9ZeVmoAvEHixf9Ds
	Pi9MXoUD6VjGqt3WMhlJloNkj6rfJEaLv3YHuDQ7i4j41inofv8g9/MquNGwB2aT
	wDAo9KGEItl11YRw8SzmJPuXs35a25G5Qfq+RqAhP45S5Tq0OIGBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jcbhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGJ5E4031186;
	Mon, 22 Sep 2025 17:58:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vd0ct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:58:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MHwFA0000606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 17:58:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EED895805C;
	Mon, 22 Sep 2025 17:58:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 853B95805B;
	Mon, 22 Sep 2025 17:58:14 +0000 (GMT)
Received: from slate16 (unknown [9.61.160.40])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 17:58:14 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 7/7] ARM: dts: aspeed: Fix max31785 fan properties
Date: Mon, 22 Sep 2025 12:58:04 -0500
Message-ID: <20250922175804.31679-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922175804.31679-1-eajames@linux.ibm.com>
References: <20250922175804.31679-1-eajames@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX7hLyNxjIhAO9
 Q4LZepAj2opFP1O+vnvaH+2HZYsJhCA58MGOOVlSa4GQwxu6ORHP/m1XzxncumI7X9cVnWpQWO1
 1OCRROmK5yhkM8LnSiCPi8ra/TH/dQsD4O1BuQpnvUrsOsuT/DTkrJKU1LAMRhE1L3WQEmAR3rF
 Sx2w+hA3jYWOIVha8jUCGFoyGxUXgkf1PBX0nwDUwLFrEepllx/iI1OpsBl6enKtqVWgyJuiF2E
 0tYfVdi3k+bfj5nJMQV09OdYlAPOlETHKIis/pdVlnKh7KP7ZEY14w7wKLJdQ5jIXM5sQo6gymS
 KejSz2c02ZxfeAgGZpeMkUe/ypGJlKODjszMK+v4WAl8AJ6wN3E+Nukkw4IwOHcZ1H3k3M4zpC1
 aG+qFFdD
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d18e38 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Kt26cSGSbpyySZw-S6oA:9
X-Proofpoint-ORIG-GUID: Cq8NlIEzR2i7S4J4ZlyD3uRzsdXLIP1a
X-Proofpoint-GUID: Cq8NlIEzR2i7S4J4ZlyD3uRzsdXLIP1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

Remove non-existant fan properties from max31785 nodes.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  4 ---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  8 -----
 .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     | 12 -------
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts | 36 -------------------
 4 files changed, 60 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
index 2f5d4075a64ad..a37399ff3cea2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
@@ -277,15 +277,11 @@ max31785@52 {
 		#size-cells = <0>;
 
 		fan0: fan@0 {
-			compatible = "pmbus-fan";
 			reg = <0>;
-			tach-pulses = <2>;
 		};
 
 		fan1: fan@1 {
-			compatible = "pmbus-fan";
 			reg = <1>;
-			tach-pulses = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 9f144f527f03b..5a0975d52492c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2066,27 +2066,19 @@ max31785@52 {
 				reg = <0x52>;
 
 				fan@0 {
-					compatible = "pmbus-fan";
 					reg = <0>;
-					tach-pulses = <2>;
 				};
 
 				fan@1 {
-					compatible = "pmbus-fan";
 					reg = <1>;
-					tach-pulses = <2>;
 				};
 
 				fan@2 {
-					compatible = "pmbus-fan";
 					reg = <2>;
-					tach-pulses = <2>;
 				};
 
 				fan@3 {
-					compatible = "pmbus-fan";
 					reg = <3>;
-					tach-pulses = <2>;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index c5fb5d410001b..e90421bf7e3af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1080,39 +1080,27 @@ max: max31785@52 {
 		#size-cells = <0>;
 
 		fan0: fan@0 {
-			compatible = "pmbus-fan";
 			reg = <0>;
-			tach-pulses = <2>;
 		};
 
 		fan1: fan@1 {
-			compatible = "pmbus-fan";
 			reg = <1>;
-			tach-pulses = <2>;
 		};
 
 		fan2: fan@2 {
-			compatible = "pmbus-fan";
 			reg = <2>;
-			tach-pulses = <2>;
 		};
 
 		fan3: fan@3 {
-			compatible = "pmbus-fan";
 			reg = <3>;
-			tach-pulses = <2>;
 		};
 
 		fan4: fan@4 {
-			compatible = "pmbus-fan";
 			reg = <4>;
-			tach-pulses = <2>;
 		};
 
 		fan5: fan@5 {
-			compatible = "pmbus-fan";
 			reg = <5>;
-			tach-pulses = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index b31eb8e58c6b4..6fe7023599e88 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -481,55 +481,19 @@ max31785@52 {
 		#size-cells = <0>;
 
 		fan@0 {
-			compatible = "pmbus-fan";
 			reg = <0>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 
 		fan@1 {
-			compatible = "pmbus-fan";
 			reg = <1>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 
 		fan@2 {
-			compatible = "pmbus-fan";
 			reg = <2>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 
 		fan@3 {
-			compatible = "pmbus-fan";
 			reg = <3>;
-			tach-pulses = <2>;
-			maxim,fan-rotor-input = "tach";
-			maxim,fan-pwm-freq = <25000>;
-			maxim,fan-dual-tach;
-			maxim,fan-no-watchdog;
-			maxim,fan-no-fault-ramp;
-			maxim,fan-ramp = <2>;
-			maxim,fan-fault-pin-mon;
 		};
 	};
 
-- 
2.51.0


