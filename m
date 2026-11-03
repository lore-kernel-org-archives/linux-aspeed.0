Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A78606A327
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gEhYhqCB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJn125YXWz2xb9;
	Tue, 03 Nov 2026 22:49:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793706566;
	cv=pass; b=fkk3jhBjh++JYpKMi7HrMgdoP5wKNBzI47e40KhS6cXz/O2PFCZJU4ytGPchWT0z0dxLolURKq76WQAAxCjut8MvrPHvxLBJC0Y+aaoPaX9OLSHvRUF0NuZBQhkGyxJ1pJEdaHttB026dyp2+O9NGYzV5lHb3cItFIEyaSA84ex3971ScPBimighHA4Uf5lFN44tIBjoA1rDB/WUjej/j8jUmMyf3PMWWszdm38BuM0W9ZFrGIBm2Js8JpWpyoEfTnbGicj8c/grE+/6b0LbZ4C3SwM7X+icSqOimF2OMJ6XCZ4FePa0Yuw7Ku/kyY03Z1vNgE/6zbbgF1paPwKWvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793706566; c=relaxed/relaxed;
	bh=cCuCb0lliVBRqkRjxIa3pFElaQQjmE/R0jHATyoQMKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEZN1iXNBBMWjDOtfYlZ4p8XSvihwCOetqCTHzV52wsAFJK0xXz4xSo/2MORxcXSafPZHs8dbsY7eeR//NLpqIlDEv8VNKFLMpQuoCE4t9ZfBSq264NFhWggE6qIAoFvbpNdIUqC/gwbMoFLgJ5h8GXtSylSd8qM5Q42SDjziXiTd2y+SqDhsUJseZu0X0gFsuRd6rkTDqJRj0zd18Xhr6JUURA8hmKsXKCQivOeS/FMqSBMxfV3vLeWu8ZszNXOCXmPoDpp7dSxnhHFZ9i6uFawSc9FHd5PpDjfqyrMCS0d1YZfDVm0AJXH7ecGOK7pGvN1Y0Wrp5qq8F+xLMC5VA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gEhYhqCB; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gEhYhqCB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJn111m4fz2xH9;
	Tue, 03 Nov 2026 22:49:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCn3g5nqdL45raCjUaKt6lCy5yB+bS3eE+O3ibzAEc7+fnL3XsxnkrE5q8DrD5uE8JGqDm19z3XWWwbAn8pwm2TG10yaUbo6SF64XFxrgMqwHYxZ11TvW9Gip9TSZ0ZEgFB9Ks+Sl7SCVIvgPJp++BtU6Z2qtOtYJ7Q/gWbkHpD78QxgJyAiJD8CGLYG4DX7A3B8WzzYLSB92J60gqzmLALp5uuPgk1kN3V9pM3U2to2UwJxlsg8HF9owPqK46rZQytBlOJyMI0lUgzEYCE+OVs0B0LTq7LlOl1BtUw3tjs5aqJkUqS+0rOXZI/lq2luyJrNqqUOjvayQCKuQO9wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCuCb0lliVBRqkRjxIa3pFElaQQjmE/R0jHATyoQMKk=;
 b=plX8At6VICgORU8j8kKqHa+WltPIdITl5ikN4KH2wUnFKb+x9rLoegnrYqSQB+Aaot7uQVyKkudnpz1iWwS/OWJ2KKfM7+PXPvLTwfE+oZvklDE1iUL7fiyb3gBWSNTVMgUT2V9UbbbQ+1tFVZf8/pArvT7h3ZT+21K/fQdQ7hLpgA1wELz9vPcZdQse8CHuHeTX/lFwVdqAtupdEl+gDKuUMUW+IEQ3vAdhIC9tmUNUkGjjjYjZBdoLjCkzNy2c/2cstb0h+5rAQA4vya8Xa4K/GkEvHvQ5zixhveeu4BvWi6L3DJlIatHjbGrZJD/DL6IqDDvc/knyUb+WPqbQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCuCb0lliVBRqkRjxIa3pFElaQQjmE/R0jHATyoQMKk=;
 b=gEhYhqCBUuv+vggAJQKzooWCVf+Va0BtIx5q6RrWeK9oJ8WSIZvoS6E7pnYEW9drm6esQdiDludhTYNNaOnnlxmCHgoY/jUAWqQHFEPGbR36hkekvRHpsyAu8PUn3h9TrN5XApZVi30qGaY+QpNf3d7EWYE28kU+rMEmiZOq4Wi+qj9sHii7QV+YV8xiKWKZJbH0GGUhuDJCIlO1dPIUa1R3C8TJnrITyHr5dIyx3gRGxakLaiXNthJLjRexT9YFEZMxcB+gQ+B1QBQCnnSBJi3ABfwcdx8Sctntsjw935NfOilaUuwQzF1Z3MHqorL95VWlMXO0O8NrxF77LEG+MA==
Received: from CH0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:610:77::24)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Tue, 3 Nov 2026 11:48:57 +0000
Received: from CH3PEPF0002457C.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::24) by CH0PR04CA0049.outlook.office365.com
 (2603:10b6:610:77::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 11:48:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0002457C.mail.protection.outlook.com (10.167.252.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 11:48:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:48:39 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 03:48:37 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Jacky Huang <jackyhuang@nvidia.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
	<devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Tue, 3 Nov 2026 20:47:53 +0900
Message-ID: <70b7dd4c538ce72a2caf3b4420af3889e9b2dab7.1793705210.git.jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793705210.git.jackyhuang@nvidia.com>
References: <cover.1793705210.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457C:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 362d4d0c-0ce8-4b75-8e9c-08df39a0710b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|82310400026|36860700016|1800799024|376014|23010399003|3023799007|22082099003|56012099006|261102123227099003|10067099003|18002099003|261009223027099003|261009221227099003|261021123027099003|261022105027099003|261021121427099003|261021135927099003|261022075727099003|11063799006|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 II+i9FPnvrfafqTjQxeDiYEHH890H/zUcPahQ7PM7w/Q2rpeVTPfYIDeFjr+TWKXtOQ/3OqyXWbiq6TNTfvfMOUi/thu19ba2fFLaid58EaconbA4LRKUe7AnttxPFDdJuCdbDGt1Bu8WSzsD3/8p9tFE8dcHP7No5+6PRUeqeXkwM00iYL8gYjPHnIgFQ3nV4QiTEn/qAf7t7wQVik0J7BIMU5DGctxYN5jGNjm6Wkfb3wtQnhdUgqYAcUoL6Jn+IA+iIrYed0S/1GCkIsBO1ltGhAA6NBIV4wucQaSZ2dR0V1K3k5ngEXtZ7fRQBudcbGmhWCXGRTdRfujyBJGnKewihlhrxq3RauXJCrkd3bHHCXjxdNg1b6tVXP9Veo0bHyQy4LjGlXfKgxyVCWbjpPMPcqq8Ffga7cvguy3xrGKlg/fFI+QWn5TR0JQe+p4JO6jj+K4qNZhxnPBpkQLrXsRMoZzM6qzvJdRyXMlcmjyiHa0mwhjMJer+ctPaT+3PwTpWjM2T/VBXnZkX6gAE5+IQj1f0ymwSt6WEtVeHZDC8iopc1hILS6nKFMD78SV5c9e7a00MOMAnisoTL3eQHYYbgrrY7NyvR1B0v+fj7NEEDfoVuaS5iTxrVPQrZqnmcc25zr1b1FYPM0XpjKe0GxAeMqcpKc1c3ykb8rihoaXWdmHBlVG+XNZ2njZ7dgFXDotCuZBzaTX+D1A0+NJpg==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(3023799007)(22082099003)(56012099006)(261102123227099003)(10067099003)(18002099003)(261009223027099003)(261009221227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261021135927099003)(261022075727099003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 Al+f+7yo/d7TMSWo/RuTLsUIDv1dp0m6tHDARWcJjA8R0JwvaI/hqBvvrj9ceDHGb17TXtCSxMAIZvqGyZbxP2pEdZv1aZ6ISfyT0a1dKvUd67O3X2hSfbSzV3ou/qe/RCbqTh9DllbPBmFRs53LSkyRp5yJZRaIy+57+wgE9kom3+QWjkoqQZ9fBNjtrS/pNnFMvb6mrrzxJypykeXIZq+Tt8ZUgrLumzW4/v/5ghzMvR9X1vRwBSQ2Mmh5gj4q2RQF4w29AZTtAOTD0rvQe8JN3WmjrU/MPbZwULuYw3i45isbLTCuK5LkGvAzmYzXcQi9MQYNoG3uOCErjGPpKpNn9QFHkUWLtqcho9USkAHPgagKs4AqQnXvCwx172YYyYZn4JJEweHpUvPrhC2vhWJ64+l83cRcYai3XiCM8u9kHlMsCA5Ld7Gl4mrYEw3V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:48:56.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362d4d0c-0ce8-4b75-8e9c-08df39a0710b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the NVIDIA MGX Vera C2 BMC based on the
ASPEED AST2600 SoC.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
Changes in v2:
- Specify the console and baud rate in stdout-path and drop bootargs.
- Use generic GPIO expander, fan controller and regulator node names.
- Fix gpio-line-names indentation and GPIO bank comment formatting.
- Remove duplicate GPIO line names.

 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1275 +++++++++++++++++
 2 files changed, 1276 insertions(+)
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
index 000000000..a044dfa00
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts
@@ -0,0 +1,1275 @@
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
+		stdout-path = "serial4:115200n8";
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
+	standby_power_regulator: regulator-standby-power {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "standby_power";
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
+							gpio@50 {
+								compatible = "nxp,pca9555";
+								reg = <0x50>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"CPU0_IROT_RECOVERY_L_3V3-I",
+									"CPU0_IROT_FATAL_ERR_L_3V3-I",
+									"CPU0_OVERT_L-I",
+									"C0_THERM_WARN_N-I",
+									"C0_S0_THERM_OVERT_N-I",
+									"CPU0_CHIPTHROT_L-I",
+									"C0_SOCAMM_0_ID_PRSNT_N_1V8-I",
+									"C0_SOCAMM_1_ID_PRSNT_N-I",
+									"C0_SOCAMM_2_ID_PRSNT_N-I",
+									"C0_SOCAMM_3_ID_PRSNT_N-I",
+									"C0_SOCAMM_4_ID_PRSNT_N-I",
+									"C0_SOCAMM_5_ID_PRSNT_N-I",
+									"C0_SOCAMM_6_ID_PRSNT_N-I",
+									"C0_SOCAMM_7_ID_PRSNT_N-I",
+									"MCU_JTAG_BYPASS_CPU0_S-O",
+									"MCU_JTAG_BYPASS_CPU0-O";
+							};
+
+							/* CPU1 IROT/thermal/SOCAMM/JTAG */
+							gpio@51 {
+								compatible = "nxp,pca9555";
+								reg = <0x51>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"CPU1_IROT_RECOVERY_L_3V3-I",
+									"CPU1_IROT_FATAL_ERR_L_3V3-I",
+									"CPU1_OVERT_L-I",
+									"C1_THERM_WARN_N-I",
+									"C1_S0_THERM_OVERT_N-I",
+									"CPU1_CHIPTHROT_L-I",
+									"C1_SOCAMM_0_ID_PRSNT_N-I",
+									"C1_SOCAMM_1_ID_PRSNT_N-I",
+									"C1_SOCAMM_2_ID_PRSNT_N-I",
+									"C1_SOCAMM_3_ID_PRSNT_N-I",
+									"C1_SOCAMM_4_ID_PRSNT_N-I",
+									"C1_SOCAMM_5_ID_PRSNT_N-I",
+									"C1_SOCAMM_6_ID_PRSNT_N-I",
+									"C1_SOCAMM_7_ID_PRSNT_N-I",
+									"MCU_JTAG_BYPASS_CPU1_S-O",
+									"MCU_JTAG_BYPASS_CPU1-O";
+							};
+
+							/* Module thermal/leak/MCU alerts */
+							gpio@52 {
+								compatible = "nxp,pca9555";
+								reg = <0x52>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"COMBINED_CPU_CEM_WAKE_L-I",
+									"MCU_THERM_OVERT_N-I",
+									"MCU_THERM_WARN_N-I",
+									"PCB_T_SENSOR_ALERT_L-I",
+									"GLOBAL_WP_1V8-I",
+									"NVBUF_LOS_L-I",
+									"LEAK_DETECT_L-I",
+									"vLeakDetect1Status0-I",
+									"vLeakDetect1Status1-I",
+									"vLeakDetect2Status0-I",
+									"vLeakDetect2Status1-I",
+									"BMC_IOX_INT_L-I",
+									"MCU_BMC_ALERT_L-I",
+									"MCU_HMC_ALERT_L-I",
+									"MCU_USER_STRAP-I",
+									"HPM_MCU_OK-I";
+							};
+
+							/* CPLD status/OOB mux/pwr brake */
+							gpio@53 {
+								compatible = "nxp,pca9555";
+								reg = <0x53>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"CPLD_RESET_L-I",
+									"CPLD_PSEQ_FAULT-I",
+									"CPLD_READY-I",
+									"CPLD_PROGRAM-I",
+									"INPUT_12V_VALID_VMON_PG-I",
+									"RUN_PWR_EN_1V8-I",
+									"MODULE_PWR_GOOD_1V8-I",
+									"MCU_I2C_RTC_ALERT_L-I",
+									"SLOT_PWR_BRAKE_EN_L-I",
+									"OOB_MUX_CTRL0-O",
+									"OOB_MUX_CTRL1-O",
+									"OOB_MUX_CTRL2-O",
+									"CPU_OOB_CS0_L-O",
+									"CPU_OOB_CS1_L-O",
+									"LEAK_SELF_TEST_L_1V8-I",
+									"MCU_RECOVERY_L-I";
+							};
+
+							/* JTAG route/SSIF alert/USB force */
+							gpio@54 {
+								compatible = "nxp,pca9555";
+								reg = <0x54>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"JTAG_SEL_MCU-O",
+									"JTAG_TCK_MCU-O",
+									"JTAG_TMS_MCU-O",
+									"JTAG_TDO_MCU-I",
+									"JTAG_TDI_MCU-O",
+									"JTAG_TRST_L_MCU-O",
+									"CPU0_SSIF_ALERT_L_3V3-I",
+									"CPU1_SSIF_ALERT_L_1V8-I",
+									"USB_HMC_TO_CPU_FORCE_EN_L-O",
+									"v_CPLD_AUTH_FAIL-I",
+									"",
+									"",
+									"",
+									"",
+									"",
+									"";
+							};
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+/* Primary BMC flash: standard OpenBMC 64MB layout */
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
+
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+		/* A0-A7 */
+		"", "", "", "", "", "", "", "",
+
+		/* B0-B7 */
+		"", "", "", "", "", "", "", "",
+
+		/* C0-C7 */
+		"SGPIO_I2C_MUX_SEL-O",
+		"", "", "", "", "", "", "",
+
+		/* D0-D7 */
+		"", "", "",
+		"UART1_MUX_SEL-O",
+		"",
+		"FPGA_PEX_RST_L-O",
+		"", "",
+
+		/* E0-E7 */
+		"RTL8221_PHY_RST_L-O",
+		"RTL8211_PHY_INT_L-I",
+		"",
+		"UART3_MUX_SEL-O",
+		"", "", "",
+		"SGPIO_BMC_EN-O",
+
+		/* F0-F7 */
+		"", "", "", "", "", "", "", "",
+
+		/* G0-G7 */
+		"", "", "", "", "", "", "", "",
+
+		/* H0-H7 */
+		"", "", "", "", "", "", "", "",
+
+		/* I0-I7 */
+		"", "", "", "", "",
+		"QSPI2_RST_L-O",
+		"GLOBAL_WP_BMC-O",
+		"BMC_DDR4_TEN-O",
+
+		/* J0-J7 */
+		"", "", "", "", "", "", "", "",
+
+		/* K0-K7 */
+		"", "", "", "", "", "", "", "",
+
+		/* L0-L7 */
+		"", "", "", "", "", "", "", "",
+
+		/* M0-M7 */
+		"PCIE_EP_RST_EN-O",
+		"BMC_FRU_WP-O",
+		"HMC_RESET_L-O",
+		"STBY_POWER_EN-O",
+		"STBY_POWER_PG-I",
+		"PCIE_EP_RST_L-O",
+		"", "",
+
+		/* N0-N7 */
+		"", "", "", "", "", "", "", "",
+
+		/* O0-O7 */
+		"", "", "", "", "", "", "", "",
+
+		/* P0-P7 */
+		"", "", "", "", "", "", "", "",
+
+		/* Q0-Q7 */
+		"", "", "", "", "", "", "", "",
+
+		/* R0-R7 */
+		"", "", "", "", "", "", "", "",
+
+		/* S0-S7 */
+		"", "", "", "", "", "", "", "",
+
+		/* T0-T7 */
+		"", "", "", "", "", "", "", "",
+
+		/* U0-U7 */
+		"", "", "", "", "", "", "", "",
+
+		/* V0-V7 */
+		"", "", "", "",
+		"PCB_TEMP_ALERT-I",
+		"", "", "",
+
+		/* W0-W7 */
+		"", "", "", "", "", "", "",
+		"CPU_RST_L-I",
+
+		/* X0-X7 */
+		"", "",
+		"TPM_MUX_SEL-O",
+		"", "", "", "", "",
+
+		/* Y0-Y7 */
+		"", "", "",
+		"EMMC_RST-O",
+		"", "", "", "",
+
+		/* Z0-Z7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* A0-A7 */
+		"", "", "", "", "", "", "", "",
+
+		/* B0-B7 */
+		"", "", "", "",
+		"AP_EROT_REQ-O",
+		"EROT_AP_GNT-I",
+		"IO_EXPANDER_INT_L-I",
+		"",
+
+		/* C0-C7 */
+		"", "", "", "", "", "", "", "",
+
+		/* D0-D7 */
+		"", "", "", "", "", "", "",
+		"I2C_SSIF_ALERT_L-I",
+
+		/* E0-E3 */
+		"", "", "", "";
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
+	gpio@20 {
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
+			"B0_M1_MCU_RESET_L-O",
+			"B0_M1_MCU_RECOVERY_L-O",
+			"B0_M1_I2C_SOCAMM_UPHY_SEL-O",
+			"B0_M1_SNN_GPU0_MCU_REC_L",
+			"B0_M1_THERM_OVERT_L-I",
+			"B0_M1_THERM_WARN_L-I",
+			"B0_M1_HMC_IST_PRE_RST_L-O",
+			"B0_M1_CPLD_READY-I",
+			"B0_M1_MODULE_PWR_GOOD-I",
+			"B0_M1_MCU_HMC_ALERT_L-I",
+			"B0_M1_USB1_HUB_RST_L-O",
+			"B0_M1_HPM_MCU_OK-I",
+			"B0_M1_CPU_SHDN_OK_L_3V3-I",
+			"B0_M1_SNN_BOARD_LOC_STRAP",
+			"B0_M1_IST_SYS_RST_L-O",
+			"B0_M1_PWR_BRAKE_L_STATUS-I";
+	};
+
+	/* Board 0 management bus 1 GPIO expander 1 */
+	gpio@21 {
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
+			"B0_M1_CPU_FORCED_RECOVERY_L-O",
+			"B0_M1_CPU_BOOT_DEV_SEL0-O",
+			"B0_M1_CPU_BOOT_DEV_SEL1-O",
+			"B0_M1_CPU_BOOT_DEV_SEL2-O",
+			"B0_M1_HMC_BRD_ID0",
+			"B0_M1_CPU_RECOVERY_TYPE0-O",
+			"B0_M1_CPU_RECOVERY_TYPE1-O",
+			"B0_M1_CPU_IST_BOOT_HMC-O",
+			"B0_M1_CPU_PREBOOT_DIAG-O",
+			"B0_M1_HMC_BRD_ID1",
+			"B0_M1_HPM_MCU_I2C_ENABLE-O",
+			"B0_M1_CPU_DIE_SEL0-O",
+			"B0_M1_CPU_DIE_SEL1-O",
+			"B0_M1_CPU_DIE_SEL2-O",
+			"B0_M1_CPU_BOOT_COMPLETE-O",
+			"B0_M1_IOX_JTAG_NVSEL-O";
+	};
+};
+
+/* Board 0 management bus 0 GPIO expanders */
+&i2c2 {
+	status = "okay";
+
+	/* Board 0 management bus 0 GPIO expander 0 */
+	gpio@20 {
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
+			"B0_M0_SHDN_FORCE_L-O",
+			"B0_M0_STBY_PWR_PG-I",
+			"B0_M0_THERM_OVERT_L-I",
+			"B0_M0_THERM_WARN_L-I",
+			"B0_M0_GLOBAL_WP-O",
+			"B0_M0_USB0_HUB_RST_L-O",
+			"B0_M0_IOX_PRE_SYS_RST_N-O",
+			"B0_M0_LEAK_DETECT_ALERT_L-I",
+			"B0_M0_RUN_PWR_EN-O",
+			"B0_M0_MODULE_PWR_GOOD-I",
+			"B0_M0_CPU_CHIPTHROT_L_3V3-I",
+			"B0_M0_SHDN_REQ_L_3V3-O",
+			"B0_M0_CPU_SHDN_OK_L_3V3-I",
+			"B0_M0_CPLD_READY-I",
+			"B0_M0_PWR_BRAKE_L_3V3-O",
+			"B0_M0_PWR_BRAKE_L_STATUS-I";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 1 */
+	gpio@21 {
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
+			"B0_M0_I2C_BUS_MUX_RST_L-O",
+			"B0_M0_HPM_MCU_OK-I",
+			"B0_M0_CPU_SYS_RST_N_3V3-I",
+			"B0_M0_C0_SOCAMM_DAC_I2C_SEL_R-O",
+			"B0_M0_C1_SOCAMM_DAC_I2C_SEL_R-O",
+			"B0_M0_C0_SOCAMM_I2C_SEL-O",
+			"B0_M0_C1_SOCAMM_I2C_SEL-O",
+			"B0_M0_EEPROM_POWER_DISABLE-O",
+			"B0_M0_CPU_L0L1_RST_L_3V3-I",
+			"B0_M0_CPU_L2_RST_L_3V3-I",
+			"B0_M0_BRD_ID_0",
+			"B0_M0_BRD_ID_1",
+			"B0_M0_BMC_LEAK_TEST_L-O",
+			"B0_M0_MCU_BMC_ALERT_L-I",
+			"B0_M0_CPU_BOOT_COMPLETE_3V3-I",
+			"B0_M0_SNN_GPU_MCU_I2C_ENABLE";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 2 */
+	gpio@22 {
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
+			"B0_M0_C0_UPHY0_PRSNT0_L-I",
+			"B0_M0_C0_UPHY0_PRSNT1_L-I",
+			"B0_M0_C0_UPHY0_PRSNT2_L-I",
+			"B0_M0_C0_UPHY0_PRSNT3_L-I",
+			"B0_M0_C0_UPHY1_PRSNT0_L-I",
+			"B0_M0_C0_UPHY1_PRSNT1_L-I",
+			"B0_M0_RSVD_C0_UPHY1_PRSNT2_L",
+			"B0_M0_RSVD_C0_UPHY1_PRSNT3_L",
+			"B0_M0_C0_UPHY2_PRSNT0_L-I",
+			"B0_M0_C0_UPHY2_PRSNT1_L-I",
+			"B0_M0_C0_UPHY2_PRSNT2_L-I",
+			"B0_M0_C0_UPHY2_PRSNT3_L-I",
+			"B0_M0_C0_UPHY3_PRSNT0_L-I",
+			"B0_M0_C0_UPHY3_PRSNT1_L-I",
+			"B0_M0_RSVD_C0_UPHY3_PRSNT2_L",
+			"B0_M0_RSVD_C0_UPHY3_PRSNT3_L";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 3 */
+	gpio@23 {
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
+			"B0_M0_C1_UPHY0_PRSNT0_L-I",
+			"B0_M0_C1_UPHY0_PRSNT1_L-I",
+			"B0_M0_C1_UPHY0_PRSNT2_L-I",
+			"B0_M0_C1_UPHY0_PRSNT3_L-I",
+			"B0_M0_RSVD_C1_UPHY1_PRSNT0_L",
+			"B0_M0_C1_UPHY1_PRSNT1_L-I",
+			"B0_M0_RSVD_C1_UPHY1_PRSNT2_L",
+			"B0_M0_RSVD_C1_UPHY1_PRSNT3_L",
+			"B0_M0_C1_UPHY2_PRSNT0_L-I",
+			"B0_M0_C1_UPHY2_PRSNT1_L-I",
+			"B0_M0_C1_UPHY2_PRSNT2_L-I",
+			"B0_M0_C1_UPHY2_PRSNT3_L-I",
+			"B0_M0_C1_UPHY3_PRSNT0_L-I",
+			"B0_M0_C1_UPHY3_PRSNT1_L-I",
+			"B0_M0_RSVD_C1_UPHY3_PRSNT2_L",
+			"B0_M0_RSVD_C1_UPHY3_PRSNT3_L";
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
+	exp7: gpio@20 {
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
+			"HMC_RST_R_L-O",
+			"HMC_RECOVERY_R-O",
+			"HMC_SPI_MUX_R_SEL-O",
+			"GLOBAL_WP-O",
+			"HMC_READY-I",
+			"HMC_PRSNT_R-I",
+			"BMC_SELF_PWR_CYCLE-O",
+			"EEDO_LED2-O",
+			"PWR_LED_L-O",
+			"PWR_BTN_L-I",
+			"UID_LED_L-O",
+			"UID_BTN_L-I",
+			"FAULT_LED_L-O",
+			"USB2_HUB_RST_L-O",
+			"IOX_GPIO_P16_TP",
+			"WARN_LED_L-O";
+	};
+
+	/* SMM carrier GPIO expander 1 */
+	gpio@21 {
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
+			"BMC_HMC_MUX_SEL-O",
+			"BMC_TPM_MUX_SEL-O",
+			"BMC_USB2_MUX_SEL-O",
+			"HMC_PGOOD_3V3-I",
+			"BF3_AOC_NCSI_PRSNT_L-I",
+			"HDR_SPI_PRSNT_L-I",
+			"SW_NRESET_R_L-O",
+			"MUX_I2C_ESPI_SEL-O",
+			"I2C_BUS_MUX_RESET_L-O",
+			"USB_MUX_EN-O",
+			"PDB_TRAY_RST-O",
+			"USB_PWR_EN-O",
+			"RTC_CLR_L-O",
+			"I2C_RTC_ALERT_L-I",
+			"I2C_PDB_ALERT_L-I",
+			"BMC_MUX_PI3DP_SEL-O";
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
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
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
+	exp21: gpio@24 {
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
+			"PDB_TYPE-I",
+			"PDB_STBY_PWR_EN-O",
+			"PDB_STBY_PWR_OK-I",
+			"PDB_MCU_RECOVERY_L-O",
+			"PDB_MCU_RST_L-O",
+			"PDB_MAIN_PWR_EN-O",
+			"PDB_MAIN_PWR_OK-I",
+			"PDB_GLB_WP-O",
+			"PDB_PWR_BRK_L-I",
+			"PDB_FAN_CTL_PRSNT_L-I",
+			"PDB_P12V_HPM_EN-O",
+			"PDB_MUX_SEL-O",
+			"PDB_P12V_GPU1_EN-O",
+			"PDB_P12V_GPU2_EN-O",
+			"PDB_PSU_PWOK-I",
+			"PDB_PS_ON_L-O";
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
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
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
+	fan-controller@2c {
+		compatible = "maxim,max31790";
+		reg = <0x2c>;
+	};
+};
+
+/* Fan controller 1 */
+&i2c_fan_ctrl1 {
+	fan-controller@2f {
+		compatible = "maxim,max31790";
+		reg = <0x2f>;
+	};
+};
+
+/* Fan board GPIO expanders */
+&i2c_fan_iox {
+	gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"FAN_P12V_FAN12_EN-O",
+			"FAN_P12V_FAN34_EN-O",
+			"FAN_P12V_FAN56_EN-O",
+			"FAN_P12V_FAN12_PG-I",
+			"FAN_P12V_FAN34_PG-I",
+			"FAN_P12V_FAN56_PG-I",
+			"",
+			"",
+			"FAN_FAN1_PRSNT_BUF_L-I",
+			"FAN_FAN2_PRSNT_BUF_L-I",
+			"FAN_FAN3_PRSNT_BUF_L-I",
+			"FAN_FAN4_PRSNT_BUF_L-I",
+			"FAN_FAN5_PRSNT_BUF_L-I",
+			"FAN_FAN6_PRSNT_BUF_L-I",
+			"FAN_FANCTRL_FAIL_L-I",
+			"FAN_FANCTRL2_FAIL_L-I";
+	};
+
+	gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"FAN_FAN1_FAIL_LED-O",
+			"FAN_FAN2_FAIL_LED-O",
+			"FAN_FAN3_FAIL_LED-O",
+			"FAN_FAN4_FAIL_LED-O",
+			"FAN_FAN5_FAIL_LED-O",
+			"FAN_FAN6_FAIL_LED-O",
+			"",
+			"",
+			"FAN_VR_P12V_FAN12_ALERT-I",
+			"FAN_VR_P12V_FAN34_ALERT-I",
+			"FAN_P12V_FAN56_ALERT-I",
+			"",
+			"",
+			"",
+			"",
+			"";
+	};
+};
+
+/* GPU0 GPIO expander */
+&i2c_mcio_c0_south2 {
+	/* GPU 0, Expander @0x20 */
+	gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"GPU0_GLOBAL_WP-O",
+			"GPU0_OOB_RST_N-O",
+			"GPU0_OOB_RECOVERY-O",
+			"GPU0_MCU_RECOVERY_N-O",
+			"GPU0_MCU_RST_N-O",
+			"GPU0_MCU_BYPASS_N-O",
+			"GPU0_SMBUS_FRU_EEPROM_WP-O",
+			"";
+	};
+};
+
+/* E1.S backplane GPIO expander (C2) */
+&i2c_mcio_c0c1_north6 {
+	/* E1S Backplane, Expander @0x20 */
+	gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"E1S_MCU_RESET_L-O",
+			"E1S_MCU_RECOVERY_L-O",
+			"",
+			"",
+			"",
+			"",
+			"E1S_LOWER_PERST-O",
+			"E1S_UPPER_PERST-O";
+	};
+};
+
+/* GPU1 GPIO expander (C2) */
+&i2c_mcio_c1_south0 {
+	/* GPU 1, Expander @0x20 */
+	gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"GPU1_GLOBAL_WP-O",
+			"GPU1_OOB_RST_N-O",
+			"GPU1_OOB_RECOVERY-O",
+			"GPU1_MCU_RECOVERY_N-O",
+			"GPU1_MCU_RST_N-O",
+			"GPU1_MCU_BYPASS_N-O",
+			"GPU1_SMBUS_FRU_EEPROM_WP-O",
+			"";
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


