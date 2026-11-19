Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E7606A33F
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6sOAb6L
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVn4T0MVdz2xGr;
	Fri, 20 Nov 2026 05:27:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795112824;
	cv=none; b=j5mey2vXc35qbkEUbZ4qgeEOUHMH6s4mazMfeFPtDGKhcmsFMi5p5hAIjt3JyOt+whcaR/2tE0HCqPIe4KbAvuVyM7XEBM1BGwlr5+kvKs151qSFlUlr69k6lilwkxVcBdj1Ajceyp7O9tHAJz52jQU7XruC8gSLhdcDHc5yaOtw9DO+RhrbzSKz1Vu/YZ68Ap1f9x1E2+IC6bZ4/9Ym4srE09MJupcHDMNxjdbIAv5R360Y4Oymy2oD8TTSwYcr85ekH0dzVLMGL/SCoHoP/X3Fa+24mQBCfkQq17uvDWIySuwrHlmAP4MOmFcK86NpS2LR6LXBmA7/e2MDpoN1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795112824; c=relaxed/relaxed;
	bh=NIPo6JsHwPi3PMuDnG/ItHqGkr2IVR0/o1OghE79lDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHfUneeghSReyLpn0kmeJuWmSg5ynkd9otluDsIdQacucZLGLsnKlQ2HjMHa5OdiI5b0G9V05wWC2LKc8FTbcgzAErB/XVDlq+DZsyToO/Qez4qIu8XKPgLQGLxYCEBbeSi4Xte3uSuuD4I6BFPwNck3XrGaECCaBEKy6y8vR6zVAqtTanU2kYdcGskKLMvPWJWrOYLkNg9yU3nv7Gf580Yl5+aMxynRpOCxXmlmBJ2EnSsXduaYoh6D0lNgyopnycILO+0SVGuqzsfZj617f13BdfhFJoCRD/xGlI0ZgsbogH9oI1rFEmljoqHYaNu3RwNaMTsC4DBpLM5h83hvQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6sOAb6L; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6sOAb6L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVn4R3MlZz2xLF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 05:27:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795112824; x=1826648824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDL2Dk0Ehk9c53PjJYhK7J4/wUrTV1V6DVnMm+9gFOw=;
  b=G6sOAb6Lnyrmb/Zv1HlWChNT/KglaOgR5EuexkBB25bZXUAQToM95Mte
   1LNQOQbnWa1aKuh+pSx8wHLGl7V5ETE6pbwmq70nVEAraW3Q5uZYAP1lE
   7l7+D+B24TpcT+wwydA2CBZBBp0er0X4I8w8n1yFe6+Gni2HJfdOvZBoC
   q0hxjN2Wl+i4CFhukQYvtjN25DRHt+OI9ra8MTAhhmpafC5tzFqcNfLnU
   gJlFkOzUG13ewMW+w1dEDUwzPLwUlZxrEN1wyITl4qUmO6yRMSl7j12QD
   BO2SLb+54xfxpY2pd5DFe2Vg1DuJiRqav//Vqqcc9dDfxEYx8Pi+Yft4y
   g==;
X-CSE-ConnectionGUID: YIYTKTR0Q4eo4UPc6QbLtg==
X-CSE-MsgGUID: 1rPEdTYdSVGt24grTSXiog==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3861791"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3861791"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 10:27:01 -0800
X-CSE-ConnectionGUID: k8tXrjp6Tp6R82gItRzlZQ==
X-CSE-MsgGUID: e4O2IkxGSp6RXbLfzI07Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12479484"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 10:26:58 -0800
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	maciej.lawniczak@intel.com,
	Dawid Glazik <dawid.glazik@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/3] dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
Date: Thu, 19 Nov 2026 20:19:38 +0100
Message-ID: <76493a8263cfaee7f700d497f6af475a44e2e85e.1795114204.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795114204.git.dawid.glazik@linux.intel.com>
References: <cover.1795114204.git.dawid.glazik@linux.intel.com>
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
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add compatible strings for the Intel AVCRP and JNCRP BMC boards.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v6:
 - Rebased onto the current aspeed/arm/dt, no other changes
v5:
 - Rebased onto the current aspeed/arm/dt, no other changes
v4:
 - Rebased onto aspeed/arm/dt of bmc/linux.git, no other changes
v2:
 - Squash the separate AVCRP and JNCRP commits from v1 into a single
   commit, since the changes are small and closely related
 - Fix compatible string ordering so the new entries stay in
   alphabetical order within the enum
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9ac4a7a8ede0..41a0a4af9e76 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -112,6 +112,8 @@ properties:
               - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
+              - intel,avcrp-bmc
+              - intel,jncrp-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-- 
2.43.0


