Return-Path: <linux-aspeed+bounces-1901-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D91C87FCB
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Aug 2025 01:40:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwx2D3d79z2xHp;
	Tue,  5 Aug 2025 11:40:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754358020;
	cv=pass; b=Dn+NArC8O2Q/42C7vCnfS2hJ3P7IRpEt76OOV4QX4TcifeHk+VtF/u1Hh6aN+gC5G9juhmr1vcKKgXoPajz8guQ9KytJtM3khAmtSpvwyBJwi9G+z44HEYQpt0IzC0AB6X5mqAqPtbKH/y6XhOCb7ObSrmJLBlCr9X0rdbwspe20Fds3LoEXqXhHT0Jl0ES7DNhHR735G/9eRntBAQtw+RDyCd+yXUcOZYAlMziCjnt1dJihJdjbK5qfX+bhFjz9KC6264duqGBCB4zccCHHK+TYSxZ2+NT5QpBZSN4uWaxrGejd+kpkLursXF456jKoVN/Hr6pHwHSkrR8PAyTd4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754358020; c=relaxed/relaxed;
	bh=/DOl1pPMt2LEiul0+kt/Zqk3fVTHUIqU/ztcSbMjFF4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FCGRlNZFQGsdRlU+lX+oPIem8KGAbpnyOc3qc8KIsw3hI50AlGJ2Cln6kZACorXoct8QdVBexZuvTbbubGdHVBR1pZoa+9WwT0Z/l5P9Z5m03g2GqShuJsxMPjDxf08wFfVIlJJTTnXMbR/ECxKvNSwmmhftX9z5c3ZngM7wJ9zpxXKaJWN5doQ3xATtpgiMwJUIStkmBHX/GfoUVtvuUrcwq8pfk3C1jdEwapJXFnXewpAO3ITIOg5TgIhS2i7NHoTvGBKlCYH6x18B08OO/sIOeudwB9rf1QNj4RNnzRHZUys+KORwtI0TqkpjyHkhJGjvInHPdlUMr3r8tBzPyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=LDA6fhyl; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=LDA6fhyl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwx2B5w2lz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Tue,  5 Aug 2025 11:40:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXbiWR/lpVr+bRZh4qGGi9Mycwt1H0O4Imot6DAs1AtVfx9Kyoz8nqumZ+Ghp31CtciddguBdltDDknN+jQ9MIO8GUvkLvL1CBdNOFo7nqx0P3+PnTobyA+UqIZzrSgke/Qiy0mJPSLIHvhEsCHUrYh5Ln6T2C8ukRpa35Pz8Lyut1yl6XEBm/9VceZV4yyL087XvdYARVv69JePkRY/7zHB8Qke0GzkZ+2ENCPTL5ZmtMqMuSLHibVDDLtMZLqNQ3AdZf8UuwWrvRA78KUe3R+KSrUa8naQ5ctdo+mqnZnYpmkEJ4uB5GHMCqHY8BktxLObJgih9tFks6RHHKuMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DOl1pPMt2LEiul0+kt/Zqk3fVTHUIqU/ztcSbMjFF4=;
 b=bnKNFT90EpuhMT7JaRSZ+vd2c0EbyJzbBOsDRD8efylLrBCWP+I1yH4FAizNW1JrN0EldDHYKfgwk8PzjFpZtViypX4t7Z7eEMQV5kF+OHRjSM0CTgx0onsQkEmuCZJaAKK4S3niey8cUNm2B950fk8oPgw/XyEytT1gDkavETWqtHHLrzYexakpKrZ2f6OAe3FGg6RgbF6+RmFuKi+YqAu3Vkjw4XE/BuJQurBiyp6/4dKxdbnbzslJvwMQibh2KPy6sCClXkgZfEb0UHJ2goa+a8SQpEVzwU3KigZwD4D8QIavryHTgorxpuxfUHOfL3VSU4WVXZJmR8+56o07eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DOl1pPMt2LEiul0+kt/Zqk3fVTHUIqU/ztcSbMjFF4=;
 b=LDA6fhyl8WN3Q10Hs3bXsltRoI++y+Si7qvdO4ZDYbn8iXOTDPQOly4TnI4Bm52k+NPZobWrkWBQLRwMrFVklIXKqDJcH198s8LsEDGiZlGZCHXxP18YGOIuavPXxes+z+91iOxZNFWtPOpnR5bpO1NhtYtiV2Tqf+YMCII8rDH7e6Acw/ucWoEceM4Jcbvouoqf6x9gk8etC9MmtTfBN6d7f9EZHMYaUW2qcXlXs9mwJDgBO48BZJa6CqKnMOeft0BV7PgRxYZOvQ/mhCfFhMVBHiyPJr1vhCOEstpzqwEQtlkmUSYI1MbQn3Y3Zxlf7i1rlpPweZRQvzPfHMDQFw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYSPR06MB6442.apcprd06.prod.outlook.com (2603:1096:400:483::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 01:39:49 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 01:39:49 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Eddie James
	<eajames@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] dt-bindings: interrupt-controller: aspeed: add
 AST2700 SCU IC compatibles
Thread-Topic: [PATCH 1/2] dt-bindings: interrupt-controller: aspeed: add
 AST2700 SCU IC compatibles
Thread-Index: AQHcBQF/LAmCZF1p/0O6zMujiYbqkbRSGeQAgAEtpTA=
Date: Tue, 5 Aug 2025 01:39:49 +0000
Message-ID:
 <OS8PR06MB7541A7408E490A8A39585B83F222A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-2-ryan_chen@aspeedtech.com>
 <19b91a3b-a330-41d5-ba45-39279185a2d1@kernel.org>
In-Reply-To: <19b91a3b-a330-41d5-ba45-39279185a2d1@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYSPR06MB6442:EE_
x-ms-office365-filtering-correlation-id: ba2c3859-c796-4534-13bd-08ddd3c0f75f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmJRdmpESm9UNVV0cXArNGU2bWhFbVJNYUZzdWFZZFRvZ2Z4WXRQajVmeHVa?=
 =?utf-8?B?cXZwVFdtR25ObHFWVm9MSWIvaUpqd204TVoxSVNxbytKRWtYamM1MXVYRjNa?=
 =?utf-8?B?dkYvZjQ3TUdmdDlvMmsyTE9RNmlFU0gyS2NLdWNvdW13M09SMCtqZzR0U1pE?=
 =?utf-8?B?MUt1bHFxVUtuVjIwbGJ3cTEwTS9ZNTNldHVMMHFTNW14c0JXblB3Y2ZtVzdh?=
 =?utf-8?B?SXlpQmdzZ2d5c0JxbVFLUGd2bll1NGdNYjN2aS9LeVpVN044WXFOVnQ4clN5?=
 =?utf-8?B?QVJmUGo3RUU4M05STUczaCtYaVJpSzhudHBobU9iWVp1amllcE5rRXNUVmlR?=
 =?utf-8?B?VGtYNFZ5cVVETlJsWWpXSkdmZEk5T3BjOTFDYlhGd3VNaDlPMkxwbTJzdUFO?=
 =?utf-8?B?dmk4amd2T3E0YVRwRk5GckxsU21RVmNGdkd6cm5HYW1Nb21nQmg4ckZrSlVq?=
 =?utf-8?B?RFI2ZWhQTmU5ODd6NFVnTUJGb0NtaFhhU3QxN0lKY1ZhZVJpZUZlaFFEU1I5?=
 =?utf-8?B?amJacWxIZ1RuaURBRitvK1dvak5KRVk3S3hieTQydXFlZXNsSmNFU0UvRitR?=
 =?utf-8?B?V3RZcVNNd3FvUlY2RjFaZ1N6SnRWYTM5RjJIQXE4ME9mMW1IeEo0SHd5OFNU?=
 =?utf-8?B?U2pUb3NJM2RhUmJkbTQ2WGsvTkZvM3h4Y2dpUnMraFY3UjhiUGpHMUVFWE9j?=
 =?utf-8?B?Y3ROaXU3bDNNZjEvZzE0VHFYOVZncXBaZTdiS3FyWi9LM1BCY1pYRWxJa012?=
 =?utf-8?B?MWM4NmUrUEp5ZGUzS0wrOFJiellHQVhEL3Rxa3FXSTVYSnJ0aGxFd3l4Z21q?=
 =?utf-8?B?Z3p4cjRrSEVyU01yM3RIeHRxaXd0VkhlcFRCSnV6aXo4NTB6a1BkR1gxVjFM?=
 =?utf-8?B?OXdxeWlvNWdRSDZ5ZVE1NUhZOFBqcUJmcTFLSktzU3gwUkIwcDMrZXUxbUJz?=
 =?utf-8?B?NEtlK1lQRlhKb0ZkNjJuQnI3WG4zajZUZyt1Y3dORjdzRHhSd1BNZzJKZ3g2?=
 =?utf-8?B?dmdjMmoyRUpZbXZJd1BiZW5ab0phMlZXbzlxRUV4ZklmOUlDOFR0dWZRVlJt?=
 =?utf-8?B?clpzenhSMGtzR3FJUW9yNVhaODBoWjJzZmdJREliYUh0QmYvS3YyRHY5ZGlB?=
 =?utf-8?B?SC9mSDlxNkF5aVZadkxNNjhqK3N1cGltcFd6L3RxanI0aDdBMU9hb0ZkenU4?=
 =?utf-8?B?dEw5NmpvczFnL3BrZFFIeWhYaXc2cElHZ2ZSR09BSXVVaTFCRUxqSm1Wa2pa?=
 =?utf-8?B?WTNtMHZ2TC9HT1p1aStJTFVUKzYrejBGZE9WT3U5RG85bFZiWW9zZ0ZwT08r?=
 =?utf-8?B?WVBVZk5TZzNMYzJsRkJJZGtNNHIrR0RERVlrd05BbjVjQ1hlZWZPSERGS0lL?=
 =?utf-8?B?bnE0SGJ2SThvcU9QMnRXOXB5SXFaQXFJU01vbG5NeVhKQWIxSmZBZWxITjU4?=
 =?utf-8?B?QVlJUDJZRHBRdWkyZjBLRGVkL0tlTHJ4bzFaMlRiNUFhcXB2ejVUR25CaTBD?=
 =?utf-8?B?cDFQZkYxRXRra2N6ZzV3V1FiVTBPcVJ6TzRydzZXTDlrU3gzanlJWm82dHIw?=
 =?utf-8?B?Tlo4dDdWRDUrVWxnWnZOMGxVWjUzRXJXWlNjL09DRjllUzI2KzB2L3Y3OEp2?=
 =?utf-8?B?dldVbG5qM1ZUWmhxOTNvNjBlNTRwTloxb01XT0FKR0lMS05lWFQwb01aUFVx?=
 =?utf-8?B?L3kzYmErL3ZRK2FCQWhCVVpNTXNXbGcvRThZUlRNVzBVNGoxSnc1TDQrS0Vm?=
 =?utf-8?B?VGVwZGFUSmx2YnExT0xsQjdob0dmMng2T0c0TlF1VGYxTGdpKzlDTGFiektp?=
 =?utf-8?B?OWZhbXVUUCtOZ1JlM0c1dE5RcS91Qk10UHU5bGJXb3dCYmd3OTcybWc5RXM1?=
 =?utf-8?B?Y3lKTU9RWTVONzBRNmJ0dlB5YnpFWGRZUkI1V3hoWFdBRW5CazRGa0lZNHBF?=
 =?utf-8?B?Yis0dzFIc2lXSFJLaDAyNE1CMXhNdjlIb2h2QnlZZkIwMkc5OFlMWjl3bDJp?=
 =?utf-8?Q?BgsAFBoyBw6lHrN7CpOdFnPeS63inU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTZZMDg1b0pCZHF1UTdjTkFyem9wNlROcFpQUi9QTTZTS3Bmd2VTazhLZGZt?=
 =?utf-8?B?SXhOMytheHE1Q1FlbmJwbEwzc3YxRUd0cWhsNkVtV054NzloQWhUL2JRMlk3?=
 =?utf-8?B?UklkWG1qRVpXMnRGQVhQaHc5RGV6dVZhRWRPaFZQS3R1Rzl5OWl4TmpWNW9E?=
 =?utf-8?B?WUpwU0srcHFMZnpmWlZaZVlXcXlaTE1oZS81aE9MaWF6RXRJeFVSOFovTzFY?=
 =?utf-8?B?YXVMWmFjcmhkVElBeWM4OERvVzRlczZZa1MyajA4Y0t2QWZteDA4d0dmNmZZ?=
 =?utf-8?B?ek41Tm5ZS2RtVWJoSHliZ1FoKzdsTWFIM1BnRjRGeE5oMmdpdVROd1Jqb1Q1?=
 =?utf-8?B?dk5EbERZMGtBQTZkU3lPUHBpelNua29LTmk5ejlibjlKSG44NG8vamRkWVhV?=
 =?utf-8?B?NWNtZ1oyRHU2RU5GUGJPWDZxY3hqMUFHTjAxMncraTZkWEZvZFIrVVNBdVNl?=
 =?utf-8?B?QjdqR3dQa3U0VWs5OTgycTV4SXpEemlSbjczODZUQUhxcmtJaWtuQ3hzWTZl?=
 =?utf-8?B?Ny9XblhYUm5vbmZjcTlVek1mK2U2NUgxTi9JeDExekZTNlhxbHcrTkZZZGs5?=
 =?utf-8?B?M3ErUVFjaENqOFJoZ2lTd0hSZXU5TmNBaEYzVjE4TFlBVXNRajVhRFF4QU9Z?=
 =?utf-8?B?aktjNXYvMGJ0UDZPYzVGbVdxRUFvbXdMOGZYOHJtT21CdlFESHRneDcvMFVZ?=
 =?utf-8?B?WkNmeTBsR1pvTUQzNEtIelByVllNekxCRjlWbWc4NXUvRTFlbDAvQTY0LzJ3?=
 =?utf-8?B?Z1haL2lhU0hESnUzRkw3Ly9zd1p6MCsrUEp6Q1dLMTU0RStGSTNRenZhU28v?=
 =?utf-8?B?UklGQStNd3RzdldISFVxYjRUaEtQeFdzVDVGdTc3MjFIaDhJY05wZFhOaXdO?=
 =?utf-8?B?cHIrNkZNSEZKRXgxOFNKKzhJZlpzWXE5RCtGbGxCeUJCRk9GT3UvamJoRlh2?=
 =?utf-8?B?SHFTZWxCR1UvdHFKOWplOThSTFk0UVV3ZXFQN3c0c09JV0hFaWx4aXRobnR5?=
 =?utf-8?B?cXlBVUNsa1NsUFRmU0V6akozbnJza1ZjUUc3cWE3RUY1eW1JV0lnWFFmTm1s?=
 =?utf-8?B?cGNsUmZEaU9kVE8zSUZyQnRzYzV4dHdsdDE3L0JNa3o2cUpkaUMrMUNGWSsz?=
 =?utf-8?B?dmRDbXozQnJkNVBMTEozd3g4U2hMOG5vYjFBZXBXV1pBbTZwU1hIU3BVb1Bo?=
 =?utf-8?B?bHRnQXNnTFpHN3pLdkNBUVcrdmlIZi9CVmlLeHJEUHpvbFNrdXdQT0VYQzdL?=
 =?utf-8?B?dGZZK2VLVU04blVsVFhmSmpIYUhHV1FLdjJxaVBGOWZ4WDlDbGlmeElCWmhL?=
 =?utf-8?B?SnZlOGNMbkx0K2tPaWdhajRNdkVraUQ5ZUdydmh3N2ZpY3ByaVdBZUlnR2RV?=
 =?utf-8?B?VnR3Z09ISE4wTGVZUGNWTXZLNGdDdmhCOWM5NDRUWEZBaHFOemx4WENJWTQ1?=
 =?utf-8?B?Y3FpbEEzNm5TR0FoN3hzNEZSNElvVUNkZFVrWHQ0YVd2K3JLT09sWWNMcnlM?=
 =?utf-8?B?RjloYnZNQWpFR1ZPYWV0NTArVDhBcHV5RlA0akFSUmZENGtxVk1RMTl2aXlu?=
 =?utf-8?B?TmkxNDhPODduV3N0WmFXamZab3U3bHF4bWdwc2FIcDRxVFpRbDJsTElvU3Bu?=
 =?utf-8?B?eHFTSnhjbGdFUWU0TzVSTjg3ZkhiQk9ZMlE0Slh4U0VONTdQMjhUSEJjbW0w?=
 =?utf-8?B?YW9ldENzZlorWkZaTFN3THBNVHZ0VSt2ZEk1WC9PdGtkYjJ2U1NxZUJra3hS?=
 =?utf-8?B?SHZDL2MweWJCMXl5aDhQdllEZVZWRnVkYmZUTkMyczY2TkhhNEVKa3o1dWV3?=
 =?utf-8?B?ekM0THhPQXdyanU5Z05zc2tYeTk5dWZlVHA4L0k5Z0xpUncyS1VRN291b1kr?=
 =?utf-8?B?NGFqQSttVHVQaElmSFZsd2RRZVpuS1U5TThIaHhtL3JOQ20yWjRkMFRucTlD?=
 =?utf-8?B?cUpkK3ZUWXZXVHU0VmZyMzVBdDU3NjVhWXZhS2RsS1NSNmdWOUpKc1c5a0lU?=
 =?utf-8?B?MkVVZ0FDWjlrL3h5QTB4Sm4rNENCWmJja05ra3VGSUVZYkVuaExDLzlvWGlu?=
 =?utf-8?B?Z0pqaVdqd3hQcmdwdVRwRmEva09wV3RiMXl3UkVhcnVKQWQyTC94UzdOVWhv?=
 =?utf-8?Q?o1fClfNJaHA6cZZYI0fwV7+ZL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c3859-c796-4534-13bd-08ddd3c0f75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 01:39:49.3825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLfcQfcEhgnGG2DGpYAErXYnYeRMlFHgMrMrHkpGsUMwmLR5Zl87oBfotOneJ3OZsyOrjeaKP/bNtsnBk9o9y0WCgn4/LFTXHoubDkOTipA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6442

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250cm9s
bGVyOiBhc3BlZWQ6IGFkZCBBU1QyNzAwDQo+IFNDVSBJQyBjb21wYXRpYmxlcw0KPiANCj4gT24g
MDQvMDgvMjAyNSAwNzozNCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IC0gQWRkICJhc3BlZWQsYXN0
MjcwMC1zY3UtaWMwLDEsMiwzIiB0byB0aGUgY29tcGF0aWJsZSAgbGlzdCBpbg0KPiA+IGFzcGVl
ZCxhc3QyNTAwLXNjdS1pYy55YW1sLg0KPiA+IC0gRG9jdW1lbnQgc3VwcG9ydCBmb3IgQVNUMjdY
WCBTQ1UgaW50ZXJydXB0IGNvbnRyb2xsZXJzLg0KPiANCj4gV2Ugc2VlIHRoYXQgZnJvbSB0aGUg
ZGlmZi4gIEV4cGxhaW4gdGhlIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlbS4gQWxzbywgZG8gbm90
DQo+IHVzZSBsaXN0cyAtIGl0IHNlZW1zIHlvdSBhcmUgbWl4aW5nIHR3byBpbmRlcGVuZGVudCB0
YXNrcyBpbiBvbmUgY29tbWl0Lg0KPiANCkkgd2lsbCBtb2RpZnkgYnkgZm9sbG93aW5nLg0KDQpU
aGUgQVNUMjcwMCwgQXNwZWVk4oCZcyBzZXZlbnRoLWdlbmVyYXRpb24gU29DLCBmZWF0dXJlcyA0
IFNDVSANCmludGVycnVwdCBjb250cm9sbGVycy4NCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo=

