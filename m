Return-Path: <linux-aspeed+bounces-3669-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A80107BCEE
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Mar 2026 00:25:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXhvS71tqz3cLH;
	Sat, 14 Mar 2026 11:25:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773447908;
	cv=pass; b=EUKxp4UjbnCdWh9IVaRawZoDc/1q1FEXRNmX9nFXxhtHF7xgK3i80CK683+cKOnxLg9V/8wGZ1UPtpNu12VDbEj495tklvT8fJhNf0yQ36Q6wzL3lb/IRzsODIHepdUzoswekHPOcND1vkuWCLKrMfOKW747q5qtWyZbPmm+MFzTZDS9lTUo3FAbrEpQAgXUkzYGwbEloet70pHHKfxmzGh/xv85HQH22LFvNQCkwW1mWoAhHPDuuWlTRe1oAHDe9+uTaaQ7SDwI8hiUK6YJJEI6xRCCiEi6XVDJddPRc8WO1tgcAOR6vwiUctixAbNVAum5taSzPpx11FXQHSH2rw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773447908; c=relaxed/relaxed;
	bh=SWjaXLWXuX8xBbvy5KG+KG+3bYuL50JP2i674dYVlHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APrqcURYPlw7CwFUmkNuoGQYXrpEQCCn2y9JBkmje7hHQ7KqATSSNvAu+PNJ1kGJLxIolWJkVzCAO3bPoDHJi4te2Xmwe47USFqcmCzNi1HVHHRt6Q+WdwqJndB6OseRLCRYi+rYsulVKLN7mVCanYWcYk6KdZYksLZHeu30wB/xXOf5hMStqw+mAoDMbysbeGyjwvVO9o29gcnRAxpncEQWPs0O7ewKytwcl3Pr3TjjtQH0WcJzFGhGTGVImMkMgh/YvDBdOasra0Ky+4SOJRLxk3Z6Q+463gUqcSqkrlrDy0JmFxBNIZtI2z7egga0odrWnUC/uHEUx8oRmS0ctQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=mary8yaI; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=mary8yaI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXhvR3nG7z30FD;
	Sat, 14 Mar 2026 11:25:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3xbDB4IfLLxGWQcXgrj1x3M4eqr8LPnrK+PmLcE1TbAMv6rM4l0X49UHWnxsDv8VZXYsgRrtcoAZU0NEqOWMuMtfjfdAifjPFPVAmiodII8KytfNEvaJifGnpveIzVO9290ppoU733hLabkkh1YbfJuiwxyE8DZH+rC7zkuee7p2gR8vRTGE+HE4U8O1wP3Vh5dMAyO1GFgU2sJImScXEMj19TF+gpT6m3Yl3npcbDSi7towUhvXhQQkP9aigJmanRX2R/ez8FIf2L2W7JL6tr5OthjtJa9aVe5JGAlMV5NOrotadUc0Azrv79OJKwBr9JD1eogyXSnpKEG/B86vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWjaXLWXuX8xBbvy5KG+KG+3bYuL50JP2i674dYVlHk=;
 b=SOY+ckzgQm6ewyxlAGUQXa1XWwXyE3uo5QkQt/AA79zoTN59K6GaYunz9gTEecrFdvLqiAtWc+6McTDSV7iVeaRmW/XaHQc8DaBZBiYhf+6u3O6E/xzuOighZyovek7uDalhbNuyPW1wK8r/mtc+FWOh0d82lJhD7CeM3ZDQyEwetATDmHvTk4hfopd+vElSBHp5pmu7fHiWbk6NdFdj0l2z3YeA3DgDWAu9+QbDfFQQrTVM20IiLrAJ+EFWztzRnF601kCHkK/dF0SOGk5LY9xa5LMEpn7XE5XM5yIgx0VLHFNKh167sMSQ0VXpH7SnPpP/Hsfnj+v/2gTVnawrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWjaXLWXuX8xBbvy5KG+KG+3bYuL50JP2i674dYVlHk=;
 b=mary8yaI+djeyGAKFWnfv1oW532Bb/8qt1Jjp+C3a/50CdGu69kELLU9eFPwV8EWThF88rPo0/VMNCkT35OkhYDqZOs+bmP3CVwUVdiIk3X9bKJzhJHqNbC0IjDYiKqZz3QBDXYDJ2Y/ABN6y6BUHiyyj9A8guA48a4jqOTkJLpaeiM8YOgFbCX6+IPFrM5uRde68XKBWTBT9rBWfI2x1cqvsebYrHEln04kNQIIQRQPi1Xc8b9MGod3XDg/dqDSX1lnT+1FK9cyioYh0lZvLkeQ8+0t2RSx7WELHMnmJgZKjfjHejMDD+0jgz6KW5zrjZhlWdajAApsK9iHoEbkRQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB5253.apcprd06.prod.outlook.com (2603:1096:101:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 00:24:39 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Sat, 14 Mar 2026
 00:24:39 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, Andi
 Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Topic: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Index: AQHcr5GE+hDVSyX/WkC7T78e6kO8trWtIRWAgAAQdrA=
Date: Sat, 14 Mar 2026 00:24:39 +0000
Message-ID:
 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
 <20260313232125.GA3618633-robh@kernel.org>
In-Reply-To: <20260313232125.GA3618633-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB5253:EE_
x-ms-office365-filtering-correlation-id: d57816fa-1bd4-44a0-fcb3-08de81601481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 xxCcIP7/FK8mcjK5tsAZ80ppsWArVmh1crroafFKyXQ+RPV3Bx2uO8SmM2Tn6tbBLvGM3DC4LjiUBdwpYdqU2yxPQnepsVi6z9JXUJTWxktJQIPyiRan5DIMYGdnOjfUgIPklGt7qK0mqjxPSjaxzUsNR9U/77/eN3cv8keA8yecZr8SShtAJKHq1vIF5Lec/dnFhY4/15d6mycYD2KYEotMO/flPHl19WULBuUAxEzLxjg/aC1cl0ZnfBNl6pUjqqbiqX+KinYYSZ/CXfrqShEczwBx/cR4WNIg4CFR7RUfCwJZcS+fg87n023otzxLb/byOwKZC0wful5qQ0xQ4x3AxtEKNptWN0XRdWEcvvcuKPUzrNTu9MdjK2Kb2TnMUK8Rx7RVF4CZBPFts5F5fjoYj8XozQ2eYQk9wwMvz7EDb6tR4EPV+ju/uVE+q86LX0Ub4OCuDWKC6AhTAIW25GJa5D1SbhBHBqRPKNturaxVxkvlMbro7U98rT+uDbIJ/UhFgis045mM22bKpe8+I3WvGI3MyPO0PWlHkYHuu/cJXxuvdEvfMeAOI/xpS8080KpTEHFom5LKsP7J8hivt4XtDaS0OuAyEWjFRIA2r+4NTcPvhuxEhIFOnCGJFK3N/PTMI5twg+/gCTFWnjIakLpxT8rnLxkuBo20q3wbhlsSfwylh6PG/hun89t42W+RGJlobDnCD9p5qIwSiKvwaKfDlAOnFL0cb+JzG6sBBL9dQ4gMUg8zPrsnp7uRt0kZ7dAAOLiKvktbz89RYqrgvrXApEMkHdJCPnP0z1YTujE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OGLiDKcq9NTuDqWaKsu2ph719p+L0Pg+eUl864/kIChrStJnVBYfe89VVgLM?=
 =?us-ascii?Q?S1PTVHwTJJSPV832Orm7T5EQUeki16IlqfV8SSzAzCJAY0w9tt7jjBEzIILc?=
 =?us-ascii?Q?PdK1Sothd1QCFl8XLLieHIS82dArpA9Kn0gg2dnitXEh27oMic8ERa5OHPxp?=
 =?us-ascii?Q?5MK4WWu8Qvh7fOhf5fzmZ/qCayORfF2TX3LuGx4XsKVmd1cLrrFXP/CjIjP4?=
 =?us-ascii?Q?hmd91M7pLy+TueCfmkpXgfBT3a9RXvTW6Gy+WC64r0pD8d1+/DQRxI0nJWPX?=
 =?us-ascii?Q?9DYpO7fOHIyq8iPZDzAH9MpEnyoP0ze+GVH9/ItYU4HloqcY7mXTuyWWznOo?=
 =?us-ascii?Q?F50Nl2cdEUNMxkzmazUAEUchytAL4UY3KfOOJUrQNrmVsfu8CueCeKj7jYyz?=
 =?us-ascii?Q?Kkn3KPQ9x8pgGGvGcCRKfyir4AKmHACKV4aUp+BaM4AT8kM2KN1k5s0+6ebd?=
 =?us-ascii?Q?Ywnkwz/TjGwBWhHPD8Lk0bwsU5FocliQT9baKIfLhMN9WakJy6KfA9xIqLOX?=
 =?us-ascii?Q?clw3wJ44XHCmqw6oEdYCK0RGv9YxzGrmVRjL3N9wX1gg8Cunwl2LugARkOm9?=
 =?us-ascii?Q?aJsbBFzzqYqvBKXJ+ahiFmf2LPEL3hJGNPaeUc1Pv54atI5nvfyWCZ05fgqj?=
 =?us-ascii?Q?IzlNl5FwNiuwHo0WtmHVlu4YdAaUKKwbuMK5yhJ+TTzOlIsLgHgqeUluAKiC?=
 =?us-ascii?Q?kBSghRp2p9zFKf3YVySnOWvy3RkNrE2ikNqlugeS+sdQMgHmTdTa0PvS8bE/?=
 =?us-ascii?Q?aSxvNBeUarSMlFeBjNVm+8jFDUoxvsKSUnwzN9LmRp0Lw4BiPJBzHR4UvZ8w?=
 =?us-ascii?Q?+tBxxZVo1wALYjsuTXguucLNOOZG8W+eK8FRqEUHaS/rHLaM5cpxpu9DeZnc?=
 =?us-ascii?Q?+bS2wuoHo6AlA/+YOYr/ycEOUlxZ0OcRp0VD7yCZO8ny+rFTIT9km9O5rq7E?=
 =?us-ascii?Q?MyHFlV8slJIfS0pumWG9L+xANsqzdO+rC/A/YVZFU5TWIL1Qmxl7uH2rTlfH?=
 =?us-ascii?Q?Jy/dlrOAQnPDeNqaQcwJjzKIBJtkzRD5sAAhZnQ1YFM3oiwQ+S28Rab6hYIl?=
 =?us-ascii?Q?6VMki9ahvgCW0m3CV12UTvcNIbTTW+edDpiPELjg2YLIBrA5OA65T/jE1CsS?=
 =?us-ascii?Q?0GqllOBCMXTtq4FJvjenZ6bxMt7tHX0DbyOPVmxociNcTCfnI2QP6Pz7+ais?=
 =?us-ascii?Q?iWaBQ1Vch3txlVdL6IxwmIpFDHWjxn33BxF4WByFfoIFG+DW24lHN7Xt6z+U?=
 =?us-ascii?Q?C8gdnZ6XcWLKr0hmEuWFWEzEm0BOA3QXd++Eb4A5BeoVogrbpuJq2jgaJBdL?=
 =?us-ascii?Q?j8/n66Xl6v5lwTdD4Jd1Im3TNVL5+EPj+fJlE57plE9CRYc9fXqnovMW4Pig?=
 =?us-ascii?Q?hH0KLAETXA3o8+3CQj1hpvE1kFkcO1JH3H9hmGY8lMsOqxtZdHSYTbHdmkrs?=
 =?us-ascii?Q?pHZeILMCWUXzTMF0Eqwcf7ZNG3AJVbZPmLYJZsX3kgYKnjewr0OsXpirjCuW?=
 =?us-ascii?Q?I6c+b9UnvWUIIi8XE7AwHZjtfdZJlAb1e3/kxkLPUWCXO53ll3Kd9JUftJrv?=
 =?us-ascii?Q?OYjrgfltnxApvl5gcpPz7UD+dFb4K7QKhzNg7+XwA2nIgrXj/JMchTvK6gSD?=
 =?us-ascii?Q?UYsBDYAGvRcsds9QSjIBm6aimS9QFYP/nNyo58oWGb4yLo1ghbA+lPUKzBzE?=
 =?us-ascii?Q?A99cXCFG2sIWtHZe14UUrUHz0/XXDdRhXph4D/jYbpEgexbVBqItKqOs4Cxe?=
 =?us-ascii?Q?My2N8Pjasw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d57816fa-1bd4-44a0-fcb3-08de81601481
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2026 00:24:39.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtHHx58OKUNqEEV2OMmH4NKvUqTVwG744xliVI/t14tkdRwoSNEiYZ9lMsS2bq5CrTNHUh2W5aFsDN9BWq9z2UJHO+ljgRR3F7wtlWVBfIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5253

> Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add glob=
al-regs
> and transfer-mode properties
>=20
> On Mon, Mar 09, 2026 at 02:53:53PM +0800, Ryan Chen wrote:
> > The AST2600 I2C controller supports three transfer modes (byte,
> > buffer, DMA). Add "aspeed,transfer-mode" so DT can select the
> > preferred transfer method per controller instance. Also add the
> "aspeed,global-regs"
> > phandle to reference the AST2600 global registers syscon/regmap used
> > by the controller.
> >
> > These properties apply only to the AST2600 binding and are not part of
> > the legacy binding, which uses a mixed controller/target register
> > layout and does not have the split register blocks or these new
> > configuration registers. Legacy DTs remain unchanged.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../bindings/i2c/aspeed,ast2600-i2c.yaml           | 29
> ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > index de2c359037da..323e4f9b290a 100644
> > --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> > @@ -37,6 +37,33 @@ properties:
> >    resets:
> >      maxItems: 1
> >
> > +  aspeed,transfer-mode:
> > +    description: |
> > +      ASPEED ast2600 platform equipped with 16 I2C controllers each i2=
c
> controller
> > +      have 1 byte transfer buffer(byte mode), 32 bytes buffer(buffer m=
ode),
> and
> > +      share a DMA engine.
> > +      Select I2C transfer mode for this controller. Supported values a=
re:
> > +        - "byte": Use 1 byte for i2c transmit (1-byte buffer).
> > +        - "buffer": Use buffer (32-byte buffer) for i2c transmit. (def=
ault)
> > +                    Better performance then byte mode.
>=20
> Good, I like worse performance so I can use byte mode.
Thanks your review.
Will remove performance statement.
>=20
> > +        - "dma": Each controller DMA mode is shared DMA engine. The
> AST2600 SoC
> > +                 provides a single DMA engine shared for 16 I2C
> controllers,
> > +                 so only a limited number of controllers can use DMA
> simultaneously.
> > +                 Therefore, the DTS must explicitly assign which
> controllers are
> > +                 configured to use DMA.
> > +      On AST2600, each controller supports all three modes.
> > +      If not specified, buffer mode is used by default.
> > +    enum:
> > +      - byte
> > +      - buffer
> > +      - dma
>=20
> This is not required, so what is the default mode? If there's a default, =
you don't
> need the default value in the first place as the default is the property =
omitted.

Thanks, Will update with following.

aspeed,transfer-mode:
  description:
    Selects the AST2600 I2C transfer mode:
      - byte: 1-byte transfer buffer
      - buffer: 32-byte transfer buffer
      - dma: DMA-based transfers
  enum:
    - byte
    - buffer
    - dma
>=20
> > +
> > +  aspeed,global-regs:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle reference to the i2c global syscon node, containing the
> > +      SoC-common i2c register set.
> > +
> >  required:
> >    - reg
> >    - compatible
> > @@ -59,4 +86,6 @@ examples:
> >          resets =3D <&syscon ASPEED_RESET_I2C>;
> >          clock-frequency =3D <100000>;
> >          interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +        aspeed,global-regs =3D <&i2c_global>;
> > +        aspeed,transfer-mode =3D "buffer";
> >      };
> >
> > --
> > 2.34.1
> >

