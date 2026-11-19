Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA6606A320
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tNFGnN6y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVZCg4ZQ7z2xSS;
	Thu, 19 Nov 2026 21:17:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795083455;
	cv=pass; b=OBeiuV+KzOaq2BLcILO2p8ljHVclCUV5W/m8FMNZ9w0juMRN6VZ0ZTgYu8XO6k/bD8Jmj5wTiKuFvQE4wK8iJOObfPxZyzxREAXQrQm3ZK6R9iK7rdseYBeA+YmPrfunf91ChtfdYU/B5npQhQcA1QT15kOssi6MvfUojrsGUV4TU1bETN+OMbw8mRWEmnKUmpKKtza2Li4Xa+vqSQjPoOW5+laak6BO5TCHmWWX0b7u4peJBcmnR2ZleMDJE7sQc3aGWphqjN+CkWpsl1tpMFd88/+3yaNXgRs/3spZmIOA5MgTVRygYL1YZ8rv3U/wb3aKyi9O5LQj/KBgDN+uUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795083455; c=relaxed/relaxed;
	bh=vmyHvh3ZbTLT5Nn1O4xCIJ7ihSUmHyM361ZjiQu7JWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bG/T0hUD3RETBqgAmnEKtAqGTMpyJm2D86LzoPU/k+Q7lXhK8X5yOY52QBRcQKayW/BQu87AZN6X1CoWQyDf95l+eejrfWTI1OxUpYcNq7CbqWnC9vA6Mmr0gvRLtHEOyUYRO5WtT8MQxtkfsIVMQG/HWVOoN/G7/AasWaRatSqcoukz67ahGia7LunethgZXPsX9ati7+EE3l/1Xk3SWqFbzT6y5BrdXy2PagZPwClKHp6+LtXaWbVaA1AsvPIfl1IY/jT9Obfb29UllSkgi8rFjDVxUjZBLQdfmzGKTbSPNQJzMlQsXQ50WUCET1EIscj1lbI4Q+JeEwW3ael1Ug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tNFGnN6y; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tNFGnN6y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVZCf4799z2xQK;
	Thu, 19 Nov 2026 21:17:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSEwZ/bfrdavUdNeCv4AJs0kknW9BhjLj87YrlYlI/m34ZvKezyrua3q1Pz8DTCfTdDu68IZXAgGqLksMsERN0zvoTq4gbz8P6ZfNIOo2AI32E/TgpML0msPWIAywXR7yqoMBlph9yhvXGx55vb6VbMMSE51nRLGWKfBEK+EYAHJ7+YDhublWDbMcfy0UUUdgo5KzTYKCVVZnwQ4+pzU+bKf1NyYOco/yZ4HHDnIAjg1Ga6OQhZKwLvqWHxFFM2OiZx7/yW8ntJx79n1KgfXp5CQWIa8t59KIXJ5z0NHC43Ou52GKh3ELkAju9fogiY54o97uApLgmzLHd7S8QaBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmyHvh3ZbTLT5Nn1O4xCIJ7ihSUmHyM361ZjiQu7JWg=;
 b=QYm8mMLEMjVxDR9PSy2I5TG835oefMwF+6+HYcz8ACbnAxq7sMki7gD0LzQ3LK3tbhQ80IRFBoqLaGneRMtRpUYxE9QvAZA+eUrSdoc/JKjiZ5vuSTHkMA8It2r/kxnJT3OUxF4OPbuNrIlrJ7H+eyg90eRaGRfyUtnherIZA2vSmoAfC9haMBmYmHfj3dGJSTD5z47m0HmoZYGNl8J4FkZr8RdhOwdVfAd4Wia8W2MRynuzLFBGIkiXNiYCYyToJrhXdSl1TMf3O9fqos/ixBt48qMKuQTD9nxLSuc63RiOMHGbMXLJBnF59MEsWwAZ221PPqp1L1F1iooBozfmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmyHvh3ZbTLT5Nn1O4xCIJ7ihSUmHyM361ZjiQu7JWg=;
 b=tNFGnN6yFWv+1PuMveKt0u6mOiH5H9PtTE9nq329stOxVKXIaDG4kQOv67VbGnkD2UldpbAaDVgIWpOrTk9QkLSFHWNCI/zWxS8VA1mrKcYafBa2Wc2b+w5EEjYu7AJ5lj+4O9+jArovzwH2SBqtcKxLv9rJeXUfiSnjkNefv2JHYPZKCniFQ9UQE7O18Woe+kg5Nr0o/jm/9HBzKumWrHQaKm8S84h7XQW9LJ4UjBAUCQ8xBIvikK0udaKFpnFRQ/XKg8HfMl7eLLxl05eJ9o4phO8XAazrvTScV8czvwHK5ilxWLGcSXEiRXl5KIogLhIFdhZdexUAGQvA91Bc4w==
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 10:17:15 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::97) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 10:17:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:17:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:17:02 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:17:00 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, Andrew Lunn <andrew@lunn.ch>,
	<devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: [PATCH v4 0/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC support
Date: Thu, 19 Nov 2026 19:16:39 +0900
Message-ID: <cover.1795081735.git.jackyhuang@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6b7538-fe49-401f-e0d1-08df4626484b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|36860700016|376014|10067099003|56012099006|11063799006|260925022911599003|260925021311599003|260925021911599003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
 b6JIEmkXGBFZMiNhMzKSX1hCsSyRLTyQ2KMB/51n4wE/mHiLVYfCeY0ShI5LXlhGyIV7OXfG3mJ0Hw3aNHCvRFQ4wgoQ3MPoiEsLK/mshDPuDgDkJVSnybrVG0SMEZtxaa6zOyPbtOfJ3uMl8qvIltICaQh1Oh8/pJErDR7U04Kj830uq052Z95zbkz0QKSiSKW1Nmcx8F8zK3SJrIBfRB7z0/nRS0IeAfcVyWqYB26C9RHCMguF2VeB4Sh+FFE3u5N+P+21AnoTPSfIKKiV83wWfnQkyGC/iDJcCOsck4xrFwckqHHt5bBogVGkuFagC39lXIuQljJiFtRlDW2PkDDBYU3LGejbzceKoWVva/fkUEc1o9aqv2wfaeNxnwK42YWlmVgl1cpmtlZiqczuM5Q67jNJit3BBBR0Mc0YICXVUjdwQzPUvuBQt6QiJ+CMikmDDP62AqDS0dGbU9FKyNlWwVLyQIESt3MzdHx69lq5F+Wpq/H//uRNm1+omkVtTlR+590FC4yy3/F2LvaH0Bbhq68jcwd8r0erGIXIsuZeN0ScqbHsnUOcObgcTQJyhX0GtcOAzhO301gvL+05lcIecv0uJso13fGTLLUkLRdMtAvdFGW6m3PrLsu7S21JxV/wYVLy4s9m6ju3IZc8R64mddpYPaNQ3vlQL4/8+EJrDQRlQOmHVJkwUZvjgTcIm/gUTrbBI7wpOWo2XE5CQQ==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(260925022911599003)(260925021311599003)(260925021911599003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 fXQx6zUxscZCKkCVg5BW8NWmFgQTIb6JIyxepZHL+ht8IEm7k/Ssp4hiYxV3K+hKfRrbxdK8uWZikFAbA4LKiFdgbz8JTr6oKdbEC5/l8M51nk9PnLEM4LcKLSYI0hwHUeSBXpdgLWOOFKwSo7RFAi5wZcAtyHHT66vFg4l380bLHKWfZrxzt6FW8urzqSJTQuduKC9o9HQLLyxMmJuV4RRdqhBOMNDbkec/QcqOfGtB9i7ubr2hNKNRR6OUYBp3O304eAXAcdFB2zH3qpmTndZ01tG2KzMpedg9XRjdWhOowV4GhgP6hVHOFQGbUjWWmN69BixEme+agt0HLIFCrolAzCSYw6flxboxOTwbSa76Tcz/nFS9MJuL1fqV7FeATu4LuF+1aMiXhByg8QyFbPHYEgT3WV73ab7QdoZUTADvobAsWQ9SkBg7BNkn283k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:17:14.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6b7538-fe49-401f-e0d1-08df4626484b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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

Changes in v4:
- Remove line names for GPIOs unused on the production board.

Changes in v3:
- Describe the platform's purpose and link to the MGX and Vera CPU pages.
- Drop the misleading RGMII delay comment.
- Update the write-protect GPIO name.

Changes in v2:
- Add Krzysztof Kozlowski's Acked-by to the board compatible patch.
- Use stdout-path for the console and baud rate.
- Use generic node names and fix gpio-line-names indentation.

v3: https://lore.kernel.org/all/cover.1794985308.git.jackyhuang@nvidia.com/
v2: https://lore.kernel.org/all/cover.1793705210.git.jackyhuang@nvidia.com/
v1: https://lore.kernel.org/all/cover.1793243187.git.jackyhuang@nvidia.com/

Jacky Huang (2):
  dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
  ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1266 +++++++++++++++++
 3 files changed, 1268 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts


base-commit: ba3f2c447203166c640e40dc8e9b4b91fc613aa5
-- 
2.43.0


