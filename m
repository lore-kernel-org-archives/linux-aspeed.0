Return-Path: <linux-aspeed+bounces-4849-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E16EC61DBD
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:06:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4gH15Dqz2yYY;
	Wed, 26 Aug 2026 10:06:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787654926;
	cv=none; b=cveIKaDh28Z0bUzYF9hbF91mUxR3ryMI1smfQmwEEE4S7gnUPNvDJeE8J1X8MhZud5nZwICYH1FbLjwz9PnpNhYBd/3/Yjklfk4nLEV/n7f44Kj7t2dS0BvgaSHA8v9eTaIrHYVoh6AD8NDvSRMkCpUhxLnCneMGWmQoGdCDvSnironPKxo1xBPN7sl5t5ozumlYrTEaMFICaUPkGTYzU1ynJfaAZWVPuitzwUCLgtAR2FavG6LDj0XnPhPvVKPrOfbocqyFRNjJGYYcFcbXJ7H4Syv77pS5wJH1ULR4dr8ufSSsP1Ks/b7LDiFyfo9Lj2rUHkaXEliINOfFsUzXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787654926; c=relaxed/relaxed;
	bh=IDffj+m4tK1QnvM1IPn2/npiwst27/9422ySz/IGqe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GHC0xgdho9kid9cxq+RGqC/Z1sBXrGNYmEX37NtG/99k6iliW6aOiSpf3v6mUG2e2rw6A5358D4BN2IjmKWhHVZJYPfKnQkh5f+ny902KZKiiL5ad1elNaY+K4q4uS1AQ06zeICd1gNMzn/D86LrWoDdcZyi53+wudyXHyVLkOYIsmBnW3/bNJ2g00QGzts2mEkTFBlDPZXH87B9wmVs2sMBJUNrvcFL4/60z4vcE3cKtZ/+B1gKniq3a6WE4aKiYBX1oe9apYsXE95MBmSDIP0e/vmg9x5xv8fbud8BewzbUbhLvHsZ+O+QuG1COBtY8e0QIi3Hm2NpAbIrFIpceQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WG6tSamE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WG6tSamE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkzJ0M9Rz2xlw
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 20:48:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EDFC6011F;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 030FEC2BCB8;
	Tue, 25 Aug 2026 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787654920;
	bh=o0quzmyGRCxljMKkEeEcNGFAJzl4IjiaNIjoQA/8CGM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WG6tSamEb8KcOa5M73d4WJVWA9DUnWJvqJhZe75jdVRZoiFAGB2Rg9P5lEudUrfMg
	 tLpi3vP2/obI/pRCZ3uZkzwJtE8aGJKolp+6pqhgLo2P+9dWHzQYEFg0ToVWir6wtf
	 fCl1e8Luidi13uCnxsQZpTxctNn2OF0pkRTf0SXlmVv6mWiJmBjBiYBKZqaLNq3IUv
	 7Zu/wGpkJ16YhCXAwXbE09OSMXZSY4uVd+RxvzOnoKL0rfoYGaQkT+gdB06l8jbE4m
	 IIFjZgMaX4+OkCDrI/dNql61bdh3uNxB32ktH/2q+MyXINwLXAChoNrAh3aq8/hbeo
	 ZAfXew3BmORDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0524C5DF94;
	Tue, 25 Aug 2026 10:48:39 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Subject: [PATCH v6 00/12] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Tue, 25 Aug 2026 18:47:41 +0800
Message-Id: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAM1yjWoC/43NvW7DIBSG4VuJmEvFjzngTL2PqgM5HGKkxLYgQ
 q0i33txlljp4I7vNzzfnRXKiQo7Hu4sU00lTWMLeDswHPx4Jp5Ca6aEAtEJy/3o0c+eB6qXaeb
 z4AutkZBumYh3Usigo5YKBWvKnCmm78fD51frIZXblH8eh1Wu6//tKrngvT31oMGiR/1xvvp0e
 cfpyla7qq3X73uqeeCiVg6sBPPH008PhNr3dPMs9hpNiC70p1eve3pOmH2va54JYElQ9IDm1TM
 bT+p9zzQPrTAugg4Idusty/ILLzUbIA4CAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654905; l=4221;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=o0quzmyGRCxljMKkEeEcNGFAJzl4IjiaNIjoQA/8CGM=;
 b=GU2tk4x2maAbeLgI2+uTftOtvsKs6LeMjSSdiTslJ31Xd/8jwcTOqu624c6C44v+JtqedNYjW
 O+RZqfvk1GBD5i6DwdngQsl2dtAZH9n37iq1UQ/+OCz+rW45C/WIvFo
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

Colin Huang (5):
      dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2 DVT board
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

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts |  270 +++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1120 ++++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    |  443 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1078 +------------------
 5 files changed, 1837 insertions(+), 1077 deletions(-)
---
base-commit: 112264fb0bd0a7982b13da18cd3e289e2ab76eed
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>



