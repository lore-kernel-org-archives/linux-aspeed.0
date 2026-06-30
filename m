Return-Path: <linux-aspeed+bounces-4320-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8BDC43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 30 Jun 2026 05:03:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq9yT3hBdz2yYs;
	Tue, 30 Jun 2026 15:03:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782795793;
	cv=pass; b=NHJeyLFToB5xMkF6JGX8/r0NgEPOMAhPnujicwJxdm9MSb+Kcr142q8qO7Ynsrt3KWe1hTr1J9L/5zDTYdx9bYq4hA+Qc2EEsRrwVKZHeJ6JoBA47OE3lFuBdT7de8tFDIuZOu4wgVoYAvzoOHHPzKMzcZCTBQLSISuk6xqeSiXtANh6uWWhfJVxmap3zSilFJhrfzHKVNWXYzO2TPsXm27swK8ygeTwGQtURwsAg5SxF+Fe+e9y/l1nixnVsueIqm0ve85879aLVISnfNPx8a+56hnOO8r+2JiBkMi5kGulBi9n+1Pjxw1nHTDKwBhTaP0pD0zmb328HDy/A0LKDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782795793; c=relaxed/relaxed;
	bh=40jUMhKwuYB+pVNOW02VufthW7Tjing9Tl9YUB27gH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XUbIkGjBR8ojWAnlIAQ/rfifAKX3kux4RxwCzdKE18wy3daBbH644OZF+vEDB7aekjN6H90Z/lSQgo2I6PJMgCQz9CO6JmWzdd1ionkjN52mP7XesFP3PHacSOKcXE3m1OQ2r+U3J/XRyqLEe0GNlmGokBsUeMwpn66qay62CD5jt8zyYfLAJ7FvPYkpc/Sm/bwAgbI5jdB1gMoz6nBZbDVhDrnATcgdKfQ++7IkJApT0pS9JKh3HF+VjtfukhjsnAnLGcM2f9KhyVv7AxR4e96QxrKPiWEFG5vBdynh3t+k0e07KaamJXQ9AZqZK8amImQ53zFBiU6KidG1BBuWcA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DHs5wXKM; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DHs5wXKM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq9yR3S1Jz2xHK;
	Tue, 30 Jun 2026 15:03:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSHD4/HMggKqSxpnZLwQM9hwf8koZbOlXX9Sl36eIJ0rPJ04AHRX1uARP2IN8HZ++DtWQoL6UqxR9aubwiBHwJ0vXe7s8wtzLgGQC43c+0njBf/O/vXdxC97yUZLNTCa39rbuEQ5s/7YJgRem+oZsx546RyhUfIKu3TRmZ8tuXtqSgZan+u62wlZK3I0FZ1+3XD8GL3DcEtHLdaYUddeAGlMY5HJmVjbLE66JgXyNy+gFkPt12PdO8QPSUrnbt505shpmE+CDUOEA7VVjggmQE7GKdxrE0rTOs54wy9aaHzcc1wbjyIPxP0kmJTveEuWJeD/iIJm+dK0rmZUvplJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40jUMhKwuYB+pVNOW02VufthW7Tjing9Tl9YUB27gH8=;
 b=CfD9fubIVgmPZslr86cdgVvRElN/2u6JxqTmaaWw0j08/hA9ckzPd2UtZwv22f01ka0g6PLBgrQXHb3NliNq8uW3k40mfcQSHB2htDGYlStL+tYGGspEzWrITFNpSX5SdBIyUfTw+jIKhJ3YemwaKgkjo+I5P4YPukPXQ1MhVuPY1ZoroVrl6GPKNO6KC2UmX8WRGz/B+tzpDmo09PpbPH+NWGUDoW96xKeGmsgNxd/tF2K5xoQGT9tGjeCDujXvjbcFm6+R9cpiq7yCdPCs/B0Xl3A7fUgOcWeAL0by0q5jINLCbn1DyCwHHrxdH31o1z5JeIJ7dGS2ybj4xdgMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40jUMhKwuYB+pVNOW02VufthW7Tjing9Tl9YUB27gH8=;
 b=DHs5wXKM45vdtVH0RWXSGcA9kP6PU03O5y8Pr6/57sL5zD+Q3eaJGJi1m9FMkMrexq6XBdJY+XIx+aDBecMYyoYOSPFcRQCpXzUoO5AVj8lZpsBbEhzu+B9egzvuQlPNmjWrJsm0tV9FmTa/5HkWeR1YCdiRE+7pop9TJwdvhesnjeSMxZcPuJPXtbOazMkCE19WJyeeyi+eiUmRoilseE4grDdCoufXKvpDD01Cet/ozpzC8pZgKt/yuROAW1f+BGP9eCnWlGALm6/3whlkhgTkmmRalk6BjNq7WV41Vqx5lXB47THM3XP2ZL0GMroB7qbYQP9fZgQt5is1bxXi3A==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by TYNPR06MB8403.apcprd06.prod.outlook.com
 (2603:1096:405:3b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 30 Jun
 2026 05:02:46 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 05:02:46 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: LKML <linux-kernel@vger.kernel.org>, Maciej Lawniczak
	<maciej.lawniczak@intel.com>
Subject: RE: [5/7] soc: aspeed: Add eSPI flash channel support
Thread-Topic: [5/7] soc: aspeed: Add eSPI flash channel support
Thread-Index: AQHdB6Rl+O3f/Pd0jUWeHqrLq3qghrZWi5wQ
Date: Tue, 30 Jun 2026 05:02:46 +0000
Message-ID:
 <KL1PR0601MB42764147CB9CC731BFB8DB2090F72@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
 <3ab543eb-ca09-4d75-b75c-b8a4c71b2173@web.de>
 <KL1PR0601MB4276C2C831B257898AAB363190E82@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <1df6b921-368e-461a-af01-d453a3898cf7@web.de>
In-Reply-To: <1df6b921-368e-461a-af01-d453a3898cf7@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|TYNPR06MB8403:EE_
x-ms-office365-filtering-correlation-id: 942faeb8-fd7d-403d-3380-08ded664d332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|42112799006|1800799024|7416014|38070700021|18002099003|22082099003|921020|4143699003|56012099006;
x-microsoft-antispam-message-info:
 FocjpZCq5yBRIl8++V81HcpGawg7Eel3tKL+81VKL2SNQ2OAEuKR5JKgFn6MA/ncQ8WxNSLffmPxAsPaml6wPwl5r6+f5bKzC/8Ypn4iA82HNDRc+6NAeMvYOvH577dOdF+2o8fpplMa+xI5DxoUsk8a9r1nxhSHKze0KLWCz0tzrq6zKM9ZhotiDTn4dkStJYuy4djiO2zRmuJxnLxgHbRVsZMQLelVbDLxzo8b9Ntpl29kaPrVpVp8E7ICfYoahU1j95bOytQJl5ZMaSx+IKcXj47dR+Cv/CdjsXM5YklleqUiJRvhLPHu8RU+aK37BGQ8lXr7hnMBGbEenDLJNG9udquCH9Qp4kqOsY148riDETqKAwGa5qjj2nRUUTdrgcacHKdy0jFf4jKFstK1FI/KctjVWHIc1fVy3c0K4bS5qoCre9ulGt575IOoOV8kQXdVMfM3qN970d5hlEVbmFHhQmcDNoqF1ztbYRsSKMj5ZAS15cdtmn3Up27hQllYt/TwqjTl2J+Y3VnhfYqp0PWeskm01NdUjZqv8iIDuD8AUvd34yr1bE7oI+nU9rVPcQdL6uBaJ59t+TnUyjNz6GC+iru+ecWtjImd5P3yBWaf5F8QSBOxySFU34x7fESQrO+L40a83e9+qTRN0Z98PDziPPKts/AbGSe7Hyur89IDNKZ/4f6WOKAAxCGanQI4J3fOqIhN/lEZAsc53lyG7ZC9wUyhxWf7KY0aC+hpnHwfH1b/XP7HfhY3vGN5E582
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(42112799006)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(921020)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjFtWkthV243TThoRldtQWlpcWtBVDlUYUQwTlJJZk1ZNFdmSy9tWm5ZaDgr?=
 =?utf-8?B?V0F2NkNiUnZuS3IrZTJqRi82S0pjZGliRlo3Y0FIR0lWVGtweGhaemhsWWt4?=
 =?utf-8?B?Q3k2Tk16YkM0SHg3dTNzUVdEQS9QWUpjYlQrSlVVQ0kxa2lpMjJzOTRZdEI3?=
 =?utf-8?B?Ymd5R01BY3VJZW0vS1puQ2t5Rkw1RFRiemYyQlZwdEFKUWJycHB6MmpPM0tV?=
 =?utf-8?B?WktVYXQyalpRZWpYZW1rNEI5TGFpc1lzeGlkNE9CSWRtQ1VtSXhxaDFHVHhr?=
 =?utf-8?B?Z0dXL1ZKRSt3dHR2eGNaZkpMcVU1WWJOZllET0kvVUlzWExIb2J0SEhZVTBF?=
 =?utf-8?B?cFNuY3FudTIwYnN4SjNacitwTHdINFRFdld4VDVMV1UyVHF5azhHbEwyekI0?=
 =?utf-8?B?cTNnOGh3L1Y5KzN5MVRocXdWbFFENjRGQ0FZbk5OcG8wYUtZQUMrd3BHeHl3?=
 =?utf-8?B?cysvdXBSQUdyY0JSMzFNMW1BRWZ4Uk1jeE9PMnNMUHpadWowT3ByUi9ML0p3?=
 =?utf-8?B?SjlxZkN5ei9lZUhaQ2VPWEtCNTdrcEVoZmlza1REa2VSUmNQR3BCTW1PZ0Rt?=
 =?utf-8?B?bVVIODcvOWdBS2NGYWJtZno4VzJHYlArekMzZ0ljTitYRDh6Nlc4Q2JZOGN4?=
 =?utf-8?B?b1ZtZFRyaDRvRUFjZlpnaHRBa0tBQ3RrNURuRVE4Mnl1ZjZtOVFsR3NMUXpa?=
 =?utf-8?B?Z1Y3VFlwSW9xUzhwVW9UUmlYMllodGtxb2U3bHl5am9sUmlpWXFRL0w0MlFU?=
 =?utf-8?B?WDhibWpWK1ZBMXpKUWJkSGFFL1FrNzU5UlU5UTVRUW1CZ0prRFowNnkzb2lU?=
 =?utf-8?B?WDVXcUFHVlFLT2xsaDJrb2lsSlhicGJQdlFnWDVCL0pmMStyaWRpN0pPVWZt?=
 =?utf-8?B?TkJHNUNzMkx5MU42Yk1GMjFlY3VvTUFrV0E4UjZWaUdVcm9ZZWRWRkMxbEtr?=
 =?utf-8?B?OTdyQWRtaW45L2Zod1UxY2pNZTZyRkhBcHdaTmhnVXhJTE9YMG5tTnBxbEtk?=
 =?utf-8?B?L0toQjFTbWVVeTF4cHB3UlR6bkxnNlpjalF4blRDQ3dMNWxjN3VMKzloNWlM?=
 =?utf-8?B?Kyt4S1VMaTNjbVl3cXJ3N3Jld2JyRzRoSmd2L1VpQm5qdlh1b0t0S3dBTVpZ?=
 =?utf-8?B?VUJuWCt4SlA2WmFqazJOR0d4ay83aWtkTWNPQnhobUNCb2g3SmhLL3dIQzV3?=
 =?utf-8?B?cGxKVVlEcUtRa05veE1Gakxmb2RQK09tTm85Q3kwRU1UOXVlcGRBcG5JMXd3?=
 =?utf-8?B?Q1UvaDMxRnhveTQvNFNiWkNYKzBoS1JNdzdBanBHd3FYT095ZWVLMUkwbU5s?=
 =?utf-8?B?L1pramt2d04xcmJoeldxazg0RTBGTXFlN1pjZzcydEl2SVNoUnNCanBkamtm?=
 =?utf-8?B?MGJISGVkTElpdEtQN05YNDM0YWJKL1Fja0lGOGVjZThtY2tGR0g1QmY5Rndp?=
 =?utf-8?B?c1IwZ2tyWWoyeUNsR0YwZzZ1RHdtL3ozU1BqT2hrU3hqR0NNNzFacGIrdStu?=
 =?utf-8?B?QllJbGxBSGRXNitLWDNyank0ZXZEOHBPRmlJazZvbWRDWFd1MjFMQjgrZVpC?=
 =?utf-8?B?ZEk5OXZwN2NSclNuMTFSVHlybmJyRWJBTkRzSFZhY1R5aEZDQk0wbnFTRGNy?=
 =?utf-8?B?dVdvU0hmVm5IYWRLMnB0bWtMbGdxVTVKVSs2VDRnQkdId3c1VktvTmhYSFl2?=
 =?utf-8?B?NG9Pdy9DOUJUSmY0VEdDdHU3QzZLS3ZOZUJNMStDeEZUdWlsMXpWN1pSZk5x?=
 =?utf-8?B?UFplanYwN2t3N1RBNnNHTG5KaS9MeWEydzloaldKVjRoZ1F6UFlsSHVMbXNM?=
 =?utf-8?B?YUxobWpjMjVsaWIxMG40OGYyNzM0aG1mSWVJTGFaa0ttZEhSM3V5RmJhUkRW?=
 =?utf-8?B?MDlXRnM3WWJ0amRCZm8vbkUra1hPcGxjU2tuWXFWbk1LNWdiSk5saHNJbm1v?=
 =?utf-8?B?Sk1EMmJJUnI5eFJqYlBEc05kaHQwSTBjR0dqMWcwT0dOUDZjdkY3VzNlYlVP?=
 =?utf-8?B?TG0zVldSamx6dCtOcTVtZm5sdUc5V3Fzd0xraXNIL1B5L1A0NHJBRjBES3k2?=
 =?utf-8?B?eGVnTUVjbGFVQllXK2FKRjI4MkNPeTdyMHU2dEVCNm8wUDZQclFIREYvMWFW?=
 =?utf-8?B?SzhsWldzSnd5YU9OWGNxbndkQkpvaTU0NGRhc0JWQkExL1lMS29iNWxiWlVZ?=
 =?utf-8?B?YzVwZE9uU2h6QlduL2lCVkRCQUlNR01EeVVjM0pnTkZvS2loMzlkemF5NUVO?=
 =?utf-8?B?UmVBODYxUW81NFRDYXRFWE5OR2ptVmkzSzFENVNEeG5MQlF2Zy91SlkyRE9a?=
 =?utf-8?B?bW9pditPaWt3Q3NRMURrRTM2VXpzbE1XQVpFdXZrcEZ2OXpRVkp6QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 942faeb8-fd7d-403d-3380-08ded664d332
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 05:02:46.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLWx/nZtFa28lq4Ezrh9OnmdhGg9eht1CUmEpf2bdgz9ppbE4RNR2X67BEt5wzgM73RYXqcKxqEAYnpd7Edb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8403

SGkgTWFya3VzLA0KDQo+ID4+PiArKysgYi9kcml2ZXJzL3NvYy9hc3BlZWQvZXNwaS9hc3BlZWQt
ZXNwaS5jDQo+ID4+IOKApg0KPiA+Pj4gK3N0YXRpYyB2b2lkIGFzcGVlZF9lc3BpX2ZsYXNoX3J4
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKSB7DQo+IOKApg0KPiA+IFRoYW5rcyBmb3Ig
dGhlIHN1Z2dlc3Rpb24uIEkgYWdyZWUgdGhhdCBndWFyZChtdXRleCkgaXMgaGVscGZ1bCB3aGVu
IGENCj4gPiBsb2NrZWQgc2VjdGlvbiBoYXMgbXVsdGlwbGUgZXhpdCBwYXRocy4gU2luY2UgdGhp
cyB3b3JrZXIgY3VycmVudGx5DQo+ID4gaGFzIGEgc2luZ2xlIHNpbXBsZSBwYXRoLCBJIHdvdWxk
IHByZWZlciB0byBrZWVwIHRoZSBleHBsaWNpdA0KPiA+IG11dGV4X2xvY2soKS9tdXRleF91bmxv
Y2soKSBwYWlyIGZvciByZWFkYWJpbGl0eS4gSSBjYW4gc3dpdGNoIHRvDQo+ID4gZ3VhcmQobXV0
ZXgpIGlmIHlvdSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgaW4gdGhpcyBjYXNlLg0KPiBJIGhv
cGUgdGhhdCBkZXZlbG9wbWVudCBpbnRlcmVzdHMgY2FuIGluY3JlYXNlIG1vcmUgYWxzbyBmb3Ig
dGhlIGFwcGxpY2F0aW9uIG9mDQo+IHNjb3BlLWJhc2VkIHJlc291cmNlIG1hbmFnZW1lbnQuDQo+
IA0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gSSB3aWxsIHN3aXRjaCB0aGlzIHdvcmtl
ciB0byB1c2UgZ3VhcmQobXV0ZXgpDQpzbyB0aGF0IHRoZSBjb2RlIGZvbGxvd3MgdGhlIHNjb3Bl
LWJhc2VkIHJlc291cmNlIG1hbmFnZW1lbnQgc3R5bGUuDQoNCkJlc3QgcmVnYXJkcywNCll1biBI
c3Vhbg0K

