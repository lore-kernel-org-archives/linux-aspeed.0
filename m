Return-Path: <linux-aspeed+bounces-3495-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD9EF06E3
	for <linux-aspeed@archiver.kernel.org>; Sun,  8 Feb 2026 02:27:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f7sDc0vFvz2xdL;
	Sun, 08 Feb 2026 13:27:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770517664;
	cv=pass; b=W9TiUlr5nahNTkyZG0ClnT6k8j1DMOkNcJ/tZkFSvyQw6cClMmwWuEJ10G+aZZ7YhzPCir9AlnFFaycFrtNv+I4RNtQegQQik1OJ05fIvA1nR1a57Fz7ntn2RFHqDofOLDcMUY5b/EDwoiAWXng9Z32RJOvqsrQIBjt+o8tcLxowMKiTPYSBug1AVXSa6vxbuZQmKa1m3a69BN70TXiu2aR+ZBMwqhvbxg9JigveaG/WqXNYuQ+ZE3HU70XhHLCET71tUu4Qn1ZCgVMJvWc6h0j9X2o6+wkM7GhAWqGi0tKVqWTcZ++rWQbrA3QKTl2NQbvTQLlS+2GPgJFhqvtj1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770517664; c=relaxed/relaxed;
	bh=udzCF4e8SFbF0+5FwWIBVuFBmsRDMRCvHOoKXN4Zbx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TLF9zhhlqlcOPWYd05k1vOOrlfAhBGX9Lk1NT2wJjwESCLZuuTzE0P4KTWrogNA83Q2CqAZobEMblLAWDBnTN5sas364HAd9m0T5f9rwIqZA/lv78NhgDjerfjjsMP0QNWsGNqtxa40xWmsOyAMWOt5adlfqRN+nFkuoEmOdaKnJLJrN2rGuWjioZ7+L8Fi6qgMOW7LlcNYGvJQruAxcIVFsSlrcugWLJDvdDVycyfeQkJQ22tju80iPBeCBvjgpDqIFwQLevNpBtEc6/TQURyvC9G2EQwFYRleJfN57IGDV9sASproN/JtOSZVbL/rdwB5Ac4I6Pw8oNpdwHzkbJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=a/29g2O3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=a/29g2O3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f7sDb08Blz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Sun, 08 Feb 2026 13:27:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB4es7xUb3Xx0akNxnfpb3Qqq1SXKojuhnyef8yEunYMMxwImbTgAciqh1yZTWAv15Ma97BMoACf/wFVpQoxIW0xhiQk+xq34mhztH852BAmNZf4dDneOu15PUpQqv5Wrg7snIlzsw4pD90QKji+qS58sfjHGhi88UTpj9BsgdptiP8t/YplvX8cFJ3dJb/y6vcAAtN68I/lD8UrAwFOWYqRo3YuXjuJSbn14GtNBM2c4xH/XiczAB6An3eAgS+d3S/sXskNbCeRYxjWgii+lFxyrCrskd8ZbRjhDSoXmcqeAQcZ/yhScUuRB8viipzhCUtJUf6x0F2nYJKT4/5FfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udzCF4e8SFbF0+5FwWIBVuFBmsRDMRCvHOoKXN4Zbx4=;
 b=v1+b3qtRHbh0kGZ5N81mjoUJzhYQLFQCchbhrhJpUQv3g20Hbk5+oBhSSjPnhtQ6SH2Mmmycg+MSyWsOZqJW8a2lzNQ+HYdgKjJEK9Ns/hlCywvrMxBCTrMed/GAsLvES58MBwzOzSv+NHl2uQPUCaZhQrTx5U3xu7ktqLVa1ry8gbTDDGZr0Br5VXQDX4f5NYJzX618t0NwnCZ5FCaMS9oay5e+mPdKu5cAyjwjfo5eP6k3Eak1qJk5oqyc7YM6n8ifsz/n7Ilyz33iD9SZ3c2qaK6tdmQdxFOgrAqUx299sEfOGZZ8j8H84CtGJdpbrGzob7eWYERyqbn1E9Orjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udzCF4e8SFbF0+5FwWIBVuFBmsRDMRCvHOoKXN4Zbx4=;
 b=a/29g2O37ksp5/m0U9UrrmRBFOVAEp89qLnOjDGmQv9X8Oh4mBtpsS1pUQeZlB1/3NQR9Mms8AUS1miphGDDEQwyFNwxukMJwRmCmWTqyVROqGg9Xnotp9lxIvAnylCLrCEtnpQhJve/4Gt2jrW5zZRNn132oWYidfny+FGSVccv/3cqtnS9/jHsGRG5kCERRyzycmg+9VSBXlw3tW/UaolfAaDVBaV1KuTP+FfxytMACN/PnR3eo+dDrjqy5G3BpbD1oQVAHqY/3cGf6IFVJr3qGoROvW9zU/Imaghz3/1YJerKqaK/3d7GuPaDhwsm/1oJf+7s0y4sK0f783bJYg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sun, 8 Feb
 2026 02:27:14 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::8c70:cb01:78fb:d9c0%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 02:27:14 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
 support
Thread-Topic: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
 support
Thread-Index: AQHclmW5rzV03X0Kg0SxRPeN+45NtrV1jEMAgAD5ciCAAKtrAIAA5pbw
Date: Sun, 8 Feb 2026 02:27:14 +0000
Message-ID:
 <TY2PPF5CB9A1BE694EF0F82A274A441D252F264A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com> <87h5ru14xx.ffs@tglx>
 <TY2PPF5CB9A1BE6CC5EEC90EBF13B083D1EF267A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <87sebczpyx.ffs@tglx>
In-Reply-To: <87sebczpyx.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SEYPR06MB5891:EE_
x-ms-office365-filtering-correlation-id: 2dae8afb-1b84-4125-5a21-08de66b99241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UsgMPeZGQ2sedyypmfsHDU2U391lOoZCwOsVKA7ZUJ4r4uxq6Ond2GFYP6b8?=
 =?us-ascii?Q?4Sar1T7IIhdzQZ5xipFHO1qqkL8iTiKIeKVgPgvUk5SaIcJh7GGsKNn9A1qt?=
 =?us-ascii?Q?30mQ/DB49fQ2ZEGg/FUu9rjcGa4rhx++CcgbNJGm9C1Wx44WDqlSw0woFBYD?=
 =?us-ascii?Q?jFravDyeSxZgPb0dH4eZXbBYZPCmmgXKOR67ofe6s/+Mqej0ttcN9xWpGe+D?=
 =?us-ascii?Q?niZWlYPfaCRfzoBAnb2ugo9LpwaCqbz9ejQOsS4UF3Y4bflNGRZHFavuZ8P9?=
 =?us-ascii?Q?I7uvKgPEIPgAW2rk0XD2P8O7dU06q82Shi6st2oYWYloa/T6LckGSSt/imUi?=
 =?us-ascii?Q?W6Yc4fbOo49pYf8DiTBh4rZQuB7MtAUrBbcFoWaYWvOpzGvJYOSYK69YopHy?=
 =?us-ascii?Q?zb+7yvM4QD5IQqoA81KGBSIL6gaIg8pcnbc9tpRiCGvtqXEYhHo5qAADIeAp?=
 =?us-ascii?Q?NKA6LCNM/qsXZs+Q4rQ4oxBAqGaBS85I3iFlvafDYBVGgOeShXrxkdnT9gQw?=
 =?us-ascii?Q?83hB/uDx64w7Bm+7IivHYYJj85eCMKrnxydXB2JqkC3aSyQqgoPZYZfX+6ua?=
 =?us-ascii?Q?PM9KlDtm3soH8njtORkJGj8cvwTeaCD6Ahvcd6tRxgZjz6kuPIVE2k7B+7VH?=
 =?us-ascii?Q?a0xXtlGHCEWgYEwcg2mcY7XxTl2/zmB4iVpcn2PrUgKSmPg6B3mffXqrGQe0?=
 =?us-ascii?Q?Lkyzvrqh5+br0tJcOjm2F6z5Cyn8DlPwo7gFmnNcJsskHMqQXb3plI4HnpTV?=
 =?us-ascii?Q?txULjHmckk2tnG37H1jKDQkGmb7OcUQgJDTafr4Ix9RYIlzh2Zx1KlCNLl/q?=
 =?us-ascii?Q?RXs4zrjm1CuPXXQXTTx/yHMAUF6QTDlkdhw5V4roYZ81x37S/1RfHQoxVTgl?=
 =?us-ascii?Q?q5+wlP/GpsofrO0amyvhx0bNfntFlc/PygnwDuKH0b8hj3DMTszqjpzCvuQO?=
 =?us-ascii?Q?v1+q2w54cLV3fq62YXiv5q+WMWMyYqg6/uGby0ZBiMNn82cQ7CbkJOeTW4fS?=
 =?us-ascii?Q?mkUpMq1SjkNyTzG8JhS+Xj1lU5Ech6L5czplrT7bgqFg74p1AhPTFSKVgqiM?=
 =?us-ascii?Q?ekBs6xe1h/ACNKH53H9X6uXvfmDwxRyLVpmtx0SZaVm5z2pVHBX5iW5lGKmw?=
 =?us-ascii?Q?CJKHHznzJSqQ2m3rtmM06gGs/5nhC6j8ALruKK1OYDdPEyRB6YAY09bTCzNk?=
 =?us-ascii?Q?O9vIA0GVVEynS4PpmjkkE9qQuRc5xfZhVOQhIfYSu+N+YguCQTsi1dJOQSKT?=
 =?us-ascii?Q?qt5bB7V6hJMO87p9n6yxbfrTpT7qGChc4C6/wbl9TFLpDvVXl5+aSf0IUa6F?=
 =?us-ascii?Q?z15eisgTBXFXNnuWSltZ+JEDIdelVbP+bnziV/D3s0j6VujBsYGQzH76X4ae?=
 =?us-ascii?Q?fWm5nAq+RHRBJvyFPa7nOtVe9Df8HXb7Q+7qc4hznOwrmyja+uHBXwEWVTqT?=
 =?us-ascii?Q?28y/DjzlW1EJVsNKcXjAIMU72nvA2Ky0cxYFQNOJG/+o2/+1XRtNtnQn72MQ?=
 =?us-ascii?Q?SaouUoRd1sUFd2gFksYIhnlr+cXV9mwI+LHOe9aUEOqpHDdc4RiV3Q1TTNWd?=
 =?us-ascii?Q?9AfInwrnhMhREOABwd5aun2opK0TEJ7WdcoNXNC/K4ykr/3abggogYzFPCpJ?=
 =?us-ascii?Q?aAGuIzpccyIcCR6ySwSYrhr+VXhOoPKgaHHqYteAOSd3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VsXYFZB7eUi6IgmGaNnOQ9dtHRNeztrVg8wea/bYbiFJhjazb6T/aaEpnH3u?=
 =?us-ascii?Q?jWOxOcnXc/YxQKUwrtn6vjbTLjKkpg3hIpqRLuB96/xPhS0CAVciUOEAQphJ?=
 =?us-ascii?Q?j0S0Y0osOg8VnF0Eq/yrAGRzqeAT98yUvR+n4TOYmptb6NjTxyjSxrKo1BcK?=
 =?us-ascii?Q?98VvaG2eatQ0KqGBHL/q4cpukoqoqHtkR3QY3+RnOqhOub25uNS6ej+7VGUn?=
 =?us-ascii?Q?vvz2O77UtNPD1NN70phwKqRH7zCI5Bu4XdibDXBcQW9OD8fiUBfW3tivarQK?=
 =?us-ascii?Q?YN8DgF5ENxo42uuTikQSJLHk05gW6q2V6SOmSciun9dHM2aWoDN4isgoAYgE?=
 =?us-ascii?Q?GL3G0Vm6Mx0TdGCYqGEXN7JrRagPfcVRLEURY6mROhz/RXfQnthN8kZWV3wR?=
 =?us-ascii?Q?ST801CrkcxdQ+bLemn6yKq3+7ELVt0Gnn5Htvz3l/mjOyTaVIWmVuO92GiRl?=
 =?us-ascii?Q?BMVBGm1Pn2u64wTgW2LwmhW3Q6TENgIO7D/f0Zb+ONa+BM1SnX4FuLVJBEUc?=
 =?us-ascii?Q?Vo/2mRlxKtGtfr0gkXSNTMapjsib5a6Q+6wy/oUpa1XJc8Rpw7t53zZjq4Xs?=
 =?us-ascii?Q?tYllCqEhgbHvsO8Cf0CZD1TPtcmlb3DDaRGuJ3Ugs5PmEn12nf2XeYXOKuRI?=
 =?us-ascii?Q?H/tID1lumcnD88RlLEOW9qpDa10rJD9d1w4SFVyX70DiZQFh72kjAXQ/P+iT?=
 =?us-ascii?Q?CSsT1GhZOFH2aKMeeFKj2uC1qajcnAH2xROtC7ffzjd9+m5KUgdkTy0jBsjc?=
 =?us-ascii?Q?k1Cf8FWCYEraNFa26LyBk5sx3qwXubqDNME1QxDj7oh93XlfTeR7pdjpIfze?=
 =?us-ascii?Q?GQa/c6xxLwHD7djpKkoGuhN2nAGBciwW/GGi8mugImeTKv/rP5SVg+7PURBY?=
 =?us-ascii?Q?0qqAeBF6Dj2YO0SEIupbjB6H8ZBpqdbjofJhbfkmHKICt0OFLH6q9jlY59iD?=
 =?us-ascii?Q?XVWoYz+hFNYrVvHMTh7lLKGajhaXAQ1uPHh6iM93jAGAEFH0TzYJlX0uuSHe?=
 =?us-ascii?Q?C1jekoNNVOwqbFVwulMhr2bMGS0AUKmiszzIgnBsG6aC0CPl49Es5D24MvNl?=
 =?us-ascii?Q?Phjw1DlBbbxhwM4eX8YK8UUnYhdVJjKGd5DzXNmoHuhevvWFsAPJYYE+SgTW?=
 =?us-ascii?Q?tAdYy2EgXN/HZO8ra8JwLXPixNyqk4WixWh0AahDXHSDdHZsqhWnAAg7GdNn?=
 =?us-ascii?Q?m/AC1/DJitbZYT8UgGlrWWCMxWoUSiY/TURH9DdxzVi961+AX9/1bjyfnJwl?=
 =?us-ascii?Q?EIkfV05xxNnq8E5BATEpyIP4n/Iw3iQMiGvfsAL5YKi7Q28gLh/F54TVZXWn?=
 =?us-ascii?Q?MS4gAhFIPpVwBzeJ8a9ThKZrmrrOOeljkpC59ZdsElU9bJ6VRaG8jbRqxSa1?=
 =?us-ascii?Q?6hcDO6Khusw3ELljVSoPKfv7YWxck+g+t2UVFBWZAWSm6HH2Z3SxS3gQKP86?=
 =?us-ascii?Q?R1+/cBGreXgnSvDCDotqrliJAj3k5uAZdLot5Fvy/qgSdpJC2EVw+ftzc1uI?=
 =?us-ascii?Q?7nOG7XcKSSr6xIuBdWO2WTsTDN1JyU3B7mZDePuUjLOrxA8YdGpqcWqBTo4l?=
 =?us-ascii?Q?zc7eievk5uuviwuNmsQr4Y0UPXFTC2GCK2CiVK/XE1qSotkqE/WFKQ7xrxrV?=
 =?us-ascii?Q?AwUKi0zpmqgcf1i+k2pn4F5SNqW8T5AAHzC3w4qy9UH9Q5+1yYZZ9RfxoPn/?=
 =?us-ascii?Q?Yoc24Vfe6RQcZKOcgoj84ls0X4WbzmQpVubOe75Cb8wLRQnhK867PenpwVcW?=
 =?us-ascii?Q?qDkF7UYIcw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dae8afb-1b84-4125-5a21-08de66b99241
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 02:27:14.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /c2/w+riWr2Ae5VtiqqBnMvE3Cs4Khra2JnVrVKlJfBnmQJjGZ4xW0Rb86c/v9olg4aGDvlY7OaS5YRzhh1/YC6mcUGPFKV6p3DGqasiCWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5891

> Subject: RE: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
> support
>=20
> On Sat, Feb 07 2026 at 03:50, Ryan Chen wrote:
> >> -----Original Message-----
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> Sent: Friday, February 6, 2026 7:34 PM
> >> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
> >> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor
> >> Dooley <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> >> Jeffery <andrew@codeconstruct.com.au>; Paul Walmsley
> >> <pjw@kernel.org>; Palmer Dabbelt <palmer@dabbelt.com>; Albert Ou
> >> <aou@eecs.berkeley.edu>; Alexandre Ghiti <alex@ghiti.fr>
> >> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> >> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> >> linux-riscv@lists.infradead.org; Ryan Chen <ryan_chen@aspeedtech.com>
> >> Subject: Re: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700
> >> INTC0/INTC1 support
>=20
> Please fix your email client to not copy all mail headers. If you can't f=
ix it,
> remove them manually and replace it with the usual:

Sorry, This is my mistake.=20
>=20
> On Fri, Feb 06 2026 at ...., Thomas Gleixner wrote:
> >> > +	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
> >>
> >> s/_irqsave// Interrupts are disabled when this is invoked.
> > Sorry, do you mean when this function been call.
> > Ther have desc->lock to do the raw_spin_lock_irqsave.
>=20
> The core always holds irq_desc::lock with interrupts disabled when it inv=
okes
> those irqchip callbacks. So trying to disable interrupts in them again is=
 a
> pointless exercise.
>=20
Thanks your gyudabce , understood.=20


