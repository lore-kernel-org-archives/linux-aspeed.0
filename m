Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1D606D822
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PVXU7Zhr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJn1854mfz2xwL;
	Tue, 03 Nov 2026 22:49:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793706572;
	cv=pass; b=MCw6pgBO460OGsWifdTuOhs1BenxIrq6ydxNUyxvSGRQE7ZvTKePj08RKsngFF/QZvwESz/rVD7FROGI5Vcii4moVRNBvGa3jN1DOvCgdcMg8YyoNNsAM5DKBp5X6+18GHs7POt5XiD5bBpvOU9/RTAMk4KoYF9HQXmpZ5wn1Cc8ttoP5nefCavlzg0aWB9iSACa5ef8/fFIKvcyrHaBFx7C2kjOMREPA6O9m44vL0KpHRhcn+qXgs635b1ZwKSUAczmDi5YrMs9stnKcp82m/Pi+9mNEPtcp7hvUn6LO1FC6rb7I/iocrwOP/y9oYmAwxXj7Dp/R4mr5/vCTlUb/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793706572; c=relaxed/relaxed;
	bh=m+6NSoBtSa1CPqPfwgCDegOu2B7TuiUuL9/1rVDivZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0Jk2xBelcb6OOHjqQcF+zm/NRFiEXpJBLMuLpWRc1uUuUqcr+GhSMnP3dRzkae29eRJLRgliCv+iM4JPmlh0KdHvZ06nDLLxajPkjEluYtoIGf15PscQu3Fg5O+BsxiNS1SgG7rjopuzt1gV7H8bz85EQfTDXtJDn2BJntNi+W/Rdy67leA4ieDae5Eg/H0ArteZf3C9lA/rVcEodPSjdkn3HxYI8WZ1w4x6uxYynJsN1I1cuORcKbMx2asQ9QGsRH0rI+PGmL7jkDW0ezEExh8RRso58sz1nmG/93N8V8ns3I+tLxQGdL1tCGStb3GxbFgT7xd6loRv++aMh7Jkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PVXU7Zhr; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PVXU7Zhr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJn180Vqmz2xH9;
	Tue, 03 Nov 2026 22:49:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRLBwIM8WKVs/Wzpxkv96ntyo6Sk9dZWW7eQHSUd5yllvy/IBdUja1CmsEUEv0rUG00Y9p5QYjCBgVyQXPhhtQccJWBtHMeaxB4KEnqEC41ksnTK96MV+n+TsUBa6Ch4m0DOW/AuLU/h3vqnCf/pgPtbM5EKLQehjn8whZ4RNfmzMdCXN7x3tQ/KPvCLWelzHEECJf1Qb2+0CgGpD4Bjy6eXAb9/SUwHNA0lFbCstm/oOlAx1YTRcVLicg5KV9tI7ksF58FEqBDy+k84NsHHoaZAW67ifWp01QATCM3HxMhRfpkaYx+dw2vTOyLiUStttOKIkwyywJ807Dp79YgGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+6NSoBtSa1CPqPfwgCDegOu2B7TuiUuL9/1rVDivZs=;
 b=ucQp7hyXfnoLnblrB1h1E2GhzPeqPvMaCmLc7MkgX00GvOFrtkvi2AbXrkHe9a4Ztir/p/NeKUEeDjl7vngLhNlElW4lw6pOPxSFZhmC/ek8TBW3MBmtJrnrK00w2A47BsGceUvl64gWK/yNebdOy7vzOXXKMqo9s8a28AV7R9r5NqpGknnOL5v0clp7d//F/lnIyfhm3TWcll6326DBhbev4+xnsIxEwY/lvtrGddP6WoMTocvYqwYU0YsqRzqULPH/NRGwPd6GygYwa2GWUSmdu2X9fRBfayfgYDtVyFI2Hxp8LbA1zD4t4V5Cu++s3dhOkyENqyh8+m21dkoREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+6NSoBtSa1CPqPfwgCDegOu2B7TuiUuL9/1rVDivZs=;
 b=PVXU7ZhrU3nIs8yYHPZrgBdYKN+baAh0rcivLdIoPigsL0KyTyat4Ni97lZwlxN20hqRUCl9+6eiGXlZpOY8P46kzV6wwxW7lAcXthj/BOf/LS2TUhxFKmcBx426pL2Zie1T53+xzQFHQQ4TK4XfYY4E4X64Q1pRX59y3aZFWYdJLUhjfpRV6iev/ruuph4YUyIv3kYXJ4tZoOwghj3xGVM6m5R/BaW0KNnZTwsacchAfUlFBwutFblA6HjPjoBOaHTYCsLACUxJ0D+T66NZSUc/JJDNOohpUvxOT/eCkR1nGWB68wMXSksQUjxBw3VsmktLMMeQmNaU3pf2HYABPw==
Received: from PH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:5::30)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:48:50 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:510:5:cafe::9f) by PH0PR07CA0025.outlook.office365.com
 (2603:10b6:510:5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 11:48:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 11:48:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:48:35 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:48:33 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Jacky Huang <jackyhuang@nvidia.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
	<devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC support
Date: Tue, 3 Nov 2026 20:47:51 +0900
Message-ID: <cover.1793705210.git.jackyhuang@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: b96e204c-b642-4560-61ea-08df39a06ce1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|260925022911599003|260925021311599003|260925021911599003|261102123227099003|18002099003|56012099006|13003099007|261009223027099003|261022075727099003|261021121427099003|11063799006|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
 NBUhTeVqn9q3SF5049DRMyYGlqtNZ0+hp2RbPeJw3Wl6Q1r9iufkspPxQ1z3USDJzIPb7ZLGJvlmK0lUjdX+U+Q2wAPMmLBfVQ8o9kt5y6zukBfnSKu42N4ViimSktm+2/M6bpbKWjo2VIZCDSS7+EGUux4RK5DhC5EtdY4yxXpEFQE+6XVQV9+/+U53p5BmfaWxRjIJoir6ZhLtNtNgnT5mpDwEbFK4ZGmvJziu15L6scFBTrGGEPGvJcPG4yCTKtd+yNjMHXqVgO822z8+DTH4kW16pPVqLOyofijiv7w8w1tCbLXDqdRM1dTTieuWwZ8yMur4T4c48BHaVeJ4MEB+Eaz5WBF8U++SrvSAeEDIB3H2Oz8Ne7GpqoJZbRFds5WM7ntWtsa4FBJiq5qbaOEW3ugtwEKaSvKYSISRjRds82FNDvsZGJgFzve7oP3Y3zV2bl1v2DH2TXSroh38G1NE38c0ZdIzFL/M64M3G2tQogpgmRPmrUSo1BiuzM8JLl0bNL9v6YsRjjoQsxVGAvbiiHbCgLlf6kXd7SobxcbZbvH0ShgN4JF3fAPR5Br6ZWHbm8lW+LGCgjwTlTIJD5VtjVXwGa/MtD5eo1rKVtqyBTOx9cY3v+VXHR1V2G16uCHeKNN1mGkLtedD8+edWX4AnpS5n1wfpC2ZdxeyzNMZ0uO2Jb+MKcO0yLJ0Z6T76GaU/QjeAyQvf4qR8UeibQ==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(260925022911599003)(260925021311599003)(260925021911599003)(261102123227099003)(18002099003)(56012099006)(13003099007)(261009223027099003)(261022075727099003)(261021121427099003)(11063799006)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 mBVQsRvj6+6MzWaqwN7KTYN5+YZLpSN8yhepBvP6b2n3FVqK6PVFFGLpTO00G3AJA6/AedXw1SVBAfoI9Beb1XIi0nz7Z9drpy/96aXp22/baYtoI+1cTN1AbHB13OP6Y8pCD2zWsDnf7xCUprFp5w92YjI5G8V64iAjv8p3HiZ/BIZJYCbX+RiFfuNQrV2pKBWpafErwL7seGuiEJ8hZD8xwPTdBLTqFJPny21269FSRzySQBjFJoty1WO1N/m/SVguX5anoJ4qqSOO4Pn/VAu2KefaH5V7eW1qha86FmCj+oyshhcX9IbA1SkoEVrj524GDNZnWI1F9t4dLfqT9nfogzp77+bUfWvaBa2J1NUUg4QYQFsXh1rsJ/Jzl5sCBl1bPrBKePBEYp4XnLvg/bVh9ceKG2NXerD8wectyynoQfdOTDv3vFwWdOaKeWUY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:48:49.3915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96e204c-b642-4560-61ea-08df39a06ce1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the NVIDIA MGX Vera C2 BMC,
which is based on the ASPEED AST2600.

The board declares its boot-flash properties explicitly, allowing the
same DTS to work before and after the flash-node cleanup [1].

The board DTS was checked with dt-check-style --mode=strict.

Changes in v2:
- Add Krzysztof Kozlowski's Acked-by to the board compatible patch.
- Use stdout-path for the console and baud rate.
- Use generic node names and fix gpio-line-names indentation.
- Remove duplicate GPIO line names.

v1: https://lore.kernel.org/all/cover.1793243187.git.jackyhuang@nvidia.com/

[1] https://lore.kernel.org/all/cover.1793179064.git.jackyhuang@nvidia.com/

Jacky Huang (2):
  dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
  ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1275 +++++++++++++++++
 3 files changed, 1277 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts


base-commit: ba3f2c447203166c640e40dc8e9b4b91fc613aa5
-- 
2.43.0


