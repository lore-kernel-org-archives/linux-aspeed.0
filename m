Return-Path: <linux-aspeed+bounces-1566-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11292C77B7C
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 03:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRmt74zgTz306l;
	Wed, 25 Jun 2025 13:06:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750820767;
	cv=pass; b=XHOwFiWk2MS8oGW8ILgs3bKueOx6EoJUm64zsNF54NsIfJg7VzzFRGOpAel3wywITCzu+5rkv6sC6SkjhwniwNAIEkWlOW994uNjGvLxmiaEdVxa0FviYpQM6eHHi+3g3mwURmD3VijrPMM65zApnI133egI78k0cGfTHNKyOsxAf91KrdDrkeJMBIyxxY/iF5HGmKovaLWYzJkntss/AbFYrrG17m+FVgLdggJ+j1rKZmkd4rXDqZwIx70apIQINIY+QWgMq3uFzEQHvo+DX7laHA0zR4PSs3qaL7W0HrkUuXjiTS5i776ZgrwrwSlbrnleJlLA2gGgmYl4gkPvtg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750820767; c=relaxed/relaxed;
	bh=Acneohg1Zn8HsyrKcG29uiFZI8G1ZPvlnf8hWKcaTNE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQg0pQhfk1LjsLrrNG5MBH1qWCVzh17u1ETDISdy+G/ZWfyIM0QHvi0kA9PsYu5UHICfd9/ejD6nqy0UFKthW0MmFDnb8MuS9C6CH858zCls82trSjxS4QMqqdNRtNKvTTFQMPmkfkZ+t+flUq9MZeK7jFawHRurwJ7gGRxi9SuEGEc0CjXDlnzrelCKsSDR6T5p4ttZYG3wL8VKj17xf7ARQsz4e1sWn1Hp8aWmT17n2YwsTANSuZ6wKudjeos7F965/hQJdyfNqTSmjC3C8huMrZJo2aYDQ9gEK1GB5WNKgGfgWnMLFQNbJu3yseK8Lb82EKY0lL3WO/67VQOyqw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=OtQLVyi0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=OtQLVyi0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRmt61VKfz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 13:06:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwvQMXHSEMVYtVsKzcHmY8xLQ4IEVrEIqOo6tTmpJbxN+rRNBDpWS8N6CKQOmJnOgAmXgc8GwIshuA6Ab0cosJf0ECCS0R2BoSY4Y8QgHydenlXCsGeS+9nZaCN6vzFkC6uEmQnXe85aGlEyhtJ5oTHn2iQNFKE6+Ppb42CQzbsYk4p5T4+s4Xv6Dxq/SkJlz6fvHGQ5C2IjC1zadR+BjIb5aSRe8VEsT1/Fa5x/ETsVeb6OdsA/3e4B7KNj97vM1UeK23aa2FE6SSxVo7Atma9g7qiCsBfvINNBEKyCNDSYx8d5j6QULR9HFqn4J3Sr5gpZx/ACBOyom8XZ4I/iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acneohg1Zn8HsyrKcG29uiFZI8G1ZPvlnf8hWKcaTNE=;
 b=p7TM6HuqWlS/8BgdCMedUB/JVUwIbD2wuywmE1gFiQ0Z0jckrycF8XpFHcbWB7MVZXoTYm0VtM6ICYiD62MhSUPYwwkguemlqJydodETM+oqyFVsYDQE4J5MNXzb8PEJ6jWH7FHwp1dNkf8NtVXkRRjB+U5VnfzHlJK0XKojHHuJh8MnEid8PlzQvkjqhhPgCA55s3NPgGDyGWJ3/0u02PJJpAmKO0ktC+BiQ7Z/rxtOsZ7VCorvG7w5OAwhl4Qd5By2HJWr67Amnl6WTUafiRGulaGoa4t8vxo59oPE1TxIsse7YeyV8mtvsqvmzYKkAn4pi4iXzYmdt7jy13qrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acneohg1Zn8HsyrKcG29uiFZI8G1ZPvlnf8hWKcaTNE=;
 b=OtQLVyi0Oo8jGbCVAMeQGLj3Uxr+iMybXR1K/FywfCh2IWPf+57dcGZKHG7J7IlW63AiGY0BJOcOp8bxIh6zBI8e2f2ym8VPEyl7bYfc1D6s7YXjeZ6Vayt7pDdkrUAq1KrSw73hJ/iT61tnGpYqHsQMrd9nu89wXE/h6h2oxv2kFKgG2mgKPKnBAVswHgdQ8qAFLOn/XA2/Um3cYuAP6cSY5D+b9b9N2X4oFs2gNW1n1G0w5wbI+LGf3ZjOCsG7h7n2TwT/39mka8Uv9Ui7C/NdCLfZh4Hy4lkoXYRDB8QzYVkMYh0R+ctMGS8x+xw4/7gCn4OkcT+gcZKUABDW/Q==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by KL1PR0601MB5680.apcprd06.prod.outlook.com (2603:1096:820:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 03:05:43 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 03:05:43 +0000
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
Subject: RE: [PATCH v4 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Topic: [PATCH v4 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
Thread-Index: AQHb5W5DibGuaucLSESViBg/QPEnc7QTJ81Q
Date: Wed, 25 Jun 2025 03:05:43 +0000
Message-ID:
 <TYZPR06MB656881C7D0CB77C9051149C9F17BA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
	 <20250623024456.2068370-3-jammy_huang@aspeedtech.com>
 <c1820a08930576d19c107d8e007acb21cae07a4d.camel@codeconstruct.com.au>
In-Reply-To:
 <c1820a08930576d19c107d8e007acb21cae07a4d.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|KL1PR0601MB5680:EE_
x-ms-office365-filtering-correlation-id: 23711af7-e459-4415-5104-08ddb3952c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jzToa4UXlbJ8KZ0kRywWYieT+iKtzkavBtjuSuBcoBwbR9VBW6EwBfZ0Rw?=
 =?iso-8859-1?Q?54P6YgPBgUtx1oXCX5GB7T3S/8FdXIc5hdKIVyMuZKks9Ush+6ZxUACw90?=
 =?iso-8859-1?Q?YuJMoyafOi2iyFWaPTe5rIusHtclppUyE46Om0bC0bXcVOMO2e3dmSk1tZ?=
 =?iso-8859-1?Q?B/eVK1BvnSWAED4VH6Ua21HaxYPuGphAkg/r7I+2/nCAP2uij/ddgtfLOH?=
 =?iso-8859-1?Q?DSFIj/VMEdhXkRUadKsUMd1YB3vXOoNbCJmalT/ZqpHZC6xzPYnGB8ZKRk?=
 =?iso-8859-1?Q?+SPWbnkuAqQuZkwhlej+AhZShnHcfK1Oa6j/E2GuxFFqTxilMTWRtV96Tm?=
 =?iso-8859-1?Q?36QzMQ9F/tVLS4bXS9Kl+ML7z7aISSz7iYEdwtSg1D/Wr6HY31hfZ2HejT?=
 =?iso-8859-1?Q?3wlG3yX51TAHDqlHASpJ2YLIL5fTtyD1B1ITX2VW4vROCaIuXNqnxkb+2y?=
 =?iso-8859-1?Q?LY8QlZ7Vfae6l6raN/Ij77mx5HpE1fGSCUHas4QrVaJ1qgf1vfi/fq79aU?=
 =?iso-8859-1?Q?uhhiW3wygoVtfFZVA6asF0RBpP/HL0IlMEHPxaBobtqM2GFxgUcCUv2v87?=
 =?iso-8859-1?Q?avabq0FnfubOV2NABho80SEFpODBOou8Z2anZi0n+0elZfMFhszSM9dHC+?=
 =?iso-8859-1?Q?e4BY3meui0YHZk8RGOL0njSIU5Yw8gL6t9RBPDW/HZlx34LVNSiJ5L7XS+?=
 =?iso-8859-1?Q?6z6bQzv3MO3YFj/2vgMNif4ormIVr9W/zFEGcGueCEgZnmVSHAbUBmvq9g?=
 =?iso-8859-1?Q?RTDfkpzM8xueyKr7F6LEVJZWPU/XWJyQyCqHU46pDF9EOzQBmvsI5ZJO+q?=
 =?iso-8859-1?Q?4D5vZrn78xCoYECxjh8FITmmxkTsYYjBMaNEPYegHr0pbEBS4T1pghKRS0?=
 =?iso-8859-1?Q?U1hI5vxppsUvRUHJOeHODkG1x2pS1YrRltGzsBf5WTD7CcIQeK0/wb8vUU?=
 =?iso-8859-1?Q?w6hYyseV8rqkCEMqNnkXR0ccxurc3MQhZsEyEipZDviCp8h/2JL6xEke3k?=
 =?iso-8859-1?Q?eyWXZSGql9mwcEycLMMRKH5ZkQgfgpYvnxGnk9oRmdnhkN/lRsJAPGe/+g?=
 =?iso-8859-1?Q?je12jbTZF5aCeHoY0ms1HyHPwniJZI19hY7Dw2r2XD1RbU1fttzUrrVcRO?=
 =?iso-8859-1?Q?wR/sE5YBv90rw0nj8u4W6u4NVoeOA6fT+VyfderMmyfoIP9WEmtJL5vA0Z?=
 =?iso-8859-1?Q?vJwEhq9hBGjGddQjxRBP520U1PkuP6IqhtZIAAsWKsR/M4mKu3L1GGOD/r?=
 =?iso-8859-1?Q?n0iMPK714VBgbxcPemQteIZNJWNep6LOvGmMJS/lZXQ1mqn0LI249HkwnG?=
 =?iso-8859-1?Q?zzyJ1endY5TI1UvZcORWwXa+VGId7OoaSEC689eRno5gnojRmTwtQtWIJz?=
 =?iso-8859-1?Q?CHpYgizA8U9VXZWmfJly90tcQ+AhFcQ96UVWBlfHlCQsCLFffVlnexv2CT?=
 =?iso-8859-1?Q?rWso3Kj16Hi5xXoNlov/lNQGqsaEwwcqgFiFFYK3lICTdZI/4qIwOs34Sb?=
 =?iso-8859-1?Q?Or06zByMP+5mrdJiOVNhUz4IgvwTAPLpwirLL7lZFcr+XfODTDarzK/4nb?=
 =?iso-8859-1?Q?bw8+TXA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?v42iVqCvo/d9K2kjoqYxpgUeZXOJ4FE+gYEbrGhJZst+8rVWBnDVpsn3Uq?=
 =?iso-8859-1?Q?hsFwkvH3TTJzGnxmEZut3AcW3NlekL4eAk6LG+MQy4W0OQuCXW/KUSZrF0?=
 =?iso-8859-1?Q?MKoAGlO0s/y1bvUFnKeFdCVkvMwox86o+thjv0UvA9SWZDffCiG0RgTSTx?=
 =?iso-8859-1?Q?3J9aKXt7hkWa0GnISxEiSsMc/pa+4IEtx2FJDIi/XDkAfg4eOl/kRxzjkc?=
 =?iso-8859-1?Q?+a5RuALXmsWvT+iILz8L7lZZXwJz01R7a175emig97R36KwG9POGpaoxKM?=
 =?iso-8859-1?Q?rHvNhpgBZdaq4Gt0xOBcE0FHdYIETam8M6eK4SEDURa+Bpw68moI7fTybB?=
 =?iso-8859-1?Q?RpG5aUCrW+ReRjUot2ggYQGKOPpzAl2rPCPIbp84UyO2etnmq7K6Iz1WKG?=
 =?iso-8859-1?Q?HRMB0SzFjg1RtOIE8+rTfNYTpNcc51/yU/Rqpjz9wuc2hgNCpoElyg6TWa?=
 =?iso-8859-1?Q?awz7IGc589gpFwas+fuqLN3OHvGW0DSHrJfrpo+EbtmJrPnbFxkaCNgiCN?=
 =?iso-8859-1?Q?Ik26LXtd8yqDh4R0o8OvB9UAO55SLKhZrzQ/WQiuCw8GUfDChbyUb3k7oq?=
 =?iso-8859-1?Q?tVO++den1QrCRzyvdwAkSW+Dgy0VF1DVUMWC8ayipuJQ/DsqsZPUG3hy8e?=
 =?iso-8859-1?Q?ryPJATQv42IXAJnYDam+efxBma/nDuI8zQAW6+hJBgtC0kliN+5rNn7uiL?=
 =?iso-8859-1?Q?Q5zugputDcc4/oWxG/+yXkyHhzGbkwuJqgu9o7a2DL1CPQrLLLOFQhzGxv?=
 =?iso-8859-1?Q?jCRVVg+K2fJtFChUwTflVZw99sOr82DqMUwjQc2TnkE9XhLYvyxKESytjb?=
 =?iso-8859-1?Q?RiLdmxim8EKRpZy/uhsUzSIX7qtHT23jMnke0sEz1LX4PcPoycdejUMfSq?=
 =?iso-8859-1?Q?QYgwtCXUn8XQTKr4rPdckvMUQRSNbdO2ZN+lV2FOdqJPLqeOAh2kKpZf80?=
 =?iso-8859-1?Q?vSM+QiuG3TVEoOsBrxXsAEwk7hh2uOrplRBwl6UwhylOrvBURxhStUidW7?=
 =?iso-8859-1?Q?I2kBUSu1rsJuHGdpLmy0UW54Wf7dN1vLFpZE3km1VINjaSUk4RI8l2/Ryv?=
 =?iso-8859-1?Q?JTDX+hJtXD1KOaAjGS2uVPFUteCdNlwrtgn4LI+Il30YEJjOMGOR13QzcG?=
 =?iso-8859-1?Q?LbxDxCNu0y/b8WcibFcOKVZrHUIPh5UuZf5mPWRcVMOfkf2LZexifftg/9?=
 =?iso-8859-1?Q?7R5W7KuzCRWd7XUoFOAc/7RymMdhahykiQZM15U9O1CuhACHS3v8wm8y+D?=
 =?iso-8859-1?Q?M4h7TfTwTEiEL0gxEy+LHzFMkq7mvGtHlnOPTSbEXx6uA9jThbJMeKtPnK?=
 =?iso-8859-1?Q?jp1kJ5QLXByXffPHrxoqbLRYuDQio1LyVoLpjrmc5pI9S0jLMZxJcySvtO?=
 =?iso-8859-1?Q?1Nn9GmfkdaGIH7otmQX39Ok44alznYlkz6/CxomMdYy4z/EdlrdWF1Zcwy?=
 =?iso-8859-1?Q?ii3l1h3Vyz2jqO5wRMrHxOFs2vHOq0nJodQaScMT+pvn8ufhrAFgHVSVon?=
 =?iso-8859-1?Q?7rh8aU8LdD3j0lt6CecaYIxque5plg+1UCy0i7oJgVKfHmcQQ8k5ZVhowu?=
 =?iso-8859-1?Q?q2XlThnkWvAb2z8LVfLRIAusxiQ8kEU0FHFKwn1vfofCQK7ngPb4YT5Xc+?=
 =?iso-8859-1?Q?ifV+2UCCVcIo+DJqGJY5/+nWer7tqjo/2C0ed2SPAyXC5AUjEZF9fKFA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23711af7-e459-4415-5104-08ddb3952c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:05:43.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGfmxZHSLHhX4XlPi0f/DsIWu4e3uXLd7TXsKnlrSASkr/sJZCQ5ZUdKlTobndILss8TIzJF3BBj6FJBeQFm5WQNzvECFeZ5O0sDqoF6fIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5680

> On Mon, 2025-06-23 at 10:44 +0800, Jammy Huang wrote:
> > Add mailbox controller driver for AST27XX SoCs, which provides
> > independent tx/rx mailbox between different processors. There are 4
> > channels for each tx/rx mailbox and each channel has an 32-byte FIFO.
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> > =A0drivers/mailbox/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 ++
> > =A0drivers/mailbox/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +
> > =A0drivers/mailbox/ast2700-mailbox.c | 230
> > ++++++++++++++++++++++++++++++
> > =A03 files changed, 240 insertions(+)
> > =A0create mode 100644 drivers/mailbox/ast2700-mailbox.c
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
> > 68eeed660a4a..1c38cd570091 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -340,4 +340,12 @@ config THEAD_TH1520_MBOX
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel is running, and E902 core used for p=
ower
> management
> > among other
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 things.
> >
> > +config AST2700_MBOX
> > +=A0=A0=A0=A0=A0=A0=A0tristate "ASPEED AST2700 IPC driver"
> > +=A0=A0=A0=A0=A0=A0=A0depends on ARCH_ASPEED || COMPILE_TEST
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0=A0 Mailbox driver implementation for ASPEED AST2=
7XX SoCs.
> This
> > +driver
> > +=A0=A0=A0=A0=A0=A0=A0=A0 can be used to send message between different=
 processors in
> SoC.
> > +=A0=A0=A0=A0=A0=A0=A0=A0 The driver provides mailbox support for sendi=
ng interrupts
> > +to the
> > +=A0=A0=A0=A0=A0=A0=A0=A0 clients. Say Y here if you want to build this=
 driver.
> > =A0endif
> > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile index
> > 13a3448b3271..9a9add9a7548 100644
> > --- a/drivers/mailbox/Makefile
> > +++ b/drivers/mailbox/Makefile
> > @@ -72,3 +72,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)=A0+=3D
> qcom-cpucp-mbox.o
> > =A0obj-$(CONFIG_QCOM_IPCC)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0+=3D qcom-ipcc.o
> >
> > =A0obj-$(CONFIG_THEAD_TH1520_MBOX)=A0=A0=A0=A0=A0=A0=A0=A0+=3D mailbox-=
th1520.o
> > +
> > +obj-$(CONFIG_AST2700_MBOX)=A0=A0=A0=A0=A0+=3D ast2700-mailbox.o
> > diff --git a/drivers/mailbox/ast2700-mailbox.c
> > b/drivers/mailbox/ast2700-mailbox.c
> > new file mode 100644
> > index 000000000000..64638ac67e7a
> > --- /dev/null
> > +++ b/drivers/mailbox/ast2700-mailbox.c
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright Aspeed Technology Inc. (C) 2025. All rights reserved  */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mailbox_controller.h> #include <linux/module.h>
> > +#include <linux/of.h> #include <linux/platform_device.h> #include
> > +<linux/slab.h>
> > +
> > +/* Each bit in the register represents an IPC ID */ #define
> > +IPCR_TX_TRIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00 #define
> IPCR_TX_ENABLE=A0=A0=A0=A0=A0=A0=A0=A0=A00x04
> > +#define IPCR_RX_ENABLE=A0=A0=A0=A0=A0=A0=A0=A0=A00x104 #define
> IPCR_TX_STATUS
> > +0x08 #define IPCR_RX_STATUS=A0=A0=A0=A0=A0=A0=A0=A0=A00x108
> #define=A0 RX_IRQ(n)
> > +BIT(0 + 1 * (n))
>=20
> Seems overly complex?
Agree.

>=20
> > +#define=A0 RX_IRQ_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00xf
> > +#define IPCR_TX_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x10
> > +#define IPCR_RX_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x110
> > +
> > +struct ast2700_mbox_data {
> > +=A0=A0=A0=A0=A0=A0=A0u8 num_chans;
> > +=A0=A0=A0=A0=A0=A0=A0u8 msg_size;
> > +};
> > +
> > +struct ast2700_mbox {
> > +=A0=A0=A0=A0=A0=A0=A0struct mbox_controller mbox;
> > +=A0=A0=A0=A0=A0=A0=A0const struct ast2700_mbox_data *drv_data;
> > +=A0=A0=A0=A0=A0=A0=A0void __iomem *regs;
> > +};
> > +
> > +static inline int ch_num(struct mbox_chan *chan) {
> > +=A0=A0=A0=A0=A0=A0=A0return chan - chan->mbox->chans; }
> > +
> > +static inline int ast2700_mbox_tx_done(struct ast2700_mbox *mb, int
> > +idx) {
> > +=A0=A0=A0=A0=A0=A0=A0return !(readl(mb->regs + IPCR_TX_STATUS) & BIT(i=
dx)); }
> > +
> > +static irqreturn_t ast2700_mbox_irq(int irq, void *p) {
> > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D p;
> > +=A0=A0=A0=A0=A0=A0=A0void __iomem *data_reg;
> > +=A0=A0=A0=A0=A0=A0=A0int num_words;
> > +=A0=A0=A0=A0=A0=A0=A0u32 *word_data;
> > +=A0=A0=A0=A0=A0=A0=A0u32 status;
> > +=A0=A0=A0=A0=A0=A0=A0int n;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Only examine channels that are currently enabl=
ed. */
> > +=A0=A0=A0=A0=A0=A0=A0status =3D readl(mb->regs + IPCR_RX_ENABLE) &
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 readl(mb->regs + IPCR_RX=
_STATUS);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!(status & RX_IRQ_MASK))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return IRQ_NONE;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0for (n =3D 0; n < mb->mbox.num_chans; ++n) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mbox_chan *chan =
=3D &mb->mbox.chans[n];
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(status & RX_IRQ(n))=
)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ontinue;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Read the message data =
*/
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (data_reg =3D mb->reg=
s + IPCR_RX_DATA +
> > +mb->drv_data->msg_size * n,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 word_data =
=3D chan->con_priv,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words =
=3D (mb->drv_data->msg_size /
> > +sizeof(u32));
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words--,=
 data_reg +=3D sizeof(u32),
> > +word_data++)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*=
word_data =3D readl(data_reg);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mbox_chan_received_data(c=
han, chan->con_priv);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* The IRQ can be cleared=
 only once the FIFO is
> empty.
> > +*/
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0writel(RX_IRQ(n), mb->reg=
s + IPCR_RX_STATUS);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return IRQ_HANDLED;
> > +}
> > +
> > +static int ast2700_mbox_send_data(struct mbox_chan *chan, void *data)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > +=A0=A0=A0=A0=A0=A0=A0void __iomem *data_reg;
> > +=A0=A0=A0=A0=A0=A0=A0u32 *word_data;
> > +=A0=A0=A0=A0=A0=A0=A0int num_words;
> > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!(readl(mb->regs + IPCR_TX_ENABLE) & BIT(idx)=
)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_warn(mb->mbox.dev, "%=
s: Ch-%d not enabled
> yet\n",
> > +__func__, idx);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!(ast2700_mbox_tx_done(mb, idx))) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_warn(mb->mbox.dev, "%=
s: Ch-%d last data has
> not
> > +finished\n", __func__, idx);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Write the message data */
> > +=A0=A0=A0=A0=A0=A0=A0for (data_reg =3D mb->regs + IPCR_TX_DATA +
> > +mb->drv_data->msg_size * idx,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 word_data =3D (u32 *)data,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words =3D (mb->drv_data->msg_siz=
e / sizeof(u32));
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_words--, data_reg +=3D sizeof(u3=
2), word_data++)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0writel(*word_data, data_r=
eg);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0writel(BIT(idx), mb->regs + IPCR_TX_TRIG);
> > +=A0=A0=A0=A0=A0=A0=A0dev_dbg(mb->mbox.dev, "%s: Ch-%d sent\n", __func_=
_, idx);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > +}
> > +
> > +static int ast2700_mbox_startup(struct mbox_chan *chan) {
> > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > +=A0=A0=A0=A0=A0=A0=A0void __iomem *reg =3D mb->regs + IPCR_RX_ENABLE;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0writel(readl(reg) | BIT(idx), reg);
>=20
> It seems ->startup is called with the channel spinlock held, but as each =
channel
> is independent, the RMW sequence here could lead to unexpected results?
>=20
> I expect you need a spinlock to protect against concurrent changes to cha=
nnel
> state.
Agree.

>=20
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return 0;
> > +}
> > +
> > +static void ast2700_mbox_shutdown(struct mbox_chan *chan) {
> > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > +=A0=A0=A0=A0=A0=A0=A0void __iomem *reg =3D mb->regs + IPCR_RX_ENABLE;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0writel(readl(reg) & ~BIT(idx), reg);
>=20
> See comment above.
OK.

>=20
> > +}
> > +
> > +static bool ast2700_mbox_last_tx_done(struct mbox_chan *chan) {
> > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb =3D
> dev_get_drvdata(chan->mbox->dev);
> > +=A0=A0=A0=A0=A0=A0=A0int idx =3D ch_num(chan);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return ast2700_mbox_tx_done(mb, idx) ? true : fal=
se;
>=20
> The ternary expression is unnecessary, we can instead do:
>=20
>    return !!ast2700_mbox_tx_done(mb, idx);
>=20
OK, I will let ast2700_mbox_tx_done return bool to simplify it.

> > +}
> > +
> > +static const struct mbox_chan_ops ast2700_mbox_chan_ops =3D {
> > +=A0=A0=A0=A0=A0=A0=A0.send_data=A0=A0=A0=A0=A0=A0=3D ast2700_mbox_send=
_data,
> > +=A0=A0=A0=A0=A0=A0=A0.startup=A0=A0=A0=A0=A0=A0=A0=A0=3D ast2700_mbox_=
startup,
> > +=A0=A0=A0=A0=A0=A0=A0.shutdown=A0=A0=A0=A0=A0=A0=A0=3D ast2700_mbox_sh=
utdown,
> > +=A0=A0=A0=A0=A0=A0=A0.last_tx_done=A0=A0=A0=3D ast2700_mbox_last_tx_do=
ne, };
> > +
> > +static int ast2700_mbox_probe(struct platform_device *pdev) {
> > +=A0=A0=A0=A0=A0=A0=A0struct ast2700_mbox *mb;
> > +=A0=A0=A0=A0=A0=A0=A0const struct ast2700_mbox_data *drv_data;
>=20
> Calling this drv_data is slightly confusing. Perhaps dev_data?
OK.

>=20
> > +=A0=A0=A0=A0=A0=A0=A0struct device *dev =3D &pdev->dev;
> > +=A0=A0=A0=A0=A0=A0=A0int irq, ret;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!pdev->dev.of_node)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0drv_data =3D device_get_match_data(&pdev->dev);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0mb =3D devm_kzalloc(dev, sizeof(*mb), GFP_KERNEL)=
;
> > +=A0=A0=A0=A0=A0=A0=A0if (!mb)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.chans =3D devm_kcalloc(&pdev->dev,
> drv_data->num_chans,
> >
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(*mb->mbox.c
> hans),
> > +GFP_KERNEL);
> > +=A0=A0=A0=A0=A0=A0=A0if (!mb->mbox.chans)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* con_priv of each channel is used to store the =
message
> > +received */
> > +=A0=A0=A0=A0=A0=A0=A0for (int i =3D 0; i < drv_data->num_chans; i++) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mb->mbox.chans[i].con_pri=
v =3D devm_kcalloc(dev,
> > +drv_data->msg_size,
> >
> +
> =A0=A0=A0=A0=A0=A0 sizeof(u8),
> > +GFP_KERNEL);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!mb->mbox.chans[i].co=
n_priv)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn -ENOMEM;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0platform_set_drvdata(pdev, mb);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0mb->regs =3D devm_platform_ioremap_resource(pdev,=
 0);
> > +=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(mb->regs))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return PTR_ERR(mb->regs);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0mb->drv_data =3D drv_data;
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.dev =3D dev;
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.num_chans =3D drv_data->num_chans;
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.ops =3D &ast2700_mbox_chan_ops;
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.txdone_irq =3D false;
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.txdone_poll =3D true;
> > +=A0=A0=A0=A0=A0=A0=A0mb->mbox.txpoll_period =3D 5;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0irq =3D platform_get_irq(pdev, 0);
> > +=A0=A0=A0=A0=A0=A0=A0if (irq < 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return irq;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0ret =3D devm_request_irq(dev, irq, ast2700_mbox_i=
rq, 0,
> > +dev_name(dev), mb);
> > +=A0=A0=A0=A0=A0=A0=A0if (ret)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return devm_mbox_controller_register(dev, &mb->mb=
ox); }
> > +
> > +static const struct ast2700_mbox_data ast2700_drv_data =3D {
>=20
> Again, this is data about the device, not data about the driver.
> Perhaps ast2700_dev_data?
Agree.

>=20
> Andrew
>=20
> > +=A0=A0=A0=A0=A0=A0=A0.num_chans =3D 4,
> > +=A0=A0=A0=A0=A0=A0=A0.msg_size =3D 0x20,
> > +};
> > +
> > +static const struct of_device_id ast2700_mbox_of_match[] =3D {
> > +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "aspeed,ast2700-mailbox", .data=
 =3D
> > +&ast2700_drv_data },
> > +=A0=A0=A0=A0=A0=A0=A0{}
> > +};
> > +MODULE_DEVICE_TABLE(of, ast2700_mbox_of_match);
> > +
> > +static struct platform_driver ast2700_mbox_driver =3D {
> > +=A0=A0=A0=A0=A0=A0=A0.driver =3D {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name =3D "ast2700-mailbo=
x",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.of_match_table =3D ast27=
00_mbox_of_match,
> > +=A0=A0=A0=A0=A0=A0=A0},
> > +=A0=A0=A0=A0=A0=A0=A0.probe =3D ast2700_mbox_probe,
> > +};
> > +module_platform_driver(ast2700_mbox_driver);
> > +
> > +MODULE_AUTHOR("Jammy Huang <jammy_huang@aspeedtech.com>");
> > +MODULE_DESCRIPTION("ASPEED AST2700 IPC driver");
> > +MODULE_LICENSE("GPL");

Best Regards
Jammy

