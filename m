Return-Path: <linux-aspeed+bounces-2607-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C459CCD1BF
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Oct 2025 20:24:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctZB60Gpyz30MY;
	Sat, 25 Oct 2025 07:24:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20b::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761337453;
	cv=pass; b=ISrXNZX5DzKFi11rhCb9b81yhZHeAc8InR4tj6voInZVRW9XQbdWF3M4efpC30fdvchZ1kSrTkxy+MuNziLCv+D/svhGlhItY1K2M05xzeRY4sPy3orbKZti+1zc+JBLhYth+WGJyEVcFI8E3KWn5RzhXcMtuL64Xqj8Ft5VuAnk6DuHKo6ZotPzD4f994ZGQM/+uvjji7OfMxGHXt0VX9977iluTGTNlNAjfd3UvwdtSB0hiF0+YuyuqpYE7bQV/BfzbGIyerDqVlZNjntton3EiS1Ma5yrDi2hzrTfo3EL1yUm3o2GKAMXqQmKl41mQPJCQzMCO7Uap2JmcY7hAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761337453; c=relaxed/relaxed;
	bh=da/vp8eeliiDiGabUSBWs64bDnYuD0tVtkwkLUeNOiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mW5dvXE+3IsxxDt1prAa46WIw4VzXwc6HVSVlvkgTuaVbbgqQIiAqVHCx8cgYwYgw8z8Nm1UypRlwMEX+Ll+125GpWNQMlJ4t6LtlK0WvPMDP2NPzo/1n0JPOIpDyhg37GRxIF9cdd+jEHt3t5IbwigRJfTLByHNVaPjjGdSoKQ1cgdPyA+UUMLqSFJBiMz4Za9sA+agnJuKIUQAXCMEC/AyFEaxtvIXWfUMFRE2npcZGlRSgOZ6/YAwZ6wcne0sOVNh9+LDw/UT3eXhkIRKTbjMV4lgRRk/CGumixb43cuEPtEdvw0DjJbIf19blW/oQeRRNGZ8uNg1titMrBZ4Yg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20b::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctZB51Fr7z2yGx
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Oct 2025 07:24:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVGl4ckwl8Qk0Nuvy7azByeWffTKC2WTLeKWt93LkVSeoR0RpaNIbR9XjhVCt7O0w23hBERlArNU3aw+TBXHwp04Ifc+YyCcHAN6TrjGNunVHS4i8UZLqS+lvFezv/WQip66l1zlb7pbLRf4pICpipm4XF1wU4DjGxk6PRBujF7/50NznlSeLyZiMiO85JXSl+n3ADh4OX9SUgMr8aH29nmutOIFC4wS2Bkg/nb2NycxGbApmFg/oWOhUWJbPZCN3gML0eb1lJk7rAEg9KzxGjPfyyjVHxIBhjlIJ86k6aQRsoUIJs4zlcfZ7rMSEhSsZ60lwbemFXq9GQv7p/EoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da/vp8eeliiDiGabUSBWs64bDnYuD0tVtkwkLUeNOiQ=;
 b=fRapUk07fhFV9NrRLmLcYRm3ZWMtMziv/6ISuB8xHuXD3LePAcFU8gBe/esxo58/D8O+iogroQ2wMeafc9SQyika378LPIOnEBk+oY+VOdGeegdR9k4DEZST8P6dTVtu7HKCpKbpDdkuIBdpAzNWrjavxAICOdLai0JHu/ZfNWvAHKpI591RwCmpVonMqIMJtqR5rkeZf4iihEDnvQGR9V3/ehab2wX5GuZYOujrZg59dEroLbozdr16WsewRibCavI7r08geY9BnjziKZghUusR8c0PbqeliMFFLNws3wuq2W3m8vVmIcKB2+qb8mL/sm8y26zA4l2TtgjHc2gJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR4P281MB4104.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 20:23:47 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9%8]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:23:47 +0000
Message-ID: <5f596af8-950c-41aa-a7df-3a62339392ce@siewert.io>
Date: Fri, 24 Oct 2025 22:23:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Content-Language: en-GB
To: Zev Weiss <zev@bewilderbeest.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251011112124.17588-1-tan@siewert.io>
 <20251011112124.17588-3-tan@siewert.io>
 <c6ee0814-1d36-45b5-8598-2a30efeee5a5@hatter.bewilderbeest.net>
From: Tan Siewert <tan@siewert.io>
Autocrypt: addr=tan@siewert.io; keydata=
 xjMEXY4MwBYJKwYBBAHaRw8BAQdAdDPxHO4UUyhKcZXkztTv4iVAbjk/+F8ayCYnegO4q4zN
 HFRhbiBTaWV3ZXJ0IDx0YW5Ac2lld2VydC5pbz7ClAQTFgoAPBYhBJ1bd8XzFb0F9Kx5LnjQ
 kBYSrhG1BQJnqiY3AhsDBQkSJuqzBAsJCAcEFQoJCAUWAgMBAAIeBQIXgAAKCRB40JAWEq4R
 tbtDAQDyPybWLk2EYMeY+vv/WID8hk18+jp3fZCNp9aJp9GkJwD9GeQNvCO1LPDUjkMQqf8d
 DgMM9pmsvbJUFfViYbflbQ7OOARdjgzAEgorBgEEAZdVAQUBAQdAjtzTYeMaO9yG3M1uBtQy
 JB57UJXf+m+mNDhWkOY69DADAQgHwn4EGBYKACYCGwwWIQSdW3fF8xW9BfSseS540JAWEq4R
 tQUCZk72AwUJEibqwwAKCRB40JAWEq4RtUkGAP0R8RmddZqdGdqdod1MkVXpw/z5OOptToXf
 za1W8nsGmgEA5gvQzkN1LJ8oP9LB8YGAmJt82tPvJCmi4WzesI53kQY=
In-Reply-To: <c6ee0814-1d36-45b5-8598-2a30efeee5a5@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::17) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR4P281MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 900da838-e037-427b-537e-08de133b3c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVKTlpCODljNmpSblVOZmdycGgwZjFyc2dQTVFpOVp3UGpKanRvU0o0dFhS?=
 =?utf-8?B?Tk5UblBKV0lzeVBLUk5taFFpYmZ5ZlJPWU1ZSmFxVUc2L1FDUitMVkdzZmly?=
 =?utf-8?B?NldMSU10Tkt5VDc3VVhsTk9kOWRzbXdCRnBsdGtlUmZUQkkyTVI0SVkyOWsx?=
 =?utf-8?B?VkdTYTBLa0ttSi9CWHdqS0J0L1g2QUU5U2dCMFYzQUR5d1NxbysraElBQjF6?=
 =?utf-8?B?Y20yRlF0YTlTdTVnT24xYit2UGpjczdLWEd3eWhESFh6WitjZkV2dTJaRXRn?=
 =?utf-8?B?VkFKa1VLMmVmeWZOOXp0QU1NTExRSzlvVWRUelFrNnlzSEFISDdDVHUrOHVB?=
 =?utf-8?B?Skh3QXRXS09yVVJXQ2JRWG5RTTZycm16M3d6UXZmYkFUTVl0WktYc09COHJm?=
 =?utf-8?B?alM1dEFHa3V2L00vWkYyV2psRjZad3Fwa2FKdmhrRWRySTZFK3VWRDZZTzY0?=
 =?utf-8?B?MDc0by9GVDU0NUprYnBFTlJUTE9saEhEdTExTVRORmlhU3N2UmRHbVJzVnpo?=
 =?utf-8?B?OW52dEpYemRLa0RXdUhydTVZcXoxc1JwaFVCUFVaMm40R3BqQWpDdVhNSVVB?=
 =?utf-8?B?UTNvbWxMK2pjd2VQeDkwVEo0eXRXYzA1N3pDTHJ6OWFlZ3pDVS8yK3pIZkk2?=
 =?utf-8?B?cjczTXpIR3VMY1lvamN0NGlCRndlYm5mU3BCQXpGdUVuRUFlV1pSUlJYbVpD?=
 =?utf-8?B?N1M3VXMrVzRTcldEZnlhcVZSN3NsSGsraDFRNnVzRGpYM1Q4M2hhK1Y0ZXJF?=
 =?utf-8?B?elFHajI2MEYzNEo3LzNydER6eU1pbGh4MFJiRmwvbGt2VC9PTksrTWlmZ2Ez?=
 =?utf-8?B?Y1R4SFVieHY4eU5OdDdmbm1uaDlvcHJ0RDUrdHR4VzYrdnpVNzF4QlVmTCsz?=
 =?utf-8?B?YUQ1MTJWNDZERE45by8wNGsyZUNvVW1HdU50M3AwdmZnZUExTDRSMnc3TVRv?=
 =?utf-8?B?VjBPY3l0TFJjZVFWM2s1N3lJanRCbzJFR2RkdEw5bU80UmVUYTZYbnZUN3dY?=
 =?utf-8?B?bEoxejVlaHdOeVNNMWZJMDZ6eTNCWUZDWm1wbytsMmFRLzc5NmxiWHFCVkpj?=
 =?utf-8?B?TVAxOUpaVzBWcmNTc0ZDOGh5d2FPdVdpOXNGZWVZM2VuR1JsOHZadkNVSUVy?=
 =?utf-8?B?WGZISEM0VzlrVkY0R2s2Q293WUFxSkxQN1NVWEVHeEV0V2U5SW43MFVkdUJX?=
 =?utf-8?B?alFMaC9ISGJYa3JHOE5LcmtLZDRTNVUyVTQvQzFnd0UwN2xqdVJtaUlXNnV0?=
 =?utf-8?B?SVVaMDNBUzlZUlFZaVZYZC80c0VSKytaMHpKOXBMeGVjTEtIcFB3YkpHTThG?=
 =?utf-8?B?SUJmSFE3UTFmdHVveFNWWGVaMG5CZFlRTStsS0xOU3FoSXZrN3lhQ05BRmdr?=
 =?utf-8?B?R1pUa3FReFJHdStJMVdpVXpTRlJBbFM0eFFRZllrc1VhTVRBWHJ6WjBDMElu?=
 =?utf-8?B?NWFQRytDNkdSaTVzWjlTSHozTVhXT3gvbkd5RmowWU5Uc3VkaW56TEwxQllD?=
 =?utf-8?B?R0JVWSsvMTJpaUNWQm9RdmtCNjllYThySVEwdmQrSzNqa1BtOHNwK3JIUVpt?=
 =?utf-8?B?UmRGWkRMemlNSFNhZGs0Mm90cjc3Sld3VkRYQ0J3UllzSXkvbXA4bUJOTkxj?=
 =?utf-8?B?SGgxam1LTnZGQzgxMC9CUFJBcVlwQlhiSVcreVRJUFZjSzd5T2g1NDlxZXpS?=
 =?utf-8?B?WHQ0WjIzMTVpMHNQaVB6MlhTUTc3akhISElKVW5UK1NyZXQ0SWltWXZ3RkhS?=
 =?utf-8?B?VVVtSHpBK1d2bjRzcE9TMHFDSC9mTmFEN3VjTWg5d1E0TmVPakJvL25nYjZF?=
 =?utf-8?B?a0RCVDBKMy9JbWVVUkJhUDRvdGhIMU01MHdSLzRMSTh3bTNsZS9qRmpXa2VN?=
 =?utf-8?B?SDJaRFZQejI4U0dCMm53algrTlRkcXNld3pqNTFSSDZNdGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjQ5aXVQQTBsNzlkUDlVL3R3Qm1LTlVkclhBTTFiRjBSL0ZFNng5T0NWWkdT?=
 =?utf-8?B?U1IwZnBJdjZ2Yy91VGJXRXNhMXUwWVBaMGhmVFQxZjFqdzNBSndZRlFUcVFO?=
 =?utf-8?B?U3EyNy9hdE1rNEpuaEczQUoramVETklORFlWS0g2Tm5WbXgwYjlSdTdDMW1w?=
 =?utf-8?B?ek9jZkNEdUIrQ0hnalZwcWIxb2RYd0FDOTVUbWVXWElXem81ZFg1ai9qb1JO?=
 =?utf-8?B?TU9DQUxLOGQ0a2ZEeUEzLzJlNEQ0OElWS3NvSnBORkNXK3BSVGQwMnR0OXdU?=
 =?utf-8?B?Q2dXOXFmaFZsK3RMaEppZC85OUJoZUFWWnExQmx3VzRGYVUyOENtMnVLRitU?=
 =?utf-8?B?T1pjdFVPVUo3M1BBOEpQYmQ2QkhJZytYVk9HSjRJaWVCTTJBZkJLTXp6V253?=
 =?utf-8?B?aUN5WFpwMkVOcjdZaWNSZldHZVBlTXlJQklRM1ArZmh3M0tOVnllTDAvTyt0?=
 =?utf-8?B?QXlvYWJRNXFlTkQ4Z2gyNGk3eE5mV0l1MTVTVHZxcWFXTWpqYTkxREZ2dGJz?=
 =?utf-8?B?ZXZqYXdCZGpDRGRyaHowWVFCRndQdDI5aTVVUzFGM2NIWFN4aWROVDJyVHBz?=
 =?utf-8?B?RDZiSU4wYVRkRkJBY0FiSmhkd1hCMFMyUjdtYUdlU1psWXJQeGI0YkNXK1hS?=
 =?utf-8?B?emtOQ3paN3h1ZWJLK3V6a2FRRnZyN3NOdHlqUEs3SzdBK3VpNVhUWktnR0dI?=
 =?utf-8?B?QWlZMFBRK3ZaNHJ5ZmxLZ1B4ZWFmc3lIbFN0RXB0VUVCUStnRnFzQnlGRTlk?=
 =?utf-8?B?N1NORFRHWDkyWmcxYU5FYVpRcVROL1p3OTN3SnlGY3VrcUdYSFhjT2lnSjRW?=
 =?utf-8?B?T1NsbmtuUnJnZ3BhVndTUC9KNGY1SHR2MWVZRzlKeEt0Z3EyTHFuZThGTlE0?=
 =?utf-8?B?QkdwTEVoZ2QyZXZjSEkwU3NKcW5tL1dPRTh1c3NCbHJxbEc2SmxsdWZYajdB?=
 =?utf-8?B?WUljNzJ0TU5DMmMxOFgwNkphVnBxMFFSZlllREtqTk5wZDEzZnVza0xQN2hu?=
 =?utf-8?B?eGF4ZkN0cXcvb1ZlZ3F2TFF2SHJLR2VJWWtTQjVyNU1ydCtBZHpkK0NiMkZw?=
 =?utf-8?B?emhaZEdPYWx1R2p1aXNPaG5OZVdMK0Z3QlF6eDR1YjhMRXpiWmQvTm4yalZJ?=
 =?utf-8?B?dkhHb2lhWHB3Y09hMWs0WmRiSlJlME5EeVlkOWdEVlJ1L3NTM2pMRmF4Vzlj?=
 =?utf-8?B?a3ZjWUIwUkJ4bGxOQm5rT0NKS1pQcFgrbXliYW1KM29kTzhMYzhIc2JLNW1O?=
 =?utf-8?B?b1dVSS83K1VVUnY5Yk05QjFGMnVpdTFtTE15QUNjb2N6L05EanZPTXpTNFl5?=
 =?utf-8?B?TDlzSTdERFpaNmJYaVRuNVFDTk9oWEs3UUhWWWJ5Z2daRTYzSzUzdVJDSnE1?=
 =?utf-8?B?OHBLZmN1UWZNM3d1TnpGcG5BaEV3NTB6OWRyTXdhbDZ3NWVaaG9rM3lxZHpY?=
 =?utf-8?B?U3d3V0w5bzg4bEF5bGVkVlR3QzdKQWhtSUczU1BocGdReXlSRnBYQkVkcEtM?=
 =?utf-8?B?OHFOZmpnN2tEZXppU2NzcjdQQ1JwS1dnNE5uNUtpdmcrUm9RQTZCUmxqbnQ0?=
 =?utf-8?B?eGhyY0dxYms0M0h6RWpjRDhlNmdJd0lhc3cvZmxwc3hRZzJnY2FqVUNkR3Jh?=
 =?utf-8?B?L3JBK3BUTktkdG9kSW5EekhxVlpVckJDRmt4SzhjOXhWdnpFNkt4NDdjNkFF?=
 =?utf-8?B?Z0JqOWFaanBQVWZ6N2IweERBRnZjamRzcVRncjFIWlJiWTBEMGg3c2VFS1lC?=
 =?utf-8?B?Rk90WFpXZmlaYnQvc2pmbE9mZWtySGdUYlVaZjQrTXZJRlBZbDdkZTJ4bnVZ?=
 =?utf-8?B?Ty9pWWhvditFWjFOQXljOHBvZVB2by95Ukx1ajRxY3dGZER6SEdZTHR6Nm94?=
 =?utf-8?B?WUdRZFVLZGptSHBYTHBQZFMvSEV3cXdaUnA4M3BkOXEwZ2Zsc2liV1gwTFpS?=
 =?utf-8?B?aWphMGo0RHlva0xtaGd4SW5kdURkaG9EV1k2ckxNS0tQMVVkQ3IwREZWWEND?=
 =?utf-8?B?N1ZmQXQ1b2tkVTBxZWdwMG5ZYVpzS0FlK21TM3JYN091ODBMS05qUlZURWF0?=
 =?utf-8?B?OG9EMmZxSy9nUW1oOXZzNm1hZ24rRTZPZzBhRVA4MmZpd1h5VTVkOVMybWow?=
 =?utf-8?Q?dhNs=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 900da838-e037-427b-537e-08de133b3c8d
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:23:47.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbKmPrMvTDFG5Im7+++X4raSvI3efvj/Y8KNgWh6q2Pdy7Z6X4y/O9Wf6xQvfYa5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4104

On 20.10.25 11:40, Zev Weiss wrote:
> On Sat, Oct 11, 2025 at 04:21:20AM PDT, Tan Siewert wrote:
>> The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
>> motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
>> 64MB SPI flash.
>>
>> This mainboard exists in three known "flavors" which only differ in the
>> used host NIC, the BMC SPI size and some parts that may be un-populated.
>>
>> To keep the complexity low with the BMC SPI, use the 32MB layout
>> regardless of the used SPI or mainboard flavor.

*snip*

> Hmm -- I can see the simplicity argument, but it seems a bit of a shame 
> to let the other 32MB go to waste on boards with 64MB chips (especially 
> given how tight a fit OpenBMC is getting in 32MB these days).

Agreed.

> Could we maybe have an aspeed-bmc-asrock-x470d4u-64.dts alongside this 
> one that #includes it and then drops in the 64M layout over the default 
> 32?  You could then arrange for a flag in the OpenBMC bitbake recipes to 
> opt in to using that dts if you want to.

I implemented this idea in one of my first drafts [1], but there were 
questions on the OpenBMC Discord if the additional 32MB of space are 
really needed, given that the 64MB SPI is only available on an ODM 
variant by default.

[1] https://gerrit.openbmc.org/c/openbmc/openbmc/+/82262/4

Cheers,
Tan

> 
> 
> Zev
> 

