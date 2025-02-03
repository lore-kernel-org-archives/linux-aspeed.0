Return-Path: <linux-aspeed+bounces-613-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E90C02196
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 14:45:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ymq621LhTz2yGs;
	Tue,  4 Feb 2025 01:44:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738593898;
	cv=none; b=oTU8bROFJRORrD222Xh9TbLVVBKifRrbbJQNvYrbAbNVP2ucO9jHMMdUHlMSYeQRgVPWzlf3sK3eiVU8LqKl1oatzEHdeMQYhQtFgkDBg441qZkhPk8c5kycDUyr7ttjz6bXx1PmKptdEo7QH6M3T+CzO1iv3qxq8nW6alxMtV9fZ63IK4KcdwQdsg/7PfQB2cPFwTqF+78KEEk411LkZ3eFrmBKJC1NETBfUU3ifE42CgEbAUsBKO3RqdSLMNnx04dHxqcLCMV0GaauZ5bXzIv1PsHkWIkfyBbur7bNADQvf4R5d74Equqyua/fCBJY7j/ZsSLRweg0GyisRfvKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738593898; c=relaxed/relaxed;
	bh=MnSNxIgYPsgpg0tKKR24BYQMKAZxqPPimhE/YL6OUow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khs6XLKiEXHQX/NRTw2Vg4LSkbVF/c6ODY9LaYbj0CdzSKpmRvzCuS+PFrofA94dY5qsEZlT4IMWjOvDP+X8uc2fhxsQ1kUJ3zMzoyjVdIjEtrlQLa9QQS5STpSnfig+WozLnKGxUpb9Ddrv5j341xm7DsA7rpvsoeOnqODsgu3sF+Rs55g4mm7pNmOBeetSZIb4rdBENLKQG8/6VQQbAxhQuX8jmNzys7spsTNdi9ofPIa3auCpLT5Vx5qKPoHCVSqL9tSXu6nlXoqvfhEi/1bXYUq75q/VbwXgxG+qI5loa3/3CXA3OJNKXGBSbFUcu7zziQyL9r3EUkFMXrQLvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MLeAX5Td; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MLeAX5Td;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymq606GnSz2yGC
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 01:44:56 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135OYlV014151;
	Mon, 3 Feb 2025 14:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MnSNxIgYPsgpg0tKK
	R24BYQMKAZxqPPimhE/YL6OUow=; b=MLeAX5TdmMNpf6EqZGj1nvV74N2f6Bqzi
	eninJqjRj7LR3Z3qdvBnNiEosWIAlPC6jJoZNgpJmYFSw30sPKUeb2c3C8b4x8VX
	23emq315j73Vd4DkuNxVDHdVOuN5Gd8NqCYEIfXdnymRk87kNGEYFDejEc2sHfPM
	xTttmnK/hZ6RbPAecIAPWsWliKxud7A/GoIZRG8Wnyv/yhIdSACXUiFHFs//FtKu
	WpmXVlIJQKq45jre1czek593Q359TJ5J3DG06Ks1NCvWKgTSpUOFztgOKm5O0W6i
	7Cg/0Qe600KguxPdS6wMlYAuekBbv9oBGjs/IueTqAN/PQ1x3uTTg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7aj7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:30 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513EZxcm020665;
	Mon, 3 Feb 2025 14:44:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jqm7aj79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Echfc016315;
	Mon, 3 Feb 2025 14:44:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxs7097-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513EiR1Z32309802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 14:44:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3263458043;
	Mon,  3 Feb 2025 14:44:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B0F15805D;
	Mon,  3 Feb 2025 14:44:26 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 14:44:26 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v7 1/9] bindings: ipmi: Add binding for IPMB device intf
Date: Mon,  3 Feb 2025 08:44:11 -0600
Message-ID: <20250203144422.269948-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203144422.269948-1-ninad@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6JVZS2zuW-JB1O4d1lC0kkUwKg2dNIDO
X-Proofpoint-ORIG-GUID: HnclquqNtgwvhoRqkBQeEIk0lcwIssUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030106

Add device tree binding document for the IPMB device interface.
This device is already in use in both driver and .dts files.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
new file mode 100644
index 000000000000..8b0d71901195
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The Intelligent Platform Management Bus(IPMB) Device
+
+description: |
+  The IPMB is an I2C bus which provides interconnection between a Baseboard
+  Management Controller(BMC) and chassis electronics. The BMC sends IPMI
+  requests to intelligent controllers like Satellite Management Controller(MC)
+  devices via IPMB and the device sends responses back to the BMC.
+  This device uses an I2C slave device to send and receive IPMB messages,
+  either on a BMC or other MC. A miscellaneous device provices a user space
+  program to communicate with the kernel and the backend device. Some IPMB
+  devices only support the I2C protocol and not the SMB protocol.
+
+  IPMB communications protocol Specification V1.0
+  https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmp-spec-v1.0.pdf
+
+maintainers:
+  - Ninad Palsule <ninad@linux.ibm.com>
+
+properties:
+  compatible:
+    enum:
+      - ipmb-dev
+
+  reg:
+    maxItems: 1
+
+  i2c-protocol:
+    description:
+      Use I2C block transfer instead of SMBUS block transfer.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/i2c/i2c.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ipmb-dev@10 {
+            compatible = "ipmb-dev";
+            reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+            i2c-protocol;
+        };
+    };
-- 
2.43.0


