Return-Path: <linux-aspeed+bounces-1976-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073D7CA0EE9
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 19:47:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3XhN6b9mz3cjT;
	Sat, 16 Aug 2025 05:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287268;
	cv=none; b=JRa7i89NthGB4OhFarm6sIYbzMw46CvrvU0yOxLurM+r8BUQ1Qmn21fpeAyRG548/C5AArZvCYmpk0oLaL/2MpQOYsEdyrOTwILoAy3qLmEILVVg8K2+++GBehe1Z5HeuxeWKxq5qFpggiUXJGX8+7L6A2Ts7Tg3yxObgW46jhjj8ks2WsGG7aYdB+qJWaXZh3qlGzqwi/pU7FHjNUIES19MmIW1Rs8W0ntvJDKnrJ4pGbY1/r0aURoalq5RtE4KfA1/aVkrMfcYb4CNeNkq3wZJex56pLIgH88zpOZLbYQS/x0TyzzVjvrb2I+olijDFXTHGq07EKEAiq6C394yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287268; c=relaxed/relaxed;
	bh=24aLO601S3vQo0KXg2ad5ryUEm61BcUK1KpsUl3bcAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxTQXFfTEEGDkjPlRYgQti0cbxPqbllc4DmnOfsf8h+yvix42SSCKs7irg+UPUlkmSvL4hlfGVpk9jde2mV+nZO1KYLpRf7d5CkDr4UzCJg6O7fhmCTNOAIsfViADCEjgzZkrFAIuVB4WoMGjfTEksD4DLYjjoFHbmBdCxTJ49AAlQMx/N1G4lvK0fITPNYkOFFw/Wj6JJAoNVPsqhNfdoIuLY+kgRQ8HKfFVOCGmWhxkcANhwhvajZJpnWtl8FlED0rfbeZL9hN7FOVZtQJ5//Z7YL7Jm5yRBKaP/g9nz/Ja22LPknbcGqv2iO/WmR20uiwEpEDd4ZE1FClqO3baQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=STCac5cf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=STCac5cf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3XhM59ZCz3cjX
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FFxlF6010174;
	Fri, 15 Aug 2025 19:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=24aLO601S3vQo0KXg2ad5ryUEm61BcUK1KpsUl3bc
	AA=; b=STCac5cfjJaXo9pUyL1cs4XseVGR2Q4LYYIBMbWY1ueREZJWGdvhsvD1K
	ET39RKZ9uRiIv40PhoswI78SExVQpOmCGkJa5o1/x2VKEtA3ZR0dcCGvYmiKxVvU
	FY13T3L5E3jUlZNnW6AnLb3Fovn1rZiENlJkvNVP8RdpMbgdeWetFeQrByPEzIt0
	LHNVt36o7tQ1qI7Uz/hsxn2KkDpgBNh3qKoW4unHmVpin0rOzkc6CTTkEM88VoBj
	7Q93XGpK0wkHj6iw0Mmsd4h11vFLxhJ9+9ozL5j1g8W3iG94REVx4Ta3GCVf3WaR
	mSqmq0vOepn/ha0d+NZy1j5twfOeg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwuds6ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FG3VLj026275;
	Fri, 15 Aug 2025 19:47:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21jm1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FJlcA115467058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:47:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F392658059;
	Fri, 15 Aug 2025 19:47:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCB8658058;
	Fri, 15 Aug 2025 19:47:37 +0000 (GMT)
Received: from slate16 (unknown [9.61.135.91])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 19:47:37 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v4 0/4] ARM: dts: aspeed: Add Balcones system
Date: Fri, 15 Aug 2025 14:47:26 -0500
Message-ID: <20250815194730.41695-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX1jkt0+Ht9Cft
 CMSdMaq62/Fo3++Fte+2JJDSmHzUSyhPBuKW01Rc0uYYdsb9sLB7RjYO0QCQAq3DODqJo/L98ib
 H2d91m11EMg5/1IPl0uKKHCfQ09bMvMxQtpkXGKoSynkxNspnL3kH+7+pXuKIEkml0m4Q5clXwO
 25UJB2AiNNdlpPa/qZbey8KerON9znMMfen9/VRMNsm0vkI++Hrde30CuUdpSqUA0+LwKPHZlyB
 bKUIcv+7g4uhxsmO28Rh+s0evrq4rH2piHOXOAMEGxH3X2fBGlhcqEXRAtTSeOvR+YXTgwDXnqK
 Bdzt6H9Y367RlpA/fpMuX/XrRediUQFqse7BLX4IZPjDuScPf1YsJ6Ba6wPEd5Gd35XGJD96MNC
 S2NVei6o
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689f8edb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=_exzTb3LTX8wHh0XIscA:9
X-Proofpoint-GUID: ZM-5wk4AYj1ce9wV14igQ4OR92zFYeIa
X-Proofpoint-ORIG-GUID: ZM-5wk4AYj1ce9wV14igQ4OR92zFYeIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

The Balcones system is similar to Bonnell but with a POWER11 processor.

Changes since v3:
 - Add max31785 to the max31790 document instead of to trivial-devices
 - Fix minor formatting in dps310 document

Changes since v2:
 - Fix a couple of incorrect i2c addresses
 - Document dps310 and max31785 properly
 - Drop the UCD binding documentation update, it's been fixed

Changes since v1:
 - Add all the ucd9000 driver supported compatible strings
 - Fix node ordering in Balcones device tree
 - Improve commit message to explain addition of ibm-power11-dual.dtsi

Eddie James (4):
  dt-bindings: arm: aspeed: add IBM Balcones board
  dt-bindings: iio: Add Infineon DPS310 sensor documentation
  dt-bindings: hwmon: Move max31785 compatibles to max31790 document
  ARM: dts: aspeed: Add Balcones system

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../devicetree/bindings/hwmon/max31785.txt    |  22 -
 .../bindings/hwmon/maxim,max31790.yaml        |   6 +-
 .../iio/pressure/infineon,dps310.yaml         |  44 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 10 files changed, 1442 insertions(+), 792 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

-- 
2.50.1


