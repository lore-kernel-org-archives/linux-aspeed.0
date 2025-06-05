Return-Path: <linux-aspeed+bounces-1315-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B8C5B543
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Jun 2025 01:45:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bCS1m4YTBz2ypV;
	Thu,  5 Jun 2025 11:45:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749087900;
	cv=pass; b=if9ezVYTajFu7RxyfCQJzoGLWmNPv+VOT+2B8gPy10acyOn+mc7xshEpuYZOYWZIdcCn076utivCApJNx3O/4sE2/dSrXwKsJ6i+ZB4GiDiw5EhEuMSL4QtGAketJ93fKNjdIfUY9FwGnx0Zo9qbFSZkZBs1iUY5sKgLU0j/7FYo4vEgYXMaKd2I59RFkPKZDD37I0elobbug5gh2d36hOExAi/Kj0J1lTYU/0/0iCPNxqy3DKDnFhifql+GIX+G8c+5VBGjNgAKcnWze9c4q33REYEjgFA85H2pIgXgVM7fpoKsStGgzQGdV2L6YDNMVvZNrTXRQ64PYvIVmHFKxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749087900; c=relaxed/relaxed;
	bh=UckRJstE4f8SH+8sMpUhZux7k8ZpEVYNu5ToBgLPK/E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RI2JDcT2TUSZCVqocKTYZ5RHlJoy3RZkwHHv+OLaRk68AljSD2pVy26VJbUcOsC5x6OiWC4qH+m/L7198tdAlKu+xUxiQOXG2aQ1WQf87Qfao4xlpkCIjrHl3vbvPjJp8FvFFTbnoIYja0VAs9k+WXA/WqNHC26cuII/SMfXYtWgHcplvrby+hgVTCIQGbD1pr4p89t+u9CI7LNbiC/pv7JkskaxmeG2pcRa34rpnhsfq4PdlHveECl8QJCay3pcrD5HIJG6xJ6jRvcfr913MAvH58lo63KZsVHySkIsG+s1ZCBUKwIvVjESmi5sOuwu7t8ge9cHE+sjlCgJFk99eQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bCS1Y4GDzz2ynh
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Jun 2025 11:44:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkfcE08NOzmt8jB5GSVYIQRObQ6BzE0wzREiQq8PGCuW4liG8miM54jCaFQZipHikPslUgREngffx85OYgJzEw0RTOWHchh/2quRs28k67AhSPfZLFltnZUTJQ2XSAUBGMNN/3hSAYbbCGh7ME2LBNkymxlzT6KAeVwwfy05Tqgqn44ub1sQIoSSSVqOh477MnVn7G3bimpDQSb7xo9G4AMYB+D3RbqEN1kAH4bqhyhkjWVQ31QCsMUG/ww+wh7ycmHPC7NfAUrDDQtaaz27BmZf45x67gAwsR4YrgVCMT+ZScc2iPg5sRcVWmF4FBx98mwcv4E2PU3w/hLR5obfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UckRJstE4f8SH+8sMpUhZux7k8ZpEVYNu5ToBgLPK/E=;
 b=wIM322l2+cmJfYeZfkiANqWbrsnxZTwqpwPo/2CrUb6oGCnHQ5vPK1KXUIXOKeMZXvo8fOA3ypOnbIFHrH9QzaTSYObiUgyz6cWmxhzp65TUuSAFf92bbXYNf0fL7tTBotoa3JFmY2mOgkiOKvcIik2ojs4vHss/jNpDYZ1hew1qG1P9piWl7Q0oZbFOwb7xsZrOdyji8sXylZn423Q1MYgbDoMHW6+rfyVc9CatSnY5kLU1+HsGWJyUv3p7HxflBMlHToJuXIm36NQ1Yhm7il7nKdehG0b3ICTzJF3dYPDlIMhjznTxBI9KCY+hly3FnDYUcPbIgRFwOTd2vf4J4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UckRJstE4f8SH+8sMpUhZux7k8ZpEVYNu5ToBgLPK/E=;
 b=ONmP3laVR2r0bp4bReoxv8MPmVL8TM5+WzQ1+kod3f2ZCiwNlMYQixXilCwhIPQ/n5XFpgFV51vYWk8qZDZoXCbDyD19NzozQA61Ba+JwqeHKgoYGl2849VoST0xO1JUpirgqTcQQ0QmGUerUh5r3h9cKqxR1g1SVilto8zIs2/4cF2l/doHguQJy8kcSpwoqnpsaLORMy1Ciet9bcl7jkFkcIaokJyy85F/HrPfaI/bNTDGujDTb8U4klxlM11+adhbvwTF35XFeDcmjPmrr/LStu9xokJ/By40XVIOAr/g8XZksaCUQSg/2D1pzJ888B/4zuCYo9NNEbU5oXBb4g==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYUPR06MB6050.apcprd06.prod.outlook.com (2603:1096:400:356::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 01:44:01 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 01:44:01 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v2 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb1VAI1rJPhsQxKUGpHJ7mTL5g97PzHW8AgACs7BA=
Date: Thu, 5 Jun 2025 01:44:00 +0000
Message-ID:
 <TYZPR06MB656866677C78C34A5AFDC985F16FA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250604125558.1614523-1-jammy_huang@aspeedtech.com>
 <20250604125558.1614523-2-jammy_huang@aspeedtech.com>
 <e27f3ea6-943d-4d78-b4d6-85d0dd521fe7@kernel.org>
In-Reply-To: <e27f3ea6-943d-4d78-b4d6-85d0dd521fe7@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYUPR06MB6050:EE_
x-ms-office365-filtering-correlation-id: d8bae5fd-a6dc-468f-2f4c-08dda3d27224
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0VJM0VrNTdveEhzQ3NjKzE0NWpSOXdDc2NoM2dZZ1ljVlhrS1h2SGFGdEZB?=
 =?utf-8?B?enh0Y0FlWkVpTXV5bGVWSFl6SThUVDVIdjZuQkxCQzZQaE9Zd2VXWW0zRzJM?=
 =?utf-8?B?YzJhZnZqa1BhZmtTVU5PQnhwcWxYK2g4aTJrZFE4ajRaeG43UERKUlgrSlpQ?=
 =?utf-8?B?amxuWThiUkJ6WnhtVEY4bnk4QVlZcmJoMTRkbjZOQXhmOVJ1RFFCaVBSdTlx?=
 =?utf-8?B?NFVPV21ZR20wLytQOHc4eHFoYjhWK1ZXOHRSSkNVNm9MVWJ3QW0yMjdrU0g3?=
 =?utf-8?B?WFY4YzN6ODNka3dJYlRBTkxqWXNQUVlmRGpLTkNKMTJYVFJCZ1M3aWd3YkpN?=
 =?utf-8?B?Q05mZTJSSk5iR05kM1ljZGQvQ1RmNWhEeFltbkRaT1pYanROb2ZUbmxvTE9C?=
 =?utf-8?B?VnQvZStMMkZ1VGVPeHZHdktGaHgzZ2UvWFBxd3dlTW1LTDZiK0d1RFFZcjE1?=
 =?utf-8?B?b3Arc3hKOFlYNzRYZWRMdkFrdTBxTERUY0dhRTlpWURDSEZDZGRlYmlaMnVl?=
 =?utf-8?B?TVhlQmU4TzlkSGlYWGpiUUhVZTdaT29kZTBBWk16ODRTQjVBSG1EMndjSytJ?=
 =?utf-8?B?TU90eFBzb3hFT2pRd0NIRFhtOGxDVjQ4d05wZzRJUWEvb3NrQXVCVk1wWlZh?=
 =?utf-8?B?aG4rRWJZOTltdCtiVjQ0Z1RZZ0VXdVovM0h0MlJmMENwcThVU0h1UlcxQkhR?=
 =?utf-8?B?eFpBUzlDeURjSzhFUmJ0ZENBNWd0MURmUFI4Vk9sWXZxVzQra0haTFhyODJz?=
 =?utf-8?B?R3BCaThWNGEyMEoyL3N5SWYyWjBJcUR6RXJybUVZbEhqdTRuWUtBZm4wK1pQ?=
 =?utf-8?B?V0VNazNhWTA0dW5wNWpZS0ViNkpGOXkrOHozbUg0Vys2QytIMGl3ZFB0RWti?=
 =?utf-8?B?QzBUVHN0b2F3d0laL1puU2N1MHhSRXU4R1hLYlJJM3c2bENqUU0rYldGZWx5?=
 =?utf-8?B?ajhYb1llck1DclgwRUdHOEZiS0h0dDZVSVFYTGNGVnhvd2hRZ0FvMFFpSzNa?=
 =?utf-8?B?NlZCNDRNbTZrOGk2QnBSRy83NXFIZEMyYi9mWWdnQ2FINDdIcThIMm9EdkVD?=
 =?utf-8?B?UFMyTTQxVmZWckhiMkhMRVZrMmRDY2RYZE52QXpoaElIVkJ4aTJ1d2llbFhT?=
 =?utf-8?B?Y3VBSlZnR0ZqTTEvVzNVZkZGV0sxMzBHbG56Z29IWFFSb1E3WE0zMXhNQzhT?=
 =?utf-8?B?bFhrRDUzS0hQSnFVWXRBTFZNZjZnUXdLVHJhSnhOZU43bktPRE9aSzFyWXNU?=
 =?utf-8?B?dmtDeHdtYUNJb1RJRjNxMWl6WlBEY3dCZTZUcGgxZUprTUJTVnFWS3l0Wk5u?=
 =?utf-8?B?d002cWtiaDQ2MTQ2RGhmV3FtSUkxajh5Qlk4RE05TG1VRWpmL216UkpvZlJY?=
 =?utf-8?B?QXY3VjhXbnQ1N3Z1RmdicUFSbFhERVVUSzVHVWt2TXI0Z1F6SHN5aDJDZmR0?=
 =?utf-8?B?ODE4RERsTGhad3lPQ1hQNTdtK3ZwekVoQ1NhZWswZzU4WXNTQkpaN3pDOG9h?=
 =?utf-8?B?VmhCMVNSdmNncno1a2ZaN2xLYldvQXpwRU4vbTJ0cVhOM0Q3UFFiRi9SUkdh?=
 =?utf-8?B?dlhYbzdNWjRmdEhVVEdHbnk3RzFrL3A3TWZsVExTRjkraCsvMUhZbzA2Nisy?=
 =?utf-8?B?SFZpQXFCdkl5TXVmdWtubUkyN2diRDlIcGxxVWY0cUZpU0ZndWRVZFB2OFdV?=
 =?utf-8?B?R2RiQi96bnplRFFtWGx1MnNHYUhDOUVZYzdiWTdHTlBYUjNaZWtOK3JIUzZV?=
 =?utf-8?B?elVqTkYrQURGR3lQZ3FYOUk1WHlpT3NHVEJ4dndpSWN0aXRNVVo5MFYzWW5o?=
 =?utf-8?B?Q0R3LzZvbUNVOFZ6T3dTdHI1TVlLSWRxa29QN1dIVlNVVzgvQU1OdURPZHdU?=
 =?utf-8?B?M1Zndlo4MCs3MkV1U2FuQlBnYk9RaEJkUzNHTEJpQkhJc29YTzVTWUZrWWhY?=
 =?utf-8?Q?4z/6IPs/dXckb1ssPTMy7oE0DfKdkg5P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmtPd1VteSs4STRaQTJMd3pqeXV6Z2taYkp4cUMvR1U1VlE4SVNMOEVCWHpY?=
 =?utf-8?B?OWs1NmlnQVNWVmpqZHE0SC94T2F1ejV4ekNoT3FrQ0ZFK3dtMm5RZVlGYklm?=
 =?utf-8?B?WGVZTVhyRkt1RDV0V3o3QVNpUXhnd3FPM2xVMTZrYnpzVCtEVEcrUHlUWml2?=
 =?utf-8?B?MjZjVytWYnlKeDB5UThlZHgvam1STHA1Nkh4S0xEdERwSWh1OXFUaFEzMEFC?=
 =?utf-8?B?ZjJ2VEZ6ZWUxc1ZVTmtjREV5NDZlYzQ0WVRLa20yVlAxWlRwS3A0S1V5Nnpx?=
 =?utf-8?B?UGxoTGVmektqblVDNXMzalhtMVRjeDdaN3A1ajZzeVUrbFR5SXpEeTd0eFd0?=
 =?utf-8?B?UXVVZEMyZVd2UGorcm9CWVJvNENubGtqOGRHZVRrZTJIL0JzQXA4Nzc3YVZq?=
 =?utf-8?B?aUtwa3BwVlJ6ZHJaM0l6RVVsU3VQdm55UWV3N2dTYWNhUnNDVU8xT3FlbGx3?=
 =?utf-8?B?OXc0aWhncUExNzFERUxJTEJJZlZ4cDdCMU96aTdtcS8wQytrd2VmWXRDands?=
 =?utf-8?B?TlZuTzFTRWU1TC9uM3YybStxcDkvWWwrNWRhV1B5clVpT0xCbVdsNm5tS1k0?=
 =?utf-8?B?TXljVzRoOThpRDErQ1M5NVhXQ3k4ei9xb1p4ckNmZThpL1lIR1VsMzBocG1m?=
 =?utf-8?B?TExheUlxVDY0aFdjc0hkTkxTNWpwZHpTTDZGWjc4M1dSN1JCcVhZRU15Yk9j?=
 =?utf-8?B?N2NLNmc1bGlJWHNROVhjd3Axcmo5bGcrSEZWSXBGN0JXNmFFcUEybWEvUlBp?=
 =?utf-8?B?Wm9INkdZdEpBN0h6ZjFEdDRxNmNsa2ZyNFJYLzhRa1B6V0xGaEptRXZQenJp?=
 =?utf-8?B?L2t5VThQaElPM2x2dDBiOHY2QlVobG41VEY4MjJUSFFweVd1NEx4WmZUeXMz?=
 =?utf-8?B?aThMclMzVXpIeVFMclV6VVoxNHlBSGFka3ZFbmVMTzllY2NOMlVReGdXS1E3?=
 =?utf-8?B?NGdER2FQRmxjck1xZStjYkRSNVExZWdKdU15SjE3NDhWWmlPRDNnU3pVRS9M?=
 =?utf-8?B?OEIxZW11T3RuV0JwVXF3aXp2UDRGZHpZSjRMRkNhRGZkdlJxWEY1WXROL3JO?=
 =?utf-8?B?d2RpNnQ0TzZCdmxyeUY4cDVGVFRlZ1NyRm0ydXpMZWgrSUd4MHFSTCtjd0lq?=
 =?utf-8?B?RC9GenZvVDB5aGZCM2V5UFA0ekxZbURjMlFjZ2EzQVBBbmcyMkVVZndnTHVU?=
 =?utf-8?B?VHA2eStKRERxZDFtVVpmMiswa3JBbVNvaFpFUi9UNGJCak9rb2F3aU13NGFF?=
 =?utf-8?B?cjRBdkk3Y1VKTktERlo2bWIyNXFSSjVsdEQwT2g0ODl4SDMwUnR3MmVWOExu?=
 =?utf-8?B?OEt1QnI1ckdyVTJFd3p0cUtNckxyMTBVcFhXTG51Q3B4bU9OQ21QMWh4Y2Ry?=
 =?utf-8?B?cU9XQVhNZWJ0a0kxMS8yWmk0eUo5NnlKMnlTdWJSYWRrY0s5TmFtWGg4ZHFN?=
 =?utf-8?B?a0VYWUk1NkRMdWcxUDEyWE91SERDMzN6QlRGTjZDRTVzL1FSMlJSRndZeEpo?=
 =?utf-8?B?Q3FoSUcyQzdBTGtRVm5Dek1FY0FXYjVzMlc1c3BFVFhPaWo4RElTNEtjYXBX?=
 =?utf-8?B?S2Z1RjBybmhtcm1NYzJWelMrUWxyVjBzNjdHVTd0MmtlN1VWWXBrUGNNbjVp?=
 =?utf-8?B?amZadUlQZlRpMWxLZ2YraGVJZmdKMktPVzY5SFgzK05ZblR0NkNGUDN1MHBF?=
 =?utf-8?B?T1lSazVDZVFCVEpWbXNpeHVmZUg3K3NvYWpISWR6akpuUFkzNElPOTJVc0JL?=
 =?utf-8?B?MHhnR1F4dFlYcXV6eG5iSmthVUxmVXdpT2lBMnlEOFJYNUhJNkVwSGJkUm9L?=
 =?utf-8?B?M0hDQnVJRk9kcGpyTHNYNVpQNkVyb09HSmtRVnhWSlc1bzFMbUNKVmFZOWd4?=
 =?utf-8?B?L2dJc2I4VmdvNHNMVW5RVTc5S3R4cE9XeUVCRHJ0YVA5b0RzR0lFbjE4YXFY?=
 =?utf-8?B?aGQxZDRhTy9JQkg3K2dNZ0ZDaHZFS0MxU2J5S0YzNHViM2JDU3YyWkdCTjVw?=
 =?utf-8?B?R3ZyUWQrY2RxQk95Mms2Nytqcm94R0hGcWtSeU8xa3JGYnFYRjl6c2R3WUJk?=
 =?utf-8?B?R0NvT3pkbjB5RFMya1dTcUJncVpCZS83RmFsdStDdmV2ei9HU0pUU0hkNWFW?=
 =?utf-8?B?MkZvSGNUWUVQQ1hyRncrR045Ykd0MytMdTFDUjcrVFN5QUR2SlZuMGZHbXE2?=
 =?utf-8?B?L3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bae5fd-a6dc-468f-2f4c-08dda3d27224
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 01:44:00.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WArpwR+76esrig3LLnAeBE00sz5t4BitfBaKsQBNsP9VQjhIu3v2yBctrM3jdedmxsPi1sbSlYIk1CUouQlK4WZ+S3SyqlcOvovTwImlduE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6050

PiBPbiAwNC8wNi8yMDI1IDE0OjU1LCBKYW1teSBIdWFuZyB3cm90ZToNCj4gPiArDQo+ID4gK2V4
YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVy
cnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPiArDQo+ID4gKyAgICBtYWlsYm94QDEyYzFj
MjAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLW1haWxib3gi
Ow0KPiA+ICsgICAgICAgIHJlZyA9IDwweDAgMHgxMmMxYzIwMCAweDAgMHgyMDA+Ow0KPiANCj4g
TGFzdCB0aW1lIEkgYXNrZWQgdG8gdGVzdCwgeW91IHJlc3BvbmRlZCB5b3Ugd2lsbCB0ZXN0LiBX
aGF0IGhhcHBlbmVkPw0KPiBZb3UgZGlkIG5vdCB0ZXN0LiBUaGlzIGlzIGp1c3QgZGlzYXBwb2lu
dGluZy4NCkkgZGlkIHRlc3QgZm9yIG15IGxhc3QgcGF0Y2guIEluIHRoZSBlbmQsIHRoZSBlcnJv
cnMgc2hvd24gYXMgYmVsb3cgZGlkIG5vdCBpbmNsdWRlIGFzdDI3MDAtbWFpbGJveC4NClNvIEkg
dGhpbmsgaXQgaXMgb2suIEkgd2lsbCBjaGVjayB3aGF0J3Mgd3Jvbmcgb24gbXkgZW52aXJvbm1l
bnQuDQoNCiAgQ0hLRFQgICAuL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncw0KL2hv
bWUvb3Nib3hlcy9saW51eF90b3J2YWxkcy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY3J5cHRvL2luc2lkZS1zZWN1cmUsc2FmZXhjZWwtZWlwOTMueWFtbDogcHJvcGVydGllczpj
b21wYXRpYmxlOm9uZU9mOjE6aXRlbXM6ICdvbmVPZicgY29uZGl0aW9uYWwgZmFpbGVkLCBvbmUg
bXVzdCBiZSBmaXhlZDoNCiAgICAgICAgW3snbm90Jzoge30sICdkZXNjcmlwdGlvbic6ICdOZWVk
IGEgU29DIHNwZWNpZmljIGNvbXBhdGlibGUnfSwgeydlbnVtJzogWydpbnNpZGUtc2VjdXJlLHNh
ZmV4Y2VsLWVpcDkzaScsICdpbnNpZGUtc2VjdXJlLHNhZmV4Y2VsLWVpcDkzaWUnLCAnaW5zaWRl
LXNlY3VyZSxzYWZleGNlbC1laXA5M2lzJywgJ2luc2lkZS1zZWN1cmUsc2FmZXhjZWwtZWlwOTNp
dyddfV0gaXMgbm90IG9mIHR5cGUgJ29iamVjdCcNCiAgICAgICAgQWRkaXRpb25hbCBwcm9wZXJ0
aWVzIGFyZSBub3QgYWxsb3dlZCAoJ25vdCcgd2FzIHVuZXhwZWN0ZWQpDQogICAgICAgIEFkZGl0
aW9uYWwgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdkZXNjcmlwdGlvbicsICdub3QnIHdl
cmUgdW5leHBlY3RlZCkNCiAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvbWV0YS1zY2hlbWFzL3N0cmluZy1hcnJheS55YW1sIw0KL2hvbWUvb3Nib3hlcy9saW51
eF90b3J2YWxkcy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tc20v
bWRwNC55YW1sOiBwcm9wZXJ0aWVzOmNsb2NrLW5hbWVzOml0ZW1zOiAnb25lT2YnIGNvbmRpdGlv
bmFsIGZhaWxlZCwgb25lIG11c3QgYmUgZml4ZWQ6DQogICAgICAgIFt7J2NvbnN0JzogJ2NvcmVf
Y2xrJ30sIHsnY29uc3QnOiAnaWZhY2VfY2xrJ30sIHsnY29uc3QnOiAnYnVzX2Nsayd9LCB7J2Nv
bnN0JzogJ2x1dF9jbGsnfSwgeydjb25zdCc6ICdoZG1pX2Nsayd9LCB7J2NvbnN0JzogJ3R2X2Ns
ayd9LCB7J2NvbnN0JzogJ2xjZGNfY2xrJ30sIHsnY29uc3QnOiAncHhvJywgJ2Rlc2NyaXB0aW9u
JzogJ1hPIHVzZWQgdG8gZHJpdmUgdGhlIGludGVybmFsIExWRFMgUExMJ31dIGlzIG5vdCBvZiB0
eXBlICdvYmplY3QnDQogICAgICAgIEFkZGl0aW9uYWwgcHJvcGVydGllcyBhcmUgbm90IGFsbG93
ZWQgKCdkZXNjcmlwdGlvbicgd2FzIHVuZXhwZWN0ZWQpDQogICAgICAgIGZyb20gc2NoZW1hICRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9zdHJpbmctYXJyYXkueWFtbCMN
Ci9ob21lL29zYm94ZXMvbGludXhfdG9ydmFsZHMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2NyeXB0by9tYXJ2ZWxsLG9yaW9uLWNyeXB0by55YW1sOiBwcm9wZXJ0aWVzOnJlZy1u
YW1lczppdGVtczogJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVk
Og0KICAgICAgICBbeydjb25zdCc6ICdyZWdzJ30sIHsnY29uc3QnOiAnc3JhbScsICdkZXByZWNh
dGVkJzogVHJ1ZX1dIGlzIG5vdCBvZiB0eXBlICdvYmplY3QnDQogICAgICAgIEFkZGl0aW9uYWwg
cHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdkZXByZWNhdGVkJyB3YXMgdW5leHBlY3RlZCkN
CiAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL3N0cmluZy1hcnJheS55YW1sIw0KL2hvbWUvb3Nib3hlcy9saW51eF90b3J2YWxkcy9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vdGksYWRzNzg0
My55YW1sOiBwcm9wZXJ0aWVzOnRpLHgtcGxhdGUtb2htczogJyRyZWYnIHNob3VsZCBub3QgYmUg
dmFsaWQgdW5kZXIgeydjb25zdCc6ICckcmVmJ30NCiAgICAgICAgaGludDogU3RhbmRhcmQgdW5p
dCBzdWZmaXggcHJvcGVydGllcyBkb24ndCBuZWVkIGEgdHlwZSAkcmVmDQogICAgICAgIGZyb20g
c2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQovaG9tZS9vc2JveGVzL2xpbnV4X3RvcnZhbGRzL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnB1dC90b3VjaHNjcmVlbi90aSxhZHM3ODQzLnlhbWw6IHByb3BlcnRpZXM6dGks
eS1wbGF0ZS1vaG1zOiAnJHJlZicgc2hvdWxkIG5vdCBiZSB2YWxpZCB1bmRlciB7J2NvbnN0Jzog
JyRyZWYnfQ0KICAgICAgICBoaW50OiBTdGFuZGFyZCB1bml0IHN1ZmZpeCBwcm9wZXJ0aWVzIGRv
bid0IG5lZWQgYSB0eXBlICRyZWYNCiAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCi9ob21lL29zYm94ZXMvbGludXhf
dG9ydmFsZHMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFk
NzE3My55YW1sOiBvbmVPZjogTWlzc2luZyBhZGRpdGlvbmFsUHJvcGVydGllcy91bmV2YWx1YXRl
ZFByb3BlcnRpZXMgY29uc3RyYWludA0KDQovaG9tZS9vc2JveGVzL2xpbnV4X3RvcnZhbGRzL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDcxNzMueWFtbDog
b25lT2Y6IE1pc3NpbmcgYWRkaXRpb25hbFByb3BlcnRpZXMvdW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
IGNvbnN0cmFpbnQNCg0KL2hvbWUvb3Nib3hlcy9saW51eF90b3J2YWxkcy9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvcmVuZXNhcyxvc3RtLnlhbWw6IGlmOnByb3BlcnRp
ZXM6Y29tcGF0aWJsZTogQWRkaXRpb25hbCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAoJ25v
dCcgd2FzIHVuZXhwZWN0ZWQpDQogICAgICAgIGZyb20gc2NoZW1hICRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9zdHJpbmctYXJyYXkueWFtbCMNCi9ob21lL29zYm94ZXMv
bGludXhfdG9ydmFsZHMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gv
cWNvbSxhcGNzLWtwc3MtZ2xvYmFsLnlhbWw6IG9uZU9mOiBNaXNzaW5nIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzL3VuZXZhbHVhdGVkUHJvcGVydGllcyBjb25zdHJhaW50DQoNCi9ob21lL29zYm94ZXMv
bGludXhfdG9ydmFsZHMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gv
cWNvbSxhcGNzLWtwc3MtZ2xvYmFsLnlhbWw6IG9uZU9mOiBNaXNzaW5nIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzL3VuZXZhbHVhdGVkUHJvcGVydGllcyBjb25zdHJhaW50DQoNCi9ob21lL29zYm94ZXMv
bGludXhfdG9ydmFsZHMvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9hZGks
YXhpLWRtYWMueWFtbDogcHJvcGVydGllczphZGksY2hhbm5lbHM6dHlwZTogJ2Jvb2xlYW4nIHdh
cyBleHBlY3RlZA0KICAgICAgICBoaW50OiBBIHZlbmRvciBib29sZWFuIHByb3BlcnR5IGNhbiB1
c2UgInR5cGU6IGJvb2xlYW4iDQogICAgICAgIGZyb20gc2NoZW1hICRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy92ZW5kb3ItcHJvcHMueWFtbCMNCiAgTElOVCAgICAuL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncw0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0K

