Return-Path: <linux-aspeed+bounces-5094-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DA0CA5FC5
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 01:02:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwDBx2jvbz30CZ;
	Thu, 01 Oct 2026 11:01:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748868;
	cv=pass; b=eZC8FCMY9jGqL7AchyKozNvDmhQTMJEEDRdIOFzKzNT3n1ZKe0DDsQGADUwHK+cYZvACU2gF5HQoFiK/apEGJwJAFibgiEeY/29oo5E+gMPcGljHmYeOdPFkO2z81b4zmxnqBPF7BWQGGUfsDh1fGsB1cCddbff5Pk9runkdc5nyRi1W7c7tVaBU7V1/5UKC7XzDAjyulj9ZzKAGwXc+54Ye+7XYvOtjn5L+aCOs2d0hogBCV6OmVPws6ykTG701GH4q5aQDBTX8L2Y+5X3Ko9cF9gqonFxQ5adUAtyURry8wCOQavRhtXeypWCfZU5dQx39V3di6C2ihxF/B1b1Bw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748868; c=relaxed/relaxed;
	bh=vJMVgc/OwoPyvEhvWxQJdZUhfSVpAZZCg5XYPAj/kdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lu4Lo1DiuYcuUMqSR9q0Zz/NswG+j/wvIrKXGjBR5sIb6/j2xgeah3ZlI2EPP2qGLYdE/lBw83pX1Oz36QM7B0mnL/sNgw1yWL7aSVxVmOC8OdqlDAOtWD6yZ842mCBN7+6FfzBYxLlGm9ip2VS4x///iUHM8hBc+2GOmQJmJeOgif97LNwZbuVZmklZHND2TCN+tg6F4FgYLD/bE08/WAzwfO2fxRxWDpwADwfhBvohsGPSmr2Orsd1cVlQDf+gSLCYoOQWV0UNd+syzShqvINv6EEQ9eUKleYjarViqNs3HCT76AvR28kKZ8+UX8AXdXefjWtJe8kq/R9s5QuBlQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=XrwOVAUp; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=XrwOVAUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlBC3R22z2yn2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgxwJgfcZ3LhWec+nqCzs0JLnjdQ13C0pQFXddzFFh12EkSzNF+RfluGMZLuIGgSFXuSn2k7wM9nIgA2kiBpFNzCKb00B/huK2zztVIZrER0eSQj4aWS9jnHq8TEOpy0fcc3tflAR/T8jfsizfbyj/0F1Jif+0La/5sHpd07kHm3Ti2uKbn5ZckxnM9kP0TOqW3UufGhtfzvklrG0PYxnCj97LoA2p72RTxmEzfKTNRZnRrd3zlGmfa71P2iKPLKmYrYKAnH8cRk2X3D6UG65NHLuh6iEPJwbhlpZhCfFDdmuIJ2f6uowSYOm3Ni4wR66qtzEXxY0kyLwSoeyqHrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJMVgc/OwoPyvEhvWxQJdZUhfSVpAZZCg5XYPAj/kdc=;
 b=LEEtHzMS5be321VPMxag3m25gMFPU9CYGqH+k2zfwyQRUtKGTHvxKyq6lhtS+xXigBh68QGrjL+NEmX+wS74oE4exCSPuoT1E5DMdiWgh8Ukn6IfAuTefT0EGMU7DlZwl1dHjJ05e1BGxtEzDYWBQV1vQ2F6UTCI7fdLZ8D/gK4O53kHnCytU87njuq6skY266TWM3k/6DCcL2WFVj8upaZ/tWPTMwqfprzCkbYCtwFV3ZNQxNTGvhIb3IV2yisGqDysVZv5e+6S6TffnOWjkobmdZvvjteInNR/VREEmy5ixRGx5umbuTC1zMm62qjSJCxtTM+rX4OfGn9UCI/hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJMVgc/OwoPyvEhvWxQJdZUhfSVpAZZCg5XYPAj/kdc=;
 b=XrwOVAUpF24XMjXJhKKxSFpKGqR6IG9FDuwSVUFGl4vd5umZ3t7aiFJmWX+4y3ykoUGjOtZ/LFP4LX1gtNKJOlXW33Rt43dHxb/L3L67ivOdHvSHUNaK+vjGwhTggBtqJ9RA22AwXSJAODQa4yjS8nI857F9wVCWUtOgx1tTRfcgW7FEsfyXMywOMTh5YTeWyNH156HzW9d2nBQZ1FoGSpgghBGZTvrOGkkt64CUa2GUFUGZNzzY2MpvThujuQAI8uWVP5Z/44qFm+80KYLiDPHZMgxIBdfPbgYqjuxI2xEcf901kVxFH9vsCH/tqmXK0PfhHB84xoVmyP1Hg1iptg==
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 06:14:18 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::80) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 06:14:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:14:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:14:17 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:14:14 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:21 +0800
Subject: [PATCH v9 13/15] ARM: dts: aspeed: anacapa: Remove LTC4287 power
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-13-f08aa0d7182d@gmail.com>
References: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
In-Reply-To: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Carl Lee
	<carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=1863;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=ippwuj8pzOKFkEhOs9Y9bdu/+M5Y45aCO3iLCFK9I78=;
 b=oEs5JJzsmiTP+/rBAu3FHuLgIZVWbM974MPkBaxKURbpuewsKAb3Wgj9zSccSuD+H4iksrQFT
 c4a3MGb9mDWCnS995VkYPY6GoNDeP3gavEj8bd2bUedNtSftT0nVt1T
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e56da17a-65b9-426c-5a05-08df1eba0f9f
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|82310400026|7093399015|48200799018|7416014|376014|61400799027|18002099003|22082099003|16102099003|11063799006|4128699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vB4FZopaYALKfrYV4vBDcPOp4j2szdvaw52wWjzGnwSrCAEVtw4bQZbGNRZh4LnTwq+yHTdpDtPFvJtdJ5/CTe0OP0NK+1IxE+jJ/gH2N6jlU+sL9CDHHQFeR3u6J4fjEA9kIqREvuBr6y7WRb5rE7l6xA3mLRD2E6pUR82Kdi5IvK9BYFQdlhwH37ncF+k8F7Nd0RFv22ZEodJB9d2xDwsYq8bXruihVQ8mQSd71gM6HMEw1z+9R+MXDsUYGdVKWVPUfHn4v3MJ2sg1/nD/5BlSk4WepIdcTNztcLzpLvDH7csjMItfWTMfwap7ZzMtAyVjeg9yyUHeh9pwn5Bvj5LFt8Id/rvgazKLWE2hFk35Fe/iCy/4c+bPR9XaVNu0pHgUIKwp+0A6Gp8qBcFwveTjw8NGtuzdlcfDE23eRMW1fe/Ch2A0F52DFzfxlq1cfE9GPeOR9OGfLXVrx994N0YUYcPaJKdgfE4hYFr3pqdHzfr+qHdREumiBl5blhlfvD8yqFemflyQmCzleDFVf7ILu6m59jH22n/47SwsdP7+aP4BXH9CFzw+dhM5N/BradJwPvmRGWDBlDxlltHJEooF4QAky6WSzs365Tj1+ctjZC5pJvXdJiwdrhohKHFzhKHjjjo3F4isJ6e+aepFrmv46NWjPwdCDl20iqW/Y/NPz2I3tN8hAAXim3/FXtWXEkhrXpPii8S4WY4nJ0qLPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35950700016)(82310400026)(7093399015)(48200799018)(7416014)(376014)(61400799027)(18002099003)(22082099003)(16102099003)(11063799006)(4128699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s4sP3+SEhYXBxKAg9SBSAw7I5yiBWe6BIasFLC6gIf5JtT/2dfAF4glgyUCkQsVtKgjwz5AW6B+rDdlDHaV5aFrX5gT8srKrZ8fEnXoErL4ptXZqMAQ888AES93Ejllt7JIB8WMZMOAfJGxanom/jiUI3s+Baw5DOny4EgOjDbFA1scKoyjwZPkfnbPgJbhrYX0zA1M6UXUMZWz1fKT6qW81Ul+RJLm+pgwuAU2G5RLiuNbO9J/G0KeLigUyZd6tokULttj4KxWlJ8bdItCgbOsisnrVl/JtPU34Jac1L3IdVmGfi9Xbg1mukmioFjXT0trJwTaPaj/zsHUNBaoxdD7bJvf4gj+RHhqw3a2CxOMX5NzPnJ40ym4T5fCNuU7AtYpWQpAg8sEcRiZ2t2aHhGiPVQlY4935qM5CFYfDAgxKL3An3Z34kQVYibQO2cPS
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:14:18.4284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56da17a-65b9-426c-5a05-08df1eba0f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079

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


