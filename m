Return-Path: <linux-aspeed+bounces-5118-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAD8CA5FE3
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Oct 2026 00:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxQmg6NHjz2y1W;
	Sat, 03 Oct 2026 10:01:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790955456;
	cv=none; b=ZQG3yMvrOJoodc3HrqVnw7rYwDtDmda/5B0yWf3o94RRbVwa/bhLgbtUKZSNXm4cslCgcczejrAsQgRQP9pBLeeDWGElx/WwIiETXKozPwGYx6ChPSzTYGDtNW7cAYioKzi7yiDlHWBCSlCKcsljW+vERYH7yHtqQZw749Gt+oi5YSzjw/ICssHTHPIqJS0mdB4Omv2CXqxamHKjm0IJKMZHHKiLhDEWJBamZjbipWMhA0v3GKt2+Z8QdvIYxC2b98xBi3sRN9TMDUjBtotTGn77S5nhPJorUBawDnCWTAGsIXOqfcZf4pKia382Bu3zCphfg2k7d2a/nLSP28wPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790955456; c=relaxed/relaxed;
	bh=2qPw+Pg6F2BVS6Rxytm/LCoHFcBV7RBXe2zcL1rJqwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lr5YBMmWDDBKJlG74W8cCmsEiWSsO00iQdmBAWajeWJxkvXAqJuPkx9uGgDY91J8LV1Ku59hSlr90aeN3pa+ia+5vgwp2FVSNxoJXN7JBVV5M9yl9fLZehf3cFOLBCQq6BrFjR5xK88nbLRkCYLSrxFHdGFZyntKF+13n5A3WSWMpPcoEFS0KoEi2cQB6wxx/g7FJEQXUzXY65du4+qnk4J7Qdy5Vo6wiy90IrOHeQPQGIJlo9EMDo/5RInDjcNZsHojGVBlES4tOyuNpwU5HdY4EKcce5RNcv2tGkWy6CcdG1xpOrwPCOsAjF/Yg37cWXmX4yuf1b1HyIInB0m4iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PguWyvZZ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PguWyvZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Sat, 03 Oct 2026 01:37:33 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxCb13fmRz2xLg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 03 Oct 2026 01:37:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790955454; x=1822491454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ID/HkmFMTgXfBvEK9zp6+sIFgeqPAHbQ5YXi9GUqiE0=;
  b=PguWyvZZs4KEdhZ20lkpUXCWAdbzbU1QjKFz/DfNjfGRe+VE6cbEsszl
   U8c3IUnlU8GEZd4fqcbcjWwgSRKCGNZ9Mzm1pUV0zD+zA/ys86jYDdDZc
   Lc0wxR5SGaF2hl5WuhCcyTr8kXWHPkZAyLXJ5zPtjZNExAqwyReYe3sF1
   PanF5T82WYOTKfCMPq3G6l6UOlyFxoOIhYYxw9R3fmTy+rd5qcuQLN1uc
   7crjKEcIwJ6SFqfMAbWaRPfY66EkazuY6boiYl9uNhSmTkiDbcwFN5tpC
   zNhFv1ubfl42YiDVnLCyfA74xcCZhz5YII89A9hVKtCmPLRJDV9qna9rS
   g==;
X-CSE-ConnectionGUID: rw97cdwsS7e5Bj+azNAqdA==
X-CSE-MsgGUID: nvUP8/yKSbOfyV7bkESN3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="117247685"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="117247685"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:36:25 -0700
X-CSE-ConnectionGUID: /exO7IEOQoiF36dXfvuycQ==
X-CSE-MsgGUID: Btu7op7IREy2zYlUhnhmAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279522351"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:36:22 -0700
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
Subject: [PATCH 0/4] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC platforms
Date: Fri,  2 Oct 2026 18:32:41 +0200
Message-ID: <cover.1790344811.git.dawid.glazik@linux.intel.com>
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

This series adds initial upstream support for the Intel AVCRP and JNCRP
BMC platforms based on the ASPEED AST2600.

The first two patches extend the ASPEED board binding to describe the new
Intel platform compatibles. The remaining patches add the corresponding
board DTS files and register them in the ASPEED DTB build list.

Dawid Glazik (4):
  dt-bindings: arm: aspeed: Add Intel AVCRP board
  dt-bindings: arm: aspeed: Add Intel JNCRP board
  ARM: dts: aspeed: add Intel AVCRP BMC
  ARM: dts: aspeed: add Intel JNCRP BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   2 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 321 ++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 257 ++++++++++++++
 4 files changed, 582 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
prerequisite-patch-id: 3af4bd880f896c97741b54ee18845b305a4bd061
prerequisite-patch-id: 23091b539ec7723a865d82da7703bf70c6ed0222
prerequisite-patch-id: ac42a7a373fdc407f6377d0b1c74d728af50ba42
-- 
2.43.0


