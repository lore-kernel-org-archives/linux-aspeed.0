Return-Path: <linux-aspeed+bounces-1789-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E8C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 08:19:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bn6VV44FCz3bh0;
	Wed, 23 Jul 2025 18:19:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753258754;
	cv=pass; b=SCobW45T/cN18y8maQuoQC4WG21KOYL1tlszJJzaEuxrplpH4r+hUX6+drZhoawEN0d1l5jlZRW4uOlLknNg0iGTBMWiT+65sJQTm7nOgOxYuZgGL36T2HOHnfiJG+yzJg2xHRa183jX62OmdEQPzVSotXCFFWCNZWo88XlnOSSMTj6Wxy7DCXlAVViBqgqAwg8G/CtuvvwWPL9e+J/2uvPgQsdoIdCctgOx4/esF0Ca4XY4RUANWHDQYXydOD1/DRamWerZs46q7Sfv5G3TVVA6b71AepCIlITZW5S6YYGYZwVd9ILjnFBNbLy0DFBC9jEDG0VDFw3tC4O64dMjdg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753258754; c=relaxed/relaxed;
	bh=hR4vyvMpKRQ6QHOQovnisC1nlOyKKGo8j8QzxuEmiUo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VizX6NwAiH8JKeRyka5CTGHrP6jQsg7SWSa5rTueyLff4vx7HFDcapOmpN7AmJVg6XeHoOLpHE458jzYobhbEm8ZqD9ffI7QkiVEcWySLPu7LFO4dXiQ/61PSsNRxFjsrmbe9YXUm4tWky6C7ALGuFPiPd8kaYTL/vlhVsk9zYtYmW+GSkKwBYvgHKEy8+Yx8o7cFMy4HsQoQ+Dwqfq1E8e7IzJoIOpbNWib5f+D4M6b/iYuK70nVnDZ+BMql7fM8zObkFI0tNp7l8m2ie12qI3Rga+c3KL80gBuMYvU3CScCRO7bOBRbjcrd97S0JWw4T9l0ibXsXjI9kAF0X20Jg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=MfyUoOmq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=MfyUoOmq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn6VT5Ltmz2yDk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 18:19:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIEVvu7RLjgzrAEGIKCRLDTcLsxQWDKO3xjX+bntV84V50mS5YwYs9MbWSt6nPI2NAKHHnR8VA+BIejf8GB+Wbsm90E+6aDGTIHqteOO9DAeNWswQj3Hmyr9H+I8JLkvWVN8Sm4EVAaHhOtw87N+IqplbvA9t63CdaKx7CAQ35leyqX9uX6spaexg4+mHF/2v9IRV2acbhjBTvJXr4g10NgZc6sRA9e2/jdDF5eLhzThSomqdXwTUJXw2DQJ6yoCu1vyj/58/kWyS7rfc7rjGKmLOsWwGTOMPgm0hAwGopKYGBmuoj2GhQ0GT3yXCcEj/qXMpna2FvPz8/jOPRpTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR4vyvMpKRQ6QHOQovnisC1nlOyKKGo8j8QzxuEmiUo=;
 b=fTuoxP17El3paRekOijZMSK5nScoBKoUsU0zAFWyik6zAWFBBUJz3ebLNhW0F42QMMQ0RHVq6qq/F7dCX1abH2wM+wresDRA4M4C+77+wCh+e4JKCxXAQ3SrjJgMGsdRdgY37vfrV2YXsH1cfMtGrHRrjttJaWLReedHpLM0b8GV3WKikKS4NZ8PLGtJRbMFC0yOmA21kp4J5RFWu0ZC0kTNGZVoKy0SFcBj/iIkQwDOmQH4qnm3qn+7iGyYqv03ljZbS7jitn+dGU08GQmsHv/yxZDUSPzLrcsnwLUn4qOR4uMN+rbhbEmcqtjuZ1R0sylR69RGV5Ul8Tghv0lOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR4vyvMpKRQ6QHOQovnisC1nlOyKKGo8j8QzxuEmiUo=;
 b=MfyUoOmqrg0i1EKjTvNvarp2DeDvoiimEnDnmo4AnjrzXOOuR3BypvWhAlyVPDYkWhOtaObtaKbQYa9piULpddRsfJLY/pr1XRz9I3R1GxGKNLgQKFVAWfm07dS9wZIX8D9FkFHY7Pl64FrB9/Qqz+XBMRxa5tTlgiKz/vMZmvtJbu5zo0QspQqHPHp3aoku9fFXA9zLMtvNzs3JYFDAuD5bpzRM7QoP0v+XKZ7a10e8Pq0CdGEYIT0NP8E98dfZzFyo+cwHQEjr3eUl/i/Y8Oy1GtPoAG1qGOsh4BfjxOzFCNPa1mQEyMoIdvy0dtCl7/yDcBButWIC0sP3RuM0Ig==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by JH0PR06MB7212.apcprd06.prod.outlook.com (2603:1096:990:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 08:18:46 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 08:18:46 +0000
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
Thread-Index: AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ/O3cAgAAieEA=
Date: Wed, 23 Jul 2025 08:18:46 +0000
Message-ID:
 <OS8PR06MB754125722911782DBB3CFEFCF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <a9294387-ce7f-482e-89e1-7c85feaeeee9@kernel.org>
In-Reply-To: <a9294387-ce7f-482e-89e1-7c85feaeeee9@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|JH0PR06MB7212:EE_
x-ms-office365-filtering-correlation-id: 025732e7-ac7a-4ef7-50a1-08ddc9c18b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Njh6VjhzVkI0aGxNK1pVR2oydlVQYS96ei9RNHdBN0JGaGYzRkpXSHZwcCth?=
 =?utf-8?B?bWU5NmNWUmtyTU91cW43WjhhY0dzd2tQOENrdEd5S0pVemJWZDVYTWlGdlll?=
 =?utf-8?B?ZVNNcGw4bThycU5teEt1RlVDOXN6cFM3RVEwZ0U0bmJIaE56UzEremlHNVZy?=
 =?utf-8?B?a2g0a3VNOGtVOE43LzlQRUhyVERGak1GaEFabU0ybUlsNkVqS3ZrZi9WZXZz?=
 =?utf-8?B?bVl2bEhDNzdMT1VRTDhMTmtQd3g3ZW1lRGk4OXpFQjJocldzcGpvVVloSUQz?=
 =?utf-8?B?NjFOeFVvUVJ1L2VYQXNoRnYxbnFkQkxYajkvVlQyNG40aWdXV0VsRkh1OENT?=
 =?utf-8?B?c1NRbE1BRGxudkdGTlZOY3NRZkNzSTdkNFVuTFVjWWdlM3V5M0s1MnE5UE5O?=
 =?utf-8?B?dk1taXVmeDFNbzdreTlWN1RkSERkbitCT0RlUEhONnc3ek9yU0tTT2hOTjNQ?=
 =?utf-8?B?TlVFNnR6TEQ0TVkvNCs5MGJMWmtsOHc2WHgrWGIxZyt3aDRtb09HenR6RXpU?=
 =?utf-8?B?b2FLWlZEZ09yNXFlSk5sT2I0SUMyTTJoRG1nVTJVVUgzaTlKeE9OMEN3VEV1?=
 =?utf-8?B?MmhSUXgxNk95L3BHYTJvUFVZOGhqOHUxV3JOeU1LRFJjSkh4S1FFSTlxbkxy?=
 =?utf-8?B?Qksxajh4cWNOMTFQcGFWbWo4ZjNsOUNBVUZFV0hQUm11VGFsUVdnb0RhVXlO?=
 =?utf-8?B?OU92NlVwV2xQeUpmMDQ5czNtUzI3dUU0Q2oyekk3bG1zbVhWWjZyV2Rxc2R0?=
 =?utf-8?B?L2VQVEpyMTJEdjVOYTI4c3p5NXhheTE2NnBFOFdsK1JDYVdzbFR2bHpZVlJj?=
 =?utf-8?B?cVhWbXFpZEUrNkF2YkdmbEpoNXpOU3BIcWFyb2g4RkNza2FTSGJzQzQybVBX?=
 =?utf-8?B?MElNYi8vK044cU5aaENWWTRLbVBxQ0RicHhtZ0Yxbm1VTjgybStMVnlmS2Zx?=
 =?utf-8?B?VFJVSDNCTTlPNllMclFjUjRhb3dTTThqc3dvYzdDU0htblJvU3d1MTloa1Jm?=
 =?utf-8?B?ZW55elhiZjFvUUlKcnhYd1JUbnlCT3g1NXRpM25VTkdOcXRyUGFjTVY2dE03?=
 =?utf-8?B?dTd5czdlMjNLQ0xnUm9pNXlEb0cwRzdLSEVyRWRhKzIwQUNKbis3dWZtWVNh?=
 =?utf-8?B?VGYxNlpWbENtRnMvU2djbURXUTBhcStnK1NrejEyYU9VSFYwZXFmRWFQYzlq?=
 =?utf-8?B?ZDhJMnZXd3dNN0NhclF4RTNqRlB1Q0pibVhYbjRBZ0Fkem5zNW5OOHl3WGR1?=
 =?utf-8?B?dFoyWnp4bmgrU3VJcndlVERxZmt6aWVaMU56ak9RVnNCZEFxN0xnK3lwTFgy?=
 =?utf-8?B?ZjhPc3V4cGxVUHY4YTlObmdkUW5jaFVGUDh3QzVodHVWNUU1QktxOHdsVWd1?=
 =?utf-8?B?VXdiWURscUFRdWd0Sm45NkNmRllOZmMxNGhEbnN2OThJQi9VbE5DYmtMMWNY?=
 =?utf-8?B?dEQwUm1mcXcxZG1NS2NNblkzYlNJVXpSbWVreWZlL0FXbFpRUjVUcFQ0RHRJ?=
 =?utf-8?B?QUpMVDN6NmJ1eGV6dnc0UGlEUHNLYjJJY2JoSko5SUxXWGdFMzVDby9XT3Vo?=
 =?utf-8?B?N3Y3STF3L1NvcTUxWWRTeXFyY0UxK3NYZEdFYlk3T2d3SU9Fak9QUkVldU50?=
 =?utf-8?B?NHh6KzRubmsvaXBNTXNuZks2eWVWaGYzc2tzQXN0VE9OMmVGUUM2Zi9nWVhy?=
 =?utf-8?B?bElTME5RNEdwdm10MkNOS2FGa2V3MnNvem40Yk9yMnJYZksrUVE3M25kZ0xq?=
 =?utf-8?B?cUFFLzMzUnF2cmJJNkFrdDVBMFEvWTlLNlpEM3FkQ3JQbmhsaTJZd09qb3NJ?=
 =?utf-8?B?ekV0OTlpNTJmYUpBbnJCb0FFY0N3N0Q5dVhWdy82YTNRT1E5YTE5UHM2ZE4v?=
 =?utf-8?B?OUtndXVEMXIrcHhqWVZiYVRqWmdFemRHNG0vL0Vwd0tLK1BseHJvRjE0S2VV?=
 =?utf-8?B?emZXOHFmUmc4RmYrem80TWw3am5hdXVCR1hIVXJqL1I1WU93ZHlnc0c3ejhl?=
 =?utf-8?Q?+M3INI0ytIXXBADjN+wef265t5BIa0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWZLQ2JjbmsrRW8yaFRxSHN5alJWRzRMNmxGalk3VGIvQ3RPOHNpYUFhcEI5?=
 =?utf-8?B?STZCV2tSSEIrN1ZVYll2WlVTVElQNFVNZ256YzFMY2lVZm1SY0VCTzhOcGR2?=
 =?utf-8?B?eXM4ZTBRVldoRm9Kd25vdkZrQmY3L0hlZlhpbXpCMS9JTUo2T3BkQnQyNUFx?=
 =?utf-8?B?V0tBZUY1VjVTcXlpbjR5RmRRSVVQUDM2M1lHRkljWTErNklDemJ0WTlwQjdO?=
 =?utf-8?B?cElvRFMvNlRmQ0JEU1l0Zll5Y2RLMXNUclBuRFVCSUd2MXhhNU5XN0JpdFA1?=
 =?utf-8?B?Yjh4aDNDYk5OOVVWVUcyT3FwWnZ0NVlSMk9paGJ3NUYzOEFBVkFLWnhERi9H?=
 =?utf-8?B?RnppWG5qUlJTVWFvaUtDd1ArVXQ2ZWN6UHgwRWpNbmZmd1FCNGZ6VFJHTzFz?=
 =?utf-8?B?cFBFVThGTnZjb3J0d1FSdUdWQkFyZGtPT3NWYXc2Wm1zNG1WTjh3VmNPNG02?=
 =?utf-8?B?YXoydXRmQXFqeUhkNHRIdTVWSDF1aFp1WmVvRUh1dFJvY0RtRnQydlpLbXpM?=
 =?utf-8?B?RFF1ZW9ZNktoWVhqNDk1a1lZdzVONU1TaGdDNGZjK3JadUF6QjlFZ25jb0N1?=
 =?utf-8?B?QjZ2SW04b0RIVEJLZGo3ZktLelI0c3o3QVhQRlFTMGVTZ1ljNWRuQ1lrTDZs?=
 =?utf-8?B?eGlIaHEvR1ZYTFVvWnd2QkFNTlJNblJoejR6TWJDQktYamR4K29sWU40YUNq?=
 =?utf-8?B?VjFJelJsNnpiUHBEcmo1cjB3WkFidks1U242THJ4UUFVL2FXNjRlM3owL244?=
 =?utf-8?B?Ti9NL2dTZjdjNUlDVWYzWXFROHB2TjhLQ3BVZDNRT1BSZ0lRQzByWThScjZZ?=
 =?utf-8?B?QUdOcDJuODl1UWExSzl4cklQUmVrNk5LcXBnZU45aW1BVmIrQkYxMXVkeFly?=
 =?utf-8?B?TUtiU1NpMFZSWEZiWnRuZy9iWGFraXl3dnNjc0JpekQxbXJocXlqSHJ1V0lO?=
 =?utf-8?B?bGdWLzU3RGZLNThGakFManFBNTI0c1dRQ214U1FtdHFFeTBseDNKV1ZsWGpq?=
 =?utf-8?B?VlZhTnVScjM5SGs2NVJkMHNsZkdvN3BVTXlSemlsS0JUeG9pUndRWGVsQmtO?=
 =?utf-8?B?Q1BBQjFFVG5XNnpYbWFHcHh3YVNqRGhYMVhrZlZnZklxTkRENnFlM0VJd0FK?=
 =?utf-8?B?SXBQZWNCczZEYzJzNS9VM2svNkxTQ0pYQ29RcUcyL2hMOXBIZk9DL28veWhv?=
 =?utf-8?B?cGd5cUhnbWMzRW9PTEVUU0tadDlsSUZQOUdML2FBdW9IcktBUFJTaUxnY3ND?=
 =?utf-8?B?dWpFYkxWSll2bmpxcElzRjZ2N2xpTTZzbTlaRVV2WDEwK1g3WXplbDlpMVNk?=
 =?utf-8?B?aHlGR29TT1ZsOTIwdjU0cFhIKzVVMExBZmszYVU4Nk1UWEVsUGU1dUdmTFps?=
 =?utf-8?B?SXJpTmZ4em5peHNBRnVuWDNpL2tDNnVjNmg2YUpNZW5HUHdrYlBoZS91VTli?=
 =?utf-8?B?MHZnNGI4V2RJclVWVjRnOHBWR005THNPeDlkbm5JTzhlL05MSzBSdm5jU0dw?=
 =?utf-8?B?elZjWGEvQ09FY0JMOWdRNGt3YXMwRno5dVN4SEJlZmdRdjJjdGVHRERTa3o2?=
 =?utf-8?B?TzBENDZhT1N1L1JsdzhrMzdPc3NaNExBK25MQnF4Nnl2TVFkbEFzNUJMeExG?=
 =?utf-8?B?blVhclk3b21BZng2aGdYcTZwSUtNV01Iakg0RkZGRUJRRWJOcDRRSmwxdTVB?=
 =?utf-8?B?K3NGbmxhZzJobFlNRHlDUDJMM1dtTlg3UVF0ODRWRGw4dDlFRHlFaTdjdHV1?=
 =?utf-8?B?a1RpMy9xcFovRCs3N2F1cmN6YjZSU2xtODFRVFpCcFdtTUl0UDlCY3hRUmtZ?=
 =?utf-8?B?NDM4TE43NHBxN2pZTzFzazJLZXc2WnRpOEFXM3hwZDk3Q2xEdjNCaHVXRWE1?=
 =?utf-8?B?Y1pzMGtSbDJqOXBLM2VMSGp5aHE2YXRXUWpnTm5JTnRwZHRyVlBKSjNQa3lC?=
 =?utf-8?B?TFMrWVZsellBaGZ2RzNpckV6QXhNTW12cFBwWXNhWVBNMFBZSEcwanlzNE1N?=
 =?utf-8?B?dVdORDkzTklTdzVTV2JwWEhQOVBIRkExNnhpcWZLZ3p4aEtRL1ZkekMrOFJu?=
 =?utf-8?B?RWJCWmJXWDJ1VXVmdzhJcHYvazhCczRCNmtQbEJEa3hyVGZTdlNoRFV4VFVs?=
 =?utf-8?Q?Zs17sdjBOKnJn05gGq4oav+wu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 025732e7-ac7a-4ef7-50a1-08ddc9c18b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 08:18:46.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnrTKFrulpXemF4Bvqnr9emnDbwiNJ8vapv24XZweeXiCZOYHv384xH28sgx8KRJtHedE8ksnvRapoG1wjnC6DObgK/a6emVYnj+JKZyx5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7212

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250
cm9sbGVyOiBhc3BlZWQ6IEFkZA0KPiBwYXJlbnQgbm9kZSBjb21wYXRpYmxlcyBhbmQgcmVmaW5l
IGRvY3VtZW50YXRpb24NCj4gDQo+IE9uIDIyLzA3LzIwMjUgMTE6NTEsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPiBUaGUgQVNUMjcwMCBTb0MgY29udGFpbnMgdHdvIGluZGVwZW5kZW50IHRvcC1sZXZl
bCBpbnRlcnJ1cHQNCj4gPiBjb250cm9sbGVycw0KPiA+IChJTlRDMCBhbmQgSU5UQzEpLCBlYWNo
IHJlc3BvbnNpYmxlIGZvciBoYW5kbGluZyBkaWZmZXJlbnQgcGVyaXBoZXJhbA0KPiA+IGdyb3Vw
cyBhbmQgb2NjdXB5aW5nIHNlcGFyYXRlIHJlZ2lzdGVyIHNwYWNlcy4gQWJvdmUgdGhlbSwgUFNQ
KENBMzUpDQo+ID4gR0lDIGNvbnRyb2xsZXIgYWN0cyBhcyB0aGUgcm9vdCBpbnRlcnJ1cHQgYWdn
cmVnYXRvci4gQWNjdXJhdGVseQ0KPiA+IGRlc2NyaWJpbmcgdGhpcyBoaWVyYXJjaGljYWwgaGFy
ZHdhcmUgc3RydWN0dXJlIGluIHRoZSBkZXZpY2UgdHJlZQ0KPiA+IHJlcXVpcmVzIGRpc3RpbmN0
IGNvbXBhdGlibGUgc3RyaW5ncyBmb3IgdGhlIHBhcmVudCBub2RlcyBvZiBJTlRDMCBhbmQgSU5U
QzEuDQo+ID4NCj4gPiAtIEFkZHMgJ2FzcGVlZCxhc3QyNzAwLWludGMwJyBhbmQgJ2FzcGVlZCxh
c3QyNzAwLWludGMxJyBjb21wYXRpYmxlDQo+ID4gc3RyaW5ncyBmb3IgcGFyZW50IGludGVycnVw
dCBjb250cm9sbGVyIG5vZGVzLiAoaW4gYWRkaXRpb24gdG8gdGhlDQo+ID4gZXhpc3RpbmcgJ2Fz
cGVlZCxhc3QyNzAwLWludGMtaWMnIGZvciBjaGlsZCBub2RlcykNCj4gDQo+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCBob3cgdGhpcyBzb2x2ZXMgeW91ciBwcm9ibGVtIGF0IGFsbC4gTG9vayBhdCBvbGQg
ZGlhZ3JhbSAtIGlzDQo+IGl0IGNvcnJlY3Q/IElmIG5vdCwgd2hhdCBtYWtlcyB5b3UgdGhpbmsg
dGhhdCBuZXcgZGlhZ3JhbSBpcyBjb3JyZWN0Pw0KPiANCj4gV2hhdCBpcyB0aGUgbWVhbmluZyBv
ZiBleGlzdGluZyBiaW5kaW5nIGFuZCBleGlzdGluZyBpbnRjLWljIGNvbXBhdGlibGU/DQo+IA0K
VGhlIG5ldyBwYXJlbnQgbm9kZXMgKGFzcGVlZCxhc3QyNzAwLWludGMwL2ludGMxKSBtYWtlIHRo
ZSBkZXZpY2UgdHJlZSBsYXlvdXQgbWF0Y2ggdGhlDQphY3R1YWwgaGFyZHdhcmUgc2VwYXJhdGlv
biBzaG93biBpbiB0aGUgU29DIGRhdGFzaGVldC4NClRoaXMgYWxsb3dzIHVzIHRvIHJlZ2lzdGVy
IHRoZSBmdWxsIHJlc291cmNlIHJlZ2lvbiwgYWxsb2NhdGUgcGxhdGZvcm0gcmVzb3VyY2VzIHBy
b3Blcmx5LA0KYW5kIGNsZWFubHkgZXh0ZW5kL2RlYnVnIGluIHRoZSBmdXR1cmUuDQoNClRoZSBw
cmV2aW91cyAiYXNwZWVkLGFzdDI3MDAtaW50Yy1pYyIgY29tcGF0aWJsZSBvbmx5IGRlc2NyaWJl
cyB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgaW5zdGFuY2UsDQpub3QgdGhlIGZ1bGwgcmVnaXN0
ZXIgYmxvY2suIEluIHByYWN0aWNlLCB3aXRoIG9ubHkgYSBzaW5nbGUgY2hpbGQgbm9kZSwgdGhl
cmUgaXMgbm8gd2F5IHRvOg0KbWFwIGFuZCBtYW5hZ2UgdGhlIGVudGlyZSBhZGRyZXNzIHNwYWNl
IGZvciBlYWNoIElOVEMgYmxvY2sgKDB4MTIxMDAwMDAgYW5kIDB4MTRjMTgwMDApLA0Kb3IgY2xl
YW5seSBleHBvc2UgZGVidWcgZmVhdHVyZXMgdGhhdCBtdXN0IGFjY2VzcyByb3V0aW5nL3Byb3Rl
Y3Rpb24gcmVnaXN0ZXJzIG91dHNpZGUgdGhlIGludGMtaWMgcmFuZ2UuDQoNClRoZSBvbGQgZGlh
Z3JhbSB3YXMgaW5jb21wbGV0ZSwgc2luY2UgaXQgaW1wbGllZCB0aGF0IHRoZSBpbnRlcnJ1cHQg
Y29udHJvbGxlciBibG9jayBoYWQgb25seSB0aGUgaW50Yy1pYyBpbnN0YW5jZSwNCmJ1dCBpbiBo
YXJkd2FyZSBlYWNoIElOVEMgcmVnaW9uIGNvbnRhaW5zIG11bHRpcGxlIGZ1bmN0aW9ucyBhbmQg
cmVnaXN0ZXIgcmFuZ2VzLg0KDQpUaGlzIGJpbmRpbmcgY2hhbmdlIGlzIG1haW5seSBmb3IgY2xh
cml0eSBhbmQgY29ycmVjdG5lc3MsIGFsaWduaW5nIERUIGFuZCBkcml2ZXIgd2l0aCB0aGUgcmVh
bCBTb0MgcmVnaXN0ZXIgbWFwDQphbmQgZnV0dXJlLXByb29maW5nIGZvciBkZWJ1Zy9tYWludGVu
YW5jZS4NCj4gDQo+ID4gLSBDbGFyaWZpZXMgdGhlIHJlbGF0aW9uc2hpcCBhbmQgZnVuY3Rpb24g
b2YgSU5UQzAgcGFyZW50DQo+ID4gIChpbnRjMF8wfng6IGNoaWxkKSwgSU5UQzEgcGFyZW50IChp
bnRjMV8wfng6IGNoaWxkKSwgYW5kIHRoZSBHSUMgIGluDQo+ID4gdGhlIGRvY3VtZW50YXRpb24u
DQo+ID4gLSBVcGRhdGVzIGJsb2NrIGRpYWdyYW1zIGFuZCBkZXZpY2UgdHJlZSBleGFtcGxlcyB0
byBpbGx1c3RyYXRlICB0aGUNCj4gPiBoaWVyYXJjaHkgYW5kIGNvbXBhdGlibGUgdXNhZ2UuDQo+
ID4gLSBSZWZpbmVzIGRvY3VtZW50YXRpb24gYW5kIGV4YW1wbGUgZm9ybWF0dGluZy4NCj4gPg0K
PiA+IFRoaXMgY2hhbmdlIGFsbG93cyB0aGUgZGV2aWNlIHRyZWUgYW5kIGRyaXZlciB0byBkaXN0
aW5ndWlzaCBiZXR3ZWVuDQo+ID4gcGFyZW50ICh0b3AtbGV2ZWwpIGFuZCBjaGlsZCAoZ3JvdXAp
IGludGVycnVwdCBjb250cm9sbGVyIG5vZGVzLA0KPiA+IGVuYWJsaW5nIG1vcmUgcHJlY2lzZSBk
cml2ZXIgbWF0Y2hpbmcgU09DIHJlZ2lzdGVyIHNwYWNlIGFsbG9jYXRpb24uDQo+IA0KPiBBbmQg
aG93IGl0IHdhcyBub3QgcG9zc2libGUgYmVmb3JlPyBUaGF0J3MgcG9vciBhcmd1bWVudCBlc3Bl
Y2lhbGx5IHRoYXQgRFQNCj4gZG9lcyBub3QgaGF2ZSB0byBldmVyIGRpc3Rpbmd1aXNoIHRoYXQu
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

