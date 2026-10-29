Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E9606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SKXF5ORV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFX8W5MWLz30PJ;
	Thu, 29 Oct 2026 15:59:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793249979;
	cv=pass; b=TzItOpnxSQDEyj09bDNaLlV6WYVPahjoKDweWMSDcjJ8LZp2SjMtDJQM1tXwn7YDcxtEi538eezfCI54wDJRVz/eDBAGQf6/Y4EyfHpO3MK1Tej9KQ6l/vXWJruwvc+PwXgmNvKefQ33Wyo29HIn5eT+jzcTHob7tkyO4KlovtH2PUHuCdl8El5FlH/ntH7xCjFIpUpf2nGs6J4HZzLl7GYZCydnto+6+/WaAuoLWlpZYVc6kWs/kQCCVRd6+cbqGxoajYe84Ci91aZfpKeEDgQIxdLTRg9mXBAcMNrlTSfQWWb8Rqx1Px++SIa9Sliqu6LcSEHcgUNnIpvfVLQUqA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793249979; c=relaxed/relaxed;
	bh=5WR1PliC+T7MmOymV9KAbGhCDvo4fhx1zMS/awCeLOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQHKjAkwY7ydO5KcGHbfGiiMTqCZa9Rdg/SiWlw981Zpr9efArJem0lMxQf8GkD6rmPv68rfOIEYckMl5yCQYWilsr+zsqGVsbOObVAv4L4M/lB8m11XG4g+RQC+0G8lx+s4e3CSWaXbtHW271YoYBu4LQdK4hhpem5TNy2ZPvpR4QbbN5XVxzYhJsbDr/Q89VkPK4oqffgfi46ZiUdOoVlSCFMKEuJeWcprf9+2VYgqB9uYXPBJIg4M51vw5+8uTK4Y3k7eP0alBmBHkhdi9wY2ejuCmF4WiIudQV4YgGr8boochGTtkJtvS6EjOK9Hcwoc/bQXGmn3CULp04YL+w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SKXF5ORV; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SKXF5ORV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFX8V05ppz30Ng;
	Thu, 29 Oct 2026 15:59:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnfBoHOjGN8ZLRSL5FmQTADHQz5W10Ri8IZlVZl/9ywY7s7t+OvtkZssYsTCcakCitui2MMLZ+Gv/IoYIlG59iuCBPUqXSbks/7/wj5pH6t9DoSGy2iK6VSuHuLP8pySFtvM/oD+nYaY9MFZbXIIIbrwIx+uzR0YaFxA+GMZPcEaRd782EnXNgvronomMvjq+uhgeLfkQ88gki3yCmLO1NnTnSi53wZh/c1p4s+UjTnelBcBQ0bfFs9zb0s65enL9VRGHvJxFixfd/T7+ZXvOBbBEcuHmagV+XakxkxkKO7PscTpRk9Nym5jTCQ0P+v4gosLGHYNT+sBRlvQW9YcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WR1PliC+T7MmOymV9KAbGhCDvo4fhx1zMS/awCeLOA=;
 b=jEV9MW6h83u6MvWIaE2j2k5I/0dkP1cKrIw1GFivf1jJLENEV9HeohnehOkui3d0uEBi8w3ECsEInL8nOv7Z9QCzt188lH2q6WNIx3ryqi7i9yV+YWx4Ftzr61DgO1KQOT1/hXvo+s/P9r3dZEVdJ4nS1mfKxuAx/HbmT/3/wTOB6hzm8P6LTUUrpwxrPsaBwYIeFZmRMZhNWGcC1FEFcORs3narT1dUobq1rnL97ckqcVZX+6+o4/Vf/Ir54DhbLAl/sb9E0ggcQl2OHOjhv0n6t/HlSAaAy96LibCuEVrZEzM1/4fp8EJHsmn55+V1v70NfSQOClv+N3Qo4F1XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WR1PliC+T7MmOymV9KAbGhCDvo4fhx1zMS/awCeLOA=;
 b=SKXF5ORVgMYgwGpLffSMne3nqZT7WyFrZDSiufW+fxaNd4opN4PBrqvW+1FX3/ZFKS8CqHDXZ7OcwEoVkz3fUvP2bn2FbDSd00XqDVQ/ONJmOMN4OjBDQa4SEI3WFRKJ914+4vIGO1J4NXVuwuWyKdoawFQjbc4I9/pl2V5coAazmHrAB3ZYGLdKm7RxLY7hWgQVzlMbtMayhZReZiAc9aYqe9GuBdNbZ1OmWKvO4boPvASidAm6Xlwg0t9XlCWZkE2iqtsPiVBji/6KqLvxcoMu5lLVjuQA6KgnrMCF/SYYuR/DezGdwDxzBjsZx0bgWnaXwd+TiHOYBKqJfVOZIQ==
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 04:59:10 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::69) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.3 via Frontend Transport; Thu, 29
 Oct 2026 04:59:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:59:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 21:58:50 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 21:58:47 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Thu, 29 Oct 2026 13:58:08 +0900
Message-ID: <0d221cbd11c8b582d43b21e4156dfb7c83b121b3.1793243187.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7102e6d8-c517-4ab8-bcc8-08df35795e17
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|261028144727099003|56012099006|261009223027099003|261009221227099003|261026121527099003|261026140227099003|261022105027099003|261021135927099003|10067099003|11063799006|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 Epm9Amhatt3Dbo8GCNY5XKyBgwO5gVtExEb6mut8rqRfuNM1U6+EGXIgu7wfzVVrMADTwzv9x0JQVU9ya6ua4KzIVSC7XUGeHacCO1mPvjG2zVfvAPP1Xdz7b8YQqt30VWpcWsAW4uCDhqARrrj3Ol7dMpwqyqKHKBiYl9vEsw+05/lIB8eCVGlY2kF/tUOWEu/L40kSDDLrZ3ogmyMMNkPq6RWiPx2QgmILsVOaBdMSKwjxlaNvbz3g9jvQcMZ998rwRKwxPblbkYbfG3V2TpqsxC4Am6eMWdPScWYIy9jkT0uWhQyZNqHT0+SyilkDzryIeRJVjr2h8tsSK5CMvHmdV9H+MCfd3RKU0nVV/gbkEstbGjfCzAYXGSnO2DC+bYwvlVFU68gCLwlSo+kU+qgg7szEa/2LJ6fUa+Giotwh8ejSPWIeK2NplyPmKuupPs1MdXNWfrsn3kgEufIAbnuHSeis4VuTMyrOJ4NMQ+JlBc8awHYT5lr1MuAayD/ja2Thp6vNhCc/ugvaLAud/HS+T7daTaYOznXxnTdUHJhGLUGaDFFOsqLDWeX77NAxoQmHaDxA2HnFG0IU0vOWzID48twEOwRUcliKthwz8XwWBV2+rKUYrOuir+KUHPTmgv9ykJA0q0RN7PkkaahvmDEdQcVr0/Q8bwL77XPkFdvq7AEdDG7RiD1Gxak6cI6kT4/ALLlXZs8KvfDKuhB6rw==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(261028144727099003)(56012099006)(261009223027099003)(261009221227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021135927099003)(10067099003)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 7Gp6fpQUXEd80x0uFq95bzsU55WYE0JF/u4A7Cc0WKcRwvOlwEArVniVhB49WY1yA8pNlP7/1P69WoDcplbjTVpAWxsFD9F0CbUW2DzeP1LZXwJanhww2JckfrAQX3ev9dDAXR+nO05XwPqDh+yJr2Wv6oZPQLMtYU/UlqCrlBFJu8/AHaGt9oyybq3+YmwHJxsl9DGIo1UQAMoWVCB+mT/jAGuqPTBGN6+J7JHavf58UlLwUKCOxmVDfrTNH+y9X4q7GSh6XoIpeY97HLjVZ4iK9iFQToPEuDZ7BOfvIrcFFY/TU05G1RykqlKZVACwt6xL2l2VK90ZkJajM/5c0FZVxxw0K+/Xax9Hvqi9+50N66cQ9vtFvfvd030IxpTKKMXDuMU12/ttQ16K9K9Sum0LBuDr80zbbo3Hjyo80xXzKDLkXCbx+2hgc7IL5NgR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:59:09.3897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7102e6d8-c517-4ab8-bcc8-08df35795e17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,WEIRD_QUOTING autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the NVIDIA MGX Vera C2 BMC based on the
ASPEED AST2600 SoC.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1321 +++++++++++++++++
 2 files changed, 1322 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 6874b621d..e5c44d423 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
 	aspeed-bmc-nvidia-msx4-bmc.dtb \
+	aspeed-bmc-nvidia-vr-c2-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts
new file mode 100644
index 000000000..7e8ae8afe
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts
@@ -0,0 +1,1321 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "AST2600 MGX Vera C2 BMC";
+	compatible = "nvidia,vr-c2-bmc", "aspeed,ast2600";
+
+	aliases {
+		i2c16 = &i2c_usbhub;
+		i2c17 = &i2c_tpm;
+		i2c18 = &i2c_dp;
+		i2c19 = &i2c_rtc;
+		i2c20 = &i2c_fan_ctrl0;
+		i2c21 = &i2c_fan_ctrl1;
+		i2c22 = &i2c_fan_iox;
+		i2c23 = &i2c_fan_hsc;
+		i2c30 = &i2c_mcio_c0c1_north0;
+		i2c31 = &i2c_mcio_c0c1_north1;
+		i2c32 = &i2c_mcio_c0c1_north2;
+		i2c33 = &i2c_mcio_c0c1_north3;
+		i2c34 = &i2c_mcio_c0c1_north4;
+		i2c35 = &i2c_mcio_c0c1_north5;
+		i2c36 = &i2c_mcio_c0c1_north6;
+		i2c37 = &i2c_mcio_c0c1_north7;
+		i2c40 = &i2c_mcio_c0_south0;
+		i2c41 = &i2c_mcio_c0_south1;
+		i2c42 = &i2c_mcio_c0_south2;
+		i2c43 = &i2c_mcio_c0_south3;
+		i2c44 = &i2c_mcio_c0_south4;
+		i2c45 = &i2c_mcio_c0_south5;
+		i2c46 = &i2c_mcio_c0_south6;
+		i2c47 = &i2c_mcio_c0_south7;
+		i2c50 = &i2c_mcio_c1_south0;
+		i2c51 = &i2c_mcio_c1_south1;
+		i2c52 = &i2c_mcio_c1_south2;
+		i2c53 = &i2c_mcio_c1_south3;
+		i2c54 = &i2c_mcio_c1_south4;
+		i2c55 = &i2c_mcio_c1_south5;
+		i2c56 = &i2c_mcio_c1_south6;
+		i2c57 = &i2c_mcio_c1_south7;
+		serial2 = &uart3;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		bootargs = "console=tty0 console=ttyS4,115200n8 earlycon";
+		stdout-path = &uart5;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fault-led {
+			gpios = <&exp7 12 GPIO_ACTIVE_LOW>;
+		};
+
+		power-led {
+			gpios = <&exp7 8 GPIO_ACTIVE_LOW>;
+		};
+
+		uid-led {
+			gpios = <&exp7 10 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		framebuffer@9f000000 {
+			reg = <0x9f000000 0x01000000>;
+			no-map;
+		};
+
+		ramoops@a0000000 {
+			compatible = "ramoops";
+			reg = <0xa0000000 0x100000>;
+			max-reason = <2>;
+			record-size = <0x10000>;
+		};
+
+		framebuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x01000000>;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x02000000>;
+		};
+	};
+
+	standby_power_regulator: standby-power-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "standby_power";
+	};
+};
+
+/*
+ * NVIDIA multi-interface MCU enumerates as hid-generic by default
+ * and binds to hid-cp2112 at runtime
+ */
+&ehci1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@2 {
+			compatible = "usb424,2422";
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hub@1 {
+				compatible = "usb424,2514";
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				device@1 {
+					compatible = "usb955,cf11";
+					reg = <1>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cp2112: interface@1 {
+						compatible = "usbif955,cf11.config1.1";
+						reg = <1 1>;
+						#gpio-cells = <2>;
+						gpio-controller;
+						#interrupt-cells = <2>;
+						interrupt-controller;
+
+						i2c {
+							#address-cells = <1>;
+							#size-cells = <0>;
+
+							/* CPU0 IROT/thermal/SOCAMM/JTAG */
+							pca9555@50 {
+								compatible = "nxp,pca9555";
+								reg = <0x50>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+								"CPU0_IROT_RECOVERY_L_3V3-I",
+								"CPU0_IROT_FATAL_ERR_L_3V3-I",
+								"CPU0_OVERT_L-I",
+								"C0_THERM_WARN_N-I",
+								"C0_S0_THERM_OVERT_N-I",
+								"CPU0_CHIPTHROT_L-I",
+								"C0_SOCAMM_0_ID_PRSNT_N_1V8-I",
+								"C0_SOCAMM_1_ID_PRSNT_N-I",
+								"C0_SOCAMM_2_ID_PRSNT_N-I",
+								"C0_SOCAMM_3_ID_PRSNT_N-I",
+								"C0_SOCAMM_4_ID_PRSNT_N-I",
+								"C0_SOCAMM_5_ID_PRSNT_N-I",
+								"C0_SOCAMM_6_ID_PRSNT_N-I",
+								"C0_SOCAMM_7_ID_PRSNT_N-I",
+								"MCU_JTAG_BYPASS_CPU0_S-O",
+								"MCU_JTAG_BYPASS_CPU0-O";
+							};
+
+							/* CPU1 IROT/thermal/SOCAMM/JTAG */
+							pca9555@51 {
+								compatible = "nxp,pca9555";
+								reg = <0x51>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+								"CPU1_IROT_RECOVERY_L_3V3-I",
+								"CPU1_IROT_FATAL_ERR_L_3V3-I",
+								"CPU1_OVERT_L-I",
+								"C1_THERM_WARN_N-I",
+								"C1_S0_THERM_OVERT_N-I",
+								"CPU1_CHIPTHROT_L-I",
+								"C1_SOCAMM_0_ID_PRSNT_N-I",
+								"C1_SOCAMM_1_ID_PRSNT_N-I",
+								"C1_SOCAMM_2_ID_PRSNT_N-I",
+								"C1_SOCAMM_3_ID_PRSNT_N-I",
+								"C1_SOCAMM_4_ID_PRSNT_N-I",
+								"C1_SOCAMM_5_ID_PRSNT_N-I",
+								"C1_SOCAMM_6_ID_PRSNT_N-I",
+								"C1_SOCAMM_7_ID_PRSNT_N-I",
+								"MCU_JTAG_BYPASS_CPU1_S-O",
+								"MCU_JTAG_BYPASS_CPU1-O";
+							};
+
+							/* Module thermal/leak/MCU alerts */
+							pca9555@52 {
+								compatible = "nxp,pca9555";
+								reg = <0x52>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+								"COMBINED_CPU_CEM_WAKE_L-I",
+								"MCU_THERM_OVERT_N-I",
+								"MCU_THERM_WARN_N-I",
+								"PCB_T_SENSOR_ALERT_L-I",
+								"GLOBAL_WP_1V8-I",
+								"NVBUF_LOS_L-I",
+								"LEAK_DETECT_L-I",
+								"vLeakDetect1Status0-I",
+								"vLeakDetect1Status1-I",
+								"vLeakDetect2Status0-I",
+								"vLeakDetect2Status1-I",
+								"BMC_IOX_INT_L-I",
+								"MCU_BMC_ALERT_L-I",
+								"MCU_HMC_ALERT_L-I",
+								"MCU_USER_STRAP-I",
+								"HPM_MCU_OK-I";
+							};
+
+							/* CPLD status/OOB mux/pwr brake */
+							pca9555@53 {
+								compatible = "nxp,pca9555";
+								reg = <0x53>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+								"CPLD_RESET_L-I",
+								"CPLD_PSEQ_FAULT-I",
+								"CPLD_READY-I",
+								"CPLD_PROGRAM-I",
+								"INPUT_12V_VALID_VMON_PG-I",
+								"RUN_PWR_EN_1V8-I",
+								"MODULE_PWR_GOOD_1V8-I",
+								"MCU_I2C_RTC_ALERT_L-I",
+								"SLOT_PWR_BRAKE_EN_L-I",
+								"OOB_MUX_CTRL0-O",
+								"OOB_MUX_CTRL1-O",
+								"OOB_MUX_CTRL2-O",
+								"CPU_OOB_CS0_L-O",
+								"CPU_OOB_CS1_L-O",
+								"LEAK_SELF_TEST_L_1V8-I",
+								"MCU_RECOVERY_L-I";
+							};
+
+							/* JTAG route/SSIF alert/USB force */
+							pca9555@54 {
+								compatible = "nxp,pca9555";
+								reg = <0x54>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+								"JTAG_SEL_MCU-O",
+								"JTAG_TCK_MCU-O",
+								"JTAG_TMS_MCU-O",
+								"JTAG_TDO_MCU-I",
+								"JTAG_TDI_MCU-O",
+								"JTAG_TRST_L_MCU-O",
+								"CPU0_SSIF_ALERT_L_3V3-I",
+								"CPU1_SSIF_ALERT_L_1V8-I",
+								"USB_HMC_TO_CPU_FORCE_EN_L-O",
+								"v_CPLD_AUTH_FAIL-I",
+								"",
+								"",
+								"",
+								"",
+								"",
+								"";
+							};
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+/* Primary BMC flash: standard OpenBMC 64MB layout (env on FMC @ 0xe0000) */
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
+
+		status = "okay";
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+
+	/*A0-A7*/
+	"", "", "", "", "", "", "", "",
+
+	/*B0-B7*/
+	"", "", "", "", "", "", "", "",
+
+	/*C0-C7*/
+	"SGPIO_I2C_MUX_SEL-O",
+	"", "", "", "", "", "", "",
+
+	/*D0-D7*/
+	"", "", "",
+	"UART1_MUX_SEL-O",
+	"",
+	"FPGA_PEX_RST_L-O",
+	"", "",
+
+	/*E0-E7*/
+	"RTL8221_PHY_RST_L-O",
+	"RTL8211_PHY_INT_L-I",
+	"",
+	"UART3_MUX_SEL-O",
+	"", "", "",
+	"SGPIO_BMC_EN-O",
+
+	/*F0-F7*/
+	"", "", "", "", "", "", "", "",
+
+	/*G0-G7*/
+	"", "", "", "", "", "", "", "",
+
+	/*H0-H7*/
+	"", "", "", "", "", "", "", "",
+
+	/*I0-I7*/
+	"", "", "", "", "",
+	"QSPI2_RST_L-O",
+	"GLOBAL_WP_BMC-O",
+	"BMC_DDR4_TEN-O",
+
+	/*J0-J7*/
+	"", "", "", "", "", "", "", "",
+
+	/*K0-K7*/
+	"", "", "", "", "", "", "", "",
+
+	/*L0-L7*/
+	"", "", "", "", "", "", "", "",
+
+	/*M0-M7*/
+	"PCIE_EP_RST_EN-O",
+	"BMC_FRU_WP-O",
+	"HMC_RESET_L-O",
+	"STBY_POWER_EN-O",
+	"STBY_POWER_PG-I",
+	"PCIE_EP_RST_L-O",
+	"", "",
+
+	/*N0-N7*/
+	"", "", "", "", "", "", "", "",
+
+	/*O0-O7*/
+	"", "", "", "", "", "", "", "",
+
+	/*P0-P7*/
+	"", "", "", "", "", "", "", "",
+
+	/*Q0-Q7*/
+	"", "", "", "", "", "", "", "",
+
+	/*R0-R7*/
+	"", "", "", "", "", "", "", "",
+
+	/*S0-S7*/
+	"", "", "", "", "", "", "", "",
+
+	/*T0-T7*/
+	"", "", "", "", "", "", "", "",
+
+	/*U0-U7*/
+	"", "", "", "", "", "", "", "",
+
+	/*V0-V7*/
+	"AP_EROT_REQ-O",
+	"EROT_AP_GNT-I",
+	"",
+	"",
+	"PCB_TEMP_ALERT-I",
+	"", "", "",
+
+	/*W0-W7*/
+	"", "", "", "", "", "", "",
+	"CPU_RST_L-I",
+
+	/*X0-X7*/
+	"", "",
+	"TPM_MUX_SEL-O",
+	"", "", "", "", "",
+
+	/*Y0-Y7*/
+	"", "", "",
+	"EMMC_RST-O",
+	"","", "", "",
+
+	/*Z0-Z7*/
+	"","", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*A0-A7*/
+	"", "", "", "", "", "", "", "",
+
+	/*B0-B7*/
+	"", "", "", "",
+	"AP_EROT_REQ-O",
+	"EROT_AP_GNT-I",
+	"IO_EXPANDER_INT_L-I",
+	"",
+
+	/*C0-C7*/
+	"", "", "", "", "", "", "", "",
+
+	/*D0-D7*/
+	"", "", "", "", "", "", "",
+	"I2C_SSIF_ALERT_L-I",
+
+	/*E0-E7*/
+	"", "", "", "", "", "", "", "";
+};
+
+/* Host CPU SSIF (IPMI) */
+&i2c0 {
+	status = "okay";
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+/* Board 0 management bus 1: GPIO expanders + HPM MCU MCTP */
+&i2c1 {
+	mctp-controller;
+	multi-master;
+
+	status = "okay";
+
+	/* MCTP for HPM MCU */
+	mctp@18 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x18 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	/* Board 0 management bus 1 GPIO expander 0 */
+	pca9555@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"B0_M1_MCU_RESET_L-O",
+		"B0_M1_MCU_RECOVERY_L-O",
+		"B0_M1_I2C_SOCAMM_UPHY_SEL-O",
+		"B0_M1_SNN_GPU0_MCU_REC_L",
+		"B0_M1_THERM_OVERT_L-I",
+		"B0_M1_THERM_WARN_L-I",
+		"B0_M1_HMC_IST_PRE_RST_L-O",
+		"B0_M1_CPLD_READY-I",
+		"B0_M1_MODULE_PWR_GOOD-I",
+		"B0_M1_MCU_HMC_ALERT_L-I",
+		"B0_M1_USB1_HUB_RST_L-O",
+		"B0_M1_HPM_MCU_OK-I",
+		"B0_M1_CPU_SHDN_OK_L_3V3-I",
+		"B0_M1_SNN_BOARD_LOC_STRAP",
+		"B0_M1_IST_SYS_RST_L-O",
+		"B0_M1_PWR_BRAKE_L_STATUS-I";
+	};
+
+	/* Board 0 management bus 1 GPIO expander 1 */
+	pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"B0_M1_CPU_FORCED_RECOVERY_L-O",
+		"B0_M1_CPU_BOOT_DEV_SEL0-O",
+		"B0_M1_CPU_BOOT_DEV_SEL1-O",
+		"B0_M1_CPU_BOOT_DEV_SEL2-O",
+		"B0_M1_HMC_BRD_ID0",
+		"B0_M1_CPU_RECOVERY_TYPE0-O",
+		"B0_M1_CPU_RECOVERY_TYPE1-O",
+		"B0_M1_CPU_IST_BOOT_HMC-O",
+		"B0_M1_CPU_PREBOOT_DIAG-O",
+		"B0_M1_HMC_BRD_ID1",
+		"B0_M1_HPM_MCU_I2C_ENABLE-O",
+		"B0_M1_CPU_DIE_SEL0-O",
+		"B0_M1_CPU_DIE_SEL1-O",
+		"B0_M1_CPU_DIE_SEL2-O",
+		"B0_M1_CPU_BOOT_COMPLETE-O",
+		"B0_M1_IOX_JTAG_NVSEL-O";
+	};
+};
+
+/* Board 0 management bus 0 GPIO expanders */
+&i2c2 {
+	status = "okay";
+
+	/* Board 0 management bus 0 GPIO expander 0 */
+	pca9555@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"B0_M0_SHDN_FORCE_L-O",
+		"B0_M0_STBY_PWR_PG-I",
+		"B0_M0_THERM_OVERT_L-I",
+		"B0_M0_THERM_WARN_L-I",
+		"B0_M0_GLOBAL_WP-O",
+		"B0_M0_USB0_HUB_RST_L-O",
+		"B0_M0_IOX_PRE_SYS_RST_N-O",
+		"B0_M0_LEAK_DETECT_ALERT_L-I",
+		"B0_M0_RUN_PWR_EN-O",
+		"B0_M0_MODULE_PWR_GOOD-I",
+		"B0_M0_CPU_CHIPTHROT_L_3V3-I",
+		"B0_M0_SHDN_REQ_L_3V3-O",
+		"B0_M0_CPU_SHDN_OK_L_3V3-I",
+		"B0_M0_CPLD_READY-I",
+		"B0_M0_PWR_BRAKE_L_3V3-O",
+		"B0_M0_PWR_BRAKE_L_STATUS-I";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 1 */
+	pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"B0_M0_I2C_BUS_MUX_RST_L-O",
+		"B0_M0_HPM_MCU_OK-I",
+		"B0_M0_CPU_SYS_RST_N_3V3-I",
+		"B0_M0_C0_SOCAMM_DAC_I2C_SEL_R-O",
+		"B0_M0_C1_SOCAMM_DAC_I2C_SEL_R-O",
+		"B0_M0_C0_SOCAMM_I2C_SEL-O",
+		"B0_M0_C1_SOCAMM_I2C_SEL-O",
+		"B0_M0_EEPROM_POWER_DISABLE-O",
+		"B0_M0_CPU_L0L1_RST_L_3V3-I",
+		"B0_M0_CPU_L2_RST_L_3V3-I",
+		"B0_M0_BRD_ID_0",
+		"B0_M0_BRD_ID_1",
+		"B0_M0_BMC_LEAK_TEST_L-O",
+		"B0_M0_MCU_BMC_ALERT_L-I",
+		"B0_M0_CPU_BOOT_COMPLETE_3V3-I",
+		"B0_M0_SNN_GPU_MCU_I2C_ENABLE";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 2 */
+	pca9555@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"B0_M0_C0_UPHY0_PRSNT0_L-I",
+		"B0_M0_C0_UPHY0_PRSNT1_L-I",
+		"B0_M0_C0_UPHY0_PRSNT2_L-I",
+		"B0_M0_C0_UPHY0_PRSNT3_L-I",
+		"B0_M0_C0_UPHY1_PRSNT0_L-I",
+		"B0_M0_C0_UPHY1_PRSNT1_L-I",
+		"B0_M0_RSVD_C0_UPHY1_PRSNT2_L",
+		"B0_M0_RSVD_C0_UPHY1_PRSNT3_L",
+		"B0_M0_C0_UPHY2_PRSNT0_L-I",
+		"B0_M0_C0_UPHY2_PRSNT1_L-I",
+		"B0_M0_C0_UPHY2_PRSNT2_L-I",
+		"B0_M0_C0_UPHY2_PRSNT3_L-I",
+		"B0_M0_C0_UPHY3_PRSNT0_L-I",
+		"B0_M0_C0_UPHY3_PRSNT1_L-I",
+		"B0_M0_RSVD_C0_UPHY3_PRSNT2_L",
+		"B0_M0_RSVD_C0_UPHY3_PRSNT3_L";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 3 */
+	pca9555@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"B0_M0_C1_UPHY0_PRSNT0_L-I",
+		"B0_M0_C1_UPHY0_PRSNT1_L-I",
+		"B0_M0_C1_UPHY0_PRSNT2_L-I",
+		"B0_M0_C1_UPHY0_PRSNT3_L-I",
+		"B0_M0_RSVD_C1_UPHY1_PRSNT0_L",
+		"B0_M0_C1_UPHY1_PRSNT1_L-I",
+		"B0_M0_RSVD_C1_UPHY1_PRSNT2_L",
+		"B0_M0_RSVD_C1_UPHY1_PRSNT3_L",
+		"B0_M0_C1_UPHY2_PRSNT0_L-I",
+		"B0_M0_C1_UPHY2_PRSNT1_L-I",
+		"B0_M0_C1_UPHY2_PRSNT2_L-I",
+		"B0_M0_C1_UPHY2_PRSNT3_L-I",
+		"B0_M0_C1_UPHY3_PRSNT0_L-I",
+		"B0_M0_C1_UPHY3_PRSNT1_L-I",
+		"B0_M0_RSVD_C1_UPHY3_PRSNT2_L",
+		"B0_M0_RSVD_C1_UPHY3_PRSNT3_L";
+	};
+};
+
+/* MCIO expansion muxes */
+&i2c4 {
+	multi-master;
+
+	status = "okay";
+
+	mctp@18 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x18 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&standby_power_regulator>;
+
+		i2c_mcio_c0_south0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&standby_power_regulator>;
+
+		i2c_mcio_c0c1_north0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9548";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&standby_power_regulator>;
+
+		i2c_mcio_c1_south0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* SMM carrier GPIO expanders */
+&i2c5 {
+	status = "okay";
+
+	/* SMM carrier GPIO expander 0 */
+	exp7: pca9555@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"HMC_RST_R_L-O",
+		"HMC_RECOVERY_R-O",
+		"HMC_SPI_MUX_R_SEL-O",
+		"GLOBAL_WP-O",
+		"HMC_READY-I",
+		"HMC_PRSNT_R-I",
+		"BMC_SELF_PWR_CYCLE-O",
+		"EEDO_LED2-O",
+		"PWR_LED_L-O",
+		"PWR_BTN_L-I",
+		"UID_LED_L-O",
+		"UID_BTN_L-I",
+		"FAULT_LED_L-O",
+		"USB2_HUB_RST_L-O",
+		"IOX_GPIO_P16_TP",
+		"WARN_LED_L-O";
+	};
+
+	/* SMM carrier GPIO expander 1 */
+	pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"BMC_HMC_MUX_SEL-O",
+		"BMC_TPM_MUX_SEL-O",
+		"BMC_USB2_MUX_SEL-O",
+		"HMC_PGOOD_3V3-I",
+		"BF3_AOC_NCSI_PRSNT_L-I",
+		"HDR_SPI_PRSNT_L-I",
+		"SW_NRESET_R_L-O",
+		"MUX_I2C_ESPI_SEL-O",
+		"I2C_BUS_MUX_RESET_L-O",
+		"USB_MUX_EN-O",
+		"PDB_TRAY_RST-O",
+		"USB_PWR_EN-O",
+		"RTC_CLR_L-O",
+		"I2C_RTC_ALERT_L-I",
+		"I2C_PDB_ALERT_L-I",
+		"BMC_MUX_PI3DP_SEL-O";
+	};
+};
+
+/* Leak and fan path via PCA9546 */
+&i2c6 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		/* USB hub I2C */
+		i2c_usbhub: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* TPM */
+		i2c_tpm: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* DisplayPort aux */
+		i2c_dp: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* RTC */
+		i2c_rtc: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* M.2 SSD management */
+&i2c8 {
+	status = "okay";
+};
+
+/* Power distribution board */
+&i2c9 {
+	status = "okay";
+
+	exp21: pca9555@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"PDB_TYPE-I",
+		"PDB_STBY_PWR_EN-O",
+		"PDB_STBY_PWR_OK-I",
+		"PDB_MCU_RECOVERY_L-O",
+		"PDB_MCU_RST_L-O",
+		"PDB_MAIN_PWR_EN-O",
+		"PDB_MAIN_PWR_OK-I",
+		"PDB_GLB_WP-O",
+		"PDB_PWR_BRK_L-I",
+		"PDB_FAN_CTL_PRSNT_L-I",
+		"PDB_P12V_HPM_EN-O",
+		"PDB_MUX_SEL-O",
+		"PDB_P12V_GPU1_EN-O",
+		"PDB_P12V_GPU2_EN-O",
+		"PDB_PSU_PWOK-I",
+		"PDB_PS_ON_L-O";
+	};
+};
+
+/* PDB mux-gpios: 0 = PSU, 1 = fan */
+/ {
+	i2c-mux-pdb {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-parent = <&i2c9>;
+		mux-gpios = <&exp21 11 GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+
+		/* PSU devices */
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* Fan board devices */
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-mux@76 {
+				compatible = "nxp,pca9546";
+				reg = <0x76>;
+				#address-cells = <1>;
+				i2c-mux-idle-disconnect;
+				#size-cells = <0>;
+
+				i2c_fan_ctrl0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c_fan_ctrl1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c_fan_iox: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c_fan_hsc: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+	};
+};
+
+/* BMC FRU EEPROM and temperature sensor */
+&i2c10 {
+	status = "okay";
+
+	/* BMC FRU EEPROM */
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+/* Module 0 UPHY3 SMBus */
+&i2c14 {
+	status = "okay";
+};
+
+/* Module 1 UPHY3 SMBus */
+&i2c15 {
+	status = "okay";
+};
+
+/* Fan controller 0 */
+&i2c_fan_ctrl0 {
+	max31790@2c {
+		compatible = "maxim,max31790";
+		reg = <0x2c>;
+	};
+};
+
+/* Fan controller 1 */
+&i2c_fan_ctrl1 {
+	max31790@2f {
+		compatible = "maxim,max31790";
+		reg = <0x2f>;
+	};
+};
+
+/* Fan board GPIO expanders */
+&i2c_fan_iox {
+	pca9555@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"FAN_P12V_FAN12_EN-O",
+		"FAN_P12V_FAN34_EN-O",
+		"FAN_P12V_FAN56_EN-O",
+		"FAN_P12V_FAN12_PG-I",
+		"FAN_P12V_FAN34_PG-I",
+		"FAN_P12V_FAN56_PG-I",
+		"",
+		"",
+		"FAN_FAN1_PRSNT_BUF_L-I",
+		"FAN_FAN2_PRSNT_BUF_L-I",
+		"FAN_FAN3_PRSNT_BUF_L-I",
+		"FAN_FAN4_PRSNT_BUF_L-I",
+		"FAN_FAN5_PRSNT_BUF_L-I",
+		"FAN_FAN6_PRSNT_BUF_L-I",
+		"FAN_FANCTRL_FAIL_L-I",
+		"FAN_FANCTRL2_FAIL_L-I";
+	};
+
+	pca9555@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"FAN_FAN1_FAIL_LED-O",
+		"FAN_FAN2_FAIL_LED-O",
+		"FAN_FAN3_FAIL_LED-O",
+		"FAN_FAN4_FAIL_LED-O",
+		"FAN_FAN5_FAIL_LED-O",
+		"FAN_FAN6_FAIL_LED-O",
+		"",
+		"",
+		"FAN_VR_P12V_FAN12_ALERT-I",
+		"FAN_VR_P12V_FAN34_ALERT-I",
+		"FAN_P12V_FAN56_ALERT-I",
+		"",
+		"",
+		"",
+		"",
+		"";
+	};
+};
+
+/* GPU1 GPIO expander (C1) */
+&i2c_mcio_c0_south0 {
+	/* GPU 1, Expander @0x20 */
+	pca6408@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"GPU1_GLOBAL_WP-O",
+		"GPU1_OOB_RST_N-O",
+		"GPU1_OOB_RECOVERY-O",
+		"GPU1_MCU_RECOVERY_N-O",
+		"GPU1_MCU_RST_N-O",
+		"GPU1_MCU_BYPASS_N-O",
+		"GPU1_SMBUS_FRU_EEPROM_WP-O",
+		"";
+	};
+};
+
+/* GPU0 GPIO expander */
+&i2c_mcio_c0_south2 {
+	/* GPU 0, Expander @0x20 */
+	pca6408@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"GPU0_GLOBAL_WP-O",
+		"GPU0_OOB_RST_N-O",
+		"GPU0_OOB_RECOVERY-O",
+		"GPU0_MCU_RECOVERY_N-O",
+		"GPU0_MCU_RST_N-O",
+		"GPU0_MCU_BYPASS_N-O",
+		"GPU0_SMBUS_FRU_EEPROM_WP-O",
+		"";
+	};
+};
+
+/* E1.S backplane GPIO expander (C1) */
+&i2c_mcio_c0c1_north3 {
+	/* E1S Backplane, Expander @0x20 */
+	pca6408@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"E1S_MCU_RESET_L-O",
+		"E1S_MCU_RECOVERY_L-O",
+		"",
+		"",
+		"",
+		"",
+		"E1S_LOWER_PERST-O",
+		"E1S_UPPER_PERST-O";
+	};
+};
+
+/* E1.S backplane GPIO expander (C2) */
+&i2c_mcio_c0c1_north6 {
+	/* E1S Backplane, Expander @0x20 */
+	pca6408@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"E1S_MCU_RESET_L-O",
+		"E1S_MCU_RECOVERY_L-O",
+		"",
+		"",
+		"",
+		"",
+		"E1S_LOWER_PERST-O",
+		"E1S_UPPER_PERST-O";
+	};
+};
+
+/* GPU1 GPIO expander (C2) */
+&i2c_mcio_c1_south0 {
+	/* GPU 1, Expander @0x20 */
+	pca6408@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+		"GPU1_GLOBAL_WP-O",
+		"GPU1_OOB_RST_N-O",
+		"GPU1_OOB_RECOVERY-O",
+		"GPU1_MCU_RECOVERY_N-O",
+		"GPU1_MCU_RST_N-O",
+		"GPU1_MCU_BYPASS_N-O",
+		"GPU1_SMBUS_FRU_EEPROM_WP-O",
+		"";
+	};
+};
+
+/*
+ * On-board PHY uses RX and TX RGMII internal delays
+ * so phy-mode is rgmii-id
+ */
+&mac0 {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+/* NCSI MAC */
+&mac2 {
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	pinctrl-names = "default";
+	use-ncsi;
+
+	status = "okay";
+};
+
+/* MDIO for schematic MAC1 PHY */
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+/* BMC <-> host CPU UART */
+&uart1 {
+	status = "okay";
+};
+
+/* Serial-over-LAN */
+&uart3 {
+	status = "okay";
+};
+
+/* BMC debug console */
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+/* USB device toward host */
+&vhub {
+	status = "okay";
+};
+
+/* Video engine */
+&video {
+	memory-region = <&video_engine_memory>;
+
+	status = "okay";
+};
-- 
2.43.0


