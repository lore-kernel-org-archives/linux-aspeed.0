Return-Path: <linux-aspeed+bounces-779-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F8CC021B0
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 11:59:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyZh63p4Wz30P3;
	Wed, 19 Feb 2025 22:59:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200f::703" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739966390;
	cv=pass; b=YsYkydvghHRq3cNzE1eEBNzh0whbBGTXe/2hDNlP7rWNAwRZ1pH4Uf6l00P9BElWQOxPQf7KmT1IwnKTS7sCypWJs+q1Rh11IdUhTyrONJjOhSFag/Aq07o1F47ZtwSKxkBxRc48Xh05RUooaZ88QNmZUGatzRly87pzWCkSg95wlIWscMUwuAzcnNpy7JV7ANFzWMo/TukU38zzOndOa5z7FZlJNjZNvVLk63VQ6WK52blIWTyGS97GWfp71lkBGdLJg9hC2ru9mCeuBQsAC/IDLmOOfHnrAfp+lL5yVEi93Cp7+t5WFv1yj1vMyiPYx4FdxaTvLalR8f4J/CIAdg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739966390; c=relaxed/relaxed;
	bh=B5lXIkCDM0mEOFAmvuK9KXq6FWTHiiJjV0qN7Nw0//g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lfOIu5fMoWEIb/KMAXbB18JImrEzzl81lC2//7eGNOXo6mJEFcYkEvxSnRZwnwRLLhZXQ24+jh5xDBxl0xscsW03r38l08nn1m2T+W2GLSKHvkSf88DvOXTZSoA5mnZdmwZtiw5agSXjd1YqYGX0SiGvBX6TN0UZi2OJKrrmMOxbgVgrOl0fea7cZNt/n6RKB8kTjwswzagjxEsaklzgDUKgmqGKC/+3SfY2VCM/9pB53qfDGWkM9ioCf6d1YFZ/2N7GfSSWDdy+N51o3hMpxY0nubuw3HLaf5Yn6tNFZ19SR9ycV4TemRm0/P4OKuzeJXsSR6xes5g9HUr1ZGl64w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=Epd8HkIO; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200f::703; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=Epd8HkIO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:200f::703; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on20703.outbound.protection.outlook.com [IPv6:2a01:111:f403:200f::703])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyZh36Tvfz2xtt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 22:59:47 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2gpjnT6C0S4yxF6I7ApodhxP7cMYNxkuLYX1Itdf/1cWN7jIBDXMRVviEFId7oYtsqnWyU4N+1m1wULEliun1jkFFmSF0RMK6+d1IBcWuF5kjZDz9jbYiOiTvOEIiBtHZ6M2Mbbaltv4BLsjwrgTDPzRIbw1axiITAu8H41HsxVv+wROB6Srz8kObRD5kusKiaTOF+qe58RfHU85lfSMXUvsHZR0ZJzRk1lUIUug+Fi4RpZTqBa7b8KGAg5q0xMqIuVq+6vTWmdr9IT4d655qvDPcxe1QR4RYNJnAIKaQDuz7LiPGeDeMb1PijnqEknXfQe8bDAs8CCB1krEI0zTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5lXIkCDM0mEOFAmvuK9KXq6FWTHiiJjV0qN7Nw0//g=;
 b=YKr4ZJgnoKAY6YExHHa143LvLWnHGdGoVRdeeoPi3matfih6+QbYpV7RZbFkVN6y/tKAVfqLfp49dJg06N/1F0lyxqNMiHzNd2XZZZKGNTWxB/8xc0FrWgI1SWgvjYXww79FeVyhbZ5qtCN0bZ6NWmt9fN+WL5hRzBCBad2Nn4Vw1LD1aSttnJrNpHdJDk7r1ukoT9qTmzIJtGIxRHMVKsZZP0tyX8qKw+eI3Ddgpbtppe2jUsXUBkWcDaUsffYUoPwoqRyEt8kfL1ZymZH/6JwuI6i/An+YCK6f/fLnWKQxY8t7i8INrnAoPQyXSLnBw7wOiVGgKQWQH1KceRxeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5lXIkCDM0mEOFAmvuK9KXq6FWTHiiJjV0qN7Nw0//g=;
 b=Epd8HkIO86Dul0MT8zDQg2qmrZ+S45+ZLELvXAyitKHRCc9Aal0hV58BFSoASjI7wvKCmfChAICFe4zB/W9tfKdyox9qgllQ8HAu71DgWNDyueZ114QoV3Hg3ft/+xcX5TPooc6yvKTlOoomR8EG176NIebWAsPoiDttjmJ8yVBo2UWaj3W6XOmXkEnYV5UyD3S6VlytJFEzR4MNvKS5qAjh/gCQPTImtAJRgj5V2mPPVVlR4Q/0MhiCwhTmODV3O1NHRTpMIDiA2J+FI6v72tdoE0RcbDJQ2ESMcNVcLac+/OYdGCQiljCCbxUBPj6wxroZvJo9a3jk8SgLxd2a4Q==
Received: from TY0PR06MB4960.apcprd06.prod.outlook.com (2603:1096:400:134::11)
 by TY0PR06MB5007.apcprd06.prod.outlook.com (2603:1096:400:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.9; Wed, 19 Feb
 2025 11:59:26 +0000
Received: from TY0PR06MB4960.apcprd06.prod.outlook.com
 ([fe80::fad5:ac3b:a939:41e]) by TY0PR06MB4960.apcprd06.prod.outlook.com
 ([fe80::fad5:ac3b:a939:41e%6]) with mapi id 15.20.8466.009; Wed, 19 Feb 2025
 11:59:25 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "joel@jms.id.au"
	<joel@jms.id.au>, Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>
CC: tomer.maimon <tomer.maimon@nuvoton.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: RE: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Topic: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Index: AQHbgTHkHx9CTwRXuEqAh/w3KRppVLNLZMoAgADY0YCAAKoPgIAA6miAgACsmZA=
Date: Wed, 19 Feb 2025 11:59:25 +0000
Message-ID:
 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
In-Reply-To:
 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB4960:EE_|TY0PR06MB5007:EE_
x-ms-office365-filtering-correlation-id: 14740d38-f567-4aa4-bf3d-08dd50dcdb4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHBwdFZoWGNNM0lvdGkvVDM5K3NjWFVaMHdaandkeEp1ME4zclNtb3VLTU1o?=
 =?utf-8?B?dzlLU0llTWdNdCt4MEpWaXpNSlVDY0t5TUgvV2VVcnNHaGxPQ3l3d1NYLy9z?=
 =?utf-8?B?bFgvNFVMVGNpbDBsclJyclUzT0ZGMGN1WUk2LzBqRDFkZkw2OHh4WnF6ZDdQ?=
 =?utf-8?B?N3VjY3NUaEtjdm12c3ZYRGJxQ0xHbkFaQS92dGhNYVNLclBvVzJjUmoyWnRO?=
 =?utf-8?B?VEpBYmtRbUxyR1ZZK3k0eFdUZ1ZHdE9oWmRYUU5RZ2oweVlCb1hnMEZMSG5J?=
 =?utf-8?B?N29rNlZSYzVYR2ZSMzRSc1htQ05wQW5JMUU3bmwveVlkMDl2dEducGFHamQv?=
 =?utf-8?B?WnhsVDlaRmlsRzUzdUVwUFJCZnN1MXl6U04vS1VSNjg1cUx6OXdoV0RRMkpT?=
 =?utf-8?B?TGF2TUJnZkxMV25kTDBSUlRFSUdMb0NITVpBenZtZGo4VnZaK0J6czVFdFdz?=
 =?utf-8?B?cldyRHI0WGVDM0pZa1hQcTBDOFhlSGdvbWxIZ1hEQUZlTWpVZVh4dEZJKzZp?=
 =?utf-8?B?RGV4TTRlWGFyby91Lzc5N0tPSHZXVHg0eE1jb2dTSG5ZeUZISWNGbVlwczdp?=
 =?utf-8?B?Q0xGNExJYno4ZUZwVnNSOVhZSExVTFlSeUpIckkyL3pjYzJuWXZFRVJzM2RS?=
 =?utf-8?B?QmJORDZlSG41MWMydmozYkRVWkQvQVYwZnZrY1lvQW1yVGNEWEZCQzNmdi9T?=
 =?utf-8?B?ZGlleGxtQ2JkblF5Lzk0Rmd1ZFY5bGl3VDlodFRaOVRWZFBwclp2b0J3bmgv?=
 =?utf-8?B?SnQycmludFpsRFUrRElDUVRSQzFHRWpMVHhwbzBXc0YyYWpuRHh3bGVGMDZr?=
 =?utf-8?B?aGdHK1JjRmpGWlc0WDk3N2tKbXMzMldQRlZRT01ueWUrS00xeXRDQXlCbUEv?=
 =?utf-8?B?U2N4RVBHVHVMWjcvL0lYaFp2VVM3Y05jMTdaL2JPT2hFZHl5RGo5WlpNOHVY?=
 =?utf-8?B?TlI0YVFFN3grWis0RHJIV3hZSlUvL01QNkRCMUNoMWFQZXowa2JkRml1bmVn?=
 =?utf-8?B?TGRNSlRhdVJTTVg4cDRxZnNsbmJsVERqWHhiQ2tLd0hEVnFLTU9UOWdwZEJj?=
 =?utf-8?B?c0R1K1ZwZktrUVhmOVpoSVJoRGFST2dXUE50Q1pNYUZrblE0MUljZjF5RW4w?=
 =?utf-8?B?UkZ2ZFBEKzBlbmpNY2hEUkc2QUVmYWhodnZEelFHZTE0a1h6SDBRV0x1bzd5?=
 =?utf-8?B?MWJKYmNBaFNsRFlUOERmWGNEQmZ4K2lObFZvVHdoaGk2YU5zYjNvSWxpR1ZJ?=
 =?utf-8?B?SmRETFNMbzRDT0xxaUlRQ1pzRGVPVzJxMWpraXNscDVSSkVtZkZtMDloNHMy?=
 =?utf-8?B?d0JueGowbHZoSFNoUUg4Kys3Mm1HUjczY3hHR0dwcVR4SDB1S2hGVFRXNjlo?=
 =?utf-8?B?V2o0Q05qdmJmWGxWbm5pUlk1U0RCQ2cwa2lJd1dYQWZpYWFIVnA4THBxMnVm?=
 =?utf-8?B?WjFaUGROaEpqZVd3Vm13N0llZWYra2pCSzdKL1BRd0pRWUFSZnhTdGpNVEVC?=
 =?utf-8?B?ZzZzSnF6dEZRV1V6SXR0RmZIdFpZTXpSLzE1RmdWNTY3UjFVb0ZFNjljMTlB?=
 =?utf-8?B?dDRFKy8rTEw4SVE2N29BZGxMVTVNMFNPS250eGVHL1JTZUNTMDZFTWkzWEdy?=
 =?utf-8?B?UHF2VGxUVm9kdkcvSnhqaE50ZzNBZkNqN2xVTHZKU2x5dkJMTitLc3diZjV1?=
 =?utf-8?B?QUlJc3ZMektnTjJ5cjBON1pXN0szNjJMRndMMEVuLzlyeWd3Y3BoRlFKaHpU?=
 =?utf-8?B?aWFzeFROcUNGVUVqSHlOU3ZISVBqcDZ3OEV6QjNtQWlnTWVRcjZ6RGxpL0tH?=
 =?utf-8?B?aGxqbHovY2ErMFZzMjVmWnRUbVFvRXEvZGFUMHpLSW84R1g2dHplUnpsY2RP?=
 =?utf-8?B?SW1mK0JiM0k5UHJHM0FmYUsySUFuQlZTVGFtMnorNDhUOFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4960.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFRCbUcweG8xTC9ZQWVWemo5ek5LZkw2dlRYeWhpY202N3VqdWJHRWZZYU5E?=
 =?utf-8?B?WFNWekFDTW5JMVBhd3QvanBxVEhyYlJKL0lKN25GT1QyNzRqZ2srR0Ria1lk?=
 =?utf-8?B?bHR0dnFXL1c2QUQybnJaeVdoR3JiN1FEd2lRbFZ5eFk0TnZkWk91aUdHRmV1?=
 =?utf-8?B?c2gyQW5rUThVdGxMNUNjT0U4dmpiU3F4eU1YWG10WVJBaURKaERVSGt2OXR3?=
 =?utf-8?B?NzkxdUNmZVprbUltdGFOWUNxVTY5TWdCYkRtSzBoZE5nbHJtZkljbTNWcnZB?=
 =?utf-8?B?Zm5Rc0Z3NFpISmlrcWx6N2lOcS9GUitPMG03amFPaGRFeHNIZ2FZcUM5Z210?=
 =?utf-8?B?UnRWdVdCKzdKQjJqcjJkM2dBSXBvRnRmY0JERWhuYlA0TUtva3E3K25wMnJN?=
 =?utf-8?B?R1hqRDRYVC9PVUVick9aQ3NWSFdZK2tNaitxMlJrQXBRRVBNcG5FQjRVUkJy?=
 =?utf-8?B?dEk0Nm9iS1FaNUNNQ0wzQ01aRytaVWZZaElJdHF6dnAzOG5XSFp6eGdhbVZQ?=
 =?utf-8?B?clM1YklnMitwS3RZSzczTGl6b2ZxajBlTExrRGxFT1RXUHYyZ3lSakdBdzR5?=
 =?utf-8?B?bWROMlhudDVwM1FGK1pqNm13eXh5QlgzcFBjWEI4WlBNV1B5NCtEckNpQ1JZ?=
 =?utf-8?B?b2k2dUNmRHdnNVJLbVNBQnduSTdnMStsWGk2R0JicllaVHFSck55NDJNWDRr?=
 =?utf-8?B?aHFTdFN5enJTUDRib1JwZkw2NjhPc1V5VE5wZmF5aGhTOVVNU0huNk9rYzl6?=
 =?utf-8?B?SUovakE4VEhXQ3IwekN6dWRNSnZuUmNidWdybVVUb0pvY25PVDA5cElMZVp5?=
 =?utf-8?B?SVlRRmUxVXBYUnh6d1dLcnM2cmRFRGwwWERLdVJxcXM4N0tCZnRWRG04aTlh?=
 =?utf-8?B?WWNKODhmSFdCTm5YSVRaMzhJUE1zWFA4dEVjcjRjbnczM0hsUjV2MklqNitp?=
 =?utf-8?B?MHM3S3E1QnBVd0QwdUF1RTZjWU1FdU00U2lrTzJVaUdZeUQ4SUt0K1VqUHJa?=
 =?utf-8?B?RTFUQklwQlF0NjJNUnRBcjB3clBJQ1gxNXpBZ3NrQm9XaXNHVmFKNlVSbElD?=
 =?utf-8?B?UGVNYXRDYmp2dk52VVVRczl3MFpYYW04cjBIVmV6dmV1WE1YV2pDL3ZUSmgw?=
 =?utf-8?B?V1prekpXMmNWVWlGQ0Q3aDIvNGU2SktsUkpPU2ZMY3M5TlNjY1crNWtnK3Fn?=
 =?utf-8?B?T1JmTnpETEFORG9paEJmSjJPZVFaWkFrRktGNDRxNFVYUVVtdDlQcEIrRFZ3?=
 =?utf-8?B?WnBuQXRlR1BQM0R1VUxnZGdmR0gxVDJSb3NZWWNqYXc3REd5dkd4UThLdVpB?=
 =?utf-8?B?Tmk4ZVBkQTg4a1YwR3k4SU80QzBqaG5lRzUrbFRtNmQ3NDNRcVE2T1FJNmVW?=
 =?utf-8?B?RlplRWowRGRWbGp6akFMdkRoclRpOGNhVUx4TGE5dHc5dmpNOWpWdkNncG9X?=
 =?utf-8?B?V1hOdWxBR2JTdFJDMm9wdm1LdGs0VWQvYkZnNHhjeDk4U1puVDdjclVISERl?=
 =?utf-8?B?N0FTMlRUV2owZW9WMSszTkdaUEI3Q2g1MmxsZHBaUHUvekw5VlFQRkdpdE1Y?=
 =?utf-8?B?ZHRja1llbi9VcEhTYkNWUnVRNVFFNXlaUWNOc2dwc0VvREgydjkvNk5KSW14?=
 =?utf-8?B?ZktnK25uSVVxZmw0Q0cyZUR5bEJxaVdYTTNuU3cyY25FbU93SVU0aHo4VENY?=
 =?utf-8?B?ZUtlTUdoODdPbU9SZGhLbzQ3RXRiNTUwZlFhRzVZa3NTamNzanIwS081dFhX?=
 =?utf-8?B?RFk0UERtdVJ3YTRCRkxCMThIdVRsejFhYm1XZmM2TnU4KzJpNktqTWlwekJO?=
 =?utf-8?B?ZEpJSDZMVjZ3UHNmVFR1YUZ2eUI0V1Rwb0lVeHMxOWtPY2FJMGVmRHVnVGRz?=
 =?utf-8?B?RzdoVTBpKzdLT1dWL0s0TnRseW9kRzN0S3pidjRPQ1E5V3JLb1lIUExERkJR?=
 =?utf-8?B?cWQ2bVRIak56RHkvT2Y3Nkc0WE5teVY1dVNVd2hGVCt5cTBzSHJjUzUwR1Vm?=
 =?utf-8?B?RVBQQ25QaXhKYVFNbkY2RDlCV1RZWnJiSlFaZk9NMEtWOWxBRDNOTmhWcjRP?=
 =?utf-8?B?RFIxQUMrbWVnd2duZURmTk9zSFFGRUNWczVqM3lUMGhTWEh5ZmIwRktYTkQ4?=
 =?utf-8?B?eWJhMTd3akFZOHlNVTJmdkUrMzZSdnlaU1kzbGhZYmFmZkZIMzhoNk4zbXBt?=
 =?utf-8?B?Zmc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4960.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14740d38-f567-4aa4-bf3d-08dd50dcdb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 11:59:25.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgSM3l/D/5ghj9GsuxpON1rKPajHo3aElmX7ScBRK/yo9lpFCyUU1Wu3WMTxac8AKtRnnd5jS5il8ShDEUO8Bt5VuAa3/2Md90QaZZw6hS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5007

PiBPbiBUdWUsIDIwMjUtMDItMTggYXQgMTE6MTEgKzAwMDAsIEtldmluIENoZW4gd3JvdGU6DQo+
ID4gPiBPbiBNb24sIDIwMjUtMDItMTcgYXQgMTM6MDAgKzAxMDAsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+ID4gPiA+IE9uIDE3LzAyLzIwMjUgMTI6NDgsIEtldmluIENoZW4gd3JvdGU6
DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHBjYy0+bWRldi5wYXJlbnQg
PSBkZXY7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcGNjLT5tZGV2Lm1pbm9yID0gTUlTQ19E
WU5BTUlDX01JTk9SOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHBjYy0+bWRldi5uYW1lID0g
ZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLA0KPiA+ID4gPiA+ICIlcyVkIiwNCj4gPiA+
ID4gPiBERVZJQ0VfTkFNRSwNCj4gPiA+ID4gPg0KPiA+ID4NCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHBjYy0+bWRldl9pZCk7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcGNjLT5tZGV2LmZv
cHMgPSAmcGNjX2ZvcHM7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmMgPSBtaXNjX3JlZ2lz
dGVyKCZwY2MtPm1kZXYpOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyYykgew0KPiA+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkNvdWxk
bid0IHJlZ2lzdGVyIG1pc2MNCj4gPiA+ID4gPiBkZXZpY2VcbiIpOw0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9mcmVlX2tmaWZvOw0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiA+ID4NCj4gPiA+ID4gWW91IGNhbm5vdCBleHBvc2UgdXNl
ci1zcGFjZSBpbnRlcmZhY2VzIGZyb20gU29DIGRyaXZlcnMuIFVzZQ0KPiA+ID4gPiBhcHByb3By
aWF0ZSBzdWJzeXN0ZW0gZm9yIHRoaXMgd2l0aCBwcm9wZXIgQUJJIGRvY3VtZW50YXRpb24uDQo+
ID4gPiA+DQo+ID4gPiA+IFNlZToNCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L2JjNTExOGYyLTg5ODItNDZmZi1iYzc1LWQwYzcxNDc1ZTkwOUBhDQo+ID4gPiA+IHBwLmYNCj4g
PiA+ID4gYXN0bWFpbC5jb20vDQo+ID4gPiA+IGFuZCBtb3JlIGRpc2N1c3Npb25zIG9uIExLTUwN
Cj4gPiA+DQo+ID4gPiBGdXJ0aGVyLCBkcml2ZXJzL21pc2MvYXNwZWVkLWxwYy1zbm9vcC5jIGFs
cmVhZHkgZXhpc3RzOg0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jDQo+ID4gPiBvbW1pdC8/aWQ9
DQo+ID4gPiA5ZjRmOWFlODFkMGFmZmMxODJmNTRkZDAwMjg1ZGRiOTBlMGIzYWUxDQo+ID4gPg0K
PiA+ID4gS2V2aW46IERpZCB5b3UgY29uc2lkZXIgcmV3b3JraW5nIGl0Pw0KPiA+IEFuZHJldzog
Tm8sIEkgZG8gbm90IHJld29yayBpdCBidXQgYWRkIHRoZSBwb3N0IGNvZGUgY2FwdHVyZSBkcml2
ZXINCj4gPiB1c2luZyB0aGUgU05PT1AgcmVnaXN0ZXJzLiBBcyBhIHJlc3VsdCwgSSBhZGQgc29t
ZSBjb2RlIGluDQo+ID4gYXNwZWVkX2EyNjAwXzE1IHRvIGNoZWNrIHRoZSBTTk9PUCBlbmFibGUg
Yml0LiBQQ0MgZHJpdmVyIHByb2JlIGFib3J0DQo+ID4gaWYgc25vb3AgaXMgZW5hYmxlZC4NCj4g
DQo+IEhtbSwgSSB0aGluayBPcGVuQk1DJ3MgaGlzdG9yeSByZWdhcmRpbmcgUE9TVCBjb2RlIHN1
cHBvcnQgY2F1c2VkIHNvbWUNCj4gY29uZnVzaW9uIG9uIG15IHBhcnQuIEZvciB3aGF0ZXZlciBy
ZWFzb24sIHRoZSBzbm9vcCBkZXZpY2Ugd2FzIHVzZWQgYXMgYQ0KPiBzb3VyY2Ugb2YgUE9TVCBj
b2RlcyBkZXNwaXRlIHRoZSBleGlzdGVuY2Ugb2YgdGhlIGRlZGljYXRlZCBQT1NUIGNvZGUNCj4g
aGFyZHdhcmUgc2luY2UgYXQgbGVhc3QgdGhlIEFTVDI0MDAsIGJ1dC4uLg0KV2hhdCBJIGtub3cg
YWJvdXQgdGhlIGRlZGljYXRlZCBQT1NUIGNvZGUgaGFyZHdhcmUgaW4gQVNQRUVEIHNob3VsZCBi
ZSB0aGUgc2FtZSBvbmUgaW4gTFBDIG1vZHVsZS4NCg0KPiANCj4gPiBQQ0MgaXMgdXNlZCBmb3Ig
cG9ydCBJL08gYnl0ZSBzbm9vcGluZyBvdmVyIGVTUEkuDQo+IA0KPiAuLi4gaXQgc2VlbXMgdGhh
dCB0aGV5J3JlIGxhcmdlbHkgaW50ZXJjaGFuZ2VhYmxlLCBqdXN0IHdpdGggZGlmZmVyZW50IGhh
cmR3YXJlDQo+IGZlYXR1cmVzIChQQ0MgaGFzIERNQSk/IE15IGltcHJlc3Npb24gaXMgdGhhdCB0
aGUgc25vb3AgZGV2aWNlIGNvdWxkIGFsc28gYmUNCj4gdXNlZCBvdmVyIGVTUEk/DQpZZXMsIFBD
QyBoYXMgRE1BIHRvIGNhcHR1cmUgdGhlIFBPU1QgY29kZS4NCkFuZCBzbm9vcCBkZXZpY2UgYWxz
byBjYW4gYmUgdXNlZCBvdmVyIGVTUEkuDQoNClRoZXNlIHR3byBkZXZpY2VzIG9mIFBDQyBhbmQg
c25vb3AgdXNlIHRoZSBzYW1lIHBvcnQgSS9PIG9mIDgwaCBhbmQgODFoLg0KQnV0LCBpbiBjdXJy
ZW50IHVzYWdlIG9mIFBDQywgaXQgY2FuIHN1cHBvcnQgYSBjb250aW51b3VzLCA0LWJ5dGVzIG1h
eGltdW0gcmVnaW9uIGZyb20gcG9ydCBJL08gODBoIHRvIDgzaC4NCldoYXQgSSBrbm93IGFib3V0
IFBDQyBvciBzbm9vcCB1c2FnZSwgZGVwZW5kcyBvbiBJTlRFTCBwbGF0Zm9ybSBvciBBTUQgcGxh
dGZvcm0uDQoNCkZvciBBU1BFRUQsIHdlIHdhbnQgdG8gdXBzdHJlYW0gdGhlIFBDQyBkcml2ZXIg
Zm9yIHRoZSBQQ0MgdXNhZ2UuDQoNCg0KPiANCj4gPg0KPiA+DQo+ID4gPg0KPiA+ID4gTnV2b3Rv
biBoYXZlIGEgc2ltaWxhciBjYXBhYmlsaXR5IGluIHRoZWlyIE5QQ00gQk1DIFNvQyhzKSB3aXRo
IHRoZQ0KPiA+ID4gIkJQQyINCj4gPiA+ICgiQklPUyBQT1NUIENvZGUiIGNvbnRyb2xsZXIpLiBU
aGVyZSBzaG91bGQgYmUgc29tZSBjb25zZW5zdXMgb24gdGhlDQo+ID4gPiBiaW5kaW5nIGFuZCB1
c2Vyc3BhY2UgaW50ZXJmYWNlLg0KPiANCj4gVGhpcyBpcyBzdGlsbCB0aGUgY2FzZS4NCj4gDQo+
IEFuZHJldw0K

