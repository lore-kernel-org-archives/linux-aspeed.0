Return-Path: <linux-aspeed+bounces-377-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0317AE77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 23:11:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YT3ZF4Q8jz30VQ;
	Thu,  9 Jan 2025 10:11:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c214::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736318492;
	cv=pass; b=fPrd1HqLGKbT3+SOvxlYvxmoZ/c+D8wYHYPvKoe1egrjcrJIYBeb0rFJwD5coYX2oxaL7g7FlGEc8V993FsKWm3c6aXdD9sCp0xjWIkPEw6gyCLs73rHQEv/iz0r/cQOc/NEPY+3DPs8OSRSbYd0ViCBNqWBl5aJYu7thRMUF87arc885NmKsIvan1WiLoDqhbrh89zSXldxY2I6f801roe65J3frvckWe0WF5IfjAV0T8R6EAI2FfZfJLB6H9bolpJGLZnnpjm3IEMVFl2j9pPwsRyV0CkuSZdkG4KNbfIR516eAxLpaP2nr43CPrM40ca0q9RZXNJBMtsD4SUaYw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736318492; c=relaxed/relaxed;
	bh=E5hZJTQsjKI2UXYmgGBcu7+48wJYf3FCDWHoJJNnOP0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gWJFGfhZfTRaBrOkCGoBMIElFVEUCxdMzi+u4qgejVKeYx/QwkyoGQfkZhx8u191ppTzkUw52SMVDLWT0uChVX25XTYC9PcWpZLP1aAATggdrh4vodQRYrgnJPsDc0MyRdRN/i3+IeOm6CctUp2ueaeo+tQKLSrC9jw6ZyIOkq1TjVc8KG4PAl/R2yz8CCm37bFLPzL4y/FTuFRYetB5SBhcBGybYkZ5yXyUJ/PYvSRk2nh6YTZaWpbCK47uN1bmRAly0OPNIh5YiM2GA2Ow5wMJb+GsfE+fDvpN/sWYkna19Jvv2m8VLZIizfPZ/7it5oxtx+8mrMkyth5ryVGrkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=skidata.com; dkim=pass (2048-bit key; unprotected) header.d=skidata.com header.i=@skidata.com header.a=rsa-sha256 header.s=selector1 header.b=mvwjz0be; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c214::1; helo=gvap278cu002.outbound.protection.outlook.com; envelope-from=benjamin.bara@skidata.com; receiver=lists.ozlabs.org) smtp.mailfrom=skidata.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=skidata.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=skidata.com header.i=@skidata.com header.a=rsa-sha256 header.s=selector1 header.b=mvwjz0be;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=skidata.com (client-ip=2a01:111:f403:c214::1; helo=gvap278cu002.outbound.protection.outlook.com; envelope-from=benjamin.bara@skidata.com; receiver=lists.ozlabs.org)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c214::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSdcB5dQ7z30TQ
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 17:41:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5TfaYH3jNIyesEDKaAIY4sUmAV+rCiXvT6LllHzT8VyX/ZAtyLsUsfQSrtb7jgqutTzDZ9phvF1ysuh7JGCu2QJVRsu9f7QafcphO1VXyAXjDfzB1/QbeZra2/77Go3rnyJJuDtwAWwXiZGGIJj0Dtop836kSP/3KdITZrTMepo0mVPyBtkQVCKwOsOnD3QKYw5jPb2bm4gdJXvcr1mOqz37eYAqjEkeIKEc8MzKrL/E2KyNpZGg5HEOm9C2rOTaMYGQDBCfQMRFRvrPL3ghjqW9lpBWnUznufBkevDgdlADRNO9PHvFIbkGRjQ7xJzVVJ/ngBRlQM3fJWv8chVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5hZJTQsjKI2UXYmgGBcu7+48wJYf3FCDWHoJJNnOP0=;
 b=RcZGeBnhqeE30dFw5+AWkwvBeIRjKD2SOGp/GlT9jZ5puaOWzg6qwt1jEYpIHQ0FBz40u4ydixms/vWfiHjamsDpyWMA+2tqfm1rp/rbv+PIu3WrhOpJeM65AdEX7r4YZKt/PpH5d9nGQlraM6Hn/5iFpoYz40M6uyiMvvlV5ao2E9gtG3mCt7CgyLDJ87c1zDmd9xk92RTxfas9fPXxNYfp+OGc8a8JykvxxlCWaOTpUQAbqqXMHgXynggZcSSdugQG5jFSz1MNdeNUk4pmWx+UVgMpEuoowlyhVDBWru/VCRM7tyccQ6e4r/C4k/smGGdtCkvex1GaCM8EVvJsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skidata.com; dmarc=pass action=none header.from=skidata.com;
 dkim=pass header.d=skidata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5hZJTQsjKI2UXYmgGBcu7+48wJYf3FCDWHoJJNnOP0=;
 b=mvwjz0be/DOS4tyGftZeTCXRxqc4ysO6sStW1xjo1ewDMhrTYx6IBiU5S6cTs8vvCuLJxcgDGEnLS+4YYv9Yr0WLkKljqTgh/44+r1GrsNSxB8R4l/DIaDo6ZdLRRHJUQnBYiI5Tk/Qa5MElV/hruzEa1xyyIbJvZf0inbNe6eD8iJOUOmu3Mgiw4C1J2CjndC/OXUXI2PNhKmxCgnU+BW8aHijmhsYfKm4TANYggr2f9RFdEXXhffUMBtcFt9g67Ar4XXH36hviRHmOqyY7VRCH1XeUi+Cu9HMraUWlGS9I/0k7YEwQomh6aivkNj+doW0Q1eZp0X42YhGkhmrLJw==
Received: from ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::9) by
 ZR0P278MB1532.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:93::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Wed, 8 Jan 2025 06:41:02 +0000
Received: from ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b991:5329:d9e1:b08e]) by ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b991:5329:d9e1:b08e%6]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 06:41:02 +0000
From: Benjamin Bara - SKIDATA <benjamin.bara@skidata.com>
To: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "alcooperx@gmail.com" <alcooperx@gmail.com>,
	"yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "justin.chen@broadcom.com"
	<justin.chen@broadcom.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"macpaul.lin@mediatek.com" <macpaul.lin@mediatek.com>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "andersson@kernel.org" <andersson@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"tianping.fang@mediatek.com" <tianping.fang@mediatek.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "joel@jms.id.au"
	<joel@jms.id.au>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "biju.das.jz@bp.renesas.com"
	<biju.das.jz@bp.renesas.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"wan.ahmad.zainie.wan.mohamad@intel.com"
	<wan.ahmad.zainie.wan.mohamad@intel.com>, "francesco.dolcini@toradex.com"
	<francesco.dolcini@toradex.com>
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
Thread-Topic: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
Thread-Index: AQHbYQWEWlB4EXx24Uumc8p7Y3CxpLMMboKA
Date: Wed, 8 Jan 2025 06:41:01 +0000
Message-ID: <cd9b9c22d68658fae36e743a7a6301872a96cc5e.camel@skidata.com>
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZRAP278MB0029:EE_|ZR0P278MB1532:EE_
x-ms-office365-filtering-correlation-id: 07d06fc6-76e9-4b9e-8c80-08dd2faf6b29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm1qaVBlNEt1UFp0c2Y2dDAzSjYxWWlSOHMva1M3K05zTlNhcjlTWmhFeXh2?=
 =?utf-8?B?T0FvdFdjZHdnYSs3aGplSjRhellLQjdTNVk3cURRVTVZRStXbjNUNW85TFF4?=
 =?utf-8?B?Z2VINi9oWDJlNVdFcjBPMXg5Vm5oVU1oZENyczJxNW5yTWZEOWF5SzVrSXU1?=
 =?utf-8?B?cmd4andCSGNZWVlaMVF1TDlGbVpqK0FpRUdIQSt6UlhoWVQyNHNtclByQ2xr?=
 =?utf-8?B?VzhJUDIyL28zaGVqclZ0bW9FOFEyRUtCWnBWYjBpOVdFUDRqWGgwaTdMaXRl?=
 =?utf-8?B?OVBXWHFYY3VKNkdiSU4xNXZLd2l1Ymh3MVFqK3RZYjlWV2NQR0ZqTUI2WVJE?=
 =?utf-8?B?TC9KZDhnZml0blFOWk9pTDZKNjBjd2dwMHdVRExwV1JBcy9ROWFmTHhBTzB0?=
 =?utf-8?B?eTFLb2hlZ0liOVNYTTBkZ0pJRjdLQklwZ0pDVHNtUktXWnZYbWwzKzhsaUFO?=
 =?utf-8?B?eTJsa2NybzJhdXNMcFZ3SURIWmcwTUZ3aUJUK1R0R2d4TFZMbUhTT2RlcHQ1?=
 =?utf-8?B?dG5WZTBhMWgySkRpUUxkck5icDcrU3FTTkhKaldpelZBeXlIRmVwbTBtcUls?=
 =?utf-8?B?Q2N1OHpIb2ZtZjNuOXgyVjZXQ1QvNmVjWkFJY3hQOVJZR0xFZ0xWUHpNOTU4?=
 =?utf-8?B?d1luajJBcUJONy9CUUxIUVJMaGM3Y0hiQ0haOERRYkRocktaL2ZkNDlrN0xG?=
 =?utf-8?B?TUtUenJrOE9jVEl1VVJhRlRvZlhDcmpEN1g4eFJCYjcveDBURmtEdFJnY0lO?=
 =?utf-8?B?N0RDZTBaaFB6ZU9GV1FYTHlqY3A1ZTQzay9pQmF2OEZBNmJRU2RiRk1GU0FQ?=
 =?utf-8?B?YkZ3Qk9jSTF0OE9sSjRDclp5THhlZTJDUmpaNWhHUUZjeWk4MXlNYTE5Wngy?=
 =?utf-8?B?VHBPZXVxajdaUEEva0svbWhwandrMGVaWXUrR2t6Mmp5ajJMNklPZGxzY04y?=
 =?utf-8?B?bkROOFRRa0RMcGZjaEFXSHoxNERsYUJSVGY3Mzd2aFFPOTZzZTRybXA4Smt2?=
 =?utf-8?B?U1h1NTUxN1V6YVRmNDM3ZVNKSmZmODAwOGM4aFF3c2dBaDRtMko1UTF3RUVD?=
 =?utf-8?B?Y0lGWXhxTzlwQjNuVXg0NGZDenhCZTI4OTF2VkZjVkNxb2R2VlhqQm9pVHVu?=
 =?utf-8?B?Wms5YmlBN1BsL3QxWmdraUcxQlgzczhnR3ZhWDJ1ZmxYU2x5dktZN1FzaGlV?=
 =?utf-8?B?MXBnNlMrQ3dGZEpNL1hXTy9nb0NMOTJmaTVxSXZxTHgrSVhMZ3NocVZuZGgr?=
 =?utf-8?B?SjRmTTdDMjVlSzFpMERsTXduRHFaZWhvZXlQQTY2RTNmVXZJbG9FTjJ1eENj?=
 =?utf-8?B?ME1qeW0yVzNHZklTTCtpbWpOQ3RadG9KRjYxYzZqdE5aMDR3Ylh2WmUxZ0tr?=
 =?utf-8?B?Tk4vV3FvRVR2U3BsR3RLWXY5YWhqbzBLeml4d2p2b3oxQ3g4OXIrY2xUR2dr?=
 =?utf-8?B?c2l2ZWt3RXh5d2ZEdU5KT2dqWWs3Y1BVUVdXMUdLdWVzdjcvbFBtbWtJMTZu?=
 =?utf-8?B?VWcvd1RpaXgreUgzaFJaSHAvWlVORzMrZlJFZ2ozc2pMM2tpT0V1T2FSUUFu?=
 =?utf-8?B?VEw4QVh3cUV6ZUtELzJYRlVqd2xERFVKZ0ZXY1BZZkxTdllyZDJaOVozNER1?=
 =?utf-8?B?bTF6dUtIZEVMMTlVaU5jbTcwdmVHSENCZ3liRnFVeXhsdHhFejU0aERNdDBi?=
 =?utf-8?B?R0NOVHJsVDZDRDB0dllwVEpKUktIcC91RXR2eENsRTFIK1VDSFpyVHk2N25m?=
 =?utf-8?B?Wm1UMEFkUnFJa0N0MDVYV2ZRWVhXditEZ1I2cnFwejVOSFFxZTJuZjZKVFYy?=
 =?utf-8?B?eUNqQldnYy82RmdTR1ZQVWY3MWNLcUJURnJFbEw3YmlkelZRWVZhSDk3Z29q?=
 =?utf-8?B?UkxzWkJrSUY3NHFlekdIa2dQaFN4N2dSNUZiRWQrbjRUbEFTSkpwdzY3SlBi?=
 =?utf-8?Q?CvCF/d6aJd02UUadI5jeTNWkCKZFzB5e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzBndUdIeU1ib090NmVNTEVVYlhOb3RseW1LRVp5TTBRWEZ3ZXRFU3FxOHhw?=
 =?utf-8?B?eUFxSjBuc1kvcXM1b3k3dzJhd01iY0ZCT1lPbTZUVHFpZkZGcGFjRkJKOEFK?=
 =?utf-8?B?SFBHUmFRL0d5QmQrMzkvMEMrSzBCWXJ2OFNVMDlhNCs5dFF3MzZLdWdWZjhy?=
 =?utf-8?B?R1ozN1E3clk0OFlUTHFFZDFFdWJzL285UFZBUHY5c0k3TktsaUJyVU1qN0xh?=
 =?utf-8?B?aTFrWmdUeml5WTBIcWxsR3hsU3NDOU5Pa1B3N01FaWpoZHY0WnMxYmQ3UDJL?=
 =?utf-8?B?ZmtBdXdRSFA3Mk1mclErNDAvSEJnN3FDeTVmNmMySWFDSTh2ZStFVGYvZzlp?=
 =?utf-8?B?eEdyc3doeGN2WkJWSDZIcklvamxmRU1GK3dGMVI1QUpQRnBERHJXZ040UUhm?=
 =?utf-8?B?SEZHKzZyWkZrdEt0K3ppYjlNZEFjS2Y4Z1FtTGpvQnhtbUxFN21udXVjbC9V?=
 =?utf-8?B?N21kcVFZTm4yQ3dJeDR0dHVXdDBVMUxyMmpuSzltb1lyVzFtUWxVUHREQWps?=
 =?utf-8?B?MUFDMERzc1N3VFlHejY5NjAzQlFNVjN5eGJ6Z2FOTEhXMXVuWmx4NHk3S0Ez?=
 =?utf-8?B?d0Q0S29KaFdMZkwxcTJXWk45RzA2eldXUjZabFo2bXp0aWRzb0M4NGtRZFRY?=
 =?utf-8?B?MHI2YWM4bEJucVBHc1VDdkRJVGdiTi9HVWp6L3RZNVRmSjFBbmIrNWQ4MTRs?=
 =?utf-8?B?SWd2bmt3QUpkWEgwNGFoT0pMbWF0RGdSRzNGVG5oWkF1N0FmKzRoNEhSNkZX?=
 =?utf-8?B?amhpdHNtY28zMENtVHFRbDhEb0ozbHBkcmh6S1JxUVVGVFBIVFlxU1ppLzhQ?=
 =?utf-8?B?dVZJRnB3Skc4d3F1MEJGajdzaEZBM2VkbDNycFltbWRsLzlSejliSUNVRDJ4?=
 =?utf-8?B?ckxEczhoMmtWcHZ1RkVQQmc0NUpvTnJiMjdFcUpxRC9IYXdLZlpMNWRkVlVV?=
 =?utf-8?B?MVNUZDFwYlRkWGFXTCtidHQ5eks5RHpRRTB5S05QOGFRa3RXcTZpVzY0eWFS?=
 =?utf-8?B?SGo1QTlPeVA0NFhsc2gzL1djbk9CUXhESWE2cDNRdERQVjAyTWkzK3Zma0g0?=
 =?utf-8?B?Y24wRjlTam5ja2tPNDcyTkkvbXRPVFQ0RnFFZ3F3RnZPZk1XaUJWNVVVeU41?=
 =?utf-8?B?a1gvNTdlODVBVDRwSSthSjZVNjZTZ2I2TjE1QWRMRy93Mk1PTlhaTXlHZW50?=
 =?utf-8?B?NkxlUDNSd2Y5SkR6T2xIbExNampJbHdnaGowNEo4V3NNcVJkbHN2UkhQblZv?=
 =?utf-8?B?VEJKU0FKUzhLU1RwZ3lBZE1jNWdVUVNodGE5RW1tbEwrVTQyS3dqS3JBQWxX?=
 =?utf-8?B?eVNsWWUwQkdHZDV0K0x0Mktka2ZzY2tiZGpHSnhnTHR3MXIyM3lCZDF1QzYx?=
 =?utf-8?B?c0lzWVA3TGpMSi9TUytEaVpyeDBPOVh4UUU3MlM1dEh5QmJHT1FrRGRGU1ly?=
 =?utf-8?B?V2pTTUxsdFMwSjM3STEvMzkrem1iUXo0NkFGSG1ncVV2NGVtRzU3d1p0ZUFl?=
 =?utf-8?B?M01uUkdRamFtMm1LVmFhYU5qcXdOLzVvRmpNMEpWRHpDclNYRXZlVHE5UEpR?=
 =?utf-8?B?MjNVQXBERjlZSll0VTgyNE9KWmV2ZUJ1WUVLR3F5QTZJMlVzUjJKcXJqaXVV?=
 =?utf-8?B?ZlZNZzVCczY2aCtDQ2d0LzEyWnBnVG1YWUNlUFFDTXBXRS96VUFMcjRSdHYr?=
 =?utf-8?B?Sk1md1BGSExIT0twdTRyRERSSytTWHRTSlFWbE13TmJHMFp1OTFzQjhJemlZ?=
 =?utf-8?B?Vm5FZW9HK25jekNqQkNydW9kdHVMUGU2VFpsTzZraUtPSm14eDNXTXorMkZy?=
 =?utf-8?B?bWZSVWNaUTBrQUk1L2dIaXhWNStMUnVsbmFnUkEzSlBmejlvcStjN1Ric0hO?=
 =?utf-8?B?UWNCNUpKVXRVZldMOG9Ia2xOMXZtVnRWazh1a29USFNRT0E0NGd2MndZSGhz?=
 =?utf-8?B?Rk0rS0E2ajNrRTRnamQ2NVg4VE5USklBRjJDSXFEM1VtY1VzNlNGbjVHVDFL?=
 =?utf-8?B?L2k5ckREZStodjMzaVh6UmdSZ1MzenBhYmx3MnRoa2djQUxZUEVqTGp4dHhy?=
 =?utf-8?B?WW1GMmk4SGlhdit1UU5SUFk5bkNzbC9NV1puVnZxeHpSbk5iV29zTURlSXRJ?=
 =?utf-8?B?b3NlcVhxV1RpWUNZcExZbGxMQ0M0WEhIRzZxYkMvV095NXpxVUZjdnp4V3pU?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C656B7E3BEC56745864B6DECC90AF97F@CHEP278.PROD.OUTLOOK.COM>
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
MIME-Version: 1.0
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d06fc6-76e9-4b9e-8c80-08dd2faf6b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 06:41:01.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vugqrVXQbiyUNNLBT/dp3MPKd3+EhiLPP9X0nk2HDxD4ZxWZvlkXarZ5t97xwYoZwBqECVdM3gGlKrfkxKLdtmefUpYRqRL877zZdjHg6UU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1532

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDE0OjEwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBEVFMgZXhhbXBsZSBpbiB0aGUgYmluZGluZ3Mgc2hvdWxkIGJlIGluZGVudGVkIHdp
dGggMi0gb3IgNC1zcGFjZXMNCj4gYW5kDQo+IGFsaWduZWQgd2l0aCBvcGVuaW5nICctIHwnLCBz
byBjb3JyZWN0IGFueSBkaWZmZXJlbmNlcyBsaWtlIDMtc3BhY2VzDQo+IG9yDQo+IG1peHR1cmVz
IDItIGFuZCA0LXNwYWNlcyBpbiBvbmUgYmluZGluZy4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlcyBoZXJlLCBidXQgc2F2ZXMgc29tZSBjb21tZW50cyBkdXJpbmcgcmV2aWV3cyBvZg0KPiBu
ZXcgcGF0Y2hlcyBidWlsdCBvbiBleGlzdGluZyBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KDQpB
Y2tlZC1ieTogQmVuamFtaW4gQmFyYSA8YmVuamFtaW4uYmFyYUBza2lkYXRhLmNvbT4gIyBjeXBy
ZXNzLGh4My55YW1sDQo=

