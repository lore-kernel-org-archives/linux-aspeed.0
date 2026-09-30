Return-Path: <linux-aspeed+bounces-5071-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B05CA5FAB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvl9q1rGfz2yqT;
	Wed, 30 Sep 2026 16:14:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748847;
	cv=pass; b=JaTVEqBkYjn5gCEok9bbrZ3b01eh9ohnGnQHTvmwkvc99Wx2ubeMshc9FclzkrxnRCmP5l51OThc/Ft2kQukJCSTlkvkh450X1Y32IHTWGhCNmqkwZCM6aElMgf764zqS8bZ0nBh6J+wl2y2N9EQqSzXpxaDJnG9g51rRoB3PXG62nl5T4hZDvy6hpbCybGf1yjlK6HAgJgLYFzBgs/Poh9fjU30WzVUeV5IiDqqLgmw4tDxgfG42M9Z9grs1+oeL9Snb3DzHcgX5B5xf9BtdRKwumkswrsp0IG82ERiwyigHp5loRyRtzzy7VfrX+gfHfTXAoTmi6seZik9QF3vfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748847; c=relaxed/relaxed;
	bh=Lq+zQu2zcQURuSMyGNZ9qvKDoMVuf4xDaUpKEpWe5O4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CbKL3LdvGloDY/W0Qplo7T+DGWLteL249OHUBegxk4WJcqH2XiRxLuJDHY7kb0xD00lWnVRJ2nPQuw2mvt0ZxqaSi2wNVmVyO5grB/qlxeH6uUa7fN1BSGM4gr+SL6Y0gE5Cx7tjoKBI3XIZAf8sLZcUdjWU94YGUKnhYB/S2wEzbEFnyDkW6nt2foZNir1DV7Y21ah6gBRYGO83Jx3BnmBSU+II4dd2ZOpbNueg5vr5R98bSjkPEmMWKWVnXCu+g5Tm3EkfLq5fhdvulnUn//2ANiER7BLEM/ReQ44tgZ5Z/3jXM38G+WH0GwUfEueRKW7pvspBVEHxOkHNwphJJg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=JXxUI+ji; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=JXxUI+ji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvl9n5gS4z2yn2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqIf9CJNY9ZXqYoYotLjuIz4b+mkrXywAbHP7z2NLhdkKcnOQuGL46u75zbS0WqmiRLGzbc5+I43SBhLgutHAPYpJrWRSfA16JVUClm6wxzaOgFGqPMsjXonc4U7VdKE9yDcyk1TDEtyoW53hIc2mMoT/GcX5Vmbrl41vKHhp+tMQkDjpxZmNmxsodAMZIup6QWc5xt6sgvdbgY7sJTEFOyB/0WCoFk/LD2EOtOsl7R3Hxwf03WH3hnWCCXpM4KgqHNzUVcZeL4TXgUPZKO8PlkNxiQVoyYdyUEsxDvvFb45uSC3t/Or+Sh5rWVgr1wz14d6jkpj446039wsidOnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq+zQu2zcQURuSMyGNZ9qvKDoMVuf4xDaUpKEpWe5O4=;
 b=eUVg/YM/pVaxKJyDjWFQUfsxfjFmnkTw4PWUxowBRspdDzW3Qa5lMCsiycS8FF5j9AiujlSl6d3Q3HS7KoLB5dR221vG244sZr9f8uGlnRy+w81hx30YMyoU3TV0/wgczSE4XeCr3gkyPUmfzoHI0Oqq+hO+MLQAbbXptL9whzsRReEtlpr7EKPjovBflT1Hf8Y61EpNpd68j41wy/WjIo2xJEF4h+y2cnBMYnpJ8qN+1BappjSRejw4jMx5SlNsleE/l/K8p01RgLQ+pjZsjA0fyLb/zGUyULLMiT36PpLm0iwHr856Fkq+W+XWHlsctWsTa3uUZuW8TeDitWABJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq+zQu2zcQURuSMyGNZ9qvKDoMVuf4xDaUpKEpWe5O4=;
 b=JXxUI+ji7Ow3WHEOjH3XtNTuQ2WFsJxO1V5xpbf8m8Q1Mhw4oYWueKL2eKsW/xKkSn25sLzFS52EX2ibzXzGsIh9KeqFeG3z+55224OScTgWkL2NHj4/+xVjY8mnvEr4jIrA11HLPOFbHawDuUoTibmq8v/UOJew+2iz+0YfQ4ARe8tQtUI+d7sSoKCgL8ut1tabm0vQ4D4geWEvnxWyjploJsCXWKKhhOMN8TU0CgddawwkBLO+vFF6YQTY/9/qd6iKE9LzToHrdcCqhNVtvReXUXLp5ruUnW1dtO7fo/Tj03MCfwNgoj1cQJSxNsDb05yESQGI5hq8bHhF+8d00g==
Received: from BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::29)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 06:13:39 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8a) by BL1P222CA0024.outlook.office365.com
 (2603:10b6:208:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 06:13:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:13:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:36 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:13:33 -0500
From: Colin Huang <u8813345@gmail.com>
Subject: [PATCH v9 00/15] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Wed, 30 Sep 2026 14:10:08 +0800
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCnvGoC/43RwW6DMAwG4Fepcl4mJyFx0tPeY9ohOKZEaguCC
 m2q+u4LvRTRAxx/Hz7b+u9i5CHzKI6Huxh4ymPuriWEj4OgNl5PLHMqWWjQDipAGa+RYh9l4un
 c9bJv48hzyMS3gVlWClQyjVGaQBSlH7jJv88N3z8lt3m8dcPfc+Gk5ul+e1ISZMA6OOOQIpmv0
 yXm8yd1FzHbk156YdvTxXO+Mdo7VM6+eeblOdDbnikeUjBkU+NTqNde9fI82G2vKp5NDhm4iY7
 s2rMLT5ltzxaPEKxvnEnkcO25had33OfmPsCGqKPGQLz28OUFUNseFg/qhCppBgVv//qlt6MPP
 /cbyHOtI1KKS+/xePwDx/Nldv4CAAA=
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Carl Lee
	<carl.lee@amd.com>, Rex Fu <rex.fu.amd@gmail.com>, Andy Chung
	<Andy.Chung@amd.com>, Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=5856;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=bhAVjpCHW7FrBuXDMb7O4tkdd7LRC1vFfkMha5hqNFE=;
 b=4pUPJRvjVD2Ocqkw0tvRTrJYd7fVjIK7DuKxfxamapvH5EBxOko13gLO4fQtHmchDHBudVQXb
 fvcPYuOAMsdCA++rLT6HVzZgb7SXNPGdVRgPDbedIWlk1TZbFiEsm1j
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a04fac-7e7f-4570-c00f-08df1eb9f770
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|7416014|82310400026|7093399015|376014|61400799027|48200799018|3023799007|13003099007|10067099003|11063799006|56012099006|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2h3NY7QtJDc96O8cmyNzNoBYGfW/FDFJYtLNLZtTYyStyjFKPlOYiN77rDjrrs5o81AOXy/8bW7Zi8q3ISm6jUWXFdtVoyvkQsOit36goE1aUiBaNXIqWXSJQFQqvdnvZYCXJDeflDvNdolJfkX0//WXDmELGZKhBXiOauLu2ByIk1d9IrGiXVNxTa3k0D1Lw5qZPTT8j4Tpb+Qebz19sTJxkLNGMxdnMd0U00sR92x7MdAyCRQrs5BTKYrVxFoIqfLdZZTr87cvmLUc5/pTCAHSx0MrpjARYThSRKFUOMf9ps+SCxwEJINRto/qgG8Y3swWkxalJEoSMmtq1/gAmbBzNJBIDedsPc9PJmkteJtnmNT2VoDbJFw5UhQjkkbaE/170gPVSsWi2iEarwckfD+2xgfRHh2yYFTwT+AiTSSDLqwROtMYu/n/hWcJs9p/+dDPiHFL+DL0s1a/DqdcGE8JIY/6m13pUxWl6/NIenVS5gRkcoe40tOGuKqwKI7ykzdeIcydL8bt/Gy2xo10wM8lb/a26xTakbPzVgf6+osbpKY+ZhAHZb7xA5pa/vq3ouOhwF1vncc6GRLSaQgz1GIViWKEJuw+uP4m42zdBXJcifwtuNhQeGyDl90hAsnZsTCJnkG+++C2ftPinGj19w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35950700016)(7416014)(82310400026)(7093399015)(376014)(61400799027)(48200799018)(3023799007)(13003099007)(10067099003)(11063799006)(56012099006)(16102099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9O+V/iqa/0nuUsT1O6Y6WCd3qmFuY4pnOgPF4t4eD6Hxmdf071aQuJqS4WK5o5cjQSTcBMooqFQz7o5VIpWA56QxJ8NnBOiSIfkK7bPP3zR4AJA04bZkWWwvvzukRaNoJB/X4C+isDOW8rmvIpMd25Tlyznhq/DeA6PwHoQHvuCpOh2ixodHU+KWRFw1PnLt9B8rk/Sj+NkzYQXYZmqtw287hlodd8abwVVhDqPEjHh6vPXteOWvVA5tSwMlTAmjArHOCFjEEa6iq4tme1q1LUwmkUsKcaM3rJN+0PPEE8o7m0my52jyLOOVV+sHVMt1tQXaFAxOHXrp9welnuLOaxzEJUfKMtgBrj6H6/BrWtriktofgwo67HohCylaBRhImY4Q7uqTjfGoPy2VV8EFBjwgzCXlUrd1ZxbwjyKL5g1rX2oXYnQfCh/VGYSvfO7K
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:13:37.8666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a04fac-7e7f-4570-c00f-08df1eb9f770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

This series refactors the Anacapa BMC devicetree layout to better support
development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a platform
entrypoint.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Changes in v9:
- Add four new DTS updates for Anacapa platform:
  * Add E1.S FRU EEPROM definitions.
  * Add NCT7363 fan controller nodes.
  * Remove conflicting LTC4287 power monitor nodes.
  * Update EDSFF power status signal names from PG to FLT.
- Link to v8: https://lore.kernel.org/r/20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com

Changes in v8:
- Fix [Critical] The board compatible string was silently changed from "facebook,anacapa-bmc" to "facebook,anacapa"
  , breaking dt-bindings and backward compatibility.
- Fix [Low] The /dts-v1/ directive is improperly placed inside a .dtsi include file instead of the top-level .dts file.
  Move "/dts-v1/" into aspeed-bmc-facebook-anacapa.dts
- Link to v7: https://lore.kernel.org/r/20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com

Changes in v7:
- Fix [Critical] Devicetree ABI breakage due to removal of generic compatible string
  keep to use compatible string "facebook,anacapa-bmc".
- Fix [Low] Redundant redefinition of inherited properties in the `evt2.dts` file.
- Fix [Low] Included devicetrees use `.dts` extension instead of `.dtsi`
  aspeed-bmc-facebook-anacapa-evt1.dts -> aspeed-bmc-facebook-anacapa-evt1.dtsi
  aspeed-bmc-facebook-anacapa-evt2.dts -> aspeed-bmc-facebook-anacapa-evt2.dtsi
  aspeed-bmc-facebook-anacapa-dvt.dts -> aspeed-bmc-facebook-anacapa-dvt.dtsi
- Link to v6: https://lore.kernel.org/r/20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com

Changes in v6:
- Fold the following fixes into this series: 
   - Remove redundant vhub pinctrl-names
   - Use default SPI2 memory mapping
   - Fix dt-check-style strict violations
- Move p3v3_bmc_aux node from evt1.dts to evt2.dts for dt-check-style
- Fix the patch author information
- Link to v5: https://lore.kernel.org/r/20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com

Changes in v5:
- Remove redundant vhub pinctrl-names
- Use default SPI2 memory mapping
- Fix dt-check-style strict violations
- Add Acked-by from Conor Dooley
- Sort compatible strings in alphabetical order
- More commit message for ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it.
- Update commit message to describe both LPDB and RPDB GPIO expanders  
- Link to v4: https://lore.kernel.org/r/20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com

Changes in v4:
- Capitalize the first word of the short description.
- Rework the Anacapa development-phase devicetree hierarchy.
- Ensure that anacapa-evt1 generates an identical devicetree to the existing aspeed-bmc-facebook-anacapa.dts.
- Add SPI flash VCC supply.
- Simplify leakage GPIO line names.
- Add LPDB fuse monitor GPIO expander.
- Link to v3: https://lore.kernel.org/r/20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com

Changes in v3:
- Restructure the EVT2 devicetree to inherit from the EVT1 devicetree, making it incremental rather than standalone.
- Add the DVT devicetree, inheriting from the EVT2 devicetree.
- Enable MCTP and FRU support for the NIC.
- Align PDB fan GPIO numbering.
- Add an EEPROM device node for the NFC adaptor board.
- Add an additional EEPROM device node for the SCM.
- Add shunt resistor values for HSC monitors
- Link to v2: https://lore.kernel.org/r/20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com

Changes in v2:
- Fix dtbs_check fail.
  Validated by following command:
    make dt_binding_check DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa.dtb
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa-evt1.dtb
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa-evt2.dtb
- Link to v1: https://lore.kernel.org/r/20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com

---
Andy Chung (1):
      ARM: dts: aspeed: anacapa: Enable MCTP and FRU for NIC

Carl Lee (3):
      ARM: dts: aspeed: anacapa: Add eeprom device node for NFC adaptor board
      ARM: dts: aspeed: anacapa: Add NCT7363 fan controllers
      ARM: dts: aspeed: anacapa: Remove LTC4287 power monitors

Colin Huang (5):
      ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: Add EVT2 devicetree inheriting EVT1
      ARM: dts: aspeed: anacapa: Add DVT devicetree inheriting EVT2
      ARM: dts: aspeed: anacapa: Add additional EEPROM node for SCM
      ARM: dts: aspeed: anacapa: Add E1.S FRU EEPROMs

Peter Shen (1):
      ARM: dts: aspeed: anacapa: evt2: Add shunt resistor values for HSC monitors

Rex Fu (5):
      ARM: dts: aspeed: anacapa: Align PDB fan GPIO numbering
      ARM: dts: aspeed: anacapa: Add LPDB fuse monitor GPIO expander
      ARM: dts: aspeed: anacapa: Simplify leakage GPIO line names
      ARM: dts: aspeed: anacapa: Add SPI flash VCC supply
      ARM: dts: aspeed: anacapa: Update EDSFF power status signals

 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    |  259 +++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi   | 1165 ++++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   |  467 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1077 +-----------------
 4 files changed, 1892 insertions(+), 1076 deletions(-)
---
base-commit: cd7d1ef7d74ed5f5a1790a40389bc38382924556
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


