Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7C606A320
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G7lTbXLC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFjn366rLz30NF;
	Thu, 29 Oct 2026 23:13:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793276007;
	cv=pass; b=FrcM2JIX7wxyE+6szCsfTqhUVDwRAOnlwNeew4TAMNnxRnsvinoeFOwav+9PPI6wXAjvevs/I4eIKM66d3CR69vtKCxO6wjGB0yp/LW2t/9HaLIAGKf2NNiGZFe9HbiGGim6HMGBegP5RPmuxwnaUF1IWtfbM8VeWk7YyKiPQ/PM1UhywwbLD3bdCXnwbwuLtOVxhp0kVldE6z+BI2E+DXdMtiAkIu6AFrUow2YEy76R9VwTbbHm7KYV6JIlmXDE7XmIiOw/XqUv7xOXdYqZh8o5HOLl4XzGv2/QW1YXpqZLNBaRxz5sIMozfAKu+TbBeTzpm6AT1VQMLYFWhJfcvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793276007; c=relaxed/relaxed;
	bh=wNRTI9FBtG0+UexcZmiluRkabex8QHpgmiDWGK25+BM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4Ybvw0KxIKJ4svzdL4XGb9vlIRxU0Mce/6TtyDINdOJOjvQv5aMfc1NWLb/wLU0J3FuAT5xEFNh3K0kWwg+CIrMw9jSghsz3HvxWBQKbpgDcNQdkyid/S1in5SzZzjMHWTtx8S4p5u/IDLPoArCnF5f/IScwGCjBiXRljakNbzfE91I5fCaLGWjaIxaAuFSF7Zt8aOubNXY7CDjeqCFlSMdXM1U0bfI3XgsMBB+S/+DS1kdH7/78TmBwEu/u6Ngql59wZEjy7Z5dVRG8KE37TvfVuck4WhePnfIkAWa7oASmLYiEXT6Y+0SwwUf4ey920fKaY87qOU8oOZEoHTWjw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G7lTbXLC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G7lTbXLC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFjn246v7z308H;
	Thu, 29 Oct 2026 23:13:26 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY6jgetiZvTcjvfVg2QtghZgR+o80N7ZphoqrBwYlolJDUGY0U0ILb9fZV4ROE0iC1HGjwPR6oOyd68QJUPxKNhy+ZvLJkzVIvO2IoAhBRqqfiF/dZkhtMMyotRmU6IPR8ovbQMAKhMk3IGxRXbKBoe6zgT1K+kAqYMAh8aHLD8fJAw+iaQFWpxplhxLdLibUA0dv/0eIbOpXpijM5Gu6ZhRpUe83bhjdBmFKrzB8C/EP79MgSAKjWzsQN7O09+0qIflgqJ+popmP9FNi+KynThXBNBZeFOyGTT80VgasW4czqKwQJ8vQLJFYB7zFP50ttO2DK8gjRRRdxyMZ62XwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNRTI9FBtG0+UexcZmiluRkabex8QHpgmiDWGK25+BM=;
 b=mW+/ruryzQAnl29cen8EFA76bQby5Nb7LYmcok+rJbFy9g88CM14VWfV0xO2EjpdX3R3k2yLdpZxCwYmGaTtyL7FuwcN5I7cilolzcpjW0OOTMHZm7KmOn3lNkQQZK04WP2WH8xcrh4hP3N/tDxLkDdZIoS/srfC63QxYI0OhZTmqH6iX0W6ZY7t8M2JQBF8teD6wTdao1aMF9YfT3Ne2D4Wlo5ldus9mJUj+bt6DBPFlvnfn5xG8DlUlpEwrO8pkCLzMNqWDsueXtE4m73oJN2sYMyRLd+eKjgE+S4uLfEBJNqpLjUhlKCGepAQHFR1ILjgS/oQ2SSU1y3USzuo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNRTI9FBtG0+UexcZmiluRkabex8QHpgmiDWGK25+BM=;
 b=G7lTbXLCZRK8k2UeRNwRsJPn237Ly+XfCv/chZeNfbxc1f2227IqcP2OEfIPAFi7sa0qfN+8nHESWGBw3tvkzM76GgtqZWKeXlqIFhoUTGO5QHzhUEALAdWQc3C+yt3TV4d5RVUq4+JY7YuenMC0P9l5WEbbi6NuUfgR7Ag60GpbRmWjdrZOttT0YPwbSVxiYi5oANV6lAHbVhhUK3tTSRKpS/RDPEUWLyrLjfoRIzPk6OcIsUnu9qP5j0Lve8vvHMeg7h0rUO6tT/+lDgtNoZZZTl9uQ2+XxuAsR/NqyRqHpWR3IRijuUBU7tKd8LADkavpX6wF8m/EUnkAvyiQoQ==
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 12:12:49 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::5b) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 12:12:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 12:12:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 05:12:30 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 05:12:27 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jacky Huang <jackyhuang@nvidia.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	<devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ryan
 Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Thu, 29 Oct 2026 21:12:05 +0900
Message-ID: <20261029121208.827285-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gentle-devious-trogon-de665e@quoll>
References: <cover.1793243187.git.jackyhuang@nvidia.com> <0d221cbd11c8b582d43b21e4156dfb7c83b121b3.1793243187.git.jackyhuang@nvidia.com> <20261029-gentle-devious-trogon-de665e@quoll>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ca1b33-9372-42df-3df3-08df35b5f320
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|4143699003|11063799006|56012099006|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|10067099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
 9AyVvuRZZA0ltcHfKkXIatKTzIT5G/0c0N3PMP8d9TC7MoKuR4mjjQmS/PmABA0U2P2VOUvPiKSEYfINLZegR7V2t+UQYldLZsFHDPakllZ+jKuDEYNj4bTlc1D0r7FPLJeLCJMAPFG9nuoEWmf4qbm89wiatYuxp9kd+Vh7n3BGtboTwG1qjcW93A+tNaREjiJtiiPH82MNBzYY4FSFK6Ikl9qnzvmjfKYGlHHCa+T1FtvYG4ULnurO//hIjlupCYISCrcNXi8VA525JC4ebrde1HRu5+lrKXJhXOR27FVikfontB79wz8G/sxjhFtbptkgsfyjVRdFxWXYPO5B+zIUSg1Cl5aaElG1aVm9FSJQjxCpZwZlRCZYrkg8aocjTdA9vhnB8KGe4xfM6Cy7pgPgMKRkFEcYMVM59Ho//w/NbA8rRR1pvafBvpK8nI6i5kJnVnJqifl0VCMI+7K8Sdc4TVuOdgE/gZMgOYcKb+mVMxTFqc+6BbIlO4vSg/teyUhpQtsxNr/mWdv70UlBTTBnKXI1cGeKy+5uG2XVtsPHHoMBV7lm2ITHmwBniQovGldC2oJnPLUgkRLF3uM0iEfAi0ywCtnjfDVIhB1UhsO18wlvlBmMAMEc3893KOdkXQnMpG2FrLRUZdIH3LvA0l2To41cjgkpfrcEptn3i2C7wg2CWcQcxu5MnM6Gs+xorV8eWgHbgSpkOZChsaKzUA==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(4143699003)(11063799006)(56012099006)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 T5w0n0kMJqrHA4dYR6nnsTbwPmZ9F/hwDF/d4YMTPTb63jvhuWLopiS7wPwmyGMwZkV4dBhJbuCAT+1vNlabL4LWUnt3DWVY89TNeXZdKFepkJminREGDsmgO4ND3NNEn/o8mY9XJqjU7AkqfmA811XDjdBvwzMGIW5cZM+V0kWQj3wNovah5qPGuHl/UdcgRjz8KLYo77RLNUOXBZMBnfHas1qnMMZlchbtYxadiTnLyh0y/4+ANHpek1AfB0v+cVJyX2DhDky5o/19Spjspy/J9JtOolg/PnECTaB7LefY0Rvck96FURisQgHhTEHiJVCk8ranCQfNs7yY+TglqYK5AY5yp1uRfWtPlWwse/CzWxfSNPD2TQ9b4xnm6qgO6LYyt3hkYu6DhQH6+SpR1AnI1AhNywM2WigPbW8FLoKnAeBLOPl5oBFZ8yIoczST
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:12:49.2515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ca1b33-9372-42df-3df3-08df35b5f320
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

Thanks for taking the time to review this.

On Thu, Oct 29, 2026 at 10:53:52AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Oct 29, 2026 at 01:58:08PM +0900, Jacky Huang wrote:
> > +	chosen {
> > +		bootargs = "console=tty0 console=ttyS4,115200n8 earlycon";
>
> Drop bootargs. Console (and baudrate) goes to stdout-path. earlycon is
> for debugging, not mainline wide-usage.

Will drop bootargs and use stdout-path = "serial4:115200n8" in v2.

[ ... ]

> > +							/* CPU0 IROT/thermal/SOCAMM/JTAG */
> > +							pca9555@50 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).

Will rename the GPIO expanders to gpio@ and the fan controllers to
fan-controller@ in v2.

[ ... ]

> > +		gpio-line-names =
> > +		"B0_M1_MCU_RESET_L-O",
>
> Messed indentation.
>
> Are you sure you run dt-check-style here?

Will fix the indentation of all gpio-line-names in v2. Thanks for
pointing it out. I did run it and it passed, but it looks like the
continuation alignment check only considers values that start on the
same line as the '=', so this case wasn't caught.

Best regards,
Jacky

