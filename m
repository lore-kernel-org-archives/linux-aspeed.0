Return-Path: <linux-aspeed+bounces-1301-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8312C5AD49
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Jun 2025 00:46:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBpmq2rWPz2yKq;
	Wed,  4 Jun 2025 10:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748997995;
	cv=pass; b=Z8jMtyEL1ZpC7OW5zahNH0SCkDteNQE+u0bzbps47oAPh0PiJnVxP/xKLzLT4l/USCaplEU0upjNirAMswrqG9iOb00Lu1ru1gZe7hAuG65S+ssl2hyJBVLLu8F5td9vKLdhJ+4Q9pJIcsD7s6Uqr3ikr8cPiR3dEV9tXKjmvypjqxH3d9PyjwEGMu9EAh2ooVkGrOJ6XSL1WOjaZrcxbsbayDUYb206sO3XJmcbRC9WxypLGAYwmnoi48G540TnZqIKmclfoiwpD1bdaxpU5+TN39R7OqLXvYa0ie9L1+t5haCVIPVUCzSmc35H1UCUz2XD+eGS5lxcjVTYAGgdmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748997995; c=relaxed/relaxed;
	bh=MLwfib8OaHjzoROki7ANG0RC4DDeyVmqfOY3ZSJYxD0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9nUvWA2gYumBMjM9TuJbPhsTl9NQcQXEbdHkm8d5ROYnIskk7Y3ontT/ylpZoHx2+OJH9x/aA3MsT2Rj01vzalmJVtyk20dScjLwgekJWvejledCglJM7zBO+Nnqm/xAdGuLYhkAnNFUULhZTrW/GmaZTYZk2wsAqVBZH4h9E68s2hCnDuyzSMorY+OVvHbYnNeaLZTFxZ7A1fnapa4ciw2mil8t4JXEYxm6lMBxUUoIHkIgBI0ropVzNHQ8vrYRXpR0iHPvX1/I+GkZEzSlbXhE72adFA8URXZvav/ZeEOoXfUhmyFsfuc4wpeEwlibkB++ezCHmsTVSSsHjYROQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=gBJJYoQe; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector2 header.b=gBJJYoQe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBpmp58JBz2xYl
	for <linux-aspeed@lists.ozlabs.org>; Wed,  4 Jun 2025 10:46:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXDURuGrqodRsdrBbk2krzZkrob6RfwCe8f5YhnxwFH5OuEeNTE03RuQYpa1cUcKND7mdz08xe4LdpjgkaZQcoJNhtui0lNnznNvSoNoCoYyKf6OM+DT/nEnGCHLlwH8VdHNiIz6/F/aIqavHFf0HKsEOjjBa60uZU0KiAiWL7a7nNd4gsBOCVO2p37kc0GSeQdQ6r+hWa4fYoUHd8PPIdXToB67xIxf97Kmhyo2lNQfkNtlznxTIGoXg3jTPU6sr96863CKAzLMvsZlIaXFCiPcC+FJPjPnRMTNUjEwy/NXV8dfxTt7q3lTaXr+cChVjXTRPBwcnpxDxpVC9kOkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLwfib8OaHjzoROki7ANG0RC4DDeyVmqfOY3ZSJYxD0=;
 b=b0YIjuKgAUqsgWpW98zYXTf5Mv34SgBvSDakL3HD6rt1Wh2Gvp6VF0PJ9LhYL41ohF83R9oB5CPeVwZ4Ct6fTQwd9S4QfE5bpDPaHOn5WcdP3qFkBPEn8ldQIQXR/Md63J9hbUO0Y9zhXUI7TCPYlsRgPoq9tD0Cq8eJ2nh6olsl2eThD8fvwEu3UhxJ42voSpSMSY0tobiNhTvrqXW4tEIqowuk1+M41YQYiu2dZXs0GxrQlL2Zk5Puo9+PSVLgKoyCsAIGh5YGa4g2ffbZkaIPzNSnP/5yTEIb/khWbmQBFVU0OmmScmAQ5BRR8WvAXw/deiV4p5URxMTdJe5hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLwfib8OaHjzoROki7ANG0RC4DDeyVmqfOY3ZSJYxD0=;
 b=gBJJYoQee3mAuWjeXpQfGTWaeFDlNK8V0bRmNdiPRwfbgTsgKfZzaXYvGZWUV0so3TviAnPGlheSY5IJH46E2+/iNJ8sALQsd0z0slIdf7Wg/IwVfbQ11gY+j71XcO5jirBDLVthv7XI72RFzBXw//QZlOueymq/mRMjXOsespdx7V5AAida6JIBhl250eqkFxmseJz1Q+sRk8Zx78W1vLDUucAvF4JtMzozDnk6LDWyl7jIP1pazDktNpxpqd2HxAQXErZ979XkIWMClgGUWUOMCDV9ESZ4ak+3aQKFz1XklpVHfWH0EUF1IIOQG96c7DdLtXVBB0JfxyjDwSYjDw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SE2PPFD1755A465.apcprd06.prod.outlook.com (2603:1096:108:1::7ec) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 00:46:12 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%5]) with mapi id 15.20.8769.033; Wed, 4 Jun 2025
 00:46:11 +0000
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
Subject: RE: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Topic: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Thread-Index: AQHb1FzMRCeMloEvSUe4D9FkwuM83bPxKXCAgAAIIwCAAPe7kA==
Date: Wed, 4 Jun 2025 00:46:11 +0000
Message-ID:
 <TYZPR06MB656889259D6BE8846E2A1F65F16CA@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
 <20250603075450.133604-2-jammy_huang@aspeedtech.com>
 <273da934-deeb-4129-917c-5d7038930941@kernel.org>
 <a8c4ec8e-51bb-48f3-a47a-b7a848a44951@kernel.org>
In-Reply-To: <a8c4ec8e-51bb-48f3-a47a-b7a848a44951@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SE2PPFD1755A465:EE_
x-ms-office365-filtering-correlation-id: 96c0c016-898d-46be-ae6c-08dda30133f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Rboir63XuhvKIzaEU/ZXp9ximFYvByOLInZWYy1B+Wvn6BRzY9hfG7Q2xB7r?=
 =?us-ascii?Q?XWxsKnmkh+f2/1fyS32Y1Pj0rE8nZsn9gi4pxOOJtOLiF7GDLRRG8WDczudJ?=
 =?us-ascii?Q?EhaHJUn+S05tKDpyx8Or/cBA8il7mdvrCDPZ5ZdJjJLigEPQtMKnnBP5XeCN?=
 =?us-ascii?Q?g2lYjEJFTdmwdMNI29Jki1OTpy+/9mciEryOqVWfuhGH8bXNkVyXkTA+xkKv?=
 =?us-ascii?Q?AJXE4yHvIQYHhaGZRC45TcNHbSBfKr93TCKY/9Pu1yxoPmwB1ZeP+UHPVDkH?=
 =?us-ascii?Q?BY8nYD6FcaXtn3Za2BZkETiIE8T8E64mB6aiksgD30hZIxTZgbrxNIDHA2ok?=
 =?us-ascii?Q?H9Sq+pesE8ffYw+LHtWLdmm0zk6E6Mk9zAbPqRxMaxSaH5V1+IZpmKnjVYAR?=
 =?us-ascii?Q?8H9xZVYerE8nVB3XcGZhbzXRcLpfUgS6xnQKgt9F04Bk8EldvQTDE7QwRflh?=
 =?us-ascii?Q?TsN+76mVEV4ob6HxNI6b5Tm7SBJDcMqfKAMqzWHOG5nbdZbY9OTqajSEat5x?=
 =?us-ascii?Q?h1XCmaZ/xlnG6D1nByRsT/G+VQTRibeS2fm6bmjHefsEf5A5ZqhNRmUAfImK?=
 =?us-ascii?Q?F+REeslKrxuXHlR/35CEjf+88B/N+FDatojCh+LEBt2sePgFT/eQY2CvtXNH?=
 =?us-ascii?Q?s3cyrnNZ2a7OeBwdTzOkveLXCaasZo9vEAmsS0wFoiFoCT0ufN2efU0hVdWf?=
 =?us-ascii?Q?3K1Zn5e2X1iP7N+xBGnNPJCDuyfYqI1EXhPo49u6V/QG0SzzAO8OWFtMyyVq?=
 =?us-ascii?Q?kZ1qwgtuH4AZT+ptDMn8elK/EI0R0qM6tKdHGkOq+avL8IzjlCRU6XQy4wZ/?=
 =?us-ascii?Q?XqLiQOdSPFXEzpkCI2bMHsKF1nlkSqZcSsDxqQmly9zsY9yyLmxfmxq+o2dT?=
 =?us-ascii?Q?HYreK6bbSNd1sW+wu7Bu5ARh2Cr8YydpmjC4kcAQ3w+oaIAMN0mqrbusgiQx?=
 =?us-ascii?Q?7Ty8TPshvo891dkSv6Ne0qlWTDDgAgFl7L+N3jppJvweAkDAqJg20LESZ+gO?=
 =?us-ascii?Q?tvzkj98d9pV6yalyQyCIdmu+joumQfHv7FRmhZzQJQ8IX7SK+08yKJxqX3+f?=
 =?us-ascii?Q?dehkYuIwOd2U7E0lBVXMTDyk49jeNmsMokfpcInPyC+3F9AYGwEV0FgKvf3n?=
 =?us-ascii?Q?mPBwwke6ceaP0xSulmk92mq8W+EIZJKJxexMrzT8Gduw3h1TGEv7o2SdkT/w?=
 =?us-ascii?Q?J7I6BAZYdr8w773/O5zUaDkJru1dvlwiw4vbbxEIxkqW3wPFSexc0p9SwyjA?=
 =?us-ascii?Q?swga6ACv9MnOQSv2DSwaHYbBU3z9g6OMAOItKy/FRNkw7R0+G6XuNcDfqxoI?=
 =?us-ascii?Q?wcQ7wSDUww4xnwEMAKVjmD60naTIJoXCyM+lypIyFUii6Cd3W8m1jO5EH5o7?=
 =?us-ascii?Q?51VLlQscqA+A4c0cVimvxXr25qV6faSG0eXasWDycjCvgRGTnCanY54Wevwe?=
 =?us-ascii?Q?A1Q4SvRpV1yQ2v6CYNIaqpKqcugk26yn1KzENP+N/FR0CVuLzArmWVtKDGwV?=
 =?us-ascii?Q?rXfc9nZpKPF59Fw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ep2FqF/lhgD2NbOjEensUDipfw2fn6rUp5C4T2ITROzsLIiOmtH0TC75Hhs6?=
 =?us-ascii?Q?eqhzAt9Cp9YF5qptF/LjLFOhOcabSbFNFEa6ZKrd3vpY7JIMJNXtZvn8zrpV?=
 =?us-ascii?Q?7b/5WA0uT+q8wNs7It9xlb2EOJl9CHBOeSYhATv4TwLMbmAF6pQ4Kg6iOwN+?=
 =?us-ascii?Q?m5tOmsGgZzy456JtUpwPIHx2e7lLZ582MvC5gsAvvyouR77h9tR1jCtNHGjr?=
 =?us-ascii?Q?thIs11/pRE6YMLd2cK7DqjaNN3e47snUVsjl/QiFCmiPEWRuPi0k6nYlw/Gs?=
 =?us-ascii?Q?hDzD/NZzUZlU34Zfy6g9tPDFC3NrJEJWf5z7cysKVCWRkOm2Ua91lf9Lvoij?=
 =?us-ascii?Q?nXAsguNBGzqtW+rwhaiaKA87yUFKI53EiqZKXvjae1deeakx7+S1xX7rn7+g?=
 =?us-ascii?Q?eHD9emiCPlG2PQk+rmwnlhu2r9x5QtwxSlsqfJSP/xsBIlN2tEOs1Mpzeb2o?=
 =?us-ascii?Q?HpqBZjIn77z5GGk8du1o/7mHiUTKzqkkcQLr5jh9U9pbF58WuGl0FXm8Dtih?=
 =?us-ascii?Q?i+DDh7u11L8o7zxt2WtKPbQ5VS1ASPffWb98fTZsMx4SONS7VkeJFSugTIYI?=
 =?us-ascii?Q?jGT39nUy1hXPXhsd7JxftZzNu341gPKMjIPufafBX6zlk5/zGBCeqHal7NeM?=
 =?us-ascii?Q?1vTVjtjAghGqR5ML/3eDJwYQ0ri2wlRkoqZ+JNYi9D+U1FddQPeqrk6a50YH?=
 =?us-ascii?Q?iZatJNdXpgrkGqHF/JqzSr8nGrXttfAGce2MEnccjXeZ4+rffsOJpYCx+MfP?=
 =?us-ascii?Q?ROBGpLkrvmLTcwndCZvmpomSORj4mTN0HHCvwbjEkxMec4tc6NnzURMavnhs?=
 =?us-ascii?Q?wr8763HSPi/Kb/x6dAvxWAzcH1rw+SALiuFX8gDKStnc2JiDAezN/FBCTXzN?=
 =?us-ascii?Q?VQ+9jTIAY+1N7oMMHezAKfvpouCsCOxl+e3i1iAnb24yXB/biTlL8m/XwCaz?=
 =?us-ascii?Q?ysakA9KfVsoVyw2fAWnp8BuBoCUuN+sXIyw+niJEf8s95kVkeM7S2V71dyOR?=
 =?us-ascii?Q?1vn2ogW3kf/WsvYota5Ot1dQf3VsFFpz0Pf94gWEMI1R58A/6+Mj1dogrAM2?=
 =?us-ascii?Q?xvgquA6l0nlFNKjyk6evkbs4nN6dg2eU581LdMZTt1xxkGvZDAPWFIcWyOQ6?=
 =?us-ascii?Q?drRR0rBHglt7d/aJ61F7FuYNqhNw09a1B2fmtsgZSuccZF6cRjbVA08+Wqi6?=
 =?us-ascii?Q?XJwNEhnn7E/xES+6kS+BmkWDP5XtnS15Mw/AvOCfCixmgU1smczsy9BePFnT?=
 =?us-ascii?Q?WE7G/Y594jwh9bwPR47stLZ80lurrZr989JR28i20cT4ifzk92/XUO0UqqNm?=
 =?us-ascii?Q?r+W9O56oNc2Nu9D6TTDMz4iNuAKQNEPUwkUHXWKYfwJpEJgIqWBeqN27n+3j?=
 =?us-ascii?Q?2M8EHcdMkRy4ml9MaxfCIYUw3qOjMGN1eIjBaBVAGbqxFrvwGO9oUa7WpA2x?=
 =?us-ascii?Q?AZfvaif5s/7Wx4KNKK99SzESD0lFItnVAM620oFRcj95MDEGNf/JiQDuiTRM?=
 =?us-ascii?Q?z6/RueVt3TQb0H9IeoUcBWlr/LGQ3JGWN8kh8Azvqkz/wGtHnuNKqQcLfTIu?=
 =?us-ascii?Q?sapozCoJCfH6IHYzLaOdLOP/4lTiDyTyRtAsmx7W+Sc4bPNNsjcyRR7K73Lx?=
 =?us-ascii?Q?Tg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c0c016-898d-46be-ae6c-08dda30133f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 00:46:11.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG7PoAjKy3Z7PV6FMMBGx8Qorx/A0STzxil9XMPgGyiyGDQhEqyc2++xPsUS+m7sNfeV67oSF6VXfwb7M/v5B6bwH9gyw+fwj6YdUtUDU1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD1755A465

> On 03/06/2025 11:22, Krzysztof Kozlowski wrote:
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +  - "#mbox-cells"
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> +
> >> +    mbox@12c1c200 {
> >
> > mailbox@
> >
> > With these fixed:
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Huh, not tested.... so obviously un-reviewed.
>=20
> Test your code BEFORE you send, not via community services.
>=20
> Best regards,
> Krzysztof

Thanks for the review.
I will update accordingly and make sure test passed in later patch.

Best Regards,
Jammy Huang

