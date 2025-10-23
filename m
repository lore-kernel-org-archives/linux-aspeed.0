Return-Path: <linux-aspeed+bounces-2581-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED82CCD193
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 08:29:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csfNM67hcz3bd0;
	Thu, 23 Oct 2025 19:29:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761208195;
	cv=pass; b=GXg8fgTplLlFF/HKlppNOxKQKACdUljfNfYqfg9eGm9qZGf5Ope5u70MiE+eDnB6iftZ9/K81bg6eyi+O3rzAvZTTNjVxu/j/v1UOI2RuLwWqBxfozkGEXYXlkJ9Lq8N2xRKHTqWErZopuRvVIUuHR6PI9JsxdXW91zxetQp7pzYI6RbNALVWjufbvGU4wEiYrEO84BMHszIEI/GZZb3no37fSy0lmR3PkK7sGMzEP3BPY/5Jt9QGS2+oA5u8RmVq6Xsy0ke3JqHEJeA/69fIVTfBeUyGhgbmjv40NMPHMjXpGXfGluc9UbPMyXGqEA9TMAWacEXIOKj/1b6Lcfncw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761208195; c=relaxed/relaxed;
	bh=iLXj+X2nyyxuKXeHjDsw43Fi55PMCTIb2UDXTrS2poQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ATHvB+Bm4n/gDCDY43WO13XiShZtzrFXxcvNrD6/vHsp212qv8qZc1+JFzlvqxO+2/F11JL84pDeteP5RAZK0nCVwKsQAThrTWquKorBUr/sgIF79oTsmzGy72jdjNi7LFpvEKYL50CTk8Is2LG9O70Ail3E3jc0mvUs+AOnpvgKlaUSEh2QMiq1iBezoBmwpJZgb5deYFCQofLzuwark18pJNiajTs9qgLnhhQ+hk+W/jxWTzi39PW03a2Kqjlrnt/nfJnxg6lc07wcj90Prr4vBnWIVnF/SIxM6bdhL331kf7DwpJ31PIL8cLZHJZIgp8tzAIXOc48FdBsNiyAeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=EmT1uYpg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=EmT1uYpg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csfNL3r4cz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 19:29:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQSeIBn5N5odynob03swtvYUJqCzk+Wr4/0W87MkA/aUiO/S05B5+F7b+gEAVU3vnULMiGs/QA4uTUCl282OCLJYMND2Z+e1LGFIr2+fXOgP7qWfpyd8Phya84qCgf9YjQDnQuC1ktt6cvYi8r5vhTvEakKN4Lk612LCiEiDdy/GDI2s6v4KeQl+72JRyE3iYL+457AH8NLEWexMfEuv3NV1k2Hhsmht0ZGg2tjsoQe9yhYPk6zHRj1nYlw+BPIpHBBQwF22xlbvM7X06QVmzhkaTLoAYv9+5UykUSPLyRI8i/hmyFEa3VwVyZOcVMWKSw+J6cMOnRCM9WUjY/d88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLXj+X2nyyxuKXeHjDsw43Fi55PMCTIb2UDXTrS2poQ=;
 b=UDyx7Un9L2wW3qN4uzBx5E39eo5xnH5FyyM7J2L1fgEFkql009tLm2JKZyyIhy8zLNdjgg0HA3JgioHqalHtQEjxNn0xTEIL6AasutfBw2JICxVKosAiPC/Z1ZEsAyWrYMLdTYw/QqlI3tXXs/hSNWHZiJmv3G5Nr1KD+isRDP/Av3A7uk2pUgH+3YLT1JEM7uI0gKW1kCrkTKMe0YIKfawII1QuJmQYUpBfzg42UNXG4eAS9asd/J551/ns7M7bC7v/re4hsHFwBl8x3c9VZKiSi+e1mebJusN3BQAWgwtVDGzrF9fXMST5Q0qHAc2t2MTilqycXYSFqYjcqQJJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLXj+X2nyyxuKXeHjDsw43Fi55PMCTIb2UDXTrS2poQ=;
 b=EmT1uYpg4185MRSZzFtgMHj0B1ImcgKO/8lvTvBjzuqSuLb99eJ4pDsxoER6xbAZ2n2WzT1XoONyWhxV1+4gClNGRK3F8VFO6rR+n4XSbPKwj0DIjfwR/6oQm89JGDjIV3/6DQDQtaGOXGFeJR3C6Eqn6NUPtVAXvU6/Sa6Yx7qcq0hgrJLSwmVXsgza2Tw+k5Qy6thIsFgPAa+pschPgvbe1BwYHlnBf2Y10OthRumFSMXReUQcYpVNYcw6X8YIPp3tEA7d1hesohTawlj9LzlEjLC7klQnKpPS90mur0cdF+lGvGXPdQBbuVZMCPJxuoFR9byB2yTji+QHPJqPDQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SI2PR06MB5340.apcprd06.prod.outlook.com (2603:1096:4:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 08:29:30 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:29:29 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
 ast2700-intc0-ic and ast2700-intc1-ic
Thread-Topic: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
 ast2700-intc0-ic and ast2700-intc1-ic
Thread-Index: AQHcQyDSWW55133XQ0ux9XL7yULGOLTOYeUAgAEEmEA=
Date: Thu, 23 Oct 2025 08:29:29 +0000
Message-ID:
 <TY2PPF5CB9A1BE69A2BDA1BC2C78A7FFFCDF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-4-ryan_chen@aspeedtech.com> <87ecquyj5p.ffs@tglx>
In-Reply-To: <87ecquyj5p.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SI2PR06MB5340:EE_
x-ms-office365-filtering-correlation-id: 5b56b752-2574-4adc-2e5e-08de120e4917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J/ac8x460gn4WuLnhvotq1xq69MF+pjUlGTsZRxYbgMEiRbuv2it4cTfinRT?=
 =?us-ascii?Q?tOG+dIIilYjioNJ0JtwBnhqdtGj5ZgXtr2qTSaQTk9EsRPwGc65lX43Hin7/?=
 =?us-ascii?Q?SiY9y355N/8dIsT+HCMAAK06/az1OP9Q29PcI0fvTLtUGrYSRGPgK0M8UGlO?=
 =?us-ascii?Q?hGbjU6kxRPPizNh6n6E7DxRQ8zZcW3d2bGMZPgo+klRqyEqTwVYl/N7Uy3bf?=
 =?us-ascii?Q?hzUbjmB4MJL7S7VtT+T8aHESKbIw5vpmWkvdYm3LOWc3JmpF+onI8Q4rw1+h?=
 =?us-ascii?Q?wJzEar2GmN1BamRZlDCOp5ARz3pEwmgBVS2LIv7mbd8Qfp/ALXrih3h5i15i?=
 =?us-ascii?Q?LfriTkyDWYqtCmpgJ9EuyelnvLYMYbL+QftwC0+CCGyFo3G319UitAwLubZt?=
 =?us-ascii?Q?iPMTIa66F6PrUaM22xi09Fo7clYUxJ3siDtuV53usGCX/+bAH6xUN3XF2d3h?=
 =?us-ascii?Q?fQcqK7qjiI3JfHQ2pVlimkSpFs3W24nnHHY+YdyE53YxVKhxwtaqpAuzhyKN?=
 =?us-ascii?Q?lQXyL0FTnHY4PYIyPu06Rv7DGVEcs0E2L2aODFF8suEl7yNI8cNQiroH8rc3?=
 =?us-ascii?Q?9ucURkxf8ICyq6xmqtbX259VQkjGM0OM5igViAiMunun7ulEHs4swHqBsM3s?=
 =?us-ascii?Q?rtQQEUk8FRbM82Zs96FowTfOFaKn/OJa31UEY1qA73qmt5K9zxZJntlBk8ua?=
 =?us-ascii?Q?uhncCTvan/1TY4mzBRoRXMQMSd9B5gIZXsC2HqyyW/SMOuusgoCz3HUa9Oom?=
 =?us-ascii?Q?mQDi5Ucl83XSVKP6USuYFRrMUbeUtaGdCF7sDA6szywXNvowh5jMOdIynnfW?=
 =?us-ascii?Q?TTp+FMHTtVVnPEg2w3BcrSEQp5vdR6RZMr9oarrwr9sVqTd+Bm7hSBIunxl5?=
 =?us-ascii?Q?58QMT+4n0/zaY4fGANqdoEuLAYKVHZ6q5mxruu0DxUQz/3Gzm1p7Bm+bskip?=
 =?us-ascii?Q?oI05hwc2GCsEwMLAW7/0B4LQVsSsc+6Cc+LRtUvWq/ck+sFWuh99NGMu5o3e?=
 =?us-ascii?Q?iftDQn6AEyoX0bzOBahJG+gAe12pelAffoUTFayxhGtUPbkkjmba/nKf4f2T?=
 =?us-ascii?Q?MsFPGOoRys1KHNCaX0KBzVGnrLGP4BEyeMdCjFEGHZnaEJ2M21bAmFTk6TF/?=
 =?us-ascii?Q?dQTJdbUFeN1c0BvBhtJRzlTEOfLQzFBX94zDg2fJ6dTFZiu5pL9OPEGLv/Aq?=
 =?us-ascii?Q?W2LmYnJTM10LG5+bd0r1rwKJtVsv9wbpE8+xn6t7O78cVGZUOjuEQYpJkgyA?=
 =?us-ascii?Q?3XXigxQtuezRGV//BMdxepaY7tpho2ewLePXDYYDB/NEJ/yyapGVTtx/ETEE?=
 =?us-ascii?Q?eeVS2HBHwZOOjF3n11RBYcGhStDdkwcSzQEojDxIHVCRDoVM6qmOUJUK7B4N?=
 =?us-ascii?Q?iHYklX7etpJVabwAKgkmtgjdusKX6JH32sti4U5TbLK9K5wU63yEi3mZlkue?=
 =?us-ascii?Q?1oNlwzgD7QkhvbckD8F2ayleRCSSRI6K1YnwZ29WKKBXpbuijxPSrBcllkaQ?=
 =?us-ascii?Q?6G5if2am1hgaC0yLOECqUN6VgjrheawoxbzRvSaAGVsx46ZHLcuPoHHuRQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PCW684PiVcblFdXQovrPgb+OeXEsW6hWMk6DzbN4q5ZyqgrhO/SfwqF33Pvm?=
 =?us-ascii?Q?uXQVFKoYoiRQ8ATL7Ylk1E/QP8iKTyx7yHOcDWjdSyDamXn9cXom3FfG1qax?=
 =?us-ascii?Q?sIJ5ioHWaX1xEsxAPloN7jrts+MHHU29otMHhN/6SVGcVKGdIerMqd1Gnqmh?=
 =?us-ascii?Q?bl0jnBJGuz2MYpk24rl7pCocBHOiexfcYEAdY7pMH6C5X59wlGEtscQARJKH?=
 =?us-ascii?Q?3aEFN+XJvr2UVtS5jtXPEv3hlq4kmzGvD13l8CSgOhP7lms1K9itCZPocSWm?=
 =?us-ascii?Q?I6khqkvAGl6OHdqFQXYM+aEwG4iiyGNTRBJQ9gy/cgiqoB8Z5rO6PcCRM4c6?=
 =?us-ascii?Q?aApu0BpB9JAur73gz2Uusm28FWyN9gEBn+4AO1p/FkINUC8jOtk/K1rOIpU3?=
 =?us-ascii?Q?yTt5pb772VP4ya6xDYxGzMVI6hGG0m4dt4WTG18VgJaccwiMccKpp7SNGWBu?=
 =?us-ascii?Q?x0s+3SU+MyfWMBYIGaYu8ROzJCdayifu5kvO1J8nsY6ETFP6l0PsyIkAWPtH?=
 =?us-ascii?Q?44h82XuciowFS5i99Y/GjDmZK7V8HX/HCB9S3zMqdkKXdMcgSpzDa0jleVVs?=
 =?us-ascii?Q?OjBx/lwcEUMaoXmbFQVrgg1VM4pT1kGmL99xcEKd2Uk5DUQukp3vwvR0MXxK?=
 =?us-ascii?Q?b4s4lpTPZ4bzGLVr8sDguwsFaKfSauCVKYaTCLIkZhcIWR4yhRupfF/w8RHe?=
 =?us-ascii?Q?Yl7nSo09HM+MhZE5jPPfFcyHgXf5NoaSyKOE9w0SFReMuWkZ2GeX+wWaRhf0?=
 =?us-ascii?Q?1znSC2bgqcCEizmoRBOOsEGBLRpx4WhFlDWWt0UHVIswwTcJk0AM+JWgUVoo?=
 =?us-ascii?Q?YlLjj+8wds9SVtE/ei7m7qn7ijvoRWc9GLom4twAZDppVz2xWWWrpUbAz3ag?=
 =?us-ascii?Q?QJeAQENG3JDHhBOZkhF1D13+MVnPNK0HKB4/l4iZrW5QBNhksaj/7V4hrNRe?=
 =?us-ascii?Q?3BNTo4qLAr1eIUN6/SG96qrqV2gfxDEJetJLwHWTklTQsCP8QoceYt84UrdF?=
 =?us-ascii?Q?ASko6mpQ/R3+hz133NcvWWQsUhblW4dAcaQyRubbBFOoe3/Fhjw3KVnF2lFX?=
 =?us-ascii?Q?FmIVpUtzlwy2TS/oReyU7sQUpC+U86VO344z7K+YyHFPRmfLAP+qXEXBimgS?=
 =?us-ascii?Q?s8EuoQp9rr+2bD9geyGWo3ytZCVtSKwpWjF+KCd4ZMRs7lHY6UqGDJAhBSEb?=
 =?us-ascii?Q?iZ/rVPcjJ8hxM4pAUuTAGuz6I8iVoeFsEj7A5e/tbH+SM2FXdXk6SqO+47yj?=
 =?us-ascii?Q?b4/SJ+0CXDLHIh6TqiEsAqwuNyV+zwpz6U63QxJ9dR+vaEESgdAeSaCjSUxv?=
 =?us-ascii?Q?1dW1ERu25KQAfmHaF+/jxEYrXa1/HtK7VcZzkvU9eqlyrq9ORcWlWgMB9+6T?=
 =?us-ascii?Q?Xm1ix6MDdXC4O6Csj+PzbBbXe3K+m3cp8ard+FPZaPCzojPruEwutuqq8QZ8?=
 =?us-ascii?Q?TVqU+3hn9e2CzOL1l0hVlOF+DZLJoKg8vXCAzkoyJ71UUTvjPprbLNbl+1yM?=
 =?us-ascii?Q?ZRJjHvESBIhihPymsNovykIn7cEgJsGpYH0IKJGA2/Q8pGJstoQs9+OoQcYc?=
 =?us-ascii?Q?8C4VH0H/RRt8R2ikQMHgSpoRAHLW5tMlKi5uWYtM?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b56b752-2574-4adc-2e5e-08de120e4917
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 08:29:29.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VW+OoHH7VzsmibS1UIfqDS352bI1JnJhbkxgx2Vqt6344WBrVYxxgwIsHmrh+UXN4KVqeSeBKk2P/GWhjn5ahiObTkd/KgL0PtI8d3lerm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5340

> Subject: Re: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
> ast2700-intc0-ic and ast2700-intc1-ic
>=20
> On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:
>=20
> The subject prefix is: irqchip/aspeed-intc:
>=20
> It's documented how to make them:
>=20
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-=
su
> bject

Thanks, will fix.
>=20
> > The AST2700 SoC defines two parent interrupt controller blocks
> > (INTC0 and INTC1), each containing multiple interrupt-controller child
> > instances ("*-intc-ic"). The existing irqchip driver
> > (irq-aspeed-intc.c) currently only registers a single compatible
> > string: "aspeed,ast2700-intc-ic"
> >
> > To support device trees that describe the INTC0 and INTC1 hierarchy
> > more precisely, this patch adds two additional
>=20
> s/this patch adds/add/
will fix.
>=20
> git grep 'This patch' Documentation/process/
>=20
will fix.

> > compatible strings:
> >  - "aspeed,ast2700-intc0-ic"
> >  - "aspeed,ast2700-intc1-ic"
> >
> > Both map to the same initialization function
> > `aspeed_intc_ic_of_init()`.
>=20
> The backticks are pointless. Just write aspeed...init()

will fix.

Thanks a lot.
>=20
> Thanks,
>=20
>         tglx

