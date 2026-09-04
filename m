Return-Path: <linux-aspeed+bounces-4958-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56464C624DE
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Sep 2026 09:35:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbrt2513Lz2ytv;
	Fri, 04 Sep 2026 19:35:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788514522;
	cv=pass; b=Z4AmKrpjCxVJmNxqi3TGk3T4UuLFkvNaeU2nzQkMcEia2e/CFg8Fenj13Mhd4BJtSN/kiMGQV14LhcJ1RG6JkAHpr6bJKQE94Li7RP0XkItrKyCjCM2LWzAKSuSmI+xKNvx19/6UAFksAy/NJLeDbPzIBuB1b2l6XXTIkDxJnA5OfOsxXi4Qarw+1Z1xP6Qn/BDP1LmomWA/RNgPB13h4+LSL/oFsh7IwP8A0dNdvpBNxT9mbpkenocfUHdc+mE5v68Y0rhTUfpFM41yXMMblQLmaOOjHx3qC5uNuR6THaNxx7KzMqQNrRnEfmR4VL53APKAimrTrZ3u3x8jvIw7bA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788514522; c=relaxed/relaxed;
	bh=as+6DfHPYSqBEWE9i7602DvX8ane+SmNsUiq8qgBXro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h/mRekM9uAUGDR8T7AUvJZYxMjh7Bwp+CNP+SVaJJAEtCWPAZPX/622R6FIif2v5QNVxHNGh/+ZwlUaDn7jFaSbL26E9qmzU+5mAWcsasuzZeUhprUetHHaULThfcqhHCKV95d02bejxw+w3aZNXhXSDz6IiWqxVN7nHLtAOXhetF3n/y30VkQPFGFUIuruGBbxfT16Bla7HLZmLcEoZoCoTLauGuQAKokpu843b5X+7HWfXwXBZLeckQrObqIjRMxKb1Wvj1nS6uHKry1DJOY6NWUq8175pvlbgtiSQYN89XMSm6tkqROxzMoCm9jSCZRkFtl4t5tDTGBrgNi8dSw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l+2xwl8G; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l+2xwl8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::1; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrt02Hmgz2y2K
	for <linux-aspeed@lists.ozlabs.org>; Fri, 04 Sep 2026 19:35:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXayvenYu8S/N74tXmJPxX3Jvcmv4vbhH+E4jID6r2b4oxu2oObf8tRg8NCgH4myklmuPy16I4BEG6KnV8q/MY3+nXQV5JUvGrw6so+/mVcUfDwUeJu6ek3qWYXPKPxRppipnLcshIGlXBFlq81l0nQ1K3zLeFJIu6bZ6hyiRMU8LwsN+FImYqpU9PDigcqIbAve75PJNqu7oKnFQSrLKUqJMCKJWVwm/yq9Ee3WTBQJ2thRD3Tne8z3NzYObRboiVLWorqiw0NWdfLKxKxSGQaClbMxosQm2UaCgezEtZXqkgXc4KJ7BACet80mEf8fUgZB0vFoPHjdRR+1vqnahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as+6DfHPYSqBEWE9i7602DvX8ane+SmNsUiq8qgBXro=;
 b=g37ooTbQNp0OIFwU48JLj34Cty64yGVbLFDJ9mY3JHLYzxrk2pKfHQmtbH/PreqtyWvh9G0yFa8orCxyCYk0yPEAPP0jglP3IY3tqiFH8TVpCR/UkjtKHqwdO5mTwnyToAXJoR9WBiGPkmskzyFLCFnzsckIyBbV+ErkcBGAGv8jdYCHLb45u9PFY0XdvwluREGNbMjthgc5eSzYP0aPDiFCzrlS+3qVI3s7f17K1e4JDCBufW8yVSUMhcqOo41F/LtZ4cOPBvtebkZLiGcKU7oyOPj+ugQ19burhC8pQlslxUPnru+NNV32D+CPmMxlQKTiZ32RgAkRpI6NXZjpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as+6DfHPYSqBEWE9i7602DvX8ane+SmNsUiq8qgBXro=;
 b=l+2xwl8G4yU6wT8jPJAhicPOpTZ23SbasfWO++Fd/76eN5SUVHk89zYviUrGhDgQejzE574BIxT1tbOprMEd7kOfpEBPLjRUSpPJH4FFvX9BASWPDPgQC3GRC3WpaTgt/tczdlTmsS9nex4zcJjCYTLeqDyOhqzd+cs3+dovUjdZvGbw8KUTKrflKgSygMUmryWoUwsZqhw/5nEu29CrxA2f/0ZdeloZFmgOxNK2YdSrvQmiEzwJpxfMEAF2ZuyRIBmQ5jqAuhycHT0nr57hFMFbOFS3eDTijxCfKszmLyD2Bef2pnorqu29guU1HbbWzYfZ7zSA1bmwY19CJCRPXA==
Received: from BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::33)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:34:51 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::51) by BN9P222CA0028.outlook.office365.com
 (2603:10b6:408:10c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 09:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 09:34:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 02:34:33 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 02:34:31 -0700
From: Ender Hsieh <andhsieh@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>, Marc Olberding <molberding@nvidia.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ARM: dts: aspeed: msx4: describe the I2C5 mux tree
Date: Fri, 4 Sep 2026 18:34:12 +0900
Message-ID: <20260904093412.2188620-1-andhsieh@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de519b3-fa2c-460d-753f-08df0a67c44f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|30052699003|23010399003|36860700016|82310400026|1800799024|376014|7416014|11063799006|56012099006|10067099003|5023799004|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
 7SaTuv0U56d5fw0TvZqqh+2oX2q1p6qDtkKNhLeO7/v430RXSbfTEmlu/raPLCJuuu1Nf1v+cJCFgNGBQ8+XCC4An4E/yEMk83ZYYvyhgSkiP/re/3Ak1+6uZX5KNaFyLuQ9Bui56uyRQ/zxKehT0zP4RpfCxMlqVrF4vAVTiyhNdtmj1BvXAJ7t94nfRV0jXjJFYCHN63bwgC43tdZt8LT65C1pxDRa2ioywvfWubk+suBdC3Py4leC7Hy8HD/fct36C8j8AwlW2Ye7vyJz++vSA/2/YKb+MBs8vjqGEe/nbyoWxZ0JY5HuYbQeSlwFW8xAJU51FJQuOYa5TwAAHPTfNAoCV9NIIaPeQfVLY+FDdDBO4LgZISSjqDYYFo68AqJrSi9djL4YWJjGV8gBnCTF/uEJ+hXSPbRTg4n1z8UFE6eMrwHgjR1vI+XOPYx7m89L01X2JRU9ZhqoMLwfLc5J/sMVfnKWC0Q+280PBv4aOcYvXMfMRMH1ShkCqBk8vOj4iixnUYHPMLD0GkA9cDyjrM41Gi0vK6wV6AUkHa7mdoBdh9DX4isNykDM/qV0WUSmq51c9e+cF2GxITl33zKWCLOgJblO6r87OrG8v/QpfozTGm0G7pU5DZKCQrn9jPsu3DtUduAOu9moeUmM16n1M1ZsqKN+wxUTPHRda1CKH1otTQWIZkh0t72bWKslpc/910jWcmuefjlmyhLKfA==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(5023799004)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 4Vo8R3j1E0gwhic70RVTj4LB5rXJmpiKwm1dNQh84VTaINixYAJZWK8lk2lBTNsrShmCfynRwErlToGrLo5+NRSgX8fBcd6qEqpB7i0523KAo28TBpXGgCdWwVBzOUqDdlTSL3u9fQZF1f86T57DgqxXpCavbMiaDf91PXrjkcd6V5RBxXcufViupRWHZpCVY7nXmTYtN/GCZv7uaPh8btAVkOiN4zadUPXZL1uwD4dgWU8B7BghApls8AWTkPpmrN62cc9iDeGoCOQpFaYugijN1sSom/pnMdLIsc8bs02GK13pp2jLM7uTFgvnrZloubrgt+Y+olZHtwAV+XuIQwnDVzXEno1PLXQQFs6qSn6E+U8wY7tTX6DGyTqdo4Vc/vRvA4brKcIjQo/IotgMqzoBUE9lLNG2NvqgWqVTpC0OEv0x1nHvGa7GcfdHFoTC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:34:49.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de519b3-fa2c-460d-753f-08df0a67c44f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

The MSX4 carries four PCA9548 8-channel muxes on I2C5, and a PCA9546
4-channel mux behind channels 1 and 5 of the mux at 0x70 and channels 3
and 7 of the mux at 0x73. None of that is described here, so the muxes
are created from userspace and their channels are numbered in the order
userspace happens to create them.

That makes a channel's bus number a function of discovery order rather
than of where the channel sits in the topology, so anything that wants
to identify a device by its position has nothing stable to key on.

Describe the tree and give every channel an alias so the numbering comes
from the description instead. The aliases reproduce the numbers the
current userspace instantiation produces, so existing configuration
keeps working.

The four PCA9546 all answer at 0x72, and two of them sit behind
different PCA9548 on the same parent bus, so both can be exposed at once
if their parents are left selected. i2c-mux-idle-disconnect prevents
that.

I2C5 is shared with the host, which configures the voltage regulators
on it during POST, and a mux inside the CPLD decides which side reaches
the segment. The BMC is handed the bus once POST completes, so the muxes
described here do not necessarily answer when the kernel first probes
them, and the platform binds them once the CPLD reports the buses ready.

The reset line the four PCA9548 share is left out for the same reason.
A driver asserting it has no way to tell whether the bus is currently
the BMC's, and the reset cannot help at boot anyway: what fails there is
reaching the muxes at all, not their state.

Booted on an MSX4 from both a warm reboot and a cold power cycle. All
eight muxes register, the channels come up as i2c-16 through i2c-63
exactly as the aliases name them, and the eight FRU EEPROMs behind the
second level read as before. On the cold power cycle the kernel's probe
of the four PCA9548 fails at 1.7s, and they are bound once the CPLD
reports the buses ready 2150s later.

Cc: Marc Olberding <molberding@nvidia.com>
Signed-off-by: Ender Hsieh <andhsieh@nvidia.com>
---
Changes in v2:
- Drop reset-gpios. Measured on an MSX4, that line is shared: pulsing it
  clears the channel selection of the muxes at 0x70, 0x71, 0x73 and 0x75
  together, and leaves the four PCA9546 behind them untouched. Naming it
  on one mux alone was therefore wrong. Naming it on all four would
  describe the hardware correctly, but I2C5 is arbitrated between the
  host and the BMC by a mux inside the CPLD, and a driver asserting the
  reset cannot tell whose the bus currently is, so the line is left out
  of the description entirely.
- Say in the commit message that the bus is shared with the host, so it
  is clear why the muxes may not answer when the kernel first probes
  them.

v1: https://lore.kernel.org/all/20260903105956.1709114-1-andhsieh@nvidia.com/
 .../dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 401 ++++++++++++++++++
 1 file changed, 401 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
index 29f56176e2ca..a473bb2ccd0f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -15,6 +15,55 @@ aliases {
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+
+		i2c16 = &i2c5mux0chn0;
+		i2c17 = &i2c5mux0chn1;
+		i2c18 = &i2c5mux0chn2;
+		i2c19 = &i2c5mux0chn3;
+		i2c20 = &i2c5mux0chn4;
+		i2c21 = &i2c5mux0chn5;
+		i2c22 = &i2c5mux0chn6;
+		i2c23 = &i2c5mux0chn7;
+		i2c24 = &i2c5mux1chn0;
+		i2c25 = &i2c5mux1chn1;
+		i2c26 = &i2c5mux1chn2;
+		i2c27 = &i2c5mux1chn3;
+		i2c28 = &i2c5mux1chn4;
+		i2c29 = &i2c5mux1chn5;
+		i2c30 = &i2c5mux1chn6;
+		i2c31 = &i2c5mux1chn7;
+		i2c32 = &i2c5mux2chn0;
+		i2c33 = &i2c5mux2chn1;
+		i2c34 = &i2c5mux2chn2;
+		i2c35 = &i2c5mux2chn3;
+		i2c36 = &i2c5mux2chn4;
+		i2c37 = &i2c5mux2chn5;
+		i2c38 = &i2c5mux2chn6;
+		i2c39 = &i2c5mux2chn7;
+		i2c40 = &i2c5mux3chn0;
+		i2c41 = &i2c5mux3chn1;
+		i2c42 = &i2c5mux3chn2;
+		i2c43 = &i2c5mux3chn3;
+		i2c44 = &i2c5mux3chn4;
+		i2c45 = &i2c5mux3chn5;
+		i2c46 = &i2c5mux3chn6;
+		i2c47 = &i2c5mux3chn7;
+		i2c48 = &i2c17mux0chn0;
+		i2c49 = &i2c17mux0chn1;
+		i2c50 = &i2c17mux0chn2;
+		i2c51 = &i2c17mux0chn3;
+		i2c52 = &i2c21mux0chn0;
+		i2c53 = &i2c21mux0chn1;
+		i2c54 = &i2c21mux0chn2;
+		i2c55 = &i2c21mux0chn3;
+		i2c56 = &i2c35mux0chn0;
+		i2c57 = &i2c35mux0chn1;
+		i2c58 = &i2c35mux0chn2;
+		i2c59 = &i2c35mux0chn3;
+		i2c60 = &i2c39mux0chn0;
+		i2c61 = &i2c39mux0chn1;
+		i2c62 = &i2c39mux0chn2;
+		i2c63 = &i2c39mux0chn3;
 	};
 
 	chosen {
@@ -151,6 +200,358 @@ eeprom@51 {
 
 &i2c5 {
 	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux0chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c17mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c17mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c17mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c17mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		i2c5mux0chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux0chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c5mux0chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux0chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c21mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c21mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c21mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c21mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		i2c5mux0chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux0chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux1chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux1chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c5mux1chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux1chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c5mux1chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux1chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c5mux1chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux1chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9548";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux2chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux2chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c5mux2chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux2chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c35mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c35mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c35mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c35mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		i2c5mux2chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux2chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c5mux2chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux2chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				reg = <0x72>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c39mux0chn0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c39mux0chn1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c39mux0chn2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c39mux0chn3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9548";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux3chn0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c5mux3chn1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c5mux3chn2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c5mux3chn3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c5mux3chn4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c5mux3chn5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c5mux3chn6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c5mux3chn7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
 };
 
 &i2c6 {
-- 
2.34.1


