Return-Path: <linux-aspeed+bounces-3687-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407CAF013CA
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 08:18:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ7JR0ks1z2xpn;
	Mon, 16 Mar 2026 19:18:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773649094;
	cv=pass; b=NuJDJ/JKzixHQ8GxuVdtXrGksFf+pK3TBmiKCW0OifBfONnV27yVbFnj1BZKNkB1+LRDEEJE6PWguFVQ92tLaGK5ze53T6q3Gz8XCqdlhsK6GGbS0QRRUkj1E2uo/xGX/Rp7RCdnk3FjsrK32c0D4vAfb5NOd9crIW/zaSX/nTXwURr/Pt/zMsnlwi74zoNypgLnqpd52plBxm1qPKvZyAs5jWQegf0MehkICz4uGZ4qYjbtRyGgPBhIyvcLiYfmtRMrmRgrmfXv7H47LBXcW0rEWhcfkbhVuFzcHJ4G0gcJAjcbZ2WmafcuyzhVUjI4WoKayZPxxiTlPPbAmpJcuA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773649094; c=relaxed/relaxed;
	bh=CIzj7ZA9vpJ2WYklWg+cNhOeNkFfYh8yTwz5h01ztoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjgYRqSb2w33WUW6GNhrg2P4iOkXkTu2MytcvzxjJEu0xxcaD1v8Vye1zVwfsZ13wI3oAu0tWMvNxOHZ8cQ3kXePqB82u5Z5rqCIH++fcQHKm8gX9Nj1SLRXy8yvCTCbrblGVVRE05+vWzGXwa0pznrGMo0uT9atFmDWXxKOnCbXALGuRXRS4ut6kTZgdJrdCkFYig2RWcsB36k8a617k2oPuOjZmUOv6G3604Hk5BOqfC2F0RinoKx0LCsO6Qkpbyq3aS2NFM9cppaUwZAr5cuTOw0qqtwScb1vqZT/L/Fv2vTFp/8n1WSOLoSSq/BPwmSrrQot78cbP1BIqqbvfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nQNBox4E; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nQNBox4E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7JP3nGJz2xlP;
	Mon, 16 Mar 2026 19:18:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js5sLjAi+Oiu1P6qKh5a01jAhVPz3MS2A9DjoOtfvXVl9E03I701894iXKqsgX4zwbkfhy80imIKoQG08ltESMYdQ5TTjuHQ9JuNhgruonByujuaj0vNKqVGPrdUZPkF/GnxmJZ+Vv/ipq1sgYjyE9q6gU177cucwn+iWJCK4i/X26dcBFjeC6bEWvICEICkN5T7J/4qdvur9+Cjv8M3iobGqEJW5AdpX3RjjFKUfor3vI36BeNElkAqTAIL+I5aGvQs+rtyibrydMEL4tIh+28hLYVVLxHUHEOB3ycS4lVyBhrbKcQ/+vjys4MjWmP0y9Ni5kNvNStheMc18ofDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIzj7ZA9vpJ2WYklWg+cNhOeNkFfYh8yTwz5h01ztoM=;
 b=Gu8mjycBTI4Jkq4OnvNOY4DSEUdvbN2HDsWED3lBQeeRsoUwVhga3ighXUtWQw4DJa70SAOGylNod6fRGEfgIIGCYsK6akx78PwXv1ultTnBIL3BGvX/kEHXIwJGdK+Iw8FqHg3nkoTtJT6w7LColH966Qh2rKRAY7pfRb1A5gJSNR427nsRibn9Coqpf8M6KhX3sAHADRLZlHWX4hlh/muGGot3dya7nwAYDqHBwIoPESXMKb63MD4Z0zN1vmAjDzBTCcBmluv3Q4s+iGwzyl1w3iHZhjAp7qsLxOEWTFyIkDo3dQfrzr4DxkhJuLgvE6U85DhUMzapGm8kaqAQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIzj7ZA9vpJ2WYklWg+cNhOeNkFfYh8yTwz5h01ztoM=;
 b=nQNBox4EA/BLw9qbEVtGweFGvVcFPtZ1dSI7LzTMKn+5ubNAsPEgqtlQ6O6P8oU47YuhqhSFtLXkWCDY2SkVEMtOK4EFWBm9xwp+mWr9Q/est2Q7vHsrgqp+Y/B2IlhmhDqiEGnCtcBFA4772jWvPco0Ciq+m6Dh2WXc/xBkj+0snIRfW8XDjgcOmPNTsdOg68CGqS4VVgi8FLusdIO7+UOIieDuYRnENd7aEvwonsST8OvlSDCeMI0ka66DttNmv9PPvYOqPRfhyGfAzl0+cg5QTK50hano4FUaf+95mDjXVSUkBgb7mT8tzhr7f261/gdkjJ3zRrt8OCBu6Y2i6g==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by SEYPR06MB5325.apcprd06.prod.outlook.com
 (2603:1096:101:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Mon, 16 Mar
 2026 08:17:49 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:17:49 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>
Subject: RE: [PATCH 1/7] dt-bindings: soc: aspeed: Add AST2600 eSPI controller
Thread-Topic: [PATCH 1/7] dt-bindings: soc: aspeed: Add AST2600 eSPI
 controller
Thread-Index: AQHcstFOhnecqp+8vEODwE67uQSGWLWwwXmAgAAQs4A=
Date: Mon, 16 Mar 2026 08:17:48 +0000
Message-ID:
 <KL1PR0601MB4276A4B81C2E2DB02BE8F2059040A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-upstream_espi-v1-1-9504428e1f43@aspeedtech.com>
 <3f2d964a-4e82-414c-b373-af0d531b0fcd@kernel.org>
In-Reply-To: <3f2d964a-4e82-414c-b373-af0d531b0fcd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|SEYPR06MB5325:EE_
x-ms-office365-filtering-correlation-id: 6bd7feb8-d6ad-437e-43ee-08de833482e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|42112799006|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 LTJDKWPuz5ZxcyB0e/Zqpf5JalFhlVWd0jYh1LUQZ79Q4tkCA05SdZLB03+35+umawEHgmrAZktOQgeBQgeAqiDEDXjcDGeKxMZuWXWzQxJjomhE2qirX1KovbJQLV0NiMyi0RvcXoP46OwrZ+duyXmIRbD7hdVa79rCB5zfydBV4dqqcBqICuQKP1HlPRct1M+mxQaSk2GNF2xxx3XT/45PPUXtT6254rFxrmBZvw7IDIYHkIGejhDRGZc5VVqpuSefSuGVKMy0bFPX9dix8K4tQ4tnJQvgd/aD2Trmp0jWGXyB1YyIufRQA4Z9DWkkRN/x3K65j8ZmZh9eMX2FqqRXPAbfFVn+9AnHHZAoe8T7yzzncHgf30cuYQ6DP6+Ao7b7oO4gxFj9XvHu+9uLY5mzDvV52eqVpWtLb+bRMal5/i+OF1rdtEGCt1Dhkp1aAe4ExaB/9CiixTjuj8tQO6B/gMAG67NHrf0M4t9JX11LcF/7qBqyszCg+Yo4oUq7w/V9EcjTxBNGocEIeBPn9GEEGJbm4BdGb+7Ewzkf45/O//onWuozo35BynSb4E7N060wasLt4sysRfvFRO/qMI6Y2xuVATHY3/kRhQ1NeKHiXItG9ZCrF5sASPhPQ2bQ5vt+ttD8GNzU9qNBeuYy+fVPXSAdY8AGo26EL22uRbCmk74Wf9k2+z0b54q/n/vrYPNWUPiGikUTfh13YtOyoce6RspE4NIMy0NIt9XjzAQ/mXS2ckAH3yBT+/DVuqS542lRsb1LmsFG/SF4sQgUNsOzHjwaqKMDJ8syYois/e8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(42112799006)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFNjakhyZXQwVHhqcHNidXpVM3NXZlUwV2RsZjU0UzB2bHhkaHVCeDhCWEFD?=
 =?utf-8?B?RGduRWRBUWJxdlRtNnNVaVQ5azVEdDU1NDVrOTc4Wm4vT2dNTVRVeUR2VTVT?=
 =?utf-8?B?TlcwZ0UyTXpXOElSL3R2WGlibEdocGZlUUlmRUZLVHFJdDN2WXJKNno4eVFr?=
 =?utf-8?B?bEd2bldvMlVWSWgxellBT1hxcG5URVZjM212V0JBZGxwQzhiK242T1pMSTM5?=
 =?utf-8?B?U1VhRU54b1NYVTVWL1FFQXd3eDZFeUZseEp4aUExdEtjZXAxeDdCQzMyUWJI?=
 =?utf-8?B?WVRvK1NsWlZoSnYycmtWU1dzWUFrait0Tm5tNW9EbTY3bzlpOGZSZmpXRkZm?=
 =?utf-8?B?VSt3aFBDZUM3SzhsR2RmZkJLcWl2YlliMjJaU2oranlEOHc0RERjSkYxOFBq?=
 =?utf-8?B?UWV2S0lWajVEeU1CaDZaakpLb1hNekdyKy94c0F3K1N3Q2czMndYanFiUWp4?=
 =?utf-8?B?ajc4STkwbTRGb2NQamhENVhBcjUrSTBIblNNTVNzaExrcnhOdEwvZzZ0S01t?=
 =?utf-8?B?bWVwQmhSK01lcWNxK3VDV3JHeHdKN1g4OWowaEpJdmFqTTExanhObkxDNjUv?=
 =?utf-8?B?RXVScXc2VnVPeGt2d0V1WFBUN2g2QVo5UjV2ODdaUzJydHRvZ0J3SmpiQVdU?=
 =?utf-8?B?dk0wS1dheFc1OUVFZ1BnYW81cyt5NG1pVmtkRysxVWMxeFdOY2VQaFF2SUUv?=
 =?utf-8?B?SmhBa1NtSnpBUWwwZUl0ZFBQTE1GT3h1TFgrd0NjRjVBK3Ayd0UyZjAxQkx0?=
 =?utf-8?B?b2c4NEduY1RjSFZteWlnTWJpMXBGTGJRQjBvU3cxbmFrVWNMa3RydVdJM2Va?=
 =?utf-8?B?Z1l0MVlZOGRSK3FoN0VsYnVaTTdmVUZpK3RoV05hN1ZhQ2ZSMmN0YmRMQ2th?=
 =?utf-8?B?Yjl6ZDFMNWlFbWkwSVZwVXlFakh2S0hIQ2piQ1VTSllSR3d6RXo5N1g3RDZa?=
 =?utf-8?B?MkwrZE40ZzFNNXZMVVZ5NS9CZmdNdG96TTlDQ1hhQ21lWkRJeDg5bGtEbVBl?=
 =?utf-8?B?Ui9xYVhGdzN6MkdCK21QSk9ROFJxblF4NFQvaSszK0c3czIyeWpXVHZ6aUJX?=
 =?utf-8?B?UDhja0JrOXFadkJESUdld0VmU1B3SVE0M2EzR0pBODdzNldidWlvd0doRitC?=
 =?utf-8?B?c3hDTStGb0NwQWlCa2pDR2F3NWVSTzhyV1Q3TDYyYi8vK0NYUmtHaXo4RCtE?=
 =?utf-8?B?MlAyQUE2dlVEeTh1OXdaNC9ZbUtsUHB3ZXpVWlVlYS9DOG9rVmRtejR6b0Vm?=
 =?utf-8?B?eHJsMG1tUXBlWXBNcUU3Uk42cEVranEwUFRvajFFNkJkRVlpZ0t2ZmpkKzhL?=
 =?utf-8?B?elVnQ0FIQXBvVHRsOXRySmptdllXcFczd2pQVEkzSXhMMjRrYlFQV2o2SFEx?=
 =?utf-8?B?YXRtYVRvSGFEaTNiQS94c0RxcXBvYkpSZlMvR2o3Y0V3RWEwL2NMaDZMMHhO?=
 =?utf-8?B?bEQ1emJQV0lPTFVxOG83UXVNZHFOMVdocGRtS2FDNzhMMkVSUVRIdFhCai9h?=
 =?utf-8?B?VERFbGtMT2RpY3hBdHpHRUlXdUFIVEEzNGxMUmYxTUN0bTJOZTRyb2VHUTkw?=
 =?utf-8?B?TDlSeFZ6dVIxNXp0SVA3ZGs5ZnlIZVRJL0hCUzBqVi96Ky9za3BhbHdHMEFi?=
 =?utf-8?B?cUZaUnUzTlJQMktOL2wvRmJYT21za0FiY2Ziam9vOU9NaVZvL1VFVXJWMldx?=
 =?utf-8?B?QjJPR3lUT0dzS1V4SGpEU0FBQ3pKR0VqanRoQjhHUjNicFZkdWdrOWtzZjA4?=
 =?utf-8?B?bFgzdEs4TmdFTzdqMkNlTC9kSmhMbjBzS2R4cGY1QzRzaENXbUUvSWE1QzFU?=
 =?utf-8?B?TmswZjUySnhEcXNlZW1mUWlYdWlTdFRaNldqQWQyaWI0OU95V2ZqRjlZU2w0?=
 =?utf-8?B?UUtnUkZYNHE0YlNTcTVmMlliYzVkVG1YWUIrQ1RXYjQrU3crQVFQeU5BZE9K?=
 =?utf-8?B?c1FmeXRHcmhMcTJYTEhSL0ZZSFFlZmF4elp3MldrNWErL1hpTWtVcVRuVlNa?=
 =?utf-8?B?MHlzUWxqY1EvSkcwcU1ubVlYN1orOWZ6WlVId2RBa3hycE1od0s0K3VKRVJX?=
 =?utf-8?B?UlJ2NDZiakNzVWlmS3Nra1JlUWsrU0prSjRjcjF0UVpZc3R0MVBSbUNiNkVJ?=
 =?utf-8?B?K1I2bzE5T1RHckY2blVQdFVrb01raXoySyt1dDg0OG1xMDMvUmJQcjVWZkti?=
 =?utf-8?B?TFpkL0toMVRvcDhnc1d4eXBJQklXS0RMdlNBMjFCb2RkaWpOUVJFUnpPUWdB?=
 =?utf-8?B?MW1SRFYrVFpqaVJKcUY2VTk0YmcvcjJxaE5Ld0c5R01rNy8zWDlPSGN6eFUw?=
 =?utf-8?B?bFhFejhYRmN3WEYwb1RFWCtoOGF3a0s5cnl2blB2RGg2aFJNd0ZPQT09?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd7feb8-d6ad-437e-43ee-08de833482e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:17:49.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rj2UAuWilI558RsErpE3gykPtLzppa76GPXmTh9wse5gWGxsBF1+xi8dAsqJT5OL/ak1azVOFH3pX7fE1eUz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5325

SGkgS3J6eXN6dG9mLA0KDQo+IE9uIDEzLzAzLzIwMjYgMTE6MDcsIGFzcGVlZHloIHdyb3RlOg0K
PiA+IEludHJvZHVjZSB0aGUgZGV2aWNlLXRyZWUgYmluZGluZ3MgZm9yIHRoZSBFbmhhbmNlZCBT
ZXJpYWwNCj4gPiBQZXJpcGhlcmFsIEludGVyZmFjZSAoZVNQSSkgY29udHJvbGxlciBmb3VuZCBv
biBBU1QyNjAwDQo+ID4gQk1DIFNvQ3MuDQo+ID4NCj4gPiBUaGUgY29udHJvbGxlciBvcGVyYXRl
cyBhcyB0aGUgQk1DLXNpZGUgZVNQSSBzbGF2ZSBhbmQgcHJvdmlkZXMgdGhlDQo+ID4gcGVyaXBo
ZXJhbCwgdmlydHVhbCB3aXJlLCBvdXQtb2YtYmFuZCwgYW5kIGZsYXNoIGNoYW5uZWxzIHVzZWQg
Zm9yDQo+ID4gaG9zdC1CTUMgY29tbXVuaWNhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IGFzcGVlZHloIDx5aF9jaHVuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFBsZWFzZSB1c2UgeW91
ciBmdWxsIG5hbWUuIFNlbWktYW5vbnltb3VzIGNvbnRyaWJ1dGlvbnMgYXJlIG5vdCBhY2NlcHRl
ZC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClRoYW5rcyBmb3IgdGhlIHJl
bWluZGVyLg0KV291bGQgeW91IHByZWZlciB0aGF0IEkgcmVzZW5kIHRoaXMgc2VyaWVzIHdpdGgg
dGhlIGNvcnJlY3RlZCBzaWduLW9mZiwgb3Igd291bGQgaXQgYmUgZmluZSB0byB1cGRhdGUgaXQg
aW4gdGhlIG5leHQgdmVyc2lvbj8NCg0KVGhhbmtzLA0KWXVuSHN1YW4NCg==

