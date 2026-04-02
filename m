Return-Path: <linux-aspeed+bounces-3831-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF9BCC6B03
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Apr 2026 06:14:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWlv70F6z2ySk;
	Thu, 02 Apr 2026 17:14:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775110475;
	cv=pass; b=I3PydZHH1vrfQzhNT18p9uhApU3lEcD75KCI2lOf8wBJj2JBSXvomoV8j+42BbKtWv3/Rk0Xx2lAAI8EG6Z+jKDCFmAQBgGELM46GplSH/StZ3eCGPWY9VOB+DPMCdlPIy7r76i3C45VChMsbRO6/qSYY8cSg42YQFR7genwT7T7cWM2P37Kicsy6SYW6oslAqHdOUiIfHpWgVB9yuKeXVWqFAKz+pFUCDeeftNFRblxUbcwbp3Ho4opi2tkGO7PhewTIca3n+aGg+e2Pl/LYgXj0e4xSYAwjOIfZMOQOZ2AnQ4Bzj5aj48yFenlncVpgqkqJWhb1A8WbnCmb3gxlg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775110475; c=relaxed/relaxed;
	bh=tx0kyjNelN7KDGtYZN952VeVRBH7Z5i6av0tphVGyYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEJGse1tl3kTRrkp2b5PaPLBABWD2vSedj9rAd01k2koAEtCGDrY1BKTd6DQMB7tklnWi33QQgGdmXp5J+zmG9vCfUlu255wss5pgxGlOqcSBYV2BBo/DB4LdvZxiLfV9CPiiudlClIarQEgvtORjvIxgyQN3KqdFuuNrjxY9KqsXAQo0BhT2eV8Njm+ptdqArWltgi5PVqXRb2C43+G5eTA6gTAWo/DM0KYu14j1Egde0Y73GDiKc9p98vZtdNBX0wwbv2Zd9aG1RU05puOfRX2BYnnMMl8WgmqkAbplkd+wuWDdWXBPClb5wrkiLLD0kabPmYZoH35VVzmggON/g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oiqKI1fV; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oiqKI1fV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWls3FBgz2xm5;
	Thu, 02 Apr 2026 17:14:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVOZzbx6RI9X3YadiDPtzxauST6ybT2bOJS+2/vc0P+s27JgoyR/sJU0t0EIv/yjSMzW5nAfJ8GwgxgFM/l3xkIQtnc/hShzpz8yfhSmRwz+2gMPwvA1ohD60t4Bq3yVg8rtPMj1HU/lm4F0MKN9wJBQQP6IIjq25jvS92u1Qcp27m57IZwZy2M+izLz06ARao+XusCw0RRopzb/EhRhj/kxvndpj7/A0zvA9ozXA8S62JQaKDZsMQgskSwY1n6ISVC2ZKftkFbFF21+aPXqGxTCaZ0zF/XJ3L6kKCUF5h9c57R+tJxiZtS3Hbq9A8eGAYORCesvLfqG52fpJ7mMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx0kyjNelN7KDGtYZN952VeVRBH7Z5i6av0tphVGyYc=;
 b=DQWnp5Y1ghod0zgpYWOY2n+QA1fd/QCz1/AsyrWCxgzRevtFXvIdToV8C7oOSnZuC/8q7OBDsGtNzapEvAyZQwx1uQHFGd86XDcRCdqtZYJmyeTld0aADQdeZGs6767dxAFVuzU1xY3Se9XCnTxNySvX4hF3JUM++tA5W8EbFhTnROuoPhKoAt+wL1DRFnTNg5j6slcmCcQuaq1o7oYPNm9GtfamoqlaTBFrYT0tfyI4zaA3ldiajVU1tJH8LO6sIdMJj+nyJbVfHM3HsCqsJ5j1nfjTs5MjPceYXJTYRXECYHdLPJaA5HROKOGPkefqwu7LOEfOkGLi0ERs2wQGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx0kyjNelN7KDGtYZN952VeVRBH7Z5i6av0tphVGyYc=;
 b=oiqKI1fVmJXnbnW+rm4edWQ0GsZFDiXWmBBk2lMqzQ8vevqZ5XUKGW6YS7RjsPfUMPWTxqefbSfJUK9zxEiYn6ic/qU9CG5KoQG32I/3/RL/iHLsC60jlX9T6Bd6cALP2lUyXgRFfzdeK0VMMoeGBx3LODHVwiOF97R7+5nSzG4qskt6j5MbPciSB8XWKTymah/LkEZW5lS0LO3LMc7CFG83l52E7+hi4bUR9euikA9fjb/4vkTliXEQBFNQ0OJYKki4gj3gwN+C8tb3lUjG0zI8+MAmkQyqRWNxP3k/fFugPTvp8aJY79UnfuDJ7LzrDREY4l8ekTnluDKSj/30AQ==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYPPR06MB8080.apcprd06.prod.outlook.com (2603:1096:405:315::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 06:14:07 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%4]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 06:14:06 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Thread-Topic: [PATCH v5 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Thread-Index: AQHcwOBzpo2LGWLrJkiaaIjatlvHtrXJwg2AgAGLixk=
Date: Thu, 2 Apr 2026 06:14:06 +0000
Message-ID:
 <OSQPR06MB725204B2FAE543A71AEA52C38B51A@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260331-upstream_pinctrl-v5-0-8994f59ff367@aspeedtech.com>
 <20260331-upstream_pinctrl-v5-2-8994f59ff367@aspeedtech.com>
 <20260401-adept-zebra-of-bloom-5bb68b@quoll>
In-Reply-To: <20260401-adept-zebra-of-bloom-5bb68b@quoll>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYPPR06MB8080:EE_
x-ms-office365-filtering-correlation-id: 9f24fb88-5106-40fb-7429-08de907f0bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 P3p6BHZmcVfP2Hx5G6v/xdZy/1Os2xABbiUQDzFYdNQhjflVrZPmp9SVFbrnW2Unm0OrHj3eMHXnvJT84aCd2HoY6CW4g+w071SyfTkKolva4lw+84faxgUX9SGsZ1I0H1YnCPKHUeDVaz9KnzyzR2rBF/SnSmXoZbLqCkB9h5mx7e7HcXZoqp0fLxTPixckWBDxTw6WLym/oz7gkja3taH11ISvrreuVl4v9ZSqs20uLvnJzc6SQuNJ+8LMGPAHT15e7zZqfYVliNZuPWhXqLpdcu1YCuGLH5Bt5TvAmUtMJGvZkpO0C9mlRWptnlK6EEKeDBR6C9+19CNyp2JwQY3F4V8BUWl0I7SQG9EdROFqHu1rEcj8n3yr56F0oASyAhkDI+3VBkJhD1vKbCf3gfqhrwz5D7MmZzZH1c5prY6fmv8/5p74x15MU09RvKr40BOoUmyieS0dgXIS+qv+2Hk+pa/900YCykfBel6Juu32I6kGIVSJxMluoYOI8U8wDJswZTu9hVldR8ZPPXBlOqMqbg6xpsMiqkwklla+PywE46BFlzW6Idh1yx4u4WKbs4lhaP13inGTnIPSMJREN9v0dqIaXAImR3Vh+cMfrgLWSlnU4tUwCkMftMI7ifvl8pot6Xllb1S2d/aePL5e3ky6pKOHfLkXIKilX/wGjcujKdntOfmVz14ZjAGrfmIaJ9YaTk1qWnz5F5LkZPHzGxXAT+YRRfRKqrRhy1spjG5dL+VP5JYCzus/+U/Cp3rfHoIr0e8M9+wRIl1ive+mgoCz8So4aLlmu7QFo1YShKc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0+CtT/eJYnsADx5/M5I2QgYuBHIYOOm47I8lr0o4M6XShqgU7Sd1TmJFXN?=
 =?iso-8859-1?Q?CVz/MEgtjNk8SLGzQGcUJKBBdYBJ3vmc8aFnT15+P7wFpT4rUUREGsrNqu?=
 =?iso-8859-1?Q?Tzp5AZ0wYGx6u0a+GTWRSj4TDKZB6OtlgNmmEnW4lcVUBkftdj8RbZwKLQ?=
 =?iso-8859-1?Q?+pYgiLXlZ2DfscevB7hNaqQ6W9femT26O3veuoFQFL2Cqe3nlDYx/3ZDuf?=
 =?iso-8859-1?Q?n6iVuqd1YeWNunLNVDfnvarMlB4DSoZqaqFFwrnHUSlw5FSR4U2sspnadG?=
 =?iso-8859-1?Q?F5YjOQeAcXCMj/iZMT94YTo7/yI+wG8P2fuvec7xUpQE1eKrKEI3J0DAyf?=
 =?iso-8859-1?Q?ZCE9G76TtfSlOTljqDSu4bPDPTQTiNCtkYwRAjY181kLn3ToMlxt43UnSG?=
 =?iso-8859-1?Q?+m0NAFzGhnepUk7uypdeDt0SnqySEbhDMvFGG0DvUBtqzHwe9LtICQUDt/?=
 =?iso-8859-1?Q?usaVfkLNvyStbidZPu1x82JrIog9GJVLVRZggbTs/x1ukGiCKKJ7uEbbs7?=
 =?iso-8859-1?Q?ezn7JVbs4N7ZlzChB0kxfbBwZd2tl5yr5Y+t4lBTIckiRNIiWyeGn1h+rg?=
 =?iso-8859-1?Q?1Uw/ydWdJYWAEKDP4ILz8LVxN1XxIjFpAsSaBChfqoQKCu39g0O/qjQAjk?=
 =?iso-8859-1?Q?oqeE89Q7JNF4GXLhvF4ofdxnVGuw0lunwVKnItsEZx0b7Xo8J7x9t3Mi7s?=
 =?iso-8859-1?Q?oT1vr0OTZoMz4Eu1hUaoGkapGX/i3VMvc1u01upCaRBoDuoN/sPj912ZYp?=
 =?iso-8859-1?Q?fWcSYT/eHIFcHlpFk72fsYLoJmWs3c9aI6sdlJdoE6fTH4BUuo096SH+be?=
 =?iso-8859-1?Q?loaaKSNkiZ9orICDuN6pZpUZjJWAZ3JC5QhUHwnbSnljDK+Kb76Rao1dTw?=
 =?iso-8859-1?Q?+U9V8Mdlucp4PWHACXhXlNVxBp2q6Qn+5AIOZTfw+ZK5G+jRsFC5yq0Iyp?=
 =?iso-8859-1?Q?uMPD/xWxcH4KgINTR2xV4W3e8FoJvlKW8qCkPph4qC/0euMBcW2FzMyQ1X?=
 =?iso-8859-1?Q?fCiOigorRbt6RYB758IMjUD18k2tf9SrDCPDE0PKiTxttjwkKiEYABvhyr?=
 =?iso-8859-1?Q?hzF45A78ucV+1XuxJtzLVAEZ87l17TMg8IUUsOEtBSNBVKgyk8d7FHKL9X?=
 =?iso-8859-1?Q?e8Cq0dRqvAz1Ab5f0NQuR98QCq5YDFZkqcMI/nLziD8C5L5NdOeYJXSGIu?=
 =?iso-8859-1?Q?KxnQ2Tn7esCgH6rwd6pfsYAw4YBmfKMFK8c1/XHs8eYOZFVWjNfIaWAidf?=
 =?iso-8859-1?Q?nS410bBMDnmhNSp8HtrRfRH0FJXPK2WeXg3TJNberUAMAhcCCZcgo6fPF7?=
 =?iso-8859-1?Q?qdcFkZXlNJRg9ewB5HQDcPWRCJKdYigrL5B4/tI+PtcH+ixTRCeZLLgpc5?=
 =?iso-8859-1?Q?IM9Nw3Ngb2lQ/u+G2z0eQq6qW1OOHfakSxL4+N0Emk5GV8ofJ4K9q6rS7o?=
 =?iso-8859-1?Q?fyFaIOQKzRSV0s4H2Sa+sZle0gf35pXTk/uG8DjwuJldkWnQVdp0FAhJjU?=
 =?iso-8859-1?Q?TT50C2fa7BNtnDFR4Vu/lAqo0uVpBNzTHS472FgVNKG/uK6K6wLiwNkyzT?=
 =?iso-8859-1?Q?xwygRv+6t/e/DIHqroFE1h7uPD4Msjw25hDRJYJWhCbYqOgsmZCzk2NSZz?=
 =?iso-8859-1?Q?cIGHCSATLfzNsskgZS6U3AZVmIjuIyheGqTE8xfdo5h9g0WmBRLxNyzCtS?=
 =?iso-8859-1?Q?0QaQSmU/nxLbCHBzQK4XMLucj7aUhIg68mKAxinDrotvg41Hc1Ev3RNUUV?=
 =?iso-8859-1?Q?vHLTZzYu4uuCnHZX1J0c5uWHOoKDbJBHJn5SQE/DRiBpxpDaazSJU0oKyM?=
 =?iso-8859-1?Q?OZIObV0Ikg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f24fb88-5106-40fb-7429-08de907f0bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 06:14:06.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSmbIow9bL8eDe+NVklZZKsbeoOoP78enCkeT2ihUDYRXNgpSPCbnFJk1Zw+ib8cOzLKEadKoCfjohcqMx9G6RFBMbBYfZUwcoMYTh32jt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8080

> > AST2700 consists of two interconnected SoC instances, each with its own=
=0A=
> > System Control Unit (SCU). The SCU0 provides pin control, interrupt=0A=
> > controllers, clocks, resets, and address-space mappings for the=0A=
> > Secondary and Tertiary Service Processors (SSP and TSP).=0A=
> >=0A=
> > Describe the SSP/TSP address mappings using the standard=0A=
> > memory-region and memory-region-names properties.=0A=
> >=0A=
> > Disallow legacy child nodes that are not present on AST2700, including=
=0A=
> > p2a-control and smp-memram. The latter is unnecessary as software can=
=0A=
> > access the scratch registers via the SCU syscon.=0A=
> >=0A=
> > Also allow the AST2700 SoC0 pin controller to be described as a child=
=0A=
> > node of the SCU0, and add an example illustrating the SCU0 layout,=0A=
> > including reserved-memory, interrupt controllers, and pinctrl.=0A=
> >=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > ---=0A=
> >  .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 117 +++++++++++++=
++++++++=0A=
> >  1 file changed, 117 insertions(+)=0A=
> >=0A=
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.y=
aml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml=0A=
> > index a87f31fce019..86d51389689c 100644=0A=
> > --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml=0A=
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml=0A=
> > @@ -46,6 +46,9 @@ properties:=0A=
> >    '#reset-cells':=0A=
> >      const: 1=0A=
> >=0A=
> > +  memory-region: true=0A=
> > +  memory-region-names: true=0A=
=0A=
> Missing constraints. From where did you take such syntax (so I can fix=0A=
> it)?=0A=
=0A=
The intention was to constrain these properties conditionally for=0A=
AST2700 SCU0 as done further down in the patch.=0A=
=0A=
I can update the binding so that memory-region and memory-region-names=0A=
have baseline constraints (e.g. minItems and maxItems), and then refine the=
m in the=0A=
conditional branches for AST2700SCU0, AST2700SCU1 and others=0A=
=0A=
  memory-region:=0A=
    minItems: 2=0A=
    maxItems: 3=0A=
  memory-region-names:=0A=
    minItems: 2=0A=
    maxItems: 3=0A=
=0A=
Best regards,=0A=
Billy Tsai=0A=

