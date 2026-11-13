Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8181606A32E
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Nov 2026 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IoKqLt91
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR8R02pw0z2xLm;
	Sat, 14 Nov 2026 07:45:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794602732;
	cv=pass; b=I3E7FrwpUw5PTv47zLrFsruLE9y9c8H2D18dZBGUxUgNSuN1oIQXSF20GYj+ygYxYLSeC7auxPxsqT3t7Py1g1IVFPg7bQ4urmVNZfNGBePHw9gnI0jcNi93jaJMb7eeBXkayP3wrbgygVAlTS0itT1Ou9t0gtsrEvqAY59tMrN9B5kdEwi1W7DQ1EwdzwHUrrm3CgouOHsTmDq2K4Qk9gtbhiZhsS8XLmvzUtF+jI0Ffn6CBVn0XLTGpQCsdMs+SussmFrt7vSaq6nTemDcqqtSAyAvHeDSEYXh7m5ZUcIFcKvqA7jbU3/vkwDAcFsjAl1D85xbelhMwQCb8XPgIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794602732; c=relaxed/relaxed;
	bh=8xS1qP9zEZ8z9xhExs2g5XvE92nxSbXyrobb1NmlmZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1gATsnuwBkaxcL6fLGoaetxCJoAqtvowjfs14hWJ4lUE0O2xDaWwTOcQvUodtQ/LCS8ukTmhCSVT6MNUI11Ld002gttH2FbfLUtI3URUdJyxLN81fb9iQ9szpQK4a54tfoKz/HKjODbCbal2MMnsiBYRr4hQdlCIcF4XfVkmoD6F4y6WmzKJ7wqbiZ2jeUxf3IP1fxH8IEcY4s5ukTI7S4w7R8PmWNfe89DISYtgGsqaiI0Oe4mCpyDFc9jxkeS0VBR9GNrE3c0o9yPBYAK671PHNfUFVAPlsEeVmwSj6R5mz3dtAgl+L7o87NCqynThkbZe57lUXdtyooBoInAtg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IoKqLt91; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IoKqLt91;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR8Qz3GRwz2xGF;
	Sat, 14 Nov 2026 07:45:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsFl3CLqNRoH/QTex/0xO+U0x1ZJ6ZJyROWDwdMzXr+mDQ3XXudOqbrOc4rz330tWhzAqZy3Abk7q2fnU2zeMhxwEqcWVcRPAJS0apkJ/KL/v0n5Bq+SL+ZcTYfDpJc6oDL6VMxGWAcA5LBSUHpeydMg4ZIfrwRjbOIBvDpANZFLP5QaAN8mRJCsB40D53rH37QK0+gU8xAyUF0x4PJ6BO661521O2uNGy3be3tlsc8V75AmH55vPPQ30w5cI/olRaE2ibjhFJVpsXt1VviRe+2J9UvCPHA5w7CQloR7g6JfpWI/8rD9YaFDPatIt5f9CHvCdG1NJCJqT9jcDHYkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xS1qP9zEZ8z9xhExs2g5XvE92nxSbXyrobb1NmlmZI=;
 b=GoNin+F7qfoqNzX21XulVqm9Rb3qVu7nbfLhdcXCAcJIlPN/vr7P9OiFTw40X8M7mjx6WCRywODtPOcv2GxNRS3EHQM2QSfpak2eOwfpPbZMQZNfFvTVvKx8svzlWFpLmDVQSmUih4UV2/MnHWFh35NGRzmgzmE/3+hLTJO3NWbanTTm4dSV8GHgnsty1c1eO6zuntH4ZNExW9JlpISKXPeSJ0DVMVp8CgbkK+B/hmHso8vbCIkbkKPvYhscr9QKN/Ado1BlJM3RzAjhc7us5rJHh1wIWrzvJlm2glV0Zc04peZdPf0uwQ4F7bYc6W2M78fbIEGMLtTifjD0wlUhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xS1qP9zEZ8z9xhExs2g5XvE92nxSbXyrobb1NmlmZI=;
 b=IoKqLt912QNtIoEMEgL/bdc9bNIyUBaZIW+wjYPH1ZRSbnUuFy2cA+AmF42OHLnHBVohuuVyXN1dr8iP4RkRzvT61cUEGRE03PkwfsXfbvweO3md7hFL6i5x+W0/Ce0v/1XiHkTysbEzD+mdhiNFMZIW9RL4HLzXn0AUhxNqSxqMZS4107b9Z9LwB+MdvOqvrI4tWcPWmeomzFfKw6KH/B5nAJ6+uNBhCo2kQRFmp2CnghdmUqhaGK6HD6Em97p4ZqZTseiu2GsuvgBAyXP1z2KqEVPBjkx2dSLPlb700r2/ygFeO3vKH+kpB2VclwwCLCQe68iT7cGkJseJo6F8Cw==
Received: from BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::16)
 by PH5PR12MB394451.namprd12.prod.outlook.com (2603:10b6:510:502::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:45:14 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::7b) by BY1P220CA0040.outlook.office365.com
 (2603:10b6:a03:59e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 20:45:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 20:45:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 09:45:27 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 09:41:59 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>
CC: <joel@jms.id.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <ryan_chen@aspeedtech.com>,
	<billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<jackyhuang@nvidia.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Sat, 14 Nov 2026 01:41:30 +0800
Message-ID: <179455982636.2173009.10261089569510079520@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <42bb0b817905637239c16b94a562254cd0e6a644.camel@codeconstruct.com.au>
References: <91edc3ed1d65a6765530895c6574714bfd76b8d0.camel@codeconstruct.com.au>  <179438627442.2016371.12057101111349178921@nvidia.com>  <42bb0b817905637239c16b94a562254cd0e6a644.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="us-ascii"
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
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|PH5PR12MB394451:EE_
X-MS-Office365-Filtering-Correlation-Id: ca992e1f-611c-4708-80a8-08df41c704e8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|376014|1800799024|18002099003|22082099003|261009223027099003|13003099007|11063799006|56012099006|4143699003|10067099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
 b+llUv5NQ5fEvJymQMw7oc7Q7XSp/74iYmBvVL5nIh0y6V4Pn6D6Xhf0lH8My9WyU/6DXXNNiXdm+L/z1sWlgLk/zoO9BzOtJgaDto/dR1uZ/5pypYbhLUuCR4K8tpNGhGTZaSHMVP5+plUevHzNRsol1dDGkRLlG4ji7m4Bd1/Q0kwbvMDnqlOkgleKC3moiyNUY2qeZWWGU5XkUGO8q6LICaMBR8HBouwNe3CUOn6/ivUeLSarlnSlVA9E0e60VfZC8oDDPKFSDYtU1F3Eog9DE5bZTDkRM2LxaJZipHCnqNZhapnnMMhpFqfY+pTeMdnwbi3jCmCaat9t1BHOXVyc+gl2r4Mf3i31HMjgeoUD/5rOZBf3bT/OmbuB8BClR/SfzJ3y19s5FW0iA9YzOawEmCwma25GvBj9QkjBMtxSv6xw+XuExCkm0nbqEwSxAGdfHm1mLQDw8x1Ba619rDSFCmUeaDZ4RNRwt+Idul2mapgqy/ZUIw3GpXqSyic2W0/rNaEJCnMkq6e0OcO6VwswncuEBl38ktquQqO3853G5BzRloN2w9tDXYF8ZGyhyweR1XWYKSIdb/KuZqhwOVA5T7fWMcNTtO+fm3ccwWzaf+QEVKSvEyuMp0HmeyiThIriY95LiPppotfhce0Qygixf28vUZUJAmt5ZkfWzYunxYMHXQ24o9gd0q4hw7Z84c5oiXl4uKSTALrxCgR70Q==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(4143699003)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 FbiklKapKfadgzQ3LcgIkdQOGb6donRRp2JKvpz8mwz04rx7aeixMILNIr/IKvnocYukHv8T8QPfesdcVVh6XKTs5vWcVSfQWJsJwzgjBvMdq0ZTp9EOQOSXuf+XbpakWnSMWNweBFQgas2LN1rotrWrcVCXcwo8yjmCJIbFuRwd1p19hIPt8BLrGTn8SKVnecekfc2c0J9sz/c/FTuxN8NhVweYjGRvgXgVz1++dY9GpUHLTbITTNFdjfqHZRk/uZhV8xEXym8YuSUx+DsyWfWpH0oFZlpfRBWa0yqGtdQhfpYh0eHhThmMPnQX5KchJOwYG6sSGM71cM9p+c2vKJzFvPM3i00gxNsAckq8ZTcwJfcXYnDUMFGWC+b75cNSxSVhOxADe4Zccgvb+XStEgzHL3RjNN7o9FkGmjp2+OUWasR5fNTfIzixRMtqjHeb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:45:14.6279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca992e1f-611c-4708-80a8-08df41c704e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR12MB394451
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Message-ID: <20261113174130.zUWrEiBMxDez1qC1AwHIzketxnsSc1aSdIwMmJxCF6M@z>

Hi Andrew,=0D
=0D
Thanks for clarifying. My previous description did not explain the=0D
purpose of the platform. I would like to include the following=0D
description in the v3 commit message:=0D
=0D
NVIDIA MGX Vera C2 is a dual-socket, air-cooled 2U server reference=0D
platform based on NVIDIA Vera CPUs. It provides a reference design=0D
for partners to build and customize Vera-based servers using the=0D
MGX modular architecture.=0D
=0D
I will also include the following public links covering the MGX=0D
architecture and Vera CPU:=0D
=0D
https://www.nvidia.com/en-us/data-center/products/mgx/=0D
https://www.nvidia.com/en-us/data-center/vera-cpu/=0D
=0D
Hope this can help others better understand the role NVIDIA envisions=0D
for this platform.=0D
=0D
Best regards,=0D
Jacky=0D

