Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32A606A335
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=shglO6M8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFllH2SwMz30Ng;
	Fri, 30 Oct 2026 00:42:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281323;
	cv=pass; b=akcA3XOTBJw4BXtk2gaPLnTGONefbklQnQbULW5Mt8cG3CL4curgkqFBD7BMPVUp+q6r4S1D6B4wbLHMES9oDL77FCcKYe4is5LfxHcZUhk8WcSw5wuXk7YBVTU53v6VMXI3Vz+QwLfUIn+YuKx3xlIaYAIdEBTaWBvRfAGuNpyUqT0rC9Rj56a96WG5nMc3FZv5iO95454KNPnyQS1haX3RDUKYXwxbm3e7UyaYc5+HmTlZev64BEPBLSrNthRpAdPpKoEF/1FuJIrE4QAOEU7i9+k9BUxpOKWePmolmlVITJgZueSVZcBRsTDjnU2NH+O4zTyLW3jGsGRAN0Uc9g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281323; c=relaxed/relaxed;
	bh=9kSpXbIl7uyCbma4TQ7vyMsXR0GriMgKcxLGj6DB5k8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IAK23mTT5dHR/kkg5iBYL90jy6u9dZ/ho2PGrAoBykZJ6nCfCLLRp8Md4N/LR0EnDl1si4ENJefrj1XjaBABNEzCQrB1Pzhc1J41uocrL/Vy1JidDwC6ItSjXnEu91KZRB224fiTMaQrr+JOQ7/WklN2RF4998RAl1zbT1QZD/9jQVJGzYx+WRR+J+6pw2nkZ6ZRM1rsbQ4HIzV8oXpwv2YGRAoHLVAdI8mzjQgJXRDQRfM62xz/1QbYpESlQSzVbE0GyEj6afeiISrr8pZJmbiDnfzPfa9rDNVuwWu8VwfZOslfctmNKT1FzdabTYLFL4TEMbe7Bwk0CGaBayMxrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=shglO6M8; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=shglO6M8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFllG4w0Cz30T8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:42:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOkm54RDzH9PwkXIckRqLvywUrkGjHj2plqtyu8PBSf3VEVx+i0AKYePN3T+Ep57rRU8h/qtaAi2JfFoLKYbHcPfPf0g4GEoU6CWwpdV8TK1+i57aDP/tS2Llenr6j0fWCxLVQ4hC99Fj6hXeoYD4AC7XSwydX1PCt107EDWlkQkvHrYLboALAnkuGMBKHfU9aCcguUoue0YEyb+20KsuEMUvniLAXkDLZgexvGSnLDAGqJBVnd2f50bhkxC7cufvUJQaEtv7D25Ol0ctnmDjWSlcdi52/6ET4zB7RH0ZQJBLkr1CbuMNMbhVeV5LVl8AB9dQceraO2UT5SeM8foHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kSpXbIl7uyCbma4TQ7vyMsXR0GriMgKcxLGj6DB5k8=;
 b=YmCkCD5L/7iRBzdbRx7Jp+j54/t0mjrnpqdKwLo67AHapy5/v8vMKBGB4/0Iy6C5hu0mSveWSq1PLkKJ2UwTaQe5+hO7v2l0mDbOyYevHqB/funjxQYPhOkHcFcC2qxZq/VieRnGsemc6XCe8mJrp/16pp8WlsUt9eMzQkjRz19hmoqK0WSvuwoGjT2kkDy6uPHSZ5X2QS5TU4g3WVdx6SWENH0+Gr2bZcb+zlbh9o6QNS0T79jsSaT2+yxQ72YakWKAXaUZWl/McQjJ3PdL6x44+rBbtd4NWKu+i2vDRSZ6euQ1UgZ+p8xuH+UsGdVGGJISIBESUGzLgnpWGl6BsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kSpXbIl7uyCbma4TQ7vyMsXR0GriMgKcxLGj6DB5k8=;
 b=shglO6M8LcmZm4jhHn9ianrDTcm6oXIkSTGVceqpl+p/bJM2mXG85hb8oBQqazM39RCdTzAq3NyWwvD21M2kdJAAidqBIld2ic7XLw2lMRCM5M5ZVssyIb29DWdqhP+B5bLyB44jC8AeH4IyRQdB+MPRM9hqf77Wt1ksB6BGfOxKZ2FSJHlMr+BNn+A8CMpK2rObtfKuGBLdAvkVhxHU2B2H1DceOGDrc9Pb3FGoxM1fXBx1agzCqExZxsoYK+96iw/OdTszhSComA20mBMM8pVODk65ctjvrCXgWIm1qgOaVyh0jjxzSjurfYdjbocENU9a54wkQhyhFO5T3F2yaw==
Received: from CH0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:76::6)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 13:41:34 +0000
Received: from DS2PEPF00006E26.namprd05.prod.outlook.com
 (2603:10b6:610:76:cafe::a6) by CH0PR04CA0001.outlook.office365.com
 (2603:10b6:610:76::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 13:41:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E26.mail.protection.outlook.com (10.167.23.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:33 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:31 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:34 +0800
Subject: [PATCH v10 05/16] ARM: dts: aspeed: anacapa: Add eeprom device
 node for NFC adaptor board
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
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-5-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Carl Lee
	<carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=833;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=pAsMpGEbYbQLqQx0xG8zEgHoAeRohruYjFh5hP58kBE=;
 b=vmdceVSFuhE4Ir5bz2Si+47F6kDNwtJhhfBX3ndlln57Bw99usIbrEQSNgxbZKs8q9AT9Mlxv
 JzZoIJ8sQlkD52CrG7w2j7DSTMUp71fCrXpOL5ZnEDxjfbBZalf3cCU
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E26:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4887cef8-023a-4485-9451-08df35c2593b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|48200799018|61400799027|35950700016|7416014|7093399015|11063799006|56012099006|261009223027099003|10067099003|261021121427099003|16102099003|18002099003|22082099003|4128699003;
X-Microsoft-Antispam-Message-Info:
	0gTbvFaafa/vDQVsDGYIc60XxYD3aTDAwIbzn9KN1CIpbVlzspQaIbmoghIWK567I/usMaqnyjWDM0HVsmQe3HxQKAdP2llCrH6zoTUp30NAZ0h5Xzu52L8BHGQ52egNEb2ju/mSBRSzUUbzPs/W+ksDtLJXwtYLJ4regvPNV7wbW58FTf4cEqVu6+1wWWpuYCfsBtn2jS2mwhg4O18rQyQ7vfuRzDnJ5eVuRBSt9T1KJKDQ6eF06pvMeByDVkfTQevve+jwx1J/FJC6cuvTd2F8YZrIiGwR7GL5gOZxew1h7qNPZaDQnghI4PRZplV3q6h4hRIiIQgqJHn9ficLMCFXGjIbai4Ss5WdzSL/ElTf36GJYFqN/G/qJrJbqsclpp5d9kM16FevQRkVQwOyJ5wXIwV3a67wUIFmc9eipQUaio2YOA8FkXZGB40srUfCCz1i94wAiLrfZWJo9Szj5TM38n6e5+tZWd/D9nPty6tJi+zeoWL26jbGuw4U9P6jVn9utxI1LPn8+3Omu6oVjUMUvEGAcbRfuRFKby7UQBHkhedAqSvD6Pd5mhf2pswZirmd7p9+9Ns0NQe1hM2wedaSj/N0kqxX8W8lJohI20tbAKflEg2Q+OzxctZU4uORbGyb/qOAJxoaQh8VrixNqPBBpnkEou483HE/VJFDZa/MLDpJurfCVLORUbIlqtKvrTRIWjWHGCtHqp6Nj+nxmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(48200799018)(61400799027)(35950700016)(7416014)(7093399015)(11063799006)(56012099006)(261009223027099003)(10067099003)(261021121427099003)(16102099003)(18002099003)(22082099003)(4128699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7WzxhhP7WKbBB0XKRIxeNRpTp4mXoJkW4PkJADnpg1IRfc7BXNj97QkwweWtmH2YnpjgsWK0s6Eau70KfEBxeNpvLHcmJRh2kwDpSP4/5/aLJVaLJtXWxIwncX2ksZs2Qh75MHycJ+ubydQU1QzoC1i2LkfqGaWKqIMODxs2hcb5i+SOo5jaBqi3Wm6ehLWs0mf5gz4MdGwoTxKrhQw0KwZYma7bW6M1A/C8mard4waD82jE8+pWAlHLv1OmgUOPKaeZ+delkWDimVrn/edX59W695ciPyRNGmkMzFLOMOdcmXu5rMUZUVYaMrabNbgPJau3ZauN0/uSdECoiWDE9R4Q3m7H1kNj8eUKXcU10SmIudfewIBs3/y+uKFzq+1D4b4ng9RFbbQjwo+wzMrrzdPW/bWkUcesg/PGw8n0xBDPp8LlR4CrOIcCtNF/oTiC
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:34.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887cef8-023a-4485-9451-08df35c2593b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E26.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


