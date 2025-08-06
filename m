Return-Path: <linux-aspeed+bounces-1908-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0810DC87FD1
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 02:55:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxZfR3JWyz30W5;
	Wed,  6 Aug 2025 12:55:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754448927;
	cv=pass; b=IINydXEduPE5cCSPDeCzp67G2CcfXt8ZzxlOMMaZXVuTDMn8G+TAgJXgup/12mH+LFKabEss/DgUlo8+8PMTGyWo2x0eJ+3OBWoXzRtQwwAv7PNMT+70R4o/u3h2RO+xX9c5o5giKTxdt01kbumUABpF9ovpCCGipkbTHUs2Nf17EKSJI7chPF1Pk36/VBH2Tmdc7yIQ9OwgUJMghcyUB7JYf/jdP9024O8jOm9EWse1cT5Sn8NUl/pJARxkVJyL400rBezV6qO8suKwyWltmZZU5a2qqjgS4nFVdqPy6ePGzL1roPOkTxkTT9KbSguBZlTrfSvfeTE9rhQo4rbMTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754448927; c=relaxed/relaxed;
	bh=HIPjQNI2Wng/loJNM7D0XiKUFYAzfsdAlmqeZCF4/tI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUbJws9kHz+5Lij8Y/NMe5fE7doxvJB/4IjdGRg//CrrWjaGiOKBIJUEorUPkdUe15IuNcZijXr/YvS9Eqnv7Pzr52gz0aal85bkOwdR/DuclLhXNRPjCCfZjC21Jw5viUhlKrZKm7+m6S+IXNzkCV5p77VJSDofCu1qLuSQst5FL2gBl41X3dXVNgNEd8o9+v5oeBFk3b51bacgmyad3T0KHcS7SJN7Dz6V4dGizLfxJGTAEVx67D0FyQu89e80D7sdmEITgq/Ww28pZK0AJ7DQAA464xS30V4TBIOvzXezbG0pj0fzQ4meM1M62ZqSffNm2Ws2dj0GfZLoCOfhmA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Mm9o+X9P; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Mm9o+X9P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxZfP65Zhz2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 12:55:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB8udkW5jq8rbhT7SIoiZzJb6NUt5/+RPMwfNxcz6wox42KeXry9WNtoXtwivIHBMpmvTDXM5o+OMK2AoYXA0T5lNN9WzA6Y85jfixXKDYo33ayrwAaaSlFrZxTFxEOn8hlUMxQIwsQo36c7Bh6GGYQZSmuZfKlhyymTw9h+qGNJuQVSge0ztNCW7hMR4x3p5NuBc93LPyAw4rjEB0+MNsgOjdNqxz7M6A4Vtf/PgXNIj0kCBU3arbFaEuwCTXm2aSQtFdmarzaj0eAVx86I6zT4zD9rVYQW9CMaNNAI8YWtpEunWUb/9G3b7TxQyaJilnmFi/xHJfGyTp+QuSMoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIPjQNI2Wng/loJNM7D0XiKUFYAzfsdAlmqeZCF4/tI=;
 b=wZiq8yQ513YR5BQthVxVdvo1wVuoqt9wvH3E43xiGn+EeVBpBbuPQHpnhW61WXrc9CuEqxszRpPx+DyENmyHJ/Hk0RNH3c+pw1lVUQc0IuFSVOseC4JnnZb3a9u39YoGP/Cu4fsSqYjxNibg8ixVp2B95LOdFA1yMs7qY5to5PDi5bzvI6CqvKSQrZ6N1e0AoFOlBFWhZx7TMKw5wAO3F4rx8nzi1/8L3/J9MQOYT3BTQU4BiZJUJIZ3qDhEe+ZikRp4U2DbyRCRM96BGfYZLRbkGGK1iAmRuxzSBrQM9twlP+z/eOgzs+zx6jjBSPZ3tsdNJn/ocICC1xonreBmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIPjQNI2Wng/loJNM7D0XiKUFYAzfsdAlmqeZCF4/tI=;
 b=Mm9o+X9Pqx2TF165FiuiTo64/ZvxIMmYYa7beFpKYXXLpFElszlVDc3O8k7bvp8r48ZNzlR8WM/LJQ+WGWhRjW6PREF+952CIEn2KW/e5/SQNYwCd/VEKfg5VaE3Ann4NxqOaWX5At7MGQ+OP9L3/156p4fOOaglc3KIf9IAFpJ+t7DEMFr3RZc6oEsU5NBi6CoPbMX0VT9TLzLlwxDAiSgffxMdDVzelJ2NjZWciTPOZiUfe6hbHwN2TIA1bCoE6RawDi+JDGTdh34tgX6j0BcdKLJZffFpzDk1jWEyzmMUtEby0u5CK2IqZP9HeHssSWLmhJsxqAznl/NBPrjHng==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB5063.apcprd06.prod.outlook.com (2603:1096:101:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:55:00 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 02:55:00 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/soc/aspeed: Add AST27XX SoC ID support
Thread-Topic: [PATCH] drivers/soc/aspeed: Add AST27XX SoC ID support
Thread-Index: AQHcBdPFcrZOhFLCe0ixLd10Nb8OdrRU04WAgAAavoA=
Date: Wed, 6 Aug 2025 02:54:59 +0000
Message-ID:
 <OS8PR06MB75416120C6B6588528A7FBA9F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250805063957.1452653-1-ryan_chen@aspeedtech.com>
 <182db4f2848dc7b8c110d45bb606e6219983c237.camel@codeconstruct.com.au>
In-Reply-To:
 <182db4f2848dc7b8c110d45bb606e6219983c237.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB5063:EE_
x-ms-office365-filtering-correlation-id: 45642437-5dea-4811-33ed-08ddd494a251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEJEdEV5MjZaUmJDWEVpOUJZNnlyMStiMVJLMnlDRmI1TURSN0dMU2x0em1Z?=
 =?utf-8?B?OVV4dnFzYnJndWEwSTg4QnRqQmxCT1p2Nld4dXk1WndWNDZpbjhOdFROV1VV?=
 =?utf-8?B?azkrS2RUc0o5OWg3eEhjMnJmSzZabDZHMlVFbHJYUjZQOFJHSUtXRnFIcnMx?=
 =?utf-8?B?aTZ4ckV1TU1FM3U0cjJGMURSSGFkTjRZTGsxNU5IQlZPWG05TnppNUw3TXdw?=
 =?utf-8?B?WDkwb1FiYWdmUkdDMERNaVBCWmgwMVR2U0t4ODlpZ3FNYzZwYS94c0xoSllx?=
 =?utf-8?B?NWlURGVXYWJycWh0bi9ZTVc1ZXpVSXViUmZxVGNXaVN4WXVWQjE4UTFtclpY?=
 =?utf-8?B?UnNBZGJRSmlxTzR6b215Q0xmRkxhS3dxYlNVMDBhOGJtaVV2ZkJoQk5MZ29K?=
 =?utf-8?B?Wm80L3RNTiswK21qejE4Wk9UdEJEeVVwaFFKd3ZFekZqS1d2ZGE0dnphcEdR?=
 =?utf-8?B?N0RJN2h3cUF5dTliTjJHKy9rdW42cHdHTXRPNmFhWjNpT3cwTUtZYnFKVGFC?=
 =?utf-8?B?WnpOQm45a2RIbmNYWFJiYmFvVGg5RnFvYlo0a3Y1YVIvSjcrMlNEbGs0ZmIx?=
 =?utf-8?B?WVV6MmRBY0V5U3BNak1JTWhacUJWWmlBYnN1a3lDZTh2YXNMSGJHbjhnSkli?=
 =?utf-8?B?Uy9PaWZ1L1RSbjVVZWFxL2F1TE9VNVh0cVYzNS9MV0VaeHhNek9KbWkrWTRp?=
 =?utf-8?B?eUs4TWluNHVPSStGc04xNHZNU2Zna3JDN2JhR2UybUlLSjIrSUEzSldYalcr?=
 =?utf-8?B?QnhRRHExQVlJUGc5RjYvc2lzVUFUSGtPa0hJSDduWm02UTllc0wyaCtNbC9y?=
 =?utf-8?B?R0M4NytGTzNZd0RDVldiTC9UNmNHUjV3Q2swWEFSeHBZbVJ6VzczTm1mcDJx?=
 =?utf-8?B?dGdxZEllOENxUHlhNkdYbE9oL0xDWmQ0ODloNEpHVUkvVWVrTEQyWUZ0ZThT?=
 =?utf-8?B?cUtudDNwM08xOXgyRlhGekFCSlJaTVZyRk5wMDlMOTJCQ2tOcmNmZXZkQzRr?=
 =?utf-8?B?SFJhUk1hQUN2b0ZRYURpcUwxeE1uQXFqOGJ0UlRLeS91cnljQ01YQXNPWEtz?=
 =?utf-8?B?ODBsYWhFT0VncGJOU0graHR0ZmZZdTN2U2RCckEzbW5zK05Mck5jbmxnT0hN?=
 =?utf-8?B?THJiVFp6ZENzSmVQSHRkb3pnU3JRSEZOWWdHc29nTjlORFJtT245YmhkMWxo?=
 =?utf-8?B?aHVYbEpMVml3aGtYdGQrVzdMd2JMK1VieUFzODgyM1RwNVVIdjM4OURqWW1U?=
 =?utf-8?B?SmNiN1plcThWYnM3YnJ6YVBlYS8vdFNjUVBkZFdPc3hZdjVWSGI1dmVOYUVG?=
 =?utf-8?B?TW0zV25NY21XckF3eHRUSmpwLzNhY2hHd0NvUENYRmRzd04xM3E0dEtUNFZW?=
 =?utf-8?B?RjV3VVZPbFJoU0Z6ZkgyTi9KckN2TFRWeVMzQmZwcW5mVXFlUnJ0UENrNGVK?=
 =?utf-8?B?ZzFJOUM3ZlU5WTB2QlhZdnp5QWpPZHZXNkRieEJNYXRCcG5RbnFRWnpudysv?=
 =?utf-8?B?L04zYUM1S2dGOFMyZXduVThvMFV0d1MwbFVNN1RpeHlMenBJV0RTZExqMUZ2?=
 =?utf-8?B?S0kzZjQva1hub2xwREhoZ0hOWTErWWpkQ1FMZUhiM3Uzc0FiUWpJUWVpMGhB?=
 =?utf-8?B?NXVycGllakFtemp0aS9WL2xpOTVoRW9IUmVjOHJXQml1aHNQUzdtQWdKZzJC?=
 =?utf-8?B?NllacEpCV1piMnkwa1FqdjdhOGc2elhqRmZFM0pNc2lsY3o3ZDJCSXI0bXEy?=
 =?utf-8?B?RDZzYk9MVEJyTTNFM2d3UjVTMXUrbXJyOWlQMTNGcWQ2akdqK0hwYngwUVU4?=
 =?utf-8?B?elpqVXpkUm92OWRCbFhrd2pRdmsyRWtJZnU1QmlmRFVweW1oYmNRaVE4NkJm?=
 =?utf-8?B?VjVFQVU4ZHNIRjlNMjlnYnhiTXBKSkRtQXZ0a29DQmFjU2UxV3p0eG5XTjVq?=
 =?utf-8?B?Qzk4YnYxRDB5aUFIcExLbitNdTFZOC9NbjFPQWFHTUpMV3czSHZ2cE4ybWlh?=
 =?utf-8?Q?+3xMbHKqHQeVnxBCpf3z9zBU7Zqowo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTRGYTZQb2tPbTh2dnZnL0g5VjJuNmc2djZiS2VtMTVmQ0w4S1NZQTdsNUZQ?=
 =?utf-8?B?YXlxVm5EdXhzVVVVNCtSRFEvTlUzUmFvcDJ5UzJQRXJNcUgrK2RPc1NsVDE5?=
 =?utf-8?B?c3gwdkNaa2Q3OHNYNm41OG5ObUx3QXlBUFRVczZ6cTFhb1N0elU2ekI0ZEta?=
 =?utf-8?B?NFEwc1lKR3ZhZGpJeXc3TGtpcmxIYTJBcFR4V0VObi9PSUxlMkhveUR5dXFx?=
 =?utf-8?B?SFg2THh6UVlVb1VnSzJEaVZ5MkpjNm5BL3hXNjVSNFBpbExZVy8wckZKSkxt?=
 =?utf-8?B?V3hjbmd5SUJkd2xzQVBFUTBVU3NlMkpoa0xtWmlDRUV2dmJLS3JmSmV6azVL?=
 =?utf-8?B?UUxHakZNL2pzS0dOQnFUc2x2c2owOS9vWi9zT25jSzFsVHhCbmZHYVdveHBI?=
 =?utf-8?B?Y0JYbHR2d0dHMFpOK2I1UnpTRmVkK1ZrSVhiMU9wWTRGbE13cFk5NWErNnNU?=
 =?utf-8?B?UFdpWVZ0dzNVT2lPTy9hakJXSUppMlo2eWduRU5Ka082K200bk9FWGIySDJO?=
 =?utf-8?B?bXRUQldLMHJxMWRZVG9YelpTY0FxanRsaUh1Um9wL2l3Tmp6L3RCUGZ1V1JM?=
 =?utf-8?B?bXhDQzl2d095UmdtUHFvTExNc1F3MlNmR24zMWF1M2s0OGRjRFYrY2c5eTNi?=
 =?utf-8?B?Sk5HeDdyNExmd0lTbGtnRHBEaFFPY1JYcjR6N2FaQnBOV1Y2ZGtITnpVRVlO?=
 =?utf-8?B?emhIaVJtdUdFaUVIUm9RamVwVEttSXZnTFVRVDVCU0JzbDNDZmRpcTZmaUxy?=
 =?utf-8?B?eHR4ZlBUc2FhSWoyYWxtVFNkUEEwYnJIMTV5eklUS1NxRVlXUWJ4VlJPSzhz?=
 =?utf-8?B?ZE5MVy9DYlk1TnNaMkFXeVZlUmlzYXZhbVUycU51bXY0NmhNRDJhS1ZWMWdY?=
 =?utf-8?B?TDN4T2lMT0M4b20rbDR4Mkk0M0MwZUZBc28yeHBNZUZxSHZGOUx3d1hmeXNt?=
 =?utf-8?B?ZnZldU12TjAvcm5Kckd5YzY2NWhGTTFETUVNcWFBRWs3TytjcXJYRm1jOWhq?=
 =?utf-8?B?czBXQXN3emtKRDBYdndZZmVVbVlFcnhQTm82LzI0cVgrdnVPSVRHZGxwT3hZ?=
 =?utf-8?B?WHZkZnVFdjd6RGxBeEFtTTZueEhKQnBOTW1YenFKV1lQb3lFMEZoVTRrQlBS?=
 =?utf-8?B?djNReW9ZQVZtMGtaUDh0YjVGMTFVank5Q2I2NWFZVVJlaXp2S1pOTGpxclRG?=
 =?utf-8?B?UWdBd3VOZWRSb2pUWnRwQnJMSjFCT2p0aU1SZXV0elR1UVZHSmw3enRpZDJP?=
 =?utf-8?B?UHpsVXBTTVpHZ29UUWVvMXdQTHZIU2U2Q3B2eVZNcktjU3ROTUJveEpMUGZj?=
 =?utf-8?B?UmVRKzdyT2h1MlpWbm43OXdOR0tTU2Rra1ZxR2hNRnkvTWJyV29jdTVUSVpK?=
 =?utf-8?B?Zkt3Q05PKzMzRmUxT3NublJFallQK2RETFpxeWloRncyNEY0ckF6N09iYTNq?=
 =?utf-8?B?OWVyck1LcW1TKzZpTjVXSHFKWElYc0EwZzV2NWhuYVJXbmhwcXRoTlpuODZZ?=
 =?utf-8?B?Y3V1dHdTdWpDUFZWZmxndGlTVThjVENHbEZDMTNROWhFRDlyUEovSHJPV3Jr?=
 =?utf-8?B?bG1qRVBHN2V5K2p6NlhGcHlobTdkVS9PRkZvSjU0QWJJa3BSQk9JdTU0YlFC?=
 =?utf-8?B?dTAvT0p6a2NEbDFBUGpwL0o3cDdoblFLeHpFcW1jQWd2bHBBWStHTTZsYzNP?=
 =?utf-8?B?dGREL21WVHBybFpKMUhUajd4RVFnV09KNWFCL2lBKzMwbDRjZ1BqeXpoSkJw?=
 =?utf-8?B?SUxIR2VkeUxreUFFZER4MnVydFhtRzFRZjZvK0J4OXNCQjJSaEtWbGFNR0lk?=
 =?utf-8?B?TXdRNFNzZDdqaDlZbk5pZVUyM2U1Z0x1a2paUlVRYlB6ajN0ZFUyQzgraW5P?=
 =?utf-8?B?RFJnL2IrYnM5Q09KNWNKcGltVFl4MUpUQitRNENKOGplS05SUzZ4M0ppdU9X?=
 =?utf-8?B?TUhDanpVVklHdzdkbGdkQ3M1WXh6bmtLclVQMksyRWRWbVBFWTZJbFkyU0RR?=
 =?utf-8?B?QzVnT1AyL0RlMjRBNmRPWDUwTGVXbC91bkxhR0kvUG84UE03Kzk3SGhQWTBT?=
 =?utf-8?B?Tm5mdDJDbVA0cmw0eks1aWVSRWpFZjltZ1U3MTJoS2E2UFRoSHFuNUxkeUVU?=
 =?utf-8?Q?hvi/LItyXro+5gEd5cRxZs2Iz?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45642437-5dea-4811-33ed-08ddd494a251
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 02:54:59.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3GTorjAqm7+NuEfQpx6uUDuC+P2yIPe4Rg107z2fmuHlRi2eCh4BgGAPDrceIeWFgedUnO6z67YqxcqsdjpvmEIV7RRn1iYDYxW68RIsy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5063

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcml2ZXJzL3NvYy9hc3BlZWQ6IEFkZCBBU1QyN1hYIFNv
QyBJRCBzdXBwb3J0DQo+IA0KPiBIaSBSeWFuLA0KPiANCj4gUmVnYXJkaW5nIHRoZSBwYXRjaCBz
dWJqZWN0LCBjYW4geW91IHBsZWFzZSBmb2xsb3cgdGhlIHBhdHRlcm5zIGVzdGFibGlzaGVkIGJ5
DQo+IG90aGVyIGNvbW1pdHMgdW5kZXIgZHJpdmVycy9zb2MgPw0KTXkgbWlzdGFrZS4NCldpbGwg
dXBkYXRlIHN1YmplY3QgOiBTb2M6IGFzcGVlZDogc29jaW5mbzogQWRkIEFTVDI3eHggc2lsaWNv
biBJRHMNCg0KPiANCj4gU2VwYXJhdGVseSwgY2FuIHdlIGNvbmNlbnRyYXRlIGVmZm9ydHMgb24g
dHJ5aW5nIHRvIGdldCB0aGUgcGxhdGZvcm0gZGVmaW5pdGlvbg0KPiBiaXRzIHVwc3RyZWFtIGZv
ciB0aGUgQVNUMjcwMD8gQXJuZCdzIHJlY2VudCBuZXdzb2MgUFIgYWRkcyBzZXZlcmFsIG5ldw0K
PiBTb0NzIChhcyB0aGUgdGFnIG5hbWUgc3VnZ2VzdHMpLCB3aGljaCBpcyBhIGhlbHBmdWwNCj4g
cmVmZXJlbmNlOg0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvc29jL3NvYy5naXQvbG9nLz9oPXNvYy1uZXdzb2MtDQo+IDYuMTcNClllcywgd2ls
bCB0YWtlIGxvb2sgaW50byB0aGlzLiANCkl0IHdpbGwgYmUgbXkgYW5vdGhlciBwYXRjaCByZWZl
cmVuY2UgZm9yIGFzdDI3MDAuIA0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0
L2xpbnV4LWFzcGVlZC9saXN0Lz9zZXJpZXM9NDYwNjQ3DQoNCj4gDQo+IENoZWVycywNCj4gDQo+
IEFuZHJldw0KPiANCj4gT24gVHVlLCAyMDI1LTA4LTA1IGF0IDE0OjM5ICswODAwLCBSeWFuIENo
ZW4gd3JvdGU6DQo+ID4gRXh0ZW5kIHRoZSBBU1BFRUQgU29DIGluZm8gZHJpdmVyIHRvIHN1cHBv
cnQgQVNUMjdYWCBzaWxpY29uIElEcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hl
biA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9zb2Mv
YXNwZWVkL2FzcGVlZC1zb2NpbmZvLmMgfCA0ICsrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9hc3BlZWQv
YXNwZWVkLXNvY2luZm8uYw0KPiA+IGIvZHJpdmVycy9zb2MvYXNwZWVkL2FzcGVlZC1zb2NpbmZv
LmMNCj4gPiBpbmRleCAzZjc1OTEyMWRjMDAuLjY3ZTlhYzNkMDhlYyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9hc3BlZWQvYXNwZWVkLXNvY2luZm8uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
c29jL2FzcGVlZC9hc3BlZWQtc29jaW5mby5jDQo+ID4gQEAgLTI3LDYgKzI3LDEwIEBAIHN0YXRp
YyBzdHJ1Y3Qgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqB7ICJBU1QyNjIwIiwgMHgwNTAxMDIwMyB9
LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqB7ICJBU1QyNjA1IiwgMHgwNTAzMDEwMyB9LA0KPiA+IMKg
wqDCoMKgwqDCoMKgwqB7ICJBU1QyNjI1IiwgMHgwNTAzMDQwMyB9LA0KPiA+ICvCoMKgwqDCoMKg
wqDCoC8qIEFTVDI3MDAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqB7ICJBU1QyNzUwIiwgMHgwNjAw
MDAwMyB9LA0KPiA+ICvCoMKgwqDCoMKgwqDCoHsgIkFTVDI3MDAiLCAweDA2MDAwMTAzIH0sDQo+
ID4gK8KgwqDCoMKgwqDCoMKgeyAiQVNUMjcyMCIsIDB4MDYwMDAyMDMgfSwNCj4gPiDCoH07DQo+
ID4NCj4gPiDCoHN0YXRpYyBjb25zdCBjaGFyICpzaWxpY29uaWRfdG9fbmFtZSh1MzIgc2lsaWNv
bmlkKQ0KDQo=

