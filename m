Return-Path: <linux-aspeed+bounces-3521-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816CFE9A02C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Feb 2026 16:14:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGM5N0X1Sz307K;
	Thu, 19 Feb 2026 03:14:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771431240;
	cv=pass; b=XGyfQF/WSQATqRub24aqY9ByTpRkPnEu42WCrpgml8xfOFIekBxLAuYJHzTk9Old2ZNhc5/wdII2qXHQc0fLm8MPVi0tq0y/RvhQATjvJ20618RhrGQ1DwrptMVjIh+vxxFLBofjrvQ1fq1h7Tmdnx7BnTsq0kLwFQdoSdNM+z32RMm772yru5EgFrlgFFlN6URAcfsPVbRgZ13RQjuUUcSKDBnup61hKGgO2+t0CdLHb0o+8xD6G2gfLCJ4hDJdSWM5CKS8axqhHi5isQq13WCiMFFy2dvjh1lV8bWoo19ikWPYErM3pkRTnzO/9V+puXi1wzYQrF7O6iBGLrLwzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771431240; c=relaxed/relaxed;
	bh=56HhmK3omWUqITS6bx6f/SLCaYG3s/CfsVqw9bcfHV0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PTUlC+eGgtS47TUnt9e43prKnOgUN4nlS6TnkpA34Etvm3wEMuFGYPGQ6FVApWmbpP7dpcqrcSU+RUOFZZbSRcxeYfJDO3de0xOfyL7vu4mz+iXi/N6Df2hkmEbLO0LwfmDnJ2XdClYqDcd0yIVp3dg/cA9TlZYEkp6CRAPDD1aVQXf7/MqZ049eMfCstd2nzHTOxcRE0/HlgjGZ+v82I6FtyvqbpNU0Pmtb3zRNUavgIP2S2A848tJCM4z3nxT5hoELFvk8SJ8KEwiakTcuYHrg/1Ag1b+WUnSfzJ+46l8d7OTCvizhPr6fcjQWi/MAuQvsWli58DaNi+1GwHm+AA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Gg6ZSRr3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Gg6ZSRr3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGM5K1vjcz2xlq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Feb 2026 03:13:56 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDoGpO13NFkFpMYYw4KCkW8bMoiTb3PTRR/TtsqT7dBuCKPK9gKHmH+Mv7W9yZ/cyAX33XE2ZRpOra79Qwc5SCuPmuen7zDyqRZacZEjABkKAos63DYtWe5zydkocg5+DWwExlDHLHxiTyIn2f7zYmbX9h9dRv9Xrb9S22xLcvaw+zvX7HRgQCO+5jzp8fh7y9w8BfrtdmYZPr31QPresgYKV80RfwZAoWhI4xq/pdWsfql/5OhFivdMBUjpyR3L6ZKc854Y0Wn+DuLrtbYR0syDM5s6cl0NAIpZZQdIRevdNaELGrT1VKSUNkTL7fmNXkxvEYWd4nX9AjT8FiZpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56HhmK3omWUqITS6bx6f/SLCaYG3s/CfsVqw9bcfHV0=;
 b=xOe+kkgIiVroI36ltwlRveQSpIUrA4PGYDmuOnqYsHlWHztBNF/tMNdkK45ctcFd45lDzkuYGLl84wM5zFmA168k1jHJMv+Ik/l9O0cs9Yc0/AWxKhZ5yfFEtjCkNet4s8kUlYHg8vjSRuacO99SjRlQYqrEW/6Ezf0ncye3+gTVPi4WURgmnxNaDDNhY0NyyRXIxyI7/QaBx77OBm1Qi2TH1wK0pRq7RN42AGAlxJNVEK+N/3YMDDdq1YakY+A3ToQWCxxDIs45JlsldXEcP352kxUEsySUle4R6NCaE2P732cF2yTh+T9FuLyafBuVPARhja/GCkU7HRjnU6KF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56HhmK3omWUqITS6bx6f/SLCaYG3s/CfsVqw9bcfHV0=;
 b=Gg6ZSRr3pbec46jJZ3GWT0068qanvbKlrMts7BOWFrG3peLYEaQT64kS8V8vFo1l/SRzjmOdm/2mFJgS090PFgvEfufeqnhXcuE66XwJUBIMB+4Z2DZO5UL59SDAJNDPNffSdx9VHtrvCaP2xz5GvaiEZ9zDCqaXNqyJUnn6VAUt/jwXHNDO3jIWmV4vFhchF/gLl/gi60h1/4P+hxaJAOyKmEZLhpGmFU8dCuaiL4M5Ze/j8aD8+GTjwENBeA383mGOoH68C5oeF5l8/LPcZUxcTf+8kDDM4LADNqyr6fW9msiwXLC+r5Fbd1w3rjjPO7vQhWvB5RTent9EGvELbw==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by OS8PR06MB7324.apcprd06.prod.outlook.com (2603:1096:604:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:13:28 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:13:28 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bartosz Golaszewski <brgl@kernel.org>, "patrickw3@meta.com"
	<patrickw3@meta.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: pinctrl: Add pinctrl-packed
Thread-Topic: [PATCH RFC 1/2] dt-bindings: pinctrl: Add pinctrl-packed
Thread-Index: AQHcoPBcpGGsu6bWiUq7ZZAwnU+dAw==
Date: Wed, 18 Feb 2026 16:13:28 +0000
Message-ID: <8CA74EF8-CDED-4308-8A78-ADE989A30A4C@aspeedtech.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|OS8PR06MB7324:EE_
x-ms-office365-filtering-correlation-id: 7e896da0-269a-4954-3116-08de6f08a6c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2hnTGp0SnYzb0RSZUpwc0JCQVhycldpWXhuLy96cTdhT3FMSDVFZGNmdEVD?=
 =?utf-8?B?WlJZeUxCYXFrOVcrcUZMUmxuZXc1UEdIK09zWEw2d0JTcTg5YWJMeHJMa21s?=
 =?utf-8?B?cEZCTEZmUnRJOFNJQmY4eE1Ib1J5aVZ6UkdQZXNUbUFrVjZlbVkxYjVQemZt?=
 =?utf-8?B?U2pMTTAzMUhCakZOU1pubFZObFhBcDJ0R3lma1BxUDZTOVlRNm5yTXVGK1Bl?=
 =?utf-8?B?RTBkYWc4VWxTc2lxdDU2SDhWTE9jMVhkMzU5VVBVK3hUYS9GRXZuZ0hyQzlr?=
 =?utf-8?B?UVNVTFh2RWtSMXhzR3Q3L1pHTTc0N3VTeHo1NmNKT3pyRmFwckFhMndwTUI0?=
 =?utf-8?B?QjNYbUtGQkJUZjN1ZGpReVFna2IyS0E3WEEwNFdHSzg5a0cwNzNGRWppRTI2?=
 =?utf-8?B?MXZOM3hrYW91S2VLM2VWV3RwMGtCVGQ1dzRtUDBXelBPQmlyMEllZGFsbDE0?=
 =?utf-8?B?cUlpRkxvYk1OV3JUaHBRUndoblJvNHFyRWJ0L0dIUW9pZzJHVkh3clBlazNM?=
 =?utf-8?B?UG1yQ2lkL3JKY2lwQnZqd2dGN2YxNzdSNUpPejhTeGZkNDlBMzR4QVd6QmY1?=
 =?utf-8?B?WEJ3d0FmR21aNDZSbDdmM05KTzRHY3Z6b3JMcGFPelQ2Y0xYTGc2V01SU2Nx?=
 =?utf-8?B?MlN4M05RMW96bEU2emJkdXVhU09TRXh1OGFNYnozOW9oK0NNV0ZJOWxZM1Jn?=
 =?utf-8?B?Y21MTWlCdWhzWHlEZWU2UVhPYndJZ24xbC9CMGJ5OUN2ZnpXOE1kb3MweWF6?=
 =?utf-8?B?MWREdnBwWlRvMnR5dTk3eU1tRlVXMHdNbk5uRkVMQVBKUHNkUzBxcTdXL1pB?=
 =?utf-8?B?Mm1BeU51Q0NmNHByQkJIeUdkT0V5TzV4SFlTRVNieE81bnN5MWJpdUNZMTlx?=
 =?utf-8?B?RXpKZmtZWjh3SVpubEZmZWw3YjlSZFRNbDljQ285M2VkRXFKeTRJWXNHWktM?=
 =?utf-8?B?VG9jcHZoRWhMYVpqWHVSTGEwV0diUlZMdW5mR1NFNVpNK1BMOUtuczNTenFX?=
 =?utf-8?B?ODNlRzFuWkJScXNqZmMxT2tHSHZEbUZuaGRWenJSWVJDMWRGL3E4bGNCWC9X?=
 =?utf-8?B?K1NzZ2FDZDV2dWloTlZuSHd5bFhoRDFFSzI2ejR1bVFGNE8zZ2RPQ1RCYmZa?=
 =?utf-8?B?VmJzcnRrVWRJQmpLVUl3RGNKTE80bkdxNTF2Y2MvWG84aXFQY2dhczZsQmlW?=
 =?utf-8?B?L2JOZ213NnBsaVFPZTlKSXdWMWJQZnNCS2lsb29VcWhxOE44eUNnWE0zZWRB?=
 =?utf-8?B?eUpZTlNldzV2c1ptZDJmdUUrSjZiR2lrUm1kZ1lIMEtXLzVYcjVUUEd6bnpT?=
 =?utf-8?B?OVR4SU9PTFVGOG8xTTYyaVpXbGFySzVCOTYxbnJUM2pwa0ZIazdLTXlWVm9J?=
 =?utf-8?B?RHZYN0krUFdFZUk4VXZYdDJmdmdPOGhIbUFRcFo1Z0l0QmJYZXFIVXBRZ3kr?=
 =?utf-8?B?cU1sQllpeUZ1aG8rMXRmRldlcEVnd3BJbFRObFdyL1ZCbCswamlrMDdJWDl4?=
 =?utf-8?B?SFF0MXpHQUZoamp3UW13Yk9nbThUdEZHM3lpTnpzYmNjYThUODMwMm01blow?=
 =?utf-8?B?SlV2R3pjNnhTT3ZmUGN3djA2NDVtQThTRE96OGZlMnFJNy9UUlNOcXB4ZHMr?=
 =?utf-8?B?Z3YyQmFBTVRvUmNrZXYvTVVPUlhNeVNRWFdZQXhaclBxWE43dUpGZGt2dlZq?=
 =?utf-8?B?YVlWVmUwNjV4bFd1YmFEN2sxSGwwZSsrckFCTDFUSnlhMitpUVZ4ZStWbFd6?=
 =?utf-8?B?eFlOcjNuWVVkQ1p3dExhOGZ6THpwRTBlak1HTitPREdydmo1T0dvVUpuRU9R?=
 =?utf-8?B?ckJRVm1DK2pDbzNKZi9HNDhuOHdkQXJQR0RuL1R3b1Z3SGVFNm95ZFhVamhP?=
 =?utf-8?B?eFRsSjdnZkdSN3B4c3ZEYS8xOXZGZW9DZHptMm4rMm9vVjRBcVBFYzlSTHMx?=
 =?utf-8?B?ejJUVFRFNzhMOWhrTStvbW9Kam1GRTcvN0lqeE5EbGpGaTQ4eFkxczlsTE5j?=
 =?utf-8?B?THBMRVg2ZzlXV0liZzd2YXZqNkJTbTh2aEtMRU1vbnd1ZmVtVEIzamhYT3Rx?=
 =?utf-8?B?QnZVVkFKMkh5ZldUc2lWa3p6dEdweDdwcnpBUFZkVFRIbkhOWTFrb3JVaHZt?=
 =?utf-8?B?WHFqV1dHNkJSeFh0SE4rVnYyUjBVNWFaV0prbU8vMTZsZW5Qa29CRnRIZEQ3?=
 =?utf-8?Q?hlMN/Cp9+7O3l8TNLSiFmbk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTBOWmx1aTNoeUFRQ2Zmd0NyZ1FGTGpHMDFkWTRaQVhzMWY0VlpjSGZIYith?=
 =?utf-8?B?NGZwRjMxeXU1M2xVbmJsSDlyQmRxZVFpdFdreVBGRUQ5Wk1FWmtxQUJGb3lG?=
 =?utf-8?B?bk9yQ05hT1FYTU01M3pURHhmVFJZZFRRZEUzZkoxenlwNk42U3RacEc3ZDRC?=
 =?utf-8?B?S0tCL3grZC9MbE90cmZUbkttdzN6UEQ3Nk5MWXIxeTQ2UTcwa2kvZmN0ZHVj?=
 =?utf-8?B?WTdVQUpidHpBb0tRWGQ4NjJTVlRwNSt6emF6Y2FaYWQvSHoybmpPUlJGQm8r?=
 =?utf-8?B?bG1zTXAyYTVhSkl0cVBFRGV1cS9zZU1Lc3pNNFQ3S0lSK1NWZGVISk1wZDV3?=
 =?utf-8?B?c2V0QjExMGxDUjlVUFlKbWpsSGR4R2U4WUJGd1NtZGd0RnovWmcwdmlsWjdk?=
 =?utf-8?B?WU1tUnNxa2ppZDQvMFg4YlRIN2VuaXZXb1JxTU16VlZUVXpneUpEOFEzVnFn?=
 =?utf-8?B?d0xEZnlzbnExV3hlMnR1dS9tL2c5SzNySExBWTgxUmxlVXVRVWdGNVNST2tG?=
 =?utf-8?B?MGlrc2QydUFTOHFvbTBSN1QrajBpZU5BZGpnMEhoWHF2ZEQzNSt5OTZhV1Jm?=
 =?utf-8?B?RmM2czBVTHViWGkxeXJyMDR5dVhXWmoxZEJ0TmVZOUNURklOd1g5ZzdmMGNS?=
 =?utf-8?B?c1J2aVQwNFFHS1BwRUpPYTNrdk9tWU1vK1pMQjFlNExmQWxrNVFvajd3dThI?=
 =?utf-8?B?SGxkMnhOUHVqNVlBVDE3NDhkNFRjNFdpSHpSV08xTXVEWnhiTW9qWjVSeFE4?=
 =?utf-8?B?NmFmYytObGhIK2J6RVNsLy9jUUY4NHBlUm83WW5MajZRS3dEbFJ6NnRobFlw?=
 =?utf-8?B?ZWluUDVlcGdST3ZXZTRucTl6TVZPemdoT0RnMWFPdWNnKzIzTVlsdGg4eFZl?=
 =?utf-8?B?aW0wdmd5QTYwUGlyWWVQNUYrT1h1K3RpZEZ1b3k5MkJNd1RTV2Y5empWeXNX?=
 =?utf-8?B?Tm12QmtrV1VHYkVyMDNWejFJNGJwU0dUaWc2NGx3MWVsQm9OdXNheC9OME1L?=
 =?utf-8?B?djF4dmh5akR0VG01T0U4RzRCWmtjU082WUw5NjF4a0lOM2M3MlF1WEh5bjdu?=
 =?utf-8?B?MzRYdFpGTmFtMndYdFdNbVNKcXBGdDI5MHk3OW03VFdhS1k0V1ZRZzQyY0kv?=
 =?utf-8?B?ZUh2bjMybmpxbUNzc2lmdUtUTFA5V1c2SFI5WitYN2lYL3RHemxWUnErNzFQ?=
 =?utf-8?B?WDYrS2hYTkJ6YS9HSjh3N1QzN3dvSDFib0ZvUVMvTGEyMVphOHNUOTQvM3Ux?=
 =?utf-8?B?d1B0a09GcXZYdUtpSit5blh2eldzYTZoQzczUzFOTlBXWjNCZkQ3azhwM3ds?=
 =?utf-8?B?NUlYVUVFejhUcWJuMXRObUFtdjZ4U1pYblZwMy9ORmhoVnRYT05EZGZDRjJp?=
 =?utf-8?B?eno2bHdINlBTWmRSTlRKamRBbGlDa1dadFZKMVViUFBzb0ZOclhpTys5UkNZ?=
 =?utf-8?B?dE9FcWlIaXJ5NkhrQXBFTFJ0QkRaTmZRZHFaZHBleG9hUjFHakdjR1ZkVGFl?=
 =?utf-8?B?SFhxL1Y0VGVUV1BCaFQyT21PaEFvdjJad0hleTdsc2E2cG83QmQvSmsvcEFm?=
 =?utf-8?B?VDB4YmpMUFVJQ0sraCtCWVg2VWRMcnFHSmRoYzk3L3l3UGtqWE83Tnd0cDdC?=
 =?utf-8?B?UTZOdG5nZ3NZZjFQS2NQMElQYnZOOHpmbEVVWHd5N0I4Qlo0SVc4OXo0cU9a?=
 =?utf-8?B?TUZFT0hObGtSWTY0SG1aVTFLS1ZQSnUvT1NzdkR6MmV5MCthS1p6c3M3dFdU?=
 =?utf-8?B?bFdJNHdsRWxNUlBNVko1Qkt4N3M1clpLbEp1Q2N5ZTVTcHJZNWNxN05lMkE5?=
 =?utf-8?B?SnAra0owSS9nYzNaRm5BaU5kQ1FBNEs4S0RKTnJXTmVwTjdzU1ZFODVHa1Fj?=
 =?utf-8?B?RVl4MzZoMHBHaGZYd0NWZmUza1VwOEpBdlpCUVdxZDNOQTdwKzhoclp0T0Rn?=
 =?utf-8?B?cWorTXFyWTY2YmlCczA1dVo2TkI1TDJkL0l3NkU5WGk0Q3RzUFNBVUM2UGlm?=
 =?utf-8?B?ckQ2YkJBeU94dFVjejlQQlRWQitaeE1lQUlXMUJjc3l0cEthOGpYQUFSWHFv?=
 =?utf-8?B?eFgxOWd1TTBMbk4wZlJzTEUzd1BNVnBmdjVZSldrcjhFTkVsbUtlQ1A5Q2VP?=
 =?utf-8?B?MDRMMlpnTnhmUHNIYlg3eXdiWHh2OW9Kay9BTUh0Z2F2bkVZelZJR1JobVRn?=
 =?utf-8?B?eEpsbXB6U21wd001bjI0NFU5RzdHZ2dzTWxOQ3pIbCtTajhVbzY0Yk1pZlRV?=
 =?utf-8?B?UjU5SndYUDczQ2pKVTVYS0lNMnNnUlJydTIrQldPR1JLMzg0b211bUpWNEtl?=
 =?utf-8?B?OWNnVXBNNDBCSUdHOVNKNWdJQ210YnVvTzBteCtyMlErUGwzTDFxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2345C20FF9303A4F9DC0FE0176E5299F@aspeedtech.com>
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e896da0-269a-4954-3116-08de6f08a6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 16:13:28.0847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxH/8FCJJ5yQU8rCzuqhj5n2YwZd9Oh5TciJ0taKwLAwt9RdKZo/mYuPMAbBolCXIRIS8PjT3j5IrUp5cXsfs6S+VhSuilXe1V1BSWBdKpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7324

SGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgcmV2aWV3LgpZb3UgYXJlIHJp
Z2h0IHJlZ2FyZGluZyB0aGUgZXhhbXBsZSDigJMgaXQgaXMgbm90IHZhbGlkIGFuZCB3b3VsZAp0
cmlnZ2VyIHNjaGVtYSB3YXJuaW5ncy4gSSBzaG91bGQgaGF2ZSB0ZXN0ZWQgaXQgbW9yZSB0aG9y
b3VnaGx5LgpJIHdpbGwgaW1wcm92ZSBteSB0ZXN0aW5nIHdvcmtmbG93IGZvciBmdXR1cmUgYmlu
ZGluZ3MuCkJlZm9yZSBzZW5kaW5nIHRoZSBuZXh0IHJldmlzaW9uLCBJIHdpbGwgcnVuOgoKwqAg
wqAgbWFrZSBkdF9iaW5kaW5nX2NoZWNrCgp3aXRob3V0IGNvbnN0cmFpbmluZyB0aGUgc2NoZW1h
IHNlbGVjdGlvbiwgYW5kIGVuc3VyZSB0aGF0IG5vIG5ldwp3YXJuaW5ncyBhcmUgaW50cm9kdWNl
ZCBieSB0aGUgcGF0Y2hlcy4KCkhvd2V2ZXIsIGJhc2VkIG9uIGZ1cnRoZXIgZmVlZGJhY2sgZnJv
bSBMaW51cywKSSB3aWxsIGNoYW5nZSBkaXJlY3Rpb24gYW5kIGRyb3AgdGhlIGdlbmVyaWMgInBp
bmN0cmwtcGFja2VkIiBiaW5kaW5nLgpJbnN0ZWFkLCBJIHdpbGwgaW1wbGVtZW50IGFuIEFTVDI3
MDAtc3BlY2lmaWMgZHJpdmVyIHVzaW5nIHN0YXRpYyBTb0MKZGF0YSBhbmQgcmV1c2UgdGhlIGV4
aXN0aW5nIHN0YW5kYXJkIHBpbm11eCBhbmQgcGluIGNvbmZpZ3VyYXRpb24KYmluZGluZ3MuIFRo
aXMgc2hvdWxkIGFkZHJlc3MgeW91ciBjb25jZXJuIGFib3V0IHRoZSBiaW5kaW5nIGJlaW5nCnRv
byBnZW5lcmljIGFuZCBpbnRyb2R1Y2luZyB1bm5lY2Vzc2FyeSBjdXN0b20gcHJvcGVydGllcy4K
CkhpIExpbnVzLAoKQmFzZWQgb24geW91ciBmZWVkYmFjayBwZXJoYXBzIGludHJvZHVjaW5nIGEg
bmV3IGdlbmVyaWMKInBpbmN0cmwtcGFja2VkIiBiaW5kaW5nIGlzIG5vdCBqdXN0aWZpZWQgYXQg
dGhpcyBzdGFnZS4KCkluc3RlYWQsIEkgcGxhbiB0bzoKCi0gRHJvcCB0aGUgZ2VuZXJpYyBwaW5j
dHJsLXBhY2tlZCBiaW5kaW5nLgotIFRoZSBpbXBsZW1lbnRhdGlvbiBwcmltYXJpbHkgY29tZXMg
ZG93biB0bwpkZXNjcmliaW5nIHRoZSBwaW4tdG8tcmVnaXN0ZXItZmllbGQgb3JkZXJpbmcgYW5k
IHRoZQp2YWx1ZS10by1mdW5jdGlvbiBtYXBwaW5nIGluIHN0YXRpYyBTb0MgZGF0YSBhbmQgdGhl
IHJlc3Qgb2YKdGhlIGRyaXZlciB3aWxsIHJlbHkgb24gdGhlIGdlbmVyaWMgcGluY3RybCBBUElz
L2V4aXN0aW5nIHBpbmN0cmwtcGFja2VkIGNvZGUuCi0gTmFtZSB0aGUgZHJpdmVyICJwaW5jdHJs
LWFzcGVlZC1hc3QyNzAwLXNvYzEiLgotIFJldXNlIHRoZSBleGlzdGluZyBzdGFuZGFyZCBwaW5t
dXggYW5kIHBpbiBjb25maWd1cmF0aW9uCsKgIGJpbmRpbmdzIChwaW5tdXgtbm9kZS55YW1sIGFu
ZCBwaW5jZmctbm9kZS55YW1sKSwKwqAgd2l0aG91dCBpbnRyb2R1Y2luZyBhbnkgY3VzdG9tIERU
IHByb3BlcnRpZXMuCi0gSGFyZC1jb2RlIHRoZSBmdW5jdGlvbiBtYXNrIGFuZCBmaWVsZCB3aWR0
aCBpbiB0aGUgZHJpdmVyLApzaW5jZSB0aGV5IGFyZSBmaXhlZCBieSB0aGUgQVNUMjcwMCBoYXJk
d2FyZQoKVGhhbmtzCkJlc3QgcmVnYXJkcywKQmlsbHkgVHNhaQ==

