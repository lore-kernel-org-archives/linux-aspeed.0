Return-Path: <linux-aspeed+bounces-3008-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34698D116E3
	for <linux-aspeed@archiver.kernel.org>; Thu, 27 Nov 2025 00:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGyLy6BbFz2yvN;
	Thu, 27 Nov 2025 11:42:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764204154;
	cv=pass; b=EhgWVEu3kz5pWgswpPuJGaMDlgvlFPQvffQc1/+9NWBaAaXI2fNhvTgdhHbiRUAiDzSXJ2+LO5BXGppPomLQgJPuaupVD2jv5Ev5KXl00NIecmpVHX7Ndv2NwFS5zRxEUIGb4F9x32ZQ5E4hnxPrb8DUB6BsHm9ItKuy+sLAk0TZLJsT9ctbq4RhKnSdaVE9jUHYxzeBH71X8OWUKNef8mOWREXKV3NErLOH5D1pJbsA6OviFUNSIWiZ6C7lcKeY9gcp0YAmfG+2kQgiv0B3CoraH2e1M3capxkQJnYfKAoib3MJZ1MN/wsRgMzP+qUDruw3RZ7wr0v7c3CUezTC4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764204154; c=relaxed/relaxed;
	bh=C4i/Caz1u6zYpsNYeiyd6THKuFFLeCAFye2oxffRTJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ble9w2SdWBYZMWLicKy66NJVMAidALvGQzy8o57fwbE5mKc0SKDe65Kac5DOmAw8mFmUM+wGnLz/Sc+3NyYsg+2BTQJCv75K5lYtXTRr+HO6UA9j+WOF6Y7gNL/gKtMtOcJNK/LJHT728twf9yg3vq9QeFnWWYVC5oJbYBDouST6Bb5KK9hTtYdSN9kn1lo+019z96Ibe7seO6VLHS2SkXravwOgI4JnIH3omgTNjFZb5ICI6HU4K1lS13vDoqgntTyM3qnkj8qlWNWpXVN7NY/a3V8vKN4OT4sO4KtK2Sd4P2+I5Da/g75DsAOR+pZPApdFUoADLlhJSdel+jjnBw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=o5tij4GY; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=o5tij4GY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGyLw6tTmz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 11:42:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmOAYtyyKu7X1sRpHiojNRejF4dzp8XHJuUqlJusIThIjVlKRZcbaCdGD5FM4gqY8ZgeN3sriyjJf3274k5UZmHcgPskvhI1PLQLUoC12mThrIdeAQ+s58Ry2U7QnT0LTdPfxVHtTZ2ETGiPnd4b06rFHc5ziyaGf7aT0rCDjsw+0sDows+HQaQeR64JxiHvyd1lglqRTkA+vLG2nab2SLFKB3RqCo1Wa8c452LO4BAXvX2Tu3Sk84doRsAGvTJ1lB/xdIgedwekWydYcvETL+2UJoKPSazVHhzWgLYdNm4oJ//aUTmmlMXY1fjvgOmmne7cwa6qxY4YCKToGnD3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4i/Caz1u6zYpsNYeiyd6THKuFFLeCAFye2oxffRTJU=;
 b=A/U86R8cQj9Z/HycjKFHoO/B8ZrrEgndmqdhZFRddwjYEqh+EoeGbnnsR/iTjmj1nC3wM6ZHjIWBMyXvNGntaf4AEy6eIbYtPdUo9ljm4s29YNN33iat8Dw0UtMeRv7g50/R8BMexDYZCubJd0h5sCG1dI30xsUCYuJC6DnMN1Hj8oKhtDyXTGiatuo+YQaEEfsJnuj+Y6US2vV4/i8VM/1qHTfSolzFB4GksRZRakaw3MGIkWHYrSSrLJLNcAvg1mI7kzoztJ9PHNx2W7PMEKFvrJPlzWWz/MXv2GxvnY7WCbY0Qg8NW8a3KOFpKRXA3DcYCXCpP/GuZ/d/xLtpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4i/Caz1u6zYpsNYeiyd6THKuFFLeCAFye2oxffRTJU=;
 b=o5tij4GY552DohDud6qljniFwiwX+n/BAO9QJdVXsvCmh+r2wJWZaxaJocmVTVJdJ98FQAJIJeFQVDQtXFqxFBZ0TSFO3EWoc5LJJ30xx9Xj2j0njvDSm+HWWRUKD4GNhhg+v1NPHREodMyGH0/fof1OnXbXtvK6B97eexeej91CEy8P2lNEI1+p8CAFnizJSDib55uvZnNQD5sIaZtQO/mLMf7F2T4xRBE+mziVL8GUIVU5FeLqFpkHjoE4J313gqFezPMY2yoMSE2Coq0/u8RJIFycJKIlgh5PKyfFY5U4o+35HTmIuNm/lCUPb6WGCxFySyjvgO0jSfqqrlrWSA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE1PPFFDBC8F9D9.apcprd06.prod.outlook.com (2603:1096:108:1::433) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 00:42:03 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 00:42:03 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700
 support
Thread-Topic: [PATCH 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700
 support
Thread-Index: AQHcXq5hLghdhBiMbE2n2i9qqcwkerUFT7QAgABfpNA=
Date: Thu, 27 Nov 2025 00:42:03 +0000
Message-ID:
 <TY2PPF5CB9A1BE661637E3365B5ADEDC2BDF2DFA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251126-upstream_vhub-v1-0-910709937ee0@aspeedtech.com>
 <20251126-upstream_vhub-v1-1-910709937ee0@aspeedtech.com>
 <20251126-protegee-ragged-067de2fd6488@spud>
In-Reply-To: <20251126-protegee-ragged-067de2fd6488@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE1PPFFDBC8F9D9:EE_
x-ms-office365-filtering-correlation-id: 04b53bc4-a35a-4381-938b-08de2d4dc8a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iWAXb5meX30wOddTDsGz5F1OzVw6osbNHBvthRV4f8J9UJUOuNQ0qY/9TFMd?=
 =?us-ascii?Q?OEhU2KgSko+X+ecQ96ROaToHTrCHy1p5BmfrmlQsyxwVjQzV6QS2Jl0cyfYh?=
 =?us-ascii?Q?7RS0CdYCWavmzf6hUAP4IK7PJYW1mVGMpefBFwRaUY9b6EQnhYnU6dhP7GaK?=
 =?us-ascii?Q?5o2u6n8iwg5WxtuflP4caGKQ5KWCAonZC1PYfcAkbCQuSC0+9v2iKAMDCsV1?=
 =?us-ascii?Q?+U+3Lntc+Uqe4utmtWy1qm+/WMIAue5q2vIHr+KW24GIZLVPprOX+W0czaGa?=
 =?us-ascii?Q?wuXp9YFDczG7QlJEBuwfdyilSS3IFB1VgjHLX5KKfUnX3Jck1nj3YTFhTatR?=
 =?us-ascii?Q?Huh+d5acfj5UewwoavLQh+jHypJk9JPdNodNEFF0Z4MAWHARIXCxfRZq3kCI?=
 =?us-ascii?Q?7UKytRGjiFKnZ97hAKDZ8h7JgXVvR9Vh+6qezsC1efKnBREDP6Raxxct0XnG?=
 =?us-ascii?Q?EjjgqOVBa81R2BF5TBD2uvASR9iuRZ5xIG5o5m8SzgGtX3Y9Vx6bCQKp+P6S?=
 =?us-ascii?Q?LU2HBqkLcpkd9lLFvh/MQDNnKUDJef0h7mCygpmy0NR5kQ+wUoSr6umeeJqq?=
 =?us-ascii?Q?U8MaRg/0XaKx3O1WUdQJRs2PXKJLnxkFQ+ZXpWdA2lim8jnZXnT5SRsToomU?=
 =?us-ascii?Q?1bFI1AgLdeIvyeWNOaRHBpYbFmayZ6YXeNeWL/SR4QY5LW28mWshq6fKp26Z?=
 =?us-ascii?Q?11Thid7MwOpawv7rBWyaDOfdV+RIfx8lFMDqz9yUBadfiN0/n5Im7d11jHjD?=
 =?us-ascii?Q?2acaqlq6PG0H66KVx9dHdVzZ0TvRx8u9uA24MiytNuoA6ME420G5JxDg/kMp?=
 =?us-ascii?Q?bfmVe1ZMMUrUOqwKjecdRn2Zxw1Slifq/hLuIT0q1eENwtV22npdCX8h2QEF?=
 =?us-ascii?Q?Q82QIMAQXFVJ5zAXl3lAFYdDuc4zaYkOuGoCxcmwhkTWaFku1gaCEru8pYlG?=
 =?us-ascii?Q?4DDM8qz4ExlRukJKVcG/G/Ma7/pli8keT7ZTb4cV0rq7lhZy8RaDjSamEYaN?=
 =?us-ascii?Q?Y6tvBTe21SzXxqr10Pj94wQVDnDkw2ha8J/8SCSB5HjZJdAOzRVW54F7wuAy?=
 =?us-ascii?Q?Fwxo8JdZlfQd19d+s7pmKJG2yBbh+UaCEYJmWVLzOb5oCHbfXkPf/rJTFjRY?=
 =?us-ascii?Q?mT9NmD2IvHcTFGU/A3WhO546bYEB1bX9BTCNQZUfs+dDMlxyxlRKGq75EGuf?=
 =?us-ascii?Q?Q3pYK27Okw6tDhywWM3cZdDfEOX1s4oG+qHOohCNnmrD+CFPDp7XoJNP+tao?=
 =?us-ascii?Q?OmGXEWg9+anmxXqVkcwI7AiXaoS6u4i8HKO7RVNiunZC0ildHJRqmnK1LzOD?=
 =?us-ascii?Q?psBS+9aCm3k33TtpwGgNH7mg5y1asXPBH1nRuevw/AXnlmQe3kFsVQpIGKr2?=
 =?us-ascii?Q?51nKrSm9WxP5FfUajPB3wct+87Mga59EFKVzCI0aScl99VtQUozF1l2O1p+a?=
 =?us-ascii?Q?nC8qcKy3ygPNPdy7ZS04zSfPMOSzfm+7EK9JZKULy6Gs/NHim3QwB1S8jyrl?=
 =?us-ascii?Q?FNMPrUqsgotQI6uztL39tFsb2M/C4ZWRh0Jx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WdtRAh61xc4VuZfp1q44FKm0c5738YhbhT3RQgEIDAz36U8WbMj6Kd3s0m06?=
 =?us-ascii?Q?a1djmcDOq0yMayWB04VytfMPan6KL8JEPgKPgU0nSbwu8YHEEcNWHjryukbL?=
 =?us-ascii?Q?pB7fHh96yFo8suSBrJUcWwlEiQAEOssd6t/C3USakm/rBtYXpy5qmhHAbkk7?=
 =?us-ascii?Q?8e+NgZJiMZmUzN9rHtlcyp83jDMWOIwjxaGzdD3UE1Udz+tIaIdS9iBXIe21?=
 =?us-ascii?Q?2R/j/ns/nJNrVyupJcfKqU3hQuuOaqzRGp5s75ifRCl3Jw56vYkjRhPLWuAG?=
 =?us-ascii?Q?bEe0BIE/rxYsw3WNFNnVsMMkWIW50Lz/JsRP7spScbMnxlFMHH2owDx+N2fk?=
 =?us-ascii?Q?6P4LSS7zd8QfdL9lamNmh++IT/uolUq1AgGRTILTe5LOkHpdbYRpUkYzCCbg?=
 =?us-ascii?Q?X3AIF2B7bkNvaxu9gF4OKPLZbbSlrA7na1V/+9U0b+UMDWMHpVVCNA7t0P9T?=
 =?us-ascii?Q?3+4RaU0rzZzqHZh49SiSqQ1/8hzQq+yC60az3IqVg0UKCcjOugqY7On1tCdv?=
 =?us-ascii?Q?ZJU1CMVqsfbIpFuY7hd0WcDocRNvS6U9l4c5vpRSS6pERSklev0PKduWv+Ze?=
 =?us-ascii?Q?Otp3FcehJCB0QHqjX1em8vh5M6CdGkpK39FhSMXatOVhquK7ybIKE9mkx08c?=
 =?us-ascii?Q?pJVSYAzyDUnNxYozZ9a73PfQQa0z+jTs0h3si+gqtaENU27sMGLKTKdUDNNS?=
 =?us-ascii?Q?FekskCVlEaIT9KH8m0h1jReFWJqMGXIGImjcF1+d9QJDgtpbZejCU7ZDDXQB?=
 =?us-ascii?Q?KLii8AUxpcnjpNCORJEGI2kw1+IPObDQekUKXWqm+Pm9TdQeLj28PiYRPDAh?=
 =?us-ascii?Q?oYw6hmqgibN2ezgDaXQgthzfEcwVsrrV3WBGYQmTHmPYz3nDedZBA/nFUwD9?=
 =?us-ascii?Q?L3ubA5IirdR1mBYiy9i2wlb0VwbernJPI3ER8XJu0F1PbxFqJm+zBrkUvORL?=
 =?us-ascii?Q?qs1zUIQUVPwAIUbHhJcz2c2D+lrza3K+zRm/xEhhWbZw4fjs148cuy+C1JRu?=
 =?us-ascii?Q?59DZB3j3dpnGP/pSiWhNSJtuGhxYDeRh4GshFP6yoWUf13lo0MDx9vuMvDhM?=
 =?us-ascii?Q?jZ115E3Wn7EuJOBO9Bim/WswrR0zrxp79sg2qQGc3nPL0NLbV3gm5awocrt7?=
 =?us-ascii?Q?Xb4GqRjh+pLqkp2Gf7creMW4n+8PBrJXDD1M9uN70wpbodsRszNR+zM1+03W?=
 =?us-ascii?Q?AXGPzmVNSiAKsGFtGGRL1kuyHrE/z0jO1N6cgcaYNdgoJHmDLjJlNduleuEJ?=
 =?us-ascii?Q?VA3lL8RgCNdcgGLY22/e6Z0QAI+N4hMhP7att0pxltPTop3C3Mk3t0qzb793?=
 =?us-ascii?Q?EIUt5gfzdUebvNjr0aurZlTGh4M35xgvk30a+VKSPquuQJ0byNjQq0QlcVtV?=
 =?us-ascii?Q?IukcTJ7FqeykTIWU+lQAiK/yyQur1PQsjYOZhSvr5q13TXkYLcIrtaMfKAjo?=
 =?us-ascii?Q?xrTH+TqZ5TR+rQXWDAwnNCXD/W9l8bet/l7iJK3YpGnwr7R9m9+iPyV4Tkaw?=
 =?us-ascii?Q?X5CYzO2iS9xKLjOpjl5/wjKuGs82I4OT4AMqs5NxzvMWbHfSZhmcM2C38wLa?=
 =?us-ascii?Q?9R0CNfW3JhHZLE0umq4bMJ6cXf5euqsjmhGQMHSg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b53bc4-a35a-4381-938b-08de2d4dc8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 00:42:03.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWs+2TSuOab8NYfCvRG/iiSmVUOTSuVl70nf9nt+j3MPS5RJc+D4IjS7jHUEhoTcD+ClXF06UKFtv1kuRWU7bNDu4XztQe4/5hMrKzg4z1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFFDBC8F9D9

> Subject: Re: [PATCH 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700
> support
>=20
> On Wed, Nov 26, 2025 at 04:26:30PM +0800, Ryan Chen wrote:
> > Add the "aspeed,ast2700-usb-vhub" compatible. The ast2700 vhub
> > controller requires an reset, so make the "resets" property mandatory
> > for this compatible to reflect the hardware requirement.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml | 14
> > ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > index 7f22f9c031b2..c9ebb6e004d1 100644
> > --- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > @@ -26,6 +26,7 @@ properties:
> >        - aspeed,ast2400-usb-vhub
> >        - aspeed,ast2500-usb-vhub
> >        - aspeed,ast2600-usb-vhub
> > +      - aspeed,ast2700-usb-vhub
> >
> >    reg:
> >      maxItems: 1
> > @@ -33,6 +34,9 @@ properties:
> >    clocks:
> >      maxItems: 1
> >
> > +  resets:
> > +    maxItems: 1
> > +
> >    interrupts:
> >      maxItems: 1
> >
> > @@ -107,6 +111,16 @@ required:
> >    - aspeed,vhub-downstream-ports
> >    - aspeed,vhub-generic-endpoints
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: aspeed,ast2700-usb-vhub
> > +
> > +then:
> > +  required:
> > +    - resets
>=20
> Do other aspeed platforms have resets? If not, please add an else here to=
 block
> its use on other platforms.

I will update to following.=20

   if:
      properties:
        compatible:
          contains:
            const: aspeed,ast2700-usb-vhub
    then:
      required:
        - resets

    else:
      properties:
        resets: false

Thanks your review.
>=20
> > +
> >  additionalProperties: false
> >
> >  examples:
> >
> > --
> > 2.34.1
> >

