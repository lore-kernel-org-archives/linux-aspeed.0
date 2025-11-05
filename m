Return-Path: <linux-aspeed+bounces-2746-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665A3CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Nov 2025 00:35:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d1RFP6yKDz2yqP;
	Wed,  5 Nov 2025 11:35:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762302953;
	cv=pass; b=CbGPMgbfFu7fDNVVtL8lYioJTzkWcq8Vi6GWo3h0i1EEOfvUKmu0cuLNpvOFn5sTnKWV4mB0fhsGLxPvr+1e+1N9Rmt4tWUAH/SrQoffUjrv+7yuLu6/rONsnpYXnJdKBgd47ef3zD3IRpZV7IUCja6MusdMu7OF7hQU7pjR0t6Gx2WDZttVarAJ+2cb+CoIlbCjRjYTsuzcK9/6crG7ivTC4htT7KHBIt9tTWg+XCbu6QkTvhYqjAeK9I4sy9+PPpkeOFLHu3JhrShWMxaxSjxZg99aL4vzW4lD+VeXzaeGl+J3M2zuqJ3I9t4GVRK9gj1G19qRPKgwvYr91iitpg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762302953; c=relaxed/relaxed;
	bh=0RE0pRzNcFuhI3J1UVpproM2SQwb6E0Ug/ZeQnruW5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mBet8BaOKAP8ho4sI/ycyfTieEzZ4W8O5mxkBbabbRyA7FhnhS7+eyPLsykCVIEzI2pT+k04pS8fYjhTMx+ywxw97XiDDp3kM7N/yJtUhktvPpCQhT/cTgj89q2N5iUTX1/03VyoMuNGXRIYcCRXapx1yDrpLuqikPBdOJ/x8z3SWM8Q/SxdDGUUnoCNSpWBQorqBq7KbhVsRtWtz474sr4ckKvnUpmN8fgOKQHK2Sx+RhfF12ST8kddraxwhIOKHvJP8uQ3koCHY/WYZ1b1+RFVagqMxTVJpi7mcdNiiiX/SQ6RvOmY1UzpjT8fALnHdQYIOpA3rdMlWoj47Uz12A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=envqxc6f; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=envqxc6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d1RFN2d83z2yjq
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Nov 2025 11:35:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd4U/XxDR/TUuDpmnR55OAXn/kiAgfMorJS5T36FW1VmXSfzdKcyuYO+TQYpLQK/gYDWYvvv1zw8WnGL2jH4z/KTnqPC46BaUwIXxBYsoMinWHTHVYBAd9Pp2M/1giFKDKqxZeRygXhTGATLXXaE5TgwSOyr+Ck4Fms06GTvxDqFCPyBtG4aLtWcKRXhJKGxkZQCDbcxCLBvGG4ugZnjEel61ohTameHCgKSkERf2jF1oluNWLuYF3h+Mle8NPEmn4RM9k1u29a1b21kW9/tTGbqpjRT9tBU+Gf/zPqielaKfhdO+tG3Hae+1LL+UtDc18Fx+MuyXWUxUaDU+e+kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RE0pRzNcFuhI3J1UVpproM2SQwb6E0Ug/ZeQnruW5s=;
 b=OvvJaFLlUt3PE/r/KJhv0KfS/pMaCOy9DNZXkYWsWQ8YFz5dG4xWoZ0aY1G+cF6v/FL4HIzTbbF74P7Kb4LpwoE0gcvi1uI3T9RHhLXZxxrT6O4SiK3yqGq9HC/S5v1AM3R5/qZUMbnMKYPwlEfk5mpPiVs7oUN6t0AfSKoRKZEmgACph4gB8wU8R+XUbDrfaRG03IaWvxTFuIyVTuYrk07FDfGMt7sE/nm08t+qQgJcFZ6NXr6PB5N6pHSFARVAN3cM/IexlXq37PD6P/n2RqwZZxRdIUhEvsLHqx5xnHsrCWAFU9NgJPRilgIfdttFsKFMTtLg11OBmZncreuB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RE0pRzNcFuhI3J1UVpproM2SQwb6E0Ug/ZeQnruW5s=;
 b=envqxc6fIMpVP4rtlhOwzVMxMBRmfvFMRgygsk5jLEgRT9928s4726TmmOHb8HUueDOYzv3uGvZ/Grx2yW6xqkIq4Br0F8KjG5wC2lCmcerEnV+75uYVHhPfg3Kxna30nuSTxdLhA2DiEEubU9ISMtpONxIFuEpsGx4kB+W8tAqzr9cIzTPtXVZ62k75lU1YW8R642/lY3iMPRcbCiuLYOlv6OgLpqQ0qu+Rd926gWPkr1ZcH5XP7Ol+sWtczg6kab06lRz8IeOde3g4dB6pgfvyZGM/qAMqye2Vqb5dgQjlYynTANSfudXA/SPiorpNMUK1Wq9hORsB7J8KPvATpQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE3PR06MB8106.apcprd06.prod.outlook.com (2603:1096:101:2e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 00:35:22 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 00:35:22 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Lunn <andrew@lunn.ch>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, Lee
 Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Nishanth Menon <nm@ti.com>, =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
Thread-Topic: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Thread-Index:
 AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6AgACX8gCAAPRVAIADDnEAgAAO3MCAAJ3UAIACg/2ggABTw4CAAChhgIABFTnggAB0UoCACNrKoA==
Date: Wed, 5 Nov 2025 00:35:22 +0000
Message-ID:
 <TY2PPF5CB9A1BE6A90EB3EE01B924744957F2C5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
 <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
 <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
 <TY2PPF5CB9A1BE68F47D7F3DBA2CDA2429EF2FBA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <80d0fb36-17d8-44c9-8941-0bac9f3b3ef2@app.fastmail.com>
In-Reply-To: <80d0fb36-17d8-44c9-8941-0bac9f3b3ef2@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE3PR06MB8106:EE_
x-ms-office365-filtering-correlation-id: d54abed9-236d-411b-8e7f-08de1c033498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDdjakpBa0VTMnUrQ1hYQ1pHenJ1VDBRWi9UOHBoV0cyM1c4RThGdzF4cDRr?=
 =?utf-8?B?TC9ZeXZqSGl0VmdQVWpkWkdoNHA0eUROOU1uSGd0QW52ZmNHSmUxYVRkdTUv?=
 =?utf-8?B?cVRYTG12MnlMSHU0UitLdVkzMFNSU0pNb2pTUFM3TENQK1dLRkRWZEhITmlX?=
 =?utf-8?B?ekp1TGFEVHZmd0RrYWpjNmRRYjNoYktvUDZndTN5RmpKZ3YrMThCbm4wZkVy?=
 =?utf-8?B?QyswVDh2c3lPcHAzNzdmNEJPZ3NwVkVIZ2NyYzIwclFJQTNoWDBiem1aNkNm?=
 =?utf-8?B?b2lsQzdIdTY4LzkxYW1lTnU4M2dNM3JUNUVuaktyTmM1a25ZRng5SjllVENP?=
 =?utf-8?B?eVJPRU9tTnBSWlNjZnhXU1VNNHRYS1RyNjdtVGZPT1NQRXg4eWJZZGxjVjE2?=
 =?utf-8?B?TjBFSW5mVGkyVHk0b2E0d0IxNmtoaVp2MExNQ2ZJbWJFNXJSV3IyU2NKMXNu?=
 =?utf-8?B?Ymt4WFFPNzB2NE1oZlE0TGcrQmdHRzhjdFpxL3NtWXNjaFUxK05FVUU4SFlC?=
 =?utf-8?B?OG1uMGdJMXowd1hPVVR0dVMzOHlpakJGRlFwNTdCc0JHQWtTM01GZHY3b1g5?=
 =?utf-8?B?cUpwUStFb242ZkxDUzVnOW5HUVlLampvLy9EUWZVb25YZlgrR0dpOTAvMzZt?=
 =?utf-8?B?UVJ5WndsOTBsMVFQQU14S1JSdkdpMU83MlVUSEtSUG5yNmR4emFYSm4rZnhv?=
 =?utf-8?B?Z25Vb0JELzlDNmFoVGNGc1NKa2JpaHg4R1ptOTlwSzJ2OURYSEVpaWEvZFAw?=
 =?utf-8?B?MVgvOU5HdlBKWUU0aHljbDhqVzFBVzJQcXBPZ3kzZkJOeUM3YlM0UnlCK3VZ?=
 =?utf-8?B?V0hiZWFNM1UxbDFvU1NmSXlkQnJJd1JuZ3ByNlVpS29nVWZ0Yk9lRnlFR2pN?=
 =?utf-8?B?WHJiWVFjbit0YS9nRk9ONTdKaDdjc3RBdWN6NWpYaWdHSGRkWlY2aGJTYk92?=
 =?utf-8?B?c29Ba2NjNldpTE14MjV3dlo5K0lERy95cnpVaDFpMkpxd0NDeThaNnJpMWl3?=
 =?utf-8?B?SXFYNnBCY0ZTYjVJVWhtWG1FMVYrbDRxNkQ4UkhSai9sRGJ3bzlpdWYydTBX?=
 =?utf-8?B?a0NhY21DZHI0dWJjekxUV25ob2FCZGpZa0pLNUE5SWdwQTE0dHpDdUZvVnNv?=
 =?utf-8?B?M2tqMlc4RTIwbHRvbWNDZXNvMGhLRHZaZmo1aEJxMmVDMDRDalRyV20wWkRk?=
 =?utf-8?B?TnBnbVFpVHAvM0lGVEtZNWsrQzE4K0hkbk9vOGplL2ZrS2l1aXNjSlhvcVV0?=
 =?utf-8?B?UnJQZ05nRlVOdTUyWWdmY1RkNHlzMDBmRWJCVnB6cE5ZRlF4TFduVzhBVG5M?=
 =?utf-8?B?R3JTTDNZY05WMTh1MzVlbzVGalBWSHd6Y2M2ZGc5aUMvUTM5cnZSZTU0NDZI?=
 =?utf-8?B?bCtjcVZrVmZsbHVYS0s2cGZtVTMyNERSRzlBVkNBZkJzTEhSZ0pjRHI5N0pr?=
 =?utf-8?B?NUJRaFJ5VXZxTkpGMXBnVkVuUGVJZ1RxVFZISzc3QXhETUhaMEN4em5uS0Fs?=
 =?utf-8?B?dkI5UmRLVXFNazdYVnpYSHFpdStVVzNxRW01U3pMdE55ZjliRTZlSm5MZC9y?=
 =?utf-8?B?cy94ajh4cUhMVVNWT1NUeTBZbVFkU24vd1NSaUpCa3VPU2JxbHlGZmo2elRx?=
 =?utf-8?B?NG05OHBvdGRmOUx6dlhxTlFnS0pSZXdkQjluQ01kaklhcG9VL0dvVkE1TDF6?=
 =?utf-8?B?L0NhT0J3a21taW1UZGNlcXN1SEozcXF1TUpLQnc5Z3I5TEd0RVJoZDBTMFlH?=
 =?utf-8?B?YXlmTWFMSGMzVnpKZGpLM1VoU2NhY1UycFlMbXUzQVBZd1lsOGU2YktUQ3Rn?=
 =?utf-8?B?Sk1zcnBvOFdYSk96YXpmTnBvak9vdEVqUzF3VkJEUzVCcVV1MDRqTTNkR2VD?=
 =?utf-8?B?LzZMc1dScG1SbHp4WUZqaElGb2xTbUZBZ2FkSjhrRmZnNm51YWgzcEpSYTZJ?=
 =?utf-8?B?NkVVQ0RuK2dRSnZpaGEvOE5KeElhNDhqSVF5TU04QUpKaDB4WHk3WXllMWF6?=
 =?utf-8?B?R1hiVUZPeXZ6SVY5alllWlhmVWtMeHBOZDRTTEFNNitsRVhHTkdJbG5nQ09X?=
 =?utf-8?Q?AnExuu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0NTRHp6K0ZZOGpJZjZtdlpBMmhjSWRzeTVvMVduT2REbXhaeHVRQS9ZbzI3?=
 =?utf-8?B?QXh3Ync5VFZNRm1DTUl2elhIL1RhOHdXRmZ2RWNpT1RLUlNqUm1ieUxUajdy?=
 =?utf-8?B?Q0Fza20zRmhUdXRSbUxHalBBa095RHQxN1A5U1Q3a2M2bTk5Nm1XNlFLNTV4?=
 =?utf-8?B?YVZCdDRidXhrTkU3SW82eTZ4NnNxbXZyYVRJZWFzT0xDRW05UjQzamNjaHAr?=
 =?utf-8?B?MWlZM20wdCtjYkM5c3RpRG16TmJ4VGNrYWdxUGYrKy9HcGJ5RzZSallVeXRm?=
 =?utf-8?B?dDNVSVo0cWFteVlTdlAzbWtqeSszMjNFQmdBR1FWNFlnaFlOSThwTU5DRk01?=
 =?utf-8?B?Zm1iT1gwalRWNGw4WHlhSzZWMHEvWElvd2Q4WUJwVmxCTm51NXpZOTQvOXgy?=
 =?utf-8?B?ampaeXkwMjNyOUx0YWloNCtzWmo0T1Y0cUhLZWJja0psWGJKQUoyMjNiaE1G?=
 =?utf-8?B?NFh5M1lhM0daSUd5Z01kcUJUdURQMUtiK3k0b24xRGJybnFJb3JoRWs2QlBa?=
 =?utf-8?B?OC9WUWJIMDJXcVBwWGp4TEtBZEQwdks1NDZyM3Q1SFVkYkkrYXFUSWhEaUt0?=
 =?utf-8?B?dmRKQVdYeUF1TVhsbzhkQ3JnZjYxTWxjV2RPajI4cUFWSlJKTk5ackprRHFz?=
 =?utf-8?B?eERqdjJkV0ZFOUM1bjltKzZOUkl2RFRWc3hDc3hIZjhIVko0YW0xT1o1SWI1?=
 =?utf-8?B?T0l3WEMwYkVIQ09ySG5uU0ptcjhpSnRxUlZKR0RJOFZld2RYU3FOY3pDY0RP?=
 =?utf-8?B?QXVCYy9ZeU9TdzNKRm94T3dWS2Z5OXNHdEtZRWZqSnRFSWVPeWpnS2t1OE9K?=
 =?utf-8?B?ZERhb1I2aC9qellhQjg1UkwyamtORHBhZU52aDBLMlFKckdPaTAvRitIK3NG?=
 =?utf-8?B?V2F5a2J6TUtNbE8wSjU2TzdQWG1xeFduQzF6Z3JtdTVkRkRqa2k0MlVQRnov?=
 =?utf-8?B?d0xLU1IwZTNVSTNpYUtZU0tUckZaOHg5bk1yQWJmZFJyU1JMM2hqVTFxaldH?=
 =?utf-8?B?V2xjbXM1UWNKSGhYblNLaXg3bGtzTlplcDlJcUNyMHNTN25xWDVKT3pMd3FY?=
 =?utf-8?B?MVVzR0Jvckx5bENYYk10Z2tOY1JpeU1OSnBVcExvc3ZLQUpmcStYcTJyQytq?=
 =?utf-8?B?blVOcEF4d2U4Q0pSUDB2WWhJRmFIL3l5T2tjcDhjUG56SFlONzBqNDdCKzJl?=
 =?utf-8?B?TWUyb1RPM2VndmhkU2FHdTFrbkFGK2N0OEdUQlZsTzJhQjZBblJFVitJY3d6?=
 =?utf-8?B?Z3dKd2RLcVl4cjZPQTRsbXYyR3dhRkovaEhvajM4TEtOMmNPZ1BzRVRYU1Av?=
 =?utf-8?B?VWNyVGhJckVFUzF0WC9xOE1EUzg2WjlScjM5WUJPTTIzKzQxSWF1VkE1TmF1?=
 =?utf-8?B?WXdhSzhZQ3N3ZWNvOXIrZkIzYStETEZlNVdYYVJlMGhNRlU3Mk5Zb2p3WUpn?=
 =?utf-8?B?c1NHci9oMHlRM3FMUkRxdFR5NjVzeWNtbkhHbmJhV0VTeGx2eVFqam5lcVpk?=
 =?utf-8?B?dE8zMjBpSjkwY3FYb2wxVFFJeXltWFFIRnkwZ09tU2VZdk1qWWw1bHBKYncw?=
 =?utf-8?B?Z2dHN291UWc4Z3hHNC96Tm5JUytueWo0NitwUWdWa0JDUWdLa1U3NjViQWxB?=
 =?utf-8?B?TEtqRVV3MlU1YVpudjFzWlJHYXJ1WnQ4S1NwRGRVaTE1Rk9SeXFtTjI1VU1K?=
 =?utf-8?B?Z2NRTGNrM2ZTSlFwQVREZ3FnYXk5cFMvRnVLMnprRU5rYVd2T21wMUQ0elJE?=
 =?utf-8?B?Y0t4VFphNVNDMVBYcFcvY3NpQm5iMlVOaUU2Z2FlUGNKazBnOXRVSTdiYlIw?=
 =?utf-8?B?akNkQTl6L1RHaTdKTjVycnlXOXRLOHVCQmFWeHBBMnVEWWhmc05KOTlOc0gv?=
 =?utf-8?B?M0V6TFhxbkxzeDUwVTNGaUJnQ3UvRDFzMHV4VXNFRC9zN1RQNFhwSG5Ib09h?=
 =?utf-8?B?dGJIWldqaEpCNGZIbEhuOUtGNmd3RmkvdEdYK3hTRlB1MHFuSXN5aTN4R1JM?=
 =?utf-8?B?YllJRHhRak5JM3lnSHFzRldad3IzQ0FrWE5SSVB0elN0anFnbS9NZlFyOUZu?=
 =?utf-8?B?V2Y4WVV0d3ZYMWovTXZSaWJOVk1oQ3ZOb21lUXJVc3psZmxDeWZyQ1VOMkVk?=
 =?utf-8?Q?EgWt2+Ylt5a5UCV3q0O1/yxTG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d54abed9-236d-411b-8e7f-08de1c033498
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 00:35:22.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5ZZ3vU3ubhnHoWaYQ8LWSxk9rDqZjiZgv5r+fTZDRArKYLn7mizjB75fe+TLFP3d0fBWnn1y2SajLhAgnAhoGDpdNUMz5f7klOq4U4nO2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8106

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDQvNl0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gT24gVGh1LCBPY3QgMzAsIDIw
MjUsIGF0IDAzOjMwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djYgNC82XSBhcm02NDogZHRzOiBhc3BlZWQ6IEFkZCBpbml0aWFsIEFTVDI3MDANCj4gPj4gU29D
IGRldmljZSB0cmVlIE9uIFdlZCwgMjkgT2N0IDIwMjUgYXQgMDg6MjYsIEFybmQgQmVyZ21hbm4N
Cj4gPj4gPGFybmRAYXJuZGIuZGU+IHdyb3RlOg0KPiA+PiA+IE9uIFdlZCwgT2N0IDI5LCAyMDI1
LCBhdCAwMzozMSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+PiA+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgNC82XSBhcm02NDogZHRzOiBhc3BlZWQ6IEFkZCBpbml0aWFsDQo+ID4+ID4gPj4gQVNU
MjcwMA0KPiA+DQo+ID4gVGhhbmtzIGZvciBwb2ludGluZyBtZSBpbiB0aGUgcmlnaHQgZGlyZWN0
aW9uLg0KPiA+DQo+ID4gQWZ0ZXIgY2hlY2tpbmcgdGhlIFRJIEszIGV4YW1wbGUNCj4gPiAoaHR0
cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2FyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvDQo+ID4gazMtajc4NHM0LWo3NDJzMi1jb21tb24uZHRzaSNMNzUpLA0KPiA+IEkg
c2VlIHRoYXQgYWxsIHByb2Nlc3NpbmcgZG9tYWlucyBpbiB0aGF0IFNvQyBzaGFyZSB0aGUgc2Ft
ZSBwaHlzaWNhbA0KPiA+IGFkZHJlc3MgZGVjb2RpbmcsIHdoaWNoIG1ha2VzIGEgU3lzdGVtLURU
LXN0eWxlIHN0cnVjdHVyZSBwb3NzaWJsZS4NCj4gPg0KPiA+IEhvd2V2ZXIsIGluIHRoZSBBU1Qy
NzAwIGRlc2lnbiwgdGhlIENvcnRleC1BMzUgKDY0LWJpdCkgYW5kIENvcnRleC1NNA0KPiA+ICgz
Mi1iaXQpIGNvcmVzIGVhY2ggcnVuIGluIGEgZGlzdGluY3QgYWRkcmVzcyBzcGFjZSB3aXRoIGRp
ZmZlcmVudA0KPiA+IG1lbW9yeSBtYXBzLCBzbyB0aGV5IGRvIG5vdCBzaGFyZSB0aGUgc2FtZSBk
ZWNvZGUgdmlldy4NCj4gPiBCZWNhdXNlIG9mIHRoYXQsIGEgc2luZ2xlIHVuaWZpZWQgLmR0c2kg
Y2Fubm90IGRpcmVjdGx5IHJlcHJlc2VudCBib3RoDQo+ID4gc2lkZXMgd2l0aG91dCBhZGRpdGlv
bmFsIHRyYW5zbGF0aW9uIG9yIOKAnHJhbmdlc+KAnSBtYXBwaW5nIGxvZ2ljLg0KPiA+IEZvciBl
eGFtcGxlLCBpbiBjYTM1IHZpZXcgdWFydDBAMTRjMzMwMDAsIGNtNCB2aWV3IHVhcnQwQDc0YzMz
MDAwDQo+IEZyb20NCj4gPiBjYTM1IGRvIGhhdmUgMHg3eHh4eHh4eCBpcyBhbm90aGVyIHBlcmlw
aGVyYWwgZGVjb2RlIGFkZHJlc3MuDQo+IA0KPiBUaGlzIHN0aWxsIGxvb2tzIGxpa2UgdGhlIHNp
bXBsZXN0IGNhc2UgdG8gbWUsIHdoZXJlIHlvdSdkIGhhdmUgYSBkdHNpIGZpbGUNCj4gZGVzY3Jp
YmluZyB0aGUgQHNvYzAgYW5kIEBzb2MxIGRldmljZXMgdXNpbmcgdGhlaXIgbG9jYWwgYWRkcmVz
c2VzIHN1Y2ggYXMNCj4gdWFydDBAYzMzMDAwLCBhbmQgYSByYW5nZXMgcHJvcGVydHkgdG8gbWFw
IGl0IGludG8gdGhlIENQVSBzcGVjaWZpYyBwaHlzaWNhbA0KPiBhZGRyZXNzIHNwYWNlLCBvbmUg
b2YNCj4gDQo+IAlyYW5nZXMgPSA8MHgwIDB4MCAweDAgMHgxNDAwMDAwMCAweDAgMHgxMDAwMDAw
PjsNCj4gCXJhbmdlcyA9IDwweDAgMHgwIDB4MCAweDc0MDAwMDAwIDB4MCAweDEwMDAwMDA+Ow0K
PiANCj4gdG8gcmVtYXAgMHgxMDAwMDAwIGJ5dGVzICgxNk1CKSBvZiBhZGRyZXNzIHNwYWNlIGZy
b20gbG9jYWwgYnVzIGFkZHJlc3Nlcw0KPiB0byBvbmUgb2YgdGhlIHR3byBjbHVzdGVycy4gVGhp
cyBpcyBhbG1vc3Qgd2hhdCB5b3UgaGF2ZSwgZXhjZXB0IHlvdSBtYXAgYW4NCj4gZW50aXJlIDI1
Nk1CICgweDEwMDAwMDAwKSByYW5nZS4gVGhlIGV4YWN0IHNpemUgeW91IHdhbnQgc2hvdWxkIGJl
IGF2YWlsYWJsZQ0KPiBpbiB5b3VyIGhhcmR3YXJlIGRvY3VtZW50YXRpb24uDQoNClRoYW5rcyB0
aGUgZGlyZWN0aW9uLg0KSSB3aWxsIHNlcGFyYXRlIHRoZSBhc3BlZWQtZzcuZHRzaSBmaWxlIHRv
IGJlIGFzcGVlZC1nNy1hMzUuZHRzaSBhbmQgYXNwZWVkLWc3LWNvbW1vbi5kdHMuDQphc3BlZWQt
ZzctYTM1LmR0c2kgd2lsbCBkZXNjcmlwdCBzb2MwLzEgcmFuZ2VzDQogICAgc29jMDogYnVzQDEw
MDAwMDAwIHsNCiAgICAgICAgY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCiAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8Mj47DQogICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KDQogICAgICAg
IHJhbmdlcyA9IDwweDAgMHgwIDB4MCAweDAgMHgwIDB4MTAwMDAwMDA+Ow0KICAgIH07DQoNCiAg
ICBzb2MxOiBidXNAMTQwMDAwMDAgew0KICAgICAgICBjb21wYXRpYmxlID0gInNpbXBsZS1idXMi
Ow0KICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAgICAgICAgI3NpemUtY2VsbHMgPSA8
Mj47DQoNCiAgICAgICAgcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4MTQwMDAwMDAgMHgwIDB4MTAw
MDAwMDA+OyANCiAgICB9Ow0KYXNwZWVkLWc3LWNvbW1vbi5kdHMgd2lsbCBkZXNjcmlwdCBzb2Mw
LzEgcGVyaXBoZXJhbCBvZmZzZXQuIA0KDQo+IA0KPiAgICAgICAgICBBcm5kDQo=

