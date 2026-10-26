Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB860A2606
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8sD8DeH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCyds55ZZz2yQH;
	Tue, 27 Oct 2026 02:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793029569;
	cv=none; b=RpB9qpnBBjXmsImnjygk4Qqf/6GUOTLgbG++QcI+6zg9k6dEUO+MF79JirLKCRAZ7OyNrhgSfl95XPdsH/bL269niYGS/roHDUqHucmSUjP1Ld0Lb1YYYdQvvSsShiLQ1hTfHiSgwhGeyUzRVpEuAdkHolwLiRZSzYwRbWOFIAVfgtyFwBMeLiv7WVXjDXarRzzf7JhxdraIcaVc0fVIsWPU4mAJS/Igjc4hnQkvOIGXRAMkxFqrueTl42tztmKxeP1dx+DhUL/IcN7v13g3DZplsceX8tQ5mzDubIDkV1aD1J5yohKVc6rMFimIUZw+nt9pE6PkqS0zvtFcktaDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793029569; c=relaxed/relaxed;
	bh=h0fx31x6gaF+8787Z73S/7lRDFQWwzYnD/urzHGXw/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nsn9mY2WBwik3982OwrjJmenU6IP6bj+F6dxQJffF8+7yJerqq56phzxk6KFxVE1ngbJCaOO8iFLyWoZIJbhHgloobhfTtCDKQSIi8i61PdEnxlJFuk2nZ3u+uhOX4+x+0wRKJYOg091pIvG2dGOT/JMksn9YiD8MOc/ZaJP5QpW9eXsDoGtM3rYCJ302WevcPAEV2+GoStH2vzHeD1DRB5TXGquMgzSiPU/8rCGbJrtzTJPUzGYQHwlwzJUvur0/eYrPnB5BqsKQqk5bQ2xCbqO6N+B7cq/zVgl7ZLNCYr64mkQMAEtFJmSO0VI2qHHfsYKV8yh4/IA4B7ICQ7QzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8sD8DeH; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8sD8DeH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCydp4vHLz2yPR
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 02:46:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793029567; x=1824565567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yR3pp0eTp1CaPWvhXx9uOIKYRXzm/jqa7VinEVixpYY=;
  b=c8sD8DeHWYXh98C7ubBOpkKiyOhVm4pyyGW21xsKrCnUNwca7pqPq9b9
   28T4RolwWYT6PUDAeRLv/CeGr87xFAMAEmLf6SlCyI3kK5/HZ6KglpI9c
   yqTw2jSh9JcrIF/lwIgUeYIcqZvhy5cwTG/J21AR2hrQBjfck7eP25Wwb
   L6bpbDV80idRz6qc5UDm3U6MvH/jj59fIeHleEY1eokm5AZpci0lXzDsn
   qydRZBpX+XQ6dAJEaiYgnBsNQLjveLkRuKu2dY5JzuqJvM3cH3guSnChr
   ZL6DArV5aTr5mk7JPvmHq6fE2xcVUbC0TzdP+qu4oJfoKq2Ken0Xlivq4
   w==;
X-CSE-ConnectionGUID: JokeBhxGT9SmerI+K91Q/A==
X-CSE-MsgGUID: 5Jx61EX9TrayrorEOrYzyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1730855"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1730855"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 08:46:05 -0700
X-CSE-ConnectionGUID: pr2HmqE+RZCiRm7uo46Bmg==
X-CSE-MsgGUID: nLAGilQ5TdGJTIqLlLOOdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4369360"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 08:46:01 -0700
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
Subject: [PATCH v4 1/3] dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
Date: Mon, 26 Oct 2026 17:40:28 +0100
Message-ID: <36281bba6f86d9e0ce22025487a0538bdcda921e.1792749922.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792749922.git.dawid.glazik@linux.intel.com>
References: <cover.1792749922.git.dawid.glazik@linux.intel.com>
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
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index b7e70868ebd8..61616a9754a4 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -110,6 +110,8 @@ properties:
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


