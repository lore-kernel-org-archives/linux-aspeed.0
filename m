Return-Path: <linux-aspeed+bounces-1300-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679BBC5AD49
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Jun 2025 00:46:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBpm63Ltjz2yKq;
	Wed,  4 Jun 2025 10:45:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748997958;
	cv=pass; b=FhxhVrfauexqqxvxFQ0gKXbTvDco2hKcCTlOcDKNGKFZ13s9FMETMSZXuMKInV0c3uGEcaohzEjY4SZP0yQibyDh9X3kpPiIDkqg1Fdu2MEZY1UYUbz4mefPmUZuwWJXjU5cszyTOPwv53fUV7tHqXx0YYcZCIe4j1HwMGleJ1WoM8c0KeB7D9xDB78WfSIBEp2V/0JkM6wq1FWAoPLHg7b5672IpH1W7qfO2qfmIMgcdf+KdN3ACYAFtyKeEcrkarLxrLrAOCAZ8OpXFZED6oomiTCYzFkxtehy8dSCThK5MIeEnPapQLdp4b34G68jgbeMIPV9mYyHRWoVXvphGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748997958; c=relaxed/relaxed;
	bh=Kw8OnvcsPsWSk3lIwU/BsJfQ6QC9jrBtfp1ggOaxzsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ng8QMv+0L15dRPj0MQqUCaCC4zoRX+iq8wMOkapLw1h38Et/sc3QpwsNmW0eE1zORLxBIT26beS8VK79RmAMvLnZhBQ/kbBVwniidpv/R6l5+U6ujUq/y0NLybhL9eNB9LKGN9jdO1ip6KgnxAL/OqBoatkWe9/JY3kIIfmB6f72pNZ9W8UfpUTZJ3y76Q7dgMv5xj/xkg4wZn+V9E+gJLmRk2yUEzLclw+ygmI0yJ6ECCflLovuetmSfy7hws9mFCu3O3DG967VJuoX2j+LRpKU2uJCAZtVEMHwcMBFRDWuv5UAc+9Cn5AMlVqps4/y6rxXo2y2YbW5MvjlSzcvyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=aB9DGsxd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=aB9DGsxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBpm3605Lz2xYl
	for <linux-aspeed@lists.ozlabs.org>; Wed,  4 Jun 2025 10:45:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EASkn0xSm/tUW9lgJ3AZZ5b5o4kNcgoHllqq7glU/l9ShGPIbtRLZiljSaiBGpzsytbI53toFWvcgRFs6O3YLMFsZVGEeqF5h1oDVx/SkdRaeMtB7GDlYkh2pHycHHagQgup/7LPgTDx6bE+VIflAQ23hexw3AVeC6MSdK5SlDLq6aWc09Fl2l5vx4I2kC0TN7NPTi/QFAJawkMZ+VjsEOCmpLnuLYrNZhhux8s+/0znLOFfdZM5QpWv+Hn0L36ddbWzpTHxVl0PCZvalirXmQSfP7Ps93A8Z/qAME6VS8EZwi8rIS5/f9YLQxjQUnYRdAGP/U+akVwvo95TAFSl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw8OnvcsPsWSk3lIwU/BsJfQ6QC9jrBtfp1ggOaxzsY=;
 b=TCystCULUgi0JfQ+48Yr2KOrIw1BPI4s/xoVmRF+TqAN2hbCGPHB8hl3GK/nRuKLAEiR1+l/G+en/dD2yjPInFY3PLyTCzrDsZkS/PwhDNhllIPKabmYvMhjxM92b/3kWk5AZWR9/ZaGjTTCQKQkQtuy13QD+HkzzWgqT9oCtoiAEh7+h84YlaPTQvAGJI90EtCizoY6eLgAd6WLoS2wrcMyVI008uNfy4higvfk18P1YgZXv1iul4XXWQoY7B7ZS3EJJU1+/a/0Hj1sqBGRldnFISB25Z8pG8pnI9EV0GqPRte+i3mN7rHGWtWCBSyRO/Ty4QX00Jus1K33Ji7C+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw8OnvcsPsWSk3lIwU/BsJfQ6QC9jrBtfp1ggOaxzsY=;
 b=aB9DGsxddxeY9/waWG0BuVXxENKO/x4oXtxUWygYPkQ8qnf9ySeK3rDn03V/PGgh5XDn8Y2IrgM1pRXB+T6olgywfIHOzVgKeMoCfUcgI+U0RHtW3FTx3QldCkYQBOAuPHyLUeuhPjGFMdv0cSAOUOVOZJT88YILNQ6+zzrR+T3YKGPflvDSEDzRVPFFM9b/FFc37NB9GMnGaDG83rhErJtSZswQLcAvSInpwhOlD+3R+ovGa+G7+URbSZJR/LO6H2ZLORZD09J+Fy9SAw91JXV+7OTFCrBbKERCPF7vCykLRZWgp7hPdQFGO6ptCT3vzlUxun5ZFwKDYEpZRGXy4A==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SE2PPFD1755A465.apcprd06.prod.outlook.com (2603:1096:108:1::7ec) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 00:45:28 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8769.033; Wed, 4 Jun 2025
 00:45:27 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>
Subject: RE: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb1FzMRCeMloEvSUe4D9FkwuM83bPxLu4AgAD75cA=
Date: Wed, 4 Jun 2025 00:45:27 +0000
Message-ID:
 <TYZPR06MB65688BDEAD5793E61B32703FF16CA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
 <20250603075450.133604-2-jammy_huang@aspeedtech.com>
 <174894375223.360822.13996455735829436919.robh@kernel.org>
In-Reply-To: <174894375223.360822.13996455735829436919.robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SE2PPFD1755A465:EE_
x-ms-office365-filtering-correlation-id: d517beeb-67ad-4b72-a705-08dda3011984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?em10dmxyZUxmZkgxNHd2Zk1NWkhZaHArWE9RT3FTcVJ4U3NpNnUxT2pwSGYx?=
 =?utf-8?B?WWRPb1pOa1BLVU1UNE9ucGdJM1I3YmM1SVNaWFVSbGNZVEFwZEt4R2MzQ1FK?=
 =?utf-8?B?NjVZWlBReTVDSkpib0VYekxKRVQwUFlqK05EZU1tclZZRWowSi9KTUp6UkZJ?=
 =?utf-8?B?akh5bHl1ZmRQVTV5akZVc2MrQkpYS3ZEVG1UeUEvTTBrckYrSXBxc1JtbmMy?=
 =?utf-8?B?QndGTzFGdGlLZCt2dTdzbVpqcFNESG16QU1XNUYvNDZVKy9GV2dhb2Z3eVc5?=
 =?utf-8?B?azdNZEttOVpvc1NwUXlaaDFsUXFDKzUrWjlPVlAvaFpDUkcxeE9GelB5RDcz?=
 =?utf-8?B?ZXh3UVVOaXg0YVhYVm5ZZnAxK3loYUp1OHBLSk93YW9mb3RVNWZHblhEd09C?=
 =?utf-8?B?aFh0T0k5SXJXZm1jUlErMkhPelcvYjZiQURrQ0F5dkVEMzdHVW9Zckl5S201?=
 =?utf-8?B?YkxmelpPcjAxQ0QrMGxVQWJ1bCtlRnhJbjMvalN6cDRxbWhJYjFVYWtXNUZr?=
 =?utf-8?B?Ny9uSzI2RVRXUVBncHJWeTBZU25wakVtaFp3Z0t6cklxM1I4UkJqVTRoYmZM?=
 =?utf-8?B?R1owdVpPTzhtejJMRHZ5dWFSMFpTUm13dXlaWjZGamprM1VKWG9uUHVod2dH?=
 =?utf-8?B?MjViczlCclZZaG1ueHZpZ2ZodytZYVV2VS9pK0tTMXFBZHhOaVc4VjRKNjNK?=
 =?utf-8?B?ZE9BeW8weVpWT0F5UkFFYmpXUncweGN6NmJlNHB2QktXK2N6dzhQcDBRUjJP?=
 =?utf-8?B?SlZ2WXFMM3Iwbm9jaUpOcjBidHJ6c1Y3RmNLWjNHbHRpTmNyTW9Idml1TzQr?=
 =?utf-8?B?bWkwVVN5YnoxV2VHWE1CWjk1dkdHM0FGMk1pT0llT3VZVGQyQWdlakE3OXBk?=
 =?utf-8?B?MHdtdEo4Nmp6cmZpdzRPZ3ovWHFIbXdlNEN4RlgwMGtxWE9kT1dUMDUyLy91?=
 =?utf-8?B?b0xHdmF0ZWF2ZzkwbllPRFlSN1V6QXRLa0tWS0IweVpIWStuSkVhNDF4aE50?=
 =?utf-8?B?QUl3M1FQRFFDa1VuK3F6K2krWFdnZE5JVzlEVE9IbU9iRmM3TXR6RzNJNUVG?=
 =?utf-8?B?bnQyeUxJNlREcHhLL0ZUNXM5anV0ZzRSVUg0OVN1K2xMQzYwOTloOGQwNmc3?=
 =?utf-8?B?eUVPYkc3ZEV6S0pkTnVIMXpnckhaVzQ3bmxCNlJ2RCtta2NYNk8zQTR2MUlE?=
 =?utf-8?B?bXNuaDRjWTdHa09ralNqY2NKUG9JYTdYTWExSmY1M0QzZlBVL0M5Wlo5dWJu?=
 =?utf-8?B?TFFralk3U21JY0JBazVTWHVKSk9OY0pabDN5S3FuaHpyenVIdlpnakxrOTJl?=
 =?utf-8?B?SmxyWkRNbzRmalFvNzJFV0xyaHZMcFFoMitBMzBSWTlscW14UGFwdDhiNktN?=
 =?utf-8?B?MDBjWTRnTlVyUHlkZXpHNDFBakcraUtLVW1saFhGb0FaTGtQUTlkVjI5UFUz?=
 =?utf-8?B?cktXU1FXUmpMVzZxTjBxZHlGSmhLTFQ0Y1JSYk83QVJDTTFNbldya0svWXpl?=
 =?utf-8?B?MUpMKzVCV3N5WDR5THZvajl4a1BJMjNNeFo0Nzc3SGtCQmZZa0xKUE9hNnlC?=
 =?utf-8?B?Q2N3dllDM2VxS0I2eStiSjZ5b2o4U3ZhTnZmNTEzVHBNeSswYXo0L0dGdU5X?=
 =?utf-8?B?U3VkT3l6UkFwTFJwMkUrRkVrWEpqRkJQVEQ0TkxCWncvSHRYSU1sdVFrY05W?=
 =?utf-8?B?VklsSUg2YytrMHpiQnhNWXM3Qms0QWpUdkFpNU84MVByN2ttM0NRUFR5cVE4?=
 =?utf-8?B?QlFZMXl4Sm1Ec00zalJhMUxlNmI5OGl6bnVLTjh5QWF6MGVxdVVleHBJUGF2?=
 =?utf-8?B?UnN6TVFMRS9XS28yaE5naEFQdlpuVEhwZWdlblpUc1R2eHJlK3hZVkZkVXBY?=
 =?utf-8?B?Mk5uN3d6K2pZb0tUcWhSK3hJZ1NpNnBtUUVIVWtxNVQyTW1CTkIySmRhdW81?=
 =?utf-8?Q?7jMZbpbedKI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWx6bEFMZjBHdDF3eUFIbGVnd2E5L3Q0L3hHVCtGNllMSW5rR09rU1M1MllP?=
 =?utf-8?B?blVSWmxtR2lRajJ6MlRSVzYzTlZkSGl2c1FOUnhwUnFPS0I0cU0rbU1NWHpK?=
 =?utf-8?B?eVJGZktmWmVSNTY0VHBuUkJDNmtxRk5ndU03TFNnZ2orNlhYNzJHOVM1Yjh5?=
 =?utf-8?B?Y2xvQ1hNRDhlNjJmU0ZpQnpsbDVmcVRVMGZDQVR0U1BSSmdFT1V1amYycStR?=
 =?utf-8?B?bU92dXkwK0lyNFRVUHM5UDNwVnlMUWZEQkFCUlNPcUkyYjlrdTlINVNlNHdK?=
 =?utf-8?B?Z2pCQlRqSDFKV2JTNzhleldSeWtQelFEL2ttaGhrVThwbkNwQkZlKzdKanlC?=
 =?utf-8?B?bHJWSk5Ya1U3VCtrOTA2YWFwc0JoNjNlWThIaU9FVVpOcG5MOTdzU1AzcU1I?=
 =?utf-8?B?c3hyRkVtVkt3cC9tNGIzZmt0cjhreWVNWm9yWFhWbkNMZCtobjNvaDdwV1JZ?=
 =?utf-8?B?akVSN1M1UGRkT3FoR21oaUQrWklJUWJNOFBwRC92M2JPbXZDQms2cm9vcnh3?=
 =?utf-8?B?QjdaZ243NEVzR1B5aGc5QXFEQlEveDRkUjlJOWtiQjIyQ3Q1SFNuQXJBNlZk?=
 =?utf-8?B?cjJzazdSdzZDNnBOMlRzcFFsYVFCYTllSnJIRWZRNHJ3ZURPeVowYi9LS0h5?=
 =?utf-8?B?dHpCMlVpOEJ0MkpENTB1bXN1TjhUaTI5ZnQrVTdoV2d5NHZTUnNVQ0xrVEd0?=
 =?utf-8?B?NWMvdDdVUU1kM0h0QTIwUjByVHVTakIwbm9SQXpZdnQ2V2diZVQ1S0pwalI0?=
 =?utf-8?B?V1M3SkNFYjUvcU9QY3k4ckFjSVFObFFzaWxCb29VZjlqY2NVYXd6VWdqcUtN?=
 =?utf-8?B?RW1UejI3RW9RZExCMlRIZ3pMa0J1TTlSVW00TGRJcGtOZ2YxZGx6djlUNWpM?=
 =?utf-8?B?dkJlYmtQbnY1N253WW1QOE1qMG1aY1AybFpGTlBhSDJwTVlsakplbFJ6aS9n?=
 =?utf-8?B?S0xXSVB3S3ZPRXhGV2kxOHQzd01ianY4WFR4L2tLeDQrcnQ4c0JqWEtHWkVa?=
 =?utf-8?B?MTRXRVJ2ZVA2am1FOVlSWnd5cXN6clkxQUZlaDN6QTdJVWE2U0VSK2kyODh4?=
 =?utf-8?B?bXozRTFiS0tVQXVLd0NaZmE1MkxzR1ZoUWNLNFRSSVVHdlY0OUFFanluVW8z?=
 =?utf-8?B?dmx6RVNiYXZ6QkVhbWdHbDZEcnlON3FLeEJwSHMxWTF3Q0pmYkIrWGF1eFd2?=
 =?utf-8?B?WEVOU1k5b0NhdE0vbFVuck5TVUpRQkFqTmtTVE5TbnlxMDZRZ3RVSVFjZ0hN?=
 =?utf-8?B?SklmRWtTYm9FN1ZnNkZLSzVqOTNjaGs4Q1J5ZFVCR04wTmtCbzdTRzVoeVhr?=
 =?utf-8?B?emNMRXRCeHFhTlpPVjVhaFNLeVZsU2hZSnczV2o2RFFyQVVSSFd1SGxMRlpz?=
 =?utf-8?B?THFEZ0FSTytTZ1RVTFNmU1BzQVdUYk9wZFlON3ZqcjJLVHdYSWc3Z0Z6WWFl?=
 =?utf-8?B?TGVBcXhTOUptaDJNZEIwMSt1bFRnUlpUdlBJenBkSURmUlJrNVdHTmwzemlL?=
 =?utf-8?B?ZXpnRUxPa0F6TWozR29laEpBYWt4bDd3RjRUZGJMM2pmaHhPSWZZd09pNzc1?=
 =?utf-8?B?cTVjMzREN1gzQUNDcU5nWlJMMmpiZ3FsYU1EdUpBNE1jek92ZCtObDNmUkNQ?=
 =?utf-8?B?MWp3RDgvQ2ppZEpnaXFOZndUUFZBUHg2MG01TE9PMDJrQlA2Rm1WVGx5MmFR?=
 =?utf-8?B?VjJ4M2tTNysvT3JlYnZzMElOTWUxcDVnU1hZUEcrNysyeXFTM0FtbnpXOUpI?=
 =?utf-8?B?SWEyOU85VWNqNXo1YzlsZHd6UmNIZTZobnNvR21BMWduVVR0VWVxb3BXNm9S?=
 =?utf-8?B?UUVjaC9DRlpUeHdkR1dvWWsvTjducG9hMzhEa0ovVzIzc0toL2ZaVkY0UmZM?=
 =?utf-8?B?Ui9FM1pEODRaMkdmajArcWJYbVVSRFNrckFFVWJZdEhPcHh4TXErOWozWEdQ?=
 =?utf-8?B?RFNmcWt4NFNXU3RxN294RjdPUit4c2hrN3l0ZlFRVGlId2E5MnlsM2RiUUtl?=
 =?utf-8?B?d2NNUG5JRWR2YUlhYUVQZDBrc2U1ejVVMmMrYlRTeTRjVzhiNXUxeTVuRUM0?=
 =?utf-8?B?dS9kNEhwZEtkTXFvRlFNc0Q3RHVCVjFzMWxKZUptVnBnVnYycXRVQm1sck9N?=
 =?utf-8?B?aXllZHFKbFNZTzE3M1hvTERNOHpRbHdBM21Ta0xJU2p6ZHFXTTRSTVVpMjV2?=
 =?utf-8?B?N3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d517beeb-67ad-4b72-a705-08dda3011984
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 00:45:27.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXd/H2Xe50mPeHbbYrZieziimlrYkNpER18DOly61xctHc93m9z6xuA/rkGdSv9WQb/UdlK+sDtVhLojmEWCsh3VKFXhMIGJW0zr2M0Srp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD1755A465

SGkgUm9iLA0KDQpTb3JyeSwgSSB3aWxsIG1ha2Ugc3VyZSAnbWFrZSBkdF9iaW5kaW5nX2NoZWNr
JyB3b3JrcyBpbiBsYXRlciBwYXRjaC4NCg0KUmVnYXJkcywNCkphbW15IEh1YW5nDQoNCj4gT24g
VHVlLCAwMyBKdW4gMjAyNSAxNTo1NDo0OSArMDgwMCwgSmFtbXkgSHVhbmcgd3JvdGU6DQo+ID4g
SW50cm9kdWNlIHRoZSBtYWlsYm94IG1vZHVsZSBmb3IgQVNUMjdYWCBzZXJpZXMgU29DLCB3aGlj
aCBpcw0KPiA+IHJlc3BvbnNpYmxlIGZvciBpbnRlcmNoYW5naW5nIG1lc3NhZ2VzIGJldHdlZW4g
YXN5bW1ldHJpYyBwcm9jZXNzb3JzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtbXkgSHVh
bmcgPGphbW15X2h1YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbWFpbGJv
eC9hc3BlZWQsYXN0MjcwMC1tYWlsYm94LnlhbWwgICAgICAgfCA2MQ0KPiArKysrKysrKysrKysr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWls
Ym94L2FzcGVlZCxhc3QyNzAwLW1haWxib3gueWFtbA0KPiA+DQo+IA0KPiBNeSBib3QgZm91bmQg
ZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4g
DQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5n
cy9lcnJvcnM6DQo+IEVycm9yOg0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWFpbGJveC9hc3BlZWQsYXN0MjcwMC1tYWlsYm94LmV4YW1wbA0KPiBlLmR0czoyOS4yNy0yOCBz
eW50YXggZXJyb3IgRkFUQUwgRVJST1I6IFVuYWJsZSB0byBwYXJzZSBpbnB1dCB0cmVlDQo+IG1h
a2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5kdGJzOjEzMToNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXNwZWVkLGFzdDI3MDAtbWFpbGJveC5leGFtcGwN
Cj4gZS5kdGJdIEVycm9yIDENCj4gbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4NCj4gbWFrZVsxXTogKioqIFsvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNp
L2xpbnV4L01ha2VmaWxlOjE1MTk6DQo+IGR0X2JpbmRpbmdfY2hlY2tdIEVycm9yIDINCj4gbWFr
ZTogKioqIFtNYWtlZmlsZToyNDg6IF9fc3ViLW1ha2VdIEVycm9yIDINCj4gDQo+IGRvYyByZWZl
cmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUNCj4gaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvMjAy
NTA2MDMwNzU0DQo+IDUwLjEzMzYwNC0yLWphbW15X2h1YW5nQGFzcGVlZHRlY2guY29tDQo+IA0K
PiBUaGUgYmFzZSBmb3IgdGhlIHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIGxhdGVzdCByYzEuIEEg
ZGlmZmVyZW50IGRlcGVuZGVuY3kNCj4gc2hvdWxkIGJlIG5vdGVkIGluICp0aGlzKiBwYXRjaC4N
Cj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlk
bid0IHNlZSB0aGUgYWJvdmUgZXJyb3IocyksDQo+IHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcg
aXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAgdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMg
aW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3Vi
bWl0IGFmdGVyIHJ1bm5pbmcgdGhlIGFib3ZlIGNvbW1hbmQgeW91cnNlbGYuIE5vdGUNCj4gdGhh
dCBEVF9TQ0hFTUFfRklMRVMgY2FuIGJlIHNldCB0byB5b3VyIHNjaGVtYSBmaWxlIHRvIHNwZWVk
IHVwIGNoZWNraW5nDQo+IHlvdXIgc2NoZW1hLiBIb3dldmVyLCBpdCBtdXN0IGJlIHVuc2V0IHRv
IHRlc3QgYWxsIGV4YW1wbGVzIHdpdGggeW91ciBzY2hlbWEuDQoNCg==

