Return-Path: <linux-aspeed+bounces-4972-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A2EC79F8C
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 05:37:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfqMF4DQHz2ybK;
	Wed, 09 Sep 2026 15:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788932249;
	cv=pass; b=l/paEGc/vgGyHuz9U3ycrXUSF7BPemyEB27vlCrS81/dNsGQdvRkNocRaX1m22uMjjyXxmpdynARLjbKbeWremaijGkVWsDIoo28/yzzSewIkwI/hSl4+9xkfXyGC0LY9Q+RSL00NbXqkh49eZ4ERiA6sGDN0/EmlFfitI8ckZARnOCvkZ9ug9EUzqAzfaI4HoZGUcJLY2IUBkwOsz9QSXCA+qN/cvgDksb9sJc/CG9EGfi2p5ABjAYdb2VMPU8HdyGVLwy2sd7o/QKCo/pTAgLNEMKVEklN2SGUEvgWzxK/m0Sh5XcKUaSHgU/GPfILV+/xDM3YuxcRQmeTjUCJGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788932249; c=relaxed/relaxed;
	bh=lU3ZxqEQMDQrjdTMLFE3NOxhhGEWhoCeMfOMeY2FNrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cV20Q5RjJk4EL53GM6aOm2GBJ4OOQYACD3EydGnYUdGBShANHdwUlCsv1vOGVyDm+J6JB8ABdztoWcCKnjhGpIg2vH004ZXUJyvA+Jvqz3SEYmA8Cz6dcr/S8WRFjMgscUs7zr7cy5LO/H0gQwm0q5fgo1bxfNCfyzS+bKCwFJts+Mrd61UCDO//71f6DmG0VWS3YcF4R3ypbW8Tv2U3IzXYERf4J0FWN9aNtO+cgAEv91i1sR4eYwPlxEM6yIb4asXY9wX6LCTRyKRp9sz7yTwp0W+xy5t24MkpxRkvfdUUssI+HeqmUih+e1wCSvfXQkz7/FT5XNeQ6EbYyPTubQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lXUCOP6d; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lXUCOP6d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfqMD6WB3z2y8c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 15:37:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkcaw1keNTNcoL/cGQFeGCAHR9RzYeMLtV5EiCiZzqNSrm5msz7veWWMG34lwj483qSofB8Q3MgIBwGfO5KJ2C3uTg32wXv1u3deOjgjHdrX0jyt0wC2SrMe7Cj44MH/xAYdmgvOPjKkxQsgu0uR/21uQ3yI6SSK4Hu5KjxN0AdxyhB86sh0gDtdCsD1KH42he4K0lusqNNYnoPlXHpyEizv2KvcfusuCaMNdweA05TGXoot0QSVbNqUt1Y2wNJVVdZ6Q/CVn00fSl25au1PKeSBvkyXEqUaLlg59tgGOJRPrlaBSI+CMzaHu5vqSu+Isb2tSM2OlUpfWqvFSvsxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU3ZxqEQMDQrjdTMLFE3NOxhhGEWhoCeMfOMeY2FNrE=;
 b=dZGhjTm4I3ltbnUMzMeg6NK2zjm1up3ac736MK9RYlwmlYUyWsupSkD38mhr+IA6NUXgcj4l2/cIKW7exCOMYTDNZeWYmG0bJJ2617gOig/PluiLY77CSHGAKQcV4oYDEWq3VbaF6W+ls9FwvM5btY06yrpyDuCBVtDs1DITxG7qWZdV8ZTEits4qPdecMwo+EmxGNMjitIEjQ/4HihTX41J82fYJdrVHW4hiFKymFq8AWoQ91HBNCDSZ+nb0n/sJJm8pflJflODBjGCElqHBLBrlArZJDc9ZjMu9Nc+GMzjKTpSEA8wu5BBkQm7qQDuAdOx6hs2BJ/5G9xXmGCjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU3ZxqEQMDQrjdTMLFE3NOxhhGEWhoCeMfOMeY2FNrE=;
 b=lXUCOP6dH5ceScpD4EKI9SAZdINpXPPwxIvL3viyt+8ZTmDGTEM/py+c5yXyImphx9wV+gv3UF8vF7H6fg5aQvObmrHiEUt5FyoUR+CPZzEM/6TfP9YtpQOvUTCuXU6dKgYrPBFgI4+RMmdN8QWn3OOoPKk8evXPqTCIf7j9lVjj+u8uHPGE0Y7XgwCaIHrn59RxrHGZ+h4UqYlKh3tXpZxi9Z7dMVSDveofHudIxj4sBcp5eCnA01wmMrDRndH8J/7voagxH03o65nsfIioDW+LHnDae7zQL53fX8myiPoqUCgV0oL+pVh4fsWe+jkvQ4UmHDSoewU8mWavxUFcXQ==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by JH0PR06MB7268.apcprd06.prod.outlook.com (2603:1096:990:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 05:37:05 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 05:37:05 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIDMvOF0gaTNjOiBtaXBpLWkzYy1oY2k6IEFkZCBhIHF1aXJr?=
 =?big5?Q?_for_64-bit_DMA_addressing?=
Thread-Topic: [PATCH 3/8] i3c: mipi-i3c-hci: Add a quirk for 64-bit DMA
 addressing
Thread-Index: AQHdOgYHq/3h2D4Rj0uypiQN8ghPWLa6MysAgAuTLwc=
Date: Wed, 9 Sep 2026 05:37:05 +0000
Message-ID:
 <OSQPR06MB72523D6D3FB1091C3B26F87A8BB02@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-3-19909e7cbd7e@aspeedtech.com>
 <apc6ujQTcvoyPq7o@lizhi-Precision-Tower-5810>
In-Reply-To: <apc6ujQTcvoyPq7o@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|JH0PR06MB7268:EE_
x-ms-office365-filtering-correlation-id: c9426763-d25d-483b-f378-08df0e3461cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 bHdjcA0y0HATu0ellRVfsla8GJ6FG8CgMxW0NNuOWjulvM2/H0hhByw20SxsQxvo/QapTwfABgrtO8kzIbS2eWG6UUo7do37mMm9GpYb46NmmqBF/E5n1X3Wq++G6GkhB3n0+tXwg4zjMUdAkExb4yPlpmuDaLffM0IQowLgh2HNQtKr5lB21ZqNBOtdeIEhsPJqoA6OnwuMTFOKlHYqr0plvfocpDZlDDmkJndlyiUTjUK6FkZsvx5XL6wuG373g370FuqjIHBVqa9KqPUxPYT70TYQjLiprzWGD8XbRVSlVqOz3cS42jO+lgyeE52nsfVFETpw8BagJw5eDDB3xRWb+qntcicVE2IN4+IZuJCAwKMC32hMaU2kfUtHgkksbQlGHyZGGxQwJCy1YuG1nFp+rdEAtCqZr968+nPoTus3Y8JpDcunpg+vgqYONuDlnAZOP2E8JrQWTTwcO73Vg/ZiwhPav7P92oYdcuxnJhF/LFAtvVqEPspCdzNJWQL1gGlp4tJk9gHbJ+jctdpmxd5gJC+qzPiwWmrkUCGehZ+cibzJta4+etXfIOeiJNyZ9z3DfxCi98ehuzk8iB44WZyRiiYmrd9rW3wCTC4hwp9cz1HezEcM+IwHYmQQ0G689/L1B0NLbRH3pMUiD75FMjh7XUiuwcInY+cbmfRLQrWTo5576aBQ9EBuPibe/F+z6LowdwYwbC5Hq9CZCunkOA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?SkVTdXpmYnQrWGo2VjFBN1lPaVBXWkwvbytLV1d1Q0h6cWZhYUIrQ0dERE5WZy96?=
 =?big5?B?SHdockR3UEhMTndEbnhiN01OYnkyWURGY0RGSU9Vd2lyVWRSWUQyWjZLMFYreXY4?=
 =?big5?B?cEE1UHRQSkpUNXE2UWNiZEdTd2taK0p2bVZ4bFBHOXVBVWluRWVpb2xXYUEzbFVP?=
 =?big5?B?dUVTRGZPSW8vSDNuS1VYMU9NTkc2cmJlUk51V2ZvR25kYXQvanBManJ4S3IxVmx0?=
 =?big5?B?ZDNjV3FyQWxJYVVYV3FqSDFxbzZhZFlYcFBNN1JucFkreFVDYmNuNnliUXNWNDJl?=
 =?big5?B?NUd6cXZkdkhxbzdQOXJSNjRhT0NXMnZOcVF5bTVKOFVFQXlhVS9lVXFRWWN0WFFt?=
 =?big5?B?MTZNcDN6TXE5ZXZienJBWFVqSGUzRm80NFhPdkttdHRyTHc1RXhVbTBOSVN3ODZh?=
 =?big5?B?anNJR05PamVpUnYyREtyOEJQS1p0TVNHM2kzU2I4WVZ6TmJoQ3Z2Y0xTSnYwWWR5?=
 =?big5?B?NEdmQXAvVHJZMnArMGx5ekhQUWRhY0lkMDcxU1h3dWZ3OHZDQUNORUdURlJmNENs?=
 =?big5?B?UHdLTDhCWEJtYVdVMzhCVHdFbW5BOFJEZUVscEQ4MEIrbkVMOXhhSEQvd21UdGlm?=
 =?big5?B?Y1ZwZStXdkV1UFVoRGppSmZOenBZNDVBMjR4d2JwL3NxKzRwb3hrWFdKMkRwZkVH?=
 =?big5?B?T09ENy9qU1FzTDZwUGVEZEt5M2x3cHpSS0xMVzdKbDY4R3VLZGJZSit5YnRjZVhI?=
 =?big5?B?YjU0VU5WSVM1bmRsOFFlczJuaERsbi8ySDI4Vm9oaWxNYkVxd3BobWo1Z1YyamVa?=
 =?big5?B?U2VTdytHSFM2cjI5RTB4djBSNFBmcDduWjNsbThZYUVaZzZVRnhYV2R2Y3czUmtu?=
 =?big5?B?NmsrUzNBWE9oYUxLMjMxWVVpeGhtWmpWN0ZLSzVDdlVwSjFaU3Z5L2xzTEpoYlJR?=
 =?big5?B?elVZa3NoSnBtVkFNak5rS2tDaFc0cWhEaDlJNVFRd2hmWEtaSlJtRnNBV2xNR1Aw?=
 =?big5?B?OHovZElNR25xSXBlK0tWclB6NytXL2hlWkxBRlRzMURqcXVGZDNtWVRscG9WQmx4?=
 =?big5?B?WGtkSU5RREhDV1loYXZQT2dteU9PdXdTTUNCdjZaNFduVTF4VmZsdVBOTGRXQUlZ?=
 =?big5?B?b04wYnd6S0dqekRlQzZkMlAwWFFZWWI3TmFjcUZSK3NPM0s0SXUzdVRBTThtSjg2?=
 =?big5?B?ZHZxOUw2bXVmTWNWTVZyb0xHN3hwTk11UjJIV2J1OS85Y01WTHJyR2c2dWJucW9T?=
 =?big5?B?RFJxTW03RVdXVHBIcFRtQ29tL2NFOVFJd3FwZS9IMVdHVHMxRHBiZmI1SzNyWHU0?=
 =?big5?B?RWtQYVVKZ25uKytUbWJwVEdxUW9vcWg0SndtT2hVOWFvb05tKy9qalFuOVI3SEJp?=
 =?big5?B?N01hUktwRGFzODJHb012cFFWVEorZFIybmNac0NqRXJ4RGk3OHZEc0tldmJHRE1S?=
 =?big5?B?dHp2d2NrZE05TVBUUy9JNjhwNmtISkhLVmpZNm5HSjlvRUFxRk5VdnIzaW5IRk9T?=
 =?big5?B?UXZWK24wMEY2S3UwN3VjQ09pM0xyWWd4dWh2SndvSXFJd1VEYzF5cjZodXR4eEZP?=
 =?big5?B?NkZzZWRyZ1ZHOGdKQXRjZDhuZnFzMzlhRlE3aENiQXJKQ1hPSkNHb1RocEJHcFg0?=
 =?big5?B?UUNwL21LZ3lJS0RYN1VRK3ZKcTJYa3RLcngrOHNSM3M4MDcwaUVuVDlzbVk1Yk5m?=
 =?big5?B?dkZ1NUxhS0dOaDExUnkrZEh5ZXJYWjVSMDBVSnFPM2VQSUVvVTVIZU4wQXppaldn?=
 =?big5?B?UW80a1M0ZzUzWmlLUUNUbjk4djM0WXJhZFI1RmJ1NWlSRFBzbFYrVnNxUFF0N2pB?=
 =?big5?B?TUZrQ0dBeDdVeDNzeFQ5a0tYUjVFMWliOHlTSmh2N3R2WTJ5a1lqTnB4RDh2a2U5?=
 =?big5?B?b3YxWlI3TUp5WEJKd2N3Q3NLUDFSV1pXcVNYM1p5UXcyb1R0My9nZHFQS0hURURy?=
 =?big5?B?QWgvSU9GNTJvUGs5RGVBMjR3dHcxSnRxa3hzYTJ2MG9wQ0N6cW1Wby96RHA4bnlY?=
 =?big5?B?NHNIdlRKUUx4UTVhNTl0MW1nSzcveUlXUG04UytlYXBzZ01CMWhpZEhZeTJFOGZL?=
 =?big5?B?K0QwdHdsL0pLUm1nSmdBS09hOU1yQTB5TnUxYXdGdm1TakM4ZU8zdDJXeldLWFZl?=
 =?big5?B?SktKMXBnWEc5YWgzZ2VSYW0vUlRlVWtpMzU5Zmk0K0g0bUNHdmk5ckVYZVc4Mmsx?=
 =?big5?B?TzVxWkhhVytrc2lVY1JxQW9pOERaN1FMSUh2Yk5DSC9UOStaVUJVa3kxNS9jL0xn?=
 =?big5?B?MUVCd0w2bDVuYU9nOFBvMXdGS1dQdz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9426763-d25d-483b-f378-08df0e3461cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 05:37:05.1613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPJiS9uJrk92xQFLoMhVaUgXssdlHi2kUzY2S3xzo0qAdvc0b/Rt5vskmIigUnI9VlzPVYXbjSgqDFut11o6hAaMGbUnljazkA/UHvpZQP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7268

PiA+ICsgICAgIGlmIChoY2ktPnF1aXJrcyAmIEhDSV9RVUlSS19ETUFfNjRCSVQpIHsKPiA+ICsg
ICAgICAgICAgICAgcmV0ID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmcGRldi0+ZGV2LCBE
TUFfQklUX01BU0soNjQpKTsKCj4gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpIG5ldmVyIHJl
dHVybiBmYWlsIHdoZW4gYml0IG1hc2sgPj0gMzIKPgo+ICAgICAgICAgaWYgKGhjaS0+cXVpcmtz
ICYgSENJX1FVSVJLX0RNQV82NEJJVCkKPiAgICAgICAgICAgICAgICAgZG1hX3NldF9tYXNrX2Fu
ZF9jb2hlcmVudCgmcGRldi0+ZGV2LCBETUFfQklUX01BU0soNjQpKTsKCk9rYXksIEkgd2lsbCBk
cm9wIHRoZSByZXR1cm4gY2hlY2suCgpCaWxseQ==

