Return-Path: <linux-aspeed+bounces-1910-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4099C87FCA
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 05:29:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxf482jM0z3bkb;
	Wed,  6 Aug 2025 15:29:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754458168;
	cv=pass; b=HzdYiaDjsqWHZ39q9dEMhnAo4zJeSmQ6mN7XoRVguf52BfvKiIyUQvJ5BWpBiSDNO+pO38rSrGZbkHJhnP97zs6vUdOYMtDDTqSN1rkBbzHPgYYjD7LJskrErDYKALsnxBts21+H3gcG7YcDL8kVX24+mTh105EUv9efXFQWd+Cw4eN76XTXp2/6oGAIUC16bCEDnNdIXSvwHY85Czx4O382DDrzI9NW8Ar22gyoGXvzDZywKPzVVukhvkXIZbKiFfod12iBzb1fFuE1HqLGa26iCgR43ChC0p367BEIEIyCqR64WQWQHpqCAi4q1aD3L1gAZWdc/+5Hf6pSfxwLOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754458168; c=relaxed/relaxed;
	bh=4ajEWCkfkrNwFKGSlzfURYMOwPUkQHHFcwjKKSb4R6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/d45Z9Nj2jsLZWmoOBcYQXwBxnI7udsSDdzY6Es6JMnPpDSxGnlJ7RBefR2oBp2NQFrmmtTQJawFuLUIjGe9UH2nTta2kqMx1l0tLaHvb9WhC7yTw0YcPDGX9fZ+Qx35YNj4ASvh/CkjuCcyzToneVLfq1JX9TlAJXFKPZMq7g4fgg7VS8DEYDw9g0LA9lM6mg0xp1dU6JGt6/+Q7XNtYqSHsHeZJFq6Z1D25pthi1cZ1snjBJe+kgPYqTrEgVmAT/rXLsBunHZo7RmSh4SWmDfDLldkvjgxvxdrx/P8VFA/l0MnSiQTs26CuUPZ1GHfcZ3ZaUvhdz0lo1VXmjEjw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=AgwMTj+W; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=AgwMTj+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxf471vbRz2xck
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 15:29:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlPT5c7yoQZLTOqcBn6ADgOS/pYsPHNn7RCWfwpFoOMamugB2Wrru7z5T/MC6toNjPg4CZ12N2g0dU2crW3+YeWNlB6EjtR81J7Rz3hb2/xKxkI8t+B8zS8ibXWYp4MWPBEa5zZkXAK1XqdsgfK8fMaAFokO/YmT5PpEGvlhRYfrr0GpXL0VZoR47ns0kbiEbeS99A1BHmk99n651Q+5adP/bQvUkzKNGrTQhOtPw34DwDkzf8AJWEmFS7jjUV6vsHcCy8zMjiCO2RTVp6R2eXShBb7eyg/F0p8gQz1MDzJzW+dE2xBLg12ifVhx369W4KlAPvvxfl+LIvJ+P5MUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ajEWCkfkrNwFKGSlzfURYMOwPUkQHHFcwjKKSb4R6M=;
 b=WkYmej8WWEG3OlJk8qzgPMB0N+rX9PyEn/4mWgTGg0rlu8dZr8m1dVWGT8H2/jiI7yBmMHy/e7cj/VgQ+9/NAWPwd4NoULsnUW8heoNccJ9McmOfMAtQHziAM8+FsgwkirdWVLAMAvlXir4Dq+Sdli0fP28pP92Z7LyQaWqvvp2r2Y/+YnFQy8NAZipf0IqybYL4841zE3crYoqMj97dphiQl/eBXDYo0xfsMmNSPN2xtocIXa9YikJXME210kckOFp6ZlT1xoxkTU4t41ChxwWX5ZSwzsMqjGHbnMZuoLvmal7c1d4qfMz1hhBJtp6WZ8FV47ld59jAeX9BA4QPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ajEWCkfkrNwFKGSlzfURYMOwPUkQHHFcwjKKSb4R6M=;
 b=AgwMTj+WuAsCVFsuswNftgXJ1N4jZFtTDL8gRqWO76KZW6Fk2IvgpAjeQWyunRQvw0Js9XFcXQFoVLPG10GdAgLvETbEObM2MTmdJJeoVJFx3f2hT8qfV1sFtoMOfPrGnqitvikX3/c9BeY5fT2tupL+ahYksR2cO5btsiRnTzWPb4Rv2Ld8Day68NUyAk/U4tEnshPvMuSKDY6D3QyIYCmYIKE86yOLQ4r12m+uHHl1yL4ffpGU6HbBgTuHTY9bZIsgu51AquQZ06WvB49FCsWLVp1e85FDEhigMsAgY8EEywJi3r40GhNI5EGHpm9mGgUtsaKjdAk2+F0RigEHSw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SE1PPF675EC9542.apcprd06.prod.outlook.com (2603:1096:108:1::41b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 05:29:01 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 05:29:01 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, Mo Elbadry <elbadrym@google.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rom Lemarchand <romlem@google.com>, William
 Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>, "spuranik@nvidia.com"
	<spuranik@nvidia.com>
Subject: RE: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Thread-Topic: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Thread-Index: AQHb78lA+IAukcGqZkm+EFuCwOI247QpWPIAgCuzSYCAABGMgIAAJ8CA
Date: Wed, 6 Aug 2025 05:29:01 +0000
Message-ID:
 <OS8PR06MB75412CE3A7A3DB8E6D6A1A55F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
 <OS8PR06MB7541E7FCB367AE610EBBE121F249A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>
 <e53edafb-bfb0-45ab-8224-7b393af4e0ad@lunn.ch>
In-Reply-To: <e53edafb-bfb0-45ab-8224-7b393af4e0ad@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SE1PPF675EC9542:EE_
x-ms-office365-filtering-correlation-id: 5d22ba08-4f46-4871-82e5-08ddd4aa26c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eZ8bxxUaNkuUGIYN9NvEZozVokZR0EJ6nmRF9aj/N04hJ0bqypo7LUV3SNzE?=
 =?us-ascii?Q?DU5uB6yaO0iqE3BMkjnxvEpeflYS1o7Ckmf25T+7hfJNvH1Je5+6gS/ZcHo0?=
 =?us-ascii?Q?QcB1uQgB9K6WEypdIVE7/yvYEFBnNtUVuA1wp4v0+hxzMPeAVeJzTDrShTuQ?=
 =?us-ascii?Q?GqHVxc8FlqgSYqsjGN8gn6c1b7KwI8rBfipgNo+urW6h5foBI3b7A1xoN9gN?=
 =?us-ascii?Q?VljSUR56TfBG2vj7ALUo6zpM9hd9U7H6qTDrTGFexhxJ1O67q8/5DAOBiWYc?=
 =?us-ascii?Q?viEzcT9hYefLjJVAntpGxd48RPAeVGS78BENKRSToXVTdtiaGxoPFSa33BRo?=
 =?us-ascii?Q?k8/sbtmuu+YgF+uCK1m1IjESYlRyXhEFbztnlGUjnIWT2XL11baDnPXwHTkU?=
 =?us-ascii?Q?S/lPlINr7gOtX0IraTNHZ5oudT0t/9EzjMdtYPLqLIsYC5jvcJ72PWECr0qw?=
 =?us-ascii?Q?1ACCaFviNCLOmSsU77601XPS/pEcmfp5U4Ay5LNorH28AkQbYcaQu4MGwYrM?=
 =?us-ascii?Q?FZvJPeqHm7zxVeIh8Q5J8qsfiTtr0bV9PT4Lb0BOoWAuJDQPlsvnZf/WI5E9?=
 =?us-ascii?Q?YWx2XkVNycVCw1n9OwjII9ET9KejGCMDwXHNpGc/QMbA0VjgpF9rB8pZyNjq?=
 =?us-ascii?Q?5nlRmZhR7y3kmxzcjdhUYrqb2IpLhf+8oHTaKAGXkHPFP/Cbf9tFsz8nITaf?=
 =?us-ascii?Q?ZHs/4MlkrVtRr4LSXyFz35LtxkSvR/IP5DzxpdjZfqV7thtk5oMIsO9Tp9DR?=
 =?us-ascii?Q?6ONoOkWvb+uEGDeo8L6OMD7f2mWJlBtxEAQyJf4JwK/47p4kbYZmJtZySm8q?=
 =?us-ascii?Q?oXsCFbXgNOZaQLl1R0n3QcgP0Ab9+SQbapjCUFrHd77axex6Kp6vPEwiBzT7?=
 =?us-ascii?Q?P/2Z73tqaxtJx3nsRV1X774SsGcSPymWinFPGFHlmF78TKH5AV7KfJasf31P?=
 =?us-ascii?Q?aAflU2nKYnv199fzT5niafUZNNjBV3gYbI5Fz31E/88n3IXnmxKzdJI/Q/q9?=
 =?us-ascii?Q?W1IYEDRTkWKfeyE4iH6HzTXk3A8q89F4ExDD8mpkyveSlRDsEy7LY4g2X73a?=
 =?us-ascii?Q?TnrUMxYr5kNeXNw66OBeUpw+YKrjgqNephZDP8MAdekzJptvHt1rErpw7+mE?=
 =?us-ascii?Q?OfcUFikH0XBhLH01iImcGfYMPmZJ9acrTsdCFJEIQxv5wHkI1JXb7VgMCRDC?=
 =?us-ascii?Q?wQ0B+3HxUNsGnYc574Qh3COQXH6oc9TfmYZN+dFeoztzLxiSzSqMcfifo0/X?=
 =?us-ascii?Q?c04yu5XKDNudXus7c0ZuHHO8RNX91O4wCJPNt2LDZOTb6fds/Oll+Y9Trp2R?=
 =?us-ascii?Q?sFOZok/CW1JObv/XM9orrBwyMmn2/RolR96LOoVUqATTknP29Usk93WFRLem?=
 =?us-ascii?Q?QjxItV03vdR9o51y7pH8AFglB/MVvrViDK08PY0exjaIed5dNrbX/CL6hvbd?=
 =?us-ascii?Q?4V/PZPCyVj81f2+RY6RNqMI8+DtIF+lNznYhXBk9Fk8lehfAW0AWsg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gYSZV/MpOx9yxAvqCfMAsb68AEOP4CGY4EOJY28X7zwvyP9qA7OrAGprJVaY?=
 =?us-ascii?Q?keG3cXIwtasQwKteITJd5vXx+KMQVbAgYfVEwtQkkGx4jDqDKv6IN/BN216m?=
 =?us-ascii?Q?eEniymkleRw5b9lpvbJ5qFsOiBJcGgvP4UKrpt6iR41JCkjcyZ7aphHeXW1e?=
 =?us-ascii?Q?vb+s9LYeAjh1ZutFq7zXw6JIfpW9x6Dvz/IQhp7fI64QfRPM5LaV+nfDyOOa?=
 =?us-ascii?Q?L3uASrU/pW3aHlugaTBcQjXOlE825xjPUg48YTIsOv9B2ma04/23P2+KLWf+?=
 =?us-ascii?Q?weChezz++O2/iqpNV3c6+CzoyxGPzNVZYvr//nBRtQXGTJBeJim9zvi2+9e3?=
 =?us-ascii?Q?Q/oCe4vlji5x5H7r2qrdhhbVsfBFS9gYWTMDp7JQ/BhwIAvNPLkqoqMa1ROu?=
 =?us-ascii?Q?iL/znryUHj3tgl5tG9xZQ4uGnhjQpxdcsYzMc5F7w7jv0iSZdVfDyPt5Iz3/?=
 =?us-ascii?Q?PzL0T9Rl6g/ZUpnIEumDUciOs2S3UQyzJSwPEeCAWHFQhwgmyrcT8e3docbH?=
 =?us-ascii?Q?Q/OV6vwsg1h30SkimMBNKOC9RI7RGehJpOTZnlWAh12TWggr6D2dCZMarx2z?=
 =?us-ascii?Q?DNcJQb4DJhyeXj6xFbZXRTZRMNR6W0t6OwxIFomtSuG02U35r+bUp/DeKYRj?=
 =?us-ascii?Q?kbkVoJxgJKJVuUnNg+I6cJaIbbBt7NM5gB1E9V2aJiUWytuYJhbb3Q4JZ/sM?=
 =?us-ascii?Q?mcJMjLUzAT3S0SfBP7kc4qauMgt2qcJLPfuYkS1/QCC1s+C7HLazo6fLLoDr?=
 =?us-ascii?Q?FTlhPz6JzVqBfx79Fagt++0g/uQrccyBsgckk1Qvwsq7th0o6Ji+wXs6mKsf?=
 =?us-ascii?Q?WL7WfC6QAtP8PdFWMdW2up5sCqYXPlYndYcmjyY+YVwsuGHP5aW89mAIkZzZ?=
 =?us-ascii?Q?jVkIkMZa1qJboyWXTwwiYnikIIcUWnwBePcf6objrmpHwXuol76qNxtpP1lU?=
 =?us-ascii?Q?K5Mrmudp2euwWeoCb8xHeCvYKm5BahAtUjmTPhE2Mlhsalep7vqHK6hMZgFy?=
 =?us-ascii?Q?XPVSwq5RCrllVDWeP7PvGVnmD8BLHcffnGPiRvdNS43X7JlqKTdh426CFxVs?=
 =?us-ascii?Q?DABt0DFvf8mChMyfOJ5H58n6u/T9bxdpfTbivSHdwhGYl2HXPwTctjIi/7qL?=
 =?us-ascii?Q?HgiC3AgrDeQ7y1pGJZD3jpOiN5/wbgmyHsyZjH8KtscDsaqOyqyiEuynLPTQ?=
 =?us-ascii?Q?hQv1yjMBZQGF7S0sftoR3ZdxMVF1bVP6nWV89l+4QJn/lu/xvBa+eQi9Rouu?=
 =?us-ascii?Q?wiEfFR3jta+fZrYzNjO7UhgH6+sOsSA5Dq5JFfJzEUSO/f/5K/A09606umAJ?=
 =?us-ascii?Q?eSQMJoxVhx2Bp06T4SuGg7XeJqiWmUXUMGb+lz9GecAaAV9/xXfn3vcNcZLO?=
 =?us-ascii?Q?pMUimf3H/0pzeViL3qACgnruwUwnGICDJN/wA1u8iLxkq8/8fU9y+WvE3Tyu?=
 =?us-ascii?Q?2Itcb7sfaGXzH+K878bmMZ5kx5Md6Goar6ELBUS6Obt/dzw09iBVklsq6NsA?=
 =?us-ascii?Q?MLgD9VNP1kEoTEF9CDeQZt7Vz0d015ojSlwulkumdmhX5H1UetTk1zcP3FRx?=
 =?us-ascii?Q?3fQFWDUfQbN9QafCSa6AP6Zzv1TdRdcgroB5kxOE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d22ba08-4f46-4871-82e5-08ddd4aa26c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 05:29:01.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DP4oAwGRubtvf1MkEuHqb8U8Bypz/CrMlTy9SE70T+NJb9uFA4YpMKhj4MUZpiYwU+IxadZogKjhO8Rt/D0jJy2KignMj9wIAVAMqn+LUCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF675EC9542

> Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
>=20
> > > > +static const struct clk_div_table ast2700_rgmii_div_table[] =3D {
> > > > +     { 0x0, 4 },
> > > > +     { 0x1, 4 },
> > > > +     { 0x2, 6 },
> > > > +     { 0x3, 8 },
> > > > +     { 0x4, 10 },
> > > > +     { 0x5, 12 },
> > > > +     { 0x6, 14 },
> > > > +     { 0x7, 16 },
> > > > +     { 0 }
> > > > +};
>=20
> > > > +     DIVIDER_CLK(SCU1_CLK_RGMII, "rgmii", soc1_hpll,
> > > > +                 SCU1_CLK_SEL1, 25, 3, ast2700_rgmii_div_table),
>=20
>=20
> Historically, aspeed has got RGMII delays wrong. Could you confirm this h=
as
> nothing to do with the 2ns delay needed by RGMII.

It is nothing to do with this delay cell.
>=20
> What exactly is this clock used for? RGMII needs 2.5MHz, 25MHz and 125MHz=
,
> which none of these dividers seems to provide.

It is RGMII clk source for MAC controller.
The clock tree is hpll-> div -> mac rgmii, and MAC controller will generate=
 2.5, 25,
125Mhz depend on mode.=20

>=20
> 	Andrew

