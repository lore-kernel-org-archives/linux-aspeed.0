Return-Path: <linux-aspeed+bounces-4336-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B07C43602
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Jul 2026 23:38:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grtc72xC9z2xLq;
	Fri, 03 Jul 2026 09:38:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783011407;
	cv=pass; b=CTJ9E2STJW37v8rdVpTI+L57YESf+x6i9PQ4LEp5FUdGzaILqOIx7mh7TwarlvsacAP+xGlhBrSOkZoSUObYTZZHxT7/AsjJ73dJA1o6+ROj5MpWrlTrwSMFCKeb79vFVH9LDdugn1z3owfqGDoTSaJZiHOrzCj6tP4NyrLH/SO7NuGGaVvmzyA+hvYEn7DY/klw26oGw1Y4U9/ELoy/+bW0vB4Ry6tOhfsF303Uhau2Q1ae1zpjD9z/CN8E5vkJcKpL6eE0nVxCvdcc+hI/pm5DtkuyO8/IuhwtL14cp+Wqr25ACFsR1NQoUhAelVrDmx7iq/X1WwvsIabQkXGZtA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783011407; c=relaxed/relaxed;
	bh=moeswr1uLUprQD/Ko7eiYcwpJy8/RSTh1wI38gpHwpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kF25sgaooverjko7hRTgolTl7+VzBwrt6GfoSRE3YVoUtz7ihNJtEFGRLzcPYuy3qAGnZ3ijaUNNefNggB7HGQyaGJj8H+qeQEJjQ8Wez9tRrUQ/0mwtpaFba5t/x5xAvjBpBwiOy15jyIknrITJucWI5zlm/TElpIk+QsFeBCDq+i2R6SHn+LF8783RJj8AuGAep4r8fPkSEHRR/k79gqaGxkKibKa5MfrRKZfufdGB0PV0ef8BOB0ad/UEi0SnswQ52e4GpinZj+gb2ceSdc/hXf9JwHksSL2Xncfgn4oPC8ZkL11UpYOSRC61lBJ2/QRoYgI3BYhYLj7hNfgg+w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rUytVQ2w; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rUytVQ2w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grjhv0N08z2xLq
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 02:56:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCo1+ByiE4+SfH+E709uR6u3A+DPCkDTqNNQEhH+WBN8FYhM39vMK2vr926ndrP9QGvh7X91IR8ZgSyi20jNKDVuLJEvgOU+ZS2AIDsxNpLL79OFgcpkYVIxeii/dkbVlA41IeeuQs4uoaqJHGUjnnJVLIXQipQASMMBKhdPVIvL0BtR6iwz6mniLeHr9MC01rmNe9dpvmPNzOMQ3bDWE8cUG1/vgUdJbDuswpV6iJCVRuGNTtSXOfvrwXl0ZgQxEapyHBUz6fAx3BPtbeK/iSLdM0N8cDNQb8+vX9TaNITrvST25vSqmUnDnNbZQdomSZVpEQLBmOM0CisL8fLXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moeswr1uLUprQD/Ko7eiYcwpJy8/RSTh1wI38gpHwpY=;
 b=NHZ3FnHY7ZyiVZhbE7yugV2zqIijt3JLsK52xsmT42AVMgbF3h17HqESvfBBlxL+n0WLyuxRvnHySJaV1zMbirq4T0K0f96weBqqY8CP5tkEDulKbOTdrz11n8h91V0qjWEv99NdTry2yQTsZgFHiC4sM5j81K2uxF/wBB7JLI3/Zd3XO8kL1bSX9Uft/A97qSw+uewm+1awlZgjE7cT11ri8nSpNS+7p2dKj1ZBJmoopOI10R9HMB+PqQluO2UtiNqifr61idED2q042wvNi74NDrIgRcJRkhjpCwKfweXoWJ0SMi65U/2eF442AMeh4hyF808FuLRAj3/fYUXVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moeswr1uLUprQD/Ko7eiYcwpJy8/RSTh1wI38gpHwpY=;
 b=rUytVQ2wnmKutjFmuq4DG6W3Xq4S4SKhLV3kaS5jddiAUiPppkO5C+U56m/VO3kY2MSKjYus9VQZE7Cw0kXK+TU0nYAPUdyJTIkepWuOJXrhJ4MAyzqLT1pBLhw8Ba4G8OjoHvm55pT8MMPniBh6xtep9woRv1/jlSO+GDGZDb/F8I7gFiVgwZ+yry2U/DQ16inelVTU8oejV/Wqf9ixlchm/qN6RDaXYSn8iz3wqb6dZnd/YR60D0xryILlCyvtXtdoCgm9nuPyVl4NYBDwiIVH6l9nU2tFc+QewCqSotUDa5ZuJ0ns/kkBHdoRhA1M1y3sP5FxsEQWSbXf29dONw==
Received: from BN9PR03CA0545.namprd03.prod.outlook.com (2603:10b6:408:138::10)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 16:56:20 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::61) by BN9PR03CA0545.outlook.office365.com
 (2603:10b6:408:138::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Thu, 2
 Jul 2026 16:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 16:56:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 09:55:59 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 09:55:57 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Jacky Huang" <jackyhuang@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add NVIDIA VR-NVL BMC
Date: Fri, 3 Jul 2026 01:55:23 +0900
Message-ID: <20260702165524.2168091-2-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702165524.2168091-1-jackyhuang@nvidia.com>
References: <20260702165524.2168091-1-jackyhuang@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: f0db5b28-f64c-4ba1-a9c7-08ded85ad706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	r7srR4l/uF+yualu9QtAI1y1EdPJwVxqO1nMn0pLKAjle8jOxkmjLC9bdV83Z+j2vmyZoUhtYz8Nk8GRQsrXwt+Ji1cdcGxqcat2Ko+crRXYVDo6bN/RIv1q1MT4PptixOol+BGI1NaEfgZeBLbAAbtvElTh3wYoNfMhhNy3zfyfjyY1GaVaAHxgq/zRYHWjHRYkZjwwlthf6lkUqQt1s9faPlpuBx2PzCxW8gmCGgOJ4IKLyLs4oG20j9W9SGS78/KDHWMpzkzaKtg8MbzZ+GKsW8MdWFMuNFDA+8ySYnJlr1oTtuowYlrv00oY+XU152phHR7nMKri93/jSWTZgPb1Qf8CoWOIfxFlbx1XNyhkRFvEw+ja90n4Dj1UXBBbJoO8oXEtXFYwkRrwTgL9v0JP66nS1p5uAEF/cN//KVAjElUGa7AMUR6zLggZq29n9cEgwwueSyQbneVDObIM3670tMw6WdMNApZBbXsHzHhrfaUmvUt/N1O5lMLLEecVm7JWW076Qr7dhgFddLvKVUfryJ70FZfA3RvHkUbuNvhKehXSR04EzJv+/io0L6NMp/7z4TQMv5VVJpA5v3n8ORn6s+67MbfOOfQhQCN3DNbLRC1I+0iXhvRYYcD/KbCoPPul1Zfy5NpKIbvfMifrFRCGtQHMrtvaAV98wBW872yxmlnNEmApu63RsaX6c5BLhFy+luvQJM4AnABBfXNfxw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	805G6GAIlQw6KA7vhAx0I2P0iECa7k8T1cFjMp+ZCmM/pNMn4fp6lCC0JYO81PM+OelFmlD/Gg9noRHn3r1UBqeXwzDLfAXoETwxebYqQa21R5JN4awNjC8/L6hJusPLShbUhlAnWW1sBpJyUtfA1dM1zFnvqD8BDAtLmfT+ghjmmPavsnnhr4dsS9iWz2XfNGHMj6J9LZ6qk41009rA9bj1HAFz7MbaaHpVRX2CIU43o7YzVxmTcXLZ714uS0yGezFOKMnn8yf8zMehrhTxdLKN6bJj7+QawdYcYdyD4OXGVbdE87HEMnU9mstIvstK8LAvlWtf/hQMuEP9sHsbvrUhlZ7F312dO9fij3tMnCn8oD82rtALUgATUJmhy+50JyIDjt+uvnxLopViRc5Mf146TC0b7zfc2bmrtf8mHdzhw94hKNa1PrW2eFowBlXf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 16:56:19.7451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0db5b28-f64c-4ba1-a9c7-08ded85ad706
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

Add NVIDIA's VR-NVL BMC board compatible.

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


