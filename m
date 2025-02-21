Return-Path: <linux-aspeed+bounces-798-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975EBC021B3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Feb 2025 00:52:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzWmh6x8Nz2yVX;
	Fri, 21 Feb 2025 11:52:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::707" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740099124;
	cv=pass; b=g/jtl/xI4xDA7bSqfNMGu57pJ18cZpAyYOtCYxR3PFyGunBYLK8RTCLeUdffyhdGJpQ+S9spXPSdCoPcv8OY+kCafb/6GRbZzsb+h4zyMapQtcmcyFnieHkqgCWRAoogxtfqemCe3sc6V2XYfswIZxJNibOMjJg7bRBazZetytq9xHHuu10GPD7ltZida/uXHjUUcolR/tpFhDQaLQj+ZDkHzys+zM+vuPFSfTdeXDVK8pi5d1YVqgN9aB/PJRkVSivdA9wKE3LR6YxYc/to+t/7QX2Qovql0DTjkPmqpVnuAmCvgVS9nZSg+p2L2LXAawdBP0N0Cd1TqX1uCsCXUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740099124; c=relaxed/relaxed;
	bh=R0koQwP0Ke5G9PSzHOD+mKyy7kLlX2E/hGTMROdzX0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TlqEMxuR0dDHUMjenxM6a0LytgcMfFTA53+oxW+/0Av9hRC0AN+oWM3mjkjQ4yQL6cOH87Hmbb8M5BKywLIkykWkL/lyiLEeD81PXvXkrORmwwem8Jq3LP+51NSGP0Y4zIRnk7BCbGBornyIdpls8FgfF1BoH+cfRzDHQV+Q+l4ieXXqnl5tps4UTjzLSXFkJQqEEn/XEhpf6PLNkfJsoM7TfNc4vFcGI24gvgKzffcOOba4xaNJzP5yzROLZTvck/D3pYStpGKZsje/P7wZ6WFoz163VLwNAsOA6llDve5zKa16POn+JtSVwENay7CPaHKjxLkx4d8d4RrzMI7XjA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=o1o7v9Kx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200f::707; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=o1o7v9Kx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::707; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::707])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzWmg0sGwz2xrC
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 11:52:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RChp+QwHxg9Wum81Bpc/sNckRtUK8goe2Ont2m+3LG/BTVFbrOgX/DzJ43gRld1BYgufsGgiBr9GQ/tBFjLDqJNZ3tsn0t1a2301M/4e1KkltS7JJhAmY2VvGoV1W0I9Wyl+LRzSDO5un63z25Gb44JBZqNZW9kVCyHUnMV+GUrN53OoAoYdqdArmYf+bUexjy/5x5jM4hdZwzyS+WatoPAIzErzlCdrLY9Vf+Eoxi+YyAmrEgKoCGOVsphMRrlpk5IN1xD9aO1fqtiG+lqUmdJ64HQbPm/Vupj6nS5dazxoctMsfWFcu7F8w8F9EfwfHaXyS06vKrkJGb3UCWTpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0koQwP0Ke5G9PSzHOD+mKyy7kLlX2E/hGTMROdzX0M=;
 b=EaNQf1UXodYej911/7iREl+jipIyIFf69AL+uVNKDu8Z/zKVJTK1JU2fN+D9qRUl5oK6x/Et/4xxnbPPwiqbUXzEtHUoXaUwtBg945nLA2LNM1hZPX3oWcvRvF9evUULES20HtRvxq60y2Iy9NhoGxVSJTOySJCR64l93wBZnCFfuq0utC8sQUHFRK75HH5TvxXkfCyDRm5CkalyOWLl0+rMfMzMclqlTBkgq6RpqnDAcRcr5d/eu67f0Wcci1dIMPj9xfTUD5kIGsQMf7pcr2P1Sco6fpDS7LFDzvjlq5+UiuxIth9gK50665oktqtHlatyk9weBNfCpOS+RQn6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0koQwP0Ke5G9PSzHOD+mKyy7kLlX2E/hGTMROdzX0M=;
 b=o1o7v9KxrVJyEXW5JXXJzdtkXcMkcJDB8xLNAuO4ZxI1F0yP8DLoUJ4j4ETLIB083VDzqclY+uw4yW9dTs1VFaQLfTEeEJk0R9o1I4+R4yzUXU/scPIncCaLT86HNA/yAuyG8aOAkQDkWtLDekUMVypOwvuCQ2tiQ5WxojAIgXIj6ZZCu2CYmq+DDLVLp4at7K16zTpuTpb8JJb91+9XS8JBRPNvz0I7Sx/s7iM0cw8CtK2leyDstqFxNzt44WO8Jgso6LLWuoB6bLK5tRlW0d0YyC+yJHu0XhWF7nC778/OL3ePAcWAgU8l/frkg9YW5mo97+957hVN/Z7GNAG3lw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5378.apcprd06.prod.outlook.com (2603:1096:400:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 00:51:28 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 00:51:28 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "joel@jms.id.au"
	<joel@jms.id.au>, Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>
CC: tomer.maimon <tomer.maimon@nuvoton.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Jenmin Yuan
	<jenmin_yuan@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Topic: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Index:
 AQHbgTHkHx9CTwRXuEqAh/w3KRppVLNLZMoAgADY0YCAAKoPgIAA6miAgACsmZCAAOq6gIABhVfQ
Date: Fri, 21 Feb 2025 00:51:27 +0000
Message-ID:
 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
	 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
In-Reply-To:
 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5378:EE_
x-ms-office365-filtering-correlation-id: 9440d947-4f1e-4d74-31f1-08dd5211dfcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amJLYkU5NjVpYmtFSkFXRVVUUi9UUi9KY2ZHbzYzNmV4bFJBTmZTSFJIeUJC?=
 =?utf-8?B?N1lBbitwelpLdGtaN0o2WXlGTlVMZkVvTnlwNjlPNld5S3hTcVI2VkRJaU5k?=
 =?utf-8?B?ZnVFT01SQ0lxZnZpTHI5ZmRCZVlEenZlUDd5WGJKVHNCSmtrVUF3Qkp1aHJm?=
 =?utf-8?B?QnVXTUErek5NWlRGUFpGVUNDeDNUTi9acHBqK2w1RmxhVlVhaGhuYWQvTTFY?=
 =?utf-8?B?WENldWhpUktPbkJmMENJM1d0ZTVINnF0ZUh0SENVbHBiUlp1WVpoOENPRUds?=
 =?utf-8?B?YkwrRDg4blc4M0xnUkFJOGZXM3VaOVZxa1RWbElUYWI3b1AxckYxTXF2b3hF?=
 =?utf-8?B?ZVV0cWJqb0E1R1BWUjBvaEJxVkh6dWc2QkNnZTJ0eTRNSXkxNVV2Uzkwa3Iv?=
 =?utf-8?B?Y0VLT1QrNmVMdXJyQWxaSnRMQ280bDVVaXV4WWY1amZJblJLc2ZkY0VFWFAy?=
 =?utf-8?B?dE5YYU5uR29RSW5Ed3p2WTg1UkR4NVJIQ0ljbmlXT2xURDEwMndQc1oxcWxF?=
 =?utf-8?B?bW4wVHRsOXBnUlNVMml4NmVoY01xK1Vwblc3WHM2UWpkdkFuNGdRcW93L2tM?=
 =?utf-8?B?TVFIcXIvY1VoUUYzQXRoY0dzRkZLVDJkTDEyWHpSZ1NTTzNVby9vb1g3Slp3?=
 =?utf-8?B?RU5rSzNpQlN6TDlsbEJVb1BRQXcxSHh5RjBMU0VBcmlORWlzeHptSXBuSU9D?=
 =?utf-8?B?R1MvMGR3aXovb0NBLzNmUjY0OW1CRHo1aFlCMHAvelE2bWl1SzJFSjYrK0pY?=
 =?utf-8?B?RnRHMHpqWnRoaVVyQ0luazNmQmh2OFEvVzNuY2g5Rzk3K0NQUTdvblY1YlAw?=
 =?utf-8?B?aUVJVTNzK2ZsbFJ0K0ZRVmMzbGNNakluOHVsV1ZOcytLQUxHTlhtc3FoNE8z?=
 =?utf-8?B?VzkrUTJvQnVoeHpRZGlRN3lNcVRHUXhlZVI2Uk1QYk5PTENHdzZuR3gwU2lv?=
 =?utf-8?B?ZFR5U2RqZDhDRzk0TW8zaDR1aXlxWU55VTZMb3drdm14eHN6MEhDZHlIdndW?=
 =?utf-8?B?S0pQamVPNVdMcXFHbWwyTlR4bXFvRTFtQzVsak9hcm4yOHpTQ1ROWjRtc1pO?=
 =?utf-8?B?Mnh5RzZkZXh5QldQRG5qbFBQNGJhMDhQeTJPZStFQk9mbUNwQi9PMEtlWVZl?=
 =?utf-8?B?SVpjWkJiRVIvNlB2czIwNkRiaDVTRHV0VmlzT0pYRFVZT0VpN2xmYVNka2RI?=
 =?utf-8?B?dVlhQXVRajVRN05mVjg3QkVFU2FsRU93cTA2STNFOWdYNkgvZ3BOeTNJV0Q5?=
 =?utf-8?B?bFBZTTdhN2xEVDBsdXF4ckJ2VXFwNzBXemNSaVh6K0V3ZG9laWtYL1BsVVNr?=
 =?utf-8?B?QjhwaEFRaXNJZXZleWZlcjNuNDJ2cSs0bWo2eXRoL05rRW91QUFGdTRQUzVB?=
 =?utf-8?B?Z21hcm9ySzNJOGsvV1BQekdIaitkZ2dhK2ptcEx5OGRtd1pSUGJEd3drT3lS?=
 =?utf-8?B?cUJlU05CY0pmZ0ZjMk5MSG5PQnl6RjZYczlCUUgyOGduWjh4Q2lMOEJZZGpY?=
 =?utf-8?B?THRQemg1elBnQnVnQkZNd1dRbHFFNTFoTzRlWitnc2ozamR0N0ZlT3NZRlh5?=
 =?utf-8?B?QUw2MWdqOXl2dzNhNTJuajNUdW5wT21OZXk1S1JZS2NWT0dNU1ViNWxpWmpY?=
 =?utf-8?B?TEVZamJQemh6L2FOYVppTTR6My9PQVc4bG11WVUrblZDZm82NWpnVURXa1oz?=
 =?utf-8?B?NHk5djBoYTZjbXJicVVBbXFDSUs5MWNJM1BzNFM1R1I4bDBMSG5wMTE4R3FC?=
 =?utf-8?B?ZEVhVVBFUHZzRlJYRlIvOWFJTDNiTFdxYUtTenBRVm1vWnNSaC9iNnQ5Q28v?=
 =?utf-8?B?NVlFc1Y1cXhZb0dtL0FaeHMzbFlXZks5SDIxWms3R0pObWs3aXY4dWw5NkIx?=
 =?utf-8?B?bC9nNndRVG5aSmFGVmU4ZHpnU3ptdGFDU3pnR3k3OWg5b2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE1XN3hiVG5uQ0tUdkJwWlVOT1pJVm1VcGJrTm9pc2hpaDh4aWNBemxxaVQz?=
 =?utf-8?B?cmF5MXRKSTRQclBmVUJHaGF3TlBYQVl5M0tlQy9pVkZJc3F1b2dDQ2lzdkVC?=
 =?utf-8?B?dGxJSjk1RDhsVUFUQ2NQcXhEM0MwRWpMQXpQVU9kc3dUa3JEZ2xOd05Lakds?=
 =?utf-8?B?V1FpQVFIVXFkUU01MG92ZFo1YzlHS0VBOFNtN1R6Z0VXRnVkUjdhQi9hLzZv?=
 =?utf-8?B?SEY5RUJFT3ZJN2oweUVBV1drQUxGalZaWDJrbzdUUlpUTW9XYUd4Rmw2WGdk?=
 =?utf-8?B?UHRUZHphZWNuU0gwajF4d2xtK0tzd2RadUIyNEROSUNXcVlsK2JPSmhiZmlE?=
 =?utf-8?B?YXdaNWZLY3NORUp0aFRHcVJKN2N3bFBSb2twS3ZyeGZ0dlVRdTlISi9DVWl4?=
 =?utf-8?B?SUtobUdZN3BwSkZQTVlUWjZSYXQ5eGNrLzkzYWY2ZUNqaUhPV25obDlMRHBm?=
 =?utf-8?B?aFdzWVBWbHV0RkNMNnBnd3FGMjk3VlkxTEpDSldnZ2pQQVZ6SXp1N0dwN0Uv?=
 =?utf-8?B?d3U1UTdBSkV5Z2xyOGxpRHlCQStETEU4YmcvVDFydkV0NFI5cnlJdXdLamY3?=
 =?utf-8?B?VkdycmxVVHVBYThnSktKRnNvVXFBSS94U25QeEpwWGFFNmJmWXdQbVUrNlZV?=
 =?utf-8?B?QjN1aDdJWnovdW5nSG9XZmE2MGVNdkh5Rkdyemd2endmTjhUdWZIa25ST0NG?=
 =?utf-8?B?YklPaFg3RFh2U1JBRFo0NHY2dzMwS2h4bnhZODFCWjV2MkQwM0wwclY1WFdy?=
 =?utf-8?B?NGNZT0FiQVVnUldUSEs3QnI0VzloMDRrVFUvZVJlT0hhV1RmSXFqbytobWMy?=
 =?utf-8?B?dkVhL1JaRDlHcy9rT0ZQdG1FL0VlT1Mzc25kKzhIa3lNYzdkUHB0RGZtbzl4?=
 =?utf-8?B?MVNhMlp4djJwMHR4TGRoTDA3Q1pKVDFPLzFwejdXNmw2bHVuNmh0ZnB2cW5O?=
 =?utf-8?B?Zk1MU2Ntck9hdGFodlVOSHYrVmtSZm1QT1FZZXh0RWx6MVBtZS9EK1NtOElN?=
 =?utf-8?B?VEdiMWs0bkR4VHY5NFJjaWxVSnhCa1BBTWt5MmRRdDUxWlkvVlpZMnlmQXI3?=
 =?utf-8?B?aGc4T0M4MTBUTFMyVm5ZdjZJNW1SSWtUODZ5SzRpYXVWMnpxWi9jcUR2WTZ3?=
 =?utf-8?B?cGlJNjVjN2k2WGJRSUI2eVlwTGdZbDJMRVVVN1F4ay9oeUtCOWpmeTc2bUxB?=
 =?utf-8?B?WTRnWU5qYjR1WU5Fek1UVmNQZi81MnJUU0ZXa1Fpa05lRTFEK3hvalIyREFJ?=
 =?utf-8?B?QWtPbUE0WVJIZDdyeGJBNElLQ1A4V1VoczliRGhRa1FSUHQzbzJGbHo5UVJS?=
 =?utf-8?B?c1Y1YnhEUDY2U2JxYUI3dE5lZFk5dXhTaEc2RjZaSlYwa0NIQlpoa0tNNFRr?=
 =?utf-8?B?Q3lzYVNheDVqL1crVElaSDZoRHlVWFdCOXF5UFgzUFR2aDFYdVFXWG15VUt5?=
 =?utf-8?B?dytzNlRiN0diL0ZMMi96eE5YNi9jUUlSbUQ3UW1VWUs2YTFWdGpGbUM3ZVhx?=
 =?utf-8?B?MDhWWUxwNkVZN1R4RGRaTTZvTi9OVjA4V3M2d282cDBUckZ5T3BsUnN0UGtH?=
 =?utf-8?B?V3doYjFGSm5IeVI4MGROUm5tUWxENGhuNlhZckRTN04rYkVxaG9jTTlwTmp0?=
 =?utf-8?B?M0tTNEtnSnhXakxXM3NWcG1vSElaMlhYMWRtcVp6WGVaQk9Pcmpsc29PZ3Yx?=
 =?utf-8?B?S2VzNFZ0b2dVNDg0L1BpY2RIR0lPVnhKVGd1cWFlKzY1MmVDL1RjcDRvUjNY?=
 =?utf-8?B?K3pabW91UC9HOFhvOEk4YUlyKzBoYWxNcjM4K1EwdllQNzFULzZEWVNIOWUv?=
 =?utf-8?B?SnVMZzJiWW1DWUkyZzNaTWNlVFEwN1RpbTkxZUorZXBBdWVjamZEVFVKZ2Vm?=
 =?utf-8?B?ejJpWHE0V3RjV0N0SGE3eWMydC9kd3ZuL0hBc01icFBXMG1vYzBLbStDSUh3?=
 =?utf-8?B?bEVkcjExUkdrT20yOVdoZ3dkVlpudTBZajM3WnV5c0F6aDByNzZ4MjJZQmFy?=
 =?utf-8?B?SFZ6dndIcEFQV0tuaEhQeGIyekRBd0FDZ3hyVTU3a0RINjVMNG9SaCsyMUVF?=
 =?utf-8?B?OVltL2tqcExmT21VV2FYUmgrN0JEbC9ZWG9oZitmeHk5c2g5OTREZTBITC80?=
 =?utf-8?Q?gvB2QE9WVKBN1salCPEk3WOCC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9440d947-4f1e-4d74-31f1-08dd5211dfcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 00:51:27.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSMM9JH3AgpGS+VwVgUIJInoWV0V1nauAwGrF6G9M6q4VphnkWLNEGvBm5b0igPIWwPI9UAOGyXOfesT0LYG7DcT6hdZ9SZD6QKGZWDFBeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5378

PiBPbiBXZWQsIDIwMjUtMDItMTkgYXQgMTE6NTkgKzAwMDAsIEtldmluIENoZW4gd3JvdGU6DQo+
ID4gPiBPbiBUdWUsIDIwMjUtMDItMTggYXQgMTE6MTEgKzAwMDAsIEtldmluIENoZW4gd3JvdGU6
DQo+ID4gPiA+ID4gT24gTW9uLCAyMDI1LTAyLTE3IGF0IDEzOjAwICswMTAwLCBLcnp5c3p0b2Yg
S296bG93c2tpIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gMTcvMDIvMjAyNSAxMjo0OCwgS2V2aW4g
Q2hlbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqBwY2MtPm1kZXYucGFyZW50ID0gZGV2Ow0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBw
Y2MtPm1kZXYubWlub3IgPSBNSVNDX0RZTkFNSUNfTUlOT1I7DQo+ID4gPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoHBjYy0+bWRldi5uYW1lID0gZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVM
LA0KPiA+ID4gPiA+ID4gPiAiJXMlZCIsDQo+ID4gPiA+ID4gPiA+IERFVklDRV9OQU1FLA0KPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNj
LT5tZGV2X2lkKTsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcGNjLT5tZGV2LmZvcHMg
PSAmcGNjX2ZvcHM7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJjID0gbWlzY19yZWdp
c3RlcigmcGNjLT5tZGV2KTsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJjKSB7
DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRl
diwgIkNvdWxkbid0IHJlZ2lzdGVyIG1pc2MNCj4gPiA+ID4gPiA+ID4gZGV2aWNlXG4iKTsNCj4g
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX2ZyZWVf
a2ZpZm87DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBZb3UgY2Fubm90IGV4cG9zZSB1c2VyLXNwYWNlIGludGVyZmFjZXMgZnJvbSBTb0Mg
ZHJpdmVycy4gVXNlDQo+ID4gPiA+ID4gPiBhcHByb3ByaWF0ZSBzdWJzeXN0ZW0gZm9yIHRoaXMg
d2l0aCBwcm9wZXIgQUJJIGRvY3VtZW50YXRpb24uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
U2VlOg0KPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2JjNTExOGYyLTg5
ODItNDZmZi1iYzc1LWQwYzcxNDc1ZTkNCj4gPiA+ID4gPiA+IDA5QGENCj4gPiA+ID4gPiA+IHBw
LmYNCj4gPiA+ID4gPiA+IGFzdG1haWwuY29tLw0KPiA+ID4gPiA+ID4gYW5kIG1vcmUgZGlzY3Vz
c2lvbnMgb24gTEtNTA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRnVydGhlciwgZHJpdmVycy9taXNj
L2FzcGVlZC1scGMtc25vb3AuYyBhbHJlYWR5IGV4aXN0czoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmcNCj4gPiA+ID4gPiBpdC9jDQo+ID4gPiA+ID4gb21taXQvP2lkPQ0KPiA+ID4gPiA+
IDlmNGY5YWU4MWQwYWZmYzE4MmY1NGRkMDAyODVkZGI5MGUwYjNhZTENCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEtldmluOiBEaWQgeW91IGNvbnNpZGVyIHJld29ya2luZyBpdD8NCj4gPiA+ID4gQW5k
cmV3OiBObywgSSBkbyBub3QgcmV3b3JrIGl0IGJ1dCBhZGQgdGhlIHBvc3QgY29kZSBjYXB0dXJl
DQo+ID4gPiA+IGRyaXZlciB1c2luZyB0aGUgU05PT1AgcmVnaXN0ZXJzLiBBcyBhIHJlc3VsdCwg
SSBhZGQgc29tZSBjb2RlIGluDQo+ID4gPiA+IGFzcGVlZF9hMjYwMF8xNSB0byBjaGVjayB0aGUg
U05PT1AgZW5hYmxlIGJpdC4gUENDIGRyaXZlciBwcm9iZQ0KPiA+ID4gPiBhYm9ydCBpZiBzbm9v
cCBpcyBlbmFibGVkLg0KPiA+ID4NCj4gPiA+IEhtbSwgSSB0aGluayBPcGVuQk1DJ3MgaGlzdG9y
eSByZWdhcmRpbmcgUE9TVCBjb2RlIHN1cHBvcnQgY2F1c2VkDQo+ID4gPiBzb21lIGNvbmZ1c2lv
biBvbiBteSBwYXJ0LiBGb3Igd2hhdGV2ZXIgcmVhc29uLCB0aGUgc25vb3AgZGV2aWNlIHdhcw0K
PiA+ID4gdXNlZCBhcyBhIHNvdXJjZSBvZiBQT1NUIGNvZGVzIGRlc3BpdGUgdGhlIGV4aXN0ZW5j
ZSBvZiB0aGUNCj4gPiA+IGRlZGljYXRlZCBQT1NUIGNvZGUgaGFyZHdhcmUgc2luY2UgYXQgbGVh
c3QgdGhlIEFTVDI0MDAsIGJ1dC4uLg0KPiA+IFdoYXQgSSBrbm93IGFib3V0IHRoZSBkZWRpY2F0
ZWQgUE9TVCBjb2RlIGhhcmR3YXJlIGluIEFTUEVFRCBzaG91bGQgYmUNCj4gPiB0aGUgc2FtZSBv
bmUgaW4gTFBDIG1vZHVsZS4NCj4gPg0KPiA+ID4NCj4gPiA+ID4gUENDIGlzIHVzZWQgZm9yIHBv
cnQgSS9PIGJ5dGUgc25vb3Bpbmcgb3ZlciBlU1BJLg0KPiA+ID4NCj4gPiA+IC4uLiBpdCBzZWVt
cyB0aGF0IHRoZXkncmUgbGFyZ2VseSBpbnRlcmNoYW5nZWFibGUsIGp1c3Qgd2l0aA0KPiA+ID4g
ZGlmZmVyZW50IGhhcmR3YXJlIGZlYXR1cmVzIChQQ0MgaGFzIERNQSk/IE15IGltcHJlc3Npb24g
aXMgdGhhdCB0aGUNCj4gPiA+IHNub29wIGRldmljZSBjb3VsZCBhbHNvIGJlIHVzZWQgb3ZlciBl
U1BJPw0KPiA+IFllcywgUENDIGhhcyBETUEgdG8gY2FwdHVyZSB0aGUgUE9TVCBjb2RlLg0KPiA+
IEFuZCBzbm9vcCBkZXZpY2UgYWxzbyBjYW4gYmUgdXNlZCBvdmVyIGVTUEkuDQo+ID4NCj4gPiBU
aGVzZSB0d28gZGV2aWNlcyBvZiBQQ0MgYW5kIHNub29wIHVzZSB0aGUgc2FtZSBwb3J0IEkvTyBv
ZiA4MGggYW5kDQo+ID4gODFoLg0KPiA+IEJ1dCwgaW4gY3VycmVudCB1c2FnZSBvZiBQQ0MsIGl0
IGNhbiBzdXBwb3J0IGEgY29udGludW91cywgNC1ieXRlcw0KPiA+IG1heGltdW0gcmVnaW9uIGZy
b20gcG9ydCBJL08gODBoIHRvIDgzaC4NCj4gPiBXaGF0IEkga25vdyBhYm91dCBQQ0Mgb3Igc25v
b3AgdXNhZ2UsIGRlcGVuZHMgb24gSU5URUwgcGxhdGZvcm0gb3IgQU1EDQo+ID4gcGxhdGZvcm0u
DQo+ID4NCj4gPiBGb3IgQVNQRUVELCB3ZSB3YW50IHRvIHVwc3RyZWFtIHRoZSBQQ0MgZHJpdmVy
IGZvciB0aGUgUENDIHVzYWdlLg0KPiANCj4gWWVhaCwgdGhhdCdzIGZpbmUsIGJ1dCBJIHRoaW5r
IHNvbWUgd29yayBuZWVkcyB0byBiZSBkb25lIHRvIHByb3ZpZGUgY29oZXJlbmNlDQo+IGluIHRo
ZSBkZXZpY2V0cmVlIGJpbmRpbmcgYW5kIHVzZXJzcGFjZSBBUElzIGFjcm9zcyBib3RoIHRoZSBB
U1BFRUQgc25vb3ANCj4gYW5kIFBDQyBiaXRzLCBhcyB3ZWxsIGFzIHRoZSBOdXZvdG9uIEJQQy4g
QmVzcG9rZSBkZXNpZ25zIGNyZWF0ZSBwYWluLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgta2VybmVsLy83NjYxZGU3NC1mNjhjLTY2MTctNmE0ZS0zYjBlYjc2YTJhMmVAbGluYXJvLm9y
Zy9ULw0KQW5kcmV3LCBJIGZpbmQgdGhlICJOUENNIEJQQyBkcml2ZXIiIHRvIGdldCB0aGUgbGlu
ay4gQXJlIHRoZXNlIHBhdGNoZXMgbWF0Y2ggd2hhdCB5b3UgbWVudGlvbmVkPw0KDQo+IA0KPiBU
aGUgUENDIGRyaXZlciBhYm92ZSByZWFkcyB0aGUgZGF0YSBvdXQgb2YgdGhlIERNQSByaW5nLWJ1
ZmZlciBzdHJhaWdodCBpbnRvDQo+IHRoZSBrZmlmbyBob29rZWQgdXAgdGhlIHRoZSBtaXNjZGV2
IHJlYWQgY2FsbGJhY2suIFRoZSBkYXRhc2hlZXQNCj4gbm90ZXM6ICJ0aGUgZGF0YSBzdHJ1Y3R1
cmUgb2YgdGhlIEZJRk8gaXMgbW9kZSBkZXBlbmRlbnQiIGluIHRoZSBkZXNjcmlwdGlvbiBvZg0K
PiBQQ0NSMywgYnV0IG5vIGluLWJhbmQgb3Igb3V0LW9mLWJhbmQgbWVjaGFuaXNtIChzeXNmcywN
Cj4gaW9jdGwpIGlzIHByb3ZpZGVkIGZvciB1c2Vyc3BhY2UgdG8gcXVlcnkgd2hldGhlciBpdCdz
IDFCLCAyQiwgNEIgb3IgImZ1bGwiIG1vZGUuDQpGb3IgdGhlIGRhdGEgc3RydWN0dXJlIGluIFBD
Q1IzLCBJIGNoZWNrZWQgd2l0aCBkZXNpZ25lci4gV2Ugb25seSBuZWVkIDJCIG1vZGUgdG8gZ2V0
IHRoZSBpbmZvcm1hdGlvbiBhYm91dCBkYXRhIGFuZCByZWxhdGVkIGFkZHJlc3Nlcy4NCkZvciBl
eGFtcGxlLCBmcm9tIGVzcGkgbWFzdGVyIHNlbmQgdGhlIHBvcnQgODBofjgzaCB3aXRoIGZpcnN0
IGRhdGEgMHgxMTIyMzM0NCBhbmQgc2Vjb25kIGRhdGEgMHg1NTY2Nzc4OC4gVGhlIFBDQyBrZmlm
byB3b3VsZCBiZSB3cml0dGVuIGluIHRoZSBmb2xsb3dpbmcgb3V0cHV0IGZyb20gaGV4ZHVtcC4N
CiMgaGV4ZHVtcCAgL2Rldi9hc3BlZWQtbHBjLXBjYzANCjAwMDAwMDAgNDA0NCA0MTMzIDQyMjIg
NDMxMSA0MDg4IDQxNzcgNDI2NiA0MzU1DQo+IA0KPiBUaGUgc2l0dWF0aW9uIHdpdGggdGhlIHNu
b29wIGRyaXZlciBpcyBzaW1pbGFyICgxIG9yIDIgMUIgY2hhbm5lbHMgbXVsdGlwbGV4ZWQNCj4g
aW50byB0aGUgb25lIGRhdGEgc3RyZWFtKS4gSXQgYWxzbyBsb29rcyBhIGJpdCBxdWlya3kgd2l0
aCBtdWx0aXBsZSBjaGFubmVscw0KPiBlbmFibGVkLCBhcyB3aGF0IHVzZXJzcGFjZSByZWFkcyB3
aWxsIGRlcGVuZCBvbiB0aGUgaG9zdCBhY2Nlc3MgcGF0dGVybnMsIGJ1dA0KPiBubyBtZXRhZGF0
YSBpcyBwcm92aWRlZCB0byB1c2Vyc3BhY2UgYWJvdXQgd2hhdCBpdCdzIHJlYWRpbmcuDQpZZXMs
IGZvciB0aGUgc25vb3AgZHJpdmVyIGFuZCBQQ0MgZHJpdmVyLCBzb21lIG1lY2hhbmlzbSBpcyB0
aGUgc2FtZS4gQnV0IHNub29wIG9ubHkgc3VwcG9ydHMgMiBieXRlcyBkYXRhIGZyb20gdGhlIDIg
MUIgY2hhbm5lbHMgbXVsdGlwbGV4ZWQuDQpTbywgd2UgbmVlZCB0byBhZGQgUENDIGRyaXZlciB0
byB1cHN0cmVhbSBmb3IgY3VzdG9tZXIncyA0IEJ5dGVzIFBPU1QgY29kZSBjYXB0dXJlIHVzYWdl
IGV2ZW4gdGhlIFBDQyBkcml2ZXIgbmVlZHMgdG8gY2hlY2sgdGhlIHNub29wIGVuYWJsZWQgb3Ig
bm90Lg0KT3IsIGNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSB1cyBjb21lIGNvbW1lbnRzIGFib3V0IGhv
dyBJIGNhbiB1cHN0cmVhbSB0aGUgUENDIGRyaXZlci4NCg0KPiANCj4gVGhpcyBzaG91bGQgYmUg
Zml4ZWQgc28gdXNlcnNwYWNlIGNhbiBoYXZlIHNvbWUgY2VydGFpbnR5IGFuZCBhIHVzZWZ1bCBB
UEkgdG8NCj4gd29yayBhZ2FpbnN0IChvbmUgdGhhdCBwcm92aWRlcyBhIGRpcmVjdCBkZXNjcmlw
dGlvbiBvZiB3aGF0J3MgYmVpbmcgcmVhZCBvdXQpLg0KPiANCj4gSSBleHBlY3Qgd2UgY291bGQg
c2ltaWxhcmx5IGNvbnNvbGlkYXRlIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmdzLCBjb3ZlcmluZyB3
aGF0DQo+IElPIHBvcnQgcmFuZ2UgdG8gYXR0YWNoIHRvLg0KPiANCj4gQW5kcmV3DQo=

