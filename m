Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60038606A33F
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Nov 2026 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V0La8Nb3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR7YS5n8cz2xLs;
	Sat, 14 Nov 2026 07:06:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794600364;
	cv=pass; b=R2VPW1PGeE2pekB9SSX0SRCJQVne3JWcNMfY7+PbbfmaA8UEAnvz2ls+1V43f5MW8PA+n3T8D0OWOCirwg7lmeyavxpJNwlmSbrvUwDtItlt+ySDx7vMzEBjpsOyGLfeL1pfsArMREJ5WTbWhlyGH1obR4EbeeAegvovC8FFXcPqRtAtajwCehOuRE0qNJRBS1mSQdSxg+zHDatBNj6gr3nJrCub9+brPapUlzxMSSQsNjriJ9QI6UlIAW//oV2qxeBmPWleeRScQmPhzXYYI6wOl/6aOLAugqB1GEOrEXQ0xKfhSHRnqhqPQup+hDvawUBXNzkuft4OTVW1aznQpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794600364; c=relaxed/relaxed;
	bh=8xS1qP9zEZ8z9xhExs2g5XvE92nxSbXyrobb1NmlmZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lIHu9rrJgyyTOPiAfsgVAqol3S2jjJO8Mc8lmB+fZdHQzlCVPwadbEttcqyJyuZudOafYmFMbj7wn9ATKwSFPIl0gJgX8ZSlyBk6eR3dyExevpWCTpfJ/o3YHdAagSxer2ZF+Ev3pqovOfziyhj7v3YnBYmlFFSz1S5/fzz52xvQLN8kbYaCmRgWF7Vr40RnQ/9tWV/52WDzCNWod1rELDBBBZcR8JJbn1qzzYYOcwTEaAW4hQgI0w9Y8J/V+aRkWZCKXa4v+n0iFtod7BpAO6NWFZpzhKFvA2T6ShKIHo+GH/3amAN7s4Zaoc3oc58cJ/tJQEyWUpj78CJ0BhCPvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V0La8Nb3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V0La8Nb3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR7YQ4YTkz2xLh;
	Sat, 14 Nov 2026 07:06:01 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh1U/8YT9fJoHmtT6c7SeipQh6Vfab5Qfnbv7iMvxU7UPR2dLpxKj3nubaAHcJK0HF9ji390QZWnu/DDsyNAxVMCulisZGbjZW9ECo4ggtqGVOViH1pYuiCCzgRSjpxmTkSutQmjpMp5aIrst2VeTqEd6K1+x+RKlmfWzLVZc5e5PLOXjCFYCFncqHMDmA/4R7aoDyeuiaTJNuyVk3OUmrSsZNtoXDWAexmI/UpCVSsoRewHmdLZ8YQUMWEBQmVO1xogMrbu0TjrTJcLBTpmfG8KVQL85lBaVxG2rj9n2Abk+oo1qVczLGjoxAs4fzoysPmeGmrl+qFxbu/hmHgxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xS1qP9zEZ8z9xhExs2g5XvE92nxSbXyrobb1NmlmZI=;
 b=Y8YIIn+uxb3jo0MT2KLoX2Bdj0AImNR3pqZc7ClNva0bNwDwsTRjBqiiE/0cBQXN881NEJLTT7MUGZ0lY11dQQve4w1x5f/qVRFhIzzyVYYzKaQtpmyv/8Qo2R9m6OFmbZ2AoAF6BAsbIyErs7ps3fc+JEAOwTFHyi7hZqpuzb3MfM/R7b+1Ld7XImgOM9nnvBB73KTXVdbTa6lXj3pUEZOGT7MO96UdIYpAlBMTOXsf5v7v5EOgOOkzdJ8xrRg5Ko355lAMDsmA+wrOk+vBVfPQ9esEpfWMet9DzTESDPkQsDQICC1CCtnIe/44Lj3XvQx8TNOxClboLxjiqcIbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xS1qP9zEZ8z9xhExs2g5XvE92nxSbXyrobb1NmlmZI=;
 b=V0La8Nb3APLeKiZGagQYgJa0dkmJeqEfjNKeXZjJVIp0Qw78BJh9vZDTUSfBquE1hLucQrOudbF2bEMAez916qTZ46wAP9ZEAMm1moQU1fHUEYyXqxtni0UXLqUUH+syJDEQktoffDEXc9SyxGDTRZDMiuV3VMFydt3Ix7FSoFwSrLpkLkZGmwDCXZ3WUBmfyifsLQabGWveP0VFuUNhpsC42Un67/b6JVopI+oqsxk5HkRWvuPtiE8dUJvGEGgA+R1mPF3P5FytEGGdHplid9SbjTrejB3Azu8vX373CTwY2E7kEEs2jiEvyDICmmUhNDxG6Iy9DomQUuuMufToPQ==
Received: from PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::17)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 19:55:24 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:348:cafe::2f) by PH8P220CA0034.outlook.office365.com
 (2603:10b6:510:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 19:55:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 19:55:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 00:57:53 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 00:57:51 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>
CC: <joel@jms.id.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <ryan_chen@aspeedtech.com>,
	<billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<jackyhuang@nvidia.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Fri, 13 Nov 2026 16:57:23 +0800
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc2ada9-ab8f-44fe-29e5-08df41c00e78
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|82310400026|1800799024|10067099003|11063799006|4143699003|56012099006|261028144727099003|261009223027099003|261026140227099003|261022105027099003|261022075727099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
 CVi30Ye6d6L+Ejd5r3ieEZTavk6BMHxnW12lzGO32FVqlXV1sYgmPvcOUd8CuQE+VJYPkTUqs7y7KqYQBT84yUq4Xthsc6ZFzbBCumTFlKIo5rqd/VB245YYT2iz4UJLZPc8DivXr5gYHzuFw9dBwuZwgERY4uURpnHtgwmTyiZ/0q7bLR2fqLLgq/7xAFdZpcXWqjOp/88oPhDk53fQxIBJmJVqjPaD02NfofSuPgGmp8FyWlRPTmLPfDMtDQUxqKyh6+Ta91d41ThH+eWyHjVStFDzJrfCI9ofrCghKg39Wgw3egrM/XS3CRNnjmrEO6p9Dnw0rAJ/TbGPmzF4rv6eS6suFXHR0k309eqxIBQYU0OaZUZRAmOSx2hq7RzQaXivBXu0UateVkTuzVq0o5k7GpJiYnikjryKMO5tha469h2Fn7XfGY9A42ObWNX/4DyLSbqvhf6GUVNrz80P/QshpI/bZfQyZXbewsvvXjxWssu0RLNwZNZPITXIX5D9OuvOWTk8ty0aIPzlYZX8skAu+cjcKt6iQjK2LXKb/0hwKq8idJxce9pSRo6Be1gqYGk+d4mrOLE+woLImXbcue3PvDZK1lOgdNxKr1RKcWPsABFBYBhDQ6oSGn3ODD2ElD+c/3CUD4rLWBXTriguQALcTsxHfDycRtrAacUFJUlStbu+3IvE26NFx0xanihlA65vrDAK+SGBsj32ndS0Jg==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261009223027099003)(261026140227099003)(261022105027099003)(261022075727099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 ouPqeRZlgL30O/0qYKz6bVcmxd5eoD8W4wSj0NGt7Z8VPcRihLgG2DiUnLGjsfUU9dPNYU8FjHfdesAul+azUz0SMtvBbgopY7VWDLOGymgYGLcweqAA2PPtP/i6bfuh/huzA8Ckhj4y6n4wthPCWEWdKixddgE7tZk2DJHW1PkFHjCKuWWj97+GjaGZcTmVKhDklsLVlXdwACnE3ZgE1CBtt2G9lPMeW9JEeis7gVJqZ+ey3H3bwsGknosKFj5u8MctGQ1vqs1aajxq2asSwRSgF0AmwLAwOZ2GTfZLsZ/+z+3TDqiVU8MFp4HJC+r3jxVXmxpmTv2NFDqusfffoW7mn5TmzlBPwbO5r9zW39XhPF0yKUQOFl6ylWvShB+YAm6y1CGfp0gRnisTd15m6aXBusmdQX0XM+G3Bm2Y8KsUpfYdATzXKdH9jDkLEttE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:55:24.1086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc2ada9-ab8f-44fe-29e5-08df41c00e78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

