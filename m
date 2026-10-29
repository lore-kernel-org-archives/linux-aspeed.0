Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359B606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=qkd2g3Lz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzWH3dCyz30C6;
	Fri, 30 Oct 2026 09:32:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281361;
	cv=pass; b=EbzagsD5l394x7KeX2YQpI42yvEbzh3A43JRDU0Z5IBQZ+WfCxDkDEA1QUupYacjub7899obefJtBxyrQBMiJX6nJcx6/7DciUTgZix+LQxr+Yc+mYZbMk2O0LrH5T0umcyyCHNNrSSHqghCaCQfhRKpO6yU72B56Yhi0CamAwL1gk4o+99RuYmjyATrZpt+iMo/5jnpkJy0hp5qdA7QCIkPWSzVkLNNXHnwxYSU6USIjoljNQDpuOAKBF0cjZDm7t7SYM2Q2/mIeDb9dRgshPJoYbEcv9EkCzHalDmwyB44mJNay3/y4RhkBcag+TVLcVGjHm20+jfRCyOqAGnkyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281361; c=relaxed/relaxed;
	bh=vJMVgc/OwoPyvEhvWxQJdZUhfSVpAZZCg5XYPAj/kdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YTt/goXT0FrhaTsgsVHDZxKyNIGPMlt7oiLKBjJOpB0Y2jfU1FA9sf/Xji5uy01woXmtYDF5BCKWQt5thu2dgRcJnGyRnWBPdFR0/7eqMEh4Hnm6l8E9Fbcw3Q9yrG2BS2dvwc3B3JNsOBTfGWrfM6U/yoD6cfhd+xbWl8tl2KjPl06s93EjkTn9INTd3cLUZVqfXaCspKU/QOPU2CQuWwvzGaDIQ98pRM9+8kjesKpzWsHjowKVIfi6fkskuf1wzWLm/2L63cMHLvQLi8qB97ThtiCSKuOyKoK76JNE0iCji5b4EKFSnC5+gLGSp+uf3Ofw+t3OUlE3VvVkM5936Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=qkd2g3Lz; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=qkd2g3Lz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFlm06jWVz30Ng
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:42:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nab+PQgmxgH4CzwMPxebWaWDu7Af5pVa7bpEyS2mbHFjyCkxLDz4OJGgaYHxcGljYFFP6XrwZYtovz0WRMMs1ziFmplv4QHWZwzBpr+Yaxzi+VFlM2mgZ1ScYnn3OmsBjtl6PKqxLkSnpd4Jq967fEGAEEwKBAe5lmf0OYVbsoZs4N96LmdEA7rbFgLfqRzEu2PDkHIUJzJfM/uU1D/wJLsdR53+YzFZIXMhKWT76+vydzcn6m8sufSKgFqsL+sKqAQbQclD7nvDTlAxIq2m0jcg/b7nGFuUZhyOWcMz8NHbTs0uKnfUjePNa38pYCFg+QQZTCE61bf6iE+M2gyFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJMVgc/OwoPyvEhvWxQJdZUhfSVpAZZCg5XYPAj/kdc=;
 b=DwKqyl5ZBQwy2jY7Ue/01r8gotY7qw/dQ0lBXZgF/5HE3Be6XowVi8S/g0cpRrWopNc7z0iHp7DPwIRSI2Ey8EZ4BhMpjgTSnTbZfp7LYJ1BkdpIDEIrWeldSiQJXaebYY+v60EYamJhe/SSJh/JwbI0qHUZucKUUYeOu/xQJZiAlYvpvLWWNqczQigS6J34fi5GV7QGyubJMx45QbGYZAE49g6Ga49cQzuo/BiBfCV+AJR46DrEXBGtyY4PhI9gyEcXEbpcJZzn/HVsuTduwsmA+CPlniRFQNhTxSB4gI8V4YkJs2MvRGZ46RmXz4tLEcgKZGig7wF55lg8mEY/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJMVgc/OwoPyvEhvWxQJdZUhfSVpAZZCg5XYPAj/kdc=;
 b=qkd2g3Lzd98x3qUZ9XLYq1Z0MArS3XkJP3ojQmHQ6EP3TQglBm7kFDV044jE4Es05RHGgvHXOqdbiYZLDi+U/PYu0QrHVsDzvdsAxWWwlF8pqQ89WQUdbMvocVreMGPIwq7uio+r73iVXw5jBfoZpynw6S8KcgG7aRKwULBLC4ZvybH/thu28aQ0Pfp7d710cVd0IQ7njOqsYl7NYPg3JzhQ3KERuv8na78Gqzc9SlpdutyOBxPAzBDLV+1z9618ugFfJUO1KN/g7UDlX9MCp5euxi/CdW/JrBItiGT6J+iMd0498MOurHdR2cfb2GrFdDkSEfaKDLc6Y9wchEv6eg==
Received: from PH7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:510:33d::14)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 29 Oct
 2026 13:42:16 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::93) by PH7PR02CA0025.outlook.office365.com
 (2603:10b6:510:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 13:42:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:42:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:59 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:56 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:42 +0800
Subject: [PATCH v10 13/16] ARM: dts: aspeed: anacapa: Remove LTC4287 power
 monitors
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
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-13-26ee3cf9d9d0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=1863;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=ippwuj8pzOKFkEhOs9Y9bdu/+M5Y45aCO3iLCFK9I78=;
 b=fbs64+HhQfgEEr1vLFGadXI/fmTUVSis3txJY4RbSpoqk2YX1ZYinIcyzLf4PfNWQjaymUnkT
 t8hFZUh+h+rCeD/Zjyqv6ufFae99AKTXYihDzm3r07xUumuIT9kSS2k
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 686b19f6-964c-4d67-38c1-08df35c271bd
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|48200799018|7416014|7093399015|61400799027|35950700016|4128699003|18002099003|16102099003|22082099003|10067099003|261021123027099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	BXYKHM/TzO+NlHLlmy71ISrcAHvEX6a68f/VnduRkHE9YP92TpMisF4gdG9/U/LV/VKUddcRnzL1SgC17c2L2GdinFazD2N6oKHmQ7HWMwbAi1+m95Nxyp9YtMficM22hmQtQh9YX/dJc3Bh8tFE4rrqQlPiyCi/KVJZkaT8cXMgWed54w6TJzFNzz593KSQu0Dz1WJijdEXdveSQTG8g+bo33n56AQXXFoFRiMTSf8my1Q8DJDQvBnBrUgj9BifrpdjGyR5xAf46uvYJrh3/9G7CeHux5+vR4nBCRQBoUarx8d8QnmIGDTC52Ez2IMznGpkD7ILkPxG8R7srwZ9hgm0xwzlBvFyEv+Burp9NR2l2DPgN0f/hGo7kTAyCsSMZA2A738XOdV8eNjVProp8djoxYZDrPRFdAIUkRld6hTCFkpudJ8p3ADdVPJSrYORP7ol5Ate7dqiSrjsN4/D8mgHC2hSs80cX2eCmb7Qk4D4aQ8Jro1C0no3iK5ik9ACNXN6qg+i0YRC6H87c9G09Kw1Ta5wgN6LTK8s0GZ580EDIdxwajCeeLUffRt4XS7nwlw7OQeIoUh1JgHpWkIYblaLtpyjMJzufwyHFcythuR2q9iXEOlZh9v35YD4lpC6xL08URA+CIgX7MjmT4LKIxLnA8MVkuC6TuqqWZZDr9BLTGzigXCGLeQvneIV82hofIA+erWaVCglZL1KNkcGfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(48200799018)(7416014)(7093399015)(61400799027)(35950700016)(4128699003)(18002099003)(16102099003)(22082099003)(10067099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kdoNtAd0xDE8Dsqwg5r1RR6u2ypRaKIC9eN5sCSzrJVSlN0ousjPnVcUZ8LnCI7XiBkfwrwdZ0CbtHjuNvBDegQWd13uzafMeRVnLOjwRbFcFDL0pcOFVokD5rslA9C8EZcJAWTtO0E6+rKPjb6HVBO4HWNr0m4cWQdEht+umnF55arbTpfGQH79Og4O/IdZrKhIsJYzcTcqANAKWjLamRUMmVm4gsjk9Fs0MOai2Ow3/EsUsE+mAgHZh3SQg1jttidqAfn2x14OTFm6u1Dnqy50NTIQ+r+3GdGPmhRo3bUSmGaVSx4zr+pzu7lQICbUGxW3XMDF1JdB29qM3Z8qz+uOVlYAAxNIk5rJ6Z5MCez7uwdfgEM1SAqm0Z0bLAzHIrLbGvb0oDQFFLXZMzlp6V6S98zRD1R/UJeOCcyszII2oH4MeHqDmT5cl1+Md070
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:42:15.6912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b19f6-964c-4d67-38c1-08df35c271bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT,WEIRD_QUOTING
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Carl Lee <carl.lee@amd.com>

The LTC4287 power-monitor nodes in the Anacapa DTS overlap I2C
addresses used by other devices on the same buses.

Keeping these nodes may cause incorrect probing/binding attempts.
Remove them to avoid address conflicts.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 42 ----------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index f546a7b5786a..5c0d874fa24a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -83,30 +83,6 @@ gpio@24 {
 					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
 					"", "";
 			};
-
-			power-monitor@42 {
-				compatible = "lltc,ltc4287";
-				reg = <0x42>;
-				shunt-resistor-micro-ohms = <150>;
-			};
-
-			power-monitor@43 {
-				compatible = "lltc,ltc4287";
-				reg = <0x43>;
-				shunt-resistor-micro-ohms = <150>;
-			};
-
-			power-monitor@44 {
-				compatible = "lltc,ltc4287";
-				reg = <0x44>;
-				shunt-resistor-micro-ohms = <250>;
-			};
-
-			power-monitor@45 {
-				compatible = "lltc,ltc4287";
-				reg = <0x45>;
-				shunt-resistor-micro-ohms = <250>;
-			};
 		};
 
 		i2c@1 {
@@ -177,24 +153,6 @@ gpio@24 {
 					"","",
 					"","";
 			};
-
-			power-monitor@40 {
-				compatible = "lltc,ltc4287";
-				reg = <0x40>;
-				shunt-resistor-micro-ohms = <150>;
-			};
-
-			power-monitor@41 {
-				compatible = "lltc,ltc4287";
-				reg = <0x41>;
-				shunt-resistor-micro-ohms = <150>;
-			};
-
-			power-monitor@45 {
-				compatible = "lltc,ltc4287";
-				reg = <0x45>;
-				shunt-resistor-micro-ohms = <250>;
-			};
 		};
 	};
 };

-- 
2.34.1


