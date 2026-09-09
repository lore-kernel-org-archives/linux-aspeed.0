Return-Path: <linux-aspeed+bounces-4974-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61833C79FAD
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 05:39:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfqPJ0RvDz2ybK;
	Wed, 09 Sep 2026 15:39:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788932356;
	cv=pass; b=dtKWOFbtbV2djd0TOz2hM/CD1Uui2ykLNPI5LJ3OLbBhIZ9UN2kyxNNPLHpemwLX2x9vtQfhI8KlGSEgE1AMy3O/BNHWq9zTTcg6/TVpZ/I/FBlnAaaVH391J09o+YvKgQ96GbI2eQp04lO4+dOQVdl2H7IJFZ95Eg16wHikJ5zImwkiUnLwMxmBWxqA+HMRykyxyehqWcAaoPmm9Z44Gr4qmdh4eSpgAsGLtRJoIPHiit12YXH2jAXPq2WeuB2ozApwQFS6Jum7obHuZANqSnxqY7eX8jatrCsctom7N079yuqcMeLSW79bY2bAzWTfztwwoy3bLXKSnSP30Ooq3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788932356; c=relaxed/relaxed;
	bh=ZVuay2ygH6kVxVKvlz0Om1BuKM7dJq/bcF1Kl7hokGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XaTFKU1XMIrTjRSA1Jb6msCEICp9LamQym8UNqIQgVdtVQh9MZTWM9zmnp6tTvAyZS2RRQJosHZenLkq5a6kcMPVOiB2w92RxhAjcanUBikJOMwjdFsoqGGZJpzNAyMQlbahDs9xONGfC3JT8BSQak/Wsm1+asZABnGe1o73xCfsFoeOcQo1r9rm89evkI/+209qWuMjt37Ul0OvDs7kjg7oNmcIkrNnIsOkVqHBQOqZqimckqHPu7CbGEMzoiIixjIxQFwGWTw5IB3CJdPBLcg8snf/WEy5I5aTDj14Wa1R468DZUfTi+0GTHyjzHjURs1mfuGL30zevFF2ZF7TKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=esLFwPSj; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=esLFwPSj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfqPH163kz2y8c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 15:39:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8uLUKK7Jj/EI2jtg/XaYgNs/ULv9bJItlOWdYg+mpqf3bc8Is0efAX57m/YfRquEprAvb9yk6I7KTyHLrs6vDj8sB4VGSGdiqXNm2n92ocXBSQolLWTn0ZG1j+tXLOWGvwyEyhbonimqUqcf0l3sgrEqa8Lz4teVtyM8ikW1f8x+MUmUqPg9LIXdq34ArrPCyoGwv616kxfFUTn7AWQRQyt3ppbOZJ4FLDwEMcLyNKi0hFWNS7dSQWQXu8vwbXkGgc5K7PiVV5NSomSZgr4wQYS8VZ6jjoPC3+qE4MvLxAruM8e6K3bJ6rIfo6uWLD63JRwywSp89bfzTaqI5g/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVuay2ygH6kVxVKvlz0Om1BuKM7dJq/bcF1Kl7hokGk=;
 b=olvqwTseYghVZ2Kcqm3bnlCusdLAStir8jJaSwiZvhhAKRKrAQhywX+7hhz+hP/iqECSXIz9V75rHBNdKCldGkzd6ebUR20urnxCuGeo2mo1Huu6h8T2hdz23lYqqGKysLMgiPmXe6/xjrtNLhLfoD6dap3A97mX3FfoYyvqb49riRxgb7GH0/V6Fho2Vr7Y7MdW5AHyfrYoyC+oHp/xsEyLlcZmOsjJabciSiKSkZ+Jlsn8Z7pOUBWnnB1JYyvucKOiXw23YDzUSX+ShN/q+wR3wAcSQ/MjX8YEUlKo1DZslnAfANbwEEx/38zGsVmEMjCRtM8L4BUkv/bTUck1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVuay2ygH6kVxVKvlz0Om1BuKM7dJq/bcF1Kl7hokGk=;
 b=esLFwPSjn8dD9p9L8QzoNZejAA1iiyl1PjnT3YVP9dfTAlowHsK/V/AD1nOqVeBXKCdQrdgdBbBlMKhLFJ1OxgV7XGla0HjuixbQqVcYQV1IDixuJpxRTyD+nWP6rjoBH3URlyGYbo/vVvzHbgM+WdGZeLjkTO2tXPWrg5SLILDPGU8l8Fpb78x6iC7UFUP5p+uPgQc+ssZxPi+3MC308H9G5JBHvgtm+scShTYvpI5IvQ+/thC228EEbAsLlwd8KhLXxV2hI4VJ9BOyvAfaWL8RmHIfskTmb2EPPRxeBj6iN9NfiNEaQirm8J7F9q7twdGohtO8MRYJ+JZTPFKawg==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYZPR06MB6114.apcprd06.prod.outlook.com (2603:1096:400:33f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 05:38:51 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 05:38:49 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIDUvOF0gaTNjOiBtaXBpLWkzYy1oY2k6IEFkZCBzdXBwb3J0?=
 =?big5?Q?_for_the_AST2700_I3C_controller?=
Thread-Topic: [PATCH 5/8] i3c: mipi-i3c-hci: Add support for the AST2700 I3C
 controller
Thread-Index: AQHdOgYHXIjcRyibb0mr6MeKR00DvLa6OvWAgAuL4KU=
Date: Wed, 9 Sep 2026 05:38:49 +0000
Message-ID:
 <OSQPR06MB72525B77F0B3F5D094C4F7BF8BB02@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-5-19909e7cbd7e@aspeedtech.com>
 <apdBQ3GbChnlUk8b@lizhi-Precision-Tower-5810>
In-Reply-To: <apdBQ3GbChnlUk8b@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYZPR06MB6114:EE_
x-ms-office365-filtering-correlation-id: 03ac7aa1-e10f-4347-1257-08df0e34a018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|4143699003|5023799004|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 zYay9naIoGlJnwA+kiAbXMVqlANQitLP3KD9Ctt9tl17jPag4DON9yI3KbPo/cG4SaOW1evCadjqDImISf3g6f776YFxc8Ieh4p3h04Q0OucSdxqXiwx6fTwEs2NGZaX29F6J4UHQHPeuG9JxpiltmbVIsAood6u9bbDmvx4voB49IldS3bMs54c+E7pvxRqKT0rzCxku7y7AGW+GwaJKfzfbpGhdBBqPkM5my9R1PrwY7o/z+jr5180iEX39pWBNz+1B77yrzVHAPwTLODBThu0tPsejRxMj99dFzMhSOC+1DiDkdy2GzXloYMIzDMtp/3RLu9MzTVFPNvBXL2yOy8u7o4eLQq1ufLLw2O1N4O0qNdketAJ8+8GU/2iwE1ondSGAT0d79Gd3kAXY1Q9ukRGiDXfFTlV0HZ1fbrwWoyvqM/cqOxi+1w9lY/p4KJqRpWxFic1Ckb0sOc6MP8GFB0scY8dypdHcEm27Q5pON8KlbVKFBXFbZ9UTQmO5t8BLKPeuBrbNKvnf3VEy/Akr7K96tFTZML3BZ8gS19MCcFVO15Tfgk+chK7eAm/cEdNgw7nMsti+L/OijQhJ6R09D5MBiMHf5dxQhJ2Q/E8m5aoHITvCUFy0ndOvCmvEItgIKx8Vz/Pvx4mgSE5erPGm4N0nWqve1W3xwx1GcEXkRWjvcB/5d87ZGsVZHbgJvoOYxG9rJxnpfV6vAgtVi62se4rjDch50T1pwL5iiw7ENg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?K0pmRncwN1BIQ083Q0J5ZnZkSlJtVmRObExhNUNvWFNIcE1lK1ZHbHN6MGJUekEx?=
 =?big5?B?T3lJN09rWjdnWjdQcTV3MFdaVVMwYUs5MERMZVdwWW5VUm11VEF5NG5LL2kyYVJL?=
 =?big5?B?dlpRaGJ3aEhLNlk3eGczbFp5RXloeTZnRHg3eWpnZGhvZ2JOdzNwZkJac1FNVU5r?=
 =?big5?B?bWNqalF1ZlhmWWVGZlQ4UzZqVDlYYngrSGlBSWhXeml3c3JPdFhlMjJQVzIxWGhM?=
 =?big5?B?dnFMR2plTFc4VEpMb2JrTHdEMEUxVGQ0Y1YvM24xeDBWL0RqbnkvaHBvekwvK0Z6?=
 =?big5?B?M2JNeFZ6Q2lBWitZUUlJNzBBenFmWDRRdndFajlGR2N4d0pPSGY1aDRHYTAzVzJ0?=
 =?big5?B?UUZWbzg3MVBJbXRnd2VublNGbUhiUGE4MUxNUDJKaFI3aytUeXA0eGxYZXF4MURr?=
 =?big5?B?M05xWjhDL2crd0VQMzNZc1pmNmtScUZMQVBPZ0FTL1RHN0k2UnhHcXM1TXhsV3lT?=
 =?big5?B?VG80UVNxWTIyZFBBbXg3NDNFZmthRXhYRmdhRkQvUUswKzdMdnR0ZGdBZGdWY2ZW?=
 =?big5?B?a3JsSzNBRWluaUlZSDlyVG9ESFBRR2QxQWEvK215K0JabG4wcDFrQUJES3BCRFNh?=
 =?big5?B?dlFtWmxSZWsrb0wyS0pQVXZCZ0REWGR0WkU0YkRPVUNzS2hYK1U1a04rZGhJTTRL?=
 =?big5?B?Ky91UkZoQkY0RGEwQjErMFJlSDU4ejQ2eHdIMjljQW9pNW9odmNydXFWKzE3WGxn?=
 =?big5?B?b3A0eUduY243dldwUVBTdmlyd0F6Y1VxSlF1WlFlZk9uazJ5S1dYdHdHRUFFSHIw?=
 =?big5?B?SFgvdTE3NE5wdHplc2tYV2hjTWYrSXA5L0dleTJFNFg3VThCb2dtcXp5cGpvYkM5?=
 =?big5?B?cHQzVTRNcmtBQmNNbHB5ZUcydWxoa2JNTUtSMmZYdnZCd1hpekdmaXRRdmw5bmNh?=
 =?big5?B?ZkJIVW1jb2pGYnNENzQ5OWx1UWNMaXU4ajdwR2Z6T2tuUmNqZjdEb3R3SHNRVS9u?=
 =?big5?B?WGI1S1haZzdaejZZamhNYkV0Mk9yQlN2dzFnZWp3RjhQT242Mk9GRDI5OEJPVUpJ?=
 =?big5?B?MkpXWnFmQVJlRkZLZEpYdTd2Rlh6SG1BMlk1cGtVcDZLMFBuM0ZBK3pSeVlEVUtR?=
 =?big5?B?VGNheHZWSmkrL1FERTFjQUt0MERXMzFwM1lhdGdHM3FqRWdoSVRpQlZIbXIxWUYy?=
 =?big5?B?azB3K09sK1BXTHM4dEo1aTFFTWZVSkZBSjBzZUlmcjFJYkhHWjF3UmwzanlCZnBV?=
 =?big5?B?R0dVckdjeEFzcE9qSzMwbUcxNDd4bU5sditYNGVTUWRhdm51eW5DYWdxQWlJT0I3?=
 =?big5?B?a2JPdHVySUdyejhlakZyNHQwMFNITHRISElyTERQMElQcU0xNVR3dExYbnJoMmd1?=
 =?big5?B?bE9DaUhyZm9MY3hsZGNjRG5kNUllOU1nbVVTQVZ5a2c4aGtDUmRubGN0WlgwRHY0?=
 =?big5?B?U2ZOeElxblUyTWhxZzBZaldibHBBVjJNM3ZKR3JJbGpRaW1xcjhiTlRNL2FKd1la?=
 =?big5?B?S0kyUW0vRHU2b3RkUDlFdnVibXJLbDdqMU9lTitBWWtMZzRLL0M0d0RMSVBlZk5F?=
 =?big5?B?bUlGN2J5M2IyVVRJeFJjUEFRTTFuQkVpeW5yN2Y0NU9TSTZWSWs1WUdwYkhCVS84?=
 =?big5?B?M1JIeEtXZ2NvanluNTR0aUQzOFJJTzhNb09LcE5IWjV2K3pMMmNUbVI5Q1FtMHQ2?=
 =?big5?B?UVBTT1Q1S25HeTc2NU8rZEJ2Mmk1NGFzdk9tZkJtK1JnSGNpWnhWMlA3RW1XU0tX?=
 =?big5?B?NDhMeStFSzF4OHRtNSs1V2xnQWdaZ2lGUHZXZW1NK1A0R1I1Q0NnMngzUVFFcmV1?=
 =?big5?B?WFZ5bWlNRVhMV0FkTnBmak5oMHQ2N2pWY0wvYzlSRFQzcnMrOHA2UW9RTzFZcktW?=
 =?big5?B?UzN3ZzM3VlJKTndtN1NpMlVRNk9ndnVLTURNU2hrS2lkeURNOWNWSzNiZUgrRk1w?=
 =?big5?B?WmZiUUJwWCtMMkVxQUprQVNYemNmZ2FKMmtpTTJMSFRxNzE4UFo5UUc5UjRmQXF2?=
 =?big5?B?T1J2M1liTXdaeXNhZ1c5Qmw3MXpvOGNhbnBlQ2JHYUpZbVE0VTlzVkMyR1J6UWRu?=
 =?big5?B?Si9HbjhHVjluU0hoYkZOOEtTajZrNmlWUmVSVDQ3R25ibUpMcjUvMXdSYm1VYnJh?=
 =?big5?B?RVY2L21VZDAvU0FJS1hrajQyVllzRXVScjA0YjJGRVVnY3Nibk84SllBUDZXNHJW?=
 =?big5?B?UUFlL0t1RThVQlg0YTQ0N1RXMDJJYmpFL01VWjF2dWIzT2hLWFgySjkybXBxTDBS?=
 =?big5?B?VzNsak9oNXpkOWRiOVJEMUdrcTBGQT09?=
Content-Type: text/plain; charset="big5"
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ac7aa1-e10f-4347-1257-08df0e34a018
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 05:38:49.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8GEelFfRanseuqX3O6XEVD33koVQ20lwkOY5IkvZOjOl4S2/yErdQSQFuabInzIKRK6uGiTQiDXSwk8yj9jDgA0Rr01QkogiJZsKX6iom0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6114

PiA+ICBkcml2ZXJzL2kzYy9tYXN0ZXIvbWlwaS1pM2MtaGNpL3ZlbmRvcl9hc3BlZWQuYyB8IDIz
NCArKysrKysrKysrKysrKysrKysrKysrKysKPiA+ICBkcml2ZXJzL2kzYy9tYXN0ZXIvbWlwaS1p
M2MtaGNpL3ZlbmRvcl9hc3BlZWQuaCB8IDE3NCArKysrKysrKysrKysrKysrKysKCj4gbmVlZG4n
dCAidmVuZG9yIgoKT2theSwgSSB3aWxsIHJlbmFtZSB2ZW5kb3JfYXNwZWVkLltjaF0gdG8gYXNw
ZWVkLltjaF0KCj4gPiArc3RydWN0IGFzcGVlZF9pM2NfdmVuZG9yX2RhdGEgewo+ID4gKyAgICAg
dm9pZCBfX2lvbWVtICppbmhvdXNlX3JlZ3M7Cj4gPiArICAgICB2b2lkIF9faW9tZW0gKnBoeV9y
ZWdzOwo+ID4gKyAgICAgc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdDsKPiA+ICsgICAgIHN0cnVj
dCByZXNldF9jb250cm9sICpkbWFfcnN0Owo+ID4gKyAgICAgc3RydWN0IGNsayAqY2xrOwo+ID4g
K307Cgo+IHNob3VsZCBiZSBpbiBhc3BlZWQuYwoKT2theSwgSSB3aWxsIG1vdmUgaXQgaW50byBh
c3BlZWQuYy4gVGhlIG9ubHkgcGxhY2Ugb3V0c2lkZSB0aGF0IGZpbGUgdGhhdAp0b3VjaGVzIGl0
cyBmaWVsZHMgZGlyZWN0bHkgdG9kYXkgaXMgdGhlIHJlc2V0L2Nsb2NrIGFjcXVpc2l0aW9uIGlu
CnByb2JlKCkgLS0gdGhhdCdzIG1vdmluZyBpbnRvIGFzcGVlZC5jIGFzIHdlbGwgKHNlZSBiZWxv
dyksIHNvIG5vdGhpbmcKb3V0c2lkZSBhc3BlZWQuYyB3aWxsIG5lZWQgdGhlIHN0cnVjdCBsYXlv
dXQgYW55IG1vcmUuCgo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpc19hc3BlZWQoc3RydWN0IGkz
Y19oY2kgKmhjaSkKPiA+ICt7Cj4gPiArICAgICByZXR1cm4gb2ZfZGV2aWNlX2lzX2NvbXBhdGli
bGUoaGNpLT5tYXN0ZXIuZGV2Lm9mX25vZGUsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJhc3BlZWQsYXN0MjcwMC1pM2MtaGNpIik7Cj4gPiArfQoKPiBEb24ndCBz
dWdnZXN0IGlzX2FzcGVlZCgpLCB5b3Ugc3BsaXQgZWFjaCBmZWF0dXJlIGFuZCB1c2UgZHJ2ZGF0
YSBsaWtlCj4gcHJldmlvdXMgUVVJUksuCj4KPiBJdCB3aWxsIGJlY29tZSBjb21wbGV4IGlmIG5l
dyBjaGlwIGFwcGVhciwgc3VjaCBhc3BlZWQsYXN0MjgwMC1pM2MtaGNpLAoKT2theSwgSSB3aWxs
IGRyb3AgaXNfYXNwZWVkKCkgYW5kIHNwbGl0IGl0cyA5IGNhbGwgc2l0ZXMgaW50byBxdWlyawpi
aXRzIHNldCBmcm9tIHRoZSBtYXRjaCB0YWJsZToKCi0gSENJX1FVSVJLX1ZFTkRPUl9CVVNfU0VU
VVA6IGJ1c19pbml0KCkgYW5kIGRvX3Jlc2V0X2FuZF9yZXN0b3JlKCkKcGVyZm9ybWluZyB2ZW5k
b3Itc3BlY2lmaWMgY29udHJvbGxlciBzZXR1cCwgaW5jbHVkaW5nIGNsb2NrLXN0YWxsIGVuYWJs
ZS4KCi0gSENJX1FVSVJLX0JPQVJEX1BIWV9USU1JTkdTOiBidXNfaW5pdCgpIGFuZCBkb19yZXNl
dF9hbmRfcmVzdG9yZSgpCmFwcGx5aW5nIFBIWSB0aW1pbmcgc2V0dGluZ3MgZnJvbSB0aGUgYm9h
cmQncyBEVCBwcm9wZXJ0aWVzIHRocm91Z2ggdGhlCnZlbmRvci1zcGVjaWZpYyBQSFkgaW50ZXJm
YWNlLiBUaGUgbWF0Y2gtdGFibGUgYml0IGlkZW50aWZpZXMgY29udHJvbGxlcnMKdGhhdCBuZWVk
IHRoaXMgY29uZmlndXJhdGlvbiBwYXRoOyB0aGUgdGltaW5nIHZhbHVlcyBjb21lIGZyb20gRFQu
CgotIEhDSV9RVUlSS19WRU5ET1JfSU5UUl9TVU1NQVJZOiByZXNldF9hbmRfaW5pdCgpIGVuYWJs
aW5nIHRoZSB2ZW5kb3IKaW50ZXJydXB0IHN1bW1hcnkgcGF0aCwgYW5kIHByb2JlKCkgc2VsZWN0
aW5nIHRoZSB2ZW5kb3IgSVJRIGhhbmRsZXIKd2l0aCBJUlFGX1NIQVJFRCBkcm9wcGVkLiBUaGVz
ZSBoYXZlIHRvIG1vdmUgdG9nZXRoZXI6IGVuYWJsaW5nIHRoZQpzdW1tYXJ5IHBhdGggd2l0aG91
dCB0aGUgaGFuZGxlciBsZWF2ZXMgdmVuZG9yIGludGVycnVwdHMKdW5zZXJ2aWNlZC4KCi0gSENJ
X1FVSVJLX0lCSV9QQVlMT0FEX1RITEQ6IHJlcXVlc3RfaWJpKCkgZ3Jvd2luZyB0aGUgcGF5bG9h
ZCBJQkkKdGVybWluYXRpb24gdGhyZXNob2xkLgoKLSBIQ0lfUVVJUktfVkVORE9SX1JFU09VUkNF
UzogcHJvYmUoKSBhbGxvY2F0aW5nIHRoZSB2ZW5kb3JfZGF0YSBzdHJ1Y3QKYW5kIGFjcXVpcmlu
ZyB0aGUgcmVzZXQgbGluZXMvY2xvY2sgLS0gdGhpcyBtb3ZlcyBpbnRvIGFzcGVlZC5jCndob2xl
c2FsZSwgc28gY29yZS5jJ3MgcHJvYmUoKSBqdXN0IGNhbGxzIG9uZSBmdW5jdGlvbiBnYXRlZCBi
eSB0aGlzCmJpdCBpbnN0ZWFkIG9mIHRvdWNoaW5nIHRoZSBzdHJ1Y3QncyBmaWVsZHMuCgotIEhD
SV9RVUlSS19WRU5ET1JfREFBX0lOREVYOiB0aGUgRU5UREFBIGxvb3Agd3JpdGluZyB0aGUgREFU
IHNsb3QKaW5kZXggaW50byB0aGUgdmVuZG9yIERBQSBpbmRleCByZWdpc3Rlci4KCi0gSENJX1FV
SVJLX1ZFTkRPUl9UWF9BVkFJTDogdGhlIFBJTyBUWCBwYXRoIHVzaW5nIHRoZSB2ZW5kb3IgRklG
Twpwb2ludGVyIHJlZ2lzdGVycyBpbnN0ZWFkIG9mIHRoZSBnZW5lcmljIFNUQVRfVFhfVEhMRCBi
aXQuCgpCaWxseQ==

