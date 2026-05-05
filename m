Return-Path: <linux-aspeed+bounces-3997-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC26CD13DA
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 May 2026 05:06:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8mhb4b1yz2xmV;
	Tue, 05 May 2026 15:06:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777957615;
	cv=pass; b=UaVqQMV6qipd3bi7blfsXKddngi+peHZTQWRAd66emHiEjA6o+/R9NYAyWmwvlW2IpduQ6+n7rGDk5I8/91qfPwSkFDiHz6oCj4JWBHS3Bw0sPwhvILJDmGxyhjl2SMwJBymI1EOzcVHd8humPoJH+KS8G6/JRmAqR07BURN7iMAXwgqVf0NxQP8q82ScyTK/J+yHDF7MsEdzGSE830FcNeB7HKhqL4lSjc4l4ujKCBmGiLT606PtcFYUPT19AJC6mWRyZqzOugq5AGqxEBK1y12NGklH7m13+BkOh+vJGbPrjk2/D9fV9c+vlh+DJmPmHRQ+UOLZfv4XcCl7I4z5g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777957615; c=relaxed/relaxed;
	bh=UZ+/DcyS/sCFYJPcmZLwMT+i2GSiUHXCjea+zEbIWnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KM4SXXX/2ogAqyWX3tD1O97kXY9NF0wMZorInbTa2CeHme8ZAb1xjaOQrCvdRGH2zC8UqU6dvwIyts1TMSWKHEBldiGPKPDpkJG4ZRhEdECj6pTHgcoPw4J6T8btzu80DeaIDgKIsPksTH/GEhe3OlnXRzcYuScIaUPRZ7qc8n1lcUDhCuc5f+rw0sQIXVMFOzeERyMQ4kdp5ubJjRKJD32moIOvmSCxZhEAaIfHnj456Dtj72IL+EIdFokZ8rVustLcCyr54YJW3iyX3+BA6GKqSpUu4SCKHJESEMc9XMlcgHZgnj/to2gbv7ZcLZOlLHgvjogHMupqXuaIu0waCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HegHfLG6; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HegHfLG6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8mhb0Kskz2xMV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 05 May 2026 15:06:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ/DJa8h5uweJuUB6ZYEW4nehmMJIDEvF5c9o24mz9mj7S6fo3NOXjvarkZMrhdVtYLhc0nChOUntERyDAOp/3opzLnVEUwbCekTVMjPKpKKY1tXRqaEqkizqGzFVnD/GBqMneZjaB9zNzRFoOP1EdlapIWYsEqvnWutCG5UkfrsUgNsDKk5BGnWy/OszxBOkrZB6Rfm28iXGZqakalKCFI+8vwZSXjVlo1d1xpJHQKVADKlzc3CbqSdDsKktx9IP5KJLqQgbrMrMQ0P4GTRWaya6sThVdRMXTztAPJ7ZSUmQ69cew4TYHL6f5RLF3a6L2tgQ0UZEsgI60ua2a/2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ+/DcyS/sCFYJPcmZLwMT+i2GSiUHXCjea+zEbIWnE=;
 b=ZBjLhSfGx2mx8bJGukFZoXRevYPdugsBoKuQTc/TdIGJ6N8oRwJ5ms4MOAv3D8DCzA56B7fKN/sPfdS6EbOgztpsr6ePuEVXlW0Bj2d0tr3thzziMbZOLa+Lpq4mmdmf47NoSKz7QgqFXLRA88/fRAscvufYxeE/kkoBjTmTvn9YIi+wnh5P0LjmeVUSKASwblF43ZJYLmItqTzh5VAqJZw/s3S+v3Kg+zx0W1xjn722tLEgTvEYdIP2kJhUwOW4fivw9cPkVyJ1Vl0rfR1SUMAkreOwiLu30SE0eyqzjCXXdiqQR8nFJKZDl2cK1yIjaRDJpdmn+SthAUCT0rkArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ+/DcyS/sCFYJPcmZLwMT+i2GSiUHXCjea+zEbIWnE=;
 b=HegHfLG6u0ZkOcifYZ/AAYWF5AJQ4fi+B+80XiMRTUv41CLUzccf+IqPmBvmlEhyMMXfOe4ghSJkHh8fyrXwEZl+g8DVc+FPQM2rWE44BX+FVpas+MS1FQSj2enu5s8inr/6ae0k0KT8eZnq4YhBPzGnPoBiXH8nZSty539oUEaMiLuiYdzGuQW2+/OFiWJPZp/IxObXfo0nqLT7Bd+JRl7ryn8ZKgYYyNFlLw5/72gkGrye/4dcXPazsVJx+msy4TNErEysiDXu2AxMuhdBgJupUHiqYErw1b8w5OMN1d+owigvL9njaegX9iKsbCRWC+Vi9l9K0xcGlrF+lkTb3w==
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 05:06:31 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::cf) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 05:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 05:06:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 22:06:06 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 22:06:03 -0700
From: Ender Hsieh <andhsieh@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Marc Olberding <molberding@nvidia.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
Subject: [PATCH 1/1] ARM: dts: aspeed: msx4: enable BMC networking via MAC0
Date: Tue, 5 May 2026 14:05:41 +0900
Message-ID: <20260505050541.3031447-2-andhsieh@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505050541.3031447-1-andhsieh@nvidia.com>
References: <20260505050541.3031447-1-andhsieh@nvidia.com>
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
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dfb283-c59d-4586-f2c9-08deaa6411b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	//LhQG1yaydd2RE/tO2ct3jZOyj2mBP/1RltpDdJuNCiLfA7cGgQZK65sWhube1boOQpXPQn8Vd7JKrGB+JL9OQqeexTGs4+AHN5PUMcEaNnm21s/NmqWBiC5Whf8EViF7XoEM3Lppy353EFWfzDW45g2zky9+XFcWjg6PdPxFOyL2JUIRou6gYIcf1x0bKw2LiMVYmWM+KqGrHTm7KYO1xpbQ72uZ/VBzBGhjQAwPEYOGEBF3F+EhEBWuoXf7ZLEh2GMYPnkNfJaYl0VixPVRucqUzZWKgLo8NFNXErlTmyC4fIYGuZa9oBZnGf8eXm5SDz5NZ8Ic8/p/4mLJwgQgvtLVTYY9Yj88FjAqUMhPggI8+slowUG/U3J1MfjWN5Wntt7GHxF9Sm9EnV7dFj/KdLbejcHkuO5voDFUPawTJFD80Bvq7Ni0Korr50ar97fq8oDVf1YP/mniaMPWx2PhVcCnhLODfCrazmBVPDRUcQrLmFBSbwZ/HsXa4O6LTcXXD5SIwvSLDXr/S1uoJ+/UP7ivQMykAug0iv1Ts0wC9SJS7AugRpveGSAhm8FIVbGtXM8EnyOUdGerDfWXdxnp7yF2LM3XRyo0PpdkQCXOh0FA8lyb5+OruHe9xcHevlJZSa8c+vsMIM0Gfnn2Qko4e8yyU5WAZ7t0Wvk1NTyXvkMIexUUOyq2+9/TrtG7b5KCC+v1PTq7KlgwoDWiWQCToftzWBcfsFdwEkuFbPn64=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G7dMUtXQO3bCOtK9qzzZ5kSpRyQFH61GVsJ8af6z9U77uOHLcotXvAxJivSdhgiVh65lFYtF8IIZJ8NKSE/XKuzQOrlZXYFRnJjgTG2mnFULQEBrrtUsMhdr4KRDnCkQfatALIvSkClrwKQ2w3sBzdOb/2lbISqbZDZwd8T/LLYu6Xt0F8Po0qDX/qAb9zhkS+AACcIICfefxInH8x7XnpX3u2xVMIkER546l81ucStFtFUDW6RKxWYiPJQwt9Z+Ghb4U7HZsx0kmEO4OzvI1dr2ncq94mLcysXVMXPlGYszjUqnpF59XCAoI1wKms7aWHVH7up6wtgqTYZfD2ZXGjlWYhabLkAvYRpDRWUXFajBRqjhz9dhxQ92CBy8bYA9QFVu1hIFxhdbSx8Pd98Z7ejRpq12F3O0drkyors6UXepHj+ZRfRVrzgY5yRzK3LI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 05:06:30.3020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dfb283-c59d-4586-f2c9-08deaa6411b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161

Add &mac0, &mdio3, and the ethphy3 PHY node to enable BMC networking
on the AST2600-based NVIDIA MSX4 board. The PHY is attached to MDIO3
at address 2 and uses RGMII with PHY-internal delays.

These nodes were intentionally omitted in commit f28674fab34f ("ARM:
dts: aspeed: Add NVIDIA MSX4 HPM") at Andrew Lunn's request, pending
clarification of the RGMII delay handling. Following his guidance on
linux-aspeed, the bootloader has been modified to stop enabling MAC
clock delays on the SoC side, so phy-mode = "rgmii-id" correctly
results in the PHY adding the required ~2ns delay without any
double-delay from the MAC controller.

The corresponding U-Boot change has been submitted to openbmc/u-boot.

Link: https://patch.msgid.link/eac09481-0ba1-4ac2-ad8c-d859822ff0d5@lunn.ch
Link: https://patch.msgid.link/20260504044702.2613879-1-andhsieh@nvidia.com
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Marc Olberding <molberding@nvidia.com>
Signed-off-by: Ender Hsieh <andhsieh@nvidia.com>
---
 .../dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
index a12d4164de4a..29f56176e2ca 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -208,6 +208,21 @@ &lpc_reset {
 	status = "okay";
 };
 
+&mac0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy3>;
+	status = "okay";
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.34.1


