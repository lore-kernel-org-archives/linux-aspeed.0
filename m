Return-Path: <linux-aspeed+bounces-4581-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099C3C54F52
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 00:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8stk1DZKz2yjq;
	Wed, 29 Jul 2026 10:01:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785229074;
	cv=pass; b=NKKsQQuvuSSzAhiVveqJUjQ7N9BYyGDbw4efRYUpjt71ij81AzZCjIArAcsTY/w61daFDqiq9qp+ZMh7cZH6+mT5Z14Vk5R7j1OBhg7wD1jwU6ruqsbj0TcTAe38AJhCXuHD4YBYysQCLvGQjJWRjR/mGDYdkSvLtb/mqa8/1Fb0TIi2NB8b56XHH4S0Ih5W4jSYkH89BC1/qblvvFlEGw2ue8BjryDotdUrcXlCMzkjMFGMSMDT2vZ0SfvN3sqxL1kYQIZlD7PrQm8Vp8zp7oKVDaPXGh3uB/T44aMrvZp2T8l92im/9nr9abpWUR33b14DcsI64G5lRJOiFkBHJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785229074; c=relaxed/relaxed;
	bh=dDmGPjrXGkz+KZjv2SJWhtAlymfWVB4F9hxa1pGKoiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSQzFVa2zDoNerozcqdU+2GQq0EMmpeFVk/Y/I9D+mdjsu333Blct9P8EArYBSP239CujQlpS6V9xmuzqCearUMr3BLNt6vhfGARhuIV/gfJy+KV/8FaV1kI+7EFA18wEwZG9kGJKDfPrw6cDIOE5H6ShxFwcFI8nvOBMTQAUjdm6h4xsaIxM9deBEXVxxBgYfzqAXEqTKUUxeaPCHHtiY7gy2EiYTMC7NHi2ck1m9qwWs90R1lyzi4ufmDQiPC0OrhSC084AQyXm312+kp4jtEL43vc8c8KE2xEXYl/tv95qhOR6DfHi12wuW/niarHAU2A8tbZXcvwIqcZ3rBScA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TTVdeiO3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TTVdeiO3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8TrK5fz4z2xyk;
	Tue, 28 Jul 2026 18:57:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnJePEESzaDmRBt6mSF0N5aVK3N7iPY2LBcUEqYVwz3MLYJPCXw/tqXk89/l5yEUf5rEBXzLv6nIaXvTF2MgGAg1prpZyOwUjLLQrFFC0qCwqQOm7au7NNgidZn0vTJNAn5i4UbD1ekp9WxKs7Hfim0cToaajuMySmCXUPdcWjbiiA6iR+VGxT7e7hqi5Yg4pd+qS4DKJpRuvP1bzcgENuWEfeVbpL9FyjtyZv45ooptAQC0OvHkl3qfcr1tvOaIKStYERGs9pPBcUWBhfY3s56X4bSFi/8JqpCaT2/DlBxuaCFSihXqNcdmy/2DByqP5mDTpU7zsLAbifdZu5yUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDmGPjrXGkz+KZjv2SJWhtAlymfWVB4F9hxa1pGKoiA=;
 b=wzsis+S61cL+K8Amy0PAPT75TkeeHZYvTEuq7pmFdUecjV538lfBxUMyQqB671jA4yQNDjoGibW6gqnYRscWEw4AEecNc63VnNhUlWhOFOcYTcIY/Bcq4sdZlo7eEzVjju2pnluQQHvxJlfQmg1FXyIW0NJxTQDOcl5VwVT2udPOCPbm22qT14bsUgjrrIDQxwoWXLKSSulfIxoj+VnwGIj6iBJogaAwEkkn+rV81FKJsAvQXb5TEsVWPTE2FobJfEI/abDqiHE5dcTQKNCMSPawOyDCNE24ok7EU5/EuPn6/0WyiFun0G6gt8JgBVpSPqHm0qZREoGaL8AvB7Eyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDmGPjrXGkz+KZjv2SJWhtAlymfWVB4F9hxa1pGKoiA=;
 b=TTVdeiO3eW1ukMvhAZQqd/IGulzhwrwkbhc5K2+kdtHnOHDkTgWrZGvEbBghaRwY3WOdiLFVyxWC4GcqyCR081F2qb/x+o5kCj4uW/STIA6J8P2z1uXtWVpkWy6zuVPafFAt5+q5eIhEb4kXDMZ4vudjysnr4V4ELkcLTZ2deYh5n1Pl5K+Maon0+CeL6Bp2ECom7m70R3D48V8KYkL+IKSEE7Nffc4upOsqfh+m7kM054maDW8Z8r5dQKFu/JbIF/Rre4B2EZdjzRuo1ZJNYEmXt8l/tUHdZsPHOY3p0ZUwWJ/ktXpCT7g/HxNqej1CManUXrh8UOFcSPKdGKXhzA==
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 08:57:29 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::18) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 08:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 08:57:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 01:57:14 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 01:57:12 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <robh@kernel.org>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: Add NVIDIA VR-NVL BMC
Date: Tue, 28 Jul 2026 17:55:09 +0900
Message-ID: <20260728085640.1001890-2-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728085640.1001890-1-jackyhuang@nvidia.com>
References: <20260728085640.1001890-1-jackyhuang@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffc8d9c-262b-47b8-dc65-08deec864085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rU0Vg9qa+C2iCOLu6/VU5FpvALLAdWoezqblXA/TSFr/SnRQHJ10QWFlrT87FzHrb6M09rr9eW3LwS1IwivvIeTeea1D6u3XfI7uxbG2auQ4EeifUM6j++6YMkTzZVv8+36bPkVCO9VJCubsHwWfo/E5z2Tc9uD8So8Y4gQOgHP7eT8WBx4ApueSXSZ7pY/TaV33tXCxJWN6wmHiYep0yV319DLJb714ioqQYzyol3T+jTV13lrW7t+crEpAM70O56ypQewyDDdqQRZkr5L/kmyxuWViLBvZ2+yzzBVf7lrFuUTd1BPAJ9ZqM+LHAe751T8eLBLoolgCH7L1UzCDPVPf/HfARj/nXH7CeUEoUfGNCRfebaCbWYJKAnET87HzuqN4Tn+coPfTKgVg/TPHjiBAvqG0HjncNfkerFj3CiAxwNBBgOmq6xll8pSVf9WAHtq01GQod7J2l5i/A4lunH/e7MEnN6Ga9LgYU4olijyxuHiH6ntrsyVG5OEJkpUmxw0RJn5R6ZyeeTS8Uhg8UeBGljGWybfxNLyNG9l/H5KisYjSMkRKxOXO2YvokWvVn7L3uBNND3XI1PKAuPgNUI/sLN5VaNO0GWFJDFSpBOsvc7y88HT2A7tiymIb2BGw+IvHELevtk+dYkyW3v/50v6u8fxfOfbSnwz5VNSQqV1Idzwy3YlIVQZJxQPnlLKmSBpW78+bG7dkyrO3BJfb3g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	63Bk9UtAXb40fGzKIWIDmBFQrRM+w/ustJ1yf3IMxc/ycX2m7AsK7jhf4ooTzMdOzhJPo5sdjqH1W4jUzOciFPTowjekgbHBUVOkgNy+pnO7oj55t+zUpsS0ZvVDavx+xnp79sqHIwSvepLVI78K60Vl8u+/0CVpvoneLxI8xLBEVFX/ERKIWOCp3Yg6FxdVjbXDazg2GwKeX1tRxchzSTGvvlTt2sdGoQOMBguFxH98hfLXYZamS8AQjm/8SqTrEQ+NyMm9751pzG6imPIUQn3OETm+50F4HvdlQjTHDjDjyBZuetjxemkzw8l5dPvZM1Kt8/jV4AfC0BKE776HjoGmmuHYYWnAUEXA45p3dSkMsK1B0O2Pl29P6HmSP/pMpeqPlkS6w+2xfHYu90IhZRv8aTlDOI1QgSiB+dyU33GoBmznrc86CJdAGWkFlrcT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 08:57:28.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffc8d9c-262b-47b8-dc65-08deec864085
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

Add NVIDIA's VR-NVL BMC board compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..ce893553cfc3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -114,6 +114,7 @@ properties:
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
               - nvidia,msx4-bmc
+              - nvidia,vr-nvl-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc
-- 
2.43.0


