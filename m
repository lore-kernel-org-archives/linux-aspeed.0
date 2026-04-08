Return-Path: <linux-aspeed+bounces-3866-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21C4FD5F8C
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 07:19:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frDvQ6jM7z2ydn;
	Wed, 08 Apr 2026 17:18:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775632738;
	cv=pass; b=IgVGbYmZ7J+IF1yt4kCRFBzFZNzYO+gsufdOmbWrULyRLF290mI+Oatvr2m6fngUg9twsl0RZsOrLcUCIQ9wOMT+HI2TIdf1zrTKOzwwqa5dFHXFDFw+kYVVGc3aibkxRyPM08SxEaraJCQoFmHyG7auxhhSMfywz+img5R4+6zRJbQikAVnZRJzp08ddVoHtFdsVNxvLyJV3PUf7kWgBsyLrmMkcznm4QvjdzJVd2/nhCH0LAgK25UdPb1oM0sZsI4WjXHcD1kQAJrvc+H/KTmQuJ8dgrjlqoX4P2Y6OugNyCt8bQLxLMDQxHR2xT+hHW1a2cDjsmu9F6qc7WXb7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775632738; c=relaxed/relaxed;
	bh=tkb5KvRXjWsndN94SzgyiYSYE/HyHwpBffQwwH4WpuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gg1qv1kI9k+NlUYkENiHN7mFDF/2iyCd0JT9HNtvsK2b/igUp+wXKMV6Ci5VAwxCioJifPz6oS/ANnBVxztErDvD/De6auwgU9fcIdAx8C3YavmIxLwj2/mzvH65wUfD3iukCOjn5nI3Q5BL4SVORVdbVeSMG2Ig7RzUYB5ZNQXoX1Dq5yNmAykGNiZrHzXcAeyFhnaQFXnyrrBjxKNGPe5qkRoz+McUtNDZh+UjhnX4LlwRgk46k10XFSv7+MlMxYAAfS6JG90tEMyLHq0e9Pn6g/PTQTYGH9YWC+YOBaZQALRph3cRh3uWIydO/SveqKwTK+hEhJr8hRwljjRnrw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NWrDfnOb; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NWrDfnOb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frDvN1hLrz2xm5;
	Wed, 08 Apr 2026 17:18:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCtwc/YJq2yjQA1lXDafTblnvcDp6ZlvgPz5fkk8AV+MHP0yOcDePHgFkRjBjOIPCpXBirOglLroTIEnbC+pM18H2vjsFFXuPhmwp0iZ5FnD5zjwxpjrHU7UWHYk2GcNdrzulJ/h171z+hJS5avYhpzlWoOrQsefCHcP3pfvfJ0eQ7rkn1NkEt0RXXcIXK312aJ9RMbc2nuOoJdRnDWCEjxZRPt5vMNHQReZKpZp+XGRf/wTF47qyP9EyHan/1Ms1tlYWOh7XWEdN8I0K3OCEgIJQuOSWSpmkkpuWhczd/Siw0p4x48usYAS/cy5oGimw3qvVs9E/1jRzjSLrTMqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkb5KvRXjWsndN94SzgyiYSYE/HyHwpBffQwwH4WpuU=;
 b=EQBdro3oOkg70T03YVjr1YjL1j3jVdJ0VD0V4YkdmVXkTC65SS1Hvp8/muBsDvnye90rDIFZxJL8UM5PQxW6hwuMScHLAAC+Th2KbSP9G14KMY3/2yQ833q2HByiwRvQUQbLdF6AgLIGvdxMRS+kmPggW+F0nSbNDmKi5qDxcJecs97Yw/Gm5kZ+sHI+TfVtekQwDbg81tSqcMF3jUV4+uebyWPG1/p6akg/qTBw0rWdUfA/uOPonfRbrKMjsWnhV216TFMZoIhOLIW93kWXYlb+e06fS/IUxzAAmhWdSlhgzhOeqDDZzIT79GMUiFNAya9rfc2kPNeXpKByvu9n8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkb5KvRXjWsndN94SzgyiYSYE/HyHwpBffQwwH4WpuU=;
 b=NWrDfnOb7YMjiJSq35uJKgZVh1TV+Pn+mOpOAhvH6exbpWRvJ9kZ/XEcBqsUiUXVSWTKamvJY8PEq2OisZwjzVnSxOu2xz3C9t7Tj+Ouq8xBu8C/Amb2OZJ8jjllcbIumJFib1oV4QLu6fQ9C2t6b5CoDpTGqKl7BhzLh+BQ+OIDCYYGxQVJZbmw5QdZKfa4llhEpueOzg9MSOk4FQZ8R4BxyPSKOoWimFM5XbDpH8CWNg41VtNxmAA6qvCqOTjWSUMIbJjkIRNaZfyzAm72qUmZlPx5/DK2Bu1OKSt70o1Yrdh/ksLEjA3GH9/dryObTxxVxzFrFvDyZFNN7zFBsw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE1PPFDC587DD38.apcprd06.prod.outlook.com (2603:1096:108:1::42c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 8 Apr
 2026 07:18:32 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 07:18:32 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: Jeremy Kerr <jk@codeconstruct.com.au>, Krzysztof Kozlowski
	<krzk@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Thread-Topic: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Thread-Index:
 AQHcwB5Ez31FCAF2H06H/moL1lfWeLXINCEAgAABqPCAAAIpgIAAAW0AgAADQQCAAAMycIAL3nkAgABfLfA=
Date: Wed, 8 Apr 2026 07:18:32 +0000
Message-ID:
 <TY2PPF5CB9A1BE604170FEFB84227925F09F25BA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
 <20260331-fanatic-certain-bustard-fb13bc@quoll>
 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE64B7988CD85A7189164E1F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260407204402.GA3641251-robh@kernel.org>
In-Reply-To: <20260407204402.GA3641251-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE1PPFDC587DD38:EE_
x-ms-office365-filtering-correlation-id: 336d83ba-4238-414a-6d56-08de953f0a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 f2oxo6HNpztuDoZKRrarAe8e2WhBJ+ucNMA1RyKYod1mOGNxVFqnL0C7YoNy5+eQNHOQ4DCsmwGMa6OMVC0S5L071YlPIf73s8jBd0ucjaFf+8iYdKfTCrLbHDlzVo1SybU3+HnHpFVwKSl6x9q7mg8gW9lAFF1OaZ6Qz8nM5od2R1M+Vad9ZIp2XYmd3pkvXEacmsHBKDBmDJm1fHIhFWTw3FA7WrNNQdMaMW/6+vbZZlKepX20nIOiEQAZr8jKta5LW0LkRB7mKeF1J/0nTszrNfWvnrt9f0RQmCTVA4peVUUs9ZKRBOrBhMa1BDXnnmMemKSrlTPcgjLf4ihmn6UeNZxysHUcCk3fwg42lc3bo1P0lH0jlIChGk9eB/HIyWNqxJfXoavIwGAE/7/UPBJtveVSAu4YxpV31WPkIjE6v+n1UtLyT1B9OZFyaaOgsAhRAXr768n+5HF1/OgIjvFsv6FVISD4uT2SqSWUEHbKnlpsZF4mi0QxQA2Cy32PhegLyF0kwPzeqgdtQA3zTWONJ+oEZiPfxyjukF1qkKqbdoQw9zTK+2lJj6arwuUWG1960pYIqLFYb4gSbzy4REGGrTCS9YM528E4WEC53PYwphDRKw1tQWtD/0pvkqfhA6NlrYCYbjlgr4lbePB1Tx6bstiq6FkGT/2XSOx+H50inGE2so9Qx8qY2vcvf19sIvftHWgOS30uQBTIB6BxAg3/1lL1pQ71CZ001zymMuKwTXQXUdDfWLCRCvUxw8XA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ZjnFRV48H9ueRQKfqXegXYc1qWi3ghtgy8NizznWIuQ5ssJfktygbTmktLs?=
 =?us-ascii?Q?WB4VS3t4Uk6upImk5fZyOjufMR5mum6u+b9JhdnDFeT5WlQVq2H+OpZFWkUb?=
 =?us-ascii?Q?ZTfEBUa2OEpDI1W7+RZeVmRaKXjfddzHhwBUHlf8iiZfULCi6q++v/exF4C3?=
 =?us-ascii?Q?27Gtt9Rna+SrO9DvCB54Gj8TF7IgavnBinViOtBOTmsSUS+ISIXHFozuuM/y?=
 =?us-ascii?Q?CPlQCOGw6RMV3P+j37T0indyKNngUCzLQXLIqcdkTawj2wgVT0kPKxsFAhn8?=
 =?us-ascii?Q?vNjYJs4UsuijWze4dBFh1wbnvmbEj4GMtXVKzLi+Tyr6yEpkqWRg8VqqsAEh?=
 =?us-ascii?Q?9IsScWG4CpTX0juo8oWIzHNoKPqF6g1gMG0tbv+onxsm7k+PIB24i/pVonJb?=
 =?us-ascii?Q?Ew3HC2N6OhrwROr6FyfsXaJWPp+lfq/ovz7cjfQvaKC0j6MP23ukWwsUFBIF?=
 =?us-ascii?Q?/qDGNG8YXsOC/jiHLu9fZQVHSj9s+Z15NCcjKerUk/tLfA1wYzqMHAPTVNhm?=
 =?us-ascii?Q?fKIQICEyNg1ip0fumDFk23q/Q4IM6TrXS6eD3Qa7Ic7u0rERVNexCVLIr8LM?=
 =?us-ascii?Q?Pq1E3oyge/69VI9Ar+VzTjO8GJIn0oYzz6Z+4ZOrtW1DiPtJq6hkoj9LdlKu?=
 =?us-ascii?Q?D8SMEkT3oLO6aHt5H0DrehOq14jpt6JPj8HyzBOHv7oNOSzYBC+KiPRMPjCj?=
 =?us-ascii?Q?1DhAhI5fk0Lec1ec2kILdmwTcXCDRR4jQ2GEs507Y2qQbWsGHpC1jHcLC9qA?=
 =?us-ascii?Q?Z/jE9x/rH6mt4m/0fIRRuEjeLniiEBi++wP0haxaP5bO+hpjAKOB30ytDCmN?=
 =?us-ascii?Q?1qGvS0JNYBlAjc5sd5BOyvIEVm94/X451qOaBtBCFYOJOK+DoM5z1YRxviuZ?=
 =?us-ascii?Q?E4di+zONDTmyz9bruZBfRiv9gYmgZuCpyE9NQD3gLp0ZhX1HUQsUMJ6UCrRX?=
 =?us-ascii?Q?E+3YMSMtZbDJO4fmOmNYJwiRyif60YfBf8ucHIM6x6bMz0MYzI1fXJlishYZ?=
 =?us-ascii?Q?AaV/MZWvWhmJ4jwBE2NxyCergnMpXLKrGUxfNVzFfXilT0oqZuwOEZWDoIFO?=
 =?us-ascii?Q?cu6N+z2NZ6sQaQo8+62eBgEEQYXKxHxsvv6L0StjG6bJ1A2FaIgaEg4XsiNq?=
 =?us-ascii?Q?tK4ashXqvEyBBArtKxKfCW+a8QTUrvBwKcPwJvwq3LK0v/8pMNCgQfMthdA/?=
 =?us-ascii?Q?qF9faPSLgii6tm8I5YxDVTdxQryqNH55KV2MhOdfnvNPMAxB31ReHylUyqe1?=
 =?us-ascii?Q?OgE8ZqNIrVyEvOq1oZMuazbPDhcB8klQ/KYtOcmpFaaMBtlwtEP2pES5MXTZ?=
 =?us-ascii?Q?RgpWA6iYNFfoxizQ/3s9rzPzWaxfUuc/aXWJi5Ub//8lN9/pEYQwXz0MJuIY?=
 =?us-ascii?Q?vqRrMQYFPfzRw+7kFIJ0VMoggtM9wZn4lmRygpg34bLDUiFctm7auL8pQzMz?=
 =?us-ascii?Q?a/XUqnx4Y9OiDJpm3T7f0JsiBk2E23Izk4SC/ITnByDeII9AYwSTdjR67K1D?=
 =?us-ascii?Q?DuPcdUr2JwRgUr2zpSCqc1fIffriz6/GsFHKh1euita1x+1smrU3V2wqume8?=
 =?us-ascii?Q?6wEgt1J4D3ptoDFOiBJoWBceNKOSDZ8mhn8sCVSIsk6jSZwyXV2UxDi4usQL?=
 =?us-ascii?Q?NhteXa24TsqOABHzcQeC8AghHXL5jZwuUt57UzBxfZE7QAO8cf2k3rB6jda5?=
 =?us-ascii?Q?2FvPtlOcoTR0TEktkXUp4kMSkX/03kMgG1gwU8cQYA2A2/K6ik9WN2ReebII?=
 =?us-ascii?Q?dgDKOeprqQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336d83ba-4238-414a-6d56-08de953f0a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 07:18:32.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO7VFp3hI6QSAVe72Ce0gWIVwt5gL1eeGFMFk8jvVyQPiB6aosrbUMcwf5L6UAzgv56JE8+NffDWQkZcF10fsECrO9NLmvKOvLGrb7yKnTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFDC587DD38

> Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add glob=
al-regs
> and enable-dma properties
>=20
> On Tue, Mar 31, 2026 at 07:30:58AM +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
> > > global-regs and enable-dma properties
> > >
> > > Hi Ryan,
> > >
> > > > > Sounds reasonable, but before you do so, how are you planning to
> > > > > manage the allocation of DMA channels across multiple i2c
> peripherals?
> > > > >
> > > > The AST2600 I2C hardware has only one can use DMA at a time.
> > > > To avoid the complexity of managing DMA channel contention, I plan
> > > > to use buffer mode by default for all controllers, which still
> > > > provides better performance than byte mode without requiring DMA
> > > > channel
> > > allocation.
> > >
> > > OK, but your wording there ("by default") implies that DMA is still
> > > selectable for one controller peripheral. In which case: you still
> > > have the problem of managing DMA channel contention, but now it's at
> runtime instead.
> > >
> > > So my question still stands: how are you planning to enforce that
> > > DMA is only enabled for one controller?
> > >
> > > Or are you planning to disable I2C DMA entirely on AST2600?
> > Yes, This is my intent to do.
> > Disable I2C DMA entirely on AST2600.
> > If I remove DMA, should can I keep byte and buffer for sysfs?
>=20

> 28 versions and it's still not clear when you need what mode. Sigh. The o=
nly
> thing better about sysfs then it's not my problem, but that really doesn'=
t sound
> much better.
>=20
> DMA is only going to be useful for transfers above a certain size. If you=
 are
> doing the typical SMBus style register accesses, then DMA is completely
> useless. The setup DMA overhead is going to be greater than just directly
> reading/writing the I2C controller FIFOs.

Sorry, why you think DMA overhead is greater than read/write FIFO?
When enable DMA, all dma allocate will be initial in probe.
And the DMA mode data is going to dram, that will be read/write data from
dram. Compare with buffer mode, data is from FIFO register to read/write.
So DMA will not have overhead.

> What's the size that makes DMA
> useful? 16, 32, 64 bytes?=20
The i2c ast2600 can be 4096 byte for each tx/rx dma,
buffer mode is 32byte (16 byte for TX, 16 byte for RX).

>Something greater than the max size in buffer mode
> probably. Really, provide some data that DMA gives better performance
> and/or less CPU usage.=20
In general i2c transfer len < buffer size. dma did not gain.=20
But if large than buffer size (16 byte), it will reduce the cpu interrupt l=
atency.
For example, mctp transfer :=20
https://github.com/torvalds/linux/blob/master/drivers/net/mctp/mctp-i2c.c#L=
29
mctp max len is 256, that will 1 interrupt for each package transfer.
But in fifo mode will be 256/16 =3D 16 interrupts.
Compare the smbus I2C_SMBUS_BLOCK_MAX is 32 byte + 2
https://github.com/torvalds/linux/blob/master/include/uapi/linux/i2c.h#L145
That is only (32 + 2)/16 =3D 2~3 interrupts. It may not gain more.=20

>If you set some minimum size and request DMA only
> above that size, is there really that much contention?
Sorry, I don't know your point here, could you give more your statement?

> If there's some specific
> device that really needs DMA, then make that device's driver request it a=
nd
> reserve it.
>=20
> For byte mode, there's not a clear need nor description of why. Someone o=
nce
> long ago asked for it... Who cares, if they really want it, then the issu=
e needs to
> be described. If a certain device requires certain timing that byte mode
> provides, then that should be some property the driver for the device
> communicates to the controller. No need for DT nor sysfs in that case.
>=20
I agree with your point.
My proposal will remove byte mode. And keep dma/buffer. And remove sysfs fo=
r=20
transfer mode selection, default will be buffer mode. And keep properties
aspeed,enable-dma, which indicate the channel have DMA capability to use.
And if dts add aspeed,enable-dma, the i2c will use DMA otherwise will keep =
buffer
transfer, is it ok?

=20

