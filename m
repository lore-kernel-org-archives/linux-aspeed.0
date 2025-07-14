Return-Path: <linux-aspeed+bounces-1697-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2509C83F1A
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Jul 2025 09:43:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgcnh3BT1z3bsT;
	Mon, 14 Jul 2025 19:43:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752486200;
	cv=pass; b=FOlpY1p89aA+Ip3ycLZywrNTPIrD3IIy43oiDgZ+dA3nYhOWgxNE7aC2JihFXlTugKCMhQnmakNLrD4OD8SbXfTAnCGzutz+emypL/TiA8bP8Ua/Zgfhu0VHkBOlvGZ1MOxrwR+PHRW6QxP5oY7HNaXvgFZbxSRZRb6ixMvR+p+7nEHktUHWRykzWPperYmpNiERoUQE1y0frR2bXffM/pZJ7rd7L1bz55lvoHEWED9Fs4eK0fKhFoOhqXa2PgRptkPP3/meJkHNUspRz8z9Dyj7WR8rZtH6MxnSdtQJyRFf951vUVB/WYSB3PN7mYUE+fMy3axoG29Vj0n4I4WyKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752486200; c=relaxed/relaxed;
	bh=jcgUO57ZBkmYImN8tToR4glhmfi8P5sifvzI89OgIdk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hIAywoqzvmUDt9bXkjlxzQdUokv7Tpz2xfx/5OE2EG0nORnfISAQ1CsB7D4mq3xy+lv2NDCFUCUUKpaKmJ767q/TWTVkXxYrHc1t3y2uCS6lrf49WsPoy+t8YshwFdjE7m3mbPN/fa3vM6KmfX04cttgVEPd0WwBWsespDsu4TUXzTbm04IJomuwlzSvaCKsm22oXghURqnhJhg27eGThKyPfPaIN+HjzecGvGD+LHFEeiyFbLZcnKlq33quAFeDlGpuHr8s8uUp4HywEFV50mqyM6yvwcREqrkwIc4mlJPUWXQkqgiFGAIIXBYVWOVUSOCTwwhuOtYj36xWNxTppA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=mOCHhRjx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=mOCHhRjx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgcnZ2CMPz3bqQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Jul 2025 19:43:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWCr4CxdPQMFhKjvgaPITOJc3NfFU2bFL92+u9YAK+aq6l8StIKp7z7CZeWxycEWIggfolaLzOOqBY9F+bfOeAeCc1Y2sGf8jyXCr1pZ9wtTKuHcupXlFoNmpPHLwdffjqelyzAVmZCzdDOvAsohe4SfjNOUq5LP/bEE5ihQLn1/VCpB7ZkYoSa//oQMBk0T5HW+wgeoNeZlWV+qtQjNQFKqBGdkvKWrKE0cyEkGHDPDCPebNtSZ+OvytDR6in143m14gWVJSKw5UOkqSXngVEphTvElZc+NKxrG5MAfMKKKbusMPGzKL2vsF1aAQXCfb75HzB66KrBNZVT5w22MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcgUO57ZBkmYImN8tToR4glhmfi8P5sifvzI89OgIdk=;
 b=xMWTooxtsqgJWa/I7UXCek6Y9ADEgqw2Ik3r8Y8ajulete0urgZcHvp3AqQVFhvtCn/pTE3t0KWmaXwGMYv781VtpjhPs+ewU/SC56KdaZ52n76LYkvpxxX17xP3vHeBpwp5EwULrAsPm+E4da5k1vRy+QJINmaIrqFCWugqXLJrHIMZrRvhszpvCSKJD7zy106uij+39c+7mo+PmWDX2FpytGZAKA2c3mBj3Vcqlzc0w5lmU1+9sBG/XMBhxetjpMdA9ITsaO8BrI6lnp5ShbIMDCYiW6sptrqvCpI5ediHBC+Lbyqxe7zDu4BkJvyY/UjwaVy4rWRKEP+fiUEi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcgUO57ZBkmYImN8tToR4glhmfi8P5sifvzI89OgIdk=;
 b=mOCHhRjxLWZwvho6YbZqmrSyK8yeHKRX2pzJDbQqyOQVAjP4vNgUGKE87mWsn6XBJaDaF6o/exR5NvKRbxJeJKBfN5YVBLASEAJ3AHPbuguiz8WuLAYb3icbOnpS//6ysWxs8vnd5l4qxCLfGdTTIJTj4JfPXDMmXL9o1wFQ/NcH6NP3O03Mo8an51R4td8DWlKfz4Gyg2iN0juBQgLMFsXRFLNNZOzwG8L85pA+/KReXs0UIfPm5ABE3X8Tj1+4Zsfd9/rQLuFEguVXnxnb1b7Qa/dOLmh5P/6o4L9Bkwyv6ALerwOGoyciBUtVWQRN5PTy9WrGw81/dk0A6JdotQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KUZPR06MB7988.apcprd06.prod.outlook.com (2603:1096:d10:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 09:42:49 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 09:42:49 +0000
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
Subject: RE: [PATCH] dt-bindings: interrupt-controller: aspeed: Refine AST2700
 binding description and example
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: aspeed: Refine
 AST2700 binding description and example
Thread-Index: AQHb9I9tqIdo1qY+RE6/4ZVqCmo217QxNp6AgAABBICAABBdgIAAAEEAgAAVtjA=
Date: Mon, 14 Jul 2025 09:42:49 +0000
Message-ID:
 <OS8PR06MB7541AD942F53B16C7A6EBC05F254A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
 <b500647b-31b6-40c9-be0b-1640dc271375@kernel.org>
 <OS8PR06MB7541C0330FDE855FDD360B68F254A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <57c0d48d-1484-45df-a99d-11388b6efdb1@kernel.org>
 <6685da47-748a-4d90-ba1f-d7bcf82e8677@kernel.org>
In-Reply-To: <6685da47-748a-4d90-ba1f-d7bcf82e8677@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KUZPR06MB7988:EE_
x-ms-office365-filtering-correlation-id: c0e427fa-18dd-4ae0-13dc-08ddc2bacbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1VjMXJKZ01IRkR3WWFTZUJya012M3Npb1k3dHZpZlFJdHBLZGwxQXNDNWs4?=
 =?utf-8?B?UE04VVpIVVMwOFg1VUJQSUloMVI4STJTaTlJZ3JUSnByMExJaGRGSXQzZWxs?=
 =?utf-8?B?Y1ptNldaejBQSkN2RkRkU2hITWhrWS9lNGNLSjFyOVVjejcvcFMvMW1QYkhy?=
 =?utf-8?B?VnhJWkFzTHlyMUtKVTFaZG1NejZxVDAxS1U1bEdYZFYzZnNzNTBQb0UrQ3A0?=
 =?utf-8?B?R3psaGt3ZXVwTldEYmJkTFNNTSs3SHFmNTlyN1Vubkk3c1NJMyt6ZXJrV24y?=
 =?utf-8?B?aE1DQlpMUUN0Kyt1bnB4azVUV3EvQjg2dXlLcXZTVWtJS1Vjams3NWdsT2Jt?=
 =?utf-8?B?UDBITGJBaFVuZ0FhYldiMjhCT1NxaG1yM3h1MmRWQ2k0MVB1MjRTbGxNYWFz?=
 =?utf-8?B?ZERNN2UxZTBqNEVDUWplYUpNUk8vVGxhNXZyYzIxOThYSVZyUmIyWHUyN0R0?=
 =?utf-8?B?SlVxZWhoVEpoVUxTQThYUzJITVBIQm4yVzB0aUxPMzRPeHJWRXlxZmZsaGFz?=
 =?utf-8?B?S2lONk5kRzBvRDVuVFJkanlmZ1FabzVtNnIwSkFTT2UwRk02Ky9xUEFMZzhJ?=
 =?utf-8?B?MzE1SGJtNThybGNMdlpQdmRIWnVRWkVmdTc4NnVtN0JjR2JhSHEybDdCUWZj?=
 =?utf-8?B?NmdlcFIyTmp3WUJzb2ZBbThYNEQvVG9XR001czVnRllDUk92WkMzaU5laTM2?=
 =?utf-8?B?NUZZN2E0cDFrcnowZFJCL1FLcnFXa21tM1FleTRoQXBiLzZZbnh5di9rMGlh?=
 =?utf-8?B?WkNyNWx1Q3drbTJDTDRJNWV5VWY2TUtuaXd5QXVtL0VsUWtSQlI1Y0szM0hD?=
 =?utf-8?B?L1pQMmkxTTAvMzFxeHZPMnJuY05VY0pwZnZ4Rm5sUmNhaHRoNisyREVDYkNZ?=
 =?utf-8?B?Uk1PZFZwWHY3cDZpT1FqZzBVNnJWWHh0OW0xWExvZ0kvdDVJYUEyVnBPQjVV?=
 =?utf-8?B?K1ZoODd3bUxwcHU3WUhUZFNmMTBWSGZTMDVReDFFVEdyanhvTW9aNU55KzNx?=
 =?utf-8?B?S0JsV0JDMUhsa0s4VlMzWjRoaGVvMFFjVlMxQmFVdHVuN2xOUHRObVdSUUFx?=
 =?utf-8?B?b3NlNjRaL0FEQ1ZwOUFtajJXZjNlUjlXOWUyVWsxck5tTlJhbWZldmdpeU1K?=
 =?utf-8?B?dFVnL3dyOFBrK3FDcWo4QUNRRFhSVkFCYm0wSGpINWRhOC9FKzA1MlQzdzlX?=
 =?utf-8?B?enJlVkp1R1lKUWt2dTVMblpLa2p0a1NNQ0VJSHJhcnBXRzY2MjkvaTJjUDZU?=
 =?utf-8?B?UElxSm1zdWplZ2puU2h0RmV6TTlHeVdTYjAxeUkxejF2WjUxdkxVTjR3YkR4?=
 =?utf-8?B?NDRHRks4dHhYVHpYdlV3S2E5aDJ5WFNGRW9PMSs2MGtGRWZMeFJCclFYQ0NI?=
 =?utf-8?B?SEdRR3c4K25rR1lTbVExb0FueEtTdkdCYXZoWCtJZFlNKzJDc0JoSnV6UDVp?=
 =?utf-8?B?Z3JEWFlTOE9SNjlQZ21hTWN2NU9vL3EyeG1TRzFodFlhV3VwVVFEMm9rekJO?=
 =?utf-8?B?ZXhGZjI5WUYrS3A5QThzMTZZRTVFSjUrektTMnYyY2VPTjhIanEvbTN2d25m?=
 =?utf-8?B?OGFhWDg0RWdwVk1TclZZanEwS0lWSWRPZ0FVWXZDOEFTc1BZOGlkU21kOEVm?=
 =?utf-8?B?SEpVRUd1TENubjVSUHVCY3FWeXg1NHVjb2FMZGs1emFLSlZvU3IyS3Jia2JB?=
 =?utf-8?B?eW1md0ZIR1F6MitaeFJXS2dYQys5T2s5Rk5VazB0TTJVUXlCY3NnSEdNTGlF?=
 =?utf-8?B?V2FYN1daK0RITVZ4V1NGdGtwMzFReEpUYjBLOU90SlZYanV1b0J4bGdaQk5i?=
 =?utf-8?B?azRNVDFjN21lamlValFOVkRZUlhYR3hKWTMxRW1QZ3pncFN1Vk90VXd6WGpj?=
 =?utf-8?B?RUdSTTVTU0Jud3hJdGYzdGJaVWczVTM0RnpzYjBUWUxDM1FnaFRDTlNaWW1a?=
 =?utf-8?B?NDJlcFpWeHZnQlJBajV6QlhrbTd0UkE0RjEyck1CR3liekQrYlhxVUd2eDZT?=
 =?utf-8?Q?IZBpQKDsjXzojRjc8yT36mL6NtZNJU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXV0NjB3c0RiYjJWWGR2aTl5eXBjNkc4QnJ6ZTBaNDJ0eFd5b3RQeDNKQmJU?=
 =?utf-8?B?VEs1OGs1VVE1WjZGOFNtODlsdE5HTWpaS0Z0czRIMkp2Sk80bVZnZGhDQnp5?=
 =?utf-8?B?eDFRY3VVcDJ6WkZIbmFNUHE3TTF6TWJPQ1NUck9Mekd6SDVlL1lHSXZFSG5n?=
 =?utf-8?B?a2ZrVXJmRkpkRkczY25kNm1Db2xLRUlURzFjWlBmWG5ydG12VDZrMHhNODVR?=
 =?utf-8?B?eHpKbnh4NXlhR2kxdGhoWEF2OFBEbDdIcyt2cHRETHJmaWdGZ1diN3NENUs4?=
 =?utf-8?B?TGEvcVU5bVNKM0QzRldXYkZwU1c4K3FST1gvNnVOb0djVldiczFkR2pWc25z?=
 =?utf-8?B?dVR4QUs1YjBhZkxVd3pTOHJhaUpFaXU4R1Fodm9SRDZQbHZoUExZSjZ3aitY?=
 =?utf-8?B?YzdoOXU4dUtWQ204cHJ2KzB0eTZreGVjZWl2YWFTN3dTVHJpNG93OVNXR1Ba?=
 =?utf-8?B?aHF1RXg1M0Z5OWJsSEp4VWRxVStLV1NzLy9XUk1yVXVwNmVGdVc0bnd2ZElz?=
 =?utf-8?B?TDVNVlc5ejVJY0F4czYwdk5RUWhUd2FuQU8wWG5LWURMYTFON080bktJUXdB?=
 =?utf-8?B?NFk0bm5vbXlGOWFha1pldEs4MDI2K2tOQ09PY21HeVpJZTdjZUZzejgxQ0ZD?=
 =?utf-8?B?WGtlUHRHMUpuSzJlTHBRcjE5YUpQbncrUUhRMGkzMEE4cmVSTWJETWNrSGtB?=
 =?utf-8?B?YkFnSElseDNZc2R6dCt1NkUreG9yZ2ZlNXRoWjVoTWJ5NkJsZWJ1RmY1bEFp?=
 =?utf-8?B?OHFVWFBWVFN5Z284SnFZbjl1NTZTSDl6dENEQTFvcUd4QXBJbm0wdnNjbE8z?=
 =?utf-8?B?QU85SmE2VTFES3dzb1pnWmVnQ3V5ZE83ZXdHSjFPSlRkQVZ3VU1yTmNjenlr?=
 =?utf-8?B?RjJoOGhKSmF3WHdwV0x3RzdLYmlVMnhod1FrNDNiWWkyNCt4Yk5Dc3dDeWw4?=
 =?utf-8?B?aVAvTCtHZzg3aEJaVkJHM1laYlk5bG9yKzFqOWJTZkxKSlNYVXZIWTF3Z0Yw?=
 =?utf-8?B?cWlma3c0aXlNUUhTMnAzZUw2L2xEcW54NitiK0c5YXkxVEV5UUZ1a21nNlZa?=
 =?utf-8?B?TDU0d2c1VUg0aFFWWmV5OHJZR1hWOHNxMmFYZDYwSk1NdHhrNXRIditzbTN0?=
 =?utf-8?B?a2ExcE9BcVJOTnRsSmIwMnUyUmVIcUI5N2ZtSXY2MGxWWmo2ZERabWhtWU0x?=
 =?utf-8?B?UmVhRU5CTElPenMrZTBTRXVZRjBXckRhL09JYWk5dnhTR0lSRUIxdUtmZSsx?=
 =?utf-8?B?aGRWcDhtUEpKSGJtVHg1dkFORXlmclh0TWNkdmRmdm1DV2FCT2FNWVhrV204?=
 =?utf-8?B?Umo2b3hDdmZyVzBNS09LQit1MGIxUkdYRWVkWStWNzh4dXhhMFcwUWlSMjlz?=
 =?utf-8?B?WGJxMitTRUVTbXg3TnNibS9uaVNBQ3duWUhONzBQT1BZYmc2eGJHTERrSzJs?=
 =?utf-8?B?Z2tVMXVJby81eFdyV08vTVh6cThTVDBJMmdPOVEzUTBKcXhIMjEwbXdMb3dw?=
 =?utf-8?B?QWtNWSs3M1dtaTBmUmRjbE9sYVBSVUk2YUVDWHY1allORVk0OHB2UkthNGdS?=
 =?utf-8?B?akxNdXRmVElxekgrQzlvVnlaeU1YWG5QckVzRFQvUG9kc1ZKSHZsRkQ2MUdl?=
 =?utf-8?B?ZnVNVm1QdmI5U1BkK1M5VXRLVUVnZVRkbHlQUmFTRXRhd2dyUmgyYUhubUd5?=
 =?utf-8?B?QnB6bHAxSTFpZTNxNm1jNEswUHp4OEVzdlVYZEUyYTdqZ3NBUUFVeTRmWE8r?=
 =?utf-8?B?ZVdLcmZteEY3djI5b0laMjZVM1pGZzBneHE0WXFRNjZnQW5vWkMyeVBnd3RO?=
 =?utf-8?B?VjJvOFlDR2xpWEViTTVZSFQrNHB5Mm0zcFhIWWl3R2lzZDNjTnd3VXdXWWtK?=
 =?utf-8?B?ZVFwMkk2aUdpKzlDdGRFQ1lrSXJrRHZmMmgyL2NyTHcxNk9Vam5VN0c2L0M1?=
 =?utf-8?B?ZFhteTcyUnI1Y1I3OWdacXhxbThKdWkxeXFFNm5jT0xkWXMreCt4QkZsMGhr?=
 =?utf-8?B?YkgrOGFFTGpoOTkrU2lOYVVCR3lmRDhITGI2WUZQYXh0VXpzQlZXSTNOSG9U?=
 =?utf-8?B?ZTNJQ3BFMEpMeU02aHg5Yk9LZmN1cDM1L2RGTEkzTVEwbFZWRUJMUDBCNXpp?=
 =?utf-8?Q?6if7OHpK2+2hgsiBqCaRWrZHG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e427fa-18dd-4ae0-13dc-08ddc2bacbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 09:42:49.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAaJ9Skea1abREhRY17vd2mNKGn20WxgoQ2wCxY3LAFhyjza7rwpm9ZxWXxxgYQwWnFplz4IQX2a8JpG065h8KjMmzIM7sKVeqISirVXhO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB7988

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6
IGFzcGVlZDogUmVmaW5lIEFTVDI3MDANCj4gYmluZGluZyBkZXNjcmlwdGlvbiBhbmQgZXhhbXBs
ZQ0KPiANCj4gT24gMTQvMDcvMjAyNSAxMDoyMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToN
Cj4gPiBPbiAxNC8wNy8yMDI1IDA5OjM2LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IGFzcGVlZDoN
Cj4gPj4+IFJlZmluZSBBU1QyNzAwIGJpbmRpbmcgZGVzY3JpcHRpb24gYW5kIGV4YW1wbGUNCj4g
Pj4+DQo+ID4+PiBPbiAxNC8wNy8yMDI1IDA5OjE3LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4g
LSBVcGRhdGUgYmxvY2sgZGlhZ3JhbSBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5IGFuZCBhY2N1cmFj
eS4NCj4gPj4+PiAtIENsYXJpZnkgdGhlIHJlbGF0aW9uc2hpcCBhbmQgZnVuY3Rpb24gb2YgSU5U
QzAsIElOVEMxLCBhbmQgdGhlIEdJQy4NCj4gPj4+PiAtIERvY3VtZW50YXRpb24gYW5kIGV4YW1w
bGUgcmVmaW5lLg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBlbmhhbmNlcyB0aGUgZG9jdW1lbnRhdGlv
biBxdWFsaXR5IGFuZCBoZWxwcyBkZXZlbG9wZXJzDQo+ID4+Pj4gdW5kZXJzdGFuZCB0aGUgaW50
ZXJydXB0IGNvbnRyb2xsZXIgaGllcmFyY2h5IGFuZCB1c2FnZS4NCj4gPj4+DQo+ID4+PiBDaGFu
Z2luZyBBQkkgKGNvbXBhdGlibGVzKSBpcyBub3QgZW5oYW5jaW5nIHF1YWxpdHkgYW5kIGlzIG5v
dCBleHBsYWluZWQNCj4gaGVyZS4NCj4gPj4+DQo+ID4+IFNvcnJ5LCBJIHdvdWxkIGFkZCBmb2xs
b3dpbmcgaW4gZGVzY3JpcHRpb24uDQo+ID4+IC0gYWRkICdhc3BlZWQsYXN0MjcwMC1pbnRjMCcg
YW5kICdhc3BlZWQsYXN0MjcwMC1pbnRjMScgY29tcGF0aWJsZQ0KPiA+PiBzdHJpbmdzIGZvciBw
YXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIgbm9kZXMsIGluIGFkZGl0aW9uIHRvIHRoZQ0KPiA+
PiBleGlzdGluZyAnYXNwZWVkLGFzdDI3MDAtaW50Yy1pYycgZm9yIGNoaWxkIG5vZGVzLg0KPiA+
Pg0KPiA+DQo+ID4gSXQgZG9lcyBub3Qgc2F5IHdoeSBpcyB0aGlzIG5lZWRlZCBpbiB0aGUgZmly
c3QgcGxhY2UuLi4NCj4gPg0KPiBBbmQgYWxzbyBuZXZlciB0ZXN0ZWQgOi8uIEkgd29uJ3QgYmUg
cmV2aWV3aW5nIGl0Lg0KDQpUaGFua3MsIHdpbGwgdXBkYXRlIGV4YW1wbGUgYW5kIHRlc3QgaXQs
IGFuZCBzZW5kIHYyDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

