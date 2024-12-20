Return-Path: <linux-aspeed+bounces-284-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3392FE77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Dec 2024 04:39:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YDvpK2bqdz2yJ5;
	Fri, 20 Dec 2024 15:39:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::60b" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734669577;
	cv=pass; b=bLgQvqIua0JAvBYzlljD1L4wAAvU62Y0pshv+D9Eu3LKbRKiIAJF7FMTTbogCsMdmuldxLcHkSI+7P2MJ9r/xeS5fTmH82Qsd8b4H0f1CKZTmWfbSlj6PDhJzNAl4AkmsDAOulYq8EIUfPSrfSBCM3K4JPpTLbz1krHPMSuN4/vP/Cqg6V72Dj4N6ZulzloefmIgtiL89ihsxiRKxLErOKzDgbjlsL74H+G1riCzIDcJs9huYXejNGUtF7z2g6ypIttxjNPcmKsouPXD3F4BannKWTYIWBYf5k+rk4J95p7rhCLZOh+hOCdVweGoevSaUMQKrEOQXobK6Gxodki+bw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734669577; c=relaxed/relaxed;
	bh=LWRmS9XZsuuB0IsMvKfsYzU0SaisE7IPei+IdLuyHWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Wmsdjh7VvGNZyZk97GxIp0qDGH8cMtp+zJqk1VcyZUlZtJ5xsrxVDTdXeFFeVjuRLkPmYxc+YFy8mkH4R9E0CzOtNFv/+JiGjH4bspyCZJ68IAldshu+EjURUdXooPLCLXPHMD+RIQJXGDQycIUe4uHuFT2mklxoule/uhhvbbm0+iq52mLy3nd28+3fq6aQHf8o7tJQ8zqZd0uO4Vut0YWsbH4EdFWuk+DUXUJTzQc1hBWZVWIo9sU+Q+G3D7nj0qN4MAXJGryLSASHifAXFHhhoLwmUQrk7dJrQ89JJhPTx1HEmOBSFkB1vpxEDtW5QHzzu+JlbTg2A4ibtskYvg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=Y1Os76Kr; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::60b; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=delphine_cc_chiu@wiwynn.com; receiver=lists.ozlabs.org) smtp.mailfrom=wiwynn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=Y1Os76Kr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wiwynn.com (client-ip=2a01:111:f403:2011::60b; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=delphine_cc_chiu@wiwynn.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::60b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YDvpJ0fb2z2yHL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Dec 2024 15:39:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSI0FMWCFXHLQwh2KLalBCie8f5aXohHbPZut6GS4wMlniw6chRrFBuuZF+dFqNYzOIsPMg5mznjhFgycZFHrgqMk2Rt5zH3+GQ4VLgdM2HvwuKjoLmudMlIfM9wG3ER/yIUt+0BQpA48lgtADZLrKoaYozFrakr7KYvVjBrOYvt71G0PJcc2vPltMKJo2N7Z87HgmlVJcOXtja018pIYmMMGt4OcOQZvx72PlTuLPVyJd7BnGLIJoK4vJZpHZ/8/m+wxg2XqMizTr2biCv7sRSsCTLVBi9WHnSjPI0p4z9eCa9i1hM0+7//1kTYE3FGmDaG6Eijj0d/QVrbXUNnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWRmS9XZsuuB0IsMvKfsYzU0SaisE7IPei+IdLuyHWw=;
 b=m804fONmV0w0NWfw3XZahgTo7kZiRn6k1Qacts3XZr4FZ9XO2GZeNMU0IqB0rr0lDkG2msIpW3vyZE20szrhxvDClxcCGhURTXGKpUNPgjK7zmh6Qw0zrdpe6IuA5k5jN+JCZhtGzqxXH+Yl4RhjWrNTBwGrlh9wVMJ3pPz7OQbkMgyKiroRsxQE0xte30uhxlINHiRmc8lhsX9u9v5+t4X5lER6r29MyGq/7OsEYQVeOGHx5TvPXJyfnf30Tb0bh/5y3/1xgqHaRixL5p752CyUfhkbu8bCJzn7hP3Q3gQG2fp2zBWfbH/FYI2uWQxltyla1X2kFBpdzXoJPhB35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWRmS9XZsuuB0IsMvKfsYzU0SaisE7IPei+IdLuyHWw=;
 b=Y1Os76Kryx9U9kgBuB0ktEogaamKfjmjxWlFA2wAH4AMxFv2ts6ckpzx95Inc9utWHXn+0LMKvPRP+t28d3ybkIVtpx2RdVAKLKg99MzpRrLTzKettX6AGQ3u8JavtrQf2CmY4MhNG4NhB7q4+y/7VJjMVCGG8jzLRA7ezKXvG43xGS9GmNjIu/MiOstWf6rhfZcsHp2rjzKr4gcR2UXJFoB6aSZHzh+ndLTT+5tx1OHPC4ghIdfmklhmYQENmdTwyRtfPu9/TUvHi7NNWbKARsNZHgAcLl+BfpiDxr3A5Va8gbNpD0gDnatfntzgIAbFAg/OV4KWLxF6WMmbz5LGA==
Received: from PS2PR03CA0019.apcprd03.prod.outlook.com (2603:1096:300:5b::31)
 by TYSPR04MB7218.apcprd04.prod.outlook.com (2603:1096:400:470::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 04:39:10 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:5b:cafe::e6) by PS2PR03CA0019.outlook.office365.com
 (2603:1096:300:5b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 04:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 04:39:09
 +0000
From: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>,
	Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add fan led config
Date: Fri, 20 Dec 2024 12:38:51 +0800
Message-Id: <20241220043852.1096074-1-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYSPR04MB7218:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7bb937f-67b4-49b7-8f75-08dd20b03eea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/5NX7jcriBNoL4fNat+IXV8ikIrOqX0ZwScceqoOyICPixqBAF7CvRhlTUM?=
 =?us-ascii?Q?cnaqQWtCWLAUH6+J7U5T6+b2mlOz0tk3K2A8ihsKgg7t3WwuheTvydy0gmub?=
 =?us-ascii?Q?+WWQgemH8iy8tLUzet79zytUaW/fXSqd8mm25Umqsod0kxPsCF1K9jkUkDI4?=
 =?us-ascii?Q?q9A5Ta4bZN2qz/iSBPY8GMwPjXgQ6T9QAHjkgL7mMrn3KaboD4iearp/cvPY?=
 =?us-ascii?Q?JPnR4g/0yESgWcTIlMhhGW3i+x4O3eEm/Va+3gn75E2fsjcB+/ts5tTOJrvV?=
 =?us-ascii?Q?92fHcBesmhAfqGxN3Ln67GvjjvqnZgFI3eKWfD6/kgYOZnV01HobiAxorby6?=
 =?us-ascii?Q?jLYzW+dL3JjalWXZRK5U/KXTR513dbg7YpXD2ejpzDl1PNnxCHYMq9DbxeH5?=
 =?us-ascii?Q?4Dl8dgVpjdlRDLAq79FbHs50ZWRYG2H4QyYPdx7BMxgQrBZYYNC9mcNffsKU?=
 =?us-ascii?Q?LI3/IUk48sLorL40eyhQC6m8n1Tu3OBysP5yEZ6fTXFm3CHXXxNKxw6of8J/?=
 =?us-ascii?Q?mQDEjVfAg9speSQ+K7Ck3OL7PadoV/OhwB6pzAEP+BnDF44+NBIq1qxelzFr?=
 =?us-ascii?Q?IvgG5i9poWIxQPVIByRPwz902kv3er0+maXonE+PBXjrSQ7yt73Up6f2WgyC?=
 =?us-ascii?Q?wo4mdUOmOA9uUJuwPwruaHzB3A99CQ+om5Qn2Cl1W/LrFGrdzmSQNMZz/9m3?=
 =?us-ascii?Q?wvCNm5KN09f+N1AX5NaHEut3Z6tU0xwNcL4W933mDYLlZ6IwVtOOVQgOuDDL?=
 =?us-ascii?Q?FHuFEvMWC9MsXwpQq6DCBhyGpLZMYZP+lSE1Rgcr6qyhdPBRqMQ3vDtxczlq?=
 =?us-ascii?Q?xUbw4P+GrLudkUzQ+Xggpya5B9kydRoBNz+wZBPqotKd8bDg+MUQlAUOBoBE?=
 =?us-ascii?Q?QlJ54EI4Vu6GPJPxV1fTQzoZ/ffk5tj45PRAsQXeN9ddfCiSRP/HCkqc2KWH?=
 =?us-ascii?Q?GKGJWG1QVoyT5vu8lvakfsoJAcSWhyIr/c1rviey/wtUXruGV/i9DfvmOYq2?=
 =?us-ascii?Q?N5sOK0LAhEaNqSidNnEX4sBZWpv/J+PqTIghBtH5+HWKpTYuTgAOJGh95N8F?=
 =?us-ascii?Q?cxkruy02wHaCFWOKIQcRnkWs0jGi35pBKXdmKj63kaX/bwIwIFoePOAeAaVn?=
 =?us-ascii?Q?1T86teK4kkFdWZvucib0Vp6VnoM+yKtAXLwkXWoTbQPmNEa+r30QML2vNVEI?=
 =?us-ascii?Q?ZPUwzvrgn/56ScLTufbNXiEQI1qKUQjjZW6f5qo0T+GrDJBZg+U4/1Om4RGg?=
 =?us-ascii?Q?eddo0x5Vy7mdKXa1JFtEFgYfgbDUbwXIuJWisqE6I9Oc1TQ3FXBsORM/CczW?=
 =?us-ascii?Q?RPhnCk3kMV5isH1q7m3qwVJhXrSjKtopUDWkSl2PwRZOfCNuSbbPxiLi0h1x?=
 =?us-ascii?Q?SsxcZDZjgDsDr9DtccQiTGusy7i2B4ZxTyEgmG9ZAxqhn4hOZQOxC0y8ShMb?=
 =?us-ascii?Q?bgSF6HW5UyjH3C1EVFcSiITBLrgQnxL/7bCkbae5Ai+hZYJosShkjcy0eIG8?=
 =?us-ascii?Q?aPPriUwPJI/hLiU=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 04:39:09.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bb937f-67b4-49b7-8f75-08dd20b03eea
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7218

From: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>

Set fan led config in yosemite4 DTS.

Signed-off-by: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 166 +++++++++++++++++-
 1 file changed, 163 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ab4904cf2c0e..b5865efcc80c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -73,6 +73,160 @@ tpm@0 {
 			spi-max-frequency = <33000000>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_identify {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&identify_gpio 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan0_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan0_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan1_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan1_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan2_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan2_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan3_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan3_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan4_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan4_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan5_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan5_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan6_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan6_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan7_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan7_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan8_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan8_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan9_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio0 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan9_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio0 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan10_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan10_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan11_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&led_gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led_fan11_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&led_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &uart1 {
@@ -995,11 +1149,17 @@ gpio@20 {
 				#gpio-cells = <2>;
 			};
 
-			gpio@21 {
+			identify_gpio: gpio@21 {
 				compatible = "nxp,pca9506";
 				reg = <0x21>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				gpio-line-names = "","","","",
+						  "","","","",
+						  "LED_IDENTIFY",
+						  "","","","","","","",
+						  "","","","","","","","",
+						  "","","","","","","","";
 			};
 
 			gpio@22 {
@@ -1173,7 +1333,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio0: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
@@ -1221,7 +1381,7 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 
-			gpio@61 {
+			led_gpio1: gpio@61 {
 				compatible = "nxp,pca9552";
 				reg = <0x61>;
 				#address-cells = <1>;
-- 
2.25.1


