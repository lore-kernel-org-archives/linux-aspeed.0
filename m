Return-Path: <linux-aspeed+bounces-4971-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CA7C79F8C
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 05:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfqLJ4lnWz2ybK;
	Wed, 09 Sep 2026 15:36:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788932200;
	cv=pass; b=lNiyE4ICJ6P7BUeREf0w+wctWfpQass139Zu9GNKJJkC/KhnOjmixjOn6szqBr0fUKIxjBu/6abSZvJFQYwGb3sV6Pk4SO73fbjcalNSL3GzcgN108a1jG58OaCWzW2008InQma9dDKc8gHYtn7Z3tt8b1Tqag/dryX4XWcYNP8Do/LtcXS+tvMfCvJ2ndaTgiwPjiIN4fxSZrey4jkpcpEKQ0EXPoh716RysWx21l8pimA6iJkspUunH/wkiJPLEMHY2PErywgfsGWMV6ec8gjgnv2NlmBf/R7LduUfnFQ9XQmYwgcCszFUefu1kNT40LVX88BaJGBRzrKAdPC3XA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788932200; c=relaxed/relaxed;
	bh=0XMvDIxJO82E5EsuCZmf0rvVlNK+NGA0h6FliXJNFtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h0CQMgas1FKIZiTOltC6Bd/5TgFg4P0e+5pyxyeldlt8Bz2m7o/UWaon/RCtBO3Dw6RFnqN6GK6oB+RCtk7W0V+0e5tZ0p+8Vk7GyOmahYOja+RKYKz929S9e7n78GcpclSiLFu6P+mX638pXhfKnJbs6Os15GPWgf9lLleko94nGRY5zxH4HtTonSqiem8aD2PBQgNa0ALDvmybcacwLh3R8s1SmWZPCtWCSApXRYprRtWgCb1loB2jhGl+kGwEAF1BgMQLJ4Bn/FkuUWATeZBdAVZMuzJxyWJ56NzIjMT3uVccLcAOfokKyPvmtmad2Z1JOEpucl53DgGEqeg8yw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=iJ91Ymef; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=iJ91Ymef;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfqLJ0BZTz2y8c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 15:36:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK5/61uCad9XJdRcu2Rhw4mys/JDtFlcwlc+WNxQBPQvyfoiLpzg5Qd1sq1dMTylbwRrk+6kEeQ8QCG4pfgIs7AP2ML+KG5rPdbEcdvMF9O5rb/b0HuubnsPh08QkAFFbpEO663A6UGv7v/MdXIhTNrg7qgFT6oUJAT++70jwJSjCfExeuPY0q3KxOSp+V7AM5jhoFMKJ4oBHLmjyJQGDFjoGLPQduVkEoul/SrNID4MziKIPcp8K27QCeAD7xndnPt1iKlkH4TGTOXmi095BevSXIV6xp+PN9emrDNvH0gTYEdgNQ0EV1W+bq8WzTfC1/e+4SZRXk6NgJIsT5SrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XMvDIxJO82E5EsuCZmf0rvVlNK+NGA0h6FliXJNFtI=;
 b=XbOAeE15Itb8Rmd+VtBtsR/n4I0w6cBjWB2IaBVSwFt+sFoVuUwVg4xsClyWdEBXixMrvaTJZFH0QcBA/Z2QhKNffm2dneyKIK+xtp6bAm8PIk7ZveijzEJrMBzdH2BnThBjhVw0fF8ZsETWaU+PMmYXmE30fAUuMNBf+GPY/wehH7QDdrlB8DXTPFBbIUDPqV/wuBhbR1iDNlOUCs81uXUfv/BxzpTt+YAFEMQ24rSMcy5rN7eaSQePFZR6ToGV2eY4RoRW1X7xEV6CDIa0r9zL+kvXSfsMIktoLHaDW7gDboWcmY0jIc1UfWjssKrlGFbMK72sEIqYARfWOw5AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XMvDIxJO82E5EsuCZmf0rvVlNK+NGA0h6FliXJNFtI=;
 b=iJ91Ymef1wiyw/2OqHwkh5Q2O5yAZC1AMtNEv4LG3lqup5+MUw59VucJT44p0wvHialSlfEj9HwUZ8Ev5wX/yQEMQ+WP15D8Abac2JWFR460xyJ3ZKJx/oqM76hZYpir3HyP6FDxbuLUOaNlKDsLjUvzZ+Q34zoiVKtmJW25NnJMVGGtqcbvGG2t5M9XcGNSFPWA+lfQkl0DVZ7lIbfQAZPrDwkP3JEDtrmPGg74AprIVzEsKjjZtK4PJsiEch1Cp6PCFGpnRTUQkeM2KyjYNbq7gYzeNEP9B+qy4Veffi/8avMDpzGmHl8rLN5r2FCXTSnzVHCjet035s8mhijlUQ==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by JH0PR06MB7268.apcprd06.prod.outlook.com (2603:1096:990:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 05:36:16 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 05:36:16 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIDIvOF0gaTNjOiBtaXBpLWkzYy1oY2k6IFN1cHBvcnQgYWRk?=
 =?big5?Q?ress-indexed_DAT_slots?=
Thread-Topic: [PATCH 2/8] i3c: mipi-i3c-hci: Support address-indexed DAT slots
Thread-Index: AQHdOgYFV/iRFGCV+Eu8y/2tQxxS3ra6MksAgAuTrhI=
Date: Wed, 9 Sep 2026 05:36:16 +0000
Message-ID:
 <OSQPR06MB7252EEDBF3392ED908FD4C8D8BB02@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-2-19909e7cbd7e@aspeedtech.com>
 <apc5_qthRg3GMEyz@lizhi-Precision-Tower-5810>
In-Reply-To: <apc5_qthRg3GMEyz@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|JH0PR06MB7268:EE_
x-ms-office365-filtering-correlation-id: 514fda42-b9d0-4032-d5d9-08df0e344484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 YiG5Myewit5RumRyft7R+UBr5GEE+NwAn67soIae9Vq7mV60oKX7LfwIC+5a2KO0bzAmRAq6YLjQYpJNny4p/eNuBVO6jZ0fnKlOA9+kCKu3oaXIgGaGDB2vcqPk4+NQgBp8M3Zb9mVR9J2D1LF8+UmQnVR+54iKCg5dlWLZgn5xQD43gwDLE58W3LAoTgQsaYStf5Jb5+qgEBZdiNL+yFDlTMv1HJBZzC9yyqSwEkUx7c+cttmUqTwINrvEdw9c8S3nsvLqViGSoHrdPbqFC16TchzNGIuuke/435c5sqMomayizwbsK/jT41IYNntqUHlHX1MN+POKHJ86iJ0N9cxkoe8poHTKMz9/jA5FYfnd0SwzgUJ0GtfNEsqhGestE1A5Ra03N9IU2QhbCOyELT9Bi/Wip2w/cI+7egxDQQ40RKXE/sLmsKavEVgDDIPjFazzkMjsJ3dLeo9blkBqobFc/YJKcEua7W2IRksSb57g04VpMth16eJw86g6cmiHVraIMOnRpRpRcJpOV19EYnMyoansqH8NokxLTq9nZAItqBuZ7QXYMCxdghLmAcB1uKQOBgr0qnhh0XAe4miQVgmnlZx45C/7eOgNwKr82e5auYk2OtsF5gB/3PhShtXQiKTvifIjqINeXkjH78VY2HWjI51D0ybIDVuFyUjsgNTD4+oui5QgGN1z243QfDkWrX3nz404Eq1A52J6/LKD0Dj5IO4M9PrAcrvVENBX6UI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?ZStqb1RrcytFZjZvVFgxd0lQZW12NjF6UUV4VGVjdFMwUXR1VEp2QUpPVEpqdDRL?=
 =?big5?B?S1E0RGJKaGFjckNaVWJMRERWSExGZDBEWTQ5bVN2NEZibnk0dlhpWk5IdWIxaWhO?=
 =?big5?B?MjMrd1pSVGFKbHFjVEFxQklVTnVaY3JqdXN6RC9nOVZIMncvc2xCTDEvSTFFVkxn?=
 =?big5?B?blU3a2lhMS9OSWpSSTcvdXJJY2c1b3pGN1VxNklMTEFjeDRidHRnSXpMUWQwS3hs?=
 =?big5?B?WDdtblppTW1WTVpRbmx4TDMwN2VmOFJjK0Q2ZnVmamZYTXE5MUZGNUQxbStmTDJi?=
 =?big5?B?S1oycTlkTFI2SHluTjFPeWJzelZ6RkdsWmh1NExsMlErT2NFV0RpREduNTQrQnM4?=
 =?big5?B?UDZBaEhVdUF0M0xidHhydE9TSm1sbEdtN2YydXhIU3pGa0ErditiVEM3MHNHOXF0?=
 =?big5?B?NjM5VUtmaWZqcUpvUEwwSmcwNTZEUFFTdGFxWFAzbXJTb1p0eDFtV0xhTUFIcjJJ?=
 =?big5?B?cHBsbk95M1FYdUQwRThpOVVxa3Mzd2hDTUJrZDUyL0NTMzFmUCtEUjVveWdJZHZV?=
 =?big5?B?TkJ4bEgyTGNXUG9TT0xpeUVrb1QyaFZuRXpKRlN1aHhOZDBqc3hYYkxOamh3VVJ3?=
 =?big5?B?WUVnN2J0MGhXMlkzQW41eTFiTkt2dDgzNWpuU0E5RTNYWUxtOFFaWDBjTFlyR3l3?=
 =?big5?B?TEJlTFh4VG5CSmlFdHdJTXRKbmEwQ0NrR2RoenNvT3BjWXAreXZuV1BzQjJMdW9s?=
 =?big5?B?Q3haN2NwbVVFNVZJUlJPK1NvRDBSeXNRcjlnaU13MmNjOGcxSnFteU1IcDR4Kzc1?=
 =?big5?B?MEIwLzZPdTIwZm1CM3Zac3pyM1BXanRxYitrMW9YK3BKTzVKYU5PUmFEL2h4NGgv?=
 =?big5?B?TzRkNEVrdGFvYmptSWczbFgxR1g1Z291cjB4anBIVEp3S0JRZHFXb084aW15aVhi?=
 =?big5?B?L1kxV2lSNy9ySVM2bVZqQktrdzBBeW56MEJjVVlWNzYxMnY0MElxdkFTVm95LzBD?=
 =?big5?B?cmJTOHZJZU9nSk9qM0FSdXdJeXFOUU8wWUlhRzVMazR0U2ZUcFRiUFZRMnk1WHR0?=
 =?big5?B?NWg5anBRWjY1Qk1tTFh2czA1NTdMN0JNcmVFSk5XdDdtZi9PUTRwNW5Bb1hpTXRk?=
 =?big5?B?OWNGa2hQclJ6NGhFcS9mNUFubWJFeU9wa2pDZFdTQy9EdmYxQ2NUTWRmU0VTMDZO?=
 =?big5?B?ZjdzRzVkOW16QzJOUWU1eFVSSVJCMzBDK0J0UkFiRGlNaTVZaEJsODhMMnRSaEJk?=
 =?big5?B?L1pUeFYrZDNSR2liMHhCbGJtNXh1V2JnaFl2QXdlTGI2cncwRzJaaFltd0NtWERJ?=
 =?big5?B?WDhXOGJVOG9OY0F4SWRBai9EOWxBSjV2Zm94ZDdnSGRGenRYdG9sNG0vTVE0QjVs?=
 =?big5?B?Qmg4clBEZ0NaWHk1MFdwT2xvMldkK3RlcDgvK1RhVjJnYUF5dDE1d200cUttWlhm?=
 =?big5?B?dUw5bTBTNWpaM1A5TjVnNlBDekQ3T1BMeFFBUWp2TVcvcEM1TURIRStQVnA0WDNK?=
 =?big5?B?QnhtYXdGYVBBOEQ4NFBXdnZzNGpFSE5XRXE2MlB5U1NwQUpxT2F0NVg1Zm9UOXhm?=
 =?big5?B?eCs3cS8xd0Qxc3lRTjhuVWJXVEc4OThLMEN6d3Q3dXJjZ2VWVHE4aEd6M1dVS3Jv?=
 =?big5?B?YUxrc0dqQnFvLzdkZUtFTFkybnRscmZPeXRZcEdBQWFnN3JnV1JuWGxFZS8rRWVi?=
 =?big5?B?aE4xME9mNmE4ZjQzYUwycjBwczBiYmI5Y0ZUZ0xQaXM3YTE1azNjWWlOcThsRmFK?=
 =?big5?B?aFRZZDg1VFRaMDNscVNHUUswalZwNHRJZnJ4RXJIL3BGLzd5aXRldEZhOVFyMEpY?=
 =?big5?B?QWFDNldobkJEMEZZNElYZk42a0U4azNxUjJQRjh5bUk2WWkyblF3Um5TUjUrVExV?=
 =?big5?B?Nzh2UFNvQWxzSTVVdWYvUzlFeHFkM3hiNlpNRVBCVzVxYzlvZmtFR0tIeExlUWNi?=
 =?big5?B?T294bk1pSVpjSkJETFVQTnEwR1oydUJNRlJQQ2FNOCs4RGNSYmF0dTQ5S0pOS0hB?=
 =?big5?B?N3lLc09WSUNLMVV1RkhrMkR2T2RRRGcxSzQ1RkdjTng0SE1aMGt5WjBvSGZFUEVO?=
 =?big5?B?enZKL3p4NU5ZeklKdkxxRUdlcnJleUFTWkRLRU8rRXBxZkVPV2ZDLzBUVEU1c3U0?=
 =?big5?B?Z3lBWkZlclYrc2RJTm04OGxnL2dCVFhvUDJXVDRNQzV4cWcya2FZa2h2eUpaS2lH?=
 =?big5?B?eDAwa2Frd3Zvc05mc2Z4YklhaDExb3VjOFpkUHdYVjlHTmo0UHZVSnNidHdmWWsv?=
 =?big5?B?SldISUZsNmNTdFdKZC9qTkpsMS9CQT09?=
Content-Type: text/plain; charset="big5"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 514fda42-b9d0-4032-d5d9-08df0e344484
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 05:36:16.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nVPFmzX2ZnJdXeG0hTTSMEqc7SguqXuvg+aFl2ZLbvXEApJr1avj8cTOKfD4oofQ+ieaoZgg9o3PVx229qNBdV7viFvQvM0zt6GhjIU/Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7268

PiA+IEhDSSB2MSdzIERFVl9JTkRFWCBhbGxvY2F0aW9uIGlzIHNlcXVlbnRpYWw6IHRoZSBkcml2
ZXIgcGlja3MgYW55IGZyZWUKPiA+IERBVCBzbG90LCB3aXRoIG5vIHJlbGF0aW9uc2hpcCBiZXR3
ZWVuIHRoZSBzbG90IG51bWJlciBhbmQgdGhlCj4gPiBkZXZpY2UncyBJM0MgYWRkcmVzcy4gQVNQ
RUVEJ3MgSTNDIGNvbnRyb2xsZXJzIGhhdmUgbG9uZyBuZWVkZWQgdG8KPiA+IHN1cHBvcnQgbW9y
ZSBkZXZpY2VzIHRoYW4gdGhlIHN0YW5kYXJkIDUtYml0IERFVl9JTkRFWCBmaWVsZAo+ID4gKGFk
ZHJlc3NlcyAwLTMxKSBhbGxvd3MsIHNvIHRoZXkgdXNlIGEgbGF5b3V0IHdoZXJlIHRoZSBEQVQg
c2xvdAo+ID4gbnVtYmVyIGlzIGl0c2VsZiB0aGUgZGV2aWNlJ3MgYWRkcmVzcywgcmVxdWlyaW5n
IERFVl9JTkRFWCB0byB3aWRlbgo+ID4gdG8gNyBiaXRzIChhZGRyZXNzZXMgMC0xMjcpLgoKPiBE
b2VzIEFTUEVFRCB3b3JrIGlmIHVzZSA1Yml0IERFVl9JTkRFWD8KCk5vLCBpdCdzIGFib3V0IGhv
dyB0aGUgREFUIGl0c2VsZiBpcyBhZGRyZXNzZWQuIE9uIEFTVDI3MDAsIHRoZQpjb250cm9sbGVy
IGRlcml2ZXMgYSBkZXZpY2UncyBJM0MgYWRkcmVzcyBkaXJlY3RseSBmcm9tIGl0cyBEQVQgc2xv
dApudW1iZXI7IHRoZXJlIGlzIG5vIHNlcGFyYXRlIGFkZHJlc3MgZmllbGQvcmVnaXN0ZXIgcGVy
IGVudHJ5LgoKSTJDIGRldmljZXMgb24gdGhlIHNhbWUgYnVzIG1ha2UgdGhpcyBjb25jcmV0ZTog
dGhlaXIgYWRkcmVzc2VzIGFyZQpmaXhlZCBieSB0aGUgZGV2aWNlIG9yIGJvYXJkIGNvbmZpZ3Vy
YXRpb24sIG5vdCBhc3NpZ25lZCBieSBvdXIKY29udHJvbGxlciwgc28gd2UgY2Fubm90IHJlc3Ry
aWN0IHRoZW0gdG8gYWRkcmVzc2VzIGJlbG93IDB4MjAuIFRoZQpzYW1lIGlzIHRydWUgZm9yIEkz
QyBkZXZpY2VzIHRoYXQgb25seSBzdXBwb3J0IFNFVEFBU0E6IHRoZWlyIGR5bmFtaWMKYWRkcmVz
cyBpcyB0aGVpciBleGlzdGluZyBzdGF0aWMgYWRkcmVzcywgYWdhaW4gZml4ZWQgYnkgdGhlIGRl
dmljZQpvciBib2FyZCByYXRoZXIgdGhhbiBzb21ldGhpbmcgb3VyIGNvbnRyb2xsZXIgYXNzaWdu
cy4gV2l0aCBhIDUtYml0CkRFVl9JTkRFWCwgb25seSBzbG90cyAwLTMxIGV4aXN0LCBzbyBhbnkg
c3VjaCBkZXZpY2UgbGFuZGluZyBhdCAweDIwCm9yIGFib3ZlIHNpbXBseSBjYW5ub3QgYmUgcGxh
Y2VkIGluIHRoZSBEQVQsIHJlZ2FyZGxlc3Mgb2YgaG93IG1hbnkKb3RoZXIgZGV2aWNlcyBhcmUg
b24gdGhlIGJ1cy4gRHluYW1pY2FsbHktYXNzaWduZWQgSTNDIGFkZHJlc3NlcwphcmVuJ3QgZ3Vh
cmFudGVlZCB0byBsYW5kIHVuZGVyIDMyIGVpdGhlci4gREVWX0lOREVYIGhhcyB0byBjb3ZlciB0
aGUKZnVsbCBhZGRyZXNzIHJhbmdlIHRoaXMgREFUIGxheW91dCBjYW4gcHJvZHVjZSwgaGVuY2Ug
NyBiaXRzLgoKQmlsbHk=

