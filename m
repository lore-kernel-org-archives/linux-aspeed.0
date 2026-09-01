Return-Path: <linux-aspeed+bounces-4907-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F85C61DD6
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 23:50:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZN073gLQz2y71;
	Wed, 02 Sep 2026 09:50:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788295305;
	cv=pass; b=nZ/rb7IjuA8QuxgCZpVA8J30ywVvhgHf4u5k2SpN9Tx7BmQdjLlhTwVZtV1XiVj0ynF7O4t+zdGecqpTI8mc1/3jSIgbMreFQ+PdAEesQgKQj9/IlELiMElegwftnJ8XY4pKSe8NturSm5LnDXw0t+MAK4W3cf/HFoCCdvpTRmbUtOt0Z00W5I4Fwfg44cgwNQjNZlAZzC/aFL0BUYUCIT/n6Xe8y7nVspET7RVkSwtYxVzm/qvYhnujk5Nk2IBzlGeF/5UpMPFY85joP6dkMJnG+b0BU9y2rDxKw5y9kPD7cROyTbg+knWmLiIObjvtKoJFBwIEYxQGIzZxpiOJmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788295305; c=relaxed/relaxed;
	bh=tc2bxQQPaWCu5z1qn9lBiXOv7S0E6fy31Sk9j94vZNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ftj9m29GUBPXHfplV5wno/4DGkV68pBWoZrCHit0XOlFhQrEFmHU/EZEX+T28OTOa0BcvKh106go7XRcRET0vBsTjoHG+obC+sq31uhSfUoqZiFisPv+gGL5eKQCIglQ26CTuLXng9PsjKueojvFtbRcOqGU4B5DhYXot3M0tQdDFCxMgG1L1QMve7H6QGCVhBQHv7GzuE5w5dJQtTb3Rpe+9bW2WrukwwpGpx2w5pOCOQmWqNnGwjR1/1qpXtMz3In9x4vdeTvJ/3WIVEBLx4n5oD7fLMCI+nQg+usUj/fEHevuN3Mv62NH62ynXsmqHgalS2gQ6spqmHJ8Wc5N7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GxOI0qtj; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GxOI0qtj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZHpH4Wh1z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 06:41:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6mkNAeclc6KHOWRmOWN2rEyRXZV/7XQAhaAAWNfsQQMQo2vYhzNvaslSfJlc22bpSjnAzcQrQ22RjEUcj9DW2yXhDO4UHQ6lJMM+tRC1/YtKQyC5wBO2DGvdGY9W6e2D1q44nu/WkeupWeu2KW4yvMKWrrcSe9d1J1NDlQioV/2ytE2An/qMuU+KZH0etWWOhBAt6a6A1BSBctI6JzTV2WeY9FXzZRsRN5M7uWhZYaDWXTka9io4XrtJI9nIJw8fjd1+YK8MoWjaLAxxVZNAxe2dAXJuRCAAteZ+dWfGyahHBk6ZV5FC9Icf683Q7EOIzoC1Od+oUM+KwUPAVE+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc2bxQQPaWCu5z1qn9lBiXOv7S0E6fy31Sk9j94vZNg=;
 b=u7cltoQSwRzJBnaKW+GV875mRasScsmAZfPLOFDt3FgfdU8ri+G5WlG80bMHvfSEWX3/KZooCOtZuQ8t0a4leghPyBKyxfF9knUbHM9S54w7f5IR0FhRnsVDzNvfAfDu2P1Bzd213uX/geQzIveUyK+iie7S5qzeUw9ZJ5r+bU8HT8hVa45bZrWLh7DDtj8drPR9mieVAJA7xzmANIGqbcwpuGcvJ3uSfrByDkGzqAn27Rh5ilfiXgTD97Nuqxz5smIgwtKYxopdpG0eSc5KYMHie1c6rYFTgDP6MyqxiqReJN9/bp5DPqwLuuiO5lS1LIGV8qOKfoxW9e+hbgqBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc2bxQQPaWCu5z1qn9lBiXOv7S0E6fy31Sk9j94vZNg=;
 b=GxOI0qtj8RIOr9nTsdz7qh4XQVmSqaTchQm2FFrvksD0lIrxy4sBRUbv3k+gkniV+e4gMOP03IAwWZpUc/7RUCmOaUnD5uUeYZHp0OdBpZhmLNUtR6usuBdZ0u0Y4vdm3YbeQc7A6sw6aM92DQsd0ODpiOKHcI/6ZiudHGqU6si11tHExuoouH0lAiWYmP4fuaKvsLnO16iIaMIspQie2GbDlKLbd459MRcdMO6pzay136M4e1O5a4an+rqorJDwEpIGFe5cgVoUUMUnYIAOauvOMqtAgl62vh7f6tgoIPOKcpNSP1rcj1PDewTQGgAl/3V9T29/fOM23yxlKsJKhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:41:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:41:11 +0000
Date: Tue, 1 Sep 2026 16:41:03 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: i3c: Document the AST2700 I3C controller
Message-ID: <apc4Xxv5F9jwAHxC@lizhi-Precision-Tower-5810>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
X-ClientProxiedBy: CYZPR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:930:a2::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c210c2-6fef-41be-acb3-08df08695be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|56012099006|4143699003|10067099003|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3HIjlh/J2hJ8U4574VFmJsP2e9mgbTtiWEymm9eDYPUykXk9yBQxaCfHna8jgLKFafYp7h8dW8G3S8u4fG0oPjEJzpAuDxkqBtLfFGwCN/fZleGl7zL9bNPzxbmEmqcNP30LRQOhPr8304LpDnIrcwFqdaoPFHPe6DXVe7I1E/zhcN6C92misXqVVYXm/5FqoaKzGbRIRNpNnrynI6YUvRR8hvYORqvao4YXtumGyE1XVyPhOIki3d0eIHFwcUdAtLWJBZolyiN6EP53Phl05aoUbVaE2it+fsb06HmwBsBF50jPYuiASc/nRPTkZxUPpJjGbNMKy/mfobEl2NC2JyY554x8vHJOJZXbFL9GYVREJTv7oQ9v5MFJYYTGdFo75mQFvsA5btV60B7MlUFdLUgTuM09SVR4yLwZlmwV5bIxvyTUkhx3gV2RHccFKzud5/PJ4QYOB7uo7Gc0wnD16KsACHShRph4p+yMV3G5auEwf5PgF1nhDj0xknfY9eThYL9xF9QmMn9R24NThVSaqw8BGvXorypj28THKGZtiwBGxY9/4gunicPO8dX4EyWntz1uUfaCvuIHRe75muq/TgpxWxv3U8P40eMde1f+et0P8dqC8fRbAkAdRQPI08PG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ecP7Lb8grH2hcZVPQUYfmUG35eo63rOhyQNFd2dW/a0UyNqLvPY3ibWG4HSo?=
 =?us-ascii?Q?qoPIzLvpZonEoa1ssbohozkCJUmy/cN52stLDq3xvOKbiDrXONTtarICXWjT?=
 =?us-ascii?Q?mODWGzUqPNfgnlUWd1/sgqioygxJds7+9Env6Jdva+LVTduMGVw8IAQLl+d3?=
 =?us-ascii?Q?fZzoX/PiAgzNZZrLN1uZNUR68M4Xdk2t8vYfRwHenTk+IBxsHKxEXe9hnumN?=
 =?us-ascii?Q?LEDYHgN8htM2yFtiVnBL6eRboUBR+KdaEKslx1YJTJdYHzPmgGnIL8mILSAF?=
 =?us-ascii?Q?UUfbPRC8HulfhTcINm/Y6xBiRVcpVy8QEvyZZLR++XrNLNqKUGMJGawzN2FO?=
 =?us-ascii?Q?GqD3GQtppHVKzKrViIQsqn3DITAoNsyLE1vWcQ7pZmUzFcKU4zKNTvhUGz19?=
 =?us-ascii?Q?SlLcNbbV5PL2aUrHh1jFpbyQAJLwStxCP9bXDyDOdgDghQyOqqv+0H6NpUCW?=
 =?us-ascii?Q?VlJH7ezodYeu3dvkNczgRiOhsNIohQoPYBf7i7ZS8G2IPj6xPM6kEBa2T0At?=
 =?us-ascii?Q?A0p99kuu/yv2t7kgwO8nHsFhSesFssrzP2fCj1aYBitoG9BE+TnlDuU0yaWM?=
 =?us-ascii?Q?0sKwbEFlaMOF/TvyCGcHC5exg51lulQ9BeRE0O5tLiB0uXlgtRqqC2+3/PSB?=
 =?us-ascii?Q?y435Zm+4g2JleI+1Kh76TbDM/QwpODJ08tZ2awmgHSjsh3Ns9GMbsqwBsqlT?=
 =?us-ascii?Q?qXvVSM1iceXsKQJC76aRU+NerailfsD4jTUYmAMgGpKAo5vAU8/WPB3Floli?=
 =?us-ascii?Q?7ca0RAY3fYqbeKJdw2GINvfDbjtLq3Yb/sDmgEvefrG3GQDtZTRklK+nxhe/?=
 =?us-ascii?Q?fJPoJlfxJNK7Fc5s7VpIpQ1HHPR1NjZ3OnksNc4Rm0s0ypOopWIEBvPA2k8U?=
 =?us-ascii?Q?NGQoSgnh8tYVOWujyhwK8xFym1Ty1WZKLKRyHErkN09YYHXJfspSWJVzNN4x?=
 =?us-ascii?Q?NzmM2yIr1ODyzEHUtw6wFqE7QyzpunrX0pvlFCdNWOPcZxrS78Ia22ydW+Jk?=
 =?us-ascii?Q?1yxBMwqNPU4LYg5gJPz6xJH9dgfHwTD9RG1z/8X8irgkMMlF+KbdHSR+OuyP?=
 =?us-ascii?Q?4TQOYKHsfuy+e+Ipcd0t9tIJXLYwdWtez/WZeEmn8G2Gp36IJIZmuYmC0q7B?=
 =?us-ascii?Q?FusUsN/AfRLJV+My+1joc2TuPTjo51el/lR9yomxlZ3wKO3N/gu3A++OtPr1?=
 =?us-ascii?Q?8fUUdbEZ4fDBwHYsHKMllRAcBf+oH9OkB0ul+2RwblIN0bW/lVpOTq+PtZ+g?=
 =?us-ascii?Q?lCuvKXardGyiXdFwCSnmhzQlJkGMO27ETfg/vSfyuQB4SE/fs/6gHBJWu1bh?=
 =?us-ascii?Q?cBcRwCbqYz2EViCGbBoQ+JZi/P1fRTsj6pNdNEQIkrd7Mvm2r/DeqEIVQT3L?=
 =?us-ascii?Q?PsU4UZYwONsRFoCBeqrtuAAZkaTN1O7bdZlUojYE22PheezEWfxKBmUhgibh?=
 =?us-ascii?Q?PRBtpi6xsN2DaBHFn7JSzO9E4M5h58NEuLZyB3bEoEMOLs8pkra94mvBWaQN?=
 =?us-ascii?Q?oCgF6FGHGb+J9Wha3BwV+P6oAr1wWzRHclBPPY+g4W+KIvl09Y/Qrp1MDCE5?=
 =?us-ascii?Q?f10HjQx+OrOuP4zc7Hka8X6RRe/ekODn9ifWNQcP79bz0WY/C4jN2e3kV7Xt?=
 =?us-ascii?Q?kQp+ui3O3vG6thldFO6mP2SZkpAzzvV80q4mdnjzthMEUv2izO2Fb/jZ7QL7?=
 =?us-ascii?Q?THbg17MBatNzpTJUPtRCt0t9bkkfo3+BeoMSoh+Z1P2q1jxSITMg1VivbhGN?=
 =?us-ascii?Q?zcuH/HAvbuQE1LOnprAX6PflJE5+xpngq1FB5LM6NDV9fwvgZsY4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c210c2-6fef-41be-acb3-08df08695be1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:41:11.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5bCo6de2VKGiDlMDqdx/6u8HoYfe3Ug9PtSKhyWbrRGGeyicdbOy9PLwJ1crHqM9gr9K9k/TxkOdEPLdqQSQpTpdi5BHmMcuBpYykywTwJehBNY6g1qWuIfPZDPEcsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516

On Tue, Sep 01, 2026 at 07:35:28PM +0800, Billy Tsai wrote:
> The AST2700 I3C controller implements the MIPI I3C HCI programming
> model, extended with an ASPEED in-house control block and a PHY
> programming window advertised through an HCI vendor extended
> capability. Follow the existing aspeed,ast2600-i3c precedent of
> describing SoC integrations of a common I3C IP in their own schema.
>
> The controller takes a core clock for PHY timing and two reset-names
> lines: its own reset and a DMA engine reset shared by all I3C
> controllers on the SoC.
>
> The PHY timings derived from the core clock and bus rate assume
> nominal bus loading. Boards with long traces, weak pull-ups, or
> capacitive loading need different ratios and setup periods, so
> document properties to override the push-pull and open-drain SCL
> periods, the SDA TX hold time, the tCAS/tCBP periods, and the SCL low
> period used for a repeated START or STOP.
>
> Boards without external I3C pull-up resistors can use the PHY's
> built-in pull-ups instead. The achievable resistance depends on the
> voltage domain of the pins (high-voltage vs low-voltage), which can be
> determined from the pin group assigned to the bus. Reuse bias-pull-up
> (pincfg-node.yaml) for the strength in Ohms; it is declared on this
> node rather than a pin-config node since the pull-up switch is part of
> the I3C PHY, not the broader SoC pin control IPs.

look likes AI generated message, can you try keep short and avoid
duplicate information, which already in binding doc.

Add AST2700 I3C controller, which compatible with MIPI I3C HCI. Extend with
an ASPEED in-house control block ....

introduce some hardware feature here ...

>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-fable-5
>
> ---
> We considered formally expressing bias-pull-up's dependency on a
> pinctrl state in the schema, but couldn't find a clean way to say
> "depends on whichever pinctrl-N is active" without hard-coding
> pinctrl-0 specifically, which would be wrong in general (a node's
> active pin state doesn't have to sit at index 0). We've added
> pinctrl-0 to the example to illustrate the typical usage instead,
> without a formal schema-level dependency.
> ---
>  .../bindings/i3c/aspeed,ast2700-i3c-hci.yaml       | 133 +++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
> new file mode 100644
> index 000000000000..19ecb5b15038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/aspeed,ast2700-i3c-hci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 I3C controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description:
> +  The AST2700 I3C controller implements the MIPI I3C HCI programming model,
> +  extended with an ASPEED in-house control block and a PHY programming window
> +  that are advertised through an HCI vendor extended capability.
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2700-i3c-hci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: Core controller reset.
> +      - description: DMA engine reset shared by all I3C controllers.
> +
> +  reset-names:
> +    items:
> +      - const: core
> +      - const: dma
> +
> +  bias-pull-up:
> +    $ref: /schemas/pinctrl/pincfg-node.yaml#/properties/bias-pull-up
> +    enum: [177, 231, 261, 317, 400, 470, 550, 600, 750]
> +    description:
> +      Enable the PHY-internal pull-ups on SCL and SDA and select their
> +      strength, in Ohms. High-voltage pins support 400, 470 or 600 Ohms,
> +      and low-voltage pins support 177, 231, 261, 317, 400, 550 or 750
> +      Ohms. When absent the internal pull-ups stay disabled and the bus
> +      relies on external pull-ups.

this one should go through pinctrl.

> +
> +  aspeed,pp-scl-high-ns:
> +    description:
> +      Push-pull SCL high period. Overrides the value derived from the
> +      i3c-scl-hz bus rate.
> +
> +  aspeed,pp-scl-low-ns:
> +    description:
> +      Push-pull SCL low period. Overrides the value derived from the
> +      i3c-scl-hz bus rate.
> +
> +  aspeed,od-scl-high-ns:
> +    default: 380
> +    description:
> +      Open-drain SCL high period.
> +
> +  aspeed,od-scl-low-ns:
> +    default: 620
> +    description:
> +      Open-drain SCL low period.
> +
> +  aspeed,sda-tx-hold-ns:
> +    default: 10
> +    description:
> +      SDA output hold time relative to the SCL edge.
> +
> +  aspeed,cas-ns:
> +    minimum: 39
> +    description:
> +      Clock-after-start (tCAS) period driven after a START condition.
> +      When absent it is derived from the SCL low period of the
> +      applicable bus context, clamped to the protocol minimum.
> +
> +  aspeed,cbp-ns:
> +    minimum: 20
> +    description:
> +      Clock-before-stop (tCBP) period driven before a STOP condition.
> +      When absent it is derived from the SCL low period of the
> +      applicable bus context, clamped to the protocol minimum.
> +
> +  aspeed,sr-p-scl-low-ns:
> +    default: 40
> +    description:
> +      SCL low period used while preparing a repeated START or STOP
> +      condition, kept separate from the push-pull SCL low period to
> +      satisfy the MIPI I3C clock stalling requirements.


these value is i3c stardard defined value, why need put into dt-binding.

Frank
> +
> +dependencies:
> +  aspeed,pp-scl-high-ns:
> +    - aspeed,pp-scl-low-ns
> +  aspeed,pp-scl-low-ns:
> +    - aspeed,pp-scl-high-ns
> +  aspeed,od-scl-high-ns:
> +    - aspeed,od-scl-low-ns
> +  aspeed,od-scl-low-ns:
> +    - aspeed,od-scl-high-ns
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - reset-names
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i3c@14c24000 {
> +        compatible = "aspeed,ast2700-i3c-hci";
> +        reg = <0x14c24000 0x1000>;
> +        interrupts = <100>;
> +        clocks = <&syscon 20>;
> +        resets = <&syscon 37>, <&syscon 34>;
> +        reset-names = "core", "dma";
> +        bias-pull-up = <400>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_i3c4_default>;
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +    };
>
> --
> 2.34.1
>

