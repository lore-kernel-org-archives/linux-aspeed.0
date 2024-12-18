Return-Path: <linux-aspeed+bounces-274-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9EBE77184
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 02:51:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCdVt3zzmz306x;
	Wed, 18 Dec 2024 13:51:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734490310;
	cv=pass; b=WtPVekRQsrY+JQ2OaMwxVYP1aR9981wUuZz+HZ6H6ZxmhJ97NYYEkw+XLvI0umjRTrvz1wPSLPB9iaDTkY8TD5ZKpsAsijVLpnuX26cW4qT/89J5/iJOyGCpLH791XSugBGOM1jF9RtGUIKqbt8WJSSjsvkjzUi6xEzuKBGHfEZSRSxVzezHz3KDAkW5iv/Jr5ydfVk0i6FiZohxOxijTWeHpESIbLTJfZk75w5FQCFug3GYeNt7iYOsGkXh5/FZr0Tz28gdjrOqhTwFfhSGnOYI2cS7i3FY9dpN8Z/r5nv/kYIfW6cvnVdS947/tY4YBMwfT8P4AZQBm3SFPbyvJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734490310; c=relaxed/relaxed;
	bh=fpM+sa8QCCp13xOEkDRQwnaWLR0KTrNpVU2NzXsSnxc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GVsL0HT3wn0jEY94UVyyaC4AgYcFb3vXziFQ6+A5VxkrIGDrCkE25NoZFerZORJP5pafXG5naaeJ41mJtPYPf5afuiPRJMxzlH7TexlnHRgYb1YDXjVdavzyeICPv8s9AHvZho5fNhIrP54ismMYex4BcPFpzHP9BUtCH37RgR4ONShwtffWk4HpDkwgJhdoPHMvS+11vDCjZMnRVh+05kwWtI726jwgX2KYgRkBn9/TLEEVbVb9XTH8+ZX9eQaRjvb/SSUEJmcrLT/DnRL1A6blIuin/AD+cfoCbTHTQ4lIfDc5v/iaxwNTGCe3rgCPzYzVr41BhgPLe5hmMeajXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCdVJ70Fmz3064
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 13:51:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV320y1CjL2w6Vjzum5pf1Uo+/g1aFWwYM6/q5NDzxPPlqXyJCjlD84D96pGPYPnlwN6JQkE+TaQlnttHqCHsRY1iL9pvMnrRRfEx0pXm7erGUmk9kBk/cjC4VyQ2MlJnIf7JJsL/gTWP8kyCZY+7iKSGMPGK8ZuHvugSJWdigF/ls8ucoPGHHYcjow5/HLey2yuZPuY+PFZGF82U2bj/jTShGL7ULIhl4YxXiNauAih35PM4q4MC4dPs+z9ugJulrP1Are+Z+e/Y4ynHTXwMrTPFMKHqG9DA1SpX8r1rpx0Y8jELgVnXpGEXS2Z0htsX1T17lAUCHt9mRoIRqdtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpM+sa8QCCp13xOEkDRQwnaWLR0KTrNpVU2NzXsSnxc=;
 b=vzMvKv32Llyq/Fb6jy1CYdqCLSuw8CaTbMfOfZyL979LwnAl0p1073LKYyo1msMR6fJPVkp1AXLSS4JGU2j88Kq07SNK0RVr1/3pV0UB5/5VxD3m8vXePudiSI8PWtv3O8V9xHi/7BhpwMILAyiu3mfY20o9CBdgf+1hn8Eibn9vq8JxNV9JDAz0iVinmpZNe8/OvcJsJmiCqaYylv8+IqpA7hZmpuwqKj6Us4KlAjjwW1bMVukRznj5ECI1hGm+P2p/AF3BwnmYUMWOkJVmDxaOXZTQTEz17y1pO+Yo6JdjxlLVlCcOZgAfT5hKkRSOWC9MALPsD4MhXInbDMHLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpM+sa8QCCp13xOEkDRQwnaWLR0KTrNpVU2NzXsSnxc=;
 b=Fn2sPZXgNfe5kaHt13LMmxFReFbDkJRlesd9sfuavpfHjJvHc3QNAIsKYaqq89odiW4ZSPSuvq02WZoXsg/fe8rBR9pNYRfhRYvoDc4xZDaWzVqWvhyUnFzs5Lhc4kCfjNE7UOSrzEqjai6xrhBqR2z8gdjKDGVlDSJRlBccdm9IdZxbPopnY50SFSWaaKSWtRiEALQ6iKht1PGMWS8BQE1VizXspCS5AS9m7LLwl4imVjIEtDdnzcJ4RVJuAUztTNri/vszXEnic1r/iibPs8ENLCXyfQ7mtlA7LK3LedjNtlZE16HtcuzCTZo8SD626nKIeVWgS+NWChzAfh/Fzw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by JH0PR06MB6835.apcprd06.prod.outlook.com (2603:1096:990:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 02:50:35 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 02:50:35 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"konradybcio@kernel.org" <konradybcio@kernel.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: [PATCH v3 4/6] arm64: dts: aspeed: Add initial AST27XX device
 tree
Thread-Topic: [PATCH v3 4/6] arm64: dts: aspeed: Add initial AST27XX device
 tree
Thread-Index: AQHbTK3m0tEu001bPUaVouY7UtZn2bLj0SYAgAeD0JA=
Date: Wed, 18 Dec 2024 02:50:34 +0000
Message-ID:
 <PSAPR06MB49496308CDFF36C38EFEAFAD89052@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-7-kevin_chen@aspeedtech.com>
 <dbfe7c42-cc9b-4471-93ed-846260db42e6@kernel.org>
In-Reply-To: <dbfe7c42-cc9b-4471-93ed-846260db42e6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|JH0PR06MB6835:EE_
x-ms-office365-filtering-correlation-id: 7ac4bc51-ab7d-49ec-07f9-08dd1f0ebef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjZrQkcxUWhLZWE4UFVjYWpDUHhzM1hDcFRIZlZhY25VR05OWENRNlJucnRv?=
 =?utf-8?B?ZTNOVDg2YVpoY3pkSEp1ckswdU5MUld0L3VuM2lZZDZ6WTZRVnZSNXE4Zmhq?=
 =?utf-8?B?alJLelBxb0h1Z2wvQ0hNTVZ1aExWbFQzcFlnNVJmc29PYlR1TjRaWkhJekly?=
 =?utf-8?B?ZHM3aXVIMGZrOG1ZRFl0ODBNZ0Q2ekp5NWg0Vk4zdmh1V0djZHBuUEVIZjNX?=
 =?utf-8?B?WHJmMnB0WXVvb0tXMzZjZUhYZWY2eTVqZi9WZDVPVUlLT3hzWi80VnlhMTdW?=
 =?utf-8?B?NGw5M0F0RmEvV21QRXJHYjFYUW9HWnNVaDhhV1VLSnBrT2ZNWDk3ZFZvM0lh?=
 =?utf-8?B?RzRGc0thRE1PUmd6VW9WazUrYVBSMEJzdTl0L3gyL0VyRkhMN3B2OGcxakp6?=
 =?utf-8?B?ZkFiMEFxWFlDTnQyUnpDQ2pPTGFTM3I2LzBiYVVNWWowUW5OWnpQM1lZUHcx?=
 =?utf-8?B?ckFNVVMxVFI3ZktvRlJEZWlOdGY2ZS9qM294Z1JxREppa2x6TTRoS1VIZXQ5?=
 =?utf-8?B?c0puRnNaUFc0ZnhRdDVocG5qYUw4b0ovNmxVNXh3dDgvT3Y0anp3VWUzN28x?=
 =?utf-8?B?ak9pd0RON2oxOWUvc1gzSzdJTDE0eEY1Q0lFZEVBWktzZC9iQUZNSUt1bTRi?=
 =?utf-8?B?L3pmcG9CQVVQM3p6bEdvYzZpM2tqUjUydHZKOUtERnNjL2hLcEZBUG9aNldV?=
 =?utf-8?B?QWFnY2dvcVN2R2ZiNXhicmtxK1doSm1iZzVyVjQyZy9SRFZrMCs5MmgrMkdh?=
 =?utf-8?B?MlVsWDJicVVqM2o1amlnK01FY0xvSjFseTZVbUJxUEk1cDA2NXVvalpPRVJK?=
 =?utf-8?B?T3IyL05EaXpReXBXRndYMG5ydzI0aE91ZFVNV0Q5RkM1UUhmZVJ6M3pwcjBL?=
 =?utf-8?B?ZkpFSWkvOFpRa3VxQnczMW8wUlVQZTdTeWZXaDdzRkQ2M2x4M0M5dU9Ndkpv?=
 =?utf-8?B?Ny9XMklDQzdIYzhYNSs0bGhrU21QeW1PQTZsWlR1bk5ZenoyU1NFcWxPNVBl?=
 =?utf-8?B?QnZJajAxZ1EzWjNXaXA1MTdYU1FkcjIrYm5kZUkwUzdWRnV3aHJUV25yUGV2?=
 =?utf-8?B?WSthK3VIWW82TWVrY1NxZ2FJWEh0TUhsYTY4ZEdaTVVJUzhudVhTeW5kazZF?=
 =?utf-8?B?RHpiZjlTaXVRRVNSbXdkRUhxYWR0ekdSNXNBZjdaY3pvdm9zMGxTeTdzVVk2?=
 =?utf-8?B?cTlpNDlaOWVuMGlKaXZ6cnE5TFhveC8yYVRoMm50KzZ1TllHNkpTN2wyQXEy?=
 =?utf-8?B?YldKa0NCeVpqZGhPRWk3RjNDclFVcFFwVXJnOWFhVWJVcm84QVE2K0ViU3FO?=
 =?utf-8?B?MkJKZ2JEUnlVNm5uL21jZ2ZBd1QvWjRCSktSVFZiUUpaVEZKdDZ6MHhNYWNV?=
 =?utf-8?B?ZVBIUTdXSTVYWDdhVkVleWhsZ2l1NXNHTk13UzlqNml1K0IvUlZycGFEMjBI?=
 =?utf-8?B?LzZGQ25KRWg3NitUeTNCaytWa25zV2IwbXVXU3VPcStFTC94NFdzT1lQUzBt?=
 =?utf-8?B?QlorbEpzQ1BWQVlIL3NYd1JRMm9HbW4rcE1XeXdUTlBzRnJhN2tSTnhxd2or?=
 =?utf-8?B?Yi9RQldqNkwvRHl3VXNmUi9teHRNTk5ZeGVXWGkvcWFTTTVIZG84THU1RFNr?=
 =?utf-8?B?KzY1T2NSZngzZTRvUENKeXJxV0MzQTVGN2wzU1VqYWhpODZJanlwaGRKL3Z0?=
 =?utf-8?B?c3dRT25MRVFZaWtaVmQ2akZiNnhCc3hlU0NVTUltSVlUbDFzTkJNOGw3V0Js?=
 =?utf-8?B?d1k5d2V1QVpHZnF1c1gwU0JMUW95MzBSZzBYNk9pUEVHbndnZmVUUzRZbjNZ?=
 =?utf-8?B?d1hLSXJBNU11SXpCSUNvZm54bVY4c0hZanIyUUptUXEzaXkvRjNQc3VGd3B0?=
 =?utf-8?B?MWdpWGJtZzYvcHZaV3EydkMrek0ya0hkcGRMd1N0cWNlQ2MveEVDVEVQYWRI?=
 =?utf-8?Q?JUk/7hA+X9ct3qXn+IFgjm3eTRLtw99l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmRoM2o2djVhaWhQUEVTUFkyUzJiYWhRNXlPYzRwY1ZLWjJZUVM1QWtKZVQy?=
 =?utf-8?B?UFZIRUw0cmhldlorNml3UG5nMFRUTGZWTU9Xd21XMk5XUUR6NFBpQ1dEc3hz?=
 =?utf-8?B?eis5bTFheXBMK216TEJSZSt2blNSYlZXbkJkcDRtejF5Y2lhQVY3bEM3Q29t?=
 =?utf-8?B?NGlIMW55blcvY2J0WTd1ODJOeVpzZGgycVBYY25uNytWOEhqYkNnNlhmUFhu?=
 =?utf-8?B?RTdIRUhQcGorbENWMXVxcTZYQm1rcjd4OUp6U0ZwSDdnVC9DYkdqdHY3Skk0?=
 =?utf-8?B?eXRFeDVVbTFweGVYc2ZJNHBkYTlmQW56WFlhSHNGdW85TWtzTGQzQmVqTDZh?=
 =?utf-8?B?QUhQdE05c25sM2dZc041dnVYUE1pcVhCTjZxS0RaUmRCc0o5SFlGMnJkby9K?=
 =?utf-8?B?aTBCVjJOTHVlcjJQc1R2UENTWUlYQXFOb1lHTUJad0o4NnNmSTJNbGd4UWg5?=
 =?utf-8?B?YkNTd2phR1hvZ1pyWEt6aWtJSUtjdldSL2luVXZwVVFMT2c4SjdKM3hIRloy?=
 =?utf-8?B?VTRqZjVmWHQvYXc4czBZVW9kbGxKaVkzNFdRVVNRNStnSS9TaWdvb3NTOUVv?=
 =?utf-8?B?WUxSMG5ReFB2eHJxdnNWQk9Od2RVd2JkRDVpSHMrY1RrT2wrcEY5eElUbXhk?=
 =?utf-8?B?QUllNTVWMXMrR2RRdXdZZEZrbHZLVTNTd1gxN09aSkVwRHo5S2JEeWM3WDFE?=
 =?utf-8?B?Q3ZSUzIrSk9iWjFpOGpkd2NlUVFka2xsLzdQMjRCWFdUZ0JyUjhhTFovcDBP?=
 =?utf-8?B?dXk0azhoRUttb1RMaHlwd2VOVVBMRnRsMkxDYUFtTmdaMXNFcUJrNHl4eGNF?=
 =?utf-8?B?elk0MkdpbXQwSUhXVDI3YWRyUGZvQU1NMTc0RkM2SndvRmx0d3ZqZjc5Y1hT?=
 =?utf-8?B?MFVFRnZXUG81SHVmd3IweUNCeHlkTCtxQkVudXhuK1NHUUo2V2RXMDd2WkpC?=
 =?utf-8?B?MlJnRDQvM2l4cVNCMDFrLzFJRzUreTNqd0h5N3dVTDVYRmhPSEZVam83ck9k?=
 =?utf-8?B?TXpKY3drVUZLSmhTaXFobk5WSlIrSjlFdGpJdGtXd2lSelZ6d050SjFHN1dG?=
 =?utf-8?B?UTFGdXVDbDF3Wk1OZmxoY3lJbDJzeUdldjhpL2dmM1NaQlpoTUpUeldwOWZj?=
 =?utf-8?B?VWlIeXZxd3kwL3hQdGZYNXp3cVptclEzVzBmRWVmK0doWnorME1ndHZMYURF?=
 =?utf-8?B?L01EQ1Y0eVRHTVlGSDVnUXRqSFdSb0N2MjNpN3c3V2FHdXZBNkNicHhRL0tU?=
 =?utf-8?B?eWx4b2U4N1hkTzZsY0NLZ0VVVUlGelJnQWxyWTJjRjlnNXR3cmxKdzhxQmhm?=
 =?utf-8?B?cGZXelF0ZVNWcEcxUWZiU3RLclhnN0dDbUhIY1d2RHQwaU9kS1V5ZzVJNnVR?=
 =?utf-8?B?TEZOVXJLVlhsWG9hdG96Y215bVZMZXFXS3ZrbFhFVEtTUkkyVUJWRGgzVk9t?=
 =?utf-8?B?RlFlSlZpcnRMTDczaWk1UzdPNDdOOVU3SGRsY0ZvelVKVzZLZkgxVHBhSkR2?=
 =?utf-8?B?Wi9yT2VHaEc2bkhTU1luYUxqdmU5dEt6aGwwTXJ0N1RkQkNydUs2QUpSU3VN?=
 =?utf-8?B?TXoyT1BqOE5MU213K0hQdGE0YUpMYTd6NmlxSTNUMWc1WlVVOFBVajltR1VB?=
 =?utf-8?B?TDgvUjZWcldaZHFjV3BTdEJiSkx1aDJpRFZ5T05tcTNLN3R4c1dGWUtseGNN?=
 =?utf-8?B?WnN0blBuenNSUGFLdnphREREV0lRUERDNWNzdERsWktTeTJacHpWYjN6dmE2?=
 =?utf-8?B?T3QrcXFrR2xIdHZDbmdiSkVlVkUxZHorZzgzRGxwT09tcnBjYnJyMUlMY2Ny?=
 =?utf-8?B?RjllL3BpWFp2WjZkamJxY25JQVdSM1FEVGZIZFBwOHIxUXVFT3dmbFFka0Zv?=
 =?utf-8?B?bGFBaENJL2FkOTBZeGwycVBHUGtRZVIvdDIzSGV1bnhCQ2FTY0dmWmZLT2Z0?=
 =?utf-8?B?QWRjWlpEQVJDYjlOL1BWeUZ6TnBOR0RLbzQzNHBBQytBL3lUYytYVjU0WVRs?=
 =?utf-8?B?TFpMSkZZaWdkL0p5MXp0cldVYUhFbWRQM3JSSDZZYjdvZDlGcXN1b0FzMTl3?=
 =?utf-8?B?aXYvY1VtZWhQZ0pRNmFQNVBjVnN4WkY3OEl1cDVMZjFtS3EwQnhNZ0xNbU5x?=
 =?utf-8?Q?Dt7uDWzheNA51lRYqTO5NPlDM?=
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
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac4bc51-ab7d-49ec-07f9-08dd1f0ebef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 02:50:34.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUXipqLgqN1EAgTRQLrWb+jEurcmpUwByMMViZWJCrx0RHh5X5i8dWXqcJNHD56IHjeF/Zl79wavA3aHjNYpQUSs/rNGIFi+DYufJICK+K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6835

SGkgS3J6aywNCg0KPiA+IEFkZCBhc3BlZWQtZzcuZHRzaSB0byBiZSBBU1QyN1hYIGRldmljZSB0
cmVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2V2aW4gQ2hlbiA8a2V2aW5fY2hlbkBhc3Bl
ZWR0ZWNoLmNvbT4NCj4gDQo+IFdoZXJlIGFyZSBhbGwgdGhlIGJpbmRpbmdzPyBXaHkgYXJlIHlv
dSBzaWxlbnQgYWJvdXQgdGhpcz8gVGhlIHBhdGNoc2V0IGFkZGluZw0KPiBuZXcgU29DIERUUywg
d2hlbiBzZXBhcmF0ZSwgaXMgc3VwcG9zZWQgdG8gZXhwbGFpbiB3aGVyZSB3ZSBjYW4gZmluZCB0
aGUNCj4gYmluZGluZ3MuDQpEbyB5b3UgbWVhbiBhcHNlZWQsYXN0MjcwMC1zY3UwIGFuZCBhc3Bl
ZWQsYXN0MjcwMC1zY3UxPw0KQ291bGQgSSBtYWtlIHN1cmUgdGhpcyBuZXcgU29DIERUUyBob3cg
dG8gc3VibWl0Pw0KDQpUaGFua3MuDQoNCj4gDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9v
dC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgYXJjaC9hcm02NC9ib290
L2R0cy9hc3BlZWQvYXNwZWVkLWc3LmR0c2kgfCAyMzYNCj4gPiArKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjM3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1nNy4NCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbi4g
Q2hlbg0K

