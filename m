Return-Path: <linux-aspeed+bounces-5206-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E9ECC6B38
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:34:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X933q9Dz2yps;
	Fri, 16 Oct 2026 15:32:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791896994;
	cv=pass; b=Up3nRNTGl0mLsoK3o0ou7q81NxT/bx6zT3aA9A5bzL+6ADnRMuQaBvwVsxdMVPXRpBTb9U8MGak0msFHCq8JT+mXu7aSCcWz2r8kaQl9OKlbN5zuDTT55Zb5AeApaY90rOSF5FHdr5utmPg2o5zYp98zSDeKH0iOK9RH5i4foNRNcmnaIt56LIWzVDrVL0c2AcoHzbaSposgIeILY0SURVceV/CoTCWvLAZSWYxxj1ixtYWJvycFUF4/nGBuDRSTkIEl4GxTpnp2Bn6U8cUeR+Oist5mEekkxVrymYGGXXJ11U/KCcBxUS7DEbaaLgAIWD93ZqM6f8XzFquzU8tyzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791896994; c=relaxed/relaxed;
	bh=l3/iIZKQhJUZsfcIVouGWdsMj6/LIwjRNevWwRsSdNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U66sucW/s1b8leIbNDg1rV3EJIW3jmwtquhVB4CaZGWhSB0YepCiOuNok+IaxNvg6bvUDaZXttzF9qG0yT5Bl0YFFs2B8aqPamvl6d6F0DbpGUSGC2z7+YjDxQhbTfFpLAZGfk8ynkJX8O2XhQ+stEVV32ubTukkIX2qpmgjlo7F+xcJRULy7N63niTXglmBFjxsWqBo7zTxe+SGsf+7u/35rwenq2ha8rs7OUc+rkL03uqVwwlCnkXu3FA9vOj64anqep5vrKCE+iRW7F9qIf53jR7gHtKyk8urFMphU1D5jCxjyvOfhNtFeqDSC6Ejk+QWkxMhWEWJIulTkmMvRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=phil.gs; dkim=pass (1024-bit key; unprotected) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NETORGFT5377951-onmicrosoft-com header.b=baihjZiD; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=phil@phil.gs; receiver=lists.ozlabs.org) smtp.mailfrom=phil.gs
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NETORGFT5377951-onmicrosoft-com header.b=baihjZiD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=phil.gs (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=phil@phil.gs; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3vnW5s4pz30VV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 00:09:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPWx12dlUCDTgrrmZFPRKStJ00d8z6ViqQxeHLqcClv5p1TzBHzETRwx/tsvUqR6rjpp0w3er4rVynd9jiT1oH/GtAPzC/ZbHQgkZmYfITjvKvcAFjxeGSUx2HQFKAhxdjkIGxNsLg2jhfjmrM5/6iJoZFxxrSa2ZpxpN9XGEfzaPMOznBk2sn798mSJMow/DYOthDDGLKgrT9A9WJEg6kQQ8pJwqBJX3RvjjLihB/wsYXUxPtiqI7ldwurkc+KEhZrubvWHB8HJzFZ6br7wt4wuFHxW7t+dA5vs/ZoL2s1ardw1BkgsYHJjoytaO1Q7SbrxcgY6tYuGpYJ7AuQkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3/iIZKQhJUZsfcIVouGWdsMj6/LIwjRNevWwRsSdNI=;
 b=x5zSotoMSNYj9LgTIh70520CzX+KsSPYPst2FKPJjqs7ePaHPmOlqWelLrkwYuGe7rg3D//S3HRKGO/zyKEgxpxiquwh0oS+DPoV4KS45c8nVNQsdUkYLjPLrtmhX7ebWskt/1IYnPx8KOF2Aib+dW+n4CDMSfkqXsCVrE/1PJJRqzin5qW95umTKBiETnZwt0qYyDtt5MZ0TotW3Q803woMHX+0NQDLV5BVaDBB/FlmwL9OtVSCwMDJm4tDZYQ6hxaS4ka61vk6sPD6aqNdudab/37EfZUjH3oHeTcR3ZLht1TWDyn6nSagjGec4oHTQ7lx8Uc9HPlHCKhUZ56i5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3/iIZKQhJUZsfcIVouGWdsMj6/LIwjRNevWwRsSdNI=;
 b=baihjZiDWydbUzKa7y+5xSupRt0CaeRICakaotk+wde+2hMdWVcuZMFAYtMuYTjd+8GagFai6QBUGdQT2XlTT599vXf1CJLGVwPsDOxi01LKCu3K13/ghLKVksINtJfHfasWS1UXqW0d6T8tD/+KleaNAnh/15RIc3C5lcXMTTs=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by IA0PR04MB8788.namprd04.prod.outlook.com (2603:10b6:208:490::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:09:21 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:09:21 +0000
From: Phil Rosenthal <phil@phil.gs>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: "git@gregoirelayet.com" <git@gregoirelayet.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Tan Siewert <tan.siewert@9elements.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "jacky_chou@aspeedtech.com"
	<jacky_chou@aspeedtech.com>, "ninad@linux.ibm.com" <ninad@linux.ibm.com>,
	"anirudhsriniv@gmail.com" <anirudhsriniv@gmail.com>, "andy@kernel.org"
	<andy@kernel.org>
Subject: Re: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device
 driver
Thread-Topic: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device
 driver
Thread-Index: AQHdWr+RV/FhYOPImkyusUIlzmNZa7b7AOGAgABxsQA=
Date: Tue, 13 Oct 2026 13:09:20 +0000
Message-ID: <6712FB36-31D0-4A38-AFFD-0C992E406CEC@phil.gs>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
 <C5A01ECE-9A61-4BCA-88C6-83A1673AA69C@phil.gs>
 <as3OF7O5hnImaAWO@ashevche-desk.local>
In-Reply-To: <as3OF7O5hnImaAWO@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|IA0PR04MB8788:EE_
x-ms-office365-filtering-correlation-id: f0374847-d510-4d27-d171-08df292b320d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|19092799006|7416014|376014|366016|10067099003|7055299009|3023799007|261009223027099003|38070700021|5023799004|4143699003|6133799003|18002099003|56012099006|22082099003;
x-microsoft-antispam-message-info:
 ojkqIzNt+tZeajfZNU2msjDDAKEGKAqWTQJS07xwARabqL0inkQrjmbmiGGRePWKKIdKlKe2uR1bIuumm7HDk5r8OigOqZ/oWoyOoL5wskpzStdhV2Fja/3FkSkBQWpEx/BAacEmaVBKiuKLGBf+UGHcJOxwhjvssWqwNEOV/X0/jqOhKujI/me+RtMOtcz/WNXJd+CYTBSodr/Pyj2b8iy696jvzzZVBWwRDpCeO6n6cBLIvVqi4tzViEdotST/nw6tt0zGMfjXN0dK+NZkdKqzKIpiqWajPJVsJ57vszpNcx2dNDHvWsam6GQslaLXAz8iVlZPa7ftlEDXbT1qPRaCfq6rbWmyHV4ce1PKk8bMvqaLo+iZh2hXw7kQ99K+ueL+pvBiLDdS5iNNT5NUVLVtI2M7AEvIq/8Qzsdp/pIFiXRFC5NVLqOB0pn/iaSKbDK32ACjdMzzCxyqyURRaD+qu7DUEKOFXoiGOkl6dsIWP4nwHQFA/AxLfq8W/I5EYmYWUMn/r1JQwt4YMSCZfffq/xA9Jv7wDytPVm/CkikfRZkcdrsGXDevTLIWzI3jMvRpqG+tfmb6HQgMTFJ91t7Wv5VGWA5B6fx65jJvlxLG/VVrna6TN9YRcUFSoDKu3sOkOcpeaW48knm/NFde+fbwHN73escxL1yWhT7HsdCSwoAD87JCBf/fvaVclh0T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(7416014)(376014)(366016)(10067099003)(7055299009)(3023799007)(261009223027099003)(38070700021)(5023799004)(4143699003)(6133799003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V9h3ZbDc5yaQbLTHzihP9T8C0EMHcKSzkajdSWcl69KZMszM8uVvBzCNFnXq?=
 =?us-ascii?Q?Qx1ThwyjyRN+/3EeA9ocy6MP5JA5nGxHdUijKdalNFIMdHHhObWNIO8vRclc?=
 =?us-ascii?Q?m8M9jdMacG9w3EdW8MxeNE3LGX93bF2wN3RZY2lzl+CxVLaZ2Oy18nCdw2vW?=
 =?us-ascii?Q?RLXrtTIGszHY7xhGE6t27onnupuv3pqWeLPJYj51ioVfgQRfDLT19kNgTfj3?=
 =?us-ascii?Q?jFg38zMx9hdWbBs7eGpDcIg67FjCCnLIhNWknW5XGqGX+LmtRuMTCRPjGbCH?=
 =?us-ascii?Q?9wXmbgIFcXCjvbbBQixYmY/99GB+ofM81JTkv4XoAtCCo/SeRTO9hPU2ZeEN?=
 =?us-ascii?Q?vXKVKIyrLE45JwlgSTAQ28WlN73OazzhgWR2Lw5RZ7SdLnYzgdg2VpR7ozot?=
 =?us-ascii?Q?gmQThGuhOfmRdFdnFLTZcCmcFcyc3tFr6C7DHVjkxSWcVpZg88KK6S2yFZT6?=
 =?us-ascii?Q?3iECbYp8b7Wl6omcqCrc/Xav2eIfOZ1aB6Oda2fONLv0MUmm0XCVIycoF8h/?=
 =?us-ascii?Q?BnGxwhey3l/xmtUUYbSovAvQ3oJEXWk6U1b5XRk/7WHEVCTqvkXrov+kUwvB?=
 =?us-ascii?Q?QF+hPLBRexU/NT3/4RTRNX61Aabs8OjF1oTIvyDYNYa+8AwjjT2o+mXZPuhA?=
 =?us-ascii?Q?6M8BVFHfhvksISSSCamQx1OUVNXaUUa8zBkSvkFTp18AZ5COQ6RMB9AuyE28?=
 =?us-ascii?Q?db9eNun84UBwEC6L9c+dKVVI0RueJ/jRIhr6W9KKI+tPWkbzBuIR0EgWz4v5?=
 =?us-ascii?Q?ZoJnCzgq16u0sL8KMvibx5yX7w91mnLypEgZeeeEN8qS73ik2caSye/6UEzh?=
 =?us-ascii?Q?t66dBIltIEc0rq40cv3aOZZejrKrXaWGCb85LODp7LJpgk3OPbZV5rkVcFJ5?=
 =?us-ascii?Q?vp9TZEOB0w7i5ewgwSE9f88ZAKwHBiMXPv1E86ra/cdCWG3Qd8BA7HQrXQu3?=
 =?us-ascii?Q?jzPevYpXw+qnmN6R0zplRdxg+DyFIzcFu73GGkvSCsVMqKZTUX9viR2BhDnZ?=
 =?us-ascii?Q?C+hR2EnKHYltbd6yCByGd3c3mrOn3aBYKKx7WpUDEdnwTb42nQN2YBu0Z9xn?=
 =?us-ascii?Q?OZgdK/svr7gMXWpv60u+4JIivEGln4MOrJ3ZVMzhF5Hff5MfNBINrfk8k6V/?=
 =?us-ascii?Q?McaJbZNT5ahK/DeL1HKwNj0QWMJO1g3T5oiRCZo5jRxNUC/y+JxKx6Nwse5D?=
 =?us-ascii?Q?EAA6/3knGzDVS8a3S/+Pg+EBh81rLKXwcBzxP6V6W4EO0dECK9MtSDo4w1nh?=
 =?us-ascii?Q?QZb5KJk7u5gmcirojT4wjZ0aSbDEK5GHUBBU2ZSlcxPCtIZmdRF1H05rc4CC?=
 =?us-ascii?Q?jn4w010kmN+M9SaRVaLnJsldDXzObHGWWRLSOB7/JIii5fGxEMhEVlz4qtMp?=
 =?us-ascii?Q?ncE3pEQj2HdyCf25YVgvPLtrTLsYHnkjXSxqaggTAHywPv0eaBC/6aOWdgtB?=
 =?us-ascii?Q?aR5Ak1sqmUn5aTeDvJms/XeiUUxkvNmiWM44cl335alLiL81P/59kr+mgzuv?=
 =?us-ascii?Q?vOYXgo9Cur7CHZQzPI+dqqe+SZWLkx2MRKswgezVORJLojn9VnMn+aIWyx9f?=
 =?us-ascii?Q?dhvPgONsdBtoPwsxznpM1ajgpleyoebgTMxuSPiQA0PmTruAJaWxcAhFkY5t?=
 =?us-ascii?Q?A2SscgU1qfCrXQvZuglScqlgeYbBVp+3yEivZ5fpITeCI67UdRlxF08qIg0q?=
 =?us-ascii?Q?s6vssVDDD6GTUIHtA+qwH+7UoF2ttIBIqGiJ3/WWfj8iaJm2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6161B1F9D17E147AEEEFCFA4B0C036F@namprd04.prod.outlook.com>
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
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0374847-d510-4d27-d171-08df292b320d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 13:09:20.9967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zCEG2zw67Db6Iqd3ym36FUHiZnlxo7hBTwMG3IgzsOS+qbIwTICL9hoz8eL6/Xz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8788

On Tue, Oct 13, 2026 at 09:22:15AM +0300, Andy Shevchenko wrote:
> I interpret this clearly as "Let's allow vendors to continue making
> mistakes and provide wrong DT/configuration bits." My vote is
> definitely *no* to a such. If this needs to be done to support some
> weird firmware in the wild it must:
> - be a quirk that is clear sign that one has avoid such an example
> - inform the vendor to fix their crap
>
> Did I get it wrong?

Thanks for your review.

I see it a little differently, though my wording didn't help. For the
BMC side added by this series, I agree with you: with
aspeed,vuart-over-pci set, vuart3 and vuart4 should always be on SIRQ
0 and 1, the values the host's vectors 16 and 17 rely on, set in
aspeed-g6.dtsi rather than left to each board. That's the simple fix
for v7 of this series, with no discovery, since here the BMC and host
sides both come from this series. That's probably the less common
case, though: most of these boards run the firmware the board maker
ships with them, not OpenBMC. [my assumption, I don't have data]

The case I had in mind is firmware outside this series: the stock BMC
firmware on the ASUS board, which already ships. Which SIRQ a VUART
uses is a choice on the BMC side, and nothing documents which MSI
vector that becomes on the PCIe side or lets the host read it. From
testing, the vector looks like 16 + SIRQ: this series uses SIRQ 0 and
1 and gets vectors 16 and 17, and on the ASUS board the VUART is on
vector 20, which would be SIRQ 4, the 8250_aspeed_vuart default and
the COM1 interrupt. But that's inferred, as the host can't see the
SIRQ the firmware chose. So there's no documented value for the vendor
to fix to, and boards in the field keep their firmware.

Jacky, three things from ASPEED would help. First, confirming whether
the vector is always 16 + SIRQ. Second, having the SDK put the VUARTs
used over PCI on the same SIRQs as this series, so that firmware built
on the SDK matches the host driver. Third, longer term, a register the
host can read that gives the SIRQ or vector, since even a documented
mapping doesn't tell the host which SIRQ the firmware chose. In the
meantime, boards already in the field still need handling.

For those I'd make it a quirk, as you say. The class code tells them
apart: the stock firmware leaves the function at 0c0701, while this
series' BMC side sets ff. So the vector search would run only for
0c0701, wherever that support ends up, and never for boards using
this series.

If you'd rather not have a search at all, the quirk could instead use
the vector seen on the ASUS board, 20, for class 0c0701. That only
holds for firmware that picked the same SIRQ, and since stock firmware
from any vendor would have the same class code, each board whose
firmware picked a different SIRQ would need its own entry keyed on
DMI. With a wrong vector the port's tty output would stall, so that case
needs to be handled: the quirk would still check that the vector fires and
poll if it doesn't. The search avoids both, with a single quirk entry.

Would either form be acceptable to you?

Whichever you prefer, it doesn't settle where the stock firmware
support should go, in aspeed-pci-core or in the separate driver I
proposed [1]; that's still open, and the quirk would be the same in
either.

[1] https://lore.kernel.org/r/8CD30026-4C04-4E0F-B7A3-5C107D2A8410@phil.gs

Thanks,
Phil


