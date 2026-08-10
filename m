Return-Path: <linux-aspeed+bounces-4674-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A275C5AC82
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Aug 2026 06:24:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJPqS4znCz3048;
	Mon, 10 Aug 2026 16:24:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786343076;
	cv=pass; b=jgH4owmJz3s1ZovWosol4I8zwREo5jUQ+779R2j5CHpNa8QzDpXOxAse67B6Ste0R0cUY1aTTABmZAyS0mzI3BZ5sFzXq35rKF+pMJQTQ6dwkqT7J6Y8Mg2d3ue6D3uhpLqetNCIvjXs+eyMPTF6KbaUa294GI5oFU4v4f9A3Bub8wcPGAm3AVuU4f+6jXuiC0CBUhKQznLcJgMdHEbnmSsKsNEt1Blrg5p5zhY3JvtrjVW6aVKq2w5nVj5C9jpxvfgfyUW1mQAZWZBusqsOKpzawy/HibppRH4zGC48F3qWxcIIIRTnwW1/edrmvRb6wahTR3wklBl1Swle14bTCw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786343076; c=relaxed/relaxed;
	bh=ybLbPPF3QfwXuKFhDDSQEGJ1Mv/q7ZvZDiz8u1e3sBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AR2thtaMftdB8N9It9uGLdhdaFUauPI3yEDuPRZYmrv5hAV62RTF0bTqtWxvBcwFSE+7sjOyCp2oUWR4XSKGIqCFFQWUQsygGBvMxXKf7AQgZdvkr5YVLW3V+2WpBGsADjN3f8/PFVlhUo2rOOTPAUgdThz34JDoE1zwGJ4hi55NgAC4t9tIUeUPnHm8/nyryIbsrs7dGcobfHiAmnp3s3vS3fjeruJnqfwTOOYsnm/Trjb/u5rQUOLnKZv0hrMIuzUxYDDTp4tfB8PIXzr87Gk9ZvG750L7mnHvjahDem0/oOQMnnr2nisJjfXMTP/gv/O/YhAKq8MUQXIr5vJZlw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=RlG5M1J5; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=RlG5M1J5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJPqR3sg0z2yYq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 16:24:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4NPLqaf7CX59gVv2LxvWlAmreKzyCYKM/zCgmLqs4jz2UyN88wvT2xYQKga0p8LMoOBtMG4QBWDHmYmZtADSLfOV1bSHnAZFwjaRibCDOPHTA5Wzw5x2h6ER+ockF4myJgDn46R9EE5lRY7NS6ALprfhPGmf3vfUrK+PR6KJOtVolsI6nZfoIoouoZpJSAaIrmvrkel5CMtjdH+FihoudPpvyYqjKC30jwAdsSZvLnlIFPR0fo32rtjueBskZYUD2ExJaRlyFEwxCSuCLH2dZaw/4KDovXy8y8u4nKCpqlbyP+HgwjTeerpH+jLew9iM0k1im2ixhPyKqTaG3amQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybLbPPF3QfwXuKFhDDSQEGJ1Mv/q7ZvZDiz8u1e3sBs=;
 b=WW2xLJUrepwc7/9kKYx1wXr/TdBklonM9XKDmh2XA9DfFx1QpJ9haGSQMw1Z+2fw1b7wGQ3RqYlRBhS4IYq0hyIiVXhscyvhN4BZgK8r8eZqvaevmhpqAFdta5aMIl1QCQhOTFCWdAGqrJxwDURY1HwQf4cfKUxzLci1mpKll5zjKUD2/y32aMmGbzEF8SGOCbGtDJjDpv0ElGYwUcNNv70LcCpBm06GBewbkzptncVHZROlwb2/2Og6B0g3r3yc260hzYWpgCWkxid5bF1q5g93V84HcCxq7n09w9gh1a033RlZBV/NwmOuAZ+ZlRHzeRP/no2LTfFWUfQ80Bg8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybLbPPF3QfwXuKFhDDSQEGJ1Mv/q7ZvZDiz8u1e3sBs=;
 b=RlG5M1J5BU990ntHcSFp83d7LLj1lR0UCEHwSlHC58siYhs3DrrdqhNOvxEC1F6mTNh7JGFbw2keKXHdwS0z50+0/rPjYyC9BIJD+k2qhDLEmHHGCc5gRTkkrLUa3f4MP97yVAbSxnZxjtujR29fdcUpGlRQxQquXaCAs+lm1eUetkXLO1AFESUhpYvDv3FmcrWNLsjigm8MLB6tbIMgZ5SoCsFeNoLh2Veu62Ilias90zmncLHf350oFaEA4JmC0/v4EiogOzxz65x888iCZ2rayBCZ8HUOYV3HVUxzft3leXpFpHzhG6EQYuTr4TBk78X7LXaQs6+/DiNqGWW/hA==
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com (2603:1096:405:13::10)
 by SE3PR06MB8408.apcprd06.prod.outlook.com (2603:1096:101:32c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:24:11 +0000
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05]) by TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:24:11 +0000
From: YC Hsieh <yc_hsieh@aspeedtech.com>
To: Lee Jones <lee@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, ChiaWei Wang
	<chiawei_wang@aspeedtech.com>, Corey Minyard <corey@minyard.net>, Andrew
 Jeffery <andrew@aj.id.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH RFC 1/2] dt-bindings: mfd: aspeed-lpc: Document lpcN alias
 for multi-instance SoCs
Thread-Topic: [PATCH RFC 1/2] dt-bindings: mfd: aspeed-lpc: Document lpcN
 alias for multi-instance SoCs
Thread-Index: AQHdGmSNPNVIJAn/I0uFrmGW71QRFLaRGueAgAXPdmk=
Date: Mon, 10 Aug 2026 06:24:10 +0000
Message-ID:
 <TY0PR06MB6855FDB0FC2A4353DC96C00D93DE2@TY0PR06MB6855.apcprd06.prod.outlook.com>
References:
 <20260723-upstream_kcs_multiple_lpc-v1-0-d918b5270b86@aspeedtech.com>
 <20260723-upstream_kcs_multiple_lpc-v1-1-d918b5270b86@aspeedtech.com>
 <20260806133111.GF2869284@google.com>
In-Reply-To: <20260806133111.GF2869284@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB6855:EE_|SE3PR06MB8408:EE_
x-ms-office365-filtering-correlation-id: a8c9bf6c-cd75-4da3-3a64-08def6a7fdb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|38070700021|6133799003|10067099003|4143699003;
x-microsoft-antispam-message-info:
 buXNcVuxOD+/44YUk9Zm0t5bP/8/iNpoSIjhEi3XOB4zyyCzymzz0/Rxzb2cZC8en+2HSExad9YjFBc80DFuTfD8S8NdwikPoowkmKVKOSKy3x5TBItSAOX7GSh72k0vnruXVld93I6GmQiQ21Zk7SFo3mG0YJ5A3zvygCsxWeIFP1GuOu7NwOK7BlOtFBMNv2lE6nsHxYLsXB3vwYNnnehrSx/eQ1rVyqvMhXpJgOmM+faij95uisQF9lRAbZxxf14SdKG7Ly/MTuP1hEmiT3jAS7yrWt5c+JDyAGYJ4KiuHsBXRC1BQceiWaxnTOsq+86DS1CCglvOpdBE5mDh7LBVYUdpYEtRCuS500hKhCQLCPadM9lYDbW/RureJ1BoUEdoN/9nl6KZbEAdvmPCQYNqCgx9v0us9+DvGjjiMMfdP3/EBjTKur6obt4+DIWB0H3+spmLVetidczsXN7G4CpiaWpiZkkm4lAriaKtZLfHb+zinJ/wONiQ8LohWvFAvBW50DLjUkFNfNlCfMQDNzaSMweU7rfON7CSl/X0h/z19gamiWgPkO+vDGQhRjTtgNcaKX8b3m/SAXM0M0bbCfnBkJ7Cz+HRehS76P/MDuKZFBiQlKGM4jhf7VulDtdEWrnC8YU9Oc8+oRM5P90nqvd7u5iPeHHiSNLbKV2wOvzdYiIzPiRBhIV5A847MnKJGIVyCsxtlyQ86Q8UsteBFty5P1dlXs1wwXCNMIGgZtI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB6855.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dNAgwsCPMBfbZOj2UdtEniW9RdBGZo+dVy7m0gvRoTr2amSVFJKTkkbEU3?=
 =?iso-8859-1?Q?eHaUwMvxVf63NpT3YJulZZwL0nE0GN6OgQmlnURgg8hVBv8mJwPKmzxWuv?=
 =?iso-8859-1?Q?d1PuVBWfQWP3hs329VjZEaUnZv+lfdGeYryszkrZg2yag0bjky8KFjdX+j?=
 =?iso-8859-1?Q?v5zjD1ukG8CAxFIxblLFaTKe4TIa9Od5Wfg6Xp+rlt2KYuGoynE/osxSDc?=
 =?iso-8859-1?Q?J3AchzyWOW6JwArkDLAF1AZbvv+LGfY5an1siI2xKk27ce1AwpeCe3R8O5?=
 =?iso-8859-1?Q?OW109qgnnx8vp5xpbIqz3pUHB9sjjMrGLUoj403QOJAo0MLNfvuZK5uV7F?=
 =?iso-8859-1?Q?9ePY15ketw4OgAMFJtJwg76h9cYDlv29jGPY0pFwS553MPQtxA3ULEHj5a?=
 =?iso-8859-1?Q?o7gAuRlvckREsunPDkAwhwbtdS6b5/ShS44d5xFZmqoWzfzMj1iJFfipsR?=
 =?iso-8859-1?Q?AZ3vnywPTyLDbZDklA1GHIiWNOkvZhBZU2McGqSooHFEKBX3/Pjp+14Et+?=
 =?iso-8859-1?Q?pipIRdc4KBwhCC1FaZu1uAgyE5jniyLHx9aKrCFQhrfsdZHNI974tc/Tdr?=
 =?iso-8859-1?Q?FWuqRGKMYAvuPrLlwjA/dV5ysgQFkco6iVqIdIPDiubdZQgFvzXIYxP4iy?=
 =?iso-8859-1?Q?zpn7envAuxekp6ljdAb7ngJuTKe+//RxGXZOBSSDZkx3HgrXyYxX0skZ3y?=
 =?iso-8859-1?Q?LeHto0wCHDrth7Dn7g1PeJTng8kGhJLte2zNrdpo++VdKiSPYt6D4DOcSa?=
 =?iso-8859-1?Q?XxvsdX3Md7A3w8q467vzGWzP/X3P3SqkFWzcO9OBGmYC/ihrA+H2MaR1NW?=
 =?iso-8859-1?Q?bJdoiZt2U5jqbr5bllC/MLOnF+OACQr5bOAZixg07MJ8wSFGnxiVT0qpGv?=
 =?iso-8859-1?Q?AMX+ek1J+oXl/lKhGQwJy8wtiqWablFXIezLH13d8YDGBpC5CVnh7diAvt?=
 =?iso-8859-1?Q?TaCVX+uh4MVrBs3xVyHIC2tIkT5XoIv+Em9kMm7t/rN9vHmGmAlxdob7lz?=
 =?iso-8859-1?Q?V67X/SVUfoDy2dkoJthJpQMpnpXb53kH0UrgU1pL9m+mi/pikkx8Ix4X0l?=
 =?iso-8859-1?Q?sKujC8hCNgz+GQKRFpRLQoLGWb1UJPPqpNZSujySdeKQkPs+qQCvrX4yhG?=
 =?iso-8859-1?Q?ot0JAraWfBJY4yxnVv2JyTnsTWdfVP6P1HeZw5+50EkC52jjx6F+CnIoWl?=
 =?iso-8859-1?Q?Lsvr2gAV1xZZNV7MdYZcjLVGvXCUm2IZSeNtB/3AfBZjh77Y6lK0dCvWwn?=
 =?iso-8859-1?Q?skfIgfjQx5/T8oY8ypmmCtOqFXQiA6CyEyGWB/d+AxqtOU5jDXWjSd1KlL?=
 =?iso-8859-1?Q?hAmUTwF/Z3nyQQSKABvQpahO2c/APmLms+5/oPfzapax2ZT6c+IgqdeveI?=
 =?iso-8859-1?Q?RuAGQL1b/7NExdNhPSG5CoKsE7QJupOzDIpwOpGCiS0sjsod4wQCjdq0Jh?=
 =?iso-8859-1?Q?YjcrOe/xwIwC4L/pziR0Hg4WTKf607Jbzy/8O8dtXky0HQT8iAiZyaq8ZR?=
 =?iso-8859-1?Q?PCRZq6gKjDnB0kJG3lX3h5LCjyWApfmdr3PUiDmji9rpVgoG2Z+gPQHXqO?=
 =?iso-8859-1?Q?nNUVG1rv8knbVfN30z+wmgtbux4pTy9qwqdQMyPDzPs78o3VaWw6WTYGFA?=
 =?iso-8859-1?Q?h16Jyo0zz3SutwCMOffRkPqXxgdRIEfQZ9RIBDaxtravBZf4NdfBRK3nxC?=
 =?iso-8859-1?Q?z2qvwKBgdlnqQ4D0Xe6endj5DdnTVrmnAl4qjvdMPKDZVhoVgFMKR6PeIB?=
 =?iso-8859-1?Q?4QJdZtMwqZDcUg5PyfCtbRWCDF1tKJsgDpnSGraFrc9JJxc7dHeiHpr5ZV?=
 =?iso-8859-1?Q?LzmQ4Of/bw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB6855.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c9bf6c-cd75-4da3-3a64-08def6a7fdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 06:24:10.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWYBxJh+9KCPLNYxclwbtiLFXi+diNOftUtemk2tIsHBU54XMkUPlbx2PnHaWWisCLsR1rSMFlRie1OFXfhI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8408

On Thu, 23 Jul 2026, Yu-Che Hsieh wrote:=0A=
=0A=
>> Some SoCs (e.g. AST2700) expose more than one physical LPC controller=0A=
>> instance. Downstream devices such as KCS channels need a stable,=0A=
>> globally-unique index derived from which LPC controller instance they=0A=
>> belong to, so document the "lpcN" alias convention on the LPC=0A=
>> controller node that lets DT authors assign a fixed index per=0A=
>> instance, mirroring the existing alias-based numbering convention used=
=0A=
>> by mmc/i2c/spi/serial.=0A=
>>=0A=
>> Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>=0A=
=0A=
> Why is this RFC?=A0 What's stopping me from applying this now?=0A=
=0A=
Thanks, there is no blocker. =0A=
=0A=
I marked it as RFC to gather feedback on the alias-based =0A=
numbering convention for LPC controllers before submitting =0A=
it as a regular patch.=0A=
=0A=
If the approach looks acceptable, I'm happy to resend it =0A=
without the RFC tag.=0A=
=0A=
>> ---=0A=
>>=A0 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml | 7 +++++++=0A=
>>=A0 1 file changed, 7 insertions(+)=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Doc=
umentation/devicetree/bindings/mfd/aspeed-lpc.yaml=0A=
>> index cbc3a2485a2f..81c12e0fb312 100644=0A=
>> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml=0A=
>> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml=0A=
>> @@ -35,6 +35,13 @@ description:=0A=
>>=A0=A0=A0 configuration, therefore the host portion of the controller is =
exposed as a=0A=
>>=A0=A0=A0 syscon as a means to arbitrate access.=0A=
>>=A0=0A=
>> +=A0 On SoCs that expose more than one LPC controller instance, it is po=
ssible to=0A=
>> +=A0 assign a fixed index to a given instance (and thus to downstream de=
vices=0A=
>> +=A0 such as KCS channels that must be uniquely identified system-wide) =
by=0A=
>> +=A0 defining an "lpcN" alias for it in the /aliases device tree node. I=
f no such=0A=
> +=A0 alias is present, the SoC is treated as having a single LPC controll=
er=0A=
>> +=A0 instance.=0A=
>> +=0A=
>>=A0 properties:=0A=
>>=A0=A0=A0 compatible:=0A=
>>=A0=A0=A0=A0=A0 items:=0A=
>>=0A=
>> --=0A=
>> 2.34.1=0A=
>>=0A=
--=0A=
=0A=
Yu-Che=0A=
=0A=

