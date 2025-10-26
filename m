Return-Path: <linux-aspeed+bounces-2612-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6BACCF9EA
	for <linux-aspeed@archiver.kernel.org>; Sun, 26 Oct 2025 03:57:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cvNBp3qgTz306d;
	Sun, 26 Oct 2025 14:57:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761451058;
	cv=pass; b=JcDHfMrtCA0wfsPwc31AbVlug3DeABXQir+PpV8o36RQp+jp3osecsFuRMx0qK+HbW6Oms07rdOXre5Xuz1U8UTSXcJvyoCfrkVMWTjUP5JWVnLjsuyOSAHpSTLmU3jqrUYfL8eCn1SscZqiBbooxeKR7aK9xvGuNVjf1akGzuBAkSUno9ihADQ+XwxQ7aWJrT5Dug4rBHnf12wHqK9a7PdWU1/YrC3Qt4ZWqJdVJQ+Cv9cfWTA9LmT+P5xrq+koDUv4y8qxlSMgjTcwhrl4OaHE+qUQd6gfWZYF9L/KdeUXObn5fKd/byYGNpdN0XZ9g4ObvOUgK3sEAJThKZaAVw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761451058; c=relaxed/relaxed;
	bh=PVlUsR6MkagZQZAcoxrsw831QkGncuv7sR4E7vpVVW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0w0S78isD63NvW1T0uuENgoNbhNbIY9556vA5TbmeMWqDUAcssITYMNAaLK2KjR0ugEt7DJhm21josQT/UL2K1MUAn92sEcPJrWk/jkCKPTAzbOz7EtpOGN8yqhvST98ifEp9x88GpD0w8XbN5XU8fl9am2GhvtnjjUKs1y+6IDeaGkdUTQt/oFvatw4F4YPqbw2vZZAl69wHz2v5bSrhY1Zq4yaZEhXgRRbE7Z32Le4njNsY6yFAcKqEbOh9VuZh9Nryp3fAhUddFNHjokpRn1ASrcg4NCWTd2d5UJpNmp6xCMCu7lRyJa5Ru7NpGdAu5RUGdkBQVtDff6SNYrCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=h0rpnEWS; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=h0rpnEWS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cvNBm1vP2z2yjx
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Oct 2025 14:57:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5PUhQC+J1YtSUJFee07BULo0tVx3Psc2DfqcRTtaA3pCnx4JqixHSy980G4Tu+vT41eZ8SP425sO27hExn0RXseBfdfTGJidLTJnIB1/4No8+9cqQdu6tUUtv7mOYB/qNBn7ZyksQn18XkwAORzomgXuB3sCfEriJgP94/D/I/71aXDf6oHBm5bfq3zVWZG76AXOFys+b01AMSN5y8hhBxcTWIpYbDyWm5hUj3f9vsQmuBiqPK1b1InYHzxhmqKhELOI+ozxdnnU/fv4GXjLk0tTz214ytlHRANwvsPyLezbtLfxeELfM3J4rLNC5BydT+ea0Pw7Om4vMoCs5UUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVlUsR6MkagZQZAcoxrsw831QkGncuv7sR4E7vpVVW0=;
 b=VG9dDGx055aQOCmR4Yjw6cKSrly4piViG5lIEtdqpSFoXESacji/ZU8rsI1wOYdheyg2mFcCjmr4txTI54YQ5owDZOZDG1q0EujIS5a9TT/BINAdyCQ4GNQE6ioy2m/0e7d0EvFkWDJrSV65mfJbgYkMFETzGDt2EsQqBudcTwxHhOGKFt7rw9lSqSYEG9LR3nDOA6hze5WSO+pDUam2OBqgzgOHBfBhFLUbUfnXkG78vWNzsBGjG3PNsjbdeLhTqp3Y0BBxGjeKLN6GAnCCgIRUdpnZ0vhkw7YhVl/W7bfrvZA/j0+wEF75Og6FZLveuAAmUPBaNQBOD3OscPD4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVlUsR6MkagZQZAcoxrsw831QkGncuv7sR4E7vpVVW0=;
 b=h0rpnEWSXD+6gWdWx69vzVv/kj4PrqtClcY3TuzXM1/qorZlzBEcHS41Xjj8qiUOeg2JqGN7DPDWJg+9riKkuE1X4NesmrjgVT8pVqpkLEi1+rfqoWDPTVPp1KysTCbkV7q0KkNHf++/VKwhdpQ1WQ/Apwr6M9seClu/Kk2YCZa4FE5sN7bHOi6b+jdMs+wn3he3Il/GJkgWlOLy76TYGBcKnBY4yheJF/kikXvHBosoTVJUc3GEgGLhWPeNdiR2UxdjFGjeHPsyEdqnzVF1vvHcNZlVrzqRb0Zq8M/eLeGeO2emQ6E1cA5f54zAJuJIpmU7IP/ZirQuNuKCNXYAcg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYPPR06MB8104.apcprd06.prod.outlook.com (2603:1096:405:313::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sun, 26 Oct
 2025 03:57:07 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Sun, 26 Oct 2025
 03:57:06 +0000
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
Thread-Index: AQHcQyDQYO/3l6vgwk2QRDf7VCK0I7TOL4uAgAEN90CAArNoAIAB3pOg
Date: Sun, 26 Oct 2025 03:57:06 +0000
Message-ID:
 <TY2PPF5CB9A1BE6CDE8AF88A638BEC06B41F2FFA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
 <20251022135101.GA3349934-robh@kernel.org>
 <TY2PPF5CB9A1BE674594566C13B8D8B2984F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20251024231154.GA2962687-robh@kernel.org>
In-Reply-To: <20251024231154.GA2962687-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYPPR06MB8104:EE_
x-ms-office365-filtering-correlation-id: b160912d-66b3-415f-4aaf-08de1443baee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/AGcO45365STq4XMbmugr6druN4IPpwgW64nRshfW0gAmKYcyGrVcF88O0o/?=
 =?us-ascii?Q?oXX2nx8rAAl9fpRwA3EU67R1iB+o4hcgymHtLvCMlP7/8GCl1FjyTf025UPv?=
 =?us-ascii?Q?NKKUX74esE6ZMARyUP7/CCv1eoCzE1xO0VVUXCWn5eLhgYeOvEzher8iE9U4?=
 =?us-ascii?Q?9WcQyqan4cKyBbxI3TIE1UtS/gjhlhMA89jFz++o+qtJp/XZVmJn5qt+s8Ce?=
 =?us-ascii?Q?IJ9L8W4ABEzYhhLU427udzmL5hZEBO/tYLgnhLRezQOPQCTTyNy4q2bYYQ5l?=
 =?us-ascii?Q?Cs73+8/zs0cuZlfKyvACjZsaO81ekr+X51bkx/7LgJusaL3fby6IW4QCZKgk?=
 =?us-ascii?Q?rhJKyQxkQt15hgcfVacsv8+msbZMXnhmTSnbyla33hTzgrJY4NZ07IDwDFLt?=
 =?us-ascii?Q?6ojnRlb1+Rro1xZUZDuiHO8UjCJzfz6TUWSHS3yePEV3nbPUkycrobmvuPxk?=
 =?us-ascii?Q?IljQyCGwK+lqcRLY7q/0HemLtvuWyXDqMK325bUXgofIdfOAZbsfFufaGXSD?=
 =?us-ascii?Q?yjr3Uxcufd2JpsSkwP13i0loc7jY2fQN3C4HaxPGnSPDeP6CAHSHhbxZaE5X?=
 =?us-ascii?Q?4El60R/cMaozVmblfe1Y/wLSoFQyeICWenGFUwGW2AiJSN+AaNhrt4Ogi9rb?=
 =?us-ascii?Q?hpa9Plp0hV4ZJ+MiaYuL4uQtRHofXcrWmMbTdOOUx9OTV3lbd98DG+0srQWr?=
 =?us-ascii?Q?Dtow9GcQ/+sbyDGUDWFO/8+WmFguqieEI/W5tJtVmSOZeMeHltT9/YTFkuCa?=
 =?us-ascii?Q?tLZwGr077D8LIP1LtmE/S2S0+3AjRtrR/aSX+VWhXr6g3K/9n2H7fuC4PRvJ?=
 =?us-ascii?Q?JkrJqaxDzZ9Ibkxc19blSaxgR7dYxHTkuJGnSPsQjePm9yIWe+u0CHHfEryx?=
 =?us-ascii?Q?91ecF9T2ZyyVSDFquNykE8wIsIEmSlTORY/dhjnjg0Z/b3zRiH1EWcvRRydE?=
 =?us-ascii?Q?WG8NLeOZ0qHe0JCCN8a1zgRxjcElJJNxqxB0dlwKDb1u1azWs1xR9iYc24np?=
 =?us-ascii?Q?5vSAGBqo+VlJgGETbH7BJcYhWqmXGpIK5op7D6Qjj/bWpnWlqoTRTovuf7v3?=
 =?us-ascii?Q?wI/5hc0wdcbIPaHF5a3bPwXW/WYWk+6tK9QI0XHAWgSI+MOcvGi/uy/SOTMi?=
 =?us-ascii?Q?pjDRNBHs7kz7mKkZCz/CDmCqk1YzIUS5nu4RS+WJI0SwpIWCTE/ywJ6ppi6l?=
 =?us-ascii?Q?GsW6diPy763xPzQvmptM5uxbGTzADj6xwKrO4gPFlC5lYGylMOKf7Mld+jEZ?=
 =?us-ascii?Q?QRv5n1ecWzVpOwpgQmHLWf0HIVz2zAtJ8znX1gOPEwaUgCIDLWxxIS1YPIju?=
 =?us-ascii?Q?vguWF98x1IG9tJ3YTpnbG1fIHFQdqAEu9dRQ02ryOtVEGQsZdgVmpfs19zZ0?=
 =?us-ascii?Q?zKOQowVXy+1S+BnLP8wWfcgSo0UtzHtFLnwaKFngnCQMyqex/V7saiSiu06b?=
 =?us-ascii?Q?FCXl9JdpTA19V3jRxP6FTwF0lnolE0dlFcMypNwMrFxmcL+1BQJuS230KAbs?=
 =?us-ascii?Q?nq4QOwk4GlmOKihfjXSYHS7ahcZdtKXqZ04k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vhIIE4pWlY2+p94Ah8DUNF73ab7yqWUbqo6W5CqukCs0chERz5/pdoCSXWGp?=
 =?us-ascii?Q?XDxqfzskDARuqzo91ZCxWKOyND+AOZhTWp7IrCyMRT/c2ODnpEy0MLjAcHYK?=
 =?us-ascii?Q?o1JU/n4XZLRn3VbGx3A3x0sYl3Ltoy3KE5nn2bUHzcLe4HeLj+wt5h19Ofwu?=
 =?us-ascii?Q?BhkIOqMj4fMA3IQhkbwyMtO/1OIAFf14NOmwJkRSNfLAYEayReDwS70gbj/G?=
 =?us-ascii?Q?/rDZa5XdMiU5PQs65fvs8Hf7coJVnlYDsL+EVZIFF+EKis8wiv2P97/HmtgP?=
 =?us-ascii?Q?y/ANiVlMkrHGsM/IN656CjdllzeJdVpG5sGC6XpynL2vTvR5b/muEvnfnduf?=
 =?us-ascii?Q?h9Kf8/ltIMflbcF5QgSP7KPM2il0iIvEbkw1bVnV+e4sv2fCyMvQEvPRgECc?=
 =?us-ascii?Q?H4LsbgymtykleJZIVjkcRqUr/uqR+70N0ctXw9L80/tm4RZB3SsTyBI0AxbN?=
 =?us-ascii?Q?HK0QmDlL7rLCKOtse1SUdfkN/8c0WTkp2tvqFXRbm7GTu0gdXahi8KPDbfnx?=
 =?us-ascii?Q?UYBzREwuqzs+n0Ywm/h4l2sx1hPA0SBK4L/CTa50QX4smDc6aRj6QwAhqACk?=
 =?us-ascii?Q?2iEZ+QIWIuwAnFM4fl71gpkkgUigxJHLjiGkw4LWa83FuvZnengDfNox1Szt?=
 =?us-ascii?Q?lxHliJASnxzd/tzR34QD4okUDGiuKDqL1f4UPfMl/28yHFr5Ghak3XCFHNmB?=
 =?us-ascii?Q?+WApGCoMNW7IKXPD2jK1E8z8YLjxAy5uend5S1DgWalSTd5DvTgpesB/Ty6i?=
 =?us-ascii?Q?vXZWFo9QpyWNJkDQFS3SCHcFJPf1UK57zh/l5zg8zQaHUCVhkjuMwocw5VUc?=
 =?us-ascii?Q?yD6Y8bwU/4UTa3YVVvByUy6XfCbqgUCHTkeSS/RbKvAZ5bmSClWdALtu3yJk?=
 =?us-ascii?Q?H6sTA1dCbPR/ds7OBaEI8JHolXFghUqRE2ATQ+JIc1aMirPJINjfLCuhYteq?=
 =?us-ascii?Q?Z/0DLj/hnU7d6lv/UbWyXEDaEXVa1A3kwLFx60mRdDaJib84Wio3RBT7RPLP?=
 =?us-ascii?Q?RAcZeKIAKYe/T0AOuZ3u9kYOPJ0IvHgCGG0QeD+1IXTRl4gyIMqCAi1nc08Q?=
 =?us-ascii?Q?1RyfRrLIB9/f1aGTaRg28UeoAHUl3wI179yJ/KYtRNSmUQCWk32E5qP9dePR?=
 =?us-ascii?Q?uahzVov+PBXmLH6BezDv4VIWX56O93SOM+yTNFM0ybBnqxokJVnrNhPFeFC5?=
 =?us-ascii?Q?66JYVIsZKMScKrkl/sC3n1NOWopN5oqwMK7s1M0tJQzwQfN6ca79C6CU5wmn?=
 =?us-ascii?Q?b7Nntu9JH7QnjACDySFoo0W+at7dCFZxofUYcOZc0UtKSqSKQE1qUnqLH18b?=
 =?us-ascii?Q?yl8PlcqlQFQatnLEiQQ88Brt/7urtjecWhr7zeYl6bc7zgfyNqCHRjNOLe3m?=
 =?us-ascii?Q?wcZAlkrLz2Wnq4SYoUcH5LkqdbEECshI2Ozgi0uNXs5RMHPIxealSl5wNNVP?=
 =?us-ascii?Q?Sf5KWcwLIjWqAqKneodH1LLzpunVFPthzGn3e8hCOwqhrAxawVfFo2EEFk+E?=
 =?us-ascii?Q?he0nURGwEWukYKRVAtm3RRQqSQQOhT8F46YrA3qSkJAwgTW22p8gf46tHMMm?=
 =?us-ascii?Q?Mnu1ZraDS5a19IDMtLTJgeyYHumd3jywKg9uA2eZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b160912d-66b3-415f-4aaf-08de1443baee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2025 03:57:06.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNhFfXBxnynLFE2GGZ8mzUSUvNp7IhuT8Gbxl45wm55bxheDmQPmZO6TqLaecNT3UZ8e4E+SCgDrvCHbXRrXyeEx4QaGSKiNXN7z5GD71V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8104

> Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: aspeed,ast=
2700:
> Add support for INTC hierarchy
>=20
> On Thu, Oct 23, 2025 at 06:57:01AM +0000, Ryan Chen wrote:
> > Hello Rob.
> > 	Thank you for your detailed review and comments.
> >
> > > Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller:
> aspeed,ast2700:
> > > Add support for INTC hierarchy
> > >
> > > On Wed, Oct 22, 2025 at 02:55:05PM +0800, Ryan Chen wrote:
> > > > AST2700 contains two-level interrupt controllers (INTC0 and
> > > > INTC1), each with its own register space and handling different
> > > > sets of peripherals.
> > >
> > > This is a mess!
> > >
> > > How does this relate to the existing "aspeed,ast2700-intc-ic"? Its
> > > schema has a block diagram of connections which I can understand. Thi=
s
> does not.
> > >
> > > The use of child nodes here is questionable. A variable number of
> > > interrupt banks is not a reason to have child nodes. I'm only
> > > guessing that's what's happening here because you haven't explained i=
t.
> >
> > Let me clarify the hardware structure and the purpose of these bindings=
.
> >
> > The AST2700 SoC includes two top-level interrupt controller modules,
> > INTC0 and INTC1. (aspeed,ast2700-intc0, aspeed,ast2700-intc1) Each of
> > them provides routing selection and register protection features.
> > Within each INTCx block, there are multiple sub-blocks called intc-ic,
> > each handling multi-interrupt sources.
> > ("aspeed,ast2700-intc0-ic", "aspeed,ast2700-intc1-ic")
> >
> > Cascading occurs between the child banks:
> > Level 1 : intc0-ic have multi-interrupts connect to GIC (root) Level 2
> > : multi Intc1-ic# connect to intc0-ic The parent intc0/1 nodes expose
> > register regions for routing and protection control, serving as
> > containers for their intc-ic children.
>=20
> Being a 2nd vs. 3rd level interrupt controller is not a reason for differ=
ent
> compatibles. The programming model is obviously the same for both as you
> essentially have 0 driver changes. Having N banks of 32 interrupts vs. 1 =
bank of
> 32 interrupts is not a reason to have multiple intcN-ic nodes. That is a =
very
> common difference between instances of the same interrupt controller such=
 as
> the GIC.
>=20
> What you need to do is simply extend your driver to support N banks of
> 32 interrupts. That's what almost every other irqchip driver with more th=
an 32
> interrupts does. If you are lucky, then the offset to each bank's registe=
rs is just
> hwirq/32 * <bank stride> and the number of banks can be calculated from t=
he
> length of 'reg'. If you are not lucky, then you could put 1 'reg' entry f=
or each
> bank.
>=20
> AFAICT, the existing binding in aspeed,ast2700-intc.yaml should work for =
you.
>=20
> >
> > The following simplified diagram shows the hierarchy:
> >
> >
> >                                  +----------+       +----------+
> >                                  |  intc0   |       |  intc1   |
> > - - - - - - - - - - - - - - - - -+---- -----+- -  - +------ - -+
> >   +-----------------------+      |          |       |          |
> >   | +-------+ +---------+ |      |          |       |          |
> >   | |       | |         | |      |          |       |          |
> >   | |  PSP  +-+ GIC     | |      |          |       |          |
> >   | |       | |         | |      |          |       |          |
> >   | +-------+ |         | |      |          |       |          |
> >   |           |         | |      +----------+       |          |
> >   |           | 192~201 <-|------+          <-------+ intc1-ic |
> >   |           +---------+ |      |          |       |          |
> >   +-----------------------+      | intc0-ic <-------+ intc1-ic |
> >                                  |          |       |
> |
> >                                  | 			<-------+ intc1-ic |
> >                                  +----------+		  .....
>=20
> You already match on intc0 and handle 32 interrupts. Now you are adding
> intc0-ic to match on and handling the same 32 interrupts?

Thank your guidance, understood your point. the currently is met requiremen=
t.
For currently aspeed,ast2700-intc.yaml I still need update following.
#1. Interrupts:
	- maxItems: 6
    + minItems: 1
    + maxItems: 10

The 1 level request multi-interrupt to root GIC, the max is 10.
2nd level only request 1 to level 1 intc-ic.=20
in level 1: will be need 10, 2nd level only need 1.
=09
Level1 :=20
        intc0_11: interrupt-controller@12101b00 {
            compatible =3D "aspeed,ast2700-intc-ic";
            reg =3D <0x0 0x12101b00 0x0 0x10>;
            #interrupt-cells =3D <1>;
            interrupt-controller;
            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
                    <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
        };

Level 2:
     intc1_0: interrupt-controller@14c18100 {
            compatible =3D "aspeed,ast2700-intc-ic";
            reg =3D <0x0 0x14c18100 0x0 0x10>;
            #interrupt-cells =3D <1>;
            interrupt-controller;
            interrupts-extended =3D <&intc0_11 0>;
        };

#2. '#interrupt-cells':
    -const: 2=20
    +const: 1
Due to the driver irq-aspeed-intc.c not support any trigger type.=20


>=20
> Rob

