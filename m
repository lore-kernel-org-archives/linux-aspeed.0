Return-Path: <linux-aspeed+bounces-847-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DE9C021A4
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Feb 2025 05:26:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2jdS3bvdz30Yb;
	Wed, 26 Feb 2025 16:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740547612;
	cv=pass; b=YGyMTGn8+wsRM+FyJeN4sDxpGA2manorhl3ieEUZjJ0OXex/JgqeqgqAaxNZcaaOVnK1nVoXWrQQJ81jkuV/ZUjX+2CuP9W9qTzpx2g5yshkoX/78gmLpYr+iXJbDx9721rvgdY3UbqIPkH5uAZsLO8floMZjbJoVjFspBnfQ6Zlk3GnTJrlOQRn7oDL/LyejPm9U6D8h7oq4vGRmj4AvFIKjirMUV9l2GPnv8wSX4DdIgSax7ilUI25gJD0PJiSen1UJL0luSNF6fIKXYvIBhfddg3FkHWJqfhL3Qakr7mTmQ8zgQ9vNVvBZkOeqJA8gzafOJLGe+Hh9MbS/x7HaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740547612; c=relaxed/relaxed;
	bh=5sGHqXpfX9085nzqCYKci0b1bzzMn/KeHbQUGfBcgms=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0oip+8F4woyb2z31Dw653giMfix5AIWwSgukwHkOcoCH8CfzITb6NxB14q0dAnyqZKBvgoM9RRw1A3uXIAdbvgByUi9mVTatM/Me16JgIjNzMt6tQIIyIMFYqRFhr3D7zbIAkMuq4PLnjJFnSImcpIVgGvtCuxd6IFbo9DDcCAzVy1+IMirojDFowPkB1KZXiQdz25BxPZ0THH8zzdx7VRgaKBecw4yQ6SjtpRt9kaqjXlmK0MUwRXozSOQA2yPxVi25LiceOPtmGWt8jCCT4ifYi1v0SnJjVPeb5gpKAaCMPcAmpFMwEAQfjZPnVjmzE7bnpHdbNtpiCW9ZXN9Hg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:200f::70f; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::70f; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::70f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2jdH5KT2z30WY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 16:26:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hbuk0MzE/O982AHC9XHrNtZpHAntFP2ZoYZHeCCDRxn4tBZQrnEK/7ZQ8wsnoh6DcguKj34Za9Dws8dGrYCtxvetEtU+PIi6lnrmQ0ioj4pmAe72lB4ymHKiQkgilqM7gpdMmJkuCvFTpMSHu8GsiOaan+9ZDwd7Fpn/yN7AlOVeVrrWod18SuHZYl0AgNxGuKtRA+O7GdDUWN8IE0er4DHDkKOx/rTtsHMrwV5W/+h1LM2KAev7J4Kggrvrq322MTR/fhBqPru1iA1P7AZuU/hKX1br7AVgTjaSVJfnEATemR0zMcYBR3V4hwpel+oQPfx+PmGTRL6qr658Ac9lMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sGHqXpfX9085nzqCYKci0b1bzzMn/KeHbQUGfBcgms=;
 b=w5MyqrefuPY/V2lhNdiqgjufKoLpvGU8B29044kmXKgC4rMX08ZiwHkj3T4SjjEz8e3NIfgr0CO8BdAUZH2r8QuChsBGwxPs+noGVPCgZgDIN6TtgFFb5wmDYdd8TkjQE2TkWaJt1JK//NO31kfK5pcmbEBbFdUc+bc+2zkq7ZlRWFT36+9LXnuLsC3oGKAtm6xWm8dMqV4sI3V9uqtF9IV4L40+9lBZo75FIsE+0utzaX2wDopCP5KzlR0fFUU6FxFiPlkSmGLWcXnMYip7Q5zGTxtmhJC+feQ9jkO/Db85bxrv/Vd/FQkNsMyCHpxAM3Birw0I1YrZa25bdaUtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sGHqXpfX9085nzqCYKci0b1bzzMn/KeHbQUGfBcgms=;
 b=FuY/HUdBqrvHil6zTjWsX3HuDbYU/Py19K+F7ArHdk4O9GYk9K6EBlBpN1PoCng10ZdJKDDqBdt2akxzg/EmjZsuTgD4bEMwN2GJ12ngY03qET+uhLxTAwBtX8oF3XRD53t/4kAmcdy3tIfmYUck25VxM+pzyC4Zf7/o00x0BKEgqguqLJl7uzAxY8+O/Fllzs9nr8DLo/FaCkhTXcEowd70SWDUGQbbgRXh6emOmULPIsye0zaWBJFq5dcOVVG5/uxqqEL/ghMtvRHPc9fLw+O6f3I+v6WRN575GKz+ZN/5Ipvw/xVZhXVjKthY843dQR6xlRyd4Zbewc+NuxEUaA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB5256.apcprd06.prod.outlook.com (2603:1096:101:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 05:10:18 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 05:10:18 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Topic: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Index:
 AQHbhqIygZnvzo4Bt0Wa/Nj5P77JfbNWO12AgADwbfCAAHvmgIAAHaSggAA7nQCAAPFIAA==
Date: Wed, 26 Feb 2025 05:10:17 +0000
Message-ID:
 <OS8PR06MB7541615D536BC1D44FF6D18DF2C22@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
 <f810b8a2-4261-4b68-b59b-4efa0219b5db@kernel.org>
 <OS8PR06MB7541D685A626D300AC730A5BF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <2b64a9d7-7048-4842-9cc1-fe23f5abdd00@kernel.org>
 <OS8PR06MB75411AE082C9630314966F2AF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <c4727195-757a-4624-8580-78e5c32e9290@kernel.org>
In-Reply-To: <c4727195-757a-4624-8580-78e5c32e9290@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB5256:EE_
x-ms-office365-filtering-correlation-id: cabeca1c-4050-4680-2b15-08dd5623dc91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmtlUkZtWTNicnFCeXJKYW9XMS9LNnBmK1dvZXYxYW5nUVNrZlpVV0dvbkdm?=
 =?utf-8?B?NFZaV0ljSHA2c2NKQ0xMcHVVVHdaQlpvRC9QdTNyeHp2dmxXTzZDQjgvQVpN?=
 =?utf-8?B?QU9mMXZCd1Noa2NmTThCUXFGb1pRL1BJcm1hSzdUL0RWT2x6SGtvMEU4TW0r?=
 =?utf-8?B?SUtDZzB6bGcxNkF6cHZaRlVHVWhObUdkMGhaSVNqWDVzczNNaTZNbHZObEJZ?=
 =?utf-8?B?THQzY3h6ODJLelk4bWpmVEhQMjZGVnZPeUFwc3ZUNWVkRFEwZ0ZtaUptQk15?=
 =?utf-8?B?dld2UFhFUG5zNnFKNHlWM0dxbVF5Q0lTMy83VFUyRklOQUQ5bVBsU2llaUhr?=
 =?utf-8?B?ZDVmY2N5OUF2SXA2SnRkaklUQTZJN004azNVNldaVWdWRmovbnE4SEovOXFw?=
 =?utf-8?B?YkFXTVRoUzJqQ3lLQTNZQTJicHFPNGdPVGtBdjlVZlZYVjB6WTY4UndEb0FE?=
 =?utf-8?B?NHZ0SU8yNlBqTGkzK0FDZXpzalZ3Sk1jMmpOa29STFVmN00ya3EzQVIrbjZq?=
 =?utf-8?B?V3NVNDNIY0tzUVdxS2R4djB1M2ZUdURub2FsTENaQWpWOC9EMWhKTnpDUytI?=
 =?utf-8?B?R0I1ZW56S0lkU3g2SUNxb2dMREtLeUhsVkova2NnWWtrM1FrMTRyNEFGM2JZ?=
 =?utf-8?B?TFVsS29jRUhrbmU0MDBsblRoeDVHVzFqWUJJekIxUEUyT3h0Q01pV2dEQjVx?=
 =?utf-8?B?TWhZV1FlZm9tSEFacGlVUksxUm5ETHN4Myt3YjRSSEtHd2NTQm1qMmp3TDBV?=
 =?utf-8?B?Um5QZlJsL1AwYlIwWTRzWmcrVkluNUxDTmwxZXcrS3loL01uV3BuVnV6NlB3?=
 =?utf-8?B?akE0cDQyRDErdWxKcVFDV2p2RXRHRmQvd2VlZGtWSFVUUm1zM045Uk1iSkRV?=
 =?utf-8?B?R1c4RGI3Z3RnYUlCQ2l5RnJGN1ZVMjdmMDR3eTJBY1lYallFYmkveDdkNDNi?=
 =?utf-8?B?K2tkWkwwRG9yUnEzZHNtSE5FbGdZR25QMWhNTDMySUN6ZUlJMy9aNzBvbWR0?=
 =?utf-8?B?MVl5aU1WUWU1SjAvamlJWWZSKzJoN1doazhYNStuTmNQWFpsM1QwYmZUZEJq?=
 =?utf-8?B?RWxRR3FtZGZPT0hQcWpMM1E3MDY3aW9WS2ZyaHVuSHcwQk1zOGoyZGxsZklT?=
 =?utf-8?B?Rnk3WlZRTmgwZEU3dW0xVXpLbWhkMXhsRWtSOEllK2YrSUVnRUJEVkVxdHM2?=
 =?utf-8?B?bWROVGhqeTlTMnhqUS9FQnQ4Sld4M2s4Yzd4VWlKMFExOWZBSTFYR01jR3A1?=
 =?utf-8?B?RFhMdGtPbnRDdmp2bEx5cDUyN1o3WVAvQlBzc1pTUE9OK1EzS0RhcmJLY1Qv?=
 =?utf-8?B?N2RKNjB0QzFLN0JLbWFTVFBCNmF0Qm5xRlpOWmkzSDlXR2JObCtaNkxWS1Ew?=
 =?utf-8?B?YzdaV1hmR2ltY2R1VUNmTGF2blMybWRScll2dExOSzV1ZVdOSEEwUEJTc3RW?=
 =?utf-8?B?YW5QcFFhakc3d0M5enpPYkU5MVVwYmNQeTBNMjR0Y0Y2MmZrQldGcE5vamk0?=
 =?utf-8?B?eE5vZmpYZyt2M3FXSTlKYXBxMDZMbWttQWlnWHVZYkE0RkVGMUFmVHg1cGR4?=
 =?utf-8?B?QWVBVFNaNHE4bVlqdnRCSzRTbUZHQWVRNGM4VjRCVDZNOStrRktmUTZVelpT?=
 =?utf-8?B?UVNVNDdKNytoT2FHU2E1RWVqYUMzSXFWYmZiMnpyNnF4NDhzdU44N1pVUTE1?=
 =?utf-8?B?K1RXU2JkVkx0UEZIZURWdVJlR2NpdEpFbUlwS1hiT3J5QTFPZG1TZThxeDdR?=
 =?utf-8?B?RkhzSThUejRBKzh3UHJhRzV0bnN6ckFnNi9OUnhocXNKTDRDdlZBZjZtWFRv?=
 =?utf-8?B?OGVuWWxlOGduRGNJVllDMFNuRmlNMnFMT0hpbXp3bXdta05VSEpmQzh2R2xZ?=
 =?utf-8?B?b1FOd2FadnJCSDd3OEFWaXFlRjBYa2poM1R3ZENINzNjNzRIMTJnV1Z6RjlW?=
 =?utf-8?B?TThJMW95b1ZkM1pjcExGRi9JMy9JZ1QxczJYZElCUUVVeE5Rai9RWS9VMzlU?=
 =?utf-8?B?eXZENkJ1ZE1BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXZiNVpkbGNORjhtTGFjUHZ6QVFIajh6cWJ3WVFyQnF4MStvZXFKeG9TUjlj?=
 =?utf-8?B?RGFsbHNFL2k2VUN5eFJmN0FYZ1A2dlArMjhYend6RUFtcGkxMFN0RUQvdENo?=
 =?utf-8?B?N0VTTmtCWmZ6b1ZpUTdHd3NPNnFFRjVXQmQ5ZXg4eFFRclNQZ1NWei92T3JF?=
 =?utf-8?B?VzB6Z2hXNktlZVFOY2FCd1E2OE1OOTVmcEhrMk1ud2FaSWVoZ2FvcUpmSHdW?=
 =?utf-8?B?Qko5MXRvUklISlg3ZXU4RE9TYmdUZXpjSVhqeWhKZWVuTXFWSHhWTWlZekZx?=
 =?utf-8?B?cnVuejNxMUhOMEdsWFI4VTBiSW41OHkyT2ZaZTRrYzcvZXdoMVhka0lkQjZP?=
 =?utf-8?B?VmpqQXZWcUg4alJjQmZHUW0zS0dEYmw5S1RnYVVVYVNpWTU3cDI0V29MOHA2?=
 =?utf-8?B?bTFmZmc1eGxRdWI5RFRlOHVUelVqZ1JnRGc5eWJDY09MSXQ0ODNlTFpDZ3FU?=
 =?utf-8?B?Z0R5SmxEWlR1d3dPVG85NmZtZ2xQNVdXMUI0NTZPRnl6UVRuTXhIdEc0SjVE?=
 =?utf-8?B?ZzZKSERvcUM0TGlGY0R3NFdYbUJNcURwbHdRK0JraDNVT1c5Q2NiMGpON00y?=
 =?utf-8?B?OGZ1aXg4T2N0NmF1dFI3a0R2WlZaMTAvWXZueVd5ek84Qk96a0FOeEhPc1Qx?=
 =?utf-8?B?a2tSaWZGdGF3aWJSUkRrSkdlWVg5SGlmM2dkcFhtSjgzb2ZibW1hZ0NpVzJ3?=
 =?utf-8?B?S3FxOXJRWXlYV1hMeWowMVpuQ1h1UFMza1B1aU1LOFFZZUwxSXVQZkZiaE16?=
 =?utf-8?B?NWgvTm1GUXZwQ2pDY0NPdXRnd0orK1VYQ1ZkRU4wMGtxME5tL2FIbzFDVFk2?=
 =?utf-8?B?aDM1UFFZcFZSWThTT1hZUDlDYnZGQWl4Q2N1RGphWEZ0cmE0ZnFJMzA5Wk5k?=
 =?utf-8?B?RHRva2lWdi8xcENTNXdNUWFQSndFRUQybGlreFZNRU4zdllDYzIwaHpXV1NG?=
 =?utf-8?B?Z3oyS1NuZ1lKZmtoV1M3SGpqbE1aY1lrYllyOE1CcUptNllKaDNtQzJZUXZQ?=
 =?utf-8?B?MmFPRzYrSTQxS3JWbVZMRm1kOWJqNndqR3c4NFVwZnlCeFZxMG1pbkovaC9n?=
 =?utf-8?B?b3VML1lqcHlnRzZnVldjNVptOGh5bVZ6NmtzZmMvMERCVFFVZEVURU9DanJk?=
 =?utf-8?B?T1F1Z1JsdnNhaDhpZjY1QUlZelpNMFdNUS9nU1JVeW9uRkN4aGROL1k5VGsy?=
 =?utf-8?B?UmUvQkxnTFo5K3piTHh6OG9CZGZTdS9TeklRdWNrNVhNY2hxcUgzb3lIZXhN?=
 =?utf-8?B?UTJNOEVWL0E5d0RDNjZscHc4ZUlKWCtkL25pb2xmZjdzZUlmZHJrOXJCdUVr?=
 =?utf-8?B?UlpuU01EMmt1K1BiREozUUtES2poRStja0lFNnNRVWdydVRWRFVFTTFWUlZQ?=
 =?utf-8?B?UWwxNmd5T1lSeFRVVm5qbVU0emlmM29FYmFyeWxlMFgrM284cG9VMXVjQnhV?=
 =?utf-8?B?RVBsM0tOcmFpRlRGdjYvLzBPRDg0Z2ZMMDFRRFdNSnJWOVpOOFJtZS9wM1N2?=
 =?utf-8?B?dUZSbjBWaTZERnoycUVTNEtJSFNhdjQvbFU0Znl1U0tZS0VsTUw2WW5XQVYr?=
 =?utf-8?B?SDF4RHBPMWltYTNYa1Y3d0JFeXN4ejlTeDhWcmRkQ0NGdDdwY0tVNkJrei80?=
 =?utf-8?B?UW1Kd29ldXdyWng4L05QZklZcTFpbWFOa2d3SndFY0FOMFc0cjcvY1BDMURT?=
 =?utf-8?B?YVJqLzdFRHM2UGtaaE9iYkFVdFhTTWtXbkpyUTAxNTVGeVZpYUVIeVlKTm1E?=
 =?utf-8?B?dmNYUmUxR0lZUWdLNkl4S0E1QVJ0VWtRRXNhelNNbEhOdERHK2FZb2VNSmF1?=
 =?utf-8?B?TGNUM29pWWdpa1VuRXhSWk5wL08rQUJBam5YWjUxaU50dzBNUjgwc3grSzlj?=
 =?utf-8?B?SXFYK05TV1dVdi9HUEJEejhjZTYvSWdRRUkyblBZRHFBUzlUUEo1QVpCYWR0?=
 =?utf-8?B?S0hwN2VocThEazFUUXBWK01vZjBiQVk4Zi9DSnZKNExUV0F0OFNnbU00TjF5?=
 =?utf-8?B?ZDAzd0c1NHQzZUtTd2RPRFF6VndJbE1ldHdSSEl4dG9qOVlXcEk3YUJEWG5n?=
 =?utf-8?B?cUdoVGRvS01VVkw3UnF1dVd5eW0zdUtkbzhiOXgxMmtnbEtNZDRldzRGbkpX?=
 =?utf-8?Q?0fRmVjdhWEHT3TJYe+x9mz3kK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabeca1c-4050-4680-2b15-08dd5623dc91
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 05:10:18.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdMDt/iXX7JsxUUXD+Kr08DmbtQ488hLaGgwV8MEW2gi9DYZPwukmmiN5bs02vDKlzxqRUVrjMOpoCveg+BN5M0uc8ByML1P7QehWlAoimc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5256

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDEvM10gZHQtYmluZGluZzogY2xvY2s6IGFzdDI3MDA6
IG1vZGlmeSBzb2MwLzEgY2xvY2sNCj4gZGVmaW5lDQo+IA0KPiBPbiAyNS8wMi8yMDI1IDEwOjQ5
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAxLzNdIGR0
LWJpbmRpbmc6IGNsb2NrOiBhc3QyNzAwOiBtb2RpZnkNCj4gPj4+PiBzb2MwLzEgY2xvY2sgZGVm
aW5lDQo+ID4+Pj4NCj4gPj4+PiBPbiAyNC8wMi8yMDI1IDEwOjU1LCBSeWFuIENoZW4gd3JvdGU6
DQo+ID4+Pj4+IC1yZW1vdmUgcmVkdW5kYW50IFNPQzBfQ0xLX1VBUlRfRElWMTM6DQo+ID4+Pj4+
IFNPQzBfQ0xLX1VBUlRfRElWMTMgaXMgbm90IHVzZSBhdCBjbGstYXN0MjcwMC5jLCB0aGUgY2xv
Y2sgc291cmNlDQo+ID4+Pj4+IHRyZWUgaXMgdWFydCBjbGsgc3JjIC0+IHVhcnRfZGl2X3RhYmxl
IC0+IHVhcnQgY2xrLg0KPiA+Pj4+Pg0KPiA+Pj4+PiAtQ2hhbmdlIFNPQzBfQ0xLX0hQTExfRElW
X0FIQiB0byBTT0MwX0NMS19BSEJNVVg6DQo+ID4+Pj4+IG1vZGlmeSBjbG9jayB0cmVlIGltcGxl
bWVudC4NCj4gPj4+Pj4gb2xkZXIgQ0xLX0FIQiB1c2UgbXBsbF9kaXZfYWhiL2hwbGxfZGl2X2Fo
YiB0byBiZSBhaGIgY2xvY2sgc291cmNlLg0KPiA+Pj4+PiBtcGxsLT5tcGxsX2Rpdl9haGINCj4g
Pj4+Pj4gICAgICAgICAgICAgICAgICAgLT4gY2xrX2FoYg0KPiA+Pj4+PiBocGxsLT5ocGxsX2Rp
dl9haGINCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSSBjYW4gYmFyZWx5IHVuZGVyc3RhbmQgaXQg
YW5kIGZyb20gdGhlIHBpZWNlcyBJIGdvdCwgaXQgZG9lcyBub3QNCj4gPj4+PiBleHBsYWluIG5l
ZWQgZm9yIEFCSSBicmVhay4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+ICMxLiBTQ1UwX0NMS19VQVJU
X0RJVjEzIGlzIHJlZHVuZGFudCwgaXQgZG9lcyBub3QgaW1wYWN0IEFCSSBicmVhaw0KPiA+Pg0K
PiA+PiBZb3UgZGlkIG5vdCBleHBsYWluIGhvdyBpdCBkb2VzIG5vdCBpbXBhY3QuIENsb2NrIHdh
cyBleHBvcnRlZCwgdGhlcmUNCj4gPj4gd2FzIGEgdXNlciBhbmQgbm93IHRoZXJlIGlzIG5vIGNs
b2NrLiBVc2VyIHN0b3BzIHdvcmtpbmcuIEFCSSBicmVhay4NCj4gPj4NCj4gPg0KPiA+IFNvcnJ5
LCBTQ1UwX0NMS19VQVJUX0RJVjEzIHdhcyBkZWZpbmVkLCBidXQgd2FzIG5ldmVyIHJlZmVyZW5j
ZWQgaW4gYW55DQo+IHVwc3RyZWFtIGRldmljZSB0cmVlcy4NCj4gDQo+IA0KPiBUaGF0J3MgaW5j
b21wbGV0ZSBkZWZpbml0aW9uIG9mIEFCSQ0KPiANCj4gPiBTaW5jZSB0aGVyZSBpcyBubyBpbi10
cmVlIHVzYWdlIG9mIGBTQ1UwX0NMS19VQVJUX0RJVjEzYCwgaXRzIHJlbW92YWwgZG9lcw0KPiBu
b3QgY2F1c2UgYW4gQUJJIGJyZWFrLg0KPiANCj4gDQo+IFlvdSBpZ25vcmVkIG91dCBvZiB0cmVl
IHVzZXJzLiBQbGVhc2UgcmVhZCBjYXJlZnVsbHkgQUJJIGRvY3MuDQo+IA0KPiANCj4gPg0KPiA+
Pj4gIzIuIENoYW5nZSBTT0MwX0NMS19IUExMX0RJVl9BSEIgdG8gU09DMF9DTEtfQUhCTVVYIE9s
ZGVyDQo+ID4+IGltcGxlbWVudA0KPiA+Pj4gd2hlcmUgYG1wbGxfZGl2X2FoYmAgYW5kIGBocGxs
X2Rpdl9haGJgIHdlcmUgKipoYXJkY29kZWQgZGl2aWRlcnMqKg0KPiA+Pj4gZm9yDQo+ID4+IEFI
Qi4NCj4gPj4+IEluICoqdGhlIG5ldyBhcHByb2FjaCAodjgpKiosIEkgcmVmYWN0b3JlZCB0aGUg
Y2xvY2sgdHJlZSB0byBjbG9jayB0cmVlLg0KPiA+Pg0KPiA+PiBJIHN0aWxsIGNhbm5vdCBwYXJz
ZSBzZW50ZW5jZXMgbGlrZSAicmVmYWN0b3JpbmcgQSB0byBBIi4gSXQncyBtZWFuaW5nbGVzcyB0
bw0KPiBtZS4NCj4gPj4NCj4gPj4+IEl0IHNob3VsZCBiZSBBQkktc2FmZSBjaGFuZ2UNCj4gPj4N
Cj4gPj4gTm8sIHlvdSBkbyBub3QgdW5kZXJzdGFuZCB0aGUgQUJJLiBZb3UgcmVtb3ZlZCBhIGNs
b2NrIElELCB0aGF0J3MgdGhlDQo+ID4+IEFCSSBjaGFuZ2UuDQo+ID4+DQo+ID4+IE90aGVyd2lz
ZSBleHBsYWluIGhvdyB0aGlzIGlzIG5vdCBjaGFuZ2luZyBBQkkuDQo+ID4+DQo+ID4+DQo+ID4+
Pg0KPiA+Pj4gT3IgeW91IHdhbnQgdG8ga2VlcCBvcmlnaW5hbCBTT0MwX0NMS19IUExMX0RJVl9B
SEIgZGVmaW5lIGFuZCB0aGVuDQo+ID4+PiBhZGQNCj4gPj4gU09DMF9DTEtfQUhCTVVYLg0KPiA+
Pj4gVG8gYmUgMXN0IHBhdGNoLCB0aGVuIDJuIHBhdGNoIHJlbW92ZSByZWR1bmRhbnQNCj4gPj4g
U09DMF9DTEtfSFBMTF9ESVZfQUhCPw0KPiA+Pg0KPiA+PiBJZiB5b3UgYnJlYWsgdGhlIEFCSSB5
b3UgbmVlZCB0byBjbGVhcmx5IGV4cGxhaW4gd2h5LiBXZSBoYXZlIGxvbmcNCj4gPj4gY29udmVy
c2F0aW9ucyBhbmQgeW91IHN0aWxsIGRpZCBub3Qgc2F5IHdoeS4NCj4gPj4NCj4gPiBTb3JyeSwg
bXkgcG9pbnQgd2lsbCBiZSBmb2xsb3dpbmcgc3RlcHMgdG8gYXZvaWQgcG90ZW50aWFsIEFCSSBp
c3N1ZXMsDQo+ID4gSSBjYW4gbW9kaWZ5IHRoZSBwYXRjaCBzZXJpZXMgYXMgZm9sbG93czoNCj4g
PiAxLiAqKlBhdGNoIDE6KiogQWRkIGBTT0MwX0NMS19BSEJNVVhgIHdpdGhvdXQgcmVtb3ZpbmcN
Cj4gYFNPQzBfQ0xLX0hQTExfRElWX0FIQmAuDQo+ID4gMi4gKipQYXRjaCAyOioqIEZpbmFsbHkg
cmVtb3ZlIGBTT0MwX0NMS19IUExMX0RJVl9BSEJgLg0KPiANCj4gDQo+IEkgZG8gbm90IHVuZGVy
c3RhbmQgd2hhdCBjaGFuZ2VkIGhlcmUuIFlvdSByZW1vdmUgZXhwb3J0ZWQgY2xvY2sgd2hpY2gg
aXMNCj4gQUJJLCBzbyBob3cgaXMgdGhpcyBhbnN3ZXJpbmcgbXkgcXVlc3Rpb24uDQo+IA0KPiBZ
b3Uga2VlcCBkb2RnaW5nIG15IHF1ZXN0aW9ucy4gSGVyZSBJIGFza2VkICJ3aHkiLiBJIGRvIG5v
dCBzZWUgYW55IGFuc3dlcg0KPiB3aHkuDQoNCkFwb2xvZ3ksIEkgY2FuJ3QgY2F0Y2ggeW91ciBw
b2ludC4gQnV0IEkgc3RpbGwgbmVlZCB5b3VyIGd1aWRlbGluZS4NCg0KKipSZWdhcmRpbmcgYFND
VTBfQ0xLX1VBUlRfRElWMTNgOioqDQogICAtIFRoaXMgY2xvY2sgSUQgd2FzIG9yaWdpbmFsbHkg
ZGVmaW5lZCBidXQgd2FzIG5ldmVyIHVzZWQgaW4gYW55IGluLXRyZWUgZGV2aWNlIHRyZWVzLiAo
aTJjLWFzdDI3MDAuYyB2MSB+IHY5KQ0KICAgLSBTbyB0aGVyZSBzaG91bGQgbm90IGhhdmUgQUJJ
LWJyZWFrIGFtIEkgY29ycmVjdD8NCg0KKipSZWdhcmRpbmcgYFNPQzBfQ0xLX0hQTExfRElWX0FI
QmAg4oaSIGBTT0MwX0NMS19BSEJNVVhgOioqDQogICAtIFRoZSBwcmV2aW91cyBpbXBsZW1lbnRh
dGlvbiB1c2VkIGRpdmlkZXJzIChgbXBsbF9kaXZfYWhiYCwgYGhwbGxfZGl2X2FoYmApIGZvciBB
SEIgY2xvY2sgc2VsZWN0aW9uLiAoaTJjLWFzdDI3MDAuYyB2MSB+IHY4KQ0KbXBsbC0+bXBsbF9k
aXZfYWhiDQogICAgICAgICAgICAgICAgICAtPiBjbGtfYWhiDQpocGxsLT5ocGxsX2Rpdl9haGIN
CiAgIC0gVGhlIG5ldyBhcHByb2FjaCB1c2UgYFNPQzBfQ0xLX0FIQk1VWGAsIHdoaWNoIEFIQiBj
bG9jayBzb3VyY2VzIHZpYSBhIG11eC4gKGkyYy1hc3QyNzAwLmMgdjkpDQptcGxsLT4NCiAgICAg
IGFoYl9tdXggLT4gZGl2X3RhYmxlIC0+IGNsa19haGINCmhwbGwtPg0KICAgLSBBbmQgc2luY2Ug
aTJjLWFzdDI3MDAuYyAodjgpIGlzIG5vdCBhcHBsaWVkLCBzbyB0aGVyZSBzaG91bGQgYWxzbyBu
byBvbmUgdXNlIHRoaXMgQUJJLiBBbSBJIGNvcnJlY3Q/DQoNCklmIHRoaXMgaXMgbm90IGFjY2Vw
dGFibGUsIG15IG5leHQgcGF0Y2ggd2lsbCBrZWVwIFNDVTBfQ0xLX1VBUlRfRElWMTMvU0NVMF9D
TEtfSFBMTF9ESVZfQUhCIGRlZmluZS4NCkJ1dCBhZGQgbmV3IFNDVTBfQ0xLX0FIQk1VWCBkZWZp
bmUgZm9yIGF2b2lkIHlvdXIgcG9pbnQgQUJJIGJyZWFrLiBJcyB0aGlzIGFjY2VwdGFibGU/ICAN
Cg0KQW55IG1vcmUgY2xlYXIgZ3VpZGVsaW5lIHdpbGwgaGVscCBtb3JlIGNsZWFyIHlvdXIgdGhy
b3VnaC4gVGhhbmsgeW91ciBwYXRpZW5jZS4gDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo=

