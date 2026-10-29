Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532EA606A326
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=w5lV29GC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFllH0F81z30T9;
	Fri, 30 Oct 2026 00:42:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281323;
	cv=pass; b=KJoVlKPlLdX6JpuA8o8hUAl6AaKqQxTjJT2UqVXbWDN8sKvNCuNvDMzqJgxQtTlWiJHPdiz3rrcyjgB+9NHwGy2qtgh9Whw6SCwOyAVrS+hjaebJlB8zGtK3tMu80DnR2JPwbHqlVmC7bNjhn+eqQX1K0A25tvXTyXNay0kGt0J34EYTyYlWJc0TkWOTdhUZ0Xzjw3P+7E1zwMqrxJaweJR8fAbyY1HzX1+62mCDPjpyFKm4GVe7IqD9s9ned42717axbrV8rYvOoyLHVh3tn4fukoXotc5M72CkjPzd2Nu5Gtbujq5Dkfe9U0tRjCxIJ0aKtSejXp+pjkPwu8Z3sw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281323; c=relaxed/relaxed;
	bh=4/s6FlFwAKjgFLjZDZcFhJiBB4O4U8XepmrU/CXy4uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TDmYZVfRWv5K7UFhchA1G/Kh3jBEtjxoXdya6oAYiVdcaWbTAsC2PwzI0piOBayqiZob8WIJJxqgBxxvjgpyjdaw8MiAYZYFR2H9TbFSbYkXcZDlnu/iE1zld5EBDIu0mI2nwZYmOZQhrI4Y9JifI1BFzvCKV+QRZ+8fT7SWYLuAZppJkrqdu0Onztk2utx5b1lZBd/GNdYKjmGpRYdpSX6eyDGIZnT2al3zf1We7I8wAzQTPArXjlnguKlWnJ/46YLfs5GzEvEZUjV/n8bZMj5ryS7se4jPgxjxyNJREaQCmZeLlzvc929jWY4/jxoKyQQp3DOK3PqRakzq42jSxw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=w5lV29GC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=w5lV29GC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFllG1Dxvz30Ng
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:42:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcaTfVm9UkJyoJ8V37YHYESOxED/sLgvKUjreGAccz30vVYSfpqo7xdGEmzrfGbvrLvGCzlB4uGL/Uc2zcuznADo0lYMYPZx3KC/WZ1nmmDJn4uhLsuYwHQXHLAIBkP7RcbauzalcyGINyFVR+UnfnOkkX5jDPOnBt87m4An5XesJulzBFnONbpbbgvXSiXjNlkRxBz3eb3yYCMNLjjpz6lrQDe155oN2T1osd1ijI203puVslHi/if9aI/DQVRWBxXpkp6T4HEBZr5UGB6vzu9H5swPq61qUCdG4dmfFLi8tr9jSJP8uaDPZftl8sVBY5Qy+6nhjDfJT+5R/ySqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/s6FlFwAKjgFLjZDZcFhJiBB4O4U8XepmrU/CXy4uk=;
 b=dU1zmf1VbmhO/u5g724IRV7YYLE4QJmDRMFa+VxYluaANOMS6HyZcBfwzj3mZElKPSWKLVuhY6dtjdE/Ky1N6tmk4HiDRK0YpHr7ShGCO8L1jIz5EXGyNLIpHv4qMKXFozZkHFV7K4P9VQ9UBNiYGRcbcr7XYI7LErzU3ZyVWET01HBIkHKOgRGCQiQGDlbI4O29nRb0v6hKvwOg3EmLXLFZyv9L3BgfcJPXNOJW7WRl74b1+tyP9NV2IlU2zjKwj7dugeXfiU2HpGmys6Nb17l9oI4EYdnqbCa0syyPJnFvvPa7qugVJmiTQQtXzacrLOHi7ewgmV/bRTz86bKVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/s6FlFwAKjgFLjZDZcFhJiBB4O4U8XepmrU/CXy4uk=;
 b=w5lV29GCM4YLTVXDBYjmocqYyEyLDXbhx5tgjB0K0AO91URHsGmSWfJv2r9mCNsAwYUpHudvzgH7HrRZjKhUZc3UlQoNUselWkOnxAzsidxdnw//Vk6u3BptkAhG+09NmrT3zbfwamWoWyCG0ekypHk2PZxmqxKe8UOBIRQgDcIBYn7/c+GgY3/KgnHgtvzLxCi65ci+P1DWn7iyUrmUwKGMZAczhuwfnS6YpgEgcMcKsKKoFnwoCcZPlI6x+Feh/m0m5iiBRdsUK6DUSsiJbZwideDknBb2x9yQUwpY4Zn79djFh9uZh6f6ipCIcvLnu11tucTA7cpflUOcSR2Ntg==
Received: from CYZPR05CA0047.namprd05.prod.outlook.com (2603:10b6:930:a3::13)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 13:41:38 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::a2) by CYZPR05CA0047.outlook.office365.com
 (2603:10b6:930:a3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Thu, 29
 Oct 2026 13:41:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:37 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:34 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:35 +0800
Subject: [PATCH v10 06/16] ARM: dts: aspeed: anacapa: Align PDB fan GPIO
 numbering
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
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-6-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=1800;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=BVJMmVa6hiP62Rq3KeFZsYo9O8NS8epFWSmQDw7StNA=;
 b=wnObb9zBMVrulaKJ+MBD5Pv9vi0Bne0CqimMeOiqu7rjYuFVXIPLKRk9w9P+wPA6vQpqpc9Vq
 iODcV3loVaYALbMB2zS6Qqp9tRC96DqBcCHJXacFBTIqCbT42j0kZSg
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5d08fb-0c9e-4d32-c6a7-08df35c25b41
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|48200799018|61400799027|35950700016|7093399015|82310400026|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|10067099003|16102099003|22082099003|18002099003|4128699003;
X-Microsoft-Antispam-Message-Info:
	MtkR/rwqt57k5vdnC7z7aCKGzZHBhRKozm/iv1qJ7vq6IWvDvmnIbZb72+P74dNEMWcDXqTFUAn3yDOlhn4F45w04hiUsFHJZ1Eqv5X5CVr9dzpseZURV0iRHHnhJWSoKC48oN12dbTfIEnO9R1dAXq2r/GuhVa/SMwvMTyMcjAi3eon8ibyu6B1JLgIXhx45WFFBIo1byzOWRv6xrRhAii5sDcO0io7wlitw+PX8ImHmmKP1k2V5EHPBfw6BZAvYgwp4kI28boD9/33g1jlrqckSxzjrwlv1hmb0614U1FIDmHG+jW7Ajb1s+FeZsIFPoqCSNdjqRlCkj3VwXNgUNtmkEzUSbYIDunaGkvhGksk58vmT/+rjkvouiLyUmGJP0G1zcxfh8n2JFsKa0q7sxtuxAsJ69Sjb/Q0khJNO57Rht0RRwno+HrvLfhrZdg0JCGLCV8prNmVxauI2y6J7cSwnKrvUw/LRFLavIWecgryX6ImWoVK2Br3bRevXsOx2nd/Ii0qb/c8g5Sld5UT+wlGTNW+epF1PgQmZCat653dEGGTqB2LK6GPRJ1hP0Df/4gyJlr1JThN3Y4iSLXXhHi3o+Y4XESMEN7ZRi3MwJydBm1hG7bT/Is4xMfmB4fmiZoSG19vqpNhGHts7BcWWaSeY73pfA3rbefCxJGpjpA/1iAySMbj6v7AUhiX0/umJaemw3qm2eHQliH9yHHdpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(48200799018)(61400799027)(35950700016)(7093399015)(82310400026)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(16102099003)(22082099003)(18002099003)(4128699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9x5H+PxJNsTXZGvHgiMRn5TNxDuXwsXOSH5DdRmvvMQilJBMTSBpq29rpQve/tjdGRBbokhxMGT7nbt3v7+4d/jnfMvLuo2HluWza9N9zkcSKmSz8dVxktbNOYqRIZ7MbHJ0FHeY582cszaq49u8FbOmukKe2MDWAOem3Gmj6fm8oCpoPGQoXevvV/f0oEsveiUMaNwYFRSNb4+U4R3+fl/1aJ+YsZ3EYBbLAwC1y/OE3VXa1pherADXLC98TRs9eAlM1vAe+bKz1gtrc/1cskWxDwuUZdbPnj1TRwFMdsY20jR/IUUCn9Tv9xXAmz7HpP3655gDwH31ZTPZ52K44X12YAztd6SEhphf1AQJH0VqIrLRqEm99t0SDzmreScu6GYEZyNlvVxg+FYO4sVzHP9Yy9QXZ1njh5uWX85nixV/EkUH8pu5czhE//q3N4KU
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:37.9714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d08fb-0c9e-4d32-c6a7-08df35c25b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Rex Fu <rex.fu.amd@gmail.com>

Update the LPDB and RPDB fan GPIO line names to align with the platform
fan numbering scheme.

The LPDB fan GPIOs are named FAN0 through FAN4, while the RPDB fan GPIOs
are named FAN5 through FAN8. This keeps the GPIO line names consistent
with the fan inventory and platform-level fan numbering.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index a2392f684b80..3ea5d67865d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,40 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+// MB - PDB
+&i2c8 {
+	i2c-mux@72 {
+		i2c@0 {
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+		};
+
+		i2c@1 {
+			gpio@24 {
+				gpio-line-names =
+					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG","LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG","LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R","LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R","LPDB_FAN4_PRSNT_N_R",
+					"","",
+					"","",
+					"","";
+			};
+		};
+	};
+};
+
 // SCM
 &i2c9 {
 	// SCM FRU

-- 
2.34.1


