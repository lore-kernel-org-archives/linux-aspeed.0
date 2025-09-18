Return-Path: <linux-aspeed+bounces-2278-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9861CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnN1VjRz2xnr;
	Fri, 19 Sep 2025 04:04:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218664;
	cv=none; b=kmkAI6SgEou3LBwzqfItoprU/RHIUpm5aPvdXtpKApKuZdoW9RErFiD0PvzXAh7vEWEH04v+vUwKIqaa0i4+g7a0EeGpeVTuCUJsDqsSdMIpXFbJg6dcVCpoz41PIpWVsRl/zpyJLXLBgsWOFYauOkiwRj2avDX0uzM/6pYsqLIjTeRCwb6CBVuuxDutuFnug8G7KWVPtq4oE2+PO8Gs7E/nOHHJQluK994enIll65ywU0Avs5WpbPpKJUZ9qoL8nrqWr86ipTsNwuBpnkDpGSHNTEul4yhrXsXekwv6ow8u07KAvyrybgaR+Edx+xHKM325Nih+avODCLsh6A+Wkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218664; c=relaxed/relaxed;
	bh=cb2+xvNavcqXeO9RxuwMzm6yHui/7LQoZ3Dz4AcaNIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDpAqDk6jdoStK7K2yZQC38V1Bv/ZN+Qa1KjUY+15t9qrCebrCbkPlN4qe9w5aljg9j+gt1Y3mdcettGRXxh4V1WGTta4IIGIDwXq7F9OdsXp2sFyYunIIvr7ggP9dwyFy2t3UyLNS8/725hyDqyB9M8CdT+DObao/XW/OVDOvzaEKAWNCZjPw38sCaUR5XZSvzT69mI5DxjGqLuBdpQzsZdCMmr5dSiyhdvpB0ReMvCdVVk0lpEcGQZbhqW/kqhmhEaUuPuGepNzYW8pqHl1LtpWhkkrHrziu7RWiOmNPdazacyYZfcDD9kcFb5AfSiiLEf/3n+1a6nqFWP6nKf/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AAjfBPEn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AAjfBPEn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnL3j5Yz2yqR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:22 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEL1oY011501;
	Thu, 18 Sep 2025 18:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cb2+xvNavcqXeO9Rx
	uwMzm6yHui/7LQoZ3Dz4AcaNIc=; b=AAjfBPEnewRI1l0OGIdmsOcE0RY69t98D
	3zR8A13oz0xTHy/yqGMUHGGYxs9xwfoK3Y36I1KjX8lYs0JC1g1sUeMO4L8Eq4cJ
	xS/EsqyCqqq+3EMlFLFf85wzBwjLtDK5+JzjMYf4ZuIhikhJ+ROEK+pqw1F/cUyf
	5MdAKqFimpAS3p54lVsNjajjvYGmoebu0rhedCGHlXRtpUwnXfpdtO4N+3leQl08
	MWnsxDTDFXGQLLiwRQ8dpxr3hkLNlkKfikXy80kI78/3JG2bO0SL18H9QbYii0pd
	SrtlhKTuXXFSRh/oKeKOT+BT7UbDfvl/W52IQdglPEZAFTPdlz65A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jc1qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFA93j009382;
	Thu, 18 Sep 2025 18:04:13 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3qrag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4CQ119661474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C2758068;
	Thu, 18 Sep 2025 18:04:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DED7D58063;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 7/7] ARM: dts: aspeed: Fix max31785 fan node naming
Date: Thu, 18 Sep 2025 13:04:02 -0500
Message-ID: <20250918180402.199373-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918180402.199373-1-eajames@linux.ibm.com>
References: <20250918180402.199373-1-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cc499f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=u3jscfC60MhvLZHegIcA:9
X-Proofpoint-ORIG-GUID: BJINxADZ-jmk3YdlgEmMUm1w5moFaovy
X-Proofpoint-GUID: BJINxADZ-jmk3YdlgEmMUm1w5moFaovy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXwcYzEoYmJfHO
 yeu49He4YhH8VvVYjDVrF6Dknnmk+D+PtjK/mN3aDGg+fz3uXYqMkGOB7azIe/WubCeCtU1zLLU
 ErVY8bQf+vkAppzkvh+4HkamaMlJHBdJBNBZ8GYrB1ggPoy/JpQyyGpAylqJ0V/TL0W7QZoEYjH
 bQpl3qk4nKsEn0tQ6wAWiG8PIb4wSMyTcsU2RghYLInuLSWL+WSpq1XrOoPNUM7qo0n0IQ+Z5Vj
 hgxyFv4DxBItUB05/+j8sLGX7JThTayfo2b1RAT8Yf3Dv+EJe7tNTTqUjkeVEqS86D5mPf3P6LT
 xwbMVMavf+YDe1rmgU+jPZkjab03ig2cG+HkYcTeaUSCGGu/M7BwiPMYl0F3OQGKg3H7w+zNPKm
 iDIYNgAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Now that the max31785 is properly documented, fix up the uses of
it in the Aspeed dts.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |  4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |  8 ++++----
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts | 12 ++++++------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts  |  8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
index 2f5d4075a64ad..c2a4153bdcf49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
@@ -276,13 +276,13 @@ max31785@52 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		fan0: fan@0 {
+		fan0: fan-0 {
 			compatible = "pmbus-fan";
 			reg = <0>;
 			tach-pulses = <2>;
 		};
 
-		fan1: fan@1 {
+		fan1: fan-1 {
 			compatible = "pmbus-fan";
 			reg = <1>;
 			tach-pulses = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 9f144f527f03b..2f42482d98df2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2065,25 +2065,25 @@ max31785@52 {
 				#size-cells = <0>;
 				reg = <0x52>;
 
-				fan@0 {
+				fan-0 {
 					compatible = "pmbus-fan";
 					reg = <0>;
 					tach-pulses = <2>;
 				};
 
-				fan@1 {
+				fan-1 {
 					compatible = "pmbus-fan";
 					reg = <1>;
 					tach-pulses = <2>;
 				};
 
-				fan@2 {
+				fan-2 {
 					compatible = "pmbus-fan";
 					reg = <2>;
 					tach-pulses = <2>;
 				};
 
-				fan@3 {
+				fan-3 {
 					compatible = "pmbus-fan";
 					reg = <3>;
 					tach-pulses = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index c5fb5d410001b..bbe26f950821e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1079,37 +1079,37 @@ max: max31785@52 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		fan0: fan@0 {
+		fan0: fan-0 {
 			compatible = "pmbus-fan";
 			reg = <0>;
 			tach-pulses = <2>;
 		};
 
-		fan1: fan@1 {
+		fan1: fan-1 {
 			compatible = "pmbus-fan";
 			reg = <1>;
 			tach-pulses = <2>;
 		};
 
-		fan2: fan@2 {
+		fan2: fan-2 {
 			compatible = "pmbus-fan";
 			reg = <2>;
 			tach-pulses = <2>;
 		};
 
-		fan3: fan@3 {
+		fan3: fan-3 {
 			compatible = "pmbus-fan";
 			reg = <3>;
 			tach-pulses = <2>;
 		};
 
-		fan4: fan@4 {
+		fan4: fan-4 {
 			compatible = "pmbus-fan";
 			reg = <4>;
 			tach-pulses = <2>;
 		};
 
-		fan5: fan@5 {
+		fan5: fan-5 {
 			compatible = "pmbus-fan";
 			reg = <5>;
 			tach-pulses = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index b31eb8e58c6b4..91d514567cba5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -480,7 +480,7 @@ max31785@52 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		fan@0 {
+		fan-0 {
 			compatible = "pmbus-fan";
 			reg = <0>;
 			tach-pulses = <2>;
@@ -493,7 +493,7 @@ fan@0 {
 			maxim,fan-fault-pin-mon;
 		};
 
-		fan@1 {
+		fan-1 {
 			compatible = "pmbus-fan";
 			reg = <1>;
 			tach-pulses = <2>;
@@ -506,7 +506,7 @@ fan@1 {
 			maxim,fan-fault-pin-mon;
 		};
 
-		fan@2 {
+		fan-2 {
 			compatible = "pmbus-fan";
 			reg = <2>;
 			tach-pulses = <2>;
@@ -519,7 +519,7 @@ fan@2 {
 			maxim,fan-fault-pin-mon;
 		};
 
-		fan@3 {
+		fan-3 {
 			compatible = "pmbus-fan";
 			reg = <3>;
 			tach-pulses = <2>;
-- 
2.51.0


