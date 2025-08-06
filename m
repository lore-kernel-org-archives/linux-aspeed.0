Return-Path: <linux-aspeed+bounces-1917-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEC4CA0EC0
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 18:47:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxzmx3hTFz3bqP;
	Thu,  7 Aug 2025 04:47:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754506049;
	cv=none; b=d1X2Izyn0KbmyaFrsMc8UAmukT5fmAo/V9g/4kEDCOhkZ2ohx3KNNNxunMSDNn461nCZ4yr6b23V3rkBoL56xEwhAW8pE7/OR0lwLkkTFm7AcjsMgxuMbwWErPp9rgUkLLVwKSVXpDuCCIJ8P9IJQcvFqrkxjza9magTu5KZ/vqDXVey3aviffRgYYgniSfIcbLF44seAHDRU2nRaW+FDVOKqr13VVCmgaawqZsc4QZAVMfvg9BHc6Y205P7LMAIRXiOtcx9nSCiFlh6wabgsmBovilXtVkiyrvM30tsdNpGU4RrMgURSpwqBCHkn+LESCSDd70aPKMd1VTDBD+wuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754506049; c=relaxed/relaxed;
	bh=aq03Oign6ozBRQLAEAlVAgEzlc9zoUaGxhZQewpsOdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaQHCPU40o8rPDpsmpMxFKKrxzVwigPU7mR+15yfEsX4NjJ17nT0AzImBOUNOC4tZppFYIOPZ4sPXRrgXwwcT3w20xCmfLUoGN8lG2oQPtb2GGwPcqCXofpUjV9KcGr26xTUGwlEaHo6+qSdmKoFMgydc9ubOLMrg7R+pClXT5xt8WBHM7/bTw/aA2WbuhF2+GAxacKky1fYsEgscgyIkV/hYj10vj9GILX0vvHJ+MuJOS492LwVa7J82Pib47/qqGPzopXN+Mwawr2UibUgjkMBlQ312q1vkvYVGekb9G6iYgxTrJgaRq13907q9jYb9rb1J+FjiBb/dWYkwehu0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fFSEPKie; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fFSEPKie;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxzmw2CSPz3bpS
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 04:47:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576HeT4k028225;
	Wed, 6 Aug 2025 18:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aq03Oign6ozBRQLAE
	AlVAgEzlc9zoUaGxhZQewpsOdo=; b=fFSEPKielHNVUlO9LKQN4ytcx0bewFY81
	tlhljgn1rF2woj3H9AEDotcEGFZwdGIYPHyZJmdg4M/peDcDLnFBwfiHAH8V7+9Z
	RhSJI41C9YIeBI514RrqauJQZqHhx+qLuJxQ/3untXfHYK469Vx6D1tsqU82/VEc
	jTedKZZch/hN8JDENh5kUlunv3TQOASWmoALnKQq1FrxnaRfojoQoEqx/hiEeUgY
	0DyCPNZESOSKpYZVutVkGRhvTLrZROsxN+Nj+5rK9V+WvOHvLUbvw4nPJAbDbgfN
	N1RpIpGInkEbYA0l2aadd4jLSsu7UQfRBz2oEGbyhry31GpzoeSWg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60x221-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 18:47:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576GAxO5022628;
	Wed, 6 Aug 2025 18:47:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqd182-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 18:47:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576IlCHV30409270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 18:47:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A185805A;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B995C58060;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
Received: from slate16 (unknown [9.61.84.78])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 18:47:19 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v3 2/4] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Wed,  6 Aug 2025 13:47:09 -0500
Message-ID: <20250806184711.1882725-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806184711.1882725-1-eajames@linux.ibm.com>
References: <20250806184711.1882725-1-eajames@linux.ibm.com>
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
X-Proofpoint-GUID: EwbWYU6YztvcroEbu06d1zkhBIHuTJ18
X-Proofpoint-ORIG-GUID: EwbWYU6YztvcroEbu06d1zkhBIHuTJ18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEyMSBTYWx0ZWRfX3TCrLKrwRjjP
 imYHikmgZ5sQAKUTOo/gbNPnrv4to2QCjhaHLBI6C9zmzbbuZOuFcVTqJ9j8PZfqq2qlIHHHKKr
 zkQ74VcO6ug+SNQnkOkT7U/huuWuwzvGad9wmDHKjIoe+eziyphElk8zjR4PM2exWaEAWXPsSkT
 lXTnycagHULNlCOqpFVyOHWtfzmGZnybdhN3pVyONrzq1VSe5MTaFIj0oI82d8zNLTsJLiRgCQh
 g7/9G6D+B89rH1WlqQefogt3mq2UBa0m23kv5jAP4cMPSdCMTHS453+ThcS4vzbSuTn4j2+YZqK
 5Pw3GDwZ9+NlAUB585bDE6RgoNacX+/oPNbwgWIQ/Lg+5DfHIs932WFa/6W4r8hsVsGjj/B2VEE
 gG+IKe5sag2Yx9YEqegA9hg0Gd+2j7NOr5xbb1iCjDvRKJVKf3sLSbgIrmXTaAqPJFS2Ry/M
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6893a339 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=bXeKShIA4ZCQSYCXJPgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060121

The DPS310 is a barometric pressure and temperature sensor with
an I2C interface. Remove it from trivial-devices.yaml and add it's
own documentation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 MAINTAINERS                                   |  1 +
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
new file mode 100644
index 000000000000..3c2d807e4939
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
+description: |
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
index 4912b8a83bbb..756d988933d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11996,6 +11996,7 @@ INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
-- 
2.50.1


