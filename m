Return-Path: <linux-aspeed+bounces-729-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50405C02198
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 02:15:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvsvj5Yxjz2ydW;
	Sat, 15 Feb 2025 13:15:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739585729;
	cv=pass; b=cVv7WsfWHFYB3gxc1vA+L03Vn3K85jgn1xxNg9dbAkmZFhfA4sX+u+nUv/kVEmrypRwYoGzlI8WVTv5dhoNBhnIp8aGXDvcshZBvkPxToCf9Oi2P9J8aqg6eeCbKTeA0So6yzcxzgSE2F0kMefUJbNJu05H6BYmcX/qCa0DdUbpETLpVCUHiFyoX4i+bSHduj3NBikCgkJ2+E/+MifWY4oFSfPjEIEswS2iYt91G0MZ0cmdxW8H3lVXA4+71lGmAlXUShTvx4pgdjQyFE4NfYdAHv3e+WRHb+YpLD1jlGXvnofshvz/7bLXXeYW/cyBEf1kR/r+CYlmfxiLrPnyQSw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739585729; c=relaxed/relaxed;
	bh=lGPcq5kMDDcBG5exotR/tzUN29tCbudNYwSQa75+TBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hM5dv/Hz2Kt+8wicXDGKPuF2PDFfRKQzm19i5Q2ucdKfwMqINxzgmUhm8k2OuMJ+igm7s1ERubycBRHePUIxvgPvUk6XPnDxBalr9/jXi6ji+/TN6NXdSNdLoOB9SMjmpDh3r92RjzRd1GLT5TGlyIM2zdaSL0j19ShJTVQ4tBAhySHhCfVZzlSwBJUkMjmYVy0+xANgiWV5RjGjUY3K6M6nLqycDHgVM83rEfcWN1UGs/su1/Cxxhkria0oybWvrX1oFjbA9rN5zgIelvuRPPHoM+MSEPrqxecylze/dLG0m3TN/Ad1FyD6pbwvFdGoQYSLmsi6UJqThXJPdn0WYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c400::2; helo=hk3pr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::2; helo=hk3pr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvsvK6pQmz2yQL
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 13:15:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJyIhYHMVfdl41MfXDZo/pV0LxNlEcf+swOZ571bVSqwqlO0Etk1QdQS8VSZ9yZJLgiDCNjIOqBVDBwbgfrbXyncdzxNUoa5mcC01wfBqAal0mHVLsfgmdqial49Ty5qwK5YAEa+ToaimEPF3u8ZXaYjVsgjEe80jOE5MTrWTXNGfNutS52QK/rvlIHRU2ltFCn9GrwIE4c+2fVXHKyC8SuEiGd5YYBVjAlxsiRhz/0fG3RmEg60nVmBk4HnXVfy1h9+44BKLwXS3UmpaV8wt6HPUUvSdmn1UgEkHn+mQGWNhsuV98gMnZ+N7I990xR5lgD9GyRrdYLWjuuuHJm4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGPcq5kMDDcBG5exotR/tzUN29tCbudNYwSQa75+TBU=;
 b=w6Dp3rKf17aPwkQQ+b+E8B5Lu19aodjXVEcvfBAiIidFc36dsBwCdt+prBk1a/pMZWeoBKB0aMvwNu6TVIHjEq24pntztpRALQwjxrcKDuhxWpw+v4rfo9xeusC0TX+mIqG3pLFjGDMEn/RbLdTfz+Q6NSJKGfyU8TkvPrBTioT3jOhAF6I2GdKHAtWIPCoVjbt8+0yM6F+VTvmmzD+XkOSGk0Q87R68wfT9mjXhbzIS4rImP40fj7xGxIInbWe1zM9qpo0gKGGpOzFrx/Mxfh2Ko/cWDSYYyzMmlL00cJJmFXJgbblt5uYNGZVTk0otrSX9T4HWCcoKj0KsyrNbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGPcq5kMDDcBG5exotR/tzUN29tCbudNYwSQa75+TBU=;
 b=gIoQGQUBFVRzQFfdHR76fms3RWRiqzKvt6u16gQsAJMCtIpe7R+2V1f3lqb9co7jtIeFZLvudxWKcX3F0gn3+8Fg26JRlMkdN0vZ18WptGPIx8A+3EDyu8E+eXbqcDp14RQowIMVKkSHLxuFFNoOLaC5SUT3tuLxodVSeaapXkQJLAynTJg77yMa2/PTzCz8sjjIi+/YGrGbggTK3uxHV94VZjiFNVJCGrUZzxH8PVPtUyjopqFd5yjagK479gMeYXlcGV5ySgUxXGC3rI9R8Cb9gDbsTnoea/LAHQjqG4mabIfK26FTMoRGYiigDvijKFK4mmAooQIUmzNMVfru7g==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TY0PR06MB5427.apcprd06.prod.outlook.com (2603:1096:400:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.7; Sat, 15 Feb
 2025 02:14:40 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8466.004; Sat, 15 Feb 2025
 02:14:40 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Topic: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Index: AQHbe5jOQE8gqD0QkUiPz6C8rjFaj7NBw6UAgAXf/kA=
Date: Sat, 15 Feb 2025 02:14:40 +0000
Message-ID:
 <OS8PR06MB7541287BC48C500E50C7C77FF2F92@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250210085004.1898895-1-ryan_chen@aspeedtech.com>
 <20250210085004.1898895-2-ryan_chen@aspeedtech.com>
 <20250211-encouraging-free-aardwolf-0fabb1@krzk-bin>
In-Reply-To: <20250211-encouraging-free-aardwolf-0fabb1@krzk-bin>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TY0PR06MB5427:EE_
x-ms-office365-filtering-correlation-id: 3695983d-57ac-4dc0-7269-08dd4d66813d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFZsNytCbnM0c3FMWWI4VW82SGlqeElTVlJJMldsSjdTK2pqYmJ2UjdFQndm?=
 =?utf-8?B?WDNYQWdjemc0dVZBSnJ4VWVLQ2xjbUl6RlNVTVdON1Q5M2h0OVZvUXd1QVds?=
 =?utf-8?B?L1JuVmZjU0puSStMbkZ1V1BHREJKbGxlSE5YZUllemdudFM4bU5Bby9FeVhS?=
 =?utf-8?B?VzBoaVQ0c09QUkN4bnp6eURLVE9IRGRIdDFWa1ZKeGk1SmVwa1A4cXN1WnIz?=
 =?utf-8?B?c1dmNkxLT1VmU1RqWnhKUFo0SWxDdnNrNmdrSlMyUk5taDRUREQrU0tYZytP?=
 =?utf-8?B?a2ZDNW5tTi9ETVd6eHpHMWdVSERtT21ramdtR04xODN4UVlxVEhpSjNtaEZT?=
 =?utf-8?B?b3JWczBOd1lmbDBmZmZwTTZOTDVicEh6SUlkMUM0Y3NvTFE4WGRTTE5ZbFFX?=
 =?utf-8?B?RlVsMjQxQWhwWXZ5L00wak9RUHkwODJsODhkaVFKQ3Rydkh0Ty9jQUZBQzNK?=
 =?utf-8?B?Rkx2SzhmVWhNMFdkd0JEdGdMTWNtQjh5ZCtiYTlYUXV2TTFjYkpOM3JNeW1t?=
 =?utf-8?B?SnBhSFJvdnZRYzFlbHF1U1Y1b1BhQXZRc01LZm5OMlVONXBOU1UxMlFDNTE3?=
 =?utf-8?B?Z3l2cmJpOXFVL05tMXgwK3NIWWpHL0lDTEhjbjlXS1RkaEVuNDc2TlZTME1V?=
 =?utf-8?B?OGQ2ek5aMXduRW1OemtLQmZjWnVVd2pZMlE2SFNCRCt3TXc5SE5EZmFQVXRU?=
 =?utf-8?B?Z3RiRmZyWDBkbzZtV3BWSHZKeUhlYittZm1CaWFmMlVZKzdOMDhnODVhemJY?=
 =?utf-8?B?cWplK2MrUnZQYS80UU5sL3BJZHlSY0RFcFEyNDNhMDYvRStRQzdZcWRUUmIv?=
 =?utf-8?B?SW9IMmRyMURYT29Xa0JjWC9qZmR4WnpYeGRaL2FvTVk0aExYZ3hlYnpPTHhj?=
 =?utf-8?B?MWNRNlgvSDByMEJzZm1SYnZXVVZtdFBiTlNLdlE4N0xWeEZWQzBlS09sb05Y?=
 =?utf-8?B?dU1zdkxuanRPWWQ0dDVNQ1FlRFVoK3dlNHd6SXVoOGpWbmJBUTdKZ2JNNkUx?=
 =?utf-8?B?KzR2SjBPUEJmNkFlT2Riek54bHUwSHNtY29QYVZIeDJYeU1XNlpQdmNLUnNr?=
 =?utf-8?B?RUw5N05oSlMwWXhlKzNNOFdWTFZqUlNqNFZLRFJsbFpYNnByTlROWE15K01U?=
 =?utf-8?B?b3cxVmdyL0JyT1VyVkFvcmhyYi95UWovMjR1UmVqSGoycmo3Q1Eyd21nSXlN?=
 =?utf-8?B?VVFiRFZ4Vm1wci92VWJhOVdrUWJSMlpaM0tWU1FNR1J2K0lkWWIvc2lWWFpW?=
 =?utf-8?B?MSttbE1Md3BTNUxSNXM3UDFVUFBxbUlLVlZkd3ZCM3JpQS9LVkZFUUJIUUxP?=
 =?utf-8?B?V2s0RXordzRVdlpTTmw5OE1CdXI0SWhjU1FTQXVSaDBOcEw2TmtFdjNneEcx?=
 =?utf-8?B?YklxLzJKbHlTVEdzM1luUjJlY3htanBKa3Vwb0dmNVREVTdVN1QzK1Iyd3k1?=
 =?utf-8?B?UmcvR0RXUGNEZFhIV1pCNVM0TFBTVzdKbDZSVEgyN3F2TG1kMnBvVUZVejRM?=
 =?utf-8?B?UzFDb0Nod01UdHdDYXlOVGpjWU5nTStTYlhJN2gvT1dPNFlXZ2lnODJ3dlJt?=
 =?utf-8?B?dVlpakQ1YXM5RkFMY3J5Z1lab1VXSUdINm0wa05GdjZjRlhCVGxKb1BNR0c3?=
 =?utf-8?B?eEVwQnR0WVBIelhIVmpwdUE2U3REQitYUUJDYTFNSG0wQkl0S2ZnTEswdytu?=
 =?utf-8?B?UURMdWJXV1FhYzVjSVlmMEVmK2lJTEZJSHEwYU5ldlREMWZ6ZHNpdzlvTGtz?=
 =?utf-8?B?OCtNWWc2TzhrTzN1RzdyL3IzajNRMTZWSWNiaWU2UmI4STlsaXUvTHBKQXdh?=
 =?utf-8?B?UVFvQjVXZmVEakVCR1VhRUZmNEdacEUxTkk1M25LbUtlaGFKK2tUc3lhNGJK?=
 =?utf-8?B?VkFtUHc3bElDUnkvMHVpRHVza04zWmo1NUNzOFZQSjVidFdRK1JCSzErNSts?=
 =?utf-8?Q?gdfzC/s1srWPrzq3sdWynmCTkkiV5ZbT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODNUMUhNbFkyeDAzbFlZeDF1enhVYUVPWVJGSzJCTC8vU1Q5VmQxaWpiMlBl?=
 =?utf-8?B?WWNScEQ3aUd4RzJ4azBkb3RkaUpCZFlXSEJFSmc0M3dDbXJRbXBWMzRWdGxJ?=
 =?utf-8?B?MWxKRnBHNU9wYWl6U3FUazBSN0lxRVlpL3ExdXBHUlpCYS9vZGlkOEhVekdl?=
 =?utf-8?B?OTNpMjFUWWgyZW9zOVRzRC9sWnhROVpCNE9ZYTZHQUE2bVFXK1JKc2xXQ25J?=
 =?utf-8?B?NGtXOFI5aW8zb2lLYzM1WnFDZWFaWVpJVFBoandpbHhyY21vdjB6VFJEZTlC?=
 =?utf-8?B?RXpzelMvS0ozWlRFYzZhdWVPZy80amU4dFZKVVdsNlpsYjZyM1VoeXYxMjVD?=
 =?utf-8?B?YURnOEpCRjFVL3RaZFdFQ1R4NVhVTnMwZ2lVZGIwRXdYWlZiMXRCbzkrY2U1?=
 =?utf-8?B?Yk9sSlJjeFhyREZ5b1JkdmxQWkhDeHVHQ3NPbzhsNUttV3FCV2FYaGEzdGlj?=
 =?utf-8?B?MFlTcm5NUWdxRHZ5RUNPdmRPeWtrOWRwancwWnNBZzFzT1orNlB3UGRkRjcx?=
 =?utf-8?B?TE1MeENBRFRBU3YwOU4yVHd3YURZbHNvN1ljenBObEgrVnFod1VIaktGcXo2?=
 =?utf-8?B?RVBETnB3QUtGbkgvemR0ajl3MlFIaFhzM3VCa3pjMnYzZDRVSFB3dUFaamp3?=
 =?utf-8?B?dDl2RVFzY2JzdEVJNGhwTHNTbnd1aDJ3Ly8vNHdpSndDMGFxQ3NnVWRsTDRw?=
 =?utf-8?B?M0E5S01ObGoyakFHTlVRU0QyV0k2OE9ZZURYMGhvRWdxTTBHS01mdGNJb1BS?=
 =?utf-8?B?TTBYNmFJZjBicTFvYWZnWlBBWXdYYlRQNmlWRlVnc2V0ZDd1THNVN2ZRVWVI?=
 =?utf-8?B?SDFKRzVTZEViekNMaGdiN1c3ZmlpYTE5Q2RteWpXMXRBY3kzT3RWeURXdmRS?=
 =?utf-8?B?S2JYTEdvbnFtOVd6RWFlQ0tNcUM3L2wwa3lxdVY2Z1YwZVYvdElOTnBCVzVD?=
 =?utf-8?B?eEdJRy9FRUwwcmtjWnFXa0J2aGNzS1FIVW5peUFQR0NiUWliRldmdUdSeVVv?=
 =?utf-8?B?NWhmVnREVXd2NzFmaFowdkdzKzVTcmd1eFZWcGhOK1RYN3ZTVWVjSFpqNmdn?=
 =?utf-8?B?VVFFUmlIakpGUWlkcFM5eXBRS3ZqNWFXOC8xbDJQajFBNzJkdEE0UXQ4RkR0?=
 =?utf-8?B?Ym5iNE9vN2VoUlphUGE2UGIvMithSXRnU0hXUlp4RkkxN284MURhd0NLalNE?=
 =?utf-8?B?YW1QZ3pwdHUrNnRraDNoeWJxNE84WnM3NlVkZzR4OFJrR2VYQWVQaDVJNmpK?=
 =?utf-8?B?c1lHanZLZTRLTjUyV2NMNjFUNFNqbVNzeEozci9KNThzMTNtejgzTGxDcmNo?=
 =?utf-8?B?RnhEd2MxTlRCMnVJVWd0Vy9ONGJoWE43Z1JHc0Jaa3M2WDhCTksyNElQaUgx?=
 =?utf-8?B?Vm1PZXZ0ZCtjcHZjRHZvTmwwZHdxM2hiTXFlQUdDZFN5SUxwNWVCeGVxVjM1?=
 =?utf-8?B?MnRUd0pETE9KaU05VW5tRVBCNndlRFZQNjQyUUhvOWtiUjJKWEVmUTRiVmZY?=
 =?utf-8?B?NklUMmk3WmkxV3JTWVVWRVB1elFOSzNLUDJJOTgzMUtPcCs4cVg3ZTk2UzZR?=
 =?utf-8?B?bys0TEh0MVFFZmJpaDU3TEYvZnh0UVRpUzB1ZWYxUzJGT0dmSmorUWUyWUpo?=
 =?utf-8?B?YS9aZmZSVG5oTDlvVEg5TXIwekVuTktVMjFtdElBTDhLSG1aM2Jaci8zWHFN?=
 =?utf-8?B?MG12Q2NOSXlCdERJU0ZkUWRldVZGU3BzU3dCUkhHWXRrMU5jWi8wVEVRbmZt?=
 =?utf-8?B?TTFCYlptUkMveUNGSmIyb1d2REdJdHZYbDVIWXVlLzZSSkxiWG9PTTRZcDEx?=
 =?utf-8?B?bXpyYVVNUjV0REFOWU81OW0yTy9NNUd2MTFVajd0cW9IeEcyamhMYy9YOFBm?=
 =?utf-8?B?ZWNRUFRtTnpVVzZzUzUvOXpyMkJQSVdwSTRkbENPZFgzMzJ3NHJjTXQ2Vjhr?=
 =?utf-8?B?UjQwQ1dlNWRVMkNlUjdtWEpQODN4eS94RHBHcVFaRDdScXhPS3hvNGdacmVr?=
 =?utf-8?B?WmRzb250dkhEa2xxZXM0a0xOdVliTVhFRGN0OEgyNk9PNjNtYnMvV2krZ2c0?=
 =?utf-8?B?b2dia3FsUGsvSUlxWWROMVNjV2ZqRUlyRG9TQmxBWWtzZW9IT3Zrb0pDYXpx?=
 =?utf-8?Q?r85U6KTib8RNNTEosf6dCjhx2?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3695983d-57ac-4dc0-7269-08dd4d66813d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 02:14:40.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JimHBP4NQNJp39n/ubKPvIse8tqC1rn5WERWYklhy8aXEU5ddLq63ULlPesH388u384j+u0wR+cdU5D+yqkm5hIXTfFTxkgYurmz8dCQ7lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5427

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDExLCAyMDI1IDQ6
MTggUE0NCj4gVG86IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiBDYzog
TWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgU3RlcGhlbiBCb3lk
DQo+IDxzYm95ZEBrZXJuZWwub3JnPjsgUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25p
eC5kZT47IEpvZWwgU3RhbmxleQ0KPiA8am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeSA8
YW5kcmV3QGFqLmlkLmF1PjsNCj4gbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2Vy
bmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMS8zXSBkdC1iaW5kaW5nOiBjbG9jazog
YXN0MjcwMDogbW9kaWZ5IHNvYzAvMSBjbG9jaw0KPiBkZWZpbmUNCj4gDQo+IE9uIE1vbiwgRmVi
IDEwLCAyMDI1IGF0IDA0OjUwOjAyUE0gKzA4MDAsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiByZW1v
dmUgc29jMCBjbG9jazoNCj4gDQo+IFdoeT8gWW91ciBjb21taXQgbXNnIG11c3QgZXhwbGFpbiB3
aHkuIFdoYXQgaXMgb2J2aW91cyBmcm9tIHRoZSBkaWZmLCBpc24ndA0KPiBpdD8NClRoYW5rIHlv
dSBmb3IgeW91ciBmZWVkYmFjay4gSSB3aWxsIGFkZCBleHBsYW5hdGlvbiBpbiBuZXh0IGNvbW1p
dCBwYXRjaC4NCj4gDQo+ID4gIFNPQzBfQ0xLX1VBUlRfRElWMTMNCj4gPiAgU09DMF9DTEtfSFBM
TF9ESVZfQUhCDQo+ID4gIFNPQzBfQ0xLX01QTExfRElWX0FIQg0KPiA+IGFkZCBzb2MwIGNsb2Nr
Og0KPiA+ICBTT0MwX0NMS19BSEJNVVgNCj4gPiAgU09DMF9DTEtfTVBIWVNSQw0KPiA+ICBTT0Mw
X0NMS19VMlBIWV9SRUZDTEtTUkMNCj4gPiBhZGQgc29jMSBjbG9jazoNCj4gPiAgU09DMV9DTEtf
STNDDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQs
YXN0MjcwMC1zY3UuaCB8IDcgKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtc2N1LmgNCj4gPiBiL2luY2x1ZGUvZHQtYmlu
ZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtc2N1LmgNCj4gPiBpbmRleCA2MzAyMWFmM2NhZjUu
LmM3Mzg5NTMwNjI5ZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2Nr
L2FzcGVlZCxhc3QyNzAwLXNjdS5oDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9j
ay9hc3BlZWQsYXN0MjcwMC1zY3UuaA0KPiA+IEBAIC0xMywxOCArMTMsMTcgQEANCj4gPiAgI2Rl
ZmluZSBTQ1UwX0NMS18yNE0JCTENCj4gPiAgI2RlZmluZSBTQ1UwX0NMS18xOTJNCQkyDQo+ID4g
ICNkZWZpbmUgU0NVMF9DTEtfVUFSVAkJMw0KPiA+IC0jZGVmaW5lIFNDVTBfQ0xLX1VBUlRfRElW
MTMJMw0KPiANCj4gTkFLLCBBQkkgYnJlYWsgd2l0aG91dCBhbnkgZXhwbGFuYXRpb24uDQoNClRo
ZSBgU0NVMF9DTEtfVUFSVF9ESVYxM2Agd2FzIG9yaWdpbmFsbHkgZGVmaW5lZCBhcyBhIHNlcGFy
YXRlIGNsb2NrIGlkZW50aWZpZXIsIHJldmlld2luZyB0aGUgQVNUMjcwMCBjbG9jayBkcml2ZXIg
aW1wbGVtZW50LCBJIHJlYWxpemVkIGl0IGlzIG5vIGxvbmdlciBuZWNlc3NhcnkuDQpUaGUgY2xr
LWFzdDI3MDAuYyBkcml2ZXIgSSBoYXZlICoqaW50ZWdyYXRlZCB0aGUgU09DMCBVQVJUIGNsb2Nr
IChgc29jMF91YXJ0Y2xrYCkgd2l0aCBgYXN0MjcwMF9jbGtfdWFydF9kaXZfdGFibGVgKiouIA0K
VGhlIFVBUlQgY2xvY2sgc291cmNlIHdpbGwgZ2V0IGZyb20gYXN0MjcwMF9jbGtfdWFydF9kaXZf
dGFibGUsIHRoYXQgd2lsbCBkaXYgZnJvbSBzb3VyY2UgMjRNIGRpdjEzIG9yIGRpdjEuDQo+IA0K
PiA+ICAjZGVmaW5lIFNDVTBfQ0xLX1BTUAkJNA0KPiA+ICAjZGVmaW5lIFNDVTBfQ0xLX0hQTEwJ
CTUNCj4gPiAgI2RlZmluZSBTQ1UwX0NMS19IUExMX0RJVjIJNg0KPiA+ICAjZGVmaW5lIFNDVTBf
Q0xLX0hQTExfRElWNAk3DQo+ID4gLSNkZWZpbmUgU0NVMF9DTEtfSFBMTF9ESVZfQUhCCTgNCj4g
PiArI2RlZmluZSBTQ1UwX0NMS19BSEJNVVgJCTgNCj4gDQo+IE5BSywgQUJJIGJyZWFrIHdpdGhv
dXQgYW55IGV4cGxhbmF0aW9uLg0KDQpWNiBjbG9jay1hc3QyNzAwLmMgQ0xLX0FIQiBpbXBsZW1l
bnQgbXBsbF9kaXZfYWhiIC8gaHBsbF9kaXZfYWhiIHRvIGJlIGFoYiBjbG9jayBzb3VyY2UuDQpt
cGxsLT4gbXBsbF9kaXZfYWhiIA0KCQkJCS0+IGNsa19haGINCmhwbGwtPiBocGxsX2Rpdl9haGIN
Cg0KVjggY2xvY2stYXN0MjcwMC5jIEkgaW1wbGVtZW50IGJ5IFNDVTBfQ0xLX0FIQk1VWCBmb3Ig
bW9yZSB1bmRlcnN0YW5kIGNsb2NrIHNvdXJjZSBkaXZpZGUgdHJlZS4NCkFkZCBkZWZpbmUgU0NV
MF9DTEtfQUhCTVVYIHJlcGxhY2UgU0NVMF9DTEtfSFBMTF9ESVZfQUhCDQptcGxsLT4NCglhaGJf
bXV4IC0+IGRpdl90YWJsZSAtPiBjbGtfYWhiDQpocGxsLT4NCg0KbmV3IGFkZCANClNPQzBfQ0xL
X01QSFlTUkM6IFVGUyBNUEhZIGNsb2NrIHNvdXJjZS4NClNPQzBfQ0xLX1UyUEhZX1JFRkNMS1NS
QyA6IFVTQjIuMCBwaHkgY2xvY2sgcmVmZXJlbmNlIHNvdXJjZQ0KU09DMV9DTEtfSTNDOiBJM0Mg
Y2xvY2sgc291cmNlLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

