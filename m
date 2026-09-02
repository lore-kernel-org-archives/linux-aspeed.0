Return-Path: <linux-aspeed+bounces-4942-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3249AC624DA
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:23:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0gT6QhGz2yqq;
	Thu, 03 Sep 2026 10:23:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344552;
	cv=pass; b=C4J39x5wrOTUcb+KEBn1aSZ1RPKKs4/yRw2R7hzRgzFkRNzWK5aPHcRhklNCueK4lUgFuFhGYbzrybbS8wTubTSLzv3YNiM/byCFXbfLPPBvbmtGAFFGjGYjbzi9RLYyf8k+OkxufbXcBXOq9EVAji91A/ANOV+iaeAupzdZ305Q5motT46Lg3Yx3G4VkSiW1eybQVl8xDJE4E4f0IIGXpXXmO33XOtMSqQ0tKZl30TP0B0nD0rke+GMJu1khHl0VQW9XNNexXtTyBO2Y4ur8t+8MezugY5eMhh4gHZXYidwLarQ47j9IR9mvs6jBgm8UfbYrQiheCKaVrM600VjlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344552; c=relaxed/relaxed;
	bh=6wmzsCPF0VUsO41zOBFakLqO8T3bwqWZUXiNYOXTJRQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=C0kgMZYNlossn7poqo858TohsmR38AKo6noihhLc+AcvWVDlvTC4wsYf1+29zhUAKXYBrdwrkNg8HbvpYk78e/m1e8CiMsSORoMrCVMXIVAeQhFJ9TETAcSMQWQtctDtyCCs/Sc03kjQ5Cwb52eGL8VKXV9DX/JtOC7wrdKciMJVWxJ5uPDntrbbfBE1EJ+GlG12zFmj89e9MdS7rtiwe5tzZcM1GY81w3cr67r6l2r9hHfFZjsTMbDKRGfIeXhEJ0ArlVleiW0n14iJjpFmSESD1AHp10cNuLUu7LGzUerj7S1LFT8PQQJx1sz7IEeK3Y9kIr2JOm0Z308Ncj5Odg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2Ev2g5+V; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2Ev2g5+V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1K3qykz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGXCrlFWzJqx/4wWjurJTpCIshBU5OkAl4xozPRC1JqdN4v3B5Qrydh0lfftDWh+RokCrDGOKw8jqT5CIi2pVXB1qvo/3Es+P8cMLCoCg9/o2epGmAf0Ajf/SqVEsvZSGdb/cBgdwKatIT4GoTnphioRg+lq+XTh0JcgiXM4IfQRXy0qYj7FLvblJuGoTmnnWKPei0/ISxNFSDaGgbSJWJVfmaGTkmu3crk5fQcYmVRtOmI8OIwQkBjUFiFpcKifbm//XxV2n2kl0VsKFRKzUF2WJTibURY/wCzCamW6obIeMNCWulmw3HKD/JRkY1wR2rlF3iPuEHEwHEiY5oZIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wmzsCPF0VUsO41zOBFakLqO8T3bwqWZUXiNYOXTJRQ=;
 b=zMNlnu2im4ViqRYUkx9R0gS4LloFXGdxE5KaUOCVoqNStzOKVwt0JjlzOuvmAU9xM7AmAuxHntRa5iVsrODPVcEi1ATwOsmeirfUazavjZe8GWrS8p1WRHTEioESkawKI3tygt6Go2A8jG4UJFyUo3rMwfDKTOQ2xvLCpmUvDsTq5b2XYAq4YrfNpm3SRA4Gef5r9aXdXQSpwheI/9bN3cKH+SXAIO552oFDrf105t2hPaLrj9YKwAoS6QfDoZogEA4XTWH27GlvzGhDDadMT6WAjXrQga8n5IRMchzWexC6EfTg3qxa6rLa/0f1222XEQ63wliYX7KxLrOjA2rzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wmzsCPF0VUsO41zOBFakLqO8T3bwqWZUXiNYOXTJRQ=;
 b=2Ev2g5+VKv1AJVj0Iitq/4JTvXdq4YLabJCN2STVK+OLWPmqTjQSjmcZ99B0azC1A9eeCHkbFwI5Vjglwzp5uj7v+XjmDi0fFC5OhnD9Q4y4mYvVoDkXcSHrzoC6xXE4RtiC7+WbtkmOt9BzpbPTcsRy36Qs6gP/EFVngcQOO1U=
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:03 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::94) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:02 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:21:58 -0500
From: Colin Huang <colin.huang2@amd.com>
Subject: [PATCH v8 00/11] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Wed, 2 Sep 2026 18:21:12 +0800
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAJj4l2oC/43RwW6DMAwG4Fepcl4mJyEO6WnvMe0QHFMitYCgQ
 psq3n2hFxg70OPvw/fb8kOMPCQexfn0EANPaUxdm0P5dhLUhPbCMsWchQaNUICToQ0U+iAjT9e
 ul30TRl5CIr4PzLJQoKKpjdIEIiv9wHX6fjZ8fuXcpPHeDT/Pwkkt09ftSUmQ3lUeDToKZD4ut
 5Cu79TdxGJPeuv5Y09nD8va6BKdQvvPM6uHoI89kz1H3pCNdRl9tfeK1SvBHntF9mxEx8B1QLJ
 7z248ZY49mz1yYMsaTSR0ew83nn5hP1z+AdYHHbTzxHvPrZ4Hdey57EEVnYqaQcGfe+d5/gXSj
 hpPrgIAAA==
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Carl Lee
	<carl.lee@amd.com>, Rex Fu <rex.fu.amd@gmail.com>, Andy Chung
	<Andy.Chung@amd.com>, Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=5239;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Ar+d4mb5Bb58qe4Oy6QHvm7Is/Mxy2hZWcbg+BROmgE=;
 b=/J6VZUvQFPu2C8WKNoIMMoFK146LCwU17Ji7ZHasFP4jbdsmkNKw9O6NtfI8OuiWUxM2T2Hm5
 iqvYDdXXlCHAL1OEPXoqIx2rDb/yLQ9frGZRt9DWbUa56in4eFJbFiF
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 13da894d-e253-4e4f-d5bc-08df08dc07fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|13003099007|56012099006|10067099003|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	F7dI65Lf2KdzhrFZ9LfozQCvTMc6UpSiWj3S9gRKHHLgwlbWueEzYkluDgulB6yuyJz1ydI2uW42EmFRQUhgtD2QqQlBubK+fAGwHUQZHgewCv1ONX2FltfX5YEzzVuG5W9AFM/NpSqPsM7iuDnBxoMPzjwiT6khtw9nHZUs7wWGijZTmR/+pJOhXrK9/gzdsJQ1mzUtRbA0fkxQ1ATZst/+azuVjrIdmmibhH0kqwpJ7pEhwFQSqtnRpXEebQE0jSSrW0GWVs4CdmFTexTm65HStdP0atln09EYl7FDfPWoNWvlrqPf9X0yNR6mqG8EAy2J5ueyuCO3Hq3Yorp0xI7R2BXOVBE7RnoQL7yZKovFWg59JCv5HjpIcgxdVj8VE9qwr0VGbrnnlDL6XsO7gWJ4gZBqTSJdTOsNoU8TyyaEjlVzuhFR0txiucbaAILDbwQbrt5xkCvtAxSmJqntx9pDK5p0wOgAO0cNHuisK3Dr6sQGyYOIKav8xGraJacI6oNTnFYRBd3Sy9TOzNDb35OiTsT0cPGCDe1CjxrGyGUPdGetA5toyiXGAeTqsn7JYYUwBskuIabOp2Wizrl4QBuMdrKn6RjMJmG02va9E1TQCPDLK9IW6MhJTslnlAr/3x9DDo6x5hxg5uBfHcP3jtynXWaIVQW/M8wqGw0WEDnWzUBVgluhrdaAm97GPwsuDLoV+LGsdP25GpStr/mH3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(13003099007)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ALm916Uy8Ao73gsPJEHeS9BSGOcSd+op60O3USLSxXJTw8HRVqG0np8ajt7WpHzZ5BsSkXBdJOmobszj/5Hh18iP2ta/Rwb+Huum/hCH3IC08FlN5TnJApp1ObCfbkPFv8+ulaXomD9deZJbSqPWEIHFi8u6FjXzlirL0tILvvJuqlWK/ACVBFhB2B4mp9L32ppHt1WJRWZqb13GBxj367uUFoXnfDWHStTTh6VNaVL46Rt6sGvl5EMHTcMWuy2d/FoCn+c5d/eBzP44R9BjO41alRwnFT3JCY6rymoi7XBDq92P2iqdHJ3I6Zuhkj1C4Lh2iwwhgr8+p30CzeOLyJT8b62VVDf8vxCelADx9HVe/3jGTTnbmV9eTLvoIY5SjI+b7ysTd7vl16yBHYgmxZ5MzGXMlOKhghfw2NkM0uWHSZDOkc79KAOnAqczd+YT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:02.9435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13da894d-e253-4e4f-d5bc-08df08dc07fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

This series refactors the Anacapa BMC devicetree layout to better support
development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a platform
entrypoint.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Changes in v8:
- Fix [Critical] The board compatible string was silently changed from "facebook,anacapa-bmc" to "facebook,anacapa"
  , breaking dt-bindings and backward compatibility.
- Fix [Low] The /dts-v1/ directive is improperly placed inside a .dtsi include file instead of the top-level .dts file.
  Move "/dts-v1/" into aspeed-bmc-facebook-anacapa.dts
- Link to v7: https://lore.kernel.org/r/20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com

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

 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    |  259 +++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi   | 1130 ++++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   |  407 +++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1077 +------------------
 4 files changed, 1797 insertions(+), 1076 deletions(-)
---
base-commit: cd7d1ef7d74ed5f5a1790a40389bc38382924556
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


