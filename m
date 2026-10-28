Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC5606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cJOTZA6p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR331Xcz2yfD;
	Thu, 29 Oct 2026 10:11:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793209046;
	cv=pass; b=M+b+IxkgxAS+Yo1Elqh8tl/ypEsuEzgerVcLg5nhIvo9eDu9vnPJdvzd3P68xkzNfgh/HOqR9CZs62V1xT+cOH2hPBeg3JHs4I3OkV7GcYVLW4Wq0hPS/nDYpjp8fyKpWD9hsg47c+03xNWAnHeYE/FtaYqRHTjVjQeKImeahFF/wuhr0qr6En/dr+6BW8mc2uknxO2EC4kw0C3rwcp/HHoxKHwu2APn50eXMDIOr5jSzEvOF2hNfIMZw7YMRUXO97NbDWuWuEWsVPFKhoRGFmgdNoZY8yO0EZvpYGpVnuqoSP6HzhbgFIZqBBMC06twp2hDseNP3xAsyuaEL77ERg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793209046; c=relaxed/relaxed;
	bh=rDyHVp+QqqnZHmevEMmS7ZiNzVNpGGibF3NXpA+9C9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfGxv/Xv2Yz86sdZsn9fOv7a9Boe3LCiQDEUhrwxReLVAaE+tSC7u4SUnCcmPw0zwPeCc0jgr4VUXNEbXWzCUrixznLVzJlEnfO8Uf/xL3t3r8DM8Yj1RQsaVAnzbQKphGDIExEGolL+K6Hkv4ssIIAiTOvnnWScs6myJ44bkGGfZxaXyTziAAGio4CIByRtBUEJsFh9Zahm2wFfgJ3ZclC9Gslwi44tbBRmAX9z+6spwa8Ys7DhdtI0Abu37RGTQoUNx/p01IqN9En7rxvkWYW9jSYn3vOWPERlAOjp5qPm7ZOSgSzcf3d+dTTjjh8JnPd0qkAuNHYf5ReXuxwcdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cJOTZA6p; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cJOTZA6p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFF1K3vFxz2y8p;
	Thu, 29 Oct 2026 04:37:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgUQ1Ce8QA0gaqRgFPyOD8uzitOo+NJWMD7fMmdg0ahb057nQ+EHzNZZA1t8M+wFG0d8f385qlrKbTtv7iWwaCn4LDNgF3VcYkKxPDLHfuiPpYOen+TGQHe4SZNq4u9l/SVpYCTrol4ZPyO/A1XRRZcuC8MqlIVcof/Umn7DuijWvUg8Ceg+FQeRzyubegawJ1dcy5qyYGgpONk8+IN4l0SoA1J5Nuu2FZyUhaqksffTXL0EiYnKQ/rK4H4dRNLdF7LmVwGytotJU43gUqFJXrtMItpqamvQiU03hB0QkmDwQGJyfKN7P6fLKB1h4Ws0HgleqHu+eJgqmlqsK/XKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDyHVp+QqqnZHmevEMmS7ZiNzVNpGGibF3NXpA+9C9s=;
 b=BZaRRpmQTPYx3/PSZnPw9bBXlpd3knTW4uKb1mak/SuCX74cGsiuH0AZzgkQeY04KQFcJQxSz9KMIEokNEnfKfJQDQSpu++74Zg9gUf6Py80kezco6DKlTAzirXz5IQwkeu0bJ6/Iyeekmr9ktm7dIHxbQ66X6PxCZTJEAVXlDnS3k2T9KPnwBS0CZrV+iSXvhsTLPFXxZGG4dhBpK9dh6tA54mDJQ3hjBto6XNuBB7EwqpTobXoVKlQl1WgFyAadJJkKMVY7ovt8MkGGBiKJzjX5GEkUEVC3tSOHvq/Un7mjr4s2qDpNe4n4fqMbVgYY+kpdZ7oxnYMoBrRtc8RjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDyHVp+QqqnZHmevEMmS7ZiNzVNpGGibF3NXpA+9C9s=;
 b=cJOTZA6pk0/nt/JKuArww9TBTA8s0/U22zLR0vuuex/SIXfWhHT1AzfZo0h1SaFTIPsXiIXlvEthohgnNmwIblujjyMFuQdLWkFWTxa9s6rmdEyc+9Y0N/mrI9XQUfgRFXGedj9HT9T6i9DI3LGrF5OvcUMrLXDg+EsG67RS2GHNFD+qhZHCtxsxL6VoX/Ew4KMcxq/APIBgvhwQLqhn9G+9wFYa0FYlIFgpH/hQ+eo6Vmz6jongXH9ZdCuKOXseZ4i1IOabGbNNwNJa8UngiymAV3i2hDLM5l91h8oy4F6wI2uaEK6S6DiKrsJToD7EyP6sk7O96jLjmUP/2n7MOA==
Received: from CY8PR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:4d::29)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:37:00 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::77) by CY8PR02CA0009.outlook.office365.com
 (2603:10b6:930:4d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:36:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:36:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:36 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:34 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH v2 0/8] ARM: dts: aspeed: Move flash nodes out of aspeed-g6.dtsi
Date: Thu, 29 Oct 2026 02:36:07 +0900
Message-ID: <cover.1793179064.git.jackyhuang@nvidia.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 3933583c-73e5-4651-67f5-08df351a11a8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|23010399003|82310400026|261021121427099003|261009223027099003|261022105027099003|10067099003|56012099006|261021123027099003|261026121527099003|6133799003|18002099003|11063799006|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
 MalJcWHA3KiGKFxk7kzWeCuBcUPApR8AXjGHOSSiOg2FE+QxZmI7uX3N6F/RtSMNtEzi0tZEECaUFQdxEghYRMfvEgMk5xBGDvOgkRSpXqCGdzk3TV2bxmbkLFGgH1dZooXc0Y3UlgbsBd/HVjvSNCxoyuK2bsyT+lS9QHbs1eIiuhRXZ4c+BiQAbjUddH2g3ahsDeJtUUUr3p2L5UCfp8+6I/7e/iucu8oLWoHCmQEe3yVSQxErnnJ2CaMqwOhrllGMr+GX0l1ra8IjaXvOpmHE32Z2ztyPwFtaZgV4CrUT26teZ3LuJTR+3IzT9goFaKP8374mmNLahmdgC1uILcvOWr+vsqKRgI42g/Eonwq4qkU9Kuv8Dv3d/JOVKVUXYBcCYpSrIxGgYhO8bew1cXyEEHAgXXow377gqq6SJtMjxcwPYDPuf6NG6td2nikhFh6xoT6kLfgUoBLy9bkTMm5zn3aG0a66DSPmzw4Sj+OsNrt0h1pU/pUvNeB+kBhLyo32zyPJ7BpJEBKuPA7d56fh50DKCVm1mZIhzSdZRjGnu6nTJitQTSdlZp/sss8e0szq+ea0SnPSV+rQSUD3Ob8EV604IMG7g3ErMLVGysA2bumaekCSiYKlBZ6xmPg40lC1G0KAOTw92zUG2rY9f8o4Vb419wbJiLW2tSjKLlLQRLx3CuyCRcAHU+97Mkt6d4m8PF1APVPTbsb3MPTccQ==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(56012099006)(261021123027099003)(261026121527099003)(6133799003)(18002099003)(11063799006)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 A2X9zIpUXuZaDMh10smKRGidqAHEGHEqXv+k0VYQHDuOvni3PMPAe5JGqSI8Xb9TC4qlhBl9wCEzawYCnyPartVNw86E2T3t9ojBbCX1H22j2vE3jh3BljymHyUfndbYsRTOaMDD5Ee/aAsiAski/MG0c02V1KvX/4G6pS1bceX7qLmgguq1wknetkGMIuC28SHCxDJ5mN5J/yccaM5oYO79AETmW4kNbJMiB4VvhRwCiNO4OPCWMj1HMlcct1aioDtHrhuVUBnWLp2fpvVRKCX3P6cil716kB1LP81Y5Dfzi7Gmv+myxj7qQ/t3jqGrIIUgi6MGtNZca1zvGjBsT6z2m5JJayCZt/c1FChZwCEOYryCoMsBuW6wlLa+hx+yaeDHTScFdQ99pUB1nAau4QYCKqGBBXARY79O2mjyiVym8Ts8J+ulIcSdJSnDJxTV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:36:59.0108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3933583c-73e5-4651-67f5-08df351a11a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move SPI NOR flash descriptions out of aspeed-g6.dtsi. The disabled
flash@* stubs there describe board population, not SoC IP.

Patches #1..#7 make each board or vendor common DTSI declare the
flashes it uses, and keep status = "okay" so intermediate commits stay
bisect-safe while the stubs still exist. Patch #8 removes the stubs.

Changes in v2:
Add Ventura2's four flash declarations to the Facebook patch.

Link to v1:
https://lore.kernel.org/all/20260813102233.3088939-1-jackyhuang@nvidia.com/


Jacky Huang (8):
  ARM: dts: aspeed: facebook: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: ibm: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: nvidia: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: ampere: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: asus: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: inventec: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: Declare SPI NOR flashes on remaining boards
  ARM: dts: aspeed: g6: Remove board-level flash stubs

 .../boot/dts/aspeed/aspeed-ast2600-evb.dts    |  4 ++
 .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  |  9 +++
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   |  9 +++
 .../aspeed-bmc-asus-kommando-ipmi-card.dts    |  3 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  |  6 ++
 .../aspeed/aspeed-bmc-facebook-anacapa.dts    |  7 +++
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  |  9 +++
 .../aspeed/aspeed-bmc-facebook-catalina.dts   |  6 ++
 .../aspeed/aspeed-bmc-facebook-clemente.dts   |  6 ++
 .../aspeed/aspeed-bmc-facebook-greatlakes.dts |  4 ++
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  |  8 +++
 .../aspeed/aspeed-bmc-facebook-minerva.dts    |  6 ++
 .../aspeed/aspeed-bmc-facebook-rainiera6.dts  |  8 +++
 .../aspeed/aspeed-bmc-facebook-sanmiguel.dts  |  6 ++
 .../aspeed-bmc-facebook-santabarbara.dts      |  8 +++
 .../aspeed/aspeed-bmc-facebook-ventura2.dts   | 10 ++++
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  |  4 ++
 .../aspeed/aspeed-bmc-facebook-yosemite5.dts  |  8 +++
 .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   |  6 ++
 .../aspeed/aspeed-bmc-inventec-starscream.dts |  6 ++
 .../aspeed-bmc-inventec-transformers.dts      |  6 ++
 .../aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts |  5 ++
 .../dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts |  5 ++
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  9 +++
 .../dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts  |  9 +++
 .../boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |  6 ++
 .../aspeed/aspeed-bmc-ufispace-ncplite.dts    |  6 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       | 56 -------------------
 .../ast2600-facebook-netbmc-common.dtsi       |  8 +++
 29 files changed, 187 insertions(+), 56 deletions(-)


base-commit: ba3f2c447203166c640e40dc8e9b4b91fc613aa5
-- 
2.43.0


