Return-Path: <linux-aspeed+bounces-3697-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267BBFB5E97
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 01:36:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZZLW4Fr9z2ySB;
	Tue, 17 Mar 2026 12:36:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773711395;
	cv=pass; b=cimSeToHXsp5RG0eYiLodC/O0JbhpO+4ta1ijaoZkWs3G/Jhb1B1/1zt2s2nzwsgwVanbWJAy+GAhk+x2T1eO9T8wmd2Mao1Lyl6fNCrNatt1atI3ONfXErnDvm5dROD9lY8ufqE+6HsgG5UuRV7z4Haj854aE76+VmaXD0Y0Besq0ueZeH1Ivxaug3xvXbdS1rblwD0TASFFY6xAvlzQrjDxqWPNi7l60CIUSZk6OpPWibJ3ridn9ZW2OeNW3IC55shOOKb5+k8fkFXvTq2Unp5GhPzaESHVfBQh1PhY6/xRjs4w6dxpe0YllahfYkunLKYbpW8mMSh2RrNBs7GPw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773711395; c=relaxed/relaxed;
	bh=3vbayy1Htg1L9UjO3Q/6mEriyJ1xZ6mj4sx2w3MalN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZmnbwr0maMpRy+PnjobK7xBgNnnjmV+T7wwG4TS5xql1GBbvU87VaB/PgHz7lVuAjjz+lpie8w474fUlO32iVGA86rJh9ndsgIfZ+dUWmzBdcd65qzv4gHXshnD69G0Bw+Rx+JpB+4gIN3ppLgNaAs6rcoGMksYvZeaMo1HKoUdzcG+Ae7APe9lOKuw0LMKSy/Wa3OS6PJjeZZpuHWQqgvSrJ2edy90Dr59om4AmJjdGzqNwMQG5L5nC+UEAG78E1bl4JRqpCuGFQjjnY7Zv6NxaeQDtvLCslCmcpxpiaz9MFGOTqEKsOWrx1PtPllCTDfgbffqY2RuHWSbEtsLhA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NQdvRjRq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NQdvRjRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZZLV1Y8Bz2xS2;
	Tue, 17 Mar 2026 12:36:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAAfhustH7eaLCSNwdqRZ/7LzmZkCfKzVb2nw6ga3vGiLcgyJj+0grcJOF40N7dk+L+tU3bKTt6cWHSGPkZNxoo7+3JVE8tqpSd97ow4rVJ4+Kg+HYHQkBYQBGDZXNgYy4MGyaiI1ai1QOItlIo80NL1ggwPqTFZdUlhUhCqij4sVzddL6mG4X/OpNt3+tuCo7QgW/BALvJXPIcjAL/ytdSMz3S8Kswjena+nos8wNPCkbbpTg0rbCTjPwEi37oR9j0KOQK/neJDiiIqKV/7WPJQ/4MyNA96KrqmAIivOaWHoBkQqcY7v5YHZawRD00YbKRH2by96q0RWobRG0rStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vbayy1Htg1L9UjO3Q/6mEriyJ1xZ6mj4sx2w3MalN0=;
 b=X9edxAssquNww4puELoflFTRRpyB9H8DTdRH0kF8ktwDf1DSdejT7v4VsJaFRBuw0YWdhr2xdf1QcMfiJNx68SQna7KDiuo+4lq3wj9Dg9iUwzwkIBjVEGXYHwRW0l8uLTsjiJehBvuhL6KI+jNuzBtSJtfS/vzAjl2kQ302e8jrNgxLYAxGY/mH8Piin1aEWL4cE7PIupyJtNnPwMsZ5ppYzY0Ikn4JQWiuxjHrxlaFL/KQfP3emDBq7K/mu2YV67u9oMvbIEE/Nvwld0SFyvZw3egBFtgYYekvYqlYOkx4eCjCiYuRPsWeHLfl8s5IZ3gkmCwRI5axoTJSXJGlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vbayy1Htg1L9UjO3Q/6mEriyJ1xZ6mj4sx2w3MalN0=;
 b=NQdvRjRqJyHitZICrvdpZBiBFvJv2A5s+nv6qztYfrvjdVeHG4bBlCULiOmsKUsSV/IBjIGIDVMmuXB4Y0cU/5zgqhVG7imJ5PxNHAWiGB0Sw9n3TkEZO3odBuNP6X+OgmnO/02OR5C050LCAOrWT52kYk1Kqsc1yz3pyQBzG/uMs39/rx49TCDPxKZSC6UlMdXsMU35KzhQoyKarBIF5G91EwdKAHG/vl+Tw+XpthORBqttzTt1kfAjodByRN0tFbRmRnFGnTAY0wHc5UfBxnyBzwMm0reWQifv48TkBse6D0nteqindKiLdlPWWW9lUVnUYpa8qZypKGv00bHSFQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TY0PR06MB5635.apcprd06.prod.outlook.com (2603:1096:400:277::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 01:36:08 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Tue, 17 Mar 2026
 01:36:08 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Rob Herring <robh@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Topic: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Thread-Index:
 AQHcr5GE+hDVSyX/WkC7T78e6kO8trWtIRWAgAAQdrCAAz2mgIAA+smAgACHbICAAAQtoA==
Date: Tue, 17 Mar 2026 01:36:08 +0000
Message-ID:
 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
In-Reply-To:
 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TY0PR06MB5635:EE_
x-ms-office365-filtering-correlation-id: bc74be68-10af-4f51-19c9-08de83c59036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 lZ00IKBr2YPoVGD0+e6KbyuS08BEkPuFlxunxJauvnmrpokGLhnyiNSKb6S0Wam9MfJwhsWk63VNnqXHT1NIdIwOWX9FQyyu+rJz0p5olKM472HZeGrpyem5t1jnzeClVgRDOXDB1PlyMonVxUq/eOwUipDwL3jfaT84MFDCOymi5SC+rOjvzc8eDmA0KYYqD2+ncCuSbwQCIABPVGHHSc40f0Zq2Buo36j7I4r7E/Zuqrpjt/jiTyPviy0wXXJhKXWeMYZ22vWg3uraf560uzXMEh6V2bmBNF6DetoP3ZpTh6SDnB3CYk/SvU+eP+G+mw5s/bAiQTHQRqgeqjRkftf6wgiLwh4d4tD4V069sHpm/eiT+r9M998Ig/RzSmiaWIBP8cWh9GiRI58S6DLDGmCavR17/5SRevOWk4JNFcADDsTZot6HoPYgGgbkxYKDzChR+i1n7arM4MjeVZzIgJl2pR27gUy1ndyWzjKvJ4P20TUQhXJzJKr+AXrU77n/Q+iofQwZPW4lAaheaL5f1Fdl/8KbZGDnoDrSn/TFUT2lwPgfGeZ2HG74VI+s8mnefA+Xzs/q4IBe8zTQJqLdzoKs2fRCErAWFUNR4qjmXeNCrUuQQOQSzOFTaHiCStmpoQuiDV5JvwImtEpttFah1NCOre9vaUWia8rJOU9YjleZYjShgb1Wz5ZXbj20ogV84tKQua2GLilk9cAX5FKUu4dcLWTFITRTBKah879ZkWC/M4pj0qT9OS/EbwJKlwY+zAIR1X4zK9TpERAOErO17y0oEvl/VxDe+OCkH0kLZcs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWphNXVHKzI1TEhNZGxPSXBUd00wcmlodCtmWU5jQ3ZweWR1bFdGL3IxVDRz?=
 =?utf-8?B?NXpGZzd3N3pnRG81WHVhbU9jaFRLYVRJd2RHRVpMUXkwQUt4QmhuM2VSelFE?=
 =?utf-8?B?QlJ4eE4vWnBaUFZ2azVIcEplZTUwRUxjaTlFWnRlVm1tdDlhSzZ3SmpUUUxq?=
 =?utf-8?B?U0hIWGNsYk1obEw1M3U0L1hmaENUWWNqYWJJMkRPWEhzb1lSdTRLZnI0MGdE?=
 =?utf-8?B?N1NSSzVLdDJlRWRsMUJTVTFrSVZieEZMd1BUdUJ3T1YzOFJOdFc1cGhUY3M4?=
 =?utf-8?B?c21pWmVUUDYvOU5PZVdhR0lsVldGQU9MVlNVd3daUUgxYk1nWHZoQk1nTXlL?=
 =?utf-8?B?SkV5K0NTSEwwRStUTTRsMldHbjlTempTWEx1TVVLQ3pVdXZQU2xxaFY1ZWlM?=
 =?utf-8?B?SDExSVRSejNMeXJkZE1vaWxPQU90b1ZBRFIrRjZQbXQ1VCtzbVpkdG9JVVRM?=
 =?utf-8?B?RFBIVkZUR1dIdXVPanJPOTZFSzRMaFVBeFgwcWFoOER2SU45bEtURHkxSTMz?=
 =?utf-8?B?aVFsaVh6azlIMGhsUk1sTnZFVU80dkpmZllvM2N5dmg0U2pnVy9JeDVMOGR2?=
 =?utf-8?B?bUtHZkpNeEpDTHhDT0JRdFBZSzM2NzZYU2lTL3VLZ0NoaFVkN3JLU1VFRmZU?=
 =?utf-8?B?a3ZQd2c2L015S3BFRE0wUFlicmRSa3lzTkhoS1ZxVUNHdzJRdGNYSUp4alBy?=
 =?utf-8?B?bWQrYlB3anpjMnd5eWpVZWJxdWg3b0dOaEV2aDRTRGpRY0ZDNWY0cmJXNXQw?=
 =?utf-8?B?bGpiWC9qQzJwZ2VaZjJLUy93VzRRSkRRMWt0blVyZTZrYit5amIvMnphbkdZ?=
 =?utf-8?B?RzByOGJWamI5VHpCSVRTNk5DYUlROURqL0tGckhwUTdzUUhUNVJCb3Vpdmh1?=
 =?utf-8?B?UENIM1cycnNHTUFnd3AzWW01ZE5SMXpFTC9WRzh4WnREYjNWVlZ0bUlKdVdQ?=
 =?utf-8?B?K2dDWjJJL0ZXY2hNdGRvamZRaVFYd21XSm9rRXhueG5NcHI0dU40T1lCbTVl?=
 =?utf-8?B?aHNkTnB5OG1lMkt4NW1RaXBhdmpDUWhzT0FWbHIxUy9pN21SSFFmNXhwL0Jv?=
 =?utf-8?B?RU1YWmlBQUJoL2JDL2ZIbjBRYkpicS9GdDlyNHZNY0Q4YTdudUEyc01JOHI2?=
 =?utf-8?B?QTlVM0I2UXV6WmlWMXpETHIvRTVWdEJaMlhKQ0tKZi9keVNlMWRzYlhYVUgr?=
 =?utf-8?B?K1dzeFdtVmpMemQycTZLZUh4eWtGcS91WkhHaUxBUldEb3VINnQ3QTdQUnlh?=
 =?utf-8?B?RmlqUmt0b1ZWNkFCWUxmL1pXVHNGYW9iTWVGWkc5NTdTSEZGTXRzSTFIb3I1?=
 =?utf-8?B?YTRXUUU0MW43VjNQbFlNMFEwU3Z4WlliMzFBd3ZBMTFzd3RQVlB5VmNhWlU5?=
 =?utf-8?B?Mllpc05pU21sSzVoRi9Zekk4dDVRUTFVOGN4cnhxUjJCR3hvTEN1QjRaZWUv?=
 =?utf-8?B?VGhkcFd3VElDT1hldlAxSFkxRFI5TnRWam1uSjlSUEYxS0ZmK2lOYk1BK1dI?=
 =?utf-8?B?cy9JWHBDSUU3d25JSHNqQjR1cDBLekRaVDJJdW5KZHRWV1dlcFc3K2d3dk5j?=
 =?utf-8?B?NWZXS1pmTEtzSmNSSm9rNFFpUWFQN1RDcGEzVkRmdlIyS2lmeGdEVEpmWi9v?=
 =?utf-8?B?aEplTUxYRGpwK0haNlN5aDZzUnNWLzJ5eG5DSzkzVXl5U01hQjdsVGgrVEs3?=
 =?utf-8?B?eU1RcVYxZEQrVElHYW13bkFIRGVHYWJQNVRDa1F3VTV4VHZYV0M1dktEeFM5?=
 =?utf-8?B?OVl6TFFUWElqdHpreDJUL0FFM1Q5RFJzODZOTUNXSzUrSGZqM0hRY0ljRmVy?=
 =?utf-8?B?Nk94Sk0wblppUGR5ZGY5NHpXTThMUmlMbFYzblI3eXdLMGdreGJlMks1bFBC?=
 =?utf-8?B?VklYNVU4b3V1dDZ6WnlvTVhlN0RPL1hOa1BwRC82KzlQRFRaT2pucS94M0FJ?=
 =?utf-8?B?c1lMUmhxQjdwR1JGd21qQzd1SDY4a1ZrMmtuRFRKeWRpSEs1czhjdWszakdE?=
 =?utf-8?B?NXFYME1maHhDMWFzelM0YzROditmVXgwdmpUM2Yxd0Vrcm5DWGVXKzAvUzRq?=
 =?utf-8?B?a2l5SjNvM1VDMzE0YncvU2t6czducVRFS2p0Wldnc1Z0K3FDbHZoNmdRUEVB?=
 =?utf-8?B?alNOelg0YzZsYXc4WXBsZ2VVMUdmNksraW14M3FvNXN0Ym1EZS95Tk1GUlNP?=
 =?utf-8?B?SjBwME9jcSsydjl2QlNqSUpFdXk4R3hTWEZXYVpWS2ZHMTFnVDAxSVp4Sy93?=
 =?utf-8?B?Ry9WVWdaSTlHYm5ENzlhM21mWW4yc295NjVpdG10QThYenBpNzI2OGlXdjNP?=
 =?utf-8?B?TUdRd0haeU1wbEFQSGxLa0h5NUQ0N3RBYnBOekhoUWtoM2l1cnBLUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc74be68-10af-4f51-19c9-08de83c59036
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 01:36:08.4391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RtTPONFldxlf9IkTvluiQWkiT92Zd/FyaGAHwdIBjwlRRiIkYWOyzwK4GaV/FPnYA/2G62R6VAtsv0Sqr8jOq8My+FrHdcco11HnrR9qeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5635

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyNiAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgdHJhbnNmZXItbW9kZSBwcm9wZXJ0aWVz
DQo+IA0KPiBIaSBSb2IsDQo+IA0KPiA+ID4gSSBkb24ndCB0aGluayB0aGF0IHJlYWxseSBhZGRy
ZXNzZXMgUm9iJ3MgcG9pbnQgdGhlcmUuDQo+ID4gPg0KPiA+ID4gVGhlIHNlbGVjdGlvbiBvZiBt
b2RlIGlzIHNvbWV3aGF0IGEgZHJpdmVyIGltcGxlbWVudGF0aW9uIGRlY2lzaW9uDQo+ID4gPiAo
YW5kIHNvIHdvdWxkIG5vdCBiZWxvbmcgaW4gYSBEVCBiaW5kaW5nKSAtICpleGNlcHQqIHRoYXQg
dGhlcmUgYXJlDQo+ID4gPiBjb25zaWRlcmF0aW9ucyBhcm91bmQgdGhlIHVzZSBvZiBoYXJkd2Fy
ZSBETUEgY2hhbm5lbHMsIGFzIGNvdmVyZWQNCj4gPiA+IGluIGVhcmxpZXIgcmV2aWV3Lg0KPiA+
DQo+ID4gQW0gSSBzdXBwb3NlZCB0byBnbyByZWFkIHRoZSBwcmlvciAyNSB2ZXJzaW9ucz8NCj4g
DQo+IE5vdCBhdCBhbGwgLSB0aGUgbmV4dCBwYXJhZ3JhcGggd2FzIG15IGF0dGVtcHQgYXQgYSBy
ZWNhcCBvZiB0aG9zZSwgYnV0IFJ5YW4sDQo+IHBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3Jv
bmcgb24gYW55IG9mIHRob3NlIHBvaW50cy4NCg0KWW91ciB1bmRlcnN0YW5kaW5nIGlzIGNvcnJl
Y3Q7IHRoZSBieXRlIGFuZCBidWZmZXIgbW9kZSBpcyBtb3N0bHkgdGhlIHNhbWUuDQpBbmQgYWxz
byBtb2RlIHNob3VsZCBiZSBkZWNpZGVkIGJlZm9yZSB4ZmVyLCBkdWUgdG8gdGhlIGNvbnRyb2xs
ZXIvdGFyZ2V0DQpib3RoIHVzZSB0aGUgc2FtZSB4ZmVyIG1vZGUsIG5vdCBkZWNpZGUgYnkgdHJh
bnNmZXIgdGltZS4NClRoZSBvcmlnaW5hbCBteSBzdWJtaXQgaXMgb25seSBidWZmZXIgbW9kZSBh
bmQgZG1hIG1vZGUsIGFuZCB1c2Ugb25seSBvbmUNCkJvb2xlYW4gcHJvcGVydHksIGFzcGVlZCxp
MmMtZG1hLWVuYWJsZWQsIGJ1dCBzb21lb25lIHN1Z2dlc3QgYWRkIGJ5dGUNCm1vZGUgc2VsZWN0
LCBzbyBJIHN0YXJ0IHRvIGFkZCBhdCB2MTcuIEkgY2FuIGRyb3AgdGhlIGJ5dGUgbW9kZSwgaWYg
dGhpcyBpcyBjb25mdXNlZC4NCg0KYnl0ZSBtb2RlIHJlcXVlc3Q6DQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMDEwZTU1ZTktZDU4Yi00NDRjLWFiNTctZGRmOGM3NWYyMzkwQGdtYWlsLmNv
bS8NCg0KPiANCj4gPiA+IFtNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIG1vZGUgbmVlZHMg
dG8gYmUgZGVmaW5lZCBoZXJlIHRvDQo+ID4gPiBzZWxlY3Qgd2hpY2ggaTJjIGRldmljZXMgaGF2
ZSBhIERNQSBjaGFubmVsIGFsbG9jYXRlZCB0byB0aGVtLiBJDQo+ID4gPiBhbHNvIHRoaW5rIHRo
YXQgYnl0ZSBtb2RlIG1heSBiZSB1c2VmdWwgaW4gc29tZSBzY2VuYXJpb3MsIGJ1dCB0aGF0DQo+
ID4gPiBjb25zaWRlcmF0aW9uIGNlcnRhaW5seSBkb2VzIG5vdCBiZWxvbmcgaW4gdGhlIERUIGJp
bmRpbmcgc3BlY10NCj4gPg0KPiA+IEJ1dCB0aGlzIGlzIHNlbGVjdGluZyBETUEgZm9yIHRoZSBi
dXMsIG5vdCBzcGVjaWZpYyBkZXZpY2VzLiBJIHdvdWxkDQo+ID4gdGhpbmsgdGhlIGRlY2lzaW9u
IHdvdWxkIGJlIGR5bmFtaWMgYmFzZWQgb24gc29tZSB4ZmVyIHNpemUuIENlcnRhaW5seQ0KPiA+
IGlmIHRoZSB4ZmVyIGlzIGxlc3MgdGhhbiB0aGUgYnVmZmVyIHNpemUgKDMyYnl0ZXMpLCB0aGVu
IHRoZXJlIGlzIG5vDQo+ID4gYWR2YW50YWdlIG9mIERNQS4NCj4gPg0KPiA+IE9yIGRvIHlvdSBt
ZWFuIHNvbWUgaW5zdGFuY2VzIG9mIHRoZSBJMkMgY29udHJvbGxlcnMgaGF2ZSBETUEgYW5kIHNv
bWUNCj4gPiBkbyBub3Q/DQo+IA0KPiBZZXMsIHNvbWUgb2YgdGhlIGNvbnRyb2xsZXJzIG1heSBi
ZSBhbGxvY2F0ZWQgYSBETUEgY2hhbm5lbC4gQSBkcml2ZXINCj4gaW1wbGVtZW50YXRpb24gbWF5
IChvciBtYXkgbm90KSBtYWtlIHVzZSBvZiB0aGF0IGNoYW5uZWwuDQo+IA0KPiBTaW5jZSB0aGUg
aGFyZHdhcmUgaGFzIGEgbGltaXRlZCBudW1iZXJzIG9mIERNQSBjaGFubmVscywgUnlhbidzIGFp
bSBoZXJlIGlzDQo+IHRvIHNwZWNpZnkgd2hpY2ggY29udHJvbGxlcnMgbWF5IGNvbnN1bWUgYSBj
aGFubmVsLg0KDQpZZXMsIGluIEFTVDI2MDAgRE1BIGlzIHNoYXJlZCwgc28gaXQgb25seSBjYW4g
ZW5hYmxlIDEgY2hhbm5lbCBkbWEsIG90aGVycyB1c2UNCmJ1ZmZlciBtb2RlLCBhbmQgaW4gbmV4
dCBnZW5lcmF0aW9uIEFTVDI3MDAsIGFsbCBpMmMgY2hhbm5lbCBjYW4gdXNlIGRtYS4NCg0KPiAN
Cj4gKGluIHJlbGF0aW9uIHRvIHRoZSAnYnVzJyB0ZXJtaW5vbG9neSB0aG91Z2g6IHRoZXJlIGlz
IGEgMToxIG1hcHBpbmcgYmV0d2Vlbg0KPiBpMmMgYnVzZXMgYW5kIGNvbnRyb2xsZXJzIGhlcmUs
IHBsdXMgYSBzbWFsbCBhcmVhIG9mIGdsb2JhbCByZWdpc3RlcnMgd2hpY2ggYXBwbHkNCj4gdG8g
YWxsIGNvbnRyb2xsZXIgcGVyaXBoZXJhbHMpDQo+IA0KPiA+ICBJZiBzbywgdGhlbiAuLi4NCj4g
DQo+IFsuLi5dDQo+IA0KPiA+ID4gSW4gdGhhdCBjYXNlLCB3ZSB3b3VsZCBqdXN0IGhhdmUgYSBi
b29sZWFuIHByb3BlcnR5LCBsaWtlOg0KPiA+ID4NCj4gPiA+IMKgwqDCoCBhc3BlZWQsaTJjLWRt
YS1lbmFibGVkOw0KPiA+DQo+ID4gLi4uIHllcywgdGhpcyBpcyBmaW5lLg0KPiANCj4gQnJpbGxp
YW50LCB0aGFua3MuDQo+IA0KPiBSeWFuOiBJIHRoaW5rIHRoaXMgZ2l2ZXMgdXMgYSBtdWNoIGNs
ZWFuZXIgYXBwcm9hY2ggdG8gdGhlIGJpbmRpbmcuDQpUaGFua3MgdGhlIGZlZWRiYWNrLCBkbyB5
b3UgbWVhbiwganVzdCBvbmUgYm9vbGVhbiBwcm9wZXJ0eSBmb3IgbW9kZSBzZWxlY3Rpb24sDQpB
bSBJIHJpZ2h0Pw0KDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiANCj4gSmVyZW15DQo=

