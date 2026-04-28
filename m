Return-Path: <linux-aspeed+bounces-3965-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64DDFF8864
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 03:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4R6S29Vkz2ynv;
	Tue, 28 Apr 2026 13:40:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777347648;
	cv=pass; b=VCiYCoiaevYNBB7E6PV8LgadzI+ubohm8xV1ctYpQHi1Pe852fbZynd6b/jzxwdR7ACky3qcgrQ9CrYUXBSlv4cYIwAGFjnb71HTvDhH7NzhfXWUB6FNKlrWi6Nj4L8jso0JLfn+zjXycQbrNEV/ohuqiAmzFRVG+9rjAXZb9oMqijBjnp2fsHwsRM0uhepELYaKUKfUQI9OyY34MWCRJEjT/zivQKao63zueBRbULnOS6jR+4Rt7v+9rhG50b1BnIwRKV80WtA7N6gpAD+18+Gmpyu47LmFGFmE8Y78AKC8aVOrkcw09VGXnxlHhuryIY+FAvjVLNdE3EcNMlw6EA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777347648; c=relaxed/relaxed;
	bh=gGnyHAI51iMV5vfEhCPVoMVC8G7wq02GaVP7ZXFfklI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNLyI+BfHXW7mEJmF0JfvvAhIdOZGD6uH3qqt6J+kNaFpxLLZogg85CZDEWJd47mucnTOeT+U7aAYitQV2yIfrZMX0Io6FOazpYKFYxkx/feY3PV415OmlMVUi2gsxrAFdUpt0q9uwEoWzqTCt/XPCuLZxQjIq7ReGcVvgIstLnwgYYWSrT9M8akwT8dZvKgc6QUAdUaU98AQ13Ry2YgSN2mIanHBuquCdpX35/dd9Mpkv66EeFhnDSoLXljY9xiuljSuD8e7ATn/Vg+vuY/DzhX0DU09A8cFHVi4bdP7vIHGoVHgQysxsLdqWhYgglxpDESCrqtZUCrjiFq778Uxg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ANAtFEkh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ANAtFEkh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4R6P6NDQz2yRn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 13:40:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/9eFHBNrDgIVQk3/RGrRFXHB3+WsbDSox0jQfJWJlOJPnekvJ+pbO9ggNWvrSs/dw8b0MyV/8RsUaZyixkHmAeCH/iZYU0ADxr9Guj3IOHX6IOognepf1UbzOX779BYZ5fF2BouG3pcmjwGy5cUXVvguDMqDbzbiRKgsxM9hGcJUM5zlyMzcgeny5sNYUDQ2DkuZvHXv4jzC8IT9JMr/naewEWkdaCf47+XKQQXLzFZpnjdFtUf0nUkuM/9xkirSNnK7J4DNrBa8LLk5e5VcGIHpuhd0wf/S9/5kBukE5ThF+MTA7ldqk66zlhJLsOholyZO/BepSIb7AjSz9nO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGnyHAI51iMV5vfEhCPVoMVC8G7wq02GaVP7ZXFfklI=;
 b=aOXO0hPaslJUd0jh7UwSTSWGeH6ExF93WyKYUjTVu6CDJliuh53Ly6/HqyUb3qavz51cA6Bz2tXhoM2fqzFncieUuvLidpRiXrof71Ydm1VKV7MsMvCtGnp7jE1cX3z8LUq2BjBescG1pWnYywwBfpABX0q5SCGw1RiZGsyQWUfU3mVokef3jzvbz7K/TkxRYCMiO50ZF/kNAyEVHDz1h+mYiqq9j6Fo+WBCOeVdGbc6opJ9/uyt3rkBIpMTmzsX1JNtK1U80qj8fMZHigcpxjVGW3pNP/BnW8tSQuDOSTjjgA5iJ6X995RJQMOIPQ+fGKh3QUkEEhQeyKypVStdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGnyHAI51iMV5vfEhCPVoMVC8G7wq02GaVP7ZXFfklI=;
 b=ANAtFEkhy+61+WVmXU+KyfIQ4OuQaz47k0aZQ1B7Rjkc4piPMyqYy3fzphKHC1rlMkOIt0JjZl+FwFPWK8FGgPYP3FL3cXiC37JFooWcZmpdQQHxDSh6Wh6gHtyNnodLwBVkpxCLbysF32MwwcSTXXqX360mmJScNkygt0bMFkS3dOszb1mUwAwqAKjIlJ6ggPq17G4K1zA1O2e2xUo+rO8gfi2LpllVwYACpLqfasxPPanWC+n4jTTXiubv0FBpLujDSbqr9Dm6gMHUdZSVJ8cc1YA8f4y2zGznU6ctlF5vRCwfbx1DRs8v9ZqT6qThIniAWWLuORhMchJehJl3/Q==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6039.apcprd06.prod.outlook.com (2603:1096:101:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:40:20 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 03:40:20 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Ender Hsieh <andhsieh@nvidia.com>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: Marc Olberding <molberding@nvidia.com>, Andrew Lunn <andrew@lunn.ch>
Subject:
 =?big5?B?pl7C0DogTlZMMzIgQk1DIGVuYWJsZW1lbnQgoVggb2ZmZXJpbmcgaGVscCBvbiBm?=
 =?big5?Q?tgmac100_work?=
Thread-Topic:
 =?big5?B?TlZMMzIgQk1DIGVuYWJsZW1lbnQgoVggb2ZmZXJpbmcgaGVscCBvbiBmdGdtYWMx?=
 =?big5?Q?00_work?=
Thread-Index: AQHc1r+GLHLcfllLBUKLNnD9hcbl4rXz0urS
Date: Tue, 28 Apr 2026 03:40:19 +0000
Message-ID:
 <SEYPR06MB513489D0B8F5BC77258EA1FF9D372@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260428033048.2694433-1-andhsieh@nvidia.com>
In-Reply-To: <20260428033048.2694433-1-andhsieh@nvidia.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6039:EE_
x-ms-office365-filtering-correlation-id: fb53ec65-8958-4cfa-763e-08dea4d7df0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|8096899003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 QYs/ikv1KzdTVWQp3f9OouEC3QwJnS5icEpUZvTvkmnarMt1MVkIzFdzwNwkOmECnl0o5OpCm8ff/oqOAZFaWU68ypQmKrGOXnpeJwDlSe0RUGqoOVt252XsyktZeO/BPVfqYKojKQPW2CgME/BGiKFj4D3CSmR7Z0so7AJxYYCxah4PPEMh6zr8XHyq5d2weHxrp9Zc9l5oct1lJ82mN2oYmGT23ZrUXDCxvMDr7cTMNiShksb7recftlvWOrCDH0HE1k9PloMfT27RM77+9GVOthpaSIiDbAuxz5IqBXaVegxnIWuPcuzbYmRXNeLbRqAkQXilSKJ9L7YH1I46crkVk9oSIryHe/ESNpaU9UPN1i/7w8lHTlQI6/sCBIu1EOkqNMn0GOF2zig07uOYTdtz3zyxXdB4JBIyrRu1jZYXxjfplAoKgP7ka7qiv8J/OpAsbKWYPpd6N5DbkcSa+lvAx31eBDns2BLnA0wVjhJayLslAorU8CyFCV3hjL4LODDQyd6rSKjbtCPSWhsAJyuPPJfqihsLpVhH2S6I8dWFPR7Z9wqbjIFd7arWxy+4k3swBYPqwL0eaixAIfs7nA3BlO1fE1YKn5xogzecCUvTI4RXnyubf6KzFWht/Kv6Rvg6hBQtpOPEod1A7AsEItiIdf0O8Nxbworubt1CA0quD1p5cZ1FOy9I0336rjTx1ImQ59edMAnxyF2urZiyXpSjkHVekIwkHPYMWeWFXY3BOmBsrTcIbfeBXI/QMruUQpoU88C09CN2KYrUHCderG/znZs89eh2pGJnK0ezOhQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?Q2NTMzAveTQwdDc4bG9VdDJHL1ZPZ0w3NGdhaEsrNGpLeEUwUHkzWC9HM0dhOHVX?=
 =?big5?B?M1dwWVozUXB6YlVqQzYzQ0JRdXQ0VDdGcU1WNXphSHRESVkzVVFlOGxTbUNmdlQ4?=
 =?big5?B?eFIwbm5jaFlsd0VkODQ0eWRiRHlqN2xDU0hFY1lvUVA5aTdGTDRVNit5ZVcrWFVv?=
 =?big5?B?dVJLYWJhZG4xa0p0S1YxZUx3djFJaFRoclJNQjhMcXdzNHMxMjhYclUveklQRjVB?=
 =?big5?B?TTQ4TnY1dFdsNjJlOXIrVzZ1ekl4QXNoRHQzaVcxTlRhNFNUUXNkejRHZG14Q21h?=
 =?big5?B?RWxGcEVWQkdhMEYyalhiQ3Y2dlc0VGVGREJ1ZThMTWwva1VKbFMxR0c3c2QzTEdo?=
 =?big5?B?dDdGeDZ4QVBPU3J1MGR2dnlQU2hNSU5FWmE5VjhJNGJ4aUdqL3R4UVByNSt3K21F?=
 =?big5?B?R05TZEFHNHgraWJwMjlLd0tPKzBlYnBoSEVKMlcrcTBBY3QxZStUOENXWHliME5o?=
 =?big5?B?VHhub2dMd2xKZ0krNTAzZGZ4TXRmTzFFODBlWVNubGl3enNWWGcybjJwUjRLMmh6?=
 =?big5?B?dlY4eElZV2EvdWt6VE9uRDBjdXduMmpOcFFla2pWdDRLUEE4MXdYUXRSbXRjbUpi?=
 =?big5?B?Nk9iZUU0SlpTRUZHRm11dFhCdWVxSEFkOEV4WHcrRXlSYjFRRmpGVmZncEw4RUd4?=
 =?big5?B?cFBVV3FHcm1JazJ0YS9UMzdURnY3YTlFTUtQN3B2RURRaFJ1WTJzOWVEaGY3c21J?=
 =?big5?B?QVU0aU9OZmd6SU9rL2ZnTmRmMG83SW1OZjRXVTdjd1JqSDVFUXdtdzN0WjZFaVBO?=
 =?big5?B?M00zbStYMFY2SDg2b2tPM1RGU3hQb252aEl1VEdPK3R1QWtNTEFSUGN2K1U4Y1ZZ?=
 =?big5?B?cnI5VlJpeTErQmZJa3ZxbGRUcEhzYkxibmNheENNTDR5ZVN2Si9hYkJjYTRORjRB?=
 =?big5?B?ckdZSlpubGhvZjZzT2p6UlArOWZjSkc0Sk9xWDY0cGkydmtMclIzNG5aUHhlNzhQ?=
 =?big5?B?RGFMUG5mL3F2ZERmMmJxQ2VJa1hzRXNseHBtZHhNR09VT3VMR1JlRkR0VW1QZDV0?=
 =?big5?B?UUNqQUxOakYyeithWmNJRzVQekFHcUhJUTM1SVNLNy9EUENvYU1sV1Yzd3liUTBi?=
 =?big5?B?ckNmTkhGM01DblJLNHUxcytKbkNkWmdxQjdJZi9NMDB1WnlHTmVuZ1BVT0g2d2FQ?=
 =?big5?B?RTR4dW03Wk40RHVHV1pFZCtmMjBTRFVUK0NseklXRHB4VmJJaEpaTHBoUGZVUjdO?=
 =?big5?B?UVlSbUtPSDFaQzZUdHhZU2UyOUdPcm5UeWNsckZCTjY4dGRSNVRnODU5NW9xcDBz?=
 =?big5?B?MHROd2JhcnBRbnAveEZTM3lPRWNiakcwWTRYblJsUFpPQ0UzY3ZiNXlqd00xbm9h?=
 =?big5?B?VTVMelhsNkFjRU1UcXJtNXc1TkxOSGl0K3psOWt6WVZUMllnNGV5V2F1SnZVOUJh?=
 =?big5?B?NDZkYk9zQklFNy9NNko0TVczMkszQ0E4MHRxNDJ4UlcreG56aGtoWFhGbTVuZGIv?=
 =?big5?B?YTdWOExJOXd4UkZPOVNRVlArMGlCa2hOdnJ4QVVTUTlVenc4MUtnU05QcG8wZDNw?=
 =?big5?B?TGJOZzVGdHhNdEdSUnlXbml4Umxoc2lpci9yYXJKYWxyMHkwQktuOVhlY25DZ1Fw?=
 =?big5?B?M0tYMHBjS0ZlbmxGQU9lRzhMQ0RkeFB0Ull3ME5BQVRPM2xQVGE2QUdBTzZLYXB0?=
 =?big5?B?Q3dWT21kTW42dGVQdEsrT2QzSjJ1dERmSlk0SkU5RTRiVk01cnVXdWUwVExXa2U3?=
 =?big5?B?aHFaQU5YT1VWTkRSWXUwYUthRUJiR1A2bEliRmc2dEdkRnZkR0ZHbjZZQlFRK01w?=
 =?big5?B?eDg5SFFHMmkwRWQ4bWNkU2FuUWhLS05pUW5jTDI1cVpYYW5nTUo3cWQyR0hSQXNI?=
 =?big5?B?d00wOTVmUGxyckhGWmNWa1d1T2R1MytFTEpUdTJHYkRJbTlMazhDcjBOZ3pab3Fu?=
 =?big5?B?Vi9DY0d4TFBKRFdyMUhVbzBQSG1qYnNRYXBUQVdSSFdEbVllV3lkdmZPU0xlV2NM?=
 =?big5?B?TTdFWTNpbmdJd2x2a2V3VG8vUEM2OHo0by9ITVNoN0RackhyaHlWekJxdUoyczZU?=
 =?big5?B?dnhpVWRCZVhqRFdYV3BweGRrdDRQNDFMUXZRb05GaCtIcnJhK1Q2MHpoSGdCTG9D?=
 =?big5?B?c0ZJcnJsL0pSVHhrUkJwU1BKUngwMXhTRklaM1pyYlp6Mk5TbTJJcXdQZXFFV2dJ?=
 =?big5?B?MTBYN1Z3WnBvYUgwbDhVOUlrZkhLNzdUSlB4Z0dXaWNTNG0zdDU5K1RrcFR4YUJB?=
 =?big5?B?L2l4aThpYmExRlJNVFEvRTVsdlFDUT09?=
Content-Type: multipart/alternative;
	boundary="_000_SEYPR06MB513489D0B8F5BC77258EA1FF9D372SEYPR06MB5134apcp_"
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
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb53ec65-8958-4cfa-763e-08dea4d7df0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:40:19.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6AwoQHjqkkjFzCjyqjsq862Q61oT4s1y156kGDiFVwGDLY4tqU+1HSVph7hi3Iv4+niNuEVZBz+WlX01SbK5gRo76hTkWh038HbvckKrDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6039

--_000_SEYPR06MB513489D0B8F5BC77258EA1FF9D372SEYPR06MB5134apcp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgRW5kZXIsDQoNCk5leHQsIHdlIGFyZSBwbGFubmluZyB0byBzdWJtaXQgYSBzZXJpZXMgb2Yg
cGF0Y2hlcyB0byBhZGQgQVNUMjcwMCBzdXBwb3J0IHRvIHRoZSBmdGdtYWMxMDAgZHJpdmVyLg0K
QXQgdGhlIG1vbWVudCwgd2UgYXJlIGZvY3VzaW5nIG9uIHVwc3RyZWFtaW5nIHRoZSBBU1QyNzAw
IHBsYXRmb3JtLiBPbmNlIHRoZSBwbGF0Zm9ybSBzdXBwb3J0IGlzIGluIHBsYWNlLCB3ZSB3aWxs
IHByb2NlZWQgd2l0aCB1cHN0cmVhbWluZyB0aGUgY29ycmVzcG9uZGluZyBuZXR3b3JrIGRyaXZl
ci4NCg0KVGhhbmtzLA0KSmFja3kNCg0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxp
dHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQqnS7NkwW6p+joNCqW7q0il8yipzqjkqv6l
8ymlaa/gpV2ndL73sUu46rBUoUGow6j8qmur36tPxUChQ6ZwIKV4ut2rRKv8qXekp6aspfOqzKFB
vdClSLlxpGy2bKXzs3GqvqW7uXGkbLZspfOkp7VvsGWqzCwgqMO90KXfp1mnUrCjpbu5caRstmyl
86TOqOSq/qXzqU2+ULe0qdKms73Gpkyl86FDwcLBwrF6qrqmWKdAIQ0KDQpESVNDTEFJTUVSOg0K
VGhpcyBtZXNzYWdlIChhbmQgYW55IGF0dGFjaG1lbnRzKSBtYXkgY29udGFpbiBsZWdhbGx5IHBy
aXZpbGVnZWQgYW5kL29yIG90aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhh
dmUgcmVjZWl2ZWQgaXQgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBs
eSBlLW1haWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgd2l0aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5
b3UuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQqxSKXzqsw6IEVuZGVyIEhz
aWVoIDxhbmRoc2llaEBudmlkaWEuY29tPg0KsUil86TptME6IDIwMjamfjSk6zI4pOkgpFekyCAx
MTozMA0Kpqyl86rMOiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZyA8bGludXgtYXNwZWVk
QGxpc3RzLm96bGFicy5vcmc+DQqwxqW7OiBKYWNreSBDaG91IDxqYWNreV9jaG91QGFzcGVlZHRl
Y2guY29tPjsgTWFyYyBPbGJlcmRpbmcgPG1vbGJlcmRpbmdAbnZpZGlhLmNvbT47IEFuZHJldyBM
dW5uIDxhbmRyZXdAbHVubi5jaD4NCqVEpq46IE5WTDMyIEJNQyBlbmFibGVtZW50IKFYIG9mZmVy
aW5nIGhlbHAgb24gZnRnbWFjMTAwIHdvcmsNCg0KSGkgSmFja3ksIGhpIGxpbnV4LWFzcGVlZCwN
Cg0KSSdtIEVuZGVyIEhzaWVoIGZyb20gTlZJRElBLCB3b3JraW5nIG9uIGVuYWJsaW5nIHRoZSBO
VkwzMiBCTUMNCnBsYXRmb3JtIChBU1QyNjAwLCBtc3g0IGRlc2lnbiChWCB0aGUgb25lIE1hcmMg
T2xiZXJkaW5nIGFkZGVkIGluDQpjb21taXQgZjI4Njc0ZmFiMzRmKSBvbiB1cHN0cmVhbSBPcGVu
Qk1DLg0KDQpJJ3ZlIGJlZW4gdHJhY2tpbmcgdGhlIGZ0Z21hYzEwMCBjbGVhbnVwIHdvcmsgZ29p
bmcgb24gcmVjZW50bHkNCih0aGUgMjAyNS0wNyAuLiAyMDI2LTAyIGJhdGNoIGFyb3VuZCBEVCBw
cm9iZSwgTURJTyBzZXR1cCwgbWF0Y2gNCmRhdGEgcmVmYWN0b3JpbmcpIKFYIGxvb2tzIGxpa2Ug
c29saWQgZ3JvdW5kd29yay4NCg0KQ291bGQgeW91IHNoYXJlIGEgc3VtbWFyeSBvZiB3aGVyZSB0
aGUgQXNwZWVkIG5ldHdvcmtpbmcgc3RhY2sNCndvcmsgaXMgYXQgcmlnaHQgbm93PyBIYXBweSB0
byBjb29yZGluYXRlIG9uLWxpc3Qgb3Igb2ZmLWxpc3QsDQp3aGljaGV2ZXIgd29ya3MgZm9yIHlv
dS4NCg0KVGhhbmtzLA0KRW5kZXIgSHNpZWgNCmFuZGhzaWVoQG52aWRpYS5jb20NCg==

--_000_SEYPR06MB513489D0B8F5BC77258EA1FF9D372SEYPR06MB5134apcp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space;"><span style=3D"font-size: 12pt; color: rgb(0, 0, 0);">Hi
</span><span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">Ender,</span><=
/div>
<div class=3D"elementToProof" style=3D"font-family: Consolas, Courier, mono=
space; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Consolas, Courier, monospace; font-size: 11pt; color: rgb(0, =
0, 0);">
Next, we are planning to submit a series of patches to add AST2700 support =
to the ftgmac100 driver.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Consolas, Courier, monospace; font-size: 11pt; color: rgb(0, =
0, 0);">
At the moment, we are focusing on upstreaming the AST2700 platform. Once th=
e platform support is in place, we will proceed with upstreaming the corres=
ponding network driver.</div>
<div id=3D"Signature" class=3D"elementToProof">
<p class=3D"elementToProof" style=3D"background-color: rgb(255, 255, 255); =
margin-top: 1em; margin-bottom: 1em;">
<span style=3D"font-family: Consolas, Courier, monospace; font-size: 12pt;"=
>Thanks,<br>
Jacky<br>
<br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">********=
***** Email Confidentiality Notice ********************</span><span style=
=3D"font-family: Consolas, Courier, monospace; font-size: 12pt; color: rgb(=
0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">=A7K=B3d=
=C1n=A9=FA:</span><span style=3D"font-family: Consolas, Courier, monospace;=
 font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">=A5=BB=
=ABH=A5=F3(=A9=CE=A8=E4=AA=FE=A5=F3)=A5i=AF=E0=A5]=A7t=BE=F7=B1K=B8=EA=B0T=
=A1A=A8=C3=A8=FC=AAk=AB=DF=ABO=C5@=A1C=A6p =A5x=BA=DD=ABD=AB=FC=A9w=A4=A7=
=A6=AC=A5=F3=AA=CC=A1A=BD=D0=A5H=B9q=A4l=B6l=A5=F3=B3q=AA=BE=A5=BB=B9q=A4l=
=B6l=A5=F3=A4=A7=B5o=B0e=AA=CC, =A8=C3=BD=D0=A5=DF=A7Y=A7R=B0=A3=A5=BB=B9q=
=A4l=B6l=A5=F3=A4=CE=A8=E4=AA=FE=A5=F3=A9M=BEP=B7=B4=A9=D2=A6=B3=BD=C6=A6L=
=A5=F3=A1C=C1=C2=C1=C2=B1z=AA=BA=A6X=A7@!</span><span style=3D"font-family:=
 Consolas, Courier, monospace; font-size: 12pt; color: rgb(0, 0, 0);"><br>
<br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">DISCLAIM=
ER:</span><span style=3D"font-family: Consolas, Courier, monospace; font-si=
ze: 12pt; color: rgb(0, 0, 0);"><br>
</span><span style=3D"font-family: Consolas, Courier, monospace; font-size:=
 15px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">This mes=
sage (and any attachments) may contain legally privileged and/or other conf=
idential information. If you have
 received it in error, please notify the sender by reply e-mail and immedia=
tely delete the e-mail and any attachments without copying or disclosing th=
e contents. Thank you.</span></p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B1H=A5=F3=AA=CC:</b> Ender Hsi=
eh &lt;andhsieh@nvidia.com&gt;<br>
<b>=B1H=A5=F3=A4=E9=B4=C1:</b> 2026=A6~4=A4=EB28=A4=E9 =A4W=A4=C8 11:30<br>
<b>=A6=AC=A5=F3=AA=CC:</b> linux-aspeed@lists.ozlabs.org &lt;linux-aspeed@l=
ists.ozlabs.org&gt;<br>
<b>=B0=C6=A5=BB:</b> Jacky Chou &lt;jacky_chou@aspeedtech.com&gt;; Marc Olb=
erding &lt;molberding@nvidia.com&gt;; Andrew Lunn &lt;andrew@lunn.ch&gt;<br=
>
<b>=A5D=A6=AE:</b> NVL32 BMC enablement =A1X offering help on ftgmac100 wor=
k</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Jacky, hi linux-aspeed,<br>
<br>
I'm Ender Hsieh from NVIDIA, working on enabling the NVL32 BMC<br>
platform (AST2600, msx4 design =A1X the one Marc Olberding added in<br>
commit f28674fab34f) on upstream OpenBMC.<br>
<br>
I've been tracking the ftgmac100 cleanup work going on recently<br>
(the 2025-07 .. 2026-02 batch around DT probe, MDIO setup, match<br>
data refactoring) =A1X looks like solid groundwork.<br>
<br>
Could you share a summary of where the Aspeed networking stack<br>
work is at right now? Happy to coordinate on-list or off-list,<br>
whichever works for you.<br>
<br>
Thanks,<br>
Ender Hsieh<br>
andhsieh@nvidia.com<br>
</div>
</span></font></div>
</body>
</html>

--_000_SEYPR06MB513489D0B8F5BC77258EA1FF9D372SEYPR06MB5134apcp_--

