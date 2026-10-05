Return-Path: <linux-aspeed+bounces-5131-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714FCCA5FCE
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 02:35:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyk4l6JV2z2yjw;
	Mon, 05 Oct 2026 13:35:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791167703;
	cv=pass; b=ZqhW8sOZ5Ik1F6p3Z0d9dG8LYeouJyYjemf/oxrHoiryDOUTTETq88zfzBfSFx0yrQm1MrHXZczDbKvkXryeWqbQ7DlkWS434/xnvaP56WbgR6PmoWTsrtDMeAM5srlJW1sBdDK5/P4+9EokM3znx/K67Y8HOuXVX0/314ZKen4yUz3KAyC2zOrr+Q6jUxa2PIBNcvSxoyWh70p5vjVzPXfM/ie5ivvQVxxU8GiH8ZfMeRfjO02X84OK6I6C48vgjczHbbXH+EmtWy3NIFu+i5/NnqTwKIOM0+zGvIAYJClp3Nnx6HAUx3jKCJLBt9WPt59GbR4VCHYcctQHsuDddg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791167703; c=relaxed/relaxed;
	bh=Wtzoq8ZtbflMhWPA6j63PkUOy7zNHVIVFq6DZJDDZP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikkRPhLts9v3C4bqJju5AXM8a6dQgqgjJkTted5tlf7yeqz919hIMnnshkAxUcHlczS8S9xfTHfhstofMX/h8n/bg42LzRsnUa4Vk29iZ5s/B78WYZwtVrLmq4a7R5G5RxfQwUAznKj8j4MKR2bMvSmR+SYCHN/NIfcYHRV7wCmpU1JRi845ciKTID0dTeULYxR+mRw6qLv/BRFuWKlmvB/FT8VQHe7Wvq/f4uBACmlhc6ZL3s8JWKnJ2PI6g0hLIsIYSdYfAwyHgyd+nWkrWLaW505I3E1xh/L0/9QLwjlylc6YbRFcbNfHzWyUtdBIol/l92MUPZ06R0biwZ19UQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=M73FtUAe; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=M73FtUAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyk4j0cBsz2y7p;
	Mon, 05 Oct 2026 13:35:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO+/22AuoSylUVzDavyNUK1rYytn+z6x7pKEv2RW3yIvFA9UGl/MkJPW+puG89awo+gFzVaolJSnOfNeh9JvxQqkVwtSIEJdLI7XE6J1q8HsKafClppcGMA5+gvSI2e91hB+QMyviamZa4njToMrA/VZ4B8wC1rrFx1Dy/L7VUCRm1tDFhDh1LAp2IF+Htn2mn+B8CrI7Z5k2cTfCADbxG/XETnZCLIetCWSLHzE+uLG65iVVmwWeHjV0d+jhXN0nIwfEwB83ttCkDIKYQ0KNW4vV4oTa5ZUELdYAS1gXKkbf0eI7iIIfR3MhnUfp6zWyEOvN8D1E2wd+aSUs7HWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wtzoq8ZtbflMhWPA6j63PkUOy7zNHVIVFq6DZJDDZP8=;
 b=dQUTfjT2l7w8YbIPcfqaLbPdlB2pnlju//rcu5ou6HGAxxNBPABbHxOsYIK3JH1S33CDRMjvWk+wKkZV892lIU7fkeTUtQim68RNWgRH6U+rsfKm/EHEgzir+dsH+YO65wFSpnLZNoxwfkdNd5Y/es0IHFvz4ehHq1nY1AkwdsGMVGp7muzkI2hcQnvnKT+GWssJkAnu2dq60Sgr8r59Vov6hm/GxjDQgdohIAMrAljwAG+9Hj9AAQzRwudpRov4v7uLpuaPJFxMeJsutPN4umMM67U6Lc4DoQ+xRYlvS/Hftl7tv4gToj4npPYx01mKXC4BpmGMh66rQaoqK3mbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtzoq8ZtbflMhWPA6j63PkUOy7zNHVIVFq6DZJDDZP8=;
 b=M73FtUAe2dalAg0v5bnsAaRfhyayLqnrdYFOQfmrTKqL03oe44bJLtx9KLu6yQaVYyAlpqIGc3OCAaC/vwnl9/sVEi2m7rfvZURZgJxV94UabUgF2hIwCWP8VLdPzytqqFTd+/hpUEtLL2KKbjm98s7qJdNePbcXq2wbIAumMz/colWxisnQxApFhZ4oP/Q6CgZ32G9u4H3GexIHHha0mgNaBu3wSIf7sQXc8jsAOytzUVxdv+O7D6Jq0rBoyzTPzaKpbrpI6a+i8F8QFTzO/mVYz2Wq5MXr6CItp1PHuArVxYDUU3m042tQdmt5ceUiNzNqt4zfMI0bNON/9KLINQ==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYZPR06MB5274.apcprd06.prod.outlook.com (2603:1096:400:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 02:34:31 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 02:34:31 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Prasanth <prasanth.padarthi10@gmail.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryan_chen@aspeedtech.com>
Subject:
 =?big5?B?pl7C0DogW1JGQyBRVUVTVElPTl0gQVNUMjYwMCBHUElPUDIvR1BJT1AzIHBhc3Mt?=
 =?big5?Q?through_with_gpiolib_ownership?=
Thread-Topic: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through with gpiolib
 ownership
Thread-Index: AQHdU+nGn6GaDDQtw0OQdpC+XgojQ7buO5Qa
Date: Mon, 5 Oct 2026 02:34:30 +0000
Message-ID:
 <OSQPR06MB7252CC7FC2131D45457A1FA98B962@OSQPR06MB7252.apcprd06.prod.outlook.com>
References:
 <CAMFFDGh6XwYD-axu3brX0Tdt3PteJHHGo6oJaghzpvnEyzT58g@mail.gmail.com>
In-Reply-To:
 <CAMFFDGh6XwYD-axu3brX0Tdt3PteJHHGo6oJaghzpvnEyzT58g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYZPR06MB5274:EE_
x-ms-office365-filtering-correlation-id: 221ff3f4-8bc6-48ad-0156-08df22892f56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 sWfBjZ7sa52VC02BaL0DvwvK2OxGJe4vdRI2FYgUJJ1SjY1LIOJvavKQBdGCRgR6c5sVYVTqejczi62zF24Hse942Gd5/1ZRoDvIMEUyXjm78bi3LIwLuwiRe8Xt4PQfmxGo/ndX94hpbtMgmKrY8EUwVHKIIMZgBEgjwUU8oxDVYrFMrpamDEQ/+/bRIqgmjxpsKXCowcO4K1ZI0uysRW9qTgMfyiaGxlswW7Wn6HKAR/XGnCCPFikDNDjFwbvbtn/4f+6pPlH/6uy3jHW0kvXcStKAnucR2jz3YhkYgeGYLhW5UWp59vO9Hh670dSQV/zl/yeu+8GC54jn9pO35N6G2sStl/ijv/uj7XNWYcnQnvFmO+3QAAZqJEmBiGEFga2akja835eJ2Hy6ja6l7GI3YnI5C/CIwFX5lhfJTfBnQRaGqdSS9RHatbyfHjG7LQ5T7IsyJzcIqv19QjgcKcU8bYa6ypJNOmBKpIwaPcVjj4urhYvAWKjBb+FeRyaGsAcHvlbr+5Vu2xbK2KsLBg+UeB6BGEAkxUNtGucg3z58mlkhQBwmjvztf8gXcPjO9osFbw7s3c8Hok2AFJBAgYMDHF4erIkN90MkyOSvqHzKr1EtIm/qUCY460T6AMPZinEzCHNwiCPkhz/mA5VHUKY+S/uk1wkg3JnI2LKxajfvHxqYaTzKkRNH9UjwWhSTkFNVTy/fVFggaSVnSLFMb7QGMRARJx0VNRM5m8ieKmk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?SC9BSnFmR1lHVmJEdTVlaGpIT1JxNWdvNlhnRUpCTmhFd0NsOXVSMGhycXdad2pP?=
 =?big5?B?U3gyak9kRlVBRkZJcDRydlZwN2xqRFA0L3ZnZE5RdWIvRWRleXlhc2tMa1cyd2RN?=
 =?big5?B?VklGQUhSa3QyL1NZcUQwZ1RobVdqdDZFcnh1cDBISzhUZkoxWDNyODhvRzRkUWdt?=
 =?big5?B?UVlZcG55cTJrQ0xTeXRDVjFvazRTN0JMVlZjOUZIV0ZTL00wSzd2US9OZUZxcDFB?=
 =?big5?B?Z25xYkQ4OHVmeFRzcHJnbHdmQ1ZBUW5oNjM2RXM0RENUWW5relhHRGpSWDdtaUNl?=
 =?big5?B?cE15ZXIxOW51a1pUZUZTRjdpVUIvSjV4OGlTMmxyalBEMWJFd0MvM0FodU9sYnIr?=
 =?big5?B?ZzFxV0xsck9KSFpmczBuZnY1ZnBrdkNrRW5mMVhhQ1VQNGMzTnpkcWxKQlpvdVEv?=
 =?big5?B?ekJJTjRsZ1NCRk5ZTXp0UDcrTWFidXVXZHdHYlJDQXFUUkFHK0piL0JYWWVxUFZZ?=
 =?big5?B?cmc1NWlYOXdTV2xzUXNLM2YzVTlRRFk4c3pOQ0taV0dXaWppZUJ1b01JT3V3V25y?=
 =?big5?B?MVM4SkJMd0J2WkhFME9uM3Zjc2RwNnZnSGhHOVpGOG93N0xXQmJVZ1gvMFNwT1NG?=
 =?big5?B?emRXU1NGbGYwdnpIemVlaUJKd0xldUE0aE56ejYwWjM1RnBjaEVrUlhPZHVOdXBZ?=
 =?big5?B?VlJYK1lNcnN5ZVJVQUk5MTZJaFdlaDM5SHhBZlBYTW56bXlCcENVd0VnVkVoZldv?=
 =?big5?B?b05vdk5DUnU0bVFNeVRsRFNMUlp1YVVEMTA5clFic1Y4dm8yZVJSSG4yZFkyTjBn?=
 =?big5?B?REtRbE9xNDlUd1hGRzlhSGF2UGpUYWdWTmlkNXBSWVdFVjdyY2F6bE1SemU0V0hX?=
 =?big5?B?Tjl4b1RDYXMzSEE2MUFVVC9sWkJRQUtNMDNNb0hKS3lXMmJFRzRkSTNzTUEwWVdV?=
 =?big5?B?YjgvdkFMakJ6Y05OUVZhTXZFTlZyeW02aXJxQ0NVRDNsQ3F6SWFKMS9zbS9sL3Vy?=
 =?big5?B?RktxVFdzaXFhOGl1cXlLQXQrd1VsTEtlQkhxYVlpbGZNQitpZlJlTkdkN0kvTVI0?=
 =?big5?B?V2lxN3NlamZKZVJQV25tVDVRb2FkN2RiMmxtdHdremNDZlBWMHQ4bGMwS2toT3dy?=
 =?big5?B?dk5wRlN3eDM3N0FzN1FFOHJUTUdKK3FlcU9GQ0pQbnZHOHBZUEJHbGFwN1FUamg5?=
 =?big5?B?TE1QOUpIV2xCYVV6OHd5Wld3L1U1N3dXaTB2czZoSGI4WGtnVjRXU3RqYUVrTmpo?=
 =?big5?B?SlJ2cDdPNHM3d2VVY2xMOEtzUzVtazQxdjM0cmN0cGNweWgyazVJZ29xZGdxWDM3?=
 =?big5?B?UGkxeVJ6cnB3ZEo0VUxCakszQTc1czUxbkg4b1UwQlhCSldXM0ZwOEZqM2djREpS?=
 =?big5?B?dXpCMFBhTFZVMVRxNm9sVkc1elZpVTEzK2IrZzlNS2xuQnVBWjBHTzZZWnlNbGxu?=
 =?big5?B?UHF1YzZ2dTRnaGlWRC8zVTlFdG5tQjdVYTRXWGw0R2FMcmNvZTRPOFJkd0V0czdQ?=
 =?big5?B?ak8wZm5uNmlCeXMvRURQcnZPaGszYlhZeXJsaDczWWFGTHlZVDNzTXh5VW5hTXRw?=
 =?big5?B?czBTU2krNGVtTFhMV09IT083QXgxWXRxcjNPcjhSU0dEVFZKM1Q4b2Jua1hhZjY0?=
 =?big5?B?TGxheHRFbnBlRWdHaWNFazUxZ1diUUJSd0oyRzBOZmZHUE5hQktNNzduMW9TYnc3?=
 =?big5?B?Y0I2eEQrN1Y4aDQ4bVk5bUN3enhaRGtmaDdWUDlPOGhuZU9CRHhKSG1ZNFEyZlVV?=
 =?big5?B?Sm9yc09QK2h3RVg4dmRvbkd4Vm0yL0tyVzBVbVFiclZSUzB3MnU0cTZNNHB0T2FO?=
 =?big5?B?Wk9iWTYraXRpYVFtQU5zN1A5ekhjOWM4ZmFkbk1EMDFQZkdKS1NwTWc2eEFObktz?=
 =?big5?B?UkZyQVRHbTB0b25oWFl4Z1A1SFprZ1pnTlFxRHUvZlFtd3RwN0YrKzFIWDkvVDY5?=
 =?big5?B?ZEpIaXhJNWNSampZVk1MZFJpQWJtRHk3Z2FxYlRUSktkM0pDdFVEVjRUamZNdXFU?=
 =?big5?B?QTJ3ZTRiaVpacnhiZjA4WjJ1bDkzK0dQZnhWSVAvNUpjZzNYV1ZPZi9ncTAvRDMw?=
 =?big5?B?RzJCZGhqS05jcXJNTVBLKzB2ZEZwaTlJMkhtVkpaWTFtNmJ6QXBuVzZxZGNmUHlk?=
 =?big5?B?RjBVNXIvOHRvR1RGK1hYajJ5WmhxbE1vRi9ETjg4SFRyNjY3YXkrRXlvOGhpaFE0?=
 =?big5?B?TS9qVlBWOE0yNWN5SVArRkY3UWNMSFE3aWRlZnR1UGVkcENQVFBaTmhxNWdJR3hq?=
 =?big5?B?Y0dyZW9iVmMzeEl1Q2xkNUZ0YlRVQT09?=
Content-Type: text/plain; charset="big5"
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
X-Exchange-RoutingPolicyChecked:
	5Ow+YlhCtObr45CEZyZ5761lPicIe7JXCbN7C/oW9xfpDkXqpLFPVgfywehRDDcZQRyPFRmx4U7Y8LL2pmZE2bJu2OEJ/UuaQSXgw8QjGZY2wGCZNeMeNT5uXOFZtmDfWDFacA6feUnv/ej1ordNsWZOzhAYLBcaDJXF36vWpNbuvWT6KFD8l4VSNBeZgg88IaQRnT+HDpNL6WRpMD+lky4C/lQ7+Lpq2r5mPld2a1BRxCfUnvRC48Mgh/oK2LAJxyyA1hYOK5SpbUqHZJiP9P3jlZysLGoZiNBn/Tefc5NZQ9o1OG4jaLP5cQMKoJm6gqb7kA4C0rXgDpa4mfHhrQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221ff3f4-8bc6-48ad-0156-08df22892f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 02:34:30.9512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: td3WSbuyP1LxB+rUI5dLuMa4zJQZSiQHaPx58v4TROpPsrW7hKfL/sQUBDa9s0IJ77v3Ilw3JsXtxmT5AGnahIZ9bPQ9sIhpf56Nl3HPPpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5274

SGkgUHJhc2FudGgsCgpPbiB0aGUgQVNUMjYwMCwgdGhlIFRIUlUxIHBhc3MtdGhyb3VnaCBhbmQg
dGhlIEdQSU8xMjMgb3V0cHV0IHNoYXJlCnRoZSBzYW1lIHBhdGggYW5kIGFyZSBtdXR1YWxseSBl
eGNsdXNpdmUsIHRoZXkgY2Fubm90IGJlIGFjdGl2ZSBhdAp0aGUgc2FtZSB0aW1lLCBzbyBoYXZp
bmcgdGhlIHBhc3MtdGhyb3VnaCBwYWlyIGFsc28gY29udHJvbGxhYmxlCnRocm91Z2ggZ3Bpb2xp
YiBpc24ndCBhY2hpZXZhYmxlIGluIGhhcmR3YXJlLiBUaGlzIG1hdGNoZXMgYm90aCB5b3VyCm9i
c2VydmF0aW9ucy4KCkNvdWxkIHlvdSBoZWxwIHVzIHVuZGVyc3RhbmQgdGhlIHVzZSBjYXNlPyBJ
ZiB0aGUgcGFzcy10aHJvdWdoCmFscmVhZHkgaGFuZGxlcyB0aGUgaG9zdCBwb3dlciBwYXRoLCB3
aHkgaXMgc3dpdGNoaW5nIHRvIEdQSU8gY29udHJvbApuZWVkZWQgYXQgYWxsIKFYIHJhdGhlciB0
aGFuIHNpbXBseSBrZWVwaW5nIFRIUlUxIGVuYWJsZWQgdGhyb3VnaG91dD8KClRoYW5rcwo=

