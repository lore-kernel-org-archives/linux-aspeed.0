Return-Path: <linux-aspeed+bounces-182-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBAE7716F
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Dec 2024 01:06:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y3bnJ4KC8z2xxt;
	Thu,  5 Dec 2024 12:06:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733360788;
	cv=pass; b=lioAHj0CQX94iGVIntzQCtmDuacfPlj2uYms9YF0OMeU7Ykw69FoSRN4m4IYNr3JusZL/8WszMPr0diJp9vn0HognhrxZVHV1HIcyu2GjMbWTekb7QF+QJaeDg3uLi3Un/TLIOPe2fXKO+1sWK2fvvFDIt8kHusb48dO7XpdUxgQQj65OGzy0Uq5fZPsTc+k3Qka6U6dikddHZz18nwrZY5xtfiEPvbw52pl50Nc/RiZX1pOowvTFAwVzGk5L/wDrCDxwLhnDq7aBe3evS7cPwYMaEodN0OjXJAqjFW6p0jzL4FhtgOsCVDpRSGRjFvkvCBYcs6P0CUSwcP7MOApKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733360788; c=relaxed/relaxed;
	bh=/n165pPN472f2h9GCe00a5yG9P3NxK2QMdaPRc8A9Pg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxZQRH4mRWqWtCA3SHwvIsQHwjxf9I7eAzchKuW5PME2oXdwuromb0CssK2Km0cOhQfK64hC+nvObhc7XRMc/6oecpMXAxT8JWbyY6mR32FaUtHRPXcgGq1hNtiLXOv/XHFSZlWMtHpEhnnODxdGBZ3ZJ4IK739L9xtHsVXTkinKx6Y7pZjiiAgYhgOt7gMftivmZXwxHXMHFPPq46/JjtebSN82KQJTKqY0oNeQ4qAHdFtBrGJDWcb1qVUXg/pdQYqZN/qmLoEk59LaIP97kYBgMatcm3Wpraqd9xifP3XUzcE7v5tSfOCPHOgfprCAAAsTtVgU1IqKs1dTW6fSOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=LIiBf/9I; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=LIiBf/9I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y3bnD1xRlz2xjK
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Dec 2024 12:06:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVSR4CSsH4ngOnTl0Jm5GSehLrRfOlQUUiaOMyYsgA7ID857I8uYcZvkjnoqedZSD51CRhpaDXeXCKcxfWB6qiSXhPq21mfJQr1N6P0unnwrwo2ZRJTh6Zr6z1/Nkm1LL5u0zr85lFL51+9691KcIJoHbBAQn/tH8uu1nSP66TBk7uj5XPKRS4bM9LyeS0DtUO+/qFusdyWoVN8MsIMvlSp2bHfgAVe3T0L87Cyp0keV0M3DPMWrVjCsHZz+ZKAfhgTiyt8S+lVsvQLzGlv83kXt6y8TRQU7jvW957laDmU9A9IJo3JcLtkmG4C/z1OV9grOtdZ/vTtmf6ZEfPfprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n165pPN472f2h9GCe00a5yG9P3NxK2QMdaPRc8A9Pg=;
 b=I4U4HwD9IeWEXo5j8OAPAVA/jEhxi599hGejJYPQblDUVSkyP6YZeZ3/RfLv/8SPP8zmH+znbzMr1lZvMxRE4T2XrCiWqm1FbzYbpg8Ovk6KO2clVWUOl3EevqmU5KK7PBVlLKsjKXcblnSylAJ/CX9vVL8ZW0uUM3tiI8ZSR6VwJ0Ax4dby/jm206PJ5buThRNagWG9DjRsmbL2/QfrUOGdkD37cx36/46HopHMypX4BAhd0lxlidtHT7SUynC5CcC5bI/nfDFB+dg2f0Fg14z+6sz5CwQFF1ERDAmRyO5aPmIyDsT6CmFUjPXjd2y7EgWAWCvNdy9MyJUS8QEviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n165pPN472f2h9GCe00a5yG9P3NxK2QMdaPRc8A9Pg=;
 b=LIiBf/9IVQynHTKMm/3XvvGkBSi4+3EdNzODhnTk7b4M296YmgTEJphtG2xolj4HBvrJsoNPwPABWRjGCBTabo/iWwrY0Rgj/4UxWeqAGBZyzfzFaGGN5QbI5KImFvf+8LohLmIxOsgifl61r+fhpOv3JJrFGcD6JVxQREIAXJjrIK9+6AdMi5PkKv5jvUTT0LUEHCjipJiVerV0KapUSa2HphIjlSz7OiEWx4NLIeWG0E4XLEnr21lohfrVTgGj+uy9/XrZRRbhPtt2SrMIhkApIVTtSO/QSnNAIViqFscsL5wAVnVYFVea6Kb4HODtjXYVK7Ctm9pHbT5jc4Li2A==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB5039.apcprd06.prod.outlook.com (2603:1096:101:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Thu, 5 Dec
 2024 00:48:42 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8230.008; Thu, 5 Dec 2024
 00:48:42 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Stephen Boyd <sboyd@kernel.org>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lee@kernel.org"
	<lee@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Topic: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Index:
 AQHbKPqAZq4g4km5Z0emm4JobXy2VrKfy+OAgACisNCAIhONAIAP9ruQgAR8kQCAABcpcA==
Date: Thu, 5 Dec 2024 00:48:42 +0000
Message-ID:
 <OS8PR06MB75418449B451224C5AB46FBFF2302@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com>
 <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
 <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org>
 <SI6PR06MB7535F5D22E3FCCF5C610B307F2552@SI6PR06MB7535.apcprd06.prod.outlook.com>
 <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org>
 <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <9ccfb478d9a122db6c634e9559e211ff.sboyd@kernel.org>
In-Reply-To: <9ccfb478d9a122db6c634e9559e211ff.sboyd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB5039:EE_
x-ms-office365-filtering-correlation-id: 83a65eb5-f0d7-46a1-8034-08dd14c690fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?amtibTRLM3hUWXVoelNiZm5KZUZ0aU5OSWZqaVF1WXExRVFmUlgySXNCbjJp?=
 =?utf-8?B?UHRIVk1nSFppVGtGNlgvVVZaVjhXS09VMDBoZ0VSekpHS3pXL1I4eDBQekFG?=
 =?utf-8?B?Z1pGM2pRcEYyNThtTERUUDdDSnN4WnNnY3Y3WVg1TFhja2cwSy80L3BFYUVp?=
 =?utf-8?B?TWFUNWRwUTMrb0FRUGpMNFZIdGpza29QSk84NCtabi9OQ1o0UjJ5YlJkRUZo?=
 =?utf-8?B?SE5PNWRQUVpEMHBNTVJKL0RvdTRicElsZkxBaEVWM2dTeXlSVndLVitwNzB0?=
 =?utf-8?B?ZVhZUDdsWXU0SlFGRW9MWmgrelpZRkxyZGR1eU5ZSjRTdUs0akVCb0pwZGJN?=
 =?utf-8?B?TnpVRG9yR2JxY1dONzJScG4rbGY2VjFNZHdHNjNaRDcxODA4eXIyLzlTOUhI?=
 =?utf-8?B?SUI4T3JEOEwzdEJwRzhObmdEZ1FRM1BYMzFLbHhqL3pEUkU0QVZvblF0RUg0?=
 =?utf-8?B?ZlRRWlVuTnRURmtXTjF3aXBaSzBacFNFN2hHTkJ0bDFRRW5QWGllbStsc3VQ?=
 =?utf-8?B?ZzgyZlBVZi9TdW8wdkd4anYyZE52clhRK3RaZWc4aHluMVNjK0lKWFpLamZQ?=
 =?utf-8?B?cENWTlFqR2lucHNUeEh0Q3Y3a0pEWHhEOXJPZlZwcCtqSXZkdE5PU1J6NlhI?=
 =?utf-8?B?eVRZSWlmSkttY3dxandmRVFXOE9KaGljYzBiSDUzSzVveGNtaDRYVG13UVFz?=
 =?utf-8?B?K2tvNE9ERHpqVHFpemFMNTJSMGJLdzBjK1l1bXhhNVVRQWEzTXdSS3dmclor?=
 =?utf-8?B?aGw1bnF2VmxUaEVGcWhxak9oeVY0NEc4aGNRL1VibnpidjUvUU1HajV4aUhY?=
 =?utf-8?B?UjBlRy9FWnZvcXRsTlNaQjVCbERUbklVSkIweTJCYUhyS01Oak5rRGh0SFNt?=
 =?utf-8?B?UlJ3OGRqOFcyMkVHaTlnSVU0Ly95Wml3OC9tQVB5dTlaTTE0UzltcVc3SFpY?=
 =?utf-8?B?dC92eUp1YjFDRDAzdmsvcnMzbW5sMnplRml0WjE3RmtUYXFaUEFxVmc1RDRE?=
 =?utf-8?B?UmFqa1ZHMlVHMllybEdGMjl4cWY5S2xyU1VnYmZJUWlGeTh4c2QzWFdRS2lo?=
 =?utf-8?B?VjUrWWVMc1Nzam5sdi9BRjhudzN0LzNHQ2ovbDZ1NWZnR0tOLzFHd0J6Yjlm?=
 =?utf-8?B?Rm9tcXZvYUNXc2s2bytqbTJsYUdQNFNoRVp0bzlEWFdhV3A0OElTWE56akc1?=
 =?utf-8?B?OWJFU2E4VU5vZHNydmtqNURtNUpqK1c0aE1tZjBUUlFNUXR5NC9KRk9wQ041?=
 =?utf-8?B?cVNUZXorVnlhYU1Sa2duS2pnY2Y3Y3lSbW9JSkxiKytFcEVqMzZ6MWVIc1VC?=
 =?utf-8?B?UUthMEpieVU4b3RaV3k5elBjN0g3N2xjMkV5OUxKWVRmU2hTRWhnN0FBVk1q?=
 =?utf-8?B?bFZYMXpaSFgweHU0R0x3RWxFek9hVmFpR2JrS2ZjS0g2S3dvcGVpZ3haUUxp?=
 =?utf-8?B?QW1PcCtwSEtOWHh5eDdtVFZGd2ptY2FsN0VLWVpsN3NhR2doT095VURHTjNG?=
 =?utf-8?B?UkhmZytwYm44Y255VDJmSHZkclJialN6WkFTOUh6UXNBNlEyVVZSeUdPR2Va?=
 =?utf-8?B?cVFjSkxCQVZoZnB2Wk5LNm1PT2h2eW9UOXFHdW9yYlhhdmU2Q1lGYjBOTEhM?=
 =?utf-8?B?U2lMRTFDNVRuVStkaFJITmhWQ2lXdDJtKzN4YmdNeEhMTlBlVC9sS0k0by8z?=
 =?utf-8?B?WHVJRm9NZmVnTWNXdFNMc2N3NlMzRlVXVnpTclQ2S1YvVk1nOVhuVWszcU96?=
 =?utf-8?B?SFhtVnZJY05pdGhDbzZYZUdiczRES3RWODFIQ0JzR2QyRTFpY1JsemM5WVoy?=
 =?utf-8?B?d25jeG1iemFsRzdOaXJubWlGVEZLQTdqUjBWc1VVSFNRRVMxT0RqVXFXQ2Ra?=
 =?utf-8?B?bitlVVFTa2JndTRWMkVIdW9BaVR5MEZvbjJ2U2pUTTY2OUswc3dZOWdkejAv?=
 =?utf-8?Q?7g76ENheuz8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Szg2cW1zMmo3QjF2dENvQzNWMmxaTVNjc21KTmk5MXlyQzIwR2hWRDd0b29p?=
 =?utf-8?B?SHNhK3dYaGNoTCtSam1KVEdSUmdFSytReWJ3L0xsTnFzUC8vVFZFdjRVZURG?=
 =?utf-8?B?UURQSzU3cW1ubmVxbGY1a01oZlpwVE9aSHVEazY4dkVLTU9ycGwzWnBVMUZy?=
 =?utf-8?B?VlBmUVlLQUFuRXJqS0VONlRtTTd0Z0lNR3NmUnJBNjU1L2pGdXgxVCtxRnU0?=
 =?utf-8?B?YmlzYlZvSFluNTJsU05pM0tuVDBpL0RaejdOSEpPTmdVTm9QamhoK0RNWmpR?=
 =?utf-8?B?NU4xVWZ5cUt2bkY4WVRabHJQdkQrbGtZa3BIUURtc2xNVkF1MXo2YXlpL082?=
 =?utf-8?B?RDd1clp2SFYxb3VIbllXN1NjZUJzQ1RKL3FvZjVpSFhIeUQyd3B1bnovUEh0?=
 =?utf-8?B?WDJreWVNbm1hbU9JQUlBZmcwNHUyS09JSjQ5L1AvSnZoZnI1QWJQN3B6aEYw?=
 =?utf-8?B?am5YVUxaMi8vcjJvSi83Tnp0WWxvWDVkV1haakJWL0xGNEpTdHByeDY0SkV5?=
 =?utf-8?B?dGlkSnVYUWR3K3ZPTm9BWG9yYitsN1djK25mWmlDRWQzL3d6R1Bqak5BcDVO?=
 =?utf-8?B?cnp4dG1JREdNYTlKU2pqT0Y5RDBveFErN20zYUtRMzVjaG5rRkFSRllqMW9F?=
 =?utf-8?B?RGFVc3NQUGJqWkJqWGM3b3NGbjY1aktZeUFwaDYzd000KzExZCs5V3lvR3c3?=
 =?utf-8?B?blJ4WlF4YXZOSVc3clVWK1ZJRTkzZzFIMzJVdFgyQ3lRd21jZTkyeCtYQVp2?=
 =?utf-8?B?dTIwOGQ2NzZVQ1VXNTF0L1ZIaGtGWFU0WjFNSlEwQzRjM1NaQjJScTNraDV0?=
 =?utf-8?B?dGhEL2F4dWM5Q3JsdGNna1lyMGMxNDdVZTFob3N5YnU2Ykt6SWxyVzFkdFll?=
 =?utf-8?B?WGl4RlZPZU4yMnVjYjZWV0dydDU1OC9ORE9ZRXlXTE9DZmNLQUd0dXNoOEoz?=
 =?utf-8?B?NC9ad1pWajFrZ1pMQWRRVTRNZW53MlZsb1NPQUJTRmRtZy9mTDN5U2s2QXQy?=
 =?utf-8?B?clpsdVRpWjJlZyszUzJsaURqR1pxNUQwSnBBMDIwa3YrOXVNS2V4WW1KL0NK?=
 =?utf-8?B?Y3pZOEJsOGFaQkZWbStrZG01d3NsaXFoZFNFOWlGTHAxQlZSKzJTa1VSN3pH?=
 =?utf-8?B?czFoaWNlSzBFMHlmKzB3eU1mQm9NWG9Cdm9mSjRLUkJzMDlDd2swU1lCeXd0?=
 =?utf-8?B?V3NIdjUwZi9qS081YWJNdVpNd3ZpeFNYdEQyVllqVkY1YTVnTklZbE9CZGdl?=
 =?utf-8?B?Y3ZpbW5ya1YwOXlzdklWdklYeVBxdFZYZmp6NTU5TndvTkJZOGxFY2xWdHE3?=
 =?utf-8?B?Y2lQL0xTZ2NYVnd4TjBVSWJ3OWxPUXp3bFRSeEN1aG9QNi9GbDNNekxreXhr?=
 =?utf-8?B?TTJiRXk2dk1QcGpvR2k3dCtEL0h6SEg5Zk5JcXFFN0prWVFFeHNEY1ZMZGJX?=
 =?utf-8?B?dUhJSk42TGY1ZWUwN0xxMUc5bUdlZWJ1WTZGQ3lta1B1cVI2ekdNOTlyZzQr?=
 =?utf-8?B?MXRRRFFPbUtaT1M0MEJHN1EyZ3UwcURDd05Gd21BWkpSUnZQSzJRZFFMUmFo?=
 =?utf-8?B?ZFV3REJxU0czcEs4R3h5MUxaMUtVUVAzcWdZS21Ya0ptZENWbmhWSDN2VWxB?=
 =?utf-8?B?c1FnMUd4Qlc3TmcrSUk1VWt3ZDF0c2hXVS8zK0kySlIrRldLbVE4Ui8yMHBN?=
 =?utf-8?B?U05mR3BvK0gwd2E0OGg0dXNWZmNIVGt3MkpjUC9KYjVQZWgrdDhyZHNHeTJl?=
 =?utf-8?B?RGMrdk44d0JTYmpxU0VFdmZFei9xYmtUd1l2N3JuVDJ2dW5qQXVRNTRsTVN0?=
 =?utf-8?B?bkNSRE1QOWdCRGZzRjlRVG05RDJXZklPVk9ZMklHTW9lM0VGeWFvK29WOWFi?=
 =?utf-8?B?c2xVeW9hM20vVGR5WjRoRDBZeXdiZW5wNHZrNTd3NjRoSHRtR0hIdXV4MXBp?=
 =?utf-8?B?R2o3bkh0Zk9aSTAydktJWXlvUzVPSE40TU9IU2IzTVRoWWNFdTlxR2YxenRh?=
 =?utf-8?B?akE1N0hIWkJqWUU5cnlRMTRSUUwrNHlsMWEyVUp4Y3FoS3RqRDIwemM3Sjhl?=
 =?utf-8?B?M2dvSWRHMmJUWEh0ZkhWOHRlNjBUSmhvYS9LTU1icEJNLzUxbDZiU3VMZmox?=
 =?utf-8?Q?PZpkmB87R1/Ks8q5bd1+6qwkM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a65eb5-f0d7-46a1-8034-08dd14c690fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 00:48:42.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUHkFxvNyvb86WaJSP+ypkq073qvdOiBQ/ExDXMwYk67hwyLTT/JwMvGYtHLqcI2Z/uSJ84p9JmqwZhFVfLxtQ2VUfE+0CfzhuuNijUEscA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5039

PiBTdWJqZWN0OiBSRTogW1BBVENIIHY3IDMvM10gY2xrOiBhc3BlZWQ6IGFkZCBBU1QyNzAwIGNs
b2NrIGRyaXZlci4NCj4gDQo+IFF1b3RpbmcgUnlhbiBDaGVuICgyMDI0LTEyLTAxIDE5OjEyOjAx
KQ0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMy8zXSBjbGs6IGFzcGVlZDogYWRk
IEFTVDI3MDAgY2xvY2sgZHJpdmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUXVvdGluZyBSeWFu
IENoZW4gKDIwMjQtMTAtMjcgMjI6MzA6MTgpDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbGsvY2xrLWFzdDI3MDAuYw0KPiA+ID4gPiA+ID4gYi9kcml2ZXJzL2Nsay9jbGstYXN0
MjcwMC5jIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4gPiA+ID4gPiAwMDAwMDAwMDAw
MDAuLmRiOWVlNTAzMWI3Yw0KPiA+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiA+ID4g
KysrIGIvZHJpdmVycy9jbGsvY2xrLWFzdDI3MDAuYw0KPiA+ID4gPiA+ID4gQEAgLTAsMCArMSwx
NTEzIEBADQo+ID4gPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gPiA+IFsuLi5dDQo+ID4gPiA+ID4gPiArc3RydWN0IGFzdDI3MDBfY2xrX2luZm8gew0KPiA+
ID4gPiA+ID4gKyAgICAgICBjb25zdCBjaGFyICpuYW1lOw0KPiA+ID4gPiA+ID4gKyAgICAgICBj
b25zdCBjaGFyICogY29uc3QgKnBhcmVudF9uYW1lczsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBs
ZWFzZSBkb24ndCB1c2Ugc3RyaW5ncyBmb3IgcGFyZW50IG5hbWVzLg0KPiA+ID4gPiBTb3JyeSwg
ZG8geW91IG1lYW4gdXNlIGNsa19wYXJlbnRfZGF0YSBzdHJ1Y3QgZm9yIHBhcmVudD8NCj4gPiA+
ID4gICAgICAgICArY29uc3Qgc3RydWN0IGNsa19wYXJlbnRfZGF0YSAgIHBhcmVudDsgICAgICAg
ICAvKiBGb3INCj4gZ2F0ZSAqLw0KPiA+ID4gPiAgICAgICAgICtjb25zdCBzdHJ1Y3QgY2xrX3Bh
cmVudF9kYXRhICAgKnBhcmVudHM7DQo+IC8qDQo+ID4gPiBGb3IgbXV4ICovDQo+ID4gPg0KPiA+
ID4gWWVzLg0KPiA+IEFuZCBJIGZpbmQgYSBiZXR0ZXIgd2F5IGZvciBwYXJlbnRfZGF0YS4gVGhl
IGZvbGxvd2luZyBpcyBteSBtb2RpZmljYXRpb24uDQo+ID4gQW5kIHBhcmVudF9kYXRhIHdpbGwg
YmUgdW5pb24gZGF0YSBzdHJ1Y3R1cmUuIExpa2UgZm9sbG93aW5nLg0KPiA+IElzIHRoaXMgZ29v
ZCBkaXJlY3Rpb24/DQo+IA0KPiBMb29rcyBPSy4NCj4gDQo+ID4NCj4gPiAjZGVmaW5lIERJVklE
RVJfQ0xLKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9yZWcsIF9zaGlmdCwgX3dpZHRoLCBfZGl2X3Rh
YmxlKSBcDQo+ID4gICAgICAgICBbX2lkXSA9IHsgXA0KPiA+ICAgICAgICAgICAgICAgICAudHlw
ZSA9IENMS19ESVZJREVSLCBcDQo+ID4gICAgICAgICAgICAgICAgIC5uYW1lID0gX25hbWUsIFwN
Cj4gPiAgICAgICAgICAgICAgICAgLmRhdGEgPSB7IFwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAuZGl2ID0geyBcDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAucGFy
ZW50ID0gX3BhcmVudCwgXA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLnJl
ZyA9IF9yZWcsIFwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5iaXRfc2hp
ZnQgPSBfc2hpZnQsIFwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5iaXRf
d2lkdGggPSBfd2lkdGgsIFwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5k
aXZfdGFibGUgPSBfZGl2X3RhYmxlLCBcDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfSwg
XA0KPiA+ICAgICAgICAgICAgICAgICB9LCBcDQo+ID4gICAgICAgICB9DQo+ID4gc3RydWN0IGFz
dDI3MDBfY2xrX2luZm8gew0KPiA+ICAgICAgICAgY29uc3QgY2hhciAqbmFtZTsNCj4gPiAgICAg
ICAgIHU4IGNsa19pZHg7DQo+ID4gICAgICAgICB1MzIgcmVnOw0KPiA+ICAgICAgICAgdTMyIHR5
cGU7DQo+ID4gICAgICAgICB1bmlvbiB7DQo+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBhc3Qy
NzAwX2Nsa19maXhlZF9mYWN0b3JfZGF0YSBmYWN0b3I7DQo+ID4gICAgICAgICAgICAgICAgIHN0
cnVjdCBhc3QyNzAwX2Nsa19maXhlZF9yYXRlX2RhdGEgcmF0ZTsNCj4gPiAgICAgICAgICAgICAg
ICAgc3RydWN0IGFzdDI3MDBfY2xrX2dhdGVfZGF0YSBnYXRlOw0KPiA+ICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgYXN0MjcwMF9jbGtfZGl2X2RhdGEgZGl2Ow0KPiA+ICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYXN0MjcwMF9jbGtfcGxsX2RhdGEgcGxsOw0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1
Y3QgYXN0MjcwMF9jbGtfbXV4X2RhdGEgbXV4Ow0KPiA+ICAgICAgICAgfSBkYXRhOw0KPiA+IH07
DQo+ID4NCj4gPiBzdHJ1Y3QgYXN0MjcwMF9jbGtfZGl2X2RhdGEgew0KPiA+ICAgICAgICAgY29u
c3Qgc3RydWN0IGNsa19kaXZfdGFibGUgKmRpdl90YWJsZTsNCj4gPiAgICAgICAgIGNvbnN0IHN0
cnVjdCBjbGtfcGFyZW50X2RhdGEgKnBhcmVudDsNCj4gPiAgICAgICAgIHU4IGJpdF9zaGlmdDsN
Cj4gPiAgICAgICAgIHU4IGJpdF93aWR0aDsNCj4gPiAgICAgICAgIHUzMiByZWc7DQo+ID4gfTsN
Cj4gPg0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXN0MjcwMF9jbGtfaW5mbyBhc3QyNzAwX3Nj
dTBfY2xrX2luZm9bXQ0KPiA+IF9faW5pdGNvbnN0ID0geyAuLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4NCj4gPiAgICAgICAgIERJVklERVJfQ0xLKFNDVTBfQ0xLX0FIQiwgInNvYzAtYWhiIiwg
c29jMF9haGJtdXgsDQo+IA0KPiBDYW4geW91IGFsc28gc2hvdyB3aGF0IHNvYzBfYWhibXV4IGlz
Pw0KSXQgd2lsbCBiZSBmb2xsb3dpbmcuIA0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19wYXJl
bnRfZGF0YSBzb2MwX2FoYm11eFtdID0gew0KCXsgLmZ3X25hbWUgPSAic29jMC1haGJtdXgiLCAu
bmFtZSA9ICJzb2MwLWFoYm11eCIgfSwNCn07DQo+IA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
U0NVMF9IV1NUUkFQMSwgNSwgMiwgYXN0MjcwMF9oY2xrX2Rpdl90YWJsZSksDQo+ID4gLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
KyAgICAgICBjb25zdCBzdHJ1Y3QgY2xrX2Rpdl90YWJsZSAqZGl2X3RhYmxlOw0KPiA+ID4gPiA+
ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIGZpeGVkX3JhdGU7DQo+ID4gPiA+ID4gPiArICAgICAg
IHVuc2lnbmVkIGludCBtdWx0Ow0KPiA+ID4gPiA+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgZGl2
Ow0KPiA+ID4gPiA+ID4gKyAgICAgICB1MzIgcmVnOw0KPiA+ID4gPiA+ID4gKyAgICAgICB1MzIg
ZmxhZ3M7DQo+ID4gPiA+ID4gPiArICAgICAgIHUzMiB0eXBlOw0KPiA+ID4gPiA+ID4gKyAgICAg
ICB1OCBjbGtfaWR4Ow0KPiA+ID4gPiA+ID4gKyAgICAgICB1OCBiaXRfc2hpZnQ7DQo+ID4gPiA+
ID4gPiArICAgICAgIHU4IGJpdF93aWR0aDsNCj4gPiA+ID4gPiA+ICsgICAgICAgdTggbnVtX3Bh
cmVudHM7DQo+ID4gPiA+ID4gPiArfTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiBbLi4uXQ0K
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX2Rpdl90
YWJsZSBhc3QyNzAwX2Nsa19kaXZfdGFibGUyW10gPSB7DQo+ID4gPiA+ID4gPiArICAgICAgIHsg
MHgwLCAyIH0sDQo+ID4gPiA+ID4gPiArICAgICAgIHsgMHgxLCA0IH0sDQo+ID4gPiA+ID4gPiAr
ICAgICAgIHsgMHgyLCA2IH0sDQo+ID4gPiA+ID4gPiArICAgICAgIHsgMHgzLCA4IH0sDQo+ID4g
PiA+ID4gPiArICAgICAgIHsgMHg0LCAxMCB9LA0KPiA+ID4gPiA+ID4gKyAgICAgICB7IDB4NSwg
MTIgfSwNCj4gPiA+ID4gPiA+ICsgICAgICAgeyAweDYsIDE0IH0sDQo+ID4gPiA+ID4gPiArICAg
ICAgIHsgMHg3LCAxNiB9LA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXNuJ3QgdGhpcyB0aGUgZGVm
YXVsdCBkaXZpZGVyIHNldHRpbmcgZm9yIHN0cnVjdCBjbGtfZGl2aWRlcj8NCj4gPiA+ID4gU29y
cnksIEkgZG9uJ3QgY2F0Y2ggeW91ciBwb2ludC4NCj4gPiA+ID4gdGhlIFNvQyBkbyBoYXZlIGRl
ZmF1bHQgZGl2aWRlciBzZXR0aW5nLiBCdXQgaXQgY2FuIGJlIG1vZGlmaWVkLg0KPiA+ID4gPiBB
bmQgYWxzbyBoYXZlIGRpZmZlcmVudCBkaXZpZGVyIHRhYmxlIHNldHRpbmcuDQo+ID4gPg0KPiA+
ID4gSSBtZWFuIHRoYXQgdGhpcyBpcyB0aGUgd2F5IHRoYXQgc3RydWN0IGNsa19kaXZpZGVyIHdv
cmtzIGFscmVhZHkuDQo+ID4gPiBTbyB5b3UgZG9uJ3QgbmVlZCB0byBtYWtlIHRoZSBjbGtfZGl2
X3RhYmxlIGFycmF5IGZvciB3aGF0IGlzIHN1cHBvcnRlZCBpbg0KPiBjb2RlLg0KPiA+DQo+ID4g
U29ycnksIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50LiBCdXQgSSB0cmFjZSB0aGUgY29kZSBkaWRu
J3QgZ2V0IGFueSBjbHVlLg0KPiAiY2xrX2RpdmlkZXIgd29yayBhbHJlYWR5Ii4NCj4gPiBmaW5h
bGx5IGZ1bmN0aW9uIGNhbGwgd2lsbCBiZSBfX2Nsa19od19yZWdpc3Rlcl9kaXZpZGVyDQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvY2xr
L2Nsay1kaXZpZGVyLg0KPiA+IGMjTDU4OSBJdCBzdGlsbCBuZWVkIHRhYmxlIHBvaW50IG5lZWQg
dG8gYWRkcmVzcy4gQ2FuIHlvdSBnaXZlIG1lIG1vcmUNCj4gPiBkaXJlY3Rpb24gb3IgZXhhbXBs
ZT8NCj4gPg0KPiANCj4gVGhlICd0YWJsZScgbWVtYmVyIGlzIG9wdGlvbmFsLiBXaGVuIHRoZSB0
YWJsZSBpcyBOVUxMLCB3ZSB0cmVhdCBlYWNoDQo+IG51bWJlciB0aGF0IGZpdHMgaW50byB0aGUg
ZGl2aWRlciBmaWVsZCB3aWR0aCBhcyBhIGRpdmlkZXIuIEl0IG1heSBiZQ0KPiBDTEtfRElWSURF
Ul9FVkVOX0lOVEVHRVJTIHRoYXQgeW91IGhhdmUgaGVyZSB0aG91Z2guDQoNCkdvdCBpdCwgd2ls
bCB1c2UgdGhpcyBmbGFnLg0K

