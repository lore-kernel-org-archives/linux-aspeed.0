Return-Path: <linux-aspeed+bounces-3814-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B85FF60CF
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 07:10:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flK4t26Tyz2ybR;
	Tue, 31 Mar 2026 18:10:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774941006;
	cv=pass; b=Sl7topMUe9AkwX/2Uya5oJVlerde3r423VnqaDymaa94olx5THGfOfY6vckTmDbZeZosD9tgPD/hQq9zJ2HJDSShKHTdTXiRKNViN1GA8fmSbuUbv1IOdHMqBX5KFWgy9PtQe3/0EmpmCJAtJa/zXtALxLJw+lCGICFl0gBDf5ZFSRvE9I7ksHA33PVgqk0wT07oVpfx2+53t35ICYyWkmzslHNRSQjyIBeCJhvIkjvDdjCiD3tZSoeFlIbXWGuj0McGtAK05Clf0l+8qN+QxGZ8RchVEurfFSsdwOXdpGa5wB35eiiK1QQfucLiWnwk6m/1VjMo+eXScfS1vFOmow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774941006; c=relaxed/relaxed;
	bh=ycNdKDx/VNIReNYYQh2QBg0TAIdAveqPso8i8TgLlaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2FjsNDjLX9Nouu5sCV+Urwr0VXCk09RywkhjPmBk1fcTLblTc5KmPSL3wf/QUDi+5GsSVETTdCjFO7gFR4ZNnyy1HUJ13krfrLgZYONyXIHGSDeb0WDVipXrTaigG3K9tPP8YmgxgUXqw2WCkY+e2G3EkZru/SOw3dNtRwoDc7a7EVlGYr/Ded4hoC5Syb9Ji4jcqeUpWXN6DFkaxsjga05fscVaEmEDDfa7/1b08ekZn5T7x36GvumYhUbtZNdirr7tERwbLDc6RxiVNtsVCPgpXiHS7/q90HiDn5lbvPB+JU0sUIyn0hxqVUh65tTAEtNAGD1wKqbUupCrunynA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fI621uMu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fI621uMu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flK4s1rdRz2xSb;
	Tue, 31 Mar 2026 18:10:04 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJUFzEWEnxy2Ixa+1VRk2QhZXMzKrmX+PbSyDDZju/Yi0BWLeP4s7MJEBV7xw+wBBnRMqeXXOHzjTqUfK6At3BD2WCeMllxamVWXllgURlka/Hmpic6wTf8Lrpgl05013hLOCVbu+76s+wz4u+vOR/AI4nk6l2xFxXjg16R44Q8DBFlHJKQJ6zAQZLIdGE2kGRZi2Uj2Ttx5Gs5Eqw8Kt9EXO6pmzxYxdlgvFDUUNIeNJzzqdfcGCBB5oaIBRMMHeSV0J5H2+c7PKHEc6ITG+xNdNInNb3vICLHwf5DtUXRPJTas++B18WeJkkkKHlBFEDlwsf8DGo+TRCkECIiR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycNdKDx/VNIReNYYQh2QBg0TAIdAveqPso8i8TgLlaA=;
 b=PiwQyGHGPYaWUDqjQh7XgANMDdD+lwaY/LmaHUe8+H0PN5dQ2p751VUvjWFQbHTekbR6oPmL8RdioQP5G3V9dTn8gY0C1ssBrPLfRvgcbb8ID0ERHpkvBtwzAarehaZpjrZ4q9VNVVyTCw40lEKbnSeP8cIDpgOpFExGwO8fSdW7wRBHC42e5pCefCXMt5EdlwhB6LM7t5hL/y/owKAArwVWksjN4e7+NLiyd5sBg9XHXE3ixGPZgFeogzVv+x+4EGtivegXiAe9evhfpw9u/tWYMLC83oKSrSIH8GrCesOG7QXGdW9wJBFky7CqnFqllEbTcBOduvDtMuToNFAEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycNdKDx/VNIReNYYQh2QBg0TAIdAveqPso8i8TgLlaA=;
 b=fI621uMuG0BD2cYFiUSYJODMYIuzRJYxjz1975YfsfQiQ3L4F5E/4d28Cs2r0AVC8vj9YP9xheSAIsC6z4GH8z0sHpsN8sFzdK9u/n0xBH0NmdVo2UTZvtYQX0g0jAvuyl2Opie6Sn7w0fW/dmFTqVbsn9Z6Pw/u53HLYmUF0xQ+YmAz0QMOcKyTcW9OaDZG9MPNpbdC7PjHvaVaNZjHOcVlhNKXTpptfme7/ooBVJWbo7jNWwUIBMpNENJ61uugPHLjQtFTikRbnAFqpkrPFhfh81csMYP1xg40yZeaMKKhrTy+C615TO7rnWoa/s3Q6CIetyDIH3Ms/J/sr7gQHA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB5870.apcprd06.prod.outlook.com (2603:1096:400:338::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 07:09:41 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9745.019; Tue, 31 Mar 2026
 07:09:41 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
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
Thread-Index: AQHcwB5Ez31FCAF2H06H/moL1lfWeLXINCEAgAABqPCAAAIpgIAAAW0A
Date: Tue, 31 Mar 2026 07:09:41 +0000
Message-ID:
 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
	 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
	 <20260331-fanatic-certain-bustard-fb13bc@quoll>
	 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
In-Reply-To:
 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB5870:EE_
x-ms-office365-filtering-correlation-id: 5c5574e0-98ea-448c-404c-08de8ef47acd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 fqX4ptwZsFo04TtOr5OsyXEGDdeDjyIUFA9raKHL/gBAsGfOm0a+AwSD5mhFr5luAtgmmM5eF3xCIwspzQHnbN6FIuneDIFOxN3sTXSHIsYpG7NXE1HXhLOe5Crto8tGGFy2oMtY1V9/wsIDcs9GMvhtNPzBqm3YKkYhPOJDHZnZIjRUlB5nLYdyvT5Eq1ZwsBeF9qdchIa2eaHFmttIffVniksnsRJNu3asYrrpHgan1VI9vPOxTZ2BJv27GcWAPOlQRf+in6sRSJ65ScYIhzT6ZYOLzeAkj8kOuouLlg8rPGOGGEY+ywhu/3crI+MzCQ3utPu8OQlJMyddNFj7aWiDfUiVBvdsL97i5ChpOd5R8HMBRRs6Pbss0UgU1tMzE7+ToHJto8CBkJuwrKmWcJm2uUEBV0T01PWuNFngD9UulGOtIdyoB0UAeO6Aja7xdJt3DE/nQqH3A3WQC/2RFntFCv1m5pmjE1DdR7+rPZiKFsXn1Ldb2fYn5z6oa3K8uOoGcUlfdJp00mYN9JUiI7N6PQcik0npjRC+YYeJlj7HYnE/PAmbhjykvb8ff/nIRrWulCYzPbMRdirzKIWZCg++hXdkQw/vD+7JSWEGtTmgEuu43n6W/LgBOAYOPwrHezGsW6cU6AzdJDtj/RleJTXqCy2utFVxLYBe5ls+gD+DL5NW7UPU4QiiTItGB3Ga1r8zzKexi2nVqFKbY05Y1OGuElBiY+Jkaa5xj+8ztad/aY5Q7pyfUlOgu0wgDnKoULmPdWWYy5IxoxWlXWY0P/jzE9p8nQDJw39UpjwVmm8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzJlNkFuZk80L3RzRlZZcERTK29YdmF2alJQdjNXclRqbTY2azBPSjlwMTVq?=
 =?utf-8?B?MjczMUFkZWpCdng3YjZxUXRkbG41bUxhdzJVeEsydUhTV1FEYlFOeVhlZmMr?=
 =?utf-8?B?clNFb3FTcXhUVVhPRGliSVlyOFJpTmdwekRLd3AwUWxSZnBISUdiUEI0M3BM?=
 =?utf-8?B?dFhHWHR3dWQzdDRld3JrejFMZW5vK1Z1N3RiR3djTkNoazdTSVJQcVY2N1lt?=
 =?utf-8?B?MFNtVHFCay9HSHBaZWxGeUZ4bVFOaEZkTkNZTlJZUWREWndpQTFDOXdyMHNo?=
 =?utf-8?B?QkFWUUdKQWpIUEVza0hKUnFDeHVCdVNNYUoxcW1CUVNLVzNSZjZBN3BUays0?=
 =?utf-8?B?VWZ6NmpsbVJmaTFDRzh1OEtmbEN1Zkp6aGJ2Q3MvcFBrYzcxTWZSZjZOdG1t?=
 =?utf-8?B?R3BCc1puTEV0YzdrRmlKS29mNG85VHVIV1g3UjJNajdVMkR3TXAxaW1ubDFT?=
 =?utf-8?B?ZjkvcUNnWDExSEtCQmRDVko4dGhFRHpTVG55clNnMVBEa0diT1lIU01BUFdK?=
 =?utf-8?B?UDBjRmFIZkorbmhUQlVjYldZYlZ5MTIwT1N2NnJDMkpFVjJOVEE3MzZFM1hj?=
 =?utf-8?B?TWtCeEFoQ2duN1pDV0pYNWU5djNEMGtGR0cvaDhZRlgwSE85SG5lbTV0QVRy?=
 =?utf-8?B?NEppUVQzRnBGenlkam1IRVI4SXJkNHFQdG9SbmNkeXNjc0xUMEpYUjgxQUti?=
 =?utf-8?B?UyszQnJEcWpGcFYzbXBzb0pMK014VksvRUdiMmRpSzZMaS9lUU5lK2g4cXBw?=
 =?utf-8?B?MHdqRTRIeGdnU0owS3hhSW43cWpQSWg2QWlxei90QkY5Q1BCQ0Zlcy9WaE5E?=
 =?utf-8?B?VEFLVnJMRnlYblZrWHNzRlE3UEd6d2lKVjYxaVZGWmczMFROSkgzTG9JelRC?=
 =?utf-8?B?NUVvTWhTTlp0UXRoRWNGcW5yMFErdm41R2dUQ2tpMGFuQVVDQkNmUklQQzRW?=
 =?utf-8?B?bjRIN3Zkd1ZmZENQVkF2MjlZdFgvT3NHZWs4R3VtbnFqTjZVZWdhL3p0OE8z?=
 =?utf-8?B?dE4xeVhEU1BrY3NRMy9ITzdRZkVXaHlyOUYwL1ZIV1lscTgzU0EwK3Nuc1M3?=
 =?utf-8?B?ZTZLR1lyYWRWelUwNVFiZlJSOXpCV3lUelZaSGNURkFKSnJzTkwvaGpSUXVU?=
 =?utf-8?B?aFpGVXUxRkpkUDNxZllSR0pkNkVmenhxZVU4Y1dHekFlejA3dk1vVmVDUWpB?=
 =?utf-8?B?cW1rRU42SFQ3V1N5VVdtN2l2T2E4d3FoZmw1VkpMTHdhTytLVnFZSVQvZTk4?=
 =?utf-8?B?NmcramxKbk0xL3JxTVFvYmpuNThDK2lTNE5SVkkyZUl0MEl4b09iOVJIS09m?=
 =?utf-8?B?dS9kU0FBOWpXaldtNmE4N0JCbk9jSkFVM3hsR2g1OTBnRDgweXFjUXhFeldn?=
 =?utf-8?B?akROMVl1SUFMdjczRVlLaFlxSWZEK0xwOVc2OUVtY2hOZmcxb2FTdUhSYzY3?=
 =?utf-8?B?U01LZkZ0SEM3ZTM2d2NlSjZYUVVQckZIWXUyWlNFc1VkU3RGSmZhRExCVFpu?=
 =?utf-8?B?bnRaa2FyM2JJUnhLMFFqYjNuZHh3ZFVPK1BKNllWYnE3V01KNTE2REV5M1h4?=
 =?utf-8?B?RkJiVFp3SGxKaVdBakRSSXgvb0pzR01lVDdBV1d5cFJLZ0Z1WUpkcm1rdUtK?=
 =?utf-8?B?M0ZhOU1HMlRDRjdQSXNOK2svTXgvRDBJTkFUbitWamxzb0p2WFlVaG43RGNI?=
 =?utf-8?B?TWVSaE1yWkJWcENkYnBhWjVPdnU2ZjM4cExZU2w1Y0x3Mm9aUW8xeUNYUE10?=
 =?utf-8?B?bS9Vc01YVUpxcU43b2p0NVBOMitZYWIwajRKd28xNmJDOGdUTGtySzFJWXky?=
 =?utf-8?B?MjROUHJkSTdMbTNGNmYyeDMya2xJOTVuMjN4VW5jSExOdUVWMGlvSUdTWk5O?=
 =?utf-8?B?UzVwWVhPSGJBemwrVVJlZVVSdTE0S2hLZTF6Uk8yVFlGVVhTMW1SbjYzL3U4?=
 =?utf-8?B?M0t0YWpNS1pIWXdsZ3JsWFdyWkZhU0l4T2puUXF4a2pVWmk2VGNkd0xZcjMr?=
 =?utf-8?B?UCs4eEF3czd4SnIvck1WdEhZMm5YSTdHbUV0MVBLbEpFY1FQWU1RNC9wbGFS?=
 =?utf-8?B?SzhVYXVveUFtbG92Q0lHaFFLQzZWOVBtWnMzaTU0RlkyWE5YME52YjBLTTJy?=
 =?utf-8?B?T0dkbkRKMFhEVG1IdEN2S3doMHV3YjQydnJhcG1rcXdad0ZYbWsyenh0dWtz?=
 =?utf-8?B?bFVZWWFGKzhsRmNzZUhMUldBSTFFK09qbmkwSU11bXdua0VUVzM5NHVIdElp?=
 =?utf-8?B?Wk9VNHVvVDVOZmpBQy9EKzBDZnNqa0prWm14UURUSk5HclB4YTNGNzJNMlF5?=
 =?utf-8?B?c3R4ZUdVYUdlNDVRamZjMnhGbllPQ1NkckNXdUMwZytjUVlLMnZPZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5574e0-98ea-448c-404c-08de8ef47acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:09:41.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh0i2h+rKX4xJ9hh2Sl+ButVwHARLJ5cntQIhjoO8HScS0Rz2uFNvSnL6wI/2GhKuJBBC1GZde3EGR5H84IY7/b+9uiRcXEERjPD8Pt4nyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5870

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyOCAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgZW5hYmxlLWRtYSBwcm9wZXJ0aWVzDQo+
IA0KPiBIaSBSeWFuLA0KPiANCj4gPiBBbGwgQVNUMjYwMCBJMkMgY29udHJvbGxlciBpbnN0YW5j
ZXMgaGF2ZSBETUEgaGFyZHdhcmUuDQo+ID4gSSB3aWxsIHJlbW92ZSB0aGUgYXNwZWVkLGVuYWJs
ZS1kbWEgcHJvcGVydHkgYW5kIGluc3RlYWQgZXhwb3NlIHN5c2ZzDQo+ID4gYXR0cmlidXRlIGlu
IGRyaXZlciB0byBhbGxvdyB1c2VycyB0byBlbmFibGUgZG1hL2J1ZmZlci9ieXRlLg0KPiANCj4g
U291bmRzIHJlYXNvbmFibGUsIGJ1dCBiZWZvcmUgeW91IGRvIHNvLCBob3cgYXJlIHlvdSBwbGFu
bmluZyB0byBtYW5hZ2UgdGhlDQo+IGFsbG9jYXRpb24gb2YgRE1BIGNoYW5uZWxzIGFjcm9zcyBt
dWx0aXBsZSBpMmMgcGVyaXBoZXJhbHM/DQo+IA0KVGhlIEFTVDI2MDAgSTJDIGhhcmR3YXJlIGhh
cyBvbmx5IG9uZSBjYW4gdXNlIERNQSBhdCBhIHRpbWUuDQpUbyBhdm9pZCB0aGUgY29tcGxleGl0
eSBvZiBtYW5hZ2luZyBETUEgY2hhbm5lbCBjb250ZW50aW9uLA0KSSBwbGFuIHRvIHVzZSBidWZm
ZXIgbW9kZSBieSBkZWZhdWx0IGZvciBhbGwgY29udHJvbGxlcnMsIHdoaWNoIHN0aWxsIHByb3Zp
ZGVzDQpiZXR0ZXIgcGVyZm9ybWFuY2UgdGhhbiBieXRlIG1vZGUgd2l0aG91dCByZXF1aXJpbmcg
RE1BIGNoYW5uZWwgYWxsb2NhdGlvbi4NCg==

