Return-Path: <linux-aspeed+bounces-1411-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6959C71136
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 23:01:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJJ185LcZz2yN1;
	Fri, 13 Jun 2025 09:01:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2414::619" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749747664;
	cv=pass; b=mJTbp4S9CY9HTMkc3g7gIdPrBc3Qv7rcptCt4c9rpgPrc6DVdRWz2GaU0D8Qswsu4KGmkADUZdYkpwN0cEdAaKyQNp7JIW4lhq4hoZw8gxhJxUHNNYda87wOUuoTBFLzwfHWlU7RkvFPuHgXYhKglbvcJcufQ+wrOPIB0k1E8zmzDklXnyrnIoiXV9ZChpz2KGjtWq1nlVaFFpdf27VcgNr8yYPDZ1POInKOJXKMmcsuzdNeZXjjbhOiq+xG07LR6oRBXFNlrFgPNVjOyq4UAksWr0lRDABJTCZtU4Hh2ardOQJnU8EYVSWDqZ0eEFmYSmHOoO981W36xxYuA8XWbw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749747664; c=relaxed/relaxed;
	bh=JMWO/dolyexkfDZzc9c1JVUG8YaMHxciEZXAswvSdgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lPzFbni+s7Zk63If5QE/utTb35Amx/2YA94yD4ngSallzpHgH6FHbo452uPg7O3yBo0gvD/LhCeO+BXtzQmZlrz9KQs1QzM4GJud7KfoLaMWZXO7S5nUWPFCJqECS9IRFvPaCQU+JLFTVXsb77JK6ROzcKYlwpJgcuj6KaFXhq6l10XYoZUJWG0aRGKdYyvAEnyQdeHrr2rfUmCp8eS5bbCYJwvoAAXnUa1ECsThCUW7CVzCiZEtwj1w0WnzL06z9tCdTU9xX/OVN37QwlDj7lJLC2HjGHCvVG9SSXVOxVFIcotIahfe3LOkCOTKOD56OtIecb1ns3KlUG/5/HbusA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ILuUAB9H; dkim-atps=neutral; spf=temperror (client-ip=2a01:111:f403:2414::619; helo=nam11-bn8-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ILuUAB9H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2414::619; helo=nam11-bn8-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20619.outbound.protection.outlook.com [IPv6:2a01:111:f403:2414::619])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJ81122n1z2xHT
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 03:00:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfSA47n/FUt9HvoEbXWW84xsGu6kKaTDoUh7r0KsuCNm/wUFXelb9GdhMcyj+K7EtBpBlHsAHh2Zf/pSfZRuB45fQvme1dzs1IKM6UAfI8mNX19lH3QAKut7A2n9XX7SrW/9iqaPIfs0Q7H8M8ImAeUDPmJPHY9jvqzTKVrFDFsqUHv7KOe9PjJbp+buFKk7oglZX+0w1VvbsU4CpRpk0r3Wm5d+1yuGMZZk8zB/nk3+QyQSdWfQMtDthhu9MN/ctlmTa5YlHNGbpJ+6UQd4qz7revaA8KWPS6qDpdokfIsQbIXxHBf2JIEvFLUQLAk21Zja7+DSOxnrqhQ50kq4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMWO/dolyexkfDZzc9c1JVUG8YaMHxciEZXAswvSdgs=;
 b=ttn5qIVaPNJdtBfvH1gYJDRr0gHDPU1xyDSEf9ymfZu+0Oix1amgTqE20QV5rwYp7D/mRubfE9gdhnoOaM8TV330FTzCEdJ2TxitdjsiZfINckVjG+pcFydZIWuRmIu3QC8+ld6HIk7/Xov0nxIHzbQO6Q+E9ZC2tlbu6+0Y6bPp5QvK8uZAF94FwHP0iItppd4U0rUiBUxhs08qmEpQNPKrwAybKudlTetofqsF0ayic3gaAiJCJLhVcYvGYwn4S9FK+D9LhP6QFTxa9ET/dJ0UDWE9GXV63ofFovify4ID/u33Stm0mKqm2li+YxTWchznF9UQig0V7t31EM6ehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMWO/dolyexkfDZzc9c1JVUG8YaMHxciEZXAswvSdgs=;
 b=ILuUAB9H1QLdC6ia4p82Tookhxe5rJ7RRk4IHiKPfHQBsKWrGDGLlA92eSEuznYv2NFAiLFhRO5MNmPJwMZR3xmOINHOIoxafzJ+Xb5kUjT9FKW3Aw/fSQ8abFvKl9rwvMyliUk0QbtsBc0rJV5GksZHlHuKFGcPWHzefV4W5WSyPsfI6lPgyT56S/d9h8P0wnsjrC8zqf08bG9UhHUV8LgHrJw6FhTQSmjaeWToOc3YMo693rW6KWg2+lmuyQ4k1tetGCCp8jll0CAeeWWuzHeeQbaGOj3fEPdPsXpApcBRZwR6XoUB3nNpK8HRWrrTusJwKvmeMdswSVzhxkhlCA==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 16:59:55 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d%5]) with mapi id 15.20.8792.040; Thu, 12 Jun 2025
 16:59:55 +0000
From: Donald Shannon <donalds@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ed Tanous <etanous@nvidia.com>
Subject: Re: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200 UT3.0b platform BMC
Thread-Topic: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200 UT3.0b platform BMC
Thread-Index: AQHb2nB4Wp70Fr2MMkGlisa0WCfUdbP9K+6AgAH+FICAAJVpRw==
Date: Thu, 12 Jun 2025 16:59:55 +0000
Message-ID:
 <PH7PR12MB72826C4B588D08923A512E91D774A@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20250611013025.2898412-1-donalds@nvidia.com>
	 <20250611013025.2898412-2-donalds@nvidia.com>
 <67c89ca729669f55e2659ad8070a154c59ef83db.camel@codeconstruct.com.au>
In-Reply-To:
 <67c89ca729669f55e2659ad8070a154c59ef83db.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|BL1PR12MB5876:EE_
x-ms-office365-filtering-correlation-id: 49634577-5ef9-485b-0947-08dda9d28e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XyqnnuxsfRh+G5se+72bGHllQv1xWwLNd+WeFEkoMawHrKR65PDvsp9o79IK?=
 =?us-ascii?Q?Hze/1RPbE+PTBFfzMr5b+skHFEt5BD0gSua/C20il8QpOPZIzfKm2c31MUa8?=
 =?us-ascii?Q?Fqnvjq1joaev5dmQ3cR5XZJXerNw764aVhAxBnZRTvSzVe9U8vhs5k5QlaLj?=
 =?us-ascii?Q?5HpZEnecRjLvH6ADwoNWmyCd4xm9zP1xnpza6RsKEEHh/g/r0Q7MfBm394Rt?=
 =?us-ascii?Q?f8vawdUvhFClUqpkiUSofEfFCfkOapZxy2UvtII9i4JLv8Y+6La0Ij6J1qq0?=
 =?us-ascii?Q?6emJZna838iuLhtEV0Qm/ofUEqdO8T0TZ3cjqDmpmZe6Gl9GgnghtmBTseD4?=
 =?us-ascii?Q?KqdY9l2odCXjrZ9nQa9DsCgWf8BglaMYxa2e2xmFWNP3xi87oVfbI4Mr7nMX?=
 =?us-ascii?Q?e9lBD73Ngr96+bUZqICq6oOhwu3uePlp8cxG+fimbZ2Zb8NDdlD7rCOA8r+9?=
 =?us-ascii?Q?yuzT+VgnvGu2mK4NK+UqaQlCXgRqgkZLOZ9xmrEWMVceIROqBmhZUdu0afaP?=
 =?us-ascii?Q?hePjqHP3G7zXLUTZJvcJNX6goWrdztreyuaEHPfeAVwD+79myJKzZ8InqTNd?=
 =?us-ascii?Q?MVjM8pgZ9ywrF+Iew1xSktoNJDPhf0InPuWQ63s6ymp4AHK93ppEdUGKCnDV?=
 =?us-ascii?Q?NfeLziEf1QsPy2iJGGKWay1ktYQ7qwceX67J4iEv7TyTOfHXqosVIy2xWVeE?=
 =?us-ascii?Q?8RZiMsXuA5TKEV8WIUU/HaLEO1BAsO7mDfwwSa+A53tvtydZsEK+7SkLFPoX?=
 =?us-ascii?Q?ZLPPvoKc0a5swJJ4RDpDsQZxhUfZ0jfgVRqoi0Kx1A6NHHKTGMGRmJyiTDFJ?=
 =?us-ascii?Q?s6UlQAALCBhUrDhV08iAZYje6bB+BRlp+pjA5cmnOE1tfhHvjq+5rBuEwFYb?=
 =?us-ascii?Q?8mllnPWeE+vp3S0v06SzARdvWY1Baohbz74mDYeH0KjfHQeZgjloXtBIH85q?=
 =?us-ascii?Q?3WHINKwJc6Ysiwht6Sa/ntXHi3jTKHxHHxsmmkdc/97KtolVwZxq1wVuf3av?=
 =?us-ascii?Q?L6qCppOEtLNg9pElhLhy77W+apNHgw0E648/IHxDOE9fOAICWxu0VWDet21U?=
 =?us-ascii?Q?ELKIg6p4injIQy/aZnNrFK0+puh4XkvTkrVg8qEOu2LxPQIw0tzKrgCptMUS?=
 =?us-ascii?Q?dZRqEPl4oe9vjbUE0fIbiGlYRJnRF+dQzBUdo5Zu46T35M/VVk8oV1+t6DJQ?=
 =?us-ascii?Q?sFpF5J2Wfz6xiZ2v0P8CCH5a6+DrRr2HiQH09HWw1S9e2U5hOmMb1XscPxsS?=
 =?us-ascii?Q?+CtLQWjww8oTS9QXmBEK0SxYBuX3KBqoGTZfKGicVup8bRYdrJGrkdbYsdXy?=
 =?us-ascii?Q?PfLSLBj1eK9nt9gwkoNeNmo8v/Bt7+dnOP0L1Taub+mi/zm5jTeYTdCuywX0?=
 =?us-ascii?Q?ttdLRGBmp5kM6Am/IWPg6J5OXozxoy5Ae93DlDGdvIa/+IfMQ+T0XMUfvDNk?=
 =?us-ascii?Q?nprpRXU4b0sTbQq2QtdDEqIYVDfTvi9L/WS+VbACAMBcZBv4HewsY1BFVv4Y?=
 =?us-ascii?Q?iBQTZFm9aVOmLEA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s3NOeJSHTkV7/+GrbU5/IFMBpsN9Hsvmj/TiZvcflabTXONmyANbtfkonC+C?=
 =?us-ascii?Q?5jE9c9BonfyGz29QVSPryHefFR8u7QfZ5TVBgLypKqNckjDC0qVFUBDxc7Vu?=
 =?us-ascii?Q?vAx9Jcggw/PyZjjDKBD5rXWuBwZIhBIN+oC0wGmaPC+N6/Hf0jnuRaB1nCzo?=
 =?us-ascii?Q?9u6wglUK65l4XCHkRTHzrENPx3zgmwmfg+XhDB6i9C0LRdpts7hSCnz4K3+W?=
 =?us-ascii?Q?fzuP4gI6SBdGDsH3ew53bvEw+M8JgONaTmwha/HL4qGDNp0AISIlvGC2l4la?=
 =?us-ascii?Q?HquF9oKhq7b+4FFlIIEvdX9fjKICe8BVoGvzHA+uRuc9RtmoxzgFn6FSNPI7?=
 =?us-ascii?Q?FpbOg51gibC6mWcJK+Dj+hD5RPdA1w4ynC8UTHNzd1JnGnNQbd6iCYlFqoBE?=
 =?us-ascii?Q?vudA9YPZfzgcy+nF7vtTn6heqlVdwwauA2aBzoHEl9PDegHD9LdvWEkc4vEC?=
 =?us-ascii?Q?XJLjFEBD/Q4WHH8n4cxiDRIGlUeBryUBuNfXfhkuKzjTuuAwcJWlEGRhj9QS?=
 =?us-ascii?Q?kYwuRZOgejq1FlEQTJBTXbRCnCuRq/W1BQOvqFuCy5R4od+ExgU6f6BPdl9A?=
 =?us-ascii?Q?zPiI+Skb0RoXXZXbAHz7EIbBbE5+QRE/4OcmL4igfyZUPdtQZZH12K/5vQ/A?=
 =?us-ascii?Q?0M1RqXNRuq8wAfUJMq7oafy05fbdvGZZQ1FGcpvJbdaDuIhTK5Gw34+UkaiV?=
 =?us-ascii?Q?shhJ+O7D5qD0SDqLQntyH+6FbmJygxczowaFhvp9TjnkX7lesIv5wPU0Kta4?=
 =?us-ascii?Q?ygZmL8qEWlNUhcmZGG91IeLWkv16JB5AJTNa+KmGNm+rAZPa01E/DgPmOOjq?=
 =?us-ascii?Q?kgfeyfwjF6Nd6vEGO17PUeWe03M+9YjK3oG1ISSide1si5g4/25oQQSqO2Wi?=
 =?us-ascii?Q?xlWjo8VO4sVuoqZgbh3NrVhSQ7QYEyaHg5ekpsGJ1vRCQ4J9HkM8srin03Fd?=
 =?us-ascii?Q?qrK2nri8+GHjU1ze4K7q1bEPzegRsdlAAiUlwLI67+y/6VV6poEGvezJ+/F7?=
 =?us-ascii?Q?5tBHZ8Zw+V4JjUTAONMXP7mUnN3zhFnD2C4jExLncVcia4fY7fgQsAG+/xDG?=
 =?us-ascii?Q?7E+cV1kLAinvAUCRyu8nZi/s3ZO/usbTRCVlKMSZAhXMK42u8Sd1WYRyW68D?=
 =?us-ascii?Q?zChBOKF+429ObqTxnfVWPEEJekXGJwMqAY938aKeevI41Gl+4qulrBpHm8Gc?=
 =?us-ascii?Q?T3vo0lsRzWp4rggHEwOivKQZ5+9MiooXIrDriktPEBZkt1dO69g3kXv3tEAh?=
 =?us-ascii?Q?tJWsrdZPxw6cbIViCT3ZqZtPwU2gI5LjmDH5YomSQvoAYzcSxJSR490YLKWz?=
 =?us-ascii?Q?AskknOFUUro/wNo7PctH6r0/Eb0uOJz0Z/8Bl0B6VCHMMS5XpJgiY8xpIcZG?=
 =?us-ascii?Q?Tn3P2YfWk7rX7R7bnYi27vRMSraBf+1Nv7KMza+w5oj0eaxATYWyrDxtJZ1O?=
 =?us-ascii?Q?o1cuoQraqitL7z6ha77vxa3winB5LI786EWc46u+Ivb3c4sqdm2fDjfGIumb?=
 =?us-ascii?Q?y0fFh3KoO4lVzXFG47PdpyHNWAuJ94f0H+/33Z53EMtBwhejcISMpZ0v5HLR?=
 =?us-ascii?Q?+FavT3gsjLD3/GYkBA/I5FQ9HiaXMarXqOf/O5OqYS0/etSZt8RHeGSOwEmB?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PH7PR12MB72826C4B588D08923A512E91D774APH7PR12MB7282namp_"
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49634577-5ef9-485b-0947-08dda9d28e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 16:59:55.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gol/BnGHoooSDOREyM7Pl/dBmv1lahd1nmTvlyDog7S4ycG1s21aIgQCICs62QsvXLOYrntVn/8z8jgfAZ4EIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876

--_000_PH7PR12MB72826C4B588D08923A512E91D774APH7PR12MB7282namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andrew and Krzysztof,

The difference in this device tree is adding more GPIO expanders and changi=
ng the networking.

Would it be best practice to create a new device binding (in this case nvid=
ia,gb200-ut30b), even if it is just a slight modification on gb200nvl-bmc? =
Or can I reuse the gb200nvl-bmc compatible string and avoid the yaml bindin=
g change all together since it would share the same drivers?


Donald Shannon
Data Center Systems
NVIDIA<http://www.nvidia.com/>

From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thursday, June 12, 2025 at 00:56
To: Donald Shannon <donalds@nvidia.com>, robh@kernel.org <robh@kernel.org>,=
 krzk+dt@kernel.org <krzk+dt@kernel.org>, conor+dt@kernel.org <conor+dt@ker=
nel.org>
Cc: joel@jms.id.au <joel@jms.id.au>, devicetree@vger.kernel.org <devicetree=
@vger.kernel.org>, linux-arm-kernel@lists.infradead.org <linux-arm-kernel@l=
ists.infradead.org>, linux-aspeed@lists.ozlabs.org <linux-aspeed@lists.ozla=
bs.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, Ed Ta=
nous <etanous@nvidia.com>
Subject: Re: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Nvidia's =
GB200 UT3.0b platform BMC

External email: Use caution opening links or attachments


Hi Donald,

In addition to addressing Krzysztof's comments regarding checkpatch:

On Tue, 2025-06-10 at 18:30 -0700, Donald Shannon wrote:
> The GB200NVL UT3.0b BMC is an Aspeed Ast2600 based BMC
> for Nvidia Blackwell GB200NVL platform.

Can you add some words contrasting this platform to the one submitted
by Willie?

https://lore.kernel.org/all/20250401153955.314860-3-wthai@nvidia.com/


> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
>
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> Link:
> https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
>

Please omit the blank line here so the Link: tags are part of the
trailer.

> Signed-off-by: Donald Shannon <donalds@nvidia.com>
> ---
> Changes v1 -> v2:
>   - Changed phy-mode to rgmii-id [Lunn]
>   - Removed redundant max-speed for mac0 [Lunn]
>   - Fixed typo from gb200nvl to gb200 in Makefile
> Changes v2 -> v3:
>   - Fixed whitespace issues [Krzysztof]
>   - Fixed schema validation issues from my end ( there are still
> issues with the aspeed dtsi file that are not related to this new
> dts) [Herring]
>   - Reordered to follow style guide [Krzysztof]
>   - Removed redundant status okays
>   - Changed vcc to vdd for the power gating on the gpio expanders
> Changes v3 -> v4:
>   - Added changelog [Krzysztof]
>   - Added nvidia,gb200-ut30b board binding [Krzysztof]
>   - Removed unused imports
>   - Reordered a couple other style guide violations
>   - Added back in a couple needed "status okay"s
> ---
>  .../bindings/arm/aspeed/aspeed.yaml           |    1 +
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1154
> +++++++++++++++++
>  3 files changed, 1156 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-
> ut30b.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index a3736f134130..420fabf05b24 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -98,6 +98,7 @@ properties:
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> +              - nvidia,gb200-ut30b

For what it's worth, checkpatch reports at least the following:

   167: WARNING: DT binding docs and includes should be a separate patch. S=
ee: Documentation/devicetree/bindings/submitting-patches.rst
   180: WARNING: added, moved or deleted file(s), does MAINTAINERS need upd=
ating?
   193: WARNING: DT compatible string "nvidia,gb200-ut30b" appears un-docum=
ented -- check ./Documentation/devicetree/bindings/

Thanks,

Andrew

--_000_PH7PR12MB72826C4B588D08923A512E91D774APH7PR12MB7282namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr" style=3D"font-family: &quot;NVIDIA Sans&quot;, Arial, Helv=
etica, sans-serif; font-size: 12pt;">
Hi Andrew and Krzysztof,</div>
<div dir=3D"ltr" style=3D"font-family: &quot;NVIDIA Sans&quot;, Arial, Helv=
etica, sans-serif; font-size: 12pt;">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: &quot;NVIDIA Sans&quot;, Arial, Helv=
etica, sans-serif; font-size: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">The difference in thi=
s device tree is adding more GPIO expanders and changing the networking.&nb=
sp;</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;NVIDIA Sans&quot;, Arial, Helv=
etica, sans-serif; font-size: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;NVIDIA Sans&quot;, Arial, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Would it be best practice to create a new device binding (in this case nvid=
ia,gb200-ut30b), even if it is just a slight modification on gb200nvl-bmc? =
Or can I reuse the gb200nvl-bmc compatible string and avoid the yaml bindin=
g change all together since it would
 share the same drivers?</div>
<div dir=3D"ltr" style=3D"font-family: &quot;NVIDIA Sans&quot;, Arial, Helv=
etica, sans-serif; font-size: 12pt;">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"color: inherit; background=
-color: inherit;">
<p style=3D"margin: 0in; font-family: Calibri, sans-serif; font-size: 11pt;=
"><span style=3D"font-family: &quot;NVIDIA Sans&quot;, sans-serif; font-siz=
e: 12pt; color: black; background-color: white;"><b>Donald Shannon<br>
</b>Data Center Systems</span><span style=3D"font-family: &quot;NVIDIA Sans=
&quot;, sans-serif; font-size: 12pt; color: black;"><br>
</span><span style=3D"font-family: &quot;NVIDIA Sans&quot;, sans-serif; fon=
t-size: 12pt; color: rgb(190, 255, 70); background-color: white;"><b><u><a =
href=3D"http://www.nvidia.com/" target=3D"_blank" title=3D"http://www.nvidi=
a.com/" data-outlook-id=3D"74b95ab1-c9cd-49be-a323-2d817e96d4b9" style=3D"c=
olor: rgb(190, 255, 70); margin-top: 0px; margin-bottom: 0px;">NVIDIA</a></=
u></b></span></p>
</div>
<div id=3D"mail-editor-reference-message-container" style=3D"color: inherit=
; background-color: inherit;">
<div class=3D"ms-outlook-mobile-reference-message skipProofing">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server" style=3D"col=
or: inherit; background-color: inherit;">
</div>
<div class=3D"ms-outlook-mobile-reference-message skipProofing" style=3D"te=
xt-align: left; padding: 3pt 0in 0in; border-width: 1pt medium medium; bord=
er-style: solid none none; border-color: rgb(181, 196, 223) currentcolor cu=
rrentcolor; font-family: Aptos; font-size: 12pt; color: black;">
<b>From: </b>Andrew Jeffery &lt;andrew@codeconstruct.com.au&gt;<br>
<b>Date: </b>Thursday, June 12, 2025 at 00:56<br>
<b>To: </b>Donald Shannon &lt;donalds@nvidia.com&gt;, robh@kernel.org &lt;r=
obh@kernel.org&gt;, krzk+dt@kernel.org &lt;krzk+dt@kernel.org&gt;, conor+dt=
@kernel.org &lt;conor+dt@kernel.org&gt;<br>
<b>Cc: </b>joel@jms.id.au &lt;joel@jms.id.au&gt;, devicetree@vger.kernel.or=
g &lt;devicetree@vger.kernel.org&gt;, linux-arm-kernel@lists.infradead.org =
&lt;linux-arm-kernel@lists.infradead.org&gt;, linux-aspeed@lists.ozlabs.org=
 &lt;linux-aspeed@lists.ozlabs.org&gt;, linux-kernel@vger.kernel.org
 &lt;linux-kernel@vger.kernel.org&gt;, Ed Tanous &lt;etanous@nvidia.com&gt;=
<br>
<b>Subject: </b>Re: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Nv=
idia's GB200 UT3.0b platform BMC<br>
<br>
</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;">External email: Use cau=
tion opening links or attachments<br>
<br>
<br>
Hi Donald,<br>
<br>
In addition to addressing Krzysztof's comments regarding checkpatch:<br>
<br>
On Tue, 2025-06-10 at 18:30 -0700, Donald Shannon wrote:<br>
&gt; The GB200NVL UT3.0b BMC is an Aspeed Ast2600 based BMC<br>
&gt; for Nvidia Blackwell GB200NVL platform.<br>
<br>
Can you add some words contrasting this platform to the one submitted<br>
by Willie?<br>
<br>
<a href=3D"https://lore.kernel.org/all/20250401153955.314860-3-wthai@nvidia=
.com/" data-outlook-id=3D"25bb85d4-0d9e-45a9-9d87-75a75b551e41">https://lor=
e.kernel.org/all/20250401153955.314860-3-wthai@nvidia.com/</a><br>
<br>
<br>
&gt; Reference to Ast2600 SOC [1].<br>
&gt; Reference to Blackwell GB200NVL Platform [2].<br>
&gt;<br>
&gt; Link: <a href=3D"https://www.aspeedtech.com/server_ast2600/" data-outl=
ook-id=3D"798e12bb-570f-441b-9f24-011735a05fe5">
https://www.aspeedtech.com/server_ast2600/</a>&nbsp;[1]<br>
&gt; Link:<br>
&gt; <a href=3D"https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-33=
84703" data-outlook-id=3D"36bd268c-bf9b-4a43-97af-cb0929bdec04">
https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703</a>&nbsp;[=
2]<br>
&gt;<br>
<br>
Please omit the blank line here so the Link: tags are part of the<br>
trailer.<br>
<br>
&gt; Signed-off-by: Donald Shannon &lt;donalds@nvidia.com&gt;<br>
&gt; ---<br>
&gt; Changes v1 -&gt; v2:<br>
&gt;&nbsp;&nbsp; - Changed phy-mode to rgmii-id [Lunn]<br>
&gt;&nbsp;&nbsp; - Removed redundant max-speed for mac0 [Lunn]<br>
&gt;&nbsp;&nbsp; - Fixed typo from gb200nvl to gb200 in Makefile<br>
&gt; Changes v2 -&gt; v3:<br>
&gt;&nbsp;&nbsp; - Fixed whitespace issues [Krzysztof]<br>
&gt;&nbsp;&nbsp; - Fixed schema validation issues from my end ( there are s=
till<br>
&gt; issues with the aspeed dtsi file that are not related to this new<br>
&gt; dts) [Herring]<br>
&gt;&nbsp;&nbsp; - Reordered to follow style guide [Krzysztof]<br>
&gt;&nbsp;&nbsp; - Removed redundant status okays<br>
&gt;&nbsp;&nbsp; - Changed vcc to vdd for the power gating on the gpio expa=
nders<br>
&gt; Changes v3 -&gt; v4:<br>
&gt;&nbsp;&nbsp; - Added changelog [Krzysztof]<br>
&gt;&nbsp;&nbsp; - Added nvidia,gb200-ut30b board binding [Krzysztof]<br>
&gt;&nbsp;&nbsp; - Removed unused imports<br>
&gt;&nbsp;&nbsp; - Reordered a couple other style guide violations<br>
&gt;&nbsp;&nbsp; - Added back in a couple needed &quot;status okay&quot;s<b=
r>
&gt; ---<br>
&gt;&nbsp; .../bindings/arm/aspeed/aspeed.yaml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; arch/arm/boot/dts/aspeed/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts&nbsp; | 1154<br>
&gt; +++++++++++++++++<br>
&gt;&nbsp; 3 files changed, 1156 insertions(+)<br>
&gt;&nbsp; create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb=
200-<br>
&gt; ut30b.dts<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml<=
br>
&gt; b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml<br>
&gt; index a3736f134130..420fabf05b24 100644<br>
&gt; --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml<br>
&gt; +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml<br>
&gt; @@ -98,6 +98,7 @@ properties:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; - inventec,starscream-bmc<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; - inventec,transformer-bmc<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; - jabil,rbp-bmc<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; - nvidia,gb200-ut30b<br>
<br>
For what it's worth, checkpatch reports at least the following:<br>
<br>
&nbsp;&nbsp; 167: WARNING: DT binding docs and includes should be a separat=
e patch. See: Documentation/devicetree/bindings/submitting-patches.rst<br>
&nbsp;&nbsp; 180: WARNING: added, moved or deleted file(s), does MAINTAINER=
S need updating?<br>
&nbsp;&nbsp; 193: WARNING: DT compatible string &quot;nvidia,gb200-ut30b&qu=
ot; appears un-documented -- check ./Documentation/devicetree/bindings/<br>
<br>
Thanks,<br>
<br>
Andrew<br>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB72826C4B588D08923A512E91D774APH7PR12MB7282namp_--

