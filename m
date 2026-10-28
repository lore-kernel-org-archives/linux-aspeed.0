Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D3606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HC/1a3aQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR21ZDQz2yfs;
	Thu, 29 Oct 2026 10:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793209049;
	cv=pass; b=cd+wBy4dnytuD/GiHuF7WwkQ7kQCQPJBHn/bQujsoHZjeAYRH8PsPDAJZnd7WuYFTEp6vlOa90MVJuxYVZV/ZBx+4slhgn6TTHAtTDrtD2W2RNi6EyPmW9g9QpVK35b40esXxOWtlMAKM3OLfiHxhlct51F4toTajC5FvCMRR7NN7Iv6OAG6RWuEImBuZF7E+177bSnxP4aaHnxhjDTJuTZ0SP8y1u51BfZMUGPZ+hiAWJDSDcVtYLJyMp4t++wDCwtQ4MmYzhM9de2SIvPVKZFjWSr8BzWDBuap0nApB+2JZBP4K5Z2PH/iCtMI0OmrMQ1NzxTMvui+X6hHPK492g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793209049; c=relaxed/relaxed;
	bh=jUrMZ9g+KcmkiTaE2dNgFrMNaEX911elCIXvWoH3AZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5EfJPeW+yMlNn+SFLF68Nb+B5+ubd2rbMeaknjLY62NclQp0eP8M8d/+YklzJiLs3usmFVABIVWFYYP8qWpkTz/ARrztyvB474TRmbWkTbCb30CgvBDmlF7D9kW4Q2wK+XDg+6oYV7Sm8aMojXRnRhhIjSORiY7jdPdGsPsi/xEPJT+7U6f+5hljclYk0QTOp6p6NxrBDl1YeB5fYCeh+M8lHUAB9IBf1Jeh3CcdwB6JY/OfUllq+qJAcH2zLUnzB5nOQJRi3nytUmEwXJOmv0rrucYliUjvdGCukXsfbype1xDmOLcjnt3lh6/91LNaoS3GvSWF2Ip5iMdzy58rw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HC/1a3aQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HC/1a3aQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFF1N0GMnz2yhP;
	Thu, 29 Oct 2026 04:37:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV1Zy52ij7VjWIhgbu5PB+3e9q1uSGqYrmB6NGg9V+KrYdjzlAY7v4pKrMbAFpC9u08WNdQ2TBlXj7UtZ5mtyPDH52iEqmaKbuaCmO1B9DU75MC9At8JycRFoS/h20e7lXaoJ302+QwHh5tJPXHT6TR9nQkn8Ymsl4+uf7jXqFBj3eLjaX2qu89npR0mNn2fa45UfoLZUtJyn/oCBMz15VyNh1CTpoqrl+BKwySlvP39gCKa4J30JdfRhq5VQCnkYOvOMxIOzPm7O5zdZdFGUFTiyNMgxC0+0GMv0zWoh+p3CleSdMtqGNiGm6ir+zKeglRBC5QHrb1d54zXkD6o1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUrMZ9g+KcmkiTaE2dNgFrMNaEX911elCIXvWoH3AZs=;
 b=XpqVcAAAKrkg33oOS+Rl/Mt+qGKOw7lx8xwayFzNCA/0MNfvqSJRMQOCQQnpx3Qn8HM4qAigeJqoPZJXYTcFZQulIi5Lg5S+y/X+lF9hbhdGJswUD7By/PueCl3pDxudwALluN//o/sPrXloygbfoA/RLK0kGkPiO7lrX6Sex/YwpBKIU0FL5ik02MeP7aF/xNh7YPoW65f7Qzkke/xAtzcd3vJmYOR2bM/VbREeYHZHMdhuUG41AePqUgOb0xfVQuHVj9ScCa53XdffAKFyBVfZqTHEb3vEN3WPq8HqAEHMp3vs/mgKz0/WaA5RLe9bH8GHYiUHmIXuZhATcGT0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUrMZ9g+KcmkiTaE2dNgFrMNaEX911elCIXvWoH3AZs=;
 b=HC/1a3aQHjgrnutd8sANWORhj75snfA25pDvyS6aXWc/cvYAX3dHg7NW2874ThHbZ8pZifgAkW0toeNC+uHnzY5xW5L5bFrz0XyxfVmObF8DZukEzHQvZoeIfMRX64RxWEyShTXrlsxJTMZn1UXcZPHcrhyliO8M2XAQd68wuNl/cpjtakahA4D1ChhJohlJBwmk2KkEsEBU/U72qf4iGJJktBvQcb0sNRmUKCQ7I9MwIe85Qb6GgTHL8wuXriuk2qwDAdN+RLj37JX4lIiqvlFyDl6xVoz4wMufJI5wXhlRuMeEVBJ+kIQg5KhrhO6CCq8FvJkxB1jFD3huN+iXPA==
Received: from CY5P221CA0144.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::8) by
 LV1PR12MB999280.namprd12.prod.outlook.com (2603:10b6:408:3f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:37:03 +0000
Received: from CY8PEPF00000055.namprd05.prod.outlook.com (2603:10b6:930:6a::4)
 by CY5P221CA0144.outlook.office365.com (2603:10b6:930:6a::8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22
 via Frontend Transport; Wed, 28 Oct 2026 17:37:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000055.mail.protection.outlook.com (10.167.247.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:37:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:43 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:41 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH v2 3/8] ARM: dts: aspeed: nvidia: Declare SPI NOR flashes on boards
Date: Thu, 29 Oct 2026 02:36:10 +0900
Message-ID: <2888c855c196666424fb225043b685e0b3b65f6b.1793179064.git.jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793179064.git.jackyhuang@nvidia.com>
References: <cover.1793179064.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000055:EE_|LV1PR12MB999280:EE_
X-MS-Office365-Filtering-Correlation-Id: 9735acc4-11c4-4bbe-ef74-08df351a13bd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|23010399003|82310400026|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 vStHsNdeM74+k9sj3NafybQrJT86msHT2e4q/2QmlaCMdBqUCrizP3aN149/2n3Gba16TMU1SIXUTuvvVRF/xhgvcUCsoHugd+fk8BRkezvqEInTThOgJgiwNY5yYiJNk/0e40GvI2Fb9qVwRFNK/wd74oGi2bEPGJQbjh1NOJNmUQLVR3nSsX3fvzStaBZSFf7tparw7ShwsmACHGBs6vVmVIwhnJEPTmHUanAGY1PLWPojXA2Zw/epdem7TUurRva5RjuSQ/VcbLqeDjHmf6puq9U49kTomgVfveO3OABGsRitT2vy3mtlXRrbpmc7YhcGT11t3w+MLdK57p18ETrlYg25to3TtYtt3AtrTkfMBxJqkPm6gaseEy4O/vq3ZquebIp2QyT4X4/zfIaRDTZPHCYNPArbycsfh4nRGCzx2X6cP8Xss1EVM2/wfM2CBpOFfJhhGw8Mq16PnzsVAE4iQGf1GWY7jP3XjRztyyCB+QFp0m0NHFcS9aA7YDS9VFaMoYG9zV0WZuUkzp4/3TUMwM8sPfmm/IP/3BuCW5GK53RGxJCLlV+rdZ4DSAWf4EldwIj530SR5ZvqszlYWxVMDKYiTV90+t9q8/G7+Tcj1GN/CaFNqxrZWuc8aTnT4Y4WvUf5yf/LqsenM2NKTHvzGKKIGy1D8Qzapt+JpfgPWAcQft8p8wTwOJqFWPudxd3S/nm33k3rnyly24b8fw==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 PmF9qtwCqCGHS7C6VPhZ3vmwkJtqjocpw07timNGwGDY6XNgCAuIJycchAY1pHj6f0Zadp9OWEvEWeR3j0dX2KYftHsU+tbdwjtZUvt5ixRc10pByvCwP7sF01mRhee2Rd/YLGZyX+2a4o/BV28O50x6EkldzDJNZWwh/lePfn78iLNmU3yFEb5M/GHFCrnfXdkkd+UDTFy+bIQvUDowloEddYa+kSN/SwozvB6+pHe10oIEvOKx5Xa87mpY/QCX3XpoSZpZNYSByoSj4WqBvbJ+z5GKVlcOMc8aSg8LWsL2OAJzPmerVU/spxdKUu83PvpM0nUlcIrfbJwAzH8a96f327kdO/TIOFP2MV/ZBACkyr3gh96GkKFJDjw2nqOZwZ+QYL5447QgdcBrtdBxwmDdFaITCNejrBKOwRT39USmBTCY8b4H9CbayjBH8iQa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:37:02.5139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9735acc4-11c4-4bbe-ef74-08df351a13bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000055.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999280
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 5 +++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index 4de38613b..c8788c67d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -145,8 +145,10 @@ &fmc {
 	flash@0 {
 		status = "okay";
 		compatible = "jedec,spi-nor";
+		reg = <0>;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -180,9 +182,12 @@ &spi2 {
 
 	// Data SPI is 64MB in size
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		label = "config";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
index 29f56176e..022876472 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -56,17 +56,22 @@ &fmc {
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
+		reg = <0>;
 		label = "bmc";
 		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 		#include "openbmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
 		compatible = "jedec,spi-nor";
+		reg = <1>;
 		label = "alt-bmc";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		status = "okay";
+		spi-max-frequency = <50000000>;
 		#include "openbmc-flash-layout-128-alt.dtsi"
 	};
 };
-- 
2.43.0


