Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A5606A320
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DyE5c6Q/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVZD21dtkz2xSF;
	Thu, 19 Nov 2026 21:17:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795083474;
	cv=pass; b=kzRXY42bFtA9Kh44eN8D1gaXgbhxZ0+IQaL0z/9Egozb0+JRc958VP7ELCdoRFtvocCp4FySNq0hOaepNxcbt5OjzmCva9VhGtNYir90ty3PdODGYERbX6FUzf64cdRoHzJQYE5pynINyaaxi8Jq4xdLQOxlxgTQPEOoBwDy9AIZj76Ir377x/ssQXUJqyyAC+t3XbfU8Uvg4+dtdwuO+V0RRp7d7SHueUVFgMbFwUKhc/1hr85u/eWXXAMoYYouzt4VuV54JkPI2vlXUOKInfvrd4xNFtax1xE4ZxfEb0JCnBtZbyK2zPltP9itmuYz/OBIOX7YA5xAI9gqxEgslA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795083474; c=relaxed/relaxed;
	bh=Xw/btS2Df2sNXLEpjZc7uU2DA5ThItMTyKFdM3bEJ2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNQ+S5R3v86pbOkmpfk/VJUCNdShQbaUEPbvMOD0pEKX9OS5q2PUHhEuoZtE/SzGAcB9l4diaRDxYSHsNJXLHMnlG12pBQk7XZiExY3oSDxfrHsSPE7y+MTNtd7laMeuzUhjj9plR8a9vfE9YDz+lz19dZTFn6LnseT5erpiAAfqalYjdEC3SNOkyJGjYDDhn2vKY0B9gd7OO6xJ145vMewRs7KktbehQInkKbHhr9YQ+zo++3nF8if1tycsjKYN8TZXuFAU9t2NlggPjo0ge5EBewD1ZwSK0MsfP+jDTaVIpEhZCqrNiWKm/Ot7giDuKDjCbauzcZrdp3TqsA3mhQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DyE5c6Q/; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DyE5c6Q/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVZD02vgdz2y2T;
	Thu, 19 Nov 2026 21:17:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLMorrtZ889t8sSXrGqUAiBM0vMOiavojpXwv2+irEWtS/Jrw7j8hKRLTsSLW612AzTyUShFHc/7jOGTMXrjV4s7o8NEhBEnqVihiVfpLiEspzahWF2bxHPah8GYsnfofFvssI1if5G/bSxXSSRLdLoOFZAWp6fjavjoOoOw9J4p4lodYTkgvLE0BHaoaozrEpU/8Zg2i+8vSoQwJrcWsmH65s6AlLeiDFMpMpREhIFQxUSme4OfW6bYMExU+vaOgaY46FC4UVdijHJBsycLRlvOSeb5ecbx4uf43i+n9ySah+zuELB8nHVJPtpoOHg8tf7M3OyCnGGsIlc8WVzT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw/btS2Df2sNXLEpjZc7uU2DA5ThItMTyKFdM3bEJ2E=;
 b=tpVP5Fd6iaf0SCPM90ggruoFb9a0Wc4bsOV7saOICoqpjHhFSw4Y8Kd7PAwECuJbK18MC2THRLZksVefdD1EoWZLt2snZh7p9dGk79rwxfze4rKOc7I0IK1Zjpi8kmfwm3QchOE+nGWMcmaJGvb/lAoX+6anut6SOyA7OHblrvoENcyoDihr7eIXRiJi7Ecenq70eFbW8nu/oq42Mz496zdHHroTy8aOK/vVxFrnhVFzQE6eXQJKgDFfm1Vqwq/VNKAqVXv+/OzAtWE0GBwIle2zUHOCwNRpDVEvvWF3iCBzdg7Amvo6o/VFDgjReguXwtuwpV5OtenZuabaN9MdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw/btS2Df2sNXLEpjZc7uU2DA5ThItMTyKFdM3bEJ2E=;
 b=DyE5c6Q/r9SSw7WZH/lzIq9kraURqjFQ8L3ryyOsJkObwrjKeNeLeBGo5zebzau2YLeeh2XUCi2kJNB89ZFJZFUmbIQ/xJSlesMHJhS5xvUEnbCAS9JWJNZZYq6sGeViPGFnAM/fBAJKRpBITYWrAc208EISbrgNdW0ApOhr+weMlGGNSA6Rzf46WeBN9qnxq+RCrmgf3HwL6B5zWE13exQxACdNg3+Aa6zihatTgbdyOt1M8VFsmAUClOK4qwTxoWbQdBbYRtaIM5Elida1cERoPnpeUwQN49cIpBOjd07+O5A3KVbC3maVnpKj/czP1knMOZKaO2NDXN0F6ZbqYA==
Received: from BN0PR04CA0195.namprd04.prod.outlook.com (2603:10b6:408:e9::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:17:24 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::11) by BN0PR04CA0195.outlook.office365.com
 (2603:10b6:408:e9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 10:17:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:17:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:17:07 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:17:05 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, Andrew Lunn <andrew@lunn.ch>,
	<devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Thu, 19 Nov 2026 19:16:41 +0900
Message-ID: <dc78c9c1aea306be5a3c4b06a9a85969b2ee6913.1795081735.git.jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795081735.git.jackyhuang@nvidia.com>
References: <cover.1795081735.git.jackyhuang@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b24d460-b413-4099-3ae1-08df46264dad
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|36860700016|376014|82310400026|261021135927099003|261022075727099003|261021123027099003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 ax9NYzT0HM/Iqy9YqdQsV5xnvDIC9R5pMthd6BRCnilsCMQ9WseTDIUKtjUG73PK+OROGirqXNZfUI0oZRvbossCt9SEjJ1YJGLH8xS0NPype5vP1T84jory4mUpLMyQdkZ4FxGgxQ7K26lm1GnvCJKi+/ixWlEKcV8CMr4zPdbPhEnB4Tt1UzDTnBo3H/xuSQusISXxgGBrbh62cfzCOfl8iR8eaFNwz3PiisxR1dqfDrc7fLikRibHS68H+SaE7MaLFNP38RHSo6VnpSVf8Y7sDSlB9RUcA+mScbWB0Wt4W7BW2NK/qcjg+/dTOsvfICHvVClzmPGnYKmM2ywa5Fm9EvnLtlYNUJaw42h+nv4Cwvl9FXTJP1hgibwDPyeCzrcFX4lIRgDuR2BCpEuzf7nqgwtF+QD59K5xlJko8T3rLMs/PYCAD53WemTwZTVGpcrRA+NxDPkJ5xsxYUVvZ28rcVyRoAjq7fJQ2mNBuZWx7VhoNSvqBJR4hG2PVl++wZWqALWxAtsr0zjTAfDTOe5JL8J4TJQ6NrUNxmExfk2EZB+lMzJrlcifaUPrxaAJiXDC8Jyq2RdqEXaBTX4e1GJhamQAYIdGG8eC1TGIaXQfBkYwq9PCPLlTEMo2Vl5CJlVbh/a3unwuXUAtvlPS01sD7KQ2x1I32RM0SIF5B0/1SSVmMj/wa7wNwjz5sLgNX7Qpvxnr4OCL5Z2+5mJZ3Q==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(36860700016)(376014)(82310400026)(261021135927099003)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 4YAajQJu+PBH1eWGka3/hZZqaube8aHaKWLi6PH6iYqGdnjIdJjK1JRK+h5mQN0ffGTJo5eb6bkfbN+VybHkqfYzAANNSQR8zj0hdZfUkW7safCUlbrk71wVlLA5DyGbUInb2KRqX1w9xYg9ViXZwWVkWbwzuMQKwUO1PlpXX8eLqvgyAmUdMSgchYnZROuhUp1nzHj1rVRJT+i06/v1awNN6h9wub74Up0gi+eMzP83d4Cpfx0cOV+lcFnxS2EO+WgKCt+GGdo9du/e0av1E240vEPq7OXbPWfYkNWlz2WE7GDfwDc2WEIUzjubBLS7tnqVNPRugmfGOf8IkP/c/607IM4f+8y58Kb98g3nnmlF9B7lHPV69VUcxw4XeX4AZGZi06nvsxF2MxGiXZShrs3R8jfyjsYX26iW6EHZUohJ2VZZ2lr/PyWDFBNrZ19T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:17:23.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b24d460-b413-4099-3ae1-08df46264dad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NVIDIA MGX Vera C2 is a dual-socket, air-cooled 2U server reference
platform based on NVIDIA Vera CPUs. It provides a reference design
for partners to build and customize Vera-based servers using the
MGX modular architecture.

Add the device tree for the platform's ASPEED AST2600 BMC.

Link: https://www.nvidia.com/en-us/data-center/products/mgx/
Link: https://www.nvidia.com/en-us/data-center/vera-cpu/
Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
Changes in v4:
- Remove line names for GPIOs unused on the production board.

Changes in v3:
- Describe the platform's purpose and link to the MGX and Vera CPU pages.
- Drop the misleading RGMII delay comment.
- Update the write-protect GPIO name.

Changes in v2:
- Specify the console and baud rate in stdout-path and drop bootargs.
- Use generic GPIO expander, fan controller and regulator node names.
- Fix gpio-line-names indentation and GPIO bank comment formatting.

 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts    | 1266 +++++++++++++++++
 2 files changed, 1267 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 6874b621d..e5c44d423 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
 	aspeed-bmc-nvidia-msx4-bmc.dtb \
+	aspeed-bmc-nvidia-vr-c2-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts
new file mode 100644
index 000000000..ecbcff048
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-c2-bmc.dts
@@ -0,0 +1,1266 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "AST2600 MGX Vera C2 BMC";
+	compatible = "nvidia,vr-c2-bmc", "aspeed,ast2600";
+
+	aliases {
+		i2c16 = &i2c_usbhub;
+		i2c17 = &i2c_tpm;
+		i2c18 = &i2c_dp;
+		i2c19 = &i2c_rtc;
+		i2c20 = &i2c_fan_ctrl0;
+		i2c21 = &i2c_fan_ctrl1;
+		i2c22 = &i2c_fan_iox;
+		i2c23 = &i2c_fan_hsc;
+		i2c30 = &i2c_mcio_c0c1_north0;
+		i2c31 = &i2c_mcio_c0c1_north1;
+		i2c32 = &i2c_mcio_c0c1_north2;
+		i2c33 = &i2c_mcio_c0c1_north3;
+		i2c34 = &i2c_mcio_c0c1_north4;
+		i2c35 = &i2c_mcio_c0c1_north5;
+		i2c36 = &i2c_mcio_c0c1_north6;
+		i2c37 = &i2c_mcio_c0c1_north7;
+		i2c40 = &i2c_mcio_c0_south0;
+		i2c41 = &i2c_mcio_c0_south1;
+		i2c42 = &i2c_mcio_c0_south2;
+		i2c43 = &i2c_mcio_c0_south3;
+		i2c44 = &i2c_mcio_c0_south4;
+		i2c45 = &i2c_mcio_c0_south5;
+		i2c46 = &i2c_mcio_c0_south6;
+		i2c47 = &i2c_mcio_c0_south7;
+		i2c50 = &i2c_mcio_c1_south0;
+		i2c51 = &i2c_mcio_c1_south1;
+		i2c52 = &i2c_mcio_c1_south2;
+		i2c53 = &i2c_mcio_c1_south3;
+		i2c54 = &i2c_mcio_c1_south4;
+		i2c55 = &i2c_mcio_c1_south5;
+		i2c56 = &i2c_mcio_c1_south6;
+		i2c57 = &i2c_mcio_c1_south7;
+		serial2 = &uart3;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fault-led {
+			gpios = <&exp7 12 GPIO_ACTIVE_LOW>;
+		};
+
+		power-led {
+			gpios = <&exp7 8 GPIO_ACTIVE_LOW>;
+		};
+
+		uid-led {
+			gpios = <&exp7 10 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	standby_power_regulator: regulator-standby-power {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "standby_power";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		framebuffer@9f000000 {
+			reg = <0x9f000000 0x01000000>;
+			no-map;
+		};
+
+		ramoops@a0000000 {
+			compatible = "ramoops";
+			reg = <0xa0000000 0x100000>;
+			max-reason = <2>;
+			record-size = <0x10000>;
+		};
+
+		framebuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x01000000>;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x02000000>;
+		};
+	};
+};
+
+/*
+ * NVIDIA multi-interface MCU enumerates as hid-generic by default
+ * and binds to hid-cp2112 at runtime
+ */
+&ehci1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@2 {
+			compatible = "usb424,2422";
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hub@1 {
+				compatible = "usb424,2514";
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				device@1 {
+					compatible = "usb955,cf11";
+					reg = <1>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cp2112: interface@1 {
+						compatible = "usbif955,cf11.config1.1";
+						reg = <1 1>;
+						#gpio-cells = <2>;
+						gpio-controller;
+						#interrupt-cells = <2>;
+						interrupt-controller;
+
+						i2c {
+							#address-cells = <1>;
+							#size-cells = <0>;
+
+							/* CPU0 IROT/thermal/SOCAMM/JTAG */
+							gpio@50 {
+								compatible = "nxp,pca9555";
+								reg = <0x50>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"CPU0_IROT_RECOVERY_L_3V3-I",
+									"CPU0_IROT_FATAL_ERR_L_3V3-I",
+									"CPU0_OVERT_L-I",
+									"C0_THERM_WARN_N-I",
+									"C0_S0_THERM_OVERT_N-I",
+									"CPU0_CHIPTHROT_L-I",
+									"C0_SOCAMM_0_ID_PRSNT_N_1V8-I",
+									"C0_SOCAMM_1_ID_PRSNT_N-I",
+									"C0_SOCAMM_2_ID_PRSNT_N-I",
+									"C0_SOCAMM_3_ID_PRSNT_N-I",
+									"C0_SOCAMM_4_ID_PRSNT_N-I",
+									"C0_SOCAMM_5_ID_PRSNT_N-I",
+									"C0_SOCAMM_6_ID_PRSNT_N-I",
+									"C0_SOCAMM_7_ID_PRSNT_N-I",
+									"MCU_JTAG_BYPASS_CPU0_S-O",
+									"MCU_JTAG_BYPASS_CPU0-O";
+							};
+
+							/* CPU1 IROT/thermal/SOCAMM/JTAG */
+							gpio@51 {
+								compatible = "nxp,pca9555";
+								reg = <0x51>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"CPU1_IROT_RECOVERY_L_3V3-I",
+									"CPU1_IROT_FATAL_ERR_L_3V3-I",
+									"CPU1_OVERT_L-I",
+									"C1_THERM_WARN_N-I",
+									"C1_S0_THERM_OVERT_N-I",
+									"CPU1_CHIPTHROT_L-I",
+									"C1_SOCAMM_0_ID_PRSNT_N-I",
+									"C1_SOCAMM_1_ID_PRSNT_N-I",
+									"C1_SOCAMM_2_ID_PRSNT_N-I",
+									"C1_SOCAMM_3_ID_PRSNT_N-I",
+									"C1_SOCAMM_4_ID_PRSNT_N-I",
+									"C1_SOCAMM_5_ID_PRSNT_N-I",
+									"C1_SOCAMM_6_ID_PRSNT_N-I",
+									"C1_SOCAMM_7_ID_PRSNT_N-I",
+									"MCU_JTAG_BYPASS_CPU1_S-O",
+									"MCU_JTAG_BYPASS_CPU1-O";
+							};
+
+							/* Module thermal/leak/MCU alerts */
+							gpio@52 {
+								compatible = "nxp,pca9555";
+								reg = <0x52>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"COMBINED_CPU_CEM_WAKE_L-I",
+									"MCU_THERM_OVERT_N-I",
+									"MCU_THERM_WARN_N-I",
+									"PCB_T_SENSOR_ALERT_L-I",
+									"GLOBAL_WP_1V8-I",
+									"NVBUF_LOS_L-I",
+									"LEAK_DETECT_L-I",
+									"vLeakDetect1Status0-I",
+									"vLeakDetect1Status1-I",
+									"vLeakDetect2Status0-I",
+									"vLeakDetect2Status1-I",
+									"BMC_IOX_INT_L-I",
+									"MCU_BMC_ALERT_L-I",
+									"MCU_HMC_ALERT_L-I",
+									"MCU_USER_STRAP-I",
+									"HPM_MCU_OK-I";
+							};
+
+							/* CPLD status/OOB mux/pwr brake */
+							gpio@53 {
+								compatible = "nxp,pca9555";
+								reg = <0x53>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"CPLD_RESET_L-I",
+									"CPLD_PSEQ_FAULT-I",
+									"CPLD_READY-I",
+									"CPLD_PROGRAM-I",
+									"INPUT_12V_VALID_VMON_PG-I",
+									"RUN_PWR_EN_1V8-I",
+									"MODULE_PWR_GOOD_1V8-I",
+									"MCU_I2C_RTC_ALERT_L-I",
+									"SLOT_PWR_BRAKE_EN_L-I",
+									"OOB_MUX_CTRL0-O",
+									"OOB_MUX_CTRL1-O",
+									"OOB_MUX_CTRL2-O",
+									"CPU_OOB_CS0_L-O",
+									"CPU_OOB_CS1_L-O",
+									"LEAK_SELF_TEST_L_1V8-I",
+									"MCU_RECOVERY_L-I";
+							};
+
+							/* JTAG route/SSIF alert/USB force */
+							gpio@54 {
+								compatible = "nxp,pca9555";
+								reg = <0x54>;
+								gpio-controller;
+								#gpio-cells = <2>;
+								interrupt-controller;
+								#interrupt-cells = <2>;
+								interrupt-parent = <&cp2112>;
+								interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+								gpio-line-names =
+									"JTAG_SEL_MCU-O",
+									"JTAG_TCK_MCU-O",
+									"JTAG_TMS_MCU-O",
+									"JTAG_TDO_MCU-I",
+									"JTAG_TDI_MCU-O",
+									"JTAG_TRST_L_MCU-O",
+									"CPU0_SSIF_ALERT_L_3V3-I",
+									"CPU1_SSIF_ALERT_L_1V8-I",
+									"USB_HMC_TO_CPU_FORCE_EN_L-O",
+									"v_CPLD_AUTH_FAIL-I",
+									"",
+									"",
+									"",
+									"",
+									"",
+									"";
+							};
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+/* Primary BMC flash: standard OpenBMC 64MB layout */
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
+
+		status = "okay";
+
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+		/* A0-A7 */
+		"", "", "", "", "", "", "", "",
+
+		/* B0-B7 */
+		"", "", "", "", "", "", "", "",
+
+		/* C0-C7 */
+		"", "", "", "", "", "", "", "",
+
+		/* D0-D7 */
+		"", "", "", "", "",
+		"FPGA_PEX_RST_L-O",
+		"", "",
+
+		/* E0-E7 */
+		"RTL8211_PHY_RST_L-O",
+		"RTL8211_PHY_INT_L-I",
+		"", "", "", "", "",
+		"SGPIO_BMC_EN-O",
+
+		/* F0-F7 */
+		"", "", "", "", "", "", "", "",
+
+		/* G0-G7 */
+		"", "", "", "", "", "", "", "",
+
+		/* H0-H7 */
+		"", "", "", "", "", "", "", "",
+
+		/* I0-I7 */
+		"", "", "", "", "",
+		"QSPI2_RST_L-O",
+		"GLOBAL_WP_BUF-I",
+		"BMC_DDR4_TEN-O",
+
+		/* J0-J7 */
+		"", "", "", "", "", "", "", "",
+
+		/* K0-K7 */
+		"", "", "", "", "", "", "", "",
+
+		/* L0-L7 */
+		"", "", "", "", "", "", "", "",
+
+		/* M0-M7 */
+		"PCIE_EP_RST_EN-O",
+		"BMC_FRU_WP-O",
+		"HMC_RESET_L-O",
+		"STBY_POWER_EN-O",
+		"STBY_POWER_PG-I",
+		"PCIE_EP_RST_L-O",
+		"", "",
+
+		/* N0-N7 */
+		"", "", "", "", "", "", "", "",
+
+		/* O0-O7 */
+		"", "", "", "", "", "", "", "",
+
+		/* P0-P7 */
+		"", "", "", "", "", "", "", "",
+
+		/* Q0-Q7 */
+		"", "", "", "", "", "", "", "",
+
+		/* R0-R7 */
+		"", "", "", "", "", "", "", "",
+
+		/* S0-S7 */
+		"", "", "", "", "", "", "", "",
+
+		/* T0-T7 */
+		"", "", "", "", "", "", "", "",
+
+		/* U0-U7 */
+		"", "", "", "", "", "", "", "",
+
+		/* V0-V7 */
+		"", "", "", "",
+		"PCB_TEMP_ALERT-I",
+		"", "", "",
+
+		/* W0-W7 */
+		"", "", "", "", "", "", "",
+		"CPU_RST_L-I",
+
+		/* X0-X7 */
+		"", "",
+		"TPM_MUX_SEL-O",
+		"", "", "", "", "",
+
+		/* Y0-Y7 */
+		"", "", "",
+		"EMMC_RST-O",
+		"", "", "", "",
+
+		/* Z0-Z7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* A0-A7 */
+		"", "", "", "", "", "", "", "",
+
+		/* B0-B7 */
+		"", "", "", "",
+		"AP_EROT_REQ-O",
+		"EROT_AP_GNT-I",
+		"IO_EXPANDER_INT_L-I",
+		"",
+
+		/* C0-C7 */
+		"", "", "", "", "", "", "", "",
+
+		/* D0-D7 */
+		"", "", "", "", "", "", "",
+		"I2C_SSIF_ALERT_L-I",
+
+		/* E0-E3 */
+		"", "", "", "";
+};
+
+/* Host CPU SSIF (IPMI) */
+&i2c0 {
+	status = "okay";
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+/* Board 0 management bus 1: GPIO expanders + HPM MCU MCTP */
+&i2c1 {
+	mctp-controller;
+	multi-master;
+
+	status = "okay";
+
+	/* MCTP for HPM MCU */
+	mctp@18 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x18 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	/* Board 0 management bus 1 GPIO expander 0 */
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M1_MCU_RESET_L-O",
+			"B0_M1_MCU_RECOVERY_L-O",
+			"B0_M1_I2C_SOCAMM_UPHY_SEL-O",
+			"B0_M1_SNN_GPU0_MCU_REC_L",
+			"B0_M1_THERM_OVERT_L-I",
+			"B0_M1_THERM_WARN_L-I",
+			"B0_M1_HMC_IST_PRE_RST_L-O",
+			"B0_M1_CPLD_READY-I",
+			"B0_M1_MODULE_PWR_GOOD-I",
+			"B0_M1_MCU_HMC_ALERT_L-I",
+			"B0_M1_USB1_HUB_RST_L-O",
+			"B0_M1_HPM_MCU_OK-I",
+			"B0_M1_CPU_SHDN_OK_L_3V3-I",
+			"B0_M1_SNN_BOARD_LOC_STRAP",
+			"B0_M1_IST_SYS_RST_L-O",
+			"B0_M1_PWR_BRAKE_L_STATUS-I";
+	};
+
+	/* Board 0 management bus 1 GPIO expander 1 */
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M1_CPU_FORCED_RECOVERY_L-O",
+			"B0_M1_CPU_BOOT_DEV_SEL0-O",
+			"B0_M1_CPU_BOOT_DEV_SEL1-O",
+			"B0_M1_CPU_BOOT_DEV_SEL2-O",
+			"B0_M1_HMC_BRD_ID0",
+			"B0_M1_CPU_RECOVERY_TYPE0-O",
+			"B0_M1_CPU_RECOVERY_TYPE1-O",
+			"B0_M1_CPU_IST_BOOT_HMC-O",
+			"B0_M1_CPU_PREBOOT_DIAG-O",
+			"B0_M1_HMC_BRD_ID1",
+			"B0_M1_HPM_MCU_I2C_ENABLE-O",
+			"B0_M1_CPU_DIE_SEL0-O",
+			"B0_M1_CPU_DIE_SEL1-O",
+			"B0_M1_CPU_DIE_SEL2-O",
+			"B0_M1_CPU_BOOT_COMPLETE-O",
+			"B0_M1_IOX_JTAG_NVSEL-O";
+	};
+};
+
+/* Board 0 management bus 0 GPIO expanders */
+&i2c2 {
+	status = "okay";
+
+	/* Board 0 management bus 0 GPIO expander 0 */
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M0_SHDN_FORCE_L-O",
+			"B0_M0_STBY_PWR_PG-I",
+			"B0_M0_THERM_OVERT_L-I",
+			"B0_M0_THERM_WARN_L-I",
+			"B0_M0_GLOBAL_WP-O",
+			"B0_M0_USB0_HUB_RST_L-O",
+			"B0_M0_IOX_PRE_SYS_RST_N-O",
+			"B0_M0_LEAK_DETECT_ALERT_L-I",
+			"B0_M0_RUN_PWR_EN-O",
+			"B0_M0_MODULE_PWR_GOOD-I",
+			"B0_M0_CPU_CHIPTHROT_L_3V3-I",
+			"B0_M0_SHDN_REQ_L_3V3-O",
+			"B0_M0_CPU_SHDN_OK_L_3V3-I",
+			"B0_M0_CPLD_READY-I",
+			"B0_M0_PWR_BRAKE_L_3V3-O",
+			"B0_M0_PWR_BRAKE_L_STATUS-I";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 1 */
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M0_I2C_BUS_MUX_RST_L-O",
+			"B0_M0_HPM_MCU_OK-I",
+			"B0_M0_CPU_SYS_RST_N_3V3-I",
+			"B0_M0_C0_SOCAMM_DAC_I2C_SEL_R-O",
+			"B0_M0_C1_SOCAMM_DAC_I2C_SEL_R-O",
+			"B0_M0_C0_SOCAMM_I2C_SEL-O",
+			"B0_M0_C1_SOCAMM_I2C_SEL-O",
+			"B0_M0_EEPROM_POWER_DISABLE-O",
+			"B0_M0_CPU_L0L1_RST_L_3V3-I",
+			"B0_M0_CPU_L2_RST_L_3V3-I",
+			"B0_M0_BRD_ID_0",
+			"B0_M0_BRD_ID_1",
+			"B0_M0_BMC_LEAK_TEST_L-O",
+			"B0_M0_MCU_BMC_ALERT_L-I",
+			"B0_M0_CPU_BOOT_COMPLETE_3V3-I",
+			"B0_M0_SNN_GPU_MCU_I2C_ENABLE";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 2 */
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M0_C0_UPHY0_PRSNT0_L-I",
+			"B0_M0_C0_UPHY0_PRSNT1_L-I",
+			"B0_M0_C0_UPHY0_PRSNT2_L-I",
+			"B0_M0_C0_UPHY0_PRSNT3_L-I",
+			"B0_M0_C0_UPHY1_PRSNT0_L-I",
+			"B0_M0_C0_UPHY1_PRSNT1_L-I",
+			"B0_M0_RSVD_C0_UPHY1_PRSNT2_L",
+			"B0_M0_RSVD_C0_UPHY1_PRSNT3_L",
+			"B0_M0_C0_UPHY2_PRSNT0_L-I",
+			"B0_M0_C0_UPHY2_PRSNT1_L-I",
+			"B0_M0_C0_UPHY2_PRSNT2_L-I",
+			"B0_M0_C0_UPHY2_PRSNT3_L-I",
+			"B0_M0_C0_UPHY3_PRSNT0_L-I",
+			"B0_M0_C0_UPHY3_PRSNT1_L-I",
+			"B0_M0_RSVD_C0_UPHY3_PRSNT2_L",
+			"B0_M0_RSVD_C0_UPHY3_PRSNT3_L";
+	};
+
+	/* Board 0 management bus 0 GPIO expander 3 */
+	gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M0_C1_UPHY0_PRSNT0_L-I",
+			"B0_M0_C1_UPHY0_PRSNT1_L-I",
+			"B0_M0_C1_UPHY0_PRSNT2_L-I",
+			"B0_M0_C1_UPHY0_PRSNT3_L-I",
+			"B0_M0_RSVD_C1_UPHY1_PRSNT0_L",
+			"B0_M0_C1_UPHY1_PRSNT1_L-I",
+			"B0_M0_RSVD_C1_UPHY1_PRSNT2_L",
+			"B0_M0_RSVD_C1_UPHY1_PRSNT3_L",
+			"B0_M0_C1_UPHY2_PRSNT0_L-I",
+			"B0_M0_C1_UPHY2_PRSNT1_L-I",
+			"B0_M0_C1_UPHY2_PRSNT2_L-I",
+			"B0_M0_C1_UPHY2_PRSNT3_L-I",
+			"B0_M0_C1_UPHY3_PRSNT0_L-I",
+			"B0_M0_C1_UPHY3_PRSNT1_L-I",
+			"B0_M0_RSVD_C1_UPHY3_PRSNT2_L",
+			"B0_M0_RSVD_C1_UPHY3_PRSNT3_L";
+	};
+};
+
+/* MCIO expansion muxes */
+&i2c4 {
+	multi-master;
+
+	status = "okay";
+
+	mctp@18 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x18 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&standby_power_regulator>;
+
+		i2c_mcio_c0_south0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0_south7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&standby_power_regulator>;
+
+		i2c_mcio_c0c1_north0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c0c1_north7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9548";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		vdd-supply = <&standby_power_regulator>;
+
+		i2c_mcio_c1_south0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			mctp-controller;
+			#size-cells = <0>;
+		};
+
+		i2c_mcio_c1_south7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* SMM carrier GPIO expanders */
+&i2c5 {
+	status = "okay";
+
+	/* SMM carrier GPIO expander 0 */
+	exp7: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"HMC_RST_R_L-O",
+			"HMC_RECOVERY_R-O",
+			"HMC_SPI_MUX_R_SEL-O",
+			"GLOBAL_WP-O",
+			"HMC_READY-I",
+			"HMC_PRSNT_R-I",
+			"BMC_SELF_PWR_CYCLE-O",
+			"EEDO_LED2-O",
+			"PWR_LED_L-O",
+			"PWR_BTN_L-I",
+			"UID_LED_L-O",
+			"UID_BTN_L-I",
+			"FAULT_LED_L-O",
+			"USB2_HUB_RST_L-O",
+			"IOX_GPIO_P16_TP",
+			"WARN_LED_L-O";
+	};
+
+	/* SMM carrier GPIO expander 1 */
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"BMC_HMC_MUX_SEL-O",
+			"BMC_TPM_MUX_SEL-O",
+			"BMC_USB2_MUX_SEL-O",
+			"HMC_PGOOD_3V3-I",
+			"BF3_AOC_NCSI_PRSNT_L-I",
+			"HDR_SPI_PRSNT_L-I",
+			"SW_NRESET_R_L-O",
+			"MUX_I2C_ESPI_SEL-O",
+			"I2C_BUS_MUX_RESET_L-O",
+			"USB_MUX_EN-O",
+			"PDB_TRAY_RST-O",
+			"USB_PWR_EN-O",
+			"RTC_CLR_L-O",
+			"I2C_RTC_ALERT_L-I",
+			"I2C_PDB_ALERT_L-I",
+			"BMC_MUX_PI3DP_SEL-O";
+	};
+};
+
+/* Leak and fan path via PCA9546 */
+&i2c6 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		/* USB hub I2C */
+		i2c_usbhub: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* TPM */
+		i2c_tpm: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* DisplayPort aux */
+		i2c_dp: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* RTC */
+		i2c_rtc: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* M.2 SSD management */
+&i2c8 {
+	status = "okay";
+};
+
+/* Power distribution board */
+&i2c9 {
+	status = "okay";
+
+	exp21: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"PDB_TYPE-I",
+			"PDB_STBY_PWR_EN-O",
+			"PDB_STBY_PWR_OK-I",
+			"PDB_MCU_RECOVERY_L-O",
+			"PDB_MCU_RST_L-O",
+			"PDB_MAIN_PWR_EN-O",
+			"PDB_MAIN_PWR_OK-I",
+			"PDB_GLB_WP-O",
+			"PDB_PWR_BRK_L-I",
+			"PDB_FAN_CTL_PRSNT_L-I",
+			"PDB_P12V_HPM_EN-O",
+			"PDB_MUX_SEL-O",
+			"PDB_P12V_GPU1_EN-O",
+			"PDB_P12V_GPU2_EN-O",
+			"PDB_PSU_PWOK-I",
+			"PDB_PS_ON_L-O";
+	};
+};
+
+/* PDB mux-gpios: 0 = PSU, 1 = fan */
+/ {
+	i2c-mux-pdb {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-parent = <&i2c9>;
+		mux-gpios = <&exp21 11 GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+
+		/* PSU devices */
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* Fan board devices */
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-mux@76 {
+				compatible = "nxp,pca9546";
+				reg = <0x76>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c_fan_ctrl0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c_fan_ctrl1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c_fan_iox: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c_fan_hsc: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+	};
+};
+
+/* BMC FRU EEPROM and temperature sensor */
+&i2c10 {
+	status = "okay";
+
+	/* BMC FRU EEPROM */
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+/* Module 0 UPHY3 SMBus */
+&i2c14 {
+	status = "okay";
+};
+
+/* Module 1 UPHY3 SMBus */
+&i2c15 {
+	status = "okay";
+};
+
+/* Fan controller 0 */
+&i2c_fan_ctrl0 {
+	fan-controller@2c {
+		compatible = "maxim,max31790";
+		reg = <0x2c>;
+	};
+};
+
+/* Fan controller 1 */
+&i2c_fan_ctrl1 {
+	fan-controller@2f {
+		compatible = "maxim,max31790";
+		reg = <0x2f>;
+	};
+};
+
+/* Fan board GPIO expanders */
+&i2c_fan_iox {
+	gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"FAN_P12V_FAN12_EN-O",
+			"FAN_P12V_FAN34_EN-O",
+			"FAN_P12V_FAN56_EN-O",
+			"FAN_P12V_FAN12_PG-I",
+			"FAN_P12V_FAN34_PG-I",
+			"FAN_P12V_FAN56_PG-I",
+			"",
+			"",
+			"FAN_FAN1_PRSNT_BUF_L-I",
+			"FAN_FAN2_PRSNT_BUF_L-I",
+			"FAN_FAN3_PRSNT_BUF_L-I",
+			"FAN_FAN4_PRSNT_BUF_L-I",
+			"FAN_FAN5_PRSNT_BUF_L-I",
+			"FAN_FAN6_PRSNT_BUF_L-I",
+			"FAN_FANCTRL_FAIL_L-I",
+			"FAN_FANCTRL2_FAIL_L-I";
+	};
+
+	gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"FAN_FAN1_FAIL_LED-O",
+			"FAN_FAN2_FAIL_LED-O",
+			"FAN_FAN3_FAIL_LED-O",
+			"FAN_FAN4_FAIL_LED-O",
+			"FAN_FAN5_FAIL_LED-O",
+			"FAN_FAN6_FAIL_LED-O",
+			"",
+			"",
+			"FAN_VR_P12V_FAN12_ALERT-I",
+			"FAN_VR_P12V_FAN34_ALERT-I",
+			"FAN_P12V_FAN56_ALERT-I",
+			"",
+			"",
+			"",
+			"",
+			"";
+	};
+};
+
+/* GPU0 GPIO expander */
+&i2c_mcio_c0_south2 {
+	/* GPU 0, Expander @0x20 */
+	gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"GPU0_GLOBAL_WP-O",
+			"GPU0_OOB_RST_N-O",
+			"GPU0_OOB_RECOVERY-O",
+			"GPU0_MCU_RECOVERY_N-O",
+			"GPU0_MCU_RST_N-O",
+			"GPU0_MCU_BYPASS_N-O",
+			"GPU0_SMBUS_FRU_EEPROM_WP-O",
+			"";
+	};
+};
+
+/* E1.S backplane GPIO expander (C2) */
+&i2c_mcio_c0c1_north6 {
+	/* E1S Backplane, Expander @0x20 */
+	gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"E1S_MCU_RESET_L-O",
+			"E1S_MCU_RECOVERY_L-O",
+			"",
+			"",
+			"",
+			"",
+			"E1S_LOWER_PERST-O",
+			"E1S_UPPER_PERST-O";
+	};
+};
+
+/* GPU1 GPIO expander (C2) */
+&i2c_mcio_c1_south0 {
+	/* GPU 1, Expander @0x20 */
+	gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"GPU1_GLOBAL_WP-O",
+			"GPU1_OOB_RST_N-O",
+			"GPU1_OOB_RECOVERY-O",
+			"GPU1_MCU_RECOVERY_N-O",
+			"GPU1_MCU_RST_N-O",
+			"GPU1_MCU_BYPASS_N-O",
+			"GPU1_SMBUS_FRU_EEPROM_WP-O",
+			"";
+	};
+};
+
+&mac0 {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+/* NCSI MAC */
+&mac2 {
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	pinctrl-names = "default";
+	use-ncsi;
+
+	status = "okay";
+};
+
+/* MDIO for schematic MAC1 PHY */
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+/* BMC <-> host CPU UART */
+&uart1 {
+	status = "okay";
+};
+
+/* Serial-over-LAN */
+&uart3 {
+	status = "okay";
+};
+
+/* BMC debug console */
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+/* USB device toward host */
+&vhub {
+	status = "okay";
+};
+
+/* Video engine */
+&video {
+	memory-region = <&video_engine_memory>;
+
+	status = "okay";
+};
-- 
2.43.0


