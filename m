Return-Path: <linux-aspeed+bounces-3919-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD06F433D5
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 01:38:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fx0yw3nryz2yrZ;
	Thu, 16 Apr 2026 11:38:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776303512;
	cv=pass; b=e0GPQkarImt95+z9doNruxfI11Sn/+fKqoscu8zqkNCLStsKdUV111OsW79itdjsZI/f7w4IueZudzKMGM7SFM1sryUuL6284uh22qSeEZ+VoBiAlavW7+574M9WugMLtYNDayLS/PCtHDSZ5iuDS5CLsIGFBsD460+lGSKNluKgYYFMTXCQmkwWDQh6PqKDcV9qkrEgJpntxd0XQu0Vm4LJyVgDMGl6H7kJnYkOB51QaKDcI/4wBSXo/ciOzPp035Xu5YVvu71jk7x0tNbc0GdBlSzaBWqK6psKj2oo92r5lt7mOsnq7OO5+8D+wCDwht84g5CcGc1l8OOlsz7wWA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776303512; c=relaxed/relaxed;
	bh=xAwrcgiO10DZta9fhQhFWkMAy96vTIhE6EY8hzJ+tfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fI3tzg6h17w7CUfyDnKzMJEw3nknCja21lQBWQh1+sXEb5+kc1cmYqVxDtTf4AeIviS9R4hvfI/V9sUibFLL+TP4uEycXJR+VobOv5jGv50z7W3rCnjKRj2gEbjmvIV4LhZt85RfG4FNLSVMBZ0DCXsy2o5ppY5CUydlpTgsGu9EGXDyPZZnCsZYvjQPbUgypTCtfBi1mcm5/xL+6jiwDXxJnYS8KLejbLa9vLj+/PAa3MFytBedPKpNnlzuTOQ3DYBiFIfmCW7qU/aYHgv8csy/zm1AhX+Z465vfaPvn6CHkjaYd1ixfhsRtZEbFEA/3mSgLbSRBF4ffI0gW/CFCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=hTNhTC86; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=hTNhTC86;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fx0ys4QbBz2xTh;
	Thu, 16 Apr 2026 11:38:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzo5ShSkhnvq+TO97UCpyZUZlv4+gXwj07U2TaE+SWtWJCQ12no10Rwvqx3PZER1lPs0ycgYy05zDGkUy1rPyYQFmkabgvHcBAXp+1YiHpOEpIuuk0TMFHFvcAFAnzfbjQZT5Nj8i89yjRzNcz1OJjaCw9A0qCEAGDh8GJcba0pOMp6ZWU6XYzc3qz3Dn+ToK/COqJMhcIfEHOTSlHyEW5IoR2+RP+JDgAJZWp3vqXRSiBaaPUCWMcYJW7vV5qsUkCkowRwSod7Wac3Bz93lq7thUddztWXjueD4c/g4dPQczNncU080n5Heen1QISdrxg9GWLxTnWUrWDckeVtGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAwrcgiO10DZta9fhQhFWkMAy96vTIhE6EY8hzJ+tfs=;
 b=PrAM4WUwUr0Gis0Zw0GGFiTIr1YM1YbCG6zEz8FJKJCTnBU6/i4iyVrgWId+/4C5c0S1GcGbINWcO2RAh0HXdnjxANBuQyf04GaZhcbmnzLoEy7QjYWaKfDjCL7jPym62S9IMGd+3OCWLmDiws/fXYUbSbtpMCXg7MuFlLu7SGgPPyCBUOwg9+X/QZ11ra/qZaMZ8LrWVOjC+6V1UC5rPUIrXiJkNVD1E8HX/mOkUM7W6lWS0x+7XQMkd0Z2zSJIrFOYKzI3lc6B2GryRiE1xSO0crGY63yjfIyVu7hQX2hsg98spd4sJebr4QdwPeO8nAaJQ55J1CIUwSPBy2m7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAwrcgiO10DZta9fhQhFWkMAy96vTIhE6EY8hzJ+tfs=;
 b=hTNhTC86PWEnWUzByUUKOiVC9AdUtbFJcDYz8p628OlLZj9suETFS9q3F6wY/KWMdfyNK4tuaV23q5QgsHNp0Q4qOosiTJzur9SjfnCCNVWFBL7Vu/Uwy1IaJC1EBolBoGKll6gfJ1vD8kxmLKCsf/YJgkNSB7i3plJgCZ+vUOpvAzp8AAa4LSbLV/19PwoKI/vatOB0tUTTAx8sPhEF5iifPXJNdmwscP4gO5GAPkocxB/E+pgY06UrMYrUgxRuo5Aw/qRX1MJfRITcqMHjoDvFYgqi9wt5NI86ZGVPbcTZdhOdXSyWRKQcFOqzIxzYxOVJ2m9HIEhAvmdpAFtwJw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6995.apcprd06.prod.outlook.com (2603:1096:405:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:38:01 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 01:38:01 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, Andi
 Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
Thread-Topic: [PATCH v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
Thread-Index: AQHczJaxkaOKREqTYE6dA5SIQp13i7XgPUGAgACq5GA=
Date: Thu, 16 Apr 2026 01:38:01 +0000
Message-ID:
 <TY2PPF5CB9A1BE6FC06FB69A7CD16147CECF2232@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260415-upstream_i2c-v29-0-317c1a905ae1@aspeedtech.com>
 <20260415-upstream_i2c-v29-2-317c1a905ae1@aspeedtech.com>
 <20260415-unrushed-collected-562130070d8b@spud>
In-Reply-To: <20260415-unrushed-collected-562130070d8b@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6995:EE_
x-ms-office365-filtering-correlation-id: 875f47c7-cd7c-4746-6083-08de9b58cc2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Qt9pdbE9girxJoiZrS0rGzev/fusM0FEjwUunorjEMSjvTKkFvZOU2wDfsFEn6WaoaC7AhG2geGcxCOp1jsMU2SH00lNI/zJcpey46NGHQVJ+7AeJ4jpGFMpy4x8XWM4gx1QJd+ywHdJZr8ON7pcag3uKjhb5vHO5HMsPFGrywRg0EcWUUwLa1G6CsfgBmXiF/e9s1bSAbztBQJaxFwAn/faTRb/4gs5TfudSWhzkjVJznracW6KMYjN/8qkW6yg5emS0ZROFsV/7siOXuSc94FArSs6i6j1jQjugW0sHX+QBSn69QGB0rx+KGOn68xCMdTqLGgJIz+F7AZKmFLh7hwwY7KwEUjsBeKY696cKv75qUSEeDKl8HkNq4xAdsmcNLMwjBwbBMS9coufbi9Sh4eYpU0zs0sx9BfObEoZsVgY8rXAP/OzFLSMyHDhJLYvzzqWwazOK/k0QDhbubHOXieWnV4nrr5yH4vZnapSo1dacwQpP2pMA2gU0360QBjAI0/M9ImO80QcuL4sFumOms2IJ7YikIdncRR7i970C11nBpXpR9HKgPMV0g71B7Cyz5LHxikDKuhtfCYL+E0pZZGusYNujPuPwloBknR+V5+JL5TxLse+DXUDu+SfLTtvsoKK70Pf24nXLNritZB/w4vyjRU/eWKErJthSHbM1omS4ya+lev89ab0pvauOrXYxkjsRL280uQJKb0FyaE9KMpDNV2gd8ocLkpEt/uHvaMaTNkH6sKoS1JTzLiTgFG68FTF6OY4FA+i3U+P4gGoHKStG/FUN0ClO1YcEowcQAw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lKcb8SHiuPoYAg3ZVj9mEDY+VFxhfIjr14iqANk/ArD/Ceyxi5emwA87e3B/?=
 =?us-ascii?Q?jkAGLahhUgLGSpP+mPwWNDRNnXI+y//6P3AvOCIXty/yd+rvMnmnuPIQYP8d?=
 =?us-ascii?Q?NikIqeQYH1J5jwNXFPB4UYwSb1oCESOx0/xA/zHX+iIbN9x6NPJh2/V6HLog?=
 =?us-ascii?Q?YBjAZ30BHhsE1+lCy5LEmQYshZ+utKU6ynDBOQZqPEtEMmscRM5+/gVLxmIy?=
 =?us-ascii?Q?QNC6xVYwuLCFfCO0AuNidvKOduiq+5IWQyAeNSs8SO5LzK0dYJEu9/b8SEQw?=
 =?us-ascii?Q?fnw/YXlznBendBJjmU4QKyOwhx7P/G2X8N2yXaau3NyPpeXK4nGqrk4kcSiB?=
 =?us-ascii?Q?9Kev+hgr5V52ZRHpaj7FzXpHT6kfl58Fi7A+/wpsVOOahv7YMfapDzRwqarH?=
 =?us-ascii?Q?mqQEW1wyxwq3R/pyx0rlS9YmtkBRHkdxkhN9Egyul4uo6iKrUwq064KJI7z2?=
 =?us-ascii?Q?EN2Y6pGp0TM77LT6CD+Qe++3v+yqOAnwWUbhwtetpejzVl2yizmwQAj1/tkB?=
 =?us-ascii?Q?He6O/YWmPcVsAlUmaWARwKKEfM8SdAygjCp0nF2PjRXb03WgO5y3zcyvhARn?=
 =?us-ascii?Q?UQOgfK+STb0QlyEcy9CLzXlcvRotb1DX2ENo3biUCKQwdh4oJorJUPPlbEyZ?=
 =?us-ascii?Q?aXgubw5ZkL7vRXZf/ShRzkxNwV2n0TzjQbKnWjw99aez5GLXm2ksEMHsxG2L?=
 =?us-ascii?Q?Ks3ysbcpYY+zv7Jko4JGw8pwaFkmuM/4UK1GqUni6lQwqxqK8SIOm76F9gtq?=
 =?us-ascii?Q?rngMwCAbhlTYzzY68T8Q0LfG1OImMAZzC5k4ynub1KdljE+06taHNtMJE/O7?=
 =?us-ascii?Q?TM14tpDOR6c5seKljuFcsvBmTLQKBdFMHgb2NMq7mHfgmhXOaRzZBp5hXhhH?=
 =?us-ascii?Q?+XIxNqCQxfqYuOHBNhxhV6nORQ9acB/CmVong+UFOYPmvkoJIhf54RIqOZni?=
 =?us-ascii?Q?fjIEisxvbMqAqVQqWKw6tqw7jg8S75tqT62b00f02zNrTbdJSvKbyFEbztW7?=
 =?us-ascii?Q?ljS5UVks5jmmN5O11IytvTEdDeGe/IhUAf+KOhgsRMgyCZ2xPG9bB1Yu2SY7?=
 =?us-ascii?Q?pJ0eekH776/HJpM2bSuWxgunO8eINkCrnKyInturwmZUzEOX6o0WOkE5HrSw?=
 =?us-ascii?Q?3RqImrRgLaW/XOPhANcCoz0aVQlHjS/m7jZjfFxQ7UH7cxLxV5MJfGIsl36Y?=
 =?us-ascii?Q?xHp78ln9dFUSqkMZogSx00WgTJGX70R5bJVmwugq1UgU7Cn8OeE7zkhdU/L5?=
 =?us-ascii?Q?xKNRYKxfZhphJd/t4Ea76Yd+U1sQMfh+7oWkf4Is2rnOHmJdx2O+09Yc2uW2?=
 =?us-ascii?Q?65V3yO5bPknb+/kvNaOWVchbabibJ5jhSJFf0zYBF4mwbTvI64wgpJq/kIYy?=
 =?us-ascii?Q?BratQAdoUB7MA/LBl5wu9vK0edYhnABDR+aH7R2US0nWFtUelAgJAJICT4vc?=
 =?us-ascii?Q?4LNZQy2uzTEPh7WoyFOHmTwYf0JEUMtEWcT/GcWWdsRYdXzHpn5+K1BEg4W+?=
 =?us-ascii?Q?wB0enWKNfDNXu5b359c39AQAUZeBURIbYyIL6jKxBt4Ju0WvPHaO9ErXI5D5?=
 =?us-ascii?Q?aLOnoJNetDqK744XDWSKZtpNn4La1MfxqN/3nHjVwDk3Debbd7dTtpEHnm9Q?=
 =?us-ascii?Q?JX+ab3pidcYTCiTovk/HXMQoaJRq8cbk2CI40HyRuam78sPt+pSnWFKe3bhF?=
 =?us-ascii?Q?jav5gL7IslC6Kr4/GVKMuqxpZH7WgMNWQsP7Mn1nRxgZBmrmxuoT6jKCGHYl?=
 =?us-ascii?Q?34irAT6wMA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 875f47c7-cd7c-4746-6083-08de9b58cc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:38:01.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwP1SfYatdEIWmSE73Nc9LlPm/iWmELXgyzztyUdISHGpEXNeg1PPJZJ34yoWynl2GC1uPQtacZ0f+e+eeUpFzlSPBjde3fl4DSrcE7tbjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6995

> Subject: Re: [PATCH v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add glob=
al-regs
> properties
>=20
> On Wed, Apr 15, 2026 at 01:14:03PM +0800, Ryan Chen wrote:
> > Add the aspeed,global-regs phandle to reference the AST2600 global
> > registers syscon node, containing the SoC-common I2C register set.
> >
> > These properties apply only to the AST2600 binding. Legacy DTs remain
> > unchanged.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>=20
> I hate to do it to you on v29, but can you please explain what this
> "soc-common i2c register set" actually is/does in your commit message.

Thanks your review.
The common means this global register is common register have common
register control used by all i2c bus.
Such like register layout mode (new vs. legacy) and shared base clock divid=
ers.

> The patch seems fine, so with that
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
>=20
> > ---
> > Changes in v29:
> > - remove aspeed,enable-dma properties.
> >
> > Changes in v28:
> > - update commit message correspond with aspeed,enable-dma.
> > - remove aspeed,transfer-mode and add aspeed,enable-dma property and
> >   description.
> > - Fix aspeed,enable-dma description to reflect hardware capability rath=
er
> >   than software behavior
> >
> > Changes in v27:
> > - change aspeed,transfer-mode to aspeed,enable-dma.
> > ---
> >  Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > index de2c359037da..0c769efb76a5 100644
> > --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > @@ -37,6 +37,12 @@ properties:
> >    resets:
> >      maxItems: 1
> >
> > +  aspeed,global-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle reference to the i2c global syscon node, containing the
> > +      SoC-common i2c register set.
> > +
> >  required:
> >    - reg
> >    - compatible
> > @@ -59,4 +65,5 @@ examples:
> >          resets =3D <&syscon ASPEED_RESET_I2C>;
> >          clock-frequency =3D <100000>;
> >          interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +        aspeed,global-regs =3D <&i2c_global>;
> >      };
> >
> > --
> > 2.34.1
> >

