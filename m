Return-Path: <linux-aspeed+bounces-1786-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F91C83F25
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 07:48:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bn5q616JRz3bh6;
	Wed, 23 Jul 2025 17:48:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753256914;
	cv=pass; b=CrPqIPlzRBhumni1DE+k4iw9jTdOTBfHuXAPJDZJDtQKUnvoRhqibV/xaPCaXAdnsjXogZXgLM/2xl10uBa4DUIihaaKNA4d7PiTKfz5v5psv+FBztvYgBRD8KEog6ElH5B2nt9NMY1UUoZcqILwz3nrQLYSwYbOn4YX/W5ZIdWccQhUxpTjVa/v2Xdn8TsKxY86eT5/2feaEjEhZFZHNy8wpf4UKUWRhDxynVwjoVoENQpRiaQJZUbJfoIlu0k0Fbj0TKI3TNI1CcOHZv+GijxvHj8bShyH1VPoOr3iINzkjscWCPzHidRWRqIyogjLQXXxAdE5qFca2/KBQKeBtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753256914; c=relaxed/relaxed;
	bh=2/ZjwqSWsHF/MwkKoDQNNbqqQE4mmFk3SPlrh5YboDk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbOv2hDTis0bvDoFfv3+1rriYNNclTV5vAPXx8riZMQD1zaB4IvD/Ncw+6hnfTeo1rwD7jEmCmyc/SSnfOoSrNLCyFM/pwpgluUSd/YEM1eXRK8BiShrio2GePwwqllIIlt8XUsRoUaAmyLwaxj/QGXp6EOCnYl+H3cqTP0jLpyuxvY11G0xouK1skrwOzQ7pJRMMW02VRr52AEZqsq8EXcRLsLyRHQZeSSTokkWVh4WBJVSLHUmhHaYUqvo3Jz562kVJWVoMQGGzdaSWJupwFD/jk9uoiClzbClA8Ivcz/c1G3Y2l6KfLv7gMTCXbqRXcDWcY0qdZgpD6gEOECCYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn5pT0cJnz30P3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 17:47:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcmYOAtOIz1gVJmPcZ+TY3HDRz24D1O4sr3YBylQrwyKHawJO2E3fpxF/DWyR0Qpqy8EdnAXi6tQOZ6C5JO5CxgjiA6G75jxlDgYncwoUMWMirwo+5LwjiF4cwlYmrdHai2biOi3mIHSxc2+QgtuZOB8zsX+6sHYDbYlTKUKjinCFsoBZ4AnVmRRTciRLxHKFCkfQYQDZl3AfEhmsPx5pUTliF7lZ+L9WK73/cKjmcsAdUl3LDtMAz5XgyvsgyuzuHNd+z2EFHvtTiyamZgWfPcLFKdv1HRdV22X787jDbhd3Rj0vktyEfb1Yijd/sO3tvyfQgcS2jJwhTlw2LJJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/ZjwqSWsHF/MwkKoDQNNbqqQE4mmFk3SPlrh5YboDk=;
 b=B6xnmBrH3TQ/qVlCg+BfVG6FUi/zt06SSiIYvtIHF/09oVAXg1wsQaJ91tLzvCKy2tN8K1WWJvWgbTBL0zK3dZ29aeEOyzJ5gk9e+dE7da0SfoGWvBe7KPRnaXy6F84tr5Z8c7YNy0taPk5cx3XL9VqGYtzAsuLLGhoo8gmphGUMyQsTcbjOc5BslK3vCmePJQ6FfxD1JElVqxMUVCmyDYxD9oA0PzVF0ROQHh+JawktB7v5XJ5oRZ5BMAQ6tQODQCWMVWetE+xlXanNtfwzR7SIV4Oy1JSddUnzg3uVKLV2Kk4zxMcDe2ametL1BQsk1Xf3FoEbDkBSlauUZFqvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/ZjwqSWsHF/MwkKoDQNNbqqQE4mmFk3SPlrh5YboDk=;
 b=jJ1FHcnrnUH3b6T0ehQRWn+Sz4vzco5RyqtbRyd7gtWhoAAsBznlXRNMRXdz2BCJYqIdyVwiKgNOO/RTZBSzPQHnFxdQk7EdW9iBEFh79eTHkH/SQOZ23JzX+ow5kEMkO9ODd9jWXlYZ4+dsfgCFx4QrgA88rNXxPM0U2N0u/hxek+fI7NLpj55g/+vGrwB0o8ogj0Sz6M1WldPbCKBZHxSBv8uM/PS43LWrx3ltDvJeUUVX4ugj+Gqh5VSw/CRBIzFMkaS9Tv6dGBT35Yp5ZHUqSd7jJRDyEvL7KhYrnSeyWWo1GEdUuOfyZjQBXHFqmu/AtOhtHAd4e6xnEbJseA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB6062.apcprd06.prod.outlook.com (2603:1096:101:d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Wed, 23 Jul
 2025 07:47:32 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 07:47:32 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Index: AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ+RKiAgAD39JA=
Date: Wed, 23 Jul 2025 07:47:32 +0000
Message-ID:
 <OS8PR06MB7541811DD845EBC36A5D7E55F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com> <87zfcws0rs.ffs@tglx>
In-Reply-To: <87zfcws0rs.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB6062:EE_
x-ms-office365-filtering-correlation-id: b02a6ba5-7929-4d6c-40bf-08ddc9bd2e8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LLdtIHUNOSNqAEI8qzwi2+rpBB2TJh26As7y7U1pRHDd2KbFwY4CZPLKoWZo?=
 =?us-ascii?Q?kUpTBs1iRl4AHZqunc0HXgzjhdm5p82CQH8eMAx3GeTSAf6BIB/3ri8xT0wZ?=
 =?us-ascii?Q?B4WsSxaPLpEHkcwTRwFvUZxC1CyZTbY2VUbQpWDUGw0+aaHV+YmpOKS7A6Oj?=
 =?us-ascii?Q?gDBI7qhoFjVtZj8TWb3FcR672dMNByxihQDW9r2pZYonG/lF0vl6InRbLkLX?=
 =?us-ascii?Q?iC/czORDfjrHJ/J+nYioRRwtE2HhomZArZhUXYO8p2Z8uuVnoIWK4FebecRL?=
 =?us-ascii?Q?WbJ/64F3j1bYo7k5MnJ6A/eLlgySlvezg3HdCg3g+GKLvsNhsahkCZ0/MMSK?=
 =?us-ascii?Q?3bm7p2YMPGao9rZZdp+enF72kjmadGYLkHOtx1G5izBbUZFX1C0Y05DCSBAf?=
 =?us-ascii?Q?F9AnFTcLDAWExAKTTCDViCGYd4T4xMdS/E832BbE+jWSdAWwxYDivrzWP+19?=
 =?us-ascii?Q?IsKDW3NwnFzKcan31232Qv8+GPq75YPM18tqmDlpn6E89KB6xjZracfhQ+ky?=
 =?us-ascii?Q?6VTNV2JFS/xE55hzDajPvd5ANiUOXI8wq5ayFkS88yedlfHPwGgu72wuCXSG?=
 =?us-ascii?Q?MGPQdzSWCTmU9DnaHxQWtbrOpU/qEXqgkSQoHw40aSssYJPc6BqXCjdZKTMO?=
 =?us-ascii?Q?+sIlL9ZN40SBvZpckENrT/nLe1YCHh2xggUo7ExqWojJdAo2HrttUpV33PF/?=
 =?us-ascii?Q?nuNIeRzqcTow4JJhgmS8DE2PAhQ3I6YP0ymokzwA4xQ8qY0xaiDFat9Rn+E3?=
 =?us-ascii?Q?fYfot/T+erIo3I0jVaMExiQzjN5CRhqNdB8gUNs4vtnemVKXziWnnb218gg8?=
 =?us-ascii?Q?mYj50aijOmNEiZk8GD/DHvLRWK274EH1He1+Fv6YvpARuqINYIQODM0/P8ao?=
 =?us-ascii?Q?E3nwZ7QCvr35s5KdH+jWEE775t0HyfKJMAZSIJSAmMNe7uI/X0Ro6D3fD2LM?=
 =?us-ascii?Q?6rPYVFsaqF5Q5hr/kB3ya0TZ4VIddBtTVLcdZNgvX8CxBtciTWEPmIBsJy/Z?=
 =?us-ascii?Q?RwjobDfa780F/YzlQKoPoUzNOj8q8kgxbrvluQpOtKnY3fVGR2+aqY+VrAk7?=
 =?us-ascii?Q?oix6g4GM94/6077BvY/A2HGD7SQbvXjO7wVYy8lNaECBsBuzRS8hFUunkVM+?=
 =?us-ascii?Q?3SYkIhIWUC2dQ3/uBMyo52VH0pmKCPFpZLhV8Gi/Mu6J+/WPPS48uBbdO/gK?=
 =?us-ascii?Q?zPEelLD1uR35ehWzyBpemkMYWMLW8xsno8NhTu2jLkFT4NmxQu8iYGv/WDAZ?=
 =?us-ascii?Q?sqhxWyOUpVjWsWv9s7QQDLXI9ndmzJ/kDsJinlupQ+ZeD1ZEdnBt5TMFP7Ln?=
 =?us-ascii?Q?JqGCUiO+CBoIoKodG4sGmTzjL3GtQaTOPQ1apm6xq2dbx2nNprrsns3c2Yj+?=
 =?us-ascii?Q?M29mWL4q9OErIPleY5ydBVDuSw1JNOjyBY+5v9nbwbep6btZ1GqrL1WJnEv2?=
 =?us-ascii?Q?GeWqaw5U2lId5dJFiDzZ0sjxW93UHm2s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xeyzy3aTA/HKtr5c3JsCkJ2NeSqxPgmkyf8fa0ABN0QAcnuDKURTYjj9s9cE?=
 =?us-ascii?Q?ThTQjzee6qG1zfUxBnyFJuTczJ2vxT8/oW5ZOxXUvdg5+dDLZoEeSCZckEGH?=
 =?us-ascii?Q?dU6bMTrCQGAIi0mvV2Qim5Xq9yJ48vLBjsV118LPTGSOI2L/63vH6W+oqp4Q?=
 =?us-ascii?Q?FzRqtRu0FIyRuU2uGyiKJCeWGLPJdCxCqGIeSLysdYWl88F8xikuXQWL78/J?=
 =?us-ascii?Q?kWrH/+TuKX7gxuBOmOYrcMks8EcPqXJumDHAx0HS/35qy0Ho3+hioxHmTRs5?=
 =?us-ascii?Q?XLNsB2XhK4f4LgiA0SLhaY8me+vcPiN0MxwyNvDuNJpFjC/asrVNWptKc0pN?=
 =?us-ascii?Q?9uUEUKBMCpu28ieRUek/bYQeoCoNaIGcF1UtBBNOhE9lVGaFF8F/drTRc26O?=
 =?us-ascii?Q?sz4a9kh3mE5t9GBXkLq/YLckgSiGgGljYE6QNSoIkT6qsMIkivNKBuRMdpRW?=
 =?us-ascii?Q?RK9l63Z1vogIWrK+yuDruIPkTCk2xqV3ljs/ksq/m/5170BM/uud4Em0Q/hj?=
 =?us-ascii?Q?St23tVEhTcJelKFx+eNeT5qShpidGGkST7cnW5xrVod1PnEL+l+1g5VobXhD?=
 =?us-ascii?Q?MLM0Whq07/r8P7pNr/OEqRfrn53BSD1mHNx1giOySsK/iW6veZa6wIhcBOmc?=
 =?us-ascii?Q?tAtoiOFSWT4B9rXzuhBnfyObhI4Zh3REBwKGamHSkZL98ukgxgKQ8qsRMQd9?=
 =?us-ascii?Q?hod+Z3Jlt6FWLGH5FjNTFWA/yb5bUBfVH527kluYYcnNBbVrg58Pevz3Nbfw?=
 =?us-ascii?Q?U00mvo7dzbBpQaAj7bTYIzd1fO73laLMSZiZ+f+WbmOgWLJjL5iDUojsW2Ky?=
 =?us-ascii?Q?Q8X6lJO0iWItD1WqD8rDbpK4YQl5bEIzHHO4xfRGgjJCiaQHBgloO75kh2Rh?=
 =?us-ascii?Q?OlpuYtRufmw4FcIlBTnqu+65g9YcFJoRmsuL6xjgc76PWvnY1kxcc3BfyPHl?=
 =?us-ascii?Q?3SkMjz4R4TfoqhCSqAZZGMd0qUOYwUrPFv+euXB2HUav9KBzImf/wIqNqe5c?=
 =?us-ascii?Q?ZmF5p5oOkcjnYtN/Ji+Ckop6sUUSA1IDPEXV8Ag5XcsK+cTq9p/PH/ItGY36?=
 =?us-ascii?Q?GmR31RVYLJcPx8j0lM8gBrq4nGxrwsn+w7MWHGg8QzKpyQoNd0hQX5s25iOm?=
 =?us-ascii?Q?hsBpo3ZDuboN6GkRFJHtymI0ubSocZTS/oARzgb7Il7hpF4bhkyYcM70HIt7?=
 =?us-ascii?Q?yAEcHxPVTD5dZa+eHPbsyf2PZKR+T172M9kjg1AClkjLgMluzir/aCeyKLyk?=
 =?us-ascii?Q?7+RouevlU7Cw07zx0PoxRLjqMV3MO27Co60nmLB7M3ZoJK4Ep7BYmPNrDYr7?=
 =?us-ascii?Q?Lg40gIide0I1ep1+d/SlYFhCs45c3gDu6yUrl+YyvIUaG0ZCoKLoDTOwnsik?=
 =?us-ascii?Q?OUIbgKUp6Q3L3rTM8TN1/KDt9cFTLfQyXYyqg+yug5dqTEfuFJgtb22HzknD?=
 =?us-ascii?Q?jwe38fbONqieHeIvDbA4dGuXXhs+wGuiw4tLHIcHvxIEdE6CWYAfRXET0FCK?=
 =?us-ascii?Q?usC04H8fLRv+rnTleCUgn028eDz7wRs/Or2Mo6WjjMTfjyTGOi1Y/O4zFYRk?=
 =?us-ascii?Q?bOHFQX5jTEfl1j/X6h5YHFwD49Tec6DBxoGfMMoJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02a6ba5-7929-4d6c-40bf-08ddc9bd2e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 07:47:32.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cH5cKxJYb4NY2v9ng10tcoPQyc2OMh8ps/QgnbwkBIKLZlZTOFOukRcQaIZfWFGBqteGBN8NrYHKLjXWH4ttqsRWK/wSN4fR4dTaFdd7t5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6062

> Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Ad=
d
> parent node compatibles and refine documentation
>=20
> On Tue, Jul 22 2025 at 17:51, Ryan Chen wrote:
> > -        interrupt-controller@12101b00 {
> > -            compatible =3D "aspeed,ast2700-intc-ic";
> > -            reg =3D <0 0x12101b00 0 0x10>;
> > -            #interrupt-cells =3D <2>;
> > -            interrupt-controller;
> > -            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> > +        intc1_0: interrupt-controller@100 {
> > +          compatible =3D "aspeed,ast2700-intc-ic";
> > +          reg =3D <0x0 0x100 0x0 0x10>;
>=20
> I doubt that the controller base address is at 0x100 ...
Sorry, besides the interrupt cascade, our interrupt architecture is most li=
ke this one.
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/interrupt-controller/marvell%2Ccp110-icu.yaml#L74-L98
and also others
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/mmc/aspeed%2Csdhci.yaml#L83-L107

I don't understand you doubt it, and also we have proven in our internal Li=
nux release.
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/=
boot/dts/aspeed/aspeed-g7.dtsi#L1676-L1730

Could you point out more information what you doubt? And I can provide more=
 information.



