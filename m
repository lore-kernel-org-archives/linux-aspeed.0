Return-Path: <linux-aspeed+bounces-4938-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37450C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:22:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0fx5Lbzz2yqT;
	Thu, 03 Sep 2026 10:22:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344568;
	cv=pass; b=mtlWdeCCJTtgoSkW2pfBc9Joo5fPlBPV+FcKcmeNH434/GeLB3/rWp0zvADjLGRWXG6i2rcEGy9tKrpcz18UfqNVQ7DuJ+fUijXYOyCmMTv/r6SL9RHRgPTCn8cgVLqlSBRBGUUldikka2StCg0zeyyvbg1Q3PDF/G+fIEeNEd8L8Y4Fz00U12H02mSfffo8qK1EGHIqMXRbjtfxiHX0wDDyIEsBMbhcyNKzsedNMm+MAXlklatoh2/JprF6wDd4XayirJ1pxXZ3ZgDj3xLEYa3ZPItj6CI+h+BJ9hQ7ZNWt195SxpsLgUz5vOGls18wU4/u4+iAAf1vDlGLjk40mw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344568; c=relaxed/relaxed;
	bh=9kSpXbIl7uyCbma4TQ7vyMsXR0GriMgKcxLGj6DB5k8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HBpqTvslWathwFV9uvvDQhcqYk9Hr7yeUt5nJJVwN6Hf7C0QiK8S5EQN4hBn+Zw6xxOIzJzbj2SUJhrcskz9TOMuy4VMVQuvMKtXMff1DbvMjDYNizVLQeDZ7NVt+PRSBGiJDr6NmWYp0AhVvvNPznf6itREtAuy8P28fEoc3QgebYFOK4cAw81VzxXy3MTOyWMP5mx4FAXh5yygOY7sFUSg03CqkBYChZubFetX2Kmk67OqdCWcRb1zj0/Igi01dxfksPNVL9H+CTKq3jIumTDUyPGxxlesQhZz4Hbuu+vj/u/ic1fSCEF+HF8gA0skAyiuh9DaqZMMhjudfuwQCw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UJ+uZ7sT; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UJ+uZ7sT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1g4H7xz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufPCHuZo2gdX9vGufinOxprVxYGEQXK397unJ6gRMNZXzhQIg+81mREvgUepxdzyeCAGGTBuPUM2SkPlgLrHV8dAn4NYsJhBpUnEe95O6K7p0Y03OPapZPlXeJWsoNsdGbjssv1XtsEIFnSt0wrkM47RN10bJ791ClvCV0uUfOZzFIFZawEFd5LcgvqcCJlnwWFevmBqTSplVdbB7E6pxOT6/R1vdkUlsBizcTGfHuKqRTWkjNG7mtnxS17MH3gTzE0cGDJCidUbsVCjzT65kddD1yS2L49qf0vdJyYznjgnxJp4/bIp0b26pmauZCLEwiA67nA8ZdmM6P9lK1QN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kSpXbIl7uyCbma4TQ7vyMsXR0GriMgKcxLGj6DB5k8=;
 b=AAQMOwYgjctaSVcKH1j5HJx1BhpVWU0w3xtmZub+908WRww1GheN8OweRBaN7BWsMqxT9Nub9a+YtlEWq+ynfo3l/KI/7F2wH3wBey7nHQI0EChN+9OyJJaeSrLPhLu7X1y/IAHv5AaXC/zRuy39tus7Dr3BWSBQeACHkEClMeI4rYrMrXaFSwdjp1jGjUKKlCd9hgkKxsvD5Suel+nxbCGMWx2y3V3PcNfqoWs5qGObL+qea9Hf/H7dp0eOaSWjFcCzRbc+loHwdh9NW+8nfX+SoPWca9/75O9Eoa9RTfTkxNAK/PA+Z1jUb4+H8kjYyggDIWlXr8Z4ko2yHmMUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kSpXbIl7uyCbma4TQ7vyMsXR0GriMgKcxLGj6DB5k8=;
 b=UJ+uZ7sTb8yuwgBRWQHkPzNkV0JOy1l5eiH2Ut2AvM4/7Bq0nnuUwToa1LC+2/4Y73I8Bt/Q34zTIJd42+NMRRQEpanPWwIBKkMkIXH5atU9KaUC+jE0wpGekRbXdinH06t/pTthcmJyECengcS+KyFxvBV6GhTsabr/cZLRlds=
Received: from PH1PEPF000132FA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2b)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:21 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2a01:111:f403:c902::b) by PH1PEPF000132FA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:17 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:14 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:17 +0800
Subject: [PATCH v8 05/11] ARM: dts: aspeed: anacapa: Add eeprom device node
 for NFC adaptor board
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-5-69c8eb2a7cda@gmail.com>
References: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
In-Reply-To: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Carl Lee
	<carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=833;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=pAsMpGEbYbQLqQx0xG8zEgHoAeRohruYjFh5hP58kBE=;
 b=w435mnaB+sV2yqILGHY+BolGkO50lUlUm4YO7KZ/a90KHEiN3HVV1xyI62zZ9GhBqd9nnJBp1
 zcM6DZfr9gcAFsNShZOEFr7WCEePHRHChv7noxgN7X2fR29u/paHBfP
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH1PR12MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: 299fc0bb-ac86-4143-b18b-08df08dc1315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9ITAdn0HRWdHvghDF3LPiWyDdOtjncRCLoVr6gc+T7GHgG7ovFCR1tOAyC47TsnGe8L6Hgz7tS5cLwIwC4988ujN0rB3dXpbbKn/t/GddcwriDWqHCu+Z4FtLm+Noen7tdfnZnfa/leDBpUR2wiwpxDuYbYTX04IShas7lOQyY+6MjvXELpA0MRZn7Ny/axZVVZ/ifHtFCkFkSmwdn25/Gn4LTg/U/jWwK746DYi3fiZJ+Q0s5q+cFIc6EwjWuFwKPfMIJXkv5t74peMljMkzSEMEM90+xxeMjwgJUiCSZTT9mDgS2mEcq7cxrYWT+jDU33gp5JD1LAchqu8ba6U+UcLRvtnmZtjfGDnpq/8kWy4w6uIQGBx9d9gyrkl5EDwF58AyvOWPH+pi49guuOLqgd1lZEkjfggQKwN+W8fm34upZT4XVaX1Ft6BikZG5/lT5+mNIAbJEGGm9da4FKzAhVd7iRHI+YKG7gtiwahB/LToawnE/dAfJhOr9Pe2kUimAuwgXdrdM2uhSdwuMQo80ZpunL3c+AvK8jEotpaP88C3YSyeUET2+YtveITbPPs/zlDDN+naJEh3f4LTYGeuB1j+chaC/pUGcDAhbeUpN4LlWtMir8G1aMrBKc3bHSxL06Be5mZnD7AnmEtsarvkqM9nQ9v518aDZa0glWAErGmWjH/tn3Dh+XjXNFtiJE6FLIWY6hnOIsCiygyWYW9lg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JJMaaCJ6V0ahMEqCu6Z5T52pVPkS7jTpib0OBqqqYT9bDD0vktFNZqlE8xngJ79OLIphGotJkY8riZKHnfcUP/5MQMI3mTzFr0BFRKrDnI3/QtckUQ6EVS950b8EtzSssnXu0uKKk9v86pK6xCBdZ+MKf3oeiUTtfuhrUJapDUHqetw7nosoRuzHk9q1De7g0kpmgZcBDHeq+gXb5RlwK+gWluOq3RoNKoXXZ5lkDsdDpfLh68+jbhBDvRN4C5Zdrqi1KxXJA3eKC9NQfXo4O8LzRvV1kk25RunsQfmX8kEosYiZ1EEkPULGuplKzs1PY9kpnqR4D4ujXtKS3RaD2er2q4PievGinY2ysk3TbQTgN/RrQ0KFjpkKK1PfAK2URu0d3i20NBUIc7QN/lD3uDj1JXkhR2fSUFpFF6aOVZlpEtx7/uVtngXn3t4SYxKD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:21.4878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299fc0bb-ac86-4143-b18b-08df08dc1315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695

From: Carl Lee <carl.lee@amd.com>

Add eeprom device node for NFC adaptor board FRU.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index 8c4a03a82d44..a2392f684b80 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -16,6 +16,19 @@ eeprom@51 {
 	};
 };
 
+// MB
+&i2c13 {
+	i2c-mux@70 {
+		i2c@7 {
+			// NFC adaptor board FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 &sgpiom0 {
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1


