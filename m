Return-Path: <linux-aspeed+bounces-3022-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF2ED111A8
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Dec 2025 06:29:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKYsW4DRtz2ypW;
	Mon, 01 Dec 2025 17:29:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764570575;
	cv=none; b=h1PcKiLKHg/cdIgjCulkg0VDG0SXnBnS+7uQGIAtBbq1RnVRRZWVfHhbqnQkAYB8yftvqPa6KjyQQKI3LPIEVA5mvwk3gXdhg2AECi5YV7ZELteYND2v1kA5vmSHfkSa+guZ9RAJi1roT42lTjbGBYGlqlpZtXW6H97DKQKdKMabumu4sTyRe8/wcAvMSbTwNUMiHID6SLndenKYrxr4VQVRmRbfd3vhshYHBGpdpvVQCTNX3o0DS/nH4vZuEYogmQZgZm3LmCd/GsEMWjMBN5Jh8huJLPo/foYBaXRoTD8ctR7B7XaDIprOcWRN+aajv5n4e5uCiMDGnccnYuzakA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764570575; c=relaxed/relaxed;
	bh=LVMAtFSJkOmWLNQOjwD3PHOyrL1IbxHoq2jDW6dhuac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZxqLvpR78Si9DMvjaplJyK9XPUQCNlUk174/PgRywEBTmxfwZvA84qfo8CYEZHFpMZSRU2thOjpc9nUsSZqAVPNcQI7/n8DCrbAmG95kMBbMr94hrNQB5REqPCjZiQ/vqlrGi2Y5LxorrPqtpMJDXun0YI6P8RxdGr0rK93oOgFV3IoZ3iRGymgooxjuhryEq6/ghCGrppv4iVeKc3iM2n+vRucFGUvqCV6Nus39xWAM3/4ooRijmFwXohY+3Gz8Sn0ZTtfOyQrtOaqEYldWW3a0sQ3/1hyp0qilFjXsAEBiXhNjMR7Vvf2+CZ6XvK/RT7clzvQWRDlTnHq9gyNO3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKYsV3KB2z2yvR;
	Mon, 01 Dec 2025 17:29:34 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Dec
 2025 14:29:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Dec 2025 14:29:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 1 Dec 2025 14:29:11 +0800
Subject: [PATCH v6 1/7] dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251201-upstream_pcie_rc-v6-1-8c8800c56b16@aspeedtech.com>
References: <20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com>
In-Reply-To: <20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764570556; l=1554;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=nSo81XDH3g+0IhsQkmlg4apJPpZay88RgQZ5h1VpL2k=;
 b=wn4tVyDcRAl+ptbneXUhW5x0rObe9Oc/HOE7tXxWQGIo5vEzIS2OoEoe74E8/Wa/IitSyebs3
 ezDyZrRcA+HBsnc8i6VrZcdwJBirEvHGT/W252l1nt3rEtZ+sLZaS36
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Introduce device-binding for ASPEED AST2600/2700 PCIe PHY.
The PCIe PHY is used for PCIe RC to configure as RC mode.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/phy/aspeed,ast2600-pcie-phy.yaml      | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
new file mode 100644
index 000000000000..71a5cd91fb3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/aspeed,ast2600-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe PHY
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description:
+  The ASPEED PCIe PHY provides the physical layer functionality for PCIe
+  controllers in the SoC.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2600-pcie-phy
+          - aspeed,ast2700-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@1e6ed200 {
+      compatible = "aspeed,ast2600-pcie-phy";
+      reg = <0x1e6ed200 0x100>;
+      #phy-cells = <0>;
+    };

-- 
2.34.1


