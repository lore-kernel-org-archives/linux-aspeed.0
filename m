Return-Path: <linux-aspeed+bounces-4092-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEE5CD5BA4
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 10:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKWRH2d5kz2yFK;
	Tue, 19 May 2026 20:40:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779187243;
	cv=pass; b=iSZCb+8tsZHciu9BM8ioVDLwgoIH46CZMCWcgh8IGVIIGze7kA7MvDSmOiSEuwlhb1JIf/qRCMM1Xif35zCYSMdsOiPCEFFaTfyODK9UOfd09Fcv5/5comoMpvYL9FVdaJbQJy6PTpLyEP/UZjPEeiTQOxlgDk/y7etflG5zY+6H0BRhp2RXzPAZzBel8Xb5BTSEhTo5rrEMzHxeIvIxLawav0eTkCF6PfsZHtC8c7CkR88/J+8oKiptGV1BelT2Jq/ZlJIDWqB9nACScHMgfZBDBlSHyI3G2G5y+aAWLpmGqAwuGEj4PAWI4EEez9G9q23g56+LR9ZFXvCw5C/Krg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779187243; c=relaxed/relaxed;
	bh=FU3kfh1Wo1QP648n+fGNQDFcdN1aG8vxJmaAMcjZH7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvsyGBjuGpqqcAlljvtV8C0H8aBIZLOmHl+wbnb23/gekJ5RlUSJ4359mjUy1htPRRVfIu0O9JR6EqqA+XDBiMzKNsZbApbYBcdYX8OP+HNDNBpFacAGL03iTIzWGX8/UvabDL4RVrklRhqzqRnvuWDoTyVoZBW6g+bX8LrrpiZl08MkHZ4nMdiPfWRK16HiCnXe7fKHzk/ydyVHbO9l+9caNtsH6e/k8rWFFQ5BjGfkF8Ca7ZwYL+jMZZo2mawjRc6I93lXog2nmoKBGdpJM9EKmZgW49yHkpvrEkbbY9LHkNQfhO9pcpyc6YHiUVYVLjyPLJrOZh5gf+HKxgY1Uw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=S1hJpdrv; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=S1hJpdrv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKWRF5cvlz2yD6;
	Tue, 19 May 2026 20:40:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thx+lK/uEaPgw6Oy0kCBpLE3CEKmBP7xsjtF2GitMucuJou6ccucLIStiK5VFCwLiOFsowxtnpJgnrsVveEE8MPvJ7mUe11CcdD6FYif9EZTw/Me9khdlkNYv/GqcLM/2EzBOXvM8hKME8tzmKVvTp3HQA4CzsO5JNHDCQ5V6uVb8ex+Jmw1bGQgJYi3nbLVnMJB4JGeQXg8NUKa/5BEwN1n/oWJUdkzAtofEtOkAI08VXx700+4tH6ryvu0ykJ/IQdqaYaiXiEhxdjXGbrhuQhdvear30u0mC0h4XjeRGTSWK65FSuSDxtEU81QUugsvLqMbwYqSKC4vNoqCyRVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU3kfh1Wo1QP648n+fGNQDFcdN1aG8vxJmaAMcjZH7w=;
 b=JZGHU30p/LYgTI+iKwI8D5P0gRP0gzdw4pooFMrENfAwnWssE0a4aitXLTtQReBeus1er4hWFiRn6pOfDq9O+j4pOfIowHwigdOjzEUUqVZjXDlFHg56k57TACGktc17EGYDstJmqTJ4bmLKmSPLIV2leEK7BdiCu5PcxMW48eEBo/tU8cumikbwgA8zf13vpPepb/C3LylUAzAwSOeTOwjwl29hjycEHei3F8sLS6UrQjWZv+nRwSgO5PD4BjYI51YYz+0Z0LltLRbTiZqOC+gvACyh8a8s3urvYq7UScVZeDQY502pGDxRDTJP/Ll4hsqqI931zAKmHPcXo9cPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU3kfh1Wo1QP648n+fGNQDFcdN1aG8vxJmaAMcjZH7w=;
 b=S1hJpdrvo5cuXJVAbTqJIZiCfmXAEFBTv+/PZGJwPBuu3YKf8+/J0BE0Rpeg0Ut1x+4Mg/iaNh0p5VX6Xu/P1yCK4RZlAYGrVulq97xqPnaXWP6xgfLtX1276k4mOlM0kTmVuDqmwJTJNFW5zJdOhjsqWhGbe21DZqWhMkwbn/goVq9/IReCt0jItlT8UVi7Q0T72Lymrf7/H+ZVQRTMntIE0XoNPinYggWejepksrOIsJ55npBzqzYvXBjzjo7vp84aoLZV4tVNeErLkdBc/ZjyobDYD57W7CM4QKzC9ZZge2Vy2oet69yLJYhys5vQUQCvuj3Jb8S84ZTac7BBvg==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by TYZPR06MB6568.apcprd06.prod.outlook.com
 (2603:1096:400:45f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:40:17 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 10:40:17 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@linux.intel.com>, Arnd
 Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, Conor
 Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "maciej.lawniczak@intel.com"
	<maciej.lawniczak@intel.com>, Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Topic: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Thread-Index:
 AQHcstFOqEOl3ItXl0mr3midS8GMZLWsphAAgABXFACAA7sEAIAAT9LAgAF5RgCADH1X4IAAILCAgAK7OMCAEYY3UIAvrvqAgADtghCABnSAgIACyQAA
Date: Tue, 19 May 2026 10:40:17 +0000
Message-ID:
 <KL1PR0601MB427604A7136947D020CF272D90002@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
 <c3b28ee92fa46700887d0c68b23045b2418358a7.camel@codeconstruct.com.au>
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
 <KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <14870d17-2471-4522-b8b5-03cb9002a4f7@app.fastmail.com>
 <KL1PR0601MB42763DAD359305DEBA4B769D9057A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <KL1PR0601MB427603A6A5768D6A537CAFCB905AA@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <b1d56feb-9847-41b1-8bba-733963055cae@linux.intel.com>
 <KL1PR0601MB4276AB799EC03BB00C4C0E5490392@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <be4f662a-b986-4b4c-8263-2fd7b63c238a@linux.intel.com>
In-Reply-To: <be4f662a-b986-4b4c-8263-2fd7b63c238a@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|TYZPR06MB6568:EE_
x-ms-office365-filtering-correlation-id: 433ccd01-9e0f-467c-8109-08deb59304a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 7r55TewTsT7omYt3wZzoGvuP2ZguNDeiGXNXMk/gPeFed+Vv/F1HvdKBVYI3zUWK1AMzGRqNvm8gkzvrWIxGMwNoQ3l+aQPMEw5lqOVv6wzTD6VIh8BHzsTzeBo0n2DNBgFIS70DIW8tvU1fU6/XdRXrIxLjRsRuxVBKti8OAsRVDPmjkKHI1vHUWPL9iCd1byr5TG4qQwMcC8onZC+MYaYk7CjwGU6BeCkoh9P0rhH0hpmcPTH8A9A6phDyU4TpEUT18q1QrnR0fOdVYuBrNkm3BLRL92yGQCGQCUbQxW1KbxHsT3s+hgKCGFxVntiCTHl4yiKoYajKmwNLJaQ6mbLf6YYe3S0LXY+KcTgn8zLIdQGMDf0ObyCGFcMih3Lb7ClAgrsQY9yN9cg/ClfdQik1fBH9PikVwGRxk0p1h6HbMkk7E/HArhLIg/LT5N9woJewJmzwec3tRCct3yPTSW2zoPWnIW7XWuWjUfggQeo8n9kv9UJ/OwBZ4l1KXQoDJm+2A1zmh6s0BHn0fsLKnZyO/3Odf//P/bHEVJxEqsmoPQR4F4yy6/Kal+LrjS8bSJ/k5cEKrpDiRmSuVWT96WyLY4EyLNJPl2fdAPaaiMiolDE3n9O4/z6yN/btPGzYDKSyybpTE+yfQYQsRWLqCwBMm85VIhz0NiEPFOJ/bZZo6sWIjIgdpPm5f99pT5EtwxBCKM74Gv3tCeXxGzeud1vK6FOdrgtBVhV0GBSPak0zRQR9rojUyE8R5jRk7bzi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmhwZjFXMGQ5RXpFeEdJK3dyWG9WWkdrU3Fod1FDd1F0cFJKS0NHOHdONDVv?=
 =?utf-8?B?aTRRVlhleHU2OTlsN1JuQVlDa2ZZOGlzb3ZYTUxjWkppdXNCRnB4anZCdkp2?=
 =?utf-8?B?akpYalB0VFpYYmhBUktwWGUydGR5Ly9DbnRlMFErdWVGSmRZZmw0dTVBdnFw?=
 =?utf-8?B?eU1lS3BLZ1hSTW9wcWhXaERZbU1oMURoVDBVSlRJR3VnVG13cHVJbzRNNmUy?=
 =?utf-8?B?Q2QxRFlLZFdpdTdKYzA0bzl2L0VVOE1wa2VyZXhuYzBraTE5VnVIQ2ZBTy9U?=
 =?utf-8?B?RDJKRlFZSTRPbEw3SlFXMjVvUEpJQkhXb1kwd2ZzendYaFY4clNHS0R0SGJK?=
 =?utf-8?B?dmJRY1ZBSHFYMzlBa01kRHZWeWpQWVd6c3k5N0RQMnVCWUlpdVlHZ3hYNnJw?=
 =?utf-8?B?ek91eG9PcFBjVUZPRTcxVkJqQlROczJtdFhCNzN2cXRLSUZrNFlVU0tYMDI4?=
 =?utf-8?B?M3pWQ2p3bENka1NVNTJiL2wrTXpzUGdVSTdmRzJUcGJjc3A4KzB4SExvRnRj?=
 =?utf-8?B?ZmRXYnNNdWFETVVYbU1aOUNsNzgxbWk2bTJnZDlVVEZNRzk4VFFRZk9DeHcy?=
 =?utf-8?B?MitrQVVVUWdZYVFUeUpDQVpITmpGZW56OC84bjZWcWk0dzliYUo1Q0VxcFg1?=
 =?utf-8?B?c016QUpDTlFoV1RVR25qZ25aT3Z3dzFQSHpOQW1mVDN5YlVralkzeUFVV1Bz?=
 =?utf-8?B?TVR4NnVBMk5JM0tJLyswWFhGMWZWU1g3Y0F0aWtHQzgxeHRiUmFuSWFWVkFo?=
 =?utf-8?B?Tk9oWWh3dDJPS1N0dDMvb3J4dDMrbHRnVnFtdTh1WFlFdHpMRVZqRlFBRzIz?=
 =?utf-8?B?dk45MHNOUCtxVTllTm5oUmlOSHBBWG9iblBGWEViaFZ1WjdZTURSSFMwTlV6?=
 =?utf-8?B?Mms1eC81RVJGUmdLMGcveWNzZWtMaFpHWTRBU1pRd1ppdEhyYVFwbFVDQ3E1?=
 =?utf-8?B?YjUwOVNCeUlxV3htM1d5S2piOWcxeU9NMGtaNmM0SHE5M1p6RkRmeUdmcTUv?=
 =?utf-8?B?Qy9iK2tHSnRaTG01UXJRclNKR2s3NTUvYkFtMDV0YkdOcmhDQ2hJR3lZMjY0?=
 =?utf-8?B?MzZuMjhuUklhT0lmUHorcHBSMkhkNlhnQU1QWDZnSEVwek40RWpzc2tRZW81?=
 =?utf-8?B?cGhFamhvYUJleHl6OElDeTR1SC9OR2t6WTIwbFlDTjFFanNEWUdCbjZTTjFa?=
 =?utf-8?B?UXlLTU9IejBFN21YUVgyT2FCZHhsT216d21WMlY0K29sdmJlOW1NdUFxUGt3?=
 =?utf-8?B?eHpQY3FzN2w5aFgvVFU5eHZORS9Zd0JTc2RRcStrUEcyUlJtYk94R2d2Qk1r?=
 =?utf-8?B?UENtQXNMVmZPbUtnK2lrWDZISkVOdjMvYmt1QkM0NWloNllBcGVJcjQrdEVi?=
 =?utf-8?B?YWNhLzVEK0FpTk95OGcxbWJIWTRYRVRqZEY2NHdKQVZCaXZoSitaSlBlYnB1?=
 =?utf-8?B?NVdDZDJhWlpHWnlQb1RMYnhQeDVZRHhaUVRLWjY1Z0V1WDRySHNTRk0rZDhD?=
 =?utf-8?B?cUdhVFQxLzZZYldMQ2tua25VWkd1Q0RHMUg3cHVmUmRPa1lxbkQxUnUyZDAw?=
 =?utf-8?B?K1V0RzVSZGNyeDJTcHRjMEN1U2taRGx4K3FiL3NXamcydzB3d3RYVkhBMzA2?=
 =?utf-8?B?K3FFN2E4bUFZNDFUOVI4US91TmtCdUJlbjlRazc4d3AzbmwyclU4RDcyM3Ft?=
 =?utf-8?B?b2k3cU52NSt3TWVZNGJRbllsdzc2SGQ0NHlySWRZTDMyaVRjenlBenJFbkhY?=
 =?utf-8?B?MmtFalRnZmRueFk3VGVwaWlrRExENTVlQVYvOGxlRVoyQTA1ZHhvbkFCN0Fz?=
 =?utf-8?B?K2hCeWx1VEExUVRNRGFWcGZIZmtSK0kwRzRGZ2ZCTEF1NjgzdGV5WEtSUldq?=
 =?utf-8?B?ZkNDbm1DV0F4VVdRdDZlRXFWQ2xjT3habksrbXlJWWFjcExKNGNReFRuUW9X?=
 =?utf-8?B?c0hqOTl2Nms2dks5Q3NXRThUcDUxRWxZZFR2cU01dXBaWmN5RE51TnlsTWIy?=
 =?utf-8?B?UW5xZngwOXBVY1BrVW5uZi9HNmhWN2JYbll1a2p4OEhsZ05Pb01CZ0xvb2s1?=
 =?utf-8?B?eUk0a1krWnZWYTdmSUVVTm9FaHIxT0tjM29nbko1cDhkSkkzL3lXbjRKR3cy?=
 =?utf-8?B?bU9KK2pxeTEwdEJHZldCelE5T1hveWFDZTBaQjJ4OXBCdGJwZkxKcm1QMC9T?=
 =?utf-8?B?dytNZU5ScjhYNElxSFJva0h5OVFlenA3OENuWTF4TCtZUTlkSllSMm0wM3dt?=
 =?utf-8?B?QVVlNjl3SlJLY2lOUWNBbGUvRHJoVkx1dkdUVDZIOWJoS29VNG52V0Zha24v?=
 =?utf-8?B?T0pvM0dXMThldjh6UnJ1UzVncG5DRFBlZUdLYUJ1Vmx4TVIvY1VFdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433ccd01-9e0f-467c-8109-08deb59304a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 10:40:17.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSIly/M5VFk8VeYAM4KXTBZmi5D/DjcUcdgthmYb2eq2M/VaEGpGf+yP5091kvZ/HqtH5tUOH53DWUs+NcoQ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6568

SGkgU2h1bHpoZW5rbywNCiANCj4gTXkgbWFpbiBjb25jZXJuIGlzIHRyeWluZyB0byB1bmRlcnN0
YW5kIHdoZXRoZXIgaXQgaXMgY29tcGxldGVseSBpbXBvc3NpYmxlIChvcg0KPiBpbnRyb2R1Y2Vz
IHRvbyBtdWNoIGVmZm9ydCB0aGF0IHdlJ2QgYmV0dGVyIG5vdCB0byB0YWtlKSBpbnRlZ3JhdGlu
ZyB0aGlzIHRvIFNQSQ0KPiBzdWJzeXN0ZW0uDQo+IA0KPiAgRnJvbSB5b3VyIHJlcGx5IEkgdW5k
ZXJzdGFuZCB0aGVyZSBhcmUgdHdvIHBvdGVudGlhbCBibG9ja2VyczoNCj4gDQo+IGEpIFRyZWF0
aW5nIGVTUEkgdHJhbnNmZXJzIGFzIGJ1cy1sZXZlbCB0cmFuc2ZlcnMgKG1lYW5pbmcgdGhhdCBp
dCB3aWxsIGJlIG5lY2Vzc2FyeQ0KPiBwcm9iYWJseSBtYWtpbmcgc2VwYXJhdGUgZHJpdmVyIGZv
ciBPT0IvVlcvRmxhc2ggY2hhbm5lbHMgYXMgdGhleSBlc3NlbnRpYWxseQ0KPiB1c2UgZVNQSSBh
cyBhIHRyYW5zcG9ydCk7DQo+IA0KPiBiKSBTb21lIGxvZ2ljIGJlaW5nIGRvbmUgYnkgdGhlIGhh
cmR3YXJlIChpLmUuIExQQyBicmlkZ2UpLg0KPiANCj4gUGxlYXNlIGNvbmZpcm0gbXkgdW5kZXJz
dGFuZGluZzoNCj4gDQo+IChhKSBpcyBmZWFzaWJsZSwgYnV0IHJlcXVpcmVzIG1hbnkgZWZmb3J0
IHRvIHJlLWRlZmluZSBhcmNoaXRlY3R1cmUgDQoNCkkgdGhpbmsgaXQgbWF5IG5vdCBiZSBhIGdv
b2QgY2hvaWNlIGZvciBvdXIgaGFyZHdhcmUsIHNpbmNlIGVTUEkgaGFzIGNsZWFybHkNCmRlZmlu
ZWQgY2hhbm5lbCBzZW1hbnRpY3MgYW5kIG91ciBoYXJkd2FyZSBleHBvc2VzIGRpZmZlcmVudCBz
dWJzZXRzIG9mDQpyZWdpc3RlcnMgZm9yIGVhY2ggY2hhbm5lbCBhY2NvcmRpbmdseS4gVGhlcmVm
b3JlLCBpdCB3b3VsZCBub3QgZml0IHdlbGwgd2l0aA0KdGhlIGdlbmVyYWwgbWVzc2FnaW5nIGZs
b3cgcmVxdWlyZWQgYnkgdGhlIFNQSSBzdWJzeXN0ZW0sIGJlY2F1c2Ugd2Ugd291bGQNCmhhdmUg
dG8gcmUtc2VyaWFsaXplIHRoZSBwYWNrZXRzIGFuZCBwbHVtYiB0aGVtIHRocm91Z2ggdGhlIFNQ
SSBzdWJzeXN0ZW0gdG8NCmEgY29uc3VtZXIgdGhhdCBjYW4gaGFuZGxlIHRoZSBwYWNrZXQgYW5k
IHBlcmZvcm0gdGhlIGNvcnJlc3BvbmRpbmcgcmVnaXN0ZXINCm9wZXJhdGlvbnMuDQoNCj4gKGIp
IElmIHNvbWV0aGluZyBpcyBkb25lIGJ5IHRoZSBoYXJkd2FyZSAtIHdoYXQgaXMgdGhlIGRyaXZl
ciBpbXBhY3Q/IEkgcmVjYWxsDQo+IGVEQUYgdXNlIGNhc2Ugd2hlbiB0aGUgZHJpdmVyIHdhc24n
dCBpbnZvbHZlZCBhdCBhbGwgLSBhbmQgZmxhc2ggYWNjZXNzIHdhcyBmdWxseQ0KPiBkb25lIGJ5
IHRoZSBoYXJkd2FyZSAodW5sZXNzIHRoZSBjb250cm9sbGVyIGlzIGNvbmZpZ3VyZWQgdG8gaGFu
ZGxlIGl0IGluIFNXDQo+IG1vZGUpLg0KDQpGb3IgaGFyZHdhcmUgbW9kZSwgSSBkbyBub3QgdGhp
bmsgdGhlcmUgaXMgbXVjaCBkaXJlY3QgZHJpdmVyIGltcGxlbWVudGF0aW9uDQppbXBhY3QuIElm
IHRoZSBoYXJkd2FyZSBoYW5kbGVzIHRoZSB0cmFuc2FjdGlvbiBjb21wbGV0ZWx5LCB0aGUgZHJp
dmVyIG1heQ0Kb25seSBuZWVkIHRvIGNvbmZpZ3VyZSB0aGUgY29udHJvbGxlciBkdXJpbmcgaW5p
dGlhbGl6YXRpb24uDQoNCk91ciBjb25jZXJuIGlzIG1vcmUgYWJvdXQgdGhlIGRlc2lnbiBzZW1h
bnRpY3MuIEludGVncmF0aW5nIHRoaXMgaW50byB0aGUgU1BJDQpzdWJzeXN0ZW0gd291bGQgaW1w
bHkgdGhhdCBlU1BJIHBhY2tldHMgYXJlIHRyZWF0ZWQgYXMgbG93LWxldmVsIFNQSS1saWtlIGJ1
cw0KdHJhbnNmZXJzLiBIb3dldmVyLCBvdXIgaGFyZHdhcmUgaGFuZGxlcyBzb21lIGNoYW5uZWwg
cGFja2V0cyBhdXRvbWF0aWNhbGx5LA0Kc28gZXhwb3NpbmcgdGhlbSBhcyBub3JtYWwgU1BJIHRy
YW5zZmVycyBtYXkgbm90IGFjY3VyYXRlbHkgcmVwcmVzZW50IGhvdyB0aGUNCmhhcmR3YXJlIG9w
ZXJhdGVzLg0KDQo=

