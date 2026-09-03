Return-Path: <linux-aspeed+bounces-4957-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABABC61DD3
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 11:01:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbGqj5Dpqz2y22;
	Thu, 03 Sep 2026 21:01:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788433281;
	cv=pass; b=ieKDW3LDIhHmLbU0ZhV5VTnIC30tWODiXrcKJ5i2uyN9Fk42SBrGvTrblCj/IgkmWgt0QjFTtxsr0D/8HmloEKG/tN5STLi+NfZS8Zd4wDEE0av3HkzEainKhcEYZ/Knbnx5y1KVR4qD7vVHy8MuNOKjkHI+PHpOlElgqaf6a8P6J6OKxAC6NfEZB4SbDYdGE5pSCRJcXBxhslfQmANxEJmC5WV6LBYo9UfFfimi1QNd7PNMOQLXFO2+MLvvVQymLMs97EOHRKpccn8Kd/WCl2j0zAU7BX1jYVIVwB55iiwGovb0toBy+U+1gPHZKtvVSPeQirjehJvRX3Mtn9hpuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788433281; c=relaxed/relaxed;
	bh=atLxWKpy7AY3dwT+7ak/7PYbBxsxzg9EoHpHh512Uzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/GvcUsfS8cjg+E/jaa0ptJ/d1gxrKVSZKYEMQ94IFiBHaRmKnhLk9fpigFmsBdVcxONuGJEtyVPqfUrOIEiH4nmV9a+uLbAtnfm8cxfIbmVrL5gLdEEk9LOfA/QaV7p5vy7/7U2cQtg+ty1vM6jywLTEmQfde8naEvmUfDC6ezjDx4OQrENyihhw1UyQKqmH7paEE5nhudSLnyqS2DtoQl0LmoL8xqdjH3gtgLysJUpx/RxhtHcuxkTNykbp8WVLpXoKIRlQMhUP1edbjUWUICIHPgT0IP3Oa+szhR9FaZes8dheESb0yceU/WvSJtPbrZH7Si/fOqLoTKurgkGug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S6etJKuZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S6etJKuZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbGqg3nz8z2xyl
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 21:01:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNET+FGKILrSsWvDmAJSAh5hZX4bihsj2fIpE1p6woQ2HPbfbmHU5TyIUlA3+nY5TWtNQmQW/37mAC/rWkYAT1vaRp/x7BnOhe8v7cOhwZJktL3I+s/xRq7Va5YqOZILdU4/GpDhdaSSYa6+S7sPPxl6dVWOWfbQG6ArjYfXK+6IGe9c6Cvi99yr33sqCIbD6Eav2vIJYzSOTOaYkus6vC4JsVO7jQJa28vrvFE+MuUCpu5aHoNjYn+UzidlIQkljxMzzKtoocNRGR3X3yio5B9AA7OcaBNq1egH6hbrlC1mWzRQNb/lge7Cra8m1V/xgwCZxTfMKo0Z+XKZNSxxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atLxWKpy7AY3dwT+7ak/7PYbBxsxzg9EoHpHh512Uzo=;
 b=b/bwyzpSx+Oa5TLOoX7FtFucgYmnzuNDEOH0ShXoYDELOwoLH7ConSrIJB+C9cNTsnf+6zpzI8ZqoE14iV5fwS3t3STziJUj4WAUv7xLly6nyKunAgkfQu7o1JA3EugIjHak3gcgfU7PrTOeohSicexdClkKiDUdqGnLpQz5MCFB5oDP0OQPnH8UdyU5TwaCT8VkzJ0hgFXAZmNrmD8gLx0P2Ov6fpsZXeCIVhmFG5BlnK/Y2G1DCmRGbygUKtZV8xSIOtlg33+So/gdRm6ke+LHkiYvSSPT9N58jJlUPdJAapgR+BiHFc8L+hREU186gbmOGM4+ibsC77HJel9zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atLxWKpy7AY3dwT+7ak/7PYbBxsxzg9EoHpHh512Uzo=;
 b=S6etJKuZ4zCz6pSN1K6NfEKk51KXBLi6MTi6GxzaINSMEMAgsfd7YGsd54AC9kew0L55NDBoi92myJwH+EShsRCMZxYd/L0WI8gnV0l6jg2Rl3GRECKl0xK8aEctmqTysrTmm1BRNvj2i6/cY9ZI6k1Om/10GBg6scIIc+00C3xruIWd8xvcdD/pbq1/L3fk8kh4IYKSiHpOKM/2mx/KKnqJ1mJ25ZB0wiD+HL2y4Te6TqbZOpp7m4jFboohNWHlq4MwbXkr9gL7z4I+14XjCM8dGR51+olgtmpxOsZ+qTGpousiMKaQrZVUC18rPpccPzRihrVhCUYNpshn0TvQkA==
Received: from CH2PR11CA0018.namprd11.prod.outlook.com (2603:10b6:610:54::28)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:00:46 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::a5) by CH2PR11CA0018.outlook.office365.com
 (2603:10b6:610:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 11:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 11:00:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:00:22 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:00:20 -0700
From: Ender Hsieh <andhsieh@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>, Ender Hsieh <andhsieh@nvidia.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Marc
 Olberding" <molberding@nvidia.com>
Subject: [PATCH] ARM: dts: aspeed: msx4: describe the I2C5 mux tree
Date: Thu, 3 Sep 2026 19:59:56 +0900
Message-ID: <20260903105956.1709114-1-andhsieh@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: ad057df0-979a-4cb2-b728-08df09aa9ab1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
 1fkpDU1Z+j2//UnLoEhfOGD3n9zKOScEzCF1R7bRsQbA5fTG3R9weIolwB7aah8LxJdrvjcdBqvP82/pUd6DUUIBKQ7GUyjsLfH1eZCcI1n657ivV+ugZmj4tY22RGFUFgmDmpDtUW8u9LPhaycWjz5SczylStnKH8SffucTykRDf6xxYhCS45OUDcaFqkyleBrqczsZB9qNTHsFZFyk9gOfjTRAps1Bipvbi+U97VMnn/dUrCtIFczx+UyGKM6Qy+n8fwE+srPXOG0F3cQXLRqWkW5CPh/6bBm1gyH6+Eq3GgFSzug6/dcJHKlJ7UqcOroqqyWV5HWs8jWkqrm5xlwceHB7vvLMZyyJpEegxPAppN12ZJx9MSyh4YbB+3C8rkSFjVUXIp955324GkgJdaNh/Owtg64uyTUSt0DplBILQDtZhGoPLOKZaRRTw2sp2uO0Q3EenbrJt8BM6RS3t3/8Igztr+8p8ljYeBpbPPRlCQGS0TYyxdo2R/YZLSo5q83l/BvmPVZrofRzNrvmD3cSyAsR1FenL6arwKQcnxLLqkEdxHo/niSiidQA0mq3EKK82tZxp916cP3iyIKC59YDwNjPA7CgIskNvOFTVb1FBXiiGEs0LwaqOuqW+5n4ceMieLlGJwkzyrDZk6av72bTvc7yKUgP6bHhtgMOy8izPLmbDip6aqSnyzbplLYo
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 lVXkMilnQpA7DsPBw/efttOw8botyzoAJ6PRURBq0aa4AhoZDRVKeWQ4sp7E+UecAPTd3yt+9wrlCXPVpilVKzXCDdiQfPmrvvdsxd/H9KoJlg0GM71nzlCWjlFqI/sRNOViA+nrvBtZzPxThZgI60OXCdYV+mKMNmCmXbHiy16wMT7ogLMb5HmtmWEHnHJmYfOaak2CtSe+RelcCbPGUTgIMhKF8kj8xI42RVsKmmkwSBufZT5X/3S3jaKcLCINpbDy85+JLlKQYFP5Wh5bW8/C8B1qUblspA/M1V8t9dLfPkj0sCY4v3CaqtM5tH7NPzCAqaOOvaSw2ecYNC8R6VDV0+AepnOf60WU9mVTN5dfr51MDFsqLM+2p2kHT2X3oHg6nnDbUn0WJuEQ+bio/M92bQpjdDVGEA4Ms2+5JHIKGH1oQI9v3ZGm4UAn9rxA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:00:45.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad057df0-979a-4cb2-b728-08df09aa9ab1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

The MSX4 carries four PCA9548 8-channel muxes on I2C5, and a PCA9546
4-channel mux behind channels 1 and 5 of the mux at 0x70 and channels 3
and 7 of the mux at 0x73. None of that is described here, so the muxes
are created from userspace and their channels are numbered in the order
userspace happens to create them.

That makes a channel's bus number a function of discovery order rather
than of where the channel sits in the topology, so anything that wants
to identify a device by its position has nothing stable to key on.

Describe the tree and give every channel an alias so the numbering comes
from the description instead. The aliases reproduce the numbers the
current userspace instantiation produces, so existing configuration
keeps working.

The four PCA9546 all answer at 0x72, and two of them sit behind
different PCA9548 on the same parent bus, so both can be exposed at once
if their parents are left selected. i2c-mux-idle-disconnect prevents
that.

Describe the reset line as well, so a mux that is powered but not
responding can be recovered by the driver rather than by hand. The
driver takes the line exclusively, so it is described on the mux that is
probed first.

Booted on an MSX4 from both a warm reboot and a cold power cycle. All
eight muxes register, the channels come up as i2c-16 through i2c-63
exactly as the aliases name them, and the eight FRU EEPROMs behind the
second level read as before.

Cc: Marc Olberding <molberding@nvidia.com>
Signed-off-by: Ender Hsieh <andhsieh@nvidia.com>
---
 .../dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 407 ++++++++++++++++++
 1 file changed, 407 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
index 29f56176e2ca..a9a491a87312 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -15,6 +15,55 @@ aliases {
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+
+		i2c16 = &i2c5mux0chn0;
+		i2c17 = &i2c5mux0chn1;
+		i2c18 = &i2c5mux0chn2;
+		i2c19 = &i2c5mux0chn3;
+		i2c20 = &i2c5mux0chn4;
+		i2c21 = &i2c5mux0chn5;
+		i2c22 = &i2c5mux0chn6;
+		i2c23 = &i2c5mux0chn7;
+		i2c24 = &i2c5mux1chn0;
+		i2c25 = &i2c5mux1chn1;
+		i2c26 = &i2c5mux1chn2;
+		i2c27 = &i2c5mux1chn3;
+		i2c28 = &i2c5mux1chn4;
+		i2c29 = &i2c5mux1chn5;
+		i2c30 = &i2c5mux1chn6;
+		i2c31 = &i2c5mux1chn7;
+		i2c32 = &i2c5mux2chn0;
+		i2c33 = &i2c5mux2chn1;
+		i2c34 = &i2c5mux2chn2;
+		i2c35 = &i2c5mux2chn3;
+		i2c36 = &i2c5mux2chn4;
+		i2c37 = &i2c5mux2chn5;
+		i2c38 = &i2c5mux2chn6;
+		i2c39 = &i2c5mux2chn7;
+		i2c40 = &i2c5mux3chn0;
+		i2c41 = &i2c5mux3chn1;
+		i2c42 = &i2c5mux3chn2;
+		i2c43 = &i2c5mux3chn3;
+		i2c44 = &i2c5mux3chn4;
+		i2c45 = &i2c5mux3chn5;
+		i2c46 = &i2c5mux3chn6;
+		i2c47 = &i2c5mux3chn7;
+		i2c48 = &i2c17mux0chn0;
+		i2c49 = &i2c17mux0chn1;
+		i2c50 = &i2c17mux0chn2;
+		i2c51 = &i2c17mux0chn3;
+		i2c52 = &i2c21mux0chn0;
+		i2c53 = &i2c21mux0chn1;
+		i2c54 = &i2c21mux0chn2;
+		i2c55 = &i2c21mux0chn3;
+		i2c56 = &i2c35mux0chn0;
+		i2c57 = &i2c35mux0chn1;
+		i2c58 = &i2c35mux0chn2;
+		i2c59 = &i2c35mux0chn3;
+		i2c60 = &i2c39mux0chn0;
+		i2c61 = &i2c39mux0chn1;
+		i2c62 = &i2c39mux0chn2;
+		i2c63 = &i2c39mux0chn3;
 	};
 
 	chosen {
@@ -151,6 +200,364 @@ eeprom@51 {
 
 &i2c5 {
 	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		/*
+		 * The reset is described on this mux alone. The driver claims
+		 * the line exclusively, and this node is probed before the
+		 * others on the bus.
+		 */
+		reset-gpios = <&gpio0 ASPEED_GPIO(S, 2) GPIO_ACTIVE_LOW>;
+
+		i2c5mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c17mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c17mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c17mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c17mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		i2c5mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c5mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c21mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c21mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c21mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c21mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		i2c5mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux1chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux1chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c5mux1chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux1chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c5mux1chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux1chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c5mux1chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux1chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9548";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux2chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux2chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c5mux2chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux2chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c35mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c35mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c35mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c35mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		i2c5mux2chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux2chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c5mux2chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux2chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c39mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c39mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c39mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c39mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9548";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux3chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux3chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c5mux3chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux3chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c5mux3chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux3chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c5mux3chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux3chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
 };
 
 &i2c6 {
-- 
2.34.1


