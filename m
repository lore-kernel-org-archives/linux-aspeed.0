Return-Path: <linux-aspeed+bounces-5049-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C5DC9830D
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Sep 2026 05:12:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrf254Pxmz30WX;
	Fri, 25 Sep 2026 15:11:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70d" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790313101;
	cv=pass; b=b++Ek+fNF3d6RVpuMjy5Kp+gdXLT4eDfqHxcsfPUScAsmbBsVFHlGBbf4+fKUp+paQV0X6bm1LMxBJo3xUHLYNUIcvXdmd4rqE8unPkQuugzRourqFixN/YSVcJN0zWPf3uQfATV79lJNh5JzBwKZRkP+smD4Z66fQbBisMEsLgxGmmPaWWo/XmnoqJYTsZOyvR4WQWErzNy0lZ4h6I8d/r2We6ekpJo1NLg4GlIjUSDx5aqzMeCfUhIAtEFEla2p/o913naP3XhMjXfQOK/mmb7j9VxIBvGE8ujYcRMDAEDDujD6v9w4swroPZ6l5b5SOG2Icm0G1HoZbH9q/cIhg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790313101; c=relaxed/relaxed;
	bh=7unK9C60F3eCtt/t23kkhck7RBn4yndb9g/9BUhvWMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEf7ChwxRVBKp/0bVuLctEQhQixMnLiQVMya66MKH+LHDWCXgxp7+rfdU4aywch60oaUuP+2EiSrAKIha4nKcI4gcLehxDAbnROwNDbn9qNHY3XRsJ6Crqi5WHyZ6RmIl8O/yKzkyjwDaKy31qsvLSGeykPUrp43s+UhBaOCeYQvhUW4kPDjSLahLwc23JO9IhVpkE6eJJon2x9TK0CAMOMaiQLnqHjBPOqueJlE3fRCtZGm5EDNQ+sU5J/Raq8xomkZy44Lx0SwIsL+Rm3WEURISZtsTY4G0zEnniZRN3GCT5FvTuQeMzjMRLTnpsduJmDr4dUnoq4X8aD6RhJvkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70d; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70d; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070d.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrf246S2cz30WF;
	Fri, 25 Sep 2026 15:11:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp7I0WAqL+DLONYf6xMLrLYDc30mCokLC4bH3NdjwIgL51arBidePpcsb226j+i2XJA5eQfUO8i6W9BFkVe6doqwOOjbe42BOvPpBS/Lzk1jQIdMIiZuSTP25o6Z8yDSp+I+ZBtZqFIftloL+qB0mWgNFjzq/Wpy7NgMCav5DpkftmbGvm8V7CvsVlkYMSqlEMjpSdT04iyE0XNEUaIVDf/EpY+GoSJ+p/QOtxz+WFGpTi85Ih2ubVEzJFyEdGb/b6oozQa6hrd1+SOCtWW18sZU5oCgc76c2qNGicCjgDSKd8OYu5GJSRzt+PpBSRM7Rz2dMjoPEP8BXIc0aE6y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7unK9C60F3eCtt/t23kkhck7RBn4yndb9g/9BUhvWMk=;
 b=eYLZ8BJhVlwTzs7VBshTDVtTJrd+EekG0LQNeGKBlIHEXvY4Tn2pzjLJN4gkIieLVH4I1ji0zqqwxhl0NSrzCqRF9oXDziJs26/ouJLle69mqJ8KGXFZ4irGpBmW+sEHAHjXs1J2FMAuAJ4ACgGVl/TLiqS1GhHjxpDuvQMhyddH/ssyKrt/tP5+8x7O2qeElZWp0iOrDaf1EBaYCFO13lLfi1gIYMdZAg9TRG8J0Ib5HPw4S0XQ2uMpB5lZ3Twes64yTyFfrt5IQjNsWaDq92Eq6IdiKl0xlZ4NeSjP1FJ3TYHNGuaCcd/+4jJTDVddr5st23d9wSuENxqy5yhFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1169.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 05:11:07 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Fri, 25 Sep 2026 05:11:07 +0000
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
Subject: [PATCH v3 3/4] dt-bindings: soc: starfive: Add StarFive JHB100 UART routing
Date: Thu, 24 Sep 2026 22:09:46 -0700
Message-Id: <20260925050947.9900-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260925050947.9900-1-changhuang.liang@starfivetech.com>
References: <20260925050947.9900-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::17) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1169:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fa7e3c-304a-44fd-844a-08df1ac367c6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|10067099003|3023799007|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	s+aDE07UyyUgCS10qSnS6wa2XrZf7o/ySCTcM2Pyh04K49pQNOxkVQpQoyGTd+iNq3gavNB5bsONgCax0E7l+0YqGUG+zelv/EomB7ZiMNLkf+c5YosVGewIaEzpDPVmqJkqkk3yyLb2U1CJLAGD36Hr8eaHnbG4c1FFPZ7EcRgwaNNouMtkvkigEPt+CfSUI8bpOOcSvQvJQzt9IVzbOzGRJA0dBt4X4tG3sshfIBrL/xdauhLuG0c/tp0gpeA+0L0wPyX2ExmDzNc8+5lU3Z+O60WZ30mW7IwHVmU0QiFuuTLuyPgkGehxoEOrtnpwQCEXMOA88v/cpWEBgzy/nfYSU/KWIZiH9rxiEhDtKCRFjIrnbB30fzAC1zB5cT2cRdf7LDOj2rfkm+FVFkoeiAxipsBZOx3IOBw0Pn2QJNe7mNdGzEyIafBq6B736pTV+qyGXkKPRpqzH3RLPiJKo+OcGgesx+BfigGn9mn8lrHaWz5wGD71R4Ze38HoRCB/0FOke3aC36WDdYgrGOl4XB+fYJdGGlbtSIKkS4pskhLd6vAmu3vpeE+OU5XEVLtX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZhtF26ujL3m+dxbo8ULcf7Y6UjbJYXh3OkJXhU82MifPrT7RysMcoQbIf3ax?=
 =?us-ascii?Q?nc6bsofRQXxCcIKg81C6Aw/z0f+wQKZTJZbK2g5R6trVhjLBl43BsSYU3fNK?=
 =?us-ascii?Q?iKn8V9zEQScjKpuK1dvyOZ7n8EE8Dt3SWnqQfvOlq81nW7EHzvZG56KIv0Hd?=
 =?us-ascii?Q?EeHrU7VPWfbcb9Ri5sFYZYvP8lpPN1nWKMlejDmDJtj8n88a3pzcl9n8m9gN?=
 =?us-ascii?Q?MoRpCIerxzg8k6gVbSrXMATO9yyYH3hGUTj2S/t0FzwXaNkMjqs7hwx4IZcB?=
 =?us-ascii?Q?VLmJWYujCI1LQJrqgLFtq0MegmlQadnwOBJam70UribATnae003xvMdavacM?=
 =?us-ascii?Q?Nya2TxQEzRJPfLIyojm4zptsYDY19ZuPO39neKgs/QfV5bzekObfgCdbJ2H4?=
 =?us-ascii?Q?AZ9iCU0WXHCuQ/DqB4t2kiU09g/rM2OqP65tBPirFySnqAw+dDMbXzYxv6A3?=
 =?us-ascii?Q?wJELj7xhaOxPdxwUY8POb62dYoqyeeQ25wmij8PW0HzpbNdmSrvUIuwZ0ywi?=
 =?us-ascii?Q?I6dFdapr3xnUUYQKcTHvy2k9T3Gr9RR3QvYZTgPx/k1z3ZFmhXy3tpftTWjU?=
 =?us-ascii?Q?R1Q1PodIRP7hZsXX8tekZV4bTUl4Zq4XQNvyHIuehum7k+OVe9QsPuYNu9LG?=
 =?us-ascii?Q?D+xBF4OyMKYiFr0B12jCb/noWB+Og8yTIcIj45ZQyaKbIDIZWl3FdUVMBo66?=
 =?us-ascii?Q?hAr51bHbOUa9K1aq9YkcxBa7PDFYa4yQP9t0Ikig+3kiMZ0jxJKVb1KECvIO?=
 =?us-ascii?Q?WW4hfethYMPt4MUsxaA+6zsQatbVc3Zt1CBfA/hec/vzYvXGVPknnVHXrIcg?=
 =?us-ascii?Q?1foDS4uiRQcBdO1/JBJT6Czu4DMF2L+iuneAgllzFV9auY/i/WRY7paifeen?=
 =?us-ascii?Q?0b7neUhSIdXquFucCEgtX+72rcLqaUwNidDo8KguJpPa7HvSa6HfDAuaAInq?=
 =?us-ascii?Q?7+4NqoGTh5GFV5XsrCB0+eSijHioNndk6j6D4NE5FqOKgtO7GlhyE21ldF7Z?=
 =?us-ascii?Q?NM5PgHm6SD8fwzMTXBjlo0gmPfCl6C1pnjQI/UUfQDeswzrF6bEKa8Xp0y98?=
 =?us-ascii?Q?v5BRHcvXT+//+a7UHK2PVJmAnw6PaJ7Ub8DG1KheLeArt+5XVQZD+XNIeob3?=
 =?us-ascii?Q?d4n8Ljt/ColKovP+zluc29wOSChehqbo4JW1Av2qYWtwSVV+OtS2uUl4vcXe?=
 =?us-ascii?Q?je9XykZNDb5BOg+fAaDvS/md3EDpjQ+5cAyZT5GLixS9VCjXS5UbcqRcKSsO?=
 =?us-ascii?Q?PFh6YbAFWoU9YHZYoTJK2VqQkvkQ47+H6uH2VaosRXyzR7KL0MTSJ5KHF3/H?=
 =?us-ascii?Q?wjZOtFsE030avxS3j5rZDJ8UKL/0MiYTnnXVpnNaCS0og0hO1RROzUbyGwZ+?=
 =?us-ascii?Q?X4/dCE2zG++Aa7gxPBIVeh3cEZx5ZtPNYmJFnGTK4fc9+blUodDYUhCec8JW?=
 =?us-ascii?Q?7206mBjuvRS6AhNWVRWWOi0K1LODIGZHgHef1I7a6xxDSkmOancsVd/HzhxB?=
 =?us-ascii?Q?cexKnBCFZ3kbBtXxmHOm6Q2hnVViJB2Kzbv/S1RhrArAx3O8nOLQVrTVTh9L?=
 =?us-ascii?Q?ssSvEbrnIz+rYyWvqK0fw/ZTXPbTXjssuI5AUUHaa8Gxh78gr77c9NQjBZ+O?=
 =?us-ascii?Q?4rA34P+o7ddLmlCapSClr8PlvMvBfqOV1M5Ky6IwAB0md3kXcNCBkoRQBqGZ?=
 =?us-ascii?Q?Cxb/lGglVoKCcLmM+OTdIyGwTiClzASDpP/rRj0+AQc5dEG5fuQfRaYJo08z?=
 =?us-ascii?Q?KGgwTQmzLBS3N/HD6fdlgc0RnDam8puI57gaVauHd19KZdLdK6XS?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fa7e3c-304a-44fd-844a-08df1ac367c6
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 05:11:07.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goyoDbttjJ/qAfWk4WhURgFtpD0bLI0crJylJRjdKEmX73adzTdiyjl6TxbbPGw3nMzpWSGM8MzqQoZvbu/JoSUvpuTzAeyEqbM8jskbh8TRwp2SiabNru7YJcNiaSrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1169

Add device tree binding for the StarFive JHB100 UART routing controller.
This controller allows dynamic routing of inputs between built-in UARTs
and physical serial I/O ports, enabling use cases such as Host <-> BMC
communication via UARTs.

The clocks property exists in the hardware, but the driver does not use
it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
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


