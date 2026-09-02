Return-Path: <linux-aspeed+bounces-4936-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E1BC624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:22:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0fl3dLjz2yqT;
	Thu, 03 Sep 2026 10:22:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344576;
	cv=pass; b=M3KTLfQ83yp2fTY5K5fj6R7rspRE0H9U3U37HplO5MzCeP1brW3bqKy9RsjAhhz3rdeoYrNxOCiwPjT/8p7/yFxIDKUeh2IkrCxcwnmNffmLph/K1v1kxoLlWyAm6rPRqTsFhjncfTprmXqnSBKNPHn+3GDl54fjE/ERyaUDjB+dUBY69H5WeJtqdTDsm2M05iSdSv49QWeKWPLpSHGegFznwQ1+tEJO2Sq4orHSogGbmsw5pH9GyRe1GXYTMT/jSrggMIZeZzvPxfTaNtZpXRTQHfaso4n9cNXIU5WocuP7hP+trghG68QWCAfuSIiM5xy4UD1jXrgOZtCUduk72A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344576; c=relaxed/relaxed;
	bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f/uJgsrrQ6aamVN/9xUuPdCrtit+Kdu+AqhlWMVRAccshP4rX0g2h0Ll/t3SHVmI2ORpXmY7RaqL9r8lvAX+J2mke1GxojPA/eIpT09SdPvXrIshalIGhSUsc3bJLN9VicxOOOX9vBx1yfxlHqSwRey/0uNZXHyX0XztZzHMx7nHhQUzKOtCcZAsiVJ4xjtBWTMTzpiIMk5e0isJYxl4pNg+x7o0j6KctyXRlEyzFA5Dpy3hJMVw/1bIR54rHvjnNYwhWUoYKFhDIci+ruse6DLUZQuc+FGP/jckxQrQxouuAeaJhz6dSduajmRi3BqNTa4d21zZ8v/EOQmeAcnM8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ovhOqfvL; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ovhOqfvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1q5cblz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQZLYht0AQkBr1wyFS8CXxE8JU6aQLmIaQVIuSwuco2roasmzNSUc5SDApVvcZ7P7sxhSG7Gwlk33kUx3DDnqiYMC+N39B1Ub3A1auKImY8K7yKN1ulNKkPPctLzEY9nBLqLVvL7mB0oqq2xDpveU/7A1QlIQKDQFDfOCb5eknYHSYuNWKdmu5WoYshJyysTMpW0ryJjiiTy3V4v2Zped/6hN7AdZhv0QLoN/GmdCDwEY9UPWF36uBRRye0HLH7QKVi0Hc0p1HRa3rvegrcR4Vcu8Rx/AqPgN6ILoO7AIFGQUru/+wrUuKwjYL8xXIqrYOE6XqGVNTKsiTXBI7sGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
 b=i6rhrn7vMLW66GkH5GcRG9YEEWsQa/MjFUGawSp62kQcI0xAI3I43NmDLoPU+FJpvAhniOErUOW8mZOahKSXnKxRUYXPTj8FmvYOo6xhXWZpoi/Ohc56PCg7XjVjJhZ4NzwEk74narvgtiEU5fLIuzCyhLebqHoI5+7J+QmaKL41LmxWzaAelr1GuIVqg6jUSM+4T15z7TVFPUu46sY4Kp2FV3Ep18IExL8pn2kAmmypF2L3oCeSEqhXc4WxFzzDfzMcsNfiCg/kxoalKRmSvB6dEbev7ox7mSR2al1ZO10uLPCHvkVkvmyiV9BwtmjbUlhBDExf7+c05CY5IfCiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
 b=ovhOqfvLpN0j4vM9/zga+wiYiK/9DJMpv61a7463/rspjjjZ0fhxRG2IEhW02HEgmCd2/P0NuJK5B4DvuYG8eFy5dAw7fWJsPF3R7TCmB1tcIFDykGafU03lLseXh7VpHLTLE6Esou86sw3osIntaq+B9x7cR7BhWUj1oUDvIfI=
Received: from BY3PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:39b::27)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:31 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::41) by BY3PR05CA0052.outlook.office365.com
 (2603:10b6:a03:39b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:30 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:27 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:21 +0800
Subject: [PATCH v8 09/11] ARM: dts: aspeed: anacapa: Add LPDB fuse monitor
 GPIO expander
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-9-69c8eb2a7cda@gmail.com>
References: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
In-Reply-To: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=3698;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=8kEAvGR4wHD+buKRoFqsooBUH7WFB3+NHrtadmWVUT0=;
 b=WB0w8QQWniqUwRCv/utf898ZGrIHJHPN7kbyXUXkvso5VJAzH1f/VWyz4yLtR3ceJcTDiqIcr
 FeifRUqFLtgBqCWvSfVRDednav6RLc5QxjrzAmoVgxjFlMSlzq5u+V0
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c767eef-a742-4249-f2a2-08df08dc18c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GznoEqso1lnsE6YMt2lLysH3/zMSw2MBR5vvX1G6wSley8Qmr3CN+WuSVoWP1j0ItJxmdoT60obK1m/oLOOn0v5BfC0v0gMmj2uxuJ62AW+k/N0TbeVLdqAGDMu7rClaqay0j0JF9llrvtfLZDSnqSVdgVCQVK3gngaFb52XOQOYBySVLU3q07q/6ZBEoX0Uf6yrOsUlMpbeBG9P8A86iKIVzGlKb3JVN73+vXy88kLaNphuTiw6upp3fH9Vo68Q/ZH9dI1XKYD9HxKV3sxE7bgbBtWhaV5K0cztMDHJfvWNnyWSoVYzewV0K30FvvHg135WVQXfktLHTO4tLsXAhELH0mFnfpEMhqmdeJydbWm86hd1UONk3HvrYp28f/IpnMxnGfbHRr/QF/At38/+nhCW92m+3PTVOKKL1YvQ2wwXu3DrDYBqQ6+KlMEQYXuCy0jIaoyFSXEY7Sj7slDOcit64iM0eVd8kC4eon2tntFErHVkljg4NaUfrMto8EH7s1h8DIA/OMUHGDOAzTGHRD9ozK44ueDfJRLgZzSzt4Xs8D+IudTBWVP+AZOi6TFRBEB26VnGpTK97PdC53ichBM/GQ20dngWgKZGIcnckU6ZIT7syH4cL/yrozXgZ8VK7CgBT/rleCowgI+a0ByuRUfkw6OucJidneTMtYyss4++a1yZfCi8tUl+3HZ9zh9+CasPo/xwpE9AxJfMG2rTqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jI/xx4fEVr800gtHCUVfH5a3/tPpRA1FFkWCN4p/dtFSCKm8FkGJTKNqmQ7BBThI+3XP65NvsxFJGEXi+lmdRZNAHrb0/hrChE8zKi0B4eDb8KGQAoY7qdmWlgZ+ltelImwvC0YN0p4WtFy2C94Fpg8SbF1Q3eNiBlnDHPb8lKTTFM9FSYFjrl24siotzQaddbQklMyaw92hdcuFk/5tCr/G2IO1AhccKqYolwf4rIUUSQI/YYRHL3eM0kNxP5Y4tIXJkF25MDXBgSPO/ruhY2BB9q1Q8cZXl8vafQNTO8rvI/ah8zUwdEjYnvOrL+cyJvSVsEYHzszH1kDbbmtf5aoSTOEImE/9EiM8unN1/wh+vQ7jfuIOkesaz1AFZ/b/7VWate6amrP8VbBPYCDl1ubuNYFtuz+d9JQgulG2icPs5nrtRtwqWEXd0E7Xj5A7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:31.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c767eef-a742-4249-f2a2-08df08dc18c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711

From: Rex Fu <rex.fu.amd@gmail.com>

Add PCA9554 GPIO expanders for PDB fuse monitor signals on the
Anacapa DVT board.

The patch adds GPIO expander definitions for both the left and
right PDBs under the i2c8 multiplexer and updates the associated
gpio-line-names to reflect the final signal assignments.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
index 0509bc8bb9cd..2fd7e46daa63 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
@@ -2,6 +2,98 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
 
+// MB - PDB
+&i2c8 {
+	i2c-mux@72 {
+		i2c@0 {
+			gpio@22 {
+				gpio-line-names =
+					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TMP432_U8_ALERT_R_N",
+					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
+					"RPDB_FAN_CT_FAN_FAIL_R_N", "RPDB_VERID_A0",
+					"RPDB_VERID_A1", "RPDB_VERID_A2",
+					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
+					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
+					"RPDB_P12V_MB_VRM_ALERT_R_N",
+					"RPDB_P12V_STBY_VRM_ALERT_R_N",
+					"RPDB_PGD_P3V3_STBY_PWRGD_R",
+					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
+			};
+
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"RPDB_SKU_ID0", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+
+			gpio@38 {
+				compatible = "nxp,pca9554";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"RPDB_P50V_FUSE2_TVS1", "RPDB_P50V_FUSE2_TVS2",
+					"RPDB_P50V_FUSE3_TVS1", "RPDB_P50V_FUSE3_TVS2",
+					"RPDB_P50V_FUSE4_TVS1", "",
+					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+		};
+
+		i2c@1 {
+			gpio@22 {
+				gpio-line-names =
+					"LPDB_FAN_FULL_SPEED_R_N", "LPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"LPDB_I2C_TMP432_U29_ALERT_R_N", "LPDB_GLOBAL_WP",
+					"LPDB_FAN_CT_FAN_FAIL_R_N", "LPDB_VERID_A0",
+					"LPDB_VERID_A1", "LPDB_VERID_A2",
+					"LPDB_ALERT_P50V_HSC0_R_N", "LPDB_ALERT_P50V_HSC1_R_N",
+					"LPDB_ALERT_P50V_HSC5_R_N", "LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
+					"LPDB_EAM0_PRSNT_MOS_N_R", "LPDB_EAM1_PRSNT_MOS_N_R",
+					"LPDB_PWRGD_P50V_HSC5_SYS_R", "BARKLIP_PRSNT_N_R3";
+			};
+
+			gpio@24 {
+				gpio-line-names =
+					"LPDB_P50V_FAN0_R2_PG", "LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG", "LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG", "LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R", "LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R", "LPDB_FAN4_PRSNT_N_R",
+					"LPDB_SKU_ID0", "",
+					"", "",
+					"", "LPDB_PG_P3V3_R";
+			};
+
+			gpio@38 {
+				compatible = "nxp,pca9554";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"LPDB_P50V_FUSE0_TVS1", "LPDB_P50V_FUSE0_TVS2",
+					"LPDB_P50V_FUSE1_TVS1", "LPDB_P50V_FUSE1_TVS2",
+					"LPDB_P50V_FUSE5_TVS1", "",
+					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
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


