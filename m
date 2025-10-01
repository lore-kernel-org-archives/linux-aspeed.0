Return-Path: <linux-aspeed+bounces-2370-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA71CCCD182
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 14:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccHlV1BG6z3cfj;
	Thu,  2 Oct 2025 00:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759329910;
	cv=none; b=FKJClK4CdHKySRZ2wB+MobfKLg3DyFjmx0QViuMJPJE7xzq0XzAw6Se09NK5q8OO84DN6uiru+jy80bX9yWYHV1MOWMDQM70YzmRPexmuYKvLxZ8YILSoXQS3Q/3E0cXaGSJbUTOC91TSlEFFZ+jW8aIcSGRWR91VmOZJgDSUdD4T1HmewB8nIjozmFP8abIsxKkiWHSKa9UE05d5MIcvOVfA2ioz7StkIKl93bfZPUI3pMumr1Ug3V5N3PKn9iMvgdPkYNI6WI92RC+5KbFHdCBzFMz4jXEOnPavXoeBP8l0pB4iXzYvlAlJmTSDhkey+/9+UcyHd8UVXYr8n1myw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759329910; c=relaxed/relaxed;
	bh=cKED4uPJ+TKBOyEa5CsEPNGDx3w/XuHzMmE8+Sv4n+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTHxFnxOC34yrfyTdxPO/pg/4ojoTELFxgPWkBPKqX5pTyHzZ4uaMTDvMv66g24tlZddC5n3yYISdA0Ir7Vu02amUGHbFPyW0PF4IdxPaSMrcO5bioB/qfF6LiSNFOUzlwMGXwuqa+daeUcGZ4E3gfRIPN55biyamuldVOX+/dIxjBm6NGelSeizEXwqP95lIk2vuwdIU1IZcrFyhw8Coo+xElKquHBswQhbaAOCuOGCJhOstbcMfh5Gb6js1AeDJVh0gZRXO/erEEvGervW4lAVXiPFGnIMMSO7kQYHorfd7K435kXPswoahT9mQxBbQs0uyTgNaw2FovW7R5dRSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c1XjaAQs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c1XjaAQs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccHlT21fyz3cfT
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 00:45:08 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918og7M006384;
	Wed, 1 Oct 2025 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cKED4uPJ+TKBOyEa5
	CsEPNGDx3w/XuHzMmE8+Sv4n+8=; b=c1XjaAQsvd45apDkDinZky+QmdPBBGP6N
	yDxVSU+yxFNaq89mQYSZTafeLQ4ugABxXxI6Y0+qq05eYHamyUXoBvWw6W8jmXjV
	+Skhe/MFvrDqVZVvM5m0EzpuQmZdPZyCACMBqi0NktOqiYv1anMvkV5B6viW6g0l
	eQ9Z9NjQkdq3udARC4VxLWxfxEegLCwnVcIVIGvY/h+aCxmyj7QzqFAPId5D9wCI
	rviB8rknXr3f67vHuWWBBnEtvVt4YsLwi9An2qIwedTq8Jp6d0wsSG6S4LxA9wJ9
	uelkju8OC4sWS0chEqzCMz0UPuzh+rVFRWRk+M5TmJXhfUVMAWUwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7g5h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591C0XUp003926;
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy1dh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591Ein9T27918994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1E258043;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B06125805E;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 3/7] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Wed,  1 Oct 2025 09:44:37 -0500
Message-ID: <20251001144441.310950-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: MnXhhf8F0LHLxM82cNCsf94UcxR5g3Ea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfXzeXJhmB0zPJe
 PryFPv6akgxDtQ56v9XHVzfpX/WNR5mBdoeWJSWhB40JU/G9+5OjgIv1pMa4cL4RwYbUWawyp2H
 1aXcBn6bvGMKI66BKs/CAC8Misj1XzL0+3of1OmsbEgeVh6vpAyETnzq4pfu3CZ3MvJUcBPXRzO
 RNJg+ZndbL00ZlYrGWgg4jTwsNsgBM5A8bzxrfOgR0HMq33NiOd0+6HConRiSHiLfKWl5DWW/Vt
 mBhvdCKDdnD1gNSYxfQcrmjilO5YPywiFgNCy2Cr4zduoKw8kRQ0/pspWnOR1B//punsCYbsrE6
 qaQs4PbRSdTlTWOcKZY7ZHU9SGaR6/mc8uleJnvVuv/89+Tj1vEaMDXQZpKaWSNv8G8P+NH0agZ
 7+55A73jG6Vicz+9XumbVn7aJJdhiA==
X-Proofpoint-GUID: MnXhhf8F0LHLxM82cNCsf94UcxR5g3Ea
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68dd3e63 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nPmG1HaLeDTRtUTItIQA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

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
index 0000000000000..7c0782e2a821b
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
index 7609acaa752d5..a72b7fabc7034 100644
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
index 0c8281ea4cc64..92b9854a0e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12191,6 +12191,7 @@ INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
-- 
2.51.0


