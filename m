Return-Path: <linux-aspeed+bounces-4014-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667DACD4F26
	for <linux-aspeed@archiver.kernel.org>; Tue, 12 May 2026 07:08:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF73v6bJvz2yZ8;
	Tue, 12 May 2026 17:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778569723;
	cv=pass; b=fcOoGi5Tf/sCiXkIVPAVHE+EOZJDkDE88ewrlNjcTv0wH5FETppWdNrNcYYQR8Z1gdkplEWroO4ja1ooPodFCNCbycldpN6XA86a1jV2sH/r++MWdCjMxxSc3QFtq3sLT/tnYLj9bawUU0FkaeJSnJ9HFCF6Y4w+ymy4BcfrpuojE25eZewGQo5Dz1FYk6IAWDkw5z2dWGpVIXcr78x1DlGaqY4FCSR4bCw0YoNw8ztB60a3A6JG0N89boieVO0p9bbTsrv9gBhRxxX19G+qBHep8rfPm16Ni68f5/BcvS2NBh7r24HKhDYo+tLhJOiJesJF78WM8iTl77r/nhImKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778569723; c=relaxed/relaxed;
	bh=pUNIeNgYRBpYYbi72d9Ee+j1Vx/lit3IDEJeeoqyhKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4CRY4AAuPTS5jH8QxyuBjAekDUMF3NzvoHR0uaJlpLa1uv3D7Z9aZ6BFpnXothr2l66Gh3p3Yxg4rPIHOYoO0sKjWviQMUQk98BxWJVlBs3fuEqMRDgcAq8JvrXcfbtZ4/2WPN4BZ1LKVvFEdT+Ks9X+r2M1vPqQlqJKeQmNeUnPCj0n2ksjBJebrSI/NdtZINZRyKtLzFfbTyP55jJMDnRqh3kp/49cU9r+eKpVtMRtU+Mtzt6XaXCnDeVcxQa3qcBoEBraVGMTEomymvbz7RkvqJcagfu2ooJpHVLDwGqdZ+T1/glmVAvkF+gX6OXFIzWF5lLiENZIhFcu+6gBQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=APL4JGqw; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=APL4JGqw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF73r6rMJz2yMl;
	Tue, 12 May 2026 17:08:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPuJGc7bVAECtNe1e9GWX90HJGA/14iLAmwMund6+APWhYoPJEWKrPTAOWQlzKzjKQsT7Ix0c/g7uOxm12fw+ULcDHRkY0aOT0M8Pz+uzmQZSJUr9B1AEapur5VMtK9E9Uhj/V6y52Ki/iUQiKRFWmEyc0rmip/4Hw8++1nYiPy3VtEyw7jN4NYF5MudDFM+c4SLgs2TbpnoiVV25UWS3xXQhf0Y6iH9oZoTLFofk9zXOtXP24RRE1HhTG/DrouC8aDEtJi/jIrM4uPR4i6KJX52IrdH6b//hAHnIhAMoGwMCk+ubQNjJLEUx7XUmBC337xr1sWaJk/z2OLsLzNU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUNIeNgYRBpYYbi72d9Ee+j1Vx/lit3IDEJeeoqyhKE=;
 b=lHegi/ULekHxTyYkYTk+xkCUuLkNgCPaYt7Biyqky/mmPRy9kcZ9dWrrlQgaikGsDosmxuWYvsl+PO0xT6Y+/NEnkyhV8pFH66CmFiWb2Jjc8iVCWTEJPBtPUnjyI0lGh9yrqGwkMdNxBd8/zmB6wGUg7C+IOuy6fcTzT8qLhoq+nQnI8YAVkETN5c3op64YftzAcZU1Vmysg2kyYdMEj3lq8VQdpSLMLrQ0XkHZaIvoQH8nU7Anyd4aUm5NnaVI7c8MvJQp246ka0k1fZEErZ1x0PnRXfqXQCPb7L+bsw9jQGlKRlXf0+a8uQlYehUyKH993+WgkxqipAZ32r40rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUNIeNgYRBpYYbi72d9Ee+j1Vx/lit3IDEJeeoqyhKE=;
 b=APL4JGqwLg0Dmi5sx3bJfHRovO/qJgCZwsUDBoyloh8F2lTjRY8GXwEisqVyBZPi01P8wLbSY/xtj+G11ch9968aZE1Z1GsXIkbO3KHcDZ9q0zL9vViQWqgHcpbv0Ms5mZ5JenN43BnsyRl6ZtiAr1APz2hyj6NxRNtyNUbmGN04OPtNA9i/v8ky1K4B4kPzujrondyTCyPe3mRc0acGm/vrotKDVxp4ctzBPbZA4WQduOkjh5Qn0wQo0zvsPiWOhg7z1KuWx3la8wW8MXkvNJPHl+IRS8F1sf9Eh+M+E30kOwYsa2gH0caUzwVOrz5sw6qWew3eL+FcNa9gHj6R3g==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by OSNPR06MB8443.apcprd06.prod.outlook.com
 (2603:1096:604:489::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 07:08:16 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:08:16 +0000
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
 AQHcstFOqEOl3ItXl0mr3midS8GMZLWsphAAgABXFACAA7sEAIAAT9LAgAF5RgCADH1X4IAAILCAgAK7OMCAEYY3UIAvrvqAgADtghA=
Date: Tue, 12 May 2026 07:08:16 +0000
Message-ID:
 <KL1PR0601MB4276AB799EC03BB00C4C0E5490392@KL1PR0601MB4276.apcprd06.prod.outlook.com>
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
In-Reply-To: <b1d56feb-9847-41b1-8bba-733963055cae@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|OSNPR06MB8443:EE_
x-ms-office365-filtering-correlation-id: a230ec80-ba6e-47f5-ae6a-08deaff53d7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|42112799006|366016|38070700021|56012099003|3023799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 8f9TtchSygJ7BdOGa/CS9cimxIt/cDUBUj5QiZFSCEf9f4PC1LQjspTZCQyB/THYbEL4QLAlQ/tR2J8TGZ5xpeGCAJkIMHR4NjSQDc4/5c6SwaVME+ExSljo9uvKbnB5gnjQ315YVPsy4WEhq4f6/HxI3ObSyRU3ojTmBjMv/y9iZhlHKzLwoJVHnpVu/RVhDWAFeb+CpyPoYTLnz4HN6IPav552bHhv55QbRQAa5UfcSc2Qazs0GNPm5lW38bfMvg/BdmyTgk/Pq6ff2AGuB8cvsZbeRj2leRMhYWpeFUDnpgeHVg0x7m+UZb/r+zphyG8d4CFNEno95JdXFwAcDPwq3fbIXopiSjUJxxzwuKrlqKZwi7YdYNIlrVlB1+CZ+0AgAUzUpaYRGXcfx2J2ThgpojdZuNgXVzn3rMQKPuF/lXqOZOTaTdGwoUus5b+CEK31PqLsnNjuWibxLoiaeBO5ZrPRFlZ+bylMYtyo3f3uBimNINwnt0KUO0dVRob7flv6XQm61J4SD2k0V7BLkHWUabIDoHbsxs+5TKN8KAwO7Ow9PlTTIHvnMIYgoCeGIhh9OnU8G74a0EOehvHIT0RfIt9xVNSalGYxy0lmMpnQY3zLjQX6CQ7Kj48ophjz7rVx79tt0//q7gUNl0Y6LsLyiCVVKQYNtybyvUaRGfvHi9iRn+1+4D8/X3sPvuDBGJe2j+5nTmW+ilhugsna7ZlhjsEBekF2I3yZmozWAIHf8bccc/XfYTAVsES9NGP7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(42112799006)(366016)(38070700021)(56012099003)(3023799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clVlLy9VTWwvSGIrSHJpcSt0RTM1cDdvVFlJRXZUaW9JVmFNcGdVV0JXOU1h?=
 =?utf-8?B?SG9Ga2g1Q3NzdHoyWEVSMjRPNEo2RjhxT1VKQ3VmU2Qrb0tCN2NNTG5yaE91?=
 =?utf-8?B?K2JGNlRxb041Ui8vZEtqcWhUMXMrRHFyRDFRaFpJUHUvOHVqUTNPRDd1NWpT?=
 =?utf-8?B?T2hTM2wvK2xsVms4ZXdHWkVDREdaNVduY1VHYllFSUpPeUZrb01XV2VaMzdC?=
 =?utf-8?B?dTNHUC8ySU8randieHkyZjhRKytsSTEvYUlvOGdyTmhtcW1VUHNpOXdvdHRP?=
 =?utf-8?B?TEx2NVNUQ09kUzNwMWlVVEluM0tscU1GM29IQjNNYm5oU0JqckU0ZmdmMUJK?=
 =?utf-8?B?dlNhYUVkNVFWdDVlR2hpa2M5YjBOYkxLUk9wakpob21MeVI4Q01aSkhHT2pG?=
 =?utf-8?B?SWZPSXQzUU5abHl1bC9MKzE0ZEpVQm5wQVY2bXZqNlJZRUc4cGhiVFExaThy?=
 =?utf-8?B?M3NkVS9LU2ZXZzlFNnN0Y25aN2pibURra1NFWmZRSU5GR0VQcEg5bFdaMmNo?=
 =?utf-8?B?dWZkcVJmWVluWUhNU0g2V09YQ2FWbVRuMmJHTnlhYWFkVjhPREFLWkI3eTdS?=
 =?utf-8?B?QTFJeURpNDZRVlp6Q3NpaktwZnQ0N1B3RXo5R0JFZzljeUlockQ3KzNEVkoz?=
 =?utf-8?B?L2ZIdERRdkE2TSt3QjI5RVFXYXdFbEJtTUNmeVRQOGN5OXYvS3ZrRzM1cFNK?=
 =?utf-8?B?eWNkblc1TkZYNWIvUFVwMnF1cktCVXdqSXY1R3lDYTV5TUVRQzZHWHhJQlI1?=
 =?utf-8?B?YzcyY1IvWFRsK0JuRXVUZHNlWFNVVDdreGJ3VmdCTkVzNXZsUzV4UWRpeVdj?=
 =?utf-8?B?YWNMcXNBWGFSa09qakxVYzRSVCtWa012Rzc2T0x3U0lJMWZRK0pJclBBalJh?=
 =?utf-8?B?LytCb0xUcUYyNDNxWlBTa01oRmRaU0xyQlpJelVSN0IxUzhmREE3cExSUUlD?=
 =?utf-8?B?STVmcnVpUGdjTnJockMvSkNQelgzUHhLcUVMWkxxZ2lON1dFL3RhQk1ic3oz?=
 =?utf-8?B?M1NtKzJoYUQ5MkE2Vk9SbG04TVZ4Z0x4ZHUyTHZKakpWbWZDM0E0dytJRXM5?=
 =?utf-8?B?aHNIeFdBOFhYS2hZb0FRQ2M2ZHliNWxzUjJYQmQzcVN1dGVHVStqa2V1K0tz?=
 =?utf-8?B?QWZia2tueldveVZMQlg1ZzF6Q05BbTBsOE4rNXA3RVk4YU1aTWpIRW9QRUJj?=
 =?utf-8?B?YXpjNmpkSWhzUTl2MlUvRWU1VC9qWmo0ZVBmTjkyQllVdlk3UjZGZ0FMaHFY?=
 =?utf-8?B?RHNYVUorRTcza3BxaVVPQmx1ZkFTenh0SW1LVzQ2emdTV2dPQkdpaDZLZWFW?=
 =?utf-8?B?eE44MVZwaEZvMWgzZVduY05vYW5zOGt2dEpLOW9ibTVCcVA3a3lsdDNXN0FK?=
 =?utf-8?B?bWJYanYrN05LZGxiSmFqMUo3dHlMZHY3OGhzR3AvQ2h0dEJuejhMcHhHTGw1?=
 =?utf-8?B?VTVVQnlJTEtrS1FKZHFHdU9Pc2hSOStBaTlEU3J0eWwveUg4UWhLRk0yQ3p2?=
 =?utf-8?B?UnJEcUFNd3pTUi9nTEs1R2p2NEZVbGpWTlBpdnRzb0RoNFJPcWdNbDlCUEEx?=
 =?utf-8?B?ODkwbGhQSU5XblpTUklnUi95S2IyMjhnaE1ETjJOeEdQZTdNUlNMalI1SXBP?=
 =?utf-8?B?T1ZMNm5leHlTNjIzWmF6Z0JZYzdMdWJkMldhMkVVbTIzUTdFK2QwdW5VZXJ4?=
 =?utf-8?B?b1JzY0pQZ2gycy9DelBSN0wzeWJiRVhqdkhtUVhnTnJOYmpBeVBCSFJVWTdK?=
 =?utf-8?B?cXUyQ2VYZm1SRWxuZThmUVFxN0ZPcC9pRmlVM3oxSDdKV2ptbi9oc0c0MDFI?=
 =?utf-8?B?RFFYa3lvaVBhS3JQU210Mnl3UmtxaVNjdXlyTnpYVS82ZmRmbnZ6NzdlL0p6?=
 =?utf-8?B?cWM0ci81Qmd3MTlHRXZDUEV3amNScGJKT1VSdWpxRGNIbm1LU3NJM2t4QnVU?=
 =?utf-8?B?YXFETEJiejhvTXJRK01EWTBQVWZvMDVNdktuZkZpOW56dWhSK3Y3ejcrOWpP?=
 =?utf-8?B?WlpycGQxNVdYckp6Mmd0R0dlZERCZ1NmL3FLNDRIMnh2OU9aNWVrcWVkQXl4?=
 =?utf-8?B?cnZFSHZwN0piMThJQkZ1NTdSajlIVjRyU1ZYKytkTXRRRXZzV09wendtVU1O?=
 =?utf-8?B?RFM4KzZ0dmVpdGx5dEF5MTgyZ3dpdWJYQldNTnVtRitWLzV3bkRVRWdSdm9W?=
 =?utf-8?B?SWtzV0VSMkZ2OFRweGZUL1dER0oxeGd4dFFid0RKYnZSZkVoN25iQUthUktE?=
 =?utf-8?B?d0E3Q21OUnZVODNxdk9oZG5FMk5CRFhvZERPN3FtQXJEbGx1NXRBOHM4QVFi?=
 =?utf-8?B?Z2tvWXRsTVNIcFVFWFZualZIMUZ4ZkNxcWhHb0w2MU5pTGxkY2VsZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a230ec80-ba6e-47f5-ae6a-08deaff53d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 07:08:16.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PX3WDZ9itKMX/G1PqLi3SmLEGeRB8Ny8BdeqaSzxQ+OuXnnClxlJvKNsZTmGmfun6/upox5tD+v28RMmhRvRbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8443

SGkgU2h1bHpoZW5rbywgDQoNClRoYW5rcyBmb3IgdGhlIGZvbGxvdy11cC4gDQoNCj4gSW50ZWdy
YXRpbmcgdGhpcyBkcml2ZXIgaW50byB0aGUgU1BJIHN1YnN5c3RlbSBtYXkgYWxsb3cgcmV1c2lu
ZyBzb21lIGV4aXN0aW5nIA0KPiBkZWZpbml0aW9ucywgZS5nLnxzcGlfY29udHJvbGxlcnwsfHNw
aV9tZXNzYWdlfCwgYW5kIHBlcmhhcHMgcGFydHMgcmVsYXRlZCB0byANCj4gc2luZ2xlL2R1YWwv
cXVhZCBJL08gaGFuZGxpbmcuIEF0IHRoZSBzYW1lIHRpbWUsIHBhcnRzIHN1Y2ggYXMgdGhlIEZs
YXNoIGNoYW5uZWwgDQo+IChpbmNsdWRlZCBpbiB0aGUgY3VycmVudCBzZXJpZXMpLCBhbmQgT09C
IC8gVmlydHVhbCBXaXJlIHN1cHBvcnQgKEkgd291bGQgZXhwZWN0IA0KPiB0byBjb21lIGxhdGVy
KSwgYXBwZWFyIHRvIGJlIHNwZWNpZmljIHRvIHRoZSBJbnRlbCBlU1BJIHByb3RvY29sLiBNb2Rl
bGluZyBhbGwgb2YgDQo+IHRoYXQgYXMganVzdCBhbm90aGVyIFNQSSBJUCBkcml2ZXIgbWF5IGlu
dHJvZHVjZSBzb21lIGF3a3dhcmQgbGF5ZXJpbmcgYW5kIA0KPiBvdmVyaGVhZC4gDQoNCkFncmVl
ZC4gZVNQSSBpbnRyb2R1Y2VzIHR3byBhZGRpdGlvbmFsIHBpbnMsIFJFU0VUIyBhbmQgQUxFUlQj
LCBiZXlvbmQgdGhlDQpzdGFuZGFyZCBTUEkgc2lnbmFscy4gTW9yZSBpbXBvcnRhbnRseSwgZVNQ
SSBmdW5jdGlvbmFsaXR5IGlzIGRlc2NyaWJlZA0KcHJpbWFyaWx5IGluIHRlcm1zIG9mIGZvdXIg
bG9naWNhbCBjaGFubmVscywgcmF0aGVyIHRoYW4gZ2VuZXJpYyBsb3ctbGV2ZWwNCmJ1cyBzaWdu
YWxpbmcgb3IgcHVyZSBkYXRhIHRyYW5zZmVycy4NCg0KPiBBbHNvLCB0aGUgY3VycmVudCBzZXJp
ZXMgYWxyZWFkeSBzZWVtcyB0byBzZXBhcmF0ZSBjb21tb24gZVNQSSBsb2dpYyBmcm9tIA0KPiBB
U1QyNjAwLXNwZWNpZmljIHBpZWNlcywgYXNzdW1pbmcgdGhhdCAyNzAwIGRyaXZlciBpcyBhbHNv
IGNvbWluZyBhdCBzb21lIHBvaW50LiANCj4NCj4gVGhpcyBtYWtlcyBtZSB3b25kZXIgd2hldGhl
ciBhIGRlZGljYXRlZCBlU1BJIGxheWVyL3N1YnN5c3RlbSBjb3VsZCBiZSBhIA0KPiBiZXR0ZXIg
Zml0IOKAlCBlaXRoZXIgdW5kZXIgdGhlIFNQSSBvciBhcyBzb21ldGhpbmcgc2VwYXJhdGUgKGJ1
dCBub3QgU29DIGRyaXZlcikuIA0KPg0KPiBHaXZlbiBteSBsaW1pdGVkIGV4cGVyaWVuY2Ugd2l0
aCBTUEkvZVNQSSwgY291bGQgeW91IGhlbHAgY2xhcmlmeSBhIGZldyBwb2ludHMgZm9yIA0KPiBt
ZSAoYW5kIHByb2JhYmx5IG90aGVycyBhcyB3ZWxsKT8gDQo+IA0KPiAqIEhvdyBtdWNoIG9mIHRo
ZSBTUEkgc3Vic3lzdGVtIGNhbiBiZSByZXVzZWQgZm9yIHRoaXMgaW1wbGVtZW50YXRpb24sIA0K
PiBib3RoIGZvciB0aGUgY3VycmVudCBwYXRjaHNldCBhbmQgZm9yIGxpa2VseSBmdXR1cmUgZXh0
ZW5zaW9ucz8gDQoNCkkgYmVsaWV2ZSBvbmx5IGEgbGltaXRlZCBwb3J0aW9uIG9mIHRoZSBTUEkg
c3Vic3lzdGVtIGNhbiBiZSByZXVzZWQuIFNvbWUNCmdlbmVyaWMgZnJhbWV3b3JrIGVsZW1lbnRz
LCBzdWNoIGFzIGNvbnRyb2xsZXIgcmVnaXN0cmF0aW9uIGFuZCBiYXNpYw0Kc2NhZmZvbGRpbmcs
IG1heSBiZSB1c2VmdWwgaW5pdGlhbGx5LiBCdXQgdGhpcyByZXVzZSBhcHBlYXJzIHRvIGJlIG1v
c3RseQ0KbWVjaGFuaWNhbCByYXRoZXIgdGhhbiBzZW1hbnRpYy4gT25jZSBlU1BJLXNwZWNpZmlj
IGZlYXR1cmVzIGxpa2UgRmxhc2gNCmNoYW5uZWxzLCBPT0IgbWVzc2FnaW5nLCBhbmQgVmlydHVh
bCBXaXJlIHNlbWFudGljcyBhcmUgaW52b2x2ZWQsIHRoZSBTUEkNCnRyYW5zYWN0aW9uIG1vZGVs
IGRvZXMgbm90IHNlZW0gdG8gbWFwIHZlcnkgbmF0dXJhbGx5LiANCg0KPiAqIEFyZSB0aGVyZSBh
bnkgcGl0ZmFsbHMgb3IgYWJzdHJhY3Rpb24gbWlzbWF0Y2hlcyBpbiB0cnlpbmcgdG8gcmV1c2Ug
DQo+IHRoZSBTUEkgY29yZSBoZXJlPyANCg0KT3VyIG1haW4gY29uY2VybiBpcyBhbiBhYnN0cmFj
dGlvbiBtaXNtYXRjaC4gU1BJIGlzIGRlc2lnbmVkIGFzIGEgZ2VuZXJpYw0KcGVyaXBoZXJhbCBi
dXMsIHdoaWxlIGVTUEkgaXMgbW9yZSBvZiBhIHN5c3RlbS1tYW5hZ2VtZW50IGludGVyZmFjZSB3
aXRoDQpleHBsaWNpdCBob3N0LUJNQy1zcGVjaWZpYyBzZW1hbnRpY3MuIFJldXNpbmcgdGhlIFNQ
SSBjb3JlIHdvdWxkIGxpa2VseQ0KcmVxdWlyZSB0cmVhdGluZyBlU1BJIHBhY2tldHMgYXMgZ2Vu
ZXJpYyBidXMtbGV2ZWwgdHJhbnNmZXJzIGluIHRoZSBrZXJuZWwuDQoNCkhvd2V2ZXIsIHNvbWUg
ZVNQSSB0cmFuc2FjdGlvbnMgYW5kIHByb3RvY29sIGhhbmRsaW5nLCBzdWNoIGFzIExQQyBicmlk
Z2UNCmFjY2Vzc2VzLCBhcmUgcGVyZm9ybWVkIGF1dG9ub21vdXNseSBieSB0aGUgaGFyZHdhcmUg
cmF0aGVyIHRoYW4gYmVpbmcgZnVsbHkNCmRyaXZlbiBhcyBsb3ctbGV2ZWwgYnVzIG9wZXJhdGlv
bnMgYnkgdGhlIGRyaXZlci4gVGhpcyBtYWtlcyB0aGUgZVNQSSBkcml2ZXINCnNvbWV3aGF0IGRp
ZmZlcmVudCBmcm9tIGEgY29udmVudGlvbmFsIHNlcmlhbCBidXMgY29udHJvbGxlciBkcml2ZXIN
Cm1haW50YWluZWQgdW5kZXIgdGhlIFNQSSBjb3JlLg0KDQo=

