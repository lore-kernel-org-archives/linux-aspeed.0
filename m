Return-Path: <linux-aspeed+bounces-1585-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB7C7EE30
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Jun 2025 02:23:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSzqS0LCqz306l;
	Fri, 27 Jun 2025 12:23:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750990980;
	cv=pass; b=mLnAA+mnMruRrJ+bJJUQikSF/KenT8HC/GnHOd2aslEmEfyCNWUCylwe0wRXuI9oniWB7Ewn3P7oCezbOzyU77tkFzQYg6Vpt/QcKS1kkd3CSyZm+Mo6ZYPnt9EvtQ9sR8g7D9Eo8VyD5kFU0MR98EpkI6hsN5LdHXj46N37lgKOKZWwhCX4BN/HUOUcOVIRodCRe2jqywaKItyiKaFzl6trNniU2utAcRDMwuYKo/HQqtyHvaSrtFIaxRSoiAFUKW/okFBdB745miZ71inJotuldvi+NQJVOJwHwlq6sFTMlCzSzot9V+Oox4cBJPvP9SwtMJvaZw6V9Chi1sqEQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750990980; c=relaxed/relaxed;
	bh=WLZryNFucTJuwvf4P6Iw3DFZ6W1KWtCwiitrkXi3Crk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjrgUFrXl/OQZ33QD8v0xefckV2fY84LDQwJzTaMfTpjB9uMUG2d6wvOqgCzGy6J6KaJBOU6CzYl1fwbfSLDNABYHqUJQMagGuparQNNmlQlgihtw8cfbcLkVp/1Ab2UKGCAZuHr1zUfV+ccGPDE4DdhEJXw6GI8Xr4h+tagR+pUN4tqLFazfBG9P4x/i5ovy+cinW6NYTLIbk7fIuf6zbioUXxGMEb7HDgD+71HlqRbnqkkhSvsdp5Lg14XnnSKH1VnyjjiNzTEMw8Oo2llNJxOQAdthsmvS5OsahvxkDOvnVFISCc2o3w/xvxc7YJCCBUla8xTyCFtRf9oL7nxQQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=KMoUetL7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=KMoUetL7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSzqR3yYQz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 12:22:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpgCRM9H6+ETld5X/BAZq5yGk4v0ZBGfDPpfvrtkBJ33tAyiLWMTQw9eTtoElVPCjWZhYQYYuejyyIo/MJUrsW2dOsa35VwZ7n+nUaUi7kRBRljPhUV1u4r6jO3yaB0TJ5+n4ezrkL7+fGEVhVITC0lpAyu+3j1cwb0qDn6+YEy52yMYM5ew0qUZJfQD8Zk+AuTq8fT6ADbofEAbqoIMHyiEE6vQtPT104WqvW59VlxdvNIG56BuCagBQ/fiAQaq/6JP1Hnp7C66Ff0cRX19Xd0wT7kRHPyD4cJXXN8/dsmleDnJrZYdPbZpuJbItTds5+A8TVkxgyKvL1qap+kDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLZryNFucTJuwvf4P6Iw3DFZ6W1KWtCwiitrkXi3Crk=;
 b=YRbHzt+PDvjbr4MgWMyQnbc9AugXc7om/v9Pm6gx4DsCMwzzwmwVYnMeFufBGcKeA5axJ8Rkzl8kQiLuDaLCsxV62AXnAB02M3XiC8k0xQ+xyNz3TYmT1MZkK3wod2bR8jmaR6v5qvG/gtk/tc/yZTNbWMMJtZ4ENUolaoh9g4mR8I2r5iMEKhk4aciua2/aM/nj/dsGuYxcGWo5pl8hMcLuqiBvL1QctRmkuDdH5t7INdmLZm8F3vqltUFnagL/Bsu08oJooIE6t21qfzsaPppYNF4fVGqEVwQewbM0qXW2eKUHgUWD59sD/BOgE8JQGrNYN7acD4sJysg8oet/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLZryNFucTJuwvf4P6Iw3DFZ6W1KWtCwiitrkXi3Crk=;
 b=KMoUetL75d+Lp8+bl7W/sUdiwBOwpIjRZTIwlgts5QJOADTwffmTEdy9/R3HnvTvv0qUvuuOpCa9Z8aDtgKOI13a/iploxn0N6oWslkWfwXEyCLLLtRwXfqU06JbbOSjkmqr8qvuzsqB9rWNZcdCOH7J84gaVPJZNbKY24o8L944AmoIjImwDKXHhogAQ29XlhN6EBCrfk89EpTfLul4BXRhpzDcWnZXfZR42hDS3U38/S0Vm1m/Zg4SEz7raMcV+Z/KBBcsjrhYgpASF1Xt0Ymke2506LVdVyb40kWHVhLvPXhMz+U1NnpKRIZ63/DmO1L4D30KlHnpxGu7v2xLrw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYQPR06MB8088.apcprd06.prod.outlook.com (2603:1096:405:2fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 02:22:37 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 02:22:37 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>
CC: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb5ejXM1vEEl7n4Euw0osJMHWsTLQWQJUAgAAH/RA=
Date: Fri, 27 Jun 2025 02:22:37 +0000
Message-ID:
 <TYZPR06MB6568D1E1CA64E22D7261F725F145A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250625073417.2395037-1-jammy_huang@aspeedtech.com>
	 <20250625073417.2395037-2-jammy_huang@aspeedtech.com>
	 <20250625155007.GA1489062-robh@kernel.org>
 <9efb52255ee55c6300f97c067d8cec606dab0574.camel@codeconstruct.com.au>
In-Reply-To:
 <9efb52255ee55c6300f97c067d8cec606dab0574.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYQPR06MB8088:EE_
x-ms-office365-filtering-correlation-id: afda3469-32d9-40fb-a455-08ddb5217bc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czZqQW15MkY3WVhiMUo0QWw5bXBINk5lTGFoVmhhZVhoY2JhMnczV2x3eDVJ?=
 =?utf-8?B?QVpOckVoR1ROWUxJS1J6aWN4MFJoVnVpQmNmSGpnbm8wMGtzYjJrOXYzVUth?=
 =?utf-8?B?WjJSejkvQ0NHVDkvQm45dStDdzNDWGxxdFVxL0lDeWhFNW0yWmFkYVU2aFNm?=
 =?utf-8?B?Z3U3NFFtaHFyZG14NVpOMGVkQ1laZXU2RzZtYnZ5TlVQMnlFalIvZGpiK2Rq?=
 =?utf-8?B?aVBzVU1sREhBVmttb3phZWRLRG5zbzdHaWl0N1I5Q1RZVDVHRWp2akl0Smtx?=
 =?utf-8?B?MWNhUTdLbytjZ3NNWjdqRWNUTEFSOC9DNS9tZy90YnEybm40MVMrVFV4RHZh?=
 =?utf-8?B?dTQ5Unh4b3psMk5KRklVdUhNMVZiYmJjR01KbnAyWC9ZalFMKzl6bmhXTjZB?=
 =?utf-8?B?UkdZRVhoNVRSaXNOdnJVUGR0aUJPY0x2bTQrZGk5T2hlSllCSXNmTE5pZzNM?=
 =?utf-8?B?N3BDdW9land0c0N6OHpHeUtzcTJUMjlSU3lBVktVUS9DL3ljRUxydFViRDl2?=
 =?utf-8?B?dlhGS1JvVkwrTW5tT0VWTi9ERDQ3RGJKWVRXeGw1RCtQbEdSZEZSdjZlbWw5?=
 =?utf-8?B?QlVEUGcwZzBTTlVRbWxvckxqTWZuRkZYWmh4bmY0LzBySHNRTHVCazlOQ2Mr?=
 =?utf-8?B?RzQ0VUZFTWl1OUNWK0Z4blZJMEt4Z3NaaTl4WGk2QTYxZ2lwTjIxY1IwUjlL?=
 =?utf-8?B?N0srL01ackNmUVhCdVBrSXhYTklqTUZFcnJ3c05GeENwdkpHZDR3a2tBWVhZ?=
 =?utf-8?B?UnJjeVR6bkFiL1lQL1c1RWdUSEZDMlBkTjVGNGVRdU1oc244dXo4R0FoY0Rq?=
 =?utf-8?B?dU1ycnFFc2ROOEpuQWtJQklGb0IrUUE4V2NPU21NZWYveGlYL1ovWjRDYk1o?=
 =?utf-8?B?Q3JCeHR4QkhpeEVGM3dCS0NaaUdMRlBuWGtGakMzaXlkc2Myc1lKNEJJZ0x6?=
 =?utf-8?B?NEhjams5Q2UvSTIrTkV2c2Y2Q3lnTlVMT2QzaEF0SUhSNW02ZUlnZ3pBR1pN?=
 =?utf-8?B?MnY3bFpsOGVrdlQwa1BsLzVYTUtoMzcxMmUrN1pHdFhkdDBlejdpQnlPOHox?=
 =?utf-8?B?QkE0TWtZMkNlNEp2anB4eWE5dmNJbkFRUFNnRGtXckZoME5jSnp2SWJEcmJ2?=
 =?utf-8?B?MmNuTHVaUXlyeVhIRldKUTZjeEk2aEUvZUFvUXBWNnRoTGZVcjU5NUlQNk03?=
 =?utf-8?B?T1F2cklUMVY3OVhYMXd6N0hOZGs1Mm1TUml0MU9QTS81Z0ZTTkNXbW5iTHd6?=
 =?utf-8?B?RkdVd1RtOXBPQ3Z6ZzhDLzBxRk0vS2pvbXVuY0pnUTE0SURCR2EyR1FFTXph?=
 =?utf-8?B?OTV1RG5CZHBSRURYT3JKNGtLYlBNZTNodVdNSGM3VHJVd3BsOGJVNXlZSFJl?=
 =?utf-8?B?dkNJbzNDckppeXk1UVVJR2xQZm14V3ZqSWczTmVDRGdmN2NVcUxzRk4zOGJw?=
 =?utf-8?B?YkVzbHZzRFRKNWFUTklyK3B3RU9kanl6QThaRDZNdXR6aEJ1aitZNUtZRVdP?=
 =?utf-8?B?NGwzMmZGMUxHZlVTbXFCdmIyTjEzR1FjbG1lMmZQSDdJVjhHWlN2cTJ5K3A5?=
 =?utf-8?B?SzVhRGxmSGdEU2RjOTAxSmNxUjVuaHN3NFVaTkxEOHI2Nkl3d1FNQWV3dVVR?=
 =?utf-8?B?eDBZWGV0NkZNSkV4ek5qcFljNFNGMDBJbWRFVGdHd29HU3FIcGFCNkx3TzA4?=
 =?utf-8?B?eTRnSVNETU9BeG5rbnd0REN1VU1uSE9Xa3djKzU3M0hBREpEVVdxRlpMV1VX?=
 =?utf-8?B?WHNpVHhDVzh3SllaV2pGLzRQMmU0N2ovSXJrMHVHL2ZBb1dMbnJvZjdlNHlv?=
 =?utf-8?B?WitPSGVYTXFRWjFXT2JZczJYaTR3WDZuS29jK0VkcnNtbXc4UXVRVHlTdlN0?=
 =?utf-8?B?SmN0c0hNWFhrZ2k2U2FpVWl1RS8ySkU5dDQwZGs0c1RnVVVIeG9hTk90QzVR?=
 =?utf-8?B?RmNsNCtSM2Z0U2tjSDRxVkZoS0pNZWtmQ1g5SVBhTTlmMGxNK1Vwb3pETE45?=
 =?utf-8?B?b1dNUG1ZYTNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnBQTkNlK2ZNdjlVSTNTT2dqRW5vbm1scWtNenlIeGdtT3BrNDJOdG13dmFh?=
 =?utf-8?B?cGo5b0lSZWtQQTJjTnliTUtNYVlVNlhkWnZHYk5TcjRueUkvbUZ2VzFqanpS?=
 =?utf-8?B?TCsyZlozV2pnOXN6ZFlaYnBPODJybzhuby80WXpLZzIwTGNVV2RDSjR4OFNs?=
 =?utf-8?B?ZzZGK3hUTGYrbXA4RWZLMTFjWHRjckdnTndmS0hFb0Z6elpQWXB5bFZETVUz?=
 =?utf-8?B?WW5lT2JjY0RUWnBLWUZ3WDV5djFHaURpd2w5Ump5a3E5OUlrbkRib3p4dzRC?=
 =?utf-8?B?WVhzSHM5Si9YWnF4MFF1eDZ4WG10MnY3bzJydHFGU0lpNC9QVmFyZHErdTZj?=
 =?utf-8?B?QXZWMkd1Vk85aGlJRGFGMGtTckl2N0NKY1Y4YVdseWE0ZlR1YWdPcHpveFBk?=
 =?utf-8?B?Q0h5c2d4cHJVYkpjTFdPUk1HVVBNdEVtRHZCNEQvZ2V0aU1EYzlBa1ZJaWIy?=
 =?utf-8?B?Y2pJbkhFem0wV29WQTAyTmJDbjg3MzlsWDYxZndmNGRTdDdyL0dDcFpza2Nh?=
 =?utf-8?B?ZmpMMHNsdlgvWXlILzlKaVJoR09qUVZpdHpIY0d4Z0NGRjdaVWxSbXBmMS9V?=
 =?utf-8?B?NTNlY1BqeU9qbnBKTElTMTZtZFJmdHBYZzBiNFo4a3pWRHN2Q1FnOXlPUVQ0?=
 =?utf-8?B?TE1PSmduYzhOMjhsa1VFaC83eXN3U1lGcUZCOGxpVVl4aGl3WTlocG1GMnVl?=
 =?utf-8?B?cytEb1NzZnJGMldaTlRFczd4N1h0Vk1YS2V1dU80NzA1QzZHaVlTcjVIUnlK?=
 =?utf-8?B?VkphTEVzTHk5ZkhCVVpKK01rVkl6RjcyUkExSWlaV2g3eUJ1VDZ6UlZSL1hZ?=
 =?utf-8?B?cUZsNkQ3Sm5yVk1QT0dkTy94UGJWR21VQ2VLcUtWWUh0cWh6V2t3dThzMzVI?=
 =?utf-8?B?Zm9UdjZkbEVxNFBYRUNmT0pXUEs3ZEdERmVDOEJ3b1lhUlZoNDdEeXBhbSt3?=
 =?utf-8?B?MW40VDVrb2RkaUFGSkh1K1A5bVdVNFBUK25udHZSTlBSd29TSmEzS1FXeFNv?=
 =?utf-8?B?YmJoUVh1dHNvYytvNXpKU3pJV1J6YmcyK2VxTXgvV0RmRzVxYVdySFg4Si80?=
 =?utf-8?B?ZVFZZU5TcWJZUUZ5djU2VFdvbEpDTGlJbzlEck1Dc2dmcGJWbHlnNlVFaXBS?=
 =?utf-8?B?aGY4TFk0RUdNalZZSElvOXdnMEVmNjlyRHhqWG10WVRQOU1QWnF4TFl4dGIw?=
 =?utf-8?B?L0xmWXl2R0NOWHhoN2JPUWw5SkVoaEhwVnNRNm15WTBQOTZWWmpRZmZBMmRS?=
 =?utf-8?B?NU95NWVyY0EvMjFaZ3VkQnp2MTBhdGY4cmc3VVh3RkR3Mk1Ra3AvVHVGU0lw?=
 =?utf-8?B?LzkzSi8vZ1BEUHgwNGRrVWF2dFJRRjNYV0VDdDNDYjJkbFFDeUljeDFnejJW?=
 =?utf-8?B?ZVc4NHAxOHhTM0ZXbWhKcTRUM1FMeTNjNXBITkkzQUtVeGQ1eEQ3SE5nYXFt?=
 =?utf-8?B?K2ZnN3FaVXZzMlJHWjlueFROck5WckhscE1DUUp2MDZ4Wkc5Z201STdDa2Ri?=
 =?utf-8?B?SG9FbU5GSXh2U2x1MFZzbDhERkJqMmp1SWNXZmxGRU5OeTVOQzRpUE5oR2lu?=
 =?utf-8?B?ZXkzYTc5RDNJNWUrd2ZlT1NGYlpBRVZrZ0ZsKzhlSjBIcFEzYlJxQmxYQ2k3?=
 =?utf-8?B?YTNBSUROcnc1bysrajRQMmFjRFNMQURaS1k0djA2K3hwWHJweFR3WTdGamhB?=
 =?utf-8?B?a3dEd0Y4a1JtRVdGczd1WVpBeEd2Q04zTlJoM1pBT2NZc0ljSjhVaytYQzdD?=
 =?utf-8?B?cXNubWNmVkFYWDViQ0RIckpVZ2paa0N6aWZhdzI4T3labnZad0xlZUNhSU1Z?=
 =?utf-8?B?dW1SQmJZaXhFSFRzeGh0cjFSRWo5SVlnRWVUTkhYWlpaRzJHK3NqeG5nMitL?=
 =?utf-8?B?TlZGeEZuWUo5Y1V0K1h5UmJWcU5pU3RjbHYxN096NVIybkkwN2xXRW9WUlFh?=
 =?utf-8?B?RXRLR2lyTVEwTGxCaWdLQXVFSkNWV2VnWmNWVjJWM0VnM0VIL2RXTE1HR2dT?=
 =?utf-8?B?MnFMNHFyNHBLNlZEYk1LYUMrTEpzQUtvKzVnU0RadVB6c21vMlJVaDkydmhD?=
 =?utf-8?B?YnF3V3NFbWxZM0pyWU4wMFVtaVdaS0R3Q2FPOWIyMTE2TUVpcXI2S3dGYWVs?=
 =?utf-8?B?c2NEQ29XeWlzM29CZndxSzFSSm9yYnM5Y1QyYTROL2huNzlkcmpFWXRFS21X?=
 =?utf-8?B?NWc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afda3469-32d9-40fb-a455-08ddb5217bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 02:22:37.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLc86/YyoK0HTBnOlhitn4NGGfSxPLcxX9kZMZl2llPPPRFvtSQpNQR7nVS+40lYYOg3P2MwBB/fsH0THJUdHPgfOF736DXZFc7jOvGMxYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8088

PiBPbiBXZWQsIDIwMjUtMDYtMjUgYXQgMTA6NTAgLTA1MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiA+IE9uIFdlZCwgSnVuIDI1LCAyMDI1IGF0IDAzOjM0OjE2UE0gKzA4MDAsIEphbW15IEh1YW5n
IHdyb3RlOg0KPiA+ID4gSW50cm9kdWNlIHRoZSBtYWlsYm94IG1vZHVsZSBmb3IgQVNUMjdYWCBz
ZXJpZXMgU29DLCB3aGljaCBpcw0KPiA+ID4gcmVzcG9uc2libGUgZm9yIGludGVyY2hhbmdpbmcg
bWVzc2FnZXMgYmV0d2VlbiBhc3ltbWV0cmljIHByb2Nlc3NvcnMuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogSmFtbXkgSHVhbmcgPGphbW15X2h1YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+
DQo+IA0KPiAqc25pcCoNCj4gDQo+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ICvCoCBjb21wYXRp
YmxlOg0KPiA+ID4gK8KgwqDCoCBjb25zdDogYXNwZWVkLGFzdDI3MDAtbWFpbGJveA0KPiA+ID4g
Kw0KPiA+ID4gK8KgIHJlZzoNCj4gPiA+ICvCoMKgwqAgbWF4SXRlbXM6IDINCj4gPiA+ICvCoMKg
wqAgZGVzY3JpcHRpb246DQo+ID4gPiArwqDCoMKgwqDCoCBDb250YWlucyB0aGUgYmFzZSBhZGRy
ZXNzZXMgYW5kIHNpemVzIG9mIHRoZSBtYWlsYm94DQo+ID4gPiArY29udHJvbGxlci4gMXN0IG9u
ZQ0KPiA+ID4gK8KgwqDCoMKgwqAgaXMgZm9yIFRYIGNvbnRyb2wgcmVnaXN0ZXI7IDJuZCBvbmUg
aXMgZm9yIFJYIGNvbnRyb2wgcmVnaXN0ZXIuDQo+ID4NCj4gPiBJbnN0ZWFkLCBqdXN0Og0KPiA+
DQo+ID4gaXRlbXM6DQo+ID4gwqAgLSBkZXNjcmlwdGlvbjogVFggY29udHJvbCByZWdpc3Rlcg0K
PiA+IMKgIC0gZGVzY3JpcHRpb246IFJYIGNvbnRyb2wgcmVnaXN0ZXINCj4gDQo+IE1heWJlIGFs
c28gc3BlY2lmeSByZWctbmFtZXMgd2l0aCAidHgiIGFuZCAicngiPyBUaGF0IHdheSB3ZSBjYW4g
dXNlDQo+IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSBpbiB0aGUgbGlu
dXggZHJpdmVyDQo+IGltcGxlbWVudGF0aW9uLCB3aGljaCBzaG91bGQgbG9vayB0aWRpZXIuDQpT
b3VuZHMgZ29vZC4gSSB3aWxsIGRvIGl0Lg0KPiANCj4gQW5kcmV3DQoNClJlZ2FyZHMNCkphbW15
DQo=

