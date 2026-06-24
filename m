Return-Path: <linux-aspeed+bounces-4291-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C775DCDB479
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 04:00:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glSrH6PWXz2yVv;
	Wed, 24 Jun 2026 13:59:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782273599;
	cv=pass; b=R6XYL5nERUseZh4VwSujYNBHruCkaHlGclGYau7DcqmGPDwUn0y3BAskezOvQOdjQ2LQWrk/sF7DM+80smmFuXfXkrycQHUN6eN8OFhtscuFxc7I59Si2CMgkMdfErX4VYf5OOeiDPLV1Bqopqle4JGlfx9O3muNhThi70fWs/aOx8aYeLfh9/W4jKJ6nu5scL34UmwcCiD2owj2URKwbEWG4bal09ejQVPogMVCCLwlTuFWv5L0by2juD/NwBheFdI0l1jM1g7M9iEIuJryxrFD1kebktFn8rfuKgLi1U8OekEFLCBfiaiDgX+4ON3XBjDVdLIj4o4CMsNlWPg8kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782273599; c=relaxed/relaxed;
	bh=T048eSnLn67wyQ35ZtRrGoHs+XTcAolcC/uHBQEGBcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glRKPTdqLCW7i7Eo0WdIJyQ0qP7r/VLg1+xUMsMbTa8/959amiejxULSafkmd5CnmW5DmYR/X/AJM85T0WImWZcZl/iTAigUg/2XajIqY4R4VY/NLMdQHzaVlhL2LBy6NGBs0Jsllc0knGglcjJ3bXdWD5GdHYJ3SE+9TrgV2aetpQ4FQNDkz2uC5QJntAOam3YOY6PJryWME+aTvr85e5ZK57hiz9SpHkHdOsLKWLK1jMOzuQ4gjI2+quj+gfi7h58sKeJNeWLAgOlR8nIpKDQaplvNDyA5DBrgYEFolZJjWw0ob9b5BQbOLBnz6hjR5Hn+8mN7xlmzC06PkfuOVA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ZEI0C9Mh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ZEI0C9Mh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glSrD3vS7z2xSN;
	Wed, 24 Jun 2026 13:59:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YupCb1E2NKixLPYl0mml0BN+tVzLXN0m4Fi0zrp/9cq1mNy+Syb2Klnv1tuYyaie9WHA94kEz0ucMtkLnXpW+IfGBWp0fmyiAYO560IKamCnqUIDZEoXPyW9CLELuNoN/HP0UeJRP10auTCCWin8mlpfxK36OR+fIkfTdT6Y29sTV9wOQUwZUDZzSFXR6emy8RBG7xeSWxbSNW3gv9ya7BmOaJS3x0HHf0d4ROl/JAE+YViXwDJ4o5T3GLY/lATbOzIZp+zvbpsR+9963bXKC9h0DtvaY4w+RjDO2r3bYO/Qy67AD6Qm/1Sxi0Ui4+eXxJDZAiezPqknSMmsvH7V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T048eSnLn67wyQ35ZtRrGoHs+XTcAolcC/uHBQEGBcg=;
 b=YbfFYQpj38hYHhagz3fx06gk2DXPxdofP4HcwViCM1Rw38P9pq9TvttSC7nwbQnFSHGgHvAxYLyNclZRyKyUJ0vJmwmuhLe8UuVSX43gIo+3PMhvXuXR8KcspOnzqc4qn+OW0Av7XfgddI9/idPmCshu+XAyglmgAvCebFee+SnEHBf93cjX7ccpOmKjWVbhXI+aSm1+7yGXKVqZOs6UTaB8HKyqLjeMIADw1GAFCFkzxflELYeBlfHa3a8HHhqy+N6pWXbEbDXt6NshA7tTQdwUqRadtCGRsvF25yUHBRAfRBsumRZZI6uuGgzyUyhkTTqP93dLhXmB6ZON6ZQrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T048eSnLn67wyQ35ZtRrGoHs+XTcAolcC/uHBQEGBcg=;
 b=ZEI0C9Mh/rkgR9lvYDlyTvvtKKYvpuxKBuBzLhu9qfvaSaDLQ1pGNXNndP4tAsni+jW/xxaOb8u5GeoulLF1L6rUI2tcmKWD+jJ/CWCvl1YEbWscmtRX/Xyhuw9UQ+VRIXS2mvjxpqvGBVPVsPT2Pugzp/w/emzBaqIyJHZTH5o5nQpp+AZZDEmEL0uMezrsXznGmdZz6kgW+UoIQeuNdeWIGAE+HX7igdchcWDodNImE0qyIVlEAzjD4d0wIhPDsKPm/xxd9kGaJ5SuKBbWQIbOYqgjycKSA0NqKELKN+WPP2VkX0yv+B4JGgZavQvEOBC5KBNJlUEgCHKXp7tLFw==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by TYSPR06MB6676.apcprd06.prod.outlook.com
 (2603:1096:400:472::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 03:59:28 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 03:59:28 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@linux.intel.com>, Arnd
 Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, Conor
 Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>, Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Topic: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Index:
 AQHcstFOqEOl3ItXl0mr3midS8GMZLWsphAAgABXFACAA7sEAIAAT9LAgAF5RgCADH1X4IAAILCAgAK7OMCAEYY3UIAvrvqAgADtghCABnSAgIACyQAAgB+RCFCAHgEHUA==
Date: Wed, 24 Jun 2026 03:59:27 +0000
Message-ID:
 <KL1PR0601MB4276FA2C6347192CC45826E490ED2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
 <c3b28ee92fa46700887d0c68b23045b2418358a7.camel@codeconstruct.com.au>
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
 <KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <14870d17-2471-4522-b8b5-03cb9002a4f7@app.fastmail.com>
 <KL1PR0601MB42763DAD359305DEBA4B769D9057A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <KL1PR0601MB427603A6A5768D6A537CAFCB905AA@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <b1d56feb-9847-41b1-8bba-733963055cae@linux.intel.com>
 <KL1PR0601MB4276AB799EC03BB00C4C0E5490392@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <be4f662a-b986-4b4c-8263-2fd7b63c238a@linux.intel.com>
 <KL1PR0601MB427604A7136947D020CF272D90002@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <KL1PR0601MB4276452D09689C90B04209C190EF2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
In-Reply-To:
 <KL1PR0601MB4276452D09689C90B04209C190EF2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|TYSPR06MB6676:EE_
x-ms-office365-filtering-correlation-id: 5e9d1741-c25e-4fd7-b23c-08ded1a4fca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|1800799024|366016|7416014|23010399003|376014|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 9uCavdb9ddv/sYE6Xo2JlkbgdAi47GXNztNpAumr0c5neF032Q6KaaOv7ijyulfi4+sB916lXZicEl9tEvgDPfBRdGR91VoVrw+O1c794ZCHyBfj8WDK4Ynmv+WTHJ+7/9vAfuS+9pqkrOlRHdE77krwC6gI28YHjQWLgJ3txDbctoZclx84UEkCzdfiwY1PKPkZ5x4rZX+ofppaltM7WvWAoSnvP5AWWIwq0fYwgZZqgIho9AgE0jH7i+9694S7oQlEN8FAXBtmUUj5LP7VV2H5YJwBVoeoxOdjQnBqgiRghyMvHy2TjD/w2wgkuBBu0p7YPSFq6KYOTASgxoorR/DRsmRCLFMEs62vx5s7InfOwUSRdX7q3IOnhT/ta6dG0U4kzplfIl5gWIWBvkATxPhwPS0sXmSlzdZEY+AiAKxFx0i8cduqha+HU+V0gL1u4veJ03L40KpjA/JA9Enc8jBzNuiNHkoRngANr+8MBUOZcHLmTDSTZJtOFD6uwJDDNoSNlsCDmEKbz0VMw1izUgBPuHkuEx/5aibqw5HCAD2me9FkCmBsuTkqShAVQ6hZntYGqrBM12YcJHyP4XtNnYbN0tW7nYlVL+2TaLYgfXvaaNktjMF1uJRx3Aj/oq4DckZpFHc6Ifm2qLJejD+a8jrUe1DuvRqJ5QIOZlsV375txyLHJR2QeqBrr0/mQaTCz2azIZkXtpXQzByhzN0rAQui7vS+Oq+KSO6o6Fq7yiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(23010399003)(376014)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFdWTVJINWpFOTN2UjVTOXRrZUZjY2ovd3pFeXZ0b1R1V2YvczI4MzhHMEc2?=
 =?utf-8?B?elZsTG9heXhmRkFER2hWQXM4QktkQ3R4a053dmhyZ0FDbjZ4QnNkUEtmc28w?=
 =?utf-8?B?TjRTaHhPM1M4MUhMck5Rb2VvSUF0WlgrWS85Y2RXcmM2OUJxeGErUTFYTExv?=
 =?utf-8?B?czVvSk5SdTI5ZVdhS3pQSWN2b09ONVRvSHMwZ3VYcmVaWTV3ZDJOc1l4THZ3?=
 =?utf-8?B?Q3A5R1lQRHMrdFpZbzY4RmZmdWl4VllibzZmcXVFbVIxSzF2SGR1YjZzQWJG?=
 =?utf-8?B?a0Vuc3NVU3RUd3p5T3dVeHA1ZGpSelpDekxuOG8ydzRZdkovVllXQ3FGY2l2?=
 =?utf-8?B?a21PUENFWDNaa1A2YWhtMGFleFUzbTk5am1FTjdHUDkwUWtSMWJmSldoT2lp?=
 =?utf-8?B?R1NtT0g2UjJ1OU5oLzNkcDBWY2VacFVRQXRDQThVUGNRVkdGSmpWV01zNWlV?=
 =?utf-8?B?ZmFqc3ZHNi9DVzg4UGZjc2UzMWhuQzc4WnBpNlZhemhIUTRKWGZjempFL1Bn?=
 =?utf-8?B?UWhCZGdsMk9sN0FCRkFiSVUzT3J5TUVnLyszdFZMczJROS9vRFJKYXpVVllY?=
 =?utf-8?B?elI4Ykt3eUFSUXJyOTF0dnVWZThWRmlGWURhZDF2NG1DNStnL3NEclB2MW40?=
 =?utf-8?B?N2VyTjBGS0pZUGFHbGNkMFlFa2VKenBPdFlRRnZBYWx3VUZWemNiMU5jWlUy?=
 =?utf-8?B?OEt3TE9Uckcxc29XaHVMSlVMT1BqRDlkZmZuSk1ML0k0S0lVRDBXN0kyVENS?=
 =?utf-8?B?VmNIRFE5bkdUK0piLzlOVmt5SEVwbHdHTzJyYTRjZkVpZTB3Vng2ODdCSXFk?=
 =?utf-8?B?WWpUUmpQREhsTmt0RytneERReWtON2MwZmJMWjJ5R3R5dUNQeGNiYXJxWWRs?=
 =?utf-8?B?NCtLMmF3TEFaanhGWUQzQ2FLWUNqTjBHTzNaWUcyeTd4Y3NKQmxGcGxURFI2?=
 =?utf-8?B?UU5IV3pzazNKeTlidkREMUxBaUs5NVF4ck5YSzBueGthZ1dBTTV4YWVpQUJk?=
 =?utf-8?B?UzgxZE1lalhOZ0ZDYXNEd253MzB0OWpCSEROb1VUcUNsRVlNSDQ5WDJLS09Q?=
 =?utf-8?B?MGU3NExqN2RCSmQzMmc2UEhGSUk1d25Oa3R1M3FKbEhXRlJYb2c0T2hsUzFB?=
 =?utf-8?B?UzE4TWdtWlJ3TkY3ZFRNY3lzRUNTb21EYVlSZGlzOVE5eUxYZFRSaVhVL0J1?=
 =?utf-8?B?bC9lTEg3UkZYOEU5ZW9maVczc2dKV1ZPdmxTZnJ6M0xOUDNKRXNyWExVOG8x?=
 =?utf-8?B?Z3dZd0VCTlJwZkJuSEVpSHR4bTh1cDk5Qmo2RW9zTTRzV29Qc2ZzOE9maWs4?=
 =?utf-8?B?Mkh4TXNaOVNYS0hsVnhGV01wME5NQUc0NTdqdytrM1ZTZ2tvd0g5NVZERTZG?=
 =?utf-8?B?ZjJZVU5IZ21Fem84aCt6VUpwL3dZS0ZtTFJ6YzlMNkhXU3QyMVRnZi8wWjhw?=
 =?utf-8?B?NVRRUE9zaXpjL0hJU1B0eWVoclJlK2Eva1ZwYXJTUDd4dmVtUWJ2cE85RzRu?=
 =?utf-8?B?VUdjYVhtbzdjc1JPazE1cjVxYjVXNzZsWmFvOUt4UUtwS3JVWVlLaUt2Q3NN?=
 =?utf-8?B?VkpoaDBqS0NuOEk1ZXFXdGhvdzdwZFlkQUVkSGNQRDkrMzhtWEFhSGd2RXFP?=
 =?utf-8?B?M3JiWEhOT0dtZzl5aHgvbS93SmRmcmVhLzMzcjFwbWRCSE01Nm9VRmlWNmNu?=
 =?utf-8?B?a250R0ZZQUJzc0ZJN0xDZ3BESHFtSDF2ZU1BNHJZOEpPVkdVeUZIL29FeGF5?=
 =?utf-8?B?eUw2aEhNbTlGdzBNd3RBc283cEZYU3VVckRtQnJLNy83ZlFZbHBqNjg3bXZ4?=
 =?utf-8?B?UUU4T1luaEplb3d2Sm5KS2VsOUFaZmk5d0k5cDRrTEZwb3B2RmRsaEp2bmFl?=
 =?utf-8?B?UWtWR1hpZ1p1UGUzU2dXN3kwaG11YW1YV3EyM2NCYTBCYURDekhoZlRNT25J?=
 =?utf-8?B?MkFyVEs1a2pUM2pVVXBxWHJ2NmRVY3ZsZ3pjc3lEeVNPZFcxNWtxUm5saGl6?=
 =?utf-8?B?RDB1cXdLcnNRZGZpMEpmeXN6NkVUMzdBcDZnNllTVk9FYzVyQkZXdjdsd2hy?=
 =?utf-8?B?R1lNRHlmdTlRRUpqbzBGdHcyYzJrM0JkemxIKzBuRWlZb0tiSmZZTFBjNFhj?=
 =?utf-8?B?SWdyczNtdmZoNXcycmM0YmtsYjh1aG5VWko1Rmx4eEJUN05BUU5Kcm5OSEJH?=
 =?utf-8?B?a1EyQ1JvRGZTWVRXa0dXZXN6aDhQRXVrdk1sZGord2dxcnJKTnpadjhYdzdD?=
 =?utf-8?B?bjN5LzdIcXBIMGpiaythVnh4V0lKS3dMTDM1ejBKZGR4TmROZUJlZ2hwOTRF?=
 =?utf-8?B?VzNQOUVnZmZPTXpLVER6K3huek5GVGNaUFZVRjFLZ1E1MCtGT2VFQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9d1741-c25e-4fd7-b23c-08ded1a4fca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 03:59:27.6059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6c5c1l5Xboz5kliQzD5K9lQ+QCYdcQwQ92yQFaVMyyybE9GkhAXkpkCmY7watooFuOPErO5yu7SFiXyD7mMhlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6676

SGkgTWFyaywNCg0KPiAoMSkgUmV1c2UgdGhlIGV4aXN0aW5nIFNQSSBzdWJzeXN0ZW0gYW5kIHRy
ZWF0IGVTUEkgcGFja2V0cyBhcyBwdXJlIHNpZ25hbHMuDQo+ICgyKSBNYWludGFpbiB0aGUgZHJp
dmVyIHVuZGVyIHRoZSBTb0Mgc3Vic3lzdGVtLCBzaW5jZSB0aGVyZSBpcyBjdXJyZW50bHkgbm8N
Cj4gZVNQSSBzdWJzeXN0ZW0uDQo+ICgzKSBDcmVhdGUgYSBuZXcgZVNQSSBzdWJzeXN0ZW0gYW5k
IHJld3JpdGUgdGhlIGVTUEkgZHJpdmVyIGFjY29yZGluZ2x5Lg0KPg0KPiBGb3Igb3B0aW9uIDEs
IHdlIGRvIG5vdCB0aGluayB0aGlzIHdvdWxkIGJlIGEgZ29vZCBmaXQsIGJlY2F1c2UgZVNQSSBo
YXMgY2xlYXJseQ0KPiBkZWZpbmVkIHNlbWFudGljcyBmb3IgZWFjaCBjaGFubmVsLCBhbmQgb3Vy
IGhhcmR3YXJlIGV4cG9zZXMgZGlmZmVyZW50IHNldHMgb2YNCj4gcmVnaXN0ZXJzIGZvciBlYWNo
IG9mIHRoZW0uDQoNClJlZ2FyZGluZyBvcHRpb24gMSwgY291bGQgeW91IGtpbmRseSBzaGFyZSB5
b3VyIGZlZWRiYWNrIG9uIHdoZXRoZXIgdGhpcw0KcGF0Y2ggc2V0IHNob3VsZCBiZSBtb2RpZmll
ZCB0byBmaXQgdW5kZXIgdGhlIFNQSSBzdWJzeXN0ZW0sIG9yIHdoZXRoZXIgYSBuZXcNCmVTUEkg
c3Vic3lzdGVtIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGU/DQoNCkZvciBvcHRpb24gMiwgQXJu
ZCBoYXMgaW5kaWNhdGVkIHRoYXQgaGUgZG9lcyBub3Qgd2FudCB0byB0YWtlIHRoaXMgdGhyb3Vn
aA0KdGhlIFNvQyBzdWJzeXN0ZW0uIFRoZXJlZm9yZSwgaWYgdGhlIFNQSSBzdWJzeXN0ZW0gaXMg
YWxzbyBub3QgYSBnb29kIGZpdCwgd2UNCnRoaW5rIGEgbmV3IGVTUEkgc3Vic3lzdGVtIG1heSBi
ZSBuZWVkZWQgdG8gcHJvdmlkZSBhIGNvbW1vbiBob21lIGZvciBjaGFubmVsDQpoYW5kbGluZywg
ZXZlbiB0aG91Z2ggdGhlIGluZGl2aWR1YWwgY2hhbm5lbHMgYXJlIHJlbGF0aXZlbHkgaW5kZXBl
bmRlbnQuDQoNCkZvciBleGFtcGxlLCB0aGUgVlcgYW5kIE9PQiBjaGFubmVsIGhhbmRsaW5nIGNv
dWxkIHBvdGVudGlhbGx5IGJlIGludGVncmF0ZWQNCndpdGggZXhpc3Rpbmcgc3Vic3lzdGVtcyBz
dWNoIGFzIEdQSU8gb3IgbmV0L21jdHAuIEhvd2V2ZXIsIHRoZSBGbGFzaCBjaGFubmVsDQp3b3Vs
ZCBzdGlsbCBuZWVkIGFuIGVTUEktc3BlY2lmaWMgaW50ZXJmYWNlIHRvIGNvbmZpZ3VyZSB0aGUg
YmFja2luZyBzdG9yZS4NClBsYWNpbmcgdGhhdCBjb2RlIHVuZGVyIE1URCBmZWVscyBhd2t3YXJk
LCBzaW5jZSB0aGUgZHJpdmVyIGlzIG5vdCByZWFsbHkgYW4NCk1URCBkZXZpY2Ugb3IgYSBmbGFz
aCBjb250cm9sbGVyLg0KDQpJZiB0aGlzIGRpcmVjdGlvbiBzb3VuZHMgcmVhc29uYWJsZSwgd2Ug
d291bGQgbGlrZSB0byBleHBsb3JlIGludHJvZHVjaW5nIGENCm5ldyBkcml2ZXJzL2VzcGkgc3Vi
c3lzdGVtIGFuZCBtb3ZpbmcgdGhlIGVTUEkgZHJpdmVyIHRoZXJlLiBQbGVhc2UgbGV0IHVzDQpr
bm93IGlmIHlvdSB0aGluayB3ZSBzaG91bGQgdGFrZSBhIGRpZmZlcmVudCBhcHByb2FjaC4NCg0K
VGhhbmtzLA0KWXVuIEhzdWFuLg0K

