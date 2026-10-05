Return-Path: <linux-aspeed+bounces-5132-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1E9CA5FCE
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 03:00:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hykfD3jQwz2yf9;
	Mon, 05 Oct 2026 14:00:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791169236;
	cv=pass; b=P7/iCGyQLHuZy2rEsqfYyxkrHEaHHCzrHzTyK3a84iFe18ICmLwRamnaCgzO7CzvP3n5UfEVFjC41axm5XU38OlD5qOVZ3g2lJ8tH33kt57whTN7XZqZFvkRRy3Tgg8C2talKO5U9X3PJPt8qjSTCjiG/yB+/md4OJSdbe/QvKH1aJib04XNJPQduvPpHShEZsVdkhybbuTI3f08zmehPXFmUFwFUtLbo2m9HcG0UBb1NjYSFIuYtJMjfh/X4PctYmdbVlVMgQ5y4Vp+6JPfKQYTUujdtPzpKzE0P6GyLWrSVfqKRCJf+UwXcNrOqcxoYw4p1umA/UfMRD6c38+TmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791169236; c=relaxed/relaxed;
	bh=AukHzc54MGBIda11PcUoJQ/tV8dco9udGmtpOQpwOdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvhJn2hwjh4PqVddGEC6bGRbx/KYu6XRx2gejePri1Hu/Yk2JAJd8oJCBE7tidnO8qcTUFKqCdWVmx5CcMWp7djSuC2YOH9FMPRJqPJwCYAcnL4Yk9PxDIqlmBfL68i79SdDex4r+zZzifgNZnBPWLetReDpQrJAC5BuXQ1Bk3JV59MvHIS1uKC0mriW45gWH+Sl0dyx+EJBVlj305LtmEAAvhFyAjpQNl2i7O/te/8exogPHvxsNk3xb5ACODqB95MsuaTSCOqgtGUeG8VFoupyh5FyHneXHSeRuB67Xx2RuNNaepbhbacLC271TM8CXKC6lsKLOZDkZw/mqjz1QQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=SioFNE0a; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=SioFNE0a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hykfC4cnqz2y7p
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 14:00:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVVVCes6znIVDyNqXR+kLwjRe2/Jp4wEMn6xrBowJhQ0tyY1afzRst/PZul5kXygNmHHi8F4OQwj3ksW8HLOLnhwJxQVFeQpwqhQ4o26ZA5OVWQoXk6IawbKBr5EgJq6UCTNjtxuw6JQaL9/b3PpRBmR49hRyUqrAW1M91RmZMZ6MduP1heZsRPRcfOCtw5Xla3xQdOJZzxLBJNnhF8CQwy0CsHc6cVKrvImVN8AEL5miVchI7QA8Z0SwkyBPOTmqEMjaQ+W3yI//7cX1hPVSZtMLr4M02gH63TIKFX1cOEP/bMyyUP7S1nS8ItOAEXgkOYhAqruJ8XMri4DMWECYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AukHzc54MGBIda11PcUoJQ/tV8dco9udGmtpOQpwOdw=;
 b=ZN/igjTW/Txirs33DDUuf9ZQ/5YDI899RaTIYY0mTaPyzrC98glUvfj7pQYZ/ONYqSECajSZGbyQPPjwvPJFxhzvwLckVvm0F7qwOTMXMFE77xzATU0mELBPM6r0XclUg5+WJr3GBX3umU5FItOxIIFG+lNhR06F96icFa+WvsC/k+YFDpfGoLPnIuwcXFouEwIh7jmEekLTgKBLC4mwitvCe9haPEbPAIRnyolgxkj3CloDen7gsCeng0dtrwYMBl7ZqPDLNvtSUsBfgNmSeC+yp/CcOcJDouJQYKLZE2GPsSkvyQ1KLQPESVcVRxCKAGJDsGUCzHWdQXSXjCKaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AukHzc54MGBIda11PcUoJQ/tV8dco9udGmtpOQpwOdw=;
 b=SioFNE0aZheSDWbuSXh4Ellxc411TukByV17tDUoUjOaWIRnssVYyNQ3GzpMdbJoZOw/EUAvJXeRYjR6+gqJohvXSLR2Bto44es3DU+BhQhURIyY39UZznMegk5bX9GsUs/G8tTqGLOpEcrH5mr1Woona/8eJoMNWrLhgzFjFP0RxrlRMwMZvHdMKdM8xYcjhNza7tu4qm8w/1A9wmqeBvFiau7CxAqsusRG8B8yXZm2qIPgjTXEZTM3abedXZ9sC6Q6ZXhHl9HpXXzvFH4Y+hLw/wPLMsB58Yqo3DtsNkG2imTOGb2BTu0fNvyWtL4FHUPn1hsymYSttp40xKLl2g==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:00:10 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:00:10 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Borislav Petkov <bp@alien8.de>
CC: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>
Subject: RE: [PATCH v4 2/9] EDAC/aspeed: Free the interrupt before the
 mem_ctl_info on remove
Thread-Topic: [PATCH v4 2/9] EDAC/aspeed: Free the interrupt before the
 mem_ctl_info on remove
Thread-Index: AQHdUJqnxy9a+RAslk6TaE5dk/Y1MLbt626AgABdSoA=
Date: Mon, 5 Oct 2026 03:00:10 +0000
Message-ID:
 <TY2PPF5CB9A1BE6A0885928E4222A0B65B3F2962@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com>
 <20260930-edac-v4-2-c2e526f3ed79@aspeedtech.com>
 <20261004212129.GBasLDWZyMyVNXIKmq@fat_crate.local>
In-Reply-To: <20261004212129.GBasLDWZyMyVNXIKmq@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEZPR06MB6488:EE_
x-ms-office365-filtering-correlation-id: b376319e-ee32-47ce-3eca-08df228cc516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|10067099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info:
 7vW9U1ct8+hpk7gpI3kgvWbVYxYXxl3X8wccv3ZIbzHcWllpy0GDFvUtScU34Lyflj7K5/2r+/ZsTG0/JA/7uSJZHMCkk4+IDbst/RAGNQkDl6My1pcktlQrrC+T8/y0lXrLyLGQhKfUvo0jo3p4tYxmdZpRbYsFGRgGe8Htz3KGYLFHyhkMf2DrbMlIYdaPnRifLQyaJ+sXp2nrnLw1ZzQbjyskd0rAxEBS02qMz5T7OK5EgoXdmj4aLRneCi2gpxt2j0nvsbQmN3Yb53ecqOfYqJ7x/aptf/fHvcPCyWIspwm1Jh6NOT6IbSMzPHs7jSz9sccmF5h6oXAGlJnAHUfUcdcaP7Poi9miD0nngfviVntqNMX6nRMnJKcDiOIJ44c60nSM3URHh4iXO3PVbi+I5AeQfXasQGmd0Mh4L0m07nMFrTOq4Z+8cn2lMQcL83/dT7DEVEJ/NIGzX/X01LzMNWQhNcB1eT46vKfx9bsbRBCU2297Vm6f4q4ojme6wIaoogmlONR/iwA3hXcXgBGWfW18pP1bT6mNtgzpG4i8loAjZuvCrkjSFPCXA0UIX30LBx1LcoKvzPskd3BILKR188Bt8Mf3AblfdKDVqvShaDrQ2rcrXoh0vj1Lfb+O8xNCTB+BxbZ5XL+S+dd3NRPLxEH69HKpjSrrId1gQk0ehLDtCO+bRrIReAUh1bBbuRWkBm1HJXNMxgpY6iKmpvvZGcNky4vfo+Zr0slegPk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFVtQWs0b0dvUDdpUm9OS3hwOGJqOFFINUNyOSs5Y3hkMnZlZ1ZKclhEY3Vs?=
 =?utf-8?B?WDR5dExURVAzWnhTREU2a243cnh4dVVuMXUvYmtnd2NYd283WmtyeHFRVDNh?=
 =?utf-8?B?V1lyeTRSK25BY0VoNGtrZ0FncDVFR0E3SEt0dmFLZnE2ZFBBU21tUXRKeXJo?=
 =?utf-8?B?TkpjQ1lncTQvUTZLSFFRdmVjeUZXeWVJNDlCbTlFclZYYklqMFY5NmVCc3NE?=
 =?utf-8?B?cjNwMGlLZ1JMR3ppOStCOVc2ZXBpQXJUb1lianltdC9xZ3VTcnFTcVVJcnYz?=
 =?utf-8?B?c0VDbVc4S2JCaXRCdTB1dkRyeHN6SXMwdnYzRHplN0IyY05IY1VXU1hUR1Vm?=
 =?utf-8?B?eTFseXdkSmVrT3N5Y2ZCN1p6ai9tanh4RFFOMGRSZG5POXYzbTErTkppdlNa?=
 =?utf-8?B?UGhMWHRNZUxMcWZRdmhHelliaWdFSlcyMGRlc2xKMGRpZ3BSRjF5TzA5b3Fj?=
 =?utf-8?B?RjhUK29aYnc2M0pwd2JoS2Z0bnQ1MjlZSjljWlRic214VU96cStrb0VHb2xH?=
 =?utf-8?B?QWs2V29qVWtEV1M3Q05tZ1BkaU42bVRnOHZpR2JFUjBSWngxUW1xQm9oMUVS?=
 =?utf-8?B?YWQ1am9iQXB5VkNDR0g5WjNPOHJVdjBZTzF4UmhSUkltNStBSVN3bm1OZFJK?=
 =?utf-8?B?aGt3T0c4VFdGeEx5N0JWbEY1M0xBU1E4aE9lQ0hsakpDMW9IckdaTXlnS3Rt?=
 =?utf-8?B?RFJtSDZzSlNKWThtTTdWYnJDc1BtY09nWFp3bUJoaHk0VE9zb0F0VDhSQUlQ?=
 =?utf-8?B?YWpweERzcHZjQ2lJY250MzErSG5VWjV3Z3BjanRxNkpaWitJZEV5a0FiUFRI?=
 =?utf-8?B?bEF1amhPRE5JeTZsS2d0MkFsNEg4eXRpeU1LLzZFb1ZUb0NHd2RxamlUWDJp?=
 =?utf-8?B?S0krSDgyYzhXWDlJZlBBbFFNN1VnUmRjWUQvSWhpSHZkUzZyM0lWY3JZc0JM?=
 =?utf-8?B?cG5JZHdjSCtVQU5MUkwrd3V0ME9NSTNwWFg0UWVjOW82L3pCeUpQTkhnNlZB?=
 =?utf-8?B?dG4vMEZpUklFOGsyc3A4di8vcDc1NGVZMld3V2VyWkNHQU9DcXBCQzhZV3c5?=
 =?utf-8?B?ckpyblhINTk4MllDcVIzZkplTHQ1eXA1elF4M0dENVcwaEo4akJ2WXRWekRV?=
 =?utf-8?B?dlM3YVBraDlFMFVpT2s1c1l0Z1JjMFFoWWlUZ1lrcDY5TkFlYWRSQk0ramlT?=
 =?utf-8?B?TVNwV0dTRWN2T3ZLeHhVK3BOWDZPTWtwVFZvV2I1QmtjRHcvNWJVWW8xTUNq?=
 =?utf-8?B?V2djWFlSdVVBS1JydkpFVmdNcnpYUUNzZHlhYzBoY0FmVzhSL1kvSDRHSkFZ?=
 =?utf-8?B?RElaU3lOQVQ3Nkc4MzZmckJSajRPUmNGaWh6OWdJKy9NWldXZEdWd1pYQnN6?=
 =?utf-8?B?VFFoNnZSeit4YXdFUEZ5YjFEUU5HSUY5emdUOTVJYWtYVmpaZ1VpcVBEQlVI?=
 =?utf-8?B?ZVBjUllqS0ZYdHoyWFE0MWg2NytVaXhxQWpoMUZPSStsc2ZHWHpYOG1QRXBI?=
 =?utf-8?B?WHBwUm5IaVZFdWtod2Z1UVEzSXkrSUxQRklNQmRUZ1Rhem1FeGtyb3JXTnAz?=
 =?utf-8?B?S1NOZTFEK2ZqSGg3QVNaNmg1SVdYN2t2UWlEVXBBeXF0RVNUQlprQjdhV3Ex?=
 =?utf-8?B?cnkyZnFPaG9MdjZRQ29wNVNtM08zOXJRSXFOMGFGMkVUYTk5azhWTnBEdmdw?=
 =?utf-8?B?Q0tMUDM4NFNBZk9oaStSaGtzL2F2MFdhUFd5YlVMZWdQcVhVZVg5UFR0M2No?=
 =?utf-8?B?UkZUNnpiK1ZJTkZFNm12cndBaXpjVDg5VkNTRmg4VkZCMklKbmRyaVFsOGdS?=
 =?utf-8?B?MVhPSlhHV2hjNVZYQ3RhdlFKbE41dlo4VlEyRFJ2NDBIQWNNdHlsTnV3QWlr?=
 =?utf-8?B?NXFBRmV6L2ZKNmZZQm5ORHpnL2NkOHNyc2hFZGJGcC83R0tYM2JKL0Z1RnN6?=
 =?utf-8?B?UTBLYUQ0aHY1K0pxeHN6aDFrNG1nWjJsZHNOKy9hWVl5QW13ZEtqU3R4U2NI?=
 =?utf-8?B?TW5hR0JTWXZaWHl6clpyRFBiaStucFlPMkF1dG9BRW5xSVVhRGhZRktJUERq?=
 =?utf-8?B?Y3BrdWY0RGJvZHYxUU5PSVJQSHVWVllidURlL2VnYW8yQnE4OThGa2NEcHN1?=
 =?utf-8?B?ajVOMTdvZkR5L05zVWpGamlSS2xybS8yaXZ3bWJ0SCtBQWhlMnFWckxlU1lh?=
 =?utf-8?B?Z2JJMHluRUxxKzROYWphY1Q0V0ljY2lDdzBKYVpmWGRSLzdlWFpXUjVMeDFv?=
 =?utf-8?B?SGY1cWN6RmtRVjBBT2luTTlrcHpQN3MxRjNPbGNOMDRSUVVNZ21oU1JkYXA2?=
 =?utf-8?B?SFRlSEs4Z3FGbEFlM1RPbktiZ1dLRzFDdUZneEpULy9Cd2x6VENpUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b376319e-ee32-47ce-3eca-08df228cc516
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:00:10.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtOjsbkAi/n1X/L+AJGcCqhAelDNbW3at//DT455VPC4Ygr6GL5K2CfHb8ZVusEdrHRNaRrVAtqo5Y+6E4YdkIPPcRBJm3EFNd2iAwQaFpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvOV0gRURBQy9hc3BlZWQ6IEZyZWUgdGhlIGludGVy
cnVwdCBiZWZvcmUgdGhlDQo+IG1lbV9jdGxfaW5mbyBvbiByZW1vdmUNCj4gDQo+IE9uIFdlZCwg
U2VwIDMwLCAyMDI2IGF0IDAxOjE1OjAwUE0gKzA4MDAsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiBU
aGUgRUNDIGludGVycnVwdCBpcyBkZXZtLW1hbmFnZWQsIHNvIGl0IGlzIG9ubHkgcmVsZWFzZWQg
YWZ0ZXINCj4gPiAucmVtb3ZlKCkgaGFzIHJldHVybmVkLCBhbmQgbWFza2luZyB0aGUgY29udHJv
bGxlciBkb2VzIG5vdCB3YWl0IGZvciBhDQo+ID4gaGFuZGxlciBhbHJlYWR5IHJ1bm5pbmcgb24g
YW5vdGhlciBDUFUuIGVkYWNfbWNfZnJlZSgpIGNhbiB0aGVyZWZvcmUNCj4gPiBmcmVlIHRoZSBt
ZW1fY3RsX2luZm8gdGhlIGhhbmRsZXIgdXNlcyBhcyBpdHMgY29udGV4dCB3aGlsZSBpdCBpcyBz
dGlsbCBydW5uaW5nLg0KPiA+DQo+ID4gRml4IHRoZSBvcmRlcmluZyBhbmQgc3luY2hyb25pc2Ug
YnkgZnJlZWluZyB0aGUgaW50ZXJydXB0IHByaW9yIHRvDQo+ID4gcmVsZWFzaW5nIHJlbGF0ZWQg
bWVtb3J5Lg0KPiA+DQo+ID4gRml4ZXM6IDliN2U2MjQyZWU0ZSAoIkVEQUMsIGFzcGVlZDogQWRk
IGFuIEFzcGVlZCBBU1QyNTAwIEVEQUMNCj4gPiBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gLS0tDQo+ID4g
Q2hhbmdlcyBpbiB2NDoNCj4gPiAtIERyb3AgdGhlIENjOiBzdGFibGUgdGFnLg0KPiA+DQo+ID4g
Q2hhbmdlcyBpbiB2MjoNCj4gPiAtIE5ldyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9l
ZGFjL2FzcGVlZF9lZGFjLmMgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvYXNwZWVkX2VkYWMu
YyBiL2RyaXZlcnMvZWRhYy9hc3BlZWRfZWRhYy5jDQo+ID4gaW5kZXggODNkNjA0MTRmODlhLi5l
MDVlYmVkNWMyZjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL2FzcGVlZF9lZGFjLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2VkYWMvYXNwZWVkX2VkYWMuYw0KPiA+IEBAIC0zNTksMTEgKzM1
OSwxNiBAQCBzdGF0aWMgaW50IGFzcGVlZF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ID4gKnBkZXYpICBzdGF0aWMgdm9pZCBhc3BlZWRfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpICB7DQo+ID4gIAlzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2k7DQo+ID4gKwlpbnQg
aXJxOw0KPiA+DQo+ID4gIAkvKiBkaXNhYmxlIGludGVycnVwdHMgKi8NCj4gPiAgCXJlZ21hcF91
cGRhdGVfYml0cyhhc3BlZWRfcmVnbWFwLCBBU1BFRURfTUNSX0lOVFJfQ1RSTCwNCj4gPiAgCQkJ
ICAgQVNQRUVEX01DUl9JTlRSX0NUUkxfRU5BQkxFLCAwKTsNCj4gPg0KPiA+ICsJaXJxID0gcGxh
dGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gPiArCVdBUk5fT04oaXJxIDwgMCk7DQo+ID4gKwlk
ZXZtX2ZyZWVfaXJxKCZwZGV2LT5kZXYsIGlycSwgcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldikp
Ow0KPiANCj4gQSBjb3VwbGUgb2YgdGhpbmdzIGNvbWUgdG8gbWluZCB3aGVuIGxvb2tpbmcgYXQg
dGhpczoNCj4gDQo+IC0gaWYgeW91IGhhdmUgdG8gZG8gcGxhdGZvcm1fZ2V0X2lycSgpLCB0aGVu
IHNvbWV0aGluZyBpbiB0aGUgZGVzaWduIG9mIHRoaXMNCj4gICBkcml2ZXIgaXMgbWlzc2luZy4g
UGVyaGFwcyBhIHByaXZhdGUgc3RydWN0dXJlOg0KPiANCj4gICBzdHJ1Y3QgbWVtX2N0bF9pbmZv
LnB2dF9pbmZvDQo+IA0KPiAgIHdoaWNoIGNvbnRhaW5zIGRyaXZlci1zcGVjaWZpYyBzdHVmZiBs
aWtlIHRoZSBpcnEgbnVtYmVyIGFuZCBzbyBvbi4gTG9vayBhdA0KPiAgIHRoZSBvdGhlciBFREFD
IGRyaXZlcnMgZm9yIGV4YW1wbGVzLg0KDQpQYXRjaCA3IGRvZXMgdGhhdCAtIGl0IG1vdmVzIHRo
ZSByZWdpc3RlciBiYXNlLCB0aGUgbG9jayBhbmQgdGhlIElSUQ0KbnVtYmVyIGludG8gYSBzdHJ1
Y3QgaW4gbWNpLT5wdnRfaW5mbywgYW5kIGFzcGVlZF9yZW1vdmUoKSB1c2VzDQpwcml2LT5pcnEg
ZnJvbSB0aGVyZS4gVGhpcyBwYXRjaCBzaXRzIGFoZWFkIG9mIGl0LCB3aGlsZSB0aGUgZHJpdmVy
DQpzdGlsbCBrZWVwcyBpdHMgc3RhdGUgaW4gZmlsZS1zY29wZSB2YXJpYWJsZXMsIHdoaWNoIGlz
IHdoeSBpdCByZWFjaGVkDQpmb3IgcGxhdGZvcm1fZ2V0X2lycSgpLg0KDQoNCj4gDQo+IC0gdGhl
biwgd2hhdCBpcyB0aGUgcG9pbnQgb2YgdGhpcyBiZWluZyBhIGRldm0tbWFuYWdlZCBJUlEgaWYg
eW91IGhhdmUgdG8NCj4gICBleHBsaWNpdGx5IGZyZWUgaXQ/DQo+IA0KPiAgIEJ5IHRoYXQgbG9n
aWMsIHlvdSBtaWdodCBhcyB3ZWxsIHVzZSB0aGUgbm9ybWFsIElSUSByZWdpc3RyYXRpb24gc3R1
ZmYuDQo+IA0KDQpBZ3JlZWQuIEkgd2lsbCB1cGRhdGUgd2l0aCBmb2xsb3dpbmcgaW4gVjUuDQpU
aGUgSVJRIG51bWJlciBnb2VzIG5leHQgdG8gdGhlIHN0YXRlIHRoZSBkcml2ZXIgYWxyZWFkeQ0K
aGFzIGFuZCB0aGUgaGFuZGxlciBpcyByZWdpc3RlcmVkIG5vcm1hbGx5LCBzbyBuZWl0aGVyDQpw
bGF0Zm9ybV9nZXRfaXJxKCkgbm9yIGRldnJlcyBpcyBpbnZvbHZlZDoNCg0KLS0tIGEvZHJpdmVy
cy9lZGFjL2FzcGVlZF9lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9hc3BlZWRfZWRhYy5jDQpA
QCAtMzYsNiArMzYsNyBAQA0KIA0KIHN0YXRpYyBzdHJ1Y3QgcmVnbWFwICphc3BlZWRfcmVnbWFw
Ow0KK3N0YXRpYyBpbnQgYXNwZWVkX2lycTsNCiANCkBAIC0zMzMsMTEgKzMzNCwxMiBAQCBzdGF0
aWMgaW50IGNvbmZpZ19pcnEodm9pZCAqY3R4LCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KIAlpZiAoaXJxIDwgMCkNCiAJCXJldHVybiBpcnE7DQogDQotCXJjID0gZGV2bV9yZXF1ZXN0
X2lycSgmcGRldi0+ZGV2LCBpcnEsIG1jcl9pc3IsIElSUUZfVFJJR0dFUl9ISUdILA0KLQkJCSAg
ICAgIERSVl9OQU1FLCBjdHgpOw0KKwlyYyA9IHJlcXVlc3RfaXJxKGlycSwgbWNyX2lzciwgSVJR
Rl9UUklHR0VSX0hJR0gsIERSVl9OQU1FLCBjdHgpOw0KIAlpZiAocmMpDQogCQlyZXR1cm4gcmM7
DQogDQorCWFzcGVlZF9pcnEgPSBpcnE7DQorDQogCS8qIGVuYWJsZSBpbnRlcnJ1cHRzICovDQog
CXJlZ21hcF91cGRhdGVfYml0cyhhc3BlZWRfcmVnbWFwLCBBU1BFRURfTUNSX0lOVFJfQ1RSTCwN
CiAJCQkgICBBU1BFRURfTUNSX0lOVFJfQ1RSTF9FTkFCTEUsDQpAQCAtMzU5LDYgKzM2MSw4IEBA
IHN0YXRpYyB2b2lkIGFzcGVlZF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJcmVnbWFwX3VwZGF0ZV9iaXRzKGFzcGVlZF9yZWdtYXAsIEFTUEVFRF9NQ1JfSU5UUl9DVFJM
LA0KIAkJCSAgIEFTUEVFRF9NQ1JfSU5UUl9DVFJMX0VOQUJMRSwgMCk7DQogDQorCWZyZWVfaXJx
KGFzcGVlZF9pcnEsIHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpKTsNCisNCiAJLyogZnJlZSBy
ZXNvdXJjZXMgKi8NCiAJbWNpID0gZWRhY19tY19kZWxfbWMoJnBkZXYtPmRldik7DQogCWlmICht
Y2kpDQoNCmNvbmZpZ19pcnEoKSBpcyB0aGUgbGFzdCB0aGluZyBhc3BlZWRfcHJvYmUoKSBkb2Vz
IGFuZCBpdCByZXR1cm5zIDANCnN0cmFpZ2h0IGFmdGVyd2FyZHMsIHNvIHRoZXJlIGlzIG5vIGVy
cm9yIHBhdGggZm9yIGRldnJlcyB0byB1bndpbmQgaW4NCnRoZSBmaXJzdCBwbGFjZS4gUGF0Y2gg
NyB0aGVuIGZvbGRzIGFzcGVlZF9pcnEgaW50byB0aGUgcHJpdmF0ZQ0Kc3RydWN0dXJlIGFsb25n
IHdpdGggdGhlIHJlZ2lzdGVyIGJhc2UgYW5kIHRoZSBsb2NrLCBhbmQgcGF0Y2hlcyA3IGFuZA0K
OCB1c2UgZnJlZV9pcnEocHJpdi0+aXJxLCBtY2kpLg0KDQo+ICAgQnV0IHRoZW4gbG9va2luZyBh
dCB0aGUgb3RoZXIgRURBQyBkcml2ZXJzLCB0aGV5IGFsbCBkbyBkZXZtX3JlcXVlc3RfaXJxKCkN
Cj4gICBidXQgb25seSB0aGUgRE1DLTUyMCBvbmUgZG9lcyBmcmVlX2lycSgpLg0KPiANCj4gICBT
byB0aGF0IHdvdWxkIG1lYW4gdGhhdCBlaXRoZXIgYWxsIHRoZSBvdGhlciBFREFDIGRyaXZlcnMg
bmVlZCBzdWNoIGEgZml4Lg0KPiAgIEFuZCB0aGV5IHdvdWxkIGFsbCBuZWVkIHByb3BlciBhdWRp
dGluZyB0byBtYWtlIHN1cmUgd2hlbiB0aGV5IGRpc2FibGUNCj4gSVJRcywNCj4gICBhbGwgSVJR
IGhhbmRsZXJzIHJ1bm5pbmcgaGF2ZSBmaW5pc2hlZC4NCj4gDQo+ICAgT3IsIHRoZWlyIGh3IGNh
biBoYW5kbGUgdGhhdCBhbmQgSVJRcyBmaXJpbmcgYXQgZHJpdmVyIHJlbW92ZSB0aW1lIGlzIG5v
dCBhbg0KPiAgIGlzc3VlLi4uDQo+IA0KPiAgIFNvdW5kcyB0byBtZSBsaWtlIEkgbmVlZCB0byBk
byBhIEVEQUMgc3Vic3lzdGVtIFRPRE8gZm9yIGFsbCB0aGUgZHJpdmVyDQo+ICAgb3duZXJzIHRv
IGdvIHJlYWQgYW5kIGNoZWNrLi4uDQo+IA0KPiBTbyBJJ20gcHJlc3VtaW5nIHRoaXMgaXMgU2Fz
aGlrbyByZXBvcnRpbmcgYW4gaXNzdWUgYW5kIHlvdSdyZSBhZGRyZXNzaW5nIGl0Lg0KPiBPciBp
cyBpdCBhIHJlYWwgaXNzdWUgdGhhdCBzb21lb25lIGhpdHM/DQoNClNhc2hpa28sIG9uIHYxIC0g
aXQgZmxhZ2dlZCB0aGUgdXNlLWFmdGVyLWZyZWUgYXMgcHJlLWV4aXN0aW5nIGFuZA0Kc3VnZ2Vz
dGVkIGVpdGhlciBmcmVlaW5nIHRoZSBpbnRlcnJ1cHQgYmVmb3JlIHRoZSBtZW1fY3RsX2luZm8g
b3INCmRyb3BwaW5nIGRldm0uDQpOb2JvZHkgaGFzIGhpdCBpdDogSSBoYXZlIG5vdCBzZWVuIGl0
IGFuZCBJIGhhdmUgbm8gcmVwb3J0IG9mIG9uZS4NCg0KUmVnYXJkcw0KUnlhbg0K

