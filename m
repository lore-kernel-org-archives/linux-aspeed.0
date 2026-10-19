Return-Path: <linux-aspeed+bounces-5225-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACC2CCF2DA
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 10:08:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WSW0p4Lz2ygW;
	Mon, 19 Oct 2026 21:07:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792404459;
	cv=pass; b=lZGDC5YB5P90phGoYfoDKp+IC3bfImQOQl5lTHy3bbwdEcXDhP5NV8omo6Te2jeJwkeWu7roR8BAQwHeYlvvncDDqDZa83HJu6BctgjJ6GEL/+SRq96AgWjQeYaqCgGaVuIL2tYP8DLjrl7oYY10SjZcurXqR/gBEZ2b6d5vTa/EqmwQn0Ak0mMOvFHfnVPxbeqVVuo3ZM2tusWFMKOMHHOtwum2YUBUwnCIHZ/Rt1ZKfDeV33+jUE+tKlpmFmhmVM1vbeCaK8mSKN8i9WUcV3t1uTR15jkW2FiWmsTf7N3+7dYh7DlaWwZdkTyKQ6i33445AJiMl5Qzadh6P/vM6g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792404459; c=relaxed/relaxed;
	bh=15hUMvN0PPzdUn/IJzzq8MDlV86NiVKJxdczp5axw50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n5H1aO7RRXIbEejAqChnfqDZSXUp6guMuOmFAnM0hIugqT1mRZP8mL8hApVPflg0VTE0RmY33Djf9SRsMYFY+muGUjPRIY6Yc26nU6+jwJOzt5zlF4K8hzz2m0Ems185SeL0yh4yWBRZIIO0fn8x/SEQzwrYmFpLFCdgbkA9NZ5t8cF+Xj0n1bAyDK/cs4H40CQoOBYG9d3DcY9knRx/u2lb9sqoQqoZxIthLtnGEjMPJ0uwnDTZNSakdGWHJAgQB0iUABBacC026TYYm8TM+5yc5842uqM5LvwtV+7koSrAUtZBw8H3lfyvZi/VBZ4XZ6C0GcIS9Uym1IMQ20cAhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070f.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WSV121pz2yqF;
	Mon, 19 Oct 2026 21:07:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMzKqhc+Qqnu/4oK8V8AS+EKOVcXnpVnZ8/MlMn+/TfCHLcsiOXpadHPCd5tC/tRiXr16Gzf5UES8enUVMPWrsypNzk2JNXR4tibAXcU3n3d+4kNutbKTGfV3GJY0ngkzDSZCA5jxxHkzosm3dHkMdjSA2z4oPGGZ8t3FaF+FJq0bJBcfj9cjdTg0828lIqAB1LARmVJZc0wUf31DtwfFGDHORALhL1EUXg8vQfU6rYP4utHlcd2Dpa1XKXwqseFc9M/J0Iajfw8qDtYs/vcFdhCQrwwsvTLS0QsymwlVrt0/dDkrCXHNAI1hUXgdF7y3DZuZOCrfQuCVwKek+21CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15hUMvN0PPzdUn/IJzzq8MDlV86NiVKJxdczp5axw50=;
 b=D/tjaPyz/BfaYrJqYYaGbH/qlUkQUGej72woBppudnab6ZlycMtJgssAOBJFcbg9A9VRi5TYl15LGs35AsVx0G1VRCUTv1AFV6A8mzoWCbBYIiD+J+5vCGljrTsfi83DmivB6ROfLJ5KpFNX42+hVF6uHdDZZSSQMt0og4EX2xwlQkAFGFhvfEFZWrmB6PGnrmMV22pTkb7UvO3lhceDjPNjef2mVjvqSlSNFNCf5HEXrtVN01K6ouzdDOL0D2vgdd8gzJTbPWwMxOUOX2AuUh4YwlT0Zh0NIr/ek5iTzc4HAvEZzvUSW6XmO/5hvx8OvYIvzNEkPvj5WgT/8kuqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1204.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:07:03 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 10:07:03 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Oskar Senft <osk@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Vitaly Lubart <lubvital@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Breno Leitao <leitao@debian.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	James Morse <james.morse@arm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Julian Braha <julianbraha@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v4 3/4] dt-bindings: soc: starfive: Add StarFive JHB100 UART routing
Date: Mon, 19 Oct 2026 03:06:42 -0700
Message-Id: <20261019100643.49099-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019100643.49099-1-changhuang.liang@starfivetech.com>
References: <20261019100643.49099-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn (10.2.10.20)
 To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn (10.2.3.102)
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1204:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fad4be-8837-49da-931c-08df2dc8b953
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|52116014|18002099003|22082099003|3023799007|10067099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	KJs/p4/WYcehR6w9dENBaKh4NPikvRIpEI7XKUmdd0E52jQVNFXekW+NHvLk9F0VzwRNORVba65RXAtTLDPnl2vU4U8cJZh3Vmr6d6raI6e6V9bU5VAJPgnse7qwPuFernhG2UdOCVbMiAFJfariqkPnjN80wyhXtMgQBM20MEOaOVjZXuFUoMA3Hbqu1RKiOuTVvQo2LT86BwbpfzgjVmOoMGF30HdjNn9/+/HO051Q+aHcR+JEIyZyyVTuCuyLA6oE/l5xiebjtGyUvfYPdO89VpD3HXxWqzo74YyGhJV1V3IN3dpXZXeFVQaF7QIz0OK1eNWggmFD+wESWG2aR+ZGRzuyCArMwAy8r1nyjaxIUXoBxoRJCJfeBdyrjLKcdusE/3dY8g9afvzJ8H7nRghCpG2AOSkmRZgelArp6dIaG6wVCaSaFK6rI5ePE72y6+9p8diQ+6IbmN/smzbjxFOGF7UHfrnhUDmo2xfnuB5yQacsT1zVMI+c/Cx2Ba0Fgmza5mkFea0i+t71uXng4HiYP8XhVKbS+eHQT1UW6DUib/o3GBsWXlg1KPjVkibS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(52116014)(18002099003)(22082099003)(3023799007)(10067099003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q9ktnBLEEjSWHmS03DQJazSoPHtkstvI//g3gYU8F29Y05bnC10g01BDB4Xx?=
 =?us-ascii?Q?UoLMym602rZ63W82wRNRuixGTEGGRqvAy2ZXlHiFnqqV0ZGlLezxRRCdaCFE?=
 =?us-ascii?Q?6Uv7fFZ9iGB5+a40SMLdca43BIe7Hs/ou4J8Bx4us9w/U93hMk0971kv0EP4?=
 =?us-ascii?Q?yohMWNUq0uB/8RIPeJ3fjKZLkLmpYY5ZJaoOquB1BSQCfJmikBbWaCUc4eLa?=
 =?us-ascii?Q?5Y6O2Km8Xwf663iO1q2OIVLRW95Bipdd9Racd7KleOP0Out8vUMDjlu7nHiP?=
 =?us-ascii?Q?9Fpx7T5D9SHF7VFj1slcJmqT7w66p1k8CylY1uAS7WYY5PI0yE5vY/UOoJMV?=
 =?us-ascii?Q?4NLlPvGihP26UHNFNXIR7w4kg51WqSGwG964p39QwhK+VcUj3/1W/v11zLrH?=
 =?us-ascii?Q?uIg3Aw1J1A4/b4ykdQUV5i8+u2ZLExgtio9na6PvsHlSQlGGHQ4iUJyZVKOC?=
 =?us-ascii?Q?Nc1qa8FgP+O4mUBWm/cBw+ZDoed/fuBjhOlxLFMw7SZNdUrds7tUwaA5H7wS?=
 =?us-ascii?Q?BqrlICyqA2LefxWKYPl609o0izCt5yfYUJxBRsoFvofbkU6Xl5tnZCLHbuDm?=
 =?us-ascii?Q?aLKwqrtgfTIuQufN22PxcoQ6TQg9DADQ5Qh9SMuKRowlkcXQMNqHS/ZIu4NR?=
 =?us-ascii?Q?2RAYu+GAHzT+xfjx2Likl3YGBvylinXIhzc2cA6r6g2aUhKWm37kSHnwMMB4?=
 =?us-ascii?Q?t5sQsbMyGisOo1BT5TQlLH1Lf2Sx0v8vX5iUNgQvSnLLxRO1/pDsuSW9EuvG?=
 =?us-ascii?Q?D/Tp/eeOw1+vAUwcWCYaXOt2rx8IBuPbcvZmaRSCqeyoIXcI0yXDB/X7FRse?=
 =?us-ascii?Q?KJiXM5ADeT2WTlVkS3LBw6OPxrCUP5GCyED9HtsAOM7YRSSKSOEOouh75pIA?=
 =?us-ascii?Q?DN1CxNgly9I3lwS6JQaVZGFzp0gTg/0w+7oD8dwNQVJm099olZFACUBE9b10?=
 =?us-ascii?Q?ONQ3gvQwfpwSYmQex6NBn8nYu8vqK8xEKIGl1UI9vBrf2S5JjZ1Z4FkI/vTj?=
 =?us-ascii?Q?MAFO+dedEAtgFgocV6jHA047ida8woV9m/6Em4XB9ydwErELdR0av3w57gl7?=
 =?us-ascii?Q?5VJz68M0Cx/95wh/1xnnGHVmGUzUENOtv8iBFXlHg6SMCHCSdwLWMEGoyJZs?=
 =?us-ascii?Q?Qh763G2MnYYzmOStrbt/Dky+Lft7qPdXSM9uQteI8x2Mw8Fhgaq4cz5PVFZJ?=
 =?us-ascii?Q?0NEC77eZy5vP7XVf+GM76khTJxRJy8mveytMSmhkH7XlSSABqpEc35sToAmV?=
 =?us-ascii?Q?FPHYWJb8ax5ESl3kAnJ6fMmXgnsEbqC0IpVwBBP8LWBo04HCuPnKRnWrtSw/?=
 =?us-ascii?Q?tI0O3eV6i8W67KWUdKoK0QM6r/IJj2UvHobKge3zelS4DCvgF430xo81havo?=
 =?us-ascii?Q?JfQzHA0znPdi3vW7H4Dot2cFL6HZvY5n/U2DQBgxVBuOW2Ip0/UgniLewu/M?=
 =?us-ascii?Q?p9Qs/vNHJdcAeNJW/3VGQtbJx9JCLwSX2aYijhrIf3wHmFdkrAGaTzrItlQ4?=
 =?us-ascii?Q?Mcdx+t8J87NIhL1agQVuN4rbJE17EhI7S+ITWPCnSph/IqXsavVCVUxHD2/x?=
 =?us-ascii?Q?HkKiZ7lYcMM69vO09uxosWCk2572kt/jMz7wMEnY3pAn8eiqNRp7DHdiF+Sr?=
 =?us-ascii?Q?k6ruRUoNAGWxfA3mV+DymD3c2AEH+u//B6SA2VX141po9692P+69Wfk8PqQA?=
 =?us-ascii?Q?H1POF6hJkLwZdp6Pm7QsJTv8E4G7JOZQhGu55PLhnVlQbF5jjvyCQwOH6frn?=
 =?us-ascii?Q?PifiN0yhFwT/vOafp6gDId8hbfw1fAnVn2JP3OSdUCaMti6PJHh2?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fad4be-8837-49da-931c-08df2dc8b953
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:07:03.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/+XcDsnacamgFVMk8cprd97whYURy5I1VIpQaCRYkCX1TepMctlwvWxt6EgnhavPPpn8M3vMJeArsAhNlJW+7Ws59OoD+3EeuMZy9SZT8Lx9/629aDn25ZwEdPBwzgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1204

Add device tree binding for the StarFive JHB100 UART routing controller.
This controller allows dynamic routing of inputs between built-in UARTs
and physical serial I/O ports, enabling use cases such as Host <-> BMC
communication via UARTs.

The clocks property exists in the hardware, but the driver does not use
it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../soc/starfive/starfive,uart-routing.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml

diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml
new file mode 100644
index 000000000000..5de809ab3a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/starfive/starfive,uart-routing.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JHB100 UART Routing Controller
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+description: |
+  The StarFive JHB100 UART routing controller allows dynamic routing of the
+  inputs for the built-in UARTs and the physical serial I/O ports.
+
+  This allows, for example, connecting the output of one UART to another
+  UART, which can be used to enable Host <-> BMC communication over UARTs,
+  e.g. to give the BMC access to the Host's serial console.
+
+properties:
+  compatible:
+    const: starfive,jhb100-uart-routing
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    uart-routing@11a42a00 {
+        compatible = "starfive,jhb100-uart-routing";
+        reg = <0x11a42a00 0x100>;
+        resets = <&per0crg 74>;
+    };
-- 
2.25.1


