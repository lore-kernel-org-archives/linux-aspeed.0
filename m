Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE4606A881
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=opFlTzW5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTnGv3Sx4z2xlY;
	Wed, 18 Nov 2026 14:32:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794972759;
	cv=pass; b=lJaW1WaLR7UuUNBCf6yLU4NloFsN3GzkmJpLcO+teE/EiULoN6VcvDf8p8o7fm1hhiXxKYrEM6IzhGymkVreUmw5d/jBK4qZb1l3+/psCkYT0khiE4ElzKonidsjqdz95VA8It0k0ktkGjM4CMLCOymbgYkrMJbPJTjxWbz+3wpm+Z3KtS4N8RjPY0Xd490FSopFkYKX/N9+bdXA1yHBzPpuQMHh0NTXUhvCRd250uobnbFJPaQV4IvfmS62xdm37na/KQ9lQwGZp4SeLYRZW0/vBrf1AaPTeblGWQkpD4sme06Oks3ILIGMDh8FNqLb/ej7UslXOZU3As3iTFbxRg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794972759; c=relaxed/relaxed;
	bh=awx/jlrCKfTcHpeyeG9prOlcTmrzWR7zJ064mfXIBDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFoiAkM4Y1WW1PeJnjvtWXxMbrpvES9mpoFuyS8XRtLIHXv2jPExUAyeiUc42QQySUqvIVsox8iESMNNTuGVHHyTSfE1y50BEqLn590WJXRMQI409MECLL3Fxl7vY6IRKEO34t5jCkyGvkdhoglrTmOjXnKzdnLDxduKlKChNKyH5hsv/yZmFYypP/tgA4SIYR3OSHEe6IlGPoAM6sGYFmPx79kAyQr8KVXbQIiAO1jBH87053o8KnWHKYgxy3Ye8sQJAJ4N2lcyW1e/FDyLcAN7AFAz8FCsDawutifjfICK1TH+DGyvsJaFMgblXSBb5up4lJuuJO57AwI+xtEXpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=opFlTzW5; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=opFlTzW5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTnGt4qh6z2xNC
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 14:32:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0EhD5qs4A951vAzJboe/zc8nKV6HrG+y4aS6nEBTwOh7yKjvC9QoROQ6LcYuEOADwQtMAi2EPhlAI44vvnHltzzh09UTaCZxs4HkDCrmvmWQZ4rUS6uPZQT6wZwGNjUKPH2ZIYG2+QlEvP9BTO3+J/PwYCaDLMXisbzweatUTZ9HGnZCxRFs7WmFEyjlKBU2S9eR6UHuelMCoPW4qPEAb8yz5hIwMZe4LiNZAY+EDye/71k7A6adJJYg5HPa/tNh+KpQNDpLOsp0C4qGHd0rfwN7rq8p4Pwk+jnKKBtRnrIwjjEzJMBLERE9gNXGiTq/R9AWtBq2ObdZZ1dUutgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awx/jlrCKfTcHpeyeG9prOlcTmrzWR7zJ064mfXIBDc=;
 b=dMBqakk8szwtXTkMR2Ewibjmg1ZhzlZALzjBgUXNDAWUUOZicBgfpyw9zo5A7B+1ZymMuWCiUVQGJJUWwbl2zsVWpPCVS375S1coT/OrUOeWb87leKoBb9RCWYflc1PiSRK4ncROB/t8pj1QQdNR6esXz/5tW9LMR8pYFdPp75VhWgRVwEDbCGfGC+D6GFHvHkQkZJaxUft3Uh5X28nlN3lFfGp+eXcFeBa1kQzU3p1rDNDca55MWudt/WnQxnfFZVD8JWknDXke89h6EByrkVYFKCqGEC1Qr5HkCEU+4ZHAFL9P4cd3JChWVeePyEWwnzH0UicWJA7IqOnN+E3/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awx/jlrCKfTcHpeyeG9prOlcTmrzWR7zJ064mfXIBDc=;
 b=opFlTzW5HJoN5ju50Hd3HJuOrQ5pPds1Rj3n5a3q/uWMqsBVhYtZDQ0QuoVYjR9b+bme2H0BVu6F0SCz7CaDzfBRUardM7m+ut3bmKLfUUt+bhUYAFOwRZjhGfA7MT0TKhC56im0Ojhf0Xn6KbnGTFO3nwr79KKNvo6+VGZRG82D5dVlxRMl1RCOO7CraiXOQcbPGKmNFMaIfIKiPQ9hgiA7jbFgn0oNiYX6eSJYUwh30fySKy+goQH2m/kqX66tlfLdsOmv+WmN1V1txPyrJK3f7bZ92Gh20mfKTfpBYTBjQqhcD6+30i8WDih2jnRwAIAlrUEMeaZuB9/DnA+YLg==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by OSNPR06MB9002.apcprd06.prod.outlook.com (2603:1096:604:49b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 03:32:22 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::92af:c9d9:8779:d19%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 03:32:21 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, Ryan
 Chen <ryan_chen@aspeedtech.com>, "tbevis@amazon.com" <tbevis@amazon.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIHYyIDcvOV0gaTNjOiBtaXBpLWkzYy1oY2k6IFByb2dyYW0g?=
 =?big5?Q?AST2700_IBI_termination_threshold?=
Thread-Topic: [PATCH v2 7/9] i3c: mipi-i3c-hci: Program AST2700 IBI
 termination threshold
Thread-Index: AQHdcYsUM/sgV1Aoakuu6XYDn3sxSLcpHvkAgAoXjYs=
Date: Wed, 18 Nov 2026 03:32:21 +0000
Message-ID:
 <OSQPR06MB72523D56B87D06FB5A5AF82A8B7A2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
 <20261111-b4-i3c-hci-ast2700-v2-7-4d8fff5c5196@aspeedtech.com>
 <avSkAIS82rYaLZvH@lizhi-Precision-Tower-5810>
In-Reply-To: <avSkAIS82rYaLZvH@lizhi-Precision-Tower-5810>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|OSNPR06MB9002:EE_
x-ms-office365-filtering-correlation-id: 7502c2dd-92ca-476f-7ab4-08df45248e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|18002099003|22082099003|261009223027099003|56012099006|4143699003|261026140227099003|261028144727099003|10067099003|261026121527099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info:
 w7EZJG9dq+e3szrQSPuNAADzEFYd/UDL61VN+ssND7oqSghaL5J30c+2P8DZQbzuVNZBvUfqlSyTb5TmU9FF7Js1CdBWo0NMSytx/JEv3GyvzwFD9jvr7b78ZV+P9bwNvRT/NYtM6XxxC3E/TaBN1xkgsKB6t81ph+nhYgFzsvjSmsZnYwLyfz+765Hzpzz1k3hbMF283JXxltzazgJtHnJnZmxOOLMacl5P+hzzryEhs1Wh7MWYanhpVIRkCJl8ZjTBlOeTRyYcpuUP0/tG0tyzlQ8TuaEaG4pjEosCh3OmwLU+ew7JuvUE/jfPnZQFKAGNr6//wGDc7R+XKMyy/BR/y2+tlHZfPmdB2IEt3W6WpdDV3D6jdSkRFu1U2CYZl8yC/FtmntAUpmIEGBJB/78yxsTm9TD46H8cuuGWMzJYIpAObj0ibsIFoRqZBKwYUmfdn3NhoQUR4EpKr3EPvJWTCWfILOlCz2dRROYOMB7wxYks1inGS9C1wNOzFB9FSeYpgQ6ARIJhqAbYyqRmQwcvZPymhQ9lYGSHipCYv8udwkTpdCGpXmU9hbvBQjYAXIh6LD7eBr0uHnlx/xXvznruWO5ou9BK5DQ7OsooHnUi6GwfCGxOnRyY4PNYS3n70nBXmzt/Kg1K9ideBJYBP0i2+AxmH5ZDFg02tIRjlzpJtveqanLMoqvHi4sKwL8y/93KKcmaoteSNgYYPoukvw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(10067099003)(261026121527099003)(261022105027099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?ZEljSGZsa1k2OUdaamhpL3Y2bm02TkY3eSttN0xOTkVsaGdhRTg5MHcrVlh4RFlj?=
 =?big5?B?elRxblhmakFJYWdOVTdRSzM4bUxEa0FseGZ2ZEdpdFBMRjNwaVMyTExkOE9FdnRJ?=
 =?big5?B?czhnS2JwbkZJQXlrSmVja2IxZlg5R2Rhc1ZRcVJkdzhoTHp0YWtjUmlaeVBuQm5W?=
 =?big5?B?QVdWL1hUVnVWcnh4dmw0WjNOQ0xFbGsveFVSY1YxK2krbzZaMGpGNmtzQ1Z1OE54?=
 =?big5?B?U3g1bEovTlEwR0V2a2lhT0tTU0VRMUdrUE1hV01KTkJlWTFSNmY0THN1SmdBL0hU?=
 =?big5?B?S1g2M3FySTJFMGdneU1QaUNjeDdhbkxhNmowRm54R0d0OEdFWnpUZEZERDJPVDhX?=
 =?big5?B?WDMyYzFLSjRNSzV6c2JwVUhnd1JqZ1lqN05jYllpU2dRTkVUb0p5WjNFU05nT0hG?=
 =?big5?B?YUJRUTNyYldTS3l6dWxZMFl4Q3RiQkRYdm1yMjFuRjB4akZ5am9rTUtNc1MzZVlR?=
 =?big5?B?bW92MGcvYnNIYWpVbGYzQzJLcXZTWjVuK3ZoaHlxK1hDRzBSV05pSHdlNEFCVThj?=
 =?big5?B?S0tVMUhPMFhJVm1EdXJnZkhUcUp4dnBIcjhTdXRRejRjYTNHREo5dzBHNTZXaEtz?=
 =?big5?B?d1NVSE9FZUh3QXJ4dThEbDBEZHQ0eU1LRlJ4dGF3K3NqRjdBL05nN3pablJMM1li?=
 =?big5?B?YzRRM2p4T0xHUUNWSlBXOW8ycmlwckw3SmpJSTdMNTdlVEFFMzJqWGFXYnprcjVi?=
 =?big5?B?UDRqaHpEcENTNTFWRU5icExlNERuTSt2L0RpdzNsQkNBVktJa0NGR284N1JsK2tr?=
 =?big5?B?Z2E5dGxOMHdSWDFRcDJkT3duOGtUS0kwRWhZS21vSnlDcm1FUmlQZzVMTmZ1L2Er?=
 =?big5?B?Y1RhWnlUWlVFK1FScXRGMjlweDN4Ri9DY04yLzd5L3k0dFFCTGxQdWsrSGZja3Ey?=
 =?big5?B?ZE9BMzFXZnZqMklIWC9pRnRkS0h0UnJlbjh5TEdqYWFRVVJTa1g3dkl5TSszbGZD?=
 =?big5?B?c2VkZWlkK0VQNjBXOEh1TVc4OEJhbCsyRFV3SS9GSndBandYMDFaTzRJQVpYL3Fh?=
 =?big5?B?NHVGL2tHK1U5U1JSell2ai93dVVYeWtuaWdBMHlJenc0Nml2VE5wVTU2cVlOWEtH?=
 =?big5?B?Vzh5bGR6SHBsbEpKRTcvQjFqbWVLTjNXNUllQWhWQU41VFlDU1BIOWljQXNhRDRt?=
 =?big5?B?c0c2bEx1WTJxUW1IRFlvZ1puVE41NEc2MGhhMW9JWTJ1NGlzbVlyUVp6SHo3c2ho?=
 =?big5?B?TW9BKyttei9XOENxeUx5NVBzZVg5akcrWUpiTW03RXdldDFEaFJUaVdMcjRUM0xP?=
 =?big5?B?a1BDSjhpT1NKUktsU2FOcU5MdjBsMFptZkVKaEM0K1ora2tEK2dXYVhFbUhPY3di?=
 =?big5?B?Sng1OVE4TEpsU21LbzNNTDl0aFczdk0yNlFrREttbmJTVit2Q3l1VVZzQjBDZFBT?=
 =?big5?B?SXdab1FuNFYwSzNXa2x4ai9QdGxZSHdQdHQ0Z3hUekFab0xNeDJhSFpVOFYzRnVK?=
 =?big5?B?R1haZ0owcWh4YXp2R0pycGM5anBjTWZwWURWRlUzc3dFMEVTUno4N1FkcThDc1dn?=
 =?big5?B?UzV2c3RkR3ljVGhvaWZ0Yk4wejg4bWFQU2pGWEJVNHU1bGVnNmFkZnlOcE11ZzFp?=
 =?big5?B?cUxaYUVUdHV5N3hCaDVjUG5pUFJLdTdDR0xrSEU5SFVpdlpheXc1MDY4dGFLL3pI?=
 =?big5?B?THVBTEJOQ21BSUU0aWREY0NRU01jS1ZybjllM2pEamd5clBoQWp6VGFTRk1SWlhK?=
 =?big5?B?K09ReHMyRFFBbEhnemNsRW01ei84L1BldGNseVJnaGsxUEw4YUcwYTlxZ2R4MHJ0?=
 =?big5?B?a21HOVFPK3VSZ3NTRE1pOEpmenQzNUc1THJyRy9zQ0JsdkF1bFlHYXNncjFyZXhl?=
 =?big5?B?dnN4T0tQQWpUMytma2FpVWlaa01neEUyU1VmakFLT3FoZmoxdURrUW1KZFRxek1M?=
 =?big5?B?dWdlWjRqVWVBVVdSMHV2Z1E4WHFweSttSG9QaVZCOENDUW9TS2RxYlNvcXZCRG5y?=
 =?big5?B?b3c3cVdSUDRLTURhdkI0eUZqSml5RGdGTFpWYmdibmZ0Mk5GcHA1TWhKVTlIZDF6?=
 =?big5?B?Qk9EbE5aL3N1TXJuUjBGQnU0V2RRUFRUclM3R1ljQXBLdHlyRGZKMkd4VDZ5VmRM?=
 =?big5?B?eld6ZHZMSU5zS2pmYjEybU83RGZZaStrZG5pUGhkOC9HVEhkTEtRdVJiKzhnT3Fz?=
 =?big5?B?V1FFN004RDlJeS91eW5pdG9GYjdjdlArd1dWZm5KNDVuMWlZaU1hL1BwQk5mM0dm?=
 =?big5?B?bVpCSTQvZWNFODlUN09JSXFKOVpTQT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7502c2dd-92ca-476f-7ab4-08df45248e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 03:32:21.8364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQ4qLPgTOh+NmKt4bzJw8lHN5K7gDUGc8boWr7S6gIb7UJ1FPdmp2ADQLEiicNd9COheaqQzEUouO14CT1yYyGqucLPz+uTr4v/tbB5ILzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB9002
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiB3aGF0J3MgaGFwcGVuIGlmIGRldmljZSBBIGhhdmUgcGF5bG9hZCA0IGJ5dGVzIGFuZCBkZXZp
Y2UgQiBoYXZlIHBheWxvYWQKPiA4IGJ5dGVzLCB5b3Ugc2V0IHBheWxvYWQgdGhsZCB0byA4LiBp
ZiBkZXZpY2UgQSByYWlzZSBJQkksIHdoYXQncyBoYXBwZW4KPiBpZiBkZXZpY2UgaGF2ZSBub3Qg
c2VudCBvdXQgZWFyaWx5IHRlcm1uaWF0ZT8KCkRldmljZSBBIGlzIHN0aWxsIHByb3RlY3RlZCwg
anVzdCBhdCBhIGNvYXJzZXIgZ3JhbnVsYXJpdHkuCgpBU1BFRURfSTNDX01TVF9NUkwncyB0ZXJt
aW5hdGlvbiBsZW5ndGggaXMgb25lIGNvbnRyb2xsZXItd2lkZQpyZWdpc3Rlciwgbm90IGEgcGVy
LWRldmljZSBsaW1pdCwgYW5kIGFzcGVlZF9pM2NfaWJpX2dyb3dfdGhyZXNob2xkKCkKb25seSBl
dmVyIGdyb3dzIGl0LCBuZXZlciBzaHJpbmtzIGl0IGJhY2sgZG93bi4gT25jZSBkZXZpY2UgQgpy
ZWdpc3RlcnMgZm9yIHVwIHRvIDggYnl0ZXMsIGV2ZXJ5IGRldmljZSBzaGFyaW5nIHRoZSBidXMg
aXMgY2FwcGVkIGF0CjguCgpBIHdlbGwtYmVoYXZlZCBkZXZpY2UgQSB0ZXJtaW5hdGluZyBpdHMg
b3duIDQtYnl0ZSBwYXlsb2FkIG5ldmVyCnJlYWNoZXMgdGhhdCB0aHJlc2hvbGQuIEEgbWlzYmVo
YXZpbmcgb25lIGlzIHN0aWxsIGZvcmNlZCB0byBzdG9wLApqdXN0IGF0IDggYnl0ZXMgaW5zdGVh
ZCBvZiBpdHMgb3duIDQ6IHRoZSB0aHJlc2hvbGQgYmFja3N0b3BzIGFuCnVuYm91bmRlZCBwYXls
b2FkIElCSSwgaXQgZG9lc24ndCBlbmZvcmNlIGVhY2ggZGV2aWNlJ3Mgb3duIGxlbmd0aC4KClRo
YW5rcwoKQmlsbHkgVHNhaQ==

