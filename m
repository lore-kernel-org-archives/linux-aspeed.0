Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475B606A32A
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JkIRkDYu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTv9B2G05z2y2T;
	Wed, 18 Nov 2026 18:58:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794988686;
	cv=pass; b=kZAoC39r5oQQIwuFw59WY5E+obdYyvJkNN/jN8FYEHUpu5Rbn6JknBEPdZcsWojlaYS+Dk9SixjXpMHK7UkkVfS0UI/DLvNFgg7v4iJJk90g3oLSLBgUeuGjiZNAfOIhVGB6r7nGLbz73RA7I5hcB4hrpeZf5vkMXQ3SnRbWLbFE9G8QZcawu/44UG8LnBwp+qTAIR/7N7tYnzIStXYj047wNdDB7+KjB0S3hp0GlPPHztnr0YiCClZQtYRv5jfPc8WMksoGCzYOyRE2A1GiuZSGUIKaHdiaCOKFWaNZa4ddkM6VEsowBV8uKIU0RAItQJ4rnPz2zfbWSdvXk84XZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794988686; c=relaxed/relaxed;
	bh=lWOh1vVqeDtz7VKFLpNWeZ4fxLg5K3MLHFWli6Psq/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh9lz3ujU4lbT4wP7v2geYRtoigAzGcFLxPND4PpSvXzb0bzdVOJ01jJ8bc7Y15fYb12ectWUzq7VDyD4hiCoPQMLBk5othl01FXSLV3ity6oOJMFIZVub0tSzNEd6E1e8Zbm837sXzCZ0XbDTfMLd0pDJAX55wUWf1UeceFIYiv5vf2EpVgTQGiCB22plb3qAPz0KluGVzXh1K4dm5Fgew65A9D6WIoBzbytctBI1DxG/qIW70LWuYuQgqE2Ya6EWBepbcAuEgaFy5StoJVz0PXLIw3GC5VkEwFSbQyk2sU9VosEcRXzqLTYyPWSVrKx5uqSdfPkhyDzkt295FWEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JkIRkDYu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JkIRkDYu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTv9832dMz2xL4;
	Wed, 18 Nov 2026 18:58:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+2EOLB5MacOp/rRa+8l/jfsQt+fA1gQiZkoVg1TDQTro8iCMloSoI3zpeJpOkGBBOG+jYV0d/ZKUeb/AGhXjm2lCxH8zbIVW+Cbtp2vk91CRbOpwCa9JKcWCwdToA5e2k1yxGaC+HIWhsOY0fWBlcX3Svfy+4hzrSgqW5DlUXr63U75o7oQuin43XYxeySJ6ZiB7Eq5mm0eRloMK+xwSeACxskQKG2/KjXaYWZf1uYzaqP7Ia8EHtQ5U+jz0nyMclbKLYUnm4T/gfe8WNuNVrrTOrdE+8QX9VjtgB8Fa0P0Y9pYuyFiGwsTmCI/WAqmpqD5j+s707V3wV7OPYwSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWOh1vVqeDtz7VKFLpNWeZ4fxLg5K3MLHFWli6Psq/o=;
 b=Fo9bW0mWsuSEAZztlA/9DUCI+tn71IgWrj/adnrVAO7Xhlj6QAiK4ZTA54vAQjwP7ow9mZfah38mJxY9t4UkgqVNDj+066eXRPikak3dJ4vH7dJcf3YJdlrL/OlitdBphPSvuwSYMJULqpvQxB0192RsEd+SfiDb5Ih+IWrng4aYDYsMRqmi+qyyjVfgrBCmRPU3HOzKOwGetzp9LWi1Sgte9nbYPYk5mc1z8rEBpbfyRYXYGEaLPlTZrwdkyCIun3xaOQUb5lJoD5YyLKDkQy/GLzOlo5vKTRCW7nB2mDbwGhotOwK6fm3hnariKbPUG+ha6FRixjZTJ5tQP+x8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWOh1vVqeDtz7VKFLpNWeZ4fxLg5K3MLHFWli6Psq/o=;
 b=JkIRkDYuyOj1++lbAHgdmTmDQCh1vycePHZlDIYeEc+jWIQEQouQJunAW4+L6k53TzbUfkZu2sFciShZ4jU3mMVXDYlk892tl8SQi4PjVzVVzFX41SPMgyrGZEtfwTA7kktNqBln3XkxaPDf+34GcHka6YPEPriY5uLjQpYTSh0dGFf+tR+G3GIA0U7DvqmbbGDCJ4vkvGetGWb67efOwhoUhwAMyt8wQFCra45CGlsUFCYV5VzgliInQabDHijco0RsU1rmKOH7WodjQf4TiNTukvv6I7vDftLg08KcXU3A+NQCPbvmzRnAgtcEPiClFVvyGyJWTrVcvAayQBfC4Q==
Received: from DS1PR05CA0028.namprd05.prod.outlook.com (2603:10b6:8:23f::19)
 by FT1PR12MB249006.namprd12.prod.outlook.com (2603:10b6:170:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:57:41 +0000
Received: from CY7PEPF000000EE.namprd04.prod.outlook.com
 (2603:10b6:8:23f:cafe::98) by DS1PR05CA0028.outlook.office365.com
 (2603:10b6:8:23f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 18
 Nov 2026 07:57:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY7PEPF000000EE.mail.protection.outlook.com (10.167.247.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 07:57:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:57:22 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 23:57:20 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Jacky Huang <jackyhuang@nvidia.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Wed, 18 Nov 2026 16:56:55 +0900
Message-ID: <7a3f142b8142b7c067182799d30b33b026e74221.1794985308.git.jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794985308.git.jackyhuang@nvidia.com>
References: <cover.1794985308.git.jackyhuang@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EE:EE_|FT1PR12MB249006:EE_
X-MS-Office365-Filtering-Correlation-Id: 303bfb7a-e27d-44e3-b0a6-08df45499e62
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|22082099003|18002099003|261009223027099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 g8ZnWvTOWpJeg9YTrxZvp4r1dtNeh00mrA9OuHSfULdpNGOSLOS1EupOaD0BZGDAFTxdkG2b9tylOik2kXVVvFvr6cwyxoERtNniDLhlh62eO9TcKXW8pS9DnB/F+HtoHWQUZEVnkCHKZEWv67sXGsTcs8V1uMrhStmmVwDQGVbwI+85ucTEawlPIa0auB+GS9hadq9dZGfJ0fZJzyB+w0Jbf5Jsdb8/bBLld1i/uxItmlxvWk9nnQgPy2jV0CqLe6oXtG/+9m40pT1wRtkkpN/nw9mrUfAQQAYy1yzo0H6inZUjx4UqGJCJq/XwrTaNo4HLLWutiqDKfp3qRC/zUJkmSZthdDliMkT4oeuB89G1BI1qgctkozL53TV1YOeiR+mzTKwXyBESpa8VG7HYNmVSYqov/o2OlvSXbHX5kKpangBB+wFBFz1lC0xydGza1UT9IFCNQ10j6UK3SQf80LSmR2qu4uIz+VodXY0LwaQ4qQsBwusoKgDrKZfmTu+7+tDEpLzaTA0TU07Ndy/tu6vOb23AwzpBXlnH0DgbM06nyPD91ji0If6aYJ766oa0A9jBtQ2rPlHMQiY7Bzz1HluzpvxOAMsPY0jQqCFV7Fr6BAGA0OkRS0lCocJVPI2iDkOqRXaED6N7Z92P24g6qxEc5el67im58DLeXOd9rxHU8eCFywY+lsIP1ixFmS/+NJZqIK1dHnergsiYbDxwVg==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 9laG8UdJ23Xm3qDuU8tLBX5UMflomBv8NBfVbtqlrR3ZUy5u4Cdfz3Y5TQeel+pSX5fTZkQHcRUGdVTyDqSnKbscuMXjosRA6B0frVvBIQawsFr2lyZfp6UlrwfpU4Xb8Q0rCMIBW+B7IPbCae3wi5/ivVj+xPP31iPg0XO2wQiwnvLTXAy33i/Wb8gFAdArsxo5hKjnjURs16Dr0Aqyq4EyRcWSrf5MQOgRXubW2vqc13L/BZ6b+jZX9A6Arw1UykxJNfhdHWxl+RSgLuElbKi2Jhvwfbclt4jsNv9dbSKkylqBnNGLHTV2qQpoP2T7OMrc5waH6eyrt8OcezWWBrxZtb+0fLh964VB2xXMsg7zuMMSoYpFE9QfCXs1KdLa5/9/KPmCvff5iW5NyoWagVOEjmsWqSP4J7+CsOg1r+EiuUlo1y4mhvcjOJ/bIRbd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:57:40.1158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303bfb7a-e27d-44e3-b0a6-08df45499e62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB249006
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the board compatible for the NVIDIA MGX Vera C2 BMC, which is
based on the ASPEED AST2600 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
Changes in v3: None.

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b7e70868e..92127d7c4 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -115,6 +115,7 @@ properties:
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
               - nvidia,msx4-bmc
+              - nvidia,vr-c2-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc
-- 
2.43.0


