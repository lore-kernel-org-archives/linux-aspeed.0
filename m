Return-Path: <linux-aspeed+bounces-449-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D22C02184
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:49:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2rW6XNGz3d8J;
	Tue, 14 Jan 2025 06:48:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797739;
	cv=none; b=cH3FwfzrZzRk7wM4fFXHuinTNuC3JILloHQfYhQGFnWXw+eRWG1spzyrevcFADKzjuYuEVvyEeXHn0A4bp2tEa+w+3PzRKRKp2G9eM3yrWE/yzEF1AxoVz9f0ryGOYJAU1oQfa+4Jsne8VxKQr9LSOSVL5KsWk+IT8QkuaeSV40dgioKf44aXlNlXFnolfSfoBYA0zP2Fl3CknXc/GTjlZXXT/E4B+GCIjR9cta/WjL8UZiuWTAiB+uXAO7m7JrUkEfKQIXRJ6kYR4BO1xMjkdRASlS1OOpThOb7Sb2cDIcgQRcYKCgrrhtGrqk/Wi/sQEcQ0UI02U8tXn1dkIDNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797739; c=relaxed/relaxed;
	bh=fab8HOYyReh75sGdj3d39HxN+S7IqDmP5CXeNbWhf/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV4rQrC0YdgarBFeOuC3hcI3O5OxHZdVuwFT/iW8WqCqFSiRsFLcQQ2Kjvx19h0qk9tUqOUqx/U+AefpuC/5EfhIRcY6bTTdO1oZ5XI39O1uixCIr5cjoMKevfo7VE48+Z1ibwrSobZ3gr3N6rrbTCE7Tx+zFFYncSvryKZxZZws6/pmBN3m9tIOR7H52x/RERsJBh+gdQHkTAEjInQ3PAicVXbq+5O24mD7rBt2lpyiTfpaXUf2cxN752ECuVm8EkT8e9IJVs4fvlMw8xjeFEkAosmMXG7yhKjZsI5dnWQZ0SHSq8d8x56dtf52kdSWdm70+001SGO78i84Q/4kvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZE/jL3nG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZE/jL3nG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2rV3MVDz3d3Q
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:48:58 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DEm4Fi002409;
	Mon, 13 Jan 2025 19:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fab8HOYyReh75sGdj
	3d39HxN+S7IqDmP5CXeNbWhf/k=; b=ZE/jL3nGgzqBPx28vAY/EMB+3y02G/Axr
	urvnt0omitDvtzsDmStGpxkbVXZ7zO5qdOUrnE23g7lqxaWsh4ZeXuEjrGxNya6y
	3Y7kb3HfbUINZ5c4iRWb/rdu6F5Erkcd4Vhf/p1skg6RaVSGUd2L2Xk5uBZJ0Vi2
	ZYviz1Sl7kgf/KhCJA6hMqyiM55WASw/J8OL8iV1z8JJHWXAu84TCis5IAypZmTn
	0LTky/Tgs8rtpKYB4mpzmpexNP0CBs19e/WcwhnGmnXUkYGZpoMC7wIzj/77Idef
	BKeLLbS66jWwgrdbD4jmVgvLEjSxqjQw5neNWG/eeg+yskM2GN71Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uaguvt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJmTsZ032460;
	Mon, 13 Jan 2025 19:48:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uaguvt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DJIeTc002738;
	Mon, 13 Jan 2025 19:48:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443bxyxnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJmQCg24773194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:48:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E0985805E;
	Mon, 13 Jan 2025 19:48:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED0C58059;
	Mon, 13 Jan 2025 19:48:26 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:48:26 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v4 2/9] bindings: ipmi: Add binding for IPMB device intf
Date: Mon, 13 Jan 2025 13:48:12 -0600
Message-ID: <20250113194822.571884-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113194822.571884-1-ninad@linux.ibm.com>
References: <20250113194822.571884-1-ninad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DjZ86MhFZKN8FXPz5qgFFGmSYKpUzrHK
X-Proofpoint-GUID: jFWM7qK0dKAwlDWvSqRog8hx0YNLJuyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

Add device tree binding document for the IPMB device interface.
This device is already in use in both driver and .dts files.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
new file mode 100644
index 000000000000..136806cba632
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The Intelligent Platform Management Bus(IPMB) Device
+
+description: |
+  The IPMB is an I2C bus which provides interconnection between Baseboard
+  Management Controller(BMC) and chassis electronics. The BMC sends IPMI
+  requests to intelligent controllers like Satellite Management Controller(MC)
+  device via IPMB and the device sends a response back to the BMC.
+  This device binds backend Satelite MC which is a I2C slave device with the BMC
+  for management purpose. A miscalleneous device provices a user space program
+  to communicate with kernel and backend device. Some IPMB devices only support
+  I2C protocol instead of SMB protocol.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ipmb-dev@10 {
+            compatible = "ipmb-dev";
+            reg = <0x10>;
+            i2c-protocol;
+        };
+    };
-- 
2.43.0


