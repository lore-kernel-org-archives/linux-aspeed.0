Return-Path: <linux-aspeed+bounces-2566-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A3CCD1AB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 08:29:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs2Pw04VWz2yrb;
	Wed, 22 Oct 2025 19:29:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761121747;
	cv=pass; b=hKvxErRZhhgGXnGyHgIVGLjoThwg0QtICMUIpAE3ioXBPzdCZdtZjGEahn/yHQ6YwXHr4dz/FtqJNsqb67DQTFHLoYm9nX6h2Nk+uzkvOB/GKNJ6I+fqc9DBzf/a0q07CMyyw4HeWB7ri6qha5cEd0bL8VPWzn01A8QlUXh0iMOQB7b3i9Ca4wIbBNUBDcRFAOdyrgHs3oqOkQIPNfKqO4aKTv6m2GAiwkHUavgRER2StDUQpz8+Tv2EtEFWXPlEx2GTsQ4G51fbi5q5rGr1ZF7NhScIz2WWcMsvx5zPrL94ghynd7v4hJdCCLvO4/vLXN1cTCX5Dyxbxi6pW0LWvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761121747; c=relaxed/relaxed;
	bh=I+usERoobPg+iRROrP8/38iVEmrlni4yKKzK/5hcF54=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/Z82EQcCK0oo4j+hp47EvnysGe3EOeg51RbMEzgERul34TjLsZpmwehqFfj+Z/bcTaci3gSg7bLT4bgDOOoA7dcMlsBVaFZUdQU4ydIiF2pP1WPdyVNAbINwAgjzpa1fNxzC5+ejgyLMz8Hz7HQsKv7APGtgXvDFcKQIJ863k4lzLGtS8ufQZ3vRBaupWsE3wVCedP9to+7bLCoF+5IdE9wE1TyjZe5UA5eD4agwWNK1OLzRfvsd3XL3DW1lYuEzFwqtnsbgtYOH1e+lafAa1vHpl5QEuCBdf2OnyXTQ07lcpvWIzjPhigOyDbV6ETdLrbMMP0vR6Yolq1+KxAmXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=W24V9bZ9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=W24V9bZ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs2Ps5pK2z2yjx
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 19:29:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9W6xmKcnyqSPNpUoWmswY+zGa8aQkkzbuU9RtRULiqSqMohZ9IQXc5T+kn+5WDw8mNVmLbKTUVeuS0941hp3uV7I/0EiflVPaaUXml9GFATFtsZ84vBbQchwSEImStygGRmkLQTS/n7C3XxL+TU4Ib0b+Gb4XV4pxDghnoEOffpuFbLexpdTFOSEf7/MMQNdkgb8qUhAZrLFwiSIwqWSQ52bIo0b9wOYRxmabTFSUOA4e1Dw7dbIZyJys8KlmQip5jXe0m/y/0UnagZ+1phrNyB+sk5nrX2XG9wueqIPt4HZ7/Aj1bc3MBaITiLvlr5of7Pl28RlDSfFYQsFZFy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+usERoobPg+iRROrP8/38iVEmrlni4yKKzK/5hcF54=;
 b=vXKQFfhbG5tKens8TDQohDwKvUjdfRbivgBuvZBj4K+LnkcCD8DYavy64W0GgT7cyLJ1Arxk+WXl19x1es/VRDotPqgotbOZuLpeDirahuXzwcZvZ4+ALV3mmWYEPDg0hu2OQcexiUSzAhXBZCtkS5/1LSkUP2yhNJM5xU6LAVtwig2RK4XXiB7HcOub9PdSr+B5REXGfOt7dl1A1Nuky6zhGZk+0U/B/AHyWzfKFDlgs3kS+UDvyKcEJab9WDeOMKKWH29SDcAlYPvNdBByr9bw/W17OwosUqzk/okspe9sXvLtGgXstkZzMUljS9RIqCvBKgpdf61Qz1NY3ZjOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+usERoobPg+iRROrP8/38iVEmrlni4yKKzK/5hcF54=;
 b=W24V9bZ9Ey6DfzZI8YND1ZjTV86gWm8jkc+L+nqRf9m+fu3ZeL+5CDybG+ubuHtWYLM1BjAOaD87K5PP63ZybiSRUk8D8cK1SWr5QqIw3WxjaRMI7ZzNv0t4Q/itGCLzh8EcE01jLIUfcV1i3kHAEO4F5cJDYJa/HmUo3KyPO7328QIs1dhPLEQ99zfqqd7YwMyul9StOv7RkdXuCghosgTcJO5N6VmLlDImC6GwNvB4DjVQi1parRCDzrFv0TSYYeT/QsH4icFfQaT6L7I33DMNPtVRezXBA0jUS3lxvm0rVDMGHUWHBfE7T0Oew9tKj1vzw46WtTAX3g/YBc3H7g==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEZPR06MB6285.apcprd06.prod.outlook.com (2603:1096:101:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 08:28:40 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9228.014; Wed, 22 Oct 2025
 08:28:40 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "jk@codeconstruct.com.au"
	<jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	"nfraprado@collabora.com" <nfraprado@collabora.com>, Taniya Das
	<quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/6] dt-bindings: mfd: aspeed,ast2x00-scu: allow
 #size-cells range
Thread-Topic: [PATCH v6 3/6] dt-bindings: mfd: aspeed,ast2x00-scu: allow
 #size-cells range
Thread-Index: AQHcQyJOVReIAh3KfkOzMPA0rgTmD7TNz7sAgAAFj0A=
Date: Wed, 22 Oct 2025 08:28:40 +0000
Message-ID:
 <TY2PPF5CB9A1BE61219A29CA15C87D7AEB5F2F3A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-4-ryan_chen@aspeedtech.com>
 <624530ac-078a-4312-b8da-c2a090aec7c4@kernel.org>
In-Reply-To: <624530ac-078a-4312-b8da-c2a090aec7c4@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEZPR06MB6285:EE_
x-ms-office365-filtering-correlation-id: 05a78e59-5265-4bec-b295-08de11450140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3poajEwdHNwZlVZVGcvMXZ3UlBDemsyZHd4dU9TbTlSUk9WR1hLbUVFcUc5?=
 =?utf-8?B?SkwvRUpNWHEwZitKVlErMGNTSDEyb1VlL1pXczI0V3E0aFl6eTJuTEZHbElD?=
 =?utf-8?B?MnFYdVpvaHcrSWZsbHpFRVpwR0k4bjZDMUFQTUtHclN1aGpZTUR6UzhyMVJw?=
 =?utf-8?B?L2ZaMzFjQTJqS3V2OXA0b2QxK3RXV1hVL09ocjRqczZGWG9iSjFCbzNGT1pr?=
 =?utf-8?B?NloxWFRVNzcrZ3Z2NkVkU1N4N29EWUZsY2lpNWcvUUo1d0VscGJPcWM4cFJt?=
 =?utf-8?B?V201anZUcGhzc1IvTVVpNkFZOXd1aC9CQ200L0ZNZmlRcnlaZTJSdDUvOEhY?=
 =?utf-8?B?bFB3QzI0eG9PaWU0RGVUQ1JCRDRSNVhZQjVPT1dRWVdrcmJKUkNIYnh3WFli?=
 =?utf-8?B?VHZlRy9VZ3NlQVY2RTQzelB0alYyZEZqWURYUHRSMGgyMGxJWVVBVlprMy9m?=
 =?utf-8?B?T0NlL0dMTW8yNTFBREZIQWJWbXdlZjlwQmlIOXc4amN1TEUxSWk5OXJQNENl?=
 =?utf-8?B?NVVRZW15V2lxTExqTWZtK09VcDl4NzE1NGZ4c2dJdGl5UGVDOFNUQ2hSd1VY?=
 =?utf-8?B?ZFRWK2p0N2tLYnV0dVIzVklJcU5HRmh2eXRLMUZRcXkvc0d5WGZXb0Uwdno5?=
 =?utf-8?B?cFN1eEQ5MmRkdTBQenpyemtTTmFXUnpPVy9YMjBpMnFrYVhmeTIxdGI5NUxO?=
 =?utf-8?B?NXo3NmRFNldweFZ6Tlc2bW1sNVpRUE9wU0ZzK0Z0dnhBUG1VbEg3Ry9pdDF4?=
 =?utf-8?B?bklkVXJmckg0dVNzRmpIdFh4aGcwN2dQUUptd0VVOFFRcWpuOURDQnppTU1N?=
 =?utf-8?B?a29hczdlTzdrQ29PZUg4ZENCQjRWcmt4MnI1bittdUMwb2ZlWTJ5MGlua0RG?=
 =?utf-8?B?WTdCaEk4YWRpVlh5bmk1Q1FSN2gxNTgwY1hDeHNpTTNxODVqNlQ2UXp6cDlG?=
 =?utf-8?B?c0dpUy82VFkyYzZWTU5vYUlBTXlHdGhndDFjaUNmMkRiN2RKd3VTK1FTS0hF?=
 =?utf-8?B?MTU5RnZWL2pYbmxJbFZnYkNnbU9aa0psL2hlSVFFMGxlV29BbitaQjl6cHlv?=
 =?utf-8?B?aW5laC9DZDNsNEFFY29TTUc1YmpNU1RWOFB0NjI4TDhhQUkrNy9yV0JZVUdO?=
 =?utf-8?B?UkZOb3JDVFlseGVsZk0xaVo2aW9NSndGdDIwV0d0QzRDc3N3MWJLN00vNmpN?=
 =?utf-8?B?SGN3UEJkME1TTEVoRFRtSzRTYTZLVE5pUWN2SnAvYjV3anZZdm9Qb2tEWVpI?=
 =?utf-8?B?anI3UzVYREQ0NDN3ekVKa3kxUnBmWno5YXZHTzdtOTErY0xWT1ZSU21wbklP?=
 =?utf-8?B?SlRlckdQSmtqMTZDc2dscWNZN3VnMGNwbmxkNkI1ODZlcmhBMFpuS3d5c2tr?=
 =?utf-8?B?bWVMUnFOcklpcnE5MDE5MmYveXVmRHVnUWQrek5rTlFSZlh3RHlaQ0MvTXhm?=
 =?utf-8?B?RFJqdkp4Qkl4YVZFMjRGdW8rT29DZ3liNTJ1MXJ1VG53UnUweVNoVGpqdXBz?=
 =?utf-8?B?S0w2ZFBTb1ZRc1Zlb2lHc0dUVVI3N0RFNmRYbnMrcmwra3RLelk0RVkrWFd3?=
 =?utf-8?B?ZlJ6MFk0QlIyQVE4WDhxUVFhdUF4a3JyTzBiN1RKM3k0d2pzU2hVMTUrVFNP?=
 =?utf-8?B?a2R0aWFULzcyNHFzZHpPTlZsbC9iNllDWWRvdW9JaXE5OEV6d0Nya2ROREJ2?=
 =?utf-8?B?dmUrSGxlQjRaQTdUK0s1RFkza05YNFR4U2gwU3MzS1pBNUJFa1daS3ZTaVBE?=
 =?utf-8?B?VWNVOWc3U0IzQ2ZUVDNWSk9UQlJVVFM5UktxQTRUclNtYmtCcGcwZkxPUVFD?=
 =?utf-8?B?MUlTVWVTU1lkcTFDUWYwdGU0S2pwY04yNENETXV1TFJ1K2xab08yL1BZSitl?=
 =?utf-8?B?WkZQd3RRdTZFdEVBZXVqd3ZpSmV4Y08vWFJhanoxMUo0MExFeWZLb01zQjdS?=
 =?utf-8?B?cnVtTTJZV0FrK2h2cTl3MmRnV1dWUmVCSW5WMmMzdUpJUTdTWWk2cmhIV25J?=
 =?utf-8?B?NXJYN0Z4M09LcGhvNFRGbnMyVDJZbWpPbWJxOXhSTnpzcTROVjVJZE54bUs1?=
 =?utf-8?B?cjNONTJ0T1loTWFTM2pqR0ZOemoyNy9pRW5Tdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFByR0VqY3ZpWmRCT21xMVdjM291UFlISGtaK3N2aG04bzh6Z0MvMFBqWXdI?=
 =?utf-8?B?N2R1cTNiRmZqa20yckxRdFJKZFI0ZGQ3cHNJclNOTXdYVnJGcUtnVEZhWHY5?=
 =?utf-8?B?Qml3RmFBOUJuRks3d2l3MW5YWkUyb2dEeXIwNWhpNDZIY05oM01sSlc3YWdp?=
 =?utf-8?B?T1YveDVidUp5dzZNbU5RYVV3Zi9qYlNMaUJEMDIwL0IzNFN5VGhGUXN1Wndu?=
 =?utf-8?B?Z2pwcUFiNXJFQ24vcWdQdjVUbVNYY2p3Y0pESktDUi9VY0VySTJPWnpBYmpD?=
 =?utf-8?B?ZjI0b3QxSnd4SU5Nb0Y4SWx1b1N0ZTBBNU42bUhtUVJBYTRYL2ZMeUhnUEI0?=
 =?utf-8?B?YmFoY2lJTGNwQW5rNGI1d1FYNXdxNzVsZXpueFVrUE1IWnRuOGtZRzNlVENW?=
 =?utf-8?B?MEJDOXBPZW43VGZ2WGNicjBmNFlxQ3dIZm9IRlRaNkErU21FSlJORFlVeURz?=
 =?utf-8?B?djdJc3A4eTBFd1NNcmFEaWpldTZrOWF2RHRhR2hVdWFnNWlIMWs2NmZxaUJU?=
 =?utf-8?B?OXVFUFZpSDZJOXZLd1pXdkxhTjQ1NWxJRW5WazZHcHd2RnJkd0tWMFJtcDRm?=
 =?utf-8?B?c0dscmNKZnRoa1dsdGpiTHdWZ0VRWmZTbVZNRWMwdE9hYmg1RzdjT3hiaFIy?=
 =?utf-8?B?MUFGYU0rUEkvRzAxOEEzNTdoazU0ZWFQcVJaR0M3eGN4YjdFS0ZGQk9UYWJT?=
 =?utf-8?B?M0FuMmdKL1FCMFlJMDNQN2hvSjEzSzdiLzBzMnpJMUlXMEhNMDE1Z1ZCR2Zr?=
 =?utf-8?B?aTd3cnBObVlaa01TTHJ0SmI3ZkFobDRSd3h3N1JhMUk2b2hnYWMyMU0vc0tH?=
 =?utf-8?B?VjdWS1pwM293WTkwQmVKL1R4TWZ4Y2NaTDdvaVRSc1lhM2cxRmR1RG9TMS90?=
 =?utf-8?B?QjduMktZYXBtYW53K3ZxOG1VaEVScnRGd2pZaTJ5WDM3bmZHK25LdEVnQWFN?=
 =?utf-8?B?TjBGTXpBdERsZE9XK0JEczlGV2tiN1ZOSzhDYWUrWXRBZjh2ZlRqbWkwTmhn?=
 =?utf-8?B?MjQrRlJZb3JBZ3Z0M2c0TngxZW1tQllrbVBqVmpVd0c4UkJIeXJSVTVaR1lC?=
 =?utf-8?B?VVAwTnM3S1lmaXQrV0hwSW81YjZsZEVRYWpOY3k2cyt0ck8vM3QwUHIrMjA0?=
 =?utf-8?B?NU5idDVoYXdhUVpQRHAwR0VDanV0MmtCSFg1V21jR3ZabGR2RkNwclRrcXZJ?=
 =?utf-8?B?YmE0U2Q3MnBrc1pxWlF4bG91T1ZwTkdaamVia042OVB3ajBSQnNkSGtySnFz?=
 =?utf-8?B?STNVY0VWTXdhWDlPbGRKMUtwb25xVmJSUlBNcTBqazVWcTNMMU9VZ2VPdkVV?=
 =?utf-8?B?WCtCRlV4N2I5dWRuMXNsd01NQ2dNNysvNWxYTk96eEcwSEFaaTRsUlhuM2ZN?=
 =?utf-8?B?c2tuMTZSZFFuOHFHWGlRdThFVHdJM3h2Njh2RElXR2ZXVHBrTzZYUHZ3c3d6?=
 =?utf-8?B?cmhMOFdiRkZNL2h5Zm01ZHNQMkk4Q1Qyd3g4dWloYzVBMnJzK09KcmxBbldM?=
 =?utf-8?B?UDdhZEhHaCtXWGZhNlVYNUxVVmczMGZlS3BSRmtRNXVCZDV5Wk1jaitDZ0NF?=
 =?utf-8?B?WDNHdk1hZUJVbnN4YVdlR2RiTFZGRGxFVkhpOG5lOGlBUnFJcGVrUUpqRmZp?=
 =?utf-8?B?aVZ2enZ5aWhOcHV3YkdrVHVhdnZBa004cUtLY3UxNGU2M2NzRDlTRWJoVURk?=
 =?utf-8?B?bENEMW1ZUFJBbmZNZlphSVpZSnlMWlh5MkhaLzhHZ0FEOUlYbmQ2VW5iWW1J?=
 =?utf-8?B?dlFSbE1mVVFpWHpFU2dwQk9CYmg1c2N3RHNaMEhzNEdPTkhvenJjUWlzaDJo?=
 =?utf-8?B?bmluK0dXaGJPWHo5T3p6c1dDRzZCUlVyMEpROTZ4WXNvUkpvRDkxM3pxemtK?=
 =?utf-8?B?c0FtKzludG9icGhoQWpLWGp4aFAySDZRTzdaVEUzTmU4dFd1YlRpQnJYVnF1?=
 =?utf-8?B?YnREeVpNR2RwTEpVdy9kVTBZTjM2aE8yZ0xjWERFOFVTY1lLVkpTTVU0V1NE?=
 =?utf-8?B?TUwvb1RJWU9Wb2VUK2did1NocWJuTXJjRnl6NUJ6V3BkTnRENGF5Z05JNm9U?=
 =?utf-8?B?WGpxdHFKSU92M2Y5QTZIUGxrTGpRbUd2Z3BXaU01VzNvMkcwelBJSkVMQWlG?=
 =?utf-8?Q?kkAcAYQoruv2mzwI5XERQ+sph?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a78e59-5265-4bec-b295-08de11450140
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 08:28:40.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFevAFuW/K2xmIbH3JNbjbTmgLDP/8S/+P+DVHn4CAAlxULHdVTMJZ8SEkXu9/wFF4+247cMhCZDmV6bBCXxVL2pxvX+6NXcw0cVgayP6mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6285

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDMvNl0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkLGFz
dDJ4MDAtc2N1OiBhbGxvdw0KPiAjc2l6ZS1jZWxscyByYW5nZQ0KPiANCj4gT24gMjIvMTAvMjAy
NSAwOTowNSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IFRoZSAjc2l6ZS1jZWxscyBwcm9wZXJ0eSBp
biB0aGUgQXNwZWVkIFNDVSBiaW5kaW5nIGlzIGN1cnJlbnRseSBmaXhlZA0KPiA+IHRvIGEgY29u
c3RhbnQgdmFsdWUgb2YgMS4gSG93ZXZlciwgbmV3ZXIgU29DcyAoZXguIEFTVDI3MDApIG1heQ0K
PiA+IHJlcXVpcmUgdHdvIHNpemUgY2VsbHMgdG8gZGVzY3JpYmUgY2VydGFpbiBzdWJyZWdpb25z
IG9yIHN1YmRldmljZXMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHVwZGF0ZXMgdGhlIHNjaGVtYSB0
byBhbGxvdyAjc2l6ZS1jZWxscyB2YWx1ZXMgaW4gdGhlIHJhbmdlDQo+ID4gb2YgMSB0byAyLiBU
aGlzIG1ha2VzIHRoZSBiaW5kaW5nIG1vcmUgZmxleGlibGUgd2hpbGUgbWFpbnRhaW5pbmcNCj4g
PiBjb21wYXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgcGxhdGZvcm1zLg0KPiA+IEl0IGFsc28gcmVz
b2x2ZXMgZHQtYmluZGluZyB2YWxpZGF0aW9uIHdhcm5pbmdzIHJlcG9ydGVkIGJ5IGBtYWtlDQo+
ID4gZHRfYmluZGluZ19jaGVja2AuDQo+IA0KPiBUaGVyZSBpcyBubyBzdWNoIHdhcm5pbmchIEkg
dGhpbmsgSSB0b2xkIHlvdSB0aGF0IGFscmVhZHkuIERvbid0IGludmVudCBmYWtlLA0KPiBmdXR1
cmUgd2FybmluZ3MuDQoNClNvcnJ5LCBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCwgd2lsbCByZW1v
dmUgdGhpcyBwYXRjaC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

