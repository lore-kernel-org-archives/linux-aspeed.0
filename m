Return-Path: <linux-aspeed+bounces-1816-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8391C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:47:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnW5X4JJZz3bkL;
	Thu, 24 Jul 2025 09:47:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2416::624" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753235008;
	cv=pass; b=hUnzTfefxORtd1xn0WOtnH0ucYyq92NBtgTg6RUefL1aTxl5g34UmP3atBe9scZuVYJAQuj8HLDKh3xIIwCMksew04UKOmDG3QA+OWw9LQk97lB1n/I5uQUJg3U/D9CeSdLoDRjWHsgOHRJpChly+wqlZ4AD7qy0Lhl7oFHUwz4+mqW9dVm6cT8Y+qVsZ/acplwdQFmCVGsOIiSbJRYadq29Qyk3X3P/U7SwjSgcCjXz6XK1R8w7qsuUNiKXFXV98YPIcbZWTt4JytDnYxnq7NF4nzhDjiR3OlTi5wxKHjZ47n8M7/28dRvhTxN9HmRWkfiER4Ve2NwAYHjFKcUolg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753235008; c=relaxed/relaxed;
	bh=FfVjNGzvlm3egc816w9x32eNreHp9PYIFit8tk7zBAw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MpJxw05Zz/HqB5pHwYwvIGRUq1eZFmcLrOPjh+n0MTYCYyd3lfM9253UJMhdlnrkYz6+PdHlyLKHf1ZYTh+hUb/Ta3Nav+UvdJ3zjE4GFH0GRIxm6GlrpOPMznOhT9k2w/b2bViaCmVdPTJLrvLmA4o/CAblrUsdPiSgBs1h3dmDF8jJjFEyUXcFCQNnujzMXJoDDfIECSxWJ+p4qiAq4I7YgMa0TNJ+Qz9vx/SdhFs38JWTLN9PjSLQVSfTcWxWr5Lj5l1DgMkGXqXeKX85V1UJqS5j8I8MeokVl8lgrDxazaBj2VNrSU0xQvgcMPbQtF1v0gX9qt41A89O2y78rA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y2QlOPTh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2416::624; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y2QlOPTh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2416::624; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20624.outbound.protection.outlook.com [IPv6:2a01:111:f403:2416::624])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmxjn23pbz30Vb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 11:43:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhvPrKv1xzSefYgnVB1mPgTAGCULLVskkEhTTYNGDUDZNWP1STsxcch90Ela6tBL4YxvkJJ4tPJ44t6dzMKGEbHfUp3vqmTlVt2apozKcHrBOZzio5Om2yYHIp//YRw60skK1qaTAdgGL8q/3bNQnXasF+ZoWFB/v/gdfGQUrER9E/X3Ab3+XF/nHxwOpXtGoNy4V1UxpQjRqBn7LdbCves9fdm9fY+KKGm9WDfWGcRyK5I6QTCrMyJyCKTTus5ZP2btVLPIW8gWgf+0U0R/6DMQUw0jnb7ArjEThPop6Dy7UKu7IEzPWp2XU7m0RCPJmdox8v4glfX5Zyh3fuLWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfVjNGzvlm3egc816w9x32eNreHp9PYIFit8tk7zBAw=;
 b=OHJ5zOEI6MBpjBewWWG5nJoB3awHuEuuyoavEIs99UuCa4vrZc0aOPT/NTrF0Ud+DiY5sCaNEwhFnINf8/281tYzn7C7aOnYk1nek9Vpk3f5nzK9nogTmjpm8dSV+OQwQK5U1JiXEWIS3XTOw5urXMQG0tplesEdFhqSPjpwkv7iaC0eoPPiwugsJ4mSJ6CIXiBjVmUI+ZfGcsXY+t4K2gfq89hU7Wp9WWC9j2d8meTe/gUIxxiGUdM1Hr45EIQMigUPxTEAI+9sP3vDmiYJXhmCkWmQXo78goodLJFAxZPi3x2Dvnzo2LCjhzg7eLJqcSznRZ+yqzII/xE4pcXSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfVjNGzvlm3egc816w9x32eNreHp9PYIFit8tk7zBAw=;
 b=Y2QlOPThE7U0MhpDnNZIhZKxUGfAoHDgjez4ToRKq6gCHkxIcrQVAHYYBC3hkkKzdxRFZOtEEymsaN5y7bZ0/65gry4UQzjS9Tw7e/FzUdmZ9v0gbaf3UDG0k0T8Lr+qP4Ujn3fn96Oq4QJGi+RMOEq1N0sdYxMqec4gttnpR28wOcF1M2r7yqArEac1vyOk/eOVjS4Ik0ADMY0i6fT1UGka/FGC4nkhcc6o10eLC5sTJnCgqMQzqd/ITeCMzBR7EnUV79y0gEsPIWZX/1tri5ENWfSXl+ssIEuu3zn5Iopmj8yEbWOO2n74C9U367zuIgq9vWQyRz6ywAZbbYUU7g==
Received: from CY8PR19CA0048.namprd19.prod.outlook.com (2603:10b6:930:6::8) by
 SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Wed, 23 Jul 2025 01:43:02 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::ca) by CY8PR19CA0048.outlook.office365.com
 (2603:10b6:930:6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 01:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 01:43:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 18:42:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 18:42:40 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 18:42:40 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v6 0/2] Adding device tree and binding for NVIDIA GB200-UT3.0b
Date: Tue, 22 Jul 2025 18:42:37 -0700
Message-ID: <20250723014239.22667-1-donalds@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: b924ce79-564f-40f2-7967-08ddc98a42ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OpahfUZ8/t0JxzWj7DIrwx9xQxlIKVFcXb8U0yIIsqMO/ePjP/gDKeF9fD9e?=
 =?us-ascii?Q?Ocv0uFBC9uN6ubk5uBsssWnSl+SFHd9spd1uJ6Fu0p3FTOgGljd0JVfHpoZ1?=
 =?us-ascii?Q?vvrfDlQd/d7hFb2xVr3Bs/7OWxxlNafOIjfajCltwq9qusnVa/hOUmsiNML3?=
 =?us-ascii?Q?XLib6DP6nVdG7ur3bSNVgSlb30WOXHN3dxmDw2evU6bWZ4U7hxoVRqSlLHHF?=
 =?us-ascii?Q?KYjiI44f9XhhBRfDtDDEisk++1epbqf0v/e3uV5m5ushqvL/gfv8FI8i445+?=
 =?us-ascii?Q?RPzGA6nk/cWhI4PrJu20QvhKWr05Ds5cDt4sTlxWK50x32Ew7or+Q9JLb1AX?=
 =?us-ascii?Q?RSh9u9fMl6+do0cg1zqEGK3ArVdlpFKJ81Nlr3r2EOZVBABikGAwxYNyBjws?=
 =?us-ascii?Q?cGP0EFkhyFYQKJFoD5xkBN0HSgv9YJ2JFDiE/sy9KYA9A9zLWfpzp5wp7ib6?=
 =?us-ascii?Q?FunCJEO4l7FaNciOuySZRp2KZg9bGkwQH4djiFpkmzqpWQV7mjzYHN6pgZkn?=
 =?us-ascii?Q?Kg7eOpSqr/kbXOXWjzMbd6QgTMbnHLsc553lsmQFYVhSBnd8yYJCd8zU8wIZ?=
 =?us-ascii?Q?ew4o3APo/nX51sygi4XHDD3sy6R7dtchv0hhlEXaaG1Y1pvX+9nsF2UpMbqi?=
 =?us-ascii?Q?prL3l1/olZdRPKz+La2c/ibq/VhnPknB4lJQ7iYz+9aRmS/wY0n3d8R9opbQ?=
 =?us-ascii?Q?Ej6Bgrr3WOkFFS+C4nTDsddrihiDCy7Am+GX1s28EEhalhw4QXSLFLV2JGjj?=
 =?us-ascii?Q?PMArkXTkSi9L7wOZ+NKhZTqEiOwzDPvsEP8Q3Yufa2/sNppfty1auVw1EFmx?=
 =?us-ascii?Q?UdGCVqDNmGJaE6i70cQ02pkK3pH/dA8/by017T+jsQus6OizRvpM31vqE+tv?=
 =?us-ascii?Q?aSJKNM46eV4zGLozxaf7TiOd3jWKSdlzlG1Ad5Osl+AMly7JtNG9qqQpqWcC?=
 =?us-ascii?Q?m3V9XEw3Sc5e9aAByYVaWUzM8I2CSs1HIv4XSOQOn38UbIsqQTJ6ZUd/IzaG?=
 =?us-ascii?Q?MKjSPfoVwapdQAkYCQlmp7jesKELCJBnWV0G1iLKB08UzzTDdRhmCKPGBGw8?=
 =?us-ascii?Q?7FnttWjXYaC0/RZ8SDIUlgaKuneTwjXHI7tXzrfggptuBF8Yxvlk1ScrFIfv?=
 =?us-ascii?Q?Lu+VQOby6eUB2bKb71ifhnUKeNpC++DH3aNLAojz0igxoNpTTqUeNrW5n+zF?=
 =?us-ascii?Q?g72sY3RsAKDhIg3epsEKFX1r8qTM3k5+ToWep5nys71l3z5kuABAeKB0clH0?=
 =?us-ascii?Q?yb7RcG/NA0IflRqoHYrJ7Zp1yfmrVPutffHyL64aq6GKpmLJuuGEOXzFUy5y?=
 =?us-ascii?Q?MaH//eSC2s/FG43VQAu/TLUWvRb5NVyER7erAU+bsGRXEjZLs2WOScVmUlAU?=
 =?us-ascii?Q?ny1r5nrR8MrIGMrO1PK7uJQyH0BgSEkszVf5zK0H0LalxjOAGYdTSW7Az7FE?=
 =?us-ascii?Q?Owtx4qgrabiZaHrhIep3TCx44wgfUxBG1yUeTv6vwl9kYp3c0wjxWzVE6zHf?=
 =?us-ascii?Q?SrtvgQiRH0phr8pgvcSSmLge8vxj8Ilpsr2z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 01:43:01.7461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b924ce79-564f-40f2-7967-08ddc98a42ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

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
Changes v5 -> v6:
 - Fixed subject line
 - Added missing gpio-key compatible type to buttons
---

Donald Shannon (2):
  dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
  ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1028 +++++++++++++++++
 3 files changed, 1030 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts


base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
-- 
2.43.0


