Return-Path: <linux-aspeed+bounces-4321-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CCAC43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 30 Jun 2026 05:26:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqBSx0rYBz2yY1;
	Tue, 30 Jun 2026 15:26:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782786324;
	cv=pass; b=ACEpK6nb6gjJHpT7C2ibwNYqWU5KJXgHHNuO7SGkyw98apWIY2pvnG8mXkIb8UTq3hQHNcsdscRkF1Im2lFpYvE9LlugZAvSA16sEKBJwhEtZUYKaI3pVs2giOQaS52gRMqdMy0pJpQRR7T0XsXEGv7OlwKdRfxuUhMr1WEg7YqH47Wjj3ZmN7nXx93EAq101Q6m9zHwtHk5fKKBxQK/dz0S557Sbn3/JGJPmX7qI0WuS7J31RtTOfydwCw8wa016SA56H5znDFBbfaQjs27WoEIMgsk277U0vOu+NfLpWZZ+NgnadRKKYmFOMXfV1j3JgjDmMCWopf4j6Fd/SP0kw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782786324; c=relaxed/relaxed;
	bh=2QYzkP2qXJrUmP90GEGQLyg8eV9c603HGMLGcBuXfkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjArxK2jevEum79X9DNLpYf58P9P6HkHlqEG/w+Uat4WdxfKtlAIAKHvWCF69TFmHP7y6sN/CL+ZBBk7b6p+4KmC2YAotx+CGXH6Bz1ki7cqQ0MMA0hmpZv9+hwP6/94tBc8US+G+/uSfVhUVs4PCSYqiHZsxrUt1Bd3+o6ty9ZYuvOC4NbTg+aFdryw0KHHitW6BIcSM+jTvzlFRw0Tv2GtzjgRYmioFbmABg0NQe98uOBaYlB3ROsUPiwlsb51zkiUZgjeySDiFtry3fFsN4YCgoMDha8VIUsk67muuwnxEcLkJ0vn6MG06Z/GseUknywVa5bzb2nypU0CHbSafw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DJJDUrhe; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DJJDUrhe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq6SK6sskz2xHK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Jun 2026 12:25:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8FoNV66skMmNX7V7OxdRLP0oDd3D1mc31IzlwZD34iBKjbLwcEsJ+vP+khYDjgtTyADqg9tb4fLSnofJP9id8NTEpZJWRo4WJpBqNC+9OF8gk/pAcZjJqxs6r3RB1OAYlR5kMr8qoilivm4dAwBWmb6+N8VBsPQPZBleBZw8lzcjofK/PiyWqVkuV93cVA7S19NnLE/w3YeIQnbmRaVAlF++b5kvHL48z+VWQGXl2S/CC8wjFwgPxJS3eHJe1ZZ3DYZ2pl/c4jXRp1JMCqzkqOZT5LOcmHlGGdS+ZCiWxkM5s3kDa8CRA1zkQbV9kW5bNuHhtSN40dPOr13+h1/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QYzkP2qXJrUmP90GEGQLyg8eV9c603HGMLGcBuXfkc=;
 b=HB8lenNhPODTycZxfKR2Zx8e7ir1y9gbGLsDzsFP9Wc0fIhKMA6Js5QZOBHGT3g1uGrc99GnPBYRsRCgH01LNSPcTMFE1/GCj8REuTAdLuPe57Oj57dVV2dU2iRqMBsgwoPg/wYYMokP+AVtnIlfu+NP3em1pM7xiovV/Rk4/WSeYja/9uQogTfW1wM8mEwS+RaBcroMMTtQ7UfCFJIdn7mH5zY8KsU785kHLGE40Msw0htkXxgYFodRlRi4AR3jsh+MawsJgAAjYTwVg/a3cYIEm1ypCpCSIo0cFDq9pWU7fH34z90Ys9SFb+6Iyo4fU4skr909S+RkKXwZfWH8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QYzkP2qXJrUmP90GEGQLyg8eV9c603HGMLGcBuXfkc=;
 b=DJJDUrhe591NM7C4qMYYxy3CE60KgnTHvdvQobhUaprYPkTF/82JddrNR/rSoS5nXUqJDxxL+4jCIYdsULkhLSJIjPsUq5f1O7M+4s0ZX6TG5mD/zJwRN6ajZMFtQR70ROluHnYKX3KNvIuEA+bQPFGCX1AkgMLzTUNUwB7M8SqZ2PUwUwhzh/jTpRt0zfhURJrMuzV0R6VliSJv66MrEWvKVXr2ckIevbv50haKH50rHTppP7Zismy25arHcFFrP/S3H9DdKH/Dsj8VnGfefeHl16wwgkIs/iVIL1uKYsOmNzc0nYN6rhSryJ+i4ozE0EplpjXr6DL7e3BSNC3HzA==
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com (2603:1096:405:13::10)
 by TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:24:52 +0000
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05]) by TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05%6]) with mapi id 15.21.0159.016; Tue, 30 Jun 2026
 02:24:52 +0000
From: YC Hsieh <yc_hsieh@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Corey Minyard <corey@minyard.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH 3/4] dt-bindings: ipmi: Add optional LPC properties to
 ASPEED BT devices
Thread-Topic: [PATCH 3/4] dt-bindings: ipmi: Add optional LPC properties to
 ASPEED BT devices
Thread-Index: AQHdB5N07GOCG0yUdU+n8UrPxJS92rZVqDmAgACyo4I=
Date: Tue, 30 Jun 2026 02:24:52 +0000
Message-ID:
 <TY0PR06MB6855F690BCCCA45172F3F0AD93F72@TY0PR06MB6855.apcprd06.prod.outlook.com>
References:
 <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
 <20260629-aspeed-bt-bmc-multichannel-v1-3-fc23ee337f7a@aspeedtech.com>
 <20260629-bogus-vocation-db32e55a595f@spud>
In-Reply-To: <20260629-bogus-vocation-db32e55a595f@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
composetype: reply
undefined: 3246691
drawingcanvaselements: []
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB6855:EE_|TYZPR06MB7169:EE_
x-ms-office365-filtering-correlation-id: 2210ad80-fb20-47a6-c763-08ded64ec474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|4143699003|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 /xSw4ciqCgZWuFgVqi+ecceFlue12r7E0zB993jiV9z6rP2j8KK+PpQUYv5y4eyG2lkKejYOcAIQsBobl51ukEh6uDRCa7EBr1dMkM35DSYYHy4YytSLTL7jdLDSh/0SAz5wu+/dcqAAlrCqzYw4agsGCR+43GYsOj3CX6H57zFmuzz9lGgZJhiEPt1mAQv9CesnNSB+Y/KL0AOAGc/PZHCQ3IjtOIZ5r6FuzrCa2zaYj6UPC59Yr9vsmHG0D58Ska8UBDVuCJOaSFnTtytCcDD5JyoXZq4FyPkZ5fAyBFB5o8kdX9+UMc+KR9OkMnMvX8HzCpXL6kz9bEMUcs+htlEcwyt+nyDK+8aAjEm6AenPaPl2AdK7imDPWq4QhpXGVnT8kjSeWvc/85wBHzyamZvn5fwI0ilY4dtiM96lJXXUrSZlJIAS2bI6coYztoFqkxAb9exUYdLAYrnzU1fFPXAxGQxFQRxkNzIbApNzHasyR5eWPfH9hPKIxvYM5kiHOtccBrRV2PdkHS8L0ad7U945FoAnBYmio9jaMBKhA6jaxUEn88lzysSn9pl1Ix+LV5pIovqiY9qCa+6PtprOagVoUYTHG4tabRlXWl2YQYVPi3forZUwRIGNfiMSLE9J9+yAV7ihuLwxgXbPlKqQ202+Js5Ng9gqoYegufKJpD4rAUFtvzG8L5AXWa7yUm9LkddBXA5rZOCBSKS+XBe0D6cEsempHsytNmN4b1Y2llU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB6855.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?SGtnRmovZnBoaTgxTEtKckR1M0dxeG1aVGEycE1Zald4NHZTVWVFYjBOazBBRDBl?=
 =?big5?B?V3BJNFJCdHZyQytSY2cxTWVWRFVwM0k3MVZHam4yNkVVMksvTlhwaHAyaUx4TGkx?=
 =?big5?B?MkE0ZC9pVUx4SDAvUjlTSjMrRkhDNkovR280TzR0VDg2ZjZBd0dLWTFJaVZVTld2?=
 =?big5?B?ZFE4TXJzUUlvcjdZSkdjZ21IbXgxVTRRVm9ZSHRBbm9VcEE0blR3YUYvMlBiMzg4?=
 =?big5?B?OVZIRVlSSjF0MW5PaWl2Zk8vRkVmaHpoRUpZYngvakhpckVBbndNQ2ZnQVFYRWky?=
 =?big5?B?NkF3ZmcxME5URUQ1cXQwcGV4UnFOUTVib0o5RGZUTU5jVmF0RjNCZENNbktsU21w?=
 =?big5?B?K2V3QSt0MWxYK2Z3UlF1bDZaRjhDUEN0Mm80MFhxRDJ6STR1amhlc2p4MXNsZll5?=
 =?big5?B?azQwcktmN3ZpNEZyVlpGcVNZc1lmSGJ6RU90WHljUExLd21rN3graTV4UEFudkRi?=
 =?big5?B?OWVLMEovWVlkVVVRMW9VbWJWMFZDZGY5UUZsUmd2OExTMXVmNHYwNWtRSjBndnFE?=
 =?big5?B?RkIzZ1NuTGlDbnVmclhqVEg0WjNHUW1UQTcwZWE0c0ZSUDRBbnBWWmRxUXMrb2ZV?=
 =?big5?B?RGlPN3l4ZlJPRGNmY2ljMCs1dkhrOWViK0N2N24rekd1bGczYnkyK2lXVm8rQWVC?=
 =?big5?B?VUpBTnhlY1dWWlU0R0xLNmVzWnhaUVN4RnU3a2tIMTkvaEowcElxaWwzeUlxU0Jj?=
 =?big5?B?bTVqdjdWZDJSQUFTQythd2RQMFdHTTByeDJURW1VS1FmTzdqMGkvbkZQMDEzTWpF?=
 =?big5?B?dlpRWEZ4MHpNd0laS1hhcmhNNnFzNHZBb3lHWlJPckltL1JzRVc5OUNuQW9vNDhn?=
 =?big5?B?VU55VWQxWk9VLzRHNm9BaFVYSkV6YlAyU1dNY2czSGFoeDVQYWN6QmVqbFZxUks1?=
 =?big5?B?YnRJR0Ixd0xiS0xTRGFLc3FhQmZjZE1xa1d0ME5wc2xPbXJ4Sk16U2Fyc2lCZ2RW?=
 =?big5?B?QnpXV3FmZFpXK0crNGRYb3ZJT3pFTFI5THJ0d3hJWUhKZ0pkNzFCdkN6RzE3YXUz?=
 =?big5?B?cTJ3T1RhUWlHczFIdnkzV1JNdUw5cGR4OUVIY253a3U2RXZhdVFRWTMvRWtoS0Rz?=
 =?big5?B?cHBFVG5Zc3EyMTZKeEc1MWdRcXMwK1JlTVVOWnUrbzMwS05JZkFab05iZ2MrUTR1?=
 =?big5?B?TDVjU29UYzNFTHJpTGhTZHE4TzllREFTSzdoWGdIYWxsVEVYTFdpL09EWjhDbFVu?=
 =?big5?B?aFppdHVpcTRkOVNsV1Y3MkVCeWRxc3NqZ0NtbklWZ2FtWWNsakRNMHlJNVNXODNW?=
 =?big5?B?blUzM2hLTlRQVFNsR0RBL2VEZTIzUVZBWXFpOFNQMU1VZy9lS1g0TkN2d0VVRXJL?=
 =?big5?B?amFENW5WZUp2SFhqTWdHWVVOVUNyT1NuaEY5RVV4aUEzUzVodTlBeGtIdFdVVTA4?=
 =?big5?B?OEFWUWxqYzh2eHdWWHpOTEx3VEZ6bFgwbFFJS1pkVmdycko4SDFHYXhJem16VVlu?=
 =?big5?B?T0hpMUQvZk45RFRiUEhWVUp2UVJoc3Jmb3UvMXNIM0Y2TkFoNHJPZGxNbXJuZi9x?=
 =?big5?B?bEdjQzNjRkIwRkhFR2dpUytidzV1OUE4ZmN4aUFJZjlMcEJBd2pkdi9PclFROHBx?=
 =?big5?B?RGcwdVZIS0dpbGZxUUt2VUo4WVdjWkFLQ0xma0psVUhYeldBVXFrTjlVMlVIRlQ4?=
 =?big5?B?L1JDdDlOMldNaEpLT0V1ZnYyczVBejlWcmYyc0VwSHAyYVhlbE14QUFnWU9NWnNF?=
 =?big5?B?Yyt3ckRnZ1BCcnhFRUliaDVnanVEazNjaVZMLzQ0aUpnbm8ycXhwS245ZkJSaUJW?=
 =?big5?B?d016QXhPcXJXRC9GaVcxQTNhL1RBdnA0L0xJeDVDM0Y2WWxVUWxVQ1VIVmEyM0ly?=
 =?big5?B?NHVmTCtQV08rQnhnV3UxdEE4Z0JtSU1rMGUraXBFdHFjbXF6Y0hZOGRQbFkraUVj?=
 =?big5?B?U0t6SGFJZzhxWEhmbDVYSC9sQjAydnhHNUVkaHpFc1pyaVBZMXBxOTBwQ2dNcVla?=
 =?big5?B?eGM2T25SUnErS2JlMFNrcmtoT2REeGFZWTI1dVh5Y0ZKcG56bVg0a3lLWGM0NWMw?=
 =?big5?B?WUgrQTlodmhYVXloZ2o5SDlNaTZaQUkxSGVVTmNLSGtQZk9SNjFpelJQOXpmMzMx?=
 =?big5?B?WS9NSnN0WjlZNU1VUU1ObTFCV1Ywa2pXRk40U1FJMUlucDlyalBTajZKMGlrVHpz?=
 =?big5?B?TWh4aEg2WG93R2VZZFZPNU0wQXI2ZmhOWkk1OUZGdHhhbUx0OEZmNVF2dGRLRmpw?=
 =?big5?B?Y0NTNitVZzU3anYrQ0ovcG9KOHFEQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB6855.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2210ad80-fb20-47a6-c763-08ded64ec474
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 02:24:52.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNLfp5CQ7+1fOGd6oX/pgEO0cm5eguH9kOgV81/j8WjmAgDIQyGIWhOyeF/l6sktbYymcJP+GAOrOzmGdZl4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiBXaHkgY2FuIHRoZXNlIHR3
byBwcm9wZXJ0aWVzIG5vdCBqdXN0IGJlIGFuIGFkZGl0aW9uYWwgcmVnIGFuZA0KPiBpbnRlcnJ1
cHRzIGVudHJ5Pw0KDQpUaGUgZXhpc3RpbmcgcmVnIGFuZCBpbnRlcnJ1cHRzIHByb3BlcnRpZXMg
ZGVzY3JpYmUgQk1DLXNpZGUgcmVzb3VyY2VzLg0KDQpGb3IgdGhpcyBkZXZpY2UsIHJlZyBpcyB0
aGUgQk1DLXZpc2libGUgTU1JTyByZWdpc3RlciByYW5nZSwgYW5kDQppbnRlcnJ1cHRzIGlzIHRo
ZSBpbnRlcnJ1cHQgZnJvbSB0aGUgQlQgY29udHJvbGxlciB0byB0aGUgQk1DIENQVS4gVGhlDQpM
UEMgSU8gYWRkcmVzcyBhbmQgU2VySVJRIGRlc2NyaWJlZCBoZXJlIGFyZSBob3N0LWZhY2luZyBy
ZXNvdXJjZXM6IHRoZQ0KTFBDIElPIGRlY29kZSBhZGRyZXNzIGlzIGluIHRoZSBob3N0IExQQyBJ
TyBzcGFjZSwgYW5kIHRoZSBTZXJJUlEgaXMNCmdlbmVyYXRlZCBmcm9tIHRoZSBCTUMgdG93YXJk
IHRoZSBob3N0Lg0KDQpUaGVyZSBpcyBubyBob3N0IGludGVycnVwdCBjb250cm9sbGVyIHJlcHJl
c2VudGVkIGluIHRoZSBCTUMgZGV2aWNldHJlZQ0KdG8gdGFyZ2V0IHdpdGggYW4gaW50ZXJydXB0
cyBlbnRyeSwgYW5kIGFkZGluZyBhbm90aGVyIHJlZyBlbnRyeSB3b3VsZA0KbWl4IHRoZSBCTUMg
TU1JTyBhZGRyZXNzIHNwYWNlIHdpdGggdGhlIGhvc3QgTFBDIElPIGFkZHJlc3Mgc3BhY2UuDQoN
ClRoaXMgZm9sbG93cyB0aGUgZXhpc3RpbmcgQVNQRUVEIEtDUyBCTUMgYmluZGluZ3MsIHdoaWNo
IHVzZQ0KYXNwZWVkLGxwYy1pby1yZWcgYW5kIGFzcGVlZCxscGMtaW50ZXJydXB0cyBmb3IgdGhl
IHNhbWUgaG9zdC1mYWNpbmcgTFBDDQpjb25maWd1cmF0aW9uLg0KDQpSZWdhcmRzLA0KWXUtQ2hl
DQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioq
KioqKioqKioNCqdLs2TBbqn6Og0KpburSKXzKKnOqOSq/qXzKaVpr+ClXad0vvexS7jqsFShQajD
qPyqa6vfq0/FQKFDpnAgpXi63atEq/ypd6Snpqyl86rMoUG90KVIuXGkbLZspfOzcaq+pbu5caRs
tmyl86SntW+wZarMLCCow73Qpd+nWadSsKOlu7lxpGy2bKXzpM6o5Kr+pfOpTb5Qt7Sp0qazvcam
TKXzoUPBwsHCsXqquqZYp0AhDQqrSPd+rOyn3qVIuNurSKW/qr2t7KtopcPE8rhnwOel+Ld+oUGo
w6R3qWWl0bLEpFSk6KS9pb+z5qbsttS3frKzq0ikzqtI936s7Kfev1el37izqMao07resnqwzqZX
wXyz+Kh0ss6hQaZwplWt06dRrmDD9qtZpEi1paaztW+ye6X0pvO5SKprpM65SKTPpL2lcbFxt365
RLx3oUK5SKTPqmulT6prs1ekzrFNt363x6tooUKl56nOxVGt4qTOuUikz6nKp0+lrbWlpKexoajG
oUG90Kq9sbWzerlMpUikVaVpv+++3LDOplekp8F8s/iodLLOwXyz+KFBpkGmuLdQwcKxeqjzp1Wr
SPd+q/nE8sHaplalw8TyuGfA56FDq0j3fqzsp97BfLP4uvSvuLNztbKhR2h0dHBzOi8vc2VjdXJl
LmNvbmR1Y3R3YXRjaC5jb20vYXNwZWVkdGVjaC8NCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2Fn
ZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFu
ZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVk
IGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFu
ZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhv
dXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0KQVNQRUVE
IFRlY2hub2xvZ3kgaXMgY29tbWl0dGVkIHRvIHN1c3RhaW5hYmxlIGJ1c2luZXNzIHByYWN0aWNl
cyBiYXNlZCBvbiBpbnRlZ3JpdHkgYW5kIGhvbmVzdHkgcHJpbmNpcGxlcy4gSW4gb3JkZXIgdG8g
ZW5zdXJlIHRoYXQgYWxsIGluZm9ybWF0aW9uIGNhbiBiZSBvcGVubHkgYW5kIHRyYW5zcGFyZW50
bHkgY29tbXVuaWNhdGVkLCBhIHRoaXJkLXBhcnR5IGluZGVwZW5kZW50IG9yZ2FuaXphdGlvbiwg
RGVsb2l0dGUgYW5kIEFTUEVFRCBUZWNobm9sb2d5J3MgaW5kZXBlbmRlbnQgZGlyZWN0b3JzLCBo
YXZlIGJlZW4gZW50cnVzdGVkIHRvIG1hbmFnZSB0aGUgYW5vbnltb3VzIHJlcG9ydGluZyBzeXN0
ZW0uIElmIGFueSBzdGFrZWhvbGRlcnMgZGlzY292ZXIgYW55IGlsbGVnYWwgYWN0aXZpdGllcywg
dmlvbGF0aW9ucyBvZiB0aGUgY29tcGFueSdzIHByb2Zlc3Npb25hbCBldGhpY3MsIGluZnJpbmdl
bWVudHMgb2YgbGF3cyBhbmQgcmVndWxhdGlvbnMsIG9yIGluY2lkZW50cyBvZiBidWxseWluZyBh
bmQgZ2VuZGVyIGluZXF1YWxpdHksIHBsZWFzZSBkaXJlY3RseSByZXBvcnQgdGhyb3VnaCB0aGUg
YW5vbnltb3VzIHJlcG9ydGluZyBzeXN0ZW0gcHJvdmlkZWQgYmVsb3cuIFdlIHRoYW5rIHlvdSBm
b3IgeW91ciBhc3Npc3RhbmNlIGluIGhlbHBpbmcgQVNQRUVEIFRlY2hub2xvZ3kgY29udGludWUg
aXRzIGpvdXJuZXkgdG93YXJkcyBzdXN0YWluYWJsZSBvcGVyYXRpb25zOiBodHRwczovL3NlY3Vy
ZS5jb25kdWN0d2F0Y2guY29tL2FzcGVlZHRlY2gvDQo=

