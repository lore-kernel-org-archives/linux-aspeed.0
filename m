Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE47606A32C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yPF+AAU7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTsZh2Mcbz2xlY;
	Wed, 18 Nov 2026 17:46:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794984396;
	cv=pass; b=Vwq0Ql9ioESZUX+2PV17/g+J4L3N4IRqsbydPJ7O4Vo/U2FVgF2Lzy5nGe6hDJ5OyRfI0pEsQSrcsTTtMa0J7gfNeMm19tdF7rESZe4pePct8CPD4PLwSruPAC7FVQyhWlyn58IBQLt+kKDCkhb0zEtYeOem9h2Tt4F0kRsSWhY9r2Er2xe29W8UDmLWAP4wf43n0Azz/J4CykbQzWWRGQu3bf0vzSAe+3hEICQemOQtLpAf/c3sPiMYf7uBr3UxjUg5OBF+VHR3q/h2FI1jp9WYW4a0wvs2ZxLtrmmtmtJt9LxRrGzlbvGpFeBo3fUFI+691UEzZNgmQ6FA0JIHRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794984396; c=relaxed/relaxed;
	bh=muuCZ7DSXV/IjjPENJPY4XyOou4pzmPVRIX4kU7BALE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cTWp4exnNXJaBPZ+EejqeLUcMGKZH5TSj66apkSUWQLmrtvqBD7CN/Q63FkjomRGFuzxwZAxpsWF7g3J+CCH0qQzA1UfMfSJOs83qxNr3c3Vdig2S05j9qzLMILBZXbwoFP2gdmcFENGEXbXHQHyF10DsLo4ZiRyn4Pcp8tCsuDGlEK2yJnacoFvWkA9OaXqbaR9DfLHkzdjXAEBgpYADQqdLXUHLiBZca33z9vNAFsSV0JqvKWr6UOwdTOuCnh3WJG6X0daRng32ISZMazQYPVInbabEHs4gtpgkZ160u2NE09wGCg6Ddta+2XCsPSNQRi+NaZ405HMC6oZcR2tLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yPF+AAU7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=carl.lee@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yPF+AAU7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=carl.lee@amd.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTsZf3V1Kz2xMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 17:46:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYTzNEWWGBaUaTihbuNiqmRer2huNMIn90+hTBgy/pYum9yfV7qnQLbSiADwG2R1w20jNp+TXfkr4CQpNnUFXSW3GdGlcStBw3OJk5RPlJCIUhySZRPTcyCMVRbH/0ZLa6G89skzy/C6KvE2o37FG6R9rFg1WAbI5igCTCpwIcbqumQjyHBSBa1afE5l6g/TkEW3Jg04SZiTqexHrsUmuYgPcrbtj2ngUzKO12+rOeG9zm15Ct8cW4Lj2CqDplfQBnUuAx7rm2dvK6SAIi83c4AJjc2MtPcCE51bUSn9a6VEncfqbyNSAlVnH55LtsLWbL/W1eOxwY2sDvgOBtCAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muuCZ7DSXV/IjjPENJPY4XyOou4pzmPVRIX4kU7BALE=;
 b=ty1Y6aOePGLooxdyazn5QEZIk/V7IFomKMfa75vvRDWuEB/Fvah4vZ4RFKqj/VcWT+03nNMMRRxkwdPT9bbdN6+Cq2J3IA17BUd0Xo++ZLumvqMqd/Q1PZIOXRNL6RkIccT1xdrTjMkQs10QgN/wVdA4wlDIYo8EHvfr1/7S11QmYl8XEstrd4GVQkFWHLAzUryCD9uUYVEGy8NHTiMjaVCWnaeXq9EYH5UuvFg9nbZ+s5UesCMqjkzaGZftZkJCIKZkdku4SSCYzUcnR0nm6eYcR+z6UDt3eU6/bFUsEr3TdSJPYDMJ62H7j3DXsASclhtUfgYLBQEJptq7CMAlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muuCZ7DSXV/IjjPENJPY4XyOou4pzmPVRIX4kU7BALE=;
 b=yPF+AAU7fq0HSo0iV0RNQ0RIfkPiMaiU9hOSmhnJpEcaJtajKpg/zjrLkS3+kFFLoH+z5PYNcW8xAj0ESYB9raf1QW3UE5r3pXyhggnKgpovPb497jmyPthVKnt19RIk3rOLEDe5Mt0glYOAoFqa0Rceaohe6W24Cd0b+62/QaI=
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 06:46:14 +0000
Received: from MW1PEPF00018892.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::6c) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 06:46:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF00018892.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 06:46:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 00:46:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 00:46:12 -0600
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 00:46:09 -0600
From: Carl Lee <carl.lee@amd.com>
Date: Wed, 18 Nov 2026 14:47:53 +0800
Subject: [PATCH v2] ARM: dts: aspeed: anacapa: remove unused EEPROM
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
Message-ID: <20261118-arm-dts-aspeed-anacapa-remove-unused-eeprom-v2-1-ba49ad6e1e25@amd.com>
X-B4-Tracking: v=1; b=H4sIABhK/WoC/52NOQ6DMBAAv4JcZyOWS0qq/COiWOwluPAhL1iJE
 H+PwxNSzhQzuxJOlkXdq10lzlZs8AWaS6X0Qv7FYE1h1dTNgIg1UHJgVgGSyGyAPGmKBIldyAy
 b36RY5piCgw57TZ0x/TBPqhRj4tm+z9tzLLxYWUP6nPOMP/vfJyMgcDv15qY1Ut0+yJmrDk6Nx
 3F8AbIlTxfkAAAA
X-Change-ID: 20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-415ca4dd56fb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<carl.lee@amd.com>, <colin.huang2@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794984479; l=1307;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=dYSV9mKdQnC6h/+aQ6o0Kf71PKiug6RanpwYKVEWGIQ=;
 b=RS602ad96fGFzFypb50GXWM8tkXgbye/a1OOeUrDUaHFtvgLKD7tz6/uulMz14PKfKI23La5e
 dgU6fSXnHwYC1h2xSw3CMbld6NxHauvUPcRQtnliqbupZ8tzY8FfOCt
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018892:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 128020f8-c36d-414c-0ed1-08df453fa38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|18002099003|261009223027099003|13003099007|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|11063799006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	Y5cgdrAbBuj/D9XX97gWgz1SwnD4C8fTNGm8tzwV+6YTDykDJNI6hJnbQkXIvehUkfg8eYgwDHkida/fhZyyfxbYXNpuoPKsCO9H6q+RE52OF+QdIZLQ+vKUKsVdmGdraDMj1d6x81fAz71kseTDRiYpxIfgkE8mN7/zQInVC8Y+UMhi4kGx3hboRPzsb05T8QHlInf1dSo4Y64gBKGJFq7gHpSbNkicxWlZQrRg14RImYPh2D66mF6krn2xUPHU/1y7frjIxnSJVAA27x88y4eOkGvq1+tX5wXcf4ywQMVgfW7mik2Fo5eSU8FT155g7jMydIx03r8xTPgif8wXDKE+pYMZTgH73s9HjqwhtRCv0I+lFGIeFL+feopMLMDv4UAneTZMt871yxy1IbZN06K1cqFuNVl20YrsU2lZWrNDPqfs+bkUrhFQSSR35LxzXGE0+HLCNW5ZS+6Z/a0nhenmIx+9Gvu5Ec+J6Zr7Yed4zoBCoX9OcTBmALKMlsMk+9uWWhH2A7zd6PrW6eG5ZEHf7hXz/KcPCCaGhhiI2bVE86JXHMGcDGAwHJkn+CSf3KOsU0sCNbs7ruS9Zq4PZlhZLahPXee83yn2LiVdMuv0gHuC/xYIEGFW/raWJcBGnx3nRIBUKQmSUOK0kQeotTfnUOaPEBR7+FQ7ZSLHj74=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(18002099003)(261009223027099003)(13003099007)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(11063799006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wZnYyHrc7zRp55Yw+AYX0x9PcfW37cIkkRTOZVl78ZH+OF+UovC1bnS0BSacXM/ho12M8HwP3B9BpwxXMiddrid1abLowOy3S60F7iroziEs9ki5gIE+w9KdNxTfqhcKuYNRlYbqLsHqhDkO6+Lm4Cca+nxb3v5H1e7wT/VzBAcf2yySyhz3+v7JYpJ+JdOUNusBjs7yrtF5n/UpV9rOrVvgmc1VT9SiYJ6NPA3rflA+Vx/W0BblKXdb94DMKtr8vofF6osD1GF021tY7uSECOqavubuFKvm0oFxWcQXKZuD2nS5KFGlLdP1rbo94cGzxLguruB9Up2o7JHN4nztqE1N0YwVeRmf3I+j9HV/oIKMPzurwHFJH+o33dLJhjOCCSEkd3y5WAtTEwWikVUHbuuWicVGbGaCNi3LDPOUEOKgf7k6Lfwy8p2KV606pO+D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:46:13.7805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128020f8-c36d-414c-0ed1-08df453fa38e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018892.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HPM board ID FRU EEPROM is shared between the BMC and host, but
is not used by the BMC. Remove it from the BMC device tree to avoid
unnecessary BMC access to the EEPROM.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
Changes in v2:
- Update commit message to explain why the EEPROM is not needed by the BMC.
- Link to v1: https://lore.kernel.org/r/20261110-arm-dts-aspeed-anacapa-remove-unused-eeprom-v1-1-e3b5d9cc1a03@amd.com
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


