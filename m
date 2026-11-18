Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721A606A889
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=c7pQLX7U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTn9b4pdcz2xNC;
	Wed, 18 Nov 2026 14:28:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794972483;
	cv=pass; b=JTxmdoSQ2apNPtIUeXX76y3UxTpY00zGbAZko1XapBnQO7vMrdNytCiE12COMQL41SfU4bbGJ6dhtnLS4RCtU3yYJE/0LOTIV9dvh77wXoRr1wmgs3E/1MggOUkzco/LOrmrVMF7Z2zipwEKheki3veZ3YXmAnYIYgF+Gs9FOokk6kgN3Vvb1KZsukbaH8FCZd5aO4jXLv2+5lL9aUxRjC9NmwjyG9LtQopaKOe2GnVWEKICNM5zAFrtwc4kfN8Shk5cKxO9BbWPIzlPlhAC/ubcIr02B7UwsRxw58EXD7Jh+nsdWc12Bm5m8cR+rbn0y0e83eeB3xoKuUO3Q9JfVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794972483; c=relaxed/relaxed;
	bh=2sg2JvzIcDKUumvpFKzEXOdAWINic52oNarrsOsaJIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gueSXR5bFyiDwFUYhmYJWweQg7v8+DOOJ5VRjp2smH4YKianL+URRAlFZil2b3lP+rm5zbvswYfvmZgAaVJ1IA+9gTx0ANnZuu3QqI54V2a6J+kNGBXR+w3v8Q46gjhmU/7e4G9oTRO8TdadQiC5MMG3OrGp/22uQ7Jt2z8DJE6HQkWX+1/r+TR6r9A9yKP1B1d1n4FIiPYH/ooLqITE/3w1N77XSvkqWjCsXtS8otyCs7GzK9a6wdcOUTMkoEpesRqNB6n2Fbpy6K4c11r3RdN7MsdTimm3l/Z1kqxyF4ibzzs6m07qL5jYzLw3r4xvKOFux6Oe31VyALbn5O7LOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=c7pQLX7U; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=c7pQLX7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTn9b1Ncmz2xLG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 14:28:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TChfeJpDkHD7EHMixp0d6syyXssesFnKHx5EBn7FW5hZiy/vODDuzyXXR0AFQ+K03ooNgGb/gen3v7rCF+a9iXEUMLb7+oZkf6ndm63lAdsV1Tu3FrnvT6T4bPmj4APYDUBE51jM3CN83vB8PFF5wkLrWulmfnRnSevuSnqwANDGIqU/d34ZXMBIQK/Z1uQBQYcNbBzAKdGPrXAxdslmRAOjvxC59qf9pQSQ8SEnYdOSfIFIkhfRFFimivS0l30UKXphQ7UMxggIHozdBPaW2LbJaARxxQZLyNSmZSF0ZSEy/JlWcJZkXASbB0ejloY85uFm3F5SfdtEiHnGYxZMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sg2JvzIcDKUumvpFKzEXOdAWINic52oNarrsOsaJIw=;
 b=B6Um/zwokCTWmKO7dJyHh4q6/maWOEAcGcDcNsHABtx/4E12pXUc8+6OCXDRMrjUHLchNfZgxDTcrDP42xJoHzH3BQgnRJqpRNeAi4Z8Jc4HibcD7MLu1HWOpp5N9g/GbX4IqHIOW2JodYeShROu9Mh1QG36fmjNXfsw+oyYMVf38L9Hm9tKIx3R/mNhAGdsSLKYT4qdUhcwmBqk3hNbvqoS2P7v74RGm/ECCBW8aIfyzAidmY8xvBZEIA3HERIIExXhp6Iojf+ySp+t+UAzL3yTuHs4BsZoujCw3uo6YNQp4RdB4SvGxDKFeq4HdXAE4wGU70Km3/0y3p89LZZSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sg2JvzIcDKUumvpFKzEXOdAWINic52oNarrsOsaJIw=;
 b=c7pQLX7UnIcYPvLDZ5k3LdCYKEgFt1eZ/JjSSBFJyZBpCleLcR2vE0g7DNGArx0Qh6Qbf6LAk4K/DgA/tEV1Cjsu9Yj8Noq9TGFQT2bVxtrEuK47EQ3fkfHDOZzTRT5w4c5RfVEU7Mtx5+PBBe+gDOjHtggdBzYon956yiA2To/jzcOBnRYtHCOqCqJZxZVoPNGmuwUdE4lcKbe9b3DsGg8GfpoHhwZq3yjlWSxZwNTSsvvwoHlPvQGNjLyv+u/7/56sk+L2hXFeXqzNUe5K8Bu2XGWMYC4AL8JLS3tZXsBfrgEsMPlX6FuF1O+Gsz6uALPoxhq8efEmALMa/mpZ+Q==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYNPR06MB8829.apcprd06.prod.outlook.com (2603:1096:405:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 03:27:38 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 03:27:38 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Ryan
 Chen <ryan_chen@aspeedtech.com>, "tbevis@amazon.com" <tbevis@amazon.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIHYyIDYvOV0gaTNjOiBtaXBpLWkzYy1oY2k6IEFkZCBzdXBw?=
 =?big5?Q?ort_for_the_AST2700_I3C_controller?=
Thread-Topic: [PATCH v2 6/9] i3c: mipi-i3c-hci: Add support for the AST2700
 I3C controller
Thread-Index: AQHdcYsTnS6rQU0dQU2EMBOMr0EluLcpHFyAgAoZ20I=
Date: Wed, 18 Nov 2026 03:27:38 +0000
Message-ID:
 <OSQPR06MB7252E690688BAF7859593EBD8B7A2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
 <20261111-b4-i3c-hci-ast2700-v2-6-4d8fff5c5196@aspeedtech.com>
 <avShzxfk1kpji2iZ@lizhi-Precision-Tower-5810>
In-Reply-To: <avShzxfk1kpji2iZ@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYNPR06MB8829:EE_
x-ms-office365-filtering-correlation-id: b56bb590-5147-4aa0-b200-08df4523e59a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|4143699003|56012099006|261026140227099003|261026121527099003|10067099003|261022105027099003|261022113327099003|261028144727099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 D9wxKkMl9+TxvKPmAyZ0i8ibPeBw0E7nYeGhTdWNKWsgh7DTx5V5c1NoD80Aa0pxmTQasz1YrDDxHtWbBmRt21+5utxyFyGeX7xghZFBMCgfyJIYPCPS22x3xScvjeI1L0wq8a6mOApaGcuXq/GR06Lf0oAQISVON45EjCiotBoxLDMSGIQwhwKhgg072IC5D20zN7Ma0calhEIBAN5UWJRGXCkxg4/waA6gApCdJHCKxFpzuWU92QeMVf1JkqiWrwdhb0IeQ8mdGRBRHWqo6Cq8pSehMGoW1rREMQ9jL8d3LOm+uYF4qHLd9LA9o+IUYsjwugH4g+Jk7N7MYxKoS6MmTKdj+uULjazWpLv1Zg+P3sIaKvylj47aAM0xSNrUKZF+GgrouU4duloIitl2uvLgJfNi0RQfo0LZ7G8NiljB+DBXJsZB28f1QNlbhemX4125B6ebmghtCm/vvYN4C4nYEdY1nQAEZCsVv5RuRis/2rnDuu9+nnShtbG3fMerocRnus1T1Rtb4XpvD+3oBvLsisXmBTXmpbphzLz1+hfvwYm1pEVdGH6E57GiKPGnMCt5Q1S8UsMOYfLJjEs8UiKmRWT1YM3dIL+ndKjZn+4o3f0+UqORoLu8dA+OrWSQDWiY9NU1kCnHU7ZfrXzJFTgsL8i3O01cgSl5D3B/OvbO0R3bk33TPkCRhoH+52vgD/bn98+6d1Kk0I9wfsZ8S030JFtVgkFS8vovE0geGGA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(10067099003)(261022105027099003)(261022113327099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?MDZKZjRLTFkxRGRrVnpzc1R0RStmNllhVzBpZlM0MDZJRlFpK2d0UU13N1g3c1pz?=
 =?big5?B?R2xWZlVOM0lTck10dlIrTEdlaUlNMlBKOHp3eTBLSmsrb0ZJZXZaWGl5K3JjK0po?=
 =?big5?B?T3hrUmNVYjBkQW90MFQ5cEJ0djA0dWNtdnRzL1BxOWpmOHJIbTg5WjRLdlpjbHhO?=
 =?big5?B?NldFUmNKRzhUemlIQTQveUk5b3RUc1FDVVlPV04zRDkreDhlRVJSbVQ3QWh2OWMx?=
 =?big5?B?TFpLVEsyS0hCOU5FUG1oOWtKSFNqdWJpY0FuaWYrQ29qam5sSDhpakFLcEhzYUlx?=
 =?big5?B?T1JOZXZiM1N4R1pHSEVRdUt4U0FGODFLajBkNkpzSlJxRWVVZWt4dFkwVndGZVQ3?=
 =?big5?B?bkVuckdNWGxpQWU2SWovQTBvcmRSRlhiVGdFaW50TGtTTWlNVjNGMkJPb2E0YWw4?=
 =?big5?B?VGRGeEVManFsTjZMcGVqS3QzazRMSStXeGNXMVR6c0FDMW5pdW9aYkcvNXAyNHNN?=
 =?big5?B?SnRCQ3ZxQjFHdUhTVVhjamZTeXpJakZUY3VkUm00aU5ZS2ZHNEdiU3hHVGFBblZ3?=
 =?big5?B?aExjNGhnRnIyN3I2RUNwTzNwNHZnQUlRQnRIUE1URWhVTjRueEdTWklyNWZDT1Vt?=
 =?big5?B?bDI0SlJPN1BNNFFPUDZJOFd0ZHdQTzBHNlVYNVJhNXZqa1B1Y2MyVG1XSWFOVjZE?=
 =?big5?B?NUV0bEJ3V3VQY25NcXlJS0VWUFRYdndsQm95eFhWSEh3cjBoVTJSdFBsbFhOVmla?=
 =?big5?B?dmlYdlo3d09PRDRYTWlHcUhLWkVUbU4xZmxLTmVSRHVkVTM5bnUyMzhxZGZMRkk3?=
 =?big5?B?RGRwSGpxYnhLNXF5alMyajBrR1Z4ZXF0U0JPOWhQU044SVI3b2J2aSs0cjk3d3hv?=
 =?big5?B?Wm5VbC9uU3BNd284TlZJYk93UDM3RmV6aklKKzZGUVduMXA3RjZhVW5jYXRFUDhs?=
 =?big5?B?bHlSSXdlT1ZNa09obmFxZmNpdElqWFdVQXpGOVRkZ2N2UnRLZTRlWUtNTE5EVTB1?=
 =?big5?B?UHJvQUtQdG40cm5wTnJKTzU5ai9wTkI2eFBjZm9sczZOVjhVems4SWtyVG14V3dy?=
 =?big5?B?aEkyTGRCcjlCMlp1cXBvYU9nNU40VnA4akFrVHNDS01WSjVySFZTUjMxdXpCYkpt?=
 =?big5?B?YXVFck4vRzQxOThSZkEzS1NyKy96VllZVm55UzJZZkZXZmVYOHdTM0l2NytpRXFi?=
 =?big5?B?cXcvMG40NlRkRUtSbEVsQk9Qc1lHRnhUSTFPSExOb1ZSeGc4TTluVnFUQXlvWXQ1?=
 =?big5?B?NHZpcDUvcmZSN3NROEozNTlLblJ4R0JqbG56SVNQbEVOZ0F2NHRJd0kxOWxKVjRE?=
 =?big5?B?SkM5WXpYSm5oRStGWXZiQk5mUm5YajhaOU5Sd3pzVjdyV3BBTXgvT0kwdG1kSjNy?=
 =?big5?B?aVowVVJhTFpCUHBTUHovWWQwVmpkeFE4SENxeFAwQjRhZkY2QVNQMThiK3ZRaVgr?=
 =?big5?B?ay9FMitTWUZPS2dMSHhrNm5QV0oxTDljcFJtSVRQVHhrbUhuNGM5eWJOeHRJY0Fu?=
 =?big5?B?VndrTkwvRVRoanYzWSsrUmJUVnpMd0l1RmVzTDlybUtEVlBXZ0RoUnpkdFdPWFo1?=
 =?big5?B?V1pUUXRSeVdRT2pBY2orTEdkY1diYytPSkQ0WTRPa0VWMzVKRE4rK1BVZDhhT3Ex?=
 =?big5?B?QUJNcld4OFM3Q3BiNFptWVQwUUhoRFQ1LzMrZTZMNFp3dWpZQjJUVW91TnoyaXdU?=
 =?big5?B?RW1rN2xqK3U4Z0VDMm1Oc29Da3FhYUZ0UlRFNENNdjNsQ29sdmdjSjk0aWorczRD?=
 =?big5?B?ZDJseEN5TEVZYTNpeWg5Z0FQeHFINmVtS3JTMG45N0NmS2d6SFlIcjM1ald5N1o5?=
 =?big5?B?ejBkZVRST2dGQjFhOU5lcDh1aGQyV0ZDbDZvOFZ1bk5jcjBPcnd5aXdqdGhmZ09W?=
 =?big5?B?T2ZsdCs5TkpHMG1CRTNNbjJpN1pnT2JmZ3BJUG11bHU2QVdCYTd1cmc4OHIzK0xM?=
 =?big5?B?RU55YTBmTjhKOHo0QTdNQkVKeUhnSzR4SUNnVGt1TjZEZ3hRc2Z4YnErMHJjdEFv?=
 =?big5?B?cWtEVDdhcEIweDNQb3NKaVp1b2dwUVhyclhKYkx6UGZyYW5pU3BhT1BENmtQdzYz?=
 =?big5?B?M2c2WkNHbmd6QW5tZnFTemRDSkgxZXdSTmIvN1FuREJpcVM5M0hmS2kxbVQycnhU?=
 =?big5?B?WUpqRHNWb0dIWXpISE5qZEFXaHRvenIydUpXUHBzUGhzSHJCZEtkQ0o4ZkxnKzBq?=
 =?big5?B?Tjk3Z1J6YmI1RlIyQXh2bmd6WGxmTFg2NC9ESHd1RC9TSFF0VVlIaHdJazQyM2pU?=
 =?big5?B?eVRmd3FpWG93eE96YkErZk5ZczlDQT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56bb590-5147-4aa0-b200-08df4523e59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 03:27:38.8094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLJD0HWRJNwT14trGkiIoWDoP/owRPiLfY2eDxg1STqjpyIdTKDEWg28A5APF2AfeeQKU4bbX3ATFyg8CHTl7rv88kVZkHdN0h3BtRNZSSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8829
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiA+ICtpbnQgaGNpX2V4dGNhcF92ZW5kb3JfQVNQRUVEKHN0cnVjdCBpM2NfaGNpICpoY2ksIHZv
aWQgX19pb21lbSAqYmFzZSkKPgo+IGZ1bmN0aW9uIG5hbWUgZG9uJ3QgbWl4IGxvdy91cCBjYXNl
Lgo+Cj4gaGNpX2V4dGNhcF92ZW5kb3JfYXNwZWVkKCkKCmhjaV9leHRjYXBfdmVuZG9yX05YUCgp
IHJpZ2h0IGFib3ZlIGl0IGlzIGFscmVhZHkgYWxsLWNhcHMgZm9yIHRoZQpzYW1lIHJlYXNvbjog
RVhUX0NBUF9WRU5ET1IoKSdzIGAucGFyc2VyID0gKGhjaV9leHRjYXBfdmVuZG9yXyMjX3ZlbmRv
cilgCnRva2VuLXBhc3RlcyB0aGUgbmFtZSBzdHJhaWdodCBmcm9tIEVYVF9DQVBfVkVORE9SKE5Y
UCwgLi4uKSAvCkVYVF9DQVBfVkVORE9SKEFTUEVFRCwgLi4uKS4gQ2hhbmdpbmcganVzdCBBU1BF
RUQgdG8gbG93ZXJjYXNlIHdvdWxkCm1ha2UgaXQgaW5jb25zaXN0ZW50IHdpdGggTlhQLCBhbmQg
d291bGQgbmVlZCB0aGUgbWFjcm8gaW52b2NhdGlvbgpjaGFuZ2VkIHRvby4gSSdkIHJhdGhlciBr
ZWVwIGl0IG1hdGNoaW5nIHRoZSBleGlzdGluZyBOWFAgcHJlY2VkZW50LgoKPiA+ICsgICByZXR1
cm4gbWluX3QodW5zaWduZWQgbG9uZywgbWF4X3QodW5zaWduZWQgbG9uZywgY3ljbGVzLCAxKSAt
IDEsCj4gPiArICAgICAgICAgICAgICAgIEFTUEVFRF9JM0NfUEhZX0NOVF9NQVgpOwo+Cj4gbm93
IHVzZSBtaW4oKSBhbmQgbWF4KCkgc2hvdWxkIGJlIG9rYXkuCgpDb25maXJtZWQgd2l0aCBhIGJ1
aWxkIChXPTEsIGNyb3NzLWNvbXBpbGVkKTsgbm8gd2FybmluZ3MgZWl0aGVyIHdheS4KU2ltcGxp
ZmllZCB0byBtaW4obWF4KGN5Y2xlcywgMSkgLSAxLCBBU1BFRURfSTNDX1BIWV9DTlRfTUFYKS4K
Cj4gdGhpcyBwYXJ0IHNob3VsZCBiZSBzZXBlcmF0ZSBwYXRjaCwgd2hpY2ggbm90IHJlbGF0ZWQg
YWRkIGFzcGVlZAo+IGNvbnRyb2xlciBzdXBwb3J0LgoKQWdyZWVkLiBTcGxpdCBvdXQgaW50byBp
dHMgb3duIHBhdGNoICgiaTNjOiBtaXBpLWkzYy1oY2k6IFNwbGl0IHRoZQpjb3JlIElSUSBoYW5k
bGluZyBpbnRvIGl0cyBvd24gZnVuY3Rpb24iKSwgbm93IHBhdGNoIDYsIGFoZWFkIG9mIHRoaXMK
b25lLgoKVGhhbmtzCgpCaWxseSBUc2Fp

