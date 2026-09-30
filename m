Return-Path: <linux-aspeed+bounces-5081-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA70CA5FB5
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvlBR0WpZz30DK;
	Wed, 30 Sep 2026 16:14:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748879;
	cv=pass; b=ODHznJqHkczuw8eKmUxrKFtLop+yoRauwneoLzm0pgWKwVptTXWQlwA1VEhuNeUEMLHt9ocSMv+KqvxsJtPJuk7AqaN0pQUZNGQFhJwZ94/Rie+JDKvDFu1dv5fhjTxiybfCSsBWxYXd7fb+dxaLh4D+zf5CXf0J1TueE2G/D59tsd6UHMG8m3xykvhQ31XdFasSbWlStAaRJ546qzGuLPd5cv2OKxJmkrj3+ipL3SRLVYhmhA1PdWIe2w86NkvnZfvjdUhhS/OF325dSILRJVW/kNYECmP1Ec8cnihY3RUUuXTkl9cNxH+GXJl5fxmhPF6YiowC/bo0avGjifp/Vg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748879; c=relaxed/relaxed;
	bh=WlhMA+ZDlfAPFlDQJ8STO8ZyPTbu18NIbLTAtajN8kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gU3eeW0jn3I4Q7QItMJ5h1ZuPEyd9kkZ4tZzoaUPo5+e3rbwR4icYuz88cwkKFRLVkLb+gs7VJOCN7tHkeSXMVi/NrF7j6YTJ76agPnNsnMk6CWTcsnlXRTCcV0CJ3EzDczi+AnXu9Ptu4QPhbkeRFWKPJSmDj6XEz4iyY9qaB8hAWmlNXcaYRlGathHCyD8oYP5X6qJfJUK9OqtqPf49qVoaNjGV5danPxkWgD7T8wVrw6SjtqL4vS8Vvz2TF9XswSTJwNqHo9cZHvHppQCQzbnm0wUGAY1ysn1i2E+L+1ZgjtmfhHZho5ck3Uvl40bmPpnsZVCXpOvTAk2zNxCjQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=d3eI2Cby; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=d3eI2Cby;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlBQ3DLWz2yn2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tllzgc80sywJ0ImJrKzw/nZJZ031Uq6EyCoSfTrCFg6WfsUAc6BPBNQGhsnumTakheAahpnwWW7YodksCg7Tlu80uvqFD7PvRecPUjof9FX/XOjXJ4LaR4h1N8c/hL5I2trJmKQMSPT+uC0zBVZwZhf+1Y6QD+oY4rwZwLEuzD3GSejEGSx+sa4s478aMnIHpZhqIlPng6cTiaHwYyYCp0sVlV5C/ILQIMKI3XhDXr0JR7qr74cnCyey6bhvSqXxCEY0z7clDoFwiAd2jQ+8ZKP45KnEwTgxlsmi4PExRfPT147FcBJn86zC23xy0L2Ry6Q/3CqVlicsN4YKsHiDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlhMA+ZDlfAPFlDQJ8STO8ZyPTbu18NIbLTAtajN8kY=;
 b=Z0A77np+ghremIIlHmpTkC7OUlmjJ2RQTEaOjgLjAN4uQjGoprjJ3teyEUp6dOhZnJ8aYjqzyHHPtZUT2cvyu5jEjKytqVG5XzhxBoZXNmV7XmHKNr0dHurhDIj5pXkLFxwmD3nZFgzyUsPpyZdo1MUiJTBbmozTcbzbxeKN+OzmASig3ZzBWerXVn0OoFKpWvTS88ne2xzEYL3YjymT5gbgu/wJO8aUrFx7ch2Cs5hZxHa9vPt6NkIYYjMAIcafXaPTaNGSxy9Wk+ahMNnlWR5H3wtE8WXy7/t7TW2OxADsa4tVl38lH2Ti67noD5hJK6iVyJ4Kxn4d75rEOu2K8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlhMA+ZDlfAPFlDQJ8STO8ZyPTbu18NIbLTAtajN8kY=;
 b=d3eI2Cby8izOk2vzuIipsn2x4Mul6i4oOmiOe9PcbLjts4OB+blK26hdrxTbq2uE0UXwdxDd+e0BLGhBR1p1QmU5HRtPWAg+Lxf4f6utkRSg0kP/Wcf5/IZ9i5UkRGeFj5WMxOAnJL47qcvBViWoZojp0kZN1rBKwL3mPQG2lrFpZ8nu1+sKLmK4Odxc9ANvAYnVOHkdOMOexAcDz+Ib52YfYZltKDhAiR4oS5KwmDXJpCGdn+GsVoxK/pGF1BZor29UmAy40/PpYJ/gwFTCJlXG58jtnJudRrMHhqGIIQLl6QNemLP/JC7Q7c7t8SzTiTRmC6Q0SzbrkSomBB9Aww==
Received: from BN0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:141::6)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:14:15 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::30) by BN0PR07CA0023.outlook.office365.com
 (2603:10b6:408:141::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 06:14:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:14:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:14:14 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:14:11 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:20 +0800
Subject: [PATCH v9 12/15] ARM: dts: aspeed: anacapa: Add NCT7363 fan
 controllers
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
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-12-f08aa0d7182d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=3004;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=EoPr1aSRvbTxwXKGNXjM5OoMC9gmzjxA/4Buu1Z8hh4=;
 b=ZgpTnRBKMVdCgrfP+d1Fhi4wEYlHPXXkWzHL9SOr0guA6oBVWqkhrla+OcPsGCK02yjpOC0Ho
 Bo/OAcZNgpCB6b1f5jHBouEsNWzKe3RA2uEM7EpAvQlQzsjLL+4r+4k
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d83bb4-8c4c-449c-9b08-08df1eba0dee
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7093399015|48200799018|35950700016|61400799027|7416014|376014|10067099003|11063799006|56012099006|4128699003|22082099003|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HakXxpVQPGFj6mQnRyeTB5dl6mVkchx0SFmobIdac0jHS4ItENNsRRAv2Bb5V7rv14Ls1pTC0WtxJq0p9RBzpPpxemyzX4nSCb7ix4TmcRwvz9vszkQeC0QZLFyqUQu+3EnU85tbCRttpW2u44DqGwJrmX+auF3GIEzah3aNX8ymLCLFx+gSgui4XCkN9Ti5OdBEvty2gYt5fCYEbsC6OhrocF5K+FkiFt7bGCeWA6yxJlU+aT8tuEWHiCbBekX21bzuD3XQjVAs2F4Wgzs6K2EuGSVr5yTRe8wX3R/6g8uCA4zX5cNlIQoqETdtiJjvCBhG4qXQdk6MaumfJ0rrH234cRveuy5Az0prbSjPRJkBj80Yvmsi+Nmtd09pwYq6bWEAKgWude41MaE6dRduByIixVm9cclgxRHpop3mgwNfwIDJ1YiiIzToc7TgSbDVV6i9J47isZ0GSugI48nrlxuphgj6Hw3x8m/hCcQqOK5OwjyRgDSnrk4Wx9SZRTA/g4ZDintx2VzKRRHiQLyb7HWVyQbmpIxrJ+FylrllPApP8bbVrZWgN7RD6Vtw9aU9QsEI/FwxfdbFBBfHFWMwDaGs/RY08kazszi9jlpXKQNWUBwGfvxDQLI8LfdaKR56KLDgGXYGAm7lWgNseFAwR8nKDz9YqnbEbUk6M7ynBEYMQ2wDF0WpyqTwBtyGZ9obk08wdwt1dnNQFkcLIc4Oug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7093399015)(48200799018)(35950700016)(61400799027)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4128699003)(22082099003)(16102099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bfeBWN0j03lkyYGT8W99TZvn+Ww9wD3GL9Vxx2z+/ratG/oh47I727bb1vASadJqeRE061PDQr2t55jbfCI906n9Qv3zHr6yhOKm23WcXk8M7DZAxy6rR9v/J6jCgLMHPIFPxFxEdLEeIhUhZ6utBxikjojGMbmhvJhPt6bOv/PGbuaN4PV3aXnvdx0eY+PEJHs4HM74yDTT53+1YBAKj7zVdRgIl91UIeq8mO3Th8PFtl2BUvUcj8ezim/UcmzeXGWe2Vh92tV13ZmPilSlhqyF9FcGouvKrrlB05RiHAfEwyANFT9evbvcjsdsp3C4d5Jp22+rzV+/Cu7lfjGRkI0uvn3+ZytTsyM6s/KIbLq09HwwB1DFbP+RQNyrJAj9LayS7ng7cBU6mk8rUlJZLxOEjgDoAUz2oTQ3GAjsis6eNsniwHYJuI/iDqrpJ61l
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:14:15.5951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d83bb4-8c4c-449c-9b08-08df1eba0dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509

From: Carl Lee <carl.lee@amd.com>

Add two NCT7363 fan-controller nodes on Anacapa I2C mux
channels and define their PWM/tach channel mappings.

This matches the fan-control hardware layout and allows the
kernel to probe the correct fan-controller devices.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index 5f849bd21fe0..f546a7b5786a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -25,6 +25,52 @@
 &i2c8 {
 	i2c-mux@72 {
 		i2c@0 {
+			fanctl1: fan-controller@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-0 {
+					pwms = <&fanctl1 6 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-2 {
+					pwms = <&fanctl1 9 40000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-3 {
+					pwms = <&fanctl1 9 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+
+				fan-5 {
+					pwms = <&fanctl1 12 40000>;
+					tach-ch = /bits/ 8 <0x05>;
+				};
+
+				fan-6 {
+					pwms = <&fanctl1 12 40000>;
+					tach-ch = /bits/ 8 <0x06>;
+				};
+
+				fan-9 {
+					pwms = <&fanctl1 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-10 {
+					pwms = <&fanctl1 0 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+
+				fan-15 {
+					pwms = <&fanctl1 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+			};
+
 			gpio@24 {
 				gpio-line-names =
 					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
@@ -64,6 +110,62 @@ power-monitor@45 {
 		};
 
 		i2c@1 {
+			fanctl0: fan-controller@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-0 {
+					pwms = <&fanctl0 6 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-2 {
+					pwms = <&fanctl0 9 40000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-3 {
+					pwms = <&fanctl0 9 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+
+				fan-5 {
+					pwms = <&fanctl0 12 40000>;
+					tach-ch = /bits/ 8 <0x05>;
+				};
+
+				fan-6 {
+					pwms = <&fanctl0 12 40000>;
+					tach-ch = /bits/ 8 <0x06>;
+				};
+
+				fan-9 {
+					pwms = <&fanctl0 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-10 {
+					pwms = <&fanctl0 0 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+
+				fan-12 {
+					pwms = <&fanctl0 3 40000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-13 {
+					pwms = <&fanctl0 3 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+
+				fan-15 {
+					pwms = <&fanctl0 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+			};
+
 			gpio@24 {
 				gpio-line-names =
 					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",

-- 
2.34.1


