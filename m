Return-Path: <linux-aspeed+bounces-1233-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514A4C5AD49
	for <linux-aspeed@archiver.kernel.org>; Sun, 25 May 2025 23:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5FJY4pQPz2ySf;
	Mon, 26 May 2025 09:21:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200a::627" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748197265;
	cv=pass; b=GTLBQq1ZlDNPZvNDJD0FkQqQldJotg76C+MGAnW0Cp+srrhdDYJ2bf/c5MZeKLRfDw2nQ3TSAxqlc5rTI0grR3ZOEkVGlhdFH5Z/LNI32xz5PtJktOAbz8Ckxx8cq8g6M+/Yy8/J/9dXH9is45KZtR2uMaVhJW6a/kJ7YmePIRz0RdO+z+tL13e+9r7eGIcKzW/rejVMbIwlADa3ErlH86+bHTgDVBoW+D2y4q7MQNgmiKCvjyRMqA6p7rBHsQJG340J9yi7YMAhWBdtQ5LtB3RSD5ZiZ7aoQ5l2hWkSJ8XBfDHn2MgKoulFe1QncGBculV8W/XdU20FjyLzLN7IUw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748197265; c=relaxed/relaxed;
	bh=dbxKpmdJwA7aefqSwme5tB4qSfJ4xf4Of/4jEdWYzgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ld2IwEfE2sU3xhUbL9OsAJ3seLTTb7Q/nXJ//0y7n402392F/Qt8IFGDvRec7LGotbpHefS8Z5Bf5LdLO8Ad1dZZmIPyBUvBjBXYgIfcDmbxoMW109Wh9vh6Ll0w0fhekydPh1Hrvey9HwJrz1YyObtK+A3fWi2o7AhLRns53jMvxkXjLq6BMVKofOmE7Pm54iy2rdndpeqWOxs+5njfp6IwwmXmrQqPBz1Tk3+sr2QG/sAsxxxq2yIc57FkoWyx7U7Niybg0jEJyFUJYh4g2Tvr8i3iUWFcECmcgsTDs2wmQT/OIEL3Ju3Ae0kK+dYTj8sV/nUkUglJ83GHxAmBxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JVQ8+dwC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200a::627; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=wthai@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JVQ8+dwC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:200a::627; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=wthai@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f403:200a::627])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b56f90kM9z2xlM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 May 2025 04:21:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEPM/COZmmA13Xbd52GapbRYYSzPcPSiwbvKYw8L0MZqIIiu7PWuSoezFsclF3ZvR3ImIfFmB/sHm0LYXMH2bgIxtIRsduWsPBPOP5sywNRsujOdl68lHjA0ViPd+rqI+l3GfXrVUH7DkWkpbPow3Z4C4oDbk64k47z/TFsl9/F71eFVWk6kRs5c3e5ni6ipAlIORYJLaEwdkXsD4rHGHSfH1egvHlpYYkHmHthz00eu+TtmivOKboKGrjAKq2EXxQ6hH3towUdvGplAHHM/S+A2XwOwbodbi1W/agTeqGwxYA0peAJs8ivfaxCYg4xsefegeNmaFkRs+qvpHThC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbxKpmdJwA7aefqSwme5tB4qSfJ4xf4Of/4jEdWYzgg=;
 b=NnAn01PAsYFGVzx+T8yPdgcGzdQZ1SMZwkDbNXU87z5/xiMIUOh3XEBCLiiy5Xv3AqdMQAA0kB0Zj/oxGr6NrT9SRr6O2EP/lEGklVCph5vdIamRUdPoJteAkZyCZ2VFI+BgZdoaFT2s5jEgpvzO25qJxQ9aqq4g3pEew5fjgKfl82dp9v9wgLdtr5sVeH110CS83ce+uTS2Fu7Dusk2ICMtcHrr0NBM0sFIRDiphEHLWyNHgPg9tc8uHgpSwNfXeqepvWUNwGLK5XqQN/B/8hlSRlQX3YenPx7qCxfkbvclz+SYvlwbc9CDFkWoPyeOv7XCiWWidHCaapVv4eCQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbxKpmdJwA7aefqSwme5tB4qSfJ4xf4Of/4jEdWYzgg=;
 b=JVQ8+dwCbMLCtqlaDmqYip4EFHHTKoWUydl4TswTLUYzI912FZ55ZkdWQdncIyIGEhiKI0uc71vQnZv/HaliRbu31KlkZkiMWUFfSOnC36Mp6BuzO+kIfBfKOmDbv1A6sxS2vjMrvlEWkwB6E2rp5+WFE1C0f30cEv6D/SaNLxp+zWdh+FkbGR3fAB2vqwm0Wb8GfDQrjIKUz7Nrmbhg3bVu954xcZKlOfb2vCk979K/huss/iRr3MlL9XLzx2wWQLSokT7fMd+WQXJwHb/paoVJcsPc1FBApk+My0TcPtscTpuib5zptdB0W8qPykC/p2LArFk614cOpgrufOBsRg==
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Sun, 25 May
 2025 18:20:39 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:207:3d:cafe::40) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 18:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.0 via Frontend Transport; Sun, 25 May 2025 18:20:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 11:20:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 11:20:24 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 25 May 2025 11:20:23 -0700
From: Willie Thai <wthai@nvidia.com>
To: <wthai@nvidia.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Deepak
 Kodihalli" <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, Leo Huang
	<leohu@nvidia.com>
Subject: [PATCH 1/3] ARM: dts: aspeed: nvidia: gb200nvl: Add VCC Supply
Date: Sun, 25 May 2025 18:20:17 +0000
Message-ID: <20250525-dts-v1-1-9ac63ad3bf15@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
References: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748196599; l=6264; i=wthai@nvidia.com; s=20250525; h=from:subject:message-id; bh=7KcwrTXE1Ubn8cEgpFOXAkdi95n4Qkwqm2YlpoWQd+E=; b=dFkeLXrOZAbwJzDJ1lH1jTOgv96H/jq/44G3X87ahAP+D5sgkxVqPWVqFhQXL+6T9QNlke+zW hHUdZHkNPSdB8U8KGJqTR6Y5H86GIb/gSKv6QnMsw+lV5Z3Kf8KN4ju
X-Developer-Key: i=wthai@nvidia.com; a=ed25519; pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3baa2d-5a4c-43fb-a182-08dd9bb8da32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2haeUd4aXU5MVhROWpBWnpCNVQvYWMyZ25jdWdBYnlqUTlHOUVwT2VERzJT?=
 =?utf-8?B?b3BRWmtGMkN4RFdSWXVkalNMcHg2ZHdyVHpnaFNkWll5ZkVjRFE2MGl5V0U3?=
 =?utf-8?B?WGlqbkJzUFYyWGFxK296M0EvZUtTdDlVZ0xSZlEvelJrZEZ0V3RjMkxDUE5r?=
 =?utf-8?B?M3JFYzhoN3o2eWdpbWNOek9HZ2dUc0lZak9WVW1vcG41RW9WRnNMZVRoTXU2?=
 =?utf-8?B?RllVSDN5Q2JRU3NyK052SEkrZkJlQThjbWxtbGxxZzF2YjZnSHlzNEcxak91?=
 =?utf-8?B?cTQzVGd5VTErY3R4YTdsUXNFUXgzcnpMU2crd0pKQ1MrRWw0Q1Q1N3QvNnAw?=
 =?utf-8?B?b1hPRUtoQ2JVMG9Lc2ZzU3BtRE5DelJ4VUUzNEFjWDFpU0h4Z2tBMDhSVkdp?=
 =?utf-8?B?bUZJa1M4MFRIMzdqNHdlQXB6NzNJblBqWlM1dHZ4TmRUZkl0RU9oQzVRbjFp?=
 =?utf-8?B?ZVhocE9xM3E4Q0haTVdPZzFoS3FVamRKU2IraTN5dTB5NGpnS0tCQ3JCeVlY?=
 =?utf-8?B?bDZsMURLRnA1WXA2ZzRaNDBaTjRlY1hURWpCUUowS25ueTY5bjhjbGRiTGtq?=
 =?utf-8?B?UzBVdFdaQ090M096cm5ldDJqL0dtVnZWSzg5TEordWJadnZMdEhlTFJDRW5E?=
 =?utf-8?B?NzhJSFdaNWc5amVCQ2lLRTNjQjBOVVlZZmdRNnMxQk8zZGdBQnVIeXNxL1FX?=
 =?utf-8?B?VTZlc29rTFRPS3VRdE9XWnRLc1ZXTlo4U3Z3NWhDT3QxL0xmeXlENzVpMjlo?=
 =?utf-8?B?NEVVekxjVFlHL20xM21EdTVUZ1RUWEpWZ1FYWkZOT1B4WTQ2U05leXJ4VEwx?=
 =?utf-8?B?eHk0THhZMEU0MHBnMGg0dDhyWlhneGpWd1VCZ1F4dTlicXc1MWwyTWhjYkQ4?=
 =?utf-8?B?ZzAxcW81eGdtU0xXSDVRaTNCUjlWVm1MdjZQaXhMK1dpekZpZC96KzN2Q3hy?=
 =?utf-8?B?bVhHOXBZcUV6YlM4SncyOXBNMndtUUxNR2I1L092WGRXOEJ2YUNVYWtFanZj?=
 =?utf-8?B?bHFZMSsvWGFoK3BJOEt3SVpobW1HZ3NMWHFOVFNaUDFkaUZKQ1BhYzR1UDI5?=
 =?utf-8?B?WVJpMGNsNzdSbXUrNmhhUWlLYXBURGdQVmNiRjJkQmU1OXhOaEluRTl0cUl0?=
 =?utf-8?B?dkVva2xRV0lnenc2bXVqWTluUkd2ZnczWFdFWVpmWGlDbWZ1QXJvY1RMaUg3?=
 =?utf-8?B?WHlNS2tubmdWOG4vUWtPNlA1TXNPcVQ5Smp6SHF5S3oxODBGU2lQV1NCWUlY?=
 =?utf-8?B?S3QwZkl2K25JMmgvWXdmbjZ1SmlmODJTanFoMi9UWHpiQUZWZmtMRHhJQjVB?=
 =?utf-8?B?VUdOQ1VCZmJHWWt0aG9mcHNEUWVadUdqaW15dFVXanQzNlVOWDZXdktEcG5I?=
 =?utf-8?B?RFRaWWt6a1EvN2VlaXNWdTJwek94eUNTVHpZUFZGMFRZMzUwSVk3Ni9uaTNt?=
 =?utf-8?B?bDdDMlBQd2kyYUxscWlTK3ZJL0lxbHNiQzRUeXZQMzNqOWdFVkVPTVZqQ1VT?=
 =?utf-8?B?R2tEYlZVTWxreDZQOThlbFJMeVl1TWFDcUlxdDM5b3l6N1paU2RQdURjVEdF?=
 =?utf-8?B?Yk5lNWdyODZFUGdMdVpQZ1RySk83L01IM0xaNWJPZFZWbER1K2RKam1SclBQ?=
 =?utf-8?B?RGlnKzFSeVNhWVZaSjN0R0JXOFVGQXYvTFVWNUNzR0pDcG5TNzNnY3VOamlF?=
 =?utf-8?B?ZWZnSDhjVTNuYmFFU3BETjZaY2ZKMkFTYXhsUTl5SE5SOVpjVnY3d2owZk5p?=
 =?utf-8?B?TGFiTlU0ZnUrbHA0VFRwRFVrS0Z0YWM4bHVFWTVEd1dUVEV3UHQ0YkVDRWdq?=
 =?utf-8?B?U25hOFAvZ3pqMHRBZ1BaWHhSZEp6WDNyN2tjc3c2NVNUNFpjdmJ6OENSbTNT?=
 =?utf-8?B?Tk9nc2s2dEFwQmlQREc1Y3VjZFdMQ3NHUEp2NVVzdnBSc0pNWUk2aTEyMlEy?=
 =?utf-8?B?NkEwN21Lb29vRndPTHVHV2lxbER0YkFEeUdSVERJUmZ6NnRNYWc2bU9EOElT?=
 =?utf-8?B?M3cyaHRST05HcDJkcW9BME1BWnVTalhBZnl0dVVzY1U0VGtZZjRsUnVmM1dC?=
 =?utf-8?Q?UNKgrv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 18:20:39.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3baa2d-5a4c-43fb-a182-08dd9bb8da32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

Add Vcc supply to avoid probing the devices before they have power.

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
 .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index 41e3e9dd85f571254a08d40e68c0d8f8f049256b..0b0abb259ca3a68b43dcfa61df69b8a15421d67c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -126,6 +126,16 @@ button-uid {
 			gpio = <&sgpiom0 154 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	standby_power_regulator: standby-power-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "standby_power";
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-always-on;
+	};
 };
 
 // Enable Primary flash on FMC for bring up activity
@@ -420,6 +430,7 @@ &i2c3 {
 &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
+	vcc-supply = <&standby_power_regulator>;
 
 	// Module 0, Expander @0x21
 	exp4: gpio@21 {
@@ -431,6 +442,7 @@ exp4: gpio@21 {
 		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
 		gpio-line-names =
 			"RTC_MUX_SEL-O",
 			"PCI_MUX_SEL-O",
@@ -457,6 +469,7 @@ &i2c5 {
 	status = "okay";
 	clock-frequency = <400000>;
 	multi-master;
+	vcc-supply = <&standby_power_regulator>;
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
@@ -464,6 +477,7 @@ i2c-mux@71 {
 		#size-cells = <0>;
 		reg = <0x71>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		imux16: i2c@0 {
 			#address-cells = <1>;
@@ -482,6 +496,7 @@ i2c-mux@74 {
 				#size-cells = <0>;
 				reg = <0x74>;
 				i2c-mux-idle-disconnect;
+				vcc-supply = <&standby_power_regulator>;
 
 				i2c17mux0: i2c@0 {
 					#address-cells = <1>;
@@ -528,6 +543,7 @@ i2c-mux@72 {
 		#size-cells = <0>;
 		reg = <0x72>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		imux20: i2c@0 {
 			#address-cells = <1>;
@@ -545,6 +561,7 @@ gpio@21 {
 				reg = <0x21>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				vcc-supply = <&standby_power_regulator>;
 				gpio-line-names =
 					"RST_CX_0_L-O",
 					"RST_CX_1_L-O",
@@ -584,6 +601,7 @@ i2c-mux@73 {
 		#size-cells = <0>;
 		reg = <0x73>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		imux24: i2c@0 {
 			#address-cells = <1>;
@@ -602,6 +620,7 @@ i2c-mux@70 {
 				#size-cells = <0>;
 				reg = <0x70>;
 				i2c-mux-idle-disconnect;
+				vdd-supply = <&standby_power_regulator>;
 
 				i2c25mux0: i2c@0 {
 					#address-cells = <1>;
@@ -648,6 +667,7 @@ i2c-mux@75 {
 		#size-cells = <0>;
 		reg = <0x75>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		imux28: i2c@0 {
 			#address-cells = <1>;
@@ -666,6 +686,7 @@ i2c-mux@74 {
 				#size-cells = <0>;
 				reg = <0x74>;
 				i2c-mux-idle-disconnect;
+				vcc-supply = <&standby_power_regulator>;
 
 				i2c29mux0: i2c@0 {
 					#address-cells = <1>;
@@ -712,6 +733,7 @@ i2c-mux@76 {
 		#size-cells = <0>;
 		reg = <0x76>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		imux32: i2c@0 {
 			#address-cells = <1>;
@@ -729,6 +751,7 @@ gpio@21 {
 				reg = <0x21>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				vcc-supply = <&standby_power_regulator>;
 				gpio-line-names =
 					"SEC_RST_CX_0_L-O",
 					"SEC_RST_CX_1_L-O",
@@ -768,6 +791,7 @@ i2c-mux@77 {
 		#size-cells = <0>;
 		reg = <0x77>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		imux36: i2c@0 {
 			#address-cells = <1>;
@@ -801,6 +825,7 @@ imux39: i2c@3 {
 &i2c6 {
 	status = "okay";
 	clock-frequency = <400000>;
+	vcc-supply = <&standby_power_regulator>;
 
 	pmic@12 {
 		compatible = "ti,lm5066i";
@@ -843,6 +868,7 @@ &i2c8 {
 	status = "okay";
 	clock-frequency = <400000>;
 	multi-master;
+	vcc-supply = <&standby_power_regulator>;
 };
 
 // I2C10
@@ -851,6 +877,7 @@ &i2c8 {
 &i2c9 {
 	status = "okay";
 	clock-frequency = <400000>;
+	vcc-supply = <&standby_power_regulator>;
 
 	// Module 0, Expander @0x20
 	exp0: gpio@20 {
@@ -862,6 +889,7 @@ exp0: gpio@20 {
 		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
 		gpio-line-names =
 			"FPGA_THERM_OVERT_L-I",
 			"FPGA_READY_BMC-I",
@@ -891,6 +919,7 @@ exp1: gpio@21 {
 		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
 		gpio-line-names =
 			"SEC_FPGA_THERM_OVERT_L-I",
 			"SEC_FPGA_READY_BMC-I",
@@ -949,6 +978,7 @@ exp3: gpio@74 {
 		#interrupt-cells = <2>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&standby_power_regulator>;
 		gpio-line-names =
 			"IOB_PRSNT_L",
 			"IOB_DP_HPD",
@@ -1006,6 +1036,7 @@ &i2c14 {
 	status = "okay";
 	clock-frequency = <100000>;
 	multi-master;
+	vcc-supply = <&standby_power_regulator>;
 
 	//E1.S drive slot 0-3
 	i2c-mux@77 {
@@ -1014,6 +1045,7 @@ i2c-mux@77 {
 		#size-cells = <0>;
 		reg = <0x77>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		e1si2c0: i2c@0 {
 			#address-cells = <1>;
@@ -1046,6 +1078,7 @@ &i2c15 {
 	status = "okay";
 	clock-frequency = <100000>;
 	multi-master;
+	vcc-supply = <&standby_power_regulator>;
 
 	//E1.S drive slot 4-7
 	i2c-mux@77 {
@@ -1054,6 +1087,7 @@ i2c-mux@77 {
 		#size-cells = <0>;
 		reg = <0x77>;
 		i2c-mux-idle-disconnect;
+		vdd-supply = <&standby_power_regulator>;
 
 		e1si2c4: i2c@0 {
 			#address-cells = <1>;

-- 
2.25.1


