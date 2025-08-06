Return-Path: <linux-aspeed+bounces-1912-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C970FC87FD1
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 06:43:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxgk42fTYz30MY;
	Wed,  6 Aug 2025 16:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754462636;
	cv=pass; b=H6KgW9t2EzLq/borH1wyt0enGqXEx+u/sh/s6PQJNS9pdvMbYjXeHGWbQu1QrDLE2jZZzQUPma3dVofjRBNvkDgVqY5oApAqn7rIV0jMc0OcKe0BqfcW7pzjhTY0hZCnKxivcLC6YaKsKmn2MvGDfP8u+HMIQlYNgt1lDOk3gGavIIIW5daZpLnt6IwMvMWgsqP4kGHrEHyqJUClnm7CCNBsl07BKZrSiIAsLYUNv8M+vG0me0rqFzKbgLRqvO+9ZjBD+2A3zHtvn4CS3eQTgjetNi0ksKo7RSW12Gc3F9a8KrUJ+vSzso5wmKANXQK0ZP/lHZynuiC79w515lLEzw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754462636; c=relaxed/relaxed;
	bh=j9qS8qmweyJdhbfOQ9JuNidi4W4EoJkuex8Rr7qCSos=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovTErvCBzuAJq7q1pYs+4pd6Pvbl81V1LK3w40d7iYq25tveFNMGUDFv5SNZNEv1vHfg1HDaNYSbhePcNbBgV4rqSYDz1ccdxCVIMmzNxTls0q2EaHp3Rq1vJjeWb3h8FpLZDBH+LGLSCMSUlqYEwH/w/AMtdJw1qu6T4zUguoIcgJUfrLx3us6syfTpwK8wCyRDXjkmgAYCsfdcFGiKLz78PxgspXxkHZkPrtm7sNtUKYD/r/TZp7+t/QAB7PeyvurQtOS2tJtjZRsp79zHwbjXKU4a+BMcNes1e6YvEGh65uJCYndzm3Jidcijh4SMhQNbBYVMgWmzIQhnvohLXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=OG00aYe3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=OG00aYe3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxgk26DNMz2yLJ
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 16:43:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUPuQZ9Fm7MOQqV4jbNZ2jHfQ12PzkVIdjdZKKvAJCQVI161N8RPtsz/C7XnxOvCrqWAOltaDP1/6dws1K3rXwIr5FrYguEQuzr1q4BxcedpdHptIAXtt1/NF+CJq2j/TwSYrUY7D2WfO1we9Y8FlCWgDX4qu36IXawYA+OVpcQTowfzUcuDmQ8LSrW6t3aD1zC4KWc4Iwu15BpsW3bwcvnZ001Dd8gDV/eWqf/mUYfPGLPo11sNeEa/ktw8r1WFPE1mB/AbsFLHLY2+zb5Wpg5KED88+EK72q0gc3tGCgwELSGMunhPHwApRaPi5XY4BwVvf2JJFSERFo37qaESCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9qS8qmweyJdhbfOQ9JuNidi4W4EoJkuex8Rr7qCSos=;
 b=L3zpLod90kuULpAmfk6thBPC+OmG4+accKfHRX1sPDGaM94wctoTtHpVjsdQ2juVOECsm0Im7F6G2yA11Bs+oNQCLQgDEaQpyGXjJUx8aLklozFdLllH6WEOp8nSANgPk09E4KmWwzh22lOwvfD6Z5vyd31TId0cXAoYCU4n+BVeYdMi3kv2UNrKrUr/vCGVwsiNzwrLFlbAeXIM02udoGzzmDq/GSBNYBDCI0/F5DG9WpJn+tpU0eJYIl6/jNgYMRM64w5vAa8QCngmQ+JvChzsUgQN6/ggHj0Shp5yyzNcRI9Casx3v5qUc0rrwBY+iGZnqizlGr/cntChuEx5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9qS8qmweyJdhbfOQ9JuNidi4W4EoJkuex8Rr7qCSos=;
 b=OG00aYe3zXJNVRKsF7zH5LHJdPHaN8y1h46I0hcK0fb7mJrCMcL5Lb1OR5hNDkdgVEnGIizJ3O1AUwP4kkuZgX07wK5QfCujgt93/jdfkKriHGSOlergVHnDqlENe7fRkuy9kLhHpdyyk2nH8uKB1stooTxQgVG9vKuYdYpi4n56REWqF+GLgT5yf99Wk4ldsuT9f89qPJWA/AoZgUM+/68UKOPie4NFA1jd0a3vRO/AEo28DaubAebjy/uievK6bTTSVyby8eWSjQ1yXjup655GJ8uLN9EK8D0iBi+hr08lb2JNwXy1nHJIES+R4nqPlltcC9jW21QMDS/+XP3w9g==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by JH0PR06MB6510.apcprd06.prod.outlook.com (2603:1096:990:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 06:43:28 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 06:43:27 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Thread-Topic: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Thread-Index: AQHcBQGAHPbqy57A20e2dQZRkDylV7RTsVEAgAFsyGA=
Date: Wed, 6 Aug 2025 06:43:27 +0000
Message-ID:
 <OS8PR06MB7541C713096CA46636AECEE4F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com> <874iumgqar.ffs@tglx>
In-Reply-To: <874iumgqar.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|JH0PR06MB6510:EE_
x-ms-office365-filtering-correlation-id: 319f491f-a79f-4b08-de16-08ddd4b48cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q2xwguXXVllhtiQDhPGaPgW+lMisbHnOTPetENud8QJ79Z+L29QuNWVckrxh?=
 =?us-ascii?Q?RMJVRjbnOq5kNy9386uTJvpmjrl4P6oOx7eg/AkqBPaDgZOd9Vi0gBnwKDQT?=
 =?us-ascii?Q?7a+0B1LO93Byk6m2SOvHMValJNPfBeTxS8LJyOGITZNTG1GUwTPJ1roEyhvY?=
 =?us-ascii?Q?ZVAd1oUCvavbtzZFhiGHZhD8MMF8ryUc4EJxuwQssJLjDVUBZflvI/JZ5oJU?=
 =?us-ascii?Q?yEUHCIReLrRGFshl8/F5Wi8r5MCVJDEYcq6ElWvBpZHKu8r9yTdk6W2CiUUD?=
 =?us-ascii?Q?bHf18bfyqIn3ZxtCsHSTsU8VpqYAenJ80qRdhMuLWqQXBNYlG82YrrbQYC55?=
 =?us-ascii?Q?7Q5UtqU5CoHO+jfQtqZ6NyTt5AhnUAXqLR4SfINQTz3MBrQlfUH0S+DQe4fz?=
 =?us-ascii?Q?Vi6KnUIcD02OpjZzOMHNNGay8v921UGP+agoqkX/DwzOU9P7BP7A9/tmDpd2?=
 =?us-ascii?Q?VBU0NtqRK5037HH/+L+xyXBovBByeMxbst2b2uMXl8xnqbDGlVUrMSheiiH3?=
 =?us-ascii?Q?pNsN/toDItaPtSBKdn4blCxbxBltjE7raJIYlr0L2cTEFnTr6WEliSfjKxOk?=
 =?us-ascii?Q?7+0HAdgelqGtz2Psu2LEJiDzGVlpLiwLtE1gAaiANpKHbLFXMhpV7iOlw44k?=
 =?us-ascii?Q?4cS5kiHM1ecGUp8eWHEdGzSBU/6/Ht2F1S9wzCI60omYUL+JSwKYYOvYLfAq?=
 =?us-ascii?Q?xjLuma3s8mRgGYsqg7T/Eb3QUQsY7GdnjumFTNakA2j37hqf8xwufSJOf02P?=
 =?us-ascii?Q?SkxNPng0TJLoh9rcgEoZPUaM1ejIGFZ/G+UaujtiQZSHN4SmmTV2gYhaxUcl?=
 =?us-ascii?Q?XZUMlS4vXQ5gImYR+PSHxnR3wCbDdVyalx+UlAwVhFB8RIgm9HWWpEv4nq49?=
 =?us-ascii?Q?NcQoGHvV2FAfCSueM0+mORsKokvfkzvGYz8hYYQ/zwDBIZ77NGI2nQP+Gtv0?=
 =?us-ascii?Q?aZ8VZ1UcGTabxbcH6E/85hqacZvxGw/BVCoxDMjbM+3K+r1cedidSi/vCf5t?=
 =?us-ascii?Q?rQSWb2hgM4ploC+Z1WGq3iOKDs9+kqxDJXJScije8p2+fcIZ6a/Hk6wkadbQ?=
 =?us-ascii?Q?VcFo0vPItzLDA6PxuAKuSE7o2eXieckXIPtHQ5C1nH6OlzjowlQejsDaRbmz?=
 =?us-ascii?Q?tJ8F+iwhRcondumAlJXbhgYXP/5/YuPynGmTnGDno3bBJuRwEmiqMPJzrKlr?=
 =?us-ascii?Q?yenthDz5JMxkYpwqoZZpoTdoUzUKjARa8mnCabRgX0Pxj4KgwpuG8yXhLEfO?=
 =?us-ascii?Q?63z5Ha17Cmy2N8rzxXtB9Cb5fFyAt8fhhV7v4h1ZX3xC1fv7b1NXxx+MznJL?=
 =?us-ascii?Q?Xt2W12vhuaAAyPBhoUWqkVt+mYxM2ImVFQlUUSCFXfAFkDLCrmUwDB7aZ1NB?=
 =?us-ascii?Q?8nYcbqNm5JYwRC1k7n5XoMhD6M0fl4wMhLulu5ynjyIvm3Z2BtBrAogSBs8j?=
 =?us-ascii?Q?NP4nXC+p6RhnHLDkp+v5gIEf58JTXpB6YWqrNSSYvTqEQasPDcZ7kXO8SYrB?=
 =?us-ascii?Q?LuNmbVuhrd6QtA4xi6nZA3qPClWKhNP52zLV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1VZT/YP1cb9Bl35k7Z0eChItO8OwtdDDDwKYDOcSctOGp06/dyWEzeHftxBS?=
 =?us-ascii?Q?M5jnunZvAQTuqfx9UJCVVZPdvvGDGR0IXuj95+sdu2C2w7Ixt9K1YFvGGNRb?=
 =?us-ascii?Q?L48k44+G4EYNsTp+DpkA69My04uEAsWktA5hZROHuflZRhbDfOETK1IsJcJz?=
 =?us-ascii?Q?AbW4fYTqbhX4wRjTJYq2DScyxpfPdsL+6ZIsLddT3u3qAdfkdtKbkbQZ43nk?=
 =?us-ascii?Q?/LxMq1qTtNGppNGyWCXH8eYhCm2CmgBuzT56hMKBID7rOkBeXNNyg1YMfPWH?=
 =?us-ascii?Q?9zXW/JP2InLEnfpIUPNFjtrklOa65pCx7ALeDeiSNwYOvKO4c/BLeSkwy3VY?=
 =?us-ascii?Q?fJ0MlNZzW2zhzzNeBQwHHt7rJrbEmKebJrAFSmXCy9YAXi0g9GVyttxjFm4P?=
 =?us-ascii?Q?/imS0d4qQykMWkuAzNMTOZIPcVC41GkCRMrcBYeyHpFZoLJz+RF+DKlqCiQm?=
 =?us-ascii?Q?9uishv/YN8gNP0hVxq4VCWMGMLChnSVrzCh6RWfVJkKjWNV+4KlKGyfR4/8E?=
 =?us-ascii?Q?zzmXXeDTNuJfP8sj7mLz85Wsf5uMFVB595sJw2xadwa0w0sQaAgfre0wSDZF?=
 =?us-ascii?Q?3JPB3QRcnnStj33YqSiA0z9SyYrz+JgZFjP0gD1YEGEE++F+S+q1QFiq5E6s?=
 =?us-ascii?Q?CgNW65CJh9zALUNLm3bbgfVKFc2lFjwv0miXBDKUo5I+VxfmD+n0MSLNF1c8?=
 =?us-ascii?Q?VlbOvg659Y3wdwZZLA7rYqA4/YGK8MbLxm3SrVPJ4mB8j6tX2uIppi8TJy47?=
 =?us-ascii?Q?e4AnyNXLIdKtYGfc+lp1cBiLVV440ilV7AzvxEJkytn3Ro/9afUVLD0Q0G12?=
 =?us-ascii?Q?YqIewTv0bYDDqBaJiMZ53eyXK5abDc6dfZHsTmr+E+peHhP+iJ7ujdOuh0TE?=
 =?us-ascii?Q?IFFnH5FhyxbhKAtI33JhdamMVUTJWzoJh7JXkxL3baDFKl/HHOBbBE4Nyjdh?=
 =?us-ascii?Q?U8LZFMzx/0IjE5Bi0CDSprqj/l9S/OqNKv7zWWAYFC+ZgdwnqR5g0CNyIjdB?=
 =?us-ascii?Q?sO/RQGbXJw2Lty9ecTQ7MtzQs78uPPomWCwDx33PZsQBWVsB9xBjolLXKqyf?=
 =?us-ascii?Q?JJop2jT3vmUVCFnLBxzo/DPsBS0Np9x4GGpKdyNwd2dFnzdl434Cmu0UXEzZ?=
 =?us-ascii?Q?e258MZl00FrLpbmXczDvTzREd12Ip/6czULVCb46G7jBNLao6k/58pbPsw7h?=
 =?us-ascii?Q?gOqVCalLBvugNwWxiPSY6utZs5Wt4rp++6kvGbCnGGBTJPLJGwXf+NUwoPCT?=
 =?us-ascii?Q?to5Z1iOPwLyOZaCnpWXf6Pbmk1fKB4zNJfNhFeV7V8XOao728i06v9nr6bZg?=
 =?us-ascii?Q?xM/kn0DUVXZ1k+njFYxMQdiApFkh1qicBLx8Q1DD7MO86k97Y1uM8kQ1HclC?=
 =?us-ascii?Q?a3TfWR0T1HaXRna/Iu2jtdrkGbh3qco5i/0+aBl0x3KqrDBh36uS56eF1P/Y?=
 =?us-ascii?Q?JCXUe97EEVY1E1tDeBT4NL++FMiBMmDvHHJZoGk+WgYnKOrzE+xlSSIf5xXR?=
 =?us-ascii?Q?A8IFSyix30tJ1bajlzZWe09L+i2PpWZ1upF1hJieS8KbwNjJMD3Q6oZbqXiG?=
 =?us-ascii?Q?jUm58g68vU4GPM0ecLLl7A4fJFExfCuX5jL4cyq6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 319f491f-a79f-4b08-de16-08ddd4b48cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 06:43:27.6794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXZ2qBR01wzaQEY0n7o+6mI1b6uwNE4oRlQ3+da+zfdZqqL9Uai1eoATcuYm98d/OF9lyjxsV4rZcxci/uWn/qAgy+y/K53ggrtxcnPFkT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6510

> Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 S=
CU
> interrupt controllers
>=20
> On Mon, Aug 04 2025 at 13:34, Ryan Chen wrote:
> > +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
> > +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
> > +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
> > +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
> > +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)
>=20
> Let it stick out, you have 100 characters
Yes, will update to
#define ASPEED_AST2700_SCU_IC0_ENABLE   GENMASK(3, ASPEED_AST2700_SCU_IC0_S=
HIFT)
And another question, in original code define for AST2600, can I also modif=
y it in this patch?=20
or I should be another patch?
#define ASPEED_AST2600_SCU_IC1_ENABLE   \
        GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
>=20
> >  struct aspeed_scu_ic {
> >  	unsigned long irq_enable;
> >  	unsigned long irq_shift;
> >  	unsigned int num_irqs;
> >  	unsigned int reg;
> > +	unsigned int en_reg;
> > +	unsigned int sts_reg;
> > +	bool split_ier_isr;
>=20
> Please reformat this struct declaration according to:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct=
-de
> clarations-and-initializers

Will update struct aspeed_scu_ic to following.

struct aspeed_scu_ic {
        unsigned long           irq_enable;
        unsigned long           irq_shift;
        unsigned int            num_irqs;
        unsigned int            reg;
        unsigned int            en_reg;
        unsigned int            sts_reg;
        bool                    split_ier_isr;
        struct regmap           *scu;
        struct irq_domain       *irq_domain;
};
>=20
> >  	struct regmap *scu;
> >  	struct irq_domain *irq_domain;
> >  };
> > @@ -52,33 +83,51 @@ static void aspeed_scu_ic_irq_handler(struct
> irq_desc *desc)
> >  	unsigned long status;
> >  	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
> >  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > -	unsigned int mask =3D scu_ic->irq_enable <<
> ASPEED_SCU_IC_STATUS_SHIFT;
> > +	unsigned int mask;
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variab=
le-
> declarations

Will update by following.

struct aspeed_scu_ic *scu_ic;
struct irq_chip *chip;
unsigned long bit, enabled, max, status;
unsigned int sts, mask;

scu_ic =3D irq_desc_get_handler_data(desc);
chip =3D irq_desc_get_chip(desc);

>=20
> >  	chained_irq_enter(chip, desc);
> >
> > -	/*
> > -	 * The SCU IC has just one register to control its operation and read
> > -	 * status. The interrupt enable bits occupy the lower 16 bits of the
> > -	 * register, while the interrupt status bits occupy the upper 16 bits=
.
> > -	 * The status bit for a given interrupt is always 16 bits shifted fro=
m
> > -	 * the enable bit for the same interrupt.
> > -	 * Therefore, perform the IRQ operations in the enable bit space by
> > -	 * shifting the status down to get the mapping and then back up to
> > -	 * clear the bit.
> > -	 */
> > -	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
> > -	enabled =3D sts & scu_ic->irq_enable;
> > -	status =3D (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> > -
> > -	bit =3D scu_ic->irq_shift;
> > -	max =3D scu_ic->num_irqs + bit;
> > -
> > -	for_each_set_bit_from(bit, &status, max) {
> > -		generic_handle_domain_irq(scu_ic->irq_domain,
> > -					  bit - scu_ic->irq_shift);
> > -
> > -		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> > -				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> > +	if (scu_ic->split_ier_isr) {
> > +		mask =3D scu_ic->irq_enable;
> > +		regmap_read(scu_ic->scu, scu_ic->en_reg, &sts);
> > +		enabled =3D sts & scu_ic->irq_enable;
> > +		regmap_read(scu_ic->scu, scu_ic->sts_reg, &sts);
> > +		status =3D sts & enabled;
> > +
> > +		bit =3D scu_ic->irq_shift;
> > +		max =3D scu_ic->num_irqs + bit;
> > +
> > +		for_each_set_bit_from(bit, &status, max) {
> > +			generic_handle_domain_irq(scu_ic->irq_domain, bit -
> > +scu_ic->irq_shift);
> > +
> > +			regmap_write_bits(scu_ic->scu, scu_ic->sts_reg, mask, BIT(bit));
> > +		}
> > +	} else {
> > +		mask =3D scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
> > +		/*
> > +		 * The SCU IC has just one register to control its operation and rea=
d
> > +		 * status. The interrupt enable bits occupy the lower 16 bits of the
> > +		 * register, while the interrupt status bits occupy the upper 16 bit=
s.
> > +		 * The status bit for a given interrupt is always 16 bits shifted fr=
om
> > +		 * the enable bit for the same interrupt.
> > +		 * Therefore, perform the IRQ operations in the enable bit space by
> > +		 * shifting the status down to get the mapping and then back up to
> > +		 * clear the bit.
> > +		 */
> > +		regmap_read(scu_ic->scu, scu_ic->reg, &sts);
> > +		enabled =3D sts & scu_ic->irq_enable;
> > +		status =3D (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> > +
> > +		bit =3D scu_ic->irq_shift;
> > +		max =3D scu_ic->num_irqs + bit;
> > +
> > +		for_each_set_bit_from(bit, &status, max) {
> > +			generic_handle_domain_irq(scu_ic->irq_domain,
> > +						  bit - scu_ic->irq_shift);
> > +
> > +			regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> > +					  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> > +		}
>=20
> This is horrible, really. Either rework the code so that both chips can s=
hare it
> with minimal conditionals or provide seperate handlers. It's not rocket s=
cience.

Yes, I will update by separate handlers.

older
static struct irq_chip aspeed_scu_ic_chip =3D {
	.name			=3D "aspeed-scu-ic",
	.irq_mask		=3D aspeed_scu_ic_irq_mask,
	.irq_unmask		=3D aspeed_scu_ic_irq_unmask,
	.irq_set_affinity	=3D aspeed_scu_ic_irq_set_affinity,
};
Add new=20

static struct irq_chip ast2700_scu_ic_chip =3D {
	.name			=3D "aspeed-scu-ic",
	.irq_mask		=3D ast2700_scu_ic_irq_mask,
	.irq_unmask		=3D ast2700_scu_ic_irq_unmask,
	.irq_set_affinity	=3D ast2700_scu_ic_irq_set_affinity,
};

if (scu_ic->split_ier_isr)
    irq_set_chained_handler_and_data(irq, ast2700_scu_ic_irq_handler, scu_i=
c);
else
    irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,, scu_i=
c);

>=20
> >  	chained_irq_exit(chip, desc);
> > @@ -87,30 +136,42 @@ static void aspeed_scu_ic_irq_handler(struct
> > irq_desc *desc)
>=20
> >  static void aspeed_scu_ic_irq_mask(struct irq_data *data)  static
> > void aspeed_scu_ic_irq_unmask(struct irq_data *data)
>=20
> >  {
> >  	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
> >  	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
> > -	unsigned int mask =3D bit |
> > -		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> > -
> > -	/*
> > -	 * Status bits are cleared by writing 1. In order to prevent the unma=
sk
> > -	 * operation from clearing the status bits, they should be under the
> > -	 * mask and written with 0.
> > -	 */
> > -	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
> > +	unsigned int mask;
> > +
> > +	if (scu_ic->split_ier_isr) {
> > +		mask =3D bit;
> > +		regmap_update_bits(scu_ic->scu, scu_ic->en_reg, mask, bit);
> > +	} else {
> > +		mask =3D bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> > +
> > +		/*
> > +		 * Status bits are cleared by writing 1. In order to prevent the
> unmask
> > +		 * operation from clearing the status bits, they should be under the
> > +		 * mask and written with 0.
> > +		 */
> > +		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
> > +	}
>=20
> This also wants to be consolidated or seperated.
Yes, will do separated.
>=20
> >  }
> >
> > +static int __init aspeed_ast2700_scu_ic0_of_init(struct device_node *n=
ode,
> > +						 struct device_node *parent)
> > +{
> > +	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL)=
;
> > +
> > +	if (!scu_ic)
> > +		return -ENOMEM;
> > +
> > +	scu_ic->irq_enable =3D ASPEED_AST2700_SCU_IC0_ENABLE;
> > +	scu_ic->irq_shift =3D ASPEED_AST2700_SCU_IC0_SHIFT;
> > +	scu_ic->num_irqs =3D ASPEED_AST2700_SCU_IC0_NUM_IRQS;
> > +	scu_ic->split_ier_isr =3D true;
> > +	scu_ic->en_reg =3D ASPEED_AST2700_SCU_IC0_EN_REG;
> > +	scu_ic->sts_reg =3D ASPEED_AST2700_SCU_IC0_STS_REG;
> > +
> > +	return aspeed_scu_ic_of_init_common(scu_ic, node); }
> > +
> > +static int __init aspeed_ast2700_scu_ic1_of_init(struct device_node *n=
ode,
> > +						 struct device_node *parent)
> > +{
> > +	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL)=
;
> > +
> > +	if (!scu_ic)
> > +		return -ENOMEM;
> > +
> > +	scu_ic->irq_enable =3D ASPEED_AST2700_SCU_IC1_ENABLE;
> > +	scu_ic->irq_shift =3D ASPEED_AST2700_SCU_IC1_SHIFT;
> > +	scu_ic->num_irqs =3D ASPEED_AST2700_SCU_IC1_NUM_IRQS;
> > +	scu_ic->split_ier_isr =3D true;
> > +	scu_ic->en_reg =3D ASPEED_AST2700_SCU_IC1_EN_REG;
> > +	scu_ic->sts_reg =3D ASPEED_AST2700_SCU_IC1_STS_REG;
> > +
> > +	return aspeed_scu_ic_of_init_common(scu_ic, node); }
> > +
> > +static int __init aspeed_ast2700_scu_ic2_of_init(struct device_node *n=
ode,
> > +						 struct device_node *parent)
> > +{
> > +	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL)=
;
> > +
> > +	if (!scu_ic)
> > +		return -ENOMEM;
> > +
> > +	scu_ic->irq_enable =3D ASPEED_AST2700_SCU_IC2_ENABLE;
> > +	scu_ic->irq_shift =3D ASPEED_AST2700_SCU_IC2_SHIFT;
> > +	scu_ic->num_irqs =3D ASPEED_AST2700_SCU_IC2_NUM_IRQS;
> > +	scu_ic->split_ier_isr =3D true;
> > +	scu_ic->en_reg =3D ASPEED_AST2700_SCU_IC2_EN_REG;
> > +	scu_ic->sts_reg =3D ASPEED_AST2700_SCU_IC2_STS_REG;
> > +
> > +	return aspeed_scu_ic_of_init_common(scu_ic, node); }
> > +
> > +static int __init aspeed_ast2700_scu_ic3_of_init(struct device_node *n=
ode,
> > +						 struct device_node *parent)
> > +{
> > +	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL)=
;
> > +
> > +	if (!scu_ic)
> > +		return -ENOMEM;
> > +
> > +	scu_ic->irq_enable =3D ASPEED_AST2700_SCU_IC3_ENABLE;
> > +	scu_ic->irq_shift =3D ASPEED_AST2700_SCU_IC3_SHIFT;
> > +	scu_ic->num_irqs =3D ASPEED_AST2700_SCU_IC3_NUM_IRQS;
> > +	scu_ic->split_ier_isr =3D true;
> > +	scu_ic->en_reg =3D ASPEED_AST2700_SCU_IC3_EN_REG;
> > +	scu_ic->sts_reg =3D ASPEED_AST2700_SCU_IC3_STS_REG;
> > +
> > +	return aspeed_scu_ic_of_init_common(scu_ic, node); }
>=20
> You seriously have no better idea than this copy & pasta orgy?
>=20
> static struct scu_variant variants =3D {
> 	SCU("aspeed,ast2400-scu-ic", ......, whatever...),
>         ...
> 	SCU("aspeed,ast2700-scu-ic0", 0x1D0, 0x1D4, 0, GENMASK(3, 0),
>             4, whatever...),
>         ...
> 	SCU("aspeed,ast2700-scu-ic3", 0x10C, 0x108, 0, GENMASK(1, 0),
>             2, ......),
> } __initdata;
>=20
> static struct scu_variant *find_variant(struct device_node *node) {
>         for (int i =3D 0; i < ARRAY_SIZE(variant); i++) {
>         	if (!strcmp(variant[i].name, node->name))
>                 	return &variant[i];
> 	}
>         return NULL;
> }
>=20
> static int __init ast_scu_of_init(struct device_node *node, struct device=
_node
> *parent) {
>         struct variant *v =3D find_variant(node);
>=20
>         if (!v)
>           	...
>=20
>         scu_ic =3D kzalloc(...);
>         *scu_ic =3D v->scu;
>         ...
>=20
> You get the idea.
>=20
Thanks, I will do rework first, then add AST2700.=20

> This rework needs to come first and then you can add your new 2700 muck o=
n
> top.
>=20
> Thanks,
>=20
>         tglx

