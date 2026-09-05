Return-Path: <linux-aspeed+bounces-4963-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5F0C79F9E
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Sep 2026 23:34:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdRPN4t1Rz2yvX;
	Mon, 07 Sep 2026 09:34:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4440:2::700" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788605090;
	cv=pass; b=hdLxZzR2saPM3KStJFf5e4rCrECh/Ciqo/F6yDDyW5fNtbGOL2kWAvLZcVAcZ7P2RhCnBOsN+jVtoN/24Y2oFeFSIxyVyED3iacQET3dnS1Dc8CxnxfqddNt6KGmDnT5P2A6o5j8YX4ddP4SGqGCuBKMYdJtGo/eqAXt038CSe0PFv1ybjc38V/E//eeGDEEnyLHbuBk6aIE/jfqTUaD+ely+xYYc39MG8GR307Nty6gz7Gld7KnWVIJdCxkPM9bkyo0vgTjznhmlWLqiV0dpX+5mRNhWreSKHuJpj9fXkbOQrEJzxXcRtt4v62AuIjv9QWiFRM1Bwfv37ywVpu7eA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788605090; c=relaxed/relaxed;
	bh=3fB3/oFUiPdNbZRmKDrxxmki7FgIcXOoLkC9JCNJWpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQh87Hxv6a0yfLuH8OcZ4AKTKI59bitzaDYrQ8ZZEMUv9rEc2oFbvFE3VvmimLH/I9iDEe3Hw2xhgKRrZgsjollAaZqqKSVo0+TeXGxX9npmFY9StkAHrLJba5g7c+N2Sl6k1sk6UWWsxm/KlbRAVZnS7VZV1lDIp+vzwjgIm6jrGg9PO4NoDlgdc396W6xk8fGtZfYD8TPL42n50qjl8qmr/SRyqvW1XjD/HJJk37h6E9NXGDSIMICvbZKD2KZpdp1GGVT8iLPgaNoJP89GcNcLHC0lylY2yqNgyxY/qoj2K7vo1qduxVaO5T08Hri+VdBeDkkmsyFhVdmfb/jiQA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4440:2::700; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4440:2::700; helo=chn02-bjs-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on20700.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4440:2::700])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcVMk1BTPz2ygK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Sep 2026 20:44:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDGl7HpjngTHihlm3MLlWJc3uRBRPTkPyemwYgd2B9sSL9U75ELtzUjyV6uTOGG6F5n1Q9ne8eVMIOmmEjtWkpYT8IAWTtKMWWH29dprbKFoWbZZU7pmSYhj/cpoGc6iwRVKA7Tf2bJ0bKnwGCWthgjbiOX4TyhfQItu6eIwhS5eFwJPeilC4LC826TPf1ptK0hn7uwCoR86TD1wyqqJd4bK1Puam4yMXuYCJCXEzKmk6zJ6GiM0b2B68wUB7ZSGM8d7I0j++CLUAo18WUztkywTN/MsSxOhg9hvQNie3Or+lNJfjg83OdL+G+CNFKyDzyy5kIp7HTCnPQaW9r6RXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fB3/oFUiPdNbZRmKDrxxmki7FgIcXOoLkC9JCNJWpA=;
 b=WLMDhM8RNlIqG47QZUdu8dHk+pbIQl0DGmVF8bG0TzKsJi0sRtLvI+z701NDfli0EKP7hE2qFDrmgxWZOtMcgA7yE1EWE7MABFAGCGMzwFaG9CGlc5dhdsd7KlnGjNYkDpLHSqEuTwT4RoHqLcYAxhoUMogIS3RlExerLV7ITPaFvgFKUfjlXHv/ksascCYhU4H6fxGZDVtGg7clhbye0IJJ6aO1XIjHQf+I+Odim42MRjKoLNmQp2TUAIlbVO5iT9gWW0pylGWo6+7tfkIrCMRz83AJpKBmKRz3TxMlNjshXSiDES/rM2Jbk4dIiw0UVw3jBtSTl1PsnMsPWtWUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1329.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 5 Sep
 2026 10:29:23 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0315.011; Sat, 5 Sep 2026 10:29:23 +0000
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
Subject: [PATCH v2 3/4] dt-bindings: uart-routing: Add binding for StarFive JHB100 UART routing
Date: Sat,  5 Sep 2026 03:29:00 -0700
Message-Id: <20260905102901.126035-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d854a5f-0d46-49ab-d473-08df0b388d6a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|23010399003|38350700014|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KhwJR5bgD6sFqaFdZ6brp/QTstw8JZyU3Gkfe5NDIvie9CtKpsSTFsZx3/Qq740oUxH9QZVM5PEhkUAyqHa1beGftauYNwxUHvr3fRRSBryZlBb/SWYG0qmqjX+hQIlflBzq7rEi6BlxF1tIzL/WyVBJJ3Ifd7eaxymYSVGq4cIEvosMeaSCFkc5ZRDuhspz3jQGlTLO8SzyOe1rKbcSEEvIFC3z+KaLuu/tYW2xcUwEwDg0wjcjOR7Lhydf8Y2+G7B2oz5OYfVcDXPfvYwCHKf/ykVpWpzYalGgdU6+n5bfX7H3+t7C3R8rm5RiHG/4/SgzCNRv7flKy1NEPQepnr/PQs6fPU8Pzdps9PlHCJFhunyiYpo/kWNSO3tDX2NFwWevACOR8z8lmmRPwAXj9/acI29krkRu/cWBvJKELXGgAhQJbsyrNHIXgwDOntiYyDrhsqOaxKPcxFq2Q6QP1Es9EIBbJ1mrNcl+4wRap7bjRFhIxJx0LI4M89GLorhjEcA+vp0AtvJ2B9d6qv5dFYERgpUlIXTaUXoHHJj8+0jh1aPFNvb+0h3eOJm2gGqu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(23010399003)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHK+t1Ymfnl/ijawcbM6x61uDKMoXr3ljApQQgmb6v32WYEC5j4ysWAQcGZi?=
 =?us-ascii?Q?AkfrcO4hoz3qPTBJeo/GtA13papnyHx7mroaOoiRZGDKj9VitGzGb1k4xDQB?=
 =?us-ascii?Q?LqN19yavRV/m/DHYftI5Js8AtHz8jsrIiQcGhQZBK17ryRYT/Q+zznedzkyV?=
 =?us-ascii?Q?zO3zEhgaXZMbSRuP8q4lRdUt8ehBtAYaIe/Pw5bK7karMiwAKksPsSPjai5Q?=
 =?us-ascii?Q?e5RqFjkGtH0iZC5/sSxhK2r6s5wvdWSXP+bZ7Gj1huNqVE0TjvMacM0pxOwl?=
 =?us-ascii?Q?6QAk55oFytskQEZ117nGR+cdLwgag35SIvp3XDTF9I289HO/zdgBuOaLXJ7p?=
 =?us-ascii?Q?+ib5vA0urqkEj0huR2/HdqE3TUzhh3YBrKez9v/glJdFc3tvB6k0ithCPQd/?=
 =?us-ascii?Q?7JW9EvIrkmltzT4DzVjvrNfxTWsD/FSNhpg81aWk0liGWjugIWM8X23jdRPC?=
 =?us-ascii?Q?FYJBd/GvqTPV2kHAVBJINm9uFeYikj0z6pQ3wfFmZZzXbM3jdB8sYoWljQ/l?=
 =?us-ascii?Q?s4RjOxwp8CpnWgIr+wLfaxqbO3U5iqSjW57/99L0NW4opD9pSfPxNtt8TcQF?=
 =?us-ascii?Q?HOA6g8FxEuVZfFMozUwmnEN3NQ+QL73QDwfLDgf78dDxGu/6dCcyRmOcjf7X?=
 =?us-ascii?Q?+3Xs6uev28sNEOX1DQC5ffx3L0FikKUQLXxNohVCHLvwqOOmXB+XZ2+rOcn7?=
 =?us-ascii?Q?OTbuD9MNd+KhmGmQbf8XbcjrXRjIepFDefmZ4xJTaffZ9u9UB+wKjxa/G35p?=
 =?us-ascii?Q?8EhrVo28SCMV4V5AleypJYMOFsmsV5STpfUi84ZoyXKhC3ocVZqBcGZo3WPc?=
 =?us-ascii?Q?HaXMXujJMEElHZ4xmTlcitP3bDRpPfa0o1wwjGpOZVIshdBILJU9+0FLQmtv?=
 =?us-ascii?Q?xCfhq+MzWS65Pqgc6KwTY4PHB+TVfd5kPDBMtusccf2Vz5AyWJ/f7One9eXY?=
 =?us-ascii?Q?2LzQvYa2Dc3IQ5PpbStZUCpBK8fyDoSh/LE9BoHMaZlbMjRE/zAuQe8ajXOc?=
 =?us-ascii?Q?xBzlfXHHRrR/zHalm1pO2seBgHItK7tlr0Jn5xeWiqKBTXwGgl7CBUVbxTC0?=
 =?us-ascii?Q?uiFS4edYGdlbVcRKqUdM0ruS5kSje/7ra7vjbffRmpkMBYmoAvkxHVyld5IQ?=
 =?us-ascii?Q?E7pcqxGIKGzSK0KduvH03vzlMb1zEW9dSlj2fE0xJ0OWIXhM/n0PhQR23mWT?=
 =?us-ascii?Q?wLe6kPHZi+5Ln6UvOqWJOFgykdQAQUAwEwsrDwp/ezSYBh7UwXk6naQnQTCn?=
 =?us-ascii?Q?Q+JNq1N4MMwAVvB9/lsdE3ihWvQyDbWeMatMNd5gKi/wLCBdcVhb7mCkTMgX?=
 =?us-ascii?Q?4Wh5blnRgKkfNElmKgxOcDgToH9Ih0i48buT3QOzvcHJudVyTwnp8z4PCmKz?=
 =?us-ascii?Q?e2CWFEqrJ54nqtwpobu6zH9sgeiD73bj8IQD3AcKa/s62fbtKeHIrOSzNLI2?=
 =?us-ascii?Q?7nqUapPuXwwJ8DJ9s4R4yAzTrCVynyMRXl4EDzqVoGJq/Ls9KVu6blMiqcBl?=
 =?us-ascii?Q?ml6VG0JTr5D8l4T0iezqBmVg76/tvx7EVYIqa22BfLRWvdmh9DqkYvXgqIoN?=
 =?us-ascii?Q?Q9dDSeBQDXsrh4vmFXEo415QCnPnPeXqVWiJWu+Bt8M0y6KeGTng9lUvx8Sr?=
 =?us-ascii?Q?1ngjJN+swTIKmmS5mSY8+yCfF9CKI1l7JnwW9WEmBb8gD3eBiMrLhwZVqK0F?=
 =?us-ascii?Q?spMrDCWfFXz0kVUdgPf1x4zavRn88NlssO3IViiEpJ6x7loLA7NF0ri3YnCw?=
 =?us-ascii?Q?DkEi4xgADkJFcj1w7McnofuLyITD9xIGXzwGCdaoqLZMySnoCJux?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d854a5f-0d46-49ab-d473-08df0b388d6a
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:29:22.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5OL1iUfifNxP2kGJaQ1XQsizjoE6CyijukUXfs5frO5zjfaLp2HCQTxWrMyYqmPakWW7zWOUEtdSAMWRIIniFqW+eSvJhklio2yE6VOh7aLdo4gY5le58Ep3BS1i6yp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1329

Add device tree binding for the StarFive JHB100 UART routing controller.
This controller allows dynamic routing of inputs between built-in UARTs
and physical serial I/O ports, enabling use cases such as Host <-> BMC
communication via UARTs.

The clocks property exists in the hardware, but the driver does not use
it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../uart-routing/starfive,uart-routing.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml

diff --git a/Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml b/Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml
new file mode 100644
index 000000000000..1977f2ed20a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/uart-routing/starfive,uart-routing.yaml#
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


