Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B578606A31D
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qtheivpq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFX8D35nGz30C6;
	Thu, 29 Oct 2026 15:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793249964;
	cv=pass; b=ZZ/zg1leGBtXkTHezDInGpqRt+cT/M8vahdfjoQocN5oBcTZUcQLKdLy3D1Pt7ikKcbaIG2YcQcBlSG+Kqi5Sf1oEaPmsb0UVGhd1qUueJ1K4PnS00PkV+Ui2SVMk9ceT+JmPfZW/b6oAHGXba5Aw9J3oWNZHrfKlibkC8PIOf5FIhQWs85QA2/ZhLKUAlMRc7z6E8ghivPe8Fh6MKTreV1RQ4B82RnvkYI1XzN86OYE68/mto5wYHhZ4YXRaUHx5Lbr+Ao726qfgaUhfg++B7EIyEdU0Jy5XII2+O7x2vmMRz1dD2PmPYil39U16id+mzkgK2SgXcezOyI6dvJ0Ig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793249964; c=relaxed/relaxed;
	bh=cFlJpceVItKyObnWcTEixdVpHBpJQ8aAvP74E0iNDtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LokSbvpYllls/BD9VU8vIrPqcL9cRQbtkJLv6zIjkOegnx5BYIrDQIRNegsJ3bDumW2y6Kch8+aTk3+JZ2MmGJo4fO2LpQxiR7VIhZXDVMZI7ZzjgE8zHmQbGb78qoy1SXKp5aFaQXbD+1Bl45Sf4LCaex2Clo80DiLEEJxzJEjYbnX871G9X+NUwK/uTgVjoO8QztHNABzKYpycZvEkucQn+2zxk0ypfIqfRI0H7ApqWprUY/M17I5c0oxuk172VagTGmqlYA76w43Ucxgc5wW1TbmlbzW78p0uPNk5yT6offMe+P6pUVx8JWrNyVqhF+/kXvl3L6VyRL2jmm0qOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qtheivpq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qtheivpq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFX8B1MZbz3048;
	Thu, 29 Oct 2026 15:59:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOU0RmTVogo4o7kU5jiJgg1DKa2ERF/RWmnnKD4drvd1AWxDT1We7EzwB0N5SSArgc0PUTbJw522mJsigIoQV2XhphdR26xDAU6Fc86B6E7cgUFmYB4Tn2SOX7KdPEqXykiTGP/zpl1rxWfSyI62z8cNq4nhnwvh8f2l6i39oZPI3p2AF+grKLwBeKbmYwX4MYckHJq+AQgk0ASS7+8xK/VWAjPMTwJUWUQYKfMhtcoZKGMiOF69ZJub5IWF4e8ro5J360us35nQp2uAXdIT94VqQyfufBpBDGGXPfhUiDheOjl7Wd51hsHU/59Nw02OZY7peQtBReTlWxAkkpIO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFlJpceVItKyObnWcTEixdVpHBpJQ8aAvP74E0iNDtk=;
 b=b1k46ZMyHXeFrYapRPXJALb3WptMWB6BKe7SqvRSNI8FVqLvX3plSLiz6HkzaqtY4x8/7E53ysCjtVnJjiwymTj50WLer5Jo0M3Fni+wyaU/RzeQjq40kq+0ePikU9PPuMDFG+lZ2jbKhPA12lCXU2TgW101WLiMigCNkUOyXuPSeFS0xNbSzWfySgvI3OnCxQm/n9KRChjEh1D5dLZdJc/kKCragHbHuxpJbu8BXTPVByMLoCP2brpoQ7ES3jp13Z0uCLPjVX+pTQPdEgprfyeN/BvClsI+1VtjPvRltsEyE2rBjX0OTlRYbXhQ9PLaJdC2ZnnkD07HYZ5KkiHxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFlJpceVItKyObnWcTEixdVpHBpJQ8aAvP74E0iNDtk=;
 b=QtheivpqweHzW1SAJ9BYxk99tWFMjXvT2BewZlwGcILi1dv0GWGxRt8fJBSXzpTHG7CvBzTGFEg09Ph2jBFDmR6Tw7Hb59dlrK3mkuA2kyn8njasE5TR1WuwM3bX3tRE/uOTBpW/DeHZ+R8LjFT9aM7elR7HICkhTgkH3iemFgyUDgRE2BCNiJMNfivALy1z8r+0Zi9uzG796mHdtYYWm9x9qoUATzzQFeTHmCwTX96UCVlAgY4C9ZCjLr1E/3yl/+fRqhZH8MdpkEfwZYplHonef4YP4xmWMpgxbr0U41yZd8ST/c35W+3fA7pU4e5OuTHAhO6Ng2gaVsesP9CJkw==
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 04:59:02 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::26) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 04:59:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:59:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 21:58:43 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 21:58:41 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Thu, 29 Oct 2026 13:58:07 +0900
Message-ID: <ed348a94c9432eeea53f50448a61d93f99de7821.1793243187.git.jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793243187.git.jackyhuang@nvidia.com>
References: <cover.1793243187.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 48033f11-d62b-4830-20cd-08df35795997
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|11063799006|56012099006|261009223027099003|10067099003|261026121527099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 aySiOG7QOAa4YEMacHp7KS5E4qPalYWY0W8N3MM2rQGofnjQyxAmSd6TMvz4QLsh912ho3LJUenlTW6kqgnrzkJgirFaxcpcobJdDLkdTglOToKGLlzOXwuC3yn99lnawIF1LtFbsnumLsLSeaR8qagCdjjHCYqxQ/M144YgxZ0illZEX1PLbp+5ykI9im5OM81D8CYwDJ+E5Xo2q+uWdR2YAawM8ZUN3SMPONxzeTD35U8HnZk4k2bM9FEEg/gNUgSmJfaYt4xgZhJhmpcxk0Iss2qNbYHrsLB94KanZGtGZdBnySeuE2mS+bvWF6fc7lZJTIv9JeMTpKZVeRObInCJ07+GnZFRYoCeNKj9ivqTONJTupt/4E2v+IJYf/ereuY1PB+r5PXoIpf09pi3cY/n0BqCPjajHUuii1/kr1Bt7aC1wX4VddToAK0fdVTQwYwEGP59Yt+dygJzJnW3ltFHCIn+v8ZQnw4kArLsdjOywV8R8FWcq6WqLhd5ib9LSuCf2/icS9N235Jaq1dUO31zcva2g/1W0moID4ii8WyNhI5LTAAK8xaGSNBENfNRw0iudUGvsfHupOcKo9O5martG9i/c9Mg/O/uZvAMDxxiLpm0Obv/rTQjmUSkM6E5y3TI2gLCmtYxFVsncc/xEQrjDoyIwJWjaATOORqWxn5YLXhjWBJQvUnTyC7m3VLLRGXdfYFMjuYSscSiMzeP9Q==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(11063799006)(56012099006)(261009223027099003)(10067099003)(261026121527099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 ITV1s70leoQTOs4ruS/pWun5YPgMp/UJ66IgZJqglGNJhhz6MnX+zgURvfC7Eef/XSX9fkTqq2vU3rFXGS1kuAqNF0oDB9n/cwZUDOQW+g9tXUuGQjGOKid4deQqzGQHss8lZ46VravdyJ7e0XUsDHYgEWBdh1ATgsFGcWEpRcEeQ2QzV1lFOlldeCjFv6GltldmCTAnza+CosedZ36dW+2QezsIBEy3rd9FOPNWCT35GMrPu7nMCYoNca1uM1in8oXFy1pZuDbqVaACW2yv6lVO6L9ER/d5/Sc9rzaf42Q9rakwbN2K1XO5yg1GEOdIq6cniWrd9ZLEWXu5T/x9IcKEsLc+W/nb/mxJv8zqoMAR/g68DKL884vTWhLa3yZyGCSvGcdOoLutApTXXz9/81Un5iYTnIB16jhaQN0TD12+8f0EDYU9D1rHCvqsyRsG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:59:01.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48033f11-d62b-4830-20cd-08df35795997
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the board compatible for the NVIDIA MGX Vera C2 BMC, which is
based on the ASPEED AST2600 SoC.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b7e70868e..92127d7c4 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -115,6 +115,7 @@ properties:
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
               - nvidia,msx4-bmc
+              - nvidia,vr-c2-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc
-- 
2.43.0


