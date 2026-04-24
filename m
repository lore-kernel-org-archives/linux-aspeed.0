Return-Path: <linux-aspeed+bounces-3958-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCB4FF885C
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Apr 2026 06:21:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2fqQ4Ltpz2yng;
	Sat, 25 Apr 2026 16:21:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777058491;
	cv=none; b=O3CWSINLBE8XyPkgng6o2HF911SkR9dLu+7JPW5EqSE41xAS0MC1R6rqHn5dkojyifmNO+Zo5w/Vr61O1l1aNrCQ7Q/lrKtEMwpuEPOWqoTg5C0QCUi63AeUGn3HiB60qIn7ojtkvv4hstm3HNau0AQzPEEVREoLlmKKVyNFu2a6rhJsE1gFV31/ZLsLSbOyxNhiyDuipsOuuqs8UvkwFjSSQL++MXCuDMukD/4lnn08Gim8Na1WXL0SohmCct1l5YqeXtj1KBRtI4lH8Pih6GKCpzMxnvJhL20sJYVM3DC/ywDAm70nk1feAAiU7SniqAp/D5Zt1NXCCdSY++mhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777058491; c=relaxed/relaxed;
	bh=VxBRN8XZjJPL2qXcKamKesTsP2QnEc9zbo5fz7dhiUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+AVanWdSk0pDfre9KZnxgYVReJ+6ZaqXtflx2u1g6disxPVHVU0/CqRp7IHVFqkFqL6hsca542zNjAlYpNvCZ1Z5DUjEhkMVr9fJIhBiUdXZ+FaZYkDEN1VOWCJ+AhqwtNyWwtD+4jpf+cbe4vlg5Ax0lbv0hMxSdj8v7PXqfqIFYhAGwERmPQyPFHW58upJ9okZAJG5j7AtNdwLeJ9fjB/JagdGQMkpuZS6qEj6cdySA3+GQ+hhlhFXRl2YxZW/IDfzN/1QWQPy1sGJOaukJoJPQe35WIrSsAzvDqqlRCZGkrz7Zc+jxzRWjp3D4CZ4YW/KFdNa+ceAM9eYPHimQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNDd/0Tp; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CNDd/0Tp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2N9h4npfz2yFm
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Apr 2026 05:21:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777058489; x=1808594489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vtA3a8VJttJ/RUgugzEUJjXVC/tqXxTv7XGOrZdWfp8=;
  b=CNDd/0TpS9qRPlBrQeMOLRlw+FknpIDscZ0A0lKVgMM+zngXQTTz8pGq
   JP+yx5+Kjqh4BiUj+jza0PMaA7LDqVIs/f8p44EqgiN8+qZEv6O/4a0dI
   n3wJcsDwm2V+dUvUNqPTYAR1j2tEsOn9z8QZD5x7hiuzixH65SydC2f3i
   4x6uphgICzumJRSrEatBz8wLxhnNVhH+HhGWSEzLZq8d5Soed3A+kjYsF
   2CW2m3LB50ocIF6wlaWCHzf/E1dPD//vE2nkKUShP6/sySx47DzRwGRLx
   OcU/IXbiuQGz7ahftck1TNXEGtaAIManMcce2msYfTAqcw/snfXYUjVjD
   A==;
X-CSE-ConnectionGUID: Iw+nJFaSQzKdzBC7enFjSA==
X-CSE-MsgGUID: tsYnqxX6STas1P/HmoUXQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="77208263"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="77208263"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:21:21 -0700
X-CSE-ConnectionGUID: u9JzOGFZSP+X9N/OTCGh6Q==
X-CSE-MsgGUID: pms+UV2zQ9G5cpUtbEqmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="232040479"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:21:18 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com
Subject: [PATCH v4 0/3] ARM: dts: aspeed-g6: add AST2600 I3C nodes and bindings
Date: Fri, 24 Apr 2026 22:20:58 +0200
Message-ID: <cover.1777058942.git.dawid.glazik@linux.intel.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

This series reworks and resubmits AST2600 I3C DTS updates that were
originally posted in 2024, but stalled without further upstream
progress.[1] The series was rebased onto the current tree and merge
conflicts were resolved.

The patches first move I2C controller nodes under the APB simple-bus
for layout consistency, then document aspeed,ast2600-i3c-global in
the syscon binding, and finally add AST2600 I3C controller nodes in
aspeed-g6.dtsi.

Jeremy agreed in a separate email thread that I can continue this
series under my authorship.

Link: https://lore.kernel.org/all/9d8c03d742fa9767f30e23d75ddf0baf4296c88e.1714647917.git.jk@codeconstruct.com.au/

Dawid Glazik (3):
  ARM: dts: aspeed-g6: move i2c controllers directly into apb node
  dt-bindings: mfd: syscon: add aspeed,ast2600-i3c-global compatible
  ARM: dts: aspeed-g6: Add nodes for i3c controllers

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       | 543 ++++++++++--------
 2 files changed, 318 insertions(+), 227 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0


