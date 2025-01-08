Return-Path: <linux-aspeed+bounces-353-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3ECE77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 16:37:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YStqj2qlfz30VX;
	Thu,  9 Jan 2025 03:37:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736354241;
	cv=none; b=fxNPmj42uJIu1akXh8pX4mja3V+uRkwxV8gyjvELLTHsKODpGDJiSHwKG2C5ZwPsaCrGwSbEEFZXCa538fZ8Q4kEHvpKymRr3lGwGhjHFrGxSXZ7qFI1OPnR8f6NpTfPEOJCxrRV3qFBP4fw3ybOe8zS1i0NPKLPGP1qTMLNSUZscHYB7kirufrvDWsFEgAgbtYU6kXliNupwSwVDm/AwklpK0RgvsHMHrsbQT9ULjilacVF1d8Okxluv10uui3SEOJjG9jWqU2QCQgyLdI5qSmpZBRbOaqiJknWIF+FhG2wb7J0xx1vRL6aNHpVGE3wf0MJQ8d9/Y6wFy8Ebv8AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736354241; c=relaxed/relaxed;
	bh=Eeb+5bbQwiD1cuiyTeHIf8yHJDqRjV/gy6/cIxE2XqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MM7Lu8RIjfCHmN4JRD1U4CDHLfzf+y4md3kZDPTw3D13txk5RzTqxx5Pgf3e+tmQBO5XFbEyiiJNu10pakRWTlN12H9XYWjCZWJuLmHMmZO13yQqyLZmu06ngLDlPhjYvS7zmb0Vn5zb4QDS0Xg+nYOMWM/rUi6OrbNByeEiGQpLSF+ve03jzm6BOKfdlq+AVIzmWTuWWQdKP7a1F0DNlzHJmBN5dDDEwZLo+s4b6tOtN89DiF1X8BANYVinNVnLfERsHF32GxmPf2X2tC1AWiZdzk60cguCgm68G+ytNhGqo0jDjby1n7HTG5UAJWwbqCKseA91sthbhlJFeHrp8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pjBqCBO1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pjBqCBO1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YStqh107xz30VL
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 03:37:19 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508BkaTZ024752;
	Wed, 8 Jan 2025 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Eeb+5bbQwiD1cuiyT
	eHIf8yHJDqRjV/gy6/cIxE2XqY=; b=pjBqCBO1k6/Yy7gtpNCApxWfPZI9mbFZf
	ya/ouAoBB+tTHu+7lvonTL3DLo5F1gEWq6u5oHNr5k47uXG51lNJkwRYR/sCo3C1
	ik87Kjqj0h0u7t2PmAzoUOSIxZGX0OF8ML0q5xxHj8P4t9oRRoeaUFFLKEZxdPbM
	sTpeUEOwdPjJCX7egA5wvUgbdNuH1dWwhDNaijCCJwMvrwToQSd0pVdcujI6qmYN
	WnqWH/Zip41yvSOfTKhMvlzOfidmoVHvdVIm9+TeHn0SPqVIWYFU8fx9ke5b5hfl
	GxsscyipPos5jI0NsfTBNjtnGnCy1uIR5bbaXrWW0/EdE/SQPhTSA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj42kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508GWffH001185;
	Wed, 8 Jan 2025 16:36:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj42kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508E3ikH028054;
	Wed, 8 Jan 2025 16:36:47 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk8fu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508Gajd124707608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:36:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB73558063;
	Wed,  8 Jan 2025 16:36:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B85F958058;
	Wed,  8 Jan 2025 16:36:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 16:36:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 02/10] bindings: ipmi: Add binding for IPMB device intf
Date: Wed,  8 Jan 2025 10:36:30 -0600
Message-ID: <20250108163640.1374680-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108163640.1374680-1-ninad@linux.ibm.com>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
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
X-Proofpoint-GUID: G7djX-H4gCRzpCafK7OHUYyecHfPp2sg
X-Proofpoint-ORIG-GUID: MfxIFkF6SMTBxEuT45eu-RQSixEpBh8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080137

Add device tree binding document for the IPMB device interface.
This device is already in use in both driver and .dts files.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
new file mode 100644
index 000000000000..a8f46f1b883e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IPMB Device
+
+description: IPMB Device interface to receive request and send response
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


