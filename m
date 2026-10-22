Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CB606A319
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Oct 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dsEu7+9T
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9jfd6V10z2yLY;
	Fri, 23 Oct 2026 10:54:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792713241;
	cv=pass; b=BYxvzEOBR4bZAwSuk8vO/hUPxfI28xOJVwkuSfSgVPnggxaRW6QoFiV1CPfccGbbx7rpI9P1k1XkOWfIDwzaaS1jbJZUiNdn7ydvsWnro7JHkc0I+UywB6tPgeHA1u1OMlWYeMJHLOMJOfOJTgosNHUb5OivNS1zXAKSXqn3A6Qjkgzt/YRLlDbzfKN5S9MDmd4h3eSxboaWRiBnkYn3ywPek/4WtJmlP3FsrptQdJKY8PXAGpPZtMCxD1S2W7JJ1Hav0a3+/gHrS8jcUD4305e1CJctgTk0neud2Yi1SA0swniIa3lIhHrrdRSsa9hPysNYg0J7qAMn3HG6P4IYtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792713241; c=relaxed/relaxed;
	bh=HxL9ZFHLu2qj+okLrOoBIGsQmm5PRgr4Ouyfo6vN+8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kck3E3LNd0Q1dca0I/qvsVHKAWr71NO1othY4mc0GgIbcgqNbnQk+v4b/2WSKHLCvi8Hw8ZvGOa6TTfC0HpgMrJf3iMrHXIyyVFwIe0/+1/6Te42ohvNj5hlCyxIVwUpBa95V/s3y6SLqt79ULfx/rsqhTVvgyN4wuMe1hqWGaGU6KaRE4FrOcwu+i39Sg0Oer64OFgPy89+Q7b2p4ghXGC55kOS1zSCueCWBRiFpefzwTmJHHQQMJIIaWnZUpJTb73pCUya+YtlEyXF8qJl/lGZaRs+ZqmARY2pVdiDTIzPS3AhmHWFYS8YRUbkqva0C8qvnmEOP3TOJzWue9hSbg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dsEu7+9T; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dsEu7+9T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9jfb750Rz2xJF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Oct 2026 10:53:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8VUJbLLWwl/fW0cfYcLAFKQo3kt4hfnGDBT7vnNSa0mCcRKqI5PtgQu0hAV3ihJ3bGrr3GE2FvkV/E1xmmORdxpgG9G402jMytf7PWExMpFPOIEWROtMa2V99tIQBwyOFIg6d8d4CtBN/bnLMeh+CdMiW4b3rShiF+JanXUJNoomNu9GQF2pq3rUkcHGa5cQEas5T1BHrAEzyM2QQCeFJqP5MDvvv6snROcLGakzOqcoHAM0JJqthtXYTsJTmZwt086kwcTwYEosCGVE7whbQ6KnPq6L0Ka1UIcuV/DBmei7ICPOJnn80heHxsmMa8v6TlI+etFJPqLNWzaeGFPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxL9ZFHLu2qj+okLrOoBIGsQmm5PRgr4Ouyfo6vN+8k=;
 b=scwadCiCGNvBygctrhKzipleo5tD/K6bSNAW/omhrkGnrIYdbWNrDlh/rmcuS47kh421Rvhwdyq/0SbMut/WSy1qqeKIDVR+C9acPEg9zhnJD6R2eY/APnKIOYF3boZ+LAyWaYYI31+8U0yRgD6Kh7+hDBxSEoeczwTixP/VoCvbCzoVNM4zx/9xYkrkFholE3qAa55dlem7ACNzvUjmQ/BP16qgjI6sYz/1y8kiNolM6urYvW0ipMFO3eRcH22zWovY/1gjkPlH6Yhu+Gj73+oj0rB1gq6U4Lnx/huXhfjqx2NgNLEQaH52y9KYTrd2BfBKCtTsV+i/u3Ebu6AC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxL9ZFHLu2qj+okLrOoBIGsQmm5PRgr4Ouyfo6vN+8k=;
 b=dsEu7+9T1BYoR4me822MGaEMEPqnBgJ9CXcsp6cFqA34tOLwChHFBT16TG8ul8YN0ZqPsEjYBwFPBEDouxAq5wO0pQFVhTMwgVzA0DJ66g4RTV1iY8dMBeZUdnrUrLd83A/BaH0AbHRWbCfttHiJ2G/zZtLvXJOZHFc7+MAo8t3wPoJ6d2BQb9ioqN6/6NG4v7ES0anm4E5iFujRSZnvxi+6EVKCuf6RNicL3P97AVuYfO8+S40y3Qb4bOsm9la6jlZWDJX3d7Mu7gYVk0+Z1Ep6YsUcB9ByRRSpPBLZfa9u1ln9NCU9pr+BYw43/tslMPl2xYWcFxIdNhoUk4L/AA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6306.apcprd06.prod.outlook.com (2603:1096:400:41e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Thu, 22 Oct
 2026 23:53:33 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0569.000; Thu, 22 Oct 2026
 23:53:31 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Borislav Petkov <bp@alien8.de>
CC: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH v5 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v5 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdViL12A+l5SpHfkGkIr76gXxHGrcJaaIQgACbgICAAE9r0A==
Date: Thu, 22 Oct 2026 23:53:31 +0000
Message-ID:
 <TY2PPF5CB9A1BE68BD935DBEE35723B1742F2652@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
 <TY2PPF5CB9A1BE6C09C55652B1A6AA68725F2652@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20261022190821.GAatpfJYsT2fqKhk3T@fat_crate.local>
In-Reply-To: <20261022190821.GAatpfJYsT2fqKhk3T@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6306:EE_
x-ms-office365-filtering-correlation-id: 13cc7592-154f-458f-b50e-08df3097ad50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|261022105027099003|261022075727099003|5023799004|4143699003|261009223027099003|10067099003|261021121427099003|56012099006|261022113327099003|38070700021;
x-microsoft-antispam-message-info:
 9hTg4R4yD3G2q94qdAWHYq4MOLdUTaFQ/KEK73830XKk+v8YQNtbRVzSMCsbQoT6WhzrKGjm3hm99a+vrg9DzTsxShaOGkQfNlF/HG3oWNd9u1Ggb3NE7PUZMLTV5UVlqAAEDE/KQrBth62y+zhZf4qXYC+amg7p88FZSSjVR/rHq4HvGcCm+EAYmcONObpUkzpsXt0luEo453LUCd5GZQGmxMrg46LFrQS6QGw7lzTmnwESRjkCTJa9my0YttMI+mcjbW5MSSrQsfSPbtR4cErUCrhGe5llZGvj6jVG/4sqe4dq0TTzhysXEgJxx43ra5GSe6FC+TfOOwAHJwo8sfFPieBq+aLMJC2iZI/yW76COPmLc8OiL2k9WouKnp60RCsuiPRs9wAVLLqLucB383keEONtu/GKE3J+hXn8Tg+A4RF1RueCqFKoybzZ+63RKNwslSI9f/84cx9O6VDGhDPgyLOdEbMfCwnHCabW6zl/Iz8lwOfqE+mgoDawXemzhyM+yoDtwi2QSoksgDmdYOlkK0f5y2EIKrcYWz6tXRMuY3B0BdLmCGARPgPFi1xyOkMG1unbh10wcHp2uqIjrao4CqMZaqTjm+xh54DNurZfTRWpUXHjgNeG8FzJeYfQpTDbm5tO4benSDEdGEIZ5Mk/DMz800JLapj1+LDwZl8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(5023799004)(4143699003)(261009223027099003)(10067099003)(261021121427099003)(56012099006)(261022113327099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0JpSTFBNjl2bkp6Zjh5bzljeU1yM2o1U1RTWHFpM1l6MFVuSjRpU3hLRVZz?=
 =?utf-8?B?RS9NQ0JjaFdEank0R25XK0NuWGRhSm9zNWpEajVxanpDdDZ2cWVZOWRhK1V2?=
 =?utf-8?B?UUwzeEpSUjNNTTVRS3dpM3lSdFdNYUdLWHVsZHpwMVF3d2VsYjgwcTVoWXBt?=
 =?utf-8?B?a0RmN2tFU2hYL2VsclZ3UWd1czlZWWYzTGtrODFLQTB0bjdEbFVZSDNScnlu?=
 =?utf-8?B?U1RPNlIxWUIvVDZoc29haUNwVlNRRWZPam9YbVNBUnZMaldmOEFuWEJ5Z2Q0?=
 =?utf-8?B?WVNyOTlodm1qRThvQWZFdDBrVDljMWp5T0ZtYUo3eng1dWlQbTJyN2FxYllF?=
 =?utf-8?B?Qi90Nm9sMUJJSXgvWjNIaUg1c1VXckxab1kzZmNXSDlpclFHcFJ0VC9ZTFh5?=
 =?utf-8?B?amY1S0JWaWw0RG94SHFUU1RsekNPOGsrVEE3eW5iMXl4aTN4aHRRaWFObkha?=
 =?utf-8?B?RGplQ3d2Nnk1b0lIOVZoVzRZK1UwdHpPL0JoWGo3cG5aWktjYk0weDE1bUxT?=
 =?utf-8?B?UXQxRjhHcVhYNi9Ycngxb2hQbDFlZ3IzYzN1UkdMWVIxYVVLZDRIcmFOOGpF?=
 =?utf-8?B?ZDhPU0VDdlNzMEVpNkJPdkVETVZtN0g2bUNVcW1ROVBJRE80YmZBVUkzQTB5?=
 =?utf-8?B?UFFMMnZRcWlJR1NpdVUyUWxDd3hxUEFLWGx5L0lGcmk1OVJ2YVZHTlRWZ2Zh?=
 =?utf-8?B?OWdYVGZGa1JaMkkwWmVqUnZuNEtFRUQ0WFo3bUxaemh2THBTMDZDcXJJTW5p?=
 =?utf-8?B?KzY3bmZ0MTRJK2FYbWUyVW56QWNSaVNTN1RMbzNZaUFuOCswWjgxSjA4RkFC?=
 =?utf-8?B?aUJ0THhxSEl4czlSY3ZJL2dWTlVqeDUzMEJERnQ2UmlsYTdOZUVmbEhZd2U0?=
 =?utf-8?B?NGZOWnpFTFIzYm1OR3VNbUxuTC9heEFFeVBGQWFRZFlEU2J5OHN2WEhYdUZn?=
 =?utf-8?B?dWRaTU9ZdTlCNFRJZndkekgrNkQ3YWxTQkNrOVJOUkpJbk1Kb3pqdDNKay9N?=
 =?utf-8?B?cHR6N3d5OTA4eHdKSXRQRnZQd1BwZHJSRXNKRTcvZXFibGVjUUxta1pBeUpF?=
 =?utf-8?B?eElBbUJGQVoxVDVpVVJyeE9yVk1uTGJkcU94SjlnZzB0dHhVd2cxdG1uWFZQ?=
 =?utf-8?B?SFVuVWwxWi9nK1ZYeFlDMGJLbjduNmlFQTJjaGlDeVVYRTVzN3k4QlZROTZq?=
 =?utf-8?B?dkVLSmVoVHlEcTFkMk9OamNTaEtMRW9FdFY0QTRadjl4K1dINWQ1YVljSnJP?=
 =?utf-8?B?QUFwRGtwRjFPVld6ZEQrandlYUE2RWRCc1BoU2VrVXhEeHlNdUEzWFNsTWRn?=
 =?utf-8?B?ak0weDgwZmtqaE5RanNueCtySmYzWUZnZkd2MkZmbEZKN2hWTGRZemlVaGRU?=
 =?utf-8?B?NzBzV1o0cFcySlF6ZTZWaXJCQmFOcFNtNU9UbjdEUkxiQytlNVF4bFMxRmN5?=
 =?utf-8?B?MDUxNHVxdWs4NEpBY1k0N0xiSFlyR09NYWpLVk5GTWtZMC9lcEVBYVptUFZm?=
 =?utf-8?B?YU8vSGViUHdXKzRUTzZ1MENxMlhjM1VSWmlidFNSK3c3YjFBYkpObGIrZU8y?=
 =?utf-8?B?clVjbG50aktoSjJXclFvQnRPdXFrWnlRQlFEWE13MWtKS0lOUERFZU9kelZo?=
 =?utf-8?B?VlBxdDhIa2RRak1mMEVDMEVRYmdidGxBZnA4SGY4MUQ2MXlkV2o5SXZnQ210?=
 =?utf-8?B?Rkk3cXNEczJlRjRvVWZlOHdYVTlWa2xTeGp1d2lTemRHaXpIYUlYK0NvR1hL?=
 =?utf-8?B?Mk1rUUhYMG45Mlg4ODZybTlOUjBBZ2toaUxsazgrZFUyelNBbUxBY3NPSitj?=
 =?utf-8?B?VVFiYUVDeW1ib1R4MFU2M2pURHpXZk1mc1BuWTVkWWhXUkdPdmpZQ29sdXlm?=
 =?utf-8?B?VHA3OVkzMDJmS09MY25MRlFzeGwxZjVyRUFLUjkzbHVSdXBZN1BYa0NXK3dM?=
 =?utf-8?B?RWx6NmIwelBva2VCalJrQXlwM2RVbFRCRlFUUzVIc2xvbFJ0ZUJJclU4WjFS?=
 =?utf-8?B?dlU4Q2hpcnVDTDFXY3ZCZmpTb2ZkeS96QVNtREdmbVNMUWh2bXpLcjBrOHoy?=
 =?utf-8?B?OUY5SEsrYXlRQUJsUVAvUmsvOVIxVHowNTIyYXpZNzgzbkJHRzVoRThWTkI3?=
 =?utf-8?B?ZnNobmlSWWpTRDQxN1pmNHkzTk92Y0ZYNUwraWphbEdMdFlMNFo2U1ZFYnpT?=
 =?utf-8?B?ZUJQMWlyY3BOUFVHdlNqTEIwODlpSHBMWFNiWGxnWW13SG5FandYaThsSDBt?=
 =?utf-8?B?STZMMXNYLzVmOGczMndlRk11OWQzeEtyZ0J3VzIycGdVTTkvNStHUkZ0eTFs?=
 =?utf-8?B?aitJMGQwRnphTk51bU9XODAzYTgvY2dYRUFQYjBvRGRtUzFxQnVqUT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cc7592-154f-458f-b50e-08df3097ad50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 23:53:31.5488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emQ03ZCnkfZOqojOzTczqeyO+6NK0Nv9fxvXpabcDOxN08Qi98RGqHFdlDCarrylMz5XXD4q5xKLZkCsAqRfHjMud9ippqqlEZ2wwIM245Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6306
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvOV0gQWRkIEFzcGVlZCBBU1QyNzAwIFNEUkFNIEVE
QUMgc3VwcG9ydA0KPiANCj4gT24gVGh1LCBPY3QgMjIsIDIwMjYgYXQgMDk6NTI6MzZBTSArMDAw
MCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IEhlbGxvIEJvcmlzLA0KPiA+IAlKdXN0IGEgZ2VudGxl
IHBpbmcgb24gdGhpcyBzZXJpZXMuDQo+ID4gCUFueSBmZWVkYmFjayB3b3VsZCBiZSBhcHByZWNp
YXRlZC4NCj4gPiAJUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlzIGFueXRoaW5nIEkgc2hv
dWxkIGFkZHJlc3Mgb3IgcmV2aXNlLg0KPiANCj4gTGVtbWUgZ2l2ZSB5b3UgdGhlIHNwaWVsIHNp
bmNlIHlvdSdyZSBuZXcgOikNCj4gDQo+IEZyb206IERvY3VtZW50YXRpb24vcHJvY2Vzcy9tYWlu
dGFpbmVyLXRpcC5yc3QNCj4gDQo+IE1lcmdlIHdpbmRvdw0KPiBeXl5eXl5eXl5eXl4NCj4gDQo+
IFBsZWFzZSBkbyBub3QgZXhwZWN0IGxhcmdlIHBhdGNoIHNlcmllcyB0byBiZSBoYW5kbGVkIGR1
cmluZyB0aGUgbWVyZ2UNCj4gd2luZG93IG9yIGV2ZW4gZHVyaW5nIHRoZSB3ZWVrIGJlZm9yZS4g
IFN1Y2ggcGF0Y2hlcyBzaG91bGQgYmUgc3VibWl0dGVkDQo+IGluIG1lcmdlYWJsZSBzdGF0ZSAq
YXQqICpsZWFzdCogYSB3ZWVrIGJlZm9yZSB0aGUgbWVyZ2Ugd2luZG93IG9wZW5zLg0KPiBFeGNl
cHRpb25zIGFyZSBtYWRlIGZvciBidWcgZml4ZXMgYW5kICpzb21ldGltZXMqIGZvciBzbWFsbCBz
dGFuZGFsb25lDQo+IGRyaXZlcnMgZm9yIG5ldyBoYXJkd2FyZSBvciBtaW5pbWFsbHkgaW52YXNp
dmUgcGF0Y2hlcyBmb3IgaGFyZHdhcmUNCj4gZW5hYmxlbWVudC4NCj4gDQo+IER1cmluZyB0aGUg
bWVyZ2Ugd2luZG93LCB0aGUgbWFpbnRhaW5lcnMgaW5zdGVhZCBmb2N1cyBvbiBmb2xsb3dpbmcg
dGhlDQo+IHVwc3RyZWFtIGNoYW5nZXMsIGZpeGluZyBtZXJnZSB3aW5kb3cgZmFsbG91dCwgY29s
bGVjdGluZyBidWcgZml4ZXMsIGFuZA0KPiBhbGxvd2luZyB0aGVtc2VsdmVzIGEgYnJlYXRoLiBQ
bGVhc2UgcmVzcGVjdCB0aGF0Lg0KPiANCj4gVGhlIHJlbGVhc2UgY2FuZGlkYXRlIC1yYzEgaXMg
dGhlIHN0YXJ0aW5nIHBvaW50IGZvciBuZXcgcGF0Y2hlcyB0byBiZSBhcHBsaWVkDQo+IHdoaWNo
IGFyZSB0YXJnZXRlZCBmb3IgdGhlIG5leHQgbWVyZ2Ugd2luZG93Lg0KPiANCj4gLS0tDQo+IA0K
PiBXaGlsZSB5b3UncmUgd2FpdGluZywgeW91IGNvdWxkIHJlYWQNCj4gDQo+IGh0dHBzOi8vZG9j
cy5rZXJuZWwub3JnL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwNCj4gaHR0cHM6Ly9k
b2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9kZXZlbG9wbWVudC1wcm9jZXNzLmh0bWwNCj4gDQo+IGFu
ZCB5b3UgY291bGQgZXZlbiBoZWxwIG91dCBhbmQgcmV2aWV3IHNvbWUgcGF0Y2hlcyB5b3Vyc2Vs
Zi4gVGhhdCB3b3VsZCBiZQ0KPiB0aGUgbW9zdCBhd2Vzb21lIGhlbHAgeW91IGNvdWxkIGdpdmUg
dG8gZm9sa3MsIGFuZCBpdCB3b3VsZCBiZSB2ZXJ5IG11Y2gNCj4gYXBwcmVjaWF0ZWQgYnkgbWFp
bnRhaW5lcnMgd2hvIGFyZSBkcm93bmluZyBpbiBwYXRjaGVzLg0KPiANCj4gVGhhbmtzLg0KPiAN
Cj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9wZW9w
bGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0KSGkgQm9yaXMsDQoN
ClRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uIGFuZCB0aGUgcG9pbnRlcnMuDQpVbmRlcnN0b29k
IG1vcmUgYWJvdXQgdGhlIHByb2dyZXNzLg0KSSdsbCB0YWtlIHRoZSBvcHBvcnR1bml0eSB0byBy
ZXZpZXcgb3RoZXIgcGF0Y2hlcyB3aGlsZSB3YWl0aW5nLg0KDQpUaGFua3MgYWdhaW4gZm9yIHlv
dXIgZ3VpZGFuY2UuDQoNCkJlc3QgcmVnYXJkcywNClJ5YW4NCg==

