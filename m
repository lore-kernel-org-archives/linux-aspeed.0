Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8589606EE84
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lnNvd08p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNbMB4rRGz2y89;
	Tue, 10 Nov 2026 03:48:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794242902;
	cv=none; b=lSHdc+iX3e2Ca5D7J5hiEbBDiE0MwXFRigK+H8d34jFETQ78C10NlUGsZR39dyaOjolD15uVwus7KUIolIezcrLCQa1vQy1zGm2NR2povCXKYC+Qs8Q8XkJRZlGvNTbe1k3gbvZXN4QZfYprhgLSIlOCoH7lmf3fHjFlinB8xqYIcuRDcPq22smZ0KARs6ni1FCTs6Fgz+9Pk5QYE4xWKX4UwiUhan1UP0sX4sV+SPGKh6lzkrd386wNxf37BpudQZXTbcqKc+C7ZntAc0eIJcXW7P6ndtuAlh6Kg7HtcuYN2eNiao+ZAnATofoBnlploq8/V5x7erv3VqHguOUvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794242902; c=relaxed/relaxed;
	bh=dtCQxHf6DUwyC+J6cCfISGldHvJA6vcL3U1YvK4OhBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqO+WI4dlQZtHE2J83n64EllX4p5fjq0yFY+B8H6zWEI0/1lOgPSPhzs/YIKX0/pkFpZzEdZTEzt6eSJviPhCwO37AKNEIEqD9jYPVrmv8E/WLAauTn67mmPNkLYJjW97wq8XJBY+sGZA83kXBjJ9tykUJV2l2/hFKv2FBJUSZBJd7DzCVH1CPCYjFYKT05xKPc6p3loRS/aKhMgVaSxOD5msOy8Rs9ffkP5xsZ/Aq+na3AjH608H07+nD/06cEhAUGlbWgHuQAjDpN6w9fh1dN0m9T5qzn1K6gogcZ9vXuVBuqIwxaCdVRsPz80yXxQAYSpX6D1h83DS8uA8qGGMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lnNvd08p; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lnNvd08p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNbM95yjBz2xdX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 03:48:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794242903; x=1825778903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mG2F3kXHoPkrkgh7TuAzTTLOIw3kPA3YYlH38YhZ6zA=;
  b=lnNvd08p5o5oRvCQKTI5BdqYxd/h2PaIypt8ekJDoYgsOA13hcKEax1g
   5P4zKpWM9f8N8LyIFTjRSNHOVU7wuTUtwF0haxBIuRTbFBn0WD+GA/h17
   x5cdb8ZxRlikYEmI8dhUeu5VBGiMwwTBGDfnj4i6QecquLrPNMbec/vKI
   TBo1pQjc8sCZh3Iz+zHUmG5pmtHhbRA0zWIYd0PjaunPb2B2Ch5vP86jN
   Ze6twgc3NFqX74OjFHTg25zhlFWmicnsgSMl7Gw3hJHyGEFxKJ84yc0GD
   oA0utJD3CiEErKB9zrbaXyBHCzheUvNnhqkguzShHLfe2yMHENIv1q1Wf
   w==;
X-CSE-ConnectionGUID: 2IiQGnPuTkuGIf/BHTNuWQ==
X-CSE-MsgGUID: 2do61tzMRGOIgka/I7XEdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3010705"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3010705"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:48:22 -0800
X-CSE-ConnectionGUID: ZL6YsHvVT4ur8NDCENsfVA==
X-CSE-MsgGUID: Fk+TW1seTaGjdtpoXYvheg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8481233"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:48:19 -0800
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
Subject: [PATCH v5 1/3] dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
Date: Mon,  9 Nov 2026 18:41:48 +0100
Message-ID: <0fda64f661da98e069da9e0bdaf947f0f4d5430c.1794242015.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794242015.git.dawid.glazik@linux.intel.com>
References: <cover.1794242015.git.dawid.glazik@linux.intel.com>
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


