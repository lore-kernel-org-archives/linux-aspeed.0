Return-Path: <linux-aspeed+bounces-243-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C038E7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBQxp6Wrtz2xjK;
	Mon, 16 Dec 2024 14:52:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::70d" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734321150;
	cv=pass; b=O3ECJW2Z0Eao3hZvAEXB6mNxjGxjQ4ftMIc/7rEO3hvibzQuaxOvZBFtCej1NbxjZqh62TW/fq0LBdZVKoMk14zZiostuCnYHQaWL9ICexAXFomq+dVrtqR3dQIz4BJZwGEsIe8w9+FEdPtgJRnq6+BDxivN1It24l59eeGMf+C+Eh+r+iyf2Kf+DBw9e45WuMpRSipvjedF3w6qznaMq+OfvGSu3S08yxxm567R4jn0YwVZuhblJ3ni5Prv0welRscaKV52d13Vo6q/kKp+b7//PtJ6YkMFvTx8OfQgsXEq7ANNmqvY5ZuiFECveCS/Z6GmNLRWEOVWXpjd4FUNnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734321150; c=relaxed/relaxed;
	bh=Vnk88sYLBRKljOkLTnnJFRKY5Fo92aKoBXRPdaj2DgU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ndCVPx2I6bV43jmmUAxOyvpgsiLVy6+A3VTAmO7oWA6gwVdAyftL/h9tkmKWICSUqwBQrK2G6pxCuo6LjkWahUAXxB3X2V7EmvUZ8uD27czm8+rLjl7Qfy6txkiThXoPfgy5qOKREknxzZut3iFCbxJizlyVbYaFZwWJg2hLrc1UZ5tKXuEcjZXHAf2mYswSB7GPa6/5J6VBXyROdOzrX2Jazfk+yoza49GZviitF7nOx0ZopC7YOlld6zetPcX6P+a+o+YfsGzUVI96kPGBXccjub//11BpsSvPdMcdhMrrR6XCAWZfHJfdgxXqWSXG5ZMvsZK2M89MTaUTSQsyDA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=LRsKC+zd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200f::70d; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=LRsKC+zd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::70d; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::70d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBQxn74bdz2xbS
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 14:52:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x55jjMQjpprkmMnqgYpmuojQ0Y+kgXcul6gojGhVug36ybB/ksYAlzxNa63axKRzQgmm+anaZBt2k9PN0L1b34sYI8cWUilS534M97gwKQy7pI55MpZ9oRpu26i0aNAd4u7S5Wk4X1hUjbuLLBtYP0VY/nmlM67Vr/ZGnb/xubBSAO/QFLxcRWe0HOsYcgHusUiEvYagjtITO5jNcTUPjKFIrnBXEX+UU77CxwtYdysDvMRgGMLxpir/cPTYxxh7XSIZ4C7gl20FJi4w87rm8WBPyCb1XgN9jh1E8FKV/eiyD9MG2hHIIjJWmr9RAxCgx8EWYPRkoB6RX5I5WyH1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnk88sYLBRKljOkLTnnJFRKY5Fo92aKoBXRPdaj2DgU=;
 b=EodJMGyjv1LnYMLPoG6EkbIGUoBcLPSQ5IXMb2ycXvXx3+zF8r/fzawZZQIaxJoq9YgymLkb4E+eQZXfccuWvvJWgAPJS3Tp4OnGAyXACtrOz3Enl1MKV9O7Uhndc+sA06RCRVtRN2BMDyEzf1nJbyAFHQ1VUH7R+C6eeD/SaJW5V/562GJi3z8banOLEIxy4ODo/bi4tco2j88jfDvs1apUmh4Hochqh2k1WH13VBfcAnh8QBbjIOA3X2B2UNVf+KRcuAT7nFfwsuRzIOAAz0hT1h0PeaAMAZxxtz+BrQHLSwpbaOLVgM5nl6J3F9BQuBDhpg/6OHkaCotOdCCXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnk88sYLBRKljOkLTnnJFRKY5Fo92aKoBXRPdaj2DgU=;
 b=LRsKC+zdtSRs/6j6/54wWp5gimpI9ntpkvvicHauvUfk19n5aIyK8JWSk98AjoZsBK4AyBQP0CRYrmIC4fa30P2YDIf17ZIZXvQ6oiivZOJxpFkuedMSWptRiLhHST3iQDVPRU4bs8BAEk9PlLG72h72+/+j1hK1prBfKm4wTlXA7zWwJhWOyZRPq1+sM1bQyUKyRWZB+/Eunctt6aNcgTzPDiphr5iXn/AWG9tFyoRWLfPiPQnMZXIMIcjAePsGeKXDDfWxWQIBBuX3BXQ4f74RqSKq9HHOho6FrQNvbsO4fEhPF26EU2U+9GLO5SjFRfVNL2erYK1QwhOCVsz/ig==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.10; Mon, 16 Dec
 2024 03:34:53 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 03:34:52 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"konradybcio@kernel.org" <konradybcio@kernel.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
Thread-Topic: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
Thread-Index: AQHbTK3jpAwOf3M7kkqeKzDuH2LfgrLjoJAAgASclEA=
Date: Mon, 16 Dec 2024 03:34:52 +0000
Message-ID:
 <PSAPR06MB49493DBCC874A32174E3C180893B2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <5d91b7a7169e6db27b2493213d0df2b77699a49e.camel@codeconstruct.com.au>
In-Reply-To:
 <5d91b7a7169e6db27b2493213d0df2b77699a49e.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 05c7f18c-9561-4ce7-208f-08dd1d829a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NURNK1hMbWs1WFFFNEhkc0ZDRzVPeGtRK3p4dUNnTHZwaTZSelM4V3dDSStV?=
 =?utf-8?B?UFRSeG9vWnlGeUxxSTI2cDRTdHhxbWMrYWxFNXljajRXdkRicW5aY2txYXJK?=
 =?utf-8?B?YVFnQkR0K3EwczIxam4zNW41d2Mrb01RRlJqL1Ryc1NSem1EYW9WOVRIL2Js?=
 =?utf-8?B?RmM3Qm10WTh1eStMQWNyYkJmaWVMTW56NlErUkJubXFYWDZ5bTFDWC9sZUJD?=
 =?utf-8?B?c2JOU1VKQjNUSjBTdDVORHpvb2IvWXZXNld5bTJhRjZSbytRd085N05MVENk?=
 =?utf-8?B?SVVZUWJXWTZmWXJiZmlCUEZORjlFbzduZDRlMUxVYWk0ZHNaWUdVQ1Z1Wmky?=
 =?utf-8?B?ZWVZb0N6YnNXeGpCSThKZmtMSlJTWVJsVWJrSnVUN0RSQXF5MVU2UTQ4VlVa?=
 =?utf-8?B?b1N0NzhzYzJVdS9NYW9BYitOaUs0SWF1K3YwVXRwcEtNSFNrS0pBQlprWUk0?=
 =?utf-8?B?eTg4QnQ3Q2tUOHJndko1QmlTd1JCdnk3SzAyV2JuRGhQWmF3TW9yNnhGOHAv?=
 =?utf-8?B?THlZT3VncXpudDlHZStFVkVlVm9ObTNjcFgxN1M2MkVjME9VUVJPQmpaTThD?=
 =?utf-8?B?eU04NE5PY2RpQzlmL3FXVnNwN2FRdXUzZHZGd29rQlNrK1U4N1ZvcC9GbEdC?=
 =?utf-8?B?ekpyaUZuK0p2WWh4RExRdElPTlQ5b2NNM2dzeFhyNkM0RmprOFEvVGNnTnZK?=
 =?utf-8?B?MXJMQXNiVGRWWWRzTTdxc1JSUDdvajdCbXgxS0Nma29QNWxFTlc2QlRvRjFM?=
 =?utf-8?B?SEZWbjhZSnZNNUF5aE51c2s3QWhkd2VhTDFwcjhVaGQzZitObU1Ec0JreGdP?=
 =?utf-8?B?QTVlSTBzQUZMaXM2WlVSS0kvaEU5eURoa2NUVTh4RkwzeC91QmthbVlNbEF1?=
 =?utf-8?B?M01qcm1naElLbzNJOEZsZU00Q1hKZDZMbkRwMkZGY24yd2VEdjBOdS9lRlVQ?=
 =?utf-8?B?MzcxSzBNZDBLVWMzMFJWWWhFcmI3MENCeHEzMnV5UUEwOHZHeHJKeVJIQS96?=
 =?utf-8?B?ay94Z3RQZ09pcVBXQnhaQmFWRFJyaEtaREJKNUJkVlVBVFI5czZFNXR6TFRN?=
 =?utf-8?B?VlkwNE9qbEJYVU95STA0S1RGMUZSU29KVHh2bWs1S2xQTHJwZDFNelpVTmwy?=
 =?utf-8?B?ZVV2TTlndDlhR0xKQlBLNHZ6UXdaQU1KS3JZTlZlamxMbkJTZ004Y05WVUFk?=
 =?utf-8?B?dU5Lb2ZXZ1VZT0paSEVUVXZxWkFoZkQwb1p0MDlhR3ZycjdOaHkxTERUQzQx?=
 =?utf-8?B?TmxhdHVXbVh2V00zMkE0UWp2N3RzUmF1dCthcStwUmlKKzRzNVpSa2RUN3Vh?=
 =?utf-8?B?VGY4VG52bTJsQmtpYXJDa2FoWXVkNFNVNy9FelRxUGMra2k2RDNOR1NuTGRn?=
 =?utf-8?B?SWpob0xod0MwYUl5UE90Z1ZyUGVKalhUYy9ZL0NzeFhoWCttanBveVBVWVpk?=
 =?utf-8?B?TEh6WXkwT2l4LzlCbE92NlhDemxJOThNczMvSk5STWY2UmxZU1FyVlhPLzBx?=
 =?utf-8?B?akM1MWcvRUZ1eURjNlBzcWZleUNuTm1uMlhwNzJBS09weTZnNjdWZ25JTjZR?=
 =?utf-8?B?L2g4SWpzZVBYUXZvZS9lY1FpamVTdXRSL3Q3cGl0YlBXQkJBSm1OVVE3YTlH?=
 =?utf-8?B?T1A1eElQN2RNS2NtK0Yycy9LV1NaM2l4ZGF2RThSUkFNV1ppWVoxQUpWRkkx?=
 =?utf-8?B?QWhLdVJ0bFU5eUxHUWNjbU1MVkJWSm5hVmpjNmxuMmtVNFVTUENGUTlvLzJs?=
 =?utf-8?B?TlFFcy9ncnlwOFNXRTRQeCtjQmhocFpIMVBNclVSRWxyd3kwZjI2aUlvMUJE?=
 =?utf-8?B?ZUlNazRKSmpBVzNORXRKMEM1UGQ0bm1XcDNlSjI0K3QvSkNscE9kVHdzNHRi?=
 =?utf-8?B?eFo0ZVExL2dnSDBKZGwrNzc1bUdmV0VuWi9rL0dRVldGSExUUHJWYkRCa3My?=
 =?utf-8?B?RDd6TVJQeklxeng4d1BKRnhON29jOU93bEQrdW9UWksvMVpuY0xQVHROOEwr?=
 =?utf-8?B?RG9menprdDJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUlyamhmRmFYUHFSMUhTZXpnMTJXY2xmTjRQQUlQOEljeldnSUg1dkhnaTNs?=
 =?utf-8?B?NnZFNjk2RS9rTzFzM0k3aTIyYVlOaURkZUQ2d2dMU05DVGx0L2hMWEhTRSs2?=
 =?utf-8?B?UlpYLzNDN25BZ29vQ0I2QjROTEFhdEs4YnplY1g4K0VheFlhSk1adjNIb1ZG?=
 =?utf-8?B?bkhhVjRPNDl6cUFsUDhNTEVleE9YTURrbWordkxLNThiT09JY3c0cUV4WDJD?=
 =?utf-8?B?NHlMaTZFNHdKaWtlaGpZZ0RyY0EyN1R1SUt6SkRUOVlXR2lTZTY1VGtLMDNm?=
 =?utf-8?B?cFlOVGNsS3Z0OEVlWjZVYlB3RFNlekRSelREd2JxMzRFcitqdWRIOG9xc0t4?=
 =?utf-8?B?VkdSNFZoRGM5Z1VjWUpQblNDcEQ3Q05KenFsaEI0Z2dlYzB6T3YxbVRUbVU2?=
 =?utf-8?B?OW1GcXdxdmxEbTdmMmRhZndtbU52S1IvMDJERldoaDRsOFJEQklIdkpoZHk0?=
 =?utf-8?B?aFlyRTBtV1F5UzZwN3Y2cTVmZFI5R1ZFdFJkM2xDRkVnR1VYa3RaSW96MUlw?=
 =?utf-8?B?RnpsVDZBSGcwWXdKN1RSSk44aXUyenFiaHpZNlE5WVV3ZHZkam0vbzJZRWNX?=
 =?utf-8?B?WkQzSDNad2pycExaQVlsT3RRWDhMM09HTWt1K2dhd3BKY1hjeWVXQitjN3JH?=
 =?utf-8?B?SUF6bG5RWlhjcjR2UEh2QkxZN3NTL2tiYnRRL1lrbUxHWHR6SVFKUnFqT2p4?=
 =?utf-8?B?cmFubzJ6NHFMeHErU2FuRUJhM2hEK0FXeHE1NHNGZDVyRCtiTXhSbmtRY3Zl?=
 =?utf-8?B?WjRJMHVsVWpLK1l1RDNoS09zMnIyeG9qdkFWUlR5MVJzYmw1SlYwdllGdisy?=
 =?utf-8?B?a3pBRGR5TW0yKzBjbk15Ym91MmZuR2Q4TEJ0a3B1OU5MK2I5RkNGbGFkaHFo?=
 =?utf-8?B?aEc1Q2laK1dkY0ZUNmNZL0R1VEh5WlhLOXNoK2dtL3dkY0czTkRsQjNnNFdM?=
 =?utf-8?B?RlZEdURoQktlY1lHT1pzU0xTSDRaSkVVOCtLZmhLRGM3UGFvSk1maUZPSzQz?=
 =?utf-8?B?aDlYdzJmMVc1U2tGendJamo1RzI2ZnpveDRIb1VnNm9NUkc0ODBBM3hWbHVn?=
 =?utf-8?B?akZhTjFXRW1UZHNWRXVYaXE0aVk2VmhJRHBvWmhxbE9GWnNjam9zMnpWTXpp?=
 =?utf-8?B?eHBsWDhzd1daV2xGSDg0cmEvZCtNdHB2T0F1NHNOY2lEajFMOTBER3VUU2Nt?=
 =?utf-8?B?STZVR00yMWJrbURINlhabk84Ym02a1d4NFRub013Szc2Z0dNcUFVam00cGRv?=
 =?utf-8?B?MDFKSHIvSEZBMVhtZURWQ05oZGFKVUJHR2tkWUMyazd4enZSNytRclFBQU45?=
 =?utf-8?B?Y1FsMFJ6T3UybzBvZGtEZEhDbXZhL3Vjd2pDZzI4cWp3RDBQMzJGSk1uNG45?=
 =?utf-8?B?V0JBNkhIWlVNRmxick9vMkxaRzNwMDE3WjZUNm5QVkdlYkhxMitnNHBOM2g0?=
 =?utf-8?B?c0s2Sk5ncXBhWmVFZ01KbFRlZ0hhL0NySEdiblB1a1JzOUNvSnFSQmk1SWFG?=
 =?utf-8?B?ZWpaV3dZd251c1pUbVNFZjd3dU1WaXRRWlJEK2FuY3U1MDZiUDBlNEdEcGEx?=
 =?utf-8?B?TXhQYXptR2hCMFYzT3FLZkNRTytjbCtIMW1NREM5VU0vM01vaml6dHp4cUxE?=
 =?utf-8?B?RlNQYkVUQVFCNEt2L0lEZzBVbFZ1dTBiSHFuU2phUFZHR0s4UVFvVWpCWGxr?=
 =?utf-8?B?YU92RktnTHEvTCt2UWhXQ1lPWGdYNk01ZkdwK2dBUzRvTVExdHlNd1hqYk1O?=
 =?utf-8?B?cy9KR2ZkTjE4QlJmV3NTWG9jMUNkandBSWFYZFF0bm5JZ0xDTjNFeXVHNFQr?=
 =?utf-8?B?Uk9JQnZ0L3ZJeXVFZGNUTGx1Sml6NnFvRDJyN0dJSHNmcDI0dnBNWWtIQlY0?=
 =?utf-8?B?SGd3bXNscm9SSStlZWRTNU9aSlNLdXhZRVoyWEZZNjZsaVhzdTdXM3czaXFD?=
 =?utf-8?B?YzdYYVp4bEdoWmZFdUZWZjFFWFlkSWJPRENyOHQ5enZTdkJBY251aU1CdVVy?=
 =?utf-8?B?bWNpd0pSSG8xYllUWkxyMkw1VTZOOTFrZHduR2pnWHRnOGtJL3dmV0hEYk9M?=
 =?utf-8?B?T0t1UzJYcitKcE03VFBtdjBKdGpubjRUekkyNlBNaVk2WmlHL0k4aWZtTWk4?=
 =?utf-8?Q?7kjkd3SlIl9wW76CajsqbpAH6?=
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
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c7f18c-9561-4ce7-208f-08dd1d829a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 03:34:52.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QzbDWw9AE5q+eDZ/U0nzHXyl8fSX76uJ0NHMq0tJN6JbRJN9Yq0smXcBWgSAtu87KCftzKKPe0ZlmIft7XkgN+cUMDEaFAt/qGp5fQjHtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459

SGksDQoNCj4gPiAtLS0NCj4gPiB2MzoNCj4gPiDCoCAtIFNwbGl0IGNsayBhbmQgcmVzZXQgZHJp
dmVyIHRvIG90aGVyIGNvbW1pdHMsIHdoaWNoIGFyZSBpbiBzZXJpZXMNCj4gPiBvZg0KPiA+IMKg
wqDCoCAiQWRkIHN1cHBvcnQgZm9yIEFTVDI3MDAgY2xrIGRyaXZlciIuDQo+ID4gwqAgLSBGb3Ig
Qk1DIGNvbnNvbGUgYnkgVUFSVDEyLCBhZGQgdWFydDEyIHVzaW5nIEFTUEVFRCBJTlRDDQo+ID4g
YXJjaGl0ZWN0dXJlLg0KPiA+DQo+ID4gYXNwZWVkLGFzdDI3MDAtaW50Yy55YW1sDQo+ID4gwqAg
LSBBZGQgbWluSXRlbXMgdG8gMSB0byBmaXggdGhlIHdhcm5pbmcgYnkgIm1ha2UgZHRic19jaGVj
ayBXPTEiLg0KPiA+IMKgIC0gQWRkIGludGMxIGludG8gZXhhbXBsZS4NCj4gPg0KPiA+IEtjb25m
aWcucGxhdGZvcm1zDQo+ID4gwqAgLSBSZW1vdmUgTUFDSF9BU1BFRURfRzcuDQo+ID4NCj4gPiBL
ZXZpbiBDaGVuICg2KToNCj4gPiDCoCBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6
IFJlZmluZSBzaXplL2ludGVycnVwdC1jZWxsIHVzYWdlLg0KPiA+IMKgIGR0LWJpbmRpbmdzOiBh
cm06IGFzcGVlZDogQWRkIEFTUEVFRCBBU1QyN1hYIFNvQw0KPiA+IMKgIGFybTY0OiBhc3BlZWQ6
IEFkZCBzdXBwb3J0IGZvciBBU1BFRUQgQVNUMjdYWCBCTUMgU29DDQo+ID4gwqAgYXJtNjQ6IGR0
czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyN1hYIGRldmljZSB0cmVlDQo+ID4gwqAgYXJtNjQ6
IGR0czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyNzAwIEVWQiBkZXZpY2UgdHJlZQ0KPiA+IMKg
IGFybTY0OiBkZWZjb25maWc6IEFkZCBBU1BFRUQgQVNUMjcwMCBmYW1pbHkgc3VwcG9ydA0KPiAN
Cj4gRG8geW91IG1pbmQgc2VuZGluZyBhIHY0LCBiZWNhdXNlIEkgcmVjZWl2ZWQgYSBjb25mdXNp
bmcgYXJyYW5nZW1lbnQgb2YNCj4gcGF0Y2hlczoNCk9LLiBJIHB1dCBhIG1peGVkIGNvbW1pdHMg
aW4gb3VyIHNlbmQtbWFpbCBzZXJ2ZXIuIEkgd2lsbCB0cnkgdG8gc2VuZCB2NCBwYXRjaGVzLg0K
VGhhbmtzIGZvciB5b3VyIHJlbWluZGVyLg0KDQo+IA0KPiBbUEFUQ0ggdjMgMS82XSBkdC1iaW5k
aW5nczogYXJtOiBhc3BlZWQ6IEFkZCBBU1BFRUQgQVNUMjdYWCBTb0MgW1BBVENIIHYzDQo+IDEv
Nl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250cm9sbGVyOiBSZWZpbmUgc2l6ZS9pbnRlcnJ1
cHQtY2VsbCB1c2FnZS4NCj4gW1BBVENIIHYzIDIvNl0gZHQtYmluZGluZ3M6IGFybTogYXNwZWVk
OiBBZGQgQVNQRUVEIEFTVDI3WFggU29DIFtQQVRDSCB2Mw0KPiAyLzZdIGR0LWJpbmRpbmdzOiBp
bnRlcnJ1cHQtY29udHJvbGxlcjogRml4IHRoZSBzaXplLWNlbGxzIGluIGFzdDI3MDAtaW50YyAu
Li4NCj4gDQo+IFdoZXJlIHRoZSBjb250ZW50IG9mDQo+IA0KPiAgICBbUEFUQ0ggdjMgMS82XSBk
dC1iaW5kaW5nczogYXJtOiBhc3BlZWQ6IEFkZCBBU1BFRUQgQVNUMjdYWCBTb0MNCj4gDQo+IGFu
ZA0KPiANCj4gICAgW1BBVENIIHYzIDIvNl0gZHQtYmluZGluZ3M6IGFybTogYXNwZWVkOiBBZGQg
QVNQRUVEIEFTVDI3WFggU29DDQo+IA0KPiBEaWZmZXJzLCBhcyBkb2VzIHRoZSBjb250ZW50IG9m
DQo+IA0KPiAgICBbUEFUQ0ggdjMgMS82XSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xs
ZXI6IFJlZmluZSBzaXplL2ludGVycnVwdC1jZWxsDQo+IHVzYWdlLg0KPiANCj4gYW5kDQo+IA0K
PiAgICBbUEFUQ0ggdjMgMi82XSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IEZp
eCB0aGUgc2l6ZS1jZWxscyBpbg0KPiBhc3QyNzAwLWludGMNCj4gDQo+IERlc3BpdGUgc291bmRp
bmcgbGlrZSB0aGV5IG1pZ2h0IGhhdmUgdGhlIHNhbWUgaW50ZW50DQo+IA0KPiBBbmRyZXcNCg==

