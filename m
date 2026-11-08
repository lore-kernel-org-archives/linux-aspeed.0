Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBE606A31A
	for <linux-aspeed@archiver.kernel.org>; Sun,  8 Nov 2026 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BiROR05V
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMbl93wXfz2y2R;
	Sun, 08 Nov 2026 13:02:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794103333;
	cv=pass; b=aL/Owaa97FTyXFUq8dCCTUp2Ro+ptxAyBwIAuNWoaj/fdvjbwd3q9lyOZfVIgD5+6jTLsf7T6cK+b9el7Z2Cn9Civ8NnTmV7ef/B6NZCOgZR+sxdOOGSdvh6Faf2/VEcAutTsMgAvg0B8ebDzFlHb0rp4I/ig3/q6fPSxr2Ykv7VCo51Q9Wvd296Cca1FV/7Bh0cTYGeo/ck91C53c/ZAhX/BEvkuPq9uWpa4y198TN/WRk6r+trHAGuySpXzqkGr9ABUFTK85lUjhm66JBFLJMc1L4iNX2Xc6fclM5NX31BBxVmjllCEBzcTxPZY3GePP4OuxEMU2Vxq+c9XqAi/w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794103333; c=relaxed/relaxed;
	bh=1i6/jMFKih0h/iZEtSrntkyUBM/HWoNrwXnOSQR5GG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KB6FZi+qSXjSD2Evlb/2C7DEpDhb6KwT8dlrpc3n3jjJvv4s4uHcVYE9UZyKDZQXHq0vfLqTEVNAYlC4sV0j1WEz6/BTQvzXyNmWLUWbYA4kp9zgKGwSQooLJujUIs47KmuytiO7GSWyKm42epy8nxYsHV4F/V29+0PhLmdir42a6sQWRcMoZnRqfRCGPNVvew45ZAlfT8/agq6oVdWtI/CayprD9kE4R1Oj3f9QzskIGicxvIBGY5/GNDg5XVi3WX7FKINhVjh3ZIVtymXdIFju+0yNURSlcS4OevRXuFRARifd+/nUPXQcGGPcLGb3rsONHzUfMHX2QckZcu7OOg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BiROR05V; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BiROR05V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMbl65htvz2xJ5
	for <linux-aspeed@lists.ozlabs.org>; Sun, 08 Nov 2026 13:02:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFwbysDYkf5R0E/iLcFThGAwEDCr5rytJTL2NRtCTbVrOVgyY/IjZbbZpfVyEXUSjm5x5JoLUA8GBssLFlDXDGukVFxMJUgNDQ3wM5p8ML7CgAJ7r9Z6/CO1eDh4o6W3IS1ELQmntdBdIV7BYtP3RHol+JGr+7WI6ztDcC4u77wbFvFlpAPMR7D/JsKfVKmLwRpBSbZwH/2pZr47wQ5aCVgaRGWE3rOQ+uWJlqY7ERH8UFj7UI8L02dmfx9xc0zhAUwlz7C6G7x3SC23G05q6mixSaNz2bZiSU2lx1Zbfg9sfTAuI1ZeIuISPxofbRkAw1CLRco+TvxFPGSajiZRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i6/jMFKih0h/iZEtSrntkyUBM/HWoNrwXnOSQR5GG0=;
 b=bum9184rBij5WozidXjy7VUWjHhMAz+afMj5o/nlGH2nAlSxXttmUs1FP+hWpulYFHDVrY0l9HNPLrT9/UGFFEEksLiX17unzONEmMddQSJLm8IhTSM3SvVN0QEkhcWz0O2yWC7NB79UWNdS1mDvMYIFzU6Pbrb6lUFu124f0fZPZX2hmTbnRa5tJnhUlCKvdD+FDff+TFUThQAGq3TEWbxMyuwgVXF3beptq6InSFIwxY6f9A4odr+fuWdVBouOW0M/MWIUYAJHYP8w5cpsWnKMEi1HEMaPrO/h6H7f5om/N0EIcY2hfG0Hdfvb5c1SXTMdeFM+8bPh9ems3GvMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i6/jMFKih0h/iZEtSrntkyUBM/HWoNrwXnOSQR5GG0=;
 b=BiROR05VffM8noL7CH7/bj5PGKaM6ESx0gwXdNXjJckmA4feJ/Rfrkag3RNKVNniXV3ijAbbbBpkOJpsbQhHoWPXK1hJ7oMI4w8N7y4hdYjDMoyvLexZhL7EkalK9KZ/UcyexOK2uyeTSK5/L9HgBfhBWfFteRwq7/0GEZrtYfU3CcMCNg1mMs66T1Vs3p58KmhXd7GjfKNCJLvpBqca8X72DHZxToDBw88asRimUeFSjQhD4f1Hw6HGoTCeDAbDDuRez/gykZQ1KG51z/MfgL3JlWWlEWNdAjQc56vpLWFy0ixVo/80V3l2UFfQhmuCz4MAb8TXnhla91yA3Enfrg==
Received: from TYZPR06MB7920.apcprd06.prod.outlook.com (2603:1096:405:24::8)
 by SI4PR06MB8780.apcprd06.prod.outlook.com (2603:1096:4:2b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Sun, 8 Nov 2026
 02:01:47 +0000
Received: from TYZPR06MB7920.apcprd06.prod.outlook.com
 ([fe80::f787:b04e:6ef9:c0d9]) by TYZPR06MB7920.apcprd06.prod.outlook.com
 ([fe80::f787:b04e:6ef9:c0d9%5]) with mapi id 15.21.0615.004; Sun, 8 Nov 2026
 02:01:46 +0000
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
Subject: RE: [PATCH v5 6/9] EDAC/aspeed: Replace regmap with direct register
 access
Thread-Topic: [PATCH v5 6/9] EDAC/aspeed: Replace regmap with direct register
 access
Thread-Index: AQHdViL4mJktKbQvgk6R7ukM+31V4rcfF8qAgAMTmzA=
Date: Sun, 8 Nov 2026 02:01:45 +0000
Message-ID:
 <TYZPR06MB7920FD1C150DCB201DB88367F2742@TYZPR06MB7920.apcprd06.prod.outlook.com>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
 <20261007-edac-v5-6-5c31fc5df4cf@aspeedtech.com>
 <20261105045635.GBauwMg0oqd2tVPH-4@fat_crate.local>
In-Reply-To: <20261105045635.GBauwMg0oqd2tVPH-4@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7920:EE_|SI4PR06MB8780:EE_
x-ms-office365-filtering-correlation-id: 153b4e90-41c1-448b-675e-08df3d3c3e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|5023799004|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 KPFtSSjlppV042XrJU2eh7SWA2gI+WOLBm3XZenKeYMbexu11Z3qRWRFlylPLqq5nb3nrxhuvxZd0qCUCTkZDeDYb+08njxQ4lyY094PRCJWZcX0118i41ylJIxkwVm7GOAFlw9eokO39WjZcfXRWCILHl6DLLEWD04nXu23tWhv0l1iysdNeQPk6QDS1h6XYpOlG6KPrMAjF5wvCyKD86oVYSMeSE11yHrI5Xm46PVJCaNgzh9Fmv5KC9/jbAGcYM/7Oy8tCqxG59GfCEPhf1lwE3nUCMyGptQp3KXb77FH8cpZbCUxtE6dpzeOcDGCR2EHfa+vRJLeAnHPw+PsWFGASwesK4Re6yGrHYeweZQ/zCExdZhgaAQq7cFrs9A4wFxtY3rSOD555F0QeQUdWCtWVyyFpb4HRT609Z9cJrN30PDr6ZmuTcGz8tCfaQ3reaGR8qGaoIBQKuadkMBLYtbwgfCwBAgAZcJOm4ycMec0ei0xRKVJRQZ7sAbXxCliJX1jQxLBzBonELfh8gmXZm8U/nLW01IBu32EFOPiqS4s/G6dj+vE3O7q6QQoE0kAKIZkmHG5KkW5zwCSwXjKqDO8jmV0svwxgxpkafxhURE1RaHhLIIh20TlkM+5uw2IKAI+Waym0mXhmr6R3BTws9IGWk8S85TYuFvPV5M94gc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7920.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUdsOGFtKytZVCtCTGRVQ0tjL0hFUEQ2N2dyTHJabzlhV1duMXdxcFpHQnJp?=
 =?utf-8?B?ekxwcHEyWUg5Z29FZmJYdjhzMFV4Qlk2Rzk4Ry9DRmFZRDVoK2JTQjFEeVZL?=
 =?utf-8?B?ME5aRFZ4QjdqTm5TYy96SE1Wd2VaWXhuV0RwZFBmU21pc1dSU1hwcWJ3clNP?=
 =?utf-8?B?QkZ4aWkwNnBwZ1ZlL2VuNXl5L2dnelArM2p1T1ZEWEdVc0Q4eXdnZUxpYVZ2?=
 =?utf-8?B?TlJBOFJTcUUvV3NOUWJ5L1YvVGdEVFFnYlVJWkFINHZyQVI4cnJtYVpsS1B1?=
 =?utf-8?B?U3F0S2pKaDlQaHNmUGZwOVB2UlAvL0dvREVJUDY1QzR0UkN2MjY5V0ZsYmNF?=
 =?utf-8?B?dFNNNFIydEJMTldXWmgxSHpkT3c0cUNtMXJTMUxNZGNGUzFZeUg4cjUrS3JY?=
 =?utf-8?B?YnhmcUdyalpKRGoxRis1L0tieitwemxyQ28zSlpKNG8wRzRjWUtDdERDMHU2?=
 =?utf-8?B?b3MvOTdhdXhNUjE5bS9McWlUMmxCR1R6YSt5NHpTZ3JOWXEzUG5yTHozSlpi?=
 =?utf-8?B?dDhVQnBzYmJQZVdOaDUxSHNhWmZnbVgrZE91NHNmV1JLM1RzemEwNjVkK01o?=
 =?utf-8?B?eWFvczJtcDRiK3lsZUJGakVVYlpOTlg2MnN4bmtEU1ZqbzVqcHZ5RFVwVXdi?=
 =?utf-8?B?M1F0N2JmRnpOT0Yvb205Y1pzMENOV1lmNlhlVVdLZ1ZPTC9jSiszalVTaXZP?=
 =?utf-8?B?aTRiY1cwdXhYOE9XYXUxSGVYOGRUOTJSdFdkOUx5bTdEUnlzTk45VGpXVVF1?=
 =?utf-8?B?VVRPYmZqcHRxMkZ4RUxjdmt0cVJGZ3BFcTBud21saFJSNXNTMkVSVmd0dWUw?=
 =?utf-8?B?YzR4N2VFcW94blorTDZjV2hUUW0vNWU3RTVRaHpzTHFiR1U2QjArb25tdStV?=
 =?utf-8?B?MCs0bXJiQUd5Wi92NkZ3SW5GS0luSytlU3FpTnZDNVdOb2UyeDRpSGFxdjN4?=
 =?utf-8?B?SkNMWERFbUVtRFZvY2NZZmJIRWJFb2N2NTBNdVpMRzA1NEtmRWN5NXdLdEZU?=
 =?utf-8?B?RnQ1Mk9LRitMWG5qT24yVHg2MHZkOXhXdWc5SzNLTHhrT3BYby9CT0x4ZE4y?=
 =?utf-8?B?RnVFU2pFT1VvTzYrYTZOMWFOQ0sxaTdYZ2tWUXVJR2RmRS9pT0lUQW5BVDdN?=
 =?utf-8?B?dHVpU1dCU3FJRlIxTERVaDJQQVNLS2ZQaDNYNGJSVSt2TGJZckNLZzdPUHFD?=
 =?utf-8?B?T3hlaVlGb29oMVpscGtxQ0tDbWtZQlp6cTEvQ1dFc3BtL1pTLy90TkJkNGNK?=
 =?utf-8?B?YnJvV09UZFdTbGtIRm1GRXZab0ZIMERZWFkrendudERrd0F0ZzU0Yi8rTGxM?=
 =?utf-8?B?RS9OUGw3MzF1aUhMbkljVVVVdFNGUjRCU2syNEJsSlR4VWd6bWJoUUw2MVA3?=
 =?utf-8?B?QUVJVktUeWUzR2YzV3NiVFRzaDRBbnQ2K29sdi8xMWJyV3JxZm12SEY3L3ph?=
 =?utf-8?B?NkFybzVBUlp0TTMzMmd0Z1hSVmp6NWMzYVZDMmhZdEI2cHc2b0xXVURrN3FV?=
 =?utf-8?B?UkpMUGVLN0xKQ2lpcWl5RHBJeGpGMGtLaXF0anVnUFNqZGFITlBRYUpKNVc3?=
 =?utf-8?B?VzBTZVFWYVhlOFVWTXBZdWJDczVjRjUwbDU4ZmllSm9wckF1OGZnSDFIdGRH?=
 =?utf-8?B?cWdPN3FtZFVoY0lZcWplbHZTU01KTGdrUWJ2RWRFMERLVk9xYzlEZ1drODJC?=
 =?utf-8?B?T01KaW5lMzE1VU1wYnBnWTBXZVdxZXRRM2xJKy84NjRDUUZKdStIdzNTWmti?=
 =?utf-8?B?UVpqWWNiMWRKNzlGY0hIaUhUOGtkVU1PUkk0MURtT1dZZ1VEZ2JySTk2QVY2?=
 =?utf-8?B?Uml0MFljV0tCT0Ntd3c4RE1tR3lnRFVwNzRkc0o4Q2ZyYTFaeU8yekpxYkQ3?=
 =?utf-8?B?S0xWVjRvd2dVakxRbktxZDArUUVDajZJN2FjOGQ4TTVidnVENWlUalpGSDU3?=
 =?utf-8?B?MnNPM0VYNUZzZ2FBZVo2MnB0R0t1K2FJdG9QM1FKN3VyM1JkZFdzbStEN2cr?=
 =?utf-8?B?VWFTTkh6d1E2dzFPYlBJci9BampyWjhrTS9kMFY5VmM3cnMwU24rZ0V4N2hT?=
 =?utf-8?B?ZEE1K2xabmFJTFVjNkZQT0xRRythVXo4RDVVbjZvOVdRNkJ1MGt4YTd4ZS9D?=
 =?utf-8?B?NmFZRzhUaG51SGJLcU9PZzlQZ0s0N0FKWHhrYTZlRGVUVmNxckk2T1ZjVThQ?=
 =?utf-8?B?T01mUlhzZDhxQkRNNG9tOUtWdHpLZDRGbzcyRlROMStlMmUwSnRZditKNjBD?=
 =?utf-8?B?ZURZWW1hTG5VYTA0cnZhemtHdkVDZzZ3Ym5XWDVPQys0dVQwRk8vMjFuampM?=
 =?utf-8?B?bUIvQTA5NXAxTDc0N2VvbU9nNnhGb0NMYUJ1Z1d3VDY4NlN5VUh1UT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7920.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153b4e90-41c1-448b-675e-08df3d3c3e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2026 02:01:45.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuUiddXJnGZbbAKr3c20AinXTNX2T5d0MPWZOTGIkIjVO9RPf3llYWphbgzzMLq28d8QexisYaRtRxsRCJ60VP+w1AkCk3jtWiYN91adouk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8780
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDYvOV0gRURBQy9hc3BlZWQ6IFJlcGxhY2UgcmVnbWFw
IHdpdGggZGlyZWN0IHJlZ2lzdGVyDQo+IGFjY2Vzcw0KPiANCj4gT24gV2VkLCBPY3QgMDcsIDIw
MjYgYXQgMDI6MTM6MjNQTSArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IFRoZSBkcml2ZXIg
aW5zdGFudGlhdGVzIGl0cyBvd24gcmVnbWFwIHB1cmVseSBhcyBhbiBNTUlPIHdyYXBwZXI6IGl0
DQo+ID4gaGFzIG5vIHJlZ2lzdGVyIGNhY2hlLCB1c2VzIGN1c3RvbSAucmVnX3JlYWQoKS8ucmVn
X3dyaXRlKCkgY2FsbGJhY2tzLA0KPiA+IGFuZCBpcyBub3Qgc2hhcmVkIGFzIGEgc3lzY29uIHdp
dGggb3RoZXIgZHJpdmVycy4gU28gaXQgYnJpbmdzIG5vdGhpbmcNCj4gPiBoZXJlIGJleW9uZCB0
aGUgc3BpbmxvY2sgdGhhdCByZWdtYXAgdGFrZXMgYXJvdW5kIGVhY2ggYWNjZXNzIHdoZW4NCj4g
PiBmYXN0X2lvIGlzIHNldC4NCj4gPg0KPiA+IERyb3AgdGhlIHJlZ21hcCBhbmQgYWNjZXNzIHRo
ZSByZWdpc3RlcnMgZGlyZWN0bHkgd2l0aA0KPiA+IHJlYWRsKCkvd3JpdGVsKCkgdW5kZXIgYW4g
ZXhwbGljaXQgcmF3IHNwaW5sb2NrLCBoZWxkIGFjcm9zcyB0aGUgd2hvbGUNCj4gPiByZWFkLW1v
ZGlmeS13cml0ZSBzbyB0aGUgY29udHJvbGxlciBpcyB1bmxvY2tlZCBvbmNlIGFyb3VuZCB0aGUN
Cj4gPiBncm91cGVkIHdyaXRlcyByYXRoZXIgdGhhbiBvbiBldmVyeSByZWdpc3RlciB3cml0ZS4N
Cj4gPg0KPiA+IEFubm90YXRlIHRoZSByZWdpc3RlciBiYXNlIHdpdGggX19ndWFyZGVkX2J5KCkg
c28gdGhhdCwgdW5kZXINCj4gPiBDT05GSUdfV0FSTl9DT05URVhUX0FOQUxZU0lTLCB0aGUgY29t
cGlsZXIgY2hlY2tzIGF0IGJ1aWxkIHRpbWUgdGhhdA0KPiA+IGV2ZXJ5IGhhcmR3YXJlIHJlZ2lz
dGVyIGFjY2VzcyBpcyBwZXJmb3JtZWQgd2hpbGUgaG9sZGluZyB0aGUgbG9jay4NCj4gPg0KPiA+
IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC04DQo+ID4gU2lnbmVkLW9mZi1ieTog
UnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+IC0gVGFrZSB0aGUgcmVnaXN0ZXIgbG9jayB3aXRoIHRoZSBpcnFz
YXZlIHZhcmlhbnQgaW4gaW5pdF9jc3Jvd3MoKSBhbmQgaW4NCj4gPiAgIGFzcGVlZF9wcm9iZSgp
OyB0aGUgaW50ZXJydXB0IGhhbmRsZXIgdGFrZXMgdGhlIHNhbWUgbG9jayBpbiBoYXJkaXJxDQo+
ID4gICBjb250ZXh0Lg0KPiA+IC0gTW92ZSB0aGUgZGV2X2RiZygpIG9mIHRoZSBpbnRlcnJ1cHQg
c3RhdHVzIHJlZ2lzdGVyIG91dCBvZiB0aGUNCj4gPiAgIHJhd19zcGlubG9jayBjcml0aWNhbCBz
ZWN0aW9uIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gPiAtIE9wdCBhc3BlZWRfZWRhYy5v
IGludG8gY29udGV4dCBhbmFseXNpcyBpbiBkcml2ZXJzL2VkYWMvTWFrZWZpbGUsIHNvDQo+ID4g
ICB0aGF0IHRoZSBfX2d1YXJkZWRfYnkoKSBhbm5vdGF0aW9uIGlzIGFjdHVhbGx5IGNoZWNrZWQu
DQo+ID4gLSBOb3RlIGluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciB0aGF0IHRoZSBjb3VudGVyIGFu
ZCBpbnRlcnJ1cHQgZmxhZw0KPiA+ICAgZmllbGRzIGFyZSByZWFkLW9ubHksIHNvIHdyaXRpbmcg
YmFjayB0aGUgcmVhZCB2YWx1ZSBpcyBoYXJtbGVzcy4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9l
ZGFjL01ha2VmaWxlICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2VkYWMvYXNwZWVkX2VkYWMu
YyB8IDEzMQ0KPiA+ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDgxIGRlbGV0aW9ucygt
KQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9zYXNoaWtvLW91dGJveC0xNjI2NjdA
a2VybmVsLm9yZw0KPiANCkhlbGxvIEJvcmlzLA0KU29ycnksIEkgZG8gbm90IHJlcGxpZWQgdG8g
dGhhdCBvbmUuDQoNCkknbGwgdGFrZSB0aGUgc2Vjb25kIG9wdGlvbiBpbiB2NjogYXNwZWVkX3By
b2JlKCkga2VlcHMgaXRzIGdvdG8tYmFzZWQNCmVycm9yIHBhdGhzIGFuZCBubyBsb25nZXIgdXNl
cyBzY29wZWRfZ3VhcmQoKS4NCg0KdjYgZHJvcHMgdGhlIGFubm90YXRpb24gYW5kIHRoZSBjb250
ZXh0IGFuYWx5c2lzIG9wdC1pbiwgYW5kIGFzc2lnbnMNCnRoZSByZWdpc3RlciBiYXNlIGRpcmVj
dGx5Og0KDQotCXNjb3BlZF9ndWFyZChyYXdfc3BpbmxvY2tfaXJxc2F2ZSwgJmFzcGVlZF9sb2Nr
KQ0KLQkJYXNwZWVkX3JlZ3MgPSByZWdzOw0KKwlhc3BlZWRfcmVncyA9IHJlZ3M7DQoNCldoaWxl
IGF0IGl0LCB2NiBhbHNvIHN3aXRjaGVzIHRoZSBsb2NrIGZyb20gcmF3X3NwaW5sb2NrX3QgdG8N
CnNwaW5sb2NrX3QuIFRoYXQgaXMgd2hhdCByZWdtYXAgdXNlZCBiZWZvcmUgdGhpcyBwYXRjaCwg
YW5kIHRoZQ0KaW50ZXJydXB0IGhhbmRsZXIgaXMgbm90IElSUUZfTk9fVEhSRUFELCBzbyBhIHJh
dyBsb2NrIGlzIG5vdCBuZWVkZWQuDQoNClBhdGNoZXMgNy85IGFuZCA4LzkgZm9sbG93IHRoZSBz
YW1lIGNoYW5nZXMuDQoNClRoYW5rcyB5b3VyIGhlbHAuDQoNClJ5YW4NCg0KDQo+IC0tDQo+IFJl
Z2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5v
cmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

