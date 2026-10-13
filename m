Return-Path: <linux-aspeed+bounces-5178-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC8DCA9ED0
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Oct 2026 05:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3jyd3T5Vz3bqh;
	Tue, 13 Oct 2026 16:47:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791870425;
	cv=pass; b=mR1LMMnptjyE6RwGp6QRO+lo2v03RLrwJJ3/7SLDNS5dnbEo+pwbF6HLX6JvI+s25hC8RpkotkrvsApCUKqMGRYsUwusQR9gC8XY3pPQHExPTSvz7vCM0RdDkwMzGjvntz/sgnvDiKAtdrz0PjPUFQZFolAYrwlUt0zT6djjRCXateJ9OUK5iWg8ZsP7K4enfiLsptr3mW2i68I3JOB3d41XXzzvJlYldyfUvdkUlaM05AcLkKaxQtXV/3UXkD4l4UTpMLFKAKCqSNn8yrGeeiUYLwNKdG+ohMgqV0bAuX2RaYLpLXZc3eY3+qUSvEDlONYmoukAuZloeuK6hmEh1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791870425; c=relaxed/relaxed;
	bh=cst2eBIhdCMkloKJXh9zjv04CSd2w73zJ/tEv2xtZvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VenPX+pOyO1zNgrkjGGAZ8fVnIBTsNO8VqCGnEsfZ2TBaPmviVb7rbNCTPAGuRm+nt4JylgmmQqx1D5gvrnF51l5uQlPKU0EvJrehmLVo36fy0xjzQnbTmGDrp5lag9q92IOv3tWFECwNqEmAxO/iUp5VTeNM2VduVrD/heHIkWSsxifKOdO2lWGPKgpDEbtLeALaS8Tm3Vyy1eMLMiz3Yjf7onWLzrCMILMYWcOp7bJX0yxcHPhl/YubSbhLdnIV7JhrkzKAs8a4jndXsFkEvf3rN76fVjOPvTHkxZqV6NYGeGSHtFe/VdnLCJ5oG4+3OE4BbkUQrPXd6Ux4xUCXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=l/jRQKhJ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=l/jRQKhJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3jyc5C8Qz3bqV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 16:47:04 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJONilKyHuMj3X/8dgK9rTcnBxT28cWtf5HQ80AMCeNocCMXrHWDXU2ObSVDPaZuuB4ViKkvNcX/Mq3voJIVo8118L9zorqAEqV6UHg09rdURG37gSFXGfHssLJ0Mv2Gksww7/K3KzyXt99yaJVZsbYMMtxxhIUJK7X8elxwbQljM5tAcfHWFj/djKn0mifMpLyr1uAulLSPt6pyrOJBTQepghIHJ9zmeKsFzm6Cwd6l5gwF3MkLU7bfty4aQ05BWT96uTCS8tMhltNGWc3UlN4GQYEXabzqnr6JOB9psyiAyYLHCaDhAHcAuMHbvd9Xzsm/cyRHHiiMJ5BlpzR7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cst2eBIhdCMkloKJXh9zjv04CSd2w73zJ/tEv2xtZvo=;
 b=kD75IEcwiM2QoeJDflWVnUOPofQPwxZAICJYRE9KbDY9YDANQRn/TrmKJvQ8enbIdVndjOOH2s5+GBZJEQ8oFpC6zPo8jCwsWhLDwoQrtetTnTJsXJkQI0cXm6uj6Khck4soZB7ZG3dxUG0tjoYCIPHwtRhvpAyGj8/4e4GuTXnTJ75e9BRC3WMriNacS6KVBNVWJ5xSjtpw8WmEC/binH45GJ3MARLg8AwTVpDJWuBvFEAOBFGBBZSchc+AAYtGLDIWSzU/Gn1CJPajNtXkspKICuB/FX+jdgUgepGjxzK2hrQV8GqOpeASP37hV4qn7sp7UGdtxFNOqo2WgpEwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cst2eBIhdCMkloKJXh9zjv04CSd2w73zJ/tEv2xtZvo=;
 b=l/jRQKhJNbqfC72MQzda7btH3Twv5BC9Pyl5A2U1Wj/BXwfqJ+Y4yJqjF5IHaZn3FIQu3wXpaLNdI12O0qaVIR7tHe3OvTvB3UrJlOt/mr/glcwrv0XWg2doZcBGtkr/6NnZ+o2IYO6RL3gQKuQjPr9k6EjcIOELe/lMXf9/r6djfNnEHQNBMPQhkTAbsCseZ+jlXigYX7l3Xd9sb0Ri/0o7upY0BJLBirq+UBCAp8Zx1i08jJvyM4osveIhtfMRXgtZHy7M37/1ab/lYYOno7FH96pcJuHWk7sLRdFJNpze48wgV1sefkXSfJ47gCTujpEGdlWQ7/AlANSdoOIahw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB7000.apcprd06.prod.outlook.com (2603:1096:101:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 05:46:39 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:46:39 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Manivannan Sadhasivam
	<mani@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggMi8zXSBwaHk6IGFzcGVlZDogQWRkIEFTUEVFRCBQ?=
 =?utf-8?Q?CIe_PHY_driver?=
Thread-Topic: [PATCH 2/3] phy: aspeed: Add ASPEED PCIe PHY driver
Thread-Index: AQHdVxgnBL20YPLWJky4Vc5bhAVwAbb1BQWAgAX33OA=
Date: Tue, 13 Oct 2026 05:46:39 +0000
Message-ID:
 <SEYPR06MB5134569F41D37B0CD4D201569D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
 <20261008-aspeed_pcie_phy-v1-2-96764937aef0@aspeedtech.com>
 <20261009-cherry-caribou-of-glamour-adaba4@quoll>
In-Reply-To: <20261009-cherry-caribou-of-glamour-adaba4@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB7000:EE_
x-ms-office365-filtering-correlation-id: ab070e7e-7ada-4cd4-a26a-08df28ed5a4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|38070700021|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 IYv718EY0lkwv6LDEjj4wxuxxFykSoGVJx2ZaRr1ZlbGVs4FkzKqS7WMn1LdK/yfyoLqFTq73waIrOHIIoVFYqpl4lUfzFLWPNV3XzT4oOuEvm6OSy6ZpB6bZnDxzQYUfN+7MMn/M8ktSmOIQR+rTNAexKLdiXzyvteoHJUthCVLmuRVXHAZ9IOACzmka0xk+0wF3HbrUaxDh5FNs17gZgmAKh88ld2+E4xFj6PexwnE5Ma7tV+YdoNOeLvJq9UuXO5KiBafWeufJ7SiNh0EoKvqzq2MHqtM4YqOUHXut/1uqQXTO03+NriM3LFOnxIjyhxNhMfrYRNTClbFEuvsYnJthI6EcrkNkXAu2zdwp1nDGj8gvRxw9A5JCANJmYqumkSB7gtZ5loVop2Kn73v4nPHP3QbqPyEOsBBz/YoAYiazXTmEVoe6oRaxn0K21WUwsItNbXJI3bcgK5GAQkDyQIJ2JITiFZ+HCrkkblFoUGGO3HV2T8c1I2+s+VYUhMEBLVmasJvvGp9qe4UIqsWw9fa5sU11JiYH/O9ZCPQFWC/bqrKxXjsK1EQthP03ztdhkKpVuQjDzZ0Evzbt9vOAW6EO0gwAIEfZaqzyAgeB6iJcOGOH0f1SBXIrM7g99zafdVsVRM/jgqTDGfcrDEHmufkP/o2Gz6NC2/gW/obNBydcZS+YOkKBDfWcpLKlG4XQGPs4imbOVYJ8seH/GoCbvM6FkMVbtt4U2mVYkQiD/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THpxK0NYWG5UQTlMNUFmWkU0QXllWEFVOUQ4VTk3bDBPTnc5RWgyeHBpdXlO?=
 =?utf-8?B?VHE2Q3VxTTRBbXF2emhGc3IrakN4aDREQVI3VFZQbWhUdTM4UlF0VjNSTlVt?=
 =?utf-8?B?Mkhab0xadjlkUFpjclFST0xWaUNydTQvWHVPQmZNRGFza1R5S25hQllaZllI?=
 =?utf-8?B?WXJnNittSS9laTVRQ2lIRTdVQVR0dGl0OEVJNE00MkZLMUlwKzU4SWMzd3lv?=
 =?utf-8?B?b0txeFFlZ0ZkRE16OFJ5KzM3MUR3K3Z2cUpwNm1PbDJmdjdwdktMNVFRNGhL?=
 =?utf-8?B?R3ZvUE1IWlhtaE9FVlo1L2RYNGQ1a2VabVBESFdvN25Ca1o1MHcyRyt1L3Bx?=
 =?utf-8?B?MDNxV0IxWXBRR1NWWnBWSTBDZnhJdElMeldjamtiZkNtTW5SRjdiMEo3WURY?=
 =?utf-8?B?b1k1QzZNNW9vdWdwdG5PTkt4VlF6YmJIMUJ0dS9lOWRuQWdUcE9ONDg0cWVy?=
 =?utf-8?B?NWdQdlc0djFTdkNvdEJ3enlQaFhFSmsrSW9DKzlXUlBvSlZFNGpnbnRsOHcv?=
 =?utf-8?B?eGtiZ1VMZ1Y4bmV0TXF6TkwwOWxGSTNhTUYwdkdmR2ZlYmRPdjNabWQrVmNj?=
 =?utf-8?B?RXdzZzROVCtzMEhPbWtyaThtdGRQOC9lVHlqR29SZEJlamZHMnhYN1BIWEJu?=
 =?utf-8?B?R0N2dzUvQ0ZtMUxFLzFhU2h4SXdEVmFhVGFEVExnd2dJekZxYTFzQnloMExG?=
 =?utf-8?B?ZWdSaTRicCt0QmZhMnFMSjg4VnBMQ3EwcVJBSXJpczVDQkowZllldVVhSjJj?=
 =?utf-8?B?amlIbHdvbFk5YkN5bk1TSHVGbU12Nm03SldPTURLR0hrbmNtRE9uOFlGWVFw?=
 =?utf-8?B?U3VtVjE2MC9YWU8vZDJIYlgwZ1RBNEpDNGxQMUdpSmJzR0x0NzZlUm1ZS3Uw?=
 =?utf-8?B?VEVsT2dwWW5BSkRGZ2ZpWWNkamNGQmNhM1VoT0RiNjlKQ3EvSmJBV3pXSDZZ?=
 =?utf-8?B?dk5IK1piRmxPMGFOY205UFJmUGNlNmNuZW54eWFXWkdhcTRtU1RUaGxSaUlu?=
 =?utf-8?B?NnV0YnFPQ1Rzc09pcUMzbnFGeDErNlBqLzJWcFVlUlc5Y2RMY1FWUXAzOW5Z?=
 =?utf-8?B?S1o4YXpSRzNoZ3FobmpON0taSlpIUDFySFVobysyQURQYTlzUklwVWlZNGRL?=
 =?utf-8?B?d0pCb0o0a3ZXQ0p1UVBVaFFlb0JnYUVlNkxyRGp3Vkc0ZHZuWncwdW5HQTZ3?=
 =?utf-8?B?ckk2WEMyOVV4Q2laMVRsS0l5SHc3ZWc3RVVHOWlqL3FVZFJrQkVYdXpVV1Fp?=
 =?utf-8?B?MFJDZklvTkwwalQ1SVNnTlJtVTZ5R1dhUlhzd09JMzdzVWd2TmlLRWhPTkxh?=
 =?utf-8?B?aEhLY3pHKzVnaHVkcC9LZGdmSE1xcSs4ZlY0WW1FK1loSnpISGZOYjdGaWVS?=
 =?utf-8?B?YmtKQWVzZ1VBOVEwSzV6bUJMT3J5MkYxcUtrVHZma0p2c0JUVGxNZ3Ivampi?=
 =?utf-8?B?L1lnN3BjMkNjTjU3TFI5Ri81aWUrVTZRRlp0RyszSWRZV2FFVnVMZzEzQTg4?=
 =?utf-8?B?QnorZDlXelFJSm1heTRwVnZ4Q0VBczE4V1FQNTJWdDZ4NmFuKzlLTVRHL0xL?=
 =?utf-8?B?T3ZRREY4aGcxNG9Gdm9uSXpDaDRQcHpWZTA4Uk9qZmNZV2FWOUJld1J5cFox?=
 =?utf-8?B?SnJxZXVxdmtnQ0dmMkRDbDdDZUI1bmZuTmRMbDhEQlFFbnlDQ2tNVkNSbUZC?=
 =?utf-8?B?WUZzRG0zb0NxSmdpc2tiVEZLWTZPdjdmbUllYmlsWU9sOWpNaEhUTmxkZ1Z0?=
 =?utf-8?B?OFhJTWtsSXhuOU8vZmhkaVFmWU0remwzQW96NmdPcFRrcWYwaXFkU21aZ2Rz?=
 =?utf-8?B?TnZ0TUw2S2svNGEwK2ozNFBDZHNvbmg2MkJiVWs1SjkrRlMwL0FUNmI4VUVX?=
 =?utf-8?B?U3l0eXZ1S20rbGs3cGIvbHFRcUxKQnBSZ0pjQWhHT0ZBY2pJM3U4bFVNMmxo?=
 =?utf-8?B?VngvcVFHdGxFOVcyVVYzKzAvS0RRTFYwSmxsUlZOSUtsSW5DcXJjNk9NWXEv?=
 =?utf-8?B?R0E2K1BabFBxbXRhaENIWFl1clBkdk9oWjZ1UXY1TzQ3WkhnQzRTOVZteGY0?=
 =?utf-8?B?azNBVkh1MnludVltdnBQdWtTdk9NeUJxb3IxRjdrZ2xlZ1dUZGEwSU9aZ1BT?=
 =?utf-8?B?b3NERmxwWDJoR0NKVGJyekJtWFlrUFhKYU9TT3NsKzFmbEt2QUxlZjJrYU54?=
 =?utf-8?B?VU9lWGpoMkNxZDB5cVNUQldkaXFCZTAzK2l5ZW9zMmR2RzZzNHFIZEthZW5j?=
 =?utf-8?B?bUtybUFlKzY0WnNXcm1EL0U3MkxmVGx4U1lxeEhKa3lNZWo4dDFLQjlDQks3?=
 =?utf-8?B?TVE2bW1JZ3pSZEZnYlVrT1lkNnZzVW5BRkN6eDV5WE5hQS9Cd2l0QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab070e7e-7ada-4cd4-a26a-08df28ed5a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 05:46:39.6327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LSuV4iFbQDRQGAUOJwOZ/dpCVz2BYdNWc/XSz6HKfiTHUuYyrdzl/+XJRSrqI+Bbvm+WeBo5ib66tLDJWzqxk2d2MWjH6sybVU1Rxb2IXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7000

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBJbnRyb2R1
Y2Ugc3VwcG9ydCBmb3IgQXNwZWVkIFBDSWUgUEhZIGNvbnRyb2xsZXIgYXZhaWxhYmxlIGluDQo+
ID4gQVNUMjYwMC8yNzAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFja3kgQ2hvdSA8amFj
a3lfY2hvdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9waHkvYXNwZWVk
L0tjb25maWcgICAgICAgICAgIHwgIDEyICstDQo+ID4gIGRyaXZlcnMvcGh5L2FzcGVlZC9NYWtl
ZmlsZSAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcGh5L2FzcGVlZC9waHktYXNwZWVk
LXBjaWUuYyB8IDIzNw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IA0KPiBBbmQgdW5saWtlIDEwIHByZXZpb3VzIHZlcnNpb25zLCB0aGlzIHdhc24ndCBldmVuIGJ1
aWx0IQ0KPiANCg0KSSBidWlsdCB0aGlzIHZlcnNpb24gd2l0aCBhbiBBUk02NCBjb21waWxlciBh
bmQgZW5jb3VudGVyZWQgbm8gZXJyb3JzLiANCkFmdGVyIHNlZWluZyB0aGF0IHRoZSByZXBvcnRl
ZCBmYWlsdXJlIG9jY3VycmVkIGluIGFuIHg4Nl82NCBidWlsZCwgDQpJIGFsc28gdGVzdGVkIGFu
IHg4Nl82NCBidWlsZCBhbmQgcmVwcm9kdWNlZCB0aGUgZXJyb3JzLg0KSSdsbCBjaGVjayBidWls
ZHMgZm9yIGJvdGggYXJjaGl0ZWN0dXJlcyBpbiBmdXR1cmUgc3VibWlzc2lvbnMuDQoNClRoYW5r
cywNCkphY2t5DQo=

