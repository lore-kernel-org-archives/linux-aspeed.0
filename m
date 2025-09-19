Return-Path: <linux-aspeed+bounces-2292-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C76BCAC5AB
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Sep 2025 18:57:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cT1vj5VXQz3cbg;
	Sat, 20 Sep 2025 04:57:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758308225;
	cv=pass; b=eq2ZzXNfAdJVouF0xFz5FDEHVirWLC7Zdw1VaPS/tGU0Xfna11fbEwFRcuI2+S7JnoczraFyEE9wdCCzpELrZon8mdhDdP/53m22hyPnhnbtynNGCd2/N6CH4k/xkO4HgW8+sAV4sxGV4LQyNsynIrWyoGxQrIAEDsrJjJyaKyErFkRaZC9greSkwp8w2QPu5xebO1i2bClxAAESDt3XFXx9ORP26HgfyjyVwxrdcwCsFxfIkEJQMc+fu6MElGxcOIbNB/uN6uvr58UJCtOy3hhwR5RxqCYIp8Ay3ujIjh/OrHEou1LmJTrtysMAp4Y91ZyM6547oeOmbDhAOd6XeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758308225; c=relaxed/relaxed;
	bh=FKMfdVKqgxO5oKrT4PjQnyc+DSyDPHwr2eU5WMk/hu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxBeIM/ECWHUqnmjzAV1OyJsuWUgHCUSe1p/Jx0HQ2d81DYpb9YFuy637rSSPMSB0GNlimcLS47qAs8uxex/yI1THMRy2CuWie3eS3Un4EMITGy+uxlvEkceeGyrqn1286kCFQmMT6fXO2IFC+VcqCyUPMc9AZpc0lq4Nwfo+rFWPN34iGw8Qg/UgJU8f+FH5y+Vi9cboTSpA1m9reJLJNpiJ46Mg2iK2eWRfmkMjqFxQtlR1QTYvf6nb0LhYeokFhmexvPPFV4uC1jXEIsxNjj0LQpe0eTTvVgVerO56VuXGxe3oVSsplPhQyCT8QC8U0B1u0v8DpIQgRYy/ZGwQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::1; helo=fr6p281cu001.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::1; helo=fr6p281cu001.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cT1vj12z4z2xpn
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 04:57:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PARY9+hwYElg3DDdg/G/A9kToSSDObj8/eqDnY1QlUXlMSGN8lpfLN9yPceGpl2l/p9aF4Vj73+JoUIosFTJVwjsjP3D/d/64TfACl3XQcFnJ/OFIY7Gt07gXzUeJrhe679nbIup1NX6m9NGhGTO7iTcRL6YZFLBJgRTPeUi6/3W4FluS9SNT6s0bYqFSJUQP+cYntjD4gjaGC3Z7rBhctcAeg381G17NA7Jp6dgNpiYl51Fx6W3obuO6sviQ5fVO0wFa0TmKf3SgGN7hb/gQc2MmRFJUrLvchBSDwlxxKCiFlfiDbLLpB4Tkp6IqgxBn1In1/5v1TIpR9o2shhcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKMfdVKqgxO5oKrT4PjQnyc+DSyDPHwr2eU5WMk/hu4=;
 b=t4+UPUQ4uyLVqX+fKBDXyQIoTpGTnaLI6yvN747SJWzGsuE2diEge5VUV+459/yiAH5KSSmJkJDCiByPiiyQZMoDtzRE+mzeB/W+xTEt6oZUA4XooU0tzo/APG9/h2Ys9vV/sV7M0Ilud+ZqYflv5W6q/3jW/53RFBUwRR6nw7hNk79tIYB1Ad6C3wuneREsUWl2lz2Wxy9cjP/kd+9zgJGH2ApxmrZRq7DGxA8M8QVxspdBbJMc83b8Sr98D8EelifXYTizDrk8l3BQdlxfYGWD+WldrmmZztWR16Y1zBUCx270RMeejAnOZHkqb1ZUgWNvkZjkfC9p7HgFRE9qlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::4f)
 by BE1PPF39BB4A911.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::62d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 18:56:38 +0000
Received: from FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc7d:1a08:950f:3971]) by FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc7d:1a08:950f:3971%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 18:56:38 +0000
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
Subject: [PATCH 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Date: Fri, 19 Sep 2025 20:56:18 +0200
Message-ID: <20250919185621.6647-3-tan@siewert.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919185621.6647-1-tan@siewert.io>
References: <20250919185621.6647-1-tan@siewert.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::15) To FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::4f)
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
X-MS-TrafficTypeDiagnostic: FR2PPF7274BE471:EE_|BE1PPF39BB4A911:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c90bfdd-80be-4ad3-5184-08ddf7ae4333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mg0BkNbGOKzcIshNAOdHe+FYK02R4ptTNchrzlIPj1qWtWh4/BC90neDbuVh?=
 =?us-ascii?Q?e/vV49e/RGuEG1R0WzfMuVAsYPI8BBr+5vIPxWiVGdWki4KZxs/TYnc3eu9/?=
 =?us-ascii?Q?dC4FyS6dFGe3H/7zYygY63xzD6pIy2BxShjWEx+kDT29qIMJ1WNaDB4bY/Nn?=
 =?us-ascii?Q?831n5IOZKZoBtNGYFnR5EV1EhrTQf+YlXt7Zj9Zh21Y2uUG98U7tQlHvZ5ga?=
 =?us-ascii?Q?uF3zD9zPwGAyyriQhqrSjM/FPY9py+IAh24hzks6dht5ALwpmol8P7j41u8D?=
 =?us-ascii?Q?HQYqIvaPv/G/A2Y7PiU7m6VnO8V0G+pcCL7p0cRd0xCl3trqp/y1IBgQcztM?=
 =?us-ascii?Q?t8rxTJopp9T7pyEX+79JSC1srVTiH0ghoG1mLPcKU+d1QxSaiLDTlqJeJoHu?=
 =?us-ascii?Q?lL4sW/d9mrWzDBua+R36eftdOXxGMOnuQwZGsZ6nbZwing7qV0WTN6JUIC9h?=
 =?us-ascii?Q?M7vtNBGZTc7FMob9UkEkJ0DcCMRSmIyCwRJ0lxlpd6ehp4Sy6Mw7VLJw2MeN?=
 =?us-ascii?Q?K4YniTZqyv/dgvwR1wOki7kLjhlDEbK0khAzUHnztpN7u48ILUxQy2Cc1Lph?=
 =?us-ascii?Q?JUPplOFe8TF4+AkeeyHi5s1s0mBaCm6TfTmcsKkyE/lJkWT4awpGjRcRxiOa?=
 =?us-ascii?Q?9oY7P+RH+uhYOJjUtOWSeQlQUiSaoFsHFDvU8WL1b0+HmHYaIii8DmJ7ArZk?=
 =?us-ascii?Q?bTQvMpksm1fiqhY7L6/SKEO4raHldKGbgUFzdcQjTI/rMIRxxincXiTsj1J5?=
 =?us-ascii?Q?Cw0yqSZkiUMBdoOJlCOzLvWARIjXQ8R36GloNjvtX4EDjxETGJUddzvXJ2j9?=
 =?us-ascii?Q?YiFBY5Pl+47Gz+MN3MP+7FQMEMPDCz3mK2rnR4oab/dct0qnOnfX+TlShLCr?=
 =?us-ascii?Q?R8tmqGD5GyBvgZF11NVQ17UMk7ZA0hJvQR8fAsGwDxgE1PmJDH/xFt6npVez?=
 =?us-ascii?Q?Vr+6wYaaLYycMX6BS2eeB9GKpsfPUir210oXKd+KWr1K1pT3z5ZAbgQp7hF4?=
 =?us-ascii?Q?8YrVwXD5/s+/eOe6Qr47s3WYjtkSq0llxemFIx3ZBkIa4+yj/oG69ppn9PDe?=
 =?us-ascii?Q?fNKuw7pJ5WJR0EOqhhkmhQARzYXGw6CLQYmkRtVvaaRTtqgxZG67fM2W2B+r?=
 =?us-ascii?Q?z9JAt7zyHe2DU77uIL4ZMCLZ1XEparg3g8k/TkNklEwA8Pc7ErHWOBI36Bbt?=
 =?us-ascii?Q?niuJoSVuozpu793rlnt3jnoHkCtixIzd9yFoSyH9pE6oA6iEMmF8wvIaVXV7?=
 =?us-ascii?Q?VUMHsG8dhi1ShkC1+DiUQuKPIlnAZOVmtS48CCYZjQs3SaQMqkenB2+ganll?=
 =?us-ascii?Q?/q/THimyPOuLs06Km3Cex6f8fOAWMxU8D4P2EQHbfDkHe/sGgKJ3v5D8e4hL?=
 =?us-ascii?Q?33BdFS5mzjeBw6OMyY0qXQLPSRESoFGP/TNJ+orbkQTtJRBCw2bT08MwbFv/?=
 =?us-ascii?Q?Ruut56TiXz6n7y3VHc5CTUd0SnQd0kGXl9DuC0a1zAL+d6WL/KAjCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35XPBUqm8uaCD3tMKkxRWQcTs/Qu7eQGq4qj/lvUXljnH2+StSc8mkLjPT66?=
 =?us-ascii?Q?KBrwIy+ptzoVdV5Ad3WzyY1BD6FqBRNT+C44wrdFn0WM31LHvvK/GSKIZAYn?=
 =?us-ascii?Q?5dXWmwbnM8lD6guQb4N/fJYG0RgyH0ypFxnd0CfuC8haOv1iSgmd725DUN/9?=
 =?us-ascii?Q?x+qbJB/EfhbY3fYpRtD9b3iNyprMpP0dLcNPvhbRGVmiVvR4dmT2WzlYOOHM?=
 =?us-ascii?Q?SurFyKqirfR+Ft9FHcWm/T0iefzapfsY10/QMcKrWCTSIu1Ju3Gisy0ddfSk?=
 =?us-ascii?Q?7LjyC728eft5ijCsnrD08KRtKnYjbnW87w7lNLXdGyG6JgKh2cNmG0hn6GPt?=
 =?us-ascii?Q?kO3UNrDqB44zNCjvDQ4VNsE2W4XYt1gsuuRtS+rJCeZL5MmSHT9wJ5aj7E0P?=
 =?us-ascii?Q?5oihumAEa1XDI0QQwKJs9NObU4/NuMTfejTVnG8iflF+j0LlCkDXUrAKFZzc?=
 =?us-ascii?Q?o20CuhNfsjE8wwgTJBCoO2FSd/STSnIyhV+DMdlSlEgz0hHx++1sSWeqeAqM?=
 =?us-ascii?Q?4jWE+P4vgwTBrP+pEMFzpM/QRqHjRO9PE2EtWcSMb8Q6NNXnetO63iqIxZpp?=
 =?us-ascii?Q?3Q8dLCUnWzIFo7laFJHj1516X+H9Yhn4d2XBE4tzD52rO3HcnSr1X3SYiTWz?=
 =?us-ascii?Q?FDdeAdTdHVqmJ3FlGQO7QU9eB8e1uQoN1Zl0ZckH24ajG9J5B0t2Hlj+vtTo?=
 =?us-ascii?Q?OOI/h2K43s30KRJyhA5ZJmwC6jEejUWsCk4UGcIj0OA48MBfjO89GIKi5Afl?=
 =?us-ascii?Q?Lq0+hlg78NqT1k35O3XSYvdbxcXMCDTgUqBaA5ApVP9y8t7c1aNtR6pCV3xJ?=
 =?us-ascii?Q?haEHbGrNJrl2/rJO1J/5Y31omyFKgxf9wPdZ5+j9+J4WHoCp1OAkChkhs1eA?=
 =?us-ascii?Q?eV8JAtUkYHcZVS4lI57TTyi6NIsWLD3eVd0W/y5B15yOk4064WYCzQZ9vMBS?=
 =?us-ascii?Q?kHbmjdUSDSwGMIrUET312Tg3BIIwYZ0sbw8isuB9gSDxiQfNvKQnP0jFVGas?=
 =?us-ascii?Q?CcVgb6E7Wfn9oArmuIkj5S58e1E+y9KBnShnr2Nr2JXPGUD8VMpaeOJv5a2x?=
 =?us-ascii?Q?GqtnoQbDnLprf+KeQz1291JgZ1drbByzOvDeqITAnJNbtQQRAUVfS2IXJX5d?=
 =?us-ascii?Q?4nG9TYx2LphQ2YU4ma+UnShTTQXwM7+G062CAdsL4UjwlwI095UgHy2tpMuU?=
 =?us-ascii?Q?0mva3z72ejI/RFrmXJ6gTytzJRg/sVVCZBfTIQeIZP1kMZQis39Zyub0S+u9?=
 =?us-ascii?Q?wP0EdCQ4qmC+1Yrt0AZp5V6jUlE9C+9JZAhWIRQz2jIesMfqF1xJcpzcR+jC?=
 =?us-ascii?Q?cWWmspyaNpqeqNJU2OzPKHrJgakid9SvGOFSPK7MnazolofBtZCDq7n7+gbe?=
 =?us-ascii?Q?LEe+Oky42KvrhFF6T3lypgnreAUtRXIbljEN8+cPwJaKgUEZrIwCCUhc5SkS?=
 =?us-ascii?Q?P/Eti9tNcJ3A/3Tzx3pchc/0ou/WWEV28PTAh4x3zQw4OI7d/HfeoFJBP8tZ?=
 =?us-ascii?Q?CQH2WtUK7jXmN+DgeVhh8MY8GLca929WGBeRYhatJ/qYjhbydF5v0JTJ+nzI?=
 =?us-ascii?Q?zLbVviCGOlZJ/EedUYw=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c90bfdd-80be-4ad3-5184-08ddf7ae4333
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:56:38.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtPjTTWjNw0MGIn4ixV+bAPD0fgdC0u4ApkLdTazHBoj8mr87P9XuK+q2uU5HfHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF39BB4A911

The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
64MB SPI flash.

This mainboard exists in three known "flavors" which only differ in the
used host NIC, the BMC SPI size and some parts that may be un-populated.

To keep the complexity low with the BMC SPI, use the 32MB layout
regardless of the used SPI or mainboard flavor.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 345 ++++++++++++++++++
 2 files changed, 346 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index aba7451ab749..fae97b5183e5 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-e3c256d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
+	aspeed-bmc-asrock-x470d4u.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
 	aspeed-bmc-asus-x4tf.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
new file mode 100644
index 000000000000..bae2b521f708
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Asrock Rack X470D4U-series BMC";
+	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
+			<&adc 10>, <&adc 11>, <&adc 12>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			/* led-heartbeat-n */
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+
+		systemfault {
+			/* led-fault-n */
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			panic-indicator;
+		};
+
+		identify {
+			/* led-identify-n */
+			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pci_memory: region@9a000000 {
+			no-map;
+			reg = <0x9a000000 0x00010000>; /* 64K */
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02800000>;	/* 40M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default		/* 3VSB */
+			&pinctrl_adc1_default		/* 5VSB */
+			&pinctrl_adc2_default		/* VCPU */
+			&pinctrl_adc3_default		/* VSOC */
+			&pinctrl_adc4_default		/* VCCM */
+			&pinctrl_adc5_default		/* APU-VDDP */
+			&pinctrl_adc6_default		/* 1V05-PROM-S5 */
+			&pinctrl_adc7_default		/* 2V5-PROM */
+			&pinctrl_adc8_default		/* 1V05-PROM-RUN */
+			&pinctrl_adc9_default		/* VBAT */
+			&pinctrl_adc10_default		/* 3V */
+			&pinctrl_adc11_default		/* 5V */
+			&pinctrl_adc12_default>;	/* 12V */
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+/*
+ * Although some board flavors have a 64MB SPI, use the
+ * 32MB SPI layout to be compatible with all boards.
+ */
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		label = "bmc";
+		m25p,fast-read;
+		spi-max-frequency = <10000000>;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&gfx {
+	status = "okay";
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*  A */ "input-locatorled-n", "", "", "", "", "", "", "",
+	/*  B */ "input-bios-post-cmplt-n", "", "", "", "", "", "", "",
+	/*  C */ "", "", "", "", "", "", "", "",
+	/*  D */ "button-power-n", "control-power-n", "button-reset-n",
+		 "control-reset-n", "", "", "", "",
+	/*  E */ "", "", "", "", "", "", "", "",
+	/*  F */ "", "", "", "", "", "", "", "",
+	/*  G */ "output-hwm-vbat-enable", "input-id0-n", "input-id1-n",
+		 "input-id2-n", "input-aux-smb-alert-n", "",
+		 "input-psu-smb-alert-n", "",
+	/*  H */ "", "", "", "", "input-mfg-mode-n", "",
+		 "led-heartbeat-n", "input-case-open-n",
+	/*  I */ "", "", "", "", "", "", "", "",
+	/*  J */ "output-bmc-ready-n", "output-bios-cs-n", "", "", "", "",
+		 "", "",
+	/*  K */ "", "", "", "", "", "", "", "",
+	/*  L */ "", "", "", "", "", "", "", "",
+	/*  M */ "", "", "", "", "", "", "", "",
+	/*  N */ "", "", "", "", "", "", "", "",
+	/*  O */ "", "", "", "", "", "", "", "",
+	/*  P */ "", "", "", "", "", "", "", "",
+	/*  Q */ "", "", "", "", "input-bmc-smb-present-n", "", "",
+		 "input-pcie-wake-n",
+	/*  R */ "", "", "", "", "", "", "", "",
+	/*  S */ "input-bmc-pchhot-n", "", "", "", "", "", "", "",
+	/*  T */ "", "", "", "", "", "", "", "",
+	/*  U */ "", "", "", "", "", "", "", "",
+	/*  V */ "", "", "", "", "", "", "", "",
+	/*  W */ "", "", "", "", "", "", "", "",
+	/*  X */ "", "", "", "", "", "", "", "",
+	/*  Y */ "input-sleep-s3-n", "input-sleep-s5-n", "", "", "", "",
+		 "", "",
+	/*  Z */ "", "", "led-fault-n", "output-bmc-throttle-n", "", "",
+		 "", "",
+	/* AA */ "input-cpu1-thermtrip-latch-n", "",
+		 "input-cpu1-prochot-n", "", "", "", "", "",
+	/* AB */ "", "input-power-good", "", "hard-power-off", "", "", "", "",
+	/* AC */ "", "", "", "", "", "", "", "";
+};
+
+&i2c0 {
+	/* SMBus on auxiliary panel header (AUX_PANEL1) */
+	status = "okay";
+};
+
+&i2c1 {
+	/* Hardware monitoring SMBus */
+	status = "okay";
+
+	w83773g@4c {
+		compatible = "nuvoton,w83773g";
+		reg = <0x4c>;
+	};
+};
+
+&i2c2 {
+	/* PSU SMBus (PSU_SMB1) */
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c6 {
+	/* SMBus on BMC connector (BMC_SMB_1) */
+	status = "okay";
+};
+
+&i2c7 {
+	/* FRU EEPROM */
+	status = "okay";
+
+	eeprom@57 {
+		compatible = "st,24c128", "atmel,24c128";
+		reg = <0x57>;
+		pagesize = <16>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
+
+			eth1_macaddress: macaddress@3f88 {
+				reg = <0x3f88 6>;
+			};
+		};
+	};
+};
+
+&i2c8 {
+	/* SMBus on intelligent platform management bus header (IPMB_1) */
+	status = "okay";
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii2_default &pinctrl_mdio2_default>;
+	use-ncsi;
+
+	nvmem-cells = <&eth1_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+				&pinctrl_pwm1_default
+				&pinctrl_pwm2_default
+				&pinctrl_pwm3_default
+				&pinctrl_pwm4_default
+				&pinctrl_pwm5_default>;
+
+	fan@0 {
+		/* FAN1 (4-pin) */
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@1 {
+		/* FAN2 (4-pin) */
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan@2 {
+		/* FAN3 (4-pin) */
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan@3 {
+		/* FAN4 (6-pin) */
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
+	};
+
+	fan@4 {
+		/* FAN5 (6-pin) */
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0d>;
+	};
+
+	fan@5 {
+		/* FAN6 (6-pin) */
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0e>;
+	};
+};
+
+&p2a {
+	status = "okay";
+	memory-region = <&pci_memory>;
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		/* Frequency extracted from original ROM */
+		spi-max-frequency = <24000000>; /* 24 MHz */
+	};
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x2f8>;
+	aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart5 {
+	status = "okay";
+};
-- 
2.50.1


