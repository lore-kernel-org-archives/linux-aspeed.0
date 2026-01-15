Return-Path: <linux-aspeed+bounces-3344-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A66BD41157
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 10:04:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsJVD0Jllz2yFm;
	Thu, 15 Jan 2026 21:04:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768471444;
	cv=pass; b=f8eoKIOovi6jAL+TJEPGCF6VgqTatvZIaJcEdTqznX1GyFc0BTMpsGyhRGhIm6sAbrsYxzNQ2OEYrLTmBMFT9BD/1wQ4DS6gs6gVaH0xMcZdgjBG5WCCxWTWwmqhL0t/Ji7hMOj6fHBod9eyYJ/3Bgg0+gJbyHvztdUhrhuaZuVrwz+Hy6+pXNCvIwEascExaT6I5rNf9TZpAt4OEB+FOISt7B6g/h3oJnEIxRQTrkwYQM4PfKaDeSd0OAGQtKnRtgFeG9uilZqgB3RscoWfJG32JVefrY6o/5Zc/EdtQ+v1oACQAX4BEAotmC8ZBazFXlyUnzi6Tehelcjsau+YNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768471444; c=relaxed/relaxed;
	bh=w5L12ICrahOOdDT2dLN4ObhrxLbCfDNoAgpDYpT0zKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mem1Y6OPQLRwbfBYG09vfH885kp8g4cyyn9ATRuQHaOjRoTWDqWoOI/wOwdRrxGgfLlWiX+t447ynUppvuKQLT40njYPfcuJV0xoKbL+enyG3iHbnzopGI4n2tHqafGsA4b6MTeELcHjKsmgHdNnJw3XMxLV15B44vwFy+3hI5EVF1QeJDjDl2ipcScyWKx4WFe0lSvIdYaGJX8iN25BMHRkN3MIlYkm7juFJCUxDSw2qa4g/qBY9QsqMc5cTcBv9JlVEPdWj4ykkq1valiu2MUXlSbN5cDkf9K8jtP44YxwkbhcDkOV8mkdbF9kGB0G8UCT77NlPMEYGyViQdjEFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=rqpme+R7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=rqpme+R7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsJVC3GPnz2xNg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 21:04:03 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrh3dg5eyZylTc3eVXIrNbjWlO5fNQqpc8KIuDa/LiDZDQ+W8Yj2bsHEGYBfwF2MoUWFCTnYlJLDlvDIhSeAmZ/+JpQMRIDCwJWwxmX+CvVbERw5TTqxr1qPRdZAVttyGNiogVRj8M8AgP9jfkBDjmf7ESrAl1rVDMDqoOimw0fuGCFqG0KoxcL+SGfDTuM2WJaucm90UUEoc0JTSujfUWTxzDdMkFSLKca7EDNEGYLDaSR2aMpj1LZx9yoysgqjGfjMwQDGlHGWdtanIG7pycSicEA2wq3eG4saRQ+CPWQ9aTFbpLviXGVeoxjSuYnir5mIt53BORoGt2c5yvRPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5L12ICrahOOdDT2dLN4ObhrxLbCfDNoAgpDYpT0zKI=;
 b=RAtxuXSKSCHCJFvndh7BdwXpCSJg54TKFQbxnuQR+HIeXptTsKKmZ60ib3CREm5COr1oOKrDX32gAyqc8OIdZ0nwPr6dIAeNaZHvIxkMWfQGBOKlMPRA6tquLji53EsJVMud0kmbPI3fwyjiptEpAi2jRy9EWWUWcclBTfWJD1dfwV+YL6F4g3RUOtj45qfGJjZaiP3ZDgw1Ca6UA3SW816vzRoYHPNCNZonLgFSvWYeN4XQqDNRUz2Fu0D8fpsb9CluucMj7OdpGlhYpvM99LBMtr2PUADIQuyp9ya0PMbh1/UKoy3H5gHCZQvWX3xttl3aM4IWLU1m430ZWlpk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5L12ICrahOOdDT2dLN4ObhrxLbCfDNoAgpDYpT0zKI=;
 b=rqpme+R7VkDG/y5NnZ2KksmDsoByVY8UEvOHWUsWbzcWAmeRrgl+0Ht/9ec1sC6FUu1U8k5ZBXzeANnMJK2gtiI8Y3ViYvKD8QAneeZV0Wx7zwLAoW4wor6odldq4K8P0+nnFO195/Rk7P592wvbxWWQFQtWR3GXo4gYrY7U+7PGU9s6Anm80JXjYNllFtLdyXmnSQz2L4qcNBddKOJtaXl2va3plbm7+i8f8mlsydaNQHJaz/Gy2t3ebvrWjtw1sPlerMdVv2HjnEU40mkX/88bvhOFlbsHCgzZk3IgoKY7YeDoaie2qCdQM1qV6/9Q93w04wQRIMxkk15kkBkPaw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYPPR06MB7970.apcprd06.prod.outlook.com (2603:1096:405:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 10:03:41 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 10:03:41 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.0 PHY
Thread-Topic: [PATCH 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.0
 PHY
Thread-Index: AQHchSVBNAHlpZisWE+jalWIPjF+j7VS/3QAgAACmGA=
Date: Thu, 15 Jan 2026 10:03:41 +0000
Message-ID:
 <TY2PPF5CB9A1BE61C4D545AED6155DF2614F28CA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com>
 <20260114-upstream_usb3phy-v1-1-2e59590be2d7@aspeedtech.com>
 <20260115-tricky-invaluable-snake-abec06@quoll>
In-Reply-To: <20260115-tricky-invaluable-snake-abec06@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYPPR06MB7970:EE_
x-ms-office365-filtering-correlation-id: 98ae56c5-31c5-4828-2bc6-08de541d5cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlAvbUFvRVh2QjBpcm9nV3AzZWE4TGhIZ216aEh2N1hFeWdXSkxHTjRrUVNl?=
 =?utf-8?B?OEk3bHF0SXhRZm1CNDQydG42NVl6RXl4bUdscDBSSVFBbXZrR2c2aXlCWWVz?=
 =?utf-8?B?bWtDYUFzL005RFExK3diVW5WZ080RmN6NmIzY1BheTdmSDRWaGQvMFNCSGpI?=
 =?utf-8?B?NCs0OHVlN1g3U1dpS1dqNXNtVWZUK0t2cm0rR04zbENYNURtaDBaODh4TmZj?=
 =?utf-8?B?bm1IdnY0REtiUWNIWWI3TEtEaGFYZm5OVys1ZmNRZFZFTlNobUxoR2YzT2Vo?=
 =?utf-8?B?clZtMDdWMWRDZjJhc2pibWt4R0FKTm15WVZpUVNxbkxPaTNDdzUrOEgzUjFP?=
 =?utf-8?B?REJJUElWdWtveFNkZVJpcFZYa0plQUdDL3h0WHhlTmMzYmFBUTlhT1pQNkdK?=
 =?utf-8?B?QjFpMU0vTUJ2Z0Q5bWxLQ0NYZEs4aEdxL2t6STZsSjVzZmpRaGcvQmZva1JM?=
 =?utf-8?B?UzJuTXlkS0dVaUFXWE04cHlMcHlpNGVuODVBQjRHVUIwaWtZQWU5dlZrejUw?=
 =?utf-8?B?ejFiUXVDSHgrSGVJQlByYUV4MGRzdWpWV3VubUZBUGgxZmdPaXJESjZNdjJ0?=
 =?utf-8?B?bjhFbmdJbll6dmhpdE42ck1yTkZ0a3BKckZsYTZvUjB2RHBvck1UY2E0SStm?=
 =?utf-8?B?YWtVUWpKK1EzQmY0Nnd5NUR2ZUJsaExTUnZYbVE5YUdRTExHMnoxSzN5NWZv?=
 =?utf-8?B?dkdjckdhb21rOG5FSEpYZFlkZUhRVzd1VmRXVURrczd0Z1VBY1dlazdnMkdq?=
 =?utf-8?B?SHFudVQrWmtKaklmUkZOM2RFcGNUNnZJQnk4VkI1WUhZeWlDVlhmMzQvWVpS?=
 =?utf-8?B?cGRHZmo1MWpGVHBWaUU0S1U4SUZ1R1hzdGYwVHVsVCtLanhRN1VkZXJtc2V0?=
 =?utf-8?B?Wk9zNzU0RExaQS93SVRKQ2hwSXltVER2VjRFdFVmanNVUXlnMFdVSm9LcUtO?=
 =?utf-8?B?Q2Z5dzBWeklYMVZybTZvRlNtd1J2RmhhSlhQclQ2ZW0wMUt5dXBjdUVMakxJ?=
 =?utf-8?B?QVV0MDBJR09DRGRiL1ZKRzZSQlBSSlVsZ2dOSCtaRHUrRUJwd25aR0FTY1FX?=
 =?utf-8?B?bGRHMHVuM1lEeEhjc0hNR1B3ZERYNksvbEE2U0ZlTHpSd3YyelBSc1kwVkxr?=
 =?utf-8?B?cGV2TS96Y2FyMlZwVE5ITW45R3kvTjNibnRWTUZVT2xQcDVqWXhzMitUVnF3?=
 =?utf-8?B?RHp5Mllsa2RjUGIzRHdOQlYzVUQ4MlNja2doZG9wZzRMME5WUldWYW9memlZ?=
 =?utf-8?B?Tm5EcyttMjlLN3V2QmhFT1krbmx0dW81VHBZY1BKSW1XTm5QTHRMSElYbVNJ?=
 =?utf-8?B?NlFrbUhFcjI0SENhZVU5QXlWQ3o2OThjOTAwY3J6ekZOSExxWnVEU3c1KzJK?=
 =?utf-8?B?ZGNQSnNJeE1zelN3WFFxUlZpVjBDRmhkSzBLOGFoWUUwTkRxZ2U3SmJScEFV?=
 =?utf-8?B?YzkzRk5URGR3WlY5QWxQZlBvMFFJWmZGTDJZc21OS0ZMRVQ1eHpMbDR1a3Nr?=
 =?utf-8?B?TW5yQWM2TFdzWndYNEFxN20rdkNWQ3BtMFhUVXZDRFRick1HM2JVc1RGdE1H?=
 =?utf-8?B?R2dyS2tFV3JvT1E4Q2RRanZEY0llbW54eW55UWNhZHRQVVdjdmNBTVhrem43?=
 =?utf-8?B?b3dGQmxHNmVQSXg2Q2xzM2hpZHRZNktJRkY1emp5UWZteGt5MkZUdDRFSjJ0?=
 =?utf-8?B?Uk5qTDB0ckxwYjR6bnpLaGp3MVdKWVdBQXo4UW10ZmZDMkY0d1k5aUJMTmFQ?=
 =?utf-8?B?UTlXVW9ZWDNac09vWFhJMjQ2UDZNWEkzUWt3M0R2Nm80eEJid0pXU3lwNmkr?=
 =?utf-8?B?MnZobEp3OXJWUHk0bE8vd0J6R2NjZHpBY2dOYmdWWW5qZGhHWXp6dGFDR0M1?=
 =?utf-8?B?SnY5eEs4ejA4MGRja0N6aXpZWERPbXRJNU1MSllPQ2tqQ1g0S3E1WjJualpx?=
 =?utf-8?B?dE1nSVdSWXRnakQ0S1lwakZncHEyMm1aUk0xS2htci9jZWhmVGlnZnhOTkpy?=
 =?utf-8?B?SFVpRit4UnlzSU9ZSWN6aFdyMVV5WWpJL0lpZ1FiUmFIcExQWDZ6QnEyLytS?=
 =?utf-8?B?Wi93QlFvWXNTWVNtTFBQOGcyQ0Z6TDdUb1gvMERuWU5XQUQ5QllJMzRUK2tR?=
 =?utf-8?Q?MB/BPZ9Z2W9g0YNLu4xyRnkwN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K09rdVpQZjhQUzBGemhBVEFQTHFsSkFRcjNxZUpBNzF6ODZvU01ML3A0ZGZx?=
 =?utf-8?B?N0pVeFpENFhZMUdCamFxY3ZFaUo0eUsrbGJLMno4YTFYSFFvdHZkbVZJbDIv?=
 =?utf-8?B?ZGlEbzMwenRVeERBdEVuVHk3N1Fqc2RxMmRvRHBpT0s5bTlpTTVNaTZ1UW14?=
 =?utf-8?B?V016SE8yZDZycGE0ZlBoODlNTllNS2wrcmN1TXBFL3pmeFQ1WHczNDR0NDNZ?=
 =?utf-8?B?V0VkcjQ1eVlmN1pSSHFBaDVDNzZaZkswZnVwSTE1d0FEdWQ1Q3JpaGRsMUow?=
 =?utf-8?B?YzhRQm15K0Y3L2JNQkNTMkQvNEl1L2hCQUgwT1ZQUWhTdlJZclF6cVFVbVR6?=
 =?utf-8?B?UHYzRHc2TWVCMDJRRWJiTGpleE1Pbi9ONXhsK1V6eWRkNDBXRFNVdE1PcEl4?=
 =?utf-8?B?aWdqN3FETUdwdTV0clh5ZnE1M1NrSFJQditreDBNVi9ValVoMFlIRGJsbjlG?=
 =?utf-8?B?TXRTV0ViSVlMc0JwdDNZa1F5WDBCZU4xdHlnN2xaYWtvN1hCYVVoazFldEhM?=
 =?utf-8?B?WmUxMFF6SHcxeWtsWWh0UUtYWVQ0Qk85Lzl4RThpNmNFZFhLL1RmTTMvUmdC?=
 =?utf-8?B?WmFEOUVlaGtJYkdmbWZXb09UcGhuTHFqcmJpbG9iUXo3bkFUMzdoRUlCUy9k?=
 =?utf-8?B?cWRNdTk3Y1pudjYrUFN5bzE3OTZYSHpvRWlwMEJkNXJ5MTlvaXp5aXFSQVpm?=
 =?utf-8?B?ckRUWGJraHV4N3pKYmYyem1ZbVNhQ1Q3OGVzOGxMTW5qV0hrVzVhb1hjb1ZJ?=
 =?utf-8?B?ZlF4Zm44YWYrWDV0UUpLYlU3VG1TMzd5M1MwaHVoYWxteENWa05xZDJ1S21h?=
 =?utf-8?B?bFJ0R3JmMlBBcTY1ZFlpWjlXY3B0Ui9ZQmYrQ2dScFB3ejV4L0FhWE1hZG96?=
 =?utf-8?B?NHRrbWZoZ2l1RENvN3ZrWFh6UGttS1pwWjZ4N05UbzFxTXZZRzh0YnBCRHBE?=
 =?utf-8?B?eXl4cjFtRXhNN3JOOVRUUVRneFpSQitVNHQ3VVlHb0FjUVd0VXlSQWpxZXhk?=
 =?utf-8?B?d0hNK1ZFSmRGaEVGZ0FNOVNCQ1BvZ3BvR21wbVFFVmp5TG5wckRRRk5oMzdB?=
 =?utf-8?B?bW9xRDkyZTNnRnN0QlZTcTl4dlU0bmJVRW93aGY5QklKazJZQ2tEUW1SSXVF?=
 =?utf-8?B?SVpXdjE1MHc4R1JBazl4aXdtRVBWU3VWNTBwaTl5Zi8rc3pSVy81a3BNV0hP?=
 =?utf-8?B?cG1xT1FqMjNsbUcyNGh1bDhxQUxrY2FRQkdSR3I2ZHVZT2t5dXFOSWZwbng2?=
 =?utf-8?B?Yzk2cStnZWhxbUhiK1BxMW9LSmF5ZWRTUzlKRFJ6RmRKM3Y2TTdNWEFVWS8r?=
 =?utf-8?B?OXB6ZC8rRXpPR1ZLVFRaSHoyUnFlR2FaK1RVZUpNQTZjUFN6ckF5WWVYRVdF?=
 =?utf-8?B?T25mZWEyU3NiSkFGdGl5OG5xeUd3c3lhM29DaTlabVczSDE2R1gzUm9XbENo?=
 =?utf-8?B?SHNIR2xsZHJ5eGdwTkVOZWN2T1ppdEdYQ2V0MVUrQ2tQRDA0d2xBTURBcnpV?=
 =?utf-8?B?VGFqdGgzdDE0L3FGYkdsTUI4emovOVFTVi9TQmlvdG5Nc1V4dUpUTWNwS1Na?=
 =?utf-8?B?WnhhRWJmWk9pM2ZHRWVNSWpVOTlFV0NwN091ZzA4cEc5RTNEU0lWeHlKWXlF?=
 =?utf-8?B?c3ZCT2xQWENldlhMS2NpbkhpcDJwQnoyM3FJNzBOMElFNlZKM0JXRzVWWmlz?=
 =?utf-8?B?dms5MGV0cUZ3anRvQ2R6czU4WlhMRkpjVjdVSjhtd2ZXRmpFK3d3enpOb29n?=
 =?utf-8?B?eGFrUnNJMVA0TFdzWGc1SnB5NHhIbzlTR1E5MitFV3VJTmdtRm90QWVvYTBn?=
 =?utf-8?B?WThObWRDWTFZbHJtVVUrbHB3WEY0WUtXTUhIT2ljemhEeEJGMlpCcGRRQWpD?=
 =?utf-8?B?c3FaMGYvYndJbVExeVg5cFhTdWJXOEJtbE1kWm03UWNmYjh6WnFnZlpRZ3Zr?=
 =?utf-8?B?WGF3ZXJXcVhaV0pwS2I4eDh1RzBMcTluNXNFTklGc3JObHdsSFB3cGRkSnNw?=
 =?utf-8?B?MGp6eEMxLzM2QnNKQWxjV1E2UTVwaHpRL3hvTGdWUmQySGtSNnNpbGg1YjJC?=
 =?utf-8?B?cHRmV0JlQjJrMzhzN0ZoZ3Bhek9UR2VGMU5VbjQ3WUdLTi82ajNtRUFGVU5u?=
 =?utf-8?B?em9HaCtyT1NhbDNKcGFaWjN0SmVDQTFkNkk4aE8wb3BYaGtRbnkvYndFQmhZ?=
 =?utf-8?B?Nnh2ZzJkbWd3SVdmOCtteWwxYlJ4QTB0RmJLYTlpUU0va2JXQnpLbDdMM1F5?=
 =?utf-8?B?UEVIVWdjb3BNUmlDK2VYVW9WVlZsenBCT0ZzbldNU05ieUx6YVBkbmhMdUJT?=
 =?utf-8?B?a3NVZjZDSklZQy9DRVArV2tLMEZ5SlE5aHQ1VzVycUlRT1MybVpEQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ae56c5-31c5-4828-2bc6-08de541d5cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 10:03:41.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4t0deTqMfzhsXowYlRGxDHcScnSLv6Uj1Yzq/oc8X43hQ1xgJ9VxwF9sPTgAsb/GsJ+SLcGBWnXsPwENxx1GZacPxsJqZdySsvH3HbNsDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB7970

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IHBoeTogYXNwZWVkOiBEb2N1
bWVudCBBU1QyNzAwIFVTQjMuMA0KPiBQSFkNCj4gDQo+IE9uIFdlZCwgSmFuIDE0LCAyMDI2IGF0
IDAzOjEzOjEwUE0gKzA4MDAsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiBEb2N1bWVudCBBU1QyNzAw
IFVTQjMuMiBQSFkuIFRoaXMgSVAgaXMgY29ubmVjdGVkIGJldHdlZW4NCj4gPiBVU0IzIGNvbnRy
b2xsZXIgYW5kIFBIWSBtb2R1bGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4g
PHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3Bo
eS9hc3BlZWQsYXN0MjcwMC11c2IzLXBoeS55YW1sICAgICAgfCA1MA0KPiArKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5
L2FzcGVlZCxhc3QyNzAwLXVzYjMtcGh5LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9waHkvYXNwZWVkLGFzdDI3MDAtdXNiMy1waHkueWFtbA0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi44M2RhMjI0ZDk5YjENCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9hc3BlZWQsYXN0MjcwMC11c2IzLXBoeS55YQ0KPiA+ICsrKyBtbA0KPiA+IEBAIC0w
LDAgKzEsNTAgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25s
eSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9waHkvYXNwZWVkLGFzdDI3MDAtdXNiMy1waHkueWFtbCMN
Cj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQVNQRUVEIEFTVDI3MDAgVVNCIDMuMiBQSFkNCj4gPiAr
DQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVk
dGVjaC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+
ID4gKyAgICBjb25zdDogYXNwZWVkLGFzdDI3MDAtdXNiMy1waHkNCj4gPiArDQo+ID4gKyAgcmVn
Og0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAg
bWF4SXRlbXM6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOiBVU0IgMy4wIFBIWSBjbG9jaw0KPiAN
Cj4gRHJvcCBkZXNjcmlwdGlvbiwgb2J2aW91cywgeW91IGp1c3QgcmVwZWF0ZWQgdGhlIGJsb2Nr
IG5hbWVcDQpXaWxsIHJlbW92ZSANCj4gDQo+ID4gKw0KPiA+ICsgIHJlc2V0czoNCj4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVVNCIDMuMCBQSFkgcmVzZXQNCj4g
DQo+IERpdHRvDQpXaWxsIHJlbW92ZQ0KPiANCj4gPiArDQo+ID4gKyAgJyNwaHktY2VsbHMnOg0K
PiA+ICsgICAgY29uc3Q6IDANCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAtIHJlc2V0cw0KPiA+
ICsgIC0gJyNwaHktY2VsbHMnDQo+IA0KVGhhbmtzIHlvdXIgcmV2aWV3Lg0KDQoNCj4gUmV2aWV3
ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxj
b21tLmNvbT4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

