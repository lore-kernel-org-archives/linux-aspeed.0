Return-Path: <linux-aspeed+bounces-2029-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C274BCA0EFA
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 23:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Jhm2x77z30KY;
	Fri, 22 Aug 2025 09:01:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755758639;
	cv=pass; b=b6Dmm8Sn76Gxe7+5DekvvIXN0/0h3kALByzUSroI3O68j35Xns+TYc5JEd0w3Ay7phJ5xfObYCFze1SZ2La8TfUg12okGOUF97o+tcPZGSNTECmhgwrBTr8GoXCANMJvvdFpnufPUYCpJhpz9yWdOm7vXtqvShz/hfSH4iHHj0OdAZn1Me35ike/VTEDSyGx37usuvSYm9nixLep4luFJJkg6KQxq2QITxr2BwZJvvkI7bMl8TNLNW8WcfUkjuWKVz2LWmoZuDwXSnjnrwVWB+Y0swXwxadtk+LXbXOrzniorFSBs+NMcSJNX8ayHjNk28SKyrul3cOWrNUqGb/a+g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755758639; c=relaxed/relaxed;
	bh=gHU3namH57IqcPAl+7Vrv7PoDA4e7Z/yDBWW0enSWQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIJJelac1P6b3VV+jfZM7lMV6oR7RJ+Z7TkAnNLP7lEbl5PXddUYbaiZYkGUoqvRuEyJPnN7JopxzoznYzxLmWVdoQ84nTo4fZPS1WeZH0xo7zcho9QTZBezloYcivEuG1Ct7wJQGO4WnRgTYmUl2sygCFhZ/D4fRtXPuauME6wXonbZDDqrFYfhewtOV4iCYO+9fMCHnflvQ0ExJLjFVB7v4XT921dJ1rgFKQSLwZX4cFBHMV1BZsr+862ibqbVokOHcFa3KQHXOUfWreUK7ABylnVLXWUqtEoZ5+lqHFOzQo7wo+s1z7qN60K4hmVvIGWLEYcMLMQRXKvkkqWq5A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PBwIw07g; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PBwIw07g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6v1B5gDgz2xPx
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 16:43:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTI3XImJwzT+qdimhjpqPKr8A+6oNUAd0AR+ENOLKg4nzsYXP1994nJeL7QyLolMplNhhe+QJ7/GD3pURjaC1htTYiapdzUP3rNSybfBw4RQ2V1QwXr7+7sLjLiQ4XCya3T37jzhWlporjP2eqF23xH1x+rbzPmUeab92OCL/iYrHJ8yQBB7jzb3O2aGcgYVpTqshGc5nTAa8KXI5YqSJFmGFSJbj+79J74LDr4QFxy2ugo85xW8r1brhRUl+qEHsIILP2I/WR30eY7drEsv/AzwX39qNOzZYtCk/k4V1gvj8MfWbl6TRDigcBcyI4X/oTM+ds7wSfErVDDu17u2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHU3namH57IqcPAl+7Vrv7PoDA4e7Z/yDBWW0enSWQc=;
 b=TmIFCI6PfilgPSZCPQ3dyPhfYwpRqTyGHs+lVmot4gG/fGl+hvl76dtLfkcbcrHNPZOKFdqEdTKk5Y2d4UHhyfAuFm/fBNdFwHw10v0QHd7J9UNBv6zSfA+ASslGuZjVU5jofXwfxsP83hZUX5hacwJ6Ty+1v6Sf2QK+lJrqi5mfWmhVnwzF3y+F6tcXWTA5sLoahh/H0tQEKkgGjNZgFmfiucwwxOkiwF1Q7t/bZpf6EIVSIkFDLAaPrCPH1ehEY9IPG88p9zS4G+7GQzG0F2Rb8BN24qSMbxtUzldNFbqLXl29FOn+oqtpHI8VDEUC43kOAuq6IR+I62/ftqt0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHU3namH57IqcPAl+7Vrv7PoDA4e7Z/yDBWW0enSWQc=;
 b=PBwIw07gruTW9JfOKwhFuKbLBS7VAdsp8+edHi+KkIHpuf4H93rbKD2yimMRsfOVtlIsw8zuQjL/zfgsuUqgjKhYRAcK+bB5GUJnoalbP9U7RuxRmQH2UHagAQGDewp9ybTEM5Rhf23K6rSZVWCTyRvTuEgpmX2Z2J+1fb0mDFcMN5GytGWp7BYmxv/qYOP8pqRT9f3GfcPcNmaA6pW1eWuUazl3ywM8vBzjkzOjBUWMVZHGYqKhnvvizEk87PMB02MgWwhbYDEziVdzB7jHi2cCsfiK4Pj1uRMV50D7wGpN9FaKwyCpxyqJ7ZOjwHZhsxVmou2Nc+wG7McYmIOexA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5356.apcprd06.prod.outlook.com (2603:1096:400:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 06:43:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%7]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 06:43:33 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, Z-Howard Chiu <howard_chiu@aspeedtech.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtuZXRdIEFSTTogZHRzOiBhc3BlZWQ6IGFzdDI2?=
 =?utf-8?Q?00-evb:_Correct_phy-mode_to_rgmii-id?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbbmV0XSBBUk06IGR0czogYXNwZWVkOiBhc3QyNjAwLWV2Yjog?=
 =?utf-8?Q?Correct_phy-mode_to_rgmii-id?=
Thread-Index: AQHcElwUrGwcYi9MjEiGcSHwQ2D4GrRsn52AgAAAn5CAAAVcgIAAAo0w
Date: Thu, 21 Aug 2025 06:43:33 +0000
Message-ID:
 <SEYPR06MB5134646C91238EC7336AC3269D32A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
 <80723310-97e6-45ea-8154-c48de40e14aa@kernel.org>
 <SEYPR06MB5134106F024EB9EC32472A329D32A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <c288db22-7a80-4dc1-abb5-fb5adb2f5669@kernel.org>
In-Reply-To: <c288db22-7a80-4dc1-abb5-fb5adb2f5669@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5356:EE_
x-ms-office365-filtering-correlation-id: a07e9386-f8ed-4a18-333a-08dde07e0c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXRBYmVVQWc0aWFIQmk1WlY5VDdMYXRmVG5zK0p1cktDa0FSSEgzRGxJdGp5?=
 =?utf-8?B?KzNEcjAxSmV4YzdNbzVlLzEyTlVKcGJlR3NpNmI3UlQvWlYvcDVueUtxL2lr?=
 =?utf-8?B?cEI2NnFtaVRIRER1NGlpTG91d21HdkViNy9nNFNoU2plM215amxMUTNoTzNs?=
 =?utf-8?B?YkhPeWE4Yk16RzhJbWFJR05LL3lFVEFhTTZnU0MyeFZqVDB1YkNuU0t5aHU2?=
 =?utf-8?B?RlMvdkJzblFBVGNsQnBRbFlIYUlpUzUrdHJHc3daaTI2RHpjVys3cDZjM2hk?=
 =?utf-8?B?dnExSU9LaUtWZ0xlZVhSd1Vqb2xXM3ZTb2lnS09zQ1NRM3R4UDFuNTBxRjlK?=
 =?utf-8?B?UjEvdHJVWnF6UytlY21wYUJLQi9YZUYwOVhlWmtBZm5YSnRhT0lod2VEY2RR?=
 =?utf-8?B?c0FKclNlUkVUMGp6RlpwdlNCTVd1Wm81bzlXcDJEWTlYUk1WSjhJZnF2QmYy?=
 =?utf-8?B?VTlKT2JEeE5tNTY4bW5haUwyUFRKcWEwZkdCYmM3cTlvY2o5ZFBRbDl0Vlgr?=
 =?utf-8?B?V0pvWkVNSzhKLzluQnZUQVFuc25DWkxicUZWNHpHSWx6ckpORUFtTVVoVzdo?=
 =?utf-8?B?MHBBbE1tSGJCSUZYcFNIbEtDaXY2VXFLNGFwb0FWbEEyNCtoUzBmZVk4KzBI?=
 =?utf-8?B?UVJzK2dnU3I5S1RWS2ZuNnBpeFlGMDJpNXczZEMwTkFaYVpzWjZCbUo2Q2Q4?=
 =?utf-8?B?Y2dSMGg4cGpVSjBTeW4wd3FrVDR5bUpMOTBtWk9kQUlEYlJHUHVkMmVHemNJ?=
 =?utf-8?B?OVMwNzZzYUNITTBFaGtQSzdlNmRjR1o5eWpoK08yWmNxN0VPMEVTWkk0OC9t?=
 =?utf-8?B?SklzVnZFY2Q4czdiVmxpUzB0Y3VzQ0lKemtNUlhBSFZ1dkJLb2Y3ZVEzT0lp?=
 =?utf-8?B?Y3VPZGd4SXNheS9tOEV3WWQ2SVZQWkZHRmwxTGdGNlBCSTgzYStHaUtPTGdE?=
 =?utf-8?B?djk0Uk5rQVdZMUR3Z25Wdkxwdk4zUU1tcGhYcW1lbXJheW92enpjZUo1RmhS?=
 =?utf-8?B?WllaV3ExaENNQXhXaTFRTkVrYmZTS0JrMVltL0JORjZLa0UxWWhNbWhuNkVm?=
 =?utf-8?B?M1pOQ05zMWNLWXZRZzNIMURnSWdEeTRtM1RVT1JSUTZiKzlwbHJscGRVdjZX?=
 =?utf-8?B?MzNXNGJzaFRPYXFjWGwwV3JFR2trV09jYnFqcExGbWpUb3lEak8wRGpjUy9o?=
 =?utf-8?B?bXo0N0ZGc0xQdHc2VTljOTdBc3VqTGNlUldtamV6NWJvWUVCMGg1cmhTNzFS?=
 =?utf-8?B?T1lRd1RwUGVGZ2k2U1RKRWhGNERDUWkxL2Zib0J4dmN4eCtiK3pQaFRZQnE1?=
 =?utf-8?B?NjZLUEpPUWxCSU84ZnNaSkoyYTdjL2s1ZStqLzhBdHprTEdQNnc1ejNEc1Ey?=
 =?utf-8?B?dnZ1VGFMczQ0YjU1UjZlaVJ0d0szVjdvMlo4UE1DMkE4NUdwd2xJOFFhcGNJ?=
 =?utf-8?B?S0hTNWIvdTVDL2NtcFY3SEs3UFhVd3Vaam1HVXFCb21nT0V0VkhZaHV2U3Jp?=
 =?utf-8?B?azhWL2VjODFNQmRSWEdPRStCUmNtS1lEQllKcEhDZHp6d3FSTW1IZGxZSWVh?=
 =?utf-8?B?Y25SWStqTlUwdC9NTCszdHVyWUVqMjliZUZtM0ZhYXcyWjVaYnlEaEpabStZ?=
 =?utf-8?B?eG82RFI5MDlrK2R0ZFpuSnNiUDN4OUxzSjM1TkEwK3FFQnBnaldQK2x5eEFH?=
 =?utf-8?B?aGdydXh0RmJlMEVjLzJSV05hc0prSk5sTTZuUStjMFNoL0ZKQktJRTRjOWRN?=
 =?utf-8?B?c2crQnN5UkttdGZSSlY2emVycGptSUMzSkFlQTFIVzl5a2N3V0IzdCtrR2Jq?=
 =?utf-8?B?b1dXaTM3dzVvbHdHellXekR5QURNZ1MyL0l6UWNFdjNweThSTVRwODhLTmpH?=
 =?utf-8?B?TWZqREtIOWtld1U2Y3pXeWZtbW0xQlMwazk2bmo1cllBRE04L1QrQy93cXo4?=
 =?utf-8?B?dXBMTTBwaDN6Z1QvMHlVZWRDdGJSdFQvMmdWd01DaUFtZE1YMXJQZ2I2c0tJ?=
 =?utf-8?B?T3drNW0wMlJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFcxU0Vxck5sT1pCUGxqK2JZSUJIa3k3KysySk0zWWt5RDVUcDV2RzIzb1RX?=
 =?utf-8?B?eWRCK2tyR3lxalZsbFltUnJTeXJuVDhFY01FWFNYZE1teW1abldFODBuVmF4?=
 =?utf-8?B?T3NmRy80MnVkTjRFSnR4OTN1a2M4ZzZ5OHNKVnIvOWE1enR4OUZFZS92aHFN?=
 =?utf-8?B?TGhNL21mdWhsOFVjUVF1alFsTXVES1ZML2dmYXFoVHZkNWV1ZHlKUWlOM1lL?=
 =?utf-8?B?TGVvTlZkMDBuM1IrNGJIcFlMNndCMFRNRlgrdTU2OUNWeTl2MkNBNmRydWpp?=
 =?utf-8?B?MFBhdjh5YnpMVFpPNFlhM2hEQUFOM0lQSXJYZjY1OGxFczZndmNycHV5eGVC?=
 =?utf-8?B?WHpxaFowWXUyUjJIWHA4MWJibk9EZVlFUDZlRWRBRDFyODNmUVFYZFBqcm5L?=
 =?utf-8?B?aktoTW5kSWJhaERyYmlWc0dZUjBMSndDT1JzdGFISUxwRXJYMGgvQ0g0RE9j?=
 =?utf-8?B?aFdHOC9IN01zRVFRYzBQaEd1TWxIV1l1ek80YTZQTnhBMnhuU2FQY1FQOTNo?=
 =?utf-8?B?a1cxbE95WTVTZWpCUGFrUEhrSVpSZW9GOG1BbGV3SVFXeDl0eWg3NGMvZlZH?=
 =?utf-8?B?d1ZaWjVtK3Y5bDRqQVIvU2crWEIrMW81NytGdTdiaGl2R0JhbEhOWTcyKzFa?=
 =?utf-8?B?c2VrSXptUDcrS1FWTE1YSlhWZy82amt6T0Q4YmgzdDVLelQrSS94MjlxVUhy?=
 =?utf-8?B?enJmQ2RiOFkxa3lMYkJGdnk3ZkJxMER0cllaWkJQalRWeHdTTTNmV09XNGNl?=
 =?utf-8?B?b0tCdS9PeTRkRWx4c3J2U3JGYkN1UGd6T3VvWkUycEdUMXVIY3IvN3lzc2RL?=
 =?utf-8?B?YTZPaEJBN1l5c0R5MXhrZXpXU0lHcEdiejJxeVB3bVZERGJVQ080YzF1MzhU?=
 =?utf-8?B?MUlNVkNEalZUVDFqZjNXMjF2RXhEbEZRUmNIU2hLMmF5SEY3aGdYN3ZtZVBm?=
 =?utf-8?B?RW8yRUM3eURKYmJ1THQvdlF4QU5JampTdXJTMk8wRHE3K3dLbDdlYVZPeWF2?=
 =?utf-8?B?dTBrNmpKakt1UXNQRXd4NUt2TjZlQTh6WFo2cTRCa0c5WlZnUTJRTDg0czlO?=
 =?utf-8?B?MWVSSWluZ2pIRnNUTXFFTnJXcXFZQ0s3dTM0TndSTHVjM2RXUXZMOGJRYTA4?=
 =?utf-8?B?SjY2TjdsQ1JCemQwUTl3OHhyZHFVMEE2WGxLWk1BOHlUVXZlVEtmMEJaZUVU?=
 =?utf-8?B?Mmh4cEh2ZGlxeEZVeTVxVE1uTHVGSTZ4TFFiaTIzZVExVnU2QVdsUG9mcTRj?=
 =?utf-8?B?VjN2amtCaXBnMTRKZzc1cnMyV0h6NVl5NHRFUGpZR0tidjN4TDZYdnBoODJs?=
 =?utf-8?B?dmRmRjM0QWpIblZXSXVBSDdxdVc0M0NsdktMTjU2T2lOcGJCdE8ybUtjS3M5?=
 =?utf-8?B?OTdydkpKNHRPdWVPMlpVMlhIQWJHcTUrc2RSOUdVRU14WVF1UzB2Y2JpMjZG?=
 =?utf-8?B?eWlFK1Q2M2hZeE1IU0Z1bHNmRXZXdmUwbXhVeEpvdk02YkltbGx5MHFsYzRu?=
 =?utf-8?B?bktTa1hrV2p1RWZhK1A1Rms0emo4SW5NUHVIbTV2cGxLUjE2MmgxNU1GTmE5?=
 =?utf-8?B?aUp2RnY5U292dEdLUVlGNmpMT1l5RzFyU0k1czZPVmxIOVJhNnFwRjUwV2Vx?=
 =?utf-8?B?c3J4eW9GRmoxU2VkVkhHdHFVRDR0SDc4bGg4NDB6dzBGZU1YYTRTNU1OeERZ?=
 =?utf-8?B?SUs5ZmVUSkhLa0Q1MGJ1TjNyaGlJRjNzTS9kN21wRXFHU09jdDhxRkxKMEdx?=
 =?utf-8?B?c2dscm82ajZOMDFuS1daNDF4dkFqbUFoZFVkTW9Ec2dmd0MyemovUTdKRTdt?=
 =?utf-8?B?TG9kdm1LT2tlT3RaNnpUeFhHZE1vTk9rMWN4NTFKdTVsSjdlQWFKVm5mYnFE?=
 =?utf-8?B?eGZtWHRWT3lUNDdsNWNtaE1xOUtaVGVJMTUwcTZENnJocDVEbm82UEtkYTZV?=
 =?utf-8?B?VlAyRXpBSnoweVVpU1UxSnFmY1VjV05xMnc4Q1o5NTZTRzY0RXFIbGQzZjlI?=
 =?utf-8?B?WExsL05na3I4MFl4N0dmVWs4VFNVejlTWlN2Qmw1YXNtd2hZamlsY1M5cDB2?=
 =?utf-8?B?ZDgvY1RrV3ZkbmJXTEFkOUk1RmJIakJ0UWRSTnRmWmhLL2RRdW1uTGI3bUw2?=
 =?utf-8?B?Y3pvRXZwQTNKYUErMHQydDhQakRaZHl1SXBFZFl6OU5wbldQR3RnU2Z3L3RY?=
 =?utf-8?B?VUE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07e9386-f8ed-4a18-333a-08dde07e0c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 06:43:33.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiVZhdf8X3gwTcMIm5K8i1KlFIm8m+BO2ugiRK3s/UsX1W0jHTZfpkqTvV/GIMfrdowPe+fPvgJ+muWrmI1/6uxQsnniOzgmp1/IbC5VU+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5356

PiA+Pj4gQWNjb3JkaW5nIHRvIHRoZSBsYXRlc3QgZXRoZXJuZXQtY29udHJvbGxlci55YW1sLg0K
PiA+Pj4gU2luY2UgdGhlcmUgaXMgbm8gUkdNSUkgZGVsYXkgb24gQVNUMjYwMCBFVkIsIHRoZSBw
aHktbW9kZSBwcm9wZXJ0eQ0KPiA+Pj4gb2YgYWxsIE1BQ3MgY2hhbmdlIHRvICJyZ21paS1pZCIg
bW9kZS4NCj4gPj4+DQo+ID4+PiBGaXhlczogNGQzMzhlZTQwYmE4ICgiQVJNOiBkdHM6IGFzcGVl
ZDogYXN0MjYwMC1ldmI6IEVuYWJsZSBSWCBkZWxheQ0KPiA+Pj4gZm9yIE1BQzAvTUFDMSIpDQo+
ID4+PiBGaXhlczogMmNhNTY0NmI1YzJmICgiQVJNOiBkdHM6IGFzcGVlZDogQWRkIEFTVDI2MDAg
YW5kIEVWQiIpDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYWNreSBDaG91IDxqYWNreV9jaG91QGFz
cGVlZHRlY2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVk
L2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMgfCA4ICsrKystLS0tDQo+ID4+DQo+ID4+IE5vLCBEVFMg
Y2Fubm90IGdvIHRvIG5ldC4gV2h5IGRvIHlvdSBwcm9wb3NlIHRoYXQ/DQo+ID4+DQo+ID4NCj4g
PiBJZiB0aGVyZSBpcyBhIHNlcmllcyBvZiBwYXRjaGVzIHRvIGFkZCBvciBmaXggYWJvdXQgbmV0
d29ya2luZyBhbmQNCj4gPiB0aGlzIHNlcmllcyBJbmNsdWRlcyBkdHMgb3IgZHQtYmluZGluZywg
SSBzZW5kIGl0IHRvIG5ldCBvciBuZXQtbmV4dC4NCj4gDQo+IE5vLiBUaGF0J3MgcmVhbGx5IGly
cmVsZXZhbnQuIEFuZCBpZiB5b3UgY2hhbmdlIHRoZXJlIEkyQyB5b3Ugc2VuZCB0byBJMkMNCj4g
bWFpbnRhaW5lcnM/IFRoYXQgbWFrZXMgbm8gc2Vuc2UuDQo+IA0KPiBZb3Ugc2VuZCBpdCB0byBy
ZXNwZWN0aXZlIG1haW50YWluZXJzLiBuZXR3b3JraW5nIHRoaW5ncyBnbyB0byBuZXRkZXYuDQo+
IFNvQyAoc28gRFRTKSBnb2VzIHRvIFNvQy4NCj4gDQo+IA0KPiA+IFNvLCB0aGlzIGlzIGp1c3Qg
Y2hhbmdpbmcgdGhlIERUUyBzZXR0aW5ncywgZXZlbiBpZiBpdCBpcyBmb3IgTUFDLA0KPiA+IHdv
dWxkbid0IGl0IGJlIHNlbnQgdG8gbmV0Pw0KPiANCj4gWW91IG11c3QgZm9sbG93IHdoYXQgTUFJ
TlRBSU5FUlMgdGVsbCB5b3UuIERvbid0IGludmVudCB5b3VyIG93biBydWxlcy4NCj4gDQoNCkdv
dCBpdC4gVGhhbmsgeW91Lg0KSSB3aWxsIHN1Ym1pdCB0aGlzIHBhdGNoIGFnYWluLg0KDQpUaGFu
a3MsDQpKYWNreQ0KDQo=

