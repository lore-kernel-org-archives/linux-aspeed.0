Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8439606A33E
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KyxCcWT5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCyds4y5Bz2yPq;
	Tue, 27 Oct 2026 02:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793029569;
	cv=none; b=kNeYDtIVKgCyvwhJaMWXviGbIxBsYwa/xnpq/rj/UHiSF85y9t7UZPViWHwT0DC5x4DKXNehaaolNfRniP64hRwogNp5ZPAVjcpBhpRhuvyma9iOkMlOAZGz6f9thIXsCgwuDixDs38Vlt5j92u+Y2IuGyO3lIVul8BHc8aup5cNaPgPnY0aRR8edmiaM5dyUlz57roam/pVeodmUYoQUuFSS4h33HQ1yrxr8qprauuU4Zo8PhqKQLPGWWFAmt2jM6e/cq/TfkfLzLIqBSMNRq/fg8ur09ld1FAprXmP+ni5tVGn3qwkvwTOQ9RzCfFcDmB2YNTeijBShrzDc3LNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793029569; c=relaxed/relaxed;
	bh=XPlIwY0S0sn4bBSh2Xil5xdrfx5N4jwTm973vijhd5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnhPHirgt6ZSMw8Bv/zotwMdA7nwrMcImNrIKd7lh2tnHipRv6U4eP925Rx5RbgJJMJvXidyYdI8Yx/0mzl111f6WQGsnvdzM69FzhREGGsUL+VnaIDVhNnSC0uiUwOsGzF7xHoG5nNyFTmti88WEDy5vJsWdIbGvbG0qwbT42FL3h+ijSOEvxgq0v8fOL+fQz43Q6moUmO7tabDuGGO6B5Wu3fwMPrJRT9+NQGA8aNuKEOXC+1KumAsOUw8l4qes3Ujw6oMWLWJE07b8jaNKMeUf1EeW7WxIfP2/b2ZITLI/fVIo+izMHMQ0cfr1vbDaew8/GyDVqTZAFvQC3MmcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KyxCcWT5; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KyxCcWT5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCydp2gtBz2yKp
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 02:46:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793029567; x=1824565567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gr6yVywM7WwdkGlnhrf4VhiYPUPRKPdnfkDFTc5rT8Q=;
  b=KyxCcWT5SjpqeNn5zuwvYS6UGREJdFvMsSWmFRkXQMzUAHiOe+r/S85s
   c+PoWDcrmDTC05o1qbvJK/Tzj0IAT/XHrc0vV6Dm9a2gJOCVOHsXPAmbn
   dBf+/gMZ+Cm+yosOWMl1J/PpC3+l3yre9u5uhu/xrHik7wmB/oYDDqh8f
   YVF4f586wwDzYx3Z7nQpyLFFJCZ4CnQR97L0OY6Xv5ghuFjNqsR9ZM4BI
   doDE4HkZoxeHMbp3oJTyuoyo6F07U9GReWckKEf5DWLCnkz6nXejUH585
   86q+0Icgyuixqzr6br0wnP+oPGBF+vxwun2lW0IMuBzPNWthM5YPA7YKi
   A==;
X-CSE-ConnectionGUID: cN9ypuVBSASjMYqn7l68dA==
X-CSE-MsgGUID: FRlwXAPTSWuSnwsB/46Pfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1730842"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1730842"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 08:46:00 -0700
X-CSE-ConnectionGUID: iG/+IbbbQmmQmtRlk3ZqgA==
X-CSE-MsgGUID: RX6t+cpLRXaHAx7WnzRzmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4369322"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 08:45:57 -0700
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
Subject: [PATCH v4 0/3] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC platforms
Date: Mon, 26 Oct 2026 17:40:27 +0100
Message-ID: <cover.1792749922.git.dawid.glazik@linux.intel.com>
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
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial upstream support for the Intel AVCRP and JNCRP
BMC platforms based on the ASPEED AST2600.

The first patch adds the board compatibles to the ASPEED binding. The
remaining two patches add the board DTS files and register them in the
ASPEED DTB build list.

Changes in v4:
  - Rebased onto aspeed/arm/dt of bmc/linux.git. No other changes.

Dawid Glazik (3):
  dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
  ARM: dts: aspeed: add Intel AVCRP BMC
  ARM: dts: aspeed: add Intel JNCRP BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   2 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 322 ++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 276 +++++++++++++++
 4 files changed, 602 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts


base-commit: 8db593481c8669eddb8b4e21ea44f3fa11d9f030
-- 
2.43.0


