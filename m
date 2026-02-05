Return-Path: <linux-aspeed+bounces-3487-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF3EC1E86
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 09:49:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6CBF13Hjz2xrk;
	Thu, 05 Feb 2026 20:49:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770284997;
	cv=pass; b=nGDD4rcEnpKDHi7cUhOpWWRo9ZuFvHUHkLxF3K7Wm0pWddtWdJvlv+i1ku0AfLiTrobig2ejvRI93Om79SSrF8iYndgIFHLu96/1YbpONNASTIJYicILj89vwbTD/yCBHBqHKywa6isWcl3f39We4oYVKVrYWU8kmlWPAYLoJXwNWT6saRnioThMjStGLrnb2bm/A/tnRuUJk/clXIYkQh8JQtIVJjpGeIhodc3kefEPq3jywta9YQEKlTS3EfDXSOvjBXh3vahL1tNvV+Hgvk/KqGsElzZajnd7D4l/Lg6cnqp20p9VwHGBfGEvAU4UU/6o+jD/EYmlzFful8lYHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770284997; c=relaxed/relaxed;
	bh=dYV6tINcvF2zjq/9R1NDU25UJ/y7Pn/qc1Jwi9c1+cc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwESKLv8pT5smdkNp4BIwIto9nmYtcQ5CNPbCbz5E3yn0NfN/d1RCZg+b+6Vi7lAKLI0iqNtehbqb0y3OFtgittuIVG3VRHAi6yvMgEuITjIVaJEleinasgY3njiIfTpZ+eyl/2k+SnDZ4yZwJOLIVcYyfHhCiQ1f1okay7nVfhbGN0H0R1GqEfD0e4C9VwcUH8WGPRhMI5m6bczn0XWa7PEQZ783WAOsBBxaRoshVzIpIo/o3/0xm0G7kUuSFaCvpkWxNhdja0X6ZvyOPavEf1eI7cjeWQuFPRrIX4c5Ke2bJ+JS2ZwnII1gUX13j7IP4SsM/yGqGRwshZdECE5AQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ftUoa0Bm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ftUoa0Bm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6CBC0F2Kz2xg9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 20:49:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izS1usSIExthmdW7A7unN3z2LE+U9Hflsak7AFyFFqUmf1dLZWAodJ/g1FTrWfdrw8LCaR06eCb0PJpf2OdbMJJJWzwpgOmz/th4WzUZhA9fKTYr59IutVmi1hS65QeIJZLQjea/QlD7NOBFgtDkduWFkD49aTMipVBDew/WX4qx1ItN5ufW3IAjfwWli4HuJIVqkK7+FWnr7sO8s1CVy53QaHRkJLohd1Z3SDYE+mehz11HmhDEZ0BRbofM1+NellWm3gJHPfDzqLXH+EBkXPIH4KUWmc93qvwyG/ObMHDknDk3YEbHszsdVaRKHb06kdD7eUTPpEtId9l1cAUPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYV6tINcvF2zjq/9R1NDU25UJ/y7Pn/qc1Jwi9c1+cc=;
 b=OZq3/ywfUjShNG5CVGgcNvX1aiR9454jvsL4tXGNsYrcbwNQ6mEv9ep84dz1A02zumCy+UNoq+28Z6+9GetsFbCbcwW3IVbwPeBq21T8I1QsdYPo4g88CiCRf0T5xUEfcFPjd4tZRS8OlCxzkz0G64At/0tRsYcSIxKAa/Evhn10hu/G5jvC8PJCdc7yH3a2nRBS22yGDVVIYJz2vZ3n67ic0h9TcmaRzDsz8qsxRNtxd/lNgcCr9BZxyn0daBgFH8iqqxyH3WuzSEyZnuhyLlQBfdYJ7jlwBJdaXtScUz34eLQSIm2sAMfQXBc2hOC+07lxvc4+BPb/ZL+KZHJo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYV6tINcvF2zjq/9R1NDU25UJ/y7Pn/qc1Jwi9c1+cc=;
 b=ftUoa0Bm70rXhu41Ks9pkgwip2qqWdH1z32QTPZv0fnTPN7YvfZlgMyxlhoCoQuq2KBFIYEV3w49jz2d5avF9n0fy6cEddAsEiQB/ZRTxPCUsyscz+vbLi16CeVxTDtFUTHKwJQGvijFmDigSGwc0Ml/6Fdc38Oa3oSTc6GFRSsZH1sVROyM/PfmEawvpWfRZaxSDAnepTdasiVmXKvlLcvT4fF4D53bDXaCzaZg7tDi1FsCRj6UJTtuudB5TPzfgMaCMEiC/PXjb9vyUbhhvSSHGQg9FVSHhIRvuCaBM17JbhQO9lVLAXsvc6QE1J7DdJtdl8doLlziPFZ7lYIp9w==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6281.apcprd06.prod.outlook.com (2603:1096:400:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 09:49:29 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 09:49:29 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
Thread-Topic: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
Thread-Index: AQHclmW4Koe03evCDkyjHS4Z2TLeNbVzzlsAgAAN8DA=
Date: Thu, 5 Feb 2026 09:49:29 +0000
Message-ID:
 <TY2PPF5CB9A1BE69B07F90DFB245FAB735DF299A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-intrepid-vengeful-deer-14e2eb@quoll>
In-Reply-To: <20260205-intrepid-vengeful-deer-14e2eb@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6281:EE_
x-ms-office365-filtering-correlation-id: f5358aea-9de8-4902-7f2d-08de649bdb23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVdrUVNGSk9tU2F0NFh5NldrQ0wxZEpGODg5bW5VNmVUUFhVdlhWdlowemh5?=
 =?utf-8?B?UWdtTCtWUjRPalNkM0c4TGhzZnhCZ1VUc1NJMnhWVnU1OWttbmNLKzVJaUpC?=
 =?utf-8?B?cWJmcGYwNC9LSTdETVhUcHQzMDcxL3hDT2ZxZ1FNemFTM2d5RFVrb1ZHcmk3?=
 =?utf-8?B?ZDFHc2dwMms1cnRITk1IbmYzWEJZT1dqVU9HK2VIRElMSjMxL1dDVERtMHR0?=
 =?utf-8?B?dEI3aWJhQ0hvN3ZmV0lBcWVnZnFKd1pySnhTdFo3bkhvMHlNNGZzNXJnWHZJ?=
 =?utf-8?B?Q0JUYkgwTUZMckNDMFFJYkxKZll2ekZFQ1g5WldXMVRDNUx0RGlRMkUzd3py?=
 =?utf-8?B?aTA3TlZ4SVRkZVhOSmxMN0Y4MkJ4SmpCcWZvL2FYdUl2aGJGb2ZIbCtBak1C?=
 =?utf-8?B?VHZUSStqVkg5ZUQ0eFhUQ0kwSkFkdjVCVjRSTmppeFNuTHpucU95S0NQRTNn?=
 =?utf-8?B?LzBIZVBOUlM0UHNtSUNWT0lTeDY2cm9CUUFxSGI4ZnNOT09MOEJGcVZMbGpN?=
 =?utf-8?B?UmZwdFNBbW5xZjdRaXBHa3lMcSthUG1TR3hRd254Um1ScjkybVB3emNKNlVu?=
 =?utf-8?B?MUkwNEVQdkViV0Q4WTYrbzY3MEJYOXFrV0cyeTZVOTFFUG9jYWlkbG91WWll?=
 =?utf-8?B?V21JcXdQRUZuWkRtVlhRWlV5UUFTT1Y2TzJkNGhiWktXM0E2QXlKZ2czdlc3?=
 =?utf-8?B?TW5aSzlzWDFXWm1VNEFSUFpLVkdSRWgwVG1zQ0VrQWxlZjUwVzJnRXowdXhw?=
 =?utf-8?B?VEU2Vlk1QW95U3VTTkhpQ1VNMERTbTc0QklleVJ3QTQ0WE1GZWx2d0g1cHVX?=
 =?utf-8?B?bkoxdk1GQ0FkZGZMblczNm5peUNqVG1pcVFWQURqSHlwVFVESVNTeG9naWhP?=
 =?utf-8?B?dWZtSGlZWnZZaE1mYVp2V2F1Z29kdGxZYnUrR1Y3cTNDNElBRmJScFFKa0Ew?=
 =?utf-8?B?OVQ4VUJVNnNPR0MxeGlKeDBwTkhxVW5DdDhmTkZONWQvaGE5L3h3M3Rra05X?=
 =?utf-8?B?QlRJRXV1RWhjUVVXaXR0SFZyaFlPSXUwK1NsVTh4ZkY5dnVGNGZ4VEJzR2Mx?=
 =?utf-8?B?dVc4OGdXY2h2N2lab0U0Ull6MHYxbFBDb2xMYWZXR2VCNytMOUtySDFJQml0?=
 =?utf-8?B?UDliZXhDWWNvYVpIcEVGYzRpQ1piLzltaVN0TXg0eitZWVBXWkRjU0s4Ykla?=
 =?utf-8?B?Y0hkbEZSMEdicG9MUFQwQnc0bC9hMTVzdWpSdjk2bUY1N1lPb1VFUnVDd0pV?=
 =?utf-8?B?dEhUNks1a2dVdHdoZ09zZ2hoeHA1Y1lza0pxbndYa1NTOXd1aHg0eFBVci80?=
 =?utf-8?B?SHJxUUN6c1RDdStoSHNxSzRrMVBkbWl6VDVHVHpFMlB0d2FieHp2Zld4RGp3?=
 =?utf-8?B?bGJRVXlEczhtNUc5UTY3R3hmTy9QVEgvQ2k3K0FFalYvUURQc21PWWtsUk5q?=
 =?utf-8?B?a3RmVElzY1dXbTNjSkh2bTZ6RlZ6SkhmSEJjcDJoUEdFeDV3TExjTUk4amEz?=
 =?utf-8?B?QXJYSE1FWldDRW44dUVqREYrL1R3OTFUNnNzckRma3BRcEc1ZTNSQkZUakFS?=
 =?utf-8?B?bTVGckMxaWtqa3N5aEw4eHdmYTFFNkhKRVBNckNhUjY2Y0kxZW9XS2VlRTFI?=
 =?utf-8?B?WmM0LzJWNks1bUQvMzMzNllibFYrRXB4SWF2SXFaUHdETFlZcGV2N0VvQ0Fp?=
 =?utf-8?B?Y0dkNDdIT082MDJMbzEwUHgxMVNUUjFXYlJNaUhNWjZQbCtBblpOdWYyWitU?=
 =?utf-8?B?K25laCtjMXZZOFJoRFhhY2d1ZE5LbnBZMk0xL3hBd1lNa2t6MHA1OXNId2Zt?=
 =?utf-8?B?TjBjczN0cjYxTTc2TFNGUTZyTUl0STJURnJJZVpSUy9pWCsrUzFzdXVoanRN?=
 =?utf-8?B?TXV0eDF0SHdkVnZFNUxITHgvVG9yUHFVcHdZNmg3cGtDelFEUWNDWEZyeFpJ?=
 =?utf-8?B?V3UxRUJKeDFqRXZ4M1dySFZJbUtNS05GS3JVZkxBSmg0VzhvTmI5WHVOaElp?=
 =?utf-8?B?ZXFxcGtmUGlJdzdpTHdtY3FKZ2hEbm9rU1dZbXEvbkFUQ0dxQ0VxSHM2Um1u?=
 =?utf-8?B?ajg2L3VmRzAvbm00b0hyS2pOZ2xzeGNJK0RRbW41N2hiRHlYVVY4WXUxZkNW?=
 =?utf-8?B?S2FkSTNqdEcvQTkxajVSYmEyaXV6c1Y5YXNjWGhuaHllWFZnRVVWNnlla2R2?=
 =?utf-8?Q?ILIAIgq+MnaJRJaCho/Rm6M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3ByOVpLSjJzSDg2WktBb2xMVXBDUmVRR0RtNndZS2k3TlRIMUtOOFpCZXBS?=
 =?utf-8?B?LytTTEQxQ25ZYXc0VE0rRjlUdDNYb2FuSWFZUG5TcmF5ZGtMZm1nSWI4a21X?=
 =?utf-8?B?UWtMdFV2NkxRckJkdkpLL2RuUTFlOFJKbVNvUWdCR256OXJQalIzNXp0bTNW?=
 =?utf-8?B?ZmJycmhhUXJlSGQ0Z3NwZ0xRcDBGbDFRZ212bXppeXE2alhscHpyaTRsTWVR?=
 =?utf-8?B?aVJmeFg3WGVsTzRBREgxQU1hSjBqamV3ZE9hVE9xSkgyMTZjcGNLSlYxV3Fo?=
 =?utf-8?B?eFRRUTdFaEM2WW5NT2JRaFduWGtPY3pSWERpRUdOR1Z2aDM4L01YcFVucThJ?=
 =?utf-8?B?dHU0OVM0NEtSbGpLMERHVjRWeGI5eUZvYktZYlBKSHM5TDY5Tm5JNWdmeWMz?=
 =?utf-8?B?VDJoODl2V2dmWVRBWm5wa05pcE0vckxkQndWY3FmK1h4MWx3Tks4SzBSZVdp?=
 =?utf-8?B?RzJybUV1MW5qbEY0L2kzdkEwRkRZMG5CTjZxR2dnRm4wcndOT3pPc2x6bTlX?=
 =?utf-8?B?enA4a1JJUVVGdnJhRk9DUVpTNmhVUzV0SEhzeUd0N0FIc3ZZWVBHN2RHWDZR?=
 =?utf-8?B?R0NYc1FVclg2dndqSllXbTFxM0UxK1o4SjM1b0lRTlNYZWlscjVNWWF2U2k4?=
 =?utf-8?B?WFFKM1pHZXFMd3hIdktZaXdveStvbXlPRjhTSUFCRExUblFrS2RvNWZ5OWh3?=
 =?utf-8?B?a1lmekM4eWNKaStla3M0NkJDT3VOZjJoVDB0VFdSTktJVElhL0xNb3pITHFB?=
 =?utf-8?B?Zmp0a1Mydnl2b2syRytVZzN0aGlFU3NYZmsyM0ZFWmFKSTR6Vis1YzFnbnVS?=
 =?utf-8?B?dVQwclhDSFdXejBUdzk5ZDUrSVNHcmZud2x6Y01welUwQnpmUzNwVDVLU2tR?=
 =?utf-8?B?eGc0aDVMcldydUhKT0NOK2JBNmhFTDI4dlFPenNmUlIyQkV0bTVXZzRpRGMr?=
 =?utf-8?B?SVNSc1FLNVBVWnJDNUxtcHhPbDRkVThLT25jRDJHRkRBdzFORXNlSnlSZlV1?=
 =?utf-8?B?QU55Tlh2QmNkNWx0WkZQYzc4MEsyeTJvcEpnSjRMUE1HUnFwWkQ2SElGSFZX?=
 =?utf-8?B?aWdid0NCaHNhbFNyRlRrVVVIUVRheTIyRHlPd3E2SEd5UmhPNzBYNy9NYTFm?=
 =?utf-8?B?STZya3U1RnhpYjdEY0tQUUpBU0haaitxWXZnMTE3ajlnNlZTNTQ3Z29TNnJC?=
 =?utf-8?B?ZjlBTUZwZGo2ZytzdEVHQ3JjSE14Q1dJUXRlU1h0cm9qUG96OVkxZTVoZ2wy?=
 =?utf-8?B?cVMzdUhoWGVhYkMwLzlRWjlNMmdlUWxPQkh1YllxUUVDTHl5NlpWb0p6clFk?=
 =?utf-8?B?WUFkeUpyZFRmK0ZtRlBKVWYvWUhBWmwrQzJza0Q2clhLaEtzNXVzR25zQnV5?=
 =?utf-8?B?aE5wR2FGdG1wbTR2VGJ4czYyL3Z6eVpYVUVhb0ZFdlA2K0UwazVrNmFvcy9C?=
 =?utf-8?B?ZnJONys0RWpLcXE3YVpWRk1QbHhWU3ZTTGNNVmtRUEFoQVd1aS9KckN0OHlM?=
 =?utf-8?B?Zm45ZE1adi9lY0xPVWdEL210RGRRM0RXWUtyUms2d3V3Z3FZQWx0ZkN2OEJW?=
 =?utf-8?B?c2hjcXMzblBaa2xsY1o5TDlkQWtDTElFQUk1d09TTStqRXdaSkF4Vkk0eWlq?=
 =?utf-8?B?RXhNY1hkcmhZKzNnWE42Y3YyY0phU3dseUZUMnlnSGVaelgyYnJOZlNIRzQ4?=
 =?utf-8?B?Mnk3czdPVmsySzVmTFM4RzdPSThFUlZnUngycDRIUGNFU2NybWJ2WURSUjRs?=
 =?utf-8?B?SVVud2JJVE9uNG4xVnZSOFdDM0ttUkI1bEcrWlplZ3ptdFJtM3BPYnhkcVhW?=
 =?utf-8?B?QW5rcnlXUmoxNGZzc2h3K2U1eE01amhDNkgyaUZYdWppNzhvZkVxcnlZQ0tX?=
 =?utf-8?B?YTZBUjEyYjNOSHJoMFBrd1BhMkEyd0ZZNDVFRU1NQnQ4c1cxdWkxRHZrbU1u?=
 =?utf-8?B?cnltV1p0ZVdxSFRlNmFnL29IbmhzdVFkTDZ6V3hMcG1wV1V3TWJqd0tlSHlV?=
 =?utf-8?B?bllta3BtMUlmVUtUcUE1bUk3K0VRd0RZNXZVQ3Fkb0VZT2ZzVkZOOUYzbHpE?=
 =?utf-8?B?MmwxTzdNSUQ0YS8yalcvMTl0dmtyemtDQTNkQkZLOXp4QXlTVFZ1QXRqbW5B?=
 =?utf-8?B?blpqVURyRlhuMUJST3BSZVRzQUMyNzVoSXVwL1lidWpidlpqWE1DMC9yUWov?=
 =?utf-8?B?cEVDVnVQdGllTDF4QmM0QmhiRGRVQTgxL0VVRDIyUDNZZjRUb0NaaVFhZmQ3?=
 =?utf-8?B?TEI0K1RuOTBkMXBHeTVzUDI3NjFycm1mL2N1ZWZ4TDZVMytLdHIwOEZxejZX?=
 =?utf-8?B?TTRJYVFxdy9SbVM2SVd3ZzMyc3N3SUtaZW1ieGFaQ0xDdWdjbVA3Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5358aea-9de8-4902-7f2d-08de649bdb23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:49:29.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjcUPm6T7RR0CsNC4ojQm03afHMjdS7aqAHRynR/K1z8rZDC0tckh7DwaPaRRiedmFPVMC1Cpr4Pt0gq0dE+VRZoD9qCHVLdXf4Ogy3Lwn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6281

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC80XSBBZGQgQVNUMjcwMCBJTlRDMC9JTlRDMSBzdXBw
b3J0DQo+IA0KPiBPbiBUaHUsIEZlYiAwNSwgMjAyNiBhdCAwMjowNzoxOFBNICswODAwLCBSeWFu
IENoZW4gd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgcmVwbGFjZXMgdGhlIGV4aXN0aW5nIEFTVDI3
MDAgaW50ZXJydXB0IGNvbnRyb2xsZXIgYmluZGluZw0KPiA+IGFuZCBkcml2ZXIuIFRoZSBvcmln
aW5hbCBpbXBsZW1lbnRhdGlvbiB3YXMgZm9jdXNlZCBvbiBhIG5hcnJvdywNCj4gPiBQU1AtY2Vu
dHJpYyB2aWV3IGFuZCBjb3VsZCBub3QgZnVsbHkgZGVzY3JpYmUgdGhlIGNvbXBsZXhpdHkgb2Yg
dGhlDQo+ID4gQVNUMjcwMCBpbnRlcnJ1cHQgZmFicmljOg0KPiA+DQo+ID4gKiBJdCB3YXMgZm9j
dXNlZCBwcmltYXJpbHkgb24gdGhlIHBlcnNwZWN0aXZlIG9mIHRoZSBQcmltYXJ5IFNlcnZpY2UN
Cj4gPiAgIFByb2Nlc3NvciAoUFNQKS4NCj4gPiAqIEl0IGNvdWxkIG5vdCBoYW5kbGUgaW50ZXJy
dXB0IHJvdXRlIGNvbmZpZ3VyYXRpb24uDQo+ID4gKiBJdCBjb3VsZCBub3QgaGFuZGxlIGludGVy
cnVwdCByZWdpc3RlciBwcm90ZWN0aW9uLg0KPiA+DQo+ID4gQnkgY29udHJhc3QsIHRoZSBuZXcg
YmluZGluZ3MgYW5kIGRyaXZlcnMgZGVzY3JpYmUgdGhlIGludGVycnVwdA0KPiA+IGNvbnRyb2xs
ZXJzIGF0IHRoZSBibG9jay1mdW5jdGlvbiBsZXZlbCBhbmQgcHJvdmlkZSBhIHVuaWZpZWQgYmlu
ZGluZw0KPiA+IGRlc2lnbiB0aGF0IGNhbiBiZSB1c2VkIGZyb20gdGhlIHBlcnNwZWN0aXZlIG9m
IGFueSBvZiB0aGUgZm91cg0KPiA+IGludGVncmF0ZWQgcHJvY2Vzc29ycyAodGhlIFByaW1hcnks
IFNlY29uZGFyeSBhbmQgVGVydGlhcnkgU2VydmljZQ0KPiA+IFByb2Nlc3NvcnMsIGFuZCB0aGUg
Qm9vdCBNQ1UpOg0KPiANCj4gV2hlcmUgYW5kIGhvdyBkaWQgeW91IGFkZHJlc3MgbGFzdCBmZWVk
YmFjayBnaXZlbiB0byB5b3UgaGVyZToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI1MDgxNC1hdXNwaWNpb3VzLXRodW5kZXJpbmctamF5YmlyZC1iNzZmNGZAa3UNCj4gb2th
Lw0KPiANCj4gIlRoaXMgYmluZGluZyBpcyBub3QgaW1wcm92aW5nLiBZb3UgYXJlIG5vdCByZXNw
b25kaW5nIHRvIFJFQUwgcHJvYmxlbXMNCj4gZGVzY3JpYmVkIHRvIHlvdS4gV2hhdCdzIG1vcmUs
IHlvdSBzZW5kIGl0IGluIGEgd2F5IG1ha2luZyBvdXIgbGlmZSBkaWZmaWN1bHQsDQo+IGxvb2s6
Ig0KPiANCj4gU28gaG93IGRpZCB5b3UgbWFrZSBvdXIgbGlmZSBlYXNpZXIgbm93Pw0KPiANCkhp
IEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQpUaGUgc2VyaWVzIHlv
dSBjb21tZW50ZWQgb24gaW4gQXVnIDIwMjUgKHY0IDEvMikgYXR0ZW1wdGVkIHRvIG1vZGVsDQpU
aGUgaGFyZHdhcmUgYnkgaW50cm9kdWNpbmcgcGFyZW50IGNvbXBhdGlibGVzIChhc3BlZWQsYXN0
MjcwMC1pbnRjMCAvDQphc3BlZWQsYXN0MjcwMC1pbnRjMSkgd2l0aCBjaGlsZCAiaW50ZXJydXB0
LWNvbnRyb2xsZXJAIiBub2RlcyB1c2luZw0KYXNwZWVkLGFzdDI3MDAtaW50Yy1pYy4gSW4gaGlu
ZHNpZ2h0LCB0aGF0IGFwcHJvYWNoIGRpZCBub3QgYWxpZ24gd2VsbA0Kd2l0aCB0aGUgYWN0dWFs
IGhhcmR3YXJlIHN0cnVjdHVyZSBhbmQgcmVzdWx0ZWQgaW4gaW5jb25zaXN0ZW5jaWVzDQpiZXR3
ZWVuIHRoZSBkaWFncmFtcywgdGhlIHNjaGVtYSwgYW5kIHRoZSByZWdpc3RlciBsYXlvdXQgKGlu
Y2x1ZGluZw0KdW5pdC1hZGRyZXNzIGlzc3VlcykuIEl0IHdhcyBhbHNvIGRpZmZpY3VsdCB0byBy
ZXZpZXcgaW4gaXNvbGF0aW9uLg0KDQpUaGlzIHNlcmllcyBhZGRyZXNzZXMgdGhhdCBmZWVkYmFj
ayBieSBjaGFuZ2luZyB0aGUgYXBwcm9hY2ggZW50aXJlbHk6DQoNCkZpcnN0LCB0aGUgYXJ0aWZp
Y2lhbCBwYXJlbnQvY2hpbGQgc3BsaXQgaGFzIGJlZW4gcmVtb3ZlZC4gVGhlIG5ldw0KYmluZGlu
ZyBleHBvc2VzIG9ubHkgdGhlIHR3byBpbnRlcnJ1cHQgY29udHJvbGxlciBkZXNpZ25zIHRoYXQg
ZXhpc3QgaW4NCmhhcmR3YXJlLCBJTlRDMCBhbmQgSU5UQzEuIFRoZXJlIGFyZSBubyBpbnRlcm1l
ZGlhdGUgaW50ZXJydXB0LWNvbnRyb2xsZXINCmNoaWxkIG5vZGVzIGludHJvZHVjZWQgZm9yIGdy
b3VwaW5nIG9yIGRyaXZlciBjb252ZW5pZW5jZS4NCg0KU2Vjb25kLCB0aGUgcm9sZSBvZiBhc3Bl
ZWQsaW50ZXJydXB0LXJhbmdlcyBoYXMgYmVlbiBjbGFyaWZpZWQgYW5kDQpuYXJyb3dlZC4gVGhl
IHByb3BlcnR5IG5vdyBkZXNjcmliZXMgb25seSB0aGUgZml4ZWQgaGFyZHdhcmUNCmNvbm5lY3Rp
b25zIGJldHdlZW4gaW50ZXJydXB0IGNvbnRyb2xsZXJzIChpLmUuIHBvc3Qtcm91dGluZw0KY29u
bmVjdGl2aXR5KSwgcmF0aGVyIHRoYW4gYXR0ZW1wdGluZyB0byBlbmNvZGUgcm91dGluZyBwb2xp
Y3kgaW4gdGhlDQpkZXZpY2V0cmVlLiBSb3V0ZSBzZWxlY3Rpb24gaXRzZWxmIGlzIGltcGxlbWVu
dGVkIGluIHRoZSBJTlRDMCBkcml2ZXIsDQpiYXNlZCBvbiBpbmZvcm1hdGlvbiBzdWNoIGFzIHRo
ZSBpbnRlcnJ1cHQtcGFyZW50IG9mIHRoZSBydW5uaW5nDQpmaXJtd2FyZSBlbnZpcm9ubWVudC4N
Cg0KRmluYWxseSwgdG8gbWFrZSB0aGUgaW50ZW50IGV4cGxpY2l0IGFuZCBlYXNpZXIgdG8gcmV2
aWV3LCB0aGlzIHNlcmllczogdGhlIG5ldyBiaW5kaW5nIGFuZCBkcml2ZXJzIGFyZSBhZGRlZA0K
Zmlyc3QsIGFuZCB0aGUgbGVnYWN5IGJpbmRpbmcgYW5kIGRyaXZlciBhcmUgcmVtb3ZlZCBpbiB0
aGUgc2FtZSBzZXJpZXMuDQoNCkluIHNob3J0LCB0aGUgZWFybGllciBwYXJlbnQvY2hpbGQgbW9k
ZWzigJR3aGljaCBkaWQgbm90IGNvcnJlc3BvbmQNCmNsZWFubHkgdG8gaGFyZHdhcmUgcmVzb3Vy
Y2UgYm91bmRhcmllc+KAlGhhcyBiZWVuIGRyb3BwZWQgZW50aXJlbHksIGFuZA0KdGhlIGJpbmRp
bmcgbm93IGRpcmVjdGx5IHJlZmxlY3RzIHRoZSBoYXJkd2FyZSBibG9ja3MgcHJlc2VudCBpbiB0
aGUNCkFTVDI3MDAuDQoNCkJlc3QgcmVnYXJkcywNClJ5YW4NCg==

