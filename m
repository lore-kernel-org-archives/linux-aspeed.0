Return-Path: <linux-aspeed+bounces-1693-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2045DC83F17
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Jul 2025 07:37:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgZ0b3Nywz3bsT;
	Mon, 14 Jul 2025 17:37:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752478655;
	cv=pass; b=TQfHjziuAZRPlgLapK5PwBWiRPqTJiOADblW15aODtTAzrF7mNzknU6Aq4zotllqoeP81PgswcbN9q4jZ/LpSwG8RZ/NjNbO7rXXf0DGuXtBJu4nTxXlkO+RA3viCZDZhU0ySk88sQgU77xNosIxQzOkDoYkC5uIQI25TIwTp93Za9P9bH45y4WhFp2gCHIU1KTGBrJcqsxZwEPr4mCMwQtdeK7aH+r/dtdCvzmmnxMkD5ZQstOcnQtEbJL2QXBaSN64FJ9gU7h5GZ6d/px2dl/Umq3L6+zRDgvUoo1Ps9Zz913sYYcsWQMI6AuFbJIhtAv53+JMglFu8PKxBPr/kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752478655; c=relaxed/relaxed;
	bh=WQFn56JlcJhnGjpusujw37MWqXubn2yhQiT/wy1P4nU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgcGWSXeGCtfaml16yDmKZ6xlkl/YLHrohvEI3tJ7ASy3lK4Yq8LvUrQ5g98/gGw7xMJLwuIch8kOqKfM7ramhvGJWnd+sZrgEdf9Mt5v0gWKehYWYguHCp9wc55UAr++xNc1uyrFDDnlOWO2tHqvHvBILfy5KP5CbSTMC3CTwPZyh6wYcI2AkdldE+PGw1WTF0qs7zlGNHlqCgLh3FdMnlijG/OZSZ1DGryLNoYkOjJO8jLPgbObgPJVttIj86tfipwOv01e1K3FJGd2R6OkhbGavb93yNMSaHDkChY1mRIpINBEjQIzR3bNCz6TqrOXjcQWPBMc/aIpot9aoHkgA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgZ0P6jWrz3brM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Jul 2025 17:37:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hazJK/RFBm1Lkbnvis5pP8nwWccqLjDja4Vvi9e62PF6DlwXgFBgOGMOzinzRLcOSmeOZIIB3nGg30rXQ4HG/vQISBHyHHNJ887NZMvHtD7j8lS4EkghoSyznyu5nqSq4fp3VXGKAY/xrGNbVfEzB+ZBFhIbg4SRt/VBkz0rkUlmKOvH0rBnUhadK9RfjPBYDp9nPtOy2K0mamApTtow2VwekqIPXAH6tEX6FPoFjGmBdaGOZQWF1NOcxTbO3eZMvnv09tU1NvQzGQ+yB41gJPhjBUhf44ZrDOx94bsZRwY6hafmBOBUiAzCfPOlbabNVMxkh5fqd2M1MeUr5mEPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQFn56JlcJhnGjpusujw37MWqXubn2yhQiT/wy1P4nU=;
 b=RICEt/OtaNf1tH+QfvzLrrJsFWT5JM0wVgkQq7Guvk0MHpGU99TYspXZbKGYSqXNAYO5F0yTTa4Vf2x5Ts0F62pDee3CYsrk8yO43S1iz/VY0fLfNUFV3EJoXHwCu7mKO8b6pyRoJKLc9aejREGRd0Adv4L8w0fs4iUsTXKqgOtUTfET4uQNWfVGkPN67yBbwgG+gouWpTNcHbJtSdrVKDQ6RRxkiX0X7DB5sgOqrFW6pvQLbfbu64g55NEJJyM8urDkz8NgzouTNNKZLcGDxpbChhB/XFnVFojSD+M/QpTgMa84E/A0AiIRWfmo19byOXZ6x0FFdlEOXatjqhh4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQFn56JlcJhnGjpusujw37MWqXubn2yhQiT/wy1P4nU=;
 b=pG22jX9IebucXkvHOoorRLnhQzgP2Oa4r06txZFXnO5UNNSVOISdcRyXG0rEg3/sptDdnzuP9XL4L2FOxZQDJAxvsVU0/FS1PgBFa0lXfDCGDqFuARPPJrcL+gKbL/23bMhMwQi95YouRWGEKnXKLL15Bl6kuXLG8pEQl6IZuHLcfihgx4H0MYdE//lblipW0e/bd45dw17kZ4fn1nU2wz/r5iiA9+mYtgQGHKPsM3cRsM0XTOI9MqG8nONzsmB8ZOQ/q3VDtzVhUSml0SW5UjR7E2B/+KFMSk+V227kXRBp8F1+FLGKgCsAxrvKcnbesi7UFc/VrScaJrjI0r4qVA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TY0PR06MB5496.apcprd06.prod.outlook.com (2603:1096:400:267::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:36:59 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 07:36:58 +0000
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
Thread-Index: AQHb9I9tqIdo1qY+RE6/4ZVqCmo217QxNp6AgAABBIA=
Date: Mon, 14 Jul 2025 07:36:58 +0000
Message-ID:
 <OS8PR06MB7541C0330FDE855FDD360B68F254A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
 <b500647b-31b6-40c9-be0b-1640dc271375@kernel.org>
In-Reply-To: <b500647b-31b6-40c9-be0b-1640dc271375@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TY0PR06MB5496:EE_
x-ms-office365-filtering-correlation-id: 605ede5e-19b9-42cb-7efb-08ddc2a93744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFJJR2JsZkhjMWFOUndxaVRRa29WdzJmajNTYk5FM2ROOWhEM3J5bjVhQlQ1?=
 =?utf-8?B?SWU3TXVvSEgxRStkdzFwQjRlN1pvMktla1gwd2preXJDZGxGOU14bnppOEFz?=
 =?utf-8?B?TVY4eVkwcTNvRit1RHVhcnVJRGVsbnJ5eEN2UmkxYitNRU9YNFFMLzRnazd5?=
 =?utf-8?B?YUo5OXRuRTBzRFZIdVFQbVFxL2xEdGpWVlF1Q1BTQlJxZytHSHZFamFRbFV5?=
 =?utf-8?B?SG84N1pjdFk3aWxHbVdjWVIzZEh0aE13enhtYVoxOHFvNS81VWtSMVdhakJa?=
 =?utf-8?B?NVM4dDFiVUVkclNwS3RPNmwxZVMwZFdJd1dVZmE5TmFBVTFLaXpFUlNGS1E4?=
 =?utf-8?B?SDk2bnQxVzlId0xlSFp6Ry9sZ1JiYUF1bm5nTytTdTRzdXJRUkd0L05TUmkz?=
 =?utf-8?B?cG0yeHdlNUI4a0d5a0UwZklJdnVad1c1dkdLMy94YWYybkRCMFFhczBzcU95?=
 =?utf-8?B?bUJ6K3hoUzJHREc2ZXprdkJ4ckVETnY5Szh6MGJIcFFzcXVUZTZDLzJMbVo0?=
 =?utf-8?B?dUZ6NnFTUFBiUXpyZ29pcGFVT0hMWW5USXF4K3phV3FiSzBJd2xoa1NqZGRU?=
 =?utf-8?B?dXdpblUwOTZ4Nzdnb29Nb01jVVJWeHpmbmdoWVQ1dG1oK2k1a0QxeTJQWDJ0?=
 =?utf-8?B?eDdFanFWRzA4ZGZINGx6RjBKWnZJQmJJMEN1NVljRHhlTzVXc2ZVQ05STVBa?=
 =?utf-8?B?UlhGayt3ZCtNU2h0QnVzaXpuakZWNk14Sk9PUVd4NXovZUZxMHFlcXlkWUk5?=
 =?utf-8?B?cVFxN3hUSGZ0Rk9waDZZN1o1aU45QVYxYzJaaE9heDI1cXNsb05FRU93ckpQ?=
 =?utf-8?B?ejF4dXNVcFNqNmhYb0Zad2JRVHlYbXpRNXpSR09JNlBoNDF5K0p3T0trWlVu?=
 =?utf-8?B?a3hDUlpQM0ZXZ1lIc3NzL0kzdjBOMXY4Slpsb3FOZVQ2eXNTU2xqM1hSVllF?=
 =?utf-8?B?ZEdMWUtmS3VQQ0V1OXF4QkliNlQ2eFVWeVUwMFNvQUpOR1U5KzBYMmQzOVNF?=
 =?utf-8?B?L2h0YUhhSjZvTjQzenFuOUFFUEoyditPbE5sWU1BSElaN3J1NzJDaGR6WXNN?=
 =?utf-8?B?U0dJSFJmcDVwdzBPYUowKzJvMk5oKzY1dExIMTBDcHNEZW5DbzJCM3JUREZr?=
 =?utf-8?B?YVlhcklFRnFwNlZaUmsxSlpiSWJMcFdmYjU1Tks3enlRQXM0RlhZZVJMZ1RD?=
 =?utf-8?B?Yk5UMGNTV3hFeXNFN0h1VzZJNWdHVDVYYTdnTmx4L09nekovQ2xEMVRKT1Uy?=
 =?utf-8?B?ZHZMSTFTUWdQblA2RHZja0JxUlc2TWt3YmhWTzVyeVJlZU9xK0N5eUM1Uk1a?=
 =?utf-8?B?OTd5akhRcTM0dlJvT21STUwwenpRbVdxcCtOekM4WGdnTFQ5TmY0ZFJHRnNn?=
 =?utf-8?B?MGp0QTRQWVFveWYwZ0wzdnhiRUtVelFLZGR0YVJ4anJGRHFHNnZvWXdoWDdF?=
 =?utf-8?B?QzYyK0xoaTRZRTVrNUNiMkx4aEl6dE1NZ0tRanQ4RkNpSXVuRThxTVJ3cU9Q?=
 =?utf-8?B?QnJERUhzeElobkg3NEdXYWZPR3FQUVI3bDVzakRJWXJsNzM1WGNFRU05bmtK?=
 =?utf-8?B?SnVoOTlDaXhpVC8yaWF0MWdKclhjbzcyTlQ4dWNlNlZlOTN0R0ZlaElNWEs4?=
 =?utf-8?B?ekx6SEM2MWFXSFdIdDMwVXY3dmtibHpPdlllMzhBTHJhbGVVREpQU0R0Um5I?=
 =?utf-8?B?d3VNSHdQM3lFRTRNb3lHY2MrQ05SZEducE1sV2NocDIvTDJlZkZyOGxadUhC?=
 =?utf-8?B?bjNOdTV4WER6U2dZcGxnYlRlc2FWMVA4b3VKSEtwYVBvSlA3dzVBdm5uRVc0?=
 =?utf-8?B?SzBXcnpBak1nZ3RrejF0L0d6c1JvZ0xUbm5QVWZWbDRjY1BPSWNGdHUrQU03?=
 =?utf-8?B?Mm1mL053aGNiL0JhUE1vYTZuWGxuZUQwRnY1dEExZkQwUVFJdUZnVy9Oa0VF?=
 =?utf-8?B?LzZ5NWJNK0FnTzkxSVIyS3dGN2gveXYwM3luVFNiL1dxVG9xYXZiVWhIeTVw?=
 =?utf-8?Q?HdLyNER5k7CP5PYNElsiQSzCASRJEc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QndHL2hEckVRZ3Q0VTN3OU02L2htWTBlSytmTnNyZ29pTy9ZZ0lwcGV3c0xm?=
 =?utf-8?B?R1F2OElITUJoZncyOGxzK28xRWR1RGJaeHRPMWd5VVBSZm0rdEtoeDZrNndk?=
 =?utf-8?B?TE92T2lRMzVCVE5JaGdKN0cyYmV4V2J5enloN0luVVoydnBjS3dMWkVqdi9n?=
 =?utf-8?B?MkJpY283aXEwalU2YldUNUxVR1VGUGh4NEtaYzZvNTNLZFdrYVBtR2o3V1RR?=
 =?utf-8?B?WWVwTXo0RGZtRllDUmc4aGpTQUFNQWxuZFd1VjNTNi9YUFpWTnVhVjViU0Jk?=
 =?utf-8?B?TkFTUlFKcXdMaDJDRFlUdFlOUEMyRFUwRUdaa1NqTFcxZlAzbmtKdHFDTzFP?=
 =?utf-8?B?ay9nUUJNVnYxUHpxclphaEpwcUlXOFZmRFo2NGd5SUNWSEZwWjNVYytaT3JI?=
 =?utf-8?B?d2hVc1NRTXQzUy9KQ3VnMHU5L2pTYjZCaUk0eU9CNHRRT08yQlhkRUtiWW5s?=
 =?utf-8?B?MDlqdy8reWRDbWIySDB0TkF6amlad2E2ayttUHRrYzQ5aWNTR3FtMlkvc241?=
 =?utf-8?B?Wi9EUnJGOUdwY3JMY2JJTTFNUmJSOWFiQ0tVMlRDcWFydEs3V1hnMlBvdWF4?=
 =?utf-8?B?cEdZRzg3bEtzSHFUbi9wc3VMcEdnWm1ZbnpwWnlvUGJvZjFPS3RzcFYrMk92?=
 =?utf-8?B?V2xZSGdieVBoMDFVaWN5VVpKMnE1TEwyWUVrMnd2WllDdXNiRHBMeWM0UEIx?=
 =?utf-8?B?TXRUbS9UVm02bFJJQlNhMlFYWE10UUljRVFSRXMwNkJuMjhjTjZ1ekRMaFVa?=
 =?utf-8?B?UWhXK1psdUszZko4a2N3Z0hJRDVmNWZOZUlHUTA5VkFHSTVhSUVYRnBQSlVl?=
 =?utf-8?B?dmEwNFQxMitOYjdGQW1ZS2t4UURMM1dRMk9YQXk1ZXRCb1dPeDE0ektLdDNy?=
 =?utf-8?B?dGRIR1NnT2U2QTVyNGhHcE5TN0tzbTBvd24zRWlOZ2VuMUQvemdLdEU3VEJV?=
 =?utf-8?B?RE9kci82dVYzMzlDb3oveEc0VS9Ub0NCenR2UUs0WGlFQU5EUnpOZ2VUN0NB?=
 =?utf-8?B?aTZGUGZCNHdtdHhsekhZc1BhanJHNldxUWNjMUZyYXByMUZOekdTZStkQXMy?=
 =?utf-8?B?WVlQeUZmUFZpb2FtdWpWUGhHemJ5ajhTRVQ0ZUgzeXhhZkhoekhpc0tOQ2hE?=
 =?utf-8?B?Tzd3Q3BqL1FGK3dCTW9uSm9Fa2JlMnFDNXlIeVRyQnVWbUhzdTlmTnJINFRr?=
 =?utf-8?B?Znh0dnpNNW1hN1BwSDRDaDVqWXdpVTh4N3krc1U4UmpFc2tVSnRpYzFWaDJm?=
 =?utf-8?B?bzRRNGJxQjdmRnhHK1VvR2piZWI2aDVRblcwNVloV1VYLyt1cURhUzd0T1Js?=
 =?utf-8?B?MnBBUVZNNjVrVmhLL1pTRWRuUjVnRmNuNk9kNHdwV2VCa0NMa1RKNkt0M21X?=
 =?utf-8?B?RkJ1bzJ4eDZCTlpaRlFTTDA1ZTlPN2xUM2xlbm5pcjRIclVVbW42RzdKaWRT?=
 =?utf-8?B?SnFjZTJYRWhBZ1MxMFdacm80bHd4Z3g0bDZmTXNqQjZ4VkZsaUJNNWMrZEdp?=
 =?utf-8?B?azRKSUFCNzVTWTN2UTJvZWptcnpROFZoZWFrR04vNHFTU0Jtc2hENmVzNjEx?=
 =?utf-8?B?cjdnOFgyc21PY3g3Z1JMUVV3NTJjdmxCRWVYZVFmanZTbjAvOTNrR3kxbjNz?=
 =?utf-8?B?dEJPbGc3a0dmS1B1ZlhKTUl4RGg1cUZUVEJBOVR3WG9SWGhnMTNTNmNzRFdj?=
 =?utf-8?B?ZVhzMmpJTDgvalRITVQ5VHprTEtpcXNpdEl5UEN3R3c2SG5IOTZrM0k0Y2k0?=
 =?utf-8?B?UUdvcXBaR1NGOHFCS292bC8wdCs4UUJPUXVhRitlRXBQTk04N0xvK2xhbGpO?=
 =?utf-8?B?azFJZkQyc1JQVEdqbldWUkxRSVdBYXJGYWw5cGxqRmFldGhxSjRjb1FnNkJH?=
 =?utf-8?B?WnQzaWFmSUFRU2N2NjhSWjFwQlBOMjRGSUloYjNyeGg5RHdzS3lISi9BTVla?=
 =?utf-8?B?YVZXZ0YvWTlidUE1UXdkdzQwdUhKOW9iTVNSYnJrTFd0OXE0R1FBM2t0RzY1?=
 =?utf-8?B?cnplY3hJUGd6cS80bHZ6byt5L1VHYXorWnh0L1NTME44c0h0cytvTXlybGpO?=
 =?utf-8?B?K21QTmEyblI0Z3JFSU1aUUc4QmhwTldoNk5XUWJaeWhyZ0NkUmlrQWFtWnBV?=
 =?utf-8?Q?vIMrFjueTQgDSUeUIpYfq0qFV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 605ede5e-19b9-42cb-7efb-08ddc2a93744
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 07:36:58.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guHHEC8DsdftOR5Q9SxLSakZFoprHwEMCd6khN9VghFcKXXf2waaDafPzHfhk5aLlPC/tLZuv1/MC6zDVB100Pr7JK4EcOFQZkdoa++GKv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5496

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6
IGFzcGVlZDogUmVmaW5lIEFTVDI3MDANCj4gYmluZGluZyBkZXNjcmlwdGlvbiBhbmQgZXhhbXBs
ZQ0KPiANCj4gT24gMTQvMDcvMjAyNSAwOToxNywgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IC0gVXBk
YXRlIGJsb2NrIGRpYWdyYW0gZm9yIGJldHRlciByZWFkYWJpbGl0eSBhbmQgYWNjdXJhY3kuDQo+
ID4gLSBDbGFyaWZ5IHRoZSByZWxhdGlvbnNoaXAgYW5kIGZ1bmN0aW9uIG9mIElOVEMwLCBJTlRD
MSwgYW5kIHRoZSBHSUMuDQo+ID4gLSBEb2N1bWVudGF0aW9uIGFuZCBleGFtcGxlIHJlZmluZS4N
Cj4gPg0KPiA+IFRoaXMgZW5oYW5jZXMgdGhlIGRvY3VtZW50YXRpb24gcXVhbGl0eSBhbmQgaGVs
cHMgZGV2ZWxvcGVycw0KPiA+IHVuZGVyc3RhbmQgdGhlIGludGVycnVwdCBjb250cm9sbGVyIGhp
ZXJhcmNoeSBhbmQgdXNhZ2UuDQo+IA0KPiBDaGFuZ2luZyBBQkkgKGNvbXBhdGlibGVzKSBpcyBu
b3QgZW5oYW5jaW5nIHF1YWxpdHkgYW5kIGlzIG5vdCBleHBsYWluZWQgaGVyZS4NCj4gDQpTb3Jy
eSwgSSB3b3VsZCBhZGQgZm9sbG93aW5nIGluIGRlc2NyaXB0aW9uLg0KLSBhZGQgJ2FzcGVlZCxh
c3QyNzAwLWludGMwJyBhbmQgJ2FzcGVlZCxhc3QyNzAwLWludGMxJyBjb21wYXRpYmxlIHN0cmlu
Z3MNCmZvciBwYXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIgbm9kZXMsIGluIGFkZGl0aW9uIHRv
IHRoZSBleGlzdGluZw0KJ2FzcGVlZCxhc3QyNzAwLWludGMtaWMnIGZvciBjaGlsZCBub2Rlcy4N
Cg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9hc3BlZWQsYXN0MjcwMC1pbnRjLnlhbWwgICAgICAg
ICAgICAgICAgICB8IDE1NQ0KPiArKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDExMiBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hc3BlZWQsYXN0MjcwDQo+ID4gMC1pbnRjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hc3BlZWQsYXN0Mjcw
DQo+ID4gMC1pbnRjLnlhbWwgaW5kZXggNTU2MzZkMDZhNjc0Li43NTFhMDdkNDljOTAgMTAwNjQ0
DQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJy
dXB0LWNvbnRyb2xsZXIvYXNwZWVkLGFzdDI3MA0KPiA+IDAtaW50Yy55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2Fz
cGVlZCxhcw0KPiA+ICsrKyB0MjcwMC1pbnRjLnlhbWwNCj4gPiBAQCAtMTAsNiArMTAsMzMgQEAg
ZGVzY3JpcHRpb246DQo+ID4gICAgVGhpcyBpbnRlcnJ1cHQgY29udHJvbGxlciBoYXJkd2FyZSBp
cyBzZWNvbmQgbGV2ZWwgaW50ZXJydXB0IGNvbnRyb2xsZXINCj4gdGhhdA0KPiA+ICAgIGlzIGhv
b2tlZCB0byBhIHBhcmVudCBpbnRlcnJ1cHQgY29udHJvbGxlci4gSXQncyB1c2VmdWwgdG8gY29t
YmluZSBtdWx0aXBsZQ0KPiA+ICAgIGludGVycnVwdCBzb3VyY2VzIGludG8gMSBpbnRlcnJ1cHQg
dG8gcGFyZW50IGludGVycnVwdCBjb250cm9sbGVyLg0KPiA+ICsgIERlcGVuZCB0byB3aGljaCBJ
TlRDMCBvciBJTlRDMSB1c2VkLg0KPiA+ICsgIElOVEMwIGFuZCBJTlRDMSBhcmUgdHdvIGtpbmRz
IG9mIGludGVycnVwdCBjb250cm9sbGVyIHdpdGggZW5hYmxlDQo+ID4gKyBhbmQgcmF3ICBzdGF0
dXMgcmVnaXN0ZXJzIGZvciB1c2UuDQo+ID4gKyAgSU5UQzAgaXMgdXNlZCB0byBhc3NlcnQgR0lD
IGlmIGludGVycnVwdCBpbiBJTlRDMSBhc3NlcnRlZC4NCj4gPiArICBJTlRDMSBpcyB1c2VkIHRv
IGFzc2VydCBJTlRDMCBpZiBpbnRlcnJ1cHQgb2YgbW9kdWxlcyBhc3NlcnRlZC4NCj4gPiArICAr
LS0tLS0rICAgKy0tLS0tLS0tLSsNCj4gPiArICB8IEdJQyB8LS0tfCAgSU5UQzAgIHwNCj4gPiAr
ICArLS0tLS0rICAgKy0tLS0tLS0tLSsNCj4gPiArICAgICAgICAgICAgKy0tLS0tLS0tLSsNCj4g
PiArICAgICAgICAgICAgfCAgICAgICAgIHwtLS1tb2R1bGUwDQo+ID4gKyAgICAgICAgICAgIHwg
SU5UQzBfMCB8LS0tbW9kdWxlMQ0KPiA+ICsgICAgICAgICAgICB8ICAgICAgICAgfC0tLS4uLg0K
PiA+ICsgICAgICAgICAgICArLS0tLS0tLS0tKy0tLW1vZHVsZTMxDQo+ID4gKyAgICAgICAgICAg
IHwtLS0uLi4uICB8DQo+ID4gKyAgICAgICAgICAgICstLS0tLS0tLS0rDQo+ID4gKyAgICAgICAg
ICAgIHwgICAgICAgICB8ICAgICArLS0tLS0tLS0tKw0KPiA+ICsgICAgICAgICAgICB8IElOVEMw
XzExfCArLS0tfCBJTlRDMSAgIHwNCj4gPiArICAgICAgICAgICAgfCAgICAgICAgIHwgICAgICst
LS0tLS0tLS0rDQo+ID4gKyAgICAgICAgICAgICstLS0tLS0tLS0rICAgICArLS0tLS0tLS0tKy0t
LW1vZHVsZTANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgSU5UQzFfMCB8LS0t
bW9kdWxlMQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgIHwtLS0u
Li4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0rLS0tbW9kdWxl
MzENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tLSstLS1tb2R1bGUwDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IElOVEMxXzUgfC0tLW1vZHVsZTENCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICB8LS0tLi4uDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArLS0tLS0tLS0tKy0tLW1vZHVsZTMxDQo+ID4NCj4gPiAgbWFpbnRhaW5lcnM6
DQo+ID4gICAgLSBLZXZpbiBDaGVuIDxrZXZpbl9jaGVuQGFzcGVlZHRlY2guY29tPiBAQCAtMTcs
NDkgKzQ0LDY3IEBADQo+ID4gbWFpbnRhaW5lcnM6DQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAg
Y29tcGF0aWJsZToNCj4gPiAgICAgIGVudW06DQo+ID4gLSAgICAgIC0gYXNwZWVkLGFzdDI3MDAt
aW50Yy1pYw0KPiA+ICsgICAgICAtIGFzcGVlZCxhc3QyNzAwLWludGMwDQo+ID4gKyAgICAgIC0g
YXNwZWVkLGFzdDI3MDAtaW50YzENCj4gDQo+IE5vLCB5b3UgY2Fubm90IGNoYW5nZSBjb21wYXRp
Ymxlcy4NCj4gDQo+IFlvdSBqdXN0IHJld3JpdGUgZW50aXJlIGJpbmRpbmdzIGp1c3QgYmVjYXVz
ZSBvZiB3aXNoIHRvICJyZWZpbmUiPw0KPiBIYXJkd2FyZSBjaGFuZ2VkPyBXaGF0IGhhcHBlbmVk
IGhlcmU/DQo+IA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQpUaGVyZSBpcyBubyBo
YXJkd2FyZSBjaGFuZ2UuDQpNeSBpbnRlbnRpb24gd2FzIHRvIGNsYXJpZnkgdGhlIGludGVycnVw
dCBjb250cm9sbGVyIGhpZXJhcmNoeQ0KYnkgaW50cm9kdWNpbmcgc2VwYXJhdGUgY29tcGF0aWJs
ZSBzdHJpbmdzIGZvciB0aGUgcGFyZW50IG5vZGVzLg0KDQpTb3JyeSwgSSBkb24ndCBjaGFuZ2Ug
b3JpZ2luYWwgY29tcGF0aWJsZXMsIEkgYWRkIHBhcmVudCBjb21wYXRpYmxlcyBhc3BlZWQsYXN0
MjcwMC1pbnRjMCwgYXNwZWVkLGFzdDI3MDAtaW50YzEuDQpNb2RpZnkgb3JpZ2luYWwgdG8gYmUg
Y2hpbGQgbm9kZXMsIGFuZCBzdGlsbCBrZWVwIHRoZSBzYW1lIGNvbXBhdGlibGUgYXNwZWVkLGFz
dDI3MDAtaW50Yy1pYw0KDQo+IFlvdSBuZWVkIHRvIGNsZWFybHkgZGVzY3JpYmUgQUJJIGltcGFj
dCBhbmQgcmVhc29ucywgbGlrZSBwb3NzaWJsZSBidWdzIHlvdQ0KPiBhZGRyZXNzLiBZb3UgY2Fu
bm90IGp1c3QgcmV3cml0ZSBleGlzdGluZyBiaW5kaW5nIGludG8gc29tZXRoaW5nIGVudGlyZWx5
IGVsc2UuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

