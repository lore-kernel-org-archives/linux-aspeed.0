Return-Path: <linux-aspeed+bounces-1836-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D52C83F17
	for <linux-aspeed@archiver.kernel.org>; Sun, 27 Jul 2025 01:48:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bqPdJ53WXz30LS;
	Sun, 27 Jul 2025 11:48:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753580884;
	cv=pass; b=ENqsag12fV+Q+wuk+Zv0drc5APErdZ7wiWbw7UbMOjh2g2n0NUTiW7riZpRQnYckX9kTORAhK1Uulw8F7RJ6v/JWz+xetQNnUfa8S8hcrSEHRAu6Eh8KhGyT68NZgyKNNw0wzuMkIXwqVcu8C+r52UwVQlj5yNXps52dxU173g+LulLNr/2MTIJt0PpgjHNekuD0OR+GCDNLILWrxexfLsDTU8gSyFDfpr0tfghNak08erSSjeTi8B5t+xLcvpRKYN9jLWbghduIug6KNWffkF4Ibe+gilF50TJyvMbnMEW1VCeEnOGgL49DaszJZDGaigMDq9fYEIMLPEi5e19rBA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753580884; c=relaxed/relaxed;
	bh=LdBByXizILot5YxeFriofPLP8iYci3KQc2FFhlFKtI4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2Oxa5ypWxltPJ3ATtITpN5O+LySxxA90MYRUUEPy+b8hiVLOCDwr//n1KW69g2uq4+GguoL+Vq7StXcYbcM9iBG2HrmFmDjR21sBa3SRaIYfo/hLHPCEJXl/pXDEuwCd95R4BC1Fck5tPH5m5mpdxp4zPDqs8z9wqDsX5KhzCiJRD3NDUhJdjXaCsrUrSF14FHvPU68C1waZObVGfIx+VawHvy5eE/Fv3afUTMW13+QqnUExhERpm367avHoalvqLyMvnpaYoenJWwg9/rclVzxUU/62HjCPzSsiRK3qm3QBzXnf8xu8NbMNaTwFfqHh0usDm7eKXhaLJ84EpovUA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=fail header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=XC0D9Z+G reason="key not found in DNS"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=XC0D9Z+G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bqPdG52xkz3091
	for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 11:48:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf/iTt4YGzVShHxz2klEO3wV+iuKCSirh3oR5N7yCDCogPWFNup/ms8FBFkhm7tzhbEOmX3whyvxsMpMs0+xQE/JRESJzofGVpiZ2TkIVhpqydXKUOhCRWOgB9KYhERez6SWvpu+6fu/OoHpDk13YCLXKZMkVyD/IMfCjPV+mSC323v7mXVptSfNyKJYslWURAykJBFIgcLKvmxyyfYZD6J7vBhxhrA8ECJZ1NekDJDwB43jx+C/M1kkGA5Wgwhqk8IkscF66s2cNS3nzx24tWuM4KHGJDj8stlikepmNEv00kP2TgvsVoOvmKHCeuj9/eDLzhx8XWkB1Ugyeju91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdBByXizILot5YxeFriofPLP8iYci3KQc2FFhlFKtI4=;
 b=SxOM5bnzyfqDMmuLKhCJeC9KT8hFwqGjFkeQg8rrZ8FYCe09VkZqAVM4WUOy+lusMtS3rNbCLb0UVqgWD4aAQYel3E5S4sY2uZVYFlafw9O7Klho39bGPRY7V2DC9qSiWEuv8526oT0DpKd4HAKrUDhm4fughOdaqydxKHKULz0DNJQcmOyb8MXXHhfHxp+hpJ7gC4LAzBh5vMoAUUnWHjbOAc/v1zeEwcdnQkkwi9KIZz0qYSkTBVUEg20wt+Dwut0KwtIuCYnL0+fx6SdS1JCJOFZH5j6MVKiIctBCSNBkTzVluCC5hDJ/4uHEG9RoBE9Jr/NCjN802/cwwx+HMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdBByXizILot5YxeFriofPLP8iYci3KQc2FFhlFKtI4=;
 b=XC0D9Z+Gcc0qB4NFO6yNbZvRgRCZbzKLlrq2EhCGOOhaRZtc+ol/cxNVmTIUPAn9+c+XiwEPDY5kqivLDQ7YHsSFIfXqx7xbzKgi/TI1xzYEtmKYwOFjNjTLoroWHa7Rxx82IDyM6LtA9MIb7xobK5Wl3Cbu9PGaJphy1bXLax0ctFrdNoKXsB1ChuGA47PSM5sKZEX8+pQE/26QgFThq/O+jDsBotfuDMqHPNfBuoD32NUXbEHr2/54eBqy+Oo4Zr4n7WewHpJAV03HhZA4cNxoVIeidDGrZWn9uEQPraGCutNqXXHanjk9Plm4Uq+R9S1ohS/YeTIl/etdrTwneA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by PUZPR06MB5723.apcprd06.prod.outlook.com (2603:1096:301:f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 01:47:35 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 01:47:34 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Thread-Index: AQHb+u5GGJR1Lh1PR0C5h6er79qfsbQ/O9gAgAAebjCAAx6NAIACvGYQ
Date: Sun, 27 Jul 2025 01:47:34 +0000
Message-ID:
 <OS8PR06MB75418BD29DCD6E93F2A44903F25BA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <001d37c7-f704-4554-a4db-0cc130e07dd6@kernel.org>
 <OS8PR06MB7541F8D3AEE1A618DB31F07BF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <384635a3-c6ed-44f8-a54a-2b20e20694cd@kernel.org>
In-Reply-To: <384635a3-c6ed-44f8-a54a-2b20e20694cd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|PUZPR06MB5723:EE_
x-ms-office365-filtering-correlation-id: e73d438e-169b-411d-a380-08ddccaf8ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXMwSXZyenlVc09wOUJlV2pBRURPL2lrVDlwbXNTMWhvNnd2MTZLa01FbFJ2?=
 =?utf-8?B?bVVaR09vN2l6TFc5aW8ybkprRlNrd1hEUXRyVG5HalV2NG9RL2VVbElhbGNw?=
 =?utf-8?B?MGcwd01DbHhveEMxNjJrR1BvOGFsVnZtQU94U0NKWVVXQjE5cU9PMU15MWtF?=
 =?utf-8?B?cWlXOXlYY1R0UmE4SWdXRWQ0Y1BGZkpWRnkwTEhETEFYU01VUW1iYWRZWmJF?=
 =?utf-8?B?YVZ5bWpJaUM4blRqbldGcFlMOE1TbzRuV2FEdDUwaHpKMmtGNTdEU0Y2UlZy?=
 =?utf-8?B?a0o0bi9DNDJtcDludTNSVzZiSHVXYldaWHhTZ3AzNDVIUThJZFlmWVZpNnZD?=
 =?utf-8?B?ZXZLbllXNlFSOFVLMjYzaTlub093Wm5VWHBiS09LNVA0bitnR1lHa2xkcU14?=
 =?utf-8?B?Wmk5dlJCMnp0d0YxWlAreHZZL3NLcHBvOWk3Y2NkMEZvSVZidTNCUVlkakxn?=
 =?utf-8?B?YkJqZXBkaVdEem1EVWhjUWM0ZTgrTWxJVkdxNVh2eEpPQThuU2MzY1Q4OWln?=
 =?utf-8?B?WEFUaVhrYUhEVEs1citTOXh2cWxlTWZrTVBJWElhVXdXMzZXcGtJS0FDWUhH?=
 =?utf-8?B?N1dBb0JQTGw5cExHVjV4M3U3N2FjeGhpYVN5cFRLTUR1dk85Y2FWTkd4cHNJ?=
 =?utf-8?B?aXhSQXNwMmVlR3VhWGlaVThsZGs3NVBueHFFcE5wYjREL2xnM0d4N2c1T0Fj?=
 =?utf-8?B?NWdkUk9sbkVCWlV4UmZEemFBNDBFUGJSaHhiWVpyQWlJVU9ESm9sK0wvZ0RI?=
 =?utf-8?B?VTZvdEdVWTY2Rnd4WDU3OWxmRlF5bEdtTnhmMDdjS1hVejZOVlVUM2xXM0Nz?=
 =?utf-8?B?K0hmZkU4REw3UE00UTl1Q3VQZU1IVWQ0a1B1eUxzVHhLR05tclJDcjlFQ1g1?=
 =?utf-8?B?NXlCa04zYklhWjVWYk1UMUFrU3V5QkJ0RlUxOGJlekhlYWtTRDVuamwvQmhp?=
 =?utf-8?B?RmtiZTZnOTJWQVoxNUREMmRMditheDBuamJIaEtBa2FIVFUrbEZ4UlVkcmly?=
 =?utf-8?B?MGJRODVsYWQ3Y2hEdkloaFBMZVRIT3hzS21BZkdySHhPS0p3bzd5ajgzY2gr?=
 =?utf-8?B?V3JRaVFjZ2JpSHN6SmJ5MHhRQ0tWZnBWS0NvK2VhSERXck5OakFoTytuVWlz?=
 =?utf-8?B?bWVadFU3dlJjUUtPem1lODh2bXBKSFFpY3I3WllsaWlzNnBvYkNWaFZBWjFy?=
 =?utf-8?B?U2VDdVIzNU5LQWYxSndLK2c4a0E1RXRNMlVYNlJBdlZLemYxckNTQVpsU1Ar?=
 =?utf-8?B?UG12OWJNcFB3dnl1c2pMNjV4aDExQmczdjNRYkZEN25wN3JkKzUzbVkwMEVl?=
 =?utf-8?B?OVBkWSt6S09HNUNaMTZrMWs4UTc1aWFHV0FtQkdYZG1PQjhNUzVtbFFxYTdo?=
 =?utf-8?B?d25pcEFLN1ZETE5obmNFUzNCbmRvbUhCOWRxNjgrNEdrYXVzaDJLcllicEpp?=
 =?utf-8?B?UXRZcjBlMEZqcE9ZUXo3Q0tRY1ExUHJDQjEvWEN3WFZ3K1ZheGc4LytCR0tY?=
 =?utf-8?B?NXBDMnhWTmpXR2dURTNiZ3pPN1V5ZzlXUGRIRndESmg4N1J2cFVQWXIvQU5x?=
 =?utf-8?B?ejZlMlRGc2ZzRmlKcGJLa3dHKzBNNmxXc2NKM2pMUER6eVQ0eGRIUUhxRllv?=
 =?utf-8?B?eUZVU2E0THRpNVFEbmhKWTdSeWVmakVhbkU1TWlBSVlSSGova0dKMWtmbW5Y?=
 =?utf-8?B?ZldCMXhaT3Vpb2c5K1RHYkRxREM4eUNwZ2tyM2ErMlZtL1lPVUE0QzhhOGx2?=
 =?utf-8?B?dWZycXFYNmMraEhVQjRTbFNSWVN2cGZXSmpxT1A4TFBXYThmUU9CYXhEYW1Y?=
 =?utf-8?B?ZndodmNLaTBkNVpBNXMwd2ROWjQ3b2Zib1F5ZFdYZFFkNE8xNGlvbEp1NkVC?=
 =?utf-8?B?enhVUTVRZ2xzMzhBUWR2d0ozcy9HOGhrWk90bTZFTDZSYmFPbktZbGVNOHFI?=
 =?utf-8?B?alVKcWtKSzlpY3FQam5rRWM4NitlL2lEQjM3cUlVMjNXU3dVa3prUGw4NmFC?=
 =?utf-8?Q?JDOWo181BQPxVegDXfwoXIfezsOzH4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVdleUNEdUJCa3ZPVXBHOUpYbks0cStjM0swd3FQQ1ZnZzNuK21Xbk9YOStw?=
 =?utf-8?B?aWZ4d1BjeW54elpQM1R6clJsYWVKWDNmTFI5WjRieGRMTmJ5SzN3TmFRTmZ5?=
 =?utf-8?B?aFVseVBhd0lnaDlPc2JnY1IzV1Zjc0lLWEkrZUgvQ1M0SDFvZTl3NE1VMGJK?=
 =?utf-8?B?dWFnR2k2QWtldW1Qa0xsVnhGaHdza3gwS1VPMnRjTlNuSHZtRnVGV3Zodnpr?=
 =?utf-8?B?Z21BNFlrVGVnbXV1eG1tbXgxNHhRUVlMcGpzdVhoWWRDWHBkWnluMlp1a3Za?=
 =?utf-8?B?d1VXK2RuUDMyS1lQYWFSdllsNHlESnh3S2t4RG1KSzZDb3YwSEdCWUhGVEZX?=
 =?utf-8?B?czF4UjcxK3FYMkRnK1JOM3IwL3pNbUcyRUhNQTlQVUhORXZpcklsRVhXeVps?=
 =?utf-8?B?VnVxZFBNZjFOY0x4cW85ZEd5N0Ivdzd6ME42YzFKUlVsME1tNGo1bCtLemdx?=
 =?utf-8?B?UWZ2RmJYclpmQ2xvaHRrVGNneWY5R3hZMUQrYTd2NlByVk5nTWFEMHNtdWxR?=
 =?utf-8?B?S2JlYU93eGlTWFU5ODBGRGlBZFhUWWprdnk2NGNqbWZROE13NUk2NVZoTGpM?=
 =?utf-8?B?RERRMDJnVUpqSjlVN1Zlc0xwOVFmWkp5UnRzaUUxZko5ejV4VWZZci9nOVRn?=
 =?utf-8?B?Q3l4Ykg0WmJJaE1WNmRtbjJoOE84NlRWTHBycGpva2syUFpPZkZ0KzlWTExa?=
 =?utf-8?B?WjdDSU84MVlDaENIdWpGUGNnbTBzWDltUk8zS1Qxc3lBY2ZHKzFmOWhWcVlT?=
 =?utf-8?B?bWVmMEd0U05LRGt4dFlFazVJLzlIb0NYVWZ3Yyt1dnNHdktuclZxejBIYUJN?=
 =?utf-8?B?MHk1eXFLQjNGWi9uZmMwL3RWQ21iQ2NpMU1kZ0EyZzJNdDdTT0R5ck9qVkhY?=
 =?utf-8?B?RGJCMFZGcHJsUVFNdTBzdGx4SVpvQzMwd01BWmRDa1QxdDJsTGJobno4am8y?=
 =?utf-8?B?VTJ3K3BlNnFPVUJRUmlYcHh3SjdzQWNpNGlqSmF5aUE1MjBDWTFqQzJQbGpJ?=
 =?utf-8?B?TGtjZnlXd3NrbHhDditVaTJKM2l0RXlCWGZGNUtOSEJJTyt4T3lNQUdBT00v?=
 =?utf-8?B?MnBodkUzay9xRDIzTlp5NGZJT1pRMmtSckt1TWNGaHJ4d1ZTNzVkSy9GcFdy?=
 =?utf-8?B?TFZIRFM0Z3BUTVhsMUxIeE55czYxYzdmeTA4dkJZd1lINXk3Y0xodnVoNVRh?=
 =?utf-8?B?OE84b1ppZXB0SlBrbWlDOUhENTFCMVlYaFdxT2JNQzBjWlJoTkc0dzY5L2l1?=
 =?utf-8?B?T2V6VTFIZFlZREZFYlMwS1JEMTcxeE0rNDBVTmJrTUhxbTNROE85cEs0d2Zt?=
 =?utf-8?B?S2QwTGlZREkwOWIyaS9DYzRDKzhQbGY1Zk03NDlmekt0Z1hEYzBsQlMzaWgr?=
 =?utf-8?B?TE8rRDFoK1MxUFVOMGFQZFdxQkRzQTZMMDRWcnBkdTBwTWh1NE5POWZLbkky?=
 =?utf-8?B?dmFneWh1UWpnVFFKVDNDdEdscE5MNkpySk5yUGFqakV5bUdLU2laV3gwdFdi?=
 =?utf-8?B?Szc0SjY3eWRPSkRFa3A1Ukhvci82MDkzdFJsR2RXK2NYRmdpOUdoNTh3Z1Zj?=
 =?utf-8?B?azZLdkRpVEFZOGtIK1R3OE1adUZwWVBrcUVDVWpJNE5LakJhemVQanprSDJX?=
 =?utf-8?B?aUs4cHprRjlid2ZUN2tsVnAxdjczaEVZeklhbTgrMndVaVM0ZWdMYndCS0tw?=
 =?utf-8?B?RWFYZHpzankyYXMvSmU4Zkxvbmc2UVFRcThjZk1NelZjMzMyQ3NXNnhpTm1O?=
 =?utf-8?B?dnAyQ0JlcU1FM2NqYUNmbjljSGJwbzVrR2dXTWQ0a0llVUZXSXBJQ210T29T?=
 =?utf-8?B?UnhsdHIwcU9ZMm5uOHJ1d29MZ2lra0R6ZGp0OFlSL0l5QXB2a0pWRTFLZi96?=
 =?utf-8?B?SkUzUjlrZkwzL1liOFNzUXczOFFXY1l2akk4Y25CbXp4OWFrcVVTMmhzNTFv?=
 =?utf-8?B?WlJzNzBVNHZIekx5anB3a09rWVB6QVFRY1pFeHM4RmV3T245V0R4aXNHaFhm?=
 =?utf-8?B?M20yY3lRbGpmRmpBY2x3bm1PbVVUQVdOVG1qU3U4aEF2WXZ5bktMREtpeWZB?=
 =?utf-8?B?a3E4ZUVicC95VUY2Y2NobVNoaWFLbkRGWFdnUnRINW52bWZWRWtDWUZDUlF4?=
 =?utf-8?Q?MUi/DWzIfeCVkvKdYE1gxUlQw?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73d438e-169b-411d-a380-08ddccaf8ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2025 01:47:34.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEmfySMrwjK9WVw+24pSo3PVVgY8cVhrisKTFSLeikYE+X9AfqyFrFOt10ypVjjTin5PNXgJCEmwEVV+VukTENivXpsg4UrAJP+WAZ5NCzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5723

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250
cm9sbGVyOiBhc3BlZWQ6IEFkZCBwYXJlbnQNCj4gbm9kZSBjb21wYXRpYmxlcyBhbmQgcmVmaW5l
IGRvY3VtZW50YXRpb24NCj4gDQo+IE9uIDIzLzA3LzIwMjUgMTA6MDgsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGR0LWJpbmRpbmdzOiBpbnRlcnJ1
cHQtY29udHJvbGxlcjoNCj4gPj4gYXNwZWVkOiBBZGQgcGFyZW50IG5vZGUgY29tcGF0aWJsZXMg
YW5kIHJlZmluZSBkb2N1bWVudGF0aW9uDQo+ID4+DQo+ID4+IE9uIDIyLzA3LzIwMjUgMTE6NTEs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPj4+ICsgIElOVEMwIGlzIHVzZWQgdG8gYXNzZXJ0IEdJQyBp
ZiBpbnRlcnJ1cHQgaW4gSU5UQzEgYXNzZXJ0ZWQuDQo+ID4+PiArICBJTlRDMSBpcyB1c2VkIHRv
IGFzc2VydCBJTlRDMCBpZiBpbnRlcnJ1cHQgb2YgbW9kdWxlcyBhc3NlcnRlZC4NCj4gPj4+ICsg
ICstLS0tLSsgICArLS0tLS0tLS0tKw0KPiA+Pj4gKyAgfCBHSUMgfC0tLXwgIElOVEMwICB8DQo+
ID4+PiArICArLS0tLS0rICAgKy0tLS0tLS0tLSsNCj4gPj4+ICsgICAgICAgICAgICArLS0tLS0t
LS0tKw0KPiA+Pj4gKyAgICAgICAgICAgIHwgICAgICAgICB8LS0tbW9kdWxlMA0KPiA+Pj4gKyAg
ICAgICAgICAgIHwgSU5UQzBfMCB8LS0tbW9kdWxlMQ0KPiA+Pj4gKyAgICAgICAgICAgIHwgICAg
ICAgICB8LS0tLi4uDQo+ID4+PiArICAgICAgICAgICAgKy0tLS0tLS0tLSstLS1tb2R1bGUzMQ0K
PiA+Pj4gKyAgICAgICAgICAgIHwtLS0uLi4uICB8DQo+ID4+PiArICAgICAgICAgICAgKy0tLS0t
LS0tLSsNCj4gPj4+ICsgICAgICAgICAgICB8ICAgICAgICAgfCAgICAgKy0tLS0tLS0tLSsNCj4g
Pj4+ICsgICAgICAgICAgICB8IElOVEMwXzExfCArLS0tfCBJTlRDMSAgIHwNCj4gPj4+ICsgICAg
ICAgICAgICB8ICAgICAgICAgfCAgICAgKy0tLS0tLS0tLSsNCj4gPj4+ICsgICAgICAgICAgICAr
LS0tLS0tLS0tKyAgICAgKy0tLS0tLS0tLSstLS1tb2R1bGUwDQo+ID4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgSU5UQzFfMCB8LS0tbW9kdWxlMQ0KPiA+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgfC0tLS4uLg0KPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArLS0tLS0tLS0tKy0tLW1vZHVsZTMxDQo+ID4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC4uLg0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAr
LS0tLS0tLS0tKy0tLW1vZHVsZTANCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCBJTlRDMV81IHwtLS1tb2R1bGUxDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICB8LS0tLi4uDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICst
LS0tLS0tLS0rLS0tbW9kdWxlMzENCj4gPj4NCj4gPj4gWW91IGJpbmRpbmcgYWxzbyBzYWlkIGlu
dGMxIGlzIHRoZSBwYXJlbnQgb2YgaW50Yy1pYywgc28gd2hlcmUgaXMgaGVyZSBpbnRjLWljPw0K
PiA+Pg0KPiA+PiBUaGlzIGRpYWdyYW0gYW5kIG5ldyBiaW5kaW5nIGRvIG5vdCBtYXRjaCBhdCBh
bGwuDQo+ID4NCj4gPiBUaGUgY29ycmVzcG9uZGVkIGNvbXBhdGlibGUgaXMgZm9sbG93aW5nLg0K
PiA+DQo+ID4gICArLS0tLS0rICAgKy0tLS0tLS0tLSsNCj4gPiAgIHwgR0lDIHwtLS18ICBJTlRD
MCAgfCAtPiAocGFyZW50IDogYXNwZWVkLGFzdDI3MDAtaW50YzApDQo+ID4gICArLS0tLS0rICAg
Ky0tLS0tLS0tLSsNCj4gPiAgICAgICAgICAgICArLS0tLS0tLS0tKw0KPiA+ICAgICAgICAgICAg
IHwgICAgICAgIHwtLS1tb2R1bGUwDQo+ID4gICAgICAgICAgICAgfCBJTlRDMF8wIHwtLS1tb2R1
bGUxDQo+ID4gCQkJKGNoaWxkIDogYXNwZWVkLGFzdDI3MDAtaW50Yy1pYykNCj4gPiAgICAgICAg
ICAgICB8ICAgICAgICB8LS0tLi4uDQo+ID4gICAgICAgICAgICAgKy0tLS0tLS0tLSstLS1tb2R1
bGUzMQ0KPiA+ICAgICAgICAgICAgIHwtLS0uLi4uICB8DQo+ID4gICAgICAgICAgICAgKy0tLS0t
LS0tLSsNCj4gPiAgICAgICAgICAgICB8ICAgICAgICAgfCAgICAJCQkJCSArLS0tLS0tLS0tKw0K
PiA+ICAgICAgICAgICAgIHwgSU5UQzBfMTEgfCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQl8IElOVEMxICAgfCAgLT4gLT4NCj4gKHBhcmVudCA6IGFzcGVlZCxhc3QyNzAwLWludGMxKQ0K
PiANCj4gQUdBSU4gKHNlY29uZCB0aW1lKTogdGhhdCdzIG5vdCB3aGF0IHlvdXIgYmluZGluZyBz
YWlkLg0KPiANCj4gWW91ciBiaW5kaW5nIGlzIGV4cGxpY2l0IGhlcmUsIHdoaWNoIGlzIHdoYXQg
d2Ugd2FudCBpbiBnZW5lcmFsLiBJdCBzYXlzIHRoYXQgaW5jdDEgaXMNCj4gb25lIG9mIHRoZSBw
YXJlbnRzIG9mIGludGMtaWMuDQo+IA0KPiBMZXQgbWUgYmUgY2xlYXIsIGJlY2F1c2UgeW91IHdp
bGwgYmUgZHJhZ2dpbmcgdGhpcyB0YWxrIHdpdGggaXJyZWxldmFudCBhcmd1bWVudHMNCj4gZm9y
ZXZlciAtIGNoYW5naW5nIHRoaXMgYmluZGluZyBpcyBjbG9zZSB0byBuby4gSWYgeW91IGNvbWUg
d2l0aCBjb3JyZWN0IGFyZ3VtZW50cywNCj4gbWF5YmUgd291bGQgd29yay4gQnV0IHRoZSBtYWlu
IHBvaW50IGlzIHRoYXQgeW91IHByb2JhYmx5IGRvIG5vdCBoYXZlIHRvIGV2ZW4NCj4gY2hhbmdl
IHRoZSBiaW5kaW5nIHRvIGFjaGlldmUgcHJvcGVyIGhhcmR3YXJlIGRlc2NyaXB0aW9uLiBXb3Jr
IG9uIHRoYXQuDQo+IA0KDQpJZiBJIGRvIG5vdCBjaGFuZ2UgdGhlIGJpbmRpbmcsIEkgdGhpbmsg
dGhlIHlhbWwgYW5kIGR0cyBjYW4gc3RpbGwgZml0IHRoZSBpbnRlcnJ1cHQNCm5lc3RpbmcgYXJj
aGl0ZWN0dXJlIGJ5IHVzaW5nIGJvdGggaW50ZXJydXB0cyBhbmQgaW50ZXJydXB0cy1leHRlbmRl
ZC4NCg0KRm9yIGZpcnN0LWxldmVsIGNvbnRyb2xsZXJzLCB1c2UgdGhlIHN0YW5kYXJkIGludGVy
cnVwdHMgcHJvcGVydHkNCihlLmcuIHdpdGggdGhlIEdJQyBhcyB0aGUgcGFyZW50KS4NCg0KRm9y
IHNlY29uZC1sZXZlbCBJTlRDLUlDIGluc3RhbmNlcywgdXNlIGludGVycnVwdHMtZXh0ZW5kZWQg
dG8gcmVmZXIgdG8gdGhlDQpmaXJzdC1sZXZlbCBJTlRDLUlDLCBmb2xsb3dpbmcgY29tbW9uIExp
bnV4IHByYWN0aWNlIGZvciBzdGFja2VkIGludGVycnVwdCBjb250cm9sbGVycy4NCkZvciBleGFt
cGxlOg0KZHRzDQovLyBGaXJzdCBsZXZlbA0KaW50YzBfMTE6IGludGVycnVwdC1jb250cm9sbGVy
QDEyMTAxYjAwIHsNCiAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLWludGMtaWMiOw0K
ICAgIHJlZyA9IDwuLi4+Ow0KICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KICAgICNpbnRlcnJ1
cHQtY2VsbHMgPSA8Mj47DQogICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5MiBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwgLi4uOw0KfTsNCg0KLy8gU2Vjb25kIGxldmVsLCBjYXNjYWRlZA0KaW50YzFf
MDogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTRjMTgxMDAgew0KICAgIGNvbXBhdGlibGUgPSAiYXNw
ZWVkLGFzdDI3MDAtaW50Yy1pYyI7DQogICAgcmVnID0gPC4uLj47DQogICAgaW50ZXJydXB0LWNv
bnRyb2xsZXI7DQogICAgI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCiAgICBpbnRlcnJ1cHRzLWV4
dGVuZGVkID0gPCZpbnRjMF8xMSAwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KfTsNCkluIHlhbWws
IEkgY2FuIHVzZToNCm9uZU9mOg0KICAtIHJlcXVpcmVkOiBbaW50ZXJydXB0c10NCiAgLSByZXF1
aXJlZDogW2ludGVycnVwdHMtZXh0ZW5kZWRdDQpUaGlzIGFsbG93cyBib3RoIGNhc2VzIHRvIGJl
IHZhbGlkLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcyB0aGUgcmVjb21tZW5kZWQg
YXBwcm9hY2gsDQpvciBpZiBmdXJ0aGVyIGNoYW5nZXMgYXJlIG5lZWRlZC4NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0K

