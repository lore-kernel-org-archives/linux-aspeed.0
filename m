Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC4606A31B
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3M5JnoK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7sbX19nNz2ygD;
	Tue, 20 Oct 2026 10:44:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792129948;
	cv=pass; b=ipNq/pXvvsP1X+fZCGmuvfcFJ6hjOkZ4g/S1cI4qbB9rYnQs1yCPczdNH59dBhrXskmfL1f5W9ELniz7Uhe6oGVx5Ji9mlwYUmjN+JWWHnDDgLZ8CIrCyXJIBhMNU9cd8PWC+I40R7hbNumsFzB1rhE2yH4DdtRsmxmuR8isWYIsrdRq8efceWA5a1Z/MAPrF4wAdvhMb3vlACuFtPBYmVoetqumJ73FXpReHOBrWJcdBN7Qdo21SpahoLSru22+BSLUCkgjf+pZQ401vxZ+dC92O9zaeKVHhyB/KqDuDcBZ99fyiJMALJzbTrnlMI0fNf+OVQc4XXsJHRXlwj8wfg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792129948; c=relaxed/relaxed;
	bh=K+PkjRxZ7BzcXDwMGlg/cwyWkaXgj31DyFfZOMIRkKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCimT3+FsmgMLhiHilD+Mk1X5UW7kqTAlL/2eylvcbLvazjiOkhLl+z2YJbvhi/OkaRw1mktIzETRb3dohkzIdZRThjyEOANzMSGWqWEqywX/Q4ieaaP9sbHIgb6//kS8Cecobn6xCOjcougCtlEFXevLvSzNvYBF8abil30Bt0a9x6wYYvZS6Fi1n77T2GPafIkpT05qdBJvMF4kFTkqgv8fzLagmt0WiiE6e7QYNaY0jWMIBHizE94em+GXtiv7IshrLPaC+NaotkO5rY4s5exJpMwSERR/YgF24aSyWJwZ5n/16VnIhoaqT9+1TqbJAea5JQRJdsETeTKAS6YHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3M5JnoK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S3M5JnoK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5YxR243Qz2yMn;
	Fri, 16 Oct 2026 16:52:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I++W8/gYK8Cemvd4SegZjg2xY59AzIJTaMavPo9iJhDwFoWORrmglHuo4TAPnJb1SFO8VAuO9ebDeQr0wyGpzu1/VJTENjJ0EbbRSeWzh30OMkAKaSMrR3RCgehZ7eCd2qBreIZCTHxGHCxeeqMWuUh5+ntdKXWxXuPNoP9bJfcjj1Pw0NJwWED2a2SRAACV+ztsQVQCWzRpv6IeXqbE5fPokL+4FuwAKtZDsHcdP4pBzizVCG6h/Z3+HxqasD+pKU9LOBw/6i+4CqKukqMgLle/88ORFMRazuPAGJ8UcijXxcG8Wz/BPVxkrtcy2EzVQv6IASzF0bozF9GeJ6c4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+PkjRxZ7BzcXDwMGlg/cwyWkaXgj31DyFfZOMIRkKc=;
 b=bEQwK8a/PKx4m6Xk3YN5YhOrl+cqem/bH0FDnCFWvZQUzSFWK11CsOmyqBH/hFGYV6e1zlZZtNZOMNwwKvoFfPj3JSpc1p38+fca1YONMUCPxnzfvTgmRZCFLJTiKmAa20nYiOujKLTVoGqsdx6f420StUeIddpQuBYXqH9GKpc3EsfIx7iCNleJdif1XV03HFT0Nq++JO4rUiC8C7RO2g844zmXjIj9bbsqa3OS1/YRu4huErEG1pLGC/Hl0dmSFxGt5pAgwgQLwEbesBGZJhwsn8Woo1+XMnznfAQGmT4aaQJF9U7Z6ZGF3YxAv9KEIok7L1IVYh5OSqDhSaHOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+PkjRxZ7BzcXDwMGlg/cwyWkaXgj31DyFfZOMIRkKc=;
 b=S3M5JnoKf2SPtJLZs6YWhzx4lrZymUwuHfMw0hRbhc2w+GM0oDgXnPCItZKQ+WlANAQ/VLXzrPoQ6aRKqYvPsB7VeCpFhVYNQ703RxlWcnAy/ANY5DTWK4YB3Menjg7cZ7PpPLyJC0mx4yEYKS7YW5xxjqmsSeJSGBeVspQbJqcioFTBShC65QY0S16e6D1VyqWza6FX32UP/XMwVJvS5b4rqgDSHO8tDS01Vml2bAeVDAcW8qRq4tVD5sIOwaCIAh74BDQL2pXtdr7XMgl5xpL2Vt2KPUFD9lGr8LH+yAHsbs/qUHz0Vkat5l7EqHwvIiy3l0rnYoxNCMyvJzqCsw==
Received: from CH2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:610:50::19)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 05:52:00 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::60) by CH2PR16CA0009.outlook.office365.com
 (2603:10b6:610:50::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 05:52:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 05:52:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 22:51:36 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 22:51:34 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Rob Herring <robh@kernel.org>
CC: Jacky Huang <jackyhuang@nvidia.com>, <andrew@codeconstruct.com.au>,
	<joel@jms.id.au>, <krzysztof.kozlowski@oss.qualcomm.com>,
	<conor+dt@kernel.org>, <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Fri, 16 Oct 2026 14:49:53 +0900
Message-ID: <20261016055117.59404-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAL_JsqKx4OEM-asdvs1wUiP3FFObzJHZtNTtqiwtcRhJ5CPRyQ@mail.gmail.com>
References: <20260728085640.1001890-1-jackyhuang@nvidia.com> <20260728085640.1001890-3-jackyhuang@nvidia.com> <20260728143952.GA2121505-robh@kernel.org> <20260729060612.1085870-1-jackyhuang@nvidia.com> <CAL_JsqKx4OEM-asdvs1wUiP3FFObzJHZtNTtqiwtcRhJ5CPRyQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dd4418-8767-48bf-e2fa-08df2b4998a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	FCzlMMfUFPGsDblSUPlT5NijRKuzKNREUX9N9sj/bwtpc9Eqv5j6kmaywsqRi9N50J0Jij42D/Meuyk5L60WTElQ0NYfB8Ual6UU8GSbZ6nX7Pmy+F1UXIVWfaA9jxbMjFXww5UEybye8Syv457ikrcnY0gXkn3DpJ8pYY2+69EiY746BkhfPXonxlS5x+JYyzhysiYmSsNI6yeN1Hohlkk1RFKkfEK2TlJZwNVf4DeM7rLsskfUIzeuhZgnUBBgASRo4Pa+h+FWbNVo/pgv11sDdxGV4gkbGBvByQQSHArY52W6Liu1r774nf+PeEUEYfSZ1bJezK6ZygyLPHc/uR47JadEkH91R4D2ZSXj9SNQ/mB6+dUvoF93h4IuijpkQUomkzYkB8Oyqjw1NeuzcvSeawX3bUjU3xPSS1sewjDPewp6+Q0E3EbAhruNj7kCRx2zMPSLwb0lX7glR32UwXrbJFDqQwC2IcTliPrTlMhMmAzWvqfMApcBeIFzKZwAJ+X2Y3io7p10PQHoiOD13j+jX5bnbbRUuSkd3sARz127nkHNI4gy9OLi9cQcVt4TMJ475cLLbMxfqq9tms0KUOBjhwqxBQvr57/tUhYnOs5mrX5l3+Nl4zZ4tHn8gvqJQs3fLB6VzSOJzzR4+ezXVZHy+mDPIoQ63rfgcRwqcWQeaIbiTORdni1EHD26/m9nJfB+QjoQ61ft9c2FfPwHtw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G+S5Hl0AF8Nw6h067meoiS6Dlr5fHn2aOPQNXXS+Q0sOv+voAHwBtT0boKjrIB036IY3zUT/uTb4/iUfafMcwdo3/+46KK5oG9WYnwPJA8xoX2j+eg7xylaCtch6VxmDNm8aPU4uPQNG2m5iV/t7HPLbDQ6hhXUTvaoK3+MIpBynR3otYuXw5Z7yBqRSBJ6kqTEncx0TVm2o86Xb/WYmWKgOSPrDAKaOYJQVupGtdVWRu309DalZRfuQKfIX0ipW511aPPyr+6BjutYKJYAEtZ6LDOw4JnZcjajEodtNGJTrTyUm4t0MjekUe4bIKacxHZdM0etKRAcqZzLOCpp1dv7tpZD85ICn+eR2MOh0TjzM20YLtezO2zcoCayWh2/z7DrKTfhwHo348nnQj8fpVoitZZSVXKW5tSiIIAYk/KydvncworQtNzvfvGyF1hlh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:52:00.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dd4418-8767-48bf-e2fa-08df2b4998a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Rob,

> A board level component shouldn't be in the SoC .dtsi file.

I submitted a separate cleanup series to address this. The series
updates the AST2600 board files and vendor common DTSI files to
declare the flash devices they use, then removes the shared flash
nodes from aspeed-g6.dtsi:

https://lore.kernel.org/all/20260813102233.3088939-1-jackyhuang@nvidia.com/

I plan to base v5 of the VR-NVL DTS series on this cleanup.

Thanks,
Jacky

