Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A47606A32A
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJWKiLhL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVn4S0bC6z2xLq;
	Fri, 20 Nov 2026 05:27:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795112823;
	cv=none; b=gZRmB17AWtbIChqhjx8rpbHvsIgzGqK6QwYV4FegEwZ4/WlPSEpad7HNRAnzmHl21NTEUDINop106mKyVh79lU6gRNNhwPhbsQOmAm2XSkoe5CLdysaOEjlWRnfRZ3WT00z709vFk+rFEatnuP7dtwyxYlZCHk++NEPdHfsv4A7KfnCqrDzAZNc3CoTDe9sVcaA9wS0HHjxA051wp4JR6s9WWO/ihOBFcADmB0E527sCz32+sHxB4jq/Tzqax1I+U8HRdPPgUYraD8+mJx6s89k34oSyEnoXDiJvvYbsET+T0jhRcrgz+P4cqbGzU0lYU4RnxyO275pRPRmUL4ZeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795112823; c=relaxed/relaxed;
	bh=7XKVf74bZ49xNeFhqK3BBEa0pEr/hyXteIE2thclohg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AqDqOllT4eoZJLppMvlflXG/bZQobCSGybrbJRTA1vO6gYvMM/CoA1ALmMXW67B+4Wf6YiQE4fIMaYdGCnfovlU+6+I8zulI/IKEje7eym8RNq0iMfIdXVPocjnO93FoKrfnPLmRAe7lqe2etmjg9E6TKVLMlkwSS588IldvAXn4Vli3YtF+W5iYpY5XAxKm6pTIS4P4C01Gsjz8yR+1TBgfzKOl8WxInE6TVFdvgYcUiDo4yPlEKX63aHNOCdc8xaQDbKDj01wemXq1Y45G2mJP5lMY8w5mIGhbJVprYURzjBrIWVzNLslaOh2JaKJ8HSvR8T6eHcqN3CGSRUqODQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJWKiLhL; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJWKiLhL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVn4P2HGkz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 05:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795112822; x=1826648822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P/lRIKn7mbqvagK6b21mgg/jRRmvu5vkSsvQSOSueYg=;
  b=YJWKiLhLdFcOUS6eKbqGDA2sOXsGMwEkmkzjr71CHOYUh/fdOcO7kOe2
   tYumRmDdTzT49VlahdRcWvkWE1yGqK3H6Z6ZiV5LPbwROcLJGdRYK78JE
   jt+FTSDgLJSZ+dv3KM498cmPvltdpToacDfhrjccYS4ZB0otqEfSBdNoD
   Mrj5RinH8ifumfvqCkcUcFcUobzebgRwwXSUZko8cTzhuB8Du4QyaznrR
   +Y7wiq24KMXnYMG+5DKuTcM0ToxZJWWszz/evH+027b0bnGbYP9DqeOTk
   qvfNkDX3BtcN0MatiUIuIBY3qHR0zUlipkR/aS+k5cFk0uiOQ9DP0Wguj
   g==;
X-CSE-ConnectionGUID: 0Gsy7UCBQAm8thxYPh7ktQ==
X-CSE-MsgGUID: VMD1gQ/VS4i2EguYcRJIZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3861778"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3861778"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 10:26:57 -0800
X-CSE-ConnectionGUID: qZ31+rbWRtC6ZN00VYB0Bg==
X-CSE-MsgGUID: 8nuPVo1CS/uM6HumXT1TQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12479467"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 10:26:54 -0800
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
	Dawid Glazik <dawid.glazik@linux.intel.com>
Subject: [PATCH v6 0/3] ARM: dts: aspeed: Add Intel AVCRP and JNCRP BMC platforms
Date: Thu, 19 Nov 2026 20:19:37 +0100
Message-ID: <cover.1795114204.git.dawid.glazik@linux.intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds initial upstream support for the Intel AVCRP and JNCRP
BMC platforms. Both are x86 server platforms with Intel host processors,
managed by an ASPEED AST2600 BMC.

The first patch adds the board compatibles to the ASPEED binding. The
remaining two patches add the board DTS files and register them in the
ASPEED DTB build list.

Changes in v6:
  - Removed the default pinctrl from &uart3 and &uart4, which are only
    used through &uart_routing, so their pins stay available as GPIOs
  - Added &uart3, &uart4 and &uart_routing to JNCRP
  - Reworded the platform descriptions in the commit messages
  - Rebased onto the current aspeed/arm/dt

v5: https://lore.kernel.org/r/cover.1794242015.git.dawid.glazik@linux.intel.com

Dawid Glazik (3):
  dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
  ARM: dts: aspeed: Add Intel AVCRP BMC
  ARM: dts: aspeed: Add Intel JNCRP BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   2 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 326 ++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 293 ++++++++++++++++
 4 files changed, 623 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts


base-commit: 3251db5e8a31b456ff9b841d73412a22735a7416
-- 
2.43.0


