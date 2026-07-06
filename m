Return-Path: <linux-aspeed+bounces-4402-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD4CC44500
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 11:59:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv2wP4NdGz2yfS;
	Mon, 06 Jul 2026 21:59:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783332992;
	cv=pass; b=mwNlc4LweSCo5A4ykm8shwm/f+eS1BNo3ciGsadCZq2U5lQhkWHHE2WiVD1YyDqkcKg2ev1800o74aO2SIDz4e/P86v+wHf7qybcE6ozVkM8VK0Y7w7f+UqDoQL1U67iKge0LA773PuV6WEy3pTt6EvEMKnnmy23iepkRErQizqZPuNhjZC/3fBUr1Ftr5S3/EQlV0+kI7rTbW5KDSDRjPC8ppQ8whqhB9lEOIjEIoPjqMObDmEyai7/NIjxlfnO9aAYj8mFYMp1ppHpOn6hB5FcsZx7WEVxNanCt+854UDFYqqJGM4R1K4BSQObhrBd4Tue82ZnaS5YY8zvRB5wyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783332992; c=relaxed/relaxed;
	bh=FdKDrOITyXZatHuIc86ZO3dbgvUa7luxp9gwswHt6rA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPEYjes7/OiLqLTCX37qu34qyrMHPf6PVCWjlj5f4hbLtsrsGYmYYfqXS0J6Tj1P3cMgRDKKVxSt9/1Ca7OFgh5ryLkdvn+jlGZc98Ej+3/E/1PZuJAeeAKV0bWjd3zwP0ELCWd3OIIHpQu0Rha3yOUG5kYNOI1jQzVjQG5GiQDjccBJ+yyUzdRzb3rb0MU07rp7pzYeYyEbwKgR1iATpRrB/hozau/VKBQeNwQ90Fm3rfm8/pJ8U3wJqPi+RAwKehhbYedyaeQE6saM2crtMZjKobqrcuJzFJpYPen7UHQKtZAu9qvbypb1AEpvae8TupvSK94sGW2ibq1jWgQUFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dL3ObMzp; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dL3ObMzp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv0dB0TFdz2xpn;
	Mon, 06 Jul 2026 20:16:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALmsYSx7UdNn5MUcMZ2ovkQaMDEFPT28CUSzd1Wf7mvw5aYhOWrlXxmniN44mjn4PpYyymEV9rZNnHa6mIdsNE5ZIbCcRRGruN0togwIWwDwHEllcY+fsRIcCsP5oSfx9a9PxbNdOOaIJjoFsGi5jIPsAlfWCfJcJtC9dJxG0vYsjl+xpIIRQspYmFhXty/Hl9rAAZnbJranLRcOPAgVZabKVNhElncr3zb4YgIe+p9N84kudLf/FjsFgyZeRDf9slyVQnWdTQmKpuEWa2LjWs0z/E2RTT3Ym6N5ecRkKh2bJXjpiVNCRmppyHZMA3ZCD7SCRO9jykvjCcU8ztrn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdKDrOITyXZatHuIc86ZO3dbgvUa7luxp9gwswHt6rA=;
 b=k47827J2JjV09Ix/Nt4l5Mgz74qsnGdGuKnr/OMWXIEVOLwNfm42G1+V2uMSEnmiqrRXaZYzLUQ9CPnPzo5zgEpbxyg0L8yolt4UcKl2OlH7HMsVLjgCt4qB9YT2VU1s4P3WfCuQNmKqVjhrIQRApLZu3bzTf87fTBFJXtylL5pot1hH1NiY24F3tpRSn0f6v4+zFZGyZbfjtyHnlM1f3DKrrsWDyUdHBXN4eaBCeJ8i5CU9WQpuOE40AJSlvkC/CNJlbVe0lLIwVktLAxwHM5ayG6yRqXfstMaiHjfRhH+yWiO61F+CxqrtAnCGlnoob3HknrlZi4yEhqgjFINHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdKDrOITyXZatHuIc86ZO3dbgvUa7luxp9gwswHt6rA=;
 b=dL3ObMzp/jJSeM5Gm/6FMmadHux5HZuC2rPZNLpODSJhykji+DqJkglIW9EbbQeXopTMnATav9zaWLt4E5d0fPXRVH2SRgoyTOxzpVEdS1mqf1cfWW+ppHf/Dq34CRWk5vNuGYreKbIrNcAS0fbY2YDO8aDTLBYZNiZwERt1jhMUixte/V5d/kwZIe7twyNnjamXZRgiMhr7dakGtHxe89HCgah1WbqjL1gc7CtEMLbWT3Rn+F/zKjTnSGmHnyWy9iibkBJNKhz+d/D0L4QEWvjddBDnjM5nej1uawLl/hLAqiAaM4fm6m9oCfVwn4KIOWrwwPsPBHTaWPk00OLbgA==
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 10:16:04 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::64) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 10:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 10:16:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 03:15:47 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 03:15:44 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <robh@kernel.org>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add NVIDIA VR-NVL BMC
Date: Mon, 6 Jul 2026 19:14:04 +0900
Message-ID: <20260706101526.2556226-2-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706101526.2556226-1-jackyhuang@nvidia.com>
References: <20260706101526.2556226-1-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: f67c13d3-f642-4bb9-26ce-08dedb4795b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|36860700016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0cT+lW8HTAohBILFEEIA/f/+vi0dAV9GWCRnozG41yx/IjOKKlSrx29DzV4rqfE8Ztwea4hS0fODw2NAg7TblqnjZr8LxEfQHPEw8/mUjnsixsQkSZ8WKZb6hk/1wVeTMmGI/3gYt292N6f67lJ/sDvsBEXR7To8D+hjBJad/IYp9o1z+E9e0ef1iKeNC6FQWzWJNOqWmEfN71t9b0/MVQOnwG6yR3mcEm/tirsU31nqsjqJzuJDfzMSedBjPo29zakKDgnAV1Lq5HNlinh6aUGV3iBxeF+ihuSfK2hLGOi16k9jm0muBJ9oF/ezO1qSwYQy37cuqe6N0JcD/ommpVj619wg2FdeTE8q0QP5H3l+PWPmuX+e8wOv8uMXG0fymHR63uPnWPUemrhV/iZ6utJayK7X3wZRmpxyRPqG5Yo4JN/v7FVHyphEXoy9ztQz+ud3O3S7hRFSyolU0DsCXpMBDO4UX7kh+8FYH7sqFyzW1J5oRIhfqhZxOl/DrgmPJocIDxQ71npjsdQHEby33zTfoF/XedsSiSWgpCl0lef4N8+IYMmaQ8fRE184rKVsZFzq8z3mpuO22TnPmQFWcn0vsvXwTrUSWrP22NjdjfVyESkAB6ROSxY+YFMUt9Dwglp8rggFsYzKv0smt7KUHdExtVF2MzVixU+gz/zj+3ex+ImaJk08ZRbKuYH5/xH34g6E5ftz3OxzqfnYDojEfA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pQxZycrc/c7xniShgTCrYx6FYKw99isWresWyKxt9APbo1jgdzbbwJoLvc+TC7GbhO3UN28YhGjnUoObjxI0AFssRSU20lwXFt5MXfx4+mLBQh9172wdKTl1JWEE1g71axrwQxE+LU2417pS9mg4/kuUW2c9GVSj37+XakwGJuW8RA1PHpdJU3gg4wdNYYlP9vPMiGV+uD6J9f5s1CgIqhOIXm+xGQsz/tUlNj7z8tjmFS0Kg9HpV1K18vgn2SmI+HNnWzZptRNuxDdtMkDF2vCn/6pGtlR/bhIERJadyETpIXG3vTawtY9rXwq0NmvhNg3IZaF4jJaup/WKQh75sglkW381WxF9Vdj/xML7P1mSrcab0pyt7N9CA+RHwvJ6M5EEjWFxNXOqsxH3TYCXFU0WkvfZ75kd9V4O+x7GBThmTNPc7CsUMi2oHjt4vyXN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:16:03.2230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67c13d3-f642-4bb9-26ce-08dedb4795b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207

Add NVIDIA's VR-NVL BMC board compatible.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


