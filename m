Return-Path: <linux-aspeed+bounces-3761-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF02FEA82E
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 08:12:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgflV6fq8z2xMY;
	Wed, 25 Mar 2026 19:12:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774426342;
	cv=pass; b=WQzNKR0lqvdkPB7x6sS0NglKFGcq9AmiGF3oQbnmhNBW/0Jo3kwuoBx59QtZuUyzpfyiXLUJIZNSbjtGJUhHtjpv+DEAgfRe/d33RTjpR1gjFBZ9QFAwb42Jg3m3d587etIt7WYHuzOmskJb8OQNlJTFsNrRI+a1+0nNPfHYw0apr0QCHO6KplAfZD3FqGyBFg2It1F2jqN3mvb1wlgqxGq8QHTYTFZSnBdMt+FnMwpieDerche98CqRYBMv3EvVsdT78yaRRFAp//+V3qB+vPd9qhvNIlnrwYoriDdGaqvpszJG+npB2tYhJKfBAkP2BJgj0Une36hq68CfrP+fbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774426342; c=relaxed/relaxed;
	bh=/yDs/FdQq/1BW4PEAFwjO7/Rkk0PYccQhccYTeqMUAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XrMj1hjazdLL7Ixx1jdJXJlmapRxD5v4F/8sXYr4jrOBKdrKpxi6AkaDv4Mz57RnLM0vTHDqzKjAokLyH2d92HVHZgbTdBG3SisC7C4ZXwo38zyssVfyDw9iZTYWd9zjuJl1orJrfzSZHETeR9Mr0ucwy9hV6koxOt7gaddZE6Mvpg1yKz/qVeer+QzwvRtQBRXhOWfucRvJ8p8hx9DaUvECv+eDR8Sbkm4OxDcTadoYiGoV8xfOUYVGsCPLs8U808Zdy94teY/IG79vmXvfG3ZQfs/HMCPVNIonXWwRwVRGWGmADC92S3WwmpEEd3qmkphnsmdPq920dF0ek1M9fg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=b2567ZVR; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=b2567ZVR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgflR2yD2z2xMQ;
	Wed, 25 Mar 2026 19:12:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUqMnzK1HoDPZPsUFRNRrb2gVeK3N5AScx1BruijQQXyln9MDF9OQQp9ccxg+Mb7F+SOaRYrHsY9O3UuVeolA2pD/7E3PbxTJO4ys+3CfPbPKRQrX8ivkgPhEXzWRHTERR8hHNCMDXLqDNS9XFRK8CK1Wp1kKjVnRjX630mV41yJ8e9s+1UkDq0JZ3QoPA3E/RXeXmlCQ6uovSaII/sOTjghHfaI1FZNE41hSGJ2qdEbj25GY0Yfo4gVKgmrhUkzc0OBPunS/zWvCvYPkfdRk0E8QokKsDdL5AoruNVLKZoIhyFefOvkx649BUuDvs3SS7+p+nOOfry5cY63htqM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yDs/FdQq/1BW4PEAFwjO7/Rkk0PYccQhccYTeqMUAY=;
 b=ioMHfJo8Hxduk/gIpc1q0+bdXG078Zl/930dQIIQuxQbAsKK7CVJCIFui9o7o5M6eqDhD7NoQt5Pk0xru6QjJvT6dphKRFBvSmQIc5h06UYVf3bYoFQT7OAMLpXUxzht8R+vjWCXNHteilTOhQlQHb0SRn20iN5B/WwOrw4oxgJi1dZc4RLdWCG2qAMGRma2x3ijm9pZBZdkgCEMPRpph3zSfko/j8rKF2VujtZcyY0m1Wu5hEUbQONDcyRxJk235Jf1JfUPlizgnXZpA+6mCcKO71R1NpE83a0RpOIHxf2TkZTyxcew2Hk/AplSwf/WIEksEPuzdZYeP9XzS9EwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yDs/FdQq/1BW4PEAFwjO7/Rkk0PYccQhccYTeqMUAY=;
 b=b2567ZVRd6IfVOccvuC+LLFp6y/sbmrRdl8zyFD1Vq21TrcRJ18rKUIUcfEyXME5ZE5ijH5Yyv7QHyUJu2pF8Mg02Sx6uxcsN7GgNyzzQPas5C7H5GRKtiPY+LIkQUNHnVsxKr+cGMyyb49FQv2ut7JgtB3azRlvJ/4gDWwq4OibuEAYPiju/2kbagvny8EqaUgwXNHUyBHHFQI3T2QjWr+IJ8oxPy46lBS17+EIc+ZbfkEqJwqzgOXujjAa0og1giaDh1mj7eHnQhWYvwTgsjP7D1j4R/88Z2p0IWzJRW9z4iZ5mJLntT0cIEtxiPdeoC5B4KtBqyHaOQBBkE1ieQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB5492.apcprd06.prod.outlook.com (2603:1096:101:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:11:54 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9723.018; Wed, 25 Mar 2026
 08:11:54 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rayn Chen <rayn_chen@aspeedtech.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Topic: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Index: AQHcuzs4qjzU97MMJUicgXu5EEZ27bW9AWUAgAHaG5A=
Date: Wed, 25 Mar 2026 08:11:54 +0000
Message-ID:
 <TY2PPF5CB9A1BE6F0B9087048F46ABD72A6F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
	 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
 <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
In-Reply-To:
 <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB5492:EE_
x-ms-office365-filtering-correlation-id: 17135cc2-8e57-42b8-2370-08de8a462d0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 N7dpt4al5xnd8ZxOh2bZaFM1l2pU9Bx4UBrttsWjOaY4oFKbJi7iCjOgxhKtTGuwYKDzBN3dFTWjkhYqT3wOaANgijj7Sy9558wQOSJjRNxYPiUTjHPbrg3F4Z3WtnEzSsnosfqnNiCO/epmg1//jnN6grtDWj6elOQTP8bd0z5v5IwSL0HfFRPmFMuqPSnNQ83MygwqL540WPZ0bBRMbEIjI40JpPkljCyt8aopRQVkX1QQiuwR4CL/78qFJ+foZE0D7Gl/dbXQh0ll9f4l3H4AzYx7Uz1+qa3G5ThWZB48T3GFGmYUJUY8R3XP2pXeuj9BOAgBr4ytWD76lCeV9MzD5FGn/V1Kb3V4Bb+W1z9zveH4rknqy0aGydhdsvbP5Kg4l47MvxBPRtYJNp/exqNXEx82D5/yHTgRJuBHLOHpnlUfTmJ4to6vwfrtRXF0lyK0ptsIf7h5Hr8U9L4gA3AlvtEIP911GuH6bV+o7PnZTVZcwXNHOqT/ATXltqKZ5NNT+Jt8G4fl1ANmVAg7h5xQ7IKzXNVDuyGLeYO85UO2+RnVqQSqqEQVRCglQ19xt1S77yZlnXkwO4yORDWAbPUJgOhsyAkzojFVZepVs+iQQluDv0kDXNCxieQ/qJ0GfiVRbFiN5jdcxQZGPfbGp1TYE7sJahjvjUeBQBdpNoA4D/aArhiFJ8bm5i+byfIIa019E529icWFUn6ISkkB89joz9wkhrfUHIQQ0MlYzd906l5Uvli3AD6OJc6XtFgWcCCx0pp0w6NlkK2Ujh/jhUdMx82RwTjEX5QHl016Ht0a2JZryf6Bu8vN+pa05rcq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2p5bnVCbDRBaVVaZGlSY0hmOVh3ajZydVVJbHVrL1NFMENlUDRIV2p6VVA3?=
 =?utf-8?B?Q0JpaEFJNFhWSUp1WUVCYVdaT0FpWmloQU85c0pRbGpySUVxdHFXYnZYcUJM?=
 =?utf-8?B?VEV6akdYVUxEYXErWGZyaGhsbDEwZndCaDB1K3VTcUt3VzBsUUFoYVphL1ZQ?=
 =?utf-8?B?WTNhZlY3cTMwOWFReDN4amFPTzFrWDFCTk51bzVCeFI4d2ZTdVNvOWpNd05q?=
 =?utf-8?B?d1dBT3dHWmZMcjhNNFBONy9EaVBka05sR2dORnVPUWp3eVBRa0I4TGgwQW1X?=
 =?utf-8?B?MG5kdEUwVUh6ZmwyU3VFSzBIdkh0R3lYaXlKMDl3MndqcUUyWExjc21zdUVM?=
 =?utf-8?B?ZHpYOCtMUFpyelgvTzFpNVhXRkMrMmtQK0J3bDMwMVEzTS8rNk1YbnRNZHhJ?=
 =?utf-8?B?R1FxUTdCektaMkMxVzFzeGQ4c3VvcTR3K2VadDBEN0h4NURTTmE3ODZKeEFy?=
 =?utf-8?B?ditDb1FOTEd3bDZQOERVR2hMdHdHZjllblRycmFjdjNpTjdpMVpaVFhzbzNq?=
 =?utf-8?B?aG1FY0MyRzAvVEtmN1U0enFMd1kyczkxdm1iSjlvUlhaeUtCVGkrVWJRYm5F?=
 =?utf-8?B?U2tsdzZhSndhSHA0SjROSWRHL2RuQXQwa28vTmVnUy8yckN4OEwzSVhBOWE2?=
 =?utf-8?B?Z3NXaDRYYnN1WE16UkE3M1BTelN2MlVuZ0YvWkRXaS83dUo2eHVvOWJLNUdP?=
 =?utf-8?B?VEFqeHZrWFEzMXBoWUgveVF2OC9aRUtlVjlLcE8xRk90VXlrN1ZiU0JmYWdh?=
 =?utf-8?B?NU5ERU1ySHFxNG15T2VURTZLdDZXa2lOdnhFVStvblVSNDRpcGlHaSt0ajlx?=
 =?utf-8?B?MU5vanM4TkI0TzZCbUNKdkp3b0N6TUZrOFhadDRVMGZvTXk2b2I1d2JFS2tn?=
 =?utf-8?B?aW1KRGFCR1dtazZvL1dub0VYbWxlYnREWmhnQTZrbHpZQkgycnVRczJkTjdq?=
 =?utf-8?B?anpEUXJhV3dKelJPMnZHSGZDZTljcXdmelVhKy9OUjNkaEdXaUhpNGVEakdW?=
 =?utf-8?B?b2YrWTdLWWFQczd4TGxNSjhtSjZJVXBYRlJzS1hDOVVZV2VxM0pCY3ZFbDVi?=
 =?utf-8?B?b2EvU3ZhSzYxb1RncjF4OWpQM1FsdWxITDRuZ3k5N3U5WUZoNWlQVWJuNUp2?=
 =?utf-8?B?T0JMTmpWdDhEK0hyampMVlI0VTN2eHA2cnd3emljTi83cnAxd25TRDd1R2dL?=
 =?utf-8?B?OGJhU3ZRbHNweXBIMW5TWHcyMXpSaDFOTFlTQ203OXdkWkJSR2labVJ3K3dG?=
 =?utf-8?B?VDVObzJlZExveU9xalg1ZWVVVit5VVppc1A5YzNwM0p2ZjZ5YTZ5dnlKNnVv?=
 =?utf-8?B?aFVvd2tuT3ltRXYvVEpJK1RwL2hRUTZXc0FJQU5TUHUxSjdyQjROMmFKc2o5?=
 =?utf-8?B?MFdlaFBBZ3dPS21xTnROU1htaDRXL2ZuVmE1VllNeEFEaDVuL1NPOTFuQTRn?=
 =?utf-8?B?eFlJYlI3RnZqRnNMZGEzWEZRS0VCU1hnV1BXbm9ReVdOSWY1SUZRVk9lYVhz?=
 =?utf-8?B?Ti8xNFQ3YnRRZHp0WjZyaFZRMGVyOHdRTHZNRkJWcWJmV1JPQzRUcWtVT3pj?=
 =?utf-8?B?cGl1SDk2V1pwL3VVeDVGYjd6bmRnUW9YUVVXR2FHS292Wnh6TkpKUVhZVFpl?=
 =?utf-8?B?aHRqTVVlM1lKVGtTZHpoSG5UMEh1V2M5aWlHa28xMEp6SUE5S1JPUG5lVHEz?=
 =?utf-8?B?KytOcG41M0s3bWZ1R3Z6dFowbzNOUThaYVYyeGx0QytKQ0UyMWJFcmswT1pM?=
 =?utf-8?B?Y2N3dnRHckpCQXMxK1ZtWEhDMloyMXFOSWQ5L0x0eDAvQ1NodlBzVDJxRzFh?=
 =?utf-8?B?MU9EWk1PVG1jcUpFY0lMRVIxRWxmUGl4c0wxbndCQTNlNXJFTHNBRjVNOFZh?=
 =?utf-8?B?NEVRdU4vZ2MwZnYyMzY5b3lQL1FJWmwzVWx3RlZobnlaZEJrVVpsbDFFMkxC?=
 =?utf-8?B?OE9jL3ZqK3dkdi9IQmlZK3dvL01IZ0RrQmhibGpUL2pSQ2RmTnNsWTQ1UmRk?=
 =?utf-8?B?dTFwRkthVkxINldYcFRXemhRT0xzK3k5cHJ5Vi9idGYzcG5uUVl0RDA4UEkr?=
 =?utf-8?B?MDczaFdnMFdoZEczSXJpWWZkb3QvdnFIVk8yUEpFVEhMbVQya1hBbnZwTklh?=
 =?utf-8?B?WTNYMVUzcEsvdVFXTXVpQkpQTVlaUldJQkpkU2lTWVcxZFZNQ09UQlQ0Z2Zu?=
 =?utf-8?B?Z1YwblZkYkhYSEgzKzNyWG8vc09ZYlpvWXpKeDlCdTh1L0lPNkplcmJlL0ZR?=
 =?utf-8?B?dGtYOVpoMVQxZlg0cnFpS203aGRJNnZyVHRybHoyRWFXYUQ1NHZOQk5FcWRz?=
 =?utf-8?B?UHdYTnlhT3FpWU1QeUltR3VKam9BcUQzRTBKS2pWUFpVTVBoRVAwQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17135cc2-8e57-42b8-2370-08de8a462d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 08:11:54.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7kWORLoyDn7MuFU8bUIGyLuloaG0LeutTP5KXQJOUxtKvnWSVjMYPsyrNu4hg63qOzqljbIw3ymm31vQHTYjuNQ4lNA4j8vF/HnDJsnh5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5492

SGVsbG8gSmVyZW15LA0KCVRoYW5rcyB0aGUgcmV2aWV3Lg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjI3IDIvNF0gZHQtYmluZGluZ3M6IGkyYzogYXN0MjYwMC1pMmMueWFtbDogQWRkIGdsb2Jh
bC1yZWdzDQo+IGFuZCB0cmFuc2Zlci1tb2RlIHByb3BlcnRpZXMNCj4gDQo+IEhpIFJ5YW4sDQo+
IA0KPiA+IFRoZSBBU1QyNjAwIEkyQyBjb250cm9sbGVyIHN1cHBvcnRzIHRocmVlIHRyYW5zZmVy
IG1vZGVzIChieXRlLA0KPiA+IGJ1ZmZlciwgRE1BKS4gQWRkICJhc3BlZWQsdHJhbnNmZXItbW9k
ZSIgc28gRFQgY2FuIHNlbGVjdCB0aGUNCj4gPiBwcmVmZXJyZWQgdHJhbnNmZXIgbWV0aG9kIHBl
ciBjb250cm9sbGVyIGluc3RhbmNlLg0KPiANCj4gVGhpcyBwYXRjaCBkb2VzIG5vdCBhZGQgYW4g
YXNwZWVkLHRyYW5zZmVyLW1vZGUgcHJvcGVydHkuDQpXaWxsIHVwZGF0ZSB1c2UgYXNwZWVkLGVu
YWJsZS1kbWENCj4gDQo+ID4gQWxzbyBhZGQgdGhlICJhc3BlZWQsZ2xvYmFsLXJlZ3MiDQo+ID4g
cGhhbmRsZSB0byByZWZlcmVuY2UgdGhlIEFTVDI2MDAgZ2xvYmFsIHJlZ2lzdGVycyBzeXNjb24v
cmVnbWFwIHVzZWQNCj4gPiBieSB0aGUgY29udHJvbGxlci4NCj4gPg0KPiA+IFRoZXNlIHByb3Bl
cnRpZXMgYXBwbHkgb25seSB0byB0aGUgQVNUMjYwMCBiaW5kaW5nIGFuZCBhcmUgbm90IHBhcnQg
b2YNCj4gPiB0aGUgbGVnYWN5IGJpbmRpbmcsIHdoaWNoIHVzZXMgYSBtaXhlZCBjb250cm9sbGVy
L3RhcmdldCByZWdpc3Rlcg0KPiA+IGxheW91dCBhbmQgZG9lcyBub3QgaGF2ZSB0aGUgc3BsaXQg
cmVnaXN0ZXIgYmxvY2tzIG9yIHRoZXNlIG5ldw0KPiA+IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJz
LiBMZWdhY3kgRFRzIHJlbWFpbiB1bmNoYW5nZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
eWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vz
IGluIHYyNzoNCj4gPiAtIGNoYW5nZSBhc3BlZWQsdHJhbnNmZXItbW9kZSB0byBhc3BlZWQsZW5h
YmxlLWRtYS4NCj4gDQo+IFdoYXQgYWJvdXQgYWxsIHRoZSBwcmV2aW91cyBjaGFuZ2VzPw0KV2ls
bCB1cGRhdGUNClJlbW92ZSBhc3BlZWQsdHJhbnNmZXItbW9kZSBpbnN0ZWFkIGFzcGVlZCxlbmFi
bGUtZG1hDQo+IA0KPiA+IC0tLQ0KPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2Fz
cGVlZCxhc3QyNjAwLWkyYy55YW1swqDCoMKgwqAgfCAxNw0KPiA+ICsrKysrKysrKysrKysrKysr
DQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9hc3BlZWQs
YXN0MjYwMC1pMmMueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2kyYy9hc3BlZWQsYXN0MjYwMC1pMmMueWFtbA0KPiA+IGluZGV4IGRlMmMzNTkwMzdkYS4uMzhk
YTZmYzY0MjRmIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pMmMvYXNwZWVkLGFzdDI2MDAtaTJjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2FzcGVlZCxhc3QyNjAwLWkyYy55YW1sDQo+ID4gQEAg
LTM3LDYgKzM3LDIxIEBAIHByb3BlcnRpZXM6DQo+ID4gwqDCoCByZXNldHM6DQo+ID4gwqDCoMKg
wqAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICvCoCBhc3BlZWQsZW5hYmxlLWRtYToNCj4gPiArwqDC
oMKgIHR5cGU6IGJvb2xlYW4NCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOiB8DQo+ID4gK8KgwqDC
oMKgwqAgSTJDIGJ1cyBlbmFibGUgZG1hIG1vZGUgdHJhbnNmZXIuDQo+ID4gKw0KPiA+ICvCoMKg
wqDCoMKgIEFTUEVFRCBhc3QyNjAwIHBsYXRmb3JtIGVxdWlwcGVkIHdpdGggMTYgSTJDIGNvbnRy
b2xsZXJzIHRoYXQNCj4gPiArc2hhcmUgYQ0KPiA+ICvCoMKgwqDCoMKgIHNpbmdsZSBETUEgZW5n
aW5lLiBEVFMgZmlsZXMgY2FuIHNwZWNpZnkgdGhlIGRhdGEgdHJhbnNmZXIgbW9kZQ0KPiA+ICt0
by9mcm9tDQo+ID4gK8KgwqDCoMKgwqAgdGhlIGRldmljZSwgZWl0aGVyIERNQSBvciBwcm9ncmFt
bWVkIEkvTy4NCj4gDQo+IEFzIHdlIGhhZCBkaXNjdXNzZWQ6IHRoaXMgZG9lcyBub3QgZGVmaW5l
IHRoZSB0cmFuc2ZlciBtb2RlLCBvbmx5IHdoZXRoZXINCj4gRE1BIGlzIGF2YWlsYWJsZSB0byB0
aGUgcGVyaXBoZXJhbC4NCj4gDQo+IFdoeSBtZW50aW9uIHRoZSAxNiBpMmMgY29udHJvbGxlcnMg
aGVyZT8NCj4gDQo+IFBsZWFzZSBrZWVwIHRoaXMgZGVzY3JpcHRpb24gc2ltcGxlIGFuZCByZWxl
dmFudCB0byB0aGUgc3BlY2lmaWMgcHVycG9zZSBvZiB0aGUNCj4gcHJvcGVydHkuDQoNCldpbGwg
dXBkYXRlIHdpdGggZm9sbG93aW5nLg0KZGVzY3JpcHRpb246IEVuYWJsZSBETUEgZm9yIHRyYW5z
ZmVycyBvbiB0aGlzIEkyQyBidXMuDQo+IA0KPiA+ICsNCj4gPiArwqAgYXNwZWVkLGdsb2JhbC1y
ZWdzOg0KPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
cGhhbmRsZQ0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246DQo+ID4gK8KgwqDCoMKgwqAgUGhhbmRs
ZSByZWZlcmVuY2UgdG8gdGhlIGkyYyBnbG9iYWwgc3lzY29uIG5vZGUsIGNvbnRhaW5pbmcgdGhl
DQo+ID4gK8KgwqDCoMKgwqAgU29DLWNvbW1vbiBpMmMgcmVnaXN0ZXIgc2V0Lg0KPiA+ICsNCj4g
PiDCoHJlcXVpcmVkOg0KPiA+IMKgwqAgLSByZWcNCj4gPiDCoMKgIC0gY29tcGF0aWJsZQ0KPiA+
IEBAIC01OSw0ICs3NCw2IEBAIGV4YW1wbGVzOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmVzZXRz
ID0gPCZzeXNjb24gQVNQRUVEX1JFU0VUX0kyQz47DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBjbG9j
ay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVwdHMg
PSA8R0lDX1NQSSAxMTAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gK8KgwqDCoMKgwqDCoMKg
IGFzcGVlZCxnbG9iYWwtcmVncyA9IDwmaTJjX2dsb2JhbD47DQo+ID4gK8KgwqDCoMKgwqDCoMKg
IGFzcGVlZCx0cmFuc2Zlci1tb2RlID0gImJ1ZmZlciI7DQo+IA0KPiBUaGlzIGV4YW1wbGUgZG9l
cyBub3QgbWF0Y2ggdGhlIGJpbmRpbmcuDQpXaWxsIHJlbW92ZSBhc3BlZWQsdHJhbnNmZXItbW9k
ZSA9ICJidWZmZXIiOw0KQWRkIHdpdGggYXNwZWVkLGVuYWJsZS1kbWENCg0KPiANCj4gQ2hlZXJz
LA0KPiANCj4gDQo+IEplcmVteQ0K

