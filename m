Return-Path: <linux-aspeed+bounces-4594-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D26BC55165
	for <linux-aspeed@archiver.kernel.org>; Fri, 31 Jul 2026 00:02:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB5p657Jzz2ykc;
	Fri, 31 Jul 2026 10:01:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785407142;
	cv=pass; b=WpA8kzXrNuMsdixJyPCURwZLR8g1kbeyu5RDMwHTJpVVD1mMYb8hICmcEcDcGQfCL60MeIxiIDiCzhz71VhUfgEGFLRQbwlt9zvlMCpV6PAg1Ya3VQvdztsDRSyPIONKhf3l0bWwDZVpJiX/BdPrIkp3Gb2s/0zLtMO/tRa2U5Ppw4v4/Xa/Kt5PgkgOw+/NPox+QJhn6TQ/6BjavYYAk0FGnmXQOjaQmuzcwRt6QwtBkTaiP9z/XAGXWvfBn0nl5yrI8WIffyq/4pnF37jf02rT4/7c5UHqOtYDe46WnsgCx9E7DNR3rINQmjvzBoCDEIQgP0F+N4zX4iHFoCoXnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785407142; c=relaxed/relaxed;
	bh=Vb9hWpPzLLmgPeOk6my/OoSrfoPIctJAyics1WhoyJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imtp4E67+aymIYjxGK6rBbxhXIenYp12+CvuaCiQKSVIfKVtArCU3qcKqgk9kQEmoERQc6ex6PVtCRMeO7TyQ7ZurIdKjjWgm7miidu+0IpJQRCRKyqPEZj0IVN7YwPhpCAUIgrxs2zuO/YFw1ozNkZMKkYBFsj6dbIvVqAkrvJYCqc9VtqWCjeM4mOzFH/7VzIMiDbT8UQjm+WPl79oYHng5ewyZu3jTdDSwhKrsBIYh++nait3Zp42TMbAXKSjB3Baa43GOYrrfp3WVcNlmZOAoeuJqCUt0xbxnla+RlQT1Te1i07XfPrPGR0WDrATpXvLIIXHgwSn3SgvSRsBAQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M9GTSvu0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M9GTSvu0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9lhg5hYmz2xRs;
	Thu, 30 Jul 2026 20:25:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF5OpiAAvebjxQx/Up6c6SRbI+MfOi/LjIi24t3htgUuemOvedDDBDdYjzdQaZnGWYQNoEnx41Jr1EmrmfGQ7CyXVY2yyV+ZwmcqGl6Ju5JlzVdwEfO/GgRX4VtA9nfacFnwQaX5jao8KturWnaMG60VzoP8fp+EnSVecViNlu5auOhbePdRC0IJNu1o1DQ8fdBL326QQSuBAXKi69i3OPCQT7X14VU5VDf0Hf20zQ4UMZHQQN5AP1ER9ef/e4Cecd0TzgxBmfuoeDwfZmVEB3NjLmggMy4QzUiQ+07LQ4eRd9hhBXz2cascJAyLpq4+9CK6eefgMd0JL+kg61kaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb9hWpPzLLmgPeOk6my/OoSrfoPIctJAyics1WhoyJ4=;
 b=rswGZtyGv1uuxa3BVwq/7VLuH+xmtqcMCcZICcrt+k5tJJUb3qS8uOld9dZzE5RjYHkzoXicNFQ+0m7m6M3MHX7kbN9WZbQkw0GrVogLjEfGRn+OM8otaPpYhv44qyKbwu/LyV+m3pDmZ8rnHSOqMH7Ug6iKaicclcVV0XI848gIBdwNeVntqFcQsSTvB9DYO9FYzedywvsJ8FgLIw4Ln73KMYpGEsU7u/jirIFv56iIISYyZ31oGs3Qte5M309pAd89IzLtAcHZspGuiuNA0DtAHbjXGpaLBPmUbLjPoskIIUuFBVDRPCQUPVf35wmOio5rICf28Hd1uF3tGmkyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb9hWpPzLLmgPeOk6my/OoSrfoPIctJAyics1WhoyJ4=;
 b=M9GTSvu05SKJdf/xuQTuH3lgHdZSa8GUKGdExlATqJdlT0M9n8c7MV0e63mooCFZRcs+gUwjXZBTSuEBwOYVs5GpJa/ns+N2+fq7pEQD4bQB8pYrc4RU+KtrdUZK7QiJNQ2sGqHAgGrg7LmL7n8p4+TF2RoPq2uzIR/tddoAHb7z8mFCBVUZnwVdH8wDWS/zmGQ17ghkqS37YWfDgBfAtNxmnb5e4CxBvPqyf84XDaoNAUrNJaUVYT1ejnLBTCd5xwNEJK28aAol1MTkEwNmRtGQxdZjdO1PDCLawzQ7SIiMSPXs6YR5Kmnc+mvxviu5c7CXd+rYiCWTU7LudplfVQ==
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 10:25:13 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:32e:cafe::f) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 10:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Thu, 30 Jul 2026 10:25:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 03:24:56 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 03:24:54 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Rob Herring <robh@kernel.org>
CC: <andrew@codeconstruct.com.au>, <joel@jms.id.au>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Thu, 30 Jul 2026 19:24:17 +0900
Message-ID: <20260730102419.1218311-1-jackyhuang@nvidia.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e59bb73-e7a5-4e2e-bf2a-08deee24d7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ych+SC6hLxTVsCSmrAZct084vLZaxFR+EhqY2S1JRLLi3747LxjYy6lWPE1VpH+FICjpmKzpico5r8XgviqWqn/IXJXBhvDkPjNFABqtO2JuGMgxxu4iP4b7bfgQmW5jK7EZSyR748C/PE3EUdcOaEJFrZtTJlv2lOhrY54ErpF1rI9tCHYJw0JgAwLu/HDZVv6/prZKYXyUM5d4iMW5kZOHmJa7eLrxruBWFzZUpIJmkHREsM81c/xP1PMIIoNcUaAgdxgk8G41wVqZuMit+WtU23yZYHo87eaxP5vfoeTL6MbXqwf9TA5vf9iRNcf0gC29hfsRLoewdIIB8XM0ZJDQwy/NeYsUj+mw0WxNTx7UTwrSCZzIT1NU/U8cOZGrSJuBaZ0IU2ivEc6rOvHb1e1W0/fzTXuCfDdbR/bunaHY2b5rIk8ScoBm6sK7WVoIydh+B86ahCxZyPlmYMMfWnRYxmiFJ9PbPhO0Sb2WBRwNdtCx/hlJDwgCwGZ+iKFoGafh3iJaowGleF3pFZYRAOgTzzhdW/Ywg/JUR+FWsp5orPT+7ykruO4ghfWFV+0KaDBPYywC6rvgj4bjVmU8B1glVPMtPYej0tloJ6pYo/a4llu/uqGr3SQopjxgkFwuiuxCvvmWOlilX7kcCFrs/Z8of4d3vQ7DaD5SWpgjrerSQk59p9O31BhSfey5W693+FKAHnEbRPH8AGMI+uF2yQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WRhlkwtUxSaGiHihRhQC9W/7mnHMUMAbIJzKG6D4oLtyLmDpUGGzeHn8mJ6s4LY2B0fP00fNzPkWwZ+yNMgqHxjZPXfWKFbruN9u2sAkQl5SNV0L509f8/mPpJM9b/iAPb0l9rtzQ6E/IKU+ep/fddtXuWJelo5naRQJ9npjG633fSoJPZ18o4Lo+mcuB8C0y5dsslldXfDo5SR84welLTHafooqpsFGxFYeEXKJhVwg5q8zbakyVxIxbJRl7rNg65382fuZpliaTrPOAbCXUkWV2frWlt6p8srCQEoHAleErTj193Kd7z3hseT5ult6wjgkXzg4Vm6wpZpVtnS9iOGsYWBXqWdk5h7ZeDzmWZnzMGZdLsj6VWrFnlkKFg+tHQcFV549RqXDsP5lFJDWDFYLiQU4Fv+2SvzR9OK9cdqMumpLM+N9cXxw/3ZlPwen
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 10:25:13.7331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e59bb73-e7a5-4e2e-bf2a-08deee24d7c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

Hi Rob,

On Wed, Jul 29, 2026 at 08:17:40AM -0500, Rob Herring wrote:
> Is the flash part of the SoC package? A board level component
> shouldn't be in the SoC .dtsi file. If there's some components that
> all/most boards happen to use, then those should be a common board
> .dtsi file.

No, it is not part of the AST2600 SoC package. It is a discrete SPI NOR
on the BMC module.

I agree a common board .dtsi would be the better structure. The nodes
are already in aspeed-g6.dtsi today and more than 28 AST2600 board files
extend them. I can help prepare that cleanup if it is wanted.

Thanks,
Jacky

