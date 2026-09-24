Return-Path: <linux-aspeed+bounces-5044-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE16C982FD
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Sep 2026 05:40:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr2jY0MKSz30RN;
	Thu, 24 Sep 2026 15:40:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790228416;
	cv=pass; b=YvQVNSSJI4Ixb7NPdMxx8NlgX7UkPsmDVF9JpR3GIMSIchA/Jzo5K3Li/bZqtV8hEldksA3pOdKnyEyhnBEYzN4+WIscOz8U1DNn3UE5Dm9WbjqlHD1lVMeym9usdjrw0oK7/3ZGSlo+wbB0ji/CLxzk2yBRbalNctuULpqp939ErfUOlELbkfhg4TxLehodIBiHvKM2Fi+ZrMVxUPPyEQ9paYBZpk6N22LYrIZWoISLjHitvD164E0KMGeQXS9phTAPlcKDMz0XcuV9+9lxoISYnNhFKhV9PfafCb0u6WGqDKAc4XOVoBzV2d0FBU3luERTbXV4kA4ZJWEnPTlJtA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790228416; c=relaxed/relaxed;
	bh=AUpTgJrcXv83j0/tX9SIs+HxxrEvTLZCcNRsYAiIREw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bSTRaisXfayfFHHgdw1iNB34U98Rd7X4uQJHITeVzyUlHk5dXrSJwHT0f1N9UXwSzGDrKnpyuunZaTxsUh0HFoUkvUAC02jLZPW3Bh9yPmrT2xLoh378mhdt5IFuYCQQfE4rYu6ex9xYNqn8ZroOeYx07I8EOCSQCzKpLd5QKHDWOWoc5I9wnioE0jbugMSKkVkcRhcBLYOtMRdrC2YqkhPbKCeC4wnqNonTY4y72qSrxPw5llj0c9YCEluUEsnTd2eK5k1o0bxOZlVV5nn1JcER+G/n1ptwt3C9EWIbaMnpX5lKsMFN/R815ch+Pi47bw9gJpP8N0KpdG96JgLMmw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Cj7C+X6T; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Cj7C+X6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr2jV0hsDz2yD3
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Sep 2026 15:40:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW9N1Jw1aQ/9Xlu1guRJB29IO20KOl0i1Ql05Ncxwh+6PPwLCUxs8aMu0SaEuLWo3RSp/vFl+qsA56rBGuDkixJ0et1dxOD6UgqHHOskwrVU9bxiBhIpWvf1K7y2EqxpxMihflh3aWfp58w8uBXZTJbmkfwWfVlfx3MhhHcEaB7zOz7qcA2i/eNPkS7AKtC2JV1IDhFWrndjy4B461JZ46dDTWnvTEBrhGI1c1twIvzYBxJ6OFzbHBY9DHisljut96g6tWITQMwpZnnHJrP3Gb2CM1jMA3LbhFhqlpN9q7HUNyXo3KkHsTGxDnmnWjK1V/pnzxoaDbnHSuUlIY/mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUpTgJrcXv83j0/tX9SIs+HxxrEvTLZCcNRsYAiIREw=;
 b=u7QeFtjQ3OQbI6yzpcJ3fJ6C0+rdBlB/R9fimCsAmpbf7xCvO5Wh3EqPUO1CCuyk1k/uhy/YH+fOe3dOEtC534wD6N9lqjLTEie/e2tA5umezkYoCq93UfHVXqQncvndOiC22SDs4LCkf6SnmNAG94UqDzG+CTMphJHN4xc9Vl4BCnDJ7QwTZzrD+grLad3g67Sn4qSZ6RKc4glqgvdOfPXtbylhbs8fZCa1V9ySgaNY4s7Nvr21md0AmExh2MCiE9PTC9tVQhH81qakc9g2jDrmQDN93+Iy82J43xloqFRjGJYkvwbKxZQjtTQFZJqrgst3c+hx6hLIoc6XJZCg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUpTgJrcXv83j0/tX9SIs+HxxrEvTLZCcNRsYAiIREw=;
 b=Cj7C+X6TdolrGLwtk1aBY4+hWohQHc8ljlZwtEvMNHGlVKCl4Ic1j77simtGvRFz/k59IGeyXxfJGTsDJ6x/UaqjcLj7SK8gNfyJcKaJzUqogVHEPOvu+fgdHQNg/ytiO4a2aLK8trzlsGyfdtJn10noTGtd84xNbXLqI3bgCLwAssUwzvQgzv5uxBpaPUOTZiPdg+szYSpYupjt3K1T4PcEsTrwaOas9npZM05/IU+9TFYunB2DJrMuhWRqznl0q48MJenD+T9wX7gfLh1R0uNmlsVw99N79FSofn9A9OPfi7oph6n/vcju7ZbzaOeA03qCOuHNcJgoISPlAYBWRg==
Received: from SEZPR06MB7237.apcprd06.prod.outlook.com (2603:1096:101:238::10)
 by SEYPR06MB6432.apcprd06.prod.outlook.com (2603:1096:101:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:39:48 +0000
Received: from SEZPR06MB7237.apcprd06.prod.outlook.com
 ([fe80::f1cb:15dc:b764:fa22]) by SEZPR06MB7237.apcprd06.prod.outlook.com
 ([fe80::f1cb:15dc:b764:fa22%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 05:39:47 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Philipp Zabel <p.zabel@pengutronix.de>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIDEvOF0gZHQtYmluZGluZ3M6IGkzYzogRG9jdW1lbnQgdGhl?=
 =?big5?Q?_AST2700_I3C_controller?=
Thread-Topic: [PATCH 1/8] dt-bindings: i3c: Document the AST2700 I3C
 controller
Thread-Index: AQHdOgYGnk2AFkBmnEiGGqUqF4qN8bbCsC8AgBBTkwCAClXCyw==
Date: Thu, 24 Sep 2026 05:39:47 +0000
Message-ID:
 <SEZPR06MB7237179374D186C39384D9808B812@SEZPR06MB7237.apcprd06.prod.outlook.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
 <20260907-imaginary-economic-oyster-57cdd6@quoll>
 <20260917154754dd1eefbe@mail.local>
In-Reply-To: <20260917154754dd1eefbe@mail.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7237:EE_|SEYPR06MB6432:EE_
x-ms-office365-filtering-correlation-id: b1255929-eea2-46b0-78af-08df19fe3eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qCT/bNKY7v61lYPeTF+cD6m+ed7mHCDVDKOhZUXcB9XC7pog9FTqCJlA6XUADlciWqUtzPWjpsUVMcruylc1neY7kerTvmocmRroNBMJzPSBNWmmq8WOigbhyLuuM6Cv5tO0N/RbmDa9PLCxMvL0UlKeqa//Gw6ZWlDIr1EEq8I5TDF6u6jnCEKeR4SA3CuUt6ZYauo0n5dNINR2yV28Yq14gbPDwBPkiqorUtWq4raag8dnCE+sEdwG3NNO5ARKhuAno1q34pHXI27CGWcsmWMjDserkvAUhid8ilOfs1Z9PGXFQB54dpDtpOY0U93AeemyriOd8ZGzMuw7DgKT1OIMdnELWVxOcpj8samFw7xiOOCYl7kv3ECURcWIyOVO15L3MPnOC8BoVZnJexf60Ik9g7KSXcmjTMatbR/K2f8LgRW60b1jT92I6BHDlpYqnMCQlHPbVuIXCx/PdbtizY5bRylmphRXrjQ2zwCGwr31QHHeHkcfUWujKO6JKFNiXYD2pYVssyPfMW0zLdvUJYMuDh5IvJ15WjiYvZobsix/breZWdMGIiwyTbfyf0W1w9shPSRbMQXJdNHPVUi3ymDKx+V/0aWaG5MBSsxk7glwcGWoZ0EPxMxJp/okHR1mjoO+f234q69ECj0YuIK5OEjOhHfUBjPf1BU2CLTfAV2142NZXzB8qOZeoh7EA3CBY/+mlkgfjLkPO1LM7uDqoy+TH1BcG7gFY6MJrKJJ+q4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7237.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?eC9CSzF5ZEQ4aThQUXJQbXIrUXVRcm5SYkFKNFhvYkt3WFowR1Vzb2c3eUR4S0Fo?=
 =?big5?B?UUlSdWlBZWgwYVIvZFQrKzBLRWZ4Smh3M2I2Uzh1cjFuSHUyMVBpcGVJZ3dVMVh6?=
 =?big5?B?Nm91NkdFT25NWGdGVXdNQW9sZlBDZU5FSDlBaWNlOEZVaWp0K2U3b05VcmFpZjR2?=
 =?big5?B?NEJoRzgxWEZwSmpMVi81NjU5aFpLTnQ2RmdUL2wzdm9EbitWR2kyOHkrMWdoMytt?=
 =?big5?B?c2Z6MzYyeGxZRUI3NlMzTGdaZjBndmYwMTB5dkNGTkgveklhTGg3cXRkckdhdEpl?=
 =?big5?B?MHg5ZnRNZjJnK3d2b2dFZm1IaElQNG5rblZQVE5ISlNNbXNyRlBKdjQxV1BaTFh2?=
 =?big5?B?K1ZUaFhXbVRINjBNcEpsb0FTa0tydHhLSEZ4cmxOUktUdVphWGVHWWJXWWV4akNv?=
 =?big5?B?bXNyRTFuTUZJeE14bWE0ekFWaU12LytodzlBVjM2NkFwempXRmo4S3B5aUhpY3pa?=
 =?big5?B?ZlViajF0Uk9UNldtWW1XUEd5OC9vUjRXTzR1T3lZZmZkWFNwN0k4aFNhUzlIWGVH?=
 =?big5?B?UkFlZjZHRkRldi9wZE53SSs4UE5BaUt4QkFmUGhjcm1pRWUvamd2LzNwUHd3SjFi?=
 =?big5?B?aHQ0aVR1ay96UjQyck5sTGprRDNjc2tPN01IZXlESTI3bUZwUHQxVVY1TFZGd21T?=
 =?big5?B?NkJ6LzBwbzVSWVpoR2IremcxZTBYeUpWVGRQSktPLy9kSTRaRnRTWm5EQWxRZEVK?=
 =?big5?B?am95WVBJbitjSUpTbzJYVGU4TXE2Nldsa083QlRUNEJjUW9jUkliMFpKS2I2c2RM?=
 =?big5?B?ZHFISDJhczFPRks5SEtNOTAzWVM0cTNieldCajZMMGpxb0IrTGdLLzlna0JrTWRh?=
 =?big5?B?ZzZuSkt3L3NnMkUzVlYxWUt1MVozYmZIb04vQTdNdUJkTW1nSkVlZ2UzcnkrYjJ0?=
 =?big5?B?UHVxTjNCeHpoYnlhd1YvcmF4dmRtZ2U2cFRKeGtmSFFWbzEwZWR6NnlpY0FhS0lC?=
 =?big5?B?cnRRODF3a3JHaEdBTjNEa0V6cHh6dkt2TElMZmVuVjBkY1lwTE15aWdvU0FJWnFI?=
 =?big5?B?ZHBNNGtMckVBM1J2eFpESWdCYThpNjVtRVlNU01hL0lRaWU0N1RGL2lLMFIyUlRS?=
 =?big5?B?Z3NBcEd3U2NIQmowSjRZK1JGYlFxVWdDUUVOd2t5cUF3OU1CMFBuSk5wK1VSeUZk?=
 =?big5?B?RzUrOE8zQ09YbEdLSlhEd21CRWkyMWN1WG1VbUNOZXJSK2wwUW1SZXgrVzA5bjRp?=
 =?big5?B?TzYzNzhkRFVHWmNobE1RMUhGT01pWDNiRzU5ZjhYOTRTeWxrTkRRK1pHbENrZm5T?=
 =?big5?B?ekxoYkFXQkJjYWk0SFRiZ211NEZwT3U4QkZ0ajJ5ZEFnN0M4aTJObnJlOFhtRFht?=
 =?big5?B?bms4UUUzbzErYjl0UEdReWFPMlNUTlR0alZzM2cyVDFLUmhzV3cxOHJmbC9KcU1m?=
 =?big5?B?ZkkrQmJhZnd3d0RWaGNUWUhDKzVnZjBxSnl1a05XMWYyNjVaK1NBTXU2NXc3Qkcy?=
 =?big5?B?UHV2dzMzNjBiWUFuSngxWFVTcjd2Znh6aXdpTlR0U0xXQnArTGczcXkrWlFqY2hT?=
 =?big5?B?Vk9pL2NSejFQdGdNMDEvS24rRlhzSXFkd0xRNzFoc3hvNExLTXRYZkhFcWZnNHBj?=
 =?big5?B?b212c20zN1VUQjFFdHYzY2JvYnJVOVhFOCtiS2FFSWVzR0FYTmRSOFNwMHJUN1E2?=
 =?big5?B?emtydG1JcE5oc05oM3ZLSWNENlBiZkI0YnBWMkNuZ1JOR01pSTB4TnptSC92N21L?=
 =?big5?B?NzFWUExDYU45YnRFQVR0bmN5UU9ROUsvUWI5Q3JBN2RDUUsvYmJvRWRCT3VmM2gz?=
 =?big5?B?M1hpblpOVVI1bk1SUnVBeDErbVN5cXdHTU0yZnpxTk15VWlXTFovUWNJSks0ZlFP?=
 =?big5?B?QVVVeFBQemNiVGdOaGh4TloxWGZhUGZDb0ZWNG5qZ2NoZHo4VVNSdnIyWnc2Y3U5?=
 =?big5?B?eGdaeTB4eTFuRTQ1eml1cDlrMHNsMjRGMUdSNi9vZ2J5VjBFRTNzbVhhZFZVanZl?=
 =?big5?B?RHdkTzVJZlhCZVFTZGZqcEFJK2RzSHk2TEJPRnNtQm5ZbXplV0JyNnBnYlhwa21h?=
 =?big5?B?VG84UjVwYzRrRzlSZzg4NG0xQ1JjUkZXRG9tMjZZZDV4NWxHRzI0eGZtL0NBWVoy?=
 =?big5?B?aUZpSXluWExxMUp4anNvV1V6U3MxN01lWUdoeDVvTlYyVlRHMGZ0TU5nRUVldDhN?=
 =?big5?B?N0R4VXQ5SUNnK3ZRTlQ4bzJWSzRiNHhiV0V4NTR2a3g0TFJLUjRWUXZEbHBQMS8z?=
 =?big5?B?QWk1bXJjb2VwM2FBRXcwM0hUSGNTdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7237.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1255929-eea2-46b0-78af-08df19fe3eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 05:39:47.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ytHyXVfHq4kD1u6f2y0yXpNb8yZGpy9YWPbqT32EnF6vmjMq9EFXnERTfPslSHeM/MTmQwUKNa4VqXDPu8cAu5zUsgMD+hGYO8QAQG1lJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6432

PiBJIGd1ZXNzIHdlIG5lZWQgdG8gbWFrZSB0aGVtIGdlbmVyaWMuIFByb2JhYmx5IG5vYm9keSBu
ZWVkZWQgdGhlbSB5ZXQKPiBhbmQgbm90IGFsbCB0aGUgY29udHJvbGxlcnMgd2lsbCBoYXZlIHN1
cHBvcnQgYW55d2F5Lgo+IEhvd2V2ZXIsIEkgd291bGQgbGlrZSB0byBtYWtlIHN1cmUgd2UgZ2V0
IGVub3VnaCBjb21tb25hbGl0eSBiZXR3ZWVuCj4gY29udHJvbGxlcnMgdGhhdCBzdXBwb3J0IHNl
dHRpbmcgdGhlIHRpbWluZ3MgaW5kaXZpZHVhbGx5LCBjYW4geW91Cj4gY2hlY2s/CgpJIHdlbnQg
dGhyb3VnaCBkdy1pM2MtbWFzdGVyLCBpM2MtbWFzdGVyLWNkbnMsIGFuZCB0aGUgQU1EL1hpbGlu
eCBBWEkKSTNDIGRyaXZlci4gRXZlcnkgcHJvcGVydHkgaW4gdGhpcyBzZXQgaGFzIGEgZGlyZWN0
IGNvdW50ZXJwYXJ0IGluIGF0CmxlYXN0IG9uZSBvZiB0aGVtOgoKLSBPcGVuLWRyYWluIGFuZCBw
dXNoLXB1bGwgU0NMIGhpZ2gvbG93OiBkdy1pM2MtbWFzdGVyIGhhcwogIFNDTF9JM0NfT0RfVElN
SU5HL1NDTF9JM0NfUFBfVElNSU5HIChoaWdoL2xvdyBjb3VudCBlYWNoKTsgdGhlCiAgQU1EL1hp
bGlueCBkcml2ZXIgaGFzIHNlcGFyYXRlIFNDTCBoaWdoL2xvdyBhbmQgT0QgU0NMIGhpZ2gvbG93
CiAgcmVnaXN0ZXJzLgotIFNEQS9kYXRhIGhvbGQgdGltZTogdGhlIEFNRC9YaWxpbnggZHJpdmVy
IGhhcyBpdHMgb3duIGhvbGQtdGltZQogIHJlZ2lzdGVyIGNvbXB1dGVkIGFzIGEgcGVyY2VudGFn
ZSBvZiB0aGUgbG93IHBlcmlvZDsgY2RucyBoYXMgYQogIGRhdGEgaG9sZCBkZWxheSBleHBsaWNp
dGx5IHRoZXJlIHRvIG1lZXQgdGhlIE1JUEkgSTNDIHRIRF9QUAogIG1pbmltdW0gInJlZ2FyZGxl
c3Mgb2YgUENCIGJhbGFuY2luZyIsIHRoZWlyIHdvcmRzIGZvciB0aGUgc2FtZQogIGJvYXJkLXZh
cmlhbmNlIGNvbmNlcm4gd2UgaGF2ZS4KLSB0Q0FTOiBkdy1pM2MtbWFzdGVyJ3Mgb3duIGNvbW1l
bnQgc2F5cyBpdHMgTVNUX0ZSRUUgcmVnaXN0ZXIKICByZXByZXNlbnRzIHRDQVMgaW4gcHVyZSBJ
M0MgbW9kZTsgdGhlIEFNRC9YaWxpbnggZHJpdmVyIGNvbXB1dGVzIGFuCiAgZXhwbGljaXQgdENB
UyBtaW5pbXVtIGZyb20gdGhlIHNwZWMgdmFsdWUuCgpOb25lIG9mIHRoZSB0aHJlZSBleHBvc2Ug
YW55IG9mIHRoaXMgdGhyb3VnaCBhIERUIHByb3BlcnR5IHRvZGF5LgpUaGV5IGVpdGhlciBkZXJp
dmUgaXQgcHVyZWx5IGZyb20gdGhlIGJ1cyByYXRlLCBvciBoYXJkY29kZSBvbmUgZml4ZWQKdmFs
dWUgcGVyIGNvbXBhdGlibGUgKGNkbnMncyBkYXRhIGhvbGQgZGVsYXkgaXMgYSBmbGF0IDEwbnMg
YmFrZWQKaW50byBpdHMgcGVyLVNvQyBtYXRjaCBkYXRhLCB0aGUgc2FtZSBkZWZhdWx0IHdlIHBp
Y2tlZAppbmRlcGVuZGVudGx5KS4gU28gdGhlcmUncyBubyBleGlzdGluZyBuYW1pbmcgY29udmVu
dGlvbiB0byBiZQpjb25zaXN0ZW50IHdpdGgsIGJ1dCB0aGUgdW5kZXJseWluZyBxdWFudGl0aWVz
IGFyZSBjbGVhcmx5IGNvbW1vbgphY3Jvc3MgaW1wbGVtZW50YXRpb25zLCBub3Qgc29tZXRoaW5n
IHNwZWNpZmljIHRvIG91ciBjb250cm9sbGVyLgoKVGhhbmtzCkJpbGx5

