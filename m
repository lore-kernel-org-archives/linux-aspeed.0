Return-Path: <linux-aspeed+bounces-4477-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA2FC4450A
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 05:56:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0QQX2Q11z2xjN;
	Wed, 15 Jul 2026 15:56:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784094964;
	cv=pass; b=l3qmdq13Bdg5oKVd+hHhRgjx6BmikkC3N3aLli4dZ6AQ5JR216JzbJBAWW+/n7kOGh+Cds0CeYHIs8lUOdcAMc0WEaJSvCVmTHCGJWHSwp5+5tnUgPdaOd64vNZMnXMB8+KBf9H9mCrm29ezzQb4FQnNL83XDNVZOyoDq04TG1ntNCK3IsTD+ylt1OovCUjDHi0J+ek3HwnO9ktxQ2Vf/L4HPSbG/z6m3MbkOqaKjrxECImp9ubvm47rbWO8AvRszSntICDFKj7wB3cTk/v2PSfeeE63gDvBBc/TpmTspFJ1BCa/N6NJlIrfLMWJQGkRHcYuI4w733VWuSbF9OyP+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784094964; c=relaxed/relaxed;
	bh=ROjfA8jsXOCE2lf6W5pB4p8ezgVVzwVhVC3TwjBm9uQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4XjbZ7nQt5IUMQRxctE0aNhMcO1ITcMiZ4AIGuEJ2nCKs/2GNjkeDYzieWCxcTyQFz5Gl0+HyRXObCj1LUZS6SOS+dYy2RKFpzjzg97gpNUUQqQBdyLMYt7AaGU3Lj2aEGoReAy+jJlSjT7Plb/tWZtl5u1q3OeMSZrLSBrzOJFEwligUXm25Tp11RIbcYdQODc8YQ/KV4cIDube3Ov/tGFyiaoG1BMwav2DPQaehtfAQtaWd2Vwx1exbugOFjxd1Gd/TTirlilLhJmnJSgp7aSdsc+ugS64M4q3T3hY6ZSvflyLCosc7TF/1w1AQDMOeRCZ/oz6umJW2/YsvuVMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BXrPMGuq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BXrPMGuq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0QQT1f4cz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 15:56:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5CPJls6Kt6NXIL82Bx6NxTlK8s3zppyvKJpO9hSS10sMwFytJWV8z0hCfcm4wCzZC2wotUVy9stSI/ClsvhL3ojj6Y1AB0pAQSDq06ZnTxOt69YGNL/Ldza0hFv0xRca0T1IgY53JXjp+qyiUpfBJXNRzQrSo+wHIYAtqujBM3N2kyx1H+E1jeoj0roL+tnJ/QQSzE4uD22r2PPp0/WIJO1mh/H/CRqrC2ImaV2Xz6Cg4psUphLWMVricFOCSHqc5yHu1IBiupJMqGA4f13COAKgDOCCCEb9XKt0H0UYYKRhXBqOaCM7W+DhE6mqNFB4KQxF7ClB4s564KCL8O+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROjfA8jsXOCE2lf6W5pB4p8ezgVVzwVhVC3TwjBm9uQ=;
 b=ihGci0BEdigjS0bqSUESuGO5z7wyO4GfAYUSC9Wiri4TTH+dSqccvZW+qBnHAmVck0E0WQzns+sJ8oLfYEQv5cegi2mp4hgpMIG2vnWIi/BwMl3f4c+7H3z3/RNsdxmlzx5CbYWeGsTH6E5TQVpADQ1uXprHRmoejbkisbrdIIRA8TcbHyyQeFaG9HHANtFiOzoKzQonC4dmVV9quycRcROMZZ6WIe5C/D6jiDOk+mfVBxohl6bDmYf4tW4GJA2wdyT7TTmsjuTwn/iDliv1E6xCpWsxBAn32J4B0tllTfVUgUohbLAGNWbo5qvFQCqU9OiN0NobYIu2n5+CzCDFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROjfA8jsXOCE2lf6W5pB4p8ezgVVzwVhVC3TwjBm9uQ=;
 b=BXrPMGuqwYa+Z9FI6lHwsPYbrqAMdwa+II7qZAaVNLxVuffZlp73aApjMArU1s3kR0fzE/G0H9MoLioxy6j8kFca2PFX9jFRgQGLXBVtyhxdMPVZ5B6WIrmjtFnaHdlp54oxp8E7cv6irwFlumzgVuUJpQKR9D3r9Abxb4yZ592pV3P5K161qoXujEH+9mwn5mf7illTvrumE3lFsZqJRFKSo1fUhOg76FrnCPvxIHdb6GGb4hby+C/pfSBYxnnggsAJwUU1XCIEeerwaP96U6RFUwZRrDgoFkJlUVxjgTJH0Y4KyL8h1q5Nv4YVsFNkPqFllgrU2P6XoTwnj1Q3TQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by OSNPR06MB8520.apcprd06.prod.outlook.com (2603:1096:604:490::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 05:55:32 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2%4]) with mapi id 15.21.0181.012; Wed, 15 Jul 2026
 05:55:32 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Vinod Koul
	<vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] phy: add AST2700 usb3.2 phy driver
Thread-Topic: [PATCH v2 2/3] phy: add AST2700 usb3.2 phy driver
Thread-Index: AQHchpNOnM449AUerUiXvoW6kWH3sbZlhJQAgAA9O2A=
Date: Wed, 15 Jul 2026 05:55:32 +0000
Message-ID:
 <TY2PPF5CB9A1BE6AE5B658D558EBDF24450F2F82@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
	 <20260116-upstream_usb3phy-v2-2-0b0c9f3eb6f4@aspeedtech.com>
 <ddb133ca1a3be605ee776b2276c1907c9ad32491.camel@codeconstruct.com.au>
In-Reply-To:
 <ddb133ca1a3be605ee776b2276c1907c9ad32491.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|OSNPR06MB8520:EE_
x-ms-office365-filtering-correlation-id: dfa940f6-8176-47af-c35d-08dee235ae70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|56012099006|4143699003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 A2H3tIymh7H5oEqF4KyejIoFZkNQ9BGcKgd1Fsp+A5CNkp2H0hz9wU1RTO49yBdGR6x7W4wRIqAPnrAvHJzQoaBotHAO3yQhaO6vM1PpikA4VAa11GA571eCEgVlpdt/lL0B55fqA+k9H14k4KbkssjLwXKHyNRRg4PHylVMyXcCZ7kDC+FImPc77TKP4VtffMUBPTrSFecQi4H4gNTwBSgxz/wlsgcgieI0YqAkAYxNjTsksUYfIboMF43Omaa+OtVlErP7eQKNbymTGsbeQ1H3ZEe9ar209r7pPqlcjigFteJJib+HdjYksxgz6vu4jMzJouWwUxPMvMMnPvpzsdsg14R9gHEdv1ihRyj7g0z2mraUWZ7auV9PgBPG4YYKHlwfaXlfILX1e+y+f5LHgPp/xGrl7Q9R37rXT5KqFu7P2AZNCq0nD7JqKtnraScle/vW3kM0tLZEeyAkNANgopatvzKBBEottZVEeKUNz4KEeEWXvjrqAEYgWk/gubIRoq9byN63JyabNqUPUM13NutBPMDbsMKfx9tfrKc0cZyXAmHJEsSzkJBw8GvkUpwfZCP6/Ml6syuWppREi1SWgtUsHzK7lB3ap5dMssnoxaJ6wlhHWdXc2di2WWHAz00CscYV//+TJBcVNYkz7uWCWKUSD+yZfUPQR0u6knnQvnz0QybjOO2nhAo389avbbvcY5ULZ2TALmrCWolMeiNnWW9c769hbjhTaf8tvET0SAg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(56012099006)(4143699003)(3023799007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3hzTzNUb1hkNWtuNjFBVytldG1ZVFFoZnlTNVJBbS9FNlp4TGRLQi9jNm5o?=
 =?utf-8?B?eEd0eWtsM1cxdDd0WnovUXJudzZnRlg0cHZMeHlsMUpXK3ZwZ2ZyMzhMRUgv?=
 =?utf-8?B?SE83TUxzVzBxeHVwRkI0UWgrMVNwRElJVGR6bmZMZjFieHpmY0tSNFRjWEVX?=
 =?utf-8?B?MWw2dWRRSkNvQmMzUS94Uk41VmZqUW5qcVRYaHYzdUlSSDZ4SWQxbFR1N1V5?=
 =?utf-8?B?a2JYb2k1WHNwZFgwQ0Z0ZjVZUzhEeEFadHl3a0xJNUdPRnA0b0J0QWd5eVQ0?=
 =?utf-8?B?bUVYcTh3alErMDkrWkpPNmc0cE4yZ2xkT1B2NXdXUmhWRkVQdUR6Vk9qQ1Ew?=
 =?utf-8?B?bXBsMzFOeDV6M2dnTmp0K1NQWWtpUmRyRHgrTEw2cFdrcG9CaXZ2emxSTjdN?=
 =?utf-8?B?Y210Wk50blJXTHc4N2VXdHNKejhpc3Y0L1FaelhWRUJxNWZpVmpKcE4vSzhX?=
 =?utf-8?B?OWFwVm4rSGlYN1VmWFgwZ3k4TXVwNHUxVUpKL082dDlya3NDU0J5TVFEdTlL?=
 =?utf-8?B?Nks0ZGp2eDVZaThkTERuQTRvZXlVWDVnQnpiY3NNeU1lR0ZyMldSUFVPSU1Y?=
 =?utf-8?B?ZTVEcDhpYTAzL0hSQ1dHUnB1RWI1QjM3cWs3c0ZFc3l1aDlrQ0NpR2NCeE9O?=
 =?utf-8?B?bWVRREZZcE55djUxUk1STTdqRXZ4R2N3MzZFd1Znc2kyTEdFNnp3SkN6UE0z?=
 =?utf-8?B?eHVvTnNJL2JPMlk2VnVGZkxkQlZ2cXdJWGFDWUNDZW1CM2hObW5qQk5INVcw?=
 =?utf-8?B?d2JwRXpBblVPaTZtL1luVk1PbW1SNTAySnV0dE02R2tYS24rc1dYdVpCVXZj?=
 =?utf-8?B?YlR4ZStnRG9teWlPUVhtSXV6WFlwSnRNNlAxMXJKUEsrbFkrM2NoTFpNVU1G?=
 =?utf-8?B?TDJNcjRCeFIvbkVvSU1vSEJuc3Qyd0ZjdytQNmxlV3hkc1I2OWR1elhieGtn?=
 =?utf-8?B?dk9EUnh2N3RtM2FhRDJRVUlmbitXSjh4UlR5SjVvL1Y4UWFYSTBWWXA0c01p?=
 =?utf-8?B?UDJoNXpXeVZmMUVXMU9ZUFZLRHNleStNZ2JyVTArWVJwTTFJbmlubXhyTE9T?=
 =?utf-8?B?K3VMM1dRbHVKU3B5bGhWcy80NExEdDllMFQyV2JUQ21hMythcTdvL1pnNTF2?=
 =?utf-8?B?WUlWVEY3VVREbVR0RU14alNVUk9NYnV2TXBNTmFqdlNDOXVhV1FZSkVzbXRW?=
 =?utf-8?B?em53U1VXdm0veGI4QjRSa0VIbjU3RVZaQVkwVkQ4ejFSNTJKZkMxYTEvOWJ1?=
 =?utf-8?B?ZFFKa3IvSFVaS0orV1NyQXZXeXpnWExzS24waW1qc1JBTnVzZVZmSk1Lam5u?=
 =?utf-8?B?SmJiZVRtT3FFYVd1QmlXU2dGaStVaUhVd3kvSXhQR0lRN0t4b1hhWWQzMjli?=
 =?utf-8?B?eEZCaGwwR1FGMG9SSlVQUUlndXhQWFdjTjVaeURnMGUzUlBLMGxmRHVPQzRt?=
 =?utf-8?B?TkF0NzQrYk1sTTZHRWliaGFIQXRnZ2Q4NnhvWXlyNEdzN0ZrQ1FuWHd0bmVW?=
 =?utf-8?B?RG1NbjR0R0ZIejZZN2o2bzY4VjZldEZxNE9KQzVkNmJ2Sm5PL2I2R3RocC9w?=
 =?utf-8?B?WWg3MDdVRGl2THJXN0Z6WGlxUnFLdkd5RnlYNEJVbmFqSUw3Y2IzYmp3VFJ4?=
 =?utf-8?B?a2srTHFxOEJVSUJ1b1FueWhNWVMra1Y2VjZRNGtRaElhYXBUZS80YjhLc3pT?=
 =?utf-8?B?Q24wMzNHdmVqbWtzaWZEUWtnNnNUZEZGWmhqKzJrY2cwNUpyWXlUczQySDc3?=
 =?utf-8?B?dHFSaTl4Q2Fpcm9JMG5meERIRTA5VHNZYysyV3BBdldUSWp1d3FBN3RxTzBj?=
 =?utf-8?B?ZEc4NFBDTFpSTmdSTkdUVTRTeFNSbzAyaU5OVTBiQ3RVTklNQ2FpR1UxbkxN?=
 =?utf-8?B?ZkNuZCtKb1B6TUh5NVdHbUlVVGI3bnEyM2R5MzE3bmxtZ0ptY3RIcjNQVVBs?=
 =?utf-8?B?bGUxSk9VTVM4SnR3YmVPM3dIajQrUEVvcGhmaS9yaC9YckVoTmhyMnJVK0U1?=
 =?utf-8?B?NVEyTWJjVjh6akEyM0xaT0c0dnhjWVBPLzhzS1o5MTJORllvbWNia2c4elFZ?=
 =?utf-8?B?aXB6U0VxbXpmYWlub1U1TDBSdFFFeTBtUkVtUTRNQkhTWW9sSFZHU0JVd3RT?=
 =?utf-8?B?cEdDS3JpZWk2NjBwQmE5UDNDdUNPRVNzRFJpb1VVUmlLYzBIN0psZ3VDUitj?=
 =?utf-8?B?V2RVRjY5SXNoZWRGbWtNWlEvUGF3RjRTYnlhcTErZ3FwNHpDRFBmcEhkaXpu?=
 =?utf-8?B?Yk9ueUcwZTBPS2lubk1scnJxK0dBT01lSGhPcXNDbzg2WFJLRG9YZE82M3hz?=
 =?utf-8?B?NXQ2b0NQWVJEVGFsY1RqYnJrRm0rMmw0eGJ2dXJDNDQvRyt6TjdrUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa940f6-8176-47af-c35d-08dee235ae70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 05:55:32.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbszcwLbcvV3yc28sszfP2nQenpPayl38uWw+ir8azTo4AhvA4ylVpf1EPv36i43WwFoZB3U76xqt9TV1JrIvCwTm2Udb1+j25fVzzWpXBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8520

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10gcGh5OiBhZGQgQVNUMjcwMCB1c2IzLjIgcGh5
IGRyaXZlcg0KPiANCj4gSGkgUnlhbiwNCj4gDQo+IE9uIEZyaSwgMjAyNi0wMS0xNiBhdCAxMDo1
MyArMDgwMCwgUnlhbiBDaGVuIHdyb3RlOg0KPiANCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9waHkvYXNwZWVkL3BoeS1hc3BlZWQtdXNiMy5jDQo+ID4gYi9kcml2ZXJz
L3BoeS9hc3BlZWQvcGh5LWFzcGVlZC11c2IzLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uODcyZDIxNjNmY2Y1DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2RyaXZlcnMvcGh5L2FzcGVlZC9waHktYXNwZWVkLXVzYjMuYw0KPiA+IEBAIC0w
LDAgKzEsMjM2IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0K
PiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyNiBBc3BlZWQgVGVjaG5vbG9neSBJbmMuDQo+
ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BoeS9waHku
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvcmVzZXQuaD4NCj4gPiArDQo+ID4gKyNkZWZpbmUgUEhZM1MwMAkJMHgwMA0KPiA+
ICsjZGVmaW5lIFBIWTNTMDBfSU5JVF9ET05FCQlCSVQoMTUpDQo+ID4gKyNkZWZpbmUgUEhZM1Mw
MF9TUkFNX0JZUEFTUwkJQklUKDcpDQo+ID4gKyNkZWZpbmUgUEhZM1MwMF9TUkFNX0VYVF9MT0FE
CUJJVCg2KQ0KPiA+DQo+IA0KPiAuLi4NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFzcGVl
ZF91c2IzX3BoeV9pbml0KHN0cnVjdCBwaHkgKnBoeSkgew0KPiA+ICsJc3RydWN0IGFzcGVlZF91
c2IzX3BoeSAqYXNwZWVkX3BoeSA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOw0KPiA+ICsJdTMyIHZh
bDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxl
KGFzcGVlZF9waHktPmNsayk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2Vycihhc3Bl
ZWRfcGh5LT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGNsb2NrICVkXG4iLCByZXQpOw0KPiA+ICsJ
CXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0ID0gcmVzZXRfY29udHJvbF9k
ZWFzc2VydChhc3BlZWRfcGh5LT5yc3QpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShhc3BlZWRfcGh5LT5jbGspOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+
IA0KPiBOaXQ6IEdpdmVuIHdlIGhhdmUgdG8gZG8gdGhpcyBiZWxvdyBpZiB0aGUgcmVzZXRfY29u
dHJvbF9kZWFzc2VydCgpIHN1Y2NlZWRzLA0KPiBwZXJoYXBzIGFkZCBhIGxhYmVsIGJlbG93IGFu
ZCB1c2UgZ290byBoZXJlPw0KDQpXaWxsIHVwZGF0ZQ0KDQoJcmV0ID0gcmVzZXRfY29udHJvbF9k
ZWFzc2VydChhc3BlZWRfcGh5LT5yc3QpOw0KCWlmIChyZXQpDQoJCWdvdG8gZXJyX2Rpc2FibGVf
Y2xrOw0KCS4uLg0KCWlmIChyZXQpIHsNCgkJZGV2X2Vycihhc3BlZWRfcGh5LT5kZXYsICJTUkFN
IGluaXQgdGltZW91dFxuIik7DQoJCWdvdG8gZXJyX2Fzc2VydF9yZXNldDsNCgl9DQoJLi4uDQoJ
cmV0dXJuIDA7DQoNCmVycl9hc3NlcnRfcmVzZXQ6DQoJcmVzZXRfY29udHJvbF9hc3NlcnQoYXNw
ZWVkX3BoeS0+cnN0KTsNCmVycl9kaXNhYmxlX2NsazoNCgljbGtfZGlzYWJsZV91bnByZXBhcmUo
YXNwZWVkX3BoeS0+Y2xrKTsNCglyZXR1cm4gcmV0Ow0KDQoNCj4gDQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJLyogV2FpdCBmb3IgVVNCMyBQSFkgaW50ZXJuYWwgU1JBTSBpbml0aWFsaXphdGlvbiBk
b25lICovDQo+ID4gKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQoYXNwZWVkX3BoeS0+cmVncyAr
IFBIWTNTMDAsIHZhbCwNCj4gPiArCQkJCSB2YWwgJiBQSFkzUzAwX0lOSVRfRE9ORSwNCj4gPiAr
CQkJCSBVU0VDX1BFUl9NU0VDLCAxMCAqIFVTRUNfUEVSX01TRUMpOw0KPiA+ICsJaWYgKHJldCkg
ew0KPiA+ICsJCWRldl9lcnIoYXNwZWVkX3BoeS0+ZGV2LCAiU1JBTSBpbml0IHRpbWVvdXRcbiIp
Ow0KPiA+ICsJCWdvdG8gZXJyX2Fzc2VydF9yZXNldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwl2
YWwgPSByZWFkbChhc3BlZWRfcGh5LT5yZWdzICsgUEhZM1MwMCk7DQo+ID4gKwl2YWwgfD0gUEhZ
M1MwMF9TUkFNX0JZUEFTUzsNCj4gPiArCXdyaXRlbCh2YWwsIGFzcGVlZF9waHktPnJlZ3MgKyBQ
SFkzUzAwKTsNCj4gDQo+IEFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0IFBIWTNTMDBbMTVdIChQ
SFkzUzAwX0lOSVRfRE9ORSBhYm92ZSkNCj4gaW5kaWNhdGVzIHRoYXQgdGhlIFBIWSBpbnRlcm5h
bCBTUkFNIGluaXRpYWxpc2F0aW9uIGlzIGNvbXBsZXRlLiBUaGUgZGF0YXNoZWV0DQo+IHJlcG9y
dHMgdGhlIFNSQU0gaXMgdXNlZCBmb3IgY29uZmlndXJhdGlvbiBvZiBjYWxpYnJhdGlvbiBhbW9u
ZyBvdGhlciB0aGluZ3MuDQo+IFBIWTNTMDBbNl0gaW5zdHJ1Y3RzIHRoZSBQSFkgdGhhdCBzb2Z0
d2FyZSBoYXMgY29tcGxldGVkIGxvYWRpbmcgdGhlDQo+IGNvbmZpZ3VyYXRpb24gZGF0YSBpbnRv
IFNSQU0sIGhvd2V2ZXIgUEhZM1MwMF9TUkFNX0JZUEFTUyAoUEhZM1MwMFs3XSkNCj4gdGVsbHMg
dGhlIFBIWSB0byBsb2FkIGNvbmZpZ3VyYXRpb24gZnJvbSAiaGFyZCB3aXJlZCIgdmFsdWVzLg0K
PiANCj4gSXMgaXQgbmVjZXNzYXJ5IHRvIHdhaXQgZm9yIFNSQU0gaW5pdGlhbGlzYXRpb24gdG8g
Y29tcGxldGUgaWYgd2UncmUgYnlwYXNzaW5nIGl0Pw0KPiBPciBhcmUgdGhlcmUgb3RoZXIgc2lk
ZS1lZmZlY3RzIGludm9sdmVkIGluIHRoZSBzZXR0aW5nIG9mIFBIWTNTMDBbMTVdPw0KDQpZZXMs
IGl0IGlzIG5lY2Vzc2FyeSB0byB3YWl0IFNSQU0gaW5pdGlhbCwgdGhlIGRyaXZlciBwb2xscyBQ
SFkzUzAwWzE1XS4NCkl0IHJlcG9ydHMgdGhhdCB0aGUgYm9vdCBsb2FkZXIgaW4gdGhlIFBDUyBo
YXMgZmluaXNoZWQgaW5pdGlhbGlzaW5nIHRoZSANClNSQU0gKGxvYWRpbmcgdGhlIGNvbnRlbnRz
IGludG8gdGhlIFBDUyksIGFuZCB0aGF0IGluaXRpYWxpc2F0aW9uIGhhcyANCnRvIGNvbXBsZXRl
IGJlZm9yZSBzcmFtX2J5cGFzcyAoUEhZM1MwMFs3XSkgbWF5IGJlIGFzc2VydGVkLiANCg0KDQo+
IA0KPiA+ICsNCj4gPiArCS8qIFNldCBwcm90b2NvbDFfZXh0IHNpZ25hbHMgYXMgZGVmYXVsdCBQ
SFkzIHNldHRpbmdzIGJhc2VkIG9uIFNOUFMNCj4gZG9jdW1lbnRzLg0KPiA+ICsJICogSW5jbHVk
aW5nIFBDRkdJWzU0XTogcHJvdG9jb2wxX2V4dF9yeF9sb3NfbGZwc19lbiBmb3IgYmV0dGVyDQo+
IGNvbXBhdGliaWxpdHkNCj4gPiArCSAqLw0KPiA+ICsJd3JpdGVsKFBIWTNQMDBfREVGQVVMVCwg
YXNwZWVkX3BoeS0+cmVncyArIFBIWTNQMDApOw0KPiA+ICsJd3JpdGVsKFBIWTNQMDRfREVGQVVM
VCwgYXNwZWVkX3BoeS0+cmVncyArIFBIWTNQMDQpOw0KPiA+ICsJd3JpdGVsKFBIWTNQMDhfREVG
QVVMVCwgYXNwZWVkX3BoeS0+cmVncyArIFBIWTNQMDgpOw0KPiA+ICsJd3JpdGVsKFBIWTNQMENf
REVGQVVMVCwgYXNwZWVkX3BoeS0+cmVncyArIFBIWTNQMEMpOw0KPiA+ICsNCj4gPiArCXJldHVy
biAwOw0KPiA+ICsNCj4gPiArZXJyX2Fzc2VydF9yZXNldDoNCj4gPiArCXJlc2V0X2NvbnRyb2xf
YXNzZXJ0KGFzcGVlZF9waHktPnJzdCk7DQo+ID4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoYXNw
ZWVkX3BoeS0+Y2xrKTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPg0KPiANCj4gLi4u
DQo+IA0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGFzcGVlZF91c2Iz
X3BoeV9kcml2ZXIgPSB7DQo+ID4gKwkucHJvYmUJCT0gYXNwZWVkX3VzYjNfcGh5X3Byb2JlLA0K
PiA+ICsJLmRyaXZlcgkJPSB7DQo+ID4gKwkJLm5hbWUJPSBLQlVJTERfTU9ETkFNRSwNCj4gPiAr
CQkub2ZfbWF0Y2hfdGFibGUJPSBhc3BlZWRfdXNiM19waHlfbWF0Y2hfdGFibGUsDQo+ID4gKwl9
LA0KPiA+ICt9Ow0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGFzcGVlZF91c2IzX3BoeV9k
cml2ZXIpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+ICtNT0RVTEVf
REVTQ1JJUFRJT04oIkFTUEVFRCBVU0IzLjAgUEhZIERyaXZlciIpOw0KPiANCj4gTU9EVUxFX0FV
VEhPUigpPw0KV2lsbCB1cGRhdGUNCk1PRFVMRV9BVVRIT1IoIlJ5YW4gQ2hlbiA8cnlhbl9jaGVu
QGFzcGVlZHRlY2guY29tPiIpOw0K

