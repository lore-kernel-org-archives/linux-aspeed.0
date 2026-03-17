Return-Path: <linux-aspeed+bounces-3699-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40725FB5EA1
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 01:49:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZZcq5LYYz2ySB;
	Tue, 17 Mar 2026 12:48:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773712139;
	cv=pass; b=P5OKujxHjwXVBObW6LpH2/vAVvx3t3v5j0Lx46ffu3EN/Z0gqO5YMThx/tnO9HzIlPygTFfWECyO4fNL98r1qlQkq3tkr1ZrhW/CTSFnPrZh6B2tqzC0rol7twWuYtLwM4ci+My56ROzSGfITJwhmnbH2MPkCnCawtb+wOWudvnhyhHRxCy8IJY4B1BUGduFYasWknT3bWlH0spEcR5MTz6/sct3m9nhnjQX9CMOVYweuYzfZQ0orAn/NsWDvFTUR12KpJVud4hqLS5QVE1o6QP1kNv5ijYcXciBykOrTey4u3zcb0M+UGGBuHNlVfMVEII4MdMEiL8T7wV8axEQqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773712139; c=relaxed/relaxed;
	bh=JgqFYsiQ97eafudpKRP5OEjNfN9bWYeqrXSJV+NDqV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XFDR1C2W02tFD/qdHGw+whQtAQJBCNTSkKuYeG56YSwKxUhzhbbc4HiKRycfNUOAt4SiU/RQ4SUTl0EzcFY+suxF6XfbBxIKiOl0aUaS8G8OI0Gk5ZaoRNr+XToH1nkJYouKuoguSnTAc2yBQh6zteddGHxCFyzZk63oLXH2388Q4FNqZZ70Ke/DMezdtIypL2AE2+AgDpJp3/+kXWOlZKXH8tUgjPb62Ze0zGKdadi/Am90u42EOULKqOw6mHQZXLm4iazbiCkzWRzxt95sQjUV7K0YnzNQP/jznUJV46w9Sk3VmXW8351qLjo4WJlqm7krweAQJqIZte36CgAZWg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=RqL/thTF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=RqL/thTF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZZcq13KVz2xVT;
	Tue, 17 Mar 2026 12:48:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF1on0JBn9vAGx63LbWdYMMtxma6rbwSEmZDdPpy0g+SUr1eYMMnjiMhNyWnNtsdYbZREfO3YfK5kizasgAnAi8WjsVZGqFL9I1/nk30GGMEbbmdjarPfNkvyUy/EKGAZ/L0vBZso3RISw2s4hkU2BoU+NJWTsQNwMSoJhfGT7OHblJliMpruvSov4JMjzJRZCtifCClPl8La6eT2Soh/igfq3unuvNIN8wqhPLCgmqmvr0fLRECi4+vhlZUy+1csyWKWSjWSITXe95IughaY24p5a4WOC4KqUBbxAUfiZpJ7xAbpo2jGvEANTZdwqMfmVmQ3T2UIYmrBWZIpQEqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgqFYsiQ97eafudpKRP5OEjNfN9bWYeqrXSJV+NDqV0=;
 b=j45TZRneYg1TUg87K/b0f3AKyxrp1WLHIVLJ4vo9NJVG9e6dokyPEzAJFaG4ee/bxkfsZ6swSCOWM44kiVxS1by6pqVqw4QIlGmYIt4ObmK+kvVYodhRHgAUcI2DDpfF0jQMPZE26Y5OIBB/47MxQGlA4AgdvoBgAa9YJGFiztAnFevcmlUmelw0nxGxV29g0Lfss0d6F2IIgux0vGzUm0et2l7xVWyhuwbieLBy6+vaAms8ohhJFyOnfthHHnUhrnRRsHRthBiCmzrL2EyynVi3Df+/CEqUnOzrdQoYA0nwO9x8akXUR0jpEsTXlT/PwNrUrJGxurVIT0JAEmuweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgqFYsiQ97eafudpKRP5OEjNfN9bWYeqrXSJV+NDqV0=;
 b=RqL/thTFlyrVA/bfCb3VaWiWnv1ViRRXxv+wlknbMhdoLO8tB6VcPSFDVlae98OLUV/vQm0f21z5f2Pg4M1AxSMrZ3qRUEJcAa5h3dnPPQMm9Sm8q5OLQAJkKkn/1IvklQNAlrhmH05TuAmsib1iDAoFoVZ3azyjEDSA1yIW8hKgOx1wAq3z6QOxkbmezhuJ3X+FnyO7SH3Vnptvb3Qpk7B6fmzyRastL1BSmVm/Orxkf18TPfmp/MEVVrqaLLoCgc+U66VTwtI6eS5FIRZZxAVAiLXObDDEN1x6Sv3xl9TYx7oHnxrfEWql9hNzCCFZwADN2gk78ertmk9DlDCqOQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYSPR06MB6899.apcprd06.prod.outlook.com (2603:1096:405:35::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 01:48:33 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9700.013; Tue, 17 Mar 2026
 01:48:33 +0000
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
 AQHcr5GE+hDVSyX/WkC7T78e6kO8trWtIRWAgAAQdrCAAz2mgIAA+smAgACHbICAAAQtoIAACkqAgAAAdeA=
Date: Tue, 17 Mar 2026 01:48:33 +0000
Message-ID:
 <TY2PPF5CB9A1BE6D9A83DFAA004E795A5FCF241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <9dec962eb510d947a458fd2318a3812d58b3553a.camel@codeconstruct.com.au>
In-Reply-To:
 <9dec962eb510d947a458fd2318a3812d58b3553a.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYSPR06MB6899:EE_
x-ms-office365-filtering-correlation-id: ac1a01b6-84a5-436d-1821-08de83c74c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 HfuFJmf3zv4l3rZo5zatmn705gtt+3H7cLocB5jqn6W0pNYBvJWV4ug5nreRyKKvjVeNrrROxUXwTanqoXT9GRDxy3Dgq3Rt0zdBGRwdXBWAgu7dWsbQk3qrxEg3L85JNeQ4T4AUQ4tvO+8ZjYsFWDk4GvxPeFONaypI5e0BwD5pzPcZtsB5hBfYsjPuVfnctJSe65zHYCq/sbdkbH5YLw4J7rEpuQmfI8ttKVA4k9Tv3C38rclPfS0DU56BPZIj0Hg1KK/Kc2TBt6OB3ylUMvvcOVhaX0nPiEY7zHRQGFDtfBgFl68jxfefcI9atyM0k/0PJxkxQbper2n6jzKkP6JkqP2YpE4AEHnMyayNtsl8UaiLd6e5jlXRrUsLWBTsrFew79BkG6CAwFiZGgffnEX60bGTyVJDDw/JTw6xjYrmCVIZsvvGAoGR9fzTkaoAuBj3N9B9tDfb3FNCFof/JqetZylNhLdoZigNebYjJ3P4YUSvw5VcSXVlVkNqH6WkYPXqArxIoxDQ/vZAydyMUkKFSwdSFPQlspAZK/23LgNqIpLoCj5SSo/zLt5tEbmVhup64yFTOdcqf0V5CmHix8uEOExwHOhz54/GT8nCCU+7g/l/vUjr4FcBTNMoRgfHMoA2arOca6hxLvbku6CVzTo23q6Dh63PgXMNJUGdA7YIB1QILz80RVm6BcZ8fnL3m4Jdop8j7rfxM1BCtLU0SA13kxSCnR7V+0/8x6VnSL98zXF6jcd8G3sq/NL91crH0tAONiuTAA1YYKkenOLAjz7LqoE7hYA4toAsBO4lk5o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFJ4RzNDUkRrdVp4d3N0Q1hUZnpzSzhWcVlKR2lzVjJlcE41VGpydkRGL0xW?=
 =?utf-8?B?dFRPd1loOGV5V0RtcW0xMDJYMEJHRDJNUU1aK0NZU000V0pLMWZ6c0ZWLzJM?=
 =?utf-8?B?dE5CNUJLV2NENUZOeHlZZ0lROXVKUmJMNllyZytHRlBJVEVRaW9LT3dESkJt?=
 =?utf-8?B?Y1kyYlQrSlppUG9KTzFLLzRxZXBORkFUMVNUaUZRVWJucE1HWXplYWRhb3Ev?=
 =?utf-8?B?MDlIWVB6N3JWWSt4K0xZYWxlY0xLUDdaVDNuUHNkc2ovRTZ5MlBvc25GL3Fx?=
 =?utf-8?B?V3duNnBUYWt5WGxnSlJVaElGTldVQkhmeTBEeGZ0aVY4SGJUWnNyaVVibXdh?=
 =?utf-8?B?R0h6cDBSZmJENVV6VVJOVmMxb1dYZUR4TnR3U211Vm9tbFBGK3B5c250dDQy?=
 =?utf-8?B?MmE3MEp2RmFzeWdsVGNoTVB6a1VjUkQzaHhtTjlxM2Z3WXhnSmFFU3dCbmhI?=
 =?utf-8?B?SFROTE1tRnpuYm1yKzNFQmU4bjdsU2hJYWdMWTFsdXl6NEtCSi9wM21ocGVp?=
 =?utf-8?B?cVlwK3Nlc2FLZmFXVmZjb21wK2JiQXN4QWhYVEUrVjVVcnM2MTJSWWExMEV3?=
 =?utf-8?B?MCsrNGVYNTNYRTl4K2hyVlIrWWVDeFVwcVZFNWszbWd5cysxS0J0YjlMYWZP?=
 =?utf-8?B?VHZjL2hXT1oyeEFQblVYdFhuTlRBdktmNWF4VjFCSWl1R1dMamJNS0JUb3Fw?=
 =?utf-8?B?NHJOaVB5aVl6Ukh3NWg0M0FZczdEV0NGVDhMR1F5SDZQcHFib1E2ZGJJR0gr?=
 =?utf-8?B?VGZZSUlyUUVJaC9hNVhpc3VnV2R2TWd1clBlOEw3bEN5VUsxTlVaQytqOTRB?=
 =?utf-8?B?MHhVRVdTYnB0Q0lBNTZYT1BVdzdvZGdjbGs4OXBWNmxwOFFra3lWZEEzVEJl?=
 =?utf-8?B?YjFHV0FKbGo1QzJrSWlWc1RPMzRMdFYva1Q3cE51aFgzUGFlOXRNNFdubkx5?=
 =?utf-8?B?SDFBcFJtUGUvUmprVEdYNFVPeUx1YXYxUWxyOHV3MmNWTVMwNnFvRVg5eFNU?=
 =?utf-8?B?TnhPSEd1TkxDZS8vekYyNGRVbjRRZmYvNzA2ZWhPdEZnUk5XVVVGajRHR2s0?=
 =?utf-8?B?UUJNdTdjaEF5djNvUS9rdExTa1A4dXRYMndJR2JGN2RRYWhyRTM2UkdHeUY1?=
 =?utf-8?B?Z1RMYi9Sc0tUUW8yd0twMGE0ZU5zamxrNHRrdmg5UUVrUktYWDAzNkZBTzNh?=
 =?utf-8?B?eTZhaDR2aitDVjZnaW1uOFQ1aTVxV3RjU29Nem82TU1DYXgwdnpIT3ZQRDIw?=
 =?utf-8?B?U05sMXQxS3c4TnpsZkNKUUU3ZTRvelNRY04wUWJrUzJLV3JUKzRkZDFYeVJy?=
 =?utf-8?B?dklDTXNiUDQ2MEwvcS9zampYTVRYZFhYeEE3d3VIS1o4TUVKZDM3TzlBOVdX?=
 =?utf-8?B?SEdCQy80dzhEM0g1UE54Q3VzTVM1SjJvbWlSTXJuejEwT3UzblkrbFQ5UkV1?=
 =?utf-8?B?N0pyMG5HLytlV1ZNdVAwSE1NZ1RPdFU2TTVad1VSaHlJVnA0WCtVdXI2aEQz?=
 =?utf-8?B?bUdOM0Zvbkg2TWdvWlJVZUI2YVZRRElBR1g4K3NVVXNjSnE3VG5WVnVlTWdz?=
 =?utf-8?B?OEhnelpNRkl3aFhsZDhocElGcTEyOS9jTmdFTW1tUFNndU5VdDBSRVl0WEV2?=
 =?utf-8?B?Z2VNOVJUVnNPTitDWjZ4K2lMSFhDU3pwa1gwYW9ydm9Td0dKTEZFV3NVZzA5?=
 =?utf-8?B?WmEvcVNSTUZURHg2OGhWd0doMTVSV3ZFSmpwTEhBN0oxSTg5RGpnbUxwNlFU?=
 =?utf-8?B?dnoxQWFZOVpWakJtNm1BbmV3Z3Eva1hHL1B0OVR5MWtYb2JQTWRPN0o4cUFR?=
 =?utf-8?B?V1NtbUR5b21jcisveXBZamRKY3BuaDF1clZnY1dGSWYrNlJQdENhQTJhSzJB?=
 =?utf-8?B?bVpjcGtFeXhaSVhKY2hnUk1aRkN6WFNsOEhGNW1LOHJRc1c5SEJNT2wzUlBM?=
 =?utf-8?B?Tk9aTjVraEU0ckZVeVNiRWZ3YllIbUNYdHd4S1V2TlJ5UVpvRTR3dWhCWnFj?=
 =?utf-8?B?RWxMQ05rb2FUTFpGVTB3QnZKRjJhZDJOcEFlYjEwOWlEUlRrNkdaZzdjdERE?=
 =?utf-8?B?d3VBUFNXdkpoU1RLOWxHQUxiNVl1R3lua3JZV0FBNTBWNDJtUjNBSHJRZFZy?=
 =?utf-8?B?M1p2eUhlYUZwNWFJRHhRbSsrZHgza3pWN05VMkpMdmFEd1MvYUp1Q0QxQkxB?=
 =?utf-8?B?V0pZZW9PZnVsV1dvMC9KY1djOGcyRm5mR0ltQkZlR0RxV0d3WGo5Qnc3LzBH?=
 =?utf-8?B?L1NCVXBlbU5tNVh6Q21UcXUvOVBiaDdRUzdMWFljSTZaSEJEZ2xGenNyeEdN?=
 =?utf-8?B?a2JEbDJvOUowQ293b29IZFlDeXpZd1J2ZVlxTjJMVnE5WllqVy93dz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a01b6-84a5-436d-1821-08de83c74c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 01:48:33.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIY9ypAR5VfdGacyeMqC6oTLQOT08YBISHx92SjuVzQPuuDh/8zoEQX65qzMIPi10SQGfmLwcMa5DDOlZ+wcyMeezqX8iqlr6di5enJaXgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6899

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyNiAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgdHJhbnNmZXItbW9kZSBwcm9wZXJ0aWVz
DQo+IA0KPiBIaSBSeWFuLA0KPiANCj4gPiBZb3VyIHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdDsg
dGhlIGJ5dGUgYW5kIGJ1ZmZlciBtb2RlIGlzIG1vc3RseSB0aGUNCj4gPiBzYW1lLiBBbmQgYWxz
byBtb2RlIHNob3VsZCBiZSBkZWNpZGVkIGJlZm9yZSB4ZmVyLCBkdWUgdG8gdGhlDQo+ID4gY29u
dHJvbGxlci90YXJnZXQgYm90aCB1c2UgdGhlIHNhbWUgeGZlciBtb2RlLCBub3QgZGVjaWRlIGJ5
IHRyYW5zZmVyDQo+ID4gdGltZS4gVGhlIG9yaWdpbmFsIG15IHN1Ym1pdCBpcyBvbmx5IGJ1ZmZl
ciBtb2RlIGFuZCBkbWEgbW9kZSwgYW5kIHVzZQ0KPiA+IG9ubHkgb25lIEJvb2xlYW4gcHJvcGVy
dHksIGFzcGVlZCxpMmMtZG1hLWVuYWJsZWQsIGJ1dCBzb21lb25lIHN1Z2dlc3QNCj4gPiBhZGQg
Ynl0ZSBtb2RlIHNlbGVjdCwgc28gSSBzdGFydCB0byBhZGQgYXQgdjE3LiBJIGNhbiBkcm9wIHRo
ZSBieXRlDQo+ID4gbW9kZSwgaWYgdGhpcyBpcyBjb25mdXNlZC4NCj4gPg0KPiA+IGJ5dGUgbW9k
ZSByZXF1ZXN0Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8wMTBlNTVlOS1kNThi
LTQ0NGMtYWI1Ny0NCj4gPiBkZGY4Yzc1ZjIzOTBAZ21haWwuY29tLw0KPiANCj4gT0ssIHRoYXQg
c291bmRzIGxpa2UgbW9yZSBkcml2ZXIgY29uZmlndXJhdGlvbiB0aGFuIGhhcmR3YXJlIGRlc2Ny
aXB0aW9uDQo+IHRob3VnaC4NCj4gDQo+ID4gPiBSeWFuOiBJIHRoaW5rIHRoaXMgZ2l2ZXMgdXMg
YSBtdWNoIGNsZWFuZXIgYXBwcm9hY2ggdG8gdGhlIGJpbmRpbmcuDQo+ID4gVGhhbmtzIHRoZSBm
ZWVkYmFjaywgZG8geW91IG1lYW4sIGp1c3Qgb25lIGJvb2xlYW4gcHJvcGVydHkgZm9yIG1vZGUN
Cj4gPiBzZWxlY3Rpb24sIEFtIEkgcmlnaHQ/DQo+IA0KPiBJdCdzIGxlc3MgYWJvdXQgIm1vZGUg
c2VsZWN0aW9uIiAod2hpY2ggaXMgYSBkcml2ZXIgaW1wbGVtZW50YXRpb24NCj4gY29uc2lkZXJh
dGlvbikgYW5kIG1vcmUgYWJvdXQgImhhcmR3YXJlIGNhcGFiaWxpdHkiLCB3aGljaCBJIHRoaW5r
IHRoZQ0KPiBib29sZWFuIHByb3BlcnR5IGJldHRlciByZXByZXNlbnRzLg0KPiANCj4gVGhlIGRy
aXZlciBpbXBsZW1lbnRhdGlvbiBjb3VsZCBkbyB3aGF0ZXZlciBpdCBsaWtlcyB3aXRoIHRoZSBp
bmZvcm1hdGlvbg0KPiBhYm91dCB3aGV0aGVyIGEgRE1BIGNoYW5uZWwgaXMgYWxsb2NhdGVkIChh
bmQgc2VsZWN0IGEgc3VpdGFibGUgbW9kZQ0KPiBkZXBlbmRpbmcgb24gdGhhdCwgYW5kL29yIG90
aGVyIHJ1bnRpbWUgZGF0YSkuDQo+IA0KPiBUaGlzIHByb3BlcnR5IG9ubHkgc2VlbXMgdG8gYmUg
YXBwbGljYWJsZSB0byAyNjAwIHRob3VnaCwgYXMgdGhlcmUgaXMgbm8gbmVlZA0KPiBmb3IgaXQg
b24gMjcwMCwgaWYgYWxsIGNvbnRyb2xsZXJzIGFyZSBETUEtY2FwYWJsZS4NCj4gIA0KVGhhbmtz
IHRoZSBpbnB1dCwgSSB3aWxsIG1vZGlmeSBzdXBwb3J0IGJvb2xlYW4gcHJvcGVydHkgYXNwZWVk
LGkyYy1kbWEtZW5hYmxlZCwNClllcywgYXN0MjcwMCBhbGwgY29udHJvbGxlciBzdXBwb3J0IERN
QS4gDQo=

