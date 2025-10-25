Return-Path: <linux-aspeed+bounces-2611-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBD5CCF9E0
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Oct 2025 03:16:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctlKX5SP5z2yrq;
	Sat, 25 Oct 2025 14:16:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761362176;
	cv=pass; b=T07HnM7YhlEZ+be3mhgKYpkpkUuvUPo7yqZZ05Ov+gjwjOJojWtzU49CnocIiPXyCe95hYy2ZuYNtb+2iaoBDTv4Sny34FsaSD3VqZlTNFjap8ij+xc9qbEE1mnDjn2AuI3ZdRNz++tbagkUcTTZaGY3ltpz2DLOclDZQNPaSGg45VSj1dkcQMkKgHF/+qN8Ll/2dXmaaPD6Aqoc2Y+mP/coPtW0BYx8ndXRZbQ14oEsQPMdOVpOsmHwygP4P4HUH/pqhyDazq1MPvjxaxc3mFwt4reuYpBufGyG3ed2iAkh1iCvNIGo85LiPIHOD56RNpyRYGri3CIgPHWxqH/3WQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761362176; c=relaxed/relaxed;
	bh=3PEC/wcOj+17yawk14izvvo4xQr8PTjZXSPTJvcoL7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SDCdgYIBQAvCCVoGjO58myeyQUhfu2Mk0dMvpgARoJYbVTXTK/9LV9ql373YEu5TtORS6Ote+WW1uNXV4Pesu/hbTjL2pi2yv6DLpZw7kiXsU2WGeMN4cQ8gGUask6JbwIqcB+6SscmTwpn1ajLvQFjLi50hPyBOM8O9FEb571ue+pgGOkRhno0dgF37ljDwynwsAhn8SJAbPb5Ad0fAn49Ylu2ItsKCVAbk2vIeoYP/ONaHYD+iY0Adxv+jBHcRGmKK565mYn9iltlXml4HbBvmYi+RMM1qSOyii8GmDJfq3WTFxmlyk5h8hauqm6XepNcOGmG1sXU3mSE170TPqg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Tbu14re0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Tbu14re0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctlKW6Ll2z2ypW
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Oct 2025 14:16:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqfuVroA3MPsYHrOJQ4IWwyfhnT45DMPSsezapPzAYadWzw0Q6utDYBI2pZzrh3oal3uo0Y+5/ike6qmQfDZfsRRLup70ftA3eGyYCT458lh8THv7asWcUQKi9NUbeUsZbqlOiBLoDsH5syruBZe4+gs/uIJ7TFroawfrIkF5LS8H9bEkLBwd20hTMnWKuRxTHPwZBojX9DCpG5WDHdK1dder5u1E+JYvyB7ihNsBV5gZxerDpLW5pTTVTvv+3D5iYX4ZlwF/ym4M5cbfnJG91UyeoE3CxMFdCWWGaiEdrPZ5frZa5UbqjM1NHgaFS7p0ja0RL3u2SKhQPgonTSXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PEC/wcOj+17yawk14izvvo4xQr8PTjZXSPTJvcoL7w=;
 b=SSCeNubl3zXjprwGRd5hMmvuoEZZWBg5cfg3MnTHt6N2P1eIIWq92w9+ItKhkzacF4t6S8+7LEPdhsihs1o/yMiV+BW2ix4Z+K7i6BU4tyfymyxTaOhW7o1+WOPsSTxsT4SvGOwTCJDZbZMzrGwh2iwtDjaV6rO5KATZ8qv0FDaiTpmTrbVCho1Ne7wZCoyRQbKiqQWrQ5yBi6wXNvvI8B1VFOCROvGzAzHF7S2lRhAQB0rWv20HZMZJKvxZT7khAf6YUo14bfLZOETiVVITJVyDhuSXKvLtIEOh67mtU8AuGT7+sLrToHBz3GtjwUP8gub+PjIN+3rUpyEwzn/YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PEC/wcOj+17yawk14izvvo4xQr8PTjZXSPTJvcoL7w=;
 b=Tbu14re0WL9ki5ogM6eO5ivvpNpeqNMT1sVVPmDdBOlXfRX0AJ8Tf/2MTCzYIb4g42+cTzIUAkFC0iqTMKu56XM2W6m/T9g0JyKZBK8FEwDF26uFfay+k5xjoBUE5rFgpJ9glqBcHh/tcosaw6BeDmv21rUrXP6dX7eknd9h3uI89nLHYFZeqwok0IMlSIS6GhQTrmFFrPgEUwdVH9XrF2VHxJ1NPWtpdgPG2U0UNDwWS2i45o7TTdhoTdnV66KYbGrF/u8fVifz52bW1VbMlOh5cmM6e4IXfDktR4eflWVwPkDn33/QlNmM7bWl9nVOx9CDngspcKr2ZpodmvD7Yg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB6183.apcprd06.prod.outlook.com (2603:1096:101:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 03:15:51 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 03:15:51 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
CC: BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bjorn
 Andersson <bjorn.andersson@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>,
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>, "Lad, Prabhakar"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
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
Thread-Index: AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAxTaAgAFDg3A=
Date: Sat, 25 Oct 2025 03:15:51 +0000
Message-ID:
 <TY2PPF5CB9A1BE6085479040799D70F4BECF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <CAMuHMdXTZZK-Tk0gerpARfr+jUNGPhEfRqGOtTvTTJp=SZ2ayg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXTZZK-Tk0gerpARfr+jUNGPhEfRqGOtTvTTJp=SZ2ayg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB6183:EE_
x-ms-office365-filtering-correlation-id: a17df097-e4a4-49d8-01c9-08de1374cd58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHdkRGgvZ3Yzb0g5d2k1bmliTGNLWjY5eEc3dWFqeHBBUUZRd2JHa2Rhd2Mx?=
 =?utf-8?B?VXNhMXNIcmlFaTVxT01YbXFZTERUSTVPQmpIOVBuQUVYSFc5M0dkOEhxaFFi?=
 =?utf-8?B?Sy9USERkaWFzdE1Sbk82WVUySzVnN1lneDE1N280NHhacDJ0TnQ2KzhEaEFS?=
 =?utf-8?B?OWVIM3kvbWgrMVd0ZjZucE5HMzJjNVZiWWs3ajNTNC9RcDdTN05wVTRrVlpj?=
 =?utf-8?B?N3Q1U3QxbmVMSG92Zi9uTFEwUkVUSEdpQ0hzYWRFa0E5ZDAxY1krTVJqc1B3?=
 =?utf-8?B?Qnh4d25JK25HMXYvNWtYNm9jOVZmOWJUbm0vUm5EV09QRy94UmtVMHpCSWFY?=
 =?utf-8?B?aU10c1UzUXFnUEtjWnloZndwSFU0a1diQlZVOGlJK1lSVFFQMWVTeEVoaW5z?=
 =?utf-8?B?M2hIdGFBYmkxeUU2WlpXYWZIK2VyWURFZTFycUdHTG9RV1VwMDNTN0hvY1dX?=
 =?utf-8?B?RXI4aEV4aXZ4OEluSGQ4RC9iWHYvd3ZwUjFnTkR6cVpPbmQ0OWFjcThMY1Rw?=
 =?utf-8?B?a1JkZ2J2RnE0bjJFLzZZeDl0Zy9TUGh6anpnRGJQSHA2SytNMk5jV0VQMDhX?=
 =?utf-8?B?Wmk3TjdoT3dwekJ0QWI5K1FvOGd4elFTZnlOR29rVDdsOVZNYWlkYzFrRU8v?=
 =?utf-8?B?bWRQMHB2ZHhhbHFRMlRCckhLRzI3bHZ6OTBaSjJrSGFHYzRCYnNPZ3YzL3dm?=
 =?utf-8?B?TjE2REVWWHVIbjJYVG5rUjc3TnFiQTFEL0ZFUDc5Q3oveXJPZ0o4eUJDZENa?=
 =?utf-8?B?NytrQWVOWEZjM3F6eDBabFdaeFc1U1QxMkpIRGlydCs2ZUg0S01CTHBKaGR0?=
 =?utf-8?B?VkRpQTZBdHNIVVQwRkJoM0Z2SFA4WSt6WUswQnN5a3N1UFRqelJQbWdZR3Qy?=
 =?utf-8?B?OUFrRDZtbkwvM3VDNDQ5NE9RakNPYzZrRFAxQklBblBUcnhjdmZZc1RXSHFj?=
 =?utf-8?B?Z3laWjFIWis4TW4vYlNPclVVN203cVZjMmJUMi93Nm1tMXlmaEp2eDMvanFm?=
 =?utf-8?B?VWNYWGhPcThCYnBURC9CZ3k4V0lHUHMwOHFuMSs3dDVsc2JNRmJ5cFhxOU5u?=
 =?utf-8?B?Skx6bFBTWkNxWGF2U3BObDM0ZUJ6OFlaTDVtdExOU00vQUZiYURRcU1RaFF6?=
 =?utf-8?B?NVlSVFlzbnF3cWtnM1drQjFGYzQ1N2U1ck1RbncwSkNLZi9iekE5d3N3WGxQ?=
 =?utf-8?B?UjFhR21TNDk3b1VVd1dCb2NVUStCMFFZdGZFUmNvQkZjK3ViYzB5OWZnVW9s?=
 =?utf-8?B?WlJ3anZPcnB1Y0VOekdocFZTZWZjUUVYZG8wOHpQMG1lQUtSWUUxaTNPTWNZ?=
 =?utf-8?B?Ukp2SElZNGpScHZUUVdKVS9jTm5oQmY5aWtId2RnZmY0RjVwSE9DOU53Ykk4?=
 =?utf-8?B?dE1WQVg0ZEhnRTlPQXJmMUN3UzBEYk5XTUJybWR2Q0UvOHh1d2Voek9RdzNO?=
 =?utf-8?B?T3RmQy96WXg2emMrWkNqQ0dkSDZHbHRPNFhWYlByY090TVM3NFBQL3kzN0lS?=
 =?utf-8?B?TjZIamJCOFFoeEo2RFNTNFlMdjVLRC90NVB1THJXR2piMDY2Tm5LaTBNZFBl?=
 =?utf-8?B?eGJINHdrd3JQWkkxNmt0QVZ4ZlRLanJkOHBiL041QUEzYU9YMmJPTmRFWGxI?=
 =?utf-8?B?SWc0UUNsWC9LRTZwaDIzL2R6L2gzcnBVU1A2eG40M3VydXZFOHNpR3JPUG1p?=
 =?utf-8?B?R3RVeXVidjNMcVZXaUhwb3IzeWRJYTJtVmM0VTFZeEZidE9pNDdTUUtmVmxR?=
 =?utf-8?B?QnVDa0JiMi9ncWcrNjJ6akE1TmRsSnFadzhXLzQzZTNRSGpPWTZLZElrL0FN?=
 =?utf-8?B?UEtkN0JacFRPSGRLaVNyTXNrRWNVcXdUSS84V2sxdE5jRjcyY0ViczNxY2JX?=
 =?utf-8?B?V0hHQ1NtS0psSmUwSEMwN2ZiMnl4b1pwb1FXWDNCWUdjT3lQazZHeVZXUXFP?=
 =?utf-8?B?VEFrUE93RFlEYkwzQ3pYdWRIdy9GQzV2RUxSNEVQajlTRDhrb0VOTVdnWE5C?=
 =?utf-8?B?S0U0WTdJKzBCbFdwWktKd285bU85dHo1RVhaQVRaaVgrSy9mYzFXdG5GVUVs?=
 =?utf-8?Q?fmIfEM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elpzVkZNQ2l5TGYvSm4vVW5ZT2ZOS0RBZE9QUCtwMWJ2YytvU1N0NFBTSFo2?=
 =?utf-8?B?N1o4Q1hwMCtJNW5YYXhncmdNMmRnVUh4amVMbmplbHJWYTQ3eFIwc0JQRi81?=
 =?utf-8?B?VDRmVFdyU1ZGdjBZRTd5R2M5R01JSTZLQ1RWazY0ai9ZcU5XR0FjVDZCQlpC?=
 =?utf-8?B?Vm8rYjR5TklIVVUxYlVjRkU4QUdaMlFGazhZamJxNlpqT2FlRStTMmk5L0hr?=
 =?utf-8?B?c1JVWWFoSzJHSWhSMXVFcmhmWHFIMXNhMTdDaDVJTkVPa09SaHpONUJrejg4?=
 =?utf-8?B?UUVCZUM2QXlRN0hVTkZmZjJoK1NTazVIWnZDN2k0enBJRUh4T0dkc3pMZkFl?=
 =?utf-8?B?UmFKdHF0bVJDSnpjZEY4WUlwTmdjdXNWZE9iZ3BSWUNRYThFcm1UK1dwOUlB?=
 =?utf-8?B?d3M3bUpvMVpDUmd0Z1JhOWNsdHJBWTI1cFd2aDE4Ny9pWDdUTkJQQ1VCN2wr?=
 =?utf-8?B?WUNCalBiN2U3aHB1MC9WU2Z3MkI4Sjg5S2NCRHZnditmam9lSzlnd3NnNStM?=
 =?utf-8?B?VFUxZGdoSmhZdnYvdit3UUIxbVdlYm5qVS9FQVVNSEJCV3VubFZ1ZVFYNGMx?=
 =?utf-8?B?eG05dVFwaDA4a0s2eU1nTHY3dTFUUkVIVHdQVkkvWGZaN21DN2ZzU29LZndy?=
 =?utf-8?B?dk9LeUNiTUpmUXBkQzJiZ2djcHZJMGlmaDdXSUY4N2ZUenk2QjlHSVFWZWdu?=
 =?utf-8?B?K284QlI0VVNxN2FHeTZrQlgxbGJHcjBPVEkwc1lLc3FMK2FmazZRc2MvY3R1?=
 =?utf-8?B?bi9MN3BvOXRyRitIdHM2c2dNakZQYnhmL2F4YWROdzBNS0s2Mnd4VmQwZ0Vs?=
 =?utf-8?B?WHh2TDAwdEgzK3B6eGRlSzRTVmkxamw0d3g4TEwyaDdXTzlmRzZMejV2d3lO?=
 =?utf-8?B?MXV3OHJPUHFwNkZhZnd5QWk5MnBwQUhnQS8wRkF4MGFXZ2pERzcwbC9MSEFi?=
 =?utf-8?B?TTBmeFkvbWZvZTlLVDFoU3BiSVF5bDJsVURUNE1rL1BWNGNQdFNEQjZNUEFO?=
 =?utf-8?B?L1V3VHlwejZrK2lLZmV3ak5LbVpjZ1MvMmFjeDFBVlNuWElpZSs5OW1KODcy?=
 =?utf-8?B?dFh6SSs2ZkhTWE1NT0Q2aXNFVDhjWGRhaG5nOEhkYkUxZWZUaDlkUyttUU9E?=
 =?utf-8?B?S0poWEQ1R3ltb1UrL054R1p3SDR2UFppVHpZWnBUaWNjOUJzbnR0cXRKQTRK?=
 =?utf-8?B?TmkxdzdIeGllYXN3U0hUS0NBU0YrcXkvWU8vYTFGTHJkcXN5WlFsQlpXeXZh?=
 =?utf-8?B?WEpzTHdqR2xDSklpYzJYaFVLMFpPdXRkd3hHVGFVd3Vxek9GVnJGTXNpNEl0?=
 =?utf-8?B?c1c1emVaRm9XOEgzUldKTXc4N3pEOXp6NE8rZk03L0N6OHlTL1RTSWUwbUdN?=
 =?utf-8?B?Uy9yM0NZYlJpKzJvdzZSZzU0QlFJTEo0bFhHeEw5Unk0YlBoanhaalpDNE1h?=
 =?utf-8?B?cFZDNFJDVXRUbnJrdmNtaThkdzVhaTlsckZMdnBHRDl2dm9qRTRyNGVKblpY?=
 =?utf-8?B?cXNDZjFoWVNERG5tMUoySFgyOTJoc1Y0VEpsVVEzU1c1eTVieWs5Z1EvWXg1?=
 =?utf-8?B?bkhUQjBSajNGeHM0OEl0Tk1kbFRTeGZhdHE1b09mYnBsZmJla01QbGkxVGNC?=
 =?utf-8?B?MnlPOTNld3gzZjFBME1HRDgyaVFVaVRVdWVkY1pIbkJPdDNiRG1rOThkdmlw?=
 =?utf-8?B?TGtLRE5JM0orMUNMZlA2Mjh2Zzg5c0I4K2NoUW04T0RpcTRXb0VUTzhURUpV?=
 =?utf-8?B?U205N3FNUlgrbnlERVcwSDZMUGxjVUtpZytPN1lVaXM2dFNEYXhNNFFES0JX?=
 =?utf-8?B?L3hyWGFIMWlrTkEyWEd0MHRNVDFUOFFNRVRUcEFFTURMM1VITWhYaFV1bnJW?=
 =?utf-8?B?eUVscnliTzJMb1FlaWJJNHlLZXZ6NkZldGJKRW52WlpRWXNTQm42OFBjWmw4?=
 =?utf-8?B?anZhT29ybFVaYjNFS0d5YnMwaVhsblBieTRFalhpUHk2VmVXUHV3Q0RYSm8v?=
 =?utf-8?B?REtoSlNVNVlaRWFjSEJsaWZiZ1NzeEFDVldtNjZpR2czd2ZjNGdvaXpCTFdK?=
 =?utf-8?B?Q0JwSnVBSUFSMU92UXpxZVJ4am5aZUxVKy9wM1FOcGRpSXdCdVlFZU94SHE4?=
 =?utf-8?Q?q4jEA968Z7ZQ7iK5Y1HhC8BCm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a17df097-e4a4-49d8-01c9-08de1374cd58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 03:15:51.5174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CisQFyrDpQb5BZ9GOevMyGpMta54BVLlHZIIvgPoUr03D685NBbBOmIbbELHx8Vwt6YxfQ/xNbCeFh8IAo9YEwWZ+Wjk629OpREebuhwnEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6183

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDQvNl0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgaW5p
dGlhbCBBU1QyNzAwIFNvQyBkZXZpY2UNCj4gdHJlZQ0KPiANCj4gT24gVGh1LCAyMyBPY3QgMjAy
NSBhdCAyMjoxMSwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6DQo+ID4gT24g
VGh1LCBPY3QgMjMsIDIwMjUsIGF0IDA5OjM3LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPj4gPiAr
ICBhbGlhc2VzIHsNCj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsMCA9ICZ1YXJ0MDsNCj4gPiA+
PiA+ICsgICAgICAgICAgc2VyaWFsMSA9ICZ1YXJ0MTsNCj4gPiA+PiA+ICsgICAgICAgICAgc2Vy
aWFsMiA9ICZ1YXJ0MjsNCj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsMyA9ICZ1YXJ0MzsNCj4g
PiA+PiA+ICsgICAgICAgICAgc2VyaWFsNCA9ICZ1YXJ0NDsNCj4gPiA+PiA+ICsgICAgICAgICAg
c2VyaWFsNSA9ICZ1YXJ0NTsNCj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsNiA9ICZ1YXJ0NjsN
Cj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsNyA9ICZ1YXJ0NzsNCj4gPiA+PiA+ICsgICAgICAg
ICAgc2VyaWFsOCA9ICZ1YXJ0ODsNCj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsOSA9ICZ1YXJ0
OTsNCj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsMTAgPSAmdWFydDEwOw0KPiA+ID4+ID4gKyAg
ICAgICAgICBzZXJpYWwxMSA9ICZ1YXJ0MTE7DQo+ID4gPj4gPiArICAgICAgICAgIHNlcmlhbDEy
ID0gJnVhcnQxMjsNCj4gPiA+PiA+ICsgICAgICAgICAgc2VyaWFsMTMgPSAmdWFydDEzOw0KPiA+
ID4+ID4gKyAgICAgICAgICBzZXJpYWwxNCA9ICZ1YXJ0MTQ7DQo+ID4gPj4gPiArICB9Ow0KPiA+
ID4+DQo+ID4gPj4gVGhpcyBsb29rcyBsaWtlIHlvdSBqdXN0IGxpc3QgYWxsIHRoZSB1YXJ0cyB0
aGF0IGFyZSBwcmVzZW50IG9uIHRoZQ0KPiA+ID4+IGNoaXAsIHdoaWNoIGlzIG5vdCBob3cgdGhl
IGFsaWFzZXMgYXJlIG1lYW50IHRvIGJlIHVzZWQuIE1vdmUgdGhpcw0KPiA+ID4+IGJsb2NrIGlu
dG8gdGhlIGJvYXJkIHNwZWNpZmljIGZpbGUgYW5kIG9ubHkgbGlzdCB0aGUgb25lcyB0aGF0IGFy
ZQ0KPiA+ID4+IGFjdHVhbGx5IGVuYWJsZWQgb24gdGhhdCBwYXJ0aWN1bGFyIGJvYXJkLg0KPiA+
ID4+DQo+ID4gPj4gSW4gcGFydGljdWxhciwgdGhlIGFsaWFzIG5hbWVzIGFyZSBtZWFudCB0byBi
ZSBsb2NhbCB0byB0aGUgYm9hcmQNCj4gPiA+PiBhbmQgZG9uJ3QgdXN1YWxseSBjb3JyZXNwb25k
IHRvIHRoZSBudW1iZXJpbmcgaW5zaWRlIG9mIHRoZSBjaGlwLg0KPiA+ID4+IEluIHRoZSBkZWZj
b25maWcsIHdlIGN1cnJlbnRseSBzZXQgQ09ORklHX1NFUklBTF84MjUwX05SX1VBUlRTPTgsDQo+
ID4gPj4gd2hpY2ggaXMgZW5vdWdoIGZvciBhbnkgYm9hcmQgd2Ugc3VwcG9ydCBzbyBmYXIsIGJ1
dCB0aGF0IG1lYW5zDQo+ID4gPj4gb25seSB0aGUgZmlyc3QNCj4gPiA+PiA4IGFsaWFzZXMgaW4g
dGhlIGxpc3Qgd2lsbCBhY3R1YWxseSB3b3JrLg0KPiA+ID4NCj4gPiA+IFVuZGVyc3Rvb2QuIEkn
bGwgbW92ZSB0aGUgYWxpYXNlcyBibG9jayBmcm9tIHRoZSBTb0MgZHRzaSBpbnRvIHRoZQ0KPiA+
ID4gRVZCIGJvYXJkIGR0cy4gRm9yIHRoZSBFVkIsIFVBUlQxMiBpcyB1c2VkIGFzIHRoZSBkZWZh
dWx0IGNvbnNvbGUsDQo+ID4gPiBhbmQgdGhlIGJvYXJkIGxhYmVscyBtYXRjaCB0aGUgU29DIG51
bWJlcmluZywgc28gSSBwbGFuIHRvIGtlZXA6DQo+ID4gPg0KPiA+ID4gRG9lcyB0aGF0IGxvb2sg
YWNjZXB0YWJsZT8NCj4gPiA+IGFzdDI3MDAtZXZiLmR0cw0KPiA+ID4gICAgICAgYWxpYXNlcyB7
DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDAgPSAmdWFydDA7DQo+ID4gPiAgICAgICAgICAg
ICAgIHNlcmlhbDEgPSAmdWFydDE7DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDIgPSAmdWFy
dDI7DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDMgPSAmdWFydDM7DQo+ID4gPiAgICAgICAg
ICAgICAgIHNlcmlhbDQgPSAmdWFydDQ7DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDUgPSAm
dWFydDU7DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDYgPSAmdWFydDY7DQo+ID4gPiAgICAg
ICAgICAgICAgIHNlcmlhbDcgPSAmdWFydDc7DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDgg
PSAmdWFydDg7DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDkgPSAmdWFydDk7DQo+ID4gPiAg
ICAgICAgICAgICAgIHNlcmlhbDEwID0gJnVhcnQxMDsNCj4gPiA+ICAgICAgICAgICAgICAgc2Vy
aWFsMTEgPSAmdWFydDExOw0KPiA+ID4gICAgICAgICAgICAgICBzZXJpYWwxMiA9ICZ1YXJ0MTI7
DQo+ID4gPiAgICAgICAgICAgICAgIHNlcmlhbDEzID0gJnVhcnQxMzsNCj4gPiA+ICAgICAgICAg
ICAgICAgc2VyaWFsMTQgPSAmdWFydDE0Ow0KPiA+ID4gfQ0KPiA+DQo+ID4gSSB0aGluayB0aGlz
IHdvdWxkIGJlIGJyb2tlbiBmb3IgdGhlIGRlZmNvbmZpZyBpZiB0aGUgY29uc29sIGlzIG9uDQo+
ID4gc2VyaWFsMTIuIEkgd291bGQgcmVjb21tZW5kIHVzaW5nIHNlcmlhbDAgYXMgdGhlIGNvbnNv
bGUsIGxpa2UNCj4gPg0KPiA+IGFsaWFzZXMgew0KPiA+ICAgICAgICBzZXJpYWwwID0gJnVhcnQx
MjsNCj4gPiB9DQo+ID4NCj4gPiBpbiB0aGlzIGNhc2UuIElmIGFkZGl0aW9uYWwgdWFydHMgYXJl
IGVuYWJsZWQsIGFkZCB0aG9zZSBhcyBmdXJ0aGVyDQo+ID4gYWxpYXNlcy4NCj4gDQo+IEluZGVl
ZC4gQXJlIGFsbCB0aGVzZSBzZXJpYWwgcG9ydHMgZXhwb3NlZCBvbiB0aGUgYm9hcmQ/DQo+IEFs
aWFzZXMgaXMgbWVhbiB0byBsaXN0IG9ubHkgdGhlIG9uZXMgdGhhdCBhcmUgZXhwb3NlZCwgYW5k
IHRoZSBhbGlhcyBudW1iZXINCj4gc2hvdWxkIG1hdGNoIHRoZSBsYWJlbCBvbiB0aGUgYm9hcmQv
cG9ydCAoInNlcmlhbE4iLCAiZGVidWdOIiwgLi4uKSwgaWRlYWxseS4NCj4gDQo+IFR5cGljYWxs
eSBvbmx5IGEgZmV3IHBvcnRzIGFyZSBleHBvc2VkLCBzbyB5b3UgbWF5IGVuZCB1cCB3aXRoIHNv
bWV0aGluZyBsaWtlOg0KPiANCj4gYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3J6ZzNzLXNt
YXJjLmR0c2k6ICAgICAgICAgICBzZXJpYWwwID0gJnNjaWYxOw0KPiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JlbmVzYXMvcnpnM3Mtc21hcmMuZHRzaTogICAgICAgICAgIHNlcmlhbDEgPSAmc2NpZjM7
DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yemczcy1zbWFyYy5kdHNpOiAgICAgICAg
ICAgc2VyaWFsMyA9ICZzY2lmMDsNCj4gDQo+IEkgZGVsaWJlcmF0ZWx5IHBpY2tlZCB0aGlzIGV4
YW1wbGUsIGFzIGl0IHNob3dzIGhvdyB0aGUgc2VyaWFsTiBudW1iZXJpbmcgZG9lcw0KPiBub3Qg
bmVlZCB0byBtYXRjaCB0aGUgc2NpZk0gKG9yIHVhcnRNKSBudW1iZXJpbmcuDQo+IA0KPiBHcntv
ZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0K
PiAtLQ0KSGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24gYW5kIHRoZSBS
ZW5lc2FzIGV4YW1wbGUg4oCUIHRoYXQgaGVscHMgYSBsb3QuDQoNClllcywgb24gdGhlIEFTVDI3
MDAgRVZCIG9ubHkgYSBmZXcgVUFSVHMgYXJlIGFjdHVhbGx5IHJvdXRlZCBvdXQsDQphbmQgVUFS
VDEyIGlzIHVzZWQgYXMgdGhlIG1haW4gY29uc29sZSBwb3J0Lg0KDQpJ4oCZbGwgdXBkYXRlIHRo
ZSBFVkIgRFRTIGFjY29yZGluZ2x5IHRvIGxpc3Qgb25seSB0aGUgZXhwb3NlZCBwb3J0cywgZS5n
LjoNCg0KYGBgZHRzDQphbGlhc2VzIHsNCiAgICBzZXJpYWwwID0gJnVhcnQxMjsgLyogY29uc29s
ZSAqLw0KfTsNCg0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4
IGJleW9uZCBpYTMyIC0tDQo+IGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

