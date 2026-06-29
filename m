Return-Path: <linux-aspeed+bounces-4312-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B1C43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 08:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpfHP18hWz2yZ8;
	Mon, 29 Jun 2026 18:16:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782720960;
	cv=pass; b=a7hx7SyvLeBJaJe0tnLVKyoW3BifSqHi727Ec71hJKaWN1vbmYW8+nfSblTYP6WqNu6iAnNRIUSf5cKYR7WASGn4XGrH6WQr2ZKLiXtQh20jzZqOvCoCT+vUjw9AiB+LoScoSG8DEYxGqgJGYXbL7PoByDZtVH7w6z7din3f3dUyfTWBQi/plmp09rXwMWRjKeDl37QtqoJsyLJ1w+r1k8Ku8ZxKCdJEfRWDjH1iEpAv4bw4RvMBaDppC+a1Yz130FWz91thETcamR5Nw+uDgF4hkVMudLgn47b5R02M0TKu3HwiJ85mzpU6x+/docwHH7/HxmV19OOe7FNwPB9JNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782720960; c=relaxed/relaxed;
	bh=D9rPDjMwd5TVOnUZugglriIjH9wIgGYPH56soFebzfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJdJCAm5G/Fns5SuIPIpSNO2doqNpxu8taNst2wZ3lRKWRhbvj2ShgOMkBFOIflkFlUdUUKFT/kuB2AF4dywKsSXuBqYWueQmiMyMr5Bcb8tpjeuj6YpntmGBuR0gYtIXauTpSfxUbreSyrYX5etR1kerQOjpHES5BreUbbtDtWidfXXh0V4En9AH4zDKLjYad/oN9mxmYbvuRCYmHwVybRvAarNp32v4FfSXcgTsJKK3J6neCrn5tEAoALJG2HspgZDLHElHH55LcsAEDdqLWNOk2MKKAnW95tt9i/djovjz5nshKKszFhTVXQxxt91QeZpyMRO2eoNw9c8k1TvfA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=k+bjzex8; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=k+bjzex8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpfHN11nGz2ySS;
	Mon, 29 Jun 2026 18:15:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDsXa3v/h+dcXs5U9SSO6D/moQz/2p5Go+yj5swl7EWhake5qEPOLpIbMDDw+ZjT6UHjUFQyACJpHl1BEEDBnxUMQmy+FNxdx8datuiIsNnemEukHfqdbT7n3CXwEjQ89Xtq91Sq+MUTnaV7OAqvGR2827lZj3i1b4KOvSj5P6GC/zKmxb+5ypjcoK2z81Dy+zgSWarnnoBB9qTS61CjzTE8Y/nD3j0btjFijTHtZGBZnqav9eXn2E/vZ6fYvxPwrh1lVPmsxpVpiIn/AJfaidXPpOrFlyTzf0Eev/kGNUrqiz4MJJUDlTCki4kzc2IhmaWyWLYl/6vz2OUToge43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9rPDjMwd5TVOnUZugglriIjH9wIgGYPH56soFebzfs=;
 b=kENsQ6hjOrEi71PVfK09aOOSV0ujvVGKuGDz/3kyL/ylqnQ6/OaUp567xLVkui4NAP+xLR9y2dNti5O0F7dSzYkvRciZtMBoSKxq2FWfZfnIfUCt2UNHpZq7pk3HX6+++DZt45uaejN0s2YSE4AeO+3Y0pRTcV5my+RAaujm096qoI9xbGLa7e1KuWp7jGykknMdfQ2aFX9Ti8sQ42dRPZJtEAtvTYJrCOKdlyYkgCDyGVHne7mC8QFpvXW0gslyWKG4bRVC4+Irj27jgo32kDh29Rzv7kSGsrCJIBdzl7LLOWGA4OP9eBgAL6CfK9J5WsDwktrFfVUq6b7sVOo3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9rPDjMwd5TVOnUZugglriIjH9wIgGYPH56soFebzfs=;
 b=k+bjzex8oOQIs0cXqyEliLcx9K2i0XBP4eTfAiEprgUE63f9UTueeDz11/1WA5EKAdgEGeTTj6nwU+Dn+4l9/TdAflll3T4JrIA/QPqAFhocYzj8Fe5T+m15W3NP22I0dVT74VwWPfOMOZNUjnm3lqQNoGTaYCmOMRpMq9CTtizVyWQB/llQD8rFseXaKucatYLI5Bfta2nL1t41cADSZAfMshGB5kCDhMH0clrOMI8L7/bvunqz3u0fa+Qa8S8TLoyQjLzp3zvO4rSGynvBJvKhhYow4+rm1iWbhTdW9d4w7sGbJZ8DUNY3xDvgeJIpOf5EC0qoRh9L2f7SWUp5BQ==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by SI2PR06MB5410.apcprd06.prod.outlook.com
 (2603:1096:4:1ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:15:36 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:15:36 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: LKML <linux-kernel@vger.kernel.org>, Maciej Lawniczak
	<maciej.lawniczak@intel.com>
Subject: RE: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Thread-Topic: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Thread-Index: AQHcstFRz8cZq16J/U+sBKwdttKpXrZOQGgAgAeYkJA=
Date: Mon, 29 Jun 2026 08:15:35 +0000
Message-ID:
 <KL1PR0601MB4276C2C831B257898AAB363190E82@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
 <3ab543eb-ca09-4d75-b75c-b8a4c71b2173@web.de>
In-Reply-To: <3ab543eb-ca09-4d75-b75c-b8a4c71b2173@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|SI2PR06MB5410:EE_
x-ms-office365-filtering-correlation-id: 255daaaf-7a32-4b6b-b768-08ded5b698f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|42112799006|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 +H1oOTbFoc4Kz/yGNFDdqjgBnvN5TfK2tiWzLMHWo9+p6h0yXvGsMKOo9H6ha2UpzjvzBRVYY3OIMiy+sZ4p6UARERJ/YwKPaNGxYts+5baW0ei3Qr78mGkqwr1aI2pLPHGo2nkihFS+iS/4Qs64QA0LPaTHURK0lXY1tU8mtsru8wLp20PruF189jNLE6FkRzMiNlxyuwODW3+0Z6BZOoRa/av9kXaQK7h5y3a65mvm0Vs5LoYdGwoXhWujd5KTfbd8rkSKOeiVAiuLmBBwmdfM7XK3ie+C0NSSrjW+91f4TdJ5rB7M23Q6B0etd2uwzbmdwKTMJo7wKKjn0IoxKWsFseq95ppy1xkcdxVjLxi6WzjH6LtJ3bvAE/ehl6y2ZN7RIrTqW5Gf+LPgloCvEL6TIaHKdzP00ESXdBRnmaucmMGisgTQjsPbwvJA7l47BgdvkmmvEXR1gqgftQpJYdUq6Tz7+yGTwBg2DLSukp4iwLeWWpdBDtjlGV1DpD8rme2NoKbIuWFpUvUzx0A/OsR4mJfdWAFxM96Iu4aVrWZSzW9Iull0h6CyO7TbEjM3leUOaVUOxONTuXqhVXkZq1h+1V4QKO7+O+9ctlEvMWDXfyaufMUASblw/fM3ySGzHdEE+kwYu6KZkewRCQBuhs88qzmbw6CjKjJAsCCZ9bV1GxbVMhJWVXlO3M9YhHtp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(42112799006)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUtQZE9UdG5NSVlwQXhwcWI0WUJvcnZEVHRsajY2VFpra2xLbXhya0NLYjQ4?=
 =?utf-8?B?bC92WkMzdnFGVS9IV1FEOUpDNjVIQy94Z3BwemE1WWZZQ2txeVVaTitaTTI2?=
 =?utf-8?B?SE1rb3p3dUhDbTB3aTdmeWxKNEtXRUgxSEwzWVpQcHQ5elBIb3Y4Y2x5VEFS?=
 =?utf-8?B?MTE0N2VNalMzUXliOXZLM0JvUFBGNUE5Ymd0YXRlVVhPLzlXN05JaHlhN2lv?=
 =?utf-8?B?Y3hOcGV0T0R0SFpqV0thWkVZdFZTWnNpK3o4Yys4VGswOHFWWG1YbFQ5RzNL?=
 =?utf-8?B?VXB6L3E2Ykl1ZHFVUC8zamEyaUdZSXFnOWx4MGRGU3BUb3JBSlREQTZQdWJo?=
 =?utf-8?B?ZGRmMUowK0JyeUpWNXE4L2drUW9WaXByQ1RqejQyOVp4RG52dlhzaElBSmpz?=
 =?utf-8?B?OS83NUpOcXVDaEszQkZuKzNLNVdzK20ranJzdXJpRzYySjRJNEU1YWhhaWk4?=
 =?utf-8?B?MnZweXdPYWhLYkVKU0NwLzBidG5zWDZZbUxXWUhaTDI0MnhmMU5pTEh0dWNj?=
 =?utf-8?B?d2E3S0RCbXFTMWN0UlhkTXBWNGl1cjVWdkplbnBKdGJ3RmdSWmdKVnVpNEJN?=
 =?utf-8?B?dUhlekY3dFlPc2ZMUGdIY0pjV3RMYXIwSXJtNHRoTG4wdkR5elVZRjVHdVRJ?=
 =?utf-8?B?M0I2VjVUSWFJaDk5UUxmMmRBa3U2SEZhNWRVeER5YmpmUUdBanRiSFYxLzB1?=
 =?utf-8?B?NmxSNFpFUkExdHh5eHdKSC9sVGJWeFNJZ05HRkhTUWRaZ2txT3RJQW02eFR0?=
 =?utf-8?B?dVNMRjkraDNIT3ZXVE14Z09LcjNxY2h1MC9Sc0VrSjN5KzRJUDBCNWVkajM3?=
 =?utf-8?B?USs4T2RxL04wSmxHR2p6MWljdVB6ekNYSENoNzBaRGh2T0Y0Z29EVWdGVVh0?=
 =?utf-8?B?a3Q2UGFuS0RpRE1hOGk2QjJ5MXlNZE9lUmQyaEZ3L2F2dGJ4WUtuQmF2V2VI?=
 =?utf-8?B?VG01dDJhMmw4MGZZTkZmZXRCK29VYXAxb0hTUGxKb015cjJGSFh3QjdWajdV?=
 =?utf-8?B?SjljQTJOcGNNcW5OMVl5MXRJODVoUFJoWGtnT0xhZVBzT0J3V1RMMElOVGlN?=
 =?utf-8?B?aDlwOVpJWEtkcVVWSmMxajQ2d0dsVGNQTGNRcFFKV1hKMnI0RkIzbGM1NmpQ?=
 =?utf-8?B?YTdWUjMwVUtTV05CdllHNU9VSzF0RW81UWFSYnliODVTakdXam9pK09EY1NX?=
 =?utf-8?B?VUlpa01GN211dTlnZmIwZmx0U1NMais2c3B1cUd6MFN4YWJhbVVEQXB1SDkx?=
 =?utf-8?B?RkMwNUY5Vnhxa1M5S1E2c25lVGFmb1NZRG9yV0crdlhYTnVwZXQxUnJMejJ5?=
 =?utf-8?B?Nkt1eTRmbHRvZU5PcElJdm5PL01qeEdEMHY4NTJsejlHazVXcWFxV05JbTRp?=
 =?utf-8?B?SVdvemM1RnRGRXBtSk9JaUhPYmJudC9SalgxWVA5OTIvVGp5VGdwTW5iRWNj?=
 =?utf-8?B?eWpabnlUWkNPNEtKeW1uL2ZQUWlaWmZla2g4T0d6UzFneUc2RjQrZGRRNUFO?=
 =?utf-8?B?U0RjZC81WEpNMDJSalFiYkUyY3dXc1l6dEdNaEpKZ0ZUTTlaVEdUNU5PeGZH?=
 =?utf-8?B?NEpzeTZleHlhSTZHR0FoRVlybTVqdkRsR2hOZWwrZW1EaURjVmppUnlrSTFG?=
 =?utf-8?B?bUw0N1VueENVSTkzckZZQTMxRmJnNmpERHV0aWEwNkt1a0t6SVltSjBCa3Ny?=
 =?utf-8?B?b3JtQ3VoSE9iQW92c3VEMWNEbXVkeko4S2NJQllOeTRaekUvZ1lITHl4RW1n?=
 =?utf-8?B?ZkVzMGpJUjVmMzY4TmtqaDkxcXhSUEV5N2NnNWZ4aFlVM3c5eG0rM2VWbW1V?=
 =?utf-8?B?QU1DYWkzOXgrLzV1NVVCelAwWUl1bHZSNjBtd2hxR2ZmZEQxOTZnVkYwckxV?=
 =?utf-8?B?REJlRC9PM3FqOWVsdkQxTmlOU3FKb04zejBJempjVGROcnkzaGdGbURXZmpR?=
 =?utf-8?B?QlBjc2J2aVhSUmVJak1iUFRxaG5tN3ZKa0E4RU1QV0crVUxPcE5taVl5WDdn?=
 =?utf-8?B?NG1pVk9aWmdwRnIvSHNnM3lJK3plbHhxS0lDcElmVFd1cW1zRU55MkpuY1o3?=
 =?utf-8?B?L0tzOFdiZVZRK0tXU3hha2Z1Mzc4UUFPUXBBSWd5OUFvNDRoa25xK1NtT0Y5?=
 =?utf-8?B?M2NsTkZVbWVRZ3RocGV6ay9hbjR2V2FadjcxTFdZUlB6clhYUjdCU0gvV1Zw?=
 =?utf-8?B?Um9IWGt3c2RGTlBMVWwyZ0hoZUVZNnp3MGd5cWpLZWc1T0dya25CZG1nV2lR?=
 =?utf-8?B?TDJ0Zjl0NjhES2VEcFpCTHdpY0lWejFaeTZSWXJjVGQ1bjhGRTVnNnZqRm5h?=
 =?utf-8?B?QWZpZU03MDR5M242cS9LdXU5aDQzWlR6clRKTmdQMkVTdTVvcDdsZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 255daaaf-7a32-4b6b-b768-08ded5b698f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 08:15:35.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEKiUs0Fnf+EQr0Xftfw+WdPdtAIk89/NDSSjMdZWKw6NH603yhp49g3agIq8hArJthX07G4xRZblEn8rNf3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5410

SGkgTWFya3VzLA0KDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvYXNwZWVkL2VzcGkvYXNwZWVkLWVz
cGkuYw0KPiDigKYNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2VzcGlfZmxhc2hfcnhfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspIHsNCj4gPiArCXN0cnVjdCBhc3BlZWRfZXNwaV9mbGFz
aCAqZmxhc2ggPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0DQo+IGFzcGVlZF9lc3BpX2ZsYXNo
LCByeF93b3JrKTsNCj4gPiArCXN0cnVjdCBhc3BlZWRfZXNwaSAqZXNwaSA9IGNvbnRhaW5lcl9v
ZihmbGFzaCwgc3RydWN0IGFzcGVlZF9lc3BpLA0KPiA+ICtmbGFzaCk7DQo+ID4gKw0KPiA+ICsJ
bXV0ZXhfbG9jaygmZmxhc2gtPnR4X210eCk7DQo+ID4gKwlhc3BlZWRfZXNwaV9mbGFzaF9oYW5k
bGVfbHVuKGVzcGkpOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZmbGFzaC0+dHhfbXR4KTsNCj4gPiAr
fQ0KPiDigKYNCj4gDQo+IFVuZGVyIHdoaWNoIGNpcmN1bXN0YW5jZXMgd291bGQgeW91IGJlY29t
ZSBpbnRlcmVzdGVkIHRvIGFwcGx5IGEgc3RhdGVtZW50DQo+IGxpa2Ug4oCcZ3VhcmQobXV0ZXgp
KCZmbGFzaC0+dHhfbXR4KTvigJ0/DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y3LjEuMS9zb3VyY2UvaW5jbHVkZS9saW51eC9tdXRleC5oI0wyNTMNCj4gDQpUaGFua3MgZm9y
IHRoZSBzdWdnZXN0aW9uLiBJIGFncmVlIHRoYXQgZ3VhcmQobXV0ZXgpIGlzIGhlbHBmdWwgd2hl
biBhIGxvY2tlZA0Kc2VjdGlvbiBoYXMgbXVsdGlwbGUgZXhpdCBwYXRocy4gU2luY2UgdGhpcyB3
b3JrZXIgY3VycmVudGx5IGhhcyBhIHNpbmdsZQ0Kc2ltcGxlIHBhdGgsIEkgd291bGQgcHJlZmVy
IHRvIGtlZXAgdGhlIGV4cGxpY2l0IG11dGV4X2xvY2soKS9tdXRleF91bmxvY2soKQ0KcGFpciBm
b3IgcmVhZGFiaWxpdHkuIEkgY2FuIHN3aXRjaCB0byBndWFyZChtdXRleCkgaWYgeW91IHRoaW5r
IGl0IHdvdWxkIGJlDQpiZXR0ZXIgaW4gdGhpcyBjYXNlLg0KDQpUaGFua3MsDQpZdW4gSHN1YW4N
Cg==

