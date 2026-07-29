Return-Path: <linux-aspeed+bounces-4589-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B57C54FCD
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 23:37:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9TJP0Z6Mz2yjm;
	Thu, 30 Jul 2026 09:37:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785314498;
	cv=pass; b=UcexYp90KD0pmA3KkTMTCIDuND98ZLKXtwwOilRF9A6P/8XEFnQdsSKKrUe4addSd1nnw+mOOmpek0n3qGBLXpYA9sIRbEv0Z/uBhVwEKGZnCtkXaW9ELRXjmJB3Hdq/BzC+2gSypCYDkFUbe4RBtMnOTsnzn88k0GJnjZSbdVrA8KEuguG5oS88tC4NsK+8YBHJ2T/XsWjEsr5MmhNuZ3OuT6mrMWiXBxg13oX1RhnjngxAV4vEjdxRAzPgicf6UA2NQIAMqZ/JjrY9H4vcRJn81zhoGE86v7YICeIA9qUhSNbhFzlqHgMzH08xxDUav6r9+NRsrrJ02mQb9ocmzw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785314498; c=relaxed/relaxed;
	bh=/lJf3d7yefXbRv1ItwNTno8xNC8U/G7XgSwMCvF1oZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggj6OT9SfwUnwTdW1NTGeCu085tKxn8+uuDLcRbciXe0tf0inbmoBbm2amRagw9lzK7VRGh37VLvQSj+yAalLckBhe+7b2GzFaOMeXVHQZd1a73UYY2e0SPhpDDISi3A0uzVQpU2xM0vCpASpz8NvpOEN24Ae9xGGHS4Oc3uZzMUc9CCXtp+tBB46vbSwNPEG3irgWcbSlkcmC8ZWDqPKF4RWaZbOz78cp/FXSyBkx9axjvWod92W4YaMCzlTK/ughY1x/CEvRV3197Ho+b1EGlv8yIV6B8CelDl1yXo+1Ml7ZpPxybBla1OXjvOQvVwQvB62N7arHRAUvUkrIeGhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t+fgq3Hn; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t+fgq3Hn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h95R16sQBz2xFc;
	Wed, 29 Jul 2026 18:41:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILpba5X9k2WVbFfmqmVN0UbgJBnU+ggmvB6J4prbVvtwsyuSJZiOJBrII6yRcZGYnI1OemYesxMe4YZfhi7dGht3DCSgo0LYmO50rBdi8+Uh4iEcQarfgyt0e+x6ZAwpaWchglRUgMJx0Fi1I+frtYsUZDn6Axw4e8YLJ1Gd3TE30iABeLxyIXrTd91wp/qHYLp856jddGwE0SKwB0NptXVgVp/Wsty6JNIQfXIaFXiBa0gqwxOnjknrt2UFtv2KMWTJFQ8Ndlo0sXLaXbUYck25wUENE3VP5fBBWmg8fJXt2tHb3/dS/KrfTvBST+AQ7xGMQxGZJ3SgcerZTieaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lJf3d7yefXbRv1ItwNTno8xNC8U/G7XgSwMCvF1oZc=;
 b=Byl/xjKuXhkff2fmf6vDFYK89XslkRSdwHO1nDHuqryCHlt4CWwDNhgL28xgYwom0ghvr3m70WPb0QUvWEQ7zgYPDBlRVprGe8kLec3fKvOtypF9pxWb80sg5v/8Ppr+ou8PU0ZnRs6Yu4KyRvOGkh0/aP2JIWx+SAFtvrP/b/KrVYFL8aAcubJDe8UDEy62jbkoqczzOfUTAYdsB6lWoXNx3ZljijmiCtxLIDK6o3bSzq9jo2MdeWgt2912rg8hIhj8G7z/NR7DAeRRwCRgsvXWj81cRuKz6qw0sEej0H+YVWlkqWThFFXwa/URc8TRIgMGx4luBpqh7Jp24idqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lJf3d7yefXbRv1ItwNTno8xNC8U/G7XgSwMCvF1oZc=;
 b=t+fgq3Hntp87phe05BbtGGyxGV36c4+jMl4RLnBLn+JEivaLO4uht0ldMI2qV0ohVAChOaoyhgsaZFB9xIeHTXajgvkqOpT8Bv5gZix26P9WsRSmgExEY83GPpBBq/Xi8LwqIgUewigdilW8pTHXAWMBy9nzgtZChZv6pkf77/GpiCmJyE1tqoNjMIzw2qYVclZ36ozDZkR+bIaDVWSeZsCOr5jZ5DVkQ+O5U8MilYXFfjFeFF2GwOOisBrMPUmxsz89WjqR0MffK9yIpfvqY5AwLlrgZTsMsM3RgjrdDlle6/JUBt97ycg+U8EtLH0aGL2NGacNbAS+RF/VXibCJg==
Received: from DS7P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::13) by
 CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:41:06 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:25b:cafe::5a) by DS7P221CA0002.outlook.office365.com
 (2603:10b6:8:25b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:41:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 01:40:50 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 01:40:48 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	<devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Wed, 29 Jul 2026 17:40:10 +0900
Message-ID: <20260729084013.1104891-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d8927b08-f743-4b1c-85ad-f64b9e5b326f@oss.qualcomm.com>
References: <20260728085640.1001890-1-jackyhuang@nvidia.com> <20260728085640.1001890-3-jackyhuang@nvidia.com> <20260728143952.GA2121505-robh@kernel.org> <20260729060612.1085870-1-jackyhuang@nvidia.com> <d8927b08-f743-4b1c-85ad-f64b9e5b326f@oss.qualcomm.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 892081d3-f478-4235-14f5-08deed4d211b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	aRmjXhZDhmmwvheFyCobVgsMVVxL+LPTtQ2LNOqhUSb8zNT3CEdby03LSocKXwNSA8hGWkmFpA/gaSFhF1007Ysejpq8q2GIQje9PFQIQcmKux++79FPI2WtWSv4fugiYc1qYFgCDLTgH27UBdgesas5OvWDbdNs0Qdikgyetikb3oeS8Qy8MYEkI5tr9nzISUUbYL4ERiGJy0YvLAuZi7cgApoOqLtk5gurAnkuMKp6hDg0YvuTiu7gz9FDYglMe8hgXCSnjBt7/RdEqJ87js/tftOYKO5EutJ4h6fnRLuD0eAb+B9KL5jCIMnbzeR/6d00Nhi7ipGzmWnZSuTbaYc0cEQqZx7IWbbjjAr6CpWqgkegDa9weJPs4/jmXYzIXQYmsQhimcXdcLrae51QMrE7ES1x4CqyK+qp3xWyzoz6AZIJKU9n1/KBmkaQJXr9FCvw2T454lwyfQgSqHRkIPBgy6j8YKRME5nw9RK6RkYeb3ngkzxojIxPnJQe11+7nuH1hhoGY9dv0uX67SYLMl4ojrVHbHpwoTIat3ZY5HAwj9yiwmpj54up2vT8DMNrtoWASvz/VPeah9HenbZ4FnR1ARqR6KDxSYENvVh81AHagsqQtpWQH5tMmBo+NJnHoA0j/RSL6eiYYFZaLQCfhDXW6iSYMzBTqb53nLeH5KD/Yf0wi8x7/kZQtDpjvqq11ZFTOl4RjnB9qQX1MQsHzg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l4zKcf7DYLy88mjIPZQqS6NzqaWxCQyrFMvIgwq0/wY5I9DcGy3Pbv34d7c9rc2nyJEDzSSUmP1oKytr5sA8lQ1vz3VHPp2uG/d/oQ9hxFwHDyghK479nLTdDHiGCHiQZNB41CnmKNdVKtuXpUykECiVQr+OyAFE7eOXcF7gUH/8RDD6bas5ZFFjinqm++Dm7OIfdlOk0K0J206W9GSFMA8cT4pqAzaxCgVPe6r6CRzj6wPaNi+1/osXjjqjFOvFv8E9LKm1IwDKLN4hEe/xhCwVMzSIczgvDWPj+3fv70jZD4wF9Z2l5oTMVVdYfAjJKjSsvgRSQxBz5ZTk/uos8dSnZT4k35zOiXsV2ZtOfPiE86zfhwI8gwvPv0zos+76JnP/zkMPAa0l6GxaHmkZt5jZry7x3U8/PDnJWwkwNgXhf6bqAkbp1FYUsLpts/JA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:41:05.5508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892081d3-f478-4235-14f5-08deed4d211b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

Hi Krzysztof,

On Wed, Jul 29, 2026 at 08:16:52AM +0200, Krzysztof Kozlowski wrote:
> Why are you extending existing nodes that way instead of phandle/label?
> You write confusing code, so that's why you have such comments.

Thank you for pointing this out. I agree that the current form is unclear.

For v5, I plan to add source labels to the existing flash nodes in
aspeed-g6.dtsi:

    fmc: spi@1e620000 {
            fmc_flash0: flash@0 {
                    ...
            };
    };

    spi2: spi@1e631000 {
            spi2_flash0: flash@0 {
                    ...
            };
    };

The board DTS will then reference them directly:

    &fmc_flash0 {
            ...
    };

    &spi2_flash0 {
            ...
    };

This should make the references to the existing nodes explicit.

Best,
Jacky

