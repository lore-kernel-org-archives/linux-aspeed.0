Return-Path: <linux-aspeed+bounces-5170-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424E4CA9ED1
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Oct 2026 16:44:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Nbz2K4Wz3bgK;
	Tue, 13 Oct 2026 03:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791823487;
	cv=none; b=C2hBevBgjHU300QE2d/e6us4mWBMIfU/xD83ZpFQh6Gzy0QfonNSla1DBLrNji8NQUWykMZRROfguyTMN9smm9tpon2rrfPM7Vxm+LYc5nguu3r3nYocvWAgrOn3dQeacFm2Oc/TFKRrQlyybdOGxRVJZjb7lIaa7L0xyDQfdB6HGlF1xECXuQkI5oYyZnpcBDJF0fEn4itjjyGwohsJZDz4dHXbLkKN1WDyCfsBxNQCdm+Wit+3mOY7kF2q40NptO8P/slb/RsSOOUImGvYGiCEymN3mXuNFYIXTIeGxbUB6u1K/mfS1l8uAp+RETMyXxAfObrbZEk6QGlU5Y+8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791823487; c=relaxed/relaxed;
	bh=wX2YvpH7DdQdsajdJe3TNhQ1nhuMxlfbSIyqkAE8Z7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZk0D48CUBTJPdOvyuSsOJMk0Vgq/NfMP+t4TXoODKh98MVYXfuFgHte6VYSwR+/7/lGZSHadfVsF78kSGUVhr7ZkSAWjCvNZnNfGMsY4/Nyy3B0wlZBL74WzPDvM4uMdMmMvOmNIyWGtGcBlzBwIJ/1+k1pGvbATCkotMJqiRL3uGd93TOZvODLuYhkfYP+Sc23v8EJ+kJ05QkbrV81yuUmaS8ndo5u8joDoR29Q6AuWNbgr8Qv7JB2vawoHcrqibMDyocpblc6/vtqOuUdxBkpnOnBxZkuno/OjF5sCMCnARtwet0L/AQE3qP8tM6heAbYo+Tf007y9edWx3td0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJ7Gd1X3; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJ7Gd1X3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 13 Oct 2026 03:44:44 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3Nbw5HB4z3bNr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 03:44:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791823485; x=1823359485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cv0YOCl67A2bSUYRl7ofUt87v7F05LKG20xnzj4vBDQ=;
  b=FJ7Gd1X3HlbM2Zsn15W/hb2klo07D+hPl+AMoRf7Nxsp0Undd4J4NJhs
   IS2u9HZkAM1ay1KMszKkJqWLwX/4q5xwlVm1R5SRSheIVhNzqlD2hzFEv
   035X3qHCD571UvUJ9g1/ERHgKGbPuH9t38a+BP5tuMhnGQoArVGBIsVE8
   0gwusyUM1EVvY8p8klHqKv09q+70BGY1TesQDJMirz2VSr5AaiR+MeY3w
   zwwk+Dx+lR8pmXC1PeQE1F3rewuPRjnBTxmH053h7hxQg/k/9Gv9ACQ1u
   ri4bI1yX1+vxJO78lnEMh1izlPT+HGU+hHrsydbXyda2U8T25YLOwMgL8
   A==;
X-CSE-ConnectionGUID: hrwfzonURlekpyAhHziczw==
X-CSE-MsgGUID: 8HcnaxgqQa+W7yA3xJud3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="410054"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="410054"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:43:35 -0700
X-CSE-ConnectionGUID: xpmaf2bASx++l5FWpus8sw==
X-CSE-MsgGUID: r/lN0FUZQY2Znx5r3hSaZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1004908"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:43:33 -0700
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
Subject: [PATCH v2 0/3] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC platforms
Date: Mon, 12 Oct 2026 19:39:04 +0200
Message-ID: <cover.1791825961.git.dawid.glazik@linux.intel.com>
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

Dawid Glazik (3):
  dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
  ARM: dts: aspeed: add Intel AVCRP BMC
  ARM: dts: aspeed: add Intel JNCRP BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   2 +
 .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 315 ++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 258 ++++++++++++++
 4 files changed, 577 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
prerequisite-patch-id: 3af4bd880f896c97741b54ee18845b305a4bd061
prerequisite-patch-id: 23091b539ec7723a865d82da7703bf70c6ed0222
prerequisite-patch-id: ac42a7a373fdc407f6377d0b1c74d728af50ba42
-- 
2.43.0


