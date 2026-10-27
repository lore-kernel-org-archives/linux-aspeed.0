Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F82606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Liqf86rz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDCLn4Hl1z2xH9;
	Tue, 27 Oct 2026 12:18:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793063937;
	cv=pass; b=PE+SsRN3uLpx8qDUjw8jcTTLF+2NJbvFHDcSMvDkuGO50ZGMcxXy77SjsVmCcdmIM6+044tRJqF66TmxYtAKErR4mzsmcQiVkDig245452+gsh9724KCX6S9OHx2Gq9A8xAGyflKQ4ptmI/jUNcK51CvS2dynvKFxxBVcLhVX0uowF7TYl3uKby0ZCE5ceCiD0PGB+dtxl9FYEVuL5g0NgOuh9r2GQ8rTOSM7JUckvd+CyXcoJJ+/8zJrD5mb+qTxXAQZmGUs31z2WCypgkZhJwoBnZN6O9oTY3IF1xDQ0/LDwA7456uaLO65nC+X8Oz70Dez/y/zi6XpIjpzCQzXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793063937; c=relaxed/relaxed;
	bh=46RyXzphrtiMJVv/JdvEnsr8L3f+Kw5Rh+2EnVJkTGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JzAJsnNWWt8Mn9yjBeoybaJ1dVHmlo7HPcg2WyNmzEIQxNDFd9o8i19T1L8RMsJR52uZTFPi7wo7VKoDWu/4cc2GFdHsx3B3niq24XV2E0k8WinMka1dF6WE+CM9HJdxNt9zQy7fY3IC7HK+ri3ii6+8zFSOscsU0/9iAXTy3QNuzIK6HS3gwaHQgiHhvdhlvzFqzruhEXd8RcYZeJWvVRqLrEuF8YvLL7FGnqJjfrUPshRDf9sKe9D+CXPfW7Bw8PdAv/R8ivX8baXIh6ZRNMta/AcUF/y3GnQgWKStfJlp82tQYbg855yIO9VvcKMOTNosh4WYSx0kI6tFmJxzLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Liqf86rz; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Liqf86rz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDCLk4gGbz2xH7;
	Tue, 27 Oct 2026 12:18:53 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFVG07y2kYn2R567znWuKHYtVnk5sOOX1Bwt+vmIppQ5QEDdSHm4n019szyfyfoAUFYsH6NW38LIK2Wl04FkJxPNiUqZocGIVpHOeC6QZEwbHugN3oXvYqC8bMJxu5hLy2X3TxObFitGzHsQcxNgLynyB9q86CsZ649+N4rEuF44IEbx+0524V22Jk1Vjv/QiBzRtfZJAMXpsNdrWN2oCOsEC0Q4CaDn4JvRemq7kCKWvStvtjvBPr4E+V1Yvzy6oCUTxrtL4+8DuZE7FlPrwrcU5JeNOgPupqXVOmsxAtsETAdKi9OYCr4frXlLYXeI+3e4GgCuln0mNH2es7VW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46RyXzphrtiMJVv/JdvEnsr8L3f+Kw5Rh+2EnVJkTGE=;
 b=nvNfINLRRVSSJ/NUow+XgmJrtiIhD16UnaitR0Gm1Wsx4748UQr8eeZO55fbziTkfQRDmnHGyvgHwnn9A7Ymc8hO75f8V239lbXB50uRWQhgiOkuhlF3CWiZokJqg+tZrw4s4VZCMSYNqp5XLPqtWmJwzFG8YPvUtj2DLl0gCH8P6q6Ho2AUKinhxMk6kkb1pTZR2VawOIvG7/fy9C358FGw86btg9eqfWtRugsN9afKr8ALPcEig7bgLOs0Gs4PC1Ajgq+ZMoZwgOg5EoGu8isy9PX61f+8JubWmIMrW2B0G7mw1sM0iAQLnmGbo381D7TPsx6n2y6IOoYuUZVBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46RyXzphrtiMJVv/JdvEnsr8L3f+Kw5Rh+2EnVJkTGE=;
 b=Liqf86rznAcZLTj+TRteaiKaM4o9OYhHcaKhQ9Sfy2izS5/A1BiuCMAnynMoVMeiLmze9TXWsuI92kzIPqss5eEI/ltow/IZDTeBlN8b5skN0bHE+430cSLBUCjI90zPFsDPce0fxWznbm7nHtUwAOBkP+AZEE6ga/QRiRslgGT8f1mmItqJM7PjAhMI74WjFYNI+KOs+2Qk81Vn7vP0BnmdvBrGfEZdtKKhqw9Scl7LbOxJScxy8te7H4d1eaC2fZ8eeajDdrLX3Je3yPXW4hlx5rmSG2Gi+SF3iFnXulF0scg3sA456gUabEDv2a5HX/CWEC9RdPdOR8twopxlxw==
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9)
 by TYNPR06MB8958.apcprd06.prod.outlook.com (2603:1096:405:3c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 01:18:24 +0000
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f]) by KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f%6]) with mapi id 15.21.0569.006; Tue, 27 Oct 2026
 01:18:24 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Myeonghun Pak <mhun512@gmail.com>, "eajames@linux.ibm.com"
	<eajames@linux.ibm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] media: aspeed: acquire IRQ after reset and clock
 resources
Thread-Topic: [PATCH] media: aspeed: acquire IRQ after reset and clock
 resources
Thread-Index: AQHdXQyRS1tkx3VxgEqGzyuPc3PKjrcQokkA
Date: Tue, 27 Oct 2026 01:18:24 +0000
Message-ID:
 <KL1PR06MB694295F7F33B8FEDA284C65DF1602@KL1PR06MB6942.apcprd06.prod.outlook.com>
References: <gm-top10-20261015191529-g65-295aa0ac5211@mhun512.gmail.com>
In-Reply-To: <gm-top10-20261015191529-g65-295aa0ac5211@mhun512.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6942:EE_|TYNPR06MB8958:EE_
x-ms-office365-filtering-correlation-id: b0548828-f459-45c4-7f9a-08df33c8327c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|261026121527099003|38070700021|5023799004|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
x-microsoft-antispam-message-info:
 t5fl7G2MwyeY+K+5qiHuu/lBnpO9+8UMpg96OysSEt1qsptaknr7nZ8d8IE0B9bqfFPOXtf8LzVKIeQmiuqS0VeFCQTcFazKI64oDZU/Cm9ibSUSRNBw8ndeGT6KafnrIaEQbXBgtYID5uKp8HqGT89epI/3hR9A4IZfItyoy2RoBFyJgz4Yz+pAvib/VP0sRH5bnBKZSnw/j0H6o90YP/osuOdaTHIPOTkQtDs5H0qYnwqKfTc5NTf2S8ZVnJp+DZhHMTQWTg3n3yfNDxQ0kt3vgObJw6JFqrlAncRZf40CtuOJz/cMaVzGBymxVx3v5aGuMK37rKKU59UbKImTbxpwzNA/VYvrQY69s5PIlUVmktrviIUyPZMiDF+FnPPC+rLZFR7Z1w6movwygSj/s//92jsEvg871Zr9Cd1Ezo6Hk24+LEjUTyYw5Vpl/eAiX6W2/lIM742Sir4R1afCIwZkSxp8a53tSlkvmL8Zu9IKuk+O8cj8ZtdkeG4LO4/ImxnTxT6rpv8H41OEt/RjjG4a+zQCIFU/lD0XyKfAClbc6xlU6vSzSNvSvEEQt9qqIiMkpy20Ljk8GPkzbyDaHRC38Js6EP8IO7Oy1AuYCDQqp5PIntk3iYBPKme8WxVzPgJLuigAKnEtk8noIafdU8V/iHcrFUylDZIx/Yftyki+G3+2Fs/tOicuauVbLa46Oh7hGpH8UoMCtJ18C4G+iizQNtcAiNe6yKD9b53glnM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(261026121527099003)(38070700021)(5023799004)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1pTNVg2ZlI5TTRZR1ZyMzBBRXlybG8wU2dZNXB0MVhzb25xb29CdmNCUEZ0?=
 =?utf-8?B?TGk0MHlweU9MMEg3YzV4UHgrTjN4eVNFVmpXdlBGdk5PanN0ZGdrL0lZYmFK?=
 =?utf-8?B?ajVNb0xRekhZYThNVHFIdE13REFRaHZHVXk0NExER3l1cHFHSjFua09lNWFq?=
 =?utf-8?B?cUpVeStFNi9zSXdZeDFJNGFFL3BLd0RQZWFSYTRjVHJDWjFxd3NWSm9qSmwx?=
 =?utf-8?B?Mm1sMHJkU2xNcDcxN0dmSndCMDZhd2tKb2w2SzA3d2RsL2dWODF3bVlZNTNC?=
 =?utf-8?B?bDVxaGRVbmxoSzFOQnBscXFiMFJFUDE1cGdzNm5EMG5pb29HY1dIck5qaVIw?=
 =?utf-8?B?SmFpL2tzMWJiS3VRNHA3elBSZlVnbXFONmFuRkJieDFpREtCTnVUZGFHZzRZ?=
 =?utf-8?B?UnptOUFDczdlcFZpSVc2T2V4ek9WUWFjRGJXeWJodnVzSTYzd3NrbTdBOVdT?=
 =?utf-8?B?UFpnNStwMUZBT2tyVzhhUk1nQm5oRG0rOXdhSkwrZnlXMmhJYUpEOTBldDI3?=
 =?utf-8?B?MldOazJobjc0aFM1RkpRT3FGSEdoRlFEUzRuZzlQWjlQaFd4cGpZbkxvMXhL?=
 =?utf-8?B?REk4VWZwZC9ucG9ZS3NtOVRpZmp4UEtvMDFpNFd6NFh0aEY3QjdYUzNnVTY3?=
 =?utf-8?B?Ry9FMkl1bTBsQnpSRWJuWUl2UkU5MnNGalovbDJZRk1ONHRzZDN0a1JwUkhM?=
 =?utf-8?B?Q1YzVVpoMWZOWXlUaklVbS9xOHFlU2ttQ1RvZkJrZDJuS3pPa1V1RWh5Z3pv?=
 =?utf-8?B?anl3bEdpWEtrUWtVNjJwOWVOS0dwYjRBcmpMdWxScjZXbG9WcHpWa3BIeTB2?=
 =?utf-8?B?Um1nTGsyTENhZWdSdm94b1hHVTAwNU96U0U5NGwwUDNHZ3NZWjBaYzE5OHZC?=
 =?utf-8?B?WGpEdkZhaFd2N2JFWGFqK1cyd0RkSUp2ZVEyN0wrckcyYjljSURpZTdTQk1W?=
 =?utf-8?B?SFd6VFFqdnlicmlSNTFuN2kwNHFRWGsvdTBJTEJZb3JnU0FuRXNHYnpkQ1Iv?=
 =?utf-8?B?TGJ2dVpEOUwvQ1c1SmJHaUtUbHlqQ1k2eWg4NXJMNEhaNjNxMkx3UHJ3d0do?=
 =?utf-8?B?N3hhREpwQU5MNlB0M3RVbkwrWmxMOVNZU1p2bmRrTGpOUjFncmtmL3cweHB3?=
 =?utf-8?B?NUh1WW56N3NYVFk2bkcrdDhmSEp3ckcyRDhxS2RuWkVWV1Q1RkhQZE1kelFX?=
 =?utf-8?B?UEYzb2ZmT3duenJ6WGEwTUZNSGNLM0srTjlpQVVoR0xFMGJxVmVqZDlYcTRB?=
 =?utf-8?B?MjNHVTF2MkMzdzJuTFZ5QlF3L1AxT0I2NFRLa3o1WWhqeS9RYjNXaXJoM3Iz?=
 =?utf-8?B?NXd1TDUzQWxDM3RJOXMxbi94Sm8wOXhpUTRPa2xvRDNYZTJ2N2x2MDB2N3Vl?=
 =?utf-8?B?dmtKeDFsZGpOcUs1UTdPSzg5WUFjMzUxbmZUVmRFMS9zakxoeWdkQXBzRHRQ?=
 =?utf-8?B?anZJWldJbzUrdzFncEZPYmhHcmR0QXJFRmZpaVhsNmVZT3c0TDg1WWtvaWs2?=
 =?utf-8?B?Ym5XeWNLRWwyb2RXYXpUU1ZndFB2VVJialhRNUh1Z2hJanVxeE1ZS3UxTVNv?=
 =?utf-8?B?NXNoMlROY1NNaVZub3lVMmZWbVpSMWdVZytYQm5wTUtuTGM4eE9jRE03Y3dD?=
 =?utf-8?B?aThvOVhyWUtuT0E1cFZIajkwRHZmOHVHaTNNemZJb2N3bzA5OHpDWWQrQ0Y0?=
 =?utf-8?B?aUNlVk5lRUYzZ0M5VDlJUDZMc2FYNmNpbjcxR2w3WkpEVkpsdjFjaVk2ak93?=
 =?utf-8?B?R3U1RDgzVi8yNlhLbWlZYnBxQW0yQmN5ZXIvWWN1bFZheDA1K09RVjBnenZO?=
 =?utf-8?B?T1U4cTAreXFDVzVJWG9yU1NxU3V3dURxaktwZWYrbDlhSnVRK1p2d096ZEVI?=
 =?utf-8?B?T1pLdWRjVnVHdDliRERYWmxiQ3NvTnkxVWY2VGpiVEIvTWdya2E0eHZndFRn?=
 =?utf-8?B?d2I2YXhwTDZWNlV1a0NESWFoZHg0QTd1WHYvdlAxQWhiR3ZZTDFuc2dGY2FZ?=
 =?utf-8?B?TnpOSU9VQ3JwR2xEZXJNN21tZjZaWTJxUTVjdDRIT0Z5ZFVwMTNZUDBXR0Vl?=
 =?utf-8?B?WDc2ZWxNdTg2WDVFZW40K1Rpb2xaTGFpSlB6NXMrTVJKSTVvL0NSNUlydk15?=
 =?utf-8?B?NnRVSXBUWUQ0b1VOMlBTdUVLZXpqSEk2SkVZLzByS3JUcE9XN3hSaGFtQnd3?=
 =?utf-8?B?eXdHZS8vVXFMbmJhZzZJM1lTM1JHRlZqQmlJOHVZckNyNE1PQU9hK2V2M01V?=
 =?utf-8?B?eHNra1JRaUI1SllDcGhrbGtiUkptbmhXMjNnK3Qydi9hb2VRUlN6UVJBYUVk?=
 =?utf-8?B?L2k5QW4zVGxwWHNTZ0ltYW9FaHIzWWlia2kvcXlMQUVGQTZOdGRQQT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	x+lZ9VMWc7xKEfzTDsSLBzT4uKoU778eP9SFMYbeGbYGUnyuOD2Ey3FotbQXcsbne/sdKQKmiJOa7I/JpyRcLYO0CgC3WSPZFLIjbhgI5FJ4iL43dq18jBAFmF6+cmlburmqKcAJmjzsHJurUTPvwvr9nwJ0ru3x00RzTp+jmQDOlIEjs7NjzVKZwtiXEgydphOGcUpiJFSK9BpMWnKavqEGMvJKEWLtGLCPnU+6rCwpTj37vHxlBXbby4NdKIcz0m/v7Kfs2nFmh/5v3imaFKA9HY5Ly58AspSV3DfXd7dG7639Cl+8noraa82GwIJiqkFXWkAF+LIQmNUhVSMuyQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0548828-f459-45c4-7f9a-08df33c8327c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 01:18:24.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnFKVkurR5I9iHN/KW++BkBvPofFlwuu61MDiMF7cztaDyQQcZ1NI8JK4Agnwy7GI+pRsXFyckUIZbE7pAC0UAlUZE1ZxHUT6RFVmcs6zFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8958
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTXllb25naHVuLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4gQSBmZXcgY29tbWVudHM6DQox
LiBUaGlzIGRvZXNu4oCZdCBhcHBseSB0byBjdXJyZW50IG1haW5saW5lLiBhc3BlZWRfdmlkZW9f
aW5pdCgpIG5vdyB1c2VzIA0KZGV2bV9vZl9yZXNlcnZlZF9tZW1fZGV2aWNlX2luaXQoKSBhbmQg
ZXJyX3JlbGVhc2VfcmVzZXJ2ZWRfbWVtIG5vIGxvbmdlciBleGlzdHM7IA0KcGxlYXNlIHJlYmFz
ZSBhbmQgZmFsbCB0aHJvdWdoIHRvIGVycl91bnByZXBhcmVfdmNsay4gVGhlIHJlc2VydmVkLW1l
bW9yeSByb2xsYmFjayANCm1lbnRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBnbyBh
cyB3ZWxsLg0KDQoyLiBUaGUgYW5hbHlzaXMgaXMgY29ycmVjdCwgYnV0IEkgZG9u4oCZdCB0aGlu
ayB0aGUgd2luZG93IGlzIHJlYWNoYWJsZSBpbiBwcmFjdGljZTogDQpUaGUgaGFuZGxlciBtYXNr
cyB0aGUgc3RhdHVzIHdpdGggVkVfSU5URVJSVVBUX0NUUkwuIGFzcGVlZF92aWRlb19yZW1vdmUo
KSDihpINCiBhc3BlZWRfdmlkZW9fb2ZmKCkgemVyb2VzIHRoZSBjb250cm9sIHJlZ2lzdGVyIGFu
ZCBjbGVhcnMgdGhlIHN0YXR1cyBiZWZvcmUgZGV2cmVzIHJ1bnMuIA0KT24gYSBwcm9iZSBmYWls
dXJlIHRoZSByZWdpc3RlciBpcyBzdGlsbCBhdCBpdHMgcmVzZXQgZGVmYXVsdCBvZiAwLg0KDQoy
LiBQbGVhc2UgZHJvcCB0aGUg4oCcb25nb2luZyByZXNlYXJjaOKAnSBzZW50ZW5jZSBmcm9tIHRo
ZSBjb21taXQgbWVzc2FnZSwgYW5kIG5hbWUgDQp0aGUgYWN0dWFsIHRvb2wgaW4gQXNzaXN0ZWQt
YnksIG9yIGp1c3QgcmVtb3ZlIGl0Lg0KPiANCj4gVGhlIHRocmVhZGVkIElSUSB1c2VzIHRoZSBy
ZXNldCBhbmQgY2xvY2sgcmVzb3VyY2VzLCBidXQgaXQgaXMgcmVnaXN0ZXJlZCBiZWZvcmUNCj4g
dGhvc2UgbWFuYWdlZCBoYW5kbGVzIGFyZSBhY3F1aXJlZC4gUmV2ZXJzZSBkZXZyZXMgY2xlYW51
cCBjYW4gcmVsZWFzZSB0aGUNCj4gaGFuZGxlcyBiZWZvcmUgdGhlIElSUSBhY3Rpb24gaGFzIGJl
ZW4gcmVtb3ZlZCBhbmQgam9pbmVkLg0KPiANCj4gT24gYSByZXNvbHV0aW9uLWNoYW5nZSBpbnRl
cnJ1cHQsIGFzcGVlZF92aWRlb19pcnEoKSBjYWxscw0KPiBhc3BlZWRfdmlkZW9faXJxX3Jlc19j
aGFuZ2UoKSwgd2hpY2ggaW52b2tlcyBhc3BlZWRfdmlkZW9fcmVzZXQoKSBhbmQNCj4gYWNjZXNz
ZXMgdmlkZW8tPnJlc2V0IHRocm91Z2ggcmVzZXRfY29udHJvbF9hc3NlcnQoKSBhbmQNCj4gcmVz
ZXRfY29udHJvbF9kZWFzc2VydCgpLg0KPiANCj4gUmVxdWVzdCB0aGUgSVJRIGFmdGVyIHJlc2V0
LCBjbG9jayBhbmQgSlBFRy10YWJsZSBpbml0aWFsaXphdGlvbiBzbyBtYW5hZ2VkIElSUQ0KPiBy
ZWxlYXNlIHByZWNlZGVzIHJlbGVhc2Ugb2YgdGhvc2UgaGFuZGxlcy4gQWRkIHJvbGxiYWNrIGZv
ciB0aGUgSlBFRyBhbGxvY2F0aW9uLA0KPiByZXNlcnZlZC1tZW1vcnkgYXNzb2NpYXRpb24gYW5k
IHByZXBhcmVkIGNsb2NrcyBpZiB0aGUgbGF0ZXIgSVJRIHJlcXVlc3QgZmFpbHMuDQo+IA0KPiBU
aGlzIGlzc3VlIHdhcyBpZGVudGlmaWVkIGFzIHBhcnQgb2Ygb3VyIG9uZ29pbmcgcmVzZWFyY2gg
d2hpbGUgcmV2aWV3aW5nDQo+IGtlcm5lbCBjb2RlLg0KPiANCj4gRml4ZXM6IGQyYjQzODdmM2Jk
ZiAoIm1lZGlhOiBwbGF0Zm9ybTogQWRkIEFzcGVlZCBWaWRlbyBFbmdpbmUgZHJpdmVyIikNCj4g
QXNzaXN0ZWQtYnk6IExMTQ0KPiBDby1kZXZlbG9wZWQtYnk6IElqYWUgS2ltIDxhZTg3ODAwMEBn
bWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IElqYWUgS2ltIDxhZTg3ODAwMEBnbWFpbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IE15ZW9uZ2h1biBQYWsgPG1odW41MTJAZ21haWwuY29tPg0KPiAt
LS0NCj4gVGhpcyBmaXhlcyBtYW5hZ2VkIGhhbmRsZSBsaWZldGltZSBvbmx5Lg0KPiANCj4gQ29t
cGlsZS10ZXN0ZWQgd2l0aCBDbGFuZyAyMi4xLjIsIFc9MS4gTm8gcnVudGltZSBvciBoYXJkd2Fy
ZSB0ZXN0aW5nLg0KPiANCj4gQmFzZTogMGZjYjA1YjcyMzQ0ZjQwODA2Y2JlODEwZGU4ODcyZjE2
OThiZjA1Mw0KPiANCj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXNwZWVkL2FzcGVlZC12aWRl
by5jIHwgMTkgKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9hc3BlZWQvYXNwZWVkLXZpZGVvLmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2FzcGVlZC9hc3BlZWQtdmlkZW8uYw0KPiBpbmRleCBhMjkyMjc1ZjZiN2IuLjIzNDAwMWE5
M2FkNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hc3BlZWQvYXNwZWVk
LXZpZGVvLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hc3BlZWQvYXNwZWVkLXZp
ZGVvLmMNCj4gQEAgLTIyMzIsMTQgKzIyMzIsNiBAQCBzdGF0aWMgaW50IGFzcGVlZF92aWRlb19p
bml0KHN0cnVjdCBhc3BlZWRfdmlkZW8NCj4gKnZpZGVvKQ0KPiAgCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gIAl9DQo+IA0KPiAtCXJjID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShkZXYsIGlycSwg
TlVMTCwgYXNwZWVkX3ZpZGVvX2lycSwNCj4gLQkJCQkgICAgICAgSVJRRl9PTkVTSE9ULCBERVZJ
Q0VfTkFNRSwgdmlkZW8pOw0KPiAtCWlmIChyYyA8IDApIHsNCj4gLQkJZGV2X2VycihkZXYsICJV
bmFibGUgdG8gcmVxdWVzdCBJUlEgJWRcbiIsIGlycSk7DQo+IC0JCXJldHVybiByYzsNCj4gLQl9
DQo+IC0JZGV2X2luZm8odmlkZW8tPmRldiwgImlycSAlZFxuIiwgaXJxKTsNCj4gLQ0KPiAgCXZp
ZGVvLT5yZXNldCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXQoZGV2LCBOVUxMKTsNCj4gIAlpZiAo
SVNfRVJSKHZpZGVvLT5yZXNldCkpIHsNCj4gIAkJZGV2X2VycihkZXYsICJVbmFibGUgdG8gZ2V0
IHJlc2V0XG4iKTsgQEAgLTIyODYsOCArMjI3OCwxOSBAQA0KPiBzdGF0aWMgaW50IGFzcGVlZF92
aWRlb19pbml0KHN0cnVjdCBhc3BlZWRfdmlkZW8gKnZpZGVvKQ0KPiANCj4gIAlhc3BlZWRfdmlk
ZW9faW5pdF9qcGVnX3RhYmxlKHZpZGVvLT5qcGVnLnZpcnQsIHZpZGVvLT55dXY0MjApOw0KPiAN
Cj4gKwkvKiBSZWxlYXNlIHRoZSBJUlEgYmVmb3JlIHRoZSByZXNldCBhbmQgY2xvY2sgaGFuZGxl
cyBvbiBkZXZyZXMgdW53aW5kLg0KPiAqLw0KPiArCXJjID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVk
X2lycShkZXYsIGlycSwgTlVMTCwgYXNwZWVkX3ZpZGVvX2lycSwNCj4gKwkJCQkgICAgICAgSVJR
Rl9PTkVTSE9ULCBERVZJQ0VfTkFNRSwgdmlkZW8pOw0KPiArCWlmIChyYyA8IDApIHsNCj4gKwkJ
ZGV2X2VycihkZXYsICJVbmFibGUgdG8gcmVxdWVzdCBJUlEgJWRcbiIsIGlycSk7DQo+ICsJCWdv
dG8gZXJyX2ZyZWVfanBlZzsNCj4gKwl9DQo+ICsJZGV2X2luZm8odmlkZW8tPmRldiwgImlycSAl
ZFxuIiwgaXJxKTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiANCj4gK2Vycl9mcmVlX2pwZWc6DQo+
ICsJYXNwZWVkX3ZpZGVvX2ZyZWVfYnVmKHZpZGVvLCAmdmlkZW8tPmpwZWcpOw0KPiAgZXJyX3Jl
bGVhc2VfcmVzZXJ2ZWRfbWVtOg0KPiAgCW9mX3Jlc2VydmVkX21lbV9kZXZpY2VfcmVsZWFzZShk
ZXYpOw0KPiAgCWNsa191bnByZXBhcmUodmlkZW8tPnZjbGspOw0KDQo=

