Return-Path: <linux-aspeed+bounces-2578-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEED8CCD1BC
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 07:38:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csdDm2Y7Nz3bW7;
	Thu, 23 Oct 2025 18:38:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761205096;
	cv=pass; b=mIkPJfCPX+w+ba81Uwu3vRcqT9Uk4agYwUwOztsSnl+6w3emMXREHJ1mUar9KH2aNEaFh1wmcnIQyPL0E7Ljxr3Uj5CbE71GWgTaXQ1jOxmGMqsYgaJrV86gmLYwkCeS/c0/KODdw/4HCPRVSjeQKboPvbu1+XtA1McNj5xCklNXSs8lBjB4m3Ogp2+dxHQm1ZVgLom7f36z6XEjmSp4GxVMGWcBrG8IrsE2wpPFMPtcJWzALZlM/hAHMLsqYMPHRPCh+sZ7hvz0CRUtivhrkE0AxX7bZO+9tevjMQPNZFqR7UI87DaQKdsaLsjhCfuUmTMbfzLizPtb/kXWw1il0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761205096; c=relaxed/relaxed;
	bh=shHMu/MgM0utG2qZhEw7phzdnWjhrpb+TstWL68F1Ig=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWa2u8716IEWE/Cw9Zt54NkRuxTy2d2IUBznMcZnwRdK+xb9VrRIeUk7sWif+EW3t6tS48aBdH9L6ktwEYRFg2dQG36wxsrU32DpasAdbI9x00/lkyk1JC0TuRfASVpeOA/1mmk2tdFe3SfJErcjZIRAhN13PFYArQea3DfkL1K6w2+kuQerNDiuRyRmHEu9HKlSrls8iFDwJ9Fhkz0TrlOuNiTPfNOkoulwBD2hIqEOtf89Rbn0H5EeL4KwQaPibwFUJ15xIbv5yq4hbJXsEalxw4RaspyDbKa37pGK6sQCq+JqecmK4BrVNyMC5W0GvPEThd4EvMttrxoAweKocA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=cDajCn0s; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=cDajCn0s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csdDl0np9z304l
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 18:38:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOMnoJLCmPAAaGGJ2iXAKzrU5NfLPeQ5SyvF8m/fiDnLSPX0AjxuTB4gValHWRFot10jlnNckb1CUXRzifKB0P5dKFii2w5ODVviBpberoYTxm5jG43rHFbb0AcQLYYB8EGC33+V51UiZZp5Ke6CsrVMMReU6IHW61R9khnhLIEeJQqun0lRxkAgsnYG3LzaH2m9x0i27ePX4O2XbhIZW4SEx59jmyNcejuGIiFLvjaO9pQY6B0kqSyou44rxrnAP8N7bdK/AhpSjLghfUIe60edrRJynNg1N4v4YboyzcVdl2MvXWeqt72GnhAd55IHqNOaOeoDtF+Bf2QTFPNxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shHMu/MgM0utG2qZhEw7phzdnWjhrpb+TstWL68F1Ig=;
 b=WwJUfEepn8GY2HkNzmxEkiLaneuGkFkp2Gh1K/TP4h4T6lBMHCI9OXf1WQwk48qpFH1IEjZhYFVEnMMWNDDcrx0AfhPzsg0GV+o4iYkAymhMbr7iiBFa7xh4XAEzzdIPToexhzbmdbCNsAxUwHmgI0UeHOfzJaA2nsq/Am45fAClYiWE63r0XLwwPiK2/m5RXgNexa1fLIgrulqkcVbPXa5a2hCVJZ7B5o2Iiq65FoEjA0R4TZbzIoD5WKnmEMusDUbrBWXRUt6NfVTTiNef+uKYAa/ia6GbLg/dB4WFSB6TcLAlfbwv1aRJ8WsVtvtXrON+IeZqgON28+xK8XpqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shHMu/MgM0utG2qZhEw7phzdnWjhrpb+TstWL68F1Ig=;
 b=cDajCn0sYmJsJ/XiPb5WVcFyt3iP6anCJ63f05lXP5LZlFdhdp6xlFfMNgb2ek6H2IafiXvi60ir0B3XYRkZZHAu0UWIok3lXIAYLKVJLY0h9jlD3iQ+r4mnJ7wlcugL7jyejyDg/1VnWMgEh1XOS0kPegZJJsoc/EtzHRfuagMBQ/Pt3Buch9A0alyNDY+ofq/pdV6/Qf+OMht73zva5TYu78SzxdrtIo4hoUqbH8lf/YUpMY6A4Qvz6HDGzsNfQ913WSnGuIqGAOg6Baqs0EHvy9V7eWua/ILJCGSGQAsSm/MV5dl2lTl7dC3lDDefD14tTOA3X1yVsm9LnTUr0g==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by JH0PR06MB7268.apcprd06.prod.outlook.com (2603:1096:990:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:37:50 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:37:50 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, Lee
 Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>, "Lad, Prabhakar"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
 tree
Thread-Topic: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Thread-Index: AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YA=
Date: Thu, 23 Oct 2025 07:37:49 +0000
Message-ID:
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
In-Reply-To: <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|JH0PR06MB7268:EE_
x-ms-office365-filtering-correlation-id: d3e4b107-0953-41ec-d764-08de1207117e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?caFkaTye/de1MpTx/ROe/m8dF4EVWaU9CgRHKrPrKDhVyEq59YdL5Um0XK?=
 =?iso-8859-1?Q?8sAxjSkcPme0uSDQN0RSfHuAX38p3btJSivXrifQLCDNdZsfELaP3vL4Wy?=
 =?iso-8859-1?Q?8Gb2y7PFcRbqvgmvAzSHm/pg5BKMBLTc62zfdfPSgG6T/AnpiWFxBWWtGa?=
 =?iso-8859-1?Q?APLzVeXIV5CoPgLw7S4/Jqsbw8+pqFsesB/pYnIsiPebt8Z0XtLQL8iI+W?=
 =?iso-8859-1?Q?g5nxUprSjIUkg9FswKVBrzho+rROArrxMHtcKwEbGLFcwYQzqixQB1WvNF?=
 =?iso-8859-1?Q?nfCizmX5cwoz+oD/r/V/1M+VdRoQj3upMBZ4iUqXAPG6s8B21CNI/gRfCr?=
 =?iso-8859-1?Q?BkCVJmd0yHfOjnKX6ETGU5BgSEb+onMdCrQhTA0RskaDPrD/+K8Bhq8KnN?=
 =?iso-8859-1?Q?SI3l8dFP9oUelSougVPd/DxoelYqA6pcvZgGOI0xLUzq2MtbletsM4TJut?=
 =?iso-8859-1?Q?uo+iNWEQBhHUgetpBX8OOM8IIKz7i1bT5onbW4qfmu6tgzivJvHRhFmKiv?=
 =?iso-8859-1?Q?MsOLrWM5R8fIex3AEz7EDxUVKu5t/jxHXgNSqGi/yu9kYxkSar66wPVZ6P?=
 =?iso-8859-1?Q?LjlzyQv76+yeXp5kysfnE9OpRskffGMUwYh9pUjXTPIIOYlhQb54rJPn0d?=
 =?iso-8859-1?Q?QFM/hiznrs5oG7DKfnI9caBLY9rI+j7uQNjXQSGzWB4XUHFDwuTsFYrfeZ?=
 =?iso-8859-1?Q?pTpM6Boj+zA3cDRH6F+lsciTsXyn+QmyJoMcn+zjk3LP61dsDdE7+PMzHe?=
 =?iso-8859-1?Q?uaxTHreNRq8+Mvz/yXZX+Zyhvh8uaqJXvC2+N6AHTIrFAvpNSAUx49odfe?=
 =?iso-8859-1?Q?Eb+qyz+Yr6KjS+PvvI5WhS4UDv/KW4U0J6aCREhExD8RqNIcDFSO/AGrPi?=
 =?iso-8859-1?Q?bBhsga24Ql0bWaDHtjigBp8revwMr42kGZ7KYe5AzQ3qeJ/Wy0IvmiIlyr?=
 =?iso-8859-1?Q?nJkzqIhJO2YhKEipvDc+KMFeLz3HRo4OKZXcStrPczPXjP9PSq1bXw/Pem?=
 =?iso-8859-1?Q?HpF72TXxIOueWSDurhXUxfEgxh0SbmVOIREuvzzyJRddixiY7uzgQ50R8z?=
 =?iso-8859-1?Q?9IJT81ZZpvW93DYWxDz8T+rybYVh1cJhRgv/dkxxQp1ZFuBgL9SJ5Tfu6G?=
 =?iso-8859-1?Q?axStbn8KQJZMpnsVQHVi/rSsOE3UqKgszmWLsUzPdNdHTmuBBtJ0aXeEK1?=
 =?iso-8859-1?Q?JPHrqoqTCH6QvDq47p2gmrW5t+NUIwlqJUseAMxGwXucGepeB34LSkrFXY?=
 =?iso-8859-1?Q?5rd/VbT4ED969JIhmo4KDFmRXPm4ztWKkT76NtUes3ztDZ1df0s0Gbkw9b?=
 =?iso-8859-1?Q?cfHbVSNylGnfei1AqmnvaPLFzd7xT7k4mymD7KtV3gTAUbIInIX/noM/bb?=
 =?iso-8859-1?Q?K8RlXQ0PHDm3zH50mClpFJvFRW/Plzrh7D0aLBDfzHocoMxDOsoPYeGRtz?=
 =?iso-8859-1?Q?mpWAB5PPG6I2KlnmCcfkT1jDNe6L9HmJq4hN9AFnh7Ho3OM/8f8PMSN5zr?=
 =?iso-8859-1?Q?cbmVqr7vI9gCVE4nNdaUrqeF4Vmj5RXj0FBqxIu8eJLg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5xa5I/Tnhw7aamn5JCofXASjW9J3iqvErwuPZM57agwzQK+ZH5uZ5ZgT5Q?=
 =?iso-8859-1?Q?xAW9nNJpqvu8UddiAFhSFo1X5beM/VMn6OQqyLKqoLYiHjAy9CycIl33le?=
 =?iso-8859-1?Q?X16xWfdk9uf2/yThXZ/ahTexvuqgOcYAkgFalZhm5ygjXNNxhQCHZ2dSo+?=
 =?iso-8859-1?Q?OrTcI++zjOR2/EB05JeQtm+hO9zVuxrurJppvZi7l9l0eUJ3XjbRFztgcO?=
 =?iso-8859-1?Q?+FiCuB8ODMQLAsMQlJ7PPq9uTvDtoIPHzdeVYMYszIFfZrMe6HbLF5o0gi?=
 =?iso-8859-1?Q?+4G3PEmbD0hjcU1Hr0S9XcCTlN3DUJVs9AF3mc0EL3y4iv0M6E2OacSa8P?=
 =?iso-8859-1?Q?+korxWy9yCVKR+ozxf6VxV/BLI047UF/mReZ2NDVO3jgU/Gu/LunQW2Vsx?=
 =?iso-8859-1?Q?p20N0WRFkIyP57ZHTlRi//trlr6qwOQo40XAXbP48/KKBaTYEVpEGSeNHq?=
 =?iso-8859-1?Q?jEfEcWfANZAmgIVHFgZa9jf4Z9ect7sE0fmunc2JG2szxLFSyf1ldPSXz+?=
 =?iso-8859-1?Q?/CbhTyuK+quZyTie9DMAXMgOf+Kql3dq2eo6U744ssfnIxSK9FSFz53y49?=
 =?iso-8859-1?Q?kbasFQ3v+7AyEEmQMwJTm48S1WJYjTjgsyLNUd838H2YQ0TtiYZqhm9TsP?=
 =?iso-8859-1?Q?QVGqdellb7ZviQ9vW1J6tpOAcV4ZeSMbQjm81Uzhkd2zkNmRXhZtGpa1K7?=
 =?iso-8859-1?Q?bKepw2Hf/mAAwa5hPyOtyRlt3rieHsHFIIcUvmMOTc7XIwmVfNwIQqczdi?=
 =?iso-8859-1?Q?5j4GG25SDRqsJ4k3A56nKchmsZDsDQOps0HtcAbcxcI1ky+FVOkIFWYbI7?=
 =?iso-8859-1?Q?G3bJCz5ovCYJWChESOz4GZhWYptVJiv/rXvMzd9qFfcTFk8kllaWh5IeKX?=
 =?iso-8859-1?Q?DSgq/gKGyGgZIjCrHPesdn8RJWOgucxO79TqxXaHlq0TS1Q8miz///046m?=
 =?iso-8859-1?Q?V2nNhcWNxQ17ELDJkUcgdr+QrkFw3OSPVGZ5qqsDROZHbZOzU4GP83A/Wm?=
 =?iso-8859-1?Q?n6+m6QD9KyXHwcwLdnwG9awXKLgm4kyQYFyg37tNMIMbHwcn/mAxSvvyzZ?=
 =?iso-8859-1?Q?zDjib/Xs9mIWkyQVZulj8jtsnspo96FjMdvELldAUsy5rBCJ8j8bt8wtV0?=
 =?iso-8859-1?Q?dtNm0AG0S7tOvpAtLcxcXgW1kOAxkpoXAbZjdxWFWPYHDG9JyrYU/T0mlW?=
 =?iso-8859-1?Q?8XI3h5PPDfS23tL5jH89mEJ79cM0GkWC0vHGA6ZUVA6tmPn/PlGLYARoYO?=
 =?iso-8859-1?Q?y0KfmX2oUS8vqrorOpSezh4EO8fNk8CK9EUc5ok4hkv8d9xiNaWJwm4Fwr?=
 =?iso-8859-1?Q?1KEdt8bdyESt/BKBXYak0B5tERrBR6QtcRZ8uiZ1R5/tXSyR2EN4KZUgiM?=
 =?iso-8859-1?Q?YhroNeGdkdzpllqvHJtCfQczc5Qsgh4ksmbtr/8KjT0svMi7YY374J4YUC?=
 =?iso-8859-1?Q?MYbqbxLq9a9FoSMtA1FdeTbFgUH0QcJddVC1fzwBXLqsLSKykUDBtSzO4U?=
 =?iso-8859-1?Q?6W4SxtSuO2U97RqrwL9v7ElTefflPmVt9vtW9Lv9kqzTTKQWTSOWjkt0J5?=
 =?iso-8859-1?Q?rBXczRAwdfmPX8ZlMZ8jzBIGWoSZS65bRjwsja58PsfkX2H+oLRMtpEm/g?=
 =?iso-8859-1?Q?esmxpwWJ8GERkAt+JDq621zr7JiukvT/tP?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e4b107-0953-41ec-d764-08de1207117e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 07:37:50.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jD2TEKuUTpLTozvId/DapAJ+pWREFmv+yyKNP3B0qqDiQ9hT8jqicrgu3nA6GA91UKktxsrprUPMGzRXp5UQYUNS4477/MXYyXl1xnEN98Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7268

Hi Arnd,

Thanks for the detailed review and explanations.

> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC d=
evice
> tree
>=20
> On Wed, Oct 22, 2025, at 09:05, Ryan Chen wrote:
> > Add initial device tree for the ASPEED 8th BMC SoC family.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>=20
> I think this is the place where you'd want to put some information about =
the
> chip itself. I know what it is, but others may not know anything about it=
.
>=20


I've included basic information about the AST27xx family in the cover lette=
r:
AST27XX SOC Family
 - https://www.aspeedtech.com/server_ast2700/
 - https://www.aspeedtech.com/server_ast2720/
 - https://www.aspeedtech.com/server_ast2750/

I will add here in next submit.


> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +		serial2 =3D &uart2;
> > +		serial3 =3D &uart3;
> > +		serial4 =3D &uart4;
> > +		serial5 =3D &uart5;
> > +		serial6 =3D &uart6;
> > +		serial7 =3D &uart7;
> > +		serial8 =3D &uart8;
> > +		serial9 =3D &uart9;
> > +		serial10 =3D &uart10;
> > +		serial11 =3D &uart11;
> > +		serial12 =3D &uart12;
> > +		serial13 =3D &uart13;
> > +		serial14 =3D &uart14;
> > +	};
>=20
> This looks like you just list all the uarts that are present on the chip,=
 which is
> not how the aliases are meant to be used. Move this block into the board
> specific file and only list the ones that are actually enabled on that pa=
rticular
> board.
>=20
> In particular, the alias names are meant to be local to the board and don=
't
> usually correspond to the numbering inside of the chip. In the defconfig,=
 we
> currently set CONFIG_SERIAL_8250_NR_UARTS=3D8, which is enough for any
> board we support so far, but that means only the first
> 8 aliases in the list will actually work.

Understood. I'll move the aliases block from the SoC dtsi into the
EVB board dts. For the EVB, UART12 is used as the default console,
and the board labels match the SoC numbering, so I plan to keep:

Does that look acceptable?
ast2700-evb.dts
	aliases {
		serial0 =3D &uart0;
		serial1 =3D &uart1;
		serial2 =3D &uart2;
		serial3 =3D &uart3;
		serial4 =3D &uart4;
		serial5 =3D &uart5;
		serial6 =3D &uart6;
		serial7 =3D &uart7;
		serial8 =3D &uart8;
		serial9 =3D &uart9;
		serial10 =3D &uart10;
		serial11 =3D &uart11;
		serial12 =3D &uart12;
		serial13 =3D &uart13;
		serial14 =3D &uart14;
}

>=20
> > +	soc0: soc@10000000 {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges =3D <0x0 0x0 0x0 0x10000000 0x0 0x4000000>;
> > +
> > +		intc0: interrupt-controller@12100000 {
> > +			compatible =3D "aspeed,ast2700-intc0";
> > +			reg =3D <0 0x12100000 0 0x4000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges =3D <0x0 0x0 0x12100000 0x4000>;
>=20
> This doesn't seem to add up: you define a local register space for the so=
c from
> 0x0 to 0x4000000, but the registers of the child devices are above 0x4000=
000.
>=20
> I suspect that you forgot to adjust all the addresses in the child device=
s to be
> inside of that range.

Yes, that's a mistake. I'll fix the ranges property in=20
soc0 to properly cover all child registers.

>=20
> > +	soc1: soc@14000000 {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges =3D <0x0 0x0 0x0 0x14000000 0x0 0x10000000>;
>=20
> This probably needs some explanation: why are there two 'soc@...'
> devices? Is this literally two chips in the system, or are you describing=
 two
> buses inside of the same SoC?

The AST2700 is two soc connection with a property bus.
Sharing some decode registers. Each have it own ahb bus.

>=20
> > +
> > +		mdio0: mdio@14040000 {
> > +			compatible =3D "aspeed,ast2600-mdio";
> > +			reg =3D <0 0x14040000 0 0x8>;
> > +			resets =3D <&syscon1 SCU1_RESET_MII>;
> > +			status =3D "disabled";
> > +		};
>=20
> I see that you use the old compatible=3D"aspeed,ast2600-mdio" string excl=
usively
> here. While this works, I would suggest you list both a more specific
> "aspeed,ast2700-mdio" string to refer to the version in this chip as well=
 as the
> fallback "aspeed,ast2600-mdio" string as the generic identifier.
>=20
> The binding obviously has to describe both in that case, but the driver d=
oes not
> need to be modified as long as both behave the same way.

Thanks, will submit ast2700-mdio.=20
Question, should I add in here patch series?
Or go for another patch thread?

>=20
> > +
> > +		syscon1: syscon@14c02000 {
> > +			compatible =3D "aspeed,ast2700-scu1", "syscon", "simple-mfd";
> > +			reg =3D <0x0 0x14c02000 0x0 0x1000>;
> > +			ranges =3D <0x0 0x0 0x14c02000 0x1000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			#clock-cells =3D <1>;
> > +			#reset-cells =3D <1>;
> > +
> > +			scu_ic2: interrupt-controller@100 {
> > +				compatible =3D "aspeed,ast2700-scu-ic2";
> > +				reg =3D <0x100 0x8>;
> > +				#interrupt-cells =3D <1>;
> > +				interrupts-extended =3D <&intc1_5 0>;
> > +				interrupt-controller;
> > +			};
> > +
> > +			scu_ic3: interrupt-controller@108 {
> > +				compatible =3D "aspeed,ast2700-scu-ic3";
> > +				reg =3D <0x108 0x8>;
> > +				#interrupt-cells =3D <1>;
> > +				interrupts-extended =3D <&intc1_5 26>;
> > +				interrupt-controller;
> > +			};
>=20
> This looks a bit silly to be honest: you have two separate devices that e=
ach have
> a single register and a different compatible string?

Yes, it have difference register define in each scu-ic#. That is compatible=
 with design.
https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-aspeed-sc=
u-ic.c#L45-L48

>=20
> Also you claim to be compatible with "syscon" but nothing actually refers=
 to the
> syscon node in that form?

There is another submit ongoing in pinctrl which will use syscon.=20
https://lwn.net/ml/all/20250829073030.2749482-2-billy_tsai@aspeedtech.com/

Could I keep it? or I should remove it?

>=20
>        Arnd

