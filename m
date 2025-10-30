Return-Path: <linux-aspeed+bounces-2697-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08443CCF9EB
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 02:31:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxp5J2bQlz2yvv;
	Thu, 30 Oct 2025 13:31:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761791476;
	cv=pass; b=DkhX+5SUHDXOT9p9hYA2M09idGXUALjJJvZCtDYKJeCnUb23jhFnsBIZvV/+Whmqf7YBdnAIUYQ+8Lz8ga0dfJY3+rSGXlkvBIDMzyMQRx+Obqu76RLzBYBXMTmS8eBWrbZlqe5XSsZ9irtY1r3HJtrY9N/3fjFcLM+dPaWuOHdfy59MPYox/9lP7mQBHtbkebONGvo34VhsK4RIGPChMC2ZTdDGkEPyrkzVGxJx4PmPpw2La8ZYg/cz1UuEbpC2yXZyizeqHPWbURvyos1zOOQ3QTM1YixNftWRewzwkWSx2jGFzVeZGDQIS1XtNTWpDHz+a1AVgYTlCDLzpOnodw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761791476; c=relaxed/relaxed;
	bh=42UA4z7e1HiLQ71qacY/6wK7ymEmF7PkThs2KiVCcq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvQ3mt9n1ThkGS7juZ7ar3OipBnsWXPdeKGcMnGiF9v9Bt3pC051GphHUWt1trCzNKAP7ETMhGpjTuP4yipHDPxa/GpGOmyfr/CpcCq+f1nXAhwVl0WutLaElkv74ppvC80dayfqnqckcbd2e7BekuJSCJ4BMMal+iTQVkdT3euO2kHG59mOzRdGe2D6z69EEz6Z9TwNfBFm7eP4/PL9iHd6mh4TWl6Juz60kbULT78zjr/TbsX4t2fGt2hpJIKc6Llk1417B17dFX7e1d7wC8ls+n0ylu7bbWl1v4v85wdVDuIcAjOu2bHbUJKN64SUvNaZGIg6a/HYmax+sa2N9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NGce9+9/; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NGce9+9/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxp5H1xBxz2yrg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 13:31:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIXZfRRf2XK206XkzGibglZDiCYzM/aGcnC6eQXO/r9o52oPtKv0nAzhk29T2zc4DjLz/kVF9/oOnzCjVTteCxHNkojUYX3OVOUrArYCLYz75Orz+MiGsx7RcjpagoJzFmtNnlndKdVXiIvSudqI/HeT0ts8UBzK3QEM72JCb1vdLLRzzk7nnCs+QDK/5aIKNV3ILumqRP8bsN0qT4btWW/Y4RTbL5x3eG6/s/wfkFj810naN009sPUX/M9dVFG44Rh17LZkWKolUYqOUlSSiVp81Q724fmTJhZj4d5kmBfxXPYf+Ox2ulj+cmY+BCXwbWUkKedv5N6QP8S2q6VwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42UA4z7e1HiLQ71qacY/6wK7ymEmF7PkThs2KiVCcq8=;
 b=BqYUowgWTrGszFeVf4prUTV5FXx9ct9uzB/RCrhdgvfkm7fdEXh344lEwPTtLxQu+OREQzhrRAskppeEqCXOEfzvHSbsplEgpy1ZeOUluUTBQDme90Tj5bn5WovTanwwvxrRFaEMrQV2cGBox4afQ+MRZzWKqMdIaP2UjtMaYRvqTico8n/Zf44a1PAX082IFTXhO4HelJTv+LVHyG5IIJnx7JX64ToqrGqWPmmS3SUA8yN9TOT0M9ec63ef98lp43RbsBWcq9oPMTg8+SdaE+TZTKU90zdcogS0961ih9k6HfhdGEQCfbPJxwwBG73C8du2M7lQXRkVIOi2SIhSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42UA4z7e1HiLQ71qacY/6wK7ymEmF7PkThs2KiVCcq8=;
 b=NGce9+9/KFW28WP+pTeS2ao25QZvDN/3l7tyQ7iZmlu5GsUQtSHHwh83J2YanBUZXVbXCzZ5SFET8j3zMRDefMsjaeI3nMvS+18lrJlZ3s6QuZ88ddUgM8LBcEVLcTSV+Hk50X9X1Wz9LUopEmCCP9E+efnVznrVJuAcioGcg0QS6zK8RQ4HIdxCY8E7kIf6/o+5pQe4lz0XvWXTG4YmCA0w0xI7uLCus+HZOCR9MvfemnqO1nUcPFii0xET+0VZECUh9TApwyOjsXOkIORi4jfl3aW2KDMWXQcsHD7J2BKEzeNFXNJRqMmknSgXRjEzxmeaVhy6mGegvbDuwgDM9g==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB8066.apcprd06.prod.outlook.com (2603:1096:101:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 02:30:44 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 02:30:44 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
CC: Andrew Lunn <andrew@lunn.ch>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, Lee
 Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Nishanth Menon <nm@ti.com>, =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
Thread-Topic: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Thread-Index:
 AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6AgACX8gCAAPRVAIADDnEAgAAO3MCAAJ3UAIACg/2ggABTw4CAAChhgIABFTng
Date: Thu, 30 Oct 2025 02:30:44 +0000
Message-ID:
 <TY2PPF5CB9A1BE68F47D7F3DBA2CDA2429EF2FBA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
 <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
 <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB8066:EE_
x-ms-office365-filtering-correlation-id: 4157b6c2-85b7-45e4-03ca-08de175c53ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWZQa0hCMlBIbzdFdjNkeXdWWEYvN0wvakxVdGJyMHJyZFhTM0pxUE9yaUVU?=
 =?utf-8?B?OFJrVjR2L3V1YXBhOHl4TnBOclNRL2ZjYXdmR2dMTTJ6WUhvMnJwUVV1YW1Z?=
 =?utf-8?B?anhsSklNRVVoWVJMQzB1NUI4Ri9OVFA2MG1ENGxhbDVnb04zMUVpbmhOZ3Jv?=
 =?utf-8?B?QjhMMGYyekk3ZHhvNTR6TmlNV3BYWFhuN25qc1J6dXJlVlp0MVVXdll1Q2cy?=
 =?utf-8?B?QlZXenZoNEU5ekZlK3JjTVVsTWM3L3hSY1h2cXhweHhaS1d4QVQwNDdwdlQv?=
 =?utf-8?B?N2owckFOSWJCck8xazluY0FWbTBrQzl2eFZXSEV2clpWK3JXZWluZkh3Wmpi?=
 =?utf-8?B?ZHZCU3o2WGt5RU9KWEljYmMwdy81em01RW1FdUZ2dVZwYXNnQ2ZaS29XUVFO?=
 =?utf-8?B?c3VxR1RJM0JEVHlLYmpzbmY3TFQvVmpUVkhPaVVQTXUrUnpCdGFzaDJ1L29l?=
 =?utf-8?B?REcwU3JROXltQzU3K0FNM08wRWVmd2Z0b2VyMWVXS1lXNjBPNGhFcndzQjZh?=
 =?utf-8?B?b0pXaUl2cFdSakdVeS9qRFh1d3lkSW5leUlYME15c3ROZXpzOE0wdy9FUy9y?=
 =?utf-8?B?djVYTDNhYnBjQXcyWVdidytVWm0wNFg0eTYybDh3VW5YRTYxSUJrbzlILzJ3?=
 =?utf-8?B?ZkdBbzV6YkxmOE9lcjlXMUptK2czY0ZCL011MUg0QTN4OS92ZnNybmQxMUtJ?=
 =?utf-8?B?SkRiNWRGS1Q3MmtmbHRNbWt0ZTNHNjZiWUxLcGloa25EQzBFUG5vRnd4eG1h?=
 =?utf-8?B?UDlRYWV6aFFmUlZLdlhXcmd6UmV1NkZvSGtOYWk0QUEzSWZUZ3hsZzMyc1JD?=
 =?utf-8?B?U2laT0dMR1dKQXpKWGFxazRpcndWZW5KVXhQU2RrNnZPVDdQaitOMU5EU2JU?=
 =?utf-8?B?dEtQRjB4R3BVRzk4SnFGVTdTSUhORjM3N01ZakZaUXh3QjFGTEJabk82OUVo?=
 =?utf-8?B?cS9pSno2akFZK0JqS1B6bUh1OHRQRXpVS1lOdXJsSitrNGdFWGFkRUhvTUt4?=
 =?utf-8?B?dU5VMUtHbE9nK3FXS2pHejhEd25WaWFBSXVieHZSUUxjV245QVpJWE9ZMWJu?=
 =?utf-8?B?Qk9IQ1RDVXRwZXFaRmxmMWNsNk9FdEZOWE1xN2UrNndQNW12cnBTR2tJODM4?=
 =?utf-8?B?VysrN3RFaytTTFJuV3NYcW0vcFFRL1Z1ejR4bi9XM0FLZWwrVWJLdWcvTmQv?=
 =?utf-8?B?Q2h2NUZ6L2QzL3pHcHZhMVR1d0pnbUJsWU1WQnB6Y1dhcHdPVHYrYmQwb2to?=
 =?utf-8?B?QkxxOXpkU0paMVR6SDV4c3djUGxXNUZGWHlMZWZNOEVwcUVmTEpEQzMvajUy?=
 =?utf-8?B?RmhOaTV6U2xodFBLdGJyT3ZORGJ3Y3RFNU5UY1pFVy9pZWhsRmhhM0RzR2dx?=
 =?utf-8?B?Q2VWYnJBM0NPektaRm9jNE43bmg3OS80UEMrVENsWjBzbFY3NEcvUm42SU04?=
 =?utf-8?B?a1JJMVM3ODVwbE5LQ0J2UERVZm8vQWZERFk2UmJhdmdLWm5vZENvTzdlLzdy?=
 =?utf-8?B?SGZqNWRwb1ZkeUVrYjNGdVZsM1p2cWVqYmdWaVVMcDJwK1JhRit4S0F4T1BE?=
 =?utf-8?B?K0Q4UzZYSU9IbzZsbThtK3p1RjRtcGpQa1Z1cWd2U2dGNmwybm9lSDVsZnpp?=
 =?utf-8?B?ckYwMEFpWDRNdXYrSmdzU2FpNW0zUGJVc0w2Vm1QM05HWTVSc3N5RjNwZ0Rm?=
 =?utf-8?B?VEhKRGxFUnR6LzVRS2ordVVjQkNNS2pPbnRkOEJlbjAya1ZiMU96NFYxbmtO?=
 =?utf-8?B?QlVEZEd5dUtPSG5oYXNqcWgrTVB3K0ZmcFZJTVJXL0NmYnNHVWsyQVVuc01o?=
 =?utf-8?B?OGRVZWJ4YmJjVU9Od1ZSRmpwSFlsd3BPd2crbUJzd2RHR2NRVjJJQ2lCUDBH?=
 =?utf-8?B?MTBFOTA0YkppaWsyMkExVWprYUV1b1pZYnV3TjZZSC9jTmxBVWdmWGRQOTd3?=
 =?utf-8?B?UDhTYjFYK3BRbURhQ2l4WWJPbmgwVmQ4NEMzTzZ0MlI5YndQK3g1MVAxWXd6?=
 =?utf-8?B?bGF2Ym9nQkJicmIzYWYrM2pZbktKR1d2ZzlWTGc5clBpU2laSkRnd0FJYnF0?=
 =?utf-8?Q?+FuPCh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlpJbUtSMkVITURkUzIyd1FyeFBYczZvRUhnMExOcTdXaFdJZUhEdlZ1M05O?=
 =?utf-8?B?Yk14cWRaVHNxUjNKRzN0Mi82SzVQNm1JSFJYZEppbnFEdXV6azg5cnNRcHk2?=
 =?utf-8?B?UHFlcHVkenBxODZHR0I5Z0ZRdVd1ZUl0aDZ2L3JkWUFvbXhoTnUvcUdCWDl0?=
 =?utf-8?B?Rk1QRUcwMkVyRVpzUG9xeUQvMWZza3hPRUU2QUtsa01ubTNWUTRDcVdWM3kr?=
 =?utf-8?B?K3Izd3ZxVDR1dU5ZMjE0cXFQblp3dE1sMjB3amQwV2RaaStwV2I1NkwzQlJr?=
 =?utf-8?B?cTlTSVBlZDFKZlYwNjZ4aHpEdDE0c3ErV1VBMFE0Yjd2T2lTTFJ2UnE5RzFJ?=
 =?utf-8?B?ZmVZbkpPVmE1ckluck56Rjlsc1RKcUkyc0V5aU5FYUVzZnY4ZFNSVkVtbTRx?=
 =?utf-8?B?aTNqaDA3amx0RUIzd2ZoUTVTc0dsWUZpalZKZU9FMUplZEdKUEw1SGhmTllH?=
 =?utf-8?B?VVU0bVo3NC9tT1BSYmtCeUxLWVY2dnFhaVRneEgzS3VDZlJkMUhBbmVERjVm?=
 =?utf-8?B?VUNRN0FkY0lOeWhhaXRBNCtSb3Z5YllxNHZWQy9CcGJhTG02YXArNjZFdi9a?=
 =?utf-8?B?Y3IrUG1JUlJFc2IxYXlTU2pjbWJrSVp3VkVIekwrSFNZa2wvbENuQ2NWVVhr?=
 =?utf-8?B?WDFMSkJuZ2FsRDFYUFBkbC9va2FJTzdzK1lKUXptclpyQlhEMTdyRS9JWDJI?=
 =?utf-8?B?U3lVdWV1ZFhUQnVkNXZYd3ltNmdQaDJ1akIrMFY2cFQwRUZmbC9ZY2I0dHBZ?=
 =?utf-8?B?dzFnN2tpTUtLdUJBOUcwT0RreVVpbW1id3BkY0NkVzRzRnVPeUwyU2tLeFFH?=
 =?utf-8?B?WjcwNWdDZkhEK2ZYdUt3VkRGZXA1OTdSRG1vNUE0MHgvaHVMQytoaGNUSGgy?=
 =?utf-8?B?Q2tSWmV5U2NkRXltcTlTMk16RXZmYUlEWGpTRldnaUF2YlFTZm14SStXRUZ1?=
 =?utf-8?B?a3R3eXNJcnlIb0s1QmxiV3VBYnVNQ3JIWmF5dmtmVUg4MWhvVXNUc3FQbHBX?=
 =?utf-8?B?TCtLb1REN0R4UmlNQ2Z6OStBRG12dWg2ZmZIb0JSSGNkbktJWFVpRlRnNnA4?=
 =?utf-8?B?NGxtams0NlNKenlRK21nME11N3BMSW5kKzRaSGNCenR0MVFTZUhtWFIwTi9R?=
 =?utf-8?B?ZVFuYnluTzRVMk0yNm5rT3FSQXRzRE1hVThLakRJUXRtS3FudzRnazJuc1Vh?=
 =?utf-8?B?azk2Y3FNSDhkNXMwOSs3cTJDSkh5YnlmWGRHZ2EvRVduSmp0RFJWWTlKL3Az?=
 =?utf-8?B?cUl4K2gyTEt5VXM5YkZtbCs5dms0MTNZYWcrQ3ZjNXdxVGxkT1NwT0huY3RO?=
 =?utf-8?B?ZFVsTDlLZ3orZ2k4MXZWTDlQR2hFOHZkSmN1T0hzV1JaM1NOZERTdlA5eU10?=
 =?utf-8?B?Q0g2Y0Jnak1mYnRjdFVuWjVITEtXUUhrMk1ON0YzeklVdVE5YktxWTMwbTJ4?=
 =?utf-8?B?TmFtS09SRFZnc3JWVDRheGc5UVFyYVlMQjhCSG9CalY0SjE0OC9OUGtjTmFm?=
 =?utf-8?B?cUlXd3l2T1pJOEtRQVBIcENDUHRpb0ErQ1VVWHNkS0hEbUUySmpYTVhpK2o0?=
 =?utf-8?B?RExmT1JpTDdlUEVyaVYrQW5CamxmWFNncFVSR1BveUtJRzJtRDF6S1JlQjBU?=
 =?utf-8?B?TUQ4clNScHNBd1E2QmNvdDdSQzR3RFp6MWRZVkNoS3pnc281aHNocVRydDJG?=
 =?utf-8?B?amRPVDhFbHdLa1lXeVNQbzBrNXRyWWQ4UEZaeDAyMHFaWk5ha21nenZQSGhN?=
 =?utf-8?B?SU56N0h4RUxJVE5GWjdGNTIrRU9UdDhFVUh0ekphdWpTb1g1ZE5CT2JES253?=
 =?utf-8?B?bnFRamU0SGRhN1RWWFhzTVBqMkp5NERwRWJ2SDBNVkpBSFZ4SlZQb1BVdDU1?=
 =?utf-8?B?YXFFVDJDbWNSVnhNMlQwa3cwb2hKOS8xcTlKdncvTzFtc3MyOU8xN0gxeUlp?=
 =?utf-8?B?bEczay9kNDAxR3ZFMG4yN2ZYeTVFU1piam16ejRHSkVsL1dVR2RXOFdpTEdW?=
 =?utf-8?B?ZmdnU0NMRVAySzQvOUZxdXhUZkN3cmJvOUFaQUdCNFFwbnIzNm4vN2h3NGZ4?=
 =?utf-8?B?RnpZSVduK0hZWEJKYW5XVVFiTXhjSitpQTdhdyswbUl0cHZwQkdtdUY4djZM?=
 =?utf-8?Q?FTHB/QvrGjdh4HofSB9oUNDcd?=
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
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4157b6c2-85b7-45e4-03ca-08de175c53ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 02:30:44.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpK2J/ZPWswFORzF6QnO/7aTwYEtpqt0R13L/1DzaRfaZ0FcrTByL6zLwLHJdy/QCBA8v1kOZD2ZK07F+IKMmg5N/Er8LZ9zmBZE+HVPFgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8066

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDQvNl0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gSGkgQXJuZCwNCj4gDQo+IE9u
IFdlZCwgMjkgT2N0IDIwMjUgYXQgMDg6MjYsIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
IHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDI5LCAyMDI1LCBhdCAwMzozMSwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNC82XSBhcm02NDogZHRzOiBhc3Bl
ZWQ6IEFkZCBpbml0aWFsIEFTVDI3MDANCj4gPiA+PiBTb0MgZGV2aWNlIHRyZWUNCj4gPiA+Pg0K
PiA+ID4+IE9uIE1vbiwgT2N0IDI3LCAyMDI1IGF0IDAyOjQyOjAxQU0gKzAwMDAsIFJ5YW4gQ2hl
biB3cm90ZToNCj4gPiA+PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiA0LzZdIGFybTY0OiBk
dHM6IGFzcGVlZDogQWRkIGluaXRpYWwNCj4gPiA+PiA+ID4gQVNUMjcwMCBTb0MgZGV2aWNlIHRy
ZWUNCj4gPiA+PiA+ID4NCj4gPiA+PiA+ID4gPiBTb0MwLCByZWZlcnJlZCB0byBhcyB0aGUgQ1BV
IGRpZSwgY29udGFpbnMgYSBkdWFsLWNvcmUNCj4gPiA+PiA+ID4gPiBDb3J0ZXgtQTM1IGNsdXN0
ZXIgYW5kIHR3byBDb3J0ZXgtTTQgY29yZXMsIGFsb25nIHdpdGggaXRzDQo+ID4gPj4gPiA+ID4g
b3duIGNsb2NrL3Jlc2V0IGRvbWFpbnMgYW5kIGhpZ2gtc3BlZWQgcGVyaXBoZXJhbCBzZXQuDQo+
ID4gPj4gPiA+DQo+ID4gPj4gPiA+ID4gU29DMSwgcmVmZXJyZWQgdG8gYXMgdGhlIEkvTyBkaWUs
IGNvbnRhaW5zIHRoZSBCb290IE1DVSBhbmQNCj4gPiA+PiA+ID4gPiBpdHMgb3duIGNsb2NrL3Jl
c2V0IGRvbWFpbnMgYW5kIGxvdy1zcGVlZCBwZXJpcGhlcmFsIHNldCwgYW5kDQo+ID4gPj4gPiA+
ID4gaXMgcmVzcG9uc2libGUgZm9yIHN5c3RlbSBib290IGFuZCBjb250cm9sIGZ1bmN0aW9ucy4N
Cj4gPiA+PiA+ID4NCj4gPiA+PiA+ID4gU28gaXMgdGhlIHNhbWUgLmR0c2kgZmlsZSBzaGFyZWQg
YnkgYm90aCBzeXN0ZW1zPw0KPiA+ID4+ID4NCj4gPiA+PiA+IFRoaXMgLmR0c2kgcmVwcmVzZW50
cyB0aGUgQ29ydGV4LUEzNSB2aWV3IG9ubHkgYW5kIGlzIG5vdCBzaGFyZWQNCj4gPiA+PiA+IHdp
dGggdGhlIENvcnRleC1NNCBvciB0aGUgQm9vdCBNQ1Ugc2lkZSwgc2luY2UgdGhleSBhcmUgc2Vw
YXJhdGUNCj4gPiA+PiA+IDMyLWJpdCBhbmQgNjQtYml0IHN5c3RlbXMgcnVubmluZyBpbmRlcGVu
ZGVudCBmaXJtd2FyZS4NCj4gPiA+Pg0KPiA+ID4+IERUIGRlc2NyaWJlcyB0aGUgaGFyZHdhcmUu
IFRoZSAuZHRzaSBmaWxlIGNvdWxkIGJlIHNoYXJlZCwgeW91IGp1c3QNCj4gPiA+PiBuZWVkIGRp
ZmZlcmVudCBzdGF0dXMgPSA8PjsgbGluZXMgaW4gdGhlIGR0YiBibG9iLg0KPiA+ID4NCj4gPiA+
IENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgYW4gZXhhbXBsZSBvZiBhIC5kdHNpIHRoYXQgaXMgc2hh
cmVkIGJldHdlZW4NCj4gPiA+IGRpZmZlcmVudCBDUFUgYXJjaGl0ZWN0dXJlcz8NCj4gPg0KPiA+
IEkgY2FuIHRoaW5rIG9mIHRocmVlIHRoYXQgYXJlIHNoYXJlZCBiZXR3ZWVuIGFybSBhbmQgcmlz
Y3YsIHdpdGggYm90aA0KPiA+IGFibGUgdG8gYm9vdCBMaW51eCB1c2luZyBhIHZhcmlhdGlvbiBv
ZiB0aGUgc2FtZSBkZXZpY2UgdHJlZSwgd2l0aCB0aGUNCj4gPiAuZHRzaSBmaWxlIGJlaW5nIGlu
Y2x1ZGVkIGZyb20gdGhlIHJlc3BlY3RpdmUgb3RoZXIgc2lkZToNCj4gPg0KPiA+IGFyY2gvcmlz
Y3YvYm9vdC9kdHMvcmVuZXNhcy9yOWEwN2cwNDNmLmR0c2kNCj4gPiBhcmNoL2FybS9ib290L2R0
cy9hbGx3aW5uZXIvc3VuOGktdDExM3MuZHRzaQ0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvc29w
aGdvL3NnMjAwMC5kdHNpDQo+ID4NCj4gPiBBbGwgb2YgdGhlc2UgaG93ZXZlciB1c2UgdGhlIHNh
bWUgYmFzaWMgcGh5c2ljYWwgYWRkcmVzcyBsYXlvdXQgYXMNCj4gPiBzZWVuIGZyb20gdGhlIHR3
byBDUFVzLCB3aXRoIG9ubHkgdGhlIHNldCBvZiBvbi1jaGlwIGRldmljZXMgYmVpbmcNCj4gPiBz
bGlnaHRseSBkaWZmZXJlbnQsIHN1Y2ggYXMgdXNpbmcgdGhlIG5hdGl2ZSBpcnFjaGlwIGluc3Rh
bmNlIHBlciBDUFUuDQo+IA0KPiBJIGNhbid0IHNwZWFrIGZvciB0aGUgbGFzdCB0d28gb25lcywg
YnV0IHRoZSBmaXJzdCBvbmUgaXMgbm90IHdoYXQgUnlhbiBpcyBsb29raW5nDQo+IGZvciwgYXMg
cjlhMDdnMDQzIGhhcyBlaXRoZXIgYW4gQVJNIChyOWEwN2cwNDN1KSBvciBhIFJJU0MtViAocjlh
MDdnMDQzZikNCj4gQ1BVIGNvcmUsIG5vdCBib3RoLg0KPiANCj4gPiBJbiB0aGUgQVNUMjcwMCBk
ZXNpZ24sIGV2ZW4gdGhvdWdoIHdlIGhhdmUgYm90aCBDb3J0ZXgtQTM1ICg2NC1iaXQpDQo+ID4g
PiBhbmQgQ29ydGV4LU00ICgzMi1iaXQpIGNvcmVzLCBlYWNoIHJ1bnMgaW4gYSBkaXN0aW5jdCBh
ZGRyZXNzIHNwYWNlDQo+ID4gPiBhbmQgc2VlcyBhIGRpZmZlcmVudCBtZW1vcnkgbWFwLg0KPiA+
DQo+ID4gVGhpcyBpcyBzaW1pbGFyIHRvIHRoZSBDb3J0ZXgtTTQgb24gaS5NWDdELiBUaGlzIGlz
IHN1cHBvcnRlZCBieSB0aGUNCj4gPiBMaW51eCBjb2RlLCBidXQgSSBkb24ndCBzZWUgdGhlIGNv
cnJlc3BvbmRpbmcgZHRzIGZpbGUgZm9yIGl0IG5vdywgaXQNCj4gPiBtYXkgaGF2ZSBuZXZlciBi
ZWVuIG1lcmdlZC4NCj4gDQo+IFRoZSBrZXl3b3JkIGhlcmUgaXMgIlN5c3RlbSBEVCIsIHdoZXJl
IHlvdSBoYXZlIGEgc2luZ2xlIGZpbGUgZGVzY3JpYmluZyB0aGUNCj4gd2hvbGUgU29DLiBGcm9t
IHRoaXMsIHNlcGFyYXRlIERUUyBmaWxlcyBhcmUgZ2VuZXJhdGVkIHRoYXQgZGVzY3JpYmUgdGhl
IHZpZXcNCj4gZm9yIHRoZSBhcHBsaWNhdGlvbiBDUFUgY29yZSwgcmVhbC10aW1lIENQVSBjb3Jl
LCBjb250cm9sIENQVSBjb3JlLCBldGMuLi4NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCg0KVGhhbmtzIGZvciBwb2ludGluZyBt
ZSBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uLg0KDQpBZnRlciBjaGVja2luZyB0aGUgVEkgSzMgZXhh
bXBsZQ0KKGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9hcmNo
L2FybTY0L2Jvb3QvZHRzL3RpL2szLWo3ODRzNC1qNzQyczItY29tbW9uLmR0c2kjTDc1KSwNCkkg
c2VlIHRoYXQgYWxsIHByb2Nlc3NpbmcgZG9tYWlucyBpbiB0aGF0IFNvQyBzaGFyZSB0aGUgc2Ft
ZSBwaHlzaWNhbA0KYWRkcmVzcyBkZWNvZGluZywgd2hpY2ggbWFrZXMgYSBTeXN0ZW0tRFQtc3R5
bGUgc3RydWN0dXJlIHBvc3NpYmxlLg0KDQpIb3dldmVyLCBpbiB0aGUgQVNUMjcwMCBkZXNpZ24s
IHRoZSBDb3J0ZXgtQTM1ICg2NC1iaXQpIGFuZCBDb3J0ZXgtTTQNCigzMi1iaXQpIGNvcmVzIGVh
Y2ggcnVuIGluIGEgZGlzdGluY3QgYWRkcmVzcyBzcGFjZSB3aXRoIGRpZmZlcmVudCBtZW1vcnkN
Cm1hcHMsIHNvIHRoZXkgZG8gbm90IHNoYXJlIHRoZSBzYW1lIGRlY29kZSB2aWV3LiAgDQpCZWNh
dXNlIG9mIHRoYXQsIGEgc2luZ2xlIHVuaWZpZWQgLmR0c2kgY2Fubm90IGRpcmVjdGx5IHJlcHJl
c2VudCBib3RoIHNpZGVzDQp3aXRob3V0IGFkZGl0aW9uYWwgdHJhbnNsYXRpb24gb3Ig4oCccmFu
Z2Vz4oCdIG1hcHBpbmcgbG9naWMuDQpGb3IgZXhhbXBsZSwgaW4gY2EzNSB2aWV3IHVhcnQwQDE0
YzMzMDAwLCBjbTQgdmlldyB1YXJ0MEA3NGMzMzAwMA0KRnJvbSBjYTM1IGRvIGhhdmUgMHg3eHh4
eHh4eCBpcyBhbm90aGVyIHBlcmlwaGVyYWwgZGVjb2RlIGFkZHJlc3MuDQoNCj4gDQo+IC0tDQo+
IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIg
LS0NCj4gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlv
bnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4g
d2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tIExpbnVzIFRvcnZhbGRzDQo=

