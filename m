Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4904606A321
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Nov 2026 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DyJPnOUZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ25d2Nn6z30C6;
	Thu, 12 Nov 2026 11:56:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794444997;
	cv=pass; b=mL3xdeWG3jIxsbUXJsjWzYVDrbvNwSj+rIaFKOTkJ036aKRKsm4FEjY0TNSZ4U99jhETK4hlIoCR3pLBSlh3J/VXTMKO53/1V5jOjfa3UXNzISt6e1AuAoZmid48vSLYIT6uRLRCraUNIEWVdS4+grlJCBxn7MPPOJ53HAZnwPkmcW0NIOdcyaRX8gdmvwlZriap1r/trkdXNvIchgicFexlskC2agzX9ufRhj6K4Vw6xrWljYfLC0lrxpWoshuptnV5iK/aDwX76izBvSyPOXXvgPjdhS4RDeg8IZrd9q4uGwxuyMz3Xy5Vddm/9TFz6yRoUIlushrx27Nn/ehwmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794444997; c=relaxed/relaxed;
	bh=w/ORXFPuNc2htP9MkKBMdX+QO80tQbANeIp4MPSgze8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9WvT28EIXUWyTHeAmOrviZzNZqu8T1J0Y4dgsJ04QpdOx+tG0Ah6+RPea8BnLcWVfGiuPZYcFZ3hIUeXarDxLd9cdwWOtlEH4RGUix68iSrQdRnL9L3kfeHrWsQE/KXZRrKSdNoy5DLlOC3PwxUly5U/yJyNz+XVUFc530T821QsVk2S/C/Lv/Py7OAgE5GaE+WBypk3q3UYgwwN2hHv/qgmxDPs5R2V80zks12owLMtqHRAVJR4N6r9fYHop30mkbucELDuIP8UN+Bi183+bspLy3z4T8VA9PdABL9S4CA0QTmaHU1BSqwL/OcxUuufmxP8dQEeG0sbwiGv6gDKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DyJPnOUZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DyJPnOUZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ25c0CBDz308H;
	Thu, 12 Nov 2026 11:56:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxGDVCHSnHCLhsM7Wmt7+fXCGqd91y18weGpHs/z+cYo6d91Mc5OZIDzjg9t94WRd8ICGZfXSSWTlYJsSY43Aqpv6eTN1hHciKAHCgQQhbNmXKdkAXdeHem1U3+FcmRS6fkcunN8zbS9/iqdSN7GW5ZnTi5xEEwrXVGJ9LQ4hjq+0rfXjRu34QQ9r5mMbO8Vu657QCZu0YDfPaak3N4Kb/UYmvKmrMb8OmYPxYit6b1B7zLtjgJiOuhX8bLUAXuR+LWQVlKpNJHcViyCSUqtUN96CClgpbA7BJJ5DFcTjoUWp1MbP5ka6f2eZHlx9TSNreku0ve/Fr7Zx6rLXFULCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/ORXFPuNc2htP9MkKBMdX+QO80tQbANeIp4MPSgze8=;
 b=qSt9TSuhfUveptQY72CdzA98msSNesvHZrYCnmWoluA1n839cCwKGfUvDLwgQPXau+smX5vA2BJM4NCzlXB5B41XGn5mWgzu4P5aNe0K5bV4OVFXlthaS6wQHeKIXMjxRJGjCkeR587rCdflx9pACcXv/AP5fsiCgfmEomZJHlqkIZ0ldhl8JtZZXPMMBKgu4ZaixXNaadaEbH4G6nckqrbW18UfmoMjR1t853+llXfGgqxsbuKzeQrhrOvBnhMklEdf3yPBI9tOoucj6Ya71k7vK3A1ORusJMmXLSls5twjyTupBcv9qea8P6pZJKphERQ04owTBdaWW9K128N5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/ORXFPuNc2htP9MkKBMdX+QO80tQbANeIp4MPSgze8=;
 b=DyJPnOUZcUdtj2it6jdcZGa7mPbIkE3JsOPspWjCgLPGbaBfq5wwgfxtVPXPO72E+AEhjWrULRmsdOlr8K+TqI+YHB6pdjpvksluSiekc43QjpPq1kyiDTOIiJjj1Zl+HlKEnJdzpgm26RevkK11j/aOADlhiNVN5M5ZHBmarVsyqNm6muw62Et4pZ8OKya+Ak5MBGMxfK4oSTdNC6CtXaL9h3KVpgPfUAhBAmjuwaF3ragcVeq8+anwPeuXTd6ghIgAapIHQG/MiDC0jvdst772lOsJA4yKfqUa1VLhLeqEw5Xz+Qjbph+2RqbkMsoa2YgdPFkW1ZUMbPBU7U7pUA==
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9)
 by TY0PR06MB5007.apcprd06.prod.outlook.com (2603:1096:400:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 00:56:18 +0000
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f]) by KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 00:56:17 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>, Myeonghun Pak
	<mhun512@gmail.com>, Eddie James <eajames@linux.ibm.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH v2 0/2] media: aspeed: order probe cleanup and last close
Thread-Topic: [PATCH v2 0/2] media: aspeed: order probe cleanup and last close
Thread-Index: AQHdcNAYsFgAlp1MsE68E0g5h4nL1bco5TgAgAC5lBA=
Date: Thu, 12 Nov 2026 00:56:16 +0000
Message-ID:
 <KL1PR06MB6942E30AF3E81DC84335DCB4F1702@KL1PR06MB6942.apcprd06.prod.outlook.com>
References: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
 <5b068d22-4f46-4f82-8914-ffed5a0f6f0f@kernel.org>
In-Reply-To: <5b068d22-4f46-4f82-8914-ffed5a0f6f0f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6942:EE_|TY0PR06MB5007:EE_
x-ms-office365-filtering-correlation-id: b8366f51-6f8b-45f0-c521-08df4057c201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|6133799003|18002099003|4143699003|56012099006|10067099003|261022075727099003|261009223027099003|261102123227099003|261021121427099003|261028144727099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info:
 79uQWPLnqkC+P8G+qf45/LQ5bE6VW9cAikIUynIKsY7XFagbo0odHzrRUKXOXfZdQwkfGKwa6E6JZsJz+b3d44h1sIe2MjBhfbR/K1fxAVI7TvLfR/QWClkRYPyXRvBxxmW/B4IDK0wOnOPHkJgPZBpUlFvPoOEWKNYUzSSf+dDTYRRMW29FS4Yrldxo/4rsAsk9h0I8++dNLjH77/S26IwLKsXMJ1ppLbfyakBfC49TU1+fC8bnSiNW/Itd/2GhkE4WBTpJSssAVdFSPOMVNMypxU2q8fuSzwoyrqw8Nw9fcZQrMfANRKPlz1AGBSilnR8LxigarqTc09cDot+5hu9VyQ8CpzRe4gE7m5wou3q9PGGA7aIg3En37M+rrbM+w2Jk1NsuxQfybtyTWti2M0Ozzok1F4CC298swqa1SCg8NAhSMnil/Th+6i75v/Jf1mlQcDR71ukmum904eYnZBUfbZlEyuXJQKvcYsvxm8GRhd/KGOxpDdAT/0KkSjuFK1TMR9/0NqSq7tkQUlHLyqRlmnSt1Fee/hDgqnU0+rX6uXQC3+MA0yAIvq3V+DUfhJzKv5J8GyzjZ6n6ZHN3KYCJprN38u5i6TyYmblN822CROEVHdNXGv1zIeQaItPiaIZppnRneDYYiTjYLY3aluFfL8g/yw3TZm1EwQhbzSXuGQgEPAz8k4CcfOLM5EV+S3cVAhJZYd4AILvFO7kcKeeKNQEBOavMJMK0deuk904=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(6133799003)(18002099003)(4143699003)(56012099006)(10067099003)(261022075727099003)(261009223027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVZYMnA3T3BrS3pTczd0MFRNQ3lMeG1kaFlQdHlncWN4MTZGZ2sxVXJZdENt?=
 =?utf-8?B?OVYwcXNiV0FDNy9xTEJxVXBjVXYrdXlCWk1rbHlFektsZ0NESTZJbVpUMG9V?=
 =?utf-8?B?QmdBUDVMMTY4VEV3SDRZNVRGQkhHbEZwcS9ZU1V6aGwrREtyM3FJWHVGaTgy?=
 =?utf-8?B?YW5uZmVncDJ0bnV6SmhtbkdqLys4WE11cTBFS2pQZ2dHZ1VlSjZCWWJIdFNF?=
 =?utf-8?B?MzR1ejRiQzd6dS9qVEM3RWlRVVMxamE1SDRJaTY0NW5MS25PU0FlTmZZTXJL?=
 =?utf-8?B?OXNwUUhMYWU0WUQrMFZvRElLWSs3eEdkeHlqVXVLNTBTcEJSa0lHcVduZWFx?=
 =?utf-8?B?Ylo2U0Q2eUtMOHFNVXMvMUZtOExFTXlFRXBUTXY2ZnB2aUVpY1lZY0NQUmdS?=
 =?utf-8?B?LzYvVWF0dUhJUEwvVDBvU25xcUd0M085V3FNL1VzMDlhWlIva3BVVkZWUis3?=
 =?utf-8?B?bWVEUCtPV01OakNNOTI5SjNwTjl3VEphWWcra2huQnUrTGdRdzA5QWRLQnNn?=
 =?utf-8?B?L3BwbTh6bWZBOXNJbGZRVEFTMk01U2dvY3picUVKYTRpU3B5N3M5U29TQjJO?=
 =?utf-8?B?TFhzM3BJK1RKVjE2cGJSdWxrQ3FWNS9PalQyZEUwQ2puQkwrdkJaWVJiSVhT?=
 =?utf-8?B?V1oxRGs1Rm0weGdReHVkc2Y3dUJ2YTA2eVVZRE9VSmM0UXk1NDJiYTJMdVI3?=
 =?utf-8?B?MkpBMGlUOW5IVVZXd0E4MElXWWJHZnhoOUtGUUNDTmRnelF0YUNydjhnK3Ay?=
 =?utf-8?B?dXk3TXl2WEpzRjlEeDF3L0trejE2L0dMR2E4UmJob001OTNINmlGb01TOU5C?=
 =?utf-8?B?KzFVS050V0EyUHQzdkhmSHhzNEZ6Y0hFdGdYWklkV1Rad0VjeEZxWkNDV2RU?=
 =?utf-8?B?eUFZMmgrdWN6MXZsWHRTSi84OHBOR3YrWDVtblpIc0NWVDByZHJQd3luZzdr?=
 =?utf-8?B?Wk5STW9FeGFKRTBoMDBJN3VIbEJSZHcwK05USjI4Z2J1aHhJYXd2aEExN21Y?=
 =?utf-8?B?eDk0MFR3UzlzaHg5UHcySldpeis2UmVibUxlYVBVY3luTHp6OERZN3pHZ2hl?=
 =?utf-8?B?WjFYaWJuUkxoSUlZN0JzZWlIc0VWYmVWWVNEMmhuQlphRTZNbnRnMHhZVmZE?=
 =?utf-8?B?VklTUlp1Smo5V05jRHl6ZWQ2Vit6Sk5mVlhiUEFLZUN4VEJicEduWGhsQlc1?=
 =?utf-8?B?NnFhRlgxc0F3VnVwclJkRzVXRThWM2lZR1JPQUQzSHZNcFQ1VTBLTGorMjN0?=
 =?utf-8?B?b0NwWUhBQ1N2TXQyaUJrM3h4V2lIT0xKbUdqanBqQ2FIZDZQYUhLeFBYUFR2?=
 =?utf-8?B?R2pIbjA4eG9zWW81YmVZVzNpdGpOYStqVEVFOWJGNXlYWlExNkxKMG5tMEds?=
 =?utf-8?B?Z0JjK1BjcHpTRCtvazRwV08yQ1c3RnovN1R4STYxclVKa3U5RjU2N0s3cVU0?=
 =?utf-8?B?b0dtTjBuMVI3bURQSzZtejFsL2NYVzlvVXRjMTM2VmZhZjNJTjh6a01ST1Zx?=
 =?utf-8?B?dDc0UUhHYm5kcjYyRi9lWWxmNitwaEJUelZBTFZ6cE5HeWdaMUJ5QTkzOEhk?=
 =?utf-8?B?MkFzekY3clVqL2tjbW4zZ1A5N0JYa1B2MHBhczZLMEpzR3NybDFNQTNucFJO?=
 =?utf-8?B?VGw2eldnYVVEcUVJNkdLQWYrOE9xNzNsRlZFN1MvWExNZFlJTWNsVXZOaXda?=
 =?utf-8?B?YmkvV3p0MkVYSktsdWhUL3ZYNzh6dHNKMHhuMDVCc0JzQm5GSWIzMGx0dENl?=
 =?utf-8?B?b2dxdWllcnBUNHFseUM1a2x5SVRZZDFRSVBHYVhweTBZQ1JObHpvSmE5dGV6?=
 =?utf-8?B?eURVVDUwblQ2YVh5WGJtUy9INEhuSjRpYkNDZkJUekNCdDNGL21VT0t1NVd0?=
 =?utf-8?B?UnRISE5vVjVXa2hvYXA4ZGZvZEJpdm43NVo2NGt2UzY2U2tmck9qc0ZxSmh6?=
 =?utf-8?B?eDdwRlN4ejNCaGdodkM5YXJtV3JRTnBXQmhxNTdiK05xclViaDBzVXBNeXUy?=
 =?utf-8?B?bFhzemhsWTlWdVdBZ0U0MzVYa3BqRGlOZ0V4ejMreXp3a0J5VzF5T1F0MGZs?=
 =?utf-8?B?YXZoNmd5QVVYbWFsRUsxRU51VXVrR3dpanlFMzd4MUFaWXRtUkd6aXlYRXlB?=
 =?utf-8?B?WEp0VWVxNUxObzlrTUxlRG9hQzR0MTFVRW5ZWWJKK2VMMUxXRnB4R0R1VFBB?=
 =?utf-8?B?Rm1HTlZwTTFBK1lNd1k5aTZXekM3L1phUnhnK3lsa214OC9zYWJFYU9ZN3Q4?=
 =?utf-8?B?TjJQRkFyTlVTZmFtejBZL09IaGwyajFyZENGaVhXT0x5cFhWVmxsWEp6T1FP?=
 =?utf-8?B?RytZV1Mxc3B6UkYzT0dGRGhnZUgyWnFuSW1xdmY3VnhFUnc4WjkyQT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	3FKV5FCDAyxQNkdmfAIhJAhCz1qGkVqA0Pu+8HqNpg93RiUFaDFh/Pps5XVC6ketgX2TVNhU0JsYGutr6Z9rFka7xLN8rfwMCWNHzX7jcV7Fr3F+S7kaRkFhEttkERgHCOqzN72XtBrBCaT7UcL1u3RP8zvNdm4ybWqLmAsMDa1AMHxRawZgbfiAjueHkB9QWMjc+wmeGOr6Cph4FkOt6+GsATgmx78yivBKuhpuduBH9+ZTBe1HGHo4GWxgZsqCE8oY7BN75XDLcH8aYWoXO6F0bE16Jd8S508sYb7BkNXPSrYuH2sGToiQBwpV2dxV+UmM3Qe/YTs7pOVcCLvRJA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8366f51-6f8b-45f0-c521-08df4057c201
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 00:56:17.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOfdgAHd+w8D8JIuy1HYh6y/u054fUFBVkXzD/OMMbcRGCd3cZLKMBIEadxG+J+RUSJ2oM2c9XaJRRduKPtz5xIvBdi2WCFetOVgvZ6C99k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5007
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSGFucywNCg0KSSdsbCB0ZXN0IHRoaXMgc2VyaWVzIG9uIG91ciBBU1BFRUQgcGxhdGZvcm1z
IGZpcnN0LiBJZiBldmVyeXRoaW5nIGxvb2tzIGdvb2QsIEknbGwgZm9sbG93IHVwIHdpdGggYSBS
ZXZpZXdlZC1ieSB0YWcgYWZ0ZXJ3YXJkLg0KDQpSZWdhcmRzLA0KSmFtbXkNCg0KPiBFZGRpZSBv
ciBKYW1teSwNCj4gDQo+IE9uIDEwLzExLzIwMjYgMDU6NTgsIE15ZW9uZ2h1biBQYWsgd3JvdGU6
DQo+ID4gVGhpcyByZXZpc2lvbiByZXF1ZXN0cyB0aGUgSVJRIGFmdGVyIGl0cyBkZXBlbmRlbmNp
ZXMgYW5kIHN5bmNocm9uaXplcw0KPiA+IElSUS93b3JrIGJlZm9yZSBtYW51YWwgcHJvYmUgY2xl
YW51cC4gVGhlIHNlY29uZCBwYXRjaCBmaXhlcw0KPiA+IGxhc3QtY2xvc2Ugb3JkZXJpbmcgYW5k
IGtlZXBzIHRoZSBlbmdpbmUgYXZhaWxhYmxlIHVudGlsIFZCMiByZWxlYXNlDQo+IGNvbXBsZXRl
cy4NCj4gPg0KPiA+IENvbXBpbGUtdGVzdGVkIG9uIEFSTTY0IHdpdGggTExWTSwgVz0xLg0KPiA+
IE5vIGhhcmR3YXJlIHRlc3RpbmcuDQo+IA0KPiBDYW4geW91IHJldmlldy90ZXN0IHRoaXMgc2Vy
aWVzPw0KPiANCj4gSSBkb24ndCBmZWVsIGNvbWZvcnRhYmxlIG1lcmdpbmcgdGhpcyB3aXRob3V0
IHlvdXIgT0suDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gCUhhbnMNCj4gDQo+ID4NCj4gPiBDaGFu
Z2VzIGluIHYyOg0KPiA+IC0gUmViYXNlIG9udG8gbWFuYWdlZCByZXNlcnZlZC1tZW1vcnkgaW5p
dGlhbGl6YXRpb24uDQo+ID4gLSBSZW1vdmUgdGhlIHJlc2VhcmNoIHNlbnRlbmNlIGFuZCBBc3Np
c3RlZC1ieSB0YWcuDQo+ID4gLSBKb2luIHRoZSBJUlEgYW5kIGRlbGF5ZWQgd29yayBiZWZvcmUg
bWFudWFsIHByb2JlLWZhaWx1cmUgY2xlYW51cC4NCj4gPiAtIEtlZXAgVkIyIHJlbGVhc2UgYmVm
b3JlIG5vcm1hbCBsYXN0LWNsb3NlIGhhcmR3YXJlIHNodXRkb3duLg0KPiA+IC0gRHJhaW4gdGhl
IElSUSBwcm9kdWNlciBiZWZvcmUgY2FuY2VsbGluZyByZXNvbHV0aW9uIHdvcmsuDQo+ID4gLSBC
YWxhbmNlIElSUSBkaXNhYmxlL2VuYWJsZSB3aXRoaW4gc3RvcCBhbmQgY2hlY2sgU1RPUFBFRCBi
ZWZvcmUNCj4gcG93ZXItb24uDQo+ID4NCj4gPiBNeWVvbmdodW4gUGFrICgyKToNCj4gPiAgIG1l
ZGlhOiBhc3BlZWQ6IGpvaW4gSVJRIGFuZCB3b3JrIGJlZm9yZSBwcm9iZSBjbGVhbnVwDQo+ID4g
ICBtZWRpYTogYXNwZWVkOiBkcmFpbiBJUlEgd29yayBiZWZvcmUgc3RvcHBpbmcgdGhlIGVuZ2lu
ZQ0KPiA+DQo+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXNwZWVkL2FzcGVlZC12aWRlby5j
IHwgMzgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4NCg0K

