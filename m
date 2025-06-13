Return-Path: <linux-aspeed+bounces-1417-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22507C71136
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 00:52:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJLSz57x7z2yMF;
	Fri, 13 Jun 2025 10:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749775923;
	cv=pass; b=VmbUYZAx/grhH98QITc87qE28iaZFZWluUHE4OzCFgVVVTub9IYa0fhRdTHPL+vmg7hhPCQ9pai/Nlct8pfND9UOSoRuycYGi9fadRRVPCMLc9pAehWmbhreVCkRyQmj3NOWGXS3JqHz1PxsSjTBXWlWDmhIbeO1Utu4NiJI8cIhOqj9EeIkzSrS4rJ6cw5UT7m/39hZiFDZajY8Y++sKD7KKlM5ewoH5GnJgDC+2y26MSURmVxtJ4KuDF6K2zGxwgQudqg0Ju0fsq4CbQ04J+yzcrusQKXS3VQhPbUwe+M78xn8mp848kE92fMWy4sDELWAk65N4MYz72dS4VQ2VQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749775923; c=relaxed/relaxed;
	bh=rF2gWYnCPO0N7heFWCaon+Sa4g2bRmlBhii9uvItDuI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WH/7jOjrLTkV9+x8LcsD7wKJOKXEgA8NAVPwZP55uQDqHxgQ+ExKh1CylFiA88d1I3kCtJHwpFalTEEr13cDhskqK4lKedwS92dPo1auDodgxeHSZTU6LdH6JPQiYYspOeeDb2vNZf34TR0ZdZO47Tm4Vz/QicbB1K226gCoGwZas0RajF7CiADPfb+ki7JgLXrEzR0QwNN8d7gSCZ2ALi9AYQq9HwieGbqYcA3JmJlz0Wmb3UmuxUN3QIZgBCCQARId9k39OW9zBWkqMzBCRaLfprH+eIARgSABeDHSEx7MgB1hqoljAFPzYueEM4ft4v2vBAn8bTPYjFjhLJaGLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com; spf=temperror (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJLSk4bcwz2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 10:51:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPPb3wa1IO+sOZpQF+mW6Ok3axMgDJTdCvXC7mDgwJ0CEJRZTewAEygy5aVLdooZEocdkVsklCVvBI10WiB3somhMLNKEsWA632m26vdX9t7OSedHAPmxtKBpTweeb+QAaHItfDF1zNuoFqmYZXH2gcILPDVIR+VrtnuXLxEymFOVLRQbulD5HZQIlGQrd21bSURGqjMMRtMw05vInIVxXBtFh3DkkdJSSQ2sBALohm79LI1WdzmB8JsCoLkLwsQke/nd3POyOnmw3ILdmezXjWyvluYS1IiReDLfSwxdPpBY+UvsmS1O/tf+OMIDP61ll+ExwG3eXxF8PGBetlemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF2gWYnCPO0N7heFWCaon+Sa4g2bRmlBhii9uvItDuI=;
 b=Qv4RTzlcRXIGNSe6SugUoyMSUOhEXt7OlOUAbhX5VG/Pi72Ugc9wS3VqqQupv0XO19X6KGaO45iclia3P+W3bWXgzjwY7TfI3oeHbTlzCB2aE0oaccE5NEi+5XqXHsAZ7kFFQuU1h/y4p24m5X3lXQ3PZw38LI1vHW0heHo/jMLK/Fs/bJeIUAo/Vb6sed531yAYkXPPqBn0sgHIEEh9qb89Kh8C4xLQeMHGW+zDvo0A3DdX5F5hjeiW1psnALZlSK/KhLMhJtQAfSLLOrMgOrmirE0Q09qIoznwobZj0j5riFPuGW5128f210A76TBVML92pQbsxeWbRLEuXOBPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF2gWYnCPO0N7heFWCaon+Sa4g2bRmlBhii9uvItDuI=;
 b=nhCO0/6n3mgczcHWb6LxBIhzJxw0G3fASFDLTq2nIOQtsV7WVrXCYcn6vTyha3YKoB5LiVVCM5R111+fejT3W8XhwmfbbrGsOKOMpQO8MpT/GW7+4lcG0lIKawGbrXjfWHaHp2t3qNUFiUaN+G+QuXXRAxpAatBOTxcFrKTjAcjAPQ0FiEpp+OLGDxgB+m8NKui/APpuiwFhYZezzaoVgW8z9FPySUlHKC/74NAUKN0H+61jVhLVZdpa2T0ZyrsuuatrX9vPnoCRZRSretOjIoIntsOTDqx5OtyA1WQf8psbP1KH69E4a1C0f3rNLmOejU7w+H7WypX9M2Gy/VWsvw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by JH0PR06MB6296.apcprd06.prod.outlook.com (2603:1096:990:c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 00:51:05 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 00:51:05 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Topic: [PATCH v3 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Index: AQHb2eeI4a5F3MN24Eu/ozXuvO4n07QAO/MAgAAJjEA=
Date: Fri, 13 Jun 2025 00:51:04 +0000
Message-ID:
 <TYZPR06MB6568BA93BCEEBEE3B9DE15EBF177A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
	 <20250610091026.49724-3-jammy_huang@aspeedtech.com>
 <13b88c1e404a9abe5cfae6673cb93e0b020e3524.camel@codeconstruct.com.au>
In-Reply-To:
 <13b88c1e404a9abe5cfae6673cb93e0b020e3524.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|JH0PR06MB6296:EE_
x-ms-office365-filtering-correlation-id: f04c6692-4038-45b6-60b6-08ddaa14606b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GsVCL3O88Yb7Xst653ZAx/dJXxD2+aJwsTg2dzNlEQ6WWg+qkSyPoh4fEk?=
 =?iso-8859-1?Q?MW8gFDaBuYuV25XoGIIPqvCSWiDZgdmcApXQAc5h6rWOs4pqKJd1JxrsZr?=
 =?iso-8859-1?Q?BgK+defI6ivEEdUgpjMTsmnwxtF9eQhh+G7Zt6llaxgU7V6Qg6QP+ssKJA?=
 =?iso-8859-1?Q?4GmppscbO4Xn2bErlQvIqP2G3MBQvlijASh/lyTxNz+goqShRtvPp+Y2qO?=
 =?iso-8859-1?Q?qV5GBmsO+ts/eMSokev/Y0D5PZiyfkkxL8Q8vVE9ECEM9d3wak8BTv+zHZ?=
 =?iso-8859-1?Q?1kCCrouS+kPCWEm66CCsMX4KvOx4FIyw684jCXhbMycaiNapS0FBFviHQy?=
 =?iso-8859-1?Q?ICis66HEDPJ5e2ScwlbAXG20SW8Vug17OxILM5YvHWodbdThW4VO0UgS3n?=
 =?iso-8859-1?Q?AwHIXZfNkFf5RKXC/iyz6XuxDisB2CfbUlMbvpd+cP2xk2bJqpbxT4DlDC?=
 =?iso-8859-1?Q?Uk8+jbhTva2BTsRGulbJXwGA1V0FNfDybc99pQE9ye7BAnAcWLrDZplpZS?=
 =?iso-8859-1?Q?omVwOHbEcYBqArdWKxiC6WrIGfehUlWtQVEjnVjOpSSpvrTibk1DznR5dE?=
 =?iso-8859-1?Q?PEO35MAaM5Wv5ex5PdfpqOVwkYsMCBBIXRjL1TDq7jJvxEh0ISNDCH1atK?=
 =?iso-8859-1?Q?7rFmoT+8UR+LLvv3O8XZx9Ds257cmKCi5P1TLFeVSzPtoNGIjQgykHlnYa?=
 =?iso-8859-1?Q?bfBtd0fwFRIuyT03jFEicA2SH5XA2I2/EdrybhXsJPpwylRhRAznBEjUsx?=
 =?iso-8859-1?Q?k3okvd+iCookNkbwg8fw2swMLrVC0OS20UtlFbXzRmUEmd1t2bwlQyAdXA?=
 =?iso-8859-1?Q?XIeUPPhXIasG8L1Ta1Cz4NRWwtGmodihdUb80ZwvKNwmXDFhDVYiPRd6Kd?=
 =?iso-8859-1?Q?CLn9v6NdAnJ9C7U+VMsuzgROfoxwFkUucy4KSyHwYAppLwhaeH2h8aNZPr?=
 =?iso-8859-1?Q?kz+kgsejJJKVLzoXd8JX/AtfUJ+L1PPPQpYzxLimmP8bvyZgQNngpFd3b9?=
 =?iso-8859-1?Q?vQpz5jvrEfAliRISj/O4VDXChE6uwLhiQOu87FVlzHbzZrgjUw9pHAhFRq?=
 =?iso-8859-1?Q?WxNCpD1OQ7Ew6hjjrzYK/oeJulq8SqMUvmQbF6NExXaYRXHrsxQ94krZ53?=
 =?iso-8859-1?Q?OVRX72eboLjyGyPidLlkM+PkCh3NptOYduLRRdAEKjINrkFv0Yd6VY/ZSb?=
 =?iso-8859-1?Q?RhB4SIoP+LHPkLmUlV0u2iJ784GB3YzUJb4/f1pAWmAWZNud3MEJhDhJpr?=
 =?iso-8859-1?Q?mC+zDlJGMLrpnJCbp4xlAuug/9CQdr4TYDeC4RR36t/q85RoIVVQZA+I+N?=
 =?iso-8859-1?Q?CjKsy+zALmcVvXO3IedzaEuOnNfvkVTfMfDwU8AAsc1ZP36EE83l6/pied?=
 =?iso-8859-1?Q?DflSBKijLeyGqnK+H2YsmwHdqHEvwkDhzA3sWMW9SIvUiHnHa2LSn7A3bq?=
 =?iso-8859-1?Q?oRC0ZGplG0R4dga+h4NWZvt84rIARBUANvMkgHivZjoPsSlmLhiTju4/Kr?=
 =?iso-8859-1?Q?UY6gng09Wb1TLphbyyOuwSvEk+IR2bBCbMs0DawoTYvgbdGu/z8zmfTdjn?=
 =?iso-8859-1?Q?8Fxi3BY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FHqIIrfcn+I8YvEUaJXolRVHuwNUVcz1i+eU14vn5UQPfYDA2mluO4FSE0?=
 =?iso-8859-1?Q?tmUJAYzVcFKW4Znuj46EatD5MHczydE91LqSFm6bKGQXfBmphrLA/LWgKH?=
 =?iso-8859-1?Q?dyj36nHWltzTlIBvoTOMj/chMWp4zY8HRo/IadZg4B1sD5LBxk51+AfsQP?=
 =?iso-8859-1?Q?P7Z++QhgerBe+kF/3rYS4XMJObyRKP6CH79f1l1FTdhlIJvlwTBtJMOs/X?=
 =?iso-8859-1?Q?xsASuqQkDyrhTyUkzFmii+lE1fPImTZaexyONLk8hxS8avF66a49EBcCSt?=
 =?iso-8859-1?Q?o8157X3Hr1GxBTvqoIsUseJmxnhKZndGVWKCd4AR68aMyyehKl+DU1oFgQ?=
 =?iso-8859-1?Q?/deF4kKGeogzAe/4Tn3uD+nL8cn9OtC2tImq6agvB7cINs+gRkpzdQVTgW?=
 =?iso-8859-1?Q?/cZgPuHmb66RQkc6FhUoA3377LR9kvfN5bLWahsTtbajYnbhmMZwgqbtmY?=
 =?iso-8859-1?Q?+YGPFj4YzhyEx4+rWcCmtBcQ3FDzwp3i/2gRvHxZH7C6b9av4L27Kz6Dcq?=
 =?iso-8859-1?Q?fKgQxQ3YOA4l3PoondrEnJYdvsVitfcy34nvJfEVA5c/Yeo8CW2Kfb9pfE?=
 =?iso-8859-1?Q?+3Am/Wg4882t1J8cF3OyhFTznixyN22BIxQYo/KQuPv29r3CPLR1XzAiAx?=
 =?iso-8859-1?Q?FzLq3hj2FY90m8M5fPMfY8nvQBBBUnUAs26X3BUChTg9y9pNd45LTU4TwQ?=
 =?iso-8859-1?Q?hEfhxoKlZzYyJ8BuTIFTYXXyJiPzkWQ1LLYAJD8N+OyBLLsn1PmAPacVtJ?=
 =?iso-8859-1?Q?hI9Osvn+WBYOpPfrMhRflmUv+89qbuSmrNBEeKKddD2NEvIWZ56kfX6SXz?=
 =?iso-8859-1?Q?m5EWneCUvN5wk49dPzYumYYL2XcjaCp0VXlRnFYmT3Qik85/8DdbgYVEla?=
 =?iso-8859-1?Q?xgvcgR8hn0NYSQVItB2nbzxOovvkOPhzOHrGWsIx5bGW8V6KzfUl1fJY8u?=
 =?iso-8859-1?Q?Eq8c5SWCbZGEFQU4a3ndHwvn3h9u291tN+YzIwvM79vNKYtyXwqJnvlaCA?=
 =?iso-8859-1?Q?ntqj1iiGJqVCHNvpCPUaiztV0iRpiVvkFbNfmQOkfS1mlnWFLhwLvXDLvg?=
 =?iso-8859-1?Q?chneezf+vsppG1Az3/h91SOKD+rU/2OnCnIupucShk+pujSk2eXqpdrtd9?=
 =?iso-8859-1?Q?M/S6SoyV4A+PG7zIDGBMcxZVbSGlC0VmDT7dfjyL0zIFmw3VJvODcq0UJ7?=
 =?iso-8859-1?Q?spAIF2LhdLX8dl+RnUzsRsB0M7HDHHNsh7o4D26Sf7QjpS6DrS0wz+zE3D?=
 =?iso-8859-1?Q?YbT+JkVE/+Rox8IMwv7nQYyvNfcm7sc3hLpvBz7sr6FkzbgynykFmg08O6?=
 =?iso-8859-1?Q?0Lauk5DoUIDd3MDrLVDH1WOcCvByjCDRZnbqOeQN2YcORtajvAuumwgtzU?=
 =?iso-8859-1?Q?VfN8iL0iK+wpgraTGhvLo1CAHqD7qaDhXgu3rfVd4ajOplVi2oHeTfnAbl?=
 =?iso-8859-1?Q?ZB/IPepmJiJfCaRjMCx1qM6NqFCSuRChgphRzMnSRobOsdYXvYG/ulpCs4?=
 =?iso-8859-1?Q?SMpQnV2Dc6J+y4ubBy7quoSR+APphKE6RJqyah0EpAeY3JdWLpQbilrrDh?=
 =?iso-8859-1?Q?sNB0elmPJ3ogi7RdkHbg49/oe677UY8Ocg80LksiPJlOcykfVazavlMWlJ?=
 =?iso-8859-1?Q?3vTLXYCYamNW6qBKD6JD/EKgG8cjCn0R9RUxpGJ2K6FEBsMbFRQNq6Dw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f04c6692-4038-45b6-60b6-08ddaa14606b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 00:51:04.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/5WKWI/VoHdQ4Jcui9Net82Ee6FuwthUV6K9+Q9REXZA+qp61nt4M99o9GcYxJKFzinoqQEr7RATkQRojsEHsLAGU8D+aFpyMAAtTE+dHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6296

Hello Andrew,

You can find it in chapter of ast2700 datasheet below.
  III Function Registers -> 12 Inter Processors Communication (IPC)

Regards,
Jammy Huang

>=20
> Hi Jammy,
>=20
> As far as I can tell this controller isn't documented in the datasheet fo=
r the
> AST2700. Can you point me to the right place? Or, can we get the
> documentation updated?
>=20
> On Tue, 2025-06-10 at 17:10 +0800, Jammy Huang wrote:
> > > Add mailbox controller driver for AST27XX SoCs, which provides
> > > independent tx/rx mailbox between different processors. There are 4
> > > channels for each tx/rx mailbox and each channel has an 32-byte FIFO.
> > >
> > > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > > ---
> > > =A0drivers/mailbox/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 ++
> > > =A0drivers/mailbox/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +
> > > =A0drivers/mailbox/ast2700-mailbox.c | 226
> > > ++++++++++++++++++++++++++++++
> > > =A03 files changed, 236 insertions(+)
> > > =A0create mode 100644 drivers/mailbox/ast2700-mailbox.c
> > >
> > > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
> > > 68eeed660a4a..1c38cd570091 100644
> > > --- a/drivers/mailbox/Kconfig
> > > +++ b/drivers/mailbox/Kconfig
> > > @@ -340,4 +340,12 @@ config THEAD_TH1520_MBOX
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel is running, and E902 core used for=
 power
> management
> > > among other
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 things.
> > >
> > > +config AST2700_MBOX
> > > +=A0=A0=A0=A0=A0=A0=A0tristate "ASPEED AST2700 IPC driver"
> > > +=A0=A0=A0=A0=A0=A0=A0depends on ARCH_ASPEED || COMPILE_TEST
> > > +=A0=A0=A0=A0=A0=A0=A0help
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 Mailbox driver implementation for ASPEED AS=
T27XX SoCs.
> > > +This driver
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 can be used to send message between differe=
nt processors
> in SoC.
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 The driver provides mailbox support for sen=
ding interrupts
> > > +to the
> > > +=A0=A0=A0=A0=A0=A0=A0=A0 clients. Say Y here if you want to build th=
is driver.
> > > =A0endif
> > > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> > > index 13a3448b3271..9a9add9a7548 100644
> > > --- a/drivers/mailbox/Makefile
> > > +++ b/drivers/mailbox/Makefile
> > > @@ -72,3 +72,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)=A0+=3D
> qcom-cpucp-mbox.o
> > > =A0obj-$(CONFIG_QCOM_IPCC)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0+=3D qcom-ipcc.o
> > >
> > > =A0obj-$(CONFIG_THEAD_TH1520_MBOX)=A0=A0=A0=A0=A0=A0=A0=A0+=3D mailbo=
x-th1520.o
> > > +
> > > +obj-$(CONFIG_AST2700_MBOX)=A0=A0=A0=A0=A0+=3D ast2700-mailbox.o
> > > diff --git a/drivers/mailbox/ast2700-mailbox.c
> > > b/drivers/mailbox/ast2700-mailbox.c
> > > new file mode 100644
> > > index 000000000000..0ee10bd3a6e1
> > > --- /dev/null
> > > +++ b/drivers/mailbox/ast2700-mailbox.c
> > > @@ -0,0 +1,226 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright Aspeed Technology Inc. (C) 2025. All rights reserved
> > > +*/
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mailbox_controller.h> #include <linux/module.h>
> > > +#include <linux/of.h> #include <linux/platform_device.h> #include
> > > +<linux/slab.h>
> > > +
> > > +/* Each bit in the register represents an IPC ID */ #define
> > > +IPCR_TX_TRIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00 #define
> IPCR_TX_ENABLE=A0=A0=A0=A0=A0=A0=A0=A0=A00x04
> > > +#define IPCR_RX_ENABLE=A0=A0=A0=A0=A0=A0=A0=A0=A00x104 #define
> IPCR_TX_STATUS
> > > +0x08 #define IPCR_RX_STATUS=A0=A0=A0=A0=A0=A0=A0=A0=A00x108
> #define=A0 RX_IRQ(n)
> > > +BIT(0 + 1 * (n)) #define=A0 RX_IRQ_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A00xf #define
> > > +IPCR_TX_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x10 #define
> IPCR_RX_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x110
> > > +
> > > +struct ast2700_mbox_data {
> > > +=A0=A0=A0=A0=A0=A0=A0u8 num_chans;
> > > +=A0=A0=A0=A0=A0=A0=A0u8 msg_size;
> > > +};
> > > +
> > > +struct ast2700_mbox {
> > > +=A0=A0=A0=A0=A0=A0=A0struct mbox_controller mbox;
> > > +=A0=A0=A0=A0=A0=A0=A0const struct ast2700_mbox_data *drv_data;
> > > +=A0=A0=A0=A0=A0=A0=A0void __iomem *regs;
> > > +=A0=A0=A0=A0=A0=A0=A0u32 *rx_buff;
> > > +};
> > > +
> > > +static inline int ch_num(struct mbox_chan *chan) {
> > > +=A0=A0=A0=A0=A0=A0=A0return chan - chan->mbox->chans; }
> > > +
> > > +static inline int ast2700_mbox_tx_done(struct ast2700_mbox *mb, int
> > > +idx) {
> > > +=A0=A0=A0=A0=A0=A0=A0return !(readl(mb->regs + IPCR_TX_STATUS) & BIT=
(idx)); }
> > > +
> > > +static irqreturn_t ast2700_mbox_irq(int irq, void *p) {
> > > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D p;
> > > +=A0=A0=A0=A0=A0=A0=A0void __iomem *data_reg;
> > > +=A0=A0=A0=A0=A0=A0=A0int num_words;
> > > +=A0=A0=A0=A0=A0=A0=A0u32 *word_data;
> > > +=A0=A0=A0=A0=A0=A0=A0u32 status;
> > > +=A0=A0=A0=A0=A0=A0=A0int n;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0/* Only examine channels that are currently ena=
bled. */
> > > +=A0=A0=A0=A0=A0=A0=A0status =3D readl(mb->regs + IPCR_RX_ENABLE) &
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 readl(mb->regs + IPCR_=
RX_STATUS);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (!(status & RX_IRQ_MASK))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return IRQ_NONE;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0for (n =3D 0; n < mb->mbox.num_chans; ++n) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mbox_chan *chan =
=3D &mb->mbox.chans[n];
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(status & RX_IRQ(n=
)))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0continue;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (data_reg =3D mb->r=
egs + IPCR_RX_DATA +
> > > +mb->drv_data->msg_size * n,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 word_data =
=3D chan->con_priv,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words =
=3D (mb->drv_data->msg_size /
> > > +sizeof(u32));
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words;=
 num_words--, data_reg +=3D
> > > +sizeof(u32), word_data++)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0*word_data =3D readl(data_reg);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mbox_chan_received_data=
(chan, chan->con_priv);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* The IRQ can be clear=
ed only once the FIFO is
> > > +empty. */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0writel(RX_IRQ(n), mb->r=
egs + IPCR_RX_STATUS);
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int ast2700_mbox_send_data(struct mbox_chan *chan, void
> > > +*data) {
> > > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > > +=A0=A0=A0=A0=A0=A0=A0void __iomem *data_reg;
> > > +=A0=A0=A0=A0=A0=A0=A0u32 *word_data;
> > > +=A0=A0=A0=A0=A0=A0=A0int num_words;
> > > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (!(readl(mb->regs + IPCR_TX_ENABLE) & BIT(id=
x))) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_warn(mb->mbox.dev, =
"%s: Ch-%d not enabled
> > > +yet\n", __func__, idx);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (!(ast2700_mbox_tx_done(mb, idx))) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_warn(mb->mbox.dev, =
"%s: Ch-%d last data has
> not
> > > +finished\n", __func__, idx);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0for (data_reg =3D mb->regs + IPCR_TX_DATA +
> > > +mb->drv_data->msg_size * idx,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words =3D (mb->drv_data->msg_s=
ize / sizeof(u32)),
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 word_data =3D (u32 *)data;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words; num_words--, data_reg +=
=3D sizeof(u32),
> > > +word_data++)
>=20
> The readability of this is not great. Can you try to improve it? At least=
 put each
> header statement on its own line (at the moment the condition statement i=
s on
> the same line as the increment statement).
>=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0writel(*word_data, data=
_reg);
>=20
> I'm not super familiar with the mailbox subsystem, but I feel some
> commentary on the data size and alignment assumptions would be helpful,
> given the APIs are all `void *` without a length parameter.
>=20
> Should you define a type for clients to submit?
>=20
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0writel(BIT(idx), mb->regs + IPCR_TX_TRIG);
> > > +=A0=A0=A0=A0=A0=A0=A0dev_dbg(mb->mbox.dev, "%s: Ch-%d sent\n", __fun=
c__, idx);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static int ast2700_mbox_startup(struct mbox_chan *chan) {
> > > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > > +=A0=A0=A0=A0=A0=A0=A0void __iomem *reg =3D mb->regs + IPCR_RX_ENABLE=
;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0writel_relaxed(readl_relaxed(reg) | BIT(idx), r=
eg);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > > +}
> > > +
> > > +static void ast2700_mbox_shutdown(struct mbox_chan *chan) {
> > > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > > +=A0=A0=A0=A0=A0=A0=A0void __iomem *reg =3D mb->regs + IPCR_RX_ENABLE=
;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0writel_relaxed(readl_relaxed(reg) & ~BIT(idx), =
reg);
>=20
> Why are we using relaxed operations for startup and shutdown? If this is =
valid
> a comment would be helpful.
>=20
> > > +}
> > > +
> > > +static bool ast2700_mbox_last_tx_done(struct mbox_chan *chan) {
> > > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0return ast2700_mbox_tx_done(mb, idx) ? true : f=
alse; }
> > > +
> > > +static const struct mbox_chan_ops ast2700_mbox_chan_ops =3D {
> > > +=A0=A0=A0=A0=A0=A0=A0.send_data=A0=A0=A0=A0=A0=A0=3D ast2700_mbox_se=
nd_data,
> > > +=A0=A0=A0=A0=A0=A0=A0.startup=A0=A0=A0=A0=A0=A0=A0=A0=3D ast2700_mbo=
x_startup,
> > > +=A0=A0=A0=A0=A0=A0=A0.shutdown=A0=A0=A0=A0=A0=A0=A0=3D ast2700_mbox_=
shutdown,
> > > +=A0=A0=A0=A0=A0=A0=A0.last_tx_done=A0=A0=A0=3D ast2700_mbox_last_tx_=
done, };
> > > +
> > > +static int ast2700_mbox_probe(struct platform_device *pdev) {
> > > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb;
> > > +=A0=A0=A0=A0=A0=A0=A0const struct ast2700_mbox_data *drv_data;
> > > +=A0=A0=A0=A0=A0=A0=A0struct device *dev =3D &pdev->dev;
> > > +=A0=A0=A0=A0=A0=A0=A0int irq, ret;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0if (!pdev->dev.of_node)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0drv_data =3D (const struct ast2700_mbox_data
> > > +*)device_get_match_data(&pdev->dev);
>=20
> There's no need for the cast here, device_get_match_data() returns `const=
 void
> *`.
>=20
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0mb =3D devm_kzalloc(dev, sizeof(*mb), GFP_KERNE=
L);
> > > +=A0=A0=A0=A0=A0=A0=A0if (!mb)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.chans =3D devm_kcalloc(&pdev->dev,
> > > +drv_data->num_chans,
> > >
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(*mb->mbox.c
> hans),
> > > +GFP_KERNEL);
> > > +=A0=A0=A0=A0=A0=A0=A0if (!mb->mbox.chans)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0for (int i =3D 0; i < drv_data->num_chans; i++)=
 {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mb->mbox.chans[i].con_p=
riv =3D devm_kcalloc(dev,
> > > +drv_data->msg_size,
> > >
> +
>=20
> > > +sizeof(u8), GFP_KERNEL);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!mb->mbox.chans[i].=
con_priv)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return -ENOMEM;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0platform_set_drvdata(pdev, mb);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0mb->regs =3D devm_platform_ioremap_resource(pde=
v, 0);
> > > +=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(mb->regs))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PTR_ERR(mb->regs=
);
>=20
> Just checking the controller doesn't require any clock or reset configura=
tion
> before we access it?
>=20
> Andrew

