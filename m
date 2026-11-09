Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF2606A337
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DPyajoaG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNbM72xjvz2xnv;
	Tue, 10 Nov 2026 03:48:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794242899;
	cv=none; b=onEbRpZWsAfgoM4t4SaTD+EX0AeiqqJhz43w6bBppZKWejv2J+DGwz6WHFb1gXUVRDShfnTK4GHLc+1as+vtziHFNDEWzgGShhzsgCz3ueIib02wVZ/sIHJPAJ8ol81+NhRcmaTrEteHhITdcKh1JLDyZsBgiycFd/qGBhi8W/yjFubRRo57KgWAIEmMlKDixulkhmbVurlnDOA15Y+gmRotldmc3b0vcD4/c5ESlp8MgROc8DpXhFRtCvC4+ylnO2TdWk7oLLagWloDfeicfe0XmGKj74YEEZfuZEV68jffekRPISKAwhhpgux+jawZABvqHyXC9IbTG/j+aG1EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794242899; c=relaxed/relaxed;
	bh=hHaS+ftN8yPzDFvIun/EZKVknOKh7/K5G40GhrJsRd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPwJHL5PW6Wv98U92xsosiTEzu49W5pFXy0yLcRbQz8JXiSM8aeTDDGTueIQrO7qpVi2nFvKFF0APkE1hnoBFILYC6HQBU3zWEJgvL3hIBnhbSkyxorE+Cr+C6c3uFQk05c7nZruAxJCw5KgFvgo7miVyHrn5HJk9j67vHsZBQ/Ln89W4ObPg9hMd6/l0Fj6VaxJIXvX4C5fcc+Tbb7Sv3zSS9ML5d3Meo+Uny/IO2cNy56t8IzNOy8DMT68LleJhTcCiZj3i6sv3pAMwRMfE0KmiWUxqf67InApsneGm6X/UAdOOScz/BgSsdBiTgZQshRxOGGGkMf2pkh/IAc+Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DPyajoaG; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DPyajoaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNbM62Mphz2xdX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 03:48:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794242899; x=1825778899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tCG0G3JVI4tRqcPbvjLwK+Qe1NPh0Vqhwwedp+CSJiA=;
  b=DPyajoaGxDatZkY/R1s/TrvylZL6kFZ7+0y+KJrwz+KHiQ1QCYizgTgS
   tppTJ3t9O9Tmw4i5jlapMOi0yBvVB9qCLTwV/rrhNX+ilx7u/kh297Ta6
   Y7BZDvEhvSE8NK7ubMrj+KVnTWRZYJENYwO9GbOCBl6hBmuL37r9fmQ50
   5IfiJRO1eYLbVT3ya6LIsL0JxCJWqTfnOJV+ubkc7tvVb1nEB6tV3s3nJ
   SzA2iyxmLLE40dk9BYC7GX4aHxLjextRtsU6AcQkw68nRI63JAuMLnd+m
   Gv8ghPLXmVpf7R17XDnM0LmcjhzQT89atErGr5Rs2wvzCJlnur24W9+hF
   A==;
X-CSE-ConnectionGUID: VRiPOQVRTGKMkj45jvsa3A==
X-CSE-MsgGUID: QFB2b7RLTPOh3nie2UCkAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3010681"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3010681"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:48:16 -0800
X-CSE-ConnectionGUID: DjDpGG6OShSaS9F04spwkw==
X-CSE-MsgGUID: rO5iguyOTg+BaUmM3h/VgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8481199"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:48:13 -0800
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
	maciej.lawniczak@intel.com
Subject: [PATCH v5 0/3] arm: dts: aspeed: Add Intel AVCRP and JNCRP BMC platforms
Date: Mon,  9 Nov 2026 18:41:47 +0100
Message-ID: <cover.1794242015.git.dawid.glazik@linux.intel.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial upstream support for the Intel AVCRP and JNCRP
BMC platforms. Both are x86 server platforms with Intel host processors,
managed by an ASPEED AST2600 BMC.

The first patch adds the board compatibles to the ASPEED binding. The
remaining two patches add the board DTS files and register them in the
ASPEED DTB build list.

Changes in v5:
  - Removed bootargs from the chosen node
  - Added a description of each platform to the commit messages
  - Capitalised the first word of the DTS subjects
  - Rebased onto the current aspeed/arm/dt

Dawid Glazik (3):
  dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
  ARM: dts: aspeed: Add Intel AVCRP BMC
  ARM: dts: aspeed: Add Intel JNCRP BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   2 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 321 ++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 275 +++++++++++++++
 4 files changed, 600 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts


base-commit: 6767ba3efdda2d27e5eab719db39a7ed98d28b35
-- 
2.43.0


