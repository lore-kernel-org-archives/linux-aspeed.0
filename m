Return-Path: <linux-aspeed+bounces-2576-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DFDCCF9E0
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 06:57:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cscKg46W2z3bd0;
	Thu, 23 Oct 2025 17:57:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761202647;
	cv=pass; b=Wb1eKO8LNEabuS6mKBWZmmV1bkYT5swBr5DHFC1yMt9QfUmCssATJ9JGtlLrL+x5JlI9Ip7LGm725F2PbOLcTJnAX/NrmnA8Z5PH+pPHVYms0VaW3ETxhUtjSjalUWA9Y6yuxoIdlwQy5pFnS1A7PXndJPzwpvVbyg78hOgtTc0lUXsujtVZa50m9QXPG5H7tDNv0xGnQnUSDBIAHCvCz+bkLWDyM0PhaLlv4PHpZqP7QDj81xpE01S3DYf8q8l12A3A0VOvJQjyVR8hPF3mZf/RsfJm3HdLZcoP0PwGDL1LNWqxaFRXWP5sG0LkvnBGie+UotnoFgLS1iuHXsfdsA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761202647; c=relaxed/relaxed;
	bh=tuSX4OV274Em+3A2ShYqJ0GHD33iM3ViwyUtqB6pTnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W22bg6E+Lpk8nZDDd3jVUF6bFnUrEQ3lwJd1U0pdG4861q0tg9Aeohu5GiNmwsDEmWm9oYDwjt7x8JfLOxUYK4xygqMEiam51EOXN1tJtOb/y0IGtn95Qigtf6851ns44iFtRS+69oz0q8OKeNNLFMnJeJs0Qhxid2TIs9SHpfEz06P5fzeb+XZY0CshAW+V9VuYUoz0TgSHOIWR5cjd47WB4knkj+FpWD2iSkWx4dN0t+nKszBBv49+g4+g+bFozbq7ESIRdJ5M9Fx8rNBe2vdpkhjarOHFEr1ndIbZdyMBRRMc0IEkogJn42KWNav2RWzXZVuyqsTgqhUvz/amlg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=p3EznfFe; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=p3EznfFe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cscKf0qtKz3bW7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 17:57:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYnrERgFJEl1lHIWfHHumMh1tw/SAXsgFXTf+63uQmcg44twm/pn/ksu2E7M3dv6D+vGFVS0tSP6bID1K0Hk8WPlLeq9Fyx67icoAAMXRL0h7Vfof71fofiZbugZZ7Rhminnrlojp6IYKtkOOtd6p7QdyhbBfOFjoENPUtMUGoqLfgfFBeaAKTlVYtzgRknYfCjlLChV9GnpkQB85oZA10a5lag9dK3Mb4r4MAgWywbesaNr+6JysHGBFccha4X6suU4EvNlj81KZ0wWcATw+IM2huEs9mCgi9eN8FkhnOskp2G68gxs9W+cSXaVXkXJ48h165bK88iJoR+i4CGVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuSX4OV274Em+3A2ShYqJ0GHD33iM3ViwyUtqB6pTnQ=;
 b=rhaCQHjWsQpKfD9kIvBQ9J4PFJ4cz+bv6T0hrzpRYs8lXf9XLSRr2b5wRtHRo9Su9svqzDLbmurNqgZskmQOw6bEWPHeViTCuAKv2lJR5S9NnK73Is8cTkkndZ3qRNSuRNxvsVaBGXiM7ztd3FJBHXpilW9fRwrp5RP/tSsJ0g+EaHl7KyegHYPUjjtydqKm4ffoi7km72HzZ6v586S/GNC7EJze0i3I1d1tucofEv0Vk8YMRHkQSSwv9qDdDNAJTei4A25j1VwWa0h191P8gzKFqsjE/PAH5HERWa6pla60Kwtej7pgviU9aPjRQydclypxmo1lMULMIxiLXv1eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuSX4OV274Em+3A2ShYqJ0GHD33iM3ViwyUtqB6pTnQ=;
 b=p3EznfFenNYakLaVaMPzFu14wL/bTqG53aH6aa35sD3pw58T796FvNgPO90tLUTr5BGTOR5TYupk0O2g4J9YaDdFrFmcxiRCJNQYIkxXVknST2ksJX6w+bGfHH0ZiImrei5JGaBa+naoGv1Ftv7JfXGYSK0Y6ov0HVs/gUaDqUljVg3aCye4ABd0x+x/ZASR+yysd2Uqn/DqQLVdDTzxctrUPN2vCA5WPMb41vqeCyZ4lzH7OsqiwhEJ7LJzsai7HVnS03yGAzcq3PPtZFjisP7U999qwt8oaHvwGcku2soRejSDaR+acUUtRFtnfVnFgD8bhmhszKe8FFqw/XhsBw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by JH0PR06MB6512.apcprd06.prod.outlook.com (2603:1096:990:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:57:01 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:57:01 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 1/3] dt-bindings: interrupt-controller: aspeed,ast2700:
 Add support for INTC hierarchy
Thread-Topic: [PATCH v5 1/3] dt-bindings: interrupt-controller:
 aspeed,ast2700: Add support for INTC hierarchy
Thread-Index: AQHcQyDQYO/3l6vgwk2QRDf7VCK0I7TOL4uAgAEN90A=
Date: Thu, 23 Oct 2025 06:57:01 +0000
Message-ID:
 <TY2PPF5CB9A1BE674594566C13B8D8B2984F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
 <20251022135101.GA3349934-robh@kernel.org>
In-Reply-To: <20251022135101.GA3349934-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|JH0PR06MB6512:EE_
x-ms-office365-filtering-correlation-id: f6cb6c70-944d-4866-405b-08de12015e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BlYKgJSpDR3xxgkJyujvnhUwHX3Z7nV1NRUAewEwkb+qAlEvyIzB/E/cNsCz?=
 =?us-ascii?Q?HzyGxJDHQSKu4S5lRbotMQ1Pii9hQepHTUXKQW+k8eFvPNRD9i5Vz/Nff8Qq?=
 =?us-ascii?Q?h4vBapSewq3N9OG641iWhDVhHO5m0IX/a6CLcT2Zmxljgpex8wQng9HquonF?=
 =?us-ascii?Q?YuwVwkdkfEVT7V8D1beV8URyu0xCcG8CZlHAsgFto86u+3y+AgJNTixpuPa3?=
 =?us-ascii?Q?zLGcExEXsYyHjnUqgCWyQJY1dXIG6lb7mBYWD3yyZGjicfSDj878SfbuJCMg?=
 =?us-ascii?Q?LpwfDde61axmNzfJBfl5rGx4l7ugW6pyW4SwX0htXlWOzvOZ6NbQkmZYRUHW?=
 =?us-ascii?Q?Lqew8J2MuF7Of3iEsTeXJVuMzejqSqDKl5iBwgUXGS1JWuZu2IAQE9MLoZCN?=
 =?us-ascii?Q?xFlr4n+1map3Fl9Q/rlYk95OOgK/hRVN2JvdGBxD+RIM+Ga9CCNEFvFmBaLo?=
 =?us-ascii?Q?86sjDFPr+yIaUNnB2hGoEbfG3Ft6WHtlIzgPdLP7TkgfVkmR0kmzaJLfFN+n?=
 =?us-ascii?Q?5fuHApeDaziVXbKeOZ1vuVzz+y9dkGcyJUKnw+SrWG/oqqiqZgQz8S+PMKc0?=
 =?us-ascii?Q?R8nv2c54M8s25Hmw44/Jp1Nc0M1uSQjE/UMm7PHuIytBakgvb56Fk6fLsTrm?=
 =?us-ascii?Q?G3MwFziT16NxaZPF6IEQqs8XkRzLm9Z4QHM9yCIvF9TRizyiMFSpYirvMEZi?=
 =?us-ascii?Q?Ta7yHKax9iC7RKvS7eJmxu32tGpELJHwc/7CffMK4QA2YCSvrz5jdM4lOAi7?=
 =?us-ascii?Q?Tw8z0OI3mvaubjutySI1jakvx9Vgf3uisKRVlc15JZs1UnZla5lAnOop68zX?=
 =?us-ascii?Q?fTIYZM3CETl4H4zq5bggzUJMXxzc2NKvafT1duCSF3yC4fwyfNGAg6GWSykx?=
 =?us-ascii?Q?1jfCadnKL2F0g4Guvb6NQVfoeqzYSnsRDabYkplGvZSQ4BVlSXHm0wowvyJX?=
 =?us-ascii?Q?B3taTerMLZvxxM1Di4itik89csFC+2yCPo+Qd2h3EZOfNUBXi55xGCyVyteq?=
 =?us-ascii?Q?0MPgFbg6t/b1XKn06z5DNh/0l6ag6K1JfDn/mkmMgLY3kPwF8UWk9kCp3M1w?=
 =?us-ascii?Q?WHL+uakiJI8xIV0aVCqgxMctZrN+qMVECfmIChwtQHUQrbJUfpDMHoU/ELHH?=
 =?us-ascii?Q?IfBjgVrClhK08wftuYl2sYccXu1bv693VDfznG5clEll++d5DWL47I0RiaMu?=
 =?us-ascii?Q?D/147iaMBpLIHbR7w1+PxkHr3Mk6DW8kADn96p2ImOl8nyaRCFWjhg11PI+o?=
 =?us-ascii?Q?uEg5vKT/xoHOLTMvlEXe7A9Vpzue3EDJkAfPRNvlvWuPvKYhERcjs6Z9g2va?=
 =?us-ascii?Q?jQ6Ur2XSq3PwO4aTMegsoeGY6N1xWj3AdB89OrX+l0URc+KEJsjl2Nxn/z8B?=
 =?us-ascii?Q?QXh5mj6cRsmEBXuVED2L2Mrt0/hQ8jiBci0Jp9zyiN5OP0SvomPuqem8+sCv?=
 =?us-ascii?Q?RF0CBBg7R/Rd3kpkBB+PV26967qyeQr+tJBQFecg32ioBJArdCsB6g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GID12oL2NRg/oFaL4H3jiqMMCoxtsisH0GxFbaDqmiMH0a0xSzPGCgmF52cg?=
 =?us-ascii?Q?yQHAqO4Qw41oK4gXTsO+6qVjNgm/HOU26/RYeowNonF6Ef8OP8XVngycqcnY?=
 =?us-ascii?Q?yhER8hsWTK0mA4U8GcgMuiTed9k+4/pSkwdCEf7cWaJwgHljqkMUaGwJP6Y9?=
 =?us-ascii?Q?q54WAGV/YVaY1683qU595gNAbvfwSPCOUc+oX3l6bbbAcErfpRFrkf1D/Ndr?=
 =?us-ascii?Q?+i1BbfLLtDkdc1YZ4gjq/El4q+eFjvoxMxW3SdYnbdkIm67iwxK0H/gPoV3q?=
 =?us-ascii?Q?yYLfNjRfSDOnuDJCgHpNIYyeFeJ5QfojntyKUumchCenWfLWr4IP3SeIcDsO?=
 =?us-ascii?Q?LCc9auZb4iX+J1GDfoG8gK6JtC+kqOL9HHJtPIDoOYoY4yD4wsVM6vaa6Lxe?=
 =?us-ascii?Q?aQgZ4q4dEnDN6iCtxvcoxRhRMzpshFoh1FhWFTx/9OGjnsTQvOay+QcWakre?=
 =?us-ascii?Q?gm9BBdl+OC7TRA13qbbOMmangM7KJ9FfsZu807Vt5zz8bcTI/FgOnvr2EsOE?=
 =?us-ascii?Q?cZck+plRa+g6tDjuRVSq3K8HPt1TMY+Ji8KXQWnbwHOCz1VDVEO43nDhSvdA?=
 =?us-ascii?Q?lJBmBBPdKrS0EJjLhKEtcscjSankiurv30v/DpOaPUXgwNRvtFGyiXSGy7QK?=
 =?us-ascii?Q?hyuOF8VyEp9Du457NvgaIJJj1ByGDi8gEUBAPd2Rkw02buIz89LVABKi/19Z?=
 =?us-ascii?Q?4/FBHG7Jl3OS0fp+EsoKyYbggcwNUOwFdIv30q8MfKUggivt8wdoVcl8G67W?=
 =?us-ascii?Q?loiaV8hzYtnV0tPy8heNRlLlObm16wzLRefxVoX7zK3Ef0jmyT0aHPVLRFtF?=
 =?us-ascii?Q?oQZfugCxe8RWtqAUv3sUGi8bnzEQcG1bULnIdKFyBvLQbdgbVC6hn0t4asMm?=
 =?us-ascii?Q?hJ/Ycyas+XZtqg6Eyh4KSaiNVOHdHKhsP/pYskN21PieAlRPSJErBUqPnLvW?=
 =?us-ascii?Q?zjcXST0NMLz7zsY6mubfgzP7fIwGRYzJQfRTFqto/nuSdISUaMHN4tzieunU?=
 =?us-ascii?Q?cJCnHGBqY5y+dwOeOyEzaR4uA6lh/5GoaOYU8Licsgqav4ZbpXV3lNvJhT2B?=
 =?us-ascii?Q?xva6hZw0CFAblnrW0gTYDbB+PPBusSZryzOf/lQWuH3RteQ4w2IINMMCafJw?=
 =?us-ascii?Q?vdHrLsHW2n2CVJf3BLoMdldto2hIhOVqwHY2U/tZWsDfIsrinECKTwYZRDzE?=
 =?us-ascii?Q?5VZQIUinpZUbQfdlC2RB3lfHXV+gsjiuXvpYGTCOvUn2LdzGetxv4MA4Bjsp?=
 =?us-ascii?Q?nYLCP4s563GvQpOfxA5QshDwyVsRVtGMo+F7i2SId/TLB0d2e5ZIMqvs7XyB?=
 =?us-ascii?Q?VTb5g5nlTF7fNrmo4Z4f+HVY+3BxUsxbEQXe5GexkOyC+mnqsvTSZbW7sqh5?=
 =?us-ascii?Q?ZbGjcnufxBGwOvotLu5xvgKcIGjKobSqf+SHTROVweGOu1hn/J7U9DnBnltH?=
 =?us-ascii?Q?uuwBB5VRDi4KCxgscockF3JYgD2m6crqNOzBk45BnlRxgQ9Z1LXhXb/zwMGx?=
 =?us-ascii?Q?lvpStXRZRNy5Jn8hL44rkBaku/XApLnxMroLyW8eiRNAO5KnszKis73Ep8jY?=
 =?us-ascii?Q?DZtBqV++zGaTzxZSZEhwwPsnwxpCLZAYf2s45h+B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cb6c70-944d-4866-405b-08de12015e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 06:57:01.5653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/HnKV1FU3QwxAgXa/E5DwHEg5w+Wa1EbFapWgFYB5OloXHpQ32gP9H1+61vNmxNnEBh9qX6XmhFl6OBef55mAtCwH/g5BTG0S69hTCpaGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6512

Hello Rob.
	Thank you for your detailed review and comments.

> Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: aspeed,ast=
2700:
> Add support for INTC hierarchy
>=20
> On Wed, Oct 22, 2025 at 02:55:05PM +0800, Ryan Chen wrote:
> > AST2700 contains two-level interrupt controllers (INTC0 and INTC1),
> > each with its own register space and handling different sets of
> > peripherals.
>=20
> This is a mess!
>=20
> How does this relate to the existing "aspeed,ast2700-intc-ic"? Its schema=
 has a
> block diagram of connections which I can understand. This does not.
>=20
> The use of child nodes here is questionable. A variable number of interru=
pt
> banks is not a reason to have child nodes. I'm only guessing that's what'=
s
> happening here because you haven't explained it.

Let me clarify the hardware structure and the purpose of these bindings.

The AST2700 SoC includes two top-level interrupt controller modules,
INTC0 and INTC1. (aspeed,ast2700-intc0, aspeed,ast2700-intc1)
Each of them provides routing selection and register protection
features.
Within each INTCx block, there are multiple sub-blocks called
intc-ic, each handling multi-interrupt sources.
("aspeed,ast2700-intc0-ic", "aspeed,ast2700-intc1-ic")

Cascading occurs between the child banks:
Level 1 : intc0-ic have multi-interrupts connect to GIC (root)
Level 2 : multi Intc1-ic# connect to intc0-ic
The parent intc0/1 nodes expose register regions for routing and
protection control, serving as containers for their intc-ic children.

The following simplified diagram shows the hierarchy:


                                 +----------+       +----------+
                                 |  intc0   |       |  intc1   |
- - - - - - - - - - - - - - - - -+---- -----+- -  - +------ - -+
  +-----------------------+      |          |       |          |
  | +-------+ +---------+ |      |          |       |          |
  | |       | |         | |      |          |       |          |
  | |  PSP  +-+ GIC     | |      |          |       |          |
  | |       | |         | |      |          |       |          |
  | +-------+ |         | |      |          |       |          |
  |           |         | |      +----------+       |          |
  |           | 192~201 <-|------+          <-------+ intc1-ic |
  |           +---------+ |      |          |       |          |
  +-----------------------+      | intc0-ic <-------+ intc1-ic |
                                 |          |       |          |
                                 | 			<-------+ intc1-ic |
                                 +----------+		  .....


>=20
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../aspeed,ast2700-intc0.yaml                 | 97
> +++++++++++++++++++
> >  .../aspeed,ast2700-intc1.yaml                 | 94
> ++++++++++++++++++
> >  2 files changed, 191 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-
> > intc0.yaml  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-
> > intc1.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc0.yaml
> > b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc0.yaml
> > new file mode 100644
> > index 000000000000..93a5b142b0a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,as
> > +++ t2700-intc0.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-int
> > +c0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +maintainers:
> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > +
> > +title: ASPEED AST2700 Interrupt Controller 0
> > +
> > +description:
> > +  This interrupt controller hardware is first level interrupt
> > +controller that
> > +  is hooked to the GIC interrupt controller. It's useful to combine
> > +multiple
> > +  interrupt sources into 1 interrupt to GIC interrupt controller.
> > +
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2700-intc0
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  "^interrupt-controller@":
> > +    type: object
> > +    description: A child interrupt controller node
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - aspeed,ast2700-intc0-ic
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      '#interrupt-cells':
> > +        const: 1
> > +
> > +      interrupt-controller: true
> > +
> > +      interrupts:
> > +        minItems: 1
> > +        maxItems: 10
>=20
> What are the 10 different interrupts? You have to define what each one is=
.
In currently design in level 1, intc0-ic connect 10 interrupts to CPU GIC.=
=20
So, should i use const:10 or I just use minItems: 1?

>=20
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupt-controller
> > +      - '#interrupt-cells'
> > +      - interrupts
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    intc0: interrupt-controller@12100000 {
>=20
> This node is not an interrupt-controller.

If can't use the interrupt-controller here.
What can I use? "intc0: controller@12100000" is ok ??

>=20
> > +        compatible =3D "aspeed,ast2700-intc0";
> > +        reg =3D <0x12100000 0x4000>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0x12100000 0x4000>;
> > +
> > +        intc0_11: interrupt-controller@1b00 {
> > +            #interrupt-cells =3D <1>;
> > +            interrupt-controller;
> > +            compatible =3D "aspeed,ast2700-intc0-ic";
> > +            reg =3D <0x1b00 0x10>;
> > +            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
> > \ No newline at end of file
>=20
> Fix.

Will fix it in next version.

>=20
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc1.yaml
> > b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc1.yaml
> > new file mode 100644
> > index 000000000000..2f807d074211
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,as
> > +++ t2700-intc1.yaml
> > @@ -0,0 +1,94 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-int
> > +c1.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +maintainers:
> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > +
> > +title: ASPEED AST2700 Interrupt Controller 1
> > +
> > +description:
> > +  This interrupt controller hardware is second level interrupt
> > +controller that
> > +  is hooked to a parent interrupt controller. It's useful to combine
> > +multiple
> > +  interrupt sources into 1 interrupt to parent interrupt controller.
> > +
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2700-intc1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  "^interrupt-controller@":
> > +    type: object
> > +    description: A child interrupt controller node
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - aspeed,ast2700-intc1-ic
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      '#interrupt-cells':
> > +        const: 1
> > +
> > +      interrupt-controller: true
> > +
> > +      interrupts-extended:
> > +        minItems: 1
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupt-controller
> > +      - '#interrupt-cells'
> > +      - interrupts-extended
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    intc1: interrupt-controller@14c18000 {
> > +        compatible =3D "aspeed,ast2700-intc1";
> > +        reg =3D <0x14c18000 0x400>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0x14c18000 0x400>;
> > +
> > +        intc1_0: interrupt-controller@100 {
> > +            compatible =3D "aspeed,ast2700-intc1-ic";
> > +            reg =3D <0x100 0x10>;
> > +            #interrupt-cells =3D <1>;
> > +            interrupt-controller;
> > +            interrupts-extended =3D <&intc0_11 0>;
> > +        };
> > +
> > +        intc1_1: interrupt-controller@110 {
> > +            compatible =3D "aspeed,ast2700-intc1-ic";
> > +            reg =3D <0x110 0x10>;
> > +            #interrupt-cells =3D <1>;
> > +            interrupt-controller;
> > +            interrupts-extended =3D <&intc0_11 1>;
> > +        };
> > +    };
> > \ No newline at end of file
> > --
> > 2.34.1
> >

