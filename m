Return-Path: <linux-aspeed+bounces-3513-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B342EDF046
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Feb 2026 05:58:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBPkV1Jfpz2xcB;
	Thu, 12 Feb 2026 16:58:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770875938;
	cv=pass; b=UL6n5uMNZ3DF25rRTRy5fFQeo8smLbJ9BY+vXDKlB2+74g6p1p0Iv7dDLf3o3rgo4FxEffxIfsSqHnMa37wwhYubrTNwNJ8CAwj4c0oPqFrNfv5XJW9+c4nsAzkwu6bP98YA/l1E36lKpMoCepWwsTlmdIL4tE7f9Rr7qb2iNd4L1wshlZTlriR85nr9gvLJ6Q8/5Pie7zfFWjFQ9CopwoTPcp6CD8jXWO0i4dVNF5pLqS2ukiJYLYcNEOQPbN+fW+L6jiNX/gHBG90q0stH1HNO8MryInpvOn1zX3/DP9XtN6lDwTO+BVTwHySOPWU31gPe/dYsD+uq3Ib155ax4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770875938; c=relaxed/relaxed;
	bh=2pnDfF0cssq1rHGu5nKiZSNK9/pCFGmbEG20nVc64Vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dAjl8hVLDNvUEfMDzzlnY3C1BaPxEm4QczTuGMAhFT/8nk8DdXRYCIhS+oHCZosKxLHgA/I7v2BFLm1A+fvLa/IJL3eQhI2/8KIeyO8gKO5ywzFfolWIZZ/ZA3ZnsBLpU59UGXEiZatwI/rY/sLaqwTDjkig99Y/jl1wAcYjNJlsZqubm9ahblx7f0Zb5K5w3r1PW3+OwO+SpkX8rsAhYnGLtZx1SkGvjKOh5Nj4Vw3emN/MhksytqiaUHXQ2GXlEAPNRVp1kH5XOZ1fTcOcWaITAe0ElGVDm3i74zz8XoSK3V7QSBNmwpJZZrwD1hfS1GdSQFTOGz8rMtJtV8I1Dg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=EQXL2Ei5; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=EQXL2Ei5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBPkR6HHpz2xN5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Feb 2026 16:58:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYBCt/oA8NwhGcmAt3gcAeOquqW/A/SK22ZFTKiu6QY8E5xLrd6cPPQefudGfk+AvTvzzz4wPY4C/eT1ZBQfCcJRaiLieTzKRG/EFOs+564bQItcSpuXFn26awpHDWn+4nxAqNxfsrAgbxGRSY2gYCf7Zf2znsUyLsffwChfSUfUpgVPUMnSSUT3FOKf2SkCrTcse4DHhtPsh+WtgLfz3uHKg5pYIlEPB1EMZHVa32Hbyf1pK/iwRxIO+BJ7j80ADsPzfKeKH7tplH8EFFVh6NzkUlIcdSkCfp4kXjB5gNLWT/SmnMd9mz1xmABKHrUnqv1akSt1lMrcbOOk/wxbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pnDfF0cssq1rHGu5nKiZSNK9/pCFGmbEG20nVc64Vk=;
 b=IPnSESgWruh7DkJwxTPsMOvLbwiMPvdYdN6HPaAnTxfy60nMP+d4gJghiZix4QH/T9vsw1ZEbdj+pVZ6E/fkm+vzPUmb8WMxXsPR97N85//Glan20ELoaCUXrIJmR82Gch97Dk7rg47eKE4tcZuvUgB+Io9sYpuUnEMl9i27TUgPL7d2jzjxKMSQ6Kagy46S+HD6nMIE9s8tDh8h3YH0bLt8iA1WhiLVL4e0AdL9V9hfnPcLVRJNwBzK0IDLCDeY3XGkNs6xA3NXndsQ5LFukcsfL6waUYvhyl2GMJmsg18Xbc+SGwKicxomh+UW3oci0GUIa9USGJHY4XYcBlyGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pnDfF0cssq1rHGu5nKiZSNK9/pCFGmbEG20nVc64Vk=;
 b=EQXL2Ei5Hmk3c1xu2MG65baqmb5BKE+2vpTNT9m/LNGJjDNLIrAIV51hA22n4Kuhu3jdX0UJQGnj+1vQF2IyS0y6oqtgm893J/m6PhXrT0u6DbgLyZpQvOl4Ki0NHstmf9fF2z2W3Cux4O+F35cj97kzxEKJG6vg2txDfJxu7d/PI1BXUUGm54+57rLh4Z6Ib3qOvb0jN8to5gEOOc06YlGfeCbHl69FiUwY1uC54oQ98Y8mBwEnL+xQetiLdYax7w9DuzRyCOyB3b0vC0zFaquYTYR91lsi9wglFkHOqHrq8s0h+hAOqVmvaSHXuDf8fbFp5RIfhGcHoApgueTdoQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB6376.apcprd06.prod.outlook.com (2603:1096:101:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 05:58:30 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%7]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 05:58:30 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Jeremy Kerr <jk@codeconstruct.com.au>
Subject: RE: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
Thread-Topic: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
Thread-Index:
 AQHclmW4Koe03evCDkyjHS4Z2TLeNbVzzlsAgAAN8DCAAAJzgIABZmUAgAZLEQCAAwvqwA==
Date: Thu, 12 Feb 2026 05:58:30 +0000
Message-ID:
 <TY2PPF5CB9A1BE6D1632D9A480E7A3E6E86F260A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
		 <20260205-intrepid-vengeful-deer-14e2eb@quoll>
		 <TY2PPF5CB9A1BE69B07F90DFB245FAB735DF299A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
		 <d5e45c9f-f3c7-4289-8991-02bd2c5b9587@kernel.org>
	 <6de719dc84324166ed60bb8ec130cf2c9ef351f5.camel@codeconstruct.com.au>
 <feedc58438adad98f4b2a74a1499b2afa92a5eae.camel@codeconstruct.com.au>
In-Reply-To:
 <feedc58438adad98f4b2a74a1499b2afa92a5eae.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB6376:EE_
x-ms-office365-filtering-correlation-id: 14f1d35e-dc36-4456-3b32-08de69fbbf78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0prRFlWd0s5OGsydzl0QzBMTUJlN0NMc3VRanFFdnNXTFUrakNiWG4rQlgz?=
 =?utf-8?B?VGJtUmdkdWNxUW80MmlsK2owbHlpbzhXbnlqelZzU1o5MEZQN2JaanRlM3JW?=
 =?utf-8?B?eTdud0NlSVNUbUxIeXB1VlFmdkY3ajVGVU9scVBoWEZ6cnNibjY5ajZvcWNr?=
 =?utf-8?B?KzM5aTlCV1RpWS9PcnltcE1OTk5ydEZ2TFQ4aUZjeHRUK25JSkJNUWRwSDlM?=
 =?utf-8?B?RE1wQ0gyM0xJSDRBY0RxNVBvaVNLN0tFbnNTcnJKMVNLNkt5SW5Tb3ZqMDA3?=
 =?utf-8?B?UGhjV0tFV1JMM3JzZzdEQ0w0dW1TbVorMzcvZjMrbUttQloyUitmaVB6ZDRW?=
 =?utf-8?B?S2EzVWZiRUVBb1FqOVFHcU5TZTJabWJXM01VT2FmQnd3bklCRkIwK2JZbGpl?=
 =?utf-8?B?eHN6QlR6Ui82elVUYTA1TVZrSDFBN0kwdXpMUStmKzdST29BYzlTWHo5Q3My?=
 =?utf-8?B?NjBYcnVxcFZET0FVNk8ydkdONDVXK0R6OFhqMEVpY0VLdWZxNmc0cFlSRktN?=
 =?utf-8?B?dW1KWU9oc09sWnRmN3JDUGF0UkNsQWFySFZEOW9TT24yekpTRGoyYS8ra0Fh?=
 =?utf-8?B?eUxqZm9TbEM4N2VLSHVqbE83VkRZMTVLWnRWRVlOM0NESExoQ3UxVTB6K2Ft?=
 =?utf-8?B?ZnFiMFo0QWVsMGV4TENpNFlmWTBhcFFIS3hSYUtPSHdDMTRjeWkrV0oveHRL?=
 =?utf-8?B?aUxseVg3bXBINnRRNXFuSWhXdG10MTd3K0ZyY0g2bHBKMFRiYm5lTSsvakN6?=
 =?utf-8?B?N0dhTWZuSEttdERzR0c0YUxpdGJhekdZTVVoL2RjZDZFcTV0ZytidlVtUkFC?=
 =?utf-8?B?d3dCVDlPaTg3ZVBjUE9oY09VeHhPblA0cUovTk5pL0tEODJjNzFqV0dHdk9J?=
 =?utf-8?B?TjIrYS9ESHhCTXRTZ1dGblpLZWlzektOMkUzMEwzbVNoclUxRXR4aThTakdZ?=
 =?utf-8?B?L0FieEZvTDBpMkhYNGFjN2RKV2pNbHlNRTFiVU1OaFROVG5CcDM0OXQxeVlo?=
 =?utf-8?B?bWwrNlRiVXBWMGdsUERCb3U0ajNjWmFCdFpWQVZRUmtPckxLVUVxcDZlOXFq?=
 =?utf-8?B?L2Nzd203MVlKT0x1T3VPSnJrUkRZdjJpNjVLMFI1WVEzYW1uSEtXYUNKVjR2?=
 =?utf-8?B?ZzdvUS9EckZReHJLMGhyRWszcVBwQ054MXRXSGlkb09KQVRDVnRFbEpKdzdG?=
 =?utf-8?B?M1Y2Z2hqWERwRTh1S1B2MnJaMlRYTjk5V0hTMXFZNktGTHFIUnRmQzIzY3RK?=
 =?utf-8?B?OUkydFQ4QTRYQzFndmtBcVJMUTg4R1ZPQ2pYRVBZOU9GbUhaU1ptRm5xZWRp?=
 =?utf-8?B?U3RVR0cyMXNEaGtoVXd4RjVlZDdiREFvYzB0MElCUk93aC9QQUtRZFhSNXpH?=
 =?utf-8?B?YzZrTjk1NUVRd01WeDBicXJOdkp3bGV0eVcrY0E0a09NWHRJN2NleHdsaFdk?=
 =?utf-8?B?QWVHNHZWNGlpMjUwdEptbnVyS3FCSWdTcWJZSXhNc1JlMm9JMnNYWWZUQm1Y?=
 =?utf-8?B?bFJwZVVYaTJCekNNcVVtUlRQWThzMUgyNWtPZUVyek9BRjBRZGo0Wm0zYlBw?=
 =?utf-8?B?SzU0SVpZLytMUm10TmUvSzFPUzlvWmZqdkV0K1VBR1o3aTFyYnFVV21LZjFM?=
 =?utf-8?B?QkYrYStvcW9iRkFaWEtGcDVUakZyd1JYamlNWlVaaGtKbGRvWldXM0JxWjBR?=
 =?utf-8?B?T3FjeHpTdUQ4dk50VW9FcUV4aXNxa21xVUV4V1ZQSFl6L3ZlSGVlWDh2UUZM?=
 =?utf-8?B?aVdnTXR3VzBIUEJ2S1M0WWJnVGo4REMybXhzSERva3Z0dXkwbGE1ZEdmRGVn?=
 =?utf-8?B?SkVZMHA1K0hDenl5cFBaeDVQbmwrenZNN2plQ1lmeFpVUnZUeWdvK3VPVFZT?=
 =?utf-8?B?SDA3ZGt3YjdmZDRSbWhwWGJQbWRSNTVNcFVKSzdGVEpEa0xSQVkzdi9UK2cv?=
 =?utf-8?B?QTdRR0gwL2kyS1VrMnp6THFPSW5iNG9tUmViaHZGaWxNajFLanBRd0p2VkUv?=
 =?utf-8?B?aHJTdFNpd0dVYnI2b2UwZk9sbWU5Tnp6TittUzBsWFF4UkhkajFWblM2eCs0?=
 =?utf-8?B?RjF1enUzWkR0ODUyN1p1U255ZEJDdDVqZVVSemRMeFMwa2dvY1Exa3F4UFRw?=
 =?utf-8?Q?jhhglHz6x5c84d8g0BBp7ZPkp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnNMWWNPMytodEhtVDlsR21QZVZSdlZITTNOd3ZnaklQQXA1c2xLUXVvcUt3?=
 =?utf-8?B?eTc2amd0bUZmSmJnaEVwc2dDZDB3cndNZFZmVzF3ME1oK0JMUnU1YUxScmhE?=
 =?utf-8?B?TGdTOURxb1VXS2xZWUovcXBYN3BEWWZtSEtxS3FjaFk1V2xwMmwvSDRwZGcr?=
 =?utf-8?B?YTd1cXo3c0Z4eFpxMWYvUk85OWYzMUJnQW0wM0hjNWc0WHdUNFhxUURCWmU4?=
 =?utf-8?B?TkhVUXdSaWNFV0dVT2dreHQvSXFLR0lhNXY1R0VsZ2tLWXBSSm9IcHFPUUVM?=
 =?utf-8?B?RW9WQUtNNHFib091WUx0RCthaVZBMmdSTEVjaVpUUTVjNGxrY1NlcnlQdnZy?=
 =?utf-8?B?Vkc4VFhZMGgzei95U0NQZGdFc2cwb1hPUFVzam5NVVFDeGVUWHpMYmNVakFD?=
 =?utf-8?B?Z2FuQXVJSUlMWlJIcE9zZ2d0bEJOWXVNK3RSb3FCMUREd0VoQlJsYTFyZG51?=
 =?utf-8?B?aURXbnhMR1NxTmNOZHo1bENVVytVM3crOGFjZjRNTi9sZDFNWWtUUW1FM2M5?=
 =?utf-8?B?WWRuMjB0c0xSYUV0SjNySTJnZjVsQm1Mb3M2RWk4b2JWNUdhc0dFZmV1aGhq?=
 =?utf-8?B?WEZBTnJMdXZ0Tkd3aVg5b291L01EQnFBYW9PRi9JR2tUN2IxdDJFS3EvT2sw?=
 =?utf-8?B?M3cwV0JpMURUNFo5eXdLay9QQkdDK3NDZm1RTkZ2REJTUWMxd3VPVnZzWVI3?=
 =?utf-8?B?RkFBRzJRYkhvQ29BQmpSbEwvWFJhMk5tR2NNT2g0dWlZMzlSRGd5NnZwdVpZ?=
 =?utf-8?B?ZUlhNWpWendJSDE2dGF0R2RFbDQrZ0d2dUFLOXdNL09ua1MzeEF0Rmh1Y01z?=
 =?utf-8?B?TWg1NTVVY0krdkczQ0Rrb04zK2hVQnBJMDIwdHc4T09HOGlHRzVoQ1BUQTNI?=
 =?utf-8?B?U1E3dlRvWEh6emxtVmJraUkxZlZEcTlTOG5FbWJmMDc0ekFOVHdGcXJBcE1C?=
 =?utf-8?B?dVBwMzdocnQ0eW12emprUmFZZXp3eEx3eERWWTlNTG9hT3FzYndDcUcrMHhJ?=
 =?utf-8?B?Qm9hSEZaeFBJWlU4TktOcVovbEsrc011RjlvYUhwNHF5RWk2THJWeVN2dzlX?=
 =?utf-8?B?dHFLV1lyTlJHZUQyODN6akQrWnVzRWFKdVFYZklEQ3JMdE9LUkVxc0lJb3dY?=
 =?utf-8?B?Rk5lYk5BVGlNYklhQTVEaDQ1SHBoaWRiNTd6eS9iMlhvdDhRbnljcTB2S1I4?=
 =?utf-8?B?M1FJS21Ja2FaM2tyRVBjc2w3U2xKcHZwRU52WkRyK0ZEd3FVV1EwRzl6ZGRz?=
 =?utf-8?B?ZldCbi9rSGRaaDZVOUxhZzBWTkFQV2s5WHcwcGp5YnRnd2pnUVlaQXg3MzNp?=
 =?utf-8?B?RndsQUo2VWJZWEdqM241b0hiUnJzbmJnQm42VDlnbkRXZENONnh3R3NDV3Ru?=
 =?utf-8?B?eWxzVGpUbGg4TlhmRjYrQUo2VEtLZGk3Q0NXMnVRSTRHZUhCUzhWd3NoWnB6?=
 =?utf-8?B?S1ZFcU9FYXFYTzJ2NkFzNFdkNCtBUTZ2UzFFWTloS1B6YXg2NjB4UWtONk5T?=
 =?utf-8?B?M29hajVzYjVUeGsvRW9HNmQzZS9ob3psQXZOd0dXTTRvTDhocWtPeXJ4eUZ4?=
 =?utf-8?B?Rk41NmNBZkgrbTh5ZDRlZDlsRjkyN2ZZVW12bk5kblErRkQvQWpiTjNiRnVX?=
 =?utf-8?B?Nm5xUEhvNWNCcnJacTh6d1VMNVZ6MzhYZThNT01VZEVEV01GZndGTU8vOVZC?=
 =?utf-8?B?TjZPR2pXdVRyRy9VMzI0QmhMNldsMVluc2dha3VONlF5SEozVGJObCthSTQy?=
 =?utf-8?B?UGRoOUJmaHJqVFUrczVwRkdkeGdLdlVIclJZVWZPSDE2NnJnbElpREUzN2RU?=
 =?utf-8?B?bWlzMFFLRFRMVFV5L2RWYWdZZkpMUW9yYVdib0tkaEVTUktFOVJ5cS9PSEtZ?=
 =?utf-8?B?UXNsYmEzOHM1a0R1Qmk2NFlvdWVBU0Vja21aNHRiZVhJZE9KMENobEl5ZjA5?=
 =?utf-8?B?M05XRllUYmhCL2FlRVljR1JKUTNvcnBkeTdEb0V0c2JyVTFCaFVwcm53aTB4?=
 =?utf-8?B?WndkaDRoSXBtRi9xMEhZd2NYOW80YW4xMDRTKy9tK0xBMllneUVVSU1EUUFq?=
 =?utf-8?B?RWlmSHgrdkExQjJBWEJydTM5ZW92VFFmSXhBSjAyNmZMQ2M5SHdSZlJwbWRD?=
 =?utf-8?B?Z2RRUytYVjM2QmJGOW5vNngycHNoYy9STlI3NzkxZ2JQN0xsZHpCNUlLWjJO?=
 =?utf-8?B?L1VpWk1LWlZCSkNDWEErcm9MOTVSTmJxN1JRakt2RG1UaEhLYnpac1JybmR2?=
 =?utf-8?B?QThRUG92aVZuK3k1ZUw5dThNU2RONkY3N1lITTRjNGlRTGpuTkFqMzc2SVQ3?=
 =?utf-8?B?NUdXUHUrWHFIeXNUQVhQaDVlYnMyZXFoWUFMODd1VHF5WUlQWHpyZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f1d35e-dc36-4456-3b32-08de69fbbf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 05:58:30.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTwuq9bBw561+RJr10CHYDqIvKPzmF4jWbrBCf2tGXgu6yBbfrfIU8uEAAm7jwSplEgDa4yWppkj6IvCNgRBrSQRxikbUMLJ4iX8AWKcxFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6376

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNF0gQWRkIEFTVDI3MDAgSU5UQzAvSU5UQzEgc3VwcG9y
dA0KPiANCj4gSGkgS3J6eXN6dG9mLA0KPiANCj4gT24gRnJpLCAyMDI2LTAyLTA2IGF0IDE3OjQ5
ICsxMDMwLCBBbmRyZXcgSmVmZmVyeSB3cm90ZToNCj4gPiBJcyBpdCBhY2NlcHRhYmxlIGlmIHdl
IHRha2UgdGhlIGZvbGxvd2luZyBhY3Rpb25zOg0KPiA+DQo+ID4gwqDCoCAxLiBEbyBzb21lIGI0
IG1hZ2ljIHRvIHRyYW5zcGxhbnQgdGhpcyBzZXJpZXMgYmFjayBvbnRvIFsxXQ0KPiA+IMKgwqAg
Mi4gU2VuZCBhIGZvbGxvdyB1cCByZXZpc2lvbiB3aXRoIGEgbGluayB0byB0aGlzIGRpc2N1c3Np
b24gaW4gdGhlDQo+ID4gwqDCoMKgwqDCoCBjb3ZlciBsZXR0ZXINCj4gDQo+IEZvbGxvd2luZyB1
cCBteSBvd24gcG9zdCwgSSBkb24ndCB0aGluayB3ZSBzaG91bGQgYXR0ZW1wdCBzdWNoIGdyYWZ0
aW5nLiBbMV0NCj4gcmVmZXJlbmNlcyB2NC4gdjQgd2FzIHN1cGVyc2VkZWQgYnkgdjYgYXQgWzJd
LCB3aGljaCB3YXMgbWVyZ2VkLg0KPiANCj4gQmVjYXVzZSBvZiB0aGF0IG1lcmdlLCBzZXBhcmF0
aW5nIHRoaXMgcHJvcG9zYWwgaW50byBhIG5ldyBzZXJpZXMgc2VlbXMNCj4gd2FycmFudGVkLCBi
dXQgaGFzIHRoZSBkb3duc2lkZSBvZiBtYWtpbmcgaXQgZGlmZmljdWx0IHRvIGNvbXBhcmUgdG8g
djQgb2YgdGhhdA0KPiBlYXJsaWVyIHNlcmllcy4NCj4gDQo+IEkgaGF2ZSBnb25lIHRocm91Z2gg
ZWFjaCBvZiB5b3VyIGZlZWRiYWNrIGl0ZW1zIGZyb20gdGhlIGVhcmxpZXIgc2VyaWVzIHRvDQo+
IGNvbnNpZGVyIHJlY3VycmluZyBpc3N1ZXMuIERlZmluaW5nIGEgbmV3IGJpbmRpbmcgaXMgdW5m
b3J0dW5hdGUgYnV0IGl0cw0KPiBhZGRpdGlvbiBzaWRlLXN0ZXBzIGFuIEFCSSBicmVhayAtIHBl
cmhhcHMgcmF0aGVyIHRoYW4gcmVtb3ZlIHRoZSBleGlzdGluZw0KPiBiaW5kaW5nIHdlIGNhbiBk
ZXByZWNhdGUgaXQsIGFuZCBrZWVwIHRoZSBhc3NvY2lhdGVkIGRyaXZlciAoYXNzdW1pbmcgdGhp
cw0KPiBpc24ndCBvdmVya2lsbCwgZ2l2ZW4gdGhlcmUgYXJlIG5vIGluLXRyZWUgdXNlcnMpLg0K
PiBPdGhlcndpc2UgaXQgbG9va3MgdG8gbWUgbGlrZSB0aGUgcHJvcG9zYWwgaGFzIGNvbmNlcm5z
IGNvdmVyZWQsIGJ1dCBsZXQgbWUNCj4ga25vdyBpZiBub3QuDQo+IA0KPiBBbmRyZXcNCj4gDQo+
IFsxXToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzFhMmNhNzg3NDZlMDBjMmVjNGJm
YzI5NTNhODk3YzQ4Mzc2ZWQzNmYuY2FtDQo+IGVsQGNvZGVjb25zdHJ1Y3QuY29tLmF1Lw0KPiBb
Ml06DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MTAzMDA2MDE1NS4yMzQyNjA0
LTEtcnlhbl9jaGVuQGFzcGVlZHRlYw0KPiBoLmNvbS8NCg0KSGkgS3J6eXN6dG9mLA0KDQogICAg
Rmlyc3Qgb2YgYWxsLCBJIHdvdWxkIGxpa2UgdG8gc2luY2VyZWx5IGFwb2xvZ2l6ZSBmb3IgdGhl
IGNvbmZ1c2lvbiBhbmQgZXh0cmEgYnVyZGVuLg0KICAgIEkgcmVjb2duaXplIHRoYXQgSSBkaWQg
bm90IGZvbGxvdyB0aGUgdXBzdHJlYW0gcmV2aWV3IHByb2Nlc3MgY2FyZWZ1bGx5IGVub3VnaCwN
CiAgICB3aGljaCBtYWRlIHRoZSBzZXJpZXMgaGFyZGVyIHRvIHJldmlldy4NCiAgICBJIGFtIG5v
dyB3b3JraW5nIHdpdGggb3RoZXJzIHRvIGNhdGNoIHByb2JsZW1zIGJlZm9yZSBzZW5kaW5nIGNo
YW5nZXMgdG8gdGhlIGxpc3RzDQogICAgYW5kIGFsaWduIHdpdGggdGhlIGNvbW11bml0eSdzIGV4
cGVjdGF0aW9ucy4NCg0KICAgIEdvaW5nIGZvcndhcmQsIGJlZm9yZSBzZW5kaW5nIGEgbmV3IHJl
dmlzaW9uLCBJIHdpbGwgZW5zdXJlIHRoYXQ6DQoNCiAgICAqIEFsbCByZXZpZXcgZmVlZGJhY2sg
aXMgYWRkcmVzc2VkIGV4cGxpY2l0bHksDQogICAgIGVpdGhlciB0aHJvdWdoIGNvbmNyZXRlIGNo
YW5nZXMgb3IgZm9sbG93LXVwIGRpc2N1c3Npb24gdGhhdCByZXNvbHZlcyB0aGUgY29uY2Vybi4N
CiAgICAqIFRoZSBzZXJpZXMgcmVtYWlucyBzdHJ1Y3R1cmVkIGFuZCB0cmFjZWFibGUgdXNpbmcg
YjQuDQogICAgKiBSZWxldmFudCB0ZXN0cyBhcmUgcnVuIGFuZCB3YXJuaW5ncy9lcnJvcnMgYXJl
IGFkZHJlc3NlZCBwcmlvciB0byBwb3N0aW5nLg0KICAgICogQSBjbGVhcmVyIGludGVybmFsIGNo
ZWNrbGlzdCBpcyBmb2xsb3dlZCBiZWZvcmUgc3VibWlzc2lvbi4NCg0KICAgIFRoZSBjdXJyZW50
IHN1YmplY3QgbGluZSBtYXkgaGF2ZSBtYWRlIGl0IGhhcmRlciB0byByZWxhdGUgdGhpcyBzZXJp
ZXMgdG8gdGhlIHByZXZpb3VzIGRpc2N1c3Npb246DQogICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjUwODE0LWF1c3BpY2lvdXMtdGh1bmRlcmluZy1qYXliaXJkLWI3NmY0ZkBrdW9r
YS8NCg0KICAgIFRvIGltcHJvdmUgY2xhcml0eSBhbmQgY29uc2lzdGVuY3kgYWNyb3NzIHJldmlz
aW9ucywNCiAgICBJIHdpbGwgdXBkYXRlIHRoZSBzdWJqZWN0IGZvciB0aGlzIHNlcmllcyB0bzoN
Cg0KICAgICJBU1QyNzAwIGludGVycnVwdCBjb250cm9sbGVyIGhpZXJhcmNoeSBhbmQgcm91dGUg
c3VwcG9ydCINCg0KICAgIElmIHlvdSBzdGlsbCBzZWUgcHJvY2VzcyBpc3N1ZXMsIHBsZWFzZSBs
ZXQgbWUga25vdy4gSSB3aWxsIGNvcnJlY3QgdGhlbS4NCg0KQmVzdCByZWdhcmRzLA0KUnlhbg0K

