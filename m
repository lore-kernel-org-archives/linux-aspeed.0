Return-Path: <linux-aspeed+bounces-1889-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68EBC87FCA
	for <linux-aspeed@archiver.kernel.org>; Sun,  3 Aug 2025 15:18:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bw3Hd30pvz2xQ6;
	Mon,  4 Aug 2025 01:18:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754234333;
	cv=pass; b=Znn8ODhnbn1iOMPYgD+i+We1DMi012RVG4OILfCvNTe+/wnthl6fbxl2wKgNfovjR0w1knAI+cfmf6Oo53xThM1ktLdjoK3GekYdMvKV5bA5qmRwinIVuMVJs/fyZY3/KDczrR13t/8h+v+SxMH16dUgLfk4ZDBqgIm3wg0FWj9ImHjl7tgUB0TXyS31Kg3ARz7BOneFRq/8iGm6ShahQY6Z8kXF+OvWDD4xRDRke/yc03L3ak5UdcGVnsjW3qP3S0SVPJ6u/q8EAaUJkrm/oe2rJkguOxwylFxnqJxvwM24K9hoPcpYTl7+P/r1w8WUKaJa/oC45F3Mju3S04pNEA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754234333; c=relaxed/relaxed;
	bh=yNI+LhHXQ+9iO/YpWo0TJMuaZrrlbQ9uwKMkDKxFoOE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hXfz6xfqG8/Vc6dq7HItL2dGjfLwc/ycHl/BVRkGUXmbjoyho2T7t02MZb9P70Dc2aCZ3buPvOsrDYO9Y2xY9RsZYTo0AisBzGgwuqiTbjtKthRQQ6/qJXM+hmC64dRCHLWmPvjABKpbp3S0y0jYkIGaQhQLjglvHV7G+wJ13lG6zbrB1zIJ29O3t46svYvSo5p9/QZdNIwKmvte69mBeCzwh+u+e0o6nasf9rRqpE1s+YtCiXZ1pL+y0MiZ7QZAZjmLXYahcusJaQgZ2hYwIGrA5QSUBv5G4PZmOzFt4EHn0V0jQAseN1w+3h4fnBDa40r+1CCDYODzsPdwnxnt2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::4; helo=fr4p281cu032.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::4; helo=fr4p281cu032.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bw3Hc510mz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 01:18:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o72/XnZ8FsI+gixCxKzI/PM27Aszxy+eOzEYVMrKQgbqxlpHH0G8mu4PR6Te5NEDTk4n+KCINHqaDadfJm9pLIyXOKAhGVqsUP2YBN3JiIu+YSjqNmYUKO12f7QrNOGpqInoK901FxNdlvBNo0jzMYsNpve7MEx7kPaaae/CKq2Zv2TL5Rc7+oxUl1dBXo3j641FauR0u1CTE7g+HVDoJpxWJfbh1/HSAHJ9XqUMEYPcRf4S8CHqG8ONkm3QzMLkFBOyvx1DL3m8ORNf4hTjX8tun2vkhKLPxijAvCF3wlkQXbwE2U2iVU31VadzxsZDXvVK2Hk2lueojBKky/QaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNI+LhHXQ+9iO/YpWo0TJMuaZrrlbQ9uwKMkDKxFoOE=;
 b=E748q4qT8c9sljWmBn5xKWi9XRANk7H9cbjS6PFI4dmUv9KZSpBQ1mjlvKf0td3K4higgSrrEFIFnTt015rtXRNW2MJhvYBnCANXFuyKmibkoGo6Z82He6piWBUJKLk6SaeXUAsmORHHy7XMIiMNBm8cL3kS5PjgWL1kj4zdu8DSjFe9K4KyvVVI5E87SaNsIzBDvibYbrvy4cQJtAU4j5AYFKL3LxWrb0rCo4Qlhbk66MmpqUAUaOxa+n1kwIKkqwwfRJQ2idULTai+yRtwgxr4gzT+cWrD7KiR/d6j4MtCOrla688NlyHZ1iF2mJpkHhrgbRXVGzklCZTHFbR9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FRYP281MB1898.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Sun, 3 Aug
 2025 15:18:27 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::32fc:c799:7f09:62b5]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::32fc:c799:7f09:62b5%7]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 15:18:27 +0000
From: Tan Siewert <tan@siewert.io>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ARM: dts: aspeed: Convert remaining ASRock systems to NVMEM layout syntax
Date: Sun,  3 Aug 2025 17:18:16 +0200
Message-ID: <20250803151822.68080-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FRYP281MB1898:EE_
X-MS-Office365-Filtering-Correlation-Id: cec67af5-5dea-4261-bc5b-08ddd2a0ff37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODEjxedArVCdiJVppkvG3HodoDcdaS5k0E8mm2klm8aTdK0h5nKCNh2RXxAA?=
 =?us-ascii?Q?RWuO8ANHaKOtTcVnHus3/gZnZmB3sNrrk9PdDX48Q0pN7M8qUTK2auBhrdUl?=
 =?us-ascii?Q?ovMD0e9ZooEjkgmzZeqhrVCO+eIJ6Zl7k4Pa2vLwrnwrD7ciJZQRAzLfmoZt?=
 =?us-ascii?Q?rRP7fzluarox6/aMRmkRO+K+HQNSdOFrj972hITHH7aE8643tZ8zt749ltv9?=
 =?us-ascii?Q?yq7FevL0lpSb6ay/oviDBNAy5lhrhN0EQj+3AHimsanxAyKnE80mE1xec8Ip?=
 =?us-ascii?Q?EiJZLghhBethISIKr+WjsDsvg8iSV4madC6u2sFEH4oFkgCsbu5rc89BfOjr?=
 =?us-ascii?Q?2M0aJmSFhOGjdGeNTr1tUveBnSYiSopxfa4NrUXeCeLojBxAUI48G4Hu9HE6?=
 =?us-ascii?Q?XNLyJ4Csyk09HiToIRaAZkVcmVbQ4CS8LOZetYRfgHVUknxfVuhNR2d2egF+?=
 =?us-ascii?Q?QPSrrj6jv12umDFx5e0UE8w/GKTrBr9cipM4b24NeLX0Xgpe4yhGhayiWCbH?=
 =?us-ascii?Q?MYmDYLZ0/f4qqR5511dCUbliHqj0rWOFCZUyLMvilzqVXbYftGAl67UYTT9b?=
 =?us-ascii?Q?ug5w8bX63p+MVGj6XJ5/PwsZc76mI/M1NlOwT1a8zBiv/Gs4FDNzsG5nGaHM?=
 =?us-ascii?Q?Jz4VYTeKhmfk/UURL+wDQVS1W7won8wij8MtTmuoX/NqLv7+ojGIorq6HOA4?=
 =?us-ascii?Q?W5iq8l+B+5SQlv/z8AOe3iCpleRaRq5uFE8EUlYzgkvJl9S6q7wCoTh4apOc?=
 =?us-ascii?Q?0KLCGB7vtbR/K9VxyVMVkrjiXuZdoUdbMS8mZATM16yLCMD7srOhrQdrRjRR?=
 =?us-ascii?Q?2vwVN+BFLC6856B/zuEXgO0rUPUzMkbcOeGMJYnfYMN9+Ay8DnIaNQr6va5l?=
 =?us-ascii?Q?6dzRf48DTKIIdIBrPbdxU9McM/AdflRK3Yux+osu5/qQVZAHf768tH9Cd9+H?=
 =?us-ascii?Q?htz2UGcdlvYyYjB74g0Mpfo0I0wlvEUss2V27j+enmEin9db7M6HkBK5hZar?=
 =?us-ascii?Q?hfvvD4XAJSu3b1LIQIA9g+kljjJEB/MGzD1KnFqKTp2qfxwAO1kF//cldkzo?=
 =?us-ascii?Q?wCtbB8lCyGE2AXkVYEWL0ev9BAORkDhT8FZcGG7k45ICOYpcMiNR8aqpB224?=
 =?us-ascii?Q?45I9lefV9uARonw3DYxyQ7WxYVF7Kl66O3PvnzUdvGWsMK/TgtYnYjbyZ/4y?=
 =?us-ascii?Q?LPg5l1fjK8zSJkCLgAy/+vX+aMttFw0l1OQlFgf+9GGFcrg+on3RjY2fhvP+?=
 =?us-ascii?Q?jjEvLDaJYxWsPLQjEIUF2JRs+H4HjpsKQDQ8nfWGKqWhCtJfn3YsKg8LESd0?=
 =?us-ascii?Q?KkrDOwgdSp+HpuBgYhX0xHyjM76Iu1qF8LgetCKP+7V5NR89mOLMIS2vG79P?=
 =?us-ascii?Q?xMkirCdLNzuOwwlEcpr6ixlSzL/zrXExRnHwbBhgKPSvdLKtQrHfzaBPfXXb?=
 =?us-ascii?Q?/MxYjtWytR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHPT+ihqAu+7w1UsGhsfRlWDYjNAc3Zo+Qvm5sgwzc7n/DIfspXfAzs3jGDg?=
 =?us-ascii?Q?q63YA4FRVhoNVyUUZ1gbaIYZFexvjcs+GzDU7hO1zwrLfhlcHRVu5zGCUdCM?=
 =?us-ascii?Q?hvYLLdg5EKIbUIfZz2Af/DYHHDq0xiDq4FFN3FYATLmvZ6B0JFoTO3oyno+k?=
 =?us-ascii?Q?2qUYmyT0f8BzFEIQ4sp0XNusKakT2Q3rr4aUV1mkjftaNtfOGSBLnc94bkeI?=
 =?us-ascii?Q?pphw1YWWsKpb3UYMyCiK3km7n+g/zOaqGzaVBTeDwlxPSTU+PyuVlCFYYwMf?=
 =?us-ascii?Q?vVlEKRAuvi4h9WirNNPjphkpYxMP931FcELa2m1r8dkxUmCgiWAr9YkvRton?=
 =?us-ascii?Q?23kP91Tj6ZKyjQXCTzLZPubhmia9Uoox4+INe7P8IvSxsfpDNfgIw0qXuT7q?=
 =?us-ascii?Q?N5Z/CH8ZZ2hUD4QCmZq0wFISpcaM1E9mvZhIDUOm6OFALbzE8jj5GCcOFogk?=
 =?us-ascii?Q?zgcdKHmqKoO1i6WZKRuToBvjltfYTYlCODTYK0M/M5KUMgjpIKjILm83MbFk?=
 =?us-ascii?Q?UGZjrk8pQ/aGNFGRCfN0Yej1cxXQdzGq2f32iz754rSM+N404mfb5Fc5hoYI?=
 =?us-ascii?Q?okG33H8tSewEuRDUNbXmue14e5SKuAu7rCOoSt/m3id2JhfJ/S6YD1T+8Z5O?=
 =?us-ascii?Q?ofKPneXdyrhU1qMpg3v1ORzz0yNq4w0+1u2edBw5ZR2Zhuq5FqtmkJRAB+ht?=
 =?us-ascii?Q?nbtEMO+A4fyz3PHtSFGZqplc/WXjRe/jUS2zOc0xcgxM5CjEuCTIq4m2VI9B?=
 =?us-ascii?Q?btD9qicv+0xjCX9k3OFmummcmD6Qj8pffyN6rVNK82AS3OShcSJ+2YeHF7wC?=
 =?us-ascii?Q?yC0t4VBjCtGLde9uBXCE8DWb3uM+aEL9AqAlvMo5IuV8do1bZCD/JTVh7y6G?=
 =?us-ascii?Q?CqM4a2i+xKqmmfj6pxA37oid4aamq2P0/6l158hoBT/V0SOdiRRyuPzBenZ4?=
 =?us-ascii?Q?SR6CeSClq9UXtdGZiJMDjYWr3q/yJgHOBIAYoWP1CFwFY1BG+MLUehhNKAiZ?=
 =?us-ascii?Q?PMlnQs5swpnaKHM4LSrLsHZh7oD6wH8W7rnzXnM2rEje1TX3GhDwKlNQjO7U?=
 =?us-ascii?Q?BZ4sK8huO0IBZmdY31p/OPUOduC/2P13BJDoKiOcVZ1ZQnZkgrletLiQIRaF?=
 =?us-ascii?Q?kqoW7PVIC1R4OcePPLplauF7K9mr4YX/leQRzWW+W/U7ikEKfQX5QiCduJE8?=
 =?us-ascii?Q?MpWqIEv7tHal0eCf8meqAXvHrGkTrTlHLTzWwNoO7oodKFcASvjn3gwrC89d?=
 =?us-ascii?Q?OltJE91SifLsL+jlE7qLb0QOaOCV3ieCZbWEdYTli9kBQmCIuyTSkHYf4NfZ?=
 =?us-ascii?Q?zPlkVI1eAxdQh3/F9h4Qnlj7u5nPHyM0FtNoySS76x1Hvnb8GvHCqmoJthVt?=
 =?us-ascii?Q?NulGB2KWjrFl3cmAhYm1kNZxRtuav2ZWxCBClJ4fDjQyz7ueGV+gImUj84+b?=
 =?us-ascii?Q?gHGeZGXJegaSVt3GfLiP0ajhH4CYoV1Vy55aGdtbutzxwLuQsK0zlk9xWwnB?=
 =?us-ascii?Q?OGRhTDfFLVjJ22S2E5IwjoLIwO36jEite09ztoWY33B58xanQ4q+pA9DCuJd?=
 =?us-ascii?Q?cuR0MkuwLXMjg+/u2NKO7AqNfbStNFELj0ZRFSV7rxv2BxdQltR8y/wyvZ1b?=
 =?us-ascii?Q?5QBkAveX+Xrz4Bio6mvXcDE=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: cec67af5-5dea-4261-bc5b-08ddd2a0ff37
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 15:18:27.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNbW2yv+qwpIGGVLTyLxz7Bq2ZPaMWcJq60+uc/glnQAaMtgdUT9VEP8ZLUZB3l6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB1898

Hi,

While investigating an issue with an ASRock Rack platform, I noticed
that most of the ASPEED device trees using NVMEM cells to populate
MAC addresses still rely on a deprecated NVMEM binding syntax.
As a result, the MAC addresses are not populated from the
device tree/NVMEM cells properly, and an address from "the chip" is
being used instead.

Commit 76c5533925434 ("ARM: dts: aspeed: convert ASRock SPC621D8HM3
NVMEM content to layout syntax") was the only system that had previously
been converted to the new layout syntax.

This patch series converts all remaining ASRock Rack systems in the ASPEED
device trees to use the new NVMEM layout syntax.

Tan Siewert (4):
  ARM: dts: aspeed: e3c246d4i: convert NVMEM content to layout syntax
  ARM: dts: aspeed: e3c256d4i: convert NVMEM content to layout syntax
  ARM: dts: aspeed: romed8hm3: convert NVMEM content to layout syntax
  ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax

 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts | 12 ++++++++----
 .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts | 12 ++++++++----
 .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 12 ++++++++----
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts   | 18 +++++++++++-------
 4 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.43.0


