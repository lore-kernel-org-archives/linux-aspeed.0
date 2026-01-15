Return-Path: <linux-aspeed+bounces-3337-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5D3D3CCA8
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 03:35:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds7tD4pq3z2xrC;
	Thu, 15 Jan 2026 14:35:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768448148;
	cv=none; b=Owo5rxzs6GWf6aadm5VOmhkb1/vXGyKauLYPIF3zu1KLI38gfruk6aVhvvkb3U1Fbw6tEAte+TtY4IExb7HrM2ZbTD0L+MGDvIrJv2aHEq7KAEr85LOyUwHXBG6X6fe25/Q0/JVQ59EB9n5CD5fvPbr6s7GU/FObic3DHamzrcv8jO++u9uIyvbNhRFSRBopyBu45Iun0RYZ8Yr0AhtfJwdHM+7NzJVQ7IOD5LYhI4/77T5Il3oE1ANeaFrnmj2PBtWWW/F98ghwToYxGwtwrVYR0kFxlslWuipA2qrvoZEI2690R+L++oK5mMUrqtG9x/BDlhPavW1PZv397yJ7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768448148; c=relaxed/relaxed;
	bh=LVMAtFSJkOmWLNQOjwD3PHOyrL1IbxHoq2jDW6dhuac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eRRXNUVJjE7VqspQQ/2uT5lRdXBK2mn9qm+iRJkiBZnjRy6Sz7GgKlSPolcXhtK1lzAN+uhQrIA9akAp7l2QEI1ObhtL5Cqi87vnNEz4vt60gLoUp7u0EJCXsHi2PdSKFX4/di2ftpUfOG307FcG51XV/uzf18iPap5E+1mFbRuocfb4Vcf94Tpa3NbyEYkFZZ8yOXafFqlDJ6zLRhUO9HUtr0NT2flt7drxi4cUzCeRhzB2GRz58VDsGdFMYqJTW9CTsuhw6OdZWZLc/Rnx+Vty9VHaCTg6MlHel0NvHyVpJa8iw2vQXkJDP3JjUX9cTu3gxBc2mobLNPu2gycChA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds7tC6sJfz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 14:35:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Jan
 2026 11:35:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Jan 2026 11:35:29 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 15 Jan 2026 11:35:29 +0800
Subject: [PATCH v9 1/3] dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
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
Message-ID: <20260115-upstream_pcie_rc-v9-1-d6c82a1556a7@aspeedtech.com>
References: <20260115-upstream_pcie_rc-v9-0-d6c82a1556a7@aspeedtech.com>
In-Reply-To: <20260115-upstream_pcie_rc-v9-0-d6c82a1556a7@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768448129; l=1554;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=nSo81XDH3g+0IhsQkmlg4apJPpZay88RgQZ5h1VpL2k=;
 b=3BjxpAFIVJJIe0vbFWljCmTsDe6mLa8pKT353DyKYJCAf08mufVZ8fqCtxYvFcmKSdV6UyTze
 +U0ykFQ0FQ1CsdSK70IoLn+0c9Kd9azwujNCKK3sSgZb+8iAdATI18I
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


