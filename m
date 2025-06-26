Return-Path: <linux-aspeed+bounces-1580-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C784C7115B
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Jun 2025 03:58:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSPzg4W80z309v;
	Thu, 26 Jun 2025 13:58:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750910287;
	cv=pass; b=KZWXztDG4ntOb/iFUOiPgS6v/XkAyBF+5vlBgFCdyl4azjfV5F0DXlJGI8Y0I6FMwAlUvLuO3/rtlkxocj6WOrATVZmG0Q417YBh+M9fVsADN3COmwljnJiuV0OcxSyZkiWm6bJRdqZDJbB5Ndl1CghEh1LnaVscPRZyyP1i/sRsjypVlc85pu6euzjaTDs32W++9cPKSNnMEXtgqvm9NARgxKpp5igtPAaY52RAobJTa4kM1KeMv278ZYzjKGsG/k92UUdtCCVFUKezqs2aJF2Gm5LLoNOFVzciqY/Qyce6Txbq5FVQSqvxqXrHV7eJjESFwltGy387cTqab7JDTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750910287; c=relaxed/relaxed;
	bh=bzyJ1RvP48bQ0cboGHTX0OG3xga66fbEztzQ6sqmVnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qg/lKcReMbYnANMovo4th8MGFPFM9y/cjX9vNNcZ8C//gX7drF205cE3DNfzy4DmjUOrtCS3m82Rb8SiWJOSmAz1WqdjoDN4eH8M2k1iNh43UsYqxTjlyYuaU22JM6sXQrK/nrrAnd6S/46wi/ACtZ5DBsfP1gGivZaoCfUivfOoWeP+KUrgiZPJyomaTffOzJSUt9Waif1hPJ6TA/fvT9MuCNNJTpr4qPLbIxJePhyfH/5hISifY5YB9B8sdsLNb9hXbQy0oN9IBExXdE0kZzUDxbZV5ZyM+XS8DsV9sik1fktnMBd9IlfhDElR90Ehd+03Sc160WKcfUQeRkZniQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=dkUh+Fw8; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=dkUh+Fw8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSPzd3DpBz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Jun 2025 13:58:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD2J2bQ3oV0ttSpzkCYxtNzf46UjEfF+VOoT6uidBAY4q2WCnvBATYtM1P3CKUUr85CByqOZgFu732hQf5C+1Y++JIny8hyA8YOWTcOf4UoD/5Mql0NQUBe1gKpc6iMtGzPfBtyk8VCUn+XJko9mg+aIVI6cfq5pj4vmYNVS943B4GwCUvW+lJoY364oKxANJRzPsfkETfXKa/EUWtKPkECK3onmmh1DYPJx2HlU+Cn9EygLSbgqs29mNHzwnbXMhW0qgajH/B6wzEnE0mQ1ZTC9JG1dAr7B/txe5bJyWcR3+z6l9wQPUIbHq9IzQ4xOYqO6UBRekeSuuAS5ScPyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzyJ1RvP48bQ0cboGHTX0OG3xga66fbEztzQ6sqmVnw=;
 b=lYQXG0BWyJHeHjog1ZeJzUsa5VImzX6OLDSbAqANuk8XT+nvQ4fNY1ITe4vGWg5na18Tbix5u2HhbGHk9QHijSv5ytMmodpq2A35CezdB3cnMeyOoJtmrYm9nRy0WRmvhvOO0XIqzTuj3WU+cHKG1qUXL44Rowug0HFVn/+ztohApw8an/lHFNaZX3szOrpuDexkPwSLC+uIegea30QqO3Gx2QEkGwJ3qvxe2BV6ODSMeEWxlzu3jJJ7PAhIGbG/YZ6C+ZToJyOxjDzyxsb3FrNLeE5Hvon0hLsPJgDTN/G1yT1olxibz78hY/hmyorYnrBSVkxP/4XfLDULnVdD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzyJ1RvP48bQ0cboGHTX0OG3xga66fbEztzQ6sqmVnw=;
 b=dkUh+Fw8vXVV3DMv4pk9g1BLLelemI1+kIhjQgqEauU5eutt3i9ckeUMt8EciMmJo9zEmrd4Bd5t8W/GNCnWJDdhrTQt6c9AyNUXtL3bVPQRdOrwn4H0IVgQy4KOcXWrlx3PRdmDfqzvlmctP4Y+K9Lu+PDTjlHujuxLQE9FLw4eelLRiczEhjQXhcmGij/PA5wDrjTVnqmadlB53tPllCCcB9TIfYTihIijfw96vPPH6VTArDk6m1PzsA32N6u0zR9VDb2MMbNaJqEIgNmcUNuhHFPMtRFBl/8+CFZeyBTC/itggwFdemoOE5aTgl5KGyWUL31REAAyt/akN7Nikg==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SEZPR06MB5200.apcprd06.prod.outlook.com (2603:1096:101:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 03:41:42 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 03:41:42 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb5ejXM1vEEl7n4Euw0osJMHWsTLQUwIRA
Date: Thu, 26 Jun 2025 03:41:42 +0000
Message-ID:
 <TYZPR06MB6568CA1AD00A1D749CD06C8BF17AA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250625073417.2395037-1-jammy_huang@aspeedtech.com>
 <20250625073417.2395037-2-jammy_huang@aspeedtech.com>
 <20250625155007.GA1489062-robh@kernel.org>
In-Reply-To: <20250625155007.GA1489062-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SEZPR06MB5200:EE_
x-ms-office365-filtering-correlation-id: aa64760c-7a26-482f-c298-08ddb4635dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KGKcIBfF2phGlLAScvjveOZzui16x1S/yPh4zvmD/Nx1NhOaXcoeYCzPEHRr?=
 =?us-ascii?Q?NbiIki7p0EnZ76ftrr3T9JTbNC1wVMm9PWILlFfPcs4rGVno/oCU2fmmoVLP?=
 =?us-ascii?Q?LZv7VomxU8tRgFLUr7VH0hraJ5v5E903+CbwTr942dSJSoQafCpmOiS5mcU1?=
 =?us-ascii?Q?B3NvG0xSBt5ygSNg8HSJZXdbRjwdXyKQE3mki0t2AE4Ew7qMELNmlqndp/vG?=
 =?us-ascii?Q?ZnxaQwcS+3CJ1t1GjCX+7p00AVG58/nnYdTMzUl7GxN3R9DhPluV35iAUGIu?=
 =?us-ascii?Q?4RED2z8DgIFXxseSDFn3RWD6+k43SZV+gO7VRinbbLi4ehPlrWCkNurm7UvF?=
 =?us-ascii?Q?ayPHsWAGdTxFcnAKe5SCtjTo4yxk++Z31wkPuD+OMzlid4HbylTFZVq4ItJs?=
 =?us-ascii?Q?zHOLM4K07pvpr8Ovh/XyNWGF5wWicTPlD8RD2bPKunbBjUllgWgyhnP/ozlh?=
 =?us-ascii?Q?zME2Mhf7uMwXG0BG93uhmPwWCyFb5R1YSOBAyoUP/puunstPvO48PfZs9mqe?=
 =?us-ascii?Q?Hz4stEBnnUIbYz3Zsbur3VgFIEvF+hUnZi+QVxDnnq5Pl3u855wWsN9JJgeY?=
 =?us-ascii?Q?HHCfz1+dnU5Bp6g+YRxy9F4M7wAHDJHzOQNAJuHWRdkqj+jarwpnp9EF1bhj?=
 =?us-ascii?Q?ZkeZUMHzuh5zzm49AU/NUOaZf+ztUMIKUCEwMminbZ4c/G64NjQgD7yWjcFK?=
 =?us-ascii?Q?xwZiYPJUXUjY4PBXUcXa4gMvj+J+U62+iPDUnI7R8xN6qUfcAsmpWwFTziwB?=
 =?us-ascii?Q?4k+Y56f4eQnVn1ohjEvisYU/Ebh4ZoBANHHdQXxSBOVwA6ZMnAz5KI8b5NY8?=
 =?us-ascii?Q?7ourrTbMGotf8FtJwm+YK0TrEbrKkPtsj85rGRLOWrand7YVOGaHBQMT7MLb?=
 =?us-ascii?Q?VHaH1cH9op87aXc8lTcjraJB3JgNehrRpawga3xFjib34j19yqQPrQ0eHnLy?=
 =?us-ascii?Q?+il0qX0dSPmGv3Xlfw88dlYDLVfV4Hr+LeD5iUGu72U3lHbYT5IQb6Z98Iw6?=
 =?us-ascii?Q?94DPdsSC7rpDF34eNoP5A4Fl0MprUTLahRGSj5k/JQSdExlE1+pc7udHIkV3?=
 =?us-ascii?Q?BdKkobixieSk4sn0wiGkvRXFy8lUtupusPatBk18pWB0MeeW/bmfLabpZFxE?=
 =?us-ascii?Q?YUX5zviTrT4aKkqIc0vy8QvSEGpdJK1VhelqwjaVwTmlajJUhmRmtl831yCw?=
 =?us-ascii?Q?5kcB+a8aYyyKNHT6IRyO+XYEPTD62/x+58c8MH8JnFY9DGRU4qXj7emKToAZ?=
 =?us-ascii?Q?yNj7daRd87zyojeku7OQDOrCClIgzFVT6r5dxN3nkDv8MwK0Wn5Z3tmgiYl8?=
 =?us-ascii?Q?SvJI09bzN6iE0TrZulJryUrX0yTnAxD+AIIDZEmHGE3VG8w/1wLa975e8KLy?=
 =?us-ascii?Q?tD9C4TzSGmziXW2+KKx4oWI6yphD/ao6ae+CEaTCQ8b3NK+qWxqMMHRP8E3K?=
 =?us-ascii?Q?O7db65Z7i6zY96CgPBWznuepsnrC4474?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pvP+2znu/daHfcX3ACcFkeIB6Twd00ZcmObGRXkV3o6V4RmdalBD2P2Pzc5o?=
 =?us-ascii?Q?LVAjRn796Xkk0OmjnarfEJGDD2aRnoimrfJ3LDlRwHKGx8spbaEwQJLozvpC?=
 =?us-ascii?Q?VR50pOAtwfpDOMdxXGvmUX3mO1vK/WcAX/NAbsQMszMN2RcqQeY/uhzqfDab?=
 =?us-ascii?Q?nqaEwiine11bnDL3EPg5T0mg0xdji+9hVa7tKKZz+p9B4phRez51QBWuBzIe?=
 =?us-ascii?Q?3SFuBrHgbjItTBXim2SGNpAaIPyHIRHGMDIfe6+C0QgpFvGuBnRB9QVaHi6q?=
 =?us-ascii?Q?aNlMWKZ9JEsnhjrqBHytGXP8+rJYl75+wc6sQek7Wgz3mYXEFgNqh3FrM3D1?=
 =?us-ascii?Q?lDUZSQNEPi9Iq1rKWQgSsDf0UScbEV3p25OwCQl6CK38fnonoIPraT9K4/dX?=
 =?us-ascii?Q?v+ne6KgIf4RNDePKDI4uq7zy3KPor8U6nwQabkBlSyYFkzdFutsFTwohdwXC?=
 =?us-ascii?Q?J21aqxDVwbh56l3WPtY9LSLjjzmdcMKH15zMX/TPFRs3pbuEd12eneXr56ke?=
 =?us-ascii?Q?7bJMH6+3LLbwRCCusoxKQG1oNMSL5/iv9iIExaQbtd1pJzy2+UOhDKT0wo4A?=
 =?us-ascii?Q?CixvcLPYC/pUvJuuN+6gljTgYd9gVKr+jUB9XgzvhOAbcvfc5WkFn25/CJRt?=
 =?us-ascii?Q?jbzmaoLnilzTUUnvh9/08ODAbU2p+VS3XFuo0hiQos6EpVPgzKQ22RP7RvHD?=
 =?us-ascii?Q?ivu4zKhSIfzLXodmKqtYwXSpGEIYPAfTrvJ9//hXpaFEkYKQBe2iEKVAymiy?=
 =?us-ascii?Q?2shvjGuqgpuhhQ22cKgX9dghD5xXiZWm7fPfeUp8+dXwP8Ep0I46QuhewD9N?=
 =?us-ascii?Q?ZhkPwfkC7q68ZsCHGe6edxRTixIm4GF1YE6t+WpWCWTK9ecJ0aS8wUiQHaRS?=
 =?us-ascii?Q?angrwXZTVtsKl+y9NxaRlnNBb64Z6hV5WGBoDWUKmaEkZ8tv8ubTgfFzYY+g?=
 =?us-ascii?Q?xBaoJR17fPfD5XtYu+Oyq7TYEy9FERIsOw/T5XzB4xpzCxlb1vP2bkPVCyHZ?=
 =?us-ascii?Q?KJgZHWl/ZOQQxfMLUZyxF/V3A/MPMiLK1EM0R11JBTEe6gUmf4IVoK/F3AWJ?=
 =?us-ascii?Q?CdVwTIMEGn+cdex2Pqj9RHDIruC74xr8ccYOuBONc0pZB/gRazwMx6eQez+B?=
 =?us-ascii?Q?rezuYMinLKGuU9feW/pltnxtNI8gBTls53iQyXAtc+Zacsq0IF0WI8xF6NL5?=
 =?us-ascii?Q?ofcKc0O8TxGRqH/f09FLQ0tVhdA6NmuqFvHdfqbIQp6A6wl5YRCS10zPxdnc?=
 =?us-ascii?Q?OrSRo9cwWyCg2fXJiDeGQJhVRaZ66Wda/2YrvL4KhDduQ08RL9kLlbcfjrQ0?=
 =?us-ascii?Q?GwRsh/gni1CUxlKCfJ/eaJulqfDaYrM6eyJiUAKqbhPiB59i2v4/1ezygrAR?=
 =?us-ascii?Q?AXOesG/x0Nuf4pXYDW4jQV0hl6lsXkwSi921ahLAcOLL3rh7yIiHxvMEao3G?=
 =?us-ascii?Q?R0ORG8N4KI5Dc6gAFMkhVte39UyAN0vb2l4VeeXoM6g01xC4n7lpTFBLRQPW?=
 =?us-ascii?Q?PEtaBqstvkkBvYXKFXnKx5RmUx7HwZbIPKOujnOseV57Acl7H1XyE2WX7Oez?=
 =?us-ascii?Q?TJLxk8ULTO2jTbCSWYMVZu9cF9DXHjVwOSfymDk4F8N3TRJofhoAMIkwjjph?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa64760c-7a26-482f-c298-08ddb4635dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 03:41:42.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Au63j8az63MRfR5GlA8W6yaAE+l7t2y8EKMLOzMk4xwgOsROu1B4mMo0XRR+7kK8YQl/Umc1mtehDC3FToJ53OinmqQALhQAhb8bWn47bQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200

> On Wed, Jun 25, 2025 at 03:34:16PM +0800, Jammy Huang wrote:
> > Introduce the mailbox module for AST27XX series SoC, which is
> > responsible for interchanging messages between asymmetric processors.
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>=20
> You didn't add Krzysztof's Reviewed-by...
Hi Rob,

I checked submitting patches' guide, and it says that if the patch has chan=
ged
substantially in following version, these tags might not be applicable anym=
ore
and thus should be removed. I also mentioned this in changelog on the cover=
.

I am not sure about this, so may I keep Krzk's Reviewed-by tag?
If it's OK, I will add it back on next patch.

>=20
> > ---
> >  .../mailbox/aspeed,ast2700-mailbox.yaml       | 60
> +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yam
> > l
> > b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yam
> > l
> > new file mode 100644
> > index 000000000000..0a5f43de5f28
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox
> > +++ .yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/mailbox/aspeed,ast2700-mailbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED AST2700 mailbox controller
> > +
> > +maintainers:
> > +  - Jammy Huang <jammy_huang@aspeedtech.com>
> > +
> > +description:
>=20
> You need '>' to preserve paragraphs.
OK

>=20
> > +  ASPEED AST2700 has multiple processors that need to communicate
> > + with each  other. The mailbox controller provides a way for these
> > + processors to send  messages to each other. It is a hardware-based
> > + inter-processor communication  mechanism that allows processors to
> > + send and receive messages through  dedicated channels.
>=20
> And a blank line between paragraphs.
>=20
OK

> > +  The mailbox's tx/rx are independent, meaning that one processor can
> > + send a  message while another processor is receiving a message
> simultaneously.
> > +  There are 4 channels available for both tx and rx operations. Each
> > + channel  has a FIFO buffer that can hold messages of a fixed size
> > + (32 bytes in this  case).
>=20
> And here.
>=20
Sure.

> > +  The mailbox controller also supports interrupt generation, allowing
> > + processors to notify each other when a message is available or when
> > + an event  occurs.
> > +
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2700-mailbox
> > +
> > +  reg:
> > +    maxItems: 2
> > +    description:
> > +      Contains the base addresses and sizes of the mailbox controller.=
 1st
> one
> > +      is for TX control register; 2nd one is for RX control register.
>=20
> Instead, just:
>=20
> items:
>   - description: TX control register
>   - description: RX control register
>=20
Agree.

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#mbox-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#mbox-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    mailbox@12c1c200 {
> > +        compatible =3D "aspeed,ast2700-mailbox";
> > +        reg =3D <0x12c1c200 0x100>, <0x12c1c300 0x100>;
> > +        interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > +        #mbox-cells =3D <1>;
> > +    };
> > --
> > 2.25.1
> >
Thanks for your help.

Regards
Jammy

