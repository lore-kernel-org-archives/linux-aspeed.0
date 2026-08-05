Return-Path: <linux-aspeed+bounces-4637-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83290C55ABF
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnSp0YFwz2yjw;
	Thu, 06 Aug 2026 09:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785934991;
	cv=none; b=IAs/3ZS5hV27w1z3a/U2LTOWUZCZ92MsSkAe/X3PUIIWHq+nDoKAWtkafCp+R9FHWxl6FkdFDm/7Ep09SEaF/XpDOTwwQi4q2050Kq/C768dgHdZn0tUDh1uihxQDz59mNIS1kekmVKf4XIzPvKglnafv/+9GP3VyyL5h96oy0OnHnXIQLVWj3l5gZ8GoPvQ+H+Tx1rmwdl7HZj1s+QF/XPhZyPe1A3ekbFCWqknhm+JIvhp/MprCU5/DJ40rPHv/I0COyOqCoSEWVzvqf/bbekmOxwog+tEy2U0ougRaIVceVTAa0SptznwygByyAj6x63Lr0gx9HDCUHuam6RXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785934991; c=relaxed/relaxed;
	bh=TsToUmNoeBgrbjOgZX1nld4aTgniXbr44AUxLSb32Mc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UgLb7Kv2sHcS+lV5oZh5/vWxVsRnc2vunmj2clzBxX6p64vZChIf09Cy/okja/EGc/qUEHwb2oMgdQxL89V69kfis/iEOZtpUd0V3l5f0HZ8+V26UxYzuhSMR6JdkT30tLPCXNm26TOmZN4CpVAIMd7pqcSCh+ootcmI2p0Z877CxoGkg4l0htDukWHrB3pOWAdZ2bVslAdrBxNEDVZlKOj8XJLdDT0KsjbDUVANi3FIngKudr4OESLepnrqtdJIMgJ7MZ7cFvW91Isp7HnUXcqbGY8Uz2HoEx4jiD/6aR2z8E0P+VVERgBWjLyOR/G17H2I9p0kJN9y9Iduw6MLww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b6u66+XS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b6u66+XS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvg0nj9z2ySW
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F013242E7B;
	Wed,  5 Aug 2026 13:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2B2EC19425;
	Wed,  5 Aug 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934988;
	bh=bYDdWSVVTiG5MK6NhiClpB+w+7wlTNEHoSs63MTDrVY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=b6u66+XSuX2JpJNoqebmDGmCCC2fAhfiOkGGom1m3S8HNeqUQ7mVWReDKbZmybdWy
	 Z1FfDxUWghRiDva/MocNsf59o5odsgrOm9urFZmYFl8r6lYHkFBCUl1ADWWOOIWxXn
	 5JHFr9rvv7yS8DMXrg9aut4L0OGxlmkxgiT8yQjYacYRjHkX4Jb+yR38z/IpGkamqU
	 Gx4YH1V/A1j5Bf7Q2Q7Y0Jf7x8E42cp1jySTQpYYKxkaP2M2F/HDvf6Y8fw/4yWokE
	 FllRKIiwgklGn6Qkl44RbTeA8LuytatalwfuQUJpHXm8F/SRZ7UsTAxoegotkB5Eu/
	 jWfsJSH/ey2Gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D334C55ABA;
	Wed,  5 Aug 2026 13:03:08 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Subject: [PATCH v4 00/12] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Wed, 05 Aug 2026 21:02:28 +0800
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAGU0c2oC/43NSw7CIBSF4a00jMXwaKE4ch/GAV5uW5K+Ag3Rm
 O5d6kQTB3X4n8F3niRi8BjJqXiSgMlHP405ykNBoLNji9S73EQwoVjJNLWjBTtb6jD100znzkb
 cwgMuAZGWnHEnG8kFMJKVOWDj7++HyzV35+Myhcf7MPFt/d9OnDJq9M0oqTRYkOd2sL4/wjSQz
 U7i2zP7nsieqhspaqW5qn48+fEUE/uezJ4GI6FyTe3M7dtb1/UFz/hTrm4BAAA=
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>, Rex Fu <rex.fu.amd@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>, Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=3300;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=bYDdWSVVTiG5MK6NhiClpB+w+7wlTNEHoSs63MTDrVY=;
 b=JpW4raBNri6sH3Ja42DQW7J3vx/7RUB0HXn/GLfe3sG52WMvc65kv4VxarMyU30IM4cLoixZE
 DKEe+jKGXLvBCGXdk62DQ4vm/qPb8gSi0HzHW04zQrhGXZFzG0RA+N/
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

Colin Huang (6):
      dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2 DVT board
      ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: Add EVT2 devicetree inheriting EVT1
      ARM: dts: aspeed: anacapa: Add DVT devicetree inheriting EVT2
      ARM: dts: aspeed: anacapa: Add additional EEPROM node for SCM
      ARM: dts: aspeed: anacapa: evt2: Add shunt resistor values for HSC monitors

Rex Fu (4):
      ARM: dts: aspeed: anacapa: Align PDB fan GPIO numbering
      ARM: dts: aspeed: anacapa: Add LPDB fuse monitor GPIO expander
      ARM: dts: aspeed: anacapa: Simplify leakage GPIO line names
      ARM: dts: aspeed: anacapa: Add SPI flash VCC supply

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts |  265 +++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1079 ++++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    |  408 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1077 +------------------
 5 files changed, 1756 insertions(+), 1076 deletions(-)
---
base-commit: 112264fb0bd0a7982b13da18cd3e289e2ab76eed
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>



