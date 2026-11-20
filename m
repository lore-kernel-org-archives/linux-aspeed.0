Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FB606A320
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Fo0zYn3M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW6Tx0sChz2yDm;
	Fri, 20 Nov 2026 18:31:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795159909;
	cv=pass; b=aypsmKmZJVJbKq1wDGXTr0i/ySfUnW0AP2SYAUKLPbg+xm6i7Jl/gA+Hpn45LfqNnlEVBmjBhsqD0MdhLjIJM0wDTfi67eWEI96y5fhvdd62Hlv1brFyxPqv3AB0Cou1VKWAt6Sk+xlVv1Oq0WtcOyYH87iKKk4FxQt4XdXKAClspjqI7VoaK1x7KUXx/deBJ9JRUOx9SWDCfcUDiU+TvX0imnNzTPgrw/ID8sVMfTm90CSWBM2+EJm8ROS98bzWqqmqzjugJBn4wuy2w73BUOrJwAzdnfdVLq1w+rDqtbakvBkoLCtw1ayelZ6S2rbLcMnKJ1v4B8+UkXorGcPzKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795159909; c=relaxed/relaxed;
	bh=xkaEZskxeyKMzDEDXXUrxv+rPJXuWY9+AXCI05Rw6LM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFa/Ae3JmbMACkUpBUK8XbPyvj9xUgyCbgZw+YwMIWybrWKMALDSlQnDaX+kDZ95nwST8+Zc54W9qLYA9V5dds8Ja4zsD0ky660JROu8mhL+aTrAd3oe/1o3663onQRLTwug0eqRyC7bpNPQc8cIQ9UNc6fFSyHNjbbaNleWSsK8UDc2TgP/VzIEGfvgUb3nWuO3dPlW8PggkozyELCCGb/4ajnhv3Ky+i3aQoxTuX3+59Ngw5vLfqtwSpvAKTNEKPypJhoai8VqtH6wZSMkvBo0G/sXNCtoco2fnTVKdCTI8ZL8bE0RFiGCjkYacIEcf3pGB+L4dstFEuubQryEPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Fo0zYn3M; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=neal_liu@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Fo0zYn3M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=neal_liu@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW6Tt2DSXz2xdR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 18:31:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI038XQw2bivwl+OUo2K4tDsxopgaSFB4N1eXV3AG0dPHmwt5TI/M/GNyZc30VoW/xJMq/FEnI9ALsfWjFwxRlyJhfUphYw24jTV7UVw6HqCN09akl9bAbbTHZEH8QlVTotNjIH8ahZDTE6Qh2btZv0TtlvoFm7ztGPwr694FJVjbeiXt3kDR5lsSNJgT3H9lf9qcVuQ31tnTMJxdVPQK4GMSwmbzHpRtFNV/1Qwv8BnCYI7f4Dk/IUDdiu2SbMjBM6nYHBK/ILGtTUXHoUh0Dip1L+toegATLD8+onoD76+c9HKqID3j+YaxJFMi+AL7klh8eaUZAndOBHbwCgHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkaEZskxeyKMzDEDXXUrxv+rPJXuWY9+AXCI05Rw6LM=;
 b=eprvJ+nt1IJ+0Zc1nZQdpLAoWfwj1fIQi55wMytEHzwiR7d451Vyy2i1oJ/A0ikw7MjR67CvG8KhlLRfQ83ahps5oskUmLZaGhrvb0q9J5ZQ8juFIyv+voiNmWSrTpbBVtMk/xC1LkTz3sE07uVz/tUb4TnLF5UaB7dAulicCghC9ts+622crq3g5AW7VO6SqOFLugqYC1cITxexNoWbytnq8cDpgmWDSykwTirjlk2K1Hx7U+NJhnLMl0LjooiJ4cTmYQDXVC2JvARQvw9b7zsZ3FUOKOnWdXM/vohUldVHkEpjrAboq3C4UG1b/o+8x2vyYvIMOsewKf+HJqQ/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkaEZskxeyKMzDEDXXUrxv+rPJXuWY9+AXCI05Rw6LM=;
 b=Fo0zYn3M9mz2ngEuwBKFgzAkBK+LI1IAPDhoDEZhoqfEFIZO1pavWB+Ba++gsU9vBoD4uYP5dcAJCztQHmtsASsPNv9DA7ZHABqg4Gxoc5UT/bI6/eF0GELX31ndTfuyPZ+k1mKZ9Wi5AqvKQiF4ockHL/LkJhj/b/xu2O/24UVMXFFSO1W+uQ9n9O94rTzjafccWCVFdhf+yZRVIpptx8tab1ksoXSHmDuFUl1XI2CrIoDFURArs3rKKFN+/LiDguk0HMjoXUARp7c7xAGVVZ7MWuBmR37JlljVQFj63Kgbm4fpLf3c94zILf1Xq8QuNL3+bIVhSkyI3tCRdgtx3g==
Received: from KL1PR0601MB3986.apcprd06.prod.outlook.com (2603:1096:820:26::7)
 by OSNPR06MB8281.apcprd06.prod.outlook.com (2603:1096:604:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 07:31:27 +0000
Received: from KL1PR0601MB3986.apcprd06.prod.outlook.com
 ([fe80::c909:16d0:3ee1:15c1]) by KL1PR0601MB3986.apcprd06.prod.outlook.com
 ([fe80::c909:16d0:3ee1:15c1%6]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 07:31:26 +0000
From: Neal Liu <neal_liu@aspeedtech.com>
To: Prasanth <prasanth.padarthi10@gmail.com>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>, Tan Siewert <tan.siewert@9elements.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: AST2600 OTP NVMEM driver: hardware clarification for v2
Thread-Topic: AST2600 OTP NVMEM driver: hardware clarification for v2
Thread-Index: AQHddA8Js82ynImxJ0OlecX/+/eNfbc1wEPO
Date: Fri, 20 Nov 2026 07:31:26 +0000
Message-ID:
 <KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com>
References:
 <CAMFFDGivXPRLWNVY-g1ngfUXiHRCFPfn5uAOy71mtpi+J2=M9A@mail.gmail.com>
In-Reply-To:
 <CAMFFDGivXPRLWNVY-g1ngfUXiHRCFPfn5uAOy71mtpi+J2=M9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
composetype: reply
drawingcanvaselements: []
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB3986:EE_|OSNPR06MB8281:EE_
x-ms-office365-filtering-correlation-id: 54c75a5e-83e4-4225-a8bb-08df46d84939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|261009223027099003|22082099003|18002099003|3023799007|13003099007|8096899003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|56012099006|10067099003|261102123227099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 5K+fsiriyupUO0ojXoTT9M766pyicsbN+v0XoBBl0822N+NwmcpWASDz6Qo3aMWdpViP7lwbt01PZWkwwNoOZtS7M3KYRI3nmA2PFN/X5DsgwfNjbM9pKm/V3zGd4HVb1BkCjDTXtD/mF3/JmuJbKqm6WgNeNzHc38cTEg96jrzv600aql9PYBQisFkSCUg6QbWNtUXdnFqfA9aDOKfTwnTvukUdFzkaLz4eK13WT1RSxCv4fTFP7bvze7gOORtINjFWXLRLr2NEV+SiMT9S0Wv5wT4mZLkP8pUiZhOsldUhSjFBqp7ALkygh6soPBb29sij/6okHYJYxnbnvYqoeD9NWbZNixDvAxh8jh/VzfZwfSrSFXH0VmcHSc0lNN5cpu10r3S0eAZzhwJyBrgHumo0gCmIg7s5Q0NSlUXrBdyxF2R2EbgifyfxocsK6a87mkHSpfZndEwrjIzeymyCt3mUHSonPu6diQRe5QVXHR4oMIuc+jzfo+VC2vrTid5oponOGFuC8hY+tN+6y7BvdPp/aqElbo0J7aSwSAxMCJ+XVGwzgf3HN11L+5ll596gnDBZueF4+NuStQvXhgWoxtXrkkre8HRTAp2YuDiJoBHH3Kly4V5KtSPBbLE5Hxs/SByneTo2naY1C6YiPyD4QR6PpB8asBxXEveVAq6iVKs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB3986.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(13003099007)(8096899003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(56012099006)(10067099003)(261102123227099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?sxuwhssvH+lg/GAQGnsdXIgernd/xQYmotQbzxNiRG096p5gtjHiI9mK?=
 =?Windows-1252?Q?/1icW/sto8W4LLfHyiu0hPU8sU966uMG81aMgR+NcYmPYpH8sxT0lbMq?=
 =?Windows-1252?Q?Qtx4CVuMMO84bj7wfUTXBSpWEwPWsf9jir7aEJvSZKENf1+lDQ2e+/i8?=
 =?Windows-1252?Q?g33JzKk14/7GlnKN/O1WF35eeiZVcOEu/+oyRcbymgg3vZ3FzN+3xcjL?=
 =?Windows-1252?Q?bu1aw1iqqLnB8ePQnZ4HWv5zy+yHhzxyM/a9pti8jtgK2AZfeEh4SjcY?=
 =?Windows-1252?Q?rEE1LjsiDt+uOE1h3jpe0b6UmAq9/0F5F5lLIMeU+fBc0+M59tS8gRLK?=
 =?Windows-1252?Q?riU4ZdFyQHOG4cW1KudXK2efb3XTh4xKfs60qdDhw0BTRRP2QWS2PQjv?=
 =?Windows-1252?Q?Sk1TPp8wIF5HRhpEx5IvOJcGPWgSx57s6y6ga40FvLUg2gp6fO7ke4XL?=
 =?Windows-1252?Q?he5gk6uKbJKr74w46tuy8/veWC6P876m2XjofPntmb1Hcq4cUgg0zT5K?=
 =?Windows-1252?Q?ZpAqwWnAaPbLee4vz9Rl7xGdqovNVXcRfVIK90hWNXiZnQWCDj3Plbk5?=
 =?Windows-1252?Q?QIiAvbrzSZpfWNKQKu0Si/H6JN4GU7xpwjUDpHrp4qB8CM1nfxwV6Es1?=
 =?Windows-1252?Q?07IKm/rnTUpXtnoOrJLVOHDdGXFkD87npVbUmzgpA6lDDe/M/86FLJrH?=
 =?Windows-1252?Q?EW6izTZTriQa59vrg1pPWhEAveGk0xQOvRn8gPN2Vbjk8vIs6ciQYUAb?=
 =?Windows-1252?Q?/uqOuBPs+BRXboDNk5V4sp7cdZqMRcsK9YNsbhaCwEim7RcPNbd32eks?=
 =?Windows-1252?Q?2o9hLo5r8jpsnLy1ml+ERo+psgE7cibOxXZUlO12YMd/pDUWl4+hj21l?=
 =?Windows-1252?Q?F+9QMngucRwczH2Eb4hLTOYrjNTSWwiBPjhErdoAw5++eFU06bSaAcq3?=
 =?Windows-1252?Q?XAwXH4X+nUhKfKURi+jQMUn8xPNEBwCidfEV8XXvQOb92cgmWrfXeNBp?=
 =?Windows-1252?Q?YAyQyQzoVXPT3mihF8qT+6Z6D9taulZKcJrnKnwSI6cmRhj/EyeZcK17?=
 =?Windows-1252?Q?UoJpLS1CGHUmwM7NbpHcEuTd+pe0tGUIpAI11QTVMKljDl7L2fKaf0e3?=
 =?Windows-1252?Q?5mTpS/jLelTkX1DQAPM0GY3ieUr+kigfieYhPVRV8DmP0iV4drJMeFEM?=
 =?Windows-1252?Q?lkO8qrdVlaQzA4YYXtfPw0jUT02y5JXgfhT5SEoMKivnliv2IFrEA1Qw?=
 =?Windows-1252?Q?N6RUBc6KUCfTBuQ2tIJHFEqXEm0WEz/qwVW1T7mMAlEZky9suPtrQoKu?=
 =?Windows-1252?Q?lSnHkx8LZ1ho/DntJ6PC4E0NgsR8za2UO+tacjngT5cS7gAFT6Vvr//t?=
 =?Windows-1252?Q?DniEM+oZHDrlxI3wsnJsA3Bl3Pl4e7eiAYxe83wS6K/TdKikVz3x2wuQ?=
 =?Windows-1252?Q?4Qk/kVXFoBfXwcEBvLw/6aE4qfd1AjHWY8EvUZZmFkZ0msgmilnk3DDH?=
 =?Windows-1252?Q?WKH2Hwz88H2OMowMYXpogz24+NTF9ERp2gi5vm5dOTWg+Kuzch0VS76+?=
 =?Windows-1252?Q?93iCokO8I1jxOFL2+A91cNfcDgHlSZFcYXV/Fi4FWZTSsv127wkleCiT?=
 =?Windows-1252?Q?rCsPOA2ntzEwdLgVMdj78YQr065ritj9dTeo0L9vUgNfwLSLg0EoaBpP?=
 =?Windows-1252?Q?6VHoa35CDprgIpJ+oNSDISeO/lzqUTFxX8qqQVt5cdXLz1tdm+ycbQPZ?=
 =?Windows-1252?Q?JbA3d+vWiLvPY5aH6bn9AGdcHzgHqVQw0HA0yB8P7bY9PL2Q7q9uy+b0?=
 =?Windows-1252?Q?lV09tNbitITNT1Gu3sSvlYFw2FDm+RqmVG/KV1pMvDVqOQoohEuVzb5m?=
 =?Windows-1252?Q?awV0IUaV56xxDzGAU+z6XR+p/Xn4rsOmnBY=3D?=
Content-Type: multipart/alternative;
	boundary="_000_KL1PR0601MB3986A356BD06F98D0FF9AD5E80792KL1PR0601MB3986_"
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
	pINJmhY6hsdlpDJr662K3OQjy/qhgs8nbc7yq19OkdKsxjiDomnjUGSx6VdCNT2MKEr5TfRkETZtkGDHjymA5S3svtIdgSmUl6EpNiWO0/8rjcj85w0wii5c3sZtDYththSD50BM78K1z5r84+RWhuxxWEokEjuXq19SuC6B7qU6FvyxS2jqsiJ18bOdpx5btqB4RFtjFl/sCvH/9sj+LnjLyejZz+mKyEdVj9BnlwFjNBhwswIzNBmcaVEHNXK1hGJ8bQWo+iJDLL7cxP11n6/y7InxR+1pTP4SEALe9aRekGR/O2fWgqMJnvz+RmiFxNkakSoRMJirAtpNSCKXVg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB3986.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c75a5e-83e4-4225-a8bb-08df46d84939
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 07:31:26.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErJ4xKw3urXa0kcE4WHcU2j9WtLFlXggOwIROLK34Kz7+3YWGFQ3l7oz4VFdQUb8DrF3Ef2rkV7nbvSfivd5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8281
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_KL1PR0601MB3986A356BD06F98D0FF9AD5E80792KL1PR0601MB3986_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Prasanth,

Thanks for picking this up. Answers below:

1. No erratum. Waiting 1 us after the command, then polling
    SEC14[2:1] once, is enough.
2. SEC00 only blocks new writes to SEC04; relocking it does not abort
   a running command. Nothing documents a safe retry, so keep your
   current behaviour: return an error on timeout and stop issuing
   commands.
3. Reads must be done in read mode. Programming leaves MR/MRA/MRB in
   program mode. Nothing in Linux programs the OTP, so restoring read
   mode once at probe is enough.
4. No documented maximum. One read takes well under 1 us, so 100 ms
   is generous.
5. Yes. SEC54[5:0] uses 32-DW units, and the protected prefix is
   max(OTPCFG0[21:16], SEC54[5:0]) * 32 DW. SEC54 can only increase
   (SEC54[6] locks it) until ARM reset, so it may grow while Linux
   runs. Check it on each read instead of rejecting any nonzero value.
6. Yes. SEC14[8] only reports whether the address is write-protected,
   for programming. It does not affect reads.

The datasheet is not public, so please cite this mail and public driver ins=
tead.
I'm fine with being listed as co-developer:
Co-developed-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Thanks,
Neal

________________________________
From: Prasanth <prasanth.padarthi10@gmail.com>
Sent: Saturday, November 14, 2026 4:06 PM
To: Neal Liu <neal_liu@aspeedtech.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>; Billy Tsai <billy_tsai@aspeedtech=
.com>; Tan Siewert <tan.siewert@9elements.com>; linux-aspeed@lists.ozlabs.o=
rg <linux-aspeed@lists.ozlabs.org>
Subject: AST2600 OTP NVMEM driver: hardware clarification for v2

Hi Neal and ASPEED maintainers,

I am addressing Tan=92s review of the read-only AST2600 OTP NVMEM
driver. Could you clarify these points?
1. Completion polling: Why does the downstream wait_complete() require
two successful observations of SEC14[2:1]? Is there an erratum or
silicon-revision requirement?
2. Timeout recovery: After a command times out, can the next request
wait for idle and retry safely? Is reset/reinitialization required?
Can SEC00 be relocked while the command remains active?
3. Read initialization: Must software restore MR/MRA/MRB before
reading? If required, should this happen once during initialization or
before every read?
4. Timeout limit: What polling timeout is recommended for read and
mode-register commands? The current 100 ms limit is an engineering
choice, not a documented ASPEED maximum.
5. SEC54 range: Does SEC54[5:0] use 32-DW units, giving an effective
protected prefix of max(OTPCFG0[21:16], SEC54[5:0]) =D7 128 bytes? Are
there boundary exceptions or restrictions on changing it during Linux
operation? The driver currently rejects nonzero SEC54 ranges.
6. Programming-protected reads: Are ordinary reads supported when
SEC14[8] is set? Reads on my B650D4U passed, but the tested addresses
had programming protection clear.
A public reference or shareable guidance from the Secure Boot User
Guide would help justify these decisions.

Patch  Series:
https://lore.kernel.org/all/20261113034213.158390-1-
prasanth.padarthi10@gmail.com/
https://lore.kernel.org/all/20261113034213.158390-2-prasanth.padarthi10@gma=
il.com/

Thanks,
Prasanth Kumar Padarthi

--_000_KL1PR0601MB3986A356BD06F98D0FF9AD5E80792KL1PR0601MB3986_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Prasanth,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks for picking this up. Answers below:</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
1. No erratum. Waiting 1 us after the command, then polling</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; SEC14[2:1] once, is enough.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. SEC00 only blocks new writes to SEC04; relocking it does not abort</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;a running command. Nothing documents a safe retry, so keep you=
r</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;current behaviour: return an error on timeout and stop issuing=
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;commands.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
3. Reads must be done in read mode. Programming leaves MR/MRA/MRB in</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;program mode. Nothing in Linux programs the OTP, so restoring =
read</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;mode once at probe is enough.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
4. No documented maximum. One read takes well under 1 us, so 100 ms</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;is generous.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
5. Yes. SEC54[5:0] uses 32-DW units, and the protected prefix is</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;max(OTPCFG0[21:16], SEC54[5:0]) * 32 DW. SEC54 can only increa=
se</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;(SEC54[6] locks it) until ARM reset, so it may grow while Linu=
x</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;runs. Check it on each read instead of rejecting any nonzero v=
alue.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
6. Yes. SEC14[8] only reports whether the address is write-protected,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;for programming. It does not affect reads.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The datasheet is not public, so please cite this mail and public driver ins=
tead.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I'm fine with being listed as co-developer:</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Co-developed-by: Neal Liu &lt;neal_liu@aspeedtech.com&gt;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: Neal Liu &lt;neal_liu@aspeedtech.com&gt;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Neal</div>
<div class=3D"elementToProof" style=3D"direction: ltr;"><a name=3D"x__MailO=
riginal"></a></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Prasanth &lt;prasanth.padarthi10@gmail.com&gt;<br>
<b>Sent:</b> Saturday, November 14, 2026 4:06 PM<br>
<b>To:</b> Neal Liu &lt;neal_liu@aspeedtech.com&gt;<br>
<b>Cc:</b> Ryan Chen &lt;ryan_chen@aspeedtech.com&gt;; Billy Tsai &lt;billy=
_tsai@aspeedtech.com&gt;; Tan Siewert &lt;tan.siewert@9elements.com&gt;; li=
nux-aspeed@lists.ozlabs.org &lt;linux-aspeed@lists.ozlabs.org&gt;<br>
<b>Subject:</b> AST2600 OTP NVMEM driver: hardware clarification for v2</di=
v>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-size: 11pt;">Hi=
 Neal and ASPEED maintainers,<br>
<br>
I am addressing Tan=92s review of the read-only AST2600 OTP NVMEM<br>
driver. Could you clarify these points?<br>
1. Completion polling: Why does the downstream wait_complete() require<br>
two successful observations of SEC14[2:1]? Is there an erratum or<br>
silicon-revision requirement?<br>
2. Timeout recovery: After a command times out, can the next request<br>
wait for idle and retry safely? Is reset/reinitialization required?<br>
Can SEC00 be relocked while the command remains active?<br>
3. Read initialization: Must software restore MR/MRA/MRB before<br>
reading? If required, should this happen once during initialization or<br>
before every read?<br>
4. Timeout limit: What polling timeout is recommended for read and<br>
mode-register commands? The current 100 ms limit is an engineering<br>
choice, not a documented ASPEED maximum.<br>
5. SEC54 range: Does SEC54[5:0] use 32-DW units, giving an effective<br>
protected prefix of max(OTPCFG0[21:16], SEC54[5:0]) =D7 128 bytes? Are<br>
there boundary exceptions or restrictions on changing it during Linux<br>
operation? The driver currently rejects nonzero SEC54 ranges.<br>
6. Programming-protected reads: Are ordinary reads supported when<br>
SEC14[8] is set? Reads on my B650D4U passed, but the tested addresses<br>
had programming protection clear.<br>
A public reference or shareable guidance from the Secure Boot User<br>
Guide would help justify these decisions.<br>
<br>
Patch&nbsp; Series:<br>
<a href=3D"https://lore.kernel.org/all/20261113034213.158390-1-" id=3D"OWA3=
6a81e87-7b88-6183-990c-c69ba097ecdd" class=3D"x_OWAAutoLink" data-auth=3D"N=
otApplicable">https://lore.kernel.org/all/20261113034213.158390-1-</a><br>
prasanth.padarthi10@gmail.com/<br>
<a href=3D"https://lore.kernel.org/all/20261113034213.158390-2-prasanth.pad=
arthi10@gmail.com/" id=3D"OWA9fdb256b-c5c5-e7ae-07bc-b11d21b60a70" class=3D=
"x_OWAAutoLink" data-auth=3D"NotApplicable">https://lore.kernel.org/all/202=
61113034213.158390-2-prasanth.padarthi10@gmail.com/</a><br>
<br>
Thanks,<br>
Prasanth Kumar Padarthi</div>
</body>
</html>

--_000_KL1PR0601MB3986A356BD06F98D0FF9AD5E80792KL1PR0601MB3986_--

