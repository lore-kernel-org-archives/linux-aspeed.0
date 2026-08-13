Return-Path: <linux-aspeed+bounces-4723-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5DBC5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkh33wLxz2yv8;
	Fri, 14 Aug 2026 11:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616627;
	cv=pass; b=YdPQgih1pIVZ5md31/O6YDwEd0qDSaIL+7ZQcWXMGHDRWOUQ4tNFMDuqYm4D8T5JoSRrfaLyv0Q4O/3cw8GpY0H38qmv9ySF0Gq+a7azMPNSvObV2Y+0RCnVNLe4VCnflQ7ykPGbxzx4crE25eA6ov7yeeVkfN7PpSDFtukOBXh2mNuqeL4bZC2JAJbc4riJoJPMaLqFdh7ba6U82uCLy47BKFjE1p9LJyLWKsAtCZ73xqqT/XWPI9KWeDYATCr4KTuMX1k0JVvb07Qz/S6jzsB9Z+gYhY837J3lex1WMh9h3tkcANi3S/Uf0LZUGNabzXl6kBycXDIPxdnxniBAbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616627; c=relaxed/relaxed;
	bh=0n22+2hszmfvyV2F6H4a1xfwpgDEvNULiXfiBMAoQkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UwYBFHi57VK7qvzWtEeC6wmVw+srfDhvbZASqAc+uOjYPBazsEaIjZVDJrWrnpXeADlTQCjwybeQRK08UQPS755+2ga1YgxsSreVRszYDYfcCVfCK3Dp6CwAwyLRrDwXWNDi4Kfly2oMZgwUXOAgn8gkqFjtroU3Utey3gN7JhzYXfhVFrKWiwXDB6ly3dG8iNXsjaqPcwAb2f84oDKS8PcpUPGENlzKoBtTqJ4JahurH6g5jkSMBctpfiAQ6XxhmmoBIvaNf60JK7SjYpgFxJDH0NTAjzUjjLMxn1kdBZ0+kn3x/ah4DpdBa851uwyVx4F/BxVZ3VS8WLDl3iOpPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gzNgi24i; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gzNgi24i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM015rF3z2xyl;
	Thu, 13 Aug 2026 20:23:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+92Ja5TmMvMG62GNxUUlQDazrZn56GCQYZHz6b5ycVbx7GAci4c/m3ipvSaJ9xualq8wH4v4/C6N6GxrwjDrswEW++/X6fo9VePved4VdxuG4lmbXxI/cuJgeRIBfQ2foUS2j+itc53bHRcjie4IpLO4ZLco0J6BIOlFDMU159COkCH/+IAp9RTKrTv6YZtb09RUK/UobeaueUqnq8XQNKZSb3+WdRxBRrEH/KirH1t5OFf4VZI6e3XqyZ4lDgRMxvDkA5LkAS6NbZ3XAMuFnZs6TaGFlZbGRJ4zIeRp3MFlSH30GNy/aE47/rObWJOpV57dzop6HEmFOohBbE1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n22+2hszmfvyV2F6H4a1xfwpgDEvNULiXfiBMAoQkg=;
 b=E1cjGJCD+Kx+MyTfGIA7P1Z6nyK5jAwg8uq3WvyQ5QlK3+/G0qKaFTGFRo7qZ46VHVUjCQDHiULCeuln/+Y+YLqb5bdmDnqAAa7mFhOks+Yh94/xt+fyBOhPPL9keu0KBqpg8h9xuR2J+9rzvtDSKsNaGfOQnIHZDrjdtyNQhpMMz8aY1Z1E3SdHd/J+ImGp6DeG7TIJMMGJqf0CZ9z7G2ZixKWPFOGxEM0SO1peAVaI7IjObK0Uius/kFXjoTsLczH1Bi27fjdIPfw/cMEFL8RXM5twj53mg5WisoVoE0V5NYTbx3zAWnhosfvA+dsI9POWV4Z+8UwQ/cf6SR+LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n22+2hszmfvyV2F6H4a1xfwpgDEvNULiXfiBMAoQkg=;
 b=gzNgi24iXsTmWC5d7wcmiitLpcChVpGbnAnzXLCMbmnQrvdNrRujIsYanDzGKpIjvRBu5XLFTQ+LTPuKhiYvZBW4AYguyplzkdXPQpAXg1ngcRVhFuVcNaYmzU/KC/eHX2mAzjjWFhX7btUwvkDfXGYuNlCYs0Jz1LET5vCVQogMj3/p0hEe/mZsSta1QyPRFtI34jMiI/MMs01G45HVXhimOOoFj8smln4XBiU/AtJSu1POSVKWoMEQxp/lEDQxmaixpjV7JCHpqQdjVKv84Gb+qGSFp0eLl6azJEObFDLIb+jWDnWle61F/QfIfpGuv6KfarvNRw41YkRu19d14A==
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 10:23:19 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::59) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.4 via Frontend Transport; Thu, 13
 Aug 2026 10:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:03 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:01 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 0/8] ARM: dts: aspeed: Move flash nodes out of aspeed-g6.dtsi
Date: Thu, 13 Aug 2026 19:22:25 +0900
Message-ID: <20260813102233.3088939-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: ca45aa3c-3cd3-4c18-0741-08def924e530
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
 IedzPbulGu5dA8DEhXXTmy3u5LdUUgz6z00py5ghbqo7DO1Yr7HSjicaCxfgLo6E2aYerbAtfy18SCWug/QmeDtK1bHOJjxYy/Ixmjvsgfsv3nUOrbkT6vH4xbd8iiMI6dR1GgO9A+osz5X917345gsOEy//VMXhynq6qIWWvpM0CCZkwdA51rJVQ8ayzO/ZxBauQYT7voEnGY4m/MFfQCaJANzdhZ8QTt7ofjckLYdN417TjcVuNv5Ee9DnHuGdCVIvqvWd0eGB8YolZJtcg3p5Los42fFALhTCQShfUJ9OAjoL33+J6Fykdia9ruRR6sYsNQcQ+hSH2g49nAkY87L/p0D7AIuEngU45FhFV4/SuoUF45dMnCVEaoTx3UizABhILRfICmLulpuWbMqLPYZxFGSzDwTrrlQY7AbyyzCWbovNhzwU10Y+UGHUinnaqPw1juhHkV9rNWHaabL4r8iAMgMyBShvs/SKNH76ax7hCflqEIRGFPRMJvQ+884SUmWsmwJ1DkHEzDxvgBVd7mqt90nN6ohGJe3nnoZQ/LjDfTw1j7l+uNW9B58mOuF/JpvliemWH/2UFKnKn9Sm14ZytWSa/YO0usBXTzVEMJCRKV/xYae8QyfZKhPBlew4m+VnWhR01X3opf8C3+unNiaLj1HdvmNa9H/6n6IhYKq2497frAx1hb7HOg2mRm25sBoFttwXGkMJXLKW8KIm3w==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 AKmjt0Zl9ACqNRwXjX1f7YN6bNpDkIudcioempjYDk030zbLH/b8QED2X4ZQJA83pFUm6d3LZiL0cViAXWryqhM5xc4IEU2MkU2TCR0Jlj6qS2PLFdu1Hi+FPuK9+WbnkggJQgi8AODADrc+zLjYZzauyMBt4SM9++Hg0yfKvjrdaRpP/p7YZvRUOssb2RgyhnFDktiwVv+iu6XHavSSh/Eoma9W4AyBjd6BeXJIwrD8yiSPoxE2JTWOJHz63lo8L8kfYvp6jxAO54pgqCoQlyCH3+8vlpyjf99BiKxVJ9oJbodM02mv0AhckjSfT8o2syfLacOyHoW4Yg2O6xogzHf5jZOje3XuyAx4QtYG8+IGyzeqWc/yymLzms1IwvMtVmchPC3ec5RjTGfhLTYAj5nYkEl5F8p70NhTm07VrQp27c4ZacoQ4cAEE8chlMYf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:19.0910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca45aa3c-3cd3-4c18-0741-08def924e530
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

Move SPI NOR flash descriptions out of aspeed-g6.dtsi. The disabled
flash@* stubs there describe board population, not SoC IP.

Patches #1..#7 make each board (or vendor common dtsi) declare the
flashes it uses, and keep status = "okay" so intermediate commits stay
bisect-safe while the stubs still exist. Patch #8 removes the stubs.


Jacky Huang (8):
  ARM: dts: aspeed: facebook: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: ibm: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: nvidia: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: ampere: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: asus: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: inventec: Declare SPI NOR flashes on boards
  ARM: dts: aspeed: Declare SPI NOR flashes on remaining boards
  ARM: dts: aspeed: g6: Remove board-level flash stubs

 .../boot/dts/aspeed/aspeed-ast2600-evb.dts    |  4 ++
 .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  |  9 +++
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   |  9 +++
 .../aspeed-bmc-asus-kommando-ipmi-card.dts    |  3 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  |  6 ++
 .../aspeed/aspeed-bmc-facebook-anacapa.dts    |  7 +++
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  |  9 +++
 .../aspeed/aspeed-bmc-facebook-catalina.dts   |  6 ++
 .../aspeed/aspeed-bmc-facebook-clemente.dts   |  6 ++
 .../aspeed/aspeed-bmc-facebook-greatlakes.dts |  4 ++
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  |  8 +++
 .../aspeed/aspeed-bmc-facebook-minerva.dts    |  6 ++
 .../aspeed/aspeed-bmc-facebook-rainiera6.dts  |  8 +++
 .../aspeed/aspeed-bmc-facebook-sanmiguel.dts  |  6 ++
 .../aspeed-bmc-facebook-santabarbara.dts      |  8 +++
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  |  4 ++
 .../aspeed/aspeed-bmc-facebook-yosemite5.dts  |  8 +++
 .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   |  6 ++
 .../aspeed/aspeed-bmc-inventec-starscream.dts |  6 ++
 .../aspeed-bmc-inventec-transformers.dts      |  6 ++
 .../aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts |  5 ++
 .../dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts |  5 ++
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  9 +++
 .../dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts  |  9 +++
 .../boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |  6 ++
 .../aspeed/aspeed-bmc-ufispace-ncplite.dts    |  6 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       | 56 -------------------
 .../ast2600-facebook-netbmc-common.dtsi       |  8 +++
 28 files changed, 177 insertions(+), 56 deletions(-)

-- 
2.43.0


