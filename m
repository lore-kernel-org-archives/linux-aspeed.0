Return-Path: <linux-aspeed+bounces-4709-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A39FC5DF67
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7C31Djz2yqX;
	Fri, 14 Aug 2026 10:46:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622408;
	cv=none; b=Kz7a31BqrVzeNdhVL9i5aCCq2hntR+gFjUFQLjMAdAdujlB7iJ769bbexF4bgT3sjKDEv8fRW5XYRwG/qZAWGXDL1PsiAPa5wLnQC1k4QNGx8pmvFC3mGMqthtkOLfK3P32ZRgY/o01CVvpWIrdv4VWBg4kTsHBnUPDLJQ+fbZoVIjb/DRC4X5yVhW5Crns/SrWK82GEXzC0Fxo/Jc8QvJVqc7KQdy5bS7eqbm8MO0DUX469WEE1j2c84XF6c1be++9YITn16oQpC0JjXaYFHrwqJGNpIfiktR87qNJU67J3jGYEdQI7loph6AVSnqZQCk28bM2ytdYczLHqlv1cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622408; c=relaxed/relaxed;
	bh=Am0FRf1MiyG9Qisxihff4Ico7LVKmPXMY6H0lNw2zw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fSqVdOlSCAtWR/ArgL88m+6eY/wt3y3lkKTKciPaZg34KI0itrG3DNU+1MmEc72XnkKKdoMJZ5LGHYh14KrqbOekMkT2N6u7Ljaszqu+gSofWvnk7T3JkR//GhBJm2nSvNXeUETePyuFmnzKynVMc3h+4VwKU3DmZC1BEwcyxzbpeQyDSePOgnFb6txe6IVaO6d4oOT2kE5pUg5Ak2qJF1i29rTB5MG3dQKiORa4bvJbL5iRjFlfFpCK+J6X9uSEtIuFl93nyZEeM4gYm/Xwc6EYJFsAEY4HavG/AVDQvRWsyeKW5Vp4oc0eQbj5gJuzizaY9oI+YFJPzcyO+gvSEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bC13H6GT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bC13H6GT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP775B4Dz2yl2
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 24E81600AD;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB6DBC19425;
	Thu, 13 Aug 2026 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622399;
	bh=KspGXcyx0zJEN9WlK/sXLb3sPuYZz8T7kJQlmBlGklA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bC13H6GT9bb5Rh800MSSS94DDhbZOr846x0Wqj4CNu3D6d+jX4lFuxKOgerfKG2s/
	 O+heO6OjhR0aO5b8zV6jhj8tILolee9NLlF3/MjokTvmeH3YAHlSKHh1lswgdUuSGc
	 3h/49EPFwEJfun2PP0sbFYMgkUHWKTZt3tq+fgYpGRX8+vKMqJUItlw9UHhlTDcKKw
	 p6T5JVXlbohnyJ46B1vL7uiUns41Tj/6PLYFqfiaRpVKuYShAZhem0P09iN9kKRfDm
	 mcfoVjFqlCwBe6nDm6FIWsQ+7/ChB9Nnq5IMdyllK5UE2fip2Sec9vJ07oNcbzWgo3
	 Cr0jIqXvxKpfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDAC5CFEB;
	Thu, 13 Aug 2026 11:59:59 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Subject: [PATCH v5 00/15] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Thu, 13 Aug 2026 19:59:30 +0800
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAKKxfWoC/43NsW7DIBSF4VeJmEt1AQOmU98j6kAulxgpsS2IU
 KrI716cJVEyuON/hu/cWKGcqLCv3Y1lqqmkaWyhP3YMBz8eiafQmkmQBjqw3I8e/ex5oHqaZj4
 PvtAaCemSiXgnQAQVlZAIrClzppiu94f9T+shlcuUf++HVazr/+0qOHBnD84oY9Gj+j6efTp94
 nRmq13ls+e2Pdk800cle2OF0W+eengG5LanmmfRKdQh9sEdXr3u4fWgt72ueToYS0DRG9TP3rI
 sfyMIS5y+AQAA
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Carl Lee <carl.lee@amd.com>, 
 Rex Fu <rex.fu.amd@gmail.com>, Andy Chung <Andy.Chung@amd.com>, 
 Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=4004;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=KspGXcyx0zJEN9WlK/sXLb3sPuYZz8T7kJQlmBlGklA=;
 b=zJW+wxbsgrn7odameHSrHPNFOoXZrsOk1aKRQSZdYLK+ZFFLrxpbYx13lcUvpxoLLTh86LQIc
 5DGIJRDwC4WBE5N5ifI7bcvBcxB1DCkUCHaZO1jhbzOGYMoU0i7Upcq
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

Colin Huang (9):
      dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2 DVT board
      ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: Add EVT2 devicetree inheriting EVT1
      ARM: dts: aspeed: anacapa: Add DVT devicetree inheriting EVT2
      ARM: dts: aspeed: anacapa: Add additional EEPROM node for SCM
      ARM: dts: aspeed: anacapa: evt2: Add shunt resistor values for HSC monitors
      ARM: dts: aspeed: anacapa: fix dt-check-style strict violations
      ARM: dts: aspeed: anacapa: Use default SPI2 memory mapping
      ARM: dts: aspeed: anacapa: Remove redundant vhub pinctrl-names

Rex Fu (4):
      ARM: dts: aspeed: anacapa: Align PDB fan GPIO numbering
      ARM: dts: aspeed: anacapa: Add LPDB fuse monitor GPIO expander
      ARM: dts: aspeed: anacapa: Simplify leakage GPIO line names
      ARM: dts: aspeed: anacapa: Add SPI flash VCC supply

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts |  270 +++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1128 ++++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    |  435 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1078 +------------------
 5 files changed, 1837 insertions(+), 1077 deletions(-)
---
base-commit: 112264fb0bd0a7982b13da18cd3e289e2ab76eed
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>



