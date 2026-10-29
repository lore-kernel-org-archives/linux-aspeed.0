Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B317606A334
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=BxWIF24C
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFlkv5F9Jz30RN;
	Fri, 30 Oct 2026 00:41:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281303;
	cv=pass; b=YNfA9TUJCqhSekw34kCse7Ybf41yQC7VHFIWomrZl+6tI8y6eIzjIc2b3ISfZxYibYunmXOkpzjDAZ15wX+sLnrkQdRdHGNTMqe/6yhU1Mczl0HutXnTmm8opNAGGYZyvSnc1eCt9aYINq4EgJWXYF0qaZV+gAvioOnfSfS36amSlm8olVeNmD7/63cSv9k7X/qWOwPSIsDOOCxvsSABS0FW8+yGBswt6LyiRDf4ykG/ncrPXMeFNyZo0g5d4YQixdYxyxCePSj0cO/YNwPYmEg8cjyHtnMTRHg7juj+LkHKSrUB/SJEYeYO/KG14paeA955FF5d+NOi6qLnHpOPNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281303; c=relaxed/relaxed;
	bh=HkAtG0OpnxEciylAUBUN/PGpjy9nCiPea5G2Swh+DrA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LivZlufgELobbjw5Fo8KaOYe+sbWHcCnhqvXixgcVhyRHEyPLByDAqbkJbMWHh9B3FYbLUkXoNMTQYVhY55Fe9YO8v9dUm2jBv8cYf6OXkADQJMYVdmshRuLo6AkUDcGGWT7qkex+bs8457hDOCDpmgaGlQcYe6dXoK7JiDEyf/WINaDKpm/RAGpm0bm//oax8zd9Ao4GD87uBARD6L4CoFtZZLHHQXirr4P4Z6susifvvmSTO5zmciGk+UmWqP03GmvdBNmj9FNP15Qt/8Mf84im58+IUmGh1uxt1zeAB+x6MQPACrQDsWo/+8d1EMmCW+0HMEnkmK8YxSGUnVBVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=BxWIF24C; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=BxWIF24C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFlkt2jrNz30Ng
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:41:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2htNd4Dj7MpGtzYA5iwDEPqFBu/eQ3OfylCmWYIwUJil/ikjZxOZSOxSBw1roEPQ5fFROAxrECCbg3fCF69TEr1zxwwBH6MMq0Wpsr+UYFZIFlvIIkgbaGOGJ+7SPtL8nkGQAnDxpPvZcWAenRT/bwhOU9Pe3IhdQZlDDPdy7k9NCf35wOdedaxe6ZC1VwHptGSlBANs/kGmjyQkPynZslKPONskeDr4kI7tjh65WgIHmOoNuApiljn+jXz/lR8SMycd1PYtfLiAEEK0anlwECwzIUW1FQQVFDo5yjFyf4up4nPPT8LhcfJ94336kNx0Xu4VzHzGoaxbeAzE0vIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkAtG0OpnxEciylAUBUN/PGpjy9nCiPea5G2Swh+DrA=;
 b=eBAyWbGnx1hbSExH80HytGFH+RoWGFKX8PTQz8HemwNqBkWCuBZgBTehlT1wibniylVMC10g3s4y8bWzSD/eDEuwKW5t9kFlIIk1yMpidt5Bc1Hut7buKslkHUtZ53DR0l5vsKaYRHddPsyVYh25WnlQXjAaMu2ydO1Z/pBxARVyArCmqXyhCrkJfEWxLVkdlUAazvZwY62w3BhW+j4B51m97UPF1kf+mKbvMFmXW8jSH2d41oicw7NDr99mProOqf+QoI4aWMboGbva0w7H4ux2O9MHWY63f5rFNJTOG2rBqVj7Oz3SbCQVRf6jZsEqWz8SXUsHOBR1QHZOUbwzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkAtG0OpnxEciylAUBUN/PGpjy9nCiPea5G2Swh+DrA=;
 b=BxWIF24Ci02ae4nNmaQP+Bt9MUZF1m39F7pPGFBhjnwxPNZufPYiuEypYMsx4H0RK7gXV30tbCw3wFdqbZpqMaqNUWQkLHCjUIWTHyMFi0bO+RzTkYyme4aHGIFP8nxPf2YUvu/ErZsuVDhIiRkk0gMrxM3Z4460TCRyJDD/G1atv4Z8BYhNe8G+EQFez5pQBMWoR9FvWStWPqOgdc7unv4JXJv/+Ybz2ZjbX4+RC3jk9D/r08/oGNZd5inOUu0vJL/FT9pbNgJmFwlM/6NLSSJBhuRH8mTyocoFXpO/bjnGg0QcudnPdOLFlEsvmW3U09EstF8EZIHNVeX+UycH8Q==
Received: from DS1PR05CA0008.namprd05.prod.outlook.com (2603:10b6:8:457::19)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:41:19 +0000
Received: from DS2PEPF00006E20.namprd05.prod.outlook.com
 (2603:10b6:8:457:cafe::77) by DS1PR05CA0008.outlook.office365.com
 (2603:10b6:8:457::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Thu, 29
 Oct 2026 13:41:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E20.mail.protection.outlook.com (10.167.23.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:18 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:15 -0500
From: Colin Huang <u8813345@gmail.com>
Subject: [PATCH v10 00/16] ARM: dts: aspeed: anacapa: restructure
 devicetree for development-phase
Date: Thu, 29 Oct 2026 21:38:29 +0800
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVM42oC/43RPW7DMAwF4KsEmquCkqy/TL1H0YGmqERAEht2Y
 LQIcvfKWWI4gzM+Dh9JvJsYeSg8iv3uJgaeyli6Sw0KPnaCjng5sCypDoQG7aABL/GChD3KxNO
 p62V/xJHnUIivA7NsFKhkslGaQFSlHziX38eK75+aj2W8dsPfY+Ok5un79qQkyOjb6IzzhGS+D
 mcsp0/qzmK2J7304ranq+dCNjo4r5x98czTc6C3PVM9T9GQTTmk2K695ukFsNteUz2bnGfgjI7
 s2rMLT5ltz1aPPNiQnUnk/NpzC0+/cZ+b+wAbUaP2kXjt+acXQW17vnrQJq+SZlDw8m9Yem/0E
 eZ+IwVuNXpKuPbiwjOw7cXqZQiIUG8MOi29+/3+D4u86rZPAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=6167;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=5Wq+6Opm3rEoxIul7nvEb7EvhDPHb6MzIE5Sg7vghKE=;
 b=YgL6wUDiegK5/SDVV4U8nYZ0stjVKOLi/t8tIGFt9+8e/x1rVMBz2ZxlAaChw6D6EdtBFpB64
 qLwKA/hakdIC8NKctit7cV1M4SeERlEscL24imnUv9Rz+US6p+wspjg
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E20:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: c06895a7-f833-4e14-9290-08df35c24ff0
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|35950700016|7416014|376014|48200799018|7093399015|82310400026|261022113327099003|11063799006|56012099006|261009221227099003|261009223027099003|261022075727099003|261028144727099003|10067099003|261026121527099003|261021121427099003|261022105027099003|261026140227099003|261021123027099003|261021135927099003|3023799007|18002099003|16102099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	s2jhFMRxa/e47c5qXsMyr7TCtSpLx/MysbDyjJGDv0QzyXOiVhcY5RFRUNtNGP0gEJmxsGnmpRNcHpgpiOdIpxjFV5ScHxa28wHE20GZClDeQXCYX+ktoQRIgdi0AmzNGAxKrYKcJ9TT29oWVv+hEj82kca/DOjul49HUwIuNbLHyzekIVxMbOku933RcT9NRMOeqRl9N9EWadrKFtlFEi2Le1s2DXbtK6lLieNyN3ByyuVNxFL1mjzE0FO72QR7AIpdaedekTR0AnarpjVswKcIVHwbvc33e3B2go2ntB88zJl6j5TDJqenjOViVxz+2JLPJXVtphiB8gZlM268VOh9XjIA+E4U6URBgvkBbjIvifRZJrK44scfZxbvxUI9/Y+pURdVsdzvrZ6uXHpOdHav+z3VXG8/TKu14QwnEZMrUJ83U2aMBR3dLbs3+yGAhT7tDQAox+LnmOFvAtrdTmHIft4UfGveDKKMir3DUdZsQFkqe20IWTyFv06tyt75sFSIyU66MI8f8oa5g0q9LaN87qGCndMP9EpQ7OKx93cXHlEm03r9YEP6/QMnrQ9ugf6q/GkFesHCzCfTaEpn6iISbrbfztsH0NtS8lgcXjOyv4TG5P381d+U3SuI88XtJnxtqkRhi9EdcQpOQqjwtw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(35950700016)(7416014)(376014)(48200799018)(7093399015)(82310400026)(261022113327099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261022075727099003)(261028144727099003)(10067099003)(261026121527099003)(261021121427099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021135927099003)(3023799007)(18002099003)(16102099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wk7MbTTK2RlnqNemoU04YD2XIB1WH7eGQpIjS/LI1QlOeWzL+nk7LBRBWzHcgA5xD3jHYxBP043TGxrfvOeHfJmjybIhf26UVNAFiy4JM4wWmcsyoTZNEjp8vhipMO9n8GTZ6MEBnhtqOfjlrFtp2yOernzAujyB6voZAIrYrF2oI7z7/t4Ei6AeK4E/ORnliaWk603lJgv+9rnCBJGDO/JpP1KbtEsVf4CdR4sev2D8aLPBNVzDrBP5ucpud01cmnTh6D/6mXC4ZFd3S9YkmCgjV/QFbqERvwkMl5pqQ+uZpMKJd5ZkiE5K4V9NA7SMqBymNPBnFJGvEAm3I11RN50t7aHNAIq6iz33XAO/E1K+Vt0/qbufmuTB8PXfzURAQsaCDHR3BEf7Uuzgu+BtuZFA2S+9SOP2yerCw5H/uXZZQ3LuTku3y6yy5YPaYurM
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:19.0131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06895a7-f833-4e14-9290-08df35c24ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E20.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series refactors the Anacapa BMC devicetree layout to better support
development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a platform
entrypoint.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Changes in v10:
- Fix [Medium] dts: aspeed: anacapa: missing SGPIO line rename for EVT1
- Rename FM_CPU0_PWRGD to host0-ready
- Link to v9: https://lore.kernel.org/r/20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com

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

Colin Huang (6):
      ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: Add EVT2 devicetree inheriting EVT1
      ARM: dts: aspeed: anacapa: Add DVT devicetree inheriting EVT2
      ARM: dts: aspeed: anacapa: Add additional EEPROM node for SCM
      ARM: dts: aspeed: anacapa: Add E1.S FRU EEPROMs
      ARM: dts: aspeed: anacapa: Rename FM_CPU0_PWRGD to host0-ready

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
base-commit: ba3f2c447203166c640e40dc8e9b4b91fc613aa5
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


