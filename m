Return-Path: <linux-aspeed+bounces-4591-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FF9C53200
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 23:46:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9TWH2hmwz2yQG;
	Thu, 30 Jul 2026 09:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785305234;
	cv=pass; b=YGQv36RhW80Og7xDRnsf6r8sP/jSe/4O8fPoTPFPucSVNjq1wZRvz8nEx6ChSiqoUSF9ydOB5Is022KSBbGektPsCdbErW7de6gxx352ZUP7bRsKvTKcw5HcmPL75aN4IRuyGatItSNhgTWmd5hc+bdYip/vuQgoK09yIKnHLaJyEtJv3OCrPKb7ga5Zff/5A7Vh5n4Klw8ZsOqdrgucyPz9n+Mh5rcpmG9SLnS+0GSB/J1y5Ac766hiTqYmmxEdkiLeqCEWAx4LbgqcG+pMwWv/gGio1ckXzdJTqNpBEEhH3QPB3JHPCpi/b6idKtV+UWaDPLT5I1Kt2EiVfWkbtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785305234; c=relaxed/relaxed;
	bh=6P/AubE0czJ7eXAzcy6Adglc3QFhZgoMP5W2g7L/NHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9/mqpvAHRnySr+gVxJiVfdXXErMj3S1KfoKHwM9pqdZXrgHI0WAvU7aFyVAqayivMAmu0lub+TNOees7kUNxoEeyWwIrjehLSHVvc+g/gj3OIbU7mlh+xFFVYyqHZUN2VVT9O76vXX0A3uOzNUR0Y0HN66T9ogfBKfjYZa+hQGqGj+fWQWJrnWl1InZPVB8RKpJZYXEKtftchukI5yBMvM9WO3xN/k+EprIUfJvYjxTA/fs8YKKQa4IthACYQ+Ipj09RURKNjAnwJfjhGwxu4MXyfDyR08Cr0LKUmsbIk88phIm/NQRTF0Ic31IO/VIvtKRAIsGq/mAUj/8C7Rpwg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oTpxunew; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oTpxunew;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h920x5nfLz2xrL;
	Wed, 29 Jul 2026 16:07:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQs5mfNFtKSFHmrIQKL/su8Qmau8keEkRgQDsaKZcSeVcTy6JivMrZ58tAWA+Mh4zEz54wghMGWP4cl/r8+XgRdGMn4xIx5dgzWwZBVSxd1i+N74runkqMjYAfqSuTldR8on4SXLLUT1xyeaurVp2+nkE0T6xiYg+bGVaBLzlnm8R+4qTJfkrPr48tRpgGv0l0BoS1bECzcyFlIoqFeTa1xtf+JMmSCJAOAVl+xSoSNorem+RwDzsS2ZU6g2XeLADF0GIQFvwG599KPWK2Bllmmey9HB5WREjaJOnCf+72CXbomrCF0iW6dF9tRGBCXMwWtf/2FNhevzWjP2lLaA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P/AubE0czJ7eXAzcy6Adglc3QFhZgoMP5W2g7L/NHE=;
 b=y4VvwOG/8jOCtvQx4AyRShsD9Siy86PquNIcgdKxVOtAeAsUOLwCnyV9QS5k9HwHQbhvigFw6z1lbIq9E7XzpBcRXdBWo9GpbLXPZsc6HPgmPXQb98cLEH0XxEYEkTt62BVcAXcEDoXe8XZI+V/RWAJVCjE2wM6qw5SbyuWetQcs2XI0bcvQWwIt6dEgOG4INx62xwPYpLLRuSu4FBfcMHuCB1Xk6B74wBPvCXG16GEITLfAq1I2NfP8UVzUkELRP1hnXBWKnOorenqtGSEITx+16NEz6p0OU3/vtQzMcXcVoLm5Ez19MFvkrbcVr4+ueTlb8dnWAWuguPsusZIRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P/AubE0czJ7eXAzcy6Adglc3QFhZgoMP5W2g7L/NHE=;
 b=oTpxuneweYjDemBx51zL3YTj+wLbqffmuoMjciDywZSl/3it8gX9dzfOOgxitabUtPHXNGShaXpZEMjr0wS0lFum3YUV2xgcfiAjN2/c2KTwyQIogCTHz/rf0ezd+y5xuLZwiKTbDWUDWJtwDIBmRC3Mu9P1CisGvcp1CBx/cR1A5aMlNlqXKeGMc51xcUwcFeh6Ef83k4ihrbS5ROE/CLVhBLs2cAl2Le7x5P0xAaS+jRAKeANRY19ZxzqF2OHp2zXXvZnyrZpx6LZMwODHRe+F0hs8XRTpi0epLc2czC9tOCMk8Y7Bw3XGNzlfzq1UQa/SmN68nGaTgUAVNeRHNg==
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:47 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::21) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 06:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 06:06:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 23:06:33 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 23:06:31 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Rob Herring <robh@kernel.org>
CC: <andrew@codeconstruct.com.au>, <joel@jms.id.au>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Wed, 29 Jul 2026 15:06:09 +0900
Message-ID: <20260729060612.1085870-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728143952.GA2121505-robh@kernel.org>
References: <20260728085640.1001890-1-jackyhuang@nvidia.com> <20260728085640.1001890-3-jackyhuang@nvidia.com> <20260728143952.GA2121505-robh@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: a991c71d-9e3f-48d0-6a32-08deed379275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ykP/Wu8rkeDOeG5Yiousm+a7C7/UUM5LDteYNK5xTtSyoAltuNRIMNlKaTWgoxE0xCfv18RShSgCEM1N7rMrQxY/Dvp7J06s6PEFly6/2clwy7DB6rsx9uZJ3kb2Qb0mZsV2TAjtaj5T8HJIbm6YWJqPMI3gRbK0buaX1tkbL+PwT8sJnI3XI2Z+WhDaIqGIDNCTL/WXJNF1o7oJ0RSdAotbOsS+7D8UJQVl5o6ltMnt/0FbZbLzng3Oud0EX3vtshKmE/RbAxPzCQhPJgPSHtmkA6cmD8zzcR4HJ14ZXh6xuVVgXKlg2IL/TpyUoSZc9owIejKJq4p2mpprVu5lH+kSHMblFKF7AVoPSSQcpbSS+H5G5l4l0psBwmOmmb6zMpCtnHIDn6ota8ZNXwJGQAbZrEi6j/UrAv1dN1WjZOpSTFLzBFkGt6Igr7NyGaXuTuyEcdjPO4o2otTl8AqoqWQkMY7X+CFZX78Yrux7V9K/IIem4ZM6bgoXVSR2F3KozADh/sKwWBNd99CjKE6dNuJcv7y7MOuCchF/aoIOo/p+LHH40AVDl28RE9tn17fFLL7Hg9Yc+uEQqT30sNGtZgbjScaEz6UO+cnOGXJOezIFOW8nK0IZKgiO4tAMeBUjVjn/F2kqR9KFohUBiUoaYZsvJswlYnw7sLLuTio9DNfq18A6ecSTTJMZ3g4Hbdc8KUrVNf7Sa9pDQRf3zb5ZkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0yY6D+pEwEpJXkThawD67qzKKl5p3l1f0knDPA6e8U4LUQQiHdHaAbc54QbVlvA9uwRMubZBZmwRxzbvuoX6E/z5OVA3FJgqdlCQd03PztO5xWtE1h4avEZMDBo+n4USUIebBlhNBoqhHb3MwR5j0QH2xMmqby8scQByc2SaHOBiEHyDlnWeMv4eiFGM5z4T7HK7GSgsJLQ84KoQ+q/LJfSxT35OuPx8CnvML4D4PUMT525d1G+DfEKEPVS8sK0P+qtX/EZIRUzQVrnAADKFjC00+A6A1vKu8O5W9ZP0vyqFbpIFuGM0Re4qQsUpOiQIDLBdSqnNQ3mlL5osOf+lFoNuWT9Rad4CfJaEbYoRaggNAsBLg2iPR/hgvaIcM1sBgDyEh24FrwK6BVw1pXgnklP88mxgXBzMT9Bz0fAMUHvnHJoacNPVXOQN3cqJtXvy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:46.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a991c71d-9e3f-48d0-6a32-08deed379275
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

Hi Rob,

Thank you very much for the review.

On Tue, Jul 28, 2026 at 09:39:52AM -0500, Rob Herring wrote:
> > +				cp2112g: device@2 {
>
> This and other devices should have a compatible string and associated
> schema. The hub probably should too.

Will fix in v5.

> > +	flash@0 {
>
> Needs a compatible.

The flash@0 node augments the corresponding node defined in
aspeed-g6.dtsi, which already carries compatible = "jedec,spi-nor",
so the compatible is inherited. The same applies to the flash@0
under &spi2.

> > +		status = "okay";
>
> okay is the default, so not needed.

The flash@0 node in aspeed-g6.dtsi is status = "disabled", so the
board file needs status = "okay" to enable it.

Jacky

