Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E4606A330
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KMFEP/dV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTv9G0YgNz2yDr;
	Wed, 18 Nov 2026 18:58:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794988689;
	cv=pass; b=NXfE8WQhaOtTplHiyRWUY/tmJ32fGluRlCbqgfjGZvFDlEwI366O8goCBGv4Gzv24u/WfmMiK9yBa+X46nGqpJgEwb3GGLf/LvgYUi1VP0mYMKh8FRVrOBy8bzpI42aHXgv1x419Vi6dfkCU90nQJ3Xs2lJMNtIewx5XNV2T+Vmxxb1Ul8sJu2PEstPhHdsKApCQHdniu/Rdga7llAEjtTckckCZViVhyB+jJgGYOnliXrmOfhjIHGcfQENZqwIoH8YdGCPkEUz7+mjX9sI0MsIMpqV8bIMOlvaW3FhXMW09tyJvkX19AKKx+Fta0uNxcGyRbFkDK1C2+RDp1tWqAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794988689; c=relaxed/relaxed;
	bh=AbSMG01wD4YwjyBbzekil8yakWUlpLgqY3IFG8Ye7HI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c32t1UqZYU/vm1Lu4QR7OfDGv6EcfAnQpAM7jYxmUqVrZ43aEIwEWPvzbK4F34l35Da3VUX+wcxGnm8Ij6gnKhfunwqgJoh73s+OR7WMYZXbXXsY870VVbkgzPXlv8BabpZHx8V13l0zjOZqSKKbjCwrKJdVMKTQTkiUsXrkcgtlO1fnGpIvRZ+bdfdCYBDhc68OZGTG28V7tbQNTMqQFTWq0Wuw19q4hLwkELk/aBRww7mF0k5StJHajmd+5MWj1ab/+VC7q2ZbnnIYGIkl+4l1tUh6D0aexKVznuKbMyUwPgp1lWqVlxD2CaSWC8j30DLk/DZpV89CTtY1k/7NFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KMFEP/dV; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KMFEP/dV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTv9D2j76z2xL4;
	Wed, 18 Nov 2026 18:58:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAUVCnKAyBp/Hap4JlgObel9kES7SoFOMzPq3+Pxo0X5h3JQ65iRDl9dxPP+HWr2bo3NsxPs8AQBwW68psZtfctitrOVqGInIcAvtm4oykQEgjajM2SuiovwVk81x+nybt4PI2J1EVt4zQ8nN9lqGozwyDFN+b6Bumou+SFXOWoBNYUk6hiG8B7NrVhyYgKn+X9pN6JYbgEkpce8HaE8oTm+irdhlGOu6VBblfCm6ZWs2djCaWun7OsWSph/WH5RGle7H6ZLB4E6DPNJOoNPuqjxI37hmRKRN6kDdU7nZMYhXI/lPyiUwJdxjpVRMc2g3AVEFe4aFahz1Wn53Tu5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbSMG01wD4YwjyBbzekil8yakWUlpLgqY3IFG8Ye7HI=;
 b=WAfiYiG+jJ32P9tnAuYSAMOwni7E4t3k4pvlYs69QpE+9R6SidpvYwKj/6uqPY02gVjw/ROUjGxVso7tFW43fP9Xp5QyWkDQGUAAwZ48hixLxHtaI+lW58Jnx7ZGEzeKSMRJnyF6p8WUPMgAK2owDgihOCakPNP7vWLPrTcpw11OkvMQoz4kCcQZhG9s2OXpBjzxRNiK4RqJ0BoViUFHuxv/NW7GTiWPq/QnYBylE9Ywav4r0jHYnw4KVSrViqcxa8OKsKwOkDvMFulx6dKYggtLa74bkzlt0522165PVRMF1YM1f2xEYCarQA/kE17WNrZ/7QBNYPIKIG+rLhUBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbSMG01wD4YwjyBbzekil8yakWUlpLgqY3IFG8Ye7HI=;
 b=KMFEP/dVYViCDmT6wo5XuD/zOTP/3ImX6vGaaVJi/WITu9vT/UvDw4jpjwpBJHrDavKcBDD/hR8P/zqWFcTDfH9SvXkkWLHLBSoekn72IZryS8S/vYD8adzpkgyBY22hD3wo8c0prKVaXEnzab+UL6kKzmizUROF3cDKyQKiA9PszKqvhxVAd8DRUOuGgc8noUvyh1EiqXf5iPUhrU5yklgLniFm3+jQfnZyZFFUz7GfrGKaelbSSKHLLpcGkog7NRQeHzxTSBvhUvBQ8Jw462uk4MR723CrOafS0nHzZWbETzPEAYHGdKKUiKYUJDIsIFF8RIuPl677PhBJhkyI6g==
Received: from CY5PR19CA0120.namprd19.prod.outlook.com (2603:10b6:930:64::10)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:57:38 +0000
Received: from CY7PEPF000000EC.namprd04.prod.outlook.com
 (2603:10b6:930:64:cafe::41) by CY5PR19CA0120.outlook.office365.com
 (2603:10b6:930:64::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 07:57:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY7PEPF000000EC.mail.protection.outlook.com (10.167.247.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 07:57:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:57:20 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 23:57:17 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Jacky Huang <jackyhuang@nvidia.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 0/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC support
Date: Wed, 18 Nov 2026 16:56:54 +0900
Message-ID: <cover.1794985308.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EC:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: a924bf31-1265-48ce-3a52-08df45499ccd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|18002099003|261009223027099003|13003099007|260925022911599003|11063799006|260925021311599003|56012099006|260925021911599003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 N5YNFKflXtGpgVPjwPCYNpYuXv2S9vX8ynRhEenxHu+qFP9rOxSN08/SoDBUBRnLrOQfqPE0DbtNAUQ58ESSCMDA/ClZc5W7/LXbOLt5M+251Ci7bIuohiJZQmyMfrl+emet/GSye08BYjp2UH+jNCflrrps5HmKfdU9OY+zyxwXwrpRtlU5ohFr+OeyPzrVKKS5pgFF2bd/04KbIyXxXEYre5KdoVbShH+7b5WmipF+en8j0AF0wjj4Qry92p+KHJ3OJwl3jhae6hKhTvmeDVA6Pm6buWk/2Stqg8no/Wx6sB5u6YI6cUL7SLI+TQ3RtcO+rgz+H3E+7qqGSEsym3Lsh/bcZlRgHKbFlUmau7G4ayVQcTRZKPFpLj06ZCnLb7OSFNuTF6EmxmMibr7FDMx8uSF7u0QaUU7nhcXZpBz1uhzNBMWYYZZy3oiFr21EPNPz5iGjm5j4KGb9Po6UEHpcE7TSBr9wpf3u3B9lWEJPx0VYoELyjRsNBtQMt2MRBD4eBI0oysxVMJpUwZOeBE/QMLnJkHimW9dJDCZzLK0JbYnXenQCUpRjp2d+hJrMZpiUt0qnGltCLHdWewBikOp7wo1KC76hQDk+kym6BE4Qq80cxXLahW3NxI5FlV5XiZRQu4BhqggcS/s7po82f4GQ8GnVjEwciJDkM7LGOevwc9CJJ4QnNNmfSAnYnCftMEy5OF0BMTzzb3jnhDLU7w==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(18002099003)(261009223027099003)(13003099007)(260925022911599003)(11063799006)(260925021311599003)(56012099006)(260925021911599003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 WVSCCkvy02wBA+7sonsUvEFKgsMhv6oNbnvzhpPvB1NRWKXTH+Pid+INtif7KzspDDvgT0LpCtwimp2wnGQt1XMPl56mq62p7cobTvcftu8WzB5RqJcrQnGBycCIVAFqG6saxXJN/BJ1dCR6VUo3wA0Yd8unpwX2dGBIbVvL5DTiDwac6kH1YDqIvwMgji74/2UsArClmVGQLTVYW1Ux2WeZ4sJ5VvOh+tatuwghLPR+mFsisIe9tPBMua4sOZbIswSPAwUDngEHIY4n8m9J8xGMlUFCPQ0IgPRMk/acBG8yEIptr18u4NEp63AVWtJtdxrf53o+4wqguf9vlfddHwJclNRyHudzzI7QfbZI0Z72U5PJtoSrGr1W1wT12QKQ8o3CgaWSw8JZkFBhMPo9Hcy0Ari61OR/6JwGg1eqFModXqZjv8CdaCZLWiJrS4MF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:57:37.4467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a924bf31-1265-48ce-3a52-08df45499ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NVIDIA MGX Vera C2 is a dual-socket, air-cooled 2U server reference
platform based on NVIDIA Vera CPUs. It provides a reference design
for partners to build and customize Vera-based servers using the
MGX modular architecture.

This series adds the board compatible and device tree for the
platform's AST2600 BMC.

Changes in v3:
- Describe the platform's purpose and link to the MGX and Vera CPU pages.
- Drop the misleading RGMII delay comment.
- Update the write-protect GPIO name.

v2: https://lore.kernel.org/all/cover.1793705210.git.jackyhuang@nvidia.com/
v1: https://lore.kernel.org/all/cover.1793243187.git.jackyhuang@nvidia.com/

Jacky Huang (2):
  dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
  ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1271 +++++++++++++++++
 3 files changed, 1273 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts


base-commit: ba3f2c447203166c640e40dc8e9b4b91fc613aa5
-- 
2.43.0


