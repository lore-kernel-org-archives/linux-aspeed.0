Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B591606A327
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rOIk1gEA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMb05Lj7z2yD8;
	Wed, 11 Nov 2026 10:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794303813;
	cv=pass; b=oGqetOGum48+3uj8w7rEKXwqcg3tGT8Y0dXH5V7zVOqhr0NjkQyI+o67bA+B8M7G5a+KVK28HdHvLwh4+dPV2DYOsqx3jtYnkA2bwSyAOGG7+voN9L85OfdBrT6f5/azHUwyFuG8ES9+x5kK95mum5aJzeTCGnjZ4SnsfRtpAC6R9WiILfWyAv/1CxLgGY3TMXS57EzDWBTgExg0pXYgqyP2+ax1saiX2n9KS/DMldFCOg/tZ1ygHRRrZvS1Qh9F7ewI14QUDaqjwfDCarFgVEaSWkA6KPh2/A6zudQUa/SdV/SbdxdPefVhJ3LQDTcAjeeKjeOvQeRq1SATFVdnxA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794303813; c=relaxed/relaxed;
	bh=/STSAsKApnUqwh9qjDB+bZluSJUxcFNCda7tshnzAkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IInFPEd0N27BNXMjglLyFZKPUFZD1QF4+8hTzVLpPfwMkHyevJcphxHlT14oIRjNfGrlcEXj8mWB3rvfI0Wi/8JDmjwqfgJ1RqxkPc5kfZx0o53M2hBmWnFdHee98WNPV2FL08bY2nbUhJLDItfUZLni6pbCUEovE22UYN6jdxqPpda+zrKrG9hhosREWFG2QiSc/PesbAGFFV4GNOiL3iEmMG0VCygVu2qyP62E8cmXEkf2PEx6VvZ90zwU4SFt9Gk2cK70RLZ1guK/q4UywaFtLREKjJX5SYQIqcmc793GB6IeKjzWjmc0lPcdGDfAAm9J1qE6cki9Nhj+Vze11w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rOIk1gEA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=carl.lee@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rOIk1gEA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=carl.lee@amd.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP1tW4tWkz3dXP
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 20:43:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9IPi1MP4iuetC+LfB9msZBeMfklMmGE5Sxpog0UogC3tlZHTShjb2Jl1e9jLMr3dG6pHTCK/hElRGdPcQ0JAWh8NlQXbvvz3U3P+ZXrDlXOn2mhITG+/TpHSOm91eBvNYlpCtvXjc528G9MLQzEbCtLMK00kebeEmPjVg1/xDZHfKTBtRZPC9EBj2YwOK0d3r8r7LHeYJXNnLZx4Hxio+WPvUJRfbcNxz89EMPJPGEOQoBC5yyM1pRz98WSMhbZsfwo4G9WKfRow4pocDEXh/2yjw9Ky5tEOGi2NHb9MYzIocKC0THGqQ/NbYwOECKtcc0RKw0sV+J0BxsTpFUcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/STSAsKApnUqwh9qjDB+bZluSJUxcFNCda7tshnzAkY=;
 b=jF/csgJJfZMY/zN2a7USsJJhA1Uj7yzmhuL8UuuaSei514oOY5isvxB7BiAkpROJvsjaFUO6icPFLa2EEZcNsBVVhp9qQwVl07zvJmAsxKYkLjFuCesF2dYMrUmhafN3IiM3R05FO7+3V3QQtxQPqqeQjiQ+4pVQc5TuRV/Tc/Dbv8Om64/EOhON8yF1dnBgTXIy4JjH/Lzu5MXxc9CDR6A7VPLSdaoPo+K4782fXThsYgOQaO9BcwIM8mPoOZwNBJFN54vr578Fq5FXG5cEq7oIIpIXzxFSkE+Pdo4ZkfMY9eF9NxFTAI8LU8u0xZnX2JIFWiscjQfj8DGNuWgegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/STSAsKApnUqwh9qjDB+bZluSJUxcFNCda7tshnzAkY=;
 b=rOIk1gEAYQ69mRqZ5DpS0xnCF0UgQKCR6Xoi58a9EiKLtPFxaQG79FbvAzPyYxFzSOIikZV+oopjEdVgf5aiZmVIgPGw//Jv4z5AEto/tgVehvk8tt4HuzBoGjOqyOr08Wli1rJzeNTwGpN5g80/Jhp9tSZMIJ9tm2q5DWWL+OY=
Received: from CH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:32::31)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:43:04 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::a4) by CH0PR07CA0026.outlook.office365.com
 (2603:10b6:610:32::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 09:43:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BE.mail.protection.outlook.com (10.167.252.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 09:43:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 03:43:02 -0600
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 03:42:59 -0600
From: Carl Lee <carl.lee@amd.com>
Date: Tue, 10 Nov 2026 17:44:50 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: remove unused EEPROM
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-v1-1-e3b5d9cc1a03@amd.com>
X-B4-Tracking: v=1; b=H4sIAJHn8moC/x2NOw6DMBAFr4K2zkoYAUWuEqXY2A9w4Y92A0JC3
 D1Wypli5iKDRhg9u4sUR7RYcgP36MhvkldwDI1p6IfZOdezaOLwNRarQGDJ4qUKK1I5wHverVm
 gakk8usnLGMI0Lx9qxapY4vm/vd73/QPfzzLQfQAAAA==
X-Change-ID: 20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-415ca4dd56fb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<carl.lee@amd.com>, <colin.huang2@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794303904; l=1070;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=KuqCqTn6qEaQVN++wIzRcgfygQpkPnvrXYdt7F+hVQU=;
 b=zSQtksEijXNXCK3cDWPPHjQ1xaeYS2ziuEy1FOokwfZDvuqgb5I0Jo8EPuX3/N39BGiZPMHRO
 Kt2rIOGX6OXDEruQCRZaNwjB16tDRRGXXRG1s+lOLDCVfcWJMVIG67G
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f77399-ecd7-4640-62c8-08df3f0f0424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zLXBmk+k6vxUKNV3/3zeDTGQHolGpP503+dJDtadoiXXlP/MGxsibEgl4M1YIfKM+wd+NnA/pah+FmRXYctILOgSJ/5RhmERePjAECxLo8KbetHceFyuAKSK7VFSlBaa4OAZ6fjtfcoHy7+z2XQRpp53eSXFPPunFYKMSTPyKuhbqFYAU7wfNwmCiJUotXKv9RJOLTnOcPthoem6EcqAALB3++o8w2ubT8izoYjZ4tgTgYA4llfLt+et5MoP6BahzjOBXO/MSSPw8U2kngEomuB1JAN4XGBuY1lJYSzySBZlqz+I3l2RDqbHc6w+3DfBF3/VzOQlGvQkzgdFR7WXW+Drw3mgmsoisYJljoBQHbpQm0k5J68ISCXvnP3VOsFbpmcJiOCC0WOi4aL+/w2VbkWfAeV5GSjT4G418lYQOqNZ4/MemFmjjZHF0lZDttiql5QXrYr9IypAGQOGeVdlrdz7VWxyxmc7S/l3mK/yfL0e7FR8a6+Ye14wKeNsu3sXzPP2ZlEB2PPttOM9cAMid5S3KrWUzHUaYWtYhpDEl3x44EBrbfqpHjhJXxMISDzFKsgFnJ7zhnWC6jkSPXE1YiN38F7NG47dggnNgUjMxlZo3gzT/6SDc1HskS7wjdwcuJxDFE8sg0xs/vM2tFF8fIN2z026W0y+IyMUfcR3hWslA8kpvA23u7CB2M50saZHTN0Ou3Iks2UhBeCTQVh//g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uacHEv1jiD7VC6gIUIfnabnKMFt8N3mBgHheVXzpbSnRpGRH9MwSjstvUXdqT95BmkHX1VHJnm7ydTN13knInIGtlKJmbaszFkaR1jLJP3EsYoiKBadCP+65sf1fUSxpE/4ckpAt8qFOuRmGc7x8wBL5l1armdIibTaNf9PWP/3x4WorHXJlX1bRzvlfzjiFUDL8JMaQlEAlRGETEuNrE9VklPYPdOvSU2yYdimavpXf6BUP7RQjcWI0nBr/3YJ4fxC2VxwV9c55mHB9pObRCtAHokRPUuCkZKid0WLjX+Mjw/DXMa3bk48N0dBmbLC+B4JI0WTklBKzkEEXgH4dMuz4CEzHw45noLC4Ey19ENdJzk+BKKQ2rQlrhLmTBB+zyOKJfk+ZZDdOK0bORdUKmLxS3btpuW+ZhrNtdpJ5uB6L5iLBRQaaF2pgin0yvUXo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:43:03.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f77399-ecd7-4640-62c8-08df3f0f0424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the unused HPM board ID FRU EEPROM (0x51) from
the I2C mux channel 4 device tree node.

The EEPROM is no longer needed in the Anacapa device tree.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 1fddf3a5d138..1b05b006b3ac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -805,12 +805,6 @@ i2c13mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-
-			// HPM BRD ID FRU
-			eeprom@51 {
-				compatible = "atmel,24c256";
-				reg = <0x51>;
-			};
 		};
 		i2c13mux0ch5: i2c@5 {
 			reg = <5>;

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-415ca4dd56fb

Best regards,
-- 
Carl Lee <carl.lee@amd.com>


