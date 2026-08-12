Return-Path: <linux-aspeed+bounces-4691-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D2AC5CFDB
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Aug 2026 20:29:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hL0Sp1ZWcz30Wn;
	Thu, 13 Aug 2026 06:28:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20b::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786566538;
	cv=pass; b=Qwc6kdN57MH5SZajQvCxJzFEDI31Zm29rTX4ykE7mz6XGp8TP2ibWca/2vsqRFCDuZJtKRfutUwXWHDA26lkLaFRDsvv9RnPJa7m/0J0tH4kDQPPTl8FTTpfm7k23hd4aC8gANZ9KKomISmxgpp7V5OLkBSyl+12hj8FnxBw7x8h/Dxax3ShzBp7lgqYfBKGPTJZapxDnyfpaJMyOlidhiDG0Mm53Og2TfqVktGxLaAnYmWgADiKH5ccDph1pD3aoFNHBGmu3Sfcr9mJRed+/Oy2d/Dd6mp+P9Uq1In/KZyY+LoQaVZXZjdIIXWH1dLyfuTJQxWB12MarHOpZKlMQA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786566538; c=relaxed/relaxed;
	bh=uOqAdTHlwlcka7GMAt/sdsWd7AxP/XHKShGfB8pd57Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ArCyFQKPNcKqTVljRQk/qPUKEqDmReMcYrFHrNS84LQpSRRDXYO7DBRiQcQjxs7wZLZuNtEfma8iYG9lHYlOrZtTte19zODqS36e/hT3TEnA6xNpaADEjDUBwgE1BCSnmt+1uM3kWbmMLIOJbqKutIMlKB4pojVJd8LLiqOpaO+H/W+ouMCRGRwQ1t0RtWj64wTe4JrX05rgaaMPcqoaX+3+/4NSSnlHvcbEnkJLGzWfYilYG20PyBtIkOMLyGfbYWfLyg/rJTpSllz8Jyix7CwgHST1al82kvpXZjUIBS4Jbj9QcKdYQrh4kLZy6DOg7vi7u3vHUSRooBrffVAjgg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20b::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hL0Sn2PVvz302l
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 06:28:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsQ3ZnoQO50jIBH1vH2Rhy/XpoNw2T7hInkGbUiRWlxsfhxY7hITcv0JjeSW/YHFgyimM6ELgjny0zIF5S2si+PaAcAz8LdQKJv6T9S2Ktq4WEYFM/s2YvjyQ7tLK8BUvoDA4rCxll78S+tzE6Nw+CSqh7t0Q3eEIeNN7AByo/4ZaW55L+/JlMNWCPlFtLLTV5Mi5aFhjFQY7HOHiyFXwlGPZga/CVfi8FAkLVsD0jSiGfH3vrMCxqDUkAmmoncSY2LQKmY3PO28mhMehokPr7+qQ8uOko2gRBtgl2RrOxiIHeA/oZX+o7Y/Uez78QUiPufQHtmP+QaFVCef+8T2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOqAdTHlwlcka7GMAt/sdsWd7AxP/XHKShGfB8pd57Y=;
 b=Ab/Bo45IywFBycC7IQsRuNV4gtM7QK2oM6EUnRur7rAsadQGaCW79DFR/PvCVkHQkEZIhcuiWjNCnsgnLz1/kYycLDwUgz95jD3RPW3UXynTW0G1+p/w703g3UvFWONIB/d1usecApLELZ6ySCvPm0JhAYrhfVov7XKZLRFOO8XU09HRXwPi32GD0a+kq6Inwmy+Z9oGNt4iIXq9RqOv1u8meLVZaOH2FprInHY3Ag1IvUFKZUbxCRsr/XmsV06bHJBW3Chn+oeTDvseSRByW2PSGr8j/pnN1a69uljcEGDAjYJqnln9dU49/78knkn2C2AtEvTdXOsN8zgRA6EyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BEUP281MB3788.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 20:28:30 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 20:28:30 +0000
From: Tan Siewert <tan@siewert.io>
Date: Wed, 12 Aug 2026 22:28:26 +0200
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add ASRock X470D4U BMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-ts-x470d4u-v3-1-c8e266f1663b@siewert.io>
References: <20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io>
In-Reply-To: <20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>, Zev Weiss <zev@bewilderbeest.net>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786566507; l=922;
 i=tan@siewert.io; s=20260731; h=from:subject:message-id;
 bh=U43XDvWcaWpTybINM0+Hs+OkECxWaBtsDb3v7QHdjzU=;
 b=zvcM66A/W21PhbJAFUXh0xwD22yt8s8p9noGEmSKVlATJIopR5TYqA7gFUhqJZxc/eTHKFI33
 3FozRXZAzvmBDcIfOjw2pidltkLzduIe7BFbHRztpwvRSwY5w8nVGxN
X-Developer-Key: i=tan@siewert.io; a=ed25519;
 pk=TXy9xEw3OCAd0QBR/ZZowx3QJfMcoe0ROFfoghqLnU4=
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|BEUP281MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f5e3e9-7583-4f9d-c243-08def8b045bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|52116014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qNbh+t8lLJ71S/rtBvxd1wXKeRRbx3bracgEnD8KRf6KREy8BbjxtqibH1Xp1D9CnAZXHuF50YOtHXJ+eYZ76F7RBxS5KRpFFd/rtHkbZUWioCJieD/lZjzhwWmtVvS/buNlt5l3XN7niroeQDjr/ddW+s+2iK4S/4GQnmGNvHSwHEtPrjH+YeCcgX4uq3JjF6ksZfwzgP3LGiW6vnhqo5tZle6rD512JISgPvS9Z1Lmh0Lq2/W08FtHcdXY/GCQIAM22/N3hQ4zXYogYGRmWQIU1Zili8nlsX2FdpX4/UqHqpbVpPd9LSDu5aNfA51lXl+D2hVTmKS4fnp67jrI/2rmAgo7UB0lXBbR6GkmgUncV6S3RMn5UAz6k6zUtXitJaPwHhZYHFoZEDFEiKLTOjGPPlUnQQA9QSqQTM8caLPb+f3TP5GBVO+iRXmzAeAt4XxI8U/eEUeCMpz5lpjMw4kpl0N8znBf2GR5RXCi8HYTqSWpRAD5smKTolK0rLurJ+fNWbX3AW7PCW7BOzAeKcpaVj8+0hXJdaz3g6j4bA2MJa250H5WiKscYAdwn2rwHG7eInkt2gSnL0M+dxNz2ornWq7/00RJ0T7Bp233uBlpZC9t3WNanbUfxXp/mG1JnaM9qLhFLkvykYGlwmlGzumiqVD8QOP760oNWoZqH5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0oxaUV2Zi9pUWxXeHZ6Y25ZcndRbGFZU3p1VFZlRDI4d0lJS0t1SXdYZ0RB?=
 =?utf-8?B?eGg2OE96TjhtOGNIcktaSVltNzR0UjZjeFJnaFNBTHFndjhjanR5cUFiVHZq?=
 =?utf-8?B?bGlmT1h1ZzV2ZkJwVjdNclhVVWZlU2NPVEVKVjc3ZlRsSDFNOVg4ZDJoblgx?=
 =?utf-8?B?NmVFUU4wQmZ5cTAyd1QyM25MeS92SGdwZ09nYkdCbW4ydXZNU2NndmJ5Zkhv?=
 =?utf-8?B?dmUxNXFKRG8zUmRkTXlGRlk3aGVINHdKQ2c3VlNLN0pYQmdHRlM2RytKZHFV?=
 =?utf-8?B?RlhtWVl6YjhBbVBiN2ZpQ2FQWG44QlBWM3krYzlFalFKcU9RaEJTQXNiWkQy?=
 =?utf-8?B?cWFud1FxSEljVnM1U3J0TjZLWElxZ2JEQURpbXN2UW00RW1MNTZsay9vMGtY?=
 =?utf-8?B?L3d0ay9PbUJFVXB4QXJWUUVrRzBnZ0RaVGNCeGxBVDJLQW1YOVFRRFlRUFpx?=
 =?utf-8?B?VFRJVndUa1RYZjJINWRrQmcyaFRpTU1sY3ZvQnVLbXRraWZJM1pLU0FibmJC?=
 =?utf-8?B?WUFNMk1BQnBLSGFjQVpJcUN3czkvdjZNSitYbS80eTZTV3hUeHdiMmxjWk5B?=
 =?utf-8?B?aEYvaEZ2RHd3RjIrOTlKcERudHFYclBlNkN6VjkrK2tPajJXemFleGlWMXdu?=
 =?utf-8?B?c09GRHJwdWZzNmx4NTlWLzl4dklEeXZ2VmE2bFBHRHl4N1ZBTGNtaE1IUDNq?=
 =?utf-8?B?SUdlM3BOd2MzeS9sWFlLa1l0YVRCTmVWVmdUS2IvdHVlTnhkYWQzVzlyQS9W?=
 =?utf-8?B?Zk0vRE9TeWFmUkxQOTIwdEkwc1lvYWcrMndDbmRZbGNZc2RDa1kzWTBKdGJE?=
 =?utf-8?B?VTlmendGOEdzbktSQkhkTkhZdGNkdUdLTXk2ZXYwS0pjWjlsU2R1K0dwVks4?=
 =?utf-8?B?TjVmamZOT3FnUXlER2hhcG8yWUJSV3NRMmNLRUpUdGt2bU5RRytOdEhNaGlN?=
 =?utf-8?B?NmN1aEEvRXdqV053RVd5VGROSS80NFY1dVFQbkVEQ05IaHVObEJ6Z2VEc3gv?=
 =?utf-8?B?VUszMUNrWEcrQzkrZGNwUEZoNmcrejd6dEhjMmx3MmNZalNBd3dXZExORm02?=
 =?utf-8?B?WmFWWmFjc1ZVTWg2V0JTb3gzUUoySXpZbHZLSjB0V2dNLytFS1NLQ0ttZVgz?=
 =?utf-8?B?TjBuR0sremFJTVR0OWlYVUo4YitLNTJMVVhURTZjOG0ycjJYTlFuMkNvUWRT?=
 =?utf-8?B?OFVrTXdLeWFRM0pLdGR4bFVCSUtCUmc5ZGRDMnhJRWZ6cmJkMExFblJ3SGhv?=
 =?utf-8?B?ZSsxNDZPb3Q2NHJkMXBCRVlOTFgyTUluNzBJdFQ0aUd5N3l4SE53aUM3TStN?=
 =?utf-8?B?WEcwcjlEQ0Fxdm5UazJwWGJHc2xPdjdxNHN6NWRBNkdmR3pnM0czTlBrNEFk?=
 =?utf-8?B?OFg4WExLaTJYM3AzdTFWUlh5dTRMaE40aVQySk5XbHFXdUxvRTIxZEdQOGxr?=
 =?utf-8?B?NUZYU2FGN0RaaVZvOVl0L0VrY0xyNFp1Q0ZPRE5WK0dWQ1J5RTN4VGFRTk8w?=
 =?utf-8?B?SUxaRWtZcVY4aWJoeEdqOWEvZXlUUHFDYWYzbnJTWmszVE5HaW80ODhmZVhF?=
 =?utf-8?B?TlBtRzQ5eHRWbG0rUEtIak1MRGhweTdiZk0vT0JJeklmOG9SejFzU0RpcDFu?=
 =?utf-8?B?UkRuRGt4TlhybTVsMmxJRFVNSFhBY3hqVEpjeFhJVlRyWWFvUTkrNDRyd2x5?=
 =?utf-8?B?NC96cVdaQkw0QlBJeVN0TTFuRjFuMUo1VS9YaTRTMTR6T0dDeGJhZmNaVlha?=
 =?utf-8?B?K3ljRlUwcFk5VCsxRjJib2lzSStGZ2xGMlVkYzB0dGJ2UmZNbjFzekFFcE1l?=
 =?utf-8?B?SjZ6Tm80SEZ0c3ZOYkR2NkF5eERHUnFUWXRUd0xoQVovWVFlM3VSYnhCdEJX?=
 =?utf-8?B?Q1RqN3VDZnpvV0ZNNm5sQkxnK1pKRkZvaE4wSVhKOU1BRXhWYVl5dkwxNm1u?=
 =?utf-8?B?Qit2VnpuUE12bmk2WWdrRnZ1b1B4dDV1NGFzVGVPak9CSHZtNTJVZFlDTmVv?=
 =?utf-8?B?MDh2SENXcGlLSmJlME5PUlhmNzdpc1RhMkxTK2RmUU9EY0loNVJUTlh1QitR?=
 =?utf-8?B?MzB5VDdoZHFaNzZoRFUxV1JZNW4xUUtndldlOWttNmlkMzlRQzJxSWNDdXFw?=
 =?utf-8?B?L1l4SVh5dEcrV0F5YTllMitjM2kyMVV5M1R4OEdJNXA3eGJRWXNkNmpScUVG?=
 =?utf-8?B?eXFzY2pWZkNoNkFSYXcyV3c5U0tDSEN3Rk1FNXBDL2xhaFYybDk0aDk5bE1L?=
 =?utf-8?B?d3pMbllVbDhLbGNGRHZuK2xlNTY5NW42UmdEc3dyTVhscTBob0lqTlFWb3Zm?=
 =?utf-8?B?NzB2VE5Ra2RWTURjNCtoakZBQmI0Z0pyTzA2cFkwelBqK0xOZmtIRkQzbDhQ?=
 =?utf-8?Q?rcCy6kmt9ovuR+oTnDeWgz8o13J9WmQpxPpt7?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f5e3e9-7583-4f9d-c243-08def8b045bf
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:28:30.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWfz3oH+dXgaAwACZtzhXQ3uKIGV7eNmyphJHEjAwwUuqeClQMiXuvw/o/A19wlg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3788

Document ASRock's X470D4U BMC board compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tan Siewert <tan@siewert.io>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..277c0e03cf48 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -40,6 +40,8 @@ properties:
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
               - asrock,spc621d8hm3-bmc
+              - asrock,x470d4u-bmc
+              - asrock,x470d4u-data64-bmc
               - asrock,x570d4u-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc

-- 
2.54.0


