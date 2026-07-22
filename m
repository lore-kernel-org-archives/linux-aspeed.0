Return-Path: <linux-aspeed+bounces-4521-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CACC44512
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 07:13:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4lpd332zz2ydn;
	Wed, 22 Jul 2026 17:13:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784704409;
	cv=pass; b=gw5n5EK6c8Q/F7iYhtozkUbV/AOUV671LA5YPAHBlld90kkI5uY6ZEzE2AJeyoRVUe5TEsTaEYmJQPns+GskVXV7A8FBEwkuKAPn2PHKWb0awu+071ea/qYX8GRDknPQglcxOSC7SoJSFhg8hnXluLDwFQucZpnA/sOe/qY5/Q+Thfmfeg7YBdwcjNV2SvvE43JY+CkkAb0/5F+8SSKYEe1RgRiTsc9SuKa6jlb0ql06P/Lii0XyWnOVKUV3R8pJCVqNTCBwcbx6fBIcv9610Awzry9JOmW4Sec0DZWOwuu/ao28+5N3+te9pPCcNpY++kEDi8cxY7lnNdlO7pGL/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784704409; c=relaxed/relaxed;
	bh=8zSjtJjo65BsmoR0tfNEhF1V8f8hOiMNumw8/OLiR/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ac6lWQLqJ1E5HZNV2r2DcQ7We9XEsewH9Yfg6p24MQehU/83n8m/j+G6sZGtV6SQjTqowrqTjaFhE6frxsMzp+y+ZO2HOkwRpF95GkKnpZHTa0rOvEU8q1OMkShwrRuJnEMgFcHl+Z0JNCoohR5uBi8sbGKIA6w79WncEylYudlHAtLzoRLE/yo6ilztQo0UNyr9Oqtr7hk3sscTrYlwlwbEMXng5Rf5lSJLihS4OnlK0opeGJTSfS/rZwRrhqa9CX5IvgoeNcmQyWlNaHQvi5IkuLjZtn6PE1UUGSu3hOJLgcsbqiK+2Q5C0q3PEhV4gIbl1nYOxAGdcIMDNVNFgg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=hT4nClg+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=hT4nClg+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4lpZ293Nz2yd7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 17:13:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5Pchl8iFqGZQutr4d2AeHDyvhTAAQGxGTcik1K2hVpQujxsgmjmKZhqVmZbPykhZNA4wt8Zrws3H9uOXobLCisPdMO4oyjT17vWGr25ttd80/nSDd+TlQYw1FVtQAn8uWb6n6J6YwG6xMJVsIuA1wI2eDN6MqkV+HZdhQJ8rVgFqubJw87zz6u4K0UDMXHQlyps2QeZGmIkAxZay97O+TT4qAjtNVFGqJIPpf2ke/1WkkanBdKwgk7uiPX64jFnXsw/cPqFW8GJNmYDPCrWCazFQQGacxiC8N4gC5KeCUrDxuTdBWo3ePGuV9L5fwgZwyoaNwBD+TjeX04yObMf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zSjtJjo65BsmoR0tfNEhF1V8f8hOiMNumw8/OLiR/4=;
 b=aJ/qya9sVTgdefnqsWLsiUvMqL55I5vARnAcgi0yrBX6DfpqfBSwYYgy4hx9cGGz0nWjqL4RcHp1NBmcO1OKG59pcogShsbAcOVLhJLwv1NkdswV0w+6mXT//CHrRGcJdSbLMDQIOmYqdCsuEyuVZwDxnfaf7HMIA11ViDjxXCx/BvtSruvdFeHH8HJi7vb2wLkDZaC/JmBtHnppvqG1G6AJQryvITklLarSH6kf/oasmCYNm8j2njsFv3srQnxRZ/c5JdueNEsVowscIc5mmyAKI4aZWotCUXQorg6XGxRTzONuapk5EBNgjHTgBu29D/viOk7Z23feqvn2h52Vzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zSjtJjo65BsmoR0tfNEhF1V8f8hOiMNumw8/OLiR/4=;
 b=hT4nClg+AkV0m2K9UR0BweiWx+mugIUQ2p/TEbfaIVaqPXzO64YKnUOcPlTxyzw+l77w+wnbxu+lSCh+w8DuokweWs510qvggE0fwhWN9bZKip5++3ks7hrGozHusi53bYX1uIIUSFQCKK+/JkiN5nQAb4LTybqeHqvfQvs58FZBglkRrNCa0V3O32/YRmAHaWJMTp+JTpJkCdv1/dqdgOTdwNCqDktKtRWcu87yCENVT2Euba+qcX4OCG/AO69Xib25ZWY9scddsnWlQL/1QExEyc8w19noCtiX5z7SYLCQyCDycdRp0kFYYWirWyRUDw9ZIladf0Vx6ZzmEpvqig==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE3PR06MB8665.apcprd06.prod.outlook.com (2603:1096:101:333::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:13:01 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::43a0:9857:dd1e:76d2%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 07:13:00 +0000
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
	<linux-kernel@vger.kernel.org>, Joe Wang <joe_wang@aspeedtech.com>
Subject: RE: [PATCH v2 2/3] phy: add AST2700 usb3.2 phy driver
Thread-Topic: [PATCH v2 2/3] phy: add AST2700 usb3.2 phy driver
Thread-Index: AQHchpNOnM449AUerUiXvoW6kWH3sbZlhJQAgAA9O2CAFICtAIAAA0tA
Date: Wed, 22 Jul 2026 07:13:00 +0000
Message-ID:
 <TY2PPF5CB9A1BE62ADABBBFA67FF51ABB53F2C12@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
		 <20260116-upstream_usb3phy-v2-2-0b0c9f3eb6f4@aspeedtech.com>
	 <ddb133ca1a3be605ee776b2276c1907c9ad32491.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6AE5B658D558EBDF24450F2F82@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <ca289e45bbde8e8a2f823a1660aa0a8f88e94bc4.camel@codeconstruct.com.au>
In-Reply-To:
 <ca289e45bbde8e8a2f823a1660aa0a8f88e94bc4.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE3PR06MB8665:EE_
x-ms-office365-filtering-correlation-id: 744f58f2-bc3e-42d0-b934-08dee7c0aa2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 VY8MRMuhs1tyKmpzX71ZbYuljGmlHZUH63leUIGdhVihPmQxxLr2K3pzYl4/7IEcq2MIP151Xq8YvZsOuRIzd+hlPBXGPAmZkNm5NeQqQAYHTn066DK56dkHuL6x3iNgx146nGrN4E6H9ztU+1Fptnf00cm4CUB11/h1DNrEpSflOu3PaYKkUcURP71ME5C/vrHcBBe3h66wCc7+uSbGMEwNEM1fHlUE18qQuqBTK+vzQPlkHMpQa5AobqyNMLqTqHaEN62xvnkxuH4RLJf9qHDG0ejNQebvJ7daFh6qJvAbP5zF9xIlAKV4bU0+jFehil3ex4OSgbrrEb64r+xS31H4UFQs7gelpVQeKyd7sUBGcJ3QZ66YAgtJK5PEnLmW7eohV8Tyncz/7692dclVRN6RKfc+qqu7nCx87hw0asNQrkcghp6xhs1rbTaGNLSnw3gNyao8XWu2i6XJceAgxdDjASgiW6SSoESH7kb2+OwI5WUU1wnDpD/aO3U+lncnUdQlGsTH8nR+0sX2xsr/hP70jHXLoPv/PUvDfSoRc6MbwnxWcK9x/ylLaHd/Of9JCnX4pSqcNfa5NZabwywMdIuCjDmK7VHKlJtgkd7keCAqWgGmAjayxRstX7/gMU28NkEauS2NEDPZTo07v7JdcxcCXbJ5uDPJCs6t+dZFxEK81djbp+XEf47bAGPryxkSFF8i9nDoVWY/YRjTzjPWvH40SWHkLFruhso6LUoVKYI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wm1rSGNpZWx6MG9XbjExT1A4ai9JZzl6ckwwM0Z3aUg3TDJ2QkFHZ2Y4ZFF2?=
 =?utf-8?B?OE1JTS84dTN0S3JTSEtHbVVScnNLQnNzOHlRNlFMSFBwMkk2OURTdklvMXZZ?=
 =?utf-8?B?ZjdUMlN0TjNVdGdGdmhBNDY1NnJ2d1hzR0t3TkdlUjY4T05FbkVmb2YzZGZO?=
 =?utf-8?B?eDI4c0ZSR1h1ZE5oK0JXOG9HbU1rL3RDQWtMcVRxR2lWS1FBOW1IZTBRRThZ?=
 =?utf-8?B?OVJnbUlORXN5T2xZbXE4TjcvTGlCUkJ0emtkenFxcTg2VzQ3cjR3bTY0cy9x?=
 =?utf-8?B?MWdKYmNsYVo5Si9zUjFTNTMxWWNIL1lsRmdIT2NCOWYzZXdDak95dlRjTnVw?=
 =?utf-8?B?dWJQVzZ2d2VQUU5nbTNqVlpRY3AyT1RoVWhocXNxM1haNkdnMEhRZU5WRWVK?=
 =?utf-8?B?V0FtdVFIVG02R2RwUWdlaUJBVFM5NXRVU0tZYkxmeXBQTU1kNE1ObE1tZTcr?=
 =?utf-8?B?ZnBhYk83VE1sRTlJNDFrQzhzazU3L2Z5d2RuYTZnYjF2UHRadSt1MWE2RWdu?=
 =?utf-8?B?QXZ4em54VDA2Znd1THBHT1RyWk0vdWlOYkY0cXc3YTBrejB3TWxaRWtSMS91?=
 =?utf-8?B?TENCMkJ0cjhlQklHenQ3OFozWmpZUEhDeDFFTUdmSTBjWXV3M1BlNDgwalhE?=
 =?utf-8?B?TFZJUWFiTVFjeGNkOUp2YWhyUXNPTE1EdW5RcUY3RDJmUjUrb3p5ck53QVM4?=
 =?utf-8?B?MU1LeTFJbER4eEQ5NkQ3R0J3bjRTcWQrS3lRMi85elJpMzQ0cXJzcjNscGcr?=
 =?utf-8?B?SmRSbGNzL0d6emV0WFkrTmxGNllPNk1Gc3lYNDY2eTRlaGFZanZ3b2Y4OFBt?=
 =?utf-8?B?YUhZQmwyK29meGNLWXVNRTRML1pqa0dLdnpKVDFrZm5JNzc0bHIwMys2SXNp?=
 =?utf-8?B?N0lpWWxIVkVRTjdGQ0lwRkVQc0dpS0NDUEZiTU51bTcyWVdHL3Zield5UGda?=
 =?utf-8?B?ODZ2MkEydTV2akpjUEdHcklZNEdNMVJPMHlERS9DWldTQWZnbWZNdDBKWXF2?=
 =?utf-8?B?K1JGNnYyaXdUS2dGMTlCZ2ZES0o3eXh1ODRFY0ZWb0hRdklYNlVkV3FVK1A4?=
 =?utf-8?B?SEhpdUMrODg1TFRhZlZYbEErS3pYdVFueWJMTVNUcGh3bGVOSXN0bmhQUkMr?=
 =?utf-8?B?NDBPSm43UmVUZE9kanp3SkJOejR3VTBTc3VCVzBwRktsTHpvb2Z5bndkeWor?=
 =?utf-8?B?R0ZKNWtBQ3RtdWl1cEhKY3FubHNXYmc1OFEwT1Q2YWo1WGJWSm02MVMwSUUx?=
 =?utf-8?B?NmxQUVV0YjBSZWxBQnBiRFlGTVlhVFIvaTBzUHBwR3JPQ0ZTL054bFdKeUhp?=
 =?utf-8?B?TkMrY2trcHdaWjVlcnNNQWI1cS9jbXorMXhBdlJIOThpR2ZOVHk2eDBpd09Z?=
 =?utf-8?B?SngzRFU2WEVTNlFYS3lCVk5tWFJ3SmxNRUhTbDVoRGRtR05qM1MxQ0JTcUk5?=
 =?utf-8?B?MVBUd3ByckFjUktoaVltN0tGNjZZTUc2VXA2NmtubE40dWZ3VXBJOUxHVUxB?=
 =?utf-8?B?TDZiUnc5M2hudEQwTGZkenYzakl5N0kwSjBnYkVxWnZsUDNhcEdVMW1UTnZz?=
 =?utf-8?B?QUZwbTdJUjNYZ05PMmRaaXJZS281QXFXVFVsQjFKOVp2V3JJSGRNaW1kaWps?=
 =?utf-8?B?TzlXV21MTDdCdlN0RGpNOWVuUkROSlpNTkpSTUxhNUxMYUloQ29KZWV1M0VE?=
 =?utf-8?B?c3ppY1pBdXdzbEwwUmFoYU5HRzltVVNrMk9rNXllaGR5R2NjMmVDcmgvUUha?=
 =?utf-8?B?N1AxQm5McGc5K2VLSzAvOVJIMDhaQ25ybmJiZTdXWE5LeWgyU2NRQkxlUEsw?=
 =?utf-8?B?Vi8rRmFMSU1LbnRuUENmRUY5TWlLdXlzNFNZZGxnWXdCS29sTU5jSk5RWnZQ?=
 =?utf-8?B?Y1lpMStoSlNvci9qdUV6YitENk9ydjVkNW03cTZKTlpJNHZWM09QM3lMN2Rt?=
 =?utf-8?B?UlBiNVUxMUcrb0Y4bjRMVFVPNWdzWmtWMVZ0WnJ6U3lhMjlkalNKaGJpaUdC?=
 =?utf-8?B?S2VzQlBvdHk0a2lVeUVOZnMyZWhyelF2UENheG45dHNBelJzVWx2U1MvTUp3?=
 =?utf-8?B?VVg3UjZjTHRQVEFrc1k3bEJzOU41V2tRenEvUVRaMVRCUHBSMW1KZTRFUGxV?=
 =?utf-8?B?T29reHRWOXZOb0ZRWk1hU0NUMXptZ25jbmdJbllTWURqcSt0aTF3aEhYZURo?=
 =?utf-8?B?T3JJWEp5bmN2eldPcHZJMWtQOHFvTUUwenRnVnkwSU5Zem5HQUErUldFalZY?=
 =?utf-8?B?VmJiQ21KNEx6YUhZR012dkJLZEN2cWdZUHpKSEdUclRPSi9GdmppS3dURTZn?=
 =?utf-8?B?aHJLb2dBS1FRMFUrZk5KQW4ya0t5Yk1IalpyQmZSVEgwdzBTUXIrdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f58f2-bc3e-42d0-b934-08dee7c0aa2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 07:13:00.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUR1W/BLFcoYeJDVocnhvU3RqKNkdLGPKeuESDWr7VvfYmpWbZETMR3YcOI5q7WXikAfjIEE0uTGQkIJk9RG2hCrQroCQXRvTg74Jfr3Iu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8665

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBwaHk6IGFkZCBBU1QyNzAwIHVzYjMuMiBw
aHkgZHJpdmVyDQo+IA0KPiBPbiBXZWQsIDIwMjYtMDctMTUgYXQgMDU6NTUgKzAwMDAsIFJ5YW4g
Q2hlbiB3cm90ZToNCj4gPg0KPiA+ID4NCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KwkvKiBXYWl0IGZvciBVU0IzIFBIWSBpbnRlcm5hbCBTUkFNIGluaXRpYWxpemF0aW9uIGRvbmUg
Ki8NCj4gPiA+ID4gKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQoYXNwZWVkX3BoeS0+cmVncyAr
IFBIWTNTMDAsIHZhbCwNCj4gPiA+ID4gKwkJCQkgdmFsICYgUEhZM1MwMF9JTklUX0RPTkUsDQo+
ID4gPiA+ICsJCQkJIFVTRUNfUEVSX01TRUMsIDEwICogVVNFQ19QRVJfTVNFQyk7DQo+ID4gPiA+
ICsJaWYgKHJldCkgew0KPiA+ID4gPiArCQlkZXZfZXJyKGFzcGVlZF9waHktPmRldiwgIlNSQU0g
aW5pdCB0aW1lb3V0XG4iKTsNCj4gPiA+ID4gKwkJZ290byBlcnJfYXNzZXJ0X3Jlc2V0Ow0KPiA+
ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCXZhbCA9IHJlYWRsKGFzcGVlZF9waHktPnJl
Z3MgKyBQSFkzUzAwKTsNCj4gPiA+ID4gKwl2YWwgfD0gUEhZM1MwMF9TUkFNX0JZUEFTUzsNCj4g
PiA+ID4gKwl3cml0ZWwodmFsLCBhc3BlZWRfcGh5LT5yZWdzICsgUEhZM1MwMCk7DQo+ID4gPg0K
PiA+ID4gQWNjb3JkaW5nIHRvIHRoZSBkYXRhc2hlZXQgUEhZM1MwMFsxNV0gKFBIWTNTMDBfSU5J
VF9ET05FIGFib3ZlKQ0KPiA+ID4gaW5kaWNhdGVzIHRoYXQgdGhlIFBIWSBpbnRlcm5hbCBTUkFN
IGluaXRpYWxpc2F0aW9uIGlzIGNvbXBsZXRlLiBUaGUNCj4gPiA+IGRhdGFzaGVldCByZXBvcnRz
IHRoZSBTUkFNIGlzIHVzZWQgZm9yIGNvbmZpZ3VyYXRpb24gb2YgY2FsaWJyYXRpb24gYW1vbmcN
Cj4gb3RoZXIgdGhpbmdzLg0KPiA+ID4gUEhZM1MwMFs2XSBpbnN0cnVjdHMgdGhlIFBIWSB0aGF0
IHNvZnR3YXJlIGhhcyBjb21wbGV0ZWQgbG9hZGluZyB0aGUNCj4gPiA+IGNvbmZpZ3VyYXRpb24g
ZGF0YSBpbnRvIFNSQU0sIGhvd2V2ZXIgUEhZM1MwMF9TUkFNX0JZUEFTUw0KPiA+ID4gKFBIWTNT
MDBbN10pIHRlbGxzIHRoZSBQSFkgdG8gbG9hZCBjb25maWd1cmF0aW9uIGZyb20gImhhcmQgd2ly
ZWQiIHZhbHVlcy4NCj4gPiA+DQo+ID4gPiBJcyBpdCBuZWNlc3NhcnkgdG8gd2FpdCBmb3IgU1JB
TSBpbml0aWFsaXNhdGlvbiB0byBjb21wbGV0ZSBpZiB3ZSdyZQ0KPiBieXBhc3NpbmcgaXQ/DQo+
ID4gPiBPciBhcmUgdGhlcmUgb3RoZXIgc2lkZS1lZmZlY3RzIGludm9sdmVkIGluIHRoZSBzZXR0
aW5nIG9mIFBIWTNTMDBbMTVdPw0KPiA+DQo+ID4gWWVzLCBpdCBpcyBuZWNlc3NhcnkgdG8gd2Fp
dCBTUkFNIGluaXRpYWwsIHRoZSBkcml2ZXIgcG9sbHMgUEhZM1MwMFsxNV0uDQo+ID4gSXQgcmVw
b3J0cyB0aGF0IHRoZSBib290IGxvYWRlciBpbiB0aGUgUENTIGhhcyBmaW5pc2hlZCBpbml0aWFs
aXNpbmcNCj4gPiB0aGUgU1JBTSAobG9hZGluZyB0aGUgY29udGVudHMgaW50byB0aGUgUENTKSwg
YW5kIHRoYXQgaW5pdGlhbGlzYXRpb24NCj4gPiBoYXMgdG8gY29tcGxldGUgYmVmb3JlIHNyYW1f
YnlwYXNzIChQSFkzUzAwWzddKSBtYXkgYmUgYXNzZXJ0ZWQuDQo+ID4NCj4gDQo+IENhbiB5b3Ug
aW1wcm92ZSB0aGUgY29tbWVudCB0aGVuIHRvIG1ha2UgaXQgY2xlYXIgdGhhdCB0aGUgd2FpdCBp
cyBuZWNlc3NhcnkNCj4gZGVzcGl0ZSB0aGUgYnlwYXNzPw0KPiANClRoYW5rcywgd2lsbCB1cGRh
dGUuDQo=

