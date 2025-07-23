Return-Path: <linux-aspeed+bounces-1788-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65669C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 08:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bn6GS6c4Bz3bh0;
	Wed, 23 Jul 2025 18:08:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753258128;
	cv=pass; b=n9C8TE0OmEDxbfN6EjEa3UQptG4EYdlSXEM45auS3Cr7vZnRQfOzIAXbgrTvlCOFdWlvZv82A9HyA6OUtbSVgsVgyfGSJKC0gOfqRajUtOxcJJUoQjMN7gjGyqaQGgAPlPyNPI44ocbXxklxpGLJU0GAa573CPnbuQMdMrkM4tU75vZAvb8yNV9zzdqlOCeuid/NicJKJnVrMJ4fHAxcJTsp10n99D1g98HCgg3pHpBuUEeZhokjR3I32LWpc0Q1Hsj2DM/6gXNFBiixDCy94l3vbG7UCPG0al3RgmkYvxIxWiMQ3aSvCT4iYGVxhVq8IuMDgtY7g+wMMCDKNrGOOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753258128; c=relaxed/relaxed;
	bh=j2RHbX5dJ7fdrrFQvlgt2fnVX9jMLMH9CJuBTcxC2ro=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PM4sVOwOnSVCBQo7YNb5f7pl3GlARnKHze3uryW6c53ub7vvkivBUquQw2HOnk+JigPnOan/MBakwClFRaNZRpEHeJxstWuVIl8S3gyzaIy5HDjbBT9oiFYRzn4bhgLKfJumsqR1CyLhTvMSb0fb/VBo1BWsvhokZwybPyTGrPT8gc1s9VvcM/EAko9FQLS76F4XgJurdkot9xEGylGgMKCcAvf4bDayDngysA0znumtHszY1EOiYNiTSi7GzpFhnA2osH8bIN8XAnRrBXyKQ2ZEI8JEB39xd9Glh8rUHHBQdmnc7oRjANfjPo48qZyf3dlz3MbPS5W6WoMplrmBZw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=Lbw4KAhL; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=Lbw4KAhL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn6GS2Hvqz2yDk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 18:08:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/28xRej4BWNcSRdMrFL0W9nTernOhvfqtncms4yJg1YpWqeCxQzyeCHSnrUs0fciIo4WmLS2udG4MTW+CNvs1gZr2LA3z7FQ10XwDE+DYydlSysuXiNadT4RjQC3p10PRUQfXx3q6snv9ACgQp4+zJIN+olZ/REiEh0W/GXDo/r071O5A4P9T8zl1huayW5GgCmUQqI7xylXd+Jqabv3w84hEMrYdROfDEynWlyD3Dc4rpcYK6dhegKV71HxQw68KdYFluP/I5m7iBd3U+RkObwTJ+q1t3uv0Lwqavg6wyOeGYPEV82XyCVGbf45Wz5RT01gA96etU5Q0s0BD6fvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2RHbX5dJ7fdrrFQvlgt2fnVX9jMLMH9CJuBTcxC2ro=;
 b=ZgvQm/CV5vX6d7kVcRNjC+vTFrY8/h5JsW0mnwHTOiPwcO9D7aeHm8sgAhWqTRnl8Wg2REAih7buuMJF3ZrThr/GtvMfY4YxXaHQjeQ4RGz26U4mNPUMfXjXRWFX/pYDR0q+8xhrabdQYUvVJgBGQev1Ux7oteCF0COmFnODTe3T3x6IecZSYJPm6V/V5joQNoeeiIFa4ozF4ID2M/X0NihMhLkQJpokIfjEeeaaSHoUmRPsBkJ3PU2kBYBf0Ac+/zR/yMjfOD9gEnqMT6T5oaAsq5uPuFSYsQlmUnwOIM27xWu+dQq7Zr9OgCchyAZd2sRLa9MIFOC/4NH8DvvnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2RHbX5dJ7fdrrFQvlgt2fnVX9jMLMH9CJuBTcxC2ro=;
 b=Lbw4KAhLOg/m8ZEQ7yccPQzcmuQZTHnzeweniJFZr8NhRvlsl4sgHyJzOSuNvS/2Nkx7+1um1sQzox3mTdwFLNnBQVEZUT6lmT19DHs/YhJO302Wa+8ilh+/Qhxs3KB6GM+R5w2fGhfDu7Llew+PJDvftd1LLO+SIt281pOdZq8g6iY1ru3Sh8mb2/dyZgJaBIM8hihC04Gmd/bf/JptFp7VAS/YWGMUAgYUMoshdMvCU0bZ83YSZ2E2B+ZN2ARd1rZGw3Jrap3VC/L3QxOhLTb3x13I9qHbSaYlgxPIZLj2QzpNcT/cA4fkVyZdA0c0J3jKHgyrSRVOQYZeR1cIYg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB7144.apcprd06.prod.outlook.com (2603:1096:405:b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 08:08:22 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 08:08:22 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Index: AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ/O9gAgAAebjA=
Date: Wed, 23 Jul 2025 08:08:22 +0000
Message-ID:
 <OS8PR06MB7541F8D3AEE1A618DB31F07BF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <001d37c7-f704-4554-a4db-0cc130e07dd6@kernel.org>
In-Reply-To: <001d37c7-f704-4554-a4db-0cc130e07dd6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB7144:EE_
x-ms-office365-filtering-correlation-id: 1667cdda-3b08-434a-0255-08ddc9c017a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0RQa3k3T1NDaE50T2ZnNDFBVW5ZS1AzdTVYNWROdzVXMHlXMEx5ZzgxK2Iw?=
 =?utf-8?B?bi9EVjZpdVRlZGhCTTV0TytuaUZGWlE0YzlyaHN5c00yZWp5VmtKKysraHor?=
 =?utf-8?B?RDF3dENiTitSakM0Nyt6TFFHV05rOXZxdkFkR0Z1ZUcvSnV6OXdxQkp2d2Jx?=
 =?utf-8?B?bHhRUXk5dFc2dEhISzB4d2FRdjJNZkQxQU1BK0pFVEUvQVN0eG5vZEpJdEt5?=
 =?utf-8?B?VGR0MUdrU0Q2a2M0OGs1a1ZVTFZVNnV6dmpGMVliMGhUYzdBOGx5KzBaQmgv?=
 =?utf-8?B?RHhSS0tWQjQ4QXF6OTFuZzcvajhVWFlJN2MvbFRCL0tvLzJIYlgySVBHY1Vq?=
 =?utf-8?B?d1NwWFZlWHVFZTI2clJjSE5zdUl3UnBYK2JvVGx3OHpJcC9zT3ZPR25XSWRY?=
 =?utf-8?B?R0FGeWNBa0FpbUNMSTU3T2ZyRG9YSUIvckVPWGFURE5xRVZSY2lUTGpSRFZs?=
 =?utf-8?B?QmFQWnFvaW4rR0pTVHhXcXg0dGovVGtEQ0YrdDJqUVFkZkZodDNtUVhkWjdO?=
 =?utf-8?B?UUFOSE9NemQ3d1RWVy8vWVlFZEJxZzBFUmVjK2h1M2IzMW4xZE9rVXBYMS9r?=
 =?utf-8?B?MlE2SEczSjc3OUhmV0t0RVlLMzZYWDhlNHA5OStZSDltc2U4TzU4Tmw4bWp6?=
 =?utf-8?B?dXpseGpYZXVPemIrcXoxaWJXeEFUMnhlNlpvNXFScG45SWZLdFVoNXE1clJj?=
 =?utf-8?B?VFMwM0c1MitMQ0Myay9lRDlCYko3TzJTYmVmaXNHZXRQU04xVExMWEloa05G?=
 =?utf-8?B?eUNpNkludnZvdDJCTkRjTldNQS95YVhPRVVBMEhPaXM2cTlJRWJSUzJtdk42?=
 =?utf-8?B?N3V0d0YxYzhsdk1YZ2JEWVFiTVhERjQ5NGEySVJPVmF3RE5NYTVKMDFzY3Zj?=
 =?utf-8?B?YXVOZ1pWTlQrL2dIbUxCY3NxREN5MkI3cDFYalpDRE9WazlmMnNZcVpRTVVB?=
 =?utf-8?B?OHBnMzFjcURLeXVza0RPR1AyamZaNWFoSysrVkhPYUpPVENxUVRidVVhUnoy?=
 =?utf-8?B?K3NtSyt4YWozMFo3Yysra0F1a2FBNGJ1cHBsUWpjdVUzQlRzQ3I0NFVmWkNZ?=
 =?utf-8?B?dVFwZnE4RVdteWg1L3p5ZGxyRkpOblZ6UkFQZnVKMnR4RDFtMytsMEtFemsx?=
 =?utf-8?B?YlBxekFYdjdsMnlhVHZtYnVUcXJwbWdma2V1NWlSbk0xSmFBUS9aemtURHJP?=
 =?utf-8?B?dHhFMHp4TUIzd0I4VkI4cHVsU2dNS3Z5Z0xjcUtTNnVyVXZiYjZzM2xBT1hG?=
 =?utf-8?B?M1BuTjJ4cFNoWmlrRTAyQnR0MW0zenVIWGZXYWVIcnY2M080Z1ZVYlBwaG0w?=
 =?utf-8?B?bUpTem5UWnhOZlM1Y2h1eFJGaUQxMmQzWjhmWFBUTlA2NXVSRVZZdTlsd2pZ?=
 =?utf-8?B?ZmVJaVNXMktRekFkYWJ6Zmd1WTM0a3YrRHl1TXpaKzgrM2FGR3JDSHpzTlZq?=
 =?utf-8?B?aEEwL2tLdll2bGpnMDhoTUdob3Q1eWFjZVJpc2luQm5hekUwNm1Lc2JkdFFy?=
 =?utf-8?B?cGFabGdmZGF4K05CWGR5OG04QVNMQ1RNV0NVUStMTVFJSWpuamgybEMydkFt?=
 =?utf-8?B?ZmFGb2lkdmEyV2xxOWNORWRwSTE1eE9rYzZIUEt1eWxQd1Q0a2ZhUmVURnJ4?=
 =?utf-8?B?RHlOamp6NUNNR1J4NlZydnVCY0JOU05iQU56SWtLOXFCQU5GNjFKMHN4QnZp?=
 =?utf-8?B?V2RPN25KVkpmUnJHM2g5Wm5ieXJsaG9USmxEK1ltNnhTN2dTSWVNVzFZZFQ5?=
 =?utf-8?B?dUNwQmhnRjFGaVBZdTRCNFdOSzFlSzdzOXI0ei82eTI3S0M0eTEzdmVWZTBO?=
 =?utf-8?B?YmtmeWhpUytvK2FMQUhjQnBGY2VOQ1orZStwK0w5aVJCUXVhZ2l1MFJyMWRU?=
 =?utf-8?B?WUQ4ZmZlaWJpV0I2MU1iZHNoWStWcWJPMnUwK0p0dEdJWFFwMWFrQUpNaXRB?=
 =?utf-8?B?RjRpTTR5YWhiKzVXMG1pV0NxMWM4SER2T0NNdWorZDV6Qko3b1I1UHNMcTAv?=
 =?utf-8?Q?9TXaqYIWskqS30UsVLZgvliUcH6KM4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUwrbTNjdGg5bVVpQlhaUG16VmFVMmVmaGNsR3QrYUEzU2pwTDBkak9PQlds?=
 =?utf-8?B?Uy8wamRKRHBnZGRpY2d0QWN0M3B3WlVKS0JOTHV0WjRrekFPbEN1Q0Q2QU1G?=
 =?utf-8?B?NHdMK2xvaEQvVjhWK3BKR3lkUzVEMXVGVzNyNG1DeWtUWm5WelRzLy9HaEF5?=
 =?utf-8?B?ZFRLY0YxbVZCbXJ1WUtUZjB1UFREK3hCV1gvYzBia3kvQTRaRHc4R0lkK0xW?=
 =?utf-8?B?RFpucURRaXAzU0hlUmc3UkJLMlQ3dWFIZXNvNGI0bzkxaVR4aFJoMzNOcHVm?=
 =?utf-8?B?Y0pmbVl1cUxGcEtrM1p3QVQyd3pEZmV5VVg1WFRQS00za29IY2lPR0JFMGxv?=
 =?utf-8?B?SWVWUTU2RUI5cTVnQnNIV1R5Ky95YlVkWnN3R2lxWG9Ycm0rQm5NbTQ2Rk5E?=
 =?utf-8?B?VThQcVlzRk9wZ0RjYWc0dXFDbVVVeXQyNWJYKy9FRVVXQTBiNVlSM1QvdGk2?=
 =?utf-8?B?Q1JLcWVBUkJBWHByYWw0YjFCOXJJaHhoWFFmbFpHL09POVc2bG56ZVZFWmZz?=
 =?utf-8?B?aDJram9kWDdoU1RMc3dKaWhIOUlkaTdObjZPR2ljb0lyaXpjUTdhZS9Yd0Jx?=
 =?utf-8?B?T3dmNDZvandQRGk5WHd4UzA0cHBWOTVqdzVqeHNISFdxZlZLNE1YMXZDWWY0?=
 =?utf-8?B?ZWtDaUQyQk10R2Q3REtSM0FGd3YxTW5jb1U1ejc3UjZXdzIvakFoREIyWmx5?=
 =?utf-8?B?cGxnWnBqMVNIWm56ZldMcW5aZXhxTGZKWkh3V1VwYWdKdFhsOVozY3VwUURO?=
 =?utf-8?B?czY4eFJMSnpyMjA4dXhoRmpGNjNuY0FsTnI0VWlTVC9xbXFzQzA0ajBRTmVn?=
 =?utf-8?B?cDlFWUJFUjIrK1o5SWowSFU0TWhpT2I2bnc4MFlPVTQrcG1GZUdGNEpBNERE?=
 =?utf-8?B?QjhiKzJ4K2dFQ0ordlVmQWhPbzhROEtNUGNUOFpCcFhJTm0yTEN6SWhvcTAy?=
 =?utf-8?B?amhxM2RQUm8ySnRBTExsOFhyb0xFc2p3dEUrM05ON3RGVWdJR0tuNWt3eVRM?=
 =?utf-8?B?bUZrL1B0OVh6Wm5YUjczMFpHMEZjdHpLcXV5QkE2SExQNElPQlc3Q2Yxd3J4?=
 =?utf-8?B?bWVNS2ptMVZHQ1RvbVZ5MEtmYVRpazhLSnhiaUVXbHRtNGJLQWVzcXFKL2Fv?=
 =?utf-8?B?SEQ3UGZIeEVKSDZkTDFRMllERHNnUU5UNmNuM1FUcUxkVEhtZWxVNzJDV3Iz?=
 =?utf-8?B?ZXhFU1VET1ZoYVpTaTg2MjVZemoxSVRVLzc2UmpCdEFqL3lhb2x0V3BhMnVi?=
 =?utf-8?B?ejlqenJIN21zTmVXcmc3dHBDL21FSEN2QUpNbkptME1hY0V1Z3NEMkhoVGxJ?=
 =?utf-8?B?S2J0LzRVajg5aFN2K2JybUt0ZzV6NGduLzN3RkFaaE5XaUN3ZTMxTGdFVTlG?=
 =?utf-8?B?ajFNbDNiWm84VGdlMjFMUENqaFQ5NHFwaEhWSGIxK1EvZEh2UkVhcjNSYVhS?=
 =?utf-8?B?bkVNc2JoTGEvN2VqU3M5aTRjM1RvMzBmdWVOdS95UUlvR200UXRhc0cyTktn?=
 =?utf-8?B?bjF1WFhiM1hYNnN4VlZrZHZzd1VSUGQ5WEJ5QzVZT3liWDd5VFhMLzh1Vi8v?=
 =?utf-8?B?WE5hdVdnOGd3MDRyZzZzTlM5SXllRk16cTlDb2pKejlCS0xzNkJsOXNhMFIx?=
 =?utf-8?B?WU0vWENGZnZWMURaUDY1b0c1bDlBMVVOL2NNN0tpUHVLblhERDZVRU4wMHZ5?=
 =?utf-8?B?RXZ0TDM1TWlYT3pPTGUyeGtUNkJYVHhVc2hhb3lNcjYvTEJGVTc0Y2k3aHpE?=
 =?utf-8?B?amZHQnBBM0hYNlVGaGl6NXFDZXU0Q2cvM0xpNWo1Vk9MYWh2UmE0c2t0Z0gw?=
 =?utf-8?B?MjlLdXRGUEJEcDBqMXBJZS9VK2NVREgwNUVKb3pZaUFkeEc1V0pWOFNPTm51?=
 =?utf-8?B?QkJQZmtnZ2U4aXVBZjJtYUo0Y1Q4MzB4ekdZSE81bHU1SDc5N1BhZXFDTkxX?=
 =?utf-8?B?bzYyR3hOVlIzcjhsdkNHSDVhd2haQ1BmR3lPbDBvdUg0ZXlTV1NGMHdndzRH?=
 =?utf-8?B?ZXVDeVMrNGYzbERQT09zUmlSbWxoTG0yZ3RZQXFVN3V6Lyszcmk5d3NFdEtj?=
 =?utf-8?B?M05iNXU5UmNubmVaNTdnVXBEcXJMZ200d1FnQU55bndFeGFuK2RsVWZ2L1pR?=
 =?utf-8?Q?365i21g9oK4Xzoco2lwyLCxN7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667cdda-3b08-434a-0255-08ddc9c017a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 08:08:22.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THDxlwcw+oaRAotSuDd+9b2ELOwhy7QOxE9AeOkDhwNVu59A0gp9GKsEncH3+tNdWhKcf5rtLJ1zvvldCWDwd5Z98+8QiV+vhE/Bej9FVJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7144

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250
cm9sbGVyOiBhc3BlZWQ6IEFkZA0KPiBwYXJlbnQgbm9kZSBjb21wYXRpYmxlcyBhbmQgcmVmaW5l
IGRvY3VtZW50YXRpb24NCj4gDQo+IE9uIDIyLzA3LzIwMjUgMTE6NTEsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPiArICBJTlRDMCBpcyB1c2VkIHRvIGFzc2VydCBHSUMgaWYgaW50ZXJydXB0IGluIElO
VEMxIGFzc2VydGVkLg0KPiA+ICsgIElOVEMxIGlzIHVzZWQgdG8gYXNzZXJ0IElOVEMwIGlmIGlu
dGVycnVwdCBvZiBtb2R1bGVzIGFzc2VydGVkLg0KPiA+ICsgICstLS0tLSsgICArLS0tLS0tLS0t
Kw0KPiA+ICsgIHwgR0lDIHwtLS18ICBJTlRDMCAgfA0KPiA+ICsgICstLS0tLSsgICArLS0tLS0t
LS0tKw0KPiA+ICsgICAgICAgICAgICArLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICB8ICAg
ICAgICAgfC0tLW1vZHVsZTANCj4gPiArICAgICAgICAgICAgfCBJTlRDMF8wIHwtLS1tb2R1bGUx
DQo+ID4gKyAgICAgICAgICAgIHwgICAgICAgICB8LS0tLi4uDQo+ID4gKyAgICAgICAgICAgICst
LS0tLS0tLS0rLS0tbW9kdWxlMzENCj4gPiArICAgICAgICAgICAgfC0tLS4uLi4gIHwNCj4gPiAr
ICAgICAgICAgICAgKy0tLS0tLS0tLSsNCj4gPiArICAgICAgICAgICAgfCAgICAgICAgIHwgICAg
ICstLS0tLS0tLS0rDQo+ID4gKyAgICAgICAgICAgIHwgSU5UQzBfMTF8ICstLS18IElOVEMxICAg
fA0KPiA+ICsgICAgICAgICAgICB8ICAgICAgICAgfCAgICAgKy0tLS0tLS0tLSsNCj4gPiArICAg
ICAgICAgICAgKy0tLS0tLS0tLSsgICAgICstLS0tLS0tLS0rLS0tbW9kdWxlMA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCBJTlRDMV8wIHwtLS1tb2R1bGUxDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgfC0tLS4uLg0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLSstLS1tb2R1bGUzMQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLi4uDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
LS0tLS0tLS0tKy0tLW1vZHVsZTANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
SU5UQzFfNSB8LS0tbW9kdWxlMQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICAgIHwtLS0uLi4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICstLS0tLS0t
LS0rLS0tbW9kdWxlMzENCj4gDQo+IFlvdSBiaW5kaW5nIGFsc28gc2FpZCBpbnRjMSBpcyB0aGUg
cGFyZW50IG9mIGludGMtaWMsIHNvIHdoZXJlIGlzIGhlcmUgaW50Yy1pYz8NCj4gDQo+IFRoaXMg
ZGlhZ3JhbSBhbmQgbmV3IGJpbmRpbmcgZG8gbm90IG1hdGNoIGF0IGFsbC4NCg0KVGhlIGNvcnJl
c3BvbmRlZCBjb21wYXRpYmxlIGlzIGZvbGxvd2luZy4NCg0KICArLS0tLS0rICAgKy0tLS0tLS0t
LSsNCiAgfCBHSUMgfC0tLXwgIElOVEMwICB8IC0+IChwYXJlbnQgOiBhc3BlZWQsYXN0MjcwMC1p
bnRjMCkNCiAgKy0tLS0tKyAgICstLS0tLS0tLS0rDQogICAgICAgICAgICArLS0tLS0tLS0tKw0K
ICAgICAgICAgICAgfCAgICAgICAgfC0tLW1vZHVsZTANCiAgICAgICAgICAgIHwgSU5UQzBfMCB8
LS0tbW9kdWxlMQ0KCQkJKGNoaWxkIDogYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykNCiAgICAgICAg
ICAgIHwgICAgICAgIHwtLS0uLi4NCiAgICAgICAgICAgICstLS0tLS0tLS0rLS0tbW9kdWxlMzEN
CiAgICAgICAgICAgIHwtLS0uLi4uICB8DQogICAgICAgICAgICArLS0tLS0tLS0tKw0KICAgICAg
ICAgICAgfCAgICAgICAgIHwgICAgCQkJCQkgKy0tLS0tLS0tLSsNCiAgICAgICAgICAgIHwgSU5U
QzBfMTEgfCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQl8IElOVEMxICAgfCAgLT4gLT4g
KHBhcmVudCA6IGFzcGVlZCxhc3QyNzAwLWludGMxKQ0KCQkJKGNoaWxkIDogYXNwZWVkLGFzdDI3
MDAtaW50Yy1pYykNCiAgICAgICAgICAgIHwgICAgICAgICB8ICAgICAJCQkJCSstLS0tLS0tLS0r
DQogICAgICAgICAgICArLS0tLS0tLS0tKyAgICAgCQkJCQkrLS0tLS0tLS0gIC0rLS0tbW9kdWxl
MA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIAkJCQl8IElOVEMxXzAgfCAtLT4gKGNoaWxk
IDogYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAJ
CQkJfCAgICAgICAgfC0tLS4uLg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIAkJCQkrLS0t
LS0tLS0tICArLS0tbW9kdWxlMzENCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAJCQkJLi4u
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgCQkJCSstLS0tLS0tLS0gICstLS1tb2R1bGUw
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgCQkJCXwgSU5UQzFfNSB8IC0tPiAoKGNoaWxk
IDogYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
CQkJCXwgICAgICAgIHwtLS0uLi4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAJCQkJKy0t
LS0tLS0tLSAgKy0tLW1vZHVsZTMxDQoNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0K

