Return-Path: <linux-aspeed+bounces-5073-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B8CA5FAB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvl9y5Wy9z30CZ;
	Wed, 30 Sep 2026 16:14:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748854;
	cv=pass; b=DX5BzmsRHi18BToO533afBklnsLYN5gZxcHyvojD05NPESjqJU+cV9zOq44yZ6xn/8MsgFUEwzKZmFbgJFbAXcS9D4ts0GDlctP3MWvDpimNhXpn5lmznHHSiUiVM0LOyKnXmst1ZnvHuiFms49U2uBQLcwwoGUxe1jaH5keBuhylRrhjyxf4V81G3zYUKn9p5kPxyNQAAJFNQfHa03JlQ57MULmkMmN7ZLE1wrxI1nrNhqSCQQ8SGg2EtQvLmzdgR14gKtbHlBi6lN/mtt76iOgD5fFLEvMIf3JXVdn7iGNXzHQ9KEWhxRev2qr4xI2xyqfoe7qCDTMq83Ze/quOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748854; c=relaxed/relaxed;
	bh=SIQCX5QCC7CQv5gW9cz1dkqgjxNIqgJOCcI0wL8s8VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JEsjdLVySqSQHQHaz0zQ4mGt4PaGJbiLU/5Sta3AFvUe7nH4IthXcir/cOUTzHiwGAStD1hFCPL3kuiCzBx7EVy38oGvzA/d0lc8BD/h9TMfaDH7cEyy54BDHgSFXXZKdTjrwdI0aSjv1XAGxFprVtwJRNodjJhwjF8J+ukPTykF8cTSUpz0rQTY500f9xEd3NgvFuWFAL7lEBXy+BrJNKC4NnnnvuGXWG8pH3jhCyYtH/4xjeJKMF/fIZcz5p7U2EMr3k0Kkqq7EtiUPHIywFqC1CmSPOwVIZpStk9a6eyO2YR9LLPO8MJ5sHAcLs7nDb0FvZFxGq9NYqxNTyfXFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=pDlf+oMT; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=pDlf+oMT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvl9y13sTz2yps
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0Fno2odVOa0FD9Q1jcTQyCgFE6mpy2jkLDBn53zczNIiV6pmbOTIu5YsefO0DcSdpS0AZtXm4YhhK06QcnJvEWNu54TrGMDBJVLikYeyuota4I+VyJcTm8F0h1QudfZ39OMqPYcBzIp1YO+6p7UkleXZ46S50oox1iTsk2VFtZZ6H4b0rh2A1BfELa82dqJGuQ8tK+VMQ+8MNXpStaOd23VOP0fHUI95NX6CVfzgt12OUBEKgOTJVid8C6OWUOTpL2u7iglnUoRCFoPXqd35LOWYKUApPATAgBGtBPZLs1k+Ti/g14iVDNd3CHjDDRhQjSmuMG3MI6J0kfCy/1FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIQCX5QCC7CQv5gW9cz1dkqgjxNIqgJOCcI0wL8s8VQ=;
 b=OhqInXpJt2EMxPkjS4o2T60uFrk3yIR2wjcPusMcpCtM0JLAOVGbhLIsHdSrhXbzqmWcuwUqrDOrWuA1iXityank2pitKKCdgUphunHYqG2K9gKqwVru3drS8EqX8+cOQDzmy9h1DrzIVQKDvk9JmbXJm7rkXcrazFWxxSelc7MLQkF1vSwWvsCoq4wxfzQeHe1u7s/xJI4YXNGVQhVo7d1mLjBtt5u7L+H7XrQxKQg2qBWsk/urCYT56XksgS6G2j7w6/l89dHxb4d92nF7k2GAXhtMH1biEhr9q8VRrxLJGB29g+fEWu9TP7XE2EpOCLhpZk41zUL+mAor5A5g9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIQCX5QCC7CQv5gW9cz1dkqgjxNIqgJOCcI0wL8s8VQ=;
 b=pDlf+oMTIvimR1KOvYloekPTRrDu8VPjdxPcY/E19EdiOAVpc/Z0YCreyRlZxifqkl/c6ZZwqi5id2MhuNfakafx/zkAFqh8atIdpWgY+8DoTbjrbyJIUS+3JvsFrFOHd6/PxlpOfWhCY0o1rOd2UrCN0DZI3NvrjJ+ENyK1T2vvIDnXC6n405qG9Noxv0MgduJq/dbBiZgpZKSO+2ap2EeU18Bioa+YUYuhxKc9dhnaMHiyGhMUWFR6KKy8drCK5SIL6/pTlsPod4ckhxd43K1n3SCQChGEYxetPdNvaEQxuz0vyey0BJManjre+komrrS/0X4UgNGtQO9AVsUxog==
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by DS6PR12MB586850.namprd12.prod.outlook.com (2603:10b6:8:410::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:13:50 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::ad) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 06:13:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:13:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:49 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:13:46 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:12 +0800
Subject: [PATCH v9 04/15] ARM: dts: aspeed: anacapa: Add additional EEPROM
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-4-f08aa0d7182d@gmail.com>
References: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
In-Reply-To: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=1225;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=dS+Ny01+XQ5n7Md3LPea05VV+V4r9WTNjxB4lZM1dm8=;
 b=qOxsKhSIukHYC52zHOuGPgTPwpM8tFFr/0O0xOKrCMSN/cmbgEffEWzlg38CIUcWCzkQwE6iM
 3QmzD0bVSG5BK7DC5ELdBm8U+/iMc75zrM5pUWVOwKHCPe19TZx5ngH
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS6PR12MB586850:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f47657-eea7-4290-6b92-08df1eb9feb3
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|7093399015|35950700016|61400799027|48200799018|82310400026|11063799006|4128699003|10067099003|56012099006|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jhrx/b/Edjtof9HG01pVfJY8GDPgmaIfWTFyEDVXZzBvFS3uZD99HUd0157w9gbrkziPyVg8QpOM8T9o8dg0lcffI+xSw13u5EoxT2ZKvubEOn6GJn57nRCOF9qM6NG+hbN+EL3rmvp0icbBx0B6hjZ+w1OggQ6HxSe1kEPIdBYHq2p8A0Q4RIRTd0G68QOwHJdUTFETXa27yuNgfPdCwDmODNd0FwhbzHF4nRyYf+5D+BQ7L9gMF+quy1pnHpNoJlOHAw5O/8dR9PI+OyZNiAcZbWKROUvy1SeGp52lBRpa71mrtb757ltJJyDWfMFiCa9qvl+8JfvSZiuwItBuFz17JiMUmp/XJYMCJdiSwOMjh77MQrJioaiFAZYS+akojXpOuKNVUolThyWQszZAX35wp3G5BdfV35XLtzoBBlnQbrIid2xfWcMPiUr/j7LGJO5NnbYTUVZALKIZdS/6oLR8kC5YL9bv7qwBR5Z7tlNjbDST8A2w4j+7QAGhyZ36zCcUWTAlfYRnQgRoEV5jgXfgKMcTKhZeUXj4gzmYiQHtpfd0szqsNgCU3hs1lqQednmNjQ0gxLh9Nc+tYDJnPBlUj7NlMdfjj1mqQ/DkZq8wkJqGEVOecAgC+wHIiEyAR5HItY6S/KX/NDCKY/4OLOoMeSW185otxpEGHfNJNJeOP98Kwj8DskfDElmdoz85E4pmBDTKCZeQ2nvEQGXKdA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(7093399015)(35950700016)(61400799027)(48200799018)(82310400026)(11063799006)(4128699003)(10067099003)(56012099006)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8s4lW4sm/xq4iw0MsocRraavkriPKu+9vo5zpjcgks7IYIqZDg3BlkVqftZrMjJWb18MND9cOhwvc3+fs0ifqLNkJBCeFDxN6vL7YdFVJhWyBuhEznOl37IRksPQZJ8P7DJP0gexCEdzUvDnCmYvKZvKM09wrt/UprUuNnwoLtL+Q08O3/fA0twzFpn1GPid1gBcygkz/eZxCtISn4/KeWkfWfDYkUntCNSdVj4SBv/9P8yzHW74BAQJNqVbQa9DztAtdweY/pDJgXMn9457MHMbhzB3rJhTWKOsFp4vV9fBNdy4u34uCnQlTiFUUih91zaIAnk9R/6VpWcV4BXCGXgYnn9DkECVpzD1QvPU0/Ken1yGkf7E2pNeG1wfJTNg4YtuFwL2SLrDaI1lb5U/wlk5JgnPaj7cCTTyshmUzLzvDQxClj9uUUF+7j/FAqHg
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:13:50.0419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f47657-eea7-4290-6b92-08df1eb9feb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB586850

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


