Return-Path: <linux-aspeed+bounces-4969-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2F2C79FAD
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 05:34:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfqHF5mbCz2ybK;
	Wed, 09 Sep 2026 15:34:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788932041;
	cv=pass; b=BgI0J0js+VVvEhgwPONUbeMby+nzRqhxIeGE0X9PRqPt8HCx27die+WV1GI0YhIlRezJRFGBARACZBo3p5DgBUUG5ucYHx/T0ncL+LlCmURMCdgSOWGOqH+lfsrkxTlDfCf+IJvpiGx+Qp8c6b7kLBeNBr0sUs8fbVws1NApoq8GgKZiI/bPKZheM8as08IEfTAIm70PEQzH0AU6F4ga2qTo3WFnog6AQi3u4jqJdrChgJxjCKQbzVqYDVJOCxgFxN1nejjqezMe3g7lewcTAUvZ3/2ulQsk7bchpc73WRVTCt8nu4RJ2DEtnBR8PL6eDO2xtQStKoKYvtQOvUnN5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788932041; c=relaxed/relaxed;
	bh=GmXUshcSAPWCHNFeuKN5VT32WbbKAccXyzAuGzO7zRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZyxkIE7a17jr+EoIPOB3iGfuPKecGDBz60AEQMkE8ySAe30ionQVVFtqWw9bvdKd3HuQESHJ1Niaz1lqymw6dOytyR+TWFaeh2uOZZjn0hb1EBQ/vOne8lMABL8us6nbLDUckTiO+hN0GstlTScGM3R8ZTVLwMbTWkwK3FSGyN2Jt2/xpd87t1hiJ68KKJGPlyRllfre843u3VPtuNIC4apR7V5hz3+sw21bgqnum3C9IPtFB8VnGTsENHxCTzk5ydUSL3GeqpPXBp/YOXD9eL3BRdg33pFO2i2STo+GrLRgZjoZCl+7yGQV0/uW7rZBQbiYGzjSRbpScnv9IVn0Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BDhk/Zt0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BDhk/Zt0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfqHD2xl8z2y8c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 15:34:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb245slhRaXbuG5XgxfoWQ7xMUSsZQmWmMX3O/Chu6/t3j/Myxa2/uWmNPxAvK4R5TAGNyQ4xFkPDq1XL7fgU3prr+WLZn8ebS2Elow/e9II2LwQ6WRo0SoUtQUNygZaEK9kT57P3wUhrZpdeXc/6HBSJbe5s1To38sn2JuYLfVIVZ5HGkFd4O/G37qEJfSQoVlG9oW162ixwfbr7KXHg7h3XqaVkQZG7065kOatqgTbf7JxtStcGP29gVD7q1sPv4ZDxgiBnS7mdj+1k7qBM/CohJVOHt82QDlTlJzWoSRpBmIKqhlRlLC8S4IZwcLEBTedna6cXlTsc0TZKAAVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmXUshcSAPWCHNFeuKN5VT32WbbKAccXyzAuGzO7zRQ=;
 b=GpdNYZokyus3G9+/vtypbLkICKLlMHi5cULh5Pwk/35UiTzP/ZUoIFzzKfRAaLkm+tvsaeWSq9Vus94TAZCB4c0ecvGz4uqA1BtysCbfaPtMX7YXbwKCNfjK4E3+qW8tALCP6PnDPLHJwc4zbRE8yUhP08/ZnxFMZzA2GDkbac8VR+JkpRGMKXa0cu1l9FQ7xANo0AMm/rjZ8AC0XJw+DHQpgNSLm++9uGf8FFFiAxuxst+G0J6my5itwQZOXnA+obDIoioW5rYaqtekSY1luKcpykiDqz66//3CNDq9iGQJmufu1YURUbFFZj7Z4o0azSziUEu89VtfnboFQDqyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmXUshcSAPWCHNFeuKN5VT32WbbKAccXyzAuGzO7zRQ=;
 b=BDhk/Zt03vJtTQrYHcNFvbrzGjUF+8/RBRn6l4Uud1Q/Clzxx8sgHmwWep0U5/xhUB9HkjB5yw82Q+6OCx3ke+W9GonutINML+LBYvcfFSD6n1kpcXP7AA13swfjGkA2z10pvusovwVgirsWIdILYqeEmGcWB5W4V1sv790B0FZoK1eNuM7Hp5hnBz9dz5EKW9G0nlhTjrY7y9Q2dj42PITo5wfr0+4OYINUmhuKN8tjcLcXyhwTaVEBzHJXipuOVzLmwqJc6XtJO13SxDa+VBXVDd3B9O6mk2SrELRHSYH4S7ok/iWem0twsXZPhdYWa4ziCmbGmcFRhaY1VGxW/A==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by JH0PR06MB7268.apcprd06.prod.outlook.com (2603:1096:990:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 05:33:35 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 05:33:34 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIDEvOF0gZHQtYmluZGluZ3M6IGkzYzogRG9jdW1lbnQgdGhl?=
 =?big5?Q?_AST2700_I3C_controller?=
Thread-Topic: [PATCH 1/8] dt-bindings: i3c: Document the AST2700 I3C
 controller
Thread-Index: AQHdOgYGnk2AFkBmnEiGGqUqF4qN8ba6MFyAgAuTjww=
Date: Wed, 9 Sep 2026 05:33:34 +0000
Message-ID:
 <OSQPR06MB7252E8C6F9D3FF0DFB318B848BB02@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
 <apc4Xxv5F9jwAHxC@lizhi-Precision-Tower-5810>
In-Reply-To: <apc4Xxv5F9jwAHxC@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|JH0PR06MB7268:EE_
x-ms-office365-filtering-correlation-id: 09b2c89d-29c8-4f20-9977-08df0e33e45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|6133799003|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Db7CJ8tEwI054qCbSXVU/p9oZcFjqW82EzeKcCF8nRveRXi1kVJ42z0cl4wWeqSLgGZdnbGXIN3Kwyt3eU6089BPj0E1y8DFpBTWZtkOf84crrdBFCs4tWqEyG0wOsTWbsLLVJvM7hSocwq1kU3e3gcVDuSvAOR5c7B579ZkXnbkFSnHbPh8UBllCaZC9Lt8pQ9B3Q6ZUSBQOi1ubwL4eNNAAdoWVDguS/3nYGUDSlA8FsSB1sipbBPtQ8fwYyEj19jFtjIZ9Qq+FbweSAHv8Hg/o279cr3sGIECqbC7I4o7ZdnnUL3wwCsjCau3sU4z/neA7QXcokRW7zfZef/S/doO1/Shm3pZfs56LSex037K6OLcdUzoRKJrmAt5HhefUBumsdqVksLxhkkGRipHkDbdhmk8KQCrEorZzOzxOD5YgKlcdeyvDkl8ettfAOZfPK6FOXejy6wTHnrTo+9PfJaaRSetxZ3MfNM2ph3fEoDQ6GDcMk1H/dyjO6v3VPbgXtJphf+42HC4QOEpg2F+4JbS9RfPWjskGrAyN1SjmFpFBtw3TQacz5jzFZozcTX4r51a8PGzdog8QUkXmlJ7+v7J1H8VmWiEU9TNst/IyufwoVtvQAvvZe2Nk7w6B59GjM6L4/M78DAHz0FaNj26JLwX4OhI+Rdqg1PayK7BOICQeW29ZW1LPEQm8a8SjH111KYp6aMZyx8xMsvIyM8LUsNYMW1o/tBcwEuU9QX58ro=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?WTFiTUhZVC9zNzRlWGwzUzBwOUpYMHArTEhjaFEySXByVnQzMmtrRHl5UjlJWkZT?=
 =?big5?B?S3MweENDelVSbmlON1pnVkxLRmhwWEh4WGw5S21sSER1dEFzUERzelRyVFRYbXU0?=
 =?big5?B?YndUQUhnbjNpUks0dkZiTUlqNm9Tc04vQmJjd2ticzVBMEUvM2dpSVBZM0xPU1JD?=
 =?big5?B?SHNtVm5SNU13dEI5MlZZdnpBY0psU2pMNmV4R1lnQzRlUUxiWkk1MDNHN3pqNHhI?=
 =?big5?B?OUo3YWIwT0xKemlWSDgrY20yVEREcEdsZFAremE1UW85WG02UzBWT2JvU3BWaGsv?=
 =?big5?B?eG0vc3NIMDhsOFBZM1BTTGFGRDh4cnZYSy81NVlsVWROZlYvNDEwWGpQNkNCMHdZ?=
 =?big5?B?b29YSkFhZU05cmNqVVBnOGdrQ2NRM01mdEhPb2k1SHpncEs0TW1hZGtMcG5iMXNE?=
 =?big5?B?VFljN0ZFdHBVNkhNQmdnTHhMeVVwQVNGeWhHcm1PNUxLUklQZkpMckJQb0JaSWJP?=
 =?big5?B?Zll6eTM5cDR4YURyZnpUb1pPSk5Ib3dwZ05vZC9ZMm85em90a0I2enZ1TFdZNE5B?=
 =?big5?B?dllFUzY3V2ZNb3ZaNkNKQjZOM1Yzdm1odmZKTnlrTFVZYjNvd0x6Vll3SnZ6UFc0?=
 =?big5?B?Tm9RRlZKbzE4RGxXS0xTa01SVTBZZ0oxZXpHbnhjZWgrUGFTbUYvdEFQV2paZkNW?=
 =?big5?B?NFhoUGNnakFFbUQyd1QrazVqeFdqYjdxYW1xeTB3cDEyUDFKcStFKzk5bTZoR255?=
 =?big5?B?SzlXcDdUbWhieW01TTZXOFVDUFQ4Um1nQWdjU1BpZEFEQTZsanI5YkNjalJoNlRz?=
 =?big5?B?VWU1UnRXbU5tdXZRWXUycldzREw5WkEyaDRPNU9SK1BjRGRWT2U1SDBNdHgzZitJ?=
 =?big5?B?NEtrOEdUT016RUc4ajM3T3dHUFpRRGFZblRJOTE3eFB6L2hudVFZWFpvaERBeVJk?=
 =?big5?B?ck45d01CUTJwenZFK1l6TnRRWEI3cVcreTBUbnRMcEsxMHlaY0REd012TmwzaThp?=
 =?big5?B?T0lGcjA1VkpBNlRicDlZVkV4eFhOdnRGWDFra0ZxaVVlNkNXdGp3djV5bHpadHNk?=
 =?big5?B?WW1WMzVQa2hZTnVwNGJlbWc5R3ljRXBWbFpzK3RsejNjd2pOQWxWd0lsaHdRM1Bk?=
 =?big5?B?WkZwVW9ScHlpc1BQY0RYYUVpSjZ1NDNNN3ppVVhUTmJIbEVGTVY5K1BoU0NhNUpn?=
 =?big5?B?WDZmV21EOGxmUXcxaGFZY0JENWxLM2V6cjN2eGJHM1JLUkdDU1YvbThQZHN6SUk3?=
 =?big5?B?bEZ0MkJYeE1WeGROVWxxdFlNQlIxby9oWkxmcm5WQkg5SFZtZGRPa1lqU2RGOWN4?=
 =?big5?B?b3h1NE83SE9hSEdTNzZwTEtqY0d5UWN0RGwvZXJUQ1Z6UHdXUTVFNklic3ZpYWxk?=
 =?big5?B?bWVKdStndGxiSmJzM1NzSjBHcTVMOWFqb256blRBY2p6QTdrdXpMcnUwcWYvTTg4?=
 =?big5?B?NllQc0tScnpQcXBKSkNJODRWazdZQ0Z0b1FNTkpOaFpJejcvS1h4ZjNnYXYyTm1n?=
 =?big5?B?ZGU2ckUvMWlWSjVZaklObHhsQmRxQVdRVUViemRKZFkyZEhQZEpiV1ZveVEzZEUy?=
 =?big5?B?SThPSHQ3WU12TWJxbUZHZktNNU96Ulo1U1R4d1ZiS2NLbTU1OCtEeW9sNHdjTUdw?=
 =?big5?B?NUxWcCt4ZmhnWm9pN3Z3V2R1SjhGZ0RuV3Z1NXQwTDV0NVhaT0FmT1R0azNreDU0?=
 =?big5?B?eUxIZUJvMTJNOUFOVDFTQW1IY2ZQS202bVE0R0luekYya3ZDYmZjcld2Qkd6NzVH?=
 =?big5?B?d2ZFSFNYc21tdGZsV3BBNk9kczlyQ1hUYTllOFUyNi8veER6bitTNlRoMGw5VjdK?=
 =?big5?B?K1N1b2VDT2lYdE14UmE1WEFnQkhjeWgydDI3QXUzNlEyZW94VGt1SEVINXp5Qkky?=
 =?big5?B?N1NyNWZkQXRUMjB6TDRWNE9vbytmR3N6QmE0N0tlZkNyanlDbTc5M2NuN0hiV0d5?=
 =?big5?B?dHNZQXFHTE9IK0I0MUpnaUlKcjRVRlNNdHBOQUx6ODQvOXM4OHljdnF0M0JQN2Fn?=
 =?big5?B?NkpzUjh5UmtuWklFd3k4QkFNcVFsd29vWjhPN0hqdHRZNWlES2hMSkFydEl3WnRn?=
 =?big5?B?dXIwc1YzNzQzUklXNGdCdzhGSytIV05OMkZ6N2cwa2t2eGI1UFd4Q3BHa2hJT0tH?=
 =?big5?B?SmhhZ2NnZkpWSWhrRHg5ZkdzcEFmR0ZGT1Zzb1RZYzE5VXRqY0d6dS9Dd0l4R0Nj?=
 =?big5?B?WkRLOHNZSXIvRFVnZHBJbVBmWXRhOEsvUmNLZmZMT2kraTJjQ3JGdjdQU2RxbW1u?=
 =?big5?B?d1VxYmh4MHorQ05TTHVsblA3NFFlQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b2c89d-29c8-4f20-9977-08df0e33e45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 05:33:34.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPaRpDfglVLeTjO4267fDlyfDJzZkGHcj+UyCkI1MiWhlPc+lhxkhDRUM90lTgQV1mre6R/+YyBi516hLF2BrXE8f027HOEThjhslod9dT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7268

PiA+ICsgIGJpYXMtcHVsbC11cDoKPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvcGluY3RybC9waW5j
Zmctbm9kZS55YW1sIy9wcm9wZXJ0aWVzL2JpYXMtcHVsbC11cAo+ID4gKyAgICBlbnVtOiBbMTc3
LCAyMzEsIDI2MSwgMzE3LCA0MDAsIDQ3MCwgNTUwLCA2MDAsIDc1MF0KPiA+ICsgICAgZGVzY3Jp
cHRpb246Cj4gPiArICAgICAgRW5hYmxlIHRoZSBQSFktaW50ZXJuYWwgcHVsbC11cHMgb24gU0NM
IGFuZCBTREEgYW5kIHNlbGVjdCB0aGVpcgo+ID4gKyAgICAgIHN0cmVuZ3RoLCBpbiBPaG1zLiBI
aWdoLXZvbHRhZ2UgcGlucyBzdXBwb3J0IDQwMCwgNDcwIG9yIDYwMCBPaG1zLAo+ID4gKyAgICAg
IGFuZCBsb3ctdm9sdGFnZSBwaW5zIHN1cHBvcnQgMTc3LCAyMzEsIDI2MSwgMzE3LCA0MDAsIDU1
MCBvciA3NTAKPiA+ICsgICAgICBPaG1zLiBXaGVuIGFic2VudCB0aGUgaW50ZXJuYWwgcHVsbC11
cHMgc3RheSBkaXNhYmxlZCBhbmQgdGhlIGJ1cwo+ID4gKyAgICAgIHJlbGllcyBvbiBleHRlcm5h
bCBwdWxsLXVwcy4KCj4gdGhpcyBvbmUgc2hvdWxkIGdvIHRocm91Z2ggcGluY3RybC4KClRoZSBv
bmx5IHBpbmN0cmwgY2FwYWJpbGl0eSBvZiB0aGUgZGV2aWNlIGlzIHRvIGJpYXMgdGhlIHBpbnMg
dmlhIHRoZSBQSFkgcmVnaXN0ZXJzLApzbyBkZXNjcmliaW5nIHRoZSBkZXZpY2UgYXMgYSBwaW4g
Y29udHJvbGxlciBmZWVscyBleGNlc3NpdmUgYnkgY29tcGFyaXNvbiB0byBhbGxvd2luZwphIHNp
bmdsZSBwcm9wZXJ0eSB0aGF0IGFscmVhZHkgaGFzIGFuIGFwcHJvcHJpYXRlIGRlZmluaXRpb24u
CgpJJ2QgcHJlZmVyIHRvIGtlZXAgdGhpcyBhcHByb2FjaCwgYnV0IEknbSBvcGVuIHRvIHJlY29u
c2lkZXJpbmcgaWYgdGhlcmUgaXMgYSByZWFzb24KdGhpcyBjb250cm9sIG5lZWRzIHRvIGJlIGV4
cG9zZWQgdXNpbmcgdGhlIHVzdWFsIHBpbmN0cmwgYmluZGluZ3MuCgo+ID4gKyAgYXNwZWVkLHBw
LXNjbC1oaWdoLW5zOgo+ID4gKyAgICBkZXNjcmlwdGlvbjoKPiA+ICsgICAgICBQdXNoLXB1bGwg
U0NMIGhpZ2ggcGVyaW9kLiBPdmVycmlkZXMgdGhlIHZhbHVlIGRlcml2ZWQgZnJvbSB0aGUKPiA+
ICsgICAgICBpM2Mtc2NsLWh6IGJ1cyByYXRlLgpbLi4uXQo+ID4gKyAgYXNwZWVkLHNyLXAtc2Ns
LWxvdy1uczoKPiA+ICsgICAgZGVmYXVsdDogNDAKPiA+ICsgICAgZGVzY3JpcHRpb246Cj4gPiAr
ICAgICAgU0NMIGxvdyBwZXJpb2QgdXNlZCB3aGlsZSBwcmVwYXJpbmcgYSByZXBlYXRlZCBTVEFS
VCBvciBTVE9QCj4gPiArICAgICAgY29uZGl0aW9uLCBrZXB0IHNlcGFyYXRlIGZyb20gdGhlIHB1
c2gtcHVsbCBTQ0wgbG93IHBlcmlvZCB0bwo+ID4gKyAgICAgIHNhdGlzZnkgdGhlIE1JUEkgSTND
IGNsb2NrIHN0YWxsaW5nIHJlcXVpcmVtZW50cy4KCj4gdGhlc2UgdmFsdWUgaXMgaTNjIHN0YXJk
YXJkIGRlZmluZWQgdmFsdWUsIHdoeSBuZWVkIHB1dCBpbnRvIGR0LWJpbmRpbmcuCgpUaGUgZGVm
YXVsdHMgYXJlIGRlcml2ZWQgZnJvbSBpM2Mtc2NsLWh6IHBlciB0aGUgcHJvdG9jb2wgZm9ybXVs
YXMsIGJ1dApib2FyZC1sZXZlbCB0cmFjZSBsZW5ndGgsIHB1bGwtdXAgc3RyZW5ndGggYW5kIGNh
cGFjaXRpdmUgbG9hZGluZyBjYW4KcmVxdWlyZSBkaWZmZXJlbnQgaGlnaC9sb3cgcmF0aW9zLCBo
b2xkIHRpbWVzIGFuZCBTVEFSVC9TVE9QIHNldHVwCnBlcmlvZHMgdGhhbiB3aGF0IHRob3NlIGZv
cm11bGFzIHByb2R1Y2UgZm9yIGEgZ2l2ZW4gYm9hcmQuIFRoZXNlCnByb3BlcnRpZXMgb25seSBv
dmVycmlkZSB0aGUgZGVyaXZlZCBkZWZhdWx0IHdoZW4gYSBzcGVjaWZpYyBib2FyZApuZWVkcyBp
dDsgYW55dGhpbmcgbGVmdCB1bnNldCBrZWVwcyB0aGUgc3BlYy1kZXJpdmVkIHZhbHVlLgoKQmls
bHk=

