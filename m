Return-Path: <linux-aspeed+bounces-1420-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B132C71136
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 01:22:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJM7x6d80z2xWc;
	Fri, 13 Jun 2025 11:22:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749777741;
	cv=pass; b=UcDJHGl13u8MKbblfsIhJY4+lPD9Kuqe4RxXhhfovD7uz7OO217JWYfJQ3QN2B8RhG9sNddsyFLaIWAREJqEHsi7pe9kXWNSfJscYMSci8Q2N65DIQv7/2WQEiW1qDiLKYH/HxlebC9wQbCpq0A+nKvpI6Szf0F5DsREPB0hd7tbzMeXv2j6B4jf8j/LEDYMUwWwusM853FVIbm33PPXb+9Zbs5mJd9erczKGDDrtcKPYwvpoyprjwfYTImv/AOs19LajqKSLQY0gy+TSBbzoXBPiz/Fi/HPI4zbYH+xmQlK4t2EU2BNRqlUe87+xdaJZg+o4S70mG7DZEb+7ndlzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749777741; c=relaxed/relaxed;
	bh=lNCabB8Yj3170PaStTn8UZr8jZ9Gh4SCPdhrDWQDDsU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2KyrY7N7WlilT57JLvw7SAHXvMQAAFKGURONZ18TGy6NkXEXPvVsjaJEYewxfh4rzqSQkoBLU5CYQljZfnYuffcAa7DfDLnwjsKq2TRZ83mqhFusdTRGDlsj0BZEDa2vR59nZiLhA4Q6+BaNT5Ou9KJog0GctPpCkYQUyg3ARNl7f2I/aBfyzL0yS0rzakdUZFkG+PWHQsKDHRAyWw89DXeirifpwhzpYlm5mnsKt+UyviyJ3MguBGR/EDNoxaqk2Xe9kqiSx35FboMhF2G+OmFTwfvb97Wu+vOiXztFugE9GLoNUfJxfADk05YJlEFE1WxwFR8Ij0s8XfJL2+n9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=H8CBEmR2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=H8CBEmR2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJM7x2nS2z2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 11:22:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxisy5uOnP2Sli/OzuiQMTxO3AlVuLW5/352xz3M5f2Q2Ikgs5Ia2KF1DO1u0D3CixwVb25tnHDIafW6FBkVs2/KfaolR7+/Pv7Fe+Lm3hQKnLZRe/OviFVE7q5aDFVhwLFfHDhIIEJXbrJ5zWk3C0/M7miTa86trGnhcZOKHNiO4aAQUzirF8fQw1hUDZ6vqAn992Jg2Gdi4LhKcFvdVVT9u8HIsDhHxLoIEiAQAQfOUKCN2mgiSMgSfevSGnbSUhJQalvdfbBccN9Zn3Lxc8HHTUOKmuccYhUhvbuDkAszDEC6UjWsA7XuJruDZkB13IutGYNZB8bibhXG8vJi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNCabB8Yj3170PaStTn8UZr8jZ9Gh4SCPdhrDWQDDsU=;
 b=DwcNt3t5FSnR8yvm5QtdbHISRl2Mg4zkHdk3AoEUP6SmBIoE6wK8RQrykk3gaqej8GjNEOCfBx+PN6MATKVV2tYzeMZ6ZGIg/gPgi+paXJ5mkeL8IR5Pw8g4ruv8Yu0fL0lwGStyAT5Wq2MrOUFbWNvn2aoxRMDkffnR+LaqpegDKAj7TXt4a4ejrEWK9qDsFxf756Uoi0n550muTPgWXtfnu3i8dS6sMP/4RUl23aWVRHErikeGiy2cDXwweMNa8NK2HUpZ5hPSg+/rzrCPWnXwltD5e+eiB6XuH7t+oLFspr9mt9nuBiWF0NysGlNDg6a7CKWrFJXAhnBMtQm62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNCabB8Yj3170PaStTn8UZr8jZ9Gh4SCPdhrDWQDDsU=;
 b=H8CBEmR2l3ar+RXpHP4xx30loOlRtmTJzWuH8xIOFDAk32CP1qLhaVJpkQNJ9TgiO8JQajjzoT8PAJQsgysY7efu9Yq3Tl0y3j/uiCGiJ0AUbHi/2JmxcPwI1bSoSMuAnNpEo40ToovUBw9eyQPTbM+/v4nRUTt1bL3TjGMMajLlDbNG+gidPdnX0AVPql7FriB64Jolgpuxp2RxoRvTh2wb3EKELkKlWY4W4czU5VyBS2Cd43T4YGyhg6ZMgbgUrYVSyBv6LPyvWA+uVXF76yBNQy590QYoRW/Q/gTUExEzdCiYdEa1O1c3Cbq/7z87uOsKQ1XTx+3OI2UkqiIFzg==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by OSQPR06MB7280.apcprd06.prod.outlook.com (2603:1096:604:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 01:21:57 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 01:21:56 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Topic: [PATCH v3 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Index: AQHb2eeI4a5F3MN24Eu/ozXuvO4n07QAO/MAgAAJjECAAALcAIAABqtQ
Date: Fri, 13 Jun 2025 01:21:56 +0000
Message-ID:
 <TYZPR06MB6568D65A1288D30981D9A85EF177A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
	 <20250610091026.49724-3-jammy_huang@aspeedtech.com>
	 <13b88c1e404a9abe5cfae6673cb93e0b020e3524.camel@codeconstruct.com.au>
	 <TYZPR06MB6568BA93BCEEBEE3B9DE15EBF177A@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <831a5bf06f6e7cd7dccce77d11209b5cc0f1387c.camel@codeconstruct.com.au>
In-Reply-To:
 <831a5bf06f6e7cd7dccce77d11209b5cc0f1387c.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|OSQPR06MB7280:EE_
x-ms-office365-filtering-correlation-id: 4019d55d-3fd7-48ef-dfee-08ddaa18b03f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEV5di9ia29jR3lvYTJOeTdGdEphbVBaNWFXa2NBMWJ5MXF2RG1aV1NmOEtm?=
 =?utf-8?B?RjNqUlpyZjZPOWs4aXpGaXE2ZjNvQ09ZVi9reDVkL3RsenhNcllDd09PWTl3?=
 =?utf-8?B?SlJvQ3hkNHRnSTMwMW9jbkJkZTNGN0ZQMytVUDJNaG5HVnhVZld1TTNQNG1P?=
 =?utf-8?B?c0V5TGVOMXlpNGFiMWM3R3NvYWtROStHLzd5VWhScGVkdm11bGQyMm5vVys4?=
 =?utf-8?B?RWNpVXdHY0YyaTR1T083K3YyelRNTzMvR3lGV3RMSXMvNVdMK0hjSlQzdk56?=
 =?utf-8?B?YVhlc0IrUWRMTWY4UnhyajJGRHB2ayt2dHo0TSszbU9Oa0VraEswM3ZRYkMy?=
 =?utf-8?B?ZXJCZDZBaXNwT1BzblJOZXdzUjZ6aGhneTR6MEZhSTRPWXlKTS9PUDRhVkxj?=
 =?utf-8?B?UjZ0T1d4aklUM3Q3Zkl2MzZtRU0xc2xPNXF4dVdJZE1ZWTFjUUd1TElLeDZJ?=
 =?utf-8?B?YTYvQWh5UXVBZFFrOFhOVllwYSt1YVdCTG8wRFBWSVUzV1hkZ2JhNkx1b3lU?=
 =?utf-8?B?KzRkMzM5a3RZTzBKd3BPREtYQTlsRnVFaDVrMlR3MWxDMVovZU5wM2ExRE5W?=
 =?utf-8?B?MkcyZ1FXeUl6SWVXYzA5ekRlY3Q3L1BUZVVJVHFIMHFuMDJ5L0NHRWVlOGgw?=
 =?utf-8?B?ZmRXTUErYkw3V1NwSGhrMzZJclo1dU1sS3hocXYyNEFpcjEvYnpRczJQb1Ba?=
 =?utf-8?B?NHJsU2FVZFg0TDV5YTRsYVNJNUZlUzZIYWZJSDc5NTFmZEpyVVk0RWw0R3cy?=
 =?utf-8?B?V2YwRStOTUllZmNCN0RyUTMrNFRIZjNPWW9sd2JGalVRSGxTb0RDZzZvSDhT?=
 =?utf-8?B?elR4Tkxack9MSGhRWXg4WW44aWF4MDFvSVNHZGFPTk8xR2lmcSs5eGIyQzMr?=
 =?utf-8?B?U3Y5NUM0b3Jka2FvZXJLY0JtdUg2c2hicUk2ZE51ek5BZ0pncElkZEFzNjhF?=
 =?utf-8?B?dFlla0ZmejVMbmRkVXdyYThKSU9aWWJQZHNWUHI1bE5aR0E4cEFMbzZ0MDMv?=
 =?utf-8?B?Y2JMQW1palpnZ1pMTytqUlhZVTZlbWc5VW8wRnFROEs2ZFVjRzgzWWhFcmlr?=
 =?utf-8?B?Y3JoTWZ6RCt4RXRZTGxjbVFIQ2wyVTZwU3ZxemlWckw2eURsbW5QbFV0Z3kz?=
 =?utf-8?B?dGpyNWpYT2tKNi9XR29wK2o2S1psb3dobUl5WlVZWnlUVFNsQ1hIOGNYb3Zu?=
 =?utf-8?B?WkZRM2M4WlpmVW11cHZMNnByeWhnUVdCcDJtNWN4dlZ0eGQvZXF6ekEwaU9T?=
 =?utf-8?B?dzhlTWQ0MEhLV3ZXenJkWWJQdkkrdjNYamVhZXRYeFM0Q2RZT0o0RVVRcGVR?=
 =?utf-8?B?b1REUVh4Mmp6eWl5WTQzanN2Mno3YmNQOEJkQzJjamllTXEySkRieHZIaC85?=
 =?utf-8?B?SGNEOVRCN2hIb0gvZDQzak9aQ2dMUTFFR044WVN3U3FrTXdIR0lDZVdBLzZz?=
 =?utf-8?B?bEZQQ1U2WlZZcCtJRFQ4MWhQR0lSU1JVV1IwWjZIVXRqQ09wNUVoR2IvZG01?=
 =?utf-8?B?UVp0ZzIzbkxNYnRwaThMemoyNUE5QzJOMW1zN3NwZG5EQit2eDcrWTBtNXpv?=
 =?utf-8?B?bkVLK1lZcVdKczBQMlhRWU04d1V5dkJ5MUY0dGFyYzRMWDM5ZmdZNWx1UERm?=
 =?utf-8?B?elhYTkZRQWZibjJxU2U5YmppYmc3aG1lTm16cXZkamFKZXdnbU1icWtnL2cx?=
 =?utf-8?B?VWlURnpTeHhSY2dpcncyZ242bkl3UWY1QkI5bTU2b0xMTG1Cb1lIYmxiWk9L?=
 =?utf-8?B?OWZYUjhRMVJQWXU2cjczNGdiZTZwZXdRVVZLWjNxZzRWV3R0V2xGbVVReXBS?=
 =?utf-8?B?b0RjUmh2WTM3QjkxVlZHaXRVZ3ZpU3RjWjExb2dsbkwzL0t6T3doTXk5SWRF?=
 =?utf-8?B?RktwQVppV2dVKzA0akJQQTE1eHU0a3d2d2FhWU1ka3BKMXZmM1UxNDBsY1Qw?=
 =?utf-8?B?bzFPYU1oQXZuQlZvZXRSSnJNWHRSSk1BVTVBY3VEMEJrY3l5cDFob0JHMGdt?=
 =?utf-8?Q?yD23xo8QUEjJk93rpG0rMKPbK5aatY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTRtalhuaEtXN0xsLzI3WVFmQlhSdTB4ZXBRUmJQY0h1T09CZ3ZMMlJkOFpu?=
 =?utf-8?B?M0ZjWDVUV1ZjT3VIaWpNVEN3YUJENlV5MkpkMlJQQ0pxdVcrbDhxcS9oSEdF?=
 =?utf-8?B?MStRdHVidTQ2UU9jdm90bDNZVm1vMkE4Y2s5ZDRhSkhaOFliS2w1aDhFTjFo?=
 =?utf-8?B?d2xIemlCZFU1NXRBQjRMaEw4NFVGUTRNTVc0dURtUVJKVXRkd2ltZmt6REZU?=
 =?utf-8?B?aUNkZHJtMGdQVjhldGJ0a2Rwa2ZrV0d0eG1lQkJGTHo0SVFXQkFpc1VSMmhB?=
 =?utf-8?B?T1FXS2VlVWF1b2pPeDFia1p4RFQ3MkFsc2preE5iM05RU3pmeldPNUN4SGRW?=
 =?utf-8?B?Um93TWJ6WGNIczVpRSsrZVVwNmppa3A5cHFMcGdjSnFHRlRtQVdiV29NNS9s?=
 =?utf-8?B?VVV4TTEyVjZsZ01xYWw3cGhIcGpTR0ozMVNVazJTL1o1cU5xRXhBUTFWcHh4?=
 =?utf-8?B?NFY0bHpSZkc0YzJtZGdCbi9xM3hTT3ZrTnV6UHdTbEVEVXRoU2orT1dhNEJp?=
 =?utf-8?B?UDBkREVpSWdGOHVIRm16MGpxeVpxQkdCTlZrakVMNUJLWmIrbDc4TzVMeDk2?=
 =?utf-8?B?LzIzR2QweFAwTG1CeUE5T09kSDA4ckRNT3JLVE0wTkRyWVBMeVRtQkRvYzhZ?=
 =?utf-8?B?NStTeGM3RDhCMVVSNXFidmVsUy9KbW85Rk5mdnoyeTBhTWs1YitvUTEzdms4?=
 =?utf-8?B?VE1NQmZKK0w1bzd3YmZNYWlDZlovdGFqTXhrdWdLT0RiaGZXWjc4dVM3Vjkv?=
 =?utf-8?B?Q1RoNEk3QlJRYThKaFkzdm95OFZ0eHU5Vkp3djRGZ1gvdlZla0U2ZzJZbWR0?=
 =?utf-8?B?ajgwMGI4RGhaSlJWZENYcTdsZmR6WVIzeDY3Zi9ENms5REc0MGJRZHZYaTFm?=
 =?utf-8?B?WDlMZkhmZzNNdWJwMTdOcEZtcE1yNzlZd0lFTG1sN2FUK3ArSVFPWG5WbFVl?=
 =?utf-8?B?eE1CSWVxTDVoWkg1N1ZhZ3k4WnM2WWFsWGo3Vk9BdFU5ajRXRkdBWEpiUEQv?=
 =?utf-8?B?VVl0Y3hQaHRxbGR4Q29oU3BWdjM3T09POUgyZEJwUU5QTUxnMldRazRXMzNB?=
 =?utf-8?B?a21USUtZbklGczF5ZkFOR0tYVHRQT0c4b3RnL2xZNjVxK1JrSlJObldHT2Fo?=
 =?utf-8?B?OTVsWVJrdzdFMXNKMkhTVWhCTXF0em5naXFyNW1jTFZpZE55cnZMVGlzM3Bt?=
 =?utf-8?B?ZWcwTU1TdHpOYmVaSEtOeUxPV0ZPUEliUitQd21icXg1M3I4Szh2SysxNVNP?=
 =?utf-8?B?QzhycVFUdy9yOFRxSFVaQzZqdUpnZ2xaR0U3RmZLdTY5WUd4bWkrcllBZFhv?=
 =?utf-8?B?c0NsZVM2OVcxZHNDOG51cHJOc3JlZkpLakk3TGtJOFh5SWxkOU1tQWV2L2RQ?=
 =?utf-8?B?OXdOWGh2TWsyRHVPOVRqTnhEUloveUtuUUw3bTVQY0FDVUFsSVRzYzFMY213?=
 =?utf-8?B?aDZzL2MvOWtHMDdwM0xXQjArMEd1WUhrS1FKcDZ6RHVOODl2ZVIyUTlWU2Vi?=
 =?utf-8?B?ak8xWUhUdFBGZ0ZQa1ZDSmxsemJ1alppTzZCZmxGS29icDQydTlWdlNsbkRl?=
 =?utf-8?B?QjQ2TFVwcG9Ick4ySEdXMktXSzZmblZPa2dEVlhEQ1JxQklyWkY0RHE0aHVq?=
 =?utf-8?B?Vzl3dDgrV0hDOWJyVjRiMFdWd0xNWndMZlM3enI3NmtCSlMxRGdLS1A4UExj?=
 =?utf-8?B?RWhBeEp3UXE5TmV3c0pTT2IraTAwVFM3alBvOEhIbnJKcStxMGEybzM3R2Iy?=
 =?utf-8?B?RHhadk12MWxnVUtMV3V0UjVURmYvOFNyM0k0dmRGMlMyNDhSN1lQdWtWZlpp?=
 =?utf-8?B?RjVRdG01WlMzL3hEc2pUaDUvVlZObG5peWgzZitkeSsyUmxnSm0rTGkvZnR5?=
 =?utf-8?B?U1VnN0gyR3BJLzNNOHVzNFZBTnJuRyt6NzdKVExyS3UyWGRtRmNyQnFqYlFs?=
 =?utf-8?B?QlJrcTdPd0h6b0VsOWhqVFcxdGJ3WkdlcFZvWHh6V2o4NXBwVnoyLzhUUEFY?=
 =?utf-8?B?cjJjd2x4VEpVbHlVTkFYcVBlU3cvWGFsNFdwT0NHa1dzeUNzeERlTStseUdK?=
 =?utf-8?B?TFloKyszQmEzcTM1NTREdmJTUHFEZHl0M1BDTDhrMzVGbCtEVXVUZkVsS3A3?=
 =?utf-8?B?elAwNmxJMmpJa0U4Z0RabEZaK3FQc1lTdnhRZGxWUk9oSmt0QjFkWXNDaTdL?=
 =?utf-8?B?SGc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4019d55d-3fd7-48ef-dfee-08ddaa18b03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 01:21:56.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUS/N7RGDILWZUi2pmiSthbZYClJts8bf3/Bp0U6vwVPekGjVA7pzETp3HDKcZVp9x5XIRX1GLqUBgsqSwLoROvN9noPgGRodlj/fX4jnQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7280

PiANCj4gT24gRnJpLCAyMDI1LTA2LTEzIGF0IDAwOjUxICswMDAwLCBKYW1teSBIdWFuZyB3cm90
ZToNCj4gPiBIZWxsbyBBbmRyZXcsDQo+ID4NCj4gPiBZb3UgY2FuIGZpbmQgaXQgaW4gY2hhcHRl
ciBvZiBhc3QyNzAwIGRhdGFzaGVldCBiZWxvdy4NCj4gPiDCoCBJSUkgRnVuY3Rpb24gUmVnaXN0
ZXJzIC0+IDEyIEludGVyIFByb2Nlc3NvcnMgQ29tbXVuaWNhdGlvbiAoSVBDKQ0KPiANCj4gR3Jl
YXQsIHRoYW5rcy4gVGhlIGRlc2NyaXB0aW9uIGluIHRoZSBtZW1vcnkgc3BhY2UgYWxsb2NhdGlv
biB0YWJsZSBkb2Vzbid0DQo+IG1hdGNoIHRoZSBjaGFwdGVyIGhlYWRpbmcsIHdoaWNoIGlzIHdo
YXQgdHJpcHBlZCBtZSB1cCAoIkludGVyUHJvY2Vzc29yDQo+IENvbnRyb2xsZXIiIHZzICJJbnRl
ciBQcm9jZXNzb3JzIENvbW11bmljYXRpb24iKS4NCj4gDQo+IEFuZHJldw0KDQpUaGFua3MgZm9y
IHlvdXIgcmVtaW5kZXIuIFdlIHdpbGwgY29ycmVjdCBpdCBpbiBuZXcgZGF0YXNoZWV0Lg0KDQpS
ZWdhcmRzLA0KSmFtbXkgSHVhbmcNCg0K

