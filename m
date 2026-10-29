Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DF606A31F
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=nZist6rj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFllB1NPrz30RN;
	Fri, 30 Oct 2026 00:41:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281318;
	cv=pass; b=ll5nqg56vF2CzlZGXzqc8g25hjBVkKsfoJ13VSCK4iECVnFlmKTzMVwFzu6jzQphghJB75UhNjRm5Kv0mqNquH5QykvaNXQAOd2FwZPeOSkIj4m6Xu2pzVTIfWLWm2egxpOrlS4lptz/qajgC+k+Wo5rs7xuCupIVdaPbbLlX3yCEeR+JnV3tq0rfEEitjX/u+n74dUZrmmFBjwmbQcgXJRQT404hz0mzVfH1ewL/oPGwrXOdfQ7zqKX19b6X70Idzmlo3rk12rGUOLhRhgFMrAZ6c+B9BGnBL3Ysey0ErFaYhw0mXYdufNBBSGGdpO2m5+hu0nRmX4rfjzdILOU6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281318; c=relaxed/relaxed;
	bh=SIQCX5QCC7CQv5gW9cz1dkqgjxNIqgJOCcI0wL8s8VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VhbijyJhQdDoihkn9xK0uuJiin/KCRZA2ccuIeSW5NZyXpvXO/xcwG0lV2byH7LkoHHk5HPHVLPHXUD9HeapCp0MCslsrn5rOvvQPy9F3nNPn92z8B6D1kwu4Gc6I6ag+xzLbQbr1m/oo/wwCg2J6bCfuCL8n6YBvysmJD2wKqo4KFFEHl4gNzPxXGIT/QCG0/LY0+MgKirKSwHVrztmTZv/i4Lw4XH7LpGTb/FdKSr7FKKjVyQx8XP9cqw+XtQyhUm/mBCF96kWCKS3Xyu2XUsLi6MWUPUcwSJVXSCxaTlmgc/cnnoAsit9lEshYxRgHj+lI7CvUE1FIPmFyrGJ/A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=nZist6rj; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::5; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=nZist6rj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c001::5; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFll94DHkz30Ng
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:41:57 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCjHr6W3hnP2TwP/ipXWXKVzDcOu5R+Bg4UMkKe9tAh6JDGSfvxmfLF2tOVqCQT/PlC1CXMW4R0A93FXmXvA5rT1/l87Lgmsi0gI0usjASoKkBwJXq5PlQ5ybi6gR1u1A+P+SHxtZ4G3PIPxpha3pxwhD60cjoH1x1TZzlphF8FxmbM+icc73Ex6mvaK3jGEwru0FxDAAwfdDtK6ZYvTzPaa19otu4llhcETlVmW342koesRLvbtiI1SMw7C9DPONx7ifZx4uTtFtkPV/qAdnclEL12o8FTvo+RAIugwh44JkTHnHcFL6mJTipq5x6nWNYnaZXXjpqNR6BiChitqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIQCX5QCC7CQv5gW9cz1dkqgjxNIqgJOCcI0wL8s8VQ=;
 b=vacBpLGnOmFxvFVJBxuoSlmLlS5kCeaa49MLwaWvVxKh+bXeBC4rZDA808+JgmArWUgb/WurfXAqZwrqJZJqpLqejYGh7GRGKfzeDBc2JbLeuehQo+fTMksDBSMv1pAbtQ3A1tIAadgRj/8vVFfMHOwysYUiq5v6MY9UisSowp45FkexyOvy1U7xRRO/bx0IjzH0HwXPcWiIN8r23FHesOkf0KUMDJ37ApWViEFiM5UWG1C0OqArVEfoVYONfzEci3kFyihlbDon7dY3N0HXZdVxqw5e8IVte9AkOCuzHFlKpsRdGcuT2xgKHQbwOd4HC+uRSF2hY3glC+cc2cKtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIQCX5QCC7CQv5gW9cz1dkqgjxNIqgJOCcI0wL8s8VQ=;
 b=nZist6rjDfi1zhZUDjra/H4+ivEfEBtkmby5wwa+JYVBoi23ZWp/5EGqOnVEm29XwNcwW11V1DwYtLnfsI9It36g5ie1BXSEIZsJuyS8/x88m8+OYfChQBY5XIR7nwoERkX2MWcMDKprcJ+7Rnp41mrngF4aTUaCpARzkMsQ5JD7fTDCHuHMd1LnHtD2Np4B0zo34fjOH1OY5Zx4Lq7iNMbxzPYAzLIZDnq3O6koNg00GhvhoIdSFNv3SZ+7Ne671hYO+grmO67s3rlrtxDFjzZzGMOc55dIU1SDWf10OAj9gTd37SOnz6o8GzR+PgiKuTnMmLbR0EqOX1isivc4Ww==
Received: from CY5P221CA0124.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::7) by
 PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.9; Thu, 29 Oct 2026 13:41:32 +0000
Received: from PH3PEPF0005961B.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::32) by CY5P221CA0124.outlook.office365.com
 (2603:10b6:930:1f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 13:41:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF0005961B.mail.protection.outlook.com (10.167.243.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:30 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:28 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:33 +0800
Subject: [PATCH v10 04/16] ARM: dts: aspeed: anacapa: Add additional EEPROM
 node for SCM
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
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-4-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=1225;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=dS+Ny01+XQ5n7Md3LPea05VV+V4r9WTNjxB4lZM1dm8=;
 b=NHysd3IgLglnk7r+hzF0UXx+oAyAD54tL9V00NTlQeT7ZQxUIgsbaQYCBWIrLIzhZo9fQEGYK
 eILFe0T2PP7AR5ZyWMD8KU+pZKErU+9t6Rt7xx/vZ840EzByb86nbNq
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961B:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: f882316b-96e7-40aa-1633-08df35c25777
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|48200799018|61400799027|35950700016|7093399015|82310400026|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|10067099003|16102099003|22082099003|18002099003|4128699003;
X-Microsoft-Antispam-Message-Info:
	MQXLxsoAIklFDZ+U/C7TKVnuyjYMivQOlwW63Xebp++93wk9CnLaC+fPjQUMJ9hpHWDPs25l1Wpn9iI4HuRiE0ccafccw1xQhv3bKwLZR9SIKE3HCeQ2In+PU0Y42IMaozZe1cOp3OqW8bc4VNmCbE256otCmradLYkr+n4cDpTE2NdpVLxrXpzwEh+EBsA1YExp2F5AAbMT8bmEuix/sALmWRIfUGfJ51LZGI3aci5SU23b9VYriaCgkc6XWtjCyM780H3MdhkCgqIXxp5cMHeJ4RKMJ3e5ftTpbJuaRKss33jALC2HhNjRzFFKDfsiFdKlYwoRPvMxqIt0sHcMpojyzh1Ej9ywb56DWAeJvAP5/dKnYaZNHBY/qYGxqkrn2YiH1kxWSHVs5EJQJa0/+Af7FTQzoq1/76Cv72fYpyxUWtWuc2/TVlb7Qu/nJZ2YZXn7NQ6tJ4o0xynV9mbva5rAAQ/2m6VWuUJP2oELRCCrVsFvUGa24F8gqHhfVx7L/g9J7S4jVQVj3j/a88AbNDp+RDRctVbAAZhSrXlzzkjoOLzET2RGau5KZYHGe76dhFuolmM5B+5LnS9W/MAt3WBAF04TYIF0/GXcniABKFAmtK13D9u4DY86QtHUB5VvJmm5YxCaLpyspLeHyo/zEDwkh7wRmvDXzP/hVJbg+ViLNYIGysC31b4LE/9ShZE378OE+x+i7PZOjwszfY2c7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(48200799018)(61400799027)(35950700016)(7093399015)(82310400026)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(16102099003)(22082099003)(18002099003)(4128699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6vVTN3Kdqbq4XwxVtJhtJXSJ/TFIflBxQj159jfOGIJjzwJVO4+FQqyjFX9lHFcuwSD94bxO1veF2ylRv5+A7os+zvv3xG5eqtII9P1X5HVs4refQqRIIT7KZoHhD28Y07th2cmuHxzqR7Hd7FZ+zxeLt2yPqiCNgzgPgKG+jMCTF1NnOSB7COAj5hWMxTA/3/T8CmwJFRapFjwy6zMpVygG6lBtDWWyuwNqRer71wZbKbwrbH4VlKocvBl9wNvFRXEKxDGD3xCKJLaMqbLdanpcpWAqkaq8rehLUxVNTLUZzIV/cupzq1qQCpe32lgZ+7wwh3g37BoGlPPHhwpIxPXpFR54ju6VuSjaHDbBd1wQRdnM9DjFrBjYCzUMeeVUaCW1H1otx5ymTB0nn5abEly/ztZBncjDlMQQWew65vwUA6GmU5rsUOrU7pm4G6ds
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:31.6104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f882316b-96e7-40aa-1633-08df35c25777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SCM FRU EEPROM I2C address differs between SCM revisions:
- Rev B uses address 0x50
- Rev C/D/E/F and later use address 0x51

Add an additional AT24C128 EEPROM node at 0x51 on i2c9 so the same
device tree can support multiple SCM revisions.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index c43090618c4a..8c4a03a82d44 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,20 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+// SCM
+&i2c9 {
+	// SCM FRU
+	// | DC-SCM Rev        | Slave address of eeprom  |
+	// |-------------------|--------------------------|
+	// | Rev B             | 0x50                     |
+	// | Rev C/D/E/F/above | 0x51                     |
+
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+};
+
 &sgpiom0 {
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1


