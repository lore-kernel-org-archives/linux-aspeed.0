Return-Path: <linux-aspeed+bounces-3709-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAC110854CE
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Mar 2026 02:38:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbCgW3b7vz2yZ5;
	Wed, 18 Mar 2026 13:38:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773801511;
	cv=pass; b=VHpGvZmGouo+T8gkdhN/DxFlJjYoWKOTtVfjqSlvVStEqGFivTs/Sy2gUEN8dDnVj7LPrnrkoYTheAN2oRKBNb5XJFiai3AfWWeHOFBDXo8n/jTfXDJF658Jfu9919knWrX74EegG6xxRyugFwPt1Vu12sS8JLZLhmRMFsxVYwgk/CYHdBcQ6sMoqG7vTr0gZdXl9ZgCTEs1ylM63frTaZx1T3MXAaxtp9lb0WPl29JRoHQXpC6qpjnZtGNGXLW+EVZdsFU7UvNT8oK2t4VOvR0aBoaY8K75OM5TBWGMv2xpvbUuz8DLfCvAvjz0d75B/JMaygDi/gMbnQBuRsqSkA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773801511; c=relaxed/relaxed;
	bh=2xs7DP/RKnl0T+VsWS91gTicWLp+3tV95HydZ0TPLAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njBKx0vaA5dDr6Y3BKaaPGIq7L4wCKyLD+JD8WMKz/NB7JjSCNiwu1P6zaszvfDsFlI1Q4z7/FMyyLY0+k+u6Z5qv1sQ1/OhiEHyYTRN/t2u2kc0gZHRI9ojiM2NwgEXXI7DWgTGE1+NuE3mUrWISHU2e8osclsfYNmmkCYPU380vZ+pS3OmfqzDY89vtpS3IcGmhfbFiwRX9mR3d8syhwzlqTedi9akBNaAP+1FLvEdDajzJCS/LMGSYiw5o1oGkvc1MT9GbaIiU89GDYw1b30lBN7/RAA+jZhgmqcT0SOcIAImAA5pTfMgaYiTGY2Pl8IG9jkjyTLxdvoSA/W2fw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=UI1SD8sg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=UI1SD8sg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbCgV06Q5z2xQr;
	Wed, 18 Mar 2026 13:38:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRHmipe1ltwA9DPxhxPXtgnesaGYw4o9j9KWQGGBSIdNDsUHqJOJj+9sptQbGQlyB4S797TyssliCGnDsBjUb/tPJvxtvopO7xyBL/nWHTx5yPsx6PAfDD6EIwd13pyqBSkUxbAgQIDw7r4zMbh4BVe8vMJt4nKIpvxjBd6V2STSkoAnM64wMinXJycx8Xf0qYg0Y17XqfBd5+BK9SymfOH3S2ePxLLm7nAnJWzonRjdgx8C5rQRbbq+2nqrHJm4zcWSHohEgcu9ifNZGBtoXj+E++r3HB3MhsP4s/LEcKKdX1vdrepDHHx8BwMcBKgAecF8CPPgPcG3MFzpmLHmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xs7DP/RKnl0T+VsWS91gTicWLp+3tV95HydZ0TPLAY=;
 b=lcIBHHIRHGNYvZt8JgHlzpa0TTSqfaBGqPDUCdbEwMOEAy38iug876sawNPsJQiUzKvAicr8TqmAuOW0fCJM41NI+gGwt/TBAXlA/KUxe6UWi95wDFbU7/i01ORHezViHWK0yRoxFUEmGTcngIs9HTFvoZK7HdqnMo73chj/xE/ZrOtaQtL3+7KOJmsmf5NlCk1TRS9TbAUJjQuaH37Cfctnyd0z1j9Zju7dYiIyNShj2IdgrNVqzbj6QM5VICIl2ZynST4Bcc7FMgb/f+N0s9xGMtSI6MyJmZ82gVZsodub0czc6y975F85FsvWSfTtDqSIg+DsvtTcozmOy2BOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xs7DP/RKnl0T+VsWS91gTicWLp+3tV95HydZ0TPLAY=;
 b=UI1SD8sg5TcYykUEycToG0qrmZCGTymqNdAGUDb2zM/uaWfUmokUgh1kmS9s57UlNPv8SASVLcP2ptefJF90HyovX9G0a4ps0px6tqTzXHHdC/fn4epnfl9X5kjxQ52MUiI/C7iGv8yRRiH9LLO1IIZScbz3PWMxVG3nzaKxW4eH7jCcL0W6Gs27Df/7d9Ex0wHg0QQPeRreqJZ8YiPwVO0VweaV2aOg729Qwo0q2IiW2FtpLXtIBvLwvuQkXJHrYVblZGAlZOTtmzIkuMJKkBqRwPQLmwN9WvC4M034vsg9TKfzqms/fqZThfymJxutsISlEcbnv/a2a4gykd3ZrQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYZPR06MB6858.apcprd06.prod.outlook.com (2603:1096:405:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 02:38:01 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Wed, 18 Mar 2026
 02:38:01 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Rob Herring <robh@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Topic: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Index:
 AQHcr5GE+hDVSyX/WkC7T78e6kO8trWtIRWAgAAQdrCAAz2mgIAA+smAgACHbICAAAQtoIABn/CAgAAK66A=
Date: Wed, 18 Mar 2026 02:38:01 +0000
Message-ID:
 <TY2PPF5CB9A1BE67264C727ACBEBE4642C7F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <071adc5f76b71b3e8d2691945e7b178602b285f9.camel@codeconstruct.com.au>
In-Reply-To:
 <071adc5f76b71b3e8d2691945e7b178602b285f9.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYZPR06MB6858:EE_
x-ms-office365-filtering-correlation-id: c82201e9-7505-4097-1858-08de84975fab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 AXOcYbgbEmT/sVBk52GVOijusd65oEo9XkjcrYz5gAdJCytDIgxkDJymkBQww2A3nyQDtDol72olDBDqu4zPLCBNyh9lVGGkwC2u/zNxCRoazfuoOhzeA+SsfrnlGBEuiJ6dbbhtMY9Zd8h6zYyxCHFvkQCRurueO2pzIn+EOEXSb800HjesZq7T0gwoZuQcNIdKDQRW8TfHkaPLc4P6Q5CINTpCahTBJAeX/2uqC1q+QMEkIMgUTqRQ2AVWerYozJRLMZlWHTmQ4zc2RP32cWbshyr0ui8qiVIFGZbsb3ED7+yc/N30M1XGVIxTk3vNPGTPNhdzuScoNdim7rxIbzBEUQDM0nFJL3e4+UkXWueIg8VaizieMN/rFEQVVFOy+fnRWFRe5jAsfvnXtNESK2/9k4gFgDe9K2PFSHTgRH6y+Cupbl/Kbdb2Hg4AX2BGN42pjknvmeF98QfScO6qplKc57vM6B27HpgqjYdjoMgmSve1PVrCUD2L8tIDHvJrotCWVZHGD2VSz6Y3Y2irELHeTrZ567Qk5BgSre6K5S7LfzNyYGzUe9msTFTEb53s5qZoUtvWZrs+4dMJpLKgsUQhYw/Y0a0R/WDIl6/Y2K97SyEqpfNXEuKzTROmYwNSbWIIKjWO8bw5UrSWi0E4+3MyfhCswKyBsqR4CPaDwq2g3NcDxFHfgaKr4fLcs/PJN3hbnVQrXPbJkbRmfWsyrLMRinRogjHiQhSYUdFR3GaniQsyvEbGLGsMZG2MKfrUXl7wXv3qmzt+uAlzlgCWKe5vzb+AKHdiQ1pHSCwBKgo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXNUQ3NwaGwrOGJsUzlmZ2lWajlCWWh2bmgrcnkvdnBsQ1RiT3ZjdmEvMTIw?=
 =?utf-8?B?R2dvNU1yUWkyNmpzOHorcHExVktFdHBNNUgzMjhObThnbUk2b0VuNWhDS1VG?=
 =?utf-8?B?Z3Z0SGwrcmVIVEpaUzFrWm13QmYrak1RRSsyb3dBY0RPUHI4b2FHYVFncExY?=
 =?utf-8?B?c0FkTHk3WkhwcXplK1JFeGk1Ny9sV1ArYmhTZGNadU9pZmlkdkZLcUhTYjg1?=
 =?utf-8?B?bkhZUHZnTCtacWtrUmJhVTdlR0ZmSG9hSmI3WS9WQVdrK3R4aHExemYvQ3da?=
 =?utf-8?B?VTNVY3duQVV4Ym54WmozMWhJZzg5UEFSMlJ6QmVhNGlqMW9YZXNZUjdVWUxn?=
 =?utf-8?B?WUVSVnBUa1IvcHlrWjNmMHRpSk1nWEtpUjcrUzloejBkRXhFOWIrVWh1dVBt?=
 =?utf-8?B?Mm5KZDd6VERSUWdtQk0xT3M1ZHRqczQ0QjVnOUF3d0kxLzVaQ1RqWm1VVkQw?=
 =?utf-8?B?MEgxRVZGUmVVY083RnVuRFZGcXpaN1kyOFR4UFhLa24xYkFER3dYZ1RPMVhh?=
 =?utf-8?B?T3lWWHJlanhpNmhodU16dklucnk2QmNYdlVaOWpPRS9CZU5mUmFSQkhHcUJn?=
 =?utf-8?B?MndLRjJpNXUyZ25ZSWlWTEdjQmQxbGdBQUVCd2E5dm9vcTJNNDVWZS9XdHRY?=
 =?utf-8?B?ajBSYlplbHVhbXdTSUFaM2dwQy9jZ0xRaFZNeFRsdkVyelZxTnFtY3c0bXZr?=
 =?utf-8?B?aWtXM2RhZ3V5OVlaQUdNNGpVL0VQOHdydDA2OVErTkcxR3BmeXNyVE5ZOE5a?=
 =?utf-8?B?d1VndDZRYnErSi92TFVOSU1NVTdnZE5BeTMyQWVSYlRRZTl0YTdJOFlJdEVV?=
 =?utf-8?B?Q1RrRFI5ZEJyMHhvR0Y4cFNRbFh2bFBzdFRNSGs0TXlTOFhrbGtuUTI5K2lU?=
 =?utf-8?B?RU5NK05MMFVFdTZTTGl4K05GTmtOb29JSDNrMG14RlZmaGtXNGVzMTBmZXIz?=
 =?utf-8?B?a1hVa0o5WUl3bkJqeFg4TEdVUGN6STdBQi84RlhvQkliaEhHSVZuckVKQ0lX?=
 =?utf-8?B?aklTbG9CaURVeU5BSVlHRDRzNDhibHpoQkJWU29ZNnA5ck9ibWt1VTg0Rk5X?=
 =?utf-8?B?RXZFbzhlV1ZhVzlwSzd1S2NURjNZSE1DSVlFaDl1UGVPQktsYTZ6aTA3MUYz?=
 =?utf-8?B?YXk1ejBMZ3hrSDI5Qmx1a3l4aEJ5RmJNTWI3K2FFK0c0R01ZUVpiMkxFeUFI?=
 =?utf-8?B?V2JhV05kSHVhbGFRaXgxZXpHMWV0VjZZZ2l3eFNEaFJqRnhpMDdTZGhObit2?=
 =?utf-8?B?QkpBZHBJNldubzc1a01HMlNJUVAyTmE3QWs0MndXekF1eGRFd21SM09ueHln?=
 =?utf-8?B?bFFFbWZYeUJMazBaMTFhSUczdWFtVWtyazArdmdYVTFZc1cwWnRGQnVXYXk5?=
 =?utf-8?B?UXprdWp4OWNPSUx4d0xycnJYNDMxR21LNE9SNG1yV1hUWHNEcjZ0M1hQTjgr?=
 =?utf-8?B?Mmt1OVBQcjY3d3F4dWVBSUFFT2s4YjkrNklDUE9GUmlQWVpITTJUZDVVajMz?=
 =?utf-8?B?eUJRczQ4WWd1WUZnNGdwaFRYMmhTZVcvaXZjVjBRbzdTSDlENFlJVk5PUkwv?=
 =?utf-8?B?T0xSQ0VWeURXY2ZYYzJteGt3NFVrakZSSVQrRVB1RnQ2Q2x6MmN0enBHYmFG?=
 =?utf-8?B?NyttemxzelZtelpnb0FUZDBuSCtkdkkyQW1uTCtFTUpKSGtVRi9PUllYOUtZ?=
 =?utf-8?B?VHZYbUxLU0xKSjRSSjJycXIwODVlbnJOS1BqRkRnQ3p6U1BHUE5lc3QxZUN6?=
 =?utf-8?B?aEpHUStQblZjcExoNzhlZGVnRlNJcWl5SVJlVTFScUZHb3BDeEFGdVRNcDc2?=
 =?utf-8?B?VEZza1BSbnozOHJYT01Ld2ttc1U4K2lxcnFLR0dPVVl4bEM4YjVQMWhHVU44?=
 =?utf-8?B?WmthSC96SVVFTkxNSUZrSGU1aTR3YWFCMjVlSzNmbVlBc3hVMnJBWkV2aHdU?=
 =?utf-8?B?aWdaVHVjWFJ1TzBZQktzY1o4MFlkZ0NtQnN2SEdiUTd1OXBvbE1iNExKb2Js?=
 =?utf-8?B?UzNsUjVQR0kyQ240M2lnTEpkQ0pMbXJWWW1BMlprcGNxODZPOHdwZHo5Mzds?=
 =?utf-8?B?am9FMW1FcFd1cE42NFdrRFRMNzBmU3BJcmt6RXlOcnovVGlzSE1tbDVCRGZV?=
 =?utf-8?B?SVdlVE1nL0JpbkZCUVlxUUJUNW9DUFA1cHk2NVUva0xLV1ZaZWtpcWhEdVZG?=
 =?utf-8?B?cnlpS0hsaFVYeVNiVHptZ1dvMkxQcTNBUXhoOEpsZXphVGp3UytuQ3IyRU1a?=
 =?utf-8?B?cHcxUjNmZGtaaWY4KzBCcElDbW5xYzVhdGFFYnNYWU9KYjBTU0hyQ0lDR1N5?=
 =?utf-8?B?TnkwWnNXeWxpb0MxL2JOSkxzRW9jeFY2VjM3b2RyL3EwMncvanNOUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c82201e9-7505-4097-1858-08de84975fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 02:38:01.2174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAAfSYIEfWbfgsIK5EHvXLmoDTZzk0IvhFHfi4CwCi+oH4njQ7GAa4YMYFv6hzU1CiHIcbhrGu34nekYA2b5mXetQzM8sOCJ6TrhTe0/xjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6858

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyNiAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgdHJhbnNmZXItbW9kZSBwcm9wZXJ0aWVz
DQo+IA0KPiBIaSBSeWFuLA0KPiANCj4gPiA+IE5vdCBhdCBhbGwgLSB0aGUgbmV4dCBwYXJhZ3Jh
cGggd2FzIG15IGF0dGVtcHQgYXQgYSByZWNhcCBvZiB0aG9zZSwNCj4gPiA+IGJ1dCBSeWFuLCBw
bGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdyb25nIG9uIGFueSBvZiB0aG9zZSBwb2ludHMuDQo+
ID4NCj4gPiBZb3VyIHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdDsgdGhlIGJ5dGUgYW5kIGJ1ZmZl
ciBtb2RlIGlzIG1vc3RseSB0aGUgc2FtZS4NCj4gPiBBbmQgYWxzbyBtb2RlIHNob3VsZCBiZSBk
ZWNpZGVkIGJlZm9yZSB4ZmVyLCBkdWUgdG8gdGhlDQo+ID4gY29udHJvbGxlci90YXJnZXQgYm90
aCB1c2UgdGhlIHNhbWUgeGZlciBtb2RlLCBub3QgZGVjaWRlIGJ5IHRyYW5zZmVyIHRpbWUuDQo+
ID4gVGhlIG9yaWdpbmFsIG15IHN1Ym1pdCBpcyBvbmx5IGJ1ZmZlciBtb2RlIGFuZCBkbWEgbW9k
ZSwgYW5kIHVzZSBvbmx5DQo+ID4gb25lIEJvb2xlYW4gcHJvcGVydHksIGFzcGVlZCxpMmMtZG1h
LWVuYWJsZWQsIGJ1dCBzb21lb25lIHN1Z2dlc3QgYWRkDQo+ID4gYnl0ZSBtb2RlIHNlbGVjdCwg
c28gSSBzdGFydCB0byBhZGQgYXQgdjE3LiBJIGNhbiBkcm9wIHRoZSBieXRlIG1vZGUsIGlmIHRo
aXMgaXMNCj4gY29uZnVzZWQuDQo+ID4NCj4gPiBieXRlIG1vZGUgcmVxdWVzdDoNCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMDEwZTU1ZTktZDU4Yi00NDRjLWFiNTctZGRmOGM3NWYy
MzkwQGdtYWlsDQo+ID4gLmNvbS8NCj4gDQo+IEkgdW5kZXJzdGFuZCB0aGF0IHRoZXJlIG1heSBi
ZSB2YWxpZCB1c2VzIGZvciBieXRlIG1vZGUsIGJ1dCB0aGF0IGRvZXMgbm90DQo+IG1lYW4gdGhl
IGNvbmZpZ3VyYXRpb24gYmVsb25ncyBpbiB0aGUgZGV2aWNlIHRyZWUuDQo+IA0KPiBXZSBkbyBu
b3Qgc2VlbSB0byBoYXZlIG11Y2ggZGF0YSBvbiB3aGF0IHRob3NlIHZhbGlkIHVzZXMgYXJlLCBi
dXQgSSBhbQ0KPiBhc3N1bWluZyBpdCBpcyBub3QgYW4gYXR0cmlidXRlIG9mIHRoZSBjb250cm9s
bGVyIHBlcmlwaGVyYWwgaGFyZHdhcmUuDQoNCk9LIHdpbGwgcmVtb3ZlIGl0IGluIHlhbWwgZmls
ZSwgaW5zdGVhZCBCb29sZWFuIHByb3BlcnR5LCBhc3BlZWQsaTJjLWRtYS1lbmFibGVkDQo+IA0K
PiBbQXMgYW4gZXhhbXBsZTogSSBzdXNwZWN0IE1DVFAgY2Fubm90IGJlIGZ1bGx5IHNwZWMtY29t
cGxpYW50IHdpdGhvdXQgYnl0ZQ0KPiBtb2RlLCBpbiBvcmRlciB0byBzdXBwb3J0IHRoZSBOQUsg
d2luZG93IG9uIHRhcmdldC1tb2RlIFJYLiBJbiB0aGF0IGNhc2Ugd2UNCj4gY2FuIGVuZm9yY2Ug
Ynl0ZSBtb2RlIHdoZW4gdGhlIGNvbnRyb2xsZXIgaXMgc2VsZWN0ZWQgZm9yIE1DVFAgdXNlLCB3
aXRob3V0DQo+IHJlcXVpcmluZyBhIG1vZGUgc2VsZWN0aW9uIHByb3BlcnR5IGluIHRoZSBEVF0N
Cj4gDQo+ID4gPiBSeWFuOiBJIHRoaW5rIHRoaXMgZ2l2ZXMgdXMgYSBtdWNoIGNsZWFuZXIgYXBw
cm9hY2ggdG8gdGhlIGJpbmRpbmcuDQo+ID4gVGhhbmtzIHRoZSBmZWVkYmFjaywgZG8geW91IG1l
YW4sIGp1c3Qgb25lIGJvb2xlYW4gcHJvcGVydHkgZm9yIG1vZGUNCj4gPiBzZWxlY3Rpb24sIEFt
IEkgcmlnaHQ/DQo+IA0KPiBUaGUgcHJvcGVydHkgd291bGQgbm90IHNlbGVjdCBhIG1vZGUsIGl0
IGp1c3QgaW5kaWNhdGVzIHdoZXRoZXIgRE1BIGlzDQo+IGF2YWlsYWJsZS4NCj4gDQo+IEEgZHJp
dmVyIGltcGxlbWVudGF0aW9uIGNhbiB1c2UgdGhhdCBpbmRpY2F0aW9uLCBhbG9uZyB3aXRoIGFu
eSBvdGhlcg0KPiBjb25maWd1cmF0aW9uIGRhdGEsIGluIG9yZGVyIHRvIHNlbGVjdCBhIG1vZGUu
IFRoZSBMaW51eCBkcml2ZXIgaW1wbGVtZW50YXRpb24NCj4gbWF5IHVzZSBvdGhlciBydW50aW1l
IGZhY2lsaXRpZXMgdG8gY29udHJvbCB0aGF0IHNlbGVjdGlvbiwgaWYgeW91IG5lZWQsIGxpa2Ug
c3lzZnMNCj4gb3IgY29uZmlnZnMuDQoNCkRvIHlvdSBtZWFuIHN5c2ZzIHNlbGVjdCBzdXBwb3J0
IG1vZGUgc2VsZWN0aW9uKGJ5dGUsIGJ1ZmZlciwgZG1hKQ0KT3IganVzdCBmb3JjZSBieXRlIG1v
ZGU/IA0KDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiANCj4gSmVyZW15DQo=

