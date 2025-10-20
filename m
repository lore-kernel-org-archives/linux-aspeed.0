Return-Path: <linux-aspeed+bounces-2529-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802FBCCD193
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 07:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqmgC6rVHz3000;
	Mon, 20 Oct 2025 18:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760943975;
	cv=pass; b=WFxsTJn1b9SQ74XiijgcD+nUH8WbtHxNfWNCffR0cfrVr5Y+U9l3ofFXn5zzinAHLqQYru8DY766vczUw8bnfY+33pMwlIJtuBkvJfXoqVBk0ppopMXI5xWDRsl67gaZWgikG+y18fDBC38aQuW70t77p+r5UuEbpeM+FbnCZOqiqAjqwp2pTy7lHny+WzC+cxiDNcE/q+HieCnGhgfPHlQ2Ow6B3tYSUftuaFPo/4gwWu1V84vP+wGKpDUPQQCALSTIsErPjfSf6COlFYYZ1JLzMhglSsTlr3q1eWsurIP+zXHVwgCzAc5YzOVtNRc1jePjDqrYFjXJfpVuVw3FOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760943975; c=relaxed/relaxed;
	bh=iWkfjMarv0J1ebZUy7XIfvD+r2NStg286+dzkZr4EX0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ig9zp6AIVpFp1K11giEpVDfDzihDuWnIYmGq+CV+ceq9vzXVx/MhdKIs3TXk83m8qTeJvhF+OyOjYYME1M0Ezyu0yrQS8jf7wgEj6Bzx0OQfD8dZtme5MWb254oCHlw/B454gt9N6CQptQfyn1LBnhxe4Hn5+dSAt5KEcGDj1UDubvZ6SyphtX1fx/nZd3cWn+nghevHh1QFDqki7ZYKt/PAYB2Q4UBmMmqSuJ9JpFTjAvKOn5Mfivu1QEJEk2hUCHTDR3+CNkQ+6qFA1RNBOocukP64bJa7VkV3gQBc5xtXMgoWRZwhdwmUYcbNba2a2IRZuJd4j8IyJuGNPhbCxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=cOZlwrhE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=cOZlwrhE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqmgB6q0Fz2yjw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 18:06:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTNwWwYYcR1Dnoc4IGWTjpjlnOIIBcxbhB4nUWi0EHQ/YHmPUHtTtraRk6amZLld7LF1XpvICD17gVH8p3AKNH1XGKzObwM+g4bBLGm4Z3Y826o7x9X52lZq5JLo+K9IbJafwSWyq8iizVtZAUz0FTsVJ4ua47+DUrmL8lRn1jPHwcwqvzdcRBgxgKIxDAJy/H24GSsyMBchiZUyL3lewMIHFXcW7Upp8Q5CRE6nRJp3ibhMXs3FuUPKhp3qQRwuQKNCJlqHv/r59eU+vwbHR0y4mbiuDJ74RqTX21dn+5C3dGQ+ZjFKeX5BYrktPTeEXTj/eZ9LX2ghnuS4bOw0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWkfjMarv0J1ebZUy7XIfvD+r2NStg286+dzkZr4EX0=;
 b=T9LD+/j712M5WDTM+RJTrVesN5mMy146tGun7PkYyFW0o7C7vOaxTZYkjsbKEdj2t4ylENN8vR6wGqqZelk82BxcxpbHNqkOH7xZpFpzoYWR3nixiJnT/DjneRWFDIcszORdABqQYLD6nT0BpuNbzLpklBfBjIupjoQfygRkLr84rUkyMv7yZw/oMrg1NAx65cmM0PBW07fTLyCKHb96ck3/XrtPq/5Rl1QpYMYz2Hk7xiOaxzhbLOwyiDIhQ0VhKQ9Lu1Zcv8cuSOPwbdqv3LMCL+lmeJ+syGrL5ZSiNLlb3MMxb7mJAMnnHml8Z/xrOvpOyChTlzjkhXsJPqQFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWkfjMarv0J1ebZUy7XIfvD+r2NStg286+dzkZr4EX0=;
 b=cOZlwrhEYXVNV8HOL1yvu9b4AKNrXbvWcHJpFzyH1lgx/OU03G0SK1uVhrEW+YaxYNIyIB8BQ6e1UvgQrbHXRZtljFDxivb0cAfTf+YYNd8I3sm0OVHuPN+jADwnf5T5bzWQgbCsi4HVBeEfrfFyaQWYDAK97Ad3kYKEzWBbn+gFFE7iQ75Jr6Rkq4XfLkuiDxb0jnge/86/GyiVubwL7OvyYd+mBL3oNWTyqkJT7u9i22IT8jf7mMK1ohryjhCKfocoJhEvS1nA/DZja6cK5a09V8NHdK5P6E+T9ACk6/vKiQEZqw/iTuTMJ2/bDcOk1BKUaGQywRbtAK4HmEcXew==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYPPR06MB7970.apcprd06.prod.outlook.com (2603:1096:405:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 07:05:49 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 07:05:48 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Topic: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Index: AQHcQWZVHXgbRjt/U0uvaTyLW9Dz6LTKj6aAgAAA+wCAAAUvAIAAAXyAgAAFsgA=
Date: Mon, 20 Oct 2025 07:05:48 +0000
Message-ID:
 <TY2PPF5CB9A1BE65E96ED9C3CE0E8C7A53EF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251020020745.2004916-1-ryan_chen@aspeedtech.com>
 <b38321e8-d243-460a-a9d6-6770a41627cd@kernel.org>
 <TY2PPF5CB9A1BE6CDC6F04CC0F472FE6451F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6b30c646-cc52-4552-8311-86974c1459e7@kernel.org>
 <e7fec714-aa68-49a1-85e5-356115843307@kernel.org>
In-Reply-To: <e7fec714-aa68-49a1-85e5-356115843307@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYPPR06MB7970:EE_
x-ms-office365-filtering-correlation-id: 4202a319-7a88-44c7-b25b-08de0fa71917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnUySkNaZE1UdDM3cjhtdHgzS3BJNUwwY1RvcGl3YjVuTG40NTZkaUs2QW5q?=
 =?utf-8?B?SlI3MjM2bjRicTF4MGE5dWxJSDlHS1N5TTJ4bG5BUUFxTm5xMVQ1ODViWlJJ?=
 =?utf-8?B?M3RXdjdmS285SXM1VjluZ2FJdTREcnVHek94a2lIa3NSZ2pJS1JkeWFydmxk?=
 =?utf-8?B?ZHlGeE8zeGhXUUhhSXdEZjV3M2tIdHBEZDZ4bjJvQ1l0clY2cURiSWV2MmRH?=
 =?utf-8?B?UFYzd1lNMkljcXhvak1Vb0dkK2JqbjNDRHkxNGZMelFWTEIxNDg2ZGxEUXZi?=
 =?utf-8?B?cENUejNFczVrZGpaYklRNWhWZzUyT1pyTE5FRXUxWlpGV3ZaRVNUQUtVVjZu?=
 =?utf-8?B?VENYUjVDY21FMFR5Z2cvbGJmRnhTcGI1WFRDVjNScmNYSlBpa2FaUTJJd0di?=
 =?utf-8?B?UlN5R2x4NDErVjRGUERWYWhqZGxwMlVZSlp2WmJOdW10TjY3UTlqU3pabmZR?=
 =?utf-8?B?QzVVOWY4SjZDM29IemlwMDV2bytpYmppaS9ibkdKL3p0YzFjNHZHalVPWUVK?=
 =?utf-8?B?ck5yM2lmRkxQeDAvQjZPZjd3emlLeU9mZU14S1k0RHpSS2p3QU10WE9hamc1?=
 =?utf-8?B?VUpGVE1SMUdVOWpMU2RrRms0U0VIdEQ0My9jcGFIdDZXdi8zV3NHcXh0Smtj?=
 =?utf-8?B?VG95eTk2UWs2QXo3Q3ZsWW5iQnFrcmFkREFhZjdXVGdxbElFRlVjT1pRMmhZ?=
 =?utf-8?B?TlJoM2NlVDhZYnhwbU9ISTVELzFpVXJ1YjBSOG9LR0d5bGZBd2trVURPRkFO?=
 =?utf-8?B?cFY4S1Z2bzZsTzZpdFZMclFmbDFoT2N3RzBUREtHaUdUNDBmSlNDUzN2T2gx?=
 =?utf-8?B?OTg3NDRtSVNTVitEYnVjSXhTSFZKbXlhNWlpL2xZRmN5NTRGUFBWdElJWXVr?=
 =?utf-8?B?dkNoUmpUZTByNUo4ZnZrL044OUN6LytVcVRaL0FZY2dOemNkSkROVDRYZmY4?=
 =?utf-8?B?TFBoOC9Pbm9YbWF3ZTNrR0xuc0dvS05CbytRdUw4cFd3ZVVqWnRQMkpUelNp?=
 =?utf-8?B?T3hHb29JUFZmbGZ4Z3A2dGJlNnJlQWY5cTJzVWdhakJNdHpCNWNQVXdHTjZK?=
 =?utf-8?B?VDhwNElFRWcyVUVaVVBJanprZzBYeFNEZC9RWEIwVkovcHFVanh4TWJhV0o2?=
 =?utf-8?B?cisrRUZiSVViLzR4RmU4SHFiUkQvM0tJVTJjdkdnSmgraEt1UURmeXVBL1hy?=
 =?utf-8?B?Qld1MThhS1VGajFkUEl3MGMxcmdxTmt3UkcybHM4d3lncGtobWNqUys3aWhh?=
 =?utf-8?B?RFZaendsVS9XVzFyL1VLNkt0cXVlb0tNVEFTcWlzZHRVeENDQW53R1JIM3o3?=
 =?utf-8?B?MVd0dlZBSytNbHdVTnlMZjJGZmEwRUtBSWxXUXZEYllQZkpQMGxhTTlubThv?=
 =?utf-8?B?Y0xvcmZrQWkzNTA4UGp5RkJSSE9CZng5cERlWU1MZ2ROM0prWE1Wc1BKaXpO?=
 =?utf-8?B?NVM2ZEZra2QySlhiaXVGdG1xUVZYaU95bVZxT2lHcEdGZG5nNExac1kxMERN?=
 =?utf-8?B?N0tVc05TdW9LdFNjbUt5dnRzZ05ESDFwY2FNV3N6aGZ4NW10UnM3SFNteHdL?=
 =?utf-8?B?SDFpWk1ucy93cEREblE1M2hBRDJ3WUp6cFVkMU9HYysrVzdUdlFOV0EzZUww?=
 =?utf-8?B?S2NSNlMzcXAyd2EyU015Q1dsbEJyM25saDZIa1RlR1JvZGJ2WGF0OU1MbWFG?=
 =?utf-8?B?L0pxSWdiSjA0Zm10Qjh1SW5qK0tZQU1KWllRQ1duWVNMMWdSWllnK1BUVUIx?=
 =?utf-8?B?VS9JbGF5OXZ2UnZzSEJhR0RoeUZRZisreUVzZ1J1eGZia3BmZkwvVkVaSkxk?=
 =?utf-8?B?Uy8vUGdnZTdwd3F1WmJ6b1plbUZJOHFYMUNMVlVBTWVRZTA1YXArcXMxUExX?=
 =?utf-8?B?SkRkOWIzM016ZUV6MnczRENnMXlPcGsvL2dKRW0yd1QyMUlPVUdEd2Y1Nzk5?=
 =?utf-8?B?dXhTWVZTTWRXMEF2bStZdG84MDlzeStGS2wwbEdadm80RkVzY09Hbk9oeUpB?=
 =?utf-8?Q?EMRroz4gnmFr6ilcfoDAegWx/FzLBs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEk0UHYxeU9NeVZKSFlmS2JoY0FnOXN2S3dFMmFPNFpQbzZpNHhjdmtzU2dZ?=
 =?utf-8?B?Smx6bGgxZWJJQlBHbDlPdlJlMnVKVDREMmw4dENYRUcxTk5hRFg4c29DYURQ?=
 =?utf-8?B?VmtRTHRWUnlvb2hhcFc3QXFXNThlWW42WkpXWmxiQzdiSUlYTjBMbmpNcVV1?=
 =?utf-8?B?bjl2Y2dydkpONVBUdS95M3dsc2pVc3NIUXpVZ20xZXVma3Zqd1lLNG5mYUxI?=
 =?utf-8?B?ZjJaWE9UZ1VZQ2NrUkpyRHg1NDVWOXFzRXlTbTNnSlFFS0pUTWgzejR4akRx?=
 =?utf-8?B?dlBQZ1A3emtwRmdIOVJyZmdOZ1UxL3FGUDNPWkMxRWxzeEo5a1lRY0VQcG1R?=
 =?utf-8?B?RlFYdE5jOVBvSTEvaStoaHFQaSt1akJCSUJZM3BvT05OdEI1R2pURUtqSXpY?=
 =?utf-8?B?b2wwNktwRTlqL3hXV2huOGFTSGFBTVBZM0N2ODJHRWhzNUVrYWV5UFZpUDB1?=
 =?utf-8?B?TGFUSEVUUmRLZmRCeTBVdmxtOUNVODR6M3JXbm0xWCtTUnplZ3N3YVlqa1ls?=
 =?utf-8?B?VWFWVjdZTTVlbytQZTJVV2hjcTlBYi9CV3RSN2o3b0pVODhXUEJVUVZlbVdF?=
 =?utf-8?B?aUt1bXFjelRPVjFNVzdKL1ozNEhaSmNGbHM0TUdkWW16dkd6TXQza3lNbzZ5?=
 =?utf-8?B?YU10eTc0ZkR5bWhSVkxzV2dXemZET2VNdVNpVTB5eFBqNFFmNllEaVJmeFkw?=
 =?utf-8?B?dnloSmpoYk8wbUZ2QkRNN3ZzWE91RFhaRE9LTEt1U3BCLzlGcG9ZUmhPZC9E?=
 =?utf-8?B?enhIdC8vNnRqMFhmMVE4QWcyYlZFcUpWblE0K0VHM0V3U28zL1JxYm94bjJN?=
 =?utf-8?B?bkl2a3lScUN6UDR5VWlLMCtqVmpxQ0RQY0J5dVowSEF3ZEQ1bzlIYUxKS0tq?=
 =?utf-8?B?NTY5cjlUZE1Td202MHQyNnMwbFdmR1hpUlpYUEcyMU5TMm90K25JcEFkeUdu?=
 =?utf-8?B?TUptelA0R0MwbjdwL2pJejdGcjlseEY2c2JKcm9xV09nSUt3dUd2YzZVM3lv?=
 =?utf-8?B?dFRCTGthYUxDbWovZjAxZUJEYkRjWFFxV3hneGVhR2d2akswaEtKMFhhWTlO?=
 =?utf-8?B?SHMxMEFSYyt1NVA4cklXL1cwNlMzU1VZKzZxM2dSeU5ubFRFckdFcWxYQmY1?=
 =?utf-8?B?STNhdG9rZlNDWXhta1IzQ2JOekpPd0ppM1F0dWJzWHE4S2pabFR0aHYzWGNz?=
 =?utf-8?B?LzYrNEw0Wlg4U0ovZXg4N1o3UmhWNEpKRU1DVDNzRER0MGpmTnl6S0F6a1pQ?=
 =?utf-8?B?dlF0L0hMN0g3Tlp4YW84L05WeG9mUHB5SVlIcjltUlV6aWZwdzA1WTV2RHRX?=
 =?utf-8?B?K0pJSWM4aVRueitpdHN3RzRZdVZmUjlHK25Jc3ltcytjcWo2OWxtcEFTZnhF?=
 =?utf-8?B?N2MvNlUxOFZxTVZuK2J6Qlk1anR3WTU3Nm9VU1RXVmxTZ0lBVlBZTFRLRVRo?=
 =?utf-8?B?d29mSHRZdURLVWQ2SzVhejN2aE1TRzE4eFhDQkdnZGQyMW8yOXBwbndTYm5q?=
 =?utf-8?B?WG1xcVIrWlF1UElLVzI0ZVJyZmE3bW1aTXVHTFVQckd2WjlJODFSTE5DTGJH?=
 =?utf-8?B?SjFMaEFtRUVIaUtNUjRvTHRXSlBWSnVleE1QdjFOTEtIa2VyNXRCMC9heFZ4?=
 =?utf-8?B?QXZoVytvckcxSFR6dWZUVFpvb3RzQnpLN29uK1R4RjNZZXdlRXR3eGJlVDQ4?=
 =?utf-8?B?dU52L3NVaVVpSEVRbEJGaUZEbWdCQVBBR0pNM3ZEZlVDS2cwS2pmZmV1RGp4?=
 =?utf-8?B?RWxvMzNUZ1NTMmd1QkpUSlY4VnpCL1lIdzZHazM5UGcwM3picTlidi9vQlVZ?=
 =?utf-8?B?MnBHTXlIOVJTOFBDblUvUUFrM0tvcThnSVJSMUR4bUNvdU9tRVFwck5nTGRM?=
 =?utf-8?B?cURIQVBwcEt0YWNWVmNDSXArZjE2QnRpejEyZ1hiWFJTdHhUUk8wcUFoSm1o?=
 =?utf-8?B?Umovam9aaGNYQXVPM2l4STVzMjgzRURYS0ZsTnZZbFJiNTVaZlRnK3ZnUlpY?=
 =?utf-8?B?STNLTmExU0Z3NHU0LzhhV0twcVoxRmwwNllUTlhPSXA2WGFIS2FDdmFneUJo?=
 =?utf-8?B?TkxmYTE4cklxR2R1U2JkWk83R2p2VkpnQzRGMkhpTHdJWjNBZlpmdFBYVEU0?=
 =?utf-8?Q?MCHf5jGQJWgVEZrWxn2dRt2rD?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4202a319-7a88-44c7-b25b-08de0fa71917
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 07:05:48.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E67pzzjMKgqmWLxj/HYRQeOWKncz0hlCxQsi71A7+NxjE2vRdPMp5GBrZWLofoDP6HUnLQ69+3KY+qKDYhnrebQsZqSnqXEKCfj8Xgzu1S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB7970

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogbWZkOiBhc3BlZWQsYXN0MngwMC1z
Y3U6IGFsbG93ICNzaXplLWNlbGxzDQo+IHJhbmdlDQo+IA0KPiBPbiAyMC8xMC8yMDI1IDA4OjM5
LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDIwLzEwLzIwMjUgMDg6MzEsIFJ5
YW4gQ2hlbiB3cm90ZToNCj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBt
ZmQ6IGFzcGVlZCxhc3QyeDAwLXNjdTogYWxsb3cNCj4gPj4+ICNzaXplLWNlbGxzIHJhbmdlDQo+
ID4+Pg0KPiA+Pj4gT24gMjAvMTAvMjAyNSAwNDowNywgUnlhbiBDaGVuIHdyb3RlOg0KPiA+Pj4+
IFRoZSAjc2l6ZS1jZWxscyBwcm9wZXJ0eSBpbiB0aGUgQXNwZWVkIFNDVSBiaW5kaW5nIGlzIGN1
cnJlbnRseQ0KPiA+Pj4+IGZpeGVkIHRvIGEgY29uc3RhbnQgdmFsdWUgb2YgMS4gSG93ZXZlciwg
bmV3ZXIgU29DcyAoZXguIEFTVDI3MDApDQo+ID4+Pj4gbWF5IHJlcXVpcmUgdHdvIHNpemUgY2Vs
bHMgdG8gZGVzY3JpYmUgY2VydGFpbiBzdWJyZWdpb25zIG9yDQo+ID4+Pg0KPiA+Pj4gIm1heSI/
IFNvIHRoZXJlIGlzIG5vIGlzc3VlIHlldD8NCj4gPj4NCj4gPj4gd2hpbGUgSSBzdWJtaXQgYXN0
MjcwMCBwbGF0Zm9ybSwNCj4gPg0KPiA+IFNvIHRoZXJlIGlzIG5vIHdhcm5pbmcgY3VycmVudGx5
PyBUaGVuIGRvbid0IG1lbnRpb24uIFlvdSBjYW5ub3QgdXNlDQo+ID4gYXJndW1lbnQgb2YgcG9z
c2libGUgZnV0dXJlIHdhcm5pbmcgYXMgdGhlcmUgaXMgYSB3YXJuaW5nIG5lZWRpbmcgdG8NCj4g
PiBiZSBmaXhlZC4gVGhpcyBtYWtlcyBubyBzZW5zZS4gTGlrZSB5b3UgYWRkIGJ1ZyBpbiB5b3Vy
IHBhdGNoc2V0IGFuZA0KPiA+IHRoZW4gc2VuZCAqZGlmZmVyZW50KiBwYXRjaCBjbGFpbWluZyB5
b3UgYXJlIGZpeGluZyBhIGJ1Zy4NCj4gPg0KPiA+DQo+ID4+IFRoZXNlIHdhcm5pbmdzIGFwcGVh
ciB3aGVuIHZhbGlkYXRpbmcgdGhlIEFTVDI3MDAgRVZCIGRldmljZSB0cmVlLg0KPiA+PiBUaGUg
U0NVIG5vZGVzIG9uIEFTVDI3MDAgaGF2ZSBzdWJkZXZpY2VzIChzdWNoIGFzIGNsb2NrIGFuZCBy
ZXNldA0KPiA+PiBjb250cm9sbGVycykgdGhhdCByZXF1aXJlIHR3byBhZGRyZXNzIGNlbGxzLCB3
aGljaCBpcyBub3QgYWxsb3dlZCBieQ0KPiA+PiB0aGUgY3VycmVudCBgY29uc3Q6IDFgIGNvbnN0
cmFpbnQgaW4gdGhlIHNjaGVtYS4NCj4gPj4NCj4gPj4gSGVyZSBpcyB0aGUgcmVsYXRlZCByZXBv
cnQ6DQo+ID4+ICAgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjUvOS8yLzExNjUNCj4gPg0KPiA+
IFRoaXMgbXVzdCBiZSB0b2dldGhlciwgc28gd2UgY2FuIHJldmlldyBlbnRpcmUgcGljdHVyZSwg
bm90IHBpZWNlcyBieQ0KPiA+IHBpZWNlcy4gT3JnYW5pemUgeW91ciB3b3JrIGNvcnJlY3RseSwg
c28gcmV2aWV3aW5nIHdpbGwgYmUgZWFzeS4NCj4gPg0KPiBBbnl3YXksIEkgbWFuYWdlZCB0byBm
aW5kIHlvdXIgb3JpZ2luYWwgd29yayBhbmQgdGhlcmUgaXMgbm8gbmVlZCBmb3IgdGhpcw0KPiBw
YXRjaCBhdCBhbGwuIFlvdSBkb24ndCBoYXZlIDY0LWJpdCBzaXplcyB0aGVyZS4NClRoYW5rcywg
SSB3aWxsIGtlZXAgI3NpemUtY2VsbHMgPSA8MT47IGZvciBteSBuZXh0IHN0ZXAuIA0KDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

