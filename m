Return-Path: <linux-aspeed+bounces-5226-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73104CCF2D6
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Oct 2026 10:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WSX2FZCz2yvW;
	Mon, 19 Oct 2026 21:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2406:e500:4420:2::70f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792404460;
	cv=pass; b=i8DgbYEFq6O40ek//yDcbtgKnPQKH8tLA/GIy83I78kvFEyAhaYhKXNFldG5T1VVV/1kqtdJSzcln3vruFJKpNQfbpu1gE+X60eJqIs9PJ1ojsMv3U5C3kXbx9G55CzShkNpGmGKAFZ5+IjNuJOPTEkncJQUtw9Q3CoGKEG5ztD6piD7QOiQI8lIkjp2NCwjZxTIgayExSIelYmQDGpnhWEKbrtVHMRC5gQMngjQxTbFcSvlWGubUunVgSpXTI6Ya8vTMJOfbm20J1lfw2TLCMcVr4TZmT5an3MredVdjD7V9g4AkHkhfJeQ2Yx2NoyxYIetrRTikQgIsX6JLoVw4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792404460; c=relaxed/relaxed;
	bh=vkA12XMrXiqIndxUbHSga3MwcvfxER+D9UiN0/uDgoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxEZZVNDSlY2+S4qYxp0DfaV4jhtoYGOXG4+5P6P3hUJ173qXbeiHbsEzofJmx7yq+6YWrZ5Q4AlHw7Dw0J5SNNA2hFbPWL2/h57z+mSmhLTYjdNmYKpC0A7iSP0PamE4muF/eUvejCxvi4DoVene37pILlXuLAErCJIp7aFuud5NLQZeO0/qSgoerXswGOLKVy4ksHI0yGJhgCgtapZh04mUpch52xohF1vn+FMnOcJdP5ViJgVYQkCYSzDdqGXCd5+zpegjsfQZZ0gKcqtw23I1Is0ovfu+bHQxyq15wf93VJQmjl0mnRKzsaqyeibNI2A9wLQTsR3Ogp+4X0QnQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org) smtp.mailfrom=starfivetech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=starfivetech.com (client-ip=2406:e500:4420:2::70f; helo=chn02-sh0-obe.outbound.protection.partner.outlook.cn; envelope-from=changhuang.liang@starfivetech.com; receiver=lists.ozlabs.org)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2070f.outbound.protection.partner.outlook.cn [IPv6:2406:e500:4420:2::70f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WSW2Pmjz2yqw;
	Mon, 19 Oct 2026 21:07:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpZFY5n479qDGEF5HDmSpoKWsgGeJyxSNuWiPq/VvJuJRRE+LpMTey0RDYDmJmcG4nFrKEnJU8ozdrnY68VWCxoycta9Tp7uZR3znHD4ukcJnB4Jg7xzG6D9dsrpn6/RfpVl7NBOC7SOPUCB1Hxa0O2kwAO7SEd46qvISZtNHNUqYq1V/xdVzYe8p56xD7WgJetME1AmvpqI46jEnXsISIi/f8laTOBF35Ff1Bhkb96geAQBabSpXZtf2QWwYtk3dDPjs6q+5H/kGomsqGI2zE/RmbyHNHtxdcILs5tFv4d4s2fRReupjUdEt4xWD8D3WDr3nJDudgvKsgnBgTaKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkA12XMrXiqIndxUbHSga3MwcvfxER+D9UiN0/uDgoQ=;
 b=Ox8YDso3D0lh/S2OyFo5lWenx21GE4b0j+sxZ9b0u/ZxYRXy0OrnDlbmL2mhw0wH+i7zrCV18OTiBMDxeFp8PlQZEgXyVRUKKXVakZ3q5rZKtTKR1fhcU1c75wBAgZ8XeYxV9VDtGU7ohgKxPpaNI6QyU/NRx2Aeb7xSt2t9vjJH4+vgTwaUR+vj4UIGkquAmv9fMQJLeskjH03n4wM0NA1gtJEbPgaS15JMQGN1KhMO7vCvgziTkCQtEgTEQMv0ihRGdvh8q1utNJf9dZhnmV/ZfpcOLccHTflpTIkZkmW/ZQ+sdXN6qFIBTo0mc56PqXhhgnvVakpZpj2WI2AQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1204.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:07:06 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.017; Mon, 19 Oct 2026 10:07:06 +0000
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
Subject: [PATCH v4 4/4] uart-routing: Add UART Routing driver for StarFive JHB100 SoC
Date: Mon, 19 Oct 2026 03:06:43 -0700
Message-Id: <20261019100643.49099-5-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: cac4eaa8-4b63-4505-caf8-08df2dc8baca
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|52116014|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	2Efe0nJy+SikFhCaW6smA7ao5OTcBiX8DvRHxoxaZos9Wo5oh2pYIvEH+y9+awZay/v7V73azR9FIyCrlno51PkbWE930sO/dqZS8Hnyme4hiZpgA8eDWfN9WQjVKNg9ENrVUNbP/VSrptzOWTmLowvtFcskA6EJEnIdaTiVJu1ZCaTDSZXUbTro6/UZO3Vu47QX+JCEsYwx7lBnpBjjXhvXC8bEZy4YBjAO3pZSG6pEg7j1l0bLRwnIapEb2MeHC3yT0JLO4KohDq4OidNxNla/ycyLJLaBfTbdc9yGzOFRE2oUpLD2F+Gi8BeMLPU+t8EJNzfAgWv43kRT9TOcOeQxnpC46xTmVRX0WBJxadOfHx+h25UigjASdzgUgUwM9vVIxCAZ++wTGIhIEHSi45DWiGAoZAFGBN4KNm1R3CD0C0AheLEtBJgJ8E/U9LKx09y7YdYIzIP0msagpvoT3EDahNIoJn4CwgEuHHTjI3mDERaK8Gvc09FFhTqdYpsQsMU1dvq4tWo23GgJvQ3+PFAxD0XScRQlb1M32NJ/+wqc6gwdNV8pLnUHHV0l2/UB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axzyQCgOn+0fS9HMJSybqidgLCilL+I1hMBIUIhkY/lsxYJ0VCkbOJLVfbSA?=
 =?us-ascii?Q?nwrKxN3UDsrabGosJss29gSskfN4wbiJ4S6qXuG5yuwueH162blCkoWG0BFt?=
 =?us-ascii?Q?KkRKis3+oWmBhxDLc2wmtKJPUKJTNmt1HQo5TUMhl2aItAZENp2bd7JIpv89?=
 =?us-ascii?Q?8qAN3HL+4zU5nDGmEpSF4x1LiVVQ5/wpnTDThxVSqYDRlsVK15Fo7ob4++D1?=
 =?us-ascii?Q?NIbIdN2aZUFvaSmYeWneqEaUpeCPAYJJHUQ6pgsGVmSkfV7Xq49wwdBJvNJY?=
 =?us-ascii?Q?t5c3zvXBzcNpc/IXmEfib/CbCvMB6VmaTG+PUacG2evX0P8nBLHoi9T8Bx07?=
 =?us-ascii?Q?4fz+3FwW58wbrQfidFcKO1AHkH6PI9miZHAg4cwV6ZWCW/B0+pvSiahq5q3V?=
 =?us-ascii?Q?NoyL2rtPg84myIxwILrDAYCWJT6jzkK1dxRP9ssu6+MG3cua4c0FAGeo8/rZ?=
 =?us-ascii?Q?ZgJo6ljHNk9rtgBEh29EK5o3omRltzf20LtqvZshdkjvuKzQhXOV229z7p+C?=
 =?us-ascii?Q?l2hOlalZC0E1GndntaeqiSGYbF25UTGu7VNIVO+h/RSf7VseU/YIppuIF8N5?=
 =?us-ascii?Q?XPnBJNPrLvuc1g7vBoUBMl+4sNDqPFRYJi8mO2ruO0tvJtwfXMOdO5a0tpnB?=
 =?us-ascii?Q?DFT/OvSuikJ5sj05UCnkYuMb3qIEGnis9opnfTr7PI6hYYhES+7+2WY4wfQU?=
 =?us-ascii?Q?9whS1Zj3WUxirYx4UtmowNJXuy4lzSJKH4nD3T+X4H72pTqvMqO8dYK3HzQL?=
 =?us-ascii?Q?P3Vph5PgasCd2piPJ1/nKeJs8GFA3Q6o55k2hdzATsxAUs4HxBT5jGoDjCE5?=
 =?us-ascii?Q?dVlJpV3ASpbwvTDHy2g+TkIRSMf5al+it1TtslAILXkCbfxxfazFea87d+/E?=
 =?us-ascii?Q?iuZDfGIUeEix9k8lnPZ03sMWQCQRcdncEMsJVLJRgPv4IKldTQuhqQ3+eNW4?=
 =?us-ascii?Q?f4tIdURHV11M6f6h0+YAHJs/XBg8KqJ/HYunmF+dItOB2Xbd5MUtzs7+NgNG?=
 =?us-ascii?Q?AJPbY4OK4Mr7OYNj62oSMkOVL4LgXx16nJIAhwEhm0K1LaSH/k5ClTAQ1x4l?=
 =?us-ascii?Q?Bblj9ZBfLnq7iHq+hCcSqHVihAWM0p/8cj9/+jui0iMe0DX24S3bTGi/uDO2?=
 =?us-ascii?Q?w/aaBrat9wn4SaPpCcJrQvphm/nI7nNJlOn8VxUaMQSys5Pz3A00dmG3W8/L?=
 =?us-ascii?Q?MJ+Uq93ciXVv5/7WnIxMybj3dVSbHo4Euw3DeTqZMdobYXtmXsrLg8H+7TSU?=
 =?us-ascii?Q?GvAcjM8U4tWJ15Y2VJtEOOFg2kEYLKbePAqxZeuNAtisABYZU2CKtIstzlbs?=
 =?us-ascii?Q?9JhNJxJPjpw8cpYip14fCYdjCCD8HF8hv+oi6YCZiTY+pRolOE/CJamyeNqY?=
 =?us-ascii?Q?DdvslAl4k/5I/aBqzYchtzSGVB/NLeeocXA0UGAHAJk24DuNxdiIdMdiYgJu?=
 =?us-ascii?Q?NTkLO8iRCP48EF3m5g8prH9LqFFciODgf4nw5Xia19DvjBiSQKlWwXVUtW/d?=
 =?us-ascii?Q?V4B4SLjfL6WLm4uTjcxgDYKrUN5wqAJr42ymVzlVYQJ2jNTbtE2h7UFJ9y6D?=
 =?us-ascii?Q?iipVi0kFFaXYcdhknUjccQ1TdYHfSYeSrryvOGTHvg21eaRj6RRif6/tA/nn?=
 =?us-ascii?Q?awrEROUsayONbBpVeiCHm1+AhCP+xZTWIpgo7FstyfnrFL9m9Mqz9jlsCr9s?=
 =?us-ascii?Q?rCNFLPfExQyi2JN6eJXYPCjTv9bfLfbUBzcbhkc4485UYtBylUHK7eljKI0i?=
 =?us-ascii?Q?uWicrnEtHGVKkt2z1Bcg/e2Z+2avj4dW802evPyeKeXFyvXGkwxe?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac4eaa8-4b63-4505-caf8-08df2dc8baca
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:07:06.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG9fu4GeTWWTBwfDlxJ9yaPqXTl/tOcGfFiuBJSdQkRBCUMp92GlmkastZ3gVplK9vLGOcoHrL3Dg1Ek7oxNo6Zr5f7Tj8p7gUxEdXp9KoQRSZuszg2TndHH33/abFDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1204

Add driver support for JHB100 UART Routing control, allowing runtime
configuration of RX muxes between UART controllers and I/O pins.

A sysfs interface is provided for easy checking and updating of routing
paths.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 .../sysfs-driver-starfive-uart-routing        |  49 +++++
 MAINTAINERS                                   |   8 +
 drivers/uart-routing/Kconfig                  |  15 +-
 drivers/uart-routing/Makefile                 |   1 +
 drivers/uart-routing/starfive-uart-routing.c  | 192 ++++++++++++++++++
 5 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
 create mode 100644 drivers/uart-routing/starfive-uart-routing.c

diff --git a/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
new file mode 100644
index 000000000000..76aeed729d4b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
@@ -0,0 +1,49 @@
+What:		/sys/bus/platform/drivers/starfive-uart-routing/*/uart*
+Date:		August 2026
+Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
+Description:	Selects the RX source of the UARTx device.
+
+		When read, each file shows the list of available options with currently
+		selected option marked by brackets "[]". The list of available options
+		depends on the selected file.
+
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/uart1
+		  io0 [io1] io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14 uart0 uart1
+		  uart2 uart3 uart4 uart5 uart6 uart7 uart8 uart9 uart10 uart11 uart12 uart13 uart14
+
+		In this case, UART1 gets its input from IO1 (physical serial port 1).
+
+		To switch the RX source of UART1 to UART2, write the desired source to the file::
+
+		  echo uart2 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
+
+		This indicates that UART1 now receives its input from UART2.
+
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc@lists.ozlabs.org
+
+What:		/sys/bus/platform/drivers/starfive-uart-routing/*/io*
+Date:		August 2026
+Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
+Description:	Selects the RX source of IOx serial port. The current selection
+		will be marked by brackets "[]". The list of available options
+		depends on the selected file.
+
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/io9
+		  uart0 uart1 uart2 uart3 uart4 uart5 uart6 uart7 uart8 [uart9] uart10 uart11 uart12
+		  uart13 uart14 io0 io1 io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14
+
+		In this case, IO9 (physical serial port 9) gets its input from UART9.
+
+		To switch the RX source of IO9 to UART10, write the desired source to the file::
+
+		  echo uart10 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
+
+		This indicates that IO9 now receives its input from UART10.
+
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc@lists.ozlabs.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 13dfdc1f7aa7..83c853c45261 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26676,6 +26676,14 @@ S:	Supported
 F:	drivers/reset/starfive/reset-starfive-jhb1*
 F:	include/dt-bindings/reset/starfive,jhb1*.h
 
+STARFIVE UART ROUTING DRIVER
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
+F:	Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml
+F:	drivers/uart-routing/starfive-uart-routing.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/uart-routing/Kconfig b/drivers/uart-routing/Kconfig
index 983e7fbd1bc4..be6f5d54721e 100644
--- a/drivers/uart-routing/Kconfig
+++ b/drivers/uart-routing/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "UART routing drivers"
-	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on ARCH_ASPEED || ARCH_STARFIVE || COMPILE_TEST
 
 config UART_ROUTING
 	tristate
@@ -29,4 +29,17 @@ config ASPEED_UART_ROUTING
 	  If M is selected, the module will be called
 	  aspeed-uart-routing.
 
+config STARFIVE_UART_ROUTING
+	tristate "StarFive uart routing control"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select UART_ROUTING
+	select REGMAP_MMIO
+	help
+	  Provides a driver to control the UART routing paths, allowing
+	  users to perform runtime configuration of the RX muxes among
+	  the UART controllers and I/O pins.
+
+	  If M is selected, the module will be called
+	  starfive-uart-routing.
+
 endmenu
diff --git a/drivers/uart-routing/Makefile b/drivers/uart-routing/Makefile
index 226980c639a4..59d9b65c2273 100644
--- a/drivers/uart-routing/Makefile
+++ b/drivers/uart-routing/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_UART_ROUTING)			+= uart-routing.o
 
 obj-$(CONFIG_ASPEED_UART_ROUTING)		+= aspeed-uart-routing.o
+obj-$(CONFIG_STARFIVE_UART_ROUTING)		+= starfive-uart-routing.o
diff --git a/drivers/uart-routing/starfive-uart-routing.c b/drivers/uart-routing/starfive-uart-routing.c
new file mode 100644
index 000000000000..3bd83ca5a258
--- /dev/null
+++ b/drivers/uart-routing/starfive-uart-routing.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JHB100 UART Routing driver
+ *
+ * Copyright (C) 2026 StarFive Technology Co., Ltd
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/sysfs.h>
+
+#include "uart-routing.h"
+
+/* One selector register per channel, holding the IO and UART RX mux. */
+#define JHB100_ROUTING_SEL(ch)		((ch) * 0x04)
+#define JHB100_ROUTING_IO_SHIFT		0
+#define JHB100_ROUTING_UART_SHIFT	8
+#define JHB100_ROUTING_MASK		GENMASK(4, 0)
+
+#define JHB100_UART_PORTS		15	/* UART0-UART14 */
+
+#define JHB100_IO_TARGETS						\
+	"io0",  "io1",  "io2",  "io3",  "io4",				\
+	"io5",  "io6",  "io7",  "io8",  "io9",				\
+	"io10", "io11", "io12", "io13", "io14"
+
+#define JHB100_UART_TARGETS						\
+	"uart0",  "uart1",  "uart2",  "uart3",  "uart4",		\
+	"uart5",  "uart6",  "uart7",  "uart8",  "uart9",		\
+	"uart10", "uart11", "uart12", "uart13", "uart14"
+
+/*
+ * The two mux fields of a channel index the same target list, but starting
+ * from a different end of it: field value 0 selects IO0 for the RX mux of a
+ * UART, and UART0 for the RX mux of an IO pin.
+ */
+static const char *const jhb100_uart_rx_options[] = {
+	JHB100_IO_TARGETS,
+	JHB100_UART_TARGETS,
+	NULL,
+};
+
+static const char *const jhb100_io_rx_options[] = {
+	JHB100_UART_TARGETS,
+	JHB100_IO_TARGETS,
+	NULL,
+};
+
+#define JHB100_UART_SELECTOR(_ch)					\
+	UART_ROUTING_SELECTOR(jhb100_uart##_ch##_sel, uart##_ch,	\
+			      JHB100_ROUTING_SEL(_ch),			\
+			      JHB100_ROUTING_UART_SHIFT,		\
+			      JHB100_ROUTING_MASK,			\
+			      jhb100_uart_rx_options)
+
+#define JHB100_IO_SELECTOR(_ch)						\
+	UART_ROUTING_SELECTOR(jhb100_io##_ch##_sel, io##_ch,		\
+			      JHB100_ROUTING_SEL(_ch),			\
+			      JHB100_ROUTING_IO_SHIFT,			\
+			      JHB100_ROUTING_MASK,			\
+			      jhb100_io_rx_options)
+
+/* RX source of UART0-UART14 */
+JHB100_UART_SELECTOR(0);
+JHB100_UART_SELECTOR(1);
+JHB100_UART_SELECTOR(2);
+JHB100_UART_SELECTOR(3);
+JHB100_UART_SELECTOR(4);
+JHB100_UART_SELECTOR(5);
+JHB100_UART_SELECTOR(6);
+JHB100_UART_SELECTOR(7);
+JHB100_UART_SELECTOR(8);
+JHB100_UART_SELECTOR(9);
+JHB100_UART_SELECTOR(10);
+JHB100_UART_SELECTOR(11);
+JHB100_UART_SELECTOR(12);
+JHB100_UART_SELECTOR(13);
+JHB100_UART_SELECTOR(14);
+
+/* RX source of IO0-IO14 */
+JHB100_IO_SELECTOR(0);
+JHB100_IO_SELECTOR(1);
+JHB100_IO_SELECTOR(2);
+JHB100_IO_SELECTOR(3);
+JHB100_IO_SELECTOR(4);
+JHB100_IO_SELECTOR(5);
+JHB100_IO_SELECTOR(6);
+JHB100_IO_SELECTOR(7);
+JHB100_IO_SELECTOR(8);
+JHB100_IO_SELECTOR(9);
+JHB100_IO_SELECTOR(10);
+JHB100_IO_SELECTOR(11);
+JHB100_IO_SELECTOR(12);
+JHB100_IO_SELECTOR(13);
+JHB100_IO_SELECTOR(14);
+
+static struct attribute *jhb100_uart_routing_attrs[] = {
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart0_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart1_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart2_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart3_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart4_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart5_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart6_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart7_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart8_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart9_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart10_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart11_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart12_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart13_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_uart14_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io0_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io1_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io2_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io3_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io4_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io5_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io6_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io7_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io8_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io9_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io10_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io11_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io12_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io13_sel),
+	UART_ROUTING_SELECTOR_ATTR(jhb100_io14_sel),
+	NULL,
+};
+
+static const struct attribute_group jhb100_uart_routing_attr_group = {
+	.attrs = jhb100_uart_routing_attrs,
+};
+
+static const struct regmap_config jhb100_uart_routing_regmap_cfg = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= JHB100_ROUTING_SEL(JHB100_UART_PORTS - 1),
+};
+
+static int starfive_uart_routing_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst;
+	void __iomem *reg_base;
+	struct regmap *regmap;
+
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return dev_err_probe(dev, PTR_ERR(reg_base),
+				     "Unable to map IO resources\n");
+
+	rst = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Unable to get and deassert reset control\n");
+
+	regmap = devm_regmap_init_mmio(dev, reg_base,
+				       &jhb100_uart_routing_regmap_cfg);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Unable to init regmap\n");
+
+	return devm_uart_routing_register(dev, regmap,
+					  &jhb100_uart_routing_attr_group);
+}
+
+static const struct of_device_id starfive_uart_routing_match[] = {
+	{ .compatible = "starfive,jhb100-uart-routing" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, starfive_uart_routing_match);
+
+static struct platform_driver starfive_uart_routing_driver = {
+	.probe = starfive_uart_routing_probe,
+	.driver	= {
+		.name = "starfive-uart-routing",
+		.of_match_table = starfive_uart_routing_match,
+	},
+};
+
+module_platform_driver(starfive_uart_routing_driver);
+
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JHB100 UART Routing driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


