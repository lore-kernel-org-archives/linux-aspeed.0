Return-Path: <linux-aspeed+bounces-973-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D410C282DE
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 11:49:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBFXs4ZYNz2y34;
	Mon, 10 Mar 2025 22:49:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741607341;
	cv=none; b=eI8N87WV+/2PS/oLr0V4DhBPmu8LxwDuAvA7CIl2IdlEVSpRB4Ex0j+mL+jPVxlXpqlFZgDjTFPs/ugQ+l5YgI3FZtO86cLUFC+bNwOZFXs3d4lzMZCwt7BBnYky+YBuxmYX+yAeJmNG2VBe4brG5mXGE7udJ/+pvMVRnrSLeoC3k6HtffxfSrK1Xb85KFeBpDoiAgZmADXaFUQ254DT3V7w87AsEhF0s9j7JmXXdUz2NF7sL3lNeuQSaGObIA/g93+NDMQGx9nzR2LVhn3QepqCYPqjQI4SZZYSBnviWWQ4KNnyJn0QIJiMXT4fs2nf70nPVTTmSP6VrlWoFDEcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741607341; c=relaxed/relaxed;
	bh=ZPeOALh8hvdV7JWB8QVZ8vIgqd6Fip8BkDA60r1vc3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdJeyXIKrGwbCm0RE8YOkG60OZgqO+P+pCuqdsqVWrzzs7v1DomZsfhZPaIbbmA3zhsLkyEjmrjjh4TDZyBIlUIt58Wdg7fCguPdjy2V1NSHnlv0M9XH3IEZbI6x6OSiWyXNXdK12ElBhon+SxR/yNG4S+M3kn7Q2ijaoqEann+bbYRK2B5PTxAIdawWu3xO9z8uy2NHJQpS6yqLXpnXBYhmAcZgjshscVGD4tNppOTH9ITnQr1btaz2TUrCG3Za8fcczRRDIOY+9SoKW18/xSB6EpFGcMTdvtHV9VDkRJmn6Srz5JzShNbACrSIGeqlKD+BI+yumnnxp/lKrqb0sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBFXs0MtPz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 22:49:01 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 10 Mar
 2025 19:48:40 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Mon, 10 Mar 2025 19:48:40 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v3 1/3] dt-binding: aspeed: Add LPC PCC controller
Date: Mon, 10 Mar 2025 19:48:37 +0800
Message-ID: <20250310114839.3098148-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
References: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
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
Content-Type: text/plain

Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index 5dfe77aca167..178c151a19ba 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -149,6 +149,37 @@ patternProperties:
       - interrupts
       - snoop-ports
 
+  "^lpc-pcc@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      The LPC pcc interface allows the BMC to listen on and record the data
+      bytes written by the Host to the targeted LPC I/O pots.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2600-lpc-pcc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      pcc-ports:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          As a device handshake with a host using the port-mmaped I/O in x86
+          architecture, need to handle specific which port I/O address for use.
+
+    required:
+      - compatible
+      - interrupts
+      - pcc-ports
+
   "^uart-routing@[0-9a-f]+$":
     $ref: /schemas/soc/aspeed/uart-routing.yaml#
     description: The UART routing control under LPC register space
@@ -176,6 +207,13 @@ examples:
         #size-cells = <1>;
         ranges = <0x0 0x1e789000 0x1000>;
 
+        lpc_pcc: lpc-pcc@0 {
+            compatible = "aspeed,ast2600-lpc-pcc";
+            reg = <0x0 0x140>;
+            interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+            pcc-ports = <0x80>;
+        };
+
         lpc_ctrl: lpc-ctrl@80 {
             compatible = "aspeed,ast2600-lpc-ctrl";
             reg = <0x80 0x80>;
-- 
2.34.1


