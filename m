Return-Path: <linux-aspeed+bounces-747-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E8C021A0
	for <linux-aspeed@archiver.kernel.org>; Sun, 16 Feb 2025 01:25:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YwSlm5Zyfz301N;
	Sun, 16 Feb 2025 12:25:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c400::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739669140;
	cv=pass; b=oi8T/yVUfL1nWstdqfXO1IqB6wgoIQtqwVqa5T52N72DdpDFiCR6B3H6juqwyRdp0Uiowk1vyr3gHAFOmhpBHgQr+qBOY8uALTvZItLGNT/zRs27UyffMdJ7b/dLEgaonIMOZBUmEbb9WTGHw4n8omGerlwk7bZ5QH4XpqwLZjcIVJcmTesfU6TxZR/KCxd2ubD1CZvZca/KkqvCPJ47wqPZYFLyF3tpUrs50uZHt/3a1ev0M2C86ZgnkcMRqiz3QhydZXOlrpttOt/ygHCOuyq5MXvcKGmZNm0tEn3vCjEhpRPTQeJp4Qd8DkaPqnFAM0IstvEH2nxCWapCRP3gdg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739669140; c=relaxed/relaxed;
	bh=O3URnGhEaBzWORHLag/bpYwycGiE5INXxAnJd/fYN4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYJ6tbO8jbliWoq/qXDtKImrhG1Yyu5Hh2wZ9NT+Hyk6mYpggrzQSrAPiKpv0jdol/IYFMZ4IsjGbuJXuK7/3vPBF8bnNXZ9pJxk6EQWrDbmuvrGfiWwCXM+7t2glX3pQVs0O0uYiyKVQhVNFh4hIHn9cHkt7N40oQZzG8f3EYnizRwWBZi1ATUCZ7tdpSPMbzBquIWgpznipklUHRBKK70Nt8k/rgFmKR85jOhDWSnZKJ0t6GCnHeYxlRMCvBnDm/5cCwitCP2xu8Oco8pHy9gURQcZSmytQOc/1f/J/fXaElGhBo0+HZTz14QUmTOFvJqp/BFQE38YlOyxsIio0A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c400::; helo=hk2pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YwSlZ1gZ4z2yhD
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Feb 2025 12:25:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUmjXp8NIgw7yQQxqSscBv+InH7zjMXVlotxRVCtCs4v3zf5QaGCE8KfMe3Gqwnq8VMc6ClOX9kye2qVoQuzHa7e/bZ9OtT3JI84HNhvv16uGyHbTLZTq1mGTz/S/8PQti4ED9SHPKV1jBeOJSb2W8qgtfV1aQYHu9qGhwrol8Z/xxOlihZfJLQj/be7/FhNchgUpasLWYcKalugZeJDUUwr7Qf+i6cgoWpgk3qXE9BwKf5P0l596Wwkj+2NmeFB1lOEKV+rknW1Zc6TZymWvJPRzvm/wdXbWCIGDSKKqWyEZAUtQWWEf95F8ph9FP1GV14wUlsAHb3YXkVbNW1L8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3URnGhEaBzWORHLag/bpYwycGiE5INXxAnJd/fYN4o=;
 b=PFkwzlxqes6Ul+FLELTD+0oP2OOpuWNlkJzKGtL6neLPuUe2o+w/sZfu6DMFMqC19CDvlnrBu6csSvrIsIz9QYCp328Rmj3E6D/wtR6vdNp24Ec/5K2CmZF67fgUVvx/xHRB5AbbK4a2pRMArswvuEIuxIPLjc3Yti4KvWj64erUHchVbHITZrvw1PrYlTNMlM2M1SdgBOMjJ1DWVpcgue/yaiR6ZpdGh1+IM5kW3jhcVj11nuWRlQSwbt5Cg+5nYqwLqp3dN7/iAmGZ/Atuo4d/8GdLCJM6LMBM1ZPJYBJtwt7ahSpIn9/Dz/708R/qegG34w5uDjIHuOnYErEVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3URnGhEaBzWORHLag/bpYwycGiE5INXxAnJd/fYN4o=;
 b=lYeVCFJKrprai5UQZOq9HhLQTPi7sCplIrnLP0fkK/wXVJ0dxKXhsohvNDz+5LP1qCmWNt0BTLqTrhGmyE27FvJFFYbY8jIlfmSNASQr63i7xhJjh/ytxx8EWi86vwdfchMRaCUSPz+GItxcR/QO7FEF0Asyzfwbo98HnFb/ZMyrhioeRnvOwv0zV2j9PgaUROwmEwCfTCSYM1qVt6/sjEhUZ8OnsogweSZtlS0Ab0jVPgplQ1bbCAlF1fKL9bk8dkxYlzdzHhplU8h2TNoKyUWpwx+0Wv2LkLfIYl6kUlfVoN2Ds2rZAryINuGhVzWr++XUS8RNN78wrbienQG8yg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYSPR06MB6470.apcprd06.prod.outlook.com (2603:1096:400:483::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.7; Sun, 16 Feb
 2025 01:24:58 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8466.004; Sun, 16 Feb 2025
 01:24:58 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Topic: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Index: AQHbe5jOQE8gqD0QkUiPz6C8rjFaj7NBw6UAgAXf/kCAAJjSgIAA6k7w
Date: Sun, 16 Feb 2025 01:24:58 +0000
Message-ID:
 <OS8PR06MB7541DF787A2A77D6D029F258F2F82@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250210085004.1898895-1-ryan_chen@aspeedtech.com>
 <20250210085004.1898895-2-ryan_chen@aspeedtech.com>
 <20250211-encouraging-free-aardwolf-0fabb1@krzk-bin>
 <OS8PR06MB7541287BC48C500E50C7C77FF2F92@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <87e21b2a-b0f5-41c3-ba6e-960da5c1f836@kernel.org>
In-Reply-To: <87e21b2a-b0f5-41c3-ba6e-960da5c1f836@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYSPR06MB6470:EE_
x-ms-office365-filtering-correlation-id: 51671141-f8d6-4d44-ded2-08dd4e28b9f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEpnci85MElUN0RFZmJlb2JxR05IWFd4NTYvVm1iS2dsamRCOEVrWk9BNXhQ?=
 =?utf-8?B?WkhVejJTbE16WXFqdVhzakV2RlZPbU5FMmM5dENsa1lsTzBwTGJhbWZaL3Q1?=
 =?utf-8?B?Q0tYcUdNeXR6a2V5cDRhL3hnbDlzMzZ3N1NMV2pyWFhBdittY3lCK3VKNFZB?=
 =?utf-8?B?RCs5TllhT0NhZzhGTVVFbmt2Zlp2anRBUzlKOGJSeVVLb09lbkNkajgwTkVn?=
 =?utf-8?B?ZTZRK0c3cGJTVkhXY3BCeGY2RGRLSVgvYSthSmlOZlhMUzIxU29NNUdBN0FX?=
 =?utf-8?B?SlZ1VFNlSitIZnFpYzJiY2UrUCtRQ3JqeTNxNDNXUmlVOXFDRmdzN3YzNXFB?=
 =?utf-8?B?K1BZYzdUd29weVhRdlcxNlBXU3d2NXlHcy9GdDlKSWxTUlFHVVMzMTVKaHBQ?=
 =?utf-8?B?c2NOOTJpM0JHaHZ6c2V6RXltVEF2Q3J0TzBETk5tVDBYRnJqT3B1UXZqM2Nm?=
 =?utf-8?B?djFCU1I2M25nMGk3NytaOGFxelpGblgxZW1ac0NnSFE1NHAwb0U5d1hENnll?=
 =?utf-8?B?MzdMRm1RQzIzVUkxYTJBS2NxNjhVd2psbDdpVWNjYVY2a1o2VFpCc0c1anR0?=
 =?utf-8?B?cTlQcERxUnVWNW45ZDU5TVRnYTgrSndxSm9aQUM1T0hnWEZwT1drb25jcTdM?=
 =?utf-8?B?c2NnRlk4dGhmaEhFdXNHUFI1aExaR2JEMGJ5RmJyRE1BRnIzTG9id3dkSmVF?=
 =?utf-8?B?SXpJSEx4bFBTVGhqU1R1QlVKSzg3Vm9BelR1MzMzdGNnYi9wNGxHR25vSDA5?=
 =?utf-8?B?Z2F4MEZtWm4xeDRaNzk4aENmVjVJM0Z5cVJzVmRyT2RXRUoxaHAvMVFpOGll?=
 =?utf-8?B?YzN4T2x2Ti8zcFZIRU90MWh2ZEswS0xqVFMrcjNtUy9qTnRaTHZ3SFYyci9R?=
 =?utf-8?B?MDgrVjZhU0xSMlJOcTRmTEhiVXlzYWFkbVF0amVyR2dlRzZYSTlwcTM0R0VU?=
 =?utf-8?B?c3NuNFdEZUxVZUNvUTI4WC9zRGRxcnJQWkpSR2hyY0RtQUNzQjkrYWxlZGxB?=
 =?utf-8?B?eTZxemNkZDlOZDAyd3NGNlFETXhQMDVhV1N0Z0psK2ErODRtaVFDZ3VZcTc0?=
 =?utf-8?B?STRuZ0RQMUZYK0tWb1lBMnZYUU1yT2NVT1oydzdZRCs3a0duWW13cTU1aFR6?=
 =?utf-8?B?b08xWHpxWEpyOW9vNG5SMWRJMEVQNlZaUzNXUDB3Y1A5SUFKam5kbU0xNGFO?=
 =?utf-8?B?OFlRLzAxeVhNRG1xMU1nc1VGNW8xSG9kNTF4S0VVVU5ZM0tJVmpjRkFOSFpz?=
 =?utf-8?B?cFplMGNNTjYxTFZXNGhXWVBQc05MaGhrbEVXcjhqSWphNlc1V2FraGpOd2Ey?=
 =?utf-8?B?ZWp1NkdwZEd1c2RXNklYOWNDQi9ieGM2aGltV1ZMekxVbm5yWUhiaU40bDZi?=
 =?utf-8?B?KzA3N3MzdExGcUVJcVFUQThqYy92Ukl3Tk1QRVB2RWJvL1c4czVXLzlndlk3?=
 =?utf-8?B?UUhCVkZBaUR5bFpDbE5qSXU5S1haZWtFT1RlOUZOVE5tTzVob3liQXRobFQy?=
 =?utf-8?B?cTdUVVlSeEk4ZWduR2w2cVZmMlBvdG5vTEFDaGZvODFIUG5qL0p4STJzcTlV?=
 =?utf-8?B?VHoyZU4yeUo3QkcxSXhvOGlIUlhNbFAzc2lqcjdGclJNaXgzS09KbWpycnps?=
 =?utf-8?B?M3ozNlZQNk11elNWKzhYY2FJYmwxa1RIVkFudUpZSGZudUJncEZrM1BtUW54?=
 =?utf-8?B?Q0pVYlZDelBFSUYwS0Q3Y21CbGtiTUZ2Tkh0RGM3Q1NXZmJqcDZXZGcvRURR?=
 =?utf-8?B?THAweUw3K3FvMlExU1R2R3hMM0ptMWJCVUxvc21LZ1Y1YWdnUDZ4U0YxSk1O?=
 =?utf-8?B?dDJ5RFhuMHA1bmFyN0FwRXpoQk50OG1xRGpYT1FRbDdTd0NUVkVUMm90YmY3?=
 =?utf-8?B?QzN1Q2REMWxvUnozWFNEbjVUTTlFRlAzYVMxOS8yVmdieGpldEFlOXhhcTli?=
 =?utf-8?Q?j/K+B3pfIZ3evGQVgBpdcDf7DHWhuubi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2tDUFVXQXNZdEJFV3FTTWJuTUdMSGwyTCthL1hiaFlpZUZVcWRDWmcwdW5r?=
 =?utf-8?B?K1dsY29aWXptS1dQRnV0UUx0dGlXd0l3VFJ4WWJmVUtqRUs3NVJYb1QrTW4v?=
 =?utf-8?B?QWNYajljYm84OEw1QTBrWjA2TlBDQnlCc0toZWlRNVZkcUJoUmpDUEFNQ2I0?=
 =?utf-8?B?Q1BWcmR4Snh3dE8wc05tbDZadGRtMW5DYmxQTkh4SjFtVjVjT3N1MVZlUmN6?=
 =?utf-8?B?RUxxU3VHeENabEtvb0pzQTJ6bFhaL1E5MHhPd2RaVSsyclFrUnE3c055cncz?=
 =?utf-8?B?RUJtSU96dG1uRHlERy95QnNaaERocHFpWGtvRDlybGxxeDhScUo3VXg4WDFX?=
 =?utf-8?B?SDFFT2IzUWxhYUxkV0RPNk9xMk9UM0RxelZWM09kOXEyamgrUWVZbmlPRmtM?=
 =?utf-8?B?SFk5RDBqUkc2cW5MUS9NUVA4ejZnWVJZb0JobjdLVU1sQkZwbnMralVXMGs5?=
 =?utf-8?B?YStJWTdIMVV0bGdZYmFGemIyRmZ6aW1ObWlmcmhnOUh5T3QybTFxN3Z5dXg1?=
 =?utf-8?B?ZU5DVkhFUW9HcEhzNjhialloRzE2NWpXSFY0QVlOTDNkN0NVSTJPbCt0TU1r?=
 =?utf-8?B?VTVKallveDFOSE02elNhUnpuazdSL0F3WlFmSVdNZjl0VGZTbWxMZVFyMWlC?=
 =?utf-8?B?bThpY0sya2NOWWh0OUkrSVg1QTVCcEs3WTVRZ1B0em12dUhrZzh4ZTZPaFF5?=
 =?utf-8?B?aHp5Wjcxd2FxcXhEZXZwZTAyNHhjdUNvM2lSR3lXZkc2c0dLbE1MYUVOb2JG?=
 =?utf-8?B?SkpuTUtLbm9LaHhYUUhWUGRHUXlJc0ZVazJkNEQxdWdFblpCZnBPY3I2T091?=
 =?utf-8?B?dzB0ZUlmUjUyMmVrbXBBWkxoREVGaVJjTk1kSmk5K2tyNmlabjVFNzFsSTl0?=
 =?utf-8?B?ZStHMmUvdVV2em15bmxpSmhSNXE1d3BFK1c1Zm1wb2U1bXlDakd4Y0xhajJi?=
 =?utf-8?B?L0tqWmRGbzVKZzVqK3pvTnhJQUdCemVONDJVN1BzWncrK3YrMi9vQUhPSnRZ?=
 =?utf-8?B?WlZKcVpvK3JYbVNWWXVkMGs1Mld3a0FGQmRSTU9DWmRIUUxCdU5lR3ZCWm5U?=
 =?utf-8?B?YU5KSUlFekF5VmYxZlFtY0p0SVk2WlZBdUM1Kzk0dDV4MFZwbXFjd0xjZU5u?=
 =?utf-8?B?dC80Nm9nZWkvbVQ2YUU5cVMxcGNFUVFZMXloK3R1c01sY0FabUtHZERqYlNH?=
 =?utf-8?B?OGEyajZwTWNwWDhyTGNpeXB2UmZMUzdyM1ZFM3VKM0pFeTE5bFVaSFpmaTIx?=
 =?utf-8?B?N2V5Skxha0FpREkzbmRMSUFYRkVyOWsvLzF1aHFHbnRNTWdjVzJ5KzZhdUp0?=
 =?utf-8?B?N0p1dlNkaTRuRVZXRWNvdUU4U3VMWWJRZmorVmNvWWFXL0djcnZDVThjRU9p?=
 =?utf-8?B?NDQzWW9HdXRmcU1adWZVcURUc2FJb1VCaC9MVG81VjVjb2pIcktCMDQ4TjUx?=
 =?utf-8?B?VFlvU1BRUjU3UTZ4cE9sSkdYM1A2blRYSHRyTnk5SHBocU9EN2lpaEJmdGZI?=
 =?utf-8?B?RVJKbTZTK3RGejNzRlNLeStiV09nQWxINUhLWEM5R0piYm92TzNNY1ZjWWJq?=
 =?utf-8?B?TTF5eVdIVGJMdlZZbE15elJERmhpOG9Pa1pMMUJJa0sxRG1KYksvVmtwdmMr?=
 =?utf-8?B?T3VEeER5ZXlHWFd6UURLbWNCOTNNNWdvQTAvMzFjYnJNd204R0dFb2NkK0pJ?=
 =?utf-8?B?NmkwOWkzTi95RS9Bd3k2TzlNeHNsR0dadTZGN21rRFRTQnJwZTlvRllpajJq?=
 =?utf-8?B?V2NQTVRJaWxxUldzOU41dVIzS0JKNXBxV3hqWHN3R1RMenU4Q1VyQityd1Ny?=
 =?utf-8?B?eXk4Y3RVQjJxaERnQnY0bDVTUEVuYkVTVk1UUmZhME04cWRsbElWWTZ6THNH?=
 =?utf-8?B?YkJyNEtJbzVJY1dPOTNkTWR2aVJ5TGJtRGMzcmpXb01kbmwrekhFUlZaQjBN?=
 =?utf-8?B?dDFBWXlzUm5mL3V4RDNyb3FOR211TmVnQ1RiK29VclJFNXdGQmZlOVRUM0J1?=
 =?utf-8?B?TitGejVUZlA3MHNUYmZsMWNqT2JJT1dLTGdpVlBRNkhOUW9kRXZ3ekN4aXhs?=
 =?utf-8?B?UjhYdWxKZ2ZNNUtLdHVqZlBqMk9tQm43WnRFQ0g1bngwaFBMUVBnNHQzalFj?=
 =?utf-8?Q?xMJ7Pvp2tqrdKDclznhihf2tN?=
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
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51671141-f8d6-4d44-ded2-08dd4e28b9f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2025 01:24:58.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/zKpWlRCW8MA0y51qwUSk3ZCClAKPuMpSN5RSqxQDagkNL8YU1I+YNFsaa9ndPKroWMJ0DZ/X/wdH8WB5G/bLmr0Hzz38Bh9SLcRR1xbb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6470

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEvM10gZHQtYmluZGluZzogY2xvY2s6IGFzdDI3MDA6
IG1vZGlmeSBzb2MwLzEgY2xvY2sNCj4gZGVmaW5lDQo+IA0KPiBPbiAxNS8wMi8yMDI1IDAzOjE0
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gPj4gU2VudDog
VHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjUgNDoxOCBQTQ0KPiA+PiBUbzogUnlhbiBDaGVuIDxy
eWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+IENjOiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1
cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQNCj4gPj4gPHNib3lkQGtlcm5lbC5v
cmc+OyBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPjsgSm9lbA0KPiA+PiBT
dGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+
Ow0KPiA+PiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPjsgS3J6eXN6dG9mDQo+ID4+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsg
Q29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gPj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsNCj4g
Pj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAxLzNdIGR0LWJpbmRpbmc6IGNsb2NrOiBh
c3QyNzAwOiBtb2RpZnkgc29jMC8xDQo+ID4+IGNsb2NrIGRlZmluZQ0KPiA+Pg0KPiA+PiBPbiBN
b24sIEZlYiAxMCwgMjAyNSBhdCAwNDo1MDowMlBNICswODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+
ID4+PiByZW1vdmUgc29jMCBjbG9jazoNCj4gPj4NCj4gPj4gV2h5PyBZb3VyIGNvbW1pdCBtc2cg
bXVzdCBleHBsYWluIHdoeS4gV2hhdCBpcyBvYnZpb3VzIGZyb20gdGhlIGRpZmYsDQo+ID4+IGlz
bid0IGl0Pw0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSB3aWxsIGFkZCBleHBs
YW5hdGlvbiBpbiBuZXh0IGNvbW1pdCBwYXRjaC4NCj4gPj4NCj4gPj4+ICBTT0MwX0NMS19VQVJU
X0RJVjEzDQo+ID4+PiAgU09DMF9DTEtfSFBMTF9ESVZfQUhCDQo+ID4+PiAgU09DMF9DTEtfTVBM
TF9ESVZfQUhCDQo+ID4+PiBhZGQgc29jMCBjbG9jazoNCj4gPj4+ICBTT0MwX0NMS19BSEJNVVgN
Cj4gPj4+ICBTT0MwX0NMS19NUEhZU1JDDQo+ID4+PiAgU09DMF9DTEtfVTJQSFlfUkVGQ0xLU1JD
DQo+ID4+PiBhZGQgc29jMSBjbG9jazoNCj4gPj4+ICBTT0MxX0NMS19JM0MNCj4gPj4+DQo+ID4+
PiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAt
c2N1LmggfCA3ICsrKystLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJp
bmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLXNjdS5oDQo+ID4+PiBiL2luY2x1ZGUvZHQtYmlu
ZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtc2N1LmgNCj4gPj4+IGluZGV4IDYzMDIxYWYzY2Fm
NS4uYzczODk1MzA2MjlkIDEwMDY0NA0KPiA+Pj4gLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9hc3BlZWQsYXN0MjcwMC1zY3UuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9hc3BlZWQsYXN0MjcwMC1zY3UuaA0KPiA+Pj4gQEAgLTEzLDE4ICsxMywxNyBAQA0K
PiA+Pj4gICNkZWZpbmUgU0NVMF9DTEtfMjRNCQkxDQo+ID4+PiAgI2RlZmluZSBTQ1UwX0NMS18x
OTJNCQkyDQo+ID4+PiAgI2RlZmluZSBTQ1UwX0NMS19VQVJUCQkzDQo+ID4+PiAtI2RlZmluZSBT
Q1UwX0NMS19VQVJUX0RJVjEzCTMNCj4gPj4NCj4gPj4gTkFLLCBBQkkgYnJlYWsgd2l0aG91dCBh
bnkgZXhwbGFuYXRpb24uDQo+ID4NCj4gPiBUaGUgYFNDVTBfQ0xLX1VBUlRfRElWMTNgIHdhcyBv
cmlnaW5hbGx5IGRlZmluZWQgYXMgYSBzZXBhcmF0ZSBjbG9jaw0KPiBpZGVudGlmaWVyLCByZXZp
ZXdpbmcgdGhlIEFTVDI3MDAgY2xvY2sgZHJpdmVyIGltcGxlbWVudCwgSSByZWFsaXplZCBpdCBp
cyBubw0KPiBsb25nZXIgbmVjZXNzYXJ5Lg0KPiA+IFRoZSBjbGstYXN0MjcwMC5jIGRyaXZlciBJ
IGhhdmUgKippbnRlZ3JhdGVkIHRoZSBTT0MwIFVBUlQgY2xvY2sNCj4gKGBzb2MwX3VhcnRjbGtg
KSB3aXRoIGBhc3QyNzAwX2Nsa191YXJ0X2Rpdl90YWJsZWAqKi4NCj4gPiBUaGUgVUFSVCBjbG9j
ayBzb3VyY2Ugd2lsbCBnZXQgZnJvbSBhc3QyNzAwX2Nsa191YXJ0X2Rpdl90YWJsZSwgdGhhdCB3
aWxsIGRpdg0KPiBmcm9tIHNvdXJjZSAyNE0gZGl2MTMgb3IgZGl2MS4NCj4gDQo+IFdyYXAgeW91
ciByZXBsaWVzIGNvcnJlY3RseS4NCj4gDQo+IFNvIGFsbCB0aGlzIG1lYW5zIHlvdSBleHBvcnRl
ZCBjbG9ja3Mgd2hpY2ggYXJlIG5vdCBjbG9ja3M/DQo+IEhvdyBhcmUgQUJJIGNvbnN1bWVycyBi
ZWhhdmluZyBub3c/DQpJbiBteSBvcmlnaW5hbCB0aHJvdWdoIHdpbGwgYmUgc2VwYXJhdGUgY2xv
Y2sgaWRlbnRpZmllciBvbmUgaXMgdWFydCBjbGssIGFub3RoZXIgaXMgdWFydCBjbGtfZGl2MTMu
DQp1YXJ0X2NsayBzcmMNCgkJCQktPiB1YXJ0IGNsaw0KdWFydCBjbGtfc3JjIGRpdiAxMw0KYW5k
IEkgcmVhbCBpbXBsZW1lbnQgaW4gdjYsIG5vdCB1c2UgaW4gY2xrLWFzdDI3MDAuYy4NCkJ1dCBJ
IGtlZXAgdGhlIFNDVTBfQ0xLX1VBUlRfRElWMTMgaW4gZHQtYmluZGluZyBkZWZpbmUsIG5vdCBy
ZW1vdmUgaXQgd2hlbiBzdWJtaXQuDQpUaGUgU0NVMF9DTEtfVUFSVF9ESVYxMyBpcyByZWR1bmRh
bnQuPg0KdWFydCBjbGsgc3JjIC0+IHVhcnRfZGl2X3RhYmxlIC0+IHVhcnQgY2xrDQoNCg0KPiBB
bnl3YXksIGFueSBBQkkgaW1wYWN0IG11c3QgYmUgY2xlYXJseSBqdXN0aWZpZWQgaW4gY29tbWl0
IG1zZy4NCj4gDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2sNCkkgd2lsbCBhZGQgdGhlIGNvbW1p
dCBtZXNzYWdlIGJ5IGZvbGxvd2luZy4NCg0KLVJlbW92ZSByZWR1bmRhbnQgU0NVMF9DTEtfVUFS
VF9ESVYxMy4NClNDVTBfQ0xLX1VBUlRfRElWMTMgaXMgbm90IHVzZSBhdCBjbGstYXN0MjcwMC5j
DQpUaGUgY2xvY2sgc291cmNlIHRyZWUgaXMgdWFydCBjbGsgc3JjIC0+IHVhcnRfZGl2X3RhYmxl
IC0+IHVhcnQgY2xrDQoNCi1DaGFuZ2UgU0NVMF9DTEtfSFBMTF9ESVZfQUhCIHRvIFNDVTBfQ0xL
X0FIQk1VWA0KTW9kaWZ5IGNsb2NrIHRyZWUgaW1wbGVtZW50IGluIGNsay1hc3QyNzAwLmMuDQpv
bGQgY2xvY2stYXN0MjcwMC5jIENMS19BSEIgaW1wbGVtZW50IG1wbGxfZGl2X2FoYiAvIGhwbGxf
ZGl2X2FoYiB0byBiZSBhaGIgY2xvY2sgc291cmNlLg0KbXBsbC0+IG1wbGxfZGl2X2FoYg0KCQkJ
CS0+IGNsa19haGINCmhwbGwtPiBocGxsX2Rpdl9haGINCm5ldyBjbG9jay1hc3QyNzAwLmMgaW1w
bGVtZW50IGJ5IFNDVTBfQ0xLX0FIQk1VWCBmb3IgbW9yZSB1bmRlcnN0YW5kIGNsb2NrIHNvdXJj
ZSBkaXZpZGUgdHJlZS4NCkFkZCBkZWZpbmUgU0NVMF9DTEtfQUhCTVVYIHJlcGxhY2UgU0NVMF9D
TEtfSFBMTF9ESVZfQUhCDQptcGxsLT4NCglhaGJfbXV4IC0+IGRpdl90YWJsZSAtPiBjbGtfYWhi
DQpocGxsLT4NCg0KLW5ldyBhZGQgY2xvY2sgDQpTT0MwX0NMS19NUEhZU1JDOiBVRlMgTVBIWSBj
bG9jayBzb3VyY2UuDQpTT0MwX0NMS19VMlBIWV9SRUZDTEtTUkMgOiBVU0IyLjAgcGh5IGNsb2Nr
IHJlZmVyZW5jZSBzb3VyY2UNClNPQzFfQ0xLX0kzQzogSTNDIGNsb2NrIHNvdXJjZS4NCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

