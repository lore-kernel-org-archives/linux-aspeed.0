Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8C606A327
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Nov 2026 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lAbn2Da9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ21p1dp4z308Q;
	Thu, 12 Nov 2026 11:53:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794444798;
	cv=pass; b=cZCyOerwPBf8hhsEKe/k7gsxms6/8M2jQaYW8IIxGOQnDHTyojKNE+/1WARqdaoe94sxtGg1LyuU7JxnT7dRAVEk4WIj9vCckGxZ+1gCepqJjQg5o8h5zPu3Pa9oBAcRKcA/L/FwezkMF0KXDJ/+Nmi/dN+oIKWMdPT2LgP5rTfEq4fM+ZHVpvbOmChU4uc9NZZFWC3+x+h56XLXTznpFd68yv36FEd/K2UfUsNKgke85iQWO9Kn9n1w+wkAhoFYjpQTTNH7fh+7X1Vo9qv0P7YAnIu/Knpiip8JJ8fHDAYs3+iGZb9cOoDGDqQ+uVk4l0BzujqBmpbekTP4DdLl0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794444798; c=relaxed/relaxed;
	bh=YxJnf50tCfDByCE+LiYicwoqK+RsweByR6JgVuZCrDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uzp5bXw10qhXuc4gxxu9iAFxyyv9LEA7CHeq2DVhpc8E4FdCzbFvLZQFPXWGbmUYbzDlVBUlR02C7VQkb1NKgtzsL/2COXwCgQzynFxuBqtGPo7RdGbBqE1fSXPRL4oQvWK7KxHt1dcs8kjl5JYekKcBX5kCittf5VD/LlFf7i9L71jPnqQ6fQiqDQ3T1BgxSdE/ld/GBJni3IuDa6Ax3XK2GE4Kiwr8XkPjrjo8n+KR8HI7Xi7AGocn4WvFxCVhks4BgwFRHYBeAtggEmiVV4ZjeWasNoBXEDg4LFKcGpdhID1uN25u9ToIPSmCHDkQ6UqWVPd5rkyZYTbAgqoc/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lAbn2Da9; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lAbn2Da9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ21l43znz308H;
	Thu, 12 Nov 2026 11:53:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWhIV/zWsAgjc5pVMS/wABYPbbM5DzoslbLExyBgmZo1ktJ1w8GCmtMqlL3HoescC2u5pkiEoftltCwNU/MHt1l+/KI/v0wGlDrCH8qqjkC7BkSx9z53xtDdvDrWZDLA6KAp6g/7iD+Rl3CNS8NRjAhugJLInE4bCwALhrP9SoCFv7BVvLUleNnRAEuAMu4hgLR7T4nIpCD80ItEJmdDe1JlIuSpLepIOAvVK5AI3Vvy0T/GCRs9dw+dYTjSheqnC74z7fqpRNWDAsNQWxq1V7KcQqGDJCEQj0Aq8YKTLcU8UPFicyYFadrSZ8UN1BgXyLV0nxhY36G5iL03HcGIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxJnf50tCfDByCE+LiYicwoqK+RsweByR6JgVuZCrDs=;
 b=ZohH3qT9+y+IXlDIe/NOdsJxbua5UBvm4S27E8eKTsaumvHuWxVqkVmQMWszx4xbmuIxRhcotx2VQZfH+5NOb+t7eND2jLrtqDhY+6M7noR+p5zeJ5y9BA50wMtTIKUv2fCxR0AgdeEky70yvtzo1nwMfzd+y8BUrP5FyyXm/tNQVZV7dnbYhcZLz3dwOIqjSfI2pJaBH4XXjlTSEbF8L2oNb6lSj5zQ1TICKcKMOjC5r8fINFw0yVjerS/N1Cf1fzYH1jU2uGl+TYizz7kc989Zy/C61nY/LBE+wktbNdIB6DSYREnGZ8fVnnKkaSwsnH9oQDVs3HuMJpYMVBruiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxJnf50tCfDByCE+LiYicwoqK+RsweByR6JgVuZCrDs=;
 b=lAbn2Da9L+MGBaoNdVr/6X/uFZkFkNLvbY25SRbNil8DolLRcWMbFelqDe2hoaIjrOOXBA+cuKNhEqfzR1vfQUTctzyDoBcCFJql6vbpWdrTJWGr9YXDsKjflSFr9kYQgoipx4LCjzZ+QyoPPA4nAjELqCACxmMmwGiTJWo00Ikcti8p6RYqXxr/peXbK7FaoIyxgcqZq8j0AadixZQ6Os8hIb/CaAIAJ/Ai29m6Y5u41yrJcVsBGbfAxwtzeRuaU/4vHK7yz17ymTdIrZ5L98eX/Ri5wAa4/VzR+Nn6tEOlFL8oBGQZOLyHOAay7Q6AIiLxG/KEN+DT4drj+0oLBg==
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9)
 by TYPPR06MB8234.apcprd06.prod.outlook.com (2603:1096:405:382::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 00:52:46 +0000
Received: from KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f]) by KL1PR06MB6942.apcprd06.prod.outlook.com
 ([fe80::5058:b315:12b6:d44f%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 00:52:46 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Myeonghun Pak <mhun512@gmail.com>, Eddie James <eajames@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy
 Tsai <billy_tsai@aspeedtech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: RE: [PATCH v2 1/2] media: aspeed: join IRQ and work before probe
 cleanup
Thread-Topic: [PATCH v2 1/2] media: aspeed: join IRQ and work before probe
 cleanup
Thread-Index: AQHdcNAZaTFToA3zjkSYSs6A9M9jbLcpnbJA
Date: Thu, 12 Nov 2026 00:52:45 +0000
Message-ID:
 <KL1PR06MB6942D9B03A65443CD98E0857F1702@KL1PR06MB6942.apcprd06.prod.outlook.com>
References: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
 <20261109235731-aspeed-v2-1-mhun512@gmail.com>
In-Reply-To: <20261109235731-aspeed-v2-1-mhun512@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6942:EE_|TYPPR06MB8234:EE_
x-ms-office365-filtering-correlation-id: 7ab6c2c1-933c-4bb8-238b-08df4057442c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|6133799003|22082099003|261009220027099003|10067099003|261009221227099003|261021121427099003|4143699003|5023799004|261022075727099003|261028144727099003|261009221727099003|261009223327099003|261009223027099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info:
 8E7aCss1Ihc7gJTh2o6F2h72m4P1kuNvijAuDFgahkDObFDg2qNUIyx3Qb2c6HGfkvMVE96XvpreNpZZYxCNkuJtNVayQoY+YoLu9/ggPtnvK3nD4aOeHinhGc9FzXqe2fPFjUx2NXoVIUUlfNmksWrmhSP7y7DRVfPDW07JOT5uBTRJjPNLnZ/z9O+tV1K8WqO6qYW1U2YbW0GN08AHo5i87hMKHstvo0Ob+L6rr7tN3n2ng7uqEzrMLZDIFZdsTgH5Htj7h3x/6kNEFVtLpDPg91sW41hW+bED564vjHC82uOSY10HCmPtoW65DM1bPdzt55QIJL9JGIvvUrgM3iUReDIzm59AePhirPmUzHZMgiClkjIHWegjydfsRck000myrYFzeQCcKgHSIu5/WAkFom9FjKbnNGRake+O4ZNwOcqY00MKq0zWpyp3hY6Sp9bH8gPBv8Zblc/wWGo41H6+Tfvc+TS2d6xlneeH8gAODKyVikas7Zeb9dapKOtbmd6QItvg677ijHxuUCml+aon3x5ZFIgD77QlCVVQhcz6zN/8IIySp/N6DtThsqLFc/EaAMxTvNCBOxsetk87XztMSaJBjLLSLdcqbl+cg6dwF9+axKfPcBji9klr8JUCMDJQ7/va1vbHrXYYgmk6sNU9FGid7uFhLaBPE3h/3UMlWQra9EGHpU7S7TIdvq+KMyVcLGHTC/gL11g/A1/lwHtBf/BZGx2DM/Euk2RIulo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(6133799003)(22082099003)(261009220027099003)(10067099003)(261009221227099003)(261021121427099003)(4143699003)(5023799004)(261022075727099003)(261028144727099003)(261009221727099003)(261009223327099003)(261009223027099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ty9vdUJJTTkwTzVGUVV4c3hIVEtJTzNYczdQTHkzZ05EVWVIR3MzVXovaFRl?=
 =?utf-8?B?MjRUOUZCSXIrUmFWVlVhckpIVTNheUx6bHgyUzZsSkdDTjZDVU9Gc1p4Mlk1?=
 =?utf-8?B?R3VVV1YzTHN3bWRoNnkyajRVazZYMFVzOVNmWkJ1a2ZscmRFdEdObXorcWVN?=
 =?utf-8?B?Y1E0VFBPczgyajU1UVYrcUNEdnJkOGxOM1Zha3NhN0ZXV2IzcnBvcWh0dkRT?=
 =?utf-8?B?MFA3UUhCbXExNERYandRR2I2UisrbmFWRUVmcTErN0xLTmdxUlVwSGRrazIv?=
 =?utf-8?B?VC9NTEwwR3FUWldiWUZmeXRrdy9zSmVLVW8vYkNPV1BCaUI4ZXByOTlnZXdz?=
 =?utf-8?B?RzIwZVM1eTJtMWpNT0R2RW9BMlFnSGZ2MGJubCtOQ3ZVUWRyM2QyYVRBRHlt?=
 =?utf-8?B?aVlsUG11SVl5c0x3Qmh6TEtVNDFSTEk1RUVqdjRsYzM4cC82ZzQ0SnlBOXg5?=
 =?utf-8?B?blFPNG5GYUtkZnNHamxLV0krWWI2QVlZVnRseXQwdUpqUklSbWRESVlOanpE?=
 =?utf-8?B?d01paGIyNXF4WGZIT3BsWWExMmRLeHRTZVVrTUNJWndYd0JvSGpBWE1rb0xL?=
 =?utf-8?B?ZndkMWU2d2hwaURITCtvZFd3cTkrOVZnb054L0oyenNhbXZ1eUZHYitiYndW?=
 =?utf-8?B?ZkNZbEhlUFZ0TlFlK0RINkUvQnhpYUlyYThSRVE3cWpNMGNXRVBScHRYL3hL?=
 =?utf-8?B?QmlhYnA3RVdnalhvOTdRSXpRY2h6bElDbXFzdG1UM1RZWFllNDR3VTE2T296?=
 =?utf-8?B?UWNEdER4YWFCaDMyNURKSUZPOU9EbmprUHFLQlUxeGp3Wlk2UW5nUHJ0VDFv?=
 =?utf-8?B?OVUvTWJFeXNnanVWQ0xyS3hsY21IaU5QRmVmdmNJR2ViTDBqTFZ1WGtuNjht?=
 =?utf-8?B?TTU1NUJ2RlFBVWg4dStwd1lzYWRFMHRLK216VzRPdDVUaXVpaEdrS2ZLZ2Zr?=
 =?utf-8?B?bUFhZDFRcytLMGNsM3N5c204ZUpabFFHcGNZWVMzeUhwY1FrMzVZeExkMHRP?=
 =?utf-8?B?SjlvNlVBMVg2MTBud2xNS2duaDNYaEg0WXpYTHhnRTgwSXQ4cHh3bFFSZEtV?=
 =?utf-8?B?OWcvTkJPc2JkR1BBVVRmVXB4QnFKa0dyQ3VxcjBESzBzWGFGY3VqSklQbUZR?=
 =?utf-8?B?OTl1OEVIUTVZMHVXMkJFNHdzM04wYXBpZDNzZENERHh6YlJHTTZpUW94Vllu?=
 =?utf-8?B?YmZFRkhXbmxSc1dBeUMxMXpvZnI1TFI4bVNRWEZTZEx2dEpLQzNrOWdBd0p1?=
 =?utf-8?B?UDRBeEl4Njl4L2hrM3FkQXBYWW9oN3pCbWpxWG5XUnlJVFFXcllvYWFpb2Vr?=
 =?utf-8?B?QVlKay82dE5ORThvTGsyWlFjekZKazRGbm0xcG1aU0t2Z3dxUjd4aVRUcU1U?=
 =?utf-8?B?VWM1bTloYVc2SDZoQlNQNkN0Y203Y016dE5WVkpXYm5Cd1BEOEVpVHpnUXVq?=
 =?utf-8?B?VXNDcEtUT0o2MEhnNnF1UllCMTlzUlFPcXNPVi8rUGJNTjlsVmdmK05SQWxM?=
 =?utf-8?B?VW42SERMbUVTWVlJdFlSWUE0akl3bWo3WG83Vk5HODN0V3JKVkpGNTNlNzlB?=
 =?utf-8?B?d3AwVXExU2hFOU5qTTJUZXpPNWRZekhMUERHUHk2cUl2MDJiM3JTbWFSZVBT?=
 =?utf-8?B?K0g0bk9PSCs4VzI1TjZHbWlsUVZtZk1HcWVXbFlQTVA2bmtSYmtrbUNVL0gy?=
 =?utf-8?B?TVhIWDNTNC9pb2FsaFRMVVl1MGdxTnNpclRqTTJTb3phK001NVYxNHFaUzRL?=
 =?utf-8?B?bnY1TVRaa05KenZPZ2N1elAwTTZZR3VzQ0NSa05WOUFMckJNcTZJRm1BOW9T?=
 =?utf-8?B?cmY2V1d6bTBwT2VYZnMyNHg5SURIVFptRnduMkxZV2F6Y050cVlUQmFCTGlm?=
 =?utf-8?B?aGViMHh2NjlYam1MZWpUd2w3S3lJNjZicjQ2UFJrZHNnRjZIMGZob3NmNHBM?=
 =?utf-8?B?bkM3cmZ2MWlMYVAzUWF4SS91UDZROUlpaStzeXpUYkhXa1NHM3ZhT0ZvWnRN?=
 =?utf-8?B?cFpxM2ZaNnpsa3kvLzBRZ2hZWVpIc2UvMVNrYzFaSWVlLyt5K3ZQVUpTZ3VV?=
 =?utf-8?B?ZjlKT2UyN1FCU1JmR0JjUFdtYUJnc1QyMlNlQUsyY01OUlNLRXcvQjV6cHg1?=
 =?utf-8?B?NGNreWNEZGdtbnV4TUlOVDNCSHBuajd5djA0NkhOQjJDKzRXa1RkWDh2QnZY?=
 =?utf-8?B?NzVyQzNKZkxxOHdHTDA1NnFQUndjSmxkRnNqb0s1THBjeC9RaExFTFNDZXBl?=
 =?utf-8?B?U2dSM2FLQWVpa2gxOUpFTDRSY3FCQzJxRmdlMWllNm9VUGladXdMNlFzVjdS?=
 =?utf-8?B?RXg1S0JyUVJRdE5QZm9iM2picVNSVEF0V0JYWlAyZUE4SkY0Y1YzZz09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iKVBZFSRiJdwKjizTDX0ByLVxJdZkzPIXkbPsvI/mCJRatBprio3q/aggQxj5tF+NnAUkkPkmvSpGll3cRPJ/xeJg58AA3os3w2Teu3Nd4r/utK63oESq9G0IsrCwt1xYsgcIKA3S6nYTkp5ya/lP5KmedZaexnU8hmCoDJOUckZ/5mdXWcVyV4MDsJSlONfqEvGQTbu1ser9YmvOBqItBEN/tuYsfIZsjgQqQGfPiX24HowCR2iu495EivqYW1V4xlyl5X/N5sKZE4beR985udabwtsMrw5f22m+GGYRGq+OCRSCdO2YnVrzeNrxurSbxLm1XRROPsyuPjS/j2pfA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab6c2c1-933c-4bb8-238b-08df4057442c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 00:52:45.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJnbaqs+BESRHBv7yggruwmZYx0xtSllUdlwZkoa8T+M1OaT3/QaMfYmbGOrV8fsxBceoXK6imRcRmsFwFLPifjmpSZHAzAalVjLl8D/Yxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8234
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTXllb25naHVuLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiBUaGUgc2V0dXAgZmFp
bHVyZSBwYXRoIHVucHJlcGFyZXMgdGhlIGNsb2NrcyBiZWZvcmUgZGV2cmVzIGZyZWVzIHRoZSBJ
UlEuDQo+IEFuIElSUSBoYW5kbGVyIHRoYXQgaGFzIHNhbXBsZWQgYW4gZW5hYmxlZCBzdGF0dXMg
Y2FuIHN0aWxsIHF1ZXVlIHJlc29sdXRpb24NCj4gd29yay4gTWFza2luZyB0aGUgc291cmNlIGRv
ZXMgbm90IHN5bmNocm9uaXplIHRoYXQgaGFuZGxlci4NCkJlZm9yZSBhc3BlZWRfdmlkZW9fc2V0
dXBfdmlkZW8oKSByZWdpc3RlcnMgdGhlIHZpZGVvIG5vZGUsIG5vdGhpbmcNCmNhbGxzIGFzcGVl
ZF92aWRlb19vbigpLiBUaGUgZW5naW5lIHN0YXlzIGNsb2NrLWdhdGVkIGFuZA0KVkVfSU5URVJS
VVBUX0NUUkwga2VlcHMgaXRzIHJlc2V0IHZhbHVlLCBzbyBJIGRvbid0IHNlZSBob3cgdGhlIGhh
bmRsZXINCmNhbiBzYW1wbGUgYW4gZW5hYmxlZCBzdGF0dXMgZHVyaW5nIHByb2JlLiBZb3Ugc2F5
IGFzIG11Y2ggYmVsb3cgdGhlDQonLS0tJy4gQ291bGQgeW91IHJld29yZCB0aGUgY29tbWl0IG1l
c3NhZ2Ugc28gaXQgcmVhZHMgYXMgaGFyZGVuaW5nIG9mDQp0aGUgY2xlYW51cCBvcmRlciwgbm90
IGFzIGEgZml4IGZvciBhbiBvYnNlcnZlZCByYWNlPyBUaGVuIHBsZWFzZQ0KcmVjb25zaWRlciB0
aGUgRml4ZXM6IHRhZyBhcyB3ZWxsLg0KDQo+IA0KPiBTYXZlIHRoZSBJUlEgbnVtYmVyIGFmdGVy
IGEgc3VjY2Vzc2Z1bCByZXF1ZXN0LCB0aGVuIGZyZWUgdGhlIGFjdGlvbiBhbmQgZHJhaW4NCj4g
cmVzb2x1dGlvbiB3b3JrIGJlZm9yZSB0aGUgbWFudWFsIEpQRUcgYW5kIGNsb2NrIGNsZWFudXAu
IFR1cm4gdGhlIGVuZ2luZSBvZmYNCj4gYWZ0ZXIgdGhlIHdvcmsgaGFzIGZpbmlzaGVkLiBSZXF1
ZXN0IHRoZSBJUlEgYWZ0ZXIgcmVzZXQsIGNsb2NrIGFuZCBKUEVHDQo+IGluaXRpYWxpemF0aW9u
IHNvIGVhcmxpZXIgaW5pdCBmYWlsdXJlcyBoYXZlIG5vIGxpdmUgSVJRLg0KPiANCj4gRml4ZXM6
IDM1MzYxNjlmODUzMSAoIm1lZGlhOiBhc3BlZWQ6IGZpeCBjbG9jayBoYW5kbGluZyBsb2dpYyIp
DQo+IENvLWRldmVsb3BlZC1ieTogSWphZSBLaW0gPGFlODc4MDAwQGdtYWlsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogSWphZSBLaW0gPGFlODc4MDAwQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogTXllb25naHVuIFBhayA8bWh1bjUxMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBObyBoYXJkd2Fy
ZSB0ZXN0aW5nLg0KPiANCj4gV2l0aCByZXNldC1kZWZhdWx0IG1hc2tpbmcsIG5vIHByb2JlIElS
USBmYWlsdXJlIGhhcyBiZWVuIGRlbW9uc3RyYXRlZDsgdGhpcw0KPiBwYXJ0IGhhcmRlbnMgY2xl
YW51cCBvcmRlcmluZy4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gSm9pbiB0aGUgSVJRIGFu
ZCByZXNvbHV0aW9uIHdvcmsgYmVmb3JlIG1hbnVhbCBwcm9iZS1mYWlsdXJlIGNsZWFudXAuDQo+
IC0gUmViYXNlIG9udG8gbWFuYWdlZCByZXNlcnZlZC1tZW1vcnkgaW5pdGlhbGl6YXRpb24uDQo+
IC0gQ2xlYW4gdXAgSlBFRyBhbmQgY2xvY2tzIGlmIHRoZSBsYXRlIElSUSByZXF1ZXN0IGZhaWxz
Lg0KPiAtIFNwbGl0IG5vcm1hbCBsYXN0LWNsb3NlIG9yZGVyaW5nIGludG8gcGF0Y2ggMi4NCj4g
DQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FzcGVlZC9hc3BlZWQtdmlkZW8uYyB8IDI0DQo+
ICsrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hc3BlZWQvYXNwZWVkLXZpZGVvLmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FzcGVlZC9hc3BlZWQtdmlkZW8uYw0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2Fz
cGVlZC9hc3BlZWQtdmlkZW8uYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FzcGVl
ZC9hc3BlZWQtdmlkZW8uYw0KPiBAQCAtMzA4LDYgKzMwOCw3IEBADQo+ICAgKiBwZXJmOgkJaG9s
ZHMgdGhlIHN0YXRpc3RpY3MgcHJpbWFyeSBmb3IgZGVidWdmcw0KPiAgICovDQo+ICBzdHJ1Y3Qg
YXNwZWVkX3ZpZGVvIHsNCj4gKwlpbnQgaXJxOw0KPiAgCXZvaWQgX19pb21lbSAqYmFzZTsNClRo
aXMgc3RydWN0IGhhcyBhIGtlcm5lbC1kb2MgY29tbWVudCwgc28gdGhlIG5ldyBtZW1iZXIgbmVl
ZHMgYQ0KZGVzY3JpcHRpb24gdGhlcmUsIG9yIFc9MSBidWlsZHMgd2lsbCB3YXJuLiBQbGVhc2Ug
YWxzbyBtb3ZlIGl0IG5leHQNCnRvIHRoZSBvdGhlciByZXNvdXJjZXMgcmF0aGVyIHRoYW4gbWFr
aW5nIGl0IHRoZSBmaXJzdCBtZW1iZXIuDQoNCj4gIAlzdHJ1Y3QgY2xrICplY2xrOw0KPiAgCXN0
cnVjdCBjbGsgKnZjbGs7DQo+IEBAIC0yMjMyLDE0ICsyMjMzLDYgQEANCj4gIAkJcmV0dXJuIC1F
Tk9ERVY7DQo+ICAJfQ0KPiANCj4gLQlyYyA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoZGV2
LCBpcnEsIE5VTEwsIGFzcGVlZF92aWRlb19pcnEsDQo+IC0JCQkJICAgICAgIElSUUZfT05FU0hP
VCwgREVWSUNFX05BTUUsIHZpZGVvKTsNCj4gLQlpZiAocmMgPCAwKSB7DQo+IC0JCWRldl9lcnIo
ZGV2LCAiVW5hYmxlIHRvIHJlcXVlc3QgSVJRICVkXG4iLCBpcnEpOw0KPiAtCQlyZXR1cm4gcmM7
DQo+IC0JfQ0KPiAtCWRldl9pbmZvKHZpZGVvLT5kZXYsICJpcnEgJWRcbiIsIGlycSk7DQo+IC0N
Cj4gIAl2aWRlby0+cmVzZXQgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0KGRldiwgTlVMTCk7DQo+
ICAJaWYgKElTX0VSUih2aWRlby0+cmVzZXQpKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiVW5hYmxl
IHRvIGdldCByZXNldFxuIik7IEBAIC0yMjg2LDggKzIyNzksMTkgQEANCj4gDQo+ICAJYXNwZWVk
X3ZpZGVvX2luaXRfanBlZ190YWJsZSh2aWRlby0+anBlZy52aXJ0LCB2aWRlby0+eXV2NDIwKTsN
Cj4gDQo+ICsJcmMgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwgaXJxLCBOVUxMLCBh
c3BlZWRfdmlkZW9faXJxLA0KPiArCQkJCSAgICAgICBJUlFGX09ORVNIT1QsIERFVklDRV9OQU1F
LCB2aWRlbyk7DQo+ICsJaWYgKHJjIDwgMCkgew0KPiArCQlkZXZfZXJyKGRldiwgIlVuYWJsZSB0
byByZXF1ZXN0IElSUSAlZFxuIiwgaXJxKTsNCj4gKwkJZ290byBlcnJfZnJlZV9qcGVnOw0KPiAr
CX0NCj4gKwl2aWRlby0+aXJxID0gaXJxOw0KPiArCWRldl9pbmZvKHZpZGVvLT5kZXYsICJpcnEg
JWRcbiIsIGlycSk7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gDQo+ICtlcnJfZnJlZV9qcGVnOg0K
PiArCWFzcGVlZF92aWRlb19mcmVlX2J1Zih2aWRlbywgJnZpZGVvLT5qcGVnKTsNCj4gIGVycl91
bnByZXBhcmVfdmNsazoNCj4gIAljbGtfdW5wcmVwYXJlKHZpZGVvLT52Y2xrKTsNCj4gIGVycl91
bnByZXBhcmVfZWNsazoNCj4gQEAgLTIzNDEsNiArMjM0NSwxMCBAQA0KPiANCj4gIAlyYyA9IGFz
cGVlZF92aWRlb19zZXR1cF92aWRlbyh2aWRlbyk7DQo+ICAJaWYgKHJjKSB7DQo+ICsJCXNldF9i
aXQoVklERU9fU1RPUFBFRCwgJnZpZGVvLT5mbGFncyk7DQo+ICsJCWRldm1fZnJlZV9pcnEodmlk
ZW8tPmRldiwgdmlkZW8tPmlycSwgdmlkZW8pOw0KPiArCQljYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoJnZpZGVvLT5yZXNfd29yayk7DQo+ICsJCWFzcGVlZF92aWRlb19vZmYodmlkZW8pOw0KPiAg
CQlhc3BlZWRfdmlkZW9fZnJlZV9idWYodmlkZW8sICZ2aWRlby0+anBlZyk7DQpJIGRvbid0IHRo
aW5rIHRoaXMgaHVuayBkb2VzIGFueXRoaW5nLiBVbnRpbCBzZXR1cF92aWRlbygpIGhhcw0KcmVn
aXN0ZXJlZCB0aGUgdmlkZW8gbm9kZSwgbm90aGluZyBjYWxscyBhc3BlZWRfdmlkZW9fb24oKSwg
c28NClZJREVPX0NMT0NLU19PTiBpcyBjbGVhciBhbmQgVkVfSU5URVJSVVBUX0NUUkwga2VlcHMg
aXRzIHJlc2V0IHZhbHVlDQpvZiAwLiBUaGUgaGFuZGxlciBtYXNrcyBzdGF0dXMgd2l0aCBWRV9J
TlRFUlJVUFRfQ1RSTCBhbmQgcmV0dXJucw0KSVJRX05PTkUsIHNvIHJlc193b3JrIGNhbiBuZXZl
ciBiZSBxdWV1ZWQuIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpDQp0aGVuIGhhcyBub3RoaW5n
IHRvIGNhbmNlbCwgYW5kIGFzcGVlZF92aWRlb19vZmYoKSByZXR1cm5zIGVhcmx5Lg0KDQo+ICAJ
CWNsa191bnByZXBhcmUodmlkZW8tPnZjbGspOw0KPiAgCQljbGtfdW5wcmVwYXJlKHZpZGVvLT5l
Y2xrKTsNCg==

