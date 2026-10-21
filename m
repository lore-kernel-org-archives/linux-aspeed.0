Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7D606A31B
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Oct 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVGDzgd+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8ztZ1qhLz2xPW;
	Thu, 22 Oct 2026 06:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792611110;
	cv=none; b=ZNoNz48PvVK9je/q97chaTbTudHAclL8O+NPcLpCFZEAO5KpPGJ5KBJ5TldxWiNZtWR1gEFRzAyqWDLQRa0bqueGzdVHcIG1B83rztUw/X7GblEtaY9/NboFF708wZ6i16txt/Mbyrlb/8nOektTN6qa6paYrFsW61J8/42Pm9auWt6LQTTX7M+ZP15b020rzvKy+TYiKwzB56vdv8VFdZvfULZQ3eYpVkGpdbpc6xf+g24t6C+NORo40B2R4r9jo4hM8bb8V7dnGomS+73vNUAyiXp+SZr7ORckbVIT5RTZTt+zINgOXyGTnpl43kJJmzSRpzmMQZyMgyb6WnhhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792611110; c=relaxed/relaxed;
	bh=OPQGYY3ssesZJ1NL5DDQJezKH+tWGJ2i+1Yzkdudp0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZYXWENXGfsK/y0FoU6tZGqZu/wrQtYhPblX930GHEIPKyDbX2g5fP2l+Zcp1lSKyDlwpqsTur3qEiAq+HK0d58tn9aCwXz4D2TIimn96GV5azGPGI2YA61oIE6uNs8eGvZgQNVagEBcvRzQ0rmxpoDy25ZYoMvHNXh2EUjZG9BLdYqzX6qLzU0mjL+1WgwzcnlxqERZJNhMhL9RqMgrIxDYjpGdhAH9Xht1qmmJVITu1SX+EC537ciAEU+rh4+z9a9ZouJU2Q5qI9gmi6dOi6PBBCu/jFzRdBg/in5/S5vamtbB1MW5RyBLobzqoJHpCBQhDNB1el4Y+MGSSk3W6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVGDzgd+; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hVGDzgd+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8ztY2gXFz2xSD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 06:31:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792611109; x=1824147109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RE/DoN/sfPcw1uq93Op79DBYUxbTWL4Fw9BZEGZudRo=;
  b=hVGDzgd+z0xPPQAKZvhD1UYYXqPKJftnhpW/5pNeIat4jf5TP1UjZVnN
   W1C9D8G9igniBZnMLp5i16QyTRg1rT/63xYHXlp1Rt5eYC5o8gra6z08s
   IspaVl6AZ0KJRvMG6GumL41YkjzNOltfCLr9W99As9FqVZySb/BmONUHi
   RLCgep8+WmVWtiZPIbyHSvtEiKsb/36uIvuPUzQ/HjVmw7TTwtUzJQDDk
   4LP+4n4RsIrMoRk+49MWDOA51SQQiSdUj9gMohoqlOXwH+JMftMQtTVCl
   ZpPIlKenhmt7bEXlIIjJJDZ808QdZIr813pQyd0lGtuzNCLby62m1r2HP
   A==;
X-CSE-ConnectionGUID: s/fQvniFTJORDrLDDrPZ9Q==
X-CSE-MsgGUID: 7LQqWxV9SLCRXziZCUK6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1382519"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1382519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:31:43 -0700
X-CSE-ConnectionGUID: BesEOpeUThK9bOpqFYKyFw==
X-CSE-MsgGUID: sYgWBGvISyecZovlhkvEuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3170391"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:31:41 -0700
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
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
Date: Wed, 21 Oct 2026 22:26:40 +0200
Message-ID: <21929084fec468382460c52bf26d3b380393f732.1792613583.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792613583.git.dawid.glazik@linux.intel.com>
References: <cover.1792613583.git.dawid.glazik@linux.intel.com>
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
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add compatible strings for the Intel AVCRP and JNCRP BMC boards.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v2:
 - Squash the separate AVCRP and JNCRP commits from v1 into a single
   commit, since the changes are small and closely related
 - Fix compatible string ordering so the new entries stay in
   alphabetical order within the enum
---
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 8ec7a3e74a21..60e8e73da3f5 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -107,6 +107,8 @@ properties:
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


