Return-Path: <linux-aspeed+bounces-4937-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E388C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:22:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0fs5ydzz2yqq;
	Thu, 03 Sep 2026 10:22:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344572;
	cv=pass; b=lpfnM0K/KuzdUT/tdY4DOYRbh2VXD1fZztxqLeYI/eYOao/YANUSV4noxZ/J7OgVHhox/ynJhEaLrQ9JiBquXWeHyIBF0Au4wBqzQs4zuqxx4JsrBHedW+vYvZhhcPRm3d5w4aWtoFyRj2hZ83ve82eLSwN91iz841anHaCqUx9agQWiXGikIN5Rwlc8QBxegFcmKSSNmi/woruPV51mjE+PSHTZ36Js2AndHXDAKpm0kzlUi8pFpMQrSDtmqN6wSjGFhSKvBlZ2BAELLQA+99aCw7Vgyy1lFKOuktKldzxd9fJIHyIc2aDRCs/jSLvD5QWNpqIcW15xZHDGoiBQAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344572; c=relaxed/relaxed;
	bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cY3OK547hR+cynyFVqBx/TZ84cDLk/cNJ8hhVhnxFuMvMSPUA1CKjNwt/jPUhtFQHggSy4W2wMIKDjQnHnbEwso+/lL/Yeg0DC801DoFX3m3fFtqBifJxoH09PLtfrQCgegCSTtg9DgQN0RtGUx9kJznCUM0z7fllr6jwVSDATU+xx5q8AFgddLJ4KlH/8v6e6eoLer+x1zoVn9zvP9ruyfGoslaeVzxOnS3Ox0QfgZ4AEdn3KBKpDBP2/4czTc6ovEvdFCzSxEOlFzuisCEphCDT+75nYbtsEx6mk94Lw1sgUyBzs6OvpabgGqnDsKlVYGYD79Aa4huY40MnUv8hw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BtCNmGGh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BtCNmGGh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c105::7; helo=ch4pr04cu002.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1l6MTSz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp5yawI3LhCvSH5mGUwYuzdAecoiodEaw6zGDEmOHKzZFdzMCCKLz7/urIb+JRUKyVGYIxZzVBQDPyBUqU9MBPn2Xm5/Hf8XxWK7DVlFdwMw0Gs4UqMMpBvX/bMJO8GLf3KYLZOyJJp7Kk+40zCZKSL3V4Z7zgktsSlOsSAJIVnenwHlrPHK14BdXq6wjihuC3etrx4hXGNChlqoBqvYvUUpBd0vvbhZedxblpRv8HtG6HJ7lJiCjIArXBfIrzXqfdwun6J/IRFTIxKcY/2LxjHft5+jlF/5e0cw+bDbuMq73C27RlucEm+th5yC4maFcZJDQzy5YeycRB3V29gKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
 b=Fb3N2jyrWp7az2g8IxVNlhe/IAmwGQkVu07vSGAlM98xdHX4wX17+A63VJbHF8ltdEAKNPji5ojZB+QKLMQzWIaocxq8oqe89Mxnsct5qel9/ehFYPF1lGLIGRywoMA/qIN9Jf0Dul12roxYXtUoSc5Q+ExmGW1JreHJrPI+Vk3O3ZE7FpeprtL9OWlM4x9melDESCFtiZ0s+PMGU022koKKE22UVtTgktQr0MJvARNz8FxgIW3uG4M5VmqhZKr26XpYDPcu9qMyDg4nHdBly3uybWd4nX6wJ0YMOP0Z5SCWEfsSDRmBaUj7/FbJ5Phs8CA9MveiHE7SDobfanY5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
 b=BtCNmGGh9hwOfDHluCqcL14zRI8NgQuNFEiR0z2wRJ4ykyiGUXhUlh2un5QdCPb+rOkYgGI0nO4kh+pmCN/3/uIHM1FatwKLIsEjOU/ilxAqTs/SZZSQPWD9HZo3lMBVYVfLAmqDgVaOe01cnCnA8+zfqSWnYsfeKhMTZM74V7U=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by CHAPR12MB999248.namprd12.prod.outlook.com (2603:10b6:610:2ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:27 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2a01:111:f403:c902::b) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:23 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:20 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:19 +0800
Subject: [PATCH v8 07/11] ARM: dts: aspeed: anacapa: Enable MCTP and FRU
 for NIC
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-7-69c8eb2a7cda@gmail.com>
References: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
In-Reply-To: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Andy Chung
	<Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=3254;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=xSybis4WnZ0wCCi5yNlS7U3ZxSjvjItq7krEUM0miaU=;
 b=CLqCcYJoPpX5GX/Qr80BeGDmPdzaN97aanRt2Txebmgy9U+kpFu/HT9Hl2IMKGzmbg1eFKHXr
 WLHaKN45VTMDdnKXmkP/E+22ONMZBrh/5QOqwD8uxrgsIAZ73h8kTSc
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CHAPR12MB999248:EE_
X-MS-Office365-Filtering-Correlation-Id: 07727b38-edb4-47b3-8971-08df08dc1642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|20046099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6RkuuK6vgHtqM3H00fGnabh9MQpbLZm74P8qYVx8mrrolTEYrf93tGlm1p50C1WkVX6vDufJHFiRCgdFw2lhLOCnGMarLwdW0q2iFeKuV4WnJKjaoIatziw8u7LNOJ51T8VDqDaiyioXysj7XSwKZZFeY3g8uVfszeJJqRECb+SoSr2dAH6hd2Iua6KPFNT+d0cT1WemStL/KVy2jtqz3nAOST4MitufQKz7QfQo5B5EQ2htRhVGKCCp6FGAQv0GCsKWt2y3B8EEGlQ7zkyZhv3inBpbVdrHSNzLezKoyr6BhjVTcVCidlvurupNBVs/J8Bc6XcLKHgD+qhFQlx+W7wU0SJ0+yw87DsiH6v9MPHXkQBTJ6zQLuhfaC2+2QzGO8IJo7mUCx4H/Jdd3x+kfaaBY8zCymj0y1hHtUg30/1X4ED2tWEgEZOgBUNn/mFJnVtzoX9LsfvA3ZKAuTqnJnDvn+Q/ZlqbJTYpRu4fFgLMLGY1YeF7S7p+qtykiyORQ3P+lm4yTBdmnKqjuAMTPrsoIhHFeTdJgkSnLZcnBRsSpfQKWZm+aHLbB75khfM6K+d+PzsCBH082XDE7xbOP0oOJz8oxaoSZjpgX/pAkfZRglRO1ai0zRGQBebFteRdkqxm7N3HEy6T7SooDoK6AvP144dKL6ImlcocpBEM1s4UKVgW22Qp19ehlI9JbpY8fNXFGfWBhueteNrri/9g+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(20046099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ngOV+WqL5WthzR1wrtoOSXRttDL9eXmQSlB+dqkhtvRxGPIygf8RKRzJGcij/CmGhZFrImhgfrDaKcvcJWe81IfT7uBLC4jjI3ebW7muhTabyhqPdOQKOURYv00Q1KCevDDGSrBO/xqAZWyUrXvPOdau7DizvZO7hAguomlpisaUShFitP/7BswjBQ/MEhsKjfrR/JZ3NoKJIgwRUNdWqhKCtPQjJy/s3TSmN4rOZtg5Eqgnw8TcULLsxpKBFZ3/ngz6Tqhx+BzEZuP/TkZTywtFiH5GoXvpeXYYEg6akc49ikTISgcCaIwIPsdrQopVvbaqfsps5ldZ1tdgD/Lr/IuU0wTQO7LVMjIzgz39uVS+NQX41yvEhDiHLpwh1g9rLbuBATV3dDf1AM6uvr+EVlNt6otn+w8xLiRQ4GTkSkZe0d9gDgysYyOi5eHp/T6Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:26.8168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07727b38-edb4-47b3-8971-08df08dc1642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999248

From: Andy Chung <Andy.Chung@amd.com>

Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU and reorder the I2C virtual bus
index accroding to the system silkscreen index.

Signed-off-by: Andy Chung <Andy.Chung@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index 3ea5d67865d4..ab16e5ad5871 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,25 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+&{/aliases} {
+	i2c36 = &i2c11mux0ch5;
+	i2c37 = &i2c11mux0ch6;
+	i2c38 = &i2c11mux0ch7;
+	i2c39 = &i2c11mux0ch0;
+	i2c40 = &i2c11mux0ch1;
+	i2c41 = &i2c11mux0ch2;
+	i2c42 = &i2c11mux0ch3;
+	i2c43 = &i2c11mux0ch4;
+	i2c44 = &i2c10mux0ch1;
+	i2c45 = &i2c10mux0ch2;
+	i2c46 = &i2c10mux0ch3;
+	i2c47 = &i2c10mux0ch4;
+	i2c48 = &i2c10mux0ch5;
+	i2c49 = &i2c10mux0ch6;
+	i2c50 = &i2c10mux0ch7;
+	i2c51 = &i2c10mux0ch0;
+};
+
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {
@@ -50,6 +69,124 @@ eeprom@51 {
 	};
 };
 
+// R Bridge Board
+&i2c10 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c10mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+// L Bridge Board
+&i2c11 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c11mux0ch0: i2c@0 {
+			mctp-controller;
+			// FE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 // MB
 &i2c13 {
 	i2c-mux@70 {

-- 
2.34.1


