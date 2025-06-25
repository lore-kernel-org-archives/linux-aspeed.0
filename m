Return-Path: <linux-aspeed+bounces-1565-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E92C77B7C
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 03:04:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRmrF206Vz306l;
	Wed, 25 Jun 2025 13:04:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750820669;
	cv=pass; b=ZIdqTgTwlY4bCiRza0lEZ8uVnUb/IVLwUyfOlsw/44NfFbr1Kucju9FpImrbyLb4H76zsEKuggDJm5fAI3YLHkzSIu31LnfZ2YUkFeFisrsOmFV4t6QONTsmPCK0GnzFSon1Q4hIK3YmY+G/VQx7TMO3Ud4//ZlYwcYlprWwQ4QVALQEZwWf9Eskrr5exoJ2bArGfo7k1exopzeOkAk8JhU3Mn8lwxYFNtZk2HI4q+JMcZjG29pQORrLLdUN6dCpPENkJonJy6L/s8LwLIuSc2cU5JYD40LB5putCD/1ioZzA02ZRDJladhXxa5IAyMvLrjHayEj2wpjN+BY0awOvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750820669; c=relaxed/relaxed;
	bh=87FKuMv1p6LomxA0sXMP8cnwp/fNF88TMbmzNYFYHTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMPqTZvSpB0OIMwFThNVTRMBYs6m/xyHRq92iMMZvjYzcE1Mbj2vauBt+s1QT8qKejETNG+BkVvSTFsvAR2yKtEMk+PkS98ndSxQ28eInmxs9sJzt3Y+OFtnhWBmouucTsuxwBWn6iCwPKq73i4K/xo54Tdiu2MYyWx1/RHyxWdrn4UpgijWnxp3wPKtQUYkTsj6Miw6nu/ytHfUnqjAthK38KRCb/883a/QIDFG9gsiF9dB9mxTGx+jBaeDG5NiFVPfWaVHMunaEjUGRb+0nvaRNlM9Uur8IaEKwUgGCDFUCHjzH0Jgn+o7/gVVmjfQH9pvb3AgqcT/b/Pw2ZDzdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRmqy5nxPz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 13:03:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJhndn5BfU5i3JhAes5q0rhrev8ClMRzZ7EI44c6op1XXFNYgATUCWwWqS1P3ckqMQ2ZbzMea9lZBV+3NrwjkdqH5UsQgmGW4F9b2swKVoZD1QDY2sjHhGC6vvw9TbwVQmm1Nz9pyMXFUY7VC1WyOZLxBqC4IAPIURsiE1bsOXOECJA2AhNZY4AM7KuWSzAjrduHOu7ZUoDBIGxnwZF2G460qgRCuViBcaixRGkVVpqfgGu7jJzmD6xIuIZTeRJUFHCL4Gtzym3p5mWCSG6CIRy/gk1ZLYi6uBzs54aGG2Uovko0PUgCSEJOEDfP18lJrqYKXr5h6M8cw2nxNQCLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87FKuMv1p6LomxA0sXMP8cnwp/fNF88TMbmzNYFYHTo=;
 b=GP5yuHm8C7bpn89AWgAFxB/vfocZGTdlF8eNhzAvOeiPSUYHZsCwnNLSm/AUg8RAc3lJi1P3VA4yphIZ7xb092i+s0qXmKYjzLprfQPBNngQtZZaga6FMtqrjL7w95auvAilNXwLOY/yqk4/dzdalPqZ7+sdMFdXZBLYpOhYwUqsSwx9HfaG+uo8OMP/Lt3XCrCTGAzNwBDGgyMIK6BmiI5QuQUmtOv5lTeQ99GIl9V4ZzRKrxGSDN4W1NZJUqCNNc4kpdyHFnZkF3oHFci3dVT3SFKlPm8c8SLDG1Km5W4w+ZilIR8ZwPP9qjxOcVfPN2pIYAkWhHqb3ZDwp0jWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87FKuMv1p6LomxA0sXMP8cnwp/fNF88TMbmzNYFYHTo=;
 b=h2qJSjFk+jxSVHP/avGXgYTJlsPefHkcRtSxRW16cYYAz0r0pImGg+vPwrLTrzuzPJqiiNbYxTiLw948SmQRSRY71vEb5vTfWY0CQipRIYM78ph/MG9Q2Xd7zmY8JnW7HxPTLievZ0Pv2NqGSMY2HuUo7Y5lT//D5TDS/u0SLA4WYcIzXlR8/KuAjyR3XJ3KH1yY1Qn2WB2DQH8aQ/I96DnmB+S2qw0Zp/W8y2xBQT+wafScLxK3cEtHcdEiNpHHRzD5aeL56pN0gX+1ew70R1Is23c4zN/MvXCCdTWztuw8G2xcJaIuWwfBF3k9/hAFeyu7qfgMBWzgP6yG+dvx2A==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by KL1PR0601MB5680.apcprd06.prod.outlook.com (2603:1096:820:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 03:03:03 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 03:03:03 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v4 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb5WgJ8CgI69GCtkOTNM5MVQqgrrQTBbfAgAAGaICAACQ7kA==
Date: Wed, 25 Jun 2025 03:03:03 +0000
Message-ID:
 <TYZPR06MB656882B1D5BA4CB72D19AA9DF17BA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
	 <20250623024456.2068370-2-jammy_huang@aspeedtech.com>
	 <0ba565ac9444503be954161a8d79fa0476bd78a0.camel@codeconstruct.com.au>
	 <TYZPR06MB656893C53B13B2D288BCDEA1F17BA@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <9c748fef6be89c3bb1fe833108b2191faa25ab33.camel@codeconstruct.com.au>
In-Reply-To:
 <9c748fef6be89c3bb1fe833108b2191faa25ab33.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|KL1PR0601MB5680:EE_
x-ms-office365-filtering-correlation-id: 634d2f2c-f25c-4dc5-fb7f-08ddb394cd42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3ZLZUhPVUJlRFAvYmRRQ1RiT2k1VlFIeFlnbEZaK0VoMlFaNUxtaENzSFQy?=
 =?utf-8?B?SSsvTEp3TTQ2bE5IRi94Skl3WGVyd2NWd1c4c0FXc20rZTZydjR1aEJxaXlr?=
 =?utf-8?B?ME9rUnFnUnBBTG5vZm5BdDFuNlFZTnA3Q0tNNVlLcGQ4dTNtanpPelNSMzk4?=
 =?utf-8?B?VFJRZXdUWnRVK0t5QUJzaUNtNWFWM0lLQk9uNC9xd2NtcmovQURzK3ZWYStr?=
 =?utf-8?B?ZmxkZlVTdGxvL2NjdWdKWHhiQUhIbzgwaWgwZGU1SWR4Q0FlWVpsQ2hiNGNR?=
 =?utf-8?B?VGFvVDhPOUpkSVpUQks3Q2dRV3djYWg3RjVtbzZUd28zSmNaSkdrZmY5R0VF?=
 =?utf-8?B?elBMNFdPTzFhT2lMQ2lGcUVIb1R4bitHemtLdlJOUlNBcUZNaUN2TTdxT3Ny?=
 =?utf-8?B?Mk1ONEcwcFZRajduR0RiYWd5MEdmY0RzRDkxelJrN2VMQUNKaTFXR0taWmZs?=
 =?utf-8?B?bnAwK2szM0loS0daKzJyTEZDMW5HS0VPSWxBVlpYT1NJYW9vOXNZUkNRWkdM?=
 =?utf-8?B?b1NacHltSytWVXZCMkZzTU9JQXFaMXVRaGxUMkdXSm9OZEYzSVZpckxUUDYv?=
 =?utf-8?B?WDY2Qnk0MGdCV3B3cktRTXAyOHN2RHNod2YrWXJOVms1TXBsbDdUK3BKdGZt?=
 =?utf-8?B?U1pudVliM0xwSEtBUFFuSm1EaVQrSXo1dENBU1pGbEFrZjhHYzAxeDJxdGUw?=
 =?utf-8?B?L0w1bEc4aUt0Nld4U1Zwajk2bEFZcGxLZXNxQmJ6Sk01UDBFcUxWcGpYSHVn?=
 =?utf-8?B?cDNBbldFbkNxbFJsblNTSjN3SWNFZUdRS1dzd1NTNlFWazZTV0dFdkFHakdj?=
 =?utf-8?B?SitwclNOOGpRbmY3d08wSWFqM1ZSVnFUMHo4RUk2VGluNmFFcUpkcHR5ZXR2?=
 =?utf-8?B?cmpPSmd6T3VUTnJpZjJBZ3VWMnNSc0MvQVVxQmlOMTVRK01ZeGMySm1XQWxU?=
 =?utf-8?B?dDFnSDlWTHd1R0xGamhYTGYwc3FFeWpGSHFXRTc5dDRDVk0wWDkyM0RrcDdW?=
 =?utf-8?B?TStHVmpGbDB0VjF6WHkyZGZDQnZwTm1ETlNSY2lwTThWeW5xRVptaW5OcHNl?=
 =?utf-8?B?NmtycjA3WmZzN2JvQVh0THdOcmVCMHJwREtWMGVwRTV3d2cvb0lrQ0Q2UnhL?=
 =?utf-8?B?NVE5eUFiVlhDZUthWXNkc1lXRkJOZWI2OW9zK2NqVWpGWlkrcnlMenNjWGlr?=
 =?utf-8?B?UE5CZ21acEorcko3eW1ERW9Rc0RVS3lFOFU2UkZKQjNja2kzcllUSmR6U3ZF?=
 =?utf-8?B?ZkFvRHNxVFA1cDd2a1dEd3FuTVArMG10TnFWdnZIUjBoZ1hsa1VVVjd1b05o?=
 =?utf-8?B?a2Z3dDhtcTFXbURwNGJGYjhpeForbWhQeTBGNmJPajFKZlJneDVrbm1sSnMv?=
 =?utf-8?B?Y2kraHh6TnlJdUlIZWxjaUNzUzNUY3lvRGszWXdEQlNJMGJmVGZLaG1wM1JO?=
 =?utf-8?B?dGRHVWVBcUJvaldjT08zU0hhMk1JWHN5cm5kK2Nwd1RRUERLZmhYREpGenNa?=
 =?utf-8?B?VTZJdHJuc1A1aC9vRlAzV0Y4NHNaN0V2VEhadVNZUHJjL1NYVlpIaTRnSmlF?=
 =?utf-8?B?UnY4VTI4Y3IrT1RZY0QyT2NRYUlHTnY5Q29FMTVTVGpJUkNodkk4QTR2SXJv?=
 =?utf-8?B?R3pqK3Zjc0F3bDVQWDk4SzZVeUU3N2Vaeldqb1kxek51L3cvRFlkMS9lTGFo?=
 =?utf-8?B?NHY4WXNaeXM2akU3YW9NY1JFNXdFVHpwUmRxRk12czBDWGxaY25sUnVNMWw3?=
 =?utf-8?B?b2lNR2dRNTJJUGRUTFJIc0JRdjE2M3JReEpBdnF3R3ZTZjdjQVA5RERWT0RS?=
 =?utf-8?B?NWcvT0tKQUZpZm5Eck5UVnAvZitmQ2NQYUV3RHI1QlNwLzFBMy9jVG1NcS9I?=
 =?utf-8?B?UHRoMzFXWERVWEE5K0M5UlBHcUZmRkhnVVhybGtqUU5LczNOTVFCVUNzeVFZ?=
 =?utf-8?Q?epEK8G61RK5ftWppuHXcrK4/g4/VwSbe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkZTdFgxTDRod1plY004TmZELzFUZ1ZNQk1KVnpXTGI2QThXUzlwNGxhM3Qx?=
 =?utf-8?B?MEVETm5PRkN4aFJWTmlMMXRlU1RwZ1k5SWd2SUpQLzQ4Qm1TVzlpOVI1Zyt2?=
 =?utf-8?B?cTl6Z1RMT1dKRitDUkI5T05UN1V2UEd3UXpNZUNXSTJlSTBCcDFJWXNnSk92?=
 =?utf-8?B?dkVXT2x1QnVpUkUyREljdForT1ViTXB0QlV2M2FVd0RWOHRCMjNYVlRPT0JX?=
 =?utf-8?B?bFhnanpzWDMxV0xTUzg5aXVoTXJJRy92K1NsVVRHdkRkcE8wUG14b2xvalhz?=
 =?utf-8?B?OGRwS0pMNlkyNmdpMVFuYW43UXh1U3I4VUhsK3FpTFptd3E3SjYrMWx4MXpK?=
 =?utf-8?B?THQ4SFR2VXZnKzdpYVkrdzZzMEJxc0UyMlZQVkt6bUhEeFUwUDFzODhUdkVE?=
 =?utf-8?B?SnhNdm0yeGRrVTZRZGlpdXJQZkg5VlNxcDhXUHVLNWMvc3liV2QwNXJPTEVL?=
 =?utf-8?B?VktpWEFMQnhFQ0tUVUlvWUlKQy9VS0VNSUVLYlkwaUlLK3NXZlpEdTVZLzEx?=
 =?utf-8?B?MjIxMGt1UkRMMldWc3JHUjR2M0dzVHNLKzkyMDJqOW55em9VMEUvd0hjOWQ2?=
 =?utf-8?B?K1VPcGExYTl5M0NDSEdrMGp2dmI4eW9hU1JwSko0blNzbEdUYmpIQ3lsVDBa?=
 =?utf-8?B?THlKUnNMR2tOSkNHSG4rUE1NN1czMjZURGNRUFBlcWVzVUdWemhmWmFaaVN4?=
 =?utf-8?B?d3pDZkRkZDVkYTNYdjZOMjdtdmdkTGZ1ME40VGxlbi9hOW9ML05qdXpVeS85?=
 =?utf-8?B?N0dSQ1lkSUNPM0pERVpHQ0Z2d1ZTajI4ODArOEhneHh1N3JNc2xKL0gyaVRF?=
 =?utf-8?B?ajFoWTd3ZGZNRDN0bmJhTFRZKzFYeDBGSmg2VTlGcGRLWm8xRFpEUnMxdkd2?=
 =?utf-8?B?YXkxbDNzaGcyZDQ3QnVUZkZ2QTJWZUdYd2JBRTlJS1RzRVgvSms4aHRRSkZX?=
 =?utf-8?B?ZTM1RDBweGJGajcydUdRZVE2Vk5BN29rRCtGVjBGM0tNbzRRamhqakNPNmUw?=
 =?utf-8?B?MDFnUFllbnVISFFRMitGa2lQTXd6ZjBDMHFhcEkzWnl2S2NmQ3dNSUcxUmlO?=
 =?utf-8?B?OWs3ZVhZRjREbENyem9URUhVNXAwU0IyUFo0Yk5ZTTU0K1dWOE5sdm9tM2Ux?=
 =?utf-8?B?QWVuZHFoVnI3MXZMMHRVM3VwVk1wWEFYa3FFZXJsMisxZkpHSlp2TXVJbms3?=
 =?utf-8?B?Q05RWmRhOW0xTUp1aFdUMGllZU5meUw1VnFnZ3dIT2xpQWsxczhZb3JuOFhp?=
 =?utf-8?B?RHMrSm5maUVVMnl4d1RzMU5Na0ZWanpybHd6SHZwM1NuMzdFK3Y4UThqOFQy?=
 =?utf-8?B?ZitFVDM0RlNNYXRhbXo3cTV5NEhSU01nSCtxQ2VBczRSTVZETXU4N1hTbmty?=
 =?utf-8?B?cUZ5YWpySUQvRVFzb1ZyVko4QzJYcVNEWXRYMi9SelRHSWxqZWxqc2Evb2x0?=
 =?utf-8?B?eHcwKzZMMWFkSU9NZ1ladGtGUkFXdnl3Z1FONWVkRTdDd0tBcW9oWWZ5NmRp?=
 =?utf-8?B?ZVRnR3hPdDVYU3Rpbk9IRVdtcjU1OVAyZkxjcCtVMjJrMHd6MG5YcDZtZmtk?=
 =?utf-8?B?dDQrRllBbGhTWFRtaHZnZU8xYkgwQnI1TGU5OUZtaGhId3dTbHFCVmdjbHZk?=
 =?utf-8?B?cksxejhsdythR1RvWDFaVXpYczAweHNzeFVPYjJqR0lLWVhxa2tDdXVneGhm?=
 =?utf-8?B?RzVKSzRIWkZhMENJK0wvb21SV2hhajAveG5GT0FQRWhDamo1OHZBZHhUU2tm?=
 =?utf-8?B?OHIxK09OcE9NdGFCTWFjU2VQTVhQMDRVV2VnQ3oxRERjbE81cWdxbU5GWmdQ?=
 =?utf-8?B?Rk5DZXlVeVZvVzVWTFNPdE1CaFppZCtyMWY2Y1Qrd0JNQmNHZGRIQWhTUTdW?=
 =?utf-8?B?WkIxcm0yMXJSUWJYUTJuNFlOaUY4MWJYcWlCNmRCTkM3NnhoRkFyVDlXK3k2?=
 =?utf-8?B?WHIwVy9sdjlibGJCaUNTQWoveWY3TXNwNUF6LzEwUS9STWh4UWtWaUtIZ2xS?=
 =?utf-8?B?cEQ3cmdlTEJBaWdFTmZJaWNNd3JzSE5nUkNzSytyWHdPYU81TlJqemZRaWVD?=
 =?utf-8?B?cE9TNVRDQnhXQmtOeXkwalJIT2FaN05FL0lYSUo3N1lVY2pObFcwVVZmU0E4?=
 =?utf-8?B?UGpOcEpuTFZPSSs1RzM4UUFzRkNoZ3h3QThJY1ljcFE5MVkrTFlHaDYxV21N?=
 =?utf-8?B?cmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 634d2f2c-f25c-4dc5-fb7f-08ddb394cd42
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:03:03.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPVy9F0X7YjNPBYFQtXDFBawpPLbrQr8lFQqQBDmaiXo/eyynreZYlx811GIOcu78Pl3dOcR0ji+d3SqRXaBbDzMBJjq7f5/sAO5/zgW1OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5680

PiBPbiBXZWQsIDIwMjUtMDYtMjUgYXQgMDA6MzQgKzAwMDAsIEphbW15IEh1YW5nIHdyb3RlOg0K
PiA+ID4NCj4gPiA+IE9uIE1vbiwgMjAyNS0wNi0yMyBhdCAxMDo0NCArMDgwMCwgSmFtbXkgSHVh
bmcgd3JvdGU6DQo+ID4gPiA+IEludHJvZHVjZSB0aGUgbWFpbGJveCBtb2R1bGUgZm9yIEFTVDI3
WFggc2VyaWVzIFNvQywgd2hpY2ggaXMNCj4gPiA+ID4gcmVzcG9uc2libGUgZm9yIGludGVyY2hh
bmdpbmcgbWVzc2FnZXMgYmV0d2VlbiBhc3ltbWV0cmljIHByb2Nlc3NvcnMuDQo+ID4gPiA+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphbW15IEh1YW5nIDxqYW1teV9odWFuZ0Bhc3BlZWR0ZWNo
LmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgLi4uL21haWxi
b3gvYXNwZWVkLGFzdDI3MDAtbWFpbGJveC55YW1swqDCoMKgwqDCoMKgIHwgNTcNCj4gPiA+ID4g
KysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA1NyBpbnNlcnRp
b25zKCspDQo+ID4gPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FzcGVlZCxhc3QyNzAwLW1haWxib3gueQ0K
PiA+ID4gPiBhbWwNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FzcGVlZCxhc3QyNzAwLW1haWxi
b3gNCj4gPiA+ID4gLnlhbQ0KPiA+ID4gPiBsDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXNwZWVkLGFzdDI3MDAtbWFpbGJveA0KPiA+ID4gPiAu
eWFtDQo+ID4gPiA+IGwNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi45YzVkNzAyOGUxMTYNCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9hc3Bl
ZWQsYXN0MjcwMC1tYWkNCj4gPiA+ID4gKysrIGxib3gNCj4gPiA+ID4gKysrIC55YW1sDQo+ID4g
PiA+IEBAIC0wLDAgKzEsNTcgQEANCj4gPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gPiA+ICstLS0NCj4gPiA+
ID4gKyRpZDoNCj4gPiA+ID4gK2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21haWxib3gv
YXNwZWVkLGFzdDI3MDAtbWFpbGJveC55YW1sDQo+ID4gPiA+ICsjDQo+ID4gPiA+ICskc2NoZW1h
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArdGl0bGU6IEFTUEVFRCBBU1QyNzAwIG1haWxib3ggY29udHJvbGxlcg0KPiA+
ID4gPiArDQo+ID4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+ID4gK8KgIC0gSmFtbXkgSHVhbmcg
PGphbW15X2h1YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+ID4gPiArDQo+ID4gPiA+ICtkZXNjcmlw
dGlvbjoNCj4gPiA+ID4gK8KgIEFTUEVFRCBBU1QyNzAwIGhhcyBtdWx0aXBsZSBwcm9jZXNzb3Jz
IHRoYXQgbmVlZCB0byBjb21tdW5pY2F0ZQ0KPiA+ID4gPiArd2l0aCBlYWNoDQo+ID4gPiA+ICvC
oCBvdGhlci4gVGhlIG1haWxib3ggY29udHJvbGxlciBwcm92aWRlcyBhIHdheSBmb3IgdGhlc2UN
Cj4gPiA+ID4gK3Byb2Nlc3NvcnMgdG8gc2VuZA0KPiA+ID4gPiArwqAgbWVzc2FnZXMgdG8gZWFj
aCBvdGhlci4gSXQgaXMgYSBoYXJkd2FyZS1iYXNlZCBpbnRlci1wcm9jZXNzb3INCj4gPiA+ID4g
K2NvbW11bmljYXRpb24NCj4gPiA+ID4gK8KgIG1lY2hhbmlzbSB0aGF0IGFsbG93cyBwcm9jZXNz
b3JzIHRvIHNlbmQgYW5kIHJlY2VpdmUgbWVzc2FnZXMNCj4gPiA+ID4gK3Rocm91Z2gNCj4gPiA+
ID4gK8KgIGRlZGljYXRlZCBjaGFubmVscy4NCj4gPiA+ID4gK8KgIFRoZSBtYWlsYm94J3MgdHgv
cnggYXJlIGluZGVwZW5kZW50LCBtZWFuaW5nIHRoYXQgb25lIHByb2Nlc3Nvcg0KPiA+ID4gPiAr
Y2FuIHNlbmQgYQ0KPiA+ID4gPiArwqAgbWVzc2FnZSB3aGlsZSBhbm90aGVyIHByb2Nlc3NvciBp
cyByZWNlaXZpbmcgYSBtZXNzYWdlDQo+IHNpbXVsdGFuZW91c2x5Lg0KPiA+ID4gPiArwqAgVGhl
cmUgYXJlIDQgY2hhbm5lbHMgYXZhaWxhYmxlIGZvciBib3RoIHR4IGFuZCByeCBvcGVyYXRpb25z
Lg0KPiA+ID4gPiArRWFjaCBjaGFubmVsDQo+ID4gPiA+ICvCoCBoYXMgYSBGSUZPIGJ1ZmZlciB0
aGF0IGNhbiBob2xkIG1lc3NhZ2VzIG9mIGEgZml4ZWQgc2l6ZSAoMzINCj4gPiA+ID4gK2J5dGVz
IGluIHRoaXMNCj4gPiA+ID4gK8KgIGNhc2UpLg0KPiA+ID4gPiArwqAgVGhlIG1haWxib3ggY29u
dHJvbGxlciBhbHNvIHN1cHBvcnRzIGludGVycnVwdCBnZW5lcmF0aW9uLA0KPiA+ID4gPiArYWxs
b3dpbmcNCj4gPiA+ID4gK8KgIHByb2Nlc3NvcnMgdG8gbm90aWZ5IGVhY2ggb3RoZXIgd2hlbiBh
IG1lc3NhZ2UgaXMgYXZhaWxhYmxlIG9yDQo+ID4gPiA+ICt3aGVuIGFuIGV2ZW50DQo+ID4gPiA+
ICvCoCBvY2N1cnMuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiA+ICvC
oCBjb21wYXRpYmxlOg0KPiA+ID4gPiArwqDCoMKgIGNvbnN0OiBhc3BlZWQsYXN0MjcwMC1tYWls
Ym94DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgIHJlZzoNCj4gPiA+ID4gK8KgwqDCoCBtYXhJdGVt
czogMQ0KPiA+ID4gPiArDQo+ID4gPiA+ICvCoCBpbnRlcnJ1cHRzOg0KPiA+ID4gPiArwqDCoMKg
IG1heEl0ZW1zOiAxDQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgICIjbWJveC1jZWxscyI6DQo+ID4g
PiA+ICvCoMKgwqAgY29uc3Q6IDENCj4gPiA+ID4gKw0KPiA+ID4gPiArcmVxdWlyZWQ6DQo+ID4g
PiA+ICvCoCAtIGNvbXBhdGlibGUNCj4gPiA+ID4gK8KgIC0gcmVnDQo+ID4gPiA+ICvCoCAtIGlu
dGVycnVwdHMNCj4gPiA+ID4gK8KgIC0gIiNtYm94LWNlbGxzIg0KPiA+ID4gPiArDQo+ID4gPiA+
ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiA+ID4gKw0KPiA+ID4gPiArZXhhbXBs
ZXM6DQo+ID4gPiA+ICvCoCAtIHwNCj4gPiA+ID4gK8KgwqDCoCAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ID4gPiArDQo+ID4gPiA+ICvC
oMKgwqAgbWFpbGJveEAxMmMxYzIwMCB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRp
YmxlID0gImFzcGVlZCxhc3QyNzAwLW1haWxib3giOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAg
cmVnID0gPDB4MTJjMWMyMDAgMHgyMDA+Ow0KPiA+ID4NCj4gPiA+IEkgcmVhbGlzZSB0aGlzIGlz
IGp1c3QgYW4gZXhhbXBsZSwgYnV0IHdpdGggcmVzcGVjdCB0byB0aGUNCj4gPiA+IGRhdGFzaGVl
dCwgc2hvdWxkbid0IHRoaXMgYmUgc2l6ZWQgYXMgMHgxMDA/DQo+ID4gPg0KPiA+IEkgdXNlIDB4
MjAwIGhlcmUgYmVjYXVzZSBJIHdhbnQgdG8gaW5jbHVkZSB0eC9yeCB0b2dldGhlciBpbiBvbmUN
Cj4gPiBtYWlsYm94IGNvbnRyb2xsZXIgaW5zdGFuY2UuDQo+ID4gRXguIDB4MTJjMWMyMDAgaXMg
YSBJUEMgd2hvc2UgVFggaXMgTlMtQ0EzNSBhbmQgUlggaXMgU1NQLg0KPiA+IDB4MTJjMWMzMDAg
aXMgYSBJUEMgd2hvc2UgVFggaXMgU1NQIGFuZCBSWCBpcyBOUy1DQTM1Lg0KPiANCj4gV2hhdCBk
byB5b3UgdGhpbmsgb2YgaW5zdGVhZCByZXF1aXJpbmcgdHdvIHJlZyBpdGVtcz8gT25lIGZvciB0
aGUgVFggYmxvY2sNCj4gYW5kIGFub3RoZXIgZm9yIFJYLiBJIGZlZWwgdGhhdCBhbGlnbnMgYmV0
dGVyIHdpdGggdGhlIHdheSB0aGUgYmxvY2tzIGFyZQ0KPiBkZXNyaWJlZCBpbiB0aGUgZGF0YXNo
ZWV0LCBldmVuIGlmIFRYIGFuZCBSWCBoYXBwZW4gdG8gYmUgY29udGlndW91cyBmb3IgYQ0KPiBn
aXZlbiByZW1vdGUgc2lkZSBpbiB0aGUgY3VycmVudCBkZXNpZ24uDQpBZ3JlZS4gSSB3aWxsIG1v
ZGlmeSBhY2NvcmRpbmdseS4NCg0KPiANCj4gQW5kcmV3DQoNClJlZ2FyZHMNCkphbW15DQo=

