Return-Path: <linux-aspeed+bounces-2290-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E9CAC592
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Sep 2025 18:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cT1vh0cSsz3bwk;
	Sat, 20 Sep 2025 04:57:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758308224;
	cv=pass; b=ZtlGWh1e0+q3JUGa2I7mFW80O/ItRf0WDo5HRukQmA7R8EKMuFdEvTsUKux5mKqoF+UcHfcamiDrZa4Vjm27ox6o52zTlEjCSmSwhmxx9uqK6OGrvr93ezSW6bCCb1j3hnrJ72MtOzI7YkvInhFdqoo3ODexYkKq5kKYh35W8VaKb+ds/D6Mc46WRomFhBCGW4HEd4d/YTbWPwPhgkMD3/bcy1wCSbcHfVsCWutYiQokXGHbifP6JQZN6bewaXi0MhV5WR3wuc1UaA8bDYBRapoKLJR7SCC2WhN5KBRPQ8x1c2zYtsAUDJvUqGhB4byxrmhqGJsQf1kNVcmsC6kGlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758308224; c=relaxed/relaxed;
	bh=D5IwsHFBZEPo5hYHE/8bLXOBz1ObiAh3u9nS+SZv3tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baD/IB6B0Kn4Vgkp/aYvACQ8Y6vKzq1ed4LdGEivr3PxfNcPUdTDvdn/MmH5GDkUjv1ZhCgiDzTA8zkAgZdkr5gCh0DJe3QTQE04sS1yEy2zA7ReWZHVR9VuhUE50UUKq7mRsW0ogGILjnan2CynjzeY77kZh+hZwTiF5ouRwWIuDQF5nU5O64pEN92lvI16/xSqWDv/ppjjbeVeU6ukC5++epsesMA7YnaZ7dpxN4oUPygM10Mts15bXfGEeoaNGHwWiio+Ss3TPgsC6rPqoD0Bap3uOh6EsTYVKuCGkSeYL+fcYU41NnZXP8OHcW/OSwSUVcOdQS7lnwJcSkOR6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20c::1; helo=fr6p281cu001.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20c::1; helo=fr6p281cu001.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cT1vg3HgKz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 04:57:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVDq84H55MZq4jr+7PgLTup4u9UhfDVApYKFpeHOI6B9YJ6bOa2zRakrHZrASocn9ijnNm0pqO2Tc5CG24Bdw9iUYec9VssYVQDZjjU63oUDarvFrkac9iKQMyk+kSqYqB4XtRFmEoDvOvm9SacS+JPKZ108kUMH9XgLsFab/YJZQxtZ6OlcairAS7sZ0miXhMXG7uaQFNMG0S8KbRrzPj1z8WdGpEfjYAhqZYuhU3G6m1iJlFBageDYvqJy/ErbH2bAA0zRFhnSlCZK97oCrYMvQsdXc73ehdDSBXLsTFZp9iwJ50NONKuvhq+XUxWKWdyo6dI5kPISBu72kv7yBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5IwsHFBZEPo5hYHE/8bLXOBz1ObiAh3u9nS+SZv3tk=;
 b=sGidu6vXxbU5/pOOXOkoWFtmw/mRTWq/NWKygfZP7WInItHyF7Mb4dFpvYJPE1X61gylZAOwToQLLqSxCGG7VYZhtjuka2t/4zFaE/dVJdOTR9VqctYq+1mP8o8KhyTiBFZwssY1BzPGP/VgnOZz9HGfa8/Yrjpvo/uKBcWvFy/L4E+BRLk2ByqQMuV+3FPGJzdcpcp33hwKnPZ7/Rj41aOlpnUV9KTjQa6qmCgHCZ13KYEOPsVGhsjJkBci02MXY5Inc3BftzBQbpHQtIq4m7ZmxWzKmqyfACd2wbmd4m5V9YmxCEydvjuIoJ0vDyVj+DdTEncEMDWXVfEeiOzExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::4f)
 by BE1PPF39BB4A911.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::62d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 18:56:37 +0000
Received: from FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc7d:1a08:950f:3971]) by FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc7d:1a08:950f:3971%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 18:56:37 +0000
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
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASRock X470D4U BMC
Date: Fri, 19 Sep 2025 20:56:17 +0200
Message-ID: <20250919185621.6647-2-tan@siewert.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919185621.6647-1-tan@siewert.io>
References: <20250919185621.6647-1-tan@siewert.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::17) To FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: e12afc67-e0ca-46e2-f552-08ddf7ae42a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrFGcPQeq43HW5w4gt3kM0NiIhMbHVE0kiFkqFWTLcT/3LBn8NC4XjHaSnw8?=
 =?us-ascii?Q?Dy294MoGlDG3plc2Dr9IdGoz2GQ7OAhJ5D+l59zSPHXwcpD+g0TZ9YJiI0fD?=
 =?us-ascii?Q?s+FcJV7/Cezjx1yZvBUk/7ubL3oWzrnhtigTwdSBD6FfjnA7hYr8IZcQoriS?=
 =?us-ascii?Q?D0iQzOEo/lnnDyqJ0nbs9MWJBm8me2G+gL0/8vzK20LnetQUFSnRNTTVLYxZ?=
 =?us-ascii?Q?U8kYnl8YAJ6qve4a1ph3HrLOjKuoWndL/7GHHc7iiKe0mYGBlMkjr2EfrWC3?=
 =?us-ascii?Q?hlS6z89gzpJHT4irGiqEmHil2mA0/mz9LSrqTfIxZoc2RwNFSSP9OBUWboJp?=
 =?us-ascii?Q?rVsA+uSEKBi2gWTR+J7q6U9erPwlIHJSOHogNV84UVHB41IK5jizrKYNR3CX?=
 =?us-ascii?Q?NJ9FVXAO8cvdFFbQc9+k1bh1H5Yi73BBeLAAN6dqtlUIFFLXgmic7cLDGNlT?=
 =?us-ascii?Q?tuaEcJ5gy+3uEBL39Ge+5TuiiReaptr7yW4sKzttVW9l0DkOqGq1YH2TJu2q?=
 =?us-ascii?Q?rvRgQJAQ8zejcXEYm+jev53jXtCQHdIQAWyV0pzn4ZBDlsxJH8Q0cRcbCjTD?=
 =?us-ascii?Q?2R0PTC72/FvwNpP7shXYaQiUr28AA+IJ24IVH9FZWsP0w1MB/5PDEfPPgJm1?=
 =?us-ascii?Q?w+6v9kp6MQzUzr5n80kdTqLBK/bTe3iOOUKcB8c9MtHYllaVntJO7Nvkkz8V?=
 =?us-ascii?Q?1ki83KAmhiTwOMUDzDc5EiIPMEYqD5OBZBxlGT6VOwrbv8+Qw9aev1kGD2Xf?=
 =?us-ascii?Q?DSFWU7gcOdiQBRoywlIp6cSmmWs+PyB3vW+m4Z8Us1vQefro/sGl7uBkMXzF?=
 =?us-ascii?Q?NJaHGsIESuZ01/eRP4HXx0LGsss1hch765r+29s/2rlDhJjSjimhs+76gcyu?=
 =?us-ascii?Q?+uny67iHD3wYeApH/X6mY0Z/DljsJYs2NLbEjLHyXDoO1OwfYws2nhTaij0g?=
 =?us-ascii?Q?FBCP/eP+vvUQoGSP1clp0Fa0+DGM9Y7RNkBLOyLM0KSYPd0P+Oci+uIYh7Rw?=
 =?us-ascii?Q?8OHQqgQ9eUzfDvqI/g1o7WIuANb8T8r9A1Ql25MBtibBexSG5XhfZvt4goV0?=
 =?us-ascii?Q?/4ygQl1RJ+6q2n0hjYMEJ1saLLwGENEI/p20uO7t20Hn6L6rdEd38fu63Idk?=
 =?us-ascii?Q?H1BrC+8FiN0HGRiS3FFIU9rkr6478CE7I/M1gUDc/fHnjTS4kuEbsufKRABg?=
 =?us-ascii?Q?U38pqAyk/BWudsj8yiKxEa133BnforCdOGTZjHVXvP0zJN7uN6yOdiOfaA35?=
 =?us-ascii?Q?T/5bQ3X4CWVwFv7E3cAa4BN6C4e59+iQ8WLs/FJBE8L56xN8772JZX3+L9dd?=
 =?us-ascii?Q?4xiv/CwwF0BTqJ9LAAWg7vJj9kQDQ/naflMlRpx0Cgh7flNH7aJQGPAaisEJ?=
 =?us-ascii?Q?S8jNZ9rqUERT9yYWkAkeuqrJgtTDRAeIou0nDDRauNTDQmcarpweBTRSytrw?=
 =?us-ascii?Q?7n1QMV/juU0KTgb1Ffq19P9xDlhrCHGuZ9NTmF8sWr0evrkAkBoXBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFDOkDJ2qtij+RzaTAUxa52lC5JgDuxmUKqAVht2b8lTwXyKxjle6UARX7Ce?=
 =?us-ascii?Q?6IZhWk9V5SgNPQXEkANykW1PBTBAJL56fIGm9Awpex/Jkkbn4q6SqFBbQuQQ?=
 =?us-ascii?Q?E9hgnv2DjWqSMvOMWUqmuYRlkXf/NRfQmh1s2xO9quZdBPFZy89CDv7Xiw5P?=
 =?us-ascii?Q?/iqWHUR68v050go/kTF9kMyckpi3xA0+2j7GbA2iGONVxU2SRz7VBBHu7L/2?=
 =?us-ascii?Q?9LYSjcDabB1JgWRvNVicm5RCLgSQB7vIZF9iZZqwqRiPoz1jllUTzdGj2ufT?=
 =?us-ascii?Q?Hl098STRZ/29qKNyoqf64SsAKpbKgmDRzQj/DgB4qA6fVEaCTTb0nhpmR0Dl?=
 =?us-ascii?Q?4zdjP4frtMPZuHdRxfot6iKv8SUUebL6Bi9J0tZSgUXz6F0gtjeoUss+rGZe?=
 =?us-ascii?Q?/PhQc3AYT5rwvYdZreIfpF0+NZGlSbEHFjWdK9PIUkMCenGr3JHx4HU8qUNQ?=
 =?us-ascii?Q?VyPfZnIOzETg1VI0FLM0aOLUgrPqan2OpSyq40zuMyaspMExFw24X5NFuQuC?=
 =?us-ascii?Q?BtPfdA6yECrTIF9+3EzCcUe46vdsv/YQmPg+cqVCPRKKbQ5Al0klQ5jShN9c?=
 =?us-ascii?Q?UXTu/QaXahTGxELB/S2LGbysueTqgc7CGocMm/j4nRw+pK2JdQWmkjohwSzN?=
 =?us-ascii?Q?zhdAd9fQ6bjFoUba3sI+Rrg5UgBQ8qluK3rksicadnIzMS1AVDASWCBran3u?=
 =?us-ascii?Q?yD8oFl+8u/IeCjOYfdWrpzWjjs6IVwc6hGzXbOkw27eEx4zRQmzX/G9waYO5?=
 =?us-ascii?Q?FJENluDQ9z6v13PnhTG2YmeRqhHpKhC4Jv+XkXoUfVKixhiSUpJznulEBsF2?=
 =?us-ascii?Q?gFpHLHnRMUCBweoZxOkyr3R6j/BGpRue/xYK+4iNBV9xIm+sevEgkS3qgw3U?=
 =?us-ascii?Q?2OqmGtpFdOO+AHy4IWLQwXWQPzhLa5oDSPM+WZJBrwCAV6QkDBWiAVqIFkcd?=
 =?us-ascii?Q?ixzBK6L+tlVkmQxxoSZK5vIe+skqr7la8pTdCC/wWskYtcslqJNkBmZyyRjD?=
 =?us-ascii?Q?qKwFc+Ely5+wysA/6ifty59KmkOVYhdqKMlZJyitVtW474+QUGp60gDpr75I?=
 =?us-ascii?Q?hsH6Ti0zAyWS62Vefr0pvpV0HrKZ8Y++ifo8ICjIFTPHCkLv5mOCFvzEumCk?=
 =?us-ascii?Q?JcfN96pnR8L4nQs+aqrN5pRSrpfH7hHDzK5UU0ZZ42xeQqnT8MRRL9+Ym4H6?=
 =?us-ascii?Q?+6YsGimu9EAIMBaOWlqHGM959Eh7f/F/MX++md4Vyx8Tt2mtAy3LTZJE8llu?=
 =?us-ascii?Q?lx4PK+iOv+XovpdZFc4FbylNmPqHR1UXd0OJT5bSg7/HVIYancD/RJLFDIhJ?=
 =?us-ascii?Q?U39G9qSSUtT8BLn60ohzThcAReEhrIwas3XE5+n2fsQh0zL7GtrkPrd8fkXf?=
 =?us-ascii?Q?L+jwQXYBFNlP6xSE/xIRVPHNxJOKd2qQMtNmTPszTTXo4ooV/1j0T0qouVTV?=
 =?us-ascii?Q?TqoiHoHfVzCmA2fJ5CSXDjRcNlybf4/3MjjopsrJEDdRUFmEReCOY5GdJSQW?=
 =?us-ascii?Q?eLTIfYLCOcZTNl7DEaYh6gxaqeAABjbIJ7rrXSNNTb9sauBaYd2vQ/pQHoFl?=
 =?us-ascii?Q?I3tuzQiXsMPKXNbBLe8=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e12afc67-e0ca-46e2-f552-08ddf7ae42a1
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:56:37.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTr4CPBzb+IMKgae4Conn1o2FP4Wk++G/bciJ7Xggc8Lfex80xdwLLc5vovV1tbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF39BB4A911

Document ASRock's X470D4U BMC board compatible.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..dc0fa22db5f7 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -38,6 +38,7 @@ properties:
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
               - asrock,spc621d8hm3-bmc
+              - asrock,x470d4u-bmc
               - asrock,x570d4u-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
-- 
2.50.1


