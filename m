Return-Path: <linux-aspeed+bounces-3813-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49E5FF60D5
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 06:59:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flJrR32Qvz2ybQ;
	Tue, 31 Mar 2026 17:59:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774940359;
	cv=pass; b=BQeRUaR0/BVs4Rkw/pR+G7PIFwfKbvtRTs5o5hjBnd0fl33k3UxW8MBtLejayWJafZgJRPAa31njhAu5uHHFyp/9pQoE5Uxisoz+xVcwqUMl+yjbgh6KM4rrOofB1bPfJZv/verSwyon39pMjtm8TnYqgS3e7drgu4XbHj/Uf5hwYekYlj0IXOsjWtGeQvCmwz978GbwPsq9wIHryLRPbyDWqvzmlOoZwXnUe4oS8I2Odz4qPZ3ayJx08I0jfj4U3vmchqS4VbKxrgEJMlYz0VIbn9LRntSXxcDtR2g1KPYAOzjlRL5yR3JNkKuqZHntCwrLQ8rOgCqY2061XZMwAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774940359; c=relaxed/relaxed;
	bh=jbplTS6Tx/7puP75PqrnMhp85GHUYowt7pqui478MJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDSULCGJJQc34s3qqAC/+wjXPUUvZT7E/PJgWNCylyzPEnTuALazEtMcZWIoHuWOB33dsfYr4/aXJr/9JQl+indZBi6K5ETBTmrZNhc12STNCN6+RvTDZcrJuoUbCCXZL3VkIADkpgZCqa6zXn0u7oeDyoizUZE5KI9qJbpMI15QgWUBEzvtLpHU2Nml0dcAqLd1iAN0bfsw4vxKbk+ogIwgx2va0owx4KlVobtPKKFKFWvZzTw347D4Z/fQGuXNyJkUqa4leDp8p1Q2UnZpNVdCfSV79j3zrcsKQnMWUnDjqoSe+BC83GxyOWC1rPmwm+7nInLtdcfTzVRmZ7whgg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NlyNfQpC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=NlyNfQpC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flJrP4kr2z2xSb;
	Tue, 31 Mar 2026 17:59:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuRKpnSwmPf84kdVjSmf0XA9LuBr/qxydCSf9dAeXeC48mRJzqflB2XWnItPiFvs7vk6M76+05c7wfeeM2b+055E0+p9/Ow2Yy1SJj87RdgHjklAPPDa5gmJ6IdSBat3R5NlOCfoGtb5Xf9MJs08pyuM3MxYF1KPNgAx9LS6S457IeJGJT/uSD3Fbru0/5ga7o9KcZlfaSJaN97mDHHodWORP1Oq01M+fdvKs2Eb9jNgyshoifSpP7jAjo3UjicgXJrpmYM7PhS1/ZYJUu+h/er5dlmTJPY6sjIvhPYgem/rlFxwJm7cYxCp7ji41IG3Twhr5P0QouNSC9bXvaCXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbplTS6Tx/7puP75PqrnMhp85GHUYowt7pqui478MJg=;
 b=xsiEhp/a/Decv7wAaBlZZV2kGyDWoM86KyBnzd88aeF+O7dTEOZL/u0s8BC3omvukiE23IiWDCOztIBdc0CJ4wSDP57WXEp0aXCrfwB6dt+ySo5OIfPPXkmvjKMC35x2AFL6jA1FBK38BV2pWW/8MB/RgdV/oaxxaiRjqg3l/CMsPKBs+rKGExrOoT8kSroMyDGFRTTfppg84BZFzBywZYF1Ti5KY7VAp3bM6a7V7IA4Aa4MoCaf1+A5Lxqhr30Faidtt7rNmg2Xxkuy2rTn9HLMaSTFes3ajypKL6UJO25fUoOQxDhDKUuFYtlYB0fjb67Otaki4iK/4UZC1QmL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbplTS6Tx/7puP75PqrnMhp85GHUYowt7pqui478MJg=;
 b=NlyNfQpCOPTX4zYNI57iD7bxsr7MrEafK7KCaR3N8iQPbc4Wu70wdqVeSmPTDLbNXuHiFgVwrWBGMHOuTgTRVaYZpXSu2rOs0LANl14D3nsLg6pssR1o5Q0NlbKp9FJehj24tGcOZU1h/nty3YIPWAsLOaFzr7/QzooFRvF+0uYO3j/mOeROccyCRimw8JHRm02pq5jKn3BPVSpa/bUk21naEqZQTOh/gUaroIIncoZMG40+2ZkZQmbY7sgXGuOFMl4rE2W8L+Kkzsd8BLfNo5S9vWOf7mXkS9dLm44CEgrcxcAZdArwVh/g84CJJk372j1x6ISpP4C6ga5muNfkwg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by JH0PR06MB7127.apcprd06.prod.outlook.com (2603:1096:990:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Tue, 31 Mar
 2026 06:58:51 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%6]) with mapi id 15.20.9745.019; Tue, 31 Mar 2026
 06:58:50 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, Andi
 Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
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
Thread-Index: AQHcwB5Ez31FCAF2H06H/moL1lfWeLXINCEAgAABqPA=
Date: Tue, 31 Mar 2026 06:58:50 +0000
Message-ID:
 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
 <20260331-fanatic-certain-bustard-fb13bc@quoll>
In-Reply-To: <20260331-fanatic-certain-bustard-fb13bc@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|JH0PR06MB7127:EE_
x-ms-office365-filtering-correlation-id: 244a7cde-4741-4771-9edf-08de8ef2f6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 YDOiTKPgwrGEgiJWp0pmscXxLE1GNNAit+va9a0FCgYXSZb0hHmEm0szHfVOHWEhxR177dcuX7aqaCCUvKiqZ+ayQF7q72SX5+6lh5ReW+0SUTVQdHrYq7Mt/C3IB+oG0beRc6gA9apLQgGFH5LUt365QtTnazSqKeoUEMa1ZbJMjGW1HydL6VZr4GtIr7k/2zTCxrLaVXchm5kmGzh4RAQy91ny18CSKbefxPP30Vf2umMLOOtzr6TXwasEcfZHNR9ES2Kuz5xtnpjxz4Lc+h+WVSeRU60Hj/cDibrvh2Eyw0rOCFp+yTuQxyvnEkZlY+//xGF1MrC3ovJdx39AfHGJEVF/0TmBrqpsGXNdhL1FuqVUJPiC8nuNt774uNVmgkMMKwHAjAqWoFQ6k/gaOkFEdckd5zjLhGf5wCmyf6ezoDMmH6i/7PjpKoa2VPW3y3ifd84d+othN3Z/endOBFdqk23fVV1tlUTzEFl3X0EjRKaMR03MxbXN/YLrRw+wN/DZj74Cq1KNdv0cRbpuWKwNd1guXS/9aPusxUeCstAdvpJ0rZPhwCPj9q8jzv8DNaSxDQhQBCJfRwPy4smm0SBVmCwk1DOAml6pMTIqwmrw74aVswmorrARsE43eHkI6kGNcHqfSGoAXYpBtRBJASfXUfEo0aS/NnSumQ+YY2hIpxdjj+uUyrHWqA6DCmec/Ywk5PWAL2uYCFHOPRFYnkkuTrSrDVBB2O/x3tF2Ms2XnAW0O6l4g9qF8qBNAub8dOiDGXc+2MfI6YQY5Wj+fHt6HZ1tk6BlRCvGDbQhqg0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzljRG1jRm1NQlgwZlNKaDNWeWNNRERxSmx1UXp2Q2hsQU9DVjNSWUNxY1VM?=
 =?utf-8?B?OGw4SWlmaHNBRVFnREx4ZitCUVhLNVJxay9nN2gycXFaNXdjVThSSTVMTURL?=
 =?utf-8?B?MUpOK3JDK3M3U3pEKzcxWmYyOEpTck5nNVlCK3RsMkRWV0VtQ05Pa1RTNnZr?=
 =?utf-8?B?QjcwcVpReElSOG9uU2dyUDNBVndKRVVFcmVPMUJYaG81KzVMMFpZUXVYSW5X?=
 =?utf-8?B?WFJ1NUZnSnhOL1MvNkJVUEdiQ2dma2hBaUVRN2pabjFhM0FqYjRxYjk0Wjgy?=
 =?utf-8?B?emVRVVdNUWlOcThCejM0ZkIyMzFRYXhaNXFqVi8vdU91MnZPcWdNbVRmTDdy?=
 =?utf-8?B?L3IrZGM2R2JxWjd2VnF2Q25VZXcxWTdBVFJGRUZZQ0hwTnpGUlFXeUlhMUFB?=
 =?utf-8?B?aTBaSHBmMmc0SDlqZlJ6SUU1UGNDUmgyU0ZGQ3hnSHhRcFBKd1hlSHdiSm41?=
 =?utf-8?B?WmhTY0s0eHBkZlkveWd4UGN4UTlvL2lUc3AwOGw1STN1eSt4bnZrTXJJejV5?=
 =?utf-8?B?SHNQTENOZ24xOG1Jem9SaTljdks5L1NCaEdDcSt6VDNDNUNCTVlGOGdBSjZk?=
 =?utf-8?B?d090VnNyNWZpZHdQaUxZZDBJei9BZnRzT2pkZjZrNVZTS2R1bkRWVy9NaFNS?=
 =?utf-8?B?S0VYZ25BMmhOT2xzak9FRDlodzgvQ0tXdTc2K3JCcEYyamhVTk1kQU1qOGZK?=
 =?utf-8?B?eWpxVUxOWEFnSk9jVnllMk0vMDFscGR4Nml1Vi9BRmZIUVU1dWlxbGVmMTM1?=
 =?utf-8?B?bFNVYkRCaXlxSHg1RjdLa0E1aHRCbnZlb0hReVlRMTNqa3BrdG9aU1g0b1dR?=
 =?utf-8?B?ZWNDV2tTYy9XaUk0c1V1bit6bjd2aG1VOUt2M0UyUGZYcjZvYm5lbWVDTzJZ?=
 =?utf-8?B?eVZXb2ZOc1JDK0IyQXkxQkFwKzU2a3dYNFI1MEhaSGRPY09TcDl4OS9BQlhR?=
 =?utf-8?B?ZXNPL1MxaHQ4a1NhMWhURDBSeUZBTUF2L3J2Zjd2Q1RxeE5GcTVoZERVMEpE?=
 =?utf-8?B?b3Fndnl6TjJJeU5YWTB1ZUttOGFUM0cxZm1pZXpQcGErUS9CbVBuWjQ5cDd4?=
 =?utf-8?B?RHNwUmhvU2M2bFNTdTZyM1llcEo3dDB5OTloUTBTQWpSakw4c3hNUWxsMnhR?=
 =?utf-8?B?c2RMMUd2TERSWW5tYkU5dVF1d1FMUksvY25vRmlsNmxvcGN6MjlsOHRJZWgy?=
 =?utf-8?B?MEl1eXVBcERUQXRzdTlNTFZHWkM0MlBqT243WTlZcWsvQk5CeEdZcGhqUm9p?=
 =?utf-8?B?Q1FXUzRFK3VYUVNkMUZFSkhINTFjcmNnT1NtRmdmRFJCUXkzdy9PNFFhNE1p?=
 =?utf-8?B?UHYvOVBvdHNnVWdQNFh1NVQ5L1h3VEY0T3hWWGNOMWZJQ3BzNDR3UWJuY2Vz?=
 =?utf-8?B?RWFwN285UEhKKzl3ZXk0MzNLaG1tSkhyM2EzTTlDM0Y2MjBEZStvcnNBdU1h?=
 =?utf-8?B?Mk9PMVlaNCtqKzhPUUJxWXBzcFlsazQ2Y1BRQ3M4ZXBTV1dCMDVZUk16WTky?=
 =?utf-8?B?eG5mTnFZcTZYYzBsd2o5bkM2SjkxR1FoVXpLaUVyYXhENDZhdFAvZ3NUdEZu?=
 =?utf-8?B?YjFoZ2FMVm81ckVUbGMweDRxcU1EdnBLYnlQTmhINlI3ZkdzL01KcFJIQzly?=
 =?utf-8?B?djVPSUFpTUs3N2hXc3Nkd1phaHVPTGNnR1hYdFI3Q05rWE0yUnhmWTZxRXpI?=
 =?utf-8?B?V1BPWi9aUlJOaEZaTm1sbUVKN1pHZUJkR3pGK0ZDd0lkS0hmYisvTDFKRW9s?=
 =?utf-8?B?QWJ0NndIRWszZ1BIUXJqKy9zWncra3BJMnhidVMvQ3RCQ1lWZTVzRTZPQ2Yz?=
 =?utf-8?B?S0hOTnJTWFJxT0J4WUtMRGJaK29DbWU3cmJGMGxZaW94TWR0cm9OQW9hd00w?=
 =?utf-8?B?NmZmTWhQMFV2Y0Vja1g5RmZYQld0Nml5bzFlYmFKTXRmSzZRU0FKbkNCZlpt?=
 =?utf-8?B?YzZtKzJoNTdmT2F0LzNNWHdTYXBSdXpLek51N3FtUFIwODEwazNqK1MrSE5j?=
 =?utf-8?B?N2RMM0xFNFdZbVFZNC9kY3g3aUl1d2NYWldNSVpzbDRjTEdyejRCRmRmam1D?=
 =?utf-8?B?ZVU0NG44SklqQ2xnalk3d3Mya05ORjJLamNoRE9MRjVrUDNzWXNNaHZRNHBh?=
 =?utf-8?B?WEo0UllwdlRoQXAzdURPbVlZZmRqaHNjUVgyOTlKYzJmd3gvTnAraFJGOTln?=
 =?utf-8?B?d1VFdUZITHl4aG40OEhoVldEUk8zdXVVRWdlTjNoYTFiUzFFRkdtVFFGYWRv?=
 =?utf-8?B?WFFjdm0waXhLbDBPaFNhQndKWHhVZ2lGRHIyZjBvNG5Qbys4d0RlcXZ0ZGlp?=
 =?utf-8?B?NkRQSVBEZUJFM0xqVTkrbElGbGlWWmtzSVFCMVlEMi8zY0xaM1p3dz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 244a7cde-4741-4771-9edf-08de8ef2f6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:58:50.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1dUpSASEUuEkIypH0edlO0z5h8CpDagbJxP1X1upkhQzZlWc4lI8fc5TZ0qdiTujU3OxCA2t+qjgIAYrU6J3PXM64iujddYw/Ivt0KucFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7127

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyOCAyLzRdIGR0LWJpbmRpbmdzOiBpMmM6IGFzdDI2MDAt
aTJjLnlhbWw6IEFkZCBnbG9iYWwtcmVncw0KPiBhbmQgZW5hYmxlLWRtYSBwcm9wZXJ0aWVzDQo+
IA0KPiBPbiBNb24sIE1hciAzMCwgMjAyNiBhdCAwNDoyMTo0N1BNICswODAwLCBSeWFuIENoZW4g
d3JvdGU6DQo+ID4gQWRkIGFzcGVlZCxlbmFibGUtZG1hIGJvb2xlYW4gcHJvcGVydHkgdG8gaW5k
aWNhdGUgdGhhdCBETUEgaXMNCj4gPiBhdmFpbGFibGUgZm9yIHRyYW5zZmVycyBvbiB0aGlzIEky
QyBidXMuDQo+ID4NCj4gPiBBbHNvIGFkZCB0aGUgYXNwZWVkLGdsb2JhbC1yZWdzIHBoYW5kbGUg
dG8gcmVmZXJlbmNlIHRoZSBBU1QyNjAwDQo+ID4gZ2xvYmFsIHJlZ2lzdGVycyBzeXNjb24gbm9k
ZSwgY29udGFpbmluZyB0aGUgU29DLWNvbW1vbiBJMkMgcmVnaXN0ZXINCj4gPiBzZXQuDQo+ID4N
Cj4gPiBUaGVzZSBwcm9wZXJ0aWVzIGFwcGx5IG9ubHkgdG8gdGhlIEFTVDI2MDAgYmluZGluZy4g
TGVnYWN5IERUcyByZW1haW4NCj4gPiB1bmNoYW5nZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFu
Z2VzIGluIHYyODoNCj4gPiAtIHVwZGF0ZSBjb21taXQgbWVzc2FnZSBjb3JyZXNwb25kIHdpdGgg
YXNwZWVkLGVuYWJsZS1kbWEuDQo+ID4gLSByZW1vdmUgYXNwZWVkLHRyYW5zZmVyLW1vZGUgYW5k
IGFkZCBhc3BlZWQsZW5hYmxlLWRtYSBwcm9wZXJ0eSBhbmQNCj4gPiAgIGRlc2NyaXB0aW9uLg0K
PiA+IC0gRml4IGFzcGVlZCxlbmFibGUtZG1hIGRlc2NyaXB0aW9uIHRvIHJlZmxlY3QgaGFyZHdh
cmUgY2FwYWJpbGl0eSByYXRoZXINCj4gPiAgIHRoYW4gc29mdHdhcmUgYmVoYXZpb3INCj4gPiBD
aGFuZ2VzIGluIHYyNzoNCj4gPiAtIGNoYW5nZSBhc3BlZWQsdHJhbnNmZXItbW9kZSB0byBhc3Bl
ZWQsZW5hYmxlLWRtYS4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaTJj
L2FzcGVlZCxhc3QyNjAwLWkyYy55YW1sICAgICAgICAgIHwgMTINCj4gKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2FzcGVlZCxhc3Qy
NjAwLWkyYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJj
L2FzcGVlZCxhc3QyNjAwLWkyYy55YW1sDQo+ID4gaW5kZXggZGUyYzM1OTAzN2RhLi42N2IyM2Qx
YTRjZWMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2kyYy9hc3BlZWQsYXN0MjYwMC1pMmMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pMmMvYXNwZWVkLGFzdDI2MDAtaTJjLnlhbWwNCj4gPiBAQCAtMzcs
NiArMzcsMTYgQEAgcHJvcGVydGllczoNCj4gPiAgICByZXNldHM6DQo+ID4gICAgICBtYXhJdGVt
czogMQ0KPiA+DQo+ID4gKyAgYXNwZWVkLGVuYWJsZS1kbWE6DQo+ID4gKyAgICB0eXBlOiBib29s
ZWFuDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogSW5kaWNhdGVzIHRoaXMgSTJDIGNvbnRyb2xsZXIg
aW5zdGFuY2UgaGFzIERNQSBjYXBhYmlsaXR5Lg0KPiANCj4gQ29tcGF0aWJsZSBpbXBsaWVzIHRo
YXQgIkkyQyBjb250cm9sbGVyIGluc3RhbmNlIGhhcyBETUEgY2FwYWJpbGl0eSIsIG5vPw0KPiAN
Cj4gSG93IHR3byBzYW1lIGRldmljZXMsIHdpdGggZXhhY3RseSB0aGUgc2FtZSBvciBjb21wYXRp
YmxlIHByb2dyYW1taW5nDQo+IG1vZGVsIGNhbiBoYXZlIGRpZmZlcmVuY2UgaW4gdGhlIHByb2dy
YW1taW5nIG1vZGVsIGZvciBETUEgKG9uZSBsYWNrcyBpdCk/DQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQpUaGFua3MgeW91ciByZXZpZXcuDQoNCkFsbCBBU1QyNjAwIEkyQyBj
b250cm9sbGVyIGluc3RhbmNlcyBoYXZlIERNQSBoYXJkd2FyZS4NCkkgd2lsbCByZW1vdmUgdGhl
IGFzcGVlZCxlbmFibGUtZG1hIHByb3BlcnR5IGFuZCBpbnN0ZWFkIGV4cG9zZSBzeXNmcw0KYXR0
cmlidXRlIGluIGRyaXZlciB0byBhbGxvdyB1c2VycyB0byBlbmFibGUgZG1hL2J1ZmZlci9ieXRl
Lg0KDQo=

