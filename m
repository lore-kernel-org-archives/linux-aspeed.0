Return-Path: <linux-aspeed+bounces-4338-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB43C43458
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Jul 2026 03:49:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs0B823kzz2yDs;
	Fri, 03 Jul 2026 13:49:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783049777;
	cv=pass; b=LjQkG/nhqNeCTCe8GaGwM/kXaQfEss4oelr8wP3Ay2Lgp0Q83VIVVfH66nXXKH12UcEDQFHPvBvGTZZbbBODafLJ6+CkqW303SD6nQcQ/LGE8NFWAdWA+FVvxCL73Yx+vcAMLH48UrX7qPE4dN3LyC3+9xk0zWo8Pjnsjcac+sthkPMjvDjV+VCP5Ln6kip6ADEj8mdfbJRk1ZqQ29dqoTrHx03RmX5Hr0xuid2sPYdTEWasD8bh3Y5NAPz8UVSNVOuaU21YYGG//llzFP48NQl/KrFtiAwYgAXlDlXUUPl+NM1w/ZtSsTkW02Ro4jJS4y18Xq/IpjJLzm+1LcySIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783049777; c=relaxed/relaxed;
	bh=oljSYm54xnsmUbPHme0Vamq4799ZBbCONZsK4olCCqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=havj6hVBHOomz19AGgaSQNcfGmol8Q7vJ19ndE+jcvjm+rGY4YQFrAN0LWI+7oiYli7y1ufxfO7zYJosl33ZHgFOQ6i0d8bQoc2cts0KJ1Z148nkcFV4lrhV1ti9XGpw0iudI9RMOlvOKAPxvhqmhIficP9D7udSA3VoAyvLHggYevMHiUkQCLUiw8KL5d4jn59/d9XLtOxZMy/q9875jWX57tJ3ZGryw2q0XmXbuo4ylAJU5njbYuBq7Stbk3yInPn4GcM+gRkio//irnBjrxVSy4PrecTsC/qe7s6p9tL8clVgMKNjWjtlCME14aD0imFWt3Em/tuRrKLuk1AKnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RGLchBdd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RGLchBdd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grztl0nXjz2yDs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 13:36:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqB8BFbD6eRplA64AxI+ggRHt1XMdYNfU8dQ76d7Ph7ikfjMSYO3hsIpGlXsfS0hj7iNwGrCJNhw0vSgB4Ep9pEtnSb0QbL6OHKpA8RojPMblV3qOcBeF9bFm44LHW7tFcfXOwTUKP74kqGxwjvLF2ghThVPT4FeSHgUlU7bWk6/Tv6CZOuiR3UUQkM74D1790v9xWlAFY58mcfGLWzRn4FnEv+mA1IDnweMJn1AI6j8bDEKnndhzXRZ8ZsFVDmZUYVJyfJYTuK/YC8C8KivK9hV6pVcXVHcoMDDVezglxWZkhxBpAOAI5ePw5krPXzMGVcVRdP+QYpOLEkEdivXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oljSYm54xnsmUbPHme0Vamq4799ZBbCONZsK4olCCqg=;
 b=NQ9FkHDYJTz3FsAk4FlFw2ezfOfeWN8gtIWX4ydhpxvbXxF4tz17z/nddanwCHs9v9YicrRY8hse3iCRo4e19ox4h1LGZ33QuFpEEu/wqRslF57Umqvn7NsLUVuNJlcLoCfJdtcARLjLw9+zFL/1YYuvVebLVjcDiZQPXiOuzcHMebTHqHnoh+IPP/yBPSg6O9XuT0AKuYe7/AcGoUciN3T2Yf2dr39SFYLe2M9dM3NMFsrtepamL5i5v8QYmIN25IG4o8lP/4lGoe14XKdv3PkRI1b6KCtzN3BRntEn979rAmkreStnQ1BwG/PUpxqhlRxnmb1O7PQ+36gUGzscyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oljSYm54xnsmUbPHme0Vamq4799ZBbCONZsK4olCCqg=;
 b=RGLchBddhMN0BkE7W0mP0K25loGeykIYc10vg4iKQ1pSbAkPrNGtAqsZyCyHU+kjAIdgsIbHiWToUXPjfex2YOOHskAdMiIA3wOvHaonUERNyaw3FARJRuY03TdGh/PFnZJnLwVKsH5Rx3mrMr5ev3oXsPTkxTIjDbwrxjQgB8vXw8+1muP7g6dyprUViXrmDrD2fUapbK/DDvoem/LxyL+i0K02B6v3KmIwrkANTtBQw7Ns6YoPd8oNXpx5pNhFOfv60Fb7OXnok7evEQm1Rj3hiys+4V+BF1StCdbP+tViva/ycN0iHc6y3QJbcDC4NehKm7+aFwCEV3drGPcvKA==
Received: from DS1PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:458::10)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 03:35:46 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:458:cafe::22) by DS1PR06CA0003.outlook.office365.com
 (2603:10b6:8:458::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 03:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 03:35:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 20:35:30 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 20:35:28 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jacky Huang <jackyhuang@nvidia.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Fri, 3 Jul 2026 12:31:23 +0900
Message-ID: <20260703033401.2195572-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c43899a8-3d6a-4c94-b0c2-33c00a830610@lunn.ch>
References: <20260702165524.2168091-1-jackyhuang@nvidia.com> <20260702165524.2168091-3-jackyhuang@nvidia.com> <c43899a8-3d6a-4c94-b0c2-33c00a830610@lunn.ch>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: d83ff7be-cf88-4cc0-26cd-08ded8b42b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TSlaOx36X/PLQ/YphRpY3Bbk4tw3ItCikDuuTzZW77YC+/7CQzd6MxlbQSaDmhGQtp8Eoh+nOl1n8YmPF3ZIxQBrRSXA/iOJF8+ohB/7wipVn687m66Zy3cRBEjMB48xcF0ZEOUBGhfUpBYgv3xmw9BfP2D4ggPevNWRkWMoHsejkzra7/dy2W03+LW/qwSfSCl1tiN7tc/xOFY4syr77uI4FTmb80StX2Gogm9BXoD5RLzti1k2oyTBuiiMSRbWzBufJJCzgIX0zXaV1RWgPH8TAWdp3KCnNgpd5yPVI/E7sBxn/y4N72Cv58tN1TuqkkQa7K55s59uR3SCUL8fHYjEQNE8hNBKe1wOQyQKb+FAkzF+dx29l3XCiIPuD6Q5Fl+3+Q3NQPak4Y5o1QE6RrMfjw6pAUCxFB283CMh04CooV3JA+II41qb0mEdA/4X5UNcazBRn8KuouzdJnIdToxcC0qGOzReMmjnoZr4jI5G9eOHFxpWKh7tm3JR5wFpEgYSVL2bEtEkWcWrh2/RhRFasj1IqD/Gu5COuAMNqtdjiCjQwitnxyar8aKqpu49oq5dMX9X6jTOO8q53mYykGSmIz7IOjO9tEdrHMMQEzCU38wZr8dCRBrqxKRxCL8AcxkKlTrhDT3rAiLkGwU5kjQ7aL7iptxRDiGLpurBrTg1OErITePhFSqHi9c4hN0ocC4kdmVQ3GXgcoTeCwbV2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Kkr5ewHeL3nVNKQe+7Xqs8iu0ntZQBJef914QrK9H3zQnLmZ+9P6d4gtSetAXE4u2ND57uhLHvhiPqkwMFFXi9tBOOze112ZbDx4Uv+9696RnTY/fftmOgPbZiLEt7MX+SaYgQSZtgmlsJ/N9R4EcFQES6vw2tQP1AtYFEnos3KTNkmLxNhW9XDTemNS8tAiT+wnwPVexwS8VqJtTQCdoL5+N/gOgrs7mx9LjIi6dwu5xxo8OcLv7/Hygk9cL7WE5JeRJSiqUpVzo/06RtPXKlujP7DvO0nR975yBnlHAHHWa6W0r9GOLqnm/nc6W0QCvn7lmkM2m24dIJs1LqcJimzxmvszJ9pDVPq1HNHcxMIhzmGecjizRl4UWVbt3E66ZtlqvQ3DgpoRXo5DSsq9It8ZHLeJtMjUvLekxkFxLDinWA/uzrTf32LGyNqSYan
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:35:45.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83ff7be-cf88-4cc0-26cd-08ded8b42b0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

On Thu, Jul 02, 2026 at 07:16:29PM +0200, Andrew Lunn wrote:
> No change required, just a comment. The strapping should not
> matter. All Linux PHY drivers should configure the PHY based on
> phy-mode, replacing the strapping settings. There have been cases
> where the strapping is wrong...

Good to know, thanks for the explanation.

> For these nodes only:
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks for the review and the Reviewed by, much appreciated.

Jacky

