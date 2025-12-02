Return-Path: <linux-aspeed+bounces-3029-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13796CFD2F6
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Dec 2025 06:53:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLBM72kjSz3blk;
	Tue, 02 Dec 2025 17:53:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764658435;
	cv=pass; b=aa1XHHxm6xQUjqPJkmFo17F26MyjDFP+Q6TFgYHlkOz2SWrqf0G0lNATsyhrtO/oqFDIJtzxl745/AyIbbO5ymW++CIiA5zAet96p5F32VrLL+0FTMJ6sJnfzVxlQesxNQuHzhf1nR7VTbji4dzse4tIbP648kzdTaJ530z6crwc0hcNwNNxFd6XoE41pGKhkyX8lNxVMCaMnnL6r3W3jnJEWBi0xfI2dZmHOMp6WzWGwlHX2IIXPyyPV61wrpAZl1KioIWQS+7spsmcVPfphlNtTv8kxw5fj0WVASn/NNX+b1t/x1NeKUeM/+ZLqWr+pukx5Xh4Wpj6aTuMELm4UQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764658435; c=relaxed/relaxed;
	bh=CvFX6YbeEDDFiRlaBNCXxXgo8mxZEvj0XfakdTKDICU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDT4FHVcMG8Wo5aAhdHtTfaQslwGWPI/Z32SsH4UHgkfDVN5AyX6BP7ubFHSgCU2fEyyH32l0EDXubrYUwJG5VRNeNoaeCGVr43ksarl8IEfRKwgW4677m5XAJ+S89Ck84rZC7BAUEjhrg9zvG/u9/Xm5bhMUEUewGTrAEPO1zNnEq1Uax+sTQXqdUI9buxexDB7j1KCfM3yi1UA75SkcfDglJ92F9BneJiOCXXOYMNzmo8HdyQi+ma3Bg3RxCKNmD2u0pVCxelKadyitjOgIkzrZ0nx7g941Dh11kad79cWnOM2f822VmXYkI1yQHpif419+MmNZ5FkzvnOQTmCkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kKeXA9P3; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kKeXA9P3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLBM52Zdrz3bfR
	for <linux-aspeed@lists.ozlabs.org>; Tue, 02 Dec 2025 17:53:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI8YR3JE0q7aOvKIOcEIpoQDpbI7d3UqIbl4xTH5QtBsy5c2I99Cr5KI6JWC7G/OKL/ok+pMSTm+oR8viBhQ5XhH6YzBts3dCXK6hQplnO/uxIfcvQlBc89dvr1CkmolQLvrhgDu1V59jg6vJhe3qaMc+QsdF/2x7TYBRQCRhSCbeOMQKP+zr6BchwgSFNaS7KeTp6b2IDmQlX2kWay/Kxi5Mn9BgATw78RQfwaVgD0sBQl22X2y1vwCRVZVtPZcJrD4sS4rg6X5eu2Mhy1GC30VLBHPTKQ75nbkNwotQFWpReoD4mMfbg3s0JcWQpNM3J9idgg7Nz49x+7Ticsj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvFX6YbeEDDFiRlaBNCXxXgo8mxZEvj0XfakdTKDICU=;
 b=LArqmupIPTCMVgcLgF9GdLYtMDCVl1Nq+vlr6YQTVUQtiR1W55+OVf5en0gEjgp2muaOvCxrPDw1WikqgpyFfH78Yk/wwGb+2FroGVif2BltycL7APN4pnzjeBeimLZgDbIup+GPbE9SVLK1ZEBnfGyKTyxjsOBxK4BdiaM4Et+LGO5VwVjfssZ5vjmmXY1JR7Pt2OpDHF9xDZspzf04e3+b+8kBDrjlETH//X6QSoWtdoUtvDafLWAzxCXLHxZ69ADtJEGMSSMabfrGQ5QA+MeOC3bXagmJO+0+1Tlk+JALyNrH4yARAcFlxGs7WXbaKKWPdqVlZZL/RJb2/I0wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvFX6YbeEDDFiRlaBNCXxXgo8mxZEvj0XfakdTKDICU=;
 b=kKeXA9P3vP5CR6B2QbZ8cio7RHv/+KXbRj1NL8k6xetzFBKnIRsf4V2gNed+mqHhnNNhBhzVkBi0K300arNe4m464Xep2BoeRPPXAjxSx1qY3oyjUPaL4BCWuFGTyKkdA0dFkdCZBzj48rKUk1cKnNDgHs8HMDMlNXu/SvL2Med5hOo2nenmxD6qBmrnw0qCY6c09Qr+mYnwIUY8f8PZs0zKBOcauY7eT/cwtenqPzaVTNEn/twtrM7oSx1k/BfuTenJXGph1GSCiICaMUs729BWl2poWW545ShjdMZ6NdUYRWRM6HIeHfSdcb0Cj/dqiiQvjU2IukX7scHsJSev+A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB6276.apcprd06.prod.outlook.com (2603:1096:820:e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:53:22 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:53:22 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, Tao Ren <rentao.bupt@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
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
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index:
 AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpCAAKBqgIABWbLAgAPq3QCADnQYkIABZcyAgACY8gCAAYfhoIAHwL3A
Date: Tue, 2 Dec 2025 06:53:21 +0000
Message-ID:
 <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch> <aSbA8i5S36GeryXc@fedora>
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
In-Reply-To:
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB6276:EE_
x-ms-office365-filtering-correlation-id: 78ff7197-e3fa-4921-615a-08de316f7bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HI3hvD8JPlTD/ymTCaRm43/PFkoSzsSJr6oNKlM+elhsSRgzjAeQ9EItNfvo?=
 =?us-ascii?Q?rUvlUGr+a2cqYQPhF789JyGIGTSQqpDFfvWKlJs1PgOOpN3fkQUJvHHqwJVu?=
 =?us-ascii?Q?ZZ0hFZBRqCnCiUEGAkQLJc251mgkt7QLXB8yd2kth9psntTa55vJEBi+TvMj?=
 =?us-ascii?Q?SzX86H+ZOZdIuqJGotZWyUBJ2NWnsPqeY8dojVrGoc4QRsDBgEPsXj2fbN7N?=
 =?us-ascii?Q?rAkgjUnS7viQNwmyuOCv+uGxClTRYoeKAUfRoouA1z4vodj+vEbvVw9MRgMx?=
 =?us-ascii?Q?s3SrXRFYpkkkXFP9hPBm6buVbzj7joDOzAZ0w2EIxjwVQmsX4Va8DMORCEra?=
 =?us-ascii?Q?g+5HPnNVXXybySM0957VpcYsXR1njjpkCd9wK1bLxHa3yXgYwpXEip722ng8?=
 =?us-ascii?Q?gve9lXi93YPd/n6LiYGNk+zWxlNrdRC4iHgPVVdsFZnNVhg4nyX4lsi9NLTv?=
 =?us-ascii?Q?1Lzzy4X8HaQOEZnXLKYOI7KcxHAgb/PBnohQbmhYW8RReI4FY9IrqlmeJk/A?=
 =?us-ascii?Q?W6GU6PJmMdX/X3f6DmtSyA1kces71o+YFPdhB0dHkU4wxkAQzKr/xrA9uvG5?=
 =?us-ascii?Q?HKAX1EcE3Bw6rFNR6cqQyA16nZYDwLNUe6D1MP3gSHYT3aLWDS36556BdYKu?=
 =?us-ascii?Q?idX7Adapdrm5A21M8/iGY1MmKmJoutotpUCWoBHVyjNZ02KuHdZc9Ed0BLyf?=
 =?us-ascii?Q?nycGBXkbrKP6xBQEwAbh4jCqQ72kmTsAdwFwUy9u66V7P+SJZXsHp5/zgrRf?=
 =?us-ascii?Q?j+fRKmEm4ZwY9vQcY+FVzHs8KJwX0cTEeZaMw+JZaClipKMeJyq3lddppYvw?=
 =?us-ascii?Q?8ieskp9AJPLh1ntTF9mMhYReWOi0lwvCOGSeZybgk6B/vEdt2x5PoDEgOKbi?=
 =?us-ascii?Q?aona6VLICJNA25unndRdXjXd1HQGSRX3S8gMfN4KtGPKMkdKNizc+fZ7nzaU?=
 =?us-ascii?Q?rcX/7M3BNczENjhe6h14HFYCufBb8hNGfyJf8cMEg8F7NW/Rbe8wlXToYu1Z?=
 =?us-ascii?Q?s1QRBMJaG4R0zF7KMfLjXngB2PNHjA7Pw4BqZD47LKe3R4Uold9y0blcTWVj?=
 =?us-ascii?Q?3BMbCzt5lt1ok+zCPV5UVn8CxgoyNcIzNhLezpWAnZGrdzKq1YrVkDL1x/Fl?=
 =?us-ascii?Q?yzKpHM3BC0gIRvbk+uu371nE8LrAAdsqZUSMCT2y+8Um2kKkgU+5/HBSYlsW?=
 =?us-ascii?Q?OM8q9XVcy2PHtMlGu9jUpy5Zim4AJ7WCMgjhpOgGP+pYVaU137pwKSgrQuBb?=
 =?us-ascii?Q?yyLdGKS1uZS1Bbo7pbtR9HV8RgEXDaV61F3vSdXgy+T8Zk4GrtCFReSXO11U?=
 =?us-ascii?Q?Q+HI0S5m5BpbWlXqeMgMU+DsmBHKAPnlfS27dIZtJOsiJBwm0uAm5lKzFmZ6?=
 =?us-ascii?Q?EB6ZRn6+vO1lNMuVoOY8f+ajoCl6nm3t08XXcFp4YlLfIv0QgamGl7zpSiTY?=
 =?us-ascii?Q?jAeh6avOMJ29yyyjvjD0eIjNenhPWO8mRqFfUMwh1j6dgXDZbvy0WQuskJJA?=
 =?us-ascii?Q?0cLSqnrLBoKa9jcFJaf5WcnQ+HOnN4Donp+s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bOxmoO6rmFqjZwhs4HT9hM5mxvZnec1F0JJLD+tmp36dO0KW6M1NbfD5uTLN?=
 =?us-ascii?Q?Ud8MGOrmqTzu8/01QZPSZCN9q2Ry33sg0hmwldzEt2xoIE+Vhw8oaxsPMclP?=
 =?us-ascii?Q?W1/4chmD3RKyNd5+6sX4wD9q8Oh/hMDFXOqWZD7ih9coXqzhDliufPlQ400S?=
 =?us-ascii?Q?pG7HV96cQgKT3fXjdhrgmYCy7fX/4xi0Mvo7pgAd5l8HHTNMNlkX4FZ/9iec?=
 =?us-ascii?Q?T9PGvwsrCNl1+6mchxdpDC3fGXFElxzFeLj4TPnSJJFylIdtIQt3O4KIQuq+?=
 =?us-ascii?Q?FKNaeptZGrfY9HYRcb2y23pparNTGQNsPLVUddDozVVJfmNeCvDbIkyDRdwO?=
 =?us-ascii?Q?rdpu9YXkLLbmXyx/9zp+fA6TSbPRNbvqockag7gFlpJajnMNATOWdhFu+lNg?=
 =?us-ascii?Q?KZJKhkRuySM7Z71FqsHtHdJezHJbwcmxg3LvcmLtNzWMND3UOEbwiELpAtsO?=
 =?us-ascii?Q?87Y9aOplxhs3QzEhl4q9ryRMXQZ9zTsGFfFhPndjkZWY/AKc4K1Szamx/geu?=
 =?us-ascii?Q?RiW7V+uEqXuH5S0tNGdyUy8kcmTkAeoLUoWDerf0/Y+1zEDSZ5wkkrtdO/AQ?=
 =?us-ascii?Q?f986sIU3DJXsFA8+KW2R8OY1AKIDIdbEafi0VlvFiqVv2tF1tUcKJrmDekXj?=
 =?us-ascii?Q?GGvbW3HnepQ5+vrMZoDYiAsJFfC7MByKQOtShhflHrpXcXsHmwK4Xkxylo3e?=
 =?us-ascii?Q?C40YV1CzBsYXKyougm6d3lyeuZdqvHmrOh7WCXCQoBoFvGl+CbBr3Apb/1ER?=
 =?us-ascii?Q?woe9ITtk4C7GUtrgLIEa5uD0J3Ri6gHzMRTS3bVRPCFVrsRwSV/dC3oLei9H?=
 =?us-ascii?Q?Sr4tQELa379A7AUy+w3WOzviZhX1+pYwDW6MOU21FMxeKMPV4XUUjbKxTwaA?=
 =?us-ascii?Q?tNF+NMfD6rZXQG0UhedNiy9fNmYkCEfuFq5fjtoyuAxAxga1aJW3OqekkQOR?=
 =?us-ascii?Q?KprmcTr+FOB6iJCKMQNsGGU03UOM7BemYL2/K5FiccwYS+f3UcGkpDZ/VC51?=
 =?us-ascii?Q?VMTwxA6jzHuSi6X2hMSqVkID1awDjVL/yTKms0erDXfyliL8F6p/kQu8uJax?=
 =?us-ascii?Q?kfJYS5pdBLwlD537XOptehYZluFULiXJ4g6bpytMbQD/+RKM0j7+tttp0J62?=
 =?us-ascii?Q?Mwjq77XvJyTl8glzLOUfws2fK4yBKpewgwfjlxs+QzLTCbzTW8gQuUHQ5DJe?=
 =?us-ascii?Q?vjk6l9w6NJ4vir4pDc9A6QUYO3hZp2iUT/oDMWl0NoxOsS/vJeHizywMQUgt?=
 =?us-ascii?Q?vHXqd6kla36jzduoYVKFU4H1cUdcVjnHsqu704HhIfa4jwpO20TA4znc26Dg?=
 =?us-ascii?Q?PQ0pdsf/5Cs7SHJMv1o7ZGwWsK8+k11ibceWsYhQ3P0BtiRAqXUzbGRtK0BM?=
 =?us-ascii?Q?y9gFKbuzO1aVIyfdBf41pWwYjh+7gKFeqVjHBTltUhPSuBK726Dsf0q0zU/x?=
 =?us-ascii?Q?vjfCCjvlZr/ZWqNM5fzJjyCIA9ddbH10K7qkjD51tPbWhgOtzR/QuJJip8mJ?=
 =?us-ascii?Q?Fszyid2JJ526daOFjwjQLeQ6j9yAdvn932rgLvqnqQU7AyNaoXVkxUYTSnnh?=
 =?us-ascii?Q?PDq9lO+huTpjrq/biF1fihg659tKlw0O21YD2eYR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff7197-e3fa-4921-615a-08de316f7bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 06:53:21.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqfOVe+yq43C2LhODRLjiNmz48NH0UyNYoGND861f2587Olzho7wmupQWhHAab+v2DhMsM4sHk2kIIjEriNs4G+EWZwji8OpzOmEzFO2atw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6276

> > > How many different boards do you have you can test with? Do you only
> > > have access to RDKs? Or do you have a test farm of customer boards
> > > for regression testing. I would throw the patchset at as many boards
> > > as you can to make sure there are no regressions.
> >
> > I synced with Jacky offline a few times, and I'm happy to test the
> > patches on my Facebook Network OpenBMC platforms.
> >
> > Hi Jacky,
> >
> > Looking forward to your v5, and please don't hesitate to ping me
> > offline if you need more info about my test hardware.
> >
> >
>=20
> Hi Andrew,
>=20
> Thank you for your suggestions and feedback.
> I will update the patches based on our discussion in the next version.
>=20
> Hi Tao,
>=20
> Thank you for your support.
> Once I have version 5 ready, I will reach out to you. I appreciate your h=
elp in
> verifying the patches on your hardware.
>=20

Hi Andrew,

I miss one condition is using fixed-link property.
In ftgmac100, there are RGMII, NC-SI and fixed-link property.
On RGMII, we have solution on dedicated PHY, but there is an issue on fixed=
-link
property.

Example on dedicated PHY.
The driver can pass the "rgmii-id" to tell PHY driver to enable the interna=
l delay on
PHY side. Therefore, we can force to disable RGMII delay on MAC side.
But there is not any driver when using fixed-link property, which means
no body can tell the outside device, like switch or MAC-to-MAC, to enable t=
he internal
delay on them. Also mean the phy-mode in fixed-link case is not used.

Therefore, could we ignore the RGMII delay on MAC side when the ftgmac100 d=
river gets
the fixed-link property? Just keep the original delay value?

Thanks,
Jacky


