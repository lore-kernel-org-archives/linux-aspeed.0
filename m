Return-Path: <linux-aspeed+bounces-4450-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5FDC43458
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jul 2026 06:12:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwl4m29m7z3cDd;
	Thu, 09 Jul 2026 16:12:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783577576;
	cv=pass; b=FVmxmSkVW7Zd5W1b8poAvnX6ydPwg+4WvDEHWLNb0cXEgW8/ZUr8Us47OGtb3kcdKN31pbOrUInPSMjGV6SVGVu0g1Fo2sXIdNrrO78oZf1wkMDS4psBwHteamKsl43nY6ob9tljZoL8GjLWWyhLopX0R2qoaDRYCUK7t5RgfTwA6w9E7LI25hnyRnGKEJMNbTjRLuFiAs53AuSv/qt0UzVTsuEdRYKv9T/P7KbTW4j4kNp2lR8q/w3qd9s70VUWl0BvyP9a/KwG/rkwAmwT0Gl0cr0cpRsSLFn4SFdsxY92fykkLdE1X2WtCLNTLcoyLxiNQ/Cg1Rd+NXdBZWFzFA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783577576; c=relaxed/relaxed;
	bh=uJ/4SwjyEF8KLZFqi+iXiWhnwewHu2Asrz8+c84E6/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9P+CvJfRgIkzqF/rGi8HIU6qwxKc64Sst7k+xjTjrqCPzC8LyEYZDYW0iGrG+5LPaBElD5KE3j3GJLz5nzjO7Q1fUGS8o2hqftPpBz7wYPcFUkFBmFubNh2xU+jxSrR5/A8GWBj3lBHe/yts1hFkgZ7q79r5cgMULFHKDzlDcfUTwwhb4K3t5w07pa0nq+aB4hz6KdIsPmiifA32ZWx+qrabB22DRHLS4zQC+mwMpYyFULesfKpkIpFGCxZy5u1J7UIdKwXzwzXHaQOlJl6QQYiVVQwRiBWJ1zfVejvL1dt8/7nwYgjg2xTCsHKsObacycI7Hs7zVQVke9zs4eNEQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=MmtQO+Y9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=MmtQO+Y9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwl4j6gXpz3c9w;
	Thu, 09 Jul 2026 16:12:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjwVJIFcpCnyMMHT/zIVnRU9nnMbuZh+E0pITgEYpUHoVzLdSC2jPc4px7AO1CMaMubYTgA3iyqSmtWds4M5nMXNrxWIdft9oDSv0dEcgUTsQ0w8nfdDOVF2vMDt6ZktNGC8+37Flwswhwns6lWqIQadNzNRS/qNUAANfG9oyliQp1OaXBluXc0pqUphYto/4k1goTjOjnImn2vrF9WqQuSspDUu+vGcsYe5BPTWmS+HkVkf35Zt/oB3ThE+VclBWS3PNPkzyDeHUechrhvNXu+pYRWTKnmXITJUv1PclTsDk48siNk3gOdhaXvDhk6NIRQMYahvf5/TYURyE518Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ/4SwjyEF8KLZFqi+iXiWhnwewHu2Asrz8+c84E6/Q=;
 b=Vygcfq2f9GpQER9DPahf00EMgN2MXy+vfDaP3Mt0vjjN7uAnuGAQC8conZ1W52sUzNPpTEUoHCzL4MJKqw9EBWR1flavYtK4W9fYTqf+y/hZRh7uO+guzVwH07N4q8IhjfthEqqGg+rgsPCra3B/jx5siHB1c9QMOdSaKXpcgNNnFBcIAQqU14BgLq3FnxaQ96QfW7D0BpYsyBgK4qXq9ehRcClalnnYlkVazk1Q9d9c42+lNWlM6rvXadTOEqsbHwkgpxgLkh+viErMBLTEVV9iL+c8McI/tWHQApo9Gn4ld/NPzfW/NTWzI5aKqxr2M5KDVAMYRk3hEJu796lWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ/4SwjyEF8KLZFqi+iXiWhnwewHu2Asrz8+c84E6/Q=;
 b=MmtQO+Y97euMICNC6RHWyyAGB9SqastUZobSnPCTKwParmscmPzOu9EKyFZllYmGjlkdlTteC0E/OWUEFNaItNRQaGuqEfIuLLe66rkAwbGMUjcWsU1iXN2Xu5AKWah0aOXiTJ8QviwtNd8CVhlicxZenmBW7yBHTxNhNIeXO4vqZrppr0hnrgaCJA9lrGXnHYvdf10HLXVL03L34nfRfKRXGvRXNLM6F9B5a8Qc8g0VRqUMt/gg5qIcGh/NRZ9YVXHsZlDca/wlIt3XK0f2OG4N69xfmGd8BCuW4UW22550V/bXnzhla8kk4oJ9HRJo0cz7KcQtImhwyT+Zjb2M7A==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:12:29 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2%4]) with mapi id 15.21.0181.012; Thu, 9 Jul 2026
 06:12:29 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: usb: Add Aspeed AST2700 DWC3 controller
Thread-Topic: [PATCH] dt-bindings: usb: Add Aspeed AST2700 DWC3 controller
Thread-Index: AQHdDdeNMVjAGOY5AUKDgoVpX0D44rZjcs0AgAFEywA=
Date: Thu, 9 Jul 2026 06:12:29 +0000
Message-ID:
 <TY2PPF5CB9A1BE6F1C0A7943B0A20EF8D34F2FE2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260707-xhci-v1-1-b202b9b3274e@aspeedtech.com>
 <20260708-crafty-copperhead-of-whirlwind-1d89e9@quoll>
In-Reply-To: <20260708-crafty-copperhead-of-whirlwind-1d89e9@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE3PR06MB8199:EE_
x-ms-office365-filtering-correlation-id: 41ab73d8-02dc-4b5e-4fe6-08dedd810e35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|4143699003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 X+9Dzn4yvKs0p8kQMV78ju3MMqJOYAPnyW3qDyRVkuEgVk9uXMp91N75Fjad7QdiSbi25j0z/9EeG/0cTmUbY9bMXf2Z9l9jbPqoqY6KW8r962J4V3iZIuu98Pi4aSj/C+tXck8qPgPS3bUS6RYUE3rrBwgXu9HIxqWlH4PIC69+aKIQWPqzA8PNYI0/O0yX8s/+199eXhUPSNn5AZLFzaXksVbN/HEhGkFzBCjFC1sKtqeLSOHFvsImT833b9r8bJ+/3mFH27pb1GyWpe6e8mweFZKgyLIX+f5bePoSHo8xSdIT8daliQRuMNoB1JgPd7AGxho4gUP/lR4PjF0QKO7RFJbhbUbi9AiqUxL5n0AusyMPLysJ1u5mrzn94WzqBhrawR8eaoQ5P8yU1BSe4sqW2iBmIwlBZ5zhgj2jMesKbxU+5Hdu64sV/UeXmA/y57yjZ4E/+jZ3uem9AhbZneSHWEPiw/CQh54IKt7Cj9VDERc71h5sx4oRuFhzgJ4+TmvPnGL1yhBf7aQ+CtMXHog0REwtuSwMmgxno1X8S160Vx1u9LDPV21kYW2BQMFaRW7N46Jc8eF9dmUJ7CaoAGErCkGh4Ecmj2KxJpmvsagH92CkKrBE2rnCmKKyn0djfwn9BrhBPq/a4YyeyYfjrHX3XPqFG2MLJcmTCPNPm1y4zQLWCQ5yYmdsgsMt/HRPvmrLnTd4zpxxg4ruFg/HxQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjRlZUkwSUFqZ3E5NnhvbmFjeWs5TWJvOGNobTBIekl2ZjNJYkdoSHNscFJD?=
 =?utf-8?B?ZG1GQU5ORFdRVDI5M21jTGwxUU5qOVJFaXg5WTMxUzR4b2J0RlpOOXVtaitT?=
 =?utf-8?B?eVBnRDF0QXNhRHdvNmlLRHNBNkpEM1pTSkdhSEwyZVdQTnZQWUU3YzJKVUcy?=
 =?utf-8?B?aER0Tm5XU2Y3bS9jVFZWeDg4WDc5VG55VFZDL1QzWlE4OWtRNEgyaXFwRXdP?=
 =?utf-8?B?cW1HeVdnZjJwQ0M3bGtWdExCMDkwOXlEdUtRdDJXVmhZalBiWmVwWGRGbldI?=
 =?utf-8?B?SG5LRjRpbW12dGZpUDdqQW4xdXlIU0hoZlRCRUxkdjN5ZnFwS3BYUTBvTlUw?=
 =?utf-8?B?NVFXOG1GRk12OE95MTBheW5vbkw5OFVWb2lVUlpQdmFBV3FDY0pUamZVWWZX?=
 =?utf-8?B?STl5V2VVWnAxempnWWhHZDVwblVaK0ZiV3RYK0RWbDBvT2FDUEwvdGNaQTEy?=
 =?utf-8?B?RFVqc1FSc1R0S252aEZyTzR5b1pIcU02b3BQcUVLNXJpMlJlL01wN3AzN2wv?=
 =?utf-8?B?S0FxUGVFOURrYXZjcFdhM29valdIbm94N0IxbnpXaXVPbWpLRHFaajlzNHl4?=
 =?utf-8?B?VTlhNVVPNGM5RGpCRGlnZXd0NXZGZXY1VHdnYnBIblZ6Y0ZKZ0JyRVlPWVY4?=
 =?utf-8?B?c01ka2VDVkVnek5oOE1TbE9jTEZOamh3QkJaQUltRlphb0QyTlR5aSt5Ukx2?=
 =?utf-8?B?cVVMTEN0cXNtQjhvbWViTkpBWE11UVF4OHJoZnV4cHR1RW5OaEJvODBKVVd4?=
 =?utf-8?B?L1BYNy93Q3g5cFZBeU14Z1haU1BVUDlobVpjd25tazlNU1JmaEprcGgvQlZP?=
 =?utf-8?B?cEFIQmRBRkYxTWlHZWdxRW1PN29HZ0laNUhzM3N1Uk4wSTF0ZWtJdjFTblZY?=
 =?utf-8?B?TUdHWUZJQk1sNEpyaHB1WVg2OEcxOWVtcW5LUU9UaEZIWVlLSVZ4MEw5dXo5?=
 =?utf-8?B?RkRrZ2tVOTV4YUh1dzFBTGFOK0YyTGV1R3ZVRHRoeTNFb2p0bkllcFU5T2Uz?=
 =?utf-8?B?UThRaGVsWHVya1FJVUF0RVVoSHN1bkplSHpUSTFuUERKTGVzcVpqU1R5NDRL?=
 =?utf-8?B?Q0FWSnR0cnlna1U3VlkwVnV5bWpUSzdNUjBHNU9WbWxNWm1tQm5iaUdRU3Fi?=
 =?utf-8?B?Q1JpM3ltekJ4c09va3c2T0JSNjM1aWxIdzlmRjQ5eFJUR1QxNWdVOUl5a2RW?=
 =?utf-8?B?MjM3UUhtaTVXTlhoL3RaVGhrcEc2ZUVKVnR0MUI2aXI1SkJsR1o1SHVDb1Q2?=
 =?utf-8?B?TUFLYTVuOHlmVnFxUmc3S3JlRlBkemRjWjl4bTI1QXFRRFlSZkdjTCsrSnI3?=
 =?utf-8?B?MG1CUVBweElHbzBkU2xQSzRidk9uVGY4b2FhL0k3RzZ6WEMwVkwwcHBFRmNT?=
 =?utf-8?B?RDNpcUxkNmkyN2F0bk5nQ3NIQ2dPcUUzcDk4YzZsWFJXeDlsRnNRZ3NiWmxx?=
 =?utf-8?B?VlhsTksvall5U3ZaY2dSSTZvakUrZjZGS1RCM1JMMC9qWjdWWjR2WnRRdDFH?=
 =?utf-8?B?amVXY2VWQmErMXV2Z3BqVDh6VDB2SWM1dGpLS1k0dGhDZzZ0MzRONWlHZmNv?=
 =?utf-8?B?WWlKMHRxQzYxQzlVMVFUWTdtWTFNSzJIV082U093UnVGRkNYZlZiWlB6K2x3?=
 =?utf-8?B?dnJEL0Y1N0NzeEhjRHJ6aEVkbGpjQ0VrdW5oR0dUN1pxWFM1ZDF5blJldmJI?=
 =?utf-8?B?aFlmNXMxMHRSYVp0RnRiOFhkTm5FNnRZWUYrVjBlWGNSMEdPc1huWm11eUg1?=
 =?utf-8?B?ZTJxcEJDdDdFMndXcGowaXkzNCtxNGpUQm5NcWErRURqdC9SaGtxRFVIMlNn?=
 =?utf-8?B?RHZJRWFaS01iYm1wUHIwbGpMaHhJWjVXYUV2bmVmVG85QVllZHRNVGRIR0Q2?=
 =?utf-8?B?UXpKZnhBeDlNay9BdDlsZENPN2gyK08wQUppLzhJN05ZOW5vQ3dqYWZHSTZW?=
 =?utf-8?B?aHgxYzBNbmlQVW54U2NtQ0NVd2lkZTMxam5yc0owTjE1NnVuZkZFb1hhY1BH?=
 =?utf-8?B?T1IrbDdoVEdsN0JRdVdNVkU3ekFPdmRwU2ZwNE0wM3ZsN2NSRzB2THpEYXRK?=
 =?utf-8?B?QlY1UEttOWVSVTdKM0lvRnQzdGNXdEljUUxzRFZhNXN2TE1ycnhlZmZ6RTBQ?=
 =?utf-8?B?M2ZBTmlsSUh3ZW1kNTA0K3gxQnU1UWZWUTRXZlpzSXJDamtEUGZGREVyaitC?=
 =?utf-8?B?QmlQU3dwM0VKNDc1d2xiUWFkK1FsM0VvLzdDTGhkeTNqdmdrVWU3cW1HcVRu?=
 =?utf-8?B?b0QzcHQ5NktTSis2UVU5OVdUajBiRS8yK1BET2VyZFVsZmgvQ0NzNFpYZEI5?=
 =?utf-8?B?MmIrUWxpOGdLMkZGWVh4U1h5ZXJFdTh6Uk13Y2Z6eGRZeTFpWHFDQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab73d8-02dc-4b5e-4fe6-08dedd810e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 06:12:29.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGwTeDAVosuXd5rFxAvhFWP4byVkWxwfeWP0rjl8T9w9GUY5VegyPKu87IT+OV5Lnje6kP+gJRCYZeCKm4EfGJ9QVo6JqP11Pl6am4qvPNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8199

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogdXNiOiBBZGQgQXNwZWVkIEFTVDI3
MDAgRFdDMyBjb250cm9sbGVyDQo+IA0KPiBPbiBUdWUsIEp1bCAwNywgMjAyNiBhdCAwMjoxMjow
NFBNICswODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gVGhlIEFzcGVlZCBBU1QyNzAwIFNvQyBp
bnRlZ3JhdGVzIHRoZSBTeW5vcHN5cyBEZXNpZ25XYXJlIFVTQjMgY29yZQ0KPiA+IHdpdGggbm8g
dmVuZG9yIGdsdWUgbG9naWM6IGl0IGlzIGZ1bmN0aW9uYWxseSBjb21wYXRpYmxlIHdpdGgNCj4g
PiBzbnBzLGR3YzMsIHVzZXMgdGhlIHN0YW5kYXJkIERXQzMgY2xvY2tzLCBhbmQgdGhlIG9ubHkg
U29DLXNwZWNpZmljDQo+ID4gcGFydCBpcyBhIFVTQjMgUEhZIHRoYXQgaXMgaGFuZGxlZCBieSBh
IHNlcGFyYXRlIGRyaXZlci4NCj4gPg0KPiA+IEFkZCBhIGRlZGljYXRlZCBiaW5kaW5nIGRvY3Vt
ZW50IHJhdGhlciB0aGFuIGFkZGluZyB0aGUgY29tcGF0aWJsZSBhbmQNCj4gPiBhIGNvbmRpdGlv
bmFsIHRvIHNucHMsZHdjMy55YW1sLiBUaGlzIGZvbGxvd3MgdGhlIGVzdGFibGlzaGVkDQo+ID4g
cGVyLXZlbmRvciBEV0MzIGNvbnZlbnRpb24gKGFwcGxlLGR3YzMueWFtbCwNCj4gPiBzb2Npb25l
eHQsdW5pcGhpZXItZHdjMy55YW1sLCAuLi4pIGFuZCBrZWVwcyB0aGUgQVNUMjcwMC1zcGVjaWZp
Yw0KPiA+IGNvbnN0cmFpbnRzIC0gbm90YWJseSB0aGUgbWFuZGF0b3J5IFVTQjMgUEhZIC0gb3V0
IG9mIHRoZSBnZW5lcmljIHNjaGVtYS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hl
biA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiANCj4gV2h5IGFyZSBjbG9j
a3MgdW5jb25zdHJhaW5lZD8NCj4gDQpUaGV5IHNob3VsZG4ndCBiZSAtIEknbGwgYWRkIHRoZSBj
b25zdHJhaW50cyBpbiB0aGlzIHNjaGVtYToNCg0KICBjbG9ja3M6DQogICAgaXRlbXM6DQogICAg
ICAtIGRlc2NyaXB0aW9uOiBDb250cm9sbGVyIGJ1cyBlYXJseSBjbG9jaw0KICAgICAgLSBkZXNj
cmlwdGlvbjogUEhZIHJlZmVyZW5jZSBjbG9jaw0KICAgICAgLSBkZXNjcmlwdGlvbjogQ29udHJv
bGxlciBzdXNwZW5kIGNsb2NrDQoNCiAgY2xvY2stbmFtZXM6DQogICAgaXRlbXM6DQogICAgICAt
IGNvbnN0OiBidXNfZWFybHkNCiAgICAgIC0gY29uc3Q6IHJlZg0KICAgICAgLSBjb25zdDogc3Vz
cGVuZA0K

