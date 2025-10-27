Return-Path: <linux-aspeed+bounces-2621-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5637ACCF9EB
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 06:25:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw3Qv6YjPz2yyx;
	Mon, 27 Oct 2025 17:25:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761546327;
	cv=pass; b=H2yR2tPQR8AyvUwsbMYzMhBeNFzTFPggBJfntkikfeMZu0+MiaHDf0zB33S7PDpTvycTvT2o8n2jXVxTl3uY3RAXaJIJqMyhuofLict2V3jwNEP9LYTGnUSHTh657qHcUJffvQya7sY4ydwSmaSJe2SA8NfB+OmSWohRyhC4Bwhdgr3srm6P1/f2XEbHZKma53w2UwQW1U3i3xJxtPUBvJCUiJxIyj1uhNv5vnJqhi7zbT7xIUs/cQ/phiJtb8IJ/2nthYLk0RcNY1UJwBqseM3c4i7nP2pLQMwLrYIjg8T3hoGLdim678JctHMq+gesdG58j55owcY+3kJcn2D+Zw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761546327; c=relaxed/relaxed;
	bh=Fp6KVc0hb5pyee8ulu9WXv+Pak0tvrz42J8ZSISnJvk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShwIq1vjXRykSZwm/0lnznbiU46oYZ6iW3XH8el7Cu2NO6NyByJG0lCmmoTieju8Cz0IwDGvq+rNFo2Y+15yGF6I832YtVCNoyEzlsmNh/AbDcUhz9OR8BBaHpOxvK9UD23bs2kUlq0zaqZAvDieCW9+/E9soTOFqaMVIYzqBS4BMP9zCwv6Cf+8CDfRdQnlC69R4k3y3qwpbh5J5TZPNxQAv0XhPWVyVCWyuqwQEQdMTpmkTN6Q0dJUOiFklPpTNDIEXgFw6JgJe+E/W5MNLKBXH2l3EeXi+C1mO20LgUX08BVxYY8NUGsZodzqd507/eEuGKN/mUWYMUEeyx+Mmw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=IdlenteV; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=IdlenteV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw3Qs12fjz2yw7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 17:25:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT6dX1b0xJLWRRb8yk1dFzGFSXsQ3armFIasu33C+h5k8F4UMYQC53A5NWercGyi2ehTkjrAehFuhxFIbuoh/bPJJ/7efQEpwed6euk82A8eNYj9AZfg07ZGwyd9QOixkCLb7tFOySs170HkidK7y9wuA0iAwz/JpG4R00ulZrd9PJHYtfRdAzodvecdH7tJtfF1KQtguLzWYwnt+hJiZJx9D7XnyzicSeic/X1crvQ3Mli5TQvuE4k/irQgKdJ4PZqRZWTjlRPRVP9W1wsUXJYQhDhcQVc31cwZMJcstjahife+8zeq3HNwXW0cA44O7deSQg3n0u0lVL0mCeOrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp6KVc0hb5pyee8ulu9WXv+Pak0tvrz42J8ZSISnJvk=;
 b=rOcmokUz0BsV5+pYmNZakGcW6YYk3b+y0wt+PuS7vWjj5jzfbZs1UlRlNgF3DdSPvng2uoP6bDRCDnVUfHQQL9R0CtLATIBF3GTHoMKvzcI4KLff3aSa2dM7668BVRQoYt+M3Rk+nl7mJg20eX7RQActxTUWFjv/tpmKs5SSlZVTCKZwJXk9hP5fQAP1n8OspfyYN0r6dROKhDcC+iimV3sErZju/o6J7WyNuVdWDCQ68sENRGCtf8CwcY4vQxG1AwVHDk0O0HOwTEkobPLkrYoht/Kb6IA0y9dWa+xUSCbpjghNEOv9fRY57hJS6DjGhogfTp0Wq+nGTFzmviEjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp6KVc0hb5pyee8ulu9WXv+Pak0tvrz42J8ZSISnJvk=;
 b=IdlenteVMnjQVShH3lyT2vDgDv0k2z2n54EvkA1x3m80+Ys0QHF8q37M1rTGZy4VLN7SI+JMJcfwlF/bRqtgaWSzbjy9AlSuKkqWEcXzGgCOmcN3ev6OAqFunMVxcczmanlD3S75XxHu+abrB5ES5OWn0nHjZ+gZtJ6KQhtGVjQNaP3R3sIlJ+VRTI4KE193hMAqqeYZtv5kRlW8Ig0FbqW/VheUIJBZKRax4nXWBcZBBQ8YRs6hiW6SvYqNs+7Q/Avv0cAKdAq0mz1wp3TOC+JOjzopqAVQDz2ytec+TIr5aqO5DjQ/AZvaKAafVDvCMkJKpQGPWmLhvDnNu+KaYg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB6334.apcprd06.prod.outlook.com (2603:1096:101:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 06:24:59 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Mon, 27 Oct 2025
 06:24:59 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Brian Masney <bmasney@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, Rom
 Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao
 Zhang <yuxiaozhang@google.com>, "wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>, "dkodihalli@nvidia.com"
	<dkodihalli@nvidia.com>, "spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: RE: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
Thread-Topic: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
Thread-Index: AQHcObcYZfDa5MFRHEuA0bcfdj7WJ7TVoHpQ
Date: Mon, 27 Oct 2025 06:24:59 +0000
Message-ID:
 <TY2PPF5CB9A1BE64DCD487138F3BAC4FD34F2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251010072540.666673-1-ryan_chen@aspeedtech.com>
 <20251010072540.666673-4-ryan_chen@aspeedtech.com>
In-Reply-To: <20251010072540.666673-4-ryan_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB6334:EE_
x-ms-office365-filtering-correlation-id: 98088f0a-2ac6-4e9d-179e-08de15218de2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AmXKr/WFpWyqKDmP4QtEb8JhR2WNfhdHOJnAxbd4D2C0aUdcf3UVlSKeT60X?=
 =?us-ascii?Q?7H8EXAyBZfutdA6t3Kl/uxVKaTHSqeRvSfgc/N7qySk4egwVNAmKwPFh2u8F?=
 =?us-ascii?Q?XJ3hcsRx++67VMoVPx2nhgOjR5VZWpId9ij6M3OebhcgVPQn7vzFi3TLVPeK?=
 =?us-ascii?Q?grAw5a3j3N9q8/FZlXqLR0UV7TRBycx+9gb6qP22X7Xci16wP05LUfDoGsLc?=
 =?us-ascii?Q?L+MHkOK057vsm8MdVa+LRHRWhe8jOO8jODdOlEovOAcBqrLzYvZc+GuQopEc?=
 =?us-ascii?Q?NRlgoxkKcog3VAQM54Z2PaqYjQIbC+aOR90ggf6zxZxBB9w4FryBoReQavaP?=
 =?us-ascii?Q?3jC4P+9fZbc/beWQeVbR1VrGY7MOEcT0/6esKWTzr70L/YU1qcoHMZdVTnYj?=
 =?us-ascii?Q?1FoCBYVBkGNoOt2zM0QeBhccWXLoIWGZmXiAHzAj3KIgO6kGG5DzKBHLkQ8C?=
 =?us-ascii?Q?wApcGaSFTZXP8z1RAiV6d/CMFQkF3906aTuORYxf9jJIwzJ1SV2oXqdLVyjG?=
 =?us-ascii?Q?tCa063CohwCVVjbrPH772ZtG8pi7a12oY37jFwA5p03nhzUs8znVdAlH76vD?=
 =?us-ascii?Q?jMYYPE5/H3CEoa/iAgqItx6Kgdh072AdMJbxDudGA+vRWOjutL8rr5UjQ2yO?=
 =?us-ascii?Q?bNilAv2dOwjYqYbszy15ftRjlpme2G+Fpaf3edmnf+TIUL4PkwnCPeylT+P/?=
 =?us-ascii?Q?/Mz7IM6sg6LoHqIkXO+pYd4cpC4uN0ffulEK8ky9ojOoUYdHG05qbP/8ardn?=
 =?us-ascii?Q?n/kwEdrptLIYKRgmC6i8LYna9FO7FPHyV/jI5FBVN72AQVT+abCK5NfR/8Up?=
 =?us-ascii?Q?LIgW+ugX+srrdzHaYrn8qIrBCANeeLtFztQAMux4i5uGYrOJ3QY4wENrtFk/?=
 =?us-ascii?Q?5FBVMwoIL4XDmYXv50tIGNRmq3QJ0LAx82laotD+TRhEqQCd79eaqoLlxKgy?=
 =?us-ascii?Q?MByiJSoQuZql4IzhEPzlGD4djdSOBm5CTe2k3im9K+DP2SElc5BVVHpOjD3z?=
 =?us-ascii?Q?GLaI02LfXKkR4qWz0NupOcdntnXcL6xTd3tMoMLwUsaZnwuMM+WwmPJ3RFyr?=
 =?us-ascii?Q?fA0zRzSmkeSJiQwdeSqzlzv7yoV+hw5PCatRPCrgStgE/QqzpAs2HyEpuepB?=
 =?us-ascii?Q?4og4jh/P1y0X7yjylOv5UQyAI/h2ByEmujmKuhj6ncH8bdbsOxnmoOGVEnpF?=
 =?us-ascii?Q?leKGBXU6L42uoskoiltHrr26rBnQs8kBliQdnDN2Xz/i/iOESoHd7mg1Smk+?=
 =?us-ascii?Q?jJaIJAVnTSxnm/WTaH1iznm/ivahViv+h6MXFQanuzcMyRuZRa4Qp+8UWiWP?=
 =?us-ascii?Q?+thGk9BNGeU0bN7Jtu4UrPhzOhI7ev3fOVEsfDrN1Ab+dETMxcJ0dNoSuLo/?=
 =?us-ascii?Q?hNfoA1xZzzMy55LtS67qTaAFmeGZPV7LSQ4keLqJq5g2c8URFiuJGZjbJpZR?=
 =?us-ascii?Q?1hIUWVQpywiN7lN5ZRyz7ZjjjAral8zQKCxks9GIqujYIq9oX2b2B7P+AyEe?=
 =?us-ascii?Q?PHy681bxCbUEclCwnSuVgvvO8zN2xRtSn7dE7qiVLnbD3huvSlDS3LpGXQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T1MMf9f7OuCZkzQeH8vG5c27WVqWmEJGWBfA0UaMObESV1QmhXytOxQyaCmn?=
 =?us-ascii?Q?anSqqkbgYb3IQgyPN+aB2eRiXq2whu0qvisYFfPhyHyYnImukQEr5sdSZPA7?=
 =?us-ascii?Q?nHn4iUb/CQEqCG1wmVxy4XoRiRWJGloKGkk+XKqK69Ht+mgzllKfjp+8hXdJ?=
 =?us-ascii?Q?/F2XJEAV375AijR8bXDCOdmxgV6HHHIafByDS5eBclnIt66PR/Ia4fbo/le2?=
 =?us-ascii?Q?52fMdU/MrWgDP8hf/8dfO1lInNC6Ed5TYtdAqO/OTJoJd1lNG6aewAcFeWGv?=
 =?us-ascii?Q?ugiHGAm1wAVPwKe16a+3Lybougj6qRrqBkTh0rJOJZoZ99yFkmmrI4muG5Pn?=
 =?us-ascii?Q?OulEz2SDHgzf2lOexSPL8cAitJSDGCIXmBQL/sHqJRAPeeMW/1g6P3fqAXSw?=
 =?us-ascii?Q?+ziM40Edy9AaZRmMM8EA+HTrMYkg6cRcKmesgUeBRBQkar2s5hDSJjiiFbAI?=
 =?us-ascii?Q?c+TVV233JBBkJArHXQMZNckZlF7ypmqQJGpagbnabKR81er1YhTrlgX37ket?=
 =?us-ascii?Q?Y6prpa5S/q0p1VKuWN1S0UEaUyC7BvjVZDeWe98zuSLoBeA6/4aKUv/Awo5A?=
 =?us-ascii?Q?y6/Gm3HBiM+UVPo+cXCRG9kM5FQRn5VGqcQEUoTc7vuH/fhklheAqCc6Q+Ks?=
 =?us-ascii?Q?lba2jSv7DIAkWKdvFQMXy+GS0PKtSkw7qd5AMOKGeHOMpFCR4/JTN7k2HvW/?=
 =?us-ascii?Q?fdS/98mkRNc6Z4hIAk3KAujb3GSBLvYplvWl6YOYmdEDayPTA7eisp/kMoL1?=
 =?us-ascii?Q?q3DFn8IUbtMviVm3SKEYXIewdzsUBQRHfREvJ9OKCtUeqebhJqYeWKEeqMJn?=
 =?us-ascii?Q?i5zdBE2t4EpJYqEHmxOmUrP6NYpDfUz7P43KczBZwPP+7ZP6YQr0OqWGmaob?=
 =?us-ascii?Q?H7lsReu21uLeF4dYRh5nyQ0U9YHXutBqglkurpklO0r0JVak0jrkEC1NPyt0?=
 =?us-ascii?Q?z/nuanYZCGOm2zX880dmfuRYoPmtyy+VYoRke2inrZ4nwrp96bdJOVIhDrio?=
 =?us-ascii?Q?LesLW9Dud2giexdG2o/cZ8axCtwghgy1jmTVxghWFf6k4L7SDE5QXoOVes3E?=
 =?us-ascii?Q?gaNXE9Gnb7g7di36d8Hd8sUhT2lpfLv+9hiPlI7twx6mHLB95lPZFpWqmb2l?=
 =?us-ascii?Q?2QHZbS1C9ar7MY8OEMfGn/f/YEcg1A74osBAhAjOp+am0gsjrCHDGhxVBB9z?=
 =?us-ascii?Q?OS+wMLguJkz8DItanrm/LkWhx/CgFzWdeXvZILVTaXSC1P6gHJhYRma89ire?=
 =?us-ascii?Q?hEpzIUsi7+Losq6dX253vcPXDNgy4T4ivxJ2AauSMsTj96+LgxFQrVt2lPc9?=
 =?us-ascii?Q?EU0/Dgq1SeAf+dc3PCYMjJdaVtDYNRIJyZPLGXUiv3YkVIjeMG1Hz5gDOK8e?=
 =?us-ascii?Q?cvo6NAHGZpcK86Pr75hLOrYftplA+K0VHCdtbmvLrbZVwYKL40szWXd+eb/A?=
 =?us-ascii?Q?Qjb3z3NZ8Y6tyGxsT+WbdZriHGf0uDJ+dEorDtRcx0Qgm/iHI3y3AYhaWasR?=
 =?us-ascii?Q?ztJqNCWlbjGXWgcOgNeKDpaLOvSLPGcSmAQ/mLd37hWXaYQGc6cGC2GRkIgS?=
 =?us-ascii?Q?81sOoZMHBor2X1jz7llnd0iZUmGY7OBmS1DG0avw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98088f0a-2ac6-4e9d-179e-08de15218de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 06:24:59.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pbg4vdYKbcXR4gXsGqJz7KKhCSGaiEACEox+wPWlolAIXt4/QLoDqZy9eRb5y7Kb2FqTS7ZdvWZZm1BkRhlUiz5WLysqssG2Tb2WMvaIeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6334

Hello Stephen,
	Will this be accepted in clk-next?
Ryan Chen


> Subject: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
>=20
> Add AST2700 clock controller driver and also use axiliary device framewor=
k
> register the reset controller driver.
> Due to clock and reset using the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/clk/Kconfig       |    8 +
>  drivers/clk/Makefile      |    1 +
>  drivers/clk/clk-ast2700.c | 1055
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1064 insertions(+)
>  create mode 100644 drivers/clk/clk-ast2700.c
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> 4d56475f94fc..b3a6eb374a53 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -296,6 +296,14 @@ config COMMON_CLK_ASPEED
>  	  The G4 and G5 series, including the ast2400 and ast2500, are
> supported
>  	  by this driver.
>=20
> +config COMMON_CLK_AST2700
> +	bool "Clock driver for AST2700 SoC"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	help
> +	  This driver provides support for clock on AST2700 SoC.
> +	  The driver is responsible for managing the various clocks required
> +	  by the peripherals and cores within the AST2700.
> +
>  config COMMON_CLK_S2MPS11
>  	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
>  	depends on MFD_SEC_CORE || COMPILE_TEST diff --git
> a/drivers/clk/Makefile b/drivers/clk/Makefile index
> 18ed29cfdc11..0c47294715d3 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+=3D clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)		+=3D clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)		+=3D clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)		+=3D clk-ast2600.o
> +obj-$(CONFIG_COMMON_CLK_AST2700)	+=3D clk-ast2700.o
>  obj-$(CONFIG_ARCH_HIGHBANK)		+=3D clk-highbank.o
>  obj-$(CONFIG_CLK_HSDK)			+=3D clk-hsdk-pll.o
>  obj-$(CONFIG_COMMON_CLK_K210)		+=3D clk-k210.o
> diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new fi=
le mode
> 100644 index 000000000000..bbb2b571eb72
> --- /dev/null
> +++ b/drivers/clk/clk-ast2700.c
> @@ -0,0 +1,1055 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 ASPEED Technology Inc.
> + * Author: Ryan Chen <ryan_chen@aspeedtech.com>  */ #include
> +<linux/auxiliary_bus.h> #include <linux/bitfield.h> #include
> +<linux/clk-provider.h> #include <linux/io.h> #include
> +<linux/mod_devicetable.h> #include <linux/platform_device.h> #include
> +<linux/slab.h> #include <linux/units.h>
> +
> +#include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +
> +/* SOC0 */
> +#define SCU0_HWSTRAP1		0x010
> +#define SCU0_CLK_STOP		0x240
> +#define SCU0_CLK_SEL1		0x280
> +#define SCU0_CLK_SEL2		0x284
> +#define GET_USB_REFCLK_DIV(x)	((GENMASK(23, 20) & (x)) >> 20)
> +#define UART_DIV13_EN		BIT(30)
> +#define SCU0_HPLL_PARAM		0x300
> +#define SCU0_DPLL_PARAM		0x308
> +#define SCU0_MPLL_PARAM		0x310
> +#define SCU0_D0CLK_PARAM	0x320
> +#define SCU0_D1CLK_PARAM	0x330
> +#define SCU0_CRT0CLK_PARAM	0x340
> +#define SCU0_CRT1CLK_PARAM	0x350
> +#define SCU0_MPHYCLK_PARAM	0x360
> +
> +/* SOC1 */
> +#define SCU1_REVISION_ID	0x0
> +#define REVISION_ID		GENMASK(23, 16)
> +#define SCU1_CLK_STOP		0x240
> +#define SCU1_CLK_STOP2		0x260
> +#define SCU1_CLK_SEL1		0x280
> +#define SCU1_CLK_SEL2		0x284
> +#define SCU1_CLK_I3C_DIV_MASK	GENMASK(25, 23)
> +#define SCU1_CLK_I3C_DIV(n)	((n) - 1)
> +#define UXCLK_MASK		GENMASK(1, 0)
> +#define HUXCLK_MASK		GENMASK(4, 3)
> +#define SCU1_HPLL_PARAM		0x300
> +#define SCU1_APLL_PARAM		0x310
> +#define SCU1_DPLL_PARAM		0x320
> +#define SCU1_UXCLK_CTRL		0x330
> +#define SCU1_HUXCLK_CTRL	0x334
> +#define SCU1_MAC12_CLK_DLY	0x390
> +#define SCU1_MAC12_CLK_DLY_100M	0x394
> +#define SCU1_MAC12_CLK_DLY_10M	0x398
> +
> +enum ast2700_clk_type {
> +	CLK_MUX,
> +	CLK_PLL,
> +	CLK_HPLL,
> +	CLK_GATE,
> +	CLK_MISC,
> +	CLK_FIXED,
> +	CLK_DIVIDER,
> +	CLK_UART_PLL,
> +	CLK_GATE_ASPEED,
> +	CLK_FIXED_FACTOR,
> +	CLK_FIXED_DISPLAY,
> +};
> +
> +struct ast2700_clk_fixed_factor_data {
> +	unsigned int mult;
> +	unsigned int div;
> +	int parent_id;
> +};
> +
> +struct ast2700_clk_gate_data {
> +	int parent_id;
> +	u32 flags;
> +	u32 reg;
> +	u8 bit;
> +};
> +
> +struct ast2700_clk_mux_data {
> +	const struct clk_hw **parent_hws;
> +	const unsigned int *parent_ids;
> +	unsigned int num_parents;
> +	u8 bit_shift;
> +	u8 bit_width;
> +	u32 reg;
> +};
> +
> +struct ast2700_clk_div_data {
> +	const struct clk_div_table *div_table;
> +	unsigned int parent_id;
> +	u8 bit_shift;
> +	u8 bit_width;
> +	u32 reg;
> +};
> +
> +struct ast2700_clk_pll_data {
> +	unsigned int parent_id;
> +	u32 reg;
> +};
> +
> +struct ast2700_clk_fixed_rate_data {
> +	unsigned long fixed_rate;
> +};
> +
> +struct ast2700_clk_display_fixed_data {
> +	u32 reg;
> +};
> +
> +struct ast2700_clk_info {
> +	const char *name;
> +	u32 id;
> +	u32 reg;
> +	u32 type;
> +	union {
> +		struct ast2700_clk_fixed_factor_data factor;
> +		struct ast2700_clk_fixed_rate_data rate;
> +		struct ast2700_clk_display_fixed_data display_rate;
> +		struct ast2700_clk_gate_data gate;
> +		struct ast2700_clk_div_data div;
> +		struct ast2700_clk_pll_data pll;
> +		struct ast2700_clk_mux_data mux;
> +	} data;
> +};
> +
> +struct ast2700_clk_data {
> +	const struct ast2700_clk_info *clk_info;
> +	unsigned int nr_clks;
> +	const int scu;
> +};
> +
> +struct ast2700_clk_ctrl {
> +	const struct ast2700_clk_data *clk_data;
> +	struct device *dev;
> +	void __iomem *base;
> +	spinlock_t lock; /* clk lock */
> +};
> +
> +static const struct clk_div_table ast2700_rgmii_div_table[] =3D {
> +	{ 0x0, 4 },
> +	{ 0x1, 4 },
> +	{ 0x2, 6 },
> +	{ 0x3, 8 },
> +	{ 0x4, 10 },
> +	{ 0x5, 12 },
> +	{ 0x6, 14 },
> +	{ 0x7, 16 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_rmii_div_table[] =3D {
> +	{ 0x0, 8 },
> +	{ 0x1, 8 },
> +	{ 0x2, 12 },
> +	{ 0x3, 16 },
> +	{ 0x4, 20 },
> +	{ 0x5, 24 },
> +	{ 0x6, 28 },
> +	{ 0x7, 32 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_div_table[] =3D {
> +	{ 0x0, 2 },
> +	{ 0x1, 2 },
> +	{ 0x2, 3 },
> +	{ 0x3, 4 },
> +	{ 0x4, 5 },
> +	{ 0x5, 6 },
> +	{ 0x6, 7 },
> +	{ 0x7, 8 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_div_table2[] =3D {
> +	{ 0x0, 2 },
> +	{ 0x1, 4 },
> +	{ 0x2, 6 },
> +	{ 0x3, 8 },
> +	{ 0x4, 10 },
> +	{ 0x5, 12 },
> +	{ 0x6, 14 },
> +	{ 0x7, 16 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_hclk_div_table[] =3D {
> +	{ 0x0, 6 },
> +	{ 0x1, 5 },
> +	{ 0x2, 4 },
> +	{ 0x3, 7 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_uart_div_table[] =3D {
> +	{ 0x0, 1 },
> +	{ 0x1, 13 },
> +	{ 0 }
> +};
> +
> +/* soc 0 */
> +static const unsigned int psp_parent_ids[] =3D {
> +	SCU0_CLK_MPLL,
> +	SCU0_CLK_HPLL,
> +	SCU0_CLK_HPLL,
> +	SCU0_CLK_HPLL,
> +	SCU0_CLK_MPLL_DIV2,
> +	SCU0_CLK_HPLL_DIV2,
> +	SCU0_CLK_HPLL,
> +	SCU0_CLK_HPLL
> +};
> +
> +static const struct clk_hw *psp_parent_hws[ARRAY_SIZE(psp_parent_ids)];
> +
> +static const unsigned int hclk_parent_ids[] =3D {
> +	SCU0_CLK_HPLL,
> +	SCU0_CLK_MPLL
> +};
> +
> +static const struct clk_hw
> +*hclk_parent_hws[ARRAY_SIZE(hclk_parent_ids)];
> +
> +static const unsigned int emmc_parent_ids[] =3D {
> +	SCU0_CLK_MPLL_DIV4,
> +	SCU0_CLK_HPLL_DIV4
> +};
> +
> +static const struct clk_hw
> +*emmc_parent_hws[ARRAY_SIZE(emmc_parent_ids)];
> +
> +static const unsigned int mphy_parent_ids[] =3D {
> +	SCU0_CLK_MPLL,
> +	SCU0_CLK_HPLL,
> +	SCU0_CLK_DPLL,
> +	SCU0_CLK_192M
> +};
> +
> +static const struct clk_hw
> +*mphy_parent_hws[ARRAY_SIZE(mphy_parent_ids)];
> +
> +static const unsigned int u2phy_parent_ids[] =3D {
> +	SCU0_CLK_MPLL,
> +	SCU0_CLK_HPLL
> +};
> +
> +static const struct clk_hw
> +*u2phy_parent_hws[ARRAY_SIZE(u2phy_parent_ids)];
> +
> +static const unsigned int uart_parent_ids[] =3D {
> +	SCU0_CLK_24M,
> +	SCU0_CLK_192M
> +};
> +
> +static const struct clk_hw
> +*uart_parent_hws[ARRAY_SIZE(uart_parent_ids)];
> +
> +/* soc 1 */
> +static const unsigned int uartx_parent_ids[] =3D {
> +	SCU1_CLK_UARTX,
> +	SCU1_CLK_HUARTX
> +};
> +
> +static const struct clk_hw
> +*uartx_parent_hws[ARRAY_SIZE(uartx_parent_ids)];
> +
> +static const unsigned int uxclk_parent_ids[] =3D {
> +	SCU1_CLK_APLL_DIV4,
> +	SCU1_CLK_APLL_DIV2,
> +	SCU1_CLK_APLL,
> +	SCU1_CLK_HPLL
> +};
> +
> +static const struct clk_hw
> +*uxclk_parent_hws[ARRAY_SIZE(uxclk_parent_ids)];
> +
> +static const unsigned int sdclk_parent_ids[] =3D {
> +	SCU1_CLK_HPLL,
> +	SCU1_CLK_APLL
> +};
> +
> +static const struct clk_hw
> +*sdclk_parent_hws[ARRAY_SIZE(sdclk_parent_ids)];
> +
> +#define FIXED_CLK(_id, _name, _rate) \
> +	{ \
> +		.id =3D _id,	\
> +		.type =3D CLK_FIXED, \
> +		.name =3D _name, \
> +		.data =3D { .rate =3D { .fixed_rate =3D _rate, } }, \
> +	}
> +
> +#define FIXED_DISPLAY_CLK(_id, _name, _reg) \
> +		{ \
> +			.id =3D _id, \
> +			.type =3D CLK_FIXED_DISPLAY, \
> +			.name =3D _name, \
> +			.data =3D { .display_rate =3D { .reg =3D _reg } }, \
> +		}
> +
> +#define PLL_CLK(_id, _type, _name, _parent_id, _reg) \
> +	{ \
> +		.id =3D _id, \
> +		.type =3D _type, \
> +		.name =3D _name, \
> +		.data =3D { .pll =3D { \
> +			.parent_id =3D _parent_id, \
> +			.reg		=3D _reg, \
> +		} }, \
> +	}
> +
> +#define MUX_CLK(_id, _name, _parent_ids, _num_parents, _parent_hws,
> _reg, _shift, _width) \
> +		{ \
> +			.id =3D _id, \
> +			.type =3D CLK_MUX, \
> +			.name =3D _name, \
> +			.data =3D { \
> +				.mux =3D { \
> +					.parent_ids  =3D _parent_ids, \
> +					.parent_hws  =3D _parent_hws, \
> +					.num_parents =3D _num_parents, \
> +					.reg =3D (_reg), \
> +					.bit_shift =3D _shift, \
> +					.bit_width =3D _width, \
> +				}, \
> +			}, \
> +		}
> +
> +#define DIVIDER_CLK(_id, _name, _parent_id, _reg, _shift, _width, _div_t=
able)
> \
> +	{ \
> +		.id =3D _id,	\
> +		.type =3D CLK_DIVIDER, \
> +		.name =3D _name, \
> +		.data =3D { \
> +			.div =3D { \
> +				.parent_id =3D _parent_id, \
> +				.reg =3D _reg, \
> +				.bit_shift =3D _shift, \
> +				.bit_width =3D _width, \
> +				.div_table =3D _div_table, \
> +			}, \
> +		}, \
> +	}
> +
> +#define FIXED_FACTOR_CLK(_id, _name, _parent_id, _mult, _div) \
> +	{ \
> +		.id =3D _id,	\
> +		.type =3D CLK_FIXED_FACTOR, \
> +		.name =3D _name, \
> +		.data =3D { .factor =3D { .parent_id =3D _parent_id, .mult =3D _mult, =
.div =3D
> _div, } }, \
> +	}
> +
> +#define GATE_CLK(_id, _type, _name, _parent_id, _reg, _bit, _flags) \
> +	{ \
> +		.id =3D _id,	\
> +		.type =3D _type, \
> +		.name =3D _name, \
> +		.data =3D { \
> +			.gate =3D { \
> +				.parent_id =3D _parent_id, \
> +				.reg =3D _reg, \
> +				.bit =3D _bit, \
> +				.flags =3D _flags, \
> +			}, \
> +		}, \
> +	}
> +
> +static const struct ast2700_clk_info ast2700_scu0_clk_info[] __initconst=
 =3D {
> +	FIXED_CLK(SCU0_CLKIN, "soc0-clkin", 25 * HZ_PER_MHZ),
> +	FIXED_CLK(SCU0_CLK_24M, "soc0-clk24Mhz", 24 * HZ_PER_MHZ),
> +	FIXED_CLK(SCU0_CLK_192M, "soc0-clk192Mhz", 192 * HZ_PER_MHZ),
> +	FIXED_CLK(SCU0_CLK_U2PHY_CLK12M, "u2phy_clk12m", 12 *
> HZ_PER_MHZ),
> +	FIXED_DISPLAY_CLK(SCU0_CLK_D0, "d0clk", SCU0_D0CLK_PARAM),
> +	FIXED_DISPLAY_CLK(SCU0_CLK_D1, "d1clk", SCU0_D1CLK_PARAM),
> +	FIXED_DISPLAY_CLK(SCU0_CLK_CRT0, "crt0clk", SCU0_CRT0CLK_PARAM),
> +	FIXED_DISPLAY_CLK(SCU0_CLK_CRT1, "crt1clk", SCU0_CRT1CLK_PARAM),
> +	PLL_CLK(SCU0_CLK_HPLL, CLK_HPLL, "soc0-hpll", SCU0_CLKIN,
> SCU0_HPLL_PARAM),
> +	PLL_CLK(SCU0_CLK_DPLL, CLK_PLL, "soc0-dpll", SCU0_CLKIN,
> SCU0_DPLL_PARAM),
> +	PLL_CLK(SCU0_CLK_MPLL, CLK_PLL, "soc0-mpll", SCU0_CLKIN,
> SCU0_MPLL_PARAM),
> +	FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV2, "soc0-hpll_div2",
> SCU0_CLK_HPLL, 1, 2),
> +	FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV4, "soc0-hpll_div4",
> SCU0_CLK_HPLL, 1, 4),
> +	FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV2, "soc0-mpll_div2",
> SCU0_CLK_MPLL, 1, 2),
> +	FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV4, "soc0-mpll_div4",
> SCU0_CLK_MPLL, 1, 4),
> +	FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV8, "soc0-mpll_div8",
> SCU0_CLK_MPLL, 1, 8),
> +	FIXED_FACTOR_CLK(SCU0_CLK_AXI1, "axi1clk", SCU0_CLK_MPLL, 1, 4),
> +	MUX_CLK(SCU0_CLK_PSP, "pspclk", psp_parent_ids,
> ARRAY_SIZE(psp_parent_ids),
> +		psp_parent_hws, SCU0_HWSTRAP1, 2, 3),
> +	FIXED_FACTOR_CLK(SCU0_CLK_AXI0, "axi0clk", SCU0_CLK_PSP, 1, 2),
> +	MUX_CLK(SCU0_CLK_AHBMUX, "soc0-ahbmux", hclk_parent_ids,
> ARRAY_SIZE(hclk_parent_ids),
> +		hclk_parent_hws, SCU0_HWSTRAP1, 7, 1),
> +	MUX_CLK(SCU0_CLK_EMMCMUX, "emmcsrc-mux", emmc_parent_ids,
> ARRAY_SIZE(emmc_parent_ids),
> +		emmc_parent_hws, SCU0_CLK_SEL1, 11, 1),
> +	MUX_CLK(SCU0_CLK_MPHYSRC, "mphysrc", mphy_parent_ids,
> ARRAY_SIZE(mphy_parent_ids),
> +		mphy_parent_hws, SCU0_CLK_SEL2, 18, 2),
> +	MUX_CLK(SCU0_CLK_U2PHY_REFCLKSRC, "u2phy_refclksrc",
> u2phy_parent_ids,
> +		ARRAY_SIZE(u2phy_parent_ids), u2phy_parent_hws, SCU0_CLK_SEL2,
> 23, 1),
> +	MUX_CLK(SCU0_CLK_UART, "soc0-uartclk", uart_parent_ids,
> ARRAY_SIZE(uart_parent_ids),
> +		uart_parent_hws, SCU0_CLK_SEL2, 14, 1),
> +	PLL_CLK(SCU0_CLK_MPHY, CLK_MISC, "mphyclk", SCU0_CLK_MPHYSRC,
> SCU0_MPHYCLK_PARAM),
> +	PLL_CLK(SCU0_CLK_U2PHY_REFCLK, CLK_MISC, "u2phy_refclk",
> SCU0_CLK_U2PHY_REFCLKSRC,
> +		SCU0_CLK_SEL2),
> +	DIVIDER_CLK(SCU0_CLK_AHB, "soc0-ahb", SCU0_CLK_AHBMUX,
> +		    SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> +	DIVIDER_CLK(SCU0_CLK_EMMC, "emmcclk", SCU0_CLK_EMMCMUX,
> +		    SCU0_CLK_SEL1, 12, 3, ast2700_clk_div_table2),
> +	DIVIDER_CLK(SCU0_CLK_APB, "soc0-apb", SCU0_CLK_AXI0,
> +		    SCU0_CLK_SEL1, 23, 3, ast2700_clk_div_table2),
> +	DIVIDER_CLK(SCU0_CLK_HPLL_DIV_AHB, "soc0-hpll-ahb",
> SCU0_CLK_HPLL,
> +		    SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> +	DIVIDER_CLK(SCU0_CLK_MPLL_DIV_AHB, "soc0-mpll-ahb",
> SCU0_CLK_MPLL,
> +		    SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> +	DIVIDER_CLK(SCU0_CLK_UART4, "uart4clk", SCU0_CLK_UART,
> +		    SCU0_CLK_SEL2, 30, 1, ast2700_clk_uart_div_table),
> +	GATE_CLK(SCU0_CLK_GATE_MCLK, CLK_GATE_ASPEED, "mclk-gate",
> SCU0_CLK_MPLL,
> +		 SCU0_CLK_STOP, 0, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_ECLK, CLK_GATE_ASPEED, "eclk-gate", -1,
> SCU0_CLK_STOP, 1, 0),
> +	GATE_CLK(SCU0_CLK_GATE_2DCLK, CLK_GATE_ASPEED, "gclk-gate", -1,
> SCU0_CLK_STOP, 2, 0),
> +	GATE_CLK(SCU0_CLK_GATE_VCLK, CLK_GATE_ASPEED, "vclk-gate", -1,
> SCU0_CLK_STOP, 3, 0),
> +	GATE_CLK(SCU0_CLK_GATE_BCLK, CLK_GATE_ASPEED, "bclk-gate", -1,
> +		 SCU0_CLK_STOP, 4, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_VGA0CLK,  CLK_GATE_ASPEED,
> "vga0clk-gate", -1,
> +		 SCU0_CLK_STOP, 5, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_REFCLK,  CLK_GATE_ASPEED,
> "soc0-refclk-gate", SCU0_CLKIN,
> +		 SCU0_CLK_STOP, 6, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_PORTBUSB2CLK, CLK_GATE_ASPEED,
> "portb-usb2clk-gate", -1,
> +		 SCU0_CLK_STOP, 7, 0),
> +	GATE_CLK(SCU0_CLK_GATE_UHCICLK, CLK_GATE_ASPEED, "uhciclk-gate",
> -1, SCU0_CLK_STOP, 9, 0),
> +	GATE_CLK(SCU0_CLK_GATE_VGA1CLK, CLK_GATE_ASPEED, "vga1clk-gate",
> -1,
> +		 SCU0_CLK_STOP, 10, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_DDRPHYCLK, CLK_GATE_ASPEED,
> "ddrphy-gate", -1,
> +		 SCU0_CLK_STOP, 11, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_E2M0CLK, CLK_GATE_ASPEED,
> "e2m0clk-gate", -1,
> +		 SCU0_CLK_STOP, 12, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_HACCLK, CLK_GATE_ASPEED, "hacclk-gate",
> -1, SCU0_CLK_STOP, 13, 0),
> +	GATE_CLK(SCU0_CLK_GATE_PORTAUSB2CLK, CLK_GATE_ASPEED,
> "porta-usb2clk-gate", -1,
> +		 SCU0_CLK_STOP, 14, 0),
> +	GATE_CLK(SCU0_CLK_GATE_UART4CLK, CLK_GATE_ASPEED,
> "uart4clk-gate", SCU0_CLK_UART4,
> +		 SCU0_CLK_STOP, 15, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_SLICLK, CLK_GATE_ASPEED, "soc0-sliclk-gate",
> -1,
> +		 SCU0_CLK_STOP, 16, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_DACCLK, CLK_GATE_ASPEED, "dacclk-gate",
> -1,
> +		 SCU0_CLK_STOP, 17, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_DP, CLK_GATE_ASPEED, "dpclk-gate", -1,
> +		 SCU0_CLK_STOP, 18, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_E2M1CLK, CLK_GATE_ASPEED,
> "e2m1clk-gate", -1,
> +		 SCU0_CLK_STOP, 19, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU0_CLK_GATE_CRT0CLK, CLK_GATE_ASPEED, "crt0clk-gate",
> -1,
> +		 SCU0_CLK_STOP, 20, 0),
> +	GATE_CLK(SCU0_CLK_GATE_CRT1CLK, CLK_GATE_ASPEED, "crt1clk-gate",
> -1,
> +		 SCU0_CLK_STOP, 21, 0),
> +	GATE_CLK(SCU0_CLK_GATE_ECDSACLK, CLK_GATE_ASPEED, "eccclk-gate",
> -1,
> +		 SCU0_CLK_STOP, 23, 0),
> +	GATE_CLK(SCU0_CLK_GATE_RSACLK, CLK_GATE_ASPEED, "rsaclk-gate", -1,
> +		 SCU0_CLK_STOP, 24, 0),
> +	GATE_CLK(SCU0_CLK_GATE_RVAS0CLK, CLK_GATE_ASPEED,
> "rvas0clk-gate", -1,
> +		 SCU0_CLK_STOP, 25, 0),
> +	GATE_CLK(SCU0_CLK_GATE_UFSCLK, CLK_GATE_ASPEED, "ufsclk-gate", -1,
> +		 SCU0_CLK_STOP, 26, 0),
> +	GATE_CLK(SCU0_CLK_GATE_EMMCCLK, CLK_GATE_ASPEED,
> "emmcclk-gate", SCU0_CLK_EMMC,
> +		 SCU0_CLK_STOP, 27, 0),
> +	GATE_CLK(SCU0_CLK_GATE_RVAS1CLK, CLK_GATE_ASPEED,
> "rvas1clk-gate", -1,
> +		 SCU0_CLK_STOP, 28, 0),
> +};
> +
> +static const struct ast2700_clk_info ast2700_scu1_clk_info[] __initconst=
 =3D {
> +	FIXED_CLK(SCU1_CLKIN, "soc1-clkin", 25 * HZ_PER_MHZ),
> +	PLL_CLK(SCU1_CLK_HPLL, CLK_PLL, "soc1-hpll", SCU1_CLKIN,
> SCU1_HPLL_PARAM),
> +	PLL_CLK(SCU1_CLK_APLL, CLK_PLL, "soc1-apll", SCU1_CLKIN,
> SCU1_APLL_PARAM),
> +	PLL_CLK(SCU1_CLK_DPLL, CLK_PLL, "soc1-dpll", SCU1_CLKIN,
> SCU1_DPLL_PARAM),
> +	FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV2, "soc1-apll_div2",
> SCU1_CLK_APLL, 1, 2),
> +	FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV4, "soc1-apll_div4",
> SCU1_CLK_APLL, 1, 4),
> +	FIXED_FACTOR_CLK(SCU1_CLK_CAN, "canclk", SCU1_CLK_APLL, 1, 10),
> +	DIVIDER_CLK(SCU1_CLK_APB, "soc1-apb", SCU1_CLK_HPLL,
> +		    SCU1_CLK_SEL1, 18, 3, ast2700_clk_div_table2),
> +	DIVIDER_CLK(SCU1_CLK_RMII, "rmii", SCU1_CLK_HPLL,
> +		    SCU1_CLK_SEL1, 21, 3, ast2700_rmii_div_table),
> +	DIVIDER_CLK(SCU1_CLK_RGMII, "rgmii", SCU1_CLK_HPLL,
> +		    SCU1_CLK_SEL1, 25, 3, ast2700_rgmii_div_table),
> +	DIVIDER_CLK(SCU1_CLK_MACHCLK, "machclk", SCU1_CLK_HPLL,
> +		    SCU1_CLK_SEL1, 29, 3, ast2700_clk_div_table),
> +	DIVIDER_CLK(SCU1_CLK_APLL_DIVN, "soc1-apll_divn",
> +		    SCU1_CLK_APLL, SCU1_CLK_SEL2, 8, 3, ast2700_clk_div_table),
> +	DIVIDER_CLK(SCU1_CLK_AHB, "soc1-ahb", SCU1_CLK_HPLL,
> +		    SCU1_CLK_SEL2, 20, 3, ast2700_clk_div_table),
> +	DIVIDER_CLK(SCU1_CLK_I3C, "soc1-i3c", SCU1_CLK_HPLL,
> +		    SCU1_CLK_SEL2, 23, 3, ast2700_clk_div_table),
> +	MUX_CLK(SCU1_CLK_SDMUX, "sdclk-mux", sdclk_parent_ids,
> ARRAY_SIZE(sdclk_parent_ids),
> +		sdclk_parent_hws, SCU1_CLK_SEL1, 13, 1),
> +	MUX_CLK(SCU1_CLK_UXCLK, "uxclk", uxclk_parent_ids,
> ARRAY_SIZE(uxclk_parent_ids),
> +		uxclk_parent_hws, SCU1_CLK_SEL2, 0, 2),
> +	MUX_CLK(SCU1_CLK_HUXCLK, "huxclk", uxclk_parent_ids,
> ARRAY_SIZE(uxclk_parent_ids),
> +		uxclk_parent_hws, SCU1_CLK_SEL2, 3, 2),
> +	DIVIDER_CLK(SCU1_CLK_SDCLK, "sdclk", SCU1_CLK_SDMUX,
> +		    SCU1_CLK_SEL1, 14, 3, ast2700_clk_div_table),
> +	PLL_CLK(SCU1_CLK_UARTX, CLK_UART_PLL, "uartxclk", SCU1_CLK_UXCLK,
> SCU1_UXCLK_CTRL),
> +	PLL_CLK(SCU1_CLK_HUARTX, CLK_UART_PLL, "huartxclk",
> SCU1_CLK_HUXCLK, SCU1_HUXCLK_CTRL),
> +	MUX_CLK(SCU1_CLK_UART0, "uart0clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 0, 1),
> +	MUX_CLK(SCU1_CLK_UART1, "uart1clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 1, 1),
> +	MUX_CLK(SCU1_CLK_UART2, "uart2clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 2, 1),
> +	MUX_CLK(SCU1_CLK_UART3, "uart3clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 3, 1),
> +	MUX_CLK(SCU1_CLK_UART5, "uart5clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 5, 1),
> +	MUX_CLK(SCU1_CLK_UART6, "uart6clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 6, 1),
> +	MUX_CLK(SCU1_CLK_UART7, "uart7clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 7, 1),
> +	MUX_CLK(SCU1_CLK_UART8, "uart8clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 8, 1),
> +	MUX_CLK(SCU1_CLK_UART9, "uart9clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 9, 1),
> +	MUX_CLK(SCU1_CLK_UART10, "uart10clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 10, 1),
> +	MUX_CLK(SCU1_CLK_UART11, "uart11clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 11, 1),
> +	MUX_CLK(SCU1_CLK_UART12, "uart12clk", uartx_parent_ids,
> ARRAY_SIZE(uartx_parent_ids),
> +		uartx_parent_hws, SCU1_CLK_SEL1, 12, 1),
> +	FIXED_FACTOR_CLK(SCU1_CLK_UART13, "uart13clk", SCU1_CLK_HUARTX,
> 1, 1),
> +	FIXED_FACTOR_CLK(SCU1_CLK_UART14, "uart14clk", SCU1_CLK_HUARTX,
> 1, 1),
> +	GATE_CLK(SCU1_CLK_MAC0RCLK, CLK_GATE, "mac0rclk-gate",
> SCU1_CLK_RMII,
> +		 SCU1_MAC12_CLK_DLY, 29, 0),
> +	GATE_CLK(SCU1_CLK_MAC1RCLK, CLK_GATE, "mac1rclk-gate",
> SCU1_CLK_RMII,
> +		 SCU1_MAC12_CLK_DLY, 30, 0),
> +	GATE_CLK(SCU1_CLK_GATE_LCLK0, CLK_GATE_ASPEED, "lclk0-gate", -1,
> +		 SCU1_CLK_STOP, 0, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_LCLK1, CLK_GATE_ASPEED, "lclk1-gate", -1,
> +		 SCU1_CLK_STOP, 1, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_ESPI0CLK, CLK_GATE_ASPEED,
> "espi0clk-gate", -1,
> +		 SCU1_CLK_STOP, 2, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_ESPI1CLK, CLK_GATE_ASPEED,
> "espi1clk-gate", -1,
> +		 SCU1_CLK_STOP, 3, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_SDCLK, CLK_GATE_ASPEED, "sdclk-gate",
> SCU1_CLK_SDCLK,
> +		 SCU1_CLK_STOP, 4, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_IPEREFCLK, CLK_GATE_ASPEED,
> "soc1-iperefclk-gate", -1,
> +		 SCU1_CLK_STOP, 5, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_REFCLK, CLK_GATE_ASPEED,
> "soc1-refclk-gate", -1,
> +		 SCU1_CLK_STOP, 6, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_LPCHCLK, CLK_GATE_ASPEED, "lpchclk-gate",
> -1,
> +		 SCU1_CLK_STOP, 7, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_MAC0CLK, CLK_GATE_ASPEED,
> "mac0clk-gate", -1,
> +		 SCU1_CLK_STOP, 8, 0),
> +	GATE_CLK(SCU1_CLK_GATE_MAC1CLK, CLK_GATE_ASPEED,
> "mac1clk-gate", -1,
> +		 SCU1_CLK_STOP, 9, 0),
> +	GATE_CLK(SCU1_CLK_GATE_MAC2CLK, CLK_GATE_ASPEED,
> "mac2clk-gate", -1,
> +		 SCU1_CLK_STOP, 10, 0),
> +	GATE_CLK(SCU1_CLK_GATE_UART0CLK, CLK_GATE_ASPEED,
> "uart0clk-gate", SCU1_CLK_UART0,
> +		 SCU1_CLK_STOP, 11, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART1CLK, CLK_GATE_ASPEED,
> "uart1clk-gate", SCU1_CLK_UART1,
> +		 SCU1_CLK_STOP, 12, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART2CLK, CLK_GATE_ASPEED,
> "uart2clk-gate", SCU1_CLK_UART2,
> +		 SCU1_CLK_STOP, 13, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART3CLK, CLK_GATE_ASPEED,
> "uart3clk-gate", SCU1_CLK_UART3,
> +		 SCU1_CLK_STOP, 14, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_I2CCLK, CLK_GATE_ASPEED, "i2cclk-gate", -1,
> SCU1_CLK_STOP, 15, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C0CLK, CLK_GATE_ASPEED, "i3c0clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 16, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C1CLK, CLK_GATE_ASPEED, "i3c1clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 17, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C2CLK, CLK_GATE_ASPEED, "i3c2clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 18, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C3CLK, CLK_GATE_ASPEED, "i3c3clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 19, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C4CLK, CLK_GATE_ASPEED, "i3c4clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 20, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C5CLK, CLK_GATE_ASPEED, "i3c5clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 21, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C6CLK, CLK_GATE_ASPEED, "i3c6clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 22, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C7CLK, CLK_GATE_ASPEED, "i3c7clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 23, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C8CLK, CLK_GATE_ASPEED, "i3c8clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 24, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C9CLK, CLK_GATE_ASPEED, "i3c9clk-gate",
> SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 25, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C10CLK, CLK_GATE_ASPEED,
> "i3c10clk-gate", SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 26, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C11CLK, CLK_GATE_ASPEED,
> "i3c11clk-gate", SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 27, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C12CLK, CLK_GATE_ASPEED,
> "i3c12clk-gate", SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 28, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C13CLK, CLK_GATE_ASPEED,
> "i3c13clk-gate", SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 29, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C14CLK, CLK_GATE_ASPEED,
> "i3c14clk-gate", SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 30, 0),
> +	GATE_CLK(SCU1_CLK_GATE_I3C15CLK, CLK_GATE_ASPEED,
> "i3c15clk-gate", SCU1_CLK_I3C,
> +		 SCU1_CLK_STOP, 31, 0),
> +	GATE_CLK(SCU1_CLK_GATE_UART5CLK, CLK_GATE_ASPEED,
> "uart5clk-gate", SCU1_CLK_UART5,
> +		 SCU1_CLK_STOP2, 0, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART6CLK, CLK_GATE_ASPEED,
> "uart6clk-gate", SCU1_CLK_UART6,
> +		 SCU1_CLK_STOP2, 1, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART7CLK, CLK_GATE_ASPEED,
> "uart7clk-gate", SCU1_CLK_UART7,
> +		 SCU1_CLK_STOP2, 2, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART8CLK, CLK_GATE_ASPEED,
> "uart8clk-gate", SCU1_CLK_UART8,
> +		 SCU1_CLK_STOP2, 3, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UART9CLK, CLK_GATE_ASPEED,
> "uart9clk-gate", SCU1_CLK_UART9,
> +		 SCU1_CLK_STOP2, 4, 0),
> +	GATE_CLK(SCU1_CLK_GATE_UART10CLK, CLK_GATE_ASPEED,
> "uart10clk-gate", SCU1_CLK_UART10,
> +		 SCU1_CLK_STOP2, 5, 0),
> +	GATE_CLK(SCU1_CLK_GATE_UART11CLK, CLK_GATE_ASPEED,
> "uart11clk-gate", SCU1_CLK_UART11,
> +		 SCU1_CLK_STOP2, 6, 0),
> +	GATE_CLK(SCU1_CLK_GATE_UART12CLK, CLK_GATE_ASPEED,
> "uart12clk-gate", SCU1_CLK_UART12,
> +		 SCU1_CLK_STOP2, 7, 0),
> +	GATE_CLK(SCU1_CLK_GATE_FSICLK, CLK_GATE_ASPEED, "fsiclk-gate", -1,
> SCU1_CLK_STOP2, 8, 0),
> +	GATE_CLK(SCU1_CLK_GATE_LTPIPHYCLK, CLK_GATE_ASPEED,
> "ltpiphyclk-gate", -1,
> +		 SCU1_CLK_STOP2, 9, 0),
> +	GATE_CLK(SCU1_CLK_GATE_LTPICLK, CLK_GATE_ASPEED, "ltpiclk-gate",
> -1,
> +		 SCU1_CLK_STOP2, 10, 0),
> +	GATE_CLK(SCU1_CLK_GATE_VGALCLK, CLK_GATE_ASPEED, "vgalclk-gate",
> -1,
> +		 SCU1_CLK_STOP2, 11, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_UHCICLK, CLK_GATE_ASPEED,
> "usbuartclk-gate", -1,
> +		 SCU1_CLK_STOP2, 12, 0),
> +	GATE_CLK(SCU1_CLK_GATE_CANCLK, CLK_GATE_ASPEED, "canclk-gate",
> SCU1_CLK_CAN,
> +		 SCU1_CLK_STOP2, 13, 0),
> +	GATE_CLK(SCU1_CLK_GATE_PCICLK, CLK_GATE_ASPEED, "pciclk-gate", -1,
> +		 SCU1_CLK_STOP2, 14, 0),
> +	GATE_CLK(SCU1_CLK_GATE_SLICLK, CLK_GATE_ASPEED, "soc1-sliclk-gate",
> -1,
> +		 SCU1_CLK_STOP2, 15, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_E2MCLK, CLK_GATE_ASPEED,
> "soc1-e2m-gate", -1,
> +		 SCU1_CLK_STOP2, 16, CLK_IS_CRITICAL),
> +	GATE_CLK(SCU1_CLK_GATE_PORTCUSB2CLK, CLK_GATE_ASPEED,
> "portcusb2-gate", -1,
> +		 SCU1_CLK_STOP2, 17, 0),
> +	GATE_CLK(SCU1_CLK_GATE_PORTDUSB2CLK, CLK_GATE_ASPEED,
> "portdusb2-gate", -1,
> +		 SCU1_CLK_STOP2, 18, 0),
> +	GATE_CLK(SCU1_CLK_GATE_LTPI1TXCLK, CLK_GATE_ASPEED,
> "ltp1tx-gate", -1,
> +		 SCU1_CLK_STOP2, 19, 0),
> +};
> +
> +static struct clk_hw *ast2700_clk_hw_register_fixed_display(void __iomem
> *reg, const char *name,
> +							    struct ast2700_clk_ctrl *clk_ctrl) {
> +	unsigned int mult, div, r, n;
> +	u32 xdclk;
> +	u32 val;
> +
> +	val =3D readl(clk_ctrl->base + SCU0_CLK_SEL2);
> +	if (val & BIT(29))
> +		xdclk =3D 800 * HZ_PER_MHZ;
> +	else
> +		xdclk =3D 1000 * HZ_PER_MHZ;
> +
> +	val =3D readl(reg);
> +	r =3D val & GENMASK(15, 0);
> +	n =3D (val >> 16) & GENMASK(15, 0);
> +	mult =3D r;
> +	div =3D 2 * n;
> +
> +	return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL, 0,
> +(xdclk * mult) / div); }
> +
> +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,
> +						   const char *name, const struct clk_hw
> *parent_hw,
> +						   struct ast2700_clk_ctrl *clk_ctrl) {
> +	unsigned int mult, div;
> +	u32 val;
> +
> +	val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> +	if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {
> +		switch ((val & GENMASK(4, 2)) >> 2) {
> +		case 2:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 1800 * HZ_PER_MHZ);
> +		case 3:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 1700 * HZ_PER_MHZ);
> +		case 6:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 1200 * HZ_PER_MHZ);
> +		case 7:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 800 * HZ_PER_MHZ);
> +		default:
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else if ((val & GENMASK(3, 2)) !=3D 0) {
> +		switch ((val & GENMASK(3, 2)) >> 2) {
> +		case 1:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 1900 * HZ_PER_MHZ);
> +		case 2:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 1800 * HZ_PER_MHZ);
> +		case 3:
> +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> +							       0, 1700 * HZ_PER_MHZ);
> +		default:
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else {
> +		val =3D readl(reg);
> +
> +		if (val & BIT(24)) {
> +			/* Pass through mode */
> +			mult =3D 1;
> +			div =3D 1;
> +		} else {
> +			u32 m =3D val & 0x1fff;
> +			u32 n =3D (val >> 13) & 0x3f;
> +			u32 p =3D (val >> 19) & 0xf;
> +
> +			mult =3D (m + 1) / (2 * (n + 1));
> +			div =3D p + 1;
> +		}
> +	}
> +
> +	return devm_clk_hw_register_fixed_factor_parent_hw(clk_ctrl->dev,
> name,
> +							   parent_hw, 0, mult, div);
> +}
> +
> +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void __io=
mem
> *reg,
> +						  const char *name, const struct clk_hw
> *parent_hw,
> +						  struct ast2700_clk_ctrl *clk_ctrl) {
> +	int scu =3D clk_ctrl->clk_data->scu;
> +	unsigned int mult, div;
> +	u32 val =3D readl(reg);
> +
> +	if (val & BIT(24)) {
> +		/* Pass through mode */
> +		mult =3D 1;
> +		div =3D 1;
> +	} else {
> +		u32 m =3D val & 0x1fff;
> +		u32 n =3D (val >> 13) & 0x3f;
> +		u32 p =3D (val >> 19) & 0xf;
> +
> +		if (scu) {
> +			mult =3D (m + 1) / (n + 1);
> +			div =3D p + 1;
> +		} else {
> +			if (clk_idx =3D=3D SCU0_CLK_MPLL) {
> +				mult =3D m / (n + 1);
> +				div =3D p + 1;
> +			} else {
> +				mult =3D (m + 1) / (2 * (n + 1));
> +				div =3D p + 1;
> +			}
> +		}
> +	}
> +
> +	return devm_clk_hw_register_fixed_factor_parent_hw(clk_ctrl->dev,
> name,
> +							   parent_hw, 0, mult, div);
> +}
> +
> +static struct clk_hw *ast2700_clk_hw_register_uartpll(void __iomem *reg,
> const char *name,
> +						      const struct clk_hw *parent_hw,
> +						      struct ast2700_clk_ctrl *clk_ctrl) {
> +	unsigned int mult, div;
> +	u32 val =3D readl(reg);
> +	u32 r =3D val & 0xff;
> +	u32 n =3D (val >> 8) & 0x3ff;
> +
> +	mult =3D r;
> +	div =3D n * 2;
> +
> +	return devm_clk_hw_register_fixed_factor_parent_hw(clk_ctrl->dev,
> name,
> +							   parent_hw, 0, mult, div);
> +}
> +
> +static struct clk_hw *ast2700_clk_hw_register_misc(int clk_idx, void
> __iomem *reg,
> +						   const char *name, const struct clk_hw
> *parent_hw,
> +						   struct ast2700_clk_ctrl *clk_ctrl) {
> +	u32 div =3D 0;
> +
> +	if (clk_idx =3D=3D SCU0_CLK_MPHY) {
> +		div =3D readl(reg) + 1;
> +	} else if (clk_idx =3D=3D SCU0_CLK_U2PHY_REFCLK) {
> +		if (readl(clk_ctrl->base) & REVISION_ID)
> +			div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) << 4;
> +		else
> +			div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) << 1;
> +	} else {
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return devm_clk_hw_register_fixed_factor_parent_hw(clk_ctrl->dev,
> name,
> +							   parent_hw, 0, 1, div);
> +}
> +
> +static int ast2700_clk_is_enabled(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	u32 clk =3D BIT(gate->bit_idx);
> +	u32 reg;
> +
> +	reg =3D readl(gate->reg);
> +
> +	return !(reg & clk);
> +}
> +
> +static int ast2700_clk_enable(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	u32 clk =3D BIT(gate->bit_idx);
> +
> +	if (readl(gate->reg) & clk)
> +		writel(clk, gate->reg + 0x04);
> +
> +	return 0;
> +}
> +
> +static void ast2700_clk_disable(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	u32 clk =3D BIT(gate->bit_idx);
> +
> +	/* Clock is set to enable, so use write to set register */
> +	writel(clk, gate->reg);
> +}
> +
> +static const struct clk_ops ast2700_clk_gate_ops =3D {
> +	.enable =3D ast2700_clk_enable,
> +	.disable =3D ast2700_clk_disable,
> +	.is_enabled =3D ast2700_clk_is_enabled,
> +};
> +
> +static struct clk_hw *ast2700_clk_hw_register_gate(struct device *dev, c=
onst
> char *name,
> +						   const struct clk_hw *parent_hw,
> +						   void __iomem *reg, u8 clock_idx,
> +						   unsigned long flags, spinlock_t *lock) {
> +	struct clk_init_data init;
> +	struct clk_gate *gate;
> +	struct clk_hw *hw;
> +	int ret =3D -EINVAL;
> +
> +	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name =3D name;
> +	init.ops =3D &ast2700_clk_gate_ops;
> +	init.flags =3D flags;
> +	init.parent_names =3D NULL;
> +	init.parent_hws =3D parent_hw ? &parent_hw : NULL;
> +	init.parent_data =3D NULL;
> +	init.num_parents =3D parent_hw ? 1 : 0;
> +
> +	gate->reg =3D reg;
> +	gate->bit_idx =3D clock_idx;
> +	gate->flags =3D 0;
> +	gate->lock =3D lock;
> +	gate->hw.init =3D &init;
> +
> +	hw =3D &gate->hw;
> +	ret =3D clk_hw_register(dev, hw);
> +	if (ret) {
> +		kfree(gate);
> +		hw =3D ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +
> +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl
> +*clk_ctrl) {
> +	if (readl(clk_ctrl->base) & REVISION_ID) {
> +		u32 val;
> +
> +		/* I3C 250MHz =3D HPLL/4 */
> +		val =3D readl(clk_ctrl->base + SCU1_CLK_SEL2) &
> ~SCU1_CLK_I3C_DIV_MASK;
> +		val |=3D FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
> SCU1_CLK_I3C_DIV(4));
> +		writel(val, clk_ctrl->base + SCU1_CLK_SEL2);
> +	}
> +}
> +
> +static inline const struct clk_hw *get_parent_hw_or_null(struct clk_hw
> +**hws, int idx) {
> +	if (idx < 0)
> +		return NULL;
> +	else
> +		return hws[idx];
> +}
> +
> +static int ast2700_soc_clk_probe(struct platform_device *pdev) {
> +	const struct ast2700_clk_data *clk_data;
> +	struct clk_hw_onecell_data *clk_hw_data;
> +	struct ast2700_clk_ctrl *clk_ctrl;
> +	struct device *dev =3D &pdev->dev;
> +	struct auxiliary_device *adev;
> +	void __iomem *clk_base;
> +	struct clk_hw **hws;
> +	char *reset_name;
> +	int ret;
> +	int i;
> +
> +	clk_ctrl =3D devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
> +	if (!clk_ctrl)
> +		return -ENOMEM;
> +	clk_ctrl->dev =3D dev;
> +	dev_set_drvdata(&pdev->dev, clk_ctrl);
> +
> +	spin_lock_init(&clk_ctrl->lock);
> +
> +	clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(clk_base))
> +		return PTR_ERR(clk_base);
> +
> +	clk_ctrl->base =3D clk_base;
> +
> +	clk_data =3D device_get_match_data(dev);
> +	if (!clk_data)
> +		return -ENODEV;
> +
> +	clk_ctrl->clk_data =3D clk_data;
> +	reset_name =3D devm_kasprintf(dev, GFP_KERNEL, "reset%d",
> +clk_data->scu);
> +
> +	clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> clk_data->nr_clks),
> +				   GFP_KERNEL);
> +	if (!clk_hw_data)
> +		return -ENOMEM;
> +
> +	clk_hw_data->num =3D clk_data->nr_clks;
> +	hws =3D clk_hw_data->hws;
> +
> +	if (clk_data->scu)
> +		ast2700_soc1_configure_i3c_clk(clk_ctrl);
> +
> +	for (i =3D 0; i < clk_data->nr_clks; i++) {
> +		const struct ast2700_clk_info *clk =3D &clk_data->clk_info[i];
> +		const struct clk_hw *phw =3D NULL;
> +		unsigned int id =3D clk->id;
> +		void __iomem *reg =3D NULL;
> +
> +		if (id >=3D clk_hw_data->num || hws[id]) {
> +			dev_err(dev, "clk id %u invalid for %s\n", id, clk->name);
> +			return -EINVAL;
> +		}
> +
> +		if (clk->type =3D=3D CLK_FIXED) {
> +			const struct ast2700_clk_fixed_rate_data *fixed_rate =3D
> +&clk->data.rate;
> +
> +			hws[id] =3D devm_clk_hw_register_fixed_rate(dev, clk->name,
> NULL, 0,
> +								  fixed_rate->fixed_rate);
> +		} else if (clk->type =3D=3D CLK_FIXED_FACTOR) {
> +			const struct ast2700_clk_fixed_factor_data *factor =3D
> +&clk->data.factor;
> +
> +			phw =3D hws[factor->parent_id];
> +			hws[id] =3D devm_clk_hw_register_fixed_factor_parent_hw(dev,
> clk->name,
> +									      phw, 0, factor->mult,
> +									      factor->div);
> +		} else if (clk->type =3D=3D CLK_FIXED_DISPLAY) {
> +			reg =3D clk_ctrl->base + clk->data.display_rate.reg;
> +
> +			hws[id] =3D ast2700_clk_hw_register_fixed_display(reg,
> clk->name, clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_HPLL) {
> +			const struct ast2700_clk_pll_data *pll =3D &clk->data.pll;
> +
> +			reg =3D clk_ctrl->base + pll->reg;
> +			phw =3D hws[pll->parent_id];
> +			hws[id] =3D ast2700_clk_hw_register_hpll(reg, clk->name, phw,
> clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_PLL) {
> +			const struct ast2700_clk_pll_data *pll =3D &clk->data.pll;
> +
> +			reg =3D clk_ctrl->base + pll->reg;
> +			phw =3D hws[pll->parent_id];
> +			hws[id] =3D ast2700_clk_hw_register_pll(id, reg, clk->name, phw,
> clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_UART_PLL) {
> +			const struct ast2700_clk_pll_data *pll =3D &clk->data.pll;
> +
> +			reg =3D clk_ctrl->base + pll->reg;
> +			phw =3D hws[pll->parent_id];
> +			hws[id] =3D ast2700_clk_hw_register_uartpll(reg, clk->name, phw,
> clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_MUX) {
> +			const struct ast2700_clk_mux_data *mux =3D &clk->data.mux;
> +
> +			reg =3D clk_ctrl->base + mux->reg;
> +			for (int j =3D 0; j < mux->num_parents; j++) {
> +				unsigned int pid =3D mux->parent_ids[j];
> +
> +				mux->parent_hws[j] =3D hws[pid];
> +			}
> +
> +			hws[id] =3D devm_clk_hw_register_mux_parent_hws(dev,
> clk->name,
> +								      mux->parent_hws,
> +								      mux->num_parents, 0,
> +								      reg, mux->bit_shift,
> +								      mux->bit_width, 0,
> +								      &clk_ctrl->lock);
> +		} else if (clk->type =3D=3D CLK_MISC) {
> +			const struct ast2700_clk_pll_data *pll =3D &clk->data.pll;
> +
> +			reg =3D clk_ctrl->base + pll->reg;
> +			phw =3D hws[pll->parent_id];
> +			hws[id] =3D ast2700_clk_hw_register_misc(id, reg, clk->name,
> phw, clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_DIVIDER) {
> +			const struct ast2700_clk_div_data *divider =3D &clk->data.div;
> +
> +			reg =3D clk_ctrl->base + divider->reg;
> +			phw =3D hws[divider->parent_id];
> +			hws[id] =3D clk_hw_register_divider_table_parent_hw(dev,
> clk->name,
> +									  phw,
> +									  0, reg,
> +									  divider->bit_shift,
> +									  divider->bit_width, 0,
> +									  divider->div_table,
> +									  &clk_ctrl->lock);
> +		} else if (clk->type =3D=3D CLK_GATE_ASPEED) {
> +			const struct ast2700_clk_gate_data *gate =3D &clk->data.gate;
> +
> +			phw =3D get_parent_hw_or_null(hws, gate->parent_id);
> +			reg =3D clk_ctrl->base + gate->reg;
> +			hws[id] =3D ast2700_clk_hw_register_gate(dev, clk->name, phw,
> reg, gate->bit,
> +							       gate->flags, &clk_ctrl->lock);
> +		} else {
> +			const struct ast2700_clk_gate_data *gate =3D &clk->data.gate;
> +
> +			phw =3D get_parent_hw_or_null(hws, gate->parent_id);
> +			reg =3D clk_ctrl->base + gate->reg;
> +			hws[id] =3D devm_clk_hw_register_gate_parent_hw(dev,
> clk->name, phw,
> +								      gate->flags, reg, gate->bit,
> +								      0, &clk_ctrl->lock);
> +		}
> +
> +		if (IS_ERR(hws[id]))
> +			return PTR_ERR(hws[id]);
> +	}
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> clk_hw_data);
> +	if (ret)
> +		return ret;
> +
> +	adev =3D devm_auxiliary_device_create(dev, reset_name, (__force void
> *)clk_base);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct ast2700_clk_data ast2700_clk0_data =3D {
> +	.scu =3D 0,
> +	.nr_clks =3D ARRAY_SIZE(ast2700_scu0_clk_info),
> +	.clk_info =3D ast2700_scu0_clk_info,
> +};
> +
> +static const struct ast2700_clk_data ast2700_clk1_data =3D {
> +	.scu =3D 1,
> +	.nr_clks =3D ARRAY_SIZE(ast2700_scu1_clk_info),
> +	.clk_info =3D ast2700_scu1_clk_info,
> +};
> +
> +static const struct of_device_id ast2700_scu_match[] =3D {
> +	{ .compatible =3D "aspeed,ast2700-scu0", .data =3D &ast2700_clk0_data }=
,
> +	{ .compatible =3D "aspeed,ast2700-scu1", .data =3D &ast2700_clk1_data }=
,
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ast2700_scu_match);
> +
> +static struct platform_driver ast2700_scu_driver =3D {
> +	.probe =3D ast2700_soc_clk_probe,
> +	.driver =3D {
> +		.name =3D "clk-ast2700",
> +		.of_match_table =3D ast2700_scu_match,
> +	},
> +};
> +
> +module_platform_driver(ast2700_scu_driver);
> --
> 2.34.1


