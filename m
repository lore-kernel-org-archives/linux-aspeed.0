Return-Path: <linux-aspeed+bounces-5072-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEA0C9830E
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvl9r6SRdz2yn2;
	Wed, 30 Sep 2026 16:14:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748848;
	cv=pass; b=hG3wSavz4LRbTdRQOsBWvM65dgZniT4f1B9IaZbZ1vuIhd/41lvfpL0Q9M2osnguQ1bp1CCaLJ2eMTaYbX6OtKYpYoq3Cb9lHfth8MxbyS0Cm1kcRNHcM4xgUNQywb9Af0wwJH0tjTwa8ASSHwUkqY9cboTM0/sLtIPy7uXbCZi5NHcpOmEHLOm3uVIEDBktiam8ya9/vZy7oDuHPSGFPEb7+J/8xiemR5bV0i4uG4nxpwrZHVsAW1I7MnF0F0FGB1l1G7lJ0mD/ng/lzaI8IHiGkwPPRuQ/ggeRUnpdvwolQohh6YYnNZ+IdnBiJ8GPmQBX6duq4h7W3mBPkWU9vg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748848; c=relaxed/relaxed;
	bh=cw9Twhzb/SGKbJsIapJwOTIQsD+KVSkRxBeIHtMu20c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nukwHrorwLfr/SKNJHeUlV7IjdSMYQj6k6s9zaT3VDM+LRX1xiQnEgYh1XPwozrnkCYoJ2Vdvu9hwyy+L6FXv1wJVgcPDn6pXq5KQDEUQ0bVENwNfdUgzzgITAp92f+JhkwT6aEwqrQK6/cNKMDwg11Pcm3XsBnHMsy6BaA2SKKhZi0ZNejyq+eT0zx+17HyfyX0jzNk7E0+Mg0/rqL4dnAUhKzP9z5bzCX2wYr9UYjCFDnBsgtomkE43X08GenwA817NfB/KiFnV7MH4X211Dmot49LYwz2UAglo5nKxZd76DKeBAoWEgDmJAlDPVWF3Q9+SirU9AXVXhn4a09E9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=y59pDZrU; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=y59pDZrU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvl9p4JBYz2yps
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lljXlZxM8FpFziSki8it/qIUre02OIwkk8aUcRkz/+GqfAJ4FhUK9n1GA1X5jgIPu3KXRnHSWKnjL8EBHpOdwWxAO4MnU7FUfRRjUwxjN+MiRoHfrwU8X0hIKNEqxLWYMhsGSI+r+z6hGLFeqWTDcTp5Cw68mnhs/+xY8ZQOlMbQZeKNkyBTTwKXO06saC78tODGFnSISVXGqs+eLu/yeoI9qVCdKSSzPOzfOADZceNn5yLoMg1+o2acFwxIRPcn/2WGq+v84WahX4keCXo3fcIEuzLTuagUfmxF8XeMUzFvcN4bAhSMAj5GIUnuW91Z922Apdgk1hlNxUesiYPZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw9Twhzb/SGKbJsIapJwOTIQsD+KVSkRxBeIHtMu20c=;
 b=GW6Cw37kYGTqSYACxt4kgrJ11fSmu2RHr+RzNDEg2tiQhQRYzx+TvFkHWezTYhJFjbmSb74QUg3DVuyrgHSDX5byrnXd/S04AggxewcQ1dah/DCADSW/O32HIEGRA8kOB0m320uatIogiuqUKDYfz+kPMJkvoq6qK1SfiBZeThoQ8LlOObDxu9WEnGcoF2/dXS8cG2HYBCLT/Fc7zu36tVLG/jbX7Bhl6Xy5HHPVIc03IUbiZdtublHSDygurHc0CuzhwXgThSAqyEmHXLtrQgGMp7yJ/Agn/7m90e0Gya0G182yjq0PPlYvAoV8Pdsjj7fNY34/N8/YS4IXxnaH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw9Twhzb/SGKbJsIapJwOTIQsD+KVSkRxBeIHtMu20c=;
 b=y59pDZrUdrxwdYcW/NnZLqB0AIhirSoAVzTN77EU8dGRQHCmuAMgTrYazCEPxHX8dcVxVHRsTmy2yfwiFAMTPzioiv6VpvpuuWsO2M1mpPe3g/tADrATWktzqdeEaOPTqBfAKB8OteFKwtZeGB44Z6GRp6Epp7OR6joi3x8x+ruRpaJEITRNaX1Vj6HHYB3q34m6dY9z4wRVNFG14lMhJ5DAIRoDKigARDInOWfZtH7s7E/z0shhCY0nVsT90M0l6gKo2mnaXaF/wcO4gc/2Er/IOHJt1SAadkV8NnLDt9wwffIyQdOi6UE5PofN4Cu79xt2yOnrARKCVcmoS1K0Hg==
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 06:13:41 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::5b) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 06:13:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:13:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:39 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:13:37 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:09 +0800
Subject: [PATCH v9 01/15] ARM: dts: aspeed: anacapa: Add EVT1 devicetree
 and point wrapper to it
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
Content-Transfer-Encoding: 8bit
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-1-f08aa0d7182d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=47478;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=eHXThxC1EYDPCfOU2F+qiSJ5gNgQCkEcnaUe/lOdhFY=;
 b=kivpNuol5Fs8w3R4PaYb/ttW6cz3xHd3uGREk9wcuW61bCW055+dcQlXUOpq/XrRCxwg19fHm
 BhKaJ10YALRAh+X6C2vPIKP/BeFNIcQQ64hMiFxia2zHZ+xWZBoAle6
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a8cf73-ca4e-4196-2f82-08df1eb9f95a
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|82310400026|7093399015|61400799027|48200799018|376014|7416014|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003|4128699003|16102099003;
X-Microsoft-Antispam-Message-Info:
	3G4jtUm/kDcMjYOnpjsQGHxZtfo6s4JhZ0h4NKgl9VIaAm3XO1E2IsHoCT8iJogAjTFm2vdn4vAbJjqg4zp54jo3mUvXp48caJIHscxWiJNZjQmy29Reb0j1bUd07ZXUkFij+CmAWYSSe1XNr2OhvD9GuMhyHYkxvayjggG8LIn7l8JfzDJ/8OVG5ig29i4NUNO/IIKvkIn978GIZD9kS/QlMxdssuK/9pKooEfVR3KHoyz0HHFf0fBt5GuVGsdKmZWsYmWyg7ut6/WLSChXthKs0z/Tj3dxaJj6rjm9DwDK00JQw5OkoWl0EgvwWdxgFnIt5uJmUMFjqgkFZl/oFBCukrmwC54vN7ue94tcVlT2ueQvopefMSEMpE9RnoCDNijDbpYthPTGbXKjVRNkGD+taiP+bpXzspKYJIl1YZPFP4NaIOtu1VRfhrwFjGaAcWF04sqsk7pNAjD9GysBM3Ve4E+/tFyVrVrpd1SbMo6Jy1tFzwyUDMFfKms4LCNfyGwno9ASAmn8RhcbQa/SZptZPzgQlEsueJ6E42QlUdG/Qo6VFE1AYT4mDqTWf+nm+toUgHCOdgrF7ojNP5aXXfeYCcbEqON/4bPCNH+RseR9n2GOeNOCotc+1IR2O6y+neVWSpjNt/SPvfr3lEZhffbyyfP44qgRTxcFvfhsh0bAHpMqPSV9e9H+JlqBMs2eFAXGUGfrgjgxf4FgJrlr0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35950700016)(82310400026)(7093399015)(61400799027)(48200799018)(376014)(7416014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003)(4128699003)(16102099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YL+RI/k3jrMmvBQtn0nuy42Ups9WVby3yMC1xHrlxZ6lYrDfumR/F2hKFfqUknyyffsrqIseEEjztEODug68+M0Okl721+G016drGcK7z9zcoCE3NSQp6AVyvA5sUrjILBhIqDndPnGbcQS1QZW4+uRcnknU2wizPbyfOSLrqUeDoxi5iSVnzEN8XQlY9KGMPvwUaFDvkE2A+sdJaJy5fxeV6LCrGvWrW5cFodWoyw3n4xtXJsLS3WDNh+X4JoW9gZRAnfVtT8fR+Plgre4ptiZU95C1TwYpeZe+E2Dj3/nJ/z028JFThch0Z6rKST2somQVTFOZMQScPt+6eHCi/a0p9Uo0+5bdK3iG/ifp/quU/ulUC8zPijwYTcRLvXXBKexspfQvUhW49wfAQ1dFPzQBwjrvXdMtWdX6rsKt79lYUJvTzRcUL0zidO+AgNtY
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:13:41.0669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a8cf73-ca4e-4196-2f82-08df1eb9f95a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

This commit introduces an EVT1 development-phase devicetree for the
Facebook Anacapa BMC. It updates the top-level wrapper DTS to include
the EVT1 hardware revision file.
 
A dedicated EVT1 DTS is added as the base revision for subsequent
board variants. The EVT1 devicetree is derived from the original
Anacapa devicetree and incorporates several cleanups and fixes:

  - Remove redundant vhub pinctrl-names
  - Use default SPI2 memory mapping
  - Fix dt-check-style strict violations
    Remove p3v3_bmc_aux lable to fix '[unused-lable]' warning.
 
The top-level aspeed-bmc-facebook-anacapa.dts now includes the EVT1
devicetree, allowing EVT2 and DVT revisions to inherit from a common
baseline while preserving a single build target for Anacapa.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi   | 1127 ++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1077 +------------------
 2 files changed, 1128 insertions(+), 1076 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
new file mode 100644
index 000000000000..5f9cfeec39cb
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
@@ -0,0 +1,1127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	compatible = "facebook,anacapa-bmc", "aspeed,ast2600";
+	model = "Facebook Anacapa BMC";
+
+	aliases {
+		i2c16 = &i2c0mux0ch0;
+		i2c17 = &i2c0mux0ch1;
+		i2c18 = &i2c0mux0ch2;
+		i2c19 = &i2c0mux0ch3;
+		i2c20 = &i2c1mux0ch0;
+		i2c21 = &i2c1mux0ch1;
+		i2c22 = &i2c1mux0ch2;
+		i2c23 = &i2c1mux0ch3;
+		i2c24 = &i2c4mux0ch0;
+		i2c25 = &i2c4mux0ch1;
+		i2c26 = &i2c4mux0ch2;
+		i2c27 = &i2c4mux0ch3;
+		i2c28 = &i2c4mux0ch4;
+		i2c29 = &i2c4mux0ch5;
+		i2c30 = &i2c4mux0ch6;
+		i2c31 = &i2c4mux0ch7;
+		i2c32 = &i2c8mux0ch0;
+		i2c33 = &i2c8mux0ch1;
+		i2c34 = &i2c8mux0ch2;
+		i2c35 = &i2c8mux0ch3;
+		i2c36 = &i2c10mux0ch0;
+		i2c37 = &i2c10mux0ch1;
+		i2c38 = &i2c10mux0ch2;
+		i2c39 = &i2c10mux0ch3;
+		i2c40 = &i2c10mux0ch4;
+		i2c41 = &i2c10mux0ch5;
+		i2c42 = &i2c10mux0ch6;
+		i2c43 = &i2c10mux0ch7;
+		i2c44 = &i2c11mux0ch0;
+		i2c45 = &i2c11mux0ch1;
+		i2c46 = &i2c11mux0ch2;
+		i2c47 = &i2c11mux0ch3;
+		i2c48 = &i2c11mux0ch4;
+		i2c49 = &i2c11mux0ch5;
+		i2c50 = &i2c11mux0ch6;
+		i2c51 = &i2c11mux0ch7;
+		i2c52 = &i2c13mux0ch0;
+		i2c53 = &i2c13mux0ch1;
+		i2c54 = &i2c13mux0ch2;
+		i2c55 = &i2c13mux0ch3;
+		i2c56 = &i2c13mux0ch4;
+		i2c57 = &i2c13mux0ch5;
+		i2c58 = &i2c13mux0ch6;
+		i2c59 = &i2c13mux0ch7;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 2>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			label = "bmc_heartbeat_amber";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+			label = "fp_id_amber";
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x80000000>;
+		device_type = "memory";
+	};
+
+	regulator-p3v3-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "p3v3_bmc_aux";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		gfx_memory: framebuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x01000000>;
+		};
+
+		video_engine_memory: video {
+			compatible = "shared-dma-pool";
+			alignment = <0x00100000>;
+			reusable;
+			size = <0x02c00000>;
+		};
+	};
+
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		#size-cells = <0>;
+
+		status = "okay";
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			reg = <0>;
+			spi-max-frequency = <33000000>;
+		};
+	};
+};
+
+&adc0 {
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		    &pinctrl_adc2_default &pinctrl_adc3_default
+		    &pinctrl_adc4_default &pinctrl_adc5_default
+		    &pinctrl_adc6_default &pinctrl_adc7_default>;
+	pinctrl-names = "default";
+	aspeed,int-vref-microvolt = <2500000>;
+
+	status = "okay";
+};
+
+&adc1 {
+	pinctrl-0 = <&pinctrl_adc10_default>;
+	pinctrl-names = "default";
+	aspeed,int-vref-microvolt = <2500000>;
+
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
+#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+
+	/*A0-A7*/
+	"","","","","","","","",
+
+	/*B0-B7*/
+	"BATTERY_DETECT", "", "", "BMC_READY",
+	"", "FM_ID_LED", "", "",
+
+	/*C0-C7*/
+	"","","","","","","","",
+
+	/*D0-D7*/
+	"","","","","","","","",
+
+	/*E0-E7*/
+	"","","","","","","","",
+
+	/*F0-F7*/
+	"","","","","","","","",
+
+	/*G0-G7*/
+	"FM_MUX1_SEL", "", "", "",
+	"", "", "FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
+
+	/*H0-H7*/
+	"","","","","","","","",
+
+	/*I0-I7*/
+	"", "", "", "",
+	"", "FLASH_WP_STATUS", "BMC_JTAG_MUX_SEL", "",
+
+	/*J0-J7*/
+	"","","","","","","","",
+
+	/*K0-K7*/
+	"","","","","","","","",
+
+	/*L0-L7*/
+	"","","","","","","","",
+
+	/*M0-M7*/
+	"", "BMC_FRU_WP", "", "",
+	"", "", "", "",
+
+	/*N0-N7*/
+	"LED_POSTCODE_0", "LED_POSTCODE_1", "LED_POSTCODE_2", "LED_POSTCODE_3",
+	"LED_POSTCODE_4", "LED_POSTCODE_5", "LED_POSTCODE_6", "LED_POSTCODE_7",
+
+	/*O0-O7*/
+	"","","","","","","","",
+
+	/*P0-P7*/
+	"PWR_BTN_BMC_BUF_N", "", "ID_RST_BTN_BMC_N", "",
+	"PWR_LED", "", "", "BMC_HEARTBEAT_N",
+
+	/*Q0-Q7*/
+	"","","","","","","","",
+
+	/*R0-R7*/
+	"","","","","","","","",
+
+	/*S0-S7*/
+	"", "", "SYS_BMC_PWRBTN_N", "",
+	"", "", "", "RUN_POWER_FAULT",
+
+	/*T0-T7*/
+	"","","","","","","","",
+
+	/*U0-U7*/
+	"","","","","","","","",
+
+	/*V0-V7*/
+	"","","","","","","","",
+
+	/*W0-W7*/
+	"","","","","","","","",
+
+	/*X0-X7*/
+	"","","","","","","","",
+
+	/*Y0-Y7*/
+	"","","","","","","","",
+
+	/*Z0-Z7*/
+	"SPI_BMC_TPM_CS2_N", "", "", "SPI_BMC_TPM_CLK",
+	"SPI_BMC_TPM_MOSI", "SPI_BMC_TPM_MISO", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/
+	"","","","","","","","",
+
+	/*18B0-18B7*/
+	"","","","",
+	"FM_BOARD_BMC_REV_ID0", "FM_BOARD_BMC_REV_ID1",
+	"FM_BOARD_BMC_REV_ID2", "",
+
+	/*18C0-18C7*/
+	"","","","","","","","",
+
+	/*18D0-18D7*/
+	"","","","","","","","",
+
+	/*18E0-18E3*/
+	"FM_BMC_PROT_LS_EN", "AC_PWR_BMC_BTN_N", "", "";
+};
+
+// L Bridge Board
+&i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c0mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// R Bridge Board
+&i2c1 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c1mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// MB - E1.S
+&i2c4 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c4mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// AMC
+&i2c5 {
+	status = "okay";
+};
+
+// MB
+&i2c6 {
+	status = "okay";
+
+	// HPM FRU
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+// SCM
+&i2c7 {
+	status = "okay";
+};
+
+// MB - PDB
+&i2c8 {
+	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9546";
+		reg = <0x72>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c8mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
+					"RPDB_FAN_CT_FAN_FAIL_R_N", "",
+					"", "",
+					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
+					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
+					"RPDB_I2C_P12V_MB_VRM_ALERT_R_N",
+					"RPDB_I2C_P12V_STBY_VRM_ALERT_R_N",
+					"RPDB_PGD_P3V3_STBY_PWRGD_R",
+					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9555";
+				reg = <0x24>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN1_R2_PG", "RPDB_P50V_FAN2_R2_PG",
+					"RPDB_P50V_FAN3_R2_PG", "RPDB_P50V_FAN4_R2_PG",
+					"", "RPDB_FAN1_PRSNT_N_R",
+					"", "RPDB_FAN2_PRSNT_N_R",
+					"RPDB_FAN3_PRSNT_N_R", "RPDB_FAN4_PRSNT_N_R",
+					"", "";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+
+			// R-PDB FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+
+		i2c8mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
+					"LPDB_FAN_CT_FAN_FAIL_R_N","",
+					"","",
+					"LPDB_ALERT_P50V_HSC0_R_N","LPDB_ALERT_P50V_HSC1_R_N",
+					"LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
+					"LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
+					"LPDB_PWRGD_P50V_HSC5_SYS_R","";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9555";
+				reg = <0x24>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
+					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",
+					"LPDB_P50V_FAN5_R2_PG","LPDB_FAN1_PRSNT_N_R",
+					"LPDB_FAN2_PRSNT_N_R","LPDB_FAN3_PRSNT_N_R",
+					"LPDB_FAN4_PRSNT_N_R","LPDB_FAN5_PRSNT_N_R",
+					"","",
+					"","",
+					"","";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+
+			// L-PDB FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+
+		i2c8mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c8mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// SCM
+&i2c9 {
+	status = "okay";
+
+	// SCM FRU
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	// BSM FRU
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+// R Bridge Board
+&i2c10 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c10mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"","",
+					"","RBB_CPLD_REFRESH_IN_PRGRS_R_L",
+					"RBB_EAM0_NIC_CBL_PRSNT_R_L","RBB_EAM1_NIC_CBL_PRSNT_R_L",
+					"RBB_AINIC_JTAG_MUX_R2_SEL","RBB_SPI_MUX0_R2_SEL",
+					"RBB_AINIC_PRSNT_R_L","RBB_AINIC_OE_R_N",
+					"RBB_AINIC_BOARD_R2_ID","RBB_RST_USB2_HUB_R_N",
+					"RBB_RST_FT4222_R_N","RBB_RST_MCP2210_R_N",
+					"","";
+			};
+
+			// R Bridge Board FRU
+			eeprom@52 {
+				compatible = "atmel,24c256";
+				reg = <0x52>;
+			};
+		};
+
+		i2c10mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// L Bridge Board
+&i2c11 {
+	status = "okay";
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c11mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"","",
+					"","LBB_CPLD_REFRESH_IN_PRGRS_R_L",
+					"LBB_EAM0_NIC_CBL_PRSNT_R_L","LBB_EAM1_NIC_CBL_PRSNT_R_L",
+					"LBB_AINIC_JTAG_MUX_R2_SEL","LBB_SPI_MUX0_R2_SEL",
+					"LBB_AINIC_PRSNT_R_L","LBB_AINIC_OE_R_N",
+					"LBB_AINIC_BOARD_R2_ID","LBB_RST_USB2_HUB_R_N",
+					"LBB_RST_FT4222_R_N","LBB_RST_MCP2210_R_N",
+					"","";
+			};
+
+			// L Bridge Board FRU
+			eeprom@52 {
+				compatible = "atmel,24c256";
+				reg = <0x52>;
+			};
+		};
+
+		i2c11mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// Debug Card
+&i2c12 {
+	status = "okay";
+};
+
+// MB
+&i2c13 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
+
+		i2c13mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c13mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c13mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c13mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+		};
+
+		i2c13mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			// HPM BRD ID FRU
+			eeprom@51 {
+				compatible = "atmel,24c256";
+				reg = <0x51>;
+			};
+		};
+
+		i2c13mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c13mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c13mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			nfc@28 {
+				compatible = "nxp,nxp-nci-i2c";
+				reg = <0x28>;
+
+				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+};
+
+// SCM
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&mac2 {
+	pinctrl-0 = <&pinctrl_ncsi3_default>;
+	pinctrl-names = "default";
+	use-ncsi;
+
+	status = "okay";
+};
+
+&sgpiom0 {
+	bus-frequency = <2000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/* A0-A7 line 0-15 */
+	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
+	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
+	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
+	"", "", "", "",
+
+	/* B0-B7 line 16-31 */
+	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
+	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
+	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
+	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
+	"Channel4_leakage_Manifold2", "",
+	"Channel5_leakage_EAM1", "",
+	"Channel6_leakage_CPU_DIMM", "",
+	"Channel7_leakage_EAM2", "",
+
+	/* C0-C7 line 32-47 */
+	"RSVD_RMC_GPIO3", "", "", "",
+	"", "", "", "",
+	"LEAK_DETECT_RMC_N", "JTAG_CPLD_TRST_R_N", "", "",
+	"", "", "", "",
+
+	/* D0-D7 line 48-63 */
+	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
+	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
+	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
+	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
+	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
+	"", "", "", "",
+
+	/* E0-E7 line 64-79 */
+	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
+	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
+	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
+	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
+	"", "", "", "",
+	"", "", "", "",
+
+	/* F0-F7 line 80-95 */
+	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
+	"PWRGD_PVDDCR_CPU0_P0", "",
+	"", "", "", "",
+	"", "", "", "",
+
+	/* G0-G7 line 96-111 */
+	"L_PRSNT_EDSFF0_N", "",
+	"L_PRSNT_EDSFF1_N", "",
+	"R_PRSNT_EDSFF2_N", "",
+	"R_PRSNT_EDSFF3_N", "",
+	"HPM_EDSFF_PG", "",
+	"PWRGD_CHEH_CPU0_FPGA", "",
+	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
+	"", "",
+
+	/* H0-H7 line 112-127 */
+	"PWRGD_P3V3", "",
+	"P12V_DDR_IP_PWRGD_R", "",
+	"P12V_DDR_AH_PWRGD_R", "",
+	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
+	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
+	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
+	"PWRGD_PVDD18_S5_P0_PG", "",
+	"PWRGD_PVDD33_S5_P0_PG", "",
+
+	/* I0-I7 line 128-143 */
+	"EAM0_BRD_PRSNT_R_L", "",
+	"EAM1_BRD_PRSNT_R_L", "",
+	"EAM2_BRD_PRSNT_R_L", "",
+	"EAM3_BRD_PRSNT_R_L", "",
+	"EAM0_CPU_MOD_PWR_GD_R", "",
+	"EAM1_CPU_MOD_PWR_GD_R", "",
+	"PRSNT_EDSFF_BOOT_N", "",
+	"EAM3_CPU_MOD_PWR_GD_R", "",
+
+	/* J0-J7 line 144-159 */
+	"PRSNT_L_BIRDGE_R", "",
+	"PRSNT_R_BIRDGE_R", "",
+	"BRIDGE_L_MAIN_PG_R", "",
+	"BRIDGE_R_MAIN_PG_R", "",
+	"BRIDGE_L_STBY_PG_R", "",
+	"BRIDGE_R_STBY_PG_R", "",
+	"", "", "", "",
+
+	/* K0-K7 line 160-175 */
+	"ADC_I2C_ALERT_N", "",
+	"TEMP_I2C_ALERT_R_L", "",
+	"CPU0_VR_SMB_ALERT_CPLD_N", "",
+	"COVER_INTRUDER_R_N", "",
+	"HANDLE_INTRUDER_CPLD_N", "",
+	"IRQ_MCIO_CPLD_WAKE_R_N", "",
+	"APML_CPU0_ALERT_R_N", "",
+	"PDB_ALERT_R_N", "",
+
+	/* L0-L7 line 176-191 */
+	"L_EDSFF0_PG", "", "L_EDSFF1_PG", "",
+	"R_EDSFF2_PG", "", "R_EDSFF3_PG", "",
+	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
+	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
+
+	/* M0-M7 line 192-207 */
+	"EAM0_SMERR_CPLD_R_L", "",
+	"EAM1_SMERR_CPLD_R_L", "",
+	"EAM2_SMERR_CPLD_R_L", "",
+	"EAM3_SMERR_CPLD_R_L", "",
+	"CPU0_SMERR_N_R", "",
+	"CPU0_NV_SAVE_N_R", "",
+	"PDB_PWR_LOSS_CPLD_N", "",
+	"IRQ_BMC_SMI_ACTIVE_R_N", "",
+
+	/* N0-N7 line 208-223 */
+	"AMCROT_BMC_S5_RDY_R", "",
+	"AMC_RDY_R", "",
+	"AMC_STBY_PGOOD_R", "",
+	"CPU_AMC_SLP_S5_R_L", "",
+	"AMC_CPU_EAMPG_R", "",
+	"", "", "", "",
+
+	/* O0-O7 line 224-239 */
+	"HPM_PWR_FAIL", "Port80_b0",
+	"FM_DIMM_IP_FAIL", "Port80_b1",
+	"FM_DIMM_AH_FAIL", "Port80_b2",
+	"AMC_THERMTRIP_ASSERT", "Port80_b3",
+	"CPU_THERMTRIP_ASSERT", "Port80_b4",
+	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
+	"CPLD_SGPIO_RDY", "Port80_b6",
+	"", "Port80_b7",
+
+	/* P0-P7 line 240-255 */
+	"CPU0_SLP_S5_N_R", "NFC_VEN",
+	"CPU0_SLP_S3_N_R", "",
+	"FM_CPU0_PWRGD", "",
+	"PWRGD_RMC", "",
+	"FM_RST_CPU0_RESET_N", "",
+	"FM_PWRGD_CPU0_PWROK", "",
+	"wS5_PWR_Ready", "",
+	"wS0_ON_N", "PWRGD_P1V0_AUX";
+
+	ngpios = <128>;
+
+	status = "okay";
+};
+
+// BIOS Flash
+&spi2 {
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		label = "pnor";
+		spi-max-frequency = <12000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+
+		status = "okay";
+	};
+};
+
+// HOST BIOS Debug
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+// BMC Debug Console
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+
+	status = "okay";
+};
+
+&wdt1 {
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	pinctrl-names = "default";
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+	aspeed,ext-push-pull;
+	aspeed,external-signal;
+	aspeed,reset-type = "soc";
+
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 1fddf3a5d138..5e76076bdcd4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,1079 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 /dts-v1/;
-#include "aspeed-g6.dtsi"
-#include <dt-bindings/gpio/aspeed-gpio.h>
-#include <dt-bindings/i2c/i2c.h>
-
-/ {
-	model = "Facebook Anacapa BMC";
-	compatible = "facebook,anacapa-bmc", "aspeed,ast2600";
-
-	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
-		i2c16 = &i2c0mux0ch0;
-		i2c17 = &i2c0mux0ch1;
-		i2c18 = &i2c0mux0ch2;
-		i2c19 = &i2c0mux0ch3;
-		i2c20 = &i2c1mux0ch0;
-		i2c21 = &i2c1mux0ch1;
-		i2c22 = &i2c1mux0ch2;
-		i2c23 = &i2c1mux0ch3;
-		i2c24 = &i2c4mux0ch0;
-		i2c25 = &i2c4mux0ch1;
-		i2c26 = &i2c4mux0ch2;
-		i2c27 = &i2c4mux0ch3;
-		i2c28 = &i2c4mux0ch4;
-		i2c29 = &i2c4mux0ch5;
-		i2c30 = &i2c4mux0ch6;
-		i2c31 = &i2c4mux0ch7;
-		i2c32 = &i2c8mux0ch0;
-		i2c33 = &i2c8mux0ch1;
-		i2c34 = &i2c8mux0ch2;
-		i2c35 = &i2c8mux0ch3;
-		i2c36 = &i2c10mux0ch0;
-		i2c37 = &i2c10mux0ch1;
-		i2c38 = &i2c10mux0ch2;
-		i2c39 = &i2c10mux0ch3;
-		i2c40 = &i2c10mux0ch4;
-		i2c41 = &i2c10mux0ch5;
-		i2c42 = &i2c10mux0ch6;
-		i2c43 = &i2c10mux0ch7;
-		i2c44 = &i2c11mux0ch0;
-		i2c45 = &i2c11mux0ch1;
-		i2c46 = &i2c11mux0ch2;
-		i2c47 = &i2c11mux0ch3;
-		i2c48 = &i2c11mux0ch4;
-		i2c49 = &i2c11mux0ch5;
-		i2c50 = &i2c11mux0ch6;
-		i2c51 = &i2c11mux0ch7;
-		i2c52 = &i2c13mux0ch0;
-		i2c53 = &i2c13mux0ch1;
-		i2c54 = &i2c13mux0ch2;
-		i2c55 = &i2c13mux0ch3;
-		i2c56 = &i2c13mux0ch4;
-		i2c57 = &i2c13mux0ch5;
-		i2c58 = &i2c13mux0ch6;
-		i2c59 = &i2c13mux0ch7;
-	};
-
-	chosen {
-		stdout-path = "serial4:57600n8";
-	};
-
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
-				  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				  <&adc1 2>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "bmc_heartbeat_amber";
-			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		led-1 {
-			label = "fp_id_amber";
-			default-state = "off";
-			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
-	};
-
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		video_engine_memory: video {
-			size = <0x02c00000>;
-			alignment = <0x00100000>;
-			compatible = "shared-dma-pool";
-			reusable;
-		};
-
-		gfx_memory: framebuffer {
-			size = <0x01000000>;
-			alignment = <0x01000000>;
-			compatible = "shared-dma-pool";
-			reusable;
-		};
-	};
-
-	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
-		compatible = "regulator-fixed";
-		regulator-name = "p3v3_bmc_aux";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	spi_gpio: spi {
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
-		num-chipselects = <1>;
-		status = "okay";
-
-		tpm@0 {
-			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
-			reg = <0>;
-		};
-	};
-};
-
-&adc0 {
-	aspeed,int-vref-microvolt = <2500000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
-		&pinctrl_adc2_default &pinctrl_adc3_default
-		&pinctrl_adc4_default &pinctrl_adc5_default
-		&pinctrl_adc6_default &pinctrl_adc7_default>;
-	status = "okay";
-};
-
-&adc1 {
-	aspeed,int-vref-microvolt = <2500000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc10_default>;
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&fmc {
-	status = "okay";
-
-	flash@0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-128.dtsi"
-	};
-
-	flash@1 {
-		status = "okay";
-		m25p,fast-read;
-		label = "alt-bmc";
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&gfx {
-	status = "okay";
-	memory-region = <&gfx_memory>;
-};
-
-&gpio0 {
-	gpio-line-names =
-
-	/*A0-A7*/
-	"","","","","","","","",
-
-	/*B0-B7*/
-	"BATTERY_DETECT", "", "", "BMC_READY",
-	"", "FM_ID_LED", "", "",
-
-	/*C0-C7*/
-	"","","","","","","","",
-
-	/*D0-D7*/
-	"","","","","","","","",
-
-	/*E0-E7*/
-	"","","","","","","","",
-
-	/*F0-F7*/
-	"","","","","","","","",
-
-	/*G0-G7*/
-	"FM_MUX1_SEL", "", "", "",
-	"", "", "FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
-
-	/*H0-H7*/
-	"","","","","","","","",
-
-	/*I0-I7*/
-	"", "", "", "",
-	"", "FLASH_WP_STATUS", "BMC_JTAG_MUX_SEL", "",
-
-	/*J0-J7*/
-	"","","","","","","","",
-
-	/*K0-K7*/
-	"","","","","","","","",
-
-	/*L0-L7*/
-	"","","","","","","","",
-
-	/*M0-M7*/
-	"", "BMC_FRU_WP", "", "",
-	"", "", "", "",
-
-	/*N0-N7*/
-	"LED_POSTCODE_0", "LED_POSTCODE_1", "LED_POSTCODE_2", "LED_POSTCODE_3",
-	"LED_POSTCODE_4", "LED_POSTCODE_5", "LED_POSTCODE_6", "LED_POSTCODE_7",
-
-	/*O0-O7*/
-	"","","","","","","","",
-
-	/*P0-P7*/
-	"PWR_BTN_BMC_BUF_N", "", "ID_RST_BTN_BMC_N", "",
-	"PWR_LED", "", "", "BMC_HEARTBEAT_N",
-
-	/*Q0-Q7*/
-	"","","","","","","","",
-
-	/*R0-R7*/
-	"","","","","","","","",
-
-	/*S0-S7*/
-	"", "", "SYS_BMC_PWRBTN_N", "",
-	"", "", "", "RUN_POWER_FAULT",
-
-	/*T0-T7*/
-	"","","","","","","","",
-
-	/*U0-U7*/
-	"","","","","","","","",
-
-	/*V0-V7*/
-	"","","","","","","","",
-
-	/*W0-W7*/
-	"","","","","","","","",
-
-	/*X0-X7*/
-	"","","","","","","","",
-
-	/*Y0-Y7*/
-	"","","","","","","","",
-
-	/*Z0-Z7*/
-	"SPI_BMC_TPM_CS2_N", "", "", "SPI_BMC_TPM_CLK",
-	"SPI_BMC_TPM_MOSI", "SPI_BMC_TPM_MISO", "", "";
-};
-
-&gpio1 {
-	gpio-line-names =
-	/*18A0-18A7*/
-	"","","","","","","","",
-
-	/*18B0-18B7*/
-	"","","","",
-	"FM_BOARD_BMC_REV_ID0", "FM_BOARD_BMC_REV_ID1",
-	"FM_BOARD_BMC_REV_ID2", "",
-
-	/*18C0-18C7*/
-	"","","","","","","","",
-
-	/*18D0-18D7*/
-	"","","","","","","","",
-
-	/*18E0-18E3*/
-	"FM_BMC_PROT_LS_EN", "AC_PWR_BMC_BTN_N", "", "";
-};
-
-// L Bridge Board
-&i2c0 {
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c2048";
-		reg = <0x50>;
-		pagesize = <128>;
-	};
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9546";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c0mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c0mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c0mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c0mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// R Bridge Board
-&i2c1 {
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c2048";
-		reg = <0x50>;
-		pagesize = <128>;
-	};
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9546";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c1mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c1mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c1mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c1mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// MB - E1.S
-&i2c4 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c4mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c4mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// AMC
-&i2c5 {
-	status = "okay";
-};
-
-// MB
-&i2c6 {
-	status = "okay";
-
-	// HPM FRU
-	eeprom@50 {
-		compatible = "atmel,24c256";
-		reg = <0x50>;
-	};
-};
-
-// SCM
-&i2c7 {
-	status = "okay";
-
-
-};
-
-// MB - PDB
-&i2c8 {
-	status = "okay";
-
-	i2c-mux@72 {
-		compatible = "nxp,pca9546";
-		reg = <0x72>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c8mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			adc@1f {
-				compatible = "ti,adc128d818";
-				reg = <0x1f>;
-				ti,mode = /bits/ 8 <1>;
-			};
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
-
-				gpio-line-names =
-					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
-					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
-					"RPDB_FAN_CT_FAN_FAIL_R_N", "",
-					"", "",
-					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
-					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
-					"RPDB_I2C_P12V_MB_VRM_ALERT_R_N",
-					"RPDB_I2C_P12V_STBY_VRM_ALERT_R_N",
-					"RPDB_PGD_P3V3_STBY_PWRGD_R",
-					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
-			};
-
-			gpio@24 {
-				compatible = "nxp,pca9555";
-				reg = <0x24>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
-
-				gpio-line-names =
-					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
-					"RPDB_PWRGD_P50V_HSC4_SYS_R",
-					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
-					"RPDB_P50V_FAN1_R2_PG", "RPDB_P50V_FAN2_R2_PG",
-					"RPDB_P50V_FAN3_R2_PG", "RPDB_P50V_FAN4_R2_PG",
-					"", "RPDB_FAN1_PRSNT_N_R",
-					"", "RPDB_FAN2_PRSNT_N_R",
-					"RPDB_FAN3_PRSNT_N_R", "RPDB_FAN4_PRSNT_N_R",
-					"", "";
-			};
-
-			// R-PDB FRU
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-		};
-		i2c8mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
-
-				gpio-line-names =
-					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
-					"LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
-					"LPDB_FAN_CT_FAN_FAIL_R_N","",
-					"","",
-					"LPDB_ALERT_P50V_HSC0_R_N","LPDB_ALERT_P50V_HSC1_R_N",
-					"LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
-					"LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
-					"LPDB_PWRGD_P50V_HSC5_SYS_R","";
-			};
-
-			gpio@24 {
-				compatible = "nxp,pca9555";
-				reg = <0x24>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
-
-				gpio-line-names =
-					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
-					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",
-					"LPDB_P50V_FAN5_R2_PG","LPDB_FAN1_PRSNT_N_R",
-					"LPDB_FAN2_PRSNT_N_R","LPDB_FAN3_PRSNT_N_R",
-					"LPDB_FAN4_PRSNT_N_R","LPDB_FAN5_PRSNT_N_R",
-					"","",
-					"","",
-					"","";
-			};
-
-			// L-PDB FRU
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-		};
-		i2c8mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c8mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// SCM
-&i2c9 {
-	status = "okay";
-
-	// SCM FRU
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
-
-	// BSM FRU
-	eeprom@56 {
-		compatible = "atmel,24c64";
-		reg = <0x56>;
-	};
-};
-
-// R Bridge Board
-&i2c10 {
-	status = "okay";
-
-	i2c-mux@71 {
-		compatible = "nxp,pca9548";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c10mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"","",
-					"","RBB_CPLD_REFRESH_IN_PRGRS_R_L",
-					"RBB_EAM0_NIC_CBL_PRSNT_R_L","RBB_EAM1_NIC_CBL_PRSNT_R_L",
-					"RBB_AINIC_JTAG_MUX_R2_SEL","RBB_SPI_MUX0_R2_SEL",
-					"RBB_AINIC_PRSNT_R_L","RBB_AINIC_OE_R_N",
-					"RBB_AINIC_BOARD_R2_ID","RBB_RST_USB2_HUB_R_N",
-					"RBB_RST_FT4222_R_N","RBB_RST_MCP2210_R_N",
-					"","";
-			};
-
-			// R Bridge Board FRU
-			eeprom@52 {
-				compatible = "atmel,24c256";
-				reg = <0x52>;
-			};
-		};
-		i2c10mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c10mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// L Bridge Board
-&i2c11 {
-	status = "okay";
-
-	i2c-mux@71 {
-		compatible = "nxp,pca9548";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c11mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			gpio@22 {
-				compatible = "nxp,pca9555";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
-
-				gpio-line-names =
-					"","",
-					"","LBB_CPLD_REFRESH_IN_PRGRS_R_L",
-					"LBB_EAM0_NIC_CBL_PRSNT_R_L","LBB_EAM1_NIC_CBL_PRSNT_R_L",
-					"LBB_AINIC_JTAG_MUX_R2_SEL","LBB_SPI_MUX0_R2_SEL",
-					"LBB_AINIC_PRSNT_R_L","LBB_AINIC_OE_R_N",
-					"LBB_AINIC_BOARD_R2_ID","LBB_RST_USB2_HUB_R_N",
-					"LBB_RST_FT4222_R_N","LBB_RST_MCP2210_R_N",
-					"","";
-			};
-
-			// L Bridge Board FRU
-			eeprom@52 {
-				compatible = "atmel,24c256";
-				reg = <0x52>;
-			};
-		};
-		i2c11mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c11mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-// Debug Card
-&i2c12 {
-	status = "okay";
-};
-
-// MB
-&i2c13 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
-
-		i2c13mux0ch0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch2: i2c@2 {
-			reg = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch3: i2c@3 {
-			reg = <3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			adc@1f {
-				compatible = "ti,adc128d818";
-				reg = <0x1f>;
-				ti,mode = /bits/ 8 <1>;
-			};
-		};
-		i2c13mux0ch4: i2c@4 {
-			reg = <4>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			// HPM BRD ID FRU
-			eeprom@51 {
-				compatible = "atmel,24c256";
-				reg = <0x51>;
-			};
-		};
-		i2c13mux0ch5: i2c@5 {
-			reg = <5>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch6: i2c@6 {
-			reg = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-		i2c13mux0ch7: i2c@7 {
-			reg = <7>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			nfc@28 {
-				compatible = "nxp,nxp-nci-i2c";
-				reg = <0x28>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
-
-				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
-			};
-		};
-	};
-};
-
-// SCM
-&i2c14 {
-	status = "okay";
-};
-
-&i2c15 {
-	status = "okay";
-};
-
-&kcs2 {
-	aspeed,lpc-io-reg = <0xca8>;
-	status = "okay";
-};
-
-&kcs3 {
-	aspeed,lpc-io-reg = <0xca2>;
-	status = "okay";
-};
-
-&lpc_ctrl {
-	status = "okay";
-};
-
-&mac2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ncsi3_default>;
-	use-ncsi;
-};
-
-&sgpiom0 {
-	ngpios = <128>;
-	bus-frequency = <2000000>;
-	gpio-line-names =
-	/*in - out - in - out */
-	/* A0-A7 line 0-15 */
-	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
-	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
-	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
-	"", "", "", "",
-
-	/* B0-B7 line 16-31 */
-	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
-	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
-	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
-	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
-	"Channel4_leakage_Manifold2", "",
-	"Channel5_leakage_EAM1", "",
-	"Channel6_leakage_CPU_DIMM", "",
-	"Channel7_leakage_EAM2", "",
-
-	/* C0-C7 line 32-47 */
-	"RSVD_RMC_GPIO3", "", "", "",
-	"", "", "", "",
-	"LEAK_DETECT_RMC_N", "JTAG_CPLD_TRST_R_N", "", "",
-	"", "", "", "",
-
-	/* D0-D7 line 48-63 */
-	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
-	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
-	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
-	"", "", "", "",
-
-	/* E0-E7 line 64-79 */
-	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
-	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
-	"", "", "", "",
-	"", "", "", "",
-
-	/* F0-F7 line 80-95 */
-	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
-	"PWRGD_PVDDCR_CPU0_P0", "",
-	"", "", "", "",
-	"", "", "", "",
-
-	/* G0-G7 line 96-111 */
-	"L_PRSNT_EDSFF0_N", "",
-	"L_PRSNT_EDSFF1_N", "",
-	"R_PRSNT_EDSFF2_N", "",
-	"R_PRSNT_EDSFF3_N", "",
-	"HPM_EDSFF_PG", "",
-	"PWRGD_CHEH_CPU0_FPGA", "",
-	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
-	"", "",
-
-	/* H0-H7 line 112-127 */
-	"PWRGD_P3V3", "",
-	"P12V_DDR_IP_PWRGD_R", "",
-	"P12V_DDR_AH_PWRGD_R", "",
-	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
-	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
-	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
-	"PWRGD_PVDD18_S5_P0_PG", "",
-	"PWRGD_PVDD33_S5_P0_PG", "",
-
-	/* I0-I7 line 128-143 */
-	"EAM0_BRD_PRSNT_R_L", "",
-	"EAM1_BRD_PRSNT_R_L", "",
-	"EAM2_BRD_PRSNT_R_L", "",
-	"EAM3_BRD_PRSNT_R_L", "",
-	"EAM0_CPU_MOD_PWR_GD_R", "",
-	"EAM1_CPU_MOD_PWR_GD_R", "",
-	"PRSNT_EDSFF_BOOT_N", "",
-	"EAM3_CPU_MOD_PWR_GD_R", "",
-
-	/* J0-J7 line 144-159 */
-	"PRSNT_L_BIRDGE_R", "",
-	"PRSNT_R_BIRDGE_R", "",
-	"BRIDGE_L_MAIN_PG_R", "",
-	"BRIDGE_R_MAIN_PG_R", "",
-	"BRIDGE_L_STBY_PG_R", "",
-	"BRIDGE_R_STBY_PG_R", "",
-	"", "", "", "",
-
-	/* K0-K7 line 160-175 */
-	"ADC_I2C_ALERT_N", "",
-	"TEMP_I2C_ALERT_R_L", "",
-	"CPU0_VR_SMB_ALERT_CPLD_N", "",
-	"COVER_INTRUDER_R_N", "",
-	"HANDLE_INTRUDER_CPLD_N", "",
-	"IRQ_MCIO_CPLD_WAKE_R_N", "",
-	"APML_CPU0_ALERT_R_N", "",
-	"PDB_ALERT_R_N", "",
-
-	/* L0-L7 line 176-191 */
-	"L_EDSFF0_PG", "", "L_EDSFF1_PG", "",
-	"R_EDSFF2_PG", "", "R_EDSFF3_PG", "",
-	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
-	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
-
-	/* M0-M7 line 192-207 */
-	"EAM0_SMERR_CPLD_R_L", "",
-	"EAM1_SMERR_CPLD_R_L", "",
-	"EAM2_SMERR_CPLD_R_L", "",
-	"EAM3_SMERR_CPLD_R_L", "",
-	"CPU0_SMERR_N_R", "",
-	"CPU0_NV_SAVE_N_R", "",
-	"PDB_PWR_LOSS_CPLD_N", "",
-	"IRQ_BMC_SMI_ACTIVE_R_N", "",
-
-	/* N0-N7 line 208-223 */
-	"AMCROT_BMC_S5_RDY_R", "",
-	"AMC_RDY_R", "",
-	"AMC_STBY_PGOOD_R", "",
-	"CPU_AMC_SLP_S5_R_L", "",
-	"AMC_CPU_EAMPG_R", "",
-	"", "", "", "",
-
-	/* O0-O7 line 224-239 */
-	"HPM_PWR_FAIL", "Port80_b0",
-	"FM_DIMM_IP_FAIL", "Port80_b1",
-	"FM_DIMM_AH_FAIL", "Port80_b2",
-	"AMC_THERMTRIP_ASSERT", "Port80_b3",
-	"CPU_THERMTRIP_ASSERT", "Port80_b4",
-	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
-	"CPLD_SGPIO_RDY", "Port80_b6",
-	"", "Port80_b7",
-
-	/* P0-P7 line 240-255 */
-	"CPU0_SLP_S5_N_R", "NFC_VEN",
-	"CPU0_SLP_S3_N_R", "",
-	"FM_CPU0_PWRGD", "",
-	"PWRGD_RMC", "",
-	"FM_RST_CPU0_RESET_N", "",
-	"FM_PWRGD_CPU0_PWROK", "",
-	"wS5_PWR_Ready", "",
-	"wS0_ON_N", "PWRGD_P1V0_AUX";
-	status = "okay";
-};
-
-// BIOS Flash
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
-	status = "okay";
-	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		label = "pnor";
-		spi-max-frequency = <12000000>;
-		spi-tx-bus-width = <2>;
-		spi-rx-bus-width = <2>;
-		status = "okay";
-	};
-};
-
-// HOST BIOS Debug
-&uart1 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&uart4 {
-	status = "okay";
-};
-
-// BMC Debug Console
-&uart5 {
-	status = "okay";
-};
-
-&uart_routing {
-	status = "okay";
-};
-
-&uhci {
-	status = "okay";
-};
-
-&vhub {
-	status = "okay";
-	pinctrl-names = "default";
-};
-
-&video {
-	status = "okay";
-	memory-region = <&video_engine_memory>;
-};
-
-&wdt1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdtrst1_default>;
-	aspeed,reset-type = "soc";
-	aspeed,external-signal;
-	aspeed,ext-push-pull;
-	aspeed,ext-active-high;
-	aspeed,ext-pulse-duration = <256>;
-	status = "okay";
-};
+#include "aspeed-bmc-facebook-anacapa-evt1.dtsi"

-- 
2.34.1


