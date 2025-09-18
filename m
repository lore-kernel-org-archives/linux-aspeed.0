Return-Path: <linux-aspeed+bounces-2274-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CFBCAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnL1Hvwz2yMw;
	Fri, 19 Sep 2025 04:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218662;
	cv=none; b=SbnKp6AXX12shi/Rb+x8PbFYlv9WK8vd/WPdH96XewQbh9L4baGPaKtMZBhZ8O+AEYFTKbGkbMSpHh4D4ceVL/MNf3qG5dDKVNbgzfUfmtmbySiqrWF7Wh8S6JkLjC08sq7nG0H9j+9CLtPtG1vn/8Z5vQtXdNFpks6B71wWJwbjZnMHtfoHEjFpYwYE4jeIxlcGk2tHgdaHXXRTZSCNJIFgd/m43ctDNkJtJ/yzpSNiEWeJj6S0xyhtUaxPNsNa5uVFNNhlzHk4TPxSrEPcaNxpMnkHc/Butfj6lNiuYB1lgoNX8I4rtsi4Ton3KaQk+/JNGjy0/EqfZ+0hKZP39g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218662; c=relaxed/relaxed;
	bh=dxA6/c8hafsPZw566V/Nuvy0x6ch0JN3sXIN7B9j07s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHBJN74wmucnVZyETBQdTTkeiBzlF5LSVzt9PjF+EY5RQAA71Qgn2KVpGBgwzASacmvcT0s81ScImABCVA7X3ZVJxnN6rlJsQ6gwad/DFu8jV6Iz5LLptFhEW7YfOUsyZobC/t+Iu7VGFAJBAvYsSJjrfgiYosNM7E7jnpkm2iUIdbHK+cgOM4mVjjaXygdwTd8VlOD+ncLYysOYxULWURk4FD+aaUAj0fl5WTYg/E00ad0XPe3lsKsqUGbgUBK3jl3uGrQiuTjmHQaZkcU6dxh50gGgPZs4r6TOfbScu/CON5uar9knduv3Jq1Kh13ukzP9uAC0LQZaNVh/511IGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cbTMG83O; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cbTMG83O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnK06tWz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:20 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDLQbU011417;
	Thu, 18 Sep 2025 18:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dxA6/c8hafsPZw566V/Nuvy0x6ch0JN3sXIN7B9j0
	7s=; b=cbTMG83Ozyl9vRYpAbkqUH/CuMb5yFMO2MR1uboQQvC3oLIBuMpYJiOH8
	TST0IpESlHUwckcXx7HpJ+9RyZUL5NIjca6WR86unbS8Q7TOFJJ6gkDUWDo9gRzY
	vGF0nmhNpmddA2eOGBFQky2JhqpQIEEOjneacSL9O6KwSs9bqnFsIEUEGnbS19ML
	ukF+HjOhGuCY/Giaa/scn/161Wckta8Bki9cHKCMSefv6aHyKtF1B2hQ7NulkvQs
	i5z16fBBnA4C+/MuepAi3m9cwoPhi97GCAdQ8RZDBnuljMe35XEn3085h2OtvG0h
	NNqOUqZ8ccLKC+VN6v5zDCTaOSEjg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nkhpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGg6Es022328;
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxq047b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4A1C66650486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904EC5803F;
	Thu, 18 Sep 2025 18:04:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69BA558063;
	Thu, 18 Sep 2025 18:04:10 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:10 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 0/7] ARM: dts: aspeed: Add Balcones system
Date: Thu, 18 Sep 2025 13:03:55 -0500
Message-ID: <20250918180402.199373-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cc499c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=Hy7NEVtaT5kuqzZ1rwQA:9
X-Proofpoint-GUID: ledzNp0aPZ5P7wxnLV0nj5oMky5NKPPE
X-Proofpoint-ORIG-GUID: ledzNp0aPZ5P7wxnLV0nj5oMky5NKPPE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXzcLury+xJ7F1
 ZMSgGCyNbJB4fVeaaXvcoPKiANtwGV5RLAxoevtRcCPj/rSigbo8FHJJZsLQOilY7x7cYFuCG4X
 WkD8L/Dzg2haYYXDAdUFxr/SfnLtIRSaOGSbo00tMRdqPs8x1aJ7064jSqEZTkJDJQc/4+Dz3+Q
 ukeWGvUBnmrk4Gp1Vs16S+Ki7LXvNbYMC9cwAfhYtmLSWeVVIxLYpUlQV4Yu+2w1nBfsoTSuVKM
 LGTzw/f+naifBsZeijg+FGo4FhpLZCuDnTI7a+xLHTZokglBdGpWuF7fkHypX4e7UpeZk0KXHJN
 tcZv9CUhTFSW2FITBuvmRgxUaPHso7k9ynsuPRAW8vtAsBt2oP+rtO6+7jbHIBNQW9sYL7Kmwvu
 1WXA/WKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

The Balcones system is similar to Bonnell but with a POWER11 processor.

Changes since v5:
 - Add patch to add address and size cells to max31790 document
 - Don't remove address and size cells in max31785 fixes change

Changes since v4:
 - Add patch to fix max31785 warnings
 - Add patch to fix missing Bonnell documentation

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

Eddie James (7):
  dt-bindings: arm: aspeed: add IBM Balcones board
  dt-bindings: arm: aspeed: add IBM Bonnell board
  dt-bindings: iio: Add Infineon DPS310 sensor documentation
  dt-bindings: hwmon: Move max31785 compatibles to max31790 document
  dt-bindings: hwmon: max31790: Document address and size cells
  ARM: dts: aspeed: Add Balcones system
  ARM: dts: aspeed: Fix max31785 fan node naming

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 .../devicetree/bindings/hwmon/max31785.txt    |  22 -
 .../bindings/hwmon/maxim,max31790.yaml        |  12 +-
 .../iio/pressure/infineon,dps310.yaml         |  44 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
 .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |   4 +-
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |   8 +-
 .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  12 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |   8 +-
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 14 files changed, 1465 insertions(+), 808 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

-- 
2.51.0


