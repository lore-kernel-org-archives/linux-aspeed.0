Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC3606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dxHvd2PH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTn8Z1LFVz2xNC;
	Wed, 18 Nov 2026 14:27:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794972430;
	cv=pass; b=ggmkPkH6owqujsFhcD7JFGPR0+RrS1geun0V3GT4HcbysTc0ZvDxQ7wpKd3BL0VWECOm1812+/iSZOZ1FDz1w0T9pJGuJjOBLyCZwrD81MBP6xC5AGRUWOB4vRx9kQQpSeiiPGbnerwTp5lbwRpxgeZGsFWLOPyIHE7a8BwbWTZ6Qy9POZF1SNvx2h6YIkldz/cac41GrkZOP9pbzifJzcpclq37gHgH+3IgRRYjJKO3Wj1/FgSHDysmFh8/+QRttCQ1xRYZIlClOYdi3Q/QnUA1x08Tzc8va1oLzDdrfbAS4nYRybG9Pzgr5AyZhYIxncfl4SxTitja1oaFs6nEOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794972430; c=relaxed/relaxed;
	bh=tPymqVUmTFuIWhkBVbk4nsDCJUO8vmN9WbimdVQ8XPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F5oZBKxwGsADsxBTwPXqUJenC5hPoifpd40tuvqDRG/1MdcQhQwsdrDZotUXaQ+eN93oNPKz65SiidAX1EtWuXfWexUmdQawyps5jE24Ao54npsuUg2p1o1iXVIN2pBPew6Jqfb0/dSsBSpmib0bqgImiHQpl3f+gHtINFCRmPTjF4ChfvhAuuWAgazscFx+2fnWHkCuAlKxeXIp2OClgSexvBxP0xMVhqk4NjKGJoB66fa+HbfaH2XOIKC2DCrN2mIp8JYPujYO0J0uCfQsbsqq7jBwZXCvYNuHtuIVpZvYv9/6ydfqoq1ZmdlnKDNd99mlZNirXYQGD+72fs1mOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dxHvd2PH; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dxHvd2PH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTn8W4qzMz2xL4
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 14:27:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1CErrfSzclA1GA0AfU3U066GiPfGxO4JvtpAJojImU/o6+Yz8OCBpEEGBnSBClaolhWWtlVb7p1HsnsyqFzJe//ooAnFv3lyGK5U8lF53yNu2lpb1wfnqWME5iFotVEkfwRX1LIZMqOvmfgkc8ThcvfQRwY/1fHASu4CPcQ0ym1IMMWvjpyhv9w1icw/w+Mrcz0gXHH/mLp0AT9nx3iR7Yod9cRGCjMRuZh61pIMcQ0J1Qf67st8lMgsS5uwV5UVqykZyzhRXcs3xKJiv6tzZrRCUhog2eZhF2ifNtje+06o3UpnHM7p/5ARLfuByio7wJ/QDsPN+QljTAF+ZvP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPymqVUmTFuIWhkBVbk4nsDCJUO8vmN9WbimdVQ8XPE=;
 b=dHP0m56N0Vksq9/PD24oK3kyLIQ3s1l2CQzpDc5NajrsDXQ7DMc5Y8QWHKjLKRRB4ihiORwYVEl8QYUVW5U22dtVlWyYYGNdP+IdsbKUaN2NCKCKdj0SCkyreztFKpmAEUhUV9Jgg3jeGuIGcKqXfB0TD5SmxjB0yiMAhGXxe//LVZoYDKPlGgUDMh3Hz6KYOrXKYcxDR6bU5/ofCDR997Hi3PyDODot7bAIV4js65cQ88KUU3HfGrTQzP2Rv18G3DLzoT23+M2rS06CCCQBPwRSEWRBuf71i1u7aVXzvo4zbIIuKrarAYJLZhKBkdAdMK9iHO4DV6jm+t3f30ftFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPymqVUmTFuIWhkBVbk4nsDCJUO8vmN9WbimdVQ8XPE=;
 b=dxHvd2PHkhAOI5FSrkvNT/NFLdlPJDdNlxV0uJT0fuO0g0yDp5/waOj1vdtGGQcE/nH17h94gjHyVaj+oSwv0iFA/A4ZCcPDIXOiKwYz5/i8DJkV5UpXMlk484qEbFsa3+ZICiH6IUYy2soB7oAnM3p2AkRq6gJchAvSW4Nz4rZzXSLuS7+99EAzaWboVuBSSYuQALcRkBCdk6bpU3akQ3wQvn4XYQtP1AmfX4+AzvDo59KL22IqK5x6zV5yRCn9S0aVQA07pdYbqCcvbv7FP3yqYSZrGrDlmUHSVGkimOfOtZd5a8+OKqNECwwuy6tNGN4QhIVIf5+aK2JNIbVMoA==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYNPR06MB8829.apcprd06.prod.outlook.com (2603:1096:405:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 03:26:43 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 03:26:43 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Ryan
 Chen <ryan_chen@aspeedtech.com>, "tbevis@amazon.com" <tbevis@amazon.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIHYyIDEvOV0gZHQtYmluZGluZ3M6IGkzYzogRG9jdW1lbnQg?=
 =?big5?Q?generic_bus_timing_properties?=
Thread-Topic: [PATCH v2 1/9] dt-bindings: i3c: Document generic bus timing
 properties
Thread-Index: AQHdcYsQu2j3zyDLfEW7mmto+L8ne7cpFmUAgAoaI2s=
Date: Wed, 18 Nov 2026 03:26:43 +0000
Message-ID:
 <OSQPR06MB7252FD524944EAEC81F8C71F8B7A2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
 <20261111-b4-i3c-hci-ast2700-v2-1-4d8fff5c5196@aspeedtech.com>
 <avSczhZGS9cCcNSu@lizhi-Precision-Tower-5810>
In-Reply-To: <avSczhZGS9cCcNSu@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYNPR06MB8829:EE_
x-ms-office365-filtering-correlation-id: 130c06db-3935-4316-675c-08df4523c478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|4143699003|5023799004|56012099006|261026140227099003|261026121527099003|10067099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 65UDZZXvz2n+L5lQkk9EW3O8NNXIL+t9XvFkEhSCAXVQhvS6zUQihxNoy4Rdeyn95NTDHC4r70BtGAJRmYwHesF3YEOBVSR2K6CqMPdkS84/bePKteoWaV5ahWt8doEmgYsNg/32Uusz74gZOMCph9mszS795m01vCk+JZ30TIcAB9Co9AreXnA9hCQ9ND0Lddzvh3Mhf1CU+hQ3ApqwI1opAWm3EseQJQN438ie4Ev78mAeZcaO6HXA9i5ieKlv2+YTgai918lz7W7gteIWXJWMMidYY28yD7wJ+/LMu3jrV3WHfqNA5fQQbPxTdvtD0coUBrjE1hMlxL59kseyRhFBH2S+61g5etLXlDNKFx5VJQoAuE7j8NKX+AtQnTG8j+yOBdYPXu3NukULsylP3sAFP1W3Ylo0ae+BxIGKC9Ni3vvt6rzm6+NHIDKfh+vip7i2uXN9ECMwMR3Fl+vmNIIouqvI0wfi4BQG5urgM8HBi42RpJC/+/o/zcq305c3Z/fNYlpcJCa/8ZnKM4Q8BhoXLnyWveUqSX8uUFLQ05WnKhB387LV7gxXZvdQX8oYn6Zr6Vfko6E84awAGWk9VYH2TGGgHZGYMazBVJ3Chusf5mPhFgkSb4MFD2ybxi6FkvaslRvIqaB2reS7iHiJhXBbMzhV38Ne3tCMmHxj2XLoLE5QH1/rih//Nv0FXb/BLCFJgFmqyDudIHmU3gvvhHBJ8Q8aF42WnkUM/jXooCo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(4143699003)(5023799004)(56012099006)(261026140227099003)(261026121527099003)(10067099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?cnVOeTVNaWduMnAzT0MyenBoNWRQSUZUNi85U0NJUDJUWTNzYThibG42SDFJbmRO?=
 =?big5?B?QmlHczJWUFR5SHhjTFVTNFpFRUhmbDYzNXd6YzNReFEwM21LSm5JNXBqZkVCYWpk?=
 =?big5?B?OGdob0RKWnJLaExYTkpOWW5TLzllcGZobSt2RFRaajBrNXlYRytqaUY2dURuWDEv?=
 =?big5?B?MkdtOWo0bEdUWmVhNlBXZ0RXbXk1WGE0REVFR0liYkFVemxVVEpRalQvdXczc2th?=
 =?big5?B?RWV1ajhIaDF3ZEhFTDEwbnQrdTNET1JkVzJRSU5mRDlZanQvTDM5bGV3MWlhSE1Q?=
 =?big5?B?eWhiemNsTmVMY05BM0RWRSt1VitxdmxlZEduK3pPNWROSDlCWGh1UUx4WWV4d0xq?=
 =?big5?B?NUhlbE8zaWVaRUtvemtnQ0hrRUR2amkydG1kcTZVcUpETmxtLzZocGp2ZXFwalli?=
 =?big5?B?VWRCaUNMVklEZUMrYUhDb1Rncld5OTEzWjlHVFpCanZ0N3V4eGxKVTJsSmUwcG0v?=
 =?big5?B?dTFmbGM1U0pKeUZ5SVNoQXc4d2NIRUhuQm9WTTRMcjBWVkhwNkkyMGdmZUFyWUda?=
 =?big5?B?T09rcDRtRklhVTg3bVpyM1hxbXhYNXA3b1ByamJqaVFkVzBrc1B2dEZWSFI1YStq?=
 =?big5?B?NCs1YUEyMXRtWk95QmpOSTN6eUdKTTNSeko2em14U3Z3T2tHenhiKzhzT3pHeFFr?=
 =?big5?B?MHordjMwbzMrUzJwNEZBSTU0S0pETTR4L0Y2bllmMDl2aXZObHpMVUMwMGFlb3JV?=
 =?big5?B?NWVKYlJNTkhGTW1qSStXTm5ydlNvVkM0S3pxa2tWZk1WbzlxMkhjWlBpa214R3g5?=
 =?big5?B?ZjNPQXg3dnhVNk1jcWxwcmxHTlo0SUxHaGk1dFlrdjRhbngwaDF4VFZFTFpIN0s1?=
 =?big5?B?V0s2ZFNSQXVFUkFtL0pRMFg1WnVLQXVFV1VOSG9hZWphbjRZNVNGL0VOS25KcVcr?=
 =?big5?B?Mjkrdk4wRXFlS1BUbUViZXI2Njhac0ZCdHJ0Tnp5V0dLNHNkeHQyQldDZVJSZ3My?=
 =?big5?B?U28wbk1ITC95b3Frb3pIY25aTUpjZHNKNGFMbXRKSmkxY1RLVXd3OWZROU9sTWEv?=
 =?big5?B?RzZpM01XcTlMeCtzL3FkTGVTTktJeFg4SFZrQlhRaVdESm01MGFzekhoOC9TVm5K?=
 =?big5?B?VjQwTG00KzhOWjRxRFcxYkdEdUlDQ1liZjNLa0hLU3p5V280ODQvL3V5Q2ltQUpQ?=
 =?big5?B?WTlrNVR2NmRJL1dUa29pUGN3VVgxdHhkRkZKUDkrVnI3R1lwNFpuUE4rWFVDRlVx?=
 =?big5?B?dkxXcW1mMmFaSTllMUZUYVgvVmtnZWFLVEhJMys3MGx3T3A0V28vOVV5eEpEczMr?=
 =?big5?B?YXp5ckdNUHRhNnhaeVAyaEFCZVhENHNDcFQ2Wmp6eTd1NXcrZm1Ib1dBTUNBMEpY?=
 =?big5?B?VHVxV2J1TXVWaE0rb0ZJVlhDYmt4WVp2NXZqY21YT3J5NkpYS0V6WkM4c2VKMDNI?=
 =?big5?B?UHM5UzFNb1oyS1VsREtaeXJHRkdzWVY3VlZVL2cvV21tRWNnaUpTUW9YMEI4OTF4?=
 =?big5?B?TnBaZHpWUVlianBTdUFIbEsrYkxMeWtoVFM2aDIxajhGNXhqeEVLUGxETXpHUmRP?=
 =?big5?B?Qk9PZ2x0M1RyQ3gyMmhoZndNVEpYaGFscHI2bzB3WkRNd01PODN0V2c5aXJjMDY2?=
 =?big5?B?ZGpxSmNHZ3EwVHhRU2U0UHd4ZHBCS1NnUjdPYVk2RTkzSlptZWIwcURjOWpkNlFr?=
 =?big5?B?UXFRSStOVms1RnVDMmFWKzViR2FwRzE1dWpZdGpvM2FlazVhMFZLNFA5cHNLd1RD?=
 =?big5?B?b04vYkhGbnY2VHR3bUhzYXFYUER6ZlR0dGtHT2R4cWNidkQ0cENlQzZ1RzBVNFJI?=
 =?big5?B?UTlYTTh5VlozYW5rRkUzWHplQ1YyMVk3UzhDTmFQRk84TC9JTUN4Q2RnSjBSZTY4?=
 =?big5?B?clVhQndyYXZsQ2hqcWlXcy81SHhsUGRRQllQa0JoVW5uMTMzdWhoR0lCR2dWUFZ2?=
 =?big5?B?aHNtaXh0a3hPanNMVEtOcDhNK2NEZ3ZieENSZEhWWWxuRlVIOE9GbENEalpGYXlQ?=
 =?big5?B?THBySlpEU09Gd1Z3NUxoTDQwT2p1SnUvY1QxL1diWHh6ZUYrV2JQRW1SYUtITy9q?=
 =?big5?B?VHlWSGFPK3FNS2lyT0ljV0VEM3oyWVRnQkJDNllUK1psU2s3emhMVFNWNW8zeTBN?=
 =?big5?B?a01zcFFpRDRnd3lXdVdQcklRRXVBcStnU1Q4UE90b2tJVzdWTEkxaURQWjBPMkRU?=
 =?big5?B?WGJCZ3kxUUFUbVpXR2N0ZnhaK0NVU1JEcTJvTGh4eWMrRTJlb3doQ0c1RDNrdEQv?=
 =?big5?B?MmxBOTlZeGJQdnJjMEFDUjhEamJCdz09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130c06db-3935-4316-675c-08df4523c478
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 03:26:43.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HulRUPDy15RumDWzQQuyBYcCGe0od3KaQ2vMP8+2dasYx8hF3nqgGZfHtyuQaQyUcc9vpdnzz2Sjb7GfbNeHFoSt8kh4LcDQXGuWv/GnYbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8829
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiA+ICsgIGkzYy1wcC1zY2wtaGlnaC1wZXJpb2QtbnM6Cj4gPiArICAgIGRlc2NyaXB0aW9uOiB8
Cj4KPiBOZWVkbid0IHwKCmkzYy1zY2wtaHogYW5kIGkyYy1zY2wtaHogYWJvdmUgYWxyZWFkeSB1
c2UgYGRlc2NyaXB0aW9uOiB8YCB3aXRoIHRoZQpzYW1lIGJsYW5rLWxpbmUtc2VwYXJhdGVkIHR3
by1wYXJhZ3JhcGggc2hhcGUuIEtlZXBpbmcgdGhpcyBvbmUgcGxhaW4Kd291bGQgbWFrZSBpdCBp
bmNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZmlsZS4gRGlkIHlvdSB3YW50IGFsbApv
ZiB0aGVtIGNoYW5nZWQsIG9yIGlzIHRoaXMgb25lIHNwZWNpYWwgZm9yIHNvbWUgcmVhc29uPwoK
PiBBZGQKPgo+ICAgIG1pbmltdW06Cj4gICAgbWF4aW11bToKPgo+IHRvIHJlc3RyaWN0IHZhbGlk
YXRlIHJhbmcuCgpBZGRlZCBtaW5pbXVtOiAyNCB0byBpM2MtcHAtc2NsLWhpZ2gtcGVyaW9kLW5z
IGFuZAppM2MtcHAtc2NsLWxvdy1wZXJpb2QtbnMgKHRISUdIL3RMT1csIE1JUEkgSTNDIEJhc2lj
IFNwZWNpZmljYXRpb24KdjEuMS4xIFRhYmxlIDg3KSwgYW5kIG1pbmltdW06IDIwMCB0byBpM2Mt
b2Qtc2NsLWxvdy1wZXJpb2QtbnMKKHRMT1dfT0QsIFRhYmxlIDg2KS4KCmkzYy1vZC1zY2wtaGln
aC1wZXJpb2QtbnMsIGkzYy1wcC1zZGEtaG9sZC1ucyBhbmQKaTNjLXNyLXAtc2NsLWxvdy1wZXJp
b2QtbnMgZG9uJ3QgaGF2ZSBhIGNsZWFuIGZpeGVkIHZhbHVlIHRvIGFkZDogdGhlCnNwZWMgZG9l
c24ndCBnaXZlIGFueSBvZiB0aGVtIGEgc2luZ2xlIGNvbnN0YW50IG1pbmltdW0uIEknZCByYXRo
ZXIKbGVhdmUgdGhvc2UgdGhyZWUgYWxvbmUgdGhhbiBtYWtlIG9uZSB1cC4KCj4gK2RlcGVuZGVu
Y2llczoKPiArICBpM2MtcHAtc2NsLWhpZ2gtcGVyaW9kLW5zOgo+ICsgICAgLSBpM2MtcHAtc2Ns
LWxvdy1wZXJpb2QtbnMKPiArICBpM2MtcHAtc2NsLWxvdy1wZXJpb2QtbnM6Cj4gKyAgICAtIGkz
Yy1wcC1zY2wtaGlnaC1wZXJpb2QtbnMKPiArICBpM2Mtb2Qtc2NsLWhpZ2gtcGVyaW9kLW5zOgo+
ICsgICAgLSBpM2Mtb2Qtc2NsLWxvdy1wZXJpb2QtbnMKPiArICBpM2Mtb2Qtc2NsLWxvdy1wZXJp
b2QtbnM6Cj4gKyAgICAtIGkzYy1vZC1zY2wtaGlnaC1wZXJpb2QtbnMKPgo+IHdoeSBuZWVkIHRo
ZXNlIGRlcGVuZGVuY2llcz8gU3VwcG9zZSBpdCBzaG91bGQgYmUgZGVmYXVsdCB2YWx1ZSBpZiBu
b3QKPiBleGlzdGluZy4KCnRISUdIIGFuZCB0TE9XIHRvZ2V0aGVyIG1ha2UgdXAgdGhlIFNDTCBw
ZXJpb2QgZm9yIHRoYXQgdGltaW5nIG1vZGUuClNwZWNpZnlpbmcgb25seSBvbmUgbGVhdmVzIHRo
ZSBvdmVycmlkZSBpbmNvbXBsZXRlLCBzaW5jZSBuZWl0aGVyCnZhbHVlIGFsb25lIGRlc2NyaWJl
cyB0aGUgcmVzdWx0aW5nIHBlcmlvZCBvciBkdXR5IGN5Y2xlLiBUaGUKZGVwZW5kZW5jeSBrZWVw
cyBhIGhhbGYtc3BlY2lmaWVkIHBhaXIgb3V0IG9mIGEgdmFsaWRhdGVkIGRldmljZXRyZWUKcmF0
aGVyIHRoYW4gbGV0IGl0IGRlc2NyaWJlIG5vdGhpbmcgbWVhbmluZ2Z1bC4KClRoYW5rcwoKQmls
bHkgVHNhaQ==

