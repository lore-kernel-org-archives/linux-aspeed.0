Return-Path: <linux-aspeed+bounces-641-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04484C0219C
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 18:44:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnXMd03lBz2ytQ;
	Wed,  5 Feb 2025 05:44:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738694652;
	cv=none; b=Fff73g2HxQjp6aPVwcgOJUerZbHOfwnMBKo7wRnFe0ment6kwXtuLAvxwP1/Ls6Hfcgd3fb3FYXdnf1VqZqKgqj3oTy0LmmYcwXEhxJtseeGIkfi1lnO/47Efwje+I1323edfQIUdpfgN6pOr1v+MTKsCVmw+basx9A4Z68qdexZi9m0EM4QNRnTrIJ4q4sV4Mtr6GsRVEIliTWWx4YD4mIrD8cZdBFZ/WwZeh2/TlWdkcXIo0GWC02+TuWoc1pgnp2IdJ0NvXng0LHdjfjF3j6XVdJ1Y0GdOddigDPTngE42Cd2yC+MzWbdjjoiAShc1KT0Yk8WX38ClXSLgDVvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738694652; c=relaxed/relaxed;
	bh=MnSNxIgYPsgpg0tKKR24BYQMKAZxqPPimhE/YL6OUow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG+QkVDqxs7/4JZxUVsQ8QJTe0IxLpnVOryhBcdnROqtDWWm7WtPEukcMRHtpx69Qzj7OzCYDqmILUyLFMDsyNxiqgx8RtQYGBWy5bkAWB5NeQj1tZvPgGmY5grehVPsVn2+kAoYxUkO5q2/PZ/Bfe0k067qxY+cdkF2M+7NDb2MZAhYhDfqLygykSC+x8FCf5lsFm0ErlKn25H9Mm47pDIwVrwupyk5hNwv+B/b6gOnmWfX2qfizOU8btZZBypczz2Jsp734F2GlcxJywf5T5oW+VSNycftW6QKYBpVJk1jo9nn/+pWVGZw8+XAJS+U7manwOyfhsxFVPOEdTnoPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TXFC+iF5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TXFC+iF5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnXMb36j4z2yvh
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 05:44:10 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnmK023279;
	Tue, 4 Feb 2025 18:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MnSNxIgYPsgpg0tKK
	R24BYQMKAZxqPPimhE/YL6OUow=; b=TXFC+iF5hevfdUKEdAbKUvbOlQHP40lQE
	lVyGRKSy4z9KHNLOcc1hNcBGQ6/1Lg2EHlvY30GjegOZn8DDxiOaFKk5gXFb1Wch
	xTbCLh8DCEln3UTwnUCfebDB5DvoTNr/tDc6FAz6tg4YvCIsS1f25b648aYnM/2e
	T0nEksJ7UjGZjI3OBDcJX0KFX94rZMVAWbigDHAUudq2x/nCB/Cidx2I364Hf7Az
	tIMTpGvHZ3dAu/Ue5TPxtQD7PCoekIo49aFqX6rY6A7rRcWhCLLMhUGN5bzqO6I/
	pBes+WjYHyZS1Jid/gq0/2dCIaxKtfWPyxUfyNcXsZzRq/fyRj2QQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62h6ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514FsYEI007136;
	Tue, 4 Feb 2025 18:43:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxayn23e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 18:43:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514IhgqR26477170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 18:43:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1530F5805D;
	Tue,  4 Feb 2025 18:43:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21FD458059;
	Tue,  4 Feb 2025 18:43:41 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 18:43:41 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        openipmi-developer@lists.sourceforge.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, andrew@lunn.ch
Subject: [PATCH v8 1/9] dt-bindings: ipmi: Add binding for IPMB device
Date: Tue,  4 Feb 2025 12:43:27 -0600
Message-ID: <20250204184337.3896834-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204184337.3896834-1-ninad@linux.ibm.com>
References: <20250204184337.3896834-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: tTZGu_SeBLJ82uhjc1b188stlqVOBG19
X-Proofpoint-ORIG-GUID: tTZGu_SeBLJ82uhjc1b188stlqVOBG19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040140

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


