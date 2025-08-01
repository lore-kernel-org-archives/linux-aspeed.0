Return-Path: <linux-aspeed+bounces-1875-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88FCC87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Aug 2025 14:50:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btplP1SYxz2yfL;
	Sat,  2 Aug 2025 00:50:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754059809;
	cv=pass; b=jjkJ/pAI8qSKLUI+PZ+S2xmklZx/WoVwS1yJ1JRC8BF2hCFwmajmYmXfdO8OGtr3QDO+24LGYvayA01R5TBGQiA2+uqq7JYb5EdodhBgnlDhNJBcSnR/tgH82Vh4A0RyafGQVEjx3gHKL2yMZKB7MNUa5zgiaT47VrIko9AX5i/TeFUtgFIXvMUnvmeHtKFrCy4wN2Jh/yCEQd3Dcrj93QiAfcK3Zws6B0mHvMSYwI6i3/b2lS6V2KOIMC/9Qk5koYaKQmbnSvyBV1n50bXjp2YsAK7Qhi+tIt5gfb/fR5IeOFl+kI1qZ72JvD6aRAkVqsTFG/+1sLi7zj4XcEjmLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754059809; c=relaxed/relaxed;
	bh=b+Iu5srfvlSrKQApJNparhjUP0P50O9qi1Yt6y4Z0JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CSdnTS0ItZHEH/DHy9Ze96Sa6adO+Gdp/auyIkK6nYQ0CjQn7Lbyn0ldaOYimNc45fZrHDRzE3oSlM6AOCxPIY4Zt8lIpVmgiaYpzFbA27W5XZ3S4zzcEY8Qqd+bc5DA3K5MltrTFnBK7GPmJHLfkx/nRZvJ8lTvvW90zAZSOfxn5QNnTmrIlAOeYcgMY1j6rxm5Nr/XtE5ZMDoOefteJ2v3e2qFhwfHQg8r/sjRC74ZotS09tnmZNLjJtVpAdYyZ1ps+biusg+ricWIl53ZGNx+HSEV4+/fwIdwhCEDQ7FJQM0jTO3Iy/fYPmisBksa55ttmrnVEqoy8s9q6F0fJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=quantatw.com; dkim=pass (2048-bit key; unprotected) header.d=quantatw.com header.i=@quantatw.com header.a=rsa-sha256 header.s=selector1 header.b=S40i6uXQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=p.k.lee@quantatw.com; receiver=lists.ozlabs.org) smtp.mailfrom=quantatw.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=quantatw.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=quantatw.com header.i=@quantatw.com header.a=rsa-sha256 header.s=selector1 header.b=S40i6uXQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=quantatw.com (client-ip=2a01:111:f403:c40f::7; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=p.k.lee@quantatw.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btplN0CtSz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Sat,  2 Aug 2025 00:50:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilNLiKSkRq8vdmWnRC3k2E1/9Au9cAusXOBotxl6CO/qlIrbhpzemYJY4stZlcn5gyF83PMVhan8W+psaDmc9JuE/mIBeHwTI34nRx1e3KVgXM3F/igK2VYTeN4gxHywoX6fYzAvyjyyz2pNmSljgvOBh7eGEs2iPQpLpQkhTUWpPzWKU95RFs41Qyn1okqyPXv7FuxHMD64gy5wfzfEaFVcYzIuWY/2cS2RbqOAiXaIsVmhKt/LwAJ719xCAjmfo2W5qri2tECXUiknqWzsDAkFuCBvqpWKRA3eLqLKrn0ByOJ921mU8c7s9U2RQHZqrsDLS8/CTn4cy5OLMHyQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+Iu5srfvlSrKQApJNparhjUP0P50O9qi1Yt6y4Z0JM=;
 b=K5f2O2wwoodf6dnQjOWqFf5yMuPcxlAWGHMP3lyWYJ9/bhiNpZq/w9MTv9vdlc2PrOwWDakBHy781Cg/O5ItQCzoiKmOLTRzKEjlJ9t1Bouszjco1SaVpUwfp7lFX/3EsjZJ6HpEwNLEeH6+AsSV8wLJ6Uh89s6RHU5RJTuF++asedAVe7qGvHXPx+gayXW4QQ0JgcVfhnu/fpe0paSLHeedQjz2ohyajGKdN6xuaHNkLDiQO5LMNTBS08Wl5YUU07ZMigITXd6py3AuIIeaPFdiUZfYcVPT6P/HCKxdNPsz61XBH+4Jme2tnGTeIj2Q/0jtmx0eRetOat0254YPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantatw.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Iu5srfvlSrKQApJNparhjUP0P50O9qi1Yt6y4Z0JM=;
 b=S40i6uXQPeEen6R6Atyf/rsBPjQHlNXg/Tt2ftgCblEbrTk9EetvYtPnkjIWLqAqM6uQdh2O2tho4xf/r6YNRcR67gEUGGTwrj4If/Mku1lAR5Wnh92Bn3e4etTskl7MiMbuWw08gexhCzLb1zyjXACTwsitYfx8I1rmSNyZFg5G9LwwFku4/bIvA75RhHzNFa5QK/vyNs7ymqBrooW/om62MIwqXgzzKDI81GTiEQpNCuaruwbAEyLX3qTIMhr1RAXxa4KoxFqYhmP6zfWg9+krsRzAMnKcnwA+G0s4VprC1mG5fCfsaSG6QH5juUKT7px4wLGHz+pdWgxrssUaUg==
Received: from KL1PR04MB7709.apcprd04.prod.outlook.com (2603:1096:820:13a::5)
 by SG2PR04MB5890.apcprd04.prod.outlook.com (2603:1096:4:1b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:49:42 +0000
Received: from KL1PR04MB7709.apcprd04.prod.outlook.com
 ([fe80::7476:4a70:cc28:6143]) by KL1PR04MB7709.apcprd04.prod.outlook.com
 ([fe80::7476:4a70:cc28:6143%4]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 14:49:42 +0000
From: =?utf-8?B?UC4gSy4gTGVlICjmnY7mn4/lr6wp?= <P.K.Lee@quantatw.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "P.K. Lee" <pkleequanta@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>
CC: =?utf-8?B?SmVycnkgTGluICjmnpflqIHlro8p?= <Jerry.Lin@quantatw.com>,
	=?utf-8?B?SmFzb24gSHN1ICjlvpDkvbPnrJkp?= <Jason-Hsu@quantatw.com>,
	=?utf-8?B?WWFuZyBDaGVuICjpmbPpmb0p?= <Yang.Chen@quantatw.com>
Subject: RE: [External]  Re: [PATCH v10 1/2] dt-bindings: arm:aspeed add Meta
 Ventura board
Thread-Topic: [External]  Re: [PATCH v10 1/2] dt-bindings: arm:aspeed add Meta
 Ventura board
Thread-Index: AQHcAu8I/fhoBm7Ye02W3MqI8IV9+bRN3+ww
Date: Fri, 1 Aug 2025 14:49:42 +0000
Message-ID:
 <KL1PR04MB7709935954C0100A8296D078DF26A@KL1PR04MB7709.apcprd04.prod.outlook.com>
References: <20250801141131.2238599-1-pkleequanta@gmail.com>
 <20250801141131.2238599-2-pkleequanta@gmail.com>
 <6452a85c-0b90-4c46-9685-5cd6886dca15@kernel.org>
In-Reply-To: <6452a85c-0b90-4c46-9685-5cd6886dca15@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR04MB7709:EE_|SG2PR04MB5890:EE_
x-ms-office365-filtering-correlation-id: 2cc30730-9a5c-4db4-af1b-08ddd10aa652
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHh4NTJwcGFOZnEwRC84aUdRVUZZSEpEbi9rVDk3dlVWeVRPNEMrcmV1b1JP?=
 =?utf-8?B?bmxhRHR1WmtOYWpkYzZKWjkreXBLM0J2WW9sbXQwZ2RldlE2NmhUa0o2ZWZX?=
 =?utf-8?B?dk9mYjdyMnhGUTVnajEzMzJOemNaYWVXdXhwU1FzNGFrWGliWituSFhWc09r?=
 =?utf-8?B?WlljRllJOEd1M2hVa2tadkx4L3Y0Ty9Rbk5TRkR3NWFaUGd2b2U2d0xsUG5z?=
 =?utf-8?B?Nm84VndsQWtwalFZVVY0MjM2UVlPNzRXTEtzQUphU01SS3FMVFRTbFJPYVVk?=
 =?utf-8?B?SGk2T2IwYXcxc2Z3Z1IrS3RLckZLNVo4U0t6ZzZUR3d0Um1vNGtyUy9UcTBa?=
 =?utf-8?B?SzQwb3AySlo1OVpwbEw0YWVRTEZPdENFUzhOL2lmc3ZucVhGWjFxalV0N1B1?=
 =?utf-8?B?TkVqRlBwdi9Dcll1YlFDY1RST1cybDlWYm9oMTdnRUR6RmRNNGYyeHRTMjRt?=
 =?utf-8?B?TkcyMjJDKzNhTDNtbVBrT2M5V2dIL08wdndseThBbUwzakZvLzBVRWl3Z0xI?=
 =?utf-8?B?ZjhaYWk4bkRFWHQ4Ump2VW1oNzh4MncwS1Bmakg4VXRJcjRocmt6RmpVeVg1?=
 =?utf-8?B?Yi80SFJnSWF0YVMwbFFwY0FkL3JoUVA4aDM0VytZZ1BkZXczdE92a3RuSmdG?=
 =?utf-8?B?TnRvb1RzWWQyYzIxcUpTZUp0c1hZa3JZTXZSMWQ2V0YydEI3OVloN3ZjUkxi?=
 =?utf-8?B?ejBWN0IzN3VTWEhiSU5ZL2pBckl3ODkxaG9tK2Z2SHhQYytVRTlPdWlBK1VC?=
 =?utf-8?B?L3BBNG5FZ1J4SWRxbWZEQ3MvMmxyVDZZVkdFNk5Zd3hyU1BnRXUwQWFaYVZ5?=
 =?utf-8?B?aDFxelFOVEM1M1RLSnZTVmFEMmhrMWFCWFFaQThpTkY5WWo1TzNXOFV1TnFY?=
 =?utf-8?B?UlM3c0pEM1VqbWkxRE1wK3NUN0ZSbnZSMFc4bGhWMHhZOStualFRNUxWZXpo?=
 =?utf-8?B?RE1NNWdDdk5qQUxQYTJRaEpneUlWbWRPdVdGZjMrbTZ4blE3SENiNTBTcDFt?=
 =?utf-8?B?RzErZnVoVUgwZGQweGttWVVuODFrZFZzWGlHUUJIQ0F1WHVFZUNGTjdRMytq?=
 =?utf-8?B?dVhlSkM5bDRrcnhrZzhzYTl1UUt1TUV6MjVrVU5SYTdEVUwyeUtUM1FXbTBU?=
 =?utf-8?B?MXJYT3dWeExYcnNzT2RQRS9maGlBUkoydW9VTEI1WnNIY1VZZ2tCNURNdWVG?=
 =?utf-8?B?RFJnMUlBM3BHY1BhOWNnSG44MkVoVUZWTmp3VDhobDRIeFVtelYzV3ozUjhI?=
 =?utf-8?B?blJTcmRVM3Yxc1JBbFQwZ09KUG5FRm5tYzFTODZYOW15c1pIOERKSCtFN1B2?=
 =?utf-8?B?c0g2K3VvbytzN0RhRHEvcDkrVXp1MFpFREszcXBveTBueWllK1ZScldUY0x5?=
 =?utf-8?B?ajQ0bHR0Q0FhdHBHbHRFVDFvQUVTWHp3VGhJVTh2UTEvUTVWVmo1L2FWOTlt?=
 =?utf-8?B?b0RZNDFiMENpdjBPNkNBNDFuTHFJM2lpYXdhUjJOQnBOOHpUWC9wS04rSlJM?=
 =?utf-8?B?QjB2U1FoUEtybUVNL1ROanNkb1pxTXZlaTBOdmNTNStxRDkvODRmZWhKNzNB?=
 =?utf-8?B?R01UaDIvaVJEOXJ0a3JmSjU1NFJrZjhlVW1QYnZtcDJZczNRK3Zsa2d5VkE0?=
 =?utf-8?B?TFNEYWhLZlZ2VE10Z0xKQnM4eXIyQWx4Z1hhSDR6T0JhMlRaVXNWNCtxaWZo?=
 =?utf-8?B?LzlLelViTmh0V2R0OUN5SllqU09aYkVhQUVxRWlheHpXam9iaEJraW5HcUxG?=
 =?utf-8?B?VGpia3QxUUh4elZKVWNNTWJ6Z1lyZnN3NXIxZWlja0o0eXJzekM5SmxDN0Ra?=
 =?utf-8?B?LzR1SmRHbDJpTWw2Nm1kOVZwWnRsYlJnMmdJSHhBcFZsK2x0aS82bHRQQTh0?=
 =?utf-8?B?bEI3T1RMV1BmdnBhakIxeExnMlJRMmx5L3pqSExQYktEcFBxcVBndjZONXAy?=
 =?utf-8?B?YUxManFvN2lhSHdWLzU5WWc0My9qTjBWaXozamZUMG1PQ1JPaDdRa0FRQWxM?=
 =?utf-8?Q?klnPFyKeClMIH4tRK6sAPek/oq3Qas=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR04MB7709.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFQzczFYQ2s0WUNhdmFBSmxyMUJCaVlJRjFWNFJCcWVYVXdTSUpNeHorSTQy?=
 =?utf-8?B?YzhVNzNqZEFXTWgvV0Q0ckFOOVNsVWwreG5JUVcrc1M1R0hDSlRkN1Rva1Fy?=
 =?utf-8?B?dGwyemdQcmoxdjBPMTB5NkRIR1k5Vjdwc0VBbmlxNlN4Y3lYL1RPWjdMSTZY?=
 =?utf-8?B?WUpMZXdQSWxvMmZITlV0NlI4eHk1bmR1d3FjUG9Ka0x1L3pBMVFVRk9NeVNs?=
 =?utf-8?B?aVlhZEVpTEk1OTYza1REWnBrVnUyWlNacWt4U0hQdjU0a0Q4NVFZcEFNeTIz?=
 =?utf-8?B?MmJaYStZWnFxdys3eUlBanh2QXJWTXJnUFBtNXV1Q3lxVitYTExxcFcrY09K?=
 =?utf-8?B?UGVML2QvWllsK0hJVHF2T1RwRzhFVHluLzAxTW5pQ0ptUmROMHBmY2ZGcHlU?=
 =?utf-8?B?SDBIMDhTUXh3TldlbkExWUFheEhoaDJKaEFXa2FsTzM4N3Q1NUhVcldpSzNO?=
 =?utf-8?B?TWR5SGdQZ0tqZ1VsdGZHODI5Q3dXT2s2cEIvV202TWxTaHMzeDFsNFQ3UXpY?=
 =?utf-8?B?UTdBcmV4N2NUTVZoanBwbG93YmJrRm5ENUY3QlVuMUhLRWRDaDVNaHlsMTlL?=
 =?utf-8?B?VzdYb1lZcjVhdzV3cW93THBWOFJXcGVXcDB1QWRYeE54WjQ1YWY3UGdmamlk?=
 =?utf-8?B?RnZPWFE0K0tVVnk4SXExRVR1dmM2SVA2Y1N2YWpaanZBVEY1M1RRcmxFZ29p?=
 =?utf-8?B?RG9hUHRScDN0UkhxYldqcCtrdjc2cGV5UXFNUFIvSHBiVVlKTWpITlZVdHdj?=
 =?utf-8?B?d0NHeFVVZ2d1RlhaMTBjT1l6L0JUakFSRitUaWswNXdkZXBCYndkWU9CSWNJ?=
 =?utf-8?B?UWZEa01mZDU0TnhyVVdOQURGRUpEbHdNUVZ5ZXgwU1Y0TlZaMnBvK29LRndN?=
 =?utf-8?B?dlk0UFZoZ2I4a1kxVlJQMURwRGxTMG0xQkN6ZjF6dDhnbllLSGN0aDRTWHpE?=
 =?utf-8?B?WjJmbFRKSmFSWWV2SVNlZHRmUlFpcVpCdUtLZ0NJeWIyaUhMZnhjWCs1eWZ3?=
 =?utf-8?B?U0xpOGpPUjdJTWg3dEVRYWJ1L0tTNktSbTlmT1FIQW15MmpQMWJ4Ris4UGJR?=
 =?utf-8?B?REtBRUdEcXRiYmZKTFozMVRCYkkyME5tZDlVOTR2MFdXWXJGeE5ma1VieFNx?=
 =?utf-8?B?ZVpVV09QbEw3bzc2Ty9JSjJtMy8xa29UWHdIbEUvZFVPV2RpakJwOTlKSk5O?=
 =?utf-8?B?d1hKcFdPWDRnSWpsS3RUakgxS1lYSkxiRmxNL1hxT293MmhVdytER0RlMSth?=
 =?utf-8?B?YVE4bGJUWkozSFRtSnZyeGFVeGxUZUpqNy9TRXRGdGVCMGdjcEVFN1UxM0tx?=
 =?utf-8?B?a2FHL0RoeWhqUG8yS2dNbFY4M0tSUnliWnFCSFVRdXlBQmdzZ05oU2ZEK3hJ?=
 =?utf-8?B?NzFDRy9EZjdTL0hjOFhBYjJvZ1ovdElPbFN6aUliQlc2TTk3RWIrUlEwQjZu?=
 =?utf-8?B?QktNdVpuaTRlQW9nOW5GcmdMU084K0lublU1emhxQ3d4cy9mOFdDaTdEZnVZ?=
 =?utf-8?B?VytYSzdwMEYyMytHZ25JZGQ2MHZmbmgzNGVZVFJUK2oyeCszcXpNclNPbGJZ?=
 =?utf-8?B?L2JpRUdSMHZ3WEhWOWRJcmZSOWh2MXF5UXNWd0F3VmpURkVZQTZ1bTg1QmxS?=
 =?utf-8?B?UUtQQkVhL3IwbzZPay8reVI5UDdJQVhJT25hVWlUanhROGxoWDZ1UE5RS29x?=
 =?utf-8?B?R1pHT1hVRFVrRTM0NWN2QUVBblYxK3ZXdmxQMWUxQUlmaURHZklNL3RSelhh?=
 =?utf-8?B?ZXFRYXVaS09mN0xnY3Jyc20zTUJNWml0TlVRR1I3aHJMMWlqNTlzNW04a1oy?=
 =?utf-8?B?eUw4U25icE04SXJLdlRsejNPbEpTSUtxUGNOVndqa2FjMzhVbCtNNE5udWxs?=
 =?utf-8?B?dXEyMXkyUmVYRVNPRU9LR2hIWFFzRElTWDRnemFzTzJYVjBaMjN6d3luQk9F?=
 =?utf-8?B?WGhUVkVJK0YxMXZXdkpMbmM5N3lHb2tDZ0FRV1pHd2JQSjhOeUFHaGJLTHJZ?=
 =?utf-8?B?UTRBejRuTHBhQ1N1RXpJYlV6bzNsa2M1c2FONUtEanZpd0ZNVEhvWkQ0SmV4?=
 =?utf-8?B?MkprbzkvMmN0YkFKdWFGVTRZaFFISmlEWnpBM3NpTUU4b3I1aEI1eHgwSDlR?=
 =?utf-8?Q?dLUmbTO7JnT6PdTf6luUgEqGt?=
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
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR04MB7709.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc30730-9a5c-4db4-af1b-08ddd10aa652
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:49:42.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GEOQgdhlnxgxAAPSYytYer7DFsEr8WrjMu7ZrwvaP0nkSZv20vlLwoKfnPTRu9Ul0Uxbq9+RtzicV8YJM42TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5890

PiBPbiAwMS8wOC8yMDI1IDE2OjExLCBQLksuIExlZSB3cm90ZToNCj4gPiBGcm9tOiAiUC5LLiBM
ZWUiIDxwLmsubGVlQHF1YW50YXR3LmNvbT4NCj4gPg0KPiA+IERvY3VtZW50IHRoZSBuZXcgY29t
cGF0aWJsZXMgdXNlZCBvbiBNZXRhIFZlbnR1cmEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
LksuIExlZSA8cC5rLmxlZUBxdWFudGF0dy5jb20+DQo+IA0KPiBTbyB5b3UganVzdCBpZ25vcmVk
IGV2ZXJ5dGhpbmcgSSB3cm90ZT8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Ck15IGFwb2xvZ2llcywgSSBvdmVybG9va2VkIHRoYXQuIEFwcHJlY2lhdGUgdGhlIHJlbWluZGVy
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQLksuDQo=

