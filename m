Return-Path: <linux-aspeed+bounces-3531-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A5E68179
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 00:34:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fK21L4x57z30T9;
	Mon, 23 Feb 2026 11:34:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771806886;
	cv=pass; b=mH/+qd11YOsEjsEwsSJHw4BJ9+xt4dZBemwQyWnQxzvyigxhjtzm8IWF7Ix4+YoUN9gExtgt9pnWASLobMrnh9uQ1P0HXGHlIR1VJ1xsyDb/fV/kYxqosu82d2D5qGNpuB7o7m95z5Za23GbNngMIU6ki70oXLEH5U5a4CnS8zQP5akrCYYvDLJd5fmyeaJ9ejLPjV9ONnPU65xWLnnwSKdVuF4cF9AwsXJ/XsBWxDyshX+17610E6A12HBUyofD2+041lER6gCRi2x5q6j1vRJEJWenSQ2KmIoYGcnFWl0oVTC5Md8RcOMjxEWZ7yPUZuE5gJq+TNUh/65bhDtgiA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771806886; c=relaxed/relaxed;
	bh=sXhqVKHgf2aCIdJtdmAkvMkFD/ziKzq5lxEbvTXWMOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTEEOUr+/IDshhlc16XfZOqYwYXKU3BcO6nNtKHzLdC3fReFz/8dHG1Pf9p1IO00AUVt+amIXAhXv7fRA0PTZ5M4uPWEfGAOqRX2rMNcNN7+1hJSz3Nm3gB4TifYcdBrfK39Xqd487Mzmv6PfkX2h1W10LKKrgcI0E9fm0DDtqoZOyZ1vVNPMXv+JU7r8ha++yWnhA/QyfPyswj9ZVlUmg3xv+Xc+UWW9hF4siSHPbeOFtxQm+lJ6qi1cb652YMt7QNSubX1J6a2B1ZXcKgkLeX7JZ93GQs7Q/mgNZRG8DddRP79RQH/Sac7BH3Trg1HIOoNWSiSi3fWHP9r5mw+7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=IkRKF9S4; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=IkRKF9S4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fK21H6ZSCz2yrW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 11:34:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMxINZTNPFHtMg3hvd/nPsK4iSX+r7RnCr8fXFs7F258VS2T/IMjaVIKlqezrJpnzgsxQOPzq1MQO0JGlZbc3v+1LFTlDAHZAZGCZ/4MsHxfX/IVGG8Wtc6Jg/deStRlHowAGdqDXfCQbiKbiTZD7mupTfMxUkSMzu5IMMW+erTR6EW0Zl5fu3f5pmvMZoJEQ2OjGsUEHW9Nm9A1AcxWU30kkH2zFs9B/qLe+3xkJDKDj6/EcjEOqacOXwEMLpPPcMjpwwjiLkk25rpLSPLPnKqL3zqAQetGp9GtUW/J0ejrFGeOQ0Xl9sGqnMJHZy+rFnH1RHpKuBsjK4Wqi6ITtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXhqVKHgf2aCIdJtdmAkvMkFD/ziKzq5lxEbvTXWMOc=;
 b=UH5lu6iy57emA4/SvSXKVLD0qUm1lq2A/Lwsb6IOYxm1eYzwCJp0MWD0Qrga4/6rzjQ0Sa5F+Ydk9nYLSyKhmBTW0WYMzOEEDZbBUmePNxRUK19QjGdPUOEfyvKplJyMtoDwBFwXCAcfz1kv9SUTZK1MvZib49IDMfFuSO8KyzxBlV/OWql3IyBbxVzXMPXHW4HfaziqgVVvM4VqrZFJJzPPrrjVPj9knF6ot6/lYPyo/sipgIZH3DmILSiHKyVU8CDYXQBI7jR74CC/OL4/0BRieyOHPgdJTMUK+FM57er1UzyweoxF88dVNNBNOz51OpPnVGFy9SdQQlWCJGPw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXhqVKHgf2aCIdJtdmAkvMkFD/ziKzq5lxEbvTXWMOc=;
 b=IkRKF9S4abzLvMHBxHoebysb2cFBQ1tt9cvGUxpiQy3aSTOTqnHti86FBVIzE7Zdo/HyXOn5QRf6XAWhz6Sr3xV/9I4nKET2xPiDPl8V7tlrFh3pANbS9M//w09eRgMaY64/o/Nsn1Yk9RC1GyNXC7WR47D27ASzsp9VPg4qNfz8QtQ4DO+yaL82t9B3Dz5uCF0sjeBWxSS6ZPa0fYMaKSjhZneANrBwcxDqUlAFFW4GCbZlHqw7TRfK0+ByDLfNTZ89RfjVGE2DFwypTls+21N5SoM6+UZNI3QOgN+oC9BZhdq1tMDNeM1UXhs1Hzjy3zPaGkyD1E54RBq8FTLSoQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 23 Feb
 2026 00:34:14 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%5]) with mapi id 15.20.9632.010; Mon, 23 Feb 2026
 00:34:13 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Brian Masney <bmasney@redhat.com>, Felix Gu <ustc.gu@gmail.com>
CC: Joel Stanley <joel@jms.id.au>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: aspeed: ast2700: Add missing NULL pointer check for
 devm_kasprintf()
Thread-Topic: [PATCH] clk: aspeed: ast2700: Add missing NULL pointer check for
 devm_kasprintf()
Thread-Index: AQHcoK7tRtTFTF1ysUyPdg972tPBVbWIThyAgAcoQ2A=
Date: Mon, 23 Feb 2026 00:34:13 +0000
Message-ID:
 <TY2PPF5CB9A1BE67A74D4018FA3B4063314F277A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260218-ast2700-v1-1-2388e0fe3597@gmail.com>
 <aZWfESmMIw-e81W-@redhat.com>
In-Reply-To: <aZWfESmMIw-e81W-@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEZPR06MB5899:EE_
x-ms-office365-filtering-correlation-id: 3a25b960-4f87-4315-4129-08de727344fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s8j4i03mz0pCGgcmoz1lhhZwai/bsvgPL5UNg4Kr0VSN842OtLInE/21Hy/z?=
 =?us-ascii?Q?8s3jclNG2PvHuS0B3F+kKyZ2ORhGv9ODavNn4aa1cwn23a7D8jXZcEC2EUtP?=
 =?us-ascii?Q?Pp7LUCFcXvJ51/4R2e6kIIn1/OTuDGd4uppXneg99+iNtolidVSkZhUlxEYD?=
 =?us-ascii?Q?vPxTbyJ5Xb6pJLw453BajgfGt8QS3w/4u8xUIVseuhekufuwxgGW7gIcQmhS?=
 =?us-ascii?Q?ujFed+SdmVL1t8PSvYd9HlDIldwOYOKUXC2gqnLDXOH6Ax91puUTaRRhhG2Q?=
 =?us-ascii?Q?QHwrTCfPWGh5IboPUF1+m77YC//ue2PPsgDwMUwLZ4y4i7lb5DwC1S6gr0xe?=
 =?us-ascii?Q?XbFyLVniWY77I03HHuW7vkonLtTWI6IrejQCCSc6Ihlux67AK8kxHMKpUaDQ?=
 =?us-ascii?Q?bcd4Mz1ojSUwMXXeOhmFo3qNjlHxVgpDytbEX0lbuijjDhIDEQGWpSgeSsFg?=
 =?us-ascii?Q?jHQFpYxnyRO7a1LDtAk3tKKWYrdQ41jc690PTK/04h2oh9IW6D6kC01x+RDZ?=
 =?us-ascii?Q?geJlrKLeD4auTeKrGIQ6GYBICxJlQk0vBMlGCU/MM+5JZMgtWCmf/O50bPXA?=
 =?us-ascii?Q?PIhRIss+w3lM+4zIUvvLSV6cfGydmYEa2MPPZDXNEI0J10gCcWUkv6iIbmoM?=
 =?us-ascii?Q?yZEkgqug6pAJfrDMyZEWEc4YQRpMOJCoSWJ0tD5dsnttMtNvDFgzn+OgD8xc?=
 =?us-ascii?Q?nF8VWuIkZzuWUvz1RQ2MTec1uyiN4NBkO3yO/vDn4W5+41teLP9EmlBPBv9V?=
 =?us-ascii?Q?fclM5BsJL+0JNvMfCyEVDRjvgqX29cvRgiQkt6zm6ZLSBbspi/qRYbUgyA0V?=
 =?us-ascii?Q?pEZ7jilpVS9jDDfvJPycjHTnWRyN1h0Kvgguec+oG1fhAQVMCPDJ/W0vkt0C?=
 =?us-ascii?Q?ayCJxXTxSG8R6Y3OQiuzL2Ols5U4Y3u44WYttnLtX1Om03l3WyBPl/skgEtr?=
 =?us-ascii?Q?wFucn/FTlgVvIPWagBtVTc1pwMYOFVeM48nXyR4Y9EP9ySkcyWf1BYa5XD1D?=
 =?us-ascii?Q?2mDji1JoJ9TftJLhZ3cMbyiU7sBPyJHhXr+g2wT63xFYFRowWUEuSGWUB2Qr?=
 =?us-ascii?Q?mBk/2cm3gKaOGZXDBF263tqfBelItOgxpYYsh0IKhrNxfGzLwyIsbeXkKQkI?=
 =?us-ascii?Q?o72An2zF5DHpqvrVUS+XA8CYoDc/D5wc7/Nv5Ra7xwcXqI6pRCispvpbRcVK?=
 =?us-ascii?Q?UA3mx/ZDnjR39uMTTH3QgoYUVD5l8tQPpuR6Ma5kKmiXpXjkzEs/0BVQq+Uw?=
 =?us-ascii?Q?oHE8X8sw8sr78C060/NsPP3qTqjyepNevqQGREK0lvPf9WoPZoZX6sB+KCHu?=
 =?us-ascii?Q?bq9LrKmjJKWngkMUHtyzVD9bWfvStqNi82J0dRnCDHqz5P8uTuAJB3v8IAnm?=
 =?us-ascii?Q?rvgrTk1j84nQ30GR7lOY8Jj18xnXp1jAMiCne/Bx1VRxVLQYsJQHxyz9lEkX?=
 =?us-ascii?Q?yqcflJNAwxaD8QHsvn2qcGrXpS07rgATGXiO9thF13B5Mf8y62Bj17RHaJx9?=
 =?us-ascii?Q?ay9H9cEU6kCtBkX6JQdFVCmWLEhCYe7hMSySQqGPNnCQrVnqNJ1uvcsXnRSZ?=
 =?us-ascii?Q?XWPHOQ9Y2u+rWqYe4G/BsMEJNB63CXGYosrFGvltMgd4ZudBVuguC2p7dYSy?=
 =?us-ascii?Q?xmHAQbbdtrGG1on1dA0dNDo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?haevOXQGt/Mh4lxD4jZxVhrPtKnRhWkK3SNEvAtakSsxG+So9mC2G5bf0H7l?=
 =?us-ascii?Q?18D5YsqTo5sWj5/YQMpdVMojtldiVL1wP7u8IxL7m0RBK7uFL8vjbb0iQZk3?=
 =?us-ascii?Q?KHunqmOdqAanq+dmi4m3EDHhcZa+2SwB57JhMovpFj1xvaPfrfSRY/hvduPQ?=
 =?us-ascii?Q?7gi/QhJ4U+8YAxhFNk7tXEFaxS60FicD4BpSMFLav0ok+XMdQHyTbiJzSLPx?=
 =?us-ascii?Q?8GYJ0UjRJ/Tv+zHFgQYGoOb/c7NfcDGap3RUrWD0DjLUmuocP+XnAP2qfeMQ?=
 =?us-ascii?Q?0WQ2NjwoslDPnAqUVzyFaIJLCNSwxsGCquCOV9UqYqL1xqLQW1MzYnj4eGu/?=
 =?us-ascii?Q?nM7pMm/MzpwjxegwEnoU8hbc0nQN9vyuJurfDsH6zeeJ7JcbTmiem2/Y+kWK?=
 =?us-ascii?Q?Ph8b+Fyx4EkakWxNhpLZ1+rD9pUvjcCtnNC9u0KWEgcW+W+QpbWTduzx7GdG?=
 =?us-ascii?Q?rskCeeB59G49nwtKT4t/Hsc+xkKVeKlsCtt0/hAlShsGzhD0xo3FMQSNs0+U?=
 =?us-ascii?Q?cR5lF6awZCV42QZdk11qnYl2pjKttZf2SwsD0kgHGffbFaRqKQY1xlfwCqtq?=
 =?us-ascii?Q?kosvYACVrnvaHDfFUxlBfFdMTO1pYiUPgei7xgeZvEjqycSd1O2XlHSrB/BQ?=
 =?us-ascii?Q?8FdHKXjywYNwOzpL75ZVCq96D02MA05Wl48PlAWoQzqzJ56p0xdndrn3IKew?=
 =?us-ascii?Q?ISQTy9bzehYoa3t+8eMBwJz+/WdbQOgXkMgq5IGtCfUHuRAxjtD6XpHiZ8pS?=
 =?us-ascii?Q?NVx1wOTEZs/1yBai7ZUADCPQ7tBJ96sjybEgfQrCsKgqq4K5W1/E/29YY1I4?=
 =?us-ascii?Q?etokqOHhv4qoKpSonN7e5x/r/RlWmAalDEAVKQ6UCFBr3LrwnudysfyD8iYZ?=
 =?us-ascii?Q?WnBLMwOjW5qaJxeDMhBtWeZadLC4lx07PKa0Pxlvbre63i0qKMhbBSsNwMVb?=
 =?us-ascii?Q?DMCuhDZsPuETfYMdqxDBAUhA9J6fvhHBUUnsMePQOpnuV1lWK2ZCVmKTnXdt?=
 =?us-ascii?Q?JEO92u1UnWibGLOCy++Vww7Gk5KuobuSvWVdY9/6iz1YxfH11zgOEP+s0T6D?=
 =?us-ascii?Q?Wy4L7WXsQsU8bAvgpQ45DmBVgY5kwmi6iLppEZupfzaozfCAmCY1Y0s44hNN?=
 =?us-ascii?Q?iX2ljdLeJeN8QA4f4FTrBMzpW/hchD8A3uavyZBKAkFvJorXLKUUmNbjFBHj?=
 =?us-ascii?Q?7mLJ77w290zu31DobbErhYghEDyNeG17AR4A2xQw3PlqVYD3/z5oVhy8ctM2?=
 =?us-ascii?Q?dm6NhT7VMtn2o0aucKo+N7bwZPFVVjav5P3l0V3S5Y1/iTYNPaoMpmPbpZ06?=
 =?us-ascii?Q?ql63xxi61QFu8bXt3JGT1caARvSB6GLuAd5+Om5IFNRL1TzrrC9aEHPyWCQk?=
 =?us-ascii?Q?MFDfVdz06wsMGnuV6sHRECkl5FWS2V3fr8IvnsaGmHedcbFQQjMSSEWFJ/3z?=
 =?us-ascii?Q?Ym+ohcK98IE1vCUyZhmeniiaT1WO0LM/ytwSQO7Emq9NMg/WBYjOsshkmJ/E?=
 =?us-ascii?Q?nONB1F+Z1o5bbOAdaonjgvaqdu3K53Y+YRADuIUTShu6c6hG08x6O8d7SHwL?=
 =?us-ascii?Q?utouSG+dYisC8GCHIX/889ZidK/47Dypl8aVy0V8BBKrzf7U6Ga34YNMfUam?=
 =?us-ascii?Q?rLmQ2/nhGoVYVMlJtn7GUZnvyHNlxCt+ttdJZuCTcJITZgEDb576jyQ1NA5Y?=
 =?us-ascii?Q?22kC9Nvkv0Xgf3syrxGbb+uRxSrDAAN07hss/Q4Ha/V+QBh0+7VTz3ejO2ub?=
 =?us-ascii?Q?wNPPpfxYBw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a25b960-4f87-4315-4129-08de727344fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 00:34:13.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALd8ktcbzRWK77iA/sHqotX+wEpNeeeYZmrSBWPYBm2O/W7vQ0bLY6QGhT5aC5rU1B8pQ+6LTZNzgbsFVmQ2TVp4ZSez4Jys21PZT6qiTZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5899

> On Wed, Feb 18, 2026 at 04:16:37PM +0800, Felix Gu wrote:
> > devm_kasprintf() can return NULL on memory allocation failure.
> >
> > Check the return value and return -ENOMEM if allocation fails in
> > ast2700_soc_clk_probe().
> >
> > Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>

Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>

