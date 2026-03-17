Return-Path: <linux-aspeed+bounces-3704-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA7F33817
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 08:41:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZlmC5ntYz2yhX;
	Tue, 17 Mar 2026 19:40:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773736859;
	cv=pass; b=Fs5cAfW46ENnk4xDawBuaI8BVJDtzX5mBkU+qvhEmcw3rxjp/9THrPY+EOwsEovoYNXrdmTZMk2EIq7HJAeVnQ0ABGBuKHWgVWDbAaYh86uChbd3ViakpqgY/13fendSnHHOaMVrVQ1duR4OjghGhMxghdSKEOx1476Grtgrz3vudvTHU61vZ9a2h89WL7b8PM4UZpcDYW9osC/8AP7EO5meqEPqMvfR/zHkYna/aHJbqXuuRUsweW6U+cm3eMB7UqxviNt8pb2E9qmwQ6oqqh8w537yT3UxJZOhltJ9g1Epec1aj6V3y2U/AVJCZhO+9NssbDdxiBSoDx0cLpZ7SQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773736859; c=relaxed/relaxed;
	bh=5cJjpLRNhPfOQR3mdkN9Bq8096A1ENNd/9iky6J4ou4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UeRYhh+mCYJ5GCljPOCJgLtactbAB2HsgAbg3uk93clJm+KCESFGtXT6rhx7UvBrCnOjXlpYr9BWu4kkq/gdrezD4lvtqkPtf4buHYfDOIxoBnmlIA7Xwi7HbDIcp9VqQbcZrskXvDb3WZjEiqHzszK9ZYoWDI0b8n8d8Cgk8O1TB9i0vvLZLKB3DT+THSJWb+jZbRZPB9ylRzk1tyzZUhhDFmYHhJw2MVeBZ4KXawyD3NOxQCDYmzWyg/ITag8yJhyJj48QSjiA/+f/HQDkuKGB15HBvxh51F5c5XclYAIonxfUKxITYItTEi4LwElHi3h/A2++ON7w0HH4WU3/QQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KdQPkhZT; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KdQPkhZT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZlmB5gmnz2xb3;
	Tue, 17 Mar 2026 19:40:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRWG01DsVtN5Q/zR9gRhP4v/9hShgt6C1N6Te9RaOAsPumFZnHjrkINI1BFNA0ZoJlpoF3CLlMvi7IPRmVxEgAzuk1A0oGgKrueRS1Vrg9yept4RAtHE5GmvdgRrnOLK8bPdPsHxfj2esMQrKJ2ZXauLeExZ01qn1CKzK7lbOtTJ+fE17w45BwtAJP6f+MNe2q61SMlVhvY/gNfHgjq/fwR6JgwZw/XnXUdBMMpb8LpX3hI97z1fzlqvkfRJT1pcjlnU9Ulki3pKaLl9EEAON70GH78mmKhzd2a9e+hjdVR7kTO0Ua0NYDU9PNTWGtFemMTte0AI/a/d1TGZCwKxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cJjpLRNhPfOQR3mdkN9Bq8096A1ENNd/9iky6J4ou4=;
 b=syI2ksnt9U40T3hZvpEpYMmTV0ELVnOu6+SRBAQmXiNMioG195EHgtLYX5xzBVKSx16Tbc9+Cvp4dAdMuOYBVwLY0yILMfkDCGrBoInnlUUmAHdx+hMcamltfZ/pTyn0Nf6h1tAJd1c3SVM2fAwQJI168cfDn1pd2n87LvsmIBKxnUWBgM6tJgJR94E+bI43dBNjdiWpW0UQLzEA5VvNpj5PGlZ/NDrpWRyn/ZFOL0zylmIxIl6rB31RUcN0BIoO4lbduRPQIleUNavs0HfwvcZi1A0vATdBaIvxQpuEoxKdOfwol1yY1ubzROpnYdeWGNt+k1wNxh1adBroPbFh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cJjpLRNhPfOQR3mdkN9Bq8096A1ENNd/9iky6J4ou4=;
 b=KdQPkhZTdBhfhwxqXoW+VEvxf45LL01oL6TUqesxYF9w20C5P/OAJjO9mmB+2Uw6mnNjQjSHFKFB0prUc77epPsKNi8afpK16tUiMe9JIKIvGplk8xspxf+NiwTnRCkiJohWZU1B79veCXEZWEs1KDhVI/DbCnVYQcxSKrEV9h8+Ci5PdjWG2mJWIuF0RAgZUXwmrbCY4f2HBpVH7Fvq41DzpUAjo5M3I5E0kqxIK5jGZD+KCGd+ywSfw8V4Pn9fPemdZNSLK/AZiXotPr1285TyIUZ+LsSBTB6PokOz9iC5xixyP3lNJqidHzEYruySOS89AHUbI61G5kSswtEKpw==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by SEZPR06MB5367.apcprd06.prod.outlook.com
 (2603:1096:101:7f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 08:40:34 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 08:40:34 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>
Subject: RE: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support
Thread-Topic: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support
Thread-Index: AQHcstFPGwF/SEG2f0uhTi+za0GMybWw8QMAgAF1xaA=
Date: Tue, 17 Mar 2026 08:40:34 +0000
Message-ID:
 <KL1PR0601MB427697CB5765BF9485EB97AB9041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
	 <20260313-upstream_espi-v1-2-9504428e1f43@aspeedtech.com>
 <0658c04655fc96829723cad1f17b3d899a1b2bbf.camel@pengutronix.de>
In-Reply-To: <0658c04655fc96829723cad1f17b3d899a1b2bbf.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|SEZPR06MB5367:EE_
x-ms-office365-filtering-correlation-id: daec7231-90b2-4e03-aaad-08de8400db56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|42112799006|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 y3deJXjSanr3f8FxkX0qJszIJeL6/SAeoIZxH7UAJzQ2OqmVLCjtIPKtccxx3vt1yxlcjb6uCxBb94pttHDg/cvlGUpMgnTqgYWqXpNvflmChE6QqmviSjOI6PC7b+nW1j9Xc6oitj/fHZ/WNXcN2bQ2BLw3tIPyMgENduuCxeRmVROdLffw62XTCcEIkQwe9y8LExaO6/Z/Gd7Q/AOIrewaQC+Ot+NSpjwimtyzg+vJB1prEkw48xxfaNN3O8fjSauB0YMqZ+DEuVGv/+U12vPykGX7Im6a2f7uWp3lDb7NY8KdTW28b5t5eP7noBUL5DpcuDrZ2TbJOVi0HpfcugVKspTReBL4QiyuNE/lNzBZU7+71vIrotHIKKggV/qzWkzsTDqlW76B1OdTcuYUKDc1o5H7ZnVXuSvsdKeA20+DA+I94L5O/hpcdeOI2nQDR5+nj/fqMqpqaAECveVjBcTPCfxERN1qfyeuKxwLJkDsHgaASuBCw8Y1Pyc1TOUjRZ66X6U0wEfw/LBrUQXvtDF4IqlG5rUOnoNaGKWAqYwegGeZQVeA6D/NAx7vzZ/dh3X0W7iUcWY1xDA2TjAUXrzSAvYxAmpjC+McaXg2zsHfCoMNQLa+lH7zCLTntw43Dno1b6U8yKduDQMQKJUA1cxGl/yosI1UZ1BGAXXsVn7xGQ3AzQ9CFVBIqMkFZUa79AkwF+3zuihI8lv6k/EEZdnftXqCcE1bUAGz5MOLn3ZCaBARsmjO+L1OGMA8l47mJxRcQ0q49zCqE8pdvazTUMG+XYNWk9yDdAlDHJ5HQo8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(42112799006)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amF1ZDJEMk15c2d3OFdrWVJjMURZZW50UUNsQlVJU2JJb21wRGl3YTZiU2Zo?=
 =?utf-8?B?NGVWVlJ4ZGZyQWNQQXJxYTZ4Y0M3RjdhRFRvYVNoK0R4QzlyVDFqN3pHeWNZ?=
 =?utf-8?B?K0dOblludHNHcjhVeTlVNlE4citBWDdKZk5xMURtalpESW5SSTNuVG1IQ0hD?=
 =?utf-8?B?SGd1Q2JKTVFMc1ZoSXl6UXlpeTdETE9NZS9YOEhvQlV2U2dIZ1B3WHBsVk53?=
 =?utf-8?B?UnFsd254V0FQQTk1Y1ZTNmRhODdSNFMrc3Z2RUFDNjZQQVYyQXpoK0tIS2pX?=
 =?utf-8?B?NE9ETUNCTjNEOGtYTVVEVy83cFVSUTRqNXJaZ1RHYkxTKzd3bVg3cnlZY1Iy?=
 =?utf-8?B?UGRUZDNuSjhiVWRpM1lRbXdtSUt4N1I1UXRvU1lTYWl2SnRHVUt1dmxOY0tC?=
 =?utf-8?B?QU5XSVlpM0hCQ0s4Q3Q4dGl4ajE0MGkvSkZYaDJDQ1VyeE1mZnNoR0FqbHpt?=
 =?utf-8?B?MExGQ0pvMGxGclV4MXFrUTBGeDBqVjZXb1JUNDAvTGhOOVV6TDlXd2t5RXJV?=
 =?utf-8?B?bksxY0ZGUC9EYzVIZlJYa25OSHU3K0JNc2tTRi9rS2xWeWp0YUg2cGNEcUJI?=
 =?utf-8?B?dTJ6MmdUNGZtRXcva0d0UnpEU0pmNXdtMWNoVW1INzdaWkNhWnhmTmdHYXAx?=
 =?utf-8?B?Ry9YV25wdVZjMnBiVWVaQlU5RUFMTzdwcW5IakNXdi83b2oyekhsQlNsOWhl?=
 =?utf-8?B?QVYvVXc4Y3B4SnppSGJUc3cvUm04TkVoRFgzam5rOG8wTXNGdGZrbmJ1ZlVX?=
 =?utf-8?B?OG0yN1VoOGR5R1NrTnI2TE05QnJuZEhjZHlzbGdGcXJKMGw2SU5ESVVMRmp0?=
 =?utf-8?B?RElGVmF0Szc5eFpQcU9FaHhFVVAvdStPL0R2Nk5pRlY0aVIwOHFpOThhcExk?=
 =?utf-8?B?aGNYV2t5SXBudCsrMHZUckhlc0RxNkwvUHB3eTNtU1RaQ0xiVHExL3l5a3A0?=
 =?utf-8?B?VzBWWHVTTVIvcGcvdHNWeUFraDlrVFl5YWdybk1Ybk9kNGYvdVIxSU4zc2ZT?=
 =?utf-8?B?OFdMY0JHY1lOSDNCUDEvTDBrQVM5M0xMbDFCMGhYL2xBODJLRVJ1K0d3MXFi?=
 =?utf-8?B?dHhsUndiUGdwMGZxaE1WeGIwOVlTcDM3QjcvTnFaaXV3cmR3R1J3WndsdVR6?=
 =?utf-8?B?ejBzOGovZVhmNFJsSE4wcGdSNGlKNm1tdVphemVKYjhIcExlRDVtTGJyYUpV?=
 =?utf-8?B?SEhIL0VIWjkycDk4VXZCRUpPMHB4RUEyMkxzU2hMeWNxTk9iYXltVEJrM3ll?=
 =?utf-8?B?QTdnb0RoZUZhWDV2V0g3UEtMZCs1dXB0THNjeVFEbXFXbGZxWTVHTmVwYkw3?=
 =?utf-8?B?Y1R4Sk54c2l3OHNENnZPdjJRMmNIZTdxTFhVLzRLQVdnYXNjbVc4bE0rSXYr?=
 =?utf-8?B?TlMvdzhIMEIySXY2UUJQOEh1cXB6Y1crMm1OWEFoK0VKTFlOZzVvQVJnbGtV?=
 =?utf-8?B?NUNVZ01SL21OUXdtMlhsYnlBcUI3Y2EzYWFCTUtrTVQ2cUovcytrNmNOS1d3?=
 =?utf-8?B?SmppWS9oR01LY3VvTzJkVlM0cUFtaEZVQVhyUEhYNmRMZm0weGdUSldEbHBj?=
 =?utf-8?B?ZE1QTnhObDhGQnVMRS8xVklxVklwV2NFUWdDZGVEUmt3WEUvQ2NaaW0xd2Nz?=
 =?utf-8?B?cWhjcy94Qnl1UWorZUd6YmRFU082aEtyU0k5UjBNUlNBNXROZHJjSG5RN204?=
 =?utf-8?B?bU91bi90dDBwTTFRK1R0dmtlbWRXa1dncVFJZEpwOTBDRUZTaEVNVFJUVFhs?=
 =?utf-8?B?aDdvVUczUHlPWDFIak9YSDNubUpsTDRTWE9peE90cy9sSHlvenlnVkRqVFZT?=
 =?utf-8?B?OFRycTlTMUUySHJEZjA0bjdlc3Y5NTBuOHNTVTJzMlV2UEJ0M01mUHNnb0NQ?=
 =?utf-8?B?cnRzSkxlbStmS0V5RVVJcEc1amM4MllpT2thVHJJSmt6VTdYbm9MZVNOd2x2?=
 =?utf-8?B?Z2lVVHhmK3RMN0liKzI5L0Z1b3B6Z0h5cUNlOGJKbTliQ0VRL3VrWWNucVRK?=
 =?utf-8?B?MDZQbkMyMGY3S2U1dnpUUW40eXpRdUp2UGdxL3pvUWhGNC9VMnZmU2NHYVZr?=
 =?utf-8?B?MkFPYlhWcU5hNkNIVVpLVlM0czA2TDhwS3VvQ0RWZVJjeURTZGswemVEdzJv?=
 =?utf-8?B?bFJxRkV5bzdTVFh2TFFZZVc5VkNHbDJCZ2xDVkNOT0xTU2RIM2thU2kzMWhp?=
 =?utf-8?B?ekhtSEtoVU95MitmVkZzQ0VDZ0hLT0xhbGtkTHN0NWFMTHFERmViakdrdkdr?=
 =?utf-8?B?Yld1ZFZQMHh4NTk2c3hDbjJYRjkwcFBsSm9MNkdQVktMcTh0S1lGWlpVcG9T?=
 =?utf-8?B?R0J3SW1RTTlWaHVKaE44VGZKN0hKTU9mcXl4Y3graTlIa3o5TDhQdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daec7231-90b2-4e03-aaad-08de8400db56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 08:40:34.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAYU+WmNNuawIT+S6lZbdMJy9jgmyiuBwAYMtHyteEDQI6fg+TkZCxvrDEmwY4MMXXOqkN63/at2B2C2HrX2pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5367

SGkgUGhpbGlwcCwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IE9uIEZyLCAyMDI2LTAz
LTEzIGF0IDE4OjA3ICswODAwLCBhc3BlZWR5aCB3cm90ZToNCj4gPiBBZGQgY29yZSBlU1BJIGNv
bnRyb2xsZXIgc3VwcG9ydCBhbmQgY29tbW9uIGNvZGUgZm9yIEFTUEVFRCBTb0NzLiBUaGUNCj4g
PiBlU1BJIGVuZ2luZSBpcyBhIHNsYXZlIGRldmljZSBpbiBCTUMgdG8gY29tbXVuaWNhdGUgd2l0
aCB0aGUgSG9zdCBvdmVyDQo+ID4gdGhlIGVTUEkgaW50ZXJmYWNlLg0KPiA+DQo+ID4gVGhlIGlu
aXRpYWwgc3VwcG9ydCBpbmNsdWRlcyBiYXNpYyBlU1BJIGRyaXZlciBwcm9iZS9yZW1vdmUgb3Bl
cmF0aW9ucywNCj4gPiBhbmQgcHJvdmlkZXMgb3BlcmF0b3JzIGZvciBBU1BFRUQgU29DcyB0byBp
bXBsZW1lbnQgdGhlaXIgb3duIGVTUEkgc2xhdmUNCj4gPiBkZXZpY2UgZHJpdmVycyB0aGF0IGFy
ZSBkaWZmZXJlbnQgYW1vbmcgU29DIG1vZGVscy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGFz
cGVlZHloIDx5aF9jaHVuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9z
b2MvYXNwZWVkL0tjb25maWcgICAgICAgICAgICB8ICAgNyArKw0KPiA+ICBkcml2ZXJzL3NvYy9h
c3BlZWQvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvYXNwZWVk
L2VzcGkvTWFrZWZpbGUgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvc29jL2FzcGVlZC9lc3Bp
L2FzcGVlZC1lc3BpLmMgfCAxNDMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICBkcml2ZXJzL3NvYy9hc3BlZWQvZXNwaS9hc3BlZWQtZXNwaS5oIHwgIDI3ICsrKysr
KysNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAxNzkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IFsuLi5d
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2FzcGVlZC9lc3BpL2FzcGVlZC1lc3BpLmMN
Cj4gYi9kcml2ZXJzL3NvYy9hc3BlZWQvZXNwaS9hc3BlZWQtZXNwaS5jDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjE1ZDU4YjM4YmJlNA0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9hc3BlZWQvZXNwaS9hc3BlZWQtZXNw
aS5jDQo+ID4gQEAgLTAsMCArMSwxNDMgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjArDQo+ID4gKy8qDQo+ID4gKyAqIFVuaWZpZWQgQXNwZWVkIGVTUEkgZHJpdmVy
IGZyYW1ld29yayBmb3IgZGlmZmVyZW50IGdlbmVyYXRpb24gU29Dcw0KPiA+ICsgKi8NCj4gPiAr
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RtYS1t
YXBwaW5nLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgImFzcGVlZC1lc3BpLmgiDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYXNwZWVkX2VzcGlfb3Bz
IHsNCj4gPiArCXZvaWQgKCplc3BpX3ByZV9pbml0KShzdHJ1Y3QgYXNwZWVkX2VzcGkgKmVzcGkp
Ow0KPiA+ICsJdm9pZCAoKmVzcGlfcG9zdF9pbml0KShzdHJ1Y3QgYXNwZWVkX2VzcGkgKmVzcGkp
Ow0KPiA+ICsJdm9pZCAoKmVzcGlfZGVpbml0KShzdHJ1Y3QgYXNwZWVkX2VzcGkgKmVzcGkpOw0K
PiA+ICsJaXJxcmV0dXJuX3QgKCplc3BpX2lzcikoaW50IGlycSwgdm9pZCAqZXNwaSk7DQo+ID4g
K307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhc3BlZWRf
ZXNwaV9vZl9tYXRjaGVzW10gPSB7DQo+ID4gKwl7IH0NCj4gPiArfTsNCj4gPiArTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgYXNwZWVkX2VzcGlfb2ZfbWF0Y2hlcyk7DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IGFzcGVlZF9lc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gK3sNCj4gPiArCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KPiA+ICsJc3Ry
dWN0IGFzcGVlZF9lc3BpICplc3BpOw0KPiA+ICsJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0KPiA+ICsJZGV2ID0g
JnBkZXYtPmRldjsNCj4gPiArCWVzcGkgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmVzcGkp
LCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghZXNwaSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsN
Cj4gPiArDQo+IFsuLi5dDQo+ID4gKw0KPiA+ICsJZXNwaS0+aXJxID0gcGxhdGZvcm1fZ2V0X2ly
cShwZGV2LCAwKTsNCj4gPiArCWlmIChlc3BpLT5pcnEgPCAwKSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJjYW5ub3QgZ2V0IElSUSBudW1iZXJcbiIpOw0KPiA+ICsJCXJldHVybiBlc3BpLT5pcnE7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZXNwaS0+cnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dl
dF9vcHRpb25hbChkZXYsIE5VTEwpOw0KPiANCj4gUGxlYXNlIHVzZSBkZXZtX3Jlc2V0X2NvbnRy
b2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgpIGRpcmVjdGx5Lg0KPiANCkkgd2lsbCB1cGRhdGUg
dGhpcyB0byB1c2UgZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoKQ0K
DQo+ID4gKwlpZiAoSVNfRVJSKGVzcGktPnJzdCkpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgImNh
bm5vdCBnZXQgcmVzZXQgY29udHJvbFxuIik7DQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIoZXNwaS0+
cnN0KTsNCj4gDQo+IENvbnNpZGVyIHVzaW5nIGRldl9lcnJfcHJvYmUsIHNhbWUgZm9yIHRoZSBv
dGhlciBlcnJvcnMuDQo+IFRoYXQgd2F5IHRoZSBkcml2ZXIgd29uJ3QgcHJpbnQgaW5jb3JyZWN0
IGVycm9yIG1lc3NhZ2VzIG9uDQo+IC1FUFJPQkVfREVGRVIuDQpJIHdpbGwgc3dpdGNoIHRoZXNl
IGVycm9yIHBhdGhzIHRvIGRldl9lcnJfcHJvYmUoKSBzbyB0aGF0IC1FUFJPQkVfREVGRVIgY2Fu
IGJlIGhhbmRsZWQgY29ycmVjdGx5Lg0KDQo+IA0KPiBbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3NvYy9hc3BlZWQvZXNwaS9hc3BlZWQtZXNwaS5oDQo+IGIvZHJpdmVycy9zb2MvYXNw
ZWVkL2VzcGkvYXNwZWVkLWVzcGkuaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5mNGFkN2Y2MWZlZjYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvZHJpdmVycy9zb2MvYXNwZWVkL2VzcGkvYXNwZWVkLWVzcGkuaA0KPiA+IEBAIC0wLDAgKzEs
MjcgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ID4g
Ky8qDQo+ID4gKyAqIFVuaWZpZWQgZVNQSSBkcml2ZXIgaGVhZGVyIGZpbGUgYW5kIGRhdGEgc3Ry
dWN0dXJlcw0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyNiBBc3BlZWQgVGVjaG5vbG9neSBJbmMuDQo+
ID4gKyAqLw0KPiA+ICsjaWZuZGVmIEFTUEVFRF9FU1BJX0gNCj4gPiArI2RlZmluZSBBU1BFRURf
RVNQSV9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvaXJxcmV0dXJuLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9taXNjZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gKw0KPiA+ICsj
ZGVmaW5lIERFVklDRV9OQU1FCQkiYXNwZWVkLWVzcGkiDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYXNw
ZWVkX2VzcGkgew0KPiA+ICsJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsNCj4gPiArCXN0
cnVjdCBkZXZpY2UgKmRldjsNCj4gDQo+IFN0b3JpbmcgYm90aCBwZGV2IGFuZCAmcGRldi0+ZGV2
IHNlZW1zIHVubmVjZXNzYXJ5Lg0KPiBJcyBwZGV2IHVzZWQgYXQgYWxsPw0KPiANCkFncmVlZCwg
cGRldiBpcyBub3QgdXNlZCBpbiB0aGUgc3Vic2VxdWVudCBwYXRjaGVzLiBJIHdpbGwgcmVtb3Zl
IGl0IGluIHRoZSBuZXh0IHJldmlzaW9uLg0KDQo+ID4gKwl2b2lkIF9faW9tZW0gKnJlZ3M7DQo+
ID4gKwlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0Ow0KPiANCj4gVGhpcyBpcyBtaXNzaW5nIGEg
Zm9yd2FyZCBkZWNsYXJhdGlvbiBmb3Igc3RydWN0IHJlc2V0X2NvbnRyb2wuDQo+IA0KV2lsbCB1
cGRhdGUgdG8gYWRkIDxsaW51eC9yZXNldC5oPiBpbiB0aGUgbmV4dCByZXZpc2lvbiB0byBwcm92
aWRlIGRlY2xhcmF0aW9uIGZvciBzdHJ1Y3QgcmVzZXRfY29udHJvbA0KPiANCj4gcmVnYXJkcw0K
PiBQaGlsaXBwDQoNClRoYW5rcywNCll1biBIc3Vhbi4NCg==

