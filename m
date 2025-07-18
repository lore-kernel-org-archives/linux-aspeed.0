Return-Path: <linux-aspeed+bounces-1751-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF8C83F3D
	for <linux-aspeed@archiver.kernel.org>; Sat, 19 Jul 2025 01:55:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bkV9Y1wPMz2yrj;
	Sat, 19 Jul 2025 11:55:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2408::60f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752880329;
	cv=pass; b=myEJI+hJaxF0dXl4KbdWt8GiFkHZX0DIMC15qKl/+UrMa8x/PZvCuYJQqTrZ5NCEzFcBgr75V8znCmOU2AVw0K52IJMqL7J7rR1Jxl8B20XuZjpWOtseRvbduk/8gPVznIDwRKkDM7ZPBEwQqCn3VpdFoYeuBbemZ+/P1FnGlOOGRaZdNiaDYjhm1j7/Y9HNBBuJEg+HU6tzyhUga5Kmp+XsUGsfF9xexdS5BvB8Xjs0pTgSCJYJcV4G9ISgnR4Pxdk+9mvAUg0pIC6yCLJwlcnosgZJdgTW5ntmUYdN21KsYJo1osxZtm4n9TnJHa6B5ds6M4OTUCDm3rB0s+hKWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752880329; c=relaxed/relaxed;
	bh=E3ATMC2qdaMcHIBiexPD9N/1El1J6XW53EiLP/4k2l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gbLw/qaQmXqwEj6dS3eFlEetjrVoPtTul2XpDTqlE1CF5wgNEAJIOnHT4r3v75NgNkGw7t6y1qmtuDxxvr5ZtszWb1uviV6D25TQwTk+JWpTx/wjWCT39CpAgQPWCgNX7VC56KWG4/jvJFpv24mDiM99EGC1yVWJXDunfQJnxprfdWU2kKTlddiVppQhv6CF8bPbNfayjF4SDSffFgHdlEypQE560A/x93b1a6atR5pJypRgQ08io4sQPKVuKlRTKex0L1RTsLNK25bfD/VMeQvqDv03GcBExbe4HtuCwhzUD71CggM0v759S4rQEReSOpiQcyNTYrIRJyRbbTDRlw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aYmXWN2x; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2408::60f; helo=nam04-bn8-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aYmXWN2x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2408::60f; helo=nam04-bn8-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2408::60f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bkQY2750Kz2yrT
	for <linux-aspeed@lists.ozlabs.org>; Sat, 19 Jul 2025 09:12:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJjjBHtlDbNW8+1gaZNcghmTjB8B7R8qsfk5m4dcIERbjvVBiciniQCj6MJlabrD4/GgTBanVVVHz3e1JXR1rPA4X7VroZgmPMzKgk78MLJy3IQSV9urXgMMw+qaRReoeS8gxbGGtZc8FCyB6ryOQrv7FBedBbUGieAwUYAiIL5UOSIPh2yr8DI8v4xrbueKj8UkcabIn6LWN6Vo1XKZcQkBBJ3fKC86Nhiwm9AJ2wudhcr0CdlbnBtUisSn8RZqmGKafkrhggtpcber9DSPC7SQtmEGLNpc7QS6tGtjR72QAl9HmP9r8IP7fEOJI3anPHE/+cOmiXSMqGO8jHKllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ATMC2qdaMcHIBiexPD9N/1El1J6XW53EiLP/4k2l0=;
 b=tjVwpkw8rKWnhPEVtGv1KBP8gjxr63nt8xKZxzmhbwu8R0qvk5dUjyurWSic8gh3e5g6vtO2R4Qs0jF12PYmL01+girllAm9apmipXb5/O6bBlv2Ecetw6iniAZKeZc6d2+xAdWPqQFoVtrLmvbEg7XGAGrKTI0XhXT+8pzJVVFbo1MBjM8DlLU4Lqo3S9JIrVX3W89uwNjcLlsuLbUBAbw/BQpQ0xnNiXrwurC8Y8tNwyNBQpLTWRHijCSAdR5rbM2KdgP6iTmxvYDWgRZ1IcEK9LwsTS+B6C4Q9bYb00olTSZrWH2N/QcyUHE2fSIKAZnvWS/uPBwDjKEM0hHPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3ATMC2qdaMcHIBiexPD9N/1El1J6XW53EiLP/4k2l0=;
 b=aYmXWN2xzc+Hyi2dOtGXDzaG915RIbGk6c4RmM1by8VtA6ricXm5eyme5AmgtxzM4tqbcsgBnSEXDlFqW/ukewbJKaoEb0u4AbIEtWZz5CwV4Vd1OW7KY3YnoRZ43E15uyFONpZ1Q2Towbr+dzkVtutNKebEsgpLgoGldlWpp7SVJkHJQiJYFMliNPeEYpDYdXmpQNY1krQr4t/efXox1lgIT7toflovhJ5dK4MDOhi+3UZ1a4TIEB17Uif+lY3pO1kQsyGqL8aTy5SMHA2/BvQU3i8YML9uSHg8yTHJspZDjAZwSLBSvfTNnf90HAG2oxbn32Wi5n1dyi1h1evi0w==
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 23:11:43 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::f4) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 23:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 23:11:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 16:11:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 16:11:30 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 16:11:30 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v5 0/2] Adding device tree and binding for NVIDIA GB200-UT3.0b
Date: Fri, 18 Jul 2025 16:11:16 -0700
Message-ID: <20250718231118.3330855-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e527a7-8bb9-4115-1290-08ddc65075f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W68IQpIv9M0D3SO0PGi0CZ0mBOA93TmM6bM5G/dzfJq6xtBF2sV0LjJbs1fw?=
 =?us-ascii?Q?g/Ga/gzuua7TWIAg4RiWAP5/IN7sJ0RMloEpDyJ02BZOF4VcWivgFGhKQO69?=
 =?us-ascii?Q?yHryMqypYkzs0PbxbXG4cSLMqdd1Xd0AM0npbvVOa0C2G6fc5rkBuILPiz16?=
 =?us-ascii?Q?fGIO/0LBwGAgWAYaoFV3uF2hw1Hb+zx36YvSvqdVOHW3dQcSUf/RKG8hrt0m?=
 =?us-ascii?Q?rLdlcOhooo5gPLdQlJvnIdrdKggsspJhqTXAydi83rfTOdbSHn3BxycYDCn7?=
 =?us-ascii?Q?ObzrYzXZ3LOJCMUC0Kqw2DYOLzwXB17QXGMGxJa8/nBEWmeAWWDLsvsAbXp/?=
 =?us-ascii?Q?lYdGbvOcrmutK9MgpGhCWqQXJASjwAaGZJ9TgsAGYrlaaolEqIxyTONwBnIM?=
 =?us-ascii?Q?g2EA3dWDiFpT8CvN6gF7ze9UhFoVAoHoWCXxX5e3gOSszjQVdrDI3s8IhJu8?=
 =?us-ascii?Q?zIqmAp0AUMBNIyXoE1E05YQZ5JnJ4MYiTDURSPD6RXRNq3o+fD5vQAwj94f5?=
 =?us-ascii?Q?u0cYZiuvJu8rQ5fTkjP5vWCMx/lL7FY0/VPojWz1vOQ4bR9GIk+qqUWZGnRB?=
 =?us-ascii?Q?Y+5RUECAeLsK7Q4RnqnifqN3soZ5Lnm/egnEtY3OfSiTgMaAo0BhaYZq5RuC?=
 =?us-ascii?Q?Mj27+vBK/VFZ/MIEwORWWztKfznhTsAyx4uNwmo7w7rR+DFm0rcDCdgt2lFJ?=
 =?us-ascii?Q?DDY+HBe+y2Tmw41SWzFtjDR3pnSsXoZaWufMxf3G9jOoLXzmHktYrH/ntXaz?=
 =?us-ascii?Q?ZS+7ZrQ/StgOM4QXcAlCReh0dGs+agp9vPVHXLVERWRFy8zlR6+OaZhBjaRC?=
 =?us-ascii?Q?dvgnWrUgGSLLUWRjkWZd8HRiiZ601xsOFWGWMxpg1p++vPQTfNMzOa9WIeYF?=
 =?us-ascii?Q?ZBgbjd/NEUW4HS1j3hk6gY2s/TVEGc1B8m/ihX2GJbNKZ3mIfjVCFINBD9R1?=
 =?us-ascii?Q?5uWJGWwMRcH6EAb1WEjirzFImSVo9g/L7NPQrSTmzYzDv5L1YoB+KhZwF16N?=
 =?us-ascii?Q?nxWg95Ru52Dnj9FYZIYRqPzNgLlXtv4HfXlgqg58hHgTCpl6mVDOH/IiQuG9?=
 =?us-ascii?Q?3rFqS1YNNQQeKtTXIRRNttUYWs9DDtIi8e9QbiuLHatpnle+Q4YpfuqLu21s?=
 =?us-ascii?Q?OnTMPlyG7MnmG5ClAQRc68uQP8+eLcCHe+dN6YUXa/9B6nVHGd7BGd9oCDjb?=
 =?us-ascii?Q?Tuv5ZHzmd2Y++fcP/O/dLkaJ/rAVnZLiMgh5cTAud0w6hgTjYqHMm+9yk2XS?=
 =?us-ascii?Q?cHFssOuUrd+bV5Bd3xMzQhpn+P+XV8lFB+TDlfuYnX0bZQJVbiHGMY5x5eNe?=
 =?us-ascii?Q?BacqWpB1qPRMMSQOa1RCxCRbKP0vwUY6605kGXX/a77e1n8UIB8P+k1YogPF?=
 =?us-ascii?Q?wG7fJtVm0YJNE/NJ1holocU1qlCkS6SWfeJnbAMihxQKNz8AKNNxWlvuXHTG?=
 =?us-ascii?Q?wd9DGr/PJYN8CmTSChZspQqZOukB5yh4al7O1TE9Y3QAFfIt65YpyJwlDHhb?=
 =?us-ascii?Q?hZRRlkE7YCSjzn1dxAoSiPz/iPM1D7MfcQUe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:11:43.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e527a7-8bb9-4115-1290-08ddc65075f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

Patch 1 adds the binding for the NVIDIA GB200-UT3.0b platform.
Patch 2 adds the device tree for the NVIDIA GB200-UT3.0b platform.

This is an Aspeed AST2600 based unit testing platform for GB200.
UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
differences, additional gpio expanders, and voltage regulator gating
some devices.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
Changes v1 -> v2:
  - Changed phy-mode to rgmii-id [Lunn]
  - Removed redundant max-speed for mac0 [Lunn]
  - Fixed typo from gb200nvl to gb200 in Makefile
Changes v2 -> v3:
 - Fixed whitespace issues [Krzysztof]
 - Fixed schema validation issues from my end ( there are still issues
 with the aspeed dtsi file that are not related to this new dts)
 [Herring]
 - Reordered to follow style guide [Krzysztof]
 - Removed redundant status okays
 - Changed vcc to vdd for the power gating on the gpio expanders
Changes v3 -> v4:
  - Added changelog [Krzysztof]
  - Added nvidia,gb200-ut30b board binding [Krzysztof]
  - Removed unused imports
  - Reordered a couple other style guide violations
  - Added back in a couple needed "status okay"s
Changes v4 -> v5:
 - Resumed my patch after a pause
 - Don't plan to make this include of nvidia-gb200nvl-bmc due to some
 platform differences
 - Fixed io expanders that weren't gated by the 3.3V standby regulator
 - Fixed incorrect interrupt pin for one IO expander
 - Removed some IO expanders and I2C busses
---

Donald Shannon (2):
  Documentation: devicetree: Add binding for NVIDIA  GB200-UT3.0b
    platform
  ARM: dts: aspeed: Add device tree for Nvidia's GB200  UT3.0b platform
    BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1027 +++++++++++++++++
 3 files changed, 1029 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts


base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
-- 
2.43.0


