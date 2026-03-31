Return-Path: <linux-aspeed+bounces-3815-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C39FF60CF
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 07:31:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flKYR4B0Xz2ybR;
	Tue, 31 Mar 2026 18:31:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774942283;
	cv=pass; b=mCUo1CtZ9KVO/yS0W7Xy5y7MPS8h8XRcT9V7QqE3uHp7g0Ja2FIkbwJduxwkpfKD2K6uzkZUlh3oUo+vvFOwBOVvF9fAMwNyYjukEqWQiH9h+f7QqJ+nBxAqlWspPnZCco0bU/fRQpLl2uwQbI8bEJkvBpE5waIa+7rIanhU1O/1rElHkjjOITAfviiJqrq2Jsd+yea4a/SercF4+M/n+bKt6Kl7n1VOLtnMHSMFsgwJZD9vVDxYRx3t9hM/2zqZ2JAqBRmhizcmbxUMkpc2JQRgBdS/VQwuAeHzU/y1jIPvC4PXHFPx0obFbTib92zEkOcsVwNTWSqXa8eAg65Qyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774942283; c=relaxed/relaxed;
	bh=U9TOtm68xrzDeJP3tx4L/t25RUCe4+j7/MRpJWUt7K8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lEOrLqO+TvtWS388aIDw2pVUnpICtBh9szMWPyaLWPjydTE5ZPUGZPOtqqeHlwyx1r+DhKQ08rh81GN0U0+5QrF7NpiVzusScTq8JvgWHVV4CNkvYHqf36qlJahtHZvyDJH1mfiZItIhthM0AWXilBswPXKTZoW0Y7QZDZYlaSqYCstWMi0rLL77zwX4Qa70h+Ftl0NbgDlErq3p56g211fZATyqUZMam2F/Jcv+tCF9euJHFCmHJJ4dHc60vE++uk0K5QXKhYJAUMIISPpGQynhCj+K5sAe+m4qVJZKUVYepHWwev+EJwW3w+K3c/xcbfox+MyQ7IE2ar1sRj31Lg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=VLRMQj+p; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=VLRMQj+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flKYQ2Krrz2xSb;
	Tue, 31 Mar 2026 18:31:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgqjdNqKKd7SfCdlzoA3dpe6My+Kp6YQXE5QTyHTKaxJAit/ZYz6HZ7DpLIhJQjxnk2Axrt9pdEYr6vWtaoa0ijJaCNHHFOdvFTXHmfT0thvVWaxU2ih1pg7oHfqGdGrT6g8ZC5uOro1RvKNmZh7pf2VMbhXsciSBpA43n7ryiv/+1dD3ZJ7MOlHTA4Iei7V/jTa72lM9ouWyE0V+RnB+VZA/+DU3wMI3JdwgQ547rWaJXUtd1MMzAJ2D7x1l/YqNNq43mgPqF4K0WlzxHqPLp27DJy2QY8mXoJHWf030cHNQ81JksrJBwJ/zLlYjGkOBrQFHRbBY9MFyzsmNyOpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9TOtm68xrzDeJP3tx4L/t25RUCe4+j7/MRpJWUt7K8=;
 b=HbQEsrZzECMAwThiAZj99gwbEVMjTIuwHLWI6OvuU3OoHYu6+SnRHsaT1HHtam3qQxugxtBmQl67e4wTED/80UZKwShHmHmFfn/Qb23mM0CHr4ZHyffMl0aUE6+4KRw80zPeZt6DQl3RoIfRkjes6z/3dCpXNnB81l7lSK3iSZQLetWUE0/SgjtXY5ZYWzGWoGFpyVBpv1JP8OnYouzuC9MvpK+OJZTbctmtOe6omaghcmJQXR4d+YCxdccIDq4mrdcS70qLhdVz6P0iyE/V9PBLtGqwe431K6Q/y0DXc9XOu07FMgRZpc+zaKB05A0GJ/7mg8BvDpt2kpCs41PFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9TOtm68xrzDeJP3tx4L/t25RUCe4+j7/MRpJWUt7K8=;
 b=VLRMQj+pBPjJyMEAlYmVJOzqoGl5fg5OMibV1wWqBeRW6XcULBXbu4D19dY8CzuHVSAHRvvLaVCOSL1SgrILw6iaqO7DbroclHe3jMyORxi7fxV0VyMTeF+8vnPsIRnt0qELnPtJIe4KH0Rwc5R2VmTFOWKO9chwZEdaodj9q1iS1kyex8CFgbK2q0oK4olPXc21d9MS1/rQGCn8FlN185MpDd8Wx71HBulopqgdlySgvDn9CXDy1Cv4kQ1PIydVRHPIXfIldD2ywMhtojlQGCK7zy0NoRAD8XE9v2TESJGSc6+zF6XQt0JfxpiAqmKZShZFOKL0iOhiEwCOfwelEw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SI2PR06MB5194.apcprd06.prod.outlook.com (2603:1096:4:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 07:30:58 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9745.019; Tue, 31 Mar 2026
 07:30:58 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Thread-Topic: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Thread-Index:
 AQHcwB5Ez31FCAF2H06H/moL1lfWeLXINCEAgAABqPCAAAIpgIAAAW0AgAADQQCAAAMycA==
Date: Tue, 31 Mar 2026 07:30:58 +0000
Message-ID:
 <TY2PPF5CB9A1BE64B7988CD85A7189164E1F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
	 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
	 <20260331-fanatic-certain-bustard-fb13bc@quoll>
	 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
In-Reply-To:
 <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SI2PR06MB5194:EE_
x-ms-office365-filtering-correlation-id: bddaa869-64d5-413f-2e7c-08de8ef773b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 YktCwBkxkku3lV610iYlq+bkoKhEQs4kB2scpwu+CfCOvkthzjX/NNuvwEt14yogLy/EgbIOqMoZHoJKGwSnjRTskOcBAsS+C0A5R1vbNMnaCMNHh6tAXi2bDSl3KKml59pPZJK0pWEXOsbrpnGFXzixr9sHJQdxgj69v+239fklFOKpOP8Jcn+u+65xFjrK/RIOR8e2kJYmvs8/VWZf2wJ6/67qsNsMRN81AyM12D68+9HiaF8TqJlJOTpHr1YjoL3EriyWgbrDn4WYk45MBCz5KQLrjFA7VZFPRtipqykGwnFj4w6rxxqiGSbd6vBMVAyrnoTVagxyy7QQRFHGr4bylcsriacyv/Si9WZH+RxIK+cV55HjWJDXOhuXqcx/iZe+s1nfNsByPldVNkQ3mcfkdJlzRjHuLVR3hVy7V6iuWkIJv05XGWTs2jnpnarIwiOPqdHKdI5ur518Des3/NfsYtdyGhvbfr/0Uc4gldJG0s0UTtRo+GDZVIIKi6vq+JV8koFx8kY4Hubff5VestkeDISRQICLjzf3g/LD7h/WSVUftJnieTiC6OQrZLKtZAoqtL6lgk9wKIYqqKwAwvxtl2mZCrauqXNlBPM9IyeNFnC8sTBNhP7PbavX1ez06Epb1QZPNcf5eH/j7/fmi7IRxT7dGgm4HrapS8VffFZ/7YMz0tgCK6V6ykevN7J9JVhEYSRtSHp6VjMn9RV/yHsFNATkXDAKlW9z7PEOv5sMkM0Guo+/lj+JbbxLq/Uj3LWZN2ePlZ7MBt+N1JtlLyrq10xtwnbi3bvp/6UMSSE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTJFakdEZjZVOHNmSkM0cVFjL3l1bjMxSi9iQjhLVDAyZk1BTU50RWJHd2hT?=
 =?utf-8?B?T0JpLzJWQlRQU0h0NjVMRmtQbEdKTkt4S2Zad0tRQ2pJbTljdjdybkd0UU9O?=
 =?utf-8?B?aVZHbSs2c05vZmNIdzFtSTZhNkQyLzcyMS9sYVROM2hMTXEwN3ljUnFuVmNk?=
 =?utf-8?B?R01sZkhZdHNwa24zVWtFbkpjSDkxMll4UEV4YnE4dHR5aExldFBiS0FQMW1i?=
 =?utf-8?B?Q2pHVnpjQ3FJRGZvS1pEYkhMY0I3Q3pKcDhoamV1b2cyUStHK3BRU3hvazdM?=
 =?utf-8?B?QytpTkxCcCtpOFA1aDArNkdHOVplYWRtR3FzTVBUL2lwejkyWlVFRENpMWh1?=
 =?utf-8?B?ZnhYTURkSVpiQklPbG9KNG5lVzBCa1psb1Qwc2xwbnhJejVRdE5ma2VuVXVU?=
 =?utf-8?B?VDNvOWlsRjQ2MXRlS1p3ZURPemxYYXRXVDRlMERQNVprejhBMGlGalRZeEV3?=
 =?utf-8?B?YS9NdkxlbzJ3Z1JrTVpaUTFhUTRFN3Y2cnBQNHQxT3VnOWZwMUxMVTZjMWZX?=
 =?utf-8?B?d1dmZ3N6OWFxTXhqRTd5V0NXcUpyZ0dia3Eyb3k1a1RIaUVJSlZJMkRlQzVz?=
 =?utf-8?B?MnRWNlBSK2c4eDhlLzIzYUVpL2xYSDdhaW8zQ1VQUGxWRXI0c20zUzliWGtB?=
 =?utf-8?B?ekp4bHk5SURzOWk3ZHdwTjIyREJsR0UzTGR0L3NGdlJBanZFNTNKN1o5MWlq?=
 =?utf-8?B?VHNnTzBWSDNrb0dydnQ5aDl1SjZZVHpXaEhjNlRUKythZnlmM0NkV0VpOE9z?=
 =?utf-8?B?TFg4ZzRxdUEybER3VEJTUEhGTk50V2ZacGZmU2VxTllFcENIbjJEZEVCQ1BZ?=
 =?utf-8?B?alhuaHpXYkpUemM5Vkw4cVB0cW1GZ0c2OGJzTC81ZDRlU3pwWHN2bW13TkxE?=
 =?utf-8?B?TkQzcmQyZUVGZXg5RzNidk9EeUt1Y0YrZ1JUaGVXbW1UMHJsVzlLN3hYamZO?=
 =?utf-8?B?dUZTeDdRZFJMcno3SXFWZi8wYzJNaTlXR3hZL2FiazBYekRCbXBpZjkyUnRo?=
 =?utf-8?B?V0RybDRmRm1zUUZYL3ZKWFR3YnB0anl3YlFqbDh4RWJnaGE0U09iMU15azFE?=
 =?utf-8?B?N3ZDMVdWcEdqa25wWHd4VGwwcjJ6UCs0Rm1jYTN5bjlFNTJORkNKWVRWTit5?=
 =?utf-8?B?RUQ1ZnU3REM3Qyt0ZjdoR1ZTc1hCdzBwbzN2WFN1dERWU1dNM3YzdzZYQ3M5?=
 =?utf-8?B?dXNIQzVkS3VHWFFTU3VST3ZRWjZrbzBTNGtwK3FIV3lWMWM3Yk92RzVPRHJh?=
 =?utf-8?B?RTVGMUVoSStJcUJiK0VaNlNZdS9sS3pvWWFLZmdoVW51cnJ5c3BncG56dmp3?=
 =?utf-8?B?YVBoSzF6NHNqQ3p3OG1WQU1RQmY5ZHhiY1hDN1h4amhoMUxyNHJzRE96b1dp?=
 =?utf-8?B?aUtLODA2M1hsMnBjUzJMRmtSVkl4dHR6K1pHSGdzK1FvUjBDVkNvdjBXbXg3?=
 =?utf-8?B?dC9rWTU4UTlOcm1sRkM0MEZuMkVIejIreWRvcmdneW1XQU8rbWpTSGpDUlhZ?=
 =?utf-8?B?TFFCak4xUnQ0UXhKTnRQbWEycTBTRTZMVFRNUm8vdms5RGJuTGd1cGFsR05V?=
 =?utf-8?B?cmJPNVBONDVpSWJjMHhZVXdIb3BYNm9KWDFhVVZIV3ByQlhuUEY0KzY0V05H?=
 =?utf-8?B?Nm1CTnVWOGxzeUJwVVA2eWgxeUdldHVLbFhlMzJHWm1KMjhybWpobHphOXVN?=
 =?utf-8?B?M0R5eCtlY0x0ellyNkM0blVzUDhxMGJJdGIxSHoxcyszVXFVUkF1cFZtYTVF?=
 =?utf-8?B?blg3amU5T2ZlVkhzbndHTTlGSkM5aFBZYXlMaUtiNk1oTXAzbUllOFJPeVhG?=
 =?utf-8?B?QlhDT0V2RjlVRktNelk0SW92emkwb3BxVjFIbE13Z2JOTWhqcTJvRG8xaVE3?=
 =?utf-8?B?TGQzVXBnWjk5QXhBZGh6UG91MUpYcUROcFBlWElHdFMzdVdJaGhCMmNtSGhk?=
 =?utf-8?B?SE5CRlR6NXhFejFWbVdHTjFGVkgxRHhsSVRDRllsZWtnL2R5NEoyR2FTWFEz?=
 =?utf-8?B?Q2ZhWnQ4Qk5UandGY051MWRlMXRDbWNJSXY4RUpRakFQcy94VWRDMkZ3dWZH?=
 =?utf-8?B?dEhBTk1paklacC9LUndvMnhxVmpnTkJJQURHMDE3bTl5blE0S25jSTlkdFlZ?=
 =?utf-8?B?MDRKOGJmUXdTM2FzUG4vT0h3YzdLWjRoWVZ2L05OcFhndm9PZi9rbzlVQmcv?=
 =?utf-8?B?Sm1xME54NUxhOEdBQTdIMmVObHpzT2poT0VQbWxMYkIzZ1Evajh3VzEzRkRo?=
 =?utf-8?B?cnhucFhLbllJaVlzS3hxZWF5a0FLVlZ5QW80cERVNU5TbkRFcVlWUnpKNWlq?=
 =?utf-8?B?RXIvdFVuOEdjWHZqd2ljYWhjQ3grUXFLaGFhd1Y5bXB0SWtqZjErdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bddaa869-64d5-413f-2e7c-08de8ef773b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:30:58.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciU5KLhKK+ddC8oZP/1uVQKvykXFTGk11qFIuwxjM8j8oH97irT5p3XV93JhlTkxKSElTHlnFon+M+4pSQCbV0Kz9aw/vdpEKcNCx3DW0oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5194

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyOCAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgZW5hYmxlLWRtYSBwcm9wZXJ0aWVzDQo+
IA0KPiBIaSBSeWFuLA0KPiANCj4gPiA+IFNvdW5kcyByZWFzb25hYmxlLCBidXQgYmVmb3JlIHlv
dSBkbyBzbywgaG93IGFyZSB5b3UgcGxhbm5pbmcgdG8NCj4gPiA+IG1hbmFnZSB0aGUgYWxsb2Nh
dGlvbiBvZiBETUEgY2hhbm5lbHMgYWNyb3NzIG11bHRpcGxlIGkyYyBwZXJpcGhlcmFscz8NCj4g
PiA+DQo+ID4gVGhlIEFTVDI2MDAgSTJDIGhhcmR3YXJlIGhhcyBvbmx5IG9uZSBjYW4gdXNlIERN
QSBhdCBhIHRpbWUuDQo+ID4gVG8gYXZvaWQgdGhlIGNvbXBsZXhpdHkgb2YgbWFuYWdpbmcgRE1B
IGNoYW5uZWwgY29udGVudGlvbiwgSSBwbGFuIHRvDQo+ID4gdXNlIGJ1ZmZlciBtb2RlIGJ5IGRl
ZmF1bHQgZm9yIGFsbCBjb250cm9sbGVycywgd2hpY2ggc3RpbGwgcHJvdmlkZXMNCj4gPiBiZXR0
ZXIgcGVyZm9ybWFuY2UgdGhhbiBieXRlIG1vZGUgd2l0aG91dCByZXF1aXJpbmcgRE1BIGNoYW5u
ZWwNCj4gYWxsb2NhdGlvbi4NCj4gDQo+IE9LLCBidXQgeW91ciB3b3JkaW5nIHRoZXJlICgiYnkg
ZGVmYXVsdCIpIGltcGxpZXMgdGhhdCBETUEgaXMgc3RpbGwgc2VsZWN0YWJsZQ0KPiBmb3Igb25l
IGNvbnRyb2xsZXIgcGVyaXBoZXJhbC4gSW4gd2hpY2ggY2FzZTogeW91IHN0aWxsIGhhdmUgdGhl
IHByb2JsZW0gb2YNCj4gbWFuYWdpbmcgRE1BIGNoYW5uZWwgY29udGVudGlvbiwgYnV0IG5vdyBp
dCdzIGF0IHJ1bnRpbWUgaW5zdGVhZC4NCj4gDQo+IFNvIG15IHF1ZXN0aW9uIHN0aWxsIHN0YW5k
czogaG93IGFyZSB5b3UgcGxhbm5pbmcgdG8gZW5mb3JjZSB0aGF0IERNQSBpcyBvbmx5DQo+IGVu
YWJsZWQgZm9yIG9uZSBjb250cm9sbGVyPw0KPiANCj4gT3IgYXJlIHlvdSBwbGFubmluZyB0byBk
aXNhYmxlIEkyQyBETUEgZW50aXJlbHkgb24gQVNUMjYwMD8NClllcywgVGhpcyBpcyBteSBpbnRl
bnQgdG8gZG8uDQpEaXNhYmxlIEkyQyBETUEgZW50aXJlbHkgb24gQVNUMjYwMC4NCklmIEkgcmVt
b3ZlIERNQSwgc2hvdWxkIGNhbiBJIGtlZXAgYnl0ZSBhbmQgYnVmZmVyIGZvciBzeXNmcz8gDQo=

