Return-Path: <linux-aspeed+bounces-2109-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C04CA1002
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Sep 2025 00:11:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cG5kS3tqMz300F;
	Tue,  2 Sep 2025 10:11:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756771872;
	cv=pass; b=dcEUeRg40SxTYNA+m6cPBYHKofcLKUHaRGNUxCnK5jEGOoDG9aBMYnfiBF5yXFQPRFUDa79i3EQrAEUEZE1dmGiMdYrcJavFg+eIKCtGwsku9PZVmuicWTY9WC6fKEevBELqo12Lnt8IRvklHL+3jp6QhA2YEDNuaAmphhuE4YCF6IkiHO8vPThcvKPZtSywTIPR/Om/UrlJdBwZskKtZFnFR1Sxud+1YFGPtX3zFymhRy/Rn4tBjuCtfIPmTnEmwHmzEB7AcyeznDBOx1yJNBgX3OmJYVrgl2uInMzKHPspV2LZicJ4Nb9w9MiMikr5vS63czFvEe4Z1tnshHD9rg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756771872; c=relaxed/relaxed;
	bh=UwcwYTeiz2uIw9n2ntZqjpon4IRWaGGA+BhS4QgyBo0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMG3KGljet7D/2JpT9F3TA002FzlKU/lmKVjZMqvptFiVpIxZ4P3uewPhHRu9UejUWlHVLWZ9wpuukuexN3K1ZJ6qsTsy276KQKIKPBn3MgDXBi/HrRfsc4iCSagX1Q11YOLcUL/KYQPDAfFE8W3SaCTS2O3Jm6YeBTScExSZ0yjCyDamz4FgmbKJ6wfDai1FdWrXXqNpujEUZ+bJycseSZe2QO3C9S1k1KvQzY4GygdVQizicUiosSB0CEYLHGClCFxF6GYm1YnY0T9KWd0UApVe2NXs2WrX8WbYhKHtzx6SKVbBYMQjolxe0YAs5xFnJ3WSOaF30Sf9qtBlPxXEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=MRQ4NDBD; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=MRQ4NDBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cG5kM5swKz2ypw
	for <linux-aspeed@lists.ozlabs.org>; Tue,  2 Sep 2025 10:11:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZX2kR/ZVJrZ2bRi7LA7qcZrcCdVChvSoGXoI+SLBbpYLlj91HV5oIsDMujzkvDKGOfLvzCwhwSWmlqmfGQi4tkaxDWKGpbkBAPcYEwxM7WQFLqtRivC2VRkHj1rz0f6qGhn+0gZ8ZV5kfjdY5piSFgGA6wt4tcOjXwCpfVT/sK1edR/g9qxtW0PhyZ7QxkEVg7+bSBdW39Jpe3aapUTgpoKzOwuKO6r6bXFF6IbH3pIimfJKSdqLL15MT/BumogigNwJ1cYsHmA4C/07TuvDPJL+CwAa2Vgy1r38wrgKRJ+wgq8a262A+7Mv03YKGdtBveQwCXbPfja3/+HXmLUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwcwYTeiz2uIw9n2ntZqjpon4IRWaGGA+BhS4QgyBo0=;
 b=QLBsNyl3ES46SMIB14TvOb7jtuOtH/4qM+5JgATmNaKXgrZ1d8VsDBXrTisfTSAxGa4IaJEsrVSwl3NgsgY9pjBdJ6Wq2B8NhEb7Xj3hrAjJykyDU0UQ6oPN0V30DJmivyOw8b0JcY54+1ZhB6NkHzyOeTrHXOlujKBJWc6G5dCyrxL+84RUa27f7HDIZdI1wItOfm1I9eHVZMF0flV56Za+N5W1CwGA8/Y1iskbcUMpNv3RdeH2EIno9/ZpfIQUcrytLEEeTqOM/HISZuRJpxXFLlhOo9+8quifPnGp9YyIJ4Mgzz+eg6fj7HB14yOXb0MUOKoC8+DqOh/ag7VrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwcwYTeiz2uIw9n2ntZqjpon4IRWaGGA+BhS4QgyBo0=;
 b=MRQ4NDBDxcMGCpd4HHfpsiG54YEjopZElAl7vcAr1ylgiFxeZ+B5+Pm0vMv5YVVk+LJrZDIoiiKVVBOouJIAHzQLUsyIavYcMHfit//8FMx2hHFdz3qVGkVUCva5nKwyiEvqHNhEGAWQOyy2n8FmKXIP7KwnfW0pGiAbi/c0JGu2YWBzyNPvU9K/js0f2rygQGJta4inl1AV7PdcXkXBpGucm3HC1wwTOSrA3uxASNiniyWjC6Pgrj/8fWQ7Ucy5pAZ6SjKlr2ErHOquaz5ExILYWA6J2n5+RLQP1sTwBIuqI4Fx1ptkYju5JDBkG6Y3ho4ptuFbpG7IY93vhQWwZw==
Received: from SI6PR06MB7535.apcprd06.prod.outlook.com (2603:1096:4:235::12)
 by SEZPR06MB5391.apcprd06.prod.outlook.com (2603:1096:101:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 00:10:41 +0000
Received: from SI6PR06MB7535.apcprd06.prod.outlook.com
 ([fe80::8af2:b731:a5e5:169f]) by SI6PR06MB7535.apcprd06.prod.outlook.com
 ([fe80::8af2:b731:a5e5:169f%4]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 00:10:41 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>,
	Mo Elbadry <elbadrym@google.com>, Rom Lemarchand <romlem@google.com>, William
 Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>, "spuranik@nvidia.com"
	<spuranik@nvidia.com>
Subject: RE: [PATCH v5 4/5] arm64: dts: aspeed: Add AST2700 Evaluation Board
Thread-Topic: [PATCH v5 4/5] arm64: dts: aspeed: Add AST2700 Evaluation Board
Thread-Index: AQHcGu5dWNF4/+xaEUancT+W9VWj/bR901eAgAEyYMA=
Date: Tue, 2 Sep 2025 00:10:40 +0000
Message-ID:
 <SI6PR06MB7535DDE719CD3F742F28B1B0F206A@SI6PR06MB7535.apcprd06.prod.outlook.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
 <20250901031311.1247805-5-ryan_chen@aspeedtech.com>
 <f80b0de7-6b31-4b1f-b5ba-84e41a42420b@kernel.org>
In-Reply-To: <f80b0de7-6b31-4b1f-b5ba-84e41a42420b@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7535:EE_|SEZPR06MB5391:EE_
x-ms-office365-filtering-correlation-id: c7d8e37d-b83b-40ae-0aea-08dde9b526fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2RtY01oQ3M2bVgrV0p4UDJEVzFBWTIyWHB6N2pvWlBvZ3N4OTFLdGtJYy9S?=
 =?utf-8?B?UnZ5TGJaS0Z6QTMvemU4clJjNldObVVzSGtEblBQUXk0SEw4RW90Tlpkc3R0?=
 =?utf-8?B?UjRJMHEwbDd5NkJOOEZCOGMvL2tmVEVFSjVTNm5mNVlmbkR4NUFOaGt2Rm8v?=
 =?utf-8?B?SUQ0Z1ZZNFhRaEgwQStNbW1xOE5KV1RRMTEra3NEMVRRaWJDbFRUUnl0ZFRF?=
 =?utf-8?B?czJnK3BtMUtaWThQYXJDMkp4Q01xME9KRHlzZzFUSDY2RnE4MVFiK3BoODQ5?=
 =?utf-8?B?bjZmZmtUVnhoVDJlS3NVVVFiUFdPS0kvb1U2NjRhRFBFcU13QThGUzAxaWVP?=
 =?utf-8?B?U0FmSVkxNDNmS1B0ZzloUEZFdlN1WHJTdnFMVW4rNFNNT3RvaUJrdURqZFk5?=
 =?utf-8?B?ajAwZmoyK1FnSldzRTdubFBNTXZvMFFTOUhlOVUvYWNUSHk4b3hqUUwvTjZ0?=
 =?utf-8?B?YllqNEpPOEtSNW5VTGtwNlZ6ZnVYcFFuSTJJdERxL3ZRSGtYUHdNK2syc0FS?=
 =?utf-8?B?aGo4ZEVNeWR4M1NmYm5IMlZMdUFyMTZVdngraU02Ly9pNU5ZMStCTG5zTnFm?=
 =?utf-8?B?RmtkYkRrZ1BqRjk0ZHBjY2VLMytjd3QwNExKVmh0TXIwejQxMlczMENRdVAz?=
 =?utf-8?B?aiswSmtaUmc4MXRlNkZJbXY4dHFtVnAyZHEzSTZ1bFU3L3pYYzBFZURkQnRQ?=
 =?utf-8?B?TjdkdmVHZitIWml3OEdicWo3NUQyRkRpSUVROEgxbC9jOFIyVjJOOG9POEJs?=
 =?utf-8?B?enZlRUEvM2h0QlUzc0cyKy85a3Z5cWI4cUJRZHlYVXYyQUpnMDhnL1ZQS0Uv?=
 =?utf-8?B?NnNsWVF0ZGh1MThjMVJBMzFqUmpyTFJRTEh6bG1BS3lQSXF4aVFWOEhyTEVK?=
 =?utf-8?B?ZEdkQXhRYm00MkFaVU9IdWE0T2ZvWUgzM3FiYVpkVzRMNWNsRDRLbE9iaC9Z?=
 =?utf-8?B?MVpDdHB2b0lQMDMvMkthWXVuVUdRMXJJN0dzWUhuNHpqTnQyNEh3b25WRzNG?=
 =?utf-8?B?anhtRlo1ZUcvNTR1SWpTVUVYZWpEbmZXNE4zRmZTQkJZb2VBeVNpZ3Rpa3NS?=
 =?utf-8?B?VUpLMHpDVHVNNmdsS0pubHVFZTJxNVdiRWVCRTBwSkozYzZwSVBwVG5OdlhK?=
 =?utf-8?B?RDVzcVBncjcyNTNlRklxMTRhYWN2Q3ZsSGpXWmptdGFiN2RQZTlGbWIzUjdp?=
 =?utf-8?B?Z0JMNkdIQnJDVVo3Q1hzOFlPN2dJOFBtS2FacWlZNThNVVZLc1V2T0NqdDMx?=
 =?utf-8?B?N1N4dVRLRnV3L1pkTWJjTCtDV1JRTHI1a3NDQVE2NTNjd3Y0QXBBWC9tRjRB?=
 =?utf-8?B?OExMZHdSRXNZSzVFNGVVSVJGVlNOU1ZreWxmRFEvNW14M0dUSE82NGwweDBF?=
 =?utf-8?B?dVplREw4TUt5UHBNSnR1alZOQm8rcC80Q0FFSDl0MjR6bStnT1RoZ1RNd2dx?=
 =?utf-8?B?M0IvbXZMNHpyQkVGUWdEMWJHVzBkaGpyY0xqU3loaDF2MHk0cCtNcmlvWDY3?=
 =?utf-8?B?UmIwVGRjcjI5S2lSR2ZEck1JS2tNUjJMUkorOCtURGRqT29Qd1VoUVdMc0xr?=
 =?utf-8?B?WnN0WGZxbW9RUkFWWXdIWGlpQ1RCN2FKQXhtYjdLeWQ0NHVnMjNHOUlzQ3VJ?=
 =?utf-8?B?aE5reWtmNXR3R0RBMURDaTFmZW5ncm9iVU1KQm5QdFQ1dlVjS2FZejR3QnV0?=
 =?utf-8?B?UjVlaU1HMzQyczF0WUxyYnU3Y0M2Z2RxRG5xYmV6YVJIRTVuZlZXeDhXT2pj?=
 =?utf-8?B?YUN1QXV4SnQxVW96QW9aVEY5WjVha2p2NmFqU2g5STVMQ2tmOTJtby9uVm02?=
 =?utf-8?B?MXl1dDJNajdtTHpuNm5aRnZ1d3AzUUl4R3lSd3ZJSk9kRzJ5NFhNbE44QkZ0?=
 =?utf-8?B?N0xBeTByaVZMNTBTcStoWjFqVTFmL24vL3ZwQ0Yrd3UyK21MeXdUM3lFbFN5?=
 =?utf-8?B?UXZYSkk3V1J2L0Y4T0llZFgrcy8ycTBhYjVZUTI1Q0RxS2pNWU9uWXhOYk91?=
 =?utf-8?Q?I6TA0C4TLJitDf4Ms8o3QgFaxSYpbM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR06MB7535.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVRtdUxQT3NidXhpOUxTTkZpYS8vZmlmckpKcDFKVUhSQTkzK3RNQ29oZWNh?=
 =?utf-8?B?b2RjUDVubVpsRDVxVWdsZHBhcGxTb0lXVEsvZDlZWWx1OXJSc3JBdlRuMHI3?=
 =?utf-8?B?QVpYQk04UkVPQTZoaDgwY1FjV2VyUjFwVThQb2hsYjVNNGkzRVQyVjIvY3Iv?=
 =?utf-8?B?VkNOMGJnSHZnRUNJbjJQQ2QxZVBIRjVpZG04ZEw5dktDZzV3c2dQTnd4ZVMx?=
 =?utf-8?B?TU84bysvYXRKZWthOEkzOHBaYnFyMUcrOE9OMExUeDN3dnRYWDBDSmpLamFa?=
 =?utf-8?B?SEJmVzJFbkVSNGFMWjZpZTE3N0J1czBKbGVtZ3BxTmJsZm9MNUZLT2FqWWVo?=
 =?utf-8?B?eTdFQWN4OGtLUjV6R1lEMU9uUlloby93N1oxWGFpM1hDbXBYeUhtNjRwaDRq?=
 =?utf-8?B?dmN3Q21sVm5wN1dUeGtvR0dSQW92Qmd0T0dhNFJRemoyTllYSEdoTDhUYUJR?=
 =?utf-8?B?S0ZpcThBMVgxMGoxTDJ5NmVHRElXMGw2SktORi9icU5GYVlDMjVWMHNrUkQ5?=
 =?utf-8?B?cGlFU0RQSjI2QWxkWEZwc0Q2ZytSeW1RTlpGSXpDemd6NEwxdzAwNG9TeU5q?=
 =?utf-8?B?dW1RTndSWWR2c3phNmVkTVNycXRDbVBqL3dTa01oU0NidUREbmR5Sm95VWE0?=
 =?utf-8?B?emN4RHZoK1FPRXdId1psOG5NbnhFSU9jS3BVbFdYem9rTm0zNGJYTUlUQTBV?=
 =?utf-8?B?NFpoeHhGVUppMGJNNjVPazJZcWdkQkZpWVgxYVFlZDdOdGhEcmNFdmJ6RDFO?=
 =?utf-8?B?bDFVb3dBK3lGNjlnaEdiOUlhRWtRT3gvQnhiSzRsRnhiaUpHUTVET29vNGtx?=
 =?utf-8?B?dytGOTFZNWxnUkE4b1o5L2R3dit2ckRBNVVVaG9WVXRqL0NIVlNKbGI1a0l5?=
 =?utf-8?B?K0lsUFV5QWJkYllkekFJRUFJYnRUWkdJRmRqNE1JZHpkcStsOVNZRCsraWVF?=
 =?utf-8?B?VGVsOUJEdUpWSVZYMjZRYTJaMmZ1MDVYUTFPazc5bjV1WGducFdnY0hNVjlE?=
 =?utf-8?B?bWVHbGY5VThCN1JIdVpFVlYwNGhLaGZhczRxQTNYNWFCUGhwWE5rSGtsZ3JO?=
 =?utf-8?B?TlR2QUxjUk1YY291TFhJSXFJbC9IVWRKTlkySXBmTWlaT3k3YzZScUREVE42?=
 =?utf-8?B?ZTVnSC9sUG5IbldUeXRGK0FBZmVrTW8wbEhUMkgzOW1mYlBoYXpPa2RlcVFL?=
 =?utf-8?B?TTBiREc3SHB1TGxEQlBLeFdOemlDK3ZCSlQwOFR0OVpLdDlDb1paQkI3QnQ1?=
 =?utf-8?B?YS8ySFhmZ0E3RCt5U1BoRmhmYkJCbUdSd0RCRzlYZzZDNCtqSUNTTmp1L3FC?=
 =?utf-8?B?MjE3SWpUQjhwR2FTK2E0MEptaUpNSWZWSmRub2FHc3MwQ0Y4N25UVXdWUmxU?=
 =?utf-8?B?ZUQxWjMvdlJtb2FiYk16VXRCWlBRUm5kRllSdDdFRGtJZWFDZnJnNEtOQS9h?=
 =?utf-8?B?MEM1dkNZWVA4RWE4Z0RRWG40YjEwbUFJRVl2azBUc0YxQkNmRTFDajA1aUFR?=
 =?utf-8?B?UEhTMFRKcm9CaEtodnYzV1JnbXRsNTZ0OEVXcFR2MHhTVkVPWmRVY2o0T3gy?=
 =?utf-8?B?dktBSFdTYVA1NWNNZHZLdmk0d2Z0aDRMQUQyejlqckVRSDhQcjZBZFlzUkd4?=
 =?utf-8?B?a2xVWGQ2WmI5YUFwRDQzcW94UnpiU2prc3JZTURwWU85Sk5UeWdKNWQxSkJv?=
 =?utf-8?B?V0hTeXU3UXh5ZU5WT0lGU1VZelpNbDRTVXBCbmpPdmRYSXBBOUVIem5iSlRn?=
 =?utf-8?B?RXU3QmU2cWpBeGx2WjNZVCtlcEJTTzVCZUZvN3hsWTVqOE9laEtDcE56VUsw?=
 =?utf-8?B?Znd4eGc5R3p3b0Yrdy81VG1WdFF6Y0x5SlNtakxPdTIzQll2aEV1TkFMZVFo?=
 =?utf-8?B?eGZOR1J3WFdzYVBpYWpxWHBWNVdyNi9rYmduNnpCMmFxdThQUkFvaWNGN2Mv?=
 =?utf-8?B?YS9PNHhlUkFCUUVtR0h6Skk5Wm9HdERUcHBkMkpXelVVNVJjTTRPT3E1RmRP?=
 =?utf-8?B?YnVmMmEwdkF0QzF3ODRqVlhlVVl3ajFCam5xc056VWZ5UTROd1JOdHZFNURI?=
 =?utf-8?B?NytYY0JYVXVCRTFUUWx2aU1YZktNM2NQanIzQitFK2FvUDI0ZEI0bUc1Zlh2?=
 =?utf-8?Q?xbVwnuvUr80yOIu2h22/FyNA2?=
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
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7535.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d8e37d-b83b-40ae-0aea-08dde9b526fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 00:10:40.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcV+2j6Kk9z7fZNYuveFZWa8RVifq+ZctQiUIBYNkn14DrRr63TuxqVqHB3cvlg/Ub/sfQowaH4wbKfztksImjqmO9MaCp4DAA3cb/ROFB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5391

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvNV0gYXJtNjQ6IGR0czogYXNwZWVkOiBBZGQgQVNU
MjcwMCBFdmFsdWF0aW9uIEJvYXJkDQo+IA0KPiBPbiAwMS8wOS8yMDI1IDA1OjEzLCBSeWFuIENo
ZW4gd3JvdGU6DQo+ID4gQVNQRUVEIEFTVDI3MDAgRVZCIGlzIHByb3RvdHlwZSBkZXZlbG9wbWVu
dCBib2FyZCBiYXNlZCBvbiBBU1QyNzAwDQo+ID4gU09DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgYXJj
aC9hcm02NC9ib290L2R0cy9hc3BlZWQvTWFrZWZpbGUgICAgICAgIHwgIDQgKysrKw0KPiA+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3QyNzAwLWV2Yi5kdHMgfCAyMg0KPiA+ICsrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9NYWtl
ZmlsZQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQv
YXN0MjcwMC1ldmIuZHRzDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9NYWtlZmlsZQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9NYWtlZmlsZSBpbmRleCBiMDg0
NDQwNGVkYTEuLjM3MjllN2Q0ODBkYg0KPiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL01ha2VmaWxlDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9NYWtlZmlsZQ0K
PiA+IEBAIC0zOCwzICszOCw0IEBAIHN1YmRpci15ICs9IHRlc2xhDQo+ID4gIHN1YmRpci15ICs9
IHRpDQo+ID4gIHN1YmRpci15ICs9IHRvc2hpYmENCj4gPiAgc3ViZGlyLXkgKz0geGlsaW54DQo+
ID4gK3N1YmRpci15ICs9IGFzcGVlZA0KPiANCj4gDQo+IE1lc3NlZCBvcmRlci4gV2UgYWxyZWFk
eSBhc2tlZCBpbiBvdGhlciBwYXRjaGVzIHRvIGtlZXAgYWxwaGFiZXRpY2FsIG9yZGVyDQo+IHdo
ZW4gZXh0ZW5kaW5nIGVudHJpZXMuDQo+IA0KU29ycnksIGl0IGlzIG15IHdyb25nLCB3aWxsIHVw
ZGF0ZSBpbiBuZXh0IHBhdGNoLg0KQXBwcmVjaWF0ZSB5b3VyIHJldmlldy4NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

