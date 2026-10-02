Return-Path: <linux-aspeed+bounces-5117-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBCFCA5FDD
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Oct 2026 00:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxQmg5LW2z30DH;
	Sat, 03 Oct 2026 10:01:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790955459;
	cv=none; b=GTSiXGd1wFu2++bG0GKQR1szOHSeHJCPksQ0Q6tr/lSa0hHX2D7xeD/Xhg1F5xNFeb0Eh/UqzZ79NXQyeQPSfKLXERMUgwMFvnrpl2kAAaS+fsNxxlkxvN0MnehebmOi3DSIe3fDoJ+Z0dEtL1iOnSYApsCjb1oP2YvLsykOIlf716h58u0IibhZuBHaWqHVA5/I/LregU99pGT0knAtgq3gCBQbMuT8c1pLvaUJip2Sqj2uH3vU+e/0mySbicNWcFokB4CYlsZyHJGr+fDS2Z/B2U2fl37ovRZlzoQiB6C/I96wF8izwXqkIjXaMk7uEkKrSKz9WXRoPZSTu0iYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790955459; c=relaxed/relaxed;
	bh=wnTNlG3qZPtJtxJHsm3ojwHfnkTu660EyXz1lG5tbEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONyi1FtFEzblK/2y5M/cCZrsJuZH3Cln5A6Q/UOQGM8Un/N21e/3hAkk6r6mLcfcFy/UqJcu/Sa4bpfkzwNGB36zOErm52sfQhCxkWDXV9cu01WwTBBmwQXt053HJz9LYhXPQCFCQr+FsP/SDxkJPPLGRq3wBBvb8somjnumM/EfjAgDDWCN+hAB+yHqlmk6hoahOePq/350QO2MtitY+mOou6PZcXP6rFuKSLh0QD4x+DbFIuASQS/A2do+nW80i4cABt35B4ImvlWjfmmafQJ06R8SCSUBZc22jNAygPJoG1JeKi9q0zbuThOUGr2wAAfvmGUnNy1aG2iksIaSRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=foYlgToo; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=foYlgToo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxCb70lf9z2xLg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 03 Oct 2026 01:37:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790955459; x=1822491459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8s7rrg3yONdcHtmcH7OGOW2PwRv8XilceivIWnAV6hI=;
  b=foYlgTooag4KM0bh+gBLRQnwKuMAQygExI8hosbEM8IZbz/2pGXzrlUt
   K356Ad/FIccucw9ljB4bHUFx041hJ5rMplfPNlTJDUi8R17cKxI2EqOpI
   R/cEMw4jDLeVCoMxXTAR5m0ag+23c6UPHD2+9FFA80J86tRN1fk9zEOC/
   mbsXQaR659DuovgBMDMq7YPaLlqI1kc5xKLfuVzeLtO5a064RWZguAwaq
   11LjhCYZIyN8eKoOskDpDQdoA/azudqVu3J8Z+Nwuu4BRps6a3t0IhSn+
   2BIW/tPd7XnungtaWRvLu8FxCk6mNgwMZ9Sspa01zjvr+a6WN3E0ZamMi
   Q==;
X-CSE-ConnectionGUID: t/PSSYtWT2+gngXu9Y1vIg==
X-CSE-MsgGUID: +sgOV6+YQnKqdgBlmtNv4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="117247707"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="117247707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:36:35 -0700
X-CSE-ConnectionGUID: J9GU+psBRte3AN8ClYb7rA==
X-CSE-MsgGUID: PCPhXXncS9OdjY4ZZFdGuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279522387"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:36:32 -0700
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
Subject: [PATCH 1/4] dt-bindings: arm: aspeed: Add Intel AVCRP board
Date: Fri,  2 Oct 2026 18:32:42 +0200
Message-ID: <63367a27ef8c7f27a9d273b65b02b02009d149c6.1790344811.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790344811.git.dawid.glazik@linux.intel.com>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
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

Add a compatible string for Intel AVCRP BMC board.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 8ec7a3e74a21..2c8180e49b2f 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -106,6 +106,7 @@ properties:
               - ibm,rainier-bmc
               - ibm,sbp1-bmc
               - ibm,system1-bmc
+              - intel,avcrp-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
-- 
2.43.0


