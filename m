Return-Path: <linux-aspeed+bounces-715-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C95C021A4
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 22:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yv8Jv5WYKz301x;
	Fri, 14 Feb 2025 09:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2011::604" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739437039;
	cv=pass; b=E4yk7QdPFa5PvEx0dJbIlWEFIYWwgFKqyi8Q3zAz/OoEZyNsVYBVT+NR43dz4gZjYE8/X3T+ZBCUlxpo2Vo0Amr/G/vK2W7V+xwjK9HAjZdDf8d3anERcTj4MNUlKr4DUigiLgym4QERQkBJcq4aKTKGqDgckOfAgRhcjEiqmHBvJsAt7RGda2F61WdB1LxEVcJSUesBeBJWV0XT/LdHZKCN95H7XzoXT9LTsDBSswEBwH7m7tUa2vYgvfFDAEizuZ/Zn2AKpYfEq5Qw0U6qf7xfYhmScPuLPy67gJbsZlgY39qH51vDgtx5C8to2uvzpO5sqRKB9KCW0gufLOu51A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739437039; c=relaxed/relaxed;
	bh=lXQARnpP0YCLfn4tDpCb+/GIcWyJ1PPNj3JHvui+rUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zb0JohtMHObKlXISMHfe5w2n5JL94PpUHV6JWGjTtBh2JGnUic4GfB3GEU3DM9a8xo1K3BpKaspmN+BGWRxZ2NsCoDTWWNf6iupVW/Nk4q/81oy/mhsJ3uoXaSRAwufcYBWn6hM7aKJs1dsMp3lGGEzssCHXVICKuveA/tZ0SXXqDnEwAIQbErUyq0mzyyUtqwT0HGpNXyf5B3IgCxNoM/+9DMWOx5Tg3pgs1MRb2o697IASoxtKX1D3iqWnlyYcu7IMNbyZPolmCWyrPi53Dnsmr1B2rD+/M3W+ssOd/m1yZqdVfQBE3JJeWoonMxTCPB1D4lkWW/bVohN96fG2Mw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=eqRwGP+2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2011::604; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org) smtp.mailfrom=wiwynn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.a=rsa-sha256 header.s=selector2 header.b=eqRwGP+2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wiwynn.com (client-ip=2a01:111:f403:2011::604; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=marshall_zhan@wiwynn.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20604.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::604])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtpwG6pv4z2yK7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 19:57:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqxYbjkTIIIxIt8eibSopQoUC3izEZYZQiPnWpow3GFMy5Nfxts3L4XYsdViVgBjZyVqpAX5TeFOnT8M5zylMwdtMrfR7whkuZNvSNORLMVYga2YAlT0yaBhAYfZ55yHxI4SnmlMucsJCH6mlS9uWU+xcKezN6zpHZKiqAIqH4OQy8Me0q8MnR3aE4GIwj9wcwaalpprESMZdyZpPvo+QAimuxS6lD5rF0zxP0EBIk8yklUrNLdUjGyF0QEW+zG3ZsCrngFRgvp333d7s/fgyrXp+4X9P19IJ7PEYgFu3uA4wG9E3uzbYWHzOMf5xj47qsb4bC1V/kxBtcyiiqihOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXQARnpP0YCLfn4tDpCb+/GIcWyJ1PPNj3JHvui+rUI=;
 b=CDlhaFWjXPCwrVVwmEx4W5RNWDESPZh8MF4i8+MN+IWHDAUOi7p57mMXAWLQZbjdFUjylJTZ15JeGjt7fiW5m0nCY/Ix2T9qCltV3DCOb9dc8Pmp9irlbjFUGDTSv8k3PJexPdVBubdR7KpJgEUGwluBWOkfa0iaLtdNQZGDbKcmjTqnqfhhGB19NXiDAerlgSC6QlL8nAJ3zL4M4Ugb3MXqBXRD2kmgccl8OT+tPsqCbfPaYg6iKfYpLeKqu4X0OvTSFwJKjGDtVsf61olicNdTSiO5UQTyb3SZA8JZuZW3qsbfsiMqsxlv5B6FAn0wYdUpqpacuehT1+sjC96Y3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXQARnpP0YCLfn4tDpCb+/GIcWyJ1PPNj3JHvui+rUI=;
 b=eqRwGP+2zm9OVTB49C7KIpP2etlJ8xdImuXGN/xKX6NOqPQVRVlAX0AcQPRLg9S9gkZHZ5h5iONAENHw5266zp0qUak+/h8C/8x8spmq+yBtzQW/CqiNllJH/C8dzsdhR0+q/4VgY8DJRToUtXxlYYnPMpQioAMl2OOnhpHGe7jNIJ+6Yf0CiGbtWr27RXhuLy99Lhl9SpaFsEDQGMKFtZdTx2kg9Th1XRt9hg5KUwK3GrIGBF7HqCfyKGmP0JuXpF6xGmr6fXT0V+xIu7MuCmCnC+5MGeVIf+4+P/I5BRtYIfJllaJrfXqbiZCabQfvYLiKo5GbtLRfETybeuRb7g==
Received: from PS2PR02CA0096.apcprd02.prod.outlook.com (2603:1096:300:5c::36)
 by TY0PR04MB6206.apcprd04.prod.outlook.com (2603:1096:400:32c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 08:56:55 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::f8) by PS2PR02CA0096.outlook.office365.com
 (2603:1096:300:5c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 08:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 08:56:54
 +0000
From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH dev 6.6 v2] ARM: dts: aspeed: yosemite4: add I3C config in DTS
Date: Thu, 13 Feb 2025 16:56:51 +0800
Message-Id: <20250213085651.1483494-1-marshall_zhan@wiwynn.com>
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
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TY0PR04MB6206:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e89bc578-27b8-4f1f-98db-08dd4c0c5daf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHWz4yZakLe0TDf2mziNDbgua7Ac8AaxXj839vtbAgaexxB/yn5jLBX9UhDF?=
 =?us-ascii?Q?lV05iFp+bG1Xt9fs81rKA431xDpYlc5PKeDWgHIJCroaRASZlKN7YznE3gY/?=
 =?us-ascii?Q?CnnxmamWjCthzLhsld6gjnLzdro5VQO/JpjFcU1tTFvQUmBumyTRlr+9oirk?=
 =?us-ascii?Q?dRbYAFh0+ECMLHrLA1i3lT/hLGAkZt87S6rw7vVPowgop0T4L0dgXgIMjL1g?=
 =?us-ascii?Q?JQSTBSFBfX1VkwoICMwmYIPa26KIYJvG5aM7OxgiOX/aCZqX2ohpYmVQ5/fI?=
 =?us-ascii?Q?2Z+0Z4diQndmxcjcQ9CF9n3d+DtAlHb0swL8PqC2wrVX71EcoqYaWcZX/mp7?=
 =?us-ascii?Q?YTYn0tB+VfYgiWBlvPhYMAUcyBEY46DKYR+2JlBUaPS163ZMcNFiTzE835R5?=
 =?us-ascii?Q?NiLFn1j8QrIxJgc8XvjRnpDbyEQxWKtJync6PwHV6gm/foK/Uy8uJ77d6A3m?=
 =?us-ascii?Q?br+kKdPwlu0jYnJy0oaRdstBriRfx3gj2EvQPHrsiXNGBZ6JL5b9X2zqGeuS?=
 =?us-ascii?Q?3rMdarvqnlwB3xoWQ4FcY2aa7oLULh64hvSZUWD/BUk5Xqv8ASMOtgD3+XJi?=
 =?us-ascii?Q?Q5RPsKXCvP3XNQbLv4leMp+f0BkceCN9YXg3e0QDa3h9JHJYujLbEOTpTopO?=
 =?us-ascii?Q?64aX+huQp2YZAXbPzVMciZ7svctGYTddipAX6toSbuItY1bz7XcHQyrpejTu?=
 =?us-ascii?Q?XCeUgksLBw7XRSCLI4MvIeitmX4bk/jEmC0r74okzmLR3K8lnKQ0YFQOt0Fj?=
 =?us-ascii?Q?20Li8TKu6O15MgUWdcFtnK6iC8Xnxi9+J3XqbjU/6WBcq31e/iKJvtLAKlP3?=
 =?us-ascii?Q?MGGtqtUxf1uLk4ywb150HWiRb93ziQafihQP6sbwcbxJ+RfsJUuRzJ4gDCBb?=
 =?us-ascii?Q?ZG8mxvrNlbLa6E1f2CVOfcRamJB+7gbBUxrWCAP8JcVX8yZs9uIHa0iOV3rw?=
 =?us-ascii?Q?Bm81roVvzRAYbNPk7aNEudyppLJnfE+hK181SbhljXPRivCnUBt07Db8ZUe3?=
 =?us-ascii?Q?OLA5tEeoyWzusff4p7e0GAYT3lW0UHhYOvCCaMtjRTkASAafuTQI6XFyd2wt?=
 =?us-ascii?Q?7JmLH/ezpsHJkeMFMJZcKN9vfsDzX9l9tqemRSYhgcw5GJbcSthHLJhbwZGd?=
 =?us-ascii?Q?rrZAdVTOaXZLdwFQrb9StPqoneMvRoPBi5LFvTULhDq4unR4n//a+0Lr4Q1R?=
 =?us-ascii?Q?/yhiX2t5Cri1dO1aogpvGBeXVA+hB3dtYRSzAUhuT690cppFmy9H/k6HG2EJ?=
 =?us-ascii?Q?uDmYgNZ9dytLgfmYY7aQaJOdPe6JxyJmUNtYw+RmbUz319Cvpf0NGV8/LHML?=
 =?us-ascii?Q?zCbhpw3cSQ6/JLihwGyAj9tzN+8WyZ7+16qCmNGQr7SfdW8Z4AhrogOaikpO?=
 =?us-ascii?Q?NPUf+n3XzREaih4Dt0DCaVcKZJDrRkHob2D9zkV6WXNkzF/7ja6GoeppYMtf?=
 =?us-ascii?Q?appaalk/2jNTstSYAX74QCsGNUSssZjxUqAkABX2S/RmHlANBqAmmdZtjwg7?=
 =?us-ascii?Q?PnTW6oumG1cYI5k=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:56:54.7992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89bc578-27b8-4f1f-98db-08dd4c0c5daf
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6206

Set I3C config in yosemite4 DTS.

Test plan:
Tested pass with aspeed I3C patches and I3C hub driver.

Signed-off-by: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ab4904cf2c0e..3e67393d5291 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1317,6 +1317,92 @@ eeprom@50 {
        };
 };

+&i3c0 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_i3c1_default>;
+       i3c-pp-scl-hi-period-ns =3D <62>;
+       i3c-pp-scl-lo-period-ns =3D <63>;
+       i3c-od-scl-hi-period-ns =3D <380>;
+       i3c-od-scl-lo-period-ns =3D <620>;
+       sda-tx-hold-ns =3D <10>;
+
+       mctp-controller;
+       hub@0x70 {
+               reg =3D <0x70 0x3c0 0x00700000>;
+               cp0-ldo-en =3D "enabled";
+               cp1-ldo-en =3D "enabled";
+               cp0-ldo-volt =3D "1.2V";
+               cp1-ldo-volt =3D "1.2V";
+               tp0145-ldo-en =3D "enabled";
+               tp2367-ldo-en =3D "enabled";
+               tp0145-ldo-volt =3D "1.2V";
+               tp2367-ldo-volt =3D "1.2V";
+               tp0145-pullup =3D "2k";
+               tp2367-pullup =3D "2k";
+
+               target-port@0 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@1 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@2 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@3 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+       };
+};
+
+&i3c1 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_i3c2_default>;
+       i3c-pp-scl-hi-period-ns =3D <62>;
+       i3c-pp-scl-lo-period-ns =3D <63>;
+       i3c-od-scl-hi-period-ns =3D <380>;
+       i3c-od-scl-lo-period-ns =3D <620>;
+       sda-tx-hold-ns =3D <10>;
+
+       mctp-controller;
+       hub@0x70 {
+               reg =3D <0x70 0x3c0 0x00700000>;
+               cp0-ldo-en =3D "enabled";
+               cp1-ldo-en =3D "enabled";
+               cp0-ldo-volt =3D "1.2V";
+               cp1-ldo-volt =3D "1.2V";
+               tp0145-ldo-en =3D "enabled";
+               tp2367-ldo-en =3D "enabled";
+               tp0145-ldo-volt =3D "1.2V";
+               tp2367-ldo-volt =3D "1.2V";
+               tp0145-pullup =3D "2k";
+               tp2367-pullup =3D "2k";
+
+               target-port@0 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@1 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@2 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@3 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+       };
+};
+
 &adc0 {
        status =3D "okay";
        pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
--
2.25.1

WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.

