Return-Path: <linux-aspeed+bounces-4311-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0993C43327
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 08:10:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpf9G0Cycz2ySS;
	Mon, 29 Jun 2026 18:10:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782720641;
	cv=pass; b=UK6jycn7yyan9bO2178Y1vaX++Eu79XMG+AMTOuk3G1ZntPSB0eRVaeOrliYFAGbUKvGDJycml7M4a6op9mbHKds6GFa2XqHE9W7NhmY/Cw3bNetSINH5XxFp0bL33nl/yw/VmBr8aLXdUv07dpUFtUR7gT9HSzpYLCbt65jVUbEoy0wavronA6cDWnLyolWKFGn7nKdZ+jRe6K5C7JoSseQhJ8y763ASBo7rREC1T9815tkVrwG/lFUQWPaagBgZLzCUrRW6dIHCDB3m/luuVQi7t8lvJebUWJeoK9Sbl5FzvivUkbHCynxtPxxUFISUF/Kz27QNn0jWRFqOKrGXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782720641; c=relaxed/relaxed;
	bh=Uir0rSgMBJBtvu584KYYGjOKgf2aMqWxD2aslLHfQB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myXP28TMxmLZ5nAsgehUZWCrWN1RyV5ZAP9iDuwAbJOUhn5T02mldSwioCgeT1iy+Zzz3VKCct4AuFw6d7Yq2KzuQ3WvsBg1WejtrQc0QiW7qLDELJdbY5EJCVyWNP1mtKX7w8K6YPZQ/2rST3y8AIePFCUdePBOjC0p5U7gENPxxrXa0A++j4lcjMa6+d4x2JQhZHcUEgZwQwXS1pvoPShbcctwmZjrSG35+D97pzpBptcdVmZSeANVrr4Bb+1mEU1XX7N7fxQB/nXwnKoGtXrhrusb2CmG7R1WNxYe5VzFcrYHXx8qtDpkxXI0gBFG+t8RFoYMkREbu7c82aOvjA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=glVqRE5j; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=glVqRE5j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpf9C0V4xz2xl6;
	Mon, 29 Jun 2026 18:10:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjuyVC9bnfGLrcEwl1RyddbSfeDOMB4WdO005z/CySbiZ5lJ8jmQJUwbm3U1g1nXq69dOP+0FmjOSHTU2iiIi/wOKPKhUGX5sjYup5ICVvfOTsw6N55mfulNX2dQLbGseuhNtiWlyeXcw5cLmvCjbCsoOrbghEOL9K8dEE3i5ebiwwvHq8hkL0sR4PYBGdwUNo6TaEUe5dX0UK9g3xqWhyAzbxYGk7AsNzytgAucKtEV4vZ8fR6Zvjv50iB/V8iwZaPwhgwC22EQ6hbWfKOdXJ7mNkAb6p10qxEMob55pKrsr9xlMY/LdsWpbZ7uIPHBkJQ7cAiPIdnsdCicHFGEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uir0rSgMBJBtvu584KYYGjOKgf2aMqWxD2aslLHfQB0=;
 b=sZONRbWgrDyOqnvymtcMR1af+P/hVCBvEty+VPgl4UHh3HE+St4dEjwRnjNSn0iS0sDXuem8BM8qWMx7Cy3I2pKcgPPRXvD4x9JUYvzwwUkVIXHwqdYBJQv4veiwseZ5NsAgqtGaSV/sgEUxn2KodkN0eDVa90r76/rs21BAl8STJOS35v0wpFcFUz265q/lyO262WMBLVRnxj+5UMxg41SniDQz0RwpiKSwU6OVm8SltpVvFdPKyvS6tf/1KPsxtthRmCUOtAyisejI2v7nDaf3F0KpKr9Lvr3nAmEyWo/jjAYqicDdM82AVh2Tnz55fnfffDUZ184xN9R21vhTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uir0rSgMBJBtvu584KYYGjOKgf2aMqWxD2aslLHfQB0=;
 b=glVqRE5j/dfaQTVVojn9PgLO022HcFQD/K75959uxBdCPN8UYaIkfHme8ah7Rxl0CimqUXoo29rO1oDapVDU4+HgzuXvyrOf0najQq+9D/Pa4Zxoogd8G4N/84fvDfm3zY3BmnLuMWVnD9evzHFBjhzaH0WLaRyMGJm+xCwik2olHQBWmCF9O+wcdvNV1UQ2BI1pklFGe+/UcPqpW1Kg8/k5yeWS8JiqAdWjL4EpV+88zmHWy+elDyeQmSrrULHtzjuZiAUjdTpkfzguAs3IzijG+yygktLgjyJPnIvTNtZMEeVzq/l+ZaN2yASWjTMEHeYWjWJy5dNeDwFoqKdIxQ==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by TYPPR06MB8241.apcprd06.prod.outlook.com
 (2603:1096:405:384::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:10:13 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:10:12 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: LKML <linux-kernel@vger.kernel.org>, Maciej Lawniczak
	<maciej.lawniczak@intel.com>
Subject: RE: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Thread-Topic: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Thread-Index: AQHcstFRz8cZq16J/U+sBKwdttKpXrZOPRwAgAeWhXA=
Date: Mon, 29 Jun 2026 08:10:12 +0000
Message-ID:
 <KL1PR0601MB42767D6B20A0990D7F46DB9890E82@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
 <e78c2122-d10b-41ce-af94-45f573306c43@web.de>
In-Reply-To: <e78c2122-d10b-41ce-af94-45f573306c43@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|TYPPR06MB8241:EE_
x-ms-office365-filtering-correlation-id: 869bc106-3773-472b-0cd8-08ded5b5d850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|42112799006|366016|1800799024|38070700021|921020|3023799007|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 oWKEx9P/L4K6+NI4bD9alHdj5DOwkXYuj/AngVvfhvm2HTHX0nLboNu85B8KYsfOijH9XhI27FM0Wvi/Wya3kppLEQu0eCv4PVuRddOsnqfSzJZYNlNHVmbS97BVv0jHWouPE55sUmZ810mA5GWVuMSsQTdbsdf048yA/HBZ9oDtDnzflVdk/SfFoSJl/RYtebqQRvMlSUBogQM9N+FYOO5EAv8Z1vLFPzEFAZoSa+jvyeIlmZmVnIWdEE57tZISS9OKbnX13qWcDPHcAmDlYtqYO18s+dMsg6xd8mRpIX/Sg3P6gbxHIi6jy1ZQPiqHJeWJoI0Ta3z5FLanhVjfm/r4aL2djjtVwmVt9HvYvArbWbxoYE8Hu000x20oEr7YHfGmZA+lmHoveomoTOvX2FYYSSGpS9c4tl0b7d4bILk0KCFKTFfG79nU6U98UYmWbfdtMIIOM5Gc+b/GND7TmgUXHDUj+hfnVc6hSRwNsr3CBV6bUIO7yCrol6h0VSuveWx+vgUdfUFEDrTjcnTkAssbQxzbBvkoB6NUeo8LjkXxrtZSNkcPqlL77rk0kxvJ78VtRIk2IOq80xXOZ+2KhFDVTACryzRhN+tOxXrBIJEVcOXrBpgRXZdnNRWH7maUNizerf0+zkj9w3Myi2Fu1peD98jPbXDPiMPp4GfIkrPMCZ/17D0TCj1Wrplh9mpF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(42112799006)(366016)(1800799024)(38070700021)(921020)(3023799007)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1BpZ1c1L04zcFl6ZVlhVDhsSm5ZWHMzS0d1K0VYS0hpQUpEeVhKL2hTNDJG?=
 =?utf-8?B?RnZtUzk1MUZBdXZsMjMyb3NGUW5TWnhqWFpVeC8zQk9acTJIeis2RWJEYVNM?=
 =?utf-8?B?YlVjMXNZcEZ6M3NjdzRwdElWcU1pZm96OFBZYWNvd253OGV4cXBoTWhsaXFt?=
 =?utf-8?B?VmhrSkYwZTI0UVhIZTZKTmJkUE04SHBjM2JiZlpQZ2MybllEczhmb29nYncr?=
 =?utf-8?B?U2FTamhqcG5YNDhySmRSZHlxc29PaVYxTHBMWE1EMkdOT1NwbnNXWVBVNDd1?=
 =?utf-8?B?NEM0aWZCbTYxM0gvNkY2VEhYbVlnbFNTb0l2TWl5TmVia2FyNVJoalZJOEJL?=
 =?utf-8?B?N0t4Nno3MitLUXdtYVRWMmZFVFI4UFhoM0VkLzgxdVdFdHRxWTV5NVl5WFdm?=
 =?utf-8?B?eGM3ejJZaUlsUHpPMkRlWitZdVlETzZlTWVETlJ2ajhHNjhUL29HSFhTUVFk?=
 =?utf-8?B?d2kzNDFPbktBOGlCZUpMbUhoUGVtU3Y0YytFOXRNVHMrRzRLSWx3T1R4S1NP?=
 =?utf-8?B?ZHcycWdxSHE5M21KWlhGSGJneEY5TWd2VmNpamhnK2xyeFJKa01CdHVTZmt4?=
 =?utf-8?B?ZElCUk5kTnljNUMrbk1WaXpSaEFFMFEvbnVmS2grdDBqdXVVb2gwdFlkYW9M?=
 =?utf-8?B?dTdaaDJEa3ZXcVd4bERsMWlTcGFoNURpSUdlb3g5cWN0NW9hM0JQNGJ4T2U5?=
 =?utf-8?B?aXJzeHFyY3BlTGdGZlFDbWsrTzA5RmV5ZkRzSzRoT0dOSUN4SWdJOStDbytX?=
 =?utf-8?B?ODVnLzRNNHY4N2NOSEZBc3pFa0ZyQk5TTlc2MHJzTkRPL0RISHI5WXRnSTI3?=
 =?utf-8?B?L3Q2aGVqWmlERnA5MTZmK1BOM3g2YUtzdVBpRWJpTUwrUE56azlkZ2IxWmFy?=
 =?utf-8?B?SHdVaDlCNzREZmNvcTBCSU9Kc0xJb2Vkb1lmZm9nNmxuTWZOM3FpRUpPQW9k?=
 =?utf-8?B?K0pMRVc0eXI4QVowNkFJaC9KRmpiTG8rR0NDckhVMEVQTHZMU29hT0xqSFhH?=
 =?utf-8?B?Y2VMU0NQVVlXeUJmOGY0bnlFUTVTZk1OclpwOXFiLzJOclkvVU1xbWhSbWNS?=
 =?utf-8?B?d1JuSjNSWnJ0UVp3dFh5TTZHeUx6YTNnMDdUY24vQlBaUnRxbFNjdEpPNm5y?=
 =?utf-8?B?UHdoM0RMQjdiSDUzUnI2c0xBcnRxdTZNVkNaQ2VxMERYcytCMndvZU1SNU14?=
 =?utf-8?B?Y01mcjN5dVh5MkNuNFdjdjFVSndUbEtRTHBpSlQ1U1YzWUlBRlZPcTdTZCtn?=
 =?utf-8?B?NUdmOVdwdzg5Z01VSTMwUnN5QVoyMnBGaDRPWm5BOHBWKzZPTXIzOTQ5RzI4?=
 =?utf-8?B?WmF1SnFOSGozdTF3SjhxZDJiNDJuNjVHSk9oaEh5TnArUFpKUzJndE5yazlL?=
 =?utf-8?B?VkN4RUZ4TUZ5ODFJNUJMNG1meGhRK1g1eDVnVk1VUElXdFY3Qi9IWmEzR2pI?=
 =?utf-8?B?RUxGS1JDSDNtZCtvVUVnMTk3YS9LL1NyZ2Y1dFNmUFc0T0J3d29YZTFoU3Vl?=
 =?utf-8?B?bHFJdUdZOHFENjd3NWFOY2FFWWlkYmorWm91WUZJOTFhMWlpT2t2Qms5RE9C?=
 =?utf-8?B?RldGelhuWVYzajBRUTUyVjRiVUZEdm56YUE0WWQvSnIyRFU4RGFLbHRkRy83?=
 =?utf-8?B?Vy9DdUhIMjkxNTVKNEpkVGZYVDl1aDJ4Qy91dlUvVUJWRVZrSGdwL0w1TjBa?=
 =?utf-8?B?WGRlRXFhZGVyM2g2SkNPd2lLaFFlcVZMdmJLRU5VQTNyRlI4OFNKemZyZDQr?=
 =?utf-8?B?c0IyUCtUd0FSeUluK0tSNTJiL1Y2aHJ4NTFWbHNmR0pEbFBZZ3JlVS96ODBv?=
 =?utf-8?B?aFBRTXZZdkl1TzlLTDh6djhmMDdaMk84czlhTEVrck5MK0FMVmxjeTZseEZV?=
 =?utf-8?B?OEZLRWhCN0xGcFhSNWRPb3BNdWNxMFAxVTdMcDRNK0NXUG5aY3ljRldRRkRj?=
 =?utf-8?B?dG1Hc0RWcDlaTUVQQWJLNnJGSVVjcmExcS9tbFVma1NDcnc1cjY1ZU93eFZC?=
 =?utf-8?B?dWtxWlhBS01KWWFyZDVUZWYrZTFKNmUwN3V3WnpFaitHb0xRVW1kZ2xadVNh?=
 =?utf-8?B?TTZiRERFeU1xdGM2TDhyMjNieEJkdUlaeTFJSS9uMnltSHY3NXJkWTBGRW9j?=
 =?utf-8?B?YXVNbnR3TXFJcDJlSnAvVkE4ckJldURTWVBtc2krYjArQ050MDBTVlZraFdh?=
 =?utf-8?B?TU1XK29ZUldGTDZsMmJtSjVpVC9sWDVtMk9LMmFhNStleUU1Mi8yS3JZODdY?=
 =?utf-8?B?YmVndzBoTXZmczZSd0c2Z04vMmdzVVZJWDhlOVNScnkvaEZGdWhHakczOGpN?=
 =?utf-8?B?bndDS1d2cFgvUTlLdEo0TnZrWVEwWTdFdnlDaWhxT3dRK2pXSUZFUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 869bc106-3773-472b-0cd8-08ded5b5d850
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 08:10:12.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GP5yUck2jnDRZvoeG6zpll8dX8Ps/OM9r0Sjc6XtYgLdfFOqFiEEJzKVxTm7XQxmqRG0esl7DqmZZf8t20M/bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8241

SGkgTWFya3VzLA0KDQoNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9hc3BlZWQvZXNwaS9hc3BlZWQt
ZXNwaS1jb21tLmgNCj4gPiBAQCAtMCwwICsxLDYyIEBADQo+IOKApg0KPiA+ICsvKg0KPiA+ICsg
KiBlU1BJIGN5Y2xlIHR5cGUgZW5jb2RpbmcNCj4gPiArICoNCj4gPiArICogU2VjdGlvbiA1LjEg
Q3ljbGUgVHlwZXMgYW5kIFBhY2tldCBGb3JtYXQsDQo+ID4gKyAqIEludGVsIGVTUEkgSW50ZXJm
YWNlIEJhc2UgU3BlY2lmaWNhdGlvbiwgUmV2IDEuMCwgSmFuLiAyMDE2Lg0KPiA+ICsgKi8NCj4g
PiArI2RlZmluZSBFU1BJX0ZMQVNIX1JFQUQJCQkweDAwDQo+ID4gKyNkZWZpbmUgRVNQSV9GTEFT
SF9XUklURQkJMHgwMQ0KPiA+ICsjZGVmaW5lIEVTUElfRkxBU0hfRVJBU0UJCTB4MDINCj4g4oCm
DQo+IA0KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHVzZSBhbiBlbnVtZXJhdGlvbiBmb3Ig
c3VjaCBkYXRhPw0KPiBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9FbnVtZXJhdGVkX3R5
cGUjQ19hbmRfc3ludGFjdGljYWxseV9zaW1pbGFyX2xhbg0KPiBndWFnZXMNCg0KVGhhbmtzIGZv
ciB0aGUgZmVlZGJhY2suIFllcywgdGhlc2UgdmFsdWVzIGFyZSByZWxhdGVkIGN5Y2xlIHR5cGUg
ZW5jb2RpbmdzLA0Kc28gdXNpbmcgYW4gZW51bSBtYWtlcyBzZW5zZS4gSSB3aWxsIHVwZGF0ZSB0
aGVtLCBhcyB3ZWxsIGFzIG90aGVyDQpzcGVjaWZpY2F0aW9uLWRlZmluZWQgZW5jb2RpbmdzLCB0
byBlbnVtcyBpbiB0aGUgbmV4dCByZXZpc2lvbiwgd2hpbGUgc3RpbGwNCnVzaW5nIGZpeGVkLXdp
ZHRoIHR5cGVzIHN1Y2ggYXMgYHU4YCBmb3IgdGhlIGFjdHVhbCBwYWNrZXQvcmVnaXN0ZXIgZmll
bGRzLg0KDQpUaGFua3MsDQpZdW4tSHN1YW4NCg==

