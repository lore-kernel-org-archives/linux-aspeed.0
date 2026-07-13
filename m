Return-Path: <linux-aspeed+bounces-4483-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978A6C44508
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 07:37:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0SgV33mdz2ywn;
	Wed, 15 Jul 2026 17:37:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783926573;
	cv=pass; b=eSQrFYNcQ4xMcTq3IF76duV7X075IOneIcNw/WAnF8d0cj84Jr6nAJRStjuASk84cTsgNqh6sWaNaEyaknoG+srjLOmRtRZsRcdIfwVXyPxqoYTXbjLFMNaB7Upducr8jDQ0+9s6P52nu1xDSnFeLhUlQ+y1iXcHfBS8A49CYNfB8LHOyfAG83GzbszpjlZ97ctCIcPk4ZHF6YkU8OYyN5mBST00kutWfSOjrTF5H+qhCPHMLj/ey3SrIncsTw8JCzpC7EDGEOvz/MzcX0f9kAavfc4BhM+oUOYhJbXG7OuejcgUy/rjfRRMpjJF13UtjMUI/C73l3UrggD+zFEk7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783926573; c=relaxed/relaxed;
	bh=j8zqGlLSBUjVuasN+OM06JdfC2joRIDI0Cw8I1JSC80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edSdr7jmG+ZCUWf1zBcoSduKfnW0UA1bGbf91kCvbfMjsHkiSr5uQT8IA6U5Aaw0i1xGWpRpv7BKCM23iAxa8CSJnmO5hOUlgM7LnndQT9axpwN1leimqBlxgYsgGdTEXYRGshHsBH1xzBY9jdKW1PxwPN965Wsch6+3oeUf2OH/O7ZRe1EwdRxzrZgLcG6QXLsk/Q8CO3kdRG6YqHiNIejZtxknKGM1v+bJAprS8x5TnEZ4b+JJI0HHt3bI36HJQtRWWBff1psGtcK6xY4KQt0wV5vMSbALhp7/ZV8fF8/LXK5wk9TyvbELYs8SUnrT0Y0kTvSLvjOrPmzXGX4alw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=diK4D0Vo; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=diK4D0Vo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzD8C5Vxfz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jul 2026 17:09:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9XCc1+Jpd8PltD9tY7LlSAqu7usjt5WK8pI4AkIbRyhJTIzDM3Z7nvzpFAbhDOTbYBJC3h35DRs1uZqkHFxZLJJ6O+FdzlzzEfl+7cqcawp7Vx21V/yDZfGq7vJpGbMNH6dPWn+IKxU1uGqpV8R6HOvydb0to2esu1tNwFV7411gPpkEx4GOTSkf1MHzrVfYGEyLa2GbsSNh8x6Ae54WPisPFqDeKPOfL5QVrmWSNoTQMiS6SN+rmis1lugGs8QdyKlZnXio0pGj01WDz7ctPFGAN1+1VmtLocl7w/KLRndKH7irtEvk9tt09U7WVcOfHAT6X+3C/zPiZeEedxh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8zqGlLSBUjVuasN+OM06JdfC2joRIDI0Cw8I1JSC80=;
 b=i9eSQqltc4AR5s/biqdigEu5KJ5y5rivQE5LkN9olq/8vygVTSO6xtwYtnEcrJy5wLL6zIGToLTV0VW9J4LUONiaKmtx9HLTyhw6Jd6cotkrvzg5D1Eqrgds7qqmxuCmpW9zauSClPF7Wikaz/7cDS8iukqzJdwg0B97WsCUzL5h/qAvrDSx04bu2raJpXUDcWFmgLkNiKwyFhM5OYzjVyz7quZ0YY+MLz1hJFjJKRjtx0swvhUske2UzWO8C2hoQs0iMQTavUhEitnxl7pOgftysYXaa8DvrPYsra1Esd/UpCHM9EeS46eoO+6sXOmoLpbOENVa2jRZvGeCUpPuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8zqGlLSBUjVuasN+OM06JdfC2joRIDI0Cw8I1JSC80=;
 b=diK4D0VonKhZEMYCMjgmbaQtjfsK3OywjKaxy2hcyH0fKq46JqR2eI/4N/vN9pWI2ECdtFTreNChVgRlXakwSFeGq/o8eW/2pm402DqB83VVwg4vQ6S7F9XS+IkIVrHd1RJcwXlortWaQtxeY0N2P0WG75DonyCR/2Qf95DJxEhm5GFrtaoIxIXTvnGOWiJiPzlfNzR5vL6jTf3Fv9jCaXbC3vdS+NTFa0bSR9jD9D2V3LYfp6l9nL90xJ/Vu/JegnRDhvwmFBguvbJG3AG8/rkRvpRO+VYmjxQSjDS9NsmvyAZoAacZFB2P6jo5aHvB/EYI/PmPP5AgMae1ZCqMAw==
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com (2603:1096:405:13::10)
 by JH0PR06MB7198.apcprd06.prod.outlook.com (2603:1096:990:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 07:09:01 +0000
Received: from TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05]) by TY0PR06MB6855.apcprd06.prod.outlook.com
 ([fe80::9405:99c0:aadd:7e05%6]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 07:09:01 +0000
From: YC Hsieh <yc_hsieh@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Corey Minyard <corey@minyard.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>
CC: "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGlwbWk6IEFkZCBv?=
 =?big5?Q?ptional_LPC_properties_to_ASPEED_BT_devices?=
Thread-Topic:
 =?big5?B?pl7C0DogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGlwbWk6IEFkZCBvcHRpb25h?=
 =?big5?Q?l_LPC_properties_to_ASPEED_BT_devices?=
Thread-Index: AQHdB5N07GOCG0yUdU+n8UrPxJS92rZWn3MAgBRgtcCAAAlHAIAAEoW7
Date: Mon, 13 Jul 2026 07:09:01 +0000
Message-ID:
 <TY0PR06MB68558AD7FBBCEBB09DFAFCF593FA2@TY0PR06MB6855.apcprd06.prod.outlook.com>
References:
 <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
 <20260629-aspeed-bt-bmc-multichannel-v1-3-fc23ee337f7a@aspeedtech.com>
 <35a8e3b3-7725-4d1b-8667-84e6fa24b2ca@kernel.org>
 <TY0PR06MB6855F4F499246CD5C44DB23893FA2@TY0PR06MB6855.apcprd06.prod.outlook.com>
 <31df2c13-9c31-4a78-975f-b0152ad3356d@kernel.org>
In-Reply-To: <31df2c13-9c31-4a78-975f-b0152ad3356d@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB6855:EE_|JH0PR06MB7198:EE_
x-ms-office365-filtering-correlation-id: 898386bc-aac8-4f18-ed6d-08dee0ad9d9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|38070700021|56012099006|6133799003|4143699003|3023799007;
x-microsoft-antispam-message-info:
 co75iRvIRF/oTJjNvj5uxoBNkwYZhSvzu5PgOd1y/L7jLoZa2TOF63+JDwQIWCWDBRV5Y17xTQ8/x6iESSbbbUfZuB6zIO0WtQuB3Z8mW9qYZDxSkzSnxFytIKjMJOq0JjLU3WECummhWwNjsbN414Ac7ch67McpNuBewlGyRMX33ENajDWOa9BEyD9/pU+qA/UxK7WLGq1kIYIAE3gwsK7GS3U9g5mcx0EP8HaLF9WQUsyTU1nogrD28XStVzjpaJECZrmyFE8UyCQS1Nq97grAC129BcdJZEkIfGWzBqqr3hhGPkZcNhCjMabD0GkyMymDdrq+iQLGKSh0L0KwsL/vEMUn5UK0yJCHMK02UCWrGXCctn5dRX1jFX7ylqmy4qhniWcpAilaQxsXjKtP2x7TluxQJEI4cYZVfzf3/xnnbeucJ7ZnY2cMdoYN+9U9FwhcxsZT+RBVSTPMI2QXzkUs+faFXfe67iCpxfsjmeh37sjQ80VvpEFGYoTSFb/BSN9dwv1QwGZ8DUFLX0nPrzXt4B8SQqQ5Zh/P660v4B/sdNhb2kpdbTGXPNVZlY5bcSjaewalkOF3eOq5VZKZ9EUd5+XZly8KHwZWaEl6L/savAD511VKV5T0nuZclSvxainfsO7amIUdjarDH6+xvWE9CvuJW9fFbpsgZ4ah7+LWwY296S22MfyA6miL9RuM8QmI1SLD9eZ4DWY4I5o6Lovsn/BK+raiUQ7ohIKEo+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB6855.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(6133799003)(4143699003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?c09oanpOK29JVGI4ajlrMVkvYmsrSVR1Z1M1cGNxeUhsNFdCNVQ3UUg1bUJJUnBO?=
 =?big5?B?QmRsUjRTVS9aL0dsLzBVaHVMS1E4aFJFTUJ5RmJDT2xzbVJJVko2TEtwTjVYam5o?=
 =?big5?B?RzRuNE5EbVNsb1AyejFRc2ZvV3JWeFdZMkY4bGlvU09TaFVHeWxrUUxKdmlvaVY1?=
 =?big5?B?R2JDendxU2R5YytGbmVMWnd4OWdTR1hoQmxpS3V4Q1o4UTdWNEpKY1NldjlWcXgv?=
 =?big5?B?YjE4SmVsanY1OTcrV0F0djZucWQxY2l1M0FpR3IxZFpqR0lTSFNyT1FReVFTVmw0?=
 =?big5?B?TVZwNzRVbVJtd2NtQTZFMUJ3cFNLSmlGLzJteEF6cDFMTDF1ZkI3eGpycExlYnIv?=
 =?big5?B?S0pWM2VtWldUOHJPRnhydzhjN085ZkMyWHpFQnpIZWhxTzZadEhkTk0vWGFnK0Zz?=
 =?big5?B?cjlGcjJGRVJxRFNvNjBKZHdlSDcrSjdHeVE3T3BFQ3RKemtINjdTKy84eFZlYmZq?=
 =?big5?B?SGE5ektUak1mWEg4V1lwM216cE0zemN3eXJtZmFPRWJFRU8wcHBvWmRVcUdTN1Rz?=
 =?big5?B?ajhWbFAzV2VSSnlSUVJRTWt1cWRVTzJweXpnb3R3VjU0WHBDaVNxbVpiMCt0bTkz?=
 =?big5?B?dFhuZFdmaTNCVjdHbEdYeFdNU0xOZmNUaW9vRXh6MkdQczkvSlpsMlhGMkxrclhl?=
 =?big5?B?RXdObDdxbUo3cnJSQ1g1SGZBSXFTMjg0b2Jvc1pnczRMZHozeUJRNklDUm1BUjdy?=
 =?big5?B?RkwvSFJlUFFiRjhOS2dmdlJGbjdhMXdiRVNCUkhYdnVmWmJmczNmTm4ralZQeEtn?=
 =?big5?B?V2R2OXZSNWhvWGxhMlhRZVhtcHJwY2ZEMVBIZFdoVW50eXNCUU44S25FcGdZaXRw?=
 =?big5?B?MmU1YnQ3ai9IOFY5cEZDREgyRmROT0pRRjhtWklmRmJ0YkNIdEVWVmRIYmVIR3Ja?=
 =?big5?B?K3FwaUZaZVlQdEV1YkZJdXJhK2V1SGJhR2dTY1ZUcmdReWwvaktWcm1meVFxd2NL?=
 =?big5?B?SHRBc2RQOEVWRktxakZySjhkbmhnbmgxOG5UT1lOb2drL0g5azBzUFBGYmh0MWg5?=
 =?big5?B?NTFuSTRERnNlMXV5TXBEZ09mamUrczMzckN2NGZ4dnRBTStWRnQ2VVdBakw3TzVL?=
 =?big5?B?WXU1MmxtMkFBYzdpSU9aMjAxNjU4a21FK04wdFQ1T0NJMnZ0RkRGQ29oMERYd3pT?=
 =?big5?B?WnV2aWNKVDJFWWtXMUZTSW5jaFJjc3hlbi9Sb3RaWm5icGNRc1BIYlZjSnRnR3ha?=
 =?big5?B?bHJ6YUNKR3loVU1XT1UwYUdwbFlIVjJ5dUtYTXJtNm9hSjZaU2d1NE5KeHBMNHYr?=
 =?big5?B?Y3dNVzJYZ3pQYUpUN0VYVUh1dFl0RlJYYU9MUDhYMVg4Y0ZWOW5aQm92cEJBdi9G?=
 =?big5?B?OGFMazQ2cEZ6dVlXbGFoSFMwcThWTXNpeStJM0Z2SFZQZHE0VUJBVEI3cU1GT2M0?=
 =?big5?B?TnVIdzhSRzB4b2VKaG5uK0xYeGVWT3hLV2d1M2pjZldtcm16UHZGV3Z1cHJGUHU4?=
 =?big5?B?bVpTR29uQlN5ZnllSDFJak54RU1aUzNORzN3a1l1NFduN3dXdFNCZkxLSUpHalBZ?=
 =?big5?B?Y0NrUUo1RkJWdWQ1dVJ0c1cvUTd3eUQ3MlVQNEpjNXhyMmtpUzdERWhtR25RUnpr?=
 =?big5?B?VjkvS2NXZ2JTOWhqeFpHQmJuUHJzNXJNNlh1cjBMbUFzYnhKSFJLM2xYQkIwYnpU?=
 =?big5?B?MXh6YkY5aHROSlU2SmYvZ2lvanU4NFU0QXQ3QUZVMStMeVNWd1BqTkJOR3B2WFRH?=
 =?big5?B?eGJ5c01rRFlxQm05Y3NWNUxlT2ZqbUliNVdGUFpxcVhpN2t6WkFhZ3JEa2lBRmNM?=
 =?big5?B?OUtPN2ZFYzE5NFUyaU5ELzQvYzR3aXBWNC9oaW5JWEljY1hTVU1tRkFQL2I3ZVIy?=
 =?big5?B?cWlDdC9YOGhCYWdFUllYeWVpUE9qRUJIOExuVVNoeTUyZU1XT2J1UysvQVpVdkl2?=
 =?big5?B?RGp1N0kzOU5PTGJDUWlqNGFteWNIOUNwa0h0ZldOdkROczRjb1c4dDVwWGVrZ01E?=
 =?big5?B?K1ZFb0ZPZzgwUUtiU2dIVjh3WEZML3laUkVUangwK2hKblN2NXo0RzFFNDJJemFR?=
 =?big5?B?UmtKMVR1ZmZWd0xHVGFMbHVyaTVrVDA0NzErdCtva0JZaFNRKzRjNjk5dklKZnpq?=
 =?big5?B?ZWtVRkdUUlpkSDRsbnhJdVNzN2xXeFJSVEIrdkFyQ3RzUldmWmJEOWJRUGRQRmpI?=
 =?big5?B?czRqNEc5UUdCYTZqYXlzUU1BRHgrRTkvYVJUdHBWNEp5WjZKVmp3R05QeWgrcVFX?=
 =?big5?B?SkR3TlhFWEI1QmxXTHZWTEs1QnJjUT09?=
Content-Type: text/plain; charset="big5"
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB6855.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898386bc-aac8-4f18-ed6d-08dee0ad9d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 07:09:01.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUdH3BaHV6D3TpX5jpEhAsttVPobtCmYENx97au9fBg6+OklM+5UuE2FmiHIOjDB1HHeXVa384znsyBJwDmVdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7198

PiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHJlZmVycmluZyB0bywgZW50aXJlIGNv
bnRleHQgaXMgZ29uZQo+IGJlY2F1c2UgZXNzZW50aWFsbHkgeW91IHRvcC1wb3N0ZWQuCgpTb3Jy
eSBhYm91dCB0aGF0LiBJIG1pc3VuZGVyc3Rvb2QgdGhlIG1haWxpbmcgbGlzdCBldGlxdWV0dGUu
CklubGluZSByZXBseSBiZWxvdy4KCk9uIDI5LzA2LzIwMjYgMDg6NDksIFl1LUNoZSBIc2llaCB2
aWEgQjQgUmVsYXkgd3JvdGU6Cj4+IEZyb206IFl1LUNoZSBIc2llaCA8eWNfaHNpZWhAYXNwZWVk
dGVjaC5jb20+Cj4+Cj4+IEFsbG9jYXRpbmcgSU8gYW5kIElSUSByZXNvdXJjZXMgdG8gTFBDIGRl
dmljZXMgaXMgaW4tdGhlb3J5IGFuIG9wZXJhdGlvbgo+Pgo+PiBmb3IgdGhlIGhvc3QsIGhvd2V2
ZXIgQVNQRUVEIHN5c3RlbXMgZGVzY3JpYmUgdGhlc2UgcmVzb3VyY2VzIHRocm91Z2gKPj4KPj4g
Qk1DLWludGVybmFsIGNvbmZpZ3VyYXRpb24sIGFzIGFscmVhZHkgc3VwcG9ydGVkIGJ5IHRoZSBB
U1BFRUQgS0NTIEJNQwoKPiBXaGF0Cj4KPiBpcwo+Cj4gd2l0aAo+Cj4gdGhpcwo+Cj4gbGluZSBi
cmVha3M/CgpBcG9sb2dpZXMgZm9yIHRoZSBicm9rZW4gZm9ybWF0dGluZyBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UuCkkgd2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcmV2aXNpb24uCgo+PiArICBhc3Bl
ZWQsbHBjLWlvLXJlZzoKPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzItYXJyYXkKPj4gKyAgICBtYXhJdGVtczogMQo+PiArICAgIGRlc2NyaXB0aW9u
OiB8Cj4+ICsgICAgICBUaGUgaG9zdCBDUFUgTFBDIElPIGFkZHJlc3MgZm9yIHRoZSBCVCBkZXZp
Y2UuCgo+IE5vLCB5b3UgZG8gbm90IGdldCBzZWNvbmQgcmVnIHByb3BlcnR5LgoKPj4gKwo+PiAr
ICBhc3BlZWQsbHBjLWludGVycnVwdHM6Cj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5Cj4+ICsgICAgbWluSXRlbXM6IDIKPj4gKyAgICBt
YXhJdGVtczogMgo+PiArICAgIGRlc2NyaXB0aW9uOiB8Cj4+ICsgICAgICBBIDItY2VsbCBwcm9w
ZXJ0eSBleHByZXNzaW5nIHRoZSBMUEMgU2VySVJRIG51bWJlciBhbmQgdGhlIGludGVycnVwdAo+
PiArICAgICAgbGV2ZWwvc2Vuc2UgZW5jb2RpbmcgKHNwZWNpZmllZCBpbiB0aGUgc3RhbmRhcmQg
ZmFzaGlvbikuCj4+ICsKPj4gKyAgICAgIE5vdGUgdGhhdCB0aGUgZ2VuZXJhdGVkIGludGVycnVw
dCBpcyBpc3N1ZWQgZnJvbSB0aGUgQk1DIHRvIHRoZSBob3N0LCBhbmQKPj4gKyAgICAgIHRodXMg
dGhlIHRhcmdldCBpbnRlcnJ1cHQgY29udHJvbGxlciBpcyBub3QgY2FwdHVyZWQgYnkgdGhlIEJN
QydzCj4gKyAgICAgZGV2aWNldHJlZS4KCj4gTm8sIHlvdSBkbyBub3QgZ2V0IHNlY29uZCBpbnRl
cnJ1cHRzIHByb3BlcnR5LgoKVW5kZXJzdG9vZC4KClRoZXNlIHZhbHVlcyBhcmUgbm90IGFkZHJl
c3NhYmxlIHJlc291cmNlcyBvZiB0aGUgQk1DIG5vZGUgaXRzZWxmOwpyYXRoZXIsIHRoZXkgZGVz
Y3JpYmUgaG93IHRoZSBCTUMncyBMUEMgZW5naW5lIGlzIGV4cG9zZWQgb24gdGhlIGhvc3QKTFBD
IGJ1cy4gSSBhbSBub3Qgc3VyZSBob3cgdGhleSBzaG91bGQgYmUgcmVwcmVzZW50ZWQgaW4gRFQs
IHNpbmNlCnRoZXkgZG8gbm90IHNlZW0gdG8gZml0IHRoZSB1c3VhbCBzZW1hbnRpY3Mgb2YgZWl0
aGVyICJyZWciIG9yICJpbnRlcnJ1cHRzIi4KCkRvIHlvdSBoYXZlIGEgcHJlZmVycmVkIHdheSB0
byByZXByZXNlbnQgdGhpcyBraW5kIG9mIGhvc3QtZmFjaW5nIExQQwpjb25maWd1cmF0aW9uIGlu
IHRoZSBiaW5kaW5nPwoKVGhhbmtzLApZdS1DaGU=

