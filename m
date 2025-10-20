Return-Path: <linux-aspeed+bounces-2525-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BD4CCD199
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 06:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqlvZ4GFtz3000;
	Mon, 20 Oct 2025 17:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760941914;
	cv=pass; b=K91W+tD8gf9Ib5kVMyU5IvVaBIOPPQkrTfrXjB32vLl/WjIQfCr1fxatkOIm1GySgADWw70oE20zT1eVxJJ1PoIk+9z72FHGAFQBR0feu8TJnaBJY80FE1MogC4aYISRtkfRypDjDv6hFcvWZw+8+4iOkXaMSIW2V1ugEch46Dr7IH8qr8hx+9zpOB1Sbp2FFJgrh0cvY7pOLRvebbqncfBCVV/3rE4i9Mnt/sOhSpMXEjHZljufzQSun9jWfvfcCA4NE4NUslxZW/d/yJqtGw/uo8fkYvk8F42mLRI2xbYX4ifPhgmEwg136yAqd7fZ72H+PPaIoJcqgkuNi4LMrQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760941914; c=relaxed/relaxed;
	bh=SY5fmzLGWhKX2sBcSZ6Vhu61dotEnVyzVRdOn+eZ3tQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJmSCESfOwhoqT93qkN9BbGlCTQhAaQwfpOqsVsRGaZUBaGrCRWg3uBUnmgSUrZWn3ZQzjZ6YkB5DzhuGd1r8uS/mfB+xU+4liFEPXaVxeftQzviS4ISC9NCMH1s8EFkZ2Bgooa1p7k/Ce7Jh0xnlZk6Q1yJtbMzoofwQg/CuiVfPoCUJ5+md65mxtHO/hsY5q4QdPPAhIeD6enf9GYGu1lSG03yyF50QvDhSTN4qnz7mDny4V0pCnrDcq8xwfo0yvzwXCLJQ/RhUt+/4f6GW7/YpxPAz3794FGJ7+7+KhaLNgC61VKy0wxTgChXxNtkycLQs7Bs5qYHgx5fZYHCvA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=OYC6r8Tk; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=OYC6r8Tk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqlvW5MvTz2yVP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 17:31:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXC8HQvsFet3WHzCjZGfeAF079XUC6f+oOvlJNlBoPULbxB/3jyb4vJdBfajqhiGtnP5/j33GGeUvOtuogxT4Qx24I82/66/5DgXr741OCqh+bnUeoOIwMNkT2QXvQLlOK/hAZ0a8TMwek+YRUPvF320PId7LdQAQgak1QK5k/RKz9OpaclS8Y8UO6/MuZIRUubuPxEp624pzIyYUR6QssUo8Io/LNkA+MDLZGE8lJzbr5lWZBGy00D9TAstCR+kyKdwguo5rO2LclCxxuFnP4SvVAEg1PyTCqudE7CMNHZCR9s65uTASPi8fpsHhrLPGFkbFtDHPK+j+N8GIR3IyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY5fmzLGWhKX2sBcSZ6Vhu61dotEnVyzVRdOn+eZ3tQ=;
 b=dl8bS417LAtD+H9dOunbZ1lQi3Bp8hrYdcj2m2eD+yYvhFT0fpv6yaYbbkBuTC6eJ43Hx1DIe+yvTn1wcI3Z2sjctRtpw4HTIwsY070lr0vWBJV0ie6ZqEu8LBnAGsBpeyLKNNM9HXoEIZDeJOQzM5IGf00de5HwGc6VzbzaQUoAtSYtGUbY2IQcg1w8os87KN1A5EXoW8UTUTZR0xmqHZu4YSftYLEMNl+MGUlAUXgW9TEE6iYfBf/Kps/v84MDt4kp5e68UjrS8KYuNQV3qpeNTvGwNRb2jhVzAmRTF0b85L3JuL9BFmgkee9FnDaAh1xLW6Q4+JSmrzsBv0LL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY5fmzLGWhKX2sBcSZ6Vhu61dotEnVyzVRdOn+eZ3tQ=;
 b=OYC6r8Tk5RQDJdvVaEfBloJWiEYAOXQ450dHiW3B0MZknv8aMBvfm/qKUXVsMqZfmw/nQuHKqNVlJH4BuIF+ToIHEzvc+DEMxXuAmY4+MFQP9AuXWHjx5T5CcwwRxa042kq0rlXbqpMXZ8B175w42aggV97MjM+l08OZxrTCZj28fh//YZ356eqMhv3AmbR7wciWZOZLASFHtvfvEch+fca7r/4BV8rc7ZVTvFrvjryOauz9lGeETWWs5M58DLoWoFp9joZeeLZdojeGshnQDk1ODIHBKTtjrUkqU9CLqwcPqxvBmPvC8N7q+9JN6hK1A5QgmOy7z9Y8CzhAGL/1+A==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KL1PR06MB6986.apcprd06.prod.outlook.com (2603:1096:820:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 06:31:24 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 06:31:24 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Topic: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Index: AQHcQWZVHXgbRjt/U0uvaTyLW9Dz6LTKj6aAgAAA+wA=
Date: Mon, 20 Oct 2025 06:31:24 +0000
Message-ID:
 <TY2PPF5CB9A1BE6CDC6F04CC0F472FE6451F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251020020745.2004916-1-ryan_chen@aspeedtech.com>
 <b38321e8-d243-460a-a9d6-6770a41627cd@kernel.org>
In-Reply-To: <b38321e8-d243-460a-a9d6-6770a41627cd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KL1PR06MB6986:EE_
x-ms-office365-filtering-correlation-id: a62073e1-5cb6-48e3-9779-08de0fa24a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzhNK2tIL29tOUg3TzVyb2JvNUU2bnpBODFpVDd4TEFrOVBhS3FIdVN5T1NP?=
 =?utf-8?B?cHRiV1UwMkhGUHJ0ZWtPZmtBMnliT3MyTVl4Rkh6UTAvZHJ3STdTaFg2WnRS?=
 =?utf-8?B?bnFJb2d5OXN2OHdwRkZrUmJ3bkZwUUNodmp3SkZhWnRPODdxNGEvNUNWbUQw?=
 =?utf-8?B?ZS9EOGt0aTlYUG5UMGhkcll2MnltUHU4VzNvcWdZanl0RjFDWS9BVmlOVWcx?=
 =?utf-8?B?eFZlbklXUnNQMTNZc3RRSytPRVZVM3lMV0NFZWVMQUVoZk45SnUxVWtmSE83?=
 =?utf-8?B?QW5hSThlK0EyUmtOOUxlMnNWbXhWSzR3eXJqSUJNQzY1YzkyQ3I0QkNKZTBp?=
 =?utf-8?B?OXAwcjlPbDNKN2Z3ZWwxekYzK0puUW5pZ3dFcWF1MWdubnM1K1Faelh2ZjJT?=
 =?utf-8?B?UDhXN0dseUt1c1lqdUVQUWJ5VTBXZ2ppRGxPSm9jckJEZ09ZRkdxZmRocDNN?=
 =?utf-8?B?NUp5VHoxWG5LUmtHSWpIL0hEVlBBc2FnMEZCMmRkNG14clBxbERjL1hRSDRo?=
 =?utf-8?B?di9ueUxMdUFFcy9jYzFTZkJFVXdSU1drR0RCWFR6ZXJ1NkJYTTBpYmtsWGlX?=
 =?utf-8?B?ZXArUWVaMXJEcXRZdk9wUXNiNVdlQmcyMVhYM2MwZ1hQSzVVZVRSNSs1akly?=
 =?utf-8?B?WE1DYlFnczJBRXFkL0xPdVRWOHlFZGlzY3FQSmNtSTFoaGRPR2xGSXJFaE5o?=
 =?utf-8?B?eUkyZ0FNN0VVMjRKcWtCTlFNbGdkT3F1R3owMXhINTdrcnY3c0dXaGVMUk03?=
 =?utf-8?B?WVVWU0JPZnFadHZJbnJtMFlBRGhPOVFYcS80L3B0WmFKWFBkMUp4SG9ycmxp?=
 =?utf-8?B?MG51Mnc1RzBaNERVUUpiY0l5Skd6TXNJSTh1b3VGai8wdkxXUlFDeFV2VjBX?=
 =?utf-8?B?WnYzNG5HZ2Y2UWx0dEVheVJyZy9kVFJRUVlQU0NDWFM0U241UHJPK3ZwMDJ3?=
 =?utf-8?B?S3BYeHNpVm5UMy9KRUhBSTdDQ2tlUys1NGpJNXU4MHF6QW9nSlI5b216UW1W?=
 =?utf-8?B?STdTNExJSEt6VFc2RHArcTRNdzFzS2pUblRwWTRxajZoZnlXWXhmNXVLSUpi?=
 =?utf-8?B?RzBTOVd2VURvUVFGeldjMDFIdWZyeW04WUxraHZab2tRb0NFRzJRY2Ftcmp5?=
 =?utf-8?B?Z1dTTFpMRkcrelh6MmxEWWppOEpFQTdnOHduQVZ5RGJ5QmhZbGVncUg0MDhT?=
 =?utf-8?B?b1lJVkdJVnB2Uzd5Y2JEMlJUdmdmY0syN1E3aWZSQlovL21FS3Y2NFVwa0do?=
 =?utf-8?B?ekNIU1c2L0xUdldBbVVDVTI2eHpJdGcwWmliaXpTbzhpV1Q2eFc2ZWIzbGkr?=
 =?utf-8?B?Sjk4SVVTMWoyOUg5VUNYSUJWak9oVmlTczNGM2NXR0poa0x4ODJxOExodmVO?=
 =?utf-8?B?ckdhSlRXUWRBUVAwWi83eHhhc0J5dlJuREpxbm9JaGwvSFl4N0lPR2x6bGNs?=
 =?utf-8?B?andIUGVVbWYwNHlpdGkybGVBRE1OMGQxa1RTZzgwdkxCa2R5ZXdZSFczTEww?=
 =?utf-8?B?eHZxUnhBRFd3bWtGc2dQdEl3SUhJTkJVcEoyUEE0bHZncWlLN083TWllNlg2?=
 =?utf-8?B?KysvUWlIWENiZHl1N1ZhUEJUTzJ5TjNsaFV1a1Bxbmk2cFczRXhBVU9LajJi?=
 =?utf-8?B?QVRqSFcxV2J6Z0FLMlBEOXc1QThMZGZYUlhiNU5yU01IM01VWHJzaFNRRnox?=
 =?utf-8?B?eUFybGlJSDJhekZJSVZsN0I2bk5jMTM0N3FCQnVsUjBMK0JnOGluVnJ3SHhp?=
 =?utf-8?B?dWp1VG9XVDdyZCtWazgwcVhlVTRVTHBHRzF6bzBCbThDK3daMHc0OW5GL1Ni?=
 =?utf-8?B?Y2hhaG05MmlSNEpLc1BPbERnNUh4bFhyOWtLNXZHbkE2Lzh0N3gxR1dRdUpq?=
 =?utf-8?B?bmZQRVRBdXBMeHVBcmcwUVZuOGJyUU1admc0ZE14Vm9TOFNGZjRKNnE0dzg2?=
 =?utf-8?B?RlpBOEVMUkEydGJjQ3VIVkQ5bkZiUkM0TitIUTR1dTMwUkl0QWcrNFgxVjZN?=
 =?utf-8?Q?XhjE4gNmNRcgFGRbDJfdpheb5r45z8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3RUVEdTVlZxRDJVREsxRWZhZmliU1JnWGxIL3VUYXp6eUVNaitwOHFtWjFI?=
 =?utf-8?B?WllKTGJFcVVwaExpRUdKTTFCeGk2SDV1bDJWOWw4MHM5Zk10THRER0YyUXZM?=
 =?utf-8?B?ODF1bnVOaXhYSENOMXBLYTBPVkFYSnFsSHpoN25LZzBpUUdhQURxQWF1V1J4?=
 =?utf-8?B?ZlV2RDB1TWY4c09vRFdPWEVJS0NGWUNrdWw4NWZXZnRqTmNQeTE3alJ1d0xN?=
 =?utf-8?B?ZWNXSTl5U2tCaHdPTXRLdS95cjBFSVhhYzhuT0ZZeTZmQUFuR1dtb3ZnakQ2?=
 =?utf-8?B?VzQ2eGlOSFpnZEJSazFlRENXWjdNYmgzNzhnU2lGbjJyVDJraUJ6NWZiRExM?=
 =?utf-8?B?RjBhdnF3aHNJK2h5dlJFTTQ2SnowbC9Cdk4rNC9EamN6Um5aanBCanZiRUlv?=
 =?utf-8?B?ckJVOGFlOVRoNHJuSFhhNDd5OUZYbWlPK0laUDFEd0dYTWc5bkM5Rk9DV05m?=
 =?utf-8?B?VFNJeW1yT2JhSS9hRnc3VUtXVWNRcGFoanJFVGNZaHV0dGhaS1JuTFJaMVlB?=
 =?utf-8?B?TGFoQXBZdHBwMXhycUwzVTVJMVVHT0JidVdET2hrc3ZhdTk0cmhyd244WDZM?=
 =?utf-8?B?N0RaNXhRV2JJSWdwdmQ1M1NqeTVjT0sxMkZiNjQ5QmY0T1JaNjZ5NUNOWjdR?=
 =?utf-8?B?REZLYXUwQjdrMVlRRzlYcFZIRWJidXNjTUxBWXFvL3pCMS9HWnVOWEVwS3pS?=
 =?utf-8?B?KytkN0o1bDFYK2EvUGh2ckRZYUY4RzF3Yk90MVVvclhOek15OVRIaldIa2NV?=
 =?utf-8?B?a2gvcFFNQlB2Q3V5MlgwUDVjWGt4U0gxZFMwYTB4alpPa1ljSmZvWUZ2RnpM?=
 =?utf-8?B?S2tFbGR4dEd0ZlZyRWdld20yeEpiMVJyZWtxSldSR2l5bURrZlBXNEFWd0JB?=
 =?utf-8?B?czh5SGlBVkIxd09JZkpRZ29TMTlZNVc5cmUzWk12cTFBT0FaSk9oT2hpRC8v?=
 =?utf-8?B?cHVJaVY2VGMzeWNTRzlkYyt5Z1YweFRhRDdXaUF4SUNtUHF1YjA0MEhtRWJS?=
 =?utf-8?B?YklLdkREQnlCbW1ncUcrREpBNklJNVZaa0l1VjRhdjBpSG9qeG1QeUowRW5w?=
 =?utf-8?B?d1FFSElkd1FjSkZhMEE5ZFNPaElMdVRqM0NNNzdZbVkxeEl5NFBFYmVESCtB?=
 =?utf-8?B?MzkyV2U5Mno0WnhXUFpzZXM5bzhhTTFGZktoMGoxSGdHVWJuVllZMkZ2aU8v?=
 =?utf-8?B?NkFQbjBkRWxua3N2SFJLcDhOcEwwem03NHhKZGNpcGlhUldkd1pMYStrb29X?=
 =?utf-8?B?WUJJTWNQbmI0UHM0VFNjZG5rZVVRYTBUai9Pd0lZS01FejhzUlViSkxyOHkx?=
 =?utf-8?B?NXBsN3V6UFRQUHlkbjRpMU84aW51aWZhcFJBN0ozby90ZVFrQUg3MGNLNS96?=
 =?utf-8?B?QmIvbHdTVjg2TUJZTnBxOXUrZ1VIaGlPV01veVkwQ2tXcEcvSWltRHR2V2pP?=
 =?utf-8?B?ZlM1UzZLNkRPVlB5a1BacnBiUXZNdjJJTm5hZ3hyZ3NjTGZHWDkyemtiV2g4?=
 =?utf-8?B?R3VuTGdid1psRlIvZHZJSGFNMnBZSUtXbzRyaW1pSEs4bXRNUWV4SXp5RjhF?=
 =?utf-8?B?MUZMaEVxWGxreFltSlBDcDJmQUlHejE2TS9wbXgwY0psYkpQV29JUG1JU29N?=
 =?utf-8?B?YnZBSFdSK2ZmL1l0c2szYUM2WnFjZDZ2NXpVcjNxKzJEOW1Jb2tHOEVra09D?=
 =?utf-8?B?V1phZCtEdlFjaEMrdUpMK2dOaHdGSnF1Z0RGWnJHTVdrUlZsM2lEYkRiVGJo?=
 =?utf-8?B?bnd4VkZXamdhQUtjZVNtaEtaVUNxNWhjalB4Q3VEVE9ZalB0THJDdEh4SUQ0?=
 =?utf-8?B?SFhqOWlsYUUvZEdNMWJhVXJOSU5vcGM1cTVQMDdLUEJ3cUJJM2ZCRmJpVnR0?=
 =?utf-8?B?MDlVZWx0RFJDRVVUVnlvZFdJRytpLzhnZVFCdnBaeXZJYW9ESHdmYk45aXQv?=
 =?utf-8?B?a3lkaS9PdXZTVitzaFh1eWV0RGtaL3BHL010QmQ2QzREUi9USEJQaENUOGVq?=
 =?utf-8?B?VTRtMm9oK3JkakQ1THlNR0l4QUkvZExVWnZPUTZFT2dBTzZlR3VqZVR4ejlR?=
 =?utf-8?B?QW5uK1BCS3M3ZFJaQW9HV3pBWGJ6MlFXZ1BFLzNHNHZBcDgrbi95NmRPZ3FQ?=
 =?utf-8?Q?fCQWxnkvwcK0CLYRkZqfWGPPp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a62073e1-5cb6-48e3-9779-08de0fa24a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 06:31:24.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXYNe0KrhwudEqbszr+KGtYuHFBB9Mc4p2jwjXjDXIWj0jvbYATe0rZt542N+Bp+3p331IRoetuGVd0qjaJrEwWNBeurjqsTKmDlosEOweE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6986

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogbWZkOiBhc3BlZWQsYXN0MngwMC1z
Y3U6IGFsbG93ICNzaXplLWNlbGxzDQo+IHJhbmdlDQo+IA0KPiBPbiAyMC8xMC8yMDI1IDA0OjA3
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gVGhlICNzaXplLWNlbGxzIHByb3BlcnR5IGluIHRoZSBB
c3BlZWQgU0NVIGJpbmRpbmcgaXMgY3VycmVudGx5IGZpeGVkDQo+ID4gdG8gYSBjb25zdGFudCB2
YWx1ZSBvZiAxLiBIb3dldmVyLCBuZXdlciBTb0NzIChleC4gQVNUMjcwMCkgbWF5DQo+ID4gcmVx
dWlyZSB0d28gc2l6ZSBjZWxscyB0byBkZXNjcmliZSBjZXJ0YWluIHN1YnJlZ2lvbnMgb3INCj4g
DQo+ICJtYXkiPyBTbyB0aGVyZSBpcyBubyBpc3N1ZSB5ZXQ/DQoNCndoaWxlIEkgc3VibWl0IGFz
dDI3MDAgcGxhdGZvcm0sDQpUaGVzZSB3YXJuaW5ncyBhcHBlYXIgd2hlbiB2YWxpZGF0aW5nIHRo
ZSBBU1QyNzAwIEVWQiBkZXZpY2UgdHJlZS4NClRoZSBTQ1Ugbm9kZXMgb24gQVNUMjcwMCBoYXZl
IHN1YmRldmljZXMgKHN1Y2ggYXMgY2xvY2sgYW5kIHJlc2V0IGNvbnRyb2xsZXJzKQ0KdGhhdCBy
ZXF1aXJlIHR3byBhZGRyZXNzIGNlbGxzLCB3aGljaCBpcyBub3QgYWxsb3dlZCBieSB0aGUgY3Vy
cmVudCBgY29uc3Q6IDFgDQpjb25zdHJhaW50IGluIHRoZSBzY2hlbWEuIA0KDQpIZXJlIGlzIHRo
ZSByZWxhdGVkIHJlcG9ydDoNCiAgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjUvOS8yLzExNjUN
Cg0KVGhlIGVycm9ycyBhcmU6DQogIGFyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzdDI3MDAt
ZXZiLmR0Yjogc3lzY29uQDEyYzAyMDAwIChhc3BlZWQsYXN0MjcwMC1zY3UwKTogI3NpemUtY2Vs
bHM6IDEgd2FzIGV4cGVjdGVkDQogICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwjDQogIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvYXNwZWVkL2FzdDI3MDAtZXZiLmR0Yjogc3lzY29uQDE0YzAyMDAwIChhc3BlZWQs
YXN0MjcwMC1zY3UxKTogJyNzaXplLWNlbGxzJyBpcyBhIHJlcXVpcmVkIHByb3BlcnR5DQogICAg
ZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZmQvYXNwZWVk
LGFzdDJ4MDAtc2N1LnlhbWwjDQoNCg0KPiANCj4gPiBzdWJkZXZpY2VzLg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCB1cGRhdGVzIHRoZSBzY2hlbWEgdG8gYWxsb3cgI3NpemUtY2VsbHMgdmFsdWVzIGlu
IHRoZSByYW5nZQ0KPiA+IG9mIDEgdG8gMi4gVGhpcyBtYWtlcyB0aGUgYmluZGluZyBtb3JlIGZs
ZXhpYmxlIHdoaWxlIG1haW50YWluaW5nDQo+ID4gY29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5n
IHBsYXRmb3Jtcy4NCj4gPiBJdCBhbHNvIHJlc29sdmVzIGR0LWJpbmRpbmcgdmFsaWRhdGlvbiB3
YXJuaW5ncyByZXBvcnRlZCBieSBgbWFrZQ0KPiA+IGR0X2JpbmRpbmdfY2hlY2tgLg0KPiANCj4g
QnUgdGhlcmUgaXMgYSB3YXJuaW5nPyBXaGljaCB3YXJuaW5nPyBPbiB3aGljaCBmaWxlPw0KPiAN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2gu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L2FzcGVlZCxhc3QyeDAwLXNjdS55YW1sIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3Uu
eWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQs
YXN0MngwMC1zY3UueWFtbA0KPiA+IGluZGV4IDVlY2NkMTBkOTVjZS4uMWQzZjY4NjU3N2RiIDEw
MDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNw
ZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55YW1sDQo+ID4gQEAgLTM4LDcgKzM4LDgg
QEAgcHJvcGVydGllczoNCj4gPiAgICAgIG1heGltdW06IDINCj4gPg0KPiA+ICAgICcjc2l6ZS1j
ZWxscyc6DQo+ID4gLSAgICBjb25zdDogMQ0KPiA+ICsgICAgbWluaW11bTogMQ0KPiA+ICsgICAg
bWF4aW11bTogMg0KPiANCj4gVGhhdCdzIGp1c3QgZW51bS4NCg0KVGhhbmsgYWR2aXNlLg0KV2ls
bCB1c2UgZW51bTogWzEsIDJdIA0KPiANCj4gPg0KPiA+ICAgICcjY2xvY2stY2VsbHMnOg0KPiA+
ICAgICAgY29uc3Q6IDENCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

