Return-Path: <linux-aspeed+bounces-2252-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E0FCAC5A0
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 14:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRhLx426Lz2xlK;
	Thu, 18 Sep 2025 00:42:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758120153;
	cv=none; b=BQGrDZINs+bxKQFd44JxR/EFhIIINfXrPI2Ylj2TMZi3sR6WiEEZev6oc3XrJB+BVyDSE9/K0IzCtVv9E7/zx3eKJmMea9rU/jUXSp9VsjOBz+XFwoo8gwpUJm/s1Xt1wNtTYXd1CsENEe0mfdhKPpNfdpxh9LWplMHB0AOli7k24OmF017tTJcaPMCLrEs/3Fu6xBQoYYNLfuYEFW4S2gc0peRN1Hfw3bsMJU3wst0hMtFE4h/z3uOE39LlgsHiQthMtXBo2Tn7nvCo3IXXMIiEru5z2wCT/ehcy8CdWlygRq/iCp8uShMIvAGVkT/RUMaC0RKwdi1b/ZrCSmkFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758120153; c=relaxed/relaxed;
	bh=CImNgmlOQCjqkUdMcePYIV8VqOAvzBMr4fh7cDDQQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXOEWtmtNYaJsQR9E9eXYdF6xmD+FZLLqe6bqRUHo2RD7/K52er5DuWL3MJWs96dbUvOg95maGR52k73u4wg7U/XQTtyKsDE6wOACfy1oSuIIFCtct7UZKdnM1xh5jtkxZfRMvmnbHBzTsFKJG0HGxQzWV4HhHdX42gEG4FcAkpy05L9c5fw+yR6sFW3l+2F8NdKieQr33kdPLvpHPGT9fJ/0tLjXrlRvbAcw1w05uBI9UN4L0WP9/GGb8as9mDn2ro/uOnNEqJKD1pH4YeEw+tK2yYkanKfBbo5lr9r/tuhIkLkAZII/nB9CyzC+fWGiQ3x/GtmEEMSKs78tcD0Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qilKZfql; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qilKZfql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRhLt2zYKz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 00:42:30 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBCqKe027546;
	Wed, 17 Sep 2025 14:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CImNgmlOQCjqkUdMc
	ePYIV8VqOAvzBMr4fh7cDDQQlY=; b=qilKZfqlfJo2DYtJx/5b4xIfllLycF/Ru
	dfH7AhwW/0Bwo0dIGs6s0hXPWPFioYipMjtV3KYkNbJcydWvhIh1Og/3VsGaXXbP
	Mwme90Ti9v4uFdiU32jDCQO7d2lS+hOg1daUVsFDTK87A46M00Y+XH0f8s2xxdBG
	th05ktPC+zB9mdp4p0sV+/q/DajTKLIZTx3wlK3xbxafblcj2YeCK7gHpvGiAd9B
	LhEwWweT0+2AXlr1aTn75YjW5LqUbtB0FI1c+V9NeLjFeg2ib9ArZeJO8P3re9UE
	/Fmb+U3s2QmqImDhFHmBB5sbDJqIe49Z+Mo/FBcjsHsNV9yhoAUzw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p4ckt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBSEgX018649;
	Wed, 17 Sep 2025 14:42:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mhj42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 14:42:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HEgMBh33554978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 14:42:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C63958055;
	Wed, 17 Sep 2025 14:42:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDD058043;
	Wed, 17 Sep 2025 14:42:21 +0000 (GMT)
Received: from slate16 (unknown [9.61.98.41])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 14:42:21 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v5 3/6] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Wed, 17 Sep 2025 09:42:07 -0500
Message-ID: <20250917144210.160051-4-eajames@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2dYSKDOiOVuU
 QhkQHJfwSMU2M3KA29/Ow5oeuQGTbeiEztJfrJUfZ+lAj+vEbOxtBYJTYb52mGVnQgde6gytzhk
 qHThlGFl6c6wHPTXVB8CGShoBEaYrHxVB6yQDGUc+9OUSuDISXJdI6NKzZgPXXNQJ+EYENisblY
 +QspCqEBOiMWElUqJanYY7iXoHEzIUQWUThzPl4xR42foJUkbEe8+WiM76ITQlyPCeLserlYGlz
 fAKCzTPJWbbqJcKwEasJMpQCYJvRj03zLBvyaimPt9PGJL1v2c4NX6rpBIet5QF7NMf7Q62CiuO
 oBF6SDk9WO7+zneKD6sFmj4cgwR6MJInac6EYPgl56TPb+FK1v1HiS+xTCWq0rY9Nxa8pEdVBRi
 q9Qjv9yy
X-Proofpoint-ORIG-GUID: pinrgSBirTnnEykgw1ABWYAqBZJCv6Un
X-Proofpoint-GUID: pinrgSBirTnnEykgw1ABWYAqBZJCv6Un
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cac8cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nPmG1HaLeDTRtUTItIQA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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


