Return-Path: <linux-aspeed+bounces-2276-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F935CAC5A9
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnM3smpz2yGM;
	Fri, 19 Sep 2025 04:04:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218663;
	cv=none; b=JPkXpaQqJcxa2C3bXqAWeFQu4wiIkP8bEv0tDVA884CImxI6TsGmiZUQYbN9UvpI8PFRB9BmbeQskdwpQGeLhETWVCLAcUASTyXIIcoGlBNYJcznmMtqVYkJJ2CHOf0hwKBpkolXaSwzPpji8MmrDG9aZR0fVIukkXyspd8XSvV8dDeN0Co/An15jhh42dNNoMWFX3IBdyhr3Mp6gQnpbWS+98JwSdDXJlOkJWPmFTO/icM5x1pd2Z8k8l7gwfHtXXcc5+cOGDqauRzg09alB3YwOsPcyLLWvf0ryEYw8kemt83ECq4YDAjObQFgPJTIMpXtLaTvT85ClSszkaaQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218663; c=relaxed/relaxed;
	bh=CImNgmlOQCjqkUdMcePYIV8VqOAvzBMr4fh7cDDQQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC2pU0Wp2+OBGPkGD1ZTBnnIDnC95i0NmbKpMRK7NgA7eWxiJu9UVhpR93OZl7xeZQGRYoy9fdwsI33KAynqh6cRXL7+dhSaQVTp2TK+6wfDgNO/IfFOTqEZWJajISAcNgWx1aUus7AeDsmag+xNVMvvd6kaZLfMBshQkbvNCpnBTloZ5KMHEIlb69WZ/IVNP8Kgh9hGMYDhWlJasL9/SKDUjDeAEhctbxNclHzvlPToNgkBQ34LeAsE4LSh386zvcLzrvi3n6BkjWDvuwsZ2tVBsJX1u6eWhgjQlxjn4t0H2OHMbT+2Vw/Bp7chuggbcGcB3m99YdfXn7dufwwL0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G8kwR08s; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G8kwR08s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnL2Xljz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGn1bX031401;
	Thu, 18 Sep 2025 18:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CImNgmlOQCjqkUdMc
	ePYIV8VqOAvzBMr4fh7cDDQQlY=; b=G8kwR08sF4GaHacfHyO/THs9qd98mQ7eK
	d02AgIJ9GrE+5nUDjeQMQcpiRRBsK/GGYb6+f8zKn8tI2CPvk9FizrJD2S0Lskn4
	bJdKd5LhFt7rhJSls/XBsqfkq6ewcUssuPnKIKMmsBcdigWdSxX1gjfEg8XTDgXD
	UQMRsOBr/ekn2rxAAElDHGaXnF1GwcSDxhuXdGPdyY2hWqpLSAcovSX3aotC/6pH
	zPJpqPxWsdvkXb57v3BBJ1v0OxcdZl8/2rSOjVRHPiwSENG/LVep599dBpGmR0ud
	rKIcpFsCdwztvIEkOJPJZFBxA6ePRwsfEx3TP1vG1oU4Eu/ErQY1Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hv0dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IF6FpE008987;
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3qrab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4BXh524808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 371C758060;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE8A5805A;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 3/7] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Thu, 18 Sep 2025 13:03:58 -0500
Message-ID: <20250918180402.199373-4-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: y59cYjksECP9ZpOyQUN5aXdyZjmAMArT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4Obb21bm00Sj
 Grd6EQ/sTxx3+L3glE0yzK5TY1uAvNGZ6MNOPDvQhJUg8KZQHvUzn1TyvmOInWAuUYIuyyPvyDM
 8HRgY9QxphiAfyvjXgIHs0qxrNQYiuGvraU11VdLJAnSeFUht4JyXxejksCTQLFlsx4E9h9lyBZ
 OAM6OcnnHw1H+NnO841LToOBs/4enB91UqbgSGNVB1ES6Y2muj6P4G4MLvLqZOODG+0LE6KKTkH
 VmpE4Et0z+hk043N8nhONlJwTgByfWAA4MquGxJFCMnleRVQb5yd4BQKWG3c2HX/d/Rr1kvpsLp
 iL76E79aHWwWmYPaLNwMje78PjyTVizH6aVLC8rmmVWgH25uGgfJJ3xHOkOZFokJVij71i2KHHl
 +nJQaf/f
X-Proofpoint-GUID: y59cYjksECP9ZpOyQUN5aXdyZjmAMArT
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc499d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nPmG1HaLeDTRtUTItIQA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

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
index 9da37c8dee69d..656eada3d6389 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12176,6 +12176,7 @@ INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
-- 
2.51.0


