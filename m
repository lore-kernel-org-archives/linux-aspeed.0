Return-Path: <linux-aspeed+bounces-4174-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4539CD6E4A
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 05:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVblV63bkz2ySl;
	Wed, 03 Jun 2026 15:26:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780464374;
	cv=pass; b=nsWGumkyTltSOpN5+qlLfdrTuxrHO3aDqzDoXEcIZJSJg+C9nrpYk/6AntY0XwfM3rclaJ2OL4KMxpMeXcPJ8aSpjMAxcACXtNQZJpTuqQ4kHWVy40329WFyTZtunSZkxuyS+IsoI56lkip76SV3+NvOCLbCMN2//ieq4xuagbXgjDkWjM+QLQlkYDDoID2dWvul+lHN8bXTa3rzh3SWUw5d/fYaqilq+558/ecduYfnYZwHwYANnVRXv6cH6lYzE6lhZkgjmXJRr/cpQZaNuTwFiKT1DQZ1ap4VVq9tgQKEVcr0i3qNETsu+5NC8Es8R0uAXn1PJvxzCxdaU9WPvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780464374; c=relaxed/relaxed;
	bh=Npcy15CwlFGqUCqFvVVzRgWDhCtiKeLW9P9x7xp4f78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMoGEEexpKoHmXMA6EKHReqP4OU4zqL+d/o7KaENgeAjKONwmH7VC9w7tJv3EbLsgJVKxT+QKxS0bwlkgIDvBzKZctiOq1qKEKFcNusJy5aWU0v7M7jcJ0P9pUW/mOfmeuAHgDV7/tpNsm7YybWTbI6jiDBxKeoy4C6tQ2NYDBdYU6taRQ/M+nmZI2cA4d4b7rA97LhD8S/3yvKSGBacS8b0kOtZaRiN1P1JR1P5M7l/5GQtYP62M0mdNc6/+5k/IhPkfbUdAuBClfVOMHWt1VKzwVRNqGt/nWa1Um3mxhyDoy8+1PEUTGVZZRcZxwskrcRiZxLvcC854GJ+OtdJuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=QtKKqKsK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=QtKKqKsK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVblR70SWz2yQH;
	Wed, 03 Jun 2026 15:26:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVl9I2654JsFhFezVddM3P5xbzMNxdML+fcl18KoDIva+JFdk9M6sKUmvhSiZWOozrxgT6t7+s8+QWSR7S/MHBE8aOga7q5ZNbfux5JSezZ5vUUzaTqzp9FcE/VdbseWfOB7/xa9Jx302tcXB90v1VGXMGP9JAIIZZm6AazW5DpQ0Y81aCNJ+sXQaeQRvL10qUzU/IaRVNqFqdniD8SaVaoRN+Zo2J+PkkxifvUY01XObUfTas+AtKwhjazJj3bMRgbvCAHjuppVSRKEc78KKEC8I7HlG20qHmqs58zGSZ3OBZC/NliC9qhtNTr6Z3r+BnyTYWSPtPhxt45AmQPNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Npcy15CwlFGqUCqFvVVzRgWDhCtiKeLW9P9x7xp4f78=;
 b=qQRTIcwL1FNc0TZDPkT7XegWEkUYHQjJnfa8CoLLmhLAEkSzmSJye2/GbW+d+BGeDIYadjzUTci2SBIyQDYjykjXKV+IbLWY7CLgIPs5T+wiAxbUzwOBcGFtqRyhzFNiAqQRzV8qL0OZ6qchUi00fVh/UYcw0H13RWs0HIAF/rwaASPrKH7tlmR1e6Eh1DT9eyUM61Eb/SO+DlC70EMRcTwUVTHFsHj62vqphgam18gksEYl31PGv7kN/V7kKgmu2ElB56qucJL4Yctz0vetJhNJYLKllwcbV8lmTjIsJQ6mxSVsSDWw8Ytk2UF9BZhEaDaooHC7U2QgM5Jq2s2n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npcy15CwlFGqUCqFvVVzRgWDhCtiKeLW9P9x7xp4f78=;
 b=QtKKqKsKW81+7MZ2ijo0XAWIYYDb1N8OVejvmzQUo7rPjfA0QkYnj09RUDNsJqOCH5neUtecVwcBWqsI4GjNI2gqzohdNw8+1zq3S5vHrHJE8I0orTn/cLqEawEEznkbVrA29sco/Bjxb0/p9c6mMlzIjTLaJ+j2cSOuXqToPUUoXh04/Y7DFrt4zOQ7bpuDuDgSidDsmqETLuAeLLqjHUGJhfa42FsWqcUKEMH76dXrloZ0lOB/N3vea8Z93pNdhQnGRJ5af98EA+G00VV1HQ/NggDAKeSV4jJWqytnY9AZ5dvcZl7RmPgPXzXe/zwMO7mkcXunQ/ixey2xDJObcQ==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by KL1PR0601MB5727.apcprd06.prod.outlook.com
 (2603:1096:820:b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:25:45 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 05:25:45 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: YH Chung <yh_chung@aspeedtech.com>, "Shulzhenko, Oleksandr"
	<oleksandr.shulzhenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>, Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Topic: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Index:
 AQHcstFOqEOl3ItXl0mr3midS8GMZLWsphAAgABXFACAA7sEAIAAT9LAgAF5RgCADH1X4IAAILCAgAK7OMCAEYY3UIAvrvqAgADtghCABnSAgIACyQAAgB+RCFA=
Date: Wed, 3 Jun 2026 05:25:45 +0000
Message-ID:
 <KL1PR0601MB427611075A25374BB2A3D8AC90132@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
 <c3b28ee92fa46700887d0c68b23045b2418358a7.camel@codeconstruct.com.au>
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
 <KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <14870d17-2471-4522-b8b5-03cb9002a4f7@app.fastmail.com>
 <KL1PR0601MB42763DAD359305DEBA4B769D9057A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <KL1PR0601MB427603A6A5768D6A537CAFCB905AA@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <b1d56feb-9847-41b1-8bba-733963055cae@linux.intel.com>
 <KL1PR0601MB4276AB799EC03BB00C4C0E5490392@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <be4f662a-b986-4b4c-8263-2fd7b63c238a@linux.intel.com>
 <KL1PR0601MB427604A7136947D020CF272D90002@KL1PR0601MB4276.apcprd06.prod.outlook.com>
In-Reply-To:
 <KL1PR0601MB427604A7136947D020CF272D90002@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|KL1PR0601MB5727:EE_
x-ms-office365-filtering-correlation-id: 44e548a1-589d-486b-58f4-08dec1309045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|42112799006|366016|1800799024|376014|38070700021|6133799003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 gsW1GM8HPOoJbEWAf4k+wdpxuZ5eTS1q348irEdzpwJxBlQHmrwt89yTh/7ZqlfnMi8X54fGSZR30C/MvNW3WiSj/Pj19NpmQFTqI3zYA/P1HlKq5swHd6OsLH+XhXkHAaGduwx4TmF54HBH7kD+WNmagraP9/zrrLhsYV4TNJyi1l3p0L4aABtOCPQQFsCRBuKA3PxT+eVhQjz7yodR24jS7pVE4f1Hao8HjnV9xtowHspqJWIIQUUsbyttCttaCEgjK0hG1DtL0oBYjA+Sad0zSfVJSiG4SPE71ohb/527u7Ge69JC/TQrsz08rdqQeCGnzrDqtPQCb/U6/gM8kqdY45Smxh2DZGDE1K+CjhPj1NOkV8Wbj+JK2BIx6eELZhBSfPOYdy1V8p6wZuO0oNztMzmkyOY3yceYFhxW/pf8vI55+ktAJ2/AIttWUZGXe5i81EW4Gj+pKXiWsdnRy/o4WTxS0YHmFSsRJWkArvh1ldw4FL+yn03MMtaOKdUMaV1U+cWU0u5PvmHYo8RYg497ZGDyj5x3xDlj0ktoCaoUk+ryuu1KSOmnXX5kLFfsMMQfLvHOVHGEBgs2mHw3hqoGkXo8/vmqv0BeKdCaTTbRjZGe/GjBnFKhxMy+vQttiTRXzrOkbXFHoxZ7koDS2SnGjjiTZZqfyEy75M0/GQRuRFbv5ehwwyxhYcBHncPp0ysKxWbzFJLIzrANbU7gucsG+Zc7vIBJFMZt4dNqqXYTE1yX/Vy1ikH6adoj+iU1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(42112799006)(366016)(1800799024)(376014)(38070700021)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTRsazlNSkU5V0VnbEpwQWVxWlJ5Wldzdk1rR2VFRFhjdW5CTTBjOFRJTUlh?=
 =?utf-8?B?TFVnME9VejZzSGZtUHphd3B0ZW1seTNaL21CeFk1S3JuS050VGg5NXhBM2ho?=
 =?utf-8?B?M0txMFlhNnBjazhLNk5NamJjQVluQW03U216NkZ4ZkM4UmkzZ1ZaT2tXZUVJ?=
 =?utf-8?B?YzJJMTJYeXpGcnk1YkkwTjhjTENWV0tCZWZXVTJDT092Q1JCcUF5cDBZTFZ1?=
 =?utf-8?B?UHR0YVY4MXFYSjMreVJEVGJNcGwzLzhEZXlKbE4vOVJJdGovR09KZ3dRdFpj?=
 =?utf-8?B?N3l3WUUyYkRBZlhNSUNCZUpCRTVDUWxVa3dDNDZJSWpWNExOd3JLcE8yNDV4?=
 =?utf-8?B?dlhWWWRWNHJyS05YdXNxbHUyZUw2Rm4vQzRDMTlXSTJpakNoMy9pbVVrWTNP?=
 =?utf-8?B?YUdMdGhpTnNqeXVKbnFTK3RjbU1ZTFg0cytDbkp1WWE4RmV0RW0xb3RyZ3JE?=
 =?utf-8?B?Z3BjZ3lKTURudW4xVGZvYjEwbmNsT2ZHRFVocXRodEl1Z0JnRWdmNGxxVlRM?=
 =?utf-8?B?YTZsd2RDclIvZk9pdTJld3EyZXdiQVVORFFwS1cyaFJ1WW13VTZQTG5oSDFo?=
 =?utf-8?B?bTBlTk9iZXhoMU1Sdk9KZWdCOHNXcXdWOTBLdVBCRGQ1RjJtTnlhUW5STXdL?=
 =?utf-8?B?NzRGUHZ4RUw1WERhS210WnVjUUpKemxtZDdJQW90RE5paDNMME1HRUdqSE81?=
 =?utf-8?B?Z29VbTlaOTA1RWlGN0dsbUNnR3VwemprYWZyYllpS1FsZ2VjYXhhZEZrZUFp?=
 =?utf-8?B?cy83YWVlR0pSQkdZOWlpT1BxdjZWSDVER0VNdUVUN1RidXpackJZRnhEVTZq?=
 =?utf-8?B?YVoyUk1sZ0ZZQ25oUzFEMUpjK1RMNjlrdGc3Vm12M1kyY2ZNaWwwbG43K3Fq?=
 =?utf-8?B?WU8yb1lHcUhaWGxFN0xseG5IRCtjSDBzdVcvMmpMc1pwOWJML2I2eWlGOGFz?=
 =?utf-8?B?a2VqMzMxbUNhZ2R5VUhlaHEvNE82R1ArekNqdkpXQlFZemFSSk9uRlM4UFNy?=
 =?utf-8?B?ME1CalBXSk1FaDFqSnc5a09aNDYxS0pTajVuTC9iYkJlanpVMEM4eUhMZi9R?=
 =?utf-8?B?WDN6dlBRenpHWFBuMjFZTE9IRVN3UlJzMWlaTVVTOTNqUTNscVNFcitsdDBR?=
 =?utf-8?B?SnV5RllkSWdpZEJ6K2hCSmM0UmJIZDI2LzUyRUl4RS9sMWtpUTEzU0Q3azdG?=
 =?utf-8?B?dktlS0t2UTk5RzFqaGdEVTlDcDlZd0luOG5FSTYxNElCbVdHNWpnanJ2dmJn?=
 =?utf-8?B?d3RCYTQrdVI1M0hXVTdUNzMvd1hSeWd0a0ZHNno4QTB3L2VzOVFTdkE2Z1ZG?=
 =?utf-8?B?NzZvZDhJR1NiVjh2Vi9qN2tJNGtPRWlYd0NFRFVjSVljYWIrVFhabEdVUXRJ?=
 =?utf-8?B?d0N5VmdWVkJ1Vzl5QzRHTjQzdWRueUtNMGxFa09sR2hOc1FFRFU5SlBXdTNh?=
 =?utf-8?B?U0YzQ1ZHUGQ2TTV4QkhMSzVNNzBHV3M5REVmUmJhVVJyMElmOGJXbUlnVnF2?=
 =?utf-8?B?bkg4aTBRNHBSSFdSWW1GQWlmMGx0WTV3VU5pNnBOWWlwWnNrYUZwN3dDYUtN?=
 =?utf-8?B?VmNac3NiZVBvZ0s3d1ZaeGtxdkc4OTdBWTUyN2ZaMGt0SWVLRHVOSTNRV3ZB?=
 =?utf-8?B?NGNub1oyS3NSTmJ6S0VIdmxkOXR5dUszaUJaMEJHK3ZKVkF4VFlLczc2OHBC?=
 =?utf-8?B?VENrZGI2cFp2bGZKbGZycUtsUHFQQ1M5UDJCdlhBc0Q0TEw1NVZ3eEI1THdk?=
 =?utf-8?B?RjVvU2prWnRBY2tGQ2ZtRmlDdEhyQi94OVFBRkdNZmtGYWd2S0hvMGJIY2w1?=
 =?utf-8?B?aCtuYlVmOTBpeU1WK0lWSXFrMHlGRWdoeXhGem1yTHVWYkpPYkVCRnBhbEUr?=
 =?utf-8?B?L0ZncEE2K3pXNVZ0M1d3dVBza3pCTEE0Y0gvcTI5TU5PSjRrdk91QkhJZHZi?=
 =?utf-8?B?aTRJekVKdDY1LzFBdldHcTRaQllzZVZ0YkJaWWdEMnpLa2lIRkp4YTVWRzdQ?=
 =?utf-8?B?c3p6aGI4WkhpenpRNXQvdFh4QVZsaHNZdnNzVnc1MTNQRkxuQWlyZEphcXFn?=
 =?utf-8?B?dFNrMmRKcVN0Ny80aVZqcUpzd29qN1BlRDRkU1RQS1R1MEZBdkt4QnYwK29m?=
 =?utf-8?B?Mkd1TEdvZHlORUhjQVl1UEZRT0V0RjIzcU5rcE1XN0VXeW82SDZmVGEwamxD?=
 =?utf-8?B?UUtlc3lHMC9VSjlQTklIOWtZRlQ1cSsvWDNGaXRUeDh2MkhKd0R6RmdPZWlp?=
 =?utf-8?B?U3NUa01ETFVPMklMTDFCcW9Fa0ljdnFEN3hnb0VWbVBpZW1aanVSU1lOdkFB?=
 =?utf-8?B?N3RBcjdxRWRPYjlBa3FPTkdyZXpZWnFrVEFWUGJBRXk2V1QwaGxndz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e548a1-589d-486b-58f4-08dec1309045
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 05:25:45.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACF2JSruT+rRjcT53CA5rNxV3ccslxaflGCo+IFUJwHcj97xta9QwDuue1TVnJXwbUxgYOHoersLxMi4MgoXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5727

SGkgU2h1bHpoZW5rbywgQXJuZCwgQW5kcmV3DQoNClBsZWFzZSBhbGxvdyBtZSB0byBzdW1tYXJp
emUgdGhlIHBvdGVudGlhbCBhcHByb2FjaGVzIHdlIGhhdmUgZGlzY3Vzc2VkIHNvDQpmYXIgZm9y
IHVwc3RyZWFtaW5nIHRoZSBlU1BJIGRyaXZlcjoNCg0KKDEpIFJldXNlIHRoZSBleGlzdGluZyBT
UEkgc3Vic3lzdGVtIGFuZCB0cmVhdCBlU1BJIHBhY2tldHMgYXMgcHVyZSBzaWduYWxzLg0KKDIp
IE1haW50YWluIHRoZSBkcml2ZXIgdW5kZXIgdGhlIFNvQyBzdWJzeXN0ZW0sIHNpbmNlIHRoZXJl
IGlzIGN1cnJlbnRseSBubw0KICAgIGVTUEkgc3Vic3lzdGVtLg0KKDMpIENyZWF0ZSBhIG5ldyBl
U1BJIHN1YnN5c3RlbSBhbmQgcmV3cml0ZSB0aGUgZVNQSSBkcml2ZXIgYWNjb3JkaW5nbHkuDQoN
CkZvciBvcHRpb24gMSwgd2UgZG8gbm90IHRoaW5rIHRoaXMgd291bGQgYmUgYSBnb29kIGZpdCwg
YmVjYXVzZSBlU1BJIGhhcw0KY2xlYXJseSBkZWZpbmVkIHNlbWFudGljcyBmb3IgZWFjaCBjaGFu
bmVsLCBhbmQgb3VyIGhhcmR3YXJlIGV4cG9zZXMNCmRpZmZlcmVudCBzZXRzIG9mIHJlZ2lzdGVy
cyBmb3IgZWFjaCBvZiB0aGVtLg0KDQpGb3Igb3B0aW9uIDIsIHdlIHRoaW5rIHRoaXMgd291bGQg
YmUgYSBwcmFjdGljYWwgc2hvcnQtdGVybSBzb2x1dGlvbiwgYW5kIHdlDQpjYW4gZXhwb3NlIHRo
ZSBwZXItY2hhbm5lbCBmdW5jdGlvbmFsaXR5IHRocm91Z2ggdGhlIGV4aXN0aW5nIEdQSU8sIE1D
VFAsIGFuZA0KTVREIHN1YnN5c3RlbXMgZm9yIHRoZSBWVywgT09CLCBhbmQgZmxhc2ggY2hhbm5l
bHMsIHJlc3BlY3RpdmVseS4NCkhvd2V2ZXIsIHRoaXMgbWF5IG5lZWQgdG8gYmUgcmV2aXNpdGVk
IG9uY2UgYW4gZVNQSSBzdWJzeXN0ZW0gYmVjb21lcw0KYXZhaWxhYmxlIGluLXRyZWUuDQoNCkZv
ciBvcHRpb24gMywgb3VyIGNvbmNlcm4gaXMgdGhhdCB0aGVyZSBpcyBjdXJyZW50bHkgbm8gb3Ro
ZXIgZVNQSSBoYXJkd2FyZQ0Kb3IgZHJpdmVyIGluLXRyZWUgdGhhdCBjb3VsZCBzZXJ2ZSBhcyBh
IHJlZmVyZW5jZSBmb3IgZGVmaW5pbmcgYSBtb3JlIGdlbmVyaWMNCmludGVyZmFjZS4gQ3JlYXRp
bmcgYSBuZXcgc3Vic3lzdGVtIGF0IHRoaXMgc3RhZ2UgbWF5IHRoZXJlZm9yZSBiZSBzb21ld2hh
dA0Kb3Zlci1lbmdpbmVlcmVkLCBzaW5jZSBpdCB3b3VsZCBvbmx5IGhhdmUgb25lIHVzZXIuDQoN
CldlIHVuZGVyc3RhbmQgdGhhdCBOdXZvdG9uIG1heSBiZSB0aGUgbmV4dCBsaWtlbHkgdmVuZG9y
IHRvIHN1cHBvcnQgZVNQSSBpbg0KdGhlaXIgQk1DIFNvQ3MuIFNpbmNlIGRyaXZlcnMvc29jIHBh
dGNoZXMgZm9yIE51dm90b24gQk1DcyBhbHNvIGdvIHRocm91Z2gNCnRoZSBCTUMgdHJlZSwgd2Ug
ZXhwZWN0IHRoZXJlIHdvdWxkIGJlIGFuIG9wcG9ydHVuaXR5IHRvIHJlY29uc2lkZXIgd2hldGhl
cg0KYW4gaW5kZXBlbmRlbnQgZVNQSSBzdWJzeXN0ZW0gaXMgbmVlZGVkIG9uY2UgYW5vdGhlciB1
c2VyIGFwcGVhcnMuDQoNCkJhc2VkIG9uIHRoZSBhYm92ZSwgd2Ugd291bGQgbGlrZSB0byBwcmVw
YXJlIGFuZCBzdWJtaXQgdGhlIG5leHQgcmV2aXNpb24NCndpdGggdGhlIGRyaXZlciBsb2NhdGVk
IHVuZGVyIGRyaXZlcnMvc29jLg0KDQpDb3VsZCB5b3UgcGxlYXNlIGxldCB1cyBrbm93IGlmIHRo
ZXJlIGFyZSBhbnkgY29uY2VybnMgb3Igc3VnZ2VzdGlvbnMgdGhhdCB3ZQ0KaGF2ZSBub3QgY292
ZXJlZCwgb3Igd2hldGhlciB3ZSBjb3VsZCBzZW5kIHRoZSBuZXh0IHJldmlzaW9uIGZvciByZXZp
ZXc/DQoNCg==

