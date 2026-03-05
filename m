Return-Path: <linux-aspeed+bounces-3594-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C222EFCE5F
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Mar 2026 04:46:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRH6f5kxLz3c1J;
	Thu, 05 Mar 2026 15:46:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772685962;
	cv=pass; b=jdwUq4QF6L9vNqihDCcfJr+NWzusNd9bdKaghufLweE5l7NrcfxvywzBOIXbicnWTY+liZUieGhcSDcPvbGwNahhwjM/chgI38YQtyJ3LqftW8hNjn1ZUfi7UZg3orSRmodsVzm4kNfrRLOITyKLjRRihRB7X76fbcRh5eKV89wrn9t4NIr9WT2yfYmKSPvvo9MQJNxr8JXQJsbjKDm58EhmZHsh6rMlsXVPoqYXdlCR6OPKES5zN8mZgJZLGzkFAya4YeOx968k1Nqb1KXm6176cn0vsIlY6UZrGR/SE87QN5m5JVki1YDa3KERRXDSEzS1htjM1ZLlcZe6Zql0oA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772685962; c=relaxed/relaxed;
	bh=9xdaQdTlScqCNl5J94ZPpW0D7lEg9vlDkB0jY50nr5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LIxGtd+WSQxpwUxDSd0uq6RM8U1AVmi8+p5OH9xZ/9xtIB7rF3bXczfjy4yZIFhsIGE9wVZ7FCmQ6yC+Q0eia3EXIMiaew6rGg04xd2DunEBNl7bwjvfyO7bgPSyvk1+k9dHYTRagEMv/cAfVkQaURpoAxcHD6jL7ZFQKpNtbBzB27JZxN+B1kf8kP0xVjGSeLwuRKEWxqgPP870TsRACp6JlzE7j/1mmig8Pr3jgW3yAiwn744xwWx41BN4sPH/MGhi6hU1RQZWMmhk+CqRTp3o2WwoP7wzSntOZu0GwItQVB05Vwy4/yH758aLjcAmlKRbDWhtfPt7LdbAPzp8yg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Sw3rYgGG; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Sw3rYgGG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRH6b6NqRz3bhG
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Mar 2026 15:45:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMpRsMBp9OXpkw0XIzIRqY24xO5jvTdWJgnVx5JzuyOWSvsI/OSxVj4UYwULSzWj4hGG+vrrhwaFRneXzcNEm+iYANWgaqXyvZAAjfPE9rEXzDFwo7BTFVPG8PE0mXy4PkDHi9JVQLRdTZSASX6CqXzicq8HqQ1Vqh1mwxd9fuJCzdXLgvJQJSNXU0peZpHsAD+qHqMCfLQIf+FrzMTyRHXW5W9TR51397Ug9D/aFlFklJc4+jAJDUoupUh2LZfAvnlVPIaSqC6G+S/y8BKnB6wLkVLqe4aHefa6U7NJHeJa7fEWI4T3ozsqCByzuyYwkvy1U8OCOYsIOEpig+0IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xdaQdTlScqCNl5J94ZPpW0D7lEg9vlDkB0jY50nr5Q=;
 b=i5zx3eLQVkxgFpA581Kghv6SCmYa9wWYw+YnK1Nr2FIpUDLArkKsu36TkdC1RlV7FJn6lcdchc78MssAnpxlIXP1C3I/hsg9eD3IpTDW4TRaizyJJqKRiotjKqhXEGLIvh+4CYPCmadhfV6udEtsUBmFMiFTU6Ztc7d5ZUvXVxXArgZ6jyD2WQTsM3abS9tVHUQ03i0sboI82D8TSRHmihHh6wCYSABuBnBvMfzjTUAygNIRqtlcfl/X5Ky7QrcS8uvrRZ9Z/2XdROG5ahhKJ1NnN9DyI9TBjpu2BU1j6BiY0XBkRLhIdsYBrwmib5lVu9AOveq+XElf4bSZt00Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xdaQdTlScqCNl5J94ZPpW0D7lEg9vlDkB0jY50nr5Q=;
 b=Sw3rYgGGUvqs0K+R1b93pUKLVhzu7RKkuv8HO4YW98M/y4U8HFEbxynrAu73gd8Ty1yPI6isSRnwUV6GbK3LpG9qTvmJxomeBEfTORSFSa2Us/qr7Wqyx2gmzgsPeb82nsFuklsQiyH0Awet+0a1zyPYshxwHDebQ5qz1C3ijFjbEr73eryS58qtznsTGhZJ7gKcmjhLO2O8WpaWMCNQ5dl86c+kf0H6int/OBATwWxO7qdSq3ixOP/zUSHFh/Nx3Jz3GnCyDp/oA5rlP4s3Byiu6hAttwdgyYtEAYwn1YDDqzTEKqDuXXnRe38XuGf9teJLfNPsydwasIQeV2hvew==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 04:45:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 04:45:34 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcrFrnevl6+hCpUU2aPeSuExnKlA==
Date: Thu, 5 Mar 2026 04:45:34 +0000
Message-ID:
 <SEYPR06MB5134315F4EEE77ABEECF7AAD9D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
 <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
 <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8b1e64cd-b48c-43c4-a184-82a6297f273b@lunn.ch>
In-Reply-To: <8b1e64cd-b48c-43c4-a184-82a6297f273b@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB6081:EE_
x-ms-office365-filtering-correlation-id: 540babdd-6695-411b-895c-08de7a7209b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 UNOg4FlDTw610N3V1S+SAEKfzbrMz9BhIM7x5Ws09KXFMjm0zSaAu4eD0b0HcQbBDd1uTgCbe9/DwTylw7qopewfjEB8AJ5wUrkoZEeoS/Nq9pREiSB7zQe8M5kPLihvQ8ewQMhjmXjU35RACM41bSYkYgJlJ7RSK23sERVAxjnj3c7FuOvMfExe4MTPYNVBpKv3I0lGJSYP6sa7IF7jQt2PRU3KX/j2G9CU4ZOm2wUkwF+cGduvDuVx5MvL6oOZUDfDHBmkBpC4s7pd0RkngQoFnU/WWtBHVl4R7TeERQ+MCzDnuqhjuL3+qat786EU47TolVesbWu3UVTHrL0bQtgEIrmyx0zV5Q/yoBHo9KwSR7LNVxPMdze77zYbSwToSz8JRVyajsBfq7rZbJJr7IQbVKGuR9JAWr9brTiZyQciJiUPFblWtT+GNSX8YwA/7SjJnli23xKMoPM+zbwV/V5wYr8Mp5WhXjAgCtDhGGN/5iQ00ao3T5LloOaG8B0l/Uz8nhtN8hhYPUgHsuuZxCOwfHHBIe3LYsn/L/6dRlNrLs9XTm0c9eUxpWTDclaqe0R2R+T4E/oKW3+Lza/E9CGAsvTx+R1FpheixfaQz3sAPW6F4SpIGE3+8hDneAlTZoBAZAL5/UvuJPND7VvizjytjHWDLfurFQw3MtqYdICtZuOpnt/zyj89lAivWeMEeX8MZbm4Q4kLjTKqg3I8zgvwj2yJ7AlNnav8eq96rJLTizALAgbQUXRQUz2Gkql6pjcELGlt1Z9rbA5yBGenXHRmo47oN9TISkQ+xew/7iE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YqWl1SnrhYNRwSdYs9UE+utMx81Re1HwsK5antCcqdygyYfjspVep7APqbwO?=
 =?us-ascii?Q?pzBAEyI5kMmS9C8dPE1r+D1XCWM59212t8+ZaXd6jcYo5oDyuHuqW7A4TW5M?=
 =?us-ascii?Q?rrK5nJqBTg56fRArDOaFat/wofJziDkdexgMQ34nj3Y30CIUx0E6L38P0IE+?=
 =?us-ascii?Q?64CJexzqSahipCZ+Sr6XNpoIVvN7L8M1NtU+pG8wyKcxMJupgBEiRfUxnYk8?=
 =?us-ascii?Q?shQR3xlc7JoQk/YuBg9SVpz2Fx5GCSAvcjjFt4rVSfHCuodOisD5O+1huF1F?=
 =?us-ascii?Q?fkgehX54h/NxXVsZOyeAwgujc7h514BRZTGGFQ9vnvkEvqJD3LDT0Z/DxslA?=
 =?us-ascii?Q?iv/BPbjB/H6R+GO2U/PXY8FEvLCzqYZch3+uq5Qd8t6xNnJglMheK2MepZsH?=
 =?us-ascii?Q?mcKLhkRkl4eD7ucAifZapygKdL1WptjAOwCoD2XDzwGQLK58/XVxKDA+Yw62?=
 =?us-ascii?Q?AnQBO/V+5nfk0ONIs5iztPGgnEIo7bMt5Th7BDSUP9IEp088h+ulwA1jjw02?=
 =?us-ascii?Q?IhWDnihg7BUPRWBOLZz9RZutYdek5OSD2efknlgE8H5Gb9dU1hahrKVQnFbw?=
 =?us-ascii?Q?jVF+D09GitwNhPXl1gy+ZCXC5rwHiIuuK2lJ/xOxnSJnuR7k2+xYuvfqzK97?=
 =?us-ascii?Q?UnfmQ8kkaIty5rvEvQf/s3TOIquiX+mpVL1RHFHa82ptaFERpoti3XJoWFga?=
 =?us-ascii?Q?ETD2zVxxi6Q4sd3unUEQJ7iWYLrZ5rer7SnmAAYH9/PhWtngHnN2Comd0AC/?=
 =?us-ascii?Q?Rc14J4JW+Clyzt11iq3uKB1FMhVL+zM4jCnjOimzxkegNYoadKTrakXGJmFO?=
 =?us-ascii?Q?rK6LF+8Gjw5vbS4YwI2OZKxIU0EM2VapbAhXrtHkR7owO3FSu6WUn2DSu4hx?=
 =?us-ascii?Q?un/ZxPIPmQIiobFTLXiuG/nposdlzKy5bM8T1o7Gxr8zARbhPfdDTd+ZxWFT?=
 =?us-ascii?Q?M+R9CmcKhxVDq05lT3TXBnmB06BpRtF8XmSiKwYnxRgv5Zb+MS7Mlq1ejQ7D?=
 =?us-ascii?Q?bXqv5T5eCFzABxL/1ttgijK17MMddXliHow2bbIhJJNyxTS/7OPdGASwjWCi?=
 =?us-ascii?Q?S9ZeuJ7guMX6bjERx36slCPLpptjUZnP+EXrw4p4UBD3G8p4195a6wlnu6Y0?=
 =?us-ascii?Q?vbTII7Fr5czaP099SZeXnIV6QrqE6EuQ/szMBA7Rzxt6ejqVyVooIidnyGyk?=
 =?us-ascii?Q?biGzCOWllsPsWsIv+GkGcB5i6qvO1SVVdOFXGWb00ZNvMkD7eRtuoFWj/J9r?=
 =?us-ascii?Q?+7ECM9iwj/29YqHoOK6+evcIX7dx5Z9gs1r+yevCSH1vA0tsDd5whMn0L+lt?=
 =?us-ascii?Q?/9xjDdhltzFZ2PWYO68kz9DAmsP2LGP4mZwUj4CJtoo2rYU0PwK2VXcRfTUK?=
 =?us-ascii?Q?DxapmjWKaaSfWv+59C/pxPTZndpagVimuNxGWlN86nSByddDs+BeMZJz5W3L?=
 =?us-ascii?Q?ReZThra7e1ni+5m6eMexiHcOmruuV6WP1tATgJ75v/eck4wYBuoExdOS3K87?=
 =?us-ascii?Q?lFncwVN8jOf7zGPj10DOH6fQCiTh/8zZJ0tROIhGz2w5OkvvvqkJQWYURYro?=
 =?us-ascii?Q?FzHjTqx4zy8E79ncx9Zf/eefmgvIWqEBMxtHgFMgwroj5XzAlFj4RQTeHSM3?=
 =?us-ascii?Q?Z26bDZHRwbG8T6W7DHM/l8diGkdsNbgQaQpohPouhfgD3YBf+wt89ae7plmQ?=
 =?us-ascii?Q?p+f/Zb3YyF0AjO5wN8Bgze4lY3fCSYWrLO7bcW8Ddt8Nj78RhpT7uPbjmSW0?=
 =?us-ascii?Q?cf2o63gH1A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540babdd-6695-411b-895c-08de7a7209b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 04:45:34.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6OqBQwFIW4dx8S3GSQx4uBInNbcDee4IbOK+fbuosXJGkuTwDkJs7kyvrQRCs6U7gbE/XQjAwZAzewgEsuOnjlSGnhoRhTNrWYzw6MMnEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081

> > > > Therefore, we calculate the delay stage from the
> > > > rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel to
> > > > or bigger than 32, the delay stage will be mask 0x1f to get the cor=
rect
> setting.
> > >
> > > Please return -EINVAL. Asking for more than 7.75ns is clearly broken.
> >
> > ...
> > 	tx_delay_index =3D DIV_ROUND_CLOSEST(rgmii_tx_delay,
> rgmii_delay_unit);
> > 	if (tx_delay_index >=3D 32) {
> > 		dev_err(dev, "The %u ps of TX delay is out of range\n",
> > 			rgmii_tx_delay);
> > 		return -EINVAL;
> > 	}
> >
> > 	rx_delay_index =3D DIV_ROUND_CLOSEST(rgmii_rx_delay,
> rgmii_delay_unit);
> > 	if (rx_delay_index >=3D 32) {
> > 		dev_err(dev, "The %u ps of RX delay is out of range\n",
> > 			rgmii_rx_delay);
> > 		return -EINVAL;
> > 	}
> > ...
> >
> > These codes will calculate the ns delay to MAC delay index.
> > (rgmii_delay_unit is 250 ps on MAC2/3) If set tx delay to 8 ns on MAC2
> > or MAC3, it will get index is 32.
> > It is over the delay configuration range, here will return -EINVAL.
>=20
> So is the comment wrong? No masking is actually done?
>=20

Yes. I will update the comment in next version.
Thank you for reminding me.

Thanks,
Jacky


