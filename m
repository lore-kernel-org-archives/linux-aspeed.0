Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AE606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=itLivLbI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPdcl5qGyz2y8W;
	Wed, 11 Nov 2026 20:33:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794389623;
	cv=pass; b=ezwOzvg+TgQajpuOB1lypYhbHCSI5ypKYmGKSdOyXujIlIMRGktC+OGH1bu+2N+aoJCAByu6DkVdcYxNe8LciPG5rwBxWSzGYMk0EhsiSANLPhpx9zxaiP1Zh6K9khCimyGxVLB1sVg6RZRuYLZtaTA/T1ugzs6lwc2p3hi4hONsSJLwB5iGlhv+to5VXNV97jxEfBdwQqO57WEJGpBBsKG2qw0oIhudEuTzTMw14PXElpuYqkuI+1hYPE+DPCnHa2S8pAEbuJEYW019itg2T9bzeDzue3ZtmZ//gYYo1wfEFfMjoYE/ILpH3ztuC6YZ6FfKv8nQXTvux6/zLhQSOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794389623; c=relaxed/relaxed;
	bh=g4zrxnTD6clFQg6ZGzIK3ka00uJSjzYkFoU7/oubAgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7o23pf/Rif7qxzP6oR5ecY+ZJMUcdQxI8El7xvZwLH3VTX0oTDX5LfrfKOeDJOScxoyBztwdWTnmjPBArWaftPi8wecot3k5decMq1ceXngfbumZKNTBsf57JeZaB4v2sNUBJHy7AMlFrgTx0Vz8zQdoOn4IFwHDHEcljUvmWlmSeksgfrGWI9pYzcdg1Z61BOmq7njkgtuNaKaYZi6jb6QNdhKS2p1Q18Uz7cN1MQnCw/KU6ggVV6az1hp/sK05uux2prXSlVN7ZgKwhGJE2FnVwsuvTluUqJ4t6VzilRJTyHB0EjbDuIDQKtHoSlUhGoBD8JC9ceADbCnRgvnFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=itLivLbI; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=itLivLbI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPdcj5j8tz2xLq;
	Wed, 11 Nov 2026 20:33:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK5oAzxbnyD1dwaPQFJLEE9BKkkMfzRwRjUP5TRl94RJgq1whWftguO61Y2ZXeaxXItPI3h1D9qvN0L0g/KcpNNOiKsRHnt4R90fpudNQ8oGwLhweYXvK79EFFH7NG3vT6Doxzow/kqcQL6nkqqDZDjNQA5wJIfuO0P6dFxmvGV5cHHbrGmdSwe1zGMAPPWiaQJPIY0xPHzVuKHPmWFO27U74nPs2dGC2GVzSfVazKgwVMv5OvLCPZ1gQhiy+EXTg4kkvEnvvr6A6fM1CINU3abqcaNLo5UGetZjxxGo/E2tTNFbpl4Q26lxOp/ES1PuLzYLgw6kRjCR6eH5+Zrb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4zrxnTD6clFQg6ZGzIK3ka00uJSjzYkFoU7/oubAgw=;
 b=MRGTmFlH10qGBy7jJkM+FwuHi8RJLfyvcNErhqbYkW0grXsZFyYAxZS5dvfvZvi7Vm3GYADlN5jexGX1tRyGRla1tuzx6mcarir6A7WCV2apRg8Q0UHw+2ee4ASJrKF4qT36k4ejBW9eJX2uJTrGc1FaQTXaw/US5yyRTWizy1eLDNsEn+SrhxfdtJSC0sYeOE/VC+lERey1xT3Y1Ea73y1PhovwOgTVFlpgeNZJpnUn63NS0MsS7QOcCf441fYl8dBiTyuAFDZgBRilYkbqstTCED4qhi6qSv9im5QhSKd07ZZRjdDypaB1D8BKo1eUy+0S910MJA/KN1bdsTR1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4zrxnTD6clFQg6ZGzIK3ka00uJSjzYkFoU7/oubAgw=;
 b=itLivLbIwiJ4mO4iuZoTfYRJgFHjk6wLQ8tqqOyuNRmfEm1onGi36EbI1TV6FYcaGT9tdrGZfKJDWysrLaI7vHpvi4sKjDNw/3cuRjnjr5mlcD3D4Fim5dwrs2IvXQ0qhpWj/8XVqtT71EB16F5RJkBS6xaZP0X7KXSDrdJe/HJqdgi3ZICJNNqbE9iWbeqwuIb31mqvuMKeT7O1Cz8L4DnBrqoAZQaFoZP02qpjKTZR7AhmVofP8jiYjCuPPf2FDqKklwnGXQG9NeTpC6PaenD8OnTr/y1BDF84oxsnayFF2+s1AbdMzJ6nIe8x6QM+0d3Tn6M/aMleMOmYzsHXBw==
Received: from CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::27)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:33:09 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::31) by CH0P223CA0026.outlook.office365.com
 (2603:10b6:610:116::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:33:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 09:33:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 01:32:51 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 01:32:48 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>
CC: <joel@jms.id.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <ryan_chen@aspeedtech.com>,
	<billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Wed, 11 Nov 2026 17:32:28 +0800
Message-ID: <179438627442.2016371.12057101111349178921@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <91edc3ed1d65a6765530895c6574714bfd76b8d0.camel@codeconstruct.com.au>
References: <91edc3ed1d65a6765530895c6574714bfd76b8d0.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: ef72ffe8-f055-4f3e-ac28-08df3fd6cc0d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|23010399003|36860700016|10067099003|3023799007|261102123227099003|261021121427099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 nYMTzxO9VjxK6EdjaLe14ZFJFXDg7054NsBwIOSPy31MLTCJz1FcSvo/j0XflDIh3bvHGIH5w/bkZj4MS9HSNx05hca+oASrpD5/VqLgIs0ERD0VDvN8gJvkECyILsKXyXin5+7hF/2SBqftySCRS4E+Cg+2Ld/G+0yKWgwmmHJwWHfu/tUvp514/EXxa9htyXpP9UUHTwXgXoqMmLOjc5X5YoMYB/HxXnLcU4ajvq5fuNUVOgXCN6jtnpmXTNrfQr25aLscwm8GUPKCZzHoQ6MhqrMY1st5vApHbmaQfOJHvMAmfzscI+FWYJYnG6DHsuJeEP/I4TOKvM5E2sm9Js8+hB2OYb/L65gySsDJY4rQd08SPwsRtor2X3GX3kQv79B78Dpnyy3NJfu31ctNQtib/4EcuR25SXO3LgZyAiu1OxeyjNn+Q7F1g1MiyJVa4ChqDvHHePOJ+PQGb8rBvRIPzr19RW/1qoYkWJUI+cf8dixZ49eckGnziFYX33HJrT5ZPtEtqNy1TT/Mp2YXi9HRSZDgXiNiMtvqxFR7G1tZ22MFfKE+gJXZiiN57BFTtehvEiD704XWuHxQhDOiWlmpuqi5hDhStRDMsUSHzdSnYaGqvfNAMaYsfGrlhtM8RHF00ekKi/gtXZVvEadxeMLKHk19bovOqeIdYzXGCQIXZF+RhwwDYzio/ojsMGobXERuxX41Xhbc85iUgozEmA==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(23010399003)(36860700016)(10067099003)(3023799007)(261102123227099003)(261021121427099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 alv4sFMQKU8BqkccOrbhjuuAMj1LGYEuM+f099Ucq01Mak5QS2W4B/G4NCIBth+84+odMOh0H0hFl8qZz6rAmXwQXlTJ8UmML5gFgAzZX/uHrx2oHpj91hSxZUTSK7zHd896Nssb5Dl/NSV6cmPeixqACixucTC/1+3B+CumxLtATfXL8mkRuMmMEzjs7xzkdvTdhCY9w387WXhjEPQXGCutTfjYqOMr8FgPU4nBwiXXVm4ShU9vhg2qBYyPKX71vsCd+BtMjk+9B+WUyHmmDnZAYkRT2XwNM+tarTnDnvFjj0gBmW+R4Mcn5eU64WCd6zFjVWZZoGTFyHvfs/QbGQQ0b9BmBElfV8eDTiRO+xNaQM/ys6h42if4sNmztKt0/W1br+RAnFeHaa2nMse31CKR4nPbnXebkhBkp+CixHqRiQ9jjDR/x9TpM8Y6HKJn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:33:08.7495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef72ffe8-f055-4f3e-ac28-08df3fd6cc0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,=0D
=0D
Thanks for taking the time to review this.=0D
=0D
> Can you please expand the description of the platform? Why was it=0D
> designed and built? What's its purpose?=0D
=0D
The NVIDIA MGX Vera C2 is a Vera CPU-based server platform. I will=0D
expand the description in v3 to clarify its purpose.=0D
=0D
> I assume the -{I,O} suffixes refer to input or output. Are they necessary=
?=0D
=0D
Yes, the -I and -O suffixes indicate the intended GPIO direction and help=0D
distinguish inputs from outputs at a glance. This follows the same naming=0D
convention used on Facebook SanMiguel. The suffixes are not essential, and=
=0D
I would be happy to adjust the naming if it's preferred.=0D
=0D
Thanks,=0D
Jacky=0D

