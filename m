Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A0606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IpvrMtRm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFXBB3fBgz30P3;
	Thu, 29 Oct 2026 16:01:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793250066;
	cv=pass; b=JGu7SrZjnZb1SMBZHVq08LEnWv3bYvggOaihQ8i+u2ZYG46O3YoMWMr4dWroc5qaiVUkQkFPaUIWIfhVVUZlG3aeWf6L6w9FJMJNxI9iAOfA1q5FvIb0zdJZvJPFfkglTLSudBiw+H77a4JKRfT3XbIjDT0cNTb+hkC4KZScbwc8zNSgwxC7OUyjMzdl14GhvHp839+NORiqdn+qUxbtWK2u2I72MDV4FgBS3WWXOEZuHzL1/PGhw/ymU9k1Uejp6I2unhRCnMhNeFjmF7rvwsznfIp+s4De7NMefNBEFtZ7QJfZnr9jP5PuRIqGKhmj7yLEUqGlRsQsU5isg2eSEg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793250066; c=relaxed/relaxed;
	bh=9+DRNTb+Iccr7cg3IFlbMKMsq0jQF/LIYCAo0v5lp2M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDhXUE91ImzrGKpntyRa64m9sPByxhohuNFUQdXohj0Cs83C+nhDE+i3SwPm1UoBn+YBuSpMgYo34CkbyDQLfAgR+NMf3yUfHOKP/XYWgenjK1fZ6g06c8GCIznafV1T2rR4z5h5nRipaQcH047Skob0IfZp2ZQTSMTmfn7wz4xvZAfZ+7jv2kwAk3m3j7KYLKFC+6K+TDPSI9mVItQkcPJfujF9BFmb9UuVlY7ma37UQ91GhDje3x+H+zRewr/cx3TGyWuycG+1mtGt4aMF2LkwlQAMhgIeQm2h/UDgsEncKsPGcFNpOglm3LOLs1u6zkjZfV5FicV9cX9Az7wqWQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IpvrMtRm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IpvrMtRm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFXB93MPYz30V0;
	Thu, 29 Oct 2026 16:01:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQeYs+NpXDlI0V7Q/wh2KHShlw+JsNceIQlc7Nfmx5zwPCGOs/RpKFr3/PRfyrtEWWFFg0ZpE0EOKqdYNyjgR9OKy1WdPTsLuQJFC4vr+hzFkeE8IGwQRLLZsDa/P2DwsrLQlijRc9lu0RqOQr4aTVJ69o1APu0WH6FZFNe+bcJlQ5TcZPqSST4pnxwuwb0i2q18eJPCSwhcrd2QhLXmjlqgd/2PgiAXZx1xGfozG0TdAA1FhA6c/Zok47/Zw2pvs78dSfUcE7jj58Sb8kBuTGFnveIyzZeZ5CZOB5cfNaZgZEzK4KaBGzDAzJ/kmtCv9bLjnJTsooKBpBG4LXeF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+DRNTb+Iccr7cg3IFlbMKMsq0jQF/LIYCAo0v5lp2M=;
 b=QWpo+PyfcryS42nLC0Dd8HieUO7wtbASu2zs5sak5V/dqHeasdu28MQirct5cdAkDxzcCn8IM2o21oRBA59yy/CNMJhTaVQurjWO7rcKzpkCgsvWbbuwiaJQx3RkkWaVviQr1ICNUKZQ1KbZbgKV//BTW2LC0ZZHETqhO5Ia4Bbf2YXxA5ycUMU3WkpTTvJC/RAg569IXMNMGrwAYrCnElesckZV20RhYow25o/FGuqDee2T/uZZhOwApEzF6Mv5Nk6ol2X5UHvjEexcLG0fgel3cyix+RfWTlBUhpL/NlnCcUJQJ1VOZzl6XnPOFmm3Ay/mANIbgWK3wuKnxs6mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+DRNTb+Iccr7cg3IFlbMKMsq0jQF/LIYCAo0v5lp2M=;
 b=IpvrMtRmqHmVFaGTQE4vXZDBWEwcbpOP5lXCzC/9dtX8pEmjXDWMWR75g0qu/WtwNHGpmZjlWMACrb5ITwjl+2Ggv7CYx5BK13RFgnhZVWvBv2ONCU5dWl6AvrP8ysZMn6T1I2bY6MfocRI9sVQQ3pfNugnlbBqACdGwAjTDg4dbKxxyf4DYoJwoP6I9ka6PxrOZfXCIIZAFRyG9SDghLQvPKl/er4ncmu72j7BaxLKKZVs/yoGTCyNR1+WZcSndiIQVw9kjGvIakCO5ZdrN5RR+JO/rDoNBaEGTObNOz21f5Mr+gsCOJ5Vw4q0Y+K48uGu68n+q0Y+6MbE50M1uSw==
Received: from BL1PR13CA0202.namprd13.prod.outlook.com (2603:10b6:208:2be::27)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 04:58:52 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::71) by BL1PR13CA0202.outlook.office365.com
 (2603:10b6:208:2be::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 29
 Oct 2026 04:58:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:58:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 21:58:34 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 21:58:31 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC support
Date: Thu, 29 Oct 2026 13:58:06 +0900
Message-ID: <cover.1793243187.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c1ae17-5950-40ce-196a-08df3579533b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|18002099003|13003099007|56012099006|11063799006|261009223027099003|261021121427099003|260925021911599003|10067099003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
 aXzzfh71ooPWCyXn8KO/0mjMrTRNuLvu9ItAiauyNG1TS2gkJH2OEp4EWc52k3HHnL1g5bOWWr7HhuJvXFUz3PAdQ3cGzLyYQSBDHIO3lNWI5C4Qy6qTy+lXJSxUPjmdHPSf906QUb0yEoRkx3AM8eedwTETKLBRvBk48kfQJjnus8bD8gGStySkdAHgClbxKuu/jMKF3U4qcWqjX5OOQ4CXuAusqn0j4d0UfGmoxZGbPfrEfoVEiI86ibkJXjzKJant+IN7xVNwlbmH3Tm6YUrxJXKREAaEXoINMOUHDhmO6ZWcVPtxFaZ8lMDiY5JklK8TFMvDhgiL0/FLZ9O/xL5Hh5euVx2eHkJXHLQd3iGbBPry+ZIdAwIe6jFuXlY9X1NMXWTF7YhfuTU2L0IsBLsF4i77/L7OdtmyvL5i4HjgydZJ28Fe2TXj5sOqG8F+GNaEKAHrdHik+uR8Uykgmd5inydJt3roQhYpLTHFvkVR1ktyV/1r7P2wijoBxx++aSl5dlA4CzkSz5cKGO6/oZIPEZoLX+rvNcxtqTSmIQ1v4W3Slm9CviEM8PN6s+JItEKKyvr158ZzP7fqtYJf7RmSIYf8X44RTpIvQRYsU/U7iucFVps22Q6y1haqPVnI9obB2fs3K0Df1pCcAw3rO2djdaGFlu27HGAVLqmyT5PHW4H+yRGrAQupEkfD8EplyJ2NnFx3TRAoXStYPxaZkw==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(18002099003)(13003099007)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(260925021911599003)(10067099003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 ksumgdySMnsHEMPobE2N9dOuASVKtlY814anmJefI0x/uJYBPlMfeDk81ihvMC8yiy5U1uH0TPd3ceg3GuhXKUqCor9wW7Qcrqe5TkQ4Zy6rXWJcuSNateXOsv0bIjnTCUTmd64Ppt5TxRJ/ZBdb6vfXJzGT+TVg4c8jhQmnTLXaJCnBMHQv/khHPY6H7g3ZBjh/Knhz770LQ3H2y3w5M30PAHvVryWi/Ji8ZgZ47rugkGMkHYUtzrmHHCbldDRXOh3Uo3gtxect9nxp/kReK5Y9F7Kkhh54D2V0gvOpmRwLan5cZJ2csUlyB1SrJzk33wXgmX5y2nRe+e5O1ENqb4yp1hOG2nWhI0xkB9iRDQ0p/VgPyk7mnXy2e9z01xbzmp2BsCDzSVOVOD+oq6bMq35LbKzKIAUJ4Bs13/BokSvmsuk5j/7vH6tEAlP2gD0l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:58:51.1759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c1ae17-5950-40ce-196a-08df3579533b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the NVIDIA MGX Vera C2 BMC,
which is based on the ASPEED AST2600.

The board declares its boot-flash properties explicitly, allowing the
same DTS to work with aspeed-g6.dtsi both before and after the pending
flash-node cleanup [1].

The board DTS passes scripts/dtc/dt-check-style --mode=strict.

[1] https://lore.kernel.org/all/cover.1793179064.git.jackyhuang@nvidia.com/

Jacky Huang (2):
  dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
  ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1321 +++++++++++++++++
 3 files changed, 1323 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts


base-commit: ba3f2c447203166c640e40dc8e9b4b91fc613aa5
-- 
2.43.0


