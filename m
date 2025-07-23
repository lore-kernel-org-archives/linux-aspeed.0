Return-Path: <linux-aspeed+bounces-1783-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4341CC83F25
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 06:03:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bn3Tv6wfmz30Qk;
	Wed, 23 Jul 2025 16:03:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753250611;
	cv=pass; b=QSMyNo6wxPT2KVe6V7H/38lEpSHnT5wn08//F9TDliNAwZ0STsSxH7zzR4ItT/0UgzzE6QpBlqM81WxkZYQmamAFnV+i8uZQzOCGncdVZwS0pM2A/pPU7FM+lZVJzxxBrzu7BxisCFQgv271VHESZF4cWhcllQeIygPml9RXxhnMOCQA4Js63v4331g2Fmx0TDqtHMdwaVzZpya4C93uqSEA+cg/sfRUYEp8MV8RzbhrwjweIgl1H45JJ+myf/oWznAzXnKWFpByUEJckhpH+0euJtp2wrz9Luiqa7QgBEuV+OnVDwF0yql50h7xPZVdkZLh2X5wDCH2bFAgH1XDiA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753250611; c=relaxed/relaxed;
	bh=LbYmxW332nVcxEVq858+gXUYmWBVqLzsrrXPQz1SAbU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJJAGlSi8LXrCg2UCr1g5I1VcsQ+nUOjBV86nKl6XwoiUVp9on5/qfxVWlT6eXa7SHhr1r4aH+xxNwbPApqR1HlcEkAlaKLBXPwng5BVNKtMlrSH16za/iOYBIfQSBiE4BnTu16rG7BWYwnwGCi8Kcye7sctQcLHv3LxHdedONA3Onzt3aOrzhu5oPhu9OAGGSo1tEOTKV4qtfIYSoFoy8prZKhDwduqKkkFZ4Is/VuInkHQnYRB4zppNSjceB0jL0IR8PT6IdsvDnz2+i0i0N5Z35kK2CN7XoJSfZ+WR+m/yMvAfSni2MPbbNsvHyoWFcA4xywUMI4yD8BSWc5GMg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn3Tf0P2Sz2yF0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:02:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2YvV+T8AOQqsmuGQHfl0dw2ZF3H2QcUbyOt1zmqqNVFuny9jBkYy1QbCD753Zx+uJqY6nKsbBsUDNblJEaFR2Y/hc+UyguT2jNIqyXWBi++sRRjK06yZTdsXZEt43m+xS2w8oGXTGWEiNfSDK6V3a5Dw1WLJtLGfmQQwST9uuNiIsfw35fxXg8C+6HzEijPdv4hVkoyMTi1g4CIMxlf5dqP7M1mWghi4SO9D1vx/Twq9EO7P9ynfRFR05BsObM8bkhm1l6wuARLypxURcVtjlpTGKX93DFhoE/nDSFbdsZGlmQALc+Nmn6LEw0HCzVciwZKVslc6UKotWUhYtYJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbYmxW332nVcxEVq858+gXUYmWBVqLzsrrXPQz1SAbU=;
 b=bXzlV7y3/FLmsSqlzNVRdW57/R9KxbSTggeCQQfnRJMT5spV9m0Jm0bWW82Wxo2L+46Q9BQSde2TfWed80zarz4/FbS/AZPy3LROHPGS6fByfxnrhk8JxWC0gkT21mOtDhjGP7NUnxX1CF9/znnSGmsTCAmvwv4f5DO3ywX746R2ATO326lAxPD3W4dl7pOTCwdGDUyA3749eHlc6LfBrMTP/bEFcvR6yfrylbpJkeXaT/TCAOwY0RbTMjMg2vWirqG1pdQDWm8LxfoXj1lx94VJCFSCEnG2Fu9EqNnn7a57NltKrUsgfUZBvW3a57PM/Fc7EWvzeXiEYpYeXq24uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbYmxW332nVcxEVq858+gXUYmWBVqLzsrrXPQz1SAbU=;
 b=DtV3lWsU7X5db7U1Cs3gCArAnL6ivvuOT2jXBdR3nChzxbeHiaDzMZ8gqYfmfdeVc1w6xJpM+pM046ZN3LjzMt3twfSxwXzwAhB6c3CHbupzgYgTKUllTq4WtKFsldeYQjkdg4KhChxsyl3Ady5hzZTpKYBoV1IvWYRDKq5PYz7235pnGnFEqMSuayiMzd+0OscUEsZ16S0k6XaaDdon7IYFopGE+hV2ZXli3V36aUjOWmnAsMGWcr1KuoM8tDdOmjwDlUQ/aO1AucKX54ky6Hp14fWln/z/SUybgDe6EgzAEN93lrle1wJr5M7dYi1Lwb/LMNYVCOr4sy51J2KNJA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYSPR06MB6316.apcprd06.prod.outlook.com (2603:1096:400:430::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 06:02:21 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 06:02:21 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
Thread-Topic: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
Thread-Index: AQHb+u5GY6AhyQJs/0KoaQA5Nmaf5bQ+RGiAgADJr1A=
Date: Wed, 23 Jul 2025 06:02:20 +0000
Message-ID:
 <OS8PR06MB7541516DD4FDEBD72A764042F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-3-ryan_chen@aspeedtech.com> <8734aotfdq.ffs@tglx>
In-Reply-To: <8734aotfdq.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYSPR06MB6316:EE_
x-ms-office365-filtering-correlation-id: 17807a55-d6c4-40e9-fd88-08ddc9ae7cb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h3RQ8LdOHEThZ1pfx30aoPQrMgw1QyN/ySvo7LQc3iiJRv2jrKq+IHIpIWDN?=
 =?us-ascii?Q?fyUVw0CM3Ra7ZiobG+rTa2AvMRudmaY2pG9JDUdeAwcbzlw1NKGSKDoaU7e6?=
 =?us-ascii?Q?fWEC3pccXA8K4spC10ihiU5889kJ8s7zUl5NuZ6Q1/HcPBI662BAjO4vmLUO?=
 =?us-ascii?Q?9Xxe4Fvj0lWQPFbLQNlD04kgQpeXu96814GX8Oe6QvzkCxUFURY3exDfA2IL?=
 =?us-ascii?Q?V+4d3d68M4cZPOTBUStdpuaI4Q9G5Y/v0vK1tQORSuTI2AfG83b42040rE71?=
 =?us-ascii?Q?gyxSEM9UB0MO1MNu6M1DKPKmfXrUgnRmNHvSEyJEdxhjpxVwGGvlO2dVb5M1?=
 =?us-ascii?Q?/BMTx9sxDnUFr1OD+mVLdZQfyua/qt+XRNk7s72y0Q3one2i3clej3OEIPhe?=
 =?us-ascii?Q?vXy0ImlMIljm/9fa1h6uKk4cAoBbUKf7o8s5xXS9AdwYOIj87XBg3hNB0hti?=
 =?us-ascii?Q?EtV6VSMRtNhe+8aAWFq2Vh7PRwWXYwLKCo9yV1d+q1jpnAK3ifu0CXrCu2Z1?=
 =?us-ascii?Q?rF1Z1sxh14IVgSRXyo2PgHr23zt/hX3zHmTZeOMxdFyjVyN9+fqg05yCo80e?=
 =?us-ascii?Q?WNhlHtn6pI2vPY9HQcBri+XVZw1VFaeUKly78uPCsBcL9AZFa/uIqmUQ60q1?=
 =?us-ascii?Q?ZEbmoESoQCGMPZDOQ60xjybByaC4gTmut4xiI2KRhY9lbWOcmqXjp5+E0EAJ?=
 =?us-ascii?Q?gdw2ItRmW2WZw2JEQ1eixGEqRgm0B/BtoqhdW83GziJMwUalKOAo2QWy5Jci?=
 =?us-ascii?Q?VwL1PK4KvvGjfTE+AvYr0prIKzD5Z6SKoQoT83x1XH0JBhka6lfnfDO9QVrS?=
 =?us-ascii?Q?2LOjNZ5QWf/La/HoOxPk68WION8OMo4IN/6r93sbhkPX7+05oa7+8CLQTM2A?=
 =?us-ascii?Q?VRg3oseDtRbg0AyA4WNB8eVIHq3wzZn8FgbYVmvCC4cS1cNFPPpYQbe98JDM?=
 =?us-ascii?Q?2mGSdsVt7xiNiXcPpQn2cSOw/n0G9v+vKE05R683/FNkF+2WJazORscUfa8S?=
 =?us-ascii?Q?dbYO6I8c5Teoym2lnKLdIzye6kxEvafMxA6yuh5wSgL8DY1dEeP7fqHqMpGl?=
 =?us-ascii?Q?DMATcMzEplI3TgVFve2gereyNupodhDuBAMLlJGcJMDq8O48yDaJAM8HrmW5?=
 =?us-ascii?Q?esstRGajA7ZFv/XDf3Adb2YyE30RiPqAWbxyk/hp9QpSTzjNzUxmAC3dE41Z?=
 =?us-ascii?Q?bmpyn5Tnykl0lvszFDEcYzrOMaXDRMm2Qybw8XtojZUPqaU9h/15z3oD1pRH?=
 =?us-ascii?Q?QTMCOuEwP0I1urKosNL2UStiU+uCQZQkvc3iKOJIiz3/y1UfVKFgiS6lXn+l?=
 =?us-ascii?Q?+1+lzGkm29J4y/IUfogUPITMlTJKx5xu02vBhgVjKCxjKLek8jrGkI8W08Nk?=
 =?us-ascii?Q?2acWaMSQB1MaAgjBVVZAQ4zH+o/pmlwkI9RAi0kjunzqyt9PusHhBn4ijFMO?=
 =?us-ascii?Q?MabQcODdqzwVvjvE968M0KB/SV/XJC+a?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c13wVmijoq7aDClv/FqTzrv3lGRNGlMAytrXnXtXbbjowcPfsN6llCun2J2L?=
 =?us-ascii?Q?7ByLJXcguOO8vy1/VdU7hXzctCpRcvKoNWICVDOLMzX6W9mespMKSsLdskfK?=
 =?us-ascii?Q?XD4woDrSwVDVeeGFaoAn7xF6dc18kO8K0L/rw8k0dcexGbhQ3I3YkYhU3cRt?=
 =?us-ascii?Q?PAxZpsITpUkEPwBxOGx4Fnni2XFjMNX+VRA2oPX9jr7Gt4imfFwxipr+P1za?=
 =?us-ascii?Q?xNeaj9LRrdjTAlDzza2zn/E3QOvQ/0F0FfbsSW/HW0YAvfAwnKeZ6Wyfp8vX?=
 =?us-ascii?Q?a9YbivVo7wtd/d1FtkxPn6yJWFmpIMQGcel6KyDawpFx5jFz9d5PBx1eEPL8?=
 =?us-ascii?Q?FrH7noXGNJVmQ9CPE7UjhwIxmznIBYwK14b7h6VQ6cqoQ1Vnt8XnpN+L4eFd?=
 =?us-ascii?Q?F7t2h6zCAh87rOpJYjwMwLcSGVTywFrUQSc+mDUdFT1Uh8MNnT1ZDGkRF06L?=
 =?us-ascii?Q?lNfeP5gKqV4WMtNCNnm8HjIcx4UlNmNQA+EJon/smXybsuEEZFSQo6/9AYWC?=
 =?us-ascii?Q?rgKo10r7eg42vrSrbODJneAa2RIULgBm38w8Ifti0mgM3lniL6pXSPM1ybds?=
 =?us-ascii?Q?YoQczsmFdYaXH27N9NXd89Q4sj1IoGo4qw9H3wkvALEYP8L43lFXldHxCKFh?=
 =?us-ascii?Q?lqCn/KpWDMd9/7GqypmfbkdKUEsD+A/yS4Yzy4ygilqhWahlvP9TV9C3kigi?=
 =?us-ascii?Q?aJDFGesOaezJphAf5MQ6rmCWkf9O+g6p3hDESHoi7EB6rbw3OspUF9siUhTo?=
 =?us-ascii?Q?iTSP9BKqzmKZ/KYYOu/4BQUA9UOK7i3a4WC6/iToQsHNowk4zLX+DIGG611g?=
 =?us-ascii?Q?z42W1/ubwSfRzSFLka1K4Hfx50sg1P6VMP9v2Dfnbu29qei76waauGQGB9Ux?=
 =?us-ascii?Q?wRKNCaRSbdcqWPY20sHF6+AoNAIW7Dl1S1WAIpYOPCtqrtnmeaK7uXVK+7co?=
 =?us-ascii?Q?evrlwMJJgq4r+BzjiNVTpFpCGR+r+nauwCyEJenhvZyVjhkGfgI0+8eCOeqE?=
 =?us-ascii?Q?CDHVQCjYuxG7wCab8TCZst+6Kedazm2kDIvQ4lhUvDilmMtbbFp0yQ1yaOSW?=
 =?us-ascii?Q?b6aWzpdn/LBk3EwLswNetb0drwH1hyULuTPCDSACTkE0rMuoOqfWUhjxC6SE?=
 =?us-ascii?Q?B/ARVKu3wjJBM5k9vk9FIvaSZ2V3oxoh0yhPuKha9PjpnP8+24Unzw+WeRVV?=
 =?us-ascii?Q?POy1AfhiUyfQWpKrBlFJRzP2exzVLecBNpaHAfU0Cl4DSmRaUOwMhZYw/R6S?=
 =?us-ascii?Q?m+dX+q8MkP1M0G7AEBpcVp25f5lG6EHvLv1nAvytMgsNgWStIGCPNCVSU7MF?=
 =?us-ascii?Q?YRr2W/5Tl9kymTeVutu4KXXiUaQHohhKiL/5q2zp+xCPZC1aYrFinHeLSEGk?=
 =?us-ascii?Q?M5QfJtSzAdqu/5yvywDIRJ95i7nkG0NzvZQjolP1J3bUZAQwjl4FGC4XU921?=
 =?us-ascii?Q?xeJUN9wz4B+BSJaFIUQ0qTvdTp8HbX2sTpXZIe9XckLCM0bErPYWeP6NQxGJ?=
 =?us-ascii?Q?9PtslcOLPTXGhQuAe9ylVh5oZHqHY9kRMiNMPtwwh5XTKw0SedMIP6JD/RDj?=
 =?us-ascii?Q?U0UFRWc9BQCxlGCJG65bwCttRA4n57WvmJvb82XF?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17807a55-d6c4-40e9-fd88-08ddc9ae7cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 06:02:20.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgsKK8ZGiBahUQSTEb0criYGgyfzD+3xqpr1SSZs38ucLh+xCa6YKx/hFQZUIIuzH3X0veFqmZkZ6rBxDreDyg1Heu3YLwBVmavtMokVPMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6316

> Subject: Re: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2=
700
> INTC0/INTC1 routing/protection display
>=20
> On Tue, Jul 22 2025 at 17:51, Ryan Chen wrote:
>=20
> The subsystem prefix is made up. See:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-=
su
> bmission-notes

Will prefix update to
Irqchip/aspeed-intc: add debugfs support and AST2700 INTC0/INTC1 routing/pr=
otection display

>=20
> > AST2700 INTC0/INTC1 nodes ("aspeed,ast2700-intc0/1") not only include
> > the interrupt controller child node ("aspeed,ast2700-intc-ic"), but
> > also provide interrupt routing and register protection features.
>=20
> > This patch adds debugfs entries for interrupt routing and protection
>=20
> # git grep 'This patch' Documentation/process

Modify to
Adds debugfs entries for interrupt routing and protection status for AST270=
0 INTC0/INTC1.
>=20
> > status for AST2700 INTC0/INTC1.
> >
> > - Register platform driver for "aspeed,ast2700-intc0" and
> > "aspeed,ast2700-intc1" compatible nodes.
> > - Add show_routing/show_prot callbacks for both intc0 and intc1,
> > displaying current interrupt routing and protection register status.
> > - Expose routing/protection information via debugfs for debugging  and
> > validation.
> > +
> > +struct aspeed_intc {
> > +	void __iomem *base;
> > +	struct device *dev;
> > +	struct dentry *dbg_root;
> > +	int (*show_routing)(struct seq_file *s, void *unused);
> > +	int (*show_prot)(struct seq_file *s, void *unused); };
>=20
> See the chapter about struct declarations and initializers in the documen=
tation
> I linked to above.

Sorry, I don't see the struct "> > +	int (*show_prot)(struct seq_file *s, v=
oid *unused); };"
My original submit is following, it should ok. Am I right?

+struct aspeed_intc {
+	void __iomem *base;
+	struct device *dev;
+	struct dentry *dbg_root;
+	int (*show_routing)(struct seq_file *s, void *unused);
+	int (*show_prot)(struct seq_file *s, void *unused);
+};
https://www.spinics.net/lists/kernel/msg5776957.html
>=20
> > +static int aspeed_intc1_show_prot(struct seq_file *s, void *unused) {
> > +	struct aspeed_intc *intc =3D s->private;
> > +	u32 prot =3D readl(intc->base);
> > +
> > +	seq_printf(s, "INTC1: 0x%08x\n", prot);
> > +
> > +	static const char * const prot_bits[] =3D {
> > +		"pprot_ca35: Protect INTC100~150,280~2D0,300~350 write by PSP
> only",
> > +		"pprot_ssp: Protect INTC180~1D0 write by SSP only",
> > +		"pprot_tsp: Protect INTC200~250 write by TSP only",
> > +		"pprot_reg_prot: Protect INTC080~0D4 to be read only",
> > +		"pprot_regrd: Protect INTC080~0D4 to be read protected",
> > +		"pprot_regrd2: Protect INTC100~150,280~2D0,300~350 read by PSP
> only",
> > +		"pprot_regrd3: Protect INTC180~1D0 read by SSP only",
> > +		"pprot_regrd4: Protect INTC200~250 read by TSP only",
> > +		"pprot_mcu0: Protect INTC010,014 write by MCU0 only",
> > +		"pprot_regrd5: Protect INTC010,014 read by MCU0 only",
> > +		"pprot_treg: Protect INTC040~054 to be read protected"
> > +	};
> > +
> > +	for (int i =3D 0; i < 11; i++)
> > +		seq_printf(s, "  [%2d] %s: %s\n", i, prot_bits[i],
> > +			   (prot & BIT(i)) ? "Enable" : "Disable");
> > +	return 0;
> > +}
>=20
> I really have to ask, what the value of this metric ton of string constan=
ts and
> decoding is. This is a debug interface, which is intended for developers =
and
> experts. As these are hardware bits, which are immutable, it's completely
> sufficient to print out the raw values here and let the engineer decode i=
t, no?

The reason for the string decoding was to make debug output more friendly f=
or quick diagnosis during bring-up,
If it is not accepted, I will revise the patch to remove the extra string d=
ecoding and only output the raw values.

>=20
> > +static int aspeed_intc_probe(struct platform_device *pdev) {
> > +	struct aspeed_intc *intc;
> > +	struct resource *res;
> > +
> > +	intc =3D devm_kzalloc(&pdev->dev, sizeof(*intc), GFP_KERNEL);
> > +	if (!intc)
> > +		return -ENOMEM;
> > +	intc->dev =3D &pdev->dev;
>=20
> intc->dev is not used anywhere.

Will remove it.=20

>=20
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	intc->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(intc->base))
> > +		return PTR_ERR(intc->base);
> > +
> > +	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc0"=
))
> {
> > +		intc->show_routing =3D aspeed_intc0_show_routing;
> > +		intc->show_prot    =3D aspeed_intc0_show_prot;
> > +	} else if (of_device_is_compatible(pdev->dev.of_node,
> "aspeed,ast2700-intc1")) {
> > +		intc->show_routing =3D aspeed_intc1_show_routing;
> > +		intc->show_prot    =3D aspeed_intc1_show_prot;
> > +	} else {
> > +		intc->show_routing =3D NULL;
> > +		intc->show_prot =3D NULL;
>=20
> What's the point of creating the debugfs entry instead of bailing out?

Yes, will update to
return -ENODEV;
>=20
> > +	}
> > +
> > +	platform_set_drvdata(pdev, intc);
> > +
> > +	intc->dbg_root =3D debugfs_create_dir(dev_name(&pdev->dev), NULL);
>=20
> Why storing this? It's just used for setting up the debugfs entry, no?

I'll update the code to use a local variable, by following.

struct dentry *dbg_root;
dbg_root =3D debugfs_create_dir(dev_name(&pdev->dev), NULL);
if (dbg_root) {
    debugfs_create_file("routing", 0400, dbg_root, intc, &aspeed_intc_routi=
ng_fops);
    debugfs_create_file("protection", 0400, dbg_root, intc, &aspeed_intc_pr=
ot_fops);
}
>=20
> > +	if (intc->dbg_root) {
> > +		debugfs_create_file("routing", 0400, intc->dbg_root, intc,
> > +				    &aspeed_intc_routing_fops);
> > +		debugfs_create_file("protection", 0400, intc->dbg_root, intc,
> > +				    &aspeed_intc_prot_fops);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_intc_of_match[] =3D {
> > +	{ .compatible =3D "aspeed,ast2700-intc0", },
> > +	{ .compatible =3D "aspeed,ast2700-intc1", },
> > +	{},
> > +};
> > +
> > +static struct platform_driver aspeed_intc_driver =3D {
> > +	.probe  =3D aspeed_intc_probe,
> > +	.driver =3D {
> > +		.name =3D "ast2700-intc",
> > +		.of_match_table =3D aspeed_intc_of_match,
> > +	},
> > +};
> > +builtin_platform_driver(aspeed_intc_driver);
>=20
> Why has this to be builtin and not a module? It has zero dependencies on =
the
> existing code in this file, right?
> Just stick it into a seperate source file and make it modular with a sepe=
rate
> Kconfig switch. No point in carrying this code as built-in in multi-platf=
orm
> builds.
>=20
> This whole platform driver muck is just there to expose the routing and
> protection registers in debugfs even if debugfs is disabled. Seriously?
>=20
OK. I will do it in separate source c file and make it modular with Kconfig=
.
And also depends on DEBUG_FS
Thanks for guidance.


> It's completely disconnected from the interrupt delivery chain as far as =
the
> kernel is concerned, i.e. it does not provide a interrupt domain/chip. So=
 that
> interface dumps just some register values with a lot of effort and leaves=
 it to
> the user to decode which actual linux interrupt in the real intc-ic inter=
rupt
> domains is affected, right?
>=20
> I'm still failing to see the value of all of this. As the kernel does not=
 even
> modify these registers, you are basically implementing a dump facility fo=
r
> decoding what the firmware put into those registers, right?
>=20
> I don't have a strong opinion about it, but if it has a value, then all o=
f this can
> be done with way smaller code by just dumping the raw register values all=
 in
> one go. No need for two files and string encoding. That's what user space=
 is
> for.
>=20
Thanks, I will send a new version with a modular driver and a simplified de=
bugfs interface as you suggested.

> Something like the completely uncompiled below, which I cobbled together
> quickly for illustration. You get the idea.
>=20
> Thanks,
>=20
>         tglx
> ---
>=20
> #define INTC_TYPE_C0	0
> #define INTC_TYPE_C1	1
>=20
> struct aspeed_intc {
> 	void __iomem	*base;
> 	unsigned int	type;
> };
>=20
> const struct aspeed_intc_data {
> 	char		*name;
> 	unsigned int	groups;
> 	unsigned int	prot_offs;
> 	unsigned int	rout_offs;
> 	unsigned int	rout_gap;
> } aspeed_intc_data[2] =3D {
> 	{
> 		.name		=3D "INTC0",
> 		.groups		=3D 4,
> 		.prot_offs	=3D 0x40,
> 		.rout_offs	=3D 0x200,
> 		.rout_gap	=3D 0x100,
> 	},
> 	{
> 		.name		=3D "INTC1",
> 		.groups		=3D 6,
> 		.prot_offs	=3D 0x0,
> 		.rout_offs	=3D 0x80,
> 		.rout_gap	=3D 0x20,
> 	},
> };
>=20
> static int aspeed_intc_show(struct seq_file *m, void *unused) {
> 	struct aspeed_intc *intc =3D m->private;
> 	const struct aspeed_intc_data *d =3D &aspeed_intc_data[intc->type];
> 	void __iomem *base =3D intc->base;
>=20
> 	seq_printf(m, "%s\n", d->name)
> 	seq_printf(m, "P: 0x%08x\n", readl(base + d->prot_offs));
>=20
> 	base +=3D d->rout_offs;
> 	for (unsigned int i =3D 0; i < d->groups; i++, base +=3D 4) {
> 		seq_printf(m, "R%d: 0x%08x 0x%08x 0x%08x\n", i, readl(base),
> 			   readl(base + d->rout_gap), readl(base + 2 * d->rout_gap));
> 	}
> 	return 0;
> }
> DEFINE_SHOW_ATTRIBUTE(aspeed_intc);
>=20
> static int aspeed_intc_probe(struct platform_device *pdev) {
> 	struct aspeed_intc *intc;
> 	struct resource *res;
> 	struct dentry *dir;
>=20
> 	intc =3D devm_kzalloc(&pdev->dev, sizeof(*intc), GFP_KERNEL);
> 	if (!intc)
> 		return -ENOMEM;
>=20
> 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	intc->base =3D devm_ioremap_resource(&pdev->dev, res);
> 	if (IS_ERR(intc->base))
> 		return PTR_ERR(intc->base);
>=20
> 	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc0"))
> 		intc->type =3D INTC_TYPE_C0;
> 	else if (of_device_is_compatible(pdev->dev.of_node,
> "aspeed,ast2700-intc1"))
> 		intc->type =3D INTC_TYPE_C1;
> 	else
> 		return -ENOTSUPP;
>=20
> 	platform_set_drvdata(pdev, intc);
>=20
> 	dir =3D debugfs_create_dir(dev_name(&pdev->dev), NULL);
> 	debugfs_create_file("intc_regs", 0400, dir, intc, &aspeed_intc_fops);
> 	return 0;
> }
>=20
> static const struct of_device_id aspeed_intc_of_match[] =3D {
> 	{ .compatible	=3D "aspeed,ast2700-intc0", },
> 	{ .compatible	=3D "aspeed,ast2700-intc1", },
> 	{ },
> };
> MODULE_DEVICE_TABLE(of, aspeed_intc_of_match);
>=20
> static struct platform_driver aspeed_intc_driver =3D {
> 	.probe  =3D aspeed_intc_probe,
> 	.driver =3D {
> 		.name		=3D "ast2700-intc",
> 		.of_match_table	=3D aspeed_intc_of_match,
> 	},
> };
> module_platform_driver(aspeed_intc_driver);

