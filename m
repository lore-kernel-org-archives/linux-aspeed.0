Return-Path: <linux-aspeed+bounces-4542-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8784C44524
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 03:48:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5HCn68H1z2yVZ;
	Thu, 23 Jul 2026 13:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784778517;
	cv=pass; b=lN73BrhmPtl1RyEXMR9J0wWbBjVVWwH17QYQCnw8T/W0cwsrBFEdW4/dT9IX0JZmfZIOd57Rjb1oEiuYlfK5QbNwCje37QCw4RdqlKftUdK7FFk384JsBJz5aHL+3CWYopBZ71sulPuZLA2I7ZRfrmNGhMmy493o5XeTAZdSkHrSyl/MS3RG6HiTOtZOR/DBAcpUZ8yut9skaMj10HK8dtKGWsythkdha5nCtZ3YV/75QeBNXSMrw3FfR+LaYbObkFgeNe1y0oa6eQwTOcxBaFinHGLYlD+hOy187heHSUwxQX7CALYr2T246Qk9g4yQqRFIR/GC3NfqsQcPi0LfyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784778517; c=relaxed/relaxed;
	bh=pBuX7HtChxENgZMCSsWZYD3XpjVUNik8WN2aQEjE0c8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYk+d7hRh9xxz6vDvL78fW9MyaxFOWmljU0DEpdGi3eKQ9B3LnjMp16OJM+InN+W6xrvogZDmBkJI+bHBCaKV1HO3J/HgU5R8l8poMDhif6wtT8RCEHc3LZKePxdkuQ6WxkXrcsxlDD44b5kSaZXTd2Xqi3/lmWPtw2wWUhiJ5s4JBg0PjSAn+uFN2Rg4OYN/kUBdVa2tDelTb2k7+18KaPMTjyOKFmJhFJaMpXx6w5x/tlDhqqCyS7y6/HhIijwLTcmjDsv5URGy3d9mxZYJKoRW+67cuItoYcdCNc2Owi7OWWhVANUp4sqU3AHDXC3FYqGEQ2keh5vdFLr2ni1TA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=E4ZShuOt; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=E4ZShuOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5HCl53cbz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 13:48:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NosL2JNu3uD2/pCyCIubXCyOOGCeM23yB1hixGsI0axQTjnq1esTAsirxjnxsoK60kvESpSswyMeMowQETnO6rt+qQR1kFTWwlLkmuIKGvKn3DGcEqqVDwwz5OR/om8Bm1RF3b4g3jd4Fa8zAzjoEAW2gYwBnAclGcPro40KXX4lg13UzqEWWdS9PIxwRCX+sqQRMmYG1fsjS7iwp6ZeJgBJ/eUZ0ozyHp/CiHVHmllj3VZq/72VA9V01QPKcIfCb9JAOPpqOy13JiLJuGwcUvT627ZSz6e6HuSkhHtUhbWQRdujgQ0s0hWROPs11pQJcIkdUfeh6KCQlpF33BflOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBuX7HtChxENgZMCSsWZYD3XpjVUNik8WN2aQEjE0c8=;
 b=SObp/OHXJxc9Ncbhxd1QaCHqFk562lg53radT1BNkIeO1tO9c9g/+eDjPl5BN931JVFiNqvESfFQjaxk+Cjqb9KGhxhwZQnUvYNRuW4/od0CYtBLKTaptcouKszQCxN+Sn9lPq+7mCaYxjnLXYtua7z/D5JGmwWbdmF9QA8AMiGv78RCdFewhSB+wtCkwzDOTpSLQ2+J2XcnzpsQfUiqbitge1FTvI2bjIxC4Lc9cncKdmfQGvfS9JnzQx9C5WM/SMMzn4NbgEZObo8UJNuA/T8xJwVXnM1sFvKDXb3Lng4yG9P9RrfCkoe213aE3KuatESN+P/LnU/fZpQkmpql5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBuX7HtChxENgZMCSsWZYD3XpjVUNik8WN2aQEjE0c8=;
 b=E4ZShuOt/QLjAuUeNSUSD+5ZA8j+Vmk8nC3rLvwU+kV3OKqtZk1ylqRri1T0SKFl4sLYu+bGEXV05cAe514Is9LpSlxQdcCvQ20fCQtjffoOu7nAUhNBHRNMqqAkK4Jee4JFPxwSKkM0uO4X7OTfGntzYDjkRp+hIkQAHEoLt53VPR6QBIDPiR5rYeEcTtpTmVP+AWS7pTxAbElKlfncl/GgtQIpUjgi4DgSSmE4vNOt4Ri7UyAnRT/cdkOB1aYhgJqB5GX8XX7/JPuCh5ZP4QSZ6/iLqxDzsfNDYxe9ZlmNUguNtck0UmJghdz8CnEPuK13jv+8Cf7nMNwGQFoRiw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SG2PR06MB5240.apcprd06.prod.outlook.com (2603:1096:4:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:48:09 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:48:06 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: =?utf-8?B?R3LDqWdvaXJlIExheWV0?= <gregoire.layet@9elements.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "corey@minyard.net" <corey@minyard.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, YC Hsieh
	<yc_hsieh@aspeedtech.com>
CC: "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] soc: aspeed: ipmi: add KCS Channel 4 over PCIe
Thread-Topic: [PATCH v2 0/2] soc: aspeed: ipmi: add KCS Channel 4 over PCIe
Thread-Index: AQHdGezQ0quMicaHf02veNXAwWBHIbZ6caMw
Date: Thu, 23 Jul 2026 03:48:06 +0000
Message-ID:
 <TYZPR06MB65685CF6F0969A3F400AEA2BF1C02@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
In-Reply-To: <cover.1784732161.git.gregoire.layet@9elements.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SG2PR06MB5240:EE_
x-ms-office365-filtering-correlation-id: 02484ada-ccaf-46d6-9874-08dee86d34cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|38070700021|6133799003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qMEBB0lEvq8ZY0gCd10JNoNc9ZoBIk7ZKWA4rgAKx5nfoQjZcG7rC8XbnJ0qn8Lope4fiYJIJdczshodgiGbJ+1pXhmev+tWgTLOcFVgyfA6yVSRxUBkHWlPr5AcflmtDRJmRIy0f1351DNrwrnaZkkapRuG1uRM6Qb1zr35CKAiw4QmHejxSd9TYyIUcfTxj/OQcRrqH6J0ceT7Zgd2YewXEeXghCGJViceU89cjEuz8q4H37iXvxdl3hEEo9OX8OXO5aoSh3RkRDCAbanEvv1HoIwWmsFyaUX1Q1KRir5dwyaLiKW5tOWlwEzJvePBAku5PjMOHB8aql+ZQK1mjiOwq1/8QSgNZEj+p0R1O3Jzd0jCQcvPFcu7DRzBTnl111e49JiC+oiXvHpmM5dUNPQGrxuG+yAIq4DmFHisf95hTUn9cvKQkjzx9CnGt8jxr0L2/2ByiMhjzgTb6t76fRrEK2KyN28ni+HIv1HM9+tt1zHIy0KXjZI+EC8+7PirHLp6BCRNwm8+u/NtEs/vQNbRh9v1b1Tpgb1Ise6AX7VwHuibIOv+da06D3P+v8Z4b0O5KyHwv4YMlobcOjMd9jT7HaNYJ9k9Doo/M/pKYlLbVeBTiuxRbH0oW2uPmzX3u8vCPGqWx4B7XaiQNwcnRC9khxD57A1zGOeUQdECoDONo/d7gpOgIRobeZDHsWkFX6Gg3TKM6yIZhB07fwl2Na4ArBMrYXIwQYjtbv7AnGE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUJwY2lsVzh1ZE9TWFFscjl2Y3UzYVFwZEdsRUhuM0tZTEJhTnFhZEI0bW1w?=
 =?utf-8?B?OE02SGRmMm1FSDUyMWJMNmVWY1k4S3FuZTN0OTZyZE0vUFdFajlZdXUyd2ly?=
 =?utf-8?B?RStCZVJrNlNkYlpTRm9NcUV6aUd3UVBaYUNna0F6UENHR3N4SlVyVm9OaFFk?=
 =?utf-8?B?OFhjRXFzak5ZcFdPNjgzU2dVMnFFUHVKRGN3bUdjbzlkclpIQmZwbjZhaSth?=
 =?utf-8?B?MFQrZXArb1ZTQ29vcVhjbTh6VHlKcGp0dFR1dHZwN1Z5YjFlbEVVcHNTR01a?=
 =?utf-8?B?L0p5Zjh1QTcybXg1NEpIYWpaSG5xU1hYSFI1dXdwY0pRbjNqUmJyMlloSWNO?=
 =?utf-8?B?UmszcnNhL21rNktPWXdCRW5Kb2lyY1ZFdnd1bDRQaUM4eThaaUpoTHJKNkhN?=
 =?utf-8?B?S2VTUDdWYlIyNmJTN1habjc5SUJzeVFRb0RPdjJGMTFySTF3d2JXaWE2cEdM?=
 =?utf-8?B?UXF3Q0JpbDhXcDZRWnpqd1ZJQlg4Sy9vY3lnMjRWR3Rmb2VYZFRPSWhub0g2?=
 =?utf-8?B?WXFFRjRNU2J0RFpwdkZDdHRTeVlMeCs0dWhPRmFxY3V1MnpmTXBVWjNlU0o4?=
 =?utf-8?B?NDZYbWx0ek82OW5tblpVb2pLaW5EVG9waXcveDkxYU5Bb1dhT2E4ak9hMUta?=
 =?utf-8?B?VkxleGFkT3VaVllwSVFEbGNIVkgzaW44M3lHS3dCVmI1NGRyc1hmalB4aEJo?=
 =?utf-8?B?OXdGSFJpYWMvUCttenBCbkVkbTB6NnZ5aHROUUFJMFh0VE1GZ2dpTUF0ZDhD?=
 =?utf-8?B?NmVpd0FJemVtVmlRN0JtWjlwcm5ZK21WWitzUkhHWlBsaEdlS0tuM1YvTzFk?=
 =?utf-8?B?Q1FjWHVGNi9BSmJkYVI3T3Bkc2gyLzhLdWUxMUxBRC9ZZXRBVitVaGRhTE1T?=
 =?utf-8?B?SHA1UkNrb1o4MzVMZjl6a2FvdWJnd1kzYTdTcFNBWk43TTlJOE9nYXNKdXQy?=
 =?utf-8?B?TGFVSnpyTjU2Ykd2aXlXaVYzQldWUEVsaTdOWm56dUpvcTZhNllyUWI3TlA2?=
 =?utf-8?B?bWdLRFU4MkFNeFI4WlMyRzRZQkNXb21XY1UwemZLRmk4VFFnaEJDQ3M1SnhW?=
 =?utf-8?B?UUtxVzBvOHpuSkpXZFN2bVk1Z0lpbjhlV21TTk5WTXNFaXhxNm1WVEVSWklF?=
 =?utf-8?B?Y0lxT2k5WDZLSXdRd1hoSUpTdnoxR0k1Zm1CRnZzTCtmNzR2c05ackdvT2Zh?=
 =?utf-8?B?a2ZOL29VM2phMUpVd1VuS1hEb1Y1OVNCTENVM1BPd0Q0VE82L0psN2tuTHlW?=
 =?utf-8?B?QjA1bDFydjlKQTNCa2hwblczWG1iRVZ0OGRjTkE1UjE1bm1ZZytZKy9aUmVY?=
 =?utf-8?B?Wm5QZ0NPcm1IbVBFQjVNaEIrMTVoUzNKSWFoa29kUkh0VUd5U2RaajZTa1dX?=
 =?utf-8?B?NTl6aElNYitxMkE2V2srMmIvdEdQZk5vS0Z4TURGMzljaE9NSGhjaDhHS2dD?=
 =?utf-8?B?L1c2dHNaNGNmT1o1VHArNFZ4cEsxMVFmcGhnRWhxb2hhQzdCOVRaWXhaSmxm?=
 =?utf-8?B?bXdGSmE3OTJHSlQ4L2VhREF3SlZraDlZTXFiV2U0ZGhvalJSajMrNTk0bGZR?=
 =?utf-8?B?M3VpT0pxdER5aXpiT3NydGJzZ0RDVzRtYVdNZDc2ZEdLK2c1YUxXSlR4WjBD?=
 =?utf-8?B?blhvUlFpNUwySUkvZnVEUnQ1RGhrL1pVNEdzd3ZSaTU3VmRlcWJxcUFQOU05?=
 =?utf-8?B?VFkyZ2tLbGdVeU9WaW9OQUxWMWNMUFlmQlJiZXFvTzIyRlNuUUdUMmI5RndR?=
 =?utf-8?B?NUVWVWlDTW9LdS9tdlYyRXRCdnNaWWQrNzdHZUc4ZWJud09ZWFlDMzhjUzFi?=
 =?utf-8?B?VjFKMk90RkJMRCtHc3hHaXBlNk9kQXdDZ3c0MERldlBxaGpUSS9Hc1djSWxh?=
 =?utf-8?B?R3F0d2lGOFcxQ3h2M2xnbG9mYWFSWlJjclRMeUhISEl6b1kxV0d4b04yU283?=
 =?utf-8?B?dkpITWFMdWRaamx4MnhmSEhwTnhiVFI1Yk9IdFp6eU5SVFhJTE8zNUNZeGxN?=
 =?utf-8?B?Q0VOQzFrWEJVSUpqQStzRTQ2bFZDNGJrWUN0bDc0OXBNZk1rbHFpbUcrTlpL?=
 =?utf-8?B?RmlyL0RlZ1I2NlkxNTZPajBxbEh6N2xTU0ltSEVkOURtK29LMEVzSnF1bnR2?=
 =?utf-8?B?dDRVM1QxLzJjM2xyTERTeTh6NGNQRmlvQTA2Y2ltNE4vaHZoNXdZT3JLa3Qy?=
 =?utf-8?B?QTRnWWV3OU9Jb2x0UXliQXcwUEZ4blU4SkFYTUpiWERlWVBVWHZPWVF0UU45?=
 =?utf-8?B?N2wwVVUrTTY0QVhqTW9mWDF0eUtqZkhveVlZd3VqdWdWck9VOGZ4U2duK1hC?=
 =?utf-8?B?M3hTTGJsOEMwZkJsNURMR0Q3TVllMEQ5NjRVQXEyM1UxK1o2MUdiZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02484ada-ccaf-46d6-9874-08dee86d34cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 03:48:06.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgzFGKw1QEN5gIylmyt1gseAf9lldEZCtIVyhievoOxxMSFTrlHrmHblJgU4fYEX7yXsaqe8ltSuWENpd+hzCNn3wlZpO57HUYaHZsQSngA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5240

SGkgR3LDqWdvaXJlLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NClRoZSBQQ0llLXRvLUxQQyBi
cmlkZ2Ugb24gdGhlIEFTVDI2MDAgZXhwb3NlcyA0IGNoYW5uZWxzLCBtYXRjaGluZyB0aGUgTFBD
IA0KY29udHJvbGxlcidzIG93biBLQ1MxLTQsIG5vdCBqdXN0IGNoYW5uZWwgNC4NCkl0IHdvdWxk
IGJlIGJldHRlciBJZiB5b3UgY2FuIHByb3ZpZGUgYSB3YXkgdG8gaGFuZGxlIG11bHRpcGxlIExQ
QyBjb250cm9sbGVyIGZvcg0Ka2NzIGNoYW5uZWxzLg0KDQo+IA0KPiBUaGUgQVNQRUVEIEFTVDI2
MDAgaGFzIGEgUENJZSB0byBMUEMgY29udHJvbGxlci4gSXQgaW5jbHVkZXMgYSBLQ1MgaW50ZXJm
YWNlDQo+IG9uIGNoYW5uZWwgNC4gVGhpcyBpcyBhIGZ1bGx5IEtDUy1jb21wYXRpYmxlIGludGVy
ZmFjZSB0aGF0IGlzIGV4cG9zZWQgb3Zlcg0KPiBQQ0llLg0KPiANCj4gQWRkIHBjaWVfa2NzNCB0
byBleGlzdGluZyBMUEMgYnVzIGluIGFzcGVlZC1nNi5kdHNpLg0KPiBNb2RpZnkga2NzX2JtY19h
c3BlZWQgZHJpdmVyIHRvIGRldGVjdCB0aGUgUENJZSBvdmVyIExQQyBjaGFubmVsLg0KPiANCj4g
SW4gdGhlIGRyaXZlciwgdGhpcyBQQ0llIG92ZXIgTFBDIGNoYW5uZWwgd2lsbCBiZSBkZXRlY3Rl
ZCBhcyBDaGFubmVsIDUuDQo+IEluIHRoZSBkYXRhc2hlZXQgdGhpcyBpcyBkZWZpbmVkIGFzIENo
YW5uZWwgNCBvdmVyIFBDSWUuDQo+IA0KPiBUaGUgQ2hhbm5lbCA0IG5hbWUgaXMgc3RpbGwgcmVm
ZXJlbmNlZCBpbiB0aGUgb2Zmc2V0cyBtYWNyb3MuDQo+IA0KPiBUaGUgaG9zdCBuZWVkIGEgZHJp
dmVyIHRvIGFjdGl2YXRlIHRoZSBNU0kgaW50ZXJydXB0cyB3aXRoIHRoZSBQQ0llIEJNQw0KPiBE
ZXZpY2UuDQo+IA0KPiBUZXN0czoNCj4gV2l0aCB0aGUgcGF0Y2ggWzJdIGFkZGluZyBQQ0llIEJN
QyBkZXZpY2UgZm9yIFZpcnR1YWwgVUFSVCwgdGhlIE1TSQ0KPiBpbnRlcnJ1cHRzIGFyZSBjb3Jy
ZWN0bHkgc2V0dXBzLiBUaGUgSG9zdCBkcml2ZXIgaXMgYnVpbGQgYW5kIHNpZGUgbG9hZGVkIG9u
IHRoZQ0KPiBob3N0LiBUaGUgaXBtaV9zaSBkcml2ZXIgb24gdGhlIGhvc3QgaXMgbG9hZGVkIG1h
bnVhbGx5IHdpdGggdGhlIEtDUyBhZGRyZXNzDQo+IGdpdmVuIGJ5IGhhbmQuICdpcG1pdG9vbCBt
YyBpbmZvJyBpcyBydW4gdG8gY29uZmlybSBpdCdzIHdvcmtpbmcuDQo+IA0KPiBUZXN0ZWQgb24g
OiBBc3VzIElQTUkgRXhwYW5zaW9uIENhcmQsIEFTVDI2MDAuDQo+IGBgYA0KPiAjIGluc21vZCBh
c3BlZWQtaG9zdC1ibWMtZGV2LmtvDQo+ICMgbHNwY2kgLXZ2diAtZCAxYTAzOjI0MDINCj4gMDI6
MDEuMCBVbmFzc2lnbmVkIGNsYXNzIFtmZjAwXTogQVNQRUVEIFRlY2hub2xvZ3ksIEluYy4gRGV2
aWNlIDI0MDINCj4gCVN1YnN5c3RlbTogQVNQRUVEIFRlY2hub2xvZ3ksIEluYy4gRGV2aWNlIDI0
MDINCj4gCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0g
VkdBU25vb3AtDQo+IFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrDQo+
IAlTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9bWVkaXVt
ID5UQWJvcnQtDQo+IDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0NCj4gCUxh
dGVuY3k6IDANCj4gCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNTQNCj4gCUlPTU1V
IGdyb3VwOiAxMg0KPiAJUmVnaW9uIDA6IE1lbW9yeSBhdCA4MjA4MDAwMCAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10NCj4gCVJlZ2lvbiAxOiBNZW1vcnkgYXQgODIwNDAwMDAg
KDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MjU2S10NCj4gCUNhcGFiaWxpdGllczog
WzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMw0KPiAJCUZsYWdzOiBQTUVDbGstIERTSS0g
RDErIEQyKyBBdXhDdXJyZW50PTM3NW1BDQo+IFBNRShEMCssRDErLEQyKyxEM2hvdCssRDNjb2xk
KykNCj4gCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0w
IFBNRS0NCj4gCUNhcGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MzIvMzIgTWFz
a2FibGUtIDY0Yml0Kw0KPiAJCUFkZHJlc3M6IDAwMDAwMDAwZmVlMDA4MTggIERhdGE6IDAwMDAN
Cj4gCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBhc3BlZWQtaG9zdC1ibWMtZGV2DQo+IA0KPiAjIG1v
ZHByb2JlIGlwbWlfc2kgdHlwZT1rY3MgYWRkcnM9MHg4MjA0MEU4OCByZWdzcGFjaW5ncz00IHJl
Z3NpemVzPTENCj4gcmVnc2hpZnRzPTANCj4gDQo+ICMgaXBtaXRvb2wgbWMgaW5mbw0KPiBEZXZp
Y2UgSUQgICAgICAgICAgICAgICAgIDogMzINCj4gRGV2aWNlIFJldmlzaW9uICAgICAgICAgICA6
IDENCj4gRmlybXdhcmUgUmV2aXNpb24gICAgICAgICA6IDI2LjA0DQo+IElQTUkgVmVyc2lvbiAg
ICAgICAgICAgICAgOiAyLjANCj4gTWFudWZhY3R1cmVyIElEICAgICAgICAgICA6IDI2MjMNCj4g
TWFudWZhY3R1cmVyIE5hbWUgICAgICAgICA6IEFTVVNUZWsgQ29tcHV0ZXIgSW5jLg0KPiAuLi4N
Cj4gYGBgDQo+IA0KPiBUaGUgb3JpZ2luYWwgcGF0Y2ggWzFdIHJldmlldyBzZXQgdG8gdXNlIHRo
ZSBleGlzdGluZyBMUEMgYnVzIGFuZCBtb2RpZnkgdGhlDQo+IGtjc19ibWNfYXNwZWVkIGRyaXZl
ci4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hc3BlZWQvZGU0
OWYyMDMyZjViMWYxNzAxNjFkY2Q2MTkxYzBkYWE0OGYwDQo+IGIwYzIuMTc4NDExNzcxNS5naXQu
Z3JlZ29pcmUubGF5ZXRAOWVsZW1lbnRzLmNvbS8NCj4gWzJdDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWFzcGVlZC81MWU0NTU0MTdiZGNmZTYwODI3MGM2Y2IyODA2YjFmZDk3MWYN
Cj4gYjk5OC4xNzgzNTI0NjQ1LmdpdC5ncmVnb2lyZS5sYXlldEA5ZWxlbWVudHMuY29tLw0KPiAN
Cj4gR3LDqWdvaXJlIExheWV0ICgyKToNCj4gICBpcG1pOiBrY3NfYm1jX2FzcGVlZDogZzY6IEFk
ZCBLQ1MgQ2hhbm5lbCA0IG92ZXIgUENJZQ0KPiAgIEFSTTogZHRzOiBhc3BlZWQtZzY6IGFkZCBw
Y2llLWtjczQNCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc2LmR0c2kg
fCAgNyArKysrKw0KPiAgZHJpdmVycy9jaGFyL2lwbWkva2NzX2JtY19hc3BlZWQuYyAgICAgIHwg
MzkNCj4gKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiAwM2Y5
MDZkOGY1NTQxZThiYjc0MTAzNTk4MTMwNGZlY2VlZDU5OTNkDQo+IC0tDQo+IDIuNTQuMA0KDQo=

