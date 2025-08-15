Return-Path: <linux-aspeed+bounces-1975-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8438BCA0ED1
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 19:47:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3XhN5Ks4z3cj9;
	Sat, 16 Aug 2025 05:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287268;
	cv=none; b=lTVsGGMVoYry2sLN00MXfyqVBuHcgVeqT+YwCeTbTC1HTmz663DX/ZE5LZXnFALL8ut80+trj8o7/zIJhjfFkFgOhEtu9x/Q7kxU+ycEaAFKgd+6j9xF82I1GEYPy1rjd65TOFeeZq2k+kxfR6me2s6uXjZKyDgbuE2VhKB8MZR8r1dxt2Prftt3JyyRtaIY4l7FrbumPCCi66cfEM3GPvLaeVgyeiIyr4U0cwaM9bN6HBj6/6w98PzTRE34YdHmKJhWrL28vJJrre2nWoevWkJZSFlyS3TkL9VYg0fUMP8KKhr5xkHpaGd8Yiie6SJ1fDIt9sBWTdNvBobnQVXwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287268; c=relaxed/relaxed;
	bh=3l+zqNR8KdPaXrOHqJNsFYtPlTjunMeqNdwfJL0FNM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCQxLlIxewpePnLrwLaE4Gg2RBgl0YxqVsIi6bqW6uN60lwiH4IuaBkAy+yBk1BmhDEDHFavLtxDYF818WFyYHGm10pGep5tEVvFQyEAam+SxVmwpmd+ip+rS4nsyXSz6to2bF/PdaXnKb+yMm8cIZM8TOg7uIBfW2oyIEHtHQH0PcjkR2rHTD8NY6dSKP8PdPgQqnCMQ/RLLQRwXlR2lwBHWF4sac92hAReCfBNpIjVyOgIl43f4z22P95EcS0yqYMyRn5urmOREF/w+wZ2KYfKZCw2sKMKlT0A44EfKsj8oVXTIF7y6aHIgKRLCU5tEYprLEdUVG31D4tStnTUAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OrdUvv9w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OrdUvv9w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3XhM52Nsz3cjT
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:47 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FFpXfC022341;
	Fri, 15 Aug 2025 19:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3l+zqNR8KdPaXrOHq
	JNsFYtPlTjunMeqNdwfJL0FNM0=; b=OrdUvv9wqXuKuIJWAo0qzrh2bsijG5xEE
	P2GaNJ5k6qImqePmijSinUr7waGMj1nxjqCJiRCUjHgFMjChyDYefwi7CdfwQb6h
	BT6RO5LN5pQQA3dvKcpfdFFX+MDyhUjV9sdnsfqR3LeucISXrA40PegCa9yR7ibA
	bgDpRVqtQamVSOoMnB8PDkqW/z2Ei9zQL2JtJFHy9+8IB8HPb0MzPZf3aJ2aOUSA
	M1/mX1DQ9DRQmBHqfyV4VWzgSrTc9bCP6ybG5jj609hRKDrrqilMj60PBlicWVgz
	oOdu1rssKCwcbVS89ZeCdapkyXN7vvN3v74v2muowjI1Aq98sGNuQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx15130k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FJStiG026377;
	Fri, 15 Aug 2025 19:47:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21jm1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 19:47:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FJlcR015598238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:47:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616DC58063;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC6E58061;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
Received: from slate16 (unknown [9.61.135.91])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 19:47:38 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v4 2/4] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Fri, 15 Aug 2025 14:47:28 -0500
Message-ID: <20250815194730.41695-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194730.41695-1-eajames@linux.ibm.com>
References: <20250815194730.41695-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Qtue_d5owKKj8iLaASZr_2kUqN01FqTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX7JWGw30Hu7hV
 gxaKhn5bNyolawdymRpRg/sVeUHlaBRIN7tqkujahr85SGGnoLFwW3Zc6Jj0eGR/n6/49431v8t
 uM9Jfl4pK03ZFNsifKJ5q03y1uRt74kpnphXG/J7nOSnXl/CoP3BLBMrMOFN5EuxJdroRorJn89
 3nK7+C43srKX22D6vNcVIK4QWDRnbA2nL+lQtg7uLgGLGF7h8IMNDNsxEQDqpD1QVOiSsDBtPT7
 /1dTk15lLQNC8ku25ilA5pH0ZcZOKjEZFJyuKOUugGJ/y5q3w0pHAgPNw79Z4Elape0ZX9LBb2P
 5TDn20hxKgYNqNzrKTvn4sxH+Ajgj5kHBdhMsQi5Z3CP5HO74k7cK694f9JjK9VsiGmiRCzEk4T
 MTbki9sh
X-Proofpoint-GUID: Qtue_d5owKKj8iLaASZr_2kUqN01FqTn
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689f8edc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nPmG1HaLeDTRtUTItIQA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

The DPS310 is a barometric pressure and temperature sensor with
an I2C interface. Remove it from trivial-devices.yaml and add its
own documentation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 MAINTAINERS                                   |  1 +
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
new file mode 100644
index 000000000000..7c0782e2a821
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon DPS310 barometric pressure and temperature sensor
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The DPS310 is a barometric pressure and temperature sensor with an I2C
+  interface.
+
+properties:
+  compatible:
+    enum:
+      - infineon,dps310
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure-sensor@76 {
+          compatible = "infineon,dps310";
+          reg = <0x76>;
+          #io-channel-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..3f2c5b815d0d 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -127,8 +127,6 @@ properties:
           - ibm,cffps2
             # IBM On-Chip Controller hwmon device
           - ibm,p8-occ-hwmon
-            # Infineon barometric pressure and temperature sensor
-          - infineon,dps310
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
             # Infineon IRPS5401 Voltage Regulator (PMIC)
diff --git a/MAINTAINERS b/MAINTAINERS
index 5eeeef7bf255..538fab167141 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12033,6 +12033,7 @@ INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
-- 
2.50.1


