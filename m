Return-Path: <linux-aspeed+bounces-710-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE61C0219D
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 09:02:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ytq1y6PvJz30Gq;
	Thu, 13 Feb 2025 20:02:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739437334;
	cv=pass; b=CcdyQpFcboP5N0E7aZO8Fn/yN8vn6QEKpRAkRQiS9wgUHps3tL69uzO0a8lixXY80mHTCO7cZhtWDVOtZtLDutz/Q33I6Tf1Z8c+Xgv4ukT3h9xU8Xwy4dM3E/e5V4f8gi7mQrTRVdz629qwvQbZawOd8S6CD97zkqht3Eno26hkPmnzqS5pwLXsjC/DIa0YyWIxrDp4T2Bt+q33lhV348U+zW1Gip98yFaVGHPRbjPy0BCu8ZRFUHRzHHd/g4w74+XF7f1GUhZcTjANaTpYPPNwfwGrLHgvozLAjQ04UwdZiXXIHTOpzvdCySLpDbCDkbn4DVKBVEWhs+J4BjTaDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739437334; c=relaxed/relaxed;
	bh=fr/nbEMHoLkS8dJRvsio5tGP38RfYKC767ybCgw4wyg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MFJcyYwCiJBZ8CDRkJejKSqetC+3GIhhU+V2AnfMZYX9JjqmzvwptnEcT4MqNmrQNtwES9fDojBx97vMuuBdbEZkZvl1Qk+fJNJD6qzA3/D/yUFuP0Dhg2djaK4bJ0DZs74JwW1ZhBO4GS7tWpZ+cl/aOhfmLBPBt1YaGHWXKH4hktHLF1YXW2ejj/+VxvrLt04SBOrpYv8gLkFhg+wTjaLp70Y+Q1hAmf/gC6VwaYtASuF3gr/a0VfvLTJrSlXjd1FBQOdcKhIYA5hkNxnYvfRiI9V2nTy5EZrBcoVUyrtOmTA2HyuXpKHfmxTlhxkoPPiPrJgVazvsJacQGGrX4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=rI9KCxV7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c400::2; helo=hk3pr03cu002.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=rI9KCxV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::2; helo=hk3pr03cu002.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ytq1y2Hx4z2yK7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 20:02:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1+x4ehJ5rI2agA7HPxIkhb8hKFLdAtlyKHmqdGHcHRTtwhLgFfKcfJ8v8Vh354wROzJDFT/8ggRKF6DAUIhWo7iGJ5wiB75aegONTRbwBa8QVi8+qqzahRa86KIxY3glAQF8ZWzVYgy9yB8MB7E/7VZAcXAiuhGquWZUcm1+I/zge51okKsB5bL0PhKnbDP3c4m4CRZl4H3iEy9zNQL4pwFsXXMQFTU35MrHT6E6t/BqkenqSc26u1JfhuA8/wHH+gE8OMOqEsKsbj2WjkQCyW3WoTxe40s9ADALauxE5ieUTMr3r8RmWKyTZdauABZwA0ijXDBrIt8IMMQ588QvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr/nbEMHoLkS8dJRvsio5tGP38RfYKC767ybCgw4wyg=;
 b=iuGmKDyi9iv9+eJCIEcgOvyCs0xIZmqIcWTRrDyrH/Fm7k9Rd3E2OldI1lJBnf/wuuoNzvikDDVTsaZ/MibBQqBQ+m4G7qLYRcaYTYhNllH7or/xgvWlCVT+9TBzWsUi1jRxdBUxMrXN8Mc3E3Y0ztwFNJRX7hgBE7B9DK9gR+vCKYLQfD+w0b0ZlCDxArIkzO77hJbXBhK9ohgprO0nXt2Jc4UaoG+5li2ZW5ZecWXpgg3Ab7AQZvC4w0YVj7NsDWPjW+kBIOfnMzRzhGASPhzN9/jychYeouXELWeZlAL2tbq3psmAwDfU66kPlNkJkOMYb4LehJGgBhiu1I8GhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr/nbEMHoLkS8dJRvsio5tGP38RfYKC767ybCgw4wyg=;
 b=rI9KCxV7kr2g1rBL35kEp/4I64r1U4+8nAMGM1R12zTUwQyHIp9hRd+KAZV0s1N8yHpzv9SA1nH52HlSXbYQVxOCzVZxmU6jWkgYNsacoKuaqM6mo9fEzyRZP5UWxH7d6D+v8TGlAgwGhydDVvSagyBoRpT47WC0MHHUDHeCQQNnBDtAmxO1JkC6lEIXoiQRtpB9KPWSevPYsT2bj6Wtvnk1zAlPTaw7PLJX7UqwckrTwt7uF3vrcqy10vXyp5YRu1OewIXLeN30g1LerBeyIkVnZsgOZ6czGjz9SiasIYpwPR7n33MQ7T057dt8/ggfA+SY2bX24sAqnovuk8+KvQ==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR06MB6072.apcprd06.prod.outlook.com (2603:1096:820:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 08:46:00 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8466.007; Thu, 13 Feb 2025
 08:46:00 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "elbadrym@google.com" <elbadrym@google.com>
Subject: RE: [PATCH v0 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Topic: [PATCH v0 1/3] dt-binding: aspeed: Add LPC PCC controller
Thread-Index: AQHbaMWDLvNKL3+DeEen8gMIrRoxYLMcMfgAgCji+kA=
Date: Thu, 13 Feb 2025 08:46:00 +0000
Message-ID:
 <PSAPR06MB4949CB5CE2E08B98B368160589FF2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
 <20250117095217.661070-2-kevin_chen@aspeedtech.com>
 <bad78886-2577-476f-a80f-e189a178b26e@kernel.org>
In-Reply-To: <bad78886-2577-476f-a80f-e189a178b26e@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR06MB6072:EE_
x-ms-office365-filtering-correlation-id: bd949114-9d88-4ecf-07eb-08dd4c0ad771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWxhVHNYdHpVdVFTMS9hWkJWVlFuYnl4NHFmVERtUmp1ZjdaN3ZqL2I5QVV1?=
 =?utf-8?B?UHIrTVZMUW1kZWprQmJtK3BVVmovL0ZDQjFxTHNCdk9KdGU3MGoxRjVabkpL?=
 =?utf-8?B?ZXVsaXRybG9taTRaVXFxcFhIRStHTW9Sc0dtTGlBaHRJWCtTODN0NlUrNW9D?=
 =?utf-8?B?N2NMSmgwbWU2aWM5ZEw2Z1czM3IzNW1EdGRDUldOM3Z6c3VNVlB0dGJyWlpG?=
 =?utf-8?B?NXNuK29FMmdKMjQxVlcrVWh1bHBmd3lzNFhDd0tkTkRMUE5KaDJZLys0UFQy?=
 =?utf-8?B?a3FGa1Rpdkx6M0pTL3hCVG1sQ0xEY0pOUWE2WjlGT25lTGwxQ0dWSWpzdExQ?=
 =?utf-8?B?MHRzdTR4akR5ZVkwa2sxRUVHWlV1RXhVRVVxM0tpcmxac0ZEdk03T3h3b1Zu?=
 =?utf-8?B?TGlWWktBN3liOVBONnlhQlNOSUhyT1ZMYXhwaVh2QlcvVXFDTnBsN3ozb0RE?=
 =?utf-8?B?bkVFZXNjQ1VQdjhGMStqMWU1Ky96QndZc0QrZFV5UERtTmtGN2MwV0l3ZzVW?=
 =?utf-8?B?UWR4M1dJVTNNQ2hrRnErbnRtR2tLalQ0QnVnZ0lGS1k1eWlIREptQml4ZUsx?=
 =?utf-8?B?VUpLSytaMWhidGVFMVA4STZNT3A1dVQ3b2dTUlpxQ1JuamJZR1Z2K09GZXBi?=
 =?utf-8?B?bWR2aHBmM0ZueW8wL1A0OGo2aWRFRWVqY3lOV0xUcGtxcWpWNU1tcHBRSXU4?=
 =?utf-8?B?TmlSKzFCVkVnUkxwYkFacEhkUVZFN0ZqR1BHSHJyYUlFOVNleE9yemNFMlVB?=
 =?utf-8?B?czMyWktLQzlza0RZOXhoOC91WU4rRDVtSS9LUmx0YzAyNHEzQk5WeW9uaGtv?=
 =?utf-8?B?TmVPd3haNEJVTThEallvZmFPYUswZUd0YnJZNTRONEZMM3d1MG1XR3Rrakdw?=
 =?utf-8?B?Z21ER1RaZXp3QTd4QTdJMDd6QnBwZ3ErTm05eU9oNmxXZEwvejFjMEMxenpJ?=
 =?utf-8?B?M2RDMk12Q3oyOGFWd1NGSTFEV3dsMlN5V0xRcE1pdXhJV1hLNEJ2OC9WZEdI?=
 =?utf-8?B?OUFnQ0JEQlgrdEFmM3NiR1RXTEpMdzBlbHhwc2VXcWo1UElYZ25HMUNEdFVG?=
 =?utf-8?B?QmFpbmhVcjkzTkNoOUx4eVhzQmNPc2pHWklmWGZmWDRqRXB4REI2a0VJY2pS?=
 =?utf-8?B?NWtQa09PZGM4L2tHMmpicXJuSWJ4c1d6djEwMGdmdit2UUY0SVhKOGlBdWVo?=
 =?utf-8?B?a1liWVJldldCZjBPTFg4YVdxbXVlL0hRY0xadmM0VXA1M3NFK3lWVlhkYzZ1?=
 =?utf-8?B?SUJySW85Q1EzQ3pGSUpFTWRoR3JTamtHOENJODQ1TlUwRnVxWmZpb1ZBVmt6?=
 =?utf-8?B?dklQZks1T1ZqYkFVaUMyakxFU3k1ZDIxcjBtbTcydW9ocmQxQmR6NHpVRXhj?=
 =?utf-8?B?RnUwNStJUjJjT05ZQzJYY0pDM3p5Tko5NjZDS0t5eDlXMmx3SlBsTEw3Z0JH?=
 =?utf-8?B?RGRibXl1OEVBUTZNa3FDRDZIVjMvRXdTZGZMcVdNdWwvaWRzZnRxczBaSFQ1?=
 =?utf-8?B?RmprWUp0UlpTTnNGMlJVclFGdy9Ja093ekJlMm04T2xOeThueVFhbll0Wklj?=
 =?utf-8?B?RTlxeGVwNGtXSWNxR2hlNTRVWUxWMExid0FIWWNqcnV3N1FPc2ZJSy9kU3JW?=
 =?utf-8?B?ME1BVU5CQXhGck5yZHowZ1Byd0M0dlJDeDlMdnhBb0UrREo0eVY4UXp0TFQr?=
 =?utf-8?B?VU1TenNIMVcveXJLTEo3cVJMMDU4Y0dVcXV0VXU5bnJBQ1VwRWoremtFaGkr?=
 =?utf-8?B?UGxaY3Z6SlJrdGlEMGFMMnFrMTFYd1E3N2NOWGwweDFDdHZNMHpVeWc1SWhx?=
 =?utf-8?B?OHJyMFZ4czM3ajZ2TlZ0OSsvV2d6WitoWlA3Vit4Z2JCbEVYYlNGQUlZa1Vn?=
 =?utf-8?B?czU1OGp0cXNjWTk5L0wvcnZxQmc2NjRYckFPRUQ2aWhGWE5HRUV2SmRncWIx?=
 =?utf-8?Q?Ncy3vNWQUlhjyC5vnKbGQ+twR8kDvoc9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVUzVHNwVDAwMG5QY3U0V00vVXFWdXlwOE8yb3BjVldzZ3NrSXE5OUt1RnRE?=
 =?utf-8?B?ZEV0WXhnLzJPejFiSksxaUwzZmlDSFRzZEdNdW94WlN4aEIwT2tLZWVITnls?=
 =?utf-8?B?dDlocnRrOTB4bmljT3o1TS9vWHk4RW5LenpHUUs4T2t6Z3Iwc3U0T1FvckVP?=
 =?utf-8?B?Y3VrSFM5OXZ2bU9yQkZjaTZjQ3M0UHAwSUxlOW5JR0taOUNkRDBsWlN5REMw?=
 =?utf-8?B?N0pyMTVNMTZmM20zZjZleDVtUkdLMmNiZEU0TlhtdDVEd3ZxOXZodWR1dy9M?=
 =?utf-8?B?L244TW43Y3ZGSlZUVkYxbFlGT3ZlQWRId0hvcWNwUno0cllFdkE1ODNtTWRE?=
 =?utf-8?B?alROYUh4b1RWaEd6Z2ZmbUdaQ2pydlkxb2pSSEFNalk2QlBCOThKM00xdFc3?=
 =?utf-8?B?emhNY01WWjNsZm5CcXJYaDNiMmg3ZE5pam1EaEdDVmQwVWNsdDdlcUkzdVNF?=
 =?utf-8?B?bm1WdzVsQnFvczRUVUVVSDdHMGU5Y0lTa0NtVmtCNzJ2OHRkWUVqajBBbUFD?=
 =?utf-8?B?YTcxTVNVQ3Z3Y1pnR3JRYXFsb2h3bDdxOXFDZTRNbTN4RkprR1RmL2pLdE5i?=
 =?utf-8?B?VEZJeHZOSXZwNlhmQkpXUTFxeGZ5WG45V01tUmEwMm4wSnlUUjg3aXVQb0lY?=
 =?utf-8?B?clNnUkZCQ2VIY2RyRXc4MktBY0dEeUp3b09kZG4xRkxWQkRIOXE1YlBjSWo3?=
 =?utf-8?B?Tm5uYmJHM09YU001amtkUk1nalZPWjlQbFYrOHkyNWZYd3hFL2dJQ0ZCRUQ2?=
 =?utf-8?B?WTFUelJVMWpySTdYV2ZUdWdzY2JCSERDejZ0K2dRdjFYNThHQkwwL3ZQK2gv?=
 =?utf-8?B?bWo0UTExdnR5cDd3OGlqWk42NExHbWFXU0VtU0FnVE0xenJJajVzeWVLbGVP?=
 =?utf-8?B?a2N5NGQ2Q0ZiZXZFcmZjWTcxd3ZsYytDeHdXMWNHRm9lYS9jRVRvZGdYVTBB?=
 =?utf-8?B?b2wxdEluL1hkMmx5Z1cvWmVlOVBEUVJlS09MT3F6YU9SeWczV01MYlFKVXdM?=
 =?utf-8?B?b0gwZS94WjJRV1lsVDZnYjUrT0hiU2lKNXI2RWYxdDYwU3AyUGdLSzYvalhD?=
 =?utf-8?B?WVZORXU5RW9pRE4rcThpKzErcG82My9EWm9zYlhRUGlZR2lGaEI5N1Y1cTlY?=
 =?utf-8?B?NFNUaC9DTVp5L2FzRS83eXM3U1pUWHpXMVpzQW9iZGRBSmJGcFlwVFNHS0NV?=
 =?utf-8?B?aWZueWJpQUpwY29Qa2tEVmM3c3J6SGZVaHEzcTh3Mjh6K2o4VGdEQXdSaTg2?=
 =?utf-8?B?VUZmcGp3WTZxQUZ4dmpDdldBWkhVcmtsbzlEVTZQOXVyZmlUYVkzb3d1RHVa?=
 =?utf-8?B?NkxjVHpxSVNocXdadEZVNklhMTc4dnYyU3hpK2F3N2lmVngwZHRhMUJnTFEz?=
 =?utf-8?B?UVNDL25zVUU3YTdibjZKa3NhZVY1VHNkemhLVkpndnJ5eURiWFJwSS9MVTZL?=
 =?utf-8?B?d3hlNGhhS0RIVTFjTTJGK2JmYUVtQ0RKWi9aZDJNdkJLNFN3bldYWEtBUFA2?=
 =?utf-8?B?QlRmeklGNkt5VGpSSTEzRktFWmMzSG9HYWVPVzlhTjliTnVSQUZNamtJK29F?=
 =?utf-8?B?THNSQ0t1VVZVdExnOXFyMjFjY1FyU2NnK1FrWmhiU01CVko0U2EzT3Jldnl3?=
 =?utf-8?B?dTI1QVh3aGlpSjVXQ29XZ0xjT0hsaWN0dE1wTEg5WUkwZ0VtTUN5NlFsRWpT?=
 =?utf-8?B?cGJyTXNZbWhLUXpZNTRkNi9lL2hLNCtmZFZGOHJsV200UkJoMUZUY1dwQmh6?=
 =?utf-8?B?VmNhNlBvRGZkU0lsTzdhVGo0aHBHa0s2enNWcnozOFpPSHJXYSt5c3RhSi9x?=
 =?utf-8?B?S2FFNWNaY0YydUZoRllHYmgzMnlEdTFsVTkyTmhOQ2dtMDl0WlhJd1JRSHZP?=
 =?utf-8?B?WndJazIza1VDU2pEbDVmQ3h0anlZaVBUSk9YSkpxdFBIT1pXVUlRTEJVbits?=
 =?utf-8?B?by9WK3BsbGF1WnpVM2RLbm84ajVNa05CWVFHK2hKYUlSQ29KeVFqM3hTTU84?=
 =?utf-8?B?YmhKK1lmUjRlYndtMXdIU0NGejFIRldhUTRxakJoaUxPTEh4SnJiZ1RkcnVE?=
 =?utf-8?B?N2FKdHRPZ2hrdmdBZU1ReUZRUnFuOEkxaXNLWXRrVVZCakhqcHdsTFJZeUNn?=
 =?utf-8?Q?gUCEc8H9kBBivOnPk+bRvmLJ5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd949114-9d88-4ecf-07eb-08dd4c0ad771
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 08:46:00.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcvS51fuyHdRym/3tlqY1SOJSo1+E5kiid2TiJ+sI1oJlN4l6r6Py495YGuUF7wGRJDHgp8R6vs3riTyrtHiiDIQk2WQJzAkNlHnAJLLYg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6072

PiBPbiAxNy8wMS8yMDI1IDEwOjUyLCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+IEFkZCBkdC1iaW5k
aW5ncyBmb3IgQXNwZWVkIGZvciBBc3BlZWQgTFBDIFBPU1QgY29kZSBjYXB0dXJlIGNvbnRyb2xs
ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBDaGVuIDxrZXZpbl9jaGVuQGFzcGVl
ZHRlY2guY29tPg0KPiA+IC0tLQ0KPiANCj4gUGF0Y2hzZXRzIHN0YXJ0IGZyb20gMSwgbm90IDAu
DQpBZ3JlZSwgSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2hzZXRzIG9mIHYxLg0KDQo+IA0KPiBUaGlz
IHdhc24ndCB0ZXN0ZWQgYXMgaXQgaGFzIG9idmlvdXMgZXJyb3JzLCBzbyBubyByZXZpZXcuIFRl
c3QgeW91ciBwYXRjaGVzDQo+IGJlZm9yZSB5b3Ugc2VuZCB0aGVtLg0KQWdyZWUsIEkgd2lsbCBy
dW4gIm1ha2UgZHRic19jaGVjayBXPTEiIGFuZCAiIG1ha2UgZHRfYmluZGluZ19jaGVjayAiIHRv
IGNoZWNrIHJlc3VsdCBpcyBjbGVhbiBiZWZvcmUgdGhlIG5leHQgY29tbWl0cy4NCg0KPiANCj4g
DQo+IDxmb3JtIGxldHRlcj4NCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5w
bCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeSBwZW9wbGUgYW5kIGxpc3RzDQo+IHRvIENDLiBJ
dCBtaWdodCBoYXBwZW4sIHRoYXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlciBrZXJuZWws
IGdpdmVzIHlvdQ0KPiBvdXRkYXRlZCBlbnRyaWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUg
eW91IGJhc2UgeW91ciBwYXRjaGVzIG9uIHJlY2VudA0KPiBMaW51eCBrZXJuZWwuDQo+IA0KPiBU
b29scyBsaWtlIGI0IG9yIHNjcmlwdHMvZ2V0X21haW50YWluZXIucGwgcHJvdmlkZSB5b3UgcHJv
cGVyIGxpc3Qgb2YgcGVvcGxlLCBzbw0KPiBmaXggeW91ciB3b3JrZmxvdy4gVG9vbHMgbWlnaHQg
YWxzbyBmYWlsIGlmIHlvdSB3b3JrIG9uIHNvbWUgYW5jaWVudCB0cmVlIChkb24ndCwNCj4gaW5z
dGVhZCB1c2UgbWFpbmxpbmUpIG9yIHdvcmsgb24gZm9yayBvZiBrZXJuZWwgKGRvbid0LCBpbnN0
ZWFkIHVzZSBtYWlubGluZSkuDQo+IEp1c3QgdXNlIGI0IGFuZCBldmVyeXRoaW5nIHNob3VsZCBi
ZSBmaW5lLCBhbHRob3VnaCByZW1lbWJlciBhYm91dCBgYjQgcHJlcA0KPiAtLWF1dG8tdG8tY2Ng
IGlmIHlvdSBhZGRlZCBuZXcgcGF0Y2hlcyB0byB0aGUgcGF0Y2hzZXQuDQo+IA0KPiBZb3UgbWlz
c2VkIGF0IGxlYXN0IGRldmljZXRyZWUgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3Qg
YmUgdGVzdGVkIGJ5DQo+IGF1dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBvbiB1
bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGEgd2FzdGUgb2YNCj4gdGltZS4NCj4gDQo+IFBsZWFzZSBr
aW5kbHkgcmVzZW5kIGFuZCBpbmNsdWRlIGFsbCBuZWNlc3NhcnkgVG8vQ2MgZW50cmllcy4NCj4g
PC9mb3JtIGxldHRlcj4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

