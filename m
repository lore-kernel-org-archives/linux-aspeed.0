Return-Path: <linux-aspeed+bounces-3586-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B65EB365B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Mar 2026 02:44:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ0WQ0wG9z2xpk;
	Tue, 03 Mar 2026 13:44:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772505874;
	cv=pass; b=miejrCrb06d3y3gSC4yNK22q8GZjFEyi1MkYeVqFBxDkZ3dyF9rVU8H9ZIkGEkkVjC6ThXmdCGLT89s9Cj1UwbDKXSGcLRvGJAwFEcWDo1WhIR1FXeX8o4OAuSRiAeD4fi1VxC2vXuy7ZyLapthx41vBc4XQ0H4KmZTQgUYrf1bBPHufMUk1ptA+/neaKC20HaXwm32OZgIsR+hY0uc3NHpY1taCpGsU/Ok1tiRqigYYDU2rHnAUdsbw3aOUuV2HX+G18pwVhKTEjeV5UdfB/u9fWPBlRYG9QUnlecjt06u8VWOEIFTOIsYwqplk24kGXaDQfMO3ZfrmQ9pFNR5ovQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772505874; c=relaxed/relaxed;
	bh=xI47GvGx+LBmFVceJqaBfu/TZwFpzmEjZRwkYkieSx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zm3k7KAeYbZBO80dEWJLfSmYpHdcpa8Y/V0A3HLCQnTL9fre1GQpa/ac25LjYyIzYQQTxYabMJpr5I+hFLMkiKfHjanrTDx5zSeuz2ap8POizkYo6+xhqMdDBbCJlWl1rz0wvBHoZKmCZ7m9rI1k2rT5H4MS9uUDosk60kuEXcgZD8duQRbc/RFnwdMlSsf24516tSk2y3TxrTZMXywhyuPY79beuKV5uSQegdM4HZr1wUcbTXWpO/UBMssKM1uw+lZEt/s2mkeSXCKPGs1rqVV3aNf0gtkR0fy02Hj+akVScKtf/LGNSjSQv4BAKVxQ34l1oRMhiXsm6EP5QOGsnQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kigc4Zp4; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kigc4Zp4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ0WP0Xztz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 13:44:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYsbOdVejakr4ye8Un8YV6prSqTPCQVNIsClOObp/61MI/laLOhKbDkBTGHrdJHyo5uXdRe9VQpD8h0Eqy0n672K1s0BcoT24g/J6mzIAZ5fBO9gRadxBx8n6v9XinPAF8WQch7lXJ8H4mdNzrVEvlUFMMtJnqi+FUwXB7p3K6rpaQq0kqdfLfZNDokzZQjAUEOX/Nj1/5NUB7gCrek7MDdu3SYwU4bOQ35AWLwSxvFYljyT7SpeuVB8IK42O0VGkNEwCFayB9t9j1e441JhlkEOSmFaIM9lM/+CQRQNCoI5oERPm3rVj2/RN+LdJW6SNIJzZA/eHiz2r7TX70ccpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI47GvGx+LBmFVceJqaBfu/TZwFpzmEjZRwkYkieSx8=;
 b=sfQIHG756k2kvAWYTC0UnFAzMe+mlbMPcKczkRgYkzd61du/p7LdacGEgyeOG/6MT4+0kPzUPTJ7Ro3U009ysydD7/8EpiVQ9nMulIaevGYd0A9/C71XGdZ6oBeSpCQar3/4ny9BGzAlUBvWYRxIb7lC8k5380OmUNngEXaNJLJRGlYzxTeuQkRCtYofAEe9RkVbqvtNqBNkxp2soGYe87h999xAt1GMWbo+jR/IeIMSNFIUykT3jCrVVHRWE54urjA9LecgmMgOxFuIZ8PhT/F+GKQieJ38oxloIn9DMh2nYU2XZH5QeM93Ozzeu/ylewtV4Hkl4sCa4mnb5t0Dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI47GvGx+LBmFVceJqaBfu/TZwFpzmEjZRwkYkieSx8=;
 b=kigc4Zp4R0lpWTZ2mNjabDGUfHR2yB6vm/238zTC1sDjJqIocUwJyHrqHy/31O3cTf7qs1q3Y0g/ml5iVRvAyAWgp/eS8UQwmW/dsiHNdNPyt68VZkgcWuIxcmXu67Up/EcdsG3HbecgbTyGapdhnRPwEsbjCuNHlxXP91KCwJfYeXbCUNeDeUv8YbSHZ5NUP6/s/8dEdWpQ1EWNs2quJ9FW/tYI1gYA9hCFLyksAtFvQROtefF35uK4w56fQp15swldXFJMgpIlVp6SwOs8qvy4N6jy+UbKQ+uVImY+uWpmLBa5NGFeeM0bmuJq9+A4gO+bl4VYgqAv+Ajax//ggw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SG2PR06MB5105.apcprd06.prod.outlook.com (2603:1096:4:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 02:44:05 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:44:05 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHY2IDAvNV0gQWRkIEFTVDI2MDAgUkdNSUkg?=
 =?big5?Q?delay_into_ftgmac100?=
Thread-Topic: [PATCH net-next v6 0/5] Add AST2600 RGMII delay into ftgmac100
Thread-Index: AQHcqi7Dn3EPiYw+mU61Mm1b5sdx4rWcBk+AgAATRHA=
Date: Tue, 3 Mar 2026 02:44:04 +0000
Message-ID:
 <SEYPR06MB513446282E752E9458F0FD1E9D7FA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch>
In-Reply-To: <ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SG2PR06MB5105:EE_
x-ms-office365-filtering-correlation-id: 210e8167-0bb0-4f78-c21f-08de78cebc4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 iD57YpDP7/zPiv5uy6XiqW+3ydU4WZObVRX8MnzIJGBDmG5KiV+Hpf/oMgOcERbrdBDaQiiV+66UW3g+H7AUWwoUFDHVjOEUFmzdVb2fM7oZcQ3Irw3RiZ7jkNLIxo5xd9y1I/kTnA+b7U9UjfAUT/4t7yz1DfMkCxWaKpbOKjjhkQz8J9dVC98DpTaIfDXYXkuDH9I+ZR7E9K5X4xgdG8RxZQbtXB6+xuH2W+lB3i/Z6zCYlcD61cYYN8x2P9sYcdRS4nQLxH6u2KAqRhh1wPDJ0zINbbEz73Ll4Caa0tt47x7vFAAv74GTCTGMp3/a1tojEveppnEvt0n8VYeiLH10qj5XIcZaW5RRpWNl7Axc/YmUDrOS3z29xYONukYeZZheOFHI482PGzNYGfx8nJxA79bOhNNmsyXxrVDndF0kcZB+okWVu8nRjtnwkhfI+WmRvym6gSwBr7ZHrDghdvktT94R1fksf6VxsvDGqrQqdrr9q5dv5yv4aSemHjuLWbDEoscDolS4euBDV7Oj2GP92V30RSs3gEVj8PW7BJbB24AzF+KXFLCGa39YfWb/kgPz3hKlz2gOS88AxKpMgGBjr84R+cvpDG5f9jm9UYh4EBtFa2d0dX20+xcClMUJTNJ+YfwtZl+gZwC+Mnzm4fFgqFDZviNi4ZwIQR5lHQMoL5vJitL1Kcv72wYH4cEnBa+/R0r0YMBrItuS/PW1sVfO96WcjDX0M3xf/8sxzdsHQrh0vymeBvWPcEOPzi3GOLDbIzoBDkk5kTk+qxUhYUbufMvkispYZ4vlSWEwHJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?YXR3UDVDcDZ5VTNMYy9QYVJYODZrMWorU3d0SExVVG4wMXN6bHZQWCt2VTRlSzlB?=
 =?big5?B?TlFKcEdrTUpHV1NLcVpENTNPNERXWFlvVmNwRU9iV1VIZnEwMXdRQWthMVJEanBF?=
 =?big5?B?ZjhYNWRmMlRlbC9Ycm8wR1ZzZ1NZK3F0clRIS2kxbGVBczBwb29YZXBkWi9LNFNr?=
 =?big5?B?VStoYWVRdjNyWld2K1pJRG9mSXpFYTJ4ZnR2dEV1ZWw2cW1JQnpRczRWcmNHeW5l?=
 =?big5?B?ODQxcGpOOFBySEQ2eFZwcUhHcE1vUnY2YUlQUzd1NVdYNGZxZXFlNUJzNUhMM3BO?=
 =?big5?B?RFlIeVI1M0Nsb1loNURIYjNCUzBmbzNNVnJ2enNGeVFvbDhkQUxDV2VtcEszQ0Rr?=
 =?big5?B?S0dNUTRmZXcvL3VkMDF0ZEtpSEhScWNGOW0zckpyZkc1cUlNZ2VEYmhBQzlvQXda?=
 =?big5?B?cHMyei9JY0sxN0tyNXk3QTJhMEs3dU5VZGJaLytXL2k1cjV6UEVrcmZQdkttSjlU?=
 =?big5?B?U0JuNkZrc2JkSEVnRmxoZTd4RThrSTNxR2dyWXlJY29YdytvbmtUTG9jMzR0TlR1?=
 =?big5?B?TlBZS3R0UWc0eHp0aUcyY0l0MjZvVUQzOWRUblBRaG1sazdpekx3TkdTdmJKWVlS?=
 =?big5?B?aFkzWXAwVWZKSlVaeWhmbCtrOEJWV1QrSnU2NHY4UmJ3KzFWSW4zcXNNd0RHNWZw?=
 =?big5?B?VnJYdU05MDQ1TG00S0YvTXJ2eHRRV1N4UFY3MFBNZUwwY1lCSGI4YUdRb0ZyNzUz?=
 =?big5?B?QVBMTGx1Sk5meTd4R0w4eXA0RVRncVNjd0wvcHJxKzJZREVoQUFhMHFwVWRzUVRH?=
 =?big5?B?MHhNTm05aFl2TGpzd1F2cVpQcWxoSWhHcDY2UkRUZkNEa2hRYm9yY0pWVWo3MkpD?=
 =?big5?B?NkdXR1MvK05GcUtTVVNvbktHV2p2Sjd1eVZjZSswSkxVYzFlUUhMZTJ0SFVnc1Na?=
 =?big5?B?WW93a2RaVmV0WkdtamMzZ1BWVmVQUFVXZUtNUUdKN1lzckxTV2xDSjJnMDhLTnp4?=
 =?big5?B?RmZlNXdXK3UzTDQ0T0FSVjVqWU5LK3hzcTRCZ2FIU2xHNlAzNXZBSHl1dUNrOWdr?=
 =?big5?B?R2E3bWZVQ2dCQ0FHSUQ5MlBrdGZYK3hMTnZrdEVDeitkWnl0cnBPUEJidDdXdytU?=
 =?big5?B?M0F6bCsySWVaWDdUTWhNakdJU083K3BqNmNXditJMDVlTHV4K3NwbVVSWVF1NFZu?=
 =?big5?B?YW1zNUZKWlhVT2t5K1oxL3c0Z0FGcEE5MC9lSU9xK0t2bUw4TUJGbWV5WE1SeWh3?=
 =?big5?B?OFB0TEdzamFuUC9yd3lUVmZ1Y0xXQ2h4WjZldmZEVGJ6bWZ6MkVwOHBILytUeDdy?=
 =?big5?B?c3llbDloOE5SUDZCbXVNdHk0RnRYVFNTQUVBc2lrRWpYcVNLU2xHRkdDc2kxcHhI?=
 =?big5?B?Z1Qrcm9Vak9OZDd3cTVqWGkzNktsa2tpSlVYVW9pOGg4YzdvMVhZSG8zWU5wWG1h?=
 =?big5?B?d2t1Y0gwVDVRNS9CVUlESG8rMzllaWllVGFUNGRXRzlwenh1Q3pmWlhGSldxSzZK?=
 =?big5?B?d1l1U2ttemFmVGlQcnlTSzg1MjJlRS9OYldyRVBpU1VXMjRna09Dc1dOU1NCT2Rv?=
 =?big5?B?TThrcHkrY1EzMjBBYUplNm5iSXFUS1lnamV6emlHMk5WU3I1YXdGSDJrdlBDbHdE?=
 =?big5?B?eEU3R0N2NjZVRmtBSkZBdE1iREVqYjZlMER2SGlmcXBaeHBIVnZEdE5DSWJzeGRa?=
 =?big5?B?MHh0WGs3S1FmMEJqZVNXUmFGNE5DTDJuQVpHYlNMUU9MSXVZUFhOSVp0bGhJVkRp?=
 =?big5?B?QTAyN2xlbGlFMDlaekFTOTk2TlcrTC82bDhJcEgwS1FhaGlvYTB6emFPaTdZTVQx?=
 =?big5?B?RVA4M3luN0x1TXJTbFFRYkhNVDVCTGFWdWYxdVFOVUtTZHJlQjBkVDZ6OHZOa1Nq?=
 =?big5?B?NS9MelVJc0d0d0FHclpBT1Vjc1loRTR6cW92WS9HbW9oQjZnOEtEdGhmc0RJeTdv?=
 =?big5?B?cUF2VzZaYW9lMzV6VFArdmlObGV1bEMxYjFMMm9SZlRTWnZmcHl4OTBxOU1RejQ5?=
 =?big5?B?WFh0bGhYUnA2QjFkSjJ4Q0d4RC9vak9ZSGZIYXpYNEl0M05meUZFQjZRTmhsd29s?=
 =?big5?B?ZFdmZGFrU2cwK3E1aEhnVmZMVnBjcjVleXQrWjkyK1FwbTl4VW1TNlRjK2RjVURN?=
 =?big5?B?aXA3RHJqQ1ZXYkNlSUlXSU9zYmRtZ1NEQ0tKK2ZqWXNSUTBXMFFCbHljcWtUK3FH?=
 =?big5?B?OVQ0L3hIczRKWlc0Q3BtWU8rUCs5OTNJUkhFekpvRi9xSzNBRnliQ3dUK1BVL3d2?=
 =?big5?B?RlhRcW1vSWpkVXRXOVRKNzhOMFE2UT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210e8167-0bb0-4f78-c21f-08de78cebc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 02:44:05.0604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEaEt1YMCUCi4s03pj2U6APchybuY+5xgWKL2bEyqmxe0Pi5qYKpkCsqF3uTfTjpqefd7YEchKR52KfAAIcdF3BRQ0aEhle9LGkBWOKanxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5105

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gT24gTW9uLCBNYXIg
MDIsIDIwMjYgYXQgMDY6MjQ6MjdQTSArMDgwMCwgSmFja3kgQ2hvdSB3cm90ZToNCj4gPiBUaGlz
IHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIFJHTUlJIGludGVybmFs
IGRlbGF5cw0KPiA+IGZvciB0aGUgQXNwZWVkIEFTVDI2MDAgRlRHTUFDMTAwIEV0aGVybmV0IE1B
Q3MuDQo+IA0KPiBJJ3ZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgdGhpcyBzb21lIG1vcmUuIEFuZCBp
IHdvdWxkIGxpa2UgdG8gcHJvcG9zZSBhDQo+IGNvbXBsZXRlbHkgZGlmZmVyZW50IHNvbHV0aW9u
Lg0KPiANCj4gV2hhdCB3ZSBhcmUgdHJ5aW5nIHRvIGFjaGlldmUgaXMgYWxsb3dpbmcgdGhlIGNv
cnJlY3QgcGh5LW1vZGUgdG8gYmUgdXNlZCBpbg0KPiBEVCwgcmdtaWktaWQuIEJlaW5nIGFibGUg
dG8gc3BlY2lmeSBpbnRlcm5hbCBkZWxheXMgaXMgbmljZSB0byBoYXZlLCBidXQgZm9yIG1vc3QN
Cj4gcGxhdGZvcm1zIHNob3VsZCBub3QgYmUgbmVlZGVkLiBJdCBpcyBvbmx5IG5lZWRlZCBmb3Ig
YmFkbHkgZGVzaWduZWQgYm9hcmRzDQo+IHdoZXJlIHRoZSBkZXNpZ25lciBvZiB0aGUgUENCIGRp
ZCBub3QgdGFrZSBjYXJlIHdpdGggdGhlIGxlbmd0aCBvZiB0aGUgdHJhY2VzLg0KPiANCj4gUGFy
dCBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBNQUMgZHJpdmVyIGlzIG5vdCBhY3R1YWxseSAi
YnJva2VuIi4gSXQgZG9lcw0KPiB3aGF0IHdlIHJlY29tbWVuZCwgcmVhZCB0aGUgcGh5LW1vZGUg
dmFsdWUgZnJvbSBEVCwgYW5kIHBhc3MgaXQgdG8gdGhlIFBIWS4NCj4gVGhlIHJlYWwgaXNzdWUg
aXMgdGhhdCB0aGUgYm9vdGxvYWRlciBlbmFibGVkIGRlbGF5cyBpbiB0aGUgTUFDLCBiZWhpbmQg
dGhlDQo+IE1BQyBkcml2ZXJzIGJhY2suIEJlY2F1c2UgdGhlIE1BQyBkcml2ZXIgaXMgbm90ICJi
cm9rZW4iLCBpdCBpcyBoYXJkIHRvICJmaXgiDQo+IHRoZSBpc3N1ZSBpbiB0aGUgTUFDIGRyaXZl
ci4NCj4gDQo+IFNvIGxldHMgc29sdmUgdGhpcyBpbiB0aGUgYm9vdGxvYWRlci4gSSBzdWdnZXN0
IHlvdSBwYXRjaCB0aGUgYm9vdGxvYWRlciB0byBubw0KPiBsb25nZXIgZW5hYmxlIHRoZSBkZWxh
eXMgaW4gdGhlIE1BQy4gSXQgYWxzbyBuZWVkcyB0byBwYXRjaCB0aGUgRFQgYmxvYi4gSWYgdGhl
DQo+IGJsb2Igc2F5cyAicmdtaWkiLCBjaGFuZ2UgaXQgdG8gInJnbWlpLWlkIi4gdS1ib290IHNo
b3VsZCBiZSBhYmxlIHRvIGRvIHRoaXMuDQo+IA0KPiBUaGF0IHNob3VsZCBnaXZlIGJhY2t3YXJk
cyBjb21wYXRpYmlsaXR5Og0KPiANCj4gKiBFeGlzdGluZyBEVCBibG9icyB3aXRoIG9sZCBib290
bG9hZGVyIGdhaW4gdGhlIGRlbGF5cyBpbiB0aGUgTUFDLg0KPiANCj4gKiBFeGlzdGluZyBEVCBi
bG9icyB3aXRoIHRoZSBuZXcgYm9vdGxvYWRlciBnYWluIGRlbGF5cyBpbiB0aGUgUEhZLg0KPiAN
Cj4gKiBGb3IgbmV3IGJvYXJkcyBiZWluZyBhZGRlZCB0byBMaW51eCwgd2UgTkFDSyB0aGVtIHdp
dGggInJnbWlpIiwgdGVsbA0KPiAgIHRoZSBkZXZlbG9wZXIgdG8gdXBncmFkZSB0aGUgYm9vdGxv
YWRlciwgYW5kIHVzZSB0aGUgY29ycmVjdA0KPiAgIHJnbWlpLWlkLiBUaGlzIGlzIGEgcG93ZXIg
d2UgZG8gaGF2ZS4NCj4gDQo+ICogRGV2ZWxvcGVycyBvZiBleGlzdGluZyAuZHRzIGZpbGVzIGNh
biBzdWJtaXQgcGF0Y2hlcyB0byByZXBsYWNlDQo+ICAgInJnbWlpIiB3aXRoICJyZ21paS1pZCIg
b25jZSB0aGV5IGFyZSBoYXBweSBhbGwgcGxhdGZvcm1zIGhhdmUgaGFkDQo+ICAgdGhlaXIgYm9v
dGxvYWRlciB1cGdyYWRlZC4gVGhhdCBtaWdodCBiZSBuZXZlciwgc2luY2UgZGV2ZWxvcGVycyBh
cmUNCj4gICBsYXp5LCBhbmQgd2UgY2Fubm90IGZvcmNlIHRoaXMgb24gdGhlbS4NCj4gDQoNCklu
IHRoZSBjdXJyZW50IGZ0Z21hYzEwMCBkcml2ZXIsIHRoZXJlIGlzIG5vIGxvZ2ljIHRvIGNvbmZp
Z3VyZSBNQUMgaW50ZXJuYWwgZGVsYXkuDQpBbGwgTUFDIGRlbGF5IHNldHRpbmdzIGFyZSBjb25m
aWd1cmVkIGluIFUtQm9vdCwgYW5kIHRob3NlIGRlbGF5IHZhbHVlcyBhcmUgZGVyaXZlZCBmcm9t
IHRoZSBEVCB1c2VkIGluIFUtQm9vdC4NCg0KQXMgYSByZXN1bHQ6DQoqVGhlIHBoeS1tb2RlIGlu
IHRoZSBMaW51eCBEVCBtYXRjaGVzIHRoZSBvbmUgdXNlZCBpbiBVLUJvb3QuDQoqRXhpc3Rpbmcg
QVNUMjYwMCBkZXZpY2UgdHJlZXMgoVggaW5jbHVkaW5nIEFzcGVlZKGmcyBFVkIgRFQgoVggZG8g
bm90IHVzZSAicmdtaWktaWQiLg0KDQpCZWZvcmUgdjYgb2YgdGhpcyBzZXJpZXMsIHdlIGRpc2N1
c3NlZCBpbnRyb2R1Y2luZyBNQUMgaW50ZXJuYWwgZGVsYXkgY29uZmlndXJhdGlvbiBpbnRvIHRo
ZSBmdGdtYWMxMDAgZHJpdmVyLg0KSG93ZXZlciwgdGhpcyBjaGFuZ2Ugd291bGQgYWZmZWN0IGFs
bCBleGlzdGluZyBEVHMsIGJlY2F1c2U6DQpJZiByeC1pbnRlcm5hbC1kZWxheS1ucyAvIHR4LWlu
dGVybmFsLWRlbGF5LW5zIGFyZSBub3QgcHJlc2VudCwgYWNjb3JkaW5nIHRvIHRoZSBZQU1MIGJp
bmRpbmcgZGVmYXVsdHMsDQpNQUMgaW50ZXJuYWwgZGVsYXkgd291bGQgYmUgZGlzYWJsZWQuDQoN
ClRoaXMgd291bGQgdW5pbnRlbnRpb25hbGx5IGNoYW5nZSB0aGUgYmVoYXZpb3Igb2YgZXhpc3Rp
bmcgcGxhdGZvcm1zLg0KVGhlcmVmb3JlLCBzdGFydGluZyBmcm9tIHY2LCB0aGUgYXBwcm9hY2gg
ZXZvbHZlZCBpbnRvOg0KKiBDaGVja2luZyB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlIGN1
cnJlbnQgTUFDIGRlbGF5IGFuZCB0aGUgcGh5LW1vZGUNCiogRGVjaWRpbmcgd2hldGhlciB0bzoN
CiAqIE1vZGlmeSB0aGUgTUFDIGRlbGF5LCBvcg0KICogUHJlc2VydmUgdGhlIGV4aXN0aW5nIE1B
QyBkZWxheSBzZXR0aW5nDQoNCkluIGZhY3QsIGluIG91ciBTREsgKFUtQm9vdCk6DQpUaGUgQVNU
MjYwMCBFVkIgRFQgaGFzIGFscmVhZHkgYmVlbiB1cGRhdGVkIHRvIHVzZSAicmdtaWktaWQiLg0K
TUFDIGludGVybmFsIGRlbGF5IGlzIGV4cGxpY2l0bHkgZGlzYWJsZWQgKHNldCB0byAwIG5zKS4N
Ckhvd2V2ZXIsIGV4aXN0aW5nIGRlcGxveWVkIHBsYXRmb3JtcyB3aWxsIG5vdCB1cGRhdGUgdGhl
aXIgTUFDIGRlbGF5IGNvbmZpZ3VyYXRpb24gc2ltcGx5IGJlY2F1c2Ugb2YgdGhlc2UgY2hhbmdl
cy4NCg0KRm9yIEFTVDI2MDAsIHdlIG5lZWQgdG8gbWFpbnRhaW4gYmFja3dhcmQgY29tcGF0aWJp
bGl0eSBpbiB0aGUgTGludXggZnRnbWFjMTAwIGRyaXZlci4NClRoZSBiZWhhdmlvciBpczoNCkZv
ciBvbGQgRFRzOg0KVGhlIGRyaXZlciBkZXRlcm1pbmVzIHdoZXRoZXIgdGhlIGV4aXN0aW5nIE1B
QyBkZWxheSBzaG91bGQgYmUgcHJlc2VydmVkLg0KSXQgbWF5IGF0dGVtcHQgdG8gY29udmVydCB0
byAicmdtaWktaWQiIGFuZCBkaXNhYmxlIE1BQyBpbnRlcm5hbCBkZWxheSBvbmx5IHdoZW4gc2Fm
ZS4NCkhvd2V2ZXIsIGlmIHRoZSBvbGQgRFQgdXNlcyBmaXhlZC1saW5rLCB3ZSBtdXN0IHByZXNl
cnZlIHRoZSBvcmlnaW5hbCBNQUMgZGVsYXksDQpCZWNhdXNlIHdlIGNhbm5vdCBwcm9wYWdhdGUg
cGh5LW1vZGUgdG8gbW9kaWZ5IHRoZSBleHRlcm5hbCBkZXZpY2WhpnMgc3RhdGUuDQpGb3IgbmV3
IERUczoNClRoZSBkcml2ZXIgY29uZmlndXJlcyBNQUMgaW50ZXJuYWwgZGVsYXkgYmFzZWQgb246
DQpyeC1pbnRlcm5hbC1kZWxheS1ucw0KdHgtaW50ZXJuYWwtZGVsYXktbnMNClRoZSBkcml2ZXIg
dGhlbiBwcm9wYWdhdGVzIHRoZSBwaHktbW9kZSB0byB0aGUgUEhZLg0KDQpBZnRlciBjb21wbGV0
aW5nIEFTVDI2MDAgUkdNSUkgZGVsYXkgaGFuZGxpbmcsIHdlIHBsYW4gdG8gcGF0Y2ggdGhlIEFT
VDI3MDAgcGxhdGZvcm0uDQpGb3IgQVNUMjcwMDoNClUtQm9vdCB3aWxsIGNvbnNpc3RlbnRseSB1
c2UgInJnbWlpLWlkIi4NCk1BQyBpbnRlcm5hbCBkZWxheSB3aWxsIGJlIGRpc2FibGVkIGluIFUt
Qm9vdC4NCkxpbnV4IHdpbGwgZm9sbG93IHRoZSBBU1QyNjAwICJuZXcgRFQiIG1vZGVsOg0KKiBD
b25maWd1cmUgTUFDIGludGVybmFsIGRlbGF5IGFjY29yZGluZyB0byByeC90eC1pbnRlcm5hbC1k
ZWxheS1ucw0KKiBQcm9wYWdhdGUgcGh5LW1vZGUgdG8gdGhlIFBIWQ0KVGhpcyBlbnN1cmVzIHRo
ZSBwbGF0Zm9ybSBpcyBpbXBsZW1lbnRlZCBjbGVhbmx5IGFjY29yZGluZyB0byB0aGUgZGlzY3Vz
c2VkIGRpcmVjdGlvbiwgd2l0aG91dCBsZWdhY3kgY29tcGF0aWJpbGl0eSBjb25zdHJhaW50cy4N
Cg0KVGhhbmtzLA0KSmFja3kNCg0K

