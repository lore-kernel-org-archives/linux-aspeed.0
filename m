Return-Path: <linux-aspeed+bounces-4401-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE2EC43458
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 11:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv2wK360Hz3bby;
	Mon, 06 Jul 2026 21:59:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783332992;
	cv=pass; b=bIvx9e6ct6Ns5TKNM2KyOqouSQZD6OlDsjEEz0PHhCTKrny/rwv7bxBSSS7RxhP/hdnWRlosUlk0AaiJ2lLHtb8QR7TpcvKkOsoiZxAgXIJ1M2zDLaAd/H5qJGTKiwK1yAkWOUJiMKOxxvT4OHtQXjGQ0ZdnPTng2x/IZ3RCGlzHXt5r2SqIOYchzIyfAJLksUs4BFHluW+X5QkvAOvLFjs3lRrUxQvMaF8ZFWCAyTI2iP2tUyKvcVjFhM+P5vCfXEw+pAP3yskrnu/ck0wv3qs/35YKyFcAHBYtJzoeJSYMYXuI6jb6o9hJDTXAA/sHX9+LPW2Ok7hJHZIddmHETw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783332992; c=relaxed/relaxed;
	bh=M9dShIDrXz9ZEgKE4IWIb9zNx/vklBUxBTh3qSFCQdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3VXdrzLlVS8Q2WwQJYtqIJEFSkQKM6Y+1e1sXQlFHnprEFNJtMoW5hGBn1cQiLGD1vy6q9JDkE1qcAdSt6F5ekykodFiOLfx9p53Gl05w6vRGI+LMJH76uLJx53vCavsllzi/434L1iuzOZNBo0zY3+WpANCxC0TKK1zoFCVIqLL2agLbLZGeoPjI1SFsH06p7byrlUtbbGacGeSaV5E7T2ZlsHclbOdi9u6v/KGDboMM9lUngKrvlwUykJUwX7VbAmMle7FeTlkH5n1zyr0lC3tJojUrXh7pIxdWrJLN5tK0nkRQP6PQHxztBdHdBP0hdqtm+URp3jWOBB+bT0hQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sd/U57b2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sd/U57b2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv0dB0bM3z2yVZ;
	Mon, 06 Jul 2026 20:16:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7jKFIG7MY+kkbnHXrwsCpNQ1SjhsnqRi7VihdO1quC/I+DCVNdudHc3b5QPzdFzrrkLneqV/X199knmHaXHT1HJJd8AuiEuTUpissF8aeGYee7LeBdjpvfnv45aJ1Qx67Z5BCbTrzmFRIjqjwuzCz1nk/s5N//IKVJIYTXXgFwDRnElXM7ivxUT9O0AXm/S7z1i/V8mEWBXmcGTvdMzXwFb4CcBrr2FpmWdmZ+uWfz0M06nTK4aWSUjUJKVvs2oFRX//lB/QzhrTIHdJjpjFavMPUNSW+G4VipB4rDiUCY4r/Xk6gv03xGWUOZqOrsRGbjWZW4p7ZF5fQAw4oBmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9dShIDrXz9ZEgKE4IWIb9zNx/vklBUxBTh3qSFCQdI=;
 b=ALYUxAjvMW5cfblKlYrKSV8jkrg6F35UgoljqaqMA8sJswBuxQTIvvEhZY+ktTmoLaeYd62O2Ix6uend47Xn6iUVQIiHlWt2NToIeWkupYlMRTsXTmxOj1dCCHh7rxxUIbdFhSR6pcb0Llh1dkw1c7FabdHaN8vEOYpUPrmsiyYWvzEH2OLzoPIfxvxSSBt0gpkQ1CqEJunE2NpVqBmeLgwjoJLcoPTXVo+jnmpONcoUn8qpjK36y9yNf/6l9LeSr15HzamEx7utpwngCYW3WQroIpxwpgOg//GPF9uN15V0pqj/WsZbRTuUjwKKs9/QCn9qa02enjQWcN+3fLD+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9dShIDrXz9ZEgKE4IWIb9zNx/vklBUxBTh3qSFCQdI=;
 b=sd/U57b2ZTXvlLIOm8KCLhySvF1RdT6UT14x1pRolFDjyD4sSxQgB5GAjAPrkMvYwcxKAuoQcrgHd8qPZ6yJPixPUlhVKrb5QP+rBfpfbHdYLlilEWckQVQyVK3SIFyhTY5ltNcxkSCb9JYp04vmMnWGzOzuuGwzq/j35+4efjowt7XfYlNT0yXja9KVb2X/YRUQuyQTBSRB58DsfWHOvso42Zl4A0GgFzGi983Uk61RtX5UZOibHu80LBvZ58nbVFq6kHkZmdT6pL6jvTZ1W6REeI2MXzF+Rklg3HQzsHqB1GBkYG8hzScUQn8nCbZzkm+jzyhinTdFMiR63Lz7pw==
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 10:15:58 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::1f) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon, 6
 Jul 2026 10:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 10:15:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 03:15:45 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 03:15:41 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <robh@kernel.org>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: [PATCH v2 0/2] Add device tree for NVIDIA VR-NVL BMC
Date: Mon, 6 Jul 2026 19:14:03 +0900
Message-ID: <20260706101526.2556226-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 848875bc-ca22-47fc-6aa2-08dedb479256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	E6F7CKJ9cBKwymqcvFVnjs5NqdGccSHdynwyX+eRDuBGfnzUzM8WQwMyvMk6uxaw+hHLbw8wVEmmLjCsfwgbzFiF4HHBouppfOdqNV42co9lKkiUarX0lYtdlJiBADZhjB6o8YTRDq5BIR64RoPT49QrJQW5urmLT6jDHDcA0XKOK4odgQLKS7XdRjRcgxuVpxKA36W7lh/Z6Fb6dRcDO+Rjm4LPoVbYGCdFhQ5G6gU6cVBKO0748lwL9I/qj18bIqZ98OGJK6AnHXnun5nXmUExm93GWZx8nkiHh/wMI8uurLd/j6w7Z85FYzHTLL4lF2cI5ikb2ZnloV8CyrtXPy/jEyMHfhcy8HiFIdY63ie+rDSj/ubWyltwXdxJ1DLnA2t1dOyqv84QcDcZpPOZ+UvkKFJtx66B+JwU6zrY01qdzlLMutrxYNMYKQ4xeBOowlnnbPmXFTJcgf5Zh2qj2dPhlJPaWyZc/RW2nxeIuQUgbjYTfcgMj/YyYhTjIX6DbuXfdOl93MFr/vsJbpckrlDWeJ0wZipM8/99yXL0nv3k3Ht13Ta6KPVgT1IsHPjiDP1lH1IvULq6HwBzvqhx5rgPKzmiu3CLcfd86WZN0jKwioLim0BVGwfv7b6paU173LEfcEbjmA6HRIGdOHMhpGRom0wE3yUg8CFeg03NOmGJKRBGaQsnP3UjZ/ha3u5t9O7UZUMp1nMmdM6RPiuYdw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(13003099007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tc/O1yH35cHZpbJRx+obPpnUTsewcbe6LbGho55dPXsK6QyDnf3rpN7Bo354ssn49gR2cStObX0lYvNVvJI2S//Dg/pWTwWg5eGuXUoazsrq/i6OZYINwMG3HE2mxdnf9iMKMjDEM5JBaEamd+hlW/hQ3BTwxGyCSHBQqcUwY7bl+xAMktWPsmz/MMNzXmR3vh0wS77nDVA2k/3EKewwzeOXSyQ64tmHH1EhN/cYbp8QyHI/uC2RFPhqXpgHtTGqRwZV9iD6m+IHyJYxK0Y715djC/7TG4Y2y6B2AGI0IK8FxIVyR6Oage+9+tz4ND26+UnJGeqtbIjUzlTPCyOCgPiHci/ze1NQijpq5jasrsM9VS19B07KgCB+juskzanHU+wuQ6Xpssz9XDAjf8unDouGF0QcBZBvmlCAc9xLEAFzFnsGYDFhyGv2bgc+VqpM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:15:57.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848875bc-ca22-47fc-6aa2-08dedb479256
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

This series adds the DT binding compatible and the device tree for
the NVIDIA VR-NVL BMC, an Aspeed AST2600-based BMC for the Vera
Rubin NVL compute platform.

Changes in v2:
- dts: correct the compatible of the PDB I/O expander at 0x75 from
  nxp,pca9555 to nxp,pca9539 to match the actual part.
- Pick up Acked-by from Krzysztof Kozlowski on the binding.
- Pick up Reviewed-by from Andrew Lunn on the &mac0 and &mdio0 nodes.

v1: https://lore.kernel.org/all/20260702165524.2168091-1-jackyhuang@nvidia.com/

Jacky Huang (2):
  dt-bindings: arm: aspeed: Add NVIDIA VR-NVL BMC
  ARM: dts: aspeed: Add NVIDIA VR-NVL BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts   | 901 ++++++++++++++++++
 3 files changed, 903 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts

-- 
2.43.0


