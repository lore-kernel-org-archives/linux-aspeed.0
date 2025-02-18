Return-Path: <linux-aspeed+bounces-767-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD4FC02198
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Feb 2025 11:05:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxxX926Mlz2yvv;
	Tue, 18 Feb 2025 22:05:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200e::718" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739876745;
	cv=pass; b=Icu/Byu7HvIj3kRYbLJ6+poZvcs0dYGbubnkL2NrfPVQUnh7lilSYy1OzRFPz+R3aiGLzMT1sfGYHntTKq1XUn448KbvHf8zvKG2DkzIOLmN+IInGyZ8hHxlaUdNudtYU7cutQtqvf+bDZO2JJOnHMDQZRnOCi2TuaVFEidADtaOIt8lpOS2p2HkYeUcbl2snblhYeVGezFlnYFkIZPwumozxORuw7iu9Pq+/kA7XIy7lEjwnAIQPDVsDdzLhnbr2Dz1U0z2djpvR7m6c1ECXBksgml+MaJ6NuxiYNP7uyY6jnTjRz2yqYiD1ZpldISS2/dFRvGYkXqasIfnuki04g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739876745; c=relaxed/relaxed;
	bh=IJXEVN7M2ec4XdTgdOvQQ1r0v2XS/DwS5beI9odaaNU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KTKkthOA4WZlwyIUNLPiGAiFkQ/Dny8mndzI0oxgUH4elRfZZf9qx3hjCbvoQTdiwpzXfl6Pz2Z8ufeQRNiRlfOE4YDDJCvHi/E/k/5iu9gefw5vZ/dxIHLotbDHpnkU08MGmVMGKsEK2QaGnoyyZhEfO3jtOwVLP4ZhtZ3Gr71eoo8Sxgquxzd5O7bSPHyZjOxrF/D7nAV2/5q4oywgvYfF4mHYdltywFgvbzx9KYvaoWnWNeLPKGdI7tuRgL9qEkkPqWM6iv76CZerjDbfH2/Hhq2r0o+ImbI1fZmoAgdu07f8+xW4o5YxULLQTj8EgUFkrdWOTXXsxM+hXca1uQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=M0w8PCFK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200e::718; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=M0w8PCFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200e::718; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f403:200e::718])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxxX70GYHz2yvs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 22:05:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlscOCAHUuphGjHoppjMBa3s2S3ocgy+Ecwrhzg29M3h0ZN7uJdKld5+/xAYr6/cyxXpoy+/EYiDLeiVZiewBVocWPL6pZCjTEjSlThixXyoYweJb3yhF0/vt+kJBTYU4h5H9rrg6PVmn3sIKykbUwI2rvGaSCbYGkUaGGhE1f1K0sBYmyOEJ3BViPrn/lFK/tAa+hshWp8sqhn8Czpa7OPj27mNAwmrdg4ZSin+5gPeEopN4UuutAizXRiDkiDPf6xE9KoEaAMnFpjp2HBszFsKKcMDdikv7aiwg/nHyTHNdNsUe6V0j///eYVvz76P2A2t4YWJj9+yZz+6KMNpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJXEVN7M2ec4XdTgdOvQQ1r0v2XS/DwS5beI9odaaNU=;
 b=LHbcQrSecxM+rKKWhQJzVo99nxKgo/SU0ka0dpGBdHegBaBXW0cflbeVoicdljAu3Ci/y31p7PlZkv1S7gfSDWoP20kwpaxLVnJPNdPfttc55pCbQvhixQpyh5S3Xt1c5wFhLFlxnAfKVYvhsoNkQEeUDcyf1AKbgy7I80EhvxPDUbuZB56cy+b+GtBi/9oVaFSgaDJqhqNcodXurnG5G6hGaWliQRIR8RpNyEC/DPmOD68LRBKFKoi6ekS8MagSIYPhPY5ZMaNfH3muQsiSZ1W6OwcNxXjdBihBp4eR3nM+4mqUu3MhsBmz6azR0bDoO2Y6Ju0hjEFc5h6PWkjlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJXEVN7M2ec4XdTgdOvQQ1r0v2XS/DwS5beI9odaaNU=;
 b=M0w8PCFKW5GhJm54vKw0FfW1d6Yc206q7+Be6ZR7Vc3iquw3OuACTHTdCy8I/yhIvqpI694uDbK1HZc03hsD90RlT48A/f8EUcAbb8QG9l/eqrr+Hbpe62r+MzlXfb4jdYtBPcEkST1RTrFgD20bN7DTAJzjIoiHJDYoUsVij/afhoAh3yTiGnFw5oIu/YLBYkgU/IsuvDAj2aDml2r2V63kh50j0bCkzERmYw+Uw6jugtSLLIH63v2vRJ+b5SvjUM5pwinNTeHAUGfiTXwQokotAJcbhW+fZrOHkZ9L0HfBgQ1WWY07qowUeSOQtJKy+xGr2FRjSK00bZkMw/1LpA==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEYPR06MB6508.apcprd06.prod.outlook.com (2603:1096:101:172::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.13; Tue, 18 Feb
 2025 11:05:16 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 11:05:16 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "elbadrym@google.com" <elbadrym@google.com>
Subject: RE: [PATCH v0 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Topic: [PATCH v0 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Index: AQHbaMWDLvNKL3+DeEen8gMIrRoxYLMcMfgAgCji+kCABn8ugIABgpRg
Date: Tue, 18 Feb 2025 11:05:16 +0000
Message-ID:
 <PSAPR06MB494959646EC7A8447056777B89FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
 <20250117095217.661070-2-kevin_chen@aspeedtech.com>
 <bad78886-2577-476f-a80f-e189a178b26e@kernel.org>
 <PSAPR06MB4949CB5CE2E08B98B368160589FF2@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <78dc2cee-2d87-42a9-8e0b-2199c653def4@kernel.org>
In-Reply-To: <78dc2cee-2d87-42a9-8e0b-2199c653def4@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEYPR06MB6508:EE_
x-ms-office365-filtering-correlation-id: 13b5dea0-232b-48d4-0f24-08dd500c2013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjFCeVhybTdjMHBnWWduK0VEcHNHY2prcU5TcUdwUnE4WUU4Znc0TjNCK0Uv?=
 =?utf-8?B?eTN3eHJUeFJsK3ByY0xIRmVGdjRxaTlKZW1UNFl2VXNSUCtRd2dkQ2o4TUNR?=
 =?utf-8?B?WnhkTGwyZ3pqamRoK0tEU0NNc01kdTdCK2ZMdlJXczNCOWdUYkxLSGpUWkVa?=
 =?utf-8?B?d2Nvd3pJTWd0YUxXZE5wMVFYL2ErV1JrcDRXTGtNRFdzUjY0VW9KVno1MUFa?=
 =?utf-8?B?ZVdkSThKTUhKblJyQ3RsNXBaWVh3TWY4YUF5Y1k4M1M5NHF4TDFCc0tjSmx0?=
 =?utf-8?B?ZXk5QVRtb0hvemxKKzdPOGI0dk8vM1R6dkFUbnViNzFBeXF1NzdpUCtQMVpG?=
 =?utf-8?B?MTNibFNTanR0V1FPbG5KajkxZnVCWVFvM0NUUk5xSlpITXdsS2VWQk1XZEpC?=
 =?utf-8?B?MDZhcnpjQ0NaRnVvU0pxdkV1c0FRVWN0QWMrSFlRZTI0T3hQbEJZSHJwcGUw?=
 =?utf-8?B?TzlJSWZlSEpSTUFYRWhXMHNnTXUreVhPQk5NQUlmZXFYOXR5cWt3ckxDLzhx?=
 =?utf-8?B?clNDQUlyZlIweGdEUUYzdzNCbTVaT3VXM3VBSDNtTVNlcVJPZzltWTdoOHNz?=
 =?utf-8?B?SHEwNHpVbUJ0YkwvcnpHeEx3MUtBZG1ZOHFKY1hQYUc5ejFrbjd6ajlKUDZv?=
 =?utf-8?B?cXZZd3FzaXhId1BrSU9lOXVrY2tQT2JkdVljcmJMQTRQRVowVERMcWhXSERP?=
 =?utf-8?B?VEluRkFUaWhlZ2FxK0RaLzVIZVUwOURVbng5cGVMT05jQzdDcWplZzkyOXhh?=
 =?utf-8?B?aVV0ZlgvS1htQnBsMm1udFNnVFJhNjRVV3EyVDVnbGdWdkdYd0UrRW1IVnhn?=
 =?utf-8?B?OHpMcE1FM3hiSGJXSzdkNEc5M0FyMXRZbnJYQWF0NDVBZGdZTXc1R3lKQnVF?=
 =?utf-8?B?OVFGaitOYWE1RTdqMURBT1FQaTh2K0w4Y2N5eXdTNHRXeThoRFpsQnljS0sv?=
 =?utf-8?B?WGRpb0l2SFpXSU42N0oyTWVpTFBMRjhGUUVhV2QreEJpWTlkWk9LZ0tFUWR3?=
 =?utf-8?B?VzF1SnBISGpPN3d2R2xhQnJYQXB5NUQ4ZUs5cERvdjlveVBkdW5WMGlKR2Ft?=
 =?utf-8?B?YndpdWNmbEpIRXc4SGR3QUJKT0t0SVdQRWhVckFCR013ejVud2FIRjhVZU84?=
 =?utf-8?B?YjhyL2JrR01wc015Ui84aUlvakdHc1JRTTlnVGdCc01scm0vcENQbmRBMkpa?=
 =?utf-8?B?OFpETnNhZUREaTBTeU4rT3JJZWkyU1lBZUdqN21TWkFNOHcvYlVUcDZzcTEx?=
 =?utf-8?B?VnZGVG9TNTBiUDE4QVJRRGRtTVBLcUY3bUtseWhETEhlbStJVjI3cVNJeEhy?=
 =?utf-8?B?S0twditDNVJKeGVYRFlHeGNpenZsYXZQSTJTUWc3STdFc0ZZZ1BCeWszcTFI?=
 =?utf-8?B?MERXcFV3KzZEQTBxTEFva2ptYlYrc0RVR0hNMU1FRHBzb0lMR0pYZVFMR0pR?=
 =?utf-8?B?VnFQUmU1Qy9DTlFBMTJ1Y0g4NEV4WVhqcVY2M3VkTm13cVh5Q0REb1VSQStp?=
 =?utf-8?B?RmpiOTFDZElwRXhIVktjdnhsMnI1ckFERzB0bld0aEJ0NXBSVTNGc1pYbGFj?=
 =?utf-8?B?aTI3d29pTVFkS1prUzVmTEtUVWJzNlc0WVBPU3BxRk9WSzJxOE50QTFkTmFK?=
 =?utf-8?B?OFh0clNGbTBCRjVPL0dGVWtUZmdxNzFHT1JEV093R29Eb29DVk91ek8vdnNZ?=
 =?utf-8?B?T0c3MXhibmZIaTliY1ZNeTdKY2VZbjFZNWVnT3hZUTNuaEdzWWYxS3RzeEpu?=
 =?utf-8?B?U1U2NUJXaVpXL0NGS2EvZ1EwSDZFYWxiZ1g1WmtTUXBDTUdsUDlvTmhXN3lN?=
 =?utf-8?B?T3dkMjcvL05MU29nYzBxVnA0L2VDYnUzUlh3NUttbHJZS2lOTGRtWllqMkxY?=
 =?utf-8?B?dHUxWGM2NXlQZStRUUd1ZW1BeW1MQk0vSDFSa0Z4dkFyYUxIS0gvYVF0UUZ4?=
 =?utf-8?Q?2WnKayets9f2vDncGCGbs78MlzSPgg6r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHRtbllRTlZ0VGp4M01nT0JiVUpJT1RpVittSHFDYWhXOXBQNWlDNkJ5aW10?=
 =?utf-8?B?bnZUcDZLUFdUaTVkTXpYZ1pxbjhXaDE5aTNEUFN5U2FQMFY4OTRpWnR5WWZX?=
 =?utf-8?B?c2k0VC9zc3V4Q0FRcTJtcTRRaEJ4Qk5WVG9MellwTWVzaGF2SXNWdXpZNEd6?=
 =?utf-8?B?QVV2TmpkS2FOVzE3UmtJcllNUXVCM2FMV2lNWEFhMXhTSGc3V1lDcXk0TlRX?=
 =?utf-8?B?d2VPOGVtMXVGVU9ESlhWZlljN0tsS1cxcXhmbjFsbVVRMGVpZzNYckw0N3Vi?=
 =?utf-8?B?c0NKTFF2S1R2YTNwN01GS1hKQjBGcGxwQ0R1Zm5TMzNJUW1kNGVZMnVNTjB4?=
 =?utf-8?B?WmcvQjZRRzBFbFZTcUFFYVB2V0ZRbjQwaFVpbGhVdnRZVndKbFhjWmFIV2ln?=
 =?utf-8?B?c0VxR3V0MDlCdXBzZ28wZk9TVGdSdS92VFhpenRvbVFjazFVY1UvVk9XTTFG?=
 =?utf-8?B?dEJtK2ttcDFsSkU2VkNOVnZvZDNmZ1dHYWtQQWFGK0xNRUU2dHdybmJtelpt?=
 =?utf-8?B?aUp6VHhuQzZISzFpZm1XaGhNVHpEZS95MEFJeXV6azd4N0tlamY5Qjh4SEJ6?=
 =?utf-8?B?eFFpcXIvaEI5clF6ckViZjZUVzVzWm1WWVNZby9EbXNsMjg4eU5GMWZmRTE1?=
 =?utf-8?B?d0U3Z0lNaFBaenZldEhpdncrWUoyalJHeEJhKzlESmNmN25rTS93c1hmQ0Ji?=
 =?utf-8?B?ajhYNEFuaEFxUmZDSXkwL3JGWkduR1dvdG1meTlhV2pLRVJ0ZFlaS3pzTEtP?=
 =?utf-8?B?MGpqd3RQbU80VmJyTnd4aTNmR0gvbm9rYXhCMWJXa3dvT2pSNnRUUlFZN0po?=
 =?utf-8?B?SVpSeGtKZkRrK1lzNkNRbXpaeEdRVFh5YjBCWVFZR2RqcWxRUEJlOFJPWTZH?=
 =?utf-8?B?MHZjTEh3QVZCN1A4SUg2MWFWd3hDZUt2NmlKd01oaVR2VkJabmFrcEZQUU1z?=
 =?utf-8?B?YmFOVFN2dy81WDZUM0p3QnFoYUVNSkN2VU13YWxyUDlIdjhnZnZ3cFBFdFBE?=
 =?utf-8?B?UWRVUW5ZZFU4dmh4S0lsQ0tQMHZ4Nmx5dmxLUWlCbThJeXBIZFU5VGp1ZWor?=
 =?utf-8?B?YlpNUy9ReXdGQzd5NmpLeXYxRWFMOXlTOGhMVzNBZ2FtRHdCYjdvLzJhb3di?=
 =?utf-8?B?ekdxeFEyQmxRUnZDaFFCTGUvM2VDUzZCeTBadFk2YksxRkJ2ZndnNmJZWWVQ?=
 =?utf-8?B?KzVEM2x4S1lCTTEyVUp4cnFxekd2OWJ4anYxRzhXcTdjUkxCTS93MFB4VHdB?=
 =?utf-8?B?T2V2TnlnU0tWTjNtbWwvaFJXc0dmTm1qdklXUTVKa3FDdUZhTGtRa00wZlFl?=
 =?utf-8?B?YXFIRXpkZHBFaUN2Ky9xMFF3anBzRmxBU0xwQUNqUjI2eXplT28zSFdLbVRS?=
 =?utf-8?B?WGtveXA2NmVJL0V4YjkvUXhTd2xJNUFYZU0rTUlFQzBWZ1M3K0FzWm9VL1N3?=
 =?utf-8?B?c0h0Rk1pa1hkbzhhZTgwSHJaUzVaMWVRK1NqN2FaVlJNdzNJMXYxS3Q4Z205?=
 =?utf-8?B?eTlwZ0FXRmRkWWplL1VvdGdCR2ROSG12SEd4VlpRUFNjM2tjUjRUclNPR0l6?=
 =?utf-8?B?LzYzZFdORjk1WkxFTG1FQmdhaER1NmFmSW1jWnlEM2lrN2c2d1l0cUZsMlM1?=
 =?utf-8?B?U2xnLzRRM2tId2xYS1JzakIvZ0VWNkNaWnlTT1JObGREZlYvUWdUYTZzQ28z?=
 =?utf-8?B?RTVPM09LSEVERVMvbThiMWhXVklvNC9EaC9tZXR1RHFZMDlkWTRhaWtBUzZo?=
 =?utf-8?B?R3hmUlE0NlhlU1VRbm1LTHIrd21lMWw1VEEvR1RWSzcyZXpqQzJ4Mm5TY1px?=
 =?utf-8?B?ekdIM044YU1hUmo2Ni93SEJqenRKUlZvYmJ2VlBCaVArQVZMRFM4RXVNWkNa?=
 =?utf-8?B?ZVU1M3pIWFFkR1pHVERDNVJTb1dVbVRwZmttQWN0LzBiME55MGFibzBsaUVJ?=
 =?utf-8?B?ajFQU21EZ2l2aSs0QUNVZml5eTdwb1RvM291UnRRekk0QXFPYnE1SVhVekFZ?=
 =?utf-8?B?RXV5YjJSMVJ4TFJLbjNDYkpoZlJxNjNEV0NFVVY0UGZ0UHUrWFJqcngyNVlz?=
 =?utf-8?B?OXpETkg4UHo2MXdnOVB3QU9YZ2x3VGVqY21JRTVzbGc0QXZPbFZSeDI1S3lw?=
 =?utf-8?Q?72WoW6geUXRXUsKmGyKpmXKm3?=
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
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b5dea0-232b-48d4-0f24-08dd500c2013
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:05:16.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiBqtdd/Iv0CoFJidXYFyqnPgf0cmGFTRwD662E6jc8gEvrzBZLTGNLUPz3qMCEH/nAgqF65IvqJFokc92KSgL6u7ie+9k6KHsfX9ZMCcCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6508

PiBPbiAxMy8wMi8yMDI1IDA5OjQ2LCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+PiBPbiAxNy8wMS8y
MDI1IDEwOjUyLCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+Pj4gQWRkIGR0LWJpbmRpbmdzIGZvciBB
c3BlZWQgZm9yIEFzcGVlZCBMUEMgUE9TVCBjb2RlIGNhcHR1cmUgY29udHJvbGxlci4NCj4gPj4+
DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBDaGVuIDxrZXZpbl9jaGVuQGFzcGVlZHRlY2gu
Y29tPg0KPiA+Pj4gLS0tDQo+ID4+DQo+ID4+IFBhdGNoc2V0cyBzdGFydCBmcm9tIDEsIG5vdCAw
Lg0KPiA+IEFncmVlLCBJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaHNldHMgb2YgdjEuDQo+ID4NCj4g
Pj4NCj4gPj4gVGhpcyB3YXNuJ3QgdGVzdGVkIGFzIGl0IGhhcyBvYnZpb3VzIGVycm9ycywgc28g
bm8gcmV2aWV3LiBUZXN0IHlvdXINCj4gPj4gcGF0Y2hlcyBiZWZvcmUgeW91IHNlbmQgdGhlbS4N
Cj4gPiBBZ3JlZSwgSSB3aWxsIHJ1biAibWFrZSBkdGJzX2NoZWNrIFc9MSIgYW5kICIgbWFrZSBk
dF9iaW5kaW5nX2NoZWNrICIgdG8NCj4gY2hlY2sgcmVzdWx0IGlzIGNsZWFuIGJlZm9yZSB0aGUg
bmV4dCBjb21taXRzLg0KPiA+DQo+ID4+DQo+ID4+DQo+ID4+IDxmb3JtIGxldHRlcj4NCj4gPj4g
UGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5l
Y2Vzc2FyeQ0KPiA+PiBwZW9wbGUgYW5kIGxpc3RzIHRvIENDLiBJdCBtaWdodCBoYXBwZW4sIHRo
YXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbg0KPiA+PiBvbGRlciBrZXJuZWwsIGdpdmVzIHlvdSBv
dXRkYXRlZCBlbnRyaWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUNCj4gPj4geW91IGJhc2Ug
eW91ciBwYXRjaGVzIG9uIHJlY2VudCBMaW51eCBrZXJuZWwuDQo+ID4+DQo+ID4+IFRvb2xzIGxp
a2UgYjQgb3Igc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBwcm92aWRlIHlvdSBwcm9wZXIgbGlz
dCBvZg0KPiA+PiBwZW9wbGUsIHNvIGZpeCB5b3VyIHdvcmtmbG93LiBUb29scyBtaWdodCBhbHNv
IGZhaWwgaWYgeW91IHdvcmsgb24NCj4gPj4gc29tZSBhbmNpZW50IHRyZWUgKGRvbid0LCBpbnN0
ZWFkIHVzZSBtYWlubGluZSkgb3Igd29yayBvbiBmb3JrIG9mIGtlcm5lbA0KPiAoZG9uJ3QsIGlu
c3RlYWQgdXNlIG1haW5saW5lKS4NCj4gPj4gSnVzdCB1c2UgYjQgYW5kIGV2ZXJ5dGhpbmcgc2hv
dWxkIGJlIGZpbmUsIGFsdGhvdWdoIHJlbWVtYmVyIGFib3V0DQo+ID4+IGBiNCBwcmVwIC0tYXV0
by10by1jY2AgaWYgeW91IGFkZGVkIG5ldyBwYXRjaGVzIHRvIHRoZSBwYXRjaHNldC4NCj4gPj4N
Cj4gPj4gWW91IG1pc3NlZCBhdCBsZWFzdCBkZXZpY2V0cmVlIGxpc3QgKG1heWJlIG1vcmUpLCBz
byB0aGlzIHdvbid0IGJlDQo+ID4+IHRlc3RlZCBieSBhdXRvbWF0ZWQgdG9vbGluZy4gUGVyZm9y
bWluZyByZXZpZXcgb24gdW50ZXN0ZWQgY29kZSBtaWdodA0KPiA+PiBiZSBhIHdhc3RlIG9mIHRp
bWUuDQo+ID4+DQo+ID4+IFBsZWFzZSBraW5kbHkgcmVzZW5kIGFuZCBpbmNsdWRlIGFsbCBuZWNl
c3NhcnkgVG8vQ2MgZW50cmllcy4NCj4gPj4gPC9mb3JtIGxldHRlcj4NCj4gDQo+IEhvdyBkaWQg
eW91IGltcGxlbWVudCB0aGlzIGZlZWRiYWNrPw0KDQptYWtlIGR0YnNfY2hlY2sgVz0xDQojIENo
ZWNrIHRoZSBscGMtcGNjIG9yIHBjYyBtZXNzYWdlIGZyb20gdGhlIGxvZw0KDQptYWtlIGR0X2Jp
bmRpbmdfY2hlY2sgDQojIE5vIEVycm9yDQoNCm1ha2UgY29jY2ljaGVjayBNT0RFPXJlcG9ydA0K
IyBTdG9wIGF0IHRoZSBmb2xsb3dpbmcgbG9nIGJ1dCBubyByZWxhdGVkIGxvZy4NCiMgICBPQ2Ft
bCBzY3JpcHRpbmcgaXMgdW5zdXBwb3J0ZWQuDQojICAgY29jY2ljaGVjayBmYWlsZWQNCg0KDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

