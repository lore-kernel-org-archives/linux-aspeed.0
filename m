Return-Path: <linux-aspeed+bounces-4913-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430A9C61DD6
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 00:08:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZNNK4HCBz2y71;
	Wed, 02 Sep 2026 10:08:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788264948;
	cv=none; b=ScaDyB74UyUYnS1e6Iw3wMPg4bFyQbqz7q/KotAjjCnl+8r5BTerpycwje53Wq9l9NIKxEM96bdeHbup9ws5capLhI2Qg8Sdkt66wiz8aChO0mPSygXwmQ+V0MP/SItG99JDJNk+748SEc5L7BqvLCocXmf54m5WgWhMU7xLvyREpvi35efndOe1vgh7LXb3aOxard4rY4fMEZ6iEhnnJbkBrtKiBJZNS2zx/X6Oy95VBrpevwvvCpQ91SxyenOTdYNEILQEW9nucH+++YL1ti35jr4wHHHllBm4i9QUGtzVd0Y6CqR1eM7b5BSaK+wi4ugk05ryfXjl/q+Hh5+cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788264948; c=relaxed/relaxed;
	bh=NIx23cic9vwgBOce5/kxPY4ydEoHGmmr9OIsZBzxUd8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cL7elWwLGIkX1qgmdweXCYmaKCbjF2+9CjMqR/+B6GQo/vbpAOtoL+AE1X7WOCVCgzamaqAdHqOjS4KAeJjNaSUGJBce3VBbN5sofVoX384eqWu0Q1TzELEAMyPgVNQC7AU7sZpDTDK/SbMPY6pqc2UJn7BuWOnQMHfygsUCVY+Xwj9Y1w+iBv+vuBtGjh7xvcm0gHF0Utk3dFBvEcXmIqUUgHdUDVS7//3HOTZIR8oS+rGdCiuAyjEOefcAEzIKmLaqTn5dnAHIIfYUgnZPk7Ncmj3eHBVqidqLtHpv6fy+EpQhFxhKiw2jGyBBch+TrmAR59ZYe1oHMl46EsO7sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cN8KA0jL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cN8KA0jL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ4ZV0rdVz2xmh
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 22:15:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E1ACE60214;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82BB2C2BD05;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788264942;
	bh=ih7W+wXfiTJthvY1vQFGO1aRjeSHWvFND7AC85htw0A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cN8KA0jLeMyzpPtULdVM8uFy/zhwbx/MFzgNaBI5cWzuTxUHeveo4q+CI9Lq9UTot
	 6HLqCBrE+psmsuoIgGuj4lPg/T5Lk2bbaFrk6lPRiMAje+KPpxGYQBXTFED+J8jz4T
	 n/vOoFVIRRZJ0lJ9E6EytMIgx6f0FQAx0EKp91JWEWBQUNQb5BVFDPtPtHhdsaO/cq
	 jvlqaXkveAUMBzcITVjdLxPld5FDyMoYZzYCN+HvMOJnwN3lJbUbonbKfexATrzuwH
	 W41FmGefCC1+upD0N3NyoMpCcXf+AWpCeNNpIbQf3a4b2Den+0ShjV1QQgp3rSavfv
	 Y9T1uHqBktwzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D523C624C6;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Subject: [PATCH v7 00/11] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Tue, 01 Sep 2026 20:15:15 +0800
Message-Id: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIANPBlmoC/43RzW6DMAzA8Vepcl6mfBCH7LT3mHpwHadEagFBh
 VZVvPtCL0XsQI9/H3625IcYecg8iq/DQww85TF3bQn/cRDUYHtmmWNpYZQBVSkvsUXCHmXk6dL
 1sm9w5CUy8W1glpVWOtpktSElitIPnPLvc8PPsXSTx1s33J8LJ71M37cnLZUM/hTAgick+32+Y
 r58UncViz2ZtRf2PVM8qJM1NXgN7p9nXx4os+/Z4nkKllxMdQynrVe9vFq5fa8qnovgWXFCILf
 13MrTdt9zxSOvXJ3ARgK/9WDlmTfug+UfygU0aHwgXnvzPP8BlrlDol4CAAA=
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>, Rex Fu <rex.fu.amd@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>, Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264930; l=4763;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=ih7W+wXfiTJthvY1vQFGO1aRjeSHWvFND7AC85htw0A=;
 b=s06DfTGT9sXXP1OOnhTvtLZ4KhucHRzdn4dQbTAet9lwP0+PLSpge/6xQit7R/XJINXc9FhPf
 6LnI95yaarxCirh1xyv2My06xMunVm/zWxHM6quFXlou41hI/8dk2rA
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

This series refactors the Anacapa BMC devicetree layout to better support
development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a platform
entrypoint.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Changes in v7:
- Fix [Critical] Devicetree ABI breakage due to removal of generic compatible string
  keep to use compatible string "facebook,anacapa-bmc".
- Fix [Low] Redundant redefinition of inherited properties in the `evt2.dts` file.
- Fix [Low] Included devicetrees use `.dts` extension instead of `.dtsi`
  aspeed-bmc-facebook-anacapa-evt1.dts -> aspeed-bmc-facebook-anacapa-evt1.dtsi
  aspeed-bmc-facebook-anacapa-evt2.dts -> aspeed-bmc-facebook-anacapa-evt2.dtsi
  aspeed-bmc-facebook-anacapa-dvt.dts -> aspeed-bmc-facebook-anacapa-dvt.dtsi
- Link to v6: https://lore.kernel.org/r/20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com

Changes in v6:
- Fold the following fixes into this series: 
   - Remove redundant vhub pinctrl-names
   - Use default SPI2 memory mapping
   - Fix dt-check-style strict violations
- Move p3v3_bmc_aux node from evt1.dts to evt2.dts for dt-check-style
- Fix the patch author information
- Link to v5: https://lore.kernel.org/r/20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com

Changes in v5:
- Remove redundant vhub pinctrl-names
- Use default SPI2 memory mapping
- Fix dt-check-style strict violations
- Add Acked-by from Conor Dooley
- Sort compatible strings in alphabetical order
- More commit message for ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it.
- Update commit message to describe both LPDB and RPDB GPIO expanders  
- Link to v4: https://lore.kernel.org/r/20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com

Changes in v4:
- Capitalize the first word of the short description.
- Rework the Anacapa development-phase devicetree hierarchy.
- Ensure that anacapa-evt1 generates an identical devicetree to the existing aspeed-bmc-facebook-anacapa.dts.
- Add SPI flash VCC supply.
- Simplify leakage GPIO line names.
- Add LPDB fuse monitor GPIO expander.
- Link to v3: https://lore.kernel.org/r/20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com

Changes in v3:
- Restructure the EVT2 devicetree to inherit from the EVT1 devicetree, making it incremental rather than standalone.
- Add the DVT devicetree, inheriting from the EVT2 devicetree.
- Enable MCTP and FRU support for the NIC.
- Align PDB fan GPIO numbering.
- Add an EEPROM device node for the NFC adaptor board.
- Add an additional EEPROM device node for the SCM.
- Add shunt resistor values for HSC monitors
- Link to v2: https://lore.kernel.org/r/20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com

Changes in v2:
- Fix dtbs_check fail.
  Validated by following command:
    make dt_binding_check DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa.dtb
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa-evt1.dtb
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa-evt2.dtb
- Link to v1: https://lore.kernel.org/r/20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com

---
Andy Chung (1):
      ARM: dts: aspeed: anacapa: Enable MCTP and FRU for NIC

Carl Lee (1):
      ARM: dts: aspeed: anacapa: Add eeprom device node for NFC adaptor board

Colin Huang (4):
      ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: Add EVT2 devicetree inheriting EVT1
      ARM: dts: aspeed: anacapa: Add DVT devicetree inheriting EVT2
      ARM: dts: aspeed: anacapa: Add additional EEPROM node for SCM

Peter Shen (1):
      ARM: dts: aspeed: anacapa: evt2: Add shunt resistor values for HSC monitors

Rex Fu (4):
      ARM: dts: aspeed: anacapa: Align PDB fan GPIO numbering
      ARM: dts: aspeed: anacapa: Add LPDB fuse monitor GPIO expander
      ARM: dts: aspeed: anacapa: Simplify leakage GPIO line names
      ARM: dts: aspeed: anacapa: Add SPI flash VCC supply

 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    |  260 +++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi   | 1131 ++++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   |  408 +++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1078 +------------------
 4 files changed, 1800 insertions(+), 1077 deletions(-)
---
base-commit: cd7d1ef7d74ed5f5a1790a40389bc38382924556
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>



