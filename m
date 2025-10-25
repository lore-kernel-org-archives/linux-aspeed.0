Return-Path: <linux-aspeed+bounces-2610-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D8ACCF9E0
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Oct 2025 03:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctl9V631Pz2yrq;
	Sat, 25 Oct 2025 14:09:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761361758;
	cv=pass; b=n6AfOYoLdrd1DvGBA3gojn/pc3b+yPRu5jWTpUuAG511xHSrYenMYUu7sJ98DHjwIGFiswuDGJwVXQLMlDKda7102DowRxa1W6SMUBZfCf0ce7NTGG2XuOjEcwg92AbwQxwPwypbe2BVilMVt48cMdusKI8cdXDZ/MJNPMu84e+VVN/7aWpaC0e2ILdUtXo3XYNwNLgr6tNfck3uWAr8BcR02vgH+WlZcgzQLgWJgWAh520QHzgSHVwB2kTmMnG748OwT2ai9ZunXkzGHXC3T7vNp5fJfWPzq+lDQKdmcN+WL1zCbsuLdrZF5ddKSLhYx1sQTWsFn0aCLoBzhn8MPg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761361758; c=relaxed/relaxed;
	bh=L2W3u79/R3c1ObNwFVF9wjpfn/ksRMzTeDN364PCpT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exxnyeCmOtidXoWCnxMML610uFOsjEHlnuQy44KEfIp8GCFFrNqno2kmIOqwyAm2ZrtqCX5Mah4zXjY8K+/Syg4tU/YtoO2vTMMfw4uG0Zfeo1mRm2QcktdPO3gYOF3eGB2q/7+TeEpx7VPCYxlAyX5CiG5AdqHer3P6FaanhTr3t/1/vF3Q8cemq2SerV/H/iw5g3FgFvAYzmH100L4K3gnPg0L9io0XxJgBreanOxwzHrUb/ab0BYfPpnt9WHkwICZ3KXCnnLcJLQLi4pcF6wlirrBAeWDCIUhUfy6jSKf9+dCiwa3teJSDoguLmoRxMELSXpqcEpMOoy0yH1Mmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NnS8RBY7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NnS8RBY7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctl9T6sjLz2yl2
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Oct 2025 14:09:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBsJ3phqG6eJRVCc5auJLI1NodUVoryv8XYTUfBDO65wItgmEyreyUdiZYeXl30oWSvgj4rPkZdppkyvxthN0l74rRW4dpzwW6e5DWtexWbU50BHHgdkJ5RNVVTq43d8rr7tFN6HQ10g/LB+C2XgfvlMOTZCl2MD7AGZ3pI/BGmpZmWKFmFQvAfaYKrHjsgHNUOEGrKmYMczTJQR9MNlevxeY9T4UFdAjPKf14tWWV2iTapm8ryCy/HS4Y5RKlDNEPKIJvL2/1snDUEklS313XLp6rjNQ/F29YooudHgHqm+sE+C0ueOsc6twQhqGEFq/A9fKZeNOVUh3nRzVZKN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2W3u79/R3c1ObNwFVF9wjpfn/ksRMzTeDN364PCpT8=;
 b=xUaWwerCBMMapPlSDOTYSI1ESt4gIA/Y7PQaLKKl7aKRkFtsb/kwS4+dvArU5NsrIFsAKJ9Oi9wEGqyMB6bSpInH40XvKgkqiP2rprUmx59hkjzXUNEE38+SanbEHlL2JtTbG9BqkD81WUKWwEWZ9QlbrTYnZvP76+WMhfIxIkv5pwAYis4HWVErDYmAn5do3suKaN7o1ms9mL25JyDgRLPdvE9ii2cAUXveln17+PZGLYPJbdmVDVJA6JXxg9R1VQoNli3PpOXUffuhnBzlkAaCDViyD5wHDnzCUBAc6RNIGunU8I2TUVQZTe4BixqCL1o+cPymA3tSR4MZcNtlYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2W3u79/R3c1ObNwFVF9wjpfn/ksRMzTeDN364PCpT8=;
 b=NnS8RBY7JutgUew9YD+HDqeubuBAWaTQYgyXvh0BSHrsfjKYbv3u+/aEHpKOYgusr/QFody1Mz+Vw58xKu2I3pzGyC1iEuseEd5l1qdRq4YQd61JkDq6JcFiTZDLocjaSZLFIAuX8U2d8TYhnl5v7DY+zWC1K66fppIzXQHW1bhJ7qLzymFzBKGB1FLBGibNmeupVql+pgyHjT5suS9yVDTBhMp457ErGyqqSMY/PxEVoOVKBz6Zx9cri+j9PJ37xIkcrTZHsS4iYB5Hp2G2K0Ihqj3p4dU5uMFdflz/ZGQDSrmnojArJ1Ox2Fw87GW/iEN3BJ5EnUY+U/EDVp4Fkw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYSPR06MB6410.apcprd06.prod.outlook.com (2603:1096:400:42b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 03:08:54 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 03:08:53 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring
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
Thread-Index:
 AQHcQyJQr8Cg3wF4TE29hMu8e6S4P7TOr5mAgACf3YCAANyZAIAAeR6AgACX8gCAAPRVAA==
Date: Sat, 25 Oct 2025 03:08:52 +0000
Message-ID:
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
In-Reply-To: <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYSPR06MB6410:EE_
x-ms-office365-filtering-correlation-id: a51c0c68-e540-496b-3c77-08de1373d3d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RIm+Dq0PB2uYGf3y2oEgKKu6L32xSp2P28IZlI09munehRU77Q7i+l46yl?=
 =?iso-8859-1?Q?iE5wtOFyQNNSDHP3BY0plcs8QW4uzXpw6hromT7mz3389sbUGIhaG/BiqM?=
 =?iso-8859-1?Q?KSMZxSp3MzblCdMGdthozLtIcIScdLT2GdMYZVNTm32BNXvSuAFxHecfUF?=
 =?iso-8859-1?Q?1d080hKeB4chbVmjryq6N9VP5UN24Ci+1d4Wt5gMfE4fxFhsWj4/5F7e9J?=
 =?iso-8859-1?Q?4WRM6I+zNdYMvxbv4Qgs4XluAGlziTf32rfitnnP68dDUo+wd2PEbs/8Jh?=
 =?iso-8859-1?Q?sTs2v9tG2/9Ia6HjsZ405o5TPXzp6e7+iVbXOkvey7xY7h6i12I1Ml7IEk?=
 =?iso-8859-1?Q?XN1ic8EBJl0R47PqyNAaZq+gJZ8cgygylRolC8OgX8Mb/jUJcza2wICS1K?=
 =?iso-8859-1?Q?DW2NSHlFBbpyYdtr7CcujvN6uhCjGyK4/YshsL0m1cXyFIkKzDhXp5Ysni?=
 =?iso-8859-1?Q?0D3xezCD1/lWMGi6Q9Jn5kAYNQB7MO7QLzSwvv26EVz+s9T+e83AVSc0FB?=
 =?iso-8859-1?Q?SCG/cNfYiSg23R3qcEVAxUZwG4YRy7TSB6PIxEiv0l3Gbli+bn5HgIu7zM?=
 =?iso-8859-1?Q?YNcMFWf9JxDQmFnP6rU+xRvILJSiVrk/IgWuGjplSAvRgLqJ2WrvrrHbXq?=
 =?iso-8859-1?Q?aRJi5htoBXJM3quugozQo2MGnjPIFJ1NlwnOBacWg5h1R8IdPBz5bBu5mo?=
 =?iso-8859-1?Q?qljrYorMS88P4tpqzrFHFBJAbk84bGuFrwLc1BgkaQaLiryefF9WbBrCIs?=
 =?iso-8859-1?Q?wswUfjj+gu4Rikff6/tlFc18MWL/zycSlzWOxVb2tay0DfasBG7JzMXl9t?=
 =?iso-8859-1?Q?6AYbEwy9Ouy8UFH9utsRhuqB6ss9P5X9jYzVhD9FnqATrgm0qLfJFgz9+3?=
 =?iso-8859-1?Q?G/+eNAONUqQLb//c7ElJfI2dZsA7/zG5FxpgerDycHjT35cB/TOhBay9vP?=
 =?iso-8859-1?Q?VJue6vWoYoPxg0CiNI1SI/xi45e1lR4ZQnIWD6p4OFA3MxMGZj193NNdbu?=
 =?iso-8859-1?Q?Xe4vpHg4aMT3Au/GWeAZH25Di5YrYZdIBAHU5JDMfWSXxDXalRO+gzeNzY?=
 =?iso-8859-1?Q?MAWLnBsQlESymLoIXMNtVBkKm+XF67wtDvcPRRR4lohiXwuWY1vvSsE9/o?=
 =?iso-8859-1?Q?ofIW2FwirKejtpOh5LbincNw0PVWaWeLeugQpGN+5qSyj1ndpGtXNRsYGZ?=
 =?iso-8859-1?Q?a5xZQ9Fln6tT0HtLXAOd1tjLktVyA3Z6kNgYlaRhjPQoPqWgBBk45+wjkh?=
 =?iso-8859-1?Q?8cVeBhyxBhOIMvo9PebDkfjlv/9coG1FXVoRhn9FnXUP1Hv/yqOh18qGHp?=
 =?iso-8859-1?Q?EmuE6Is0qcA2juWmb0ByV8Zd9fvVwd+P1BSxEWtrnrUlP/F1D82DrBd/sG?=
 =?iso-8859-1?Q?o83wno2jkU3NG1lz5hBrj8Qd/HH6QGp963f3cxT5FGjZq6ovUg/46TcE5y?=
 =?iso-8859-1?Q?1KYE9xl1ZoPdJX93v9FMX9JMvZUisxpUaSG2jRsjfnALcbIq22M60M5tCz?=
 =?iso-8859-1?Q?aP1EPwcptREKLVaJQiBjTRFGfiu/en1Gp1x/TO0be24UeUg9k/VQ++xumh?=
 =?iso-8859-1?Q?BginBMvxRFixj/4UvyLZdU6PM+gC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lccxyIeGDgTTadEkUdpVMgg1JbKzhI+TCJl74kseGnX7XV5v34aUif2ge3?=
 =?iso-8859-1?Q?StjwqqCU8bkDK3RcBSU0xatyi/BWVdapjOnt3ww448+lH90VEesHKYDJHe?=
 =?iso-8859-1?Q?cX/ERqPPWcXFW7ATDW+lrAXq0SSyx2mQoL6m8IlDC6mOoSRgZtngPWHbdG?=
 =?iso-8859-1?Q?vUqjxHLTQAK82hXSIECvqwDW+SwcqOvmvuNvp+zIRBtSiJlOMSvZ26f9P8?=
 =?iso-8859-1?Q?2DrFgQf7toPovkqG1ofQ0e7grsJkOgFKDbxA8e41InBpgTF2RiAEpjDBZw?=
 =?iso-8859-1?Q?Z8S9AFcB7QQEEFuqCMw//6TZGZRx40fk4KHVuuJ/1LdkpS4PfBMzalNYaG?=
 =?iso-8859-1?Q?Iqz+XX6wGSz6SM2jS5MaaGzHqa3q7s76nI+bW0xpxnT6K0gvR4kCZm6XFf?=
 =?iso-8859-1?Q?6eJ8yJmFlqDB9L5bNzq+y8ITxnjfDNqHyK3vlEGFk+t6qvg8fCAREWNHr/?=
 =?iso-8859-1?Q?cgzMeZJzn3Xkcrdprw7ccTI8AytQ2WocBgSvwEPNhiufIeTWvU2A48VkBv?=
 =?iso-8859-1?Q?fS+gZyRGWGxpALgUEzAVw/tah6oxogO2JbrIRnNu/M1SkC07JB2/u5POUL?=
 =?iso-8859-1?Q?TMGw5Rii00eZr4YBlgLQ5dKoqBZ2xi66eQHFq06Ob+OozLwQbXsJnYKbn5?=
 =?iso-8859-1?Q?xPHuLteR6nJjyONNjyZ7UnP+14NQpcVCgIX2PkA4xosymAKSiQGpSIGbbu?=
 =?iso-8859-1?Q?27Lv443uRo1iaeA9ALHuCrhvF+lAALwWW4qqDbTE485Nxd7W61Aafstnzf?=
 =?iso-8859-1?Q?BeY3MJ6A1w7rs1JayyUu6FZ4FdOtEDzhykX9K4BFxYt67dreS7LnUHNBhx?=
 =?iso-8859-1?Q?gBzUa528+1vfe4I/6P2+7xOLPQQfFm1SlccQcsZ2mEPBe6nXcRIzWlU4zo?=
 =?iso-8859-1?Q?/myMBiOvsVzHkSLY0TSK9xO5ckdfAIkxLom3trdX12SrpwazmeqX9nNzgW?=
 =?iso-8859-1?Q?BKm+tPrw2vclLW++/QK8afB0hmbTXBbP2/X7QY4e/ym3z6O3uJDeneAFpN?=
 =?iso-8859-1?Q?6E1n7PcZm7zMLvP2cO3Myp0KiSiPIjTN1qXBMyHb5O/ojkFhoueoSrliDk?=
 =?iso-8859-1?Q?wtHW9/MsGYmQSZ0inzAzxyKYdLt/MxN8/fCQ8HtVZfflXA07OVjgj/3Fti?=
 =?iso-8859-1?Q?eIisFPU2ajL2w2qlwj5qH9ydYTcNLsL1COEqgE19I6PI05tkUgS8a+vAz3?=
 =?iso-8859-1?Q?o1R7P+78RBSwQbTQrccSZMa+SEuOSx2LYY0W0CzmoAlBac1ZqA97hsjygh?=
 =?iso-8859-1?Q?Vh+94IE19K0qpPT1TlPtf0DpL6SkAj53IgL17mlVd8SOKKD8pfXybm888y?=
 =?iso-8859-1?Q?lZs/2WxLaEQpSYat22K9nbCMnTAF6Eth3+7zjwdcdnzkR4uQQZNHJ3MNTp?=
 =?iso-8859-1?Q?fI6yXiI2QH9VX7m6dgmfSZUKdZ7hsO6AsLa9H8QuhPeEkPOFogreP+YfGb?=
 =?iso-8859-1?Q?J0mXIelhJ+2HzUz+XlqjvFtwFyT1E8mmyNrzKv7FVCD1TKzzW0o2BEzk4+?=
 =?iso-8859-1?Q?qPb8X+ePhb14nI8z7iMKcUYDFtkq5d5U4UryXsDIYgu/ppdNnUmmPL172L?=
 =?iso-8859-1?Q?EhyMZleAPhvbaNmTsG9V7F7kWzEOPLG3fAD4JG5P5KZPs24CBFbHoCruAI?=
 =?iso-8859-1?Q?RtpAXHfHyVqk/2ewksTswAaied9k1BT8ti?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a51c0c68-e540-496b-3c77-08de1373d3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 03:08:52.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBQ451mmLAXf95T/lv0U70IXBu29XKnDCFyY6mmSbCaP92MHgio8IsvaFBbJnWikDh+eqZQOY8SggFFZn0DMKTlz/L6wUFIxg/bou/WnE4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6410

> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC d=
evice
> tree
>=20
> > > >> This probably needs some explanation: why are there two 'soc@...'
> > > >> devices? Is this literally two chips in the system, or are you
> > > >> describing two buses inside of the same SoC?
> > > >
> > > > The AST2700 is two soc connection with a property bus.
> > > > Sharing some decode registers. Each have it own ahb bus.
> > >
> > > I don't understand your explanation,
> >
> > Let me clarify more clearly:
> > The AST2700 is a dual-SoC architecture, consisting of two
> > interconnected SoCs, referred to as SoC0 and SoC1. Each SoC has its own
> clock/reset domains.
> > They are connected through an internal "property bus", which is
> > Aspeed's internal interconnect providing shared address decoding and
> > communication between the two SoCs.
>=20
> By SoC are you just referring to peripherals? Or are there two sets of CP=
Us as
> well?
>=20
> If it is just peripherals, this has been done before by Marvell.
>=20
> See armada-cp11x.dtsi. Marvell calls it a CP, they are identical, so ther=
e is one
> description of it, which then gets included twice.
>=20
Hi Andrew,

Thanks for asking - yes, the AST2700 is indeed a dual-SoC device, not just =
a split peripheral domain.

SoC0, referred to as the CPU die, contains a dual-core Cortex-A35 cluster a=
nd two Cortex-M4 cores, along with its own clock/reset domains and high-spe=
ed peripheral set.
SoC1, referred to as the I/O die, contains the Boot MCU and its own clock/r=
eset domains and low-speed peripheral set, and is responsible for system bo=
ot and control functions.

The two SoCs are interconnected through Aspeed's internal "property bus", w=
hich provides shared address decoding and inter-SoC communication between t=
he CPU and I/O dies.

This makes the AST2700 closer to a dual-die / dual-SoC configuration, rathe=
r than the Marvell CP model you mentioned, which only duplicates peripheral=
 blocks under a single CPU domain.

I'll add this clarification in the commit message and DTS comments in the n=
ext revision to make the relationship between the two SoCs explicit.

Best regards,
Ryan


