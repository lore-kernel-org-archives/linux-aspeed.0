Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9C606EE8A
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hEzNd/eo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKMNY0p5yz2xNC;
	Wed, 04 Nov 2026 21:38:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793788701;
	cv=none; b=VYn8vPLHryyPEKJgqwYbGNp5uaophiXPrDEFq+d/gEs0jpOAh0TJ/ULWvn1uua2iCmfc3gwTqvokO+f8kKD+z/qlOpuzueRmnofbIAvPYsIK+vMNXgCKw1NojeLDafXu8ComkQlQxpxBjSYmCvRj5Vflu3FIEUlc+X/gPwzgyDmiiqOhcE15QUGEMsgl8QF94GuVBsIaRiSIDb2FKfnO2LzSwQtcY1YHWTkPlobuOXb72tMt9VT8cwmcWGKim2XIyBIlHmjGOtkSUqhHqxBeGmpJxTIB8hPQ2UkOnZPVgIDa0A4gGlQYM1Fskqs/XeLlRrbKQDV+2k7gqp7WO1Ac0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793788701; c=relaxed/relaxed;
	bh=Bky+z94GjBhGuHRVzoeUOOEZJsIpZL6CWBksx0pMhcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4GBvhh5SEZn0JDzYNelTDHjyuQmiC1zHflLVCZV8jnyIjTie4+yWe4iQpnHHSiUvgioDoLUQZkJoazStKS/cXcL5mT9gQg5duuYUzMimq1d8vGfhu7SVazi5BVUxq0UkgIgg0FCapy/G4dutYxM/uQVI8qSeyDKwyaBEIEVWnpM3ZjsH+cIpHyHW9aJC7Of6Aq1UD2EYayxl+5N2xIbIikySVQTUlVBntlNzpxSW8F5iRX0Z33HLcJek4a7HBqMeh0oI5IgroDJDL5weRiZwRhCb9Z0ho+1/ohXa99H3x6xjFJH1eJx51aZzuLOHPovc8gKu8+hQyiXmNRGONjgJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hEzNd/eo; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hEzNd/eo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKMNV4VZcz2xK7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 21:38:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793788699; x=1825324699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aOGzTuu2joxxtbxKzL4dHVBDbu15VwOAO4OF8srkPsM=;
  b=hEzNd/eoO6yB+zT1D99cOYCgNblKlo14ULZw6f/DvB2CvRYISBw+XA9n
   f3ZR5tTONnx0uXmAdK1JYSexWgLeBN8Ej86dxf2dngO6Wzh1ffKeLLu72
   KzQpjCKUx5ZwKlOpw452E2fSyzgF5dZyOT3q8bZsND3OQO3k6A/WK0jzV
   c1CsQZ/MVsyUz1IyIlnhwTKQrdp7u6wu+TZtQu2c1yfEIorbheS88vi/Q
   5IWjsqGJ/yQRDoLhRAYagoObFGxYSwGMvLziWzkc6FyVH6ANda5eEdeqx
   hQIpCpMkAe/Au/YCw7jIcs+T6qNJCzYXs12E+VHYpSe71nAGZPunfSpR9
   w==;
X-CSE-ConnectionGUID: xFv/F3ClTAC3zTVz6JoS5Q==
X-CSE-MsgGUID: 0a+YVFltQxKB+fD/dkjnQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2412952"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2412952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:38:13 -0800
X-CSE-ConnectionGUID: +o7S5iu8SKeIiX9Wt7GSfA==
X-CSE-MsgGUID: 8J3dyKC6Q4eTbNPj8Cjt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6569104"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 02:38:12 -0800
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	dawid.glazik@linux.intel.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [RESEND] dt-bindings: mfd: syscon: add aspeed,ast2600-i3c-global compatible
Date: Wed,  4 Nov 2026 12:32:06 +0100
Message-ID: <20261104113206.3243865-1-dawid.glazik@linux.intel.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add aspeed,ast2600-i3c-global to the syscon binding compatible list to
document the AST2600 I3C global register syscon node, which is already
used in aspeed-g6.dtsi.

Without it, dtbs_check reports this node as failing to match any schema
on every AST2600-based board.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Resend of [1]. It was accepted on the list but is not in upstream.

[1] https://lore.kernel.org/all/41d66492e1a1d42f6888459288311094c8b7bc51.1777058942.git.dawid.glazik@linux.intel.com/
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 80ff0e1caca2..dae706ca7642 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -47,6 +47,7 @@ properties:
               - apm,xgene-mcb
               - apm,xgene-rb
               - apm,xgene-scu
+              - aspeed,ast2600-i3c-global
               - atmel,sama5d2-sfrbu
               - atmel,sama5d3-nfc-io
               - atmel,sama5d3-sfrbu

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0


