Return-Path: <linux-aspeed+bounces-3762-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B3BFEA834
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 08:41:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fggP73jdbz2xPL;
	Wed, 25 Mar 2026 19:41:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774428091;
	cv=pass; b=QR+6hUugpD73r18CI3um42f4mNwneQe/Oa1H+GOqNDf0gmmABKxWFfrtyVXceG40O3ek+t11Sk2tf17vSOBXRPW0swZJmNyivZMiDyWLjFUeU+XndW4yGiOMJedGSYQqGF6hVe6wb30XCpcZPoUr2Iw5k5PDxz9Wu1NMl6W+9wuPrxIO2/bixOHZcXqD+egqxXLdz63j631tAUGx/ai/BZsTu+cqJGTwlS7KqTwHAbfBtrB5WyoyDNCDO2AWBIYB22Klc8qSUzvWBAPIUOwKuqNpOq6wxhg8qfhhXh0u3OVPdLq3LRdQXsiJmCRtGZjJ1rTFIxcCywuusV8Nis34KQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774428091; c=relaxed/relaxed;
	bh=QParyW+sfsMB5ON0FBQTQ2wiUTVagLtJMsYwVBdi3dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zz2FtTpGYni2C5GVHQSth2ZMoCBQJHiddkrrJY5fyaF4shAQvK8IYuRACSyONywKD7qYkubfyZElSRWEoxShKx1FsCs1mX2C0enJHg8lclOvTLUOBmwgFMswyjM41MmnHmjM7S9MuvlScD23D7Gz7O6YWtHNzT6lZHhPIC6wm77Bpn2FDOsNtCSIxvi1AGVnhmEKkvqGddPoZJTabcn5wtz4zxItF+EDAFn06vI/gjUhWA7NZCMN2+7I2AI8cELBwiMA+0oeHl0uDwG4H3gE2KEoTtyfmNKNNj/3jkcZfP9azsjrejUVtCkDF3eeoh/8t/UC0zA/tovxsTxQDxA9Rw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dLa+tBQu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dLa+tBQu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fggP625hYz2xMY;
	Wed, 25 Mar 2026 19:41:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja0TPzJcYCG5RUof8xg0ZOApCQOpd2gLA2W41G7fqhokFk9cjxZ7K3lbLCOU9/gQVBTPk1lEQPxRLRud86oAhj9EGsDGoYVVM8ZDRIzN95JIow5HLC4Oe1MjqDK1Bbw359gyKHQwxDlxheLvDzksI699n6WRZM5OJvQ8AR67M3MluInVJVBoV+rvFOMUIZSXQFQ5EENW/t9R8NTH+EoyncKPzSED1OKYKMsyb44wCyf0zwfHUlENYANOplKLSmqrLv46Cmb1cNh1QFtEGl6Cw0dCEEN4O/DdEL7Fo6cgY8LLvimywtC7o19Vfy4Klft1gqj9cK2o5RJYNjeY1qI/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QParyW+sfsMB5ON0FBQTQ2wiUTVagLtJMsYwVBdi3dw=;
 b=bnrQ0d/dqwoKmTABEdRmQmrA7hODfuJH3+NSpUBnmF524S/qOvawq1FEnSISKCFMwzP8x/T2xYjOj12hxebaZ+u1xIJ03Lwzk51d0n8JjdtKZzlSAwZg5MhtF/Box3WqgxqaTX9O2iW8CNl4eVx0ahQRgyDBLOdCaElrnRWHlkgk3mtibxhTArjT28XwWgbewVsdS1t+gqECWK+crHPcXvRaJ8jOE2UFMzy8R2w0ErZhNjGkcmzkTckuH1sOvRmMGcEH1/nXYVe70ckpHsEh8nSyqvcnMdwWPYQzjl2CE1TDj+w53eHcSCXaU7Wqd3+zxTYs5rMiM15y0tEygKIQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QParyW+sfsMB5ON0FBQTQ2wiUTVagLtJMsYwVBdi3dw=;
 b=dLa+tBQutAXBK2evI5WrWs0H3buehQMmwxjwQHCvuCS4prXdfRvuJ8xjkUe2zr6Y/2whSi6CWB8nOS92odghpJaxv8pK9PI4d+x2IoRNl8MObuYwYsRiB5dGsg3L5UWoKoSnf3SomLR9cJLVfLMa2tcVhxIG2AsSNgceWrxOrlYM7xJH6MZ7OuGSvdb//M+gR9LPNUobD42jTja0EzHh5GtoDotJgBcDlnGFbVX6ws31UoyW5ZvGjlm8g5hf2KegKpxN0Mt6WQf/UMiK3C2HUkdIh9Ag+tnMdnpZV1EOnSQCcOG8Uhm9YRleGAaMK4lVYUaZ1afwYcMoo4EnsMQI5g==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by TYZPR06MB7190.apcprd06.prod.outlook.com
 (2603:1096:405:a9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 08:41:06 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:41:06 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>, Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Topic: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Index:
 AQHcstFOqEOl3ItXl0mr3midS8GMZLWsphAAgABXFACAA7sEAIAAT9LAgAF5RgCADH1X4A==
Date: Wed, 25 Mar 2026 08:41:05 +0000
Message-ID:
 <KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
 <c3b28ee92fa46700887d0c68b23045b2418358a7.camel@codeconstruct.com.au>
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
In-Reply-To: <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|TYZPR06MB7190:EE_
x-ms-office365-filtering-correlation-id: 3afbafb4-3a30-4494-f597-08de8a4a414a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 J6T1U48dIvT4Q4brzvBI5zGBcuKgRS+nYNLM8AZ6HFF7hFUdZXjuGLV1Zpny5qNsTbLA2l1oo3m7jn2vINnah1Eq6RO6S4WhN4ZWN510d10UKNzDY2mUsj8jRDRFRF7N+RRuT4u3qxRs4aOB4u1kMu4l9s0NRu3Pn0lUsQKZg3krp1/dWD0EkxlGuwUb6XfkBJj5TJ0DI3cX0VwZkTWRbBCVBxwD3zbrI61jyoDIS6p/5IWnOeuepVgloZik8U7P3mk9oSwNkiN4huLEAMY095o2HqTbit1w2mKkTg+dIbEYl5r3hZAGQaWOoZPvlC2teoiwZm2ORrZhqnlir0xWiCVCj5WcgQKW3AjU+iFht5R1uQu0MsNcbEy7X/ueDVE2IrrUMQPm/IyKOcVt5FeS1719iP+HNsBET8MKpc00B6+vTzpLA4ClderLgebvvikSA7s6Nl4MYU/rc+42P/qWxlg2sXrIN9P9UYJ8XR55V2gwBShqoJJQ3MD2d/THDUc2C0puIXdl7RaVc7XGAyX1+Xl1/OeLvCja0jLNeXFg6nQV8D5FYn5sCGgSFDdWTijeiRlpMq8Rc2rwZIQMtYLEf2bfjklir4O1Ikx5C2q8EFoB5w+03jUzbMQbQhhxCYkmV/awUyzVX5z7yWga59vs11eFjYmmiL3BBl9GcCKRVCPOMa1PFXWNXTOTWnv9zlJ1SvKlf80NATx98oJZO7ZInFL+IF/tg4MckLrZ9Zqjq2bzheojLwYqrEGgNJt3M1DZv4eq6V3Qxft1fzaoIHpOY5HI4+YrOFzOqLQEo7xlMGw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?sXSaznKBOhxH6terd3AQwotZBzdToyzdinqUjgsz7KUgiJh9HO1eNzDXtajDRe?=
 =?koi8-r?Q?7aP5bIFpYCSbpsBXhKkHpEH3JQwYJ7aBmjd1onLek/TexM6bmqLlB/V+KEdM8d?=
 =?koi8-r?Q?fo5PcPp1DSpNNDb4S4ot4/tfBTkCzrTgDCHdpgWP4qGoVuxATrqhjvd14yukxf?=
 =?koi8-r?Q?AbGPRCHvVGPoZzaxq66DGguEqi9k9uixT4PX8B/Kg0kqxU87wt2oEbq853RP2X?=
 =?koi8-r?Q?P8+EkZ1bfjP6fZL8xUcUK4pqJ1rFYqB4p+QejqLavyh/tNQ3uaeRkTuPkXkWx6?=
 =?koi8-r?Q?dy+KSM6vBo9r57lluiHvYavoQTrNBoFyZtA0VCb3JYV9Uz93CGGXZZEFEMvKc3?=
 =?koi8-r?Q?mvAk9I+JSMvVNfMNOAmXlSurWoIczSBSgJfMrWgkZDjtVBys7fRXIO+0rM7TGW?=
 =?koi8-r?Q?Dlbp8ZfUslVGplikQ6kRHfIjUeKuc84wQe/arSxNPLIZM4TipTMMRnz3K35yuH?=
 =?koi8-r?Q?YNVKI3paUy5siid1pixqOxJFgiHXgE21FfOFccMPX6lyOzYqD+6caciIn7yfqa?=
 =?koi8-r?Q?ogCtQygw5hquukV5V3LCpvBaLFaDsFch6WIQhM8jKfxVnI3z+JVXZpgPY+BhOh?=
 =?koi8-r?Q?M8CLGWC/9acj/KCWE2kU6Wro5vRUkXW4CxS9XgGmbQy3F17ATYYg1gcfS7IIFa?=
 =?koi8-r?Q?Q4WpHGUvl+m7WYCaq1hZ+Qmwfoe0SV7cwKC233wkKsW2EVLHbhyssRJ/7kEAMT?=
 =?koi8-r?Q?QUWT6e41X0LP1JJ6cM2MjV0Nm7C0RqT30LC0kO1sPpkYBmoqZ0eDlZbKRECkmu?=
 =?koi8-r?Q?pm25VW4alSgVpqAiyZzE9ibFLCETOI1iLHtHJ4TkWwmOe3sDuZmNSMaYG0KrXN?=
 =?koi8-r?Q?f/DVEFbH3lrqYJNzfowzRAnhnu7IYZlpdx1JFIYOddP8pP8BuGK0268NEqHhUE?=
 =?koi8-r?Q?yKRP/U8o8b6U/XIqfyyikscG/iKIk35XDQQbtfg8ZYXDsGPf3cDPbLU1MeoflG?=
 =?koi8-r?Q?kmT9HOFp0KCA1qBV5h9hG2h59zxr9gN5UCN/CKP1i75QV+E0TvTNMvkTnIUFfo?=
 =?koi8-r?Q?WX6hadgPjbPX541/nv0jaZW9y/D/2OKppj6iZnPeHhN7sXMPvLCtDK3o/5zqp4?=
 =?koi8-r?Q?5Svw2eGUGoTD038MteN9cJLgx6jBJ0Ow8A0ZLFQGxt2L6iYqN7qk0DabeFVO0q?=
 =?koi8-r?Q?zkq7rvbBdqv8qxsflc1Sunf7Bc5Eia1SVGH+RPGqJdUKs24jU/6ZfRwexGLF6x?=
 =?koi8-r?Q?ITPh+G1sYH+YLeEr2ml+iiU/b+5hir+Q+MUwITJjbqjEe+YFI5bYdLq9kELWuR?=
 =?koi8-r?Q?XOrL9lwxzufQZ8C3R9fBZGlqyj47K2M+k37Os5OurHAgx5PkeztPd+eXEviHBZ?=
 =?koi8-r?Q?bRgOmG3rA7H6ekkcVjXL3UVzpdzfi7pasj8A1Eivmaec2l3on8X2FTpAMxx6/W?=
 =?koi8-r?Q?68DVj5d1sXUYbIlhb4HbozMiu9MdsvGLvanOcrlDdLm/KYKKbHQQN3ng6+DCAI?=
 =?koi8-r?Q?CuB8bC1LZ0DsnzDfOJyeJM0MhNW8v6QvQKvf7h0pyD3U6wKSKT4E9x0H6lstM9?=
 =?koi8-r?Q?pQrahRcM8UZGZPjZZQpBL6MPljsxwxS6SFHXFCn4rKph9VfXm35RhffVBiL0DS?=
 =?koi8-r?Q?NqFLdE/F4t/AGJLETTpDYE4HPqaYJHklX1gUcd6yI3ZbJvCD3CbRPhZ8WuXkX9?=
 =?koi8-r?Q?hhQbXsGIsjvAOYCLddk4/Ji+Cw8KGlNch0ggi5MRq9LOvSMxtSgF1cmAWn20GD?=
 =?koi8-r?Q?DM6j4QqaTP7vew=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
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
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afbafb4-3a30-4494-f597-08de8a4a414a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 08:41:06.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: acXgTrHRKLz2XG+E5oRQDwWOwhed5e/W4jWM/eqVI8M1UHm1uVNjS40fzTTszgKm4Cet1EshjRfSERQh1tHwbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7190

Hi Arnd,

> On Tue, Mar 17, 2026, at 09:14, YH Chung wrote:
> >
> > In the meantime, my understanding is that this driver is for the Intel
> > eSPI interface used by the AST2600 BMC,
> > rather than fitting a conventional SPI controller/device model. That
> > was the reason for initially placing it under
> > drivers/soc/aspeed/, since there does not appear to be an in-tree eSPI
> > subsystem at present.
> > However, if that is not the preferred upstream direction, we are happy
> > to restructure the series accordingly.
> > It would be very helpful if you could advise on the preferred placement=
.
>=20
> I think we need to make sure everyone understands what the options are
> here based on what the hardware can do, and what your use cases require.
>=20
For reference, Intel's eSPI base specification is defined here:
https://www.intel.com/content/www/us/en/content-details/841685/enhanced-ser=
ial-peripheral-interface-espi-interface-base-specification-for-client-and-s=
erver-platforms.html

Although eSPI physically reuses some SPI pins, it is not used as a
conventional SPI controller/device interface. It also adds RESET# and ALERT=
#
beyond the usual SPI signals.

The spec also defines two roles in eSPI transaction model: Controller and
Target Device. ASPEED SoCs act as the Target Device side to interact with t=
he
host. In this case, the hardware is not exposed in a form that maps natural=
ly
onto the existing SPI subsystem model.

> If I understood this correctly, I think there is a general agreement
> upstream that the low-level device access should indeed be in a
> drivers/spi driver, with no ports of it in drivers/soc/aspeed. Using
> a portable driver subsystem is always better than a custom solution
> if it works at all.

We understand the preference for using a generic subsystem where possible.
Our hesitation is that the eSPI functionality appears to software primarily
in terms of the eSPI Peripherals, Virtual Wires, OOB (SMBus), and Flash
channel semantics and backend routing, rather than low-level bus signaling.

Since this driver is responsible for configuring those Aspeed-specific
backend interfaces so they can service host requests, we initially placed i=
t
under drivers/soc/aspeed.

> From reading the old comments that Andrew linked to at
>=20
> https://lore.kernel.org/linux-aspeed/HK0PR06MB377924CFCBFE9BD40E1C4A5D91
> D49@HK0PR06MB3779.apcprd06.prod.outlook.com/
>=20
> I understand that the SoC has a "hardware mode" in which eSPI is
> directly implemented by redirecting upper-level eSPI transactions into
> functional blocks of the chip, while the software mode behaves like
> a regular SPI endpoint controller and your driver implements the
> same interfaces in a mix of kernel and userspace components. Can you
> confirm that this is a correct understanding of what the hardware
> does, or where I misunderstand parts?

Broadly yes, except that the AST2600 does not operate in a single global
"hardware mode" or "software mode". Instead, some backends in the eSPI targ=
et
controller support per-function HW/SW mode selection.

Depending on that function-specific setting, the controller either forwards=
 a
received transaction directly to the corresponding hardware block or traps =
it
for software handling instead.

This mechanism exists because some backend blocks include their own hardwar=
e
filtering, but not all request types could be validated generically in
hardware. For example, the LPC bridge can reject illegal requests. In some
cases, blindly forwarding host requests to the target block would also have
security implications.

The channel/backend mapping on AST2600 can be summarized as:

eSPI
=86=80=80 Peripheral
=81 =86=80=80 Memory (HW mode only)
=81 =84=80=80 LPC bridge (HW mode only)
=86=80=80 Virtual Wire
=81 =84=80=80 GPIO (HW/SW mode selection)
=86=80=80 Out-of-Band (SW mode only)
=84=80=80 Flash
   =84=80=80 Storage controller (HW/SW mode selection)

From the link thread, what Jeremy mentioned is the GPIO HW/SW mode for CH1,
which determines whether the host can directly control the corresponding BM=
C
GPIO output, or whether BMC software can inspect and decide whether to act =
on
that request.

Another example is the Target Attached Flash Sharing (TAFS) defined by the
eSPI specification that allows BMC to share its storage with the host.

In hardware mode, the eSPI Target Device controller routes the request
directly to a predefined storage controller on AST2600.
In software mode, it raises an interrupt and lets software handle the
transaction instead.

So I would not describe the AST2600 eSPI block as being globally in either
"hardware mode" or "software mode".
That choice is made per backend function, and some backend functions do not
implement such a switch at all.

So far, this series only covers the LPC bridge and flash channel parts.

> For the higher-level interfaces (flash, gpio, ...), I don't think
> there is any consensus yet about how this should be done, but again
> I think this won't be drivers/soc but instead something more
> generic.

For the flash-related interface, would it make sense to follow the
configuration model used by the USB gadget mass-storage function, and expos=
e
the backing storage selection through configfs?=20

For the attributes, perhaps the only backing storage object and read-only
flag would be required in our case.

For the Virtual Wire GPIO, we think GPIO subsystem may be leveraged here,
though some corner cases may not map cleanly to a typical GPIO controller
model.

For the Out-of-band channel, since the eSPI spec models it for tunneled SMB=
us
packets, we may want to integrate it with the kernel's MCTP stack if that i=
s
a suitable fit.

Thanks,
Yun Hsuan


