Return-Path: <linux-aspeed+bounces-177-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4456FD49798
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Dec 2024 03:28:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y1q4g678mz2xl6;
	Mon,  2 Dec 2024 14:28:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733110115;
	cv=pass; b=Kn8a1eslfHUm16kmDHESrRoAoS6//DcLiMGLER1cJxYtHCynSiSxDtk6BiE8m6rA/mtY84j0x4S+E6UgrieUJVaEPY4xGhHekc00mmU6ZH8eTLBFwLGiQYVFVrqeJLyhP386wL+vupKLTu8ATVTp0OAPUq4HYTq2rQ1OSRL+uBlhJYL808e+WyP95Xpmq4EQaK+6pOpJA8oeNlGKBF5yIQuDuhKHxCXYWyF33xGTukfI+ymQLQMUsglmRHKqOIDNtZIE8jcfF3xPRiIfxfMfxG7ytL6fqMRftQzXvhqyjfxkFCFZ3qtunSuKjOQzNq5SgNAFsWYKHBEkTCqmfH/HAg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733110115; c=relaxed/relaxed;
	bh=sK2bp4R1AqRx3DOtPoKeZj66U6kEG1wn2whOAHr7nxQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMMdzK+tPzwm6tIBCwyTTO5tNe7qh/MYLLxLBkCSC8xqHTTtCH5iAz3w0720fAJwmyQIhD8IEbNVcP+SVyr9qtlL0pl3Yz20JmdolklsJmk+T0F4TOjN2t06h7uq5VjnL7TDwHBs6Hq/yiqIY+6uS+ibtNhi/GgtWsLrmZhFIJ0twXfjSppAHWC+hzua7G+2iqJ5jxHBjEiB68gtooZLEPLXUz3LZtRf9eWhIjz6Myey8Eu7R9rVebtWNA33kbQXRyQTcSMVQE00KMf3vDhJp+/2wzgrcjeWF3jiSb9DRQPRgLd3PJXmgIOiLC8nMXsmBpQIqrDaB2Avh35JctPFlg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=GuqihgBa; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=GuqihgBa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y1q4d1rmkz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Mon,  2 Dec 2024 14:28:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wag4xpp1on54mukJptju6LBR8pTPZmU9ztK0OvSVmXSWDQJv01ZIvrS0BxSZWsVSBghfzpltNIq8jwtIf+3txkBF49mwZ9H2dfAPHiJWBUBZVyIdme9EFaNVfjb4wtGaAhNfZT3jsqor8zQH6TVy3M4rxrPGoj6wiVhNn0LXSvgJUsdurLkNr5Q2zBZwr9vijkeOadPS9DSX5hNALUED7+AKyQuvmZWKb9GynDRHdu1L1opXSCFzbaGJfftWzI7fXhnDGPbqBrhTL8ty/MDVS3tzvcxaMukSnR2RLEWA0RKuhJgJ1DUKClf9ixf1ZWgcnpu6uchJPe02Ub2N3cxOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK2bp4R1AqRx3DOtPoKeZj66U6kEG1wn2whOAHr7nxQ=;
 b=LMr+Z9fZOUX6qcaMzfbaGZQ6g4m7d3p9ptV360jDWOR2BTVG5E+41HUCL+k9lpoZ0vWZXC8QyhHX2w7sMiJB1WnirEd6lgrNkGZXqIqd8LZjtoyoMHIFj+dlVwEys88Ddm3Ex2eomDq/gv5oOZHB6LYrfZYGZbBjsGK874F3kHAxVSyTr1lYpqV9K2+ZBcg2pceLX+Qgf0hlchaJCokrtlWsb3C53My7Flvm4lz68sQRT6d1fCV8T6uLwYqu0pGdHQgUNErNs9B2JipZuSSwzzEDaZdUQKMVvNLLavDeFaB4VgLlt5QF9XAyYtdXRczabIN9pbSDXV9NWQ4yxs6iYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK2bp4R1AqRx3DOtPoKeZj66U6kEG1wn2whOAHr7nxQ=;
 b=GuqihgBaUYhPEOrNW4ujXnLBIuQmxs27+h0ezePXk7AQrCDcRLXWpcr6zmYuvYvefkvaT7W7J7sSih1UEQZqKpSook0EHs8lJVcMIdNf3BdxkzI2ZHYlRzAcNlPESG75RntesW8MxTPyXn/2AMyS5MBVaM98GS+cK1vZb7a/1nDPgRmZYWrLuqwvUJwt7gMzqPptO+3By/zIRc2vuHPX+ceConBwtqWUXGCEn5qVAYRcPY4DGTgppbw1fPJFfiO9hgis5+0mSVuk+hRodEKNptYFdurBE1mw9Pmaz640N0FUWKdYTCxterwe7sOwvX/AQKC/Yl4QpmJxGg380pwl3A==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB6302.apcprd06.prod.outlook.com (2603:1096:101:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.5; Mon, 2 Dec
 2024 03:12:01 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 03:12:01 +0000
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
Thread-Index: AQHbKPqAZq4g4km5Z0emm4JobXy2VrKfy+OAgACisNCAIhONAIAP9ruQ
Date: Mon, 2 Dec 2024 03:12:01 +0000
Message-ID:
 <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com>
 <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
 <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org>
 <SI6PR06MB7535F5D22E3FCCF5C610B307F2552@SI6PR06MB7535.apcprd06.prod.outlook.com>
 <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org>
In-Reply-To: <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB6302:EE_
x-ms-office365-filtering-correlation-id: 901787d9-9d1f-42ed-be89-08dd127f16f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3RaNlR5Ni9uaTM1T0lNVjk2THBMN3pJUGtOWmdqV1VzR25MNHZydWR1Ky9R?=
 =?utf-8?B?WUdWaFZKMUswVi9UTG9RaWFRcnIxcWpIK01HVWVwYXNxQ2RadHE1L0g2T2Mw?=
 =?utf-8?B?Y1pqWmE2aEs0elJkRWNhZ1FTeU5jWUU1Q0JrcHFiTXpzcmkyd2tBVEFpVS9u?=
 =?utf-8?B?d0FiQ1VORTZJMTJ3SStQMEpkVkcxVXR6SDBjcDVQTVI4d0UvVE0ycTNLUE85?=
 =?utf-8?B?U3dpWFNRbWcyMi9MWFhld21rejh0cERHM2YweEsvT00wVGxyT3Y2ZnliYkNo?=
 =?utf-8?B?eXJlamhIaGFhRkpCOHhZRkpNWERDNlZwWEpHR3JsMEhTUjVrRjE1ZnBSWnNn?=
 =?utf-8?B?S3NyNjk4bmVWaFVoN1lTcFEydVdEenZjaGh0eGpKRW5DWWlESHpwNFhqbU1z?=
 =?utf-8?B?WW5ldlNXczJzVHh0bGxxaVNzazZ0Z3N3NFpPWFpJWjdNYkl2MVdxb3gvWi8v?=
 =?utf-8?B?Mit3REZhb1FQMWhJUFo3Z0pvckIrTHFuZk9LTnB5N2lYNjJuN2ZoeCtjWVA2?=
 =?utf-8?B?b2x0djZON2VoSVhwS1pQaEpjZy9CM1FJYXBHTFVyaVQ0c0pZSjdKR3Q3Y1c1?=
 =?utf-8?B?K2VtN01iNkgzL2F3eExkQkZHQy9OTE9UdVF1NUVWVFh3Qk1zbG4ybDg3bTY2?=
 =?utf-8?B?R3JUWTg1d0tqb3lMbHJiYk1lNm4xU1dvZGZTRk53d1NQZ3FOODJ4bVFLVWgv?=
 =?utf-8?B?V3I0K3ZvOEFvYmpydU14YVQyalNnbURBSU1GdEFBaCtxS0VNcUVRR0Rjdm9a?=
 =?utf-8?B?dlBDclBEL3RFR0xkdWFtSUhML1dwOGZ5eDJ5bHZ2WlpkNTFPdmRZdVRJd2Yv?=
 =?utf-8?B?eEVLZjB4SGFJblJNQkk3bUZHQ1gxVzIxOFE3cWpaZmhHTmtFSFFXN3YwNVl5?=
 =?utf-8?B?K01BZmhMMkZHOTkxUFdXUzZsYU1QYlNaVSsreGVIMEJLS2h1bGVCSXpYb2Vw?=
 =?utf-8?B?YXB4Q282Y3pTNGQ5VlRvSFBibll6SkNlRzEwNVA3bTkxckkrdWhyK0JxSXlx?=
 =?utf-8?B?RUF1UHBnT3EwQ3dVSWNsdnZDN3kvRWVMR0NVK3V6M3BGcnYrUkhocDZmeDVy?=
 =?utf-8?B?UkZITkFKUklsOGJ0T0haWENDbjhUQk5MRjNMb21ueSt4cE44Qi81eWYraEhW?=
 =?utf-8?B?L21jZUI1anJFRGxxb3JvQkgzUnU1QWxnRS9hOHZpZllFd3QzRUtnYngyQkhZ?=
 =?utf-8?B?UWxZcTVKRkd0UnV6QjBhRWpMWFdCNG5YUVBnODQ3ZldTYXhiQlc5alQzU3A0?=
 =?utf-8?B?akxWQ01ISnkyalU3VnF2SHdIclNGV1V3MjFySnFtNzV6aDVSU0ZDM2F4bzkz?=
 =?utf-8?B?VS9VM2dGeWlSdzVMenlmT1M2dC83TllNdEhScG9NMng1eW5uOXFObWhxL1Vq?=
 =?utf-8?B?bnFFaHF3OWUrUEx0Z3FoMEhBcWY4TFFjNVpXUldHeE5pYytYNk9yUnZzQUIw?=
 =?utf-8?B?VysxVlprSHhsSDNrUjZYVDU0dTFOM0xOZXdjUE82UHZ2Z1RTRmNWMzJmNVc5?=
 =?utf-8?B?K01kS3B3MHZLNExiZ3lEZ1JRWmgyTEtvcVdsUDYwTHpMblRJZW9TcXZHZDZw?=
 =?utf-8?B?UFBSR2tLQ2ZuSzFjc1pMSzQ2Z0xkbm1XVjNqczZuZFZkbXlrMmdmWnFLQy9Q?=
 =?utf-8?B?NmY0ZWVhOXdVZE5RRlBoZ1VIM0FYV05QR1BybnluSG0vNTkxWmxoZGQrTDZ0?=
 =?utf-8?B?cVdJL0Q5WHUvMUpsK1BuaDlaVC9zN3Y1eE5laVpWTW1MTGJQUFRJS21wL1Q4?=
 =?utf-8?B?QUZXTHZ2YnpSaWN3ajJLRFE2MjRYTUpyMFlRSEVnL0tNcUxuR0Vyclp6Z2Qy?=
 =?utf-8?B?SjZaVGJma0FkWjNWSmRBNERQYXU0THpMN3ltQ2NpcWRpQm5kdDNGNktOMVRp?=
 =?utf-8?B?R2hjVitvRTZqcVBjMjIxQ0NHbURvQ3NqQVppQXVtYWZlUFFRWXdIdGZISlRN?=
 =?utf-8?Q?zxAM0B/4Nbc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajVLVTlDRHI1NnRTQUpXTVF3WDI1WDl4ZVozUUxKZXdRVXc1Qk84bHFmanNh?=
 =?utf-8?B?dy9STndGdXhEblg5QytLME9SU3phSXJ2RW5JbitRbXNaMUd6eEhHSjZRdmV3?=
 =?utf-8?B?Mzc4MS95ZVYxMHBpOG5TMWl1SXVGcGZzK0g2ZU55eklQR3hLKzVzK1Mza0JF?=
 =?utf-8?B?YjFMMENsTEZranR1dUh5MC9FS0NHV0VrK29GcjhUajFWSTJNQnplODRRUE9x?=
 =?utf-8?B?WUFBbzdlUis3UEROZUx2dTYyTnhFWGFGWjEyN1V0L1FENmtyOUVjTHZxa045?=
 =?utf-8?B?RGpDS0RkUjhlWlBZZ0F6QWxzTG1mUTlRcmpqRWFvcFJQeWcvb1pSaFFvb0J0?=
 =?utf-8?B?dkQ5SnE4S2RHdVNKQ1JZUStGcFp3QXZXK2phMVRRUFlSZk5QZUpkRDJ2UmQ0?=
 =?utf-8?B?b2lFbWp1eUJUYTlvekwyU2ttUW85Snh3aEU1VXU1U0l2dmROY2liMVl1VFN4?=
 =?utf-8?B?ZEFjTXNLWG9SREFqS2dVRlBjbjR5VHdaVjZlOExJU3VWSThCMGxWRjJqQmN5?=
 =?utf-8?B?MjBiamNlR2x0K0R4cjRkYU93RDRJdmxrSWg2aHVBRzFQWS9jZzNlbHNzd3JM?=
 =?utf-8?B?Wm12dmp5d3hUSml3azNRV2JFZ2duL1NEM29la284dVUvb0k0VjNzclBLbHpj?=
 =?utf-8?B?S1pkWitTaVhVNzNpdkJZWUczQ3k0Wk1ZeHVVYUZvNmVFcTFhZmRKWk9QMzVo?=
 =?utf-8?B?L3pSLzhRVzNteno4YWkvS3FaQy82akYxODloTUlnekd3RFZ0dmc5ZlROWVhK?=
 =?utf-8?B?QU9UVjJBZTV4NnhKY29uUGQvdlp6bTRGcXFSVDZMTGVRdENsb0daRm5Ga0NK?=
 =?utf-8?B?SVUyMmJKQjA4N1dsYkFaaFJuWFVUM3RmZ3ovOWVJaWg3NGMzeHQwQWNOUWd1?=
 =?utf-8?B?WHowVGRucWx4QWJQRk1NbmZvV3lKMXFZUXpQMVNTUThQWmV3V3gyYjdRVVda?=
 =?utf-8?B?ZEo4NlY1S2ZTRnNpUFB2am5FM1lOcEFZQURNQ0pFS1RLSjBROUJiRmkrMHJm?=
 =?utf-8?B?K2hUeldQUDg2Q0U2UklmVmxOYzQ4cVUzOGVsTVM3Smp4YW9wMGo0dmtubUli?=
 =?utf-8?B?eG94VnUwZ3gvejJIelViNDlTRmh6YTROdW9jYVhMMDc4eEJiTEhzc2dWR0NZ?=
 =?utf-8?B?cTM4VHFlakhLdEp0NEp6Y09qdEZrb2tkUmJoL2VQWDc0T09TclBQcHc5dWhZ?=
 =?utf-8?B?SE5Wb1FVajJHMk40bFZvazZ0c2hkVFlaNmdQamZGSmxUZVp5a0poK085aEF2?=
 =?utf-8?B?b1ExZGJla2hPZXcxd2hmS0J4dlBPQWFtQzdLYUl6MW9yYU5rcTZQK1p6ZGZH?=
 =?utf-8?B?empaSUdhaHBScEFrZGpJQW1QRHlOZ1NoSDNheG1RSHU3dTNJZldEMjU2ckQ1?=
 =?utf-8?B?UGZCZktZb3ZrTDFYdHhpeTZPSnd4Y3QvTDM5MzJkOThLSGM1ZTVETEQ0U1JB?=
 =?utf-8?B?YjJNMzV2U09BcWtQUWxPRllDeXN4NC9wVGJyZURTaVVEeERKSFM5MnltN3Vj?=
 =?utf-8?B?NSs5aHNQd0RRY3h2UFFVRFovY0w0eDBodTYyUktQY3B3dXNnQnNZdnNDRGN0?=
 =?utf-8?B?ZzcvWW5TWWQxVnp0SDJXR2FMMXdodThsUUJ3YjZXdEticWx0MmpaUVVxamNN?=
 =?utf-8?B?TkFUenBFSVZlbTFjeFoxZnhIZDVKWnZnalo1RERoOE5wUU1kT3N5SEJEcWov?=
 =?utf-8?B?SEk3V3MrU2ZUWU1Hd3grQXBoN2k0MVQ4TUllU005bkgreFpNSmJBM0hJWStW?=
 =?utf-8?B?dUM2clpxQURaM3hOUzVFemZZa3NIYkVqRlJ2dUFlL3o0d29pUWpTOGtYOWFR?=
 =?utf-8?B?MHBPWjAwZW1BVEdaMGx3RUhoZzQrc1F3TkpiaXFXWkdYTWxwblNUY2JETlVH?=
 =?utf-8?B?ak04Vkh1K1ZkeWdSSTkvRkFqYklscUdwMEJSTGVKL1JsUEd3cmdUNDRPNFNJ?=
 =?utf-8?B?bEVIVkgxcnRDdHNoMWFtZlFEMm5VZm5YZElRZVM3eTdBZ1JTM24vNmM5U3dj?=
 =?utf-8?B?ZnkwSHd0emMvMTJzWCtrY0J3OUJRQkl3QW54M1FFbXhnQkN0c0VyNE9kMlFC?=
 =?utf-8?B?UWdLUFpNZ2FET2QyQncxaFd6Sk8wUUk0bFRXVytyUFE5OXFFUzVXZmJ1VGl3?=
 =?utf-8?Q?/+UW5Empm8TWHC1xBhYtp7vam?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 901787d9-9d1f-42ed-be89-08dd127f16f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 03:12:01.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4xbV+MfmqIlRU/JovILcgu5jgdRoONnlhDmvkkQlz9Xyhhi6ojDfG1QhytZ1ajeWbXdA/iI6Cs0g7q9PYhuUPzf08GwBFyFflLmcV0H5fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6302

PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAzLzNdIGNsazogYXNwZWVkOiBhZGQgQVNUMjcw
MCBjbG9jayBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gUXVvdGluZyBSeWFuIENoZW4gKDIwMjQtMTAt
MjcgMjI6MzA6MTgpDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstYXN0Mjcw
MC5jIGIvZHJpdmVycy9jbGsvY2xrLWFzdDI3MDAuYw0KPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLmRiOWVlNTAzMWI3Yw0KPiA+ID4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1hc3QyNzAwLmMNCj4gPiA+ID4gQEAg
LTAsMCArMSwxNTEzIEBADQo+ID4gPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMA0KPiBbLi4uXQ0KPiA+ID4gPiArc3RydWN0IGFzdDI3MDBfY2xrX2luZm8gew0KPiA+ID4g
PiArICAgICAgIGNvbnN0IGNoYXIgKm5hbWU7DQo+ID4gPiA+ICsgICAgICAgY29uc3QgY2hhciAq
IGNvbnN0ICpwYXJlbnRfbmFtZXM7DQo+ID4gPg0KPiA+ID4gUGxlYXNlIGRvbid0IHVzZSBzdHJp
bmdzIGZvciBwYXJlbnQgbmFtZXMuDQo+ID4gU29ycnksIGRvIHlvdSBtZWFuIHVzZSBjbGtfcGFy
ZW50X2RhdGEgc3RydWN0IGZvciBwYXJlbnQ/DQo+ID4gICAgICAgICArY29uc3Qgc3RydWN0IGNs
a19wYXJlbnRfZGF0YSAgIHBhcmVudDsgICAgICAgICAvKiBGb3IgZ2F0ZSAqLw0KPiA+ICAgICAg
ICAgK2NvbnN0IHN0cnVjdCBjbGtfcGFyZW50X2RhdGEgICAqcGFyZW50czsgICAgICAgICAgICAg
ICAvKg0KPiBGb3IgbXV4ICovDQo+IA0KPiBZZXMuDQpBbmQgSSBmaW5kIGEgYmV0dGVyIHdheSBm
b3IgcGFyZW50X2RhdGEuIFRoZSBmb2xsb3dpbmcgaXMgbXkgbW9kaWZpY2F0aW9uLiANCkFuZCBw
YXJlbnRfZGF0YSB3aWxsIGJlIHVuaW9uIGRhdGEgc3RydWN0dXJlLiBMaWtlIGZvbGxvd2luZy4N
CklzIHRoaXMgZ29vZCBkaXJlY3Rpb24/IA0KDQojZGVmaW5lIERJVklERVJfQ0xLKF9pZCwgX25h
bWUsIF9wYXJlbnQsIF9yZWcsIF9zaGlmdCwgX3dpZHRoLCBfZGl2X3RhYmxlKSBcDQoJW19pZF0g
PSB7IFwNCgkJLnR5cGUgPSBDTEtfRElWSURFUiwgXA0KCQkubmFtZSA9IF9uYW1lLCBcDQoJCS5k
YXRhID0geyBcDQoJCQkuZGl2ID0geyBcDQoJCQkJLnBhcmVudCA9IF9wYXJlbnQsIFwNCgkJCQku
cmVnID0gX3JlZywgXA0KCQkJCS5iaXRfc2hpZnQgPSBfc2hpZnQsIFwNCgkJCQkuYml0X3dpZHRo
ID0gX3dpZHRoLCBcDQoJCQkJLmRpdl90YWJsZSA9IF9kaXZfdGFibGUsIFwNCgkJCX0sIFwNCgkJ
fSwgXA0KCX0NCnN0cnVjdCBhc3QyNzAwX2Nsa19pbmZvIHsNCgljb25zdCBjaGFyICpuYW1lOw0K
CXU4IGNsa19pZHg7DQoJdTMyIHJlZzsNCgl1MzIgdHlwZTsNCgl1bmlvbiB7DQoJCXN0cnVjdCBh
c3QyNzAwX2Nsa19maXhlZF9mYWN0b3JfZGF0YSBmYWN0b3I7DQoJCXN0cnVjdCBhc3QyNzAwX2Ns
a19maXhlZF9yYXRlX2RhdGEgcmF0ZTsNCgkJc3RydWN0IGFzdDI3MDBfY2xrX2dhdGVfZGF0YSBn
YXRlOw0KCQlzdHJ1Y3QgYXN0MjcwMF9jbGtfZGl2X2RhdGEgZGl2Ow0KCQlzdHJ1Y3QgYXN0Mjcw
MF9jbGtfcGxsX2RhdGEgcGxsOw0KCQlzdHJ1Y3QgYXN0MjcwMF9jbGtfbXV4X2RhdGEgbXV4Ow0K
CX0gZGF0YTsNCn07DQoNCnN0cnVjdCBhc3QyNzAwX2Nsa19kaXZfZGF0YSB7DQoJY29uc3Qgc3Ry
dWN0IGNsa19kaXZfdGFibGUgKmRpdl90YWJsZTsNCgljb25zdCBzdHJ1Y3QgY2xrX3BhcmVudF9k
YXRhICpwYXJlbnQ7DQoJdTggYml0X3NoaWZ0Ow0KCXU4IGJpdF93aWR0aDsNCgl1MzIgcmVnOw0K
fTsNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBhc3QyNzAwX2Nsa19pbmZvIGFzdDI3MDBfc2N1MF9j
bGtfaW5mb1tdIF9faW5pdGNvbnN0ID0gew0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQoJ
RElWSURFUl9DTEsoU0NVMF9DTEtfQUhCLCAic29jMC1haGIiLCBzb2MwX2FoYm11eCwNCgkJICAg
IFNDVTBfSFdTVFJBUDEsIDUsIDIsIGFzdDI3MDBfaGNsa19kaXZfdGFibGUpLA0KLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICBjb25zdCBzdHJ1
Y3QgY2xrX2Rpdl90YWJsZSAqZGl2X3RhYmxlOw0KPiA+ID4gPiArICAgICAgIHVuc2lnbmVkIGxv
bmcgZml4ZWRfcmF0ZTsNCj4gPiA+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgbXVsdDsNCj4gPiA+
ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgZGl2Ow0KPiA+ID4gPiArICAgICAgIHUzMiByZWc7DQo+
ID4gPiA+ICsgICAgICAgdTMyIGZsYWdzOw0KPiA+ID4gPiArICAgICAgIHUzMiB0eXBlOw0KPiA+
ID4gPiArICAgICAgIHU4IGNsa19pZHg7DQo+ID4gPiA+ICsgICAgICAgdTggYml0X3NoaWZ0Ow0K
PiA+ID4gPiArICAgICAgIHU4IGJpdF93aWR0aDsNCj4gPiA+ID4gKyAgICAgICB1OCBudW1fcGFy
ZW50czsNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+IFsuLi5dDQo+ID4gPiA+ICsNCj4g
PiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX2Rpdl90YWJsZSBhc3QyNzAwX2Nsa19kaXZf
dGFibGUyW10gPSB7DQo+ID4gPiA+ICsgICAgICAgeyAweDAsIDIgfSwNCj4gPiA+ID4gKyAgICAg
ICB7IDB4MSwgNCB9LA0KPiA+ID4gPiArICAgICAgIHsgMHgyLCA2IH0sDQo+ID4gPiA+ICsgICAg
ICAgeyAweDMsIDggfSwNCj4gPiA+ID4gKyAgICAgICB7IDB4NCwgMTAgfSwNCj4gPiA+ID4gKyAg
ICAgICB7IDB4NSwgMTIgfSwNCj4gPiA+ID4gKyAgICAgICB7IDB4NiwgMTQgfSwNCj4gPiA+ID4g
KyAgICAgICB7IDB4NywgMTYgfSwNCj4gPiA+DQo+ID4gPiBJc24ndCB0aGlzIHRoZSBkZWZhdWx0
IGRpdmlkZXIgc2V0dGluZyBmb3Igc3RydWN0IGNsa19kaXZpZGVyPw0KPiA+IFNvcnJ5LCBJIGRv
bid0IGNhdGNoIHlvdXIgcG9pbnQuDQo+ID4gdGhlIFNvQyBkbyBoYXZlIGRlZmF1bHQgZGl2aWRl
ciBzZXR0aW5nLiBCdXQgaXQgY2FuIGJlIG1vZGlmaWVkLg0KPiA+IEFuZCBhbHNvIGhhdmUgZGlm
ZmVyZW50IGRpdmlkZXIgdGFibGUgc2V0dGluZy4NCj4gDQo+IEkgbWVhbiB0aGF0IHRoaXMgaXMg
dGhlIHdheSB0aGF0IHN0cnVjdCBjbGtfZGl2aWRlciB3b3JrcyBhbHJlYWR5LiBTbyB5b3UgZG9u
J3QNCj4gbmVlZCB0byBtYWtlIHRoZSBjbGtfZGl2X3RhYmxlIGFycmF5IGZvciB3aGF0IGlzIHN1
cHBvcnRlZCBpbiBjb2RlLg0KDQpTb3JyeSwgSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQuIEJ1dCBJ
IHRyYWNlIHRoZSBjb2RlIGRpZG4ndCBnZXQgYW55IGNsdWUuICJjbGtfZGl2aWRlciB3b3JrIGFs
cmVhZHkiLg0KZmluYWxseSBmdW5jdGlvbiBjYWxsIHdpbGwgYmUgX19jbGtfaHdfcmVnaXN0ZXJf
ZGl2aWRlcg0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2Ry
aXZlcnMvY2xrL2Nsay1kaXZpZGVyLmMjTDU4OQ0KSXQgc3RpbGwgbmVlZCB0YWJsZSBwb2ludCBu
ZWVkIHRvIGFkZHJlc3MuIENhbiB5b3UgZ2l2ZSBtZSBtb3JlIGRpcmVjdGlvbiBvciBleGFtcGxl
Pw0KDQoNCj4gDQo+ID4gPg0KPiA+ID4gPiArICAgICAgIHsgMCB9DQo+ID4gPiA+ICt9Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19kaXZfdGFibGUgYXN0Mjcw
MF9jbGtfdWFydF9kaXZfdGFibGVbXSA9IHsNCj4gPiA+ID4gKyAgICAgICB7IDB4MCwgMSB9LA0K
PiA+ID4gPiArICAgICAgIHsgMHgxLCAxMyB9LA0KPiA+ID4gPiArICAgICAgIHsgMCB9DQo+ID4g
PiBbLi4uXQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgLmJpdF9zaGlmdCA9IDIzLA0KPiA+ID4g
PiArICAgICAgICAgICAgICAgLmJpdF93aWR0aCA9IDMsDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAuZGl2X3RhYmxlID0gYXN0MjcwMF9jbGtfZGl2X3RhYmxlMiwNCj4gPiA+ID4gKyAgICAgICB9
LA0KPiA+ID4gPiArICAgICAgIFtTQ1UwX0NMS19HQVRFX01DTEtdID0gew0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgLnR5cGUgPSBDTEtfR0FURV9BU1BFRUQsDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAubmFtZSA9ICJtY2xrLWdhdGUiLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLnBhcmVu
dF9uYW1lcyA9IChjb25zdCBjaGFyICpbXSl7ICJzb2MwLW1wbGwiLCB9LA0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgLnJlZyA9IFNDVTBfQ0xLX1NUT1AsDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAuY2xrX2lkeCA9IDAsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAuZmxhZ3MgPSBDTEtfSVNf
Q1JJVElDQUwsDQo+ID4gPiA+ICsgICAgICAgfSwNCj4gPiA+ID4gKyAgICAgICBbU0NVMF9DTEtf
R0FURV9FQ0xLXSA9IHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC50eXBlID0gQ0xLX0dBVEVf
QVNQRUVELA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLm5hbWUgPSAiZWNsay1nYXRlIiwNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIC5wYXJlbnRfbmFtZXMgPSAoY29uc3QgY2hhciAqW10peyAg
fSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC5yZWcgPSBTQ1UwX0NMS19TVE9QLA0KPiA+ID4g
PiArICAgICAgICAgICAgICAgLmNsa19pZHggPSAxLA0KPiA+ID4gPiArICAgICAgIH0sDQo+ID4g
PiA+ICsgICAgICAgW1NDVTBfQ0xLX0dBVEVfMkRDTEtdID0gew0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgLnR5cGUgPSBDTEtfR0FURV9BU1BFRUQsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAu
bmFtZSA9ICJnY2xrLWdhdGUiLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLnBhcmVudF9uYW1l
cyA9IChjb25zdCBjaGFyICpbXSl7ICB9LA0KPiA+ID4NCj4gPiA+IFRoaXMgaGFzIG5vIHBhcmVu
dD8gV2h5IGlzIHBhcmVudF9uYW1lcyBzZXQgdG8gYW4gZW1wdHkgYXJyYXk/DQo+ID4gRHVlIHRv
IEkgdXNlIGNsay0+cGFyZW50X25hbWVzWzBdIGZvciBjbGtfaHdfcmVnaXN0ZXJfZ2F0ZSwgY29u
c3QgY2hhcg0KPiAqbmFtZSBwYXJhbWV0ZXIgaW5wdXQuDQo+ID4gSWYgbnVsbCwgdGhhdCB3aWxs
IGNhdXNlIHBhbmljIGZvciBOVUxMIHBvaW50Lg0KPiANCj4gQnV0IHRoZSBwYXJlbnQgaXMgTlVM
TD8gSG93IG1hbnkgcGFyZW50cyBkb2VzIHRoaXMgY2xrIGhhdmU/DQoNCkkgd2lsbCByZW1vdmUg
dGhpcyBpbiBhcnJheS4NCkkgd2lsbCBkbyBwYXJlbnRfbmFtZXMgPSBwYXJlbnQgPyAmcGFyZW50
LT5uYW1lIDogTlVMTDsgdG8gY2hlY2sgbnVsbC4NCj4gDQo+ID4gPg0KPiA+ID4gPiArICAgICAg
IGlmICghY2xrX2RhdGEpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2bV9vZl9w
bGF0Zm9ybV9wb3B1bGF0ZShkZXYpOw0KPiA+ID4NCj4gPiA+IFdoYXQgaXMgYmVpbmcgcG9wdWxh
dGVkPyBJc24ndCB0aGVyZSBhbHdheXMgY2xrX2RhdGE/DQo+ID4gWWVzLCBpdCBpcyBhbHdheXMg
Y2xrX2RhdGEsIEkgd2lsbCBtb2RpZnkgdG8gYmUgZm9sbG93aW5nLCBpcyBpdCBvaz8NCj4gPiBJ
ZighY2xrX2RhdGEpDQo+ID4gICAgICAgICBSZXR1cm4gLUVOT0RFVjsNCj4gPg0KPiANCj4gU3Vy
ZS4NCj4gDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGRvbid0IHVzZSBzdHJpbmdzIGZvciBwYXJlbnRf
bmFtZXMuIFVzZSBjbGtfaHcgcG9pbnRlcnMgb3IgRFQNCj4gaW5kaWNlcy4NCj4gPiBVc2UgY2xr
X3BhcmVlbnRfZGF0YSBpcyBpdCBvayA/DQo+IA0KPiBZZXMuDQo=

