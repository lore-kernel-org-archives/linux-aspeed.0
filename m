Return-Path: <linux-aspeed+bounces-1891-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0F6C87FDA
	for <linux-aspeed@archiver.kernel.org>; Sun,  3 Aug 2025 15:20:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bw3Kd4zbMz2xdg;
	Mon,  4 Aug 2025 01:20:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754234437;
	cv=pass; b=JmcGmwZuJinoTty7Mf6hw8VnPEDXwuirouuUG2ibt98db9ND5Ilx41u8zEvTCrKlOuXqvtdM3LOcGai++s2hvLJDVoT5DC2KQA1Gf90xIkXetdyci57MEudpBbMLxzM7fNsxl9kWgpeXsXCMTNf11P7DodzCDc+eEzpt3y9kBwgEo8OirIRTVMnTg3s/s4mVHTxQTEy+vlcwhgvhV2yuIvizRD2IKmgY1ItLoBV+0rLvOzzgefPw/i/hzV4fgVjLCIwE5KgV4fA4bJxxjmt9MM4PKbuE2zWb/mbqxeFQtdaLn6kpwRd0JO3XY30m+amUbbkYFKLK2NqsHEwcPQinUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754234437; c=relaxed/relaxed;
	bh=05cNTLmyz2nmm7kjHhJjXNOWlyiQm9oZ0n10Pz7wFnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5CISl95S2LiCA26xOv5SWSbf6N6OAS1W+wg258NtwUuYcvV8IQnnl+8bbiB8ALQIXxlcCbjWiqQu5yST++ofpXR81w+Tg5MzkCVD+asFmcyRkvI5MrWPHHrS0P3XPAvqHe2/LyY5XJu++nf5cRVWAC27E6HjeZ4gt87yrU1b8OIYUxouA3tnoyIGslJN6Zsw/nGKVRdPlAuwjgHz68oewot/riw8PuR3cErXHIo0kgE4e1k1bhan5iTZSq81nTBtQ1/w2BO2dsq3AH89sDXAmwvRnnJ+tk0eGD/gExLgENPkXBCIpAu1vO/RP+0vrrNYGJTM7tppLicUO/fpZ2WYw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::4; helo=fr4p281cu032.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::4; helo=fr4p281cu032.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bw3Kd1Xtcz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 01:20:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY94awZzpfp0sIfuEb/ibs3m+UA3JOxbFjV111pkSZEU2ThyZORmQ+gXU8MpdpClNUOEpfkZFxzl9+Y8XR0lHD51dvMJJTPgGJL+jCvLVzQ9723XSXP1QrVWUPY31xq4Z1CUYNwzuXSurzsvr1dUVKdwQdkpXERQX0KeEynyO0cQOrZh5p0S3srBIDodeYlkIoimL5ZqCcQzovh0NPtZnsbO58EJkqCdPuLz6LVHYDMdyCW9yvq9D+xmE2SEduXXkAvu7duWs2VsFMBgyMAWBRuD+seW5NJZF2u8AUe4V728shy7DosvCUto4naM/5+/3VX6wL2B99zQ9TSsFABDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05cNTLmyz2nmm7kjHhJjXNOWlyiQm9oZ0n10Pz7wFnw=;
 b=PpehYt6R8Db8kJrD7hoZm6oy0yyjGgjjJMCglVTaC5eBzpH7cPWSUfQxUhqttc7Ij/BxZbIbQ+yWwH9yDtVC1js5DOgSEKeWVNVdQNW18KUyJ+f7wexsQu6bJ4gm4dko1cI+1ZCQQC6gfd/RaERsgl2hRAUBp6i34y5N/zFj7360mTu85t625ewigh3LbmRZNz9q9JAQCDVOjsYMmMP3pLeyJHWnhXXoSMrpGO4LBde+b7IXjZJSA9OgJM3RSK/6DXJLoStmEbGb5kldqEfmgobnH1HFQ6wMDA/u6ZGfh11AdyqfYQatDCorDL6Se6P1HN/YOOq8WTtFq3rASBFfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FRYP281MB1898.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Sun, 3 Aug
 2025 15:20:19 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::32fc:c799:7f09:62b5]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::32fc:c799:7f09:62b5%7]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 15:20:19 +0000
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
Subject: [PATCH 2/4] ARM: dts: aspeed: e3c256d4i: convert NVMEM content to layout syntax
Date: Sun,  3 Aug 2025 17:19:38 +0200
Message-ID: <20250803151949.68618-2-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250803151822.68080-1-tan@siewert.io>
References: <20250803151822.68080-1-tan@siewert.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 000585ad-7bec-469c-65b3-08ddd2a141fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6pddxk4jRA+QSKaxzgiOW+SVbdFLptmBwlathXUD1TEQPHc5Gl5zbaVPdnQR?=
 =?us-ascii?Q?T2BETVhxF2oPGK8GWBi6hxKgkP3yAujJY3k5jSerghFhx0wlQYv8RtBpHyLb?=
 =?us-ascii?Q?qRRrH/JpFDqjNLJ6Pe8h51hny3tx4bfiOsmMLagcROxMNTM2Z3AVfDaMeo22?=
 =?us-ascii?Q?LpDn9slmyJcay2c+VqQtk5C5L5hkCY7rqjrNYLm+QQAulPDX3N5YSO6FzNcc?=
 =?us-ascii?Q?CgdTxtKxPpdmPLMQkyU5zjcLGhKdP46hDNMOX4Bogy1eRZy4KPhIO78SQj+P?=
 =?us-ascii?Q?BzfBBJ2RRRJfU0npD5vjuWi96QgewOADrgDNzO0ntLFchx4NU/zqu6eZwNT8?=
 =?us-ascii?Q?xi0Nt+VvDjzasCY7Ib9Ny4vEPmwm+6u58tzZFUxrDefJinHTkF0z+AWmkYwn?=
 =?us-ascii?Q?7rRS8g9LfhkD6+zHv2y8h5ZmAFH00XUCWXGnY8jXok5Y7f7UI6BDIxcauT8Z?=
 =?us-ascii?Q?7U+/Q4LKauZQXc/NlRjyd7Y9S6/ce3jOQ7a640VW9AOAv17Hhs3CQ2ug8FMA?=
 =?us-ascii?Q?OozIWAiLThFUzH8LuyrbNdDyzdJSe1eMXLm8RrywlnUGPuKaiTyNUpvfs3LX?=
 =?us-ascii?Q?GmBWhhIUXGU7qF1UrafuhdggWXKJXQd6aa2lHqHRIr7HYALn9Q+quXGb8xJt?=
 =?us-ascii?Q?D007nmdO1u0KXLApXj1X7GWvvEanb3IxVFwmUsESPQyhHyVvkyL0ZaM7W9ev?=
 =?us-ascii?Q?/aaqzfGSrdVqNgs42kQqnlRQHgaiFLM5jRXeytpoFfxWUp6hiuBhun1BOf1N?=
 =?us-ascii?Q?via+huL9yWwlVsQw7N6KB/TEwKQImzPjhMZrsql3slkcFnvdnawk8V1NcPAx?=
 =?us-ascii?Q?9jCgyq/i5XTakhxDuA7RIoZSsq0WKsecRt+QmWXbdAg1XF21cXcj92qU9rLF?=
 =?us-ascii?Q?kzEJjY0a8ZaC6ZMGF/MrSKXRsUbIWt58QOEhXTlgkfkGSFg8IQjg2DvCtDWT?=
 =?us-ascii?Q?xXj+6RTxOGlUiT29PmbAmq0H90gTVOMaQGUIw1ENBgBq8cUJGYmucH41mCBx?=
 =?us-ascii?Q?swZt2GqTUnDM4rLQAq7qOQrMer0vUDi6Pd/jlXpoUG80zFLQ2M56f4A+sSEm?=
 =?us-ascii?Q?bJl/jj+LIS+YLHFlL8LwYjOT2WbUBkP05Adr8FB4sY8qCbvyhKiJZ+h0kJqU?=
 =?us-ascii?Q?/bMVz1tUnG5lMss6mCxtUwSvwZqXko2uyd/+rYHFTdzkPVq/ztS1Cyc2gIvy?=
 =?us-ascii?Q?QH7SkRoZR89yKeEFB2+rR4zqWVx8oll/ImzbOqbjx6TGQUTuPh5BBm/zJas1?=
 =?us-ascii?Q?w0N2dVdhz358VYoobI8NTLkagVAK0eU87Aq4iU6BWVtEqeOs5I5jeQLOr/cT?=
 =?us-ascii?Q?pDWYlbKhjaD9vEwrEgPz+vFGqyA+zDvOo6bm+divl78IIHCmRnUf+TL4ltO2?=
 =?us-ascii?Q?NodgXTLXPK/CYp25XBR2s78Qq0G1dIGcKnQ+6OihrUcUFZV+9XifNz4WsLtn?=
 =?us-ascii?Q?iyRZhMz5+oE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lda4WKJUajmF9c9Sci61DmzXRJq/6laGuWqN3cSpp6gONQcwckrb8VeKPxk2?=
 =?us-ascii?Q?607D4EQ95B37+9+zgGhbXaah6RE37Qvlp1h9bE0S5HnX6GDzjq1bsr1hY6uS?=
 =?us-ascii?Q?UGRsoUOF/rkFCwQXqImbV3gqI9+Tg0YUMS2vGQDqKdDICN9gYYZKg94rBW50?=
 =?us-ascii?Q?qveObFXTWmQxJ6YoDqwCBYjJFdqKbRKBd16ZZ+MRMBHQ9askPP4pXYIVerBY?=
 =?us-ascii?Q?tYc+Wv0hM8LerevMovB/pMp6JV7DOHxSNsa8mEOLVoZ9rT+xJgWnl4RIQ+9h?=
 =?us-ascii?Q?Q7UJei6PJdm6QOJFQn+Kr5nREEKheoLsiLDmSwA+x1oZNCcMPo5lBH3b0VUU?=
 =?us-ascii?Q?2gP9vkbZaCYDJTTgQeTqny+KM7CpZc6OuW41ZG6eeaigYyy1L6LnhmdH6Iw1?=
 =?us-ascii?Q?AKGvnx/7THoU3RQJb8hQFDH2K0h68jlidfYO2adDI6bCemGt7aMGAHas/yoT?=
 =?us-ascii?Q?udLiFSh/r6zgiDOwQ1BFjmL8o767ic/Xsh5idEryJcSSwkUgTVRIL1xI1+up?=
 =?us-ascii?Q?7JC2TvD69G3SWVupWJtLg6R3FEQCXsFbbISBikhQVuzh8HBugAgGW7jhZzql?=
 =?us-ascii?Q?6z3HhFuq1vbfnupDJ8vQ/OWg1YuRb4tkMiTmsUk7XYsFzWnB/5C64MVhf8yn?=
 =?us-ascii?Q?jYp4lDYpkNAPqJzRGC2YUaNOeDlGfZ86Hr7nhEAYZSj50WPxKpjTjHHWwofz?=
 =?us-ascii?Q?OGuSYylq6vYKCs29iAjEg8ZZakftEMhV5lUyY+wfcJtplbAGtxgrGiCyU8Gu?=
 =?us-ascii?Q?W6hffq1r2PKhKVOtkPeLxs4kgywH1mFkKEGQ2okF+jxs6Y23bLQCj+AfEQyx?=
 =?us-ascii?Q?4q6Iix0/5a8E/cAeYRLhu9mCvcH3xlYCaf7J5swEmgokDXGGvXi+/MRPOJIV?=
 =?us-ascii?Q?rVDl0PQIcWp6m+7SPcgsVdYhtyQyIGtiHa25ruRmQb5fVPtkhFHDP1dsq8LZ?=
 =?us-ascii?Q?PP+L1IdRkRFYp8aV/zSJEp9AL5MiR010np7DPEJJSAPX7Xt5RWfmuHfL9JiJ?=
 =?us-ascii?Q?cayhp+op3tv264TlcZD1WrU0Sh8K23GN7nM4PKNskEsjmvEFFHr2lGh+kj5B?=
 =?us-ascii?Q?ZTSOoKhaCRAxcVjyOqZvAtMgUnqvPxxrDQyxGAD3vhq6h0Xp4lKlZiMRSCdn?=
 =?us-ascii?Q?lfo9Ls29hKnaer1BpNDjyZ+MQJEZB6LdzMBj+1Tk3F+I2VkgkQq+sYZoeoGP?=
 =?us-ascii?Q?f1Au4v/c3EyXi1V1OnBOhxuLFjEy61e0jSfupgjo09YznXuphuN1mCaJqHHl?=
 =?us-ascii?Q?9pgvsXeZapHb20fxbn4CT3VereRcKOe9UaKpL4wOw4gxEkkuRypbAOpzhDPd?=
 =?us-ascii?Q?eS3s2bzgBKP90O0U85q0XR29Jj6Sadvzeuya0VQ0i5+7MmpirkLnjrZeThNE?=
 =?us-ascii?Q?JU6tD9CUhH2KK6WOdzs47NJWInJQ71gj2jSTp4vZhUS5xUaQgxifBcMcHqek?=
 =?us-ascii?Q?Sd4iZhiCh9TM2i+KC3FLhELbCx1jTS/qprL7UnyCzLTEzfCcfHtZZAijVb1F?=
 =?us-ascii?Q?e2K+l2TtbLVAXwLg8hTrEdWsA2LzpxbsN9ISJ4Q40FhTZuEj3PMKdXFjYmkB?=
 =?us-ascii?Q?EhhUJtFIArjYiqIKexSWnW6jGWIgk5AEVPnY06Zff3Z1cxQBLSwOd2mESCqY?=
 =?us-ascii?Q?ar+Csv57KGTJpnWtpamk+U4=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 000585ad-7bec-469c-65b3-08ddd2a141fe
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 15:20:19.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrPIjHAJWaCiGSVrQdzSZPniMS6N3Utt3y5LnJVA+mZprTPFO3hkX7fepxlQbZaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB1898

The used bindings syntax has been deprecated and doesn't work properly
anymore.

Use the newer (and non-deprecated) fixed-layout approach. See commit
bd912c991d2e ("dt-bindings: nvmem: layouts: add fixed-layout") for
details.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 .../boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
index 9d00ce9475f2..8c57a071f488 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
@@ -191,11 +191,15 @@ eeprom@57 {
 		compatible = "st,24c128", "atmel,24c128";
 		reg = <0x57>;
 		pagesize = <16>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 
-		eth0_macaddress: macaddress@3f80 {
-			reg = <0x3f80 6>;
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
 		};
 	};
 };
-- 
2.43.0


