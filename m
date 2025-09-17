Return-Path: <linux-aspeed+bounces-2253-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C819CAC59D
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 14:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRhLy43thz2yPd;
	Thu, 18 Sep 2025 00:42:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758120154;
	cv=none; b=aFYW0Kq4QoiTf/dzolEgFPlSucWx49ukWhNEY3gE88/VPxyFIrxoWkygvM2xdgsngUP7G3ypq71F5W5nADoPFmwfFWVtJ9moVyIwjFK9DqtJjCxMRgdI73bKhx0tGBLEn2sMJItgmmOLAc+2ktER3N+wjdMi6jWYv3/YNJ7nHteXd7MHkz+V1fu6diiioqlKHbgYIIBotYzqKsZjBVC1k9Yxnjj0ixq+p66qt2EFuxJ5/se6g8XTUT2JYzEUoNoR6W8bYlllH20UpyHNOH5+CiJd6rU8amu4Gd8yHx5TZLM0SSpPwRbySa2wlNh/ttJgedSIp3u5GGUoKiIBgsMgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758120154; c=relaxed/relaxed;
	bh=2AD27kb5haOmAxU9zWX1KW7fT8y6pGthn8ll6T0se5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJQGFdIKpEtP3xu762NAHn04yXFlptad7Eoha4mATuoTLPBD9V578lo57UOygoxv5wiTj70n8gxf/Wp/F8ETi2Z4GsH/j+xSK5PnVacPDd7VGRQK3rNNaRfiH/33+mY7OfDNOwj9K9aL9pXrkz7sAwCZvqT7JrPMFT+7UFoBNg/SZL4D3PwXTzQeIWm21k1URQhS9HcgfkRH5axbhx1QGRlGsjiHqwZ1TCB7ljUnoaUzwnj9UZ497zrsrDgLHYcZbnAuwI56LMjM17XcaGIBY4NbY3DLoPhnVsswkuiRD1d4775fGsyDTN2XnNW1rq4CX684DHmG0DS9dP8tTGbUDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PnaiyZ4F; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PnaiyZ4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRhLx4zljz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 00:42:33 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H9iVTE011459;
	Wed, 17 Sep 2025 14:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2AD27kb5haOmAxU9z
	WX1KW7fT8y6pGthn8ll6T0se5w=; b=PnaiyZ4FJ4sQiTK4SFfqqjNzEq1EZa6Eb
	Yi+1iq3nTKOC3d0vOD2g9C2GmkJDL4MnYBA48LK+5YyoxJ1PMiSsmMUOMhxCLw1j
	Aa902EU5beMVPuNntU2N4MBCaeLqpeWoyA1uvSa/w4TnXt2DI3+mZu5KDpz+jYA2
	3C56akKuhbkWP/8SnQTw2h0r0zkf2JcFTXN5mo0m2C3AGEe+qS94Snvh4y9X56mZ
	xLOVEaAxzeJKuef2/7cvuQIKeV3o1lzbVfeXEPz20HilhQ3p1qhtSasuI+8D9fT/
	GJv2o0zV2yvTi44Dhnrgdk7vcH+9i1LfI5Sa8rUmWltFaN9krZvlQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j4ckp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HE6v26022328;
	Wed, 17 Sep 2025 14:42:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpsrs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HEgPVZ30474824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 14:42:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2577F58043;
	Wed, 17 Sep 2025 14:42:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6462A5805D;
	Wed, 17 Sep 2025 14:42:24 +0000 (GMT)
Received: from slate16 (unknown [9.61.98.41])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 14:42:24 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v5 6/6] ARM: dts: aspeed: Fix max31785 fan node naming
Date: Wed, 17 Sep 2025 09:42:10 -0500
Message-ID: <20250917144210.160051-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917144210.160051-1-eajames@linux.ibm.com>
References: <20250917144210.160051-1-eajames@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cac8d3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Sq8nXUOxSZhkBh-L9C0A:9
X-Proofpoint-ORIG-GUID: xehVstPslCnna2RlRnRQcFNP_5N5uOHB
X-Proofpoint-GUID: xehVstPslCnna2RlRnRQcFNP_5N5uOHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX7NK+7wxOAzck
 1YBpZRgUEoh6axQvaramYYWoQdPxlMMeti8rD1rX++A8sNTG9SNdE30Rq1KiGE+pXaVXUypDveu
 yBDb9bnUDWEKtxWI1pGivy1RjR8YO1gaMNCbjqNtQzldUNwmYtYWHAh9uUOzHLQSSBJ7whBPX9q
 C776jXM0+cCOoURrvLgU5VQ8ee777RW9SxTwOkwYhR9r7SRTIBojCWTNUxtqG2J3bzaSLz0oUdg
 ZEK0E23URvnazDjxcAlNRlzkcjzkMIeVa9ATPNOezGp7ZdAG4egShRORJRPvMibKs5Xkj0SriP4
 hPSU9Tolk9F51zwYpkLa5VEYlqP2ZndbUgtdm2VveOd5jzfTSESWKdT3bRwyb8IJKtHV19rY5Hd
 gLtDKGOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Now that the max31785 is properly documented, fix up the uses of
it in the Aspeed dts.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |  6 ++----
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 10 ++++------
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   |  2 --
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts | 14 ++++++--------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts | 10 ++++------
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  2 --
 6 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
index 2f5d4075a64ad..36e6bbfdeb30a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
@@ -273,16 +273,14 @@ eeprom@51 {
 	max31785@52 {
 		compatible = "maxim,max31785a";
 		reg = <0x52>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
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
index 9f144f527f03b..db20a3b740836 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2061,29 +2061,27 @@ i2c14mux0chn3: i2c@3 {
 
 			max31785@52 {
 				compatible = "maxim,max31785a";
-				#address-cells = <1>;
-				#size-cells = <0>;
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
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
index 9a43fc7bcebe9..e312bfc2c5bda 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
@@ -2053,8 +2053,6 @@ i2c14mux0chn3: i2c@3 {
 			pwm@52 {
 				compatible = "maxim,max31785a";
 				reg = <0x52>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			led-controller@60 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index c5fb5d410001b..8a5f4131787f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1076,40 +1076,38 @@ tmp275@48 {
 	max: max31785@52 {
 		compatible = "maxim,max31785a";
 		reg = <0x52>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
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
index b31eb8e58c6b4..bc83605bdf497 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -477,10 +477,8 @@ bmp: bmp280@77 {
 	max31785@52 {
 		compatible = "maxim,max31785a";
 		reg = <0x52>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		fan@0 {
+		fan-0 {
 			compatible = "pmbus-fan";
 			reg = <0>;
 			tach-pulses = <2>;
@@ -493,7 +491,7 @@ fan@0 {
 			maxim,fan-fault-pin-mon;
 		};
 
-		fan@1 {
+		fan-1 {
 			compatible = "pmbus-fan";
 			reg = <1>;
 			tach-pulses = <2>;
@@ -506,7 +504,7 @@ fan@1 {
 			maxim,fan-fault-pin-mon;
 		};
 
-		fan@2 {
+		fan-2 {
 			compatible = "pmbus-fan";
 			reg = <2>;
 			tach-pulses = <2>;
@@ -519,7 +517,7 @@ fan@2 {
 			maxim,fan-fault-pin-mon;
 		};
 
-		fan@3 {
+		fan-3 {
 			compatible = "pmbus-fan";
 			reg = <3>;
 			tach-pulses = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index 89907b628b655..f26df3c8cc261 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -360,8 +360,6 @@ bmp: bmp280@77 {
 	max31785@52 {
 		compatible = "maxim,max31785a";
 		reg = <0x52>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	dps: dps310@76 {
-- 
2.51.0


